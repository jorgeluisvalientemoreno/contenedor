SELECT trunc(cargfecr), NVL(sum(NVL(cargvalo, 0)), 0) VALOR
            FROM cargos CI
            WHERE CI.cargnuse = 50664187
            AND trunc(CI.cargfecr) BETWEEN '01/07/2024' AND '31/07/2024'
            AND CI.cargsign = 'PA'
            GROUP BY trunc(cargfecr)
            ORDER BY trunc(cargfecr) asc
