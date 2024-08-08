select ge.subscriber_id "Id_cliente",
       sesususc         "Contrato",
       sesunuse         "Producto",
        phone            "Telefono",
       initcap (subscriber_name ) || ' '|| initcap (subs_last_name) "Nombre" ,
       s.susccicl        "Ciclo",
       a.address        "Dir_cobro",
       prttacti         "Flag_tarifa_tran",
      (select sum(decode(t.dpttsign, 'DB', -t.dpttvano, t.dpttvano)) 
       from open.ldc_deprtatt t
       where t.dpttconc = 130 
       and t.dpttcont= se.sesususc and t.dpttsesu= sesunuse) as "Valor Nota"
from open.suscripc s
left join open.ge_subscriber ge  on s.suscclie = ge.subscriber_id
left join open.ab_address a on a.address_id = s.susciddi
left join open.servsusc se on s.susccodi= se.sesususc
inner join open.ldc_prodtatt l  on prttsesu  = sesunuse and prttacti= 'S'
where sesuserv = 7014
and (select sum(decode(t2.dpttsign, 'DB', -t2.dpttvano, t2.dpttvano)) 
       from open.ldc_deprtatt t2
       where t2.dpttconc = 130 
       and t2.dpttcont= se.sesususc and t2.dpttsesu= se.sesunuse) < 0 
and exists ( select null 
                 from procejec e 
                 where e.prejcope= (select pf.pefacodi from perifact pf where pf.pefacicl=  s.susccicl and pf.pefames= 02 and pf.pefaano=2023)
                 and e.prejprog LIKE '%FGCC%'
                 and  prejespr = 'T')
and NOT exists ( select null 
                 from procejec e2 
                 where e2.prejcope= (select pf.pefacodi from perifact pf where pf.pefacicl=  s.susccicl and pf.pefames= 03 and pf.pefaano=2023)
                 and e2.prejprog LIKE '%FCRI%'
                 and  e2.prejespr = 'T')
group by ge.subscriber_id ,sesususc,sesunuse,phone,s.susccicl,a.address,subscriber_name,subs_last_name,prttacti 
