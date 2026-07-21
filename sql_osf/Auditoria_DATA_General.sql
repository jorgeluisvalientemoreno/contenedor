select --*
 to_char(previous_text),
 to_char(current_text),
 TRUNC(CAST(au.current_date AS DATE))
  from open.au_audit_policy_log au
 where 1 = 1
   and au.current_table_name = 'LD_PARAMETER'
   --and au.current_user_id not in - 1
   --and au.current_user_mask not in ('JOBOSF', 'JOBOSFDM', 'ADMIOPEF')
   --and au.current_even_desc = 'UPDATE'
   --and au.current_exec_name = 'LDPAR'
      --and audit_log_id in (405)
      -- and au.current_even_desc = 'INSERT'
      -- and TRUNC(CAST(au.current_date AS DATE)) >= '01/01/2024'
   and to_char(previous_text) like '%LDC_TIPOSUSPRECSN%'
--order by au.current_date desc;
