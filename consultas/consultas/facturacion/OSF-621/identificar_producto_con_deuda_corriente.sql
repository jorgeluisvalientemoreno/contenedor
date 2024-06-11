select sesususc , sesunuse, sesuserv, sesuesco, sesuesfn 
from open.servsusc a
where ((Select sum(nvl(cucosacu, 0))
        from open.cuencobr, open.servsusc
        where cuconuse = sesunuse
        and sesususc = a.sesunuse
        and nvl(cucosacu, 0) > 0) +
       (select sum(nvl(difesape, 0))
           from open.diferido
           where difesusc = a.sesunuse
           and nvl(difesape, 0) = 0)) > 0
