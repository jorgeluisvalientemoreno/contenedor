select /*a.attribute_set_id attribute_set_id,
       a.attribute_id attribute_id,
       b.name_attribute name_attribute,
       b.display_name display_name,
       b.length length,
       b.precision precision,
       b.scale scale,
       dage_statement.fsbgetstatement(a.statement_id, null) statement_id,
       a.mandatory obligatorio*/
 * --count(1)
  from open.ge_attributes b
  join open.ge_attrib_set_attrib a
    on b.attribute_id = a.attribute_id
  join open.or_tasktype_add_data ottd
    on a.attribute_set_id = ottd.attribute_set_id
   and ottd.task_type_id = 12192
   and ottd.active = 'Y'
   and (ottd.use_ = decode((select c.Class_Causal_Id
                             from open.GE_CAUSAL c
                            where c.causal_id = 3533),
                           1,
                           'C',
                           2,
                           'I') or ottd.use_ = 'B')
   and a. mandatory = 'Y'
 order by a.attribute_set_id, a.capture_order;
