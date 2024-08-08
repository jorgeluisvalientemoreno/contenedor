PL/SQL Developer Test script 3.0
18
declare
 sesion number;
 cantidad number;
begin
  -- Call the procedure
  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);
  os_registerrequestwithxml(isbrequestxml => :isbrequestxml,
                            onupackageid => :onupackageid,
                            onumotiveid => :onumotiveid,
                            onuerrorcode => :onuerrorcode,
                            osberrormessage => :osberrormessage);
 select count(1) into cantidad
 from open.mo_component
 where package_id=:onupackageid;
 dbms_output.put_line('Cantidad '||cantidad);
end;
5
isbrequestxml
1
<?xml version="1.0" encoding="ISO-8859-1"?><P_SAC_SERVICIOS_NUEVOS_100323 ID_TIPOPAQUETE="100323"><FECHA_DE_SOLICITUD>06-07-2022 08:24:43</FECHA_DE_SOLICITUD><ID>1</ID><POS_OPER_UNIT_ID>766</POS_OPER_UNIT_ID><RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID><IDENTIFICADOR_DEL_CLIENTE>288903</IDENTIFICADOR_DEL_CLIENTE><CONTACT_ID>288903</CONTACT_ID><ADDRESS_ID>48863</ADDRESS_ID><COMMENT_>PRUEBA </COMMENT_><M_INSTALACION_DE_GAS_100299><SUBSCRIPTION_ID>20200631</SUBSCRIPTION_ID> </M_INSTALACION_DE_GAS_100299></P_SAC_SERVICIOS_NUEVOS_100323>
5
onupackageid
0
4
onumotiveid
0
4
onuerrorcode
0
4
osberrormessage
0
5
7
sbNode
nuNodes
INUFATHER
INUSEQUENCE
SBINSTANCE
IORCMIRROR.SBINSTANCE
IORCMIRROR.SBMIRRORATTRIBUTE
