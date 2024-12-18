REM Fuente="Propiedad Intelectual de Gases del Caribe y Efigas"
REM Descripcion	 :		Cancela las programaciones en ge_process_schedule,
REM              :      su job asociado 
DECLARE
        
    sbSimulacion            VARCHAR2(1) := 'N';

    csbSep                  CONSTANT VARCHAR2(1) := ';';

    sbInfoGeSchedProc       VARCHAR2(4000); 
    
    sbKillSesionLlamaSist   VARCHAR2(4000);
    sbRemJob                VARCHAR2(4000);
    sbKillJobSession        VARCHAR2(4000);
    sbUpdProcessSchedule    VARCHAR2(4000);   
    
    TYPE tytbObjEjecLlamSist IS TABLE OF VARCHAR2(4000) INDEX BY VARCHAR2(200);
    
    tbObjEjecLlamSist      tytbObjEjecLlamSist;   

    CURSOR cuScheduler
    IS
    WITH ejec as
    (
        SELECT 
            executable_id, NAMe NAME_, description
        FROM
            sa_executable

    )
    SELECT
        ej.executable_id , ej.name_, ej.description, 
        pe.process_schedule_id, job,frequency,parameters_,status,log_user,start_date_        
    FROM
        ejec ej,
        ge_process_schedule pe
    WHERE
        pe.executable_id = ej.executable_id
        and pe.status NOT IN  ( 'C', 'E' ) 
		and ej.executable_id in (500000000011285,500000000013776,500000000007153,500000000013735)
    ORDER BY
        pe.start_date_ DESC;
             
    PROCEDURE pExecImm( isbComando VARCHAR, osbRes OUT VARCHAR2 )
    IS
    BEGIN
    
        IF sbSimulacion = 'N' THEN        
            EXECUTE IMMEDIATE isbComando;
        END IF;
            
        osbRes := 'OK-pExecImm';
    EXCEPTION
        WHEN OTHERS THEN
            osbRes := 'ERROR[' || SQLERRM|| '][' || isbComando || '''';
            ROLLBACK;
    END pExecImm;

            
    PROCEDURE pRemJob( inuJob NUMBER, osbRes OUT VARCHAR2 )
    IS
    BEGIN             
    
        IF sbSimulacion = 'N' THEN
            DBMS_JOB.BROKEN(inuJob, TRUE);
            DBMS_JOB.REMOVE(inuJob);
        END IF;
                
        osbRes := 'OK-pRemJob';
        
    EXCEPTION 
        WHEN OTHERS THEN
            osbRes := 'ERROR[' || SQLERRM || ']';
            ROLLBACK;
    END pRemJob;
    
    
    PROCEDURE pKillJobSession( inuJob NUMBER, osbRes OUT VARCHAR2 )
    IS

        blJobRunning        BOOLEAN := FALSE;

        sbComandoKillJob    VARCHAR2(2000);
        
        osbExecImm          VARCHAR2(2000);
        
        CURSOR cuSesion 
        IS
        select
           jr.job,
           s.username,
           s.sid,
           s.serial#,
           p.spid,
           s.lockwait,
           s.logon_time,
           (sysdate - s.logon_time)*(24*60) Tiempo_Minutos
        from
           dba_jobs_running jr,
           v$session s,
           v$process p
        where
           jr.sid = s.sid
        and
           s.paddr = p.addr
           and  jr.job = inuJob
        order by
           jr.job;

    BEGIN 

        FOR rgSesion IN cuSesion LOOP 
            sbComandoKillJob := 'alter system kill session ' || '''' || rgSesion.sid || ',' || rgSesion.serial# || '''' || ' immediate';
            
            pExecImm( sbComandoKillJob, osbExecImm );
            blJobRunning := TRUE;
        END LOOP;
        
        IF blJobRunning THEN
            osbRes := osbExecImm;
        ELSE
            osbRes := 'INFO:JOB NOT RUNNING';        
        END IF;
        
        EXCEPTION
            WHEN OTHERS THEN
                --DBMS_OUTPUT.PUT_LINE( 'ERROR KILL SESSION JOB |' || InuJob || csbSep || SQLERRM );
                osbRes := SQLERRM;
                ROLLBACK;         
    END pKillJobSession;  
     
    PROCEDURE pUpdProcessSchedule( inuprocess_schedule_id NUMBER, osbUpdProcessSchedule OUT VARCHAR2)
    IS
        rcProcess_Schedule  DAGE_PROCESS_SCHEDULE.STYGE_PROCESS_SCHEDULE;    
    BEGIN
    
        DAGE_PROCESS_SCHEDULE.GETRECORD(inuprocess_schedule_id,rcProcess_Schedule);
    
        rcProcess_Schedule.Status := 'C';
        rcProcess_Schedule.Job := -1;
    
        IF sbSimulacion = 'N' THEN
            DAGE_PROCESS_SCHEDULE.UPDRECORD( rcProcess_Schedule );
            COMMIT;
        ELSE
            ROLLBACK;
        END IF; 
        
        osbUpdProcessSchedule := 'OK-pUpdProcessSchedule';
        
        EXCEPTION
            WHEN OTHERS THEN
            osbUpdProcessSchedule := SQLERRM;
            ROLLBACK;
    END pUpdProcessSchedule;      
    
    
    PROCEDURE pImprEncabezado
    IS
        sbEncabezado    VARCHAR2(4000);
    BEGIN
    
        sbEncabezado := 'executable_id ' || csbSep ||  'Aplicacion' || csbSep;
        
        sbEncabezado := sbEncabezado || 'process_schedule_id ' || csbSep ||  'job' || csbSep;

        sbEncabezado := sbEncabezado || 'frequency ' || csbSep || 'parameters_' || csbSep;       

        sbEncabezado := sbEncabezado || 'status ' || csbSep || 'log_user' || csbSep; 

        sbEncabezado := sbEncabezado ||'sbRemJob'||   csbSep;
                
        sbEncabezado := sbEncabezado || 'sbKillJobSession'|| csbSep || 'sbUpdProcessSchedule'|| csbSep;

        -- Imprime encabezado
        dbms_output.put_line( sbEncabezado );
        
    END pImprEncabezado;    
    
BEGIN

  
    pImprEncabezado;

    FOR rgScheduler IN cuScheduler LOOP
    
        sbInfoGeSchedProc := rgScheduler.executable_id || csbSep ||  rgScheduler.name_ || csbSep;
        
        sbInfoGeSchedProc := sbInfoGeSchedProc || rgScheduler.process_schedule_id || csbSep ||  rgScheduler.job || csbSep;

        sbInfoGeSchedProc := sbInfoGeSchedProc || rgScheduler.frequency || csbSep || rgScheduler.parameters_ || csbSep;       

        sbInfoGeSchedProc := sbInfoGeSchedProc || rgScheduler.status || csbSep || rgScheduler.log_user|| csbSep; 

        sbInfoGeSchedProc := sbInfoGeSchedProc || rgScheduler.start_date_ || csbSep ; 
        
        sbRemJob                := null;
        sbKillJobSession        := null;
        sbUpdProcessSchedule    := null;
                               
        IF rgScheduler.JOB > 0 THEN
                    
            pRemJob ( rgScheduler.JOB, sbRemJob ); 
            
            pKillJobSession( rgScheduler.JOB, sbKillJobSession );

        END IF;
        
        pUpdProcessSchedule( rgScheduler.process_schedule_id, sbUpdProcessSchedule);  
        
        sbInfoGeSchedProc := sbInfoGeSchedProc || sbRemJob || csbSep;

        sbInfoGeSchedProc := sbInfoGeSchedProc || sbKillJobSession || csbSep;
                                                              
        sbInfoGeSchedProc := sbInfoGeSchedProc || sbUpdProcessSchedule || csbSep;   
                
        dbms_output.put_line( sbInfoGeSchedProc );

    END LOOP;

END;
/