CREATE OR REPLACE PROCEDURE prreglabuscaunidadreparaciones
(
    inuProducto     pr_product.product_id%TYPE,
    inuSolicitud    mo_packages.package_id%TYPE
)
AS
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prreglabuscaunidadreparaciones 
    Descripcion     : Constructora ( ge_object ) que ejecuta 
                      pkg_BOASIGNA_UNIDAD_REV_PER.prcBuscaUnidadReparaciones 
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 27-09-2024 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-09-2024  OSF-3368    Creacion
    ***************************************************************************/    
    
    csbMetodo        CONSTANT VARCHAR2(70) :=  'prreglabuscaunidadreparaciones';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    pkg_traza.trace('inuProducto|' || inuProducto, csbNivelTraza );
    pkg_traza.trace('inuSolicitud|' || inuSolicitud, csbNivelTraza );
    
    pkg_BOASIGNA_UNIDAD_REV_PER.prcBuscaUnidadReparaciones
    (
        inuProducto    ,
        inuSolicitud   
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
END prreglabuscaunidadreparaciones;
/

