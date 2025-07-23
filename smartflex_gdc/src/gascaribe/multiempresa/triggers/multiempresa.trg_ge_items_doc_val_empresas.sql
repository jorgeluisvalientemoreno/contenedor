CREATE OR REPLACE TRIGGER multiempresa.trg_ge_items_doc_val_empresas
BEFORE INSERT OR UPDATE ON ge_items_documento
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
WHEN (NEW.operating_unit_id <> NEW.destino_oper_uni_id)
DECLARE

/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Trigger     :   trg_ge_items_doc_val_empresas
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   19/02/2025
    Descripcion :   Trigger para validar la empresas de las unidades en traslado
                    de items
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     19/02/2025  OSF-3956    Creacion
*******************************************************************************/

    csbMetodo       CONSTANT VARCHAR2(70) :=  'trg_ge_items_doc_val_empresas';
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    csbNivelTraza   CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    nuBaseAdmOrigen     base_admin.base_administrativa%TYPE;
    sbEmpresaOrigen     base_admin.empresa%TYPE;
    nuBaseAdmDestino    base_admin.base_administrativa%TYPE;
    sbEmpresaDestino    base_admin.empresa%TYPE;
                        
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
           
    nuBaseAdmOrigen := pkg_or_operating_unit.fnuObtAdmin_Base_Id( :NEW.operating_unit_id );
    
    sbEmpresaOrigen  := pkg_base_admin.fsbObtieneEmpresa( nuBaseAdmOrigen );

    nuBaseAdmDestino := pkg_or_operating_unit.fnuObtAdmin_Base_Id( :NEW.destino_oper_uni_id );

    sbEmpresaDestino  := pkg_base_admin.fsbObtieneEmpresa( nuBaseAdmDestino );
    
    IF ( sbEmpresaOrigen <> sbEmpresaDestino ) THEN
        pkg_error.setErrorMessage( isbMsgErrr => 'La empresa origen[' || sbEmpresaOrigen || '] y destino[' ||sbEmpresaDestino  ||'] son diferentes' ); 
    END IF;
            
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
END;
/
