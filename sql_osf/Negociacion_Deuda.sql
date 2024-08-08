select * from gc_debt_negotiation a where a.package_id = 186560874;
select *
  from OPEN.GC_DEBT_NEGOT_PROD T
 where t.debt_negotiation_id = 1240340;
select *
  from OPEN.GC_DEBT_NEGOT_CHARGE nc
 where nc.debt_negot_prod_id = 1242229;
select *
  from diferido d
 where d.difecodi in (95912396, 95912398, 95912399, 95912397);
select * from cc_financing_request a where a.package_id = 186560874;
select *
  from cc_fin_req_concept a
 where a.financing_request_id = 186560874;
--select mm.*,rowid from open.mo_motive mm where mm.subscription_id = 6216329 order by 1 desc;
