select *
  from open.or_tasktype_add_data a
 where a.task_type_id in (12669)
   and a.active = 'Y';
select a.*, rowid
  from open.ge_attributes_set a
 where a.attribute_set_id in (select a1.attribute_set_id
                                from open.or_tasktype_add_data a1
                               where a1.task_type_id in (12669)
                                 and a1.active = 'Y');
select a.*, rowid
  from open.ge_attrib_set_attrib a
 where a.attribute_set_id in
       (select a2.attribute_set_id
          from open.ge_attributes_set a2
         where a2.attribute_set_id in
               (select a1.attribute_set_id
                  from open.or_tasktype_add_data a1
                 where a1.task_type_id in (12669)
                   and a1.active = 'Y'));
select b.*, rowid
  from open.ge_attributes b
 where b.attribute_id in
       (select a.attribute_id
          from open.ge_attrib_set_attrib a
         where a.attribute_set_id in
               (select a2.attribute_set_id
                  from open.ge_attributes_set a2
                 where a2.attribute_set_id in
                       (select a1.attribute_set_id
                          from open.or_tasktype_add_data a1
                         where a1.task_type_id in (12669)
                           and a1.active = 'Y')))
--   and b.name_attribute = 'INSPECCION_VISUAL'
;
select b.*, rowid
  from open.ge_attributes b
where b.name_attribute like '%ON_VISUAL';
