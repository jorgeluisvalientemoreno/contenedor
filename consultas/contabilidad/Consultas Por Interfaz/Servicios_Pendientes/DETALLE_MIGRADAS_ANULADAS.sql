-- MIGRADAS ANULADAS
SELECT M.INVMSESU, s.sesucate, M.INVMCONC, M.INVMVAIN, invmconc, o.concdesc, l.celocebe   
  from open.ldci_ingrevemi m, open.servsusc s, open.ab_address, open.suscripc, open.ge_subscriber g,
       open.ldci_centbenelocal l, open.concepto o
 where m.invmsesu in (SELECT distinct hcecnuse FROM open.hicaesco h
                       WHERE hcececac in (/*5,95,*/110)
                         AND hcecserv = 7014
                         AND hcecfech >= '09-02-2015' and hcecfech < '01-11-2015')
   AND M.INVMSESU = s.sesunuse
   AND sesususc = susccodi
   AND suscclie = g.subscriber_id
   AND g.address_id = ab_address.address_id
   AND ab_address.geograp_location_id = l.celoloca AND invmconc = conccodi
