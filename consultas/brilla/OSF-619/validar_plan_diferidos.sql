select diferido.difecodi , diferido.difesusc , diferido.difenuse ,diferido.difeconc , diferido.difevatd ,diferido.difesape, diferido.difeprog , diferido.difepldi || ' ' || plandife.pldidesc as plan_diferido , difefumo 
from open.diferido
left join open.plandife on plandife.pldicodi = diferido.difepldi
where diferido.difenuse = 17116546
and diferido.difesape > 0 
