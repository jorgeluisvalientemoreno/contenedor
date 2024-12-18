CREATE OR REPLACE PROCEDURE PR_ACTCONSU(NUMINICIO NUMBER,NUMFINAL NUMBER, inubasedato number) is
cursor ss is select * from servsusc where sesunucp>0;
f date;
nuLogError NUMBER;
begin
  PKLOG_MIGRACION.prInsLogMigra (281,281,1,'PR_ACTCONSU',0,0,'Inicia Proceso','INICIO',nuLogError);
  UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=281;
  commit;
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
  PKLOG_MIGRACION.prInsLogMigra (281,281,3,'PR_ACTCONSU',0,0,'Termina Proceso','FIN',nuLogError);
    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=281;
  commit;
end; 
/
