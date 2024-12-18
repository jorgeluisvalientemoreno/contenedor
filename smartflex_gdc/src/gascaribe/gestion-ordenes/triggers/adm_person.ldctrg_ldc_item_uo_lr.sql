CREATE OR REPLACE TRIGGER ADM_PERSON.LDCTRG_LDC_ITEM_UO_LR
 BEFORE INSERT OR UPDATE OR DELETE ON ldc_item_uo_lr
 REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
 /*******************************************************************
  Propiedad intelectual JM GESTIONINFORMATICA S.A.S.

  Trigger     :  ldc_item_uo_lr

  Descripci?n : Validaciones de fechas de vigencias y rangos

  Autor       : John Jairo Jimenez Marimon
  Fecha       : 26-10-2016

  Historia de Modificaciones
 ********************************************************************/
DECLARE
 eerror     EXCEPTION;
 sbmensaje  VARCHAR2(2000);
 nucontadel NUMBER(4);
BEGIN
 sbmensaje := NULL;
 IF inserting THEN
  IF :new.liquidacion = 'A' AND (:new.actividad = -1 /*OR :new.item = -1*/) THEN
   sbmensaje := 'La liquidaci?n configurada es por actividad, el campo actividad debe ser diferente de -1.';
   RAISE eerror;
  END IF;
  IF :new.liquidacion = 'I' AND :new.item = -1 THEN
   sbmensaje := 'La liquidaci?n configurada es por item, el campo item debe ser diferente de -1.';
   RAISE eerror;
  END IF;
 ELSIF updating THEN
  IF :new.liquidacion = 'A' AND (:old.actividad = -1 /*OR :old.item = -1*/) THEN
   sbmensaje := 'La liquidaci?n configurada es por actividad, el campo actividad debe ser diferente de -1.';
   RAISE eerror;
  END IF;
  IF :new.liquidacion = 'I' AND :old.item = -1 THEN
   sbmensaje := 'La liquidaci?n configurada es por item, el campo item debe ser diferente de -1.';
   RAISE eerror;
  END IF;
 ELSIF deleting THEN
  nucontadel := 0;
  SELECT COUNT(1) INTO nucontadel
    FROM ldc_const_liqtarran l
   WHERE l.unidad_operativa = :old.unidad_operativa
     AND l.actividad_orden  = :old.actividad
     AND l.items            = :old.item;
  IF nucontadel >= 1 THEN
   sbmensaje := 'No es posible borrar el registro debido a que existen configuraciones en la forma LDCCLUO con la unidad operativa : '||:old.unidad_operativa||' , actividad : '||:old.actividad||' e item : '||:old.item;
   RAISE eerror;
  END IF;
 END IF;
EXCEPTION
 WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
   ut_trace.trace('ldctrg_ldc_item_uo_lr '||sbmensaje||' '||SQLERRM, 11);
 WHEN OTHERS THEN
  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,SQLERRM);
  ut_trace.trace('ldctrg_ldc_item_uo_lr '||' '||SQLERRM, 11);
END;
/
