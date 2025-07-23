CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_BOGESTION_NOTIFICACIONES IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    PKG_BOGESTION_NOTIFICACIONES
    Autor       :   Jhon Jairo Soto
    Fecha       :   22/11/2024
    Descripcion :   Paquete con los metodos para gestion de notificaciones
    Modificaciones  :
    Autor               Fecha           Caso        Descripcion    
    PAcosta             04/12/2024      OSF-3612    Migración de la bd de EFG a GDC por ajustes de información de 
                                                    la entidad HOMOLOGACION_SERVICIOS - GDC 
    Jhon Jairo Soto     22/11/2024      OSF-3591    Creacion                                                    
*******************************************************************************/

    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion 
    RETURN VARCHAR2;

    PROCEDURE prcActualizaAtributo(
								osbParamString 	OUT VARCHAR2,
								isbAtributo		IN VARCHAR2,
								inuOrden       	IN NUMBER
							);

    PROCEDURE prcEnviaNotificacion(
									inuNotificationId 	IN NUMBER,
									inuOriginModule   	IN NUMBER,
									isbParamString		IN VARCHAR2,
									inuExternalId		IN ge_notification_log.external_id%type,
									onuNotifica_log		OUT ge_notification_log.notification_log_id%type,
									onuErrorCode		OUT NUMBER,
									osbErrorText		OUT VARCHAR2
								 );


END PKG_BOGESTION_NOTIFICACIONES;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_BOGESTION_NOTIFICACIONES IS


    -- Identificador del ultimo caso que hizo cambios
    csbVersion     VARCHAR2(15) := 'OSF-3612';
    -- Constantes para el control de la traza
    csbSP_NAME     CONSTANT VARCHAR2(35):= $$PLSQL_UNIT;


    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 09/02/2024
    Modificaciones  :
    Autor               Fecha       Caso     Descripcion
    felipe.valencia     09/02/2024  OSF-1909 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;


    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActualizaAtributo
    Descripcion     : Establece los parametros para crear la notificacion
    Autor           : Jhon Soto
    Fecha           : 20-11-2024

	Parametros de entrada
	
		isbAtributo		Atributo a configurar,
		inuOrden       	IN NUMBER


    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    ***************************************************************************/

    PROCEDURE prcActualizaAtributo(
								osbParamString 	OUT VARCHAR2,
								isbAtributo		IN VARCHAR2,
								inuOrden       	IN NUMBER
							)
    IS
        csbMetodo        CONSTANT VARCHAR2(200) := csbSP_NAME||'prcActualizaAtributo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

		Ge_BONotification.SETAttribute(osbParamString,isbAtributo, inuOrden);

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
                RAISE pkg_error.Controlled_Error;
    END prcActualizaAtributo;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcEnviaNotificacion
    Descripcion     : Envía la notificación
    Autor           : Jhon Soto
    Fecha           : 20-11-2024

	Parametros de entrada
	
		inuNotificationId  Id de la notificación
		inuOriginModule    Modulo Origen de la notificación
		isbParamString	   Cadena con los paramtros
		inuExternalId      Id externo del log de la notificación

	Parametrods de salida
		onuNotifica_log		Log del proceso
		onuErrorCode		Error del proceso
		osbErrorText		Descripcion del error


    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    ***************************************************************************/

    PROCEDURE prcEnviaNotificacion(
									inuNotificationId 	IN NUMBER,
									inuOriginModule   	IN NUMBER,
									isbParamString		IN VARCHAR2,
									inuExternalId		IN ge_notification_log.external_id%type,
									onuNotifica_log		OUT ge_notification_log.notification_log_id%type,
									onuErrorCode		OUT NUMBER,
									osbErrorText		OUT VARCHAR2
								 )
    IS
        csbMetodo        CONSTANT VARCHAR2(200) := csbSP_NAME||'prcEnviaNotificacion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

		ge_bonotification.SendNotify (inuNotificationId,inuOriginModule,isbParamString,inuExternalId,
									  onuNotifica_log , onuErrorCode, osbErrorText );

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
                RAISE pkg_error.Controlled_Error;
    END prcEnviaNotificacion;


END PKG_BOGESTION_NOTIFICACIONES;
/
PROMPT Otorgando permisos de ejecución 
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOGESTION_NOTIFICACIONES', 'ADM_PERSON');
END;
/ 