select *
from open.wf_data_external d
where package_id=143159620;

select *
from open.wf_instance s, open.wf_instance_status ei
where plan_id=1686673147
  and ei.instance_status_id=s.status_id
  and instance_status_id=9
  and s.instance_id in (1327894889, 1327894885);
  
select i.instance_id, p.package_id, p.package_type_id, p.request_date, i.status_id, i.previous_status_id
from open.wf_instance i, open.wf_data_External d, open.mo_packages p
where i.unit_id=100903  
  and i.plan_id=d.plan_id
  and p.package_id=d.package_id
  and p.request_date>='10/03/2020'
  and exists(select null from  open.wf_instance_attrib a where a.instance_id=i.instance_id and  attribute_id=442 and a.statement_id=120182377 and a.mandatory='Y') 

  ;
select *
from open.wf_instance_attrib a, open.ge_attributes s
where instance_id=1687341062
  and s.attribute_id=a.attribute_id  
  
select *
from open.or_order_Activity
where instance_id in (299449647,299449655,299449671)  
  
select *
from open.wf_exception_log
where instance_id in (select s.instance_id
from open.wf_instance s, open.wf_instance_status ei
where plan_id=1327894880
  and ei.instance_status_id=s.status_id);
  
select d.package_id, i.instance_id, i.status_id, s.description, l.*
from  open.wf_exception_log l, open.wf_instance i , open.wf_data_external d, open.wf_instance_status s
where log_date>='06/06/2019'
  and message_desc='Error de java null.'
  and i.instance_id=l.instance_id
  and d.plan_id =i.plan_id 
  and d.package_id in (106937711 , 103409285 )
  and s.instance_status_id=i.status_id
  
select *
from open.wf_instance i, open.wf_data_external d
where instance_iD=1348501352
 and i.plan_id=d.plan_id
  
select *
from open.ge_error_log l
where time_stamp='14/06/2019 18:33:10'; 
 
SELECT *
FROM OPEN.WF_INSTANCE_TRANS S
WHERE S.ORIGIN_ID=1327894885;

select *
from open.wf_instance_trans s, open.wf_instance i1, open.wf_instance i2
where expression='STATUS_ID == ESTADO_FINALIZADO'
and i1.instance_id=s.origin_id
and i1.unit_type_id=1824
and i2.instance_id=s.target_id
and i2.unit_type_id=1825
--and s.origin_id=1327894885
and i1.initial_date>='01/01/2019'
;
select *
from open.wf_exception_log
where instance_id=1687341062;

select *
from open.wf_instance_attrib a, open.ge_attributes s
where instance_id=1687341062
  and s.attribute_id=a.attribute_id;
  


select wf_data_external.package_id,
wf_data_external.pack_type_tag,
wf_instance.instance_id,
wf_instance.description,
wf_instance.plan_id,
wf_instance.action_id||'-'||ge_action_module.description accion,
ge_action_module.config_expression_id||' - '||gr_config_expression.description regla
from wf_instance,
  wf_data_external,
  ge_action_module,
  gr_config_expression
where wf_data_external.package_id=123750121
  and wf_data_external.plan_id=wf_instance.plan_id
  and ge_action_module.action_id=wf_instance.action_id
  and ge_action_module.config_expression_id=gr_config_expression.config_expression_id
