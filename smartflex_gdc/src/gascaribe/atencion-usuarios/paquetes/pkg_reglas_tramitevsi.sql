CREATE OR REPLACE PACKAGE pkg_reglas_tramitevsi AS

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe y Efigas
      Autor : jerazomvm
      Descr : Reglas para el manejo de funcionbalidades del tramite de venta
			  de servicios de ingenieria
      Tabla : 
      Caso  : OSF-4024
      Fecha : 24/02/2025
  ***************************************************************************/
  
	-- Obtiene la version del paquete.
    FUNCTION fsbVersion
    RETURN VARCHAR2;
  
	-- Inicializa el ID del componente del producto
	PROCEDURE prcIniComponentIdProd;

END pkg_reglas_tramitevsi;
/
CREATE OR REPLACE PACKAGE BODY pkg_reglas_tramitevsi AS

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Autor : jerazomvm
    Descr : Reglas para el manejo de funcionbalidades del tramite de Actualizar Datos del Predio
    Tabla : 
    Caso  : OSF-4024
    Fecha : 24/02/2025
	***************************************************************************/

	--------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-4024';
    csbSP_NAME          CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';
    cnuNVLTRC           CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
	
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
  
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 4-10-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="4-10-2024" Inc="OSF-4046" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcIniComponentIdProd
    Descripcion     : Inicializa el ID del componente del producto
	
    Autor           : Jhon Erazo
    Fecha           : 24/02/2025
	
	Parametros		:
		Entrada		:
		
		Salida		:

    Modificaciones  :
    Autor       Fecha       Caso       	Descripcion
	jerazomvm	24/02/2025	OSF-4024	Creación
	***************************************************************************/
	PROCEDURE prcIniComponentIdProd IS

		csbMetodo   		VARCHAR2(70) := csbSP_NAME || 'prcIniComponentIdProd';
		nuErrorCode 		NUMBER; -- se almacena codigo de error
		nuAtributo 			PLS_INTEGER;
		nuProducto			pr_product.product_id%TYPE;
		nuComponente		pr_component.component_id%TYPE;
		nuTipoComponente	pr_component.component_type_id%TYPE;
		sbMensError 		VARCHAR2(2000); -- se almacena descripcion del error 
		sbInstancia			VARCHAR2(4000) := 'WORK_INSTANCE';
		sbInstanciaActual	VARCHAR2(4000);

	BEGIN

		pkg_traza.trace(csbMetodo, cnuNVLTRC, csbInicio);
		
		-- Valida si el producto y el tipo de producto esta instanciado
		IF (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbInstancia, null, 'PR_PRODUCT', 'PRODUCT_ID', nuAtributo) AND
			GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbInstancia, null, 'PR_PRODUCT', 'PRODUCT_TYPE_ID', nuAtributo)) THEN			
			
			-- Obtiene el contrato
			PRC_OBTIENEVALORINSTANCIA(sbInstancia,
									  NULL,
									  'PR_PRODUCT',
									  'PRODUCT_ID',
									  nuProducto
									  );
			pkg_traza.trace('nuProducto: ' || nuProducto, cnuNVLTRC);
			
			-- Obtiene el componente y tipo de componenete a iniciar
			pkg_botramitevsi.prcObtDatosComponente(nuProducto,
												   nuComponente,
												   nuTipoComponente
												   );
												   
			pkg_traza.trace('nuComponente: ' 		|| nuComponente || CHR(10) ||
							'nuTipoComponente: ' 	|| nuTipoComponente, cnuNVLTRC);

			IF (nuComponente IS NOT NULL AND nuTipoComponente IS NOT NULL) THEN
			
				-- Obtiene la instancia actual
				GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstanciaActual);
				pkg_traza.trace('Instancia Actual: ' || sbInstanciaActual, cnuNVLTRC);
			
				-- Coloca valor al atributo actual
				GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuComponente);
				
				-- Coloca valor al atributo instancia
				GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstanciaActual, NULL, 'MO_COMPONENT', 'COMPONENT_TYPE_ID', nuTipoComponente);
				
			END IF;	
			
		END IF;					

		pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);

	EXCEPTION
		WHEN pkg_Error.Controlled_Error THEN
			pkg_Error.getError(nuErrorCode, sbMensError);
			pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			RAISE pkg_Error.Controlled_Error;
		WHEN OTHERS THEN
			pkg_Error.setError;
			pkg_Error.getError(nuErrorCode, sbMensError);
			pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE pkg_Error.Controlled_Error;
	END prcIniComponentIdProd;

END pkg_reglas_tramitevsi;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('pkg_reglas_tramitevsi'),'OPEN'); 
END;
/