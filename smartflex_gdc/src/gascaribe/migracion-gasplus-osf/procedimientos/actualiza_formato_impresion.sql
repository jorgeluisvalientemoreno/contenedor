
  CREATE OR REPLACE PROCEDURE "OPEN"."ACTUALIZA_FORMATO_IMPRESION" IS

nuLogError NUMBER;
nuTotalRegs number := 0;
nuErrores number := 0;

BEGIN

   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (249,249,1,'ACTUALIZA_FORMATO_IMPRESION',0,0,'Inicia Proceso','INICIO',nuLogError);

    UPDATE suscripc SET  susccemd= 24, susccoem=24
    WHERE susccodi in (select sesususc FROM servsusc  where sesucate in (3))
    AND (suscripc.susccemd   IS null
    OR suscripc.susccoem IS null);

  -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra (249,249,3,'ACTUALIZA_FORMATO_IMPRESION',nuTotalRegs,nuErrores,'TERMINO PROCESO #regs: '||nuTotalRegs,'FIN',nuLogError);


EXCEPTION
   WHEN OTHERS
   THEN
      PKLOG_MIGRACION.prInsLogMigra ( 249,249,2,'ACTUALIZA_FORMATO_IMPRESION',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);

END ACTUALIZA_FORMATO_IMPRESION;
/
