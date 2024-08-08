declare
  MED_REEPCION   NUMBER := 25;
  COMENTARIO     VARCHAR2(4000) := 'Generacion Tramite atencion inmediata';
  CONTRATO       NUMBER := 447305;
  nuPackageId    mo_packages.package_id%type;
  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);

  nuProductId PR_PRODUCT.PRODUCT_ID%type;
  sbComment   VARCHAR2(2000);
  nuRecept    MO_PACKAGES.RECEPTION_TYPE_ID%type;

  osbErrorMessage VARCHAR2(4000);
  onuErrorCode    NUMBER;
  ionuorderid     or_order.order_id%TYPE;
  sbmensamen      VARCHAR2(4000);

  nuContratoId   number;
  nuSubscriberId number;
  nuActividad    number;
  sbRequestXML1  varchar2(32767);

  --nuErrorCode         NUMBER;
  --sbErrorMessage      VARCHAR2(4000);
  --nuPackageId         mo_packages.package_id%type;
  nuMotiveId mo_motive.motive_id%type;

  CURSOR cuAreaOrganizat(nuUnitop number) IS
    SELECT ORGA_AREA_ID
      FROM or_operating_unit
     WHERE OPERATING_UNIT_ID = nuUnitop;

  CURSOR cuSubscriberId(contrato number) IS
    select gs.SUBSCRIBER_ID
      from ge_subscriber gs, suscripc ss
     where gs.subscriber_id = ss.suscclie
       and ss.susccodi = contrato;

  nuunidad_operativa number;

  nuid_de_la_causal number;

  cursor cuPersonID is
    SELECT a.organizat_area_id --id, a.display_description description
      FROM ge_organizat_area a, cc_orga_area_seller b
     WHERE a.organizat_area_id = b.organizat_area_id
       AND b.person_id = GE_BOPERSONAL.FNUGETPERSONID();

BEGIN

  open cuPersonID;
  fetch cuPersonID
    into nuunidad_operativa; -- := 2069;
  close cuPersonID;
  nuunidad_operativa := 1240;

  nuContratoId := CONTRATO;
  dbms_output.put_line('Contrato -->' || nuContratoId);

  sbComment := COMENTARIO;
  dbms_output.put_line('Comentario -->' || sbComment);

  nuRecept := MED_REEPCION;
  dbms_output.put_line('Medio de recepcion -->' || nuRecept);

  nuid_de_la_causal := null;

  sbRequestXML1 := '<?xml version="1.0" encoding="utf-8"?>
                      <P_REGISTRO_PQR_PORTAL_WEB_100284 ID_TIPOPAQUETE="100284">
                      <FECHA_SOLICITUD /> 
                      <ID /> 
                      <POS_OPER_UNIT_ID/>
                      <RECEPTION_TYPE_ID>' || nuRecept || '</RECEPTION_TYPE_ID>                      
                      <CONTACT_ID /> 
                      <COMMENT_>' || sbComment || '</COMMENT_>
                      <CORREO_ELECTRONICO /> 
                      <M_MOTIVO_REGISTRO_PQR_PORTAL_WEB_100290>
                      <CONTRATO>' || nuContratoId || '</CONTRATO> 
                      </M_MOTIVO_REGISTRO_PQR_PORTAL_WEB_100290>
                      </P_REGISTRO_PQR_PORTAL_WEB_100284>';
/*
- <P_REGISTRO_PQR_PORTAL_WEB_100284 ID_TIPOPAQUETE="">
  <FECHA_SOLICITUD /> 
  <ID /> 
  <POS_OPER_UNIT_ID /> 
  <RECEPTION_TYPE_ID /> 
  <CONTACT_ID /> 
  <COMMENT_ /> 
  <CORREO_ELECTRONICO /> 
- <M_MOTIVO_REGISTRO_PQR_PORTAL_WEB_100290>
  <CONTRATO /> 
  </M_MOTIVO_REGISTRO_PQR_PORTAL_WEB_100290>
  </P_REGISTRO_PQR_PORTAL_WEB_100284>
*/


  OS_RegisterRequestWithXML(sbRequestXML1,
                            nuPackageId,
                            nuMotiveId,
                            onuErrorCode,
                            osbErrorMessage);

  if onuErrorCode <> 0 then
    rollback;
    nuErrorCode    := onuErrorCode;
    sbErrorMessage := osbErrorMessage;
    dbms_output.put_line('PRSOLCUPPORWEB ERROR AL GENERAR EL TRAMITE -->' ||
                         sbErrorMessage);
  ELSE
    dbms_output.put_line('Solicitud[' || nuPackageId || ']');
    --rollback;
    commit;
  END if;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise;
  when others then
    Errors.setError;
    dbms_output.put_line('PRSOLCUPPORWEB ERROR AL GENERAR EL TRAMITE --> when others ');
    raise ex.CONTROLLED_ERROR;
end;
