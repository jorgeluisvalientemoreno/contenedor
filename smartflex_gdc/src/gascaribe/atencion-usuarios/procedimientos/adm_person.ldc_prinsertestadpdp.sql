CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRINSERTESTADPDP IS
  /*****************************************************************
  Propiedad intelectual de Gases de Occidente (c).

  Unidad         : LDC_prInsertEstadPDP
  Descripcion    : Inserta el estado de registro en la tabla ldc_proteccion_datos
  Autor          : Álvaro Zapata
  Fecha          : 15-12-2013

  Consideraciones de Uso
  ============================================================================

  Este objeto se encargará de insertar un regsitro en la tabla ldc_proteccion_datos al momento de legalizar
  la OT con tipo de trabajo 12652 siempre y cuando el cliente no existe en dicha tabla

  los estados utilizados según la ley 1581 son AUTORIZA, NO AUTORIZA o REVOCA

  Historia de Modificaciones
  Fecha             Autor             Modificación
  =========   ==================      ====================

  ******************************************************************/

  nuSubscriberId   number;
  nucurractivityid or_order_activity.order_activity_id%TYPE;
  nuClienteId      number;
  nuorden          or_order.order_id%type;
  sbEstadoLey      Varchar2(20);
  sbCurrentUser    sa_user.mask%type;

  /*-- Codigo del Cliente
  CURSOR cuCliente (nuOrdenId or_order_activity.order_id%type) IS
        SELECT  SUBSCRIBER_ID
        FROM    OR_ORDER_ACTIVITY
        WHERE   ORDER_ID = nuOrdenId;*/

BEGIN

  ut_trace.trace('FIN - LDC_prInsertEstadPDP', 15);

  -- Obtiene el usuario actual
  sbCurrentUser := ut_session.getUSER;

  ut_trace.trace('Obtiene el usuario actual: ' || sbCurrentUser, 10);

  --Obtener el identificador de la orden  que se encuentra en la instancia
  nuorden := or_bolegalizeorder.fnuGetCurrentOrder;

  ut_trace.trace('ORDEN actual: ' || nuorden, 10);

  -- obtiene el order_activity_id
  nucurractivityid := LDC_BcFinanceOt.fnuGetActivityId(nuorden);
  --or_bolegalizeactivities.fnugetcurractivity;


  ut_trace.trace('nucurractivityid: ' || nucurractivityid, 10);

  --Obtiene el codigo del suscriptor de order_activity
  nuSubscriberId := daor_order_activity.fnugetsubscriber_id(nucurractivityid);

  ut_trace.trace('nuSubscriberId : ' || nuSubscriberId, 10);

  --Obtiene el estado de ley seleccionado en la legalización
  sbEstadoLey := to_number(ldc_boordenes.fsbDatoAdicTmpOrden(nuorden,
                                                             5001394,
                                                             'ESTADO_LEY_1581'));

  ut_trace.trace('sbEstadoLey: ' || sbEstadoLey, 10);

  SELECT COUNT(1)
    INTO nuClienteId
    FROM LDC_PROTECCION_DATOS
   WHERE ID_CLIENTE = nuSubscriberId;

  ut_trace.trace('nuClienteId: ' || nuClienteId, 10);

  IF nuClienteId = 0 THEN
    Insert into LDC_PROTECCION_DATOS
      (ID_CLIENTE,
       COD_ESTADO_LEY,
       ESTADO,
       FECHA_CREACION,
       USUARIO_CREACION,
       PACKAGE_ID)
    Values
      (nuSubscriberId, sbEstadoLey, 'S', SYSDATE, sbCurrentUser, 1);
  END IF;

  ut_trace.trace('FIN - LDC_prInsertEstadPDP', 15);

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;

END LDC_PRINSERTESTADPDP;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRINSERTESTADPDP', 'ADM_PERSON');
END;
/
