CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_DEL_GE_ACTA_NOV_OFER
 BEFORE DELETE ON ge_acta FOR EACH ROW
DECLARE
  nucontacd NUMBER(6);
BEGIN
 nucontacd := 0;
 SELECT COUNT(1) INTO nucontacd
   FROM ldc_actas_aplica_proc_ofert tf
  WHERE tf.acta = :old.id_acta;
  IF  nucontacd >= 1 THEN
   ldc_procrevnovedadesnueesliq(:old.id_acta);
  END IF;
EXCEPTION
 WHEN ex.controlled_error THEN
   RAISE;
 WHEN OTHERS THEN
  errors.seterror;
  RAISE ex.controlled_error;
END TRG_DEL_GE_ACTA_NOV_OFER;
/
