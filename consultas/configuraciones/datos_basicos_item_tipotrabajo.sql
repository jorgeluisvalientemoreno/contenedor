select or_task_type.task_type_id, or_task_type.description, or_task_type.task_type_classif, open.dage_task_class.fsbgetdescription(or_task_type.task_type_classif, null) desc_clas,
       ge_items.items_id, ge_items.description,ge_items.item_classif_id , ge_items.warranty_days, ge_items.object_id,
       or_task_type.concept,
       nvl((SELECT 'S' FROM open.ct_item_novelty n where n.items_id=ge_items.items_id),'N') novedad,
       ge_items.standard_time,
       ge_items_attributes.attribute_1_id,
       (select ati.name_attribute from open.ge_attributes ati where ati.attribute_id=ge_items_attributes.attribute_1_id) desc_1,
       ge_items_attributes.init_expression_1_id,
       ge_items_attributes.valid_expression_1_id,
       ge_items_attributes.statement_1_id,
       ge_items_attributes.required1,
       ge_items_attributes.attribute_2_id,
       (select ati.name_attribute from open.ge_attributes ati where ati.attribute_id=ge_items_attributes.attribute_2_id) desc_2,
       ge_items_attributes.init_expression_2_id,
       ge_items_attributes.valid_expression_2_id,
       ge_items_attributes.statement_2_id,
       ge_items_attributes.required2,
       ge_items_attributes.attribute_3_id,
        (select ati.name_attribute from open.ge_attributes ati where ati.attribute_id=ge_items_attributes.attribute_3_id) desc_3,
       ge_items_attributes.init_expression_3_id,
       ge_items_attributes.valid_expression_3_id,
       ge_items_attributes.statement_3_id,
       ge_items_attributes.required3,
       ge_items_attributes.attribute_4_id,
        (select ati.name_attribute from open.ge_attributes ati where ati.attribute_id=ge_items_attributes.attribute_4_id) desc_4,
       ge_items_attributes.init_expression_4_id,
       ge_items_attributes.valid_expression_4_id,
       ge_items_attributes.statement_4_id,
       ge_items_attributes.required4,
       ge_items.concept,
       ge_items.warranty_days,
       ic_clascont.clcocodi,
       ic_clascont.clcodesc
from open.or_task_types_items
inner join open.or_task_type on or_task_type.task_type_id=or_task_types_items.task_type_id
inner join open.ge_items on ge_items.items_id=or_task_types_items.items_id
left join open.ge_items_attributes on ge_items_attributes.items_id=or_task_types_items.items_id
left join open.ic_clascott on ic_clascott.clcttitr=or_task_types_items.task_type_id
left join open.ic_clascont on ic_clascont.clcocodi=ic_clascott.clctclco
