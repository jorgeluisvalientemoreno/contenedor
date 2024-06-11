select lectelme.leemsesu,
       elmesesu.emsscoem, 
       lectelme.leemlean,
       lectelme.leemfela,
       lectelme.leemleto, 
       lectelme.leemfele,
       lectelme.leemoble,
       conssesu.cosspefa,
       conssesu.cosspecs ,
       conssesu.cosscoca ,
       conssesu.cossmecc,
       conssesu.cossfere,
       conssesu.cosstcon , 
       lectelme.leemtcon,
       lectelme.leemclec  
from lectelme 
left join elmesesu  on lectelme.leemelme = elmesesu.emsselme
left join conssesu  on leemsesu = conssesu.cosssesu and conssesu.cosspefa = lectelme.leempefa 
where   lectelme.leemsesu in (6500507)
and   conssesu.cossmecc <> 4
order by lectelme.leemfele desc;