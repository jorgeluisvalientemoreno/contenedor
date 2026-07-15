select p.product_id,
       p.product_status_id,
       p.suspen_ord_act_id,
       (select t.task_type_id||'-'||t.description
          from open.or_order_activity a 
          join open.or_Task_type t on t.task_type_id=a.task_type_id
          where a.order_activity_id = p.suspen_ord_act_id) suspension,
       sesunuse,
       sesueste,
       (select etsedesc from gasgg.esteserv where etsecodi=sesueste) desc_estado
from pr_product p
join gasgg.servsusc on sesunuse=p.product_id-3300000
where exists(select null from migragg.pr_product m where m.product_id=p.product_id)
  and p.product_status_id=2
  and (p.suspen_ord_act_id is null or
       not exists(select null from pr_prod_suspension s where s.product_id=p.product_id and s.active='Y')
       )
  and sesueste not in (11,14)
   
