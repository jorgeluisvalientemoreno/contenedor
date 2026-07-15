/*Select Su.Susccodi,
              Ab.Address_Parsed,
              Ab.Address_Id,
              Ab.Geograp_Location_Id,
              Pr.Category_Id,
              Pr.Subcategory_Id,
              Su.Suscclie
From Suscripc Su,
Pr_Product Pr,
Ab_Address Ab
Where Pr.Subscription_Id = Su.Susccodi
And Pr.Address_Id = Ab.Address_Id
And Pr.Product_Id  = 50718475

;
*/
select pr.product_id,( '<P_SOLICITUD_SAC_REVISION_PERIODICA_100306 ID_TIPOPAQUETE="100306">'||'<FECHA_DE_SOLICITUD>'||sysdate||'</FECHA_DE_SOLICITUD><ID>'||1||'</ID ><POS_OPER_UNIT_ID>'||64||'</POS_OPER_UNIT_ID ><RECEPTION_TYPE_ID>'||10||'</RECEPTION_TYPE_ID><IDENTIFICADOR_DEL_CLIENTE>'||11111111||'</IDENTIFICADOR_DEL_CLIENTE><CONTACT_ID>'||Su.Suscclie||'</CONTACT_ID><ADDRESS_ID>'||NULL||'</ADDRESS_ID><COMMENT_>'||'prueba'||'</COMMENT_><M_ACTIVIDAD_PARA_SOLICITUD_SAC_REVISION_PERIODICA_100310><SUBSCRIPTION_ID>'|| Su.Susccodi||'</SUBSCRIPTION_ID><ITEM_ID>'||4294820||'</ITEM_ID><PRODUCT_ID>'||pr.product_id||'</PRODUCT_ID><DIRECCI_N_DE_EJECUCI_N_DE_TRABAJOS>'||Ab.Address_Parsed||'</DIRECCI_N_DE_EJECUCI_N_DE_TRABAJOS><ORDEN_REV_PERIODICA>'|| 324545034||'</ORDEN_REV_PERIODICA></M_ACTIVIDAD_PARA_SOLICITUD_SAC_REVISION_PERIODICA_100310></P_SOLICITUD_SAC_REVISION_PERIODICA_100306>') as XML                      
from suscripc su
inner join pr_product pr on pr.subscription_id = su.susccodi
inner join ab_address ab  on pr.address_id = ab.address_id
where pr.product_id  in ( 50718475);
  
  
  
  
select ce.* , mp.suspension_type_id, open.ldc_getedadrp(ce.id_producto)  edad_rp
from ldc_plazos_cert  ce
inner join ldc_marca_producto  mp  on mp.id_producto = ce.id_producto
where open.ldc_getedadrp(ce.id_producto) >= 55
and exists(select null
          from or_order_activity  a
          where ce.id_producto=a.product_id
          and a.activity_id in (100003630,100003629,100004600,100004601,100003631,100004602,4000056)
          and a.status='R')
and not exists(select null
              from mo_packages a1
              inner join mo_motive m on m.package_id=a1.package_id
              where ce.id_producto=m.product_id
              and a1.package_type_id=100306
              and a1.motive_status_id=13
              and not exists (select null
                              from or_order_activity a2
                              where m.product_id=a2.product_id
                              and a2.package_id=a1.package_id
                              and a2.activity_id =4294820))
                              .
and rownum<=3;
