--unidades_de_trabajo
select uo.operating_unit_id,
       uo.name,
       p.person_id,
       p.name_,
       uo.oper_unit_status_id,
       uo.oper_unit_classif_id,
       uo.admin_base_id,
       ba.descripcion,
       mb.empresa  empresa_base,
       uo.es_externa
from or_operating_unit  uo
 inner join ge_base_administra  ba  on ba.id_base_administra = uo.admin_base_id
 left join ge_person p  on p.organizat_area_id = uo.operating_unit_id
 left outer join multiempresa.base_admin  mb  on mb.base_administrativa = uo.admin_base_id
  where 1 = 1
  and p.person_id in (38963,13519) 
 
 
 
  --uo.operating_unit_id in (64)


--update or_operating_unit  uo2  set uo2.admin_base_id = 2 where uo2.operating_unit_id in (67)
