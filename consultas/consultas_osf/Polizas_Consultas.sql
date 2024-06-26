select p.description, m.* from open.mo_packages m, OPEN.PS_PACKAGE_TYPE p
 where m.package_id in (186267912) and m.package_type_id = p.package_type_id;
select * from open.mo_motive m where m.package_id =  186267912;
select * from open.or_order_Activity a where a.Package_Id = 186267912;
select * from open.or_order o where o.order_id = 245775219;
select * from open.ge_causal g where g.causal_id = 9441;
select * from open.ld_policy p where p.policy_number = 1603276012; --66301478; -- 829206. 907595
--17114023; -- p.product_id = 51761243;
select * from OPEN.LD_POLICY_STATE;
select * from open.cargos p where cargnuse = 51966033  /*51429050*/;
--
-- Se debe revisar el proceso ya que se detuvo el flujo pro haber cargos con cuentas de cobro a la -1, 
-- no genero las ordenes respectivas, 
-- 10239 = 10247
-- cancelo la poliza y no debio.
