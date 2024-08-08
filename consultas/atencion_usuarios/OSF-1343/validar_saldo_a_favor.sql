-- Validar Saldo a favor x producto
select s.sesunuse,
       s.sesususc,
       s.sesusafa
from servsusc  s
where s.sesunuse = 50101060;


select *
from open.saldfavo sf
where sf.safasesu = 50101060
order by  safafecr desc ;

select *
from open.movisafa ms
where ms.mosfsesu = 50101060
and mosffecr >= '27/11/2023';

select ss.susccodi,
      ss.suscsafa 
from open.suscripc  ss
where ss.susccodi = 48085611
