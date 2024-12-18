create or replace package adm_person.pkg_parametros is
    FUNCTION fsbVersion RETURN VARCHAR2;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbVersion
        Descripcion     : Retona el identificador del ultimo caso que hizo cambios
        Autor           : Luis Javier Lopez - Horbath
        Fecha           : 21-08-2024
    
        Modificaciones  :
        Autor       Fecha       Caso       Descripcion
        LJLB      15-01-2024   OSF-3140    Creacion
   ***************************************************************************/
   FUNCTION fsbGetValorCadena(isbNombreParametro     IN    parametros.codigo%type ) return varchar2;
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbGetValorCadena
        Descripcion     : funcion que devuelve valor cadena del codigo del parametro ingresado
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023

        Parametros de Entrada
          isbNombreParametro    nombre del parametro

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
    FUNCTION fnuGetValorNumerico(isbNombreParametro   IN    parametros.codigo%type) return number;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbGetValorCadena
        Descripcion     : funcion que devuelve valor numerico del codigo del parametro ingresado
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023

        Parametros de Entrada
          isbNombreParametro    nombre del parametro

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
    FUNCTION fdtGetValorFecha(isbNombreParametro      IN    parametros.codigo%type) return date;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbGetValorCadena
        Descripcion     : funcion que devuelve valor fecha del codigo del parametro ingresado
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023

        Parametros de Entrada
          isbNombreParametro    nombre del parametro

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/

    FUNCTION fnuValidaSiExisteCadena(isbNombreParametro      IN    parametros.codigo%type,
                                     isbSeparador            IN    VARCHAR2,
                                     isbCadena               IN    VARCHAR2
                                    ) return number;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fnuValidaSiExisteCadena
        Descripcion     : funcion que devuelve la cantidad de veces que una cadena se
                          encuentra en un parametro tipo cadena
        Autor           : dsaltarin
        Fecha           : 04-12-2023

        Parametros de Entrada
          isbNombreParametro    nombre del parametro
          isbSeparador          separador
          isbCadena             cadena a buscar

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/

END pkg_parametros;
/
create or replace package body  adm_person.pkg_parametros is
 -- Constantes para el control de la traza
  csbSP_NAME        CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion        CONSTANT VARCHAR2(15) := 'OSF-3140';
  nuError     NUMBER;
  sbError     VARCHAR(4000);
  sbObligatorio   parametros.obligatorio%type;
  sbEstado        parametros.estado%type;
     
     
  
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 21-08-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      15-01-2024   OSF-3140    Creacion
  ***************************************************************************/
   BEGIN
      RETURN csbVersion;
   END fsbVersion;
  
   FUNCTION fsbGetValorCadena(isbNombreParametro     IN    parametros.codigo%type ) return varchar2 IS
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbGetValorCadena
        Descripcion     : funcion que devuelve valor cadena del codigo del parametro ingresado
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023

        Parametros de Entrada
          isbNombreParametro    nombre del parametro

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
       csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.fsbGetValorCadena';
      sbValor         parametros.valor_cadena%type;
      
      CURSOR cuGetValorParametro IS
      SELECT  parametros.valor_cadena, 
              parametros.obligatorio,
              parametros.estado
      FROM parametros
      WHERE parametros.codigo = isbNombreParametro;

    BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      pkg_traza.trace(' isbNombreParametro => ' || isbNombreParametro, pkg_traza.cnuNivelTrzDef);
      IF cuGetValorParametro%ISOPEN THEN
        CLOSE cuGetValorParametro;
      END IF;

      OPEN cuGetValorParametro;
      FETCH cuGetValorParametro INTO sbValor, sbObligatorio, sbEstado;
      IF cuGetValorParametro%NOTFOUND THEN
         pkg_traza.trace(' Parametro [' || isbNombreParametro||'] No existe.', pkg_traza.cnuNivelTrzDef);
         pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
         return null;
      END IF;
      CLOSE cuGetValorParametro;
      
      pkg_traza.trace(' sbValor => ' || sbValor, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' sbObligatorio => ' || sbObligatorio, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' sbEstado => ' || sbEstado, pkg_traza.cnuNivelTrzDef);
      
      IF sbEstado = 'A'   THEN
        IF sbObligatorio = 'S' AND sbValor IS NULL THEN
            pkg_error.setErrorMessage(isbMsgErrr => 'parametro  [' || isbNombreParametro||'] es obligatorio y no tiene dato configurado, por favor valide en la forma MDCPGS.');
        END IF;
      ELSE
        sbValor := NULL;
      END IF;
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

      RETURN sbValor;
     
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
    END fsbGetValorCadena;

    FUNCTION fnuGetValorNumerico(isbNombreParametro   IN    parametros.codigo%type) return number is
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fnuGetValorNumerico
        Descripcion     : funcion que devuelve valor numerico del codigo del parametro ingresado
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023

        Parametros de Entrada
          isbNombreParametro    nombre del parametro

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
      csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.fnuGetValorNumerico';
      nuValor   parametros.valor_numerico%type;
      
      CURSOR cuGetValorParametro IS
      SELECT  parametros.valor_numerico,
              parametros.obligatorio,
              parametros.estado
      FROM parametros
      WHERE parametros.codigo = isbNombreParametro;

    BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      pkg_traza.trace(' isbNombreParametro => ' || isbNombreParametro, pkg_traza.cnuNivelTrzDef);
      IF cuGetValorParametro%ISOPEN THEN
        CLOSE cuGetValorParametro;
      END IF;

      OPEN cuGetValorParametro;
      FETCH cuGetValorParametro INTO nuValor, sbObligatorio, sbEstado;
      IF cuGetValorParametro%NOTFOUND THEN
         pkg_traza.trace(' Parametro [' || isbNombreParametro||'] No existe.', pkg_traza.cnuNivelTrzDef);
         pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
         return null;
      END IF;
      CLOSE cuGetValorParametro;
      
      pkg_traza.trace(' nuValor => ' || nuValor, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' sbObligatorio => ' || sbObligatorio, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' sbEstado => ' || sbEstado, pkg_traza.cnuNivelTrzDef);
      
      IF sbEstado = 'A'   THEN
        IF sbObligatorio = 'S' AND nuValor IS NULL THEN
            pkg_error.setErrorMessage(isbMsgErrr => 'parametro  [' || isbNombreParametro||'] es obligatorio y no tiene dato configurado, por favor valide en la forma MDCPGS.');
        END IF;
      ELSE
        nuValor := NULL;
      END IF;
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
      RETURN nuValor;
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
    END fnuGetValorNumerico;

    FUNCTION fdtGetValorFecha(isbNombreParametro      IN    parametros.codigo%type) return date is
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fdtGetValorFecha
        Descripcion     : funcion que devuelve valor fecha del codigo del parametro ingresado
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023

        Parametros de Entrada
          isbNombreParametro    nombre del parametro

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
      csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.fdtGetValorFecha';
     dtValor   parametros.valor_fecha%type;

     CURSOR cuGetValorParametro IS
     SELECT  parametros.valor_fecha,
             parametros.obligatorio,
             parametros.estado
     FROM parametros
     WHERE parametros.codigo = isbNombreParametro;

    BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      pkg_traza.trace(' isbNombreParametro => ' || isbNombreParametro, pkg_traza.cnuNivelTrzDef);
      IF cuGetValorParametro%ISOPEN THEN
        CLOSE cuGetValorParametro;
      END IF;

      OPEN cuGetValorParametro;
      FETCH cuGetValorParametro INTO dtValor, sbObligatorio, sbEstado;
      IF cuGetValorParametro%NOTFOUND THEN
         pkg_traza.trace(' Parametro [' || isbNombreParametro||'] No existe.', pkg_traza.cnuNivelTrzDef);
         pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
         return null;
      END IF;
      CLOSE cuGetValorParametro;
      
      pkg_traza.trace(' dtValor => ' || dtValor, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' sbObligatorio => ' || sbObligatorio, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' sbEstado => ' || sbEstado, pkg_traza.cnuNivelTrzDef);
      
      IF sbEstado = 'A'   THEN
        IF sbObligatorio = 'S' AND dtValor IS NULL THEN
            pkg_error.setErrorMessage(isbMsgErrr => 'parametro  [' || isbNombreParametro||'] es obligatorio y no tiene dato configurado, por favor valide en la forma MDCPGS.');
        END IF;
      ELSE
        dtValor := NULL;
      END IF;
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

      RETURN dtValor;
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
    END fdtGetValorFecha;
    FUNCTION fnuValidaSiExisteCadena(isbNombreParametro      IN    parametros.codigo%type,
                                     isbSeparador            IN    VARCHAR2,
                                     isbCadena               IN    VARCHAR2
                                    ) return number is
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fnuValidaSiExisteCadena
        Descripcion     : funcion que devuelve la cantidad de veces que una cadena se
                          encuentra en un parametro tipo cadena
        Autor           : dsaltarin
        Fecha           : 04-12-2023

        Parametros de Entrada
          isbNombreParametro    nombre del parametro
          isbSeparador          separador
          isbCadena             cadena a buscar

        Parametros de Salida
        Modificaciones  :
    ***************************************************************************/
      sbValor     parametros.valor_cadena%type;
      nuExiste    NUMBER;
      nuError     NUMBER;
      sbError     VARCHAR2(4000);
      csbMT_NAME  VARCHAR2(4000):='PKG_PARAMETROS.FNUVALIDASIEXISTECADENA';

    BEGIN
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzApi,pkg_traza.csbINICIO);
      sbValor := fsbGetValorCadena(isbNombreParametro);
      sbValor := isbSeparador||sbValor||isbSeparador;
      pkg_traza.trace('sbValor: '||sbValor, pkg_traza.cnuNivelTrzApi);
      nuExiste := instr(sbValor, isbSeparador||isbCadena||isbSeparador);
      pkg_traza.trace('nuExiste: '||nuExiste, pkg_traza.cnuNivelTrzApi);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzApi, pkg_traza.csbFIN);
      return nuExiste;
    EXCEPTION
      WHEN pkg_Error.Controlled_Error  THEN
          pkg_Error.getError(nuError, sbError);
          pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
          return 0;
      --Validación de error no controlado
      WHEN OTHERS THEN
          pkg_Error.setError;
          pkg_Error.getError(nuError, sbError);
          pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
          return 0;
    END fnuValidaSiExisteCadena;
END pkg_parametros;
/
BEGIN
    pkg_utilidades.prAplicarPermisos( 'PKG_PARAMETROS', 'ADM_PERSON');
END;
/