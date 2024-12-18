create or replace TRIGGER TRG_VALICONSFAEL
  FOR INSERT or DELETE or UPDATE  ON recofael COMPOUND TRIGGER
 /**************************************************************************
    Autor       : Luis Javier Lopez Barrios
    Fecha       : 2024-01-11
    Ticket      : OSF-2158
    Descripcion : trigger que valida los datos de la tabla recofael
    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
   sbexiste       VARCHAR2(4);
   sbOperacion    VARCHAR2(4);
     -- Constantes para el control de la traza
   csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
   nuError        NUMBER;
   sbError        VARCHAR2(4000);

   nuCodigo       recofael.codigo%type;
   nuTipodocu     recofael.tipo_documento%type;
   nuConsInicial  recofael.cons_inicial%type;
   nuConsFinal    recofael.cons_final%type;
   sbEstado       recofael.estado%type;
   nuUltimoCons   recofael.ultimo_cons%type;
   regRecofaelLog  pkg_recofael_log.styRecofaelLog;

-- Ejecucion antes de cada fila, variables :NEW, :OLD son permitidas
  BEFORE EACH ROW IS
    csbMT_NAME  VARCHAR2(100) := csbSP_NAME || '.BEFORE EACH ROW';

  BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        nuCodigo      := :new.codigo;
        nuTipodocu    := :new.tipo_documento;
        nuConsInicial := :new.cons_inicial;
        nuConsFinal   := :new.cons_final;
        sbEstado      := :new.estado;
        nuUltimoCons  := :new.ultimo_cons;

        pkg_traza.trace(' nuCodigo => ' || nuCodigo, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(' nuTipodocu => ' || nuTipodocu, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(' nuConsInicial => ' || nuConsInicial, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(' nuConsFinal => ' || nuConsFinal, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(' sbEstado => ' || sbEstado, pkg_traza.cnuNivelTrzDef);

        IF nuUltimoCons = nuConsFinal AND sbEstado = 'S' THEN
           pkg_error.seterrormessage(isbMsgErrr=> 'No se puede activar el rango de consecutivo, el  ultimo consecutivo utilizado es igual al consecutivo final ');
        END IF;

        IF nuConsInicial > nuConsFinal THEN
           pkg_error.seterrormessage(isbMsgErrr=> 'Consecutivo inicial no puede ser mayor al consecutivo final ');
        END IF;

		IF :new.fecha_ini_vigencia > :new.fecha_fin_vigencia THEN
		    pkg_error.seterrormessage(isbMsgErrr=> 'Fecha inicial de vigencia no puede ser mayor a la fecha final ');
		END IF;

        IF inserting THEN
           sbOperacion := 'I';
		   :new.FECHA_REGISTRO := sysdate;
		   :new.USUARIO := user;
		   :new.TERMINAL := userenv('TERMINAL') ;
        END IF;

        IF updating THEN
           sbOperacion := 'U';
        END IF;


        pkg_traza.trace(' sbOperacion => ' || sbOperacion, pkg_traza.cnuNivelTrzDef);

		regRecofaelLog.codigo					 := nuCodigo;
		regRecofaelLog.tipo_documento_actual	 := nuTipodocu;
		regRecofaelLog.tipo_documento_anterior  := :old.tipo_documento;
		regRecofaelLog.prefijo_actual           := :new.prefijo;
		regRecofaelLog.prefijo_anterior         := :old.prefijo;
		regRecofaelLog.resolucion_actual        := :new.resolucion;
		regRecofaelLog.resolucion_anterior      := :old.resolucion;
		regRecofaelLog.cons_inicial_actual      := nuConsInicial;
		regRecofaelLog.cons_inicial_anterior    := :old.cons_inicial;
		regRecofaelLog.cons_final_actual        := nuConsFinal;
		regRecofaelLog.cons_final_anterior      := :old.cons_final;
		regRecofaelLog.ultimo_cons_actual       := :new.ultimo_cons;
		regRecofaelLog.ultimo_cons_anterior     := :old.ultimo_cons;
		regRecofaelLog.estado_actual            := sbEstado;
		regRecofaelLog.estado_anterior          := :old.Estado;
		regRecofaelLog.fecha_resolucion_act     := :new.fecha_resolucion ;
		regRecofaelLog.fecha_resolucion_ant     := :old.fecha_resolucion;
		regRecofaelLog.fecha_ini_vigencia_act   := :new.fecha_ini_vigencia;
		regRecofaelLog.fecha_ini_vigencia_ant   := :old.fecha_ini_vigencia;
		regRecofaelLog.fecha_fin_vigencia_act   := :new.fecha_fin_vigencia;
		regRecofaelLog.fecha_fin_vigencia_ant   := :old.fecha_fin_vigencia;
		regRecofaelLog.operacion   			 := sbOperacion;

		pkg_recofael_log.PrInsRecofaelLog(  regRecofaelLog,
										   nuError,
										   sbError);

		IF nuError <> 0 THEN
           RAISE pkg_error.CONTROLLED_ERROR;
        END IF;


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
  END BEFORE EACH ROW;

  /*Despues de la sentencia de insertar o actualizar*/
  AFTER STATEMENT IS
    csbMT_NAME  VARCHAR2(100) := csbSP_NAME || '.AFTER STATEMENT';
  BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      IF sbEstado = 'A' THEN


          pkg_recofael.prValidaSolapamientoCons( nuCodigo,
                                                 nuTipodocu,
                                                 nuConsInicial,
                                                 nuConsFinal,
                                                 nuError,
                                                 sbError);
          IF nuError <> 0 THEN
             RAISE pkg_error.CONTROLLED_ERROR;
          END IF;
      END IF;
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
  END AFTER STATEMENT;

END TRG_VALICONSFAEL;
/