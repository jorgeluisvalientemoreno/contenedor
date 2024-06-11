select s.subscription_id,
       d.package_id,
       d.package_type_id,
       d.motive_status_id
from open.mo_motive s
inner join open.mo_packages d on s.package_id = d.package_id
where s.subscription_id in (select contanul from open.ldc_contanve)
and d.package_type_id = 271
and d.motive_status_id = 13; 