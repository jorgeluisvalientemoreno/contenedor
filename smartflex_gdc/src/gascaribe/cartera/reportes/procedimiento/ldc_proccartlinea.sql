CREATE OR REPLACE PROCEDURE LDC_PROCCARTLINEA (
/**************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2013-08-14
    Descripcion : Generamos informacion del producto a cierre

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
    14/04/2014      JJJM            Se cambio el procedimiento que obtiene el saldo pendiente del usuario
                                    Antes  : gc_bodebtmanagement.fnugetdebtbyprod(i.product_id)
                                    Actual : open.pkBCCuencobr.fnuGetOutStandBal(i.product_id);

    26/06/2014      MALS            Se ajusto el procedimiento para darle mayor fluides
    30/10/2014      JJJM            Se cambio ciclo for por el bulk collect esto le dara mejor desempe?o al proceso
    09/04/2015      JJJM            Se adicionao lectura actual y anterior del producto
    15/10/2015      JJJM            Se actualiza llamado al procedimiento ldc_procrecucartconcdiaria para que reciba como parametro
                                    el dia y el nro de cuentas de cobro con saldo
***************************************************************************/

inuProgramacion in ge_process_schedule.process_schedule_id%type) IS

TYPE array_cartdiaria IS RECORD(
                                  nuse servsusc.sesunuse%TYPE
                                 ,tipr servsusc.sesuserv%TYPE
                                 ,cicl servsusc.sesucicl%TYPE
                                 ,cate servsusc.sesucate%TYPE
                                 ,suca servsusc.sesusuca%TYPE
                                 ,depa ge_geogra_location.geograp_location_id%TYPE
                                 ,loca ge_geogra_location.geograp_location_id%TYPE
                                 ,dedi diferido.difesape%TYPE
                                 ,esco estacort.escocodi%TYPE
                                 ,ulsu pr_product.suspen_ord_act_id%TYPE
                                 ,cont servsusc.sesususc%TYPE
                                 ,dire ab_address.address_parsed%TYPE
                                 ,espo pr_product.product_status_id%TYPE
                                 ,esfi servsusc.sesuesfn%TYPE
                                 ,barr ab_address.neighborthood_id%TYPE
                                 ,fein servsusc.sesufein%TYPE
                                 ,clie ge_subscriber.subscriber_id%TYPE
                                 ,idra ldc_usuarios_actualiza_cl.idregistro%TYPE
                                 );

TYPE t_array_cartdiaria IS TABLE OF array_cartdiaria;
TYPE t_actusuarios IS TABLE OF ldc_usuarios_actualiza_cl%ROWTYPE INDEX BY BINARY_INTEGER;
v_array_cartdiaria t_array_cartdiaria;
v_array_usuatuali  t_actusuarios;
TYPE t_array_productos_procesa IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
v_array_productos_procesa t_array_productos_procesa;

-- Ultimo plan de financiacion del producto
CURSOR cuultref(nupprod NUMBER) IS
 SELECT
       DISTINCT d.difecofi codigo_financiacion
      ,trunc(d.difefein)   fecha_ingreso
      ,d.difepldi          plan_financiacion
  FROM open.diferido d
 WHERE difenuse = nupprod
   AND difeprog = 'GCNED'
 ORDER BY trunc(difefein) DESC;

 -- Cursor cuentas de cobro con saldo
CURSOR cucuentassaldo(nuproductocta NUMBER) IS
 SELECT cucocodi
       ,cucofeve
       ,open.ldc_edad_mes(trunc(SYSDATE) - trunc(cucofeve)) nuedadmora
       ,open.ldc_edad_mes(trunc(SYSDATE) - trunc(factfege)) nuedaddeuda
       ,NVL(cucosacu,0) cucosacu
   FROM open.cuencobr, open.factura
  WHERE cucosacu > 0
    AND cucofact = factcodi
    AND cuconuse = nuproductocta
  ORDER BY cucofeve DESC;

    nuLecturaActual             lectelme.leemleto%TYPE DEFAULT 0;
    nuLecturaAnterior           lectelme.leemlean%TYPE DEFAULT 0;
    limit_in                     INTEGER := 100;
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
    nucontaproc                  NUMBER(3);
    l_cursor                     NUMBER;
    l_return                     NUMBER;
    cu_productos                 SYS_REFCURSOR;
    sbcursorproce                VARCHAR2(22000);
    nucantlet                    NUMBER;
    nocontareh                   NUMBER;
    nocontarehcl                 NUMBER;
    nuflagejec                   ld_parameter.numeric_value%TYPE;
    ultejecatlinea               DATE;
    sbobservaprob                VARCHAR2(100);
    nucontaarreglo               NUMBER(10) DEFAULT 0;
    nuidreg                      ldc_usuarios_actualiza_cl.idregistro%TYPE;
    nucontadelete                NUMBER(10) DEFAULT 0;
    nucantidadrefultano          NUMBER(10);
    dtvarfechaini                DATE;
    dtvarfechafin                DATE;
    nuflagprocesa                NUMBER(1);
    nuvalorcast                  NUMBER(13,2);
BEGIN
    nuerror := -1;
    dtvarfechaini := to_date(to_char(add_months(SYSDATE,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
    dtvarfechafin := to_date(to_char(SYSDATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');
    -- Validamos que el proceso no este en ejecucion
    SELECT pm.numeric_value INTO nuflagejec
    FROM ld_parameter pm
    WHERE pm.parameter_id = 'FLAG_EJEC_CARTI';
    IF nuflagejec = 0 THEN
        UPDATE ld_parameter x
        SET x.numeric_value = 1
        WHERE x.parameter_id = 'FLAG_EJEC_CARTI';
        COMMIT;
    ELSE
        RETURN;
    END IF;
    -- Obtenemos datos para realizar ejecucion
    SELECT to_number(to_char(SYSDATE,'YYYY'))
       ,to_number(to_char(SYSDATE,'MM'))
       ,userenv('SESSIONID')
       ,USER INTO nuparano,nuparmes,nutsess,sbparuser
    FROM dual;
    -- Se inicia log del programa
    nuerror := -2;
    ldc_proinsertaestaprog(nuparano,nuparmes,'LDC_PROCCARTLINEA','En ejecucion',nutsess,sbparuser);
    -- Obtenemos el dia.
    nuerror        := -3;
    dtdia          := trunc(SYSDATE);
    ultejecatlinea := SYSDATE;
    -- Se adiciona al log de procesos
    nuerror := -4;
    IF inuProgramacion <> -1 THEN
        ge_boschedule.AddLogToScheduleProcess(inuprogramacion,nuhilos,nulogproceso);
    END IF;
    limit_in := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');
    nucantiregcom := 0;
    -- Se obtiene parametros
    nuerror      := -5;
    IF inuProgramacion <> -1 THEN
        sbParametros := dage_process_schedule.fsbGetParameters_(inuProgramacion);
        ldc_pk_parametros_vistas.nuvadepa := to_number(ut_string.getparametervalue(sbParametros,'GEO_LOCA_FATHER_ID','|','='));
        ldc_pk_parametros_vistas.nuvaloca := to_number(ut_string.getparametervalue(sbParametros,'GEOGRAP_LOCATION_ID','|','='));
        ldc_pk_parametros_vistas.nuvacate := to_number(ut_string.getparametervalue(sbParametros, 'CATEGORY_ID', '|', '='));
        ldc_pk_parametros_vistas.nuvasuca := to_number(ut_string.getparametervalue(sbParametros, 'SUBCATEGORY_ID', '|', '='));
        ldc_pk_parametros_vistas.nuvatipo := to_number(ut_string.getparametervalue(sbParametros, 'PRODUCT_TYPE_ID', '|', '='));
        ldc_pk_parametros_vistas.nuvanuci := to_number(ut_string.getparametervalue(sbParametros, 'CICLCODI', '|', '='));
        sbobservaprob := '[EJECUCION X PROGRAMACION]';
    END IF;
    -- Truncamos la tabla
    nuerror := -6;
    IF inuProgramacion <> -1 AND dald_parameter.fsbgetvalue_chain('BLOQUE_LCD_CARTLINEA') = 'Y' THEN
        sbobservaprob := '[EJECUCION X PROGRAMACION]';
        EXECUTE IMMEDIATE 'truncate table open.ldc_cartdiaria';
        COMMIT;
        DELETE open.ldc_usuarios_actualiza_cl hj;
        sbcursorproce := 'SELECT l.sesunuse
                          ,l.product_type_id
                          ,l.sesucicl
                          ,l.cate_prod
                          ,l.sucacate_prod
                          ,l.nuvdepa
                          ,l.nuvloca
                          ,l.deuda_diferida
                          ,l.estado_corte
                          ,l.ult_act_susp
                          ,l.contrato
                          ,l.direccion
                          ,l.estado_producto
                          ,l.estado_financiero
                          ,l.barrio
                          ,l.fecha_ingreso
                          ,l.cliente
                          ,l.idreg
                     FROM open.ldc_view_cartlinea l';
    ELSE
        sbobservaprob := '[EJECUCION X GEMPS]';
        sbcursorproce := 'SELECT l.sesunuse
                          ,l.product_type_id
                          ,l.sesucicl
                          ,l.cate_prod
                          ,l.sucacate_prod
                          ,l.nuvdepa
                          ,l.nuvloca
                          ,l.deuda_diferida
                          ,l.estado_corte
                          ,l.ult_act_susp
                          ,l.contrato
                          ,l.direccion
                          ,l.estado_producto
                          ,l.estado_financiero
                          ,l.barrio
                          ,l.fecha_ingreso
                          ,l.cliente
                          ,l.idreg
                      FROM open.ldc_view_cartlinea_actualiza l';
    END IF;
    -- Recorremos cursor
    nuerror        := -6;
    l_cursor       := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor,TRIM(sbcursorproce),dbms_sql.native);
    l_return       := dbms_sql.execute(l_cursor);
    nucantlet      := l_return;
    cu_productos   := dbms_sql.to_refcursor(l_cursor);
    nucontaarreglo := 0;
    LOOP
        FETCH cu_productos BULK COLLECT INTO v_array_cartdiaria LIMIT limit_in;
        nuerror      := -7;
        BEGIN
            FOR i IN 1..v_array_cartdiaria.count LOOP
                nuproducto := v_array_cartdiaria(i).nuse;
                nuflagprocesa := 1;
                IF inuProgramacion = -1 THEN
                    nuidreg    := v_array_cartdiaria(i).idra;
                    IF v_array_productos_procesa.exists(nuproducto) THEN
                        nuflagprocesa := 0;
                        nucontaarreglo := nucontaarreglo + 1;
                    ELSE
                        v_array_productos_procesa(nuproducto) := nuidreg;
                        DELETE open.ldc_cartdiaria cadi WHERE cadi.producto = nuproducto;
                        nuflagprocesa := 1;
                    END IF;
                END IF;
                IF nuflagprocesa = 1 THEN
                    v_deuda_no_corriente := v_array_cartdiaria(i).dedi;
                    -- Obtenemos valores de la cta de cobro
                    nuerror        := -8;
                    nuedad                       := -1;
                    nuedaddeud                   := -1;
                    nuctasconsaldo               := 0;
                    v_sesusape                   := 0;
                    v_deuda_corriente_no_vencida := 0;
                    FOR g IN cucuentassaldo(nuproducto) LOOP
                        nuedad         := g.nuedadmora;
                        nuedaddeud     := g.nuedaddeuda;
                        nuctasconsaldo := nuctasconsaldo + 1;
                        v_sesusape     := v_sesusape + g.cucosacu;
                        IF nuedad <= 0 THEN
                            v_deuda_corriente_no_vencida := v_deuda_corriente_no_vencida + g.cucosacu;
                        END IF;
                    END LOOP;
                    -- Dias de asignacion
                    nuerror      := -9;
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
                    -- Recuperamos la ultima financiacion
                    nuerror      := -19;
                    nuultre      := NULL;
                    dtultfina    := NULL;
                    dtpenultfina := NULL;
                    nucontaref   := 0;
                    FOR k IN cuultref(nuproducto) LOOP
                        nucontaref := nucontaref + 1;
                        IF nucontaref = 1 THEN
                            nuultre       := k.plan_financiacion;
                            dtultfina     := k.fecha_ingreso;
                        ELSIF nucontaref = 2 THEN
                            dtpenultfina := k.fecha_ingreso;
                        END IF;
                    END LOOP;
                    -- Cantidad de refinanciaciones en el ultimo a?o
                    nucantidadrefultano := NULL;
                    SELECT COUNT(DISTINCT(difecofi)) INTO nucantidadrefultano
                    FROM open.diferido xd
                    WHERE xd.difenuse = nuproducto
                     AND xd.difefein BETWEEN dtvarfechaini AND dtvarfechafin
                     AND xd.difeprog = 'GCNED';
                    -- Recuperamos la lectura actual y anterior del producto
                    nuLecturaActual   := fnuObtenerLectActual(nuproducto);
                    nuLecturaAnterior := fnuObtenerLectAnterior(nuproducto);
                    -- Consulta valor castigado
                    IF v_array_cartdiaria(i).esfi = 'C' THEN
                        nuvalorcast := gc_bodebtmanagement.fnugetpunidebtbyprod(nuproducto);
                    ELSE
                        nuvalorcast := null;
                    END IF;
                    -- Guardamos el registro
                    nuerror      := -10;
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
                        cantidad_refinan_ultimo_ano,
                        valor_castigado
                        )
                    VALUES
                        (
                        dtdia,
                        v_array_cartdiaria(i).tipr,
                        v_array_cartdiaria(i).depa,
                        v_array_cartdiaria(i).loca,
                        v_array_cartdiaria(i).cicl,
                        v_array_cartdiaria(i).cate,
                        v_array_cartdiaria(i).suca,
                        nuproducto,
                        nvl(v_sesusape,0),
                        nvl(v_deuda_no_corriente, 0),
                        nvl(nuctasconsaldo,0),
                        nvl(nuedad,-1),
                        nvl(nuedaddeud,-1),
                        nuLecturaAnterior, --0, --nulectante se adiciona la lectura anterior optenida
                        nuLecturaActual, -- 0, --nulectact se adiciona la lectura actual optenida
                        v_consumo,
                        nudiasas,
                        v_array_cartdiaria(i).esco,
                        v_array_cartdiaria(i).ulsu,
                        v_array_cartdiaria(i).cont,
                        v_array_cartdiaria(i).dire,
                        v_array_cartdiaria(i).espo,
                        v_array_cartdiaria(i).esfi,
                        v_array_cartdiaria(i).barr,
                        v_array_cartdiaria(i).fein,
                        v_array_cartdiaria(i).clie,
                        nuultre,
                        nucontaref,
                        dtultfina,
                        dtpenultfina,
                        v_deuda_corriente_no_vencida,
                        nucantidadrefultano,
                        nuvalorcast
                        );
                    nucontaarreglo := nucontaarreglo + 1;
                END IF;
                IF inuprogramacion = -1 THEN
                    v_array_usuatuali(nucontaarreglo).idregistro := nuidreg;
                END IF;
                nucantiregcom := nucantiregcom + 1;
            END LOOP;
            COMMIT;
        END;
        EXIT WHEN cu_productos%NOTFOUND;
        nuerror      := -11;
    END LOOP;
    IF inuprogramacion = -1 THEN
        nucontadelete := 0;
        FOR i IN 1..v_array_usuatuali.count LOOP
            DELETE ldc_usuarios_actualiza_cl xg WHERE xg.idregistro = v_array_usuatuali(i).idregistro;
            nucontadelete := nucontadelete + 1;
            IF nucontadelete = 100 THEN
                COMMIT;
                nucontadelete := 0;
            END IF;
        END LOOP;
        v_array_usuatuali.DELETE;
    END IF;
    COMMIT;
    CLOSE cu_productos;
    -- Actualizamos la ultima ejecucion del proceso LDC_PROCCARTLINEA
    UPDATE ld_parameter par
    SET par.value_chain = ultejecatlinea
    WHERE par.parameter_id = 'ULTIMA_EJECUCION_CARTLINEA';
    COMMIT;
    nuerror       := -12;
    sbmensa       := sbobservaprob||' Proceso termino Ok. Se procesaron :'||to_char(nucantiregcom)||' registros. '||to_char(nucantlet);
    error         := 0;
    ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROCCARTLINEA','Ok');
    IF inuProgramacion = -1 THEN
        SELECT COUNT(1) INTO nocontarehcl
          FROM ldc_osf_estaproc ep
         WHERE ep.proceso = 'LDC_PROCCARTLINEA'
           AND trunc(ep.fecha_inicial_ejec) = dtdia
           AND ep.fecha_final_ejec IS NOT NULL;
        IF nocontarehcl = 1 THEN
            UPDATE ldc_cartdiaria SET dia = dtdia;
            COMMIT;
            ldcusuadifcartlicuencob;
        END IF;
    END IF;
    -- Guardamos informacion de la cartera resumida en linea o diaria
    nuerror       := -13;
    BEGIN
        sbproces := 'BEGIN LDC_PROCARTLINRES(to_date('''||to_char(dtdia,'dd/mm/yyyy')||''''||','||'''dd/mm/yyyy'''||'),'||nuparano||','||nuparmes||','||nutsess||','''||sbparuser||'''); END;';
        EXECUTE IMMEDIATE (sbproces);
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
    -- Validamos si debe ejecutarse la por concepto
    nucontaproc := 0;
    SELECT COUNT(1) INTO nucontaproc
    FROM open.ldc_ejecuta_conc_diaria f
    WHERE UPPER(trim(f.proceco)) = 'LDC_PROCRECUCARTCONCDIARIA'
    AND NVL(UPPER(f.ejecuta),'N') IN('S','s');
    -- Validamos si ya se ejecuto en el dia
    SELECT COUNT(1) INTO nocontareh
    FROM ldc_osf_estaproc ep
    WHERE ep.proceso = 'LDC_PROCRECUCARTCONCDIARIA'
    AND trunc(ep.fecha_inicial_ejec) = dtdia
    AND ep.fecha_final_ejec IS NOT NULL;
    IF nucontaproc > 0 AND nocontareh = 0 THEN
        -- Truncamos la tabla de cartera diaria por concepto
        ldc_proinsertaestaprog(nuparano,nuparmes,'LDC_PROCRECUCARTCONCDIARIA','En ejecucion',nutsess,sbparuser);
        EXECUTE IMMEDIATE 'truncate table open.ldc_concepto_diaria';
        COMMIT;
        -- Generamos la informacion de la cartera x concepto para las cuentas con saldos >= 3
        BEGIN
            ldc_procrecucartconcdiaria(dtdia,dald_parameter.fnuGetNumeric_Value('CTAS_CON_SALDO_FREC_GDC',NULL));
            -- Registros procesados
            SELECT count(1) INTO nucantiregcom
            FROM ldc_concepto_diaria cf
            WHERE cf.dia = dtdia;
            sbmensa       := 'Proceso termino Ok. Se procesaron :'||to_char(nucantiregcom)||' registros.';
            ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROCRECUCARTCONCDIARIA','Ok.');
        EXCEPTION
            WHEN OTHERS THEN
                sbmensa := to_char(SQLCODE)||' - '||SQLERRM;
                ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROCRECUCARTCONCDIARIA','Termino con error.');
                ROLLBACK;
        END;
    END IF;
    UPDATE ld_parameter x
    SET x.numeric_value = 0
    WHERE x.parameter_id = 'FLAG_EJEC_CARTI';
    COMMIT;
    UPDATE ld_parameter x
    SET x.value_chain  = 'N'
    WHERE x.parameter_id = 'BLOQUE_LCD_CARTLINEA';
    COMMIT;
    IF inuProgramacion <> -1 THEN
        ge_boschedule.changelogProcessStatus(nuLogProceso,'F');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        UPDATE ld_parameter x
        SET x.numeric_value = 0
        WHERE x.parameter_id = 'FLAG_EJEC_CARTI';
        COMMIT;
        error   := -1;
        sbmensa := sbobservaprob||' '||to_char(error)||' Error en ldc_cartlinea..lineas error '||to_char(nuerror)||' producto ' || nuproducto || ' ' || sqlerrm;
        ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROCCARTLINEA','Termino con error.');
        IF inuProgramacion <> -1 THEN
            ge_boschedule.changelogProcessStatus(nuLogProceso,'F');
        END IF;
END;
/