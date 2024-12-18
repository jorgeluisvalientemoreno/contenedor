CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAUALLOCATEQUOTETRANSFER
AFTER UPDATE OF status,trasnfer_value ON ld_quota_transfer
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/*
    Propiedad intelectual de PETI

    Trigger     : trgauAllocateQuoteTransfer
    Descripci๒n : Trigger que permite marcar el contrato para actualiza cupo
    Autor       : llozada
    Fecha       : 12-05-2015

    Historia de Modificaciones
    Fecha
    12-05-2015  Creaciรณn
*/
DECLARE

    rcQuotaFNB          ldc_prQuotaFnb.styldc_quota_fnb;
    nuProductId         servsusc.sesususc%type;
    nuProducStatus      servsusc.sesuesco%type;
    nuSesuesfn          servsusc.sesuesfn%type;

BEGIN
    ldc_prQuotaFnb.prGetProduct(:new.origin_subscrip_id,nuProductId,nuProducStatus,nuSesuesfn);

    rcQuotaFNB.subscription_id := :new.origin_subscrip_id;

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
        rcQuotaFNB.product_id      := nuProductId;
        rcQuotaFNB.product_status_id := nuProducStatus;
        rcQuotaFNB.financial_state := nuSesuesfn;
        rcQuotaFNB.last_quota      := 0;
        rcQuotaFNB.last_quota_date := null;
        rcQuotaFNB.calculated_quota := 'Y';

        --Se inserta el contrato para actualizar el cupo
        ldc_prQuotaFnb.insRecord(rcQuotaFNB);
    END IF;

    ldc_prQuotaFnb.prGetProduct(:new.destiny_subscrip_id,nuProductId,nuProducStatus,nuSesuesfn);

    rcQuotaFNB.subscription_id := :new.destiny_subscrip_id;

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
        rcQuotaFNB.product_id      := nuProductId;
        rcQuotaFNB.product_status_id := nuProducStatus;
        rcQuotaFNB.financial_state := nuSesuesfn;
        rcQuotaFNB.last_quota      := 0;
        rcQuotaFNB.last_quota_date := null;
        rcQuotaFNB.calculated_quota := 'Y';

        --Se inserta el contrato para actualizar el cupo
        ldc_prQuotaFnb.insRecord(rcQuotaFNB);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        raise_application_error(-20001,'Ha ocurrido un error - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
/
