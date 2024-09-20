-- Ejecutar el 1 de cada mes a primera hora.
select distinct  r.charge_status, /*a.package_id,*/ o.package_type_id,  p.description, a.task_type_id, t.description --, sum(cargvalo)
  from open.cargos c, open.OR_order_activity a, open.or_task_type t, open.ps_package_type p, open.mo_packages o, open.or_order r
 where cargcuco = -1
   and cargfecr >= '01-05-2015'
   and cargfecr <  '30-05-2015'
   and cargdoso like 'PP%'
   and to_number(substr(cargdoso, 4, 8)) = a.package_id
   and a.task_type_id = t.task_type_id
   and a.package_id = o.package_id
   and o.package_type_id = p.package_type_id
   and a.order_id = r.order_id
   and r.charge_status = '3'
-- ESTADO DE GENERACION DE CARGO [1] NO GENERO, [2] PENDIENTE, [3] GENERADO, [4] NO ENCONTRO TARIFA   
