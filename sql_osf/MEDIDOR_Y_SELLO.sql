--VALIDAR ORDENES A UTILIZAR
Select *
FROM open.OR_ORDER O, open.OR_ORDER_ACTIVITY OA
WHERE O.ORDER_ID = OA.ORDER_ID
AND O.TASK_TYPE_ID in (10100,13322,13324)
AND O.order_status_id in (5)
order by created_date desc;
 
--SI SOLICITA CONTRASEÑA UNIDAD OPERATIVA
select *
from open.or_operating_unit u
where u.operating_unit_id = xxxxx;--UNIDAD OPERATIVA ASOCIADA A LA ot (UNIDAD DE TRABAJO)
 
--ELEMENTO DE MEDICION DISPONIBLE PARA LA UO
select s.id_items_seriado,
       s.items_id,
       s.serie,
       s.id_items_estado_inv,
       e.descripcion,
       s.costo,
       s.fecha_ingreso,
       s.operating_unit_id
  from open.ge_items_seriado s
inner join OPEN.ge_items_estado_inv e
    on e.id_items_estado_inv = s.id_items_estado_inv
where s.id_items_estado_inv = 1
   and s.operating_unit_id = XXXXX;--UNIDAD OPERATIVA
--SELLO
   SELECT *
FROM OPEN.GE_ITEMS_SERIADO D
WHERE ITEMS_ID = 4295812 --ITEM TIPO SELLO
AND D.OPERATING_UNIT_ID = XXX -- UNIDAD OPERATIVA
AND PROPIEDAD = 'E'; --EL SELLO ESTA AUN EN COMPAÑIA
