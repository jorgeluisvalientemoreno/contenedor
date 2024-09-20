SELECT  *
FROM    (
        SELECT  cargcuco,
                cucovato,
                cucovaab,
                nvl(cucosacu,0) cucosacu,
                nvl(sum(decode( cargsign,
                            'DB',cargvalo,
                            'CR',-cargvalo
                           )),0) vato,
                nvl(sum(decode(cargsign,
                            'PA',cargvalo,
                            'AS',cargvalo,
                            'NS',cargvalo,
                            'SA',-cargvalo,
                            'AP',-cargvalo
                           )),0) vaab
        FROM    open.cargos, open.cuencobr, open.factura
        WHERE   cargcuco = cucocodi
                AND cucocodi = 2923131196
                AND factcodi = cucofact
                AND cuconuse = 2087867
        GROUP BY cargcuco, cucovato, cucovaab, cucosacu
        )
 WHERE  cucovato <> vato  OR  cucovaab <> vaab
