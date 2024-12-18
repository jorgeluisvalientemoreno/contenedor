CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BOTRAMITEANULACION
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BOTRAMITEANULACION </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-02-2024 </Fecha>
    <Descripcion> 
        Paquete de anulación de solicitudes
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="27-02-2024" Inc="OSF-2374" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------


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
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcReversaEstadoProducto  </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-02-2024 </Fecha>
    <Descripcion> 
        Anula la solicitud de terminación de contrato
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="27-02-2024" Inc="OSF-2374" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcReversaEstadoProducto(inuSolicitudId	IN mo_packages.package_id%TYPE);
	
END PKG_BOTRAMITEANULACION;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BOTRAMITEANULACION
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BOTRAMITEANULACION </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-02-2024 </Fecha>
    <Descripcion> 
        Paquete de anulación de solicitudes
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="27-02-2024" Inc="OSF-2374" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-2374';
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
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
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
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcReversaEstadoProducto  </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-02-2024 </Fecha>
    <Descripcion> 
        Anula la solicitud de terminación de contrato
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="27-02-2024" Inc="OSF-2374" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
	PROCEDURE prcReversaEstadoProducto(inuSolicitudId	IN mo_packages.package_id%TYPE)
    IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'prcReversaEstadoProducto ';

        nuError					NUMBER;  
		nuSoliTerminaContraId	mo_packages.package_id%type;
		sbmensaje   			VARCHAR2(1000);
		
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
		
		-- Obtiene la solicitud de terminación de contrato
		nuSoliTerminaContraId := pkg_bctramiteanulacion.fnuSolTerminacionContrato(inuSolicitudId);
		pkg_traza.trace('nuSoliTerminaContraId: ' || nuSoliTerminaContraId, cnuNVLTRC);
		
		-- Reversa el estado del producto de la solicitud de terminación de contrato
		IF (nuSoliTerminaContraId IS NOT NULL) THEN
			pkg_traza.trace('Reversando el estado de los productos de la solicitud de terminación de contrato', cnuNVLTRC);
			pkg_gestion_producto.prcReversaEstadoProducto(nuSoliTerminaContraId);
		END IF;
        
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

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
    END prcReversaEstadoProducto ;
END PKG_BOTRAMITEANULACION;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_BOTRAMITEANULACION'),'PERSONALIZACIONES'); 
END;
/