select pp.subscription_id, pps.*
  from pr_product pp, pr_prod_suspension pps
 where 1 = 1
   and pps.product_id = pp.product_id
   and pp.suspen_ord_act_id is null
   and not exists (select a.product_id
          from OPEN.PR_PROD_SUSPENSION a
         where a.product_id = pp.product_id
           and a.active = 'Y')
   and pp.product_type_id = 7014
 order by pps.product_id, pps.register_date desc;
