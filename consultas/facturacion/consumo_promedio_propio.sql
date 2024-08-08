select hcppsesu "Producto",
       hcpptico "Tipo_cons",
       hcppcopr "Consumo_promedio",
       hcpppeco "Periodo_consumo",
       hcppcons "Consecutivo"
from  open.hicoprpm
order by hcpppeco desc