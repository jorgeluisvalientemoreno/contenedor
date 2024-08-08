PACKAGE CT_BCReads
IS
    




























































    
    
    
    
    
    CSBSEPARATOR    CONSTANT VARCHAR2(1) := ',';
    
    
    CSBGROUPEDTOKEN     CONSTANT    OR_ORDER.SAVED_DATA_VALUES%TYPE := 'ORDER_GROUPED';

    



























    CURSOR CUGETGROUPEDORDERSLEC
    (
        IOTBFOUNDORDERS IN  OUT NOCOPY CT_TYTBORDERSTOLIQ,
        IDTMAXDATEORD   IN  GE_PERIODO_CERT.FECHA_FINAL%TYPE,
        ISBREADTASKT    IN  VARCHAR2,
        ISBOBSERVID     IN  GE_PARAMETER.VALUE%TYPE
    )
    IS
    SELECT  /*+ no_merge(ordenes)*/
            GEOGRAP_LOCATION_ID,
            OPERATING_UNIT_ID,
            LEGALDATE,
            ITEMS_ID,
            SUM(LEGAL_ITEM_AMOUNT) LEGAL_ITEM_AMOUNT,
            SUM(VALUE) VALUE,
            SUM(TOTAL_PRICE) TOTAL_PRICE,
            SUM(VALUE_REFERENCE) VALUE_REFERENCE,
            MAX(ADDRESS_ID) ADDRESS_ID
    FROM
        (
        SELECT  /*+ use_nl(tmp_imprfact orders or_order_activity lectelme or_order_items ab_address)
                    index(OR_ORDER_ACTIVITY IDX_OR_ORDER_ACTIVITY_05)
                    index(LECTELME IX_LECTELME03)
                    index(OR_ORDER_ITEMS PK_OR_ORDER_ITEMS)
                    index(AB_ADDRESS PK_AB_ADDRESS) */
                ORDERS.ORDER_ACTIVITY_ID,
                ORDERS.GEOGRAP_LOCATION_ID,
                ORDERS.OPERATING_UNIT_ID,
                TRUNC(ORDERS.LEGALIZATION_DATE) LEGALDATE,
                ORDERS.ITEMS_ID,
                ORDERS.LEGAL_ITEM_AMOUNT,
                ORDERS.VALUE,
                ORDERS.TOTAL_PRICE,
                ORDERS.ADDRESS_ID,
                ORDERS.VALUE_REFERENCE
        FROM    TABLE(CAST(IOTBFOUNDORDERS AS CT_TYTBORDERSTOLIQ)) ORDERS,
                LECTELME
        WHERE   /*+ Ubicaci�n: CT_BCReads.cuGetGroupedOrdersLec SAO235515 */
                ORDERS.ORDER_ACTIVITY_ID = LECTELME.LEEMDOCU
        AND     ORDERS.ACTIVITY_ID IN (GE_BOITEMSCONSTANTS.CNUREADINGACTIVITY, CM_BOCONSTANTS.CNUBIL_ACTIVITY_READING)
        AND     INSTR(NVL(ISBOBSERVID,'-'), CONCAT(CT_BCREADS.CSBSEPARATOR,CONCAT(TO_CHAR(LECTELME.LEEMOBLE),CT_BCREADS.CSBSEPARATOR))) = 0
        AND     INSTR(NVL(ISBOBSERVID,'-'), CONCAT(CT_BCREADS.CSBSEPARATOR,CONCAT(TO_CHAR(LECTELME.LEEMOBSB),CT_BCREADS.CSBSEPARATOR))) = 0
        AND     INSTR(NVL(ISBOBSERVID,'-'), CONCAT(CT_BCREADS.CSBSEPARATOR,CONCAT(TO_CHAR(LECTELME.LEEMOBSC),CT_BCREADS.CSBSEPARATOR))) = 0
        AND     INSTR(ISBREADTASKT,','||ORDERS.TASK_TYPE_ID||',')>0
        AND     TRUNC(ORDERS.LEGALIZATION_DATE) = IDTMAXDATEORD
        AND     ORDERS.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES
        UNION
        SELECT  /*+ ordered full(tmp_imprfact) use_nl(tmp_imprfact orders or_order_activity hileelme or_order_items ab_address)
                    index(OR_ORDER_ACTIVITY IDX_OR_ORDER_ACTIVITY_05)
                    index(HILEELME IX_HILEELME05)
                    index(OR_ORDER_ITEMS PK_OR_ORDER_ITEMS)
                    index(ab_address pk_ab_address) */
                ORDERS.ORDER_ACTIVITY_ID,
                ORDERS.GEOGRAP_LOCATION_ID,
                ORDERS.OPERATING_UNIT_ID,
                TRUNC(ORDERS.LEGALIZATION_DATE) LEGALDATE,
                ORDERS.ITEMS_ID,
                ORDERS.LEGAL_ITEM_AMOUNT,
                ORDERS.VALUE,
                ORDERS.TOTAL_PRICE,
                ORDERS.ADDRESS_ID,
                ORDERS.VALUE_REFERENCE
        FROM    TABLE(CAST(IOTBFOUNDORDERS AS CT_TYTBORDERSTOLIQ)) ORDERS,
                HILEELME
        WHERE   /*+ Ubicaci�n: CT_BCReads.cuGetGroupedOrdersLec SAO235515 */
                ORDERS.ORDER_ACTIVITY_ID = HILEELME.HLEMDOCU
        AND     ORDERS.ACTIVITY_ID IN (GE_BOITEMSCONSTANTS.CNUREADINGACTIVITY, CM_BOCONSTANTS.CNUBIL_ACTIVITY_READING)
        AND     INSTR(NVL(ISBOBSERVID,'-'), CONCAT(CT_BCREADS.CSBSEPARATOR,CONCAT(TO_CHAR(HLEMOBLE),CT_BCREADS.CSBSEPARATOR))) = 0
        AND     INSTR(NVL(ISBOBSERVID,'-'), CONCAT(CT_BCREADS.CSBSEPARATOR,CONCAT(TO_CHAR(HLEMOBSB),CT_BCREADS.CSBSEPARATOR))) = 0
        AND     INSTR(NVL(ISBOBSERVID,'-'), CONCAT(CT_BCREADS.CSBSEPARATOR,CONCAT(TO_CHAR(HLEMOBSC),CT_BCREADS.CSBSEPARATOR))) = 0
        AND     INSTR(ISBREADTASKT,','||ORDERS.TASK_TYPE_ID||',')>0
        AND     TRUNC(ORDERS.LEGALIZATION_DATE) = IDTMAXDATEORD
        AND     ORDERS.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES
        ) ORDENES
    GROUP BY LEGALDATE, GEOGRAP_LOCATION_ID, OPERATING_UNIT_ID, ITEMS_ID;


    
























    CURSOR CUGETGROUPEDORDERSNOLEC
    (
        IOTBFOUNDORDERS IN  OUT NOCOPY CT_TYTBORDERSTOLIQ,
        IDTMAXDATEORD   IN  GE_PERIODO_CERT.FECHA_FINAL%TYPE
    )
    IS
    SELECT  /*+ no_merge(ordenes)*/
            GEOGRAP_LOCATION_ID,
            OPERATING_UNIT_ID,
            LEGALDATE,
            ITEMS_ID,
            SUM(LEGAL_ITEM_AMOUNT) LEGAL_ITEM_AMOUNT,
            SUM(VALUE) VALUE,
            SUM(TOTAL_PRICE) TOTAL_PRICE,
            SUM(VALUE_REFERENCE) VALUE_REFERENCE,
            MAX(ADDRESS_ID) ADDRESS_ID
    FROM
        (
        SELECT  /*+ ordered full(tmp_imprfact)
                    use_nl(tmp_imprfact OR_order or_order_activity or_order_items ab_address)
                    index(OR_ORDER_ACTIVITY IDX_OR_ORDER_ACTIVITY_05)
                    index(OR_ORDER_ITEMS PK_OR_ORDER_ITEMS)
                    index(AB_ADDRESS PK_AB_ADDRESS) */
                ORDERS.GEOGRAP_LOCATION_ID,
                ORDERS.OPERATING_UNIT_ID,
                TRUNC(ORDERS.LEGALIZATION_DATE) LEGALDATE,
                ORDERS.ITEMS_ID,
                ORDERS.LEGAL_ITEM_AMOUNT,
                ORDERS.VALUE,
                ORDERS.TOTAL_PRICE,
                ORDERS.ADDRESS_ID,
                ORDERS.VALUE_REFERENCE
        FROM    TABLE(CAST(IOTBFOUNDORDERS AS CT_TYTBORDERSTOLIQ)) ORDERS
        WHERE   /*+ Ubicaci�n: CT_BCReads.cuGetGroupedOrdersNoLec SAO235515 */
                ORDERS.ACTIVITY_ID NOT IN (GE_BOITEMSCONSTANTS.CNUREADINGACTIVITY, CM_BOCONSTANTS.CNUBIL_ACTIVITY_READING)
        AND     TRUNC(ORDERS.LEGALIZATION_DATE) = IDTMAXDATEORD
        AND     ORDERS.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES
        ) ORDENES
    GROUP BY LEGALDATE, GEOGRAP_LOCATION_ID, OPERATING_UNIT_ID, ITEMS_ID;

    
    FUNCTION FNUGETREAD
    (
        INUORDER        IN      OR_ORDER.ORDER_ID%TYPE,
        ISBCAUSAL       IN      VARCHAR2,
        ISBOBSECOD      IN      VARCHAR2,
        IBLONLYNOEFFEC  IN      BOOLEAN DEFAULT FALSE
    )
    RETURN NUMBER;

    
    FUNCTION FBOGETREWORKED
    (
        INUORDER        IN      OR_ORDER.ORDER_ID%TYPE
    )
    RETURN BOOLEAN;
    
    
    FUNCTION FBOGETBADREADS
    (
        INUORDER        IN      OR_ORDER.ORDER_ID%TYPE
    )
    RETURN BOOLEAN;
    
    
    FUNCTION FSBVERSION
    RETURN VARCHAR2;
    
    



    PROCEDURE INSSELECTORDERS
    (
        IDTEXECFINAL    IN  GE_PERIODO_CERT.FECHA_FINAL%TYPE,
        INUCONTRACTID   IN  GE_CONTRATO.ID_CONTRATO%TYPE,
        ISBTASKTYPESID  IN  GE_PARAMETER.VALUE%TYPE,
        ONUROWNUM       OUT NUMBER
    );
    
    



    PROCEDURE UPDATEORDERLIQ
    (
        IOTBORDERINPROC  IN OUT NOCOPY CT_TYTBORDERSTOLIQ,
        IDTMAXDATE      IN GE_PERIODO_CERT.FECHA_FINAL%TYPE
    );

    




    PROCEDURE UPDATEVALUEANDCOST
    (
        INUORDERID  IN  OR_ORDER_ITEMS.ORDER_ID%TYPE,
        INUVALUE    IN  OR_ORDER_ITEMS.VALUE%TYPE,
        INUCOST     IN  OR_ORDER_ITEMS.TOTAL_PRICE%TYPE
    );
    
    



    PROCEDURE DELETETMPTABLE;
    
    

















    PROCEDURE GETDAYSTOEXEC
    (
        IOTBFOUNDORDERS IN OUT NOCOPY CT_TYTBORDERSTOLIQ,
        ITBDATESTOEXEC  IN OUT NOCOPY DAGE_PERIODO_CERT.TYTBFECHA_INICIAL
    );
    
    














    FUNCTION FTBGETOPUNIBYCONTRACT
    (
        INUCONTRACTID        IN      GE_CONTRATO.ID_CONTRATO%TYPE
    )
    RETURN DAOR_OPERATING_UNIT.TYTBOPERATING_UNIT_ID;
    
    
















    FUNCTION FSBGETGROUPTASKTYPES
    (
        INUCONTRACTID        IN      GE_CONTRATO.ID_CONTRATO%TYPE,
        ISBTASKTYPESID       IN      GE_PARAMETER.VALUE%TYPE
    )
    RETURN GE_PARAMETER.VALUE%TYPE;
    
    
    
















    PROCEDURE UPDCONTRACTTOORDERS
    (
        INUOPERATINGUNITID  IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        ISBFINALTASKTYPES   IN GE_PARAMETER.VALUE%TYPE,
        IRCGE_CONTRATO      IN DAGE_CONTRATO.STYGE_CONTRATO,
        IDTFINALDATE        IN GE_PERIODO_CERT.FECHA_FINAL%TYPE
    );
    
    





















    PROCEDURE GETORDERSTOGROUP
    (
        INUCONTRACTID   IN  GE_CONTRATO.ID_CONTRATO%TYPE,
        ISBTASKTYPESID  IN  GE_PARAMETER.VALUE%TYPE,
        IDTMAXDATE      IN  GE_PERIODO_CERT.FECHA_FINAL%TYPE,
        IOTBFOUNDORDERS IN OUT NOCOPY CT_TYTBORDERSTOLIQ
    );
    
    

















    PROCEDURE GETREADTASKTYPES
    (
        IOSBREADTASKTYPES  IN  OUT NOCOPY  VARCHAR2
    );
    
    
END CT_BCREADS;
/
PACKAGE BODY CT_BCReads
IS
    


























































    
    
    
    CSBVERSION                  CONSTANT VARCHAR2(10) := 'SAO476466';

    
    TYPE TYTBROWID IS TABLE OF ROWID;

    
    
    

    


















    FUNCTION FNUGETREAD
    (
        INUORDER        IN      OR_ORDER.ORDER_ID%TYPE,
        ISBCAUSAL       IN      VARCHAR2,
        ISBOBSECOD      IN      VARCHAR2,
        IBLONLYNOEFFEC  IN      BOOLEAN
    )
    RETURN NUMBER
    IS
        SBOBLECODIS         VARCHAR2(500);
        SBCAUSALS           VARCHAR2(500);
        NUCOUNTER           NUMBER;
        SBSQL               VARCHAR2(2000);
        NUEFFECTIVEREAD     NUMBER := 0;
        NUINEFFECTIVEREAD   NUMBER := 0;
        CUDATACURSOR        CONSTANTS.TYREFCURSOR;
    BEGIN
    
        UT_TRACE.TRACE('BEGIN CT_BCReads.fnuGetRead', 2);

        UT_TRACE.TRACE('Par�metro -> inuOrder: ' || INUORDER      || CHR(10) ||
               '        Par�metro -> isbCausal: ' || ISBCAUSAL    || CHR(10) ||
               '        Par�metro -> isbObseCod: ' || ISBOBSECOD  || CHR(10) ||
               '        Par�metro -> iblOnlyNoEffec: ' || (CASE WHEN (IBLONLYNOEFFEC = TRUE) THEN 'TRUE' ELSE 'FALSE' END), 3);
        
        SBOBLECODIS := CHR(39) || '|' || ISBOBSECOD || '|' || CHR(39);
        
        SBCAUSALS :=  CHR(39) || '|' || ISBCAUSAL || '|' || CHR(39);
        
        IF (IBLONLYNOEFFEC = FALSE) THEN

            SBSQL :=    'SELECT'|| CHR(10) ||
                        '/*+ ordered  index(or_order_activity IDX_OR_ORDER_ACTIVITY_05)*/'|| CHR(10) ||
                        'count(1)' || CHR(10) ||
                        'FROM   or_order_activity,' || CHR(10) ||
                        '       lectelme,' || CHR(10) ||
                        '       (SELECT '|| CHR(10) ||
                                 'obselect.oblecodi FROM obselect WHERE instr(:sbOblecodis, concat(''|'',concat(to_char(obselect.oblecodi),''|''))) != 0 AND obselect.oblecanl = '|| CHR(39) || 'N' || CHR(39) || ') obs' || CHR(10) ||
                        'WHERE  or_order_activity.order_id =  :orderId' || CHR(10) ||
                        'AND    or_order_activity.activity_id = :nuReadActivity' || CHR(10)||
                        'AND    lectelme.leemdocu = or_order_activity.order_activity_id ' || CHR(10) ||
                        'AND    lectelme.leemleto IS not null' || CHR(10) ||
                        'AND    instr(:sbCausals, concat(''|'',concat(to_char(lectelme.leemclec),''|''))) != 0 ' || CHR(10) ||
                        'AND    (lectelme.leemoble = obs.oblecodi' || CHR(10) ||
                        '       OR lectelme.leemobsb = obs.oblecodi' || CHR(10) ||
                        '       OR lectelme.leemobsc = obs.oblecodi)';

            OPEN CUDATACURSOR FOR SBSQL USING SBOBLECODIS, INUORDER, GE_BOITEMSCONSTANTS.CNUREADINGACTIVITY, SBCAUSALS;
            FETCH CUDATACURSOR INTO NUEFFECTIVEREAD;
            CLOSE CUDATACURSOR;
        
        END IF;
        
        SBSQL :=    'SELECT'|| CHR(10) ||
                    '/*+ ordered  index(or_order_activity IDX_OR_ORDER_ACTIVITY_05)*/'|| CHR(10) ||
                    'count(1)' || CHR(10) ||
                    'FROM   or_order_activity,' || CHR(10) ||
                    '       lectelme,' || CHR(10) ||
                    '       (SELECT '|| CHR(10) ||
                             'obselect.oblecodi FROM obselect WHERE instr(:sbOblecodis, concat(''|'',concat(to_char(obselect.oblecodi),''|''))) != 0 AND obselect.oblecanl = '|| CHR(39) || 'S' || CHR(39) || ') obs' || CHR(10) ||
                    'WHERE  or_order_activity.order_id =  :orderId' || CHR(10) ||
                    'AND    or_order_activity.activity_id = :readActivity' || CHR(10)||
                    'AND    lectelme.leemdocu = or_order_activity.order_activity_id ' || CHR(10) ||
                    'AND    lectelme.leemleto IS null' || CHR(10) ||
                    'AND    instr(:sbCausals, concat(''|'',concat(to_char(lectelme.leemclec),''|''))) != 0 ' || CHR(10) ||
                    'AND    lectelme.leemoble IS not null' || CHR(10) ||
                    'AND    (lectelme.leemobsb = obs.oblecodi' || CHR(10) ||
                    '       OR lectelme.leemobsc = obs.oblecodi)';

        OPEN CUDATACURSOR FOR SBSQL USING SBOBLECODIS, INUORDER, GE_BOITEMSCONSTANTS.CNUREADINGACTIVITY, SBCAUSALS;
        FETCH CUDATACURSOR INTO NUINEFFECTIVEREAD;
        CLOSE CUDATACURSOR;
        
        UT_TRACE.TRACE('END CT_BCReads.fnuGetRead', 2);

        RETURN NUEFFECTIVEREAD + NUINEFFECTIVEREAD;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (CUDATACURSOR%ISOPEN) THEN
                CLOSE CUDATACURSOR;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (CUDATACURSOR%ISOPEN) THEN
                CLOSE CUDATACURSOR;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        
    END FNUGETREAD;
    
    















    FUNCTION FBOGETREWORKED
    (
        INUORDER        IN      OR_ORDER.ORDER_ID%TYPE
    )
    RETURN BOOLEAN
    IS
        CUDATACURSOR        CONSTANTS.TYREFCURSOR;
        NURESULT            NUMBER := 0;
    BEGIN
    
        UT_TRACE.TRACE('BEGIN CT_BCReads.fboGetReWorked', 2);

        UT_TRACE.TRACE('Par�metro -> inuOrder: ' || INUORDER, 3);
        
        OPEN CUDATACURSOR FOR
            SELECT  1
            FROM    DUAL
            WHERE EXISTS (
                SELECT  /*+index(or_order_activity IDX_OR_ORDER_ACTIVITY_05)*/
                        1
                FROM    OR_ORDER_ACTIVITY,
                        LECTELME
                WHERE   OR_ORDER_ACTIVITY.ORDER_ID = INUORDER
                AND     LECTELME.LEEMDOCU = OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID
                AND     NVL(LECTELME.LEEMFLCO,'N') = 'S'
            );
        
        FETCH CUDATACURSOR INTO NURESULT;
        CLOSE CUDATACURSOR;
        
        UT_TRACE.TRACE('END CT_BCReads.fboGetReWorked', 2);
        
        RETURN NURESULT = 1;
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (CUDATACURSOR%ISOPEN) THEN
                CLOSE CUDATACURSOR;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (CUDATACURSOR%ISOPEN) THEN
                CLOSE CUDATACURSOR;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        
    END FBOGETREWORKED;
    
    















    FUNCTION FBOGETBADREADS
    (
        INUORDER        IN      OR_ORDER.ORDER_ID%TYPE
    )
    RETURN BOOLEAN
    IS
        CUDATACURSOR        CONSTANTS.TYREFCURSOR;
        NURESULT            NUMBER := 0;
    BEGIN
    
        UT_TRACE.TRACE('BEGIN CT_BCReads.fboGetBadReads', 2);

        UT_TRACE.TRACE('Par�metro -> inuOrder: ' || INUORDER, 3);
    
        OPEN CUDATACURSOR FOR
            SELECT  COUNT(1)
            FROM    DUAL
            WHERE   EXISTS (
                SELECT  /*+index(or_order_activity IDX_OR_ORDER_ACTIVITY_05)*/
                        1
                FROM    HILEELME,
                        OR_ORDER_ACTIVITY
                WHERE   OR_ORDER_ACTIVITY.ORDER_ID = INUORDER
                AND     HILEELME.HLEMDOCU = OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID
                AND     OR_ORDER_ACTIVITY.ACTIVITY_ID <> GE_BOITEMSCONSTANTS.CNUREADINGACTIVITY
            );

        FETCH CUDATACURSOR INTO NURESULT;
        CLOSE CUDATACURSOR;

        UT_TRACE.TRACE('END CT_BCReads.fboGetBadReads', 2);

        RETURN NURESULT = 1;
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (CUDATACURSOR%ISOPEN) THEN
                CLOSE CUDATACURSOR;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (CUDATACURSOR%ISOPEN) THEN
                CLOSE CUDATACURSOR;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        
    END FBOGETBADREADS;

    













    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;
    
    




















    PROCEDURE INSSELECTORDERS
    (
        IDTEXECFINAL    IN  GE_PERIODO_CERT.FECHA_FINAL%TYPE,
        INUCONTRACTID   IN  GE_CONTRATO.ID_CONTRATO%TYPE,
        ISBTASKTYPESID  IN  GE_PARAMETER.VALUE%TYPE,
        ONUROWNUM       OUT NUMBER
    )
    IS
    BEGIN
        UT_TRACE.TRACE('Inicia CT_BCReads.InsSelectOrders ('||IDTEXECFINAL||') ('||INUCONTRACTID||') ('||ISBTASKTYPESID||')',15);

        INSERT INTO TMP_IMPRFACT (IMFAREGI)
        WITH TASKTYPES AS
        (
            
            SELECT  OR_TASK_TYPE.TASK_TYPE_ID
            FROM    OR_TASK_TYPE
            WHERE   INSTR(','||ISBTASKTYPESID||',', CONCAT(',',CONCAT(TO_CHAR(OR_TASK_TYPE.TASK_TYPE_ID),','))) != 0
            UNION
            
            SELECT  /*+ index(IDX_OR_TASK_TYPES_ITEMS01) */
                    OR_TASK_TYPES_ITEMS.TASK_TYPE_ID
            FROM    OR_TASK_TYPES_ITEMS
            WHERE   OR_TASK_TYPES_ITEMS.ITEMS_ID IN (GE_BOITEMSCONSTANTS.CNUREADINGACTIVITY, CM_BOCONSTANTS.CNUBIL_ACTIVITY_READING)
        )
        SELECT  /*+ ordered index(OR_ORDER IDX_OR_ORDER16) */
                OR_ORDER.ROWID
        FROM    OR_ORDER,
                TASKTYPES,
                GE_CAUSAL
        WHERE   /*+ Ubicaci�n: CT_BCReads.InsSelectOrders SAO230779 */
                GE_CAUSAL.CLASS_CAUSAL_ID = OR_BOCONSTANTS.CNUSUCCESSCAUSAL
        AND     GE_CAUSAL.CAUSAL_ID = OR_ORDER.CAUSAL_ID
        AND     TASKTYPES.TASK_TYPE_ID = OR_ORDER.TASK_TYPE_ID
        AND     (OR_ORDER.SAVED_DATA_VALUES IS NULL OR
                OR_ORDER.SAVED_DATA_VALUES != CT_BCREADS.CSBGROUPEDTOKEN)
        AND     OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED
        AND     OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES
        AND     OR_ORDER.DEFINED_CONTRACT_ID = INUCONTRACTID
        AND     TRUNC(OR_ORDER.LEGALIZATION_DATE) = IDTEXECFINAL;

        ONUROWNUM := SQL%ROWCOUNT;
        
        UT_TRACE.TRACE('Finaliza CT_BCReads.InsSelectOrders ('||ONUROWNUM||')',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    













    PROCEDURE UPDATEORDERLIQ
    (
        IOTBORDERINPROC  IN OUT NOCOPY CT_TYTBORDERSTOLIQ,
        IDTMAXDATE      IN GE_PERIODO_CERT.FECHA_FINAL%TYPE
    )
    IS

    BEGIN
        UT_TRACE.TRACE('Inicia CT_BCReads.UpdateOrderLiq',15);
        
        
        UPDATE /*+ use_nl(or_order) rowid(or_order) */ OR_ORDER
        SET IS_PENDING_LIQ = NULL
        WHERE ORDER_ID IN
            (
                SELECT /*+ use_nl(tmp_imprfact) full(tmp_imprfact)*/ ORDER_ID
                FROM TABLE(CAST(IOTBORDERINPROC AS CT_TYTBORDERSTOLIQ))
                WHERE TRUNC(LEGALIZATION_DATE) = IDTMAXDATE
                  AND IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES
            );
            
        
        FOR NUIDX IN  IOTBORDERINPROC.FIRST .. IOTBORDERINPROC.LAST LOOP
            IF ( IOTBORDERINPROC(NUIDX).LEGALIZATION_DATE  = IDTMAXDATE AND

                 IOTBORDERINPROC(NUIDX).IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES) THEN
                 IOTBORDERINPROC(NUIDX).IS_PENDING_LIQ := NULL;
            END IF;
        END LOOP;

        UT_TRACE.TRACE('Finaliza CT_BCReads.UpdateOrderLiq',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    

















    PROCEDURE UPDATEVALUEANDCOST
    (
        INUORDERID  IN  OR_ORDER_ITEMS.ORDER_ID%TYPE,
        INUVALUE    IN  OR_ORDER_ITEMS.VALUE%TYPE,
        INUCOST     IN  OR_ORDER_ITEMS.TOTAL_PRICE%TYPE
    )
    
    IS

    BEGIN
        UT_TRACE.TRACE('Inicia CT_BCReads.UpdateValueAndCost',15);
        
        UPDATE OR_ORDER_ITEMS
        SET VALUE = INUVALUE, TOTAL_PRICE = INUCOST
        WHERE ORDER_ID = INUORDERID;


        UT_TRACE.TRACE('Finaliza CT_BCReads.UpdateValueAndCost',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    













    PROCEDURE DELETETMPTABLE
    IS

    BEGIN
        UT_TRACE.TRACE('Inicia CT_BCReads.DeleteTmpTable',15);

        DELETE FROM TMP_IMPRFACT;

        UT_TRACE.TRACE('Finaliza CT_BCReads.DeleteTmpTable',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    






















    PROCEDURE GETDAYSTOEXEC
    (
        IOTBFOUNDORDERS IN OUT NOCOPY CT_TYTBORDERSTOLIQ,
        ITBDATESTOEXEC  IN OUT NOCOPY DAGE_PERIODO_CERT.TYTBFECHA_INICIAL
    )
    IS

        






















        CURSOR CUGETDAYSTOEXEC
        IS

        SELECT  DISTINCT TRUNC(ORDERS.LEGALIZATION_DATE) DATES
        FROM TABLE(CAST(IOTBFOUNDORDERS AS CT_TYTBORDERSTOLIQ)) ORDERS;

    BEGIN
        UT_TRACE.TRACE('Inicia CT_BCReads.GetDaysToExec',15);

        IF (CUGETDAYSTOEXEC%ISOPEN) THEN
            CLOSE CUGETDAYSTOEXEC;
        END IF;

        OPEN CUGETDAYSTOEXEC;
        FETCH CUGETDAYSTOEXEC BULK COLLECT INTO ITBDATESTOEXEC;
        CLOSE CUGETDAYSTOEXEC;

        UT_TRACE.TRACE('Finaliza CT_BCReads.GetDaysToExec ('||ITBDATESTOEXEC.COUNT||')',15);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (CUGETDAYSTOEXEC%ISOPEN) THEN
                CLOSE CUGETDAYSTOEXEC;
            END IF;
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            IF (CUGETDAYSTOEXEC%ISOPEN) THEN
                CLOSE CUGETDAYSTOEXEC;
            END IF;
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETDAYSTOEXEC;
    
    


















    FUNCTION FTBGETOPUNIBYCONTRACT
    (
        INUCONTRACTID        IN      GE_CONTRATO.ID_CONTRATO%TYPE
    )
    RETURN DAOR_OPERATING_UNIT.TYTBOPERATING_UNIT_ID
    IS
        CUDATACURSOR         CONSTANTS.TYREFCURSOR;
        TBOPERATINGUNITS     DAOR_OPERATING_UNIT.TYTBOPERATING_UNIT_ID;
        NUCONTRACTORID       GE_CONTRATO.ID_CONTRATISTA%TYPE := 0;
    BEGIN

        UT_TRACE.TRACE('BEGIN CT_BCReads.ftbGetOpUniByContract', 2);

        UT_TRACE.TRACE('Par�metro -> inuContractId: ' || INUCONTRACTID, 3);
        
        
        NUCONTRACTORID := DAGE_CONTRATO.FNUGETID_CONTRATISTA(INUCONTRACTID);
        UT_TRACE.TRACE('Contratista -> nuContractorId: ' || NUCONTRACTORID, 3);
        
        
        OPEN CUDATACURSOR FOR
            SELECT  OR_OPERATING_UNIT.OPERATING_UNIT_ID
            FROM    OR_OPERATING_UNIT
            WHERE   OR_OPERATING_UNIT.CONTRACTOR_ID = NUCONTRACTORID
            AND     OR_OPERATING_UNIT.ES_EXTERNA    = GE_BOCONSTANTS.CSBYES;

        FETCH CUDATACURSOR BULK COLLECT INTO TBOPERATINGUNITS;
        CLOSE CUDATACURSOR;
        
        UT_TRACE.TRACE('Cantidad unidades operativas: ' || TBOPERATINGUNITS.COUNT, 3);
        UT_TRACE.TRACE('END CT_BCReads.ftbGetOpUniByContract', 2);

        RETURN TBOPERATINGUNITS;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (CUDATACURSOR%ISOPEN) THEN
                CLOSE CUDATACURSOR;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (CUDATACURSOR%ISOPEN) THEN
                CLOSE CUDATACURSOR;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END FTBGETOPUNIBYCONTRACT;


    
















    FUNCTION FSBGETGROUPTASKTYPES
    (
        INUCONTRACTID        IN      GE_CONTRATO.ID_CONTRATO%TYPE,
        ISBTASKTYPESID       IN      GE_PARAMETER.VALUE%TYPE
    )
    RETURN GE_PARAMETER.VALUE%TYPE
    IS
        
        SBFINALTASKTYPES    GE_PARAMETER.VALUE%TYPE := NULL;
        NUCONTRACTORID      GE_CONTRATO.ID_CONTRATISTA%TYPE := 0;
        SBTEMPTASKTYPE      GE_PARAMETER.VALUE%TYPE := NULL;
        
        
        CURSOR CUGETCONTRATASKTYPES
        IS
            SELECT  CT_TASKTYPE_CONTYPE.TASK_TYPE_ID
            FROM    CT_TASKTYPE_CONTYPE
            WHERE   CT_TASKTYPE_CONTYPE.CONTRACT_ID = INUCONTRACTID;
    BEGIN

        UT_TRACE.TRACE('BEGIN CT_BCReads.fsbGetGroupTaskTypes', 2);

        UT_TRACE.TRACE('Par�metro -> inuContractId: ' || INUCONTRACTID, 3);
        UT_TRACE.TRACE('Par�metro -> isbTaskTypesId: ' || ISBTASKTYPESID, 3);


        
        FOR REC IN CUGETCONTRATASKTYPES LOOP
            SBTEMPTASKTYPE := TO_CHAR(REC.TASK_TYPE_ID);
            UT_TRACE.TRACE('Tipo de trabajo encontrado: ' || SBTEMPTASKTYPE, 3);
            IF (INSTR(ISBTASKTYPESID, SBTEMPTASKTYPE) > 0) THEN
                IF (SBFINALTASKTYPES IS NOT NULL) THEN
                    SBFINALTASKTYPES := SBFINALTASKTYPES||','||SBTEMPTASKTYPE;
                ELSE
                    SBFINALTASKTYPES := SBTEMPTASKTYPE;
                END IF;
            END IF;
        END LOOP;


        UT_TRACE.TRACE('Tipos de trabajos encontrados -> sbFinalTaskTypes: ' || SBFINALTASKTYPES, 3);
        UT_TRACE.TRACE('END CT_BCReads.fsbGetGroupTaskTypes', 2);

        RETURN SBFINALTASKTYPES;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (CUGETCONTRATASKTYPES%ISOPEN) THEN
                CLOSE CUGETCONTRATASKTYPES;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (CUGETCONTRATASKTYPES%ISOPEN) THEN
                CLOSE CUGETCONTRATASKTYPES;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END FSBGETGROUPTASKTYPES;

    

















    PROCEDURE UPDCONTRACTTOORDERS
    (
        INUOPERATINGUNITID  IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        ISBFINALTASKTYPES   IN GE_PARAMETER.VALUE%TYPE,
        IRCGE_CONTRATO      IN DAGE_CONTRATO.STYGE_CONTRATO,
        IDTFINALDATE        IN GE_PERIODO_CERT.FECHA_FINAL%TYPE
    )
    IS
        SBSQL           VARCHAR2(2000) := NULL;
        NUCOUNTORDERS   NUMBER := 0;
    BEGIN
        UT_TRACE.TRACE('Inicia CT_BCReads.UpdContractToOrders',2);

        SBSQL :=    'UPDATE OR_Order'|| CHR(10) ||
                    'SET    OR_Order.defined_contract_id = :IdContrato' || CHR(10) ||
                    'WHERE  OR_Order.operating_unit_id = :IdUnidadOperativa' || CHR(10) ||
                    'AND    OR_order.task_type_id in ('||ISBFINALTASKTYPES||')' || CHR(10)||
                    'AND    OR_order.defined_contract_id IS null ' || CHR(10) ||
                    'AND    trunc(OR_order.legalization_date) <= :FinalDate' || CHR(10) ||
                    'AND    OR_order.order_status_id = :StatusClosed' || CHR(10) ||
                    'AND    OR_order.IS_pending_liq = :PendingLiq';
                    
        UT_TRACE.TRACE('sbSql '||SBSQL, 3);
        
        EXECUTE IMMEDIATE SBSQL USING IRCGE_CONTRATO.ID_CONTRATO, INUOPERATINGUNITID,
                                      IDTFINALDATE,
                                      OR_BOCONSTANTS.CNUORDER_STAT_CLOSED,
                                      GE_BOCONSTANTS.CSBYES;

        NUCOUNTORDERS :=  SQL%ROWCOUNT;
        UT_TRACE.TRACE('Se actualizaron '||TO_CHAR(NUCOUNTORDERS)||' �rdenes.' , 3);
        
        UT_TRACE.TRACE('Finaliza CT_BCReads.UpdContractToOrders',2);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',3);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',3);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDCONTRACTTOORDERS;
    
    
























    PROCEDURE GETORDERSTOGROUP
    (
        INUCONTRACTID   IN  GE_CONTRATO.ID_CONTRATO%TYPE,
        ISBTASKTYPESID  IN  GE_PARAMETER.VALUE%TYPE,
        IDTMAXDATE      IN  GE_PERIODO_CERT.FECHA_FINAL%TYPE,
        IOTBFOUNDORDERS IN OUT NOCOPY CT_TYTBORDERSTOLIQ
    )
    IS
    BEGIN
    
        UT_TRACE.TRACE('Inicia CT_BCReads.GetOrdersToGroup',2);

        SELECT  CAST
                    (
                        MULTISET
                                (
                                 WITH TASKTYPES AS
                                 (
                                    
                                    SELECT  OR_TASK_TYPE.TASK_TYPE_ID
                                    FROM    OR_TASK_TYPE
                                    WHERE   INSTR(','||ISBTASKTYPESID||',', CONCAT(',',CONCAT(TO_CHAR(OR_TASK_TYPE.TASK_TYPE_ID),','))) != 0
                                    UNION
                                    
                                    SELECT  OR_TASK_TYPES_ITEMS.TASK_TYPE_ID
                                    FROM    OR_TASK_TYPES_ITEMS
                                    WHERE   OR_TASK_TYPES_ITEMS.ITEMS_ID IN (GE_BOITEMSCONSTANTS.CNUREADINGACTIVITY, CM_BOCONSTANTS.CNUBIL_ACTIVITY_READING)
                                 )
                                 SELECT /*+ use_nl(orders or_order_activity or_order_items ab_address)
                                            index(OR_ORDER IDX_OR_ORDER21)
                                            index(OR_ORDER_ACTIVITY IDX_OR_ORDER_ACTIVITY_05)
                                            index(LECTELME IX_LECTELME03)
                                            index(OR_ORDER_ITEMS PK_OR_ORDER_ITEMS)
                                            index(AB_ADDRESS PK_AB_ADDRESS) */
                                        OR_ORDER.ORDER_ID,
                                        OR_ORDER.CAUSAL_ID,
                                        OR_ORDER.TASK_TYPE_ID,
                                        OR_ORDER.SAVED_DATA_VALUES,
                                        OR_ORDER.ORDER_STATUS_ID,
                                        OR_ORDER.IS_PENDING_LIQ,
                                        OR_ORDER.DEFINED_CONTRACT_ID,
                                        OR_ORDER.LEGALIZATION_DATE,
                                        OR_ORDER.EXTERNAL_ADDRESS_ID,
                                        OR_ORDER.OPERATING_UNIT_ID,
                                        OR_ORDER_ITEMS.ITEMS_ID,
                                        OR_ORDER_ITEMS.ORDER_ITEMS_ID,
                                        OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT,
                                        OR_ORDER_ITEMS.VALUE,
                                        OR_ORDER_ITEMS.TOTAL_PRICE,
                                        OR_ORDER_ACTIVITY.ACTIVITY_ID,
                                        OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID,
                                        OR_ORDER_ACTIVITY.VALUE_REFERENCE,
                                        AB_ADDRESS.GEOGRAP_LOCATION_ID,
                                        AB_ADDRESS.ADDRESS_ID
                                   FROM OR_ORDER,
                                        TASKTYPES,
                                        GE_CAUSAL,
                                        OR_ORDER_ITEMS,
                                        AB_ADDRESS,
                                        OR_ORDER_ACTIVITY
                                  WHERE /*+ Ubicaci�n: CT_BCReads.GetOrdersToGroup SAO424459 */
                                        OR_ORDER_ACTIVITY.ORDER_ID = OR_ORDER.ORDER_ID
                                    AND OR_ORDER_ITEMS.ORDER_ID = OR_ORDER.ORDER_ID
                                    AND OR_ORDER_ITEMS.ORDER_ITEMS_ID = OR_ORDER_ACTIVITY.ORDER_ITEM_ID
                                    AND AB_ADDRESS.ADDRESS_ID = NVL(OR_ORDER_ACTIVITY.ADDRESS_ID, OR_ORDER.EXTERNAL_ADDRESS_ID)
                                    AND GE_CAUSAL.CLASS_CAUSAL_ID = OR_BOCONSTANTS.CNUSUCCESSCAUSAL
                                    AND GE_CAUSAL.CAUSAL_ID = OR_ORDER.CAUSAL_ID
                                    AND TASKTYPES.TASK_TYPE_ID = OR_ORDER.TASK_TYPE_ID
                                    AND (OR_ORDER.SAVED_DATA_VALUES IS NULL OR
                                         OR_ORDER.SAVED_DATA_VALUES != CT_BCREADS.CSBGROUPEDTOKEN)
                                    AND OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED
                                    AND OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES
                                    AND OR_ORDER.DEFINED_CONTRACT_ID = INUCONTRACTID
                                    AND TRUNC(OR_ORDER.LEGALIZATION_DATE) <= IDTMAXDATE
                                    ORDER BY TRUNC(OR_ORDER.LEGALIZATION_DATE)
                                ) AS CT_TYTBORDERSTOLIQ
                    )
        INTO IOTBFOUNDORDERS
        FROM DUAL;

        UT_TRACE.TRACE('Finaliza CT_BCReads.GetOrdersToGroup',2);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',3);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',3);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END GETORDERSTOGROUP;
    
    

















    PROCEDURE GETREADTASKTYPES
    (
        IOSBREADTASKTYPES  IN  OUT NOCOPY  VARCHAR2
    )
    IS
        CURSOR CUREADACT IS
            SELECT  /*+ index(IDX_OR_TASK_TYPES_ITEMS01) */
                    OR_TASK_TYPES_ITEMS.TASK_TYPE_ID
            FROM    OR_TASK_TYPES_ITEMS
            WHERE   OR_TASK_TYPES_ITEMS.ITEMS_ID IN (GE_BOITEMSCONSTANTS.CNUREADINGACTIVITY, CM_BOCONSTANTS.CNUBIL_ACTIVITY_READING);

    BEGIN
    
        UT_TRACE.TRACE('Inicia CT_BCReads.GetReadTaskTypes',2);

        IOSBREADTASKTYPES := ',';
        
        FOR RC IN CUREADACT LOOP
            IOSBREADTASKTYPES := IOSBREADTASKTYPES||RC.TASK_TYPE_ID||',';
        END LOOP;
        
        UT_TRACE.TRACE('Finaliza CT_BCReads.GetReadTaskTypes',2);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',3);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',3);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END GETREADTASKTYPES;


END CT_BCREADS;