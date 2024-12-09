select i.* ,  -3*desviacion_poblacional + consumo_promedio limite_inf , 3*desviacion_poblacional + consumo_promedio limite_sup
from info_producto_desvpobl i
where producto = 2059929
and periodo_consumo = 113317