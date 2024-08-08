select hcppsesu "Producto",
       hcpptico "Tipo_cons",
       hcppcopr "Consumo_promedio",
       hcpppeco "Periodo_consumo",
       hcppcons "Consecutivo"
from  open.hicoprpm
where hcppsesu = 50003042
and hcpptico = 1
and hcpppeco = 105275
order by hcpppeco desc
