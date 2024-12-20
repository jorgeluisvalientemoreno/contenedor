CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_CC_REQUEST_DEFERRED 
AFTER INSERT OR UPDATE OR DELETE ON CC_REQUEST_DEFERRED
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

REQUEST_DEFERRED_ID NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  REQUEST_DEFERRED_ID := :new.REQUEST_DEFERRED_ID;
  OPERATION := 'I';
ELSIF UPDATING THEN
  REQUEST_DEFERRED_ID := :new.REQUEST_DEFERRED_ID;
  OPERATION := 'U';
ELSE
  REQUEST_DEFERRED_ID := :old.REQUEST_DEFERRED_ID;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_CC_REQUEST_DEFERRED (
  REQUEST_DEFERRED_ID,
  OPERATION
)
VALUES (
  REQUEST_DEFERRED_ID,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/
