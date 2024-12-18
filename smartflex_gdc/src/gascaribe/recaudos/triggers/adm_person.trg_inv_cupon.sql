CREATE OR REPLACE trigger ADM_PERSON.TRG_INV_CUPON
  after insert or update or delete on cupon
  referencing old as old new as new
  for each row
declare
  -- local variables here
  TIPOEVENTO VARCHAR(10);
  CUPONUME   NUMBER(10);
begin

  IF INSERTING THEN
    TIPOEVENTO := 'INSERT';
    CUPONUME   := :new.cuponume;
  ELSIF UPDATING THEN
    TIPOEVENTO := 'UPDATE';
    CUPONUME   := :old.cuponume;
  ELSIF DELETING THEN
    TIPOEVENTO := 'DELETE';
    CUPONUME   := :old.cuponume;
  ELSE
    TIPOEVENTO := 'OTHER';
    CUPONUME   := :old.cuponume;
  END IF;

  INSERT INTO LDCI_INNOVACION_LOG_CUPON
    (LOG_ID, CUPONUME, EVENT_TYPE, REGISTER_DATE)
  VALUES
    (SEQ_LDCI_INNOVACION_LOG_CUPON.NEXTVAL, CUPONUME, TIPOEVENTO, SYSDATE);

end TRG_INV_CUPON;
/
