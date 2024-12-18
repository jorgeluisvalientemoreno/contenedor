CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDCBI_MO_ADDRESS AFTER INSERT OR UPDATE OR DELETE ON mo_address
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

address_id       NUMBER(15);
is_delete        varchar(1) := NULL;

BEGIN

IF DELETING THEN
  address_id := :old.address_id;
  Is_Delete := 'Y';
ELSE
  address_id := :new.address_id;
  Is_Delete := 'N';
END IF;

INSERT INTO ldcbi_mo_address (
    address_id,
    Is_Delete
  )
  VALUES (
    address_id,
    Is_Delete
  );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
