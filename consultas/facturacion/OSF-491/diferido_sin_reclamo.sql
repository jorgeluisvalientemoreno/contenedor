select d.difenuse  Producto, 
       d.difeconc || '-  ' || c.concdesc Concepto, 
       d.difesape  Saldo_Pendiente, 
       d.difesign  Signo, 
       d.difepldi || '-  ' || pd.pldidesc Programa, 
       gp.grace_period_id  || '-  ' || pc.description  Periodo_Gracia, 
       gp.initial_date  Inicio_P_Gracia, 
       gp.end_date  Fin_P_Gracia
from open.diferido  d
left join open.cc_grace_peri_defe  gp on gp.deferred_id = d.difecodi
left join open.plandife  pd on d.difepldi = pd.pldicodi
left join open.concepto  c on c.conccodi = d.difeconc
left join open.cc_grace_period  pc on pc.grace_period_id = gp.grace_period_id
where d.difenuse = 758990
and d.difetire = 'D'                 
and d.difesign in ('DB', 'CR')                 
and d.difesape > 0   
group by d.difenuse, d.difeconc || '-  ' || c.concdesc, d.difesape, d.difesign, d.difepldi || '-  ' || pd.pldidesc,
gp.grace_period_id  || '-  ' || pc.description, gp.initial_date, gp.end_date