CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_HICOPRPM 
AFTER INSERT OR UPDATE OR DELETE ON HICOPRPM
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

HCPPCONS NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  HCPPCONS := :new.HCPPCONS;
  OPERATION := 'I';
ELSIF UPDATING THEN
  HCPPCONS := :new.HCPPCONS;
  OPERATION := 'U';
ELSE
  HCPPCONS := :old.HCPPCONS;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_HICOPRPM (
  HCPPCONS,
  OPERATION
)
VALUES (
  HCPPCONS,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/
