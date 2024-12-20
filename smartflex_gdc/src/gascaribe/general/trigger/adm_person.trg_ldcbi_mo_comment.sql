CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDCBI_MO_COMMENT AFTER INSERT OR UPDATE OR DELETE ON MO_COMMENT
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

comment_id NUMBER(15);
Is_Delete VARCHAR(1);

BEGIN

IF DELETING THEN
  comment_id := :old.comment_id;
  Is_Delete := 'Y';
ELSE
  comment_id := :new.comment_id;
  Is_Delete := 'N';
END IF;

INSERT INTO LDCBI_MO_COMMENT (
  comment_id,
  Is_Delete
)
VALUES (
  comment_id,
  Is_Delete
);

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
