with tabla as
(select distinct a.product_id
from open.or_order_Activity a,open.or_order o
where o.order_status_id in (0,11)
  and o.task_type_id in (12164)
  and o.operating_unit_id is null
  and o.order_id=a.order_id
union
select  distinct a.product_id
from open.or_order_Activity a,open.or_order o, open.mo_packages p
where o.order_status_id in (0,11)
  and o.task_type_id in (10446)
  and o.operating_unit_id is null
  and o.order_id=a.order_id
  and p.package_id=a.package_id
  and p.package_type_id=100101
  
minus
select product_id
from open.mo_packages p, open.mo_motive m
where m.motive_type_id = 75
and p.package_type_id in (100294, 100295)
and  m.package_id=p.package_id
minus
select a.product_id
from open.or_order_Activity a,open.or_order o
where o.operating_unit_id  in (2420,2421)
  and o.order_id=a.order_id
minus
select product_id
from open.pr_certificate c
where c.estimated_end_date>='01/01/2017'
minus
select distinct a.product_id
from open.or_order_Activity a,open.or_order o
where o.order_status_id in (0,5,7,11)
  and o.task_type_id in (10444,10795,12161, 10445,10723,12475,10714,10715,10716,10717,10718,10719,10720,10721,10722,12453,12487,10011)
  and o.order_id=a.order_id
minus
select  distinct a.product_id
from open.or_order_Activity a,open.or_order o, open.mo_packages p
where o.order_status_id in (0,5,7,11)
  and o.task_type_id in (10339,12135,12136,12138,12140,12139,12142,12143,12148,12147)
  and o.order_id=a.order_id
  and p.package_id=a.package_id
  and p.package_type_id!=100101
minus
select distinct a.product_id
from open.or_order_Activity a,open.or_order o
where o.order_status_id in (5,7,11)
  and o.task_type_id in (12164)
  and o.operating_unit_id is not null
  and o.order_id=a.order_id
minus
select  distinct a.product_id
from open.or_order_Activity a,open.or_order o, open.mo_packages p
where o.order_status_id in (5,7,11)
  and o.task_type_id in (10446)
  and o.operating_unit_id is not null
  and o.order_id=a.order_id
  and p.package_id=a.package_id
  and p.package_type_id=100101
)
select TABLA.PRODUCT_ID,
(SELECT GE.GEOGRAP_LOCATION_ID||'-'||GE.DESCRIPTION FROM OPEN.AB_ADDRESS DI , OPEN.GE_GEOGRA_LOCATION GE WHERE GE.GEOGRAP_LOCATION_ID=DI.GEOGRAP_LOCATION_ID AND DI.ADDRESS_ID=P.ADDRESS_ID),
a.order_id, a.task_type_id, a.operating_unit_id,
(select order_status_id from open.or_order o where o.order_id=a.order_id)
from tabla, open.pr_product p,  open.or_order_Activity a
where p.product_id=tabla.product_id
 and p.category_id<3
-- and tabla.product_id=1012053
 and exists(select null from open.prodproyecrevper90k k where k.product_id=p.product_id) 
 --and exists(select null from open.ldc_marca_producto m where m.id_producto=p.product_id and m.suspension_type_id in (102))
and (p.product_status_id=1 or (product_status_id=2 and (select count(*) from open.pr_prod_suspension su where su.product_id=tabla.product_id and active='Y' and suspension_type_id in (101,102,103)) =0))
AND  a.product_id=P.product_id 
and a.task_type_id in (10444, 10446,12161,12164, 10449, 10450, 12457,10011,10339,10445,10714,10715,10716,10717,10718,10719,10720,10721,10722,10723,10795,12135,12136,12138,12139,12140,12142,12143,12147,12148,12453,12475,12487) 
and status='R'
