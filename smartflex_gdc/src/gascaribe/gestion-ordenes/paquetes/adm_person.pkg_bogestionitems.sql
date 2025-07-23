CREATE OR REPLACE PACKAGE adm_person.pkg_bogestionitems IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_bogestionitems
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   27/03/2025
    Descripcion :   Paquete con los programas para gestión de items
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     27/03/2025  OSF-4042 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Obtiene el valor del item para la unidad operativa y localidad
    FUNCTION fnuObtieneValorItem
    (
        inuItem             IN  or_order_items.items_id%TYPE,
        inuUnidadOperativa  IN  or_order_activity.operating_unit_id%TYPE,
        inuIdDireccion      IN  or_order_activity.address_id%TYPE,
        inuTipoTrabajo      IN  or_order_activity.task_type_id%TYPE      
    )
    RETURN NUMBER;

END pkg_bogestionitems;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bogestionitems IS

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
    Fecha           : 27/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     27/03/2025  OSF-4042 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prReferenciaCupon 
    Descripcion     : Obtiene el valor del item para la unidad operativa y localidad
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 27/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     27/03/2025  OSF-4042 Creacion
    ***************************************************************************/
    FUNCTION fnuObtieneValorItem
    (
        inuItem             IN  or_order_items.items_id%TYPE,
        inuUnidadOperativa  IN  or_order_activity.operating_unit_id%TYPE,
        inuIdDireccion      IN  or_order_activity.address_id%TYPE,
        inuTipoTrabajo      IN  or_order_activity.task_type_id%TYPE      
    )
    RETURN NUMBER
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'fnuObtieneValorItem';

        nuValorItem         NUMBER;

    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        nuValorItem :=  or_boitemvalue.fnugetitemprice( inuItem, inuUnidadOperativa, inuIdDireccion, inuTipoTrabajo );

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN nuValorItem;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN nuValorItem;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuValorItem;  
    END fnuObtieneValorItem;    
      
END pkg_bogestionitems;
/
Prompt Otorgando permisos sobre adm_person.pkg_bogestionitems
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_bogestionitems'), upper('adm_person'));
END;
/