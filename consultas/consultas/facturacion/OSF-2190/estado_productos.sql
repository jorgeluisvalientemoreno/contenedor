select sesuesco , sesuesfn , sesususc ,sesunuse from servsusc 
where sesuesfn != 'C'AND SESUCICL =4761  and exists (select null from or_order_activity a where a.subscription_id=sesususc and a.task_type_id in (12617) and a.status ='R' ) and rownum <= 20
--update servsusc set sesuesfn ='C' where sesunuse = 17241383

