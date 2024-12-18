CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_FECHAINTERSINFLUJO
/*******************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Trigger     :   LDC_TRG_FECHAINTERSINFLUJO
    Descripcion  :  Audita la actualizacion de la DATA en la entidad definida

    Autor       :   Jorge Valiente
    CASO        :   OSF-679

    Historia de Modificaciones
    Autor                   Fecha            Descripcion
    --------------------    --------------   ---------------------------------

*******************************************************************************/
  BEFORE UPDATE ON ldc_interaccion_sin_flujo
  referencing old as old new as new
  for each row
DECLARE

  sbUsuario varchar2(50);

BEGIN

  if (UPDATING) then
  
    if (:new.created_at is null) then
      RAISE ex.controlled_error;
    end if;
    if :old.created_at <> :new.created_at then
      RAISE ex.controlled_error;
    end if;
  
    :new.update_at := sysdate;
  end if;

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE;
  WHEN others THEN
    RAISE;
END;
/
