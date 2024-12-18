create or replace PROCEDURE adm_person.api_related_order( inuOrderId         IN NUMBER,
                                                           inuOrdenRelacionar IN NUMBER,                                                      
                                                           onuErrorCode       OUT NUMBER,
                                                           osbErrorMessage    OUT VARCHAR2) IS
  /*****************************************************************
  Procedimiento   :   api_related_order
  Descripcion     :   Proceso que se encarga de llamar al api de relacionar orden

  Parametros de Entrada
    InuOrderId            codigo de la Orden padre
    inuOrdenRelacionar    codigo de orden a relacionar

  Parametros de Salida
    OnuErrorCode          codigo de error
    OsbErrorMessage       mensaje de error


  Historia de Modificaciones
  Fecha       Autor              Modificacion
  =========   =========       ====================
  17-07-2023  LJLB            OSF-1133 Creaci?n
  ******************************************************************/

BEGIN

  PKG_ERROR.prInicializaError(onuErrorCode, osbErrorMessage);

  os_related_order(inuOrderId, inuOrdenRelacionar, onuErrorCode,  osbErrorMessage );

EXCEPTION
  WHEN OTHERS THEN
    PKG_ERROR.setError;
    PKG_ERROR.getError(onuErrorCode, osbErrorMessage);
END api_related_order;
/
BEGIN
   pkg_utilidades.prAplicarPermisos('API_RELATED_ORDER', 'ADM_PERSON');
END;
/