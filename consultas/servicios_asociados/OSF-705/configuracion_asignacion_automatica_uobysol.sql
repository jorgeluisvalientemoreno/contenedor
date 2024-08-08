select a.package_type_id,
       s.description,
       t.package_type_oper_unit_id,
       t.operating_unit_id,
       u.name,
       t.task_type_id,
       t.items_id,
       i.description,
       t.procesopre,
       t.procesopost,
       t.catecodi
  from open.ldc_package_type_assign a
 inner join open.ps_package_type  s on a.package_type_id = s.package_type_id
 inner join open.ldc_package_type_oper_unit  t on a.package_type_assign_id = t.package_type_assign_id
 inner join open.ge_items  i on t.items_id = i.items_id
 inner join open.or_operating_unit  u  on t.operating_unit_id = u.operating_unit_id
 where t.items_id  in (4000943)

-- ldc_boasigauto.prasignacion
