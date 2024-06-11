select p.codigo,
       p.descripcion,
       p.valor_numerico,
       p.valor_cadena,
       p.valor_fecha,
       p.proceso,
       n.descripcion,
       p.fecha_creacion,
       p.fecha_actualizacion,
       p.usuario,
       p.terminal
  from personalizaciones.parametros  p
  left join personalizaciones.proceso_negocio  n  on n.codigo = p.proceso
 where p.codigo = 'COD_ITEMS_LECTURA_INDUS'
