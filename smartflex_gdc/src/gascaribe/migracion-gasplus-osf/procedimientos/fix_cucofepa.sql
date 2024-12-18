CREATE OR REPLACE PROCEDURE FIX_CUCOFEPA IS
CURSOR CUENTAS IS SELECT CC.CUCOCODI
FROM open.cuencobr cc
WHERE cc.cucosacu IS null
  AND cc.cucofepa IS null
  and cc.cucofeve >=add_months(sysdate,-6)
  and exists (select null from open.cargos ca where
ca.cargcuco=cc.cucocodi and ca.cargsign='PA');
F DATE;
BEGIN
     FOR C IN CUENTAS LOOP
         SELECT MAX(CARGFECR) INTO F
                FROM CARGOS
                WHERE CARGCUCO=C.CUCOCODI AND
                      CARGSIGN='PA';
         UPDATE CUENCOBR SET CUCOFEPA=F WHERE CUCOCODI=C.CUCOCODI;
     END LOOP;
END;
/
