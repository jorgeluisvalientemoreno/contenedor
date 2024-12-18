create or replace PROCEDURE ADM_PERSON.LDC_CREATRAMITESUSPACOMET AS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Funcion     : LDC_CREATRAMITESUSPACOMET
    Descripcion : Procedimiento que crea el tramite de suspension x acometida por medio de XML.

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    18/09/2018          JOSH BRITO          CASO 200-2073 Cuando se legalice la orden 10833 con causal 3601 definido en el par¿¿metro [TITRCAUSL_REPADEFCRIT_SUSPACOM],
                                            si el producto se encuentra suspendido, no generar tr¿¿mite de suspensi¿¿n
    16/03/2021          LJLB                CA 472 se modifica plugin para que se pueda legalizar orden por plugin
	
	14/11/2023			jsoto				OSF-1766 Ajustes previos a la mirgacion a 8. Se actualiza entre otros:
											-Manejo de errores por pkg_error
											-Manejo de trazas por pkg_traza
											-Reemplazo de llamado a objetos de producto por objetos personalizados
											-Se suprimen "AplicaEntregas" que no estén activas actualmente
  **************************************************************************/

    onuErrorCode            NUMBER;
    osbErrorMessage         VARCHAR2 (4000);
    nuPackage_id            mo_packages.package_id%TYPE;
    nuMotiveId              mo_motive.motive_id%TYPE;
    sbrequestxml1           constants_per.tipo_xml_sol%TYPE;
    nuorden                 or_order.order_id%TYPE;
    dtfechasuspension       DATE;
    sbComment               VARCHAR2 (2000);
    nuProductId             NUMBER;
    nuContratoId            NUMBER;
    nuTaskTypeId            NUMBER;
    nuCausalOrder           NUMBER;
    ex_error                EXCEPTION;
    nupakageid              mo_packages.package_id%TYPE;
    nucliente               ge_subscriber.subscriber_id%TYPE;
    numediorecepcion        mo_packages.reception_type_id%TYPE;
    sbdireccionparseada     ab_address.address_parsed%TYPE;
    nudireccion             ab_address.address_id%TYPE;
    nulocalidad             ab_address.geograp_location_id%TYPE;
    nucategoria             mo_motive.category_id%TYPE;
    nusubcategori           mo_motive.subcategory_id%TYPE;
    sw                      NUMBER (2) DEFAULT 0;
    sbmensa                 VARCHAR2 (10000);
    numarca                 ld_parameter.numeric_value%TYPE;
    numarcaantes            ldc_marca_producto.suspension_type_id%TYPE;
    nucontacomponentes      NUMBER (4);
    nunumber                NUMBER (4) DEFAULT 0;
    nuprodmotive            mo_component.prod_motive_comp_id%TYPE;
    sbtagname               mo_component.tag_name%TYPE;
    nuclasserv              mo_component.class_service_id%TYPE;
    nucomppadre             mo_component.component_id%TYPE;
    rcComponent             damo_component.stymo_component;
    rcmo_comp_link          damo_comp_link.stymo_comp_link;
    dtplazominrev           ldc_plazos_cert.plazo_min_revision%TYPE;
    sbsolicitudes           VARCHAR2 (1000);
    sbflag                  VARCHAR2 (1);
    numeresuspadmin         mo_packages.reception_type_id%TYPE;
    nuunidadoperativa       or_order.operating_unit_id%TYPE;
    inuSUSPENSION_TYPE_ID   ldc_marca_producto.SUSPENSION_TYPE_ID%TYPE;
    nutipoCausal            NUMBER;
    nuCausal                NUMBER;
    nuEstadoPro             NUMBER;
	csbMT_NAME  VARCHAR2(70) :=  'LDC_CREATRAMITESUSPACOMET';
	sbproceso  VARCHAR2(100) := 'LDC_CREATRAMITESUSPACOMET'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

    --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
    CURSOR cuProducto (nuorden NUMBER)
    IS
        SELECT product_id,
               subscription_id,
               ot.task_type_id,
               package_id,
               at.subscriber_id,
               ot.operating_unit_id,
               (SELECT person_id
                FROM or_order_person P
                WHERE P.order_id = ot.order_id AND ROWNUM < 2)    persona
        FROM or_order_activity at, or_order ot
        WHERE     at.order_id = nuorden
        AND package_id IS NOT NULL
        AND at.order_id = ot.order_id
        AND ROWNUM = 1;

    -- Cursor para obtener los componentes asociados a un motivo
    CURSOR cuComponente (nucumotivos mo_motive.motive_id%TYPE)
    IS
		SELECT COUNT (1)
		FROM mo_component C
		WHERE c.package_id = nucumotivos;

    --INICIO CA 472
    nuPersonaLega           ge_person.person_id%TYPE
                                := pkg_bopersonal.fnugetpersonaid;
    nuLectura               NUMBER;
    nuCodigoAtrib           NUMBER
        := Dald_parameter.fnuGetNumeric_Value ('LDC_CODIATRLECTSUSPAD', NULL);
    sbNombreoAtrib          VARCHAR2 (100)
        := DALD_PARAMETER.FSBGETVALUE_CHAIN ('LDC_NOMBATRLECTSUSPAD', NULL);
    --FIN CA 472


	CURSOR cuDatosPro(inuProducto pr_product.product_id%TYPE) 
	IS
	SELECT di.address_parsed,
		   di.address_id,
		   di.geograp_location_id,
		   pr.category_id,
		   pr.subcategory_id,
		   pr.product_status_id
	FROM pr_product pr, ab_address di
	WHERE pr.product_id = inuProducto 
	AND pr.address_id = di.address_id;



BEGIN

	pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuorden := pkg_bcordenes.fnuobtenerotinstancialegal;
    nucausalorder := pkg_bcordenes.fnuobtienecausal(nuorden);
    -- Inicializamos el proceso
	
	pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);

	pkg_estaproc.prActualizaAvance(sbProceso,'OT:' || nuorden || '.En ejecucion',NULL,NULL);

    pkg_traza.trace ('Numero de la Orden:' || nuorden, pkg_traza.cnuNivelTrzDef);

    -- obtenemos el producto y el paquete
    OPEN cuproducto (nuorden);

    FETCH cuProducto
        INTO nuproductid,
             nucontratoid,
             nutasktypeid,
             nupakageid,
             nucliente,
             nuunidadoperativa,
             nuPersonaLega;

    IF cuProducto%NOTFOUND
    THEN
        sbmensa :=
               'Proceso termino con errores : '
            || 'El cursor cuProducto no arrojo datos con el # de orden'
            || TO_CHAR (nuorden);
		
		pkg_estaproc.prActualizaEstaproc(sbProceso,' Errores', sbmensa);
        pkg_error.setErrorMessage (ld_boconstans.cnugeneric_error,
                                          sbmensa);
        RAISE pkg_error.controlled_error;
    END IF;

    CLOSE cuproducto;

    pkg_traza.trace (
           'Salio cursor cuProducto, nuProductId: '
        || nuProductId
        || 'nuContratoId:'
        || 'nuTaskTypeId:'
        || nuTaskTypeId,
        pkg_traza.cnuNivelTrzDef);

    -- Obtenemos los datos de la solicitud de visita de verificacion para generar el tramite de defecto critico
    sbdireccionparseada := NULL;
    nudireccion := NULL;
    nulocalidad := NULL;
    nucategoria := NULL;
    nusubcategori := NULL;
    sw := 1;

    BEGIN
	
		IF cuDatosPro%ISOPEN THEN
			CLOSE cuDatosPro;
		END IF;
		
		
		OPEN cuDatosPro(nuproductid);
		FETCH cuDatosPro INTO sbdireccionparseada,nudireccion,nulocalidad,nucategoria,nusubcategori,nuEstadoPro;
		IF cuDatosPro%NOTFOUND THEN
			CLOSE cuDatosPro;
			RAISE NO_DATA_FOUND;
		END IF;
		CLOSE cuDatosPro;

    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            sw := 0;
    END;

    IF nuEstadoPro = 2
    THEN
        IF INSTR (
               DALD_PARAMETER.FSBGETVALUE_CHAIN (
                   'TITRCAUSL_REPADEFCRIT_SUSPACOM'),
               nuTaskTypeId || '|' || nucausalorder) >
           0
        THEN
            sw := 0;
        END IF;
    END IF;

    IF sw = 1
    THEN
        -- Construimos XML para generar el tramite

        sbcomment :=
               dald_parameter.fsbGetValue_Chain ('COMENTARIO_REPARACION_PRP')
            || ' AL LEGALIZAR ORDEN : '
            || TO_CHAR (nuorden)
            || ' CON CAUSAL : '
            || TO_CHAR (nucausalorder);
        numediorecepcion :=
            dald_parameter.fnuGetNumeric_Value (
                'MEDIO_RECEPCION_REPARACION_PRP');
        nuPackage_id := NULL;
        nuMotiveId := NULL;
        onuErrorCode := NULL;
        osbErrorMessage := NULL;
        dtfechasuspension := SYSDATE + 1 / 24 / 60;
        numeresuspadmin :=
            dald_parameter.fnuGetNumeric_Value (
                'MEDIO_RECEPCION_SUSPADM_PRP',
                NULL);
        inuSUSPENSION_TYPE_ID :=
            LDCI_PKREVISIONPERIODICAWEB.fnuTipoSuspension (nuproductid);

        nutipoCausal :=
            Dald_parameter.fnuGetNumeric_Value (
                'TIPO_CAUSAL_100013_SUSP_ACOME',
                NULL);

        IF nutipoCausal IS NULL
        THEN
            pkg_error.setErrorMessage (
                ld_boconstans.cnugeneric_error,
                'No existe datos para el parametro TIPO_CAUSAL_100013_SUSP_ACOME, definalos por el comando LDPAR');
            RAISE pkg_error.controlled_error;
        END IF;

        nuCausal :=
            Dald_parameter.fnuGetNumeric_Value ('CAUSAL_SUSP_ACOM_100013',
                                                NULL);

        IF nuCausal IS NULL
        THEN
            pkg_error.setErrorMessage (
                ld_boconstans.cnugeneric_error,
                'No existe datos para el parametro COD_CAUSA_SUSP_ADM_XML, definalos por el comando LDPAR');
            RAISE pkg_error.controlled_error;
        END IF;


		IF nuPersonaLega IS NULL
		THEN
			sbmensa :=
				'Proceso termino con errores : No se encontro persona que legaliza';
			pkg_error.setErrorMessage (
				ld_boconstans.cnugeneric_error,
				sbmensa);
		END IF;

		nuLectura :=
			ldc_boordenes.fsbDatoAdicTmpOrden (nuorden,
											   nuCodigoAtrib,
											   TRIM (sbNombreoAtrib));

		IF nuLectura IS NULL
		THEN
			sbmensa :=
				   'Proceso termino con errores : '
				|| 'No se ha digitado Lectura';
			pkg_error.setErrorMessage (
				ld_boconstans.cnugeneric_error,
				sbmensa);
		END IF;

		sbcomment :=
			   '[GENERACION PLUGIN]| LEGALIZACION ORDEN['
			|| nuorden
			|| ']|LECTURA['
			|| nuLectura
			|| ']|PERSONA['
			|| nuPersonaLega
			|| ']|  CON CAUSAL : '
			|| TO_CHAR (nucausalorder);

		nuPackage_id :=
			LDC_PKGESTIONCASURP.fnuGeneTramSuspRP (nuproductid,
												   numeresuspadmin,
												   nutipoCausal,
												   nuCausal,
												   inuSUSPENSION_TYPE_ID,
												   sbcomment,
												   onuErrorCode,
												   osbErrorMessage);

		IF nuPackage_id IS NOT NULL
		THEN
			INSERT INTO LDC_BLOQ_LEGA_SOLICITUD (PACKAGE_ID_ORIG,
												 PACKAGE_ID_GENE)
				 VALUES (nupakageid, nuPackage_id);
		END IF;

        IF nuPackage_id IS NULL
        THEN
            sbmensa :=
                   'OT:'
                || nuorden
                || '.Proceso termino con errores : '
                || 'Error al generar la solicitud de suspension administrativa x xml. Codigo error : '
                || TO_CHAR (onuErrorCode)
                || ' Mensaje de error : '
                || osbErrorMessage;
				
			pkg_estaproc.prActualizaEstaproc(sbProceso,' Errores',sbmensa);
				
            pkg_error.setErrorMessage (ld_boconstans.cnugeneric_error,
                                              sbmensa);
            RAISE pkg_error.controlled_error;
        ELSE
            sbflag :=
                ldc_fsbretornaaplicaasigauto (nutasktypeid, nucausalorder);

            IF NVL (sbflag, 'N') = 'S'
            THEN
                ldc_procrearegasiunioprevper (nuunidadoperativa,
                                              nuproductid,
                                              nutasktypeid,
                                              nuorden,
                                              nuPackage_id);
            END IF;

            -- Dejamos la solicitud como estaba
            UPDATE mo_packages m
               SET m.motive_status_id = 13
             WHERE m.package_id = nupakageid;

            sbmensa :=
                   'OT:'
                || nuorden
                || '.Proceso termino Ok. Se genero la solicitud Nro : '
                || TO_CHAR (nuPackage_id);
			
			pkg_estaproc.prActualizaEstaproc(sbProceso,' Ok',sbmensa);
			
        END IF;
    ELSE
        IF sw <> 0
        THEN
            sbmensa :=
                   'OT:'
                || nuorden
                || '.Proceso termino con errores : '
                || 'No se encontraron datos de la solicitud asociada a la orden # '
                || TO_CHAR (nuorden);
				
			pkg_estaproc.prActualizaEstaproc(sbProceso,' Errores',sbmensa);
			
            pkg_error.setErrorMessage (ld_boconstans.cnugeneric_error,
                                              sbmensa);
            RAISE pkg_error.controlled_error;
        END IF;
    END IF;

	pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);

EXCEPTION
    WHEN pkg_error.controlled_error THEN
        pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
        RAISE;
    WHEN OTHERS THEN
        pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
        sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
		pkg_estaproc.prActualizaEstaproc(sbProceso,' Errores',sbmensa);
        pkg_error.setError;
        RAISE pkg_error.controlled_error;
END LDC_CREATRAMITESUSPACOMET;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CREATRAMITESUSPACOMET', 'ADM_PERSON');
END;
/
