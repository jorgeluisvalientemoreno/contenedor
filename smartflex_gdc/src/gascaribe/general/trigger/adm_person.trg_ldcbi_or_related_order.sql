CREATE OR REPLACE TRIGGER ADM_PERSON.trg_ldcbi_or_related_order 
AFTER INSERT OR UPDATE OR DELETE ON or_related_order
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

order_id            NUMBER(15);
related_order_id    NUMBER(15);
rela_order_type_id  NUMBER(10);
Is_Delete           varchar(1) := NULL;

BEGIN

IF DELETING THEN
  order_id           := :old.order_id;
  related_order_id   := :old.related_order_id;
  rela_order_type_id := :old.rela_order_type_id;
  Is_Delete := 'Y';
ELSE
  order_id           := :new.order_id;
  related_order_id   := :new.related_order_id;
  rela_order_type_id := :new.rela_order_type_id;
  Is_Delete := 'N';
END IF;

INSERT INTO ldcbi_or_related_order (
    order_id,
    related_order_id,
    rela_order_type_id,
    Is_Delete
  )
  VALUES (
    order_id,
    related_order_id,
    rela_order_type_id,
    Is_Delete
  );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
