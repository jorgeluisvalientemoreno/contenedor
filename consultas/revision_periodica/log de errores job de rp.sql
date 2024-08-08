select *
from open.LDC_LOGERRLEORRESU e
where e.order_id=108271732
order by fechgene;


select distinct r.order_id, o.task_type_id,(select description from open.or_task_type t where t.task_type_id=o.task_type_id) desc_titr,
 product_status_id, p.product_id,
 (select ot.task_type_id from open.or_order ot where ot.order_id=r.ordepadre),
(select ot.operating_unit_id ||'-'|| open.daor_operating_unit.fsbgetname(ot.operating_unit_id) from open.or_order ot where ot.order_id=r.ordepadre)
from open.LDC_LOGERRLEORRESU r, open.or_order o, open.or_order_activity a, open.pr_product p
where r.order_id= o.order_id
and o.order_status_id not in (8, 12)
and a.order_id=o.order_id
and a.product_id=p.product_id;



with error as
(select *
from open.LDC_LOGERRLEORRESU e2
  where (order_id,FECHGENE) in (select e.order_id, max(e.FECHGENE)
from open.LDC_LOGERRLEORRESU e
group by order_id))

select distinct lo.geo_loca_father_id,(select de.description from open.ge_geogra_location de where de.geograp_location_id=lo.geo_loca_father_id) desc_depa,
       lo.geograp_location_id, lo.description,
       o.created_date,
       r.order_id, 
       o.order_status_id,
       a.package_id,
       o.task_type_id,
(select description from open.or_task_type t where t.task_type_id=o.task_type_id) desc_titr,
 product_status_id, p.product_id,
 r.ordepadre orden_padre,
 (select ot.task_type_id from open.or_order ot where ot.order_id=r.ordepadre) titr_padre,
 (select ot.execution_final_date from open.or_order ot where ot.order_id=r.ordepadre) fecha_fina,
(select ot.operating_unit_id ||'-'|| open.daor_operating_unit.fsbgetname(ot.operating_unit_id,null) from open.or_order ot where ot.order_id=r.ordepadre) unidad,
(select error.menserror from error where error.order_id=r.order_id),
(select error.FECHGENE from error where error.order_id=r.order_id),
(select value_1 from open.or_requ_data_value where order_id=r.ordepadre   and name_1='LDC_LECTTOMSUSP') lectura,
a.activity_id
from open.LDC_LOGERRLEORRESU r, open.or_order o, open.or_order_activity a, open.pr_product p, open.ab_address di, open.ge_geogra_location lo
where r.order_id= o.order_id
and o.order_status_id not in (8, 12)
and a.order_id=o.order_id
and a.product_id=p.product_id
and di.address_id=p.address_id
and di.geograp_location_id=lo.geograp_location_id
and o.order_id=197972171 
--and o.order_id in (142033030, 142033130, 142033132,142033230)
and (select error.menserror from error where error.order_id=r.order_id)  like '%La lectura no puede ser mayor%'
--and (select error.menserror from error where error.order_id=r.order_id)   like '%No se han registrado lecturas para el equipo%'
--and (select error.menserror from error where error.order_id=r.order_id) not  like  '%Error legalizando orden de reconexion 120622-No se han registrado lecturas para el equipo%'
