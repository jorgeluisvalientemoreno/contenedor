CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_OR_REQU_DATA_VALUE AFTER INSERT OR UPDATE OR DELETE ON OR_REQU_DATA_VALUE
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

ORDER_ID NUMBER(15);
ATTRIBUTE_SET_ID NUMBER(15);
TASK_TYPE_ID NUMBER(15);
ACTION_ID NUMBER(15);
READ_DATE DATE;
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  ORDER_ID := :new.ORDER_ID;
  ATTRIBUTE_SET_ID := :new.ATTRIBUTE_SET_ID;
  TASK_TYPE_ID := :new.TASK_TYPE_ID;
  ACTION_ID := :new.ACTION_ID;
  READ_DATE := :new.READ_DATE;
  OPERATION := 'I';
ELSIF UPDATING THEN
  ORDER_ID := :new.ORDER_ID;
  ATTRIBUTE_SET_ID := :new.ATTRIBUTE_SET_ID;
  TASK_TYPE_ID := :new.TASK_TYPE_ID;
  ACTION_ID := :new.ACTION_ID;
  READ_DATE := :new.READ_DATE;
  OPERATION := 'U';
ELSE
  ORDER_ID := :old.ORDER_ID;
  ATTRIBUTE_SET_ID := :old.ATTRIBUTE_SET_ID;
  TASK_TYPE_ID := :old.TASK_TYPE_ID;
  ACTION_ID := :old.ACTION_ID;
  READ_DATE := :old.READ_DATE;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_OR_REQU_DATA_VALUE (
  ORDER_ID,
  ATTRIBUTE_SET_ID,
  TASK_TYPE_ID,
  ACTION_ID,
  READ_DATE,
  OPERATION
)
VALUES (
  ORDER_ID,
  ATTRIBUTE_SET_ID,
  TASK_TYPE_ID,
  ACTION_ID,
  READ_DATE,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/
