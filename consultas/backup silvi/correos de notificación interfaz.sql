select *
from LDCI_CORTINTE b
where  activo = 'S'
 and tipointe= 2
 
 select *
  from LDCI_CORTINTE b, IC_TICOCONT a
 where a.tccocodi = b.tipointe
   --and substr(a.tccodesc,1,2) = isbtipointe
   and activo = 'S'
   
   
   update LDCI_CORTINTE b
 set correo='sjurado@findingtc.com'
 where  activo = 'S'
 and tipointe= 8
