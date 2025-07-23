CREATE OR REPLACE PACKAGE adm_person.pkg_bcutilidadescadenas AS

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe y Efigas
      Autor : jvaliente
      Descr : Paquete para el manejo de servicios con que manipulen y/o modifiquen el contenido de una cadena
      Tabla : pkg_bcutilidadescadenas
      Caso  : OSF-4472
      Fecha : 30/05/2025
    Modificaciones
    =========================================================
    Autor           Fecha       Caso       Descripcion
  ***************************************************************************/

    FUNCTION fsbVersion
    RETURN VARCHAR2;

  --Permite obtener data de una cadena compuesta por 3 delimitadores
  FUNCTION frfObtDataCon3Separadores(isbCadena       IN VARCHAR2,
                                     isbDelimitador1 IN VARCHAR2,
                                     isbDelimitador2 IN VARCHAR2,
                                     isbDelimitador3 IN VARCHAR2)
    RETURN constants_per.tyrefcursor;

  --Permite obtener data de una cadena compuesta por 2 delimitadores
  FUNCTION frfObtDataCon2Separadores(isbCadena       IN VARCHAR2,
                                     isbDelimitador1 IN VARCHAR2,
                                     isbDelimitador2 IN VARCHAR2)
    RETURN constants_per.tyrefcursor;

END pkg_bcutilidadescadenas;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bcutilidadescadenas AS

  csbSP_NAME    CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;
  csbPUSH       CONSTANT VARCHAR2(4) := pkg_traza.fsbINICIO;

    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-4472';

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : fsbVersion
  Descripcion     : ultima Version
  Autor           : Jorge Valiente
  Fecha           : 16-05-2025
  Caso            : OSF-4472
  
  Modificaciones  :
  Autor       Fecha       Caso    Descripcion
  *************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : frfObtDataCon3Separadores
  Descripcion     : Permite obtener data de una cadena compuesta por 3 delimitadores
  Autor           : Jorge Valiente
  Fecha           : 16-05-2025
  Caso            : OSF-4472
  
  Parametros 
    Entrada:
      isbCadena           Cadena con la DATA a seperar con 3 delimitadores
      isbDelimitador1     Delimitador Principal (Incial que separa un grupo de datos)
      isbDelimitador2     Delimitador Secundario (Establece el Dato llave (Principal) de cada grupo)
      isbDelimitador3     Delimitador Final (Data hija del Dato llave (principal))
  
      Ejemplo
        Cadena
           12669;3812,3813,3814,3800|12673;9037
        Resultado
          NOMBRE  VALOR
          12669   3812
          12669   3813
          12669   3814
          12669   3800
          12673   9037
  
    Salida:
      rfDataCadena constants_per.tyrefcursor
  
  Modificaciones  :
  Autor       Fecha       Caso    Descripcion
  *************************************************************************/
  FUNCTION frfObtDataCon3Separadores(isbCadena       IN VARCHAR2,
                                     isbDelimitador1 IN VARCHAR2,
                                     isbDelimitador2 IN VARCHAR2,
                                     isbDelimitador3 IN VARCHAR2)
    RETURN constants_per.tyrefcursor IS
    csbMT_NAME     VARCHAR2(70) := csbSP_NAME || 'ftbObtCadenaSeparada';
    nuErrorCode    number;
    sbErrorMessage varchar2(4000);
  
    sbSQLSelect VARCHAR2(4000) := null;
  
    rfDataCadena constants_per.tyrefcursor;
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME, csbNivelTraza, csbPUSH);
  
    sbSQLSelect := 'WITH datos AS
   (SELECT ''' || isbCadena ||
                   ''' AS cadena FROM dual),
  -- 1. Separar cada bloque por ''|''
  bloques AS
   (SELECT REGEXP_SUBSTR(''' || isbCadena || ''', ''[^' ||
                   isbDelimitador1 ||
                   ']+'', 1, LEVEL) AS bloque
      FROM datos
    CONNECT BY LEVEL <= REGEXP_COUNT(''' || isbCadena ||
                   ''', ''\' || isbDelimitador1 ||
                   ''') + 1),
  -- 2. Separar llave y lista de valor
  llave_y_valor AS
   (SELECT TRIM(REGEXP_SUBSTR(bloque, ''[^' ||
                   isbDelimitador2 ||
                   ']+'', 1, 1)) AS llave,
           TRIM(REGEXP_SUBSTR(bloque, ''[^' ||
                   isbDelimitador2 ||
                   ']+'', 1, 2)) AS valor
      FROM bloques),
  -- 3. Separar los valor por coma
  valor_individuales AS
   (SELECT llave, TRIM(REGEXP_SUBSTR(valor, ''[^' ||
                   isbDelimitador3 ||
                   ']+'', 1, LEVEL)) AS valor
      FROM llave_y_valor
    CONNECT BY PRIOR llave = llave
           AND PRIOR SYS_GUID() IS NOT NULL
           AND LEVEL <= REGEXP_COUNT(valor, ''' ||
                   isbDelimitador1 || ''') + 1)
  -- 4. Resultado final
  SELECT llave, valor
    FROM valor_individuales
   WHERE valor IS NOT NULL
   ORDER BY llave';
  
    pkg_traza.trace('Sentencia [' || sbSQLSelect || ']', csbNivelTraza);
  
    OPEN rfDataCadena FOR sbSQLSelect;
  
    pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN);
  
    RETURN rfDataCadena;
  
  EXCEPTION
  
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuErrorCode, sbErrorMessage);
      pkg_traza.trace('sberror: ' || sbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbErrorMessage);
      pkg_traza.trace('sberror: ' || sbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
    
  END frfObtDataCon3Separadores;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : frfObtDataCon2Separadores
  Descripcion     : Permite obtener data de una cadena compuesta por 3 delimitadores
  Autor           : Jorge Valiente
  Fecha           : 16-05-2025
  Caso            : OSF-4472
  
  Parametros 
    Entrada:
      isbCadena           Cadena con la DATA a seperar con 2 delimitadores
      isbDelimitador1     Delimitador Principal (Establece el Dato llave (Principal) de cada grupo)
      isbDelimitador2     Delimitador Final (Data hija del Dato llave (principal))
  
      Ejemplo
        Cadena
           12149|30;12162|674;12150|19;10268|3
        Resultado
          NOMBRE  VALOR
          12149   30
          12162   674
          12150   19
          10268   3
  
    Salida:
      rfDataCadena constants_per.tyrefcursor
  
  Modificaciones  :
  Autor       Fecha       Caso    Descripcion
  *************************************************************************/
  FUNCTION frfObtDataCon2Separadores(isbCadena       IN VARCHAR2,
                                     isbDelimitador1 IN VARCHAR2,
                                     isbDelimitador2 IN VARCHAR2)
    RETURN constants_per.tyrefcursor IS
    csbMT_NAME     VARCHAR2(70) := csbSP_NAME || 'ftbObtCadenaSeparada';
    nuErrorCode    number;
    sbErrorMessage varchar2(4000);
  
    sbSQLSelect VARCHAR2(4000) := null;
  
    rfDataCadena constants_per.tyrefcursor;
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME, csbNivelTraza, csbPUSH);
  
    sbSQLSelect := 'WITH datos AS
     (SELECT (regexp_substr(''' || isbCadena || ''',
                            ''[^' || isbDelimitador1 ||
                   ']+'',
                            1,
                            LEVEL)) AS cadena
        FROM dual
      CONNECT BY regexp_substr(''' || isbCadena || ''',
                               ''[^' || isbDelimitador1 ||
                   ']+'',
                               1,
                               LEVEL) IS NOT NULL)
    SELECT substr(cadena, 1, instr(cadena, ''' ||
                   isbDelimitador2 ||
                   ''') - 1) llave,
           substr(cadena, instr(cadena, ''' ||
                   isbDelimitador2 || ''') + 1, LENGTH(cadena)) valor
      FROM datos';
  
    pkg_traza.trace('Sentencia [' || sbSQLSelect || ']', csbNivelTraza);
  
    OPEN rfDataCadena FOR sbSQLSelect;
  
    pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN);
  
    RETURN rfDataCadena;
  
  EXCEPTION
  
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuErrorCode, sbErrorMessage);
      pkg_traza.trace('sberror: ' || sbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbErrorMessage);
      pkg_traza.trace('sberror: ' || sbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
    
  END frfObtDataCon2Separadores;

END pkg_bcutilidadescadenas;
/
BEGIN
  pkg_Utilidades.prAplicarPermisos(UPPER('pkg_bcutilidadescadenas'),
                                   UPPER('adm_person'));
END;
/
