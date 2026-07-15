select l.periodo_facturacion, l.fecha_inicio, L.CANTIDAD_REGISTRO, l.codigo_lote, count(distinct documento) uno,
       (select count(factcodi) from factura where factpefa=l.periodo_facturacion  and factprog=6) factura
from personalizaciones.factura_elect_general e
inner join personalizaciones.lote_fact_electronica l on l.tipo_documento=1
where e.codigo_lote=l.codigo_lote
  and l.fecha_inicio>='26/07/2024'
  AND L.CODIGO_LOTE!=9999999
  group by l.periodo_facturacion, l.fecha_inicio, l.codigo_lote, L.CANTIDAD_REGISTRO
  having count(distinct documento)!=(select count(factcodi) from factura where factpefa=l.periodo_facturacion  and factprog=6)
