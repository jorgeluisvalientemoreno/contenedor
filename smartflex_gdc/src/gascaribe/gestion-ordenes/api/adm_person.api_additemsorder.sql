create or replace procedure adm_person.api_additemsorder ( inuOrderId          IN  NUMBER, 
                                                           inuItemId           IN  NUMBER,
                                                           inuLegalItemAmount  IN NUMBER,
                                                           onuErrorCode        OUT GE_MESSAGE.MESSAGE_ID%TYPE, 
                                                           osbErrorMessage     OUT GE_ERROR_LOG.DESCRIPTION%TYPE ) IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : API_ADDITEMSORDER
     Descripcion     : api para cargar items y realizar aceptacion de los mismo
     Autor           : Luis Javier Lopez
     Fecha           : 23-08-2023

    Parametros de Entrada
     inuOrderId          Numero de orden
     inuItemId           Item adicionar
     inuLegalItemAmount  Cantidad de Items
     
    Parametros de Salida
     onuErrorCode          codigo de error
     osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
  ***************************************************************************/
 
 BEGIN
   UT_TRACE.TRACE('Inicio API_ADDITEMSORDER ['||inuOrderId||']['||inuItemId||']['||inuLegalItemAmount||']', 10);
   OS_ADDITEMSORDER( inuOrderId , 
                     inuItemId  ,
                     inuLegalItemAmount ,
                     onuErrorCode,
                     osbErrorMessage );
  UT_TRACE.TRACE('Fin API_ADDITEMSORDER');
 EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_ADDITEMSORDER ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_ADDITEMSORDER ['||osbErrorMessage||']', 10);
END api_additemsorder;
/
BEGIN
 pkg_utilidades.praplicarpermisos('API_ADDITEMSORDER', 'ADM_PERSON');
END;
/