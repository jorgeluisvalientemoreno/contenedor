select p.codigo,
       p.descripcion,
       p.valor_numerico,
       p.valor_cadena,
       p.valor_fecha,
       p.proceso,
       pn.descripcion,
       p.estado,
       p.obligatorio,
       p.fecha_creacion,
       p.fecha_actualizacion,
       p.usuario,
       p.terminal
from parametros  p
left outer join proceso_negocio  pn  on pn.codigo = p.proceso
where p.codigo = 'GDGU_LOCALIDAD_CERREJON'


/*
UPDATE parametros
SET valor_numerico = 9134
WHERE codigo = 'GDGU_LOCALIDAD_CERREJON';
*/
