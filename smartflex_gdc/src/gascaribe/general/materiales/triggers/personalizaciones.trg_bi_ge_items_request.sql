CREATE OR REPLACE TRIGGER personalizaciones.trg_bi_ge_items_request
BEFORE INSERT ON GE_ITEMS_REQUEST
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
DECLARE
    sbError             VARCHAR2(4000);
    nuError             NUMBER;
    csbMT_NAME          VARCHAR2(100) := $$PLSQL_UNIT;

    nuitem              ge_items.items_id%TYPE;
    
    nuUnidOperDestino   ge_items_documento.destino_oper_uni_id%TYPE;
    
    sbEmprUnidOperDestino   materiales.empresa%TYPE;
    
    sbMaterialHabilitado    materiales.habilitado%TYPE;
    
BEGIN

    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    nuitem :=:NEW.ITEMS_ID;
    
    nuUnidOperDestino := pkg_ge_items_documento.fnuObtUnidOperDestino( :NEW.id_items_documento );

    sbEmprUnidOperDestino := pkg_boConsultaEmpresa.fsbObtEmpresaUnidadOper(nuUnidOperDestino);

    sbMaterialHabilitado := pkg_boConsultaEmpresa.fsbMaterialHabilitado( nuitem, sbEmprUnidOperDestino );

    IF sbMaterialHabilitado = 'N' THEN
        sbError := 'El item '||:NEW.ITEMS_ID||'-'||pkg_bcitems.fsbObtenerDescripcion(:NEW.ITEMS_ID)||', no está habilitado para la empresa[' || sbEmprUnidOperDestino || ']. Por favor validar.';
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
