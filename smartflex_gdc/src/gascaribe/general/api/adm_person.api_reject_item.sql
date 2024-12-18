CREATE OR REPLACE PROCEDURE ADM_PERSON.API_REJECT_ITEM (iclXMLRejectItem	      IN	CLOB,
                                                        onuErrorCode             OUT GE_MESSAGE.MESSAGE_ID%TYPE,
                                                        osbErrorMessage          OUT GE_ERROR_LOG.DESCRIPTION%TYPE) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : API_REJECT_ITEM
    Descripcion     : api permite rechazar ítems en transito..

    Autor           : Diana Saltarin
    Fecha           : 01-09-2023

    Parametros de Entrada
    iclXMLRejectItem	XML con Información de Ítems a Rechazar

    Parametros de Salida
     onuErrorCode          codigo de error
     osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

BEGIN
   UT_TRACE.TRACE('Inicio API_REJECT_ITEM ', 10);
   Pkg_Error.prInicializaError(onuErrorCode, 
                               osbErrorMessage);
   OS_REJECT_ITEM (iclXMLRejectItem,
                  onuErrorCode,
                  osbErrorMessage
                  );
  UT_TRACE.TRACE('Fin API_REJECT_ITEM ', 10);
EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_REJECT_ITEM ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_REJECT_ITEM ['||osbErrorMessage||']', 10);
END API_REJECT_ITEM;
/
BEGIN

	pkg_utilidades.prAplicarPermisos('API_REJECT_ITEM', 'ADM_PERSON'); 

END;
/

