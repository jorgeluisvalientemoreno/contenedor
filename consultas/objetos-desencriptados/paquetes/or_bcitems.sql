CREATE OR REPLACE PACKAGE BODY OR_BCITEMS IS
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO190748';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE PROCESSITEMDELETED( INUORDER IN OR_ORDER.ORDER_ID%TYPE )
    IS
      CURSOR CUITEMDELETED( INUORDER IN OR_ORDER.ORDER_ID%TYPE ) IS
SELECT ORDER_ITEMS_ID, ITEMS_ID, ASSIGNED_ITEM_AMOUNT
            FROM or_order_items
            WHERE or_order_items.order_id = inuOrder
            minus
            SELECT TEMP_ORDER_ITEMS_ID, ITEMS_ID, ASSIGNED_ITEM_AMOUNT
            FROM or_temp_order_items
            WHERE or_temp_order_items.order_id = inuOrder;
      NUOPERUNIT OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE;
    BEGIN
      NUOPERUNIT := DAOR_ORDER.FNUGETOPERATING_UNIT_ID( INUORDER );
      FOR RCITEMDELETED IN CUITEMDELETED( INUORDER )
       LOOP
         UPDATE Or_Ope_Uni_Item_Bala
            SET    Balance = Balance + nvl(rcItemDeleted.ASSIGNED_ITEM_AMOUNT,0)
            WHERE  Items_Id = rcItemDeleted.ITEMS_ID
              AND  Operating_Unit_Id = nuOperUnit;
      END LOOP;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE PROCESSITEMINSERTED( INUORDER IN OR_ORDER.ORDER_ID%TYPE )
    IS
      CURSOR CUGETACTIVITIES IS
SELECT * FROM OR_TEMP_ORDER_ITEMS
            WHERE or_temp_order_items.order_id = inuOrder
            AND exists
            (select * FROM ge_items
                WHERE item_classif_id = or_boorderactivities.cnuActivityType AND
                    ge_items.items_id = or_temp_order_items.items_id );
    BEGIN
      UT_TRACE.TRACE( 'Inicia OR_BCITEMS.ProcessItemInserted ORDER_id[' || INUORDER || ']', 15 );
      DELETE FROM or_order_items WHERE or_order_items.order_id = inuOrder
        AND not exists
            (select * FROM ge_items
                WHERE item_classif_id IN
                    (or_boorderactivities.cnuActivityType,
                     ge_boitemsconstants.cnuCLASIFICACION_EQUIPO) AND
                    ge_items.items_id = or_order_items.items_id );
      INSERT INTO or_order_items (    ORDER_ID,
                                        ITEMS_ID,
                                        ASSIGNED_ITEM_AMOUNT,
                                        LEGAL_ITEM_AMOUNT,
                                        VALUE,
                                        ORDER_items_id,
                                        element_code,
                                        element_id,
                                        order_activity_id,
                                        reused,
                                        out_
                                    )
            SELECT  or_temp_order_items.ORDER_ID,
                    or_temp_order_items.ITEMS_ID,
                    or_temp_order_items.ASSIGNED_ITEM_AMOUNT,
                    or_temp_order_items.LEGAL_ITEM_AMOUNT,
                    or_temp_order_items.VALUE,
                    or_temp_order_items.temp_ORDER_items_id,
                    or_temp_order_items.element_code,
                    or_temp_order_items.element_id,
                    or_temp_order_items.order_activity_id,
                    or_temp_order_items.reused,
                    nvl(or_temp_order_items.out_, decode(ge_item_classif.quantity_control,
                                Or_BOConstants.cnuIncrease, ge_boconstants.csbNO,
                                Or_BOConstants.cnuDecrease, ge_boconstants.csbYES,
                                or_temp_order_items.out_
                          )) out_
            FROM or_temp_order_items, ge_items, ge_item_classif
            /*+ OR_BCItems.ProcessItemInserted SAO185809 */
            WHERE or_temp_order_items.order_id = inuOrder
            AND   ge_items.items_id = or_temp_order_items.items_id
            AND   ge_items.item_classif_id =  ge_item_classif.item_classif_id
            AND   ge_items.item_classif_id not in (or_boorderactivities.cnuActivityType,
                                          ge_boitemsconstants.cnuCLASIFICACION_EQUIPO)
            AND NOT EXISTS
            (select 'X' FROM OR_order_items
                WHERE OR_order_items.order_items_id = or_temp_order_items.temp_ORDER_items_id);
      FOR RGACTIVITIES IN CUGETACTIVITIES
       LOOP
         UT_TRACE.TRACE( ' UpdateOrderItemsProcessed: ' || RGACTIVITIES.TEMP_ORDER_ITEMS_ID, 15 );
         UPDATE OR_ORDER_ITEMS
                SET legal_item_amount = nvl(rgActivities.legal_item_amount,0),
                    value = nvl(rgActivities.value,value),
                    OUT_ = ge_boconstants.csbYES
                WHERE  ORDER_items_id = rgActivities.temp_order_items_id;
      END LOOP;
      UT_TRACE.TRACE( 'Finaliza OR_BCITEMS.ProcessItemInserted ', 15 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FNUGETTEMPITEMID( INUORDERID IN OR_TEMP_ORDER_ITEMS.ORDER_ID%TYPE, INUITEMID IN OR_TEMP_ORDER_ITEMS.ITEMS_ID%TYPE )
    RETURN NUMBER
    IS
      NUTEMPITEMID OR_TEMP_ORDER_ITEMS.TEMP_ORDER_ITEMS_ID%TYPE := NULL;
      CURSOR CUTEMPITEMID IS
SELECT temp_order_items_id
            FROM or_temp_order_items
            WHERE order_id = inuOrderId
            AND   items_id = inuItemId
            AND   rownum   = 1;
    BEGIN
      FOR REG IN CUTEMPITEMID
       LOOP
         NUTEMPITEMID := REG.TEMP_ORDER_ITEMS_ID;
      END LOOP;
      RETURN ( NUTEMPITEMID );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE GETITEMSBYORDER( INUORDERID IN OR_ORDER_ITEMS.ORDER_ID%TYPE, OTBORORDERITEMS OUT DAOR_ORDER_ITEMS.TYTBOR_ORDER_ITEMS, ONUCOUNT OUT NUMBER )
    IS
    BEGIN
      OTBORORDERITEMS.DELETE;
      OPEN OR_BCITEMS.CUITEMSINORDER( INUORDERID );
      FETCH OR_BCITEMS.CUITEMSINORDER
         BULK COLLECT INTO OTBORORDERITEMS;
      CLOSE OR_BCITEMS.CUITEMSINORDER;
      ONUCOUNT := OTBORORDERITEMS.COUNT;
    EXCEPTION
      WHEN OTHERS THEN
         IF OR_BCITEMS.CUITEMSINORDER%ISOPEN THEN
            CLOSE OR_BCITEMS.CUITEMSINORDER;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETITEMSBYORDER;
   PROCEDURE TRASLATEITEMSTOTMPITEM( INUORDERID IN OR_ORDER.ORDER_ID%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( 'Inicia OR_BCITEMS.TraslateItemsToTmpItem inuOrderId[' || INUORDERID || ']', 15 );
      DELETE FROM or_temp_order_items WHERE or_temp_order_items.order_id = inuOrderId;
      INSERT INTO or_temp_order_items (   order_id,
                                            items_id,
                                            assigned_item_amount,
                                            legal_item_amount,
                                            value,
                                            temp_order_items_id,
                                            element_code,
                                            element_id,
                                            order_activity_id,
                                            reused,
                                            OUT_
                                        )
            SELECT  order_id,
                    items_id,
                    assigned_item_amount,
                    legal_item_amount,
                    value,
                    order_items_id,
                    element_code,
                    element_id,
                    order_activity_id,
                    reused,
                    OUT_
            FROM or_order_items
            WHERE or_order_items.order_id = inuOrderId;
      UT_TRACE.TRACE( 'Finaliza OR_BCITEMS.TraslateItemsToTmpItem ', 15 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FSBALLOWREUSED( INUITEMSID IN GE_ITEMS.ITEMS_ID%TYPE )
    RETURN VARCHAR2
    IS
      SBALLOW VARCHAR2( 1 );
      NUCLASSIF GE_ITEMS.ITEM_CLASSIF_ID%TYPE;
    BEGIN
      IF INUITEMSID IS NOT NULL THEN
         NUCLASSIF := DAGE_ITEMS.FNUGETITEM_CLASSIF_ID( INUITEMSID );
         IF NUCLASSIF = 9 THEN
            SBALLOW := 'Y';
          ELSE
            SBALLOW := 'N';
         END IF;
      END IF;
      RETURN SBALLOW;
   END FSBALLOWREUSED;
   PROCEDURE GETLEGALIZATIONITEMS( INUORDERID IN OR_ORDER_ITEMS.ORDER_ID%TYPE, OTBORORDERITEMS OUT DAOR_ORDER_ITEMS.TYTBOR_ORDER_ITEMS )
    IS
      CSBYES VARCHAR2( 1 ) := OR_BOCONSTANTS.CSBSI;
      CSBNOT VARCHAR2( 1 ) := OR_BOCONSTANTS.CSBNO;
      CURSOR CULEGALIZATIONITEMS( INUORDERID IN OR_ORDER.ORDER_ID%TYPE ) IS
SELECT a.*, a.rowid
            FROM  or_order_items a
            WHERE a.order_id = inuOrderId
            AND a.legal_item_amount >= 0
            AND NOT EXISTS
                ( SELECT 1
                  FROM   or_order_activity
                  WHERE  or_order_activity.order_item_id = a.order_items_id
                  AND    nvl(or_order_activity.compensated,csbNot) = csbYes
                );
    BEGIN
      OTBORORDERITEMS.DELETE;
      OPEN CULEGALIZATIONITEMS( INUORDERID );
      FETCH CULEGALIZATIONITEMS
         BULK COLLECT INTO OTBORORDERITEMS;
      CLOSE CULEGALIZATIONITEMS;
    EXCEPTION
      WHEN OTHERS THEN
         IF CULEGALIZATIONITEMS%ISOPEN THEN
            CLOSE CULEGALIZATIONITEMS;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETLEGALIZATIONITEMS;
END OR_BCITEMS;
/


