select mp.*, rowid
  from open.mo_packages mp
 where mp.package_id = 191239579;
select mp.*, rowid from open.mo_motive mp where mp.package_id = 191239579;
select cc.*, rowid
  from open.CC_SALES_FINANC_COND cc
 where cc.initial_payment > 0
   and cc.package_id in (191239579, 191249154);
select *
  from open.MO_GAS_SALE_DATA cc
 where cc.package_id in (191239579, 191249154);
