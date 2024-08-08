
DECLARE
    nuexit number;
    sboutput varchar2(32764);
BEGIN
    GE_BOPROCESS_SERVER.SETSERVERUP();
END;
/


DECLARE
 CURSOR CUGETSESION IS
  SELECT SID
  FROM gv$session
  WHERE module='PROCESS_SERVER';
  NUSID NUMBER;
  
  CURSOR CUVALIDATESESSION(IDEN NUMBER) IS
  SELECT UPPER(q.sql_text) "texto"
  FROM gv$session s,
       gv$sqltext q
 WHERE  s.sql_hash_value = q.hash_value
   AND s.sql_address = q.address
   AND s.sid in (IDEN
   )
order by q.piece;
 SBTEXTO VARCHAR2(4000):='GE_BOPROCESS_SERVER.PUTMSGMONITORSERVER';
 SBINPROGRESS VARCHAR2(4000):='GE_BOPROCESS_SERVER.PUTMSGMONITORSERVER';
 NUEXECUTOR NUMBER;
BEGIN
   WHILE NUSID IS NULL LOOP
     OPEN CUGETSESION;
     FETCH CUGETSESION INTO NUSID;
     CLOSE CUGETSESION;
   END LOOP;
   DBMS_OUTPUT.PUT_LINE(NUSID);
   WHILE SBTEXTO LIKE '%'||SBINPROGRESS||'%' LOOP
     DBMS_LOCK.SLEEP(5);
     OPEN CUVALIDATESESSION(NUSID);
     FETCH CUVALIDATESESSION INTO SBTEXTO;
     CLOSE CUVALIDATESESSION;
     
     
     select count(1) INTO NUEXECUTOR
     from gv$session s
     where s.module = 'EXECUTOR_PROCESS';
     
     DBMS_OUTPUT.PUT_LINE(NUEXECUTOR);
   END LOOP;
   
   DBMS_OUTPUT.PUT_LINE('TERMINO SUBIR EJECUOTRES');
   
   DBMS_OUTPUT.PUT_LINE('SUBIR ADICIONALES');
   
   
   
END;
/
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
   DBMS_OUTPUT.PUT_LINE('TERMINO SUBIR ADICIONALES');
end;
/