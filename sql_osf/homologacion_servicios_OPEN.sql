select hs.*, rowid
  from open.homologacion_servicios hs
 where upper(hs.servicio_origen) like upper('%ps_boengineeringactiv%')
    or upper(hs.servicio_origen) like upper('%cc_boaccounts.generateaccountbypack%')
    or upper(hs.servicio_origen) like upper('%pktblplandife%')
    or upper(hs.servicio_origen) like upper('%dacc_sales_financ_cond%')
    or upper(hs.servicio_origen) like upper('%dacc_quotation%'); 
--upper(hs.servicio_destino) like upper('%FINAN%');
--upper(hs.descripcion_origen) like upper('%CATE%')
--upper(hs.descripcion_destino) like upper('%FINA%')
--pkg_or_order_comment
--pkg_or_extern_systems_id.prcactualizaDireccExterna
--pkg_or_order
--ADM_PERSON.
--personalizaciones.pkg
