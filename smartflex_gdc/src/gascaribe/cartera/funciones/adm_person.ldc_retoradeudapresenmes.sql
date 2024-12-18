CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_RETORADEUDAPRESENMES" (nuproducto NUMBER) RETURN NUMBER IS
/**************************************************************
  Propiedad intelectual PETI.

  Trigger  :  ldc_retoradeudapresenmes

  Descripción  : Obtiene deuda por producto a presente mes

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 06-07-2013

  Historia de Modificaciones
  **************************************************************/
 CURSOR cuctassaldopresmes(nucprod NUMBER) IS
  SELECT NVL(SUM(cucosacu),0) saldo_presente
    FROM cuencobr c
   WHERE c.cuconuse = nucprod
     AND c.cucosacu > 0
     AND cucofeve >= trunc(sysdate);
 nuconta cuencobr.cucovato%TYPE;
BEGIN
 nuconta := 0;
 FOR i IN cuctassaldopresmes(nuproducto) LOOP
    nuconta := i.saldo_presente;
 END LOOP;
 RETURN nuconta;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_RETORADEUDAPRESENMES', 'ADM_PERSON');
END;
/
