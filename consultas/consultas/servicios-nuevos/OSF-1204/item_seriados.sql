select s.id_items_seriado,
       s.items_id,
       s.serie,
       s.id_items_estado_inv,
       e.descripcion,
       s.costo,
       s.fecha_ingreso
  from open.ge_items_seriado s
 inner join ge_items_estado_inv e on e.id_items_estado_inv = s.id_items_estado_inv
 where s.operating_unit_id = 3624
 order by s.fecha_ingreso desc
