CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_LDC_MARCA_PRODUCTO AFTER INSERT OR UPDATE OR DELETE ON LDC_MARCA_PRODUCTO
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

ID_PRODUCTO NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  ID_PRODUCTO := :new.ID_PRODUCTO;
  OPERATION := 'I';
ELSIF UPDATING THEN
  ID_PRODUCTO := :new.ID_PRODUCTO;
  OPERATION := 'U';
ELSE
  ID_PRODUCTO := :old.ID_PRODUCTO;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_LDC_MARCA_PRODUCTO (
  ID_PRODUCTO,
  OPERATION
)
VALUES (
  ID_PRODUCTO,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/