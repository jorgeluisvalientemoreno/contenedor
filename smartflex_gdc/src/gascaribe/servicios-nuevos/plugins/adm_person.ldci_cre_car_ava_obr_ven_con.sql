create or replace PROCEDURE adm_person.ldci_cre_car_ava_obr_ven_con IS
/*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDCI_CRE_CAR_AVA_OBR_VEN_CON
  Descripcion    :

  Autor          :
  Fecha          :

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  19-04-2024	  Adrianavg		      OSF-2569: Se migra del esquema OPEN al esquema ADM_PERSON
  21-08-2024	  Aarroyo		        VEN-916: Se elimina la creación de cargos del IVA
  ******************************************************************/
  packageId           NUMBER;
  productId           NUMBER;
  packageTypeId       NUMBER;
  ignoreChargeComment NUMBER;

  quotationItemId NUMBER;
  unitValue       NUMBER;
  unitTaxValue    NUMBER;

  orderId    NUMBER;
  taskTypeId NUMBER;

BEGIN

  orderId := "OPEN".or_bolegalizeorder.fnuGetCurrentOrder;

  SELECT PACKAGE_ID, TASK_TYPE_ID
    into packageId, taskTypeId
    FROM OPEN.OR_ORDER_ACTIVITY
   WHERE ORDER_ID = orderId
    AND ROWNUM = 1;

  IF packageId IS NULL THEN
    RETURN;
  END IF;

  SELECT PACKAGE_TYPE_ID
  INTO packageTypeId
  FROM OPEN.MO_PACKAGES
  WHERE PACKAGE_ID = packageId;

  IF packageTypeId NOT IN (323) THEN
    RETURN;
  END IF;

  SELECT COUNT(1)
  INTO ignoreChargeComment
  FROM OPEN.MO_COMMENT mc
  WHERE mc.PACKAGE_ID = packageId
  AND mc.COMMENT_TYPE_ID = 2
  AND mc.COMMENT_ = 'IGNORAR CARGOS AVANCE OBRA'
  ;

  IF ignoreChargeComment > 0 THEN
    RETURN;
  END IF;

  SELECT PRODUCT_ID
  INTO productId
  FROM OPEN.MO_MOTIVE mm
  WHERE mm.PACKAGE_ID = packageId
  AND mm.PRODUCT_TYPE_ID = 6121 -- tipo producto contrato padre
  AND ROWNUM = 1;

  BEGIN
    SELECT QI.QUOTATION_ITEM_ID, QI.UNIT_VALUE, QI.UNIT_TAX_VALUE
      INTO quotationItemId, unitValue, unitTaxValue
      FROM OPEN.CC_QUOTATION Q
      LEFT JOIN OPEN.CC_QUOTATION_ITEM QI
        ON QI.QUOTATION_ID = Q.QUOTATION_ID
     WHERE Q.PACKAGE_ID = packageId
       AND Q.STATUS IN ('A', 'C')
       AND QI.TASK_TYPE_ID = taskTypeId
       AND QI.REMAINING_ITEMS > 0
       FOR UPDATE;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      "OPEN".ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                              'No se encontraron datos disponibles en la cotizaci?n constructora');

      RETURN;
  END;

  UPDATE OPEN.CC_QUOTATION_ITEM
     SET REMAINING_ITEMS = REMAINING_ITEMS - 1
   WHERE QUOTATION_ITEM_ID = quotationItemId;

  "OPEN".PKERRORS.SETAPPLICATION('CUSTOMER');

  -- Generate charges
  IF (taskTypeId = 12149) THEN
    "OPEN".PKCHARGEMGR.GENERATECHARGE(INUNUMESERV  => productId,
                                      INUCUCOCODI  => -1,
                                      INUCONCCODI  => 30,
                                      INUCAUSCARG  => 53,
                                      IONUCARGVALO => unitValue,
                                      ISBCARGSIGN  => 'DB',
                                      ISBCARGDOSO  => 'PP-' || packageId,
                                      ISBCARGTIPR  => 'A',
                                      INUCARGCODO  => orderId,
                                      INUCARGUNID  => 1,
                                      INUCARGCOLL  => null,
                                      INUSESUCARG  => null,
                                      IBOKEEPTIPR  => true,
                                      IDTCARGFECR  => sysdate);
  ELSIF (taskTypeId = 12162) THEN
    "OPEN".PKCHARGEMGR.GENERATECHARGE(INUNUMESERV  => productId,
                                      INUCUCOCODI  => -1,
                                      INUCONCCODI  => 674,
                                      INUCAUSCARG  => 53,
                                      IONUCARGVALO => unitValue,
                                      ISBCARGSIGN  => 'DB',
                                      ISBCARGDOSO  => 'PP-' || packageId,
                                      ISBCARGTIPR  => 'A',
                                      INUCARGCODO  => orderId,
                                      INUCARGUNID  => 1,
                                      INUCARGCOLL  => null,
                                      INUSESUCARG  => null,
                                      IBOKEEPTIPR  => true,
                                      IDTCARGFECR  => sysdate);
  ELSIF (taskTypeId = 12150) THEN
    "OPEN".PKCHARGEMGR.GENERATECHARGE(INUNUMESERV  => productId,
                                      INUCUCOCODI  => -1,
                                      INUCONCCODI  => 19,
                                      INUCAUSCARG  => 53,
                                      IONUCARGVALO => unitValue,
                                      ISBCARGSIGN  => 'DB',
                                      ISBCARGDOSO  => 'PP-' || packageId,
                                      ISBCARGTIPR  => 'A',
                                      INUCARGCODO  => orderId,
                                      INUCARGUNID  => 1,
                                      INUCARGCOLL  => null,
                                      INUSESUCARG  => null,
                                      IBOKEEPTIPR  => true,
                                      IDTCARGFECR  => sysdate);
  END IF;
EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE;
  WHEN OTHERS THEN
    ERRORS.SETERROR();
    RAISE EX.CONTROLLED_ERROR;
END LDCI_CRE_CAR_AVA_OBR_VEN_CON;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO LDCI_CRE_CAR_AVA_OBR_VEN_CON
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_CRE_CAR_AVA_OBR_VEN_CON', 'ADM_PERSON');
END;
/