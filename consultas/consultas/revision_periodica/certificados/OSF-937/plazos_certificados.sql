Select o.certificados_oia_id,
       o.id_contrato,
       o.id_producto,
       o.fecha_inspeccion,
       o.tipo_inspeccion,
       o.certificado,
       o.order_id,
       o.organismo_id,
       o.resultado_inspeccion,
       o.status_certificado,
       o.fecha_reg_osf,
       o.fecha_apro_osf,
       o.fecha_registro,
       o.obser_rechazo,
       o.fecha_aprobacion,
       o.vaciointerno
From open.ldc_certificados_oia  o
where o.id_producto in (50106618)
order by o.fecha_inspeccion desc;

Select *
From open.ldc_plazos_cert t
Where t.id_producto in (50106618);

select *
from open.pr_certificate c
where c.product_id in (50106618)
order by c.register_date desc;

