select s.INST_ID,s.username, count(1) as cantidad
from gv$session s
where s.module = 'EXECUTOR_PROCESS'
group by s.INST_ID, s.username;


select *
from gv$session
where MODULE LIKE 'demonio%';


SELECT count(*)
FROM gv$session
WHERE module='PROCESS_SERVER';



with base as
(select 'Executor='||e.process_executor_id ejecutor, e.thread hilo, count(s.SID) cantidad
from open.ge_process_executor e
left join gv$session s on s.MODULE = 'EXECUTOR_PROCESS' and s.username = 'OPEN' and 'Executor='||e.process_executor_id=substr(client_info,0,instr(client_info,' ')-1)
where e.process_executor_id!=-1
group by 'Executor='||e.process_executor_id, e.thread
)
select b.*, 
       hilo-cantidad,
       case when hilo!=cantidad then 'S' else 'N' end DIFERENCIAS
from base b
where hilo>cantidad
