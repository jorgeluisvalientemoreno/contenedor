select t.task_type_id, t.description, t.task_type_classif, open.dage_task_class.fsbgetdescription(t.task_type_classif, null) desc_clas,
       i.items_id, i.description,i.item_classif_id , i.warranty_days, i.object_id,
       t.concept,
       nvl((SELECT 'S' FROM open.ct_item_novelty n where n.items_id=i.items_id),'N') novedad,
       i.standard_time,
       ai.attribute_1_id,
       (select ati.name_attribute from open.ge_attributes ati where ati.attribute_id=ai.attribute_1_id) desc_1,
       ai.init_expression_1_id,
       ai.valid_expression_1_id,
       ai.statement_1_id,
       ai.required1,
       ai.attribute_2_id,
       (select ati.name_attribute from open.ge_attributes ati where ati.attribute_id=ai.attribute_2_id) desc_2,
       ai.init_expression_2_id,
       ai.valid_expression_2_id,
       ai.statement_2_id,
       ai.required2,
       ai.attribute_3_id,
        (select ati.name_attribute from open.ge_attributes ati where ati.attribute_id=ai.attribute_3_id) desc_3,
       ai.init_expression_3_id,
       ai.valid_expression_3_id,
       ai.statement_3_id,
       ai.required3,
       ai.attribute_4_id,
        (select ati.name_attribute from open.ge_attributes ati where ati.attribute_id=ai.attribute_4_id) desc_4,
       ai.init_expression_4_id,
       ai.valid_expression_4_id,
       ai.statement_4_id,
       ai.required4,
       i.concept,
       i.warranty_days,
       cl.clcocodi,
       cl.clcodesc
from open.or_task_types_items ti
inner join open.or_task_type t on t.task_type_id=ti.task_type_id
inner join open.ge_items i on i.items_id=ti.items_id
left join open.ge_items_attributes ai on ai.items_id=ti.items_id
left join open.ic_clascott co on co.clcttitr=ti.task_type_id
left join open.ic_clascont cl on cl.clcocodi=co.clctclco
where t.task_type_id in (10951,12143)
--and  i.items_id in (100002509)
 and i.item_classif_id=2;
