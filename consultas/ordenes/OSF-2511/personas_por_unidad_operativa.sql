select p.operating_unit_id, 
       u.name
from or_oper_unit_persons  p
inner join or_operating_unit  u  on u.operating_unit_id = p.operating_unit_id
where  p.person_id = 38963
and exists (select null
    from ldc_usualego  l  
     where l.person_id = p.person_id)    
 order by u.operating_unit_id desc


-- and p.operating_unit_id = 2152
  
