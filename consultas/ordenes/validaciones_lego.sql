select ldc_otlegalizar.order_id,
       ldc_otlegalizar.task_type_id,
       ldc_otlegalizar.causal_id,
       ge_causal.description            desc_causal,
       ge_causal.class_causal_id        clase_causal,
       ge_class_causal.description           desc_clase_causal,
       ldc_otlegalizar.order_comment,
       ldc_otlegalizar.exec_initial_date,
       ldc_otlegalizar.exec_final_date,
       ldc_otlegalizar.legalizado,
       ldc_otlegalizar.fecha_registro,
       ldc_otlegalizar.mensaje_legalizado     mensaje,
       ldc_otdalegalizar.name_attribute,
       ldc_otdalegalizar.value,
       ldc_otdatoactividad.name_attribute,
       ldc_otdatoactividad.name_attribute_value,
       ldc_otdatoactividad.component_id,
       ldc_otdatoactividad.component_id_value,
       ldc_otadicional.task_type_id,
       ldc_otadicional.causal_id,
       ldc_datoactividadotadicional.material,
       ldc_datoactividadotadicional.name_attribute,
       ldc_datoactividadotadicional.name_attribute_value,
       ldc_datoactividadotadicional.component_id,
       ldc_datoactividadotadicional.component_id_value,
       ldc_otadicionalda.name_attribute,
       ldc_otadicionalda.value
  from open.ldc_otlegalizar
 left join open.ldc_otadicional on ldc_otadicional.order_id = ldc_otlegalizar.order_id
 left join open.ldc_datoactividadotadicional on ldc_datoactividadotadicional.order_id = ldc_otadicional.order_id
 left join open.ldc_otdalegalizar on ldc_otdalegalizar.order_id = ldc_otlegalizar.order_id
 left join open.ldc_otadicionalda on ldc_otadicionalda.order_id = ldc_otlegalizar.order_id
 left join open.ldc_otdatoactividad on ldc_otdatoactividad.order_id = ldc_otlegalizar.order_id
 left join open.ge_causal on ge_causal.causal_id = ldc_otlegalizar.causal_id
 left join open.ge_class_causal on ge_class_causal.class_causal_id = ge_causal.class_causal_id  
 group by (ldc_otlegalizar.order_id, ldc_otlegalizar.task_type_id, ldc_otlegalizar.causal_id, ge_causal.description,
           ge_causal.class_causal_id, ge_class_causal.description, ldc_otlegalizar.order_comment,
           ldc_otlegalizar.exec_initial_date, ldc_otlegalizar.exec_final_date, ldc_otlegalizar.legalizado,
           ldc_otlegalizar.fecha_registro, ldc_otlegalizar.mensaje_legalizado, ldc_otdalegalizar.name_attribute,
           ldc_otdalegalizar.value, ldc_otdatoactividad.name_attribute, ldc_otdatoactividad.name_attribute_value,
           ldc_otdatoactividad.component_id, ldc_otdatoactividad.component_id_value, ldc_otadicional.task_type_id,
           ldc_otadicional.causal_id, ldc_datoactividadotadicional.material, ldc_datoactividadotadicional.name_attribute,
           ldc_datoactividadotadicional.name_attribute_value, ldc_datoactividadotadicional.component_id,
           ldc_datoactividadotadicional.component_id_value, ldc_otadicionalda.name_attribute, ldc_otadicionalda.value)
 order by fecha_registro desc;


 --validar si la persona esta asociada a la unidad
 select *
 from open.or_oper_unit_persons
 where operating_unit_id=&unidad
   and person_id in (
 select person_id
 from open.sa_user sa, open.ge_person p
 where p.user_id=sa.user_id
  and mask=&loginusuario);


-- validar si fue gestionada
select a.product_id, o.order_id, ot.operating_unit_id,open.daor_operating_unit.fsbgetname(ot.operating_unit_id) nombre,
    o.task_type_id, o.causal_id, ot.order_status_id, fecha_registro,a.package_id, a.product_id,
     mensaje_legalizado, order_comment
from open.ldc_otlegalizar o, open. or_order ot, open.or_order_activity a
where --mensaje_legalizado is not null
1=1
and o.order_id=ot.order_id
and a.order_id=o.order_id
and ot.order_status_id not in (8,12)
and ot.order_id=&orden  
 ;




select *
from open.ldc_otadicionalda
where order_id=&orden ;

select *
from open.ldc_anexolegaliza
where order_id=&orden ;
select *
from open.ldc_agenlego
where agente_id=&agente;

select *
from open.ldc_usualego l
inner  join open.ge_person p on p.person_id=l.person_id 
inner join open.sa_user s on s.user_id=p.user_id and mask=upper(&loginusuario)
where person_id in ( 
select person_id
 from open.sa_user sa, open.ge_person p
 where p.user_id=sa.user_id
  and mask=upper(upper(&loginusuario)));

  
select *
from open.ldc_tipotrablego;

select *
from open.ldc_tipotrabadiclego;

select *
from open.ldc_otitem
where order_id=&orden;

select *
from open.ldc_otdalegalizar
where order_id=&orden;

select *
from open.ldc_otadicional
where order_id=&orden;

select *
from open.ldc_otdatoactividad
where order_id=&orden;

select *
from open.ldc_datoactividadotadicional a
where a.order_id=&orden;

---no ofertados
select codigo_material codigo, descripcion_material descripcion
  from ldc_or_task_types_materiales
 where tipo_trabajo = &tipotrabajo
   and (select count(liul.item)
          from ldc_item_uo_lr liul
         where liul.item = codigo_material) = 0
 order by codigo_material asc;


---ofertados 
select gi.items_id codigo, gi.description descripcion
  from ge_items gi
 where gi.items_id in
       (select *
          from open.ldc_item_uo_lr liuol , open.ge_items i
          where item=items_id
          and  liuol.unidad_operativa = 2630
           and liuol.actividad = 4000044
           and i.items_id=10004070)
 order by gi.items_id asc;
 
 
with base as(
select o.order_id, r.exec_final_date, o.operating_unit_id, o.execution_final_date, i.item, open.dage_items.fsbgetdescription(i.item, null) desc_item, i.cantidad
from open.ldc_otlegalizar r, open.ldc_otitem i, open.or_order o 
where o.order_id=&orden
  and r.order_id=i.order_id
  and r.order_id=o.order_id
)
select *
from base left join open.ge_list_unitary_cost c on trunc(base.exec_final_date) between c.validity_start_date and c.validity_final_date and base.operating_unit_id=c.operating_unit_id
  ;
 


with base as(
select o.order_id, r.exec_final_date, o.operating_unit_id, o.execution_final_date, i.task_type_id, i.actividad, i.material, open.dage_items.fsbgetdescription(i.material, null) desc_item, i.cantidad
from open.ldc_otlegalizar r, open.ldc_otadicional i, open.or_order o 
where o.order_id=&orden
  and r.order_id=i.order_id
  and r.order_id=o.order_id
)
select *
from base 
left join open.ge_list_unitary_cost c on trunc(base.exec_final_date) between c.validity_start_date and c.validity_final_date and base.operating_unit_id=c.operating_unit_id
left join open.ge_unit_cost_ite_lis li on li.list_unitary_cost_id=c.list_unitary_cost_id and li.items_id=base.material
  ;
 

      
 


--tabla principal
select *
from open.ldc_otlegalizar
where order_id=&orden;
--datos adiconales orden padre
select *
from open.ldc_otdalegalizar
where order_id=&orden;
--atributos orden padre
select *
from open.ldc_otdatoactividad
where order_id=&orden;
--atributos orden hija
select *
from open.ldc_datoactividadotadicional a
where a.order_id=&orden;
--trabajos adicionales
--ldc_tipotrabadiclego(configuracion)
--ordenes adicionales
select *
from open.ldc_otadicional
where order_id=&orden;
--items legalizados en la orden padre
select *
from open.ldc_otitem;
--datos adicionales ordenes adicionales
select *
from ldc_otadicionalda;



--tabla principal
select *
from open.ldc_otlegalizar
where order_id=&orden;
--datos adiconales orden padre
select *
from open.ldc_otdalegalizar
where order_id=&orden;
--atributos orden padre
select *
from open.ldc_otdatoactividad
where order_id=&orden;
--atributos orden hija
select *
from open.ldc_datoactividadotadicional a
where a.order_id=&orden;
--trabajos adicionales
--ldc_tipotrabadiclego(configuracion)
--ordene adicionales
select *
from open.ldc_otadicional
where order_id=&orden;
--items legalizados en la orden padre
select *
from open.ldc_otitem
where order_id=&orden;
--datos adicionales ordenes adicionales
select *
from ldc_otadicionaldas
where order_id=&orden;