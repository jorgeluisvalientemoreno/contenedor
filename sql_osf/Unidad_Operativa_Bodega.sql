SELECT or_operating_unit.operating_unit_id    id,
       or_operating_unit.name                 description,
       or_operating_unit.admin_base_id,
       or_operating_unit.oper_unit_classif_id
  FROM or_operating_unit /*+ GE_BOItemsLoV.GetOperUnitsByORPTM SAO186231 */
 WHERE or_operating_unit.person_in_charge = ge_bopersonal.fnugetpersonid
    OR or_operating_unit.operating_unit_id in
       (SELECT b.operating_unit_id
          FROM or_oper_unit_persons b, or_operating_unit c
         WHERE b.person_id = ge_bopersonal.fnugetpersonid
           AND b.operating_unit_id = c.operating_unit_id)
   and (select count(1)
          from or_ope_uni_item_bala a
         where a.operating_unit_id = or_operating_unit.operating_unit_id
           and a.balance > 0) > 0;
SELECT or_operating_unit.operating_unit_id    id,
       or_operating_unit.name                 description,
       or_operating_unit.admin_base_id,
       or_operating_unit.oper_unit_classif_id
  FROM or_operating_unit /*+ GE_BOItemsLoV.GetOperUnitsByORPTM SAO186231 */
 WHERE or_operating_unit.person_in_charge = ge_bopersonal.fnugetpersonid
    OR or_operating_unit.operating_unit_id in
       (SELECT b.operating_unit_id
          FROM or_oper_unit_persons b, or_operating_unit c
         WHERE b.person_id = ge_bopersonal.fnugetpersonid
           AND b.operating_unit_id = c.operating_unit_id)
   and (select count(1)
          from or_ope_uni_item_bala a
         where a.operating_unit_id = or_operating_unit.operating_unit_id
           and a.balance > 0) = 0
           
