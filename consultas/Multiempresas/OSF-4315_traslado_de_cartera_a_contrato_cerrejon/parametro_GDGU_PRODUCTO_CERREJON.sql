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
where p.codigo = 'GDGU_PRODUCTO_CERREJON'

/*
UPDATE parametros
SET valor_numerico = 1000650
WHERE codigo = 'GDGU_PRODUCTO_CERREJON';
*/



/*select *
from pr_product
where product_id = 1000650
*/
