select *
from ldc_calificacion_cons
where  codigo_calificacion = 2004

/*
select sesunuse , sesususc, sesucicl, sesucate , cosspefa , cossmecc , cossfere 
from servsusc 
left join lectelme on leemsesu = sesunuse 
left join conssesu on leemsesu = cosssesu and cosspefa =leempefa 
where cosspefa in (select max(c.cosspefa) from conssesu c where c.cosssesu=sesunuse and c.cossmecc = 3)
and sesucate = 2
and cossmecc = 3
--and leemoble in (79,80,59,71)
and leempefa in ( select max(c.cosspefa) from conssesu c where c.cosssesu=leemsesu and c.cossmecc = 3)
and sesucicl in (8414, 8114)
and rownum <= 10 */
