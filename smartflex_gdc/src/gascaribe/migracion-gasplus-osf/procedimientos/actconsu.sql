
  CREATE OR REPLACE PROCEDURE "OPEN"."ACTCONSU" is
cursor ss is select * from servsusc where sesunucp>0;
f date;
nuLogError NUMBER;
begin
     PKLOG_MIGRACION.prInsLogMigra (281,281,1,'ACTCONSU',0,0,'Inicia Proceso','INICIO',nuLogError);
  for s in ss loop
         select max(cossfere)
                into f
                from conssesu
                where cosssesu=s.sesunuse and
                      cossmecc=3;
         update conssesu
                set cossnvec=s.sesunucp
                where cosssesu=s.sesunuse and
                      cossmecc=3 and
                      cossfere=f and
                      rownum=1;
         commit;
     end loop;
  PKLOG_MIGRACION.prInsLogMigra (281,281,3,'ACTCONSU',0,0,'Termina Proceso','FIN',nuLogError);
end;
/
