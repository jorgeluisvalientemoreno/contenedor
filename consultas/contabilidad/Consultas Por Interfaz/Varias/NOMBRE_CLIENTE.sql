select * from open.ge_subscriber s, open.servsusc c, open.suscripc p
 where c.sesunuse in (50924327,50929594,50966234,50929705,50898280,50904791,50893718,50932851,50921886,50900620,50926603,50947817)
   and c.sesususc = p.susccodi
   and p.suscclie = s.subscriber_id
