select *
  from open.ct_process_log la
 where la.contract_id = 9321
   and upper(la.error_message) like upper('%OSF%')
