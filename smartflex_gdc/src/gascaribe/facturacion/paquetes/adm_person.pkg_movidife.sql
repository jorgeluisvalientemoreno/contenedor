CREATE OR REPLACE PACKAGE adm_person.pkg_movidife IS
  CURSOR cuObtRegistro (inuDiferido IN movidife.modidife%type) IS
  SELECT movidife.*, movidife.rowid
  FROM movidife
  WHERE movidife.modidife = inuDiferido;

  SUBTYPE sbtMoviDife IS movidife%ROWTYPE;
  SUBTYPE sbtMoviDiferido IS cuObtRegistro%ROWTYPE;

  FUNCTION fsbVersion RETURN VARCHAR2;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-01-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2025   OSF-3855    Creacion
  ***************************************************************************/

  PROCEDURE prcInsertarMoviDife (ircMovidife IN sbtMoviDife);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcInsertarMoviDife
    Descripcion     : proceso que inserta en la de movidife
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-01-2025
    
    Parametros Entrada
     ircMovidife        registro de movidife
    Parametros de salida
    
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2025   OSF-3855    Creacion
  ***************************************************************************/
  FUNCTION frcObtInfoMoviDife (inuDiferido IN movidife.modidife%type) RETURN sbtMoviDiferido;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcObtInfoMoviDife
    Descripcion     : Retona infromacion de movimientos de diferido
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-01-2025

    Parametros Entrada
     inuDiferido  codigo del diferido
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2025   OSF-3855    Creacion
  ***************************************************************************/
END pkg_movidife;
/
create or replace PACKAGE BODY  adm_person.pkg_movidife IS
  -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-3855';

    -- Constantes para el control de la traza
    csbSP_NAME     CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.'; 
    cnuNVLTRC      CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef; 
    nuError     NUMBER; 
    sbError     VARCHAR2(4000);
    FUNCTION fsbVersion RETURN VARCHAR2 IS
      /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbVersion
        Descripcion     : Retona el identificador del ultimo caso que hizo cambios
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 22-11-2024

        Modificaciones  :
        Autor       Fecha       Caso       Descripcion
        LJLB      22-11-2024   OSF-3540    Creacion
      ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fsbVersion';
    BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('csbVersion => ' || csbVersion, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN csbVersion;
     EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
  END fsbVersion;
  PROCEDURE prcInsertarMoviDife (ircMovidife IN sbtMoviDife) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcInsertarMoviDife
    Descripcion     : proceso que inserta en la de movidife
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-01-2025
    
    Parametros Entrada
     ircMovidife        registro de movidife
    Parametros de salida
    
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2025   OSF-3855    Creacion
   ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcInsertarMoviDife';
    BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        -- Adiciona movimiento diferido
        pktblMoviDife.InsRecord(ircMovidife);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
     EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
  END prcInsertarMoviDife;
  PROCEDURE prCierracuObtRegistro IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prCierracuObtRegistro
    Descripcion     : proceso que cierra cursor cuObtRegistro
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-01-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2025   OSF-3855    Creacion
  ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcInsertarMoviDife';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     IF cuObtRegistro%ISOPEN THEN CLOSE cuObtRegistro; END IF;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
  END prCierracuObtRegistro;
  FUNCTION frcObtInfoMoviDife (inuDiferido IN movidife.modidife%type) RETURN sbtMoviDiferido IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcObtInfoMoviDife
    Descripcion     : Retona infromacion de movimientos de diferido
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-01-2025

    Parametros Entrada
     inuDiferido  codigo del diferido
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2025   OSF-3855    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.frcObtInfoMoviDife';
    rcMovidife   sbtMoviDiferido;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuDiferido => ' || inuDiferido, pkg_traza.cnuNivelTrzDef);
    prCierracuObtRegistro;
    OPEN cuObtRegistro(inuDiferido);
    FETCH cuObtRegistro INTO rcMovidife;
    CLOSE cuObtRegistro;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN rcMovidife;
  EXCEPTION
   WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        prCierracuObtRegistro;
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        prCierracuObtRegistro;
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
  END frcObtInfoMoviDife;
END pkg_movidife;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_MOVIDIFE','ADM_PERSON'); 
END;
/
