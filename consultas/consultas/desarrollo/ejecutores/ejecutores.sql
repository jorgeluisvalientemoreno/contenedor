--------------------------BAJAR HILOS
DECLARE
    client_info_char varchar2(30);
    CURSOR cu_audsid IS
    SELECT *
    FROM v$session
    WHERE osuser = '$1'
    AND  MODULE = 'EXECUTOR_PROCESS'
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


--------------------------Bajar Proccess Server
DECLARE
    nuThreadCount number;
    nuServerCount number;
BEGIN
    SELECT count(*) INTO nuThreadCount
    FROM v$session
    WHERE module='EXECUTOR_PROCESS';
    SELECT count(*) INTO nuServerCount
    FROM v$session
    WHERE module='PROCESS_SERVER';
    IF(nuThreadCount=0)
    THEN
        IF(nuServerCount=0)
        THEN
            dbms_output.put_Line('El proceso servidor ya se encuentra abajo.');
        ELSE
            dbms_output.put_Line('Se procede a bajar el proceso servidor, por favor espere.');
            ge_bosystemprocessmonitor.sendshutdownserver();
        END IF;
    ELSE
        dbms_output.put_Line('No se puede bajar el proceso servidor hasta que todos los hilos no se encuentren abajo.'
                            ||chr(10)||'Si ya ejecutM-s el proceso de bajado de hilos por favor espere a que todos se encuentren abajo.'
                            ||chr(10)||'Si no lo ha ha hecho, ejecute primero el proceso de bajado de hilos.');
    END IF;
END;
/


--------------------------Subir ejecutores
DECLARE
    nuexit number;
    sboutput varchar2(32764);
BEGIN
    GE_BOPROCESS_SERVER.SETSERVERUP();
    
END;
/