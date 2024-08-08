--validar_estados_ordenes_agrupadas
select ag.estado, 
       count (distinct ag.orden_agrupadora) cantidad_ot_agrupadas, 
       count (distinct ag.orden) cantidad_ot_individuales
from detalle_ot_agrupada  ag
inner join open.or_order o on o.order_id = ag.orden_agrupadora
where o.created_date >= '22/05/2024 11:00:00'
and   o.saved_data_values = 'ORDER_GROUPED'
group by ag.estado
