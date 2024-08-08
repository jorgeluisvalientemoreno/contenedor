--diferido_pendiente
Select sesunuse, sesususc, sesuserv , sesucicl, (sum(difesape)) "saldo_pend "
from servsusc 
left join diferido  on difenuse = sesunuse  
where  sesucicl = 601 and difesape >0 
and not exists (select null 
                from cuencobr br
                where br.cuconuse =sesunuse
                and cucovare >0) 
and not exists (select null 
                from cuencobr br1
                where br1.cuconuse =sesunuse
                and br1.cucovrap >0) 
 group by sesunuse, sesususc, sesuserv , sesucicl
 order by sesususc 


