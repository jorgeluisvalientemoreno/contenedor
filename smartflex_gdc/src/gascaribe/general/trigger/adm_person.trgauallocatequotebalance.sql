CREATE OR REPLACE TRIGGER ADM_PERSON.trgauAllocateQuoteBalance
AFTER UPDATE OF cucosacu,cucovato ON cuencobr
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/*
    Propiedad intelectual de PETI

    Trigger     : trgauAllocateQuoteBalance
    Descripci?n : Trigger que permite marcar el contrato para actualiza cupo
    Autor       : llozada
    Fecha       : 12-05-2015

    Historia de Modificaciones
    Fecha
    12-05-2015  Creaci?n
*/
DECLARE

    rcQuotaFNB          ldc_prQuotaFnb.styldc_quota_fnb;
    nuSubscriptionId    servsusc.sesususc%type;
    nuProducStatus      servsusc.sesuesco%type;
    nuSesuesfn          servsusc.sesuesfn%type;
    nuMayor             number := 0;
    nuidregistro    ldc_usuarios_actualiza_cl.idregistro%TYPE;
    CURSOR cuSuscTraslado(nuSuscRecibe servsusc.sesususc%type)
    IS
        SELECT DISTINCT *
        FROM (
            SELECT  origin_subscrip_id ,
            SUM(
            (EXTRACT(YEAR FROM transfer_date)*10000) + (EXTRACT(MONTH FROM transfer_date)*100)
            + EXTRACT(DAY FROM transfer_date)) nuFecha
            FROM    ld_quota_transfer
            WHERE   destiny_subscrip_id = nuSuscRecibe
            AND     approved = LD_BOConstans.csbYesFlag
            GROUP BY origin_subscrip_id)
        ORDER BY nuFecha DESC;

BEGIN
    ldc_prQuotaFnb.prGetSubscription(:new.cuconuse,nuSubscriptionId,nuProducStatus,nuSesuesfn);

    --Se valida si el contrato tiene traslado para actualizar cupo a los implicados
    FOR rc IN cuSuscTraslado(nuSubscriptionId) loop
        IF (rc.nuFecha >= nuMayor)  THEN
            nuMayor := rc.nuFecha;
        ELSE
            EXIT;
        END IF;

        rcQuotaFNB.subscription_id := rc.origin_subscrip_id;

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
            rcQuotaFNB.product_id      := :new.cuconuse;
            rcQuotaFNB.product_status_id := nuProducStatus;
            rcQuotaFNB.financial_state := nuSesuesfn;
            rcQuotaFNB.last_quota      := 0;
            rcQuotaFNB.last_quota_date := null;
            rcQuotaFNB.calculated_quota := 'Y';

            --Se inserta el contrato para actualizar el cupo
            ldc_prQuotaFnb.insRecord(rcQuotaFNB);
        END IF;
    END LOOP;

    rcQuotaFNB.subscription_id := nuSubscriptionId;

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
        rcQuotaFNB.product_id      := :new.cuconuse;
        rcQuotaFNB.product_status_id := nuProducStatus;
        rcQuotaFNB.financial_state := nuSesuesfn;
        rcQuotaFNB.last_quota      := 0;
        rcQuotaFNB.last_quota_date := null;
        rcQuotaFNB.calculated_quota := 'Y';

        --Se inserta el contrato para actualizar el cupo
        ldc_prQuotaFnb.insRecord(rcQuotaFNB);
    END IF;
      nuidregistro := seq_ldc_usuarios_actualiza_cl.nextval;
      INSERT INTO ldc_usuarios_actualiza_cl(producto,ctacob,idregistro) VALUES(:new.cuconuse,'S',nuidregistro);

EXCEPTION
    WHEN OTHERS THEN
        raise_application_error(-20001,'Ha ocurrido un error - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
/
