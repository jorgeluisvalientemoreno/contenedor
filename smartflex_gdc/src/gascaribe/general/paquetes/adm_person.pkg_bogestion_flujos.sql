CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_BOGESTION_FLUJOS
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BOGESTION_FLUJOS </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 19-01-2024 </Fecha>
    <Descripcion> 
        Paquete de gestión de flujos
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="19-01-2024" Inc="OSF-1907" Empresa="GDC">
               Creación
           </Modificacion>
           <Modificacion Autor="PAcosta" Fecha="23-12-2024" Inc="OSF-3786" Empresa="GDC">
               Cambio de esquema de personalizaciones de adm_person
               Cracion metodo prcCrearFlujo
               Creación constantes cnuExito y cnuFallo
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
    <Unidad> prcAnulaFlujo </Unidad>
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
    PROCEDURE prcAnulaFlujo
    (
        inuInstanciaId	IN WF_INSTANCE.INSTANCE_ID%TYPE
    );
    
    /*****************************************************************
    Unidad      : prcCrearFlujo
    Descripcion : Creación de Plan en WF
    ******************************************************************/
    PROCEDURE prcCrearFlujo;
    
    /*****************************************************************
    Unidad      : cnuExito
    Descripcion : Constante de exito 
    ******************************************************************/
    cnuExito CONSTANT NUMBER := 1;
    
    /*****************************************************************
    Unidad      : cnuFallo
    Descripcion : Constante de fallo 
    ******************************************************************/
    cnuFallo CONSTANT NUMBER := 0;
    
END PKG_BOGESTION_FLUJOS;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_BOGESTION_FLUJOS
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BOGESTION_FLUJOS </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 19-01-2024 </Fecha>
    <Descripcion> 
        Paquete de gestión de flujos
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="19-01-2024" Inc="OSF-1907" Empresa="GDC">
               Creación
           </Modificacion>
           <Modificacion Autor="PAcosta" Fecha="23-12-2024" Inc="OSF-3786" Empresa="GDC">
               Cambio de esquema de personalizaciones de adm_person
               Cracion metodo prcCrearFlujo
               Creación constantes cnuExito y cnuFallo
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
    gsbErrMsg           GE_ERROR_LOG.DESCRIPTION%TYPE;
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
    <Unidad> prcAnulaFlujo </Unidad>
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
    PROCEDURE prcAnulaFlujo
    (
        inuInstanciaId	IN WF_INSTANCE.INSTANCE_ID%TYPE
    )
    IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'prcAnulaFlujo';

        nuError				NUMBER;  
		nuSolicitudId		mo_packages.package_id%type;
		sbmensaje   		VARCHAR2(1000);
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuInstanciaId: ' || inuInstanciaId, cnuNVLTRC);
		
		pkgmanejosolicitudes.prcAnulaFlujo(inuInstanciaId);
		
		PKG_BCGESTION_FLUJOS.prcConsultarSolicitudInstancia(inuInstanciaId,
															nuSolicitudId
															);
		
		pkgmanejosolicitudes.pannulerrorflow(nuSolicitudId);
        
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
    END prcAnulaFlujo;    
       
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcCrearFlujo </Unidad>
    <Autor> Paola Acosta</Autor>
    <Fecha> 23-12-2024 </Fecha>
    <Descripcion> 
        Creación de Plan en WF
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola Acosta" Fecha="23-12-2024" Inc="OSF-3786" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcCrearFlujo    
    IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'prcCrearFlujo';

        nuError				NUMBER;  		
		sbmensaje   		VARCHAR2(1000);
        
    BEGIN		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		mo_boactioncreateplanwf.processaction;
        
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
    END prcCrearFlujo;    
        
    
END PKG_BOGESTION_FLUJOS;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_BOGESTION_FLUJOS'),'ADM_PERSON'); 
END;
/