CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDCBI_CUENCOBR AFTER INSERT OR UPDATE OR DELETE ON cuencobr
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

cucocodi  NUMBER(10);
is_delete varchar(1) := NULL;

BEGIN

IF DELETING THEN
  cucocodi := :old.cucocodi;
  Is_Delete := 'Y';
ELSE
  cucocodi := :new.cucocodi;
  Is_Delete := 'N';
END IF;

INSERT INTO ldcbi_cuencobr (
    cucocodi,
    Is_Delete
  )
  VALUES (
    cucocodi,
    Is_Delete
  );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
