--ordenes de solicitud 
select oo.order_id,
       oo.task_type_id,
       ott.description,
       oo.causal_id,
       oo.legalization_date,
       mp.package_type_id,
       ppt.description
  from open.or_order oo
 inner join open.or_order_activity ooa
    on ooa.order_id = oo.order_id
   and ooa.package_id = 213221608
 inner join open.mo_packages mp
    on mp.package_id = ooa.package_id
 inner join open.ps_package_type ppt
    on ppt.package_type_id = mp.package_type_id
 inner join open.or_task_type ott
    on ott.task_type_id = oo.task_type_id
