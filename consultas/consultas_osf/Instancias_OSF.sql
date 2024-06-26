--Seteo de Valor Base en Memoria con relacion al modo instanciado
pkInstanceDataMgr.gettg_exemode(isbModo);
  
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
  

--Servicio de ajuste, para validar si la DATA utilizada en el momento de creacion 
--del cargo con el concepto al que se le realizara ajustes desde FAJU
Function fbl_Ajuste return boolean is
  
  rcBillingPeriod perifact%ROWTYPE;
  rcUsagePeriod   pericose%ROWTYPE;
  rcProduct       servsusc%ROWTYPE;
  nuConcept       NUMBER;
  nuIdx           number;
  --Tabla de conceptos base de liquidacion
  tbConcepts pkBCConcbali.tytbConcbali;
  
  sbBaseConcepts varchar2(4000);
  
  cursor cuCargos(inuProduct      number,
                  inuBillPeriod   number,
                  inuUsagePeriod  number,
                  isbBaseConcepts varchar2) is
    SELECT --+ index(cargos IX_CARGOS04)
     sum(decode(cargos.cargsign,
                'DB',
                cargos.cargvalo,
                cargos.cargvalo * -1))
      FROM cargos
     WHERE cargos.cargnuse = inuProduct
       AND cargos.cargpefa = inuBillPeriod
       AND nvl(cargos.cargpeco, -1) = nvl(inuUsagePeriod, -1)
       AND cargos.cargsign in ('CR', 'DB')
       AND instr(isbBaseConcepts, ',' || cargos.cargconc || ',') > 0;
  
  nuValorCargo  number;
  onuErrCode    number;
  osbErrMessage varchar2(4000);
begin
  
  pkg_traza.trace(csbMetodo || '.fbl_Ajuste',
                  pkg_traza.cnuNivelTrzDef,
                  pkg_traza.csbINICIO);
  -- Obtener registro del producto en liquidación
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
  
  open cuCargos(rcProduct.Sesunuse,
                rcBillingPeriod.Pefacodi,
                rcUsagePeriod.Pecscons,
                sbBaseConcepts);
  fetch cucargos
    into nuValorCargo;
  close cuCargos;
  pkg_traza.trace('Valor Ajuste: ' || nuValorCargo,
                  pkg_traza.cnuNivelTrzDef);
  
  if nuValorCargo > 0 then
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

--Instanciar registro de producto utilizado en la regla
pkInstanceDataMgr.getcg_productrecord(rcServSusc);
pkg_traza.trace('Contrato: ' || rcServSusc.sesususc,pkg_traza.cnuNivelTrzDef);
pkg_traza.trace('Servicio: ' || rcServSusc.SESUNUSE,pkg_traza.cnuNivelTrzDef);

--Instanciar registro de periodo de facturacion utilizado en la regla
pkInstanceDataMgr.GetCG_BillPeriodRecord(rcperifact);
pkg_traza.trace('Periodo Consumo: ' || rcperifact.pefacodi,pkg_traza.cnuNivelTrzDef);

--Instanciar concepto utilizado en la regla
pkInstanceDataMgr.getcg_concept(nuConcepto);
pkg_traza.trace('Concepto: ' || nuConcepto, pkg_traza.cnuNivelTrzDef);

-- Obtiene valor base del calculo del impuesto en la liq del servicio de OPEN
nuValorBAse := FA_BOServiciosLiqPorProducto.fnuGetTotLiqBaseConc(pktblservsusc.frcgetrecord(rcServSusc.SESUNUSE),
                                                                 rcperifact,
                                                                 nuConcepto,
                                                                 1 --Suma algebraica
                                                                 );

--Instanaciar orden a legalizar
nuOrdenLegalizada := PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL(); -- Obtenemos la orden que se esta legalizando

--Liquidacion Impuesto (IVA) con el Valor Base 
nuValor := LIQTAXBASEVALUE(NULL, 1, 'N');

