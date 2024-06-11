SELECT *
FROM open.ge_Error_log l
where l.time_stamp>='28/07/2022 11:00:00'
  and upper(call_stack) like '%TRG_LOG_DELETE_CARGOS%';
  
SELECT *
FROM OPEN.LDC_CARGOS_LOG_DELETE
where cargcuco<>-1
  and terminal_elimina!='GCBQ34P14';
