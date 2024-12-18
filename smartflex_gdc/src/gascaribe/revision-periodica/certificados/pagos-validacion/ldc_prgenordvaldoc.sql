CREATE OR REPLACE PROCEDURE LDC_PRGENORDVALDOC IS

	/*****************************************************************
	Propiedad intelectual de Gases del Caribe.
	Nombre del Servicio: LDC_PRUODEFECTO
	Descripcion: job para generar orden de validacion docuemntal al producto cunaod se rechace o se apruebe un certificado OIA

	Autor    : HORBATH
	caso	 : 371
	Fecha    : 27/07/2020

	Historia de Modificaciones

	DD-MM-YYYY    	<Autor>.            Modificacion
	-----------  	--------------   	-------------------------------------
	21/07/2023		jerazomvm			CASO OSF-1261:
										1. Se reemplaza el llamado del API os_legalizeorders
										   por el API api_legalizeorders.
										2. Se reemplaza el manejo de errores ex y errors por Pkg_error.
										3. Se elimina la funcion fblAplicaEntregaxCaso, para la entrega la cual retorna true.
										4. Se reemplaza el API OS_ASSIGN_ORDER por el API API_ASSIGN_ORDER
										5. Se reemplaza el llamado del método or_boorderactivities.createactivity,
										   por el API api_createorder.
	06/09/2023		jerazomvm			Caso OSF-1542: Se envia comentario en el API api_createorder.
	26/09/2024		dsaltarin			OSF-3369: Se cambia la dirección de generación de la orden, ya no se genera con la 
										dirección del producto sino con una dirección genérica configurada en un parametro.
	******************************************************************/  

	CURSOR cu_certificado IS
		SELECT  ge.certificados_oia_id,
				c.id_producto,
				c.fecha_aprobacion,
				c.tipo_inspeccion
		FROM  ldc_genordvaldocu ge 
		INNER JOIN ldc_certificados_oia c ON c.certificados_oia_id=ge.certificados_oia_id  
		WHERE ge.ESTADO='P'; 

	CURSOR cudatos(idProducto 	ldc_certificados_oia.id_producto%TYPE) IS
		SELECT	p.subscription_id,
				sc.suscclie subscriber_id
		FROM pr_product p
		INNER JOIN suscripc sc ON sc.susccodi=p.subscription_id
		WHERE p.product_id = idProducto;
		


		nuActValidaDocumental       ldc_pararepe.parevanu%TYPE := PKG_BCLDC_PARAREPE.FNUOBTIENEVALORNUMERICO('ACT_VAL_DOCUMENTAL');
		nuUnidadOperativa 			ldc_pararepe.parevanu%TYPE := PKG_BCLDC_PARAREPE.FNUOBTIENEVALORNUMERICO('OPER_UNIT_VAL_DOCUMENTAL');
		nuCausalLegalizacion  		ldc_pararepe.parevanu%TYPE := PKG_BCLDC_PARAREPE.FNUOBTIENEVALORNUMERICO('CAU_LEGA_VAL_DOCUMENTAL');
		nom_dato_adicinal          	ldc_pararepe.paravast%TYPE := PKG_BCLDC_PARAREPE.FSBOBTIENEVALORCADENA('DATO_ADI_VAL_DOCUMENTAL');
		nupersonalegaliza          	ld_parameter.numeric_value%TYPE := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('PERID_GEN_CIOR');
		nuAddressId					ab_address.address_id%TYPE := PKG_PARAMETROS.FNUGETVALORNUMERICO('DIRECCION_GENERICA_BARRANQUILLA');
		

		nuProductId                pr_product.product_id%TYPE;
		nuSubscriptionId           pr_product.subscription_id%TYPE;
		nuSuscclie                 suscripc.suscclie%TYPE;
		nuOperatingSectorId        ab_segments.segments_id%TYPE;
		nuOrderActivity_id         or_order_activity.activity_id%TYPE;
		nuOrderId                  or_order.order_id%TYPE;
		nuCertificado              ldc_genordvaldocu.certificados_oia_id%TYPE;
		osbErrorMessage            ge_error_log.description%TYPE;
		onuErrorCode               ge_error_log.error_log_id%TYPE;
		sbDatoAdicional            VARCHAR2(1000);
		sbCadenaLegacion           VARCHAR2(1000);
		ex_error                   EXCEPTION;
		--PE-321
		
		---Creas la estructura de la tabla en memoria
		TYPE tbActxTiins IS RECORD(nuTipoIns  number,
								nuActividad ge_items.items_id%type);
		TYPE tytbActxTiins IS TABLE OF tbActxTiins INDEX BY BINARY_INTEGER;
		tbActixTiins tytbActxTiins;

		CURSOR 	cuActividadXtipoInspecion IS
		SELECT CODIGO, ACTIVIDAD_VALIDACION
		FROM LDC_RESUINSP;

		-- Constantes para el control de la traza
		csbMetodo      CONSTANT VARCHAR2(32)	:= $$PLSQL_UNIT||'.'; --Constante nombre método
		csbNivelTraza  CONSTANT NUMBER(2)		:= pkg_traza.cnuNivelTrzDef; 		
		sbProceso   	VARCHAR2(100)			:= csbMetodo||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

		PROCEDURE PROACTAUT_dc_genordvaldocu(
											numecerti 	ldc_certificados_oia.certificados_oia_id%TYPE, 
											mensaje     ldc_genordvaldocu.OBSERVACION%TYPE,
											nuestado      ldc_genordvaldocu.ESTADO%TYPE,
											nuOrden	    ldc_genordvaldocu.order_id%TYPE
											) IS
			PRAGMA AUTONOMOUS_TRANSACTION;
			
		BEGIN
			UPDATE ldc_genordvaldocu 
			SET observacion=mensaje,
				estado=nuestado,
				order_id=nuOrden
			WHERE certificados_oia_id=numecerti;
			COMMIT;

		END;

BEGIN   
	pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
	pkg_estaproc.prinsertaestaproc(sbProceso,NULL); 
	
	IF (cuActividadXtipoInspecion%ISOPEN) THEN
		CLOSE cuActividadXtipoInspecion;
	END IF;

	FOR reg IN cuActividadXtipoInspecion LOOP
		tbActixTiins(reg.codigo).nuTipoIns:=reg.codigo;
		tbActixTiins(reg.codigo).nuActividad:=reg.actividad_validacion;
	END LOOP;
		
	IF (cu_certificado%ISOPEN) THEN
		CLOSE cu_certificado;
	END IF;	
	
	IF nuAddressId is  null THEN
		osbErrorMessage :='No se ha configurado dirección para crear ordenes, configurar parámetro : DIRECCION_GENERICA_BARRANQUILLA';
		pkg_Error.setErrorMessage(isbMsgErrr=>osbErrorMessage);
	END IF;

	pkg_traza.trace('nuAddressId: ' || nuAddressId, csbNivelTraza);
	
	IF nuUnidadOperativa is null OR nuUnidadOperativa <= 0 then 
		osbErrorMessage:='La unidad operativa para asignar la orden no es valida';                          
		pkg_Error.setErrorMessage(isbMsgErrr=>osbErrorMessage);
	END IF;
	pkg_traza.trace('nuUnidadOperativa: ' || nuUnidadOperativa, csbNivelTraza);
	
	FOR c in cu_certificado LOOP
		pkg_traza.trace('certificados_oia_id: ' || c.certificados_oia_id, csbNivelTraza);
		nuActValidaDocumental		:=null;
		nuProductId					:=c.id_producto;
		nuSubscriptionId			:=null;
		nuSuscclie					:=null;
		nuOperatingSectorId			:=null;
		nuOrderActivity_id			:=null;
		nuOrderId					:=null;
		osbErrorMessage				:=null;
		onuErrorCode				:=null;
		sbDatoAdicional				:=null;
		sbCadenaLegacion			:=null;
		nuCertificado				:= c.certificados_oia_id;

		BEGIN
			
			IF (cudatos%ISOPEN) THEN
				CLOSE cudatos;
			END IF;	

			OPEN cudatos(c.id_producto);
			FETCH cudatos INTO nuSubscriptionId,nuSuscclie;
			CLOSE cudatos;                  
			
			pkg_traza.trace('nuProductId: ' || nuProductId, csbNivelTraza);
			pkg_traza.trace('nuSubscriptionId: ' || nuSubscriptionId, csbNivelTraza);
			pkg_traza.trace('nuSuscclie: ' || nuSuscclie, csbNivelTraza);


			nuCertificado := c.certificados_oia_id;
			--Validaciones
			--Se valida que exista actividad configurada para el tipo de inspeccion
			BEGIN
				nuActValidaDocumental := tbActixTiins(c.tipo_inspeccion).nuActividad;
			EXCEPTION
				WHEN no_data_found THEN
					nuActValidaDocumental:=null;
			end;
			IF nuActValidaDocumental IS NULL THEN
				osbErrorMessage :='No se encontro actividad para el tipo de inspección del certificado';
				RAISE ex_error;
			END IF;
			pkg_traza.trace('nuActValidaDocumental: ' || nuActValidaDocumental, csbNivelTraza);
			
			
			api_createorder(nuActValidaDocumental,
							NULL,
							NULL,
							NULL,
							NULL,
							nuAddressId,
							NULL,
							nuSuscclie,
							nuSubscriptionId,
							nuProductId,
							NULL,
							NULL,
							or_boconstants.cnuprocess_manual_charges,
							'Orden generada por el proceso LDC_PRGENORDVALDOC',
							FALSE,
							NULL,
							NULL,
							ge_boconstants.csbyes,
							NULL,
							NULL,
							NULL,
							0,
							NULL,
							TRUE,
							NULL,
							NULL,
							nuOrderId,
							nuOrderActivity_id,
							onuErrorCode,
							osbErrorMessage
							);

			IF nuOrderId IS NULL OR nuOrderId=0 THEN -- NO FUE EXITOSA LA CREACION DE LA ORDEN                   
				osbErrorMessage :='Error al generar la orden: '||osbErrorMessage;
				RAISE ex_error;

			ELSE -- fue exitosa la creacion de la orden
			-- asigna orden

					

				pkg_traza.trace('Orden generada : ' || nuOrderId, csbNivelTraza);

				api_assign_order(nuOrderId, nuUnidadOperativa, onuErrorCode, osbErrorMessage);

				pkg_traza.trace('api_assign_order :  ' || osbErrorMessage, csbNivelTraza);

				IF nvl(onuErrorCode,0) != 0 THEN  -- no pudo asignar la orden	          
					RAISE ex_error;
				ELSE -- si pudo asignar la orden
					-- legaliza la orden
					IF nom_dato_adicinal is not null THEN
						sbDatoAdicional:= nom_dato_adicinal||'='||to_char(c.certificados_oia_id);
					ELSE
						sbDatoAdicional :=NULL;
					END IF;
					pkg_traza.trace('sbDatoAdicional :  ' || sbDatoAdicional, csbNivelTraza);
					
					sbCadenaLegacion:=nuOrderId||'|'||nuCausalLegalizacion||'|'||nupersonalegaliza||'|'||sbDatoAdicional||'|'||nuOrderActivity_id||'>1;;;;|||1;'||'Generada por validacion de certificado';


					pkg_traza.trace('sbCadenaLegacion :  ' || sbCadenaLegacion, csbNivelTraza);
					pkg_traza.trace('fecha inicial :  ' || c.fecha_aprobacion, csbNivelTraza);
					pkg_traza.trace('fecha final :  ' || c.fecha_aprobacion, csbNivelTraza);

					api_legalizeorders(sbCadenaLegacion, c.fecha_aprobacion, c.fecha_aprobacion, SYSDATE, onuErrorCode, osbErrorMessage );

					pkg_traza.trace('api_legalizeorders :  ' || osbErrorMessage, csbNivelTraza);

					IF nvl(onuErrorCode,0) != 0 THEN 
						osbErrorMessage := 'No se pudo legalizar la orden: '||osbErrorMessage;                             
						RAISE ex_error;
					ELSE
						PROACTAUT_dc_genordvaldocu(C.certificados_oia_id,'Atendido exitosamente y se genero la orden # '||to_char(nuOrderId),'A', nuOrderId);                             
						COMMIT;
					END IF;
				END IF;
			END IF;
		EXCEPTION 
			WHEN ex_error THEN                
				ROLLBACK;
				PROACTAUT_dc_genordvaldocu(C.certificados_oia_id,substr(osbErrorMessage,1,200),'P', null);
			WHEN others THEN    
				ROLLBACK;
				Pkg_error.setError;
				Pkg_error.getError(onuErrorCode, osbErrorMessage);
				PROACTAUT_dc_genordvaldocu(C.certificados_oia_id,substr(osbErrorMessage,1,200),'P', null);			 
		END;
	END LOOP; 

	pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);    
	pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,isbEstado      => 'OK',isbObservacion => 'Proceso terminó correctamente');
EXCEPTION
  WHEN PKG_ERROR.CONTROLLED_ERROR  THEN
		pkg_error.geterror(onuErrorCode, osbErrorMessage);
		pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
											isbEstado      => 'Error',
											isbObservacion => osbErrorMessage
											); 
		pkg_traza.trace('onuErrorCode:'||onuErrorCode||'-'||osbErrorMessage,pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
  WHEN OTHERS  THEN
		pkg_error.seterror;
		pkg_error.geterror(onuErrorCode, osbErrorMessage);
		pkg_estaproc.prActualizaEstaproc(isbProceso     => sbProceso,
											isbEstado      => 'Error',
											isbObservacion => osbErrorMessage
										);    
		pkg_traza.trace('onuErrorCode:'||onuErrorCode||'-'||osbErrorMessage,pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);										
END LDC_PRGENORDVALDOC;
/
grant execute on LDC_PRGENORDVALDOC to SYSTEM_OBJ_PRIVS_ROLE;
/