PACKAGE BODY Or_bcPlannedActivit
IS
	
	CSBVERSION     CONSTANT VARCHAR2(20)  := 'SAO208344';
	
    CURSOR CUPLANNEDACTIVITIES
    IS
    SELECT A.*
    FROM OR_PLANNED_ACTIVIT A;

    TBPLANACTBYACTCONF      TYTBPLANACTBYACTCONF;

	
	
	FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;
	
    PROCEDURE GETALLPLANACTCONF
    (
        OTBPLANACTBYACTCONF     OUT TYTBPLANACTBYACTCONF
    )
    IS
    BEGIN
        OTBPLANACTBYACTCONF := TBPLANACTBYACTCONF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    
























    PROCEDURE GETPLANACTCONFBYACT
    (
        INUACTIVITYID           IN  OR_PLANNED_ACTIVIT.ACTIVITY_ID%TYPE,
        OTBPLANACTCONF          OUT TYTBPLANACTCONF
    )
    IS
        TBNULL TYTBPLANACTCONF;
    BEGIN

        IF TBPLANACTBYACTCONF.EXISTS(INUACTIVITYID) THEN
            OTBPLANACTCONF := TBPLANACTBYACTCONF(INUACTIVITYID);
        ELSE
            OTBPLANACTCONF := TBNULL;
        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETPLANACTCONFBYACT;
    
    
    PROCEDURE LOAD
    IS
        NUINDEX                 NUMBER := 1;
        TBPLANACTCONF           TYTBPLANACTCONF;
    BEGIN

        FOR RCPLANACT IN CUPLANNEDACTIVITIES LOOP
            
            IF TBPLANACTBYACTCONF.EXISTS(RCPLANACT.ACTIVITY_ID) THEN
                NUINDEX := TBPLANACTBYACTCONF(RCPLANACT.ACTIVITY_ID).COUNT+1;
            ELSE
                NUINDEX := 1;
            END IF;
            
            TBPLANACTBYACTCONF(RCPLANACT.ACTIVITY_ID)(NUINDEX).NUACTIVITYID        := RCPLANACT.ACTIVITY_ID;
            TBPLANACTBYACTCONF(RCPLANACT.ACTIVITY_ID)(NUINDEX).NUPLANNEDACTIVITYID := RCPLANACT.PLANNED_ACTIVITY_ID;
            TBPLANACTBYACTCONF(RCPLANACT.ACTIVITY_ID)(NUINDEX).SBREQUIRED          := RCPLANACT.REQUIRED;
            TBPLANACTBYACTCONF(RCPLANACT.ACTIVITY_ID)(NUINDEX).NUSEQUENCE          := RCPLANACT.SEQUENCE_;
            NUINDEX := NUINDEX + 1;
        END LOOP;
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END LOAD;
    




    FUNCTION FRFGETPLANACTCONFBYACT
    (
        INUACTIVITYID   IN  OR_PLANNED_ACTIVIT.ACTIVITY_ID%TYPE,
        INUORDERID      IN  OR_ORDER.ORDER_ID%TYPE,
        INUOPERUNITID   IN  OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        IDTASSIGNEDDATE IN  OR_ORDER.ASSIGNED_DATE%TYPE
    )
    RETURN CONSTANTS.TYREFCURSOR
    IS
        CURFGETDATA   CONSTANTS.TYREFCURSOR;
    BEGIN
        OPEN CURFGETDATA FOR
            SELECT OR_PLANNED_ACTIVIT.PLANNED_ACTIVITY_ID, OR_PLANNED_ACTIVIT.ACTIVITY_ID, GE_ITEMS.DESCRIPTION,
                   OR_PLANNED_ACTIVIT.REQUIRED, OR_PLANNED_ACTIVIT.SEQUENCE_,
                   OR_BOITEMVALUE.FNUGETITEMVALUEPLANNEDORDER(PLANNED_ACTIVITY_ID, INUORDERID, INUOPERUNITID, IDTASSIGNEDDATE) ACTIVITY_COST
              FROM OR_PLANNED_ACTIVIT, GE_ITEMS
             WHERE OR_PLANNED_ACTIVIT.PLANNED_ACTIVITY_ID = GE_ITEMS.ITEMS_ID
               AND OR_PLANNED_ACTIVIT.ACTIVITY_ID =  INUACTIVITYID
            ORDER BY GE_ITEMS.ITEMS_ID;
            
        RETURN CURFGETDATA;
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FRFGETPLANACTCONFBYACT;
    
    
    
    
    
    FUNCTION FNUGETPLANNEDACT(INUACTIVITYID IN GE_ITEMS.ITEMS_ID%TYPE)
    RETURN NUMBER
    IS
        NUCOUNT NUMBER := 0;
    BEGIN
        SELECT COUNT('x') INTO NUCOUNT
            FROM OR_PLANNED_ACTIVIT
            WHERE ACTIVITY_ID = INUACTIVITYID;

        RETURN NUCOUNT;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETPLANNEDACT;


    
    
    
    FUNCTION FBLISPLANNEDACT(INUACTIVITYID IN GE_ITEMS.ITEMS_ID%TYPE)
    RETURN BOOLEAN
    IS
        NUCOUNT NUMBER := 0;
        CURSOR CUGETPLANNED IS
        SELECT 1 CONTADOR
            FROM OR_PLANNED_ACTIVIT
            WHERE PLANNED_ACTIVITY_ID = INUACTIVITYID
            AND ROWNUM = 1;
        
    BEGIN
        OPEN  CUGETPLANNED;
        FETCH CUGETPLANNED  INTO NUCOUNT ;
        CLOSE CUGETPLANNED;

        RETURN (NVL(NUCOUNT,0) <> 0);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBLISPLANNEDACT;
    
    




    FUNCTION FNUGETAMOUNTPLANNEDACT
    (
        INUORDERACTIVITYID  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE
    )
    RETURN NUMBER
    IS
        NUCONT      NUMBER := 0;
    BEGIN

        SELECT  --+ index(or_planned_items IDX_OR_PLANNED_ITEMS_02)
                COUNT(1) INTO NUCONT
        FROM    OR_PLANNED_ITEMS /*+ Or_bcPlannedActivit.fnuGetAmountPlannedAct SAO187664 */
        WHERE   OR_PLANNED_ITEMS.ORDER_ACTIVITY_ID = INUORDERACTIVITYID;

        RETURN  NUCONT;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETAMOUNTPLANNEDACT;

    




    FUNCTION FRFGETPLANNEDBYORDERACT
    (
        INUORDERACTIVITYID  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE
    )
    RETURN CONSTANTS.TYREFCURSOR
    IS
        RFCURDATA   CONSTANTS.TYREFCURSOR;
    BEGIN

        OPEN RFCURDATA
        FOR
            SELECT  --+ index(or_planned_items IDX_OR_PLANNED_ITEMS_02)
                    PLANNED_ORDER_ID,
                    ITEMS_ID,
                    ITEM_AMOUNT,
                    VALUE,
                    ELEMENT_ID,
                    ELEMENT_CODE
            FROM    OR_PLANNED_ITEMS  /*+ Or_bcPlannedActivit.frfGetPlannedByOrderAct SAO187664 */
            WHERE   OR_PLANNED_ITEMS.ORDER_ACTIVITY_ID = INUORDERACTIVITYID;

        RETURN RFCURDATA;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(RFCURDATA);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(RFCURDATA);
            RAISE EX.CONTROLLED_ERROR;
    END FRFGETPLANNEDBYORDERACT;

    




    FUNCTION FNUGETVALUEPLANNEDACTIV
    (
        INUPACKAGEID  IN  OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE
    )
    RETURN NUMBER
    IS
        NUCONT      NUMBER := 0;
    BEGIN

        SELECT  /*+ index(OR_order_activity IDX_OR_ORDER_ACTIVITY_06)
                    index(or_planned_items IDX_OR_PLANNED_ITEMS_02)
                */
                SUM(VALUE * ITEM_AMOUNT) INTO NUCONT
        FROM    OR_ORDER_ACTIVITY, OR_PLANNED_ITEMS /*+ Or_bcPlannedActivit.fnuGetValuePlannedActiv SAO195661 */
        WHERE   OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID = OR_PLANNED_ITEMS.ORDER_ACTIVITY_ID
        AND     OR_ORDER_ACTIVITY.STATUS = OR_BOCONSTANTS.CSBPLANNEDSTATUS
        AND     OR_ORDER_ACTIVITY.PACKAGE_ID = INUPACKAGEID;
        
        RETURN NUCONT;
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    
    
    BEGIN
        LOAD;
    
END OR_BCPLANNEDACTIVIT;