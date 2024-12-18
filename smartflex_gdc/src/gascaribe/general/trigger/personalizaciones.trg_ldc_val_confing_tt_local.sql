create or replace trigger personalizaciones.trg_ldc_val_confing_tt_local
  before update on ge_acta
  referencing
         new as new
         old as old
  for each row
when (new.estado = 'C')
Declare
    csbMetodo        CONSTANT VARCHAR2(70) :=  'trg_ldc_val_confing_tt_local';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;    
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    
    nuordenes Number;
Begin

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
   
    IF (:old.estado <> 'C') And (:new.estado = 'C') THEN

        pkg_Traza.Trace('contrato: ' || :new.id_contrato, csbNivelTraza);

        nuordenes := ldc_pkvalida_tt_local.valida_trigger(:old.contractor_id, :old.id_acta);

        pkg_Traza.Trace('Ordenes ' || nuordenes, csbNivelTraza);
        
        IF nuordenes = 1 THEN       
            pkg_error.setErrorMessage( isbMsgErrr => 'Existen tipos de trabajo que no poseen la configuracion contable');
        End IF;
        
    End IF;

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
End trg_ldc_val_confing_tt_local;
/