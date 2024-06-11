-- Validaci�n_Cargos
-- Validaci�n_Cargos
select c.cargcuco,
       c.cargnuse,
       c.cargconc,
       c.cargcaca,
       dc.cacadesc,
       c.cargsign,
       c.cargpefa,
       c.cargpeco,
       pc.pecsfeci,
       add_months('27/11/2023',-3) calculada,
       c.cargvalo,
       c.cargdoso,
       c.cargcodo,
       c.cargusua,
       c.cargtipr,
       c.cargunid,
       c.cargfecr,
       c.cargprog,
       c.cargcoll,
       c.cargtico,
       c.cargvabl,
       c.cargtaco
from cargos  c
inner join causcarg dc on dc.cacacodi = c.cargcaca
inner join pericose pc on pc.pecscons = c.cargpeco
inner join pericose pc on pc.pecscons = c.cargpeco
where c.cargconc = 31
and   c.cargnuse in (6588877)  
and   c.cargcaca  in (1,4,15,60)
and   c.cargpeco > 101938 
and  pc.pecsfeci >=  add_months('27/11/2023',-3) -- fecha_calculada   -- '25/03/2023' fecha Suspensi�n 
order by c.cargnuse, c.cargfecr desc



  --fac  106386, 103970

--and  c.cargfecr >=  add_months('27/11/2023',-3) -- fecha_persca
