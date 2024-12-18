create or replace PROCEDURE adm_person.ldc_progeneranoveltyofertados(nupaacta ge_acta.id_acta%TYPE) IS
/*********************************************************************************************************
    Propiedad intelectual de JM GESTIONINFORMATICA S.A.

    Unidad         : LDC_PROGENERANOVELTYOFERTADOS
    Descripcion    : Procedimiento para generar las novedades
                     de ofertados las unidades operativas que aplican al nuevo
                    esquema de liquidacion.

    Autor          : John Jairo Jimenez Marimon
    Fecha          : 21-10-2017

    Historia de Modificaciones
    Fecha             Autor                         Modificacion
    ==========        ==========================    =================================================
	19/09/2018        John Jairo Jimenez Marimon     Se modifica el cursor cuordenesgenerarnovedadact
                                                    del sub-proceso ldcprollenaldcuniactot para que en
                                                    todas las consultas se tenga encuenta la actividad en
                                                    caso que se liquide por items y el item en caso de que
                                                    se liquide por actividad, osea que estos campos pueden
                                                    tener valores diferentes a -1.
                                                    Se contempla la posibilidad de la combinacion actividad
                                                    e items idnependientemente de como se este liquidando.
    26/03/2019        ELAL                          CA 100-85779 se agrega logica para insertar en la tabla LDC_REPORTE_OFERT_ESCALO
                                                    informacion de rangos obtenidos y aplicados en las novedades de ofertados
    18/07/2018        John Jairo Jimenez Marimon    200-2438 - Se crea cursor para actividades padres e hijas en el
                                                    procedimeinto : ldcprollenaldcuniactot
	10/07/2019		  John Jairo Jimenez Marimon        Se adecua para manejo de ofertados
    20/11/2019        F.Castro                          Cambio 231 - Se adecua para manejo de unidades operativas hijas cuando el tipo de liquidacion
                                                    es por actividad (Se modifica cursor cuordenesgenerarnovedadact del procedimiento interno
                                                    ldcprollenaldcuniactot)
	12-01-2024		  jerazomvm						OSF-2052: 	
													1. Se modifica el subprocedimiento ldcprollenaldcuniactot, de la siguiente manera:
														1.1. Se ajusta el cursor cuordenesgenerarnovedadact, para que tenga obtenga la zona de ofertados, 
															es decir, si la unidad operativa tiene asociada una zona ofertada vigente con -1 en ldc_const_liqtarran 
															devolverá la zona con -1, de lo contrario, devolverá la zona operativa asociada de ldc_zona_loc_ofer_cart.id_zona_oper.
														1.2. Se modifica la inserción a ldc_uni_act_ot, para que la zona ofertada no sea -1, si no la zona ofertada obtenida en 
															el cursor cuordenesgenerarnovedadact.
													2. Se ajusta el cursor cuordernesacta, para que también obtenga la zona de ofertados.
													3. Se ajusta el cursor curangos, donde se añadirá el parámetro de entrada nuzonaofer, para que sea tenido en cuenta en la 
														búsqueda de ofertados.
													4. Se ajusta el cursor cuordernesactaot, añadiendo el parametro nuzonaofer para que sea tenido en cuenta 
														en la busqueda de ofertados.
	19-04-2024		 Adrianavg						OSF-2569: Se migra del esquema OPEN al esquema ADM_PERSON
**************************************************************************************************************/
---
	-- Constantes para el control de la traza
	csbSP_NAME 	CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
	cnuNVLTRC 	CONSTANT NUMBER 		:= pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;

	CURSOR cuordernesacta(nuparcussion  ldc_uni_act_ot.nussesion%TYPE,
						  nucurpacta 	ldc_uni_act_ot.nro_acta%TYPE
						  ) IS
	SELECT t.unidad_operativa,
		   t.actividad,
		   t.item,
		   t.zona_ofertados,
		   nvl(SUM(t.cantidad_item_legalizada),0) cantidad
    FROM ldc_uni_act_ot t
    WHERE t.nussesion 	= nuparcussion
    AND t.nro_acta  	= nucurpacta
    GROUP BY t.unidad_operativa,
			 t.actividad,
			 t.item,
			 t.zona_ofertados;

	CURSOR curangos(nucuunidadoper 	or_operating_unit.operating_unit_id%TYPE,
					nucuactividad  	or_order_activity.activity_id%TYPE,
					nucuitems      	ge_items.items_id%TYPE,
					nuzonaofer   	ldc_zona_ofer_cart.id_zona_oper%TYPE,
					dtcufechafin   	DATE
                   ) IS
	SELECT lq.cantidad_inicial,
		   lq.cantidad_final,
		   lq.valor_liquidar, 
		   lq.iden_reg id_reg
    FROM ldc_const_liqtarran lq
    WHERE lq.unidad_operativa  	= nucuunidadoper
    AND lq.actividad_orden   	= nucuactividad
    AND lq.items             	= nucuitems
    AND lq.zona_ofertados    	= nuzonaofer
    AND trunc(dtcufechafin)  	BETWEEN trunc(lq.fecha_ini_vigen) AND trunc(lq.fecha_fin_vige)
    ORDER BY cantidad_inicial;

	CURSOR cuordernesactaot(nucuunidad   ldc_uni_act_ot.unidad_operativa%TYPE,
							nucuactivi   ldc_uni_act_ot.actividad%TYPE,
							nucuitem     ldc_uni_act_ot.item%TYPE,
							nucupasesion ldc_uni_act_ot.nussesion%TYPE,
							nucuacta     ldc_uni_act_ot.nro_acta%TYPE,
							nuzonaofer   ldc_zona_ofer_cart.id_zona_oper%TYPE
							) IS
	SELECT DISTINCT(t.orden) order_id
		   ,oa.address_id
		   ,oa.package_id
		   ,(SELECT mo.motive_id FROM mo_motive mo WHERE mo.package_id = oa.package_id AND ROWNUM = 1) motivo
		   ,oa.product_id producto
           ,nvl(t.cantidad_item_legalizada,0) cantidad_legalizada
	FROM ldc_uni_act_ot t
         ,or_order_activity oa
    WHERE t.nussesion            = nucupasesion
    AND t.nro_acta               = nucuacta
    AND t.unidad_operativa       = nucuunidad
    AND t.actividad              = nucuactivi
    AND t.item                   = nucuitem
    AND t.unidad_operativa_padre = -1
    AND t.zona_ofertados         = nuzonaofer
    AND t.orden                  = oa.order_id
    AND oa.order_activity_id     = ldc_bcfinanceot.fnugetactivityid(t.orden)
	UNION ALL
	SELECT DISTINCT(t.orden) order_id
       ,oa.address_id
       ,oa.package_id
       ,(SELECT mo.motive_id FROM mo_motive mo WHERE mo.package_id = oa.package_id AND ROWNUM = 1) motivo
       ,oa.product_id producto
       ,nvl(t.cantidad_item_legalizada,0) cantidad_legalizada
	FROM ldc_uni_act_ot t
       ,or_order_activity oa
	WHERE t.nussesion            = nucupasesion
    AND t.nro_acta               = nucuacta
    AND t.unidad_operativa_padre = nucuunidad
    AND t.actividad              = nucuactivi
    AND t.item                   = nucuitem
    AND t.zona_ofertados         = nuzonaofer
    AND t.orden                  = oa.order_id
    AND oa.order_activity_id     = ldc_bcfinanceot.fnugetactivityid(t.orden);

	CURSOR cuordenesnovgenval(nucuorden NUMBER,nucuactividad NUMBER,nucuitem NUMBER) IS
	SELECT yu.order_activity_id,yu.value_reference,tr.created_date fecha_creacion
    FROM or_related_order ro
         ,or_order_activity yu
         ,or_order tr
         ,or_order_items s
	WHERE ro.rela_order_type_id  = 14
    AND tr.order_status_id     	 = 8
    AND yu.activity_id         	 IN(
                                    SELECT tx.actividad_novedad_ofertados
                                      FROM ldc_tipo_trab_x_nov_ofertados tx
                                     WHERE tx.actividad_novedad_ofertados = yu.activity_id
                                   )
    AND ro.order_id           = nucuorden
    AND TRIM(yu.comment_)     = TRIM('Orden de novedad generada ACTIVIDAD : '||to_char(nucuactividad)||' ITEM : '||to_char(nucuitem))
    AND tr.order_id           = s.order_id
    AND ro.related_order_id   = yu.order_id
    AND yu.order_id           = tr.order_id
	ORDER BY fecha_creacion;

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
	nuError				  NUMBER;  
	sbmensaje             VARCHAR2(1000);
	nuvalfinal            ldc_const_liqtarran.cantidad_final%TYPE;
	nuvalinicial          ldc_const_liqtarran.cantidad_inicial%TYPE; --ticket 100-85779 ELAL -- se almacena cantidad inicial
	nuIdeRegistro         ldc_const_liqtarran.iden_reg%TYPE; --ticket 100-85779 ELAL -- se almacena ide del registro

	nucontarang           NUMBER(8);
	nucontarangmenos1     NUMBER(8);
	nuvarunidad           or_operating_unit.operating_unit_id%TYPE;
	nusw                  NUMBER(1) DEFAULT 0;
	sbcompletobser        VARCHAR2(100);
	regor_order           or_order%ROWTYPE;
	nucantidadnovgen      NUMBER(8) DEFAULT 0;
	nutotalvalornov       NUMBER(15,2) DEFAULT 0;
	swencontro            NUMBER(2);
	dtfechafinacta        DATE;
	
	PROCEDURE ldcprollenaldcuniactot(nuparacta      ge_acta.id_acta%TYPE,
									 dtpasfechaacta DATE,
									 nuparsesion    ldc_uni_act_ot.nussesion%TYPE
									 ) 
	IS
	
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'ldcprollenaldcuniactot';

		CURSOR cuordenesgenerarnovedadact(nucurtacta ge_acta.id_acta%TYPE) IS
		SELECT ot.operating_unit_id             unidad_operativa,
			   ot.order_id                      orden,
			   oa.activity_id                   actividad,
			   -1                               nuitemss,
			   iu.liquidacion                   liquidacion,
			   CASE WHEN (SELECT COUNT(1)
                          FROM ldc_const_liqtarran bv
                          WHERE bv.unidad_operativa = ot.operating_unit_id
                          AND bv.zona_ofertados   = -1
                          AND trunc(dtpasfechaacta) BETWEEN bv.fecha_ini_vigen AND bv.fecha_fin_vige
                          ) >= 1 THEN
					-1
               ELSE
					zo.id_zona_oper
               END 								id_zona_oper,
			   nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
		FROM or_order 						ot,
			 or_order_activity 				oa,
			 or_order_items 				oi,
			 ldc_item_uo_lr 				iu,
			 ct_order_certifica 			oc,
			 ldc_tipo_trab_x_nov_ofertados 	cx,
			 ldc_const_unoprl 				xu,
			 ab_address 					ab
			 left join ldc_zona_loc_ofer_cart 	zo on zo.localidad = ab.geograp_location_id
		WHERE oc.certificate_id  	= nucurtacta
		AND oi.value             	> 0
		AND iu.liquidacion       	= 'A'
		AND xu.tipo_ofertado     	= 1
		AND ot.order_id          	= oc.order_id
		AND ot.order_id          	= oa.order_id
		AND oa.order_activity_id 	= ldc_bcfinanceot.fnugetactivityid(ot.order_id)
		AND ot.order_id          	= oi.order_id
		AND ot.operating_unit_id 	= iu.unidad_operativa
		AND oa.activity_id       	= iu.actividad
		AND oi.items_id          	= decode(iu.item,-1,oi.items_id,iu.item)
		AND ot.task_type_id      	= cx.tipo_trabajo
		AND ot.operating_unit_id 	= xu.unidad_operativa
		AND ab.address_id			= nvl(ot.external_address_id, oa.address_id)
		AND zo.localidad			= ab.geograp_location_id
	    GROUP BY ot.operating_unit_id,
				 ot.order_id,
				 oa.activity_id,
				 oi.items_id,
				 iu.liquidacion,
				 zo.id_zona_oper
		UNION ALL
	    SELECT ot.operating_unit_id,
			   ot.order_id,
			   iu.actividad,
			   oi.items_id,
			   iu.liquidacion,
			   CASE WHEN (SELECT COUNT(1)
                          FROM ldc_const_liqtarran bv
                          WHERE bv.unidad_operativa = ot.operating_unit_id
                          AND bv.zona_ofertados   = -1
                          AND trunc(dtpasfechaacta) BETWEEN bv.fecha_ini_vigen AND bv.fecha_fin_vige
                          ) >= 1 THEN
					-1
               ELSE
					zo.id_zona_oper
               END 								id_zona_oper,
			   nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
		FROM or_order 						ot,
			 or_order_activity 				oa,
			 or_order_items 				oi,
			 ldc_item_uo_lr 				iu,
			 ct_order_certifica 			oc,
			 ldc_tipo_trab_x_nov_ofertados  cx,
			 ldc_const_unoprl 				xu,
			 ab_address 					ab
			 left join ldc_zona_loc_ofer_cart 	zo on zo.localidad = ab.geograp_location_id
		WHERE oc.certificate_id  = nucurtacta
		AND oi.value             > 0
		AND iu.liquidacion       = 'I'
		AND xu.tipo_ofertado     = 1
		AND iu.actividad         = -1
		AND ot.order_id          = oc.order_id
		AND ot.order_id          = oa.order_id
		AND oa.order_activity_id = ldc_bcfinanceot.fnugetactivityid(ot.order_id)
		AND ot.order_id          = oi.order_id
		AND ot.operating_unit_id = iu.unidad_operativa
		AND oa.activity_id       = decode(iu.actividad,-1,oa.activity_id,iu.actividad)
		AND oi.items_id          = iu.item
		AND ot.task_type_id      = cx.tipo_trabajo
		AND ot.operating_unit_id = xu.unidad_operativa
		AND ab.address_id		 = nvl(ot.external_address_id, oa.address_id)
		AND zo.localidad		 = ab.geograp_location_id
		GROUP BY ot.operating_unit_id,
				 ot.order_id,
				 iu.actividad,
				 oi.items_id,
				 iu.liquidacion,
				 zo.id_zona_oper
		UNION ALL
		SELECT uh.unidad_operativa_padre,
			   ot.order_id,
			   iu.actividad,
			   oi.items_id,
			   iu.liquidacion,
			   CASE WHEN (SELECT COUNT(1)
                          FROM ldc_const_liqtarran bv
                          WHERE bv.unidad_operativa = uh.unidad_operativa_padre
                          AND bv.zona_ofertados   = -1
                          AND trunc(dtpasfechaacta) BETWEEN bv.fecha_ini_vigen AND bv.fecha_fin_vige
                          ) >= 1 THEN
					-1
               ELSE
					zo.id_zona_oper
               END 								id_zona_oper,
			   nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
		FROM or_order 						ot,
			 or_order_activity 				oa,
			 or_order_items 				oi,
			 ldc_item_uo_lr 				iu,
			 ldc_unid_oper_hija_mod_tar 	uh,
			 ct_order_certifica 			oc,
			 ldc_tipo_trab_x_nov_ofertados  cx,
			 ldc_const_unoprl 				xu,
			 ab_address 					ab
			 left join ldc_zona_loc_ofer_cart 	zo on zo.localidad = ab.geograp_location_id
		WHERE oc.certificate_id       = nucurtacta
		AND oi.value                  > 0
		AND iu.liquidacion            = 'I'
		AND xu.tipo_ofertado          = 1
		AND iu.actividad              = -1
		AND ot.order_id               = oc.order_id
		AND ot.order_id               = oa.order_id
		AND oa.order_activity_id      = ldc_bcfinanceot.fnugetactivityid(ot.order_id)
		AND ot.order_id               = oi.order_id
		AND oa.activity_id            = decode(iu.actividad,-1,oa.activity_id,iu.actividad)
		AND oi.items_id               = iu.item
		AND ot.operating_unit_id      = uh.unidad_operativa_hija
		AND iu.unidad_operativa       = uh.unidad_operativa_padre
		AND ot.task_type_id           = cx.tipo_trabajo
		AND uh.unidad_operativa_padre = xu.unidad_operativa
		AND ab.address_id			  = nvl(ot.external_address_id, oa.address_id)
		AND zo.localidad			  = ab.geograp_location_id
		GROUP BY uh.unidad_operativa_padre,
				 ot.order_id,
				 iu.actividad,
				 oi.items_id,
				 iu.liquidacion,
				 zo.id_zona_oper
		--SE AGREGA SUBQUERY POR CAMBIO 231
		UNION ALL
		SELECT uh.unidad_operativa_padre,
			   ot.order_id,
			   oa.activity_id 					actividad,
			   -1 								items_id,
			   iu.liquidacion,
			   CASE WHEN (SELECT COUNT(1)
                          FROM ldc_const_liqtarran bv
                          WHERE bv.unidad_operativa = uh.unidad_operativa_padre
                          AND bv.zona_ofertados   = -1
                          AND trunc(dtpasfechaacta) BETWEEN bv.fecha_ini_vigen AND bv.fecha_fin_vige
                          ) >= 1 THEN
					-1
               ELSE
					zo.id_zona_oper
               END 								id_zona_oper,
			   nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
		FROM or_order 						ot,
			 or_order_activity 				oa,
			 or_order_items 				oi,
			 ldc_item_uo_lr 				iu,
			 ldc_unid_oper_hija_mod_tar 	uh,
			 ct_order_certifica 			oc,
			 ldc_tipo_trab_x_nov_ofertados  cx,
			 ldc_const_unoprl 				xu,
			 ab_address 					ab
			 left join ldc_zona_loc_ofer_cart 	zo on zo.localidad = ab.geograp_location_id
		WHERE oc.certificate_id       = nucurtacta
		AND oi.value                  > 0
		AND iu.liquidacion            = 'A'
		AND xu.tipo_ofertado          = 1
		AND ot.order_id               = oc.order_id
		AND ot.order_id               = oa.order_id
		AND oa.order_activity_id      = ldc_bcfinanceot.fnugetactivityid(ot.order_id)
		AND ot.order_id               = oi.order_id
		AND oa.activity_id            = iu.actividad
		AND oi.items_id               = decode(iu.item,-1,oi.items_id,iu.item)
		AND ot.operating_unit_id      = uh.unidad_operativa_hija
		AND iu.unidad_operativa       = uh.unidad_operativa_padre
		AND ot.task_type_id           = cx.tipo_trabajo
		AND uh.unidad_operativa_padre = xu.unidad_operativa
		AND ab.address_id			  = nvl(ot.external_address_id, oa.address_id)
		AND zo.localidad			  = ab.geograp_location_id
		GROUP BY uh.unidad_operativa_padre,
				 ot.order_id,
				 oa.activity_id,
				 oi.items_id,
				 iu.liquidacion,
				 zo.id_zona_oper
		-- FIN CAMBIO 231
		UNION ALL
		-- 200-2438
		SELECT ot.operating_unit_id        		unidad_operativa,
			   ot.order_id                      orden,
			   ah.actividad_padre              	actividad,
			   -1                               nuitemss,
			   iu.liquidacion                   liquidacion,
			   CASE WHEN (SELECT COUNT(1)
                          FROM ldc_const_liqtarran bv
                          WHERE bv.unidad_operativa = ot.operating_unit_id
                          AND bv.zona_ofertados   = -1
                          AND trunc(dtpasfechaacta) BETWEEN bv.fecha_ini_vigen AND bv.fecha_fin_vige
                          ) >= 1 THEN
					-1
               ELSE
					zo.id_zona_oper
               END 								id_zona_oper,
			   nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
		FROM or_order 						ot,
			 or_order_activity 				oa,
			 or_order_items 				oi,
			 ldc_item_uo_lr 				iu,
			 ldc_act_father_act_hija 		ah,
			 ct_order_certifica 			oc,
			 ldc_tipo_trab_x_nov_ofertados  cx,
			 ldc_const_unoprl 				xu,
			 ab_address 					ab
			 left join ldc_zona_loc_ofer_cart 	zo on zo.localidad = ab.geograp_location_id
		WHERE oc.certificate_id       = nucurtacta
		AND oi.value                  > 0
		AND iu.liquidacion            = 'A'
		AND xu.tipo_ofertado          = 1
		AND ot.order_id               = oc.order_id
		AND ot.order_id               = oa.order_id
		AND oa.order_activity_id      = ldc_bcfinanceot.fnugetactivityid(ot.order_id)
		AND ot.order_id               = oi.order_id
		AND ot.operating_unit_id      = iu.unidad_operativa -- 200-2438
		AND oa.activity_id            = ah.actividad_hija -- 200-2438
		AND iu.actividad              = ah.actividad_padre -- 200-2438
		AND oi.items_id               = decode(iu.item,-1,oi.items_id,iu.item)
		AND ot.task_type_id           = cx.tipo_trabajo
		AND ot.operating_unit_id      = xu.unidad_operativa
		AND ab.address_id			  = nvl(ot.external_address_id, oa.address_id)
		AND zo.localidad			  = ab.geograp_location_id
		GROUP BY ot.operating_unit_id,
				 ot.order_id,
				 ah.actividad_padre,
				 oi.items_id,
				 iu.liquidacion,
				 zo.id_zona_oper;

		nucontaotnove    NUMBER(6);
		nuitems          ge_items.items_id%TYPE;
		nucontaconfigura NUMBER(4) DEFAULT 0;



	BEGIN

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

		pkg_traza.trace('nuparacta: ' 		|| nuparacta 		|| chr(10) ||
						'dtpasfechaacta: '  || dtpasfechaacta 	|| chr(10) ||
						'nuparsesion: ' 	|| nuparsesion, cnuNVLTRC);

		DELETE ldc_uni_act_ot lk WHERE lk.nussesion = nuparsesion AND lk.nro_acta = nuparacta;

		FOR i IN cuordenesgenerarnovedadact(nuparacta) LOOP
			nucontaotnove    := 0;
			nuitems          := i.nuitemss;
			nucontaconfigura := 0;

			SELECT COUNT(1) INTO nucontaconfigura
			FROM ldc_const_liqtarran qw
			WHERE qw.unidad_operativa   = i.unidad_operativa
			AND qw.actividad_orden   	= i.actividad
			AND qw.items             	= nuitems
			AND qw.zona_ofertados    	= i.id_zona_oper
			AND qw.valor_liquidar   	>= 1
			AND trunc(dtpasfechaacta)  	BETWEEN trunc(qw.fecha_ini_vigen) AND trunc(qw.fecha_fin_vige);

			IF nucontaconfigura >= 1 THEN
				BEGIN
					INSERT INTO ldc_uni_act_ot(nussesion,
											   unidad_operativa,
											   orden,
											   actividad,
											   item,
											   cantidad_item_legalizada,
											   liquidacion,
											   nro_acta,
											   unidad_operativa_padre,
											   zona_ofertados
											   )
					VALUES(nuparsesion,
						   i.unidad_operativa,
						   i.orden,
						   i.actividad,
						   nuitems,
						   i.cantidad_legalizada,
						   i.liquidacion,
						   nuparacta,
						   -1,
						   i.id_zona_oper
						   );
				EXCEPTION
					WHEN dup_val_on_index THEN
					NULL;
				END;
			END IF;
		END LOOP;

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

		END;

BEGIN

	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.fsbINICIO);

	pkg_traza.trace('nupaacta: ' || nupaacta, cnuNVLTRC);

	nucantidadnovgen := 0;
	nutotalvalornov  := 0;

	-- Consultamos datos para registrar inicio del proceso
	SELECT to_number(to_char(SYSDATE,'YYYY')),to_number(to_char(SYSDATE,'MM')),userenv('SESSIONID'),USER INTO nuccano,nuccmes,nusession,sbuser
	FROM dual;

	-- Registramos inicio del proceso
	ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROGENERANOVELTYOFERTADOS','En ejecucion..',nupaacta,sbuser);

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
	ldcprollenaldcuniactot(nupaacta,dtfechafinacta,nusession);

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

		-- Consultamos los rangos
		nureg      		:= -1;
		nuvalfinal 		:= NULL;
		nuvalinicial 	:= null;

		FOR j IN curangos(nuvarunidad, i.actividad, i.item, i.zona_ofertados, dtfechafinacta) LOOP
			nureg            := -1;
		    nuvalfinal       := j.cantidad_final;
		    nuvalinicial     := j.cantidad_inicial; --TICKET 100-85779 ELAL -- se almacena cantidad inicial
		    nuvalordescontar := nvl(j.valor_liquidar,0);
		    nuIdeRegistro  	 := j.id_reg; --TICKET 100-85779 ELAL -- se almacena ide del registro

			-- Validamos si la cantidad esta en un rango
			IF i.cantidad BETWEEN j.cantidad_inicial AND j.cantidad_final THEN
				nureg := 0;
				EXIT;
			END IF;
		END LOOP;

		-- Si la cantidad no esta en ningun rango, validamos si es mayor al ultimo rango
		IF nureg = -1 THEN
			IF i.cantidad > nuvalfinal AND nuvalfinal IS NOT NULL THEN
				nureg := 0;
			END IF;
		END IF;

		-- Si es mayor al ultimo rango, generamos las novedades
		IF nureg = 0 THEN
			--TICKET 100-85779 ELAL-- Guardamos informacion para el reporte
			INSERT INTO ldc_reporte_ofert_escalo(
                                      nusesion,nro_acta,iden_regi,unidad_operativa_esca
                                     ,actividad_rep_escalonado,item_rep_escalonado
                                     ,rango_inicial,rango_final,cantidad_ordenes
                                     ,valor_liquidar,total_ajuste
                                     )
                               VALUES(
                                      nusession,nupaacta,nuIdeRegistro,nuvarunidad
                                     ,i.actividad,i.item
                                     ,nuvalinicial,nuvalfinal,i.cantidad
                                     ,nuvalordescontar,i.cantidad*nuvalordescontar
                                     );

			-- Generamos las novedades para cada una de las ordenes
			FOR j IN cuordernesactaot(i.unidad_operativa,i.actividad,i.item,nusession,nupaacta, i.zona_ofertados) LOOP
				nuorderid := NULL;

				BEGIN
					SELECT pe.person_id INTO nupersona
					FROM sa_user us,ge_person pe
					WHERE us.mask  = USER
					AND us.user_id = pe.user_id;
				EXCEPTION
					WHEN no_data_found THEN
					nupersona := NULL;
				END;

				IF nvl(nuvalordescontar,0) >= 1 THEN
					nuvalordescontarxcant := nvl(nuvalordescontar,0) * j.cantidad_legalizada;
					sbmensaje    := NULL;

					BEGIN
						SELECT ox.* INTO regor_order
						FROM or_order ox
						WHERE ox.order_id = j.order_id;
					EXCEPTION
						WHEN no_data_found THEN
						sbmensaje := 'La ord?n de trabajo : '||to_char(j.order_id)||' no existe en la tabla or_order. Contacte el administrador del sistema';
						ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENERANOVELTYOFERTADOS','Termino con errores.');
						RETURN;
					END;

					-- Obtenemos la novedad asociada al tipo de trabajo
					BEGIN
						SELECT ti.actividad_novedad_ofertados INTO nunovedadgenera
						FROM ldc_tipo_trab_x_nov_ofertados ti
						WHERE ti.tipo_trabajo = regor_order.task_type_id;
					EXCEPTION
						WHEN no_data_found THEN
						nunovedadgenera := NULL;
					END;

					-- Validamos si la orden tiene una novedad y si es asi el valor este actualizado en los rangos
					swencontro := 0;
					FOR x IN cuordenesnovgenval(j.order_id,i.actividad,i.item) LOOP
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
								UPDATE or_order v
								SET v.defined_contract_id   = regor_order.defined_contract_id
									,v.legalization_date    = regor_order.legalization_date
									,v.exec_initial_date    = regor_order.exec_initial_date
									,v.execution_final_date = regor_order.execution_final_date
									,v.exec_estimate_date   = regor_order.exec_estimate_date
									,v.is_pending_liq       = NULL
								WHERE v.order_id = nuorderid;

								UPDATE or_order_activity gh
								SET gh.comment_ = 'Orden de novedad generada ACTIVIDAD : '||to_char(i.actividad)||' ITEM : '||to_char(i.item)
								WHERE gh.order_id = nuorderid;

								INSERT INTO ct_order_certifica(order_id,certificate_id) VALUES(nuorderid,nupaacta);

								nusw := 1;
							END IF;
						END IF;
					END IF;
				END IF;
			END LOOP;
		END IF;
	END LOOP;

	IF nusw = 1 THEN
		UPDATE ge_acta s
		SET s.is_pending = 1
		WHERE s.id_acta = nupaacta;
	END IF;

	DELETE ldc_uni_act_ot lk WHERE lk.nussesion = nusession AND lk.nro_acta = nupaacta;

	INSERT INTO ldc_actas_aplica_proc_ofert(acta
                                        ,procejec
                                        ,novgenera
                                        ,total_nove
                                        ,usuario
                                        ,fecha
                                        )
    VALUES(nupaacta
           ,'LDC_PROGENERANOVELTYOFERTADOS'
           ,nucantidadnovgen
           ,nutotalvalornov
           ,USER
           ,SYSDATE
           );

	sbmensaje := 'Se procesaron : '||to_char(nucontanov)||' registros.';
	ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENERANOVELTYOFERTADOS','Termino Ok.');

	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

EXCEPTION
	WHEN OTHERS THEN
		pkg_Error.setError;
		pkg_Error.getError(nuError, sbmensaje);
		ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENERANOVELTYOFERTADOS','Termino con errores.');
		pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR); 
		RAISE pkg_Error.Controlled_Error;
END;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO LDC_PROGENERANOVELTYOFERTADOS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROGENERANOVELTYOFERTADOS', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REXEREPORTES sobre funcion LDC_PROGENERANOVELTYOFERTADOS
GRANT EXECUTE ON ADM_PERSON.LDC_PROGENERANOVELTYOFERTADOS TO REXEREPORTES;
/