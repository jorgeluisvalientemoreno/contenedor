CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_LD_PROMISSORY_PU AFTER INSERT OR UPDATE OR DELETE ON LD_PROMISSORY_PU
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

promissory_id NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  promissory_id := :new.promissory_id;
  OPERATION := 'I';
ELSIF UPDATING THEN
  promissory_id := :new.promissory_id;
  OPERATION := 'U';
ELSE
  promissory_id := :old.promissory_id;
  OPERATION := 'D';
END IF;

INSERT INTO OPEN.LDCBI_LD_PROMISSORY_PU (
  promissory_id,
  OPERATION
)
VALUES (
  promissory_id,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20000,
                            'Error en TRG_BI_LD_PROMISSORY_PU por -->' || sqlcode ||
                            chr(13) || sqlerrm);
END;
/
