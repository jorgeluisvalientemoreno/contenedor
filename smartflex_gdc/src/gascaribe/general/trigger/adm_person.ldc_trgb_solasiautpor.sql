CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGB_SOLASIAUTPOR
  BEFORE INSERT OR UPDATE ON LDC_SOLASIAUTPOR
  FOR EACH ROW
DECLARE

BEGIN

  if updating('task_type_id_val') then
    if :new.package_type_id is null and :new.task_type_id_val is null then
      Errors.SetError(2741,
                      'No se permite TIPO TRABAJO VALIDO vacio si tipo de solicitud esta vacio.');
      raise ex.controlled_error;
    end if;
  end if;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    pkErrors.Pop;
    raise;

END LDC_TRGB_SOLASIAUTPOR;
/
