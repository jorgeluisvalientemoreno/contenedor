CREATE OR REPLACE PACKAGE personalizaciones.pkg_boservicio_tecn_clie_ext AS

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe y Efigas
      Autor : jerazomvm
      Descr : Paquete para manejo de logica del tramite
			  299 - Solicitud de Servicio Técnico Clientes Externos 
      Tabla : 
      Caso  : OSF-4449
      Fecha : 16/05/2025
  ***************************************************************************/
  
	-- Obtiene la version del paquete.
    FUNCTION fsbVersion
    RETURN VARCHAR2;

	-- Obtiene la categoria del producto de gas
	FUNCTION fnuObtCategoriaProducGas(inuContrato IN suscripc.susccodi%TYPE) 
	RETURN NUMBER;
  
	-- Obtiene la subcategoria
	FUNCTION fnuObtSubCategoriaProducGas(inuContrato IN suscripc.susccodi%TYPE) 
	RETURN NUMBER;

END pkg_boservicio_tecn_clie_ext;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boservicio_tecn_clie_ext AS

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Autor : jerazomvm
    Descr : Reglas para el manejo de funcionbalidades del tramite
			299 - Solicitud de Servicio Técnico Clientes Externos 
    Tabla : 
    Caso  : OSF-4449
    Fecha : 16/05/2025
	***************************************************************************/

	--------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-4449';
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
    <Fecha> 16/05/2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="16/05/2025" Inc="OSF-4449" Empresa="GDC"> 
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
    Programa        : fnuObtCategoriaProducGas
    Descripcion     : Obtiene la categoria del producto de gas
	
    Autor           : Jhon Erazo
    Fecha           : 16/05/2025
	
	Parametros		:
		Entrada		:
			inuContrato		Contrato
		
		Salida		:
			nuCategoria		Categoria
			
    Modificaciones  :
    Autor       Fecha       Caso       	Descripcion
	jerazomvm	16/05/2025	OSF-4449	Creación
	***************************************************************************/
	FUNCTION fnuObtCategoriaProducGas(inuContrato IN suscripc.susccodi%TYPE) 
	RETURN NUMBER
	IS

		csbMetodo   		VARCHAR2(70) := csbSP_NAME || 'fnuObtCategoriaProducGas';
		
		nuCodigoError 		NUMBER; -- se almacena codigo de error
		nuProductoGasIdx	BINARY_INTEGER;
		nuCategoria			servsusc.sesucate%TYPE := -1;
		sbMensError 		VARCHAR2(2000); -- se almacena descripcion del error 
		tbProductoGas		pkg_bcproducto.tytbsbtServsusc;

	BEGIN

		pkg_traza.trace(csbMetodo, cnuNVLTRC, csbInicio); 
		
		pkg_traza.trace('inuContrato: ' || inuContrato, cnuNVLTRC);

		-- Obtiene el producto de gas del contrato
		pkg_bccontrato.prcObtProductosXTipoYContrato(inuContrato, 
													 constants_per.cod_servicio_gas, 
													 tbProductoGas
													 );

		nuProductoGasIdx := tbProductoGas.FIRST;						 
			
		-- Si el contrato tiene producto de gas
		WHILE nuProductoGasIdx IS NOT NULL LOOP
			pkg_traza.trace('El contrato tiene el producto de gas: ' || tbProductoGas(nuProductoGasIdx).sesunuse, cnuNVLTRC);
		
			-- Obtiene la categoria
			nuCategoria := tbProductoGas(nuProductoGasIdx).sesucate;	
		
			nuProductoGasIdx := tbProductoGas.NEXT(nuProductoGasIdx);
		
		END LOOP;
		
		pkg_traza.trace('nuCategoria: ' || nuCategoria, cnuNVLTRC);

		pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuCategoria;

	EXCEPTION
		WHEN pkg_Error.Controlled_Error THEN
			pkg_Error.getError(nuCodigoError, sbMensError);
			pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			RAISE pkg_Error.Controlled_Error;
		WHEN OTHERS THEN
			pkg_Error.setError;
			pkg_Error.getError(nuCodigoError, sbMensError);
			pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE pkg_Error.Controlled_Error;
	END fnuObtCategoriaProducGas;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtSubCategoriaProducGas
    Descripcion     : Obtiene la subcategoria del producto de gas
	
    Autor           : Jhon Erazo
    Fecha           : 16/05/2025
	
	Parametros		:
		Entrada		:
			inuContrato		Contrato
		
		Salida		:
			nuCategoria		Categoria

    Modificaciones  :
    Autor       Fecha       Caso       	Descripcion
	jerazomvm	16/05/2025	OSF-4449	Creación
	***************************************************************************/
	FUNCTION fnuObtSubCategoriaProducGas(inuContrato IN suscripc.susccodi%TYPE)
	RETURN NUMBER
	IS

		csbMetodo   		VARCHAR2(70) := csbSP_NAME || 'fnuObtSubCategoriaProducGas';
		
		nuCodigoError 		NUMBER; -- se almacena codigo de error
		nuProductoGasIdx	BINARY_INTEGER;
		nuSubcategoria		servsusc.sesusuca%TYPE	:= -1;
		sbMensError 		VARCHAR2(2000); -- se almacena descripcion del error 
		tbProductoGas		pkg_bcproducto.tytbsbtServsusc;

	BEGIN

		pkg_traza.trace(csbMetodo, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContrato: ' || inuContrato, cnuNVLTRC);
		
		-- Obtiene el producto de gas del contrato
		pkg_bccontrato.prcObtProductosXTipoYContrato(inuContrato, 
													 constants_per.cod_servicio_gas, 
													 tbProductoGas
													 );

		nuProductoGasIdx := tbProductoGas.FIRST;						 
			
		-- Si el contrato tiene producto de gas
		WHILE nuProductoGasIdx IS NOT NULL LOOP
			pkg_traza.trace('El contrato tiene el producto de gas: ' || tbProductoGas(nuProductoGasIdx).sesunuse, cnuNVLTRC);
		
			-- Obtiene la subcategoria
			nuSubcategoria := tbProductoGas(nuProductoGasIdx).sesusuca;	
		
			nuProductoGasIdx := tbProductoGas.NEXT(nuProductoGasIdx);
		
		END LOOP;
		
		pkg_traza.trace('nuSubcategoria: ' || nuSubcategoria, cnuNVLTRC);

		pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuSubcategoria;

	EXCEPTION
		WHEN pkg_Error.Controlled_Error THEN
			pkg_Error.getError(nuCodigoError, sbMensError);
			pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			RAISE pkg_Error.Controlled_Error;
		WHEN OTHERS THEN
			pkg_Error.setError;
			pkg_Error.getError(nuCodigoError, sbMensError);
			pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE pkg_Error.Controlled_Error;
	END fnuObtSubCategoriaProducGas;

END pkg_boservicio_tecn_clie_ext;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('personalizaciones.pkg_boservicio_tecn_clie_ext'),'PERSONALIZACIONES'); 
END;
/