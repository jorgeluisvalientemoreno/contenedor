CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_CC_GRACE_PERI_DEFE 
AFTER INSERT OR UPDATE OR DELETE ON CC_GRACE_PERI_DEFE
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

GRACE_PERI_DEFE_ID NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  GRACE_PERI_DEFE_ID := :new.GRACE_PERI_DEFE_ID;
  OPERATION := 'I';
ELSIF UPDATING THEN
  GRACE_PERI_DEFE_ID := :new.GRACE_PERI_DEFE_ID;
  OPERATION := 'U';
ELSE
  GRACE_PERI_DEFE_ID := :old.GRACE_PERI_DEFE_ID;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_CC_GRACE_PERI_DEFE (
  GRACE_PERI_DEFE_ID,
  OPERATION
)
VALUES (
  GRACE_PERI_DEFE_ID,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/
