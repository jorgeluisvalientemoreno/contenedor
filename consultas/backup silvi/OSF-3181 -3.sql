select distinct( c.cosssesu ), 
       sesucicl ,
       sesucate ,
       sesuesco
from conssesu c
inner join servsusc on sesunuse = c.cosssesu
where cossfere >= add_months( sysdate , -26)
and c.cossmecc = 3 and cosscoca = 0
and not exists ( select null
               from conssesu c1
               where c.cosssesu = c1.cosssesu
               and c1.cossfere >= add_months( sysdate , -26)
               and cossmecc  in (1,5) )
and exists ( select null
             from or_order_activity a
             where a.product_id =  c.cosssesu
             and a.task_type_id= 12617
             and a.status='R')
and not exists ( select null
               from conssesu c2
               where c.cosssesu = c2.cosssesu
               and c2.cossfere >= add_months( sysdate , -26)
               and c2.cosscoca >0 )
and exists ( select null
            from lectelme l
            where l.leemsesu = c.cosssesu
            and leemleto is not null
            and leemfele >=  add_months( sysdate , -2)) 
group by sesucicl , sesucate , sesuesco , c.cosssesu
