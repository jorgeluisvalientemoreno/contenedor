CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_GE_CAUSAL 
AFTER INSERT OR UPDATE OR DELETE ON GE_CAUSAL
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

CAUSAL_ID NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  CAUSAL_ID := :new.CAUSAL_ID;
  OPERATION := 'I';
ELSIF UPDATING THEN
  CAUSAL_ID := :new.CAUSAL_ID;
  OPERATION := 'U';
ELSE
  CAUSAL_ID := :old.CAUSAL_ID;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_GE_CAUSAL (
  CAUSAL_ID,
  OPERATION
)
VALUES (
  CAUSAL_ID,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/
