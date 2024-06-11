select c.certificados_oia_id,
       c.id_contrato,
       c.id_producto,
       c.fecha_inspeccion,
       c.tipo_inspeccion,
       c.certificado,
       c.id_organismo_oia,
       c.resultado_inspeccion,
       c.status_certificado,
       c.fecha_registro,
       c.obser_rechazo,
       c.fecha_aprobacion,
       c.order_id,
       c.organismo_id,
       c.vaciointerno,
       c.fecha_reg_osf,
       c.fecha_apro_osf
  from open.ldc_certificados_oia c
 where c.fecha_aprobacion >= '06/10/2022'
   and c.status_certificado = 'A'
   and c.resultado_inspeccion in (2, 3)
   and c.id_contrato = 67257713
 order by c.fecha_aprobacion asc
