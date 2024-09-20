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
        AND cucocodi = 2921321320
        AND factcodi = cucofact
        AND cuconuse = 50572920
GROUP BY cargcuco, cucovato, cucovaab, cucosacu;
select * from open.resureca r where r.rerecupo = 133551287
