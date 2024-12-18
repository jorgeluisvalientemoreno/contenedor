create or replace TRIGGER personalizaciones.LDC_TRGIUDSA_TAB
  AFTER INSERT OR UPDATE ON SA_TAB
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
/**************************************************************
  PROPIEDAD GASES DEL CARIBE E.S.P.

  TRIGGER  :  LDC_TRGIUDSA_TAB

  DESCRIPCION  : REGISTRA O ACTUALIZA DATOS EN LA ENTIDAD SA_TAB_MIRROR

  AUTOR  :  Jorge Valiente
  FECHA  : 19-06-2018

  HISTORIA DE MODIFICACIONES
  23/10/2024    jpinedc OSF-3164    Se migra al esquema PERSONALIZACIONES
  **************************************************************/

DECLARE
    csbMetodo           CONSTANT VARCHAR2(70) := 'personalizaciones.LDC_TRGIUDSA_TAB';
    csbNivelTraza       CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    nuError             NUMBER;
    sbError             VARCHAR2(4000);
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
    
    IF INSERTING THEN
        pkg_Traza.Trace('INICIO INSERTING',csbNivelTraza);
        LDC_PKSATABMIRROR.PRREGISTRASA_TAB_MIRROR(:NEW.TAB_ID,
                                                  :NEW.TAB_NAME,
                                                  :NEW.PROCESS_NAME,
                                                  :NEW.APLICA_EXECUTABLE,
                                                  :NEW.PARENT_TAB,
                                                  :NEW.TYPE,
                                                  :NEW.SEQUENCE,
                                                  :NEW.ADDITIONAL_ATTRIBUTES,
                                                  :NEW.CONDITION);
        pkg_Traza.Trace('FIN INSERTING',csbNivelTraza);
    END IF;

    IF UPDATING THEN
        pkg_Traza.Trace('INICIO UPDATING',csbNivelTraza);
        LDC_PKSATABMIRROR.PRACTUALIZASA_TAB_MIRROR(:NEW.TAB_ID,
                                                   :NEW.TAB_NAME,
                                                   :NEW.PROCESS_NAME,
                                                   :NEW.APLICA_EXECUTABLE,
                                                   :NEW.PARENT_TAB,
                                                   :NEW.TYPE,
                                                   :NEW.SEQUENCE,
                                                   :NEW.ADDITIONAL_ATTRIBUTES,
                                                   :NEW.CONDITION);
        pkg_Traza.Trace('FIN UPDATING',csbNivelTraza);
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
END LDC_TRGIUDCONFIMAXMIN;
/