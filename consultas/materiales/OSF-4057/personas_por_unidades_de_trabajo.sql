--personas_por_unidades_de_trabajo
Select u.operating_unit_id, u.name, p.person_id, pe.name_
 From open.or_operating_unit  u
  inner join or_oper_unit_persons  p  on u.operating_unit_id = p.operating_unit_id
  inner join open.ge_person  pe  on  p.person_id = pe.person_id 
Where 1=1
 and   u.operating_unit_id in (4283)     
 and   p.person_id = 38963        
