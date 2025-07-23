CREATE OR REPLACE TRIGGER multiempresa.trg_auditoria_contrato
BEFORE INSERT OR UPDATE OR DELETE ON CONTRATO
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE

/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Trigger     :   trg_auditoria_contrato
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   11/03/2025
    Descripcion :   Trigger para insertar en multiempresa.auditoria_contrato
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     11/03/2025  OSF-3956    Creacion
*******************************************************************************/

    csbMetodo       CONSTANT VARCHAR2(70) :=  'trg_auditoria_contrato';
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    csbNivelTraza   CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    

    sbEvento            VARCHAR2(15);
    nuContrato          contrato.contrato%TYPE;
    sbEmpresaAnterior   contrato.empresa%TYPE;
    sbEmpresaNueva      contrato.empresa%TYPE;
                          
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    
    IF INSERTING THEN
        sbEvento            := 'INSERT';
        nuContrato          := :NEW.CONTRATO; 
        sbEmpresaNueva      := :NEW.EMPRESA;           
    ELSIF UPDATING THEN
        sbEvento := 'UPDATE';
        nuContrato          := :NEW.CONTRATO; 
        sbEmpresaAnterior   := :OLD.EMPRESA;   
        sbEmpresaNueva      := :NEW.EMPRESA;
    ELSE
        sbEvento := 'DELETE';
        nuContrato          := :OLD.CONTRATO; 
        sbEmpresaAnterior   := :OLD.EMPRESA;      
    END IF;
    
    IF sbEvento <> 'INSERT' THEN
    
        pkg_auditoria_contrato.prInsRegistro
        (
            inuContrato         =>  nuContrato,
            isbEvento           =>  sbEvento,
            isbEmpresaAnterior  =>  sbEmpresaAnterior,
            isbEmpresaNueva     =>  sbEmpresaNueva
        );
    
    END IF;
    
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
END;
/
