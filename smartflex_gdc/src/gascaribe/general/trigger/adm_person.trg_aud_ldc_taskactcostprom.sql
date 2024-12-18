CREATE OR REPLACE TRIGGER ADM_PERSON.trg_aud_ldc_taskactcostprom
 AFTER INSERT OR UPDATE OR DELETE ON ldc_taskactcostprom FOR EACH ROW
DECLARE
  sboper    ldc_audi_ord_ofer_redes.oper%TYPE;
  sbmensaje VARCHAR2(500);
  eerror    EXCEPTION;
BEGIN
 sboper := NULL;
 IF inserting THEN
  sboper := 'I';
 ELSIF updating THEN
  sboper := 'U';
 ELSIF deleting THEN
  sboper := 'D';
 ELSE
  sboper := '-';
 END IF;
 INSERT INTO ldc_audi_taskactcostprom( id_registro, tipo_trabajo_act, tipo_trabajo_ant, actividad_act, actividad_ant,unidad_operativa_act,unidad_operativa_ant, costo_prom_act, costo_prom_ant,fecha,usuario, terminal, operacion)
      VALUES(
              nvl(:new.id_registro, :old.id_registro), :new.tipo_trab,   :old.tipo_trab, :new.actividad,  :old.actividad,  :new.unidad_operativa, :old.unidad_operativa,  :new.costo_prom, :old.costo_prom,SYSDATE,USER, USERENV('TERMINAL'), sboper
            );
EXCEPTION
 WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
   ut_trace.trace('trg_aud_ldc_taskactcostprom '||sbmensaje||' '||SQLERRM, 11);
 WHEN OTHERS THEN
  errors.seterror;
  RAISE ex.controlled_error;
END trg_aud_ldc_taskactcostprom;
/
