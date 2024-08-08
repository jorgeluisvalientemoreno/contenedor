select ge.subscriber_id id_cliente,
       sesususc         contrato,
       sesunuse         producto,
       phone            telefono, 
       subscriber_name || ' '|| subs_last_name nombre ,
       s.susccicl       ciclo,
       s.susciddi       id_dir_cobro,
       a.address        dir_cobro,       
       ge.address       dir_cliente,
       ge.address_id    id_dir_cliente,
       prttacti         activo_tarifa_tran
from suscripc s 
left join ge_subscriber ge  on s.suscclie = ge.subscriber_id
left join ab_address a on a.address_id = s.susciddi
inner join servsusc se on s.susccodi= se.sesususc
inner join ldc_prodtatt l  on prttsesu  = sesunuse and prttacti= 'N' 
and ge.address_id  is not null 
and ge.address_id = s.susciddi
and sesuserv = 7014 
and sesucate <> 1
and rownum <=10  ; 