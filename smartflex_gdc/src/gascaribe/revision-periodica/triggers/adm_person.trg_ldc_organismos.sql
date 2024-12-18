CREATE OR REPLACE trigger ADM_PERSON.TRG_LDC_ORGANISMOS
  before insert or update on LDC_ORGANISMOS
  for each row
  DECLARE
   -- PRAGMA AUTONOMOUS_TRANSACTION;
    cnunull_attribute CONSTANT NUMBER := 2741;
begin
  if INSERTING then
	  if :new.CONTRATISTA_ID is null and :new.OPERATING_UNIT_ID is null then
		errors.seterror(cnunull_attribute, 'Debe ingresar un Contratista o Unidad Operativa');
		RAISE ex.controlled_error;
	  else
		:new.fecha_registro := sysdate;
		:new.usuario_registro_id := GE_BOPersonal.fnuGetPersonId;
	  end if;
  elsif UPDATING then
	  if :new.CONTRATISTA_ID is null and :new.OPERATING_UNIT_ID is null then
		errors.seterror(cnunull_attribute, 'Debe ingresar un Contratista o Unidad Operativa');
		RAISE ex.controlled_error;
	  end if;
  end if;
EXCEPTION
  when ex.CONTROLLED_ERROR then raise ex.CONTROLLED_ERROR;
  when others then Errors.setError; raise ex.CONTROLLED_ERROR;
end TRG_LDC_ORGANISMOS;
/
