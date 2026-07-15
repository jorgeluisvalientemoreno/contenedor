select distinct( cosssesu),
       sesuesco,
       cosspefa,
       cossfunc,
       cosscoca,
       cossmecc,
       cossflli,
       cossdico,
       cossfere,
       cossfufa,
       cosscavc
from open.conssesu c1
left join  open.servsusc on c1.cosssesu = sesunuse
where c1.cossfere = (select max(c3.cossfere) from  open.conssesu c3 where c1.cosssesu = c3.cosssesu)
and exists ( select null
            from  open.conssesu c4
            where c1.cosssesu = c4.cosssesu
            and c4.cossmecc = 3
            and c4.cosspefa= c1.cosspefa)
and c1.cossfere <= '26/02/2023'
and sesuesco in (1)
--and cosssesu = 6623173
and rownum <= 10
