
declare
 nuSolicitud number:=192687794;
 nuInicio number:=1031;
 nuIncremento number:=1;
 
 cursor cuGetPlanSol is
 select *
 from open.wf_data_external d
 where d.package_id=nuSolicitud;
 
 
 cursor cuGetInstancia(nuPlan number) is
 select *
 from open.wf_instance 
 where plan_id=nuPlan
 order by instance_id;
 
 cursor cuBloqueaInstancia(nuPlan number) is
  SELECT WF_instance.*,WF_instance.rowid
  FROM WF_instance
  WHERE  plan_id = nuPlan
  FOR UPDATE NOWAIT;
begin
  for reg in cuGetPlanSol loop
     begin
      for reg2 in cuBloqueaInstancia(reg.plan_id) loop
        dbms_output.put_line('instancia_bloqueada: '||reg2.instance_id);
      end loop;
      for reg2 in cuGetInstancia(reg.plan_id) loop
          insert into wf_instance(instance_id,description,parent_id,original_task,plan_id,unit_id,status_id,previous_status_id,online_exec_id,action_id,pre_expression_id,pos_expression_id,quantity,initial_date,final_date,sincronic_timeout,asincronic_timeout,layer_id,external_id,geometry,try_number,multi_instance,function_type,node_type_id,module_id,is_countable,total_time,parent_external_id,entity_id,par_ext_entity_id,group_id,min_group_size,unit_type_id,execution_order,annulation_order,notification_id,execution_id,previous_instance_id) 
           select nuInicio, i.description, i.parent_id, i.original_task, i.plan_id, i.unit_id, i.status_id, i.previous_status_id, i.online_exec_id, i.action_id, i.pre_expression_id, i.pos_expression_id, i.quantity, i.initial_date, i.final_date, i.sincronic_timeout, i.asincronic_timeout, i.layer_id, i.external_id, i.geometry, i.try_number, i.multi_instance, i.function_type, i.node_type_id, i.module_id, i.is_countable, i.total_time, i.parent_external_id, i.entity_id, i.par_ext_entity_id, i.group_id, i.min_group_size, i.unit_type_id, i.execution_order, i.annulation_order, i.notification_id, i.execution_id, i.previous_instance_id from wf_instance i where i.instance_id=reg2.instance_id;
          --data_map
          update wf_instance_data_map m set m.source_id=nuInicio where m.source_id=reg2.instance_id;
          update wf_instance_data_map m set m.target=nuInicio where m.target=reg2.instance_id;
          --Wf_instance_attrib
          update wf_instance_attrib a set a.instance_id = nuInicio where a.instance_id=reg2.instance_id;
          
		  --mo_wf_comp_interfac
          update mo_wf_comp_interfac c set  c.ACTIVITY_ID =nuInicio where c.activity_id=reg2.instance_id;
		  update mo_wf_comp_interfac c set  c.PREVIOUS_ACTIVITY_ID =nuInicio where c.PREVIOUS_ACTIVITY_ID=reg2.instance_id;
		  update mo_wf_comp_interfac c set  c.UNDO_ACTIVITY_ID =nuInicio where c.UNDO_ACTIVITY_ID=reg2.instance_id;
          
		  
		  ---mo_wf_motiv_interfac
          update mo_wf_motiv_interfac c set c.ACTIVITY_ID = nuInicio where c.activity_id=reg2.instance_id;
		  update mo_wf_motiv_interfac c set c.PREVIOUS_ACTIVITY_ID = nuInicio where c.PREVIOUS_ACTIVITY_ID=reg2.instance_id;
		  update mo_wf_motiv_interfac c set c.UNDO_ACTIVITY_ID = nuInicio where c.UNDO_ACTIVITY_ID=reg2.instance_id;
          
		  
		  --MO_WF_PACK_INTERFAC
          update mo_wf_pack_interfac c set c.ACTIVITY_ID = nuInicio where c.activity_id=reg2.instance_id;
		  update mo_wf_pack_interfac c set c.PREVIOUS_ACTIVITY_ID = nuInicio where c.PREVIOUS_ACTIVITY_ID=reg2.instance_id;
		  update mo_wf_pack_interfac c set c.UNDO_ACTIVITY_ID = nuInicio where c.UNDO_ACTIVITY_ID=reg2.instance_id;
          
          update wf_exception_log l set l.instance_id = nuInicio where l.instance_id=reg2.instance_id;
          
          update wf_instance_trans t set  t.TARGET_ID = nuInicio where t.target_id = reg2.instance_id;
          update wf_instance_trans t set  t.origin_id = nuInicio where t.origin_id = reg2.instance_id;
          update wf_instance_equiv e set  e.instance_id= nuInicio where e.instance_id=reg2.instance_id;
          update wf_data_external d set plan_id=nuInicio where plan_id=reg2.instance_id;
          
          update wf_instance set plan_id=nuInicio where plan_id=reg2.instance_id;
          update wf_instance set ORIGINAL_TASK=nuInicio where ORIGINAL_TASK = reg2.instance_id;
          update wf_instance set PARENT_ID=nuInicio where PARENT_ID = reg2.instance_id;
          update wf_instance set PREVIOUS_INSTANCE_ID=nuInicio where PREVIOUS_INSTANCE_ID = reg2.instance_id;
          update or_order_activity set instance_id=nuInicio where instance_id=reg2.instance_id;
          update in_interface_history  set request_number_origi  = nuInicio where request_number_origi = reg2.instance_id;
          delete wf_instance i where i.instance_id=reg2.instance_id;
          nuInicio := nuInicio + nuIncremento;
      end loop;
  end loop;
   
end;
