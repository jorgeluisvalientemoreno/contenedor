select distinct /*+ index(OR_ORDER PK_OR_ORDER)
                                                                                                                       index(OR_RELATED_ORDER IX_OR_RELATED_ORDER01)*/
                --UNIQUE SBORDERRELATBYORDERATTRIBUTES,
                 OR_ORDER.Order_Id,
                (select description
                   FROM ge_transition_type
                  WHERE transition_type_id =
                        OR_RELATED_ORDER.rela_order_type_id) relation_type
  FROM /*+ GetOrderRelatByOrderPno.GetOrderRelatByOrderPno SAO207537 */
       OR_ORDER,
       OR_RELATED_ORDER
 WHERE OR_ORDER.ORDER_ID = OR_RELATED_ORDER.RELATED_ORDER_ID
 START WITH OR_RELATED_ORDER.ORDER_id = 351493313
CONNECT BY OR_RELATED_ORDER.ORDER_id = PRIOR related_order_id;

select oro.*, rowid
  from open.or_related_order oro
 where oro.order_id = 351493313;

select oro.*, rowid
  from open.or_related_order oro
 where oro.order_id in
       (351750940, 353122281, 353122348, 353063015, 353063099);
