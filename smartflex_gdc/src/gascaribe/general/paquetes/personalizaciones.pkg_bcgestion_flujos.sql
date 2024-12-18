CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BCGESTION_FLUJOS
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BCGESTION_FLUJOS </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 19-01-2024 </Fecha>
    <Descripcion> 
        Paquete de gestión de flujos
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="19-01-2024" Inc="OSF-1907" Empresa="GDC">
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
    <Fecha> 19-01-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="19-01-2024" Inc="OSF-1907" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcConsultarSolicitudInstancia  </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 19-01-2024 </Fecha>
    <Descripcion> 
        Obtiene el número de solicitud apartir de la instancia
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="19-01-2024" Inc="OSF-1907" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcConsultarSolicitudInstancia 
    (
        inuInstanciaId	IN  WF_INSTANCE.INSTANCE_ID%TYPE,
		onuSolicitudId	OUT mo_packages.package_id%type
    );
END PKG_BCGESTION_FLUJOS;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BCGESTION_FLUJOS
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BCGESTION_FLUJOS </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 19-01-2024 </Fecha>
    <Descripcion> 
        Paquete de gestión de flujos
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="19-01-2024" Inc="OSF-1907" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-1907';
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
    <Fecha> 19-01-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="19-01-2024" Inc="OSF-1907" Empresa="GDC"> 
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
    <Unidad> prcConsultarSolicitudInstancia  </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 19-01-2024 </Fecha>
    <Descripcion> 
        Anula el flujo para no realizar reenvio de peticiones
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="19-01-2024" Inc="OSF-1907" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcConsultarSolicitudInstancia 
    (
        inuInstanciaId	IN WF_INSTANCE.INSTANCE_ID%TYPE,
		onuSolicitudId	OUT mo_packages.package_id%type
    )
    IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'prcConsultarSolicitudInstancia ';

        nuError				NUMBER;  
		nuPackage_id		mo_packages.package_id%TYPE;
		sbmensaje   		VARCHAR2(1000);
		
		-- Cursor que obtiene la solicitud a partir de la instancia
		CURSOR cuSolicitudDeInstancia IS
		Select wde.package_id 
		from wf_instance wi, wf_data_external wde
		where instance_id 	= inuInstanciaId
		and wde.plan_id 	= wi.plan_id;
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuInstanciaId: ' || inuInstanciaId, cnuNVLTRC);
		
		IF(cuSolicitudDeInstancia%isopen) THEN
			CLOSE cuSolicitudDeInstancia;
		END IF;

		OPEN cuSolicitudDeInstancia;
		FETCH cuSolicitudDeInstancia INTO onuSolicitudId;
		CLOSE cuSolicitudDeInstancia;
	
		pkg_traza.trace('La solicitud asociada a la instancia ' || inuInstanciaId || ' es: ' || onuSolicitudId, cnuNVLTRC);
        
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.setError;
		pkg_Error.getError(nuError, sbmensaje);
		pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC); 
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
        pkg_Error.setError;
		pkg_Error.getError(nuError, sbmensaje);
		pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR); 
		RAISE pkg_Error.Controlled_Error;
    END prcConsultarSolicitudInstancia ;
END PKG_BCGESTION_FLUJOS;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_BCGESTION_FLUJOS'),'PERSONALIZACIONES'); 
END;
/