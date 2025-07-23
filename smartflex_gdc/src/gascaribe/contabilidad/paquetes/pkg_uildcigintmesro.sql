create or replace package pkg_uildcigintmesro AS

 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retorna la version del paquete

    Autor           : Jhon Jairo Soto
    Fecha           : 10-04-2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

  FUNCTION fsbVersion RETURN VARCHAR2;

 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObjeto
    Descripcion     : procesa la informacion para PB LDCIGINTMESRO

    Autor           : Jhon Jairo Soto
    Fecha           : 10-04-2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

  PROCEDURE prcObjeto;
  
  END pkg_uildcigintmesro;
  
  /
  
  create or replace PACKAGE BODY pkg_uildcigintmesro IS

   -- Constantes para el control de la traza
  csbSP_NAME     CONSTANT VARCHAR2(200):= $$PLSQL_UNIT||'.';
  -- Identificador del ultimo caso que hizo cambios
  csbVersion     VARCHAR2(200) := 'OSF-4202';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Jhon Jairo Soto
    Fecha           : 10-04-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;



PROCEDURE prcObjeto IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObjeto
    Descripcion     : proceso para PB LDCIGINTMESRO

    Autor           : Jhon Jairo Soto
    Fecha           : 10-04-2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

	  nuErrorCode    	NUMBER;
	  sbErrorMessage 	VARCHAR2(4000);
      csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'prcObjeto';

      cnunull_attribute   CONSTANT NUMBER := 2126;
      nuAnio              ge_boinstancecontrol.stysbvalue;
      nuMes               ge_boinstancecontrol.stysbvalue;
      sbTipoInterfaz      ge_boinstancecontrol.stysbvalue;


BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

      --<<Se realiza la asignacion de los valores de los campos a las variables definidas>>--
      nuAnio := ge_boinstancecontrol.fsbgetfieldvalue ('LDCI_PERIPROGINTE', 'ANO');

      nuMes :=  ge_boinstancecontrol.fsbgetfieldvalue ('LDCI_PERIPROGINTE', 'MES');
	  
      sbTipoInterfaz := ge_boinstancecontrol.fsbgetfieldvalue  ('LDCI_TIPOINTERFAZ', 'TIPOINTERFAZ');

     --<<Valida los parametros del reporte que no esten en Nullo-->>
      IF (sbTipoInterfaz IS NULL)
      THEN
         pkg_error.setErrorMessage (cnunull_attribute, 'Debe Indicar Tipo Interfaz ');
      END IF;

      --<<VAlida los parametros del reporte que no esten en Nullo-->>
      IF (nuAnio IS NULL)
      THEN
          pkg_error.setErrorMessage (cnunull_attribute, 'Ano');
      END IF;

      IF (nuMes IS NULL)
      THEN
          pkg_error.setErrorMessage (cnunull_attribute, 'Mes');
      END IF;

      IF (nuAnio < 1999)
      THEN
          pkg_error.setErrorMessage (2741, 'El Ano es invalido');
      END IF;

      IF (nuMes < 1 or nuMes>12)
      THEN
          pkg_error.setErrorMessage (2741, 'El Mes es invalido');
      END IF;

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbErrorMessage);
      pkg_traza.trace('sbErrorMessage: ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbErrorMessage);
      pkg_traza.trace('sbErrorMessage: ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
END prcObjeto;


END pkg_uildcigintmesro;
/
PROMPT Otorgando permisos de ejecución 
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_uildcigintmesro'), upper('open'));
END;
/