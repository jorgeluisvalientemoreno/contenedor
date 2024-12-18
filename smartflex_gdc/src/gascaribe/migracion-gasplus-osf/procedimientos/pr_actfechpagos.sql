CREATE OR REPLACE procedure pr_actfechpagos (numinicial number,numfinal number) is
cursor pa is select /*+ index(pagos ix_pago_susc) */ * from pagos
where pagosusc>= numinicial and pagosusc<numfinal order by pagofepa asc;
van number;
nuLogError NUMBER;
cursor ca(cup number)  is select rowid,cargcuco from cargos where cargcodo=cup and cargsign in ('PA','SA') order by cargfecr;
begin
     van:=0;
     PKLOG_MIGRACION.prInsLogMigra (802,802,1,'pr_actfechpagos',0,0,'Inicia Proceso job '||to_char(numinicial),'INICIO',nulogerror);
     for p in pa loop
         van:=van+1;
         for c in ca(p.pagocupo) loop
             update cargos set cargfecr=p.PAGOFEGR where rowid=c.rowid;
             UPDATE CUENCOBR SET CUCOFEPA=P.PAGOFEPA WHERE CUCOCODI=C.CARGCUCO;
         END LOOP;
         if van=1000 then
            commit;
            van:=0;
         end if;
     end loop;
     commit;

     PKLOG_MIGRACION.prInsLogMigra (802,802,3,'pr_actfechpagos',0,0,'termina Proceso job '||to_char(numinicial),'termina',nulogerror);
end;
/
