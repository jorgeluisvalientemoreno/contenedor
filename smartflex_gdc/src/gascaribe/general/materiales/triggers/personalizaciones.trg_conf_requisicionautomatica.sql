CREATE OR REPLACE TRIGGER personalizaciones.trg_conf_requisicionautomatica
  BEFORE UPDATE OF OPER_UNIT_STATUS_ID, ITEM_REQ_FRECUENCY, NEXT_ITEM_REQUEST ON Or_Operating_Unit
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
DECLARE

  /*****************************************************************
    GASEA DEL CARIBE
  
    UNIDAD         : trg_conf_requisicionautomatica
    DESCRIPCION    : TRIGGER PARA RETIRAR REQUISICION AUTOMATICA A UNIDAD OPERATIVA INHABILIDATA
    AUTOR          : JORGE VALIENTE
    FECHA          : 10/03/2025
  
    HISTORIA DE MODIFICACIONES
  
      FECHA             AUTOR             MODIFICACION
    =========         =========         ====================
  ******************************************************************/

  --APLICACION QUE EJECUTA
  csbMetodo CONSTANT VARCHAR2(100) := 'trg_conf_requisicionautomatica'; --nombre del metodo
  nuNivelTrzDef NUMBER := pkg_traza.cnuNivelTrzDef;
  sbINICIO      VARCHAR2(100) := pkg_traza.csbINICIO;
  sbFIN         VARCHAR2(100) := pkg_traza.csbFIN;

  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);

  nuESTADO_INHABILITADA_UO NUMBER := pkg_ld_parameter.fnuObtNUMERIC_VALUE('LDC_ESTADOINHUNOPER_2584');

BEGIN

  pkg_traza.trace(csbMetodo, nuNivelTrzDef, sbINICIO);

  pkg_traza.trace('Parametro ESTADO_INHABILITADA_UNIDAD_OPERATIVA: ' ||
                  nuESTADO_INHABILITADA_UO,
                  nuNivelTrzDef);
  pkg_traza.trace('Estado Unidad Operativa: ' || :NEW.OPER_UNIT_STATUS_ID,
                  nuNivelTrzDef);

  pkg_traza.trace('Frecuencia: ' || :NEW.ITEM_REQ_FRECUENCY, nuNivelTrzDef);
  pkg_traza.trace('Proxima Requisicion: ' || :NEW.NEXT_ITEM_REQUEST,
                  nuNivelTrzDef);

  IF :NEW.OPER_UNIT_STATUS_ID = nuESTADO_INHABILITADA_UO THEN
    :NEW.ITEM_REQ_FRECUENCY := NULL;
    :NEW.NEXT_ITEM_REQUEST  := NULL;
  END IF;

  pkg_traza.trace(csbMetodo, nuNivelTrzDef, sbFIN);

EXCEPTION
  WHEN pkg_error.CONTROLLED_ERROR THEN
    pkg_Error.getError(nuErrorCode, sbErrorMessage);
    pkg_traza.trace('Error: ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
    RAISE pkg_error.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuErrorCode, sbErrorMessage);
    pkg_traza.trace('Error: ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
    RAISE pkg_error.CONTROLLED_ERROR;
  
END trg_conf_requisicionautomatica;
/