CREATE OR REPLACE PACKAGE adm_person.pkg_concilia IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_concilia
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   10/02/2025
    Descripcion :   Paquete
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     10/02/2025  OSF-3893 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Obtiene una conciliacion bancaria abierta
    FUNCTION fnuObtConcilacionAbierta
    (
        inuBanco     IN      concilia.concbanc%TYPE,
        idtFechaPago  IN      concilia.concfepa%TYPE
    )
    RETURN concilia.conccons%TYPE;

END pkg_concilia;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_concilia IS

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
    Fecha           : 10/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     10/02/2025  OSF-3893 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fnuObtConcilacionAbierta 
    Descripcion     : Retorna una tabla pl con los diferidos con saldo del contrato
                      que tengan plan de alivio por contingencia
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 10/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     10/02/2025  OSF-3893 Creacion
    ***************************************************************************/                     
    FUNCTION fnuObtConcilacionAbierta
    (
        inuBanco     IN      concilia.concbanc%TYPE,
        idtFechaPago  IN      concilia.concfepa%TYPE
    )
    RETURN concilia.conccons%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtConcilacionAbierta';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nuConcilacionAbierta    concilia.conccons%TYPE;
        
        CURSOR cuConcilacionAbierta IS
        SELECT CONCCONS
        FROM concilia
        WHERE CONCBANC = inuBanco
        AND TRUNC(CONCFEPA) >= TRUNC(idtFechaPago)
        AND CONCCIAU = 'S'
        AND CONCFLPR = 'N';        
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuConcilacionAbierta;
        FETCH cuConcilacionAbierta INTO nuConcilacionAbierta;
        CLOSE cuConcilacionAbierta;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

        RETURN nuConcilacionAbierta;
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuConcilacionAbierta;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuConcilacionAbierta;
    END fnuObtConcilacionAbierta;
      
END pkg_concilia;
/
Prompt Otorgando permisos sobre adm_person.pkg_concilia
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_concilia'), 'adm_person');
END;
/