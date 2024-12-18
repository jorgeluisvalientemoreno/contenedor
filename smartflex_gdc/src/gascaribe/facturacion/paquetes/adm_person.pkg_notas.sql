create or replace PACKAGE  adm_person.pkg_notas IS
 FUNCTION fsbVersion RETURN VARCHAR2 ;

  PROCEDURE prActualizaFechagen ( inuNota       IN  notas.notanume%type,
                                  idtFechagen   IN  notas.notafecr%type);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaFechagen
    Descripcion     : proceso que actualiza fecha de generacion de una nota

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 27-06-2024

    Parametros de Entrada
        inuNota        codigo de la nota
        idtFechagen    fecha de generacion
    Parametros de Salida       
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    LJLB       27-06-2024   OSF-2913     Creacion
  ***************************************************************************/
END pkg_notas;
/
create or replace PACKAGE BODY  adm_person.pkg_notas IS
  -- Constantes para el control de la traza
   csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
   -- Identificador del ultimo caso que hizo cambios
   csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2158';

   FUNCTION fsbVersion RETURN VARCHAR2 IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 127-06-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       27-06-2024   OSF-2913    Creacion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  PROCEDURE prActualizaFechagen ( inuNota       IN  notas.notanume%type,
                                  idtFechagen   IN  notas.notafecr%type) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaFechagen
    Descripcion     : proceso que actualiza fecha de generacion de una nota

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 27-06-2024

    Parametros de Entrada
        inuNota        codigo de la nota
        idtFechagen    fecha de generacion
    Parametros de Salida       
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    LJLB       27-06-2024   OSF-2913     Creacion
  ***************************************************************************/
   csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prActualizaFechagen';
    nuError  NUMBER;
    sbError  VARCHAR2(4000);

  BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
	  pkg_traza.trace(' inuNota => ' || inuNota, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' idtFechagen => ' || idtFechagen, pkg_traza.cnuNivelTrzDef);
      UPDATE notas SET notafecr = idtFechagen, 
                       notafeco = trunc(idtFechagen)
      WHERE notanume = inuNota;
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
 END prActualizaFechagen;
END pkg_notas;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_NOTAS','ADM_PERSON');
END;
/