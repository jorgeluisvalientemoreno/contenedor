select ga.id_acta Acta,
       ga.nombre Nombre,
       decode(ga.id_tipo_acta,
              '1',
              '1 - Liquidacion de Trabajos',
              '2',
              '2 - Facturacion de Contratistas',
              '3',
              '3 - Acta de Suspension',
              '4',
              '4 Acta de Reactivacion',
              '5',
              '5 Acta de Apertura',
              '6',
              '6  Acta de Modificacion',
              '7',
              '7  Acta de Anulacion',
              '8',
              '8 Acta de Inactivacion') Tipo_Acta,
       ga.valor_total,
       ga.fecha_creacion,
       ga.fecha_cierre,
       ga.fecha_inicio,
       ga.fecha_fin,
       decode(ga.estado, 'A', 'A - ABIERTA', 'C', 'C - CERRADA') Estado,
       ga.id_contrato Contrato,
       ga.id_base_administrativa || ' - ' || gba.descripcion Base_ADministrativa,
       ga.id_periodo || ' - ' || GPC.NOMBRE Periodo_Certificacion,
       ga.numero_fiscal,
       ga.id_consecutivo Consecutivo,
       ga.fecha_ult_actualizac Fecha_Ultima_Actualizacion,
       ga.person_id Persona,
       decode(ga.is_pending, 1, '1 - SI', 0, '0 - NO') Pendiente_Regenerar,
       ga.contractor_id || ' - ' || gc.nombre_contratista Contratista,
       ga.operating_unit_id Unidad_Operativa,
       ga.value_advance Anterior_Anticipo_Contrato,
       ga.terminal,
       ga.comment_type_id || ' - ' || gct.description Tipo_Comentario,
       ga.comment_ Comentario,
       ga.extern_pay_date Fecha_Pago,
       ga.extern_invoice_num Factura_Pago,
       ga.valor_liquidado
  from open.ge_acta ga
  left join OPEN.GE_BASE_ADMINISTRA GBA
    on gba.id_base_administra = ga.id_base_administrativa
  left join OPEN.GE_PERIODO_CERT GPC
    on gpc.id_periodo = ga.id_periodo
  left join OPEN.GE_COMMENT_TYPE GCT
    on gct.comment_type_id = ga.comment_type_id
  left join OPEN.GE_CONTRATISTA GC
    on gc.id_contratista = ga.contractor_id
 where ga.estado = 'A'
   and ga.fecha_creacion > sysdate - 100
 order by ga.fecha_creacion desc;
select gc.*, rowid from open. ge_contrato gc where gc.id_contrato = 5165; --1194;
