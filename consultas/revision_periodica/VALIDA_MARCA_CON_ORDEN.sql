SELECT 'CON ORDEN1 ' AS MODO
      ,de.geo_loca_father_id departamento
      ,(SELECT rd.description FROM open.ge_geogra_location rd WHERE rd.geograp_location_id = de.geo_loca_father_id) descripcion_departamento
      ,di.geograp_location_id localidad
      ,de.description descripcion_localidad
      ,su.suscclie cliente
      ,su.susccodi contrato
      ,pr.product_id producto 
      ,(SELECT cl.subscriber_name||' '||cl.subs_last_name||' '||cl.subs_second_last_name FROM open.ge_subscriber cl WHERE cl.subscriber_id = su.suscclie) nombres      
      ,pr.product_status_id estado_producto
      ,(SELECT ep.description FROM open.ps_product_status ep WHERE ep.product_status_id = pr.product_status_id) descripcion_estado_producto
      ,pr.address_id direccion
      ,di.address_parsed direccion_parseada
      ,se.operating_sector_id sector_operativo
      ,(SELECT sc.description FROM open.or_operating_sector sc WHERE sc.operating_sector_id = se.operating_sector_id) descripcion_sector_operativo
      ,pr.category_id categoria
      ,(SELECT ca.catedesc FROM open.categori ca WHERE ca.catecodi = pr.category_id) desc_categoria
      ,pr.subcategory_id subcategoria
      ,(SELECT g.sucadesc FROM open.subcateg g WHERE g.sucacate = pr.category_id AND g.sucacodi = pr.subcategory_id) descripcion_subcategoria
      ,(SELECT em.emsscoem
          FROM open.elmesesu em
         WHERE em.emsssesu = pr.product_id
           AND (SYSDATE BETWEEN em.emssfein and em.emssfere)) medidor
      ,(SELECT MAX(t.review_date)
          FROM open.pr_certificate t 
         WHERE t.product_id = pr.product_id
       ) fecha_ultima_revision           
      ,pc.plazo_min_revision 
      ,pc.plazo_min_suspension
      ,pc.plazo_maximo
      ,/*round((
        SELECT months_between(trunc(SYSDATE),MAX(trunc(t.review_date)))
          FROM open.pr_certificate t 
         WHERE t.product_id = pr.product_id
       ),0)*/ OPEN.ldc_getEdadRP(pr.product_id) numeses_revision
      ,mp.package_id nro_solicitud
      ,mp.package_type_id tipo_solicitud
      ,(SELECT ts.description FROM open.ps_package_type ts WHERE ts.package_type_id = mp.package_type_id) descripcion_tipo_solicitud
      ,ot.order_id numero_orden
      ,oa.activity_id actividad_orden
      ,(SELECT description FROM open.ge_items iy WHERE iy.items_id = oa.activity_id) descripcion_actividad_orden
      ,ot.task_type_id tipo_trabajo
      ,(SELECT tt.description FROM open.or_task_type tt WHERE tt.task_type_id = ot.task_type_id) descripcion_tipo_trabajo
      ,ot.operating_unit_id unidad_operativa
      ,(SELECT uo.name FROM open.or_operating_unit uo WHERE uo.operating_unit_id = ot.operating_unit_id) nombre_unidad_operativa
      ,ot.order_status_id estado_orden
      ,(SELECT eo.description FROM open.or_order_status eo WHERE eo.order_status_id = ot.order_status_id) descripcion_estado_orden
      ,ot.created_date fceha_creacion_ot
      ,ot.assigned_date fecha_asignacion
      ,ot.execution_final_date ejecucion_orden
      ,(SELECT mv.suspension_type_id FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id)  marca_producto
      ,(SELECT gs.description FROM open.ge_suspension_type gs WHERE gs.suspension_type_id IN(SELECT mv.suspension_type_id FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id)) descripcion_marca_producto            
      ,decode(ot.task_type_id,
        12161,'REVISION',
        10723,'REPARACION',
        12135,'REPARACION',
        12475,'REPARACION',
        12487,'REPARACION',
        12138,'REPARACION',
        10721,'REPARACION',
        10445,'REPARACION',
        10716,'REPARACION',
        12147,'REPARACION',
        12143,'REPARACION',
        10833,'REPARACION',
        10714,'REPARACION',
        12139,'REPARACION',
        12140,'REPARACION',
        12136,'REPARACION',
        10720,'REPARACION',
        10722,'REPARACION',
        12148,'REPARACION',
        10444,'REVISION',
        10446,'CERTIFICACION',
        10795,'CERTIFICACION',
        12164,'CERTIFICACION',
        10450,decode(nvl((SELECT nvl(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),-1),
                     101,'REVISION',
               102,'REPARACION',
               103,'CERTIFICACION',
               104,'REPARACION',
               'SIN DEFINIR'),
        10834,'REVISION',
        10835,'REPARACION',
        10836,'CERTIFICACION',
        12457,decode(nvl((SELECT nvl(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),-1),
                     101,'REVISION',
               102,'REPARACION',
               103,'CERTIFICACION',
               104,'REPARACION',
               'SIN DEFINIR'),
        10449,decode(nvl((SELECT nvl(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),-1),
                     101,'REVISION',
               102,'REPARACION',
               103,'CERTIFICADO',
               104,'REPARACION',
               'SIN DEFINIR'),
        12460,decode((SELECT nvl(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),
               101,'REVISION',
               102,'REPARACION',
               103,'CERTIFICACION',
               104,'REPARACION',
               'SIN DEFINIR'),
		DECODE(nvl((SELECT NVL(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),-1),
		       -1,'SIN DEFINIR',
			   101,'REVISION',
			   102,'REPARACION',
			   103,'CERTIFICACION',
			   104,'REPARACION'
		       ),
	    'SIN DEFINIR'
		) ETAPA,
	    decode((select nvl(suspension_type_id,101) from open.ldc_marca_producto where id_producto=pr.product_id),
		       101,'REVISION',
			   102,'REPARACION',
			   103,'CERTIFICACION',
			   '104','REPARACION',
			   'SIN DEFINIR') ETAPAMARCA,
   order_activity_id actividad_en_la_orden               
  FROM open.ldc_plazos_cert pc
      ,open.pr_product pr
      ,open.suscripc su 
      ,open.ab_address di
      ,open.ab_segments se
      ,open.ge_geogra_location de
      ,open.or_order_activity oa
      ,open.or_order ot
      ,open.mo_packages mp
 WHERE pr.product_type_id            = 7014                            
   AND pc.id_producto                = pr.product_id
   AND pr.subscription_id            = su.susccodi
   AND pr.address_id                 = di.address_id
   AND di.segment_id                 = se.segments_id
   AND di.geograp_location_id        = de.geograp_location_id
   --AND pr.product_id=50653227
   AND pr.product_id                 = oa.product_id
   AND oa.order_id                   = ot.order_id
   and oa.order_activity_id          = (select min(oa2.order_activity_id) from open.or_order_activity oa2 where oa2.order_id=oa.order_id)
   AND ot.task_type_id IN (12135,12136,12138,12139,12140,12142,12143,12147,12148,12453,12487,10714,10715,10716,10717,10718,10719,10720,10721,10722,10723,10444,10445,10446,12161,12164,10449,10450,12457,12460,10795,12475,12460,10834,10835,10836,10833)
   AND ot.order_status_id IN(0,5,7,20,11,6)                                       
   AND oa.package_id = mp.package_id
   AND mp.package_type_id IN(265,266,100237,100014,100153,100270,100255,100246,100156,100293,100294,100295,100321, 100013, 100297)
   and OPEN.ldc_getEdadRP(pr.product_id)>=43
   AND decode(ot.task_type_id,
        12161,'REVISION',
		10723,'REPARACION',
		12135,'REPARACION',
		12475,'REPARACION',
		12487,'REPARACION',
		12138,'REPARACION',
		10721,'REPARACION',
		10445,'REPARACION',
		10716,'REPARACION',
		12147,'REPARACION',
		12143,'REPARACION',
		10833,'REPARACION',
		10714,'REPARACION',
		12139,'REPARACION',
		12140,'REPARACION',
		12136,'REPARACION',
		10720,'REPARACION',
		10722,'REPARACION',
		12148,'REPARACION',
		10444,'REVISION',
		10446,'CERTIFICACION',
		10795,'CERTIFICACION',
		12164,'CERTIFICACION',
		10450,decode(nvl((SELECT nvl(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),-1),
		             101,'REVISION',
					 102,'REPARACION',
					 103,'CERTIFICACION',
					 104,'REPARACION',
					 'SIN DEFINIR'),
		10834,'REVISION',
		10835,'REPARACION',
		10836,'CERTIFICACION',
		12457,decode(nvl((SELECT nvl(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),-1),
		             101,'REVISION',
					 102,'REPARACION',
					 103,'CERTIFICACION',
					 104,'REPARACION',
					 'SIN DEFINIR'),
		10449,decode(nvl((SELECT nvl(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),-1),
		             101,'REVISION',
					 102,'REPARACION',
					 103,'CERTIFICADO',
					 104,'REPARACION',
					 'SIN DEFINIR'),
		12460,decode((SELECT nvl(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),
					 101,'REVISION',
					 102,'REPARACION',
					 103,'CERTIFICACION',
					 104,'REPARACION',
					 'SIN DEFINIR'),
		DECODE(nvl((SELECT NVL(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),-1),
		       -1,'SIN DEFINIR',
			   101,'REVISION',
			   102,'REPARACION',
			   103,'CERTIFICACION',
			   104,'REPARACION'
		       ),
	    'SIN DEFINIR'
		) != decode((select nvl(suspension_type_id,101) from open.ldc_marca_producto where id_producto=pr.product_id),
		       101,'REVISION',
			   102,'REPARACION',
			   103,'CERTIFICACION',
			   '104','REPARACION',
			   'SIN DEFINIR') 

UNION
SELECT 'CON ORDEN2 ' AS MODO
      ,de.geo_loca_father_id departamento
      ,(SELECT rd.description FROM open.ge_geogra_location rd WHERE rd.geograp_location_id = de.geo_loca_father_id) descripcion_departamento
      ,di.geograp_location_id localidad
      ,de.description descripcion_localidad
      ,su.suscclie cliente
      ,su.susccodi contrato
      ,pr.product_id producto 
      ,(SELECT cl.subscriber_name||' '||cl.subs_last_name||' '||cl.subs_second_last_name FROM open.ge_subscriber cl WHERE cl.subscriber_id = su.suscclie) nombres      
      ,pr.product_status_id estado_producto
      ,(SELECT ep.description FROM open.ps_product_status ep WHERE ep.product_status_id = pr.product_status_id) descripcion_estado_producto
      ,pr.address_id direccion
      ,di.address_parsed direccion_parseada
      ,se.operating_sector_id sector_operativo
      ,(SELECT sc.description FROM open.or_operating_sector sc WHERE sc.operating_sector_id = se.operating_sector_id) descripcion_sector_operativo
      ,pr.category_id categoria
      ,(SELECT ca.catedesc FROM open.categori ca WHERE ca.catecodi = pr.category_id) desc_categoria
      ,pr.subcategory_id subcategoria
      ,(SELECT g.sucadesc FROM open.subcateg g WHERE g.sucacate = pr.category_id AND g.sucacodi = pr.subcategory_id) descripcion_subcategoria
      ,(SELECT em.emsscoem
          FROM open.elmesesu em
         WHERE em.emsssesu = pr.product_id
           AND (SYSDATE BETWEEN em.emssfein and em.emssfere)) medidor
      ,(SELECT MAX(t.review_date)
          FROM open.pr_certificate t 
         WHERE t.product_id = pr.product_id
       ) fecha_ultima_revision           
      ,pc.plazo_min_revision 
      ,pc.plazo_min_suspension
      ,pc.plazo_maximo
      ,/*round((
        SELECT months_between(trunc(SYSDATE),MAX(trunc(t.review_date)))
          FROM open.pr_certificate t 
         WHERE t.product_id = pr.product_id
       ),0)*/ OPEN.ldc_getEdadRP(pr.product_id) numeses_revision
      ,mp.package_id nro_solicitud
      ,mp.package_type_id tipo_solicitud
      ,(SELECT ts.description FROM open.ps_package_type ts WHERE ts.package_type_id = mp.package_type_id) descripcion_tipo_solicitud
      ,ot.order_id numero_orden
      ,oa.activity_id actividad_orden
      ,(SELECT description FROM open.ge_items iy WHERE iy.items_id = oa.activity_id) descripcion_actividad_orden
      ,ot.task_type_id tipo_trabajo
      ,(SELECT tt.description FROM open.or_task_type tt WHERE tt.task_type_id = ot.task_type_id) descripcion_tipo_trabajo
      ,ot.operating_unit_id unidad_operativa
      ,(SELECT uo.name FROM open.or_operating_unit uo WHERE uo.operating_unit_id = ot.operating_unit_id) nombre_unidad_operativa
      ,ot.order_status_id estado_orden
      ,(SELECT eo.description FROM open.or_order_status eo WHERE eo.order_status_id = ot.order_status_id) descripcion_estado_orden
      ,ot.created_date fceha_creacion_ot
      ,ot.assigned_date fecha_asignacion
      ,ot.execution_final_date ejecucion_orden
      ,(SELECT mv.suspension_type_id FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id)  marca_producto
      ,(SELECT gs.description FROM open.ge_suspension_type gs WHERE gs.suspension_type_id IN(SELECT mv.suspension_type_id FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id)) descripcion_marca_producto            
      ,decode(ot.task_type_id,
        12161,'REVISION',
        10723,'REPARACION',
        12135,'REPARACION',
        12475,'REPARACION',
        12487,'REPARACION',
        12138,'REPARACION',
        10721,'REPARACION',
        10445,'REPARACION',
        10716,'REPARACION',
        12147,'REPARACION',
        12143,'REPARACION',
        10833,'REPARACION',
        10714,'REPARACION',
        12139,'REPARACION',
        12140,'REPARACION',
        12136,'REPARACION',
        10720,'REPARACION',
        10722,'REPARACION',
        12148,'REPARACION',
        10444,'REVISION',
        10446,'CERTIFICACION',
        10795,'CERTIFICACION',
        12164,'CERTIFICACION',
        10450,decode(nvl((SELECT nvl(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),-1),
                     101,'REVISION',
               102,'REPARACION',
               103,'CERTIFICACION',
               104,'REPARACION',
               'SIN DEFINIR'),
        10834,'REVISION',
        10835,'REPARACION',
        10836,'CERTIFICACION',
        12457,decode(nvl((SELECT nvl(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),-1),
                     101,'REVISION',
               102,'REPARACION',
               103,'CERTIFICACION',
               104,'REPARACION',
               'SIN DEFINIR'),
        10449,decode(nvl((SELECT nvl(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),-1),
                     101,'REVISION',
               102,'REPARACION',
               103,'CERTIFICADO',
               104,'REPARACION',
               'SIN DEFINIR'),
        12460,decode((SELECT nvl(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),
               101,'REVISION',
               102,'REPARACION',
               103,'CERTIFICACION',
               104,'REPARACION',
               'SIN DEFINIR'),
		DECODE(nvl((SELECT NVL(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),-1),
		       -1,'SIN DEFINIR',
			   101,'REVISION',
			   102,'REPARACION',
			   103,'CERTIFICACION',
			   104,'REPARACION'
		       ),
	    'SIN DEFINIR'
		) ETAPA,
	    decode((select nvl(suspension_type_id,101) from open.ldc_marca_producto where id_producto=pr.product_id),
		       101,'REVISION',
			   102,'REPARACION',
			   103,'CERTIFICACION',
			   '104','REPARACION',
			   'SIN DEFINIR') ETAPAMARCA,order_activity_id actividad_en_la_orden               
  FROM open.ldc_plazos_cert pc
      ,open.pr_product pr
      ,open.suscripc su 
      ,open.ab_address di
      ,open.ab_segments se
      ,open.ge_geogra_location de
      ,open.or_order_activity oa
      ,open.or_order ot
      ,open.mo_packages mp
 WHERE pr.product_type_id            = 7014                            
   AND pc.id_producto                = pr.product_id
   AND pr.subscription_id            = su.susccodi
   AND pr.address_id                 = di.address_id
   AND di.segment_id                 = se.segments_id
   AND di.geograp_location_id        = de.geograp_location_id
   AND pr.product_id                 = oa.product_id
   AND oa.order_id                   = ot.order_id
   and oa.order_activity_id          = (select min(oa2.order_activity_id) from open.or_order_activity oa2 where oa2.order_id=oa.order_id)
   AND ot.task_type_id IN (12135,12136,12138,12139,12140,12142,12143,12147,12148,12453,12487,10714,10715,10716,10717,10718,10719,10720,10721,10722,10723,10444,10445,10446,12161,12164,10449,10450,12457,12460,10795,12475,12460,10834,10835,10836,10833)
   AND ot.order_status_id IN(0,5,7,20,11,6)                                       
   AND oa.package_id = mp.package_id
   --AND pr.product_id=50653227
   AND mp.package_type_id IN(265,266,100237,100014,100153,100270,100255,100246,100156,100293,100294,100295,100321, 100013, 100297)
   and OPEN.ldc_getEdadRP(pr.product_id)>=43
    AND decode(ot.task_type_id,
        12161,'REVISION',
        10723,'REPARACION',
        12135,'REPARACION',
        12475,'REPARACION',
        12487,'REPARACION',
        12138,'REPARACION',
        10721,'REPARACION',
        10445,'REPARACION',
        10716,'REPARACION',
        12147,'REPARACION',
        12143,'REPARACION',
        10833,'REPARACION',
        10714,'REPARACION',
        12139,'REPARACION',
        12140,'REPARACION',
        12136,'REPARACION',
        10720,'REPARACION',
        10722,'REPARACION',
        12148,'REPARACION',
        10444,'REVISION',
        10446,'CERTIFICACION',
        10795,'CERTIFICACION',
        12164,'CERTIFICACION',
        10450,decode(nvl((SELECT nvl(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),-1),
                     101,'REVISION',
               102,'REPARACION',
               103,'CERTIFICACION',
               104,'REPARACION',
               'SIN DEFINIR'),
        10834,'REVISION',
        10835,'REPARACION',
        10836,'CERTIFICACION',
        12457,decode(nvl((SELECT nvl(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),-1),
                     101,'REVISION',
               102,'REPARACION',
               103,'CERTIFICACION',
               104,'REPARACION',
               'SIN DEFINIR'),
        10449,decode(nvl((SELECT nvl(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),-1),
                     101,'REVISION',
               102,'REPARACION',
               103,'CERTIFICADO',
               104,'REPARACION',
               'SIN DEFINIR'),
        12460,decode((SELECT nvl(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),
               101,'REVISION',
               102,'REPARACION',
               103,'CERTIFICACION',
               104,'REPARACION',
               'SIN DEFINIR'),
		DECODE(nvl((SELECT NVL(mv.suspension_type_id,101) FROM open.ldc_marca_producto mv WHERE mv.id_producto = pr.product_id),-1),
		       -1,'SIN DEFINIR',
			   101,'REVISION',
			   102,'REPARACION',
			   103,'CERTIFICACION',
			   104,'REPARACION'
		       ),
	    'SIN DEFINIR'
		)= decode((select nvl(suspension_type_id,101) from open.ldc_marca_producto where id_producto=pr.product_id),
		       101,'REVISION',
			   102,'REPARACION',
			   103,'CERTIFICACION',
			   '104','REPARACION',
			   'SIN DEFINIR') 
        and decode((select nvl(suspension_type_id,101) from open.ldc_marca_producto where id_producto=pr.product_id),101,'REVISION',102,'REPARACION',103,'CERTIFICACION','104','REPARACION','SIN DEFINIR')= 'SIN DEFINIR'        

