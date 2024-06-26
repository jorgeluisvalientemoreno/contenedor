---Identificar y visualizar errores en acta
SELECT CT_PROCESS_LOG.PROCESS_LOG_ID PROCESS_LOG_ID,
       CT_PROCESS_LOG.ORDER_ID ORDER_ID,
       (SELECT ge_items.items_id || ' - ' || ge_items.code || ' - ' ||
               ge_items.description
          FROM open.ge_items
         WHERE ge_items.items_id = CT_PROCESS_LOG.ITEMS_ID) ITEMS_ID,
       CT_PROCESS_LOG.CONDITION_BY_PLAN_ID || '-' ||
       --CT_BCConditionPlan.fsbCondNameByCondPlan(CT_PROCESS_LOG.condition_by_plan_id) CONDITION_NAME,
        CT_PROCESS_LOG.LOG_DATE LOG_DATE,
       CT_PROCESS_LOG.BREAK_DATE BREAK_DATE,
       CT_PROCESS_LOG.ERROR_CODE ERROR_CODE,
       CT_PROCESS_LOG.ERROR_MESSAGE ERROR_MESSAGE
  FROM open.CT_PROCESS_LOG
 WHERE CT_PROCESS_LOG.contract_id = 7566
   and CT_PROCESS_LOG.Log_Date >
       to_date('14/10/2022 09:50:36', 'DD/MM/YYYY HH24:MI:SS') --
--sysdate -1
 order by CT_PROCESS_LOG.Log_Date desc
