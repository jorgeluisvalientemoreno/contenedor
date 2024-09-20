select o.package_type_id, p.description, /*a.task_type_id,*/ sum(cargvalo)
  from open.cargos c, open.mo_packages o, open.ps_package_type p--, open.OR_order_activity a
 where cargcuco = -1
   and cargfecr >= '01-05-2015'
   and cargfecr <  '30-05-2015'
   and cargdoso like 'PP%'
   and to_number(substr(cargdoso, 4, 8)) in o.package_id -- a.package_id
   --and a.package_id = o.package_id
   and o.package_type_id = p.package_type_id
group by o.package_type_id, p.description--, a.task_type_id
