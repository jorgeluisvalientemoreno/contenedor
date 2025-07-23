select distinct /*+ index(oo PK_OR_ORDER) index(oro IX_OR_RELATED_ORDER01)*/
                oo.Order_Id Orden_Hija,
                (select description
                   FROM open.ge_transition_type
                  WHERE transition_type_id = oro.rela_order_type_id) Tipo_Relaciona,
                oo.task_type_id || ' - ' || ott.description Tipo_Trabajo,
                oo.created_date Fecha_Creacion
  FROM /*+ GetOrderRelatByOrderPno.GetOrderRelatByOrderPno SAO207537 */
       open.OR_ORDER         oo,
       open.OR_RELATED_ORDER oro,
       open.or_task_type     ott
 WHERE oo.ORDER_ID = oro.RELATED_ORDER_ID
   and ott.task_type_id = oo.task_type_id
 START WITH oro.ORDER_id = 351493313
CONNECT BY oro.ORDER_id = PRIOR related_order_id
 order by oo.created_date desc;
