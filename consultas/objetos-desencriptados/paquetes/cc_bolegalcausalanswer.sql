PACKAGE BODY CC_BOLegalCausalAnswer
IS





















































    
    
    
    
    
    
    
    
    

    
    
    CSBVERSION CONSTANT VARCHAR2(250) := 'SAO203956';

    
    CNUTRACE_LEVEL       CONSTANT    NUMBER  := 7;

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
























    FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
    
        UT_TRACE.TRACE('Inicio: CC_BOLegalCausalAnswer.fsbVersion', CNUTRACE_LEVEL);

        UT_TRACE.TRACE('Fin: CC_BOLegalCausalAnswer.fsbVersion', CNUTRACE_LEVEL);
        RETURN CSBVERSION;
    
    EXCEPTION
    
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR: CC_BOLegalCausalAnswer.fsbVersion', CNUTRACE_LEVEL);
        	RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('others: CC_BOLegalCausalAnswer.fsbVersion', CNUTRACE_LEVEL);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END FSBVERSION;
    
    












































    PROCEDURE UPDATECLAIMANSWER
    (
        INUPACKAGEID    IN  MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS
        
        
        
        NUANSWERID      CC_ANSWER.ANSWER_ID%TYPE;
    BEGIN
    
        UT_TRACE.TRACE('Inicio: CC_BOLegalCausalAnswer.UpdateClaimAnswer', CNUTRACE_LEVEL);

        
        UPDATEPACKAGEANSWER( INUPACKAGEID, NUANSWERID );  

        UT_TRACE.TRACE('Fin: CC_BOLegalCausalAnswer.UpdateClaimAnswer', CNUTRACE_LEVEL);
    
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDATECLAIMANSWER;

    
































    PROCEDURE UPDATEPACKAGEANSWER
    (
        INUPACKAGEID    IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        ONUANSWERID     OUT CC_ANSWER.ANSWER_ID%TYPE
    )
    IS
        
        
        
        TBMOTIVES   DAMO_MOTIVE.TYTBMO_MOTIVE;
        
        
        
        RFORDERS    PKCONSTANTE.TYREFCURSOR;
    BEGIN

        UT_TRACE.TRACE( 'CC_BOLegalCausalAnswer.UpdatePackageAnswer('||INUPACKAGEID||')', 15 );

        
        GETPACKAGEANSWER( INUPACKAGEID, ONUANSWERID );

        
        IF ( ONUANSWERID IS NULL ) THEN
            RETURN;
        END IF;

        
        TBMOTIVES := MO_BCMOTIVE.FTBALLMOTIVESBYPACK( INUPACKAGEID );

        
        IF ( TBMOTIVES.COUNT = 0 ) THEN
            RETURN;
        END IF;

        
        DAMO_MOTIVE.UPDANSWER_ID( TBMOTIVES( 1 ).MOTIVE_ID, ONUANSWERID );

        UT_TRACE.TRACE( 'Fin CC_BOLegalCausalAnswer.UpdatePackageAnswer => onuAnswerId['||ONUANSWERID||']', 15 );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDATEPACKAGEANSWER;

    
















    PROCEDURE GETPACKAGEANSWER
    (
        INUPACKAGE  IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        ONUANSWER   OUT CC_ANSWER.ANSWER_ID%TYPE
    )
    IS
        
        
        
        NUIDX           BINARY_INTEGER;
        NUPACKAGETYPE   MO_PACKAGES.PACKAGE_TYPE_ID%TYPE;
        OBNUMBER        GE_TYOBNUMBER;
        RCORDER         DAOR_ORDER.STYOR_ORDER;
        TBLEGCAUSANS    DACC_LEGAL_CAUSAL_ANSWER.TYTBCC_LEGAL_CAUSAL_ANSWER;
        TBTASKTYPES     GE_TYTBNUMBER := GE_TYTBNUMBER();
        TBCAUSALS       GE_TYTBNUMBER := GE_TYTBNUMBER();
        TBANSWERS       GE_TYTBNUMBER := GE_TYTBNUMBER();
        
        
        
        RFORDERS        PKCONSTANTE.TYREFCURSOR;
    BEGIN

        UT_TRACE.TRACE( 'CC_BOLegalCausalAnswer.GetPackageAnswer', 15 );

        
        NUPACKAGETYPE := DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID( INUPACKAGE );

        
        CC_BCANSWERBYPACK.GETLEGCAUANSBYPACKTYPE( NUPACKAGETYPE, TBLEGCAUSANS );  

        NUIDX := TBLEGCAUSANS.FIRST;

        WHILE ( NUIDX IS NOT NULL ) LOOP

            TBTASKTYPES.EXTEND;
            OBNUMBER := GE_TYOBNUMBER( TBLEGCAUSANS(NUIDX).TASK_TYPE_ID );
            TBTASKTYPES( TBTASKTYPES.COUNT ) := OBNUMBER;

            TBCAUSALS.EXTEND;
            OBNUMBER := GE_TYOBNUMBER( TBLEGCAUSANS(NUIDX).CAUSAL_ID );
            TBCAUSALS( TBCAUSALS.COUNT ) := OBNUMBER;

            TBANSWERS.EXTEND;
            OBNUMBER := GE_TYOBNUMBER( TBLEGCAUSANS(NUIDX).ANSWER_ID );
            TBANSWERS( TBANSWERS.COUNT ) := OBNUMBER;

            NUIDX := TBLEGCAUSANS.NEXT( NUIDX );

        END LOOP;

        
        RFORDERS := OR_BCORDERACTIVITIES.FRFGETORDERSBYPACKAGE( INUPACKAGE,
                                                                TBTASKTYPES );
        FETCH RFORDERS INTO RCORDER;
        CLOSE RFORDERS;

        
        IF ( RCORDER.CAUSAL_ID IS NULL )THEN
            RETURN;
        END IF;

        
        ONUANSWER := CC_BCLEGALCAUSALANSWER.FNUGETANSWERBYCAUSAL(
                                                            RCORDER.TASK_TYPE_ID,
                                                            RCORDER.CAUSAL_ID,
                                                            TBTASKTYPES,
                                                            TBCAUSALS,
                                                            TBANSWERS );

        UT_TRACE.TRACE( 'Fin CC_BOLegalCausalAnswer.GetPackageAnswer', 15 );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETPACKAGEANSWER;

END CC_BOLEGALCAUSALANSWER;