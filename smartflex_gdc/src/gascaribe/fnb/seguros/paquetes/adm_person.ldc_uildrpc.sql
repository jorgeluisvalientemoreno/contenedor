CREATE OR REPLACE PACKAGE adm_person.ldc_uildrpc AS

	/*****************************************************************
	Propiedad intelectual de Gas Caribe.

	Unidad         : ldc_uildrpc
	Descripcion    : Paquete para agrupar servicios del PB LDRPC
	Autor          : Carlos Andres Gonzalez
	Fecha          : 03/04/2023

	Historia de Modificaciones
	Fecha       Autor                   Modificacion
	==========  ===================     ====================
	14/03/2024	jerazomvm				OSF-2169: Se modifica el procedimiento Process
	03/04/2023	cgonzalez (Horbath)		OSF-952: Creacion
	******************************************************************/
	
    FUNCTION fsbVersion RETURN VARCHAR2;
    
	PROCEDURE Process;

END ldc_uildrpc;
/
CREATE OR REPLACE PACKAGE BODY adm_person.ldc_uildrpc AS

	/*****************************************************************
	Propiedad intelectual de Gas Caribe.

	Unidad         : ldc_uildrpc
	Descripcion    : Paquete para agrupar servicios del PB LDRPC
	Autor          : Carlos Andres Gonzalez
	Fecha          : 03/04/2023

	Historia de Modificaciones
	Fecha       Autor                   Modificacion
	==========  ===================     ====================
	03/04/2023	cgonzalez (Horbath)		OSF-952: Creacion
	******************************************************************/

	csbVersion  CONSTANT VARCHAR2(250)	:= 'OSF-2169';
	csbSP_NAME	CONSTANT VARCHAR2(100)	:= $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       	:= pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;
    sbErrmsg    ge_error_log.description%TYPE;
	
	/*****************************************************************
	Propiedad intelectual de Gas Caribe.

	Unidad         : fsbVersion
	Descripcion    : Servicio para obtener el ultimo caso que modifico algun servicio del paquete
	Autor          : Carlos Andres Gonzalez
	Fecha          : 03/04/2023

	Historia de Modificaciones
	Fecha       Autor                   Modificacion
	==========  ===================     ====================
	03/04/2023	cgonzalez (Horbath)		OSF-952: Creacion
	******************************************************************/
	FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
		RETURN csbVersion;
	END fsbVersion;

  
	/*****************************************************************
	Propiedad intelectual de Gas Caribe.

	Unidad         : Process
	Descripcion    : Servicio utilizado al momento de seleccionar la opcion procesar
	Autor          : Carlos Andres Gonzalez
	Fecha          : 03/04/2023

	Historia de Modificaciones
	Fecha       Autor                   Modificacion
	==========  ===================     ====================
	14/03/2024	jerazomvm				OSF-2169:
	03/04/2023	cgonzalez (Horbath)		OSF-952: Creacion
	******************************************************************/
	PROCEDURE Process
	IS

		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'Process';
		cnuNULL_ATTRIBUTE 	constant number := 2126;
	 
		nuError			NUMBER;  
		sbLINE_ID 		ge_boInstanceControl.stysbValue;
		sbMONTH_POLICY 	ge_boInstanceControl.stysbValue;
		sbPOLICY_ID		ge_boInstanceControl.stysbValue;
		sbParametros	ge_process_schedule.parameters_%TYPE;
		sbmensaje		VARCHAR2(1000); 

	BEGIN
	
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
	
		sbLINE_ID 		:= ge_boInstanceControl.fsbGetFieldValue ('LD_LINE', 'LINE_ID');
		sbMONTH_POLICY	:= ge_boInstanceControl.fsbGetFieldValue ('LD_POLICY', 'MONTH_POLICY');
		sbPOLICY_ID 	:= ge_boInstanceControl.fsbGetFieldValue ('LDC_POLICY_TRASL', 'POLICY_ID');
		
		pkg_traza.trace('sbLINE_ID: ' 		|| sbLINE_ID, cnuNVLTRC);
		pkg_traza.trace('sbMONTH_POLICY: '	|| sbMONTH_POLICY, cnuNVLTRC);
		pkg_traza.trace('sbPOLICY_ID: ' 	|| sbPOLICY_ID, cnuNVLTRC);

		------------------------------------------------
		-- Required Attributes
		------------------------------------------------

		-- Valida que se haya ingresado la linea de producto
		IF (sbLINE_ID IS NULL) THEN
			Pkg_Error.SetErrorMessage(cnuNULL_ATTRIBUTE, 'L¿nea de Producto');
		END IF;
	 
		-- Valida que se haya ingresado el tipo de renovación
		IF (sbMONTH_POLICY IS NULL) THEN
			Pkg_Error.SetErrorMessage(cnuNULL_ATTRIBUTE, 'Tipo de Renovación');
		END IF;
	 
		-- Valida que se haya ingresado el dato de renovación
		IF (sbPOLICY_ID IS NULL) THEN
			Pkg_Error.SetErrorMessage(cnuNULL_ATTRIBUTE, 'Dato Renovacion');
		END IF;
		
		-- Arma los parametros ingresados
		sbParametros :=	'LINE_ID=' || sbLINE_ID || '|MONTH_POLICY=' || sbMONTH_POLICY || '|POLICY_ID=' || sbPOLICY_ID || '|';
		pkg_traza.trace('sbParametros: ' || sbParametros, cnuNVLTRC);
		
		-- Valida si el proceso se encuentra en ejecución
		pkg_borenovacionpolizas.prcValidacionesLDRPC('LDRPC',
													sbParametros,
													nuError,
													sbmensaje);
													
		-- Si se encuentra en ejecución, lanza error
		IF (nuError <> 0) THEN
			Pkg_Error.SetErrorMessage(nuError,
									  sbmensaje
									  );
		END IF;
	 
		------------------------------------------------
		-- User code
		------------------------------------------------
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
	END Process;

END ldc_uildrpc;
/
PROMPT Otorgando permisos de ejecucion a LDC_UILDRPC
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_UILDRPC', 'ADM_PERSON');
END;
/