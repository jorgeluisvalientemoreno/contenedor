alter session set current_schema=open;
SELECT  CAST
                    (
                        MULTISET
                                (
                                 WITH TASKTYPES AS
                                 (
                                    
                                    SELECT  OR_TASK_TYPE.TASK_TYPE_ID
                                    FROM    OR_TASK_TYPE
                                    WHERE   INSTR(','||'12626,12617,12626,10043'||',', CONCAT(',',CONCAT(TO_CHAR(OR_TASK_TYPE.TASK_TYPE_ID),','))) != 0
                                    UNION
                                    
                                    SELECT  OR_TASK_TYPES_ITEMS.TASK_TYPE_ID
                                    FROM    OR_TASK_TYPES_ITEMS
                                    WHERE   OR_TASK_TYPES_ITEMS.ITEMS_ID IN (102008, 4294337)
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
                                    AND GE_CAUSAL.CLASS_CAUSAL_ID = 1
                                    AND GE_CAUSAL.CAUSAL_ID = OR_ORDER.CAUSAL_ID
                                    AND TASKTYPES.TASK_TYPE_ID = OR_ORDER.TASK_TYPE_ID
                                    AND (OR_ORDER.SAVED_DATA_VALUES IS NULL OR
                                         OR_ORDER.SAVED_DATA_VALUES != 'ORDER_GROUPED')
                                    AND OR_ORDER.ORDER_STATUS_ID = 8
                                    AND OR_ORDER.IS_PENDING_LIQ = 'Y'
                                    and or_order.operating_unit_id in (4439, 4440, 4441)
                                    AND TRUNC(OR_ORDER.LEGALIZATION_DATE) <= sysdate
                                    ORDER BY TRUNC(OR_ORDER.LEGALIZATION_DATE)
                                ) AS CT_TYTBORDERSTOLIQ
                    )
        FROM DUAL;
