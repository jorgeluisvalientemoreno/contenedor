
Unwrap More Code

PACKAGE BODY MO_BOWF_PACK_INTERFAC AS
    
    
    
    
    CSBVERSION  CONSTANT VARCHAR2(250)  := 'SAO399636';
    
    GNUERRORCODE    GE_MESSAGE.MESSAGE_ID%TYPE;
    GSBERRORMESSAGE VARCHAR2(2000);

    
    
    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;


    



















    PROCEDURE INSTANCEDATA
        (
        IRCWFPACKINTERFAC   IN DAMO_WF_PACK_INTERFAC.STYMO_WF_PACK_INTERFAC
        )
    IS
    BEGIN
        
        GE_BOINSTANCE.INIT;
        
        GE_BOINSTANCE.SETVALUE
            (
            MO_BOCONSTANTS.CSBMO_PACKAGES,
            MO_BOCONSTANTS.CSBPACKAGE_ID,
            IRCWFPACKINTERFAC.PACKAGE_ID,
            GE_BOCONSTANTS.CNUNUMBER
            );
        
        GE_BOINSTANCE.SETVALUE
            (
            MO_BOCONSTANTS.CSBMO_WF_PACK_INTERFAC,
            MO_BOCONSTANTS.CSBACTIVITY_ID,
            IRCWFPACKINTERFAC.ACTIVITY_ID,
            GE_BOCONSTANTS.CNUNUMBER
            );
        
        GE_BOINSTANCE.SETVALUE
            (
            MO_BOCONSTANTS.CSBMO_WF_PACK_INTERFAC,
            MO_BOCONSTANTS.CSBCAUSAL_ID_INPUT,
            IRCWFPACKINTERFAC.CAUSAL_ID_INPUT,
            GE_BOCONSTANTS.CNUNUMBER
            );
        
        GE_BOINSTANCE.SETVALUE
            (
            MO_BOCONSTANTS.CSBMO_WF_PACK_INTERFAC,
            MO_BOCONSTANTS.CSBPREVIOUS_ACTIVITY_ID,
            IRCWFPACKINTERFAC.PREVIOUS_ACTIVITY_ID,
            GE_BOCONSTANTS.CNUNUMBER
            );
        
        GE_BOINSTANCE.SETVALUE
            (
            MO_BOCONSTANTS.CSBMO_WF_PACK_INTERFAC,
            MO_BOCONSTANTS.CSBUNDO_ACTIVITY_ID,
            IRCWFPACKINTERFAC.UNDO_ACTIVITY_ID,
            GE_BOCONSTANTS.CNUNUMBER
            );
        
        GE_BOINSTANCE.SETVALUE
            (
            MO_BOCONSTANTS.CSBMO_WF_PACK_INTERFAC,
            'WF_PACK_INTERFAC_ID',
            IRCWFPACKINTERFAC.WF_PACK_INTERFAC_ID,
            GE_BOCONSTANTS.CNUNUMBER
            );
        
        GE_BOINSTANCE.SETVALUE
            (
            MO_BOCONSTANTS.CSBMO_WF_PACK_INTERFAC,
            MO_BOCONSTANTS.CSBACTION_ID,
            IRCWFPACKINTERFAC.ACTION_ID,
            GE_BOCONSTANTS.CNUNUMBER
            );
    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
            RAISE  EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			ERRORS.SETERROR;
            RAISE  EX.CONTROLLED_ERROR;
	END;


    















    PROCEDURE REPORTLOG
        (
        INUERRORCODE    IN NUMBER,
        ISBERRORMSG     IN VARCHAR2,
        ISBMESSAGE      IN VARCHAR2,
        ONUREPORLOGID   OUT NOCOPY NUMBER
        )
    IS
         PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        
        GE_BOEXECUTOR_LOG.INSERT_DEFAULT
            (
            INUERRORCODE,
            ISBERRORMSG,
            ISBMESSAGE,
            ONUREPORLOGID
            );
        COMMIT;
     EXCEPTION
        WHEN OTHERS THEN
             ROLLBACK;
             RAISE EX.CONTROLLED_ERROR;
     END;

    


























    PROCEDURE PROCESSERROR
        (
        IORCWFPACKINTERFAC  IN OUT DAMO_WF_PACK_INTERFAC.STYMO_WF_PACK_INTERFAC,
        INUERRORCODE        IN GE_MESSAGE.MESSAGE_ID%TYPE,
        ISBERRORMESSAGE     IN VARCHAR2,
        IBLINSERTREGISTER   IN BOOLEAN DEFAULT FALSE
        )
    IS
        NUREPORTLOGID   NUMBER(15);
    BEGIN
        UT_TRACE.TRACE('Inicia Proceso de Error:['||INUERRORCODE||']-['||SUBSTR(ISBERRORMESSAGE,1,2000)||']',3);

        
        REPORTLOG
            (
            INUERRORCODE,
            ISBERRORMESSAGE,
            MO_BOCONSTANTS.CSBPACKAGE_ID || '-' || IORCWFPACKINTERFAC.PACKAGE_ID,
            NUREPORTLOGID
            );
        IORCWFPACKINTERFAC.EXECUTOR_LOG_ID := NUREPORTLOGID;

        
        IF (NVL(INUERRORCODE,MO_BOCONSTANTS.CNUOK) <> MO_BOCONSTANTS.CNUOK) THEN

            
            IORCWFPACKINTERFAC.STATUS_ACTIVITY_ID := MO_BOSTATUSPARAMETER.FNUGETSTA_ACTIV_RESTART;

            
            IF (NVL(IORCWFPACKINTERFAC.TRY_AMOUNT,0) < 99) THEN
                
                IORCWFPACKINTERFAC.TRY_AMOUNT := IORCWFPACKINTERFAC.TRY_AMOUNT + 1;
            END IF;
        ELSE

            
            IF (MO_BOACTIONUTIL.FBLGETEXECACTIONINSTANDBY) THEN

                
                IORCWFPACKINTERFAC.STATUS_ACTIVITY_ID := MO_BOSTATUSPARAMETER.FNUGETSTA_ACTIV_STANDBY;
            ELSE

                
                IORCWFPACKINTERFAC.STATUS_ACTIVITY_ID := MO_BOSTATUSPARAMETER.FNUGETSTA_ACTIV_FINISH;

                
                IORCWFPACKINTERFAC.ATTENDANCE_DATE := SYSDATE;
            END IF;
        END IF;

        
        IF IBLINSERTREGISTER THEN

            DAMO_WF_PACK_INTERFAC.INSRECORD(IORCWFPACKINTERFAC);
        ELSE

            DAMO_WF_PACK_INTERFAC.UPDRECORD(IORCWFPACKINTERFAC);
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
			RAISE EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			RAISE EX.CONTROLLED_ERROR;
    END;


	PROCEDURE GETACTIVITYIDPACK
        (
        INUPACKAGEID        IN MO_PACKAGES.PACKAGE_ID%TYPE,
        INUACTIONID         IN GE_ACTION_MODULE.ACTION_ID%TYPE,
        INUSTATUSACTIVITYID IN MO_WF_PACK_INTERFAC.STATUS_ACTIVITY_ID%TYPE,
        ORCWFPACKINTERFAC   OUT NOCOPY DAMO_WF_PACK_INTERFAC.STYMO_WF_PACK_INTERFAC
        )
    IS
        RCWFPACKINTERFAC    DAMO_WF_PACK_INTERFAC.STYMO_WF_PACK_INTERFAC;
        EXACTPACKNOEXIST    EXCEPTION;
    BEGIN
        
        OPEN MO_BCWFPACKINTERFAC.CUWFPACKINTERFAC(INUPACKAGEID,INUACTIONID,INUSTATUSACTIVITYID);
        FETCH MO_BCWFPACKINTERFAC.CUWFPACKINTERFAC INTO RCWFPACKINTERFAC;
        IF (MO_BCWFPACKINTERFAC.CUWFPACKINTERFAC%NOTFOUND) THEN

            RAISE EXACTPACKNOEXIST;
        END IF;
        ORCWFPACKINTERFAC := RCWFPACKINTERFAC;
        CLOSE MO_BCWFPACKINTERFAC.CUWFPACKINTERFAC;
    EXCEPTION
        WHEN EXACTPACKNOEXIST THEN
            IF (MO_BCWFPACKINTERFAC.CUWFPACKINTERFAC%ISOPEN) THEN
                CLOSE MO_BCWFPACKINTERFAC.CUWFPACKINTERFAC;
            END IF;
            ERRORS.SETERROR
                (
                MO_BOCONSTERROR.CNUERRACTPACKNOEXIST,
                TO_CHAR(INUPACKAGEID) || '|' ||
                TO_CHAR(INUACTIONID) || '|' ||
                TO_CHAR(INUSTATUSACTIVITYID)
                );
            RAISE  EX.CONTROLLED_ERROR;
		WHEN EX.CONTROLLED_ERROR THEN
            IF (MO_BCWFPACKINTERFAC.CUWFPACKINTERFAC%ISOPEN) THEN
                CLOSE MO_BCWFPACKINTERFAC.CUWFPACKINTERFAC;
            END IF;
            RAISE  EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
            IF (MO_BCWFPACKINTERFAC.CUWFPACKINTERFAC%ISOPEN) THEN
                CLOSE MO_BCWFPACKINTERFAC.CUWFPACKINTERFAC;
            END IF;
			ERRORS.SETERROR;
            RAISE  EX.CONTROLLED_ERROR;
	END;


    FUNCTION FBLACTIVITYEXIST
        (
        INUPACKAGEID        IN MO_PACKAGES.PACKAGE_ID%TYPE,
        INUACTIONID         IN GE_ACTION_MODULE.ACTION_ID%TYPE,
        INUSTATUSACTIVITYID IN MO_WF_PACK_INTERFAC.STATUS_ACTIVITY_ID%TYPE
        )
    RETURN BOOLEAN
    IS
        NUCOUNT NUMBER;
    BEGIN
        FOR REC IN MO_BCWFPACKINTERFAC.CUEXISTACTIVITY(INUPACKAGEID,INUACTIONID,INUSTATUSACTIVITYID) LOOP
            NUCOUNT := REC.NUCOUNT;
        END LOOP;

        
        IF NUCOUNT = MO_BOCONSTANTS.CNUOK THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    













    FUNCTION FBLLOCKRECORD
        (
        INUWFPACKINTERFACID IN MO_WF_PACK_INTERFAC.WF_PACK_INTERFAC_ID%TYPE,
        ORCWFPACKINTERFAC   OUT DAMO_WF_PACK_INTERFAC.STYMO_WF_PACK_INTERFAC
        )
    RETURN BOOLEAN
    IS
    BEGIN
        
        DAMO_WF_PACK_INTERFAC.LOCKBYPK(INUWFPACKINTERFACID,ORCWFPACKINTERFAC);
        
        RETURN TRUE;
    EXCEPTION
		WHEN OTHERS THEN
           RETURN FALSE;
	END;

    

















    PROCEDURE PROCESSACTION
        (
        IORCWFPACKINTERFAC  IN OUT DAMO_WF_PACK_INTERFAC.STYMO_WF_PACK_INTERFAC,
        ONUERRORCODE        OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE     OUT VARCHAR2
        )
    IS
        NUERRORCODE         GE_MESSAGE.MESSAGE_ID%TYPE;
        SBERRORMESSAGE      VARCHAR2(2000);
        NUCAUSALIDOUTPUT    MO_WF_PACK_INTERFAC.CAUSAL_ID_OUTPUT%TYPE;

        EXCALLSERVICE   EXCEPTION;
    BEGIN
        UT_TRACE.TRACE('Inicia Ejecuci�n de Acci�n:['||IORCWFPACKINTERFAC.ACTION_ID||']',3);

        SAVEPOINT SVPROCESSACTION;

        
        INSTANCEDATA(IORCWFPACKINTERFAC);

        
        MO_BOUTILITIES.INITIALIZEOUTPUT(NUERRORCODE,SBERRORMESSAGE);

        
        GE_BSACTION.EXECVALIDEXPRBYACTION
            (
            IORCWFPACKINTERFAC.ACTION_ID,
            GE_BOMODULE.GETWORKFLOW,
            GE_BOMODULE.GETMOTIVES_MANAGEMENT,
            NUERRORCODE,
            SBERRORMESSAGE
            );
        IF (NVL(NUERRORCODE,MO_BOCONSTANTS.CNUOK) <> MO_BOCONSTANTS.CNUOK) THEN
            RAISE EXCALLSERVICE;
        END IF;

        
        IF MO_BOACTIONUTIL.FBLGETEXECACTIONINSTANDBY THEN

            UT_TRACE.TRACE('Actividad en Espera',3);
            
            NUCAUSALIDOUTPUT := GE_BOCAUSAL.CNUCAUSALACTIVITYSTANDBY;
        ELSE

            
            GE_BOINSTANCE.GETVALUE(MO_BOCONSTANTS.CSBMO_WF_PACK_INTERFAC,MO_BOCONSTANTS.CSBCAUSAL_ID_OUTPUT,NUCAUSALIDOUTPUT);

            
            IF (NUCAUSALIDOUTPUT IS NULL) THEN
                NUCAUSALIDOUTPUT := MO_BOCAUSAL.FNUGETSUCCESS;
            END IF;
        END IF;

        UT_TRACE.TRACE('Causal:['||NUCAUSALIDOUTPUT||']',3);
        
        IORCWFPACKINTERFAC.CAUSAL_ID_OUTPUT := NUCAUSALIDOUTPUT;
    EXCEPTION
        WHEN EXCALLSERVICE THEN
            ROLLBACK TO SVPROCESSACTION;
            ERRORS.SETERROR
                (
                MO_BOCONSTERROR.CNUERRCALLSERVICE,
                'GE_BSAction.ExecValidExprByAction' || '|' ||
                TO_CHAR(NUERRORCODE) || ' - ' || SBERRORMESSAGE
                );
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
        WHEN EX.CONTROLLED_ERROR THEN
            ROLLBACK TO SVPROCESSACTION;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ROLLBACK TO SVPROCESSACTION;
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    END;


    PROCEDURE MANUALSEND
        (
        INUWFPACKINTERFACID IN MO_WF_PACK_INTERFAC.WF_PACK_INTERFAC_ID%TYPE
        )
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        UT_TRACE.TRACE('Inicia MO_BOWf_Pack_Interfac.ManualSend',1);
        MANUALSENDDEP(INUWFPACKINTERFACID);
        COMMIT;
        UT_TRACE.TRACE('Finaliza MO_BOWf_Pack_Interfac.ManualSend',1);
    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
            ROLLBACK;
            RAISE  EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
            ROLLBACK;
			ERRORS.SETERROR;
            RAISE  EX.CONTROLLED_ERROR;
	END;
	

    PROCEDURE MANUALSEND
        (
        INUWFPACKINTERFACID IN  MO_WF_PACK_INTERFAC.WF_PACK_INTERFAC_ID%TYPE,
        ONUERRORCODE        OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        ONUERRORMESSAGE     OUT VARCHAR2
        )
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        UT_TRACE.TRACE('Inicia MO_BOWf_Pack_Interfac.ManualSend',1);
        GNUERRORCODE := MO_BOCONSTANTS.CNUOK;
        GSBERRORMESSAGE := NULL;
        MANUALSENDDEP(INUWFPACKINTERFACID);
        ONUERRORCODE := GNUERRORCODE;
        ONUERRORMESSAGE := GSBERRORMESSAGE;
        COMMIT;
        UT_TRACE.TRACE('Finaliza MO_BOWf_Pack_Interfac.ManualSend',1);
    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
            ROLLBACK;
            RAISE  EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
            ROLLBACK;
			ERRORS.SETERROR;
            RAISE  EX.CONTROLLED_ERROR;
	END;

    


















    PROCEDURE MANUALSENDDEP
        (
        INUWFPACKINTERFACID IN MO_WF_PACK_INTERFAC.WF_PACK_INTERFAC_ID%TYPE
        )
    IS
        NUERRORCODE         GE_MESSAGE.MESSAGE_ID%TYPE;
        SBERRORMESSAGE      VARCHAR2(2000);
        RCWFPACKINTERFAC    DAMO_WF_PACK_INTERFAC.STYMO_WF_PACK_INTERFAC;
    BEGIN
        UT_TRACE.TRACE('Inicia MO_BOWf_Pack_Interfac.ManualSendDep',1);

        
        IF FBLLOCKRECORD(INUWFPACKINTERFACID,RCWFPACKINTERFAC) THEN

            
            IF (RCWFPACKINTERFAC.STATUS_ACTIVITY_ID = MO_BOSTATUSPARAMETER.FNUGETSTA_ACTIV_RESTART) THEN

                
                MO_BOACTIONUTIL.SETEXECACTIONINSTANDBY(FALSE);

                
                MO_BOUTILITIES.INITIALIZEOUTPUT(NUERRORCODE,SBERRORMESSAGE);

                
                RCWFPACKINTERFAC.CAUSAL_ID_OUTPUT := NULL;

                
                PROCESSACTION(RCWFPACKINTERFAC,NUERRORCODE,SBERRORMESSAGE);

                IF (NVL(NUERRORCODE,MO_BOCONSTANTS.CNUOK) <> MO_BOCONSTANTS.CNUOK) THEN

                    
                    RCWFPACKINTERFAC.CAUSAL_ID_OUTPUT := GE_BOCAUSAL.CNUCAUSALACTIVITYSTANDBY;
                ELSE
                    
                    MO_BONOTIFICATION.NOTIFYACTIVPACKAGE
                        (
                        RCWFPACKINTERFAC.ACTIVITY_ID,
                        RCWFPACKINTERFAC.CAUSAL_ID_OUTPUT,
                        NUERRORCODE,
                        SBERRORMESSAGE
                        );
                END IF;

                
                PROCESSERROR(RCWFPACKINTERFAC,NUERRORCODE,SBERRORMESSAGE);

            END IF;
        END IF;
        GNUERRORCODE := NUERRORCODE;
        GSBERRORMESSAGE := SBERRORMESSAGE;
        UT_TRACE.TRACE('Finaliza MO_BOWf_Pack_Interfac.ManualSendDep',1);
    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
            RAISE  EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			ERRORS.SETERROR;
            RAISE  EX.CONTROLLED_ERROR;
	END MANUALSENDDEP;


    PROCEDURE PROCESSRECORD
        (
        IORCWFPACKINTERFAC IN OUT DAMO_WF_PACK_INTERFAC.STYMO_WF_PACK_INTERFAC
        )
    IS
        NUERRORCODE     GE_MESSAGE.MESSAGE_ID%TYPE;
        SBERRORMESSAGE  VARCHAR2(2000);
    BEGIN
        UT_TRACE.TRACE('Inicia Proceso Registro:['||IORCWFPACKINTERFAC.WF_PACK_INTERFAC_ID||']',3);

        
        MO_BOACTIONUTIL.SETEXECACTIONINSTANDBY(FALSE);

        
        MO_BOUTILITIES.INITIALIZEOUTPUT(NUERRORCODE,SBERRORMESSAGE);

        
        PROCESSACTION(IORCWFPACKINTERFAC,NUERRORCODE,SBERRORMESSAGE);
        IF (NVL(NUERRORCODE,MO_BOCONSTANTS.CNUOK) <> MO_BOCONSTANTS.CNUOK) THEN

            
            IORCWFPACKINTERFAC.CAUSAL_ID_OUTPUT := GE_BOCAUSAL.CNUCAUSALACTIVITYSTANDBY;
        END IF;

        
        PROCESSERROR(IORCWFPACKINTERFAC,NUERRORCODE,SBERRORMESSAGE,TRUE);

        UT_TRACE.TRACE('Causal:['||IORCWFPACKINTERFAC.CAUSAL_ID_OUTPUT||']',3);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    PROCEDURE UPDRECTOFINISHANDNOTIFY
        (
        IRCWFPACKINTERFAC   IN DAMO_WF_PACK_INTERFAC.STYMO_WF_PACK_INTERFAC,
        INUCAUSALIDOUTPUT   IN MO_WF_PACK_INTERFAC.CAUSAL_ID_OUTPUT%TYPE
        )
    IS
        RCWFPACKINTERFAC    DAMO_WF_PACK_INTERFAC.STYMO_WF_PACK_INTERFAC;
    BEGIN
        UT_TRACE.TRACE('Wf_Pack_Interfac_Id:['||IRCWFPACKINTERFAC.WF_PACK_INTERFAC_ID||']Causa:['||INUCAUSALIDOUTPUT||']',9);
        
        UPDACTIVITYANDNOTIFY(IRCWFPACKINTERFAC.WF_PACK_INTERFAC_ID, INUCAUSALIDOUTPUT);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDRECTOFINISHANDNOTIFY;


	PROCEDURE PREPNOTTOWFPACK
        (
        INUPACKAGEID        IN MO_PACKAGES.PACKAGE_ID%TYPE,
        INUACTIONID         IN GE_ACTION_MODULE.ACTION_ID%TYPE,
        INUCAUSALIDOUTPUT   IN MO_WF_PACK_INTERFAC.CAUSAL_ID_OUTPUT%TYPE,
        INUSTATUSACTIVITYID IN MO_WF_PACK_INTERFAC.STATUS_ACTIVITY_ID%TYPE DEFAULT MO_BOSTATUSPARAMETER.FNUGETSTA_ACTIV_REGISTER,
        IBLSETERROR         IN BOOLEAN DEFAULT TRUE
        )
    IS
        RCWFPACKINTERFAC    DAMO_WF_PACK_INTERFAC.STYMO_WF_PACK_INTERFAC;
    BEGIN
        UT_TRACE.TRACE('Inicia MO_BOWf_Pack_Interfac.PrepNotToWfPack',7);
        UT_TRACE.TRACE('Paquete:['||INUPACKAGEID||']Acci�n:['||INUACTIONID||']Causal:['||INUCAUSALIDOUTPUT||']Estado:['||INUSTATUSACTIVITYID||']',8);

        IF (NOT IBLSETERROR) THEN
            
            IF (NOT FBLACTIVITYEXIST(INUPACKAGEID,INUACTIONID,INUSTATUSACTIVITYID)) THEN
                UT_TRACE.TRACE('No Existe Actividad',8);
                RETURN;
            END IF;
        END IF;

        
        GETACTIVITYIDPACK(INUPACKAGEID,INUACTIONID,INUSTATUSACTIVITYID,RCWFPACKINTERFAC);

        
        UPDRECTOFINISHANDNOTIFY(RCWFPACKINTERFAC,INUCAUSALIDOUTPUT);

        UT_TRACE.TRACE('Finaliza MO_BOWf_Pack_Interfac.PrepNotToWfPack',7);
    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
            RAISE  EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			ERRORS.SETERROR;
            RAISE  EX.CONTROLLED_ERROR;
	END;


    FUNCTION FNUGETPACKAGEIDINST
    RETURN NUMBER
    IS
        NUPACKAGEID MO_WF_PACK_INTERFAC.PACKAGE_ID%TYPE;
    BEGIN
        GE_BOINSTANCE.GETVALUE
            (
            MO_BOCONSTANTS.CSBMO_PACKAGES,
            MO_BOCONSTANTS.CSBPACKAGE_ID,
            NUPACKAGEID
            );
        RETURN NUPACKAGEID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    FUNCTION FNUGETACTIVITYIDINST
    RETURN NUMBER
    IS
        NUACTIVITYID    MO_WF_PACK_INTERFAC.ACTIVITY_ID%TYPE;
    BEGIN

        GE_BOINSTANCE.GETVALUE(MO_BOCONSTANTS.CSBMO_WF_PACK_INTERFAC,MO_BOCONSTANTS.CSBACTIVITY_ID,NUACTIVITYID);
        RETURN NUACTIVITYID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    FUNCTION FNUGETCAUSALIDINPUTINST
    RETURN NUMBER
    IS
        NUCAUSALIDINPUT MO_WF_PACK_INTERFAC.CAUSAL_ID_INPUT%TYPE;
    BEGIN

        GE_BOINSTANCE.GETVALUE(MO_BOCONSTANTS.CSBMO_WF_PACK_INTERFAC,MO_BOCONSTANTS.CSBCAUSAL_ID_INPUT,NUCAUSALIDINPUT);
        RETURN NUCAUSALIDINPUT;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    FUNCTION FNUGETPREVIOUSACTIVITYIDINST
    RETURN NUMBER
    IS
        NUPREVIOUSACTIVITYID    MO_WF_PACK_INTERFAC.PREVIOUS_ACTIVITY_ID%TYPE;
    BEGIN

        GE_BOINSTANCE.GETVALUE(MO_BOCONSTANTS.CSBMO_WF_PACK_INTERFAC,MO_BOCONSTANTS.CSBPREVIOUS_ACTIVITY_ID,NUPREVIOUSACTIVITYID);
        RETURN NUPREVIOUSACTIVITYID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    FUNCTION FNUGETUNDOACTIVITYIDINST
    RETURN NUMBER
    IS
        NUUNDOACTIVITYID    MO_WF_PACK_INTERFAC.UNDO_ACTIVITY_ID%TYPE;
    BEGIN

        GE_BOINSTANCE.GETVALUE(MO_BOCONSTANTS.CSBMO_WF_PACK_INTERFAC,MO_BOCONSTANTS.CSBUNDO_ACTIVITY_ID,NUUNDOACTIVITYID);
        RETURN NUUNDOACTIVITYID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


	PROCEDURE FINISHACTIVITIESPACK
        (
        INUPACKAGEID    IN MO_PACKAGES.PACKAGE_ID%TYPE,
        INUACTIVITYID   IN MO_WF_PACK_INTERFAC.ACTIVITY_ID%TYPE DEFAULT NULL
        )
    IS
        RCACTIVPACKNOFINISH     DAMO_WF_PACK_INTERFAC.STYMO_WF_PACK_INTERFAC;
        CURFACTIVMOTNOFINISH    CONSTANTS.TYREFCURSOR;
        RCWFPACKINTERFAC        DAMO_WF_PACK_INTERFAC.STYMO_WF_PACK_INTERFAC;
    BEGIN
        UT_TRACE.TRACE('Inicia MO_BOWf_Pack_Interfac.FinishActivitiesPack. Paquete:['||INUPACKAGEID||']',4);

        
        CURFACTIVMOTNOFINISH := MO_BCWFPACKINTERFAC.FRFGETACTIVPACKNOFINISH(INUPACKAGEID,INUACTIVITYID);
        FETCH CURFACTIVMOTNOFINISH INTO RCACTIVPACKNOFINISH;
        WHILE CURFACTIVMOTNOFINISH%FOUND LOOP

            
            IF FBLLOCKRECORD(RCACTIVPACKNOFINISH.WF_PACK_INTERFAC_ID,RCWFPACKINTERFAC) THEN
                UT_TRACE.TRACE('Registro Bloqueado:['||RCACTIVPACKNOFINISH.WF_PACK_INTERFAC_ID||']',5);

                
                RCACTIVPACKNOFINISH.STATUS_ACTIVITY_ID := MO_BOSTATUSPARAMETER.FNUGETSTA_ACTIV_FINISH;
                RCACTIVPACKNOFINISH.ATTENDANCE_DATE := SYSDATE;
                RCACTIVPACKNOFINISH.EXECUTOR_LOG_ID := NULL;
                RCACTIVPACKNOFINISH.CAUSAL_ID_OUTPUT := MO_BOCAUSAL.FNUGETFAIL;

                
                DAMO_WF_PACK_INTERFAC.UPDRECORD(RCACTIVPACKNOFINISH);

                
                MO_BONOTIFICATION.NOTIFYACTIVPACKAGE
                    (
                    RCACTIVPACKNOFINISH.ACTIVITY_ID,
                    RCACTIVPACKNOFINISH.CAUSAL_ID_OUTPUT
                    );
            END IF;

            FETCH CURFACTIVMOTNOFINISH INTO RCACTIVPACKNOFINISH;
        END LOOP;
        CLOSE CURFACTIVMOTNOFINISH;
        UT_TRACE.TRACE('Finaliza MO_BOWf_Pack_Interfac.FinishActivitiesPack',4);
    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(CURFACTIVMOTNOFINISH);
            RAISE EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(CURFACTIVMOTNOFINISH);
			ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
	END;


    FUNCTION FNUGETWFPACKINTERFACIDINST
    RETURN NUMBER
    IS
        NUWFPACKINTERFACID  MO_WF_PACK_INTERFAC.WF_PACK_INTERFAC_ID%TYPE;
    BEGIN

        GE_BOINSTANCE.GETVALUE(MO_BOCONSTANTS.CSBMO_WF_PACK_INTERFAC,'WF_PACK_INTERFAC_ID',NUWFPACKINTERFACID);
        RETURN NUWFPACKINTERFACID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    PROCEDURE UPDACTIVITYANDNOTIFY
    (
        INUPACKINTERFACID   IN MO_WF_PACK_INTERFAC.WF_PACK_INTERFAC_ID%TYPE,
        INUCAUSALID         IN MO_WF_PACK_INTERFAC.CAUSAL_ID_OUTPUT%TYPE DEFAULT MO_BOCAUSAL.FNUGETSUCCESS,
        INUSTATUSACTIVITYID IN MO_WF_PACK_INTERFAC.STATUS_ACTIVITY_ID%TYPE DEFAULT MO_BOSTATUSPARAMETER.FNUGETSTA_ACTIV_FINISH
    )
    IS
        RCWFPACKINTERFAC   DAMO_WF_PACK_INTERFAC.STYMO_WF_PACK_INTERFAC;
    BEGIN
        
        RCWFPACKINTERFAC := DAMO_WF_PACK_INTERFAC.FRCGETRECORD(INUPACKINTERFACID);

        
        RCWFPACKINTERFAC.STATUS_ACTIVITY_ID := INUSTATUSACTIVITYID;
        RCWFPACKINTERFAC.ATTENDANCE_DATE := SYSDATE;
        RCWFPACKINTERFAC.EXECUTOR_LOG_ID := NULL;
        RCWFPACKINTERFAC.CAUSAL_ID_OUTPUT := INUCAUSALID;

        
        DAMO_WF_PACK_INTERFAC.UPDRECORD(RCWFPACKINTERFAC);

        
        MO_BONOTIFICATION.NOTIFYACTIVPACKAGE(RCWFPACKINTERFAC.ACTIVITY_ID, INUCAUSALID);
    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
            RAISE  EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			ERRORS.SETERROR;
            RAISE  EX.CONTROLLED_ERROR;
	END UPDACTIVITYANDNOTIFY;

    

















    PROCEDURE RESTOREACTIVITIES
        (
        INUPACKAGE_ID   IN  MO_WF_PACK_INTERFAC.PACKAGE_ID%TYPE,
        INUACTION_ID    IN  MO_WF_PACK_INTERFAC.ACTION_ID%TYPE,
        IDTDATE         IN  DATE,
        INUSEQUENCE     IN  NUMBER DEFAULT 0
        )
    IS
        NUSTANDBYSTATUS     MO_WF_PACK_INTERFAC.STATUS_ACTIVITY_ID%TYPE;
        NUFINISHSTATUS      MO_WF_PACK_INTERFAC.STATUS_ACTIVITY_ID%TYPE;
        NURESTARTSTATUS     MO_STATUS_ACTIVITY.STATUS_ACTIVITY_ID%TYPE;
        NUCAUSALEXITO       MO_WF_PACK_INTERFAC.CAUSAL_ID_OUTPUT%TYPE;
        NUCAUSALFALLO       MO_WF_PACK_INTERFAC.CAUSAL_ID_OUTPUT%TYPE;
        CUACTIVITIES  CONSTANTS.TYREFCURSOR ;
        RCREG   DAMO_WF_PACK_INTERFAC.STYMO_WF_PACK_INTERFAC;

        PROCEDURE CHARGEBASICDATA IS
        BEGIN
            
            NUFINISHSTATUS  := MO_BOSTATUSPARAMETER.FNUGETSTA_ACTIV_FINISH ;

            
            NURESTARTSTATUS :=  MO_BOSTATUSPARAMETER.FNUGETSTA_ACTIV_RESTART;

            
            NUCAUSALEXITO := MO_BOCAUSAL.FNUGETSUCCESS ;

            
            NUCAUSALFALLO := MO_BOCAUSAL.FNUGETFAIL ;
        END;

    BEGIN
        UT_TRACE.TRACE('Inicia Continuidad de actividades de pago. Paquete:['||INUPACKAGE_ID||']',5);

        CHARGEBASICDATA ;

        CUACTIVITIES := MO_BCWFPACKINTERFAC.FRCACTIVITIESSTANDBY(
                           INUPACKAGE_ID,INUACTION_ID,INUSEQUENCE);

        SAVEPOINT SVSETPAYMENTS;

        LOOP
        
            FETCH CUACTIVITIES INTO RCREG;
            EXIT WHEN CUACTIVITIES%NOTFOUND;

            BEGIN
                UT_TRACE.TRACE('Id Registro de Mo_Wf_Pack_Interfac:['||RCREG.WF_PACK_INTERFAC_ID||']',6) ;
                UPDACTIVITYANDNOTIFY(RCREG.WF_PACK_INTERFAC_ID, NUCAUSALEXITO, NUFINISHSTATUS );
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK TO SVSETPAYMENTS;
                    UPDACTIVITYANDNOTIFY(RCREG.WF_PACK_INTERFAC_ID, NUCAUSALFALLO, NURESTARTSTATUS );
                    COMMIT;
                    RAISE EX.CONTROLLED_ERROR;
            END;
        
        END LOOP;
        CLOSE CUACTIVITIES;

        UT_TRACE.TRACE('Termina Continuidad de actividades de pago ',5);
    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
		    ROLLBACK TO SVSETPAYMENTS;
            RAISE  EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
		    ROLLBACK TO SVSETPAYMENTS;
			ERRORS.SETERROR;
            RAISE  EX.CONTROLLED_ERROR;
    END;
    
    
















    PROCEDURE FINISHTASK
    (
        INUACTIVITYID   IN MO_WF_PACK_INTERFAC.ACTIVITY_ID%TYPE
    )
    IS
        RCMOWFPACKINTERFAC  DAMO_WF_PACK_INTERFAC.STYMO_WF_PACK_INTERFAC;
        NUSTATUSACTIVITYID  MO_WF_PACK_INTERFAC.STATUS_ACTIVITY_ID%TYPE;

    BEGIN
        UT_TRACE.TRACE('Inicia MO_BOWF_PACK_INTERFAC.FinishTask. inuActivityId['||INUACTIVITYID||']',5);

        
        NUSTATUSACTIVITYID := MO_BOSTATUSPARAMETER.FNUGETSTA_ACTIV_STANDBY;

        
        OPEN MO_BCWFPACKINTERFAC.CUMOWFPACKINTERFAC(INUACTIVITYID,NUSTATUSACTIVITYID);
        FETCH MO_BCWFPACKINTERFAC.CUMOWFPACKINTERFAC INTO RCMOWFPACKINTERFAC;
            IF RCMOWFPACKINTERFAC.ACTIVITY_ID IS NOT NULL THEN

                
                UPDRECTOFINISHANDNOTIFY (RCMOWFPACKINTERFAC, MO_BOCAUSAL.FNUGETFAIL);

            END IF;
        CLOSE MO_BCWFPACKINTERFAC.CUMOWFPACKINTERFAC;
    
        UT_TRACE.TRACE('Termina MO_BOWF_PACK_INTERFAC.FinishTask ',5);
        
        EXCEPTION
        	WHEN EX.CONTROLLED_ERROR THEN
                RAISE  EX.CONTROLLED_ERROR;
        	WHEN OTHERS THEN
        		ERRORS.SETERROR;
                RAISE  EX.CONTROLLED_ERROR;
                
    END  FINISHTASK;

END MO_BOWF_PACK_INTERFAC;