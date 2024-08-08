select sucosusc "Contrato",suconuor "Orden",suconuse"Producto" ,sucoserv "Tipo de producto",sucotipo "Tipo"  ,sucofeor "Fecha orden",sucocoec "Estado de corte anterior"  ,sucoprog "Programa" ,sucousua "Usuario" 
from suspcone s
where s.suconuse= 1000239
order by sucofeor desc 