CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_ELEMMEDI 
AFTER INSERT OR UPDATE OR DELETE ON ELEMMEDI
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

ELMEIDEM NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  ELMEIDEM := :new.ELMEIDEM;
  OPERATION := 'I';
ELSIF UPDATING THEN
  ELMEIDEM := :new.ELMEIDEM;
  OPERATION := 'U';
ELSE
  ELMEIDEM := :old.ELMEIDEM;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_ELEMMEDI (
  ELMEIDEM,
  OPERATION
)
VALUES (
  ELMEIDEM,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/