select DALDC_PARAREPE.FSBGETPARAVAST('LDC_FLAGVALTIPOFECHA', NULL)
  from dual;
SELECT /*+ index (a IDX_LDC_PLAZOS_CERT01) */
 * -- 'X'
  FROM ldc_plazos_cert a
 WHERE plazo_min_suspension >
       sysdate + nvl(open.Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',
                                                             NULL),
                     0) --
   --AND is_notif IN ('YV', 'YR')
      --AND a.ID_PRODUCTO = inuProducto
      --and (select count(1) from pr_product b where b.product_id = a.ID_PRODUCTO and b.suspen_ord_act_id is null) = 0
   /*and (select count(d.order_id)
          from or_order_activity d
         where d.order_activity_id =
               (select b.suspen_ord_act_id
                  from pr_product b
                 where b.product_id = a.id_producto)
           and d.task_type_id = 12457) > 0*/
   and (select y.susccicl
          from suscripc y
         where y.susccodi = A.ID_PRODUCTO) = 301
   and (select X.SESUESCO
          from SERVSUSC X
         where X.SESUSUSC = A.ID_PRODUCTO
           AND X.SESUSERV = 7014
           AND ROWNUM = 1) = 1;
