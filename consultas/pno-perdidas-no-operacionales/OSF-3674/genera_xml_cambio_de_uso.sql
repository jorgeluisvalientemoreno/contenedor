select sesunuse , 
('<?xml version="1.0" encoding="utf-8" ?><P_CAMBIO_DE_USO_DEL_SERVICIO_100225 ID_TIPOPAQUETE="100225"><PRODUCT>'||product_id||'</PRODUCT><FECHA_DE_SOLICITUD>'||sysdate||'</FECHA_DE_SOLICITUD><RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID><CONTACT_ID>'||ge.subscriber_id||'</CONTACT_ID><ADDRESS_ID>'||pr.address_id ||'</ADDRESS_ID><COMMENT_>prueba</COMMENT_><ROLE_ID>2</ROLE_ID><M_PATRON_DE_SERVICIOS_100237><CATEGORY_ID>3</CATEGORY_ID><SUBCATEGORY_ID>2</SUBCATEGORY_ID><NUMERO_DE_RESOLUCION>471</NUMERO_DE_RESOLUCION><DOCUMENTACION_COMPLETA>Y</DOCUMENTACION_COMPLETA><REALIZO_VISITA_EN_CAMPO></REALIZO_VISITA_EN_CAMPO><C_PATRON_10305><C_GENERICO_10317/></C_PATRON_10305></M_PATRON_DE_SERVICIOS_100237></P_CAMBIO_DE_USO_DEL_SERVICIO_100225>') as cadena 
from open.servsusc 
inner join open.pr_product  pr on product_id = sesunuse and subscription_id = sesususc
inner join open.suscripc on sesususc = susccodi 
inner join open.ge_subscriber ge on suscclie = ge.subscriber_id
where sesunuse = 2084824;
