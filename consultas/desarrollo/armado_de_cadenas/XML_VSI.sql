select p.product_id, pkg_xml_soli_vsi.getSolicitudVSI(p.subscription_id,10, 'comentario de prueba', p.product_id, s.suscclie, null, null,sysdate, p.address_id, p.address_id, 4000056)
from open.pr_product p
inner join suscripc s on s.susccodi=p.subscription_id
where product_type_id=7014
