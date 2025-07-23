CREATE OR REPLACE PACKAGE adm_person.pkg_pr_component_retire IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_pr_component_retire
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   27/01/2025
    Descripcion :   Paquete de acceso a los datos de la tabla pr_component_retire
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     27/01/2025  OSF-3893 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Inserta un registro en pr_component_retire
    PROCEDURE prInsRegistro
    (
        inuComponente       IN  pr_component_retire.component_id%TYPE, 
        inuTipoRetiro       IN  pr_component_retire.retire_type_id%TYPE DEFAULT 2, 
        idtFechaRetiro      IN  pr_component_retire.retire_date%TYPE DEFAULT to_date('31/12/4732 23:59:59', 'dd/mm/yyyy hh24:mi:ss'), 
        idtFechaRegistro    IN  pr_component_retire.register_date%TYPE DEFAULT SYSDATE,
        isbRetiroIndividual IN  pr_component_retire.individual_retire%TYPE DEFAULT 'Y'
    );

END pkg_pr_component_retire;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_pr_component_retire IS

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
        inuComponente       IN  pr_component_retire.component_id%TYPE, 
        inuTipoRetiro       IN  pr_component_retire.retire_type_id%TYPE DEFAULT 2, 
        idtFechaRetiro      IN  pr_component_retire.retire_date%TYPE DEFAULT to_date('31/12/4732 23:59:59', 'dd/mm/yyyy hh24:mi:ss'), 
        idtFechaRegistro    IN  pr_component_retire.register_date%TYPE DEFAULT SYSDATE,
        isbRetiroIndividual IN  pr_component_retire.individual_retire%TYPE DEFAULT 'Y'
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        INSERT INTO Pr_Component_Retire 
        (
            COMPONENT_RETIRE_ID, 
            COMPONENT_ID, 
            RETIRE_TYPE_ID, 
            RETIRE_DATE, 
            REGISTER_DATE, 
            INDIVIDUAL_RETIRE
        )
        VALUES
        (
            seq_pr_component_retire.NextVal, 
            inuComponente,
            inuTipoRetiro, 
            idtFechaRetiro, 
            idtFechaRegistro,
            isbRetiroIndividual
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
      
END pkg_pr_component_retire;
/
Prompt Otorgando permisos sobre adm_person.pkg_pr_component_retire
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_pr_component_retire'), 'ADM_PERSON');
END;
/