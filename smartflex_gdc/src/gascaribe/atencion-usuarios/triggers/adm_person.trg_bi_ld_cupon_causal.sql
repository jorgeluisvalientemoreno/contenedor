CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_LD_CUPON_CAUSAL AFTER INSERT OR UPDATE OR DELETE ON LD_CUPON_CAUSAL
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

CUPONUME NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  CUPONUME := :new.CUPONUME;
  OPERATION := 'I';
ELSIF UPDATING THEN
  CUPONUME := :new.CUPONUME;
  OPERATION := 'U';
ELSE
  CUPONUME := :old.CUPONUME;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_LD_CUPON_CAUSAL (
  CUPONUME,
  OPERATION
)
VALUES (
  CUPONUME,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/
