DECLARE

  cursor cuJob is
    select *
      from dba_jobs
     where upper(what) like
           upper('%LDC_PKCRMFINANCIACION.PRFINANCIARDUPLICADO%')
     order by 1 desc;

  rfJob cuJob%rowtype;

  sbcadena varchar2(4000);

BEGIN

  --recorrido de Job
  for rfJob in cuJob loop
  
    dbms_job.broken(rfJob.job, true);
    dbms_job.remove(rfJob.job);
    commit;
    dbms_output.put_line('Se detubo el JOB ' || rfJob.job);
  
  end loop;

exception
  when OTHERS then
    dbms_output.put_line('Error a detener el JOB ' || rfJob.job ||
                         ' - Error: ' || SQLERRM);
  
END;
/
