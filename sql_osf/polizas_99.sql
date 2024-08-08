select *
from
(
select m.request_date , m.package_type_id, pt.description, a.*,
       (select (listagg(p.policy_number, '; ') within group(order by p.policy_number)) as Polizas
          from open.ld_policy p where p.product_id = a.product_id and p.state_policy  in (2,3,4,7)) poliza,
       (select count(*)
          from open.or_order_activity ooa where ooa.product_id = a.product_id and ooa.package_id = m.package_id) ot            
  from open.mo_packages m, open.or_order_Activity a, open.ps_package_type pt      
 where a.package_id = m.package_id
   and m.package_type_id in (100231, 100266)
   and m.request_date >= '01-01-2021'
   and pt.package_type_id = m.package_type_id
   and m.motive_status_id = 14
--   and a.product_id = 52190707
) where poliza is null; -- and nvl(ot,0) > 1;
select * from open.ld_policy p where p.product_id = 52190707;
select * from open.cargos c where cargnuse = 52190707;
select * from open.notas n where notanume = 83975580;
select * from open.causcarg where cacacodi = 72
   
