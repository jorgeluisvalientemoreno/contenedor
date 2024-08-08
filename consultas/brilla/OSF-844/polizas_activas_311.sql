select servsusc.sesususc contrato,
       servsusc.sesunuse producto,
       servsusc.sesuserv || ' ' || servicio.servdesc  as tipo_de_producto,
       pr_product.product_status_id || ' ' || ps_product_status.description as estado_producto,
       ld_policy.policy_id,
       ld_policy.state_policy ||' ' ||  ld_policy_state.description estado_poliza,
       ld_policy.product_line_id || ' ' || ld_product_line.description linea_de_producto ,
       ld_policy.policy_type_id || ' ' || ld_policy_type.description tipo_poliza
from open.servsusc 
left join open.servicio  on servicio.servcodi = servsusc.sesuserv 
left join open.pr_product  on servsusc.sesunuse = pr_product.product_id
left join open.ps_product_status on ps_product_status.product_status_id = pr_product.product_status_id
left join  open.ld_policy   on ld_policy.product_id = servsusc.sesunuse  
left join ld_product_line on ld_policy.product_line_id = ld_product_line.product_line_id 
left join ld_policy_type on ld_policy.policy_type_id = ld_policy_type.policy_type_id 
left join ld_policy_state on ld_policy_state.policy_state_id = ld_policy.state_policy 
where servsusc.sesuserv = 7053
and exists ( select p.product_id 
             from open.ld_policy p
             where ld_policy.policy_id = p.policy_id 
             and p.product_id = servsusc.sesunuse 
             and p.state_policy = 1
             and p.product_line_id = 311)