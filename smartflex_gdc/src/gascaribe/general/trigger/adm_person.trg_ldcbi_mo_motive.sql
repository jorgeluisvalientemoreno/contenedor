CREATE OR REPLACE TRIGGER ADM_PERSON.trg_ldcbi_mo_motive 
AFTER INSERT OR UPDATE OR DELETE ON mo_motive
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

motive_id  NUMBER(10);
is_delete varchar(1) := NULL;

BEGIN

IF DELETING THEN
  motive_id := :old.motive_id;
  Is_Delete := 'Y';
ELSE
  motive_id := :new.motive_id;
  Is_Delete := 'N';
END IF;

INSERT INTO ldcbi_mo_motive (
    motive_id,
    Is_Delete
  )
  VALUES (
    motive_id,
    Is_Delete
  );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
