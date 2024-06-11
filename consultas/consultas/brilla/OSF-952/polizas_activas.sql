select p.suscription_id,
       p.product_id,
       p.identification_id,
       p.policy_id,
       p.collective_number,
       p.state_policy,
       sp.description,
       p.product_line_id,
       lp.description,
       p.launch_policy,
       p.description_policy,
       p.period_policy,
       p.year_policy,
       p.month_policy,
       p.contratist_code,
       p.dt_in_policy,
       p.dt_en_policy,
       p.value_policy,
       p.prem_policy,
       p.name_insured,
       p.deferred_policy_id,
       p.dtcreate_policy,
       p.share_policy,
       p.dtret_policy,
       p.valueacr_policy,
       p.report_policy,
       p.dt_report_policy,
       p.dt_insured_policy,
       p.per_report_policy,
       p.policy_type_id,
       p.id_report_policy,
       p.cancel_causal_id,
       p.fees_to_return,
       p.comments,
       p.policy_exq,
       p.number_acta,
       p.geograp_location_id,
       p.validity_policy_type_id,
       p.policy_number,
       p.base_value,
       p.porc_base_val,
       p.sale_chanel_id,
       p.operating_unit_id
from   ld_policy p
inner join ld_policy_state  sp on sp.policy_state_id = p.state_policy
inner join ld_product_line  lp on lp.product_line_id = p.product_line_id 
where   p.policy_id =9102451284

/*p.state_policy = 1
and     p.product_line_id = 251
and     SUBSTR(collective_number, 3, 4) = 1
and not exists (select   'x' 
                from   ld_secure_cancella c, mo_packages s 
                where   p.policy_id = c.policy_id 
                and    c.secure_cancella_id = s.package_id 
                and    s.motive_status_id = 13)*/
order by  p.year_policy desc, p.month_policy desc
--1116858
-- Si seleccionas Mes Poliza, entonces va el valor del mes 1-12 y la consulta lo que hace es coger todas las polizas donde SUBSTR(COLLECTIVE_NUMBER, 3, 4) sea igual al valor que ingresaste.

--and     p.policy_id = 1072827
--and     p.collective_number = 1810
