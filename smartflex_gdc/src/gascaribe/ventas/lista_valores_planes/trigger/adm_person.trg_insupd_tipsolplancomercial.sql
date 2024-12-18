CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_INSUPD_TIPSOLPLANCOMERCIAL
/*******************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Trigger     :   TRG_INSUPD_TIPSOLPLANCOMERCIAL
    Descripcion  :  Registra la creacion y actualizacion de la DATA en al entidad

    Autor       :   Jorge Valiente
    CASO        :   OSF-450

    Historia de Modificaciones
    Autor                   Fecha            Descripcion
    --------------------    --------------   ---------------------------------

*******************************************************************************/
  BEFORE INSERT OR UPDATE ON LDC_TIPSOLPLANCOMERCIAL
  referencing old as old new as new
  for each row
DECLARE

  sbUsuario varchar2(50);

BEGIN

  sbUsuario := ut_session.getuser;

  if (INSERTING) then
  
    :new.created_tspc    := sysdate;
    :new.usuario_created := sbUsuario;
  
  elsif (UPDATING) then
  
    if (:new.created_tspc is null) then
      RAISE ex.controlled_error;
    end if;
    if :old.created_tspc <> :new.created_tspc then
      RAISE ex.controlled_error;
    end if;
    if :new.usuario_created is null then
      RAISE ex.controlled_error;
    end if;
    if :old.usuario_created <> :new.usuario_created then
      RAISE ex.controlled_error;
    end if;
  
    :new.updated_tspc    := sysdate;
    :new.usuario_updated := sbUsuario;
  
  end if;

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE;
  WHEN others THEN
    RAISE;
END;
/
