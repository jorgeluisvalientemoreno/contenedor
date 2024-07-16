select suspcone.suconuor  "Orden", 
       suspcone.sucosusc  "Contrato",  .
       suspcone.suconuse  "Producto", 
       suspcone.sucoserv "Tipo de producto", 
       suspcone.sucotipo   "Tipo de suspension", 
       suspcone.sucofeor  "Fecha de creacion", 
       suspcone.sucofeat  "Fecha de atencion"
from open.suspcone
where suspcone.suconuse = 50032741
order by suspcone.sucofeor desc;