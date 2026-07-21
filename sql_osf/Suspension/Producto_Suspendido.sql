select pps.product_id,
       pps.suspension_type_id || ' - ' || gst.description Tipo_Suspension,
       pps.register_date,
       pps.aplication_date,
       pps.inactive_date,
       pps.active
  from open.pr_prod_suspension pps
 inner join open.GE_SUSPENSION_TYPE GST
    on gst.suspension_type_id = pps.suspension_type_id
 where 1 = 1
   and pps.active = 'Y'
   and pps.product_id in (&producto)
 order by pps.product_id asc, pps.aplication_date desc;
