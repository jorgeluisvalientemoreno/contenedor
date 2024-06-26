select gs.subscriber_id Cliente,
       gs.address_id    CodigoDireccion,
       s.susccodi       Contrato,
       pp.address_id    DireccionProducto
  from open.ge_subscriber gs
  left join open.suscripc s
    on s.suscclie = gs.subscriber_id
  left join open.pr_product pp
    on pp.subscription_id = s.susccodi
 where (select count(1)
          from open.ab_address aa
         where aa.address_id = gs.address_id) = 0
   and gs.address_id is not null
 order by contrato desc;
