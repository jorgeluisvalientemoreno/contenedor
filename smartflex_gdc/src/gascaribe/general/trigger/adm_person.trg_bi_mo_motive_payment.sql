CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_MO_MOTIVE_PAYMENT 
AFTER INSERT OR UPDATE OR DELETE ON MO_MOTIVE_PAYMENT
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

MOTIVE_PAYMENT_ID NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  MOTIVE_PAYMENT_ID := :new.MOTIVE_PAYMENT_ID;
  OPERATION := 'I';
ELSIF UPDATING THEN
  MOTIVE_PAYMENT_ID := :new.MOTIVE_PAYMENT_ID;
  OPERATION := 'U';
ELSE
  MOTIVE_PAYMENT_ID := :old.MOTIVE_PAYMENT_ID;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_MO_MOTIVE_PAYMENT (
  MOTIVE_PAYMENT_ID,
  OPERATION
)
VALUES (
  MOTIVE_PAYMENT_ID,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/