/*-- se consulta lectura actual y lectura anterior de facturacion
        CURSOR cuConsuLectfact(dtFechaLect date)
        IS --200-2611*/
          SELECT leemleto lectactu, leemlean lectant, leemfele fecha
          FROM open.lectelme
          WHERE leemsesu = 51507084
            AND leemtcon = 1
            AND leemclec = 'F'
        --and lectelme.leemfele>='18/02/2023' --200-2611
            AND lectelme.leemfele IN
               (SELECT MAX(lectelme.leemfele)
                  FROM open.lectelme
                 WHERE leemsesu = 51507084
                   AND leemclec = 'F')
            --AND (lectelme.leemoble =-1 OR leemoble IS NULL)
            AND leemleto > 0;
