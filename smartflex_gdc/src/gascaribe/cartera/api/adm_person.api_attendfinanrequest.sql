CREATE OR REPLACE PROCEDURE adm_person.api_attendfinanrequest (  inuPackageId	  IN  NUMBER,
                                                                 onuErrorCode     OUT GE_MESSAGE.MESSAGE_ID%TYPE, 
                                                                 osbErrorMessage  OUT GE_ERROR_LOG.DESCRIPTION%TYPE) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : api_attendfinanrequest
    Descripcion     : api Permite realizar la atencion de la solicitud de financiacion
    Autor           : Luis Javier Lopez
    Fecha           : 01-09-2023

    Parametros de Entrada
     inuPackageId          codigo de solicitud
      
    Parametros de Salida
     onuErrorCode          codigo de error
     osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

BEGIN
   UT_TRACE.TRACE('Inicio API_ATTENDFINANREQUEST ', 10);
   OS_ATTENDFINANREQUEST( inuPackageId,                        
                          onuErrorCode,
                          osbErrorMessage );
  UT_TRACE.TRACE('Fin API_ATTENDFINANREQUEST ', 10);
EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_ATTENDFINANREQUEST ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_ATTENDFINANREQUEST ['||osbErrorMessage||']', 10);
END api_attendfinanrequest;
/
BEGIN
 pkg_utilidades.praplicarpermisos('API_ATTENDFINANREQUEST', 'ADM_PERSON');
END;
/