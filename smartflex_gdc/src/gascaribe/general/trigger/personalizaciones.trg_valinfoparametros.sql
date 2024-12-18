create or replace TRIGGER PERSONALIZACIONES.TRG_VALINFOPARAMETROS
  BEFORE INSERT or DELETE or UPDATE  ON PARAMETROS 
  FOR EACH ROW
 /**************************************************************************
    Autor       : Luis Javier Lopez Barrios
    Fecha       : 2024-01-11
    Ticket      : OSF-3140
    Descripcion : trigger que valida los datos de la tabla parametros
    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  DECLARE
     csbMT_NAME         VARCHAR2(70) := 'TRG_VALINFOPARAMETROS';
     nuError            NUMBER;
     sbError            VARCHAR2(4000);
     V_styLogParametros   pkg_log_parametros.styLogParametros;
     sbOperacion       VARCHAR2(1);
  BEGIN
    pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    IF INSERTING OR UPDATING THEN
        IF :NEW.ESTADO = 'A' AND :NEW.OBLIGATORIO = 'S' THEN
            IF :NEW.valor_numerico IS NULL AND :NEW.valor_cadena IS NULL AND :NEW.valor_fecha IS NULL THEN
                 pkg_error.setErrorMessage(isbMsgErrr => 'Si el parametro ['||:NEW.codigo ||'] es obligatorio y esta activo, se debe configurar por lo menos un valor en el respectivo tipo de dato');
            END IF;
        END IF;
        :NEW.USUARIO := PKG_SESSION.GETUSER;
        :NEW.TERMINAL := PKG_SESSION.FSBGETTERMINAL;
        :NEW.FECHA_ACTUALIZACION := SYSDATE;
        
        IF INSERTING THEN 
            sbOperacion := 'I';
        ELSE 
            sbOperacion := 'U';
        END IF;
        V_styLogParametros.codigo					:= :NEW.codigo;
       
     
    ELSE
       V_styLogParametros.codigo := :OLD.codigo;
       sbOperacion := 'D';
    END IF;
    
    V_styLogParametros.valor_numerico_actual    := :NEW.valor_numerico;
    V_styLogParametros.valor_numerico_ante      := :OLD.valor_numerico;
    V_styLogParametros.valor_cadena_actual      := :NEW.valor_cadena;
    V_styLogParametros.valor_cadena_ante        := :OLD.valor_cadena;
    V_styLogParametros.valor_fecha_actual       := :NEW.valor_fecha;
    V_styLogParametros.valor_fecha_ante         := :OLD.valor_fecha;
    V_styLogParametros.proceso_actual           := :NEW.proceso;
    V_styLogParametros.proceso_ante             := :OLD.proceso;
    V_styLogParametros.estado_actual            := :NEW.estado;
    V_styLogParametros.estado_ante              := :OLD.estado;
    V_styLogParametros.obligatorio_actual       := :NEW.obligatorio;
    V_styLogParametros.obligatorio_ante         := :OLD.obligatorio;
    V_styLogParametros.operacion                := sbOperacion;    
    V_styLogParametros.fecha_registro           := SYSDATE;
    V_styLogParametros.usuario                  := PKG_SESSION.GETUSER;
    V_styLogParametros.terminal                 := PKG_SESSION.FSBGETTERMINAL;
    
    pkg_log_parametros.prInsertarLogParametro(V_styLogParametros);
 
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
	  RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
	  RAISE pkg_error.CONTROLLED_ERROR;
END TRG_VALINFOPARAMETROS;
/