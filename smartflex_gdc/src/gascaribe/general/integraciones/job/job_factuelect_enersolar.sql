declare
    nuConta number; 
begin
    select count(*) into nuConta
    from dba_scheduler_jobs
    where JOB_NAME = 'JOB_FACTUELECT_ENERSOLAR';
  
    IF nuConta > 0 THEN
        dbms_scheduler.set_attribute 
        (
            name        => 'JOB_FACTUELECT_ENERSOLAR',  
            attribute   => 'start_date',
            value       => round(sysdate,'hh24') + INTERVAL '3540' SECOND
        );  
    END IF;
end;
/