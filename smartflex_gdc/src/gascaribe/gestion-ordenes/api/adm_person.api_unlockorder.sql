create or replace procedure adm_person.api_unlockorder( inuOrderId         IN   OR_ORDER.ORDER_ID%TYPE,
                                                        inuTipoComentario  IN   OR_ORDER_COMMENT.COMMENT_TYPE_ID%TYPE,
                                                        isbComentario      IN   OR_ORDER_COMMENT.ORDER_COMMENT%TYPE,
                                                        idtFechaCambio     IN   OR_ORDER_STAT_CHANGE.STAT_CHG_DATE%TYPE DEFAULT SYSDATE,
                                                        onuErrorCode       OUT  GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                                                        osbErrorMessage    OUT  GE_ERROR_LOG.DESCRIPTION%TYPE ) IS

/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : api_unlockorder
     Descripcion     : api para desbloquear orden de trabajo
     Autor           : Luis Javier Lopez
     Fecha           : 16-06-2023

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
BEGIN
  UT_TRACE.TRACE('Inicio api_unlockorder', 10);
  os_unlockorder( inuOrderId,
                inuTipoComentario,
                isbComentario,
                idtFechaCambio,
                onuErrorCode,
                osbErrorMessage);
  UT_TRACE.TRACE('Fin api_unlockorder', 10);
EXCEPTION
  WHEN pkg_error.CONTROLLED_ERROR THEN
    pkg_Error.setError;
    pkg_Error.GETERROR(onuErrorCode, osbErrorMessage);
    UT_TRACE.TRACE('Fin CONTROLLED_ERROR api_unlockorder['||osbErrorMessage||']', 10);
  WHEN OTHERS THEN
    pkg_Error.SETERROR;
    pkg_Error.GETERROR(onuErrorCode, osbErrorMessage);
    UT_TRACE.TRACE('Fin OTHERS api_unlockorder['||osbErrorMessage||']', 10);
END api_unlockorder;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('API_UNLOCKORDER', 'ADM_PERSON');
END;
/