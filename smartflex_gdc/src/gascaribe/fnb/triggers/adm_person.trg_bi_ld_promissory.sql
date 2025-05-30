CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_LD_PROMISSORY AFTER INSERT OR UPDATE OR DELETE ON LD_PROMISSORY
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

PROMISSORY_ID NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  PROMISSORY_ID := :new.PROMISSORY_ID;
  OPERATION := 'I';
ELSIF UPDATING THEN
  PROMISSORY_ID := :new.PROMISSORY_ID;
  OPERATION := 'U';
ELSE
  PROMISSORY_ID := :old.PROMISSORY_ID;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_LD_PROMISSORY (
  PROMISSORY_ID,
  OPERATION
)
VALUES (
  PROMISSORY_ID,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/
