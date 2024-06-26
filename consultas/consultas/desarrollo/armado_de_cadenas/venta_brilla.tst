PL/SQL Developer Test script 3.0
61
DECLARE
  ISBREQUESTXML VARCHAR2(10000) := null;
  ONUPACKAGEID  NUMBER;
  ONUMOTIVEID   NUMBER;
  onuErrorCodi  NUMBER;
  osbErrorMsg   VARCHAR2(1000);
  sesion number;
BEGIN
  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);
  
  ISBREQUESTXML := '<?xml version= "1.0" encoding= "ISO-8859-1"?>
<P_VENTA_FNB_100264 ID_TIPOPAQUETE="100264">
    <CONTRACT>1000254</CONTRACT>
    <IDENTIFICADOR_DEL_CLIENTE></IDENTIFICADOR_DEL_CLIENTE>
    <CUPO_DE_CREDITO>0</CUPO_DE_CREDITO>
    <CUPO_USADO>0</CUPO_USADO>
    <EXTRA_CUPO_USADO>0</EXTRA_CUPO_USADO>
    <CUPO_MANUAL_USADO>0</CUPO_MANUAL_USADO>
    <IDENTIFICADOR_DE_LA_PRIMERA_FACTURA>106014878</IDENTIFICADOR_DE_LA_PRIMERA_FACTURA>
    <IDENTIFICADOR_DE_LA_SEGUNDA_FACTURA>103101362</IDENTIFICADOR_DE_LA_SEGUNDA_FACTURA>
    <OPERATING_UNIT_ID>1970</OPERATING_UNIT_ID>
    <SALE_CHANNEL_ID>10</SALE_CHANNEL_ID>
    <ID>13597</ID>
    <VENDEDOR>13597</VENDEDOR>
    <FECHA_DE_VENTA>29-04-2019</FECHA_DE_VENTA>
    <FECHA_DE_SOLICITUD>29-04-2019</FECHA_DE_SOLICITUD>
    <ID_DEL_CONSECUTIVO_PAGARE_DIGITAL />
    <ID_DEL_CONSECUTIVO_DE_PAGARE_MANUAL></ID_DEL_CONSECUTIVO_DE_PAGARE_MANUAL>
    <ID_DEL_CONSECUTIVO_PAGARE_DIGITAL></ID_DEL_CONSECUTIVO_PAGARE_DIGITAL>
    <ID_DEL_CONSECUTIVO_DE_PAGARE_MANUAL />
    <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID>
    <CONTACT_ID>751606</CONTACT_ID>
    <ADDRESS_ID>217581</ADDRESS_ID>
    <TOMO_EL_PERIODO_DE_GRACIA>N</TOMO_EL_PERIODO_DE_GRACIA>
    <ENTREGA_EN_PUNTO>N</ENTREGA_EN_PUNTO>
    <CUOTA_INICIAL>0</CUOTA_INICIAL>
    <COMMENT_>PRUEBAS</COMMENT_>
    <USUARIO_DEL_SERVICIO>751606</USUARIO_DEL_SERVICIO>
    <M_INSTALACION_DE_GAS_100271>
        <IDENTIFICADOR_DEL_MOTIVO />
        <ID_DE_LA_SOLICITUD_DE_FINANCIACION_NO_BANCARIA />
        <IDENTIFICADOR_DEL_ARTICULO>3164</IDENTIFICADOR_DEL_ARTICULO>
        <VALOR_UNITARIO>140</VALOR_UNITARIO>
        <CANTIDAD_DE_ARTICULOS>10</CANTIDAD_DE_ARTICULOS>
        <NUMERO_DE_CUOTAS>36</NUMERO_DE_CUOTAS>
        <FECHA_DE_PRIMERA_CUOTA>29-05-2019</FECHA_DE_PRIMERA_CUOTA>
        <CODIGO_DEL_PLAN_DE_DIFERIDO>86</CODIGO_DEL_PLAN_DE_DIFERIDO>
        <IVA>0</IVA>
    </M_INSTALACION_DE_GAS_100271>
</P_VENTA_FNB_100264>';
OS_RegisterRequestWithXML(ISBREQUESTXML,
                            ONUPACKAGEID,
                            ONUMOTIVEID,
                            onuErrorCodi,
                            osbErrorMsg);
 DBMS_OUTPUT.put_line('Solicitud: ' || ONUPACKAGEID || ' Motivo: ' ||
                       ONUMOTIVEID);                           
 DBMS_OUTPUT.put_line('Error: '||onuErrorCodi||' Mensaje: '||osbErrorMsg);                           
END;
0
0
