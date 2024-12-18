CREATE OR REPLACE PROCEDURE PLATAFORMAK IS
  JobNo user_jobs.job%TYPE;
  WHAT VARCHAR2(100);
  dtFecha date;

  
  cursor cuinicio
  is
  SELECT *
  FROM migra.MIGR_PROCESOS;

  cursor ran (inuraprcodi number)
  is
  select *
  from MIGR_RANGO_PROCESOS
  where raprcodi=inuraprcodi;

  cursor curanprec (inuraprcodi number)
  is
  select count(1)
  from MIGR_RANGO_PROCESOS
  where raprcodi=inuraprcodi
  AND raprterm in ('N','P','M');


  tbproc      ut_string.TyTb_String;

  cursor cumaster
  is
  SELECT
  count(1)
  FROM MIGR_RANGO_PROCESOS
  WHERE RAPRTERM in ('N','M');

  nucuentot number;
  nucunenind number;
  numaster   number:=1;
begin



--  commit;


WHILE numaster <> 0
loop



  for r in cuinicio
  loop
       nucuentot:=0;

       tbProc.delete;
       ut_string.ExtString(R.procprec,'|',tbProc);

       for nuIdx in tbProc.first .. tbProc.last loop
          nucunenind:=0;

           if (tbproc(nuIdx) <>0 )
            then

                open curanprec (tbproc(nuIdx));
                fetch  curanprec into  nucunenind;
                close curanprec;

                nucuentot:=nucuentot +nucunenind;
           else
               nucuentot:=0;
           END if;

       END loop;


        if   nucuentot=0 then
            for j in ran (R.PROCCODI)
            loop

              if j.raprterm='N' then
               UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=j.raprbase AND raprrain=j.raprrain AND raprrafi=j.raprrafi AND raprcodi=r.proccodi;
                commit;
                WHAT:= r.procnomb||'('||to_char(j.raprrain)||','||to_char(j.raprrafi)||','||to_char(j.raprbase)||');';
                DBMS_JOB.SUBMIT(JobNo, WHAT, sysdate);
                COMMIT;
              END if;

            END loop;

        END if;

        open cumaster;
        fetch cumaster INTO numaster;
        close cumaster;


  END loop;
        dbms_lock.sleep(60);
END loop;
 modifyrecuperado;
 fix_sequences;
 deletesuscripc(1,1,1);
 migrhabilitatriggers;
    

END; 
/
