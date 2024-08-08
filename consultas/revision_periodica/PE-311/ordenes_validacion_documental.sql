select c.tipo_inspeccion,
       d.certificados_oia_id,
       c.certificado,
       c.fecha_aprobacion,
       c.id_contrato,
       c.resultado_inspeccion,
       c.status_certificado,
       c.obser_rechazo,
       d.observacion,
       d.estado,
       d.order_id,
       o.task_type_id,
       ao.activity_id,
       o.order_status_id,
       o.operating_unit_id,
       co.person_id,
       o.causal_id,
       o.execution_final_date,
       co.order_comment
  from open.ldc_genordvaldocu d
 inner join open.ldc_certificados_oia  c on c.certificados_oia_id = d.certificados_oia_id
 left join  open.or_order o on o.order_id = d.order_id
 left join  or_order_activity ao on ao.order_id = d.order_id
 left join  or_order_comment co on co.order_id = d.order_id
 where c.fecha_aprobacion >= '06/10/2022'
   and c.id_contrato = 67250418
 order by c.fecha_aprobacion desc
