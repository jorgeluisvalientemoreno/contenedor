select mm.product_id Producto,
       oo.order_id Orden_Suspension,
       ooa.activity_id || ' - ' || gi.description Actividad,
       oo.task_type_id || ' - ' || ott.description Tipo_Trabajo,
       suspension.package_id Solicitud_Suspension,
       tipo_suspension.package_type_id || ' - ' ||
       tipo_suspension.description tipo_solicitud,
       pps.suspension_type_id || ' - ' || GST.DESCRIPTION Tipo_suspension,
       pps.aplication_date Fecha_Suspesion
  from open.mo_packages mp
 inner join open.mo_motive mm
    on mm.package_id = mp.package_id
 inner join open.pr_prod_suspension pps
    on pps.product_id = mm.product_id
--and pps.active = 'Y'
 inner join OPEN.GE_SUSPENSION_TYPE GST
    on gst.suspension_type_id = pps.suspension_type_id
 inner join open.pr_product pp
    on pp.product_id = mm.product_id
 inner join open.or_order_activity ooa
    on ooa.product_id = mm.product_id
--and ooa.order_activity_id = pp.suspen_ord_act_id
 inner join open.or_order oo
    on oo.order_id = ooa.order_id
   and oo.execution_final_date = pps.aplication_date
 inner join open.ge_items gi
    on gi.items_id = ooa.activity_id
 inner join open.or_task_type ott
    on ott.task_type_id = oo.task_type_id
  left join open.mo_packages suspension
    on suspension.package_id = ooa.package_id
  left join open.Ps_package_type tipo_suspension
    on tipo_suspension.package_type_id = suspension.package_type_id
 where 1 = 1
      --and mp.package_id in (230241485)
   and pps.product_id = 50097342
   and not exists (select *
          from open.CT_ITEM_NOVELTY CIN
         where CIN.items_id = ooa.activity_id)
   and not exists
 (select *
          from OPEN.OR_SUPPORT_ACTIVITY OSA
         where OSA.SUPPORT_ACTIVITY_ID = ooa.activity_id)
 group by mm.product_id,
          oo.order_id,
          ooa.activity_id || ' - ' || gi.description,
          oo.task_type_id || ' - ' || ott.description,
          suspension.package_id,
          tipo_suspension.package_type_id || ' - ' ||
          tipo_suspension.description,
          pps.suspension_type_id || ' - ' || GST.DESCRIPTION,
          pps.aplication_date
 order by mm.product_id asc, pps.aplication_date desc
