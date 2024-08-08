SELECT

 open.ld_bcsecuremanagement.FnuGetAllFeesPaid(a.policy_id) feed_paid, 
 a.policy_id policy_id, 
 a.policy_number policy_number, 
 a.state_policy state_policy, 
 a.product_id product, 
 a.collective_number collective_number, 
 a.contratist_code contratist, 
 a.product_line_id product_line, 
 a.dt_in_policy initial_date, 
 a.dt_en_policy final_date, 
 a.value_policy value_policy, 
 a.prem_policy prem_policy, 
 a.name_insured name_insured, 
 a.suscription_id suscription_id, 
 a.identification_id identification_insured, 
 a.deferred_policy_id deferred_policy_id, 
 a.dtcreate_policy dtcreate_policy, 
 a.share_policy share_policy, 
 a.dtret_policy dtret_policy, 
 a.valueacr_policy valueacr_policy, 
 a.dt_report_policy dt_report_policy, 
 a.dt_insured_policy dt_insured_policy, 
 a.per_report_policy per_report_policy, 
 a.policy_type_id policy_type, 
 a.id_report_policy id_report_policy, 
 a.cancel_causal_id cancel_causal_id, 
 a.fees_to_return fees_to_return, 
 a.comments comments, 
 a.policy_exq policy_exq, 
 a.number_acta number_acta, 
 a.geograp_location_id geograp_location, 
 open.LD_BOOssPolicy.fsbNeighborhood neighborhood, 
 open.LD_BOOssPolicy.fsbLocality locality, 
 open.LD_BOOssPolicy.fsbDepartment department, 
 a.launch_policy launch_policy

  FROM /*+ LD_BOOssPolicy.GetPolicyBySusc */ open.ld_policy          a,
       open.ge_contratista     b,
       open.ld_product_line    c,
       open.ld_policy_type     d,
       open.ge_geogra_location e,
       open.ld_policy_state    h
 WHERE a.suscription_id = 
 
 --66482553
 6129554
   AND a.contratist_code = b.id_contratista
   AND a.product_line_id = c.product_line_id
   AND a.policy_type_id = d.policy_type_id
   AND h.policy_state_id = a.state_policy
   AND a.geograp_location_id = e.geograp_location_id(+);
   
select * from open.ldc_policy_trasl a where a.suscription_id in (66482553,6129554) order by a.dt_in_policy desc
