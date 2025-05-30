--Reconexion
--producto suspendido
select pps.prod_suspension_id Suspension,
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
 where --pps.active = 'Y'
--pp.subscription_id = 6233441
 pp.product_id = 51688245
--   and pps.register_date > sysdate - 200 
-- and pps.suspension_type_id <> 2
 order by pps.register_date desc;

--Componente Producto
select pc.*, rowid
  from OPEN.PR_COMPONENT pc
 where pc.product_id = 51688245;

--Componente Producto suspendido
select *
  from open.PR_COMP_SUSPENSION
 WHERE COMP_SUSPENSION_ID in
       (SELECT COMP_SUSPENSION_ID
          FROM open.PR_COMPONENT C, open.PR_COMP_SUSPENSION CS
         WHERE PRODUCT_ID = 51688245
           AND C.COMPONENT_ID = CS.COMPONENT_ID
           AND ACTIVE = 'Y');

--suspencion de conexion
select *
  from open.suspcone
 WHERE SUSPCONE.SUCONUSE = 51688245 -- &inuProductId
 order by SUSPCONE.SUCOFEOR desc;

--- Tramite s asociados a una suspension y/o reconexion
SELECT /*+ INDEX (a IDX_MO_MOTIVE_08)*/
mp.*
--A.MOTIVE_ID
  FROM open.MO_MOTIVE          A,
       open.PS_MOTIVE_STATUS   C,
       open.MO_COMPONENT       B,
       open.MO_SUSPENSION_COMP D,
       open.mo_packages mp
 WHERE A.PRODUCT_ID = 51688245--INUPRODUCTID
   AND A.TAG_NAME = 'M_GENER_RECONVOL'
   AND A.MOTIVE_STATUS_ID = C.MOTIVE_STATUS_ID
   AND C.IS_FINAL_STATUS = 'N'--GE_BOCONSTANTS.CSBNO
   AND A.MOTIVE_ID = B.MOTIVE_ID
   AND B.COMPONENT_ID = D.COMPONENT_ID
   AND D.SUSPENSION_TYPE_ID = 105--INUSUSPENSIONTYPEID
   and mp.package_id = a.package_id
   AND ROWNUM = 1;
