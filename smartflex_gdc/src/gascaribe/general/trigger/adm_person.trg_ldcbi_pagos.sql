CREATE OR REPLACE TRIGGER ADM_PERSON.trg_ldcbi_pagos 
AFTER INSERT OR UPDATE OR DELETE ON pagos
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

pagocupo         NUMBER(15);
is_delete        varchar(1) := NULL;

BEGIN

IF DELETING THEN
  pagocupo := :old.pagocupo;
  Is_Delete := 'Y';
ELSE
  pagocupo := :new.pagocupo;
  Is_Delete := 'N';
END IF;

INSERT INTO ldcbi_pagos (
    pagocupo,
    Is_Delete
  )
  VALUES (
    pagocupo,
    Is_Delete
  );

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
