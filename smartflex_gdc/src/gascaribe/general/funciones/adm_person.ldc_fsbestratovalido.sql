CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBESTRATOVALIDO" (nuEstrato  NUMBER)
RETURN VARCHAR
IS

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_fsbEstratoValido
  Descripcion    : Valida que el codigo ingresado corresponda a un estrato valido en el sistema

  Autor          : Luz Andrea Angel/OLSoftware
  Fecha          : 24/05/2013

  Parametros              Descripcion
  ============         ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/

  CURSOR cuEstrato(nuSusuca NUMBER) IS
   select count(*)
   from subcateg
   WHERE sucacate = 1
     and sucacodi = nuSusuca;


  sbValido VARCHAR2(1):='N';
  nuCantidad NUMBER;

  BEGIN
    OPEN cuEstrato(nuEstrato);
    FETCH cuEstrato
      INTO nuCantidad;
    CLOSE cuEstrato;

    IF(nuCantidad > 0) THEN
      sbValido := 'S';
    END IF;

    RETURN sbValido;
    EXCEPTION
      WHEN others THEN
        RETURN 'N';

end LDC_fsbEstratoValido;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBESTRATOVALIDO', 'ADM_PERSON');
END;
/
