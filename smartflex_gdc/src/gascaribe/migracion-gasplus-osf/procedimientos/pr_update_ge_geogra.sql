CREATE OR REPLACE procedure PR_UPDATE_GE_GEOGRA(sbFLAG varchar2)
as
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;
   vprograma              VARCHAR2 (100);
begin

if sbFLAG ='N' then
-- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (3700,3700,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
else
-- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (3701,3701,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
end if;

update ge_geogra_location set NORMALIZED =sbFLAG;
commit;

if sbFLAG ='N' then
-- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (3700,3700,3,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
else
-- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (3701,3701,3,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
end if;
end PR_UPDATE_GE_GEOGRA;
/
