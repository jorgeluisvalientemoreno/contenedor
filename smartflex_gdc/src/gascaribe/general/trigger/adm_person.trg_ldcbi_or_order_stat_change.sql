CREATE OR REPLACE TRIGGER ADM_PERSON.trg_ldcbi_or_order_stat_change 
AFTER INSERT OR UPDATE OR DELETE ON or_order_stat_change
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

order_stat_change_id NUMBER(15);
is_delete varchar(1) := NULL;

BEGIN

IF DELETING THEN
  order_stat_change_id := :old.order_stat_change_id;
  Is_Delete := 'Y';
ELSE
  order_stat_change_id := :new.order_stat_change_id;
  Is_Delete := 'N';
END IF;

INSERT INTO ldcbi_or_order_stat_change (
    order_stat_change_id,
    Is_Delete
  )
  VALUES (
    order_stat_change_id,
    Is_Delete
  );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
