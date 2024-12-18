column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    client_info_char varchar2(30);
    CURSOR cu_audsid IS
        SELECT *
        FROM v$session
        WHERE osuser = '$1'
        AND MODULE = 'EXECUTOR_PROCESS'
        ORDER BY client_info;
    CURSOR cu_audsid2 IS
        SELECT *
        FROM v$session
        WHERE MODULE = 'EXECUTOR_PROCESS'
        AND client_info=client_info_char
        ORDER BY client_info;
    CURSOR cu_audsid3 IS
        SELECT *
        FROM v$session
        WHERE MODULE = 'EXECUTOR_PROCESS';
    audsid v$session%rowtype;
    ejecutor number;
    hilo number;
    posInicio number;
    posFin number;
    executor_char varchar2(20);
    hilo_char varchar2(20);
    expression varchar2(50);
    user_char varchar2(20);
BEGIN
    user_char:=NULL;
    executor_char:=NULL;
    hilo_char:=NULL;
    FOR audsid IN cu_audsid3
    LOOP
        expression:=audsid.client_info;
        executor_char:='';
        hilo_char:='';
        posInicio:=INSTR(expression,'=',1,1);
        posFin:=INSTR(expression,' ',1,1);
        executor_char:=SUBSTR(expression,posInicio+1,posFin-(posInicio+1));
        posInicio:=INSTR(expression,'=',1,2);
        posFin:=LENGTH(expression);
        hilo_char:=SUBSTR(expression,posInicio+1,posFin);
        ejecutor:=to_number(executor_char);
        hilo:=to_number(hilo_char);
        DBMS_OUTPUT.PUT_LINE('Ejecutor:('||ejecutor||') Hilo:('||hilo||')');
        GE_BOExec_Server_MSG.Put_ServerMSG
        (
        Ge_BOExec_Server_MSG.csbMSG_STOP_EXIT,
        null,
        ejecutor,
        hilo,
        audsid.audsid
        );
    END LOOP;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/