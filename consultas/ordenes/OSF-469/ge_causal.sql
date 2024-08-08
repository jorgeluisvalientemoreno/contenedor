select c.causal_id, 
       c.description,
       c.causal_type_id, 
       tc.description desc_tipo_causal, 
       c.attributed_to, 
       c.module_id,
       c.allow_update, 
       c.observation,
       c.class_causal_id, 
       cc.description desc_clase_causal
from   open.ge_causal c
inner join open.ge_causal_type tc on tc.causal_type_id = c.causal_type_id 
inner join open.ge_class_causal cc on cc.class_causal_id = c.class_causal_id
where c.causal_id in (9595)
