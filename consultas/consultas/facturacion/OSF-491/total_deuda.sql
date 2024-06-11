select (select  nvl(sum(decode(difesign, 'DB', difesape, -difesape)),0)           
       from open.diferido                
       where difenuse = 758990                
       and difetire = 'D'                 
       and difesign in ('DB', 'CR')                 
       and difesape > 0                 
       and nvl(difeenre, 'N') = 'N') as Saldo_Diferido, 
       (select nvl(sum(cucosacu),0)            
       from open.cuencobr              
       where cuconuse = 758990               
       and nvl(cucosacu,0) > 0                
       and nvl(cucovare,0) = 0                
       and nvl(cucovrap,0) = 0) as Saldo_Corriente 
from dual;