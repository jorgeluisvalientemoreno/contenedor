REM Fuente="Propiedad Intelectual de Gases del Caribe y Efigas"
REM Script		 :		OSF-1127_Script_Canc_Prog_Jobs_GEMPS.sql
REM Autor 		 :		Isabel Becera - Horbath - Cristian Mendes - GdC - Lubin Pineda - MVM
REM Fecha 		 :		23-05-2023
REM Descripcion	 :		Cancela las programaciones en ge_process_schedule,
REM              :      su job asociado y las sesiones asociadas si el job
REM              :      ejecuta hilos por medio de Llamasist y el objeto 
REM              :      que ejecuta el Pro*C es customizado
REM CASO	     :		OSF-1127
REM Prerrequisito:		
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

    PROCEDURE pCargatbObjEjecLlamSist
    IS
    BEGIN
    
        tbObjEjecLlamSist('PERSCA')    := 'LDC_PKGENEORDEAUTORECO';
        tbObjEjecLlamSist('GOPCVNEL')  := 'LDC_BCSALESCOMMISSION_NEL';
    
    END pCargatbObjEjecLlamSist;
            
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
    
    PROCEDURE pKillSesionLlamaSist ( isbAplicacion VARCHAR2, osbRes OUT VARCHAR2 )
    IS
        
        CURSOR cuUsaLlamaSist
        IS
        SELECT name
        FROM all_dependencies
        WHERE name = isbAplicacion
        AND referenced_name = 'LLAMASIST';
        
        rcUsaLlamaSist  cuUsaLlamaSist%ROWTYPE;
        
        CURSOR cuObjBloqEnEjec ( isbObjeto VARCHAR2 )
        IS
        SELECT    'alter system kill session '
             || ''''
             || s.sid
             || ','
             || s.serial#
             || ',@'
             || s.inst_id
             || ''''
             || ' immediate;' comando
          FROM  GV$SESSION S, gV$ACCESS g
         WHERE     object LIKE upper('%' || isbObjeto ||'%' )
             and g.sid = S.SID      AND g.OWNER = 'OPEN';
             
        sbComandoKill   VARCHAR2(4000); 
        
        sbResExecImm    VARCHAR2(4000); 
        
        sbObjEjecLlamSist VARCHAR2(100);     
            
    BEGIN
    
        IF tbObjEjecLlamSist.Exists( isbAplicacion ) THEN
        
            sbObjEjecLlamSist := tbObjEjecLlamSist( isbAplicacion );

            OPEN cuObjBloqEnEjec( sbObjEjecLlamSist );
            FETCH cuObjBloqEnEjec INTO sbComandoKill;
            CLOSE cuObjBloqEnEjec;
            
            pExecImm( sbComandoKill, sbResExecImm );
            
            
            
        ELSE
        
            OPEN cuUsaLlamaSist;
            FETCH cuUsaLlamaSist INTO rcUsaLlamaSist;
            CLOSE cuUsaLlamaSist;
            
            IF rcUsaLlamaSist.Name IS NOT NULL THEN
                sbResExecImm := 'WARNING:usa LlamaSist pero se desconoce el objeto que ejecuta' ;            
            ELSE
                sbResExecImm := 'OK:NO usa LlamaSist';            
            END IF;
                        
        END IF;
        
        osbRes := sbResExecImm || csbSep ||  sbComandoKill || csbSep || sbObjEjecLlamSist ;
    
    END pKillSesionLlamaSist;
    
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

        sbEncabezado := sbEncabezado || 'start_date_' || csbSep  || 'pKillSesionLlamaSist'|| csbSep;

        sbEncabezado := sbEncabezado || 'comando_kill' || csbSep  || 'objeto_LlamaSist'|| csbSep;
        
        sbEncabezado := sbEncabezado ||'sbRemJob'||   csbSep;
                
        sbEncabezado := sbEncabezado || 'sbKillJobSession'|| csbSep || 'sbUpdProcessSchedule'|| csbSep;

        -- Imprime encabezado
        dbms_output.put_line( sbEncabezado );
        
    END pImprEncabezado;    
    
BEGIN

    pCargatbObjEjecLlamSist;
    
    pImprEncabezado;

    FOR rgScheduler IN cuScheduler LOOP
    
        sbInfoGeSchedProc := rgScheduler.executable_id || csbSep ||  rgScheduler.name_ || csbSep;
        
        sbInfoGeSchedProc := sbInfoGeSchedProc || rgScheduler.process_schedule_id || csbSep ||  rgScheduler.job || csbSep;

        sbInfoGeSchedProc := sbInfoGeSchedProc || rgScheduler.frequency || csbSep || rgScheduler.parameters_ || csbSep;       

        sbInfoGeSchedProc := sbInfoGeSchedProc || rgScheduler.status || csbSep || rgScheduler.log_user|| csbSep; 

        sbInfoGeSchedProc := sbInfoGeSchedProc || rgScheduler.start_date_ || csbSep ; 
        
        sbKillSesionLlamaSist   := null;
        sbRemJob                := null;
        sbKillJobSession        := null;
        sbUpdProcessSchedule    := null;
                               
        IF rgScheduler.JOB > 0 THEN
                    
            pKillSesionLlamaSist( rgScheduler.name_, sbKillSesionLlamaSist);
        
            pRemJob ( rgScheduler.JOB, sbRemJob ); 
            
            pKillJobSession( rgScheduler.JOB, sbKillJobSession );
            
        ELSE
        
            sbKillSesionLlamaSist := csbSep || csbSep;

        END IF;
        
        pUpdProcessSchedule( rgScheduler.process_schedule_id, sbUpdProcessSchedule);  
        
        sbInfoGeSchedProc := sbInfoGeSchedProc || sbKillSesionLlamaSist || csbSep;

        sbInfoGeSchedProc := sbInfoGeSchedProc || sbRemJob || csbSep;

        sbInfoGeSchedProc := sbInfoGeSchedProc || sbKillJobSession || csbSep;
                                                              
        sbInfoGeSchedProc := sbInfoGeSchedProc || sbUpdProcessSchedule || csbSep;   
                
        dbms_output.put_line( sbInfoGeSchedProc );

    END LOOP;

END;