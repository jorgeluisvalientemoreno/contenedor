create or replace package pkg_recofael is

 -- Cursor que obtiene los datos del cliente
 CURSOR cuRecord(inuTipoDocu  	IN 	recofael.tipo_documento%TYPE,
                 inuConsetivo 	IN 	NUMBER,
                 isbEstado   	IN 	VARCHAR,
				 isbEmpresa	 	IN	VARCHAR) IS
 SELECT recofael.*,
	   recofael.rowid
 FROM recofael
 WHERE recofael.tipo_documento = inuTipoDocu
  AND recofael.estado = decode(isbEstado, 'T',recofael.estado, isbEstado)
  AND inuConsetivo between recofael.CONS_INICIAL AND recofael.CONS_FINAL
  AND (SYSDATE BETWEEN recofael.FECHA_INI_VIGENCIA AND recofael.FECHA_FIN_VIGENCIA
    OR isbEstado = 'T')
  AND empresa = isbEmpresa
 ORDER BY recofael.cons_inicial;


 SUBTYPE styConsecutivo IS cuRecord%ROWTYPE;

 PROCEDURE prActualizaCons( inuCodigo    IN  recofael.codigo%TYPE,
                            inuUltConse  IN  recofael.ultimo_cons%TYPE,
                            onuError     OUT NUMBER,
                            osbError     OUT VARCHAR2);
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaCons
    Descripcion     : proceso para actualizar consecutivo

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 10-01-2024

    Parametros de Entrada
      inuCodigo      codigo de identificacion del registro
      inuUltConse    ultimo consecutivo utilizado
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       10-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  PROCEDURE prActualizaEstado( inuCodigo  IN  recofael.codigo%TYPE,
                              isbEstado  IN  recofael.estado%TYPE,
                              onuError   OUT NUMBER,
                              osbError   OUT VARCHAR2);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaEstado
    Descripcion     : proceso para actualizar estado de los consecutivos

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 10-01-2024

    Parametros de Entrada
      inuCodigo      codigo de identificacion del registro
      isbEstado      estado del registro
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       10-01-2024   OSF-2158    Creacion
  ***************************************************************************/
 FUNCTION fnuGetSigConsecutivo ( inuTipoDocu  IN  recofael.tipo_documento%TYPE,
                                 onuError   OUT NUMBER,
                                 osbError   OUT VARCHAR2) RETURN recofael.Ultimo_Cons%TYPE;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetSigConsecutivo
    Descripcion     : funcion que retorna siguiente consecutivo a utilizar

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 10-01-2024

    Parametros de Entrada
      inuTipoDocu    tipo de documento
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       10-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  PROCEDURE prValidaSolapamientoCons( inuCodigo      IN  recofael.codigo%TYPE,
                                      inuTipoDocu    IN  recofael.tipo_documento%TYPE,
                                      inuConsInicial IN  recofael.cons_inicial%TYPE,
                                      inuConsFinal   IN  recofael.cons_final%TYPE,
									  isbEmpresa	 IN  VARCHAR2,
                                      onuError       OUT NUMBER,
                                      osbError       OUT VARCHAR2);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prValidaSolapamientoCons
    Descripcion     : proceso para validar solapamiento de consecutivos

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 10-01-2024

    Parametros de Entrada
      inuCodigo       codigo de identificacion del registro
      inuTipoDocu     tipo de documento
      inuConsInicial  consecutivo inicial
      inuConsFinal    consecutivo final
	  isbEmpresa	  Empresa
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       10-01-2024   OSF-2158    Creacion
	JSOTO	   14-03-2025   OSF-4104    Se agrega parametro entrada isbEmpresa
  ***************************************************************************/

  FUNCTION frcgetRecord	( inuTipoDocu  IN  recofael.tipo_documento%TYPE,
						  isbEmpresa   IN  VARCHAR2,
						  inuConsetivo IN  NUMBER,
                          isbEstado    IN  VARCHAR2 DEFAULT 'A',
                          onuError     OUT NUMBER,
                          osbError     OUT VARCHAR2	) RETURN styConsecutivo;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcgetRecord
    Descripcion     : funcion que retorna informacion de consecutivos por tipo de documento

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 10-01-2024

    Parametros de Entrada
      inuTipoDocu     tipo de documento
      inuConsetivo    consecutivo de secuencia
      isbEstado       estado del consecutivo
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       10-01-2024   OSF-2158    Creacion
  ***************************************************************************/

end pkg_recofael;
/
create or replace package body  pkg_recofael is
  -- Constantes para el control de la traza
  csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion     CONSTANT VARCHAR2(15) := 'OSF-4104';

   FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 16-11-2023

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       16-11-2023   OSF-1916    Creacion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  PROCEDURE prActualizaCons( inuCodigo    IN  recofael.codigo%TYPE,
                             inuUltConse  IN  recofael.ultimo_cons%TYPE,
                             onuError     OUT NUMBER,
                             osbError     OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaCons
    Descripcion     : proceso para actualizar consecutivo

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 10-01-2024

    Parametros de Entrada
      inuCodigo      codigo de identificacion del registro
      inuUltConse    ultimo consecutivo utilizado
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       10-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME  VARCHAR2(100) := csbSP_NAME || '.prActualizaCons';
    nuConsFinal recofael.cons_final%TYPE;

    CURSOR cuGetConsFinal IS
    SELECT recofael.cons_final
    FROM recofael
    WHERE recofael.codigo = inuCodigo;

    PROCEDURE prCloseCursor IS
     csbMT_NAME1      VARCHAR2(150) := csbSP_NAME || '.prCloseCursor';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF cuGetConsFinal%ISOPEN THEN
           CLOSE cuGetConsFinal;
        END IF;
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuCodigo => ' || inuCodigo, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuUltConse => ' || inuUltConse, pkg_traza.cnuNivelTrzDef);
    pkg_error.prinicializaerror(onuError, osbError);
    prCloseCursor;

    UPDATE recofael SET  ultimo_cons = inuUltConse
    WHERE codigo = inuCodigo;

    OPEN cuGetConsFinal;
    FETCH cuGetConsFinal INTO nuConsFinal;
    CLOSE cuGetConsFinal;

    IF nuConsFinal = inuUltConse THEN
       prActualizaEstado(inuCodigo, 'I', onuError, osbError);
    END IF;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(onuError, osbError);
      prCloseCursor;
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuError, osbError);
      prCloseCursor;
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prActualizaCons;

 PROCEDURE prActualizaEstado( inuCodigo  IN  recofael.codigo%TYPE,
                              isbEstado  IN  recofael.estado%TYPE,
                              onuError   OUT NUMBER,
                              osbError   OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaEstado
    Descripcion     : proceso para actualizar estado de los consecutivos

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 10-01-2024

    Parametros de Entrada
      inuCodigo      codigo de identificacion del registro
      isbEstado      estado del registro
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       10-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME  VARCHAR2(100) := csbSP_NAME || '.prActualizaEstado';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuCodigo => ' || inuCodigo, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('isbEstado => ' || isbEstado, pkg_traza.cnuNivelTrzDef);
    pkg_error.prinicializaerror(onuError, osbError);

    UPDATE recofael SET  estado = isbEstado
    WHERE codigo = inuCodigo;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
 END prActualizaEstado;

 FUNCTION fnuGetSigConsecutivo ( inuTipoDocu  IN  recofael.tipo_documento%TYPE,
                                 onuError   OUT NUMBER,
                                 osbError   OUT VARCHAR2) RETURN recofael.Ultimo_Cons%TYPE IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetSigConsecutivo
    Descripcion     : funcion que retorna siguiente consecutivo a utilizar

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 10-01-2024

    Parametros de Entrada
      inuTipoDocu    tipo de documento
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       10-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fnuGetSigConsecutivo';
    nuConsuSig      recofael.ultimo_cons%type;

    CURSOR cuGetSigConsecutivo IS
    SELECT nvl(recofael.ultimo_cons,0)  + 1
    FROM recofael
    WHERE recofael.tipo_documento = inuTipoDocu
     AND recofael.estado = 'A'
    ORDER BY recofael.CONS_INICIAL;

    PROCEDURE prCloseCursor IS
     csbMT_NAME1      VARCHAR2(150) := csbSP_NAME || '.prCloseCursor';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF cuGetSigConsecutivo%ISOPEN THEN
           CLOSE cuGetSigConsecutivo;
        END IF;
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuTipoDocu => ' || inuTipoDocu, pkg_traza.cnuNivelTrzDef);
    pkg_error.prinicializaerror(onuError, osbError);
    prCloseCursor;
    nuConsuSig := null;

    OPEN cuGetSigConsecutivo;
    FETCH cuGetSigConsecutivo INTO nuConsuSig;
    CLOSE cuGetSigConsecutivo;

    IF nuConsuSig IS NULL THEN
       pkg_error.seterrormessage(isbMsgErrr => 'No existe consecutivo activo para el tipo de documento ['||inuTipoDocu||']');
    END IF;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    RETURN nuConsuSig;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(onuError, osbError);
      prCloseCursor;
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RETURN nuConsuSig;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuError, osbError);
      prCloseCursor;
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RETURN nuConsuSig;
  END fnuGetSigConsecutivo;

  PROCEDURE prValidaSolapamientoCons( inuCodigo      IN  recofael.codigo%TYPE,
                                      inuTipoDocu    IN  recofael.tipo_documento%TYPE,
                                      inuConsInicial IN  recofael.cons_inicial%TYPE,
                                      inuConsFinal   IN  recofael.cons_final%TYPE,
									  isbEmpresa	 IN  VARCHAR2,
                                      onuError       OUT NUMBER,
                                      osbError       OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prValidaSolapamientoCons
    Descripcion     : proceso para validar solapamiento de consecutivos

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 10-01-2024

    Parametros de Entrada
      inuCodigo       codigo de identificacion del registro
      inuTipoDocu     tipo de documento
      inuConsInicial  consecutivo inicial
      inuConsFinal    consecutivo final
	  isbEmpresa	  Código de la empresa
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       10-01-2024   OSF-2158    Creacion
	JSOTO	   14-03-2025   OSF-4104    Se agrega parametro entrada isbEmpresa
  ***************************************************************************/
     csbMT_NAME  VARCHAR2(100) := csbSP_NAME || '.prValidaSolapamientoCons';

     sbDatos     VARCHAR2(100);

     CURSOR cuGetSolapamiento IS
     SELECT /*+ index(recofael IDX_RECOFAEL_01 */ recofael.cons_inicial||' - '||recofael.cons_final
     FROM recofael
     WHERE recofael.tipo_documento = inuTipoDocu
         AND recofael.codigo <> inuCodigo
         AND recofael.estado = 'A'
		 AND recofael.empresa = isbEmpresa
         AND ( (inuConsInicial BETWEEN recofael.cons_inicial AND recofael.cons_final)
            OR  (inuConsFinal BETWEEN recofael.cons_inicial AND recofael.cons_final)
            OR (recofael.cons_inicial BETWEEN inuConsInicial AND inuConsFinal)
            OR (recofael.cons_final BETWEEN inuConsInicial AND inuConsFinal));

    PROCEDURE prCloseCursor IS
     csbMT_NAME1      VARCHAR2(150) := csbSP_NAME || '.prCloseCursor';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF cuGetSolapamiento%ISOPEN THEN
           CLOSE cuGetSolapamiento;
        END IF;
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuCodigo => ' || inuCodigo, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' inuTipoDocu => ' || inuTipoDocu, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' inuConsInicial => ' || inuConsInicial, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' inuConsFinal => ' || inuConsFinal, pkg_traza.cnuNivelTrzDef);
	pkg_traza.trace(' isbEmpresa => ' || isbEmpresa, pkg_traza.cnuNivelTrzDef);
    pkg_error.prinicializaerror(onuError, osbError);
    prCloseCursor;
    OPEN cuGetSolapamiento;
    FETCH cuGetSolapamiento INTO sbDatos;
    CLOSE cuGetSolapamiento;

    IF sbDatos IS NOT NULL THEN
         pkg_error.seterrormessage(isbMsgErrr=> 'No se puede realizar el proceso, porque el consecutivo  ya esta contemplado en el rango existente ['||sbDatos||'] ');
    END IF;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(onuError, osbError);
      prCloseCursor;
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuError, osbError);
      prCloseCursor;
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
 END prValidaSolapamientoCons;


  FUNCTION frcgetRecord	( inuTipoDocu  IN  recofael.tipo_documento%TYPE,
						  isbEmpresa   IN  VARCHAR2,
						  inuConsetivo IN  NUMBER,
                          isbEstado    IN  VARCHAR2 DEFAULT 'A',
                          onuError     OUT NUMBER,
                          osbError     OUT VARCHAR2	) RETURN styConsecutivo IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcgetRecord
    Descripcion     : funcion que retorna informacion de consecutivos por tipo de documento

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 10-01-2024

    Parametros de Entrada
      inuTipoDocu     tipo de documento
      inuConsetivo    consecutivo de secuencia
      isbEstado       estado del consecutivo
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       10-01-2024   OSF-2158    Creacion
	JSOTO	   14-03-2025   OSF-4104    Se agrega parametro entrada isbEmpresa
  ***************************************************************************/
      csbMT_NAME  VARCHAR2(100) := csbSP_NAME || '.frcgetRecord';

     V_styConsecutivo       styConsecutivo;
     V_styConsecutivonull	styConsecutivo;

    PROCEDURE prCloseCursor IS
     csbMT_NAME1      VARCHAR2(150) := csbSP_NAME || '.prCloseCursor';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF cuRecord%ISOPEN THEN
           CLOSE cuRecord;
        END IF;
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuTipoDocu => ' || inuTipoDocu, pkg_traza.cnuNivelTrzDef);
    pkg_error.prinicializaerror(onuError, osbError);
    prCloseCursor;

	OPEN cuRecord(inuTipoDocu, inuConsetivo,isbEstado,isbEmpresa);
	FETCH cuRecord INTO V_styConsecutivo;
	IF cuRecord%NOTFOUND THEN
		CLOSE cuRecord;
        V_styConsecutivo := V_styConsecutivonull;
	    pkg_error.seterrormessage(isbMsgErrr=> 'No existe informacion de consecutivos activos para el tipo de documento ['||inuTipoDocu||']');
	END IF;
	CLOSE cuRecord;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	RETURN V_styConsecutivo;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(onuError, osbError);
      prCloseCursor;
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
	  RETURN V_styConsecutivo;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuError, osbError);
      prCloseCursor;
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
	  RETURN V_styConsecutivo;
 END frcgetRecord;
 
end pkg_recofael;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_RECOFAEL','OPEN');
END;
/