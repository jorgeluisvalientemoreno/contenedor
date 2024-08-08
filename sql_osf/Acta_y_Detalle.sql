--Contrato
select gc.valor_total_contrato,
       gc.valor_total_pagado,
       gc.valor_total_contrato - gc.valor_total_pagado TOTAL_DISPONIBLE
  from open.ge_contrato gc
 where gc.id_contrato = 6901;

--Acta
select ga.*, rowid from open.ge_acta ga where ga.id_acta = 6668;

--Detalle acta
select a.*, rowid
  from OPEN.CT_ORDER_CERTIFICA a
 where a.certificate_id = 6668;

select sum(gda.valor_total) TOTAL_ACTA
  from open.ge_detalle_acta gda
 where gda.id_acta = 6668
   and gda.affect_contract_val = 'Y';

--Detalle de Acta
with ordenes as
 (select g.id_orden orden
    from open.ge_detalle_acta g
   where g.id_acta in (6668)
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
