CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_LDC_SEGMENT_SUSC AFTER INSERT OR UPDATE OR DELETE ON LDC_SEGMENT_SUSC
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

SEGMENT_SUSC_ID NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  SEGMENT_SUSC_ID := :new.SEGMENT_SUSC_ID;
  OPERATION := 'I';
ELSIF UPDATING THEN
  SEGMENT_SUSC_ID := :new.SEGMENT_SUSC_ID;
  OPERATION := 'U';
ELSE
  SEGMENT_SUSC_ID := :old.SEGMENT_SUSC_ID;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_LDC_SEGMENT_SUSC (
  SEGMENT_SUSC_ID,
  OPERATION
)
VALUES (
  SEGMENT_SUSC_ID,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/
