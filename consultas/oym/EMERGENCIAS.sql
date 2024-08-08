select * from open.wf_unit_type where unit_type_id in (select unit_type_id from open.ps_package_unittype where package_type_id in (100101))  
select p.package_id, p.request_date, p.package_type_id,  m.product_id, m.subscription_id
from open.mo_packages p, open.mo_motive m
where package_type_id in (59, 100101,308)
 and p.motive_Status_id=13
 and m.package_id=p.package_id
 and p.request_Date>='13/06/2016'
 and not exists(select null from open.or_order_Activity a where a.package_id=p.package_id)
 
select * from open.ge_mobile_event where sent_init_date is  null;
