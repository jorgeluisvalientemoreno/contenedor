with base as(select c.id_producto,p.category_id, p.product_status_id, open.ldc_getedadrp(c.id_producto) edad, suspension_type_id, register_por_Defecto
from open.ldc_marca_producto c
inner join open.pr_product p on p.product_id=c.id_producto
where open.ldc_getedadrp(c.id_producto)<55)
select base.id_producto, 
       base.category_id categoria,
       base.product_status_id,
       base.edad,
       sol.package_id solicitud,
       sol.package_type_id tipo_sol,
       open.daps_package_type.fsbgetdescription(sol.package_type_id, null) desc_tipo_sol,
       ot.order_id, 
       ot.task_type_id,
       open.daor_task_type.fsbgetdescription(ot.task_type_id ,null) desc_titr,
       ot.order_status_id,
       nvl(suspension_type_id, 101) marca,
       register_por_defecto,
       (select max(review_date) from open.pr_certificate c where c.product_id=base.id_producto) fecha_ult_rev
from base 
left join (select m.product_id, p.package_id, p.package_type_id, p.motive_status_id from open.mo_motive m, open.mo_packages p where p.package_id=m.package_id and p.package_type_id in (100237,100294,100295,100321,100156,100246) and p.motive_status_id=13) sol on sol.product_id=base.id_producto
left join (select o.order_id, a.package_id, o.task_type_id, o.order_status_id from open.or_order_Activity a , open.or_order o where o.order_id=a.order_id and o.task_type_id in (100444,10723,10833,10795,10449,10450,12457,10834,10835,10836,12460) and o.order_status_id in (0,5,6,7,11)) ot on ot.package_id=sol.package_id
