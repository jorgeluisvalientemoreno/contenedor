CREATE OR REPLACE trigger ADM_PERSON.LDC_CHEQUES_CONSTRUC_TRG_UPD
  after update on ldc_cheques_proyecto
  for each row
DECLARE
    rcCheque daldc_audit_cheq_proy.styLDC_AUDIT_CHEQ_PROY;
BEGIN

    rcCheque.consecutivo     := seq_ldc_audit_cheq_proy.nextval;
    rcCheque.numero_cheque   := :new.Numero_Cheque;
    rcCheque.estado_anterior := :old.Estado;
    rcCheque.estado_nuevo    := :new.Estado;
    rcCheque.fecha_modif     := SYSDATE;
    rcCheque.usua_modif      := USER;
    rcCheque.id_proyecto     := :NEW.ID_PROYECTO;
    rcCheque.cons_cheque := :new.consecutivo;

    daldc_audit_cheq_proy.insRecord(rcCheque);

END LDC_CHEQUES_CONSTRUC_TRG_UPD;
/
