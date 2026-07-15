/*alter session set current_schema=open;*/
​
--- Estado del producto
​
Select pp.product_id  producto, pp.subscription_id  contrato, pp.product_type_id  tipo_prod, pp.product_status_id  estado_Producto, ss.sesuesfn  estado_financiero, ss.sesuesco  estado_corte, ps.suspension_type_id  Tipo_Suspension, ps.active  Activa, ps.register_date  fecha_registro, ps.aplication_date  Fecha_Aplicacion,
ps.inactive_date  Fecha_Inactividad
from pr_product  pp
Inner join pr_prod_suspension ps on pp.product_id = ps.product_id
Inner join servsusc ss on pp.product_id = ss.sesunuse
Where pp.product_type_id = 7014
--And   ss.sesuesfn = 'C'
And   ss.sesuesco = 1
And   pp.product_status_id = 2
And   ps.suspension_type_id in (101,102,103,104)
And ps.active='Y'
--And ps.aplication_date >= '01/01/2020'
--and ss.sesucicl = 201
--and exists (select 'x' from ldc_usu_eva_cast cc where cc.producto = pp.product_id)
​
​
--And pp.product_id = 14523564
​
​
-- productos suspendidos por actividad de suspension
​
​
select p.product_id  Producto, p.subscription_id, open.ldc_getedadrp(p.product_id) edad_rp,  p.product_status_id   Estado_Producto, s.sesuesco  Estado_Corte, s.sesuesfn  Estado_Financiero, s2.suspeNsion_type_id  Tipo_Suspension, s2.active  Suspension_Activa, 
a.task_type_id  tipo_Trabajo, a.activity_id  Actividad_Suspension, it.description  Desc_Actividad_Suspension, a.register_date  Fecha_Registro --(select cc.cucosacu from cuencobr  cc where p.product_id = cc.cuconuse and cc.cucosacu > 10) Cuenta_Cobro
from open.pr_product p, open.servsusc s, open.pr_prod_suspeNsion s2, open.or_order_Activity a, ge_items it
where s.sesunuse=p.product_id
  and p.product_status_id=2
  and product_type_id=7014
  and p.producT_id =s2.product_id
 and s2.active='Y'
  and a.order_activity_id=p.suspen_ord_act_id
  and it.items_id= a.activity_id
  --and s2.suspeNsion_type_id in (101,103)
  --and a.task_type_id = 12457
 -- and s.sesuesco = 1
 
 
  And a.product_id in (50114244
​
​
)
​
​
​
​
​
-- Estado Componentes del Producto
​
select c2.cmssidco  compomente, c2.cmsssesu   producto, c4.register_date  fecha_registro, c4.aplication_date aplicacion, c4.inactive_date Fecha_Inactivo,
c2.cmssescm  Estado_Componente, c3.description Desc_Estado_Componente,
c4.suspension_type_id  Tipo_Suspension, c4.active  Suspension_Activa
From compsesu  c2,
     ps_product_status c3,
     pr_comp_suspension c4
Where c2.cmssescm = c3.product_status_id
And   c2.cmssidco = c4.component_id
And  c2.cmsssesu = 11002556
and  c4.active = 'Y'
​
-- validar componentes de la solicitud
​
select cs.component_id, cs.product_id, cs.package_id, cs.component_type_id, co.description, cs.motive_type_id, tc.description, cs.motive_status_id, ec.description,
cs.product_motive_id, mp.description, cs.status_change_date, cs.annul_date
from mo_component cs
inner join ps_motive_status ec on ec.motive_status_id = cs.motive_status_id
inner join ps_motive_type tc on tc.motive_type_id = cs.motive_type_id
inner join ps_product_motive mp on mp.product_motive_id = cs.product_motive_id
inner join ps_component_type co on co.component_type_id = cs.component_type_id
where cs.package_id in (160991043, 65950905, 11301236)
​
​
/*select pr.product_id,
       product_status_id,
       pr.component_id,
       pr.component_type_id,
       pr.component_status_id,
       open.daps_product_status.fsbgetdescription(pr.component_status_id, null) estado_comp_pr,
       s.cmssescm,
       open.daps_product_status.fsbgetdescription( s.cmssescm,  null) estado_comp_comp,
       sc.suspension_type_id,
       sc.active,
       sc.aplication_date,
       sc.inactive_date
from diana p
inner join open.pr_product on pr_product.product_id=p.producto
inner join open.pr_component pr on pr.product_id=p.producto
inner join open.compsesu s on s.cmsssesu=pr.product_id and s.cmssidco=pr.component_id
left join open.pr_comp_suspension sc on sc.component_id=pr.component_id and sc.active='Y'
;
​
select *
From open.pr_component  c
Where c.product_id = 50081592;
​
​
​
;
select *
from pr_comp_suspension  sss
​
select *
From compsesu  c1
Where c1.cmsssesu = 50764474
for update;
​
​
select *
from pr_comp_suspension c
where c.component_id in (3171926,3171927)
and   c.active = 'Y'
for update
​
select *
from 
where c3. in (3510162,3510163)
for update
*/
