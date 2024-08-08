select a.id_acta,
       a.nombre descripcion_acta,
       c.id_contrato,
       c.id_tipo_contrato,
       open.dage_tipo_contrato.fsbgetdescripcion(c.id_tipo_contrato, null) desc_tipo_contra,
       c.id_contratista,
       open.dage_subscriber.fsbgetsubscriber_name(co.subscriber_id, null) || ' ' ||
       open.dage_subscriber.fsbgetsubs_last_name(co.subscriber_id, null) nombre,
       id_tipo_acta,
       decode(id_tipo_acta, 1, 'Liquidacion Trabajos',
                            2, 'Facturacion a Contratistas',
                            3, 'Acta de suspensión',
                            4, 'Acta de reactivación',
                            5, 'Acta de apertura',
                            6, 'Acta de Modificación',
                            7, 'Acta de Anulación',
                            8,'Acta de Inactivación') desc_tipo_acta,
       a.estado, 
       decode(a.estado, 'A', 'Abierto', 'C', 'Cerrado') desc_estado_acta,
       a.fecha_creacion,
       a.fecha_cierre,
       a.valor_total,
       a.valor_liquidado,
       usu_gen_acta,
       usu_cer_acta
  from open.ge_acta a
  left join open.ldc_audi_actas au on au.id_acta = a.id_acta
  left join open.ge_contrato c on c.id_contrato = a.id_contrato
  left join open.ge_contratista co on co.id_contratista = c.id_contratista
 where c.id_tipo_contrato = 932
   and a.estado in ('A')
   and a.fecha_creacion >= '14/09/2022'
   
