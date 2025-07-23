CREATE OR REPLACE PACKAGE PERSONALIZACIONES.pkg_bcinclusioncastigocartera IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   30-04-2025
		Descripcion :   Paquete BC con logica el proyecto de castigo a usuarios por inclusion manual
		ModIFicaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	30-04-2025	OSF-4170	Creación
	*******************************************************************************/
	
	-- Record de información de los usuarios a castigar
	TYPE tyrcInfoUsuariosCastigar IS RECORD(dtFechaGeneracion		DATE,
											nuDepartamento			NUMBER,
											nuLocalidad				NUMBER,
											nuTipoProducto 			NUMBER,
											nuContrato 				NUMBER,
											nuProducto 				NUMBER,
											dtFechaConexion 		DATE,
											nuEdadDeuda				NUMBER,
											nuDeudaFacturada		NUMBER,
											nuDeudaDiferida			NUMBER,
											nuTotalDeuda			NUMBER,
											nuNroVisitas			NUMBER,
											nuUltimaFinanciacion	NUMBER,
											nuEstadoCorte			NUMBER,
											nuEstadoProducto		NUMBER,
											nuOrden					NUMBER,
											nuCategoria				NUMBER,
											nuSubcategoria			NUMBER,
											nuMotivoCastigo			NUMBER,
											sbIdentificacion		VARCHAR2(20),
											nuCliente				NUMBER,
											nuCiclo					NUMBER
											);

	-- Tipo tabla con los criterios por concepto y el tipo de producto
	TYPE tytbInfoUsuariosCastigar IS TABLE OF tyrcInfoUsuariosCastigar INDEX BY BINARY_INTEGER;
	
	-- Obtiene la version del paquete.
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	
	-- Obtiene en tipo tabla la información de los usuarios a castigar	
	PROCEDURE prcObtInfoUsuariosCastigar(inuProducto 			IN pr_product.product_id%TYPE,
										 otbInfoUsuarioCastigar	OUT tytbInfoUsuariosCastigar
										 );
									
END pkg_bcinclusioncastigocartera;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.pkg_bcinclusioncastigocartera IS

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
    <Fecha> 24-04-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <ModIFicacion Autor="Jhon.Erazo" Fecha="24-04-2025" Inc="OSF-4170" Empresa="GDC"> 
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
    Programa        : prcObtInfoUsuariosCastigar
    Descripcion     : Obtiene en tipo tabla la información de los usuarios a castigar
    Autor           : Jhon Erazo
    Fecha           : 30/04/2025
  
    Parametros de Entrada
		inuProducto					Producto
    Parametros de Salida
		otbInfoUsuarioCastigar       Tabla con la información de los usuarios a castigar
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
	jerazomvm	30/04/2025		OSF-4170	Creación
	***************************************************************************/	
	PROCEDURE prcObtInfoUsuariosCastigar(inuProducto 			IN pr_product.product_id%TYPE,
										 otbInfoUsuarioCastigar	OUT tytbInfoUsuariosCastigar
										 )
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcObtInfoUsuariosCastigar';
		
		nuError			NUMBER;  
		sbmensaje		VARCHAR2(1000);	
		
		CURSOR cuInfoUsuariosCastigar 
		IS
			SELECT c.*, 
				   p.identification, 
				   p.subscriber_id cliente, 
				   j.susccicl ciclo
			FROM ldc_usu_eva_cast c, 
				 suscripc j, 
				 ge_subscriber p
			WHERE c.producto 	= inuProducto
			AND c.contrato 		= j.susccodi
			AND j.suscclie 		= p.subscriber_id;
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProducto: ' || inuProducto , cnuNVLTRC);
		
		IF (cuInfoUsuariosCastigar%ISOPEN) THEN
			CLOSE cuInfoUsuariosCastigar;
		END IF;
		
		OPEN cuInfoUsuariosCastigar;
		FETCH cuInfoUsuariosCastigar BULK COLLECT INTO otbInfoUsuarioCastigar;
		CLOSE cuInfoUsuariosCastigar;

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
	END prcObtInfoUsuariosCastigar;

END pkg_bcinclusioncastigocartera;
/
PROMPT OtorgANDo permisos de ejecución para adm_person.pkg_bcinclusioncastigocartera
BEGIN
    pkg_utilidades.prAplicarPermisos(UPPER('pkg_bcinclusioncastigocartera'), 'PERSONALIZACIONES');
END;
/