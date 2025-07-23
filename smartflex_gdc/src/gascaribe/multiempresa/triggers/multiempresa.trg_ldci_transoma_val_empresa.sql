CREATE OR REPLACE TRIGGER multiempresa.trg_ldci_transoma_val_empresa
BEFORE INSERT OR UPDATE ON ldci_transoma
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
WHEN 
( 
    NVL(OLD.TRSMCONT,-1) <> NVL(NEW.TRSMCONT,-1) OR
    NVL(OLD.TRSMPROV,-1) <> NVL(NEW.TRSMPROV,-1) OR
    NVL(OLD.TRSMMPDI,-1) <> NVL(NEW.TRSMMPDI,-1) OR
    NVL(OLD.TRSMMDPE,-1) <> NVL(NEW.TRSMMDPE,-1) OR
    NVL(OLD.TRSMOFVE,'-') <> NVL(NEW.TRSMOFVE,'-') OR
    NVL(OLD.TRSMDSRE,'-') <> NVL(NEW.TRSMDSRE,'-')       
)    
DECLARE

/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Trigger     :   trg_ldci_transoma_val_empresa
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   23/04/2025
    Descripcion :   Trigger para validar que la empresa de centro logistico,
                    motivo de venta y oficina sea la misma del
                    contratista en los registros creados o modificados por medio
                    de las formas LDCISOMA y LDCIDEPE
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     23/04/2025  OSF-4259    Creacion
*******************************************************************************/
    csbMetodo               CONSTANT VARCHAR2(70) :=  'trg_ldci_transoma_val_empresa';
    nuError                 NUMBER;
    sbError                 VARCHAR2(4000);
    csbNivelTraza           CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    sbPrograma                  VARCHAR2(100);
        
    nuMotivo                    NUMBER;
    
    nuContratista               NUMBER;
    
    sbEmpresaContratista        empresa.codigo%TYPE;
    
    sbEmpresaCentroLogistico    empresa.codigo%TYPE;
    
    sbEmpresaMotivo             empresa.codigo%TYPE;
    
    sbEmpresaOficinaVenta       empresa.codigo%TYPE;
    
    sbDocumentoSAP              VARCHAR2(10);
    
    nuCentroLogistico           NUMBER(15);
    
    sbOficinaVenta              VARCHAR2(4);
    
    FUNCTION fnuObtContratistaDocSAP( isbDocumentoSAP VARCHAR2)
    RETURN NUMBER
    IS

        PRAGMA AUTONOMOUS_TRANSACTION;
            
        csbMetodo1               CONSTANT VARCHAR2(105) :=  csbMetodo || '.fnuObtContratistaDocSAP';
        nuError1                 NUMBER;
        sbError1                 VARCHAR2(4000);
                
        nuContratista   NUMBER;
        
    BEGIN
    
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);
        
        nuContratista := pkg_bcldcidema.fnuObtContratistaDocSAP( isbDocumentoSAP );

        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);
            
        RETURN nuContratista;
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError1,sbError1);        
            pkg_traza.trace('sbError1 => ' || sbError1, csbNivelTraza );
            RETURN nuContratista;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError1,sbError1);
            pkg_traza.trace('sbError1 => ' || sbError1, csbNivelTraza );
            RETURN nuContratista;            
    END fnuObtContratistaDocSAP;
                      
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    
    sbPrograma := pkg_Session.fsbObtenerModulo;

    pkg_traza.trace('sbPrograma|' || sbPrograma, csbNivelTraza );
        
    IF sbPrograma = 'LDCISOMA' THEN

        nuMotivo     := :NEW.TRSMMPDI;
        
        nuContratista := :NEW.TRSMCONT;
                    
        sbEmpresaMotivo    := pkg_ldci_motipedi.fsbObtEmpresa( nuMotivo );
           
    ELSIF sbPrograma = 'LDCIDEMA' THEN

        nuMotivo     := :NEW.TRSMMDPE;
        
        sbDocumentoSAP := :NEW.TRSMDSRE;
        
        pkg_traza.trace('DocumentoSAP|' || sbDocumentoSAP , csbNivelTraza );
            
        nuContratista := fnuObtContratistaDocSAP( sbDocumentoSAP );

        sbEmpresaMotivo    := pkg_ldci_motidepe.fsbObtEmpresa( nuMotivo );
            
    END IF;

    pkg_traza.trace('Motivo|' || nuMotivo , csbNivelTraza );

    pkg_traza.trace('sbEmpresaMotivo|' || sbEmpresaMotivo , csbNivelTraza );
               
    pkg_traza.trace('Contratista|' || nuContratista, csbNivelTraza );        
                    
    sbEmpresaContratista    := pkg_boConsultaEmpresa.fsbObtEmpresaContratista( nuContratista );
        
    pkg_traza.trace('sbEmpresaContratista|' || sbEmpresaContratista, csbNivelTraza );
        
    IF sbEmpresaContratista IS NULL THEN
        pkg_error.setErrorMessage( isbMsgErrr => 'El contratista ['|| nuContratista || '] no tiene empresa asociada'  );  
    END IF;
    
    IF ( sbEmpresaContratista <> sbEmpresaMotivo ) THEN
        pkg_error.setErrorMessage( isbMsgErrr => 'La empresa [' || sbEmpresaContratista || '] del contratista ['|| nuContratista || '] es diferente a la empresa ['|| sbEmpresaMotivo || '] del motivo [' || nuMotivo || ']'  );    
    END IF;    

    IF sbPrograma = 'LDCISOMA' THEN
    
        nuCentroLogistico := :NEW.TRSMPROV;
    
        pkg_traza.trace('Centro Logistico|' || nuCentroLogistico, csbNivelTraza );
            
        sbEmpresaCentroLogistico :=  pkg_boConsultaEmpresa.fsbObtEmpresaUnidadOper( nuCentroLogistico );
        
        IF ( sbEmpresaContratista <> sbEmpresaCentroLogistico ) THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'La empresa [' || sbEmpresaContratista || '] del contratista ['|| nuContratista || '] es diferente a la empresa ['|| sbEmpresaCentroLogistico|| '] del centro logistico[' || nuCentroLogistico || ']'  );    
        END IF;
        
        sbOficinaVenta := :NEW.TRSMOFVE;
        
        pkg_traza.trace('Oficina Venta|' || sbOficinaVenta, csbNivelTraza );

        sbEmpresaOficinaVenta    := pkg_LDCI_OFICVENT.fsbObtEmpresa( sbOficinaVenta );

        IF ( sbEmpresaContratista <> sbEmpresaOficinaVenta ) THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'La empresa [' || sbEmpresaContratista || '] del contratista ['|| nuContratista || '] es diferente a la empresa ['|| sbEmpresaMotivo || '] de la oficina de venta [' || sbOficinaVenta|| ']'  );    
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
