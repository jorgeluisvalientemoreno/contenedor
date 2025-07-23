/*******************************************************************************
    Método:         trg_valida_contrato_nulo.sql
    Descripción:    Trigger que valida si la actividad tiene contrato 
    Autor:          jcatuche
    Fecha:          16/12/2024

    Historia de Modificaciones
    ==========================
    FECHA           AUTOR               DESCRIPCION
    16/12/2024      jcatuche            OSF-3758: Creación
*******************************************************************************/
CREATE OR REPLACE TRIGGER PERSONALIZACIONES.TRG_VALIDA_CONTRATO_NULO
BEFORE INSERT OR UPDATE ON OR_ORDER_ACTIVITY
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
WHEN (NEW.TASK_TYPE_ID IS NOT NULL AND NVL(OLD.TASK_TYPE_ID,-1) != NVL(NEW.TASK_TYPE_ID,-1))
DECLARE
    csbSP_NAME          CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;          -- Constante para nombre de objeto
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para este objeto.
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado

    nuError             NUMBER;
    sbError             VARCHAR2(4000);
    
    sbTITR_Param        parametros.codigo%type := 'TITR_REQUIERE_CONTRATO';
    
BEGIN
    pkg_traza.trace(csbSP_NAME, csbNivelTraza, csbInicio);
    
    pkg_traza.trace('Tipo de Trabajo: '||:NEW.TASK_TYPE_ID, csbNivelTraza);
    pkg_traza.trace('Contrato: '||:NEW.SUBSCRIPTION_ID, csbNivelTraza);
    pkg_traza.trace('Producto: '||:NEW.PRODUCT_ID, csbNivelTraza);
    
    if pkg_parametros.fnuValidaSiExisteCadena(sbTITR_Param,',',to_char(:NEW.TASK_TYPE_ID)) > 0 then
    
        pkg_traza.trace('Tipo de trabajo '||:NEW.TASK_TYPE_ID||' configurado en parámetro '||sbTITR_Param, csbNivelTraza);
        
        IF :NEW.SUBSCRIPTION_ID IS NULL THEN
        
            pkg_error.setErrorMessage( isbMsgErrr => 'No se puede registrar la orden, el tipo de trabajo '||:NEW.TASK_TYPE_ID||' requiere un número de contrato');

        END IF;
        
    end if;
    
    pkg_traza.trace(csbSP_NAME, csbNivelTraza, csbFin);
EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
        pkg_traza.trace(csbSP_NAME, csbNivelTraza, csbFin_Erc);
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
        pkg_traza.trace(csbSP_NAME, csbNivelTraza, csbFin_Err);
        RAISE pkg_Error.Controlled_Error;
END;
/
