column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;



DECLARE
    nuexit   NUMBER;
    sboutput VARCHAR2(32764);
BEGIN
	--subir process server
    ge_boprocess_server.setserverup();
END;
/


DECLARE
 CURSOR cuGetSesion IS
  SELECT sid
  FROM gv$session
  WHERE module='PROCESS_SERVER';
  
  CURSOR cuValidateSession(IDEN NUMBER) IS
  SELECT UPPER(q.sql_text) "texto"
  FROM gv$session s,
       gv$sqltext q
 WHERE  s.sql_hash_value = q.hash_value
   AND s.sql_address = q.address
   AND s.sid = IDEN
 order by q.piece;

 sbTexto 		VARCHAR2(4000):='GE_BOPROCESS_SERVER.PUTMSGMONITORSERVER';
 sbInProgress 	VARCHAR2(4000):='GE_BOPROCESS_SERVER.PUTMSGMONITORSERVER';
 nuExecutor 	NUMBER;
 nuSID 			NUMBER;
BEGIN
   --ESPERAR QUE TERMINEN DE SUBIR LOS EJECUTORES
   WHILE nuSID IS NULL LOOP
     OPEN cuGetSesion;
     FETCH cuGetSesion INTO nuSID;
     CLOSE cuGetSesion;
   END LOOP;
   
   DBMS_OUTPUT.PUT_LINE('SID: '|| nuSID);
   
   WHILE sbTexto LIKE '%'||sbInProgress||'%' LOOP
     dbms_lock.sleep(5);
     OPEN cuValidateSession(nuSID);
     FETCH cuValidateSession INTO sbTexto;
     CLOSE cuValidateSession;
     
     SELECT count(1) 
	 INTO nuExecutor
     FROM gv$session s
     WHERE s.module = 'EXECUTOR_PROCESS';
     
     DBMS_OUTPUT.PUT_LINE('nuExecutor: '|| nuExecutor);
   END LOOP;
   
   DBMS_OUTPUT.PUT_LINE('TERMINO SUBIR EJECUOTRES');
   
   
   
   
   
END;
/

DECLARE 
  CURSOR cuDifHilos IS
    WITH base as
    (select process_executor_id, 'Executor='||e.process_executor_id ejecutor, e.thread hilo, count(s.SID) cantidad
    from open.ge_process_executor e
    left join gv$session s on s.MODULE = 'EXECUTOR_PROCESS' and s.username = 'OPEN' and 'Executor='||e.process_executor_id=substr(client_info,0,instr(client_info,' ')-1)
    group by e.process_executor_id, e.thread
    )
    SELECT b.*,
           hilo-cantidad faltante
    FROM base b
    WHERE b.process_executor_id!=-1
     AND hilo>cantidad;
     
 nuContador number;
begin
  DBMS_OUTPUT.PUT_LINE('SUBIR ADICIONALES');
  FOR reg IN cuDifHilos LOOP
    nuContador:=1;
    WHILE nuContador <= reg.faltante LOOP
        GE_BOProcess_Server.sendCreate_Thread (reg.process_executor_id);
        nuContador:=nuContador+1;
    END LOOP;
  END LOOP;
   DBMS_OUTPUT.PUT_LINE('TERMINO SUBIR ADICIONALES');
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/