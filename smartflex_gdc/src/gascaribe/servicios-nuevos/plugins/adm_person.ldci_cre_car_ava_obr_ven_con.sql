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
  Fecha             Autor         Modificacion
  =========       =========       ====================
  19-04-2024      Adrianavg   OSF-2569: Se migra del esquema OPEN al esquema ADM_PERSON
  21-08-2024      Aarroyo       VEN-916: Se elimina la creación de cargos del IVA
  10-01-2025    jerazomvm   OSF-3766: Se agrega el parametro INUCARGVABL  => null,
                        en el llamado del proceso de generación de cargos
   13/03/2025     Jorge Valiente   OSF-4096: Nuevo cursor llamado cuTipTraConcepto para recorrer la 
                                             configuracion de tt x concepto definida en el 
                                             parametro CONCXTITR_AVANCE_OBRA_CONS y validar si debe 
                                             generar cargo con el valor definido en la venta cotizada
 ******************************************************************/
  
  --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)  := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)     := pkg_traza.cnuNivelTrzDef; 
    csbInicio          CONSTANT VARCHAR2(35)  := pkg_traza.csbINICIO;   
  
  nuErrorCode     NUMBER;
  sbMensajeError  VARCHAR2(4000);
  
  packageId           NUMBER;
  productId           NUMBER;
  packageTypeId       NUMBER;
  ignoreChargeComment NUMBER;

  quotationItemId NUMBER;
  nuConccodi    NUMBER;
  unitValue       NUMBER;
  unitTaxValue    NUMBER;

  orderId    NUMBER;
  taskTypeId NUMBER;

  --CASO OSF-4096
  CURSOR cuTipTraConcepto(sbCADENA VARCHAR2) IS
    WITH datos AS
     (SELECT (regexp_substr(sbCADENA, '[^;]+', 1, LEVEL)) AS cadena
        FROM dual
      CONNECT BY regexp_substr(sbCADENA, '[^;]+', 1, LEVEL) IS NOT NULL)
    SELECT substr(cadena, 1, instr(cadena, '|') - 1) tipo_trabajo,
           substr(cadena, instr(cadena, '|') + 1, LENGTH(cadena)) concepto
      FROM datos;

  rfTipTraConcepto cuTipTraConcepto%ROWTYPE;

  sbCONCXTITR_AVANCE_OBRA_CONS VARCHAR2(4000);
  ----OSF-4096

BEGIN

  pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);

  orderId := pkg_bcordenes.fnuObtenerOTInstanciaLegal;
  pkg_traza.trace('orderId: ' || orderId, csbNivelTraza); 

  SELECT PACKAGE_ID, TASK_TYPE_ID
    into packageId, taskTypeId
    FROM OR_ORDER_ACTIVITY
  WHERE ORDER_ID = orderId
    AND ROWNUM = 1;
  
  pkg_traza.trace('packageId: '   || packageId || chr(10) ||
          'taskTypeId: '  || taskTypeId, csbNivelTraza); 

  IF packageId IS NULL THEN
    RETURN;
  END IF;

  SELECT PACKAGE_TYPE_ID
  INTO packageTypeId
  FROM MO_PACKAGES
  WHERE PACKAGE_ID = packageId;
  
  pkg_traza.trace('packageTypeId: ' || packageTypeId, csbNivelTraza); 

  IF packageTypeId NOT IN (323) THEN
    RETURN;
  END IF;

  SELECT COUNT(1)
  INTO ignoreChargeComment
  FROM MO_COMMENT mc
  WHERE mc.PACKAGE_ID = packageId
  AND mc.COMMENT_TYPE_ID = 2
  AND mc.COMMENT_ = 'IGNORAR CARGOS AVANCE OBRA';
  
  pkg_traza.trace('ignoreChargeComment: ' || ignoreChargeComment, csbNivelTraza); 

  IF ignoreChargeComment > 0 THEN
    RETURN;
  END IF;

  SELECT PRODUCT_ID
  INTO productId
  FROM MO_MOTIVE mm
  WHERE mm.PACKAGE_ID = packageId
  AND mm.PRODUCT_TYPE_ID = 6121 -- tipo producto contrato padre
  AND ROWNUM = 1;
  
  pkg_traza.trace('productId: ' || productId, csbNivelTraza); 

  BEGIN
    SELECT QI.QUOTATION_ITEM_ID, QI.UNIT_VALUE, QI.UNIT_TAX_VALUE
    INTO quotationItemId, unitValue, unitTaxValue
    FROM CC_QUOTATION Q
    LEFT JOIN CC_QUOTATION_ITEM QI
        ON QI.QUOTATION_ID = Q.QUOTATION_ID
    WHERE Q.PACKAGE_ID = packageId
    AND Q.STATUS IN ('A', 'C')
    AND QI.TASK_TYPE_ID = taskTypeId
    AND QI.REMAINING_ITEMS > 0
    FOR UPDATE;
    
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                                      'No se encontraron datos disponibles en la cotizaci?n constructora');

    RETURN;
  END;

  UPDATE CC_QUOTATION_ITEM
    SET REMAINING_ITEMS = REMAINING_ITEMS - 1
  WHERE QUOTATION_ITEM_ID = quotationItemId;

  pkg_error.setApplication('CUSTOMER');

  --OSF-4096  
  -- Obtener cadena del parametro CONCXTITR_AVANCE_OBRA_CONS
  sbCONCXTITR_AVANCE_OBRA_CONS := pkg_parametros.fsbGetValorCadena('CONCXTITR_AVANCE_OBRA_CONS');
  pkg_traza.trace('CONCXTITR_AVANCE_OBRA_CONS: ' ||
                  sbCONCXTITR_AVANCE_OBRA_CONS,
                  csbNivelTraza);

  IF sbCONCXTITR_AVANCE_OBRA_CONS IS NULL THEN
    pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                              'No se encontraron datos disponibles en el parametro CONCXTITR_AVANCE_OBRA_CONS');
  END IF;

  ---Inicializa concepto con NULL
  nuConccodi := NULL;
  --Recorrer la cadena configurada en el parametro para validar el tipo de trabajo legalizado
  FOR rfTipTraConcepto in cuTipTraConcepto(sbCONCXTITR_AVANCE_OBRA_CONS) LOOP
    IF taskTypeId = TO_NUMBER(rfTipTraConcepto.tipo_trabajo) THEN
      pkg_traza.trace('Tipo trabajo: ' || rfTipTraConcepto.tipo_trabajo,
                      csbNivelTraza);
      nuConccodi := TO_NUMBER(rfTipTraConcepto.concepto);
    END IF;
  END LOOP;

  ---Si el concepto es NULL el tipo de trabajo legalizado no esta configurado en el parametro. 
  IF nuConccodi IS NULL THEN
    pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                              'El tipo de trabajo [' || taskTypeId ||
                              '] de la orden legalizada no esta configurado en el parámetro CONCXTITR_AVANCE_OBRA_CONS');
  END IF;
  
  pkg_traza.trace('nuConccodi: ' || nuConccodi, csbNivelTraza);

  pkg_traza.trace('Valor Concepto: ' || unitValue, csbNivelTraza);
  --Solo genera cargo si el valor del cargo a genera en mayor a 0
  IF NVL(unitValue, 0) > 0 THEN 
  -- Genera cargos
  pkg_traza.trace('Genera cargos PKCHARGEMGR.GENERATECHARGE', csbNivelTraza);
  PKCHARGEMGR.GENERATECHARGE(INUNUMESERV  => productId,
                               INUCUCOCODI  => -1,
                               INUCONCCODI  => nuConccodi,
                               INUCAUSCARG  => 53,
                               IONUCARGVALO => unitValue,
                 INUCARGVABL  => null,
                               ISBCARGSIGN  => 'DB',
                               ISBCARGDOSO  => 'PP-' || packageId,
                               ISBCARGTIPR  => 'A',
                               INUCARGCODO  => orderId,
                               INUCARGUNID  => 1,
                               INUCARGCOLL  => null,
                               INUSESUCARG  => null,
                               IBOKEEPTIPR  => true,
                               IDTCARGFECR  => sysdate
                 );
  
  pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  END IF;

EXCEPTION
  WHEN pkg_error.CONTROLLED_ERROR THEN
    pkg_error.setError;
    pkg_Error.getError(nuErrorCode, sbMensajeError);
    pkg_traza.trace('nuErrorCode: ' || nuErrorCode || ' sbMensajeError: ' || sbMensajeError, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC); 
    RAISE pkg_error.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuErrorCode, sbMensajeError);
    pkg_traza.trace('nuErrorCode: ' || nuErrorCode || ' sbMensajeError: ' || sbMensajeError, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
    RAISE pkg_Error.Controlled_Error; 
END LDCI_CRE_CAR_AVA_OBR_VEN_CON;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO LDCI_CRE_CAR_AVA_OBR_VEN_CON
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_CRE_CAR_AVA_OBR_VEN_CON', 'ADM_PERSON');
END;
/