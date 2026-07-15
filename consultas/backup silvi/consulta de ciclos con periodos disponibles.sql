SELECT  p1.pefacodi,
        p1.pefacicl,
        p1.pefafimo,
        p1.pefaffmo,
        (
            SELECT COUNT(DISTINCT s.sesususc)
            FROM servsusc s
            WHERE s.sesucicl = p1.pefacicl
        ) AS cant_usuario
FROM perifact p1
INNER JOIN ciclo_facturacion cf
        ON cf.ciclo = p1.pefacicl
       AND cf.empresa = 'GDGU'
WHERE p1.pefaano = 2026
  AND p1.pefames = 1

  AND NOT EXISTS (
        SELECT 1
        FROM cargos c
        WHERE c.cargpefa = p1.pefacodi
          AND c.cargcaca IN (15, 51)
  )

  AND EXISTS (
        SELECT 1
        FROM perifact p_ant
        INNER JOIN cargos c_ant
                ON c_ant.cargpefa = p_ant.pefacodi
        WHERE p_ant.pefacicl = p1.pefacicl
          AND (
                (p1.pefames > 1
                 AND p_ant.pefaano = p1.pefaano
                 AND p_ant.pefames = p1.pefames - 1)
               OR
                (p1.pefames = 1
                 AND p_ant.pefaano = p1.pefaano - 1
                 AND p_ant.pefames = 12)
              )
  );
