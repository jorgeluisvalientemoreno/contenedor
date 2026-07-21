SELECT to_char(or_oper_unit_persons.person_id) person_id,
       to_char(or_oper_unit_persons.operating_unit_id) || ' - ' || oou.name operating_unit_id,
       to_char(ge_person.person_id) || ' - ' || to_char(ge_person.name_) phantom_column,
       su.user_id || ' - ' || su.mask LOGIN_
  FROM open.or_oper_unit_persons,
       open.ge_person,
       open.sa_user              su,
       open.or_operating_unit    oou
/*+ OR_BCOperUnit_Admin.frfGetOpeUniPersonal SAO181999 */
 WHERE 1 = 1 --and or_oper_unit_persons.operating_unit_id = &inuOperatingUnitId
   AND or_oper_unit_persons.person_id = ge_person.person_id
   and su.user_id = ge_person.user_id
   and su.mask in ('ISAZUL', 'NANLUG')
   and oou.operating_unit_id = or_oper_unit_persons.operating_unit_id
--   and su.mask in ('NANLUG');
