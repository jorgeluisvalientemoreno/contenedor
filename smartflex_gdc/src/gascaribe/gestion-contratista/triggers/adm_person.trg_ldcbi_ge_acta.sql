CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDCBI_GE_ACTA AFTER INSERT OR UPDATE OR DELETE ON ge_acta
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

id_acta          NUMBER(15);
is_delete        varchar(1) := NULL;

BEGIN

IF DELETING THEN
  id_acta := :old.id_acta;
  Is_Delete := 'Y';
ELSE
  id_acta := :new.id_acta;
  Is_Delete := 'N';
END IF;

INSERT INTO ldcbi_ge_acta (
    id_acta,
    Is_Delete
  )
  VALUES (
    id_acta,
    Is_Delete
  );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/