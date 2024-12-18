CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BOREVERSARORDENES
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BOREVERSARORDENES </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 22-04-2024 </Fecha>
    <Descripcion> 
        Paquete con la logica de revserar ordenes
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="22-04-2024" Inc="OSF-2556" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------


    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 22-04-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="22-04-2024" Inc="OSF-2556" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuConsultarOrdenes </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 22-04-2024 </Fecha>
    <Descripcion> 
        Retorna las ordenes a reversar
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="22-04-2024" Inc="OSF-2556" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fnuConsultarOrdenes(isbPackageId	IN VARCHAR2,
								 isbOrderId		IN VARCHAR2
								)
	RETURN CONSTANTS_PER.TYREFCURSOR;
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcReversarOrdenes </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 22-04-2024 </Fecha>
    <Descripcion> 
        Reversa la orden de estado 7 a 5
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="22-04-2024" Inc="OSF-2556" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
	PROCEDURE prcReversarOrdenes(isbPk			IN VARCHAR2,
								  inuCurrent   	IN NUMBER,
								  inuTotal     	IN NUMBER,
								  onuErrorCode 	OUT ge_error_log.message_id%type,
								  osbErrorMess 	OUT ge_error_log.description%type
								  );
	
END PKG_BOREVERSARORDENES;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BOREVERSARORDENES
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BOREVERSARORDENES </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 22-04-2024 </Fecha>
    <Descripcion> 
        Paquete con la logica de revserar ordenes
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="22-04-2024" Inc="OSF-2556" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-2659';
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
    <Fecha> 22-04-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="22-04-2024" Inc="OSF-2556" Empresa="GDC"> 
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
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuConsultarOrdenes </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 22-04-2024 </Fecha>
    <Descripcion> 
        Retorna las ordenes a reversar
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="22-04-2024" Inc="OSF-2556" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fnuConsultarOrdenes(isbPackageId	IN VARCHAR2,
								 isbOrderId		IN VARCHAR2
								 )
	RETURN CONSTANTS_PER.TYREFCURSOR
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fnuConsultarOrdenes';
		
		nuError				NUMBER;  
		sbmensaje			VARCHAR2(1000);  
		RFSELECT            CONSTANTS_PER.TYREFCURSOR;              -- Tipo de variable que devuelve los objetos en el pb LDRoe
		rcReverseOrder      pkg_or_order.styOR_order;              --Registro de una orden
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('isbPackageId: ' || isbPackageId || CHR(10) ||
						'isbOrderId: '	 || isbOrderId, cnuNVLTRC);
		
		--Se valida que el usuario en la forma LDROE ingrese un valor en el numero de la solicitud
		--o un valor en el codigo de la orden
		IF ((isbOrderId IS NULL) AND (isbPackageId IS NULL)) THEN
			pkg_traza.trace('Debe ingresar el numero de la orden de trabajo o el codigo de la solicitud', cnuNVLTRC);
			Pkg_Error.SetErrorMessage(2741, 'Debe ingresar el numero de la orden de trabajo o el codigo de la solicitud');
		END IF;
		
		--Si se ingresa el numero de la orden o si ingresan el codigo de la solicitud
		-- y el numero de la orden se buscara por el numero de la orden, de lo contrario buscara por
		-- el numero de la solicitud
		
		IF (((isbOrderId IS NOT NULL) AND (isbPackageId IS NOT NULL)) OR (isbOrderId IS NOT NULL)) THEN
		
			--Buscar la orden con el numero que viene en la variable isbOrderId
			rcreverseorder := pkg_bcordenes.frcgetRecord(isbOrderId);
		   
			--Si la orden no esta en estado terminada no se acepta
			IF (rcreverseorder.order_status_id <> 7 ) THEN
				pkg_traza.trace('La orden tiene un estado diferente a 7', cnuNVLTRC);
				Pkg_Error.SetErrorMessage(2741, 'La orden ' || isbOrderId || ' no se encuentra en un estado valido para el proceso');
			END IF;
		
			--Si supera las validaciones se retorna la orden consultada
			OPEN RFSELECT FOR SELECT OO.ORDER_ID, OOA.PACKAGE_ID
							  FROM OR_ORDER OO, OR_ORDER_ACTIVITY OOA
							  WHERE OO.ORDER_ID	= isbOrderId
							  AND OO.ORDER_ID 	= OOA.ORDER_ID; 
		
		ELSE 
		
			--Si supera las validaciones se retorna las ordenes por solicitud
			OPEN RFSELECT FOR SELECT OO.ORDER_ID, OOA.PACKAGE_ID
							  FROM OR_ORDER OO, OR_ORDER_ACTIVITY OOA
							  WHERE OOA.PACKAGE_ID 	 = isbPackageId
							  AND OOA.ORDER_ID 		 = OO.ORDER_ID
							  AND OO.ORDER_STATUS_ID = 7;
		
		END IF;    
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN RFSELECT;

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			RAISE PKG_ERROR.CONTROLLED_ERROR;
			RETURN RFSELECT;
		WHEN others THEN
			Pkg_Error.seterror;
			pkg_error.geterror(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE PKG_ERROR.CONTROLLED_ERROR;
			RETURN RFSELECT;
    END fnuConsultarOrdenes;
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcReversarOrdenes </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 22-04-2024 </Fecha>
    <Descripcion> 
        Reversa la orden de estado 7 a 5
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="22-04-2024" Inc="OSF-2556" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
	PROCEDURE prcReversarOrdenes(isbPk			IN VARCHAR2,
								 inuCurrent   	IN NUMBER,
								 inuTotal     	IN NUMBER,
								 onuErrorCode 	OUT ge_error_log.message_id%type,
								 osbErrorMess 	OUT ge_error_log.description%type
								 )
	IS

		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prcReversarOrdenes';

		rcReverseOrder		pkg_or_order.styOR_order;
	
	BEGIN

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

		pkg_traza.trace('isbOrderId ['||isbPk||']', cnuNVLTRC);

		-- Obtiene los datos de la orden
		rcReverseOrder := pkg_bcordenes.frcgetRecord(isbPk);
		pkg_traza.trace('El estado de la orden es: ['||rcReverseOrder.Order_Status_Id||']', cnuNVLTRC);

		rcReverseOrder.execution_final_date := null;
		rcReverseOrder.exec_initial_date 	:= null;
		rcReverseOrder.causal_id 			:= null;
		rcReverseOrder.order_status_id 		:= 5;

		-- Reverso el estado de la orden
		pkg_or_order.prcActualizaRecord(rcReverseOrder);
	
		-- Deja el log de cambio de estado de la orden
		pkg_or_order_stat_change.prcInsor_order_stat_change(104, 								-- inuactionId
															7, 									-- inuinitialStatusId
															5, 									-- inuFinalStatusId
															rcReverseOrder.order_id,			-- inuorderId
															PKG_SESSION.GETUSER,				-- isbUserId
															PKG_SESSION.FSBGETTERMINAL, 		-- isbTerminal
															rcReverseOrder.exec_estimate_date,	-- idtExecutionDate
															NULL, 								-- isbRangeDescription
															NULL, 								-- inuProgramingClassId
															rcReverseOrder.operating_unit_id,	-- inuInitialOperUnitId
															rcReverseOrder.operating_unit_id,	-- inuFinalOperUnitId
															NULL,								-- inuCommentTypeId
															NULL								-- inuCausalId			
															);
	
		COMMIT;
	
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
	
	EXCEPTION
		WHEN pkg_Error.Controlled_Error THEN
			pkg_Error.getError(onuErrorCode, osbErrorMess);
			pkg_traza.trace('onuErrorCode: ' || onuErrorCode || ', ' || 'osbErrorMess: ' || osbErrorMess, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			RAISE PKG_ERROR.CONTROLLED_ERROR;
		WHEN others THEN
			Pkg_Error.seterror;
			pkg_error.geterror(onuErrorCode, osbErrorMess);
			pkg_traza.trace('onuErrorCode: ' || onuErrorCode || ', ' || 'osbErrorMess: ' || osbErrorMess, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE PKG_ERROR.CONTROLLED_ERROR;
	END prcReversarOrdenes;
			
END PKG_BOREVERSARORDENES;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_BOREVERSARORDENES'),'PERSONALIZACIONES'); 
END;
/