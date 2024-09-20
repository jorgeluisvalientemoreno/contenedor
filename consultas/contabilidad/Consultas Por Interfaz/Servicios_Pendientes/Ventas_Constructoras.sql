-- Ventas Constructoras
SELECT  cargnuse, cargconc, concdesc, sum(decode(cargsign,'CR',-cargvalo,cargvalo)) Neto_Cargos, cargdoso, cargunid, cargcaca
FROM    open.cargos c,
        open.servsusc,
        open.cuencobr,
        open.factura,
        open.concepto
WHERE   factfege >= to_Date('01/10/2022 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
        AND factfege <= to_Date('31/10/2022 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
        AND cucofact = factcodi
        AND cucocodi = cargcuco
        AND sesunuse = cargnuse
        And sesuserv = 6121
        AND cargfecr <= to_Date('31/10/2022 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
        AND cargcuco > 0
        AND cargtipr = 'A'
        AND cargsign in ('DB','CR')
        and cargcaca in (41,53,15)
        and cargconc = conccodi
        and concclco in (4,19,400)
group by cargnuse, cargconc, concdesc, cargdoso, cargunid, cargcaca
