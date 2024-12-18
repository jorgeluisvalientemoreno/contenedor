CREATE OR REPLACE TRIGGER ADM_PERSON.trgUpOrderValue BEFORE UPDATE
ON OR_ORDER FOR EACH ROW
   /*****************************************************************
   Propiedad intelectual de PETI.

   Unidad         : trgUpOrderValue
   Descripcion    : Trigger que actualiza el valor de la orden con la Actividad principal para
                    los tipos de trabajo 10174 y 12161 de Revisión Periódica
   Autor          : llozada
   Fecha          : 13/12/2013

   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================

   ******************************************************************/
DECLARE
    nuErrCode number;
    sbErrMsg VARCHAR2(2000);

BEGIN

for rc in (SELECT column_value
                            from table
                            (ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain('LDC_CAUSALES_RP'),'|')))
loop
    if :new.task_type_id = rc.column_value then
        if :new.causal_id IS not null AND :new.order_status_id = dald_parameter.fnuGetNumeric_Value('COD_ORDER_STATUS') then
            IF dage_causal.fnugetclass_causal_id(:new.causal_id) = 1
             THEN
                :new.order_value := LDC_GETVALUERP(:new.order_id, :new.assigned_date);
                exit;
            END IF;
        END if;
    END if;
END loop;

EXCEPTION
   WHEN EX.CONTROLLED_ERROR THEN
       raise;
   WHEN OTHERS THEN
       ERRORS.SETERROR;
       RAISE EX.CONTROLLED_ERROR;

END  trgUpOrderValue ;
/
