create or replace procedure   adm_person.api_getperiodrevmaxdate (  inuProductId         IN  NUMBER,
                                                                    odtEstimatedMaxDate  OUT  DATE,
                                                                    onuErrorCode         OUT GE_MESSAGE.MESSAGE_ID%TYPE,
                                                                    osbErrorMessage      OUT GE_ERROR_LOG.DESCRIPTION%TYPE ) IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : api_getperiodrevmaxdate
     Descripcion     : api para Consulta la fecha estimada de la revisión periódica de un producto
     Autor           : Luis Javier Lopez
     Fecha           : 23-08-2023

    Parametros de Entrada
        inuProductId          codigo del producto

    Parametros de Salida
        odtEstimatedMaxDate   fecha
        onuErrorCode          codigo de error
        osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

 BEGIN
   UT_TRACE.TRACE('Inicio API_GETPERIODREVMAXDATE ', 10);
   pkg_error.prInicializaError(onuErrorCode, osbErrorMessage);
   
   OS_GETPERIODREVMAXDATE( inuProductId,
                           odtEstimatedMaxDate,                         
                           onuErrorCode,
                           osbErrorMessage );
  UT_TRACE.TRACE('Fin API_GETPERIODREVMAXDATE');
 EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_GETPERIODREVMAXDATE ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_GETPERIODREVMAXDATE ['||osbErrorMessage||']', 10);
END api_getperiodrevmaxdate;
/
BEGIN
     pkg_utilidades.praplicarpermisos('API_GETPERIODREVMAXDATE', 'ADM_PERSON');
END;
/