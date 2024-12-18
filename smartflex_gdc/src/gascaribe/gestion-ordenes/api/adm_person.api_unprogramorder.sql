create or replace procedure adm_person.api_unprogramorder(inuOrdenId        IN   OR_ORDER.ORDER_ID%TYPE,
                                                         inuTipoComentario  IN   OR_ORDER_COMMENT.COMMENT_TYPE_ID%TYPE,
                                                         isbComentario      IN   OR_ORDER_COMMENT.ORDER_COMMENT%TYPE,
                                                         idtFechaCambio     IN   OR_ORDER_STAT_CHANGE.STAT_CHG_DATE%TYPE DEFAULT SYSDATE,
                                                         onuErrorCode       OUT  GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                                                         osbErrorMessage    OUT  GE_ERROR_LOG.DESCRIPTION%TYPE ) IS

/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : api_unassignorder
     Descripcion     : api para desasignar orden de trabajo
     Autor           : Jhon Soto
     Fecha           : 02-10-2023

    Parametros de Entrada
     inuOrderId            numero de la orden
     inuTipoComentario     tipo de comentario
     isbComentario         comentario
     idtFechaCambio        fecha de cambio
    Parametros de Salida
     onuErrorCode          codigo de error
     osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
  ***************************************************************************/

rcOrder             DAOR_ORDER.STYOR_ORDER;

BEGIN
  UT_TRACE.TRACE('Inicio api_unprogramorder', 10);
  
  DAOR_ORDER.GETRECORD(inuOrdenId, rcOrder); --Variable rcOrder de tipo RCORDER DAOR_ORDER.STYOR_ORDER;

  OR_BOPROCESSORDER.UNPROGRAM
                            (
                              rcOrder,
                              inuTipoComentario,
                              isbComentario,
                              TRUE,
                              idtFechaCambio
                             );

  UT_TRACE.TRACE('Fin api_unprogramorder', 10);

EXCEPTION
  WHEN pkg_error.CONTROLLED_ERROR THEN
    pkg_Error.setError;
    pkg_Error.GETERROR(onuErrorCode, osbErrorMessage);
    UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_UNPROGRAMORDER['||osbErrorMessage||']', 10);
  WHEN OTHERS THEN
    pkg_Error.SETERROR;
    pkg_Error.GETERROR(onuErrorCode, osbErrorMessage);
    UT_TRACE.TRACE('Fin OTHERS API_UNPROGRAMORDER['||osbErrorMessage||']', 10);
END api_unprogramorder;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('API_UNPROGRAMORDER', 'ADM_PERSON');
END;
/