SELECT a.*, a.ROWID
  FROM or_order a /*+ ldc_bss_bcconstructora.cuLastOrder*/
 WHERE a.order_id IN
       (SELECT max(b.order_id)
          FROM or_order_activity b
         WHERE b.product_id = 1467137
           AND b.subscription_id = 1203519
           AND b.task_type_id in
               (dald_parameter.fnugetNumeric_Value('LDC_TT_NOTI_CONST', 0),
                dald_parameter.fnugetNumeric_Value('LDC_TT_SUSP_CONST', 0),
                dald_parameter.fnugetNumeric_Value('LDC_TT_RECON_CONST', 0)))
   AND a.order_status_id in
       (0,
        5,
        8);
