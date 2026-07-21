---Identificar y visualizar errores en acta
SELECT cpl.process_log_id Secuencia,
       cpl.log_date Fecha_Registro,
       cpl.contract_id || ' - ' || gc.descripcion Contrato,
       cpl.period_id || ' - ' || GPC.NOMBRE Periodo,
       cpl.break_date Fecha_error,
       cpl.error_code Codigo_Error,
       cpl.error_message Mensaje_Error,
       cpl.order_id Orden,
       cpl.items_id || ' - ' || gi.description Item,
       cpl.exclu_user_id Usuario_Excluye_orden,
       cpl.exclu_terminal Terminal_Excluye_orden,
       cpl.exclu_final_date Fecha_Limite_Excluye_orden,
       cpl.exclu_sys_date Fecha_Excluye_orden,
       cpl.condition_by_plan_id Plan_Condiciones
  FROM open.CT_PROCESS_LOG cpl
  left join open.ge_items gi
    on gi.items_id = cpl.items_id
  left join OPEN.CT_CONDITIONS_BY_PLAN CCBP
    on CCBP.CONDITION_BY_PLAN_ID = cpl.condition_by_plan_id
  left join OPEN.GE_CONTRATO gc
    on gc.id_contrato = cpl.contract_id
  left join OPEN.GE_PERIODO_CERT GPC
    on GPC.ID_PERIODO = cpl.period_id
 WHERE cpl.Log_Date >
       to_date('01/06/2024 09:50:36', 'DD/MM/YYYY HH24:MI:SS') --
--       and CT_PROCESS_LOG.contract_id = 7566
--sysdate -1
 order by cpl.Log_Date desc
