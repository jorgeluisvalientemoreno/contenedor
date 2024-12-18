CREATE OR REPLACE TRIGGER trgauAllocateQuoteNTL
AFTER UPDATE OF status,fraud_end_date ON fm_possible_ntl
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/*
    Propiedad intelectual de PETI

    Trigger     : trgauAllocateQuoteNTL
    Descripciòn : Trigger que permite marcar el contrato para actualiza cupo
    Autor       : llozada
    Fecha       : 12-05-2015

    Historia de Modificaciones
    Fecha
    12-05-2015  Creación
*/
DECLARE

    rcQuotaFNB          ldc_prQuotaFnb.styldc_quota_fnb;
    nuSubscriptionId    servsusc.sesususc%type;
    nuProducStatus      servsusc.sesuesco%type;
    nuSesuesfn          servsusc.sesuesfn%type;

BEGIN
    ldc_prQuotaFnb.prGetSubscription(:new.product_id,nuSubscriptionId,nuProducStatus,nuSesuesfn);

    rcQuotaFNB.subscription_id := nuSubscriptionId;
    
    if :new.status in ('F', 'C') THEN
        --Se valida que exista el contrato en la tabla LDC_QUOTA_FNB
        IF  ldc_prQuotaFnb.fblExist(rcQuotaFNB.subscription_id) THEN
            IF NOT ldc_prQuotaFnb.fblIsCalculatedQuota(rcQuotaFNB.subscription_id) THEN

                rcQuotaFNB.calculated_quota := 'Y';

                --Actualiza el estado del contrato para calcula cupo
                ldc_prQuotaFnb.updStateRecord(rcQuotaFNB);
            END IF;
        ELSE
            rcQuotaFNB.allocated_quota := 0;
            rcQuotaFNB.quota_used      := 0;
            rcQuotaFNB.register_date   := sysdate;
            rcQuotaFNB.product_id      := :new.product_id;
            rcQuotaFNB.product_status_id := nuProducStatus;
            rcQuotaFNB.financial_state := nuSesuesfn;
            rcQuotaFNB.last_quota      := 0;
            rcQuotaFNB.last_quota_date := null;
            rcQuotaFNB.calculated_quota := 'Y';

            --Se inserta el contrato para actualizar el cupo
            ldc_prQuotaFnb.insRecord(rcQuotaFNB);
        END IF;
    END if;

EXCEPTION
    WHEN OTHERS THEN
        raise_application_error(-20001,'Ha ocurrido un error - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
/
begin
  dbms_output.put_line('---- Inicia OSF-1119 ----');
  Execute immediate 'ALTER TRIGGER trgauAllocateQuoteNTL DISABLE';
  dbms_output.put_line('OK - Trigger Disable');
  dbms_output.put_line('---- Finaliza OSF-1119 ----');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error Dehabilitando el trigger: '||SQLERRM);
END;
/