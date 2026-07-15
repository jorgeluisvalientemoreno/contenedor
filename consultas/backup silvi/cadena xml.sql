Select ('<P_CAMBIO_TITULAR_PORTAL_WEB_100293 ID_TIPOPAQUETE="100293">
 <POS_OPER_UNIT_ID>' ||2069||'</POS_OPER_UNIT_ID>
<RECEPTION_TYPE_ID>' ||10|| '</RECEPTION_TYPE_ID>
<COMMENT_>' ||'prueba'|| '</COMMENT_>
<M_MOTIVO_CAMBIO_TITULAR_PORTAL_WEB_100295>
<CONTRATO>' ||subscription_id|| '</CONTRATO>
<CAUSAL_DE_ATENCION_INMEDIATA>' ||1|| '</CAUSAL_DE_ATENCION_INMEDIATA>
</M_MOTIVO_CAMBIO_TITULAR_PORTAL_WEB_100295>
</P_CAMBIO_TITULAR_PORTAL_WEB_100293>') 
from pr_product p
where p.product_id = 742249

 Select product_id "producto" , ('<P_REGISTRO_DE_PNO_100260 ID_TIPOPAQUETE="100260"><FECHA_DE_SOLICITUD>'||sysdate||'</FECHA_DE_SOLICITUD><RECEPTION_TYPE_ID>'||10||'</RECEPTION_TYPE_ID><CONTACT_ID>'|| ge_subscriber.subscriber_id||'</CONTACT_ID><ADDRESS_ID/><M_SOLICITUD_DE_PNO_100255><PRODUCTO>'||product_id||'</PRODUCTO><DIRECCION>'||pr_product.address_id||'</DIRECCION><COMENTARIO>'||'osf_904'||'</COMENTARIO><ACTIVIDAD_DE_GESTI_N>'||4000949||'</ACTIVIDAD_DE_GESTI_N><CUSTOMER/><OPERTING_SECTOR/></M_SOLICITUD_DE_PNO_100255></P_REGISTRO_DE_PNO_100260>') as "Cadena_XML"
from open.servsusc 
left join open.pr_product on pr_product.product_id = sesunuse 
left join open.suscripc on suscripc.susccodi= servsusc.sesususc
left join open.ge_subscriber  on ge_subscriber.subscriber_id = suscripc.suscclie
where pr_product.product_id in (1017017);
 
 
 Select product_id "producto" , ('<P_REGISTRO_DE_PNO_100260 ID_TIPOPAQUETE="100260"><FECHA_DE_SOLICITUD/><RECEPTION_TYPE_ID>'||10||'</RECEPTION_TYPE_ID><CONTACT_ID>'|| ge_subscriber.subscriber_id||'</CONTACT_ID><ADDRESS_ID/><M_SOLICITUD_DE_PNO_100255><PRODUCTO>'||product_id||'</PRODUCTO><DIRECCION>'||pr_product.address_id||'</DIRECCION><COMENTARIO>'||'osf_904'||'</COMENTARIO><ACTIVIDAD_DE_GESTI_N/><CUSTOMER/><OPERTING_SECTOR/></M_SOLICITUD_DE_PNO_100255></P_REGISTRO_DE_PNO_100260>') as "Cadena_XML"
from open.servsusc 
left join open.pr_product on pr_product.product_id = sesunuse 
left join open.suscripc on suscripc.susccodi= servsusc.sesususc
left join open.ge_subscriber  on ge_subscriber.subscriber_id = suscripc.suscclie
where pr_product.product_id in (14518870);

 Select ('<P_REGISTRO_DE_PNO_100260 ID_TIPOPAQUETE="100260">
<FECHA_DE_SOLICITUD>'||sysdate||'</FECHA_DE_SOLICITUD>
<RECEPTION_TYPE_ID>'||'10'||'</RECEPTION_TYPE_ID>
<CONTACT_ID>'||ge_subscriber.phone||'</CONTACT_ID>
<ADDRESS_ID>'||pr_product.address_id||'</ADDRESS_ID><M_SOLICITUD_DE_PNO_100255>
<PRODUCTO>'||pr_product.product_id||'</PRODUCTO>
<DIRECCION>'||pr_product.address_id||'</DIRECCION>
<COMENTARIO>'||'Tramite Registrado por XML_OSF_904'||'</COMENTARIO>
<ACTIVIDAD_DE_GESTI_N>'||4000949||'</ACTIVIDAD_DE_GESTI_N>
<CUSTOMER>'||ge_subscriber.phone||'</CUSTOMER>
<OPERTING_SECTOR>'||' ' ||' </OPERTING_SECTOR>
</M_SOLICITUD_DE_PNO_100255>
</P_REGISTRO_DE_PNO_100260>') as "Cadena_XML"
from open.servsusc 
left join open.pr_product on pr_product.product_id = sesunuse 
left join open.estacort on sesuesco = escocodi 
left join open.ps_product_status on ps_product_status.product_status_id = pr_product.product_status_id 
left join open.suscripc on suscripc.susccodi= servsusc.sesususc
left join open.ge_subscriber  on ge_subscriber.subscriber_id = suscripc.suscclie
where pr_product.product_id = 17153552

  
