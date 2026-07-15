select *
from personalizaciones.log_traslado_diferidos  lt
where lt.fecha_proceso >= '26/08/2025'
order by lt.fecha_proceso

-- and lt.fecha_proceso >= '22/08/2025'


--and producto_origen in (7000888,7053704,7053723,7054007,7055238)

--and   producto_origen in (1000650)
--lt.diferido_destino in (116704761)
