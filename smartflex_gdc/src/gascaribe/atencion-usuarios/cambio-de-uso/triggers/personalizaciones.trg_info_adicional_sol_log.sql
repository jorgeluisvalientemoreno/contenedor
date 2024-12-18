CREATE OR REPLACE TRIGGER PERSONALIZACIONES.TRG_INFO_ADICIONAL_SOL_LOG
  AFTER INSERT OR UPDATE OR DELETE ON PERSONALIZACIONES.INFO_ADICIONAL_SOLICITUD
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW

DECLARE

  rcLOG_INFO_ADICIONAL_SOLICITUD LOG_INFO_ADICIONAL_SOLICITUD%ROWTYPE;

  csbSP_NAME CONSTANT VARCHAR2(100) := 'TRG_INFO_ADICIONAL_SOL_LOG';
  nuErrorCode NUMBER; -- se almacena codigo de error
  sbMensError VARCHAR2(2000); -- se almacena descripcion del error 

BEGIN

  pkg_traza.trace(csbSP_NAME,
                  pkg_traza.cnuNivelTrzDef,
                  pkg_traza.csbINICIO);

  rcLOG_INFO_ADICIONAL_SOLICITUD.Usuario := pkg_session.getUser();
  pkg_traza.trace('Usuario: ' || rcLOG_INFO_ADICIONAL_SOLICITUD.Usuario,
                  pkg_traza.cnuNivelTrzDef);

  rcLOG_INFO_ADICIONAL_SOLICITUD.Terminal := pkg_session.fsbgetTerminal();
  pkg_traza.trace('Terminal: ' || rcLOG_INFO_ADICIONAL_SOLICITUD.Terminal,
                  pkg_traza.cnuNivelTrzDef);

  rcLOG_INFO_ADICIONAL_SOLICITUD.PACKAGE_ID := nvl(:new.package_id,
                                                   :old.package_id);
  pkg_traza.trace('Solicitud: ' ||
                  rcLOG_INFO_ADICIONAL_SOLICITUD.PACKAGE_ID,
                  pkg_traza.cnuNivelTrzDef);

  rcLOG_INFO_ADICIONAL_SOLICITUD.DATO_ADICIONAL := nvl(:new.dato_adicional,
                                                       :old.dato_adicional);
  pkg_traza.trace('Dato Adicional: ' ||
                  rcLOG_INFO_ADICIONAL_SOLICITUD.DATO_ADICIONAL,
                  pkg_traza.cnuNivelTrzDef);

  rcLOG_INFO_ADICIONAL_SOLICITUD.VALOR_ANTERIOR := :old.valor;
  pkg_traza.trace('Valor Anterior: ' ||
                  rcLOG_INFO_ADICIONAL_SOLICITUD.VALOR_ANTERIOR,
                  pkg_traza.cnuNivelTrzDef);

  rcLOG_INFO_ADICIONAL_SOLICITUD.VALOR_NUEVO := :new.valor;
  pkg_traza.trace('Nuevo Valor: ' ||
                  rcLOG_INFO_ADICIONAL_SOLICITUD.VALOR_NUEVO,
                  pkg_traza.cnuNivelTrzDef);

  rcLOG_INFO_ADICIONAL_SOLICITUD.FECHA_CAMBIO := systimestamp;
  pkg_traza.trace('Fecha Cambio: ' ||
                  rcLOG_INFO_ADICIONAL_SOLICITUD.FECHA_CAMBIO,
                  pkg_traza.cnuNivelTrzDef);

  IF DELETING THEN
    rcLOG_INFO_ADICIONAL_SOLICITUD.OPERACION := 'D';
  ELSE
    IF INSERTING THEN
      rcLOG_INFO_ADICIONAL_SOLICITUD.OPERACION := 'I';
    ELSE
      rcLOG_INFO_ADICIONAL_SOLICITUD.OPERACION := 'U';
    END IF;
  END IF;
  pkg_traza.trace('Operacion: ' ||
                  rcLOG_INFO_ADICIONAL_SOLICITUD.OPERACION,
                  pkg_traza.cnuNivelTrzDef);

  pkg_log_info_adicional_solicit.prinsRegistro(rcLOG_INFO_ADICIONAL_SOLICITUD);

  pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
  WHEN pkg_Error.Controlled_Error THEN
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbSP_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
    RAISE pkg_Error.Controlled_Error;
  
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbSP_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
    RAISE pkg_Error.Controlled_Error;
  
END;
/
