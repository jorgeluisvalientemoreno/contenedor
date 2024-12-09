select ce.* , mp.suspension_type_id, open.ldc_getedadrp(ce.id_producto)  edad_rp
from ldc_plazos_cert  ce
inner join ldc_marca_producto  mp  on mp.id_producto = ce.id_producto
where open.ldc_getedadrp(ce.id_producto) >= 55
and exists(select null
          from or_order_activity  a
          where ce.id_producto=a.product_id
          and a.activity_id in (100003630,100003629,100004600,100004601,100003631,100004602,4000056)
          and a.status='R')
and  noy exists(select null
              from mo_packages a1
              inner join mo_motive m on m.package_id=a1.package_id
              where ce.id_producto=m.product_id
              and a1.package_type_id=100306
              and a1.motive_status_id=13
                            and  exists (select null
                              from or_order_activity a2
                              where m.product_id=a2.product_id
                              and a2.package_id=a1.package_id
                              and a2.activity_id =4294820))