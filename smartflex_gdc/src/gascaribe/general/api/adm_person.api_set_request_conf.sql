CREATE OR REPLACE PROCEDURE ADM_PERSON.API_SET_REQUEST_CONF (isbRequestsConf	   IN OUT	  CLOB,
                                                             onuErrorCode        OUT  GE_MESSAGE.MESSAGE_ID%TYPE,
                                                             osbErrorMessage     OUT  GE_ERROR_LOG.DESCRIPTION%TYPE) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : API_SET_REQUEST_CONF
    Descripcion     : api permite al ERP realizar la confirmación de la solicitud recibida..

    Autor           : Diana Saltarin
    Fecha           : 01-09-2023

    Parametros de Entrada /Salida
    isbRequestsConf	   Texto XML con Solicitud Confirmada.
    


    Parametros de Salida
     onuErrorCode          codigo de error
     osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

BEGIN
   UT_TRACE.TRACE('Inicio API_SET_REQUEST_CONF ', 10);
   Pkg_Error.prInicializaError(onuErrorCode, 
                               osbErrorMessage);
   OS_SET_REQUEST_CONF (isbRequestsConf,
                        onuErrorCode,
                        osbErrorMessage
                        );
  UT_TRACE.TRACE('Fin API_SET_REQUEST_CONF ', 10);
EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_SET_REQUEST_CONF ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_SET_REQUEST_CONF ['||osbErrorMessage||']', 10);
END API_SET_REQUEST_CONF;
/
BEGIN

	pkg_utilidades.prAplicarPermisos('API_SET_REQUEST_CONF', 'ADM_PERSON'); 

END;
/

