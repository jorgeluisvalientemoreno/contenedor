PACKAGE BODY OR_BOCreateActivityAuton
IS















    
    CSBVERSION CONSTANT VARCHAR2(20) := 'SAO202833';

    

   	

    
    FUNCTION FSBVERSION RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    
    PROCEDURE GETACTIVITIESLOV
    (
        ISBCONCATSYMBOL IN  VARCHAR2,
        ORFRESULT       OUT CONSTANTS.TYREFCURSOR
    )
	IS
	BEGIN
        ORFRESULT := OR_BCCREATEACTIVITYAUTON.FRFGETACTIVITIESLOV(ISBCONCATSYMBOL);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
	END GETACTIVITIESLOV;
	
	
    PROCEDURE GETCREATEDORDERS
    (
        INUACTIVITYGROUPID IN  OR_ORDER_ACTIVITY.ACTIVITY_GROUP_ID%TYPE,
        ORFRESULT          OUT CONSTANTS.TYREFCURSOR
    )
	IS
	BEGIN
        ORFRESULT := OR_BCCREATEACTIVITYAUTON.FRFGETCREATEDORDERS(INUACTIVITYGROUPID);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
	END GETCREATEDORDERS;
	
    


















    PROCEDURE COPYPLANNEDITEMS
    (
        INUORDERACTIVITYID      OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUORDERID              OR_ORDER_ACTIVITY.ORDER_ID%TYPE
    )
    IS
        RCORDERITEMS        DAOR_ORDER_ITEMS.STYOR_ORDER_ITEMS;

        CURSOR CUPLANITBYORDACT
        (
            INUORDERACTIVITYID      OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE
        )   IS
        SELECT *
        FROM OR_PLANNED_ITEMS
        WHERE ORDER_ACTIVITY_ID = INUORDERACTIVITYID;

    BEGIN
        FOR RCPLANITEMS IN CUPLANITBYORDACT(INUORDERACTIVITYID) LOOP
            RCORDERITEMS.ORDER_ITEMS_ID         := OR_BOSEQUENCES.FNUNEXTOR_ORDER_ITEMS;

            RCORDERITEMS.ORDER_ID               := INUORDERID;
            RCORDERITEMS.ORDER_ACTIVITY_ID      := INUORDERACTIVITYID;
            RCORDERITEMS.ASSIGNED_ITEM_AMOUNT   := RCPLANITEMS.ITEM_AMOUNT;
            RCORDERITEMS.ITEMS_ID               := RCPLANITEMS.ITEMS_ID;
            RCORDERITEMS.ELEMENT_ID             := RCPLANITEMS.ELEMENT_ID;
            RCORDERITEMS.ELEMENT_CODE           := RCPLANITEMS.ELEMENT_CODE;
            RCORDERITEMS.VALUE                  := RCPLANITEMS.VALUE;
            RCORDERITEMS.TOTAL_PRICE            := 0;

            DAOR_ORDER_ITEMS.INSRECORD(RCORDERITEMS);
        END LOOP;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    





















    PROCEDURE ACTIVATEACTIVITY
    (
        INUACTIVITYID   IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE
    )
    IS
        RCORDERACTIVITY         DAOR_ORDER_ACTIVITY.STYOR_ORDER_ACTIVITY;
        ONUORDERID              OR_ORDER_ACTIVITY.ORDER_ID%TYPE;
        NUORDERACTIVITYID       OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;

    BEGIN
        RCORDERACTIVITY := DAOR_ORDER_ACTIVITY.FRCGETRECORD(INUACTIVITYID);
        ONUORDERID := NULL;
        NUORDERACTIVITYID := RCORDERACTIVITY.ORDER_ACTIVITY_ID;

        UT_TRACE.TRACE('[activateActivity] nuOrderActivityId: ['||NUORDERACTIVITYID||']', 3);
        UT_TRACE.TRACE('[activateActivity] operating_sector_id: ['||RCORDERACTIVITY.OPERATING_SECTOR_ID||']',3);

        OR_BOORDERACTIVITIES.CREATEACTIVITY (
                                            RCORDERACTIVITY.ACTIVITY_ID,
                                            RCORDERACTIVITY.PACKAGE_ID,
                                            RCORDERACTIVITY.MOTIVE_ID,
                                            RCORDERACTIVITY.COMPONENT_ID,
                                            RCORDERACTIVITY.INSTANCE_ID,
                                            RCORDERACTIVITY.ADDRESS_ID,
                                            RCORDERACTIVITY.ELEMENT_ID,
                                            RCORDERACTIVITY.SUBSCRIBER_ID,
                                            RCORDERACTIVITY.SUBSCRIPTION_ID,
                                            RCORDERACTIVITY.PRODUCT_ID,
                                            RCORDERACTIVITY.OPERATING_SECTOR_ID,
                                            RCORDERACTIVITY.OPERATING_UNIT_ID,
                                            RCORDERACTIVITY.EXEC_ESTIMATE_DATE,
                                            RCORDERACTIVITY.PROCESS_ID,
                                            RCORDERACTIVITY.COMMENT_,
                                            FALSE,      
                                            NULL,       
                                            ONUORDERID,
                                            NUORDERACTIVITYID,
                                            NULL, 
                                            GE_BOCONSTANTS.CSBYES, 
                                            NULL, 
                                            NULL, 
                                            NULL, 
                                            0     
                                            );

        
        
        OR_BOPROCESSORDER.PROCESSORDER(
                    ONUORDERID,
                    RCORDERACTIVITY.OPERATING_SECTOR_ID,
                    RCORDERACTIVITY.OPERATING_UNIT_ID,
                    RCORDERACTIVITY.EXEC_ESTIMATE_DATE,
                    TRUE);

        
        GE_BONOTIFMESGALERT.PROCSTAORDERFORALERT( DAOR_ORDER.FRCGETRECORD(ONUORDERID), NULL);

        UT_TRACE.TRACE('[activateActivity] Finaliza. onuOrderId: ['||ONUORDERID||']',3);

        
        COPYPLANNEDITEMS(NUORDERACTIVITYID, ONUORDERID);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    













    PROCEDURE LOCKBYACTIGROUP
    (
        INUACTIVITYGROUPID   IN  OR_ORDER_ACTIVITY.ACTIVITY_GROUP_ID%TYPE
    )
    IS
        RCOR_ORDER_ACTIVITY DAOR_ORDER_ACTIVITY.STYOR_ORDER_ACTIVITY;

        CURSOR CULOCKBYACTIGROUP
        (
            INUACTIVITYGROUPID   IN  OR_ORDER_ACTIVITY.ACTIVITY_GROUP_ID%TYPE
        )   IS
            SELECT OR_ORDER_ACTIVITY.*,OR_ORDER_ACTIVITY.ROWID
            FROM OR_ORDER_ACTIVITY
            WHERE ACTIVITY_GROUP_ID = INUACTIVITYGROUPID
            FOR UPDATE NOWAIT;

    BEGIN
        IF INUACTIVITYGROUPID IS NULL THEN
            RETURN ;
        END IF;

        OPEN CULOCKBYACTIGROUP(INUACTIVITYGROUPID);

        FETCH CULOCKBYACTIGROUP INTO RCOR_ORDER_ACTIVITY;
        IF CULOCKBYACTIGROUP%NOTFOUND  THEN
        	CLOSE CULOCKBYACTIGROUP;
        	RAISE NO_DATA_FOUND;
        END IF;
        CLOSE CULOCKBYACTIGROUP ;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    


















    PROCEDURE ACTIVATEACTEXEC
    (
        INUACTIVITYGROUPID      IN  OR_ORDER_ACTIVITY.ACTIVITY_GROUP_ID%TYPE
    )
    IS
        TBACTIVITIESBYGROUP     DAOR_ORDER_ACTIVITY.TYTBACTIVITY_ID;
        NUMINSEQUENCE           OR_ORDER_ACTIVITY.SEQUENCE_%TYPE;
        NUINDEX                 NUMBER := 1;
    BEGIN

        IF INUACTIVITYGROUPID IS NULL THEN
            RETURN;
        END IF;
        
        LOCKBYACTIGROUP(INUACTIVITYGROUPID);

        NUMINSEQUENCE := OR_BCORDERACTIVITIES.FNUGETMINSEQBYGROUP(INUACTIVITYGROUPID,OR_BOORDERACTIVITIES.CSBPLANNEDSTATUS);

        OR_BCORDERACTIVITIES.GETACTIVITYBYGROUP(INUACTIVITYGROUPID,
                                                OR_BOORDERACTIVITIES.CSBPLANNEDSTATUS,
                                                NUMINSEQUENCE,
                                                TBACTIVITIESBYGROUP);

        
        
        IF TBACTIVITIESBYGROUP.COUNT = 0 THEN
            UT_TRACE.TRACE('No hay actividades planeaadas ',10);
            RETURN;
        END IF;
        NUINDEX := TBACTIVITIESBYGROUP.FIRST;

        WHILE NUINDEX IS NOT NULL LOOP
            ACTIVATEACTIVITY(TBACTIVITIESBYGROUP(NUINDEX));
            NUINDEX := TBACTIVITIESBYGROUP.NEXT(NUINDEX);
        END LOOP;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    
END OR_BOCREATEACTIVITYAUTON;