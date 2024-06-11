select hcppsesu "Producto",
       hcpptico "Tipo_cons",
       hcppcopr "Consumo_promedio",
       hcpppeco "Periodo_consumo",
       hcppcons "Consecutivo"
from  open.hicoprpm
where hcppsesu = 1013742
and hcpptico = 1
order by hcpppeco desc
