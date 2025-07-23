CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_BCGESTION_PRODUCTO IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		pkg_bcordenes
		Autor       :   Jhon Eduar Erazo
		Fecha       :   29-02-2024
		Descripcion :   Paquete con los metodos para manejo de información sobre los productos
		Modificaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	25/02/2024	OSF-4046	Se crea la función fnuObtComponentePrincipal
		jerazomvm	29/02/2022	OSF-2374	Creación
	*******************************************************************************/
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-02-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="27-02-2024" Inc="OSF-2374" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtieneCompoxProduct
    Descripcion     : Busca los componentes asociados al producto.
    Autor           : Jhon Erazo
    Fecha           : 29-02-2024
  
    Parametros de Entrada
      inuProductoId		Identificador del producto
	  
    Parametros de Salida
		otbProducto		Tabla con los componentes
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	29/02/2024	OSF-2374	Creación
	***************************************************************************/	
	PROCEDURE prcObtieneCompoxProduct(inuProductoId    IN  mo_packages.package_id%type,
									  otbcomponentid   OUT pkg_bccomponentes.tytbcomponent_id
									 );
									 
	-- Obtiene el componente principal del producto
    FUNCTION fnuObtComponentePrincipal(inuProducto IN pr_product.product_id%TYPE)
	RETURN NUMBER;
									
END PKG_BCGESTION_PRODUCTO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_BCGESTION_PRODUCTO IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-2374';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 29-02-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="29-02-2024" Inc="OSF-2374" Empresa="GDC"> 
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
    Programa        : prcObtieneCompoxProduct
    Descripcion     : Busca los componentes asociados al producto.
    Autor           : Jhon Erazo
    Fecha           : 29-02-2024
  
    Parametros de Entrada
      inuProductoId		Identificador del producto
	  
    Parametros de Salida
		otbProducto		Tabla con los componentes
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	29/02/2024	OSF-2374	Creación
	***************************************************************************/	
	PROCEDURE prcObtieneCompoxProduct(inuProductoId    IN  mo_packages.package_id%type,
									  otbcomponentid   OUT pkg_bccomponentes.tytbcomponent_id
									 )
	IS
	
		csbMETODO   CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcObtieneCompoxProduct';
		nuError		NUMBER;  
		sbmensaje   VARCHAR2(1000);
		
		CURSOR cuComponenteId IS
			SELECT p.component_id
			FROM pr_component p
			WHERE p.product_id = inuProductoId;
			

	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProductoId: '	|| inuProductoId, cnuNVLTRC);
		
		IF (cuComponenteId%ISOPEN) THEN
			CLOSE cuComponenteId;
		END IF;
		
		OPEN cuComponenteId;
		FETCH cuComponenteId BULK COLLECT INTO otbcomponentid;
		CLOSE cuComponenteId;

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
	END prcObtieneCompoxProduct;

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtComponentePrincipal
    Descripcion     : Obtiene el componente principal del producto
	
    Autor           : Jhon Erazo
    Fecha           : 25/02/2025
	
	Parametros		:
		Entrada		:
			inuProducto		Identificador del producto
		
		Salida		:
			
			nuComponente	Identificador del componente

    Modificaciones  :
    Autor       Fecha       Caso       	Descripcion
	jerazomvm	25/02/2025	OSF-4046	Creación
	***************************************************************************/
    FUNCTION fnuObtComponentePrincipal(inuProducto IN pr_product.product_id%TYPE)
	RETURN NUMBER
    IS
	
		csbMT_NAME  	VARCHAR2(70) := csbSP_NAME || 'fnuObtComponentePrincipal';
		
		nuError			NUMBER;  
		nuComponente	pr_component.component_id%type;
		sbmensaje		VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProducto: ' || inuProducto, cnuNVLTRC);
		
		-- Obtiene el componente principal
		nuComponente := pr_bcproduct.fnugetmaincomponentid(inuProducto);
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
    END fnuObtComponentePrincipal;
	
END PKG_BCGESTION_PRODUCTO;
/
PROMPT Otorgando permisos de ejecución para adm_person.PKG_BCGESTION_PRODUCTO
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCGESTION_PRODUCTO', 'ADM_PERSON');
END;
/