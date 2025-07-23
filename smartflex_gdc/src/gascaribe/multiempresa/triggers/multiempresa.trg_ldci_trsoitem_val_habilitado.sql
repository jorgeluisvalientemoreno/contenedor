CREATE OR REPLACE TRIGGER multiempresa.trg_ldci_trsoitem_val_habilita
BEFORE INSERT OR UPDATE ON ldci_trsoitem
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
WHEN 
( 
    NVL(OLD.TSITITEM,-1) <> NEW.TSITITEM
)    
DECLARE

/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Trigger     :   trg_ldci_trsoitem_val_habilita(do)
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   23/04/2025
    Descripcion :   Trigger para validar que el material este habilitado para 
                    la empresa del contratista
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     23/04/2025  OSF-4259    Creacion
*******************************************************************************/
    csbMetodo               CONSTANT VARCHAR2(70) :=  'trg_ldci_trsoitem_val_habilita';
    nuError                 NUMBER;
    sbError                 VARCHAR2(4000);
    csbNivelTraza           CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    nuContratista           contratista.contratista%TYPE;
        
    sbEmpresaContratista    contratista.empresa%TYPE;
    
    sbHabilitado            materiales.habilitado%TYPE;
                     
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    
    nuContratista := pkg_ldci_transoma.fnuObtContratista( :NEW.TSITSOMA );

    pkg_traza.trace('Contratista|' || nuContratista, csbNivelTraza );
        
    IF nuContratista IS NOT null THEN
    
        sbEmpresaContratista    := pkg_boConsultaEmpresa.fsbObtEmpresaContratista( nuContratista );
        
        pkg_traza.trace('sbEmpresaContratista|' || sbEmpresaContratista, csbNivelTraza );
        
        IF sbEmpresaContratista IS NULL THEN
                
            pkg_error.setErrorMessage( isbMsgErrr => 'El contratista ['|| nuContratista || '] no tiene empresa asociada'  );
       
        END IF;
            
        sbHabilitado :=  pkg_boConsultaEmpresa.fsbMaterialHabilitado ( :NEW.TSITITEM, sbEmpresaContratista );
                   
        IF sbHabilitado = 'N' THEN
                
            pkg_error.setErrorMessage( isbMsgErrr => 'El material [' || :NEW.TSITITEM || '] no se encuentra habilitado para la empresa [' || sbEmpresaContratista || '] del contratista ['|| nuContratista || ']'  );
       
        END IF;    
    
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
