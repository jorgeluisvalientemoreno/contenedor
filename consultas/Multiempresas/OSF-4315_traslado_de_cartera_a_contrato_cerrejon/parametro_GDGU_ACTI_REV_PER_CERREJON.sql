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
where p.codigo = 'GDGU_ACTI_REV_PER_CERREJON'


/*
UPDATE parametros
SET valor_cadena = '100003630,100003631,100003629,100003632,100003634,100003638,100003639,100003640,'
WHERE codigo = 'GDGU_ACTI_REV_PER_CERREJON';
*/
