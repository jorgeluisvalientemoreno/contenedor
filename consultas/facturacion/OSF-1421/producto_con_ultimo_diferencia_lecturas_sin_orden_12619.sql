select c1.*
from open.conssesu c1
left join servsusc on c1.cosssesu = sesunuse 
where c1.cossfere = (select max(c2.cossfere)
                   from conssesu c2
                   where c1.cosssesu = c2.cosssesu)
and c1.cosspefa = (select max(c3.cosspefa)
                     from conssesu c3
                     where c3.cosssesu = c1.cosssesu)
and c1.cossmecc = 1
and not exists (select null
                from conssesu c5
                where c5.cosssesu=c1.cosssesu
                and c5.cosspefa= c1.cosspefa
                and c5.cossmecc  in (4) 
                and c5.cossflli = 'S')
and c1.cossfere >= '01/09/2022'
/*and exists (select 1
            from conssesu c4
            where c4.cosssesu=c1.cosssesu
            and c4.cosspefa<c1.cosspefa
            and c4.cossmecc  in (1))*/
and exists (select null
            from or_order_activity a1
            where a1.product_id = c1.cosssesu
            and a1.task_type_id in (10074,10075,11260,10534,12143,10933,10951,10764,11027,11028,11033,11034,11094,10720)
            and a1.status = 'R')
and not exists (select null
            from or_order_activity a2
            where a2.product_id = c1.cosssesu
            and a2.task_type_id in (12619)
            and a2.status = 'R')
and sesuesco in (select c.coeccodi from confesco c where c.coecserv= 7014 and c.coecfact= 'S') ; 