CREATE OR REPLACE PROCEDURE ADM_PERSON.API_CUSTOMERUPDATE (inusubscriber_id	      IN	NUMBER,
                                                            inuident_type_id	      IN	NUMBER,
                                                            isbidentification	      IN	VARCHAR2,
                                                            inuparent_subscriber_id	IN	NUMBER,
                                                            inusubscriber_type_id	IN	NUMBER,
                                                            isbaddress	            IN	VARCHAR2,
                                                            isbphone	               IN	VARCHAR2,
                                                            isbsubscriber_name	   IN	VARCHAR2,
                                                            isbsubs_last_name	      IN	VARCHAR2,
                                                            isbe_mail	            IN	VARCHAR2,
                                                            isburl	               IN	VARCHAR2,
                                                            isbcontact_phone	      IN	VARCHAR2,
                                                            isbcontact_address	   IN	VARCHAR2,
                                                            isbcontact_name	      IN	VARCHAR2,
                                                            inucontact_ident_type	IN	NUMBER,
                                                            isbcontact_ident	      IN	VARCHAR2,
                                                            inuMarketing_segment_id	IN	NUMBER,
                                                            inusubs_status_id	      IN	NUMBER,
                                                            isbSex	               IN	VARCHAR2,
                                                            idtBirthDate	         IN	DATE,
                                                            onuErrorCode            OUT GE_MESSAGE.MESSAGE_ID%TYPE,
                                                            osbErrorMessage         OUT GE_ERROR_LOG.DESCRIPTION%TYPE) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : API_CUSTOMERUPDATE
    Descripcion     : api permite actualizar los datos de cliente

    Autor           : Diana Saltarin
    Fecha           : 01-09-2023

    Parametros de Entrada
      inusubscriber_id	      Código de cliente
      inuident_type_id	      Tipo de identificación
      isbidentification	      Identificación
      inuparent_subscriber_id	Consecutivo del suscriptor
      inusubscriber_type_id	Tipo de cliente
      isbaddress	            Dirección
      isbphone	               Teléfono
      isbsubscriber_name	   Nombre
      isbsubs_last_name	      Apellido
      isbe_mail	            Correo electrónico
      isburl	               URL del cliente
      isbcontact_phone	      Teléfono del contacto
      isbcontact_address	   Dirección del contacto
      isbcontact_name	      Nombre del contacto
      inucontact_ident_type	Tipo de identificación del contacto
      isbcontact_ident	      Identificación del contacto
      inuMarketing_segment_id	Segmento de mercado
      inusubs_status_id	      Estado
      isbSex	               Género
      idtBirthDate	         Fecha de Nacimiento


    Parametros de Salida
     onuErrorCode          codigo de error
     osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

BEGIN
   UT_TRACE.TRACE('Inicio API_CUSTOMERUPDATE ', 10);
   Pkg_Error.prInicializaError(onuErrorCode, 
                               osbErrorMessage);
   OS_CUSTOMERUPDATE (inusubscriber_id,
                     inuident_type_id,
                     isbidentification,
                     inuparent_subscriber_id,
                     inusubscriber_type_id,
                     isbaddress,
                     isbphone,
                     isbsubscriber_name,
                     isbsubs_last_name,
                     isbe_mail,
                     isburl,
                     isbcontact_phone,
                     isbcontact_address,
                     isbcontact_name,
                     inucontact_ident_type,
                     isbcontact_ident,
                     inuMarketing_segment_id,
                     inusubs_status_id,
                     isbSex,
                     idtBirthDate,
                     onuErrorCode,
                     osbErrorMessage
                     );
  UT_TRACE.TRACE('Fin API_CUSTOMERUPDATE ', 10);
EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_CUSTOMERUPDATE ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_CUSTOMERUPDATE ['||osbErrorMessage||']', 10);
END API_CUSTOMERUPDATE;
/
BEGIN

	pkg_utilidades.prAplicarPermisos('API_CUSTOMERUPDATE', 'ADM_PERSON'); 

END;
/

