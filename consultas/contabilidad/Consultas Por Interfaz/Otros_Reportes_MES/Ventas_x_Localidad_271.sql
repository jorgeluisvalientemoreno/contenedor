-- Ventas Pijiño 
select * from 
(
SELECT  cargnuse, cargconc, concdesc, sum(decode(cargsign,'CR',-cargvalo,cargvalo)) Neto_Cargos, cargdoso, cargcaca,
        (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA
FROM    open.cargos c,  open.servsusc,  open.cuencobr,  open.factura,  open.concepto,  open.suscripc
WHERE   factfege >= to_Date('01/07/2018 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
        AND factfege <= to_Date('31/07/2018 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
        AND cucofact = factcodi
        AND cucocodi = cargcuco
        AND sesunuse = cargnuse
        and sesususc = susccodi
        AND cargfecr <= to_Date('31/07/2018 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
        AND cargcuco > 0
        AND cargtipr = 'A'
        AND cargsign in ('DB','CR')
        and cargcaca in (41,53)
        and cargconc = conccodi
        and concclco in (4,19,400)
group by cargnuse, cargconc, concdesc, cargdoso, cargcaca, susciddi
) where loca = 8232
