CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_AFIANZADO_HISTORIAL_BIU
/*******************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Trigger     :   trg_afianzado_historial_biu
    Descripcion  :  Audita la creacion y actualizacion de la DATA en la entidad

    Autor       :   Jorge Valiente
    CASO        :   OSF-569

    Historia de Modificaciones
    Autor                   Fecha            Descripcion
    --------------------    --------------   ---------------------------------

*******************************************************************************/
  BEFORE INSERT OR UPDATE ON ldc_afianzado
  referencing old as old new as new
  for each row
DECLARE

  sbUsuario varchar2(50);

BEGIN

  if (INSERTING) then
  
    :new.created_at := sysdate;
  
  elsif (UPDATING) then
  
    if (:new.created_at is null) then
      RAISE ex.controlled_error;
    end if;
    if :old.created_at <> :new.created_at then
      RAISE ex.controlled_error;
    end if;
  
    :new.updated_at := sysdate;
  
  end if;

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE;
  WHEN others THEN
    RAISE;
END;
/
