select a.operating_unit_id UNIDAD_OPERATIVA,
       a.person_id || ' - ' || gp.name_ FUNCIONAL
  from OPEN.OR_OPER_UNIT_PERSONS a, open.ge_person gp
 where a.operating_unit_id = 4205
   and gp.person_id = a.person_id;
select a.*, rowid
  from OPEN.OR_OPER_UNIT_PERSONS a
 where a.operating_unit_id = 4205;
