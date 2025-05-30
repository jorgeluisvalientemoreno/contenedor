SELECT RE.ORDER_ID,
       RE.RELATED_ORDER_ID,
       RE.RELA_ORDER_TYPE_ID,
       O.TASK_TYPE_ID,
       O.CAUSAL_ID,
       O.ORDER_STATUS_ID,
       O.LEGALIZATION_DATE,
       O.OPERATING_UNIT_ID,
       A.ACTIVITY_ID,
       (select description
                   FROM open.ge_transition_type
                  WHERE transition_type_id =
                        RE.rela_order_type_id) relation_type
  FROM OPEN.OR_RELATED_ORDER RE
  LEFT JOIN OPEN.OR_ORDER O
    ON RE.RELATED_ORDER_ID = O.ORDER_ID
  LEFT JOIN OPEN.OR_ORDER_ACTIVITY A
    ON O.ORDER_ID = A.ORDER_ID
 WHERE O.ORDER_ID = RE.RELATED_ORDER_ID
 START WITH RE.ORDER_id = 351493313
CONNECT BY RE.ORDER_id = PRIOR related_order_id;
select distinct /*+ index(OR_ORDER PK_OR_ORDER) index(OR_RELATED_ORDER IX_OR_RELATED_ORDER01)*/
                --UNIQUE SBORDERRELATBYORDERATTRIBUTES,
                 OR_ORDER.Order_Id,
                (select description
                   FROM open.ge_transition_type
                  WHERE transition_type_id =
                        OR_RELATED_ORDER.rela_order_type_id) relation_type
  FROM /*+ GetOrderRelatByOrderPno.GetOrderRelatByOrderPno SAO207537 */
       open.OR_ORDER,
       open.OR_RELATED_ORDER
 WHERE OR_ORDER.ORDER_ID = OR_RELATED_ORDER.RELATED_ORDER_ID
 START WITH OR_RELATED_ORDER.ORDER_id = 351493313
CONNECT BY OR_RELATED_ORDER.ORDER_id = PRIOR related_order_id;
