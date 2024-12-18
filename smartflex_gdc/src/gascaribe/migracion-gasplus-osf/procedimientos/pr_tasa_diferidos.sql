CREATE OR REPLACE procedure pr_tasa_diferidos is

  cursor cuDiferidos is
  select *
  from diferido;

  nuLogError number;
begin
	PKLOG_MIGRACION.prInsLogMigra (271,271,1,'pr_tasa_diferidos',0,0,'Inicia Proceso','INICIO',nuLogError);
   for rtDife in cuDiferidos loop

       if (rtDife.difeinte = 0) then

           update diferido
           set difemeca = 2,
               difetain = 1
           where difecodi = rtDife.difecodi;

       elsif ((rtDife.difeinte > 0) and (rtDife.difeinte < 13)) then
           update diferido
           set difemeca = 2,
               difetain = 6
           where difecodi = rtDife.difecodi;
       else
           update diferido
           set difemeca = 4,
               difetain = 2
           where difecodi = rtDife.difecodi;

       end if;
       commit;

   end loop;

   null;
   PKLOG_MIGRACION.prInsLogMigra (271,271,3,'pr_tasa_diferidos',0,0,'Termina Proceso','FIN',nuLogError);
end;
/
