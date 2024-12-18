CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_UPSERTLDC_TT_ACT
BEFORE insert or update ON  LDC_TT_ACT
 FOR EACH ROW
BEGIN
   ut_trace.trace('Inicio ldc_trg_upsertLDC_TT_ACT', 10);
   if :new.flag_causal = 'C' and :new.causal_id is null  then
		 ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'Si el flag elegido es "CAUSAL", debe seleccionar un identificador de la lista <<Causal>>');
         raise ex.CONTROLLED_ERROR;
   end if;
   if :new.flag_causal = 'T' and :new.class_causal_id is null  then
		 ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'Si el flag elegido es "CLASE DE CAUSAL", debe seleccionar un identificador de la lista <<Clase de Causal>>');
         raise ex.CONTROLLED_ERROR;
   end if;
   ut_trace.trace('Fin ldc_trg_upsertLDC_TT_ACT', 10);
END LDC_TRG_UPSERTLDC_TT_ACT;
/
