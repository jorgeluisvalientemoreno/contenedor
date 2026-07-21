with intentos as
 (select l.Numeric_Value
    from open.ld_parameter l
   where l.parameter_id = 'CANTIDAD_INTENTOS_ASIGNACION')
SELECT oo1.order_id,
       package_id,
       asignacion Intentos,
       --asignado,
       oo1.Operating_Sector_Id || ' - ' || oos.description SECTOR_ORDEN,
       oo1.created_date Fecha_Creacion,
       --oo1.order_status_id,
       oo1.task_type_id || ' - ' || ott.description TT,
       lo.ordeobse
  FROM open.LDC_ORDER LO
 inner join open.or_order oo1
    on oo1.order_id = lo.order_id
 inner join open.OR_OPERATING_SECTOR oos
    on oos.OPERATING_SECTOR_id = oo1.operating_sector_id
 inner join open.or_task_type ott
    on ott.task_type_id = oo1.task_type_id
 inner join intentos
    on nvl(asignacion, 0) < nvl(Numeric_Value, 0)
 WHERE 1 = 1
   and LO.ASIGNADO = 'N'
--AND &inuOrden IS NULL
 order by oo1.created_date desc
