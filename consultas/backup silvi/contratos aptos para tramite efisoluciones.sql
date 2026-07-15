select subscriber_id,
       sesususc,
       sesunuse ,
       sesuserv ,
       sesuesfn,
       sesuesco,
       susccicl,
       pf.pefafimo,
       pf.pefaffmo, pf.pefaactu
from open.ge_subscriber ge
left join open.suscripc s  on s.suscclie = ge.subscriber_id  
left join open.servsusc ss on ss.sesususc = s.susccodi 
left join open.ciclo c on sesucicl = ciclcodi
left join open.perifact pf on pf.pefacicl=ciclcodi and sysdate between pf.pefafimo and pf.pefaffmo
where sesuesfn <> 'C'
and sesuserv not in (7014)
and sesucicl in (1725) 
and sesuesco <> 95
and rownum <= 10



SELECT coecfact FROM confesco
 WHERE coecserv = (SELECT sesuserv FROM servsusc WHERE sesunuse = 533290) 
 AND coeccodi = (SELECT sesuesco FROM servsusc WHERE sesunuse = 533290)
 


select pldicodi,pldidesc,pldifein,pldifefi,pldicumi,pldicuma  
from open.plandife
where (sysdate between pldifein and pldifefi)
and pldipmaf = 100
and pldicodi = 115
order by pldicodi;
-- 321 , 381 , 181,182
--and pldicodi in ( 23,24,26,28,31,64,142)
