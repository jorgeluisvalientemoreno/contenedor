CREATE OR REPLACE FUNCTION fnu_baseliquidacion(isbEstado        varchar2,
                                               inuValorImpuBase number)

 RETURN NUMBER IS

  /*****************************************************************
  Propiedad intelectual de GDC.
  
  Unidad         : fnu_baseliquidacion
  Descripcion    : Metodo para obtener valor base de la cotizacion
  Autor          : Jorge Valiente
  Fecha          : 21-11-2023
  Caso           : OSF-1493
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  26/02/2023    Jorge Valiente                OSF-2274: Obtener valor del cargo 291 en ajuste del concepto 291
  09/08/2024    Jorge Valiente                OSF-3113: Setear el valor base liquidacion con el valor total de la actividad
                                                        registrada en la cotizacion relacionada con la orden a legalizar 
                                                        de la venta cotizada 
  09/08/2024    Jorge Valiente                OSF-3802: Setear el valor base liquidacion con el valor establecido en el ajuste
  10/06/2025    Jorge Valiente                OSF-4577: Setear el valor base liquidacion al ser ejecutado desde CCQUO
  ===============================================================
  ******************************************************************/

  csbMetodo CONSTANT VARCHAR2(100) := 'fnu_baseliquidacion'; --nombre del metodo
  nuValorBAse NUMBER := 0;
  nuValor     NUMBER;

  onuErrorCode    number;
  osbErrorMessage varchar2(4000);

  rcServSusc SERVSUSC%ROWTYPE;

  sbActividadInterna   varchar2(4000) := pkg_parametros.fsbGetValorCadena('ACTIVIDAD_INSTALACION_INTERNA');
  sbTipoTrabajoInterna varchar2(4000) := pkg_parametros.fsbGetValorCadena('TIPO_TRABAJO_INSTALACION_INTERNA');
  nuOrdenLegalizada    number;

  SBMODO VARCHAR2(1);

  rcperifact perifact%rowtype;
  nuConcepto number;
  blAjuste   boolean;

  CURSOR cuGetIVA(inuProducto  NUMBER,
                  inuContrato  IN NUMBER,
                  inuPrecioTot NUMBER) IS
    select *
      from (select cm.id_cot_comercial,
                   sum(cm.iva) iva,
                   sum(cm.precio_total) precio_total,
                   l.estado
              from LDC_ITEMS_COTIZACION_COM cm,
                   ge_items                 i,
                   mo_motive                mm,
                   ldc_cotizacion_comercial l
             where i.items_id = cm.actividad
               and cm.actividad in
                   (SELECT to_number(regexp_substr(sbActividadInterna,
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS ActividadInterna
                      FROM dual
                    CONNECT BY regexp_substr(sbActividadInterna,
                                             '[^,]+',
                                             1,
                                             LEVEL) IS NOT NULL)
               and l.sol_cotizacion = mm.package_id
               and cm.id_cot_comercial = l.id_cot_comercial
               AND mm.product_id = inuProducto
               AND mm.subscription_id = inuContrato
             group by cm.id_cot_comercial, l.estado
             ORDER BY cm.id_cot_comercial DESC)
     where precio_total = inuPrecioTot;

  rfcuGetIVA cuGetIVA%rowtype;

  CURSOR cuGetIVAOt IS
    select licc.id_cot_comercial,
           sum(licc.iva) iva,
           sum(licc.precio_total) precio_total,
           lcm.estado
      from or_order_activity ooa
     inner join mo_packages mp
        on mp.package_id = ooa.package_id
     inner join MO_PACKAGES_ASSO mpa
        on mpa.package_id = mp.package_id
     inner join mo_packages mp1
        on mp1.package_id = mpa.package_id_asso
     inner join ldc_cotizacion_comercial lcm
        on lcm.sol_cotizacion = mpa.package_id_asso
     inner join LDC_ITEMS_COTIZACION_COM licc
        on licc.id_cot_comercial = lcm.id_cot_comercial
       and licc.actividad in
           (SELECT to_number(regexp_substr(sbActividadInterna,
                                           '[^,]+',
                                           1,
                                           LEVEL)) AS ActividadInterna
              FROM dual
            CONNECT BY regexp_substr(sbActividadInterna, '[^,]+', 1, LEVEL) IS NOT NULL)
     where ooa.order_id = nuOrdenLegalizada
       and ooa.task_type_id in
           (SELECT to_number(regexp_substr(sbTipoTrabajoInterna,
                                           '[^,]+',
                                           1,
                                           LEVEL)) AS TipoTrabajoInterna
              FROM dual
            CONNECT BY regexp_substr(sbTipoTrabajoInterna, '[^,]+', 1, LEVEL) IS NOT NULL)
     group by licc.id_cot_comercial, lcm.estado
     ORDER BY licc.id_cot_comercial DESC;

  rfcuGetIVAOt cuGetIVAOt%rowtype;

  --OSF-2274
  --cursor para obtener el ultimo concepto registrado en FAJU
  cursor cuUltimoCargoAjuste(inuNumeroServicio number) is
    SELECT nvl(fcp.caapvalo, 0), fcp.caapsign
      FROM FA_Cargapro fcp
     WHERE fcp.caapnuse = inuNumeroServicio
       and fcp.caapfecr =
           (SELECT max(fcp1.caapfecr)
              FROM FA_Cargapro fcp1
             WHERE fcp1.caapnuse = inuNumeroServicio)
       and fcp.caapconc = 291;

  nuUltimoCargoAjuste number;
  sbSignoCargoAjuste  varchar2(2);

  --cursor para obtener el Iva de la ultima venta cotizada 
  cursor cuIvaUltVentaCotizada(inuNumeroServicio number) is
    select PKG_BOCOTIZACIONCOMERCIAL.fnuObtenerPorcentajeIVA(cc.id_cot_comercial) iva_porcentaje
      from ldc_cotizacion_comercial cc
     inner join mo_packages_asso mpa
        on mpa.package_id_asso = cc.sol_cotizacion
     inner join mo_packages mp
        on mp.package_id = mpa.package_id
     inner join mo_motive mm
        on mm.package_id = mp.package_id
       and mm.product_id = inuNumeroServicio
     where cc.estado = 'A'
     order by cc.fecha_registro desc;

  nuIvaUltVentaCotizada number;
  -----------------------

  PROCEDURE PRC_SeteoValorBase(isbModo varchar2, inuValorBase Number) IS
  
    onuErrCode    number;
    osbErrMessage varchar2(4000);
  
  BEGIN
  
    pkg_traza.trace(csbMetodo || '.PRC_SeteoValorBase',
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Modo de liquidacion: ' || isbModo,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Seteo de Valor Base: ' || inuValorBase,
                    pkg_traza.cnuNivelTrzDef);
  
    if (isbModo = pkBOLiquidateTax.fsbGetReRatingMode) then
      pkg_traza.trace('Eleccion 1', pkg_traza.cnuNivelTrzDef);
      -- Fija el valor base en la generacion del cargo con el concepto configurado
      pkChargeMgr.SetBaseValue(abs(inuValorBase));
    else
      pkg_traza.trace('Eleccion 2', pkg_traza.cnuNivelTrzDef);
      -- Fija el valor base para el calculo del valor del impuesto
      pkInstanceDataMgr.SetCG_BaseValue(abs(inuValorBase));
    
      -- Fija el valor base en la generacion del cargo con el concepto configurado
      pkChargeMgr.SetBaseValue(abs(inuValorBase));
    end if;
  
    pkg_traza.trace(csbMetodo || '.PRC_SeteoValorBase',
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(onuErrCode, osbErrMessage);
      pkg_traza.trace('sberror: ' || osbErrMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuErrCode, osbErrMessage);
      pkg_traza.trace('sberror: ' || osbErrMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
  END PRC_SeteoValorBase;

  --Servicio de ajuste
  Function fbl_Ajuste return boolean is
  
    rcBillingPeriod perifact%ROWTYPE;
    rcUsagePeriod   pericose%ROWTYPE;
    rcProduct       servsusc%ROWTYPE;
    nuConcept       NUMBER;
    nuIdx           number;
    --Tabla de conceptos base de liquidacion
    tbConcepts pkBCConcbali.tytbConcbali;
  
    sbBaseConcepts varchar2(4000);
  
    onuErrCode    number;
    osbErrMessage varchar2(4000);
  begin
  
    pkg_traza.trace(csbMetodo || '.fbl_Ajuste',
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
    -- Obtener registro del producto en liquidaci?n
    pkInstanceDataMgr.GetCG_ProductRecord(rcProduct);
    pkInstanceDataMgr.GetCG_BillPeriodRecord(rcBillingPeriod);
    pkInstanceDataMgr.getcg_consperiodrecord(rcUsagePeriod);
    pkInstanceDataMgr.getcg_concept(nuConcept);
  
    -- Busca los conceptos base de liquidacion
    pkBCConcbali.GetRecordByConcLiqu(nuConcept,
                                     tbConcepts --out
                                     );
  
    nuIdx := tbConcepts.FIRST;
  
    while (nuIdx IS not null) loop
    
      sbBaseConcepts := sbBaseConcepts || ',' || tbConcepts(nuIdx).coblcoba;
    
      nuIdx := tbConcepts.next(nuIdx);
    
    end loop;
  
    sbBaseConcepts := sbBaseConcepts || ',';
  
    pkg_traza.trace('Producto: ' || rcProduct.Sesunuse,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Periodo Facturacion: ' || rcBillingPeriod.Pefacodi,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Periodo Consumo: ' || rcUsagePeriod.Pecscons,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Conceptos: ' || sbBaseConcepts,
                    pkg_traza.cnuNivelTrzDef);
  
    if instr(sbBaseConcepts, ',291,') > 0 then
      pkg_traza.trace('Retorna TRUE', pkg_traza.cnuNivelTrzDef);
    
      pkg_traza.trace(csbMetodo || '.fbl_Ajuste',
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN);
      return true;
    else
      pkg_traza.trace('Retorna FALSE', pkg_traza.cnuNivelTrzDef);
    
      pkg_traza.trace(csbMetodo || '.fbl_Ajuste',
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN);
      return false;
    end if;
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(onuErrCode, osbErrMessage);
      pkg_traza.trace('sberror: ' || osbErrMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuErrCode, osbErrMessage);
      pkg_traza.trace('sberror: ' || osbErrMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
  end fbl_Ajuste;
  ----------------------------------

BEGIN

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

  pkInstanceDataMgr.gettg_exemode(SBMODO);

  pkg_traza.trace('Estado: ' || isbEstado, pkg_traza.cnuNivelTrzDef);

  pkInstanceDataMgr.getcg_productrecord(rcServSusc);
  pkg_traza.trace('Contrato: ' || rcServSusc.sesususc,
                  pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Servicio: ' || rcServSusc.SESUNUSE,
                  pkg_traza.cnuNivelTrzDef);

  pkInstanceDataMgr.GetCG_BillPeriodRecord(rcperifact);
  pkg_traza.trace('Periodo Consumo: ' || rcperifact.pefacodi,
                  pkg_traza.cnuNivelTrzDef);

  pkInstanceDataMgr.getcg_concept(nuConcepto);
  pkg_traza.trace('Concepto: ' || nuConcepto, pkg_traza.cnuNivelTrzDef);

  -- Obtiene valor base del calculo del impuesto en la liq del servicio de OPEN
  nuValorBAse := FA_BOServiciosLiqPorProducto.fnuGetTotLiqBaseConc(pktblservsusc.frcgetrecord(rcServSusc.SESUNUSE),
                                                                   rcperifact,
                                                                   nuConcepto,
                                                                   1 --Suma algebraica
                                                                   );
  pkg_traza.trace('Valor Base: ' || nuValorBAse, pkg_traza.cnuNivelTrzDef);

  if isbEstado = 'E' then
  
    --Inicio OSF-4577 
    IF NVL(nuValorBAse, 0) = 0 THEN
      pkg_traza.trace('Servicio pkInstanceDataMgr.Getcg_Basevalue',
                      pkg_traza.cnuNivelTrzDef);
      pkInstanceDataMgr.Getcg_Basevalue(nuValorBAse);
      pkg_traza.trace('Valor Base Liquidacion: ' || nuValorBAse,
                      pkg_traza.cnuNivelTrzDef);
    END IF;
    ---Fin OSF-4577
  
    if sbActividadInterna is null then
      pkg_traza.trace('El parametro ACTIVIDAD_INSTALACION_INTERNA no tiene ningun valor.',
                      pkg_traza.cnuNivelTrzDef);
      pkg_error.setErrorMessage(isbMsgErrr => 'El parametro ACTIVIDAD_INSTALACION_INTERNA no tiene ningun valor.');
    end if;
    pkg_traza.trace('Parametro ACTIVIDAD_INSTALACION_INTERNA: ' ||
                    sbActividadInterna,
                    pkg_traza.cnuNivelTrzDef);
  
    if sbTipoTrabajoInterna is null then
      pkg_traza.trace('El parametro ACTIVIDAD_INSTALACION_INTERNA no tiene ningun valor.',
                      pkg_traza.cnuNivelTrzDef);
      pkg_error.setErrorMessage(isbMsgErrr => 'El parametro TIPO_TRABAJO_INSTALACION_INTERNA no tiene ningun valor.');
    end if;
    pkg_traza.trace('Parametro TIPO_TRABAJO_INSTALACION_INTERNA: ' ||
                    sbTipoTrabajoInterna,
                    pkg_traza.cnuNivelTrzDef);
  
    open cuGetIVA(rcServSusc.SESUNUSE, rcServSusc.SESUSUSC, nuValorBAse);
    fetch cuGetIVA
      into rfcuGetIVA;
    close cuGetIVA;
  
    nuValor := NVL(rfcuGetIVA.Iva, 0);
  
  else
  
    if sbActividadInterna is null then
      pkg_traza.trace('El parametro ACTIVIDAD_INSTALACION_INTERNA no tiene ningun valor.',
                      pkg_traza.cnuNivelTrzDef);
      pkg_error.setErrorMessage(isbMsgErrr => 'El parametro ACTIVIDAD_INSTALACION_INTERNA no tiene ningun valor.');
    end if;
    pkg_traza.trace('Parametro ACTIVIDAD_INSTALACION_INTERNA: ' ||
                    sbActividadInterna,
                    pkg_traza.cnuNivelTrzDef);
  
    if sbTipoTrabajoInterna is null then
      pkg_traza.trace('El parametro ACTIVIDAD_INSTALACION_INTERNA no tiene ningun valor.',
                      pkg_traza.cnuNivelTrzDef);
      pkg_error.setErrorMessage(isbMsgErrr => 'El parametro TIPO_TRABAJO_INSTALACION_INTERNA no tiene ningun valor.');
    end if;
    pkg_traza.trace('Parametro TIPO_TRABAJO_INSTALACION_INTERNA: ' ||
                    sbTipoTrabajoInterna,
                    pkg_traza.cnuNivelTrzDef);
    nuOrdenLegalizada := PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL(); -- Obtenemos la orden que se esta legalizando
    if nuOrdenLegalizada is null then
      blAjuste := fbl_Ajuste;
      if blAjuste then
        open cuUltimoCargoAjuste(rcServSusc.SESUNUSE);
        fetch cuUltimoCargoAjuste
          into nuUltimoCargoAjuste, sbSignoCargoAjuste;
        close cuUltimoCargoAjuste;
      
        --Valida si existe algun ajuste del cagor 291
        if nuUltimoCargoAjuste = 0 then
          pkg_traza.trace('No existe ajuste del concepto 291 y sera seteada en 0',
                          pkg_traza.cnuNivelTrzDef);
          nuValor     := 0;
          nuValorBAse := 0;
        else
          open cuIvaUltVentaCotizada(rcServSusc.SESUNUSE);
          fetch cuIvaUltVentaCotizada
            into nuIvaUltVentaCotizada;
          close cuIvaUltVentaCotizada;
        
          pkg_traza.trace('Valor Ultimo Cargo Ajuste Temporal: ' ||
                          nuUltimoCargoAjuste,
                          pkg_traza.cnuNivelTrzDef);
        
          pkg_traza.trace('Iva Ultima Venta Cotizada Aprobada: ' ||
                          nvl(nuIvaUltVentaCotizada, 0),
                          pkg_traza.cnuNivelTrzDef);
        
          if nuIvaUltVentaCotizada = 0 then
            pkg_traza.trace('Ejecuta LIQTAXBASEVALUE para obtener valor de ajuste',
                            pkg_traza.cnuNivelTrzDef);
            nuValor := LIQTAXBASEVALUE(NULL, 1, 'N');
            --Inicio 3802
            if nvl(nuValorBAse, 0) = 0 then
              nuValorBAse := nuUltimoCargoAjuste;
            end if;
            --Fin 3802
          else
          
            pkg_traza.trace('Signo Ajuste: ' || sbSignoCargoAjuste,
                            pkg_traza.cnuNivelTrzDef);
            nuValor := round(nvl((nuUltimoCargoAjuste *
                                 nvl(nuIvaUltVentaCotizada, 0)) / 100,
                                 0),
                             2);
          
            if sbSignoCargoAjuste = 'CR' then
              nuValor := nuValor * -1;
            end if;
          
            --Inicio 3802
            if nvl(nuValorBAse, 0) = 0 then
              nuValorBAse := nuUltimoCargoAjuste;
            end if;
            --Fin 3802
          
          end if;
        
          pkg_traza.trace('Valor IVA Cargo Base del concepto 291: ' ||
                          nuValor,
                          pkg_traza.cnuNivelTrzDef);
        end if;
      else
        pkg_traza.trace('No existe ajuste del concepto 291 y sera seteada en 0',
                        pkg_traza.cnuNivelTrzDef);
        nuValor     := 0;
        nuValorBAse := 0;
      end if;
    else
      open cuGetIVAOt;
      fetch cuGetIVAOt
        into rfcuGetIVAOt;
      close cuGetIVAOt;
      pkg_traza.trace('Orden Legalizada: ' || nuOrdenLegalizada,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('Estado Cotizacion: ' || rfcuGetIVAOt.Estado,
                      pkg_traza.cnuNivelTrzDef);
      if rfcuGetIVAOt.Estado <> isbEstado then
        pkg_traza.trace('La cotizacion no tiene un estado Aprobado.',
                        pkg_traza.cnuNivelTrzDef);
        pkg_error.setErrorMessage(isbMsgErrr => 'La cotizacion no tiene un estado Aprobado.');
      else
        nuValor := rfcuGetIVAOt.Iva;
        --Inicio OSF-3113
        nuValorBAse := rfcuGetIVAOt.Precio_Total;
        --Fin OSF-3113
      end if;
    end if;
  end if;

  if nvl(nuValor, 0) = 0 then
    nuValorBAse := 0;
  end if;

  PRC_SeteoValorBase(SBMODO, nuValorBAse);

  pkg_traza.trace('nuValorBAse: ' || nuValorBAse, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('nuValorIva: ' || nuValor, pkg_traza.cnuNivelTrzDef);

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  RETURN(nvl(nuValor, 0));

EXCEPTION
  WHEN pkg_error.CONTROLLED_ERROR THEN
    pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
    pkg_traza.trace('sberror: ' || OsbErrorMessage,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
    raise pkg_error.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
    pkg_traza.trace('sberror: ' || OsbErrorMessage,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
    raise pkg_error.CONTROLLED_ERROR;
END fnu_baseliquidacion;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('FNU_BASELIQUIDACION', 'OPEN');
END;
/
