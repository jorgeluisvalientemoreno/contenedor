Select product_id "producto" , ('<P_REGISTRO_DE_PNO_100260 ID_TIPOPAQUETE="100260"><FECHA_DE_SOLICITUD>'||sysdate||'</FECHA_DE_SOLICITUD><RECEPTION_TYPE_ID>'||10||'</RECEPTION_TYPE_ID><CONTACT_ID>'|| ge_subscriber.subscriber_id||'</CONTACT_ID><ADDRESS_ID/><M_SOLICITUD_DE_PNO_100255><PRODUCTO>'||product_id||'</PRODUCTO><DIRECCION>'||pr_product.address_id||'</DIRECCION><COMENTARIO>'||'osf_904'||'</COMENTARIO><ACTIVIDAD_DE_GESTI_N>'||4000949||'</ACTIVIDAD_DE_GESTI_N><CUSTOMER/><OPERTING_SECTOR/></M_SOLICITUD_DE_PNO_100255></P_REGISTRO_DE_PNO_100260>') as "Cadena_XML"
from open.servsusc 
left join open.pr_product on pr_product.product_id = sesunuse 
left join open.suscripc on suscripc.susccodi= servsusc.sesususc
left join open.ge_subscriber  on ge_subscriber.subscriber_id = suscripc.suscclie
where pr_product.product_id in (1017017);
 