CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNCONSULTAORDENES" 
  return constants_per.tyRefCursor IS
  /*****************************************************************
  Propiedad intelectual de GDO (c).

  Unidad : OPEN.LDC_FnConsultaOrdenes
   Descripcion    : Funci?n para consultar las ?rdenes de acuerdo a la fecha de venta.
   Autor          : ?lvaro Zapata
   Fecha          : 16/12/2013

   Parametros              Descripcion
   ============         ===================

   Fecha             Autor                Modificacion
   =========       =========             ====================
   28/05/2018      Sebastian Tapias      REQ.2001942:
                                         Exclusión de validaciones con pagare único para ventas con devolución total.
                                         Aplicación de ROWNUN para la subconsulta de pagare único.
   13/07/2016      Jorge Valiente        CASO 200-85:Validacion de la gasera para modificar el resultado de lso datos
                                                     a mostrar en la forma LODPD.
                                                     En caso de ser GDC mostrara los datos modificados del CODEUDOR.
                                                     En caso de ser EFIGAS no mostrar lso datos modificados del CODEUDOR
                                                        debido a qeu FIFAP para EFIGAS no permite actualizar datos del CODEUDOR.
   24/02/2015      jhinestroza.NC3823    Se modifica para que muestre :
                                         Nuevo Nombre del Cliente, Identifiacion del Cliente, Nueva Identifiacion.
   05/02/2015      KCienfuegos.RNP3339   Se modifica para que no muestre ventas con devoluci?n parcial.
   19/12/2014      KCienfuegos.RNP3339   Se modifica para que muestre el nombre del due?o del contrato
                                         y no el del deudor, ya que se est?n generando errores por aquellos
                                         usuarios con una misma identificaci?n.
   01/12/2014      KCienfuegos.RNP3339   Se agrega un distinct en la consulta y se agrega la validaci?n del tipo de id.
   21/11/2014      llarrarte.NC3337      Se modifica para que muestre el nombre
                                         del deudor en lugar del nombre del due?o del contrato
   11/11/2014      KCienfuegos.RNP3339   Se modifica actualizando la consulta teniendo en cuenta
                                         los campos de fecha inicial y final. Se adiciona un condicional
                                         con los campos del departamento y proveedor.
                                         En la consulta se agrega el campo de Valor a Financiar y Pagar?.
                                         Se valida si se deben desplegar s?lo las ventas con devoluci?n total.

   14/11/2014      paulaagNC3445         Se modifica la consulta para que tenga en cuenta el Estado de Ley en
                                         la consulta. Si se consulta este campo con valor, deber? buscar los datos
                                         que cumplan con el dato ingresado. Si llega sin valor, no lo tiene
                                         en cuenta en la consulta.
   ******************************************************************/

  cnuNULL_ATTRIBUTE constant number := 2126;

  sbSALE_DATE           ge_boInstanceControl.stysbValue;
  nuOperUnit            ge_boInstanceControl.stysbValue;
  sbFINAL_DATE          ge_boInstanceControl.stysbValue;
  sbSUPPLIER_ID         ge_boInstanceControl.stysbValue;
  sbDEPARTMENT          ge_boInstanceControl.stysbValue;
  sbREQUI_APPROV_ANNULM ge_boInstanceControl.stysbValue;
  rfCursor              constants_per.tyRefCursor;
  sbQuery               varchar2(32767);
  sbYesflag             varchar2(1) := CONSTANTS_PER.CSBYES;
  sbNoflag              varchar2(1) := CONSTANTS_PER.CSBNO;

  -- paulaag [13/11/2014] Inicio NC 3448.
  -- CASO: CRM-BRI-ERROR REPORTE LODPD REVISI?N DOCUMENTOS DATOS PERSONALES NO ACTUALIZA CAMPO MANEJO DE INFORMACION
  -- Resultado esperado: Actualizar el campo "Estado de Ley" del cliente y "Manejo de Informaci?n" del cliente.
  -- Validado con Nhora Renteria.
  -- paulaag [30/01/2015] Cambio de alcance para NC 3448. No debe ser un filtro de b?squeda.

  nuCODEUDOR number := 0;

  sbQuery1 varchar2(32767);
  sbQuery2 varchar2(32767);
  sbQuery3 varchar2(32767);

BEGIN

  sbSALE_DATE           := ge_boInstanceControl.fsbGetFieldValue('LD_NON_BA_FI_REQU',
                                                                 'SALE_DATE');
  sbFINAL_DATE          := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER',
                                                                 'CREATED_DATE');
  sbSUPPLIER_ID         := ge_boInstanceControl.fsbGetFieldValue('LD_SUPPLI_SETTINGS',
                                                                 'SUPPLIER_ID');
  nuOperUnit            := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                                 'OPERATING_UNIT_ID');
  sbDEPARTMENT          := ge_boInstanceControl.fsbGetFieldValue('GE_GEOGRA_LOCATION',
                                                                 'GEOGRAP_LOCATION_ID');
  sbREQUI_APPROV_ANNULM := ge_boInstanceControl.fsbGetFieldValue('LD_SUPPLI_SETTINGS',
                                                                 'REQUI_APPROV_ANNULM');
                                                                
  nuCODEUDOR :=1;

  ------------------------------------------------
  -- Required Attributes
  ------------------------------------------------


  if (sbSALE_DATE is null) then
    Errors.SetError(cnuNULL_ATTRIBUTE, 'Fecha Visita');
    raise ex.CONTROLLED_ERROR;
  end if;

  ------------------------------------------------
  -- User code
  ------------------------------------------------
  ut_trace.trace('if (sbREQUI_APPROV_ANNULM[' || sbREQUI_APPROV_ANNULM ||
                 '] = sbYesflag[' || sbYesflag || ']) then',
                 11);
  if (sbREQUI_APPROV_ANNULM = sbYesflag) then
    --Consulta para ?rdenes con devoluci?n total
    sbQuery := 'select /*+ INDEX (LNBFR PK_LD_NON_BA_FI_REQU)*/ distinct ooa.order_id, oaa.package_id, p.subscription_pend_id Contrato ,
                  Dage_Subscriber.fsbGetSubscriber_Name(gs.subscriber_id)||'' ''||Dage_Subscriber.fsbGetSubs_Last_Name(gs.subscriber_id) "Nombre del Cliente",
                  ldc_fsbGetNewNameLODPD(oaa.package_id, p.subscription_pend_id) "Nuevo Nombre del Cliente",-- nuevo campo Nuevo Nombre
                  Dage_Subscriber.Fsbgetidentification(gs.subscriber_id) "Identifiacion del Cliente",      -- nuevo campo Identifiacion del Cliente
                  ldc_fnuGetNewIdentLODPD(oaa.package_id, p.subscription_pend_id) "Nueva Identifiacion",    -- nuevo campo Nueva Identifiacion
                  LNBFR.Sale_Date "Fecha de Venta" ,  p.request_date, oaa.final_date "Fecha Final",
                  ld_bononbankfinancing.fnuSaleValue(p.package_id) "Valor Total de Venta", (ld_bononbankfinancing.fnuSaleValue(p.package_id) - LNBFR.Payment) "Valor a Financiar",LNBFR.Payment "Cuota Inicial",nvl(LNBFR.digital_prom_note_cons,LNBFR.manual_prom_note_cons) Pagare,
                  daor_operating_unit.fnuGetContractor_Id(p.operating_unit_id,0)||'' - ''||dage_contratista.fsbGetNombre_Contratista(daor_operating_unit.fnuGetContractor_Id(p.operating_unit_id,0),0) Contratista,
                  dage_person.fsbGetName_(p.person_id,0) vendedor ,p.operating_unit_id||'' - ''||daor_operating_unit.fsbGetName(p.operating_unit_id,0) operating_unit,
                  p.reception_type_id||'' - ''||dage_reception_type.fsbGetDescription(p.reception_type_id) "Punto de Venta"';

    --Inicio CASO 200-85
    --REQ.2001942 --> Se aplica "and rownum = 1" En la subconsulta de pagare unico.
    if nuCODEUDOR = 1 then
      sbQuery := sbQuery ||
                 ',(select lda.old_name from LDC_DATOS_ACTUALIZAR lda where lda.package_id = p.package_id and lda.tipo_cambio = ''Nombre y/o ID'') "Nombre Codeudor",
      (select lda.new_name from LDC_DATOS_ACTUALIZAR lda where lda.package_id = p.package_id and lda.tipo_cambio = ''Nombre y/o ID'') "Nuevo Nombre Codeudor",
      (select lda.old_lastname from LDC_DATOS_ACTUALIZAR lda where lda.package_id = p.package_id and lda.tipo_cambio = ''Nombre y/o ID'') "Apellido Codeudor",
      (select lda.new_lastname from LDC_DATOS_ACTUALIZAR lda where lda.package_id = p.package_id and lda.tipo_cambio = ''Nombre y/o ID'') "Nuevo Apellido Codeudor",
      (select lda.old_ident from LDC_DATOS_ACTUALIZAR lda where lda.package_id = p.package_id and lda.tipo_cambio = ''Nombre y/o ID'') "Identificacion Codeudor",
      (select lda.new_ident from LDC_DATOS_ACTUALIZAR lda where lda.package_id = p.package_id and lda.tipo_cambio = ''Nombre y/o ID'') "Nueva Identificacion Codeudor",
      (select decode(nvl(lp.pagare_id,0),0,NULL,lp.pagare_id || ''-'' || lp.voucher) from LDC_PAGUNIDET LP where lp.package_id_sale = p.package_id and rownum = 1) "PAGARE UNICO"';
    else
      --REQ.200-1942 <--

      --Inicio 200-854
      --REQ.2001942 --> Se aplica "and rownum = 1" En la subconsulta de pagare unico.
      sbQuery := sbQuery ||
                 '(select decode(nvl(lp.pagare_id,0),0,NULL,lp.pagare_id || ''-'' || lp.voucher) from LDC_PAGUNIDET LP where lp.package_id_sale = p.package_id and rownum = 1) "PAGARE UNICO"';
      --REQ.200-1942 <--
      --Fin 200-854
    end if;
    --Fin CASO 200-85

    sbQuery1 := sbQuery;

    sbQuery := sbQuery ||
               'from --or_order oo, or_order_activity oa,
                                or_order ooa , or_order_activity oaa, ld_non_ba_fi_requ LNBFR,or_order oe, or_order_activity oae, mo_packages p, ge_subscriber gs
                  where --oo.order_id = oa.order_id AND
                  gs.subscriber_id = p.subscriber_id
                  and ooa.order_id = oaa.order_id
                  AND OOA.ORDER_STATUS_ID = Dald_Parameter.fnuGetNumeric_Value(''COD_ESTADO_ASIGNADA_OT'',0)
                  --and oa.order_activity_id = oaa.origin_activity_id
                  and LNBFR.non_ba_fi_requ_id  = oaa.package_id
                  and LNBFR.non_ba_fi_requ_id = p.package_id
                  --and oa.activity_id =  ld_bononbankfinancing.fnuSaleActiType
                  and oaa.activity_id = ld_bononbankfinancing.fnuReviActiType
                  and oe.order_id = oae.order_id
                  and oae.package_id = LNBFR.non_ba_fi_requ_id
                  and oae.order_id = oe.order_id
                  and oae.status = ''F''
                  and oae.activity_id = Dald_parameter.fnuGetNumeric_Value(''ACT_TYPE_DEL_FNB'')
                  and TRUNC(SALE_DATE) >=   to_date(''' ||
               sbSALE_DATE || ''')
                  and TRUNC (SALE_DATE)<=   to_date(''' ||
               sbFINAL_DATE || ''')
                   and (select count(*)
                         from or_order_activity ta
                        where ta.package_id=oaa.package_id
                          and ta.activity_id in (Dald_parameter.fnuGetNumeric_Value(''ACTIVITY_TYPE_FNB''),Dald_parameter.fnuGetNumeric_Value(''ACT_TYPE_DEL_FNB''))) = (select count(w.order_activity_id)
                                                                                                                                                                           from ld_item_work_order w, or_order_activity tta
                                                                                                                                                                          where tta.order_activity_id = w.order_activity_id
                                                                                                                                                                            and tta.package_id= oaa.package_id and w.state in (''AN'')
                                                                                                                                                                            and tta.activity_id in(Dald_parameter.fnuGetNumeric_Value(''ACT_TYPE_DEL_FNB''),Dald_parameter.fnuGetNumeric_Value(''ACTIVITY_TYPE_FNB'')))';

    sbQuery2 := 'from --or_order oo, or_order_activity oa,
                                or_order ooa , or_order_activity oaa, ld_non_ba_fi_requ LNBFR,or_order oe, or_order_activity oae, mo_packages p, ge_subscriber gs
                  where --oo.order_id = oa.order_id AND
                  gs.subscriber_id = p.subscriber_id
                  and ooa.order_id = oaa.order_id
                  AND OOA.ORDER_STATUS_ID = Dald_Parameter.fnuGetNumeric_Value(''COD_ESTADO_ASIGNADA_OT'',0)
                  --and oa.order_activity_id = oaa.origin_activity_id
                  and LNBFR.non_ba_fi_requ_id  = oaa.package_id
                  and LNBFR.non_ba_fi_requ_id = p.package_id
                  --and oa.activity_id =  ld_bononbankfinancing.fnuSaleActiType
                  and oaa.activity_id = ld_bononbankfinancing.fnuReviActiType
                  and oe.order_id = oae.order_id
                  and oae.package_id = LNBFR.non_ba_fi_requ_id
                  and oae.order_id = oe.order_id
                  and oae.status = ''F''
                  and oae.activity_id = Dald_parameter.fnuGetNumeric_Value(''ACT_TYPE_DEL_FNB'')
                  and TRUNC(SALE_DATE) >=   to_date(''' ||
                sbSALE_DATE || ''')
                  and TRUNC (SALE_DATE)<=   to_date(''' ||
                sbFINAL_DATE || ''')
                   and (select count(*)
                         from or_order_activity ta
                        where ta.package_id=oaa.package_id
                          and ta.activity_id in (Dald_parameter.fnuGetNumeric_Value(''ACTIVITY_TYPE_FNB''),Dald_parameter.fnuGetNumeric_Value(''ACT_TYPE_DEL_FNB''))) = (select count(w.order_activity_id)
                                                                                                                                                                           from ld_item_work_order w, or_order_activity tta
                                                                                                                                                                          where tta.order_activity_id = w.order_activity_id
                                                                                                                                                                            and tta.package_id= oaa.package_id and w.state in (''AN'')
                                                                                                                                                                            and tta.activity_id in(Dald_parameter.fnuGetNumeric_Value(''ACT_TYPE_DEL_FNB''),Dald_parameter.fnuGetNumeric_Value(''ACTIVITY_TYPE_FNB'')))';

  else

    sbQuery := 'select /*+ INDEX (LNBFR PK_LD_NON_BA_FI_REQU)*/ distinct ooa.order_id, oaa.package_id, p.subscription_pend_id Contrato ,
                  Dage_Subscriber.fsbGetSubscriber_Name(gs.subscriber_id)||'' ''||Dage_Subscriber.fsbGetSubs_Last_Name(gs.subscriber_id) "Nombre del Cliente",
                  ldc_fsbGetNewNameLODPD(oaa.package_id, p.subscription_pend_id) "Nuevo Nombre del Cliente",-- nuevo campo Nuevo Nombre
                  Dage_Subscriber.Fsbgetidentification(gs.subscriber_id) "Identifiacion del Cliente",      -- nuevo campo Identifiacion del Cliente
                  ldc_fnuGetNewIdentLODPD(oaa.package_id, p.subscription_pend_id) "Nueva Identifiacion",    -- nuevo campo Nueva Identifiacion
                  LNBFR.Sale_Date "Fecha de Venta" ,  p.request_date, oaa.final_date "Fecha Final",
                  ld_bononbankfinancing.fnuSaleValue(p.package_id) "Valor Total de Venta", (ld_bononbankfinancing.fnuSaleValue(p.package_id) - LNBFR.Payment) "Valor a Financiar",LNBFR.Payment "Cuota Inicial",nvl(LNBFR.digital_prom_note_cons,LNBFR.manual_prom_note_cons) Pagare,
                  daor_operating_unit.fnuGetContractor_Id(p.operating_unit_id,0)||'' - ''||dage_contratista.fsbGetNombre_Contratista(daor_operating_unit.fnuGetContractor_Id(p.operating_unit_id,0),0) Contratista,
                  dage_person.fsbGetName_(p.person_id,0) vendedor ,p.operating_unit_id||'' - ''||daor_operating_unit.fsbGetName(p.operating_unit_id,0) operating_unit,
                  p.reception_type_id||'' - ''||dage_reception_type.fsbGetDescription(p.reception_type_id) "Punto de Venta"';

    --Inicio CASO 200-85
    --REQ.2001942 --> Se aplica "and rownum = 1" En la subconsulta de pagare unico.
    if nuCODEUDOR = 1 then
      sbQuery := sbQuery ||
                 ',(select lda.old_name from LDC_DATOS_ACTUALIZAR lda where lda.package_id = p.package_id and lda.tipo_cambio = ''Nombre y/o ID'') "Nombre Codeudor",
      (select lda.new_name from LDC_DATOS_ACTUALIZAR lda where lda.package_id = p.package_id and lda.tipo_cambio = ''Nombre y/o ID'') "Nuevo Nombre Codeudor",
      (select lda.old_lastname from LDC_DATOS_ACTUALIZAR lda where lda.package_id = p.package_id and lda.tipo_cambio = ''Nombre y/o ID'') "Apellido Codeudor",
      (select lda.new_lastname from LDC_DATOS_ACTUALIZAR lda where lda.package_id = p.package_id and lda.tipo_cambio = ''Nombre y/o ID'') "Nuevo Apellido Codeudor",
      (select lda.old_ident from LDC_DATOS_ACTUALIZAR lda where lda.package_id = p.package_id and lda.tipo_cambio = ''Nombre y/o ID'') "Identificacion Codeudor",
      (select lda.new_ident from LDC_DATOS_ACTUALIZAR lda where lda.package_id = p.package_id and lda.tipo_cambio = ''Nombre y/o ID'') "Nueva Identificacion Codeudor",
      (select decode(nvl(lp.pagare_id,0),0,NULL,lp.pagare_id || ''-'' || lp.voucher) from LDC_PAGUNIDET LP where lp.package_id_sale = p.package_id and rownum = 1) "PAGARE UNICO"';
    else
      --REQ.200-1942 <--

      --Inicio 200-854
      --REQ.2001942 --> Se aplica "and rownum = 1" En la subconsulta de pagare unico.
      sbQuery := sbQuery ||
                 '(select decode(nvl(lp.pagare_id,0),0,NULL,lp.pagare_id || ''-'' || lp.voucher) from LDC_PAGUNIDET LP where lp.package_id_sale = p.package_id and rownum = 1) "PAGARE UNICO"';
      --REQ.200-1942 <--
      --Fin 200-854
    end if;
    --Fin CASO 200-85

    sbQuery1 := sbQuery;

    sbQuery := sbQuery ||
               'from --or_order oo, or_order_activity oa,
                                or_order ooa , or_order_activity oaa, ld_non_ba_fi_requ LNBFR, mo_packages p, ge_subscriber gs
                  where --oo.order_id = oa.order_id and
                  gs.subscriber_id = p.subscriber_id
                  and ooa.order_id = oaa.order_id
                  and OOA.ORDER_STATUS_ID = Dald_Parameter.fnuGetNumeric_Value(''COD_ESTADO_ASIGNADA_OT'',0)
                  --and oa.order_activity_id = oaa.origin_activity_id
                  and LNBFR.non_ba_fi_requ_id  = oaa.package_id
                  and LNBFR.non_ba_fi_requ_id = p.package_id
                  --and oa.activity_id =  ld_bononbankfinancing.fnuSaleActiType
                  and oaa.activity_id = ld_bononbankfinancing.fnuReviActiType
                  and TRUNC(SALE_DATE) >=   to_date(''' ||
               sbSALE_DATE || ''')
                  and TRUNC (SALE_DATE)<=   to_date(''' ||
               sbFINAL_DATE || ''')';

    sbQuery2 := 'from --or_order oo, or_order_activity oa,
                                or_order ooa , or_order_activity oaa, ld_non_ba_fi_requ LNBFR, mo_packages p, ge_subscriber gs
                  where --oo.order_id = oa.order_id and
                  gs.subscriber_id = p.subscriber_id
                  and ooa.order_id = oaa.order_id
                  and OOA.ORDER_STATUS_ID = Dald_Parameter.fnuGetNumeric_Value(''COD_ESTADO_ASIGNADA_OT'',0)
                  --and oa.order_activity_id = oaa.origin_activity_id
                  and LNBFR.non_ba_fi_requ_id  = oaa.package_id
                  and LNBFR.non_ba_fi_requ_id = p.package_id
                  --and oa.activity_id =  ld_bononbankfinancing.fnuSaleActiType
                  and oaa.activity_id = ld_bononbankfinancing.fnuReviActiType
                  and TRUNC(SALE_DATE) >=   to_date(''' ||
                sbSALE_DATE || ''')
                  and TRUNC (SALE_DATE)<=   to_date(''' ||
                sbFINAL_DATE || ''')';

  end if;

  ut_trace.trace('Ejecuci?n FnConsultaOrdenes sbQuery Inicial => ' ||
                 sbQuery,
                 11);

  if (nuOperUnit is not null) then
    sbQuery  := sbQuery || ' and p.operating_unit_id = to_number(''' ||
                nuOperUnit || ''')';
    sbQuery3 := ' and p.operating_unit_id = to_number(''' || nuOperUnit ||
                ''')';
  else
    if (sbSUPPLIER_ID is not null) then
      sbQuery  := sbQuery ||
                  ' and p.operating_unit_id in(select ou.operating_unit_id from  or_operating_unit ou where ou.contractor_id = to_number(''' ||
                  sbSupplier_id || '''))';
      sbQuery3 := ' and p.operating_unit_id in(select ou.operating_unit_id from  or_operating_unit ou where ou.contractor_id = to_number(''' ||
                  sbSupplier_id || '''))';
    end if;
  end if;

  if (sbDEPARTMENT is not null and sbDEPARTMENT <> -1) then
    sbQuery  := sbQuery ||
                ' and dage_geogra_location.fnugetgeo_loca_father_id(daab_address.fnugetgeograp_location_id(oaa.address_id)) = to_number(''' ||
                sbDEPARTMENT || ''')';
    sbQuery3 := sbQuery3 ||
                ' and dage_geogra_location.fnugetgeo_loca_father_id(daab_address.fnugetgeograp_location_id(oaa.address_id)) = to_number(''' ||
                sbDEPARTMENT || ''')';
  end if;

  ---------------------------------------------------------------------------------------------
  --REQ.2001942 -->
  --Obs. Cuando se activa el Flag "Solo ventas con devolución total" no se valida PAGARE UNICO
  ---------------------------------------------------------------------------------------------
  if (sbREQUI_APPROV_ANNULM <> sbYesflag) then

    sbQuery  := sbQuery ||
                ' and LDC_PKVENTAPAGOUNICO.FNUSOLICITUDVENTAPU(oaa.package_id) = 1';
    sbQuery3 := sbQuery3 ||
                ' and LDC_PKVENTAPAGOUNICO.FNUSOLICITUDVENTAPU(oaa.package_id) = 1';

  end if;
  -----------------
  --REQ.2001942 <--
  -----------------

  -- paula [13/11/2014] Fin NC 3448.
  -- paula [30/01/0215] Fin NC 3448. No debe ser un filtro de b?squeda.

  ut_trace.trace('Ejecuci?n FnConsultaOrdenes sbQuery Final => ' ||
                 sbQuery,
                 11);

  ut_trace.trace('Ejecuci?n FnConsultaOrdenes currentinstance =>' ||
                 ge_boInstanceControl.Fsbgetcurrentinstance(),
                 10);

  
  OPEN rfCursor FOR sbQuery;

  ut_trace.trace('Fin FnConsultaOrdenes', 10);

  return rfCursor;
EXCEPTION
  when no_data_found then
    if rfCursor%isopen then
      close rfCursor;
    end if;
    raise ex.CONTROLLED_ERROR;
  when ex.CONTROLLED_ERROR then
    raise;

  when OTHERS then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;

END LDC_FnConsultaOrdenes;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNCONSULTAORDENES', 'ADM_PERSON');
END;
/