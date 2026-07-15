SELECT cavccodi, calivaco.cavcdesc
FROM open.caravaco, open.racavaco, open.calivaco
 WHERE rcvccrvc = crvccodi -- Join Clases con Rangos
                      AND cavccodi = rcvccavc -- Join Rangos con Calificaci?n
                      AND crvccate = 2
                      AND crvcsuca = 1
                      AND round(165.2) BETWEEN crvcraci AND
                      crvcracf
                      AND  round((68.647 - 165.2) / 165.2 * 100) BETWEEN rcvcrain AND  rcvcrafi;
                      
