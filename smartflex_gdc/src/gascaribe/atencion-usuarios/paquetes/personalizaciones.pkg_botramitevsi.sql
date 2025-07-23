CREATE OR REPLACE PACKAGE personalizaciones.pkg_botramitevsi IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_botramitevsi
    Autor       :   Jhon Eduar Erazo Guachavez
    Fecha       :   24/02/2025
    Descripcion :   Paquete con los metodos para manejo de logica de negocio del 
					tramite de venta de servicios de ingenieria

    Modificaciones  :
    Autor           Fecha           Caso        Descripcion
    jerazomvm		24/02/2025		OSF-4024	Creación						
*******************************************************************************/

    FUNCTION fsbVersion RETURN VARCHAR2;
	
	-- Obtiene el componenete y tipo de componente del producto
    PROCEDURE prcObtDatosComponente(inuProducto			IN pr_product.product_id%TYPE,
									onuComponente		OUT pr_component.component_id%TYPE,
									onuTipoComponente	OUT pr_component.component_type_id%TYPE
									);

END pkg_botramitevsi;

/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_botramitevsi IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-4024';

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    cnuNVLTRC 	CONSTANT NUMBER 		:= pkg_traza.cnuNivelTrzDef;
	csbInicio	CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 4/02/2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4/02/2025" Inc="OSF-4024" Empresa="GDC"> 
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
    Programa        : prcObtDatosComponente
    Descripcion     : Obtiene el componenete y tipo de componente del producto
	
    Autor           : Jhon Erazo
    Fecha           : 24/02/2025
	
	Parametros		:
		Entrada		:
			inuProducto		Identificador del producto
		
		Salida		:
			onuComponente		Identificador del componente
			onuTipoComponente	Identificador del tipo de componente

    Modificaciones  :
    Autor       Fecha       Caso       	Descripcion
	jerazomvm	24/02/2025	OSF-4024	Creación
	***************************************************************************/
    PROCEDURE prcObtDatosComponente(inuProducto			IN pr_product.product_id%TYPE,
									onuComponente		OUT pr_component.component_id%TYPE,
									onuTipoComponente	OUT pr_component.component_type_id%TYPE
									)
    IS
	
		csbMT_NAME  	VARCHAR2(70) := csbSP_NAME || 'prcObtDatosComponente';
		
		nuError			NUMBER;  
		nuTipoProducto	pr_product.product_id%type;
		sbmensaje		VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProducto: ' || inuProducto, cnuNVLTRC);
		
		-- Obtiene el tipo de producto
		nuTipoProducto := pkg_bcproducto.fnuTipoProducto(inuProducto);
		pkg_traza.trace('nuTipoProducto: ' || nuTipoProducto, cnuNVLTRC);	
		
		-- Si el producto es de gas
		IF (nuTipoProducto = constants_per.COD_SERVICIO_GAS) THEN 
		
			onuTipoComponente := 7039;
			
			-- Obtiene el componente 7039 del producto
			onuComponente := pkg_bogestion_componente.fnuObtComponenteXTipoYProd(inuProducto,
																				 onuTipoComponente
																				 );
		ELSE 
			onuComponente	  := NULL;
			onuTipoComponente := NULL;			
			
		END IF;
		
		pkg_traza.trace('onuComponente: ' 		|| onuComponente || CHR(10) ||
						'onuTipoComponente: ' 	|| onuTipoComponente, cnuNVLTRC);
		
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
    END prcObtDatosComponente;
	
END pkg_botramitevsi;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_botramitevsi
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_botramitevsi'), 'PERSONALIZACIONES');
END;
/