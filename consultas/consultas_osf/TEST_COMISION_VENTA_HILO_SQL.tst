PL/SQL Developer Test script 3.0
2398
-- Created on 19/06/2024 by JORGE VALIENTE 
declare

  csbLDC_CONTRA_SIN_DIGIT_INDEX CONSTANT ld_parameter.value_chain%TYPE := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_CONTRA_SIN_DIGIT_INDEX');

  cnuNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;

  nuPkgAtendido ps_package_type.package_type_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('ID_ESTADO_PKG_ATENDTIDO');
  nuPkgAnulado  ps_package_type.package_type_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('ID_ESTADO_PKG_ANULADA');
  nuActCIVZNR   LDC_PKG_OR_ITEM.order_item_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('ACT_COMISION_INICIO_VENTA_ZNR');
  nuActCIVZSR   LDC_PKG_OR_ITEM.order_item_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('ACT_COMISION_INICIO_VENTA_ZSR');
  nuActCIVZNC   LDC_PKG_OR_ITEM.order_item_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('ACT_COMISION_INICIO_VENTA_ZNC');
  nuActCIVZSC   LDC_PKG_OR_ITEM.order_item_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('ACT_COMISION_INICIO_VENTA_ZSC');
  nuActMZR      LDC_PKG_OR_ITEM.order_item_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('ID_MULTA_VENTA_OTRA_ZONA_RESID');
  nuActMZC      LDC_PKG_OR_ITEM.order_item_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('ID_MULTA_VENTA_OTRA_ZONA_COMM');

  nuActCLVZNR LDC_PKG_OR_ITEM.order_item_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('ACT_COMISION_LEG_VENTA_ZNR');
  nuActCLVZSR LDC_PKG_OR_ITEM.order_item_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('ACT_COMISION_LEG_VENTA_ZSR');
  nuActCLVZNC LDC_PKG_OR_ITEM.order_item_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('ACT_COMISION_LEG_VENTA_ZNC');
  nuActCLVZSC LDC_PKG_OR_ITEM.order_item_id%type := pkg_bcld_parameter.fnuobtienevalornumerico('ACT_COMISION_LEG_VENTA_ZSC');

  idtToday          DATE := '19-06-2024 15:10:24';
  idtCorte          DATE := '19-06-2024 15:06:11';
  idtBegin          DATE := '17-04-2021 10:50:18';
  isbPackagesType   VARCHAR2(4000) := '271,100229,329,323,100271';
  inuSesion         NUMBER := 1280934070;
  isbProcessName    VARCHAR2(4000) := 'JOBGOPCVNEL19062024151024';
  inuTotalRegistros NUMBER := 5053;
  inuNroHilo        NUMBER := 1;
  inuTotHilos       NUMBER := 10;

  csbMetodo CONSTANT VARCHAR2(100) := 'prcHiloCadenaJobs';
  nuErrorCode NUMBER; -- se almacena codigo de error
  sbMensError VARCHAR2(2000); -- se almacena descripcion del error

  nuExisteContratoVigente number;

  sbProcesoInterno VARCHAR2(100) := (isbProcessName) || '_' ||
                                    to_char(inuNroHilo);

  TYPE RgCommissionRegister IS RECORD(
    onuCommissionValue number,
    sbIsZone           ldc_info_predio.is_zona%type,
    sbIsZoneOri        ldc_info_predio.is_zona%type);

  nuTaskTypeId      or_task_type.task_type_id%type;
  nuCateCodi        ldc_comision_plan_nel.CATECODI%type;
  nuGeograpDepto    ge_geogra_location.geograp_location_id%type;
  nuGeograpLoca     ge_geogra_location.geograp_location_id%type;
  nuOperatingUnitId or_operating_unit.operating_unit_id%type;
  nuSalesmanId      mo_packages.person_id%type;
  nuZoneIdProduct   or_operating_zone.operating_zone_id%type;
  nuZoneId          or_operating_zone.operating_zone_id%type;
  nuBaseId          ge_base_administra.id_base_administra%Type;
  sbAssignType      or_operating_unit.assign_type%type;
  nuSegmentId       ab_address.segment_id%type;
  nuAdressId        pr_product.address_id%type;
  RgCommission      RgCommissionRegister;
  rgData            ldc_pkg_or_item%rowtype;
  SBobservacion     ldc_pkg_or_item.OBSERVACION%TYPE;
  sbDOCUMENT_KEY    mo_packages.DOCUMENT_KEY%type;
  inuOrderId        or_order.order_id%type;
  nugrabados        number := 0;

  inuPersonId            SA_USER.user_id%type;
  isbObservation         VARCHAR2(400);
  onuErrorCode           number;
  osbErrorMessage        varchar2(2000);
  onuErrorCodeAdd        number;
  osbErrorMessageAdd     varchar2(2000);
  inuActivity            ge_items.items_id%type;
  nuOperatingSectorId    ab_segments.operating_sector_id%type;
  nuOperatingSectorIdAux ab_segments.operating_sector_id%type := 0;

  nuContadorTotal NUMBER := 0;
  nuContador      NUMBER := 0;

  cursor cuPackages(idtToday         date,
                    idtLastExecution date,
                    isbPackagesType  varchar2) is
  --Solicitudes de venta pendientes por pago de comision al legalizar
  
  /*select 205608619 id, 'L' sbTime
                from dual/*
              union all
              select 202803399 id, 'B' sbTime
                from dual
              union all
              select 202803399 id, 'L' sbTime
                from dual
              union all
              select 212247589 id, 'B' sbTime
                from dual*/ --;
  
  --/*
    select *
      from ((select mo_packages.package_id id, 'B' sbTime
               from mo_packages
              Where mo_packages.request_date Between
                    To_Date('01022020', 'DDMMYYYY') And idtToday
                   --and PKG_BCUNIDADOPERATIVA.FSBGETESEXTERNA(mo_packages.pos_oper_unit_id) = 'Y'
                and mo_packages.pos_oper_unit_id in
                    (4321, 4585, 4341, 4342, 4585, 4585)
                and mo_packages.package_type_id in
                    (SELECT to_number(regexp_substr(isbPackagesType,
                                                    '[^,]+',
                                                    1,
                                                    LEVEL)) AS tipk
                       FROM dual
                     CONNECT BY regexp_substr(isbPackagesType,
                                              '[^,]+',
                                              1,
                                              LEVEL) IS NOT NULL)
                AND mo_packages.PACKAGE_TYPE_ID <> 100271
                and mo_packages.MOTIVE_STATUS_ID <> nuPkgAnulado -- 32-Solicitud ANULADA
                and (((select count(1)
                         from cupon
                        where cupotipo = 'DE'
                          AND cupoflpa = 'S'
                          and cupodocu = to_char(mo_packages.package_id)) > 0) Or
                    ((select count(1)
                         from cupon
                        where cupotipo = 'DE'
                          AND cupodocu = to_char(mo_packages.package_id)) = 0))
                and not exists (select null
                       from LDC_PKG_OR_ITEM
                      where Mo_packages.package_id =
                            LDC_PKG_OR_ITEM.package_id
                        and LDC_PKG_OR_ITEM.order_item_id in
                            (nuActCIVZNR,
                             nuActCIVZSR,
                             nuActCIVZNC,
                             nuActCIVZSC,
                             nuActMZR,
                             nuActMZC))
                AND mod(mo_packages.package_id, inuTotHilos) +
                    inuNroHilo = inuTotHilos) union
           --Solicitudes de venta pendientes por pago de comision al legalizar
            (select mo_packages.package_id id, 'L' sbTime
               from mo_packages
              Where mo_packages.request_date Between
                    To_Date('01022020', 'DDMMYYYY') And idtToday
                   --and PKG_BCUNIDADOPERATIVA.FSBGETESEXTERNA(mo_packages.pos_oper_unit_id) = 'Y'
                and mo_packages.pos_oper_unit_id in
                    (4321, 4585, 4341, 4342, 4585, 4585)
                and mo_packages.package_type_id in
                    (SELECT to_number(regexp_substr(isbPackagesType,
                                                    '[^,]+',
                                                    1,
                                                    LEVEL)) AS tipk
                       FROM dual
                     CONNECT BY regexp_substr(isbPackagesType,
                                              '[^,]+',
                                              1,
                                              LEVEL) IS NOT NULL)
                and mo_packages.MOTIVE_STATUS_ID = nuPkgAtendido -- 14-Solicitud atendida
                and (((select count(1)
                         from cupon
                        where cupotipo = 'DE'
                          AND cupoflpa = 'S'
                          and cupodocu = to_char(mo_packages.package_id)) > 0) Or
                    ((select count(1)
                         from cupon
                        where cupotipo = 'DE'
                          AND cupodocu = to_char(mo_packages.package_id)) = 0))
                and not exists (select null
                       from LDC_PKG_OR_ITEM
                      where mo_packages.package_id =
                            LDC_PKG_OR_ITEM.package_id
                        and LDC_PKG_OR_ITEM.order_item_id in
                            (nuActCLVZNR,
                             nuActCLVZSR,
                             nuActCLVZNC,
                             nuActCLVZSC,
                             nuActMZR,
                             nuActMZC))
                AND mod(mo_packages.package_id, inuTotHilos) +
                    inuNroHilo = inuTotHilos));
  --*/

  nuProductId  pr_product.product_id%type;
  sbES_externa or_operating_unit.es_externa%type;

  --Cursor para validar  el sector operativo
  cursor cuOperatingSector(inuBaseId   ge_base_administra.id_base_administra%type,
                           inuSectorId or_operating_sector.operating_sector_id%type) is
    select count(*) nuSectorId
      from or_zona_base_adm, ge_sectorope_zona
     where or_zona_base_adm.operating_zone_id =
           ge_sectorope_zona.id_zona_operativa
       and or_zona_base_adm.id_base_administra = inuBaseId
       and ge_sectorope_zona.id_sector_operativo = inuSectorId;

  nuValue   number := 0;
  nuDays    number := 0;
  nuPercent number;
  nuNDays   number;
  nuBan     number := 0;

  --Cursor para obtener el identificador de la orden de multa
  --Retorna nulo porque el api no alcanza a crear el registro
  cursor cuOtMulta(isbObservation or_order_comment.order_comment%type) is
    select order_id id
      from or_order_comment
     where order_comment like isbObservation;

  --Cursor para validar si durante el proceso ya se genero multa
  cursor cuExisteMulta(inuPackageId mo_packages.package_id%type) is
    select count(*)
      from ldc_pkg_or_item
     where ORDER_ITEM_ID in (nuActMZR, nuActMZC)
       and package_id = inuPackageId;
  nuCount          number := 0;
  nuActivityId     or_order_activity.order_activity_id%type;
  nucontareg       NUMBER(15) DEFAULT 0;
  nucantiregcom    NUMBER(15) DEFAULT 0;
  nucantiregtot    NUMBER(15) DEFAULT 0;
  sbActivoOrdAdd   ld_parameter.value_chain%TYPE := nvl(pkg_bcld_parameter.fsbobtienevalorcadena('PARACTIVACIONOTADDPC'),
                                                        0);
  sbTaskTypeOrdAdd ld_parameter.value_chain%TYPE := nvl(pkg_bcld_parameter.fsbobtienevalorcadena('PARTTDIGINDGESTADDPC'),
                                                        0);
  nuOrderAdd       or_order.order_id%TYPE;
  nuActivityIdAdd  or_order_activity.order_activity_id%type;

  -- CA854
  CURSOR cuAplicaSubsidio(inuPackageId IN mo_packages.package_id%TYPE) IS
    SELECT aplicasubsidio
      FROM LDC_SUBSIDIOS
     WHERE PACKAGE_id = inuPackageId;

  CURSOR cuApplyCont(inuContratista IN LDC_INFO_OPER_UNIT_NEL.oper_unit_id%TYPE,
                     inuTipoComi    IN LDC_INFO_OPER_UNIT_NEL.tipo_comision_id%TYPE) IS
    SELECT count(1)
      FROM LDC_INFO_OPER_UNIT_NEL
     WHERE operating_unit_id = inuContratista
       AND tipo_comision_id = inuTipoComi
       AND apply_subcidy = 'Y';

  CURSOR cuInfoPremise(inuPremiseId IN ab_info_premise.premise_id%TYPE) IS
    SELECT date_ring FROM ab_info_premise WHERE premise_id = inuPremiseId;

  sbIsSubcidy LDC_SUBSIDIOS.aplicasubsidio%TYPE;

  CURSOR cuCupon(inuPackageId IN mo_packages.package_id%TYPE) IS
    SELECT cuponume, cupovalo, cupofech
      FROM cupon
     WHERE cupotipo = 'DE'
       AND cupoflpa = 'S'
       AND cupodocu = TO_CHAR(inuPackageId);

  cursor cuItem(inuItem number) is
    select gi.description from ge_items gi where gi.items_id = inuItem;

  sbItemDecripcion ge_items.description%type;

  nuCantMeses  ld_parameter.numeric_value%TYPE := nvl(pkg_bcld_parameter.fnuobtienevalornumerico('LDC_MESES_ZONA'),
                                                      0);
  dtFechaRing  ab_info_premise.date_ring%TYPE;
  sbZonaCalc   ldc_info_predio.is_zona%TYPE;
  nuSucate     pr_product.subcategory_id%TYPE;
  nuCommerPlan pr_product.commercial_plan_id%TYPE;
  nuCupon      cupon.cuponume%TYPE;
  nuCupoVal    cupon.cupovalo%TYPE;
  dtCuponDate  pagos.pagofepa%TYPE;
  nuOperUnit   OR_order.operating_unit_id%TYPE;
  nuPersonId   OR_order_person.person_id%TYPE;
  nuAppliCont  NUMBER;
  nuContraId   ge_contratista.id_contratista%TYPE;
  nuCommiType  LDC_INFO_OPER_UNIT_NEL.tipo_comision_id%TYPE;
  sbZonaTAbla  varchar2(1);

  cursor cuSectorOperativo(inuSegmentId number) is
    select a.operating_sector_id
      from AB_SEGMENTS a
     where a.segments_id = inuSegmentId;

  cursor cuZonaOperativa(inuOperatingSectorId number) is
    select a.operating_zone_id
      from OR_OPERATING_SECTOR a
     where a.operating_sector_id = inuOperatingSectorId;

  PROCEDURE PROCVALRANGOTIEMPLEGOT(DTASSIGNED_DATE     IN OR_ORDER.ASSIGNED_DATE%TYPE,
                                   DTLEGALIZATION_DATE IN OR_ORDER.LEGALIZATION_DATE%TYPE,
                                   NuDEPARTAMENTO      IN LDC_TMLOCALTTRA.DEPARTAMENTO%TYPE,
                                   NuLOCALIDAD         IN LDC_TMLOCALTTRA.LOCALIDAD%TYPE,
                                   NuTIPOTRABAJO       IN LDC_TMLOCALTTRA.TIPOTRABAJO%TYPE,
                                   NuCAUSAL            IN LDC_TMLOCALTTRA.CAUSAL%TYPE,
                                   NuPROVEEDOR         IN LDC_TMLOCALTTRA.PROVEEDOR%TYPE,
                                   NuNUMERODIAS        OUT LDC_TMLOCALTTRA.TIEMPO%TYPE,
                                   NuPORCENTAJE        OUT LDC_TMLOCALTTRA.PORCENTAJE%TYPE,
                                   NuVALOR             OUT LDC_TMLOCALTTRA.VALOR%TYPE,
                                   NuDias              OUT NUMBER) IS
    CURSOR CurTPLOCALTRA(NuDEPARTAMENTO LDC_TMLOCALTTRA.DEPARTAMENTO%TYPE,
                         NuLOCALIDAD    LDC_TMLOCALTTRA.LOCALIDAD%TYPE,
                         NuTIPOTRABAJO  LDC_TMLOCALTTRA.TIPOTRABAJO%TYPE,
                         NuCAUSAL       LDC_TMLOCALTTRA.CAUSAL%TYPE,
                         NuPROVEEDOR    LDC_TMLOCALTTRA.PROVEEDOR%TYPE) IS
      SELECT TIEMPO, PORCENTAJE, VALOR
        FROM LDC_TMLOCALTTRA
       WHERE NVL(DEPARTAMENTO, -1) =
             DECODE(NuDEPARTAMENTO, NULL, -1, NuDEPARTAMENTO)
         AND NVL(LOCALIDAD, -1) =
             DECODE(NuLOCALIDAD, NULL, -1, NuLOCALIDAD)
         AND TIPOTRABAJO = NuTIPOTRABAJO
         AND NVL(CAUSAL, -1) = DECODE(NuCAUSAL, NULL, -1, NuCAUSAL)
         AND NVL(PROVEEDOR, -1) =
             DECODE(NuPROVEEDOR, NULL, -1, NuPROVEEDOR);
  
    NumDia NUMBER(3);
  BEGIN
    OPEN CurTPLOCALTRA(NuDEPARTAMENTO,
                       NuLOCALIDAD,
                       NuTIPOTRABAJO,
                       NuCAUSAL,
                       NuPROVEEDOR);
  
    FETCH CurTPLOCALTRA
      INTO NuNUMERODIAS, NuPORCENTAJE, NuVALOR;
  
    CLOSE CurTPLOCALTRA;
  
    NumDia := 0;
    NuDias := 0;
  
    IF NuNUMERODIAS IS NOT NULL THEN
      NumDia := LDC_BOUTILITIES.FnuDiasHabiles(DTASSIGNED_DATE,
                                               DTLEGALIZATION_DATE);
    
      IF NumDia > NuNUMERODIAS THEN
        NuDias := NumDia - NuNUMERODIAS;
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      NuDias       := -1;
      NuNUMERODIAS := -1;
      NuPORCENTAJE := -1;
      NuVALOR      := -1;
  END PROCVALRANGOTIEMPLEGOT;

  function fnuContratoVigente(inuUnidadOperativa number) return number is
  
    csbMetodo VARCHAR2(70) := 'fnuContratoVigente';
    nuError   number;
    sbError   varchar2(4000);
  
    cursor cuContratoVigente is
      select count(1)
        from ge_contrato gc, or_operating_unit oou
       where gc.id_contratista = oou.contractor_id
         and oou.operating_unit_id = inuUnidadOperativa
         and gc.status = 'AB'
         and gc.fecha_final > sysdate;
  
    nuContratoVigente number;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbINICIO);
  
    open cuContratoVigente;
    fetch cuContratoVigente
      into nuContratoVigente;
    close cuContratoVigente;
  
    pkg_Traza.trace('Unidad Operativa ' || inuUnidadOperativa ||
                    ' - Cantidad de contratos vigentes: ' ||
                    nuContratoVigente,
                    cnuNivelTraza);
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN);
  
    return nuContratoVigente;
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, cnuNivelTraza);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERC);
      return - 1;
    WHEN OTHERS THEN
      pkg_error.setError;
      pkg_error.geterror(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, cnuNivelTraza);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERR);
      return - 1;
    
  END fnuContratoVigente;

  PROCEDURE prcCreaOrdenAdicionalComision(inuFatherOrder  IN or_order.order_id%type,
                                          inuPackageId    IN mo_packages.package_id%type,
                                          inuOperatinUnit IN or_operating_unit.operating_unit_id%type,
                                          inuPersonId     IN ge_person.person_id%TYPE,
                                          onuerrorcode    OUT ge_error_log.error_log_id%TYPE,
                                          osberrormessage OUT ge_error_log.description%TYPE,
                                          onuOrder        OUT or_order.order_id%TYPE) IS
  
    nuActiviy       ld_parameter.numeric_value%type := pkg_bcld_parameter.fnuobtienevalornumerico('PARACTIVIDADADDPC');
    nuValueComision ld_parameter.numeric_value%type := pkg_bcld_parameter.fnuobtienevalornumerico('PARVALORCOMISIONPC');
  
    sbComment     or_order_comment.order_comment%TYPE;
    nuTypeComment ge_comment_type.comment_type_id%TYPE := pkg_bcld_parameter.fnuobtienevalornumerico('ID_TIPO_OBS_COMISION_VENTA');
  
    CURSOR cuFatherOrderData(inuFatherOrder IN or_order.order_id%type) IS
      SELECT PACKAGE_id,
             motive_id,
             component_id,
             subscription_id,
             product_id,
             SUBSCRIBER_ID,
             address_id,
             OPERATING_SECTOR_ID
        FROM OR_ORDER_ACTIVITY
       WHERE ORDER_ID = inuFatherOrder
         AND ROWNUM = 1;
  
    rcDataOrder cuFatherOrderData%rowtype;
  
    nuContractor_Id or_operating_unit.contractor_id%TYPE;
  
    csbMetodo VARCHAR2(70) := 'prcCreaOrdenAdicionalComision';
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbINICIO);
  
    nuContractor_Id := PKG_BCUNIDADOPERATIVA.FNUGETCONTRATISTA(inuOperatinUnit);
  
    IF INSTR(',' || csbLDC_CONTRA_SIN_DIGIT_INDEX || ',',
             ',' || nuContractor_Id || ',') = 0 THEN
    
      sbComment := 'Orden adicional generada automaticamente por el proceso GOPCVNEL. Orden padre: ' ||
                   inuFatherOrder;
    
      pkg_traza.trace('Se ejecuta el servicio para crear la orden adicional para comision.',
                      cnuNivelTraza);
    
      pkg_traza.trace('unidad Operativa: ' || inuOperatinUnit ||
                      ' - Actividad: ' || nuActiviy || ' Id Persona: ' ||
                      inuPersonId || ' Valor Comision: ' ||
                      nuValueComision || ' Tipo Comentario: ' ||
                      nuTypeComment || ' Comentario: ' || sbComment,
                      cnuNivelTraza);
    
      LDC_prRegisterNewCharge(inuOperatinUnit,
                              nuActiviy,
                              inuPersonId,
                              null,
                              nuValueComision,
                              null,
                              null,
                              nuTypeComment,
                              sbComment,
                              onuerrorcode,
                              osberrormessage,
                              onuOrder);
    
      dbms_output.put_line('Paso LDC_prRegisterNewCharge Orden[' ||
                           onuOrder || '] Error: ' || onuerrorcode ||
                           ' - ' || osberrormessage);
    
      pkg_traza.trace('Salida - Codigo Error: ' || osberrormessage ||
                      ' - Mesaje Error: ' || osberrormessage ||
                      ' Orden Creada: ' || onuOrder,
                      cnuNivelTraza);
    
      IF onuerrorcode is not null THEN
      
        pkg_error.setErrorMessage(isbMsgErrr => osberrormessage);
      
      END IF;
    
      OPEN cuFatherOrderData(inuFatherOrder);
      FETCH cuFatherOrderData
        INTO rcDataOrder;
      CLOSE cuFatherOrderData;
    
      pkg_or_order_activity.prcActualizaSolicitudconOrden(onuOrder,
                                                          rcDataOrder.PACKAGE_id);
      pkg_or_order_activity.prcActualizaMotivoconOrden(onuOrder,
                                                       rcDataOrder.Motive_Id);
      pkg_or_order_activity.prcActualizaComponenteconOrden(onuOrder,
                                                           rcDataOrder.component_id);
      pkg_or_order_activity.prcActualizaContratoconOrden(onuOrder,
                                                         rcDataOrder.subscription_id);
      pkg_or_order_activity.prcActualizaProductoconOrden(onuOrder,
                                                         rcDataOrder.product_id);
      pkg_or_order_activity.prcActualizaIdClienteconOrden(onuOrder,
                                                          rcDataOrder.SUBSCRIBER_ID);
    
    ELSE
      pkg_traza.trace('Al contratista [' || nuContractor_Id ||
                      '] no se le genera orden con actividad [' ||
                      nuActiviy || ']',
                      cnuNivelTraza);
    END IF;
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(onuerrorcode, osberrormessage);
      pkg_traza.trace('Error: ' || osberrormessage, cnuNivelTraza);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      rollback;
      pkg_Error.setError;
      pkg_Error.getError(onuerrorcode, osberrormessage);
      pkg_traza.trace('Error: ' || osberrormessage, cnuNivelTraza);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERR);
    
  END prcCreaOrdenAdicionalComision;

  PROCEDURE prcRelacionSolicitudComision(inuOrderItemId IN LDC_PKG_OR_ITEM.order_item_id%TYPE,
                                         inuOrderId     IN LDC_PKG_OR_ITEM.order_id%TYPE,
                                         inuPackageId   IN LDC_PKG_OR_ITEM.package_id%TYPE,
                                         idtDate        IN LDC_PKG_OR_ITEM.fecha%TYPE,
                                         isbObse        IN LDC_PKG_OR_ITEM.observacion%TYPE,
                                         inuCate        IN LDC_PKG_OR_ITEM_DETAIL.category_id%TYPE DEFAULT NULL,
                                         inuSuca        IN LDC_PKG_OR_ITEM_DETAIL.subcategory_id%TYPE DEFAULT NULL,
                                         isbZone        IN LDC_PKG_OR_ITEM_DETAIL.zone_id%TYPE DEFAULT NULL,
                                         idtDateRing    IN LDC_PKG_OR_ITEM_DETAIL.date_ring%TYPE DEFAULT NULL,
                                         inuCommPlan    IN LDC_PKG_OR_ITEM_DETAIL.commercial_plan_id%TYPE DEFAULT NULL,
                                         inuReqSales    IN LDC_PKG_OR_ITEM_DETAIL.req_sales_id%TYPE DEFAULT NULL,
                                         inuLocation    IN LDC_PKG_OR_ITEM_DETAIL.location_id%TYPE DEFAULT NULL,
                                         inuDepa        IN LDC_PKG_OR_ITEM_DETAIL.father_location_id%TYPE DEFAULT NULL,
                                         inuPayDate     IN LDC_PKG_OR_ITEM_DETAIL.pay_date%TYPE DEFAULT NULL,
                                         inuCuponValue  IN LDC_PKG_OR_ITEM_DETAIL.cupon_value%TYPE DEFAULT NULL,
                                         inuActa        IN LDC_PKG_OR_ITEM_DETAIL.id_acta%TYPE DEFAULT NULL) IS
  
    CURSOR cuExiste IS
      SELECT count(1)
        FROM LDC_PKG_OR_ITEM_DETAIL d
       WHERE d.package_id = inuPackageId;
  
    nuExiste NUMBER;
  
    csbMetodo VARCHAR2(70) := 'prcRelacionSolicitudComision'; -- Nombre de este metodo
    nuError   NUMBER; -- se almacena codigo de error
    sbError   VARCHAR2(2000); -- se almacena descripcion del error
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbINICIO);
  
    pkg_ldc_pkg_or_item.prcInsertaRegistro(inuOrderItemId,
                                           inuOrderId,
                                           inuPackageId,
                                           idtDate,
                                           isbObse);
  
    IF inuOrderId IS NOT NULL THEN
      -- Se consulta la informacion adicional y se agrega
      Open cuExiste;
      fetch cuExiste
        INTO nuExiste;
      close cuExiste;
    
      IF nuExiste = 0 THEN
      
        pkg_ldc_pkg_or_item_detail.prcInsertaRegistro(inuPackageId,
                                                      inuOrderId,
                                                      inuCate,
                                                      inuSuca,
                                                      isbZone,
                                                      idtDateRing,
                                                      inuCommPlan,
                                                      inuReqSales,
                                                      inuLocation,
                                                      inuDepa,
                                                      PKG_BCSOLICITUDES.FDTGETFECHAREGISTRO(inuPackageId),
                                                      inuPayDate,
                                                      inuCuponValue,
                                                      inuActa);
      
      END IF;
    END IF;
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, cnuNivelTraza);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      rollback;
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, cnuNivelTraza);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERR);
    
  END prcRelacionSolicitudComision;

  PROCEDURE prcRegistraComentario(isbComentario IN VARCHAR2,
                                  inuOrden      IN OR_order.order_id%type) IS
  
    csbMetodo VARCHAR2(70) := 'prcRegistraComentario';
    nuError   NUMBER; -- se almacena codigo de error
    sbError   VARCHAR2(2000); -- se almacena descripcion del error
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbINICIO);
  
    pkg_or_order_comment.prcInsertaRegistro(isbComentario,
                                            inuOrden,
                                            -1,
                                            SYSDATE,
                                            'N',
                                            NULL);
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN);
  
  EXCEPTION
  
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, cnuNivelTraza);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, cnuNivelTraza);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERR);
    
  END prcRegistraComentario;

  function fnuRetornaValorTarifa(inuPackageId in mo_packages.package_id%type)
    return number is
  
    -----------------------------------
    --Variables
    -----------------------------------
    nuTipoPackage      mo_packages.package_type_id%type;
    dtAttentionDate    mo_packages.ATTENTION_DATE%type;
    nuCateCodi         LDC_COMISION_PLAN_NEL.CATECODI%type;
    nuSucaCodi         LDC_COMISION_PLAN_NEL.SUCACODI%type;
    nuProductId        pr_product.product_id%type;
    nuCommercialPlanId LDC_COMISION_PLAN_NEL.COMMERCIAL_PLAN_ID%type;
    nuLiquidaTarifa    NUMBER := 0;
    nuLiquidaCotiza    NUMBER := 0;
    vaLiquida          VARCHAR2(1) := null;
    nuConvalo          NUMBER;
  
    sbTipoSolicVentaTarifa  ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('TIPO_SOLIC_VENTA_TARIFA');
    sbTipoSolicVentaCotiza  ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('TIPO_SOLIC_VENTA_COTIZA');
    sbCodConcVtaLiqComision ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('COD_CONC_VTA_LIQ_COMISIONES');
  
    -----------------------------------
    --Cursores
    -----------------------------------
    CURSOR CUEXISTETARIFA(NUTIPO mo_packages.package_type_id%type) IS
      SELECT count(1) cantidad
        FROM DUAL
       WHERE NUTIPO IN
             (SELECT to_number(regexp_substr(sbTipoSolicVentaTarifa,
                                             '[^,]+',
                                             1,
                                             LEVEL)) AS column_value
                FROM dual
              CONNECT BY regexp_substr(sbTipoSolicVentaTarifa,
                                       '[^,]+',
                                       1,
                                       LEVEL) IS NOT NULL);
    CURSOR CUEXISTECOTIZA(NUTIPO mo_packages.package_type_id%type) IS
      SELECT count(1) cantidad
        FROM DUAL
       WHERE NUTIPO IN
             (SELECT to_number(regexp_substr(sbTipoSolicVentaCotiza,
                                             '[^,]+',
                                             1,
                                             LEVEL)) AS column_value
                FROM dual
              CONNECT BY regexp_substr(sbTipoSolicVentaCotiza,
                                       '[^,]+',
                                       1,
                                       LEVEL) IS NOT NULL);
    ------------------------------
    -- REQ.200-1689 Stapias -->
    ------------------------------
    --Se cambia cursor, para obtener la ultima tarifa configurada, en caso de que las fechas se cruzen
    cursor cuConceptos(sbComerPlan     in mo_motive.commercial_plan_id%type,
                       dtAttentionDate in TA_VIGETACP.VITPFEIN%type,
                       sbCategory      in LDC_COMISION_PLAN_NEL.CATECODI%type,
                       sbSubcategory   in LDC_COMISION_PLAN_NEL.SUCACODI%type) is
      SELECT nvl(sum(NVL(tv.vitpvalo, 0)), 0)
        FROM TA_VIGETACP tv
       WHERE tv.vitptacp IN
             (SELECT CONS
                FROM (SELECT max(TV.VITPTACP) CONS, CT.COTCCONC CONCE
                        FROM TA_VIGETACP tv, TA_TARICOPR K, TA_CONFTACO CT
                       WHERE tv.vitptacp IN
                             (SELECT tt.tacpcons
                                FROM TA_TARICOPR TT, TA_CONFTACO TC
                               WHERE TT.TACPCOTC = TC.COTCCONS
                                 AND TT.TACPCR01 = sbComerPlan
                                 AND (TT.TACPCR03 = sbCategory OR
                                     TT.TACPCR03 = -1)
                                 AND (TT.TACPCR02 = sbSubcategory OR
                                     TT.TACPCR02 = -1)
                                 AND TC.COTCCONC IN
                                     (SELECT to_number(regexp_substr(sbCodConcVtaLiqComision,
                                                                     '[^,]+',
                                                                     1,
                                                                     LEVEL)) AS column_value
                                        FROM dual
                                      CONNECT BY regexp_substr(sbCodConcVtaLiqComision,
                                                               '[^,]+',
                                                               1,
                                                               LEVEL) IS NOT NULL))
                         and dtAttentionDate between tv.vitpfein and
                             tv.vitpfefi
                         and tv.vitptipo = 'T'
                         AND K.TACPCONS = TV.VITPTACP
                         AND K.TACPCOTC = CT.COTCCONS
                       GROUP BY CT.COTCCONC) A)
         and dtAttentionDate between tv.vitpfein and tv.vitpfefi
         and tv.vitptipo = 'T';
  
    ------------------------------
    -- REQ.200-1689 Stapias <--
    ------------------------------
  
    CURSOR cuVlrItemCoti(nuPackageId in mo_packages.package_id%type) is
      SELECT total_items_value
        FROM CC_QUOTATION
       WHERE STATUS = 'C'
         AND package_id = nuPackageId;
  
    csbMetodo VARCHAR2(70) := 'fnuRetornaValorTarifa'; -- Nombre de este metodo
    nuError   NUMBER; -- se almacena codigo de error
    sbError   VARCHAR2(2000); -- se almacena descripcion del error
  
  begin
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbINICIO);
  
    --Obtener tipo de solicitud
    nuTipoPackage := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_packages',
                                                                     'PACKAGE_ID',
                                                                     'package_type_id',
                                                                     inuPackageId));
    open CUEXISTETARIFA(nuTipoPackage);
    fetch CUEXISTETARIFA
      INTO nuLiquidaTarifa;
    close CUEXISTETARIFA;
    open CUEXISTECOTIZA(nuTipoPackage);
    fetch CUEXISTECOTIZA
      INTO nuLiquidaCotiza;
    close CUEXISTECOTIZA;
    IF (nuLiquidaTarifa > 0) THEN
      vaLiquida := 'T';
    ELSIF (nuLiquidaCotiza > 0) THEN
      vaLiquida := 'C';
    END IF;
    IF (vaLiquida = 'T') THEN
      --Obtener fecha de la solicitud
      dtAttentionDate := PKG_BCSOLICITUDES.FDTGETFECHAREGISTRO(inuPackageId);
      --Obtener Producto
      nuProductId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_motive',
                                                                     'package_id',
                                                                     'product_id',
                                                                     inuPackageId));
      --Categoria
      nuCateCodi := PKG_BCPRODUCTO.FNUCATEGORIA(nuProductId);
      --Subcategoria
      nuSucaCodi := PKG_BCPRODUCTO.FNUSUBCATEGORIA(nuProductId);
      --Obtener plan comercial
      nuCommercialPlanId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_motive',
                                                                            'PACKAGE_ID',
                                                                            'COMMERCIAL_PLAN_ID',
                                                                            inuPackageId));
      open cuConceptos(nuCommercialPlanId,
                       dtAttentionDate,
                       nuCateCodi,
                       nuSucaCodi);
      fetch cuConceptos
        INTO nuConvalo;
      close cuConceptos;
    ELSIF (vaLiquida = 'C') THEN
      open cuVlrItemCoti(inuPackageId);
      fetch cuVlrItemCoti
        INTO nuConvalo;
      close cuVlrItemCoti;
    END IF;
  
    pkg_traza.trace('Valor tarifa: ' || nuConvalo, cnuNivelTraza);
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbINICIO);
  
    return nuConvalo;
  
  EXCEPTION
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, cnuNivelTraza);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERR);
      return 0;
    
  end fnuRetornaValorTarifa;

  function frcRetornaValorComision(isbTime          IN varchar2,
                                   inuPackageId     IN mo_packages.package_id%type,
                                   inuAddressId     IN ab_address.address_id%type,
                                   inuProductid     IN pr_product.product_id%Type,
                                   inuOperatingUnit IN or_operating_unit.operating_unit_id%type)
    return RgCommissionRegister is
    RgReturn           RgCommissionRegister;
    nuContractorId     or_operating_unit.contractor_id%type;
    nuCommissionType   LDC_COMISION_PLAN_NEL.COMISION_PLAN_ID%type;
    nuCommercialPlanId LDC_COMISION_PLAN_NEL.COMMERCIAL_PLAN_ID%type;
    nuGeograpDepto     LDC_COMISION_PLAN_NEL.DEPACODI%TYPE; -- Se agrega caso 200-1487
    nuCateCodi         LDC_COMISION_PLAN_NEL.CATECODI%type;
    nuSucaCodi         LDC_COMISION_PLAN_NEL.SUCACODI%type;
    nuCommissionPlanId LDC_COMISION_PLAN_NEL.COMISION_PLAN_ID%type;
    dtAttentionDate    mo_packages.ATTENTION_DATE%type;
    nuTotalPercent     LDC_COMI_TARIFA_NEL.PORC_TOTAL_COMI%type;
    nuInitialPercent   LDC_COMI_TARIFA_NEL.PORC_ALFINAL%type;
    nuFinalPercent     LDC_COMI_TARIFA_NEL.PORC_ALFINAL%type;
    nuPercent          ldc_info_predio.PORC_PENETRACION%type;
    nuIdPremise        ab_premise.premise_id%type;
    nuTotalValueValue  mo_gas_sale_data.TOTAL_VALUE%type;
    AXnuDepaCodi       LDC_COMISION_PLAN_NEL.DEPACODI%type; -- Se agrega caso 200-1487
    AXnuCateCodi       LDC_COMISION_PLAN_NEL.CATECODI%type;
    AXnuSucaCodi       LDC_COMISION_PLAN_NEL.SUCACODI%type;
    SW                 NUMBER;
    nuGeograpLoca      ge_geogra_location.geograp_location_id%type;
  
    --Cursor para obtener
    cursor cuPlanCommissionId(nuCommissionType   LDC_COMISION_PLAN_NEL.COMISION_PLAN_ID%type,
                              nuCommercialPlanId LDC_COMISION_PLAN_NEL.COMMERCIAL_PLAN_ID%type,
                              sbIsZone           ldc_info_predio.is_zona%type,
                              nuDepaCodi         LDC_COMISION_PLAN_NEL.DEPACODI%type,
                              nuCateCodi         LDC_COMISION_PLAN_NEL.CATECODI%type,
                              nuSucaCodi         LDC_COMISION_PLAN_NEL.SUCACODI%type) is
      select nvl(COMISION_PLAN_ID, 0) PlanCommissionId
        from LDC_COMISION_PLAN_NEL
       where TIPO_COMISION_ID = nuCommissionType
         and IS_ZONA = sbIsZone
         and COMMERCIAL_PLAN_ID = nuCommercialPlanId
         and NVL(DEPACODI, -1) = NVL(nuDepaCodi, -1)
         and NVL(CATECODI, -1) = NVL(nuCateCodi, -1)
         and NVL(SUCACODI, -1) = NVL(nuSucaCodi, -1);
  
    --Cursor para obtener los valores para aplicar en el calculo de la comision al registro
    cursor cuCommission(dtAttentionDate    mo_packages.ATTENTION_DATE%type,
                        nuCommissionPlanId LDC_COMISION_PLAN_NEL.COMISION_PLAN_ID%type) is
      select nvl(PORC_TOTAL_COMI, 0) totalPercent,
             nvl(PORC_ALINICIO, 0) initialPercent,
             nvl(PORC_ALFINAL, 0) finalPercent
        from LDC_COMI_TARIFA_NEL
       where COMISION_PLAN_ID = nuCommissionPlanId
         and dtAttentionDate between FECHA_VIG_INICIAL and FECHA_VIG_FINAL;
  
    --Cursor para obtener el tipo de zona y el porcentaje de cobertura en la zona
    cursor cuZonePercent(nuIdPremise ab_premise.premise_id%type) is
      select IS_ZONA sbZone, nvl(PORC_PENETRACION, 0) nuPercent
        from ldc_info_predio
       where PREMISE_ID = nuIdPremise
         and rownum = 1;
  
    CURSOR cuAplicaSubsidio IS
      SELECT aplicasubsidio
        FROM LDC_SUBSIDIOS
       WHERE PACKAGE_id = inuPackageId;
  
    CURSOR cuApplyCont(inuContratista IN LDC_INFO_OPER_UNIT_NEL.oper_unit_id%TYPE,
                       inuTipoComi    IN LDC_INFO_OPER_UNIT_NEL.tipo_comision_id%TYPE) IS
      SELECT count(1)
        FROM LDC_INFO_OPER_UNIT_NEL
       WHERE operating_unit_id = inuContratista
         AND tipo_comision_id = inuTipoComi
         AND apply_subcidy = 'Y';
  
    sbIsSubcidy LDC_SUBSIDIOS.aplicasubsidio%TYPE;
    nuAppliCont NUMBER;
  
    csbMetodo VARCHAR2(70) := 'frcRetornaValorComision'; -- Nombre de este metodo
    nuError   NUMBER; -- se almacena codigo de error
    sbError   VARCHAR2(2000); -- se almacena descripcion del error
  
  begin
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbINICIO);
  
    RgReturn.onuCommissionValue := 0;
    RgReturn.sbIsZone           := 'X';
    RgReturn.sbIsZoneOri        := 'X';
    --NIVELES DE VALIDAcion
    --POR ZONA -> MERCADO RELEVANTE->CATEGORIA->SUBCATEGORIA->PLAN COMERCIAL
    --COMODINES: zona, subcategoria,plan comercial, rango % covertura, (% o valor) excluyentes
  
    --Obtener id predio
    nuIdPremise := PKG_BCDIRECCIONES.FNUGETPREDIO(inuAddressId);
    pkg_traza.trace('Predio[' || nuIdPremise || ']', cnuNivelTraza);
    if nuIdPremise is null then
      pkg_error.setErrorMessage(isbMsgErrr => 'No existe predio asociado a la direccion ' ||
                                              inuAddressId);
    end if;
  
    --Obtener zona  porcentaje de cobertura para la zona
    open cuZonePercent(nuIdPremise);
    fetch cuZonePercent
      into RgReturn.sbIsZone, nuPercent;
    pkg_traza.trace('Zona[' || RgReturn.sbIsZone || '] - Porcentaje[' ||
                    nuPercent || ']',
                    cnuNivelTraza);
  
    if cuZonePercent%notfound then
      RgReturn.onuCommissionValue := 0;
      RgReturn.sbIsZone           := 'X';
      close cuZonePercent;
      return RgReturn;
    end if;
  
    RgReturn.sbIsZoneOri := RgReturn.sbIsZone;
  
    --Obtener la localidad
    nuGeograpLoca := PKG_BCDIRECCIONES.FNUGETLOCALIDAD(inuAddressId);
    pkg_traza.trace('Localidad[' || nuGeograpLoca || ']', cnuNivelTraza);
  
    --Categoria
    nuCateCodi := PKG_BCPRODUCTO.FNUCATEGORIA(inuProductId);
    pkg_traza.trace('Categoria[' || nuCateCodi || ']', cnuNivelTraza);
  
    --Subcategoria
    nuSucaCodi := PKG_BCPRODUCTO.FNUSUBCATEGORIA(inuProductId);
    pkg_traza.trace('SubCategoria[' || nuSucaCodi || ']', cnuNivelTraza);
  
    --Obtener mercado relevante
    nuGeograpDepto := PKG_BCDIRECCIONES.FNUGETUBICAGEOPADRE(nuGeograpLoca);
    pkg_traza.trace('Departamento[' || nuGeograpDepto || ']',
                    cnuNivelTraza);
  
    --Obtener fecha de la solicitud
    dtAttentionDate := PKG_BCSOLICITUDES.FDTGETFECHAREGISTRO(inuPackageId);
    pkg_traza.trace('Fecha Registro solicitud[' || dtAttentionDate || ']',
                    cnuNivelTraza);
  
    --Obtener plan comercial
    nuCommercialPlanId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_motive',
                                                                          'PACKAGE_ID',
                                                                          'COMMERCIAL_PLAN_ID',
                                                                          inuPackageId));
    pkg_traza.trace('Plan Comercial[' || nuCommercialPlanId || ']',
                    cnuNivelTraza);
    if nuCommercialPlanId is null or nuCommercialPlanId = -1 then
      pkg_error.setErrorMessage(isbMsgErrr => 'No existe un plan comercial asociado a la solicitud de venta ' ||
                                              inuPackageId);
    end if;
  
    --Obtener el contratista de la unidad operativa
    nuContractorId := PKG_BCUNIDADOPERATIVA.FNUGETCONTRATISTA(inuOperatingUnit);
    pkg_traza.trace('Unidad Operativa[' || inuOperatingUnit ||
                    '] - Contratista[' || nuContractorId || ']',
                    cnuNivelTraza);
    if nuContractorId is null or nuContractorId = -1 then
      pkg_error.setErrorMessage(isbMsgErrr => 'La unidad operativa ' ||
                                              inuOperatingUnit ||
                                              ' no esta asociado a una orden de trabajo.');
    end if;
  
    --Obtener tipo de comision para contratista y validar
    --Validar si se realizo la configuracion para el contratista
    nuCommissionType := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('LDC_INFO_OPER_UNIT_NEL',
                                                                        'OPERATING_UNIT_ID',
                                                                        'TIPO_COMISION_ID',
                                                                        nuContractorId));
  
    pkg_traza.trace('Tipo Comision[' || nuCommissionType || ']',
                    cnuNivelTraza);
    if nuCommissionType = -1 or nuCommissionType is null then
      return RgReturn;
    else
    
      -- CA854
      OPEN cuApplyCont(nuContractorId, nuCommissionType);
      FETCH cuApplyCont
        INTO nuAppliCont;
      CLOSE cuApplyCont;
    
      OPEN cuAplicaSubsidio;
      FETCH cuAplicaSubsidio
        INTO sbIsSubcidy;
      CLOSE cuAplicaSubsidio;
      -- Se valida si la venta tiene subsidio, en ese caso se toma como zona nueva
      IF sbIsSubcidy = 'Y' AND nuAppliCont > 0 THEN
        RgReturn.sbIsZoneOri := RgReturn.sbIsZone;
        RgReturn.sbIsZone    := 'N';
      END IF;
      -- CA854
    
      SW           := 0;
      AXnuDepaCodi := nuGeograpDepto;
      AXnuCateCodi := nuCateCodi;
      AXnuSucaCodi := nuSucaCodi;
      LOOP
        BEGIN
          open cuPlanCommissionId(nuCommissionType,
                                  nuCommercialPlanId,
                                  RgReturn.sbIsZone,
                                  AXnuDepaCodi,
                                  AXnuCateCodi,
                                  AXnuSucaCodi);
          fetch cuPlanCommissionId
            into nuCommissionPlanId;
        
          IF cuPlanCommissionId%NOTFOUND THEN
            IF SW = 0 THEN
              AXnuDepaCodi := nuGeograpDepto;
              AXnuCateCodi := nuCateCodi;
              AXnuSucaCodi := NULL;
            ELSIF SW = 1 THEN
              AXnuDepaCodi := NULL;
              AXnuCateCodi := nuCateCodi;
              AXnuSucaCodi := nuSucaCodi;
            ELSIF SW = 2 THEN
              AXnuDepaCodi := nuGeograpDepto;
              AXnuCateCodi := NULL;
              AXnuSucaCodi := NULL;
            ELSIF SW = 3 THEN
              AXnuDepaCodi := NULL;
              AXnuCateCodi := nuCateCodi;
              AXnuSucaCodi := NULL;
            ELSIF SW = 4 THEN
              AXnuDepaCodi := NULL;
              AXnuCateCodi := NULL;
              AXnuSucaCodi := NULL;
            END IF;
          END IF;
        
        END;
        close cuPlanCommissionId;
        EXIT WHEN nuCommissionPlanId > 0 OR SW = 5;
        SW := SW + 1;
      
      END LOOP;
    
      --Se obtiene el valor que se fijo, por porcentaje o por valor fijo
      --AL INICIO O AL FINAL segun sea el caso=> se debe modificar el cursor
      open cuCommission(dtAttentionDate, nuCommissionPlanId);
      fetch cuCommission
        into nuTotalPercent, nuInitialPercent, nuFinalPercent;
      close cuCommission;
      if nuTotalPercent = 0 then
        if isbTime = 'B' then
          RgReturn.onuCommissionValue := 0;
        else
          if isbTime = 'L' then
            RgReturn.onuCommissionValue := 0;
          end if;
        end if;
        return RgReturn;
      else
      
        nuTotalValueValue := fnuRetornaValorTarifa(inuPackageId);
        pkg_traza.trace('Tipo[' || isbTime || '] - Total Porcentaje[' ||
                        nuTotalPercent || '] - Procentaje Inicial[' ||
                        nuInitialPercent || '] - Valor Total Tarifa[' ||
                        nuTotalValueValue || ']',
                        cnuNivelTraza);
      
        if isbTime = 'B' then
          RgReturn.onuCommissionValue := ((nuTotalPercent / 100) *
                                         (nuInitialPercent / 100)) *
                                         nuTotalValueValue;
          pkg_traza.trace('Porcentaje al Inicio[' ||
                          RgReturn.onuCommissionValue || ']',
                          cnuNivelTraza);
        else
          if isbTime = 'L' then
            RgReturn.onuCommissionValue := ((nuTotalPercent / 100) *
                                           (nuFinalPercent / 100)) *
                                           nuTotalValueValue;
            pkg_traza.trace('Porcentaje al Final[' ||
                            RgReturn.onuCommissionValue || ']',
                            cnuNivelTraza);
          end if;
        end if;
        return RgReturn;
      end if;
    end if;
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN);
  
    return RgReturn;
  
  exception
    WHEN pkg_Error.Controlled_Error THEN
      rollback;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, cnuNivelTraza);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    WHEN others then
      rollback;
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, cnuNivelTraza);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
    
  end frcRetornaValorComision;

  PROCEDURE prcRegistraExcepcion(inuPackageId IN LDC_PKG_OR_ITEM.package_id%TYPE) IS
  
    csbMetodo VARCHAR2(70) := 'prcRegistraExcepcion'; -- Nombre de este metodo
    nuError   NUMBER; -- se almacena codigo de error
    sbError   VARCHAR2(2000); -- se almacena descripcion del error
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbINICIO);
  
    pkg_ldc_vent_exc_comision.prcInsertaRegistro(inuPackageId,
                                                 'E',
                                                 LDC_BOCONSGENERALES.FDTGETSYSDATE,
                                                 NULL);
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, cnuNivelTraza);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERC);
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, cnuNivelTraza);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERR);
    
  END prcRegistraExcepcion;

  PROCEDURE prcActualizaEstadoSolicitud(inuPackageId IN LDC_PKG_OR_ITEM.package_id%TYPE) IS
  
    csbMetodo VARCHAR2(70) := 'prcActualizaEstadoSolicitud';
    nuError   number;
    sbError   varchar2(4000);
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbINICIO);
  
    pkg_ldc_vent_exc_comision.prcActualizaEstado(inuPackageId, 'P');
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, cnuNivelTraza);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_error.setError;
      pkg_error.geterror(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, cnuNivelTraza);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERR);
    
  END prcActualizaEstadoSolicitud;

begin

  /*
  ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);
  */

  pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbINICIO);

  pkg_estaproc.prinsertaestaproc(sbProcesoInterno, inuTotalRegistros);

  pkg_traza.trace('prcRegistraLogComision(' || inusesion || ',' ||
                  idtToday || ',' || inuNroHilo || ',' || 1 ||
                  ',Inicia Hilo: ' || inuNroHilo,
                  cnuNivelTraza);

  --Buscar solicitudes de venta en estado "13 - Registrada" enun rango de fecha
  --Para cada solicitud, validar si ya se le genero una OT cerrada para el pago de la comision, si no, entonces generar OT y generar
  nucantiregcom := 0;
  nucantiregtot := 0;
  nucontareg    := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CANTIDAD_REG_GUARDAR');
  nugrabados    := 0;
  for pkg in cuPackages(idtCorte, idtBegin, isbPackagesType) loop
  
    nuContadorTotal    := nuContadorTotal + 1;
    nuOrderAdd         := NULL;
    onuErrorCodeAdd    := NULL;
    osbErrorMessageAdd := NULL;
    BEGIN
      pkg_traza.trace('Procesando solicitud: ' || pkg.id || ' (Hilo ' ||
                      inuNroHilo || ')',
                      cnuNivelTraza);
    
      nuBan       := 0;
      sbZonaTAbla := null;
      inuActivity := null;
      inuOrderId  := null;
      --Obtener unidad de trabajo o contratista para consultar en CTCVE
      nuSalesmanId := PKG_BCSOLICITUDES.FNUGETPERSONA(pkg.id);
      pkg_traza.trace('Unidad Operativa o Contratista para consultar en CTCVE: ' ||
                      nuSalesmanId,
                      cnuNivelTraza);
    
      sbDOCUMENT_KEY := PKG_BCSOLICITUDES.FNUGETDOCUMENTO(pkg.id);
      pkg_traza.trace('Documento Solicitud: ' || sbDOCUMENT_KEY,
                      cnuNivelTraza);
    
      if nuSalesmanId is null then
        pkg_error.setErrorMessage(isbMsgErrr => 'No existe un vendedor asociado a la solicitud de venta ' ||
                                                pkg.id);
      end if;
      inuPersonId := nuSalesmanId;
    
      --Obtener la unidad asociada al punto de venta
      nuOperatingUnitId := PKG_BCSOLICITUDES.FNUGETPUNTOVENTA(pkg.id);
      pkg_traza.trace('Unidad operativa: ' || nuOperatingUnitId,
                      cnuNivelTraza);
    
      if nuOperatingUnitId is null then
        pkg_error.setErrorMessage(isbMsgErrr => 'El Solicitud ' || pkg.id ||
                                                ' no esta asociado a una unidad de trabajo.');
      end if;
    
      --Obtener el tipo de unidad operativa asociada a la solicitud de venta
      sbES_externa := PKG_BCUNIDADOPERATIVA.FSBGETESEXTERNA(nuOperatingUnitId);
      pkg_traza.trace('Es una Unidad Operativa Externa: ' || sbES_externa,
                      cnuNivelTraza);
    
      --contrato vigente del contratista de la unidad operativa
      nuExisteContratoVigente := fnuContratoVigente(nuOperatingUnitId);
      pkg_traza.trace('Cantidad de contrato vigentes: ' ||
                      nuExisteContratoVigente,
                      cnuNivelTraza);
    
      --Validar si la unidad operativa es externa y tiene contrato vigente
      dbms_output.put_line('if sbES_externa[' || sbES_externa ||
                           '] = ''Y'' and nuExisteContratoVigente[' ||
                           nuExisteContratoVigente || '] > 0 then');
      if sbES_externa = 'Y' and nuExisteContratoVigente > 0 then
      
        nuContraId := nvl(PKG_BCUNIDADOPERATIVA.FNUGETCONTRATISTA(nuOperatingUnitId),
                          0);
        pkg_traza.trace('Contrato: ' || nuContraId, cnuNivelTraza);
      
        nuCommiType := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('LDC_INFO_OPER_UNIT_NEL',
                                                                       'OPERATING_UNIT_ID',
                                                                       'TIPO_COMISION_ID',
                                                                       nuContraId));
      
        --Obener la direccion del producto
        nuAdressId := PKG_BCSOLICITUDES.FNUGETDIRECCION(pkg.id);
        pkg_traza.trace('Codigo Direccion: ' || nuAdressId, cnuNivelTraza);
      
        --Producto
        nuProductId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_motive',
                                                                       'package_id',
                                                                       'product_id',
                                                                       pkg.id));
        pkg_traza.trace('Producto: ' || nuProductId, cnuNivelTraza);
      
        --Categoria
        nuCateCodi := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_motive',
                                                                      'PACKAGE_ID',
                                                                      'CATEGORY_ID',
                                                                      pkg.id));
        pkg_traza.trace('Categoria: ' || nuCateCodi, cnuNivelTraza);
      
        nuSucate := nvl(PKG_BCPRODUCTO.FNUSUBCATEGORIA(nuProductId), 0);
        pkg_traza.trace('SubCategoria: ' || nuSucate, cnuNivelTraza);
      
        nuCommerPlan := nvl(PKG_BCPRODUCTO.FNUTRAERCOMMERCIALPLANID(nuProductId),
                            0);
        pkg_traza.trace('Plan Comercial: ' || nuCommerPlan, cnuNivelTraza);
      
        OPEN cuCupon(pkg.id);
        FETCH cuCupon
          INTO nuCupon, nuCupoVal, dtCuponDate;
        CLOSE cuCupon;
      
        --Obtener la localidad
        nuGeograpLoca := PKG_BCDIRECCIONES.FNUGETLOCALIDAD(nuAdressId);
        pkg_traza.trace('Localidad: ' || nuGeograpLoca, cnuNivelTraza);
      
        --Obtener el Depto
        nuGeograpDepto := PKG_BCDIRECCIONES.FNUGETUBICAGEOPADRE(nuGeograpLoca);
        pkg_traza.trace('Departamento: ' || nuGeograpDepto, cnuNivelTraza);
      
        --Obtener el segmento de la direccion del producto
        nuSegmentId := PKG_BCDIRECCIONES.FNUGETSEGMENTO_ID(nuAdressId);
        pkg_traza.trace('Segmento: ' || nuSegmentId, cnuNivelTraza);
      
        --Obtener el sector operativo del segmento
        open cuSectorOperativo(nuSegmentId);
        fetch cuSectorOperativo
          into nuOperatingSectorId;
        close cuSectorOperativo;
        pkg_traza.trace('Sector Operativo: ' || nuOperatingSectorId,
                        cnuNivelTraza);
      
        OPEN cuInfoPremise(nvl(PKG_BCDIRECCIONES.FNUGETPREDIO(nuAdressId),
                               0));
        FETCH cuInfoPremise
          INTO dtFechaRing;
        CLOSE cuInfoPremise;
        pkg_traza.trace('Fecha Anillado: ' || dtFechaRing, cnuNivelTraza);
      
        --Obtener la zona del sector operativo asociado a la direccion del producto
        open cuZonaOperativa(nuOperatingSectorId);
        fetch cuZonaOperativa
          into nuZoneIdProduct;
        close cuZonaOperativa;
        pkg_traza.trace('Zona Operativa del Sector Operativo: ' ||
                        nuZoneIdProduct,
                        cnuNivelTraza);
      
        --Obtener el tipo de asignacion de la unidad operativa
        sbAssignType := PKG_BCUNIDADOPERATIVA.FSBGETTIPOASIGNACION(nuOperatingUnitId);
        pkg_traza.trace('Tipo Asignacion de Unidad Operativa: ' ||
                        sbAssignType,
                        cnuNivelTraza);
      
        ----INICIO ARANDA 3224 PARTE 1
        IF nuSegmentId IS NOT NULL THEN
          --VALIDACION DEL SEGMENTO DE LA DIRECCION DEL PRODUCTO
          IF nuGeograpLoca IS NOT NULL THEN
            --VALIDACION DE LA LOCALIDAD
            ----FIN CONTROL VALIDACION DE DATA PARTE 1
          
            --Validar si la unidad operativa es externa y tiene contrato vigente
            dbms_output.put_line('if sbAssignType[' || sbAssignType ||
                                 '] IN (''C'', ''N'') then');
          
            --Validar si el tipo de asignacion es por DEMANDA  : C => Obtener sectores de la Zona asociada a la Base Operativa de la UT
            if sbAssignType IN ('C', 'N') then
              pkg_traza.trace('Tipo Asignacion C o N', cnuNivelTraza);
            
              nuBaseId := PKG_BCUNIDADOPERATIVA.FNUGETBASEADMINISTRATIVA(nuOperatingUnitId);
              pkg_traza.trace('Base Administrativa: ' || nuBaseId,
                              cnuNivelTraza);
            
              open cuOperatingSector(nuBaseId, nuOperatingSectorId);
              fetch cuOperatingSector
                into nuOperatingSectorIdAux;
              close cuOperatingSector;
              --Si el tipo de asignacion es por CAPACIDAD : S => Obtener sectores de la Zona asociada a la UT
            elsif sbAssignType = 'S' then
              pkg_traza.trace('Tipo Asignacion S', cnuNivelTraza);
              nuZoneId := PKG_BCUNIDADOPERATIVA.FNUGETZONAOPERATIVA(nuOperatingUnitId);
              pkg_traza.trace('Zona: ' || nuZoneId, cnuNivelTraza);
            
              nuOperatingSectorIdAux := to_number(LDC_BOUTILITIES.fsbgetvalorcampostabla('ge_sectorope_zona',
                                                                                         'id_zona_operativa',
                                                                                         'id_sector_operativo',
                                                                                         nuZoneId,
                                                                                         'id_sector_operativo',
                                                                                         nuOperatingSectorId));
            end if;
          
            dbms_output.put_line('Cantidad para establecer multa o comision (nuOperatingSectorIdAux) --> ' ||
                                 nuOperatingSectorIdAux);
          
            --Validar si se registra multa o comision
            dbms_output.put_line('if nuOperatingSectorIdAux[' ||
                                 nuOperatingSectorIdAux ||
                                 '] = 0 or nuOperatingSectorIdAux[' ||
                                 nuOperatingSectorIdAux || '] = -1 then');
            if nuOperatingSectorIdAux = 0 or nuOperatingSectorIdAux = -1 then
            
              pkg_traza.trace('Crera Multa', cnuNivelTraza);
            
              --Validar si la categoria del producto es residencial
              if nuCateCodi =
                 pkg_bcld_parameter.fnuobtienevalornumerico('RESIDEN_CATEGORY') then
                --Definir item de novedad y tipo de trabajo para multar
                nuTaskTypeId := pkg_bcld_parameter.fnuobtienevalornumerico('ID_TT_MULTA_RESID');
                inuActivity  := pkg_bcld_parameter.fnuobtienevalornumerico('ID_MULTA_VENTA_OTRA_ZONA_RESID');
              end if;
              --Validar si la categoria del producto es residencial
              if nuCateCodi =
                 pkg_bcld_parameter.fnuobtienevalornumerico('COMMERCIAL_CATEGORY') then
                nuTaskTypeId := pkg_bcld_parameter.fnuobtienevalornumerico('ID_TT_MULTA_COMME');
                inuActivity  := pkg_bcld_parameter.fnuobtienevalornumerico('ID_MULTA_VENTA_OTRA_ZONA_COMM');
              end if;
            
              pkg_traza.trace('Tipo de Trabajo: ' || nuTaskTypeId ||
                              ' - Activdad: ' || inuActivity,
                              cnuNivelTraza);
            
              --Obtener el valor de la multa de LDC_ALT de acuerdo a la configuracion realizada
              PROCVALRANGOTIEMPLEGOT(null,
                                     null,
                                     nuGeograpDepto,
                                     null,
                                     nuTaskTypeId,
                                     null,
                                     null,
                                     nuDays,
                                     nuPercent,
                                     nuValue,
                                     nuNDays);
              pkg_traza.trace('Obtener el valor de la multa: ' || nuValue ||
                              ' por numero dias: ' || nuNDays,
                              cnuNivelTraza);
            
              --Si existe configuracion
              if nuValue is not null and nuValue > 0 then
                pkg_traza.trace('Validando si ya existe multa',
                                cnuNivelTraza);
              
                --Validar si ya existe MULTA
                nuCount := 0;
                open cuExisteMulta(pkg.id);
                fetch cuExisteMulta
                  into nuCount;
                close cuExisteMulta;
              
                pkg_traza.trace('Cantidad de multas: ' || nuCount,
                                cnuNivelTraza);
              
                if nuCount = 0 or nuCount is null then
                  pkg_traza.trace('No Existe multa, Se procede a registrar multa',
                                  cnuNivelTraza);
                  --Registrar multa
                  isbObservation := 'MULTA GENERADA DESDE PROCESO AUTOMATICO' ||
                                    ' - No.Documento:' || sbDOCUMENT_KEY ||
                                    ' - No. Solicitud:' || pkg.id;
                  pkg_traza.trace(isbObservation, cnuNivelTraza);
                
                  ---api de open para crear novedades orden cerrada
                  LDC_prRegisterNewCharge(nuOperatingUnitId,
                                          inuActivity,
                                          inuPersonId,
                                          null,
                                          nuValue,
                                          null,
                                          null,
                                          pkg_bcld_parameter.fnuobtienevalornumerico('ID_TIPO_OBS_COMISION_VENTA'),
                                          isbObservation,
                                          onuErrorCode,
                                          osbErrorMessage,
                                          inuOrderId);
                  nugrabados := nugrabados + 1;
                  if mod(nugrabados, nucontareg) = 0 then
                    pkg_traza.trace('prcRegistraLogComision(' || inusesion || ',' ||
                                    idtToday || ',' || inuNroHilo || ',' || 0 ||
                                    ',Ha Generado hasta ahora: ' ||
                                    nugrabados ||
                                    ' Ultima Orden generada: ' ||
                                    inuOrderId,
                                    cnuNivelTraza);
                  end if;
                  pkg_traza.trace('onuErrorCode --> ' || onuErrorCode ||
                                  ' osbErrorMessage' || osbErrorMessage ||
                                  ' sbActivoOrdAdd: ' || sbActivoOrdAdd ||
                                  ' TT: ' || nvl(PKG_BCORDENES.FNUOBTIENETIPOTRABAJO(inuOrderId),
                                                 0) ||
                                  ' sbTaskTypeOrdAdd: ' ||
                                  sbTaskTypeOrdAdd,
                                  cnuNivelTraza);
                
                  -- CA434 Se valida si la orden se genero con exito y si se debe crear la orden adicional
                  IF (onuErrorCode = 0 OR onuErrorCode IS NULL) AND
                     sbActivoOrdAdd = 'S' THEN
                    -- Se valida si el tipo de trabajo aplica
                    IF INSTR(',' || sbTaskTypeOrdAdd || ',',
                             ',' || nvl(PKG_BCORDENES.FNUOBTIENETIPOTRABAJO(inuOrderId),
                                        0) || ',') > 0 THEN
                      -- Se invoca al procedimiento para crear la orden adicional
                      prcCreaOrdenAdicionalComision(inuOrderId,
                                                    pkg.id,
                                                    nuOperatingUnitId,
                                                    inuPersonId,
                                                    onuErrorCodeAdd,
                                                    osbErrorMessageAdd,
                                                    nuOrderAdd);
                    
                      if nvl(onuErrorCodeAdd, 0) <> 0 then
                        pkg_traza.trace('prcRegistraLogComision(' ||
                                        inusesion || ',' || idtToday || ',' ||
                                        inuNroHilo || ',' || 1 || ',' ||
                                        osbErrorMessageAdd,
                                        cnuNivelTraza);
                      end if;
                    
                    END IF;
                  
                  END IF; -- Fin CA434
                  pkg_traza.trace('Error: ' || onuErrorCode ||
                                  ' - Mensaje: ' || osbErrorMessage,
                                  cnuNivelTraza);
                  if (onuErrorCode <> 0) then
                  
                    pkg_traza.trace('NO SE GENERO NOVEDAD DE MULTA',
                                    cnuNivelTraza);
                  
                    --persistencia para no generar pago de comisiones en ejecuciones futuras
                    rgData.order_item_id := null;
                    rgData.order_id      := null;
                    rgData.package_id    := pkg.id;
                    rgData.FECHA         := pkg_bcld_parameter.fsbobtienevalorcadena('FECHA_COM_REG_VENTA');
                    rgData.OBSERVACION   := 'NO SE GENERO NOVEDAD DE MULTA';
                  
                    pkg_traza.trace('Item Orden: ' || rgData.order_item_id,
                                    cnuNivelTraza);
                    pkg_traza.trace('Orden: ' || rgData.order_id,
                                    cnuNivelTraza);
                    pkg_traza.trace('Solicitud: ' || rgData.package_id,
                                    cnuNivelTraza);
                    pkg_traza.trace('Fecha: ' || rgData.FECHA,
                                    cnuNivelTraza);
                    pkg_traza.trace('Observacion: ' || rgData.OBSERVACION,
                                    cnuNivelTraza);
                    pkg_traza.trace('Categoria: ' || nuCateCodi,
                                    cnuNivelTraza);
                    pkg_traza.trace('SubCategoria: ' || nuSucate,
                                    cnuNivelTraza);
                    pkg_traza.trace('Zona: ' || nuZoneIdProduct,
                                    cnuNivelTraza);
                    pkg_traza.trace('Fecha de Anillado: ' || dtFechaRing,
                                    cnuNivelTraza);
                    pkg_traza.trace('Plan Comercial: ' || nuCommerPlan,
                                    cnuNivelTraza);
                    pkg_traza.trace('Solicitud Venta: ' ||
                                    rgData.package_id,
                                    cnuNivelTraza);
                    pkg_traza.trace('Localidad: ' || nuGeograpLoca,
                                    cnuNivelTraza);
                    pkg_traza.trace('Departamento: ' || nuGeograpDepto,
                                    cnuNivelTraza);
                    pkg_traza.trace('Fecha Cupon: ' || dtCuponDate,
                                    cnuNivelTraza);
                    pkg_traza.trace('Valor Cupon: ' || nuCupoVal,
                                    cnuNivelTraza);
                  
                    prcRelacionSolicitudComision(rgData.order_item_id,
                                                 rgData.order_id,
                                                 rgData.package_id,
                                                 rgData.FECHA,
                                                 rgData.OBSERVACION,
                                                 nuCateCodi,
                                                 nuSucate,
                                                 nuZoneIdProduct,
                                                 dtFechaRing,
                                                 nuCommerPlan,
                                                 rgData.package_id,
                                                 nuGeograpLoca,
                                                 nuGeograpDepto,
                                                 dtCuponDate,
                                                 nuCupoVal);
                  
                  else
                  
                    prcRegistraComentario('GOPCVNEL: Orden Padre: ' ||
                                          inuOrderId || ' Orden Hija: ' ||
                                          nuOrderAdd,
                                          inuOrderId);
                  
                    nuActivityId := ldc_bcfinanceot.fnuGetActivityId(inuOrderId);
                    pkg_traza.trace('Orden Actividad: ' || nuActivityId,
                                    cnuNivelTraza);
                  
                    --Actualizar Direccion de la Actividad de la orden
                    pkg_or_order_activity.prcActualizaDireccConActividad(nuActivityId,
                                                                         nuAdressId);
                  
                    --Aranda 3275
                    --Actualiza direccion de la orden
                    PKG_OR_ORDER.PRCACTUALIZADIRECCIONORDEN(inuOrderId,
                                                            nuAdressId,
                                                            nuErrorCode,
                                                            sbMensError);
                    --Actualiza Localidad de la orden
                    PKG_OR_ORDER.prcActualizaLocalidad(inuOrderId,
                                                       nuGeograpLoca);
                    --Actualiza Sector Operativo de la orden
                    PKG_OR_ORDER.PRCACTUALIZASECTOROPERATIVO(inuOrderId,
                                                             nuOperatingSectorId,
                                                             nuErrorCode,
                                                             sbMensError);
                  
                    --Actualiza Sector Opeartivo de la Actividad de la orden
                    pkg_or_order_activity.prcActualizaSecOpeActividad(nuActivityId,
                                                                      nuOperatingSectorId);
                  
                    --Actualiza Direccion Externa de la orden
                    pkg_or_extern_systems_id.prcactualizaDireccExterna(inuOrderId,
                                                                       nuAdressId,
                                                                       nuErrorCode,
                                                                       sbMensError);
                    --Fin Aranda 3275
                  
                    --Actualizacion de campos orden adicional CA434
                  
                    IF nuOrderAdd IS NOT NULL THEN
                    
                      prcRegistraComentario('GOPCVNEL: Orden Padre: ' ||
                                            inuOrderId || ' Orden Hija: ' ||
                                            nuOrderAdd,
                                            nuOrderAdd);
                    
                      nuActivityIdAdd := ldc_bcfinanceot.fnuGetActivityId(nuOrderAdd);
                    
                      --Actualiza Direccion de la Actividad de la orden adicional
                      pkg_or_order_activity.prcActualizaDireccConActividad(nuActivityIdAdd,
                                                                           nuAdressId);
                    
                      --Actualiza Direccion externa de la orden adicional
                      PKG_OR_ORDER.PRCACTUALIZADIRECCIONORDEN(nuOrderAdd,
                                                              nuAdressId,
                                                              nuErrorCode,
                                                              sbMensError);
                      --Actualiza Localidad de la orden adicional
                      PKG_OR_ORDER.prcActualizaLocalidad(nuOrderAdd,
                                                         nuGeograpLoca);
                      --Actualiza Sector Operativo de la orden adicional
                      PKG_OR_ORDER.PRCACTUALIZASECTOROPERATIVO(nuOrderAdd,
                                                               nuOperatingSectorId,
                                                               nuErrorCode,
                                                               sbMensError);
                    
                      --Actualiza Sector Operativo de la orden adicional
                      pkg_or_order_activity.prcActualizaSecOpeActividad(nuActivityIdAdd,
                                                                        nuOperatingSectorId);
                    
                      --Actualiza direccion externa de la orden adicional
                      pkg_or_extern_systems_id.prcactualizaDireccExterna(nuOrderAdd,
                                                                         nuAdressId,
                                                                         nuErrorCode,
                                                                         sbMensError);
                    
                      ---Establecer relacion con la ot comision y la ot adicional
                      api_related_order(inuOrderId,
                                        nuOrderAdd,
                                        nuErrorCode,
                                        sbMensError);
                    
                      -- CA854
                      nuOperUnit := nvl(PKG_BCORDENES.FNUOBTIENEUNIDADOPERATIVA(inuOrderId),
                                        0);
                    
                      nuPersonId := nvl(PKG_BCORDENES.FNUOBTENERPERSONA(inuOrderId),
                                        0);
                    
                      --Actualiza Id persona relacionada a la orden adicional
                      pkg_or_order_person.prcActualizaIdPersona(nuOrderAdd,
                                                                nuPersonId);
                    
                      -- Fin CA854
                    
                    END IF;
                    --Fin Actualizacion de campos orden adicional CA434
                  
                    sbItemDecripcion := null;
                    open cuItem(inuActivity);
                    fetch cuItem
                      into sbItemDecripcion;
                    close cuItem;
                  
                    --Fin seccion 07-11-2013
                    SBobservacion := 'SE GENERO NOVEDAD DE MULTA ' ||
                                     inuActivity || ' - ' ||
                                     sbItemDecripcion;
                    nuBan         := 1;
                    sbZonaTAbla   := null;
                  end if;
                end if;
              else
                --persistencia para no generar pago de comisiones en ejecuciones futuras
                pkg_traza.trace('Ya existe multa, persistencia para no generar pago de comisiones en ejecuciones futuras',
                                cnuNivelTraza);
              
                rgData.order_item_id := null;
                rgData.order_id      := null;
                rgData.package_id    := pkg.id;
                rgData.FECHA         := pkg_bcld_parameter.fsbobtienevalorcadena('FECHA_COM_REG_VENTA');
                rgData.OBSERVACION   := 'NO SE ENCONTRARON CONDICIONES PARA GENERACION DE MULTA';
              
                pkg_traza.trace('Item Orden: ' || rgData.order_item_id,
                                cnuNivelTraza);
                pkg_traza.trace('Orden: ' || rgData.order_id,
                                cnuNivelTraza);
                pkg_traza.trace('Solicitud: ' || rgData.package_id,
                                cnuNivelTraza);
                pkg_traza.trace('Fecha: ' || rgData.FECHA, cnuNivelTraza);
                pkg_traza.trace('Observacion: ' || rgData.OBSERVACION,
                                cnuNivelTraza);
                pkg_traza.trace('Categoria: ' || nuCateCodi, cnuNivelTraza);
                pkg_traza.trace('SubCategoria: ' || nuSucate,
                                cnuNivelTraza);
                pkg_traza.trace('Zona: NULL', cnuNivelTraza);
                pkg_traza.trace('Fecha de Anillado: ' || dtFechaRing,
                                cnuNivelTraza);
                pkg_traza.trace('Plan Comercial: ' || nuCommerPlan,
                                cnuNivelTraza);
                pkg_traza.trace('Solicitud Venta: ' || rgData.package_id,
                                cnuNivelTraza);
                pkg_traza.trace('Localidad: ' || nuGeograpLoca,
                                cnuNivelTraza);
                pkg_traza.trace('Departamento: ' || nuGeograpDepto,
                                cnuNivelTraza);
                pkg_traza.trace('Fecha Cupon: ' || dtCuponDate,
                                cnuNivelTraza);
                pkg_traza.trace('Valor Cupon: ' || nuCupoVal,
                                cnuNivelTraza);
              
                prcRelacionSolicitudComision(rgData.order_item_id,
                                             rgData.order_id,
                                             rgData.package_id,
                                             rgData.FECHA,
                                             rgData.OBSERVACION,
                                             nuCateCodi,
                                             nuSucate,
                                             null,
                                             dtFechaRing,
                                             nuCommerPlan,
                                             rgData.package_id,
                                             nuGeograpLoca,
                                             nuGeograpDepto,
                                             dtCuponDate,
                                             nuCupoVal);
              
              end if;
            else
              dbms_output.put_line('Comision');
            
              --Al generar la novedad,  se debe calcular el valor a pagar (con la funcion -> IN: mo_packages.package_id)
              RgCommission := frcRetornaValorComision(pkg.sbTime,
                                                      pkg.id,
                                                      nuAdressId,
                                                      nuProductId,
                                                      nuOperatingUnitId);
              dbms_output.put_line('Valor comision: ' ||
                                   RgCommission.onuCommissionValue);
            
              if RgCommission.onuCommissionValue > 0 then
              
                pkg_traza.trace('No existe comision asociada, Genera comision',
                                cnuNivelTraza);
                inuOrderId := null;
              
                -- CA854
                dbms_output.put_line('IF MONTHS_BETWEEN(PKG_BCSOLICITUDES.FDTGETFECHAREGISTRO(pkg.id[' ||
                                     pkg.id || ']),
                                  dtFechaRing[' ||
                                     dtFechaRing || '])[' ||
                                     PKG_BCSOLICITUDES.FDTGETFECHAREGISTRO(pkg.id) ||
                                     '] <= nuCantMeses[' || nuCantMeses ||
                                     '] THEN');
                IF MONTHS_BETWEEN(PKG_BCSOLICITUDES.FDTGETFECHAREGISTRO(pkg.id),
                                  dtFechaRing) <= nuCantMeses THEN
                  sbZonaCalc := 'N';
                ELSE
                  sbZonaCalc := 'S';
                END IF;
                dbms_output.put_line('sbZonaCalc: '  || sbZonaCalc);                
              
                pkg_traza.trace('Zona calculada: ' || sbZonaCalc ||
                                ' - Zona Original: ' ||
                                RgCommission.sbIsZoneOri,
                                cnuNivelTraza);
              
                -- Se valida si la zona calculada es diferente a la que ya tiene
                IF nvl(RgCommission.sbIsZoneOri, '-') <> sbZonaCalc THEN
                  -- Se registra la exclusion
                  prcRegistraExcepcion(pkg.id);
                  -- En caso de caer aca, seguir con el siguiente para no liquidar
                  GOTO siguiente;
                
                ELSE
                
                  prcActualizaEstadoSolicitud(pkg.id);
                
                END IF;
              
                -- CA854
                OPEN cuApplyCont(nuContraId, nuCommiType);
                FETCH cuApplyCont
                  INTO nuAppliCont;
                CLOSE cuApplyCont;
              
                OPEN cuAplicaSubsidio(pkg.id);
                FETCH cuAplicaSubsidio
                  INTO sbIsSubcidy;
                IF cuAplicaSubsidio%NOTFOUND THEN
                  sbIsSubcidy := 'N';
                END IF;
                CLOSE cuAplicaSubsidio;
                -- Se valida si la venta tiene subsidio, en ese caso se toma como zona nueva
                IF sbIsSubcidy = 'Y' AND nuAppliCont > 0 THEN
                  RgCommission.sbIsZone := 'N';
                END IF;
                -- CA854
              
                --Validar si la categoria del producto es comercial
                if nuCateCodi =
                   pkg_bcld_parameter.fnuobtienevalornumerico('RESIDEN_CATEGORY') then
                  if RgCommission.sbIsZone = 'N' then
                    if pkg.sbTime = 'B' then
                      inuActivity := pkg_bcld_parameter.fnuobtienevalornumerico('ACT_COMISION_INICIO_VENTA_ZNR');
                    else
                      inuActivity := pkg_bcld_parameter.fnuobtienevalornumerico('ACT_COMISION_LEG_VENTA_ZNR');
                    end if;
                  else
                    if RgCommission.sbIsZone = 'S' then
                      if pkg.sbTime = 'B' then
                        inuActivity := pkg_bcld_parameter.fnuobtienevalornumerico('ACT_COMISION_INICIO_VENTA_ZSR');
                      else
                        inuActivity := pkg_bcld_parameter.fnuobtienevalornumerico('ACT_COMISION_LEG_VENTA_ZSR');
                      end if;
                    end if;
                  end if;
                else
                  --Validar si la categoria del producto es comercial
                  if nuCateCodi =
                     pkg_bcld_parameter.fnuobtienevalornumerico('COMMERCIAL_CATEGORY') then
                    if RgCommission.sbIsZone = 'N' then
                      if pkg.sbTime = 'B' then
                        inuActivity := pkg_bcld_parameter.fnuobtienevalornumerico('ACT_COMISION_INICIO_VENTA_ZNC');
                      else
                        inuActivity := pkg_bcld_parameter.fnuobtienevalornumerico('ACT_COMISION_LEG_VENTA_ZNC');
                      end if;
                    else
                      if RgCommission.sbIsZone = 'S' then
                        if pkg.sbTime = 'B' then
                          inuActivity := pkg_bcld_parameter.fnuobtienevalornumerico('ACT_COMISION_INICIO_VENTA_ZSC');
                        else
                          inuActivity := pkg_bcld_parameter.fnuobtienevalornumerico('ACT_COMISION_LEG_VENTA_ZSC');
                        end if;
                      end if;
                    end if;
                  end if;
                end if;
                pkg_traza.trace('Actividad: ' || inuActivity,
                                cnuNivelTraza);
              
                --API para registrar novedades
                isbObservation := 'COMISION GENERADA DESDE PROCESO AUTOMATICO' ||
                                  ' No.Documento:' || sbDOCUMENT_KEY ||
                                  ' No. Solicitud:' || pkg.id;
                pkg_traza.trace(isbObservation, cnuNivelTraza);
              
                LDC_prRegisterNewCharge(nuOperatingUnitId,
                                        inuActivity,
                                        inuPersonId,
                                        null,
                                        RgCommission.onuCommissionValue,
                                        null,
                                        null,
                                        pkg_bcld_parameter.fnuobtienevalornumerico('ID_TIPO_OBS_COMISION_VENTA'),
                                        isbObservation,
                                        onuErrorCode,
                                        osbErrorMessage,
                                        inuOrderId);
              
                pkg_traza.trace('Error: ' || onuErrorCode ||
                                ' - Mensaje: ' || osbErrorMessage,
                                cnuNivelTraza);
              
                -- CA434 Se valida si la orden se genero con exito y si se debe crear la orden adicional
                IF (onuErrorCode = 0 OR onuErrorCode IS NULL) AND
                   sbActivoOrdAdd = 'S' THEN
                  -- Se valida si el tipo de trabajo aplica
                  IF INSTR(',' || sbTaskTypeOrdAdd || ',',
                           ',' || nvl(PKG_BCORDENES.FNUOBTIENETIPOTRABAJO(inuOrderId),
                                      0) || ',') > 0 THEN
                    -- Se invoca al procedimiento para crear la orden adicional
                    prcCreaOrdenAdicionalComision(inuOrderId,
                                                  pkg.id,
                                                  nuOperatingUnitId,
                                                  inuPersonId,
                                                  onuErrorCodeAdd,
                                                  osbErrorMessageAdd,
                                                  nuOrderAdd);
                  
                    if nvl(onuErrorCodeAdd, 0) <> 0 then
                    
                      pkg_traza.trace('prcRegistraLogComision(' ||
                                      inusesion || ',' || idtToday || ',' ||
                                      inuNroHilo || ',' || 1 || ',' ||
                                      osbErrorMessageAdd,
                                      cnuNivelTraza);
                    
                    end if;
                  
                  END IF;
                
                END IF; -- Fin CA434
              
                --
                if (onuErrorCode <> 0) then
                
                  pkg_traza.trace('NO SE GENERO NOVEDAD DE COMISION',
                                  cnuNivelTraza);
                  --persistencia para no generar pago de comisiones en ejecuciones futuras
                
                  sbItemDecripcion := null;
                  open cuItem(inuActivity);
                  fetch cuItem
                    into sbItemDecripcion;
                  close cuItem;
                
                  rgData.order_item_id := null;
                  rgData.order_id      := null;
                  rgData.package_id    := pkg.id;
                  rgData.FECHA         := pkg_bcld_parameter.fsbobtienevalorcadena('FECHA_COM_REG_VENTA');
                  rgData.OBSERVACION   := 'NO SE GENERO NOVEDAD DE COMISION' ||
                                          inuActivity || ' - ' ||
                                          sbItemDecripcion;
                
                  pkg_traza.trace('Item Orden: ' || rgData.order_item_id,
                                  cnuNivelTraza);
                  pkg_traza.trace('Orden: ' || rgData.order_id,
                                  cnuNivelTraza);
                  pkg_traza.trace('Solicitud: ' || rgData.package_id,
                                  cnuNivelTraza);
                  pkg_traza.trace('Fecha: ' || rgData.FECHA, cnuNivelTraza);
                  pkg_traza.trace('Observacion: ' || rgData.OBSERVACION,
                                  cnuNivelTraza);
                  pkg_traza.trace('Categoria: ' || nuCateCodi,
                                  cnuNivelTraza);
                  pkg_traza.trace('SubCategoria: ' || nuSucate,
                                  cnuNivelTraza);
                  pkg_traza.trace('Zona: ' || RgCommission.sbIsZoneOri,
                                  cnuNivelTraza);
                  pkg_traza.trace('Fecha de Anillado: ' || dtFechaRing,
                                  cnuNivelTraza);
                  pkg_traza.trace('Plan Comercial: ' || nuCommerPlan,
                                  cnuNivelTraza);
                  pkg_traza.trace('Solicitud Venta: ' || rgData.package_id,
                                  cnuNivelTraza);
                  pkg_traza.trace('Localidad: ' || nuGeograpLoca,
                                  cnuNivelTraza);
                  pkg_traza.trace('Departamento: ' || nuGeograpDepto,
                                  cnuNivelTraza);
                  pkg_traza.trace('Fecha Cupon: ' || dtCuponDate,
                                  cnuNivelTraza);
                  pkg_traza.trace('Valor Cupon: ' || nuCupoVal,
                                  cnuNivelTraza);
                
                  prcRelacionSolicitudComision(rgData.order_item_id,
                                               rgData.order_id,
                                               rgData.package_id,
                                               rgData.FECHA,
                                               rgData.OBSERVACION,
                                               nuCateCodi,
                                               nuSucate,
                                               RgCommission.sbIsZoneOri,
                                               dtFechaRing,
                                               nuCommerPlan,
                                               rgData.package_id,
                                               nuGeograpLoca,
                                               nuGeograpDepto,
                                               dtCuponDate,
                                               nuCupoVal);
                
                else
                
                  prcRegistraComentario('GOPCVNEL: Orden Padre: ' ||
                                        inuOrderId || ' Orden Hija: ' ||
                                        nuOrderAdd,
                                        inuOrderId);
                
                  nuActivityId := ldc_bcfinanceot.fnuGetActivityId(inuOrderId);
                  pkg_traza.trace('Actividad de la orden: ' ||
                                  nuActivityId,
                                  cnuNivelTraza);
                
                  pkg_or_order_activity.prcActualizaDireccConActividad(nuActivityId,
                                                                       nuAdressId);
                
                  --Aranda 3275
                  --Actualiza direccion con de la orden
                  PKG_OR_ORDER.PRCACTUALIZADIRECCIONORDEN(inuOrderId,
                                                          nuAdressId,
                                                          nuErrorCode,
                                                          sbMensError);
                  --Actualiza localidad de la orden
                  PKG_OR_ORDER.prcActualizaLocalidad(inuOrderId,
                                                     nuGeograpLoca);
                  ---Actualiza sector Opeartivo de la orden
                  PKG_OR_ORDER.PRCACTUALIZASECTOROPERATIVO(inuOrderId,
                                                           nuOperatingSectorId,
                                                           nuErrorCode,
                                                           sbMensError);
                
                  --Actualiza Sector Operativo de la Actividad de la orden
                  pkg_or_order_activity.prcActualizaSecOpeActividad(nuActivityId,
                                                                    nuOperatingSectorId);
                
                  --Actualiza Direccion externa de la orden
                  pkg_or_extern_systems_id.prcactualizaDireccExterna(inuOrderId,
                                                                     nuAdressId,
                                                                     nuErrorCode,
                                                                     sbMensError);
                
                  --Aranda 3275
                  --Fin Aranda 3275
                  --Actualizacion de campos orden adicional CA434
                
                  IF nuOrderAdd IS NOT NULL THEN
                  
                    prcRegistraComentario('GOPCVNEL: Orden Padre: ' ||
                                          inuOrderId || ' Orden Hija: ' ||
                                          nuOrderAdd,
                                          nuOrderAdd);
                  
                    nuActivityIdAdd := ldc_bcfinanceot.fnuGetActivityId(nuOrderAdd);
                  
                    --Actualiza Direccion de la actividad de la orden adicional
                    pkg_or_order_activity.prcActualizaDireccConActividad(nuActivityIdAdd,
                                                                         nuAdressId);
                  
                    --ACtualiza Direccion de la orden adicional
                    PKG_OR_ORDER.PRCACTUALIZADIRECCIONORDEN(nuOrderAdd,
                                                            nuAdressId,
                                                            nuErrorCode,
                                                            sbMensError);
                    --Actualiza localidad de la orden adicional
                    PKG_OR_ORDER.prcActualizaLocalidad(nuOrderAdd,
                                                       nuGeograpLoca);
                    --Actualiza Sector Operativo de la orden adicional
                    PKG_OR_ORDER.PRCACTUALIZASECTOROPERATIVO(nuOrderAdd,
                                                             nuOperatingSectorId,
                                                             nuErrorCode,
                                                             sbMensError);
                  
                    --Actualiza Sector Operativo de la actividad de la orden adicional
                    pkg_or_order_activity.prcActualizaSecOpeActividad(nuActivityIdAdd,
                                                                      nuOperatingSectorId);
                  
                    ---Establecer relacion con la ot comision y la ot adicional
                    api_related_order(inuOrderId,
                                      nuOrderAdd,
                                      nuErrorCode,
                                      sbMensError);
                  
                    --Actualiza direccion externa de la orden adicional
                    pkg_or_extern_systems_id.prcactualizaDireccExterna(nuOrderAdd,
                                                                       nuAdressId,
                                                                       nuErrorCode,
                                                                       sbMensError);
                  
                    -- CA854
                    nuOperUnit := nvl(PKG_BCORDENES.FNUOBTIENEUNIDADOPERATIVA(inuOrderId),
                                      0);
                  
                    nuPersonId := nvl(PKG_BCORDENES.FNUOBTENERPERSONA(inuOrderId),
                                      0);
                  
                    --Actualiza Id persona relacionada a la orden adicional
                    pkg_or_order_person.prcActualizaIdPersona(nuOrderAdd,
                                                              nuPersonId);
                  
                    -- Fin CA854
                  
                  END IF;
                  --Fin Actualizacion de campos orden adicional CA434
                  sbItemDecripcion := null;
                  open cuItem(inuActivity);
                  fetch cuItem
                    into sbItemDecripcion;
                  close cuItem;
                
                  SBobservacion := 'SE GENERO NOVEDAD DE COMISION ' ||
                                   inuActivity || ' - ' || sbItemDecripcion;
                  pkg_traza.trace(SBobservacion, cnuNivelTraza);
                
                  nuBan       := 1;
                  sbZonaTAbla := RgCommission.sbIsZone;
                end if;
              else
                dbms_output.put_line('if nvl(RgCommission.sbIsZone[' ||
                                     RgCommission.sbIsZone ||
                                     '], ''X'') = ''X'' then');
              
                if nvl(RgCommission.sbIsZone, 'X') = 'X' then
                  prcRegistraExcepcion(pkg.id);
                end if;
              
                pkg_traza.trace('Ya existe comision, persistencia para no generar pago de comisiones en ejecuciones futuras',
                                cnuNivelTraza);
              
                --persistencia para no generar pago de comisiones en ejecuciones futuras
                rgData.order_item_id := null;
                rgData.order_id      := null;
                rgData.package_id    := pkg.id;
                rgData.FECHA         := pkg_bcld_parameter.fsbobtienevalorcadena('FECHA_COM_REG_VENTA');
                rgData.OBSERVACION   := 'NO SE ENCONTRARON CONDICIONES PARA PAGO DE COMISION';
              
                pkg_traza.trace('Item Orden: ' || rgData.order_item_id,
                                cnuNivelTraza);
                pkg_traza.trace('Orden: ' || rgData.order_id,
                                cnuNivelTraza);
                pkg_traza.trace('Solicitud: ' || rgData.package_id,
                                cnuNivelTraza);
                pkg_traza.trace('Fecha: ' || rgData.FECHA, cnuNivelTraza);
                pkg_traza.trace('Observacion: ' || rgData.OBSERVACION,
                                cnuNivelTraza);
                pkg_traza.trace('Categoria: ' || nuCateCodi, cnuNivelTraza);
                pkg_traza.trace('SubCategoria: ' || nuSucate,
                                cnuNivelTraza);
                pkg_traza.trace('Zona: ' || RgCommission.sbIsZoneOri,
                                cnuNivelTraza);
                pkg_traza.trace('Fecha de Anillado: ' || dtFechaRing,
                                cnuNivelTraza);
                pkg_traza.trace('Plan Comercial: ' || nuCommerPlan,
                                cnuNivelTraza);
                pkg_traza.trace('Solicitud Venta: ' || rgData.package_id,
                                cnuNivelTraza);
                pkg_traza.trace('Localidad: ' || nuGeograpLoca,
                                cnuNivelTraza);
                pkg_traza.trace('Departamento: ' || nuGeograpDepto,
                                cnuNivelTraza);
                pkg_traza.trace('Fecha Cupon: ' || dtCuponDate,
                                cnuNivelTraza);
                pkg_traza.trace('Valor Cupon: ' || nuCupoVal,
                                cnuNivelTraza);
              
                prcRelacionSolicitudComision(rgData.order_item_id,
                                             rgData.order_id,
                                             rgData.package_id,
                                             rgData.FECHA,
                                             rgData.OBSERVACION,
                                             nuCateCodi,
                                             nuSucate,
                                             RgCommission.sbIsZoneOri,
                                             dtFechaRing,
                                             nuCommerPlan,
                                             rgData.package_id,
                                             nuGeograpLoca,
                                             nuGeograpDepto,
                                             dtCuponDate,
                                             nuCupoVal);
              
              end if;
            end if;
          
            pkg_traza.trace('nuBan --> ' || nuBan, cnuNivelTraza);
          
            if nuBan = 1 then
              pkg_traza.trace('Valida actividad ' || inuActivity,
                              cnuNivelTraza);
              if nvl(inuActivity, 0) > 0 then
                pkg_traza.trace('Persistencia para no generar pago de comisiones en ejecuciones futuras',
                                cnuNivelTraza);
                --persistencia para no generar pago de comisiones en ejecuciones futuras
              
                rgData.order_item_id := inuActivity;
                rgData.order_id      := inuOrderId;
                rgData.package_id    := pkg.id;
                rgData.FECHA         := pkg_bcld_parameter.fsbobtienevalorcadena('FECHA_COM_REG_VENTA');
                rgData.OBSERVACION   := SBobservacion;
              
                pkg_traza.trace('Item Orden: ' || rgData.order_item_id,
                                cnuNivelTraza);
                pkg_traza.trace('Orden: ' || rgData.order_id,
                                cnuNivelTraza);
                pkg_traza.trace('Solicitud: ' || rgData.package_id,
                                cnuNivelTraza);
                pkg_traza.trace('Fecha: ' || rgData.FECHA, cnuNivelTraza);
                pkg_traza.trace('Observacion: ' || rgData.OBSERVACION,
                                cnuNivelTraza);
                pkg_traza.trace('Categoria: ' || nuCateCodi, cnuNivelTraza);
                pkg_traza.trace('SubCategoria: ' || nuSucate,
                                cnuNivelTraza);
                pkg_traza.trace('Zona: ' || sbZonaTAbla, cnuNivelTraza);
                pkg_traza.trace('Fecha de Anillado: ' || dtFechaRing,
                                cnuNivelTraza);
                pkg_traza.trace('Plan Comercial: ' || nuCommerPlan,
                                cnuNivelTraza);
                pkg_traza.trace('Solicitud Venta: ' || rgData.package_id,
                                cnuNivelTraza);
                pkg_traza.trace('Localidad: ' || nuGeograpLoca,
                                cnuNivelTraza);
                pkg_traza.trace('Departamento: ' || nuGeograpDepto,
                                cnuNivelTraza);
                pkg_traza.trace('Fecha Cupon: ' || dtCuponDate,
                                cnuNivelTraza);
                pkg_traza.trace('Valor Cupon: ' || nuCupoVal,
                                cnuNivelTraza);
              
                prcRelacionSolicitudComision(rgData.order_item_id,
                                             rgData.order_id,
                                             rgData.package_id,
                                             rgData.FECHA,
                                             rgData.OBSERVACION,
                                             nuCateCodi,
                                             nuSucate,
                                             sbZonaTAbla,
                                             dtFechaRing,
                                             nuCommerPlan,
                                             rgData.package_id,
                                             nuGeograpLoca,
                                             nuGeograpDepto,
                                             dtCuponDate,
                                             nuCupoVal);
              
              end if;
            end if;
          
            ----INICIO ARANDA 3224 PARTE 2
          ELSE
          
            pkg_traza.trace('LA DIRECCION DE LA VARIABLE nuAdressId NO EXISTE O NO ES VALIDA',
                            cnuNivelTraza);
            --persistencia para no generar pago de comisiones en ejecuciones futuras
          
            rgData.order_item_id := null;
            rgData.order_id      := null;
            rgData.package_id    := pkg.id;
            rgData.FECHA         := pkg_bcld_parameter.fsbobtienevalorcadena('FECHA_COM_REG_VENTA');
            rgData.OBSERVACION   := 'NO EXISTE DIRECCION VALIDA PARA OBTENER LA LOCALIDAD';
          
            pkg_traza.trace('Item Orden: ' || rgData.order_item_id,
                            cnuNivelTraza);
            pkg_traza.trace('Orden: ' || rgData.order_id, cnuNivelTraza);
            pkg_traza.trace('Solicitud: ' || rgData.package_id,
                            cnuNivelTraza);
            pkg_traza.trace('Fecha: ' || rgData.FECHA, cnuNivelTraza);
            pkg_traza.trace('Observacion: ' || rgData.OBSERVACION,
                            cnuNivelTraza);
            pkg_traza.trace('Categoria: ' || nuCateCodi, cnuNivelTraza);
            pkg_traza.trace('SubCategoria: ' || nuSucate, cnuNivelTraza);
            pkg_traza.trace('Zona: ' || nuZoneIdProduct, cnuNivelTraza);
            pkg_traza.trace('Fecha de Anillado: ' || dtFechaRing,
                            cnuNivelTraza);
            pkg_traza.trace('Plan Comercial: ' || nuCommerPlan,
                            cnuNivelTraza);
            pkg_traza.trace('Solicitud Venta: ' || rgData.package_id,
                            cnuNivelTraza);
            pkg_traza.trace('Localidad: ' || nuGeograpLoca, cnuNivelTraza);
            pkg_traza.trace('Departamento: ' || nuGeograpDepto,
                            cnuNivelTraza);
            pkg_traza.trace('Fecha Cupon: ' || dtCuponDate, cnuNivelTraza);
            pkg_traza.trace('Valor Cupon: ' || nuCupoVal, cnuNivelTraza);
          
            prcRelacionSolicitudComision(rgData.order_item_id,
                                         rgData.order_id,
                                         rgData.package_id,
                                         rgData.FECHA,
                                         rgData.OBSERVACION,
                                         nuCateCodi,
                                         nuSucate,
                                         nuZoneIdProduct,
                                         dtFechaRing,
                                         nuCommerPlan,
                                         rgData.package_id,
                                         nuGeograpLoca,
                                         nuGeograpDepto,
                                         dtCuponDate,
                                         nuCupoVal);
          
          END IF; --VALIDACION UBICACION GEOGRAFICA
        ELSE
          pkg_traza.trace('LA DIRECCION DE LA VARIABLE nuAdressId NO EXISTE O NO ES VALIDA',
                          cnuNivelTraza);
          --persistencia para no generar pago de comisiones en ejecuciones futuras
        
          rgData.order_item_id := null;
          rgData.order_id      := null;
          rgData.package_id    := pkg.id;
          rgData.FECHA         := pkg_bcld_parameter.fsbobtienevalorcadena('FECHA_COM_REG_VENTA');
          rgData.OBSERVACION   := 'NO EXISTE SEGMENTO PARA LA DIRECCION';
        
          pkg_traza.trace('Item Orden: ' || rgData.order_item_id,
                          cnuNivelTraza);
          pkg_traza.trace('Orden: ' || rgData.order_id, cnuNivelTraza);
          pkg_traza.trace('Solicitud: ' || rgData.package_id,
                          cnuNivelTraza);
          pkg_traza.trace('Fecha: ' || rgData.FECHA, cnuNivelTraza);
          pkg_traza.trace('Observacion: ' || rgData.OBSERVACION,
                          cnuNivelTraza);
          pkg_traza.trace('Categoria: ' || nuCateCodi, cnuNivelTraza);
          pkg_traza.trace('SubCategoria: ' || nuSucate, cnuNivelTraza);
          pkg_traza.trace('Zona: ' || nuZoneIdProduct, cnuNivelTraza);
          pkg_traza.trace('Fecha de Anillado: ' || dtFechaRing,
                          cnuNivelTraza);
          pkg_traza.trace('Plan Comercial: ' || nuCommerPlan,
                          cnuNivelTraza);
          pkg_traza.trace('Solicitud Venta: ' || rgData.package_id,
                          cnuNivelTraza);
          pkg_traza.trace('Localidad: ' || nuGeograpLoca, cnuNivelTraza);
          pkg_traza.trace('Departamento: ' || nuGeograpDepto,
                          cnuNivelTraza);
          pkg_traza.trace('Fecha Cupon: ' || dtCuponDate, cnuNivelTraza);
          pkg_traza.trace('Valor Cupon: ' || nuCupoVal, cnuNivelTraza);
        
          prcRelacionSolicitudComision(rgData.order_item_id,
                                       rgData.order_id,
                                       rgData.package_id,
                                       rgData.FECHA,
                                       rgData.OBSERVACION,
                                       nuCateCodi,
                                       nuSucate,
                                       nuZoneIdProduct,
                                       dtFechaRing,
                                       nuCommerPlan,
                                       rgData.package_id,
                                       nuGeograpLoca,
                                       nuGeograpDepto,
                                       dtCuponDate,
                                       nuCupoVal);
        
        END IF; --VALIDACION DEL SEGMENTO DE LA DIRECCION DEL PRODUCTO
      
      END IF;
    
    exception
    
      when others then
      
        pkg_traza.trace('ERROR en others ', cnuNivelTraza);
        --persistencia para no generar pago de comisiones en ejecuciones futuras
      
        rgData.order_item_id := null;
        rgData.order_id      := null;
        rgData.package_id    := pkg.id;
        rgData.FECHA         := pkg_bcld_parameter.fsbobtienevalorcadena('FECHA_COM_REG_VENTA');
        rgData.OBSERVACION   := 'ERROR DURANTE LA EJECUCION DEL PROCESO ' ||
                                sqlcode || ' - ' || sqlerrm;
      
        pkg_traza.trace('Item Orden: ' || rgData.order_item_id,
                        cnuNivelTraza);
        pkg_traza.trace('Orden: ' || rgData.order_id, cnuNivelTraza);
        pkg_traza.trace('Solicitud: ' || rgData.package_id, cnuNivelTraza);
        pkg_traza.trace('Fecha: ' || rgData.FECHA, cnuNivelTraza);
        pkg_traza.trace('Observacion: ' || rgData.OBSERVACION,
                        cnuNivelTraza);
        pkg_traza.trace('Categoria: ' || nuCateCodi, cnuNivelTraza);
        pkg_traza.trace('SubCategoria: ' || nuSucate, cnuNivelTraza);
        pkg_traza.trace('Zona: ' || nuZoneIdProduct, cnuNivelTraza);
        pkg_traza.trace('Fecha de Anillado: ' || dtFechaRing,
                        cnuNivelTraza);
        pkg_traza.trace('Plan Comercial: ' || nuCommerPlan, cnuNivelTraza);
        pkg_traza.trace('Solicitud Venta: ' || rgData.package_id,
                        cnuNivelTraza);
        pkg_traza.trace('Localidad: ' || nuGeograpLoca, cnuNivelTraza);
        pkg_traza.trace('Departamento: ' || nuGeograpDepto, cnuNivelTraza);
        pkg_traza.trace('Fecha Cupon: ' || dtCuponDate, cnuNivelTraza);
        pkg_traza.trace('Valor Cupon: ' || nuCupoVal, cnuNivelTraza);
      
        prcRelacionSolicitudComision(rgData.order_item_id,
                                     rgData.order_id,
                                     rgData.package_id,
                                     rgData.FECHA,
                                     rgData.OBSERVACION,
                                     nuCateCodi,
                                     nuSucate,
                                     nuZoneIdProduct,
                                     dtFechaRing,
                                     nuCommerPlan,
                                     rgData.package_id,
                                     nuGeograpLoca,
                                     nuGeograpDepto,
                                     dtCuponDate,
                                     nuCupoVal);
      
    end;
  
    <<siguiente>>
    NULL;
  
    nucantiregcom := nucantiregcom + 1;
    pkg_estaproc.prActualizaAvance(sbProcesoInterno,
                                   'Procesando Solicitud: ' || pkg.id,
                                   nucantiregcom,
                                   inuTotalRegistros);
  
    Rollback;
    --COMMIT;
  
  end loop;
  Rollback;
  --commit;

  pkg_traza.trace('prcRegistraLogComision(' || inusesion || ',' ||
                  idtToday || ',' || inuNroHilo || ',' || 0 ||
                  ',Proceso: ' || nucantiregtot,
                  cnuNivelTraza);
  pkg_traza.trace('prcRegistraLogComision(' || inusesion || ',' ||
                  idtToday || ',' || inuNroHilo || ',' || 0 || ',Genero: ' ||
                  nugrabados,
                  cnuNivelTraza);
  pkg_traza.trace('prcRegistraLogComision(' || inusesion || ',' ||
                  idtToday || ',' || inuNroHilo || ',' || 2 ||
                  ',Termino Hilo: ' || inuNroHilo || ' - Proceso Ok',
                  cnuNivelTraza);

  pkg_estaproc.practualizaestaproc(isbproceso => sbProcesoInterno);

  pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN);

end;
0
0
