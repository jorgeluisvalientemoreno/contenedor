select pr.product_id,
             Su.Susccodi,
              Ab.Address_Parsed,
              Ab.Address_Id,
              Ab.Geograp_Location_Id,
              Pr.Category_Id,
              Pr.Subcategory_Id,
              Su.Suscclie,
              ( '<P_SOLICITUD_SAC_REVISION_PERIODICA_100306 ID_TIPOPAQUETE="100306">'||'<FECHA_DE_SOLICITUD>'||sysdate||'</FECHA_DE_SOLICITUD><ID>'||1||'</ID ><POS_OPER_UNIT_ID>'||64||'</POS_OPER_UNIT_ID ><RECEPTION_TYPE_ID>'||10||'</RECEPTION_TYPE_ID><IDENTIFICADOR_DEL_CLIENTE>'||Su.Suscclie||'</IDENTIFICADOR_DEL_CLIENTE><CONTACT_ID>'||Su.Suscclie||'</CONTACT_ID><ADDRESS_ID>'||NULL||'</ADDRESS_ID><COMMENT_>'||'prueba'||'</COMMENT_><M_ACTIVIDAD_PARA_SOLICITUD_SAC_REVISION_PERIODICA_100310><SUBSCRIPTION_ID>'|| Su.Susccodi||'</SUBSCRIPTION_ID><ITEM_ID>'||4294820||'</ITEM_ID><PRODUCT_ID>'||pr.product_id||'</PRODUCT_ID><DIRECCI_N_DE_EJECUCI_N_DE_TRABAJOS>'||Ab.Address_id||'</DIRECCI_N_DE_EJECUCI_N_DE_TRABAJOS><ORDEN_REV_PERIODICA>'|| 324545034||'</ORDEN_REV_PERIODICA></M_ACTIVIDAD_PARA_SOLICITUD_SAC_REVISION_PERIODICA_100310></P_SOLICITUD_SAC_REVISION_PERIODICA_100306>') as XML                      
from suscripc su
inner join pr_product pr on pr.subscription_id = su.susccodi
inner join ab_address ab  on pr.address_id = ab.address_id
where pr.product_id  in ( 1106843); --se debe colocar la orden en el XML