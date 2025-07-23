--consultar_contratos_por_ciclos
select *
  from (
        select sesucicl,
               count(distinct s.sesususc) as total_contratos
          from servsusc s
          join confesco c on c.coeccodi = s.sesuesco
           and c.coecserv = s.sesuserv
           and c.coecfact = 'S'
         group by sesucicl
        having count(distinct s.sesususc) > 50
           and count(distinct s.sesususc) < 100
         order by total_contratos 
       )
 where rownum <= 10;




