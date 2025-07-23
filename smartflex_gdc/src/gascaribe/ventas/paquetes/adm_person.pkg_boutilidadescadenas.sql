CREATE OR REPLACE PACKAGE adm_person.pkg_boutilidadescadenas AS

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe y Efigas
      Autor : jvaliente
      Descr : Paquete para el manejo de servicios con que manipulen y/o modifiquen el contenido de una cadena
      Tabla : pkg_boutilidadescadenas
      Caso  : OSF-3839
      Fecha : 10/01/2025
    Modificaciones
    =========================================================
    Autor           Fecha       Caso       Descripcion
    dsaltarin       19-03-2025  OSF-4059   Se agrega función ftbObtCadenaSeparada
    Jorge Valiente  20/05/2025  OSF-4472   Se agrega función frfObtDataCon3Separadores
    Jorge Valiente  20/05/2025  OSF-4472   Se agrega función frfObtDataCon2Separadores    
  ***************************************************************************/

  TYPE tytbCadenaSeparada IS TABLE OF VARCHAR2(32767) INDEX BY BINARY_INTEGER;
  tblStringTable tytbCadenaSeparada;
  -- Servicio para buscar una subcadena en una cadena mediante el filtro de 2 delimitadores
  FUNCTION fblBuscarValorEnCadena(isbCadena              IN VARCHAR2,
                                  isbBuscarAtributo      IN VARCHAR2,
                                  isbDelimitadorAtributo IN VARCHAR2,
                                  isbDelimitadorValor    IN VARCHAR2,
                                  osbValor               IN OUT NOCOPY VARCHAR2)
    RETURN BOOLEAN;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : ftbObtCadenaSeparada
  Descripcion     : Retorna una tabla pl con los tokens de la cadena
                    Migrado del paquete ldc_bcconsgenerales.ftbObtCadenaSeparada
  Autor           : Diana Saltarin Soto
  Fecha           : 26-05-2023
  Modificaciones  :
  Autor       Fecha       Caso    Descripcion
  
  *************************************************************************/
  FUNCTION ftbObtCadenaSeparada(isbCadena    IN VARCHAR2,
                                isbSeparador IN VARCHAR2)
    RETURN tytbCadenaSeparada;

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

END pkg_boutilidadescadenas;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_boutilidadescadenas AS

  csbSP_NAME    CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;
  csbPUSH       CONSTANT VARCHAR2(4) := pkg_traza.fsbINICIO;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fblBuscarValorEnCadena
    Descripcion     : Servicio para buscar una subcadena en una cadena mediante el filtro de 2 delimitadores
    Autor           : Jorge Valiente
    Fecha           : 10-01-2025
  
    Parametros
      Entrada
        isbCadena                   Cadena de donde se obtendra el valor a retornar
        isbBuscarAtributo           Nombre del Atributo con el que se se realizara la busqueda del valor
        isbDelimitadorAtributo      1er Delimitador que realizar la seperacion de los atributos contenidos en la cadena 
        isbDelimitadorValor         2do Delimitador que indica de donde se obtendra el valor a sustraer despues del nombre del atributo
        
      Salida
        osbValor                    Valor a retornar y relacionado con el atributo configurado de la cadena
          
    Modificaciones
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  FUNCTION fblBuscarValorEnCadena(isbCadena              IN VARCHAR2,
                                  isbBuscarAtributo      IN VARCHAR2,
                                  isbDelimitadorAtributo IN VARCHAR2,
                                  isbDelimitadorValor    IN VARCHAR2,
                                  osbValor               IN OUT NOCOPY VARCHAR2)
    RETURN BOOLEAN IS
  
    csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME ||
                                        'fblBuscarValorEnCadena'; --nombre del metodo
    onuErrorCode    NUMBER;
    osbErrorMessage VARCHAR2(4000);
  
    blResultado BOOLEAN := FALSE;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Cadena: ' || isbCadena, csbNivelTraza);
    pkg_traza.trace('Atributo a Buscar: ' || isbBuscarAtributo,
                    csbNivelTraza);
    pkg_traza.trace('1er Delimitador Atributo: ' || isbDelimitadorAtributo,
                    csbNivelTraza);
    pkg_traza.trace('2do Delimitador Valor: ' || isbDelimitadorValor,
                    csbNivelTraza);
  
    pkg_traza.trace('Ejecucion del servicio UT_STRING.FINDPARAMETERVALUE',
                    csbNivelTraza);
  
    osbValor := NULL;
  
    blResultado := UT_STRING.FINDPARAMETERVALUE(isbCadena,
                                                isbBuscarAtributo,
                                                isbDelimitadorAtributo,
                                                isbDelimitadorValor,
                                                osbValor);
  
    pkg_traza.trace('Valor: ' || osbValor, csbNivelTraza);
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
    RETURN(blResultado);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      RETURN(blResultado);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      RETURN(blResultado);
    
  END fblBuscarValorEnCadena;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : ftbObtCadenaSeparada
  Descripcion     : Retorna una tabla pl con los tokens de la cadena
                    Migrado del paquete ldc_bcconsgenerales.ftbObtCadenaSeparada
  Autor           : Diana Saltarin Soto
  Fecha           : 26-05-2023
  Modificaciones  :
  Autor       Fecha       Caso    Descripcion
  
  *************************************************************************/
  FUNCTION ftbObtCadenaSeparada(isbCadena    IN VARCHAR2,
                                isbSeparador IN VARCHAR2)
    RETURN tytbCadenaSeparada IS
    csbMT_NAME VARCHAR2(70) := csbSP_NAME || 'ftbObtCadenaSeparada';
  
    sbExpresion   VARCHAR2(20) := '[^' || isbSeparador || ']+';
    nuUltPosicion PLS_INTEGER;
    nuPosicion    PLS_INTEGER := 0;
    nuControl     PLS_INTEGER := 1;
    chDelimitador VARCHAR2(1) := SUBSTR(isbSeparador, 1);
  
    tbSplitString tytbCadenaSeparada;
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME, csbNivelTraza, csbPUSH);
  
    pkg_traza.trace('isbCadena: ' || isbCadena || chr(10) ||
                    'isbSeparador: ' || isbSeparador,
                    csbNivelTraza);
  
    IF NVL(LENGTH(chDelimitador), 0) = 0 OR
       NVL(LENGTH(isbSeparador), 0) = 0 OR isbCadena IS NULL THEN
      RETURN tbSplitString;
    END IF;
  
    LOOP
      nuUltPosicion := nuPosicion + 1;
      nuPosicion    := INSTR(isbCadena, chDelimitador, nuUltPosicion);
    
      IF nuUltPosicion > 0 AND nuPosicion = 0 THEN
        tbSplitString(nuControl) := SUBSTR(isbCadena,
                                           nuUltPosicion,
                                           LENGTH(isbCadena));
      END IF;
    
      EXIT WHEN nuPosicion = 0;
      tbSplitString(nuControl) := SUBSTR(isbCadena,
                                         nuUltPosicion,
                                         nuPosicion - nuUltPosicion);
      IF nuPosicion = LENGTH(isbCadena) THEN
        tbSplitString(nuControl + 1) := NULL;
      END IF;
    
      nuControl := nuControl + 1;
    END LOOP;
  
    pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN);
  
    RETURN tbSplitString;
  
  EXCEPTION
    WHEN OTHERS THEN
      pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERR);
      RETURN tbSplitString;
  END ftbObtCadenaSeparada;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : frfObtDataCon3Separadores
  Descripcion     : Permite obtener data de una cadena compuesta por 3 delimitadores
  Autor           : Jorge Valiente
  Fecha           : 16-05-2025
  
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
  
    rfDataCadena constants_per.tyrefcursor;
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME, csbNivelTraza, csbPUSH);
  
    rfDataCadena := pkg_bcutilidadescadenas.frfObtDataCon3Separadores(isbCadena,
                                                                      isbDelimitador1,
                                                                      isbDelimitador2,
                                                                      isbDelimitador3);
  
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
  
    rfDataCadena constants_per.tyrefcursor;
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME, csbNivelTraza, csbPUSH);
  
    rfDataCadena := pkg_bcutilidadescadenas.frfObtDataCon2Separadores(isbCadena,
                                                                      isbDelimitador1,
                                                                      isbDelimitador2);
  
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

END pkg_boutilidadescadenas;
/
BEGIN
  pkg_Utilidades.prAplicarPermisos(UPPER('pkg_boutilidadescadenas'),
                                   UPPER('adm_person'));
END;
/
