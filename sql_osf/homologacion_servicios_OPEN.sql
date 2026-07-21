select hs.*, rowid
  from open.homologacion_servicios hs
 where 1 = 1
   and upper(hs.servicio_origen) like upper('%daor_order_activity%')
--and upper(hs.servicio_destino) like upper('%FINAN%');
--and upper(hs.descripcion_origen) like upper('%CATE%')
--and upper(hs.descripcion_destino) like upper('%FINA%')
--pkg_or_order_comment
--pkg_or_extern_systems_id.prcactualizaDireccExterna
--pkg_or_order
--ADM_PERSON.
--personalizaciones.pkg
--ADM_PERSON.CONSTANTS_PER
--PKG_BOGESTION_CONTRATO
