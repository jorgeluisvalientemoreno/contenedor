Declare
    sbMens varchar2(4000);
    sbINI  varchar2(1) := 'T';
    
        blDebug BOOLEAN := TRUE;
        
        PROCEDURE pDebugOn IS
        BEGIN
                   
            -- Si la base de datos es sfba0708 ó sfto0708 se hace debug
            IF blDebug THEN    
        
                Errors.Initialize;
                ut_trace.Init;
                --ut_trace.SetOutPut(ut_trace.CNUTRACE_OUTPUT_DB);
                ut_trace.SetOutPut(ut_trace.CNUTRACE_DBMS_OUTPUT);
                ut_trace.SetLevel(99);
                pkGeneralServices.SETTRACEDATAON;
                           
            END IF;
        
        END pDebugOn;
        
        PROCEDURE pDebugOff IS
        BEGIN
        
            -- Si la base de datos es sfba0708 ó sfto0708 se hace debug
            IF blDebug THEN 
                
                ut_trace.SetLevel(0);
                Pkerrors.traceoFF;
                pkGeneralServices.SETTRACEDATAOFF;
                
            END IF;
                
        END pDebugOff;
    
Begin
    --pDebugOn;
    DBMS_SCHEDULER.RUN_JOB('REGISTRA_LECTESP_CRIT');
    --pDebugOff;
End;

/*
    select *
    from ldc_osf_estaproc
*/
