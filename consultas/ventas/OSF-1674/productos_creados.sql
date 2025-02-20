select m.package_id solicitud,
       pr.subscription_id contrato,
       pr.product_id  producto,
       pr.product_status_id || ' ' || ps.description estado_producto,
       m.motiv_recording_date fecha_creacion,
       pr.address_id,
       a.address direccion,
       sesucate categoria,
       sesusuca subcategoria,
       mo.document_key numero_formulario,
       sesucicl
from mo_motive m 
left join  mo_packages mo on   m.PACKAGE_ID = mo.PACKAGE_ID 
left join pr_product pr on pr.product_id = m.product_id
left join servsusc s on sesunuse = pr.product_id 
left join ab_address a on pr.address_id = a.address_id
left join ab_segments  ab on a.segment_id = ab.segments_id
left join ps_product_status ps on pr.product_status_id = ps.product_status_id
where  m.package_id =  221718596;
