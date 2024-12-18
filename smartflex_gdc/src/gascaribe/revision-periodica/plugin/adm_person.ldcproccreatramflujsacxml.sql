create or replace PROCEDURE adm_person.ldcproccreatramflujsacxml AS
/******************************************************************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2018-09-27
  Descripcion : Procedimiento de acuerdo a la marca producto, registra un tramite de revision, reparacion o certificacion.

  Parametros Entrada

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION
  09/05/2019   dsaltarin ca-200-2625. Se toman las modificaciones realiazadas en el caso CA 200-2231  por ljlb se coloca cursor para
									  consultar producto de autoreconectado
  30/11/2023   jsoto  	 Ajustes ((OSF-1851)):
						-Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
						-Ajuste  cambio en manejo de trazas y errores por personalizados (pkg_error y pkg_traza).
						-Ajuste llamado a pkg_xml_soli_rev_periodica para armar los xml de las solicitudes
						-Ajuste llamado a api_legalizeorders, api_assign_order en reemplazo de api's de producto
						-Ajuste Registrar el estado de proceso entidad estaproc (pkg_estaproc).
  19-04-2024   Adrianavg OSF-2569: Se migra del esquema OPEN al esquema ADM_PERSON
*******************************************************************************************************************************/
 CURSOR cusolicitudesabiertas(nucuproducto pr_product.product_id%TYPE) IS
  SELECT pv.package_id colsolicitud
    FROM mo_packages pv, mo_motive mv
   WHERE pv.package_type_id IN
							   (SELECT regexp_substr(dald_parameter.fsbgetvalue_chain('VAL_TRAMITES_NUEVOS_FLUJOS',NULL), '[^,]+', 1, LEVEL)AS tiposol
								FROM dual
								CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('VAL_TRAMITES_NUEVOS_FLUJOS', NULL), '[^,]+', 1, LEVEL) IS NOT NULL)
   AND pv.motive_status_id = dald_parameter.fnuGetNumeric_Value('ESTADO_SOL_REGISTRADA')
   AND mv.product_id       = nucuproducto
   AND pv.package_id       = mv.package_id;

	nuErrorCode         NUMBER;
	sbErrorMessage      VARCHAR2(4000);
	nuPackageId         mo_packages.package_id%type;
	nuMotiveId          mo_motive.motive_id%type;
	sbrequestxml1       constants_per.tipo_xml_sol%TYPE;
	nuorden             or_order.order_id%type;
	sbComment           VARCHAR2(2000);
	nuProductId         NUMBER;
	nuContratoId        NUMBER;
	nuTaskTypeId        NUMBER;
	nuCausalOrder       NUMBER;
	ex_error            EXCEPTION;
	nupakageid          mo_packages.package_id%TYPE;
	nucliente           ge_subscriber.subscriber_id%TYPE;
	numediorecepcion    mo_packages.reception_type_id%TYPE;
	nucategoria         mo_motive.category_id%TYPE;
	nusubcategori       mo_motive.subcategory_id%TYPE;
	sw                  NUMBER(2) DEFAULT 0;
	sbmensa             VARCHAR2(10000);
	numarca             ld_parameter.parameter_id%TYPE;
	nuunidadoperativa   or_order.operating_unit_id%TYPE;
	sbflag              VARCHAR2(1);
	nucontacomponentes  NUMBER(4);
	nunumber            NUMBER(4) DEFAULT 0;
	nuprodmotive        mo_component.prod_motive_comp_id%TYPE;
	sbtagname           mo_component.tag_name%TYPE;
	nuclasserv          mo_component.class_service_id%TYPE;
	nucomppadre         mo_component.component_id%TYPE;
	rcComponent         damo_component.stymo_component;
	rcmo_comp_link      damo_comp_link.stymo_comp_link;
	sbsolicitudes       VARCHAR2(1000);
	nuestadosol         mo_packages.motive_status_id%TYPE;
	nucontaexiste       NUMBER(5);
	nusaldodiferi       diferido.difesape%TYPE;
	nutiposolgene       ps_package_type.package_type_id%TYPE;
  	sbPrograma			VARCHAR2(100) := 'LDCPROCCREATRAMFLUJSACXML'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
	csbMetodo  	  		CONSTANT VARCHAR2(100) := 'LDCPROCCREATRAMFLUJSACXML';


  --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
	CURSOR cuProducto(nuorden NUMBER) IS
	SELECT product_id, subscription_id, ot.task_type_id,oa.package_id,oa.subscriber_id,ot.operating_unit_id,m.motive_status_id estado_solicitud
	FROM or_order_activity oa,or_order ot,mo_packages m
	WHERE oa.order_id = nuorden
		AND oa.package_id IS NOT NULL
		AND oa.order_id = ot.order_id
		AND oa.package_id = m.package_id
		AND rownum   = 1;
    -- Cursor para obtener los componentes asociados a un motivo
  CURSOR cuComponente(nucumotivos mo_motive.motive_id%TYPE) IS
   SELECT COUNT(1)
     FROM mo_component c
    WHERE c.motive_id = nucumotivos;

---200-2625
  CURSOR cuProductoAuto(nuorden NUMBER) IS
    SELECT product_id, subscription_id, ot.task_type_id,package_id,oa.subscriber_id,ot.operating_unit_id
     FROM or_order_activity oa,or_order ot
    WHERE oa.order_id = nuorden
      AND oa.order_id = ot.order_id
      AND rownum   = 1;
---200-2625

	CURSOR cuTipoSolicitud(inutasktypeid or_order.task_type_id%TYPE)IS
		SELECT ts.tipo_solicitud_revper
		FROM ldc_conf_ttsusreco_tisolgene ts
		WHERE ts.tipo_trabajo_susp_reco = inutasktypeid;


BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

	-- Inicializamos el proceso
	pkg_estaproc.prInsertaEstaproc(sbPrograma,NULL);

	--Obtener el identificador de la orden  que se encuentra en la instancia
	nuorden       := pkg_bcordenes.fnuobtenerotinstancialegal;
	nucausalorder := pkg_bcordenes.fnuobtienecausal(nuorden);

	pkg_traza.trace('Numero de la Orden:'||nuorden, pkg_traza.cnuNivelTrzDef);

	-- obtenemos el producto y el paquete
	OPEN cuproducto(nuorden);
	FETCH cuProducto INTO nuproductid, nucontratoid, nutasktypeid,nupakageid,nucliente,nuunidadoperativa,nuestadosol;
		IF cuProducto%NOTFOUND THEN
			--200-2625-------------
			open cuProductoAuto(nuorden);
			fetch cuProductoAuto into nuproductid, nucontratoid, nutasktypeid,nupakageid,nucliente,nuunidadoperativa;
      if cuProductoAuto%notfound then
        sbmensa := 'Proceso termino con errores : '||'El cursor cuProducto no arrojo datos con el # de orden'||to_char(nuorden);
			  pkg_estaproc.prActualizaEstaproc(sbPrograma,' con Error',sbmensa);
			  pkg_error.setErrorMessage(pkg_error.cnugeneric_message,sbmensa);
			  RAISE pkg_error.controlled_error;
      end if;
			close cuProductoAuto;
			--200-2625-------------

		END IF;
	CLOSE cuproducto;
	pkg_traza.trace('Salio cursor cuProducto, nuProductId: '||nuProductId||'nuContratoId:'||'nuTaskTypeId:'||nuTaskTypeId, pkg_traza.cnuNivelTrzDef);
	-- Actualizamos las solicitud que se esta legalizando para que no salga como pendiente
	IF nuestadosol = 13 THEN
		UPDATE mo_packages m
		  SET m.motive_status_id = 14
		WHERE m.package_id       = nupakageid;
	END IF;
	-- Buscamos solicitudes de revisi?n periodica generadas
	sbsolicitudes := NULL;
	FOR i IN cusolicitudesabiertas(nuproductid) LOOP
		IF sbsolicitudes IS NULL THEN
			sbsolicitudes := i.colsolicitud;
		ELSE
			sbsolicitudes := sbsolicitudes||','||to_char(i.colsolicitud);
		END IF;
	END LOOP;
	IF TRIM(sbsolicitudes) IS NULL THEN
		-- Obtenemos los datos de la solicitud de visita de verificacion para generar el tramite de defecto critico

		nucategoria         := NULL;
		nusubcategori       := NULL;
		sw                  := 1;

		nucategoria         := pkg_bcproducto.fnuCategoria(nuproductid);
		nusubcategori       := pkg_bcproducto.fnuSubCategoria(nuproductid);

		IF nucategoria IS NULL OR nusubcategori IS NULL THEN
			sw := 0;
		END IF;

		IF sw = 1 THEN
			-- Consultamos configuracion del tipo de trabajo legalizado por solicitud a generar
			nutiposolgene := NULL;

			BEGIN

				IF cuTipoSolicitud%ISOPEN then
					CLOSE cuTipoSolicitud;
				END IF;

				OPEN cuTipoSolicitud(nutasktypeid);
				FETCH cuTipoSolicitud INTO nutiposolgene;
				IF cuTipoSolicitud%NOTFOUND then
					CLOSE cuTipoSolicitud;
					RAISE no_data_found;
				END IF;
				CLOSE cuTipoSolicitud;

			EXCEPTION
				WHEN no_data_found THEN
					nutiposolgene := NULL;
			END;
			-- Asignamos marca
			IF nutiposolgene IS NOT NULL THEN
				IF nutiposolgene = dald_parameter.fnuGetNumeric_Value('SOLICITUD_VISITA',NULL) THEN
					numarca := ldcfncretornamarcarevprp;
				ELSIF nutiposolgene = dald_parameter.fnuGetNumeric_Value('TRAMITE_DEFECTO_CRITICO',NULL) THEN
					numarca := ldcfncretornamarcadefcri;
				ELSIF nutiposolgene = dald_parameter.fnuGetNumeric_Value('TRAMITE_REPARACION_PRP',NULL) THEN
					numarca := ldcfncretornamarcarepprp;
				ELSIF nutiposolgene = dald_parameter.fnuGetNumeric_Value('TRAMITE_CERTIFICACION_PRP',NULL) THEN
					numarca := ldcfncretornamarcacerprp;
				END IF;
			ELSE
				-- Consultamos que marca tiene el producto
				numarca := ldc_fncretornamarcaprod(nuproductid);
			END IF;
			IF numarca = ldcfncretornamarcarevprp THEN
				-- Validamos marca del producto
				nusaldodiferi := ldc_fncretornasalddifvisita(nuproductid);
				IF nusaldodiferi <> 0 THEN
					sbmensa := 'Proceso termino con errores : producto : '||to_char(nuproductid)||' tiene diferidos con saldo del concepto 739 y/o 755. Saldo : '||to_char(nusaldodiferi);
					pkg_estaproc.prActualizaEstaproc(sbPrograma,' con Error',sbmensa);
					pkg_error.setErrorMessage(pkg_error.cnugeneric_message,sbmensa);
					RAISE pkg_error.controlled_error;
				END IF;
				--200-1662
				sbcomment        :=substr(ldc_retornacomentotlega(nuorden),1,1980)||' orden legalizada : '||to_char(nuorden)||' con causal : '||to_char(nucausalorder)||' SE GENERO SOLICITUD VISITA_IDENTIFICACION_CERTIFICADO';
				--200-1662
				numediorecepcion := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_VISITA');

				sbrequestxml1 := pkg_xml_soli_rev_periodica.getSolicitudRevisionRp(
																					numediorecepcion,
																					sbcomment,
																					nuproductid,
																					nucliente
																				   );

			ELSIF numarca IN(ldcfncretornamarcarepprp,ldcfncretornamarcadefcri) THEN
				sbcomment        :=substr(ldc_retornacomentotlega(nuorden),1,1980)||' orden legalizada : '||to_char(nuorden)||' con causal : '||to_char(nucausalorder)||' SE GENERO SOLICITUD REPARACION PRP.';
				numediorecepcion := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_REPARACION_PRP');

				sbrequestxml1 := pkg_xml_soli_rev_periodica.getSolicitudReparacionRp(
																					numediorecepcion,
																					sbcomment,
																					nuproductid,
																					nucliente
																					);

			ELSIF numarca = ldcfncretornamarcacerprp THEN
				sbcomment        :=substr(ldc_retornacomentotlega(nuorden),1,1980)||' orden legalizada : '||to_char(nuorden)||' con causal : '||to_char(nucausalorder)||' SE GENERO SOLICITUD CERTIFICACION PRP.';
				numediorecepcion := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_CERT_PRP');

				sbrequestxml1 := pkg_xml_soli_rev_periodica.getXMSolicitudCertificacionRp(
																							numediorecepcion,
																							sbcomment,
																							nuproductid,
																							nucliente
																						 );
			END IF;

			pkg_traza.trace('sbrequestxml1: '|| sbrequestxml1);

			-- Generamos la solicitud y la orden de trabajo
			nupackageid      := NULL;
			numotiveid       := NULL;
			nuerrorcode      := NULL;
			sberrormessage   := NULL;
			IF numarca IN(
						 ldcfncretornamarcarevprp
						,ldcfncretornamarcadefcri
						,ldcfncretornamarcarepprp
						,ldcfncretornamarcacerprp
						) THEN
				api_registerRequestByXml(
										   sbrequestxml1,
										   nupackageid,
										   numotiveid,
										   nuerrorcode,
										   sberrormessage
										);

				IF nupackageid IS NULL THEN
					sbmensa := 'Proceso termino con errores : '||'Error al generar la solicitud. Codigo error : '||to_char(nuerrorcode)||' Mensaje de error : '||sberrormessage;
					pkg_estaproc.prActualizaEstaproc(sbPrograma,' con Error',sbmensa);
					pkg_error.setErrorMessage(pkg_error.cnugeneric_message,sbmensa);
					RAISE pkg_error.controlled_error;
				ELSE
					-- Marcamos el producto
					ldcprocinsactumarcaprodu(nuproductid,numarca,nuorden);
					ldcproccrearegistrotramtab(ldc_seq_tramites_revper.nextval,nuproductid,nupackageid,numarca,numarca,SYSDATE,'SE GENERA AL REALIZAR LA RECONEXION DEL PRODUCTO.');
					-- Dejamos la solicitud como estaba
					IF nuestadosol = 13 THEN
						UPDATE mo_packages m
						  SET m.motive_status_id = 13
						WHERE m.package_id       = nupakageid;
					END IF;
					-- Consultamos si el motivo generado tiene asociado los componentes
					IF numarca = ldcfncretornamarcarepprp THEN
						OPEN cuComponente(numotiveid);
						FETCH cuComponente INTO nucontacomponentes;
						CLOSE cuComponente;
						-- Si el motivo no tine los componentes asociados, se procede a registrarlos
						IF (nucontacomponentes=0)THEN
							FOR i IN (
									  SELECT kl.*
										FROM pr_component kl
									   WHERE kl.product_id = nuProductId
										 AND kl.component_status_id <> 9
									   ORDER BY kl.component_type_id
									  ) LOOP
								IF i.component_type_id = 7038 THEN
									nunumber     := 1;
									nuprodmotive := 10346;
									sbtagname    := 'C_GAS_10346';
									nuclasserv   := NULL;
								ELSIF i.component_type_id = 7039 THEN
									nunumber     := 2;
									nuprodmotive := 10348;
									sbtagname    := 'C_MEDICION_10348';
									nuclasserv   := 3102;
								END IF;
								rcComponent.component_id         := mo_bosequences.fnugetcomponentid();
								rcComponent.component_number     := nunumber;
								rcComponent.obligatory_flag      := 'N';
								rcComponent.obligatory_change    := 'N';
								rcComponent.notify_assign_flag   := 'N';
								rcComponent.authoriz_letter_flag := 'N';
								rcComponent.status_change_date   := SYSDATE;
								rcComponent.recording_date       := SYSDATE;
								rcComponent.directionality_id    := 'BI';
								rcComponent.custom_decision_flag := 'N';
								rcComponent.keep_number_flag     := 'N';
								rcComponent.motive_id            := numotiveid;
								rcComponent.prod_motive_comp_id  := nuprodmotive;
								rcComponent.component_type_id    := i.component_type_id;
								rcComponent.motive_type_id       := 75;
								rcComponent.motive_status_id     := 15;
								rcComponent.product_motive_id    := 100304;
								rcComponent.class_service_id     := nuclasserv;
								rcComponent.package_id           := nupackageid;
								rcComponent.product_id           := i.product_id;
								rcComponent.service_number       := i.product_id;
								rcComponent.component_id_prod    := i.component_id;
								rcComponent.uncharged_time       := 0;
								rcComponent.product_origin_id    := i.product_id;
								rcComponent.quantity             := 1;
								rcComponent.tag_name             := sbtagname;
								rcComponent.is_included          := 'N';
								rcComponent.category_id          := nucategoria;
								rcComponent.subcategory_id       := nusubcategori;
								damo_component.Insrecord(rcComponent);
								UPDATE pr_component fx
								SET fx.category_id    = nucategoria
								   ,fx.subcategory_id = nusubcategori
								WHERE fx.component_id = i.component_id;
								IF i.component_type_id = 7038 THEN
									nucomppadre :=  rcComponent.component_id;
								END IF;
								IF(nuMotiveId IS NOT NULL)THEN
									rcmo_comp_link.child_component_id  := rcComponent.component_id;
									IF i.component_type_id = 7039 THEN
										rcmo_comp_link.father_component_id := nucomppadre;
									ELSE
										rcmo_comp_link.father_component_id := NULL;
									END IF;
									rcmo_comp_link.motive_id           := nuMotiveId;
									damo_comp_link.insrecord(rcmo_comp_link);
								END IF;
							END LOOP;
						END IF;
					END IF;
					-- Si la unidad operativa no debe asignar automatica, no se guarda el registro
					SELECT COUNT(1) INTO nucontaexiste
					FROM or_operating_unit uo
					WHERE uo.operating_unit_id IN
													(SELECT regexp_substr(dald_parameter.fsbgetvalue_chain('VAL_UNIDAD_OPER_REGENERA',NULL), '[^,]+', 1, LEVEL)AS unidad
													FROM dual
													CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('VAL_UNIDAD_OPER_REGENERA', NULL), '[^,]+', 1, LEVEL) IS NOT NULL)
					 AND uo.operating_unit_id = nuunidadoperativa;

					sbflag := ldc_fsbretornaaplicaasigauto(nutasktypeid,nucausalorder);
					IF nvl(sbflag,'N') = 'S' AND nucontaexiste = 0 THEN
						ldc_procrearegasiunioprevper(nuunidadoperativa,nuproductid,nutasktypeid,nuorden,nupackageid);
					END IF;
					sbmensa := 'Proceso termino Ok. Se genero la solicitud Nro : '||to_char(nupackageid);
					pkg_estaproc.prActualizaEstaproc(sbPrograma,' Ok',sbmensa);
				END IF;
			ELSE
				sbmensa := 'Proceso termino con Errores. Marca nro '||numarca||' no es valida.';
				pkg_estaproc.prActualizaEstaproc(sbPrograma,' con Error',sbmensa);
				pkg_error.setErrorMessage(pkg_error.cnugeneric_message,sbmensa);
				RAISE pkg_error.controlled_error;
			END IF;
		END IF;
	ELSE
		sbmensa := 'Error al generar la solicitud para el producto : '||to_char(nuproductid)||' Tiene las siguientes solicitudes de revisi?n periodica en estado registradas : '||TRIM(sbsolicitudes);
		pkg_estaproc.prActualizaEstaproc(sbPrograma,' con Error',sbmensa);
		pkg_error.setErrorMessage(pkg_error.cnugeneric_message,sbmensa);
		RAISE pkg_error.controlled_error;
	END IF;

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
	WHEN pkg_error.controlled_error THEN
		pkg_error.setError;
		pkg_error.getError(nuerrorcode,sberrormessage);
		sbmensa := 'Proceso termino con Errores. '||sberrormessage;
		pkg_estaproc.prActualizaEstaproc(sbPrograma,' con Error',sbmensa);
		pkg_traza.trace(csbMetodo||' '|| sbmensa,pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		RAISE;
	WHEN OTHERS THEN
		pkg_error.setError;
		pkg_error.getError(nuerrorcode,sberrormessage);
		sbmensa := 'Proceso termino con Errores. '||sberrormessage;
		pkg_estaproc.prActualizaEstaproc(sbPrograma,' con Error',sbmensa);
		pkg_traza.trace(csbMetodo||' '|| sbmensa,pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		RAISE pkg_error.controlled_error;
END LDCPROCCREATRAMFLUJSACXML;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO LDCPROCCREATRAMFLUJSACXML
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCPROCCREATRAMFLUJSACXML', 'ADM_PERSON'); 
END;
/