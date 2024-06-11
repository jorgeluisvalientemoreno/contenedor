PACKAGE BODY CT_BCLiquidationSupport
AS
    



















































































    
    
    

    
    
    
    CSBVERSION       CONSTANT VARCHAR2(250)  := 'SAO386280';
    
    
    

    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    












































    PROCEDURE GETORDERITEMS
    (
        INUORDERID          IN            OR_ORDER_ITEMS.ORDER_ID%TYPE,
        INUGEOLOCID         IN            AB_ADDRESS.ADDRESS_ID%TYPE,
        OTBORDERITEMS       IN OUT NOCOPY TYTBORDERITEMSINFO
    )
    IS

        CURSOR CUORDERITEMS IS
            SELECT  /*+ ORDERED
                    INDEX(OR_ORDER PK_OR_ORDER )
                    INDEX(OR_ORDER_ITEMS IDX_OR_ORDER_ITEMS_01)
                    INDEX(GE_ITEMS PK_GE_ITEMS)
                    INDEX(OR_ORDER_ACTIVITY UX_OR_ORDER_ACTIVITY01)
                    USE_NL(OR_ORDER OR_ORDER_ITEMS)
                    USE_NL(OR_ORDER_ITEMS GE_ITEMS)
                    USE_NL(OR_ORDER_ITEMS OR_ORDER_ACTIVITY)*/
                    OR_ORDER_ITEMS.ORDER_ID,
                    OR_ORDER_ITEMS.ITEMS_ID,
                    OR_ORDER_ITEMS.ASSIGNED_ITEM_AMOUNT,
                    OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT,
                    OR_ORDER_ITEMS.VALUE,
                    OR_ORDER_ITEMS.ORDER_ITEMS_ID,
                    OR_ORDER_ITEMS.TOTAL_PRICE,
                    OR_ORDER_ITEMS.ELEMENT_CODE,
                    OR_ORDER_ITEMS.ORDER_ACTIVITY_ID,
                    OR_ORDER_ITEMS.ELEMENT_ID,
                    OR_ORDER_ITEMS.REUSED,
                    OR_ORDER_ITEMS.SERIAL_ITEMS_ID,
                    OR_ORDER_ITEMS.SERIE,
                    OR_ORDER_ITEMS.OUT_,
                    OR_ORDER_ACTIVITY.VALUE_REFERENCE,
                    GE_ITEMS.ITEM_CLASSIF_ID,
                    1,
                    OR_ORDER.ASSIGNED_DATE,
                    OR_ORDER.LEGALIZATION_DATE,
                    OR_ORDER.EXECUTION_FINAL_DATE,
                    OR_ORDER.OPERATING_UNIT_ID,
                    DECODE
                    (
                        OR_ORDER_ACTIVITY.ADDRESS_ID,
                        NULL,
                        INUGEOLOCID,
                        (
                            SELECT  /*+ INDEX (AB_ADDRESS PK_AB_ADDRESS)*/
                                    AB_ADDRESS.GEOGRAP_LOCATION_ID
                            FROM    AB_ADDRESS
                            WHERE   AB_ADDRESS.ADDRESS_ID = OR_ORDER_ACTIVITY.ADDRESS_ID
                        )
                    ) GEOGRAP_LOCATION_ID,
                    1,
                    GE_ITEMS.DESCRIPTION,
                    GE_ITEMS.MEASURE_UNIT_ID ,
                    DECODE(CT_EXCL_ITEM_CONT_VAL.ITEMS_ID, NULL, 'Y', 'N' ) AFFECT_CONTRACT_VAL
            FROM    /*+ CT_BCLIQUIDATIONSUPPORT.GETORDERITEMS.SAO209517*/
                    OR_ORDER,
                    OR_ORDER_ITEMS,
                    GE_ITEMS,
                    OR_ORDER_ACTIVITY,
                    CT_EXCL_ITEM_CONT_VAL
            WHERE   OR_ORDER.ORDER_ID = INUORDERID
            AND     OR_ORDER_ITEMS.ORDER_ID = OR_ORDER.ORDER_ID
            AND     GE_ITEMS.ITEMS_ID = OR_ORDER_ITEMS.ITEMS_ID
            AND     GE_ITEMS.ITEMS_ID = CT_EXCL_ITEM_CONT_VAL.ITEMS_ID (+)
            AND     OR_ORDER_ITEMS.ORDER_ITEMS_ID = OR_ORDER_ACTIVITY.ORDER_ITEM_ID(+)
            AND     OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT > 0;

    BEGIN
       

        OPEN CUORDERITEMS;
        FETCH CUORDERITEMS BULK COLLECT INTO OTBORDERITEMS;
        CLOSE CUORDERITEMS;

        

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (CUORDERITEMS%ISOPEN)THEN
                CLOSE  CUORDERITEMS;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (CUORDERITEMS%ISOPEN)THEN
                CLOSE  CUORDERITEMS;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
  END GETORDERITEMS;
  
    






















    PROCEDURE GETCERTDETAILS
    (
        INUCERTIFICATEID        IN            GE_ACTA.ID_ACTA%TYPE,
        OTBCERTDETAILS          IN OUT NOCOPY DAGE_DETALLE_ACTA.TYTBGE_DETALLE_ACTA
    )
    IS

        CURSOR CUCERTDETAILS IS
            SELECT  GE_DETALLE_ACTA.*,
                    GE_DETALLE_ACTA.ROWID
            FROM    GE_DETALLE_ACTA
            WHERE   ID_ACTA = INUCERTIFICATEID;

    BEGIN
       UT_TRACE.TRACE('BEGIN CT_BCLiquidationSupport.GetCertDetails', 2);

        OPEN CUCERTDETAILS;
        FETCH CUCERTDETAILS BULK COLLECT INTO OTBCERTDETAILS;
        CLOSE CUCERTDETAILS;

        UT_TRACE.TRACE('END CT_BCLiquidationSupport.GetCertDetails', 2);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (CUCERTDETAILS%ISOPEN)THEN
                CLOSE  CUCERTDETAILS;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (CUCERTDETAILS%ISOPEN)THEN
                CLOSE  CUCERTDETAILS;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
  END GETCERTDETAILS;
  
  




















    PROCEDURE GETAUTOMORDERSNONUSE
    (
        OTBORDERS       IN OUT NOCOPY DAOR_ORDER.TYTBORDER_ID,
        INUCONTRACT     IN            GE_CONTRATO.ID_CONTRATO%TYPE
    )
    IS

        SVDATAVALUES   OR_ORDER.SAVED_DATA_VALUES%TYPE := CT_BOCONSTANTS.FSBSAVEDDATAVALUEAUTO;
        
        
        CURSOR CUAUTOMORDERSNONUSE IS
             SELECT /*+index(or_order IDX_OR_ORDER21)*/
                    OR_ORDER.ORDER_ID
             FROM   OR_ORDER
                    /*+ CT_BCLiquidationSupport.GetAutomOrdersNonUse*/
             WHERE
                    
                    OR_ORDER.DEFINED_CONTRACT_ID = INUCONTRACT
             AND    OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES
             AND    OR_ORDER.SAVED_DATA_VALUES = SVDATAVALUES;
    BEGIN

        OPEN CUAUTOMORDERSNONUSE;
        FETCH CUAUTOMORDERSNONUSE BULK COLLECT INTO OTBORDERS;
        CLOSE CUAUTOMORDERSNONUSE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETAUTOMORDERSNONUSE;
    
    
















    PROCEDURE UPDAUTORDERSIMPLE
    (
        INUORDERID  IN  OR_ORDER.ORDER_ID%TYPE
    )
    IS
        SVDATAVALUES   OR_ORDER.SAVED_DATA_VALUES%TYPE := CT_BOCONSTANTS.FSBSAVEDDATAVALUEAUTO;
    BEGIN
        
        UPDATE  OR_ORDER
        SET     IS_PENDING_LIQ      = NULL,
                SAVED_DATA_VALUES   = SVDATAVALUES
        /*+ ct_bcliquidationsupport.updAutOrderSimple */
        WHERE   ORDER_ID = INUORDERID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDAUTORDERSIMPLE;
    
    




















    PROCEDURE GETCREATEDNOVELTYORDERS
    (
        INUORDERID      IN            OR_ORDER.ORDER_ID%TYPE,
        INUCONTRACTID   IN            OR_ORDER.DEFINED_CONTRACT_ID%TYPE,
        OTBORDERS       IN OUT NOCOPY CT_BCLIQUIDATIONSUPPORT.TYTBORDERS
    )
    IS
        SVDATAVALUES   OR_ORDER.SAVED_DATA_VALUES%TYPE := CT_BOCONSTANTS.FSBSAVEDDATAVALUEAUTO;
        
        CURSOR CUCREATEDNOVELTYORDERS IS
            SELECT  /*+ ordered
                        index (OR_related_order IDX_OR_RELATED_ORDER04)
                        index (b PK_OR_ORDER)*/
                    B.ROWID,
                    B.ORDER_ID,
                    B.PRIOR_ORDER_ID,
                    B.NUMERATOR_ID,
                    B.SEQUENCE,
                    B.PRIORITY,
                    B.EXTERNAL_ADDRESS_ID,
                    B.CREATED_DATE,
                    B.EXEC_INITIAL_DATE,
                    B.EXECUTION_FINAL_DATE,
                    B.EXEC_ESTIMATE_DATE,
                    B.ARRANGED_HOUR,
                    B.LEGALIZATION_DATE,
                    B.REPROGRAM_LAST_DATE,
                    B.ASSIGNED_DATE,
                    B.ASSIGNED_WITH,
                    B.MAX_DATE_TO_LEGALIZE,
                    B.ORDER_VALUE,
                    B.PRINTING_TIME_NUMBER,
                    B.LEGALIZE_TRY_TIMES,
                    B.OPERATING_UNIT_ID,
                    B.ORDER_STATUS_ID,
                    B.TASK_TYPE_ID,
                    B.OPERATING_SECTOR_ID,
                    B.CAUSAL_ID,
                    B.ADMINIST_DISTRIB_ID,
                    B.ORDER_CLASSIF_ID,
                    B.GEOGRAP_LOCATION_ID,
                    B.IS_COUNTERMAND,
                    B.REAL_TASK_TYPE_ID,
                    B.SAVED_DATA_VALUES,
                    B.FOR_AUTOMATIC_LEGA,
                    B.ORDER_COST_AVERAGE,
                    B.ORDER_COST_BY_LIST,
                    B.OPERATIVE_AIU_VALUE,
                    B.ADMIN_AIU_VALUE,
                    B.CHARGE_STATUS,
                    B.PREV_ORDER_STATUS_ID,
                    B.PROGRAMING_CLASS_ID,
                    B.PREVIOUS_WORK,
                    B.APPOINTMENT_CONFIRM,
                    B.X,
                    B.Y,
                    B.STAGE_ID,
                    B.LEGAL_IN_PROJECT,
                    B.OFFERED,
                    B.ASSO_UNIT_ID,
                    B.SUBSCRIBER_ID,
                    B.ADM_PENDING,
                    B.ROUTE_ID,
                    B.CONSECUTIVE,
                    B.DEFINED_CONTRACT_ID,
                    B.IS_PENDING_LIQ,
                    B.SCHED_ITINERARY_ID,
                    GE_BOCONSTANTS.CSBNO HASBILLING_ACTIVITY,
                    GE_BOCONSTANTS.CSBNO HASADJUSTMENTACTIVITY,
                    GE_BOCONSTANTS.CSBNO HASCONSIGMENT_ACTIVITY,
                    GE_BOCONSTANTS.CSBNO IS_NOVELTY,
                    DECODE
                    (
                        B.EXTERNAL_ADDRESS_ID,
                        NULL,
                        NULL,
                        (
                            SELECT  /*+ index (AB_ADDRESS PK_AB_ADDRESS)*/
                                    AB_ADDRESS.GEOGRAP_LOCATION_ID
                            FROM    AB_ADDRESS
                            WHERE   AB_ADDRESS.ADDRESS_ID = B.EXTERNAL_ADDRESS_ID
                        )
                    ) REAL_GEOGRA_LOCA
            FROM    OR_RELATED_ORDER,
                    OR_ORDER B
                    /*+ CT_BCLiquidationSupport.getCreatedNoveltyOrders SAO254854*/
            WHERE   
                    OR_RELATED_ORDER.ORDER_ID = INUORDERID
            AND     OR_RELATED_ORDER.RELA_ORDER_TYPE_ID IN (CT_BOCONSTANTS.CNUTRANS_TYPE_NOVE_ORDER, CT_BOCONSTANTS.CNUTRANS_TYPE_REVE_NOVE)
                    
            AND     B.ORDER_ID = OR_RELATED_ORDER.RELATED_ORDER_ID
            AND     B.DEFINED_CONTRACT_ID = INUCONTRACTID
            AND     B.SAVED_DATA_VALUES = SVDATAVALUES;
    BEGIN

        OPEN CUCREATEDNOVELTYORDERS;
        FETCH CUCREATEDNOVELTYORDERS BULK COLLECT INTO OTBORDERS;
        CLOSE CUCREATEDNOVELTYORDERS;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (CUCREATEDNOVELTYORDERS%ISOPEN) THEN
                CLOSE CUCREATEDNOVELTYORDERS;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (CUCREATEDNOVELTYORDERS%ISOPEN) THEN
                CLOSE CUCREATEDNOVELTYORDERS;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCREATEDNOVELTYORDERS;
    
    





















    PROCEDURE GETORDERSBLOCK
    (
        ITBORDERSTOPROCESS       IN OUT NOCOPY   CT_BCLIQUIDATIONSUPPORT.TYTBORDERS,
        ISBPIVOT                 IN OUT NOCOPY   TMP_VARCHAR.FIELD%TYPE
    )
    IS
        
        CURSOR CUALLORDERS IS
             SELECT /*+ ordered
                        index (TMP_VARCHAR  IDX_TMP_VARCHAR01)
                    */
                    TMP_VARCHAR.FIELD,
                    OR_ORDER.ORDER_ID,
                    OR_ORDER.PRIOR_ORDER_ID,
                    OR_ORDER.NUMERATOR_ID,
                    OR_ORDER.SEQUENCE,
                    OR_ORDER.PRIORITY,
                    OR_ORDER.EXTERNAL_ADDRESS_ID,
                    OR_ORDER.CREATED_DATE,
                    OR_ORDER.EXEC_INITIAL_DATE,
                    OR_ORDER.EXECUTION_FINAL_DATE,
                    OR_ORDER.EXEC_ESTIMATE_DATE,
                    OR_ORDER.ARRANGED_HOUR,
                    OR_ORDER.LEGALIZATION_DATE,
                    OR_ORDER.REPROGRAM_LAST_DATE,
                    OR_ORDER.ASSIGNED_DATE,
                    OR_ORDER.ASSIGNED_WITH,
                    OR_ORDER.MAX_DATE_TO_LEGALIZE,
                    OR_ORDER.ORDER_VALUE,
                    OR_ORDER.PRINTING_TIME_NUMBER,
                    OR_ORDER.LEGALIZE_TRY_TIMES,
                    OR_ORDER.OPERATING_UNIT_ID,
                    OR_ORDER.ORDER_STATUS_ID,
                    OR_ORDER.TASK_TYPE_ID,
                    OR_ORDER.OPERATING_SECTOR_ID,
                    OR_ORDER.CAUSAL_ID,
                    OR_ORDER.ADMINIST_DISTRIB_ID,
                    OR_ORDER.ORDER_CLASSIF_ID,
                    OR_ORDER.GEOGRAP_LOCATION_ID,
                    OR_ORDER.IS_COUNTERMAND,
                    OR_ORDER.REAL_TASK_TYPE_ID,
                    OR_ORDER.SAVED_DATA_VALUES,
                    OR_ORDER.FOR_AUTOMATIC_LEGA,
                    OR_ORDER.ORDER_COST_AVERAGE,
                    OR_ORDER.ORDER_COST_BY_LIST,
                    OR_ORDER.OPERATIVE_AIU_VALUE,
                    OR_ORDER.ADMIN_AIU_VALUE,
                    OR_ORDER.CHARGE_STATUS,
                    OR_ORDER.PREV_ORDER_STATUS_ID,
                    OR_ORDER.PROGRAMING_CLASS_ID,
                    OR_ORDER.PREVIOUS_WORK,
                    OR_ORDER.APPOINTMENT_CONFIRM,
                    OR_ORDER.X,
                    OR_ORDER.Y,
                    OR_ORDER.STAGE_ID,
                    OR_ORDER.LEGAL_IN_PROJECT,
                    OR_ORDER.OFFERED,
                    OR_ORDER.ASSO_UNIT_ID,
                    OR_ORDER.SUBSCRIBER_ID,
                    OR_ORDER.ADM_PENDING,
                    OR_ORDER.ROUTE_ID,
                    OR_ORDER.CONSECUTIVE,
                    OR_ORDER.DEFINED_CONTRACT_ID,
                    OR_ORDER.IS_PENDING_LIQ,
                    OR_ORDER.SCHED_ITINERARY_ID,
                    DECODE
                    (
                        (
                            SELECT /*+ index (or_order_activity IDX_OR_ORDER_ACTIVITY_05) */
                                    0
                            FROM    OR_ORDER_ACTIVITY
                            WHERE   OR_ORDER_ACTIVITY.ORDER_ID = OR_ORDER.ORDER_ID
                            AND     OR_ORDER_ACTIVITY.ACTIVITY_ID = GE_BOITEMSCONSTANTS.CNUBILLINGACTIVITY
                            AND     ROWNUM < 2
                        ),
                        0,
                        GE_BOCONSTANTS.CSBYES,
                        GE_BOCONSTANTS.CSBNO
                    ) HASBILLING_ACTIVITY,
                    DECODE
                    (
                        (
                            SELECT /*+ index (or_order_activity IDX_OR_ORDER_ACTIVITY_05) */
                                    0
                            FROM    OR_ORDER_ACTIVITY
                            WHERE   OR_ORDER_ACTIVITY.ORDER_ID = OR_ORDER.ORDER_ID
                            AND     OR_ORDER_ACTIVITY.ACTIVITY_ID = GE_BOITEMSCONSTANTS.CNUADJUSTMENTACTIVITY
                            AND     ROWNUM < 2
                        ),
                        0,
                        GE_BOCONSTANTS.CSBYES,
                        GE_BOCONSTANTS.CSBNO
                    ) HASADJUSTMENTACTIVITY,
                    DECODE
                    (
                        (
                            SELECT /*+ index (or_order_activity IDX_OR_ORDER_ACTIVITY_05) */
                                    0
                            FROM    OR_ORDER_ACTIVITY
                            WHERE   OR_ORDER_ACTIVITY.ORDER_ID = OR_ORDER.ORDER_ID
                            AND     OR_ORDER_ACTIVITY.ACTIVITY_ID = GE_BOITEMSCONSTANTS.CNUCONSIGMENTACTIVITY
                            AND     ROWNUM < 2
                        ),
                        0,
                        GE_BOCONSTANTS.CSBYES,
                        GE_BOCONSTANTS.CSBNO
                    ) HASCONSIGMENT_ACTIVITY,
                    DECODE
                    (
                        (
                            SELECT  /*+ index (or_order_activity IDX_OR_ORDER_ACTIVITY_05)
                                        index (CT_ITEM_NOVELTY PK_CT_ITEM_NOVELTY)
                                    */
                                    0
                            FROM    OR_ORDER_ACTIVITY,
                                    CT_ITEM_NOVELTY
                            WHERE   CT_ITEM_NOVELTY.ITEMS_ID = OR_ORDER_ACTIVITY.ACTIVITY_ID
                            AND     OR_ORDER_ACTIVITY.ORDER_ID = OR_ORDER.ORDER_ID
                            AND     ROWNUM < 2
                        ),
                        0,
                        GE_BOCONSTANTS.CSBYES,
                        GE_BOCONSTANTS.CSBNO
                    ) IS_NOVELTY,
                    DECODE
                    (
                        EXTERNAL_ADDRESS_ID,
                        NULL,
                        NULL,
                        (
                            SELECT  /*+ index (AB_ADDRESS PK_AB_ADDRESS)*/
                                    AB_ADDRESS.GEOGRAP_LOCATION_ID
                            FROM    AB_ADDRESS
                            WHERE   AB_ADDRESS.ADDRESS_ID = OR_ORDER.EXTERNAL_ADDRESS_ID
                        )
                    ) REAL_GEOGRA_LOCA
             FROM   TMP_VARCHAR,
                    OR_ORDER

                    /*+ CT_BCLiquidationSupport.GetOrdersBlock*/
             WHERE  OR_ORDER.ROWID = TMP_VARCHAR.FIELD
             AND    OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES
             AND    TMP_VARCHAR.FIELD > ISBPIVOT
             ORDER BY TMP_VARCHAR.FIELD;
    BEGIN
        OPEN CUALLORDERS;
        FETCH CUALLORDERS BULK COLLECT INTO ITBORDERSTOPROCESS LIMIT CT_BOCONSTANTS.CNUORDERSNUMBER;
        CLOSE CUALLORDERS;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETORDERSBLOCK;
    
    












    PROCEDURE CLEARTMPORDERSTABLE
    IS
    BEGIN
        
        DELETE FROM TMP_VARCHAR;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CLEARTMPORDERSTABLE;
    
    




















    PROCEDURE UPDTOLIQEXCORDERSWBASE
    (
        IDTBREAKDATE        IN            GE_ACTA.FECHA_FIN%TYPE,
        INUCONTRACTID       IN            GE_CONTRATO.ID_CONTRATO%TYPE
    )
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        TBROWID             DAOR_ORDER.TYTBROWID;

        CNUSUCCESSFULLCLASSCAUSAL   GE_CAUSAL.CLASS_CAUSAL_ID%TYPE := GE_BOPARAMETER.FNUGET('ACCOM_CAUSE_TYPE');

        DTBREAKDATE         DATE;

        
        CURSOR CUALLORDERS IS
             SELECT
                    OR_ORDER.ROWID
             FROM   CT_EXCLUDED_ORDER,
                    OR_ORDER,
                    GE_CAUSAL
                    /*+ CT_BCLiquidationSupport.updToLiqExcOrdersWBase*/
             WHERE
                   
                   OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED
                   
               AND OR_ORDER.CAUSAL_ID = GE_CAUSAL.CAUSAL_ID
               AND GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL
                   
               AND OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE
                   
               AND OR_ORDER.IS_PENDING_LIQ = CT_BOCONSTANTS.CSBEXCLUDEDORDER
                    
               AND  OR_ORDER.DEFINED_CONTRACT_ID = INUCONTRACTID
               AND  CT_EXCLUDED_ORDER.ORDER_ID = OR_ORDER.ORDER_ID
               AND  CT_EXCLUDED_ORDER.FINAL_EXCLUSION_DATE <= DTBREAKDATE;
    BEGIN
        DTBREAKDATE := TRUNC(IDTBREAKDATE);
        OPEN CUALLORDERS;

        LOOP
            FETCH CUALLORDERS BULK COLLECT INTO TBROWID LIMIT CT_BOCONSTANTS.CNUORDERSNUMBER;

            FORALL I IN 1..TBROWID.COUNT
                UPDATE   OR_ORDER
                SET     IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES
                /*+ ct_bcliquidationsupport.updToLiqExcOrdersWBase */
                WHERE   OR_ORDER.ROWID = TBROWID(I);
            TBROWID.DELETE;
            COMMIT;
            EXIT WHEN CUALLORDERS%NOTFOUND;
        END LOOP;
        CLOSE CUALLORDERS;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (CUALLORDERS%ISOPEN) THEN
                CLOSE CUALLORDERS;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (CUALLORDERS%ISOPEN) THEN
                CLOSE CUALLORDERS;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDTOLIQEXCORDERSWBASE;
    
    



















    PROCEDURE UPDTOLIQEXCORDERSABASE
    (
        INUADMINBASEID	    IN            GE_ACTA.ID_BASE_ADMINISTRATIVA%TYPE,
        IDTBREAKDATE        IN            GE_ACTA.FECHA_FIN%TYPE,
        INUCONTRACTID       IN            GE_CONTRATO.ID_CONTRATO%TYPE
    )
    IS

        TBROWID             DAOR_ORDER.TYTBROWID;

        CNUSUCCESSFULLCLASSCAUSAL   GE_CAUSAL.CLASS_CAUSAL_ID%TYPE := GE_BOPARAMETER.FNUGET('ACCOM_CAUSE_TYPE');

        DTBREAKDATE         DATE;

        
        CURSOR CUALLORDERS IS
             SELECT
                    OR_ORDER.ROWID
             FROM   CT_EXCLUDED_ORDER,
                    OR_ORDER,
                    GE_CAUSAL,
                    OR_OPERATING_UNIT
                    /*+ CT_BCLiquidationSupport.updToLiqExcOrdersABase*/
             WHERE
                   
                   OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED
                   
               AND OR_ORDER.CAUSAL_ID = GE_CAUSAL.CAUSAL_ID
               AND GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL
                   
               AND OR_OPERATING_UNIT.OPERATING_UNIT_ID = OR_ORDER.OPERATING_UNIT_ID
               AND OR_OPERATING_UNIT.ADMIN_BASE_ID = INUADMINBASEID
                   
               AND OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE
                   
               AND OR_ORDER.IS_PENDING_LIQ = CT_BOCONSTANTS.CSBEXCLUDEDORDER
                    
               AND  OR_ORDER.DEFINED_CONTRACT_ID = INUCONTRACTID
               AND  CT_EXCLUDED_ORDER.ORDER_ID = OR_ORDER.ORDER_ID
               AND  CT_EXCLUDED_ORDER.FINAL_EXCLUSION_DATE <= DTBREAKDATE;
    BEGIN
        DTBREAKDATE := TRUNC(IDTBREAKDATE);
        OPEN CUALLORDERS;

        LOOP
            FETCH CUALLORDERS BULK COLLECT INTO TBROWID LIMIT CT_BOCONSTANTS.CNUORDERSNUMBER;

            FORALL I IN 1..TBROWID.COUNT
                UPDATE  OR_ORDER
                SET     IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES
                /*+ ct_bcliquidationsupport.updToLiqExcOrdersABase */
                WHERE   OR_ORDER.ROWID = TBROWID(I);
            TBROWID.DELETE;
            COMMIT;
            EXIT WHEN CUALLORDERS%NOTFOUND;
        END LOOP;
        CLOSE CUALLORDERS;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (CUALLORDERS%ISOPEN) THEN
                CLOSE CUALLORDERS;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (CUALLORDERS%ISOPEN) THEN
                CLOSE CUALLORDERS;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDTOLIQEXCORDERSABASE;
    
    















    PROCEDURE UPDFINALDATEANDPENDREGCERT
    (
        INUCERTID	    IN            GE_ACTA.ID_ACTA%TYPE,
        IDTBREAKDATE    IN            GE_ACTA.FECHA_FIN%TYPE
    )
    IS
    BEGIN
        
        UPDATE  GE_ACTA
        SET     GE_ACTA.IS_PENDING = GE_BOCONSTANTS.OK,
                GE_ACTA.FECHA_FIN  = IDTBREAKDATE
        /*+ ct_bcliquidationsupport.updFinalDateAndPendRegCert */
        WHERE   GE_ACTA.ID_ACTA = INUCERTID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDFINALDATEANDPENDREGCERT;
    
    

















    PROCEDURE SETORDERSTOPENDING
    (
        IBLCOMMIT BOOLEAN DEFAULT TRUE
    )
    IS
    BEGIN
        UT_TRACE.TRACE('[INICIO] CT_BCLiquidationSupport.SetOrdersToPending',5);
        
             UPDATE OR_ORDER
                SET IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES
              WHERE OR_ORDER.ORDER_ID IN
              (
                 SELECT /*+ ordered
                            index (TMP_VARCHAR  IDX_TMP_VARCHAR01)
                        */
                        A.ORDER_ID
                 FROM   TMP_VARCHAR,
                        OR_ORDER A
                        /*+ CT_BCLiquidationSupport.GetOrdersBlock*/
                 WHERE  A.ROWID = TMP_VARCHAR.FIELD
                 AND NOT EXISTS
                 (
                    SELECT /*+ index(ct_order_certifica IDX_CT_ORDER_CERTIFICA04)*/
                    'X'
                    FROM CT_ORDER_CERTIFICA
                    WHERE   CT_ORDER_CERTIFICA.ORDER_ID = A.ORDER_ID
                 )
             );


        IF(IBLCOMMIT) THEN
            
            COMMIT;
        END IF;

       UT_TRACE.TRACE('[FIN] CT_BCLiquidationSupport.SetOrdersToPending',5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETORDERSTOPENDING;
  
END CT_BCLIQUIDATIONSUPPORT;