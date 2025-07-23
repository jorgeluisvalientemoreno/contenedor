CREATE OR REPLACE PACKAGE adm_person.pkg_ldc_conttsfa IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_ldc_conttsfa
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   29/01/2025
    Descripcion :   Paquete para acceso a datos de la tabla ldc_conttsfa
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     29/01/2025  OSF-3893 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Actualiza el estado de un registro por medio del rowid
    PROCEDURE prActEstadoPorRowId
    (
        irwRowId    IN  ROWID,
        isbEstado   IN  ldc_conttsfa.estado%TYPE
    );


END pkg_ldc_conttsfa;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldc_conttsfa IS

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
    Fecha           : 29/01/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     29/01/2025  OSF-3893 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prActEstadoPorRowId 
    Descripcion     : Actualiza el estado de un registro por medio del rowid
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 29/01/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     29/01/2025  OSF-3893 Creacion
    ***************************************************************************/                     
    PROCEDURE prActEstadoPorRowId
    (
        irwRowId    IN  ROWID,
        isbEstado   IN  ldc_conttsfa.estado%TYPE
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prActEstadoPorRowId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        UPDATE LDC_CONTTSFA 
        SET estado = isbEstado 
        WHERE ROWID = irwRowId;

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
    END prActEstadoPorRowId;
      
END pkg_ldc_conttsfa;
/
Prompt Otorgando permisos sobre adm_person.pkg_ldc_conttsfa
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_ldc_conttsfa'), 'ADM_PERSON');
END;
/