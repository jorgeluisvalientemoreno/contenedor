insert into open.cargos
(select 
-1, 
cargnuse, 
cargconc, 
cargcaca, 
cargsign, 
cargpefa, 
cargvalo, 
cargdoso, 
cargcodo, 
cargusua, 
cargtipr, 
cargunid, 
trunc(sysdate), 
cargprog, 
cargcoll, 
cargpeco, 
cargtico, 
cargvabl, 
cargtaco
from open.cargos@osfpl c1 
where cargcaca = 16 
and cargpefa= 114061 
and exists ( select null 
            from open.servsusc 
            where c1.cargnuse= sesunuse )
);