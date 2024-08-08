--consultas_de_apoyo

--Crear tabla espejo
create table detalle_ot_agrupada_copia (
orden_agrupadora        NUMBER(15),
orden                   NUMBER(15),
fecha_procesada         DATE,
estado                  VARCHAR2(2));

--Insertar registro a tabla espejo
insert into detalle_ot_agrupada_copia  (orden_agrupadora,
       orden,
       fecha_procesada,
       estado)
       select orden_agrupadora,
       orden,
       fecha_procesada,
       estado
   from detalle_ot_agrupada
   where fecha_procesada >= '21/05/2024 11:00:00';

-- Consultar tabla espejo   
select count (distinct ag.orden_agrupadora) cantidad_ot_agrupadas,
       count (distinct ag.orden) cantidad_ot_individuales
from detalle_ot_agrupada_copia  ag;

-- Consultar tabla original   
select count (distinct ag.orden_agrupadora) cantidad_ot_agrupadas, 
       count (distinct ag.orden) cantidad_ot_individuales
from detalle_ot_agrupada  ag
 inner join open.or_order o on o.order_id = ag.orden_agrupadora
where o.created_date >= '21/05/2024 16:00:00'
  and   o.saved_data_values = 'ORDER_GROUPED'

-- Eliminar registro a tabla original
delete 
from detalle_ot_agrupada c
where c.fecha_procesada >= '21/05/2024 11:00:00';

