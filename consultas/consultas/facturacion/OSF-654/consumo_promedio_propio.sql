select hicoprpm.hcppsesu producto,
       hicoprpm.hcpptico tipo_cons,
       hicoprpm.hcppcopr cons_promedio,
       hicoprpm.hcpppeco periodo_cons
from open.hicoprpm
where hicoprpm.hcppsesu  = 52477694
and hicoprpm.hcpppeco = 102164