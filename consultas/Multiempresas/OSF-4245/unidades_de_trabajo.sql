--unidades_de_trabajo
select uo.operating_unit_id,
       uo.name,
       uo.oper_unit_status_id,
       uo.oper_unit_classif_id,
       uo.admin_base_id,
       ba.descripcion,
       mb.empresa  empresa_base,
       pu.person_id,
       p.name_,
       uo.es_externa
from or_operating_unit  uo
 inner join ge_base_administra  ba  on ba.id_base_administra = uo.admin_base_id
 left outer join or_oper_unit_persons  pu  on pu.operating_unit_id = uo.operating_unit_id
 left outer join ge_person p  on p.person_id = pu.person_id
 left outer join multiempresa.base_admin  mb  on mb.base_administrativa = uo.admin_base_id
  where 1 = 1
  and uo.operating_unit_id in (4642,4858)
  and pu.person_id = 38963
 
 
 
  --uo.operating_unit_id in (64)

  --and   uo.admin_base_id = 25

--update or_operating_unit  uo2  set uo2.admin_base_id = 2 where uo2.operating_unit_id in (67)
