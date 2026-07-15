SELECT NVL(SUM(NVL(CONSUMO,0)),0) CONSUMO
FROM (
      SELECT sum(decode(cargsign, 'DB', cargvalo, -cargvalo)) CONSUMO
      FROM cargos, cuencobr
      WHERE cucofact = 3000009143--poner factura 
         AND cargcuco = cucocodi
         AND cargconc in (31, 196)
         AND cargcaca = 15
         AND cargprog = 5
         AND cargdoso NOT LIKE '%-PR%'
      UNION ALL
      SELECT sum(decode(cargsign, 'DB', cargvalo, -cargvalo))
      FROM cargos, cuencobr
      WHERE cucofact =3000009143--poner factura 
         AND cargcuco = cucocodi
         AND cargconc in (130, 167)
         AND cargpefa = 102790
         AND cargpeco = ( SELECT MAX(c1.cargpeco)
                          FROM cargos c1
                          WHERE c1.cargconc = 31
                           AND c1.cargcuco = cucocodi
                           AND C1.cargcaca = 15
                           AND C1.cargprog = 5
                           AND C1.cargdoso NOT LIKE '%-PR%') );
