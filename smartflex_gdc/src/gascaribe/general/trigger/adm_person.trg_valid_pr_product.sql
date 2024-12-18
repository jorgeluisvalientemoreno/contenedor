CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_VALID_PR_PRODUCT
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

      Funcion     : TRG_VALID_PR_PRODUCT
      Descripcion : trigger para validar los conceptos del plan comercial.
      Autor       : Horbath
      Ticket      : 810
      Fecha       : 18-08-2021

    Historia de Modificaciones
    Fecha               Autor                Modificacion
    =========           =========          ====================
    06/06/2024          jpinedc             OSF-2601: Ajustes por estandares
    **************************************************************************/
    AFTER
    INSERT OR UPDATE
    ON PR_PRODUCT
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
    WHEN(    new.PRODUCT_ID IS NOT NULL
         AND new.PRODUCT_TYPE_ID IS NOT NULL
         AND new.PRODUCT_TYPE_ID = 7014)
DECLARE

    csbMetodo        CONSTANT VARCHAR2(70) := 'TRG_VALID_PR_PRODUCT';
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

    IF INSERTING
    THEN
        pkg_Traza.Trace ('TRG_VALID_PR_PRODUCT Insert', csbNivelTraza);
        SENDMAILCONCEPT (:new.product_id, 'I');
    END IF;

    IF UPDATING
    THEN
        pkg_Traza.Trace ('TRG_VALID_PR_PRODUCT update', csbNivelTraza);

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
END TRG_VALID_PR_PRODUCT;
/