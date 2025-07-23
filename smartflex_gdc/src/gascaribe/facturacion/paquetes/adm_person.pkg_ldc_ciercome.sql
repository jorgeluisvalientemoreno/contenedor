CREATE OR REPLACE PACKAGE adm_person.pkg_ldc_ciercome IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_ldc_ciercome
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   25/02/2025
    Descripcion :   Paquete para acceso a datos de la tabla open.ldc_ciercome
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     25/02/2025  OSF-4042 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Retorna verdadero si la fecha esta dentro del cierre comercial actual
    FUNCTION fblFechaDentroCierreActual
    (
        idtFecha    IN DATE
    )
    RETURN BOOLEAN;

END pkg_ldc_ciercome;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldc_ciercome IS

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
    Fecha           : 25/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     25/02/2025  OSF-4042 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fblFechaDentroCierreActual 
    Descripcion     : Retorna verdadero si la fecha esta dentro del cierre 
                      comercial actual
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 25/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     25/02/2025  OSF-4042 Creacion
    ***************************************************************************/
    FUNCTION fblFechaDentroCierreActual
    (
        idtFecha    IN DATE
    )
    RETURN BOOLEAN
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblFechaDentroCierreActual';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        blFechaDentroCierreComerActual  BOOLEAN;

        --Se valida fechas de cierre
        CURSOR cuFechCierre IS
        SELECT 'X'
        FROM ldc_ciercome
        WHERE idtFecha BETWEEN CICOFEIN AND CICOFECH
        AND CICOANO = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'))
        AND CICOMES = TO_NUMBER(TO_CHAR(SYSDATE, 'MM'));
        
        sbCierre   VARCHAR2(1); 
        
        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(70) := csbMetodo || 'prcCierraCursor';
            nuError         NUMBER;
            sbError         VARCHAR2(4000);        
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
            
            IF cuFechCierre%ISOPEN THEN
                CLOSE cuFechCierre;
            END IF; 

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);        
            
        
        END prcCierraCursor;
               
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuFechCierre;
        FETCH cuFechCierre INTO sbCierre;
        CLOSE cuFechCierre;

        blFechaDentroCierreComerActual := sbCierre IS NOT NULL;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN blFechaDentroCierreComerActual;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN blFechaDentroCierreComerActual;   
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN blFechaDentroCierreComerActual;   
    END fblFechaDentroCierreActual;
      
END pkg_ldc_ciercome;
/
Prompt Otorgando permisos sobre adm_person.pkg_ldc_ciercome
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_ldc_ciercome'), upper('adm_person'));
END;
/