CREATE OR REPLACE PACKAGE adm_person.pkg_ldc_log_items_modif_sin_ac IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_ldc_log_items_modif_sin_ac
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   10/03/2025
    Descripcion :   Paquete
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     10/03/2025  OSF-4042 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Inserta un registro en ldc_log_items_modif_sin_ac
    PROCEDURE prInsRegistro
    (
        inuorden_id	        IN  ldc_log_items_modif_sin_acta.orden_id%TYPE,
        inupackage_id	    IN  ldc_log_items_modif_sin_acta.package_id%TYPE,
        inuorder_item_id	IN  ldc_log_items_modif_sin_acta.order_item_id%TYPE,
        inuitem_id	        IN  ldc_log_items_modif_sin_acta.item_id%TYPE,
        inulegal_item_amount	IN  ldc_log_items_modif_sin_acta.legal_item_amount%TYPE,
        inuvalor_original	IN  ldc_log_items_modif_sin_acta.costo_original%TYPE,
        inuvalor_total_orig	IN  ldc_log_items_modif_sin_acta.precio_original%TYPE,
        inucantidad_final	IN  ldc_log_items_modif_sin_acta.cantidad_final%TYPE,
        isbobservacion	    IN  ldc_log_items_modif_sin_acta.observa_modif%TYPE,
        onuconsecutivo	    OUT ldc_log_items_modif_sin_acta.consecutivo%TYPE,
        inuserial_items_id	IN  ldc_log_items_modif_sin_acta.serial_items_id%TYPE,
        inuCantBodPadre	    IN  ldc_log_items_modif_sin_acta.prev_ouib_balance%TYPE,
        inuCostBodPadre	    IN  ldc_log_items_modif_sin_acta.prev_ouib_total_cost%TYPE,
        inuCantBodInv	    IN  ldc_log_items_modif_sin_acta.prev_oi_balance%TYPE,
        inuCostBodInv	    IN  ldc_log_items_modif_sin_acta.prev_oi_total_cost%TYPE,
        inuCantBodAct	    IN  ldc_log_items_modif_sin_acta.prev_ao_balance%TYPE,
        inuCostBodAct	    IN  ldc_log_items_modif_sin_acta.prev_ao_total_cost%TYPE      
    );

    -- Obtiene la orden y el item en el registro del consecutivo
    PROCEDURE prObtOrderEitemConConsecutivo
    ( 
        inuConsecutivo  IN  ldc_log_items_modif_sin_acta.consecutivo%TYPE,
        onuOrden        OUT ldc_log_items_modif_sin_acta.orden_id%TYPE,
        onuItem         OUT ldc_log_items_modif_sin_acta.item_id%TYPE
    );
    
    -- Actualiza un registro de log
    PROCEDURE prcActRegistro
    (
        inuconsecutivo          IN  NUMBER,
        inucantidad_final       IN  NUMBER,
        inuvalor_unit_final     IN  NUMBER,
        inuvalor_total_final    IN  NUMBER,
        inuorden_rev_anul       IN  NUMBER,
        inuorder_item_id_rec    IN  NUMBER,
        inuorden_rec_anul       IN  NUMBER,
        inuCantBodPadre          IN  NUMBER,
        inuCostBodPadre          IN  NUMBER,
        inuCantBodInv            IN  NUMBER,
        inuCostBodInv            IN  NUMBER,
        inuCantBodAct            IN  NUMBER,
        inuCostBodAct            IN  NUMBER,
        isbUsuario              IN  VARCHAR2 DEFAULT pkg_Session.getUser,
        idtFechaActualizacion   IN  DATE    DEFAULT SYSDATE
    );   

END pkg_ldc_log_items_modif_sin_ac;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldc_log_items_modif_sin_ac IS

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
    Programa        : prInsRegistro 
    Descripcion     : Inserta un registro en ldc_log_items_modif_sin_ac
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 10/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     10/03/2025  OSF-4042 Creacion
    ***************************************************************************/                     
    PROCEDURE prInsRegistro
    (
        inuorden_id	        IN  ldc_log_items_modif_sin_acta.orden_id%TYPE,
        inupackage_id	    IN  ldc_log_items_modif_sin_acta.package_id%TYPE,
        inuorder_item_id	IN  ldc_log_items_modif_sin_acta.order_item_id%TYPE,
        inuitem_id	        IN  ldc_log_items_modif_sin_acta.item_id%TYPE,
        inulegal_item_amount	IN  ldc_log_items_modif_sin_acta.legal_item_amount%TYPE,
        inuvalor_original	IN  ldc_log_items_modif_sin_acta.costo_original%TYPE,
        inuvalor_total_orig	IN  ldc_log_items_modif_sin_acta.precio_original%TYPE,
        inucantidad_final	IN  ldc_log_items_modif_sin_acta.cantidad_final%TYPE,
        isbobservacion	    IN  ldc_log_items_modif_sin_acta.observa_modif%TYPE,
        onuconsecutivo	    OUT ldc_log_items_modif_sin_acta.consecutivo%TYPE,
        inuserial_items_id	IN  ldc_log_items_modif_sin_acta.serial_items_id%TYPE,
        inuCantBodPadre	    IN  ldc_log_items_modif_sin_acta.prev_ouib_balance%TYPE,
        inuCostBodPadre	    IN  ldc_log_items_modif_sin_acta.prev_ouib_total_cost%TYPE,
        inuCantBodInv	    IN  ldc_log_items_modif_sin_acta.prev_oi_balance%TYPE,
        inuCostBodInv	    IN  ldc_log_items_modif_sin_acta.prev_oi_total_cost%TYPE,
        inuCantBodAct	    IN  ldc_log_items_modif_sin_acta.prev_ao_balance%TYPE,
        inuCostBodAct	    IN  ldc_log_items_modif_sin_acta.prev_ao_total_cost%TYPE      
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
               
        onuconsecutivo  := seq_ldc_log_items_modif_sin.nextval;
                  
        INSERT INTO ldc_log_items_modif_sin_acta llimosa
        (
            orden_id,
           package_id,
           order_item_id,
           item_id,
           legal_item_amount,
           costo_original,
           precio_original,
           cantidad_final,
           observa_modif,
           consecutivo,
           serial_items_id,
           prev_ouib_balance,
           prev_ouib_total_cost,
           prev_oi_balance,
           prev_oi_total_cost,
           prev_ao_balance,
           prev_ao_total_cost
        )
        VALUES
        (
            inuorden_id, --orden_id,
            inupackage_id, --package_id,
            inuorder_item_id, --order_item_id,
            inuitem_id, --item_id,
            inulegal_item_amount, --legal_item_amount,
            inuvalor_original, --valor_original,
            inuvalor_total_orig, --valor_total_orig,
            inucantidad_final, --cantidad_final,
            isbobservacion, --observa_modif,
            onuconsecutivo, --consecutivo,
            inuserial_items_id, --serial_items_id,
            inuCantBodPadre,
            inuCostBodPadre,
            inuCantBodInv,
            inuCostBodInv,
            inuCantBodAct,
            inuCostBodAct
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
    
    -- Obtiene la orden y el item en el registro del consecutivo
    PROCEDURE prObtOrderEitemConConsecutivo
    ( 
        inuConsecutivo  IN  ldc_log_items_modif_sin_acta.consecutivo%TYPE,
        onuOrden        OUT ldc_log_items_modif_sin_acta.orden_id%TYPE,
        onuItem         OUT ldc_log_items_modif_sin_acta.item_id%TYPE
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prObtOrderEitemConConsecutivo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        CURSOR cuObtOrderEitemConConsecutivo
        IS
        SELECT orden_id, item_id
        FROM ldc_log_items_modif_sin_acta
        WHERE consecutivo = inuConsecutivo;
        
        PROCEDURE prcCerrarCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(105) := csbMetodo || '.prcCerrarCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);        
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);
            
            IF cuObtOrderEitemConConsecutivo%ISOPEN THEN
                CLOSE cuObtOrderEitemConConsecutivo;
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
        END prcCerrarCursor;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuObtOrderEitemConConsecutivo;
        FETCH cuObtOrderEitemConConsecutivo INTO onuOrden, onuItem;
        CLOSE cuObtOrderEitemConConsecutivo;
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCerrarCursor;
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCerrarCursor;
            RAISE pkg_error.Controlled_Error;
    END prObtOrderEitemConConsecutivo;
    
    -- Actualiza un registro de log
    PROCEDURE prcActRegistro
    (
        inuconsecutivo          IN  NUMBER,
        inucantidad_final       IN  NUMBER,
        inuvalor_unit_final     IN  NUMBER,
        inuvalor_total_final    IN  NUMBER,
        inuorden_rev_anul       IN  NUMBER,
        inuorder_item_id_rec    IN  NUMBER,
        inuorden_rec_anul       IN  NUMBER,
        inuCantBodPadre          IN  NUMBER,
        inuCostBodPadre          IN  NUMBER,
        inuCantBodInv            IN  NUMBER,
        inuCostBodInv            IN  NUMBER,
        inuCantBodAct            IN  NUMBER,
        inuCostBodAct            IN  NUMBER,
        isbUsuario              IN  VARCHAR2 DEFAULT pkg_Session.getUser,
        idtFechaActualizacion   IN  DATE    DEFAULT SYSDATE
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
            
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        UPDATE ldc_log_items_modif_sin_acta l
        SET l.cantidad_final    = inucantidad_final,
        l.costo_final           = inuvalor_unit_final,
        l.precio_final          = inuvalor_total_final,
        l.orden_rev_anul        = inuorden_rev_anul,
        l.order_item_id_rec     = inuorder_item_id_rec,
        l.orden_rec_anul        = inuorden_rec_anul,
        l.post_ouib_balance     = inuCantBodPadre,
        l.post_ouib_total_cost  = inuCostBodPadre,
        l.post_oi_balance       = inuCantBodInv,
        l.post_oi_total_cost    = inuCostBodInv,
        l.post_ao_balance       = inuCantBodAct,
        l.post_ao_total_cost    = inuCostBodAct,
        l.usu_modif             = isbUsuario,
        l.fecha_modif           = idtFechaActualizacion
        WHERE l.consecutivo = inuconsecutivo;
                
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
    END prcActRegistro;
         
          
END pkg_ldc_log_items_modif_sin_ac;
/

Prompt Otorgando permisos sobre adm_person.pkg_ldc_log_items_modif_sin_ac
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_ldc_log_items_modif_sin_ac'), 'adm_person');
END;
/

