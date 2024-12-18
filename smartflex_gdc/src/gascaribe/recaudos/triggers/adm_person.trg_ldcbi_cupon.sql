CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDCBI_CUPON AFTER INSERT OR UPDATE OR DELETE ON cupon
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

cuponume  NUMBER(10);
is_delete varchar(1) := NULL;

BEGIN

IF DELETING THEN
  cuponume := :old.cuponume;
  Is_Delete := 'Y';
ELSE
  cuponume := :new.cuponume;
  Is_Delete := 'N';
END IF;

INSERT INTO ldcbi_cupon (
    cuponume,
    Is_Delete
  )
  VALUES (
    cuponume,
    Is_Delete
  );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
