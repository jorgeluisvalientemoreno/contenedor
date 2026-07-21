select a.sesususc contrato,
       a.Sesunuse Servicio,
       a.sesuserv Tipo_Servicio,
       A.SESUCATE Categoria,
       a.sesucicl Ciclo,
       a.sesufein
  from open.SERVSUSC a
 inner join OPEN.SUSCRIPC s
    on s.susccodi = a.sesususc
 inner join OPEN.GE_SUBSCRIBER gs
    on gs.subscriber_id = s.suscclie
   --and gs.subscriber_id = 3417747
 where 1 = 1
--and a.sesususc = 67687349
--and a.Sesuserv = 7014
--AND A.SESUESFN in ('M', 'D')
