--registro_actividades_wf_para_los_paquetes
select i.wf_pack_interfac_id,
       i.activity_id,
       i.recording_date,
       i.attendance_date,
       i.package_id,
       i.causal_id_input,
       i.causal_id_output,
       c.description,
       i.status_activity_id,
       s.description,
       i.executor_log_id,
       i.action_id,
       a.description,
       i.try_amount,
       i.previous_activity_id,
       i.undo_activity_id,
       i.sequence
from mo_wf_pack_interfac i
inner join mo_status_activity  s  on s.status_activity_id = i.status_activity_id
inner join ge_action_module  a  on a.action_id = i.action_id
inner join ge_causal  c  on c.causal_id = i.causal_id_output
where i.package_id = 206933521
order by i.recording_date
