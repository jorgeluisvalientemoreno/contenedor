Select o.order_id, 
       o.task_type_id,
       a.geograp_location_id,
       g.description,
       a.id_items,
       a.descripcion_items,
       a.cantidad,
       a.valor_unitario,
       a.valor_total
from open.ge_detalle_acta  a
inner join  open.ge_acta  ac  on a.id_acta = ac.id_acta
inner join  open.ge_geogra_location g  on g.geograp_location_id = a.geograp_location_id
left outer join open.or_order  o  on a.id_orden = o.order_id
where 1 = 1
 and  a.id_acta in (242256)
order by a.geograp_location_id

/*

-- Script para actualizar localidades del acta

BEGIN
  UPDATE open.ge_detalle_acta a
     SET a.geograp_location_id = CASE 
                                    WHEN a.geograp_location_id = 55 THEN 9134
                                    WHEN a.geograp_location_id = 143 THEN 9038
                                    WHEN a.geograp_location_id = 163 THEN 9016
                                    WHEN a.geograp_location_id = 164 THEN 9077
                                    WHEN a.geograp_location_id = 192 THEN 9121
                                    ELSE a.geograp_location_id
                                 END
   WHERE a.id_acta IN (242256)
     AND a.geograp_location_id IN (55, 143, 163, 164, 192);
  COMMIT;
END;

*/
