CREATE OR REPLACE TRIGGER ADM_PERSON.trg_ldcbi_notas 
AFTER INSERT OR UPDATE OR DELETE ON notas
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

notanume         NUMBER(15);
is_delete        varchar(1) := NULL;

BEGIN

IF DELETING THEN
  notanume := :old.notanume;
  Is_Delete := 'Y';
ELSE
  notanume := :new.notanume;
  Is_Delete := 'N';
END IF;

INSERT INTO ldcbi_notas (
    notanume,
    Is_Delete
  )
  VALUES (
    notanume,
    Is_Delete
  );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
