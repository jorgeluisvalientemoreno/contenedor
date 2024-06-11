select mm.product_id,
       mp.package_type_id ,
       mm.package_id,
       mp.motive_status_id 
from open.mo_motive mm
inner join open.mo_packages mp on mm.package_id = mp.package_id
where mp.package_type_id in (100156,100237, 100246, 100321, 100294,100295,100306)
and mp.motive_status_id = 13
and mm.product_id = 50038004