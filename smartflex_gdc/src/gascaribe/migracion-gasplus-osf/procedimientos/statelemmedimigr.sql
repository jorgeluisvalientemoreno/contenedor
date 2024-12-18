CREATE OR REPLACE procedure      STATELEMMEDIMIGR(numinicio number, numfinal number, pbd number)
as
--- Control de errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;

begin

PKLOG_MIGRACION.prInsLogMigra (8400,178,1,'STATELEMMEDIMIGR',0,0,'Inicia Proceso','INICIO',nuLogError);
update migr_rango_procesos set raprfein=sysdate, raprterm='P' where raprcodi=8400 and raprbase=pbd and raprrain=numinicio and raprrafi=numfinal;
commit;

EXECUTE IMMEDIATE 'BEGIN DBMS_STATS.GATHER_TABLE_STATS('||chr(39)||'OPEN'||chr(39)||','||chr(39)||'COMPSESU'||chr(39)||', ESTIMATE_PERCENT => 100, CASCADE => TRUE); END;';
EXECUTE IMMEDIATE 'BEGIN DBMS_STATS.GATHER_TABLE_STATS('||chr(39)||'OPEN'||chr(39)||','||chr(39)||'ELEMMEDI'||chr(39)||', ESTIMATE_PERCENT => 100, CASCADE => TRUE); END;';
migra.statelemmedi;


PKLOG_MIGRACION.prInsLogMigra (8400,178,1,'STATELEMMEDIMIGR',0,0,'Inicia Proceso','INICIO',nuLogError);
update migr_rango_procesos set raprfefi=sysdate, raprterm='T' where raprcodi=8400 and raprbase=pbd and raprrain=numinicio and raprrafi=numfinal;
commit;
end; 
/
