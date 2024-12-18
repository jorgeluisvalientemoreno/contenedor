CREATE OR REPLACE PROCEDURE POSTCARGOS(NUMINICIO   number,
                                       NUMFINAL    number,
                                       inubasedato number) as

  JobNo   user_jobs.job%TYPE;
  WHAT    VARCHAR2(1000);
  dtFecha date;
  sw      number;
  c       number;
  sbsql   varchar2(1000);

  cursor cunew is
    Select * from migra.trackpostcargos;
  nucount number;
begin

  UPDATE migr_rango_procesos
     set raprfein = sysdate, raprterm = 'P'
   where raprcodi = 430
     and raprbase = inubasedato
     and raprrain = numinicio
     and raprrafi = NUMFINAL;
  commit;

 UPDATE MIGRA.trackpostcargos SET ESTADO= 'P';
  commit;

  sbsql := 'alter session set ddl_lock_timeout = 600';
  execute immediate sbsql;

  FOR r IN cunew LOOP
    WHAT := 'CREA_INDEX(' || chr(39) || r.indexname || chr(39) || ');';
    DBMS_JOB.SUBMIT(JobNo, WHAT, sysdate);
    COMMIT;
  END LOOP;
  sw := 0;

  while sw = 0 loop
    select count(1) into c FROM trackpostcargos where estado = 'P';
    if c = 0 then
      sw := 1;
    end if;
  end loop;

  select count(1) into nucount from or_route_premise;

  if nucount = 0 then
    PR_OR_ROUTE_PREMISE(inubasedato);
  end if;
  
  if inubasedato=5 then
    CLASEELEMMEDIMIGR(5);
  end if;
  


  EXECUTE IMMEDIATE 'ALTER SYSTEM FLUSH SHARED_POOL';

  UPDATE migr_rango_procesos
     set raprfefi = sysdate, raprterm = 'T'
   where raprcodi = 430
     and raprbase = inubasedato
     and raprrain = numinicio
     and raprrafi = NUMFINAL;
  commit;
end; 
/
