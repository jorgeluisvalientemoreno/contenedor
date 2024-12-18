CREATE OR REPLACE TRIGGER TRG_LDC_REVLEGORDER
AFTER UPDATE OF order_status_id ON or_order
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
  --
when (new.order_status_id = 8 and new.operating_unit_id = 3598)
Declare
nucapacidad or_operating_unit.used_assign_cap%type;

Cursor cuCapacidad is
SELECT U.USED_ASSIGN_CAP
 FROM OPEN.OR_OPERATING_UNIT U
 WHERE U.OPERATING_UNIT_ID = :new.operating_unit_id ;

begin
  open cuCapacidad;
  fetch cuCapacidad into nucapacidad;
  if cuCapacidad%notfound then
    nucapacidad := -1;
  end if;
  close cuCapacidad;

  insert into LDC_REVLEGORDER values (:new.order_id, sysdate, :new.operating_unit_id, nucapacidad);

EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
