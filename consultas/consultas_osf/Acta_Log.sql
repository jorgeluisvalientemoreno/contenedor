select *
--delete 
  from ct_process_log ct
 where ct.log_date > trunc(sysdate)
   and ct.contract_id = 5105
 order by ct.log_date desc;
