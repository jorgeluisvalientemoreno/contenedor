CREATE OR REPLACE PROCEDURE ldc_actescureportecart(
/**************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2015-02-11
    Descripcion : Actualiza estado de cuenta de contrato para reporte ldrreestcue

    Parametros Entrada
      nuano Ano
      numes Mes

    Valor de salida
      sbmen  mensaje
      error  codigo del error

   HISTORIA DE MODIFICACIONES
    FECHA           AUTOR           DESCRIPCION
    20/12/2022      jcatuchemvm     OSF-747: Ajuste reporte BACADI, agregando 
                                    calculo para VALOR_CASTIGADO
    11/02/2015      JJJM            Creacion
***************************************************************************/
inuProgramacion in ge_process_schedule.process_schedule_id%type) IS
-- Cursor productos
CURSOR cu_productos(nuccontrato NUMBER) IS
 SELECT
       sesunuse
      ,sesuserv product_type_id
      ,sesucicl
      ,sesucate cate_prod
      ,sesusuca sucacate_prod
      ,l.geo_loca_father_id nuvdepa
      ,l.geograp_location_id nuvloca
      ,(SELECT SUM(difesape) FROM open.diferido WHERE difenuse = s.sesunuse AND difesape > 0) deuda_diferida
      ,sesuesco estado_corte
      ,suspen_ord_act_id ult_act_susp
      ,sesususc contrato
      ,d.address_parsed direccion
      ,p.product_status_id estado_producto
      ,s.sesuesfn estado_financiero
      ,d.neighborthood_id barrio
      ,s.sesufein fecha_ingreso
      ,suscclie cliente
  FROM
       open.servsusc      s
      ,open.suscripc      u
      ,open.pr_product    p
      ,open.ab_address    d
      ,ge_geogra_location l
 WHERE s.sesususc = nuccontrato
   AND s.sesususc = u.susccodi
   AND s.sesunuse = p.product_id
   AND u.susccodi = p.subscription_id
   AND p.address_id = d.address_id
   AND d.geograp_location_id = l.geograp_location_id;

 -- Ultimo plan de financiacion del producto
CURSOR cuultref(nupprod NUMBER) IS
SELECT *
    FROM(
         SELECT
               distinct d.difecofi,rf.financing_plan_id,so.attention_date
           FROM open.diferido d
               ,open.cc_financing_request rf
               ,open.plandife pd
               ,open.mo_packages so
          WHERE difenuse = nupprod
            AND d.difecofi = rf.financing_id
            AND rf.financing_plan_id = pd.pldicodi
            AND difeprog = 'GCNED'
            AND rf.package_id = so.package_id
         ORDER BY so.attention_date DESC);

    nudiasas                     open.gc_coll_mgmt_pro_det.debt_age%TYPE;
    dtdia                        DATE;
    v_deuda_no_corriente         NUMBER(15, 2);
    nuedad                       NUMBER(5);
    nuedaddeud                   NUMBER(5);
    v_consumo                    conssesu.cosscoca%TYPE;
    nuerror                      NUMBER(3) := 0;
    nuproducto                   pr_product.product_id%TYPE;
    v_sesusape                   NUMBER(15, 2);
    nuctasconsaldo               ldc_osf_sesucier.nro_ctas_con_saldo%TYPE;
    nucantiregcom                NUMBER(15) DEFAULT 0;
    sbmensa                      VARCHAR2(4000);
    error                        NUMBER;
    sbParametros                 ge_process_schedule.parameters_%TYPE;
    nuparano                     NUMBER(4);
    nuparmes                     NUMBER(2);
    nutsess                      NUMBER;
    sbparuser                    VARCHAR2(30);
    nuHilos                      NUMBER := 1;
    nuLogProceso                 ge_log_process.log_process_id%TYPE;
    sbproces                     VARCHAR2(1000);
    nuultre                      cc_financing_request.financing_plan_id%TYPE;
    dtultfina                    mo_packages.attention_date%TYPE;
    dtpenultfina                 mo_packages.attention_date%TYPE;
    nucontaref                   NUMBER(5) DEFAULT 0;
    v_deuda_corriente_no_vencida NUMBER(15,3);
    nupcontrato                  servsusc.sesususc%TYPE;
    nuvalorcast                  NUMBER(13,2);
BEGIN
    nuerror := -1;
    SELECT TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))
       ,TO_NUMBER(TO_CHAR(SYSDATE,'MM'))
       ,USERENV('SESSIONID')
       ,USER INTO nuparano,nuparmes,nutsess,sbparuser
    FROM dual;
    -- Se inicia log del programa
    nuerror := -2;
    ldc_proinsertaestaprog(nuparano,nuparmes,'LDC_ACTESCUREPORTECART','En ejecución',nutsess,sbparuser);
    -- Se adiciona al log de procesos
    nuerror := -3;
    ge_boschedule.AddLogToScheduleProcess(inuProgramacion,nuHilos,nuLogProceso);
    -- Se obtiene parametros
    nuerror      := -4;
    sbParametros := dage_process_schedule.fsbGetParameters_(inuProgramacion);
    dtdia        := ut_string.getparametervalue(sbParametros,'SESUFEIN','|','=');
    dtdia        := trunc(dtdia);
    nupcontrato  := to_number(ut_string.getparametervalue(sbParametros,'SESUSUSC','|','='));
    -- Borramos registro de la tabla ldc_cartdiaria para el contrato a actualizar
    nuerror := -5;
    DELETE open.ldc_cartdiaria j WHERE j.dia = dtdia AND j.contrato = nupcontrato;
    COMMIT;
    -- Borramos registro de la tabla ldc_cartdiaria para el contrato a actualizar
    nuerror := -6;
    DELETE open.ldc_concepto_diaria h WHERE h.dia = dtdia AND h.contrato = nupcontrato ;
    COMMIT;
    -- Recorremos cursor
    nuerror      := -7;
    nucantiregcom := 0;
    FOR i IN cu_productos(nupcontrato) LOOP
        nuproducto := i.sesunuse;
        v_deuda_no_corriente := i.deuda_diferida;
        -- Obtenemos valores de la cta de cobro
        nuerror      := -8;
        BEGIN
            SELECT ldc_edad_mes(trunc(SYSDATE) - trunc(MIN(cucofeve))),
                  ldc_edad_mes(trunc(SYSDATE) - trunc(MIN(factfege))),
              SUM(cucosacu)           ,
            COUNT(cucocodi)
             INTO nuedad,
                  nuedaddeud,
                  v_sesusape,
                  nuctasconsaldo
             FROM cuencobr, factura
            WHERE cucosacu > 0
              AND cucofact = factcodi
              AND cuconuse = nuproducto
            GROUP BY cuconuse;
        EXCEPTION
            WHEN no_data_found THEN
                nuedad         := -1;
                nuedaddeud     := -1;
                v_sesusape     := 0;
                nuctasconsaldo := 0;
        END;
        -- Deuda corriente no vencida
        nuerror := -9;
        v_deuda_corriente_no_vencida := 0;
        v_deuda_corriente_no_vencida := v_sesusape-gc_bodebtmanagement.fnugetexpirdebtbyprod(nuproducto);
        -- Dias de asignacion
        nuerror      := -10;
        BEGIN
            SELECT diasasig INTO nudiasas
             FROM (SELECT p.debt_age diasasig
                     FROM open.gc_coll_mgmt_pro_det p
                    WHERE p.product_id = nuproducto
                    ORDER BY p.order_id DESC)
            WHERE ROWNUM <= 1;
        EXCEPTION
            WHEN no_data_found THEN
                nudiasas := NULL;
        END;
        -- Recuperamos la ultima financiaciòn
        nuerror      := -11;
        nuultre      := NULL;
        dtultfina    := NULL;
        dtpenultfina := NULL;
        nucontaref   := 0;
        FOR k IN cuultref(nuproducto) LOOP
            nucontaref := nucontaref + 1;
            IF nucontaref = 1 THEN
                nuultre       := k.financing_plan_id;
                dtultfina     := k.attention_date;
            ELSE
                dtpenultfina := k.attention_date;
            END IF;
        END LOOP;
        -- Consulta valor castigado
        IF i.estado_financiero = 'C' THEN
            nuvalorcast := gc_bodebtmanagement.fnugetpunidebtbyprod(nuproducto);
        ELSE
            nuvalorcast := null;
        END IF; 
        -- Guardamos el registro
        nuerror      := -12;
        INSERT INTO ldc_cartdiaria
                                  (
                                   dia,
                                   tipo_producto,
                                   departamento,
                                   localidad,
                                   ciclo,
                                   categoria,
                                   subcategoria,
                                   producto,
                                   sesusape,
                                   deuda_diferida_no_corriente,
                                   nro_ctas_con_saldo,
                                   edad_mora,
                                   edad_deuda,
                                   lectura_anterior,
                                   lectura_actual,
                                   consumo_actual,
                                   nro_dias_asig,
                                   estado_corte,
                                   ult_act_susp,
                                   contrato,
                                   direccion,
                                   estado_producto,
                                   estado_financiero,
                                   barrio,
                                   fecha_ingreso,
                                   cliente,
                                   plaultref,
                                   histref,
                                   fecultref,
                                   fecpenulref,
                                   deuda_no_venc,
                                   valor_castigado
                                   )
                                 VALUES
                                  (
                                   dtdia,
                                   i.product_type_id,
                                   i.nuvdepa,
                                   i.nuvloca,
                                   i.sesucicl,
                                   i.cate_prod,
                                   i.sucacate_prod,
                                   nuproducto,
                                   nvl(v_sesusape,0),
                                   nvl(v_deuda_no_corriente, 0),
                                   nvl(nuctasconsaldo,0),
                                   nvl(nuedad,-1),
                                   nvl(nuedaddeud,-1),
                                   0, --nulectante
                                   0, --nulectact
                                   v_consumo,
                                   nudiasas,
                                   i.estado_corte,
                                   i.ult_act_susp,
                                   i.contrato,
                                   i.direccion,
                                   i.estado_producto,
                                   i.estado_financiero,
                                   i.barrio,
                                   i.fecha_ingreso,
                                   i.cliente,
                                   nuultre,
                                   nucontaref,
                                   dtultfina,
                                   dtpenultfina,
                                   v_deuda_corriente_no_vencida,
                                   nuvalorcast);
        nucantiregcom := nucantiregcom + 1;
    END LOOP;
    COMMIT;
    nuerror       := -13;
    sbmensa       := 'Proceso terminó Ok. Se procesarón :'||to_char(nucantiregcom)||' registros. Contrato : '||to_char(nupcontrato);
    error         := 0;
    ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_ACTESCUREPORTECART','Ok');
    -- Guardamos informacion de la cartera resumida en linea o diaria
    nuerror       := -14;
    BEGIN
        sbproces := 'BEGIN LDC_PROCARTLINRES(to_date('''||to_char(dtdia,'dd/mm/yyyy')||''''||','||'''dd/mm/yyyy'''||'),'||nuparano||','||nuparmes||','||nutsess||','''||sbparuser||'''); END;';
        EXECUTE IMMEDIATE (sbproces);
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
    -- Generamos la información de la cartera x concepto para las cuentas con saldos >= 3
    ldc_proinsertaestaprog(nuparano,nuparmes,'LDC_PROCRECUCARTCONCDIARIA','En ejecución',nutsess,sbparuser);
    BEGIN
        FOR i IN (SELECT q.contrato,q.producto,q.dia FROM open.ldc_cartdiaria q WHERE q.dia = dtdia AND q.contrato = nupcontrato) LOOP
            ldc_procrecucartconcdiaria_pro(i.contrato,i.producto,i.dia);
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            sbmensa := to_char(SQLCODE)||' - '||SQLERRM;
            ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROCRECUCARTCONCDIARIA','Terminó con error.');
            ROLLBACK;
    END;
  -- Registros procesados
    SELECT count(1) INTO nucantiregcom
    FROM ldc_concepto_diaria cf
    WHERE cf.dia = dtdia
     AND contrato = nupcontrato;
    sbmensa       := 'Proceso terminó Ok. Se procesarón :'||to_char(nucantiregcom)||' registros.';
    ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROCRECUCARTCONCDIARIA','Ok.');
    ge_boschedule.changelogProcessStatus(nuLogProceso,'F');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        error   := -1;
        sbmensa := to_char(error)||' Error en ldc_cartlinea..lineas error '||to_char(nuerror)||' producto ' || nuproducto || ' ' || sqlerrm;
        ldc_proactualizaestaprog(nutsess,sbmensa,'ldc_actescureportecart','Terminó con error.');
        ge_boschedule.changelogProcessStatus(nuLogProceso,'F');
END;
/