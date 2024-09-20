-- Ingreso Ventas OSF
SELECT  sesuserv, sesucate, cargconc, o.concdesc, cargcaca, cargsign, sum(cargvalo),  
        ab_address.geograp_location_id, l.celocebe
FROM    open.cargos, open.servsusc, open.cuencobr, open.ab_address, open.ldci_centbenelocal l, open.concepto o
        /*+IC_BCCompletServiceInt.TemprInsertAccCharges*/
WHERE   cargnuse in (SELECT distinct a.product_id
                       from open.or_order_activity a, open.mo_packages m
                      where a.product_id in (SELECT distinct hcecnuse
                                               FROM open.hicaesco h
                                              WHERE hcececan = 96
                                                AND hcececac = 1
                                                AND hcecserv = 7014
                                                AND hcecfech >= '09-02-2015' and hcecfech < '01-03-2015'
                                                AND open.dapr_product.fnugetproduct_status_id (h.hcecnuse) = 1)
                         and a.package_id = m.package_id and m.package_type_id in (271, 323,/* 100271,*/ 200279))
AND     cuconuse = cargnuse
AND     cargcuco = cucocodi
and     cargconc in (30, 19, 674)
and     cargsign in ('DB', 'CR') and cargcaca = 53        
AND     cargtipr in ('A')
AND     sesunuse = cargnuse
AND     cucodiin = ab_address.address_id
AND     ab_address.geograp_location_id = l.celoloca 
AND     cargconc = conccodi
group by sesuserv, sesucate, cargconc, o.concdesc, cargcaca, cargsign, ab_address.geograp_location_id, l.celocebe
