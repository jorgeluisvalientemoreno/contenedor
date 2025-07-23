CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BCVALIDA_TITR_ABIERTA IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   18-02-2025
		Descripcion :   Paquete con los metodos para del trigger TRG_VALIDA_TITR_ABIERTA
		ModIFicaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	18/02/2025	OSF-3876	Creación
	*******************************************************************************/
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-02-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <ModIFicacion Autor="Jhon.Erazo" Fecha="27-02-2025" Inc="OSF-3876" Empresa="GDC">
               Creación
           </ModIFicacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	
	-- Obtiene las ordenes abiertas por tipo de trabajo para el producto
	FUNCTION fnuCanOrdAbierTitrProduc(inuProducto 		IN pr_product.product_id%TYPE,
									  inuTipoTrabajo	IN or_order.task_type_id%TYPE,
									  inuOrden		  	IN or_order.order_id%TYPE
									 )
	RETURN NUMBER;
									
END PKG_BCVALIDA_TITR_ABIERTA;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BCVALIDA_TITR_ABIERTA IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
    -- IdentIFicador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-3876';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 18-02-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <ModIFicacion Autor="Jhon.Erazo" Fecha="18-02-2025" Inc="OSF-3876" Empresa="GDC"> 
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
    Programa        : fnuCanOrdAbierTitrProduc
    Descripcion     : Obtiene las ordenes abiertas por tipo de trabajo para el producto
    Autor           : Jhon Erazo
    Fecha           : 18-02-2025
  
    Parametros de Entrada
		inuProducto			Identificador del producto
		inuTipoTrabajo		Identificador del tipo de trabajo
		inuOrden			IdentIFicador de la orden
	  
    Parametros de Salida
		nuOrdenesAbiertas	Cantidad de ordenes abiertas	
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	18/02/2025	OSF-3876	Creación
	***************************************************************************/	
	FUNCTION fnuCanOrdAbierTitrProduc(inuProducto 		IN pr_product.product_id%TYPE,
									  inuTipoTrabajo	IN or_order.task_type_id%TYPE,
									  inuOrden		  	IN or_order.order_id%TYPE
									 )
	RETURN NUMBER
	IS
	
		csbMETODO   		CONSTANT VARCHAR2(100) := csbSP_NAME ||'fnuCanOrdAbierTitrProduc';
		
		nuError				NUMBER;  
		nuOrdenesAbiertas	NUMBER;
		sbmensaje   		VARCHAR2(1000);	

		CURSOR cuValOrdenesAbiertas
		IS 
			SELECT COUNT(1) cantidad
			FROM or_order o, 
				 or_order_activity oa
			WHERE oa.product_id = inuProducto
			AND oa.order_id		= o.order_id 
			AND o.task_type_id  = inuTipoTrabajo
			AND o.order_id		<> inuOrden
			AND o.order_status_id NOT IN (SELECT order_status_id 
										  FROM or_order_status 
										  WHERE is_final_status = 'Y'
										  );
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProducto: '		|| inuProducto 		|| CHR(10) ||
						'inuTipoTrabajo: '	|| inuTipoTrabajo 	|| CHR(10) ||
						'inuOrden: '		|| inuOrden, cnuNVLTRC);
						
		IF (cuValOrdenesAbiertas%ISOPEN) THEN
			CLOSE cuValOrdenesAbiertas;
		END IF;
			
		-- valida si el producto tiene ordenes pendientes con el tipo de trabajo que se va crear
		OPEN cuValOrdenesAbiertas;
		FETCH cuValOrdenesAbiertas INTO nuOrdenesAbiertas;
		CLOSE cuValOrdenesAbiertas;
		
		pkg_traza.trace('nuOrdenesAbiertas: ' || nuOrdenesAbiertas, cnuNVLTRC);

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuOrdenesAbiertas;

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
	END fnuCanOrdAbierTitrProduc;

END PKG_BCVALIDA_TITR_ABIERTA;
/
PROMPT Otorgando permisos de ejecución para adm_person.PKG_BCVALIDA_TITR_ABIERTA
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCVALIDA_TITR_ABIERTA', 'PERSONALIZACIONES');
END;
/