CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_GC_DEBT_NEGOTIATION 
AFTER INSERT OR UPDATE OR DELETE ON GC_DEBT_NEGOTIATION
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

DEBT_NEGOTIATION_ID NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  DEBT_NEGOTIATION_ID := :new.DEBT_NEGOTIATION_ID;
  OPERATION := 'I';
ELSIF UPDATING THEN
  DEBT_NEGOTIATION_ID := :new.DEBT_NEGOTIATION_ID;
  OPERATION := 'U';
ELSE
  DEBT_NEGOTIATION_ID := :old.DEBT_NEGOTIATION_ID;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_GC_DEBT_NEGOTIATION (
  DEBT_NEGOTIATION_ID,
  OPERATION
)
VALUES (
  DEBT_NEGOTIATION_ID,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/