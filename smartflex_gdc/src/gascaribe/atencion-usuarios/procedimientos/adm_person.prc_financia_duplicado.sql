CREATE OR REPLACE PROCEDURE adm_person.prc_financia_duplicado IS

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prc_financia_duplicado
    Descripcion     : servicio para financiar duplicado
    Autor           : Jorge Valiente
    Fecha           : 16-07-2024
  
    Modificaciones  :
    Autor           Fecha       Caso        Descripcion
    Jorge Valiente  29/07/2024  OSF-3034    Logica para validar si para la solicitud ya se definieron Condiciones de financiación
  ***************************************************************************/

  csbSP_NAME  VARCHAR2(70) := 'prc_financia_duplicado';
  nuErrorCode NUMBER; -- se almacena codigo de error
  sbMensError VARCHAR2(2000); -- se almacena descripcion del error 

  cursor cuDuplicado is
    select * from DUPLICADO_FACTURA df where df.package_id <> 0;

  rfDuplicado cuDuplicado%rowtype;

  PROCEDURE prcGeneraCargoDuplicado(inuContrato     IN number,
                                    inuCupon        IN number,
                                    inuSolicitud    IN number,
                                    onuErrorCode    OUT number,
                                    osbErrorMessage OUT VARCHAR2) AS
  
    csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME ||
                                        '.prcGeneraCargoDuplicado';
  
    nuPackage   mo_packages.package_id%type;
    nuReception mo_packages.reception_type_id%type;
  
    -- CA- 200-904: consultar el valor parametrizado
    cursor cuGetValueToCharge(inuSolicitud number) is
      SELECT tipval.value
        FROM mo_packages pkg, ldc_tipvaldup tipval
       WHERE pkg.package_id = inuSolicitud
         AND pkg.reception_type_id = tipval.reception_type_id;
  
    sbCodReceptionCNCRM ld_parameter.value_chain%type := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('COD_RECEPTION_CNCRM');
    CURSOR cuGetValueRecep is
      SELECT tipval.value
        FROM ldc_tipvaldup tipval
       WHERE tipval.reception_type_id in
             (SELECT to_number(regexp_substr(sbCodReceptionCNCRM,
                                             '[^,]+',
                                             1,
                                             LEVEL)) AS column_value
                FROM dual
              CONNECT BY regexp_substr(sbCodReceptionCNCRM,
                                       '[^,]+',
                                       1,
                                       LEVEL) IS NOT NULL)
         AND rownum < 2;
  
    cursor cuGetValueToKiosko(inuRecep number) is
      SELECT tipval.value
        FROM ldc_tipvaldup tipval
       WHERE tipval.reception_type_id = inuRecep;
  
    -- Concepto de cobro del duplicado
    sbCONCEPTODUPL constant varchar2(100) := 'CONC_POR_DUPLICADO';
  
    -- Valor de cobro del duplicado
    sbVALORCOBRO constant varchar2(100) := 'COBRO_POR_DUPLICADO';
  
    nuProduct         cargos.cargnuse%type;
    nuConcept         cargos.cargconc%type;
    nuUnits           cargos.cargunid%type;
    nuChargeCause     cargos.cargcaca%type;
    nuValue           cargos.cargvalo%type;
    bsSupportDocument cargos.cargdoso%type;
    nuPeriodCons      cargos.cargpeco%type;
  
    nuCupon          cupon.cuponume%type;
    nuSuscripc       cupon.cuposusc%type;
    blValExisteCargo boolean := false;
  
    ----------------------------------------------------------------------------
  
    function GetFirstProduct(inususcrip number) return number is
    
      nuErrorCode    number;
      sbErrorMessage VARCHAR2(4000);
      csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME || 'GetFirstProduct';
      --Retorna producto de Gas en estado facturable.
      cursor cuProductGasActivo(suscrip number) is
        select sesunuse
          from servsusc, confesco
         where sesususc = suscrip
           and sesuesco = coeccodi
           and sesuserv = coecserv
           and sesuserv = 7014 -- Servicio Gas
           and coecfact = 'S'
           and rownum <= 1;
    
      -- Retorna productos del contrato en estado facturable.
      cursor cuProductsActivo(suscrip number) is
        select sesunuse
          from servsusc, confesco
         where sesususc = suscrip
           and sesuesco = coeccodi
           and sesuserv = coecserv
           and coecfact = 'S'
           and rownum <= 1;
    
      nuProduct_id number := 0;
    begin
    
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbInicio);
    
      pkg_traza.trace('Contrato: ' || inususcrip, pkg_traza.cnuNivelTrzDef);
    
      OPEN cuProductGasActivo(inususcrip);
      FETCH cuProductGasActivo
        INTO nuProduct_id;
      CLOSE cuProductGasActivo;
    
      if ((nuProduct_id = 0) or (nuProduct_id is null)) then
        OPEN cuProductsActivo(inususcrip);
        FETCH cuProductsActivo
          INTO nuProduct_id;
        CLOSE cuProductsActivo;
      end if;
    
      pkg_traza.trace('Producto: ' || nuProduct_id,
                      pkg_traza.cnuNivelTrzDef);
    
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN);
    
      return nuProduct_id;
    
    EXCEPTION
      when others then
        pkg_error.seterror;
        pkg_error.geterror(nuErrorCode, sbErrorMessage);
        osbErrorMessage := sbErrorMessage ||
                           DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
        pkg_traza.trace(csbMetodo || ' osbErrorMessage: ' ||
                        sbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        return 0;
    end GetFirstProduct;
  
    FUNCTION fblExisteCargo(nuProduct number, nuConceptoDuplicado number)
      return boolean is
    
      csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME || 'fblExisteCargo';
    
      nuErrorCode    number;
      sbErrorMessage VARCHAR2(4000);
    
      cursor cuCargo is
        select count(1)
          from cargos
         where cargnuse = nuProduct
           and cargconc = nuConceptoDuplicado
           and cargdoso like 'PP-%'
           and trunc(sysdate) = trunc(cargfecr);
    
      nuExiste number := 0;
    
      blExiste Boolean;
    
    begin
    
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbInicio);
    
      open cuCargo;
      fetch cuCargo
        into nuExiste;
      close cuCargo;
    
      if nuExiste <> 0 then
        pkg_traza.trace('Existe: return true', pkg_traza.cnuNivelTrzDef);
        blExiste := true;
        --return true;
      else
        pkg_traza.trace('Existe: return false', pkg_traza.cnuNivelTrzDef);
        blExiste := false;
        --return false;
      end if;
    
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN);
      return blExiste;
    
    EXCEPTION
      when others then
        pkg_error.seterror;
        pkg_error.geterror(nuErrorCode, sbErrorMessage);
        osbErrorMessage := sbErrorMessage ||
                           DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
        pkg_traza.trace(csbMetodo || ' osbErrorMessage: ' ||
                        sbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        return false;
    END fblExisteCargo;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbInicio);
  
    pkg_error.prInicializaError(ONUERRORCODE, OSBERRORMESSAGE);
  
    nuCupon := inuCupon;
    pkg_traza.trace('Cupon: ' || nuCupon, pkg_traza.cnuNivelTrzDef);
  
    nuSuscripc := inuContrato;
    pkg_traza.trace('Contrato: ' || inuContrato, pkg_traza.cnuNivelTrzDef);
  
    -- Identificador del producto
    nuProduct := GetFirstProduct(nuSuscripc);
    pkg_traza.trace('Producto: ' || nuProduct, pkg_traza.cnuNivelTrzDef);
  
    -- Medio de recepcion Kiosko
    nuReception := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('COD_RECEPTION_KIOSKO');
    pkg_traza.trace('Medio Recepcion KIOSKO: ' || nuReception,
                    pkg_traza.cnuNivelTrzDef);
  
    -- Identificador del concepto parametrizado en LD_PARAMETER CONC_POR_DUPLICADO.
    nuConcept := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO(sbCONCEPTODUPL);
    pkg_traza.trace('Concepto: ' || nuConcept, pkg_traza.cnuNivelTrzDef);
  
    --Valida que no tenga cargo por duplicado generado ese mismo dia a la -1
    blValExisteCargo := fblExisteCargo(nuProduct, nuConcept);
  
    if (not blValExisteCargo) then
    
      -- Unidades del cargo
      nuUnits := 0;
      pkg_traza.trace('Unidades del cargo: ' || nuUnits,
                      pkg_traza.cnuNivelTrzDef);
    
      -- Causa del cargo definida por Zandra Prada [Rq 173]
      nuChargeCause := 4;
      pkg_traza.trace('Causa del cargo: ' || nuChargeCause,
                      pkg_traza.cnuNivelTrzDef);
    
      -- Solicitud.
      nuPackage := inuSolicitud;
      pkg_traza.trace('Solicitud: ' || nuPackage, pkg_traza.cnuNivelTrzDef);
    
      --Valor del cargo del duplicado
      if (nuPackage = 0 or nuPackage is null) then
      
        -- obtener valor cargo kiosko
        open cuGetValueToKiosko(nuReception);
        fetch cuGetValueToKiosko
          into nuValue;
        close cuGetValueToKiosko;
      
      else
        -- obtener valor x Medio de recepcion
        open cuGetValueToCharge(nuPackage);
        fetch cuGetValueToCharge
          into nuValue;
        close cuGetValueToCharge;
      
        if (nuValue is null) then
        
          -- obtener valor x CNCRM
          open cuGetValueRecep;
          fetch cuGetValueRecep
            into nuValue;
          close cuGetValueRecep;
        end if;
      
      end if;
    
      -- si no se ha configurado ningun valor lo obtiene de un parametro
      if (nuValue is null) then
        nuValue := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO(sbVALORCOBRO);
      end if;
      pkg_traza.trace('Valor Duplicado: ' || nuValue,
                      pkg_traza.cnuNivelTrzDef);
    
      bsSupportDocument := 'PP-' || nvl(inuSolicitud, 0);
      pkg_traza.trace('Documento Soporte: ' || bsSupportDocument,
                      pkg_traza.cnuNivelTrzDef);
    
      -- Periodo de consumo actual para el producto
      nuPeriodCons := pkbcpericose.fnugetcurrconsperiodbyprod(nuProduct);
      pkg_traza.trace('Periodo de Consumo Actual: ' || nuPeriodCons,
                      pkg_traza.cnuNivelTrzDef);
    
      -- Si no tiene periodo de consumo actual, retorne el ultimo periodo de consumo configurado.
      if (nuPeriodCons = -1) then
        select pecscons
          into nuPeriodCons
          from (select pecscons
                  from pericose
                 where pecscico = PKG_BCPRODUCTO.FNUCICLOCONSUMO(nuProduct)
                 order by pecsfeci desc)
         where rownum <= 1;
        pkg_traza.trace('Retorna el ultimo periodo de Consumo: ' ||
                        nuPeriodCons,
                        pkg_traza.cnuNivelTrzDef);
      end if;
    
      -- Registrar Cobros por Facturar
      API_CREACARGOS(nuProduct,
                     nuConcept,
                     nuUnits,
                     nuChargeCause,
                     nuValue,
                     bsSupportDocument,
                     nuPeriodCons,
                     ONUERRORCODE,
                     OSBERRORMESSAGE);
    
      pkg_traza.trace('Error: ' || osbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
    
      -- Se valida si hubo error en la aplicacion del pago.
      if (onuErrorCode <> pkConstante.EXITO) then
        Pkg_Error.SetErrorMessage(isbMsgErrr => osbErrorMessage);
      end if;
    
    else
      --Elimina el cupon si ya tiene cargado la financiacion de otro duplicado ese mismo dia.
      pkg_duplicado_factura.prcEliminaDuplicado(nuCupon);
      commit;
    end if;
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      ROLLBACK;
      pkg_error.geterror(onuErrorCode, osbErrorMessage);
      osbErrorMessage := substr(osbErrorMessage ||
                                DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                                1,
                                254);
      pkg_traza.trace(csbMetodo || ' osbErrorMessage: ' || osbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      ROLLBACK;
      pkg_error.seterror;
      pkg_error.geterror(onuErrorCode, osbErrorMessage);
      osbErrorMessage := osbErrorMessage ||
                         DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
  END prcGeneraCargoDuplicado;

  PROCEDURE prcFinanciarDuplicado(inuContrato     IN number,
                                  inuCupon        IN number,
                                  inuSolicitud    IN number,
                                  onuErrorCode    OUT number,
                                  osbErrorMessage OUT VARCHAR2) IS
  
    csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME ||
                                        '.prcFinanciarDuplicado';
  
    nuProduct cargos.cargnuse%type;
  
    nuCupon    cupon.cuponume%type;
    nuSuscripc cupon.cuposusc%type;
  
    -- Tipo de dato condiciones de financiacion
    rcSalesFinanCond DACC_Sales_Financ_Cond.styCC_Sales_Financ_Cond;
  
    --PARAMETRO CODIGO PLAN DE FINANCIACION
    NUCOD_PLA_FIN_SOL_EST_CUE LD_PARAMETER.PARAMETER_ID%TYPE := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('COD_PLA_FIN_SOL_EST_CUE');
  
    function GetFirstProduct(inususcrip number) return number is
    
      csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME || '.GetFirstProduct';
      nuErrorCode    number;
      sbErrorMessage VARCHAR2(4000);
    
      --Retorna los productos que se encuentran con un estado de corte facturable.
      -- Retorna producto de Gas en estado facturable.
      cursor cuProductGasActivo(suscrip number) is
        select sesunuse
          from servsusc, confesco
         where sesususc = suscrip
           and sesuesco = coeccodi
           and sesuserv = coecserv
           and sesuserv = 7014 -- Servicio Gas
           and coecfact = 'S'
           and rownum <= 1;
    
      -- Retorna productos del contrato en estado facturable.
      cursor cuProductsActivo(suscrip number) is
        select sesunuse
          from servsusc, confesco
         where sesususc = suscrip
           and sesuesco = coeccodi
           and sesuserv = coecserv
           and coecfact = 'S'
           and rownum <= 1;
    
      nuProduct_id number := 0;
    begin
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbInicio);
    
      pkg_traza.trace('Contrato: ' || inususcrip, pkg_traza.cnuNivelTrzDef);
    
      OPEN cuProductGasActivo(inususcrip);
      FETCH cuProductGasActivo
        INTO nuProduct_id;
      CLOSE cuProductGasActivo;
    
      if ((nuProduct_id = 0) or (nuProduct_id is null)) then
        OPEN cuProductsActivo(inususcrip);
        FETCH cuProductsActivo
          INTO nuProduct_id;
        CLOSE cuProductsActivo;
      end if;
    
      pkg_traza.trace('Producto: ' || nuProduct_id,
                      pkg_traza.cnuNivelTrzDef);
    
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN);
    
      return nuProduct_id;
    
    EXCEPTION
      when others then
        pkg_error.seterror;
        pkg_error.geterror(nuErrorCode, sbErrorMessage);
        osbErrorMessage := sbErrorMessage ||
                           DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
        return 0;
    end GetFirstProduct;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbInicio);
  
    pkg_error.prInicializaError(ONUERRORCODE, OSBERRORMESSAGE);
  
    --codigo cupon
    nuCupon := inuCupon;
    --codigo contrato
    nuSuscripc := inuContrato;
    --codigo del primer prodcuto. Funcion obtendia del TRIGGER de la tabla LD_CUPON_CAUSAL
    nuProduct := GetFirstProduct(nuSuscripc);
  
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
  
    --Actualiza los campos CC_SALES_FINANC_COND
    pkg_traza.trace('Actualiza los campos CC_SALES_FINANC_COND',
                    pkg_traza.cnuNivelTrzDef);
    rcSalesFinanCond.package_id          := inuSolicitud; -- Solicitud
    rcSalesFinanCond.financing_plan_id   := NUCOD_PLA_FIN_SOL_EST_CUE; -- Plan de financiacion
    rcSalesFinanCond.compute_method_id   := pktblplandife.fnugetpaymentmethod(NUCOD_PLA_FIN_SOL_EST_CUE); -- Metodo financiacion
    rcSalesFinanCond.interest_rate_id    := pktblplandife.fnugetinterestratecod(NUCOD_PLA_FIN_SOL_EST_CUE); -- Interes
    rcSalesFinanCond.first_pay_date      := sysdate;
    rcSalesFinanCond.percent_to_finance  := 100;
    rcSalesFinanCond.interest_percent    := 0;
    rcSalesFinanCond.spread              := 0;
    rcSalesFinanCond.quotas_number       := 1; -- Numero de cuotas
    rcSalesFinanCond.tax_financing_one   := 'N';
    rcSalesFinanCond.value_to_finance    := 0;
    rcSalesFinanCond.document_support    := 'PP-' || inuSolicitud;
    rcSalesFinanCond.initial_payment     := 0;
    rcSalesFinanCond.average_quote_value := 0;

    --OSF-3034 Valida si la solicitud ya se definieron Condiciones de financiación
    if not dacc_sales_financ_cond.fblexist(inuSolicitud) then
        --Inserta la información de las condiciones
        DACC_Sales_Financ_Cond.insrecord(rcSalesFinanCond);
    else
        --Actualizar la información de las condiciones
          DACC_Sales_Financ_Cond.Updrecord(rcSalesFinanCond);
    end if;

    --Inicio Logica SAO 386766
    /* Actualizar Flag ACTIVE antes de la financiacion */
    Begin
      UPDATE mo_motive_payment mp
         SET mp.active = 'N'
       WHERE mp.package_payment_id =
             (SELECT pp.package_payment_id
                FROM mo_package_payment pp
               WHERE pp.package_id = inuSolicitud)
         AND mp.coupon_id = nuCupon;
    end;
    --Fin Logica SAO 386766
  
    pkg_traza.trace('Ejecucion servicio CC_BOFINANCING.FINANCINGORDER',
                    pkg_traza.cnuNivelTrzDef);
    CC_BOFINANCING.FINANCINGORDER(inuSolicitud);
  
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

  pkg_traza.trace(csbSP_NAME,
                  pkg_traza.cnuNivelTrzDef,
                  pkg_traza.csbINICIO);

  for rfDuplicado in cuDuplicado loop
    prcGeneraCargoDuplicado(rfDuplicado.Susccodi,
                            rfDuplicado.Cuponume,
                            rfDuplicado.Package_Id,
                            nuErrorCode,
                            sbMensError);
    if nuErrorCode = 0 then
      prcFinanciarDuplicado(rfDuplicado.Susccodi,
                            rfDuplicado.Cuponume,
                            rfDuplicado.Package_Id,
                            nuErrorCode,
                            sbMensError);
      if nuErrorCode = 0 then
        pkg_duplicado_factura.prcEliminaDuplicado(rfDuplicado.Cuponume);
        commit;
      else
        rollback;
        pkg_duplicado_factura.prcActualizaObservacion(rfDuplicado.Cuponume,
                                                      sbMensError);
      end if;
    else
      rollback;
      pkg_duplicado_factura.prcActualizaObservacion(rfDuplicado.Cuponume,
                                                    sbMensError);
    end if;
  
  end loop;

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
BEGIN
  pkg_utilidades.prAplicarPermisos('PRC_FINANCIA_DUPLICADO', 'ADM_PERSON');
END;
/
