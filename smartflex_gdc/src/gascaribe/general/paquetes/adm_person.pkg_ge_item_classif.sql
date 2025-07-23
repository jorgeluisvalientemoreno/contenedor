CREATE OR REPLACE PACKAGE adm_person.pkg_ge_item_classif IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_ge_item_classif
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   06/03/2025
    Descripcion :   Paquete
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     06/03/2025  OSF-4042    Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Retorna Y si la clasificación del item maneja Cantidad Asignada ( cupo )
    FUNCTION fsbManejaCantidadAsignada
    (
        inuClasificacionItem            IN  ge_item_classif.item_classif_id%TYPE
    )
    RETURN ge_item_classif.quota%TYPE;
    
END pkg_ge_item_classif;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ge_item_classif IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-4042';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 06/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     06/03/2025  OSF-4042 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbManejaCantidadAsignada 
    Descripcion     : Retorna Y si la clasificación del item maneja Cantidad 
                        Asignada ( cupo )
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 06/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     06/03/2025  OSF-4042 Creacion
    ***************************************************************************/                     
    FUNCTION fsbManejaCantidadAsignada
    (
        inuClasificacionItem            IN  ge_item_classif.item_classif_id%TYPE
    )
    RETURN ge_item_classif.quota%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbManejaCantidadAsignada';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        sbManejaCantidadAsignada    ge_item_classif.quota%TYPE;
        
        CURSOR cuManejaCantidadAsignada
        IS
        SELECT quota
        FROM ge_item_classif
        WHERE item_classif_Id = inuClasificacionItem;
        
        PROCEDURE prcCierraCursor
        IS

            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(70) := csbMetodo || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);        
        
        BEGIN
        
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
            
            IF cuManejaCantidadAsignada%ISOPEN THEN
                CLOSE cuManejaCantidadAsignada;
            END IF;
            
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);        
        
        END prcCierraCursor;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        OPEN cuManejaCantidadAsignada;
        FETCH cuManejaCantidadAsignada INTO sbManejaCantidadAsignada;
        CLOSE cuManejaCantidadAsignada;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbManejaCantidadAsignada;            
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN sbManejaCantidadAsignada;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN sbManejaCantidadAsignada;
    END fsbManejaCantidadAsignada;
      
END pkg_ge_item_classif;
/
Prompt Otorgando permisos sobre adm_person.pkg_ge_item_classif
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_ge_item_classif'), upper('adm_person'));
END;
/