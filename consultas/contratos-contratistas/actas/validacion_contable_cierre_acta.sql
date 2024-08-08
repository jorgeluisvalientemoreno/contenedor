 with base as (Select o.order_id,
             decode(o.task_type_id,10336, o.real_task_type_id, o.task_type_id) task_type_id,
             o.task_type_id titr_validar,
             ab.geograp_location_id,
             o.defined_contract_id,
             ( Select ct.clctclco From open.ic_clascott ct Where ct.clcttitr = decode(o.task_type_id, 10336, o.real_task_type_id, o.task_type_id)) clas,
             nvl((select 'S' from open.ct_item_novelty N, open.or_order_activity a where a.activity_id=n.items_id and a.order_id=o.order_id and rownum=1),'N') es_novedad,
             (select r.order_id from open.or_related_order r where r.related_order_id=o.order_id and r.rela_order_type_id=14) ot_padre
        From open.or_order          o,
             open.or_operating_unit ou,
             open.ab_address             ab,
             open.ct_order_certifica        da,
             open.ldc_tt_tb tb
       Where o.order_status_id = 8
         And o.operating_unit_id = ou.operating_unit_id
         And ab.address_id = o.external_address_id
         And upper(ou.es_externa) = 'Y'
         And da.order_id = o.order_id
         and tb.task_type_id = decode(o.task_type_id, 10336, o.real_task_type_id, o.task_type_id)
         And da.certificate_id = &nuacta
         and tb.active_flag='Y'),
base2 as(
select base.*,
       (Select cg.cuencosto  From open.ldci_cugacoclasi cg Where cg.cuenclasifi = base.clas And cg.cuencosto Is Not Null) cuenta,
       case when instr((  Select casevalo From open.ldci_carasewe Where casecodi = 'CLASIACTIVOS'), base.clas||',')> 0 then 'S' else 'N' end clas_activo,
       (select case when CEIL(s.capture_order/20) > 1 then   
                 decode((s.capture_order-(CEIL(s.capture_order/20)*10 )),1, value_1,2,value_2,3, value_3, 4, value_4, 5,value_5, 6, value_6, 7,value_7, 8,value_8, 9,value_9,10,value_10,11,value_11,12,value_12,13, value_13, 14,value_14, 15, value_15, 16, value_16,17, value_17, 18, value_18, 19, value_19, 20,value_20, 'NA')
                else
                  decode(s.capture_order,1, value_1,2,value_2,3, value_3, 4, value_4, 5,value_5, 6, value_6, 7,value_7, 8,value_8, 9,value_9,10,value_10,11,value_11,12,value_12,13, value_13, 14,value_14, 15, value_15, 16, value_16,17, value_17, 18, value_18, 19, value_19, 20,value_20, 'NA')
         end 
from open.OR_TASKTYPE_ADD_DATA D,open.ge_attrib_set_attrib s,  open.ge_attributes a, open.or_requ_data_value r , open.or_order o, open.or_order_activity a3
where d.task_type_id=O.TASK_TYPE_ID
  AND D.ATTRIBUTE_SET_ID=s.ATTRIBUTE_SET_ID
  and s.attribute_id=a.attribute_id
--  and a.name_attribute  in ('LONG_INST_INTERNA','MATERIAL_INST_INTERNA','PTOS_ADICIONALES','PTOS_OPCIONALES','PUNTOS_CONST_INST','UBICACIÓN_INST_INTERNA') 
  and r.attribute_set_id=d.attribute_set_id
and r.order_id=o.order_id
and O.order_id=base.order_id
and a.name_attribute=( Select casevalo  From open.ldci_carasewe      Where casecodi = 'NOMB_ATRIB_ACTIVO_OT')
and o.order_id=a3.order_id) activo,
( select count(1) from OPEN.ldci_actiubgttra 
                   where ACBGLOCA = base.geograp_location_id
                     AND ACBGTITR = base.task_type_id) cant_activo,
(Select ccbgceco From open.ldci_cecoubigetra Where ccbgloca = base.geograp_location_id And ccbgtitr = base.task_type_id) ceco,
(select open.dald_parameter.fsbgetvalue_chain('LDC_VAL_CONT_CUENTAMULTAS',null) from dual) cta_multa,
case when base.es_novedad='S' then
  (select case when CEIL(s.capture_order/20) > 1 then   
                 decode((s.capture_order-(CEIL(s.capture_order/20)*10 )),1, value_1,2,value_2,3, value_3, 4, value_4, 5,value_5, 6, value_6, 7,value_7, 8,value_8, 9,value_9,10,value_10,11,value_11,12,value_12,13, value_13, 14,value_14, 15, value_15, 16, value_16,17, value_17, 18, value_18, 19, value_19, 20,value_20, 'NA')
                else
                  decode(s.capture_order,1, value_1,2,value_2,3, value_3, 4, value_4, 5,value_5, 6, value_6, 7,value_7, 8,value_8, 9,value_9,10,value_10,11,value_11,12,value_12,13, value_13, 14,value_14, 15, value_15, 16, value_16,17, value_17, 18, value_18, 19, value_19, 20,value_20, 'NA')
         end 
from open.OR_TASKTYPE_ADD_DATA D,open.ge_attrib_set_attrib s,  open.ge_attributes a, open.or_requ_data_value r , open.or_order o, open.or_order_activity a3
where d.task_type_id=O.TASK_TYPE_ID
  AND D.ATTRIBUTE_SET_ID=s.ATTRIBUTE_SET_ID
  and s.attribute_id=a.attribute_id
--  and a.name_attribute  in ('LONG_INST_INTERNA','MATERIAL_INST_INTERNA','PTOS_ADICIONALES','PTOS_OPCIONALES','PUNTOS_CONST_INST','UBICACIÓN_INST_INTERNA') 
  and r.attribute_set_id=d.attribute_set_id
and r.order_id=o.order_id
and O.order_id=base.ot_padre
and a.name_attribute=( Select casevalo  From open.ldci_carasewe      Where casecodi = 'NOMB_ATRIB_ACTIVO_OT')
and o.order_id=a3.order_id) else null end  activo_padre
  
from base)
select b.order_id,	
       b.task_type_id,
       open.daor_task_type.fsbgetdescription(b.task_type_id, null) desc_titr,
       b.geograp_location_id,
       open.dage_geogra_location.fsbgetdescription(b.geograp_location_id,null) desc_loca,
       clas clasificador,
       cuenta,
       activo,
       cant_activo configuracion_activo,
       ceco,
       'NO TIENE CLASIFICADOR' ERROR,
       null activo_padre
from base2 b
where b.clas is null
union all
select b.order_id,	
       b.task_type_id,
       open.daor_task_type.fsbgetdescription(b.task_type_id, null) desc_titr,
       b.geograp_location_id,
       open.dage_geogra_location.fsbgetdescription(b.geograp_location_id,null) desc_loca,
       clas clasificador,
       cuenta,
       activo,
       cant_activo configuracion_activo,
       ceco,
       'NO TIENE CUENTA' ERROR,
       null activo_padre
from base2 b
where b.cuenta is null
union all
select b.order_id,	
       b.task_type_id,
       open.daor_task_type.fsbgetdescription(b.task_type_id, null) desc_titr,
       b.geograp_location_id,
       open.dage_geogra_location.fsbgetdescription(b.geograp_location_id,null) desc_loca,
       clas clasificador,
       cuenta,
       activo,
       cant_activo configuracion_activo,
       ceco,
       'NO TIENE CECO' ERROR,
       null activo_padre
from base2 b
where b.clas_Activo='N'
  and b.ceco is null
  and instr(b.cta_multa, b.cuenta)=0
  
union all
select b.order_id,	
       b.task_type_id,
       open.daor_task_type.fsbgetdescription(b.task_type_id, null) desc_titr,
       b.geograp_location_id,
       open.dage_geogra_location.fsbgetdescription(b.geograp_location_id,null) desc_loca,
       clas clasificador,
       cuenta,
       activo,
       cant_activo configuracion_activo,
       ceco,
       'TIENE ERROR DE ACTIVO' ERROR,
       activo_padre 
from base2 b
where b.clas_Activo='S'
  and (activo is null and ( cant_activo>1 or cant_activo=0))  
