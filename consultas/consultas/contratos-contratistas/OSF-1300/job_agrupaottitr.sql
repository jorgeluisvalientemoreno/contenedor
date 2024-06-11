DECLARE
    
    onuCodError     NUMBER;
    osbMensError    VARCHAR2(4000);
    
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
    
BEGIN

    pDebugOn;

    DBMS_SCHEDULER.RUN_JOB('JOB_AGRUPAOTTITR');
    
    pDebugOff;
    
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR CONTR' || osbMensError);
        when others then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR NCONT|' || osbMensError );
END;
