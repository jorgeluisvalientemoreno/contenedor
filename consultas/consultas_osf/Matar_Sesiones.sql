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
 WHERE     object LIKE '%OR_BCORDERACTIVITIES%'
     and g.sid = S.SID      AND g.OWNER = 'OPEN';

/*select \*+ CHOOSE *\ a.sid, a.serial#, A.INST_ID,a.username, a.username "DB User",
a.osuser, a.status, a.terminal, a.type ptype, b.owner, b.object, b.type, a.USERNAME "DB User"
from gv$session a, gv$access b
where a.sid=b.sid and a.inst_id = b.inst_id
and b.type<>'NON-EXISTENT'
and (b.owner is not null) and (b.owner<>'SYSTEM') and (b.owner<>'SYS')
AND UPPER(B.OBJECT) like UPPER('Or_BOLegalizeActivities%')
ORDER BY STATUS, OBJECT , TYPE */    


