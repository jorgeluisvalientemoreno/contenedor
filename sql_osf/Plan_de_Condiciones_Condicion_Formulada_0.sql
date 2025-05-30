select a.*, rowid
  from OPEN.CT_CONDITIONS_PLAN a
 where a.conditions_plan_id = 36;

select pc.conditions_plan_id, s.*
  from open.CT_CONDITIONS_BY_PLAN pc, open.ct_conditions s
 where pc.conditions_id = s.conditions_id
   and s.conditions_id = 261
   and pc.conditions_plan_id not in
       (select pc1.condition_by_plan_id
        --pc1.*
          from open.CT_CONDITIONS_BY_PLAN pc1, open.ct_conditions s1
         where pc1.conditions_id = s1.conditions_id
           and s1.conditions_id = 593)
 order by pc.conditions_plan_id;

select a.*, rowid
  from OPEN.CT_CONDITIONS A
 where 'SOBRETASA RETEICA' = DESCRIPTION;
select a.*, rowid from OPEN.CT_CONDITIONS A where a.conditions_id = 36;

select * --.conditions_plan_id, s.*
  from open.CT_CONDITIONS_BY_PLAN pc, open.ct_conditions s
 where pc.conditions_id = s.conditions_id
   and pc.conditions_plan_id = 36 --s.conditions_id = 595
 order by pc.conditions_plan_id;

select pc.*
  from open.ct_conpla_con_type pc
 where pc.contract_type_id = 1910;
