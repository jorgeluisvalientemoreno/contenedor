CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BOVALIDA_TITR_ABIERTA IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   18-02-2025
		Descripcion :   Paquete con los metodos para el trigger TRG_VALIDA_TITR_ABIERTA
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
	
	-- Valida si el producto tiene ordenes abiertas con el tipo de trabajo
	PROCEDURE prcValTitrProducto(inuProducto 	IN pr_product.product_id%TYPE,
								 inuTipoTrabajo	IN or_order.task_type_id%TYPE,
								 inuOrden		IN or_order.order_id%TYPE
								);
									
END PKG_BOVALIDA_TITR_ABIERTA;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BOVALIDA_TITR_ABIERTA IS

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
    Programa        : prcValTitrProducto
    Descripcion     : Valida si el producto tiene ordenes abiertas con el tipo de trabajo
    Autor           : Jhon Erazo
    Fecha           : 18-02-2025
  
    Parametros de Entrada
		inuProducto			Identificador del producto
		inuTipoTrabajo		Identificador del tipo de trabajo
		inuOrden			IdentIFicador de la orden
	  
    Parametros de Salida
	
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	18/02/2025	OSF-3876	Creación
	***************************************************************************/	
	PROCEDURE prcValTitrProducto(inuProducto 	IN pr_product.product_id%TYPE,
								 inuTipoTrabajo	IN or_order.task_type_id%TYPE,
								 inuOrden		IN or_order.order_id%TYPE
								)
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcValTitrProducto';
		
		nuError				NUMBER;  
		sbmensaje   		VARCHAR2(1000);	
		nuExisteTitr		NUMBER;
		nuOrdenesAbiertas	NUMBER;
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProducto: '		|| inuProducto 		|| CHR(10) ||
						'inuTipoTrabajo: '	|| inuTipoTrabajo 	|| CHR(10) ||
						'inuOrden: '		|| inuOrden, cnuNVLTRC);
		
		-- Valida si el tipo de trabajo esta configurado en el parametro TITR_VALIDA_OT_ABIERTA
		nuExisteTitr := pkg_parametros.fnuValidaSiExisteCadena('TITR_VALIDA_OT_ABIERTA',
															   ',',
															   inuTipoTrabajo
															   );
		pkg_traza.trace('nuExisteTitr: ' || nuExisteTitr, cnuNVLTRC);	
		
		IF (nuExisteTitr > 0) THEN
	
			pkg_traza.trace('Validando si el producto: ' || inuProducto || ' tiene ordenes abiertas, con el tipo trabajo: ' || inuTipoTrabajo, cnuNVLTRC);	
			
			-- valida si el producto tiene ordenes pendientes con el tipo de trabajo que se va crear
			nuOrdenesAbiertas := pkg_bcvalida_titr_abierta.fnuCanOrdAbierTitrProduc(inuProducto,
																				    inuTipoTrabajo,
																				    inuOrden
																				    );
			pkg_traza.trace('nuOrdenesAbiertas: ' || nuOrdenesAbiertas, cnuNVLTRC);	

			IF (nuOrdenesAbiertas > 0) THEN
				pkg_error.setErrorMessage(isbMsgErrr => 'No se puede registrar una Orden con el tipo de trabajo ' || inuTipoTrabajo || 
													    ' - ' || pkg_or_task_type.fsbObtDESCRIPTION(inuTipoTrabajo) ||
														', ya el usuario tiene una OT pendiente por gestionar.'
										  );
			END IF;
		
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
	END prcValTitrProducto;

END PKG_BOVALIDA_TITR_ABIERTA;
/
PROMPT Otorgando permisos de ejecución para adm_person.PKG_BOVALIDA_TITR_ABIERTA
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOVALIDA_TITR_ABIERTA', 'PERSONALIZACIONES');
END;
/