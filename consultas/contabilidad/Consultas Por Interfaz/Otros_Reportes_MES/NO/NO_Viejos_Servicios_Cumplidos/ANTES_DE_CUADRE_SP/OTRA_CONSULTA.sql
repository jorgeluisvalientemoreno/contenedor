select ss.sesuesfn, u.* 
  from (
        select * from open.hicaesco h
         where h.hcecfech < '01-08-2015'
           and h.hcececac = 96
           and h.hcececan = 1
           and h.hcecserv = 7014
           and h.hcecnuse not in (select hi.hcecnuse from open.hicaesco hi
                                   where hi.hcecfech < '01-08-2015' 
                                     and hi.hcececac = 1
                                     and hi.hcececan = 96
                                     and hi.hcecnuse = h.hcecnuse)
       ) u, open.servsusc ss
 where u.hcecnuse not in (select hi.hcecnuse from open.hicaesco hi
                           where hi.hcecfech <  '01-08-2015' 
                             and hi.hcececac in (5,94,95,110)
                             and hi.hcecnuse =  u.hcecnuse)
   and u.hcecnuse = ss.sesunuse
   and ss.sesuesfn not in ('C')
