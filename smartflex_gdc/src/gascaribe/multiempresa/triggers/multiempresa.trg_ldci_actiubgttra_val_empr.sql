CREATE OR REPLACE TRIGGER multiempresa.trg_ldci_actiubgttra_val_empr
BEFORE INSERT OR UPDATE ON ldci_actiubgttra
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
WHEN 
( 
    NVL(OLD.ACBGDPTO,-1) <> NVL(NEW.ACBGDPTO,-1)
    OR
    NVL(OLD.ACBGORIN,-1) <> NVL(NEW.ACBGORIN,-1)
    OR
    NVL(OLD.ACBGSOCI,'-') <> NVL(NEW.ACBGSOCI,'-')
)    
DECLARE

/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Trigger     :   trg_ldci_actiubgttra_val_empr(esa)
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   19/06/2025
    Descripcion :   Trigger para validar que la sociedad (empresa) 
                    * correponda al departamento
                    * sea GDCA si la orden interna empieza por 4
                    * sea GDGU si la orden interna empieza por 6
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     19/06/2025  OSF-4558    Creacion
*******************************************************************************/
    csbMetodo               CONSTANT VARCHAR2(70) :=  'trg_ldci_actiubgttra_val_empr';
    nuError                 NUMBER;
    sbError                 VARCHAR2(4000);
    csbNivelTraza           CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
            
    nuNuevoDepartamento         ldci_actiubgttra.acbgdpto%TYPE  :=  :NEW.ACBGDPTO;    
    sbNuevaSociedad             ldci_actiubgttra.acbgsoci%TYPE  :=  NVL(:NEW.ACBGSOCI,'-');    
    nuNuevaOrdenInterna         ldci_actiubgttra.acbgorin%TYPE  :=  NVL(:NEW.ACBGORIN,-1);
    
    sbEmpresaDepartamento       ldci_actiubgttra.acbgsoci%TYPE;
    
    nuPrimerDigitoOrdInterna    number(1);
    
    sbEmpresaOrdenInterna       ldci_actiubgttra.acbgsoci%TYPE;
                         
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

    IF nuNuevoDepartamento IS NOT NULL THEN 
    
        sbEmpresaDepartamento := pkg_boConsultaEmpresa.fsbObtEmpresaDepartamento(nuNuevoDepartamento);

        pkg_traza.trace('sbEmpresaDepartamento|' || sbEmpresaDepartamento, csbNivelTraza );
            
        IF sbEmpresaDepartamento <> sbNuevaSociedad THEN
                            
            pkg_error.setErrorMessage( isbMsgErrr => 'La sociedad del departamento[' || nuNuevoDepartamento || '] debe ser [' || sbEmpresaDepartamento || ']');
               
        END IF;
        
    ELSE
    
        pkg_error.setErrorMessage( isbMsgErrr => 'El departamento no puede ser nulo' );    
    
    END IF;
        
    IF nuNuevaOrdenInterna > 0 THEN
    
        nuPrimerDigitoOrdInterna  :=   SUBSTR(nuNuevaOrdenInterna,1,1);
        
        CASE nuPrimerDigitoOrdInterna 
            WHEN 4 THEN
                sbEmpresaOrdenInterna := 'GDCA' ;
            WHEN 6 THEN 
                sbEmpresaOrdenInterna := 'GDGU' ;                        
            ELSE
                pkg_error.setErrorMessage( isbMsgErrr => 'El primer digito de la orden interna deber ser 4 para GDCA o 6 para GDGU' );        
        END CASE;
        
        IF sbEmpresaOrdenInterna <> sbNuevaSociedad THEN
                            
            pkg_error.setErrorMessage( isbMsgErrr => 'La sociedad de la orden interna [' || nuNuevaOrdenInterna || '] debe ser [' || sbEmpresaOrdenInterna || ']');
               
        END IF;         
        
    ELSE
    
        pkg_error.setErrorMessage( isbMsgErrr => 'La orden interna no puede ser nula ni menor a cero' );   
    
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
