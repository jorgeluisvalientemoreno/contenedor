
select  rowid, 
        to_char(previous_text), 
        to_char(current_text),  
        au.current_date
 from open.au_audit_policy_log au
   where audit_log_id in (293) 
;


select  rowid, to_char(previous_text), to_char(current_text),  au.current_date
 from open.au_audit_policy_log au
   where audit_log_id in (293) 
     and record_rowid='AACIy0AA3AAAEXSAA2';

--historial

select  rowid, to_char(previous_text), to_char(current_text),  au.current_date
 from open.au_audit_policy_log_history au
   where audit_log_id in (293) 



