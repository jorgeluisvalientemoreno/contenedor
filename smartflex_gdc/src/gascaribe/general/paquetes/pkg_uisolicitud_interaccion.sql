CREATE OR REPLACE PACKAGE pkg_uisolicitud_interaccion
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_uisolicitud_interaccion </Unidad>
    <Autor> Paola Acosta</Autor>
    <Fecha> 27-12-2024 </Fecha>
    <Descripcion> 
        Paquete de gestión de flujos
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="27-12-2024" Inc="OSF-3755" Empresa="GDC">
               Creación
           </Modificacion>          
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /*****************************************************************
    Unidad      : fsbVersion
    Descripcion : Obtiene la version del paquete
    ******************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
    /*****************************************************************
    Unidad      : prcAccionTramite
    Descripcion : Accion del tramite 
    ******************************************************************/
    PROCEDURE prcAccionTramite;
    
END pkg_uisolicitud_interaccion;
/
CREATE OR REPLACE PACKAGE BODY pkg_uisolicitud_interaccion
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_uisolicitud_interaccion </Unidad>
    <Autor> Paola Acosta</Autor>
    <Fecha> 27-12-2024 </Fecha>
    <Descripcion> 
        Paquete de gestión de flujos
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="27-12-2024" Inc="OSF-3755" Empresa="GDC">
               Creación
           </Modificacion>       
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVersion          CONSTANT VARCHAR2(10) := 'OSF-3755';
    csbPqtNombre        CONSTANT VARCHAR2(100):= $$plsql_unit||'.';
    cnuNvlTraza         CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.fsbInicio;
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
  
    
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Paola.Acosta </Autor>
    <Fecha> 27-12-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="27-12-2024" Inc="OSF-3755" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcAccionTramite </Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha> 27-12-2024 </Fecha>
    <Descripcion> 
        Accion del tramite
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="27-12-2024" Inc="OSF-3755" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcAccionTramite    
    IS
		csbMtdName  VARCHAR2(70) := csbPqtNombre || 'prcAccionTramite';
        nuError		NUMBER;  		
		sbMensaje   VARCHAR2(1000);
        
        --variables
        nuSolicitudid		mo_packages.package_id%TYPE;
        
    BEGIN
		
		pkg_traza.trace(csbMtdName, cnuNvlTraza, csbInicio);
		
		ge_boInstance.getValue('MO_PACKAGES', 'PACKAGE_ID', nuSolicitudid); 
        
        pkg_boSolicitud_interaccion.prcAccionTramite(nuSolicitudid);
        
		pkg_traza.trace(csbPqtNombre, cnuNvlTraza, pkg_traza.csbfin);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTraza);
            pkg_traza.trace(csbPqtNombre, pkg_traza.cnuNivelTrzDef, pkg_traza.csbfin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTraza);
            pkg_traza.trace(csbPqtNombre, pkg_traza.cnuNivelTrzDef, pkg_traza.csbfin_err); 
            RAISE pkg_error.controlled_error;
    END prcAccionTramite;         
    
END pkg_uisolicitud_interaccion;
/
BEGIN
    pkg_utilidades.praplicarpermisos(UPPER('PKG_UISOLICITUD_INTERACCION'),'OPEN'); 
END;
/