CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNCRECUPAGOCICLO" (
                                                 depa NUMBER
                                                ,loca NUMBER
                                                ,cate NUMBER
                                                ,suca NUMBER
                                                ,ciclo NUMBER
                                                ,ano NUMBER
                                                ,mes NUMBER
                                                ,tipoprod number) RETURN NUMBER IS
 nuconta NUMBER DEFAULT 0;
BEGIN
  SELECT /*+INDEX (m PK_IC_MOVIMIEN)*/
       COUNT(DISTINCT(movicupo)) INTO nuconta
 FROM ic_movimien m
WHERE movicons = movicons
  AND m.movitimo = 23
  AND m.moviancb = ano
  AND m.movimecb = mes
  AND m.moviserv = tipoprod
  AND m.moviubg2 = depa
  AND m.moviubg3 = loca
  AND m.movicate = cate
  AND m.movisuca = suca
  AND m.movicicl = ciclo;
   return nuconta;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNCRECUPAGOCICLO', 'ADM_PERSON');
END;
/