select mo.product_id "producto",mo.subscription_id "contrato",m.package_id "solicitud" , request_date "fecha registro",m.package_type_id || ' -'|| ps.description  "tipo solicitud",  m.motive_status_id ||' -' || pm.description "estado"
from open.mo_packages m
left join  open.mo_motive mo on m.package_id = mo.package_id
left join  open.ps_package_type ps on ps.package_type_id= m.package_type_id 
left join  open.ps_motive_status pm on pm.motive_status_id = m.motive_status_id
where m.package_id  = 198021771
and m.request_date > '19/07/2023'