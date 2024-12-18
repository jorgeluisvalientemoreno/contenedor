create or replace PROCEDURE adm_person.ldc_valida_dato_adi_med_adic IS
  /***********************************************************************************************************
  Propiedad Intelectual de Gases del Caribe S.A E.S.P

   Funcion     : ldc_valida_dato_adi_med_adic
   Descripcion : Procedimiento que descuenta de la bodega del contratista medidor adicional
   Autor       : Luis Lopez
   Fecha       : 29-11-2017

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
   12/06/2018          LJLB                CA 200 1642  se adiciona calculo de costo promedio del material y
                                          adicion de registro en or_order_items

   27/11/2018          ELAL                CA 200-2272 se adiciona control de entrega para validar dato adicional o no
   24/04/2024          Adrianavg           OSF-2597: Se migra del esquema OPEN al esquema ADM_PERSON
  ************************************************************************************************************/
--Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
  CURSOR cuProducto(nucuorden NUMBER) is
  SELECT product_id, order_activity_id
  FROM or_order_activity
  WHERE order_id = nucuorden
  AND rownum   = 1;

  eexeptionerror  EXCEPTION;
  nuorden         or_order.order_id%TYPE;
  nuunitoper      or_order.operating_unit_id%TYPE;
  sbmensa         VARCHAR2(4000);
  nuCodierror     NUMBER;

  sbcertificado   ldc_certificados_oia.certificado%TYPE;
  nucodatributo   ge_attributes.attribute_id%TYPE;
  sbnombreatrib   ge_attributes.name_attribute%TYPE;
  nusw            NUMBER(1);
  nuproductocert  pr_product.product_id%TYPE;
  nuorganismoinsp or_operating_unit.operating_unit_id%TYPE;
  nuproductid     pr_product.product_id%TYPE;
  nuconta         NUMBER(4);
  nugrupoatrib    ld_parameter.numeric_value%TYPE;
  nuresultadoins  ldc_certificados_oia.resultado_inspeccion%TYPE;
  nuresultadoinc  ldc_certificados_oia.resultado_inspeccion%TYPE;
  nucausalorden   or_order.causal_id%TYPE;
  sbmedidor       ge_items_seriado.serie%TYPE;
  regItemSeriado    dage_items_seriado.styge_items_seriado;

  nuCosto         or_order_items.VALUE%TYPE;
  sbdatos         VARCHAR2(1);

  CURSOR cuItemSeriado IS
  SELECT ID_ITEMS_SERIADO
  FROM open.ge_items_seriado si
  WHERE TRIM(si.serie)       = TRIM(sbmedidor)
    AND si.operating_unit_id = nuunitoper
     AND si.id_items_estado_inv = 1;

  --Se consulta si existe existencia del medidor
  CURSOR cuExistencia(nuunidaope number, nuitem number) IS
  SELECT 'X'
  FROM OPEN.or_ope_uni_item_bala
  WHERE operating_unit_id = nuunidaope
   AND ITEMS_ID = nuitem
   AND BALANCE > 0;

  --se consulta costo promedio de la bodega
  CURSOR cuCostoProm(nuunidaope number, nuitem number) IS
  SELECT (TOTAL_COSTS / BALANCE) costo
  FROM OPEN.or_ope_uni_item_bala
  WHERE operating_unit_id = nuunidaope
   AND ITEMS_ID = nuitem;



  nuItemSeriado    GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%TYPE;
  sbmovetype      or_uni_item_bala_mov.movement_type%TYPE;
  nuuniitemmovid  or_uni_item_bala_mov.uni_item_bala_mov_id%TYPE;
  nuActividadId    or_order_activity.order_activity_id%TYPE;

  csbOSS_AML_ELAL_2002274_1   CONSTANT VARCHAR2(50) := 'OSS_AML_ELAL_2002274_1';--se almacena constante de entrega

  PROCEDURE PROPROCESAITEMSERIA(inuOrden     IN OR_ORDER.ORDER_ID%TYPE,
                                 Inuproductid IN servsusc.sesunuse%type,
                                 regItemSeriado IN OUT DAGE_ITEMS_SERIADO.STYGE_ITEMS_SERIADO) IS

    nuOrdenItem   OR_ORDER_ITEMS.ORDER_ITEMS_ID%TYPE;
    nuItemRecovery GE_ITEMS.RECOVERY_ITEM_ID%TYPE;
    sbmensa VARCHAR2(4000);
  BEGIN
       nuItemRecovery := DAGE_ITEMS.FNUGETRECOVERY_ITEM_ID(regItemSeriado.ITEMS_ID, 0);
       IF (nuItemRecovery IS NOT NULL) THEN
              nuOrdenItem := OR_BCORDERITEMS.FNUGETORDITEBYORDSER(inuOrden,regItemSeriado.ID_ITEMS_SERIADO);
              DAOR_ORDER_ITEMS.UPDITEMS_ID(nuOrdenItem, nuItemRecovery);
              regItemSeriado.ITEMS_ID := nuItemRecovery;
              DAGE_ITEMS_SERIADO.UPDITEMS_ID(regItemSeriado.ID_ITEMS_SERIADO, nuItemRecovery);
       END IF;
		   DAGE_ITEMS_SERIADO.UPDID_ITEMS_ESTADO_INV(regItemSeriado.ID_ITEMS_SERIADO, 5);
       DAGE_ITEMS_SERIADO.UPDNUMERO_SERVICIO( regItemSeriado.ID_ITEMS_SERIADO,inuproductid);

  EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         sbmensa := 'Proceso termino con Errores. '||SQLERRM;
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
          ERRORS.SETERROR;
          RAISE EX.CONTROLLED_ERROR;
  END PROPROCESAITEMSERIA;

BEGIN
   --Obtener el identificador de la orden  que se encuentra en la instancia
   nuorden := or_bolegalizeorder.fnuGetCurrentOrder;

   --Obtener producto de la orden
   open cuProducto(nuorden);
   fetch cuProducto into nuproductid, nuActividadId;
   close cuProducto;


   -- Obtenemos la unidad operativa
   BEGIN
    SELECT ot.operating_unit_id INTO nuunitoper
      FROM open.or_order ot
     WHERE ot.order_id = nuorden
       AND ot.operating_unit_id IS NOT NULL;
   EXCEPTION
    WHEN no_data_found THEN
     sbmensa := 'Proceso termino con errores, la orden de trabajo :'||to_char(nuorden)||' no existe o no tiene unidad operativa asignada.';
     ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
     RAISE ex.controlled_error;
   END;
   -- Obtenemos el valor del certificado del dato adicional
   nucodatributo := dald_parameter.fnuGetNumeric_Value('LDC_CODDATADICVMD',NULL);
   IF nucodatributo IS NULL THEN
     sbmensa := 'Proceso termino con errores, se debe configurar valor al parametro LDC_CODDATADICVMD, codigo dato adicional medidor adicional.';
     ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
     RAISE ex.controlled_error;
   END IF;
   sbnombreatrib := dald_parameter.fsbGetValue_Chain('NOMBRE_ATRIBU_VAL_CERTI');
   IF sbnombreatrib IS NULL THEN
     sbmensa := 'Proceso termino con errores, se debe configurar valor al parametro NOMBRE_ATRIBU_VAL_CERTI, nombre dato adicional del certificado.';
     ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
     RAISE ex.controlled_error;
   END IF;
   nugrupoatrib := dald_parameter.fnuGetNumeric_Value('LDC_GRUDAVMD',NULL);
   IF sbnombreatrib IS NULL THEN
     sbmensa := 'Proceso termino con errores, se debe configurar valor al parametro LDC_GRUDAVMD, grupo del dato adicional medidor adicional.';
     ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
     RAISE ex.controlled_error;
   END IF;
   sbmedidor := ldc_boordenes.fsbDatoAdicTmpOrden(nuorden,nucodatributo,TRIM(sbnombreatrib));

   --TICKET 200-2274 ELAL -- se valida si aplica la entrega
   IF fblAplicaEntrega(csbOSS_AML_ELAL_2002274_1) THEN
      IF sbmedidor IS NULL THEN
         RETURN;
      END IF;
   END IF;

   -- Consultamos existencia del medidor y la unidad operativa
   nuproductocert  := NULL;
   nuorganismoinsp := NULL;
   nuresultadoins  := NULL;
   nusw            := 1;
   BEGIN
     OPEN cuItemSeriado;
     FETCH cuItemSeriado INTO nuItemSeriado;
     IF cuItemSeriado%NOTFOUND THEN
          nusw            := 0;
     END IF;
     CLOSE cuItemSeriado;
   EXCEPTION
    WHEN no_data_found THEN
     nusw            := 0;
     nuproductocert  := NULL;
     nuorganismoinsp := NULL;
     nuresultadoins  := NULL;
   END;
   IF nusw = 0 THEN
    sbmensa := 'Proceso termino con errores, el codigo del serial  : '||TRIM(sbmedidor)||' no pertenece a la cuadrilla: '||nuunitoper||' o no esta disponible';
    ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
    RAISE ex.controlled_error;
   ELSE
   --se carga registro de item seriado
   DAGE_ITEMS_SERIADO.GETRECORD(nuItemSeriado, regItemSeriado);

  -- se valida existencia del item en bodega
   OPEN cuExistencia(nuunitoper, regItemSeriado.items_id );
   FETCH cuExistencia INTO sbdatos;
   IF cuExistencia%NOTFOUND THEN
      CLOSE cuExistencia;
      sbmensa := 'Proceso termino con Errores, El items['||regItemSeriado.items_id||'-'||dage_items.fsbgetdescription(regItemSeriado.items_id, null) ||'] no tiene existencia en bodega para la Unidad Operativa['||nuunitoper||'-'||daor_operating_unit.fsbgetname(nuunitoper, null)||']';
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
      errors.seterror;
      RAISE ex.controlled_error;
   END IF;
   CLOSE cuExistencia;

   --se carga costo promedio de la orden
   OPEN cuCostoProm(nuunitoper, regItemSeriado.items_id);
   FETCH cuCostoProm INTO nuCosto;
   CLOSE cuCostoProm;


   sbmovetype := or_boitemsmove.CSBDECREASEMOVETYPE;

   --se crea moviniento en bodega de tipo disminucion
   or_boitemsmove.createmovbylegalize(
                                      nuorden,
                                      regItemSeriado.operating_unit_id,
                                      regItemSeriado.items_id,
                                      regItemSeriado,
                                      sbmovetype,
                                      1,
                                      nuCosto,
                                      nuuniitemmovid
                                      );

      --se cambia el item siempre y cuando el item sea de propiedad de la empresa
     PROPROCESAITEMSERIA(nuorden, nuproductid, regItemSeriado);

     --se regitra item a la orden
      insert into or_order_items ( order_id,
                                   items_id,
                                   assigned_item_amount,
                                   legal_item_amount,
                                   value,
                                   order_items_id,
                                   total_price,
                                   element_code,
                                   order_activity_id,
                                   element_id,
                                   reused,
                                   serial_items_id,
                                   serie,
                                   out_)

                      values
                        (nuorden,
                         regItemSeriado.items_id,
                         1,
                         1,
                         nuCosto,
                         seq_or_order_items.nextval,
                         0,
                         null,
                         nuActividadId,
                         null,
                         null,
                         regItemSeriado.ID_ITEMS_SERIADO,
                         regItemSeriado.SERIE,
                         'Y');

    END IF;
EXCEPTION
 WHEN ex.controlled_error THEN
  RAISE;
 WHEN OTHERS THEN
  sbmensa := 'Proceso termino con Errores. '||SQLERRM;
  ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
  errors.seterror;
  RAISE ex.controlled_error;
END LDC_VALIDA_DATO_ADI_MED_ADIC;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDC_VALIDA_DATO_ADI_MED_ADIC
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_VALIDA_DATO_ADI_MED_ADIC', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REXEREPORTES sobre funcion LDC_VALIDA_DATO_ADI_MED_ADIC
GRANT EXECUTE ON ADM_PERSON.LDC_VALIDA_DATO_ADI_MED_ADIC TO REXEREPORTES;
/