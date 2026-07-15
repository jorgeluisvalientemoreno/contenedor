
--Hallar id tarifa
    SELECT MAX(ralilisr) nuLimite, MAX(raliidre) nuTari, MAX(ralicodo) nuConsec , MAX(cargnuse) nuSesu
    FROM cargos, cuencobr, rangliqu, servsusc
     WHERE cargcuco = cucocodi
       AND cargdoso LIKE 'CO-%TC-%'
       AND cargdoso NOT LIKE 'CO-PR%TC-%'
      -AND cargconc = 31
       AND raliconc = cargconc
       AND cuconuse = ralisesu
       AND cargcodo = ralicodo
       AND ralisesu = sesunuse
       AND sesususc = 66276422;
  
  -- Hallar cantidad de rangos
 
   SELECT 7 - COUNT(1) AS nuBlankRanks
     FROM ta_rangvitc
    WHERE ravtvitc = 117845;

  -- Hallar el limite superior de la tarifa

   SELECT MAX(ravtlisu) AS  nuLimiSuperior
     FROM ta_rangvitc
    WHERE ravtvitc = 117845; --- nulimisuperior = 99999999 quemarlo abajo 
  
--- Rangos tarifarios 
   SELECT lim_inferior lim_inferior
         ,decode(lim_superior, 999999999, 'MAS', lim_superior) lim_superior
         ,valor_unidad valor_unidad
         ,consumo consumo
         ,to_char(val_consumo, 'FM999,999,999,990.00') val_consumo
     FROM (
           SELECT rango_tarifas.lim_inferior
                 ,rango_tarifas.lim_superior
                 ,nvl(rango_liquidado.valor_unidad, 0) valor_unidad
                 ,nvl(rango_liquidado.consumo, 0) consumo
                 ,nvl(rango_liquidado.val_consumo, 0) val_consumo
             FROM (
                   SELECT ravtliin lim_inferior
                         ,ravtlisu lim_superior
                         ,0        valor_unidad
                         ,0        consumo
                         ,0        val_consumo
                     FROM open.ta_rangvitc
                    WHERE ravtvitc = 117845) rango_tarifas
                   ,(
                     SELECT raliliir lim_inferior
                           ,ralilisr lim_superior
                           ,ralivalo valor_unidad
                           ,raliunli consumo
                           ,ralivaul val_consumo
                       FROM open.rangliqu
                      WHERE ralicodo = 7984492876
                        AND ralisesu = 6630438
                        AND raliconc = 31
                     ) rango_liquidado
                WHERE rango_tarifas.lim_inferior = rango_liquidado.lim_inferior(+)
                  AND rownum <= 7
                  AND rango_tarifas.lim_superior = rango_liquidado.lim_superior(+)
          )
  UNION ALL
   SELECT NULL lim_inferior
         ,NULL lim_superior
         ,NULL valor_unidad
         ,NULL consumo
         ,NULL val_consumo
     FROM servsusc
    WHERE rownum <= 5;
 



