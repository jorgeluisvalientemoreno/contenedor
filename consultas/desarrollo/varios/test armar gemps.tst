PL/SQL Developer Test script 3.0
151
declare
        INUPROCSCHEDID       GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE:=240263;

        SBOBJECTNAME               GE_OBJECT.NAME_%TYPE;
        NUOBJECTID                 GE_OBJECT.OBJECT_ID%TYPE;
        SBPROCESSSCHEDULEPARAMS    GE_PROCESS_SCHEDULE.PARAMETERS_%TYPE;
        SBSTATEMENT                VARCHAR2(2000);

        TBDETALLES          DAGE_PROC_SCHE_DETAIL.TYTBGE_PROC_SCHE_DETAIL;
        IXDETALLES          NUMBER;
        
        
        SBPARAMETERVALUES           VARCHAR2(4000);
        
        PROCEDURE GETPARAMETERVALUES
        (
            ISBPARAMETROS    IN VARCHAR2,
            
            OSBVALUES        OUT VARCHAR2
        ) IS

            
            TBSTR           UT_STRING.TYTB_STRING;
            
            NUPOSPARAM      NUMBER;

        BEGIN
            OSBVALUES := '';
            

            TBSTR.DELETE;
            
            UT_STRING.EXTSTRING (ISBPARAMETROS, '|', TBSTR);

            
            FOR I IN 1 .. TBSTR.COUNT LOOP

                
                NUPOSPARAM := INSTR(TBSTR(I),'=');
                IF NUPOSPARAM != 0 THEN
                    
                    IF SUBSTR(TBSTR(I),NUPOSPARAM+1) IS NULL THEN
                        OSBVALUES := OSBVALUES || 'null, ';
                    ELSE
                        OSBVALUES := OSBVALUES ||SUBSTR(TBSTR(I),NUPOSPARAM+1)||', ';
                    END IF;
                END IF;

            END LOOP;
            
            OSBVALUES := SUBSTR(OSBVALUES, 0, LENGTH(OSBVALUES)-2);

        END;
        
        PROCEDURE GETOBJECT
        (
            ISBPARAMETROS    IN VARCHAR2,
            ONUOBJECT        OUT NUMBER
        ) IS

            
            TBSTR           UT_STRING.TYTB_STRING;
            
            NUPOSPARAM      NUMBER;

        BEGIN

            TBSTR.DELETE;
            
            UT_STRING.EXTSTRING (ISBPARAMETROS, '|', TBSTR);

            
            FOR I IN 1 .. TBSTR.COUNT LOOP

                
                NUPOSPARAM := INSTR(TBSTR(I),'OBJECT_ID=');
                IF NUPOSPARAM != 0 THEN
                    ONUOBJECT := SUBSTR(TBSTR(I),NUPOSPARAM+10);
                END IF;

            END LOOP;

        END;
        
    BEGIN
        UT_TRACE.TRACE('Inicia GE_BOSchedule.ExecuteObjectProcess',7);
        
        SBPROCESSSCHEDULEPARAMS := DAGE_PROCESS_SCHEDULE.FSBGETPARAMETERS_(INUPROCSCHEDID);
        
        GETOBJECT(SBPROCESSSCHEDULEPARAMS, NUOBJECTID);
        
        SBOBJECTNAME := DAGE_OBJECT.FSBGETNAME_(NUOBJECTID);
        
        GE_BCPROC_SCHE_DETAIL.GETSCHEDULEDETAILS(INUPROCSCHEDID,TBDETALLES);

        IXDETALLES := TBDETALLES.FIRST;
        
        IF IXDETALLES IS NULL THEN
        
            SBSTATEMENT := 'BEGIN '||SBOBJECTNAME||'; '||
                                'EXCEPTION '||
                                'when OTHERS THEN '||
                                'Errors.SetError; '||
                                'ut_trace.Trace('||CHR(39)||'Error en la '
                                ||IXDETALLES||'� ejecuci�n de '||SBOBJECTNAME||'. El error fue: '
                                ||CHR(39)||'|| Errors.nuErrorCode ||'||CHR(39)||
                                '-'||CHR(39)||'||Errors.sbErrorMessage||'||CHR(39)||
                                '.  Continuando con la siguiente ejecuci�n'||CHR(39)||', 6); '||
                                'END;';

            UT_TRACE.TRACE(SBSTATEMENT, 15);
            EXECUTE IMMEDIATE SBSTATEMENT;
        
        END IF;
        LOOP
          EXIT WHEN IXDETALLES IS NULL;

            GETPARAMETERVALUES(TBDETALLES(IXDETALLES).PARAMETER, SBPARAMETERVALUES);
            
            
            SBSTATEMENT := 'BEGIN '||SBOBJECTNAME||'('||SBPARAMETERVALUES||'); '||
                                'EXCEPTION '||
                                'when OTHERS THEN '||
                                'Errors.SetError; '||
                                'ut_trace.Trace('||CHR(39)||'Error en la '
                                ||IXDETALLES||'� ejecuci�n de '||SBOBJECTNAME||'. El error fue: '
                                ||CHR(39)||'|| Errors.nuErrorCode ||'||CHR(39)||
                                '-'||CHR(39)||'||Errors.sbErrorMessage||'||CHR(39)||
                                '.  Continuando con la siguiente ejecuci�n'||CHR(39)||', 6); '||
                                'END;';
                                
            UT_TRACE.TRACE(SBSTATEMENT, 15);
            EXECUTE IMMEDIATE SBSTATEMENT;

            IXDETALLES := TBDETALLES.NEXT(IXDETALLES);
        END LOOP;
        
        
        
        
            
        
        UT_TRACE.TRACE('Finaliza GE_BOSchedule.ExecuteObjectProcess',7);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;
0
1
SBSTATEMENT
