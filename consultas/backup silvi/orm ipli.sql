
with productos_sin_ot  as

(select p.product_id, lo.grupcodi, di.geograp_location_id,  row_number() over ( partition by lo.grupcodi order by lo.grupcodi) filas, p.subscription_id, gr.gruptamu, gr.grupdesc
from open.pr_product p, open.ab_address di, open.LDC_GRUPO_LOCALIDAD lo, open.ab_segments se, open.LDC_GRUPO gr
where p.address_id=di.address_id
  and di.geograp_location_id=lo.grloidlo
  and di.segment_id=se.segments_id
  and gr.grupcodi=lo.grupcodi
  and p.product_type_id = 7014
  and p.category_id = 1
  and p.product_status_id=1
  and di.address not like '%APT%'
  and di.address not like '%CASA%'
  and di.address not like '%PISO%'
  and di.address not like '%INT%'
  and ((se.operating_sector_id=lo.grloseop) or
      (lo.grloseop is null))
  and not exists ( select null
                from open.or_order_activity oa1
                    ,open.or_order ot1
                where ot1.order_id = oa1.order_id
                    and oa1.activity_id = 4000892
                    and oa1.task_type_id = 12244
                    and ot1.task_type_id = 12244
                    and oa1.product_id = p.product_id )
  order by dbms_random.value),
  
  productos_sin_ot_filtrado AS (
    select *
    from productos_sin_ot
    where filas <= gruptamu
),  

  contador_m1 as ( 
  select grupcodi , gruptamu , count (distinct product_id )m1 ,( gruptamu - count (distinct product_id ) ) faltantes
  from productos_sin_ot_filtrado
  group by grupcodi , gruptamu ),
  
  productos_sin_ot_12  as

(select p.product_id, lo.grupcodi, di.geograp_location_id,  row_number() over ( partition by lo.grupcodi order by lo.grupcodi) filas, p.subscription_id, gr.gruptamu, gr.grupdesc,faltantes
from open.pr_product p, open.ab_address di, open.LDC_GRUPO_LOCALIDAD lo, open.ab_segments se, open.LDC_GRUPO gr , contador_m1
where p.address_id=di.address_id
  and di.geograp_location_id=lo.grloidlo
  and di.segment_id=se.segments_id
  and gr.grupcodi=lo.grupcodi
  and gr.grupcodi=contador_m1.grupcodi
  and contador_m1.faltantes>0
  and p.product_type_id = 7014
  and p.category_id = 1
  and p.product_status_id=1
  and di.address not like '%APT%'
  and di.address not like '%CASA%'
  and di.address not like '%PISO%'
  and di.address not like '%INT%'
  and ((se.operating_sector_id=lo.grloseop) or
      (lo.grloseop is null))
  and not exists ( select null
                from open.or_order_activity oa1
                    ,open.or_order ot1
                where ot1.created_date > add_months(sysdate,-3)
                    and ot1.order_id = oa1.order_id
                    and oa1.activity_id = 4000892
                    and oa1.task_type_id = 12244
                    and ot1.task_type_id = 12244
                    and oa1.product_id = p.product_id )
  order by dbms_random.value) ,
  
  productos_sin_ot_12_filtrado AS (
    SELECT *
    FROM productos_sin_ot_12
    WHERE filas <= faltantes ),
    
  contador_m2 as ( 
  select grupcodi , gruptamu , count (distinct product_id )m2 ,( faltantes - count (distinct product_id ) ) faltantes
  from productos_sin_ot_12_filtrado
  group by grupcodi , gruptamu,faltantes ),
  
/* select product_id, grupcodi, geograp_location_id, subscription_id, gruptamu, grupdesc
 from productos_sin_ot_filtrado
 union all 
 select product_id, grupcodi, geograp_location_id, subscription_id, gruptamu, grupdesc
 from productos_sin_ot_12_filtrado
 */


 productos_sin_ot_24  as

(select p.product_id, lo.grupcodi, di.geograp_location_id,  row_number() over ( partition by lo.grupcodi order by lo.grupcodi) filas, p.subscription_id, gr.gruptamu, gr.grupdesc,faltantes
from open.pr_product p, open.ab_address di, open.LDC_GRUPO_LOCALIDAD lo, open.ab_segments se, open.LDC_GRUPO gr , contador_m2
where p.address_id=di.address_id
  and di.geograp_location_id=lo.grloidlo
  and di.segment_id=se.segments_id
  and gr.grupcodi=lo.grupcodi
  and gr.grupcodi=contador_m2.grupcodi
  and contador_m2.faltantes>0
  and p.product_type_id = 7014
  and p.category_id = 1
  and p.product_status_id=1
  and di.address not like '%APT%'
  and di.address not like '%CASA%'
  and di.address not like '%PISO%'
  and di.address not like '%INT%'
  and ((se.operating_sector_id=lo.grloseop) or
      (lo.grloseop is null))
  and not exists ( select null
                from open.or_order_activity oa1
                    ,open.or_order ot1
                where ot1.created_date > add_months(sysdate,-2)
                    and ot1.order_id = oa1.order_id
                    and oa1.activity_id = 4000892
                    and oa1.task_type_id = 12244
                    and ot1.task_type_id = 12244
                    and oa1.product_id = p.product_id )
   and not exists ( select null
                    from productos_sin_ot_12_filtrado 
                    where  productos_sin_ot_12_filtrado.product_id = p.product_id)
  order by dbms_random.value),
 
productos_sin_ot_24_filtrado as (
    select *
    from productos_sin_ot_24
    where filas <= faltantes )

select product_id, grupcodi, geograp_location_id, subscription_id, gruptamu, grupdesc
 from productos_sin_ot_filtrado
 union all 
 select product_id, grupcodi, geograp_location_id, subscription_id, gruptamu, grupdesc
 from productos_sin_ot_12_filtrado
