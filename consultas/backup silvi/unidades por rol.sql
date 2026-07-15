select uo.operating_unit_id,
       uo.name,
       uo.oper_unit_status_id,
       uo.oper_unit_classif_id,
       uo.operating_zone_id ,
       z.description Nombre_Zona,
       uu.id_rol ,
       sa.name Nombre_Rol, 
       uo.admin_base_id,
       ba.descripcion Nombre_Base,
       mb.empresa  empresa_base,
       uo.orga_area_id,
       uo.UNIT_TYPE_ID,
       uo.es_externa,
       uo.contractor_id,
       c.descripcion,
       mc.empresa  empresa_contratista
from open.or_operating_unit  uo
 inner join open.ge_base_administra  ba  on ba.id_base_administra = uo.admin_base_id
 left outer join open.ge_contratista  c  on c.id_contratista = uo.contractor_id
 left outer join open.contratista  mc  on mc.contratista = c.id_contratista
 left outer join open.base_admin  mb  on mb.base_administrativa = uo.admin_base_id
 left outer join open.or_rol_unidad_trab uu on  uu.id_unidad_operativa = uo.operating_unit_id
left outer join open.sa_role sa on uu.id_rol  = sa.role_id
left outer join OPEN.OR_OPERATING_ZONE z on uo.operating_zone_id= z.operating_zone_id
  where 1 = 1
   and mb.empresa = 'GDGU'
order by uo.operating_unit_id
