CREATE OR REPLACE PROCEDURE ADM_PERSON.API_ACCEPT_ITEM (iclXMLAcceptItems	      IN	CLOB,
                                                         onuErrorCode      OUT GE_MESSAGE.MESSAGE_ID%TYPE,
                                                         osbErrorMessage   OUT GE_ERROR_LOG.DESCRIPTION%TYPE) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : API_ACCEPT_ITEM
    Descripcion     : api permite la aceptación de ítems en transito de una unidad de trabajo.

    Autor           : Diana Saltarin
    Fecha           : 01-09-2023

    Parametros de Entrada
    iclXMLAcceptItems	Texto XML con Información de los Ítems a Aceptar

    Parametros de Salida
     onuErrorCode          codigo de error
     osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

BEGIN
   UT_TRACE.TRACE('Inicio API_ACCEPT_ITEM ', 10);
   Pkg_Error.prInicializaError(onuErrorCode, 
                               osbErrorMessage);
   OS_ACCEPT_ITEM (iclXMLAcceptItems,
                     onuErrorCode,
                     osbErrorMessage
                     );
  UT_TRACE.TRACE('Fin API_ACCEPT_ITEM ', 10);
EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_ACCEPT_ITEM ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_ACCEPT_ITEM ['||osbErrorMessage||']', 10);
END API_ACCEPT_ITEM;
/
BEGIN

	pkg_utilidades.prAplicarPermisos('API_ACCEPT_ITEM', 'ADM_PERSON'); 

END;
/

