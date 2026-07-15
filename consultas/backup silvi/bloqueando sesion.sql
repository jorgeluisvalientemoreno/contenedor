select * from DBA_DDL_LOCKS L, GV$SESSION S where  L.session_id=S.SID and  s.sid=780;

select l1.INST_ID, l1.sid, ' IS BLOCKING ', l2.sid
  from gv$lock l1, gv$lock l2
  where l1.block =1 and l2.request > 0
  and l1.id1=l2.id1
  and l1.id2=l2.id2;
  
  
  -- Query to Get List of all locked objects
SELECT * --B.Owner, B.Object_Name, A.Oracle_Username, A.OS_User_Name  
FROM V$Locked_Object A, All_Objects B
WHERE A.Object_ID = B.Object_ID ; 
-- Query to Get List of locked sessions        
select * from gv$session a  where schemaname = 'OPEN';


  SELECT * FROM DBA_WAITERS
;

select *
from gv$session
where username='OPEN'
--AND UPPER(PROGRAM) LIKE 'FIDF%'
  AND ACTION LIKE '%APLICANDO%'
