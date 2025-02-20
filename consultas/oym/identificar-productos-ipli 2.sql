with productos as(select p.product_id,
       p.subscription_id,
       di.address_id,
       di.geograp_location_id,
       de.grupcodi
from open.pr_product p
inner join open.ab_address di on di.address_id=p.address_id
inner join open.ldc_grupo_localidad de  on de.grloidlo = di.geograp_location_id and di.address not like '%APT%'
  and di.address not like '%CASA%'
  and di.address not like '%PISO%'
  and di.address not like '%INT%'
where p.product_type_id = 7014
  and p.product_status_id = 1
  and p.category_id = 1
)
, ordenes as(
select a.product_id,
       a.subscription_id,
       a.address_id,
       di.geograp_location_id,
       de.grupcodi,
       max(o.created_date) fecha_creacion
from open.or_order_activity a
inner join open.or_order o on o.order_id=a.order_id
inner join open.ab_address di on di.address_id = a.address_id
inner join open.ldc_grupo_localidad de  on de.grloidlo = di.geograp_location_id and de.grupcodi=30
where a.order_id > 65363139 -- primera orden creada
  and a.activity_id = 4000892
  and a.task_type_id = 12244
  and ( a.comment_ like 'MEDIDOR: %' or a.comment_ like 'TOMA %' )
group by a.product_id,
       a.subscription_id,
       a.address_id,
       di.geograp_location_id,
       de.grupcodi
)
,sin_orden as(
select product_id,
       subscription_id,
       address_id,
       geograp_location_id,
       grupcodi
from productos
minus
select product_id,
       subscription_id,
       address_id,
       geograp_location_id,
       grupcodi
from ordenes)
,sin_orden2 as(
select product_id,
       subscription_id,
       address_id,
       geograp_location_id,
       grupcodi
from productos
minus
select product_id,
       subscription_id,
       address_id,
       geograp_location_id,
       grupcodi
from ordenes
where fecha_creacion> add_months( trunc( sysdate-10, 'mm' ), -3 )
)
,sin_orden3 as(
select product_id,
       subscription_id,
       address_id,
       geograp_location_id,
       grupcodi
from productos
minus
select product_id,
       subscription_id,
       address_id,
       geograp_location_id,
       grupcodi
from ordenes
where fecha_creacion> add_months( trunc( sysdate-10, 'mm' ), -2 )
minus
select product_id,
       subscription_id,
       address_id,
       geograp_location_id,
       grupcodi
from sin_orden2)
, base as(
select 1 tipo,
       product_id,
       subscription_id,
       address_id,
       geograp_location_id,
       grupcodi
from sin_orden
union 
select 2 tipo,
       product_id,
       subscription_id,
       address_id,
       geograp_location_id,
       grupcodi
from sin_orden2
union
select 3 tipo,
       product_id,
       subscription_id,
       address_id,
       geograp_location_id,
       grupcodi
from sin_orden3)
,base2 as(
select base.product_id,
       base.subscription_id,
       base.address_id,
       base.tipo,
       base.grupcodi,
       gruptamu,
       row_number() over ( partition by base.grupcodi order by base.grupcodi) filas
from base
inner join open.LDC_GRUPO gr on gr.grupcodi = base.grupcodi
order by grupcodi,
         tipo,
         dbms_random.value)
select *
from base2
where filas<=gruptamu         



       
