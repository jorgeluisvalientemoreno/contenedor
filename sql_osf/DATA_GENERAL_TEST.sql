declare

  --cursor DATA
  	cursor cuSolicitud is
select distinct mm.subscription_id Contrato,
                mm.product_id Producto,
                DireccionSolicitud.address_id || ' - ' ||
                DireccionSolicitud.address DireccionSolicitud,
                Localidad_Solicitud.geograp_location_id || ' - ' ||
                Localidad_Solicitud.description Localidad_Solicitud,
                mp.package_type_id || ' - ' ||
                (select b.description
                   from open.ps_package_type b
                  where b.package_type_id = mp.package_type_id) Tipo_Solicitud,
                mp.reception_type_id || ' - ' ||
                (select c.description
                   from open.ge_reception_type c
                  where c.reception_type_id = mp.reception_type_id) Medio_Recepcion,
                mp.request_date Registro_Solicitud,
                mp.cust_care_reques_num Interaccion,
                mp.motive_status_id || ' - ' ||
                (select d.description
                   from open.ps_motive_status d
                  where d.motive_status_id = mp.motive_status_id) Estado_Solicitud,
                mp.comment_ Comentario,
                mp.user_id Ususario_Crea
  from open.mo_packages        mp,
       open.mo_motive          mm,
       open.mo_address         ma,
       open.ab_address         DireccionSolicitud,
       open.ge_geogra_location Localidad_Solicitud,
       open.pr_product         pp,
       open.suscripc           contrato,
       open.ge_subscriber      cliente
 where mm.package_id = mp.package_id
   and ma.package_id(+) = mp.package_id
   and DireccionSolicitud.Address_Id(+) = ma.address_id
   and Localidad_Solicitud.geograp_location_id(+) =
       ma.geograp_location_id
   and pp.product_id(+) = mm.product_id 
   and contrato.susccodi(+) = mm.subscription_id
   and cliente.subscriber_id(+) = contrato.suscclie;    
  
begin

  --tipo 1 Solicitud
  --tipo 2 Orden
  --tipo 3 Tipo Trabajo
  --tipo 4 Unidad Operativa

  if tipo = 1 then
  end if;  
  
end;
