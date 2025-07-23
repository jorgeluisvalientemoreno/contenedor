CREATE OR REPLACE TRIGGER PERSONALIZACIONES.trg_val_est_enviado_pedido
  BEFORE UPDATE ON LDCI_TRANSOMA
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
DECLARE

  /*****************************************************************
    GASEA DEL CARIBE
  
    UNIDAD         : TRG_VAL_EST_ENVIADO_PEDIDO
    DESCRIPCION    : TRIGGER PARA VALIDAR QUE SOLO CAMBIE DE ESTADO 2 A ESTADO 3 LA SOLICITUD DE MATERIALES
    AUTOR          : JORGE VALIENTE
    FECHA          : 06/03/2025
  
    HISTORIA DE MODIFICACIONES
  
      FECHA             AUTOR             MODIFICACION
    =========         =========         ====================
  ******************************************************************/

  --APLICACION QUE EJECUTA
  csbMetodo CONSTANT VARCHAR2(100) := 'trg_val_est_enviado_pedido'; --nombre del metodo
  nuNivelTrzDef NUMBER := pkg_traza.cnuNivelTrzDef;
  sbINICIO      VARCHAR2(100) := pkg_traza.csbINICIO;
  sbFIN         VARCHAR2(100) := pkg_traza.csbFIN;

  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);

  nuESTADO_PEDIDO_ENVIADO NUMBER := pkg_parametros.fnuGetValorNumerico('ESTADO_PEDIDO_ENVIADO');

  nuESTADO_PEDIDO_RECIBIDO NUMBER := pkg_parametros.fnuGetValorNumerico('ESTADO_PEDIDO_RECIBIDO');

BEGIN

  pkg_traza.trace(csbMetodo, nuNivelTrzDef, sbINICIO);

  IF ((:new.TRSMPROG = 'WS_MOVIMIENTO_MATERIAL_T' AND :new.TRSMACTI = 'N') OR
     (:new.TRSMPROG = 'WS_MOVIMIENTO_MATERIAL' AND :new.TRSMACTI = 'S')) THEN
    RETURN;
  ELSE
  
    IF nuESTADO_PEDIDO_ENVIADO IS NULL THEN
      pkg_error.setErrorMessage(isbMsgErrr => 'No existe valor en el parametro ESTADO_PEDIDO_ENVIADO.');
    END IF;
  
    IF nuESTADO_PEDIDO_RECIBIDO IS NULL THEN
      pkg_error.setErrorMessage(isbMsgErrr => 'No existe valor en el parametro ESTADO_PEDIDO_RECIBIDO.');
    END IF;
  
    pkg_traza.trace('ESTADO_PEDIDO_ENVIADO: ' || nuESTADO_PEDIDO_ENVIADO,
                    nuNivelTrzDef);
    pkg_traza.trace('ESTADO_PEDIDO_RECIBIDO: ' || nuESTADO_PEDIDO_RECIBIDO,
                    nuNivelTrzDef);
  
    pkg_traza.trace('Estado Anterior: ' || :OLD.TRSMESTA, nuNivelTrzDef);
    pkg_traza.trace('Nuevo Estado: ' || :NEW.TRSMESTA, nuNivelTrzDef);
  
    IF nvl(:OLD.TRSMESTA, 1) = nuESTADO_PEDIDO_ENVIADO AND
       :NEW.TRSMESTA <> nuESTADO_PEDIDO_RECIBIDO THEN
      pkg_error.setErrorMessage(isbMsgErrr => 'No se pueden realizar cambios a un pedido enviado a SAP.');
    END IF;
  
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
  
END trg_val_est_enviado_pedido;
/
