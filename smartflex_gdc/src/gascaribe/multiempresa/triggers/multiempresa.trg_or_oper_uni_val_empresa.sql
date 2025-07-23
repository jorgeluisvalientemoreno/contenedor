CREATE OR REPLACE TRIGGER multiempresa.trg_or_oper_uni_val_empresa
BEFORE INSERT OR UPDATE ON or_operating_unit
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE

/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Trigger     :   trg_or_oper_uni_val_empresa
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   19/02/2025
    Descripcion :   Trigger para validar que las empresas de las unidades 
                    operativas y sus contratistas sean iguales
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     19/02/2025  OSF-3956    Creacion
*******************************************************************************/

    csbMetodo       CONSTANT VARCHAR2(70) :=  'trg_or_oper_uni_val_empresa';
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    csbNivelTraza   CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    PROCEDURE prcValidaBaseAdministrativa
    IS
        csbMetodo1       CONSTANT VARCHAR2(105) :=  csbMetodo || '.prcValidaBaseAdministrativa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        sbEmpresaContratista        contratista.empresa%TYPE;
        sbEmpresaUnidadOperativa    contratista.empresa%TYPE;
            
    BEGIN
    
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);    

        sbEmpresaUnidadOperativa:=  pkg_base_admin.fsbObtieneEmpresa( :NEW.ADMIN_BASE_ID );        
        sbEmpresaContratista    :=  pkg_contratista.fsbObtEmpresa( :NEW.CONTRACTOR_ID );
               
        IF  sbEmpresaContratista <> sbEmpresaUnidadOperativa
        THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'La empresa de la unidad operativa[' || sbEmpresaUnidadOperativa || '] y de su contratista['|| sbEmpresaContratista || '] son diferentes' );
        END IF;
        
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;            
    END prcValidaBaseAdministrativa;
                        
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    
    /* si la unidad operativa es externa ( ES_EXTERNA = 'Y') y 
    tiene contratista asociado ( CONTRACTOR_ID IS NOT NULL )
    */    
    IF :NEW.ES_EXTERNA = 'Y' THEN
    
        IF INSERTING THEN
        
            IF :NEW.CONTRACTOR_ID IS NOT NULL THEN
        
                prcValidaBaseAdministrativa;
                
            ELSE
                pkg_traza.trace('INFO:La unidad operativa es de contratista pero no se le especifico uno', csbNivelTraza );        
            END IF;
            
        ELSIF UPDATING THEN
        
            IF 
            :NEW.ES_EXTERNA <> :OLD.ES_EXTERNA 
            OR
            :NEW.CONTRACTOR_ID <> NVL(:OLD.CONTRACTOR_ID,-1)
            OR
            :NEW.ADMIN_BASE_ID  <> NVL(:OLD.ADMIN_BASE_ID,-1)
            THEN
                            
                prcValidaBaseAdministrativa;
                
            END IF;
            
        END IF;
        
    ELSE
        pkg_traza.trace('INFO:La unidad operativa no es de contratista', csbNivelTraza );
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
