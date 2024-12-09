select t.task_type_id, t.description, 
       i.items_id, i.description,i.item_classif_id , i.object_id,
       nvl((SELECT 'S' FROM open.ct_item_novelty n where n.items_id=i.items_id),'N') novedad,
       ai.component_1_id,
       ai.attribute_1_id,
       (select ati.name_attribute from open.ge_attributes ati where ati.attribute_id=ai.attribute_1_id) desc_1,
       ai.required1,
       ai.attribute_2_id,
       (select ati.name_attribute from open.ge_attributes ati where ati.attribute_id=ai.attribute_2_id) desc_2,
       ai.required2,
       ai.attribute_3_id,
       (select ati.name_attribute from open.ge_attributes ati where ati.attribute_id=ai.attribute_3_id) desc_3,
       ai.required3,
       ai.attribute_4_id,
       (select ati.name_attribute from open.ge_attributes ati where ati.attribute_id=ai.attribute_4_id) desc_4
from open.or_task_types_items ti
inner join open.or_task_type t on t.task_type_id=ti.task_type_id
inner join open.ge_items i on i.items_id=ti.items_id
left join open.ge_items_attributes ai on ai.items_id=ti.items_id
left join open.ic_clascott co on co.clcttitr=ti.task_type_id
left join open.ic_clascont cl on cl.clcocodi=co.clctclco
where t.task_type_id in (12135)
 and i.item_classif_id=2;


--and  i.items_id in (100002510)

/*update ge_items_attributes ai set ai.required1 = 'Y'  where ai.items_id = 100002510 and ai.attribute_1_id = 400021*/
