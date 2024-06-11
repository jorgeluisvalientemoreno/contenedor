select *
  from open.ge_acta a
 where a.estado = 'A'
   and a.id_tipo_acta in (1, 3)
 order by fecha_creacion desc
