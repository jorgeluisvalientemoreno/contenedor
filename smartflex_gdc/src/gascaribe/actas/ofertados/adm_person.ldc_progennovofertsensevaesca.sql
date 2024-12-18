create or replace PROCEDURE adm_person.ldc_progennovofertsensevaesca(nupaacta ge_acta.id_acta%TYPE) IS
/*********************************************************************************************************************************************
    Propiedad intelectual de JM GESTIONINFORMATICA S.A.

    Unidad         : LDC_PROGENNOVOFERTSENSEVAESCA
    Descripcion    : Procedimiento para generar las novedades
                     de ofertados de servicios nuevos y servicios varios
                     escalonados.

    Autor          : John Jairo Jimenez Marimon
    Fecha          : 05-09-2018

    Historia de Modificaciones
    Fecha         Caso         Autor                             Modificacion
    ==========  ==========    ================================  =================================================================================
	  24/04/2024  OSF-2597      Adrianavg                         Se migra del esquema OPEN al esquema ADM_PERSON
    27/03/2019  200-2436      (JJJM)John Jairo Jimenez Marimon  Se reemplaza la consulta que obtiene la cantidad de rangos
                                                                por ciclo for el cual es mas exacto para obtener los rangos incluyendo
                                                                los extremos. IR CON EL PSEUDONIMO (JJJM - 200-2436).
														                                    Se reemplaza cursor curangosaplica, por formula matematica se resta -1
														                                    al else del case. IR CON EL PSEUDONIMO (JJJM - 200-2436).
 	  09/04/2019  200-2436(V2)  (JJJM)John Jairo Jimenez Marimon  Se modifica el procedimiento interno : ldcprollenaldcuniactot
                                                                el cursor, cuordenesgenerarnovedadact para que cuando la liquidacion sea por
                                                                actividad, el item sea -1.
    11/04/2019  200-2436      dsaltarin                         se obtiene el person_id con la funcion nupersona:=ge_bopersonal.fnugetpersonid;
                                                                y se coloca al inicio. se corrige la logica que calcula los rangos.
    18/07/2018  200-2438      John Jairo Jimenez Marimon        200-2438 - Se crea cursor para actividades padres e hijas en el
                                                                procedimeinto : ldcprollenaldcuniactot
***********************************************************************************************************************************************/
---
 CURSOR cuordernesacta(nuparcussion ldc_uni_act_ot.nussesion%TYPE,nucurpacta ldc_uni_act_ot.nro_acta%TYPE) IS
  SELECT t.unidad_operativa
        ,t.actividad
        ,t.item
        ,nvl(SUM(t.cantidad_item_legalizada),0) cantidad
    FROM ldc_uni_act_ot t
   WHERE t.nussesion = nuparcussion
     AND t.nro_acta  = nucurpacta
   GROUP BY t.unidad_operativa
           ,t.actividad
           ,t.item;
 CURSOR cuordernesactaot(
                         nucuunidad   ldc_uni_act_ot.unidad_operativa%TYPE
                        ,nucuactivi   ldc_uni_act_ot.actividad%TYPE
                        ,nucuitem     ldc_uni_act_ot.item%TYPE
                        ,nucupasesion ldc_uni_act_ot.nussesion%TYPE
                        ,nucuacta     ldc_uni_act_ot.nro_acta%TYPE
                        ) IS
SELECT cantidad_legalizada
      ,order_id
      ,identificador
      ,address_id
      ,package_id
      ,motivo
      ,producto
      ,liquidacion
 FROM(
      SELECT t.identificador_reg order_id
            ,t.orden             identificador
            ,oa.address_id
            ,oa.package_id
            ,(SELECT mo.motive_id FROM mo_motive mo WHERE mo.package_id = oa.package_id AND rownum = 1) motivo
            ,oa.product_id producto
            ,t.liquidacion
            ,nvl(t.cantidad_item_legalizada,0) cantidad_legalizada
        FROM ldc_uni_act_ot t
            ,open.or_order_activity oa
       WHERE t.nussesion              = nucupasesion
         AND t.nro_acta               = nucuacta
         AND t.unidad_operativa       = nucuunidad
         AND t.actividad              = nucuactivi
         AND t.item                   = nucuitem
         AND t.unidad_operativa_padre = -1
         AND t.zona_ofertados         = -1
         AND t.identificador_reg      = oa.order_id
         AND oa.order_activity_id     = open.ldc_bcfinanceot.fnugetactivityid(t.identificador_reg)
         AND t.idrangoofer            IS NULL
       )
    ORDER BY cantidad_legalizada DESC;

 CURSOR cuordenesnovgenval(nucuorden NUMBER,nucuactividad NUMBER,nucuitem NUMBER,nucuidregis NUMBER) IS
  SELECT yu.order_activity_id,yu.value_reference,tr.created_date fecha_creacion
    FROM open.or_related_order ro
         ,open.or_order_activity yu
         ,open.or_order tr
         ,open.or_order_items s
   WHERE ro.rela_order_type_id  = 14
     AND tr.order_status_id     = 8
     AND yu.activity_id         IN(
                                    SELECT tx.actividad_novedad_ofertados
                                      FROM open.ldc_tipo_trab_x_nov_ofertados tx
                                     WHERE tx.actividad_novedad_ofertados = yu.activity_id
                                   )
     AND ro.order_id           = nucuorden
     AND TRIM(yu.comment_)     = TRIM('Orden de novedad generada ACTIVIDAD : '||to_char(nucuactividad)||' ITEM : '||to_char(nucuitem)||' REG_ESCALONADO : '||to_char(nucuidregis))
     AND tr.order_id           = s.order_id
     AND ro.related_order_id   = yu.order_id
     AND yu.order_id           = tr.order_id
   ORDER BY fecha_creacion;

 CURSOR curangosaplica(nucucantidad NUMBER,nuunidadoper NUMBER,nucuactividad NUMBER,nucuitem NUMBER,nucantrang NUMBER,dtcufechafinacta DATE) IS
  SELECT l.iden_reg
        ,l.cantidad_inicial
        ,l.cantidad_final
        ,CASE WHEN ((nucucantidad) - cantidad_final) > 0 AND rownum <> nucantrang THEN
          CASE WHEN cantidad_inicial = 0 THEN
          (cantidad_final - cantidad_inicial)
          ELSE
           (cantidad_final - cantidad_inicial) + 1
          END
         ELSE
		  --(JJJM - 200-2436) Inicio modificado
          ---dsaltarin se corrige logica.
          --(nucucantidad - (cantidad_inicial - (nucantrang - 1))) -1
           case when cantidad_inicial=0 then
              nucucantidad - cantidad_inicial
           else
              nucucantidad - cantidad_inicial+1
           end
          --dsaltarin fin
		  -- (JJJM - 200-2436) Fin modificado
        END acum
       ,valor_liquidar
    FROM ldc_const_liqtarran l
   WHERE l.unidad_operativa = nuunidadoper
     AND l.actividad_orden  = nucuactividad
     AND l.items            = nucuitem
     AND trunc(dtcufechafinacta) BETWEEN l.fecha_ini_vigen AND l.fecha_fin_vige
     AND (nucucantidad - (cantidad_inicial - (nucantrang - 1)))   > 0
   ORDER BY cantidad_inicial;

nuvalordescontar      ldc_const_liqtarran.valor_liquidar%TYPE;
nuvalordescontarxcant NUMBER(20,4);
nunovedadgenera       ldc_const_liqtarran.novedad_generar%TYPE;
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
nucontarang           NUMBER(8);
nucontarangmenos1     NUMBER(8);
nuvarunidad           or_operating_unit.operating_unit_id%TYPE;
nusw                  NUMBER(1) DEFAULT 0;
sbcompletobser        VARCHAR2(100);
regor_order           or_order%ROWTYPE;
nucantidadnovgen      NUMBER(8) DEFAULT 0;
nutotalvalornov       NUMBER(20,4) DEFAULT 0;
swencontro            NUMBER(2);
nuposireg             NUMBER(4);
nuacumulavalor        NUMBER(20,4);
nudiferencia          NUMBER(20,4);
nuidentificador       ldc_uni_act_ot.identificador_reg%TYPE;
nucantidadlega        ldc_uni_act_ot.cantidad_item_legalizada%TYPE;
nucantidadregrango    NUMBER(8);
nuvaparamtpoofer      ld_parameter.numeric_value%TYPE;
dtfechafinacta        DATE;
nucantirango          NUMBER(10) DEFAULT 0;
nuresta               NUMBER;
PROCEDURE ldcprollenaldcuniactot(
                                 nuparacta        ge_acta.id_acta%TYPE
                                ,dtsubfechfin     DATE
                                ,nuparsesion      ldc_uni_act_ot.nussesion%TYPE
                                ,nupatipoofertado ld_parameter.numeric_value%TYPE) IS
 CURSOR cuordenesgenerarnovedadact(nucurtacta ge_acta.id_acta%TYPE) IS
  SELECT unidad_operativa_
        ,actividad_
        ,nuitemss
        ,liquidacion
        ,orden
        ,cantidad_legalizada
    FROM(
          SELECT ot.operating_unit_id             unidad_operativa_
                ,ot.order_id                      orden
                ,oa.activity_id                   actividad_
                ,-1                                nuitemss
                ,iu.liquidacion                   liquidacion
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
             AND iu.liquidacion       = 'A'
             AND xu.tipo_ofertado     = nupatipoofertado
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
                   ,oa.activity_id
                   ,oi.items_id
                   ,iu.liquidacion
           UNION ALL
          SELECT ot.operating_unit_id
                ,ot.order_id
                ,iu.actividad
                ,oi.items_id
                ,iu.liquidacion
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
             AND iu.actividad         = -1
             AND xu.tipo_ofertado     = nupatipoofertado
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
                   ,iu.actividad
                   ,oi.items_id
                   ,iu.liquidacion
           UNION ALL
          SELECT uh.unidad_operativa_padre        unidad_operativa
                ,ot.order_id                      orden
                ,oa.activity_id                   actividad
                ,-1                      nuitemss
                ,iu.liquidacion                   liquidacion
                ,nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
            FROM open.or_order ot
                ,open.or_order_activity oa
                ,open.or_order_items oi
                ,open.ldc_item_uo_lr iu
                ,open.ldc_unid_oper_hija_mod_tar uh
                ,open.ct_order_certifica oc
                ,open.ldc_tipo_trab_x_nov_ofertados cx
                ,open.ldc_const_unoprl xu
           WHERE oc.certificate_id         = nucurtacta
             AND oi.value                  > 0
             AND iu.liquidacion            = 'A'
             AND xu.tipo_ofertado          = nupatipoofertado
             AND ot.order_id               = oc.order_id
             AND ot.order_id               = oa.order_id
             AND oa.order_activity_id      = open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
             AND ot.order_id               = oi.order_id
             AND ot.operating_unit_id      = uh.unidad_operativa_hija
             AND iu.unidad_operativa       = uh.unidad_operativa_padre
             AND oa.activity_id            = iu.actividad
             AND oi.items_id               = decode(iu.item,-1,oi.items_id,iu.item)
             AND ot.task_type_id           = cx.tipo_trabajo
             AND uh.unidad_operativa_padre = xu.unidad_operativa
           GROUP BY uh.unidad_operativa_padre
                   ,ot.order_id
                   ,oa.activity_id
                   ,oi.items_id
                   ,iu.liquidacion
           UNION ALL
          SELECT uh.unidad_operativa_padre
                ,ot.order_id
                ,iu.actividad
                ,oi.items_id
                ,iu.liquidacion
                ,nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
            FROM open.or_order ot
                ,open.or_order_activity oa
                ,open.or_order_items oi
                ,open.ldc_item_uo_lr iu
                ,open.ldc_unid_oper_hija_mod_tar uh
                ,open.ct_order_certifica oc
                ,open.ldc_tipo_trab_x_nov_ofertados cx
                ,open.ldc_const_unoprl xu
           WHERE oc.certificate_id         = nucurtacta
             AND oi.value                  > 0
             AND iu.liquidacion            = 'I'
             AND iu.actividad              = -1
             AND xu.tipo_ofertado          = nupatipoofertado
             AND ot.order_id               = oc.order_id
             AND ot.order_id               = oa.order_id
             AND oa.order_activity_id      = open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
             AND ot.order_id               = oi.order_id
             AND oa.activity_id            = decode(iu.actividad,-1,oa.activity_id,iu.actividad)
             AND oi.items_id               = iu.item
             AND ot.operating_unit_id      = uh.unidad_operativa_hija
             AND iu.unidad_operativa       = uh.unidad_operativa_padre
             AND ot.task_type_id           = cx.tipo_trabajo
             AND uh.unidad_operativa_padre = xu.unidad_operativa
           GROUP BY uh.unidad_operativa_padre
                   ,ot.order_id
                   ,iu.actividad
                   ,oi.items_id
                   ,iu.liquidacion
           UNION ALL
		   -- 200-2438
          SELECT ot.operating_unit_id        unidad_operativa
                ,ot.order_id                      orden
                ,ah.actividad_padre                   actividad
                ,-1                      nuitemss
                ,iu.liquidacion                   liquidacion
                ,nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
            FROM open.or_order ot
                ,open.or_order_activity oa
                ,open.or_order_items oi
                ,open.ldc_item_uo_lr iu
                ,open.ldc_act_father_act_hija ah
                ,open.ct_order_certifica oc
                ,open.ldc_tipo_trab_x_nov_ofertados cx
                ,open.ldc_const_unoprl xu
           WHERE oc.certificate_id         = nucurtacta
             AND oi.value                  > 0
             AND iu.liquidacion            = 'A'
             AND xu.tipo_ofertado          = nupatipoofertado
             AND ot.order_id               = oc.order_id
             AND ot.order_id               = oa.order_id
             AND oa.order_activity_id      = open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
             AND ot.order_id               = oi.order_id
             AND ot.operating_unit_id      = iu.unidad_operativa
             --.unidad_operativa_hija
            -- AND iu.unidad_operativa       = uh.unidad_operativa_padre
             AND oa.activity_id            = ah.actividad_hija
             AND iu.actividad              = ah.actividad_padre
             AND oi.items_id               = decode(iu.item,-1,oi.items_id,iu.item)
             AND ot.task_type_id           = cx.tipo_trabajo
             AND ot.operating_unit_id      = xu.unidad_operativa
           GROUP BY ot.operating_unit_id
                   ,ot.order_id
                   ,ah.actividad_padre
                   ,oi.items_id
                   ,iu.liquidacion

       )
 WHERE 1 <= (SELECT COUNT(1)
               FROM open.ldc_const_liqtarran qw
              WHERE qw.unidad_operativa  = unidad_operativa_
                AND qw.actividad_orden   = actividad_
                AND qw.items             = nuitemss
                AND qw.zona_ofertados    = -1
                AND trunc(dtsubfechfin) BETWEEN trunc(qw.fecha_ini_vigen) AND trunc(qw.fecha_fin_vige));
BEGIN
 DELETE ldc_uni_act_ot lk WHERE lk.nussesion = nuparsesion AND lk.nro_acta = nuparacta;
 FOR i IN cuordenesgenerarnovedadact(nuparacta) LOOP
  BEGIN
   INSERT INTO ldc_uni_act_ot(
                              nussesion
                             ,unidad_operativa
                             ,orden
                             ,actividad
                             ,item
                             ,cantidad_item_legalizada
                             ,liquidacion
                             ,nro_acta
                             ,unidad_operativa_padre
                             ,zona_ofertados
                             ,identificador_reg
                             ,idrangoofer
                             )
                      VALUES(
                             nuparsesion
                            ,i.unidad_operativa_
                            ,i.orden
                            ,i.actividad_
                            ,i.nuitemss
                            ,i.cantidad_legalizada
                            ,i.liquidacion
                            ,nuparacta
                            ,-1
                            ,-1
                            ,i.orden
                            ,NULL
                           );
  EXCEPTION
   WHEN dup_val_on_index THEN
      NULL;
  END;
 END LOOP;
END;
BEGIN
 nucantidadnovgen := 0;
 nutotalvalornov  := 0;
 nuvaparamtpoofer := dald_parameter.fnuGetNumeric_Value('PARAM_TIPO_OFER_ESCALONADOS');
 nupersona:=ge_bopersonal.fnugetpersonid; --200-2436
 -- Consultamos datos para registrar inicio del proceso
 SELECT to_number(to_char(SYSDATE,'YYYY')),to_number(to_char(SYSDATE,'MM')),userenv('SESSIONID'),USER INTO nuccano,nuccmes,nusession,sbuser
   FROM dual;
  -- Registramos inicio del proceso
 ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROGENNOVOFERTSENSEVAESCA','En ejecucion..',nupaacta,sbuser);
 -- Obtenemos la fecha fin del acta
  BEGIN
   SELECT c.fecha_fin INTO dtfechafinacta
     FROM ge_acta c
    WHERE c.id_acta = nupaacta;
  EXCEPTION
   WHEN no_data_found THEN
    dtfechafinacta := SYSDATE;
  END;
 -- Llenamos la tabla con las ordenes las supuestas a generar novedades
 ldcprollenaldcuniactot(nupaacta,dtfechafinacta,nusession,nuvaparamtpoofer);
 -- Recorremos las actividades de las ots en el acta por unidad de trabajo
 nusw := 0;
 FOR i IN cuordernesacta(nusession,nupaacta) LOOP
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
  -- (JJJM - 200-2436) INICIO NEW cantidad rangos
  -- Consultamos la cantidad de rangos qyue deben aplicar
  nucantirango       := 0;
  nucantidadregrango := 0;
  nuresta            := i.cantidad;
  FOR hr IN(
            SELECT *
              FROM ldc_const_liqtarran l
             WHERE l.unidad_operativa = i.unidad_operativa
               and l.actividad_orden = i.actividad --dsaltarin
               AND l.items            = i.item
               AND trunc(dtfechafinacta) BETWEEN l.fecha_ini_vigen AND l.fecha_fin_vige
             ORDER BY l.cantidad_inicial
             ) LOOP
   FOR hr1 IN hr.cantidad_inicial..hr.cantidad_final LOOP
    IF nucantirango <> 0 THEN
     nucantirango := nucantirango + 1;
    END IF;
   END LOOP;
   IF nuresta > nucantirango THEN
    nuresta := nuresta - nucantirango;
    nucantidadregrango := nucantidadregrango + 1;
   ELSIF nuresta <= nucantirango THEN
    nucantidadregrango := nucantidadregrango + 1;
    EXIT;
   END IF;
  END LOOP;
  /*nucantidadregrango := 0;
  BEGIN
   SELECT nvl(SUM(cantrango),0) INTO nucantidadregrango
     FROM(
          SELECT COUNT(1) cantrango
            FROM ldc_const_liqtarran l
           WHERE l.unidad_operativa = i.unidad_operativa
             AND l.items            = i.item
             AND i.cantidad        >= cantidad_inicial
             AND trunc(dtfechafinacta) BETWEEN l.fecha_ini_vigen AND l.fecha_fin_vige
           UNION ALL
          SELECT COUNT(1) cantrango
            FROM ldc_const_liqtarran l
           WHERE l.unidad_operativa  = i.unidad_operativa
             AND l.items             = i.item
             AND trunc(dtfechafinacta) BETWEEN l.fecha_ini_vigen AND l.fecha_fin_vige
             AND ((i.cantidad + 1)  >= cantidad_inicial AND cantidad_final = i.cantidad
             AND MOD((cantidad_final - cantidad_inicial), 2) <> 0
             AND EXISTS (SELECT 1
                           FROM ldc_const_liqtarran li
                          WHERE l.unidad_operativa = li.unidad_operativa
                            AND l.items            = li.items
                            AND li.cantidad_final  > l.cantidad_final
                            AND trunc(dtfechafinacta) BETWEEN l.fecha_ini_vigen AND l.fecha_fin_vige)
                  )
         );
  EXCEPTION
   WHEN no_data_found THEN
    nucantidadregrango := 0;
  END;*/
  -- (JJJM - 200-2436) FIN NEW cantidad rangos
  -- Realizamos el proceso de escalonados en los rangos
  FOR k IN curangosaplica(i.cantidad,nuvarunidad,i.actividad,i.item,nucantidadregrango,dtfechafinacta) LOOP
   -- Generamos las novedades para cada una de las ordenes
   nuacumulavalor := 0;
   nuidenregi     := k.iden_reg;
   -- Guardamos informacion para el reporte
   INSERT INTO ldc_reporte_ofert_escalo(
                                        nusesion,nro_acta,iden_regi,unidad_operativa_esca
                                       ,actividad_rep_escalonado,item_rep_escalonado
                                       ,rango_inicial,rango_final,cantidad_ordenes
                                       ,valor_liquidar,total_ajuste
                                       )
                                 VALUES(
                                        nusession,nupaacta,nuidenregi,nuvarunidad
                                       ,i.actividad,i.item
                                       ,k.cantidad_inicial,k.cantidad_final,k.acum
                                       ,k.valor_liquidar,k.acum*k.valor_liquidar
                                       );
   -- Relizamos proceso para calcular el valor de las novedades
   FOR j IN cuordernesactaot(nuvarunidad,i.actividad,i.item,nusession,nupaacta) LOOP
    nucantidadlega := j.cantidad_legalizada;
    nuacumulavalor := nuacumulavalor + nucantidadlega;
    IF nuacumulavalor <= k.acum THEN
      UPDATE ldc_uni_act_ot h
         SET h.idrangoofer       = k.iden_reg
       WHERE h.unidad_operativa  = nuvarunidad
         AND h.orden             = j.identificador
         AND h.identificador_reg = j.order_id
         AND h.actividad         = i.actividad
         AND h.item              = i.item;
    ELSE
     nudiferencia    := nuacumulavalor - k.acum;
     IF nudiferencia  = nucantidadlega THEN
      EXIT;
     ELSIF j.cantidad_legalizada > nudiferencia THEN
      nucantidadlega := nucantidadlega - nudiferencia;
      nuacumulavalor := nuacumulavalor - nudiferencia;
      UPDATE ldc_uni_act_ot h
         SET h.idrangoofer              = k.iden_reg
            ,h.cantidad_item_legalizada = nucantidadlega
       WHERE h.unidad_operativa         = nuvarunidad
         AND h.orden                    = j.identificador
         AND h.identificador_reg        = j.order_id
         AND h.actividad                = i.actividad
         AND h.item                     = i.item;
       nuidentificador := ldc_seqecalonado.nextval;
       BEGIN
        INSERT INTO ldc_uni_act_ot(
                                   nussesion
                                  ,unidad_operativa
                                  ,orden
                                  ,actividad
                                  ,item
                                  ,cantidad_item_legalizada
                                  ,liquidacion
                                  ,nro_acta
                                  ,unidad_operativa_padre
                                  ,zona_ofertados
                                  ,identificador_reg
                                  ,idrangoofer
                                  )
                            VALUES(
                                   nusession
                                  ,nuvarunidad
                                  ,nuidentificador
                                  ,i.actividad
                                  ,i.item
                                  ,nudiferencia
                                  ,j.liquidacion
                                  ,nupaacta
                                  ,-1
                                  ,-1
                                  ,j.order_id
                                  ,NULL
                                 );
       EXCEPTION
        WHEN dup_val_on_index THEN
         NULL;
       END;
     END IF;
    END IF;
    nuorderid := NULL;

    /*BEGIN
     SELECT pe.person_id INTO nupersona
       FROM sa_user us,ge_person pe
      WHERE us.mask = USER
        AND us.user_id = pe.user_id;
    EXCEPTION
     WHEN no_data_found THEN
          nupersona := NULL;
    END;*/
    nuvalordescontar := k.valor_liquidar;
    IF nvl(nuvalordescontar,0) >= 1 THEN
       nuvalordescontarxcant := nvl(nuvalordescontar,0) * nucantidadlega;
       sbmensaje    := NULL;
     BEGIN
      SELECT ox.* INTO regor_order
        FROM or_order ox
       WHERE ox.order_id = j.order_id;
     EXCEPTION
      WHEN no_data_found THEN
           sbmensaje := 'La ord?n de trabajo : '||to_char(j.order_id)||' no existe en la tabla or_order. Contacte el administrador del sistema';
           ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENNOVOFERTSENSEVAESCA','Termino con errores.');
           RETURN;
     END;
     -- Obtenemos la novedad asociada al tipo de trabajo
     BEGIN
      SELECT ti.actividad_novedad_ofertados INTO nunovedadgenera
        FROM open.ldc_tipo_trab_x_nov_ofertados ti
       WHERE ti.tipo_trabajo = regor_order.task_type_id;
     EXCEPTION
      WHEN no_data_found THEN
         nunovedadgenera := NULL;
     END;
     -- Validamos si la ord?n tiene una novedad y si es asi el valor este actualizado en los rangos
     swencontro := 0;
     nuposireg := 0;
     FOR x IN cuordenesnovgenval(j.order_id,i.actividad,i.item,nuidenregi) LOOP
      swencontro := 1;
     END LOOP;
     sbcompletobser := 'Unidad operativa padre : '||to_char(i.unidad_operativa);
     IF nunovedadgenera IS NOT NULL THEN
        nucantidadnovgen := nvl(nucantidadnovgen,0) + 1;
        nutotalvalornov  := nvl(nutotalvalornov,0) + nvl(nuvalordescontarxcant,0);
      IF swencontro = 0 THEN
          or_boorder.closeorderwithproduct(
                                           nunovedadgenera
                                          ,regor_order.operating_unit_id
                                          ,regor_order.causal_id
                                          ,nupersona
                                          ,j.address_id
                                          ,SYSDATE
                                          ,1
                                          ,nvl(nuvalordescontarxcant,0)
                                          ,1400
                                          ,'ACTA_OFERTADOS : '||to_char(nupaacta,'000000000000000')||' [RFACTA] Se genera novedad valor a desconta por rango y tarifa. Registro '||to_char(nuidenregi)||' '||sbcompletobser
                                          ,j.order_id
                                          ,14
                                          ,j.package_id
                                          ,j.motivo
                                          ,NULL
                                          ,NULL
                                          ,j.producto
                                          ,nuorderid
                                          );
          IF nuorderid IS NOT NULL THEN
             nucontanov := nucontanov + 1;
             UPDATE open.or_order v
                SET v.defined_contract_id  = regor_order.defined_contract_id
                   ,v.legalization_date    = regor_order.legalization_date
                   ,v.exec_initial_date    = regor_order.exec_initial_date
                   ,v.execution_final_date = regor_order.execution_final_date
                   ,v.exec_estimate_date   = regor_order.exec_estimate_date
                   ,v.is_pending_liq       = NULL
              WHERE v.order_id = nuorderid;
              UPDATE open.or_order_activity gh
                 SET gh.comment_ = 'Orden de novedad generada ACTIVIDAD : '||to_char(i.actividad)||' ITEM : '||to_char(i.item)||' REG_ESCALONADO : '||to_char(nuidenregi)
               WHERE gh.order_id = nuorderid;
              INSERT INTO ct_order_certifica(order_id,certificate_id) VALUES(nuorderid,nupaacta);
              nusw := 1;
          END IF;
          NULL;
         END IF;
        END IF;
      END IF;
   END LOOP;
  END LOOP;
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
                                       ,'LDC_PROGENNOVOFERTSENSEVAESCA'
                                       ,nucantidadnovgen
                                       ,nutotalvalornov
                                       ,USER
                                       ,SYSDATE
                                       );
 sbmensaje := 'Se procesaron : '||to_char(nucontanov)||' registros.';
 ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENNOVOFERTSENSEVAESCA','Termino Ok.');
EXCEPTION
 WHEN OTHERS THEN
  sbmensaje := SQLERRM;
  ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENNOVOFERTSENSEVAESCA','Termino con errores.');
  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,SQLERRM);
  ut_trace.trace('LDC_PROGENNOVOFERTSENSEVAESCA '||' '||SQLERRM, 11);
END LDC_PROGENNOVOFERTSENSEVAESCA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDC_PROGENNOVOFERTSENSEVAESCA
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROGENNOVOFERTSENSEVAESCA', 'ADM_PERSON'); 
END;
/