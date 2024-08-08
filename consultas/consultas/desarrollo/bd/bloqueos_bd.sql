select * from DBA_DDL_LOCKS L, GV$SESSION S where  L.session_id=S.SID and  s.sid=780

select l1.INST_ID, l1.sid, ' IS BLOCKING ', l2.sid
  from gv$lock l1, gv$lock l2
  where l1.block =1 and l2.request > 0
  and l1.id1=l2.id1
  and l1.id2=l2.id2;
  
  
  -- Query to Get List of all locked objects
SELECT * --B.Owner, B.Object_Name, A.Oracle_Username, A.OS_User_Name  
FROM gV$Locked_Object A, All_Objects B
WHERE A.Object_ID = B.Object_ID ; 
-- Query to Get List of locked sessions        
select * from gv$session a  where schemaname = 'OPEN';


  SELECT * FROM DBA_WAITERS


select *
from gv$session
where username='OPEN'
--AND UPPER(PROGRAM) LIKE 'FIDF%'
  AND ACTION LIKE '%APLICANDO%'
  
  



SELECT    'alter system kill session ' || select /*+ CHOOSE */ a.sid, a.serial#, A.INST_ID,a.username, a.username "DB User",

a.osuser, a.status, a.terminal, a.type ptype, b.owner, b.object, b.type, a.USERNAME "DB User"

from gv$session a, gv$access b

where a.sid=b.sid and a.inst_id = b.inst_id

and b.type<>'NON-EXISTENT'

and (b.owner is not null) and (b.owner<>'SYSTEM') and (b.owner<>'SYS')

AND UPPER(B.OBJECT) like UPPER('DAGE_MESSAGE%')

ORDER BY STATUS, OBJECT , TYPE
     || ''''
     || s.sid
     || ','
     || s.serial#
     || ',@'
     || s.inst_id
     || ''''
     || ' immediate;',
     s.*
  FROM  GV$SESSION S, gV$ACCESS g
 WHERE     object LIKE upper('%DAGE_MESSAGE%')
     and g.sid = S.SID      AND g.OWNER = 'OPEN'

select lo.* , s.*

from v$locked_object lo

join dba_objects o on lo.object_id = o.object_id

join v$session s ON s.session_id = s.sid

where o.object_name = 'xxPACKAGE NAMExx' and o.object_type = 'PACKAGE';


SELECT    'alter system kill session '
     || ''''
     || s.sid
     || ','
     || s.serial#
     || ',@'
     || s.inst_id
     || ''''
     || ' immediate;',
     s.*
  FROM  GV$SESSION S, gV$ACCESS g
 WHERE     object LIKE upper('%PKG_BCFACTUELECTRONICAGEN%')
     and g.sid = S.SID     
     and g.INST_ID=s.INST_ID
     and username='ADM_PERSON'
     
     -- AND g.OWNER = 'OPEN'
