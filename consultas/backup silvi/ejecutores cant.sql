select count(1) as cantidad
from gv$session s
where s.module = 'EXECUTOR_PROCESS'
and s.username = 'OPEN' ;

SELECT count(*)
FROM gv$session
WHERE module='PROCESS_SERVER';
