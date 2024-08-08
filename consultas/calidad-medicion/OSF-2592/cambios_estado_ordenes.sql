--cambios_estado_ordenes
select c.order_stat_change_id,
       c.action_id,
       c.initial_status_id,
       c.final_status_id,
       c.order_id,
       c.stat_chg_date,
       c.user_id,
       c.terminal,
       c.comment_type_id
from or_order_stat_change  c
inner join or_order_activity  a  on a.order_id = c.order_id
where c.order_id  in (323378465)
order by c.order_id, c.stat_chg_date
