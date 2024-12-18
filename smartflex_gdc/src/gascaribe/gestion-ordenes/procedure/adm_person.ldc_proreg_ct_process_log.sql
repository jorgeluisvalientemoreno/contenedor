CREATE OR REPLACE procedure adm_person.LDC_PROREG_CT_PROCESS_LOG(inuprocess_log_id       CT_PROCESS_LOG.PROCESS_LOG_ID%type,--Not null
                                                      inulog_date             CT_PROCESS_LOG.LOG_DATE%type,--Not null
                                                      inucontract_id          CT_PROCESS_LOG.CONTRACT_ID%type     default null,--Entra el Acta
                                                      inuperiod_id            CT_PROCESS_LOG.PERIOD_ID%type       default null,    --Nulo
                                                      inubreak_date           CT_PROCESS_LOG.BREAK_DATE%type      default null,    --Nulo
                                                      inuerror_code           CT_PROCESS_LOG.ERROR_CODE%type,--Not null
                                                      inuerror_message        CT_PROCESS_LOG.ERROR_MESSAGE%type   default null,
                                                      inuorder_id             CT_PROCESS_LOG.ORDER_ID%Type        default null,
                                                      inuitems_id             CT_PROCESS_LOG.ITEMS_ID%type        default null,
                                                      inuexclu_user_id        CT_PROCESS_LOG.EXCLU_USER_ID%type   default null,
                                                      inuexclu_terminal       CT_PROCESS_LOG.EXCLU_TERMINAL%type  default null,
                                                      inuexclu_final_date     CT_PROCESS_LOG.EXCLU_FINAL_DATE%type default null,   --Nulo
                                                      inuexclu_sys_date       CT_PROCESS_LOG.EXCLU_SYS_DATE%type  default null,
                                                      inucondition_by_plan_id CT_PROCESS_LOG.CONDITION_BY_PLAN_ID%type default null--Nulo
                                                     ) is
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :  LDC_PROREG_CT_PROCESS_LOG
  Descripcion :  

  Autor       : 
  Fecha       : 

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  09/05/2024          Paola Acosta       OSF-2672: Cambio de esquema ADM_PERSON                                         
  **************************************************************************/                                                    
--
PRAGMA autonomous_transaction;

--REQ.264
 nucontrato       ge_acta.id_contrato%type;
 --

BEGIN

--REQ.264
  --Se obtiene el contrato a partir del Acta (parámetro de entrada del metodo) para el registro del LOG
  Begin
    select g.id_contrato into nucontrato
    from ge_acta g
    where g.id_acta = inucontract_id;--Variable con el valor del Acta que viene de los proedimientos del tipo de ofertado 3 y 5
  Exception
    when others then
      null;
  End;


insert into CT_PROCESS_LOG (process_log_id,--Not null
                            log_date,--Not null
                            contract_id,
                            period_id, --Nulo
                            break_date, --Nulo
                            error_code,--Not null
                            error_message,
                            order_id,
                            items_id,
                            exclu_user_id,
                            exclu_terminal,
                            exclu_final_date, --Nulo
                            exclu_sys_date,
                            condition_by_plan_id
                            ) --Nulo
                    values (
                            inuprocess_log_id, --SEQ_CT_PROCESS_LOG_109639.NEXTVAL;
                            inulog_date,
                            nucontrato,--inucontract_id,
                            inuperiod_id, --Nulo
                            inubreak_date, --Nulo
                            inuerror_code,
                            inuerror_message,
                            inuorder_id,
                            inuitems_id,
                            inuexclu_user_id,
                            inuexclu_terminal,
                            inuexclu_final_date, --Nulo
                            inuexclu_sys_date,
                            inucondition_by_plan_id--Nulo
                            );

--Persistencia
commit;

EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line(sqlerrm);
    NULL;

--
END LDC_PROREG_CT_PROCESS_LOG;
/
PROMPT Otorgando permisos de ejecucion a LDC_PROREG_CT_PROCESS_LOG
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PROREG_CT_PROCESS_LOG', 'ADM_PERSON');
END;
/