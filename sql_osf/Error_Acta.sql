SELECT CT_PROCESS_LOG.PROCESS_LOG_ID PROCESS_LOG_ID,
       (SELECT ge_periodo_cert.id_periodo || ' -  (' ||
               to_char(ge_periodo_cert.fecha_inicial) || ' , ' ||
               to_char(ge_periodo_cert.fecha_final) || ')'
          FROM open.ge_periodo_cert
         WHERE ge_periodo_cert.id_periodo = CT_PROCESS_LOG.PERIOD_ID) PERIOD_ID,
       CT_PROCESS_LOG.ORDER_ID ORDER_ID,
       (SELECT ge_items.items_id || ' - ' || ge_items.code || ' - ' ||
               ge_items.description
          FROM open.ge_items
         WHERE ge_items.items_id = CT_PROCESS_LOG.ITEMS_ID) ITEMS_ID,
       --CT_PROCESS_LOG.CONDITION_BY_PLAN_ID || '-' || CT_BCConditionPlan.fsbCondNameByCondPlan(CT_PROCESS_LOG.condition_by_plan_id) CONDITION_NAME,
       CT_PROCESS_LOG.LOG_DATE      LOG_DATE,
       CT_PROCESS_LOG.BREAK_DATE    BREAK_DATE,
       CT_PROCESS_LOG.ERROR_CODE    ERROR_CODE,
       CT_PROCESS_LOG.ERROR_MESSAGE ERROR_MESSAGE
  FROM open.CT_PROCESS_LOG
 WHERE CT_PROCESS_LOG.contract_id = 10801
