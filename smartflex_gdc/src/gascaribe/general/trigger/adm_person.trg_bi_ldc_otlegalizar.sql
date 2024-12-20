CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_LDC_OTLEGALIZAR AFTER INSERT OR UPDATE OR DELETE ON LDC_OTLEGALIZAR
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

ORDER_ID NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  ORDER_ID := :new.ORDER_ID;
  OPERATION := 'I';
ELSIF UPDATING THEN
  ORDER_ID := :new.ORDER_ID;
  OPERATION := 'U';
ELSE
  ORDER_ID := :old.ORDER_ID;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_LDC_OTLEGALIZAR (
  ORDER_ID,
  OPERATION
)
VALUES (
  ORDER_ID,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/
