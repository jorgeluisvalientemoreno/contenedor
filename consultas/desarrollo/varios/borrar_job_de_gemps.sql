declare
  cursor cuJobs is
  select *
  from open.ge_process_schedule s
  where s.job<>-1
    and s.job=XXx;
begin
    for reg in cuJobs loop
        ge_boschedule.dropschedule(reg.PROCESS_SCHEDULE_ID);
        DBMS_JOB.REMOVE(reg.job);
        COMMIT;
    end loop;
end;
