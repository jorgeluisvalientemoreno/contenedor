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
