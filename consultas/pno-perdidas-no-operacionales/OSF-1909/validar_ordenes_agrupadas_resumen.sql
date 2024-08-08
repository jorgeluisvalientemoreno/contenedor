--validar_ordenes_agrupadas_resumen
select count (distinct ag.orden_agrupadora) cantidad_ot_agrupadas, 
       count (distinct ag.orden) cantidad_ot_individuales 
from detalle_ot_agrupada  ag
 inner join open.or_order o on o.order_id = ag.orden_agrupadora
where o.created_date >= '21/05/2024 16:00:00'
  and   o.saved_data_values = 'ORDER_GROUPED'
