CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_LDC_DEPRTATT AFTER INSERT OR UPDATE OR DELETE ON LDC_DEPRTATT
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

DPTTSESU NUMBER(15);
DPTTPERI NUMBER(15);
DPTTPECO NUMBER(15);
DPTTCONC NUMBER(15);
DPTTRANG VARCHAR2(100);
DPTTVANO NUMBER(15);
OPERATION VARCHAR2(1);


BEGIN

IF INSERTING THEN
  DPTTSESU := :new.DPTTSESU;
  DPTTPERI := :new.DPTTPERI;
  DPTTPECO := :new.DPTTPECO;
  DPTTCONC := :new.DPTTCONC;
  DPTTRANG := :new.DPTTRANG;
  DPTTVANO := :new.DPTTVANO;
  OPERATION := 'I';
ELSIF UPDATING THEN
  DPTTSESU := :new.DPTTSESU;
  DPTTPERI := :new.DPTTPERI;
  DPTTPECO := :new.DPTTPECO;
  DPTTCONC := :new.DPTTCONC;
  DPTTRANG := :new.DPTTRANG;
  DPTTVANO := :new.DPTTVANO;
  OPERATION := 'U';
ELSE
  DPTTSESU := :old.DPTTSESU;
  DPTTPERI := :old.DPTTPERI;
  DPTTPECO := :old.DPTTPECO;
  DPTTCONC := :old.DPTTCONC;
  DPTTRANG := :old.DPTTRANG;
  DPTTVANO := :old.DPTTVANO;
  OPERATION := 'D';
END IF;

INSERT INTO LDCBI_LDC_DEPRTATT (
  DPTTSESU,
  DPTTPERI,
  DPTTPECO,
  DPTTCONC,
  DPTTRANG,
  DPTTVANO,
  OPERATION
)
VALUES (
  DPTTSESU,
  DPTTPERI,
  DPTTPECO,
  DPTTCONC,
  DPTTRANG,
  DPTTVANO,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/