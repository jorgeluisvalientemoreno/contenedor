/***********************************************************************
    Propiedad Intelectual de Open International Systems (c).
    Archivo       :  DownProccessExecutors.sql
    Descripcion   :  Baja los ejecutores de proceso de producto.

    Autor         : Jhonnatan Martínez
    Fecha         : 12-May-2014
    Historia de Modificaciones
    Fecha           Autor       Sao     Modificacion
    ==========    ========    =====   ======================================
    12-May-2014   jamartinez  233580  0001 - Creación
    
************************************************************************/
set serveroutput on
set FEED off
set verify off
set head off
SET timing off
DECLARE
    value       varchar2(50);
    CURSOR Cu
    IS
    SELECT distinct(username)
    FROM gv$session
    WHERE MODULE = 'EXECUTOR_PROCESS'
    UNION
    SELECT distinct(username)
    FROM gv$session
    WHERE MODULE = 'PROCESS_SERVER';
    
    --Baja los hilos de cada ejecutor de proceso para cada esquema
    PROCEDURE DownThreads
	(
	    tyScheme v$session.username%type --Esquema sobre el que hara el bajado de los hilos
	)
	IS
        CURSOR cu_audsid3 IS
	    SELECT client_info, audsid
	    FROM v$session
	    WHERE MODULE = 'EXECUTOR_PROCESS' AND username = tyScheme;

	    audsid v$session%rowtype;
        sbSqlSentence varchar2(10000);

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

            sbSqlSentence:= 'BEGIN' || chr(10);
            sbSqlSentence:= sbSqlSentence ||'"' || tyScheme || '".GE_BOExec_Server_MSG.Put_ServerMSG';
	        sbSqlSentence:= sbSqlSentence ||'(''';
	        sbSqlSentence:= sbSqlSentence ||Ge_BOExec_Server_MSG.csbMSG_STOP_EXIT ||''', ';
	        sbSqlSentence:= sbSqlSentence ||'null, ';
	        sbSqlSentence:= sbSqlSentence ||ejecutor || ', ';
	        sbSqlSentence:= sbSqlSentence ||hilo || ', ';
	        sbSqlSentence:= sbSqlSentence ||audsid.audsid;
	        sbSqlSentence:= sbSqlSentence ||');' || chr(10);
            sbSqlSentence:= sbSqlSentence ||'END;';

            EXECUTE IMMEDIATE sbSqlSentence;
	    END LOOP;
	    
	    EXCEPTION
        when others then
            if(cu_audsid3%isopen)then
                close cu_audsid3;
            end if;
            dbms_output.put_Line('Error bajando los hilos de los ejecutores de proceso' || chr(10) || SQLERRM);
            raise;
	END;
	
    --Baja el servidor de los ejecutores de proceso para cada esquema
    PROCEDURE DownServer
	(
	    tyScheme v$session.username%type --Esquema sobre el que hara el bajado del servidor
	)
	IS
	    nuThreadCount number;
	    nuServerCount number;
	    sbSqlSentence varchar2(10000);
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
                sbSqlSentence := 'BEGIN' || chr(10);
                sbSqlSentence := sbSqlSentence || '"' || tyScheme || '".ge_bosystemprocessmonitor.sendshutdownserver();' || chr(10);
                sbSqlSentence := sbSqlSentence || 'END;';

                EXECUTE IMMEDIATE sbSqlSentence;
	        END IF;
	    ELSE
	        dbms_output.put_Line('No se puede bajar el proceso servidor hasta que todos los hilos no se encuentren abajo.'
	                            ||chr(10)||'Si ya ejecutó el proceso de bajado de hilos por favor espere a que todos se encuentren abajo.'
	                            ||chr(10)||'Si no lo ha ha hecho, ejecute primero el proceso de bajado de hilos.');
	    END IF;
	    
	    EXCEPTION
        when others then
            dbms_output.put_Line('Error bajando los servidores de los ejecutores de proceso' || chr(10) || SQLERRM);
            raise;
	END;
	
    --Espera a que se bajen todos los hilos para proceder con el bajado de los servidores
    PROCEDURE WaitDownThreads
    is
	    nuExecutors number := 0;

        CURSOR Cu
	    IS
	    SELECT count(1)
	    FROM gv$session
	    WHERE module='EXECUTOR_PROCESS';
	BEGIN
	   LOOP
	        open Cu;
	        fetch Cu INTO nuExecutors;
	        close Cu;
	        if(nuExecutors < 1) then
	            exit;
	        END if;
	        dbms_lock.sleep(1);
	   END LOOP;
	   dbms_output.put_line('Cantidad de ejecutores antes de proceder a bajar los servidores: [' || nuExecutors || ']');
	   EXCEPTION
	        when others then
	            if(Cu%isopen)then
	                close Cu;
	            end if;
	            dbms_output.put_Line('Error al esperar mientras se bajen los hilos' || SQLERRM);
	            RAISE;
	END;

BEGIN
    if(Cu%isopen)then
        close cu;
    END if;
    open Cu;
    loop
        fetch Cu into value; --Esquema de la BD
        EXIT WHEN Cu%NOTFOUND;
        DownThreads(value); --Se bajan los hilos para el esquema
    end loop;
    close Cu;
    
    WaitDownThreads();
    
    open Cu;
    loop
        fetch Cu into value; --Esquema de la BD
        EXIT WHEN Cu%NOTFOUND;
        DownServer(value); --Se baja el servidor de los ejecutores para el esquema
    end loop;
    close Cu;
    EXCEPTION
        when others then
            if(Cu%isopen)then
                close Cu;
            END if;
            dbms_output.put_Line(SQLERRM);
            raise;
END;
/
