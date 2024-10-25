     SELECT orda.package_id,
            ordi.items_id,
            SUM(ordi.legal_item_amount) legal_item_amount
      FROM open.or_order_activity orda,
           open.or_order ord,
           open.or_order_items ordi,
           open.ge_items gei
     WHERE orda.order_id = ord.order_id
       and orda.task_type_id IN (10771)
       --(select To_Number(column_value)from table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('LDCTITRAVALIDAR', NULL), ',')))
       and ord.order_id <> 171682105
       and orda.package_id = 91320839
       and ordi.order_id = orda.order_id
       and ord.order_status_id IN (select l.numeric_value from open.ld_parameter l where l.parameter_id='COD_ORDER_STATUS') --DALD_PARAMETER.fnuGetNUMERIC_VALUE('COD_ORDER_STATUS', NULL)
       and gei.items_id = ordi.items_id
       and gei.item_classif_id IN (51)--(select To_Number(column_value) from table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('LDCTPORDLEGITEM', NULL), ',')))
       and gei.items_id NOT IN (100008302,100008303)--(select To_Number(column_value) from table (ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('LDCPAITEMSEXCLU', NULL), ',')))

     /*and orda.TASK_TYPE_ID IN
       (SELECT ID_TRABCERT
          FROM LDC_TRAB_CERT
         WHERE ID_TRABCERT NOT IN
               (select to_number(column_value)
                  from table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('CODIGO_TT_ASOCIADAS',
                                                                                           NULL),
                                                          ','))

                                                          )

                                                          )*/
   GROUP BY orda.package_id, ordi.items_id;
