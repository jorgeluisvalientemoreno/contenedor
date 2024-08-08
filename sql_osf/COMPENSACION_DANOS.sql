select mp.*, rowid
  from open.TT_DAMAGE_PRODUCT mp
 WHERE MP.PACKAGE_ID = 186548816;

select mp.*, rowid
  from open.pr_timeout_component mp
 WHERE MP.PACKAGE_ID = 186548816;

select mp.*, rowid from open.mo_packages mp where mp.package_id = 65622920;
select mm.*, rowid from open.mo_motive mm where mm.package_id = 65622920;
select mp.*, rowid
  from open.tt_damage mp
 where
--mp.reg_damage_status = 'A'
 mp.package_id = 65622920;
select oo.*, rowid
  from open.or_order oo
 where oo.task_type_id = 10256
   and oo.order_status_id = 7;
select mp.*, rowid
  from open.tt_damage_product mp
 where mp.package_id = 65622920;
select mp.*, rowid
  from open.pr_timeout_component mp
 where mp.package_id = 65622920;
select mp.*, rowid
  from open.pr_component mp
 where mp.product_id in (select mp1.product_id
                           from open.tt_damage_product mp1
                          where mp1.package_id = 65622920);

select mp.*, rowid
  from open.pr_timeout_component mp
 WHERE MP.PACKAGE_ID = 186548815;
