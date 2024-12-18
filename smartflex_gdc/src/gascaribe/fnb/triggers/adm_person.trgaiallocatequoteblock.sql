CREATE OR REPLACE trigger ADM_PERSON.TRGAIALLOCATEQUOTEBLOCK for insert ON ld_quota_block
COMPOUND TRIGGER
    nuSubscription    ld_quota_block.subscription_id%type;
    sbErrMsg            ge_error_log.description%type;
    nuErrCode           ge_error_log.error_log_id %type;
    nuTotal             ld_credit_quota.quota_value%type;
    nuCausal         NUMBER;
    nuCalcuCupo     NUMBER := 1;
    sbObservacion   ld_quota_block.OBSERVATION%type;
    rcQuotaHistoric   dald_quota_historic.styLD_quota_historic;

    BEFORE EACH ROW IS
     BEGIN
        IF :new.terminal IS NULL THEN
          :new.terminal := 'TERMINAL';
       END IF;
     END BEFORE EACH ROW;

    AFTER EACH ROW IS
       BEGIN
          nuSubscription := :new.subscription_id;
          nuCausal := :NEW.CAUSAL_ID;
          sbObservacion := :NEW.OBSERVATION;
    END AFTER EACH ROW;

    AFTER STATEMENT IS
    BEGIN
        -- Asigna el cupo de brilla
         IF fblaplicaentregaxcaso('0000379') THEN
            DBMS_OUTPUT.PUT_LINE('ingreso '||nuCausal||' - '||sbObservacion||'- '||nuSubscription);
            IF DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CABLCUCO', NULL) = nuCausal THEN
               nuCalcuCupo := 0;

               LDC_CALCULACUPOBRILLA.updateQuota( nuSubscription,
                                                  0,
                                                  ld_boconstans.csbNOFlag,
                                                  sbObservacion
                                                  );

                /*registra historico de cupo en 0*/
              rcQuotaHistoric.quota_historic_id := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_QUOTA_HISTORIC',
                                                                                       'SEQ_LD_QUOTA_HISTORIC');
              rcQuotaHistoric.assigned_quote    := 0;
              rcQuotaHistoric.register_date     := sysdate;
              rcQuotaHistoric.result            := ld_boconstans.csbNOFlag;
              rcQuotaHistoric.subscription_id   := nuSubscription;
              rcQuotaHistoric.observation       := 'CUPO A 0 '||sbObservacion;

              dald_quota_historic.insRecord(rcQuotaHistoric);
            END IF;
         END IF;
         IF nuCalcuCupo = 1 THEN
            LDC_CALCULACUPOBRILLA.AllocateQuota(nuSubscription, nuTotal );
         END IF;
    END AFTER STATEMENT;
END;
/
