CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BCLDCCFLOT IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   21-01-2025
		Descripcion :   Paquete con las consultas para el PB LDCCFLOT
		Modificaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	21/01/2025	OSF-3871	Creación
	*******************************************************************************/
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-01-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="27-01-2025" Inc="OSF-3871" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	
	-- Valida si el tipo de trabajo esta configurado en LDC_COTT_CFLO
	FUNCTION fnuValConfigTipoTrab(inuTipoTrabajo	IN or_order.task_type_id%TYPE)
	RETURN NUMBER;
	
	-- Valida que la orden no tenga acta asociada
	FUNCTION fnuValOrdenActaAsociada(inuOrdenId	IN or_order.order_id%TYPE)
	RETURN NUMBER;
									
END PKG_BCLDCCFLOT;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BCLDCCFLOT IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-3871';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 21-01-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2025" Inc="OSF-3871" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuValConfigTipoTrab
    Descripcion     : Valida si el tipo de trabajo esta configurado en LDC_COTT_CFLO
    Autor           : Jhon Erazo
    Fecha           : 21-01-2025
  
    Parametros de Entrada
		inuTipoTrabajo	Identificador del tipo de trabajo
	  
    Parametros de Salida	
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	21/01/2025	OSF-3871	Creación
	***************************************************************************/	
	FUNCTION fnuValConfigTipoTrab(inuTipoTrabajo	IN or_order.task_type_id%TYPE)
	RETURN NUMBER
	IS
	
		csbMETODO   		CONSTANT VARCHAR2(100) := csbSP_NAME ||'fnuValConfigTipoTrab';
		nuError				NUMBER;  
		nuExisteTipoTrabajo	NUMBER;
		sbmensaje   		VARCHAR2(1000);	

		CURSOR cuValConfigTipoTrab
		IS 
			SELECT count(*)
			FROM LDC_COTT_CFLO
			WHERE task_type_id = inuTipoTrabajo;

	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuTipoTrabajo: ' || inuTipoTrabajo, cnuNVLTRC);
		
		IF (cuValConfigTipoTrab%ISOPEN) THEN
			CLOSE cuValConfigTipoTrab;
		END IF;
		
		OPEN cuValConfigTipoTrab;
		FETCH cuValConfigTipoTrab INTO nuExisteTipoTrabajo;
		CLOSE cuValConfigTipoTrab;
		
		pkg_traza.trace('nuExisteTipoTrabajo: ' || nuExisteTipoTrabajo, cnuNVLTRC);		

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuExisteTipoTrabajo;

	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
	END fnuValConfigTipoTrab;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuValOrdenActaAsociada
    Descripcion     : Valida que la orden no tenga acta asociada
    Autor           : Jhon Erazo
    Fecha           : 21-01-2025
  
    Parametros de Entrada
		inuOrdenId	Identificador de la orden
	  
    Parametros de Salida	
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	21/01/2025	OSF-3871	Creación
	***************************************************************************/	
	FUNCTION fnuValOrdenActaAsociada(inuOrdenId	IN or_order.order_id%TYPE)
	RETURN NUMBER
	IS
	
		csbMETODO   			CONSTANT VARCHAR2(100) := csbSP_NAME ||'fnuValOrdenActaAsociada';
		nuError					NUMBER;  
		nuExisteActaAsociada	NUMBER;
		sbmensaje   			VARCHAR2(1000);	

		CURSOR cuValActaAsociada
		IS
			SELECT count(*) 
			FROM ct_order_certifica 
			WHERE order_id = inuOrdenId;

	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuOrdenId: ' || inuOrdenId, cnuNVLTRC);
		
		IF (cuValActaAsociada%ISOPEN) THEN
			CLOSE cuValActaAsociada;
		END IF;
		
		OPEN cuValActaAsociada;
		FETCH cuValActaAsociada INTO nuExisteActaAsociada;
		CLOSE cuValActaAsociada;
		
		pkg_traza.trace('nuExisteActaAsociada: ' || nuExisteActaAsociada, cnuNVLTRC);		

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuExisteActaAsociada;

	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
	END fnuValOrdenActaAsociada;

END PKG_BCLDCCFLOT;
/
PROMPT Otorgando permisos de ejecución para adm_person.PKG_BCLDCCFLOT
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCLDCCFLOT', 'PERSONALIZACIONES');
END;
/