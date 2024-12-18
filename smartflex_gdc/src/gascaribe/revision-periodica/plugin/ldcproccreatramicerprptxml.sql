create or replace PROCEDURE      ldcproccreatramicerprptxml AS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Funcion     : ldcproccreatramicerprptxml
    Descripcion : Procedimiento que crea el tramite de certificacion por revision periodica por medio de XML
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 06-01-2017

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    09-01-2018          Horbath		         200-1638
    12/03/2018          jbrito             CASO 200-1743 Se anula el condicional que valida la fecha m??A-nima de revisi??A?n sea mayor a la fecha  actual
    06/04/2018			    HORBATH.		       200-1871.SE MODIFICA EL XML DE LAS REPARACIONES Y CERTIFICACIONES.
                                           SE CAMBIA EL TAG <PRODUCTO> POR <PRODUCT>
    25/05/2018          Jbrito             caso 200-1956 Se valida Si el usuario no tiene registro en [LDC_MARCA_PRODUCTO] y si el producto tiene registro en la tabla [PR_CERTIFICATE]
                                           con fecha estimada de fin mayor o igual a la fecha actual m?!s el n??mero de meses configurados en el par?!metro LDC_PARNUMMESESVAL.
                                           Si cumple la condici??n marcar al producto con 103
                                           Se elimino La actualizaci??n de la marca despu??s de la generaci??n del tr?!mite
   31/08/2018	       dsaltarin 		  2002017 se modificar para agregar <?xml version="1.0" encoding="ISO-8859-1"?> al xml del tramite
   24/11/2023          jsoto  				Ajustes ((OSF-1855)):
											-Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
											-Ajuste  cambio en manejo de trazas y errores por personalizados (pkg_error y pkg_traza).
											-Ajuste llamado a pkg_xml_sol_rev_periodica para armar los xml de las solicitudes
											-Ajuste llamado a api_registerRequestByXml


**************************************************************************/
     CURSOR cusolicitudesabiertas(nucuproducto pr_product.product_id%TYPE) IS
      SELECT pv.package_id colsolicitud
        FROM mo_packages pv,mo_motive mv
       WHERE pv.package_type_id     IN 
	   								(
									   SELECT regexp_substr(dald_parameter.fsbgetvalue_chain('VAL_TRAMITES_NUEVOS_FLUJOS',NULL), '[^,]+', 1, LEVEL)AS actividad
									   FROM dual
									   CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('VAL_TRAMITES_NUEVOS_FLUJOS',NULL), '[^,]+', 1, LEVEL) IS NOT NULL
									)
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
    sbdireccionparseada ab_address.address_parsed%TYPE;
    nudireccion         ab_address.address_id%TYPE;
    nulocalidad         ab_address.geograp_location_id%TYPE;
    nucategoria         mo_motive.category_id%TYPE;
    nusubcategori       mo_motive.subcategory_id%TYPE;
    sw                  NUMBER(2) DEFAULT 0;
    sbmensa             VARCHAR2(10000);
    numarca             ld_parameter.parameter_id%TYPE;
    numarcaantes        ldc_marca_producto.suspension_type_id%TYPE;
    nucantotleg         NUMBER(8);
    dtplazominrev       ldc_plazos_cert.plazo_min_revision%TYPE;
    sbsolicitudes       VARCHAR2(1000);
	csbMetodo  	  		CONSTANT VARCHAR2(100) := 'LDCPROCCREATRAMICERPRPTXML';
	sbproceso  			VARCHAR2(100) := 'LDCPROCCREATRAMICERPRPTXML'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');			
	
    --------------------
    -- caso 200-1956 -->
    --------------------
    nMarca              NUMBER;
    numes               NUMBER;
    nuCertificadoExite  NUMBER;
    --------------------
    -- caso 200-1956 <--
    --------------------
  --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
  CURSOR cuProducto(nuorden NUMBER) IS
   SELECT 	product_id, 
			subscription_id, 
			ot.task_type_id,
			package_id,
			at.subscriber_id,
			ot.operating_unit_id
     FROM or_order_activity at,or_order ot
    WHERE at.order_id = nuorden
      AND package_id IS NOT NULL
      AND at.order_id = ot.order_id
      AND rownum   = 1;
	  
	  
	CURSOR cuMarca(inuproducto pr_product.product_id%TYPE) IS
		SELECT COUNT(1) 
		FROM ldc_marca_producto
		WHERE ID_PRODUCTO = inuproducto;


	CURSOR cuExisteCertificado(inuproducto pr_product.product_id%TYPE,
								inumes NUMBER) IS
	  SELECT count(1) 
		 FROM( SELECT *
				FROM pr_certificate
				WHERE PRODUCT_ID = inuproducto
				AND ESTIMATED_END_DATE >= ADD_MONTHS(SYSDATE, inumes)
				ORDER BY REGISTER_DATE DESC )
		 WHERE ROWNUM = 1;

	CURSOR cuCantOrdenes(inupakageid mo_packages.package_id%TYPE)IS
		 SELECT COUNT(1) 
		   FROM or_order_activity oal, or_order otl
		  WHERE oal.package_id = inupakageid
			AND otl.task_type_id <> dald_parameter.fnuGetNumeric_Value('TIPO_TRABAJO_DOC_TRAM_REP',NULL)
			AND otl.order_status_id NOT IN(8,12)
			AND oal.order_id = otl.order_id;

	CURSOR cuDatosPro(inuproducto pr_product.product_id%TYPE ) IS
			SELECT di.address_parsed
				,di.address_id
				,di.geograp_location_id
				,pr.category_id
				,pr.subcategory_id
			FROM pr_product pr,ab_address di
		   WHERE pr.product_id = inuproducto
			 AND pr.address_id = di.address_id;

	CURSOR cuPlazoRev(inuproducto pr_product.product_id%TYPE) IS
       SELECT pc.plazo_min_revision 
         FROM ldc_plazos_cert pc
        WHERE pc.id_producto = inuproducto
          AND rownum = 1;
	  
    sbflag              VARCHAR2(1);
    nuunidadoperativa   or_order.operating_unit_id%TYPE;

BEGIN

pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

 -- Inicializamos el proceso
 pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);

 --Obtener el identificador de la orden  que se encuentra en la instancia
 nuorden       := pkg_bcordenes.fnuobtenerotinstancialegal;
 nucausalorder := pkg_bcordenes.fnuobtienecausal(nuorden);
 pkg_traza.trace('Numero de la Orden:'||nuorden, pkg_traza.cnuNivelTrzDef);
 -- obtenemos el producto y el paquete
    OPEN cuproducto(nuorden);
   FETCH cuProducto 
	INTO nuproductid, 
		 nucontratoid, 
		 nutasktypeid,
		 nupakageid,
		 nucliente,
		 nuunidadoperativa;
      IF cuProducto%NOTFOUND THEN
         sbmensa := 'Proceso termino con errores : '||'El cursor cuProducto no arrojo datos con el # de orden'||to_char(nuorden);
         pkg_estaproc.prActualizaEstaproc(sbproceso,' Con Errores',sbmensa);
         pkg_error.setErrorMessage(ld_boconstans.cnugeneric_error,sbmensa);
         RAISE pkg_error.controlled_error;
	  END IF;
   CLOSE cuproducto;
   pkg_traza.trace('Salio cursor cuProducto, nuProductId: '||nuProductId||'nuContratoId:'||'nuTaskTypeId:'||nuTaskTypeId, pkg_traza.cnuNivelTrzDef);

    --------------------
    -- caso 200-1956 -->
    --------------------
     BEGIN

		IF cuMarca%ISOPEN THEN
			CLOSE cuMarca;
		END IF;

		OPEN cuMarca(nuProductId);
		FETCH cuMarca INTO nMarca;
		IF cuMarca%NOTFOUND THEN
			CLOSE cuMarca;
			RAISE no_data_found;
		END IF;
		CLOSE cuMarca;

     EXCEPTION
          WHEN no_data_found THEN
           nMarca := NULL;
     END;

     IF nMarca = 0 THEN
              numes := DALD_PARAMETER.fnuGetNumeric_Value('LDC_PARNUMMESESVAL');
              pkg_traza.trace('LDCPROCCREATRAMICERPRPTXML-numes -->'||numes, pkg_traza.cnuNivelTrzDef);

              BEGIN
					IF cuExisteCertificado%ISOPEN THEN
						CLOSE cuExisteCertificado;
					END IF;

					OPEN cuExisteCertificado(nuProductId, numes);
					FETCH cuExisteCertificado INTO nuCertificadoExite;
					IF cuExisteCertificado%NOTFOUND THEN
						CLOSE cuExisteCertificado;
						RAISE no_data_found;
					END IF;
					CLOSE cuExisteCertificado;
               EXCEPTION
                WHEN no_data_found THEN
                 nuCertificadoExite := 0;
              END;

              IF nuCertificadoExite > 0 THEN
                 numarca := ldcfncretornamarcacerprp;
                 ldcprocinsactumarcaprodu(nuproductid,numarca,nuorden);
                 ldc_prmarcaproductolog(nuproductid, null, numarca , 'Legalizacion OT :'||nuorden);
              END IF;
     END IF;
    --------------------
    -- caso 200-1956 <--
    --------------------

 -- Obtenemos todas las ordenes legalizadas de esta solicitud
  nucantotleg := 0;

	IF cuCantOrdenes%ISOPEN THEN
		CLOSE cuCantOrdenes;
	END IF;

	OPEN cuCantOrdenes(nupakageid);
	FETCH cuCantOrdenes INTO nucantotleg;
	CLOSE cuCantOrdenes;

  -- Actualizamos las solicitud que se esta legalizando para que no salga como pendiente
   UPDATE mo_packages m
      SET m.motive_status_id = 14
    WHERE m.package_id       = nupakageid;
  -- Buscamos solicitudes de revisi?n periodica generadas
  sbsolicitudes := NULL;
  FOR i IN cusolicitudesabiertas(nuproductid) LOOP
   IF sbsolicitudes IS NULL THEN
    sbsolicitudes := i.colsolicitud;
   ELSE
    sbsolicitudes := sbsolicitudes||','||to_char(i.colsolicitud);
   END IF;
  END LOOP;
   IF TRIM(sbsolicitudes) IS NULL AND nucantotleg IN(0,1) THEN
     -- Actualiza a estado atendido el mo_component
     UPDATE mo_component mc
        SET mc.motive_status_id = dald_parameter.fnuGetNumeric_Value('ESTADO_COMPONENTE_ATENDIDO',NULL)
      WHERE mc.motive_id IN(
                            SELECT mo.motive_id
                              FROM mo_motive mo
                             WHERE mo.package_id = nupakageid
                            );
     -- Obtenemos los datos de la solicitud de visita de verificacion para generar el tramite de defecto critico
     sbdireccionparseada := NULL;
     nudireccion         := NULL;
     nulocalidad         := NULL;
     nucategoria         := NULL;
     nusubcategori       := NULL;
     sw                  := 1;
     BEGIN

		IF cuDatosPro%ISOPEN THEN
			CLOSE cuDatosPro;
		END IF;

		OPEN cuDatosPro(nuproductid);
		FETCH cuDatosPro  
        INTO sbdireccionparseada
            ,nudireccion
            ,nulocalidad
            ,nucategoria
            ,nusubcategori;
		IF cuDatosPro%NOTFOUND THEN
			CLOSE cuDatosPro;
			RAISE no_data_found;
		END IF;
		CLOSE cuDatosPro;

     EXCEPTION
      WHEN no_data_found THEN
       sw := 0;
     END;
	 
    IF sw = 1 THEN
     -- Construimos XML para generar el tramite
     nupackageid      := NULL;
     numotiveid       := NULL;
     nuerrorcode      := NULL;
     sberrormessage   := NULL;
     sbcomment        := dald_parameter.fsbGetValue_Chain('COMENTARIO_CERTIFICACION_PRP')||' AL LEGALIZAR ORDEN : '||to_char(nuorden)||' CON CAUSAL : '||to_char(nucausalorder);
     numediorecepcion := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_CERT_PRP');



	sbrequestxml1 := pkg_xml_soli_rev_periodica.getXMSolicitudCertificacionRp(numediorecepcion,
																			  sbcomment,
																			  nuproductid,
																			  nucliente);
					   
    -- Se crea la solicitud y la orden de trabajo
     api_registerRequestByXml(
                               sbrequestxml1,
                               nupackageid,
                               numotiveid,
                               nuerrorcode,
                               sberrormessage
                             );
							 
     IF nupackageid IS NULL THEN
      sbmensa := 'Proceso termino con errores : '||'Error al generar la solicitud de certificacion prp. Codigo error : '||to_char(nuerrorcode)||' Mensaje de error : '||sberrormessage;
	  pkg_estaproc.prActualizaEstaproc(sbproceso,' Con Errores',sbmensa);
      pkg_error.setErrorMessage(ld_boconstans.cnugeneric_error,sbmensa);
      RAISE pkg_error.controlled_error;
     ELSE
      -- Verificamos la fecha minima del certificado del producto.
      BEGIN

		IF cuPlazoRev%ISOPEN THEN
			CLOSE cuPlazoRev;
		END IF;
		
		OPEN cuPlazoRev(nuproductid);
		FETCH cuPlazoRev INTO dtplazominrev;
		IF cuPlazoRev%NOTFOUND THEN
			CLOSE cuPlazoRev;
			RAISE no_data_found;
		END IF;
		CLOSE cuPlazoRev;

      EXCEPTION
       WHEN no_data_found THEN
        dtplazominrev := to_date('01/01/1900','dd/mm/yyyy');
      END;
        ldcproccrearegistrotramtab(ldc_seq_tramites_revper.nextval,nuproductid,nupackageid,numarcaantes,numarca,SYSDATE,'Se atiende la solicitud nro : '||to_char(nupakageid));
        sbflag := ldc_fsbretornaaplicaasigauto(nutasktypeid,nucausalorder);

      IF nvl(sbflag,'N') = 'S' THEN
       ldc_procrearegasiunioprevper(nuunidadoperativa,nuproductid,nutasktypeid,nuorden,nupackageid);
      END IF;

        -- Dejamos la solicitud como estaba
          UPDATE mo_packages m
             SET m.motive_status_id = 13
           WHERE m.package_id       = nupakageid;
        sbmensa := 'Proceso termino Ok. Se genero la solicitud Nro : '||to_char(nupackageid);
        pkg_estaproc.prActualizaEstaproc(sbproceso,' Ok',sbmensa);
     END IF;
    ELSE
      sbmensa := 'Proceso termino con errores : '||'No se encontraron datos de la solicitud asociada a la orden # '||to_char(nuorden);
      pkg_estaproc.prActualizaEstaproc(sbproceso,' Con Errores',sbmensa);
      pkg_error.setErrorMessage(ld_boconstans.cnugeneric_error,sbmensa);
      RAISE pkg_error.controlled_error;
    END IF;
   ELSE
    sbmensa := 'Error al generar la solicitud para el producto : '||to_char(nuproductid)||' Tiene las siguientes solicitudes de revisi?n periodica en estado registradas : '||TRIM(sbsolicitudes);
    pkg_estaproc.prActualizaEstaproc(sbproceso,' Con Errores',sbmensa);
	pkg_error.setErrorMessage(ld_boconstans.cnugeneric_error,sbmensa);
    RAISE pkg_error.controlled_error;
   END IF;
   
   pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
   
EXCEPTION
 WHEN pkg_error.controlled_error THEN
  pkg_error.setError;
  pkg_error.getError(nuerrorcode,sberrormessage);
  pkg_traza.trace(csbMetodo||' '||sberrormessage);
  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
  RAISE;
 WHEN OTHERS THEN
  pkg_error.setError;
  pkg_error.getError(nuerrorcode,sberrormessage);
  sbmensa := 'Proceso termino con Errores. '||sberrormessage;
  pkg_estaproc.prActualizaEstaproc(sbproceso,' Con Errores',sbmensa);
  pkg_traza.trace(csbMetodo||' '||sbmensa);
  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  RAISE pkg_error.controlled_error;
END ldcproccreatramicerprptxml;
/