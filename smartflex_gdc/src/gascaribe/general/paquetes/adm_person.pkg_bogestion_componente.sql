CREATE OR REPLACE PACKAGE adm_person.pkg_bogestion_componente IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bogestion_componente
    Autor       :   Jhon Eduar Erazo Guachavez
    Fecha       :   24/02/2025
    Descripcion :   Paquete con los metodos para manejo de logica de negocio de
					los componentes

    Modificaciones  :
    Autor           Fecha           Caso        Descripcion
    jerazomvm		24/02/2025		OSF-4046	Creación						
*******************************************************************************/

    FUNCTION fsbVersion RETURN VARCHAR2;
	
	-- Obtiene el componentee dado el producto y tipo de componente
    FUNCTION fnuObtComponenteXTipoYProd(inuProducto			IN pr_product.product_id%TYPE,
										inuTipoComponente	IN pr_component.component_type_id%TYPE
										)
	RETURN NUMBER;
	
	-- Obtiene el tipo de componente
    FUNCTION fnuObtTipoComponente(inuComponente	IN pr_component.component_id%TYPE)
	RETURN NUMBER;

END pkg_bogestion_componente;

/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bogestion_componente IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-4046';

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    cnuNVLTRC 	CONSTANT NUMBER 		:= pkg_traza.cnuNivelTrzDef;
	csbInicio	CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 29-02-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="29-02-2025" Inc="OSF-4046" Empresa="GDC"> 
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
    Programa        : fnuObtComponenteXTipoYProd
    Descripcion     : Obtiene el componentee dado el producto y tipo de componente
	
    Autor           : Jhon Erazo
    Fecha           : 24/02/2025
	
	Parametros		:
		Entrada		:
			inuProducto		Identificador del producto
			inuTipoComponente		Identificador del componente
		
		Salida		:
			
			nuComponente	Identificador del componente

    Modificaciones  :
    Autor       Fecha       Caso       	Descripcion
	jerazomvm	24/02/2025	OSF-4046	Creación
	***************************************************************************/
    FUNCTION fnuObtComponenteXTipoYProd(inuProducto			IN pr_product.product_id%TYPE,
										inuTipoComponente	IN pr_component.component_type_id%TYPE
										)
	RETURN NUMBER
    IS
	
		csbMT_NAME  	VARCHAR2(70) := csbSP_NAME || 'fnuObtComponenteXTipoYProd';
		
		nuError			NUMBER;  
		nuComponente	pr_component.component_id%type;
		sbmensaje		VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProducto: ' || inuProducto, cnuNVLTRC);
		
		-- Obtiene el tipo de producto
		nuComponente := pr_bocnfcomponent.fnugetcomponentidbyproduct(inuProducto,
																	 inuTipoComponente
																	 );
		pkg_traza.trace('nuComponente: ' || nuComponente, cnuNVLTRC);
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuComponente;

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
    END fnuObtComponenteXTipoYProd;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtTipoComponente
    Descripcion     : Obtiene el tipo de componente
	
    Autor           : Jhon Erazo
    Fecha           : 24/02/2025
	
	Parametros		:
		Entrada		:
			inuComponente		Identificador del componente
		
		Salida		:
			
			nuComponente	Identificador del componente

    Modificaciones  :
    Autor       Fecha       Caso       	Descripcion
	jerazomvm	24/02/2025	OSF-4046	Creación
	***************************************************************************/
    FUNCTION fnuObtTipoComponente(inuComponente	IN pr_component.component_id%TYPE)
	RETURN NUMBER
    IS
	
		csbMT_NAME  	VARCHAR2(70) := csbSP_NAME || 'fnuObtTipoComponente';
		
		nuError				NUMBER;  
		nuTipoComponente	pr_component.component_type_id%type;
		sbmensaje			VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuComponente: ' || inuComponente, cnuNVLTRC);
		
		-- Obtiene el tipo de componente
		nuTipoComponente := pr_bocomponent.getcomponenttype(inuComponente);
		pkg_traza.trace('nuTipoComponente: ' || nuTipoComponente, cnuNVLTRC);
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuTipoComponente;

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
    END fnuObtTipoComponente;
	
END pkg_bogestion_componente;
/

PROMPT Otorgando permisos de ejecución para adm_person.pkg_bogestion_componente
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_bogestion_componente'), 'ADM_PERSON');
END;
/