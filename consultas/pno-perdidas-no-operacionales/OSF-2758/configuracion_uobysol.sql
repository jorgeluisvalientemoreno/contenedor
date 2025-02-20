select a.package_type_id,
       s.description,
       t.operating_unit_id,
       u.name,
       t.task_type_id,
       t.items_id  actividad,
       i.description,
       t.procesopre,
       t.procesopost,
       t.catecodi
  from open.ldc_package_type_assign a
 left join open.ps_package_type  s on a.package_type_id = s.package_type_id
 left join      open.ldc_package_type_oper_unit  t on a.package_type_assign_id = t.package_type_assign_id
 left join     open.ge_items  i on t.items_id = i.items_id
 left join      open.or_operating_unit  u on t.operating_unit_id = u.operating_unit_id
 where a.package_type_id = -1
    and t.items_id in (102008, 100009163)
   

-- ldc_boasigauto.prasignacion


/*select *
from ldc_package_type_oper_unit  t1
where t1.items_id in (102008)
for update*/
