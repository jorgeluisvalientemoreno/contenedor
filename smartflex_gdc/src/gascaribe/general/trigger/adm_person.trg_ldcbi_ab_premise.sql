CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDCBI_AB_PREMISE AFTER INSERT OR UPDATE OR DELETE ON ab_premise
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

premise_id       NUMBER(15);
is_delete        varchar(1) := NULL;

BEGIN

IF DELETING THEN
  premise_id := :old.premise_id;
  Is_Delete := 'Y';
ELSE
  premise_id := :new.premise_id;
  Is_Delete := 'N';
END IF;

INSERT INTO ldcbi_ab_premise (
    premise_id,
    Is_Delete
  )
  VALUES (
    premise_id,
    Is_Delete
  );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
