--unidades_de_trabajo
select uo.operating_unit_id,
       uo.name,
       uo.oper_unit_status_id,
       uo.oper_unit_classif_id,
       uo.admin_base_id,
       ba.descripcion,
       mb.empresa  empresa_base,
       uo.es_externa,
       uo.contractor_id,
       c.descripcion,
       mc.empresa  empresa_contratista
from or_operating_unit  uo
 inner join ge_base_administra  ba  on ba.id_base_administra = uo.admin_base_id
 left outer join ge_contratista  c  on c.id_contratista = uo.contractor_id
 left outer join multiempresa.contratista  mc  on mc.contratista = c.id_contratista
 left outer join multiempresa.base_admin  mb  on mb.base_administrativa = uo.admin_base_id
  where 1 = 1
  and uo.es_externa = 'Y'
  and uo.operating_unit_id = 4594



--update multiempresa.base_admin  mb set mb.empresa = 'GDGU'  where mb.base_administrativa = 2
--update multiempresa.contratista  mc set mc.empresa = 'GDGU'  where mc.contratista = 3
