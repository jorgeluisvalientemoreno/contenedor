CREATE OR REPLACE PACKAGE adm_person.pkg_ldc_solianeco IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_ldc_solianeco
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   27/01/2025
    Descripcion :   Paquete para acceso a los datos de la tabla ldc_solianeco
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     27/01/2025  OSF-3893 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Inserta un registro en ldc_solianeco
    PROCEDURE prInsRegistro
    (
        inuSolicitud            IN  ldc_solianeco.solicitud%TYPE,
        inuProducto             IN  ldc_solianeco.producto%TYPE,
        inuDireccion            IN  ldc_solianeco.direccion%TYPE,
        inuContrato             IN  ldc_solianeco.contrato%TYPE,
        idtFecha_Registro       IN  ldc_solianeco.fecha_registro%TYPE DEFAULT SYSDATE,
        isbUsuario_Registra     IN  ldc_solianeco.usuario_registra%TYPE DEFAULT USER,
        isbTerminal_Registra    IN  ldc_solianeco.terminal_registra%TYPE DEFAULT USERENV('TERMINAL')
    );
    
    -- Actualiza el estado del registro de la solicitud
    PROCEDURE prActEstado
    (
        inuSolicitud            IN  ldc_solianeco.solicitud%TYPE,
        isbEstado               IN  ldc_solianeco.estado%TYPE,
        idtFecha_Procesado      IN  ldc_solianeco.fecha_procesado%TYPE DEFAULT SYSDATE,
        isbUsuario_Procesa      IN  ldc_solianeco.usuario_procesa%TYPE DEFAULT USER,
        isbTerminal_Procesa     IN  ldc_solianeco.terminal_procesa%TYPE DEFAULT USERENV('TERMINAL')
    ); 
    
    -- Actualiza la observacion del registro de la solicitud
    PROCEDURE prActObservacion
    (
        inuSolicitud            IN  ldc_solianeco.solicitud%TYPE,
        isbObservacion          IN  ldc_solianeco.observacion%TYPE
    );
    
    -- Obtiene el estado de la solicitud en ldc_solianeco
    FUNCTION fsbObtEstadoSolicitud 
    (
        inuSolicitud            IN  ldc_solianeco.solicitud%TYPE
    )
    RETURN ldc_solianeco.estado%TYPE;

    -- Obtiene el producto de la solicitud en ldc_solianeco
    FUNCTION fnuObtProductoSolicitud 
    (
        inuSolicitud            IN  ldc_solianeco.solicitud%TYPE
    )
    RETURN ldc_solianeco.producto%TYPE;
        
END pkg_ldc_solianeco;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldc_solianeco IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3893';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 27/01/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     27/01/2025  OSF-3893 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prInsRegistro 
    Descripcion     : Inserta un registro en pr_component_retire
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 27/01/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     27/01/2025  OSF-3893 Creacion
    ***************************************************************************/                     
    PROCEDURE prInsRegistro
    (
        inuSolicitud            IN  ldc_solianeco.solicitud%TYPE,
        inuProducto             IN  ldc_solianeco.producto%TYPE,
        inuDireccion            IN  ldc_solianeco.direccion%TYPE,
        inuContrato             IN  ldc_solianeco.contrato%TYPE,
        idtFecha_Registro       IN  ldc_solianeco.fecha_registro%TYPE DEFAULT SYSDATE,
        isbUsuario_Registra     IN  ldc_solianeco.usuario_registra%TYPE DEFAULT USER,
        isbTerminal_Registra    IN  ldc_solianeco.terminal_registra%TYPE DEFAULT USERENV('TERMINAL')
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        INSERT INTO ldc_solianeco 
        (
            solicitud, 
            producto, 
            direccion, 
            contrato, 
            fecha_registro, 
            usuario_registra,
            terminal_registra
        )
        VALUES
        (
            inuSolicitud, 
            inuProducto, 
            inuDireccion, 
            inuContrato, 
            idtfecha_registro, 
            isbusuario_registra,
            isbterminal_registra
        );
                         
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
                       
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prInsRegistro;
    
    -- Actualiza el estado del registro de la solicitud
    PROCEDURE prActEstado
    (
        inuSolicitud            IN  ldc_solianeco.solicitud%TYPE,
        isbEstado               IN  ldc_solianeco.estado%TYPE,
        idtFecha_Procesado      IN  ldc_solianeco.fecha_procesado%TYPE DEFAULT SYSDATE,
        isbUsuario_Procesa      IN  ldc_solianeco.usuario_procesa%TYPE DEFAULT USER,
        isbTerminal_Procesa     IN  ldc_solianeco.terminal_procesa%TYPE DEFAULT USERENV('TERMINAL')
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prActEstado';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN  

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        UPDATE ldc_solianeco 
        SET estado          = isbEstado, 
        fecha_procesado     = idtFecha_Procesado,
        usuario_procesa     = isbUsuario_Procesa,
        terminal_procesa    = isbTerminal_Procesa
        WHERE solicitud     = inuSolicitud;    
              
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
                       
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prActEstado;

    -- Actualiza la observacion del registro de la solicitud
    PROCEDURE prActObservacion
    (
        inuSolicitud            IN  ldc_solianeco.solicitud%TYPE,
        isbObservacion          IN  ldc_solianeco.observacion%TYPE
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prActObservacion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN  

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);    

        UPDATE ldc_solianeco 
        SET observacion          = isbObservacion
        WHERE solicitud     = inuSolicitud;  
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
                       
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prActObservacion;

    -- Obtiene el estado de la solicitud en ldc_solianeco
    FUNCTION fsbObtEstadoSolicitud 
    (
        inuSolicitud            IN  ldc_solianeco.solicitud%TYPE
    )
    RETURN ldc_solianeco.estado%TYPE
    IS

        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtEstadoSolicitud';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                
        sbEstadoSolicitud   ldc_solianeco.estado%TYPE;
        
        CURSOR cuObtEstadoSolicitud
        IS
        SELECT estado
        FROM ldc_solianeco
        WHERE solicitud = inuSolicitud;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        OPEN cuObtEstadoSolicitud;
        FETCH cuObtEstadoSolicitud INTO  sbEstadoSolicitud;
        CLOSE  cuObtEstadoSolicitud;
            
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbEstadoSolicitud;
                       
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEstadoSolicitud;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEstadoSolicitud;
    END fsbObtEstadoSolicitud;
    
    -- Obtiene el producto de la solicitud en ldc_solianeco
    FUNCTION fnuObtProductoSolicitud 
    (
        inuSolicitud            IN  ldc_solianeco.solicitud%TYPE
    )
    RETURN ldc_solianeco.producto%TYPE
    IS

        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtProductoSolicitud';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                
        nuProductoSolicitud   ldc_solianeco.producto%TYPE;
        
        CURSOR cuObtProductoSolicitud
        IS
        SELECT producto
        FROM ldc_solianeco
        WHERE solicitud = inuSolicitud;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        OPEN cuObtProductoSolicitud;
        FETCH cuObtProductoSolicitud INTO  nuProductoSolicitud;
        CLOSE  cuObtProductoSolicitud;
            
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN nuProductoSolicitud;
                       
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuProductoSolicitud;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuProductoSolicitud;
    END fnuObtProductoSolicitud;        
                
END pkg_ldc_solianeco;
/

Prompt Otorgando permisos sobre adm_person.pkg_ldc_solianeco
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_ldc_solianeco'), 'ADM_PERSON');
END;
/

