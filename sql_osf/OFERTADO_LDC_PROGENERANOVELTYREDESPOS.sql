DECLARE

  nupaacta open.ge_acta.id_acta%TYPE := 253251;

  --REA264 Variables
  nuerrorcode number;

  sberrormessage varchar2(4000);
  sbcontrolerror varchar2(4000);
  nuanterior     number;
  
  nuTotalOrdenHija NUMBER := 0;
  ----------------------

  ---
  CURSOR cuordernesacta(nuparcussion open.ldc_uni_act_ot.nussesion%TYPE,
                        nucurpacta   open.ldc_uni_act_ot.nro_acta%TYPE,
                        dtpasfecfin  DATE) IS
    With novedad as
     (SELECT ot.operating_unit_id unidad_operativa,
             ot.order_id orden,
             oa.activity_id actividad,
             oi.items_id item,
             iu.liquidacion liquidacion,
             nvl(SUM(oi.legal_item_amount), 0) cantidad_legalizada,
             otn.ORDEN_HIJA
        FROM open.or_order ot,
             open.or_order_activity oa,
             open.or_order_items oi,
             open.ldc_item_uo_lr iu,
             (SELECT fo.orden_nieta order_id, fo.ORDEN_HIJA
                FROM open.ct_order_certifica          oc,
                     open.ldc_ordenes_ofertados_redes fo
               WHERE oc.certificate_id = nucurpacta
                 AND oc.order_id = fo.ORDEN_HIJA
                 and fo.orden_nieta is not null) otn,
             open.ldc_tipo_trab_x_nov_ofertados uy,
             open.ldc_const_unoprl xu
       WHERE oi.legal_item_amount > 0 --= 1 --200-2532
         AND iu.liquidacion = 'A'
         AND xu.tipo_ofertado = 5 --200-2532
         AND ot.order_id = otn.order_id
         AND ot.order_id = oa.order_id
         AND oa.order_activity_id =
             (select ooa.activity_id
                from open.Or_Order_Activity ooa
               where ooa.order_id = ot.order_id)
            --open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
         AND ot.order_id = oi.order_id
         AND ot.operating_unit_id = iu.unidad_operativa
         AND oa.activity_id = iu.actividad
         AND oi.items_id = iu.item
         AND ot.task_type_id = uy.tipo_trabajo
         AND ot.operating_unit_id = xu.unidad_operativa --200-2532
       GROUP BY ot.operating_unit_id,
                ot.order_id,
                oa.activity_id,
                oi.items_id,
                iu.liquidacion,
                otn.ORDEN_HIJA
      UNION ALL
      SELECT ot.operating_unit_id,
             ot.order_id,
             iu.actividad,
             oi.items_id item,
             iu.liquidacion,
             nvl(SUM(oi.legal_item_amount), 0) cantidad_legalizada,
             otn.ORDEN_HIJA
        FROM open.or_order ot,
             open.or_order_items oi,
             open.ldc_item_uo_lr iu,
             (SELECT fo.orden_nieta order_id, fo.ORDEN_HIJA
                FROM open.ct_order_certifica          oc,
                     open.ldc_ordenes_ofertados_redes fo
               WHERE oc.certificate_id = nucurpacta
                 AND oc.order_id = fo.ORDEN_HIJA
                 and fo.orden_nieta is not null) otn,
             open.ldc_tipo_trab_x_nov_ofertados uy,
             open.ldc_const_unoprl xu
       WHERE oi.legal_item_amount > 0 --= 1 --200-2532
         AND xu.tipo_ofertado = 5 --200-2532
         AND iu.liquidacion = 'I'
         AND iu.actividad = -1
         AND ot.order_id = otn.order_id
         AND ot.order_id = oi.order_id
         AND ot.operating_unit_id = iu.unidad_operativa
         AND oi.items_id = iu.item
         AND ot.task_type_id = uy.tipo_trabajo
         AND ot.operating_unit_id = xu.unidad_operativa --200-2532
       GROUP BY ot.operating_unit_id,
                ot.order_id,
                iu.actividad,
                oi.items_id,
                iu.liquidacion,
                otn.ORDEN_HIJA)
    select novedad.orden,
           novedad.unidad_operativa,
           novedad.actividad,
           novedad.item,
           novedad.ORDEN_HIJA
      from novedad
     where (SELECT COUNT(1)
            ---INTO nucontaconfigura
              FROM open.ldc_const_liqtarran qw
             WHERE qw.unidad_operativa = novedad.unidad_operativa
               AND qw.actividad_orden = novedad.actividad
               AND qw.items = novedad.item
               AND qw.zona_ofertados = -1
               AND qw.valor_liquidar >= 1
               AND trunc(dtpasfecfin) BETWEEN trunc(qw.fecha_ini_vigen) AND
                   trunc(qw.fecha_fin_vige)) >= 1
     order by novedad.ORDEN_HIJA, novedad.orden;
  /*SELECT t.orden, t.unidad_operativa, t.actividad, t.item
   FROM open.ldc_uni_act_ot t
  WHERE t.nussesion = nuparcussion
    AND t.nro_acta = nucurpacta;*/
  ---

  CURSOR curangos(nucuunidadoper open.or_operating_unit.operating_unit_id%TYPE,
                  nucuactividad  open.or_order_activity.activity_id%TYPE,
                  nucuitems      open.ge_items.items_id%TYPE,
                  dtcufechfin    DATE) IS
    SELECT lq.cantidad_inicial, lq.cantidad_final, lq.valor_liquidar
      FROM open.ldc_const_liqtarran lq
     WHERE lq.unidad_operativa = nucuunidadoper
       AND lq.actividad_orden = nucuactividad
       AND lq.items = nucuitems
       AND lq.zona_ofertados = -1
       AND trunc(dtcufechfin) BETWEEN trunc(lq.fecha_ini_vigen) AND
           trunc(lq.fecha_fin_vige)
     ORDER BY cantidad_inicial;
  ---

  CURSOR cuordernesactaot(nucuunidad   open.ldc_uni_act_ot.unidad_operativa%TYPE,
                          nucuactivi   open.ldc_uni_act_ot.actividad%TYPE,
                          nucuitem     open.ldc_uni_act_ot.item%TYPE,
                          nucupasesion open.ldc_uni_act_ot.nussesion%TYPE,
                          nucuacta     open.ldc_uni_act_ot.nro_acta%TYPE,
                          nuordengene  open.ldc_uni_act_ot.orden%TYPE,
                          dtpasfecfin  DATE) IS
    With novedad as
     (SELECT ot.operating_unit_id unidad_operativa,
             ot.order_id orden,
             oa.activity_id actividad,
             oi.items_id item,
             iu.liquidacion liquidacion,
             nvl(SUM(oi.legal_item_amount), 0) cantidad_item_legalizada,
             -1 zona_ofertados,
             -1 unidad_operativa_padre
        FROM open.or_order ot,
             open.or_order_activity oa,
             open.or_order_items oi,
             open.ldc_item_uo_lr iu,
             (SELECT fo.orden_nieta order_id
                FROM open.ct_order_certifica          oc,
                     open.ldc_ordenes_ofertados_redes fo
               WHERE oc.certificate_id = nucuacta
                 AND oc.order_id = fo.ORDEN_HIJA
                 and fo.orden_nieta is not null) otn,
             open.ldc_tipo_trab_x_nov_ofertados uy,
             open.ldc_const_unoprl xu
       WHERE oi.legal_item_amount > 0 --= 1 --200-2532
         AND iu.liquidacion = 'A'
         AND xu.tipo_ofertado = 5 --200-2532
         AND ot.order_id = otn.order_id
         AND ot.order_id = oa.order_id
         AND oa.order_activity_id =
             (select ooa.activity_id
                from open.Or_Order_Activity ooa
               where ooa.order_id = ot.order_id)
            --open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
         AND ot.order_id = oi.order_id
         AND ot.operating_unit_id = iu.unidad_operativa
         AND oa.activity_id = iu.actividad
         AND oi.items_id = iu.item
         AND ot.task_type_id = uy.tipo_trabajo
         AND ot.operating_unit_id = xu.unidad_operativa --200-2532
         and (SELECT COUNT(1)
              ---INTO nucontaconfigura
                FROM open.ldc_const_liqtarran qw
               WHERE qw.unidad_operativa = iu.unidad_operativa
                 AND qw.actividad_orden = iu.actividad
                 AND qw.items = iu.item
                 AND qw.zona_ofertados = -1
                 AND qw.valor_liquidar >= 1
                 AND trunc(dtpasfecfin) BETWEEN trunc(qw.fecha_ini_vigen) AND
                     trunc(qw.fecha_fin_vige)) >= 1
       GROUP BY ot.operating_unit_id,
                ot.order_id,
                oa.activity_id,
                oi.items_id,
                iu.liquidacion
      UNION ALL
      SELECT ot.operating_unit_id,
             ot.order_id,
             iu.actividad,
             oi.items_id item,
             iu.liquidacion,
             nvl(SUM(oi.legal_item_amount), 0) cantidad_legalizada,
             -1 zona_ofertados,
             -1 unidad_operativa_padre
        FROM open.or_order ot,
             open.or_order_items oi,
             open.ldc_item_uo_lr iu,
             (SELECT fo.orden_nieta order_id
                FROM open.ct_order_certifica          oc,
                     open.ldc_ordenes_ofertados_redes fo
               WHERE oc.certificate_id = nucuacta
                 AND oc.order_id = fo.ORDEN_HIJA
                 and fo.orden_nieta is not null) otn,
             open.ldc_tipo_trab_x_nov_ofertados uy,
             open.ldc_const_unoprl xu
       WHERE oi.legal_item_amount > 0 --= 1 --200-2532
         AND xu.tipo_ofertado = 5 --200-2532
         AND iu.liquidacion = 'I'
         AND iu.actividad = -1
         AND ot.order_id = otn.order_id
         AND ot.order_id = oi.order_id
         AND ot.operating_unit_id = iu.unidad_operativa
         AND oi.items_id = iu.item
         AND ot.task_type_id = uy.tipo_trabajo
         AND ot.operating_unit_id = xu.unidad_operativa --200-2532
         and (SELECT COUNT(1)
              ---INTO nucontaconfigura
                FROM open.ldc_const_liqtarran qw
               WHERE qw.unidad_operativa = iu.unidad_operativa
                 AND qw.actividad_orden = iu.actividad
                 AND qw.items = iu.item
                 AND qw.zona_ofertados = -1
                 AND qw.valor_liquidar >= 1
                 AND trunc(dtpasfecfin) BETWEEN trunc(qw.fecha_ini_vigen) AND
                     trunc(qw.fecha_fin_vige)) >= 1
       GROUP BY ot.operating_unit_id,
                ot.order_id,
                iu.actividad,
                oi.items_id,
                iu.liquidacion)
    SELECT DISTINCT (t.orden) order_id,
                    oa.address_id,
                    oa.package_id,
                    (SELECT mo.motive_id
                       FROM open.mo_motive mo
                      WHERE mo.package_id = oa.package_id
                        AND ROWNUM = 1) motivo,
                    oa.product_id producto,
                    nvl(t.cantidad_item_legalizada, 0) cantidad_legalizada
      FROM /*open.ldc_uni_act_ot*/ novedad t, open.or_order_activity oa
     WHERE 1 = 1
          --and t.nussesion = nucupasesion
          --AND t.nro_acta = nucuacta
       AND t.unidad_operativa = nucuunidad
       AND t.actividad = nucuactivi
       AND t.item = nucuitem
       AND t.orden = nuordengene
       AND t.unidad_operativa_padre = -1
       AND t.zona_ofertados = -1
       AND t.orden = oa.order_id
       AND oa.order_activity_id =
           (select ooa.order_activity_id
              from open.Or_Order_Activity ooa
             where ooa.order_id = t.orden)
    --open.ldc_bcfinanceot.fnugetactivityid(t.orden)
    UNION ALL
    SELECT DISTINCT (t.orden) order_id,
                    oa.address_id,
                    oa.package_id,
                    (SELECT mo.motive_id
                       FROM open.mo_motive mo
                      WHERE mo.package_id = oa.package_id
                        AND ROWNUM = 1) motivo,
                    oa.product_id producto,
                    nvl(t.cantidad_item_legalizada, 0) cantidad_legalizada
      FROM /*open.ldc_uni_act_ot*/ novedad t, open.or_order_activity oa
     WHERE 1 = 1
    --and t.nussesion = nucupasesion 
    --AND t.nro_acta = nucuacta 
     AND t.unidad_operativa_padre = nucuunidad AND
     t.actividad = nucuactivi AND t.item = nucuitem AND
     t.orden = nuordengene AND t.zona_ofertados = -1 AND
     t.orden = oa.order_id AND
     oa.order_activity_id =
    --open.ldc_bcfinanceot.fnugetactivityid(t.orden)
     (select ooa.order_activity_id
        from open.Or_Order_Activity ooa
       where ooa.order_id = t.orden);

  ---

  CURSOR cuordenesnovgenval(nucuorden     NUMBER,
                            nucuactividad NUMBER,
                            nucuitem      NUMBER) IS
    SELECT yu.order_activity_id, yu.value_reference
      FROM open.or_related_order  ro,
           open.or_order_activity yu,
           open.or_order          tr,
           open.or_order_items    s
     WHERE ro.rela_order_type_id = 14
       AND tr.order_status_id = 8
       AND yu.activity_id IN
           (SELECT tx.ACTIVIDAD_POSITIVA
              FROM open.ldc_tipo_trab_x_nov_ofertados tx
             WHERE tx.ACTIVIDAD_POSITIVA = yu.activity_id)
       AND ro.order_id = nucuorden
       AND TRIM(yu.comment_) =
           TRIM('Orden de novedad generada ACTIVIDAD : ' ||
                to_char(nucuactividad) || ' ITEM : ' || to_char(nucuitem))
       AND tr.order_id = s.order_id
       AND ro.related_order_id = yu.order_id
       AND yu.order_id = tr.order_id;
  ---

  nuvalordescontar      open.ldc_const_liqtarran.valor_liquidar%TYPE;
  nuvalordescontarxcant open.ldc_const_liqtarran.valor_liquidar%TYPE;
  nunovedadgenera       open.ldc_const_liqtarran.novedad_generar%TYPE;
  nureg                 NUMBER(2);
  eerror                EXCEPTION;
  nuorderid             open.or_order.order_id%TYPE DEFAULT NULL;
  nupersona             open.ge_person.person_id%TYPE;
  nuidenregi            open.ldc_const_liqtarran.iden_reg%TYPE;
  nuccano               NUMBER(4);
  nuccmes               NUMBER(2);
  nusession             NUMBER;
  sbuser                VARCHAR2(30);
  nucontanov            NUMBER(10) DEFAULT 0;
  sbmensaje             VARCHAR2(1000);
  nuvalfinal            open.ldc_const_liqtarran.cantidad_final%TYPE;
  nucontarang           NUMBER(8);
  nucontarangmenos1     NUMBER(8);
  nuvarunidad           open.or_operating_unit.operating_unit_id%TYPE;
  nusw                  NUMBER(1) DEFAULT 0;
  sbcompletobser        VARCHAR2(100);
  regor_order           open.or_order%ROWTYPE;
  nucantidadnovgen      NUMBER(8) DEFAULT 0;
  nutotalvalornov       NUMBER(15, 2) DEFAULT 0;
  numetroslineal        open.ldc_ordenes_ofertados_redes.metro_lineal%TYPE;
  swencontro            NUMBER(2);
  nuposireg             NUMBER(4);
  dtfechafinacta        DATE;
  sbOmiteCursor         open.ld_parameter.value_chain%type;
  --nvl(open.dald_parameter.fsbgetvalue_chain('OMITE_VALID_CUORDENESNOVGENVAL'),'N'); -- 200-2532

  --/*                                                                  
  ---
  PROCEDURE ldcprollenaldcuniactot(nuparacta   open.ge_acta.id_acta%TYPE,
                                   dtpasfecfin DATE,
                                   nuparsesion open.ldc_uni_act_ot.nussesion%TYPE) IS
    CURSOR cuordenesgenerarnovedadact(nucurtacta open.ge_acta.id_acta%TYPE) IS
      SELECT ot.operating_unit_id unidad_operativa,
             ot.order_id orden,
             oa.activity_id actividad,
             oi.items_id nuitemss,
             iu.liquidacion liquidacion,
             nvl(SUM(oi.legal_item_amount), 0) cantidad_legalizada
        FROM open.or_order ot,
             open.or_order_activity oa,
             open.or_order_items oi,
             open.ldc_item_uo_lr iu,
             (SELECT fo.orden_nieta order_id
                FROM open.ct_order_certifica          oc,
                     open.ldc_ordenes_ofertados_redes fo
               WHERE oc.certificate_id = nucurtacta
                 AND oc.order_id = fo.ORDEN_HIJA
                 and fo.orden_nieta is not null) otn,
             open.ldc_tipo_trab_x_nov_ofertados uy,
             open.ldc_const_unoprl xu
       WHERE oi.legal_item_amount > 0 --= 1 --200-2532
         AND iu.liquidacion = 'A'
         AND xu.tipo_ofertado = 5 --200-2532
         AND ot.order_id = otn.order_id
         AND ot.order_id = oa.order_id
         AND oa.order_activity_id =
             (select ooa.activity_id
                from open.Or_Order_Activity ooa
               where ooa.order_id = ot.order_id)
            --open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
         AND ot.order_id = oi.order_id
         AND ot.operating_unit_id = iu.unidad_operativa
         AND oa.activity_id = iu.actividad
         AND oi.items_id = iu.item
         AND ot.task_type_id = uy.tipo_trabajo
         AND ot.operating_unit_id = xu.unidad_operativa --200-2532
       GROUP BY ot.operating_unit_id,
                ot.order_id,
                oa.activity_id,
                oi.items_id,
                iu.liquidacion
      UNION ALL
      SELECT ot.operating_unit_id,
             ot.order_id,
             iu.actividad,
             oi.items_id,
             iu.liquidacion,
             nvl(SUM(oi.legal_item_amount), 0) cantidad_legalizada
        FROM open.or_order ot,
             open.or_order_items oi,
             open.ldc_item_uo_lr iu,
             (SELECT fo.orden_nieta order_id
                FROM open.ct_order_certifica          oc,
                     open.ldc_ordenes_ofertados_redes fo
               WHERE oc.certificate_id = nucurtacta
                 AND oc.order_id = fo.ORDEN_HIJA
                 and fo.orden_nieta is not null) otn,
             open.ldc_tipo_trab_x_nov_ofertados uy,
             open.ldc_const_unoprl xu
       WHERE oi.legal_item_amount > 0 --= 1 --200-2532
         AND xu.tipo_ofertado = 5 --200-2532
         AND iu.liquidacion = 'I'
         AND iu.actividad = -1
         AND ot.order_id = otn.order_id
         AND ot.order_id = oi.order_id
         AND ot.operating_unit_id = iu.unidad_operativa
         AND oi.items_id = iu.item
         AND ot.task_type_id = uy.tipo_trabajo
         AND ot.operating_unit_id = xu.unidad_operativa --200-2532
       GROUP BY ot.operating_unit_id,
                ot.order_id,
                iu.actividad,
                oi.items_id,
                iu.liquidacion;
  
    ------
    nucontaotnove    NUMBER(6);
    nuitems          open.ge_items.items_id%TYPE;
    nucontaconfigura NUMBER(4) DEFAULT 0;
    ------
  
    --REA264 Variables
    nuerrorcode    number;
    sberrormessage varchar2(4000);
    sbcontrolerror varchar2(4000);
    ----------------------
  
    --REQ.264.
  BEGIN
  
    --Loop 1
    FOR i IN cuordenesgenerarnovedadact(nuparacta) LOOP
    
      nucontaotnove    := 0;
      nuitems          := i.nuitemss;
      nucontaconfigura := 0;
      --
      SELECT COUNT(1)
        INTO nucontaconfigura
        FROM open.ldc_const_liqtarran qw
       WHERE qw.unidad_operativa = i.unidad_operativa
         AND qw.actividad_orden = i.actividad
         AND qw.items = nuitems
         AND qw.zona_ofertados = -1
         AND qw.valor_liquidar >= 1
         AND trunc(dtpasfecfin) BETWEEN trunc(qw.fecha_ini_vigen) AND
             trunc(qw.fecha_fin_vige);
    
      dbms_output.put_line('Cantidad configuracion: ' || nucontaconfigura);
    
      --
      IF nucontaconfigura >= 1 THEN
        BEGIN
        
          dbms_output.put_line('-------------------------------------------');
        
          /*
          INSERT INTO open.ldc_uni_act_ot
            (nussesion,
             unidad_operativa,
             orden,
             actividad,
             item,
             cantidad_item_legalizada,
             liquidacion,
             nro_acta,
             unidad_operativa_padre,
             zona_ofertados)
          VALUES
            (nuparsesion,
             i.unidad_operativa,
             i.orden,
             i.actividad,
             nuitems,
             i.cantidad_legalizada,
             i.liquidacion,
             nuparacta,
             -1,
             -1);
             --*/
        
          dbms_output.put_line('nuparsesion: ' || nuparsesion);
          dbms_output.put_line('i.unidad_operativa: ' ||
                               i.unidad_operativa);
          dbms_output.put_line('i.orden: ' || i.orden);
          dbms_output.put_line('i.actividad: ' || i.actividad);
          dbms_output.put_line('nuitems: ' || nuitems);
          dbms_output.put_line('i.cantidad_legalizada: ' ||
                               i.cantidad_legalizada);
          dbms_output.put_line('i.liquidacion: ' || i.liquidacion);
          dbms_output.put_line('nuparacta: ' || nuparacta);
          dbms_output.put_line('-1');
          dbms_output.put_line('-1');
        
        END;
        --
      END IF;
      --
    END LOOP; --Fin Loop 1
  
  END;

  ------
  --*/

BEGIN
  dbms_output.enable(1000000);
  select nvl(l.value_chain, 'N')
    into sbOmiteCursor
    from open.ld_parameter l
   where l.parameter_id = 'OMITE_VALID_CUORDENESNOVGENVAL';

  dbms_output.put_line('Omite Cursor OMITE_VALID_CUORDENESNOVGENVAL: ' ||
                       sbOmiteCursor);

  nucantidadnovgen := 0;
  nutotalvalornov  := 0;

  -- Consultamos datos para registrar inicio del proceso
  BEGIN
    SELECT to_number(to_char(SYSDATE, 'YYYY')),
           to_number(to_char(SYSDATE, 'MM')),
           userenv('SESSIONID'),
           USER
      INTO nuccano, nuccmes, nusession, sbuser
      FROM dual;
  END;
  dbms_output.put_line('Año: ' || nuccano);
  dbms_output.put_line('Mes: ' || nuccmes);
  dbms_output.put_line('Sesion: ' || nusession);
  dbms_output.put_line('Usuario: ' || sbuser);

  --REQ.264
  -- Obtenemos la fecha fin del acta
  dbms_output.put_line('Acta: ' || nupaacta);
  BEGIN
    SELECT c.fecha_fin
      INTO dtfechafinacta
      FROM open.ge_acta c
     WHERE c.id_acta = nupaacta;
  
    dbms_output.put_line('Fecha Fin Acta: ' || dtfechafinacta);
  
  END;

  --REQ.264.
  -- Llenamos la tabla con las ordenes las supuestas a generar novedades
  /*
  BEGIN
    ldcprollenaldcuniactot(nupaacta, dtfechafinacta, nusession);
  END;
  --*/

  --/*
  --REQ.264.
  BEGIN
    nusw := 0;
    -- Recorremos las actividades de las ots en el acta por unidad de trabajo
    --Loop 2
    FOR i IN cuordernesacta(nusession, nupaacta, dtfechafinacta) LOOP
    
      if nvl(nuanterior, 0) <> i.ORDEN_HIJA then
        dbms_output.put_line('Total Ordenes Nieta: ' || nuTotalOrdenHija);
        dbms_output.put_line('-------------------------------------------------------------');
        dbms_output.put_line('Orden Hija: ' || i.ORDEN_HIJA);
        nuanterior := i.ORDEN_HIJA;
        nuTotalOrdenHija := 0;
      end if;
      -- Consultamos los rangos configurados para la unidad en especifica
      SELECT COUNT(1)
        INTO nucontarang
        FROM open.ldc_const_liqtarran k
       WHERE k.unidad_operativa = i.unidad_operativa;
    
      -- Consultamos los rangos configurados para la unidad de trabajo -1
      SELECT COUNT(1)
        INTO nucontarangmenos1
        FROM open.ldc_const_liqtarran k
       WHERE k.unidad_operativa = -1;
    
      -- Validamos si la unidad operativa tiene rangos configurados en caso contrario se tomaria el valor -1 para la unidad de trabajo
      IF nucontarang >= 1 THEN
        nuvarunidad := i.unidad_operativa;
      ELSIF nucontarangmenos1 >= 1 THEN
        nuvarunidad := -1;
      ELSE
        nuvarunidad := 0;
      END IF;
    
      -- Consultamos los rangos
      nureg      := -1;
      nuvalfinal := NULL;
      --
    
      --dbms_output.put_line('Paso 0');
    
      --REQ.264.
      BEGIN
        --Loop 3
        FOR j IN curangos(nuvarunidad, i.actividad, i.item, dtfechafinacta) LOOP
          nureg            := -1;
          nuvalfinal       := j.cantidad_final;
          nuvalordescontar := nvl(j.valor_liquidar, 0);
          --dbms_output.put_line('nuvalordescontar: ' || nuvalordescontar);
          -- Obtenemos la cantidad
          numetroslineal := 0;
        
          SELECT xt.metro_lineal
            INTO numetroslineal
            FROM open.ldc_ordenes_ofertados_redes xt
           WHERE xt.orden_hija =
                 (SELECT t.orden_hija
                    FROM open.ldc_ordenes_ofertados_redes t
                   WHERE t.orden_nieta = i.orden)
             AND xt.orden_padre IS NOT NULL
             AND xt.orden_nieta IS NULL;
        
          -- Validamos si la cantidad esta en un rango
          IF numetroslineal BETWEEN j.cantidad_inicial AND j.cantidad_final THEN
            nureg := 0;
            EXIT;
          END IF;
        
        END LOOP; --Fin Loop 3
      
      END;
    
      -- Si la cantidad no esta en ningun rango, validamos si es mayor al ultimo rango
      IF nureg = -1 THEN
        IF numetroslineal > nuvalfinal AND nuvalfinal IS NOT NULL THEN
          nureg := 0;
        END IF;
      END IF;
    
      --dbms_output.put_line('nureg: '|| nureg);
      -- Si es mayor al ultimo rango, generamos las novedades
      IF nureg = 0 THEN
        --REQ.264.
        BEGIN
          -- Generamos las novedades para cada una de las ordenes
          --Loop 4
          dbms_output.put_line('i.unidad_operativa [' ||
                               i.unidad_operativa || '] - i.actividad  [' ||
                               i.actividad || '] - i.item  [' || i.item ||
                               '] - nusession [' || nusession ||
                               '] - nupaacta [' || nupaacta ||
                               '] - i.orden  [' || i.orden || ']');
          FOR j IN cuordernesactaot(i.unidad_operativa,
                                    i.actividad,
                                    i.item,
                                    nusession,
                                    nupaacta,
                                    i.orden,
                                    dtfechafinacta) LOOP
          
            --dbms_output.put_line('Paso -1');
          
            nuorderid := NULL;
            --
            BEGIN
              SELECT pe.person_id
                INTO nupersona
                FROM open.sa_user us, open.ge_person pe
               WHERE us.mask = decode(USER, 'OPEN', 'ADMIOPEF', USER)
                 AND us.user_id = pe.user_id;
            EXCEPTION
              WHEN no_data_found THEN
                nupersona := NULL;
                NULL;
            END;
          
            --
            --dbms_output.put_line('nuvalordescontar: ' || nuvalordescontar);
            IF nvl(nuvalordescontar, 0) >= 1 THEN
            
              nuvalordescontarxcant := nvl(nuvalordescontar, 0) *
                                       j.cantidad_legalizada;
              sbmensaje             := NULL;
              --
              --REQ.264
              BEGIN
                SELECT ox.*
                  INTO regor_order
                  FROM open.or_order ox
                 WHERE ox.order_id = j.order_id;
              END;
            
              -- Obtenemos la novedad asociada al tipo de trabajo
              BEGIN
                SELECT ti.ACTIVIDAD_POSITIVA
                  INTO nunovedadgenera
                  FROM open.ldc_tipo_trab_x_nov_ofertados ti
                 WHERE ti.tipo_trabajo = regor_order.task_type_id;
              END;
            
              --dbms_output.put_line('Novedad a Generar: ' ||nunovedadgenera);
            
              --dbms_output.put_line('Paso 1');
            
              -- Validamos si la ord?n tiene una novedad y si es asi el valor este actualizado en los rangos
              swencontro := 0;
              nuposireg  := 0;
            
              --REQ.264.
              /*
              BEGIN
                --Loop 5
                dbms_output.put_line('j.order_id: ' || j.order_id ||
                                     ', i.actividad: ' || i.actividad ||
                                     ', i.item: ' || i.item);
                FOR x IN cuordenesnovgenval(j.order_id, i.actividad, i.item) LOOP
                
                  --dbms_output.put_line('Paso 1');
                  IF sbOmiteCursor = 'N' THEN
                    nuposireg := nuposireg + 1;
                  
                    IF nuposireg = 1 THEN
                      dbms_output.put_line('x.value_reference[' ||
                                           x.value_reference ||
                                           '] <> nuvalordescontarxcant[' ||
                                           nuvalordescontarxcant || ']');
                      IF x.value_reference <> nuvalordescontarxcant THEN
                        dbms_output.put_line('DIFERENTE');
                        --UPDATE open.or_order_activity b SET b.value_reference = nuvalordescontarxcant WHERE b.order_activity_id = x.order_activity_id;
                      END IF;
                    
                    ELSE
                      dbms_output.put_line('IGUAL');
                      --UPDATE open.or_order_activity b SET b.value_reference = 0 WHERE b.order_activity_id = x.order_activity_id;
                    END IF;
                  
                  END IF;
                  --
                  swencontro := 1;
                  --
                END LOOP; --Fin Loop 5
              
              END;
              --*/
            
              sbcompletobser := 'Unidad operativa padre : ' ||
                                to_char(i.unidad_operativa);
              --          
              IF nunovedadgenera IS NOT NULL THEN
                nucantidadnovgen := nvl(nucantidadnovgen, 0) + 1;
                nutotalvalornov  := nvl(nutotalvalornov, 0) +
                                    nvl(nuvalordescontarxcant, 0);
                --
                --dbms_output.put_line('swencontro: ' || swencontro);
              
                IF swencontro = 0 THEN
                  --REQ.264.
                  BEGIN
                    nuTotalOrdenHija:=nuTotalOrdenHija+nuvalordescontarxcant;
                    dbms_output.put_line('Novedad a Generar: ' ||
                                         nunovedadgenera ||
                                         ' - Valor descontar: ' ||
                                         nuvalordescontar ||
                                         ' - Cantidad: ' ||
                                         j.cantidad_legalizada ||
                                         ' - Valor Final: ' ||
                                         nvl(nuvalordescontarxcant, 0));
                  
                    /*
                    or_boorder.closeorderwithproduct(nunovedadgenera,
                                                     regor_order.operating_unit_id,
                                                     regor_order.causal_id,
                                                     nupersona,
                                                     j.address_id,
                                                     SYSDATE,
                                                     1,
                                                     nvl(nuvalordescontarxcant,
                                                         0),
                                                     1400,
                                                     'ACTA_OFERTADOS : ' ||
                                                     to_char(nupaacta,
                                                             '000000000000000') ||
                                                     ' [RFACTA] Se genera novedad valor a desconta por rango y tarifa. Registro ' ||
                                                     to_char(nuidenregi) || ' ' ||
                                                     sbcompletobser --,'[RFACTA] Se genera novedad valor a desconta por rango y tarifa. Registro '||to_char(nuidenregi)||' '||sbcompletobser  --200-2532
                                                    ,
                                                     j.order_id,
                                                     14,
                                                     j.package_id,
                                                     j.motivo,
                                                     NULL,
                                                     NULL,
                                                     j.producto,
                                                     nuorderid);
                      --*/
                  END;
                  --
                
                  /*
                  IF nuorderid IS NOT NULL THEN
                    nucontanov := nucontanov + 1;
                    --
                    UPDATE open.or_order v
                       SET v.defined_contract_id  = regor_order.defined_contract_id,
                           v.legalization_date    = regor_order.legalization_date,
                           v.exec_initial_date    = regor_order.exec_initial_date,
                           v.execution_final_date = regor_order.execution_final_date,
                           v.exec_estimate_date   = regor_order.exec_estimate_date,
                           v.is_pending_liq       = NULL
                     WHERE v.order_id = nuorderid;
                    --
                  
                    UPDATE open.or_order_activity gh
                       SET gh.comment_ = 'Orden de novedad generada ACTIVIDAD : ' ||
                                         to_char(i.actividad) || ' ITEM : ' ||
                                         to_char(i.item)
                     WHERE gh.order_id = nuorderid;
                  
                    --REQ.264
                    BEGIN
                      INSERT INTO ct_order_certifica
                        (order_id, certificate_id)
                      VALUES
                        (nuorderid, nupaacta);
                      nusw := 1;
                    END;
                  
                  END IF;
                  --*/
                
                END IF;
              
              END IF;
            
            ELSE
            
              IF sbOmiteCursor = 'N' then
                --200-2530
                nuvalordescontarxcant := nuvalordescontar;
                --REQ.264
                BEGIN
                  --Loop 6
                  FOR x IN cuordenesnovgenval(j.order_id,
                                              i.actividad,
                                              i.item) LOOP
                    IF x.value_reference <> nuvalordescontarxcant THEN
                      dbms_output.put_line('DIFERENTE 2.0');
                      --UPDATE open.or_order_activity b SET b.value_reference = nuvalordescontarxcant WHERE b.order_activity_id = x.order_activity_id;
                    END IF;
                  END LOOP; --Fin Loop 6
                
                END;
              
              END IF; --200-2530
            
            END IF; --Fin si
          
          END LOOP; --Fin Loop 4
        
        END;
      
      END IF;
    
    END LOOP; --Fin loop 2
  
  END;
  --

  dbms_output.put_line('Total Ordenes Nieta: ' || nuTotalOrdenHija);
  --dbms_output.put_line('nusw: ' || nusw);
  IF nusw = 1 THEN
    --UPDATE ge_acta s SET s.is_pending = 1 WHERE s.id_acta = nupaacta;
    null;
  END IF;
  --

  --

  sbmensaje := 'Se procesaron : ' || to_char(nucontanov) || ' registros.';

  --*/

END;
