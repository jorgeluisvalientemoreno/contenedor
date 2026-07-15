select c.ciclcodi, pf.pefacodi, pf.pefaano, pf.pefames, pf.pefafimo, pf.pefaffmo, pf.pefacicl, pf.pefaactu
from ciclo c 
left join open.perifact pf on pf.pefacicl=c.ciclcodi
left join procejec p on pf.pefacicl=c.ciclcodi
left join ab_segments  ab on  ab.ciclcodi =  c.ciclcodi
where exists ( select null 
              from  procejec pe 
              where   p.prejcope =  pe.prejcope
              and  prejprog in ('FCRI')
              and prejespr = 'T')
and (select count(1)
      from procejec po 
      where p.prejcope =  po.prejcope
      and  prejprog in ('FGCA', 'FGCC') ) = 0 
/*and pefaactu = 'N'*/
and geograp_location_id  = 5    
and pefaffmo between '01/10/2022'  and '01/11/2022'
group by (c.ciclcodi, pf.pefacodi, pf.pefaano, pf.pefames, pf.pefafimo, pf.pefaffmo, pf.pefacicl, pf.pefaactu)
