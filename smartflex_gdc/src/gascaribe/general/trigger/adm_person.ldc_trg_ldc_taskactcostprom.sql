CREATE OR REPLACE TRIGGER ADM_PERSON.ldc_trg_ldc_taskactcostprom
BEFORE INSERT OR UPDATE ON  ldc_taskactcostprom
FOR EACH ROW
DECLARE
  /*Variable para almacenar fecha actual*/
  x              NUMBER;
  eerror         EXCEPTION;
  sbdescitems    ge_items.description%TYPE;
  sbdesctipotrab or_task_type.description%TYPE;
  sbmensaje      VARCHAR2(2000);


BEGIN
  -- se valida que la unidad tenga el tipo de trabajo asociado

  if :new.UNIDAD_OPERATIVA is not null then
	  x := 0;
	  select count(1) into x
	  from LDC_VISTA_UNI_OPE_TIP_TRA_VW
	  where unidad_operativa_vw = :new.UNIDAD_OPERATIVA
		and tipo_trabajo_vw =:new.TIPO_TRAB;

	  IF x= 0 then

		 sbmensaje := 'El tipo de trabajo['||:new.TIPO_TRAB||'-'||DAOR_TASK_TYPE.FSBGETDESCRIPTION(:new.TIPO_TRAB, NULL)||' no esta asociado a la unidad ['||:new.UNIDAD_OPERATIVA||'-'||DAOR_OPERATING_UNIT.FSBGETNAME(:new.UNIDAD_OPERATIVA, NULL);
		 RAISE eerror;
	  END IF;

  END IF;
  /*Validamos si el tipo de trabajo del item es igual a tipo de trabajo que tiene registrado la actividad*/
  x := 0;
  SELECT COUNT(1) INTO x
    FROM or_task_types_items otti
   WHERE otti.items_id     = :new.actividad
     AND otti.task_type_id = :new.tipo_trab;
  /*En caso de no tener ningun registro mandaremos error*/
  IF x = 0 THEN
   BEGIN
    SELECT s.description INTO sbdescitems
      FROM open.ge_items s
     WHERE s.items_id = :new.actividad;
   EXCEPTION
    WHEN no_data_found THEN
     sbmensaje := 'No existe actividad con el id : '||:new.actividad;
     RAISE eerror;
   END;
   BEGIN
    SELECT t.description INTO sbdesctipotrab
      FROM open.or_task_type t
     WHERE t.task_type_id = :new.tipo_trab;
   EXCEPTION
    WHEN no_data_found THEN
     sbmensaje := 'No existe tipo de trabajo con el id : '||:new.tipo_trab;
     RAISE eerror;
   END;
   sbmensaje := 'La actividad : '||:new.actividad||' - '||sbdescitems||' no esta asociada al tipo de trabajo : '||:new.tipo_trab||' - '||sbdesctipotrab;
   RAISE eerror;
  END IF;
EXCEPTION
  WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
   ut_trace.trace('ldc_trg_ldc_taskactcostprom : '||sbmensaje||' '||SQLERRM, 11);
  WHEN others THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,SQLERRM);
   ut_trace.trace('ldc_trg_ldc_taskactcostprom : '||sbmensaje||' '||SQLERRM, 11);
END;
/
