CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDCBI_FACTURA AFTER INSERT OR UPDATE OR DELETE ON factura
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

factcodi  NUMBER(10);
is_delete varchar(1) := NULL;

BEGIN

IF DELETING THEN
  factcodi := :old.factcodi;
  Is_Delete := 'Y';
ELSE
  factcodi := :new.factcodi;
  Is_Delete := 'N';
END IF;

INSERT INTO ldcbi_factura (
    factcodi,
    Is_Delete
  )
  VALUES (
    factcodi,
    Is_Delete
  );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
