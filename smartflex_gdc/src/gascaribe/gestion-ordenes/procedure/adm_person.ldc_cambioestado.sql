CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_CAMBIOESTADO

  /*****************************************************************
  Propiedad intelectual del proyecto PETI (c).

  Unidad         : LDC_CAMBIOESTADO
  Descripcion    : Prcedimiento para realizar el cambio de estado a 6-En Ejecucion
                   y 7-Ejecutada de una orden de emergencia (integracion ludytrack).
  Autor          : Peti
  Fecha          : 24-10-2013


  Historia de Modificaciones
  Fecha             Autor               Modificacion
  =========     ==================      ====================  
  14/05/2024    Paola Acosta            OSF-2674: Cambio de esquema ADM_PERSON  
                                        Retiro marcacion esquema .open objetos de lógica 
  24-10-2013    GDO                     Creacion.  
  ******************************************************************/

  -- Prcedimiento para realizar el cambio de estado a 6-En Ejecucion y 7-Ejecutada Ludytrack
(inuOrderId      in OR_order.order_id%type, --> Orden a Cambiar
 inuState        in OR_order.order_status_id%type, --> Codigo Estado
 inuCausalID     in ge_causal.causal_id%type, --> Causal de ejecucion
 idtChangeDate   in OR_order.exec_initial_date%type, --> Fecha
 onuErrorCode    out ge_error_log.error_log_id%type,
 osbErrorMessage out ge_error_log.description%type) IS
  rcOrder                daor_order.styOr_order;
  rcStatChange           daor_order_stat_change.styOr_order_stat_change;
  inuCommentTypeId       NUMBER;
  isbComment             VARCHAR2(4000);
  nuEnejecucion          number := 6;
  nuEjecutada            number := 7;
  nuGeneralComment       number := 83;
  --EAM
  SBCUPDATEIDTCHANGEDATE VARCHAR2(1) := DALD_PARAMETER.fsbGetValue_Chain('LDCUPDATEINITENDEXEC');
  SBSI                   VARCHAR2(1) := 'S';
--EAM
  -- Inicializa las variables de salida del servicio
  PROCEDURE InitOutputData IS
  BEGIN
    ge_boutilities.InitializeOutput(onuErrorCode, osbErrorMessage);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END InitOutputData;

BEGIN
  ut_trace.trace('INICIO - LDC_CAMBIOESTADO - Orden [' || inuOrderId ||
                 '] Estado [' || inuState || '] Fecha [' || idtChangeDate || ']',
                 15);

  --1. Inicializa el codigo y mensaje de error.
  InitOutputData;

  daor_order.getRecord(inuOrderId, rcOrder);
  inuCommentTypeId := nuGeneralComment;

  if (not daor_order.fblExist(inuOrderId)) then
    Errors.SetError(19102, inuOrderId);
    raise ex.CONTROLLED_ERROR;
  END if;

  if (inuState != nuEnejecucion AND inuState != nuEjecutada) then
    Errors.SetError(-2291);
    raise ex.CONTROLLED_ERROR;
  END if;

  if (inuState = 6 AND rcOrder.order_status_id != 5) then
    Errors.SetError(120864);
    raise ex.CONTROLLED_ERROR;
  END if;

  if (inuState = 7 AND rcOrder.order_status_id != 6) then
    Errors.SetError(120864);
    raise ex.CONTROLLED_ERROR;
  END if;



  -- Definicion de Fechas a actualizar
  IF inuState = nuEnejecucion THEN
    -- Para el cambio a estado 6-En Ejecucion, se actualiza la Fecha Inicio de Ejecucion
    --rcOrder.EXEC_INITIAL_DATE := idtFecha;
    --isbComment:= 'Se realiza el estado de la orden a [6 - En ejecucion]' ;
    -- Inserta registro en or_order_stat_change
    rcStatChange.order_stat_change_id := or_bosequences.fnuNextOr_Order_Stat_Change;
    rcStatChange.initial_status_id    := rcOrder.order_status_id;
    rcStatChange.final_status_id      := inuState;
    rcStatChange.order_id             := rcOrder.order_id;
    rcStatChange.stat_chg_date        := /*SYSDATE*/idtChangeDate;--EAM
    rcStatChange.user_id              := ut_session.getUSER;
    rcStatChange.terminal             := ut_session.getTERMINAL;
    rcStatChange.comment_type_id      := NULL;
    rcStatChange.execution_date       := rcOrder.exec_estimate_date;
    rcStatChange.initial_oper_unit_id := rcOrder.operating_unit_id;
    rcStatChange.programing_class_id  := rcOrder.programing_class_id;
    rcStatChange.action_id            := 103;
    rcStatChange.range_description    := null;

    -- Actualiza el registro de la orden
    rcOrder.order_status_id := nuEnejecucion;

    ut_trace.Trace('Se actualiza orden [' || rcOrder.order_id ||
                   '] a estado [' || rcOrder.order_status_id || ']',
                   15);
    daor_order.updRecord(rcOrder);

    daor_order_stat_change.insrecord(rcStatChange);
  --EAM se modifica el la fecha de inicio de trabajo de acuerdo con nuevo estado de la orden
    IF nvl(SBCUPDATEIDTCHANGEDATE, sbsi) = sbsi then
      BEGIN
        UPDATE or_order o
           SET o.exec_initial_date = idtChangeDate
         WHERE o.order_id = inuOrderId;
      END;
    END IF;
  END if;

  IF inuState = nuEjecutada THEN

    --valida la causal de la orden.
    if (not dage_causal.fblExist(inuCausalId)) then
      Errors.SetError(19082, inuCausalId);
      raise ex.CONTROLLED_ERROR;
    END if;

    -- Para el cambio a estado 7-Ejecutada, se actualiza la Fecha Fin de Ejecucion
    --rcOrder.EXECUTION_FINAL_DATE := idtFecha;
    --isbComment:= 'Se realiza el estado de la orden a [7 - Ejecutada]' ;
    Or_BoEjecutarOrden.ExecOrderWithCausal(inuOrderId,
                                           inuCausalId,
                                           null,
                                           null,
                                           idtChangeDate);
  --EAM se modifica el la fecha de FIN de trabajo de acuerdo con nuevo estado de la orden
    IF nvl(SBCUPDATEIDTCHANGEDATE, sbsi) = sbsi then
      BEGIN
        UPDATE or_order o
           SET o.execution_final_date = idtChangeDate
         WHERE o.order_id = inuOrderId;
      END;
    END IF;
  END IF;
  -- Se realiza el cambio de estado de la orden
  --changeStatus(rcOrder,inuState,inuCommentTypeId,isbComment);

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    Errors.getError(onuErrorCode, osbErrorMessage);
  WHEN others THEN
    Errors.setError;
    Errors.getError(onuErrorCode, osbErrorMessage);
END LDC_CAMBIOESTADO;
/
PROMPT Otorgando permisos de ejecucion a LDC_CAMBIOESTADO
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_CAMBIOESTADO', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_CAMBIOESTADO para reportes
GRANT EXECUTE ON adm_person.LDC_CAMBIOESTADO TO rexereportes;
/