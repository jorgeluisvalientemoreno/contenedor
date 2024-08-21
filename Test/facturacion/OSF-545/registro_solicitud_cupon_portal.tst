declare
  sesion number;
  cantidad number;
begin  
  os_registerrequestwithxml(isbrequestxml => :isbrequestxml,
                            onupackageid => :onupackageid,
                            onumotiveid => :onumotiveid,
                            onuerrorcode => :onuerrorcode,
                            osberrormessage => :osberrormessage
                            );
end;
5
isbrequestxml
7
<P_SOLICITUD_DE_CUPON_POR_EL_PORTAL_WEB_100290 ID_TIPOPAQUETE="100290">
  <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID >
  <COMMENT_ >gggg  </COMMENT_>
 <M_MOTIVO_SOLICITUD_DE_CUPON_POR_EL_PORTAL_WEB_100283>
  <CONTRATO> 94973 </CONTRATO>
  </M_MOTIVO_SOLICITUD_DE_CUPON_POR_EL_PORTAL_WEB_100283>
  </P_SOLICITUD_DE_CUPON_POR_EL_PORTAL_WEB_100290>
5
onupackageid
1
65993395
4
onumotiveid
1
25907091
4
onuerrorcode
1
0
4
osberrormessage
0
5
0
