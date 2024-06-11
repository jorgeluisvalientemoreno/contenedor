select d.difenuse  Producto, 
       d.difeprog  Programa, 
       d.difesape  Saldo_Pendiente, 
       d.difepldi || '-  ' || pd.pldidesc  Plan_Diferido, 
       pd.pldicumi  Minimo_Cuotas, 
       pd.pldicuma  Maximo_Cuotas, 
       pd.pldipegr || '-  ' || pc.description  Periodo_Gracia 
from open.diferido d
inner join open.plandife  pd on d.difepldi = pd.pldicodi
inner join open.cc_grace_period  pc on pc.grace_period_id = pd.pldipegr
where d.difenuse = 50732225 
and difesape > 0
and d.difeprog = 'GCNED'
order by pd.pldicumi desc;

