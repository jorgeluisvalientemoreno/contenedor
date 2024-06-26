PACKAGE OR_BSLegalizeActivities IS




























	FUNCTION FSBVERSION  RETURN VARCHAR2;
	
    




















    PROCEDURE GETORDERITEMS
    (
        INUORDERID      IN OR_ORDER.ORDER_ID%TYPE,
        INUTASKTYPEID   IN OR_ORDER.TASK_TYPE_ID%TYPE,
        ORFQUERY        OUT CONSTANTS.TYREFCURSOR,
        ONUERRORCODE        OUT NUMBER,
        OSBERRORMESSAGE     OUT VARCHAR2
    );
	
	
    



























    PROCEDURE LEGALIZEORDER
    (
        INUORDER        IN  OR_ORDER.ORDER_ID%TYPE,
        INUPERSON       IN  GE_PERSON.PERSON_ID%TYPE,
        INUCAUSALID     IN  OR_ORDER.CAUSAL_ID%TYPE,
        IDTEXEINIDAT    IN  OR_ORDER.EXEC_INITIAL_DATE%TYPE,
        IDTEXEFINDAT    IN  OR_ORDER.EXECUTION_FINAL_DATE%TYPE,
        INUTASKTYPEID   IN  OR_ORDER.TASK_TYPE_ID%TYPE,
        ISBOLDMODE      IN  VARCHAR2,
        ONUERRORCODE    OUT NUMBER,
        OSBERRORMESSAGE OUT VARCHAR2
    );
    
    





    PROCEDURE LEGALIZEORDERBYTEXTLINE
    (
        ISBDATAORDER            IN  VARCHAR2,
        IDTINITDATE             IN  OR_ORDER.EXEC_INITIAL_DATE%TYPE,
        IDTFINALDATE            IN  OR_ORDER.EXECUTION_FINAL_DATE%TYPE,
        ONUERRORCODE            OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBERRORMESSAGE         OUT GE_ERROR_LOG.DESCRIPTION%TYPE,
        IDTCHANGEDATE           IN OR_ORDER_STAT_CHANGE.STAT_CHG_DATE%TYPE DEFAULT NULL
    );
    
    




    PROCEDURE CLOSEORDERBYXML
    (
        ICLDATA             IN      UT_DATATYPES.STYCLOB,
        ONUERRORCODE        OUT     GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBERRORMESSAGE     OUT     GE_ERROR_LOG.DESCRIPTION%TYPE
    );
    
END OR_BSLEGALIZEACTIVITIES;



PACKAGE BODY OR_BSLegalizeActivities IS



























    CSBVERSION   CONSTANT VARCHAR2(20) := 'SAO522903';
    
    
    CNUREGULAR_TRC_LEVEL    CONSTANT NUMBER := 10;
    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;
    
    
    
    
    PROCEDURE GETORDERITEMS
    (
        INUORDERID      IN OR_ORDER.ORDER_ID%TYPE,
        INUTASKTYPEID   IN OR_ORDER.TASK_TYPE_ID%TYPE,
        ORFQUERY        OUT CONSTANTS.TYREFCURSOR,
        ONUERRORCODE        OUT NUMBER,
        OSBERRORMESSAGE     OUT VARCHAR2
    ) IS
    BEGIN
        
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE, OSBERRORMESSAGE);

        OR_BOLEGALIZEACTIVITIES.GETORDERITEMS
        (
            INUORDERID,
            INUTASKTYPEID,
            ORFQUERY
        );

    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE,OSBERRORMESSAGE);
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE,OSBERRORMESSAGE);
    END;

    
    
    
    PROCEDURE LEGALIZEORDER
    (
        INUORDER        IN  OR_ORDER.ORDER_ID%TYPE,
        INUPERSON       IN  GE_PERSON.PERSON_ID%TYPE,
        INUCAUSALID     IN  OR_ORDER.CAUSAL_ID%TYPE,
        IDTEXEINIDAT    IN  OR_ORDER.EXEC_INITIAL_DATE%TYPE,
        IDTEXEFINDAT    IN  OR_ORDER.EXECUTION_FINAL_DATE%TYPE,
        INUTASKTYPEID   IN  OR_ORDER.TASK_TYPE_ID%TYPE,
        ISBOLDMODE      IN  VARCHAR2,
        ONUERRORCODE    OUT NUMBER,
        OSBERRORMESSAGE OUT VARCHAR2
    )
    IS
    BEGIN
        
        ERRORS.SETAPPLICATION('ORPLO');
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE, OSBERRORMESSAGE);
        OR_BOLEGALIZEACTIVITIES.LEGALIZEORDER(INUORDER,INUPERSON,INUCAUSALID,IDTEXEINIDAT,IDTEXEFINDAT,INUTASKTYPEID);

    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE,OSBERRORMESSAGE);
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE,OSBERRORMESSAGE);
    END LEGALIZEORDER;
    
    


























    PROCEDURE LEGALIZEORDERBYTEXTLINE
    (
        ISBDATAORDER            IN  VARCHAR2,
        IDTINITDATE             IN  OR_ORDER.EXEC_INITIAL_DATE%TYPE,
        IDTFINALDATE            IN  OR_ORDER.EXECUTION_FINAL_DATE%TYPE,
        ONUERRORCODE            OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBERRORMESSAGE         OUT GE_ERROR_LOG.DESCRIPTION%TYPE,
        IDTCHANGEDATE           IN OR_ORDER_STAT_CHANGE.STAT_CHG_DATE%TYPE DEFAULT NULL
    )
    IS
        SBISADMINORDER      VARCHAR2(1);
        NUORDERID           OR_ORDER.ORDER_ID%TYPE;
        NUPERSONID          GE_PERSON.PERSON_ID%TYPE;
        NUCAUSALID          OR_ORDER.CAUSAL_ID%TYPE;
        NUOPERUNITID        OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE;
        TBLINE              UT_STRING.TYTB_STRING;

        
        NUCOL_COMMENT_ADM   NUMBER(1) := 3;
    BEGIN
        UT_TRACE.TRACE('INICIO OR_BSLegalizeActivities.LegalizeOrderByTextLine', 2 );
        
        
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE, OSBERRORMESSAGE);

        
        OR_BOACTIVITIESLEGALIZEBYFILE.VALIDINITDATATOLEGALBYFILE
        (
            ISBDATAORDER,
            IDTINITDATE,
            IDTFINALDATE,
            SBISADMINORDER,
            NUORDERID,
            NUPERSONID,
            NUCAUSALID,
            NUOPERUNITID,
            TBLINE,
            ONUERRORCODE,
            OSBERRORMESSAGE
        );
        
        IF ONUERRORCODE = GE_BOCONSTANTS.CNUSUCCESS THEN

            
            
            
            IF (SBISADMINORDER = GE_BOCONSTANTS.CSBYES) THEN

                OR_BOACTIVITIESLEGALIZEBYFILE.LEGALIZEORDERADM
                    (
                        NUORDERID,
                        NUCAUSALID,
                        TBLINE(NUCOL_COMMENT_ADM),
                        ONUERRORCODE,
                        OSBERRORMESSAGE
                    );
            ELSE
                OR_BOACTIVITIESLEGALIZEBYFILE.LEGALIZEORDERBYLINE
                    (
                        NUORDERID,
                        NUPERSONID,
                        NUCAUSALID,
                        NUOPERUNITID,
                        IDTINITDATE,
                        IDTFINALDATE,
                        TBLINE,
                        ONUERRORCODE,
                        OSBERRORMESSAGE,
                        IDTCHANGEDATE
                    );
            END IF;

        END IF;

        ONUERRORCODE := NVL(ONUERRORCODE,GE_BOCONSTANTS.CNUSUCCESS);
        
        UT_TRACE.TRACE('FIN OR_BSLegalizeActivities.LegalizeOrderByTextLine', 2 );

    EXCEPTION
    	WHEN EX.CONTROLLED_ERROR THEN
    		ERRORS.GETERROR(ONUERRORCODE,OSBERRORMESSAGE);
    	WHEN OTHERS THEN
    		ERRORS.SETERROR;
    		ERRORS.GETERROR(ONUERRORCODE,OSBERRORMESSAGE);
    END LEGALIZEORDERBYTEXTLINE;
    
    

























































































































































    PROCEDURE CLOSEORDERBYXML
    (
        ICLDATA             IN      UT_DATATYPES.STYCLOB,
        ONUERRORCODE        OUT     GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBERRORMESSAGE     OUT     GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS
        














        PROCEDURE VALIDATEXML
        IS
            XMLDOCUMENT XMLTYPE;
        BEGIN
            UT_TRACE.TRACE('BEGIN OR_BSLegalizeActivities.CloseOrderByXML.ValidateXML', CNUREGULAR_TRC_LEVEL);
            
            
            XMLDOCUMENT := XMLTYPE(ICLDATA);

            
            UT_XMLPARSE.VALSCHEMA
            (
                XMLDOCUMENT,
                OR_BOCLOSEORDERBYXML.CSBCLOSE_ORDER_XSD_DEF
            );

            UT_TRACE.TRACE('END OR_BSLegalizeActivities.CloseOrderByXML.ValidateXML', CNUREGULAR_TRC_LEVEL);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                UT_TRACE.TRACE('ex.CONTROLLED_ERROR - OR_BSLegalizeActivities.CloseOrderByXML.ValidateXML', CNUREGULAR_TRC_LEVEL);
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                UT_TRACE.TRACE('others - OR_BSLegalizeActivities.CloseOrderByXML.ValidateXML', CNUREGULAR_TRC_LEVEL);
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END VALIDATEXML;

    BEGIN
        UT_TRACE.TRACE('BEGIN OR_BSLegalizeActivities.CloseOrderByXML', CNUREGULAR_TRC_LEVEL);

        
        OR_BOCLOSEORDERBYXML.INITIALIZEOUTPUT(ONUERRORCODE, OSBERRORMESSAGE);

        
        VALIDATEXML;

        
        OR_BOCLOSEORDERBYXML.CLOSEORDERBYXML(ICLDATA);

        UT_TRACE.TRACE('END OR_BSLegalizeActivities.CloseOrderByXML', CNUREGULAR_TRC_LEVEL);

    EXCEPTION
    	WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR - OR_BSLegalizeActivities.CloseOrderByXML', CNUREGULAR_TRC_LEVEL);
    		ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    	WHEN OTHERS THEN
            UT_TRACE.TRACE('others - OR_BSLegalizeActivities.CloseOrderByXML', CNUREGULAR_TRC_LEVEL);
    		ERRORS.SETERROR;
    		ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    END CLOSEORDERBYXML;

END OR_BSLEGALIZEACTIVITIES;