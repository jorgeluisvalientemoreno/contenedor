--centros_de_costos_por_unidad_de_trabajo
select cc.cecocodi,
       cc.cecodesc,
       cc.cecobpri,
       cc.cecobing,
       co.operating_unit_id,
       uo.name,
       mb.empresa  empresa_base
from ldci_centrocosto cc
left outer join ldci_cecounioper co  on co.cecocodi = cc.cecocodi
left outer join or_operating_unit  uo  on uo.operating_unit_id = co.operating_unit_id
left outer join ge_base_administra  ba  on ba.id_base_administra = uo.admin_base_id
left outer join multiempresa.base_admin  mb  on mb.base_administrativa = uo.admin_base_id
where co.operating_unit_id in (4858,4642,1878)
