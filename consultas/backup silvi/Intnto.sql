select * 
from procejec p
left join open.perifact pf on prejcope = pefacodi /* and sysdate between pf.pefafimo and pf.pefaffmo*/
left join open.ciclo  c on  pf.pefacicl=c.ciclcodi
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
and geograp_location_id  = 5    
order by prejfech desc     
          

