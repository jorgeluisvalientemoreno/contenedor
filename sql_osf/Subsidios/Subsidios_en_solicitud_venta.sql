select ASIG_SUBSIDY_ID || '-S' codigo,
       ooa.product_id,
       oo.order_id,
       oo.order_status_id,
       ooa.package_id,
       ooa.register_date Regsitro_Solicitud
  from OPEN.LDC_LOGERCODAVE   a,
       open.or_order          oo,
       open.ld_asig_subsidy   asu,
       open.ld_subsidy        su,
       open.or_order_activity ooa,
       open.hicaespr          hcep
 where 1 = 1
   and a.order_id = oo.order_id
   and a.order_id = asu.order_id
   AND asu.delivery_doc = 'N' --ld_boconstans.csbNOFlag
   AND asu.state_subsidy <> 5 --ld_boconstans.cnuSubreverstate
   AND Asu.subsidy_id = su.subsidy_id
   AND OO.ORDER_STATUS_ID = 0
   and oo.order_id = ooa.order_id
   and ooa.product_id = hcep.hcetnuse
   and hcep.hcetepac = 1
   and hcep.hcetepan = 15
 ORDER BY A.FECHERROR DESC;
