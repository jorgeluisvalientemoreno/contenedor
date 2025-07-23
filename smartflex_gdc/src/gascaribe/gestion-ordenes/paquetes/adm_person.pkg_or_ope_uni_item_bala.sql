CREATE OR REPLACE PACKAGE adm_person.pkg_or_ope_uni_item_bala IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_or_ope_uni_item_bala
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   26/02/2025
    Descripcion :   Paquete para acceso a los datos de or_ope_uni_item_bala
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     26/02/2025  OSF-4042 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Retorna verdadero si existe el item asociado la unidad operativa
    FUNCTION fblExisteItemEnUnidadOper
    (
        inuItem             IN  or_ope_uni_item_bala.items_id%TYPE,
        inuUnidadOperativa  IN  or_ope_uni_item_bala.operating_unit_id%TYPE
    )
    RETURN BOOLEAN;
    
    -- Retorna la cantidad disponible del item en la unidad operativa
    FUNCTION fnuObtieneCantDisponible
    (
        inuItem             IN  or_ope_uni_item_bala.items_id%TYPE,
        inuUnidadOperativa  IN  or_ope_uni_item_bala.operating_unit_id%TYPE
    )
    RETURN or_ope_uni_item_bala.balance%TYPE;
    
    -- Se actualiza el costo total y la cantidad disponible
    PROCEDURE prcActCostoTotalYcantDispo
    (
        inuItem                     IN  or_ope_uni_item_bala.items_id%TYPE,
        inuUnidadOperativa          IN  or_ope_uni_item_bala.operating_unit_id%TYPE,
        inuValorAfectCostoTotal     IN  or_ope_uni_item_bala.total_costs%TYPE,
        inuCantAfectCantDisponible  IN  or_ope_uni_item_bala.balance%TYPE
    );


    -- Obtiene el costo toral del item en la unidad operativa
    FUNCTION fnuObtieneCostoTotal
    (
        inuItem             IN  or_ope_uni_item_bala.items_id%TYPE,
        inuUnidadOperativa  IN  or_ope_uni_item_bala.operating_unit_id%TYPE
    )
    RETURN or_ope_uni_item_bala.total_costs%TYPE;
    
    -- Inserta un registro en la tabla or_ope_uni_item_bala
    PROCEDURE prcInsRegistro
    (
        inuItem                 IN  or_ope_uni_item_bala.items_id%TYPE,
        inuUnidaOperativa       IN  or_ope_uni_item_bala.operating_unit_id%TYPE,
        inuCantidadAsignada     IN  or_ope_uni_item_bala.quota%TYPE,
        inuCantidadDisponible   IN  or_ope_uni_item_bala.balance%TYPE,
        inuCostoTotal           IN  or_ope_uni_item_bala.total_costs%TYPE,
        inuCantidadOcacional    IN  or_ope_uni_item_bala.occacional_quota%TYPE,
        inuCantidadEntrando     IN  or_ope_uni_item_bala.transit_in%TYPE,
        inuCantidadSaliendo     IN  or_ope_uni_item_bala.transit_out%TYPE
    );

    -- Obtiene el costo toral del item en la unidad operativa
    PROCEDURE prcBorraItemEnUnidadOper
    (
        inuItem             IN  or_ope_uni_item_bala.items_id%TYPE,
        inuUnidadOperativa  IN  or_ope_uni_item_bala.operating_unit_id%TYPE
    );
    
END pkg_or_ope_uni_item_bala;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_or_ope_uni_item_bala IS

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
    Fecha           : 26/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     26/02/2025  OSF-4042 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fblExisteItemEnUnidadOper 
    Descripcion     : Retorna verdadero si existe el item asociado la unidad operativa
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 26/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     26/02/2025  OSF-4042 Creacion
    ***************************************************************************/                     
    FUNCTION fblExisteItemEnUnidadOper
    (
        inuItem             IN  or_ope_uni_item_bala.items_id%TYPE,
        inuUnidadOperativa  IN  or_ope_uni_item_bala.operating_unit_id%TYPE
    )
    RETURN BOOLEAN
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblExisteItemEnUnidadOper';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        blExisteItemEnUnidadOper BOOLEAN;
        
        CURSOR cuExisteItemEnUnidadOper
        IS
        SELECT *
        FROM or_ope_uni_item_bala ib
        WHERE ib.items_id = inuItem
        AND ib.operating_unit_id = inuUnidadOperativa;
        
        rcExisteItemEnUnidadOper    cuExisteItemEnUnidadOper%ROWTYPE;
      
        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(70) := csbMetodo || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);
            
        BEGIN
        
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
            
            IF cuExisteItemEnUnidadOper%ISOPEN THEN
                CLOSE cuExisteItemEnUnidadOper;
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
        
        OPEN cuExisteItemEnUnidadOper;
        FETCH cuExisteItemEnUnidadOper INTO rcExisteItemEnUnidadOper;
        CLOSE cuExisteItemEnUnidadOper;

        blExisteItemEnUnidadOper := rcExisteItemEnUnidadOper.items_id IS NOT NULL;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN blExisteItemEnUnidadOper;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN blExisteItemEnUnidadOper;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN blExisteItemEnUnidadOper;
    END fblExisteItemEnUnidadOper;

    -- Retorna la cantidad disponible del item en la unidad operativa
    FUNCTION fnuObtieneCantDisponible
    (
        inuItem             IN  or_ope_uni_item_bala.items_id%TYPE,
        inuUnidadOperativa  IN  or_ope_uni_item_bala.operating_unit_id%TYPE
    )
    RETURN or_ope_uni_item_bala.balance%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtieneCantDisponible';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        blExisteItemEnUnidadOper BOOLEAN;
        
        CURSOR cuObtieneCantDisponible
        IS
        SELECT balance
        FROM or_ope_uni_item_bala ib
        WHERE ib.items_id = inuItem
        AND ib.operating_unit_id = inuUnidadOperativa;
        
        nuCantDisponible    or_ope_uni_item_bala.balance%TYPE;
      
        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(70) := csbMetodo || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);
            
        BEGIN
        
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
            
            IF cuObtieneCantDisponible%ISOPEN THEN
                CLOSE cuObtieneCantDisponible;
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
        
        OPEN cuObtieneCantDisponible;
        FETCH cuObtieneCantDisponible INTO nuCantDisponible;
        CLOSE cuObtieneCantDisponible;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN nuCantDisponible;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuCantDisponible; 
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuCantDisponible;
    END fnuObtieneCantDisponible;
    
    -- Se actualiza el costo total y la cantidad disponible
    PROCEDURE prcActCostoTotalYcantDispo
    (
        inuItem                     IN  or_ope_uni_item_bala.items_id%TYPE,
        inuUnidadOperativa          IN  or_ope_uni_item_bala.operating_unit_id%TYPE,
        inuValorAfectCostoTotal     IN  or_ope_uni_item_bala.total_costs%TYPE,
        inuCantAfectCantDisponible  IN  or_ope_uni_item_bala.balance%TYPE
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcActCostoTotalYcantDispo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
            
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        UPDATE or_ope_uni_item_bala
        SET total_costs = total_costs + inuValorAfectCostoTotal,
            balance = balance + inuCantAfectCantDisponible
        WHERE items_id = inuItem
        AND operating_unit_id = inuUnidadOperativa;

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
    END prcActCostoTotalYcantDispo;

    -- Obtiene el costo total del item en la unidad operativa
    FUNCTION fnuObtieneCostoTotal
    (
        inuItem             IN  or_ope_uni_item_bala.items_id%TYPE,
        inuUnidadOperativa  IN  or_ope_uni_item_bala.operating_unit_id%TYPE
    )
    RETURN or_ope_uni_item_bala.total_costs%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtieneCostoTotal';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        blExisteItemEnUnidadOper BOOLEAN;
        
        CURSOR cuObtieneCostoTotal
        IS
        SELECT total_costs
        FROM or_ope_uni_item_bala ib
        WHERE ib.items_id = inuItem
        AND ib.operating_unit_id = inuUnidadOperativa;
        
        nuCostoTotal    or_ope_uni_item_bala.total_costs%TYPE;
      
        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(70) := csbMetodo || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);
            
        BEGIN
        
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
            
            IF cuObtieneCostoTotal%ISOPEN THEN
                CLOSE cuObtieneCostoTotal;
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
        
        OPEN cuObtieneCostoTotal;
        FETCH cuObtieneCostoTotal INTO nuCostoTotal;
        CLOSE cuObtieneCostoTotal;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN nuCostoTotal;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuCostoTotal; 
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuCostoTotal;
    END fnuObtieneCostoTotal;
    
    -- Inserta un registro en la tabla or_ope_uni_item_bala
    PROCEDURE prcInsRegistro
    (
        inuItem                 IN  or_ope_uni_item_bala.items_id%TYPE,
        inuUnidaOperativa       IN  or_ope_uni_item_bala.operating_unit_id%TYPE,
        inuCantidadAsignada     IN  or_ope_uni_item_bala.quota%TYPE,
        inuCantidadDisponible   IN  or_ope_uni_item_bala.balance%TYPE,
        inuCostoTotal           IN  or_ope_uni_item_bala.total_costs%TYPE,
        inuCantidadOcacional    IN  or_ope_uni_item_bala.occacional_quota%TYPE,
        inuCantidadEntrando     IN  or_ope_uni_item_bala.transit_in%TYPE,
        inuCantidadSaliendo     IN  or_ope_uni_item_bala.transit_out%TYPE
    )   
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        INSERT INTO or_ope_uni_item_bala
        (
            items_id,
            operating_unit_id,
            quota,
            balance,
            total_costs,
            occacional_quota,
            transit_in,
            transit_out
        )
        VALUES
        (
            inuItem                 ,
            inuUnidaOperativa       ,
            inuCantidadAsignada     ,
            inuCantidadDisponible   ,
            inuCostoTotal           ,
            inuCantidadOcacional    ,
            inuCantidadEntrando    ,
            inuCantidadSaliendo    
        );
                
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                     
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
    END prcInsRegistro;

    -- Obtiene el costo toral del item en la unidad operativa
    PROCEDURE prcBorraItemEnUnidadOper
    (
        inuItem             IN  or_ope_uni_item_bala.items_id%TYPE,
        inuUnidadOperativa  IN  or_ope_uni_item_bala.operating_unit_id%TYPE
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcBorraItemEnUnidadOper';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
            
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                
        DELETE or_ope_uni_item_bala ib
        WHERE ib.items_id = inuItem
        AND ib.operating_unit_id = inuUnidadOperativa;
        
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
    END prcBorraItemEnUnidadOper;
        
END pkg_or_ope_uni_item_bala;
/
Prompt Otorgando permisos sobre adm_person.pkg_or_ope_uni_item_bala
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_or_ope_uni_item_bala'), upper('adm_person'));
END;
/