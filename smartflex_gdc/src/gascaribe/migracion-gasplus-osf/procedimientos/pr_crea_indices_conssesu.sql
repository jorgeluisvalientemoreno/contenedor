CREATE OR REPLACE PROCEDURE PR_CREA_INDICES_CONSSESU(NUMINICIO   number,
                                                     NUMFINAL    number,
                                                     inudatabase number) as
  sbsql varchar2(8000);

  JobNo   user_jobs.job%TYPE;
  WHAT    VARCHAR2(1000);
  dtFecha date;
  sw      number;
  c       number;


  cursor cunew is
    Select * from migra.trackpostconsesu;

BEGIN

  UPDATE MIGR_RANGO_PROCESOS
     SET RAPRTERM = 'P', RAPRFEIN = sysdate
   WHERE raprbase = inudatabase
     AND raprrain = NUMINICIO
     AND raprrafi = NUMFINAL
     AND raprcodi = 3615;

  UPDATE MIGRA.trackpostconsesu SET ESTADO= 'P';

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
    select count(1) into c FROM MIGRA.trackpostconsesu where estado = 'P';
    if c = 0 then
      sw := 1;
    end if;
  end loop;

  UPDATE MIGR_RANGO_PROCESOS
     SET RAPRTERM = 'T', RAPRFEFI = sysdate
   WHERE raprbase = inudatabase
     AND raprrain = NUMINICIO
     AND raprrafi = NUMFINAL
     AND raprcodi = 3615;
  commit;

END; 
/
