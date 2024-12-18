CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNU_APLICAENTREGA" (ISBNOMBRE_ENTREGA VARCHAR2)
RETURN NUMBER IS

/*****************************************************************
  PROPIEDAD INTELECTUAL DE CSC

  UNIDAD         : LDC_FNU_APLICAENTREGA
  DESCRIPCION    : Función para validar si la entrega aplica, retornando valor numérico.
  AUTOR          : KCienfuegos
  CA             : 200-132
  FECHA          : 14/04/2016

  PARAMETROS              DESCRIPCION
  ============         ===================
  Isbnombre_entrega     Nombre de Entrega

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
******************************************************************/
BEGIN

     ut_trace.trace('INICIA - LDC_FNU_APLICAENTREGA', 10);

     IF (fblaplicaentrega(ISBNOMBRE_ENTREGA)) THEN
        RETURN 1;
     ELSE
        RETURN 0;
     END IF;

     RETURN 0;

     ut_trace.trace('FINALIZA - LDC_FNU_APLICAENTREGA', 10);

EXCEPTION
  WHEN OTHERS THEN
     RETURN 0;

END LDC_FNU_APLICAENTREGA;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNU_APLICAENTREGA', 'ADM_PERSON');
END;
/