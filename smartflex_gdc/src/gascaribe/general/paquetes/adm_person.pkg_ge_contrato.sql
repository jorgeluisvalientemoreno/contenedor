CREATE OR REPLACE PACKAGE adm_person.pkg_ge_contrato IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_ge_contrato
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   26/03/2025
    Descripcion :   Paquete para acceso a los datos de la tabla ge_contrato
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     26/03/2025  OSF-4010    Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Obtiene el Id del contratista asociado al contrato
    FUNCTION fnuObtId_Contratista
    (
        inuContrato            IN  ge_contrato.id_contrato%TYPE
    )
    RETURN ge_contrato.id_contratista%TYPE;


END pkg_ge_contrato;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ge_contrato IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-4010';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 26/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     26/03/2025  OSF-4010 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fnuObtId_Contratista 
    Descripcion     : Obtiene el Id del contratista asociado al contrato
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 26/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     26/03/2025  OSF-4010 Creacion
    ***************************************************************************/
    FUNCTION fnuObtId_Contratista
    (
        inuContrato            IN  ge_contrato.id_contrato%TYPE
    )
    RETURN ge_contrato.id_contratista%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtId_Contratista';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nuId_Contratista    ge_contrato.id_contratista%TYPE;
        
        CURSOR cuObtId_Contratista
        IS
        SELEct id_contratista
        FROM ge_contrato ct
        WHERE ct.id_contrato = inuContrato;
        
        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtId_Contratista';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);
            
            IF cuObtId_Contratista%ISOPEN THEN
                CLOSE cuObtId_Contratista;
            END IF;              

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);              
               
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError1,sbError1);        
                pkg_traza.trace('sbError1 => ' || sbError1, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERR);          
                pkg_error.setError;
                pkg_Error.getError(nuError1,sbError1);
                pkg_traza.trace('sbError1 => ' || sbError1, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
        END prcCierraCursor;    
                             
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuObtId_Contratista;
        FETCH cuObtId_Contratista INTO nuId_Contratista;
        CLOSE cuObtId_Contratista;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN nuId_Contratista;             
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN nuId_Contratista;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN nuId_Contratista;
    END fnuObtId_Contratista;
      
END pkg_ge_contrato;
/

Prompt Otorgando permisos sobre adm_person.pkg_ge_contrato
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_ge_contrato'), 'adm_person');
END;
/
Prompt Otorgando permisos a multiempresa sobre adm_person.pkg_ge_contrato
BEGIN
    EXECUTE IMMEDIATE ('grant execute on adm_person.pkg_ge_contrato to multiempresa');
END;
/

