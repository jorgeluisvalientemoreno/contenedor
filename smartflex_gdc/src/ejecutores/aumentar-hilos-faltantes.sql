declare 
  cursor cuDifHilos is
    with base as
    (select process_executor_id, 'Executor='||e.process_executor_id ejecutor, e.thread hilo, count(s.SID) cantidad
    from open.ge_process_executor e
    left join gv$session s on s.MODULE = 'EXECUTOR_PROCESS' and s.username = 'OPEN' and 'Executor='||e.process_executor_id=substr(client_info,0,instr(client_info,' ')-1)
    group by e.process_executor_id, e.thread
    )
    select b.*,
           hilo-cantidad faltante
    from base b
    where b.process_executor_id!=-1
     and hilo>cantidad;
     
 nuContador number;
begin
  for reg in cuDifHilos loop
    nuContador:=1;
    while nuContador <= reg.faltante loop
        GE_BOProcess_Server.sendCreate_Thread (reg.process_executor_id);
        nuContador:=nuContador+1;
    end loop;
  end loop;
end;
/