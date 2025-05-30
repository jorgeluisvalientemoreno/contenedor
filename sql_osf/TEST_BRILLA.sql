DECLARE
  type array_t is varray(saleDetailsArrayLength) of number;
  saleDetailIds            NUMBER:=6302895;--array_t := array_t(saleDetailIds);
  chargeValueArray         NUMBER:=180000;--array_t := array_t(chargeValues);
  conceptIdArray           NUMBER:=936;--array_t := array_t(conceptIds);
  orderActivityIdArray     NUMBER:=null;--array_t := array_t(orderActivityIds);
  planIdArray              NUMBER:=86;--array_t := array_t(planIds);
  planMethodArray          NUMBER:=4;--array_t := array_t(planMethods);
  numInstalmentsArray      NUMBER:=12;--array_t := array_t(numInstalments);
  BILL_ID                  NUMBER;
  SUPPORT_DOCUMENT         varchar2(30);
  EXACT_DEFERRED_ID        NUMBER;
  nuDifeCofi               NUMBER;
  onuAcumCuota             NUMBER;
  onuSaldo                 NUMBER;
  onuTotalAcumCapital      NUMBER;
  onuTotalAcumCuotExtr     NUMBER;
  onuTotalAcumInteres      NUMBER;
  osbRequiereVisado        VARCHAR2(1);
  interestRate             NUMBER(11, 8);
  nuQuotaMethod            NUMBER(2);
  nuTaincodi               NUMBER(2);
  boSpread                 BOOLEAN;
  conccore                 NUMBER;
  cucosacu                 NUMBER;
  cucovato                 NUMBER;
  contract_id              NUMBER;
  initial_max_quota_pos    NUMBER;
  final_max_quota_pos      NUMBER;
  max_number_quota         NUMBER;
  grace_period_deffered_id OPEN.cc_grace_peri_defe.grace_peri_defe_id%TYPE;
  grace_period_end_date    OPEN.cc_grace_peri_defe.end_date%TYPE;
  nuDifecodi               NUMBER;

  GRACE_PER_DEFF_NOT_EXIST EXCEPTION;
  errorCode number;
  productId number:= 52897427;    
  packageId number:= 225416579; 
  isSecureSale number:= 0;   
  skipTimeRestrictionOnElectronicInvoice number := 1;
BEGIN
  errorCode := 0;

  SELECT subscription_id
    INTO contract_id
    FROM open.pr_product
   WHERE product_id = productId;

  -- Condición agregada para excluir contratos del control de horario para facturar
  IF :skipTimeRestrictionOnElectronicInvoice = 1 THEN
    INSERT INTO OPEN.omitir_factura_temp
      (idcontrato, condicion)
    VALUES
      (contract_id, 'Y');
  END IF;

  /*for i in 1 .. conceptIdArray.count loop
    "OPEN".pkerrors.setapplication('CUSTOMER');
    "OPEN".pkChargeMgr.GenerateCharge(productId,
                                      -1,
                                      conceptIdArray(i),
                                      19,
                                      chargeValueArray(i),
                                      'DB',
                                      'PP-' || &packageId,
                                      'A',
                                      null,
                                      null,
                                      null,
                                      null,
                                      true,
                                      sysdate);
  end loop;

  "OPEN".pkerrors.setapplication('CUSTOMER');
  "OPEN".cc_boaccounts.GenerateAccountByPack(:packageId);

  SELECT cargcuco
    INTO BILL_ID
    FROM (select *
            from OPEN.cargos
           WHERE cargdoso = 'PP-' || :packageId
             AND cargnuse = :productId
             AND cargcuco <> -1
           ORDER BY cargfecr desc, cargcuco desc)
   WHERE ROWNUM = 1;

  for i in 1 .. conceptIdArray.count loop
    SELECT ITEM_WORK_ORDER_ID
      INTO SUPPORT_DOCUMENT
      FROM OPEN.LD_ITEM_WORK_ORDER
     WHERE ORDER_ACTIVITY_ID = orderActivityIdArray(i)
       AND STATE = 'RE';
  
    "OPEN".pkerrors.setapplication('CUSTOMER');
  
    SELECT cucosacu, cucovato
      INTO cucosacu, cucovato
      FROM open.cuencobr
     WHERE cucocodi = BILL_ID;
  
    SELECT conccore
      INTO conccore
      FROM open.concepto
     WHERE conccodi = conceptIdArray(i);
  
    "OPEN".pkDeferredMgr.nuGetNextFincCode(nuDifeCofi);
    "OPEN".cc_bcfinancing.ClearMemTables;
    "OPEN".CC_BOFinancing.ClearMemoryFinancing;
  
    -- Inicializa tabla de conceptos y colecciones
    "OPEN".cc_bcfinancing.clearBalByConcept;
  
    DELETE OPEN.cc_tmp_bal_by_conc;
  
    INSERT INTO OPEN.cc_tmp_bal_by_conc
      (tmp_bal_by_concept_id,
       selected,
       subscription_id,
       product_id,
       base_product_id,
       product_type_id,
       concept_id,
       deferrable,
       pending_balance,
       tax_pending_balance,
       financing_balance,
       tax_financing_balance,
       not_financing_balance,
       cancel_serv_estat_id,
       account_number,
       financing_concept_id,
       balance_account,
       amount_account_total,
       payment_date,
       expiration_date,
       company_id,
       is_interest_concept,
       discount_percentage)
    VALUES
      (1,
       'Y',
       contract_id,
       :productId,
       null,
       7055,
       conceptIdArray(i),
       'Y',
       chargeValueArray(i),
       0,
       chargeValueArray(i),
       0,
       0,
       null, -- sesuesco
       BILL_ID,
       conccore,
       cucosacu,
       cucovato,
       null,
       null,
       99,
       'N',
       0);
    "OPEN".pkGeneralServices.CommitTransaction;
    "OPEN".pkDeferredPlanMgr.ValPlanConfig(planIdArray(i), -- id plan diferido
                                           sysdate, -- fecha el sistema
                                           nuQuotaMethod, -- out: plandife.pldimccd%type
                                           nuTaincodi, -- out: plandife.plditain%type
                                           interestRate,
                                           boSpread);
    BEGIN
      "OPEN".CC_BOFinancing.ExecDebtFinanc(planIdArray(i),
                                           planMethodArray(i),
                                           SYSDATE + 1,
                                           interestRate,
                                           "OPEN".pkBillConst.CERO,
                                           numInstalmentsArray(i),
                                           SUPPORT_DOCUMENT,
                                           "OPEN".pkBillConst.CIENPORCIEN,
                                           "OPEN".pkBillConst.CERO,
                                           "OPEN".pkConstante.NO,
                                           "OPEN".cc_boconstants.csbCUSTOMERCARE,
                                           "OPEN".pkConstante.NO,
                                           "OPEN".pkConstante.NO,
                                           nuDifeCofi,
                                           onuAcumCuota,
                                           onuSaldo,
                                           onuTotalAcumCapital,
                                           onuTotalAcumCuotExtr,
                                           onuTotalAcumInteres,
                                           osbRequiereVisado,
                                           'Y');
    EXCEPTION
      when "OPEN".EX.CONTROLLED_ERROR THEN
        "OPEN".ERRORS.SETERROR;
        "OPEN".ERRORS.GETERROR(:errorCode, :errorMessage);
        IF :errorCode = 904722 and chargeValueArray(i) <= 1000 THEN
          initial_max_quota_pos := instr(:errorMessage, ' [') + 2;
          final_max_quota_pos   := instr(:errorMessage, ']. ');
          max_number_quota      := to_number(substr(:errorMessage,
                                                    initial_max_quota_pos,
                                                    final_max_quota_pos -
                                                    initial_max_quota_pos));
          "OPEN".CC_BOFinancing.ExecDebtFinanc(planIdArray(i),
                                               planMethodArray(i),
                                               SYSDATE + 1,
                                               interestRate,
                                               "OPEN".pkBillConst.CERO,
                                               max_number_quota,
                                               SUPPORT_DOCUMENT,
                                               "OPEN".pkBillConst.CIENPORCIEN,
                                               "OPEN".pkBillConst.CERO,
                                               "OPEN".pkConstante.NO,
                                               "OPEN".cc_boconstants.csbCUSTOMERCARE,
                                               "OPEN".pkConstante.NO,
                                               "OPEN".pkConstante.NO,
                                               nuDifeCofi,
                                               onuAcumCuota,
                                               onuSaldo,
                                               onuTotalAcumCapital,
                                               onuTotalAcumCuotExtr,
                                               onuTotalAcumInteres,
                                               osbRequiereVisado,
                                               'Y');
          :errorCode    := 0;
          :errorMessage := null;
        ELSE
          RAISE "OPEN".EX.CONTROLLED_ERROR;
        end if;
    END;
  
    "OPEN".CC_BOFinancing.CommitFinanc;
  
    SELECT d.difecodi
      INTO EXACT_DEFERRED_ID
      FROM OPEN.diferido d
     WHERE d.difenuse = :productId
       AND d.difenudo = SUPPORT_DOCUMENT
       AND ROWNUM = 1;
  
    IF EXACT_DEFERRED_ID IS NOT NULL THEN
      nuDifecodi := EXACT_DEFERRED_ID;
    END IF;
  
    UPDATE OPEN.LD_ITEM_WORK_ORDER
       SET DIFECODI = EXACT_DEFERRED_ID
     WHERE ORDER_ACTIVITY_ID = orderActivityIdArray(i);
  
    IF (:hasGracePeriod = 1) THEN
      BEGIN
        SELECT grace_peri_defe.grace_peri_defe_id,
               (grace_peri_defe.initial_date + grace_peri_defe.grace_days) end_date
          INTO grace_period_deffered_id, grace_period_end_date
          FROM (SELECT dpg.grace_peri_defe_id grace_peri_defe_id,
                       dpg.initial_date initial_date,
                       pg.max_grace_days grace_days,
                       ROW_NUMBER() OVER(PARTITION BY dpg.deferred_id ORDER BY dpg.grace_peri_defe_id DESC) position
                  FROM open.cc_grace_peri_defe dpg
                 INNER JOIN open.cc_grace_period pg
                    ON dpg.grace_period_id = pg.grace_period_id
                 WHERE dpg.deferred_id IN (EXACT_DEFERRED_ID) --Diferidos de la venta
                ) grace_peri_defe
         WHERE grace_peri_defe.position = 1;
      
        UPDATE open.cc_grace_peri_defe
           SET end_date = grace_period_end_date
         WHERE grace_peri_defe_id = grace_period_deffered_id;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          :errorMessage := 'No se encontró un periodo de gracia para el diferido ' ||
                           EXACT_DEFERRED_ID;
          RAISE GRACE_PER_DEFF_NOT_EXIST;
      END;
    END IF;
  
    :deferredString := EXACT_DEFERRED_ID || ',' || saleDetailIds(i) || ';' ||
                       :deferredString;
  end loop;*/

  UPDATE open.ldc_segurovoluntario
     SET difecodi = nuDifecodi
   WHERE package_id = :packageId;

  IF isSecureSale = 1 THEN
    INSERT INTO OPEN.LDC_AFIANZADO
      (PRODUCT_ID, BLOCK, CREATED_AT)
    VALUES
      (productId, 'Y', SYSDATE);
  END IF;

  IF skipTimeRestrictionOnElectronicInvoice = 1 THEN
    DELETE FROM open.omitir_factura_temp WHERE idcontrato = contract_id;
  END IF;

  COMMIT;
EXCEPTION
  WHEN GRACE_PER_DEFF_NOT_EXIST THEN
    :errorCode := -1;
    ROLLBACK;
  WHEN "OPEN".EX.CONTROLLED_ERROR THEN
    "OPEN".ERRORS.SETERROR;
    "OPEN".ERRORS.GETERROR(:errorCode, :errorMessage);
    ROLLBACK;
  WHEN OTHERS THEN
    "OPEN".ERRORS.SETERROR;
    "OPEN".ERRORS.GETERROR(:errorCode, :errorMessage);
    ROLLBACK;
END;
;
