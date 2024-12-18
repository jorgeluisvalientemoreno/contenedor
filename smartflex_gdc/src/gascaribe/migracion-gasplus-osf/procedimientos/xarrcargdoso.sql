CREATE OR REPLACE procedure xarrcargdoso is
cursor xc is select rowid from cargos where cargconc in
(156,319,508,507,557,25,40,220,198,196,589,37,570,33,10) and cargfecr<=
to_date('31/01/2014 23:59:59','dd/mm/yyyy hh24:mi:ss') and
cargdoso=' ';
van number;
begin
   for c in xc loop
       update cargos set cargdoso='-' where rowid=c.rowid;
       van:=van+1;
       if van=1000 then
          van:=0;
          commit;
       end if;
   end loop;
end; 
/
