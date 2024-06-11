select contpadre,
       direprhi,
       fechregi,
       fechulmo,
       terminal,
       estado,
       s.package_id,
       s.package_type_id,
       s.motive_status_id,
       subscription_id,
       product_id             
from open.ldc_conttsfa f
left join open.mo_packages s on f.direprhi = s.address_id
left join open.mo_motive m on m.package_id = s.package_id
left join  open.servsusc  s on sesunuse = m.product_id
where estado in ('S')
and s.package_type_id = 271
and s.motive_status_id = 13
order by fechulmo desc ;