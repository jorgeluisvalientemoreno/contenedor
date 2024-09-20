-- Facturación por Concepto
SELECT  'Facturacion x Concepto' timo,
        sesuserv K_serv, (select s.servdesc from open.servicio s where s.servcodi = sesuserv) L_desc_serv,
        cargcaca, (select g.cacadesc from open.causcarg g where g.cacacodi = cargcaca) desc_caca, 
        sum(decode(cargsign,'DB',cargvalo)) Debito, sum(decode(cargsign,'CR',cargvalo)) Credito,
        sum(decode(cargsign,'DB',cargvalo,-cargvalo)) Neto
FROM    open.cargos, open.servsusc, open.cuencobr, open.factura, OPEN.CONCEPTO O
WHERE   factfege >= to_Date('01/02/2016 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
        AND factfege <= to_Date('29/02/2016 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
        AND cucofact =  factcodi
        AND cucocodi =  cargcuco
        AND sesunuse =  cargnuse
        AND sesuserv != 7056
        AND cargfecr <= to_Date('29/02/2016 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
        AND cargcuco >  0
        AND cargtipr =  'A'
        AND cargsign in ('DB','CR')
        AND cargconc =  conccodi
        AND concclco =  27
        --AND cargdoso like 'ID%'
GROUP BY sesuserv, cargcaca
UNION ALL
SELECT  'Notas por concepto' J_desc_timo,
        sesuserv K_serv, (select s.servdesc from open.servicio s where s.servcodi = sesuserv) L_desc_serv,
        cargcaca, (select g.cacadesc from open.causcarg g where g.cacacodi = cargcaca) desc_caca, 
        sum(decode(cargsign,'DB',cargvalo)) Debito, sum(decode(cargsign,'CR',cargvalo)) Credito,
        sum(decode(cargsign,'DB',cargvalo,-cargvalo)) Neto
FROM    open.cargos, open.servsusc, OPEN.CONCEPTO O
WHERE   cargfecr >= to_Date('01/02/2016 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
        AND cargfecr <= to_Date('29/02/2016 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
        AND sesunuse =  cargnuse
        AND sesuserv != 7056
        AND cargcuco >  0
        AND cargtipr =  'P'
        AND cargsign in ('DB','CR')
        AND cargconc =  conccodi
        AND concclco =  27
group by sesuserv, cargcaca
