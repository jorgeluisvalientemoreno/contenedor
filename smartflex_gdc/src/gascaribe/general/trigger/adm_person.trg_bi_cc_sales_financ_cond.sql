CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_CC_SALES_FINANC_COND 
AFTER INSERT OR UPDATE OR DELETE ON CC_SALES_FINANC_COND
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

PACKAGE_ID NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  PACKAGE_ID := :new.PACKAGE_ID;
  OPERATION := 'I';
ELSIF UPDATING THEN
  PACKAGE_ID := :new.PACKAGE_ID;
  OPERATION := 'U';
ELSE
  PACKAGE_ID := :old.PACKAGE_ID;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_CC_SALES_FINANC_COND (
  PACKAGE_ID,
  OPERATION
)
VALUES (
  PACKAGE_ID,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/
