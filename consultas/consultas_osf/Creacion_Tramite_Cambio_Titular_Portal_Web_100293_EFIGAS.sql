declare
  MED_REEPCION   NUMBER := 10;
  COMENTARIO     VARCHAR2(4000) := 'Generacion Tramite atencion inmediata Prueba OSF-626';
  CONTRATO       NUMBER := 104762;
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

  nuContratoId := CONTRATO;
  dbms_output.put_line('Contrato -->' || nuContratoId);

  sbComment := COMENTARIO;
  dbms_output.put_line('Comentario -->' || sbComment);

  nuRecept := MED_REEPCION;
  dbms_output.put_line('Medio de recepcion -->' || nuRecept);

  nuid_de_la_causal := null;

  sbRequestXML1 := '<?xml version="1.0" encoding="utf-8"?>
                      <P_CAMBIO_TITULAR_PORTAL_WEB_100293 ID_TIPOPAQUETE="100293">
                      <POS_OPER_UNIT_ID>' || nuunidad_operativa ||'</POS_OPER_UNIT_ID>
                      <RECEPTION_TYPE_ID>' || nuRecept || '</RECEPTION_TYPE_ID>
                      <COMMENT_>' || sbComment || '</COMMENT_>
                      <M_MOTIVO_CAMBIO_TITULAR_PORTAL_WEB_100295>
                      <CONTRATO>' || nuContratoId || '</CONTRATO>
                      <CAUSAL_DE_ATENCION_INMEDIATA>' || nuid_de_la_causal || '</CAUSAL_DE_ATENCION_INMEDIATA>
                      </M_MOTIVO_CAMBIO_TITULAR_PORTAL_WEB_100295>
                      </P_CAMBIO_TITULAR_PORTAL_WEB_100293>';
/*     sbRequestXML1 := '<P_CAMBIO_TITULAR_PORTAL_WEB_100293 ID_TIPOPAQUETE="100293">
                        <POS_OPER_UNIT_ID>401</POS_OPER_UNIT_ID>
                        <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID>
                        <COMMENT_>P_CAMBIO_TITULAR_PORTAL_WEB_100293 QT</COMMENT_>
                        <M_MOTIVO_CAMBIO_TITULAR_PORTAL_WEB_100295>
                        <CONTRATO>78643</CONTRATO>
                        <CAUSAL_DE_ATENCION_INMEDIATA></CAUSAL_DE_ATENCION_INMEDIATA>
                        </M_MOTIVO_CAMBIO_TITULAR_PORTAL_WEB_100295>
                        </P_CAMBIO_TITULAR_PORTAL_WEB_100293>';*/

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
