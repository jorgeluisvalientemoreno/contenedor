create or replace PROCEDURE ADM_PERSON.LDC_PROGENERANOVELTYRANGOXASIG(nupaacta ge_acta.id_acta%TYPE) IS
/**************************************************************************************

   Propiedad intelectual de HORBATH TECNOLOGIES

    Unidad         : ldc_progeneranoveltyrangoxasig
    Descripcion    : Procedimiento para generar las novedades
                     de las unidades operativas de ingenieria.

    Autor          : John Jairo Jimenez Marimon
    Fecha          : 26-07-2020

    CASO           : 0000455

    Historia de Modificaciones
    Fecha             Autor               Modificacion
    ==========        ==================  ======================================
****************************************************************************************/
---
dtfechainiacta  DATE;
dtfechafinacta  DATE;
sbEntrega       VARCHAR2(30):='0000455';
CURSOR cuordernesacta(nucurtacta ge_acta.id_acta%TYPE) IS
 SELECT ot.operating_unit_id             unidad_operativa
       ,ot.order_id                      orden
       ,trunc(ot.assigned_date)          fecha_asignacion
       ,oa.activity_id                   actividad_rango
       ,oa.activity_id			             actividad_orden
       ,-1                               nuitemss
       ,iu.liquidacion                   liquidacion
       ,ot.task_type_id                  tipo_trab_ot
       ,actividad_novedad_ofertados      actividad_novedad_ofertada
       ,oa.package_id                    solicitud
       ,oa.motive_id                     motivo
       ,oa.product_id                    producto
       ,nvl(ot.external_address_id,oa.address_id)           direccion
       ,ot.geograp_location_id           localidad
       ,nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
  FROM open.or_order ot
      ,open.or_order_activity oa
      ,open.or_order_items oi
      ,open.ldc_item_uo_lr iu
      ,open.ct_order_certifica oc
      ,open.ldc_tipo_trab_x_nov_ofertados cx
      ,open.ldc_const_unoprl xu
 WHERE oc.certificate_id    = nucurtacta
   AND oi.value            > 0
   AND iu.liquidacion       = 'A'
   AND xu.tipo_ofertado     = 6
   AND ot.order_id          = oc.order_id
   AND ot.order_id          = oa.order_id
   AND oa.order_activity_id = open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
   AND ot.order_id          = oi.order_id
   AND ot.operating_unit_id = iu.unidad_operativa
   AND oa.activity_id       = iu.actividad
   AND oi.items_id          = decode(iu.item,-1,oi.items_id,iu.item)
   AND ot.task_type_id      = cx.tipo_trabajo
   AND ot.operating_unit_id = xu.unidad_operativa
 GROUP BY ot.operating_unit_id
         ,ot.order_id
         ,trunc(ot.assigned_date)
         ,oa.activity_id
         ,-1
         ,iu.liquidacion
         ,ot.task_type_id
         ,actividad_novedad_ofertados
         ,oa.package_id
         ,oa.motive_id
         ,oa.product_id
         ,nvl(ot.external_address_id,oa.address_id)
         ,ot.geograp_location_id
  UNION ALL
 SELECT ot.operating_unit_id             unidad_operativo
       ,ot.order_id                      orden
       ,trunc(ot.assigned_date)          fecha_asignacion
       ,iu.actividad                     actividad_rango
       ,oa.activity_id		               actividad_orden
       ,oi.items_id                      nuitemss
       ,iu.liquidacion                   liquidacion
       ,ot.task_type_id                  tipo_trab_ot
       ,actividad_novedad_ofertados      actividad_novedad_ofertada
       ,oa.package_id                    solicitud
       ,oa.motive_id                     motivo
       ,oa.product_id                    producto
       ,nvl(ot.external_address_id,oa.address_id)          direccion
       ,ot.geograp_location_id           localidad
       ,nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
   FROM open.or_order ot
       ,open.or_order_activity oa
       ,open.or_order_items oi
       ,open.ldc_item_uo_lr iu
       ,open.ct_order_certifica oc
       ,open.ldc_tipo_trab_x_nov_ofertados cx
       ,open.ldc_const_unoprl xu
  WHERE oc.certificate_id    = nucurtacta
    AND oi.value             > 0
    AND iu.liquidacion       = 'I'
    AND xu.tipo_ofertado     = 6
    AND iu.actividad         = -1
    AND ot.order_id          = oc.order_id
    AND ot.order_id          = oa.order_id
    AND oa.order_activity_id = open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
    AND ot.order_id          = oi.order_id
    AND ot.operating_unit_id = iu.unidad_operativa
    AND oa.activity_id       = decode(iu.actividad,-1,oa.activity_id,iu.actividad)
    AND oi.items_id          = iu.item
    AND ot.task_type_id      = cx.tipo_trabajo
    AND ot.operating_unit_id = xu.unidad_operativa
  GROUP BY ot.operating_unit_id
         ,ot.order_id
         ,trunc(ot.assigned_date)
         ,iu.actividad
         ,oa.activity_id
         ,oi.items_id
         ,iu.liquidacion
         ,ot.task_type_id
         ,actividad_novedad_ofertados
         ,oa.package_id
         ,oa.motive_id
         ,oa.product_id
         ,nvl(ot.external_address_id,oa.address_id)
         ,ot.geograp_location_id;

 CURSOR curangos(
                 nucuunidadoper or_operating_unit.operating_unit_id%TYPE
                ,nucuactividad  or_order_activity.activity_id%TYPE
                ,nucuitems      ge_items.items_id%TYPE
                ,nucuzonaofer   ldc_zona_ofer_cart.id_zona_oper%TYPE
				,dtcufechaasig  ldc_const_liqtarran.fecha_ini_vigen%TYPE
                 ) IS
  SELECT lq.cantidad_inicial,lq.cantidad_final,lq.valor_liquidar
    FROM open.ldc_const_liqtarran lq
   WHERE lq.unidad_operativa                                = nucuunidadoper
     AND lq.actividad_orden                                 = nucuactividad
     AND lq.items                                           = nucuitems
     AND lq.zona_ofertados                                  = nucuzonaofer
     AND dtcufechaasig BETWEEN trunc(lq.fecha_ini_vigen) AND trunc(lq.fecha_fin_vige)
   ORDER BY cantidad_inicial;

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
nuZonaOfertados       ldc_const_liqtarran.zona_ofertados%type;
-----------------------------------------------------------------------------------------------
BEGIN
 IF fblaplicaentregaxcaso(sbEntrega) THEN
  nucantidadnovgen := 0;
  nutotalvalornov  := 0;
  -- Consultamos datos para registrar inicio del proceso
  SELECT to_number(to_char(SYSDATE,'YYYY')),to_number(to_char(SYSDATE,'MM')),userenv('SESSIONID'),USER INTO nuccano,nuccmes,nusession,sbuser
    FROM dual;
  -- Registramos inicio del proceso
  ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROGENERANOVELTYRANGOXASIG','En ejecucion..',nupaacta,sbuser);
  -- Obtenemos la fecha inicio y fin del acta
  BEGIN
   SELECT k.fecha_inicio,k.fecha_fin,k.id_contrato INTO dtfechainiacta,dtfechafinacta,nucontratoacta
     FROM open.ge_acta k
    WHERE k.id_acta = nupaacta;
  EXCEPTION
   WHEN no_data_found THEN
    sbmensaje := 'No existe un acta con el id : '||nupaacta;
    ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENERANOVELTYRANGOXASIG','Termino con errores.');
    RETURN;
  END;
  -- Validamos que la fecha fin de acta no sea null
 IF dtfechafinacta IS NULL THEN
  sbmensaje := 'No se encontr? fecha final al acta nro : '||nupaacta;
  ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENERANOVELTYRANGOXASIG','Termino con errores.');
  RETURN;
 END IF;
 dtfechafinacta := to_date(to_char(dtfechafinacta,'DD/MM/YYYY')||' 00:00:00','DD/MM/YYYY HH24:MI:SS');
 -- Recorremos las actividades de las ots en el acta por unidad de trabajo
 nusw := 0;
 FOR i IN cuordernesacta(nupaacta) LOOP
   --Halla la zona de ofertados de la unidad operativa
   nuZonaOfertados := -1;
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
   -- Obtenemos el periodo contable de la fecha de asignaci?n de la ord?n
   BEGIN
    SELECT cc.cicoano,cc.cicomes INTO nuvaanoper,nuvamesper
      FROM open.ldc_ciercome cc
     WHERE i.fecha_asignacion BETWEEN cc.cicofein AND cc.cicofech;
   EXCEPTION
    WHEN no_data_found THEN
     sbmensaje := 'La de asignaci?n de la ord?n, no esta contenida en un periodo contable';
     ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENERANOVELTYRANGOXASIG','Termino con errores.');
     RETURN;
   END;
   -- Consultamos la cantidad asignada en el mes que se esta liquidando
   nucantidad := 0;
  BEGIN
   SELECT nvl(SUM(sa.cantidad_asignada),0) INTO nucantidad
     FROM open.ldc_cant_asig_ofer_cart sa
    WHERE sa.nuano                = nuvaanoper
      AND sa.numes                = nuvamesper
      AND sa.unidad_operatva_cart = i.unidad_operativa
      AND sa.actividad            = i.actividad_orden
      AND sa.zona_ofertados       = -1
      AND sa.reg_activo           = 'Y';
  EXCEPTION
   WHEN no_data_found THEN
	 nucantidad := 0;
  END;
   -- Consultamos los rangos
  nureg      := -1;
  nuvalfinal := NULL;
  FOR j IN curangos(nuvarunidad,i.actividad_rango,i.nuitemss,-1,i.fecha_asignacion) LOOP
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
      nupersona :=ge_bopersonal.fnugetpersonid;
    EXCEPTION
     WHEN no_data_found THEN
           nupersona := NULL;
	 WHEN OTHERS THEN
		   nupersona := NULL;
    END;

    IF nvl(nuvalordescontar,0) >= 1 THEN
       nuvalordescontarxcant := nvl(nuvalordescontar,0) * i.cantidad_legalizada;
       sbmensaje    := NULL;
       -- Obtenemos la novedad asociada al tipo de trabajo
       nunovedadgenera := i.actividad_novedad_ofertada;
       -- Validamos si la orden tiene una novedad para que no genere otra
       swencontro := 0;
       sbcompletobser := 'Unidad operativa padre : '||to_char(i.unidad_operativa);
      IF nunovedadgenera IS NOT NULL THEN
       nucantidadnovgen := nvl(nucantidadnovgen,0) + 1;
       nutotalvalornov  := nvl(nutotalvalornov,0) + nvl(nuvalordescontarxcant,0);
       IF swencontro = 0 THEN
       -- IF j.cantidad_legalizada = 1 THEN
         or_boorder.closeorderwithproduct(
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
                                         ,i.orden
                                         ,14
                                         ,i.solicitud
                                         ,i.motivo
                                         ,NULL
                                         ,NULL
                                         ,i.producto
                                         ,nuorderid
                                        );
        IF nuorderid IS NOT NULL THEN
         nucontanov := nucontanov + 1;
         UPDATE open.or_order v
            SET v.defined_contract_id  = nucontratoacta
               ,v.legalization_date    = dtfechafinacta
               ,v.exec_initial_date    = dtfechafinacta
               ,v.execution_final_date = dtfechafinacta
               ,v.exec_estimate_date   = dtfechafinacta
               ,v.is_pending_liq       = NULL
               ,v.external_address_id  = i.direccion
               ,v.geograp_location_id  = i.localidad
          WHERE v.order_id             = nuorderid;
          UPDATE open.or_order_activity gh
             SET gh.comment_   = 'Orden de novedad generada ACTIVIDAD : '||to_char(i.actividad_orden)||' ITEM : '||to_char(i.nuitemss)||' CANTIDAD : '||to_char(nucantidad)
                ,gh.address_id = i.direccion
           WHERE gh.order_id = nuorderid;
          INSERT INTO ct_order_certifica(order_id,certificate_id) VALUES(nuorderid,nupaacta);
          nusw := 1;
        END IF;
        END IF;
       END IF;
    END IF;
  END IF;
 END LOOP;
 IF nusw = 1 THEN
  UPDATE ge_acta s
     SET s.is_pending = 1
   WHERE s.id_acta = nupaacta;
 END IF;
 DELETE ldc_uni_act_ot lk WHERE lk.nussesion = nusession AND lk.nro_acta = nupaacta;
 INSERT INTO ldc_actas_aplica_proc_ofert(
                                         acta
                                        ,procejec
                                        ,novgenera
                                        ,total_nove
                                        ,usuario
                                        ,fecha
                                        )
                                 VALUES(
                                        nupaacta
                                       ,'LDC_PROGENERANOVELTYRANGOXASIG'
                                       ,nucantidadnovgen
                                       ,nutotalvalornov
                                       ,USER
                                       ,SYSDATE
                                       );
    -- Actualizamos registro de ordenes asignadas
   UPDATE ldc_cant_asig_ofer_cart sa
      SET sa.nro_acta             = nupaacta
    WHERE sa.nuano                = nuvaanoper
      AND sa.numes                = nuvamesper
      and sa.reg_activo           = 'Y'
      AND sa.nro_acta             = -1
      AND sa.unidad_operatva_cart IN (SELECT DISTINCT od.operating_unit_id
                                        FROM OPEN.ct_order_certifica oc , open.or_order od
                                       WHERE oc.order_id       = od.order_id
                                         AND oc.certificate_id = nupaacta);
 sbmensaje := 'Se procesaron : '||to_char(nucontanov)||' registros.';
 ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENERANOVELTYRANGOXASIG','Termino Ok.');
 END IF;
EXCEPTION
 WHEN OTHERS THEN
  sbmensaje := SQLERRM;
  ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENERANOVELTYRANGOXASIG','Termino con errores.');
  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
  ut_trace.trace('LDC_PROGENERANOVELTYRANGOXASIG '||' '||SQLERRM, 11);
END LDC_PROGENERANOVELTYRANGOXASIG;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROGENERANOVELTYRANGOXASIG', 'ADM_PERSON');
END;
/
