PACKAGE BODY Ge_BoReportProcess
IS




















































    
    
    
    
    CSBVERSION              CONSTANT VARCHAR2(20)       := 'SAO229023';

    CSBMAXREGSTOPROCESS     CONSTANT NUMBER             := 100;
    
    
    
    
    














    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    


































    PROCEDURE EXERECORDPROCESSBYTHRD
    (
        INUPROCESSCTRL  IN  GE_CONTROL_PROCESS.CONTROL_PROCESS_ID%TYPE,
        INUTHREADNUM    IN  NUMBER,
        INUTHREADTOTAL  IN  NUMBER
    )
    IS
        
        RCCTRLPROCESS           DAGE_CONTROL_PROCESS.STYGE_CONTROL_PROCESS;
        TBREGISTERTOPROCESS     DAGE_RECORD_PROCESS.TYTBGE_RECORD_PROCESS;
        RCOBJECTID              DAGE_OBJECT.STYGE_OBJECT;

        NUINDICE                NUMBER;
        SBDECLARE               VARCHAR2(32767);
        SBRETURNFUNCT           VARCHAR2(100);
        
        NUERRORCODE             NUMBER;
        SBERRORMESSAGE          VARCHAR2(2000);
        
        SBARGUMENTS             VARCHAR2(32767);
        SBARGUMENTSPARAMOUT     VARCHAR2(32767); 
        
        
        NUAMOUNT_REC_PROC       GE_CONTROL_PROCESS.AMOUNT_RECORD_PROC%TYPE := 0;
        
        NUAMOUNT_SUCCESS_REC    GE_CONTROL_PROCESS.AMOUNT_SUCCESS_RECD%TYPE := 0;
        
        NUAMOUNT_FAILED_REC     GE_CONTROL_PROCESS.AMOUNT_FAILED_RECD%TYPE := 0;

    BEGIN
        
        UT_TRACE.TRACE('Inicio Ge_BoReportProcess.ExeRecordProcessByThrd',10);
        
        
        RCCTRLPROCESS   := DAGE_CONTROL_PROCESS.FRCGETRECORD(INUPROCESSCTRL);
        
        
        RCOBJECTID      := DAGE_OBJECT.FRCGETRECORD(RCCTRLPROCESS.OBJECT_ID);

        
        
        

        
        
        
        
        GE_BOOBJECT.ADDARGTSINOUTANDVARDEF
        (
            RCOBJECTID.NAME_,
            SBDECLARE,
            SBRETURNFUNCT,
            SBARGUMENTSPARAMOUT
        );

        IF (GE_BCRECORDPROCESS.CUREGISTERTOPROCESS%ISOPEN ) THEN
            CLOSE GE_BCRECORDPROCESS.CUREGISTERTOPROCESS;
        END IF;

        
        OPEN GE_BCRECORDPROCESS.CUREGISTERTOPROCESS( INUTHREADTOTAL, INUTHREADNUM, INUPROCESSCTRL );
        
        LOOP
            FETCH GE_BCRECORDPROCESS.CUREGISTERTOPROCESS BULK COLLECT INTO TBREGISTERTOPROCESS LIMIT CSBMAXREGSTOPROCESS;

            
            IF ( TBREGISTERTOPROCESS.COUNT <= 0 ) THEN
                EXIT; 
            END IF;

            NUINDICE := TBREGISTERTOPROCESS.FIRST;
            LOOP
                
                BEGIN
                    SAVEPOINT RETURNPOINTEXE;
                    
                    IF (SBARGUMENTSPARAMOUT IS NOT NULL) THEN
                        SBARGUMENTS := CONCAT(TBREGISTERTOPROCESS(NUINDICE).ARGUMENTS,',')||
                                       GE_BOCONSTANTS.CSBENTER||SBARGUMENTSPARAMOUT;
                    ELSE
                        SBARGUMENTS := TBREGISTERTOPROCESS(NUINDICE).ARGUMENTS;
                    END IF;

                    
                    
                    GE_BCRECORDPROCESS.UPDTOBEENRUNNING(TBREGISTERTOPROCESS(NUINDICE).RECORD_PROCESS_ID);

                    
                    GE_BOOBJECT.EXECOBJ_IMMED_WITHPARAM
                    (
                        RCOBJECTID.NAME_,
                        SBARGUMENTS,
                        SBDECLARE,
                        SBRETURNFUNCT
                    );

                    
                    
                    
                    GE_BCRECORDPROCESS.UPDTOFINISHOK(TBREGISTERTOPROCESS(NUINDICE).RECORD_PROCESS_ID);
                    NUAMOUNT_REC_PROC := NUAMOUNT_REC_PROC + 1;
                    NUAMOUNT_SUCCESS_REC := NUAMOUNT_SUCCESS_REC + 1;
                EXCEPTION
                    WHEN OTHERS THEN
                        ERRORS.SETERROR;
                        ERRORS.GETERROR(NUERRORCODE, SBERRORMESSAGE);

                        
                        GE_BCRECORDPROCESS.UPDTOFINISHBAD
                        (
                            TBREGISTERTOPROCESS(NUINDICE).RECORD_PROCESS_ID,
                            NUERRORCODE,
                            SBERRORMESSAGE
                        );
                        
                        ROLLBACK TO SAVEPOINT RETURNPOINTEXE;

                        NUAMOUNT_FAILED_REC := NUAMOUNT_FAILED_REC + 1;
                        NUAMOUNT_REC_PROC := NUAMOUNT_REC_PROC + 1;
                END;
                
                
                NUINDICE := TBREGISTERTOPROCESS.NEXT(NUINDICE);
                EXIT WHEN NUINDICE IS NULL;
            END LOOP;

            
            
            GE_BCCONTROLPROCESS.UPDAMOUNTREG
            (
                INUPROCESSCTRL,
                NUAMOUNT_REC_PROC,
                NUAMOUNT_SUCCESS_REC,
                NUAMOUNT_FAILED_REC
            );

            
            COMMIT;
            
            NUAMOUNT_REC_PROC := 0;
            NUAMOUNT_SUCCESS_REC := 0;
            NUAMOUNT_FAILED_REC := 0;
            
        END LOOP;

        CLOSE GE_BCRECORDPROCESS.CUREGISTERTOPROCESS;
        
        UT_TRACE.TRACE('FIN Ge_BoReportProcess.ExeRecordProcessByThrd',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR  THEN
            UT_TRACE.TRACE(' ERROR -> CONTROLLED_ERROR',12);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE(' ERROR -> Others',12);
            RAISE EX.CONTROLLED_ERROR;
    END EXERECORDPROCESSBYTHRD;


    

































    PROCEDURE DUMPXMLDATATOTABLEPL
    (
        ICLDATAXML              IN  CLOB,
        ITBPARAMECOLUMDESCRP    IN  UT_STRING.TYTB_STRPARAMETERS,
        OTBDATATOPROCESS        OUT UT_STRING.TYTB_STRING
    )
    IS
        
        RFDATAXML       CONSTANTS.TYREFCURSOR;
        NUINDEX         NUMBER;
        SBNAMECOLUMN    VARCHAR2(50);
        SBSEPARATOR     VARCHAR2(1);
    BEGIN
        
        UT_TRACE.TRACE('[INICIO] - GE_BoReportProcess.DumpXMLDataToTablePL',11);

        UT_CLOB.CLEAR('sbStatement');
        
        UT_CLOB.ADDVARCHAR2('sbStatement','BEGIN '||GE_BOCONSTANTS.CSBENTER||'OPEN :cuCursor FOR '||GE_BOCONSTANTS.CSBENTER||'SELECT ');

        NUINDEX := ITBPARAMECOLUMDESCRP.FIRST;
        LOOP
            SBNAMECOLUMN := ITBPARAMECOLUMDESCRP(NUINDEX).SBPARAMETER;

            UT_CLOB.ADDVARCHAR2('sbStatement',GE_BOCONSTANTS.CSBQUOTE||SBSEPARATOR||SBNAMECOLUMN||
                            GE_BOCONSTANTS.CSBEQUAL||GE_BOCONSTANTS.CSBQUOTE||GE_BOCONSTANTS.CSBPIPEDOUBLE||
                            'replace(replace(replace(miTabla'||GE_BOCONSTANTS.CSBDOT||'EXTRACT'||GE_BOCONSTANTS.CSBPARENTHESESOPEN||
                            GE_BOCONSTANTS.CSBQUOTE||'RECORDS'||GE_BOCONSTANTS.CSBSLASH||SBNAMECOLUMN||
                            GE_BOCONSTANTS.CSBSLASH||'text()'||GE_BOCONSTANTS.CSBQUOTE||
                            GE_BOCONSTANTS.CSBPARENTHESESCLOSE||GE_BOCONSTANTS.CSBDOT||'getstringval(),''%'',''%37%''),''|'',''%124%''),''='',''%61%'')');
                            
            IF (NUINDEX != ITBPARAMECOLUMDESCRP.LAST) THEN
                UT_CLOB.ADDVARCHAR2('sbStatement',GE_BOCONSTANTS.CSBPIPEDOUBLE||GE_BOCONSTANTS.CSBENTER);
            ELSE
                UT_CLOB.ADDVARCHAR2('sbStatement',' AS cadena '||GE_BOCONSTANTS.CSBENTER);
            END IF;
            
            
            IF SBSEPARATOR IS NULL THEN
                SBSEPARATOR := GE_BOCONSTANTS.CSBPIPE;
            END IF;
                            
            NUINDEX := ITBPARAMECOLUMDESCRP.NEXT(NUINDEX);
            EXIT WHEN NUINDEX IS NULL;
        END LOOP;
        
        UT_CLOB.ADDVARCHAR2('sbStatement','FROM TABLE (XMLSEQUENCE (EXTRACT(XMLTYPE(:clXML),'||GE_BOCONSTANTS.CSBQUOTE||
                            '/DocumentElement/RECORDS'||GE_BOCONSTANTS.CSBQUOTE||'))) miTabla;'||CHR(10) ||'END;');
        
        

        EXECUTE IMMEDIATE TO_CHAR(UT_CLOB.FSBGETCLOBDATA('sbStatement')) USING RFDATAXML, ICLDATAXML;

        FETCH RFDATAXML BULK COLLECT INTO OTBDATATOPROCESS;
        CLOSE RFDATAXML;
        
        UT_CLOB.CLEAR('sbStatement');

        UT_TRACE.TRACE('[FIN] - GE_BoReportProcess.DumpXMLDataToTablePL',11);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR  THEN
            UT_TRACE.TRACE('[CONTROLLED_ERROR] - GE_BoReportProcess.DumpXMLDataToTablePL',12);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('[OTHERS] - GE_BoReportProcess.DumpXMLDataToTablePL',12);
            RAISE EX.CONTROLLED_ERROR;
    END DUMPXMLDATATOTABLEPL;
    

    

































    PROCEDURE REGRECORDARGUMENTS
    (
        INUCTRLPROCESID         IN GE_CONTROL_PROCESS.CONTROL_PROCESS_ID%TYPE,
        ITBDATATOPROCESS        IN UT_STRING.TYTB_STRING,
        ITBPARAMEMATCHFIELPAR   IN UT_STRING.TYTB_STRPARAMETERS,
        ITBPARAMEPARAMDESCRP    IN UT_STRING.TYTB_STRPARAMETERS,
        ITBPARAMECOLUMDESCRP    IN UT_STRING.TYTB_STRPARAMETERS,
        ITBDATATYPEPARAME       IN UT_STRING.TYTB_STRPARAMETERS,
        IONUSEQUENCE            IN OUT GE_RECORD_PROCESS.SEQUENCE%TYPE
    )
    IS
        
        RCRECORDPROCESS         DAGE_RECORD_PROCESS.STYGE_RECORD_PROCESS;

        TBDATACOLUMN            UT_STRING.TYTB_STRPARAMETERS;
        NUINDEXDATA             NUMBER;
        NUINDEXAUX              NUMBER;

        NURECORDPROCESID        GE_RECORD_PROCESS.RECORD_PROCESS_ID%TYPE;

        NUINDEXMATCFIELPAR      NUMBER;
        SBCOLUMNAME             VARCHAR2(30);
        SBVALUEARGM             VARCHAR2(4000);
        SBARGUMENTS             VARCHAR2(32767);
        SBARGUMENTS_PLAIN       VARCHAR2(32767);
        SBCOLUMNDESCRP          VARCHAR2(200);
        
        SBAUXPARAMNAME          VARCHAR2(400);
        SBAUXPARAMVALUE         VARCHAR2(4000);
        SBAUXTYPEPARAM          VARCHAR2(400);

    BEGIN
        
        UT_TRACE.TRACE('[INICIO] - GE_BoReportProcess.regRecordArguments',10);
        
        NUINDEXDATA := ITBDATATOPROCESS.FIRST;
        LOOP
            
            
            
            UT_STRING.EXTPARAMETERS
            (
                ITBDATATOPROCESS(NUINDEXDATA),
                GE_BOCONSTANTS.CSBDELIMITERBLOCKS,
                GE_BOCONSTANTS.CSBEQUAL,
                TBDATACOLUMN,
                UT_STRING.FNUHASH_PARAMETER
            );

            SBARGUMENTS := NULL;
            SBARGUMENTS_PLAIN := NULL;
            NUINDEXMATCFIELPAR := ITBPARAMEMATCHFIELPAR.FIRST;
            
            LOOP
                SBCOLUMNAME := NULL;
                SBCOLUMNDESCRP := NULL;
                SBVALUEARGM := GE_BOCONSTANTS.CSBNULL_PLSQL;

                SBAUXPARAMNAME   := ITBPARAMEMATCHFIELPAR(NUINDEXMATCFIELPAR).SBPARAMETER;
                SBAUXPARAMVALUE  := ITBPARAMEMATCHFIELPAR(NUINDEXMATCFIELPAR).SBVALUE;
                SBAUXTYPEPARAM   := ITBDATATYPEPARAME(NUINDEXMATCFIELPAR).SBVALUE;

                
                
                IF (SBAUXPARAMVALUE != GE_BOCONSTANTS.CSBNULL_PLSQL) THEN

                    
                    
                    NUINDEXAUX := UT_STRING.FNUGETHASH_STRING
                                  (
                                    UT_STRING.FNUHASH_PARAMETER,
                                    NULL,
                                    SBAUXPARAMVALUE 
                                  );
                    
                    IF ( TBDATACOLUMN.EXISTS(NUINDEXAUX)) THEN
                        SBCOLUMNAME     := TBDATACOLUMN(NUINDEXAUX).SBPARAMETER;
                        SBCOLUMNDESCRP  := ITBPARAMECOLUMDESCRP(NUINDEXAUX).SBVALUE;
                        IF (SBAUXTYPEPARAM = GE_BOOBJECT.CSBVARCHAR2) THEN
                            SBVALUEARGM := REPLACE(REPLACE(REPLACE(TBDATACOLUMN(NUINDEXAUX).SBVALUE,'%61%','='),'%124%','|'),'%37%','%');
                        ELSE
                            SBVALUEARGM := TBDATACOLUMN(NUINDEXAUX).SBVALUE;
                        END IF;
                    ELSE
                        
                        SBVALUEARGM := SBAUXPARAMVALUE;
                        SBVALUEARGM := SUBSTR(SBVALUEARGM,2);
                        IF (SBAUXTYPEPARAM = GE_BOOBJECT.CSBVARCHAR2) THEN
                            SBVALUEARGM := REPLACE(REPLACE(REPLACE(SBVALUEARGM,'%61%','='),'%124%','|'),'%37%','%');
                        END IF;
                    END IF;
                    
                END IF;

                
                IF ( SBARGUMENTS IS NULL) THEN
                    SBARGUMENTS :=  SBARGUMENTS || SBAUXPARAMNAME || GE_BOCONSTANTS.CSBPARAM_ASING;
                    SBARGUMENTS_PLAIN := SBARGUMENTS_PLAIN || SBAUXPARAMNAME || GE_BOCONSTANTS.CSBEQUAL;
                ELSE
                    SBARGUMENTS :=  SBARGUMENTS || GE_BOCONSTANTS.CSBCOLON || SBAUXPARAMNAME || GE_BOCONSTANTS.CSBPARAM_ASING;
                    SBARGUMENTS_PLAIN :=  SBARGUMENTS_PLAIN || GE_BOCONSTANTS.CSBPIPE || SBAUXPARAMNAME || GE_BOCONSTANTS.CSBEQUAL;
                END IF;

                IF (SBAUXTYPEPARAM = GE_BOOBJECT.CSBVARCHAR2) THEN
                    IF ( SBVALUEARGM != GE_BOCONSTANTS.CSBNULL_PLSQL ) THEN
                        SBARGUMENTS :=  SBARGUMENTS || CHR(39) || SBVALUEARGM || CHR(39);
                        SBARGUMENTS_PLAIN := SBARGUMENTS_PLAIN || REPLACE(REPLACE(REPLACE(SBVALUEARGM,'%','%37%'),'|','%124%'),'=','%61%');
                    ELSE
                       SBARGUMENTS :=  SBARGUMENTS || SBVALUEARGM;
                       SBARGUMENTS_PLAIN := SBARGUMENTS_PLAIN || SBVALUEARGM;
                    END IF;
                ELSIF (SBAUXTYPEPARAM = GE_BOOBJECT.CSBDATE) THEN
                    
                    IF ( SBVALUEARGM != GE_BOCONSTANTS.CSBNULL_PLSQL ) THEN
                        SBARGUMENTS :=  SBARGUMENTS || 'to_date('||CHR(39)|| SBVALUEARGM || CHR(39)||', ut_date.fsbDATE_FORMAT)';
                    ELSE
                        SBARGUMENTS :=  SBARGUMENTS || SBVALUEARGM;
                    END IF;

                    SBARGUMENTS_PLAIN := SBARGUMENTS_PLAIN || SBVALUEARGM;
                ELSE
                    SBARGUMENTS :=  SBARGUMENTS || SBVALUEARGM;
                    SBARGUMENTS_PLAIN := SBARGUMENTS_PLAIN || SBVALUEARGM;
                END IF;

                
                NUINDEXMATCFIELPAR := ITBPARAMEMATCHFIELPAR.NEXT(NUINDEXMATCFIELPAR);
                EXIT WHEN NUINDEXMATCFIELPAR IS NULL;
            END LOOP;


            
            IONUSEQUENCE := IONUSEQUENCE + 1;
            
            NURECORDPROCESID := GE_BOSEQUENCE.FNUNEXTGE_RECORD_PROCESS;
            RCRECORDPROCESS.RECORD_PROCESS_ID   := NURECORDPROCESID;
            RCRECORDPROCESS.CONTROL_PROCESS_ID  := INUCTRLPROCESID;
            RCRECORDPROCESS.SEQUENCE            := IONUSEQUENCE;
            RCRECORDPROCESS.STATUS              := GE_BOCONSTANTS.CSBREG2PROC_STAT_PEND;
            RCRECORDPROCESS.ARGUMENTS           := SBARGUMENTS;
            RCRECORDPROCESS.ARGUMENTS_PLAIN     := SBARGUMENTS_PLAIN;

            
            
            DAGE_RECORD_PROCESS.INSRECORD(RCRECORDPROCESS);
            

            NUINDEXDATA := ITBDATATOPROCESS.NEXT(NUINDEXDATA);
            EXIT WHEN NUINDEXDATA IS NULL;
         END LOOP;

        UT_TRACE.TRACE('[FIN] - GE_BoReportProcess.regRecordArguments',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR  THEN
            UT_TRACE.TRACE('[CONTROLLED_ERROR] - GE_BoReportProcess.regRecordArguments',12);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('[OTHERS] - GE_BoReportProcess.regRecordArguments',12);
            RAISE EX.CONTROLLED_ERROR;
    END REGRECORDARGUMENTS;
    
    





















    PROCEDURE GETDATATYPEOFPARAM
    (
        INUOBJECTID         IN  GE_OBJECT.OBJECT_ID%TYPE,
        OTBDATATYPEPARAME   OUT UT_STRING.TYTB_STRPARAMETERS
    )
    IS
        
        RCGEOBJECT              DAGE_OBJECT.STYGE_OBJECT;
        NUINDEXAUX              NUMBER;
        
        TBDATATYPEPARA          UT_STRING.TYTB_STRPARAMETERS;
    BEGIN
        
        UT_TRACE.TRACE('INICIO GE_BoReportProcess.getDataTypeOfParam',9);
        
        DAGE_OBJECT.GETRECORD(INUOBJECTID,RCGEOBJECT);

        
        IF GE_BCOBJECTPARAMETER.CUDATATYPEPARAM%ISOPEN THEN
            CLOSE GE_BCOBJECTPARAMETER.CUDATATYPEPARAM;
        END IF;

        FOR RCOBJEPARAM IN GE_BCOBJECTPARAMETER.CUDATATYPEPARAM(UPPER(RCGEOBJECT.NAME_)) LOOP
            NUINDEXAUX := UT_STRING.FNUGETHASH_STRING
                            (
                                UT_STRING.FNUHASH_PARAMETER,
                                NULL,
                                RCOBJEPARAM.PARAMETER_NAME
                            );
            TBDATATYPEPARA(NUINDEXAUX).SBPARAMETER := RCOBJEPARAM.PARAMETER_NAME;
            TBDATATYPEPARA(NUINDEXAUX).SBVALUE := RCOBJEPARAM.DATA_TYPE;
        END LOOP;
        
        OTBDATATYPEPARAME := TBDATATYPEPARA;

        UT_TRACE.TRACE('FIN GE_BoReportProcess.getDataTypeOfParam',9);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR  THEN
            UT_TRACE.TRACE('[CONTROLLED_ERROR] - GE_BoReportProcess.getDataTypeOfParam',12);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('[OTHERS] - GE_BoReportProcess.getDataTypeOfParam',12);
            RAISE EX.CONTROLLED_ERROR;
    END GETDATATYPEOFPARAM;
    

    


























    PROCEDURE GETDATATYPEOFCOLUMN
    (
        ITBPARAMEMATCHFIELPAR   IN  UT_STRING.TYTB_STRPARAMETERS,
        ITBDATATYPEPARAME       IN  UT_STRING.TYTB_STRPARAMETERS,
        ITBPARAMECOLUMDESCRP    IN  UT_STRING.TYTB_STRPARAMETERS,
        OTBDATATYPECOLUMN       OUT UT_STRING.TYTB_STRPARAMETERS
    )
    IS
        
        NUINDEXPARAM            NUMBER;
        SBAUXPARAMVALUE         VARCHAR2(4000);
        NUINDEXAUX              NUMBER;
    BEGIN
        
        UT_TRACE.TRACE('INICIO - GE_BoReportProcess.getDataTypeOfColumn',5);

        
        
        IF ITBPARAMEMATCHFIELPAR.COUNT > 0 THEN
            NUINDEXPARAM := ITBPARAMEMATCHFIELPAR.FIRST;
            LOOP
                SBAUXPARAMVALUE := ITBPARAMEMATCHFIELPAR(NUINDEXPARAM).SBVALUE;
                
                IF (SBAUXPARAMVALUE != GE_BOCONSTANTS.CSBNULL_PLSQL AND SUBSTR(SBAUXPARAMVALUE,1,1) != '\') THEN
                    
                    
                    NUINDEXAUX := UT_STRING.FNUGETHASH_STRING
                                  (
                                    UT_STRING.FNUHASH_PARAMETER,
                                    NULL,
                                    SBAUXPARAMVALUE 
                                  );

                    
                    IF ( ITBPARAMECOLUMDESCRP.EXISTS(NUINDEXAUX) ) THEN
                        OTBDATATYPECOLUMN(NUINDEXAUX).SBPARAMETER := SBAUXPARAMVALUE;
                        OTBDATATYPECOLUMN(NUINDEXAUX).SBVALUE := ITBDATATYPEPARAME(NUINDEXPARAM).SBVALUE;
                    END IF;
                END IF;
                NUINDEXPARAM := ITBPARAMEMATCHFIELPAR.NEXT(NUINDEXPARAM);
                EXIT WHEN NUINDEXPARAM IS NULL;
            END LOOP;
        END IF;

        UT_TRACE.TRACE('FIN - GE_BoReportProcess.getDataTypeOfColumn',5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR  THEN
            UT_TRACE.TRACE('[CONTROLLED_ERROR] - GE_BoReportProcess.getDataTypeOfColumn',12);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('[OTHERS] - GE_BoReportProcess.getDataTypeOfColumn',12);
            RAISE EX.CONTROLLED_ERROR;
    END GETDATATYPEOFCOLUMN;


    



































    PROCEDURE REGISTERPROCFEWDATA
    (
        INUOBJECTID         IN  GE_CONTROL_PROCESS.OBJECT_ID%TYPE,
        ISBMATCHFIELDPARAM  IN  VARCHAR2,
        ISBSTRGCOLUMDESCRP  IN  VARCHAR2,
        ISBSTRGPARAMDESCRP  IN  VARCHAR2,
        ICLDATAXML          IN  CLOB,
        ONUCONTROLPROCESID  OUT GE_CONTROL_PROCESS.CONTROL_PROCESS_ID%TYPE
    )
    IS
        
        RCCONTRLPROCESS         DAGE_CONTROL_PROCESS.STYGE_CONTROL_PROCESS;

        NUCTRLPROCESID          GE_CONTROL_PROCESS.CONTROL_PROCESS_ID%TYPE;

        TBPARAMEMATCHFIELPAR    UT_STRING.TYTB_STRPARAMETERS;
        TBPARAMECOLUMDESCRP     UT_STRING.TYTB_STRPARAMETERS;
        TBPARAMEPARAMDESCRP     UT_STRING.TYTB_STRPARAMETERS;
        TBDATATYPEPARAME        UT_STRING.TYTB_STRPARAMETERS;

        
        TBDATATOPROCESS         UT_STRING.TYTB_STRING;
        NUCOUNTREG              NUMBER := 0; 

    BEGIN
        
        UT_TRACE.TRACE('INICIO Ge_BoReportProcess.registerProcFewData',8);
        
        
        
        
        NUCTRLPROCESID := GE_BOSEQUENCE.FNUNEXTGE_CONTROL_PROCESS;
        
        RCCONTRLPROCESS.CONTROL_PROCESS_ID  := NUCTRLPROCESID;
        RCCONTRLPROCESS.USER_ID             := SA_BOSYSTEM.GETSYSTEMUSERID;
        RCCONTRLPROCESS.OBJECT_ID           := INUOBJECTID;
        RCCONTRLPROCESS.STATUS              := GE_BOCONSTANTS.CSBCTRL2PROC_STAT_REG;
        RCCONTRLPROCESS.ADVANCE             := 0;
        RCCONTRLPROCESS.TOTAL_RECORD_PROC   := 0;
        RCCONTRLPROCESS.AMOUNT_RECORD_PROC  := 0;
        RCCONTRLPROCESS.RECORD_INITIAL_DATE := UT_DATE.FDTSYSDATE;
        RCCONTRLPROCESS.MATCH_PARAM_COLUM   := ISBMATCHFIELDPARAM;
        RCCONTRLPROCESS.STR_COLUMN_DESCRIP  := ISBSTRGCOLUMDESCRP;
        RCCONTRLPROCESS.STR_PARAM_DESCRIP   := ISBSTRGPARAMDESCRP;
        DAGE_CONTROL_PROCESS.INSRECORD(RCCONTRLPROCESS);
        
        ONUCONTROLPROCESID := NUCTRLPROCESID;
        
        
        UT_STRING.EXTPARAMETERS
        (
            ISBMATCHFIELDPARAM,
            GE_BOCONSTANTS.CSBDELIMITERBLOCKS,
            GE_BOCONSTANTS.CSBEQUAL,
            TBPARAMEMATCHFIELPAR,
            UT_STRING.FNUHASH_PARAMETER
        );

        
        UT_STRING.EXTPARAMETERS
        (
            ISBSTRGPARAMDESCRP,
            GE_BOCONSTANTS.CSBDELIMITERBLOCKS,
            GE_BOCONSTANTS.CSBEQUAL,
            TBPARAMEPARAMDESCRP,
            UT_STRING.FNUHASH_PARAMETER
        );

        
        UT_STRING.EXTPARAMETERS
        (
            ISBSTRGCOLUMDESCRP,
            GE_BOCONSTANTS.CSBDELIMITERBLOCKS,
            GE_BOCONSTANTS.CSBEQUAL,
            TBPARAMECOLUMDESCRP,
            UT_STRING.FNUHASH_PARAMETER
        );

        
        
        DUMPXMLDATATOTABLEPL
        (
            ICLDATAXML,
            TBPARAMECOLUMDESCRP,
            TBDATATOPROCESS
        );
        
        
        
        GETDATATYPEOFPARAM(INUOBJECTID,TBDATATYPEPARAME);
        
        
        REGRECORDARGUMENTS
        (
            NUCTRLPROCESID,
            TBDATATOPROCESS,
            TBPARAMEMATCHFIELPAR,
            TBPARAMEPARAMDESCRP,
            TBPARAMECOLUMDESCRP,
            TBDATATYPEPARAME,
            NUCOUNTREG
        );

        
        GE_BCCONTROLPROCESS.UPDRECFINDATETOTALREC
        (
            NUCTRLPROCESID,
            UT_DATE.FDTSYSDATE,
            NUCOUNTREG
        );

        UT_TRACE.TRACE('FIN Ge_BoReportProcess.registerProcFewData',8);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR  THEN
            UT_TRACE.TRACE('[CONTROLLED_ERROR] - Ge_BoReportProcess.registerProcFewData',12);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('[Others] - Ge_BoReportProcess.registerProcFewData',12);
            RAISE EX.CONTROLLED_ERROR;
    END REGISTERPROCFEWDATA;


    





































    PROCEDURE REGISTERPROCMANYDATA
    (
        INUOBJECTID         IN  GE_CONTROL_PROCESS.OBJECT_ID%TYPE,
        ISBMATCHFIELDPARAM  IN  VARCHAR2,
        ISBSTRGCOLUMDESCRP  IN  VARCHAR2,
        ISBSTRGPARAMDESCRP  IN  VARCHAR2,
        ISBSENTENCESQL      IN  GE_CONTROL_PROCESS.SENTENCE_SQL%TYPE,
        ONUCONTROLPROCESID  OUT GE_CONTROL_PROCESS.CONTROL_PROCESS_ID%TYPE
    )
    IS
        
        RCCONTRLPROCESS         DAGE_CONTROL_PROCESS.STYGE_CONTROL_PROCESS;
        
        NUCTRLPROCESID          GE_CONTROL_PROCESS.CONTROL_PROCESS_ID%TYPE;
    BEGIN
        
        UT_TRACE.TRACE('INICIO - Ge_BoReportProcess.registerProcManyData',8);

        
        
        
        
        
        NUCTRLPROCESID := GE_BOSEQUENCE.FNUNEXTGE_CONTROL_PROCESS;

        RCCONTRLPROCESS.CONTROL_PROCESS_ID  := NUCTRLPROCESID;
        RCCONTRLPROCESS.USER_ID             := SA_BOSYSTEM.GETSYSTEMUSERID;
        RCCONTRLPROCESS.OBJECT_ID           := INUOBJECTID;
        RCCONTRLPROCESS.STATUS              := GE_BOCONSTANTS.CSBCTRL2PROC_STAT_REG;
        RCCONTRLPROCESS.ADVANCE             := 0;
        RCCONTRLPROCESS.TOTAL_RECORD_PROC   := 0;
        RCCONTRLPROCESS.AMOUNT_RECORD_PROC  := 0;
        RCCONTRLPROCESS.RECORD_INITIAL_DATE := UT_DATE.FDTSYSDATE;
        RCCONTRLPROCESS.MATCH_PARAM_COLUM   := ISBMATCHFIELDPARAM;
        RCCONTRLPROCESS.STR_COLUMN_DESCRIP  := ISBSTRGCOLUMDESCRP;
        RCCONTRLPROCESS.STR_PARAM_DESCRIP   := ISBSTRGPARAMDESCRP;
        RCCONTRLPROCESS.SENTENCE_SQL        := ISBSENTENCESQL;
        DAGE_CONTROL_PROCESS.INSRECORD(RCCONTRLPROCESS);
        
        ONUCONTROLPROCESID := NUCTRLPROCESID;

        UT_TRACE.TRACE('FIN - Ge_BoReportProcess.registerProcManyData',8);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR  THEN
            UT_TRACE.TRACE('[CONTROLLED_ERROR] - Ge_BoReportProcess.registerProcManyData',12);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('[OTHERS] - Ge_BoReportProcess.registerProcManyData',12);
            RAISE EX.CONTROLLED_ERROR;
    END REGISTERPROCMANYDATA;
    

    


























    PROCEDURE EXECUTESQLDATA
    (
        ISBSETENCESQL           IN  GE_CONTROL_PROCESS.SENTENCE_SQL%TYPE,
        ITBPARAMECOLUMDESCRP    IN  UT_STRING.TYTB_STRPARAMETERS,
        ITBDATATYPECOLUMN       IN  UT_STRING.TYTB_STRPARAMETERS,
        ORFDATASQL              OUT CONSTANTS.TYREFCURSOR
    )
    IS
        
        NUINDEX         NUMBER;
        SBNAMECOLUMN    VARCHAR2(50);
        SBSEPARATOR     VARCHAR2(1);
        
        RFMIDATASQL     CONSTANTS.TYREFCURSOR;
        
        NUINDEXAUX      NUMBER;

    BEGIN
        
        UT_TRACE.TRACE('INICIO - Ge_BoReportProcess.executeSQLData',9);

        UT_CLOB.CLEAR('sbStatement');

        UT_CLOB.ADDVARCHAR2('sbStatement','BEGIN '||GE_BOCONSTANTS.CSBENTER||
                            'OPEN :cuCursor FOR '||GE_BOCONSTANTS.CSBENTER||'SELECT ');
        NUINDEX := ITBPARAMECOLUMDESCRP.FIRST;
        LOOP
            SBNAMECOLUMN := ITBPARAMECOLUMDESCRP(NUINDEX).SBPARAMETER;

            UT_CLOB.ADDVARCHAR2('sbStatement',GE_BOCONSTANTS.CSBQUOTE||SBSEPARATOR||SBNAMECOLUMN||
                            GE_BOCONSTANTS.CSBEQUAL||GE_BOCONSTANTS.CSBQUOTE||GE_BOCONSTANTS.CSBPIPEDOUBLE);
                            
            NUINDEXAUX := UT_STRING.FNUGETHASH_STRING
                                  (
                                    UT_STRING.FNUHASH_PARAMETER,
                                    NULL,
                                    SBNAMECOLUMN 
                                  );

            
            IF (  ITBDATATYPECOLUMN.EXISTS(NUINDEXAUX) ) THEN
                IF (ITBDATATYPECOLUMN(NUINDEXAUX).SBVALUE = GE_BOOBJECT.CSBDATE ) THEN
                    UT_CLOB.ADDVARCHAR2('sbStatement','to_char('||SBNAMECOLUMN||',ut_date.fsbDATE_FORMAT)');
                ELSIF (ITBDATATYPECOLUMN(NUINDEXAUX).SBVALUE = GE_BOOBJECT.CSBVARCHAR2 ) THEN
                    UT_CLOB.ADDVARCHAR2('sbStatement','replace(replace(replace('||SBNAMECOLUMN||',''%'',''%37%''),''|'',''%124%''),''='',''%61%'')');
                ELSE
                    UT_CLOB.ADDVARCHAR2('sbStatement',SBNAMECOLUMN);
                END IF;
            ELSE
                
                UT_CLOB.ADDVARCHAR2('sbStatement',SBNAMECOLUMN);
            END IF;

            IF (NUINDEX != ITBPARAMECOLUMDESCRP.LAST) THEN
                UT_CLOB.ADDVARCHAR2('sbStatement',GE_BOCONSTANTS.CSBPIPEDOUBLE||GE_BOCONSTANTS.CSBENTER);
            ELSE
                UT_CLOB.ADDVARCHAR2('sbStatement',' AS datosfila '||GE_BOCONSTANTS.CSBENTER);
            END IF;

            
            IF SBSEPARATOR IS NULL THEN
                SBSEPARATOR := GE_BOCONSTANTS.CSBPIPE;
            END IF;

            NUINDEX := ITBPARAMECOLUMDESCRP.NEXT(NUINDEX);
            EXIT WHEN NUINDEX IS NULL;
        END LOOP;
        

        UT_CLOB.ADDVARCHAR2('sbStatement','FROM ' ||
                        GE_BOCONSTANTS.CSBPARENTHESESOPEN||GE_BOCONSTANTS.CSBENTER||
                        ISBSETENCESQL || GE_BOCONSTANTS.CSBENTER||
                        GE_BOCONSTANTS.CSBPARENTHESESCLOSE|| GE_BOCONSTANTS.CSBSEMICOLON||
                        GE_BOCONSTANTS.CSBENTER||'END;');


        EXECUTE IMMEDIATE TO_CHAR(UT_CLOB.FSBGETCLOBDATA('sbStatement')) USING RFMIDATASQL;

        ORFDATASQL := RFMIDATASQL;

        UT_TRACE.TRACE('FIN - Ge_BoRepotProcess.executeSQLData',9);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR  THEN
            UT_TRACE.TRACE('[CONTROLLED_ERROR] - Ge_BoReportProcess.executeSQLData',12);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('[OTHERS] - Ge_BoReportProcess.executeSQLData',12);
            RAISE EX.CONTROLLED_ERROR;
    END EXECUTESQLDATA;
    

    























    PROCEDURE REGISTERDATAFROMPROC
    (
        INUCONTROLPROCESID  IN  GE_CONTROL_PROCESS.CONTROL_PROCESS_ID%TYPE
    )
    IS
        
        RCCONTRLPROCESS         DAGE_CONTROL_PROCESS.STYGE_CONTROL_PROCESS;

        TBPARAMEMATCHFIELPAR    UT_STRING.TYTB_STRPARAMETERS;
        TBPARAMECOLUMDESCRP     UT_STRING.TYTB_STRPARAMETERS;
        TBPARAMEPARAMDESCRP     UT_STRING.TYTB_STRPARAMETERS;

        TBDATATYPEPARAME        UT_STRING.TYTB_STRPARAMETERS;
        TBDATATYPECOLUMN        UT_STRING.TYTB_STRPARAMETERS;

        
        RFDATASQL               CONSTANTS.TYREFCURSOR;
        TBDATATOPROCESS         UT_STRING.TYTB_STRING;
        NUCOUNTREG              NUMBER := 0; 
        
        NULIMIT_PROCESS         NUMBER := 100;
        
    BEGIN
        
        UT_TRACE.TRACE('INICIO - Ge_BoReportProcess.registerDataFromProC',8);
        
        DAGE_CONTROL_PROCESS.GETRECORD(INUCONTROLPROCESID,RCCONTRLPROCESS);
        
        
        UT_STRING.EXTPARAMETERS
        (
            RCCONTRLPROCESS.MATCH_PARAM_COLUM,
            GE_BOCONSTANTS.CSBDELIMITERBLOCKS,
            GE_BOCONSTANTS.CSBEQUAL,
            TBPARAMEMATCHFIELPAR,
            UT_STRING.FNUHASH_PARAMETER
        );

        
        UT_STRING.EXTPARAMETERS
        (
            RCCONTRLPROCESS.STR_PARAM_DESCRIP,
            GE_BOCONSTANTS.CSBDELIMITERBLOCKS,
            GE_BOCONSTANTS.CSBEQUAL,
            TBPARAMEPARAMDESCRP,
            UT_STRING.FNUHASH_PARAMETER
        );

        
        UT_STRING.EXTPARAMETERS
        (
            RCCONTRLPROCESS.STR_COLUMN_DESCRIP,
            GE_BOCONSTANTS.CSBDELIMITERBLOCKS,
            GE_BOCONSTANTS.CSBEQUAL,
            TBPARAMECOLUMDESCRP,
            UT_STRING.FNUHASH_PARAMETER
        );
        
        
        
        GETDATATYPEOFPARAM(RCCONTRLPROCESS.OBJECT_ID,TBDATATYPEPARAME);

        
        
        GETDATATYPEOFCOLUMN
        (
            TBPARAMEMATCHFIELPAR,
            TBDATATYPEPARAME,
            TBPARAMECOLUMDESCRP,
            TBDATATYPECOLUMN
        );

        
        
        EXECUTESQLDATA
        (
            RCCONTRLPROCESS.SENTENCE_SQL,
            TBPARAMECOLUMDESCRP,
            TBDATATYPECOLUMN,
            RFDATASQL
        );


        LOOP
            FETCH RFDATASQL BULK COLLECT INTO TBDATATOPROCESS LIMIT NULIMIT_PROCESS;
            EXIT WHEN TBDATATOPROCESS.COUNT = 0;

            
            REGRECORDARGUMENTS
            (
                INUCONTROLPROCESID,
                TBDATATOPROCESS,
                TBPARAMEMATCHFIELPAR,
                TBPARAMEPARAMDESCRP,
                TBPARAMECOLUMDESCRP,
                TBDATATYPEPARAME,
                NUCOUNTREG
            );
            
            COMMIT;
        END LOOP;
        
        CLOSE RFDATASQL;

        
        GE_BCCONTROLPROCESS.UPDRECFINDATETOTALREC
        (
            INUCONTROLPROCESID,
            UT_DATE.FDTSYSDATE,
            NUCOUNTREG
        );

        COMMIT;

        UT_TRACE.TRACE('FIN - Ge_BoReportProcess.registerDataFromProC',8);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR  THEN
            UT_TRACE.TRACE('[CONTROLLED_ERROR] - Ge_BoReportProcess.registerDataFromProC',12);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('[OTHERS] - Ge_BoReportProcess.registerDataFromProC',12);
            RAISE EX.CONTROLLED_ERROR;
    END REGISTERDATAFROMPROC;
    


    

























    PROCEDURE EXECUTEOBJECT
    (
        INUCONTROLPROCESID  IN GE_CONTROL_PROCESS.CONTROL_PROCESS_ID%TYPE,
        ISBMODEPROCESS      IN  VARCHAR2
    )
    IS
        
        NUTOTALHILOS        NUMBER;

        SBCOMANDO           VARCHAR2(2000);
        SBTRACEPATH         VARCHAR2(100);
        SBTRACENAME         VARCHAR2(100);
        
        SBCONNECTIONSTRING  VARCHAR2(300);
        SBUSER              VARCHAR2(30);
        SBPASSWORD          VARCHAR2(100);
        SBINSTANCE          VARCHAR2(100);
    BEGIN
        
        UT_TRACE.TRACE('INICIO Ge_BoReportProcess.executeObject',8);

        
        
        NUTOTALHILOS := PKGENERALPARAMETERSMGR.FNUGETNUMBERVALUE('BIL_TRHEADS');
        SBTRACEPATH  := NVL(PKGENERALPARAMETERSMGR.FSBGETSTRINGVALUE ('RUTA_TRAZA'), '/tmp') ;
        SBTRACEPATH  := RTRIM (LTRIM (SBTRACEPATH)) ;

        
        GE_BODATABASECONNECTION.GETCONNECTIONSTRING(SBUSER, SBPASSWORD, SBINSTANCE);
        SBCONNECTIONSTRING := SBUSER || '/' || SBPASSWORD || '@' || SBINSTANCE;
        
        
        
        SBTRACENAME		:= CSBREPORT_PROCESS|| '_' || SBUSER || '_'  ||
                            TO_CHAR(SYSDATE,'ddmmyyyy_HH24MISS') || '.log';
                       
        
        SBCOMANDO   :=  CSBREPORT_PROCESS   || ' '  ||      
                        SBCONNECTIONSTRING  || ' '  ||      
                        NUTOTALHILOS        || ' '  ||      
                        INUCONTROLPROCESID  || ' '  ||      
                        ISBMODEPROCESS      || ' > '||      
                        SBTRACEPATH   || '/'  || SBTRACENAME ||' 2>'||CHR(38)||'1 '||CHR(38);

        UT_TRACE.TRACE('Instancia:'|| SBINSTANCE, 5);
        UT_TRACE.TRACE('Ruta_Log:'||SBTRACEPATH || '/' ||SBTRACENAME, 5);

        
        
        
        UT_TRACE.TRACE('-- Pasando a PRO C --',5);
        LLAMASIST(SBCOMANDO);
        
        

        UT_TRACE.TRACE('FIN Ge_BoReportProcess.executeObject',8);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR  THEN
            UT_TRACE.TRACE('[CONTROLLED_ERROR] - Ge_BoReportProcess.executeObject',10);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('[OTHERS] - Ge_BoReportProcess.executeObject',10);
            RAISE EX.CONTROLLED_ERROR;
    END EXECUTEOBJECT;


END GE_BOREPORTPROCESS;