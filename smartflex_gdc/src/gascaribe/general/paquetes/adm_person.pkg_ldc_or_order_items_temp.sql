CREATE OR REPLACE PACKAGE adm_person.pkg_ldc_or_order_items_temp IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_ldc_or_order_items_temp
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   10/03/2025
    Descripcion :   Paquete
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     10/03/2025  OSF-4042 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Obtiene los ítems ya legalizados en la orden
    CURSOR cuItemsOrdenYsecuencia(inuOrden NUMBER, inuSecuencia NUMBER) 
    IS
    Select Order_Id,
    Items_Id,
    Assigned_Item_Amount,
    Legal_Item_Amount,
    Value,
    Order_Items_Id,
    Total_Price,
    Element_Code,
    Order_Activity_Id,
    Element_Id,
    Reused,
    Serial_Items_Id,
    Serie,
    Out_
    From Ldc_Or_Order_Items_Temp Looit
    Where Looit.Order_Id = inuOrden
    And Looit.Sesion   = inuSecuencia;
    
    -- Obtiene el registro por orden y sesion
    FUNCTION frcObtRegistroConOrdenYsesion
    (
        inuOrden        IN  NUMBER, 
        inuSesion       IN  NUMBER
    )
    RETURN ldc_or_order_items_temp%ROWTYPE;
    
    -- Inserta registros para los items de la orden
    PROCEDURE prInsRegistrosItemsOrden
    (
        inuOrden        IN  ldc_or_order_items_temp.order_id%TYPE,
        onuSecuencia    OUT ldc_or_order_items_temp.sesion%TYPE,
        onuCantidadRegs OUT NUMBER
    );

END pkg_ldc_or_order_items_temp;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldc_or_order_items_temp IS

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
    Fecha           : 10/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     10/03/2025  OSF-4042 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : frcObtRegistroConOrdenYsesion 
    Descripcion     : Obtiene el registro por orden y sesion
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 10/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     10/03/2025  OSF-4042 Creacion
    ***************************************************************************/
    FUNCTION frcObtRegistroConOrdenYsesion
    (
        inuOrden        IN  NUMBER, 
        inuSesion       IN  NUMBER
    )
    RETURN ldc_or_order_items_temp%ROWTYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'frcObtRegistroConOrdenYsesion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        rcldc_or_order_items_temp   ldc_or_order_items_temp%ROWTYPE;

        CURSOR cuObtRegistroConOrdenYsesion
        IS
        SELECT *
        FROM ldc_or_order_items_temp looit
        WHERE looit.order_id = inuOrden
        AND looit.sesion   = inuSesion;
        
        PROCEDURE prCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(70) := csbMetodo || '.prCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);        
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
            
            IF cuObtRegistroConOrdenYsesion%ISOPEN THEN
                CLOSE cuObtRegistroConOrdenYsesion;
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
        END prCierraCursor;        
                    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuObtRegistroConOrdenYsesion;
        FETCH cuObtRegistroConOrdenYsesion INTO rcldc_or_order_items_temp;
        CLOSE cuObtRegistroConOrdenYsesion;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        RETURN  rcldc_or_order_items_temp;
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prCierraCursor;
            RETURN  rcldc_or_order_items_temp;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prCierraCursor;            
            RETURN  rcldc_or_order_items_temp;
    END frcObtRegistroConOrdenYsesion;
    
    -- Inserta registros para los items de la orden
    PROCEDURE prInsRegistrosItemsOrden
    (
        inuOrden        IN  ldc_or_order_items_temp.order_id%TYPE,
        onuSecuencia    OUT ldc_or_order_items_temp.sesion%TYPE,
        onuCantidadRegs OUT NUMBER
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsRegistrosItemsOrden';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
            
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

        onuSecuencia := seq_ldc_or_order_items_temp.nextval;
        
        INSERT INTO ldc_or_order_items_temp
        (
            order_id,
            items_id,
            assigned_item_amount,
            legal_item_amount,
            Value,
            order_items_id,
            total_price,
            element_code,
            order_activity_id,
            element_id,
            reused,
            serial_items_id,
            serie,
            out_,
            sesion
        )
        SELECT 
            order_id,
            items_id,
            assigned_item_amount,
            legal_item_amount,
            Value,
            order_items_id,
            total_price,
            element_code,
            order_activity_id,
            element_id,
            reused,
            serial_items_id,
            serie,
            out_,
            onuSecuencia
        FROM or_order_items ooi
        WHERE ooi.order_id = inuOrden;            

        onuCantidadRegs := SQL%ROWCOUNT;
        
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
    END prInsRegistrosItemsOrden;    
          
END pkg_ldc_or_order_items_temp;
/

Prompt Otorgando permisos sobre adm_person.pkg_ldc_or_order_items_temp
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_ldc_or_order_items_temp'), upper('adm_person'));
END;
/

