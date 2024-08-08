DECLARE
  onuErrorCode    NUMBER;
  osbErrorMessage varchar2(4000);

  onuPackageId varchar2(4000);
  onuMotiveId  varchar2(4000);

  isbRequestXML VARCHAR2(4000);

  inuFuncionario          ge_person.person_id%TYPE;
  inuPuntoAtencion        mo_packages.pos_oper_unit_id%TYPE;
  inuTipoFormulario       mo_packages.document_type_id%TYPE;
  inuNumeroFormulario     mo_packages.document_key%TYPE;
  isbObservacion          mo_packages.comment_%TYPE;
  inuDireccionId          ab_address.address_id%TYPE;
  inuTipoIdentificacion   ge_subscriber.ident_type_id%TYPE;
  inuIdentificacion       ge_subscriber.identification%TYPE;
  isbNombre               ge_subscriber.subscriber_name%TYPE;
  isbApellido             ge_subscriber.subs_last_name%TYPE;
  isbNombreEmpresa        ge_subs_work_relat.Company%TYPE;
  isbCargo                ge_subs_work_relat.title%TYPE;
  isbCorreo               ge_subscriber.e_mail%TYPE;
  inuCantidadPersonas      ge_subs_housing_data.person_quantity%TYPE;
  inuEnergeticoAnterior   ldc_energetico_ant.energ_ant%TYPE;
  isbPredioConstruccion   ldc_daadventa.construccion%TYPE;
  inuTecnicoVentas        ldc_daadventa.person_id%TYPE;
  inuUnidadinstaladora    ldc_daadventa.oper_unit_inst%TYPE;
  inuUnidadCertificadora  ldc_daadventa.oper_unit_cert%TYPE;
  inuTelefono             ge_subs_phone.phone%TYPE;
  inuTipoPredio           ldc_daadventa.tipo_predio%TYPE;
  inuEstadoLey            ldc_daadventa.estaley%TYPE;
  inuPromicion            mo_mot_promotion.mot_promotion_id%TYPE;
  inuPlanComercial        mo_motive.commercial_plan_id%TYPE;
  inuValorTotal           MO_GAS_SALE_DATA.TOTAL_VALUE%TYPE;
  inuPlanFinanciacion     number;
  inuCuotaIncial          MO_GAS_SALE_DATA.Initial_Payment%TYPE;
  inuNumeroCuotas         number;
  inuCuotaMensual         number;
  inuFormaPago            MO_GAS_SALE_DATA.Init_Payment_Mode%TYPE;
  isbCuotaInicialRecibida MO_GAS_SALE_DATA.Init_Pay_Received%TYPE;
  inuTipoInstalacion      MO_GAS_SALE_DATA.Install_Type%TYPE;
  inuUso                  MO_GAS_SALE_DATA.Usage%TYPE;
    sbPromocion varchar2(200) := null;
    
BEGIN

  ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);

inufuncionario          := 43046;
  inupuntoatencion        := 4107;
  inutipoformulario       := 8;
  inunumeroformulario     := 766459;
  isbobservacion          := 'Ventas Digitales test';
  inudireccionid          := 2356255;
  inutipoidentificacion   := 1;
  inuidentificacion       := 1203169900; --1203169900;
  isbnombre               := 'Andres';
  isbapellido             := 'Cuevas';
  isbnombreempresa        := 'Sun Energy';
  isbcargo                := 'Gerente';
  isbcorreo               := 'jvaliente@horbath.com';
  inucantidadpersonas      := 2;
  inuenergeticoanterior   := 1;
  isbpredioconstruccion   := 'N';
  inutecnicoventas        := -1;
  inuunidadinstaladora    := 3478;
  inuunidadcertificadora  := 3479;
  inutelefono             := 3002569658;
  inutipopredio           := 2;
  inuestadoley            := 1;
  inuPromicion            := 86;--null;--86;
  inuplancomercial        := 4;
  inuvalortotal           := 2334930;
  inuplanfinanciacion     := 23;
  inucuotaincial          := 151288;
  inunumerocuotas         := 72;
  inucuotamensual         := 67973.72;
  inuformapago            := 13;
  isbcuotainicialrecibida := 'N';
  inutipoinstalacion      := 1;
  inuUso                  := 1;

     if inuPromicion is not null then
        sbPromocion := '<PROMOCIONES GROUP="1">
                            <PROMOTION_ID>' || inuPromicion ||
                       '</PROMOTION_ID>
                          </PROMOCIONES>';
      end if;

  isbRequestXML := '<?xml version="1.0" encoding="ISO-8859-1"?> <P_VENTA_DE_GAS_POR_FORMULARIO_271 ID_TIPOPAQUETE="271">
        <ID>' || inuFuncionario ||'</ID>
        <POS_OPER_UNIT_ID>' || inuPuntoAtencion || '</POS_OPER_UNIT_ID>
        <DOCUMENT_TYPE_ID>' || inuTipoFormulario || '</DOCUMENT_TYPE_ID>
        <DOCUMENT_KEY>' || inuNumeroFormulario || '</DOCUMENT_KEY>
        <COMMENT_>' || isbObservacion || '</COMMENT_>
        <DIRECCION>' || inuDireccionId || '</DIRECCION>
        <TIPO_DE_IDENTIFICACION>' || inuTipoIdentificacion || '</TIPO_DE_IDENTIFICACION>
        <IDENTIFICATION>' || inuIdentificacion || '</IDENTIFICATION>
        <SUBSCRIBER_NAME>' || isbNombre || '</SUBSCRIBER_NAME>
        <APELLIDO>' || isbApellido || '</APELLIDO>
        <COMPANY>' || isbNombreEmpresa || '</COMPANY>
        <TITLE>' || isbCargo || '</TITLE>
        <CORREO_ELECTRONICO>' || isbCorreo || '</CORREO_ELECTRONICO>
        <PERSON_QUANTITY>' || inuCantidadPersonas || '</PERSON_QUANTITY>
        <ENERGETICO_ANTERIOR>' || inuEnergeticoAnterior || '</ENERGETICO_ANTERIOR>
        <PREDIO_EN_CONSTRUCCION>' || isbPredioConstruccion || '</PREDIO_EN_CONSTRUCCION>
        <TECNICO_DE_VENTAS>' || inuTecnicoVentas || '</TECNICO_DE_VENTAS>
        <UNIDAD_DE_TRABAJO_INSTALADORA>' || inuUnidadInstaladora || '</UNIDAD_DE_TRABAJO_INSTALADORA>
        <UNIDAD_DE_TRABAJO_CERTIFICADORA>' || inuUnidadCertificadora || '</UNIDAD_DE_TRABAJO_CERTIFICADORA>
        <PHONE>' || inuTelefono || '</PHONE>
        <TIPO_DE_PREDIO>' || inuTipoPredio || '</TIPO_DE_PREDIO>
        <ESTADO_DE_LEY_1581>' || inuEstadoLey || '</ESTADO_DE_LEY_1581>' ||
        '<M_INSTALACION_DE_GAS_59>'|| chr(13) ||
          sbPromocion || chr(13) ||        
          '<COMMERCIAL_PLAN_ID>' || inuPlanComercial || '</COMMERCIAL_PLAN_ID>' ||
          '<PLAN_DE_FINANCIACION>' || inuPlanFinanciacion || '</PLAN_DE_FINANCIACION>
          <TOTAL_VALUE>' || inuValorTotal || '</TOTAL_VALUE>
          <INITIAL_PAYMENT>' || inuCuotaIncial || '</INITIAL_PAYMENT>
          <NUMERO_DE_CUOTAS>' || inuNumeroCuotas || '</NUMERO_DE_CUOTAS>
          <CUOTA_MENSUAL>' || inuCuotaMensual || '</CUOTA_MENSUAL>
          <INIT_PAYMENT_MODE>' || inuFormaPago || '</INIT_PAYMENT_MODE>
          <INIT_PAY_RECEIVED>' || isbCuotaInicialRecibida || '</INIT_PAY_RECEIVED>
          <INSTALL_TYPE>' || inuTipoInstalacion || '</INSTALL_TYPE>
          <USAGE>'|| inuUso ||'</USAGE>
          <C_GAS_42>
            <CODIGO_DEL_PAQUETE />
            <C_MEDICION_43 />
          </C_GAS_42>
        </M_INSTALACION_DE_GAS_59>
      </P_VENTA_DE_GAS_POR_FORMULARIO_271>';
  /*'<P_VENTA_DE_GAS_POR_FORMULARIO_271 ID_TIPOPAQUETE="271">
    <ID>43046</ID>
    <POS_OPER_UNIT_ID>4107</POS_OPER_UNIT_ID>
    <DOCUMENT_TYPE_ID>8</DOCUMENT_TYPE_ID>
    <DOCUMENT_KEY>766452</DOCUMENT_KEY>
    <COMMENT_>Ventas Digitales test</COMMENT_>
    <DIRECCION>2356255</DIRECCION>
    <TIPO_DE_IDENTIFICACION>1</TIPO_DE_IDENTIFICACION>
    <IDENTIFICATION>1203169900</IDENTIFICATION>
    <SUBSCRIBER_NAME>Andres</SUBSCRIBER_NAME>
    <APELLIDO>Cuevas</APELLIDO>
    <COMPANY>Sun Energy</COMPANY>
    <TITLE>Gerente</TITLE>
    <CORREO_ELECTRONICO>jvaliente@horbath.com</CORREO_ELECTRONICO>
    <PERSON_QUANTITY>2</PERSON_QUANTITY>
    <ENERGETICO_ANTERIOR>1</ENERGETICO_ANTERIOR>
    <PREDIO_EN_CONSTRUCCION>N</PREDIO_EN_CONSTRUCCION>
    <TECNICO_DE_VENTAS>-1</TECNICO_DE_VENTAS>
    <UNIDAD_DE_TRABAJO_INSTALADORA>3478</UNIDAD_DE_TRABAJO_INSTALADORA>
    <UNIDAD_DE_TRABAJO_CERTIFICADORA>3479</UNIDAD_DE_TRABAJO_CERTIFICADORA>
    <PHONE>3002569658</PHONE>
    <TIPO_DE_PREDIO>2</TIPO_DE_PREDIO>
    <ESTADO_DE_LEY_1581>1</ESTADO_DE_LEY_1581><M_INSTALACION_DE_GAS_59>
      <COMMERCIAL_PLAN_ID>4</COMMERCIAL_PLAN_ID>
      <TOTAL_VALUE>2334930</TOTAL_VALUE>
      <PLAN_DE_FINANCIACION>23</PLAN_DE_FINANCIACION>
      <INITIAL_PAYMENT>151288</INITIAL_PAYMENT>
      <NUMERO_DE_CUOTAS>72</NUMERO_DE_CUOTAS>
      <CUOTA_MENSUAL>67973.72</CUOTA_MENSUAL>
      <INIT_PAYMENT_MODE>13</INIT_PAYMENT_MODE>
      <INIT_PAY_RECEIVED>N</INIT_PAY_RECEIVED>
      <INSTALL_TYPE>1</INSTALL_TYPE>
      <USAGE>1</USAGE>
      <PROMOCIONES GROUP="1">
          <PROMOTION_ID>86</PROMOTION_ID> 
      </PROMOCIONES>
      <C_GAS_42>
        <CODIGO_DEL_PAQUETE />
        <C_MEDICION_43 />
      </C_GAS_42>
    </M_INSTALACION_DE_GAS_59>
  </P_VENTA_DE_GAS_POR_FORMULARIO_271>';*/
  /*'
  <P_VENTA_DE_GAS_POR_FORMULARIO_271 ID_TIPOPAQUETE="271">
    <ID>43046</ID>
    <POS_OPER_UNIT_ID>4107</POS_OPER_UNIT_ID>
    <DOCUMENT_TYPE_ID>8</DOCUMENT_TYPE_ID>
    <DOCUMENT_KEY>766448</DOCUMENT_KEY>
    <COMMENT_>Ventas Digitales test</COMMENT_>
    <DIRECCION>12036</DIRECCION>
    <TIPO_DE_IDENTIFICACION>1</TIPO_DE_IDENTIFICACION>
    <IDENTIFICATION>1203169900</IDENTIFICATION>
    <SUBSCRIBER_NAME>Jesus Daniel</SUBSCRIBER_NAME>
    <APELLIDO>Cuello</APELLIDO>
    <COMPANY>Vent Dig</COMPANY>
    <TITLE>Vent Dig</TITLE>
    <CORREO_ELECTRONICO>jvaliente@horbath.com</CORREO_ELECTRONICO>
    <PERSON_QUANTITY>1</PERSON_QUANTITY>
    <ENERGETICO_ANTERIOR>1</ENERGETICO_ANTERIOR>
    <PREDIO_EN_CONSTRUCCION>N</PREDIO_EN_CONSTRUCCION>
    <TECNICO_DE_VENTAS>-1</TECNICO_DE_VENTAS>
    <UNIDAD_DE_TRABAJO_INSTALADORA>3478</UNIDAD_DE_TRABAJO_INSTALADORA>
    <UNIDAD_DE_TRABAJO_CERTIFICADORA>3479</UNIDAD_DE_TRABAJO_CERTIFICADORA>
    <PHONE>3026644</PHONE>
    <TIPO_DE_PREDIO>2</TIPO_DE_PREDIO>
    <ESTADO_DE_LEY_1581>1</ESTADO_DE_LEY_1581>
    <M_INSTALACION_DE_GAS_59>
      <COMMERCIAL_PLAN_ID>4</COMMERCIAL_PLAN_ID>
      <TOTAL_VALUE>2334930</TOTAL_VALUE>
      <PLAN_DE_FINANCIACION>23</PLAN_DE_FINANCIACION>
      <INITIAL_PAYMENT>151288</INITIAL_PAYMENT>
      <NUMERO_DE_CUOTAS>72</NUMERO_DE_CUOTAS>
      <CUOTA_MENSUAL>67973.72</CUOTA_MENSUAL>
      <INIT_PAYMENT_MODE>13</INIT_PAYMENT_MODE>
      <INIT_PAY_RECEIVED>N</INIT_PAY_RECEIVED>
      <INSTALL_TYPE>1</INSTALL_TYPE>
    <USAGE>1</USAGE>
      <C_GAS_42>
        <CODIGO_DEL_PAQUETE />
        <C_MEDICION_43 />
      </C_GAS_42>
    </M_INSTALACION_DE_GAS_59>
  </P_VENTA_DE_GAS_POR_FORMULARIO_271>
  ';*/

  /*inufuncionario          := 43046;
  inupuntoatencion        := 4107;
  inutipoformulario       := 8;
  inunumeroformulario     := 766451;
  isbobservacion          := 'Ventas Digitales test';
  inudireccionid          := 2356255;
  inutipoidentificacion   := 1;
  inuidentificacion       := 1203169900; --1203169900;
  isbnombre               := 'Andres';
  isbapellido             := 'Cuevas';
  isbnombreempresa        := 'Sun Energy';
  isbcargo                := 'Gerente';
  isbcorreo               := 'jvaliente@horbath.com';
  inucantidapersonas      := 2;
  inuenergeticoanterior   := 1;
  isbpredioconstruccion   := 'N';
  inutencicoventas        := -1;
  inuunidadinstaladora    := 3478;
  inuunidadcertificadora  := 3479;
  inutelefono             := 3002569658;
  inutipopredio           := 2;
  inuestadoley            := 1;
  inupromicion            := 86;
  inuplancomercial        := 4;
  inuvalortotal           := 2334930;
  inuplanfinanciacion     := 23;
  inucuotaincial          := 151288;
  inunumerocuotas         := 72;
  inucuotamensual         := 67973.72;
  inuformapago            := 13;
  isbcuotainicialrecibida := 'N';
  inutipoinstalacion      := 1;
  inuUso                  := 1;

  isbRequestXML := PKG_XML_SOLI_VENTA.getsolicitudventagasformulario(inufuncionario,
                                                                     inupuntoatencion,
                                                                     inutipoformulario,
                                                                     inunumeroformulario,
                                                                     isbobservacion,
                                                                     inudireccionid,
                                                                     inutipoidentificacion,
                                                                     inuidentificacion,
                                                                     isbnombre,
                                                                     isbapellido,
                                                                     isbnombreempresa,
                                                                     isbcargo,
                                                                     isbcorreo,
                                                                     inucantidapersonas,
                                                                     inuenergeticoanterior,
                                                                     isbpredioconstruccion,
                                                                     inutencicoventas,
                                                                     inuunidadinstaladora,
                                                                     inuunidadcertificadora,
                                                                     inutelefono,
                                                                     inutipopredio,
                                                                     inuestadoley,
                                                                     inupromicion,
                                                                     inuplancomercial,
                                                                     inuvalortotal,
                                                                     inuplanfinanciacion,
                                                                     inucuotaincial,
                                                                     inunumerocuotas,
                                                                     inucuotamensual,
                                                                     inuformapago,
                                                                     isbcuotainicialrecibida,
                                                                     inutipoinstalacion,
                                                                     inuUso);*/

  dbms_output.put_line('-----------------------------------');
  dbms_output.put_line(isbRequestXML);
  dbms_output.put_line('-----------------------------------');
  "OPEN".OS_RegisterRequestWithXML(isbRequestXML,
                                   onuPackageId,
                                   onuMotiveId,
                                   onuErrorCode,
                                   osbErrorMessage);
  IF (onuErrorCode = 0) THEN
    DBMS_OUTPUT.PUT_LINE('Venta: ' || TO_CHAR(onuPackageId) ||
                         ' - Motivo: ' || TO_CHAR(onuMotiveId));
    --Commit;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Error:  ' || osbErrorMessage);
    ROLLBACK;
  END IF;

  /*
  select mp.*,rowid from open.mo_packages mp where mp.package_id=204747664; 
  select mm.*,rowid from open.mo_motive mm where mm.package_id=204747664; 
  select ma.*,rowid from open.mo_address ma where ma.package_id=204747664;
  select ma.*,rowid from open.mo_component ma where ma.package_id = 204747664;
  select ma.*,rowid from open.ge_subscriber ma where ma.identification = '1203169900';
  select ma.*,rowid from open.ge_subs_work_relat ma where ma.subscriber_id in (select ma1.subscriber_id from open.ge_subscriber ma1 where ma1.identification = '1203169900');
  select ma.*,rowid from open.ge_subs_housing_data ma where ma.subscriber_id in (select ma1.subscriber_id from open.ge_subscriber ma1 where ma1.identification = '1203169900');
  select ma.*,rowid from open.ldc_energetico_ant ma where ma.package_id=204747664;
  select ma.*,rowid from open.ldc_daadventa ma where ma.package_id=204747664;
  select ma.*,rowid from open.ge_subs_phone ma where ma.subscriber_id in (select ma1.subscriber_id from open.ge_subscriber ma1 where ma1.identification = '1203169900');
  select ma.*,rowid from open.mo_mot_promotion ma where ma.motive_id in (select mm.motive_id  from open.mo_motive mm where mm.package_id=204747664);
  select ma.*,rowid from open.MO_GAS_SALE_DATA ma where ma.package_id=204747664;
      */

EXCEPTION
  WHEN "OPEN".EX.CONTROLLED_ERROR THEN
    "OPEN".ERRORS.GETERROR(onuErrorCode, osbErrorMessage);
    ROLLBACK;
  WHEN OTHERS THEN
    "OPEN".ERRORS.SETERROR;
    "OPEN".ERRORS.GETERROR(onuErrorCode, osbErrorMessage);
    ROLLBACK;
END;
