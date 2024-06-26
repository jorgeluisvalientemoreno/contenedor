-- Valida proceso polizas
select * from open.cargos where cargnuse = 52367680;
select t.description, a.* from open.or_order_activity a, open.or_task_type t
 where a.package_id = 186686958 and a.product_id = 52367680 and a.task_type_id = t.task_type_id;
select * from open.mo_packages m, open.ps_package_type p where m.package_id = 186686958 and p.package_type_id = m.package_type_id;
select c.class_causal_id, o.* from open.or_order o, open.ge_causal c where o.order_id = 246938845 and o.causal_id = c.causal_id
