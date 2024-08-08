select diferido.difenuse  Producto, 
       diferido.difesusc ,
       grace_peri_defe_id id_periodo_grac, 
       diferido.difecodi,
       diferido.difeconc , 
       diferido.difesape  Saldo_Pendiente, 
       diferido.difepldi || '-  ' || plandife.pldidesc Plan, 
       cc_grace_peri_defe.grace_period_id  || '-  ' || cc_grace_period.description  Periodo_Gracia, 
       cc_grace_peri_defe.initial_date  Inicio_P_Gracia, 
       cc_grace_peri_defe.end_date  Fin_P_Gracia
from open.diferido  
left join open.cc_grace_peri_defe   on cc_grace_peri_defe.deferred_id = diferido.difecodi
left join open.plandife on diferido.difepldi = plandife.pldicodi
left join open.concepto  c on c.conccodi = diferido.difeconc
left join open.cc_grace_period   on cc_grace_period.grace_period_id = cc_grace_peri_defe.grace_period_id
where cc_grace_peri_defe.end_date > sysdate
