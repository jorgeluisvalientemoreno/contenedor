CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcldcidema IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_bcldcidema
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   25/04/2025
    Descripcion :   Paquete con las consultas usadas en la forma LDCIDEMA
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     25/04/2025  OSF-4259 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Retorna el contratista asociado al documento SAP
    FUNCTION fnuObtContratistaDocSAP
    (
        isbDocumentoSAP IN ldci_intemmit.mmitdsap%TYPE
    )
    RETURN ldci_transoma.trsmcont%TYPE;

END pkg_bcldcidema;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcldcidema IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-4259';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 25/04/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     25/04/2025  OSF-4259 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fnuObtContratistaDocSAP 
    Descripcion     : Retorna el contratista asociado al documento SAP
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 25/04/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     25/04/2025  OSF-4259 Creacion
    ***************************************************************************/                     
    FUNCTION fnuObtContratistaDocSAP
    (
        isbDocumentoSAP IN ldci_intemmit.mmitdsap%TYPE
    )
    RETURN ldci_transoma.trsmcont%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtContratistaDocSAP';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        CURSOR cuObtContratistaDocSAP
        IS
        SELECT  dema.trsmcont
        FROM    ldci_intemmit sap, ldci_transoma dema 
        WHERE   sap.mmitnupe like '%-'|| dema.trsmcodi 
        AND     sap.mmitdsap = isbDocumentoSAP
        AND     dema.trsmtipo = 1 
        AND     rownum < 2;
        
        nuContratistaDocSAP ldci_transoma.trsmcont%TYPE;

        PROCEDURE prcCierraCursor
        IS

            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(105) := csbMetodo || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);

        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
            
            IF cuObtContratistaDocSAP%ISOPEN THEN
                CLOSE cuObtContratistaDocSAP;
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
        
        OPEN cuObtContratistaDocSAP;
        FETCH cuObtContratistaDocSAP INTO nuContratistaDocSAP;
        prcCierraCursor;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);              
        
        RETURN nuContratistaDocSAP;
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN nuContratistaDocSAP;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN nuContratistaDocSAP;
    END fnuObtContratistaDocSAP;
      
END pkg_bcldcidema;
/
Prompt Otorgando permisos sobre personalizaciones.pkg_bcldcidema
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_bcldcidema'), upper('personalizaciones'));

    EXECUTE immediate ('GRANT EXECUTE ON personalizaciones.pkg_bcldcidema TO multiempresa');
END;
/