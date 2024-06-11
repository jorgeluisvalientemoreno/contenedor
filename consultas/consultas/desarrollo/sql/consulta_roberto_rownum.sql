with tabla as( 
 select product_id, address_id, geograp_location_id, cantidad,  row_number() over ( partition by geograp_location_id order by geograp_location_id) filas
 from (
 select product_id, di.address_id, di.geograp_location_id, tabla.cantidad
 from pr_product p, ab_address di, 
 (SELECT 55 PRODUCTO, 3 CANTIDAD FROM DUAL UNION
  SELECT 5 PRODUCTO, 6 CANTIDAD FROM DUAL ) tabla 
 where p.address_id=di.address_id
 and di.geograp_location_id=tabla.producto
 order by dbms_random.value) 
 )
 select tabla.* 
 from tabla, (SELECT 55 PRODUCTO, 3 CANTIDAD FROM DUAL UNION SELECT 5 PRODUCTO, 6 CANTIDAD FROM DUAL ) tabla2
 where tabla.geograp_location_id=tabla2.PRODUCTO
 and  tabla.filas<=tabla2.cantidad


with tabla as
(select p.product_id, lo.grupcodi, di.geograp_location_id,  row_number() over ( partition by lo.grupcodi order by lo.grupcodi) filas, p.subscription_id, gr.gruptamu, gr.grupdesc
from open.pr_product p, open.ab_address di, open.LDC_GRUPO_LOCALIDAD lo, open.ab_segments se, open.LDC_GRUPO gr
where p.address_id=di.address_id
  and di.geograp_location_id=lo.grloidlo
  and di.segment_id=se.segments_id
  and gr.grupcodi=lo.grupcodi
  and p.product_type_id = 7014
  and p.category_id = 1
  and di.address not like '%APT%'
  and di.address not like '%CASA%'
  and di.address not like '%PISO%'
  and di.address not like '%INT%'
  and ((se.operating_sector_id=lo.grloseop) or
      (lo.grloseop is null))
  and not exists ( select null
                from open.or_order_activity oa1
                    ,open.or_order ot1
                where ot1.created_date > add_months(sysdate,-6)
                    and ot1.order_id = oa1.order_id
                    and oa1.activity_id = 4000892
                    and oa1.task_type_id = 12244
                    and ot1.task_type_id = 12244
                    and oa1.product_id = p.product_id )
  order by dbms_random.value)
  select *
  from tabla
  where tabla.filas<=tabla.gruptamu
