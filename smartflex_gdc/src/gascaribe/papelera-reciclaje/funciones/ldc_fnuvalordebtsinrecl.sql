CREATE OR REPLACE function LDC_FNUVALORDEBTSINRECL(nuproducto cuencobr.cuconuse%type)
  return number is

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC.

  UNIDAD         : LDC_FNUVALORDEBTSINRECL
  DESCRIPCION    : Funci¿¿n que permitira retornar el valor corriente total sin reclamos
  AUTOR          : Luis Javier Lopez Barrios / Horbath
  FECHA          : 02/06/2016
  CASO           : OSF-299

  PARAMETROS              DESCRIPCION
  ============         ===================
   nuproducto            Codigo del servicio a procesar

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/

  cursor cutotalnoreclamo is
  SELECT nvl(sum(cucosacu),0) valor_total
  FROM cuencobr
  WHERE cuconuse = nuProducto
    AND nvl(cucosacu,0) > 0
    and nvl(cucovare,0) = 0
    and nvl(CUCOVRAP,0) = 0;

 nuSaldoPend NUMBER := 0;
begin

  Ut_Trace.TRACE('Inicio LDC_FNUVALORDEBTSINRECL', 10);
  Ut_Trace.TRACE('nuproducto[' || nuproducto || ']', 10);

  IF fblaplicaentregaxcaso('OSF-299') THEN
      open cutotalnoreclamo;
      fetch cutotalnoreclamo into nuSaldoPend;
      IF cutotalnoreclamo%NOTFOUND THEN
         nuSaldoPend := 0;
      END IF;
      close cutotalnoreclamo;
  END IF;
  Ut_Trace.TRACE('nuSaldoPend[' || nuSaldoPend || ']', 10);
  RETURN nuSaldoPend;
exception
  when others then
     return nuSaldoPend;
end LDC_FNUVALORDEBTSINRECL;
/
GRANT EXECUTE on LDC_FNUVALORDEBTSINRECL to SYSTEM_OBJ_PRIVS_ROLE;
/
