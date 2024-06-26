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
  inuCantidaPersonas      ge_subs_housing_data.person_quantity%TYPE;
  inuEnergeticoAnterior   ldc_energetico_ant.energ_ant%TYPE;
  isbPredioConstruccion   ldc_daadventa.construccion%TYPE;
  inuTencicoVentas        ldc_daadventa.person_id%TYPE;
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
  inuUso                  MO_GAS_SALE_DATA.USAGE%TYPE;

BEGIN

  ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);

  inufuncionario          := 43046;
  inupuntoatencion        := 4107;
  inutipoformulario       := 8;
  inunumeroformulario     := 10518;
  isbobservacion          := 'Ventas Digitales test';
  inudireccionid          := 100223;
  inutipoidentificacion   := 1;
  inuidentificacion       := 1203169900;--1203169900;
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
  inupromicion            := 86; --84;
  inuplancomercial        := 4;
  inuvalortotal           := 2000256;
  inuplanfinanciacion     := 23;
  inucuotaincial          := 170068;
  inunumerocuotas         := 72;
  inucuotamensual         := 47910.95 ;
  inuformapago            := 13;
  isbcuotainicialrecibida := 'N';
  inutipoinstalacion      := 1;
  inuUso                  := 1;

  isbRequestXML := PKG_XML_SOLI_VENTA.getSolicitudVentaGasFormulario(inufuncionario,
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
                                                                     inuUso);

  "OPEN".OS_RegisterRequestWithXML(isbRequestXML,
                                   onuPackageId,
                                   onuMotiveId,
                                   onuErrorCode,
                                   osbErrorMessage);

  IF (onuErrorCode = 0) THEN
    DBMS_OUTPUT.PUT_LINE('Venta: ' || TO_CHAR(onuPackageId) ||
                         ' - Motivo: ' || TO_CHAR(onuMotiveId));
    Commit;
    --ROLLBACK;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Error:  ' || osbErrorMessage);
    ROLLBACK;
  END IF;

EXCEPTION
  WHEN "OPEN".EX.CONTROLLED_ERROR THEN
    "OPEN".ERRORS.GETERROR(onuErrorCode, osbErrorMessage);
    ROLLBACK;
  WHEN OTHERS THEN
    "OPEN".ERRORS.SETERROR;
    "OPEN".ERRORS.GETERROR(onuErrorCode, osbErrorMessage);
    ROLLBACK;
END;
/
