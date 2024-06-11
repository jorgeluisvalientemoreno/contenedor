select suconuor  "ORDEN", 
       sucosusc  "CONTRATO", 
       suconuse  "PRODUCTO", 
       sucotipo  "ESTADO", 
       sucofeor  "FECHA DE REGISTRO", 
       sucofeat  "FECHA DE ATENCION" 
from open.suspcone
where suconuor = 246625922
order by sucofeor desc