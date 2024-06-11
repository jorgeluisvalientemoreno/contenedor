select s.sesususc, 
       t.concdesc, 
       ca.cacadesc, 
       s.sesuesco, 
       s.sesuesfn, 
       c.cargcuco, 
       c.cargnuse, 
       c.cargconc, 
       c.cargvalo, 
       c.cargsign
from open.cargos  c
inner join open.servsusc  s on c.cargnuse = s.sesunuse
inner join open.concepto  t on c.cargconc = t.conccodi
inner join open.causcarg ca on c.cargcaca = ca.cacacodi
where s.sesunuse in (1182942,1078172,1078170,1078171)
and  c.cargfecr >= '21/07/2022'
order by c.cargfecr desc;