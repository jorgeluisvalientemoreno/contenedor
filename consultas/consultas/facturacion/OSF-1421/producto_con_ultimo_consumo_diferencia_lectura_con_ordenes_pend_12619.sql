select c1.*
from open.conssesu c1
left join servsusc on c1.cosssesu = sesunuse 
left join perifact f on f.pefacodi = c1.cosspefa 
where  c1.cossfere >= '01/08/2023'
and  c1.cossfere = (select max(c2.cossfere)
                   from conssesu c2
                   where c1.cosssesu = c2.cosssesu)
and c1.cosspefa = (select max(c3.cosspefa)
                     from conssesu c3
                     where c3.cosssesu = c1.cosssesu)
and c1.cossmecc = 1
and not exists (select null
                from procejec c5
                where c5.prejcope = c1.cosspefa
                and c5.prejprog = 'FGCC')
and exists (select null
            from or_order_activity a2
            where a2.product_id = c1.cosssesu
            and a2.task_type_id in (12619)
            and a2.status = 'R'
            and a2.register_date between f.pefafimo and f.pefaffmo)
and sesuesco in (select c.coeccodi from confesco c where c.coecserv= 7014 and c.coecfact= 'S') ; 
