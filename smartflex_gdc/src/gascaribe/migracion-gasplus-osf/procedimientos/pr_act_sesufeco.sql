CREATE OR REPLACE PROCEDURE PR_ACT_SESUFECO IS
/*
  Actualiza la fecha de corte para los usuarios suspendidos por Cartera
*/
cursor cuServsusc is
select *
from servsusc
where sesuesco in (3,5)
and sesufeco is null;

nuLogError NUMBER;

begin
	PKLOG_MIGRACION.prInsLogMigra (265,265,1,'PR_ACT_SESUFECO',0,0,'Inicia Proceso','INICIO',nuLogError);
   for rtSesu in cuServsusc loop

      update servsusc
      set sesufeco = sysdate
      where sesunuse = rtSesu.sesunuse;

      commit;

   end loop;
	PKLOG_MIGRACION.prInsLogMigra (265,265,3,'PR_ACT_SESUFECO',0,0,'Termina Proceso','FIN',nuLogError);
end PR_ACT_SESUFECO;
/
