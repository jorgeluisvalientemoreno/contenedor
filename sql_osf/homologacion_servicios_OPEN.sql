select *
  from open.homologacion_servicios hs
 where 
upper(hs.servicio_origen) like upper('%ab_boaddress%');--damo_packages.fdtGetREQUEST_DATE
--upper(hs.servicio_destino) like upper('%LD_BOCONSTANS%');
--upper(hs.descripcion_origen) like upper('%CATE%')
--pkg_or_order_comment
--pkg_or_extern_systems_id.prcactualizaDireccExterna
--pkg_or_order
