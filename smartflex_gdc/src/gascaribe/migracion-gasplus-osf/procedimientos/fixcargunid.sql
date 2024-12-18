CREATE OR REPLACE procedure fixcargunid
as

cursor cucargos
is
SELECT /*+parallel*/ rowid FROM cargos
  WHERE cargunid=0
  AND cargconc=31
  AND cargsign='DB';
  
begin

    for r in cucargos
    loop
    update cargos set cargunid=1 where rowid=r.rowid;
    commit; 
    end loop;

end; 
/
