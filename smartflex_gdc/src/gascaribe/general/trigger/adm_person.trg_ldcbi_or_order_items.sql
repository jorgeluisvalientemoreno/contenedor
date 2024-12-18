CREATE OR REPLACE TRIGGER ADM_PERSON.trg_ldcbi_or_order_items 
AFTER INSERT OR UPDATE OR DELETE ON or_order_items
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

order_items_id NUMBER(15);
Is_Delete VARCHAR(1);

BEGIN

IF DELETING THEN
  order_items_id := :old.order_items_id;
  Is_Delete := 'Y';
ELSE
  order_items_id := :new.order_items_id;
  Is_Delete := 'N';
END IF;

INSERT INTO ldcbi_or_order_items (
  order_items_id,
  Is_Delete
)
VALUES (
  order_items_id,
  Is_Delete
);

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
