select das.*
  from dba_audit_session das
 where 1 = 1
      --and das.returncode = 28000 --1017
   and das.username = 'JESMAE'
--and trunc(das.timestamp) = trunc(sysdate)
 order by das.timestamp desc
