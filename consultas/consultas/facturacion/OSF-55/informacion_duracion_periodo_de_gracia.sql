select pc.grace_period_id || '-  ' || pc.description  Periodo_Gracia, 
       min_grace_days  Minimo_Dias, 
       max_grace_days  Maximo_Dias
from open.cc_grace_period  pc
where pc.grace_period_id = 37 