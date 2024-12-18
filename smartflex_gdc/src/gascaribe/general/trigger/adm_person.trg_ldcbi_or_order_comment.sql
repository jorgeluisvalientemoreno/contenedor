CREATE OR REPLACE TRIGGER ADM_PERSON.trg_ldcbi_or_order_comment 
AFTER INSERT OR UPDATE OR DELETE ON or_order_comment
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

order_comment_id NUMBER(15);
Is_Delete VARCHAR(1);

BEGIN

IF DELETING THEN
  order_comment_id := :old.order_comment_id;
  Is_Delete := 'Y';
ELSE
  order_comment_id := :new.order_comment_id;
  Is_Delete := 'N';
END IF;

INSERT INTO ldcbi_or_order_comment (
  order_comment_id,
  Is_Delete
)
VALUES (
  order_comment_id,
  Is_Delete
);

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
