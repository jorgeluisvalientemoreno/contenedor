CREATE OR REPLACE trigger ADM_PERSON.LDC_CUOTAS_PROYECTO_TRG_UPDATE
  after UPDATE OF estado on ldc_cuotas_proyecto
  for each row
DECLARE

    rcCuota daldc_audit_cuot_proy.styLDC_AUDIT_CUOT_PROY;

BEGIN

    rcCuota.consecutivo     := seq_ldc_audit_cuot_proy.nextval;
    rcCuota.id_cuota        := :NEW.CONSECUTIVO;
    rcCuota.estado_anterior := :OLD.ESTADO;
    rcCuota.estado_nuevo    := :new.Estado;
    rcCuota.fecha_modif     := SYSDATE;
    rcCuota.usua_modif      := USER;
    rcCuota.id_proyecto     := :NEW.ID_PROYECTO;

    daldc_audit_cuot_proy.insRecord(ircldc_audit_cuot_proy => rcCuota);

END LDC_CUOTAS_PROYECTO_TRG_UPDATE;
/
