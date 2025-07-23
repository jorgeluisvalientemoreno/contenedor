--Suspension producto
select pps.*
/*
pps.prod_suspension_id Suspension,
pp.subscription_id Contrato,
pps.product_id Producto,
pps.suspension_type_id || ' - ' || gst.description Tipo_Suspension,
pp.product_status_id || ' - ' || ps.description Estado_Porducto,
pps.register_date Fecha_Registro,
pps.aplication_date Fecha_Ejecucion,
pps.inactive_date Fecha_inactividad,
pps.active Activo,
decode(pps.active, 'Y', pp.suspen_ord_act_id) Actividad_Suspendio,
decode(pps.active, 'Y', oo.order_id) Orden_Suspendio,
decode(pps.active, 'Y', oo.task_type_id || ' - ' || ott.description) Tipo_Trabajo,
decode(pps.active, 'Y', lmc.suspension_type_id) Marca,
decode(pps.active, 'Y', lmc.fecha_ultima_actu) Fecha_Ultima_Marca
*/
  from OPEN.pr_prod_suspension pps
  left join open.pr_product pp
    on pp.product_id = pps.product_id
  left join open.ge_suspension_type gst
    on gst.suspension_type_id = pps.suspension_type_id
  left join open.Or_Order_Activity ooa
    on ooa.order_activity_id = pp.suspen_ord_act_id
  left join open.Or_Order oo
    on oo.order_id = ooa.order_id
  left join open.or_task_type ott
    on ott.task_type_id = oo.task_type_id
  left join open.LDC_MARCA_PRODUCTO lmc
    on lmc.id_producto = pp.product_id
  left join open.ps_product_status ps
    on ps.product_status_id = pp.product_status_id
-- 
 where --pps.active = 'Y'
--pp.subscription_id = 6233441
 pp.product_id = 50068723
--   and pps.register_date > sysdate - 200 
-- and pps.suspension_type_id <> 2
 order by pps.register_date desc;

--Componente Producto
select pc.*, rowid
  from OPEN.PR_COMPONENT pc
 where pc.product_id = 50068723;

--Componente Producto suspendido
select *
  from open.PR_COMP_SUSPENSION
 WHERE COMP_SUSPENSION_ID in
       (SELECT COMP_SUSPENSION_ID
          FROM open.PR_COMPONENT C, open.PR_COMP_SUSPENSION CS
         WHERE PRODUCT_ID = 50068723
           AND C.COMPONENT_ID = CS.COMPONENT_ID
           AND ACTIVE = 'Y');

--suspencion de conexion
select *
  from open.suspcone
 WHERE SUSPCONE.SUCONUSE = 50068723 -- &inuProductId
 order by SUSPCONE.SUCOFEOR desc;

select (select b.subscription_id
          from open.pr_product b
         where b.product_id = a.product_id) Contrato,
       a.*
  from open.pr_prod_suspension a
 where a.suspension_type_id in (101, 102, 103, 104)
   and (select count(1)
          from cuencobr cc
         where cc.cuconuse = a.product_id
           and (nvl(cc.cucosacu, 0) + nvl(cc.cucovare, 0)) > 0) >= 3
   and a.active = 'Y'
   and a.inactive_date is null;
