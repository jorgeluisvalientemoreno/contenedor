--reparaciones sin ot solo ssuspension notificacion

with tabla as
(select k.product_id
from open.prodproyecrevper90k k, open.pr_product p
where exists(select null from open.ldc_marca_producto m where m.id_producto=k.product_id and m.suspension_type_id in (103))
and not exists(select null from open.or_order_activity ot where ot.product_id=k.product_id and ot.operating_unit_id in (2420,2421))
and p.product_id=k.product_id
and p.category_id<3
and (p.product_status_id=1 or (product_status_id=2 and (select count(*) from open.pr_prod_suspension su where su.product_id=p.product_id and active='Y' and suspension_type_id in (101,102,103)) =0))
minus

select a.product_id
from open.or_order_Activity a,open.or_order o
where o.order_status_id in (0,5,7,11)
  and o.task_type_id in (10795,10444,10445,10446,10723,12161,12164,12475,10714,10715,10716,10717,10718,10719,10720,10721,10722,12453,12487,10011)
  and o.order_id=a.order_id
  

minus

select   a.product_id
from open.or_order_Activity a,open.or_order o, open.mo_packages p
where o.order_status_id in (0,5,7,11)
  and o.task_type_id in (10339,12135,12136,12138,12140,12139,12142,12143,12148,12147)
  and o.order_id=a.order_id
  and p.package_id=a.package_id
  and p.package_type_id!=100101
  
minus
select product_id
from open.mo_packages p, open.mo_motive m
where m.motive_type_id = 75
and p.package_type_id in (100294, 100295)
and  m.package_id=p.package_id
minus
select product_id
from open.pr_certificate c
where c.estimated_end_date>='01/01/2017'
)
select TABLA.PRODUCT_ID, A.ORDER_ID, A.TASK_TYPE_ID, A.OPERATING_UNIT_ID, (SELECT ORDER_STATUS_ID FROM OPEN.OR_ORDER O WHERE O.ORDER_ID=a.ORDER_ID),
      GE.GEOGRAP_LOCATION_ID,GE.DESCRIPTION,
      (SELECT DE.GEOGRAP_LOCATION_ID||'-'||DE.DESCRIPTION FROM OPEN.GE_GEOGRA_LOCATION DE WHERE DE.GEOGRAP_LOCATION_ID=GE.GEO_LOCA_FATHER_ID)
      
from tabla, open.pr_product p left join open.or_order_Activity a on a.product_id=p.product_id and a.task_type_id in (10795,10444,10445,10446,10723,12161,12164,12475,10714,10715,10716,10717,10718,10719,10720,10721,10722,12453,12487,10011) and status='R', open.ab_address di,  OPEN.GE_GEOGRA_LOCATION GE 
where p.product_id=tabla.product_id
  and GE.GEOGRAP_LOCATION_ID=DI.GEOGRAP_LOCATION_ID 
  AND DI.ADDRESS_ID=P.ADDRESS_ID
