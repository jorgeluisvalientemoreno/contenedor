CREATE OR REPLACE PROCEDURE      "MIGRACARGOS2"(numinicio number,
                                               numfinal  number,
                                               PBD       NUMBER) IS
  JobNo   user_jobs.job%TYPE;
  WHAT    VARCHAR2(1000);
  dtFecha date;
  sw      number;
  c       number;
  iniyear  number;
  finyear  number;
begin
  update migr_rango_procesos
     set raprfein = sysdate, RAPRTERM = 'P'
   where raprcodi = 427
     and raprbase = pbd
     and raprrain = numinicio
     and raprrafi = NUMFINAL;
  dtFecha := (sysdate + 1 * (1 / 24 / 60));
  DELETE FROM trackmigrcargos;
  
  if pbd in (1,4,5) then
  
     EXECUTE IMMEDIATE 'ALTER SYSTEM FLUSH SHARED_POOL';
  
  End if;
  
  select min(cargano), max(cargano) into iniyear,finyear from ldc_temp_cargos_sge where cargano<>-1;

   
  commit;
  FOR A IN iniyear .. finyear LOOP
    FOR M IN 1 .. 12 LOOP
      WHAT := 'CARGOSMIGR(' || TO_CHAR(PBD) || ',' || TO_CHAR(A) || ',' ||
              TO_CHAR(M) || ');';
      DBMS_JOB.SUBMIT(JobNo, WHAT, dtFecha);
      insert into trackmigrcargos
        (bd, ano, mes, estado)
      values
        (pbd, a, m, 'P');
      COMMIT;
    END LOOP;
  END LOOP;
  sw := 0;
  while sw = 0 loop
    select count(1) into c FROM trackmigrcargos where estado = 'P';
    if c = 0 then
      sw := 1;
    end if;
  end loop;

  UPDATE migr_rango_procesos
     set raprfefi = sysdate, raprterm = 'T'
   where raprcodi = 427
     and raprbase = pbd
     and raprrain = numinicio
     and raprrafi = NUMFINAL;
  commit;
END; 
/
