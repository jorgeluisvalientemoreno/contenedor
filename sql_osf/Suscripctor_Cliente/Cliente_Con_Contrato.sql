---cliento x contrato 
select s.susccodi  Contrato,
       ss.sesunuse Producto,
       s.susccicl  Ciclo_Contrato,
       ss.sesucicl Ciclo_Servicio,
       a.*,
       b.*
  from open.GE_SUBSCRIBER gs
 inner join open.suscripc s
    on gs.subscriber_id = s.suscclie
 inner join open.servsusc ss
    on ss.sesususc = s.susccodi
   and ss.sesuserv = 7014
  left join OPEN.GE_SUBS_PHONE a
    on a.subscriber_id = gs.subscriber_id
  left join OPEN.GE_SUBS_GENERAL_DATA b
    on b.subscriber_id = gs.subscriber_id
 where 1 = 1
   and gs.identification = '9013940062' --'1049536781'
