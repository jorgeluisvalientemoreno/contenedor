insert into open.cargos
(select 
-1, 
cargnuse, 
cargconc, 
cargcaca, 
cargsign, 
114487, 
cargvalo, 
cargdoso, 
cargcodo, 
cargusua, 
cargtipr, 
cargunid, 
trunc(sysdate), 
cargprog, 
cargcoll, 
114442, 
cargtico, 
cargvabl, 
cargtaco
from open.cargos c1 
where cargcaca = 16 
and cargpefa= 114061 
and exists ( select null 
            from open.servsusc 
            where c1.cargnuse= sesunuse )
);


select * from cargos where cargpefa= 114487
