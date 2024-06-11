select cs.component_id,
       cs.product_id,
       cs.package_id,
       cs.component_type_id,
       co.description,
       cs.motive_type_id,
       tc.description,
       cs.motive_status_id,
       ec.description,
       cs.product_motive_id,
       mp.description,
       cs.status_change_date,
       cs.annul_date
  from open.mo_component cs
inner join open.ps_motive_status ec on ec.motive_status_id = cs.motive_status_id
inner join open.ps_motive_type tc on tc.motive_type_id = cs.motive_type_id
inner join open.ps_product_motive mp on mp.product_motive_id = cs.product_motive_id
inner join open.ps_component_type co on co.component_type_id = cs.component_type_id
 where cs.package_id in (160991043, 65950905, 11301236)
