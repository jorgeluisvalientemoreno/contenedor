select count(1) as cantidad
  from gv$session s
 where s.module = 'EXECUTOR_PROCESS'
   and s.username = 'OPEN';
