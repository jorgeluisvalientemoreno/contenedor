CREATE OR REPLACE TRIGGER ADM_PERSON.trg_specials_plan
BEFORE INSERT OR UPDATE ON ldc_specials_plan
FOR EACH ROW
begin
  IF :new.end_date < :new.init_date THEN
      RAISE_APPLICATION_ERROR (num => -20001, msg => 'La fecha final no puede ser menor a la inicial');
   END IF;
END trg_specials_plan;
/
