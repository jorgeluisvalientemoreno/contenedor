CREATE OR REPLACE PACKAGE adm_person.pkg_ldc_infotspr IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_ldc_infotspr
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   28/01/2025
    Descripcion :   Paquete
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     28/01/2025  OSF-3893    Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Inserta un registro en ldc_infotspr
    PROCEDURE prInsRegistro
    (
        inuContratoPadre    IN  ldc_infotspr.CONTPADRE%TYPE,
        inuSolicitud        IN  ldc_infotspr.SOLIPRHI%TYPE,
        inuProductoHijo     IN  ldc_infotspr.PRODHIJO%TYPE,
        inuValorSaldo       IN  ldc_infotspr.VALOR_SALDO%TYPE,
        isbObservacion      IN  ldc_infotspr.OBSERVACION%TYPE,
        idtFechaProceso     IN  ldc_infotspr.FECHA_PROCESADO%TYPE DEFAULT SYSDATE,
        isbUsuarioProcesa   IN  ldc_infotspr.USUARIO_PROCESA%TYPE DEFAULT USER,
        isbTerminalProcesa  IN  ldc_infotspr.TERMINAL_PROCESA%TYPE DEFAULT USERENV('TERMINAL')
    );

END pkg_ldc_infotspr;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldc_infotspr IS

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
    Fecha           : 28/01/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     28/01/2025  OSF-3893 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prReferenciaCupon 
    Descripcion     : Inserta un registro en ldc_infotspr
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 28/01/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     28/01/2025  OSF-3893 Creacion
    ***************************************************************************/                     
    PROCEDURE prInsRegistro
    (
        inuContratoPadre    IN  ldc_infotspr.CONTPADRE%TYPE,
        inuSolicitud        IN  ldc_infotspr.SOLIPRHI%TYPE,
        inuProductoHijo     IN  ldc_infotspr.PRODHIJO%TYPE,
        inuValorSaldo       IN  ldc_infotspr.VALOR_SALDO%TYPE,
        isbObservacion      IN  ldc_infotspr.OBSERVACION%TYPE,
        idtFechaProceso     IN  ldc_infotspr.FECHA_PROCESADO%TYPE DEFAULT SYSDATE,
        isbUsuarioProcesa   IN  ldc_infotspr.USUARIO_PROCESA%TYPE DEFAULT USER,
        isbTerminalProcesa  IN  ldc_infotspr.TERMINAL_PROCESA%TYPE DEFAULT USERENV('TERMINAL')
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        INSERT INTO ldc_infotspr
        (
            CONTPADRE,
            SOLIPRHI,
            PRODHIJO,
            VALOR_SALDO,
            FECHA_PROCESADO,
            USUARIO_PROCESA,
            TERMINAL_PROCESA,
            OBSERVACION        
        )
        VALUES
        (
            inuContratoPadre    ,
            inuSolicitud        ,
            inuProductoHijo     ,
            inuValorSaldo       ,
            idtFechaProceso     ,
            isbUsuarioProcesa   ,
            isbTerminalProcesa  ,
            isbObservacion                          
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
      
END pkg_ldc_infotspr;
/
Prompt Otorgando permisos sobre adm_person.pkg_ldc_infotspr
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_ldc_infotspr'), 'ADM_PERSON');
END;
/