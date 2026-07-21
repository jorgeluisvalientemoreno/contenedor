select mp.package_id "Solicitud",
       mp.package_type_id || ' - ' || ppt.description "Tipo Solicitud",
       pps.product_id "Producto",
       oo.order_id "Ultima Orden Suspension",
       oo.task_type_id || ' - ' || ott.description "Tipo Trabajo",
       pps.suspension_type_id || ' - ' || GST.Description "Tipo Suspension"
  from open.pr_prod_suspension pps
 inner join open.mo_motive mm
    on mm.product_id = pps.product_id
 inner join open.mo_packages mp
    on mp.package_id = mm.package_id
 inner join open.Ps_package_type ppt
    on ppt.package_type_id = mp.package_type_id
 inner join open.GE_SUSPENSION_TYPE GST
    on gst.suspension_type_id = pps.suspension_type_id
 inner join open.pr_product pp
    on pp.product_id = pps.product_id
 inner join open.or_order_activity ooa
    on ooa.order_activity_id = pp.suspen_ord_act_id
 inner join open.or_order oo
    on oo.order_id = ooa.order_id
 inner join open.or_task_type ott
    on ott.task_type_id = oo.task_type_id
 where mp.package_id in (201727817,
                         223827778,
                         215210451,
                         229414291,
                         212493427,
                         207123442,
                         228191610,
                         198164386,
                         202024978,
                         210445902,
                         199382140,
                         199382081,
                         197797108,
                         197724798,
                         204213776,
                         197797102,
                         200131424,
                         197797106,
                         204168540,
                         198897416,
                         209608197,
                         228054614)
   and pps.product_id in
       (50097342 )
   --and pps.active = 'Y'
/*and not exists (select *
         from open.CT_ITEM_NOVELTY CIN
        where CIN.items_id = ooa.activity_id)
  and not exists
(select *
         from OPEN.OR_SUPPORT_ACTIVITY OSA
        where OSA.SUPPORT_ACTIVITY_ID = ooa.activity_id)*/
 order by mm.product_id asc, pps.aplication_date desc
