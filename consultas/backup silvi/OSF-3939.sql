select d.* ,  sol_cotizacion ,  m.package_id,  m.motive_status_id , mo.subscription_id , mo.product_id , l.fecha_registro  
from datos_cotizacion_comercial d 
left join ldc_cotizacion_comercial l on d.id_cot_comercial=l.id_cot_comercial
left join cc_quotation c  on  l.id_cot_comercial= c.quotation_id
left join open.mo_packages_asso a on  a.package_id_asso = sol_cotizacion
left join mo_packages m on m.package_id = a.package_id
left join mo_motive mo on m.package_id  = mo.package_id
where d.aiu_porcentaje !=25
and m.motive_status_id= 13
