CREATE OR REPLACE procedure xarrajustacargos (cv number,cn number) is
cursor carg (concviejo number) is
       select rowid
              from cargos
              where cargfecr>=to_date('15/06/2013 00:00:01', 'dd-mm-yyyy hh24:mi:ss') and
                    cargfecr<=to_date('02-02-2014 23:59:59', 'dd-mm-yyyy hh24:mi:ss') and
                    cargconc=concviejo;
van number;
begin
     van:=0;
     for c in carg(cv) loop
         update cargos set cargconc=cn where rowid=c.rowid;
         van:=van+1;
         if van=1000 then
            commit;
            van:=0;
         end if;
     end loop;
     commit;
end;
/
