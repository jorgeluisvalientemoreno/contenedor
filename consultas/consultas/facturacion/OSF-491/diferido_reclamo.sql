select d.difenuse  Producto, 
       d.difeconc   || '-  ' || c.concdesc Concepto, 
       d.difesape  Saldo_Pendiente, 
       d.difesign  Signo, 
       d.difeenre  Proceso_Reclamo,
       d.difepldi || '-  ' || pd.pldidesc Programa, 
       gp.grace_period_id  || '-  ' || pc.description  Periodo_Gracia, 
       gp.end_date  Fin_P_Gracia
from open.diferido  d
inner join open.plandife  pd on d.difepldi = pd.pldicodi
inner join open.cc_grace_peri_defe  gp on gp.deferred_id = d.difecodi
inner join open.concepto  c on c.conccodi = d.difeconc
inner join open.cc_grace_period  pc on pc.grace_period_id = gp.grace_period_id
where d.difesape > 0
and d.difenuse = 758990
and d.difetire = 'D'                 
and d.difesign in ('DB', 'CR')                 
and d.difesape > 0   
and d.difeenre = 'Y'
and gp.end_date > sysdate