create or replace PROCEDURE adm_person.ldc_valperc_ordcargoconec AS
    /**************************************************************************
    Propiedad Intelectual de HORBATH TECHNOLOGIES

    Funcion     :  LDC_VALPERC_ORDCARGOCONEC
    Descripcion :  Validar que las órdenes 12150, 12152 y 12153, al intentar legalizarlas, el periodo de consumo se encuentre activo.
                  1.1. Se validara que en la tabla PERICOSE hay un registro para el ciclo del producto cuya fecha final sea mayor a la
                  fecha de legalización de la Orden que se estará legalizando
                  1.2. Se validara que en la tabla de PERIFACT haya un periodo de facturación para el ciclo del producto con periodo actual en S.

    Autor       : Josh Brito
    Fecha       : 24-02-2018

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    24-02-2018          Josh Brito         Creación
    24/04/2024          Adrianavg          OSF-2597: Se migra del esquema OPEN al esquema ADM_PERSON
    **************************************************************************/
    nuOrderId           OR_ORDER.ORDER_ID%type;-- := 20913139;
    nuOrderActivityId   OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%type;
    nuProductId         PR_PRODUCT.PRODUCT_ID%type;
    nuCICLO             NUMBER;
    nuPERIODO           NUMBER;
    sbmensamen          VARCHAR2(4000);

  CURSOR cuCICLO(idORDEN OR_ORDER.ORDER_ID%type) IS
  SELECT PC.PECSCICO
  FROM OR_ORDER_ACTIVITY OA, SERVSUSC V, PERICOSE PC
  WHERE OA.PRODUCT_ID = V.SESUNUSE
  AND V.SESUCICL = PC.PECSCICO
  AND OA.ORDER_ID = idORDEN
  AND PC.PECSFECF > SYSDATE
  GROUP BY PC.PECSCICO;
BEGIN
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('LDC_VALPERC_ORDCARGOCONEC-nuOrderId -->'||nuOrderId, 10);

    nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
    ut_trace.trace('LDC_GENEVERPREFIN-nuOrderActivityId -->'||nuOrderActivityId, 10);

    nuProductId := daor_order_activity.fnugetproduct_id(nuOrderActivityId);
    ut_trace.trace('LDC_GENEVERPREFIN-nuProductId -->'||nuProductId, 10);

   --VALIDA QUE EL PRODUCTO TENGA UN CLICO HABILITADO
    open cuCICLO(nuOrderId);
        fetch cuCICLO into nuCICLO;
        IF cuCICLO%NOTFOUND THEN
            nuCICLO := NULL;
        END IF;
    close cuCICLO;
    ut_trace.trace('LDC_VALPERC_ORDCARGOCONEC - En ejecucion -->'||nuCICLO, 10);

  IF nuCICLO IS NULL THEN
    sbmensamen := 'El ciclo del producto:['||nuProductId||'] correspondiente a la orden:['||nuOrderId||'], no tiene vigencia habilitada.';
    ut_trace.trace('LDC_VALPERC_ORDCARGOCONEC-->'||sbmensamen, 10);
    ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
    RAISE ex.controlled_error;
  ELSE

    --VALIDA PERIODO DE FACTURACION ACTIVO
    SELECT COUNT(1) INTO nuPERIODO
    FROM PERIFACT PF
    WHERE SYSDATE between PF.PEFAFIMO AND PF.PEFAFFMO
    AND PF.PEFACICL = nuCICLO -- PECSCICO
    AND PF.PEFAACTU = 'S';
    --AND PF.PEFAANO = EXTRACT(YEAR FROM sysdate)
    --AND PF.PEFAMES = EXTRACT(MONTH FROM sysdate);

    IF nuPERIODO = 0 THEN
      sbmensamen := 'La orden:['||nuOrderId||'], no tiene un Periodo de facturacion activo para el ciclo:['||nuCICLO||'] del producto:['||nuProductId||'].';
      ut_trace.trace('LDC_VALPERC_ORDCARGOCONEC-->'||sbmensamen, 10);
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
      RAISE ex.controlled_error;
    END IF;

  END IF;
  ut_trace.trace('FINALIZA - LDC_VALPERC_ORDCARGOCONEC', 10);

EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

END LDC_VALPERC_ORDCARGOCONEC;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDC_VALPERC_ORDCARGOCONEC
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_VALPERC_ORDCARGOCONEC', 'ADM_PERSON'); 
END;
/