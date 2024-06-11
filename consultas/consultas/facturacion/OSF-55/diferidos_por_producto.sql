select d.difenuse  Producto, d.difeprog  Programa, sum(d.difevatd)   Valor_Total, d.difenucu  "#_CUOTAS", 
d.difepldi || '-  ' || pd.pldidesc  Plan_Diferido, d.difefein  Fecha_Diferido, pd.pldicumi  Min_Cuotas, pd.pldicuma  Max_Cuotas, 
pd.pldipegr || '-  ' || pc.description  Periodo_Gracia, pg.end_date  Fecha_Fin_PG 
from open.diferido d
left join open.plandife  pd on d.difepldi = pd.pldicodi
left join open.cc_grace_period  pc on pc.grace_period_id = pd.pldipegr
left join open.cc_grace_peri_defe  pg on pg.deferred_id = d.difecodi
where d.difenuse = 1569832
group by d.difenuse, d.difeprog, d.difenucu, d.difepldi || '-  ' || pd.pldidesc, d.difefein, pd.pldicumi, pd.pldicuma, 
pd.pldipegr || '-  ' || pc.description, pg.end_date
order by pd.pldicumi desc;