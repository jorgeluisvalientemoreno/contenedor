--consumos_recuperados
select *
from open.conssesu c1
left join open.servsusc on servsusc.sesunuse =  c1.cosssesu
where cossmecc= 5  and cossfere >='01/12/2024' 
and sesuesfn !='C'
and not exists ( select null 
                 from open.conssesu c2 
                 where c1.cosssesu = c2.cosssesu 
                 and c1.cosspefa=c2.cosspefa 
                 and cossmecc=4 
                 and cossflli='S')
and rownum<= 10
order by cossfere desc 
