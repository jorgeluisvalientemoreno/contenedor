--tipo_suspension_por_motivo
select s.motive_id,
       s.suspension_type_id,
       s.register_date,
       s.aplication_date,
       s.ending_date,
       s.connection_code
from mo_suspension  s
inner join mo_motive  m  on m.motive_id = s.motive_id
where m.product_id = 6636558
order by s.register_date desc
