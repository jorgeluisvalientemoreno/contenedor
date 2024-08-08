select o.order_id,
       o.task_type_id,
       o.causal_id,
       c.description            desc_causal,
       c.class_causal_id        clase_causal,
       cc.description           desc_clase_causal,
       o.order_comment,
       o.exec_initial_date,
       o.exec_final_date,
       o.legalizado,
       o.fecha_registro,
       o.mensaje_legalizado     mensaje,
       da.name_attribute,
       da.value,
       da3.name_attribute,
       da3.name_attribute_value,
       da3.component_id,
       da3.component_id_value,
       ta.task_type_id,
       ta.causal_id,
       dta.material,
       dta.name_attribute,
       dta.name_attribute_value,
       dta.component_id,
       dta.component_id_value,
       da2.name_attribute,
       da2.value
  from open.ldc_otlegalizar o
 left join Open.ldc_otadicional ta on ta.order_id = o.order_id
 left join open.ldc_datoactividadotadicional dta on dta.order_id = ta.order_id
 left join open.ldc_otdalegalizar da on da.order_id = o.order_id
 left join open.ldc_otadicionalda da2 on da2.order_id = o.order_id
 left join OPEN.LDC_OTDATOACTIVIDAD da3 on da3.order_id = o.order_id
 left join open.ge_causal c on c.causal_id = o.causal_id
 left join open.ge_class_causal cc on cc.class_causal_id = c.class_causal_id  
 where o.order_id in (245212506)
 group by (o.order_id, o.task_type_id, o.causal_id, c.description,
           c.class_causal_id, cc.description, o.order_comment,
           o.exec_initial_date, o.exec_final_date, o.legalizado,
           o.fecha_registro, o.mensaje_legalizado, da.name_attribute,
           da.value, da3.name_attribute, da3.name_attribute_value,
           da3.component_id, da3.component_id_value, ta.task_type_id,
           ta.causal_id, dta.material, dta.name_attribute,
           dta.name_attribute_value, dta.component_id,
           dta.component_id_value, da2.name_attribute, da2.value)
 order by fecha_registro desc;
