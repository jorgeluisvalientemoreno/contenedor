PACKAGE OR_BSExternalLegalizeActivity IS




















	

	

	

    
    FUNCTION FSBVERSION  RETURN VARCHAR2;

    
























    PROCEDURE LEGALIZEORDER
    (
        INUORDERID        IN  OR_ORDER.ORDER_ID%TYPE,
        INUCAUSALID       IN  OR_ORDER.CAUSAL_ID%TYPE,
        INUPERSONID       IN  GE_PERSON.PERSON_ID%TYPE,
        IDTEXEINITIALDATE IN  OR_ORDER.EXEC_INITIAL_DATE%TYPE,
        IDTEXEFINALDATE   IN  OR_ORDER.EXECUTION_FINAL_DATE%TYPE,
        ISBCOMMENT	      IN  OR_ORDER_COMMENT.ORDER_COMMENT%TYPE,
        ONUERRORCODE      OUT NUMBER,
        OSBERRORMESSAGE   OUT VARCHAR2,
        IDTCHANGEDATE     IN OR_ORDER_STAT_CHANGE.STAT_CHG_DATE%TYPE DEFAULT NULL
    );

END OR_BSEXTERNALLEGALIZEACTIVITY;

PACKAGE BODY OR_BSExternalLegalizeActivity
IS
    
    CSBVERSION   CONSTANT VARCHAR2(20) := 'SAO198736';

    

	
    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    PROCEDURE LEGALIZEORDER
    (
        INUORDERID        IN  OR_ORDER.ORDER_ID%TYPE,
        INUCAUSALID       IN  OR_ORDER.CAUSAL_ID%TYPE,
        INUPERSONID       IN  GE_PERSON.PERSON_ID%TYPE,
        IDTEXEINITIALDATE IN  OR_ORDER.EXEC_INITIAL_DATE%TYPE,
        IDTEXEFINALDATE   IN  OR_ORDER.EXECUTION_FINAL_DATE%TYPE,
        ISBCOMMENT	      IN  OR_ORDER_COMMENT.ORDER_COMMENT%TYPE,
        ONUERRORCODE      OUT NUMBER,
        OSBERRORMESSAGE   OUT VARCHAR2,
        IDTCHANGEDATE     IN OR_ORDER_STAT_CHANGE.STAT_CHG_DATE%TYPE DEFAULT NULL
    )
	IS
        NUPERSONID    GE_PERSON.PERSON_ID%TYPE;
        DTEXEINITIALDATE  OR_ORDER.EXEC_INITIAL_DATE%TYPE;
        DTEXEFINALDATE  OR_ORDER.EXECUTION_FINAL_DATE%TYPE;

		
        
        PROCEDURE INITOUTPUTDATA
        IS
        BEGIN
        
            GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE, OSBERRORMESSAGE);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        
        END;

        
        PROCEDURE VALINPUTDATA
        IS
        BEGIN

            NUPERSONID   := INUPERSONID;
            DTEXEINITIALDATE := IDTEXEINITIALDATE;
            DTEXEFINALDATE := IDTEXEFINALDATE;

        	OR_BOEXTERNALLEGALIZEACTIVITY.VALIDATEORDERDATALEGA

            (
                INUORDERID,
                INUCAUSALID,
                NUPERSONID,
                DTEXEINITIALDATE,
                DTEXEFINALDATE
            );

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        
        END;

        
        PROCEDURE RUNPROCESS
        IS
        BEGIN
        

            OR_BOEXTERNALLEGALIZEACTIVITY.LEGALIZEORDER
            (
                INUORDERID,
                INUCAUSALID,
                NUPERSONID,
                DTEXEINITIALDATE,
                DTEXEFINALDATE,
                ISBCOMMENT,
                NULL,
                NULL,
                IDTCHANGEDATE
            );

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        
        END;


	BEGIN
        
        UT_TRACE.TRACE('OR_BSExternalLegalizeActivity.LegalizeOrder INICIO',1);

        
        INITOUTPUTDATA;

        
        VALINPUTDATA;

        
        RUNPROCESS;

        UT_TRACE.TRACE('OR_BSExternalLegalizeActivity.LegalizeOrder FIN',1);


    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    END;
    


END OR_BSEXTERNALLEGALIZEACTIVITY;