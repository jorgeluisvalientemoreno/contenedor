select or_order_activity.product_id  "Producto",
       mo_packages.package_id  "# Solicitud", 
       or_order.order_id  "Orden",
       or_order.order_status_id || ' - ' || or_order_status.description as "Estado orden",
       or_order.task_type_id || '-  ' || initcap(or_task_type.description)  "Tipo de trabajo",
       case when or_order_comment.comment_type_id = 8963 then 'Si' 
            when or_order_comment.comment_type_id != 8963 then 'No' end  "Solicitud SAC asociada",
       or_order.causal_id || '-  ' || initcap(ge_causal.description)  "Causal",
       or_order.created_date  "Fecha de creacion"
from open.or_order
left join open.or_order_status  on or_order.order_status_id = or_order_status.order_status_id
left join open.or_order_activity on or_order_activity.order_id = or_order.order_id
left join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
left join open.or_operating_unit on or_operating_unit.operating_unit_id = or_order.operating_unit_id
left join open.ge_causal on ge_causal.causal_id = or_order.causal_id
left join open.ge_items on ge_items.items_id = or_order_activity.activity_id
left join open.mo_packages on mo_packages.package_id = or_order_activity.package_id 
left join open.ps_package_type on ps_package_type.package_type_id = mo_packages.package_type_id
left join open.ps_motive_status on mo_packages.motive_status_id = ps_motive_status.motive_status_id
left join open.or_order_comment on or_order_comment.order_id = or_order.order_id
where or_order_activity.product_id = 1038837
and or_order.task_type_id = 10450
and or_order.order_status_id in (5)
and or_order_comment.comment_type_id = 8963
order by or_order.created_date desc;

where or_order.order_id = 260907297

select or_order.order_id,
       or_order_comment.comment_type_id,
       or_order_comment.order_comment,
       or_order_comment.register_date
  from or_order
  left join open.or_order_comment on or_order_comment.order_id = or_order.order_id
 where or_order.order_id in (263493847)
 order by or_order_comment.register_date desc

select servsusc.sesunuse  "Producto", 
       servsusc.sesususc  "Contrato", 
       servsusc.sesuserv ||'- '|| servicio.servdesc  "Tipo de producto", 
       case when servsusc.sesuesfn = 'C' then 'Castigado' 
         when servsusc.sesuesfn = 'A' then 'Al dia' 
          when servsusc.sesuesfn = 'M' then 'En mora' 
           when servsusc.sesuesfn = 'D' then 'En deuda' end "Estado financiero", 
       servsusc.sesuesco ||'- '|| initcap(estacort.escodesc)  "Estado de corte",
       pr_product.product_status_id ||'- '|| ps_product_status.description  "Estado del producto"   
from open.servsusc
inner join open.servicio on servicio.servcodi = servsusc.sesuserv
inner join open.estacort on estacort.escocodi = servsusc.sesuesco  
inner join open.pr_product on pr_product.product_id = servsusc.sesunuse
inner join open.ps_product_status on ps_product_status.product_status_id = pr_product.product_status_id
where (servsusc.sesuesfn != 'C' and servsusc.sesuesco != 5)
and exists(select null 
           from open.or_order
           left join open.or_order_activity on or_order_activity.order_id = or_order.order_id
           left join open.or_order_comment on or_order_comment.order_id = or_order.order_id
           where or_order_activity.product_id = servsusc.sesunuse
           and  or_order.task_type_id = 10450
           and or_order.order_status_id in (5)
           and or_order_comment.comment_type_id = 8963)
and servsusc.sesunuse = 1038837
--AND pr_product.product_id in (50690031,50690031,1143967,1191031)

select servsusc.sesunuse  "Producto", 
       servsusc.sesususc  "Contrato", 
       servsusc.sesuserv ||'- '|| servicio.servdesc  "Tipo de producto", 
       case when servsusc.sesuesfn = 'C' then 'Castigado' 
         when servsusc.sesuesfn = 'A' then 'Al dia' 
          when servsusc.sesuesfn = 'M' then 'En mora' 
           when servsusc.sesuesfn = 'D' then 'En deuda' end "Estado financiero", 
       servsusc.sesuesco ||'- '|| initcap(estacort.escodesc)  "Estado de corte",
       pr_product.product_status_id ||'- '|| ps_product_status.description  "Estado del producto",
       ldc_marca_producto.suspension_type_id || '-  ' || ge_suspension_type.description  "Marca"   
from open.servsusc
inner join open.servicio on servicio.servcodi = servsusc.sesuserv
inner join open.estacort on estacort.escocodi = servsusc.sesuesco  
inner join open.pr_product on pr_product.product_id = servsusc.sesunuse
inner join open.ps_product_status on ps_product_status.product_status_id = pr_product.product_status_id
inner join open.ldc_marca_producto on ldc_marca_producto.id_producto = pr_product.product_id
inner join open.ge_suspension_type on ge_suspension_type.suspension_type_id = ldc_marca_producto.suspension_type_id
where (servsusc.sesuesfn != 'C' and servsusc.sesuesco != 5)
and not exists(select null 
           from open.or_order
           left join open.or_order_activity on or_order_activity.order_id = or_order.order_id
           left join open.or_order_comment on or_order_comment.order_id = or_order.order_id
           where or_order_activity.product_id = servsusc.sesunuse
           and  or_order.task_type_id = 10450
           and or_order.order_status_id in (5)
           and or_order_comment.comment_type_id = 8963)
and servsusc.sesunuse = 1038837

select or_order_activity.product_id  "Producto",
       or_order.order_id  "Orden",
       or_order.order_status_id || ' - ' || or_order_status.description as "Estado orden",
       or_order.task_type_id || '-  ' || initcap(or_task_type.description)  "Tipo de trabajo",
       or_order_comment.order_comment  "Observacion",
       or_order.causal_id || '-  ' || initcap(ge_causal.description)  "Causal"
from open.or_order
left join open.or_order_status  on or_order.order_status_id = or_order_status.order_status_id
left join open.or_order_activity on or_order_activity.order_id = or_order.order_id
left join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
left join open.ge_causal on ge_causal.causal_id = or_order.causal_id
left join open.or_order_comment on or_order_comment.order_id = or_order.order_id
where or_order.order_id = 261336187
and or_order_comment.comment_type_id = 1277
order by or_order.created_date desc;

select or_order_activity.product_id  "Producto",
       or_order.order_id  "Orden",
       or_order.order_status_id || ' - ' || or_order_status.description as "Estado orden",
       or_order.task_type_id || '-  ' || initcap(or_task_type.description)  "Tipo de trabajo",
       or_order.causal_id || '-  ' || initcap(ge_causal.description)  "Causal"
from open.or_order
left join open.or_order_status  on or_order.order_status_id = or_order_status.order_status_id
left join open.or_order_activity on or_order_activity.order_id = or_order.order_id
left join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
left join open.ge_causal on ge_causal.causal_id = or_order.causal_id
where or_order.order_id = 261336187

select mo_motive.product_id  "Producto",
       mo_packages.package_id  "# Solicitud", 
       mo_packages.package_type_id || '-  ' || ps_package_type.description as "Tipo de solicitud", 
       mo_packages.motive_status_id || '-  ' || ps_motive_status.description as "Estado solicitud", 
       or_order.order_id  "Orden",
       or_order.order_status_id || ' - ' || or_order_status.description as "Estado orden",
       or_order.operating_unit_id ||'- '|| initcap(or_operating_unit.name)  "Unidad",
       or_order.task_type_id || '-  ' || initcap(or_task_type.description)  "Tipo de trabajo",
       or_order_activity.activity_id ||'- '|| initcap(ge_items.description)   "Actividad",
       mo_packages.request_date   "Fecha de registro"
from open.mo_packages
left join open.mo_motive on mo_motive.package_id = mo_packages.package_id
left join open.pr_product on pr_product.product_id = mo_motive.product_id 
left join open.ps_motive_status on mo_packages.motive_status_id = ps_motive_status.motive_status_id
left join open.ps_package_type on ps_package_type.package_type_id = mo_packages.package_type_id
left join open.or_order_activity on or_order_activity.package_id = mo_packages.package_id
left join open.or_order on or_order.order_id = or_order_activity.order_id 
left join open.or_order_status  on or_order.order_status_id = or_order_status.order_status_id
left join open.or_operating_unit on or_operating_unit.operating_unit_id = or_order.operating_unit_id
left join open.ge_items on ge_items.items_id = or_order_activity.activity_id
left join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
where mo_motive.product_id = 1038837
order by mo_packages.request_date desc;

select *
from open.or_order_comment
where or_order_comment.order_id = 258232361

select or_order_activity.product_id  "Producto",
       or_order_activity.subscription_id  "Contrato",
       or_order.task_type_id ||'- '|| initcap(or_task_type.description)  "Tipo de trabajo",
       or_order_activity.package_id  "Solicitud",
        mo_packages.package_type_id || '-  ' || ps_package_type.description as "Tipo de solicitud",
              or_order.order_id  "Orden",
       or_order.order_status_id ||'- '|| or_order_status.description  "Estado",
       or_order.operating_unit_id ||'- '|| initcap(or_operating_unit.name)  "Unidad",
       ldc_marca_producto.suspension_type_id || '-  ' || ge_suspension_type.description  "Marca",
       or_order_activity.activity_id ||'- '|| initcap(ge_items.description)   "Actividad",
       or_order.created_date  "Fecha de creacion"
from open.or_order
inner join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
inner join open.or_order_status on or_order_status.order_status_id = or_order.order_status_id
inner join open.or_order_activity on or_order_activity.order_id = or_order.order_id
inner join open.ge_items on ge_items.items_id = or_order_activity.activity_id
inner join open.or_operating_unit on or_operating_unit.operating_unit_id = or_order.operating_unit_id
inner join open.pr_product on pr_product.product_id = or_order_activity.product_id
inner join open.ldc_marca_producto on ldc_marca_producto.id_producto = pr_product.product_id
inner join open.ge_suspension_type on ge_suspension_type.suspension_type_id = ldc_marca_producto.suspension_type_id
left join open.mo_packages on mo_packages.package_id = or_order_activity.package_id 
left join open.ps_package_type on ps_package_type.package_type_id = mo_packages.package_type_id
Where mo_packages.package_type_id in (100294)
and ldc_marca_producto.suspension_type_id = 103
and rownum = 1
order by or_order.created_date desc;
