CREATE OR REPLACE PACKAGE pkg_reglas_tram_serv_tecn_ext AS

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe y Efigas
      Autor : jerazomvm
      Descr : Reglas para el manejo de funcionalidades del tramite 
			  299 - Solicitud de Servicio Técnico Clientes Externos 
      Tabla : 
      Caso  : OSF-4449
      Fecha : 16/05/2025
  ***************************************************************************/
  
	-- Obtiene la version del paquete.
    FUNCTION fsbVersion
    RETURN VARCHAR2;

	-- Logica de la regla para inicializar la categoria
	PROCEDURE prcIniCategoria;
  
	-- Logica de la regla para inicializar la subcategoria
	PROCEDURE prcIniSubcategoria;

END pkg_reglas_tram_serv_tecn_ext;
/
CREATE OR REPLACE PACKAGE BODY pkg_reglas_tram_serv_tecn_ext AS

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
    Programa        : prcIniCategoria
    Descripcion     : Logica de la regla para inicializar la categoria
	
    Autor           : Jhon Erazo
    Fecha           : 16/05/2025
	
	Parametros		:
		Entrada		:
		
		Salida		:

    Modificaciones  :
    Autor       Fecha       Caso       	Descripcion
	jerazomvm	16/05/2025	OSF-4449	Creación
	***************************************************************************/
	PROCEDURE prcIniCategoria IS

		csbMetodo   		VARCHAR2(70) := csbSP_NAME || 'prcIniCategoria';
		
		nuCodigoError 		NUMBER; -- se almacena codigo de error
		nuContrato			suscripc.susccodi%TYPE;
		nuCategoria			servsusc.sesucate%TYPE;
		sbMensError 		VARCHAR2(2000); -- se almacena descripcion del error 

	BEGIN

		pkg_traza.trace(csbMetodo, cnuNVLTRC, csbInicio);
		
		-- Obtiene el contrato
		PRC_OBTIENEVALORINSTANCIA('WORK_INSTANCE',
								  NULL,
								  'SUSCRIPC',
								  'SUSCCODI',
								  nuContrato
								  );
		pkg_traza.trace('nuContrato: ' || nuContrato, cnuNVLTRC);

		-- Obtiene la categoria del producto de gas del contrato
		nuCategoria := pkg_boservicio_tecn_clie_ext.fnuObtCategoriaProducGas(nuContrato);		
		pkg_traza.trace('nuCategoria: ' || nuCategoria, cnuNVLTRC);

		-- Instancia la categoria
		GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuCategoria);

		pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);

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
	END prcIniCategoria;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcIniSubcategoria
    Descripcion     : Logica de la regla para inicializar la subcategoria
	
    Autor           : Jhon Erazo
    Fecha           : 16/05/2025
	
	Parametros		:
		Entrada		:
		
		Salida		:

    Modificaciones  :
    Autor       Fecha       Caso       	Descripcion
	jerazomvm	16/05/2025	OSF-4449	Creación
	***************************************************************************/
	PROCEDURE prcIniSubcategoria IS

		csbMetodo   		VARCHAR2(70) := csbSP_NAME || 'prcIniSubcategoria';
		
		nuCodigoError 		NUMBER; -- se almacena codigo de error
		nuContrato			suscripc.susccodi%TYPE;
		nuProductoGasIdx	BINARY_INTEGER;
		nuSubcategoria		servsusc.sesusuca%TYPE	:= -1;
		sbMensError 		VARCHAR2(2000); -- se almacena descripcion del error

	BEGIN

		pkg_traza.trace(csbMetodo, cnuNVLTRC, csbInicio);
		
		-- Obtiene el contrato
		PRC_OBTIENEVALORINSTANCIA('WORK_INSTANCE',
								  NULL,
								  'SUSCRIPC',
								  'SUSCCODI',
								  nuContrato
								  );
		pkg_traza.trace('nuContrato: ' || nuContrato, cnuNVLTRC);
		
		-- Obtiene la subcategoria del producto de gas del contrato
		nuSubcategoria := pkg_boservicio_tecn_clie_ext.fnuObtSubCategoriaProducGas(nuContrato);				
		pkg_traza.trace('nuSubcategoria: ' || nuSubcategoria, cnuNVLTRC);

		-- Instancia la subcategoria
		GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSubcategoria);

		pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);

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
	END prcIniSubcategoria;

END pkg_reglas_tram_serv_tecn_ext;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('pkg_reglas_tram_serv_tecn_ext'),'OPEN'); 
END;
/