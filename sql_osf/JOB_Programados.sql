select *
  from dba_jobs
 where upper(what) like upper('%PRC_FINANCIA_DUPLICADO%')
 order by 1 desc;

select sysdate,
       dsj.last_start_date,
       dsj.next_run_date,
       dsj.owner,
       dsj.job_name,
       dsj.JOB_SUBNAME,
       dsj.JOB_STYLE,
       dsj.JOB_CREATOR,
       dsj.client_id,
       dsj.GLOBAL_UID,
       dsj.PROGRAM_OWNER,
       dsj.PROGRAM_NAME,
       dsj.JOB_TYPE,
       dsj.JOB_ACTION,
       dsj.NUMBER_OF_ARGUMENTS,
       dsj.SCHEDULE_OWNER,
       dsj.SCHEDULE_NAME,
       dsj.SCHEDULE_TYPE,
       dsj.start_date,
       dsj.REPEAT_INTERVAL,
       dsj.EVENT_QUEUE_OWNER,
       dsj.EVENT_QUEUE_NAME,
       dsj.EVENT_QUEUE_AGENT,
       dsj.EVENT_CONDITION,
       dsj.event_rule,
       dsj.FILE_WATCHER_OWNER,
       dsj.FILE_WATCHER_NAME,
       dsj.end_date,
       dsj.JOB_CLASS,
       dsj.ENABLED,
       dsj.AUTO_DROP,
       dsj.RESTARTABLE,
       dsj.STATE,
       dsj.JOB_PRIORITY,
       dsj.run_count,
       dsj.max_runs,
       dsj.failure_count,
       dsj.max_failures,
       dsj.retry_count,
       dsj.LAST_RUN_DURATION,
       dsj.schedule_limit,
       dsj.max_run_duration,
       dsj.LOGGING_LEVEL,
       dsj.STOP_ON_WINDOW_CLOSE,
       dsj.INSTANCE_STICKINESS,
       dsj.RAISE_EVENTS,
       dsj.SYSTEM,
       dsj.job_weight,
       dsj.nls_env,
       dsj.source,
       dsj.number_of_destinations,
       dsj.DESTINATION_OWNER,
       dsj.destination,
       dsj.credential_owner,
       dsj.credential_name,
       dsj.instance_id,
       dsj.DEFERRED_DROP,
       dsj.allow_runs_in_restricted_mode,
       dsj.comments,
       dsj.flags
  from dba_scheduler_jobs dsj
 where upper(job_action) like upper('%PRC_FINANCIA_DUPLICADO%');

select gps.*
  from open.ge_process_schedule gps,
       (select g.object_id
          from open.ge_object g
         where upper(g.name_) like upper('%GENER%')) gobject
 where gps.parameters_ like '%OBJECT_ID=' || gobject.object_id || '%'
--and gps.job != -1
;
select g.*
  from open.ge_object g
--where upper(g.name_) like upper('%GENER%') 
 order g.object_id desc
