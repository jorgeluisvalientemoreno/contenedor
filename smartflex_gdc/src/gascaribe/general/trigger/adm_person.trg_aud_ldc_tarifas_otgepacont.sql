CREATE OR REPLACE TRIGGER ADM_PERSON.trg_aud_ldc_tarifas_otgepacont
 AFTER INSERT OR UPDATE OR DELETE ON ldc_tarifas_otgepacont FOR EACH ROW
DECLARE
  sboper    ldc_tarifas_otgepacont_audi.operacion%TYPE;
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
 INSERT INTO ldc_tarifas_otgepacont_audi(
                                         unidad_oper
                                        ,tipo_trabajo
                                        ,causal_lega
                                        ,actividad_generar
                                        ,valor_novedad
                                        ,activo
                                        ,fecha_creacion
                                        ,usuario
                                        ,operacion
                                        )
      VALUES(
             decode(sboper,'D',:old.unidad_oper,:new.unidad_oper)
            ,decode(sboper,'D',:old.tipo_trabajo,:new.tipo_trabajo)
            ,decode(sboper,'D',:old.causal_lega,:new.causal_lega)
            ,decode(sboper,'D',:old.actividad_generar,:new.actividad_generar)
            ,decode(sboper,'D',:old.valor_novedad,:new.valor_novedad)
            ,decode(sboper,'D',:old.activo,:new.activo)
            ,SYSDATE
            ,USER
            ,sboper
            );
EXCEPTION
 WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
   ut_trace.trace('trg_aud_ldc_tarifas_otgepacont '||sbmensaje||' '||SQLERRM, 11);
 WHEN OTHERS THEN
  errors.seterror;
  RAISE ex.controlled_error;
END trg_aud_ldc_tarifas_otgepacont;
/
