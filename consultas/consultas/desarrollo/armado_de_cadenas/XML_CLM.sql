select p.product_id, ---pkg_xml_soli_vsi.getSolicitudVSI(p.subscription_id,10, 'comentario de prueba', p.product_id, s.suscclie, null, null,sysdate, p.address_id, p.address_id, 4000056)
       p.subscription_id,
       p.address_id,
       p.category_id,
       p.subcategory_id,
       s.suscclie,
       di.address_parsed,
       di.geograp_location_id,
       pkg_xml_soli_calid_medic.getSolicitudSuspensionCLM(10,'PRUEBA',P.PRODUCT_ID,suscclie,101,50,5) xml_suspension,
       pkg_xml_soli_calid_medic.getSolicitudReconexionCLM(10,'PRUEBA',p.product_id,suscclie,101) xml_reconexion       
from open.pr_product p
left join ab_address di on di.address_id=p.address_id
inner join suscripc s on s.susccodi=p.subscription_id
where product_type_id=7014
