CREATE OR REPLACE PROCEDURE PERSONALIZACIONES.prc_generasolisuspenacom(inuordenId IN or_order.order_id%TYPE)
IS

	/*****************************************************************
	Unidad         : prc_generasolisuspenacom
	Descripcion    : Genera solicitud 100328 - Suspension por calidad de medicion, con el item
					 100009280 - CLM - SUSPENSION DESDE ACOMETIDA_POR NO CAMBIO DE MEDIDOR EN MAL ESTADO
					
	Autor          : Jhon Erazo
	Fecha          : 30-01-2024

	Parametros            Descripcion
	============        	===================
	inuInstancia_id			Identificador de la instancia

	Historia de Modificaciones

	DD-MM-YYYY    <Autor>           Modificacion
	-----------  ---------------	-------------------------------------
	30-01-2024   jerazomvm        	OSF-2199: Creación.
	******************************************************************/
  
	--<<
	-- Variables del proceso
	-- Constantes para el control de la traza
	csbSP_NAME 	CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT;
	cnuNVLTRC 	CONSTANT NUMBER 		:= pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;
	
	nuCodError			NUMBER;
    nuContactId     	NUMBER;
	nuProducto       	NUMBER;
	nuPackageId      	mo_packages.package_id%TYPE;
    nuMotiveId       	mo_motive.motive_id%TYPE;
	nuRecepcion         ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('PAR_RECEPTYPEID_CDM', NULL);
	nuTiposuspen      	ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('PAR_TIPOSUSP_CDM', NULL);
	nuTipoCausal      	ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('PAR_TC_SUSP_CDM', NULL);
	nuCausal          	ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('PAR_C_SUSP_ACO_XNCAMMED', NULL);
	sbErrorMessage  	VARCHAR2(4000);	
	sbRequestXML      	constants_per.tipo_xml_sol%TYPE;
	sbcomentario     	VARCHAR2(2000);
	
	CURSOR cuDatosSoli IS
		SELECT s.SUSCCLIE, 
			   oa.product_id
        FROM PR_PRODUCT PR, 
			 SUSCRIPC s, 
			 or_order_activity oa
		WHERE PR.SUBSCRIPTION_ID = S.SUSCCODI
        AND PR.PRODUCT_ID 		 = oa.product_id
        AND oa.order_id			 = inuordenId
        AND ROWNUM 				 = 1;
	
	-->>

BEGIN

	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, csbInicio);
	
	pkg_traza.trace('inuordenId' || inuordenId, cnuNVLTRC);
	
	sbcomentario   := 'Generada por orden: ' || inuordenId;
	
	IF(cuDatosSoli%ISOPEN) THEN
		CLOSE cuDatosSoli;
	END IF;
	
	OPEN cuDatosSoli;
	FETCH cuDatosSoli INTO nuContactId, nuProducto;
	CLOSE cuDatosSoli;
	
	-- Construye el XML del tipo de solicitud 100328 - Suspension por calidad de medicion
	sbRequestXML := PKG_XML_SOLI_CALID_MEDIC.getSolicitudSuspensionCLM(nuRecepcion,
					                                                   sbcomentario,
																	   nuProducto,
																	   nuContactId,
																	   nuTiposuspen,
																	   nuTipoCausal,
																	   nuCausal
																	   );
																	   
	-- Registra la solicitud por XML
	Api_RegisterRequestByXML(sbRequestXML,
                             nuPackageId,
                             nuMotiveId,
                             nuCodError,
                             sbErrorMessage
							 );
							 
	pkg_traza.trace('Se crea la solicitud: ' || nuPackageId, cnuNVLTRC);

    IF nupackageid IS NULL THEN
		Pkg_Error.SetErrorMessage(nuCodError, sbErrorMessage);
    END IF;
	
	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

EXCEPTION
	WHEN pkg_Error.Controlled_Error THEN
		pkg_Error.getError(nuCodError, sbErrorMessage);
		pkg_traza.trace('nuCodError: ' || nuCodError || ', ' || 'sbErrorMessage: ' || sbErrorMessage, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
		RAISE PKG_ERROR.CONTROLLED_ERROR;
	WHEN others THEN
		Pkg_Error.seterror;
		pkg_error.geterror(nuCodError, sbErrorMessage);
		pkg_traza.trace('nuCodError: ' || nuCodError || ', ' || 'sbErrorMessage: ' || sbErrorMessage, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
		RAISE PKG_ERROR.CONTROLLED_ERROR;
END prc_generasolisuspenacom;
/
PROMPT Otorgando permisos de ejecución a prc_generasolisuspenacom
BEGIN
	pkg_utilidades.prAplicarPermisos(upper('prc_generasolisuspenacom'),'PERSONALIZACIONES'); 
END;
/
