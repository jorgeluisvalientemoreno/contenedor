CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_LDC_PRODTATT AFTER INSERT OR UPDATE OR DELETE ON LDC_PRODTATT
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

PRTTSESU NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  PRTTSESU := :new.PRTTSESU;
  OPERATION := 'I';
ELSIF UPDATING THEN
  PRTTSESU := :new.PRTTSESU;
  OPERATION := 'U';
ELSE
  PRTTSESU := :old.PRTTSESU;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_LDC_PRODTATT (
  PRTTSESU,
  OPERATION
)
VALUES (
  PRTTSESU,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/