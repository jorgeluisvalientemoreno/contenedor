CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_GE_ITEM_WARRANTY 
AFTER INSERT OR UPDATE OR DELETE ON GE_ITEM_WARRANTY
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

ITEM_WARRANTY_ID NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  ITEM_WARRANTY_ID := :new.ITEM_WARRANTY_ID;
  OPERATION := 'I';
ELSIF UPDATING THEN
  ITEM_WARRANTY_ID := :new.ITEM_WARRANTY_ID;
  OPERATION := 'U';
ELSE
  ITEM_WARRANTY_ID := :old.ITEM_WARRANTY_ID;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_GE_ITEM_WARRANTY (
  ITEM_WARRANTY_ID,
  OPERATION
)
VALUES (
  ITEM_WARRANTY_ID,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/