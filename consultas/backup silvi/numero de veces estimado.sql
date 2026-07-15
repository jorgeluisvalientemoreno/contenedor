SELECT cossnvec
FROM conssesu c
WHERE cosssesu IN (inuproducto)
AND cossmecc = 3
AND cosspecs IN (SELECT MAX(cosspecs)
                 FROM conssesu c1, perifact pf
                 WHERE C1.cosssesu= c.cosssesu
                 AND c1.cosspefa = pf.pefacodi
                 AND NOT (pf.pefames = to_char(SYSDATE, 'mm') AND
                          pf.pefaano = to_char(SYSDATE, 'yyyy')));
                          
                          
                          
SELECT distinct  cosssesu
FROM conssesu c
WHERE cossmecc = 3 and cossnvec = 23
