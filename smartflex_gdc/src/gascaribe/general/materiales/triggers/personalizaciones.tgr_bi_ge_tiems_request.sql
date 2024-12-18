CREATE OR REPLACE TRIGGER personalizaciones.tgr_bi_ge_tiems_request
BEFORE INSERT ON GE_ITEMS_REQUEST
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
DECLARE
    sbError             VARCHAR2(4000);
    nuError             NUMBER;
    csbMT_NAME          VARCHAR2(100) := $$PLSQL_UNIT;
    Esobsoleto          BOOLEAN;

    nuitem              ge_items.items_id%TYPE;
BEGIN
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    nuitem :=:NEW.ITEMS_ID;

    Esobsoleto := pkg_bcitems.fblEsObsoleto(nuitem);

    IF(Esobsoleto)THEN
        sbError := 'El item '||:NEW.ITEMS_ID||'-'||pkg_bcitems.fsbObtenerDescripcion(:NEW.ITEMS_ID)||', se encuentra marcado como obsoleto. Por favor, validar con almacén.';
        Pkg_Error.SetErrorMessage( isbMsgErrr => sbError); 
    END IF;
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.Controlled_Error;   
END tgr_bi_ge_tiems_request;
/
