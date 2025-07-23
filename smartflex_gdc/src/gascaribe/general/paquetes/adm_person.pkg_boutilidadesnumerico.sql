CREATE OR REPLACE PACKAGE adm_person.pkg_boutilidadesnumerico AS

    /**************************************************************************
    Propiedad intelectual de Gases del Caribe

    Nombre del Paquete: pkg_boutilidadesnumerico
    Descripcion : Para contener utilidades para valores numericos

    Autor       : Jhon Soto
    Fecha       : 31/01/2025

    Historia de Modificaciones
      Fecha             Autor                Modificacion
    =========         =========          ====================
	31/01/2025			jsoto			OSF-3911 Creacion
   **************************************************************************/

    -- Obtiene la Version actual del Paquete
    FUNCTION fsbVersion RETURN VARCHAR2;
    --------------------------------------------------------------------------
    --Tabla PL para el manejo de valores de Repetibilidad.
    --------------------------------------------------------------------------


    --------------------------------------------------------------------------
    -- Metodos publicos del PACKAGE
    --------------------------------------------------------------------------

    FUNCTION fsbValDatoNumerico
    (
		isbNumber	IN VARCHAR2
    ) RETURN VARCHAR2;


	
END pkg_boutilidadesnumerico;
/
 CREATE OR REPLACE PACKAGE BODY adm_person.pkg_boutilidadesnumerico AS
    /**************************************************************************
    Propiedad intelectual de Gases del Caribe

    Nombre del Paquete: pkg_boutilidadesnumerico
    Descripcion : Para contener utilidades para valores numericos

    Autor       : Jhon Soto
    Fecha       : 31/01/2025

    Historia de Modificaciones
      Fecha             Autor                Modificacion
    =========         =========          ====================
	31/01/2025			jsoto			OSF-3911 Creacion
   **************************************************************************/


    -- Declaracion de variables y tipos globales privados del paquete

    ---------------------------------------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    ---------------------------------------------------------------------------
    csbVersion          CONSTANT VARCHAR2(10) := 'OSF-3911';
    csbSP_NAME          CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';
	
    /*
      Funcion que devuelve la version del pkg*/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
      RETURN csbVersion;
    END fsbVersion;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
  
    Programa      : fsbValDatoNumerico
    Descripcion   : Valida si el dato ingresado como parametro corresponde a un valor numerico
    Autor         : Jhon Soto
    Fecha         : 23-12-2024
  
    Parametros
	  entrada
		inuPlan  Id de plantilla
		inuTipoCertificado  Tipo certificado  Externo o Interno
	    isbNombre  Nombre de columna Solicitado
      Salida
        nuTipoLab	Tipo laboratorio    
  
    Modificaciones  :
    Autor           Fecha       Caso      Descripcion
  ***************************************************************************/

    FUNCTION fsbValDatoNumerico
    (
		isbNumber	IN  VARCHAR2
    ) RETURN VARCHAR2
    IS

	  csbMT_NAME   VARCHAR2(200) := csbSP_NAME || 'fsbValDatoNumerico';
	  
      --  Variables para manejo de Errores
      nuError      NUMBER;
      sberror      VARCHAR2(2000);
      nuNumber     NUMBER;



	  BEGIN

		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

		nuNumber := isbNumber;

		pkg_traza.trace('nuNumber : '|| nuNumber);

		pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

		RETURN 'Y';


		
     EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('sberror: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
	  RETURN 'N';
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('sberror: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
	  RETURN 'N';
    END fsbValDatoNumerico;

END  pkg_boutilidadesnumerico;
/

PROMPT Otorgando permisos de ejecución 
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOUTILIDADESNUMERICO', 'ADM_PERSON');
END;
/