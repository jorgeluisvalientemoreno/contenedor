CREATE OR REPLACE PROCEDURE fix_carg_2850 as

cursor cuCargos
is
SELECT rowid
FROM cargos
WHERE cargconc = 145
AND cargtipr = 'A'
AND cargprog = 161
AND cargfecr<=to_date('31/01/2014 23:59:59','dd/mm/yyyy hh24:mi:ss');

van number;
begin


    for r in cuCargos
    loop
        UPDATE cargos SET cargtipr = 'P' where rowid=r.rowid;
        van:=van+1;
        if van=1000 then
          van:=0;
          commit;
       end if;
    end loop;
    commit;

exception
    when others then
        rollback;
end;
/
