CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_LD_QUOTA_BLOCK AFTER INSERT OR UPDATE OR DELETE ON LD_QUOTA_BLOCK
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

QUOTA_BLOCK_ID NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  QUOTA_BLOCK_ID := :new.QUOTA_BLOCK_ID;
  OPERATION := 'I';
ELSIF UPDATING THEN
  QUOTA_BLOCK_ID := :new.QUOTA_BLOCK_ID;
  OPERATION := 'U';
ELSE
  QUOTA_BLOCK_ID := :old.QUOTA_BLOCK_ID;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_LD_QUOTA_BLOCK (
  QUOTA_BLOCK_ID,
  OPERATION
)
VALUES (
  QUOTA_BLOCK_ID,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/