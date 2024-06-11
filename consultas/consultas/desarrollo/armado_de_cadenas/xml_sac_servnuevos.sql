/*select '<?xml version="1.0" encoding="ISO-8859-1"?><P_SAC_SERVICIOS_NUEVOS_100323 ID_TIPOPAQUETE="100323"><FECHA_DE_SOLICITUD>'||sysdate||'</FECHA_DE_SOLICITUD><ID>'||1||'</ID><POS_OPER_UNIT_ID>'||766||'</POS_OPER_UNIT_ID><RECEPTION_TYPE_ID>'||10||'</RECEPTION_TYPE_ID>  <IDENTIFICADOR_DEL_CLIENTE>'||s.suscclie||'</IDENTIFICADOR_DEL_CLIENTE><CONTACT_ID>'||s.suscclie||'</CONTACT_ID>
  <ADDRESS_ID>'||p.address_id||'</ADDRESS_ID><COMMENT_>'||'PRUEBA'||' </COMMENT_><M_INSTALACION_DE_GAS_100299></M_INSTALACION_DE_GAS_100299></P_SAC_SERVICIOS_NUEVOS_100323>'
  from pr_product p
inner join suscripc s on s.susccodi=p.subscription_id
where product_Status_id=15*/




  

select '<?xml version="1.0" encoding="ISO-8859-1"?><P_SAC_SERVICIOS_NUEVOS_100323 ID_TIPOPAQUETE="100323"><FECHA_DE_SOLICITUD>' ||
       sysdate || '</FECHA_DE_SOLICITUD><ID>' || 1 ||
       '</ID><POS_OPER_UNIT_ID>' || 766 ||
       '</POS_OPER_UNIT_ID><RECEPTION_TYPE_ID>' || 10 ||
       '</RECEPTION_TYPE_ID><IDENTIFICADOR_DEL_CLIENTE>'||s.suscclie||'</IDENTIFICADOR_DEL_CLIENTE><CONTACT_ID>' || s.suscclie || '</CONTACT_ID><ADDRESS_ID>' || p.address_id || '</ADDRESS_ID><COMMENT_>' ||
       'PRUEBA' ||
       ' </COMMENT_><M_INSTALACION_DE_GAS_100299><SUBSCRIPTION_ID>' ||
       p.subscription_id ||
       '</SUBSCRIPTION_ID> </M_INSTALACION_DE_GAS_100299></P_SAC_SERVICIOS_NUEVOS_100323>'
  from pr_product p
 inner join suscripc s
    on s.susccodi = p.subscription_id
 where product_Status_id = 15
   and producto=1
