create or replace PACKAGE ADM_PERSON.LDC_PK_CARTERA_DIARIA IS
/**************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2017-07-04
    Descripcion : Procesos generaci?n cartera por producto diaria

    Parametros Entrada
      nuano Ano
      numes Mes

    Valor de salida
      sbmen  mensaje
      error  codigo del error

   HISTORIA DE MODIFICACIONES
    FECHA           AUTOR           DESCRIPCION
    20/12/2022      jcatuchemvm     OSF-747: Ajuste procedimientos
                                        [ldc_proccartlinea_h1]
                                        [ldc_proccartlinea_h2]
                                        [ldc_proccartlinea_h3]
                                        [ldc_proccartlinea_h4]
                                        [ldc_proccartlinea_h5]
                                        [ldc_proccartlinea_h6]
                                        [ldc_proccartlinea_h7]
                                        [ldc_proccartlinea_h8]
                                        [ldc_proccartlinea_h9]
                                        [ldc_proccartlinea_h10]
                                        [ldc_proccartlinea_h11]
                                        [ldc_proccartlinea_h12]
    16/07/2024     felipe.valencia      OSF-2963: Ajuste procedimientos para cambiar truncate
                                        [ldc_proccartlinea_h1]
                                        [ldc_proccartlinea_h2]
                                        [ldc_proccartlinea_h3]
                                        [ldc_proccartlinea_h4]
                                        [ldc_proccartlinea_h5]
                                        [ldc_proccartlinea_h6]
                                        [ldc_proccartlinea_h7]
                                        [ldc_proccartlinea_h8]
                                        [ldc_proccartlinea_h9]
                                        [ldc_proccartlinea_h10]
                                        [ldc_proccartlinea_h11]
                                        [ldc_proccartlinea_h12]
***************************************************************************/
PROCEDURE ldc_proccartlinea_automat;
PROCEDURE ldc_proccartlinea_h1;
PROCEDURE ldc_proccartlinea_h2;
PROCEDURE ldc_proccartlinea_h3;
PROCEDURE ldc_proccartlinea_h4;
PROCEDURE ldc_proccartlinea_h5;
PROCEDURE ldc_proccartlinea_h6;
PROCEDURE ldc_proccartlinea_h7;
PROCEDURE ldc_proccartlinea_h8;
PROCEDURE ldc_proccartlinea_h9;
PROCEDURE ldc_proccartlinea_h10;
PROCEDURE ldc_proccartlinea_h11;
PROCEDURE ldc_proccartlinea_h12;
PROCEDURE ldc_proc_cart_diari_con_x_ctas(dtpadia DATE,nupanroctas NUMBER,nuerror OUT NUMBER,sberror OUT VARCHAR2);
PROCEDURE ldc_proccargadatoscartdiaria;

CURSOR cudatossesion IS
 SELECT ep.ano,ep.mes,ep.sesion,ep.usuario_conectado,ds.dia
   FROM ldc_esprocardiaria ds,ldc_osf_estaproc ep
  WHERE ds.estado    = 'N'
    AND ep.proceso   = 'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_AUTOMAT'
    AND ep.fecha_final_ejec IS NULL
    AND ds.nusession = ep.sesion
     and ep.sesion = (select max(e.sesion) from open.ldc_osf_estaproc e where e.proceso   = 'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_AUTOMAT'
                       AND e.fecha_final_ejec IS NULL )
    ;--AND rownum       = 1;
dtvardia      DATE;
nupkvaano     NUMBER(4);
nupkvames     NUMBER(2);
nutvasess     NUMBER;
sbvaruser     VARCHAR2(30);
END;
/
create or replace PACKAGE BODY ADM_PERSON.LDC_PK_CARTERA_DIARIA IS
PROCEDURE ldc_proccartlinea_automat AS
/**************************************************************************
Autor       : John Jairo Jimenez Marimon
Fecha       : 2017-07-05
Descripcion : Se cambian par?metros para que se ejecuten los 12 hilos

Parametros Entrada
  nuano A?o
  numes Mes

Valor de salida
  sbmen  mensaje
  error  codigo del error

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
***************************************************************************/
nuparano         NUMBER(4);
nuparmes         NUMBER(2);
nutsess          NUMBER;
sbparuser        VARCHAR2(30);
dtdia            DATE;
sbmensa          VARCHAR2(4000);
nucontaejecucion NUMBER(4);
nuborrarreg      NUMBER(6);
dtfechainibdpa   DATE;
dtfechainibd     DATE;
numaxusuaactu    ldc_usuarios_actualiza_cl.idregistro%TYPE;
nussesionactiva  ldc_esprocardiaria.nusession%TYPE;
sbinsactu        ld_parameter.value_chain%TYPE;
BEGIN
  nucontaejecucion := pkg_bcld_parameter.fnuobtienevalornumerico('CARGA_LINEA_AUTOMAT');
  IF nucontaejecucion <> 0 THEN
   dtfechainibdpa     := to_date(TRIM(pkg_bcld_parameter.fsbobtienevalorcadena('FECHA_ULTIMO_INICIO_BD')),'dd/mm/yyyy hh24:mi:ss');
   SELECT vi.startup_time INTO dtfechainibd
     FROM v$instance vi;
   IF dtfechainibd <> dtfechainibdpa THEN
      dald_parameter.updNumeric_Value('CARGA_VALORES_CARTDIARIA',0);
      dald_parameter.updValue_Chain('FECHA_ULTIMO_INICIO_BD',to_char(dtfechainibd,'dd/mm/yyyy hh24:mi:ss'));
      dald_parameter.updValue_Chain('ACT_O_INS_CARTERA_LINEA','I');
      SELECT xd.nusession INTO nussesionactiva
        FROM ldc_esprocardiaria xd
       WHERE xd.estado = 'N'
         AND rownum = 1;
      sbmensa := 'Finalizado por levantamiento de base de datos.';
      ldc_proactualizaestaprog(nussesionactiva,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_AUTOMAT','Ok.');
      UPDATE ldc_esprocardiaria fg
           SET fg.estado = 'S'
         WHERE fg.nusession = nussesionactiva
           AND fg.estado = 'N';
   ELSE
    RETURN;
   END IF;
  ELSE
   dald_parameter.updNumeric_Value('CARGA_LINEA_AUTOMAT',1);
  END IF;
 -- Obtenemos datos para realizar ejecucion
 SELECT to_number(to_char(SYSDATE,'YYYY'))
       ,to_number(to_char(SYSDATE,'MM'))
       ,userenv('SESSIONID')
       ,USER
   INTO nuparano
       ,nuparmes
       ,nutsess
       ,sbparuser
   FROM dual;
 -- Se inicia log del programa
 ldc_proinsertaestaprog(nuparano,nuparmes,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_AUTOMAT','En ejecucion',nutsess,sbparuser);
 nuborrarreg := 0;
 dtdia := SYSDATE;
 SELECT COUNT(1) INTO nuborrarreg
   FROM ldc_osf_estaproc v
  WHERE v.proceso = 'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_AUTOMAT'
    AND trunc(v.fecha_inicial_ejec) = trunc(dtdia);
     IF nuborrarreg = 1 THEN
      dald_parameter.updValue_Chain('ACT_O_INS_CARTERA_LINEA','I');
      DELETE ldc_esprocardiaria WHERE estado = 'S';
     END IF;
 sbinsactu      := pkg_bcld_parameter.fsbobtienevalorcadena('ACT_O_INS_CARTERA_LINEA');
 numaxusuaactu  := NULL;
 IF sbinsactu = 'I' THEN
  BEGIN
   SELECT nvl(MAX(cv.idregistro),0) INTO numaxusuaactu
     FROM ldc_usuarios_actualiza_cl cv;
  EXCEPTION
   WHEN no_data_found THEN
    numaxusuaactu := 0;
  END;
 END IF;
 INSERT INTO ldc_esprocardiaria VALUES(nutsess,'N',dtdia,numaxusuaactu,0,0,0,0,0,0,0,0,0,0,0,0);
 dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_1',0);
 dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_2',0);
 dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_3',0);
 dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_4',0);
 dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_5',0);
 dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_6',0);
 dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_7',0);
 dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_8',0);
 dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_9',0);
 dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_10',0);
 dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_11',0);
 dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_12',0);
 COMMIT;
EXCEPTION
 WHEN OTHERS THEN
 ROLLBACK;
  sbmensa := -1||' Error en ldc_cartlinea..lineas error '|| ' : ' || sqlerrm;
  ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_AUTOMAT','Termino con error.');
END ldc_proccartlinea_automat;
PROCEDURE ldc_proccartlinea_h1 IS
/********************************************************************************************
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
    20/12/2022      jcatuchemvm     OSF-747: Ajuste reporte BACADI, agregando calculo para VALOR_CASTIGADO
    14/08/2013      John Jairo Jim  Creacion
***********************************************************************************************/
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
                                     ,idre ldc_usuarios_actualiza_cl.idregistro%TYPE
                                     );

    TYPE t_array_cartdiaria IS TABLE OF array_cartdiaria;
    TYPE t_actusuarios IS TABLE OF ldc_usuarios_actualiza_cl%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE t_array_productos_procesa IS TABLE OF pr_product.product_id%TYPE INDEX BY VARCHAR2(15);
    v_array_cartdiaria t_array_cartdiaria;
    v_array_usuatuali  t_actusuarios;
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
    /* ht.esantiago solucion caso: 200-2399
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
      ORDER BY cucofeve DESC;*/

    CURSOR cucuentassaldo(nuproductocta NUMBER) IS
     SELECT cucocodi
           ,cucofeve
           ,trunc(SYSDATE) - trunc(cucofeve) nuedadmora_exacta
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
    sbmensa                      VARCHAR2(4000);
    error                        NUMBER;
    nuultre                      cc_financing_request.financing_plan_id%TYPE;
    dtultfina                    mo_packages.attention_date%TYPE;
    dtpenultfina                 mo_packages.attention_date%TYPE;
    nucontaref                   NUMBER(5) DEFAULT 0;
    v_deuda_corriente_no_vencida NUMBER(15,3);
    l_cursor                     NUMBER;
    cu_productos                 SYS_REFCURSOR;
    sbcursorproce                VARCHAR2(22000);
    sbobservaprob                VARCHAR2(100);
    nucontaarreglo               NUMBER(10) DEFAULT 0;
    nuidreg                      ldc_usuarios_actualiza_cl.idregistro%TYPE;
    nucontadelete                NUMBER(10) DEFAULT 0;
    nucantidadrefultano          NUMBER(10);
    dtvarfechaini                DATE;
    dtvarfechafin                DATE;
    nuvalor_ejecuta              ld_parameter.numeric_value%TYPE;
    sbinsactu                    VARCHAR2(2);
    l_return                     NUMBER;
    nucantle                     NUMBER;
    sbproductoarreglo            VARCHAR2(15);
    nuedad_exacta                NUMBER(5);
    nuvalorcast                  NUMBER(13,2);
BEGIN
    -- Validamos que el proceso no este en ejecucion
    nuerror := -1;
    nuvalor_ejecuta := pkg_bcld_parameter.fnuobtienevalornumerico('EJECUTA_CARTLINEA_1');
    IF nuvalor_ejecuta <> 0 THEN
        RETURN;
    ELSE
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_1',1);
        COMMIT;
    END IF;
    nuerror := -2;
    FOR ids IN cudatossesion LOOP
        nupkvaano := ids.ano;
        nupkvames := ids.mes;
        nutvasess := ids.sesion;
        sbvaruser := ids.usuario_conectado;
        dtvardia  := ids.dia;
    END LOOP;
    nuerror := -3;
    ldc_proinsertaestaprog(nupkvaano,nupkvames,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H1','En ejecucion',nutvasess,sbvaruser);
    nuerror := -4;
    dtvarfechaini  := to_date(to_char(add_months(SYSDATE,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
    dtvarfechafin  := to_date(to_char(SYSDATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');
    nuerror        := -5;
    dtdia          := trunc(dtvardia);
    sbinsactu      := pkg_bcld_parameter.fsbobtienevalorcadena('ACT_O_INS_CARTERA_LINEA');
    IF TRIM(sbinsactu) IN('I','i') THEN
        sbobservaprob := 'NULL';
        sbcursorproce := 'SELECT
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
                         ,-1 AS idreg
                     FROM
                          open.servsusc      s
                         ,open.suscripc      u
                         ,open.pr_product    p
                         ,open.ab_address    d
                         ,ge_geogra_location l
                    WHERE s.sesususc = u.susccodi
                      AND s.sesunuse = p.product_id
                      AND u.susccodi = p.subscription_id
                      AND p.address_id = d.address_id
                      AND d.geograp_location_id = l.geograp_location_id
                      AND mod(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 1';
    ELSE
        sbobservaprob := '[ACTUALIZA]';
        sbcursorproce := ' SELECT
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
                          ,c.idregistro
                     FROM
                           open.servsusc      s
                          ,open.suscripc      u
                          ,open.pr_product    p
                          ,open.ab_address    d
                          ,ge_geogra_location l
                          ,ldc_usuarios_actualiza_cl c
                     WHERE s.sesususc                                                            = u.susccodi
                       AND s.sesunuse                                                            = p.product_id
                       AND u.susccodi                                                            = p.subscription_id
                       AND p.address_id                                                          = d.address_id
                       AND d.geograp_location_id                                                 = l.geograp_location_id
                       AND s.sesunuse                                                            = c.producto
                       AND p.product_id                                                          = c.producto
                       AND MOD(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 1';
    END IF;
    -- Se adiciona al log de procesos
    nuerror := -6;
    limit_in := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CANTIDAD_REG_GUARDAR');
    -- Borramos datos de la tabla temporal
    pkg_truncate_tablas_open.prcldc_cartdiara_tmp;

    -- Recorremos cursor
    nuerror        := -7;
    l_cursor       := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor,TRIM(sbcursorproce),dbms_sql.native);
    l_return       := dbms_sql.execute(l_cursor);
    nucantle       := l_return;
    cu_productos   := dbms_sql.to_refcursor(l_cursor);
    nucontaarreglo := 0;
    LOOP
        FETCH cu_productos BULK COLLECT INTO v_array_cartdiaria LIMIT limit_in;
        nuerror      := -8;
        BEGIN
            FOR i IN 1..v_array_cartdiaria.count LOOP
                nuproducto           := v_array_cartdiaria(i).nuse;
                sbproductoarreglo    := to_char(nuproducto);
                sbproductoarreglo    := TRIM(sbproductoarreglo);
                nuidreg              := v_array_cartdiaria(i).idre;
                IF v_array_productos_procesa.exists(sbproductoarreglo) THEN
                    nucontaarreglo := nucontaarreglo + 1;
                ELSE
                    v_array_productos_procesa(sbproductoarreglo) := nuidreg;
                    -- Cartera diferida
                    v_deuda_no_corriente := v_array_cartdiaria(i).dedi;
                    -- Obtenemos valores de la cta de cobro
                    nuerror                      := -9;
                    nuedad                       := -1;
                    nuedaddeud                   := -1;
                    nuctasconsaldo               := 0;
                    v_sesusape                   := 0;
                    v_deuda_corriente_no_vencida := 0;
                    nuedad_exacta := 0;
                    FOR g IN cucuentassaldo(nuproducto) LOOP
                        nuedad_exacta  := g.nuedadmora_exacta; -- ht.esantiago solucion caso: 200-2399
                        nuedad         := g.nuedadmora;
                        nuedaddeud     := g.nuedaddeuda;
                        nuctasconsaldo := nuctasconsaldo + 1;
                        v_sesusape     := v_sesusape + g.cucosacu;
                        IF nuedad <= 0 THEN
                            v_deuda_corriente_no_vencida := v_deuda_corriente_no_vencida + g.cucosacu;
                        END IF;
                    END LOOP;
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
                    -- Recuperamos la ultima financiacion
                    nuerror      := -11;
                    nuultre      := NULL;
                    dtultfina    := NULL;
                    dtpenultfina := NULL;
                    nucontaref   := 0;
                    nuerror      := -12;
                    FOR k IN cuultref(nuproducto) LOOP
                        nucontaref := nucontaref + 1;
                        IF nucontaref = 1 THEN
                            nuultre       := k.plan_financiacion;
                            dtultfina     := k.fecha_ingreso;
                        ELSIF nucontaref = 2 THEN
                            dtpenultfina := k.fecha_ingreso;
                        END IF;
                    END LOOP;
                    nuerror      := -13;
                    -- Cantidad de refinanciaciones en el ultimo a?o
                    nucantidadrefultano := NULL;
                    SELECT COUNT(DISTINCT(difecofi)) INTO nucantidadrefultano
                    FROM open.diferido xd
                    WHERE xd.difenuse = nuproducto
                    AND xd.difefein BETWEEN dtvarfechaini AND dtvarfechafin
                    AND xd.difeprog = 'GCNED';
                    -- Recuperamos la lectura actual y anterior del producto
                    nuerror      := -14;
                    nuLecturaActual   := fnuObtenerLectActual(nuproducto);
                    nuLecturaAnterior := fnuObtenerLectAnterior(nuproducto);
                    -- Consulta valor castigado
                    IF v_array_cartdiaria(i).esfi = 'C' THEN
                        nuvalorcast := gc_bodebtmanagement.fnugetpunidebtbyprod(nuproducto);
                    ELSE
                        nuvalorcast := null;
                    END IF;
                    -- Guardamos el registro
                    nuerror      := -15;
                    INSERT INTO ldc_cartdiaria_tmp
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
                        EDAD_MORA_EXACTA,
                        VALOR_CASTIGADO
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
                        nuedad_exacta,
                        nuvalorcast
                    );
                    nucontaarreglo := nucontaarreglo + 1;
                END IF;
                IF TRIM(sbinsactu) IN('A','a') THEN
                    v_array_usuatuali(nucontaarreglo).idregistro := nuidreg;
                END IF;
            END LOOP;
            COMMIT;
        END;
        EXIT WHEN cu_productos%NOTFOUND;
        nuerror      := -11;
    END LOOP;
    CLOSE cu_productos;
    -- Borramos los datos de ldc_cartdiaria e insertamos los datos de la tablas temporales ldc_cartdiaria_tmp
    DELETE ldc_cartdiaria cd WHERE cd.producto IN(SELECT cdt.producto FROM ldc_cartdiaria_tmp cdt);
    INSERT INTO ldc_cartdiaria(SELECT * FROM ldc_cartdiaria_tmp);
    UPDATE ldc_esprocardiaria fg
    SET fg.total_reg_proc = fg.total_reg_proc + nucontaarreglo
    WHERE fg.nusession = nutvasess
    AND fg.estado = 'N';
    IF TRIM(sbinsactu) IN('A','a') THEN
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
    sbmensa := 'Proceso termino Ok. Se procesaron : '||to_char(nucontaarreglo)||' resgistros. '||sbobservaprob||' '||nucantle;
    dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_1',2);
    COMMIT;
    ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H1','Termino oK.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_1',0);
        COMMIT;
        error   := -1;
        sbmensa := sbobservaprob||' '||to_char(error)||' Error en ldc_cartlinea..lineas error '||to_char(nuerror)||' producto ' || nuproducto || ' ' || sqlerrm;
        ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H1','Termino con error.');
END ldc_proccartlinea_h1;
PROCEDURE ldc_proccartlinea_h2 IS
/********************************************************************************************
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
    20/12/2022      jcatuchemvm     OSF-747: Ajuste reporte BACADI, agregando calculo para VALOR_CASTIGADO
    14/08/2013      John Jairo Jim  Creacion
***********************************************************************************************/
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
                                     ,idre ldc_usuarios_actualiza_cl.idregistro%TYPE
                                     );

    TYPE t_array_cartdiaria IS TABLE OF array_cartdiaria;
    TYPE t_actusuarios IS TABLE OF ldc_usuarios_actualiza_cl%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE t_array_productos_procesa IS TABLE OF pr_product.product_id%TYPE INDEX BY VARCHAR2(15);
    v_array_cartdiaria t_array_cartdiaria;
    v_array_usuatuali  t_actusuarios;
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
    /* ht.esantiago solucion caso: 200-2399
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
      ORDER BY cucofeve DESC;*/

    CURSOR cucuentassaldo(nuproductocta NUMBER) IS
     SELECT cucocodi
           ,cucofeve
           ,trunc(SYSDATE) - trunc(cucofeve) nuedadmora_exacta
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
    sbmensa                      VARCHAR2(4000);
    error                        NUMBER;
    nuultre                      cc_financing_request.financing_plan_id%TYPE;
    dtultfina                    mo_packages.attention_date%TYPE;
    dtpenultfina                 mo_packages.attention_date%TYPE;
    nucontaref                   NUMBER(5) DEFAULT 0;
    v_deuda_corriente_no_vencida NUMBER(15,3);
    l_cursor                     NUMBER;
    cu_productos                 SYS_REFCURSOR;
    sbcursorproce                VARCHAR2(22000);
    sbobservaprob                VARCHAR2(100);
    nucontaarreglo               NUMBER(10) DEFAULT 0;
    nuidreg                      ldc_usuarios_actualiza_cl.idregistro%TYPE;
    nucontadelete                NUMBER(10) DEFAULT 0;
    nucantidadrefultano          NUMBER(10);
    dtvarfechaini                DATE;
    dtvarfechafin                DATE;
    nuvalor_ejecuta              ld_parameter.numeric_value%TYPE;
    sbinsactu                    VARCHAR2(2);
    l_return                     NUMBER;
    nucantle                     NUMBER;
    sbproductoarreglo            VARCHAR2(15);
    nuedad_exacta                NUMBER(5);
    nuvalorcast                  NUMBER(13,2);
BEGIN
    -- Validamos que el proceso no este en ejecucion
    nuerror := -1;
    nuvalor_ejecuta := pkg_bcld_parameter.fnuobtienevalornumerico('EJECUTA_CARTLINEA_2');
    IF nuvalor_ejecuta <> 0 THEN
        RETURN;
    ELSE
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_2',1);
        COMMIT;
    END IF;
    nuerror := -2;
    FOR ids IN cudatossesion LOOP
        nupkvaano := ids.ano;
        nupkvames := ids.mes;
        nutvasess := ids.sesion;
        sbvaruser := ids.usuario_conectado;
        dtvardia  := ids.dia;
    END LOOP;
    nuerror := -3;
    ldc_proinsertaestaprog(nupkvaano,nupkvames,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H2','En ejecucion',nutvasess,sbvaruser);
    nuerror := -4;
    dtvarfechaini  := to_date(to_char(add_months(SYSDATE,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
    dtvarfechafin  := to_date(to_char(SYSDATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');
    nuerror        := -5;
    dtdia          := trunc(dtvardia);
    sbinsactu      := pkg_bcld_parameter.fsbobtienevalorcadena('ACT_O_INS_CARTERA_LINEA');
    IF TRIM(sbinsactu) IN('I','i') THEN
        sbobservaprob := 'NULL';
        sbcursorproce := 'SELECT
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
                         ,-1 AS idreg
                     FROM
                          open.servsusc      s
                         ,open.suscripc      u
                         ,open.pr_product    p
                         ,open.ab_address    d
                         ,ge_geogra_location l
                    WHERE s.sesususc = u.susccodi
                      AND s.sesunuse = p.product_id
                      AND u.susccodi = p.subscription_id
                      AND p.address_id = d.address_id
                      AND d.geograp_location_id = l.geograp_location_id
                      AND mod(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 2';
    ELSE
        sbobservaprob := '[ACTUALIZA]';
        sbcursorproce := ' SELECT
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
                          ,c.idregistro
                     FROM
                           open.servsusc      s
                          ,open.suscripc      u
                          ,open.pr_product    p
                          ,open.ab_address    d
                          ,ge_geogra_location l
                          ,ldc_usuarios_actualiza_cl c
                     WHERE s.sesususc                                                            = u.susccodi
                       AND s.sesunuse                                                            = p.product_id
                       AND u.susccodi                                                            = p.subscription_id
                       AND p.address_id                                                          = d.address_id
                       AND d.geograp_location_id                                                 = l.geograp_location_id
                       AND s.sesunuse                                                            = c.producto
                       AND p.product_id                                                          = c.producto
                       AND MOD(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 2';
    END IF;
    -- Se adiciona al log de procesos
    nuerror := -6;
    limit_in := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CANTIDAD_REG_GUARDAR');
    -- Borramos datos de la tabla temporal
    pkg_truncate_tablas_open.prcldc_cartdiara_tmp2;

    -- Recorremos cursor
    nuerror        := -7;
    l_cursor       := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor,TRIM(sbcursorproce),dbms_sql.native);
    l_return       := dbms_sql.execute(l_cursor);
    nucantle       := l_return;
    cu_productos   := dbms_sql.to_refcursor(l_cursor);
    nucontaarreglo := 0;
    LOOP
        FETCH cu_productos BULK COLLECT INTO v_array_cartdiaria LIMIT limit_in;
        nuerror      := -8;
        BEGIN
            FOR i IN 1..v_array_cartdiaria.count LOOP
                nuproducto           := v_array_cartdiaria(i).nuse;
                sbproductoarreglo    := to_char(nuproducto);
                sbproductoarreglo    := TRIM(sbproductoarreglo);
                nuidreg              := v_array_cartdiaria(i).idre;
                IF v_array_productos_procesa.exists(sbproductoarreglo) THEN
                    nucontaarreglo := nucontaarreglo + 1;
                ELSE
                    v_array_productos_procesa(sbproductoarreglo) := nuidreg;
                    -- Cartera diferida
                    v_deuda_no_corriente := v_array_cartdiaria(i).dedi;
                    -- Obtenemos valores de la cta de cobro
                    nuerror                      := -9;
                    nuedad                       := -1;
                    nuedaddeud                   := -1;
                    nuctasconsaldo               := 0;
                    v_sesusape                   := 0;
                    v_deuda_corriente_no_vencida := 0;
                    nuedad_exacta := 0;
                    FOR g IN cucuentassaldo(nuproducto) LOOP
                        nuedad_exacta  := g.nuedadmora_exacta; -- ht.esantiago solucion caso: 200-2399
                        nuedad         := g.nuedadmora;
                        nuedaddeud     := g.nuedaddeuda;
                        nuctasconsaldo := nuctasconsaldo + 1;
                        v_sesusape     := v_sesusape + g.cucosacu;
                        IF nuedad <= 0 THEN
                            v_deuda_corriente_no_vencida := v_deuda_corriente_no_vencida + g.cucosacu;
                        END IF;
                    END LOOP;
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
                    -- Recuperamos la ultima financiacion
                    nuerror      := -11;
                    nuultre      := NULL;
                    dtultfina    := NULL;
                    dtpenultfina := NULL;
                    nucontaref   := 0;
                    nuerror      := -12;
                    FOR k IN cuultref(nuproducto) LOOP
                        nucontaref := nucontaref + 1;
                        IF nucontaref = 1 THEN
                            nuultre       := k.plan_financiacion;
                            dtultfina     := k.fecha_ingreso;
                        ELSIF nucontaref = 2 THEN
                            dtpenultfina := k.fecha_ingreso;
                        END IF;
                    END LOOP;
                    nuerror      := -13;
                    -- Cantidad de refinanciaciones en el ultimo a?o
                    nucantidadrefultano := NULL;
                    SELECT COUNT(DISTINCT(difecofi)) INTO nucantidadrefultano
                    FROM open.diferido xd
                    WHERE xd.difenuse = nuproducto
                    AND xd.difefein BETWEEN dtvarfechaini AND dtvarfechafin
                    AND xd.difeprog = 'GCNED';
                    -- Recuperamos la lectura actual y anterior del producto
                    nuerror      := -14;
                    nuLecturaActual   := fnuObtenerLectActual(nuproducto);
                    nuLecturaAnterior := fnuObtenerLectAnterior(nuproducto);
                    -- Consulta valor castigado
                    IF v_array_cartdiaria(i).esfi = 'C' THEN
                        nuvalorcast := gc_bodebtmanagement.fnugetpunidebtbyprod(nuproducto);
                    ELSE
                        nuvalorcast := null;
                    END IF;
                    -- Guardamos el registro
                    nuerror      := -15;
                    INSERT INTO ldc_cartdiaria_tmp2
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
                        EDAD_MORA_EXACTA,
                        VALOR_CASTIGADO
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
                        nuedad_exacta,
                        nuvalorcast
                    );
                    nucontaarreglo := nucontaarreglo + 1;
                END IF;
                IF TRIM(sbinsactu) IN('A','a') THEN
                    v_array_usuatuali(nucontaarreglo).idregistro := nuidreg;
                END IF;
            END LOOP;
            COMMIT;
        END;
        EXIT WHEN cu_productos%NOTFOUND;
        nuerror      := -11;
    END LOOP;
    CLOSE cu_productos;
    -- Borramos los datos de ldc_cartdiaria e insertamos los datos de la tablas temporales ldc_cartdiaria_tmp
    DELETE ldc_cartdiaria cd WHERE cd.producto IN(SELECT cdt.producto FROM ldc_cartdiaria_tmp2 cdt);
    INSERT INTO ldc_cartdiaria(SELECT * FROM ldc_cartdiaria_tmp2);
    UPDATE ldc_esprocardiaria fg
    SET fg.total_reg_proc2 = fg.total_reg_proc2 + nucontaarreglo
    WHERE fg.nusession = nutvasess
    AND fg.estado = 'N';
    IF TRIM(sbinsactu) IN('A','a') THEN
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
    sbmensa := 'Proceso termino Ok. Se procesaron : '||to_char(nucontaarreglo)||' resgistros. '||sbobservaprob||' '||nucantle;
    dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_2',2);
    COMMIT;
    ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H2','Termino oK.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_2',0);
        COMMIT;
        error   := -1;
        sbmensa := sbobservaprob||' '||to_char(error)||' Error en ldc_cartlinea..lineas error '||to_char(nuerror)||' producto ' || nuproducto || ' ' || sqlerrm;
        ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H2','Termino con error.');
END ldc_proccartlinea_h2;
PROCEDURE ldc_proccartlinea_h3 IS
/********************************************************************************************
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
    20/12/2022      jcatuchemvm     OSF-747: Ajuste reporte BACADI, agregando calculo para VALOR_CASTIGADO
    14/08/2013      John Jairo Jim  Creacion
***********************************************************************************************/
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
                                     ,idre ldc_usuarios_actualiza_cl.idregistro%TYPE
                                     );

    TYPE t_array_cartdiaria IS TABLE OF array_cartdiaria;
    TYPE t_actusuarios IS TABLE OF ldc_usuarios_actualiza_cl%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE t_array_productos_procesa IS TABLE OF pr_product.product_id%TYPE INDEX BY VARCHAR2(15);
    v_array_cartdiaria t_array_cartdiaria;
    v_array_usuatuali  t_actusuarios;
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
    /* ht.esantiago solucion caso: 200-2399
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
      ORDER BY cucofeve DESC;*/

    CURSOR cucuentassaldo(nuproductocta NUMBER) IS
     SELECT cucocodi
           ,cucofeve
           ,trunc(SYSDATE) - trunc(cucofeve) nuedadmora_exacta
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
    sbmensa                      VARCHAR2(4000);
    error                        NUMBER;
    nuultre                      cc_financing_request.financing_plan_id%TYPE;
    dtultfina                    mo_packages.attention_date%TYPE;
    dtpenultfina                 mo_packages.attention_date%TYPE;
    nucontaref                   NUMBER(5) DEFAULT 0;
    v_deuda_corriente_no_vencida NUMBER(15,3);
    l_cursor                     NUMBER;
    cu_productos                 SYS_REFCURSOR;
    sbcursorproce                VARCHAR2(22000);
    sbobservaprob                VARCHAR2(100);
    nucontaarreglo               NUMBER(10) DEFAULT 0;
    nuidreg                      ldc_usuarios_actualiza_cl.idregistro%TYPE;
    nucontadelete                NUMBER(10) DEFAULT 0;
    nucantidadrefultano          NUMBER(10);
    dtvarfechaini                DATE;
    dtvarfechafin                DATE;
    nuvalor_ejecuta              ld_parameter.numeric_value%TYPE;
    sbinsactu                    VARCHAR2(2);
    l_return                     NUMBER;
    nucantle                     NUMBER;
    sbproductoarreglo            VARCHAR2(15);
    nuedad_exacta                NUMBER(5);
    nuvalorcast                  NUMBER(13,2);
BEGIN
    -- Validamos que el proceso no este en ejecucion
    nuerror := -1;
    nuvalor_ejecuta := pkg_bcld_parameter.fnuobtienevalornumerico('EJECUTA_CARTLINEA_3');
    IF nuvalor_ejecuta <> 0 THEN
        RETURN;
    ELSE
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_3',1);
        COMMIT;
    END IF;
    nuerror := -2;
    FOR ids IN cudatossesion LOOP
        nupkvaano := ids.ano;
        nupkvames := ids.mes;
        nutvasess := ids.sesion;
        sbvaruser := ids.usuario_conectado;
        dtvardia  := ids.dia;
    END LOOP;
    nuerror := -3;
    ldc_proinsertaestaprog(nupkvaano,nupkvames,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H3','En ejecucion',nutvasess,sbvaruser);
    nuerror := -4;
    dtvarfechaini  := to_date(to_char(add_months(SYSDATE,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
    dtvarfechafin  := to_date(to_char(SYSDATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');
    nuerror        := -5;
    dtdia          := trunc(dtvardia);
    sbinsactu      := pkg_bcld_parameter.fsbobtienevalorcadena('ACT_O_INS_CARTERA_LINEA');
    IF TRIM(sbinsactu) IN('I','i') THEN
        sbobservaprob := 'NULL';
        sbcursorproce := 'SELECT
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
                         ,-1 AS idreg
                     FROM
                          open.servsusc      s
                         ,open.suscripc      u
                         ,open.pr_product    p
                         ,open.ab_address    d
                         ,ge_geogra_location l
                    WHERE s.sesususc = u.susccodi
                      AND s.sesunuse = p.product_id
                      AND u.susccodi = p.subscription_id
                      AND p.address_id = d.address_id
                      AND d.geograp_location_id = l.geograp_location_id
                      AND mod(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 3';
    ELSE
        sbobservaprob := '[ACTUALIZA]';
        sbcursorproce := ' SELECT
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
                          ,c.idregistro
                     FROM
                           open.servsusc      s
                          ,open.suscripc      u
                          ,open.pr_product    p
                          ,open.ab_address    d
                          ,ge_geogra_location l
                          ,ldc_usuarios_actualiza_cl c
                     WHERE s.sesususc                                                            = u.susccodi
                       AND s.sesunuse                                                            = p.product_id
                       AND u.susccodi                                                            = p.subscription_id
                       AND p.address_id                                                          = d.address_id
                       AND d.geograp_location_id                                                 = l.geograp_location_id
                       AND s.sesunuse                                                            = c.producto
                       AND p.product_id                                                          = c.producto
                       AND MOD(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 3';
    END IF;
    -- Se adiciona al log de procesos
    nuerror := -6;
    limit_in := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CANTIDAD_REG_GUARDAR');
    -- Borramos datos de la tabla temporal
    pkg_truncate_tablas_open.prcldc_cartdiara_tmp3;

    -- Recorremos cursor
    nuerror        := -7;
    l_cursor       := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor,TRIM(sbcursorproce),dbms_sql.native);
    l_return       := dbms_sql.execute(l_cursor);
    nucantle       := l_return;
    cu_productos   := dbms_sql.to_refcursor(l_cursor);
    nucontaarreglo := 0;
    LOOP
        FETCH cu_productos BULK COLLECT INTO v_array_cartdiaria LIMIT limit_in;
        nuerror      := -8;
        BEGIN
            FOR i IN 1..v_array_cartdiaria.count LOOP
                nuproducto           := v_array_cartdiaria(i).nuse;
                sbproductoarreglo    := to_char(nuproducto);
                sbproductoarreglo    := TRIM(sbproductoarreglo);
                nuidreg              := v_array_cartdiaria(i).idre;
                IF v_array_productos_procesa.exists(sbproductoarreglo) THEN
                    nucontaarreglo := nucontaarreglo + 1;
                ELSE
                    v_array_productos_procesa(sbproductoarreglo) := nuidreg;
                    -- Cartera diferida
                    v_deuda_no_corriente := v_array_cartdiaria(i).dedi;
                    -- Obtenemos valores de la cta de cobro
                    nuerror                      := -9;
                    nuedad                       := -1;
                    nuedaddeud                   := -1;
                    nuctasconsaldo               := 0;
                    v_sesusape                   := 0;
                    v_deuda_corriente_no_vencida := 0;
                    nuedad_exacta := 0;
                    FOR g IN cucuentassaldo(nuproducto) LOOP
                        nuedad_exacta  := g.nuedadmora_exacta; -- ht.esantiago solucion caso: 200-2399
                        nuedad         := g.nuedadmora;
                        nuedaddeud     := g.nuedaddeuda;
                        nuctasconsaldo := nuctasconsaldo + 1;
                        v_sesusape     := v_sesusape + g.cucosacu;
                        IF nuedad <= 0 THEN
                            v_deuda_corriente_no_vencida := v_deuda_corriente_no_vencida + g.cucosacu;
                        END IF;
                    END LOOP;
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
                    -- Recuperamos la ultima financiacion
                    nuerror      := -11;
                    nuultre      := NULL;
                    dtultfina    := NULL;
                    dtpenultfina := NULL;
                    nucontaref   := 0;
                    nuerror      := -12;
                    FOR k IN cuultref(nuproducto) LOOP
                        nucontaref := nucontaref + 1;
                        IF nucontaref = 1 THEN
                            nuultre       := k.plan_financiacion;
                            dtultfina     := k.fecha_ingreso;
                        ELSIF nucontaref = 2 THEN
                            dtpenultfina := k.fecha_ingreso;
                        END IF;
                    END LOOP;
                    nuerror      := -13;
                    -- Cantidad de refinanciaciones en el ultimo a?o
                    nucantidadrefultano := NULL;
                    SELECT COUNT(DISTINCT(difecofi)) INTO nucantidadrefultano
                    FROM open.diferido xd
                    WHERE xd.difenuse = nuproducto
                    AND xd.difefein BETWEEN dtvarfechaini AND dtvarfechafin
                    AND xd.difeprog = 'GCNED';
                    -- Recuperamos la lectura actual y anterior del producto
                    nuerror      := -14;
                    nuLecturaActual   := fnuObtenerLectActual(nuproducto);
                    nuLecturaAnterior := fnuObtenerLectAnterior(nuproducto);
                    -- Consulta valor castigado
                    IF v_array_cartdiaria(i).esfi = 'C' THEN
                        nuvalorcast := gc_bodebtmanagement.fnugetpunidebtbyprod(nuproducto);
                    ELSE
                        nuvalorcast := null;
                    END IF;
                    -- Guardamos el registro
                    nuerror      := -15;
                    INSERT INTO ldc_cartdiaria_tmp3
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
                        EDAD_MORA_EXACTA,
                        VALOR_CASTIGADO
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
                        nuedad_exacta,
                        nuvalorcast
                    );
                    nucontaarreglo := nucontaarreglo + 1;
                END IF;
                IF TRIM(sbinsactu) IN('A','a') THEN
                    v_array_usuatuali(nucontaarreglo).idregistro := nuidreg;
                END IF;
            END LOOP;
            COMMIT;
        END;
        EXIT WHEN cu_productos%NOTFOUND;
        nuerror      := -11;
    END LOOP;
    CLOSE cu_productos;
    -- Borramos los datos de ldc_cartdiaria e insertamos los datos de la tablas temporales ldc_cartdiaria_tmp
    DELETE ldc_cartdiaria cd WHERE cd.producto IN(SELECT cdt.producto FROM ldc_cartdiaria_tmp3 cdt);
    INSERT INTO ldc_cartdiaria(SELECT * FROM ldc_cartdiaria_tmp3);
    UPDATE ldc_esprocardiaria fg
    SET fg.total_reg_proc3 = fg.total_reg_proc3 + nucontaarreglo
    WHERE fg.nusession = nutvasess
    AND fg.estado = 'N';
    IF TRIM(sbinsactu) IN('A','a') THEN
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
    sbmensa := 'Proceso termino Ok. Se procesaron : '||to_char(nucontaarreglo)||' resgistros. '||sbobservaprob||' '||nucantle;
    dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_3',2);
    COMMIT;
    ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H3','Termino oK.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_3',0);
        COMMIT;
        error   := -1;
        sbmensa := sbobservaprob||' '||to_char(error)||' Error en ldc_cartlinea..lineas error '||to_char(nuerror)||' producto ' || nuproducto || ' ' || sqlerrm;
        ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H3','Termino con error.');
END ldc_proccartlinea_h3;
PROCEDURE ldc_proccartlinea_h4 IS
/********************************************************************************************
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
    20/12/2022      jcatuchemvm     OSF-747: Ajuste reporte BACADI, agregando calculo para VALOR_CASTIGADO
    14/08/2013      John Jairo Jim  Creacion
***********************************************************************************************/
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
                                     ,idre ldc_usuarios_actualiza_cl.idregistro%TYPE
                                     );

    TYPE t_array_cartdiaria IS TABLE OF array_cartdiaria;
    TYPE t_actusuarios IS TABLE OF ldc_usuarios_actualiza_cl%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE t_array_productos_procesa IS TABLE OF pr_product.product_id%TYPE INDEX BY VARCHAR2(15);
    v_array_cartdiaria t_array_cartdiaria;
    v_array_usuatuali  t_actusuarios;
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
    /* ht.esantiago solucion caso: 200-2399
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
      ORDER BY cucofeve DESC;*/

    CURSOR cucuentassaldo(nuproductocta NUMBER) IS
     SELECT cucocodi
           ,cucofeve
           ,trunc(SYSDATE) - trunc(cucofeve) nuedadmora_exacta
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
    sbmensa                      VARCHAR2(4000);
    error                        NUMBER;
    nuultre                      cc_financing_request.financing_plan_id%TYPE;
    dtultfina                    mo_packages.attention_date%TYPE;
    dtpenultfina                 mo_packages.attention_date%TYPE;
    nucontaref                   NUMBER(5) DEFAULT 0;
    v_deuda_corriente_no_vencida NUMBER(15,3);
    l_cursor                     NUMBER;
    cu_productos                 SYS_REFCURSOR;
    sbcursorproce                VARCHAR2(22000);
    sbobservaprob                VARCHAR2(100);
    nucontaarreglo               NUMBER(10) DEFAULT 0;
    nuidreg                      ldc_usuarios_actualiza_cl.idregistro%TYPE;
    nucontadelete                NUMBER(10) DEFAULT 0;
    nucantidadrefultano          NUMBER(10);
    dtvarfechaini                DATE;
    dtvarfechafin                DATE;
    nuvalor_ejecuta              ld_parameter.numeric_value%TYPE;
    sbinsactu                    VARCHAR2(2);
    l_return                     NUMBER;
    nucantle                     NUMBER;
    sbproductoarreglo            VARCHAR2(15);
    nuedad_exacta                NUMBER(5);
    nuvalorcast                  NUMBER(13,2);
BEGIN
    -- Validamos que el proceso no este en ejecucion
    nuerror := -1;
    nuvalor_ejecuta := pkg_bcld_parameter.fnuobtienevalornumerico('EJECUTA_CARTLINEA_4');
    IF nuvalor_ejecuta <> 0 THEN
        RETURN;
    ELSE
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_4',1);
        COMMIT;
    END IF;
    nuerror := -2;
    FOR ids IN cudatossesion LOOP
        nupkvaano := ids.ano;
        nupkvames := ids.mes;
        nutvasess := ids.sesion;
        sbvaruser := ids.usuario_conectado;
        dtvardia  := ids.dia;
    END LOOP;
    nuerror := -3;
    ldc_proinsertaestaprog(nupkvaano,nupkvames,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H4','En ejecucion',nutvasess,sbvaruser);
    nuerror := -4;
    dtvarfechaini  := to_date(to_char(add_months(SYSDATE,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
    dtvarfechafin  := to_date(to_char(SYSDATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');
    nuerror        := -5;
    dtdia          := trunc(dtvardia);
    sbinsactu      := pkg_bcld_parameter.fsbobtienevalorcadena('ACT_O_INS_CARTERA_LINEA');
    IF TRIM(sbinsactu) IN('I','i') THEN
        sbobservaprob := 'NULL';
        sbcursorproce := 'SELECT
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
                         ,-1 AS idreg
                     FROM
                          open.servsusc      s
                         ,open.suscripc      u
                         ,open.pr_product    p
                         ,open.ab_address    d
                         ,ge_geogra_location l
                    WHERE s.sesususc = u.susccodi
                      AND s.sesunuse = p.product_id
                      AND u.susccodi = p.subscription_id
                      AND p.address_id = d.address_id
                      AND d.geograp_location_id = l.geograp_location_id
                      AND mod(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 4';
    ELSE
        sbobservaprob := '[ACTUALIZA]';
        sbcursorproce := ' SELECT
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
                          ,c.idregistro
                     FROM
                           open.servsusc      s
                          ,open.suscripc      u
                          ,open.pr_product    p
                          ,open.ab_address    d
                          ,ge_geogra_location l
                          ,ldc_usuarios_actualiza_cl c
                     WHERE s.sesususc                                                            = u.susccodi
                       AND s.sesunuse                                                            = p.product_id
                       AND u.susccodi                                                            = p.subscription_id
                       AND p.address_id                                                          = d.address_id
                       AND d.geograp_location_id                                                 = l.geograp_location_id
                       AND s.sesunuse                                                            = c.producto
                       AND p.product_id                                                          = c.producto
                       AND MOD(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 4';
    END IF;
    -- Se adiciona al log de procesos
    nuerror := -6;
    limit_in := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CANTIDAD_REG_GUARDAR');
    -- Borramos datos de la tabla temporal
    pkg_truncate_tablas_open.prcldc_cartdiara_tmp4;

    -- Recorremos cursor
    nuerror        := -7;
    l_cursor       := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor,TRIM(sbcursorproce),dbms_sql.native);
    l_return       := dbms_sql.execute(l_cursor);
    nucantle       := l_return;
    cu_productos   := dbms_sql.to_refcursor(l_cursor);
    nucontaarreglo := 0;
    LOOP
        FETCH cu_productos BULK COLLECT INTO v_array_cartdiaria LIMIT limit_in;
        nuerror      := -8;
        BEGIN
            FOR i IN 1..v_array_cartdiaria.count LOOP
                nuproducto           := v_array_cartdiaria(i).nuse;
                sbproductoarreglo    := to_char(nuproducto);
                sbproductoarreglo    := TRIM(sbproductoarreglo);
                nuidreg              := v_array_cartdiaria(i).idre;
                IF v_array_productos_procesa.exists(sbproductoarreglo) THEN
                    nucontaarreglo := nucontaarreglo + 1;
                ELSE
                    v_array_productos_procesa(sbproductoarreglo) := nuidreg;
                    -- Cartera diferida
                    v_deuda_no_corriente := v_array_cartdiaria(i).dedi;
                    -- Obtenemos valores de la cta de cobro
                    nuerror                      := -9;
                    nuedad                       := -1;
                    nuedaddeud                   := -1;
                    nuctasconsaldo               := 0;
                    v_sesusape                   := 0;
                    v_deuda_corriente_no_vencida := 0;
                    nuedad_exacta := 0;
                    FOR g IN cucuentassaldo(nuproducto) LOOP
                        nuedad_exacta  := g.nuedadmora_exacta; -- ht.esantiago solucion caso: 200-2399
                        nuedad         := g.nuedadmora;
                        nuedaddeud     := g.nuedaddeuda;
                        nuctasconsaldo := nuctasconsaldo + 1;
                        v_sesusape     := v_sesusape + g.cucosacu;
                        IF nuedad <= 0 THEN
                            v_deuda_corriente_no_vencida := v_deuda_corriente_no_vencida + g.cucosacu;
                        END IF;
                    END LOOP;
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
                    -- Recuperamos la ultima financiacion
                    nuerror      := -11;
                    nuultre      := NULL;
                    dtultfina    := NULL;
                    dtpenultfina := NULL;
                    nucontaref   := 0;
                    nuerror      := -12;
                    FOR k IN cuultref(nuproducto) LOOP
                        nucontaref := nucontaref + 1;
                        IF nucontaref = 1 THEN
                            nuultre       := k.plan_financiacion;
                            dtultfina     := k.fecha_ingreso;
                        ELSIF nucontaref = 2 THEN
                            dtpenultfina := k.fecha_ingreso;
                        END IF;
                    END LOOP;
                    nuerror      := -13;
                    -- Cantidad de refinanciaciones en el ultimo a?o
                    nucantidadrefultano := NULL;
                    SELECT COUNT(DISTINCT(difecofi)) INTO nucantidadrefultano
                    FROM open.diferido xd
                    WHERE xd.difenuse = nuproducto
                    AND xd.difefein BETWEEN dtvarfechaini AND dtvarfechafin
                    AND xd.difeprog = 'GCNED';
                    -- Recuperamos la lectura actual y anterior del producto
                    nuerror      := -14;
                    nuLecturaActual   := fnuObtenerLectActual(nuproducto);
                    nuLecturaAnterior := fnuObtenerLectAnterior(nuproducto);
                    -- Consulta valor castigado
                    IF v_array_cartdiaria(i).esfi = 'C' THEN
                        nuvalorcast := gc_bodebtmanagement.fnugetpunidebtbyprod(nuproducto);
                    ELSE
                        nuvalorcast := null;
                    END IF;
                    -- Guardamos el registro
                    nuerror      := -15;
                    INSERT INTO ldc_cartdiaria_tmp4
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
                        EDAD_MORA_EXACTA,
                        VALOR_CASTIGADO
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
                        nuedad_exacta,
                        nuvalorcast
                    );
                    nucontaarreglo := nucontaarreglo + 1;
                END IF;
                IF TRIM(sbinsactu) IN('A','a') THEN
                    v_array_usuatuali(nucontaarreglo).idregistro := nuidreg;
                END IF;
            END LOOP;
            COMMIT;
        END;
        EXIT WHEN cu_productos%NOTFOUND;
        nuerror      := -11;
    END LOOP;
    CLOSE cu_productos;
    -- Borramos los datos de ldc_cartdiaria e insertamos los datos de la tablas temporales ldc_cartdiaria_tmp
    DELETE ldc_cartdiaria cd WHERE cd.producto IN(SELECT cdt.producto FROM ldc_cartdiaria_tmp4 cdt);
    INSERT INTO ldc_cartdiaria(SELECT * FROM ldc_cartdiaria_tmp4);
    UPDATE ldc_esprocardiaria fg
    SET fg.total_reg_proc4 = fg.total_reg_proc4 + nucontaarreglo
    WHERE fg.nusession = nutvasess
    AND fg.estado = 'N';
    IF TRIM(sbinsactu) IN('A','a') THEN
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
    sbmensa := 'Proceso termino Ok. Se procesaron : '||to_char(nucontaarreglo)||' resgistros. '||sbobservaprob||' '||nucantle;
    dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_4',2);
    COMMIT;
    ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H4','Termino oK.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_4',0);
        COMMIT;
        error   := -1;
        sbmensa := sbobservaprob||' '||to_char(error)||' Error en ldc_cartlinea..lineas error '||to_char(nuerror)||' producto ' || nuproducto || ' ' || sqlerrm;
        ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H4','Termino con error.');
END ldc_proccartlinea_h4;
PROCEDURE ldc_proccartlinea_h5 IS
/********************************************************************************************
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
    20/12/2022      jcatuchemvm     OSF-747: Ajuste reporte BACADI, agregando calculo para VALOR_CASTIGADO
    14/08/2013      John Jairo Jim  Creacion
***********************************************************************************************/
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
                                     ,idre ldc_usuarios_actualiza_cl.idregistro%TYPE
                                     );

    TYPE t_array_cartdiaria IS TABLE OF array_cartdiaria;
    TYPE t_actusuarios IS TABLE OF ldc_usuarios_actualiza_cl%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE t_array_productos_procesa IS TABLE OF pr_product.product_id%TYPE INDEX BY VARCHAR2(15);
    v_array_cartdiaria t_array_cartdiaria;
    v_array_usuatuali  t_actusuarios;
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
    /* ht.esantiago solucion caso: 200-2399
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
      ORDER BY cucofeve DESC;*/

    CURSOR cucuentassaldo(nuproductocta NUMBER) IS
     SELECT cucocodi
           ,cucofeve
           ,trunc(SYSDATE) - trunc(cucofeve) nuedadmora_exacta
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
    sbmensa                      VARCHAR2(4000);
    error                        NUMBER;
    nuultre                      cc_financing_request.financing_plan_id%TYPE;
    dtultfina                    mo_packages.attention_date%TYPE;
    dtpenultfina                 mo_packages.attention_date%TYPE;
    nucontaref                   NUMBER(5) DEFAULT 0;
    v_deuda_corriente_no_vencida NUMBER(15,3);
    l_cursor                     NUMBER;
    cu_productos                 SYS_REFCURSOR;
    sbcursorproce                VARCHAR2(22000);
    sbobservaprob                VARCHAR2(100);
    nucontaarreglo               NUMBER(10) DEFAULT 0;
    nuidreg                      ldc_usuarios_actualiza_cl.idregistro%TYPE;
    nucontadelete                NUMBER(10) DEFAULT 0;
    nucantidadrefultano          NUMBER(10);
    dtvarfechaini                DATE;
    dtvarfechafin                DATE;
    nuvalor_ejecuta              ld_parameter.numeric_value%TYPE;
    sbinsactu                    VARCHAR2(2);
    l_return                     NUMBER;
    nucantle                     NUMBER;
    sbproductoarreglo            VARCHAR2(15);
    nuedad_exacta                NUMBER(5);
    nuvalorcast                  NUMBER(13,2);
BEGIN
    -- Validamos que el proceso no este en ejecucion
    nuerror := -1;
    nuvalor_ejecuta := pkg_bcld_parameter.fnuobtienevalornumerico('EJECUTA_CARTLINEA_5');
    IF nuvalor_ejecuta <> 0 THEN
        RETURN;
    ELSE
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_5',1);
        COMMIT;
    END IF;
    nuerror := -2;
    FOR ids IN cudatossesion LOOP
        nupkvaano := ids.ano;
        nupkvames := ids.mes;
        nutvasess := ids.sesion;
        sbvaruser := ids.usuario_conectado;
        dtvardia  := ids.dia;
    END LOOP;
    nuerror := -3;
    ldc_proinsertaestaprog(nupkvaano,nupkvames,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H5','En ejecucion',nutvasess,sbvaruser);
    nuerror := -4;
    dtvarfechaini  := to_date(to_char(add_months(SYSDATE,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
    dtvarfechafin  := to_date(to_char(SYSDATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');
    nuerror        := -5;
    dtdia          := trunc(dtvardia);
    sbinsactu      := pkg_bcld_parameter.fsbobtienevalorcadena('ACT_O_INS_CARTERA_LINEA');
    IF TRIM(sbinsactu) IN('I','i') THEN
        sbobservaprob := 'NULL';
        sbcursorproce := 'SELECT
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
                         ,-1 AS idreg
                     FROM
                          open.servsusc      s
                         ,open.suscripc      u
                         ,open.pr_product    p
                         ,open.ab_address    d
                         ,ge_geogra_location l
                    WHERE s.sesususc = u.susccodi
                      AND s.sesunuse = p.product_id
                      AND u.susccodi = p.subscription_id
                      AND p.address_id = d.address_id
                      AND d.geograp_location_id = l.geograp_location_id
                      AND mod(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 5';
    ELSE
        sbobservaprob := '[ACTUALIZA]';
        sbcursorproce := ' SELECT
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
                          ,c.idregistro
                     FROM
                           open.servsusc      s
                          ,open.suscripc      u
                          ,open.pr_product    p
                          ,open.ab_address    d
                          ,ge_geogra_location l
                          ,ldc_usuarios_actualiza_cl c
                     WHERE s.sesususc                                                            = u.susccodi
                       AND s.sesunuse                                                            = p.product_id
                       AND u.susccodi                                                            = p.subscription_id
                       AND p.address_id                                                          = d.address_id
                       AND d.geograp_location_id                                                 = l.geograp_location_id
                       AND s.sesunuse                                                            = c.producto
                       AND p.product_id                                                          = c.producto
                       AND MOD(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 5';
    END IF;
    -- Se adiciona al log de procesos
    nuerror := -6;
    limit_in := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CANTIDAD_REG_GUARDAR');
    -- Borramos datos de la tabla temporal
    pkg_truncate_tablas_open.prcldc_cartdiara_tmp5;

    -- Recorremos cursor
    nuerror        := -7;
    l_cursor       := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor,TRIM(sbcursorproce),dbms_sql.native);
    l_return       := dbms_sql.execute(l_cursor);
    nucantle       := l_return;
    cu_productos   := dbms_sql.to_refcursor(l_cursor);
    nucontaarreglo := 0;
    LOOP
        FETCH cu_productos BULK COLLECT INTO v_array_cartdiaria LIMIT limit_in;
        nuerror      := -8;
        BEGIN
            FOR i IN 1..v_array_cartdiaria.count LOOP
                nuproducto           := v_array_cartdiaria(i).nuse;
                sbproductoarreglo    := to_char(nuproducto);
                sbproductoarreglo    := TRIM(sbproductoarreglo);
                nuidreg              := v_array_cartdiaria(i).idre;
                IF v_array_productos_procesa.exists(sbproductoarreglo) THEN
                    nucontaarreglo := nucontaarreglo + 1;
                ELSE
                    v_array_productos_procesa(sbproductoarreglo) := nuidreg;
                    -- Cartera diferida
                    v_deuda_no_corriente := v_array_cartdiaria(i).dedi;
                    -- Obtenemos valores de la cta de cobro
                    nuerror                      := -9;
                    nuedad                       := -1;
                    nuedaddeud                   := -1;
                    nuctasconsaldo               := 0;
                    v_sesusape                   := 0;
                    v_deuda_corriente_no_vencida := 0;
                    nuedad_exacta := 0;
                    FOR g IN cucuentassaldo(nuproducto) LOOP
                        nuedad_exacta  := g.nuedadmora_exacta; -- ht.esantiago solucion caso: 200-2399
                        nuedad         := g.nuedadmora;
                        nuedaddeud     := g.nuedaddeuda;
                        nuctasconsaldo := nuctasconsaldo + 1;
                        v_sesusape     := v_sesusape + g.cucosacu;
                        IF nuedad <= 0 THEN
                            v_deuda_corriente_no_vencida := v_deuda_corriente_no_vencida + g.cucosacu;
                        END IF;
                    END LOOP;
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
                    -- Recuperamos la ultima financiacion
                    nuerror      := -11;
                    nuultre      := NULL;
                    dtultfina    := NULL;
                    dtpenultfina := NULL;
                    nucontaref   := 0;
                    nuerror      := -12;
                    FOR k IN cuultref(nuproducto) LOOP
                        nucontaref := nucontaref + 1;
                        IF nucontaref = 1 THEN
                            nuultre       := k.plan_financiacion;
                            dtultfina     := k.fecha_ingreso;
                        ELSIF nucontaref = 2 THEN
                            dtpenultfina := k.fecha_ingreso;
                        END IF;
                    END LOOP;
                    nuerror      := -13;
                    -- Cantidad de refinanciaciones en el ultimo a?o
                    nucantidadrefultano := NULL;
                    SELECT COUNT(DISTINCT(difecofi)) INTO nucantidadrefultano
                    FROM open.diferido xd
                    WHERE xd.difenuse = nuproducto
                    AND xd.difefein BETWEEN dtvarfechaini AND dtvarfechafin
                    AND xd.difeprog = 'GCNED';
                    -- Recuperamos la lectura actual y anterior del producto
                    nuerror      := -14;
                    nuLecturaActual   := fnuObtenerLectActual(nuproducto);
                    nuLecturaAnterior := fnuObtenerLectAnterior(nuproducto);
                    -- Consulta valor castigado
                    IF v_array_cartdiaria(i).esfi = 'C' THEN
                        nuvalorcast := gc_bodebtmanagement.fnugetpunidebtbyprod(nuproducto);
                    ELSE
                        nuvalorcast := null;
                    END IF;
                    -- Guardamos el registro
                    nuerror      := -15;
                    INSERT INTO ldc_cartdiaria_tmp5
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
                        EDAD_MORA_EXACTA,
                        VALOR_CASTIGADO
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
                        nuedad_exacta,
                        nuvalorcast
                    );
                    nucontaarreglo := nucontaarreglo + 1;
                END IF;
                IF TRIM(sbinsactu) IN('A','a') THEN
                    v_array_usuatuali(nucontaarreglo).idregistro := nuidreg;
                END IF;
            END LOOP;
            COMMIT;
        END;
        EXIT WHEN cu_productos%NOTFOUND;
        nuerror      := -11;
    END LOOP;
    CLOSE cu_productos;
    -- Borramos los datos de ldc_cartdiaria e insertamos los datos de la tablas temporales ldc_cartdiaria_tmp
    DELETE ldc_cartdiaria cd WHERE cd.producto IN(SELECT cdt.producto FROM ldc_cartdiaria_tmp5 cdt);
    INSERT INTO ldc_cartdiaria(SELECT * FROM ldc_cartdiaria_tmp5);
    UPDATE ldc_esprocardiaria fg
    SET fg.total_reg_proc5 = fg.total_reg_proc5 + nucontaarreglo
    WHERE fg.nusession = nutvasess
    AND fg.estado = 'N';
    IF TRIM(sbinsactu) IN('A','a') THEN
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
    sbmensa := 'Proceso termino Ok. Se procesaron : '||to_char(nucontaarreglo)||' resgistros. '||sbobservaprob||' '||nucantle;
    dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_5',2);
    COMMIT;
    ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H5','Termino oK.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_5',0);
        COMMIT;
        error   := -1;
        sbmensa := sbobservaprob||' '||to_char(error)||' Error en ldc_cartlinea..lineas error '||to_char(nuerror)||' producto ' || nuproducto || ' ' || sqlerrm;
        ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H5','Termino con error.');
END ldc_proccartlinea_h5;
PROCEDURE ldc_proccartlinea_h6 IS
/********************************************************************************************
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
    20/12/2022      jcatuchemvm     OSF-747: Ajuste reporte BACADI, agregando calculo para VALOR_CASTIGADO
    14/08/2013      John Jairo Jim  Creacion
***********************************************************************************************/
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
                                     ,idre ldc_usuarios_actualiza_cl.idregistro%TYPE
                                     );

    TYPE t_array_cartdiaria IS TABLE OF array_cartdiaria;
    TYPE t_actusuarios IS TABLE OF ldc_usuarios_actualiza_cl%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE t_array_productos_procesa IS TABLE OF pr_product.product_id%TYPE INDEX BY VARCHAR2(15);
    v_array_cartdiaria t_array_cartdiaria;
    v_array_usuatuali  t_actusuarios;
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
    /* ht.esantiago solucion caso: 200-2399
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
      ORDER BY cucofeve DESC;*/

    CURSOR cucuentassaldo(nuproductocta NUMBER) IS
     SELECT cucocodi
           ,cucofeve
           ,trunc(SYSDATE) - trunc(cucofeve) nuedadmora_exacta
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
    sbmensa                      VARCHAR2(4000);
    error                        NUMBER;
    nuultre                      cc_financing_request.financing_plan_id%TYPE;
    dtultfina                    mo_packages.attention_date%TYPE;
    dtpenultfina                 mo_packages.attention_date%TYPE;
    nucontaref                   NUMBER(5) DEFAULT 0;
    v_deuda_corriente_no_vencida NUMBER(15,3);
    l_cursor                     NUMBER;
    cu_productos                 SYS_REFCURSOR;
    sbcursorproce                VARCHAR2(22000);
    sbobservaprob                VARCHAR2(100);
    nucontaarreglo               NUMBER(10) DEFAULT 0;
    nuidreg                      ldc_usuarios_actualiza_cl.idregistro%TYPE;
    nucontadelete                NUMBER(10) DEFAULT 0;
    nucantidadrefultano          NUMBER(10);
    dtvarfechaini                DATE;
    dtvarfechafin                DATE;
    nuvalor_ejecuta              ld_parameter.numeric_value%TYPE;
    sbinsactu                    VARCHAR2(2);
    l_return                     NUMBER;
    nucantle                     NUMBER;
    sbproductoarreglo            VARCHAR2(15);
    nuedad_exacta                NUMBER(5);
    nuvalorcast                  NUMBER(13,2);
BEGIN
    -- Validamos que el proceso no este en ejecucion
    nuerror := -1;
    nuvalor_ejecuta := pkg_bcld_parameter.fnuobtienevalornumerico('EJECUTA_CARTLINEA_6');
    IF nuvalor_ejecuta <> 0 THEN
        RETURN;
    ELSE
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_6',1);
        COMMIT;
    END IF;
    nuerror := -2;
    FOR ids IN cudatossesion LOOP
        nupkvaano := ids.ano;
        nupkvames := ids.mes;
        nutvasess := ids.sesion;
        sbvaruser := ids.usuario_conectado;
        dtvardia  := ids.dia;
    END LOOP;
    nuerror := -3;
    ldc_proinsertaestaprog(nupkvaano,nupkvames,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H6','En ejecucion',nutvasess,sbvaruser);
    nuerror := -4;
    dtvarfechaini  := to_date(to_char(add_months(SYSDATE,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
    dtvarfechafin  := to_date(to_char(SYSDATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');
    nuerror        := -5;
    dtdia          := trunc(dtvardia);
    sbinsactu      := pkg_bcld_parameter.fsbobtienevalorcadena('ACT_O_INS_CARTERA_LINEA');
    IF TRIM(sbinsactu) IN('I','i') THEN
        sbobservaprob := 'NULL';
        sbcursorproce := 'SELECT
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
                         ,-1 AS idreg
                     FROM
                          open.servsusc      s
                         ,open.suscripc      u
                         ,open.pr_product    p
                         ,open.ab_address    d
                         ,ge_geogra_location l
                    WHERE s.sesususc = u.susccodi
                      AND s.sesunuse = p.product_id
                      AND u.susccodi = p.subscription_id
                      AND p.address_id = d.address_id
                      AND d.geograp_location_id = l.geograp_location_id
                      AND mod(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 6';
    ELSE
        sbobservaprob := '[ACTUALIZA]';
        sbcursorproce := ' SELECT
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
                          ,c.idregistro
                     FROM
                           open.servsusc      s
                          ,open.suscripc      u
                          ,open.pr_product    p
                          ,open.ab_address    d
                          ,ge_geogra_location l
                          ,ldc_usuarios_actualiza_cl c
                     WHERE s.sesususc                                                            = u.susccodi
                       AND s.sesunuse                                                            = p.product_id
                       AND u.susccodi                                                            = p.subscription_id
                       AND p.address_id                                                          = d.address_id
                       AND d.geograp_location_id                                                 = l.geograp_location_id
                       AND s.sesunuse                                                            = c.producto
                       AND p.product_id                                                          = c.producto
                       AND MOD(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 6';
    END IF;
    -- Se adiciona al log de procesos
    nuerror := -6;
    limit_in := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CANTIDAD_REG_GUARDAR');
    -- Borramos datos de la tabla temporal
    pkg_truncate_tablas_open.prcldc_cartdiara_tmp6;

    -- Recorremos cursor
    nuerror        := -7;
    l_cursor       := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor,TRIM(sbcursorproce),dbms_sql.native);
    l_return       := dbms_sql.execute(l_cursor);
    nucantle       := l_return;
    cu_productos   := dbms_sql.to_refcursor(l_cursor);
    nucontaarreglo := 0;
    LOOP
        FETCH cu_productos BULK COLLECT INTO v_array_cartdiaria LIMIT limit_in;
        nuerror      := -8;
        BEGIN
            FOR i IN 1..v_array_cartdiaria.count LOOP
                nuproducto           := v_array_cartdiaria(i).nuse;
                sbproductoarreglo    := to_char(nuproducto);
                sbproductoarreglo    := TRIM(sbproductoarreglo);
                nuidreg              := v_array_cartdiaria(i).idre;
                IF v_array_productos_procesa.exists(sbproductoarreglo) THEN
                    nucontaarreglo := nucontaarreglo + 1;
                ELSE
                    v_array_productos_procesa(sbproductoarreglo) := nuidreg;
                    -- Cartera diferida
                    v_deuda_no_corriente := v_array_cartdiaria(i).dedi;
                    -- Obtenemos valores de la cta de cobro
                    nuerror                      := -9;
                    nuedad                       := -1;
                    nuedaddeud                   := -1;
                    nuctasconsaldo               := 0;
                    v_sesusape                   := 0;
                    v_deuda_corriente_no_vencida := 0;
                    nuedad_exacta := 0;
                    FOR g IN cucuentassaldo(nuproducto) LOOP
                        nuedad_exacta  := g.nuedadmora_exacta; -- ht.esantiago solucion caso: 200-2399
                        nuedad         := g.nuedadmora;
                        nuedaddeud     := g.nuedaddeuda;
                        nuctasconsaldo := nuctasconsaldo + 1;
                        v_sesusape     := v_sesusape + g.cucosacu;
                        IF nuedad <= 0 THEN
                            v_deuda_corriente_no_vencida := v_deuda_corriente_no_vencida + g.cucosacu;
                        END IF;
                    END LOOP;
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
                    -- Recuperamos la ultima financiacion
                    nuerror      := -11;
                    nuultre      := NULL;
                    dtultfina    := NULL;
                    dtpenultfina := NULL;
                    nucontaref   := 0;
                    nuerror      := -12;
                    FOR k IN cuultref(nuproducto) LOOP
                        nucontaref := nucontaref + 1;
                        IF nucontaref = 1 THEN
                            nuultre       := k.plan_financiacion;
                            dtultfina     := k.fecha_ingreso;
                        ELSIF nucontaref = 2 THEN
                            dtpenultfina := k.fecha_ingreso;
                        END IF;
                    END LOOP;
                    nuerror      := -13;
                    -- Cantidad de refinanciaciones en el ultimo a?o
                    nucantidadrefultano := NULL;
                    SELECT COUNT(DISTINCT(difecofi)) INTO nucantidadrefultano
                    FROM open.diferido xd
                    WHERE xd.difenuse = nuproducto
                    AND xd.difefein BETWEEN dtvarfechaini AND dtvarfechafin
                    AND xd.difeprog = 'GCNED';
                    -- Recuperamos la lectura actual y anterior del producto
                    nuerror      := -14;
                    nuLecturaActual   := fnuObtenerLectActual(nuproducto);
                    nuLecturaAnterior := fnuObtenerLectAnterior(nuproducto);
                    -- Consulta valor castigado
                    IF v_array_cartdiaria(i).esfi = 'C' THEN
                        nuvalorcast := gc_bodebtmanagement.fnugetpunidebtbyprod(nuproducto);
                    ELSE
                        nuvalorcast := null;
                    END IF;
                    -- Guardamos el registro
                    nuerror      := -15;
                    INSERT INTO ldc_cartdiaria_tmp6
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
                        EDAD_MORA_EXACTA,
                        VALOR_CASTIGADO
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
                        nuedad_exacta,
                        nuvalorcast
                    );
                    nucontaarreglo := nucontaarreglo + 1;
                END IF;
                IF TRIM(sbinsactu) IN('A','a') THEN
                    v_array_usuatuali(nucontaarreglo).idregistro := nuidreg;
                END IF;
            END LOOP;
            COMMIT;
        END;
        EXIT WHEN cu_productos%NOTFOUND;
        nuerror      := -11;
    END LOOP;
    CLOSE cu_productos;
    -- Borramos los datos de ldc_cartdiaria e insertamos los datos de la tablas temporales ldc_cartdiaria_tmp
    DELETE ldc_cartdiaria cd WHERE cd.producto IN(SELECT cdt.producto FROM ldc_cartdiaria_tmp6 cdt);
    INSERT INTO ldc_cartdiaria(SELECT * FROM ldc_cartdiaria_tmp6);
    UPDATE ldc_esprocardiaria fg
    SET fg.total_reg_proc6 = fg.total_reg_proc6 + nucontaarreglo
    WHERE fg.nusession = nutvasess
    AND fg.estado = 'N';
    IF TRIM(sbinsactu) IN('A','a') THEN
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
    sbmensa := 'Proceso termino Ok. Se procesaron : '||to_char(nucontaarreglo)||' resgistros. '||sbobservaprob||' '||nucantle;
    dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_6',2);
    COMMIT;
    ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H6','Termino oK.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_6',0);
        COMMIT;
        error   := -1;
        sbmensa := sbobservaprob||' '||to_char(error)||' Error en ldc_cartlinea..lineas error '||to_char(nuerror)||' producto ' || nuproducto || ' ' || sqlerrm;
        ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H6','Termino con error.');
END ldc_proccartlinea_h6;
PROCEDURE ldc_proccartlinea_h7 IS
/********************************************************************************************
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
    20/12/2022      jcatuchemvm     OSF-747: Ajuste reporte BACADI, agregando calculo para VALOR_CASTIGADO
    14/08/2013      John Jairo Jim  Creacion
***********************************************************************************************/
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
                                     ,idre ldc_usuarios_actualiza_cl.idregistro%TYPE
                                     );

    TYPE t_array_cartdiaria IS TABLE OF array_cartdiaria;
    TYPE t_actusuarios IS TABLE OF ldc_usuarios_actualiza_cl%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE t_array_productos_procesa IS TABLE OF pr_product.product_id%TYPE INDEX BY VARCHAR2(15);
    v_array_cartdiaria t_array_cartdiaria;
    v_array_usuatuali  t_actusuarios;
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
    /* ht.esantiago solucion caso: 200-2399
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
      ORDER BY cucofeve DESC;*/

    CURSOR cucuentassaldo(nuproductocta NUMBER) IS
     SELECT cucocodi
           ,cucofeve
           ,trunc(SYSDATE) - trunc(cucofeve) nuedadmora_exacta
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
    sbmensa                      VARCHAR2(4000);
    error                        NUMBER;
    nuultre                      cc_financing_request.financing_plan_id%TYPE;
    dtultfina                    mo_packages.attention_date%TYPE;
    dtpenultfina                 mo_packages.attention_date%TYPE;
    nucontaref                   NUMBER(5) DEFAULT 0;
    v_deuda_corriente_no_vencida NUMBER(15,3);
    l_cursor                     NUMBER;
    cu_productos                 SYS_REFCURSOR;
    sbcursorproce                VARCHAR2(22000);
    sbobservaprob                VARCHAR2(100);
    nucontaarreglo               NUMBER(10) DEFAULT 0;
    nuidreg                      ldc_usuarios_actualiza_cl.idregistro%TYPE;
    nucontadelete                NUMBER(10) DEFAULT 0;
    nucantidadrefultano          NUMBER(10);
    dtvarfechaini                DATE;
    dtvarfechafin                DATE;
    nuvalor_ejecuta              ld_parameter.numeric_value%TYPE;
    sbinsactu                    VARCHAR2(2);
    l_return                     NUMBER;
    nucantle                     NUMBER;
    sbproductoarreglo            VARCHAR2(15);
    nuedad_exacta                NUMBER(5);
    nuvalorcast                  NUMBER(13,2);
BEGIN
    -- Validamos que el proceso no este en ejecucion
    nuerror := -1;
    nuvalor_ejecuta := pkg_bcld_parameter.fnuobtienevalornumerico('EJECUTA_CARTLINEA_7');
    IF nuvalor_ejecuta <> 0 THEN
        RETURN;
    ELSE
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_7',1);
        COMMIT;
    END IF;
    nuerror := -2;
    FOR ids IN cudatossesion LOOP
        nupkvaano := ids.ano;
        nupkvames := ids.mes;
        nutvasess := ids.sesion;
        sbvaruser := ids.usuario_conectado;
        dtvardia  := ids.dia;
    END LOOP;
    nuerror := -3;
    ldc_proinsertaestaprog(nupkvaano,nupkvames,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H7','En ejecucion',nutvasess,sbvaruser);
    nuerror := -4;
    dtvarfechaini  := to_date(to_char(add_months(SYSDATE,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
    dtvarfechafin  := to_date(to_char(SYSDATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');
    nuerror        := -5;
    dtdia          := trunc(dtvardia);
    sbinsactu      := pkg_bcld_parameter.fsbobtienevalorcadena('ACT_O_INS_CARTERA_LINEA');
    IF TRIM(sbinsactu) IN('I','i') THEN
        sbobservaprob := 'NULL';
        sbcursorproce := 'SELECT
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
                         ,-1 AS idreg
                     FROM
                          open.servsusc      s
                         ,open.suscripc      u
                         ,open.pr_product    p
                         ,open.ab_address    d
                         ,ge_geogra_location l
                    WHERE s.sesususc = u.susccodi
                      AND s.sesunuse = p.product_id
                      AND u.susccodi = p.subscription_id
                      AND p.address_id = d.address_id
                      AND d.geograp_location_id = l.geograp_location_id
                      AND mod(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 7';
    ELSE
        sbobservaprob := '[ACTUALIZA]';
        sbcursorproce := ' SELECT
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
                          ,c.idregistro
                     FROM
                           open.servsusc      s
                          ,open.suscripc      u
                          ,open.pr_product    p
                          ,open.ab_address    d
                          ,ge_geogra_location l
                          ,ldc_usuarios_actualiza_cl c
                     WHERE s.sesususc                                                            = u.susccodi
                       AND s.sesunuse                                                            = p.product_id
                       AND u.susccodi                                                            = p.subscription_id
                       AND p.address_id                                                          = d.address_id
                       AND d.geograp_location_id                                                 = l.geograp_location_id
                       AND s.sesunuse                                                            = c.producto
                       AND p.product_id                                                          = c.producto
                       AND MOD(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 7';
    END IF;
    -- Se adiciona al log de procesos
    nuerror := -6;
    limit_in := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CANTIDAD_REG_GUARDAR');
    -- Borramos datos de la tabla temporal
    pkg_truncate_tablas_open.prcldc_cartdiara_tmp7;

    -- Recorremos cursor
    nuerror        := -7;
    l_cursor       := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor,TRIM(sbcursorproce),dbms_sql.native);
    l_return       := dbms_sql.execute(l_cursor);
    nucantle       := l_return;
    cu_productos   := dbms_sql.to_refcursor(l_cursor);
    nucontaarreglo := 0;
    LOOP
        FETCH cu_productos BULK COLLECT INTO v_array_cartdiaria LIMIT limit_in;
        nuerror      := -8;
        BEGIN
            FOR i IN 1..v_array_cartdiaria.count LOOP
                nuproducto           := v_array_cartdiaria(i).nuse;
                sbproductoarreglo    := to_char(nuproducto);
                sbproductoarreglo    := TRIM(sbproductoarreglo);
                nuidreg              := v_array_cartdiaria(i).idre;
                IF v_array_productos_procesa.exists(sbproductoarreglo) THEN
                    nucontaarreglo := nucontaarreglo + 1;
                ELSE
                    v_array_productos_procesa(sbproductoarreglo) := nuidreg;
                    -- Cartera diferida
                    v_deuda_no_corriente := v_array_cartdiaria(i).dedi;
                    -- Obtenemos valores de la cta de cobro
                    nuerror                      := -9;
                    nuedad                       := -1;
                    nuedaddeud                   := -1;
                    nuctasconsaldo               := 0;
                    v_sesusape                   := 0;
                    v_deuda_corriente_no_vencida := 0;
                    nuedad_exacta := 0;
                    FOR g IN cucuentassaldo(nuproducto) LOOP
                        nuedad_exacta  := g.nuedadmora_exacta; -- ht.esantiago solucion caso: 200-2399
                        nuedad         := g.nuedadmora;
                        nuedaddeud     := g.nuedaddeuda;
                        nuctasconsaldo := nuctasconsaldo + 1;
                        v_sesusape     := v_sesusape + g.cucosacu;
                        IF nuedad <= 0 THEN
                            v_deuda_corriente_no_vencida := v_deuda_corriente_no_vencida + g.cucosacu;
                        END IF;
                    END LOOP;
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
                    -- Recuperamos la ultima financiacion
                    nuerror      := -11;
                    nuultre      := NULL;
                    dtultfina    := NULL;
                    dtpenultfina := NULL;
                    nucontaref   := 0;
                    nuerror      := -12;
                    FOR k IN cuultref(nuproducto) LOOP
                        nucontaref := nucontaref + 1;
                        IF nucontaref = 1 THEN
                            nuultre       := k.plan_financiacion;
                            dtultfina     := k.fecha_ingreso;
                        ELSIF nucontaref = 2 THEN
                            dtpenultfina := k.fecha_ingreso;
                        END IF;
                    END LOOP;
                    nuerror      := -13;
                    -- Cantidad de refinanciaciones en el ultimo a?o
                    nucantidadrefultano := NULL;
                    SELECT COUNT(DISTINCT(difecofi)) INTO nucantidadrefultano
                    FROM open.diferido xd
                    WHERE xd.difenuse = nuproducto
                    AND xd.difefein BETWEEN dtvarfechaini AND dtvarfechafin
                    AND xd.difeprog = 'GCNED';
                    -- Recuperamos la lectura actual y anterior del producto
                    nuerror      := -14;
                    nuLecturaActual   := fnuObtenerLectActual(nuproducto);
                    nuLecturaAnterior := fnuObtenerLectAnterior(nuproducto);
                    -- Consulta valor castigado
                    IF v_array_cartdiaria(i).esfi = 'C' THEN
                        nuvalorcast := gc_bodebtmanagement.fnugetpunidebtbyprod(nuproducto);
                    ELSE
                        nuvalorcast := null;
                    END IF;
                    -- Guardamos el registro
                    nuerror      := -15;
                    INSERT INTO ldc_cartdiaria_tmp7
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
                        EDAD_MORA_EXACTA,
                        VALOR_CASTIGADO
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
                        nuedad_exacta,
                        nuvalorcast
                    );
                    nucontaarreglo := nucontaarreglo + 1;
                END IF;
                IF TRIM(sbinsactu) IN('A','a') THEN
                    v_array_usuatuali(nucontaarreglo).idregistro := nuidreg;
                END IF;
            END LOOP;
            COMMIT;
        END;
        EXIT WHEN cu_productos%NOTFOUND;
        nuerror      := -11;
    END LOOP;
    CLOSE cu_productos;
    -- Borramos los datos de ldc_cartdiaria e insertamos los datos de la tablas temporales ldc_cartdiaria_tmp
    DELETE ldc_cartdiaria cd WHERE cd.producto IN(SELECT cdt.producto FROM ldc_cartdiaria_tmp7 cdt);
    INSERT INTO ldc_cartdiaria(SELECT * FROM ldc_cartdiaria_tmp7);
    UPDATE ldc_esprocardiaria fg
    SET fg.total_reg_proc7 = fg.total_reg_proc7 + nucontaarreglo
    WHERE fg.nusession = nutvasess
    AND fg.estado = 'N';
    IF TRIM(sbinsactu) IN('A','a') THEN
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
    sbmensa := 'Proceso termino Ok. Se procesaron : '||to_char(nucontaarreglo)||' resgistros. '||sbobservaprob||' '||nucantle;
    dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_7',2);
    COMMIT;
    ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H7','Termino oK.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_7',0);
        COMMIT;
        error   := -1;
        sbmensa := sbobservaprob||' '||to_char(error)||' Error en ldc_cartlinea..lineas error '||to_char(nuerror)||' producto ' || nuproducto || ' ' || sqlerrm;
        ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H7','Termino con error.');
END ldc_proccartlinea_h7;
PROCEDURE ldc_proccartlinea_h8 IS
/********************************************************************************************
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
    20/12/2022      jcatuchemvm     OSF-747: Ajuste reporte BACADI, agregando calculo para VALOR_CASTIGADO
    14/08/2013      John Jairo Jim  Creacion
***********************************************************************************************/
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
                                     ,idre ldc_usuarios_actualiza_cl.idregistro%TYPE
                                     );

    TYPE t_array_cartdiaria IS TABLE OF array_cartdiaria;
    TYPE t_actusuarios IS TABLE OF ldc_usuarios_actualiza_cl%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE t_array_productos_procesa IS TABLE OF pr_product.product_id%TYPE INDEX BY VARCHAR2(15);
    v_array_cartdiaria t_array_cartdiaria;
    v_array_usuatuali  t_actusuarios;
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
    /* ht.esantiago solucion caso: 200-2399
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
      ORDER BY cucofeve DESC;*/

    CURSOR cucuentassaldo(nuproductocta NUMBER) IS
     SELECT cucocodi
           ,cucofeve
           ,trunc(SYSDATE) - trunc(cucofeve) nuedadmora_exacta
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
    sbmensa                      VARCHAR2(4000);
    error                        NUMBER;
    nuultre                      cc_financing_request.financing_plan_id%TYPE;
    dtultfina                    mo_packages.attention_date%TYPE;
    dtpenultfina                 mo_packages.attention_date%TYPE;
    nucontaref                   NUMBER(5) DEFAULT 0;
    v_deuda_corriente_no_vencida NUMBER(15,3);
    l_cursor                     NUMBER;
    cu_productos                 SYS_REFCURSOR;
    sbcursorproce                VARCHAR2(22000);
    sbobservaprob                VARCHAR2(100);
    nucontaarreglo               NUMBER(10) DEFAULT 0;
    nuidreg                      ldc_usuarios_actualiza_cl.idregistro%TYPE;
    nucontadelete                NUMBER(10) DEFAULT 0;
    nucantidadrefultano          NUMBER(10);
    dtvarfechaini                DATE;
    dtvarfechafin                DATE;
    nuvalor_ejecuta              ld_parameter.numeric_value%TYPE;
    sbinsactu                    VARCHAR2(2);
    l_return                     NUMBER;
    nucantle                     NUMBER;
    sbproductoarreglo            VARCHAR2(15);
    nuedad_exacta                NUMBER(5);
    nuvalorcast                  NUMBER(13,2);
BEGIN
    -- Validamos que el proceso no este en ejecucion
    nuerror := -1;
    nuvalor_ejecuta := pkg_bcld_parameter.fnuobtienevalornumerico('EJECUTA_CARTLINEA_8');
    IF nuvalor_ejecuta <> 0 THEN
        RETURN;
    ELSE
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_8',1);
        COMMIT;
    END IF;
    nuerror := -2;
    FOR ids IN cudatossesion LOOP
        nupkvaano := ids.ano;
        nupkvames := ids.mes;
        nutvasess := ids.sesion;
        sbvaruser := ids.usuario_conectado;
        dtvardia  := ids.dia;
    END LOOP;
    nuerror := -3;
    ldc_proinsertaestaprog(nupkvaano,nupkvames,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H8','En ejecucion',nutvasess,sbvaruser);
    nuerror := -4;
    dtvarfechaini  := to_date(to_char(add_months(SYSDATE,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
    dtvarfechafin  := to_date(to_char(SYSDATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');
    nuerror        := -5;
    dtdia          := trunc(dtvardia);
    sbinsactu      := pkg_bcld_parameter.fsbobtienevalorcadena('ACT_O_INS_CARTERA_LINEA');
    IF TRIM(sbinsactu) IN('I','i') THEN
        sbobservaprob := 'NULL';
        sbcursorproce := 'SELECT
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
                         ,-1 AS idreg
                     FROM
                          open.servsusc      s
                         ,open.suscripc      u
                         ,open.pr_product    p
                         ,open.ab_address    d
                         ,ge_geogra_location l
                    WHERE s.sesususc = u.susccodi
                      AND s.sesunuse = p.product_id
                      AND u.susccodi = p.subscription_id
                      AND p.address_id = d.address_id
                      AND d.geograp_location_id = l.geograp_location_id
                      AND mod(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 8';
    ELSE
        sbobservaprob := '[ACTUALIZA]';
        sbcursorproce := ' SELECT
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
                          ,c.idregistro
                     FROM
                           open.servsusc      s
                          ,open.suscripc      u
                          ,open.pr_product    p
                          ,open.ab_address    d
                          ,ge_geogra_location l
                          ,ldc_usuarios_actualiza_cl c
                     WHERE s.sesususc                                                            = u.susccodi
                       AND s.sesunuse                                                            = p.product_id
                       AND u.susccodi                                                            = p.subscription_id
                       AND p.address_id                                                          = d.address_id
                       AND d.geograp_location_id                                                 = l.geograp_location_id
                       AND s.sesunuse                                                            = c.producto
                       AND p.product_id                                                          = c.producto
                       AND MOD(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 8';
    END IF;
    -- Se adiciona al log de procesos
    nuerror := -6;
    limit_in := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CANTIDAD_REG_GUARDAR');
    -- Borramos datos de la tabla temporal
    pkg_truncate_tablas_open.prcldc_cartdiara_tmp8;
  
    -- Recorremos cursor
    nuerror        := -7;
    l_cursor       := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor,TRIM(sbcursorproce),dbms_sql.native);
    l_return       := dbms_sql.execute(l_cursor);
    nucantle       := l_return;
    cu_productos   := dbms_sql.to_refcursor(l_cursor);
    nucontaarreglo := 0;
    LOOP
        FETCH cu_productos BULK COLLECT INTO v_array_cartdiaria LIMIT limit_in;
        nuerror      := -8;
        BEGIN
            FOR i IN 1..v_array_cartdiaria.count LOOP
                nuproducto           := v_array_cartdiaria(i).nuse;
                sbproductoarreglo    := to_char(nuproducto);
                sbproductoarreglo    := TRIM(sbproductoarreglo);
                nuidreg              := v_array_cartdiaria(i).idre;
                IF v_array_productos_procesa.exists(sbproductoarreglo) THEN
                    nucontaarreglo := nucontaarreglo + 1;
                ELSE
                    v_array_productos_procesa(sbproductoarreglo) := nuidreg;
                    -- Cartera diferida
                    v_deuda_no_corriente := v_array_cartdiaria(i).dedi;
                    -- Obtenemos valores de la cta de cobro
                    nuerror                      := -9;
                    nuedad                       := -1;
                    nuedaddeud                   := -1;
                    nuctasconsaldo               := 0;
                    v_sesusape                   := 0;
                    v_deuda_corriente_no_vencida := 0;
                    nuedad_exacta := 0;
                    FOR g IN cucuentassaldo(nuproducto) LOOP
                        nuedad_exacta  := g.nuedadmora_exacta; -- ht.esantiago solucion caso: 200-2399
                        nuedad         := g.nuedadmora;
                        nuedaddeud     := g.nuedaddeuda;
                        nuctasconsaldo := nuctasconsaldo + 1;
                        v_sesusape     := v_sesusape + g.cucosacu;
                        IF nuedad <= 0 THEN
                            v_deuda_corriente_no_vencida := v_deuda_corriente_no_vencida + g.cucosacu;
                        END IF;
                    END LOOP;
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
                    -- Recuperamos la ultima financiacion
                    nuerror      := -11;
                    nuultre      := NULL;
                    dtultfina    := NULL;
                    dtpenultfina := NULL;
                    nucontaref   := 0;
                    nuerror      := -12;
                    FOR k IN cuultref(nuproducto) LOOP
                        nucontaref := nucontaref + 1;
                        IF nucontaref = 1 THEN
                            nuultre       := k.plan_financiacion;
                            dtultfina     := k.fecha_ingreso;
                        ELSIF nucontaref = 2 THEN
                            dtpenultfina := k.fecha_ingreso;
                        END IF;
                    END LOOP;
                    nuerror      := -13;
                    -- Cantidad de refinanciaciones en el ultimo a?o
                    nucantidadrefultano := NULL;
                    SELECT COUNT(DISTINCT(difecofi)) INTO nucantidadrefultano
                    FROM open.diferido xd
                    WHERE xd.difenuse = nuproducto
                    AND xd.difefein BETWEEN dtvarfechaini AND dtvarfechafin
                    AND xd.difeprog = 'GCNED';
                    -- Recuperamos la lectura actual y anterior del producto
                    nuerror      := -14;
                    nuLecturaActual   := fnuObtenerLectActual(nuproducto);
                    nuLecturaAnterior := fnuObtenerLectAnterior(nuproducto);
                    -- Consulta valor castigado
                    IF v_array_cartdiaria(i).esfi = 'C' THEN
                        nuvalorcast := gc_bodebtmanagement.fnugetpunidebtbyprod(nuproducto);
                    ELSE
                        nuvalorcast := null;
                    END IF;
                    -- Guardamos el registro
                    nuerror      := -15;
                    INSERT INTO ldc_cartdiaria_tmp8
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
                        EDAD_MORA_EXACTA,
                        VALOR_CASTIGADO
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
                        nuedad_exacta,
                        nuvalorcast
                    );
                    nucontaarreglo := nucontaarreglo + 1;
                END IF;
                IF TRIM(sbinsactu) IN('A','a') THEN
                    v_array_usuatuali(nucontaarreglo).idregistro := nuidreg;
                END IF;
            END LOOP;
            COMMIT;
        END;
        EXIT WHEN cu_productos%NOTFOUND;
        nuerror      := -11;
    END LOOP;
    CLOSE cu_productos;
    -- Borramos los datos de ldc_cartdiaria e insertamos los datos de la tablas temporales ldc_cartdiaria_tmp
    DELETE ldc_cartdiaria cd WHERE cd.producto IN(SELECT cdt.producto FROM ldc_cartdiaria_tmp8 cdt);
    INSERT INTO ldc_cartdiaria(SELECT * FROM ldc_cartdiaria_tmp8);
    UPDATE ldc_esprocardiaria fg
    SET fg.total_reg_proc8 = fg.total_reg_proc8 + nucontaarreglo
    WHERE fg.nusession = nutvasess
    AND fg.estado = 'N';
    IF TRIM(sbinsactu) IN('A','a') THEN
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
    sbmensa := 'Proceso termino Ok. Se procesaron : '||to_char(nucontaarreglo)||' resgistros. '||sbobservaprob||' '||nucantle;
    dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_8',2);
    COMMIT;
    ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H8','Termino oK.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_8',0);
        COMMIT;
        error   := -1;
        sbmensa := sbobservaprob||' '||to_char(error)||' Error en ldc_cartlinea..lineas error '||to_char(nuerror)||' producto ' || nuproducto || ' ' || sqlerrm;
        ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H8','Termino con error.');
END ldc_proccartlinea_h8;
PROCEDURE ldc_proccartlinea_h9 IS
/********************************************************************************************
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
    20/12/2022      jcatuchemvm     OSF-747: Ajuste reporte BACADI, agregando calculo para VALOR_CASTIGADO
    14/08/2013      John Jairo Jim  Creacion
***********************************************************************************************/
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
                                     ,idre ldc_usuarios_actualiza_cl.idregistro%TYPE
                                     );

    TYPE t_array_cartdiaria IS TABLE OF array_cartdiaria;
    TYPE t_actusuarios IS TABLE OF ldc_usuarios_actualiza_cl%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE t_array_productos_procesa IS TABLE OF pr_product.product_id%TYPE INDEX BY VARCHAR2(15);
    v_array_cartdiaria t_array_cartdiaria;
    v_array_usuatuali  t_actusuarios;
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
    /* ht.esantiago solucion caso: 200-2399
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
      ORDER BY cucofeve DESC;*/

    CURSOR cucuentassaldo(nuproductocta NUMBER) IS
     SELECT cucocodi
           ,cucofeve
           ,trunc(SYSDATE) - trunc(cucofeve) nuedadmora_exacta
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
    sbmensa                      VARCHAR2(4000);
    error                        NUMBER;
    nuultre                      cc_financing_request.financing_plan_id%TYPE;
    dtultfina                    mo_packages.attention_date%TYPE;
    dtpenultfina                 mo_packages.attention_date%TYPE;
    nucontaref                   NUMBER(5) DEFAULT 0;
    v_deuda_corriente_no_vencida NUMBER(15,3);
    l_cursor                     NUMBER;
    cu_productos                 SYS_REFCURSOR;
    sbcursorproce                VARCHAR2(22000);
    sbobservaprob                VARCHAR2(100);
    nucontaarreglo               NUMBER(10) DEFAULT 0;
    nuidreg                      ldc_usuarios_actualiza_cl.idregistro%TYPE;
    nucontadelete                NUMBER(10) DEFAULT 0;
    nucantidadrefultano          NUMBER(10);
    dtvarfechaini                DATE;
    dtvarfechafin                DATE;
    nuvalor_ejecuta              ld_parameter.numeric_value%TYPE;
    sbinsactu                    VARCHAR2(2);
    l_return                     NUMBER;
    nucantle                     NUMBER;
    sbproductoarreglo            VARCHAR2(15);
    nuedad_exacta                NUMBER(5);
    nuvalorcast                  NUMBER(13,2);
BEGIN
    -- Validamos que el proceso no este en ejecucion
    nuerror := -1;
    nuvalor_ejecuta := pkg_bcld_parameter.fnuobtienevalornumerico('EJECUTA_CARTLINEA_9');
    IF nuvalor_ejecuta <> 0 THEN
        RETURN;
    ELSE
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_9',1);
        COMMIT;
    END IF;
    nuerror := -2;
    FOR ids IN cudatossesion LOOP
        nupkvaano := ids.ano;
        nupkvames := ids.mes;
        nutvasess := ids.sesion;
        sbvaruser := ids.usuario_conectado;
        dtvardia  := ids.dia;
    END LOOP;
    nuerror := -3;
    ldc_proinsertaestaprog(nupkvaano,nupkvames,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H9','En ejecucion',nutvasess,sbvaruser);
    nuerror := -4;
    dtvarfechaini  := to_date(to_char(add_months(SYSDATE,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
    dtvarfechafin  := to_date(to_char(SYSDATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');
    nuerror        := -5;
    dtdia          := trunc(dtvardia);
    sbinsactu      := pkg_bcld_parameter.fsbobtienevalorcadena('ACT_O_INS_CARTERA_LINEA');
    IF TRIM(sbinsactu) IN('I','i') THEN
        sbobservaprob := 'NULL';
        sbcursorproce := 'SELECT
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
                         ,-1 AS idreg
                     FROM
                          open.servsusc      s
                         ,open.suscripc      u
                         ,open.pr_product    p
                         ,open.ab_address    d
                         ,ge_geogra_location l
                    WHERE s.sesususc = u.susccodi
                      AND s.sesunuse = p.product_id
                      AND u.susccodi = p.subscription_id
                      AND p.address_id = d.address_id
                      AND d.geograp_location_id = l.geograp_location_id
                      AND mod(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 9';
    ELSE
        sbobservaprob := '[ACTUALIZA]';
        sbcursorproce := ' SELECT
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
                          ,c.idregistro
                     FROM
                           open.servsusc      s
                          ,open.suscripc      u
                          ,open.pr_product    p
                          ,open.ab_address    d
                          ,ge_geogra_location l
                          ,ldc_usuarios_actualiza_cl c
                     WHERE s.sesususc                                                            = u.susccodi
                       AND s.sesunuse                                                            = p.product_id
                       AND u.susccodi                                                            = p.subscription_id
                       AND p.address_id                                                          = d.address_id
                       AND d.geograp_location_id                                                 = l.geograp_location_id
                       AND s.sesunuse                                                            = c.producto
                       AND p.product_id                                                          = c.producto
                       AND MOD(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 9';
    END IF;
    -- Se adiciona al log de procesos
    nuerror := -6;
    limit_in := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CANTIDAD_REG_GUARDAR');
    -- Borramos datos de la tabla temporal
    pkg_truncate_tablas_open.prcldc_cartdiara_tmp9;

    -- Recorremos cursor
    nuerror        := -7;
    l_cursor       := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor,TRIM(sbcursorproce),dbms_sql.native);
    l_return       := dbms_sql.execute(l_cursor);
    nucantle       := l_return;
    cu_productos   := dbms_sql.to_refcursor(l_cursor);
    nucontaarreglo := 0;
    LOOP
        FETCH cu_productos BULK COLLECT INTO v_array_cartdiaria LIMIT limit_in;
        nuerror      := -8;
        BEGIN
            FOR i IN 1..v_array_cartdiaria.count LOOP
                nuproducto           := v_array_cartdiaria(i).nuse;
                sbproductoarreglo    := to_char(nuproducto);
                sbproductoarreglo    := TRIM(sbproductoarreglo);
                nuidreg              := v_array_cartdiaria(i).idre;
                IF v_array_productos_procesa.exists(sbproductoarreglo) THEN
                    nucontaarreglo := nucontaarreglo + 1;
                ELSE
                    v_array_productos_procesa(sbproductoarreglo) := nuidreg;
                    -- Cartera diferida
                    v_deuda_no_corriente := v_array_cartdiaria(i).dedi;
                    -- Obtenemos valores de la cta de cobro
                    nuerror                      := -9;
                    nuedad                       := -1;
                    nuedaddeud                   := -1;
                    nuctasconsaldo               := 0;
                    v_sesusape                   := 0;
                    v_deuda_corriente_no_vencida := 0;
                    nuedad_exacta := 0;
                    FOR g IN cucuentassaldo(nuproducto) LOOP
                        nuedad_exacta  := g.nuedadmora_exacta; -- ht.esantiago solucion caso: 200-2399
                        nuedad         := g.nuedadmora;
                        nuedaddeud     := g.nuedaddeuda;
                        nuctasconsaldo := nuctasconsaldo + 1;
                        v_sesusape     := v_sesusape + g.cucosacu;
                        IF nuedad <= 0 THEN
                            v_deuda_corriente_no_vencida := v_deuda_corriente_no_vencida + g.cucosacu;
                        END IF;
                    END LOOP;
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
                    -- Recuperamos la ultima financiacion
                    nuerror      := -11;
                    nuultre      := NULL;
                    dtultfina    := NULL;
                    dtpenultfina := NULL;
                    nucontaref   := 0;
                    nuerror      := -12;
                    FOR k IN cuultref(nuproducto) LOOP
                        nucontaref := nucontaref + 1;
                        IF nucontaref = 1 THEN
                            nuultre       := k.plan_financiacion;
                            dtultfina     := k.fecha_ingreso;
                        ELSIF nucontaref = 2 THEN
                            dtpenultfina := k.fecha_ingreso;
                        END IF;
                    END LOOP;
                    nuerror      := -13;
                    -- Cantidad de refinanciaciones en el ultimo a?o
                    nucantidadrefultano := NULL;
                    SELECT COUNT(DISTINCT(difecofi)) INTO nucantidadrefultano
                    FROM open.diferido xd
                    WHERE xd.difenuse = nuproducto
                    AND xd.difefein BETWEEN dtvarfechaini AND dtvarfechafin
                    AND xd.difeprog = 'GCNED';
                    -- Recuperamos la lectura actual y anterior del producto
                    nuerror      := -14;
                    nuLecturaActual   := fnuObtenerLectActual(nuproducto);
                    nuLecturaAnterior := fnuObtenerLectAnterior(nuproducto);
                    -- Consulta valor castigado
                    IF v_array_cartdiaria(i).esfi = 'C' THEN
                        nuvalorcast := gc_bodebtmanagement.fnugetpunidebtbyprod(nuproducto);
                    ELSE
                        nuvalorcast := null;
                    END IF;
                    -- Guardamos el registro
                    nuerror      := -15;
                    INSERT INTO ldc_cartdiaria_tmp9
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
                        EDAD_MORA_EXACTA,
                        VALOR_CASTIGADO
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
                        nuedad_exacta,
                        nuvalorcast
                    );
                    nucontaarreglo := nucontaarreglo + 1;
                END IF;
                IF TRIM(sbinsactu) IN('A','a') THEN
                    v_array_usuatuali(nucontaarreglo).idregistro := nuidreg;
                END IF;
            END LOOP;
            COMMIT;
        END;
        EXIT WHEN cu_productos%NOTFOUND;
        nuerror      := -11;
    END LOOP;
    CLOSE cu_productos;
    -- Borramos los datos de ldc_cartdiaria e insertamos los datos de la tablas temporales ldc_cartdiaria_tmp
    DELETE ldc_cartdiaria cd WHERE cd.producto IN(SELECT cdt.producto FROM ldc_cartdiaria_tmp9 cdt);
    INSERT INTO ldc_cartdiaria(SELECT * FROM ldc_cartdiaria_tmp9);
    UPDATE ldc_esprocardiaria fg
    SET fg.total_reg_proc9 = fg.total_reg_proc9 + nucontaarreglo
    WHERE fg.nusession = nutvasess
    AND fg.estado = 'N';
    IF TRIM(sbinsactu) IN('A','a') THEN
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
    sbmensa := 'Proceso termino Ok. Se procesaron : '||to_char(nucontaarreglo)||' resgistros. '||sbobservaprob||' '||nucantle;
    dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_9',2);
    COMMIT;
    ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H9','Termino oK.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_9',0);
        COMMIT;
        error   := -1;
        sbmensa := sbobservaprob||' '||to_char(error)||' Error en ldc_cartlinea..lineas error '||to_char(nuerror)||' producto ' || nuproducto || ' ' || sqlerrm;
        ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H9','Termino con error.');
END ldc_proccartlinea_h9;
PROCEDURE ldc_proccartlinea_h10 IS
/********************************************************************************************
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
    20/12/2022      jcatuchemvm     OSF-747: Ajuste reporte BACADI, agregando calculo para VALOR_CASTIGADO
    14/08/2013      John Jairo Jim  Creacion
***********************************************************************************************/
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
                                     ,idre ldc_usuarios_actualiza_cl.idregistro%TYPE
                                     );

    TYPE t_array_cartdiaria IS TABLE OF array_cartdiaria;
    TYPE t_actusuarios IS TABLE OF ldc_usuarios_actualiza_cl%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE t_array_productos_procesa IS TABLE OF pr_product.product_id%TYPE INDEX BY VARCHAR2(15);
    v_array_cartdiaria t_array_cartdiaria;
    v_array_usuatuali  t_actusuarios;
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
    /* ht.esantiago solucion caso: 200-2399
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
      ORDER BY cucofeve DESC;*/

    CURSOR cucuentassaldo(nuproductocta NUMBER) IS
     SELECT cucocodi
           ,cucofeve
           ,trunc(SYSDATE) - trunc(cucofeve) nuedadmora_exacta
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
    sbmensa                      VARCHAR2(4000);
    error                        NUMBER;
    nuultre                      cc_financing_request.financing_plan_id%TYPE;
    dtultfina                    mo_packages.attention_date%TYPE;
    dtpenultfina                 mo_packages.attention_date%TYPE;
    nucontaref                   NUMBER(5) DEFAULT 0;
    v_deuda_corriente_no_vencida NUMBER(15,3);
    l_cursor                     NUMBER;
    cu_productos                 SYS_REFCURSOR;
    sbcursorproce                VARCHAR2(22000);
    sbobservaprob                VARCHAR2(100);
    nucontaarreglo               NUMBER(10) DEFAULT 0;
    nuidreg                      ldc_usuarios_actualiza_cl.idregistro%TYPE;
    nucontadelete                NUMBER(10) DEFAULT 0;
    nucantidadrefultano          NUMBER(10);
    dtvarfechaini                DATE;
    dtvarfechafin                DATE;
    nuvalor_ejecuta              ld_parameter.numeric_value%TYPE;
    sbinsactu                    VARCHAR2(2);
    l_return                     NUMBER;
    nucantle                     NUMBER;
    sbproductoarreglo            VARCHAR2(15);
    nuedad_exacta                NUMBER(5);
    nuvalorcast                  NUMBER(13,2);
BEGIN
    -- Validamos que el proceso no este en ejecucion
    nuerror := -1;
    nuvalor_ejecuta := pkg_bcld_parameter.fnuobtienevalornumerico('EJECUTA_CARTLINEA_10');
    IF nuvalor_ejecuta <> 0 THEN
        RETURN;
    ELSE
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_10',1);
        COMMIT;
    END IF;
    nuerror := -2;
    FOR ids IN cudatossesion LOOP
        nupkvaano := ids.ano;
        nupkvames := ids.mes;
        nutvasess := ids.sesion;
        sbvaruser := ids.usuario_conectado;
        dtvardia  := ids.dia;
    END LOOP;
    nuerror := -3;
    ldc_proinsertaestaprog(nupkvaano,nupkvames,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H10','En ejecucion',nutvasess,sbvaruser);
    nuerror := -4;
    dtvarfechaini  := to_date(to_char(add_months(SYSDATE,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
    dtvarfechafin  := to_date(to_char(SYSDATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');
    nuerror        := -5;
    dtdia          := trunc(dtvardia);
    sbinsactu      := pkg_bcld_parameter.fsbobtienevalorcadena('ACT_O_INS_CARTERA_LINEA');
    IF TRIM(sbinsactu) IN('I','i') THEN
        sbobservaprob := 'NULL';
        sbcursorproce := 'SELECT
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
                         ,-1 AS idreg
                     FROM
                          open.servsusc      s
                         ,open.suscripc      u
                         ,open.pr_product    p
                         ,open.ab_address    d
                         ,ge_geogra_location l
                    WHERE s.sesususc = u.susccodi
                      AND s.sesunuse = p.product_id
                      AND u.susccodi = p.subscription_id
                      AND p.address_id = d.address_id
                      AND d.geograp_location_id = l.geograp_location_id
                      AND mod(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 10';
    ELSE
        sbobservaprob := '[ACTUALIZA]';
        sbcursorproce := ' SELECT
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
                          ,c.idregistro
                     FROM
                           open.servsusc      s
                          ,open.suscripc      u
                          ,open.pr_product    p
                          ,open.ab_address    d
                          ,ge_geogra_location l
                          ,ldc_usuarios_actualiza_cl c
                     WHERE s.sesususc                                                            = u.susccodi
                       AND s.sesunuse                                                            = p.product_id
                       AND u.susccodi                                                            = p.subscription_id
                       AND p.address_id                                                          = d.address_id
                       AND d.geograp_location_id                                                 = l.geograp_location_id
                       AND s.sesunuse                                                            = c.producto
                       AND p.product_id                                                          = c.producto
                       AND MOD(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 10';
    END IF;
    -- Se adiciona al log de procesos
    nuerror := -6;
    limit_in := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CANTIDAD_REG_GUARDAR');
    -- Borramos datos de la tabla temporal
    pkg_truncate_tablas_open.prcldc_cartdiara_tmp10;

    -- Recorremos cursor
    nuerror        := -7;
    l_cursor       := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor,TRIM(sbcursorproce),dbms_sql.native);
    l_return       := dbms_sql.execute(l_cursor);
    nucantle       := l_return;
    cu_productos   := dbms_sql.to_refcursor(l_cursor);
    nucontaarreglo := 0;
    LOOP
        FETCH cu_productos BULK COLLECT INTO v_array_cartdiaria LIMIT limit_in;
        nuerror      := -8;
        BEGIN
            FOR i IN 1..v_array_cartdiaria.count LOOP
                nuproducto           := v_array_cartdiaria(i).nuse;
                sbproductoarreglo    := to_char(nuproducto);
                sbproductoarreglo    := TRIM(sbproductoarreglo);
                nuidreg              := v_array_cartdiaria(i).idre;
                IF v_array_productos_procesa.exists(sbproductoarreglo) THEN
                    nucontaarreglo := nucontaarreglo + 1;
                ELSE
                    v_array_productos_procesa(sbproductoarreglo) := nuidreg;
                    -- Cartera diferida
                    v_deuda_no_corriente := v_array_cartdiaria(i).dedi;
                    -- Obtenemos valores de la cta de cobro
                    nuerror                      := -9;
                    nuedad                       := -1;
                    nuedaddeud                   := -1;
                    nuctasconsaldo               := 0;
                    v_sesusape                   := 0;
                    v_deuda_corriente_no_vencida := 0;
                    nuedad_exacta := 0;
                    FOR g IN cucuentassaldo(nuproducto) LOOP
                        nuedad_exacta  := g.nuedadmora_exacta; -- ht.esantiago solucion caso: 200-2399
                        nuedad         := g.nuedadmora;
                        nuedaddeud     := g.nuedaddeuda;
                        nuctasconsaldo := nuctasconsaldo + 1;
                        v_sesusape     := v_sesusape + g.cucosacu;
                        IF nuedad <= 0 THEN
                            v_deuda_corriente_no_vencida := v_deuda_corriente_no_vencida + g.cucosacu;
                        END IF;
                    END LOOP;
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
                    -- Recuperamos la ultima financiacion
                    nuerror      := -11;
                    nuultre      := NULL;
                    dtultfina    := NULL;
                    dtpenultfina := NULL;
                    nucontaref   := 0;
                    nuerror      := -12;
                    FOR k IN cuultref(nuproducto) LOOP
                        nucontaref := nucontaref + 1;
                        IF nucontaref = 1 THEN
                            nuultre       := k.plan_financiacion;
                            dtultfina     := k.fecha_ingreso;
                        ELSIF nucontaref = 2 THEN
                            dtpenultfina := k.fecha_ingreso;
                        END IF;
                    END LOOP;
                    nuerror      := -13;
                    -- Cantidad de refinanciaciones en el ultimo a?o
                    nucantidadrefultano := NULL;
                    SELECT COUNT(DISTINCT(difecofi)) INTO nucantidadrefultano
                    FROM open.diferido xd
                    WHERE xd.difenuse = nuproducto
                    AND xd.difefein BETWEEN dtvarfechaini AND dtvarfechafin
                    AND xd.difeprog = 'GCNED';
                    -- Recuperamos la lectura actual y anterior del producto
                    nuerror      := -14;
                    nuLecturaActual   := fnuObtenerLectActual(nuproducto);
                    nuLecturaAnterior := fnuObtenerLectAnterior(nuproducto);
                    -- Consulta valor castigado
                    IF v_array_cartdiaria(i).esfi = 'C' THEN
                        nuvalorcast := gc_bodebtmanagement.fnugetpunidebtbyprod(nuproducto);
                    ELSE
                        nuvalorcast := null;
                    END IF;
                    -- Guardamos el registro
                    nuerror      := -15;
                    INSERT INTO ldc_cartdiaria_tmp10
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
                        EDAD_MORA_EXACTA,
                        VALOR_CASTIGADO
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
                        nuedad_exacta,
                        nuvalorcast
                    );
                    nucontaarreglo := nucontaarreglo + 1;
                END IF;
                IF TRIM(sbinsactu) IN('A','a') THEN
                    v_array_usuatuali(nucontaarreglo).idregistro := nuidreg;
                END IF;
            END LOOP;
            COMMIT;
        END;
        EXIT WHEN cu_productos%NOTFOUND;
        nuerror      := -11;
    END LOOP;
    CLOSE cu_productos;
    -- Borramos los datos de ldc_cartdiaria e insertamos los datos de la tablas temporales ldc_cartdiaria_tmp
    DELETE ldc_cartdiaria cd WHERE cd.producto IN(SELECT cdt.producto FROM ldc_cartdiaria_tmp10 cdt);
    INSERT INTO ldc_cartdiaria(SELECT * FROM ldc_cartdiaria_tmp10);
    UPDATE ldc_esprocardiaria fg
    SET fg.total_reg_proc10 = fg.total_reg_proc10 + nucontaarreglo
    WHERE fg.nusession = nutvasess
    AND fg.estado = 'N';
    IF TRIM(sbinsactu) IN('A','a') THEN
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
    sbmensa := 'Proceso termino Ok. Se procesaron : '||to_char(nucontaarreglo)||' resgistros. '||sbobservaprob||' '||nucantle;
    dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_10',2);
    COMMIT;
    ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H10','Termino oK.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_10',0);
        COMMIT;
        error   := -1;
        sbmensa := sbobservaprob||' '||to_char(error)||' Error en ldc_cartlinea..lineas error '||to_char(nuerror)||' producto ' || nuproducto || ' ' || sqlerrm;
        ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H10','Termino con error.');
END ldc_proccartlinea_h10;
PROCEDURE ldc_proccartlinea_h11 IS
/********************************************************************************************
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
    20/12/2022      jcatuchemvm     OSF-747: Ajuste reporte BACADI, agregando calculo para VALOR_CASTIGADO
    14/08/2013      John Jairo Jim  Creacion
***********************************************************************************************/
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
                                     ,idre ldc_usuarios_actualiza_cl.idregistro%TYPE
                                     );

    TYPE t_array_cartdiaria IS TABLE OF array_cartdiaria;
    TYPE t_actusuarios IS TABLE OF ldc_usuarios_actualiza_cl%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE t_array_productos_procesa IS TABLE OF pr_product.product_id%TYPE INDEX BY VARCHAR2(15);
    v_array_cartdiaria t_array_cartdiaria;
    v_array_usuatuali  t_actusuarios;
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
    /* ht.esantiago solucion caso: 200-2399
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
      ORDER BY cucofeve DESC;*/

    CURSOR cucuentassaldo(nuproductocta NUMBER) IS
     SELECT cucocodi
           ,cucofeve
           ,trunc(SYSDATE) - trunc(cucofeve) nuedadmora_exacta
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
    sbmensa                      VARCHAR2(4000);
    error                        NUMBER;
    nuultre                      cc_financing_request.financing_plan_id%TYPE;
    dtultfina                    mo_packages.attention_date%TYPE;
    dtpenultfina                 mo_packages.attention_date%TYPE;
    nucontaref                   NUMBER(5) DEFAULT 0;
    v_deuda_corriente_no_vencida NUMBER(15,3);
    l_cursor                     NUMBER;
    cu_productos                 SYS_REFCURSOR;
    sbcursorproce                VARCHAR2(22000);
    sbobservaprob                VARCHAR2(100);
    nucontaarreglo               NUMBER(10) DEFAULT 0;
    nuidreg                      ldc_usuarios_actualiza_cl.idregistro%TYPE;
    nucontadelete                NUMBER(10) DEFAULT 0;
    nucantidadrefultano          NUMBER(10);
    dtvarfechaini                DATE;
    dtvarfechafin                DATE;
    nuvalor_ejecuta              ld_parameter.numeric_value%TYPE;
    sbinsactu                    VARCHAR2(2);
    l_return                     NUMBER;
    nucantle                     NUMBER;
    sbproductoarreglo            VARCHAR2(15);
    nuedad_exacta                NUMBER(5);
    nuvalorcast                  NUMBER(13,2);
BEGIN
    -- Validamos que el proceso no este en ejecucion
    nuerror := -1;
    nuvalor_ejecuta := pkg_bcld_parameter.fnuobtienevalornumerico('EJECUTA_CARTLINEA_11');
    IF nuvalor_ejecuta <> 0 THEN
        RETURN;
    ELSE
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_11',1);
        COMMIT;
    END IF;
    nuerror := -2;
    FOR ids IN cudatossesion LOOP
        nupkvaano := ids.ano;
        nupkvames := ids.mes;
        nutvasess := ids.sesion;
        sbvaruser := ids.usuario_conectado;
        dtvardia  := ids.dia;
    END LOOP;
    nuerror := -3;
    ldc_proinsertaestaprog(nupkvaano,nupkvames,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H11','En ejecucion',nutvasess,sbvaruser);
    nuerror := -4;
    dtvarfechaini  := to_date(to_char(add_months(SYSDATE,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
    dtvarfechafin  := to_date(to_char(SYSDATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');
    nuerror        := -5;
    dtdia          := trunc(dtvardia);
    sbinsactu      := pkg_bcld_parameter.fsbobtienevalorcadena('ACT_O_INS_CARTERA_LINEA');
    IF TRIM(sbinsactu) IN('I','i') THEN
        sbobservaprob := 'NULL';
        sbcursorproce := 'SELECT
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
                         ,-1 AS idreg
                     FROM
                          open.servsusc      s
                         ,open.suscripc      u
                         ,open.pr_product    p
                         ,open.ab_address    d
                         ,ge_geogra_location l
                    WHERE s.sesususc = u.susccodi
                      AND s.sesunuse = p.product_id
                      AND u.susccodi = p.subscription_id
                      AND p.address_id = d.address_id
                      AND d.geograp_location_id = l.geograp_location_id
                      AND mod(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 11';
    ELSE
        sbobservaprob := '[ACTUALIZA]';
        sbcursorproce := ' SELECT
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
                          ,c.idregistro
                     FROM
                           open.servsusc      s
                          ,open.suscripc      u
                          ,open.pr_product    p
                          ,open.ab_address    d
                          ,ge_geogra_location l
                          ,ldc_usuarios_actualiza_cl c
                     WHERE s.sesususc                                                            = u.susccodi
                       AND s.sesunuse                                                            = p.product_id
                       AND u.susccodi                                                            = p.subscription_id
                       AND p.address_id                                                          = d.address_id
                       AND d.geograp_location_id                                                 = l.geograp_location_id
                       AND s.sesunuse                                                            = c.producto
                       AND p.product_id                                                          = c.producto
                       AND MOD(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 11';
    END IF;
    -- Se adiciona al log de procesos
    nuerror := -6;
    limit_in := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CANTIDAD_REG_GUARDAR');
    -- Borramos datos de la tabla temporal
    pkg_truncate_tablas_open.prcldc_cartdiara_tmp11;

    -- Recorremos cursor
    nuerror        := -7;
    l_cursor       := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor,TRIM(sbcursorproce),dbms_sql.native);
    l_return       := dbms_sql.execute(l_cursor);
    nucantle       := l_return;
    cu_productos   := dbms_sql.to_refcursor(l_cursor);
    nucontaarreglo := 0;
    LOOP
        FETCH cu_productos BULK COLLECT INTO v_array_cartdiaria LIMIT limit_in;
        nuerror      := -8;
        BEGIN
            FOR i IN 1..v_array_cartdiaria.count LOOP
                nuproducto           := v_array_cartdiaria(i).nuse;
                sbproductoarreglo    := to_char(nuproducto);
                sbproductoarreglo    := TRIM(sbproductoarreglo);
                nuidreg              := v_array_cartdiaria(i).idre;
                IF v_array_productos_procesa.exists(sbproductoarreglo) THEN
                    nucontaarreglo := nucontaarreglo + 1;
                ELSE
                    v_array_productos_procesa(sbproductoarreglo) := nuidreg;
                    -- Cartera diferida
                    v_deuda_no_corriente := v_array_cartdiaria(i).dedi;
                    -- Obtenemos valores de la cta de cobro
                    nuerror                      := -9;
                    nuedad                       := -1;
                    nuedaddeud                   := -1;
                    nuctasconsaldo               := 0;
                    v_sesusape                   := 0;
                    v_deuda_corriente_no_vencida := 0;
                    nuedad_exacta := 0;
                    FOR g IN cucuentassaldo(nuproducto) LOOP
                        nuedad_exacta  := g.nuedadmora_exacta; -- ht.esantiago solucion caso: 200-2399
                        nuedad         := g.nuedadmora;
                        nuedaddeud     := g.nuedaddeuda;
                        nuctasconsaldo := nuctasconsaldo + 1;
                        v_sesusape     := v_sesusape + g.cucosacu;
                        IF nuedad <= 0 THEN
                            v_deuda_corriente_no_vencida := v_deuda_corriente_no_vencida + g.cucosacu;
                        END IF;
                    END LOOP;
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
                    -- Recuperamos la ultima financiacion
                    nuerror      := -11;
                    nuultre      := NULL;
                    dtultfina    := NULL;
                    dtpenultfina := NULL;
                    nucontaref   := 0;
                    nuerror      := -12;
                    FOR k IN cuultref(nuproducto) LOOP
                        nucontaref := nucontaref + 1;
                        IF nucontaref = 1 THEN
                            nuultre       := k.plan_financiacion;
                            dtultfina     := k.fecha_ingreso;
                        ELSIF nucontaref = 2 THEN
                            dtpenultfina := k.fecha_ingreso;
                        END IF;
                    END LOOP;
                    nuerror      := -13;
                    -- Cantidad de refinanciaciones en el ultimo a?o
                    nucantidadrefultano := NULL;
                    SELECT COUNT(DISTINCT(difecofi)) INTO nucantidadrefultano
                    FROM open.diferido xd
                    WHERE xd.difenuse = nuproducto
                    AND xd.difefein BETWEEN dtvarfechaini AND dtvarfechafin
                    AND xd.difeprog = 'GCNED';
                    -- Recuperamos la lectura actual y anterior del producto
                    nuerror      := -14;
                    nuLecturaActual   := fnuObtenerLectActual(nuproducto);
                    nuLecturaAnterior := fnuObtenerLectAnterior(nuproducto);
                    -- Consulta valor castigado
                    IF v_array_cartdiaria(i).esfi = 'C' THEN
                        nuvalorcast := gc_bodebtmanagement.fnugetpunidebtbyprod(nuproducto);
                    ELSE
                        nuvalorcast := null;
                    END IF;
                    -- Guardamos el registro
                    nuerror      := -15;
                    INSERT INTO ldc_cartdiaria_tmp11
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
                        EDAD_MORA_EXACTA,
                        VALOR_CASTIGADO
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
                        nuedad_exacta,
                        nuvalorcast
                    );
                    nucontaarreglo := nucontaarreglo + 1;
                END IF;
                IF TRIM(sbinsactu) IN('A','a') THEN
                    v_array_usuatuali(nucontaarreglo).idregistro := nuidreg;
                END IF;
            END LOOP;
            COMMIT;
        END;
        EXIT WHEN cu_productos%NOTFOUND;
        nuerror      := -11;
    END LOOP;
    CLOSE cu_productos;
    -- Borramos los datos de ldc_cartdiaria e insertamos los datos de la tablas temporales ldc_cartdiaria_tmp
    DELETE ldc_cartdiaria cd WHERE cd.producto IN(SELECT cdt.producto FROM ldc_cartdiaria_tmp11 cdt);
    INSERT INTO ldc_cartdiaria(SELECT * FROM ldc_cartdiaria_tmp11);
    UPDATE ldc_esprocardiaria fg
    SET fg.total_reg_proc11 = fg.total_reg_proc11 + nucontaarreglo
    WHERE fg.nusession = nutvasess
    AND fg.estado = 'N';
    IF TRIM(sbinsactu) IN('A','a') THEN
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
    sbmensa := 'Proceso termino Ok. Se procesaron : '||to_char(nucontaarreglo)||' resgistros. '||sbobservaprob||' '||nucantle;
    dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_11',2);
    COMMIT;
    ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H11','Termino oK.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_11',0);
        COMMIT;
        error   := -1;
        sbmensa := sbobservaprob||' '||to_char(error)||' Error en ldc_cartlinea..lineas error '||to_char(nuerror)||' producto ' || nuproducto || ' ' || sqlerrm;
        ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H11','Termino con error.');
END ldc_proccartlinea_h11;
PROCEDURE ldc_proccartlinea_h12 IS
/********************************************************************************************
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
    20/12/2022      jcatuchemvm     OSF-747: Ajuste reporte BACADI, agregando calculo para VALOR_CASTIGADO
    14/08/2013      John Jairo Jim  Creacion
***********************************************************************************************/
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
                                     ,idre ldc_usuarios_actualiza_cl.idregistro%TYPE
                                     );

    TYPE t_array_cartdiaria IS TABLE OF array_cartdiaria;
    TYPE t_actusuarios IS TABLE OF ldc_usuarios_actualiza_cl%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE t_array_productos_procesa IS TABLE OF pr_product.product_id%TYPE INDEX BY VARCHAR2(15);
    v_array_cartdiaria t_array_cartdiaria;
    v_array_usuatuali  t_actusuarios;
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
    /* ht.esantiago solucion caso: 200-2399
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
      ORDER BY cucofeve DESC;*/

    CURSOR cucuentassaldo(nuproductocta NUMBER) IS
     SELECT cucocodi
           ,cucofeve
           ,trunc(SYSDATE) - trunc(cucofeve) nuedadmora_exacta
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
    sbmensa                      VARCHAR2(4000);
    error                        NUMBER;
    nuultre                      cc_financing_request.financing_plan_id%TYPE;
    dtultfina                    mo_packages.attention_date%TYPE;
    dtpenultfina                 mo_packages.attention_date%TYPE;
    nucontaref                   NUMBER(5) DEFAULT 0;
    v_deuda_corriente_no_vencida NUMBER(15,3);
    l_cursor                     NUMBER;
    cu_productos                 SYS_REFCURSOR;
    sbcursorproce                VARCHAR2(22000);
    sbobservaprob                VARCHAR2(100);
    nucontaarreglo               NUMBER(10) DEFAULT 0;
    nuidreg                      ldc_usuarios_actualiza_cl.idregistro%TYPE;
    nucontadelete                NUMBER(10) DEFAULT 0;
    nucantidadrefultano          NUMBER(10);
    dtvarfechaini                DATE;
    dtvarfechafin                DATE;
    nuvalor_ejecuta              ld_parameter.numeric_value%TYPE;
    sbinsactu                    VARCHAR2(2);
    l_return                     NUMBER;
    nucantle                     NUMBER;
    sbproductoarreglo            VARCHAR2(15);
    nuedad_exacta                NUMBER(5);
    nuvalorcast                  NUMBER(13,2);
BEGIN
    -- Validamos que el proceso no este en ejecucion
    nuerror := -1;
    nuvalor_ejecuta := pkg_bcld_parameter.fnuobtienevalornumerico('EJECUTA_CARTLINEA_12');
    IF nuvalor_ejecuta <> 0 THEN
        RETURN;
    ELSE
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_12',1);
        COMMIT;
    END IF;
    nuerror := -2;
    FOR ids IN cudatossesion LOOP
        nupkvaano := ids.ano;
        nupkvames := ids.mes;
        nutvasess := ids.sesion;
        sbvaruser := ids.usuario_conectado;
        dtvardia  := ids.dia;
    END LOOP;
    nuerror := -3;
    ldc_proinsertaestaprog(nupkvaano,nupkvames,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H12','En ejecucion',nutvasess,sbvaruser);
    nuerror := -4;
    dtvarfechaini  := to_date(to_char(add_months(SYSDATE,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
    dtvarfechafin  := to_date(to_char(SYSDATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');
    nuerror        := -5;
    dtdia          := trunc(dtvardia);
    sbinsactu      := pkg_bcld_parameter.fsbobtienevalorcadena('ACT_O_INS_CARTERA_LINEA');
    IF TRIM(sbinsactu) IN('I','i') THEN
        sbobservaprob := 'NULL';
        sbcursorproce := 'SELECT
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
                         ,-1 AS idreg
                     FROM
                          open.servsusc      s
                         ,open.suscripc      u
                         ,open.pr_product    p
                         ,open.ab_address    d
                         ,ge_geogra_location l
                    WHERE s.sesususc = u.susccodi
                      AND s.sesunuse = p.product_id
                      AND u.susccodi = p.subscription_id
                      AND p.address_id = d.address_id
                      AND d.geograp_location_id = l.geograp_location_id
                      AND mod(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 12';
    ELSE
        sbobservaprob := '[ACTUALIZA]';
        sbcursorproce := ' SELECT
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
                          ,c.idregistro
                     FROM
                           open.servsusc      s
                          ,open.suscripc      u
                          ,open.pr_product    p
                          ,open.ab_address    d
                          ,ge_geogra_location l
                          ,ldc_usuarios_actualiza_cl c
                     WHERE s.sesususc                                                            = u.susccodi
                       AND s.sesunuse                                                            = p.product_id
                       AND u.susccodi                                                            = p.subscription_id
                       AND p.address_id                                                          = d.address_id
                       AND d.geograp_location_id                                                 = l.geograp_location_id
                       AND s.sesunuse                                                            = c.producto
                       AND p.product_id                                                          = c.producto
                       AND MOD(sesunuse,pkg_bcld_parameter.fnuobtienevalornumerico(''HILOS_CARTDIARIA''))+ 1 = 12';
    END IF;
    -- Se adiciona al log de procesos
    nuerror := -6;
    limit_in := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CANTIDAD_REG_GUARDAR');
    -- Borramos datos de la tabla temporal
    pkg_truncate_tablas_open.prcldc_cartdiara_tmp12;

    -- Recorremos cursor
    nuerror        := -7;
    l_cursor       := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor,TRIM(sbcursorproce),dbms_sql.native);
    l_return       := dbms_sql.execute(l_cursor);
    nucantle       := l_return;
    cu_productos   := dbms_sql.to_refcursor(l_cursor);
    nucontaarreglo := 0;
    LOOP
        FETCH cu_productos BULK COLLECT INTO v_array_cartdiaria LIMIT limit_in;
        nuerror      := -8;
        BEGIN
            FOR i IN 1..v_array_cartdiaria.count LOOP
                nuproducto           := v_array_cartdiaria(i).nuse;
                sbproductoarreglo    := to_char(nuproducto);
                sbproductoarreglo    := TRIM(sbproductoarreglo);
                nuidreg              := v_array_cartdiaria(i).idre;
                IF v_array_productos_procesa.exists(sbproductoarreglo) THEN
                    nucontaarreglo := nucontaarreglo + 1;
                ELSE
                    v_array_productos_procesa(sbproductoarreglo) := nuidreg;
                    -- Cartera diferida
                    v_deuda_no_corriente := v_array_cartdiaria(i).dedi;
                    -- Obtenemos valores de la cta de cobro
                    nuerror                      := -9;
                    nuedad                       := -1;
                    nuedaddeud                   := -1;
                    nuctasconsaldo               := 0;
                    v_sesusape                   := 0;
                    v_deuda_corriente_no_vencida := 0;
                    nuedad_exacta := 0;
                    FOR g IN cucuentassaldo(nuproducto) LOOP
                        nuedad_exacta  := g.nuedadmora_exacta; -- ht.esantiago solucion caso: 200-2399
                        nuedad         := g.nuedadmora;
                        nuedaddeud     := g.nuedaddeuda;
                        nuctasconsaldo := nuctasconsaldo + 1;
                        v_sesusape     := v_sesusape + g.cucosacu;
                        IF nuedad <= 0 THEN
                            v_deuda_corriente_no_vencida := v_deuda_corriente_no_vencida + g.cucosacu;
                        END IF;
                    END LOOP;
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
                    -- Recuperamos la ultima financiacion
                    nuerror      := -11;
                    nuultre      := NULL;
                    dtultfina    := NULL;
                    dtpenultfina := NULL;
                    nucontaref   := 0;
                    nuerror      := -12;
                    FOR k IN cuultref(nuproducto) LOOP
                        nucontaref := nucontaref + 1;
                        IF nucontaref = 1 THEN
                            nuultre       := k.plan_financiacion;
                            dtultfina     := k.fecha_ingreso;
                        ELSIF nucontaref = 2 THEN
                            dtpenultfina := k.fecha_ingreso;
                        END IF;
                    END LOOP;
                    nuerror      := -13;
                    -- Cantidad de refinanciaciones en el ultimo a?o
                    nucantidadrefultano := NULL;
                    SELECT COUNT(DISTINCT(difecofi)) INTO nucantidadrefultano
                    FROM open.diferido xd
                    WHERE xd.difenuse = nuproducto
                    AND xd.difefein BETWEEN dtvarfechaini AND dtvarfechafin
                    AND xd.difeprog = 'GCNED';
                    -- Recuperamos la lectura actual y anterior del producto
                    nuerror      := -14;
                    nuLecturaActual   := fnuObtenerLectActual(nuproducto);
                    nuLecturaAnterior := fnuObtenerLectAnterior(nuproducto);
                    -- Consulta valor castigado
                    IF v_array_cartdiaria(i).esfi = 'C' THEN
                        nuvalorcast := gc_bodebtmanagement.fnugetpunidebtbyprod(nuproducto);
                    ELSE
                        nuvalorcast := null;
                    END IF;
                    -- Guardamos el registro
                    nuerror      := -15;
                    INSERT INTO ldc_cartdiaria_tmp12
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
                        EDAD_MORA_EXACTA,
                        VALOR_CASTIGADO
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
                        nuedad_exacta,
                        nuvalorcast
                    );
                    nucontaarreglo := nucontaarreglo + 1;
                END IF;
                IF TRIM(sbinsactu) IN('A','a') THEN
                    v_array_usuatuali(nucontaarreglo).idregistro := nuidreg;
                END IF;
            END LOOP;
            COMMIT;
        END;
        EXIT WHEN cu_productos%NOTFOUND;
        nuerror      := -11;
    END LOOP;
    CLOSE cu_productos;
    -- Borramos los datos de ldc_cartdiaria e insertamos los datos de la tablas temporales ldc_cartdiaria_tmp
    DELETE ldc_cartdiaria cd WHERE cd.producto IN(SELECT cdt.producto FROM ldc_cartdiaria_tmp12 cdt);
    INSERT INTO ldc_cartdiaria(SELECT * FROM ldc_cartdiaria_tmp12);
    UPDATE ldc_esprocardiaria fg
    SET fg.total_reg_proc12 = fg.total_reg_proc12 + nucontaarreglo
    WHERE fg.nusession = nutvasess
    AND fg.estado = 'N';
    IF TRIM(sbinsactu) IN('A','a') THEN
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
    sbmensa := 'Proceso termino Ok. Se procesaron : '||to_char(nucontaarreglo)||' resgistros. '||sbobservaprob||' '||nucantle;
    dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_12',2);
    COMMIT;
    ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H12','Termino oK.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_12',0);
        COMMIT;
        error   := -1;
        sbmensa := sbobservaprob||' '||to_char(error)||' Error en ldc_cartlinea..lineas error '||to_char(nuerror)||' producto ' || nuproducto || ' ' || sqlerrm;
        ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_H12','Termino con error.');
END ldc_proccartlinea_h12;
PROCEDURE ldc_proc_cart_diari_con_x_ctas(dtpadia DATE,nupanroctas NUMBER,nuerror OUT NUMBER,sberror OUT VARCHAR2) AS

 /*****************

 Historial de modificaciones
   fecha            actor       descripcion
   15/05/2019        ljlb        CA 200-2598 se optimiza proceso de insercion de datos de cartera por concepto
 ******************************************/
 --se consultas los datos de los temporales
 CURSOR cudatos1 IS
 SELECT dtpadia
        ,cont
        ,nuse
        ,concepto
        ,SUM(valor_vencido)
        ,SUM(valor_diferido)
        ,SUM(valor_no_vencido)
   FROM(
        SELECT cont
              ,nuse
              ,concepto
              ,NVL(SUM(valor_vencido),0) valor_vencido
              ,0 valor_diferido
              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
          FROM(
               SELECT cargcuco   cuco
                     ,cucofeve   feve
                     ,d.contrato cont
                     ,cargnuse   nuse
                     ,cargconc   concepto
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                 FROM open.ldc_cartdiaria_tmp d,cuencobr,cargos
                WHERE d.nro_ctas_con_saldo >= nupanroctas
                  AND cucosacu              > 0
                  AND d.producto            = cuconuse
                  AND cucocodi              = cargcuco
                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
              )
      GROUP BY cont
              ,nuse
              ,concepto
  UNION ALL
  SELECT difesusc
         ,difenuse
         ,difeconc
         ,0
         ,difesape
         ,0
      FROM open.ldc_cartdiaria_tmp,open.diferido
     WHERE nro_ctas_con_saldo >= nupanroctas
       AND difesape > 0
       AND producto = difenuse)
  GROUP BY cont,nuse,concepto;

  TYPE tbdatos1 IS TABLE OF cudatos1%ROWTYPE  ;
  v_tbdatos1 tbdatos1;

  --se consultas los datos de los temporales
 CURSOR cudatos2 IS
 SELECT dtpadia
        ,cont
        ,nuse
        ,concepto
        ,SUM(valor_vencido)
        ,SUM(valor_diferido)
        ,SUM(valor_no_vencido)
   FROM(
        SELECT cont
              ,nuse
              ,concepto
              ,NVL(SUM(valor_vencido),0) valor_vencido
              ,0 valor_diferido
              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
          FROM(
               SELECT cargcuco   cuco
                     ,cucofeve   feve
                     ,d.contrato cont
                     ,cargnuse   nuse
                     ,cargconc   concepto
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                 FROM open.ldc_cartdiaria_tmp2 d,cuencobr,cargos
                WHERE d.nro_ctas_con_saldo >= nupanroctas
                  AND cucosacu              > 0
                  AND d.producto            = cuconuse
                  AND cucocodi              = cargcuco
                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
              )
      GROUP BY cont
              ,nuse
              ,concepto
  UNION ALL
    SELECT difesusc
          ,difenuse
          ,difeconc
          ,0
          ,difesape
          ,0
      FROM open.ldc_cartdiaria_tmp2,open.diferido
     WHERE nro_ctas_con_saldo >= nupanroctas
       AND difesape > 0
       AND producto = difenuse)
  GROUP BY cont,nuse,concepto;

  TYPE tbdatos2 IS TABLE OF cudatos2%ROWTYPE  ;
  v_tbdatos2 tbdatos2;

 --se consultas los datos de los temporales
 CURSOR cudatos3 IS
 SELECT dtpadia
        ,cont
        ,nuse
        ,concepto
        ,SUM(valor_vencido)
        ,SUM(valor_diferido)
        ,SUM(valor_no_vencido)
   FROM(
        SELECT cont
              ,nuse
              ,concepto
              ,NVL(SUM(valor_vencido),0) valor_vencido
              ,0 valor_diferido
              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
          FROM(
               SELECT cargcuco   cuco
                     ,cucofeve   feve
                     ,d.contrato cont
                     ,cargnuse   nuse
                     ,cargconc   concepto
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                 FROM open.ldc_cartdiaria_tmp3 d,cuencobr,cargos
                WHERE d.nro_ctas_con_saldo >= nupanroctas
                  AND cucosacu              > 0
                  AND d.producto            = cuconuse
                  AND cucocodi              = cargcuco
                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
              )
      GROUP BY cont
              ,nuse
              ,concepto
  UNION ALL
  SELECT difesusc
        ,difenuse
        ,difeconc
        ,0
        ,difesape
        ,0
    FROM open.ldc_cartdiaria_tmp3,open.diferido
   WHERE nro_ctas_con_saldo >= nupanroctas
     AND difesape > 0
     AND producto = difenuse)
  GROUP BY cont,nuse,concepto;

  TYPE tbdatos3 IS TABLE OF cudatos3%ROWTYPE  ;
  v_tbdatos3 tbdatos3;

   --se consultas los datos de los temporales
 CURSOR cudatos4 IS
 SELECT dtpadia
        ,cont
        ,nuse
        ,concepto
        ,SUM(valor_vencido)
        ,SUM(valor_diferido)
        ,SUM(valor_no_vencido)
   FROM(
        SELECT cont
              ,nuse
              ,concepto
              ,NVL(SUM(valor_vencido),0) valor_vencido
              ,0 valor_diferido
              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
          FROM(
               SELECT cargcuco   cuco
                     ,cucofeve   feve
                     ,d.contrato cont
                     ,cargnuse   nuse
                     ,cargconc   concepto
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                 FROM open.ldc_cartdiaria_tmp4 d,cuencobr,cargos
                WHERE d.nro_ctas_con_saldo >= nupanroctas
                  AND cucosacu              > 0
                  AND d.producto            = cuconuse
                  AND cucocodi              = cargcuco
                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
              )
      GROUP BY cont
              ,nuse
              ,concepto
  UNION ALL
  SELECT difesusc
        ,difenuse
        ,difeconc
        ,0
        ,difesape
        ,0
    FROM open.ldc_cartdiaria_tmp4,open.diferido
   WHERE nro_ctas_con_saldo >= nupanroctas
     AND difesape > 0
     AND producto = difenuse)
  GROUP BY cont,nuse,concepto;

  TYPE tbdatos4 IS TABLE OF cudatos4%ROWTYPE  ;
  v_tbdatos4 tbdatos4;

 --se consultas los datos de los temporales
 CURSOR cudatos5 IS
 SELECT dtpadia
        ,cont
        ,nuse
        ,concepto
        ,SUM(valor_vencido)
        ,SUM(valor_diferido)
        ,SUM(valor_no_vencido)
   FROM(
        SELECT cont
              ,nuse
              ,concepto
              ,NVL(SUM(valor_vencido),0) valor_vencido
              ,0 valor_diferido
              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
          FROM(
               SELECT cargcuco   cuco
                     ,cucofeve   feve
                     ,d.contrato cont
                     ,cargnuse   nuse
                     ,cargconc   concepto
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                 FROM open.ldc_cartdiaria_tmp5 d,cuencobr,cargos
                WHERE d.nro_ctas_con_saldo >= nupanroctas
                  AND cucosacu              > 0
                  AND d.producto            = cuconuse
                  AND cucocodi              = cargcuco
                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
              )
      GROUP BY cont
              ,nuse
              ,concepto
  UNION ALL
  SELECT difesusc
        ,difenuse
        ,difeconc
        ,0
        ,difesape
        ,0
    FROM open.ldc_cartdiaria_tmp5,open.diferido
   WHERE nro_ctas_con_saldo >= nupanroctas
     AND difesape > 0
     AND producto = difenuse)
  GROUP BY cont,nuse,concepto;

  TYPE tbdatos5 IS TABLE OF cudatos5%ROWTYPE  ;
  v_tbdatos5 tbdatos5;

  --se consultas los datos de los temporales
 CURSOR cudatos6 IS
 SELECT dtpadia
        ,cont
        ,nuse
        ,concepto
        ,SUM(valor_vencido)
        ,SUM(valor_diferido)
        ,SUM(valor_no_vencido)
   FROM(
        SELECT cont
              ,nuse
              ,concepto
              ,NVL(SUM(valor_vencido),0) valor_vencido
              ,0 valor_diferido
              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
          FROM(
               SELECT cargcuco   cuco
                     ,cucofeve   feve
                     ,d.contrato cont
                     ,cargnuse   nuse
                     ,cargconc   concepto
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                 FROM open.ldc_cartdiaria_tmp6 d,cuencobr,cargos
                WHERE d.nro_ctas_con_saldo >= nupanroctas
                  AND cucosacu              > 0
                  AND d.producto            = cuconuse
                  AND cucocodi              = cargcuco
                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
              )
      GROUP BY cont
              ,nuse
              ,concepto
  UNION ALL
  SELECT difesusc
        ,difenuse
        ,difeconc
        ,0
        ,difesape
        ,0
    FROM open.ldc_cartdiaria_tmp6,open.diferido
   WHERE nro_ctas_con_saldo >= nupanroctas
     AND difesape > 0
     AND producto = difenuse)
  GROUP BY cont,nuse,concepto;

  TYPE tbdatos6 IS TABLE OF cudatos6%ROWTYPE  ;
  v_tbdatos6 tbdatos6;

  --se consultas los datos de los temporales
 CURSOR cudatos7 IS
 SELECT dtpadia
        ,cont
        ,nuse
        ,concepto
        ,SUM(valor_vencido)
        ,SUM(valor_diferido)
        ,SUM(valor_no_vencido)
   FROM(
        SELECT cont
              ,nuse
              ,concepto
              ,NVL(SUM(valor_vencido),0) valor_vencido
              ,0 valor_diferido
              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
          FROM(
               SELECT cargcuco   cuco
                     ,cucofeve   feve
                     ,d.contrato cont
                     ,cargnuse   nuse
                     ,cargconc   concepto
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                 FROM open.ldc_cartdiaria_tmp7 d,cuencobr,cargos
                WHERE d.nro_ctas_con_saldo >= nupanroctas
                  AND cucosacu              > 0
                  AND d.producto            = cuconuse
                  AND cucocodi              = cargcuco
                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
              )
      GROUP BY cont
              ,nuse
              ,concepto
  UNION ALL
  SELECT difesusc
        ,difenuse
        ,difeconc
        ,0
        ,difesape
        ,0
    FROM open.ldc_cartdiaria_tmp7,open.diferido
   WHERE nro_ctas_con_saldo >= nupanroctas
     AND difesape > 0
     AND producto = difenuse)
  GROUP BY cont,nuse,concepto;

  TYPE tbdatos7 IS TABLE OF cudatos7%ROWTYPE  ;
  v_tbdatos7 tbdatos7;



  CURSOR cudatos8 IS
 SELECT dtpadia
        ,cont
        ,nuse
        ,concepto
        ,SUM(valor_vencido)
        ,SUM(valor_diferido)
        ,SUM(valor_no_vencido)
   FROM(
        SELECT cont
              ,nuse
              ,concepto
              ,NVL(SUM(valor_vencido),0) valor_vencido
              ,0 valor_diferido
              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
          FROM(
               SELECT cargcuco   cuco
                     ,cucofeve   feve
                     ,d.contrato cont
                     ,cargnuse   nuse
                     ,cargconc   concepto
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                 FROM open.ldc_cartdiaria_tmp8 d,cuencobr,cargos
                WHERE d.nro_ctas_con_saldo >= nupanroctas
                  AND cucosacu              > 0
                  AND d.producto            = cuconuse
                  AND cucocodi              = cargcuco
                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
              )
      GROUP BY cont
              ,nuse
              ,concepto
  UNION ALL
  SELECT difesusc
        ,difenuse
        ,difeconc
        ,0
        ,difesape
        ,0
    FROM open.ldc_cartdiaria_tmp8,open.diferido
   WHERE nro_ctas_con_saldo >= nupanroctas
     AND difesape > 0
     AND producto = difenuse)
  GROUP BY cont,nuse,concepto;

  TYPE tbdatos8 IS TABLE OF cudatos8%ROWTYPE  ;
  v_tbdatos8 tbdatos8;

  CURSOR cudatos9 IS
 SELECT dtpadia
        ,cont
        ,nuse
        ,concepto
        ,SUM(valor_vencido)
        ,SUM(valor_diferido)
        ,SUM(valor_no_vencido)
   FROM(
        SELECT cont
              ,nuse
              ,concepto
              ,NVL(SUM(valor_vencido),0) valor_vencido
              ,0 valor_diferido
              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
          FROM(
               SELECT cargcuco   cuco
                     ,cucofeve   feve
                     ,d.contrato cont
                     ,cargnuse   nuse
                     ,cargconc   concepto
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                 FROM open.ldc_cartdiaria_tmp9 d,cuencobr,cargos
                WHERE d.nro_ctas_con_saldo >= nupanroctas
                  AND cucosacu              > 0
                  AND d.producto            = cuconuse
                  AND cucocodi              = cargcuco
                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
              )
      GROUP BY cont
              ,nuse
              ,concepto
  UNION ALL
  SELECT difesusc
        ,difenuse
        ,difeconc
        ,0
        ,difesape
        ,0
    FROM open.ldc_cartdiaria_tmp9,open.diferido
   WHERE nro_ctas_con_saldo >= nupanroctas
     AND difesape > 0
     AND producto = difenuse)
  GROUP BY cont,nuse,concepto;

  TYPE tbdatos9 IS TABLE OF cudatos9%ROWTYPE  ;
  v_tbdatos9 tbdatos9;


  CURSOR cudatos10 IS
 SELECT dtpadia
        ,cont
        ,nuse
        ,concepto
        ,SUM(valor_vencido)
        ,SUM(valor_diferido)
        ,SUM(valor_no_vencido)
   FROM(
        SELECT cont
              ,nuse
              ,concepto
              ,NVL(SUM(valor_vencido),0) valor_vencido
              ,0 valor_diferido
              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
          FROM(
               SELECT cargcuco   cuco
                     ,cucofeve   feve
                     ,d.contrato cont
                     ,cargnuse   nuse
                     ,cargconc   concepto
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                 FROM open.ldc_cartdiaria_tmp10 d,cuencobr,cargos
                WHERE d.nro_ctas_con_saldo >= nupanroctas
                  AND cucosacu              > 0
                  AND d.producto            = cuconuse
                  AND cucocodi              = cargcuco
                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
              )
      GROUP BY cont
              ,nuse
              ,concepto
  UNION ALL
  SELECT difesusc
        ,difenuse
        ,difeconc
        ,0
        ,difesape
        ,0
    FROM open.ldc_cartdiaria_tmp10,open.diferido
   WHERE nro_ctas_con_saldo >= nupanroctas
     AND difesape > 0
     AND producto = difenuse)
  GROUP BY cont,nuse,concepto;

  TYPE tbdatos10 IS TABLE OF cudatos10%ROWTYPE  ;
  v_tbdatos10 tbdatos10;


  CURSOR cudatos11 IS
 SELECT dtpadia
        ,cont
        ,nuse
        ,concepto
        ,SUM(valor_vencido)
        ,SUM(valor_diferido)
        ,SUM(valor_no_vencido)
   FROM(
        SELECT cont
              ,nuse
              ,concepto
              ,NVL(SUM(valor_vencido),0) valor_vencido
              ,0 valor_diferido
              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
          FROM(
               SELECT cargcuco   cuco
                     ,cucofeve   feve
                     ,d.contrato cont
                     ,cargnuse   nuse
                     ,cargconc   concepto
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                 FROM open.ldc_cartdiaria_tmp11 d,cuencobr,cargos
                WHERE d.nro_ctas_con_saldo >= nupanroctas
                  AND cucosacu              > 0
                  AND d.producto            = cuconuse
                  AND cucocodi              = cargcuco
                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
              )
      GROUP BY cont
              ,nuse
              ,concepto
  UNION ALL
  SELECT difesusc
        ,difenuse
        ,difeconc
        ,0
        ,difesape
        ,0
    FROM open.ldc_cartdiaria_tmp11,open.diferido
   WHERE nro_ctas_con_saldo >= nupanroctas
     AND difesape > 0
     AND producto = difenuse)
  GROUP BY cont,nuse,concepto;

  TYPE tbdatos11 IS TABLE OF cudatos11%ROWTYPE  ;
  v_tbdatos11 tbdatos11;



  CURSOR cudatos12 IS
 SELECT dtpadia
        ,cont
        ,nuse
        ,concepto
        ,SUM(valor_vencido)
        ,SUM(valor_diferido)
        ,SUM(valor_no_vencido)
   FROM(
        SELECT cont
              ,nuse
              ,concepto
              ,NVL(SUM(valor_vencido),0) valor_vencido
              ,0 valor_diferido
              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
          FROM(
               SELECT cargcuco   cuco
                     ,cucofeve   feve
                     ,d.contrato cont
                     ,cargnuse   nuse
                     ,cargconc   concepto
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                 FROM open.ldc_cartdiaria_tmp12 d,cuencobr,cargos
                WHERE d.nro_ctas_con_saldo >= nupanroctas
                  AND cucosacu              > 0
                  AND d.producto            = cuconuse
                  AND cucocodi              = cargcuco
                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
              )
      GROUP BY cont
              ,nuse
              ,concepto
  UNION ALL
  SELECT difesusc
        ,difenuse
        ,difeconc
        ,0
        ,difesape
        ,0
    FROM open.ldc_cartdiaria_tmp12,open.diferido
   WHERE nro_ctas_con_saldo >= nupanroctas
     AND difesape > 0
     AND producto = difenuse)
  GROUP BY cont,nuse,concepto;

  TYPE tbdatos12 IS TABLE OF cudatos12%ROWTYPE  ;
  v_tbdatos12 tbdatos12;

BEGIN
 -- Temporal1
    OPEN cudatos1;
    LOOP
      FETCH cudatos1 BULK COLLECT INTO v_tbdatos1 LIMIT 100;
       FORALL i IN 1..v_tbdatos1.COUNT
         INSERT INTO ldc_concepto_diaria VALUES v_tbdatos1(i);
      EXIT WHEN cudatos1%NOTFOUND;
    END LOOP;
    CLOSE cudatos1;

  /* INSERT INTO ldc_concepto_diaria(
                                 SELECT
                                         dtpadia
                                        ,cont
                                        ,nuse
                                        ,concepto
                                        ,SUM(valor_vencido)
                                        ,SUM(valor_diferido)
                                        ,SUM(valor_no_vencido)
                                   FROM(
                                        SELECT cont
                                              ,nuse
                                              ,concepto
                                              ,NVL(SUM(valor_vencido),0) valor_vencido
                                              ,0 valor_diferido
                                              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
                                          FROM(
                                               SELECT cargcuco   cuco
                                                     ,cucofeve   feve
                                                     ,d.contrato cont
                                                     ,cargnuse   nuse
                                                     ,cargconc   concepto
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                                                 FROM open.ldc_cartdiaria_tmp d,cuencobr,cargos
                                                WHERE d.nro_ctas_con_saldo >= nupanroctas
                                                  AND cucosacu              > 0
                                                  AND d.producto            = cuconuse
                                                  AND cucocodi              = cargcuco
                                                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
                                              )
                                      GROUP BY cont
                                              ,nuse
                                              ,concepto
                                 UNION ALL
                                    SELECT difesusc
                                          ,difenuse
                                          ,difeconc
                                          ,0
                                          ,difesape
                                          ,0
                                      FROM open.ldc_cartdiaria_tmp,open.diferido
                                     WHERE nro_ctas_con_saldo >= nupanroctas
                                       AND difesape > 0
                                       AND producto = difenuse)
                            GROUP BY cont,nuse,concepto);*/
 COMMIT;
 -- Temporal2
  OPEN cudatos2;
  LOOP
  FETCH cudatos2 BULK COLLECT INTO v_tbdatos2 LIMIT 100;
   FORALL i IN 1..v_tbdatos2.COUNT
     INSERT INTO ldc_concepto_diaria VALUES v_tbdatos2(i);
  EXIT WHEN cudatos2%NOTFOUND;
  END LOOP;
  CLOSE cudatos2;
  /*INSERT INTO ldc_concepto_diaria(
                                 SELECT
                                         dtpadia
                                        ,cont
                                        ,nuse
                                        ,concepto
                                        ,SUM(valor_vencido)
                                        ,SUM(valor_diferido)
                                        ,SUM(valor_no_vencido)
                                   FROM(
                                        SELECT cont
                                              ,nuse
                                              ,concepto
                                              ,NVL(SUM(valor_vencido),0) valor_vencido
                                              ,0 valor_diferido
                                              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
                                          FROM(
                                               SELECT cargcuco   cuco
                                                     ,cucofeve   feve
                                                     ,d.contrato cont
                                                     ,cargnuse   nuse
                                                     ,cargconc   concepto
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                                                 FROM open.ldc_cartdiaria_tmp2 d,cuencobr,cargos
                                                WHERE d.nro_ctas_con_saldo >= nupanroctas
                                                  AND cucosacu              > 0
                                                  AND d.producto            = cuconuse
                                                  AND cucocodi              = cargcuco
                                                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
                                              )
                                      GROUP BY cont
                                              ,nuse
                                              ,concepto
                                 UNION ALL
                                    SELECT difesusc
                                          ,difenuse
                                          ,difeconc
                                          ,0
                                          ,difesape
                                          ,0
                                      FROM open.ldc_cartdiaria_tmp2,open.diferido
                                     WHERE nro_ctas_con_saldo >= nupanroctas
                                       AND difesape > 0
                                       AND producto = difenuse)
                            GROUP BY cont,nuse,concepto);*/
 COMMIT;
 -- Temporal3
  OPEN cudatos3;
  LOOP
  FETCH cudatos3 BULK COLLECT INTO v_tbdatos3 LIMIT 100;
   FORALL i IN 1..v_tbdatos3.COUNT
     INSERT INTO ldc_concepto_diaria VALUES v_tbdatos3(i);
  EXIT WHEN cudatos3%NOTFOUND;
  END LOOP;
  CLOSE cudatos3;
 /*INSERT INTO ldc_concepto_diaria(
                                 SELECT
                                         dtpadia
                                        ,cont
                                        ,nuse
                                        ,concepto
                                        ,SUM(valor_vencido)
                                        ,SUM(valor_diferido)
                                        ,SUM(valor_no_vencido)
                                   FROM(
                                        SELECT cont
                                              ,nuse
                                              ,concepto
                                              ,NVL(SUM(valor_vencido),0) valor_vencido
                                              ,0 valor_diferido
                                              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
                                          FROM(
                                               SELECT cargcuco   cuco
                                                     ,cucofeve   feve
                                                     ,d.contrato cont
                                                     ,cargnuse   nuse
                                                     ,cargconc   concepto
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                                                 FROM open.ldc_cartdiaria_tmp3 d,cuencobr,cargos
                                                WHERE d.nro_ctas_con_saldo >= nupanroctas
                                                  AND cucosacu              > 0
                                                  AND d.producto            = cuconuse
                                                  AND cucocodi              = cargcuco
                                                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
                                              )
                                      GROUP BY cont
                                              ,nuse
                                              ,concepto
                                 UNION ALL
                                    SELECT difesusc
                                          ,difenuse
                                          ,difeconc
                                          ,0
                                          ,difesape
                                          ,0
                                      FROM open.ldc_cartdiaria_tmp3,open.diferido
                                     WHERE nro_ctas_con_saldo >= nupanroctas
                                       AND difesape > 0
                                       AND producto = difenuse)
                            GROUP BY cont,nuse,concepto);*/
 COMMIT;
 -- Temporal4
  OPEN cudatos4;
  LOOP
  FETCH cudatos4 BULK COLLECT INTO v_tbdatos4 LIMIT 100;
   FORALL i IN 1..v_tbdatos4.COUNT
     INSERT INTO ldc_concepto_diaria VALUES v_tbdatos4(i);
  EXIT WHEN cudatos4%NOTFOUND;
  END LOOP;
  CLOSE cudatos4;
  /*
 INSERT INTO ldc_concepto_diaria(
                                 SELECT
                                         dtpadia
                                        ,cont
                                        ,nuse
                                        ,concepto
                                        ,SUM(valor_vencido)
                                        ,SUM(valor_diferido)
                                        ,SUM(valor_no_vencido)
                                   FROM(
                                        SELECT cont
                                              ,nuse
                                              ,concepto
                                              ,NVL(SUM(valor_vencido),0) valor_vencido
                                              ,0 valor_diferido
                                              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
                                          FROM(
                                               SELECT cargcuco   cuco
                                                     ,cucofeve   feve
                                                     ,d.contrato cont
                                                     ,cargnuse   nuse
                                                     ,cargconc   concepto
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                                                 FROM open.ldc_cartdiaria_tmp4 d,cuencobr,cargos
                                                WHERE d.nro_ctas_con_saldo >= nupanroctas
                                                  AND cucosacu              > 0
                                                  AND d.producto            = cuconuse
                                                  AND cucocodi              = cargcuco
                                                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
                                              )
                                      GROUP BY cont
                                              ,nuse
                                              ,concepto
                                 UNION ALL
                                    SELECT difesusc
                                          ,difenuse
                                          ,difeconc
                                          ,0
                                          ,difesape
                                          ,0
                                      FROM open.ldc_cartdiaria_tmp4,open.diferido
                                     WHERE nro_ctas_con_saldo >= nupanroctas
                                       AND difesape > 0
                                       AND producto = difenuse)
                            GROUP BY cont,nuse,concepto);*/
 COMMIT;
  -- Temporal5
  OPEN cudatos5;
  LOOP
  FETCH cudatos5 BULK COLLECT INTO v_tbdatos5 LIMIT 100;
   FORALL i IN 1..v_tbdatos5.COUNT
     INSERT INTO ldc_concepto_diaria VALUES v_tbdatos5(i);
  EXIT WHEN cudatos5%NOTFOUND;
  END LOOP;
  CLOSE cudatos5;
  /*
 INSERT INTO ldc_concepto_diaria(
                                 SELECT
                                         dtpadia
                                        ,cont
                                        ,nuse
                                        ,concepto
                                        ,SUM(valor_vencido)
                                        ,SUM(valor_diferido)
                                        ,SUM(valor_no_vencido)
                                   FROM(
                                        SELECT cont
                                              ,nuse
                                              ,concepto
                                              ,NVL(SUM(valor_vencido),0) valor_vencido
                                              ,0 valor_diferido
                                              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
                                          FROM(
                                               SELECT cargcuco   cuco
                                                     ,cucofeve   feve
                                                     ,d.contrato cont
                                                     ,cargnuse   nuse
                                                     ,cargconc   concepto
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                                                 FROM open.ldc_cartdiaria_tmp5 d,cuencobr,cargos
                                                WHERE d.nro_ctas_con_saldo >= nupanroctas
                                                  AND cucosacu              > 0
                                                  AND d.producto            = cuconuse
                                                  AND cucocodi              = cargcuco
                                                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
                                              )
                                      GROUP BY cont
                                              ,nuse
                                              ,concepto
                                 UNION ALL
                                    SELECT difesusc
                                          ,difenuse
                                          ,difeconc
                                          ,0
                                          ,difesape
                                          ,0
                                      FROM open.ldc_cartdiaria_tmp5,open.diferido
                                     WHERE nro_ctas_con_saldo >= nupanroctas
                                       AND difesape > 0
                                       AND producto = difenuse)
                            GROUP BY cont,nuse,concepto);*/
 COMMIT;
  -- Temporal6
  OPEN cudatos6;
  LOOP
  FETCH cudatos6 BULK COLLECT INTO v_tbdatos6 LIMIT 100;
   FORALL i IN 1..v_tbdatos6.COUNT
     INSERT INTO ldc_concepto_diaria VALUES v_tbdatos6(i);
  EXIT WHEN cudatos6%NOTFOUND;
  END LOOP;
  CLOSE cudatos6;
  /*
 INSERT INTO ldc_concepto_diaria(
                                 SELECT
                                         dtpadia
                                        ,cont
                                        ,nuse
                                        ,concepto
                                        ,SUM(valor_vencido)
                                        ,SUM(valor_diferido)
                                        ,SUM(valor_no_vencido)
                                   FROM(
                                        SELECT cont
                                              ,nuse
                                              ,concepto
                                              ,NVL(SUM(valor_vencido),0) valor_vencido
                                              ,0 valor_diferido
                                              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
                                          FROM(
                                               SELECT cargcuco   cuco
                                                     ,cucofeve   feve
                                                     ,d.contrato cont
                                                     ,cargnuse   nuse
                                                     ,cargconc   concepto
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                                                 FROM open.ldc_cartdiaria_tmp6 d,cuencobr,cargos
                                                WHERE d.nro_ctas_con_saldo >= nupanroctas
                                                  AND cucosacu              > 0
                                                  AND d.producto            = cuconuse
                                                  AND cucocodi              = cargcuco
                                                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
                                              )
                                      GROUP BY cont
                                              ,nuse
                                              ,concepto
                                 UNION ALL
                                    SELECT difesusc
                                          ,difenuse
                                          ,difeconc
                                          ,0
                                          ,difesape
                                          ,0
                                      FROM open.ldc_cartdiaria_tmp6,open.diferido
                                     WHERE nro_ctas_con_saldo >= nupanroctas
                                       AND difesape > 0
                                       AND producto = difenuse)
                            GROUP BY cont,nuse,concepto);*/
 COMMIT;
  -- Temporal7
   OPEN cudatos7;
  LOOP
  FETCH cudatos7 BULK COLLECT INTO v_tbdatos7 LIMIT 100;
   FORALL i IN 1..v_tbdatos7.COUNT
     INSERT INTO ldc_concepto_diaria VALUES v_tbdatos7(i);
  EXIT WHEN cudatos7%NOTFOUND;
  END LOOP;
  CLOSE cudatos7;
  /*
 INSERT INTO ldc_concepto_diaria(
                                 SELECT
                                         dtpadia
                                        ,cont
                                        ,nuse
                                        ,concepto
                                        ,SUM(valor_vencido)
                                        ,SUM(valor_diferido)
                                        ,SUM(valor_no_vencido)
                                   FROM(
                                        SELECT cont
                                              ,nuse
                                              ,concepto
                                              ,NVL(SUM(valor_vencido),0) valor_vencido
                                              ,0 valor_diferido
                                              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
                                          FROM(
                                               SELECT cargcuco   cuco
                                                     ,cucofeve   feve
                                                     ,d.contrato cont
                                                     ,cargnuse   nuse
                                                     ,cargconc   concepto
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                                                 FROM open.ldc_cartdiaria_tmp7 d,cuencobr,cargos
                                                WHERE d.nro_ctas_con_saldo >= nupanroctas
                                                  AND cucosacu              > 0
                                                  AND d.producto            = cuconuse
                                                  AND cucocodi              = cargcuco
                                                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
                                              )
                                      GROUP BY cont
                                              ,nuse
                                              ,concepto
                                 UNION ALL
                                    SELECT difesusc
                                          ,difenuse
                                          ,difeconc
                                          ,0
                                          ,difesape
                                          ,0
                                      FROM open.ldc_cartdiaria_tmp7,open.diferido
                                     WHERE nro_ctas_con_saldo >= nupanroctas
                                       AND difesape > 0
                                       AND producto = difenuse)
                            GROUP BY cont,nuse,concepto);*/
 COMMIT;
  -- Temporal8
  OPEN cudatos8;
  LOOP
  FETCH cudatos8 BULK COLLECT INTO v_tbdatos8 LIMIT 100;
   FORALL i IN 1..v_tbdatos8.COUNT
     INSERT INTO ldc_concepto_diaria VALUES v_tbdatos8(i);
  EXIT WHEN cudatos8%NOTFOUND;
  END LOOP;
  CLOSE cudatos8;
  /*
 INSERT INTO ldc_concepto_diaria(
                                 SELECT
                                         dtpadia
                                        ,cont
                                        ,nuse
                                        ,concepto
                                        ,SUM(valor_vencido)
                                        ,SUM(valor_diferido)
                                        ,SUM(valor_no_vencido)
                                   FROM(
                                        SELECT cont
                                              ,nuse
                                              ,concepto
                                              ,NVL(SUM(valor_vencido),0) valor_vencido
                                              ,0 valor_diferido
                                              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
                                          FROM(
                                               SELECT cargcuco   cuco
                                                     ,cucofeve   feve
                                                     ,d.contrato cont
                                                     ,cargnuse   nuse
                                                     ,cargconc   concepto
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                                                 FROM open.ldc_cartdiaria_tmp8 d,cuencobr,cargos
                                                WHERE d.nro_ctas_con_saldo >= nupanroctas
                                                  AND cucosacu              > 0
                                                  AND d.producto            = cuconuse
                                                  AND cucocodi              = cargcuco
                                                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
                                              )
                                      GROUP BY cont
                                              ,nuse
                                              ,concepto
                                 UNION ALL
                                    SELECT difesusc
                                          ,difenuse
                                          ,difeconc
                                          ,0
                                          ,difesape
                                          ,0
                                      FROM open.ldc_cartdiaria_tmp8,open.diferido
                                     WHERE nro_ctas_con_saldo >= nupanroctas
                                       AND difesape > 0
                                       AND producto = difenuse)
                            GROUP BY cont,nuse,concepto);*/
 COMMIT;
  -- Temporal9
   OPEN cudatos9;
  LOOP
  FETCH cudatos9 BULK COLLECT INTO v_tbdatos9 LIMIT 100;
   FORALL i IN 1..v_tbdatos9.COUNT
     INSERT INTO ldc_concepto_diaria VALUES v_tbdatos9(i);
  EXIT WHEN cudatos9%NOTFOUND;
  END LOOP;
  CLOSE cudatos9;
  /*
 INSERT INTO ldc_concepto_diaria(
                                 SELECT
                                         dtpadia
                                        ,cont
                                        ,nuse
                                        ,concepto
                                        ,SUM(valor_vencido)
                                        ,SUM(valor_diferido)
                                        ,SUM(valor_no_vencido)
                                   FROM(
                                        SELECT cont
                                              ,nuse
                                              ,concepto
                                              ,NVL(SUM(valor_vencido),0) valor_vencido
                                              ,0 valor_diferido
                                              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
                                          FROM(
                                               SELECT cargcuco   cuco
                                                     ,cucofeve   feve
                                                     ,d.contrato cont
                                                     ,cargnuse   nuse
                                                     ,cargconc   concepto
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                                                 FROM open.ldc_cartdiaria_tmp9 d,cuencobr,cargos
                                                WHERE d.nro_ctas_con_saldo >= nupanroctas
                                                  AND cucosacu              > 0
                                                  AND d.producto            = cuconuse
                                                  AND cucocodi              = cargcuco
                                                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
                                              )
                                      GROUP BY cont
                                              ,nuse
                                              ,concepto
                                 UNION ALL
                                    SELECT difesusc
                                          ,difenuse
                                          ,difeconc
                                          ,0
                                          ,difesape
                                          ,0
                                      FROM open.ldc_cartdiaria_tmp9,open.diferido
                                     WHERE nro_ctas_con_saldo >= nupanroctas
                                       AND difesape > 0
                                       AND producto = difenuse)
                            GROUP BY cont,nuse,concepto);*/
 COMMIT;
  -- Temporal10
  OPEN cudatos10;
  LOOP
  FETCH cudatos10 BULK COLLECT INTO v_tbdatos10 LIMIT 100;
   FORALL i IN 1..v_tbdatos10.COUNT
     INSERT INTO ldc_concepto_diaria VALUES v_tbdatos10(i);
  EXIT WHEN cudatos10%NOTFOUND;
  END LOOP;
  CLOSE cudatos10;
  /*
 INSERT INTO ldc_concepto_diaria(
                                 SELECT
                                         dtpadia
                                        ,cont
                                        ,nuse
                                        ,concepto
                                        ,SUM(valor_vencido)
                                        ,SUM(valor_diferido)
                                        ,SUM(valor_no_vencido)
                                   FROM(
                                        SELECT cont
                                              ,nuse
                                              ,concepto
                                              ,NVL(SUM(valor_vencido),0) valor_vencido
                                              ,0 valor_diferido
                                              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
                                          FROM(
                                               SELECT cargcuco   cuco
                                                     ,cucofeve   feve
                                                     ,d.contrato cont
                                                     ,cargnuse   nuse
                                                     ,cargconc   concepto
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                                                 FROM open.ldc_cartdiaria_tmp10 d,cuencobr,cargos
                                                WHERE d.nro_ctas_con_saldo >= nupanroctas
                                                  AND cucosacu              > 0
                                                  AND d.producto            = cuconuse
                                                  AND cucocodi              = cargcuco
                                                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
                                              )
                                      GROUP BY cont
                                              ,nuse
                                              ,concepto
                                 UNION ALL
                                    SELECT difesusc
                                          ,difenuse
                                          ,difeconc
                                          ,0
                                          ,difesape
                                          ,0
                                      FROM open.ldc_cartdiaria_tmp10,open.diferido
                                     WHERE nro_ctas_con_saldo >= nupanroctas
                                       AND difesape > 0
                                       AND producto = difenuse)
                            GROUP BY cont,nuse,concepto);*/
 COMMIT;
  -- Temporal11
  OPEN cudatos11;
  LOOP
  FETCH cudatos11 BULK COLLECT INTO v_tbdatos11 LIMIT 100;
   FORALL i IN 1..v_tbdatos11.COUNT
     INSERT INTO ldc_concepto_diaria VALUES v_tbdatos11(i);
  EXIT WHEN cudatos11%NOTFOUND;
  END LOOP;
  CLOSE cudatos11;
  /*
 INSERT INTO ldc_concepto_diaria(
                                 SELECT
                                         dtpadia
                                        ,cont
                                        ,nuse
                                        ,concepto
                                        ,SUM(valor_vencido)
                                        ,SUM(valor_diferido)
                                        ,SUM(valor_no_vencido)
                                   FROM(
                                        SELECT cont
                                              ,nuse
                                              ,concepto
                                              ,NVL(SUM(valor_vencido),0) valor_vencido
                                              ,0 valor_diferido
                                              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
                                          FROM(
                                               SELECT cargcuco   cuco
                                                     ,cucofeve   feve
                                                     ,d.contrato cont
                                                     ,cargnuse   nuse
                                                     ,cargconc   concepto
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                                                 FROM open.ldc_cartdiaria_tmp11 d,cuencobr,cargos
                                                WHERE d.nro_ctas_con_saldo >= nupanroctas
                                                  AND cucosacu              > 0
                                                  AND d.producto            = cuconuse
                                                  AND cucocodi              = cargcuco
                                                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
                                              )
                                      GROUP BY cont
                                              ,nuse
                                              ,concepto
                                 UNION ALL
                                    SELECT difesusc
                                          ,difenuse
                                          ,difeconc
                                          ,0
                                          ,difesape
                                          ,0
                                      FROM open.ldc_cartdiaria_tmp11,open.diferido
                                     WHERE nro_ctas_con_saldo >= nupanroctas
                                       AND difesape > 0
                                       AND producto = difenuse)
                            GROUP BY cont,nuse,concepto);*/
 COMMIT;
  -- Temporal12
  OPEN cudatos12;
  LOOP
  FETCH cudatos12 BULK COLLECT INTO v_tbdatos12 LIMIT 100;
   FORALL i IN 1..v_tbdatos12.COUNT
     INSERT INTO ldc_concepto_diaria VALUES v_tbdatos12(i);
  EXIT WHEN cudatos12%NOTFOUND;
  END LOOP;
  CLOSE cudatos12;
  /*
 INSERT INTO ldc_concepto_diaria(
                                 SELECT
                                         dtpadia
                                        ,cont
                                        ,nuse
                                        ,concepto
                                        ,SUM(valor_vencido)
                                        ,SUM(valor_diferido)
                                        ,SUM(valor_no_vencido)
                                   FROM(
                                        SELECT cont
                                              ,nuse
                                              ,concepto
                                              ,NVL(SUM(valor_vencido),0) valor_vencido
                                              ,0 valor_diferido
                                              ,NVL(SUM(valor_no_vencido),0) valor_no_vencido
                                          FROM(
                                               SELECT cargcuco   cuco
                                                     ,cucofeve   feve
                                                     ,d.contrato cont
                                                     ,cargnuse   nuse
                                                     ,cargconc   concepto
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1)),0),0) valor_no_vencido
                                                     ,NVL(decode(ldc_edad_mes(TRUNC(SYSDATE)-TRUNC(cucofeve)),0,0,SUM(decode(cargsign,'DB',cargvalo,'CR',cargvalo*-1,'SA',cargvalo,'AS',cargvalo*-1,'PA',cargvalo*-1,'AP',cargvalo,'NS',cargvalo*-1))),0) valor_vencido
                                                 FROM open.ldc_cartdiaria_tmp12 d,cuencobr,cargos
                                                WHERE d.nro_ctas_con_saldo >= nupanroctas
                                                  AND cucosacu              > 0
                                                  AND d.producto            = cuconuse
                                                  AND cucocodi              = cargcuco
                                                GROUP BY cargcuco,cucofeve,cargconc,d.contrato,cargnuse
                                              )
                                      GROUP BY cont
                                              ,nuse
                                              ,concepto
                                 UNION ALL
                                    SELECT difesusc
                                          ,difenuse
                                          ,difeconc
                                          ,0
                                          ,difesape
                                          ,0
                                      FROM open.ldc_cartdiaria_tmp12,open.diferido
                                     WHERE nro_ctas_con_saldo >= nupanroctas
                                       AND difesape > 0
                                       AND producto = difenuse)
                            GROUP BY cont,nuse,concepto);*/
COMMIT;
nuerror := 0;
sberror := NULL;
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  nuerror := -1;
  sberror := SQLERRM;
END;
PROCEDURE ldc_proccargadatoscartdiaria AS
 nucontatabtemp NUMBER DEFAULT 0;
 nocontareh     NUMBER DEFAULT 0;
 nucantiregcom  NUMBER(8);
 sbmensa        VARCHAR2(1000);
 sbproces       VARCHAR2(1000);
 nucantidadreg  NUMBER(8);
 sw             VARCHAR2(1) DEFAULT 0;
 nualorejecuta  ld_parameter.numeric_value%TYPE;
 nuvaerror      NUMBER;
 sbinsactu      ld_parameter.value_chain%TYPE;
 nocontarehcl   NUMBER(4);
BEGIN
 FOR ids IN cudatossesion LOOP
  nupkvaano := ids.ano;
  nupkvames := ids.mes;
  nutvasess := ids.sesion;
  sbvaruser := ids.usuario_conectado;
  dtvardia  := ids.dia;
  sw        := '1';
 END LOOP;
 dtvardia := trunc(dtvardia);
 IF sw = '1' THEN
  nualorejecuta := pkg_bcld_parameter.fnuobtienevalornumerico('CARGA_VALORES_CARTDIARIA');
  IF nualorejecuta <> 0 THEN
   RETURN;
  ELSE
   dald_parameter.updNumeric_Value('CARGA_VALORES_CARTDIARIA',1);
   nucontatabtemp := 0;
   -- Validamos que por lo menos se haya llenado una tabla temporal
     SELECT COUNT(1) INTO nucontatabtemp
       FROM ld_parameter x
      WHERE x.parameter_id IN(
                              'EJECUTA_CARTLINEA_1'
                             ,'EJECUTA_CARTLINEA_2'
                             ,'EJECUTA_CARTLINEA_3'
                             ,'EJECUTA_CARTLINEA_4'
                             ,'EJECUTA_CARTLINEA_5'
                             ,'EJECUTA_CARTLINEA_6'
                             ,'EJECUTA_CARTLINEA_7'
                             ,'EJECUTA_CARTLINEA_8'
                             ,'EJECUTA_CARTLINEA_9'
                             ,'EJECUTA_CARTLINEA_10'
                             ,'EJECUTA_CARTLINEA_11'
                             ,'EJECUTA_CARTLINEA_12'
                             )
        AND x.numeric_value = 2;
    IF nucontatabtemp = pkg_bcld_parameter.fnuobtienevalornumerico('HILOS_CARTDIARIA') THEN
     ldc_proinsertaestaprog(nupkvaano,nupkvames,'LDC_PROCCARGADATOSCARTDIARIA','En ejecucion',nutvasess,sbvaruser);
     sbinsactu := pkg_bcld_parameter.fsbobtienevalorcadena('ACT_O_INS_CARTERA_LINEA');
     -- Guardamos informacion de la cartera resumida en linea o diaria
     BEGIN
      sbproces := 'BEGIN LDC_PROCARTLINRES(to_date('''||to_char(dtvardia,'dd/mm/yyyy')||''''||','||'''dd/mm/yyyy'''||'),'||nupkvaano||','||nupkvames||','||nutvasess||','''||sbvaruser||'''); END;';
      EXECUTE IMMEDIATE (sbproces);
     EXCEPTION
      WHEN OTHERS THEN
      NULL;
     END;
     -- Validamos si ya se ejecuto en el dia
    SELECT COUNT(1) INTO nocontareh
      FROM ldc_osf_estaproc ep
     WHERE ep.proceso = 'LDC_PROC_CART_DIARI_CON_X_CTAS'
       AND trunc(ep.fecha_inicial_ejec) = dtvardia
       AND ep.fecha_final_ejec IS NOT NULL;
     IF nocontareh = 0 THEN
      ldc_proinsertaestaprog(nupkvaano,nupkvames,'LDC_PROC_CART_DIARI_CON_X_CTAS','En ejecucion',nutvasess,sbvaruser);
      pkg_truncate_tablas_open.prcldc_concepto_diaria;

      -- Generamos la informacion de la cartera x concepto para las cuentas con saldos >= 3
      BEGIN
       ldc_proc_cart_diari_con_x_ctas(dtvardia,pkg_bcld_parameter.fnuobtienevalornumerico('CTAS_CON_SALDO_FREC_GDC'),nuvaerror,sbmensa);
       -- Registros procesados
       SELECT count(1) INTO nucantiregcom
         FROM ldc_concepto_diaria cf
        WHERE cf.dia = dtvardia;
         IF nuvaerror = 0 THEN
          sbmensa       := 'Proceso termino Ok. Se procesaron :'||to_char(nucantiregcom)||' registros.';
          ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PROC_CART_DIARI_CON_X_CTAS','Ok.');
         ELSE
          ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PROC_CART_DIARI_CON_X_CTAS','Error.');
         END IF;
      EXCEPTION
        WHEN OTHERS THEN
         sbmensa := to_char(SQLCODE)||' - '||SQLERRM;
         ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PROC_CART_DIARI_CON_X_CTAS','Termino con error.');
         ROLLBACK;
      END;
     END IF;
     IF TRIM(sbinsactu) IN('A','a') THEN
      SELECT COUNT(1) INTO nocontarehcl
        FROM ldc_osf_estaproc ep
       WHERE ep.proceso = 'LDCUSUADIFCARTLICUENCOB'
         AND trunc(ep.fecha_inicial_ejec) = dtvardia
         AND ep.fecha_final_ejec IS NOT NULL;
         IF nocontarehcl = 0 THEN
           UPDATE ldc_cartdiaria SET dia = dtvardia;
             ldcusuadifcartlicuencob;
         END IF;
     ELSE
      DELETE ldc_usuarios_actualiza_cl uad
       WHERE uad.idregistro <=(
                               SELECT gh.max_id_reg
                                 FROM ldc_esprocardiaria gh
                                WHERE gh.estado    = 'N'
                                  AND gh.nusession = nutvasess
                               );
     END IF;
      sbmensa := 'Termino Ok.';
      ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PROCCARGADATOSCARTDIARIA','Termino oK.');
      SELECT fx.total_reg_proc+fx.total_reg_proc2+fx.total_reg_proc3+fx.total_reg_proc4+fx.total_reg_proc5+fx.total_reg_proc6+fx.total_reg_proc7+fx.total_reg_proc8+fx.total_reg_proc9+fx.total_reg_proc10+fx.total_reg_proc11+fx.total_reg_proc12 INTO nucantidadreg
        FROM ldc_esprocardiaria fx
       WHERE fx.estado    = 'N'
         AND fx.nusession = nutvasess;
       sbmensa := 'Proceso termin? Ok. Se procesar?n : '||to_char(nucantidadreg);
       ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PK_CARTERA_DIARIA.LDC_PROCCARTLINEA_AUTOMAT','Ok.');
       UPDATE ldc_esprocardiaria fg
         SET fg.estado = 'S'
       WHERE fg.nusession = nutvasess
         AND fg.estado    = 'N';
      dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_1',1);
      dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_2',1);
      dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_3',1);
      dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_4',1);
      dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_5',1);
      dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_6',1);
      dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_7',1);
      dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_8',1);
      dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_9',1);
      dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_10',1);
      dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_11',1);
      dald_parameter.updNumeric_Value('EJECUTA_CARTLINEA_12',1);
      dald_parameter.updNumeric_Value('CARGA_LINEA_AUTOMAT',0);
      dald_parameter.updValue_Chain('ACT_O_INS_CARTERA_LINEA','A');
    END IF;
    dald_parameter.updNumeric_Value('CARGA_VALORES_CARTDIARIA',0);
    COMMIT;
   END IF;
 END IF;
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := SQLERRM;
  ldc_proactualizaestaprog(nutvasess,sbmensa,'LDC_PROCCARGADATOSCARTDIARIA','Termino oK.');
END ldc_proccargadatoscartdiaria;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PK_CARTERA_DIARIA', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_PK_CARTERA_DIARIA TO REXEREPORTES;
/