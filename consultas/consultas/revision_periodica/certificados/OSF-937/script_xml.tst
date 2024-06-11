PL/SQL Developer Test script 3.0
11
-- Created on 8/07/2022 by MARIA CARVAL 
declare
  sesion number;
  cantidad number;
begin  
  os_registerrequestwithxml(isbrequestxml => :isbrequestxml,
                            onupackageid => :onupackageid,
                            onumotiveid => :onumotiveid,
                            onuerrorcode => :onuerrorcode,
                            osberrormessage => :osberrormessage);
end;
5
isbrequestxml
11
<?xml version="1.0" encoding="ISO-8859-1"?><P_LBC_SUSPENSION_ADMINISTRATIVA_POR_XML_100156 ID_TIPOPAQUETE="100156">
        <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID>
        <CONTACT_ID>1871001</CONTACT_ID>
        <ADDRESS_ID></ADDRESS_ID>
        <COMMENT_>sbComment</COMMENT_>
        <PRODUCT>51593771</PRODUCT>
        <FECHA_DE_SUSPENSION>27-05-2023 10:04:25</FECHA_DE_SUSPENSION>
        <TIPO_DE_SUSPENSION>101</TIPO_DE_SUSPENSION>
        <TIPO_DE_CAUSAL>73</TIPO_DE_CAUSAL>
        <CAUSAL_ID>287</CAUSAL_ID>
        </P_LBC_SUSPENSION_ADMINISTRATIVA_POR_XML_100156>
5
onupackageid
1
197028798
4
onumotiveid
0
4
onuerrorcode
1
0
4
osberrormessage
0
5
0
