select o.order_id,sesuesco,sesucate,sesuesfn,pr.product_status_id,
       a.product_id, s.sesucicl
from or_order o
inner join or_order_Activity a on a.order_id=o.order_id
inner join servsusc s on a.product_id = s.sesunuse
inner join pr_product pr on sesunuse = pr.product_id 
where o.task_type_id in (12617)
and o.order_status_id in (0,5) and sesucate = 1
and  ldc_bssreglasproclecturas.fnuvecesconsumoestimado(sesunuse)>24 
;     
      
select ldc_bssreglasproclecturas.fnuvecesconsumoestimado(50104975)from dual ;



select o.order_id,sesuesco,sesucate,sesuesfn,pr.product_status_id,
       a.product_id, s.sesucicl
from or_order o
inner join or_order_Activity a on a.order_id=o.order_id
inner join servsusc s on a.product_id = s.sesunuse
inner join pr_product pr on sesunuse = pr.product_id 
where o.task_type_id in (12617)
and o.order_status_id in (0,5) and sesucate = 1
and ( select count (distinct l.leemleto)
      from lectelme l 
      where l.leemsesu= sesunuse 
      and l.leemclec = 'F' 
      and l.leemfele >= add_months( sysdate , -24)) = 1
