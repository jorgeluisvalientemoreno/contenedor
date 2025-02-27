CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_PR_COMPONENT AFTER INSERT OR UPDATE OR DELETE ON PR_COMPONENT
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

COMPONENT_ID NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  COMPONENT_ID := :new.COMPONENT_ID;
  OPERATION := 'I';
ELSIF UPDATING THEN
  COMPONENT_ID := :new.COMPONENT_ID;
  OPERATION := 'U';
ELSE
  COMPONENT_ID := :old.COMPONENT_ID;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_PR_COMPONENT (
  COMPONENT_ID,
  OPERATION
)
VALUES (
  COMPONENT_ID,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/
