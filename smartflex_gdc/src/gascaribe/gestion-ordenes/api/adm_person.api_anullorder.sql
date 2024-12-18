CREATE OR REPLACE PROCEDURE ADM_PERSON.api_anullorder(inuOrderId        IN NUMBER,
                                                      inuTipoComentario IN NUMBER,
                                                      isbComentario     IN VARCHAR2,
                                                      onuErrorCode      OUT NUMBER,
                                                      osbErrorMessage   OUT VARCHAR2) is
  /*****************************************************************
  Procedimiento   :   api_assignOrder
  Descripcion     :   Proceso que se encarga de llamar al api de anulacion de orden de open
  
  Parametros de Entrada
    InuOrderId            codigo de la Orden
    inuTipoComentario     Tipo de comentario
    isbComentario         Comentario de la anulacion
  
  Parametros de Salida
    OnuErrorCode          codigo de error
    OsbErrorMessage       mensaje de error
  
  
  Historia de Modificaciones
  Fecha       Autor              Modificacion
  =========   =========       ====================
  11-07-2023  Jorge Valiente       OSF-1310 Creaci?n
  ******************************************************************/

BEGIN

  PKG_ERROR.prInicializaError(onuErrorCode, osbErrorMessage);

  or_boanullorder.anullorderwithoutval(inuOrderId, sysdate);

  if InuTipoComentario is not null then
    API_ADDORDERCOMMENT(inuOrderId,
                        inuTipoComentario,
                        isbComentario,
                        onuErrorCode,
                        osbErrorMessage);
  end if;

EXCEPTION
  WHEN OTHERS THEN
    PKG_ERROR.setError;
    PKG_ERROR.getError(onuErrorCode, osbErrorMessage);
END;
/

begin
pkg_utilidades.prAplicarPermisos('API_ANULLORDER', 'ADM_PERSON');
end;
/