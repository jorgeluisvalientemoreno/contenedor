select gel.*, rowid
  from open.ge_error_log gel
 where 1 = 1
      --   and gel.error_log_id = 276511150
   and to_date(gel.time_stamp, 'DD/MM/YYYY HH24:MI:SS') >= to_date('28/08/2025 13:15:42', 'DD/MM/YYYY HH24:MI:SS')
      --and to_date(gel.time_stamp, 'DD/MM/YYYY HH24:MI:SS') < to_date('28/08/2025 13:28:42', 'DD/MM/YYYY HH24:MI:SS')
   and upper(gel.call_stack) like upper('%LDC_BOASIGAUTO%')
 order by gel.time_stamp desc;
