select sesususc contrato,  c.cosssesu producto ,product_status_id estaprod ,sesucate categ, sesusuca estrato,sesuesco estacort,sesuesfn estafina,
       c.cosspefa pericons,
       c.cosspecs perifact,
       c.cosscoca  consumo,
       c.cossfere fecha ,
       c.cossidre ,
       c.cosscavc regla,
       c.cossmecc metodo,cossdico dias_open , hcppcopr  consprom_open , ( 
       select count (distinct(c1.cosspecs))
       from conssesu c1 
       where c1.cosscoca  >0 
       AND c1.cossflli = 'S'
       and c.cosssesu =c1.cosssesu
       and c1.cossfere >= ADD_MONTHS(l.leemfele, -12)
       ) Num_periodos
from open.conssesu c
inner join servsusc on sesunuse =c.cosssesu
inner join open.pr_product on product_id =  c.cosssesu
inner join open.lectelme l on l.leemsesu= c.cosssesu  and l.leempefa= c.cosspefa 
inner join open.hicoprpm  on  hcppsesu = cosssesu and hcpppeco  = 111149
where c.cosspecs = 111567
 and c.cossmecc in (1,3) and hcpptico = 1
 and c.cosscavc <> 9 and  cossfere >='23/05/2024' 
 order by c.cosssesu , c.cossfere desc
