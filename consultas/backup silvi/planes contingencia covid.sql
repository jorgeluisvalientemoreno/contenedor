(Select PLFICOCO From Open.LDC_CONFIG_CONTINGENC
  Union
 Select PLFICONT From Open.LDC_CONFIG_CONTINGENC)
 
 select *
 from LDC_CONFIG_CONTINGENC
 
select difecodi , difesusc , difenuse ,difeconc , difevatd ,difesape, difeprog , difepldi || ' ' || pldidesc as plan_diferido , difefein 
from diferido
left join plandife on pldicodi = difepldi
where difenuse = 17116546
and difesape > 0 

select *
from ld_policy 
where product_id =  17116546

select *
from cargos 
where cargnuse = 17116546
order by cargfecr desc 
