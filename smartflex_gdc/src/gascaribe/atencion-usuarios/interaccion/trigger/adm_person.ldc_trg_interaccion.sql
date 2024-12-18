CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_INTERACCION
  AFTER INSERT OR UPDATE OF motive_status_id ON mo_packages

  /*****************************************************************
  Unidad         : ldc_trg_interaccion
  Descripcion    : Trigger para actualizar el flag de campo parcial para
                   establecer que una de las solciitudes de la interacion
                   ha suido atendida.

  Autor          : Jorge Valiente
  Fecha          : 9/11/2022

  Consideraciones de Uso
  ============================================================================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========   ==================      ====================

  ******************************************************************/

  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW

when (new.motive_status_id <> 13 and old.package_type_id <> 268)
DECLARE
  cursor cuLDC_INTERACCION_SIN_FLUJO is
    select count(1)
      from open.LDC_INTERACCION_SIN_FLUJO
     where LDC_INTERACCION_SIN_FLUJO.PACKAGE_ID =
           to_number(:new.cust_care_reques_num);

  nuCantidad number;

  osberrormessage VARCHAR2(3000);
BEGIN

  BEGIN
    open cuLDC_INTERACCION_SIN_FLUJO;
    fetch cuLDC_INTERACCION_SIN_FLUJO
      into nuCantidad;
    close cuLDC_INTERACCION_SIN_FLUJO;
    if nvl(nuCantidad, 0) > 0 then
      update open.LDC_INTERACCION_SIN_FLUJO
         set LDC_INTERACCION_SIN_FLUJO.PARCIAL = 'S'
       where LDC_INTERACCION_SIN_FLUJO.PACKAGE_ID =
             to_number(:new.cust_care_reques_num);
    end if;
  EXCEPTION
    WHEN others THEN
      null;
  END;

EXCEPTION
  WHEN OTHERS THEN
    osberrormessage := 'Error en el trigger : ldc_trg_interaccion' ||
                       SQLERRM;
    ut_trace.trace(osberrormessage, 11);
END ldc_trg_interaccion;
/