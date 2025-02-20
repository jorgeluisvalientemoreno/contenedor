--configuracion_asignacion_automatica_usuarios_especiales
select *
from conf_uo_usu_especiales
where ciclo = 5502
and   sector_operativo in (691, 8479, 679, 644)
--for update
  
-- 3663 = 691, 8479, 679, 644
-- 3662 = 703
--682, 683, 712, 8229
--No configurados: 644, 737, 766, 8406

select name||' | '||operating_unit_id unidad_operativa
from or_operating_unit
where operating_unit_id in (3663, 3662)
