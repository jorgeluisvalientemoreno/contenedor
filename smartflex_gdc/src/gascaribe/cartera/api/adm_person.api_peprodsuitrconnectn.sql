CREATE OR REPLACE PROCEDURE ADM_PERSON.API_PEPRODSUITRCONNECTN (inuProductId    IN  NUMBER,
                                                                osbFlag         OUT VARCHAR2,
                                                                onuErrorCode    OUT GE_MESSAGE.MESSAGE_ID%TYPE,
                                                                osbErrorMessage OUT GE_ERROR_LOG.DESCRIPTION%TYPE) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : API_PEPRODSUITRCONNECTN
    Descripcion     : api para validacion de Aptitud para Reconexion

    Autor           : Diana Saltarin
    Fecha           : 01-09-2023

    Parametros de Entrada
      inuProductId	      Código de producto
      

    Parametros de Salida
     osbFlag               'S'->Producto Valido para reconexion
                           'N'->Producto No valido para reconexion
     onuErrorCode          codigo de error
     osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
  ***************************************************************************/

BEGIN
   UT_TRACE.TRACE('Inicio API_PEPRODSUITRCONNECTN ', 10);
   Pkg_Error.prInicializaError(onuErrorCode, 
                               osbErrorMessage);
   OS_PEPRODSUITRCONNECTN (inuProductId,
                           osbFlag,
                           onuErrorCode,
                           osbErrorMessage
                          );
  UT_TRACE.TRACE('Fin API_PEPRODSUITRCONNECTN ', 10);
EXCEPTION
   WHEN pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin CONTROLLED_ERROR API_PEPRODSUITRCONNECTN ['||osbErrorMessage||']', 10);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
      UT_TRACE.TRACE('Fin OTHERS API_PEPRODSUITRCONNECTN ['||osbErrorMessage||']', 10);
END API_PEPRODSUITRCONNECTN;
/
BEGIN

	pkg_utilidades.prAplicarPermisos('API_PEPRODSUITRCONNECTN', 'ADM_PERSON'); 

END;
/

