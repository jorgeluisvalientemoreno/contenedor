CREATE OR REPLACE PROCEDURE ADM_PERSON.LDCCREATETRAMITERECONEXIONXML
(
  inuCertiOia LDC_CERTIFICADOS_OIA.CERTIFICADOS_OIA_ID%type,
  IsbStatus   LDC_CERTIFICADOS_OIA.STATUS_CERTIFICADO%type
) 
IS
 
  /*******************************************************************************
      <Procedure Fuente="Propiedad Intelectual de Gases del Caribe S.A">
      <Unidad> LDCCREATETRAMITERECONEXIONXML </Unidad>
      <Autor> DANVAL </Autor>
      <Fecha> 06-Octubre-2021 </Fecha>
      <Descripcion>
          Procedimiento encargado de registrar una solicitud de reconexión
      </Descripcion>
      <Historial>
          <Modificacion Autor="" Fecha="" Inc="">
            Creación
          </Modificacion>  
          <Modificacion Autor="DANVAL" Fecha="06/10/2021" Inc="C 717_1">
            Se agrega registro en tablas de control para impedir que se procesen los productos
          </Modificacion>      
          <Modificacion Autor="lvalencia" Fecha="27/10/2022" Inc="OSF-638">
              Se modifica para realizar el llamdo al procedimiento LDCVALPRODUCTTRAMITERECO
              el cual realiza validaciones antes de intentar registrar la solicitud de
              reconexión.
          </Modificacion>
          <Modificacion Autor="Jsoto" Fecha="22/11/2023" Inc="OSF-1861">
			-Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
			-Ajuste  cambio en manejo de trazas y errores por personalizados (pkg_error y pkg_traza).
			-Ajuste llamado a pkg_xml_sol_seguros para armar los xml de las solicitudes
			-Ajuste llamado a api_registerRequestByXml
			-Ajuste llamado a api_createorder para crear ordenes y actividades
			-Se suprimen llamado a "AplicaEntrega" que no se encuentren activos
			-Se cambia ldc_sendmail por ldc_email
          </Modificacion>
          <Modificacion Autor="Adrianavg" Fecha="19/04/2024" Inc="OSF-2569">
              Se migra del esquema OPEN al esquema ADM_PERSON
          </Modificacion>
          <Modificacion Autor="jpinedc" Fecha="17/05/2024" Inc="OSF-2581">
              * Se reemplaza ldc_sendemailpor pkg_Correo.prcEnviaCorreo
              * Ajustes por estandares
          </Modificacion>  
      </Historial>
      </Procedure>
  *******************************************************************************/                          
  sbStatus_certi        LDC_CERTIFICADOS_OIA.STATUS_CERTIFICADO%TYPE;
  nuCERTIFICADOS_OIA_ID LDC_CERTIFICADOS_OIA.CERTIFICADOS_OIA_ID%TYPE;
  nuID_ORGANISMO_OIA    LDC_CERTIFICADOS_OIA.ID_ORGANISMO_OIA%TYPE;
  nuResulInsp           LDC_CERTIFICADOS_OIA.RESULTADO_INSPECCION%type;
  nuProductId           pr_product.product_id%type;
  nucliente             ge_subscriber.subscriber_id%TYPE;
  nuContratoId          NUMBER;
  nudireccion           ab_address.address_id%TYPE;
  nulocalidad           ab_address.geograp_location_id%TYPE;
  nucategoria           mo_motive.category_id%TYPE;
  nusubcategori         mo_motive.subcategory_id%TYPE;
  sbmensa               VARCHAR2(10000);
  sw                    NUMBER(2) DEFAULT 0;
  nucont                NUMBER(4);

  onuErrorCode    number;
  osbErrorMessage varchar2(2000);

  nuPackageId         mo_packages.package_id%type;
  nuMotiveId          mo_motive.motive_id%type;
  nuErrorCode         NUMBER;
  sbErrorMessage      VARCHAR2(4000);
  sbComment           VARCHAR2(2000);
  numediorecepcion    mo_packages.reception_type_id%TYPE;
  sbrequestxml1       constants_per.tipo_xml_sol%type;
  sbdireccionparseada ab_address.address_parsed%TYPE;

  rcComponent    damo_component.stymo_component;
  rcmo_comp_link damo_comp_link.stymo_comp_link;
  nucomppadre    mo_component.component_id%TYPE;
  nunumber       NUMBER(4) DEFAULT 0;
  nuprodmotive   mo_component.prod_motive_comp_id%TYPE;
  sbtagname      mo_component.tag_name%TYPE;
  nuclasserv     mo_component.class_service_id%TYPE;
  
  -- Cursor para obtener los componentes asociados a un motivo
  CURSOR cuComponente(nucumotivos mo_motive.motive_id%TYPE) IS
    SELECT COUNT(1) FROM mo_component C WHERE c.package_id = nucumotivos;

  CURSOR cuSubscriber(nID_contrato NUMBER) IS
    select SUSCCLIE from SUSCRIPC where SUSCCODI = nID_contrato;

  CURSOR cuCertificadosOIA(nuCertificado LDC_CERTIFICADOS_OIA.certificados_oia_id%TYPE) IS
    SELECT id_contrato, ID_PRODUCTO, id_organismo_oia, RESULTADO_INSPECCION
      FROM LDC_CERTIFICADOS_OIA
     WHERE certificados_oia_id = nuCertificado;

  -- Cursor para validar existencia de valores en parametros separados por coma
  CURSOR cu_Parameter(inuvalor    NUMBER,
                      sbParameter ld_parameter.parameter_id%TYPE) IS
    SELECT COUNT(1) CANTIDAD
      FROM DUAL
     WHERE inuvalor IN
						(SELECT regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena(sbParameter), '[^,]+', 1, LEVEL)AS tipotrab
							FROM dual
							CONNECT BY regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena(sbParameter), '[^,]+', 1, LEVEL) IS NOT NULL);

  nuExistParameter NUMBER := 0;

  CURSOR cu_ISUnitOperExter(nID_uniOper NUMBER) is
    SELECT COUNT(1)
      FROM OR_OPERATING_UNIT U
     WHERE U.OPERATING_UNIT_ID IN (nID_uniOper)
       AND U.CONTRACTOR_ID IS NULL
       AND U.OPERATING_UNIT_ID NOT IN (-1, 1);
	   

	CURSOR cuSuspActivas(inuProducto pr_product.product_id%TYPE)IS
	  SELECT COUNT(1)
		FROM PR_PRODUCT P, pr_prod_suspension PS
	   WHERE P.PRODUCT_ID = PS.PRODUCT_ID
		 AND P.PRODUCT_STATUS_ID = 2
		 AND P.PRODUCT_ID = inuProducto
		 AND PS.ACTIVE = 'Y'
		 AND PS.SUSPENSION_TYPE_ID IN (101, 102, 103, 104);
		 
	CURSOR cuDatosUbicacion(inuproductid pr_product.product_id%TYPE) IS
		SELECT di.address_parsed,
			   di.address_id,
			   di.geograp_location_id,
			   pr.category_id,
			   pr.subcategory_id
		  FROM pr_product pr, ab_address di
		 WHERE pr.product_id = inuproductid
		   AND pr.address_id = di.address_id;
		   

  nUnitOperExter          number default 0;
  contProdStatusSuspActiv number default 0;
  
  csbMetodo  			  CONSTANT VARCHAR2(100) := 'LDCCREATETRAMITERECONEXIONXML';
  sbproceso  			  VARCHAR2(100) := 'LDCCREATETRAMITERECONEXIONXML'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

  -----------------------------------------
  -- OSF-638: Variables utilizadas para  --
  -- envio de correo electronico.        --
  -----------------------------------------
  sbRemitente        	VARCHAR2(4000) := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
  sbRecipients      VARCHAR2(2000);
  sbSubject         VARCHAR2(4000);
  sbMessage         VARCHAR2(32672);
  nuContinueReco    NUMBER;

BEGIN

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

  sbStatus_certi        := IsbStatus;
  nuCERTIFICADOS_OIA_ID := inuCertiOia;

  -----------------------------------------
  -- OSF-638: Se inicializan variable de --
  -- envio de correo electronico.        --
  -----------------------------------------
  
  sbRecipients := daldc_pararepe.fsbGetParavast('LDC_MAIL_CAMBIO_TIPOSUSP',NULL);
  sbSubject := 'Error al generar el trámite de reconexión por certificación por terceros';

  IF pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_PAR_IF_TRAMITA_RECONEXION') = 'S' THEN
    --Obtiene los datos del resultado de inspeccion
    OPEN cuCertificadosOIA(nuCERTIFICADOS_OIA_ID);
    FETCH cuCertificadosOIA
    INTO nuContratoId, nuProductId, nuID_ORGANISMO_OIA, nuResulInsp;
    CLOSE cuCertificadosOIA;
  
    --Ejecutar el proceso solo si el certificado oia está aprobado.
    /*Observacion.2001572
    Se agrega validacion para realizar el proceso, solo si el resultado de inspeccion es
    instalacion certificada e instalacion certificada parcial*/
    OPEN cu_Parameter(nuResulInsp, 'COD_RESUL_INSPEC_OIA');
    FETCH cu_Parameter
      INTO nuExistParameter;
    IF cu_Parameter%NOTFOUND THEN
      nuExistParameter := 0;
    END IF;
    CLOSE cu_Parameter;

      pkg_traza.trace('nuID_ORGANISMO_OIA|'|| nuID_ORGANISMO_OIA);
  
    OPEN cu_ISUnitOperExter(nuID_ORGANISMO_OIA);
    FETCH cu_ISUnitOperExter
      INTO nUnitOperExter;
    IF cu_ISUnitOperExter%NOTFOUND THEN
      nUnitOperExter := 0;
    END IF;
    CLOSE cu_ISUnitOperExter;
  
    pkg_traza.trace('ANTES IF sbStatus_certi = A AND nuExistParameter <> 0 then');
    IF sbStatus_certi = 'A' AND nuExistParameter <> 0 then
      pkg_traza.trace('ANTES UT EXTERNO ');
    
	pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);

      pkg_traza.trace('nUnitOperExter|'|| nUnitOperExter);


	--si unidada de trabajo es externa
      IF nUnitOperExter > 0 THEN
      
        pkg_traza.trace('INGRESO 1');
        BEGIN
		
			IF cuSuspActivas%ISOPEN THEN
				CLOSE cuSuspActivas;
			END IF;
			
			OPEN cuSuspActivas(nuProductId);
			FETCH cuSuspActivas INTO contProdStatusSuspActiv;
			IF cuSuspActivas%NOTFOUND THEN
				CLOSE cuSuspActivas;
				RAISE NO_DATA_FOUND;
			END IF;
			CLOSE cuSuspActivas;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            contProdStatusSuspActiv := 0;
          WHEN OTHERS THEN
            contProdStatusSuspActiv := 0;
        END;
      
        IF contProdStatusSuspActiv > 0 THEN
          OPEN cuSubscriber(nucontratoid);
          FETCH cuSubscriber INTO nucliente;
          IF cuSubscriber%NOTFOUND THEN
            sbmensa := 'Proceso termino con errores : ' ||
                       'El cursor cuSubscriber no arrojo datos';
			pkg_estaproc.prActualizaEstaproc(sbproceso,' Con Errores',sbmensa);
            pkg_error.setErrorMessage(ld_boconstans.cnugeneric_error,
                                             sbmensa);
          END IF;
          CLOSE cuSubscriber;
          -- Obtenemos los datos de la solicitud de visita de verificacion para generar el tramite de defecto critico
          sbdireccionparseada := NULL;
          nudireccion         := NULL;
          nulocalidad         := NULL;
          nucategoria         := NULL;
          nusubcategori       := NULL;
          sw                  := 1;
          BEGIN
		  
			IF cuDatosUbicacion%ISOPEN then
				CLOSE cuDatosUbicacion;
			END IF;
			
			OPEN cuDatosUbicacion(nuProductId);
			FETCH cuDatosUbicacion INTO sbdireccionparseada,nudireccion,nulocalidad,nucategoria,nusubcategori;
			IF cuDatosUbicacion%NOTFOUND then
				CLOSE cuDatosUbicacion;
				RAISE NO_DATA_FOUND;
			END IF;
			CLOSE cuDatosUbicacion;

          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              sw := 0;
          END;
          IF sw = 1 THEN
            pkg_traza.trace('INGRESO 2');

            -----------------------------------------
            -- OSF-638: Validaciones antes de crear--
            -- el tramite de reconexión.           --
            -----------------------------------------
            nuContinueReco := 0;
            BEGIN
              ldcValproducttramitereco(nuProductId);
            EXCEPTION
              WHEN pkg_error.controlled_error THEN
                nuContinueReco := 1;
                RAISE pkg_error.controlled_error;
              WHEN others THEN
                nuContinueReco := 1;
                RAISE;
            END;

            -- OSF-638: Se agrega if validación de reconexión
            IF nuContinueReco = 0 THEN
              -- Construimos el XML para generar la orden de reconexión sin certificación
              sbcomment        := 'Se genera Orden de reconexcion por instalacion certificada por OIA externo';
              numediorecepcion := pkg_BCLD_Parameter.fnuObtieneValorNumerico('MEDIO_RECEPCION_RECO_SIN_CERT');
			  sbrequestxml1	   := pkg_xml_soli_rev_periodica.getXMSolicitudReconexionRp(numediorecepcion,
                                                                                       sbcomment,
                                                                                       nuproductid,
                                                                                       nucliente,
                                                                                       -1 ); --TipoSuspension
          
              pkg_traza.trace(sbrequestxml1);
              api_registerRequestByXml(sbrequestxml1,
                                      nupackageid,
                                      numotiveid,
                                      nuerrorcode,
                                      sberrormessage);
          
              pkg_traza.trace('despues de xml nupackageid:' ||
                                 nupackageid || ' numotiveid:' ||
                                 numotiveid || ' nuerrorcode:' ||
                                 nuerrorcode || ' sberrormessage:' ||
                                 sberrormessage);
          
              IF nupackageid IS NULL THEN
                sbmensa := 'Proceso termino con errores : ' ||
                         'Error al generar la solicitud. Codigo error : ' ||
                         to_char(nuerrorcode) || ' Mensaje de error : ' ||
                         sberrormessage;
				pkg_estaproc.prActualizaEstaproc(sbproceso,' Con Error',sbmensa );
                pkg_error.setErrorMessage(ld_boconstans.cnugeneric_error,
                                               sbmensa);
              ELSE
				sbmensa := 'Proceso termino Ok. Se genero la solicitud Nro : ' ||
						 to_char(nupackageid);
				pkg_traza.trace(sbmensa);
					--CA 717_1
				  --registro en LD_PRODAPPLYSUSPEND
				  UPDATE LD_PRODAPPLYSUSPEND
				  SET PROC_RECONEX='A',
				  PROC_RESPONSE='PROCESO ANULADO POR CERTIFICADO DE OIA EXTERNO',
				  PROC_DATE=SYSDATE
				  WHERE PRODUCT_ID=nuproductid
				  AND PROC_RECONEX='N';
				
				  UPDATE PROD_NEGDEUDA_RP
				  SET PROCESADO='A',
				  FECHA_PROCESO=SYSDATE,
				  ERROR='PROCESO ANULADO POR CERTIFICADO DE OIA EXTERNO'
				  WHERE PRODUCT_ID=nuproductid
				  AND PROCESADO='N';
                --
              END IF;
              -- Consultamos si el motivo generado tiene asociado los componentes
              OPEN cuComponente(numotiveid);
              FETCH cuComponente INTO nucont;
              CLOSE cuComponente;

              -- Si el motivo no tine los componentes asociados, se procede a registrarlos
              pkg_traza.trace('antes IF (nucont=0)THEN');
              IF (nucont = 0) THEN
                FOR i IN (SELECT kl.*,
                               mk.package_id     solicitud,
                               mk.subcategory_id subcategoria
                          FROM mo_motive mk, pr_component kl
                         WHERE mk.motive_id = numotiveid
                           AND kl.component_status_id <> 9
                           AND mk.product_id = kl.product_id
                         ORDER BY kl.component_type_id) 
                LOOP
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
                  pkg_traza.trace('antes rcComponent.component_id ');
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
                  rcComponent.category_id          := i.category_id;
                  rcComponent.subcategory_id       := i.subcategoria;
                  damo_component.Insrecord(rcComponent);
                  pkg_traza.trace('antes IF i.component_type_id');
                  IF i.component_type_id = 7038 THEN
                    nucomppadre := rcComponent.component_id;
                  END IF;
                  IF (nuMotiveId IS NOT NULL) THEN
                    pkg_traza.trace('despues IF(nuMotiveId IS NOT NULL)THEN');
                    rcmo_comp_link.child_component_id := rcComponent.component_id;
                    IF i.component_type_id = 7039 THEN
                      rcmo_comp_link.father_component_id := nucomppadre;
                    ELSE
                      rcmo_comp_link.father_component_id := NULL;
                    END IF;
                    rcmo_comp_link.motive_id := nuMotiveId;
                    damo_comp_link.insrecord(rcmo_comp_link);
                    pkg_traza.trace('despues damo_comp_link.insrecord(rcmo_comp_link);');
                  END IF;
                END LOOP;
              END IF;
            END IF;
          ELSE
            sbmensa := 'Proceso termino con errores : ' ||
                       'No se encontraron datos de la solicitud ';
			pkg_estaproc.prActualizaEstaproc(sbproceso,' Con Errores',sbmensa);
            pkg_error.setErrorMessage(ld_boconstans.cnugeneric_error,
                                             sbmensa);
          END IF;
          pkg_traza.trace('FIN BIEN');
        END IF;
		  pkg_estaproc.prActualizaEstaproc(sbproceso,' Ok','Finaliza');
      END IF;
    END IF;
  
  END IF; 
  
  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
  WHEN pkg_error.controlled_error THEN
    pkg_error.getError(onuErrorCode, osbErrorMessage);
    sbMessage := sbMessage||'Producto: '||nuProductId||chr(13);
    sbMessage := sbMessage||'Error: '||onuErrorCode||'-'||osbErrorMessage;
	pkg_traza.trace(csbMetodo||' '||sbMessage); 
    pkg_Correo.prcEnviaCorreo
    (
        isbRemitente        => sbRemitente,
        isbDestinatarios    => sbRecipients,
        isbAsunto           => sbSubject,
        isbMensaje          => sbMessage
    );
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
  WHEN others THEN
    pkg_error.setError;
    pkg_error.getError(onuErrorCode, osbErrorMessage);
    sbMessage := sbMessage||'Producto: '||nuProductId||chr(13);
    sbMessage := sbMessage||'Error: '||onuErrorCode||'-'||osbErrorMessage;
    pkg_traza.trace(csbMetodo||' '||sbMessage);
    pkg_Correo.prcEnviaCorreo
    (
        isbRemitente        => sbRemitente,
        isbDestinatarios    => sbRecipients,
        isbAsunto           => sbSubject,
        isbMensaje          => sbMessage
    );	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
END LDCCREATETRAMITERECONEXIONXML;
/
