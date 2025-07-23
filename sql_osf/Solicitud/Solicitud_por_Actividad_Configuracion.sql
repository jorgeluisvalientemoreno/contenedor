select * from open.ps_pack_type_activ;
select ppta.pack_type_activ_id Identificador,
       ppta.package_type_id || ' - ' || ppt.description Tipo_solicitud,
       ppta.product_type_id || ' - ' || s.servdesc Tipo_Producto,
       ppta.items_id || ' - ' || gi.description Actividad
  from open.ps_pack_type_activ ppta
  left join open.ps_package_type ppt
    on ppt.package_type_id = ppta.package_type_id
  left join open.servicio s
    on s.servcodi = ppta.product_type_id
  left join open.ge_items gi
    on gi.items_id = ppta.items_id;
