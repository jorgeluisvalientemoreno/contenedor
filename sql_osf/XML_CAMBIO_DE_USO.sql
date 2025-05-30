declare
  nuPackageId    mo_packages.package_id%type;
  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);

  osbErrorMessage VARCHAR2(4000);
  onuErrorCode    NUMBER;

  sbRequestXML1 varchar2(32767);

  nuMotiveId mo_motive.motive_id%type;

  inuProducto         NUMBER;
  idtFechaRegi        DATE;
  inuMedioRecepcionId NUMBER;
  inuContactoId       NUMBER;
  inuDireccion        NUMBER;
  isbComentario       VARCHAR2(2000);
  inuRelaCliente      NUMBER;

  inuCategoria    NUMBER;
  inuSubcategoria NUMBER;
  isbResolucion   VARCHAR2(50);
  isbInfoComp     VARCHAR2(50);
  isbVisitaCampo  VARCHAR2(50);

BEGIN

  inuProducto         := 6559470;
  idtFechaRegi        := sysdate;
  inuMedioRecepcionId := 10;
  inuContactoId       := 753795;

  select pp.address_id
    into inuDireccion
    from open.pr_product pp
   where pp.product_id = inuProducto;

  isbComentario  := 'COMENTARIO XML';
  inuRelaCliente := '3';

  inuCategoria    := 1;
  inuSubcategoria := 2;
  isbResolucion   := '1';
  isbInfoComp     := 'Y';
  isbVisitaCampo  := 'N';

  sbRequestXML1 := personalizaciones.pkg_xml_soli_facturacion.getSolicitudCambioUsoServ(inuProducto,
                                                                                        idtFechaRegi,
                                                                                        inuMedioRecepcionId,
                                                                                        inuContactoId,
                                                                                        inuDireccion,
                                                                                        isbComentario,
                                                                                        inuRelaCliente,
                                                                                        inuCategoria,
                                                                                        inuSubcategoria,
                                                                                        isbResolucion,
                                                                                        isbInfoComp,
                                                                                        isbVisitaCampo);

  /*
  inuProducto         => , Identificador del Producto  PRODUCT PRODUCT_ID  Y 1 - NUMBER
  idtFechaRegi        => , Fecha de Solicitud  FECHA_DE_SOLICITUD  REQUEST_DATE  Y 3 - DATE
  inuMedioRecepcionId => , Medio recepcion RECEPTION_TYPE_ID RECEPTION_TYPE_ID Y 1 - NUMBER
  inuContactoId       => , Informacion del Solicitante CONTACT_ID  CONTACT_ID  Y 1 - NUMBER
  inuDireccion        => , Direccion de Respuesta  ADDRESS_ID  ADDRESS_ID  Y 1 - NUMBER
  isbComentario       => , Observacion COMMENT_  COMMENT_  Y 2 - VARCHAR2
  inuRelaCliente      => , Relacion del Solicitante con el Predio  ROLE_ID ROLE_ID Y 1 - NUMBER
  
  inuCategoria        => , --Categoria Y CATEGORY_ID MO_MOTIVE CATEGORY_ID 1 - NUMBER
  inuSubcategoria     => , --Subcategoria  N SUBCATEGORY_ID  MO_MOTIVE SUBCATEGORY_ID  1 - NUMBER
  isbResolucion       => , --Numero de Resolucion  N NUMERO_DE_RESOLUCION  MO_PROCESS  VARCHAR_2 2 - VARCHAR2
  isbInfoComp         => , --Documentacion Completa ?  Y DOCUMENTACION_COMPLETA  MO_MOTIVE CUSTOM_DECISION_FLAG  2 - VARCHAR2
  isbVisitaCampo      =>   --Realizo Visita en Campo N REALIZO_VISITA_EN_CAMPO MO_PROCESS  FLAG_1  2 - VARCHAR2
  */
  /*sbRequestXML1 := personalizaciones.pkg_xml_soli_facturacion.getSolicitudCambioUsoServ(17188796,
  to_date('08/12/2024'),
  10,
  753795,
  438619,
  'CAMBIO USO XML',
  2,
  2,
  2,
  1,
  'Y',
  'S');*/

  dbms_output.put_line(sbRequestXML1);
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
