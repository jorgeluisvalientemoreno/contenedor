CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDCBI_PR_PRODUCT
AFTER INSERT OR UPDATE OR DELETE ON OPEN.PR_PRODUCT

REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE
PRODUCT_ID NUMBER(15);
IS_DELETE VARCHAR(1);

BEGIN

IF DELETING THEN
  PRODUCT_ID := :old.PRODUCT_ID;
  IS_DELETE := 'Y';
ELSE
  PRODUCT_ID := :new.PRODUCT_ID;
  IS_DELETE := 'N';
END IF;

INSERT INTO OPEN.LDCBI_PR_PRODUCT (
  PRODUCT_ID,
  IS_DELETE
)
VALUES (
  PRODUCT_ID,
  IS_DELETE
);

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/