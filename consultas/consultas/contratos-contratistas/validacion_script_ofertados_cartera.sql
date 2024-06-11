--alter session set current_schema = open
declare
nupaacta ge_acta.id_acta%TYPE := 124089;
---

dtfechainiacta        DATE;
dtfechafinacta        DATE;
nuact_w number;
nuite_w number;
CURSOR curesumenliquidacion(nucurtacta NUMBER,nupaano NUMBER,nupames NUMBER,nupauotr NUMBER) IS
  SELECT unidad_operativa,actividad,actividad_novedad_ofertados,item,liquidacion,zona_ofertados,SUM(cantidad_legalizada) cantidad_legalizada
  FROM(
SELECT orden
       ,unidad_operativa
       ,CASE WHEN actividad IS NULL THEN
         actividad_
        ELSE
         actividad
        END actividad
       ,actividad_novedad_ofertados
       ,nuitemss item
       ,liquidacion
       ,zona_ofertados
       ,cantidad_legalizada
   FROM(
        SELECT ot.order_id          orden
              ,ot.operating_unit_id unidad_operativa
              ,oa.activity_id       actividad_
              ,cx.actividad_novedad_ofertados
              ,iu.item              nuitemss
              ,iu.liquidacion       liquidacion
              ,CASE WHEN (
                          SELECT COUNT(1)
                            FROM open.ldc_const_liqtarran bv
                           WHERE bv.unidad_operativa = ot.operating_unit_id
                             AND bv.zona_ofertados   = -1
                             AND trunc(SYSDATE) BETWEEN bv.fecha_ini_vigen AND bv.fecha_fin_vige
                          ) >= 1 THEN
                -1
               ELSE
                zo.id_zona_oper
               END zona_ofertados
              ,1 cantidad_legalizada
              ,(
                SELECT h.actividad_padre
                  FROM open.ldc_act_father_act_hija h
                 WHERE h.actividad_padre = oa.activity_id
                 UNION
                SELECT h.actividad_padre
                  FROM open.ldc_act_father_act_hija h
                 WHERE h.actividad_hija = oa.activity_id
                ) actividad
          FROM open.or_order ot
              ,open.or_order_activity oa
              ,open.ldc_item_uo_lr iu
              ,open.ct_order_certifica oc
              ,open.ab_address ab
              ,open.ldc_tipo_trab_x_nov_ofertados cx
              ,open.ldc_zona_loc_ofer_cart zo
              ,open.ldc_const_unoprl xu
         WHERE oc.certificate_id       = nucurtacta
           and ot.operating_unit_id = nupauotr -- Cambio 211
           AND iu.liquidacion          in ('A','I')
           --AND xu.tipo_ofertado        = 2
           AND ot.order_status_id      = 8
           AND ot.order_id             = oc.order_id
           AND ot.order_id             = oa.order_id
           AND oa.order_activity_id    = open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
           AND ot.operating_unit_id    = iu.unidad_operativa
           AND oa.activity_id          = iu.actividad
           --AND iu.item                 = -1
           AND ot.external_address_id  = ab.address_id
           AND ot.task_type_id         = cx.tipo_trabajo
           AND ab.geograp_location_id  = zo.localidad
           AND ot.operating_unit_id    = xu.unidad_operativa
        )
         UNION ALL
        SELECT orden
              ,unidad_operativa
              ,actividad
              ,actividad_novedad_ofertados
              ,nuitemss
              ,liquidacion
              ,zona_ofertado
              ,nvl(SUM(cantidad_legalizada),0) cantidad_legalizada
          FROM(
               SELECT orden
                     ,unidad_operativa
                     ,CASE WHEN actividad IS NULL THEN
                       actividad_
                      ELSE
                       actividad
                      END actividad
                     ,actividad_novedad_ofertados
                     ,nuitemss
                     ,liquidacion
                     ,zona_ofertado
                     ,cantidad_legalizada
                 FROM(
                      SELECT sca.orden
                            ,sca.unidad_operativa
                            ,sca.actividad_
                            ,actividad_novedad_ofertados
                            ,-1                   nuitemss
                            ,iu.liquidacion       liquidacion
                            ,CASE WHEN (
                                          SELECT COUNT(1)
                                            FROM open.ldc_const_liqtarran bv
                                           WHERE bv.unidad_operativa = sca.unidad_operativa
                                             AND bv.zona_ofertados = -1
                                             AND trunc(SYSDATE) BETWEEN bv.fecha_ini_vigen AND bv.fecha_fin_vige
                                          ) >= 1 THEN
                                -1
                             ELSE
                              zona_ofertado
                             END zona_ofertado
                            ,cantidad_ord_gepaco      cantidad_legalizada
                            ,(SELECT h.actividad_padre
                                FROM open.ldc_act_father_act_hija h
                                WHERE h.actividad_padre = sca.actividad_
                                UNION
                               SELECT h.actividad_padre
                                 FROM open.ldc_act_father_act_hija h
                                WHERE h.actividad_hija   = sca.actividad_
                              ) actividad
                        FROM(
                             SELECT r.orden_nov_generada orden
                                   ,r.unidad_operativa
                                   ,r.actividad_orden actividad_
                                   ,cx.actividad_novedad_ofertados
                                   ,zo.id_zona_oper zona_ofertado
                                   ,r.cantidad_ord_gepaco
                               FROM open.ldc_resumen_ord_ofer_car r
                                   ,ldc_zona_loc_ofer_cart zo
                                   ,open.ldc_tipo_trab_x_nov_ofertados cx
                              WHERE r.nuano            = nupaano
                                AND r.numes            = nupames
                                AND r.unidad_operativa = nupauotr
                                AND r.localidad        = zo.localidad
                                AND r.tipo_rabajo      = cx.tipo_trabajo
                            ) sca,open.ldc_item_uo_lr iu
                       WHERE sca.unidad_operativa = iu.unidad_operativa
                         AND sca.actividad_       = iu.actividad
                         AND iu.item              = -1
                         AND iu.liquidacion       = 'A'
                      )
              )
      GROUP BY orden,unidad_operativa,actividad,actividad_novedad_ofertados,nuitemss,liquidacion,zona_ofertado
      )
    GROUP BY unidad_operativa,actividad,actividad_novedad_ofertados,item,liquidacion,zona_ofertados;

 CURSOR curangos(
                 nucuunidadoper or_operating_unit.operating_unit_id%TYPE
                ,nucuactividad  or_order_activity.activity_id%TYPE
                ,nucuitems      ge_items.items_id%TYPE
                ,nucuzonaofer   ldc_zona_ofer_cart.id_zona_oper%TYPE
                 ) IS
  SELECT lq.cantidad_inicial,lq.cantidad_final,lq.valor_liquidar
    FROM open.ldc_const_liqtarran lq
   WHERE lq.unidad_operativa                                = nucuunidadoper
   --  AND lq.actividad_orden                                 = nucuactividad
     AND lq.items                                           = nucuitems
     AND lq.zona_ofertados                                  = nucuzonaofer
    -- AND trunc(SYSDATE)      BETWEEN trunc(lq.fecha_ini_vigen) AND trunc(lq.fecha_fin_vige)
    AND trunc(dtfechafinacta)  BETWEEN trunc(lq.fecha_ini_vigen) AND trunc(lq.fecha_fin_vige)
   ORDER BY cantidad_inicial;

 CURSOR cuunidadescontra(nucuacta NUMBER) IS
  SELECT xu.unidad_operativa unit_oper,COUNT(1) cantidad
    FROM open.ge_acta ga
        ,open.ge_detalle_acta da
        ,open.ge_items i
        ,open.or_order o
        ,open.ldc_const_unoprl xu
   WHERE ga.id_acta          = nucuacta
     AND i.item_classif_id   <> 23
     AND xu.tipo_ofertado    = 2
     AND ga.id_acta          = da.id_acta
     AND da.id_items         = i.items_id
     AND da.id_orden         = o.order_id
     AND o.operating_unit_id = xu.unidad_operativa
   GROUP BY xu.unidad_operativa;

nuvalordescontar      ldc_const_liqtarran.valor_liquidar%TYPE;
nuvalordescontarxcant ldc_const_liqtarran.valor_liquidar%TYPE;
nunovedadgenera       ldc_const_liqtarran.novedad_generar%TYPE;
nureg                 NUMBER(2);
eerror                EXCEPTION;
nuorderid             or_order.order_id%TYPE DEFAULT NULL;
nupersona             ge_person.person_id%TYPE;
nuidenregi            ldc_const_liqtarran.iden_reg%TYPE;
nuccano               NUMBER(4);
nuccmes               NUMBER(2);
nusession             NUMBER;
sbuser                VARCHAR2(30);
nucontanov            NUMBER(10) DEFAULT 0;
sbmensaje             VARCHAR2(1000);
nuvalfinal            ldc_const_liqtarran.cantidad_final%TYPE;
nucontarang           NUMBER(8);
nucontarangmenos1     NUMBER(8);
nuvarunidad           or_operating_unit.operating_unit_id%TYPE;
nusw                  NUMBER(1) DEFAULT 0;
sbcompletobser        VARCHAR2(100);
nucantidadnovgen      NUMBER(8) DEFAULT 0;
nutotalvalornov       NUMBER(15,2) DEFAULT 0;
nucantidad            NUMBER(8);
swencontro            NUMBER(2);
nuvaanoper            NUMBER(4);
nuvamesper            NUMBER(2);
nucontratoacta        ge_acta.id_contrato%TYPE;
nudireccgene          ab_address.address_id%TYPE;
nulocalidaddirgen     ab_address.geograp_location_id%TYPE;
BEGIN
 nucantidadnovgen := 0;
 nutotalvalornov  := 0;
 -- Consultamos datos para registrar inicio del proceso
 SELECT to_number(to_char(SYSDATE,'YYYY')),to_number(to_char(SYSDATE,'MM')),userenv('SESSIONID'),USER INTO nuccano,nuccmes,nusession,sbuser
   FROM dual;
  -- Registramos inicio del proceso
---dbms_output.put_line('LDC_PROGENERANOVELTYCARTERA  En ejecucion.. ' || nupaacta);
 -- Obtenemos la fecha inicio y fin del acta
 BEGIN
  SELECT k.fecha_inicio,k.fecha_fin,k.id_contrato INTO dtfechainiacta,dtfechafinacta,nucontratoacta
    FROM open.ge_acta k
   WHERE k.id_acta = nupaacta;
 EXCEPTION
  WHEN no_data_found THEN
   sbmensaje := 'No existe un acta con el id : '||nupaacta;
   dbms_output.put_line(nvl(sbmensaje,'Ok') || ' Termino con errores.');
   RETURN;
 END;
  -- Validamos que la fecha inicio no sea null
 IF /*dtfechainiacta*/ dtfechafinacta IS NULL THEN
  sbmensaje := 'No se encontr? fecha final al acta nro : '||nupaacta;
  dbms_output.put_line(nvl(sbmensaje,'Ok') || ' Termino con errores.');
  RETURN;
 END IF;
 /*dtfechainiacta*/ dtfechafinacta := to_date(to_char(dtfechafinacta,'DD/MM/YYYY')||' 00:00:00','DD/MM/YYYY HH24:MI:SS');
 -- Obtenemos el periodo contable
 BEGIN
  SELECT cc.cicoano,cc.cicomes INTO nuvaanoper,nuvamesper
    FROM open.ldc_ciercome cc
   WHERE /*dtfechainiacta*/ dtfechafinacta BETWEEN cc.cicofein AND cc.cicofech;
 EXCEPTION
  WHEN no_data_found THEN
   sbmensaje := 'La fecha inicial del acta, no esta contenida en un periodo contable';
   dbms_output.put_line(nvl(sbmensaje,'Ok') || ' Termino con errores.');
   RETURN;
 END;
 -- Recorremos las actividades de las ots en el acta por unidad de trabajo
 nusw := 0;
 FOR uot IN cuunidadescontra(nupaacta) LOOP
  FOR i IN curesumenliquidacion(nupaacta,nuvaanoper,nuvamesper,uot.unit_oper) LOOP
    dbms_output.put_line('curesumenliquidacion ' || i.unidad_operativa || ' ' || i.actividad || ' ' || i.actividad_novedad_ofertados || ' ' ||
                          i.item || ' ' || i.liquidacion || ' ' || i.zona_ofertados || ' ' || i.cantidad_legalizada);
   -- Consultamos los rangos configurados para la unidad en especifica
   SELECT COUNT(1) INTO nucontarang
     FROM ldc_const_liqtarran k
    WHERE k.unidad_operativa = i.unidad_operativa;
   -- Consultamos los rangos configurados para la unidad de trabajo -1
   SELECT COUNT(1) INTO nucontarangmenos1
     FROM ldc_const_liqtarran k
    WHERE k.unidad_operativa = -1;
    -- Validamos si la unidad operativa tiene rangos configurados en caso contrario se tomaria el valor -1 para la unidad de trabajo
   IF nucontarang >= 1 THEN
     nuvarunidad := i.unidad_operativa;
   ELSIF nucontarangmenos1 >= 1 THEN
     nuvarunidad := -1;
   ELSE
     nuvarunidad := 0;
   END IF;
  -- Consultamos la cantidad asignada en el mes que se esta liquidando
  nucantidad := 0;
 -- dbms_output.put_line('PASO1');
  IF i.zona_ofertados <> -1 THEN
    --dbms_output.put_line('PASO2A i.zona_ofertados <> -1');
    -- Obtenemos la cantidad de actividades asignadas con zonas
   BEGIN
    SELECT nvl(SUM(cantidad_asignada),0) INTO nucantidad
      FROM(
           SELECT nvl(SUM(sa.cantidad_asignada),0) cantidad_asignada
             FROM ldc_cant_asig_ofer_cart sa
            WHERE sa.nuano                = nuvaanoper
              AND sa.numes                = nuvamesper
              AND sa.unidad_operatva_cart = nuvarunidad
              AND sa.tipo_trabajo         = sa.tipo_trabajo
              AND sa.actividad            = i.actividad
              AND sa.zona_ofertados       = i.zona_ofertados
              AND sa.reg_activo           = 'Y'
            UNION ALL
           SELECT nvl(SUM(sa.cantidad_asignada),0) cantidad_asignada
             FROM ldc_cant_asig_ofer_cart sa,open.ldc_act_father_act_hija apah
            WHERE sa.nuano                = nuvaanoper
              AND sa.numes                = nuvamesper
              AND sa.unidad_operatva_cart = nuvarunidad
              AND sa.tipo_trabajo         = sa.tipo_trabajo
              AND apah.actividad_padre    = i.actividad
              AND sa.actividad            = apah.actividad_hija
              AND sa.zona_ofertados       = i.zona_ofertados
              AND sa.reg_activo           = 'Y'
          );
   EXCEPTION
    WHEN no_data_found THEN
   --   dbms_output.put_line('PASO2A no_data_found');
     nucantidad := 0;
   END;
  ELSE
       -- Obtenemos la cantidad de actividades asignadas sin zonas
    --   dbms_output.put_line('PASO2B i.zona_ofertados = -1');
   BEGIN
    SELECT nvl(SUM(cantidad_asignada),0) INTO nucantidad
      FROM(
           SELECT nvl(SUM(sa.cantidad_asignada),0) cantidad_asignada
             FROM ldc_cant_asig_ofer_cart sa
            WHERE sa.nuano                = nuvaanoper
              AND sa.numes                = nuvamesper
              AND sa.unidad_operatva_cart = nuvarunidad
              AND sa.tipo_trabajo         = sa.tipo_trabajo
              AND sa.actividad            = i.actividad
              AND sa.zona_ofertados       = sa.zona_ofertados
              AND sa.reg_activo           = 'Y'
            UNION ALL
           SELECT nvl(SUM(sa.cantidad_asignada),0) cantidad_asignada
             FROM ldc_cant_asig_ofer_cart sa,open.ldc_act_father_act_hija apah
            WHERE sa.nuano                = nuvaanoper
              AND sa.numes                = nuvamesper
              AND sa.unidad_operatva_cart = nuvarunidad
              AND sa.tipo_trabajo         = sa.tipo_trabajo
              AND apah.actividad_padre    = i.actividad
              AND sa.actividad            = apah.actividad_hija
              AND sa.zona_ofertados       = sa.zona_ofertados
              AND sa.reg_activo           = 'Y'
          );
   EXCEPTION
    WHEN no_data_found THEN
    --  dbms_output.put_line('PASO2B no_data_found');
     nucantidad := 0;
   END;
  END IF;
   -- Consultamos los rangos
  -- dbms_output.put_line('nucantidad ' || nucantidad);
  
  nureg      := -1;
  nuvalfinal := NULL;
--  dbms_output.put_line('Iniciara curangos ' ||  nuvarunidad || ' ' || i.actividad || ' ' || i.item || ' ' || i.zona_ofertados);
  if i.liquidacion = 'I' then
    nuact_w := -1;
    nuite_w := i.item;
  else
    nuact_w := i.actividad;
    nuite_w := -1;
  end if;
  FOR j IN curangos(nuvarunidad,i.actividad,i.item,i.zona_ofertados) LOOP
   -- dbms_output.put_line('curangos ' ||  nuvarunidad || ' ' || i.actividad || ' ' || i.item || ' ' || i.zona_ofertados || ' j.cantidad_final: ' || j.cantidad_final);
   nuorderid := null;
   nureg            := -1;
   nuvalfinal       := j.cantidad_final;
   nuvalordescontar := nvl(j.valor_liquidar,0);
   -- Validamos si la cantidad esta en un rango
   IF nucantidad BETWEEN j.cantidad_inicial AND j.cantidad_final THEN
     nureg := 0;
     EXIT;
   END IF;
  END LOOP;
  -- Si la cantidad no esta en ningun rango, validamos si es mayor al ultimo rango
  IF nureg = -1 THEN
   IF nucantidad > nuvalfinal AND nuvalfinal IS NOT NULL THEN
      nureg := 0;
   END IF;
  END IF;
  -- Si es mayor al ultimo rango, generamos las novedades
  IF nureg = 0 THEN
   -- Generamos las novedades para cada una de las ordenes
    nuorderid := NULL;
    BEGIN
     SELECT pe.person_id INTO nupersona
       FROM sa_user us,ge_person pe
      WHERE us.mask = USER
        AND us.user_id = pe.user_id;
    EXCEPTION
     WHEN no_data_found THEN
           nupersona := NULL;
    END;
    IF nvl(nuvalordescontar,0) >= 1 THEN
       nuvalordescontarxcant := nvl(nuvalordescontar,0) * i.cantidad_legalizada;
       sbmensaje    := NULL;
       -- Obtenemos la novedad asociada al tipo de trabajo
       nunovedadgenera := i.actividad_novedad_ofertados;
       -- Validamos si la orden tiene una novedad para que no genere otra
       swencontro := 0;
       sbcompletobser := 'Unidad operativa padre : '||to_char(i.unidad_operativa);
      IF nunovedadgenera IS NOT NULL THEN
       nucantidadnovgen := nvl(nucantidadnovgen,0) + 1;
       nutotalvalornov  := nvl(nutotalvalornov,0) + nvl(nuvalordescontarxcant,0);
       IF swencontro = 0 THEN
       -- IF j.cantidad_legalizada = 1 THEN
         dbms_output.put_line('closeorderwithproduct ' || nunovedadgenera);
         nuorderid := 1;
         /*or_boorder.closeorderwithproduct(
                                          nunovedadgenera
                                         ,i.unidad_operativa
                                         ,1
                                         ,nupersona
                                         ,NULL
                                         ,SYSDATE
                                         ,1
                                         ,nvl(nuvalordescontarxcant,0)
                                         ,1400
                                         ,'ACTA_OFERTADOS : '||to_char(nupaacta,'000000000000000')||' [RFACTA] Se genera novedad valor a desconta por rango y tarifa. Registro '||to_char(nuidenregi)||' '||sbcompletobser
                                         ,NULL
                                         ,14
                                         ,NULL
                                         ,NULL
                                         ,NULL
                                         ,NULL
                                         ,NULL
                                         ,nuorderid
                                        );*/
        IF nuorderid IS NOT NULL THEN
         nucontanov := nucontanov + 1;
         BEGIN
          SELECT xc.direccion_gen_nov,df.geograp_location_id INTO nudireccgene,nulocalidaddirgen
            FROM open.ldc_const_unoprl xc,open.ab_address df
           WHERE xc.unidad_operativa  = i.unidad_operativa
             AND xc.tipo_ofertado     = 2
             AND xc.direccion_gen_nov = df.address_id;
         EXCEPTION
          WHEN no_data_found THEN 
            null;
          /* sbmensaje := 'La unidad operativa : '||to_char(i.unidad_operativa)||' no existe.';
           dbms_output.put_line(nvl(sbmensaje,'Ok') || ' Termino con errores.');
           RETURN;*/
         END;
         IF nudireccgene IS NULL THEN
           null;
           /*sbmensaje := 'La unidad operativa : '||to_char(i.unidad_operativa)||' no tiene o no tiene direccion asociada.';
           dbms_output.put_line(nvl(sbmensaje,'Ok') || ' Termino con errores.');
           RETURN;*/
         END IF;
         dbms_output.put_line('update order');
         /*UPDATE open.or_order v
            SET v.defined_contract_id  = nucontratoacta
               ,v.legalization_date    = dtfechafinacta
               ,v.exec_initial_date    = dtfechafinacta
               ,v.execution_final_date = dtfechafinacta
               ,v.exec_estimate_date   = dtfechafinacta
               ,v.is_pending_liq       = NULL
               ,v.external_address_id  = nudireccgene
               ,v.geograp_location_id  = nulocalidaddirgen
          WHERE v.order_id             = nuorderid;
          UPDATE open.or_order_activity gh
             SET gh.comment_   = 'Orden de novedad generada ACTIVIDAD : '||to_char(i.actividad)||' ITEM : '||to_char(i.item)||' ZONA_OFERTADOS : '||to_char(i.zona_ofertados)||' CANTIDAD : '||to_char(i.cantidad_legalizada)
                ,gh.address_id = nudireccgene
           WHERE gh.order_id = nuorderid;
          INSERT INTO ct_order_certifica(order_id,certificate_id) VALUES(nuorderid,nupaacta);*/
          nusw := 1;
        END IF;
        END IF;
       END IF;
    END IF;
  END IF;
 END LOOP;
 END LOOP;
 IF nusw = 1 THEN
   dbms_output.put_line('UPDATE ge_acta '); 
  /*UPDATE ge_acta s
     SET s.is_pending = 1
   WHERE s.id_acta = nupaacta;*/
 END IF;
 dbms_output.put_line('DELETE ldc_uni_act_ot ');
 dbms_output.put_line('-------------------------------------------------- INSERT ------------------------------ ');
 
 dbms_output.put_line('nucantidadnovgen: ' || nucantidadnovgen || ' nutotalvalornov: ' || nutotalvalornov);
 /*INSERT INTO ldc_actas_aplica_proc_ofert(
                                         acta
                                        ,procejec
                                        ,novgenera
                                        ,total_nove
                                        ,usuario
                                        ,fecha
                                        )
                                 VALUES(
                                        nupaacta
                                       ,'LDC_PROGENERANOVELTYCARTERA'
                                       ,nucantidadnovgen
                                       ,nutotalvalornov
                                       ,USER
                                       ,SYSDATE
                                       );*/
    -- Actualizamos registro de ordenes asignadas
   /*UPDATE ldc_cant_asig_ofer_cart sa
      SET sa.nro_acta             = nupaacta
    WHERE sa.nuano                = nuvaanoper
      AND sa.numes                = nuvamesper
      AND sa.unidad_operatva_cart = nuvarunidad;
 sbmensaje := 'Se procesaron : '||to_char(nucontanov)||' registros.';*/
 dbms_output.put_line('Termino Ok.');
EXCEPTION
 WHEN OTHERS THEN
  sbmensaje := SQLERRM;
  dbms_output.put_line('Termino con Errores ' || sbmensaje);
END;
