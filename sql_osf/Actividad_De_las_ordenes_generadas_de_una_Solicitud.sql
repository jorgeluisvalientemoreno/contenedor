--DATA Orden
select distinct ooa.activity_id || ' - ' ||
                (select gi.description
                   from open.ge_items gi
                  where gi.items_id = ooa.activity_id) Actividad
  from open.or_order_activity ooa
  left join open.or_order oo
    on oo.order_id = ooa.order_id
  left join open.mo_packages mp
    on mp.package_id = ooa.package_id
  left join open.mo_motive mm
    on mp.package_id = mm.package_id
 where oo.order_status_id = 8
   and mp.package_type_id = 323
   and mp.motive_status_id = 14
   and (select psea.pay_modality
          from OPEN.MO_DATA_FOR_ORDER mdfo, open.PS_ENGINEERING_ACTIV Psea
         where mdfo.motive_id = mm.motive_id
           and Psea.Items_Id = mdfo.item_id) = 3;
