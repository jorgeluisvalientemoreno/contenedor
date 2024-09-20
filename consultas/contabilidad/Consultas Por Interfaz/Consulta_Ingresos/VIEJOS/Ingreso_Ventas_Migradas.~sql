-- Ingreso Ventas Migradas
SELECT  /*+
            index (cargos, IX_CARGOS02)
            index (cuencobr, PK_CUENCOBR)
            index (ab_address, PK_AB_ADDRESS)
            index (servsusc, PK_SERVSUSC)
        */
        sesucate, /*sesusuca,*/ invmconc, o.concdesc, 'DB', sum(invmvain), /*ab_address.geograp_location_id,*/ l.celocebe  
from open.Ldci_Ingrevemi m, open.servsusc s, open.ab_address, open.suscripc, open.ge_subscriber g,
     open.ldci_centbenelocal l, open.concepto o
where m.invmsesu in (SELECT distinct hcecnuse
                       FROM open.hicaesco h
                      WHERE hcececan = 96
                        AND hcececac = 1
                        AND hcecserv = 7014
                        AND hcecfech >= '09-02-2015' and hcecfech < '01-03-2015'
                        AND open.dapr_product.fnugetproduct_status_id (h.hcecnuse) = 1)
AND m.invmsesu = s.sesunuse
AND sesususc = susccodi
AND suscclie = g.subscriber_id
AND g.address_id = ab_address.address_id
AND ab_address.geograp_location_id = l.celoloca AND invmconc = conccodi
group by sesucate,/* sesusuca,*/ invmconc, o.concdesc, 'DB', /*ab_address.geograp_location_id,*/ l.celocebe
