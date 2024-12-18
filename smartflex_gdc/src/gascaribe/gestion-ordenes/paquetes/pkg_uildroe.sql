CREATE OR REPLACE PACKAGE PKG_UILDROE
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_UILDROE </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 22-04-2024 </Fecha>
    <Descripcion> 
        Paquete del procedimiento LDROE
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
    FUNCTION fnuConsultarOrdenes
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
	
END PKG_UILDROE;
/
CREATE OR REPLACE PACKAGE BODY PKG_UILDROE
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_UILDROE </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 22-04-2024 </Fecha>
    <Descripcion> 
        Paquete del procedimiento LDROE
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
    FUNCTION fnuConsultarOrdenes
	RETURN CONSTANTS_PER.TYREFCURSOR
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fnuConsultarOrdenes';
		
		nuError				NUMBER;  
		sbmensaje			VARCHAR2(1000);  
		sbPACKAGE_ID        ge_boInstanceControl.stysbValue;     --Numero de solicitud
		sbORDER_ID          ge_boInstanceControl.stysbValue;     --Numero de la orden
		RFSELECT            CONSTANTS_PER.TYREFCURSOR;               -- Tipo de variable que devuelve los objetos en el pb LDRoe
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		--carga el numero de solicitud de la instancia
		sbPACKAGE_ID := ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGES', 'PACKAGE_ID');
		pkg_traza.trace('sbPACKAGE_ID: ' || sbPACKAGE_ID, cnuNVLTRC);
		
		--carga el numero de la orden de la instancia
		sbORDER_ID := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'ORDER_ID');
		pkg_traza.trace('sbORDER_ID: ' || sbORDER_ID, cnuNVLTRC);
		
		RFSELECT := pkg_boreversarordenes.fnuConsultarOrdenes(sbPACKAGE_ID,
															  sbORDER_ID
															  );		
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN RFSELECT;

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			RAISE PKG_ERROR.CONTROLLED_ERROR;
		WHEN others THEN
			Pkg_Error.seterror;
			pkg_error.geterror(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE PKG_ERROR.CONTROLLED_ERROR;
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

		nuSecuenciaOrderStatChange	NUMBER;
		rcReverseOrder				pkg_or_order.styOR_order;
	
	BEGIN

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

		pkg_traza.trace('sbORDER_ID ['||isbPk||']', cnuNVLTRC);

		pkg_boreversarordenes.prcReversarOrdenes(isbPk,
												 inuCurrent,
												 inuTotal,
												 onuErrorCode,
												 osbErrorMess
												 );
	
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
			
END PKG_UILDROE;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_UILDROE'),'OPEN'); 
END;
/