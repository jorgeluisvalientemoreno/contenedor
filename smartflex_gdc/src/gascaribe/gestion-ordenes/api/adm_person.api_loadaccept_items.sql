create or replace procedure adm_person.api_loadaccept_items( iclXmlLoadAcceptItems    IN  CLOB, 
                                                             onuErrorCode             OUT GE_MESSAGE.MESSAGE_ID%TYPE, 
                                                             osbErrorMessage          OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : API_LOADACCEPT_ITEMS
     Descripcion     : api para cargar items y realizar aceptacion de los mismo
     Autor           : Luis Javier Lopez
     Fecha           : 23-08-2023

    Parametros de Entrada
     iclXmlLoadAcceptItems    XML con Información de del los Ítems a Cargar y Aceptar

    Parametros de Salida
     onuErrorCode          codigo de error
     osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
  ***************************************************************************/

 IS
 BEGIN
   UT_TRACE.TRACE('Inicio API_LOADACCEPT_ITEMS ', 10);
   OS_LOADACCEPT_ITEMS( iclXmlLoadAcceptItems, onuErrorCode, osbErrorMessage );
   UT_TRACE.TRACE('Fin API_LOADACCEPT_ITEMS ', 10);
 EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.GETERROR( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_LOADACCEPT_ITEMS ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.SETERROR;
      pkg_Error.GETERROR( onuErrorCode, osbErrorMessage );
       UT_TRACE.TRACE('Fin OTHERS API_LOADACCEPT_ITEMS ['||osbErrorMessage||']', 10);
END api_loadaccept_items;
/
BEGIN
 pkg_utilidades.praplicarpermisos('API_LOADACCEPT_ITEMS', 'ADM_PERSON');
END;
/