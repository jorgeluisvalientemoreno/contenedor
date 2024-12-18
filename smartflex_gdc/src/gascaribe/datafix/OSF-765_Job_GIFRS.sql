declare
  job number;
begin
  sys.dbms_job.submit(job       => job,
                      what      => 'BEGIN SetSystemEnviroment; pkgldc_ifrs.prExecuteIFRS(2022, 11, 0) ; END;',
                      next_date => To_Date('22122022 10:15','DDMMYYYY HH24:MI'));
  dbms_output.put_line(job);
  commit;
end;
/
