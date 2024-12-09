select l.policy_id,
       policy_number,
       l.state_policy,
       l.contratist_code,
       l.product_line_id,
       l.dt_in_policy,
       l.dt_en_policy,
       l.name_insured,
       l.identification_id,
       l.suscription_id,
       l.product_id,
       sesuesfn,
       s.sesuplfa, dt_insured_policy 
from ld_policy l 
inner join servsusc s on sesususc= l.suscription_id and l.product_id= sesunuse
where l.state_policy in (1)and l.product_line_id in (311) and rownum <= 3 
union all
select l.policy_id,
       policy_number,
       l.state_policy,
       l.contratist_code,
       l.product_line_id,
       l.dt_in_policy,
       l.dt_en_policy,
       l.name_insured,
       l.identification_id,
       l.suscription_id,
       l.product_id,
       sesuesfn,
       s.sesuplfa, dt_insured_policy 
from ld_policy l 
inner join servsusc s on sesususc= l.suscription_id and l.product_id= sesunuse
where l.state_policy in (1)and l.product_line_id in (131) and rownum <= 9
union all
select l.policy_id,
       policy_number,
       l.state_policy,
       l.contratist_code,
       l.product_line_id,
       l.dt_in_policy,
       l.dt_en_policy,
       l.name_insured,
       l.identification_id,
       l.suscription_id,
       l.product_id,
       sesuesfn,
       s.sesuplfa, dt_insured_policy 
from ld_policy l 
inner join servsusc s on sesususc= l.suscription_id and l.product_id= sesunuse
where l.state_policy in (1)and l.product_line_id in (91) and rownum <= 3 
order by dt_in_policy desc