select s.id_items_seriado,
       s.items_id,
       s.serie,
       s.id_items_estado_inv,
       e.descripcion,
       s.costo,
       s.fecha_ingreso
  from open.ge_items_seriado s, ge_items_estado_inv e
 where s.operating_unit_id = 4604
   and s.id_items_estado_inv = 1
   And s.id_items_estado_inv = e.id_items_estado_inv
 order by s.fecha_ingreso desc
