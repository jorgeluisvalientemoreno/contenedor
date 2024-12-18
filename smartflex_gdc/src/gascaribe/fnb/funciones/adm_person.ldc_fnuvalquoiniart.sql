CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUVALQUOINIART" (inPackage OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE,
                                               inArticle LD_ITEM_WORK_ORDER.ARTICLE_ID%TYPE)
  RETURN NUMBER IS
  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : LDC_FNUVALQUOINIART
  Descripcion : Funcion que retorna el valor de la cuota inicial para cada articulo.
                Se calcula en base a las politicas del paquete (LD_BOFLOWFNBPACK.CreateDelivOrderCharg)
  Autor       : Sebastian Tapias
  Fecha       : 22-09-2017

  Historia de Modificaciones

    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  -------------------------------------
  ----Variables
  -------------------------------------
  v_Return      NUMBER := 0;
  nuPackage     NUMBER := inPackage;
  nuArticle     NUMBER := inArticle;
  nuCuotaInical NUMBER := 0;
  nuValorTotal  NUMBER := 0;
  nuMotive      NUMBER := null;
  nuProduct     NUMBER := null;
  nuValorArtic  NUMBER := 0;
  nuProportion  NUMBER := 0;
  nuvvalaboprov NUMBER := 0;
  nuChargeValue NUMBER := 0;
  nuValorfinan  NUMBER := 0;
  nuValorcondes NUMBER := 0;
  nuCuota       NUMBER := 0;
  nuValue       NUMBER := 0;
  nuTotal       NUMBER := 0;
  cnuDelivActiv constant ld_parameter.numeric_value%type := Dald_parameter.fnuGetNumeric_Value('ACTIVITY_TYPE_FNB');
  -------------------------------------
  ----Cursores
  -------------------------------------
  --Cursor para obtener el valor total de venta
  CURSOR cuValTotaVen(inuPackage    mo_packages.package_id%type,
                      inuDelivActiv or_order_activity.activity_id%type) IS
    SELECT nvl(SUM(w.amount * w.value), 0) + nvl(SUM(w.iva), 0) valor
      FROM ld_item_work_order w, or_order_activity oa
     WHERE oa.package_id = inuPackage
       AND oa.activity_id = inuDelivActiv
       AND w.order_activity_id = oa.order_activity_id;
  --Cursor para obtener los articulos.
  CURSOR cuArtiVenta(inuPackage    mo_packages.package_id%type,
                     inuDelivActiv or_order_activity.activity_id%type) IS
    SELECT w.*
      FROM ld_item_work_order w, or_order_activity oa
     WHERE oa.package_id = inuPackage
       AND oa.activity_id = inuDelivActiv
       AND w.order_activity_id = oa.order_activity_id;
  rfc_Ariculos cuArtiVenta%rowtype;
BEGIN
  BEGIN
    --Obtiene el motivo asociado a la solicitud
    nuMotive  := mo_bopackages.fnugetinitialmotive(nuPackage);
    --Obtiene el producto asociado al motivo
    nuProduct := damo_motive.fnuGetProduct_Id(nuMotive);
    --Obtiene el valor de la venta
    OPEN cuValTotaVen(nuPackage, cnuDelivActiv);
    FETCH cuValTotaVen
      INTO nuValorTotal;
    CLOSE cuValTotaVen;
    --Identifica el valor de la cuota inicial dada en la solicitud de venta
    nuCuotaInical := NVL(DALD_NON_BA_FI_REQU.fnuGetPayment(nuPackage), 0);
    nuValorfinan  := nuValorTotal - nuCuotaInical;
    FOR rfc_Ariculos IN cuArtiVenta(nuPackage, cnuDelivActiv) LOOP
      --Identifica el valor de venta del articulo + el iva
      nuValorArtic  := (rfc_Ariculos.value + rfc_Ariculos.iva);
      nuProportion  := nuValorArtic / nuValorTotal;
      --Calcula la proporcion del abono que le corresponde al articulo
      nuvvalaboprov := round(nuCuotaInical * nuProportion, 2);
      --Aplica politica de redondeo para valor proporcional de este articulo
      if (nvl(nuvvalaboprov, pkBillConst.CERO) != pkBillConst.CERO) then
        FA_BOPoliticaRedondeo.AplicaPolitica(nuProduct, nuvvalaboprov);
      END if;
      --Se le disminuye al total de la venta el articulo
      nuValorTotal := nuValorTotal - nuValorArtic;
      --Aplica politica de redondeo para valor del articulo
      if (nvl(nuValorArtic, pkBillConst.CERO) != pkBillConst.CERO) then
        FA_BOPoliticaRedondeo.AplicaPolitica(nuProduct, nuValorArtic);
      END if;
      --Se Aplica el abono
      if (nvl(nuCuotaInical, 0) > 0) then
        nuChargeValue := nuValorArtic - nuvvalaboprov;
      else
        nuChargeValue := nuValorArtic;
      END if;
      --Se le disminuye al valor del abono el valor aplicado
      nuCuotaInical := nuCuotaInical - nuvvalaboprov;
      nuValorcondes := nuValorcondes + nuChargeValue;
      --Se asigna la cuota correspondiente al articulo ingresado
      if (nuArticle = rfc_Ariculos.article_id) then
        nuCuota := nuvvalaboprov;
        nuValue := nuValorArtic;
      end if;
    END LOOP;
    nuTotal := nuValue - nuCuota;
    dbms_output.put_line('Articulo [' || nuArticle || ']');
    dbms_output.put_line('Valor del articulo + iva [' || nuValue || ']');
    dbms_output.put_line('Valor a descontar x cuota inicial [' || nuCuota || ']');
    dbms_output.put_line('Valor final del articulo [' || nuTotal || ']');
    v_Return := nuCuota;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_Return := 0;
  END;
  RETURN v_Return;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 0;
END LDC_FNUVALQUOINIART;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUVALQUOINIART', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON LDC_FNUVALQUOINIART TO REPORTES;
/