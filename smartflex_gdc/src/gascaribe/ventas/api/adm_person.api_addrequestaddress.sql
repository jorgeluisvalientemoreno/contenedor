CREATE OR REPLACE PROCEDURE adm_person.api_addrequestaddress (  inuPackageId	  IN  NUMBER,
                                                                inuAddressId      IN  NUMBER,
                                                                onuErrorCode     OUT GE_MESSAGE.MESSAGE_ID%TYPE, 
                                                                osbErrorMessage  OUT GE_ERROR_LOG.DESCRIPTION%TYPE) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : api_addrequestaddress
    Descripcion     : api permite asociar direcciones a una solicitud de Venta a Constructoras
    Autor           : Luis Javier Lopez
    Fecha           : 01-09-2023

    Parametros de Entrada
     inuPackageId          codigo de solicitud
     inuAddressId          codigo de la direccion 
    Parametros de Salida
     onuErrorCode          codigo de error
     osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

BEGIN
   UT_TRACE.TRACE('Inicio API_ADDREQUESTADDRESS ', 10);
   os_addrequestaddress( inuPackageId,                        
                         inuAddressId,
                         onuErrorCode,
                         osbErrorMessage );
  UT_TRACE.TRACE('Fin API_ADDREQUESTADDRESS ', 10);
EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_ADDREQUESTADDRESS ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_ADDREQUESTADDRESS ['||osbErrorMessage||']', 10);
END api_addrequestaddress;
/
BEGIN
 pkg_utilidades.praplicarpermisos('API_ADDREQUESTADDRESS', 'ADM_PERSON');
END;
/