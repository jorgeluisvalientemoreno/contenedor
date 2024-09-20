select *
  from (
        select cargnuse, s.subscriber_name|| ' ' || s.subs_last_name nombre, 
               sesucate, cargfecr, sum(cargvalo-aplicado) saldo, procdesc
          from (
                select cargnuse, cargconc, cargsign, trunc(cargfecr) cargfecr, cargvalo, cargprog,  
                       nvl((select sum(cargvalo) from open.cargos g
                             where c.cargnuse = g.cargnuse and g.cargsign in ('AS','DV') 
                               and c.cargvalo = g.cargvalo
                               and cargfecr < '10-08-2015'),0) aplicado
                  from open.cargos c 
                 where cargconc = 301
                   and cargsign = 'SA'
                   and cargfecr < '10-08-2015'
               ), open.servsusc c, open.ge_subscriber s, open.suscripc p, open.procesos pr
         where cargnuse = c.sesunuse
           and c.sesususc = p.susccodi
           and p.suscclie = s.subscriber_id
           and cargprog = pr.proccons
        group by cargnuse, subscriber_name|| ' ' || subs_last_name, cargconc, cargsign, cargfecr, cargprog, procdesc, sesucate
       )
 where saldo != 0       
