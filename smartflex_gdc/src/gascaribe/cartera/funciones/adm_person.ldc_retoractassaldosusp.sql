CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_RETORACTASSALDOSUSP" (nuproducto NUMBER) RETURN NUMBER IS
/**************************************************************
  Propiedad intelectual PETI.

  Trigger  :  ldc_retoractassaldosusp

  Descripción  : Obtiene cuentas con saldo de un producto para suspensión

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 04-07-2013

  Historia de Modificaciones
  **************************************************************/
 CURSOR cuctassaldosusp(nucprod NUMBER) IS
  SELECT cucovato-cucovaab-cucovare saldo,trunc(c.cucofeve) feve
    FROM cuencobr c
   WHERE c.cuconuse = nucprod
     AND c.cucosacu > 0;
 nuconta NUMBER DEFAULT 0;
BEGIN
 nuconta := 0;
 FOR i IN cuctassaldosusp(nuproducto) LOOP
  IF i.feve < trunc(SYSDATE) THEN
   IF i.saldo > 0 THEN
    nuconta := nuconta + 1;
   END IF;
  END IF;
 END LOOP;
 RETURN nuconta;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_RETORACTASSALDOSUSP', 'ADM_PERSON');
END;
/
