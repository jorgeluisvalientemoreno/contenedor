CREATE OR REPLACE TRIGGER TRG_LDC_REVCAPUSADA
AFTER UPDATE OF USED_ASSIGN_CAP ON OR_OPERATING_UNIT
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
when (new.operating_unit_id = 3598)
Declare

begin

  insert into LDC_REVCAPUSADA values (sysdate, :old.operating_unit_id, :old.used_assign_cap, :new.used_assign_cap);

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
