CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_USUALEGO_00
  BEFORE INSERT OR UPDATE OF tecnico_unidad ON LDC_USUALEGO
  REFERENCING old AS old new AS new
  for each row
DECLARE

  cursor cuexirelperuniope is
    SELECT /*+ INDEX (p PK_GE_PERSON)*/
    DISTINCT count(p.person_id) cantidad
      FROM open.ge_person p
     WHERE p.person_id in
           (select o.person_id
              from open.or_oper_unit_persons o
             where O.OPERATING_UNIT_ID IN
                   (select o1.operating_unit_id
                      from open.or_oper_unit_persons o1
                     where O1.PERSON_ID = :new.person_id))
       and p.person_id = :new.tecnico_unidad;

  rfcuexirelperuniope cuexirelperuniope%rowtype;

BEGIN
  open cuexirelperuniope;
  fetch cuexirelperuniope
    into rfcuexirelperuniope;
  close cuexirelperuniope;

  if rfcuexirelperuniope.cantidad <= 0 then
    errors.seterror(2741,
                    'El tecnico[' || :new.tecnico_unidad ||
                    '] no se relaciona con el funcionario[' ||
                    :new.person_id || '] por ninguna unidad oprativa.');
    RAISE ex.controlled_error;
  end if;

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE;
  WHEN others THEN
    RAISE;
END;
/
