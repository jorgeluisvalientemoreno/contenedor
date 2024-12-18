create or replace FUNCTION  "ADM_PERSON".LDC_FNAPLICAENTREGAXCASO (ISBNOMBRE_ENTREGA VARCHAR2)
RETURN NUMBER IS

/*****************************************************************
  PROPIEDAD INTELECTUAL DE CSC

  UNIDAD         : LDC_FNAPLICAENTREGAXCASO
  DESCRIPCION    : Función para validar si la entrega aplica, retornando valor numérico.
  AUTOR          : JBRITO
  CA             : 200-2022
  FECHA          : 22/02/2019

  PARAMETROS              DESCRIPCION
  ============         ===================
  Isbnombre_entrega     Nombre de Entrega

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
******************************************************************/
BEGIN

     ut_trace.trace('INICIA - LDC_FNAPLICAENTREGAXCASO', 10);

     IF (FBLAPLICAENTREGAXCASO(ISBNOMBRE_ENTREGA)) THEN
        RETURN 1;
     ELSE
        RETURN 0;
     END IF;

     RETURN 0;

     ut_trace.trace('FINALIZA - LDC_FNAPLICAENTREGAXCASO', 10);

EXCEPTION
  WHEN OTHERS THEN
     RETURN 0;

END LDC_FNAPLICAENTREGAXCASO;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNAPLICAENTREGAXCASO', 'ADM_PERSON');
END;
/