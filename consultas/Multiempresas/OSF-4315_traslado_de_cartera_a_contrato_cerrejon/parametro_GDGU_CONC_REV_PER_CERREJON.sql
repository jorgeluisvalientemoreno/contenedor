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
where p.codigo = 'GDGU_CONC_REV_PER_CERREJON'

/*
UPDATE parametros
SET valor_cadena = '739, 1086, 203, 603, 1026,'
WHERE codigo = 'GDGU_CONC_REV_PER_CERREJON';
*/

