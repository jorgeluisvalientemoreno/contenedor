--Estado de Corte y Estado Financiero
select s.sesuesco , s.sesuesfn, s.sesunuse , s.sesususc
from servsusc s
where s.sesususc =67033146 and s.sesunuse =52074048
for update
 

--- Tener valor  de consumo
Select   c.cargnuse,  c.cargconc,c.cargvalo, c.cargcaca, c.cargsign, c.cargcuco,c.cargpefa,    
 c.cargunid, c.cargfecr
From cargos  c
Where  c.cargnuse=52074048
and   c.cargpefa = 99979
and c.cargconc = 31
and   c.cargvalo > 0



