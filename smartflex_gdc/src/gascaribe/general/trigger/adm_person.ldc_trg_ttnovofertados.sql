CREATE OR REPLACE TRIGGER ADM_PERSON.ldc_trg_ttnovofertados
BEFORE INSERT OR UPDATE ON  ldc_tipo_trab_x_nov_ofertados
FOR EACH ROW
DECLARE
  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Trigger     : ldc_trg_ttnovofertados
  Descripcion : trigger para controlar que la actividad de novedad de ofertados, este asociado al tipo de trabajo.
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 21-10-2017

  Historia de Modificaciones

    Fecha               Autor                Modificacion
  =========           =========         ====================
  08/07/2019          LJLB              CA 0041 se agrega validacion de novedades positvas y negativas
  18/10/2024          jpinedc           OSF-3383: Se migra a ADM_PERSON
  ***************************************************************************************/
  /*Variable para almacenar fecha actual*/
  x              NUMBER;
  eerror         EXCEPTION;
  sbdescitems    ge_items.description%TYPE;
  sbdesctipotrab or_task_type.description%TYPE;
  sbmensaje      VARCHAR2(2000);

  --TICKET 0041 LJLB -- se consulta si existe novedad
  CURSOR cuValiNovedad( nuItems ct_item_novelty.ITEMS_ID%TYPE,
                        nusigno NUMBER ) IS
  SELECT 'X'
  FROM ct_item_novelty
  WHERE ITEMS_ID = nuItems
    AND liquidation_sign = 1 * nusigno;

   --TICKET 0041 LJLB -- se consulta si existe configuracion de tipo de trabajo por actviidad
  CURSOR cuExisConfTtxAct(nuItems or_task_types_items.items_id%TYPE) IS
  SELECT COUNT(1)
  FROM or_task_types_items otti
  WHERE otti.items_id     = nuItems
     AND otti.task_type_id = :new.tipo_trabajo;

   sbdatos VARCHAR2(1);

BEGIN
  /*Validamos si el tipo de trabajo del item es igual a tipo de trabajo que tiene registrado la actividad*/

   --TICKET 0041 LJLB -- Se valida que se haya configurado por lo menos una actividad
  IF :new.actividad_novedad_ofertados IS NULL AND :new.ACTIVIDAD_POSITIVA IS NULL THEN
     sbmensaje := 'Se debe configurar por lo menos una actividad de novedad.';
     RAISE eerror;
  END IF;

   BEGIN
    SELECT t.description INTO sbdesctipotrab
      FROM open.or_task_type t
     WHERE t.task_type_id = :new.tipo_trabajo;
   EXCEPTION
    WHEN no_data_found THEN
     sbmensaje := 'No existe tipo de trabajo con el id : '||:new.tipo_trabajo;
     RAISE eerror;
   END;

   x := 0;
   --TICKET 0041 LJLB -- se valida si existe configuracion de tt x act
  IF :new.actividad_novedad_ofertados IS NOT  NULL THEN
   OPEN cuExisConfTtxAct(:new.actividad_novedad_ofertados);
   FETCH cuExisConfTtxAct INTO x;
   CLOSE cuExisConfTtxAct;

    IF x= 0 THEN
     sbmensaje := 'La actividad de novedad de ofertados : '||:new.actividad_novedad_ofertados||' - '||dage_items.fsbgetdescription(:new.actividad_novedad_ofertados,NULL)||' no esta asociada al tipo de trabajo : '||:new.tipo_trabajo||' - '||sbdesctipotrab;
     RAISE eerror;
    END IF;
    --se valida signo de la novedad
    OPEN cuValiNovedad(:new.actividad_novedad_ofertados, -1);
    FETCH cuValiNovedad INTO sbdatos;
    IF cuValiNovedad%NOTFOUND THEN
      CLOSE cuValiNovedad;
      sbmensaje := 'No existe actividad de novedad o no esta configurada como signo negativo';
      RAISE eerror;
    END IF;
    CLOSE cuValiNovedad;
  END IF;

  x := 0;
  --TICKET 0041 LJLB -- se valida si existe configuracion de tt x act
  IF :new.ACTIVIDAD_POSITIVA IS NOT  NULL THEN
   OPEN cuExisConfTtxAct(:new.ACTIVIDAD_POSITIVA);
   FETCH cuExisConfTtxAct INTO x;
   CLOSE cuExisConfTtxAct;
   IF x= 0 THEN
     sbmensaje := 'La actividad de novedad de ofertados : '||:new.ACTIVIDAD_POSITIVA||' - '||dage_items.fsbgetdescription(:new.actividad_novedad_ofertados,NULL)||' no esta asociada al tipo de trabajo : '||:new.tipo_trabajo||' - '||sbdesctipotrab;
     RAISE eerror;
   END IF;
    --se valida signo de la novedad
    OPEN cuValiNovedad(:new.ACTIVIDAD_POSITIVA, 1);
    FETCH cuValiNovedad INTO sbdatos;
    IF cuValiNovedad%NOTFOUND THEN
      CLOSE cuValiNovedad;
      sbmensaje := 'No existe actividad de novedad o no esta configurada como signo positivo';
      RAISE eerror;
    END IF;
    CLOSE cuValiNovedad;
  END IF;

EXCEPTION
  WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
   ut_trace.trace('ldctrg_ldc_item_uo_lr '||sbmensaje||' '||SQLERRM, 11);
  WHEN others THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,SQLERRM);
   ut_trace.trace('ldctrg_ldc_item_uo_lr '||sbmensaje||' '||SQLERRM, 11);
END;
/
