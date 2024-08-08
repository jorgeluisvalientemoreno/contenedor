select cargcuco,
       cargnuse,
       cargconc,
       concdesc,
       cargcaca,
       cacadesc,
       cargsign,
       signdesc,
       cargvalo,
       cargdoso,
       cargcodo,
       cargtipr,
       cargfecr,
       cargprog
from cargos c
inner join signo s on signcodi = cargsign
inner join causcarg g on g.cacacodi = c.cargcaca
inner join concepto  c on cargconc = conccodi
where cargnuse = 6502076
order by cargfecr desc;