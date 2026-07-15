select cosssesu ,cosspefa ,leempefa,cosscoca ,cossmecc,leemoble,obledesc  , cossfere , cossidre , cosscavc , cossflli 
from lectelme
left join conssesu on leemsesu = cosssesu and cosspefa =leempefa 
left join obselect on leemoble = oblecodi
where leemsesu =17231400; 

SELECT *
FROM LECTELME 
WHERE  leemsesu =50055789
ORDER BY  leemfele desc ;
--FOR UPDATE 
 

select *
from conssesu 
where cosssesu =50070426
--and cossfere > '19/01/2023'
order by cossfere desc ;
--for update 

select *
from MECACONS ; 


select sesususc, sesunuse , sesuserv, sesucate , sesucicl 
from servsusc 
where sesucate = 2 
and sesunuse =51251790;


select *
from conssesu
where cosssesu = 50062473
order by cossfere desc ; 


select *
from tipocons ; 
