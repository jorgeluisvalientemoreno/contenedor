CREATE OR REPLACE PROCEDURE     FIX_CARGDOSO_2(numinicio number,numfinal number)
is

CURSOR cudiferidos
is
     SELECT difecodi,difenuse
     FROM diferido WHERE difesusc>1000000
     AND DIFESUSC >= NUMINICIO
     AND DIFESUSC <  NUMFINAL;
     ndiferido number;
     nuLogError NUMBER;
BEGIN

    PKLOG_MIGRACION.prInsLogMigra (282,282,1,'FIX_CARGDOSO',0,0,'Inicia Proceso','INICIO',nuLogError);
     for r in cudiferidos
     loop

         ndiferido:=r.difecodi-10000000;

         update /*+INDEX (CARGOS IX_CARGOS10)*/
         cargos
         set cargdoso='DF-'||r.difecodi
         where cargdoso='DF-'||ndiferido AND CARGNUSE=R.DIFENUSE;

         UPDATE CARGOS
             SET CARGDOSO='ID-'||r.difecodi
             where cargdoso='ID-'||ndiferido AND CARGNUSE=R.DIFENUSE;
         commit;
     END loop;
    PKLOG_MIGRACION.prInsLogMigra (282,282,3,'FIX_CARGDOSO',0,0,'Fin Proceso','FIN',nuLogError);
END; 
/
