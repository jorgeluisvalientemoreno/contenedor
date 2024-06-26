select *
  from open.homologacion_servicios hs
 where 
 upper(hs.servicio_origen) like upper('%daor_order_activity.updaddress_id%');--damo_packages.fdtGetREQUEST_DATE
 --upper(hs.servicio_destino) like upper('%item%');
--pkg_or_order_comment
--pkg_or_extern_systems_id.prcactualizaDireccExterna
--pkg_or_order
