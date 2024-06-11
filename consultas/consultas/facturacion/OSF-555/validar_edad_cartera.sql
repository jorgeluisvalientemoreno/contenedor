select l.contrato,
       l.producto,
       l.tipo_producto,
       l.edad ,
       l.edad_deuda, 
       l.deuda_corriente_vencida,
       l.nuano,
       l.numes
from open.ldc_osf_sesucier l
where l.contrato = 66328617
and l.edad_deuda > 90 