select r.order_id,
          atrxgr.attribute_set_id codigo_grupo,
          gr.description,
          r.name_11,
          atrxgr.attribute_id,
          atr.name_attribute,
          case when nvl(r.name_1,'-1')= nvl(atr.name_attribute,'-2') then r.value_1
               when nvl(r.name_2,'-1')= nvl(atr.name_attribute,'-2') then r.value_2
               when nvl(r.name_3,'-1')= nvl(atr.name_attribute,'-2') then r.value_3
               when nvl(r.name_4,'-1')= nvl(atr.name_attribute,'-2') then r.value_4
               when nvl(r.name_5,'-1')= nvl(atr.name_attribute,'-2') then r.value_5
               when nvl(r.name_6,'-1')= nvl(atr.name_attribute,'-2') then r.value_6
               when nvl(r.name_7,'-1')= nvl(atr.name_attribute,'-2') then r.value_7
               when nvl(r.name_8,'-1')= nvl(atr.name_attribute,'-2') then r.value_8
               when nvl(r.name_9,'-1')= nvl(atr.name_attribute,'-2') then r.value_9
               when nvl(r.name_10,'-1')= nvl(atr.name_attribute,'-2') then r.value_10
               when nvl(r.name_11,'-1')= nvl(atr.name_attribute,'-2') then r.value_11
               when nvl(r.name_12,'-1')= nvl(atr.name_attribute,'-2') then r.value_12
               when nvl(r.name_13,'-1')= nvl(atr.name_attribute,'-2') then r.value_13
               when nvl(r.name_14,'-1')= nvl(atr.name_attribute,'-2') then r.value_14
               when nvl(r.name_15,'-1')= nvl(atr.name_attribute,'-2') then r.value_15
               when nvl(r.name_16,'-1')= nvl(atr.name_attribute,'-2') then r.value_16
               when nvl(r.name_17,'-1')= nvl(atr.name_attribute,'-2') then r.value_17
               when nvl(r.name_18,'-1')= nvl(atr.name_attribute,'-2') then r.value_18
               when nvl(r.name_19,'-1')= nvl(atr.name_attribute,'-2') then r.value_19
      when nvl(r.name_20,'-1')= nvl(atr.name_attribute,'-2') then r.value_20
         end valor
   from open.or_requ_data_value r
   inner join ge_attrib_set_attrib atrxgr on atrxgr.attribute_set_id = r.attribute_set_id
   inner join ge_attributes_set gr on gr.attribute_set_id = r.attribute_set_id
   inner join ge_attributes atr on atr.attribute_id=atrxgr.attribute_id and (
   nvl(r.name_1,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_2,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_3,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_4,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_5,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_6,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_7,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_8,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_9,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_10,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_11,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_12,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_13,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_14,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_15,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_16,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_17,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_18,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_19,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_20,'-1')= nvl(atr.name_attribute,'-2')
   )
   where r.order_id=294146051
