CREATE OR REPLACE PACKAGE pkg_uildc_procinclumas IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   29-04-2025
		Descripcion :   Paquete UI para el PB ldc_procinclumas
		ModIFicaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	29-04-2025	OSF-4170	Creación
	*******************************************************************************/
	
	-- Obtiene la version del paquete.
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	
	-- Procesa el PB ldc_procinclumas	
	PROCEDURE prcObjeto;
									
END pkg_uildc_procinclumas;
/
CREATE OR REPLACE PACKAGE BODY pkg_uildc_procinclumas IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
    -- IdentIFicador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-4170';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 29-04-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <ModIFicacion Autor="Jhon.Erazo" Fecha="29-04-2025" Inc="OSF-4170" Empresa="GDC"> 
               Creación
           </ModIFicacion>
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
    Programa        : prcObjeto
    Descripcion     : Procesa el PB ldc_procinclumas
    Autor           : Jhon Erazo
    Fecha           : 29-04-2025
  
    Parametros de Entrada
	
    Parametros de Salida
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
    jerazomvm	29-04-2025  	OSF-4170	Creación
	***************************************************************************/	
	PROCEDURE prcObjeto
	IS
	
		csbMETODO		CONSTANT VARCHAR2(100) 	:= csbSP_NAME ||'prcObjeto';
		
		nuError			NUMBER;  
		sbmensaje		VARCHAR2(5000);	
		sbNombreArchivo	ge_boInstanceControl.stysbValue;
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		-- Obtiene el nombre del archivo
		sbNombreArchivo := ge_boInstanceControl.fsbGetFieldValue('GE_SUBSCRIBER', 'SUBSCRIBER_NAME');
		pkg_traza.trace('sbNombreArchivo: ' || sbNombreArchivo, cnuNVLTRC);
		
		-- Validamos Nombre archivo
		IF (sbNombreArchivo IS NULL) THEN
			pkg_Error.setErrorMessage(2126, 'Nombre archivo');
		END IF;						

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);
		
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
	END prcObjeto;

END pkg_uildc_procinclumas;
/
PROMPT OtorgANDo permisos de ejecución para adm_person.pkg_uildc_procinclumas
BEGIN
    pkg_utilidades.prAplicarPermisos(UPPER('pkg_uildc_procinclumas'), 'OPEN');
END;
/