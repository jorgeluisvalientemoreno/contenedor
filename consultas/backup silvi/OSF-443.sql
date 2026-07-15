


SELECT   sesususc , sesunuse, ciclcico , pefaactu , sesucate , sesuserv , sesuesco , sesuesfn
FROM SERVSUSC 
Inner join ciclo  on ciclcico = sesucico 
left join open.pericose pc on pc.pecscico=ciclcodi and sysdate between pc.pecsfeci and pc.pecsfecf
left join open.perifact pf on pf.pefacicl=ciclcodi and sysdate between pf.pefafimo and pf.pefaffmo
where ciclcico in (1850, 2050, 5550, 9050, 2401, 2402)
and sesususc = 1058507

select cosssesu, cosspefa, cosscoca, cossmecc , cossfere 
from conssesu c
where cosssesu = 1058507
and cossfere > '01/01/2022'
group by ( cosssesu, cosspefa, cosscoca, cossmecc , cossfere )
order by cossfere desc 

select * 
from conssesu c
where cosssesu = 1058507
order by cossfere desc 
--and cossfere > '01/03/2022'


--ciclo 1850, 2050, 5550, 9050, 2401  , 2402 
