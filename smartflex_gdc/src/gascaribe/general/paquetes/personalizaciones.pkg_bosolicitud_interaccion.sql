CREATE OR REPLACE PACKAGE personalizaciones.pkg_bosolicitud_interaccion IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BOSOLICITUD_INTERACCION </Unidad>
    <Autor> Paola Acosta</Autor>
    <Fecha> 26-12-2024 </Fecha>
    <Descripcion> 
        Paquete de gestión de flujos
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="26-12-2024" Inc="OSF-3755" Empresa="GDC">
               Creación
           </Modificacion>   
           <Modificacion Autor="Paola.Acosta" Fecha="18-02-2025" Inc="OSF-4020" Empresa="GDC">
               Modificacion metodo: fnuValEnvioRtaElect
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
    FUNCTION fsbVersion RETURN VARCHAR2;  
    
    /*****************************************************************
    Unidad      : prcAccionTramite
    Descripcion : Accion del tramite 
    ******************************************************************/
    PROCEDURE prcAccionTramite(
        inuIdSolicitud IN mo_packages.package_id%TYPE
    ); 
    
    /*****************************************************************
    Unidad      : fnuValEnvioRtaElect
    Descripcion : Indica si el tipo de respuesta electrónica se
                  encuentra en el parámetro <MED_REC_ENVIO_RESPUESTA_ELECTRONICA>, atributo TIPO_RTA. 
    ******************************************************************/
    FUNCTION fnuValEnvioRtaElect (
        inuIdSolicitud IN mo_packages.package_id%TYPE
    ) RETURN NUMBER;
    
    /*****************************************************************
    Unidad      : fnuIniValorFlagValidate
    Descripcion : Función asociada al atributo FLAG_VALIDATE del Flujo de Respuesta de Interacción                 
    ******************************************************************/
    FUNCTION fnuIniValorFlagValidate(
        inuSolicitudPadre IN mo_packages.cust_care_reques_num%TYPE)    
    RETURN NUMBER;

END pkg_bosolicitud_interaccion;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bosolicitud_interaccion IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BOSOLICITUD_INTERACCION </Unidad>
    <Autor> Paola Acosta</Autor>
    <Fecha> 26-12-2024 </Fecha>
    <Descripcion> 
        Paquete de gestión de flujos
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="26-12-2024" Inc="OSF-3755" Empresa="GDC">
               Creación
           </Modificacion>       
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVersion   CONSTANT VARCHAR2(10) := 'OSF-3755';
    csbPqtNombre CONSTANT VARCHAR2(100) := $$plsql_unit || '.';
    cnuNvlTraza  CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
    csbInicio    CONSTANT VARCHAR2(35) := pkg_traza.fsbinicio;
    
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
    <Fecha> 26-12-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="26-12-2024" Inc="OSF-3755" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuValEnvioRtaElect </Unidad>
    <Autor> Paola Acosta</Autor>
    <Fecha> 26-12-2024 </Fecha>
    <Descripcion> 
        Función que retorna si el tipo de respuesta electrónica se
        encuentra en el parámetro <MED_REC_ENVIO_RESPUESTA_ELECTRONICA>.        
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="26-12-2024" Inc="OSF-3755" Empresa="GDC">
               Creacion: proceso migrado del paquete ld_bortainteraccion.fnuValEnvioRtaElect
           </Modificacion>           
           <Modificacion Autor="Paola.Acosta" Fecha="18-02-2025" Inc="OSF-4020" Empresa="GDC">
               Se retiran las concatenaciones de pieline (|) d elas variables v y sbTipoRecepcion
           </Modificacion>  
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fnuValEnvioRtaElect (
        inuIdSolicitud IN mo_packages.package_id%TYPE
    ) RETURN NUMBER IS

        csbMtdName      VARCHAR2(70) := csbPqtNombre || 'fnuValEnvioRtaElect';
        nuError         NUMBER;
        sbMensaje       VARCHAR2(1000);
        
        --Variables
        sbParametro     parametros.codigo%TYPE := 'MED_REC_ENVIO_RESPUESTA_ELECTRONICA';    
        sbSeparador     VARCHAR2(10) := '|';
        sbTipoRecepcion VARCHAR2(100);
    BEGIN
        pkg_traza.trace(csbMtdName, cnuNvlTraza, csbInicio);
                
        pkg_traza.trace('sbParametro: ' || sbParametro, cnuNvlTraza);
        
        sbTipoRecepcion := to_char(pkg_bcsolicitudes.fnuGetMedioRecepcion(inuIdSolicitud));   
        
        pkg_traza.trace('sbTipoRecepcion: ' || sbTipoRecepcion, cnuNvlTraza);
        
        IF pkg_parametros.fnuValidaSiExisteCadena(sbParametro,sbSeparador,sbTipoRecepcion) > 0 THEN        
            pkg_traza.trace('Retorna 1', cnuNvlTraza);
            pkg_traza.trace(csbPqtNombre, cnuNvlTraza, pkg_traza.csbfin);
            RETURN pkg_bogestion_flujos.cnuExito;
        ELSE
            pkg_traza.trace('Retorna 0', cnuNvlTraza);
            pkg_traza.trace(csbPqtNombre, cnuNvlTraza, pkg_traza.csbfin);
            RETURN pkg_bogestion_flujos.cnuFallo;
        END IF;
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: '|| nuError ||' sbMensaje: '|| sbMensaje, cnuNvlTraza);
            pkg_traza.trace(csbPqtNombre, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin_erc);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: '|| nuError ||' sbMensaje: '|| sbMensaje, cnuNvlTraza);
            pkg_traza.trace(csbPqtNombre, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin_err);
            RAISE pkg_error.controlled_error;
    END fnuValEnvioRtaElect;    
       
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prRegistraInteraSinFlujo </Unidad>
    <Autor> Paola Acosta</Autor>
    <Fecha> 26-12-2024 </Fecha>
    <Descripcion> 
        procedimiento que recibe una solicitud de Interaccion y la marca en la tabla
        ldc_interaccion_sin_flujo para indicar que es una solicitud sin flujo y se debe
        atender manualmente. Para atenderlas se crea el servicio LDC_prJobInteraccionSinFlujo
        que se programa mediate job
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola Acosta" Fecha="26-12-2024" Inc="OSF-3755" Empresa="GDC">
               Creacion: migración objeto de ld_bortainteraccion.prRegistraInteraSinFlujo 
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prRegistraInteraSinFlujo (
        inuIdSolicitud IN mo_packages.package_id%TYPE
    ) IS

        csbMtdName         VARCHAR2(70) := csbPqtNombre || 'prRegistraInteraSinFlujo';
        nuError            NUMBER;
        sbMensaje          VARCHAR2(1000);
        
        --Constantes
        cnuTipoSolicitud   CONSTANT mo_packages.package_type_id%TYPE := 268;
        
        --Variables
        nuTipoSolicitud    mo_packages.package_type_id%TYPE;
        rcInterAccSinFlujo pkg_ldc_interaccion_sin_flujo.culdc_interaccion_sin_flujo%rowtype;
    BEGIN
        pkg_traza.trace(csbMtdName, cnuNvlTraza, csbInicio);
        nuTipoSolicitud := pkg_bcsolicitudes.fnuGetTipoSolicitud(inuIdSolicitud);
        IF nuTipoSolicitud = cnuTipoSolicitud THEN
            rcInterAccSinFlujo.package_id := inuIdSolicitud;
            rcInterAccSinFlujo.parcial := 'N';
            rcInterAccSinFlujo.procesado := 'N';
            rcInterAccSinFlujo.created_at := sysdate;
            rcInterAccSinFlujo.update_at := NULL;
            pkg_ldc_interaccion_sin_flujo.prInsRegistro(rcInterAccSinFlujo);
        ELSE
            pkg_error.setErrorMessage(isbMsgErrr => 'El tipo de solicitud no es ' || cnuTipoSolicitud);           
        END IF;

        pkg_traza.trace(csbPqtNombre, cnuNvlTraza, pkg_traza.csbfin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: '|| nuError ||' sbMensaje: '|| sbMensaje, cnuNvlTraza);
            pkg_traza.trace(csbPqtNombre, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin_erc);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: '|| nuError ||' sbMensaje: '|| sbMensaje, cnuNvlTraza);
            pkg_traza.trace(csbPqtNombre, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin_err);
            RAISE pkg_error.controlled_error;
    END prRegistraInteraSinFlujo;
    
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
    PROCEDURE prcAccionTramite(inuIdSolicitud IN mo_packages.package_id%TYPE)    
    IS
		csbMtdName  VARCHAR2(70) := csbPqtNombre || 'prcAccionTramite';
        nuError		NUMBER;  		
		sbMensaje   VARCHAR2(1000);
        
        nuResElectronica    NUMBER;
        nuTipoRecepEscrito  NUMBER;
        nuSolPermitidaInter NUMBER;
        
              
    BEGIN
		
		pkg_traza.TRACE(csbMtdName, cnuNvlTraza, csbInicio);
		
        nuResElectronica := fnuValEnvioRtaElect(inuIdSolicitud);
        
        nuTipoRecepEscrito := pkg_bcsolicitud_interaccion.fnuValTipoRecepcionEscrito(inuIdSolicitud);
        
        nuSolPermitidaInter := pkg_bcsolicitud_interaccion.fnuTipSolPerInteraccion(inuIdSolicitud);
        
        IF nuTipoRecepEscrito = 0  AND nuResElectronica = 0 AND nuSolPermitidaInter = 0 THEN
            prRegistraInteraSinFlujo(inuIdSolicitud);    
        ELSE
            pkg_bogestion_flujos.prcCrearFlujo;
        END IF;
        
		pkg_traza.TRACE(csbPqtNombre, cnuNvlTraza, pkg_traza.csbfin);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.TRACE('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTraza);
            pkg_traza.TRACE(csbPqtNombre, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.TRACE('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTraza);
            pkg_traza.TRACE(csbPqtNombre, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin_err); 
            RAISE pkg_error.controlled_error;
    END prcAccionTramite;  
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcAccionTramite </Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha> 27-12-2024 </Fecha>
    <Descripcion> 
        Función asociada al atributo FLAG_VALIDATE del Flujo de Respuesta de Interacción   
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="27-12-2024" Inc="OSF-3755" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fnuIniValorFlagValidate(inuSolicitudPadre IN mo_packages.cust_care_reques_num%TYPE)    
    RETURN NUMBER
    IS
		csbMtdName  VARCHAR2(70) := csbPqtNombre || 'fnuIniValorFlagValidate';
        nuError		NUMBER;  		
		sbMensaje   VARCHAR2(1000);
        
        --variables
        nuEsEscrito NUMBER; 
        onuRespuesta NUMBER;
              
    BEGIN
		
		pkg_traza.TRACE(csbMtdName, cnuNvlTraza, csbInicio);
		
        nuEsEscrito := pkg_bcsolicitud_interaccion.fnuValTipoRecepcionEscrito(inuSolicitudPadre);
        
        IF nuEsEscrito = 0 THEN
            onuRespuesta := pkg_bcsolicitud_interaccion.fnuValTipoSolUniOpeCau(inuSolicitudPadre);
        ELSE 
            onuRespuesta := nuEsEscrito;
        END IF;
        
        pkg_traza.TRACE(csbPqtNombre, cnuNvlTraza, pkg_traza.csbfin);        
        
        RETURN onuRespuesta;	

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.TRACE('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTraza);
            pkg_traza.TRACE(csbPqtNombre, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.TRACE('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTraza);
            pkg_traza.TRACE(csbPqtNombre, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin_err); 
            RAISE pkg_error.controlled_error;
    END fnuIniValorFlagValidate;  

END pkg_bosolicitud_interaccion;
/

BEGIN
    pkg_utilidades.praplicarpermisos(upper('PKG_BOSOLICITUD_INTERACCION'), 'PERSONALIZACIONES');
END;
/