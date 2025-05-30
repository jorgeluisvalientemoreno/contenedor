--Contrato
select gc.valor_total_contrato,
       gc.valor_total_pagado,
       gc.valor_total_contrato - gc.valor_total_pagado TOTAL_DISPONIBLE
  from open.ge_contrato gc
 where gc.id_contrato = 6901;

--Acta
select gct.id_contratista || ' - ' || gct.descripcion Contratista,
       gc.id_tipo_contrato Tipo_Contrato,
       ga.id_acta,
       ga.nombre,
       decode(ga.id_tipo_acta,
              1,
              '1 - Liquidacion de Trabajos',
              2,
              '2 - Facturacion de Contratistas',
              3,
              '3 - Acta de Suspension',
              4,
              '4 - Acta de Reactivacion',
              5,
              '5 - Acta de Apertura',
              6,
              '6 - Acta de Modificacion',
              7,
              '7 - Acta de Anulacion',
              8,
              '8 - Acta de Inactivacion',
              ga.id_tipo_acta || ' - No esta definido') Tipo_Acta,
       ga.valor_total,
       ga.fecha_creacion,
       ga.fecha_cierre,
       ga.fecha_inicio,
       ga.fecha_fin,
       ga.estado,
       ga.id_base_administrativa,
       ga.id_contrato,
       ga.id_periodo,
       ga.numero_fiscal,
       ga.id_consecutivo,
       ga.fecha_ult_actualizac,
       ga.person_id,
       ga.is_pending,
       ga.contractor_id,
       ga.operating_unit_id,
       ga.value_advance,
       ga.terminal,
       ga.comment_type_id,
       ga.comment_,
       ga.extern_pay_date,
       ga.extern_invoice_num,
       ga.valor_liquidado
  from open.ge_acta ga
  left join open.ge_contrato gc
    on gc.id_contrato = ga.id_contrato
  left join open.ge_contratista gct
    on gct.id_contratista = gc.id_contratista
 where ga.id_acta in (228830);

--Detalle acta
select ga.*, rowid from open.ge_detalle_acta ga where ga.id_acta = 228830;

--Detalle acta
select a.*, rowid
  from OPEN.CT_ORDER_CERTIFICA a
 where a.certificate_id = 228830;

select sum(gda.valor_total) TOTAL_ACTA
  from open.ge_detalle_acta gda
 where gda.id_acta = 228830
   and gda.affect_contract_val = 'Y';

--Detalle de Acta
with ordenes as
 (select g.id_orden orden
    from open.ge_detalle_acta g
   where g.id_acta in (228830)
  --and g.id_items = 4000360
   group by g.id_orden)
select aa.geograp_location_id, gel.description
  from ordenes
 inner join open.or_order_activity ooa
    on ooa.order_id = ordenes.orden
 inner join open.ab_address aa
    on aa.address_id = ooa.address_id
 inner join open.ge_geogra_location gel
    on gel.geograp_location_id = aa.geograp_location_id
 group by aa.geograp_location_id, gel.description
 order by aa.geograp_location_id;
