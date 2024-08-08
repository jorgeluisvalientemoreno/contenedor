-- Cancelacion polizas ALFA
select p.description, m.* from open.mo_packages m, OPEN.PS_PACKAGE_TYPE p
 where m.package_id in (183844931) and m.package_type_id = p.package_type_id;
select t.description, a.*
  from open.or_order_Activity a, open.or_task_type t
   where a.Package_Id = 183844931 and a.task_type_id = t.task_type_id;
select * from open.or_order_items o where o.order_id in (238862962,238862963);
select * from open.cargos c where c.cargnuse = 52169176;
select * from open.ge_detalle_acta a where a.id_orden in (238862962,238862963)

