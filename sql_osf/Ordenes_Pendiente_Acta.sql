SELECT /*+ index(or_order idx_or_order_3)     
     ,     leading(or_order)                  
     ,     use_nl(or_order ct_excluded_order) 
     ,     use_nl(ct_excluded_order ec)       
     ,     use_nl(ca cc)                    */
 OR_ORDER.ORDER_ID ORDER_ID,
 OR_ORDER.numerator_id || ' - ' || OR_ORDER.sequence numerator,
 OR_ORDER.TASK_TYPE_ID || ' - ' ||
 OR_boBasicDataServices.fsbGetDescTaskType(OR_ORDER.TASK_TYPE_ID) TASK_TYPE,
 OR_ORDER.ORDER_STATUS_ID || ' - ' ||
 daor_order_status.fsbGetDescription(OR_ORDER.ORDER_STATUS_ID) ORDER_STATUS,
 OR_ORDER.OPERATING_SECTOR_ID || ' - ' ||
 OR_boBasicDataServices.fsbGetDescOperatinSector(OR_ORDER.OPERATING_SECTOR_ID) OPERATING_SECTOR,
 or_bobasicdataservices.fnuGetProductId(or_order.order_id) PRODUCT_ID,
 OR_ORDER.OPERATING_UNIT_ID || ' - ' ||
 OR_boBasicDataServices.fsbGetDescOperatingUnit(OR_ORDER.OPERATING_UNIT_ID) OPERATING_UNIT,
 OR_ORDER.CREATED_DATE CREATED_DATE,
 OR_ORDER.ASSIGNED_DATE ASSIGNED_DATE,
 OR_ORDER.ASSIGNED_WITH || ' - ' ||
 decode(OR_ORDER.ASSIGNED_WITH,
        'S',
        'Horario',
        'O',
        'Cantidad de Órdenes',
        'N',
        'Demanda',
        'R',
        'Ruta',
        null) ASSIGNED_WITH,
 OR_ORDER.EXEC_ESTIMATE_DATE EXEC_ESTIMATE_DATE,
 OR_ORDER.MAX_DATE_TO_LEGALIZE MAX_DATE_TO_LEGALIZE,
 OR_ORDER.REPROGRAM_LAST_DATE REPROGRAM_LAST_DATE,
 OR_ORDER.LEGALIZATION_DATE LEGALIZATION_DATE,
 OR_ORDER.EXEC_INITIAL_DATE EXEC_INITIAL_DATE,
 OR_ORDER.EXECUTION_FINAL_DATE EXECUTION_FINAL_DATE,
 OR_ORDER.CAUSAL_ID || ' - ' ||
 Ge_boBasicDataServices.fsbGetDescCausal(OR_ORDER.CAUSAL_ID) CAUSAL,
 OR_boBasicDataServices.fnuGetOrderPersonId(OR_ORDER.ORDER_ID,
                                            OR_ORDER.OPERATING_UNIT_ID) ||
 ' - ' ||
 Ge_boBasicDataServices.fsbGetDescPerson(OR_boBasicDataServices.fnuGetOrderPersonId(OR_ORDER.ORDER_ID,
                                                                                    OR_ORDER.OPERATING_UNIT_ID)) PERSON,
 OR_ORDER.ORDER_VALUE ORDER_VALUE,
 OR_ORDER.PRINTING_TIME_NUMBER PRINTING_TIME_NUMBER,
 OR_ORDER.LEGALIZE_TRY_TIMES LEGALIZE_TRY_TIMES,
 OR_ORDER.IS_COUNTERMAND IS_COUNTERMAND,
 OR_ORDER.REAL_TASK_TYPE_ID || ' - ' ||
 OR_boBasicDataServices.fsbGetDescTaskType(OR_ORDER.REAL_TASK_TYPE_ID) REAL_TASK_TYPE,
 OR_ORDER.PRIORITY PRIORITY,
 OR_BOBasicDataServices.fsbGetProgClassDesc(or_order.order_id) PROGCLASDESC,
 OR_ORDER.ARRANGED_HOUR ARRANGED_HOUR,
 or_order.consecutive CORSCOPR,
 or_order.route_id RUSERUTA,
 (select OR_route.Name
    FROM OR_route
   WHERE OR_route.route_id = or_order.route_id) ROUTE_NAME,
 OR_bobasicdataservices.fsbGetAddress_parsed(or_order.order_id) ADDRESS_PARSED,
 or_bobasicdataservices.fsbGetDescNeighborthood(or_order.order_id) NEIGHBORTHOOD,
 or_bobasicdataservices.fsbGetDescGeograLocation(or_order.order_id) GEOGRAP_LOCATION,
 or_bobasicdataservices.fnuGetSubscriberId(or_order.order_id) SUBSCRIBER_ID,
 or_bobasicdataservices.fsbGetDescSubcrName(or_order.order_id) SUBSC_NAME,
 or_bobasicdataservices.fsbGetDescSubcrLastName(or_order.order_id) SUBSC_LAST_NAME,
 daor_order_comment.fsbGetOrder_comment(or_bcordercomment.fnuGetLastComment(or_order.order_id),
                                        0) ORDER_COMMENT,
 daor_order_comment.fnuGetComment_type_id(or_bcordercomment.fnuGetLastComment(or_order.order_id),
                                          0) || ' - ' ||
 decode(daor_order_comment.fnuGetComment_type_id(or_bcordercomment.fnuGetLastComment(or_order.order_id),
                                                 0),
        null,
        NULL,
        dage_comment_type.fsbgetdescription(daor_order_comment.fnuGetComment_type_id(or_bcordercomment.fnuGetLastComment(or_order.order_id),
                                                                                     0))) COMMENT_TYPE,
 --:parent_id parent_id,
 ct_excluded_order.final_exclusion_date,
 ec.comment_type_id || '-' ||
 dage_comment_type.fsbgetdescription(ec.comment_type_id, 0) || '-' ||
 ec.order_comment exclusion_comment,
 or_order.defined_contract_id
/*+ Ge_BofwCertifContratista.getFatherOrderWCer SAO214316 */
  FROM or_order,
       ct_excluded_order,
       or_order_comment  ec,
       ge_causal         ca,
       ge_class_causal   cc
 WHERE or_order.operating_unit_id = 4250
   AND or_order.order_status_id = 8
   AND or_order.is_pending_liq in ('Y', 'E')
   AND ct_excluded_order.order_id(+) = or_order.order_id
   AND ct_excluded_order.order_comment_id = ec.order_comment_id(+)
   AND or_order.causal_id = ca.causal_id
   AND ca.class_causal_id = cc.class_causal_id
   AND cc.class_causal_id = or_boconstants.fnuSuccesCausal
   AND NOT EXISTS
 (SELECT /*+  index(or_order_activity IDX_OR_ORDER_ACTIVITY_05) 
                                                                         index(ct_item_novelty PK_CT_ITEM_NOVELTY) 
                                                                    */
         'X'
          FROM ct_item_novelty, or_order_activity
         WHERE ct_item_novelty.items_id = or_order_activity.activity_id
           AND or_order_activity.order_id = or_order.order_id);
