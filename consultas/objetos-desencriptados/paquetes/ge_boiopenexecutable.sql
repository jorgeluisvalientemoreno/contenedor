PACKAGE BODY GE_BOIOpenExecutable
IS


























    CSBVERSION CONSTANT VARCHAR2(250) := 'SAO195232';

    
    SBERRMSG GE_ERROR_LOG.DESCRIPTION%TYPE;

    CSBINSTANCE      CONSTANT VARCHAR2(200) := 'WORK_INSTANCE';
    CSBENTITY        CONSTANT VARCHAR2(200) := 'IOPENEXECUTABLE';
    CSBPOST_REGISTER CONSTANT VARCHAR2(200) := 'POST_REGISTER';
    CSBSOURCE_DATA   CONSTANT VARCHAR2(200) := 'SOURCE_DATA';

    FUNCTION FSBVERSION RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;



























PROCEDURE SETONEVENT
(
    INUEXECUTABLEID SA_EXECUTABLE.EXECUTABLE_ID%TYPE,
    ISBEVENT        VARCHAR2,
    ISBPARAMS       VARCHAR
)
IS
    NUPOSINSTANCE     NUMBER;
BEGIN

    UT_TRACE.TRACE( 'IOpenExecutable-Event: Event['||ISBEVENT||'] Exec['||INUEXECUTABLEID||'] Params['||ISBPARAMS||']', 15 );

    
    IF ( NOT GE_BOINSTANCECONTROL.FBLISINITINSTANCECONTROL ) THEN
        GE_BOINSTANCECONTROL.INITINSTANCEMANAGER;
    END IF;

    
    IF ( NOT GE_BOINSTANCECONTROL.FBLACCKEYINSTANCESTACK( CSBINSTANCE,
                                                          NUPOSINSTANCE ) )
    THEN
        GE_BOINSTANCECONTROL.CREATEINSTANCE( CSBINSTANCE, NULL );
    END IF;

    GE_BOINSTANCECONTROL.ADDATTRIBUTE( CSBINSTANCE,
                                       NULL,
                                       CSBENTITY,
                                       ISBEVENT,
                                       INUEXECUTABLEID );
                                       
    IF ( ISBPARAMS IS NOT NULL) THEN
        GE_BOINSTANCECONTROL.ADDATTRIBUTE( CSBINSTANCE,
                                           NULL,
                                           CSBENTITY,
                                           CSBSOURCE_DATA,
                                           ISBPARAMS );
    END IF;


    UT_TRACE.TRACE( 'Fin GE_BOIOpenExecutable.SetOnEvent', 15 );

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END SETONEVENT;
















PROCEDURE SETONEVENT
(
    INUEXECUTABLEID SA_EXECUTABLE.EXECUTABLE_ID%TYPE,
    ISBEVENT        VARCHAR2
)
IS
    NUPOSINSTANCE     NUMBER;
BEGIN

    SETONEVENT
    (
        INUEXECUTABLEID,
        ISBEVENT,
        NULL
    );

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END SETONEVENT;



















PROCEDURE SETPOSTREGISTER
(
    INUEXECUTABLEID IN SA_EXECUTABLE.EXECUTABLE_ID%TYPE
)
IS
BEGIN
    PKERRORS.PUSH('GE_BOIOpenExecutable.setPostRegister');

    SETONEVENT(INUEXECUTABLEID, CSBPOST_REGISTER);

    PKERRORS.POP;

EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
    	RAISE;
    WHEN OTHERS THEN
    	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
    	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );

END SETPOSTREGISTER;















PROCEDURE SETPOSTREGPARAMS
(
    INUEXECUTABLEID IN SA_EXECUTABLE.EXECUTABLE_ID%TYPE,
    ISBPARAMS       IN VARCHAR
)
IS
BEGIN
    PKERRORS.PUSH('GE_BOIOpenExecutable.setPostRegister');

    SETONEVENT(INUEXECUTABLEID, CSBPOST_REGISTER, ISBPARAMS);

    PKERRORS.POP;

EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
    	RAISE;
    WHEN OTHERS THEN
    	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
    	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );

END SETPOSTREGPARAMS;



















PROCEDURE PRINTPREVIEWERRULE
IS
    NUPREVIEWEREXECID SA_EXECUTABLE.EXECUTABLE_ID%TYPE := 9699;
BEGIN

    SETONEVENT(NUPREVIEWEREXECID, CSBPOST_REGISTER);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;






















PROCEDURE PRINTDUPLICATERULE
IS
    NUPREVIEWEREXECID SA_EXECUTABLE.EXECUTABLE_ID%TYPE := 5988;
BEGIN

    SETONEVENT(NUPREVIEWEREXECID, CSBPOST_REGISTER);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;



PROCEDURE SETORDERPROGRAM
IS
    
    CNUORDERPROGRAMEXECID  CONSTANT SA_EXECUTABLE.EXECUTABLE_ID%TYPE := 1210;

BEGIN

    SETONEVENT(CNUORDERPROGRAMEXECID, CSBPOST_REGISTER);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END SETORDERPROGRAM;


END GE_BOIOPENEXECUTABLE;