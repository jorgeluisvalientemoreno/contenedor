CREATE OR REPLACE TRIGGER ADM_PERSON.trgauAllocateQuoteEsFn
AFTER  UPDATE OF sesuesfn,sesuesco ON servsusc
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/*
    Propiedad intelectual de PETI

    Trigger     : trgauAllocateQuoteEsFn
    Descripciòn : Trigger que permite marcar el contrato para actualiza cupo
    Autor       : llozada
    Fecha       : 12-05-2015

    Historia de Modificaciones
    Fecha
    12-05-2015  CreaciÃ³n
*/
DECLARE

    rcQuotaFNB          ldc_prQuotaFnb.styldc_quota_fnb;
    nuProductId         servsusc.sesususc%type;
    nuProducStatus      servsusc.sesuesco%type;
    nuSesuesfn          servsusc.sesuesfn%type;

BEGIN

    nuProductId     := :new.sesunuse;
    nuProducStatus  := :new.sesuesco;
    nuSesuesfn      := :new.sesuesfn;

    rcQuotaFNB.subscription_id := :new.sesususc;

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
