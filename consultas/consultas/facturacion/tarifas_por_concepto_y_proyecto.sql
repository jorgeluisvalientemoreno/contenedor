select v.*
from open.ta_taricopr 
left join open.ta_vigetaco on vitctaco = tacptacc 
left join open.ta_vigetacp v on tacpcons=vitptacp
where vitctaco in (4050,4051);  --Consultar por id de proyecto 
