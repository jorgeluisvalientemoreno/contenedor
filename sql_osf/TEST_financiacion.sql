DECLARE

  csbSP_NAME  VARCHAR2(70) := '';
  nuErrorCode NUMBER; -- se almacena codigo de error
  sbMensError VARCHAR2(2000); -- se almacena descripcion del error

  PROCEDURE prcFinanciarDuplicado(inuProduct      IN number,
                                  inuSolicitud    IN number,
                                  onuErrorCode    OUT number,
                                  osbErrorMessage OUT VARCHAR2) IS
  
    csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME ||
                                        '.prcFinanciarDuplicado';
  
    nuProduct cargos.cargnuse%type;
  
    nuCupon    cupon.cuponume%type;
    nuSuscripc cupon.cuposusc%type;
  
    sbCampo VARCHAR2(4000);
  
    -- Tipo de dato condiciones de financiacion
    rcSalesFinanCond DACC_Sales_Financ_Cond.styCC_Sales_Financ_Cond;
  
    --PARAMETRO CODIGO PLAN DE FINANCIACION
    NUCOD_PLA_FIN NUMBER := 85;
  
    nuValorCero NUMBER := pkBillConst.CERO;
  
    SUPPORT_DOCUMENT varchar(30);
  
    nuDifeCofi           number;
    onuAcumCuota         number;
    onuSaldo             number;
    onuTotalAcumCapital  number;
    onuTotalAcumCuotExtr number;
    onuTotalAcumInteres  number;
    osbRequiereVisado    varchar2(4000);
  
    numInstalmentsArray number := 1;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbInicio);
  
    pkg_error.prInicializaError(ONUERRORCODE, OSBERRORMESSAGE);
  
    --
    nuProduct := inuProduct;
    sbCampo   := NULL;
    SELECT 'Cuencobr: ' || d.cargcuco
      INTO sbCampo
      FROM OPEN.cargos d
     WHERE d.cargnuse = nuProduct
       AND d.cargdoso = 'PP-' || inuSolicitud
       AND ROWNUM = 1;
    DBMS_OUTPUT.put_line('Cargo: ' || sbCampo);
    ---actualiza el codigo del prodcuto al motivo de la socliitud si no tiene el codigo del prodcuto
  
    update mo_motive mm
       set mm.product_id = nuProduct
     where mm.package_id = inuSolicitud
       and mm.product_id is null;
  
    pkg_traza.trace('Solicitud: ' || inuSolicitud,
                    pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace('Ejecucion servicio CC_BOREQUESTRATING.REQUESTRATINGBYFGCA',
                    pkg_traza.cnuNivelTrzDef);
    CC_BOREQUESTRATING.REQUESTRATINGBYFGCA(inuSolicitud);
  
    pkg_traza.trace('Ejecucion servicio CC_BOACCOUNTS.GENERATEACCOUNTBYPACK',
                    pkg_traza.cnuNivelTrzDef);
    CC_BOACCOUNTS.GENERATEACCOUNTBYPACK(inuSolicitud);
  
    IF 0 = 0 THEN
      SELECT ITEM_WORK_ORDER_ID
        INTO SUPPORT_DOCUMENT
        FROM OPEN.LD_ITEM_WORK_ORDER
       WHERE ORDER_ACTIVITY_ID = 350328613
         AND STATE = 'RE';
    ELSE
      SUPPORT_DOCUMENT := 'SD-' || inuSolicitud;
    END IF;
  
    sbCampo := NULL;
    SELECT 'Cuencobr: ' || d.cargcuco
      INTO sbCampo
      FROM OPEN.cargos d
     WHERE d.cargnuse = nuProduct
       AND d.cargdoso = 'PP-' || inuSolicitud
       AND ROWNUM = 1;
    DBMS_OUTPUT.put_line('Cargo: ' || sbCampo);
  
    DBMS_OUTPUT.put_line('Valor Cero: ' || nuValorCero);
  
    --/*--Actualiza los campos CC_SALES_FINANC_COND
    pkg_traza.trace('Actualiza los campos CC_SALES_FINANC_COND',
                    pkg_traza.cnuNivelTrzDef);
    rcSalesFinanCond.package_id          := inuSolicitud; -- Solicitud
    rcSalesFinanCond.financing_plan_id   := NUCOD_PLA_FIN; -- Plan de financiacion
    rcSalesFinanCond.compute_method_id   := pktblplandife.fnugetpaymentmethod(NUCOD_PLA_FIN); -- Metodo financiacion
    rcSalesFinanCond.interest_rate_id    := pktblplandife.fnugetinterestratecod(NUCOD_PLA_FIN); -- Interes
    rcSalesFinanCond.first_pay_date      := SYSDATE + 1;
    rcSalesFinanCond.percent_to_finance  := pkBillConst.CIENPORCIEN; --100;
    rcSalesFinanCond.interest_percent    := nuValorCero;
    rcSalesFinanCond.spread              := nuValorCero;
    rcSalesFinanCond.quotas_number       := numInstalmentsArray; -- Numero de cuotas
    rcSalesFinanCond.tax_financing_one   := pkConstante.NO;
    rcSalesFinanCond.value_to_finance    := nuValorCero;
    rcSalesFinanCond.document_support    := SUPPORT_DOCUMENT;
    rcSalesFinanCond.initial_payment     := nuValorCero;
    rcSalesFinanCond.average_quote_value := nuValorCero;
  
    --*/
  
    --/*
    if not dacc_sales_financ_cond.fblexist(inuSolicitud) then
      --Inserta la informacion de las condiciones
      DACC_Sales_Financ_Cond.insrecord(rcSalesFinanCond);
    else
      --Actualizar la informacion de las condiciones
      DACC_Sales_Financ_Cond.Updrecord(rcSalesFinanCond);
    end if;
  
    pkg_traza.trace('Ejecucion servicio CC_BOFINANCING.FINANCINGORDER',
                    pkg_traza.cnuNivelTrzDef);
    CC_BOFINANCING.FINANCINGORDER(inuSolicitud);
    --*/
  
    sbCampo := NULL;
    SELECT 'Diferido: ' || d.difecodi || ' - Fecha incial: ' || d.difefein ||
           ' - Numero Documento:' || d.difenudo ||
           ' - Valor Total Diferido:' || d.difevatd || ' - Primer Pago: ' ||
           d.difefein
      INTO sbCampo
      FROM OPEN.diferido d
     WHERE d.difenuse = nuProduct
       AND d.difenudo = SUPPORT_DOCUMENT
       AND ROWNUM = 1;
  
    DBMS_OUTPUT.put_line('Diferido: ' || sbCampo);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      ROLLBACK;
      pkg_error.geterror(onuErrorCode, osbErrorMessage);
      osbErrorMessage := osbErrorMessage ||
                         DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      pkg_traza.trace(osbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      ROLLBACK;
      pkg_error.seterror;
      pkg_error.geterror(onuErrorCode, osbErrorMessage);
      osbErrorMessage := osbErrorMessage ||
                         DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      pkg_traza.trace(osbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
    
  END prcFinanciarDuplicado;

BEGIN

  prcFinanciarDuplicado(52952616, 224778521, nuErrorCode, sbMensError);
  if nuErrorCode = 0 then
    --commit;
    null;
  else
    rollback;
    dbms_output.put_line('Error financiacion: ' || sbMensError);
  end if;

  pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbSP_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
  
    raise pkg_error.CONTROLLED_ERROR;
  
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbSP_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
  
    raise pkg_error.CONTROLLED_ERROR;
END;
/
