CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_MOVISAFA 
AFTER INSERT OR UPDATE OR DELETE ON MOVISAFA
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

MOSFCONS NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  MOSFCONS := :new.MOSFCONS;
  OPERATION := 'I';
ELSIF UPDATING THEN
  MOSFCONS := :new.MOSFCONS;
  OPERATION := 'U';
ELSE
  MOSFCONS := :old.MOSFCONS;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_MOVISAFA (
  MOSFCONS,
  OPERATION
)
VALUES (
  MOSFCONS,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/
