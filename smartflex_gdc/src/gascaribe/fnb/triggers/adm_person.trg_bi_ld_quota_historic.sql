CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_LD_QUOTA_HISTORIC AFTER INSERT OR UPDATE OR DELETE ON LD_QUOTA_HISTORIC
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

QUOTA_HISTORIC_ID NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  QUOTA_HISTORIC_ID := :new.QUOTA_HISTORIC_ID;
  OPERATION := 'I';
ELSIF UPDATING THEN
  QUOTA_HISTORIC_ID := :new.QUOTA_HISTORIC_ID;
  OPERATION := 'U';
ELSE
  QUOTA_HISTORIC_ID := :old.QUOTA_HISTORIC_ID;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_LD_QUOTA_HISTORIC (
  QUOTA_HISTORIC_ID,
  OPERATION
)
VALUES (
  QUOTA_HISTORIC_ID,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/
