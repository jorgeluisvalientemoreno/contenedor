create or replace PROCEDURE adm_person.api_addordercomment( inuOrderId        IN   NUMBER,
                                                                    inuCommentTypeId  IN   NUMBER,
                                                                    isbComment        IN   VARCHAR2,
                                                                    onuErrorCode      OUT  NUMBER,
                                                                    osbErrorMessage   OUT  VARCHAR2 ) IS

/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : api_registerordercomment
     Descripcion     : api para registrar comentario de la orden
     Autor           : Luis Javier Lopez 
     Fecha           : 16-06-2023

    Parametros de Entrada
     inuOrderId            numero de la orden
     inuCommentTypeId      tipo de comentario
     isbComment            comentario
    Parametros de Salida
     onuErrorCode          codigo de error
     osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
  ***************************************************************************/
BEGIN
  os_addordercomment( inuOrderId, 
                      inuCommentTypeId,
                      isbComment,
                      onuErrorCode,
                      osbErrorMessage);

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    pkg_Error.setError;
    pkg_Error.GETERROR(onuErrorCode, osbErrorMessage);
  WHEN OTHERS THEN
    pkg_Error.SETERROR;
    pkg_Error.GETERROR(onuErrorCode, osbErrorMessage);
END api_addordercomment;
/
begin
  pkg_utilidades.prAplicarPermisos('API_ADDORDERCOMMENT', 'ADM_PERSON'); 
end;
/