CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_PROCCONSULTAPRODOTSPNO" RETURN constants.tyRefCursor IS
  sbProcessInstance          ge_boinstancecontrol.stysbname;
  rcResult                   constants.tyrefcursor;
  sbproducto                 or_order_comment.order_comment%TYPE;
  sbdepartam                 VARCHAR2(1000);
  nudepa                     ge_geogra_location.geograp_location_id%TYPE;
  sblocam                    VARCHAR2(1000);
  nuloca                     ge_geogra_location.geograp_location_id%TYPE;
  sbsector                   VARCHAR2(1000);
  nusector                   or_operating_sector.operating_sector_id%TYPE;
  sbbarrio                   VARCHAR2(1000);
  nubarrio                   ge_geogra_location.geograp_location_id%TYPE;
  sbciclo                    VARCHAR2(1000);
  nuciclo                    ciclo.ciclcodi%TYPE;
  sbcate                     VARCHAR2(1000);
  nucate                     categori.catecodi%TYPE;
  sbtipotrabajo              VARCHAR2(1000);  --TICKET JOSH BRITO, HORBATH, CA 200-1235
  nutipotrabajo              or_task_type.task_type_id%TYPE; --TICKET JOSH BRITO, HORBATH, CA 200-1235
  sbcantidias                NUMBER;  --TICKET JOSH BRITO, HORBATH, CA 200-1235
  nuactividad                or_order_activity.activity_id%TYPE;
  sbactividad                VARCHAR2(1000);
  --------CA 200-1408--------
  sbFlag                     varchar2(1);
  sbYesflag                  varchar2(1) := CONSTANTS_PER.CSBYES;
  sbNoflag                   varchar2(1) := CONSTANTS_PER.CSBNO;
  sbTipoProducto             or_order_comment.order_comment%TYPE;
  ---------------------------
BEGIN
  ge_boinstancecontrol.GetCurrentInstance(sbProcessInstance);
  ge_boinstancecontrol.getattributenewvalue(sbprocessinstance,
                                             null,
                                             'OR_ORDER_COMMENT',
                                             'ORDER_COMMENT',
                                             sbproducto);
  ge_boinstancecontrol.getattributenewvalue(sbprocessinstance,
                                             null,
                                             'GE_DISTADMI_GEOGLOCA',
                                             'GEOGRAP_LOCATION_ID',
                                             sbdepartam);
  ge_boinstancecontrol.getattributenewvalue(sbprocessinstance,
                                             null,
                                             'GE_GEOGRA_LOCATION',
                                             'GEO_LOCA_FATHER_ID',
                                             sblocam);
  ge_boinstancecontrol.getattributenewvalue(sbprocessinstance,
                                             null,
                                             'AB_SEGMENTS',
                                             'OPERATING_SECTOR_ID',
                                             sbsector);
  ge_boinstancecontrol.getattributenewvalue(sbprocessinstance,
                                             null,
                                             'GE_GEOGRA_LOCATION',
                                             'DESCRIPTION',
                                             sbbarrio);
  ge_boinstancecontrol.getattributenewvalue(sbprocessinstance,
                                             null,
                                             'SERVSUSC',
                                             'SESUCICL',
                                             sbciclo);
  ge_boinstancecontrol.getattributenewvalue(sbprocessinstance,
                                             null,
                                             'PR_PRODUCT',
                                             'CATEGORY_ID',
                                             sbcate);
  ge_boinstancecontrol.getattributenewvalue(sbprocessinstance,
                                             null,
                                             'OR_TASK_TYPE',
                                             'TASK_TYPE_ID',
                                             sbtipotrabajo); --TICKET JOSH BRITO, HORBATH, CA 200-1235
  ge_boinstancecontrol.getattributenewvalue(sbprocessinstance,
                                             null,
                                             'OR_TASK_TYPES_ITEMS',
                                             'ITEM_AMOUNT',
                                             sbcantidias); --TICKET JOSH BRITO, HORBATH, CA 200-1235
  ge_boinstancecontrol.getattributenewvalue(sbprocessinstance,
                                             null,
                                             'OR_ORDER_ACTIVITY',
                                             'ACTIVITY_ID',
                                             sbactividad);
  --------CA 200-1408--------
  ge_boinstancecontrol.getattributenewvalue(sbprocessinstance,
                                             null,
                                             'OR_TASK_TYPE',
                                             'IS_ANULL',
                                             sbFlag);
  ---------------------------
    nuactividad := to_number(TRIM(sbactividad));
    sbproducto := TRIM(sbproducto);
    nudepa     := to_number(TRIM(sbdepartam));
    nuloca     := to_number(TRIM(sblocam));
    nusector   := to_number(TRIM(sbsector));
    nubarrio   := to_number(TRIM(sbbarrio));
    nuciclo    := to_number(TRIM(sbciclo));
    nucate     := to_number(TRIM(sbcate));
    nutipotrabajo     := to_number(TRIM(sbtipotrabajo)); --TICKET JOSH BRITO, HORBATH, CA 200-1235
    sbcantidias := TRIM(sbcantidias); --TICKET JOSH BRITO, HORBATH, CA 200-1235
    --------CA 200-1408--------
    --Si Flag esta activo "Y" solo mostrara productos 7014
    IF (sbFlag = sbYesflag) THEN
      sbTipoProducto := '7014';
    END IF;
    --Si Flag esta inactivo "N" mostrara los tipos de trabajo configurados
    --En el parametro TIPO_SERVI_FORMA_GOAVC
    IF (sbFlag = sbNoflag) THEN
      sbTipoProducto := open.dald_parameter.fsbgetvalue_chain('TIPO_SERVI_FORMA_GOAVC');
    END IF;
    ---------------------------
    IF sbproducto IS NULL THEN
     IF nudepa IS NULL THEN
      nudepa := -1;
     END IF;
     IF nuloca IS NULL THEN
      nuloca := -1;
     END IF;
     IF nusector IS NULL THEN
      nusector := -1;
     END IF;
     IF nubarrio IS NULL THEN
      nubarrio := -1;
     END IF;
     IF nuciclo IS NULL THEN
      nuciclo := -1;
     END IF;
     IF nucate IS NULL THEN
      nucate := -1;
     END IF;
     /*Adicional consulta los productos que no tengan una orden, del tipo de trabajo ingresado en el nuevo campo nutipotrabajo [Tipo de trabajo]
     con una diferencia en d??as menor o igual al n??mero ingresado en el nuevo campo sbcantidias [Cantidad de d??as]  entre la fecha de creaci??n
     y la fecha actual del sistema, y cuyos estados estar??n definidos en el par??metro LDC_STATP_PROORDER.

     Ademmas si el par??metro LDC_STATP_PROORDER contiene 8  este tambi??n consultara productos que no tengan ordenes en estado (8-cerrada)
     con causal de ??xito = 1, del tipo de trabajo ingresado en el nuevo campo nutipotrabajo [Tipo de trabajo] con una diferencia en d??as
     menor o igual al n??mero ingresado en el nuevo campo sbcantidias [Cantidad de d??as]  entre la fecha de creaci??n y la fecha actual del sistema */

     --TICKET JOSH BRITO, HORBATH, CA 200-1235
     IF nutipotrabajo IS NOT NULL AND sbcantidias IS NOT NULL THEN
         OPEN rcResult FOR
              SELECT pro.product_id producto,
                  ser.sesuserv || ' - ' || (SELECT SE.SERVDESC FROM SERVICIO SE WHERE SE.SERVCODI = ser.sesuserv) tipo_producto, --CA[200-1408] Se agrega
                  (SELECT cl.subscriber_name||' '||cl.subs_last_name||' '||cl.subs_second_last_name FROM ge_subscriber cl,suscripc su WHERE cl.subscriber_id = su.suscclie AND su.susccodi = ser.sesususc) nombres,
                  pro.address_id||' - '||dir.address_parsed direccion,
                  loc.geo_loca_father_id||' - '||(SELECT dep.description FROM open.ge_geogra_location dep WHERE dep.geograp_location_id = loc.geo_loca_father_id) departamento,
                  loc.geograp_location_id||' - '||loc.description localidad,
                  seg.operating_sector_id||' - '||(SELECT seop.description FROM or_operating_sector seop WHERE seop.operating_sector_id = seg.operating_sector_id) sector_operativo,
                  dir.neighborthood_id||' - '||(SELECT bar.description FROM open.ge_geogra_location bar WHERE bar.geograp_location_id = dir.neighborthood_id) barrio,
                  ser.sesufein fecha_instalacion,
                  pro.product_status_id||' - '||(SELECT ep.description FROM ps_product_status ep WHERE ep.product_status_id = pro.product_status_id) estado_producto,
                  ser.sesucicl||' - '||daciclo.fsbgetcicldesc(ser.sesucicl) descripcion_ciclo,
                  ser.sesucate||' - '||(SELECT catedesc FROM categori ct WHERE ct.catecodi = ser.sesucate) categoria,
                  ser.sesusuca||' - '||(SELECT sucadesc FROM subcateg WHERE sucacate = sesucate AND sucacodi = sesusuca) subcategoria,
                  ser.sesuesco||' - '||(SELECT escodesc FROM estacort WHERE escocodi = ser.sesuesco) estado_corte,
                  decode(ser.sesuesfn,'D','Con Deuda','M','En Mora','A','Al Dia','C','Castigado') ESTADO_FINANCIERO
             FROM ge_geogra_location loc,
                  ab_address dir,
                  ab_segments seg,
                  pr_product pro,
                  servsusc ser
             WHERE loc.geo_loca_father_id  = decode(nudepa,-1,loc.geo_loca_father_id,nudepa)
              AND loc.geograp_location_id = decode(nuloca,-1,loc.geograp_location_id,nuloca)
              AND seg.operating_sector_id = decode(nusector,-1,seg.operating_sector_id,nusector)
              AND dir.neighborthood_id    = decode(nubarrio,-1,dir.neighborthood_id,nubarrio)
              AND pro.category_id         = decode(nucate,-1,pro.category_id,nucate)
              AND ser.sesucicl            = decode(nuciclo,-1,sesucicl,nuciclo)
              AND PRO.PRODUCT_ID NOT IN ((
                  SELECT OAT.PRODUCT_ID
                  FROM OR_ORDER_ACTIVITY OAT, OR_ORDER O, (SELECT to_number(column_value) AS ORDER_STATUS_ID
                                                           FROM TABLE(open.ldc_boutilities.splitstrings(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_STATP_PROORDER'),','))
                                                          ) EST
                  where  O.ORDER_ID = OAT.ORDER_ID
                  AND O.TASK_TYPE_ID = nutipotrabajo
                  AND (TRUNC(SYSDATE)-TRUNC(O.CREATED_DATE)) <= sbcantidias
                  AND ((O.CAUSAL_ID = 1 AND O.ORDER_STATUS_ID = 8)
                  or O.ORDER_STATUS_ID <> 8) AND O.ORDER_STATUS_ID = EST.ORDER_STATUS_ID
                  )
                  UNION
                  (
                  SELECT OAT.PRODUCT_ID
                  FROM OR_ORDER_ACTIVITY OAT, OR_ORDER O
                  where  O.ORDER_ID = OAT.ORDER_ID
                  AND OAT.activity_id = nuactividad
                  AND O.order_status_id IN(0,5)
                  ))
              --AND ser.sesuserv            = 7014 --CA[200-1408] Se comenta
              AND ser.sesuserv            IN (SELECT to_number(column_value)
                                FROM TABLE(open.ldc_boutilities.splitstrings(sbTipoProducto,','))) --CA[200-1408] Se agrega
              AND loc.geograp_location_id = dir.geograp_location_id
              AND dir.segment_id          = seg.segments_id
              AND dir.address_id          = pro.address_id
              AND pro.product_id          = ser.sesunuse
             ORDER BY loc.geo_loca_father_id
                 ,loc.geograp_location_id
                 ,seg.operating_sector_id
                 ,dir.neighborthood_id
                 ,pro.product_id;
         RETURN rcResult;
     ELSE
         OPEN rcResult FOR
              SELECT pro.product_id producto,
                  ser.sesuserv || ' - ' || (SELECT SE.SERVDESC FROM SERVICIO SE WHERE SE.SERVCODI = ser.sesuserv) tipo_producto, --CA[200-1408] Se agrega
                  (SELECT cl.subscriber_name||' '||cl.subs_last_name||' '||cl.subs_second_last_name FROM ge_subscriber cl,suscripc su WHERE cl.subscriber_id = su.suscclie AND su.susccodi = ser.sesususc) nombres,
                  pro.address_id||' - '||dir.address_parsed direccion,
                  loc.geo_loca_father_id||' - '||(SELECT dep.description FROM open.ge_geogra_location dep WHERE dep.geograp_location_id = loc.geo_loca_father_id) departamento,
                  loc.geograp_location_id||' - '||loc.description localidad,
                  seg.operating_sector_id||' - '||(SELECT seop.description FROM or_operating_sector seop WHERE seop.operating_sector_id = seg.operating_sector_id) sector_operativo,
                  dir.neighborthood_id||' - '||(SELECT bar.description FROM open.ge_geogra_location bar WHERE bar.geograp_location_id = dir.neighborthood_id) barrio,
                  ser.sesufein fecha_instalacion,
                  pro.product_status_id||' - '||(SELECT ep.description FROM ps_product_status ep WHERE ep.product_status_id = pro.product_status_id) estado_producto,
                  ser.sesucicl||' - '||daciclo.fsbgetcicldesc(ser.sesucicl) descripcion_ciclo,
                  ser.sesucate||' - '||(SELECT catedesc FROM categori ct WHERE ct.catecodi = ser.sesucate) categoria,
                  ser.sesusuca||' - '||(SELECT sucadesc FROM subcateg WHERE sucacate = sesucate AND sucacodi = sesusuca) subcategoria,
                  ser.sesuesco||' - '||(SELECT escodesc FROM estacort WHERE escocodi = ser.sesuesco) estado_corte,
                  decode(ser.sesuesfn,'D','Con Deuda','M','En Mora','A','Al Dia','C','Castigado') ESTADO_FINANCIERO
             FROM ge_geogra_location loc,
                  ab_address dir,
                  ab_segments seg,
                  pr_product pro,
                  servsusc ser
             WHERE loc.geo_loca_father_id  = decode(nudepa,-1,loc.geo_loca_father_id,nudepa)
              AND loc.geograp_location_id = decode(nuloca,-1,loc.geograp_location_id,nuloca)
              AND seg.operating_sector_id = decode(nusector,-1,seg.operating_sector_id,nusector)
              AND dir.neighborthood_id    = decode(nubarrio,-1,dir.neighborthood_id,nubarrio)
              AND pro.category_id         = decode(nucate,-1,pro.category_id,nucate)
              AND ser.sesucicl            = decode(nuciclo,-1,sesucicl,nuciclo)
              --AND ser.sesuserv            = 7014 --CA[200-1408] Se comenta
              AND ser.sesuserv            IN (SELECT to_number(column_value)
                                FROM TABLE(open.ldc_boutilities.splitstrings(sbTipoProducto,','))) --CA[200-1408] Se agrega
              AND 0                       = (SELECT COUNT(1)
                                               FROM or_order_activity oa,or_order otx
                                              WHERE oa.product_id  = pro.product_id
                                                AND oa.activity_id = nuactividad
                                                AND otx.order_status_id IN(0,5)
                                                AND oa.order_id    = otx.order_id)
              AND loc.geograp_location_id = dir.geograp_location_id
              AND dir.segment_id          = seg.segments_id
              AND dir.address_id          = pro.address_id
              AND pro.product_id          = ser.sesunuse
             ORDER BY loc.geo_loca_father_id
                 ,loc.geograp_location_id
                 ,seg.operating_sector_id
                 ,dir.neighborthood_id
                 ,pro.product_id;
         RETURN rcResult;
    END IF;
   ELSE
    OPEN rcResult FOR
     SELECT pro.product_id producto,
           ser.sesuserv || ' - ' || (SELECT SE.SERVDESC FROM SERVICIO SE WHERE SE.SERVCODI = ser.sesuserv) tipo_producto, --CA[200-1408] Se agrega
           (SELECT cl.subscriber_name||' '||cl.subs_last_name||' '||cl.subs_second_last_name FROM ge_subscriber cl,suscripc su WHERE cl.subscriber_id = su.suscclie AND su.susccodi = ser.sesususc) nombres,
           pro.address_id||' - '||dir.address_parsed direccion,
           loc.geo_loca_father_id||' - '||(SELECT dep.description FROM open.ge_geogra_location dep WHERE dep.geograp_location_id = loc.geo_loca_father_id) departamento,
           loc.geograp_location_id||' - '||loc.description localidad,
           seg.operating_sector_id||' - '||(SELECT seop.description FROM or_operating_sector seop WHERE seop.operating_sector_id = seg.operating_sector_id) sector_operativo,
           dir.neighborthood_id||' - '||(SELECT bar.description FROM open.ge_geogra_location bar WHERE bar.geograp_location_id = dir.neighborthood_id) barrio,
           ser.sesufein fecha_instalacion,
           pro.product_status_id||' - '||(SELECT ep.description FROM ps_product_status ep WHERE ep.product_status_id = pro.product_status_id) estado_producto,
           ser.sesucicl||' - '||daciclo.fsbgetcicldesc(ser.sesucicl) descripcion_ciclo,
           ser.sesucate||' - '||(SELECT catedesc FROM categori ct WHERE ct.catecodi = ser.sesucate) categoria,
           ser.sesusuca||' - '||(SELECT sucadesc FROM subcateg WHERE sucacate = sesucate AND sucacodi = sesusuca) subcategoria,
           ser.sesuesco||' - '||(SELECT escodesc FROM estacort WHERE escocodi = ser.sesuesco) estado_corte,
           decode(ser.sesuesfn,'D','Con Deuda','M','En Mora','A','Al Dia','C','Castigado') estado_financiero
       FROM ge_geogra_location loc,
            ab_address dir,
            ab_segments seg,
            pr_product pro,
            servsusc ser
      WHERE pro.product_id IN(SELECT to_number(column_value)
                                FROM TABLE(open.ldc_boutilities.splitstrings(sbproducto,',')))
        --AND ser.sesuserv            = 7014 --CA[200-1408] Se comenta
         AND ser.sesuserv            IN (SELECT to_number(column_value)
                                FROM TABLE(open.ldc_boutilities.splitstrings(sbTipoProducto,','))) --CA[200-1408] Se agrega
         AND 0                       = (SELECT COUNT(1)
                                           FROM or_order_activity oa,or_order otx
                                          WHERE oa.product_id  = pro.product_id
                                            AND oa.activity_id = nuactividad
                                            AND otx.order_status_id IN(0,5)
                                            AND oa.order_id    = otx.order_id)
        AND loc.geograp_location_id = dir.geograp_location_id
        AND dir.segment_id          = seg.segments_id
        AND dir.address_id          = pro.address_id
        AND pro.product_id          = ser.sesunuse
      ORDER BY loc.geo_loca_father_id
              ,loc.geograp_location_id
              ,seg.operating_sector_id
              ,dir.neighborthood_id
              ,pro.product_id;
    RETURN rcResult;
   END IF;
EXCEPTION
  WHEN ex.controlled_error THEN
    RAISE ex.controlled_error;
  WHEN OTHERS THEN
    errors.seterror;
    RAISE ex.controlled_error;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROCCONSULTAPRODOTSPNO', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON LDC_PROCCONSULTAPRODOTSPNO TO REPORTES;
/
