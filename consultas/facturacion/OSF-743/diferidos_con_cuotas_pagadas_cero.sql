select *
from factura
where factpefa = 101559 and exists (select 1 
                                    from diferido 
                                    inner join servsusc on difesusc = sesususc 
                                    where difesusc = factsusc 
                                    and difenuse = sesunuse 
                                    and sesuserv = 7053
                                    and difecupa = 0
                                    and difeprog = 'gcned')
 and factprog = 6;
