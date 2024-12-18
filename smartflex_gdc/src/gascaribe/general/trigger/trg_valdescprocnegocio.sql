create or replace TRIGGER TRG_VALDESCPROCNEGOCIO
  FOR INSERT or UPDATE  ON PROCESO_NEGOCIO COMPOUND TRIGGER
 /**************************************************************************
    Autor       : Luis Javier Lopez Barrios
    Fecha       : 2024-04-09
    Ticket      : OSF-3140
    Descripcion : trigger que valida los datos de la tabla proceso_negocio
    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
     csbSP_NAME     	CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
     nuError            NUMBER;
     sbError            VARCHAR2(4000);
	 sbDescProceNego    proceso_negocio.descripcion%TYPE;
     nuCodigoProceNego    proceso_negocio.codigo%TYPE;
-- Ejecucion antes de cada fila, variables :NEW, :OLD son permitidas
  BEFORE EACH ROW IS
    csbMT_NAME  VARCHAR2(100) := csbSP_NAME || '.BEFORE EACH ROW';

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    sbDescProceNego      := :new.descripcion;
    nuCodigoProceNego    := :new.codigo;
    pkg_traza.trace(' sbDescProceNego => ' || sbDescProceNego, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' nuCodigoProceNego => ' || nuCodigoProceNego, pkg_traza.cnuNivelTrzDef);
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

	sbExiste VARCHAR2(1);

	CURSOR cuGetExisteProc IS
	SELECT 'X'
	FROM proceso_negocio
	WHERE upper(proceso_negocio.descripcion) =  upper(sbDescProceNego)
     AND proceso_negocio.codigo <> nuCodigoProceNego;

  BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

	  IF cuGetExisteProc%ISOPEN THEN CLOSE cuGetExisteProc; END IF;

	  OPEN cuGetExisteProc;
	  FETCH cuGetExisteProc INTO sbExiste;
	  CLOSE cuGetExisteProc;
	  pkg_traza.trace(' sbExiste => ' || sbExiste, pkg_traza.cnuNivelTrzDef);
	  IF sbExiste IS NOT NULL THEN
         pkg_error.seterrormessage(isbMsgErrr=> 'Proceso de negocio ['||upper(sbDescProceNego)||'] ya existe.');
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
END TRG_VALDESCPROCNEGOCIO;
/