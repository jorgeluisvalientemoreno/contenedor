CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_LDC_CA_RANGPERSCAST before insert or update on LDC_CA_RANGPERSCAST
referencing old as old new as new for each row
declare

begin
  if (:new.RANGINICANTPER > :new.RANGFINCANTPER) then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                       'La cantidad inicial no puede se mayor a la cantidad final');
      raise ex.CONTROLLED_ERROR;
  end if;

  if (:new.RANGINICANTPER < 0 or  :new.RANGFINCANTPER < 0 ) then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                       'La cantidad inicial y final debe ser mayor a cero');
      raise ex.CONTROLLED_ERROR;
  end if;

  if (:new.VALOR < 0 ) then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                       'El valor no puede ser negativo');
      raise ex.CONTROLLED_ERROR;
  end if;

EXCEPTION
  when ex.CONTROLLED_ERROR then
      raise;

  when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
end;
/
