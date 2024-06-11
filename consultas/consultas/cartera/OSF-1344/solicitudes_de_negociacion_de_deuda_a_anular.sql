select ldc_solinean.solicitud  "Solicitud", 
       ldc_solinean.fecha  "Fecha", 
       ldc_solinean.estado  "Estado", 
       ldc_solinean.observacion  "Observacion" 
from open.ldc_solinean
where ldc_solinean.solicitud = 202786511
order by fecha desc;
