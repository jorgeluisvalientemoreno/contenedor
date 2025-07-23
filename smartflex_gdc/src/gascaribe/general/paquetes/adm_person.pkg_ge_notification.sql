CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_GE_NOTIFICATION IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      PKG_GE_NOTIFICATION
      Autor       :   Jhon Soto
      Fecha       :   20-11-2024
      Descripcion :   Paquete con los metodos CRUD para manejo de informacion
                      sobre la entidad GE_NOTIFICATION
      Modificaciones  :
      Autor       Fecha      Caso       Descripcion
      04/12/2024  PAcosta    OSF-3612   Migración de la bd de EFG a GDC por ajustes de información de 
                                        la entidad HOMOLOGACION_SERVICIOS - GDC 
  *******************************************************************************/

  -- Retona Identificador del ultimo caso que hizo cambios en este archivo
  FUNCTION fsbVersion RETURN VARCHAR2;

    FUNCTION fnuObtNotifiPorPlantilla
    (
      inuIdPlantilla          in       ldc_plantemp.pltexste%type
    ) return number;

    FUNCTION fnugetModuloOrigen
    (
      inuIdNotificacion          in       ge_notification.notification_id%type
    ) return number;



END PKG_GE_NOTIFICATION;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_GE_NOTIFICATION IS

  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-3612';

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete
    Autor           : Jhon Soto
    Fecha           : 20-11-2024
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;


    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtNotifiPorPlantilla
    Descripcion     : Retona Id de la notificación dado el id de la plantilla
    Autor           : Jhon Soto
    Fecha           : 20-11-2024
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    ***************************************************************************/

    FUNCTION fnuObtNotifiPorPlantilla
    (
      inuIdPlantilla          in       ldc_plantemp.pltexste%type
    ) return number
    IS

      nuIdNotificacion              ge_notification.notification_id%type;

	  nuError		 				NUMBER;  
	  sberror	 					VARCHAR2(1000);
      csbMT_NAME  				 	VARCHAR2(200) := csbSP_NAME || 'fnuObtNotifiPorPlantilla';

      -- CURSOR que busca el Id de la notificaci?n
      CURSOR cuNotificacion(inuXSL_temp in ldc_plantemp.pltevate%type ) IS
        select notification_id 
		FROM ge_notification
        WHERE xsl_template_id = inuXSL_temp
        AND rownum  = 1;

    BEGIN
   	pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

      for e in cuNotificacion(inuIdPlantilla) loop
        nuIdNotificacion := e.notification_id;
      end loop;

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

      return nuIdNotificacion;

    EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('sberror: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('sberror: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;

    END fnuObtNotifiPorPlantilla;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnugetModuloOrigen
    Descripcion     : Retona Id del modulo origen de la notificacion
    Autor           : Jhon Soto
    Fecha           : 20-11-2024
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    ***************************************************************************/

    FUNCTION fnugetModuloOrigen
    (
      inuIdNotificacion          in       ge_notification.notification_id%type
    ) return number
    IS

      nuIdModuloOrigen              ge_notification.notification_id%type;

	  nuError		 				NUMBER;  
	  sberror	 					VARCHAR2(1000);
      csbMT_NAME  				 	VARCHAR2(200) := csbSP_NAME || 'fnugetModuloOrigen';

      -- CURSOR que busca el Id del modulo origen
      CURSOR cuNotificacion IS
        select origin_module_id 
		FROM ge_notification
        WHERE notification_id = inuIdNotificacion;

    BEGIN
   	pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

      OPEN cuNotificacion;
	  FETCH cuNotificacion INTO nuIdModuloOrigen;
	  CLOSE cuNotificacion;

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

      return nuIdModuloOrigen;

    EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('sberror: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('sberror: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;

    END fnugetModuloOrigen;


END PKG_GE_NOTIFICATION;
/

BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_GE_NOTIFICATION', 'ADM_PERSON');
END;
/
