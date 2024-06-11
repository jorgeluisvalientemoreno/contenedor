select pr.subscription_id,
       mm.product_id,
       mp.package_type_id ,
       mm.package_id,
       mp.motive_status_id,
       mp.request_date  
from open.mo_motive mm
inner join open.mo_packages mp on mm.package_id = mp.package_id
inner join open.pr_product pr on mm.product_id = pr.product_id
where mp.package_type_id in (100333)
and mp.motive_status_id = 13