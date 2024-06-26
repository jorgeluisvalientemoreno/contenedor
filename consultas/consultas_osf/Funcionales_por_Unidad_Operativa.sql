SELECT to_char(or_oper_unit_persons.person_id) person_id,
       to_char(or_oper_unit_persons.operating_unit_id) operating_unit_id,
       to_char(ge_person.person_id) || ' - ' || to_char(ge_person.name_) phantom_column
  FROM or_oper_unit_persons, ge_person
/*+ OR_BCOperUnit_Admin.frfGetOpeUniPersonal SAO181999 */
 WHERE or_oper_unit_persons.operating_unit_id = inuOperatingUnitId
   AND or_oper_unit_persons.person_id = ge_person.person_id;
