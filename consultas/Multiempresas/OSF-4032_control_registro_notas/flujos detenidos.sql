select  'MOPRP' forma, 
                  p.package_id,
                  p.motive_status_id,
                  p.package_type_id, 
                  p.request_date, 
                  el.message,
                  null
from    open.mo_executor_log_mot lm,
                  open.ge_executor_log el,
                  open.mo_packages p
where   lm.executor_log_id = el.executor_log_id
         and         p.package_id = lm.package_id
         and         lm.status_exec_log_id = 4
         and p.package_id in (224783244)
union all
select  'MOPWP' forma, 
                  p.package_id,
                  p.motive_status_id,
                  p.package_type_id, 
                  p.request_date, 
                  el.message,
                  null
from    open.mo_wf_pack_interfac lm,
                  open.ge_executor_log el,
                  open.mo_packages p
where   lm.executor_log_id = el.executor_log_id
         and         p.package_id = lm.package_id
         and         lm.status_activity_id = 4
         and         p.package_id in (224783244)
union all         
select  'MOPWM' forma, 
                  p.package_id,
                  p.motive_status_id,
                  p.package_type_id, 
                  p.request_date,
                  el.message,
                  null
from    open.mo_wf_motiv_interfac lm,
                  open.ge_executor_log el,
                  open.mo_packages p,
                  open.mo_motive m
where   lm.executor_log_id = el.executor_log_id
         and         p.package_id = m.package_id
         and         m.motive_id = lm.motive_id
         and         p.package_id in (224783244)
union all
select  'MOPWC' forma, 
                  p.package_id,
                  p.motive_status_id,
                  p.package_type_id, 
                  p.request_date,
                  el.message,
                  null
from    open.mo_wf_comp_interfac lm,
                  open.ge_executor_log el,
                  open.mo_packages p,
                  open.mo_component c
where   lm.executor_log_id = el.executor_log_id
         and     p.package_id = c.package_id
         and     c.component_id = lm.component_id
         and     lm.status_activity_id = 4
         and         p.package_id in (224783244)
union all
select  'INRMO/WFEWF' forma,
                  p.package_id,
                  p.motive_status_id,
                  p.package_type_id, 
                  p.request_date,
                  el.message_desc,
                  null
from  open.wf_instance wf, 
                  open.wf_exception_log el, 
                  open.mo_packages p,
    open.wf_data_external de
where   wf.instance_id = el.instance_id
         and         de.plan_id = wf.plan_id
  and de.package_id=p.package_id
         and         wf.status_id = 9
         and         el.status = 1
         and         p.package_id in (224783244)  
union all
select  'INRMO' forma,
                  p.package_id,
                  p.motive_status_id,
                  p.package_type_id, 
                  p.request_date, 
                  last_mess_desc_error,
                  w.instance_id
from    open.in_interface_history i,
    open.wf_instance w, 
    open.mo_packages p,
    open.wf_data_external de
where   i.status_id = 9
  and i.request_number_origi=w.instance_id 
  and de.plan_id=w.plan_id
  and de.package_id=p.package_id
  and  p.package_id in (224783244)
order by request_date
