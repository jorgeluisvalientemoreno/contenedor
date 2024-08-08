-- Cargos 
select s.sesunuse, s.sesususc, s.sesuesco, sesuesfn, c.cargcuco,  c.cargfecr
from cargos  c
left join servsusc  s  on s.sesunuse = c.cargnuse
where sesunuse in (50897492)
and   c.cargvalo > 0
and   c.cargfecr in (select max(c1.cargfecr) from cargos c1 where c1.cargnuse = s.sesunuse )
group by s.sesunuse, s.sesususc, s.sesuesco, sesuesfn, c.cargcuco,  c.cargfecr
order by s.sesunuse, c.cargfecr desc

--
/*and   s.sesuesco in (1,3)
and   s.sesuesfn in ('C')*/
--and   c.cargnuse = 1000034
