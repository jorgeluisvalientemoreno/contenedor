CREATE OR REPLACE PACKAGE adm_person.pkg_ge_items_documento IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_ge_items_documento
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   14/04/2025
    Descripcion :   Paquete
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     14/04/2025  OSF-4245 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Obtiene la unida operativa destino del documento del material
    FUNCTION fnuObtUnidOperDestino
    (
        inuDocumentoItem IN  ge_items_documento.id_items_documento%TYPE
    )
    RETURN ge_items_documento.destino_oper_uni_id%TYPE;

END pkg_ge_items_documento;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ge_items_documento IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-4245';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 14/04/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     14/04/2025  OSF-4245 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fnuObtUnidOperDestino 
    Descripcion     : Obtiene la unida operativa destino del documento del 
                        material
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 14/04/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     14/04/2025  OSF-4245 Creacion
    ***************************************************************************/
    FUNCTION fnuObtUnidOperDestino
    (
        inuDocumentoItem IN  ge_items_documento.id_items_documento%TYPE
    )
    RETURN ge_items_documento.destino_oper_uni_id%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtUnidOperDestino';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nuUnidOperDestino   ge_items_documento.destino_oper_uni_id%TYPE;
        
        CURSOR cuObtUnidOperDestino
        IS
        SELECT destino_oper_uni_id
        FROM ge_items_documento
        WHERE id_items_documento = inuDocumentoItem;
        
        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(70) := csbMetodo || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);        
        BEGIN
        
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
            
            IF cuObtUnidOperDestino%ISOPEN THEN
                CLOSE cuObtUnidOperDestino;
            END IF;

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);          

        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError1,sbError1);        
                pkg_traza.trace('sbError1 => ' || sbError1, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.setError; 
                pkg_Error.getError(nuError1,sbError1);        
                pkg_traza.trace('sbError1 => ' || sbError1, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;      
        END prcCierraCursor;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuObtUnidOperDestino;
        FETCH cuObtUnidOperDestino INTO nuUnidOperDestino;
        CLOSE cuObtUnidOperDestino;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);              
           
        RETURN nuUnidOperDestino;
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN nuUnidOperDestino;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;            
            RETURN nuUnidOperDestino;
    END fnuObtUnidOperDestino;

END pkg_ge_items_documento;
/
Prompt Otorgando permisos sobre adm_person.pkg_ge_items_documento
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_ge_items_documento'), upper('adm_person'));
END;
/