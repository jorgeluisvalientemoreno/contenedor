CREATE OR REPLACE TRIGGER ADM_PERSON.trg_ldcbi_or_order_person 
AFTER INSERT OR UPDATE OR DELETE ON or_order_person
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

operating_unit_id NUMBER(15);
order_id          NUMBER(15);
person_id         NUMBER(15);
Is_Delete         VARCHAR(1);

BEGIN

IF DELETING THEN
  operating_unit_id := :old.operating_unit_id;
  order_id          := :old.order_id;
  person_id         := :old.person_id ;
  Is_Delete         := 'Y';
ELSE
  operating_unit_id := :new.operating_unit_id;
  order_id          := :new.order_id;
  person_id         := :new.person_id;
  Is_Delete         := 'N';
END IF;

INSERT INTO ldcbi_or_order_person (
    operating_unit_id,
    order_id,
    person_id,
    Is_Delete
  )
  VALUES (
    operating_unit_id,
    order_id,
    person_id,
    Is_Delete
 );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
