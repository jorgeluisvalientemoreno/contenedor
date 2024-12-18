CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_VALID_PLAN_COMER
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

      Funcion     : TRG_VALID_PRODUCT_CC_COMER
      Descripcion : trigger para validar los conceptos del plan comercial cuando se realice un cambio.
      Autor       : Horbath
      Ticket      : 810
      Fecha       : 11-10-2021

    Historia de Modificaciones
    Fecha               Autor                Modificacion
    =========           =========          ====================
    06/06/2024          jpinedc             OSF-2601: Ajustes por estandares
    **************************************************************************/
    AFTER
    UPDATE
    ON PR_PRODUCT
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
    WHEN(    old.COMMERCIAL_PLAN_ID IS NOT NULL
         AND new.PRODUCT_TYPE_ID = 7014
         AND old.COMMERCIAL_PLAN_ID <> new.COMMERCIAL_PLAN_ID)
DECLARE

    csbMetodo        CONSTANT VARCHAR2(70) := 'TRG_VALID_PLAN_COMER';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    nuError         NUMBER;
    sbError         VARCHAR2(4000);

    nuValexiste   NUMBER (10);

    CURSOR Cuexiste IS
        SELECT COUNT (1)
          FROM LD_TABPRODNOTIF
         WHERE STATUS = 'I' AND PRODUCT_ID = :new.PRODUCT_ID;
BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

    pkg_Traza.Trace ('TRG_VALID_PRODUCT_CC_COMER Insert', csbNivelTraza);

    SENDMAILCONCEPT (:new.product_id, 'I');

    pkg_Traza.Trace ('TRG_VALID_PRODUCT_CC_COMER update', csbNivelTraza);

    OPEN Cuexiste;
    FETCH Cuexiste INTO nuValexiste;
    CLOSE Cuexiste;

    IF nuValexiste = 1
    THEN
        SENDMAILCONCEPT (:new.product_id,
                         'U',
                         :new.ADDRESS_ID,
                         :new.COMMERCIAL_PLAN_ID,
                         :new.CREATION_DATE);
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
END TRG_VALID_PRODUCT_CC_COMER;
/