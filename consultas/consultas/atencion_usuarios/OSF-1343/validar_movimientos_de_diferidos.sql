select modidife "Cod del diferido",
       modisusc "Contrato",
       modinuse "Producto",
       modisign "Signo",
       modifech "Fecha cargo",
       modifeca "Fecha grabacion",
       modivacu "Valor Mov",
       d.difesape "Valor pendiente actual",
       --s.difesape "Valor pendiente anterior", d.difefein"Fecha diferido",
       modicaca "Causal"
from movidife 
left join diferido d on modidife = d.difecodi 
--left join diferido_sil s on modidife = s.difecodi 
where modinuse = 2074695 
and modifech >= '06/09/2023'
order by modifech desc 
