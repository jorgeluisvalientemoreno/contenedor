CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNURETACTAORDEN" (inuorder_id OPEN.OR_ORDER.ORDER_ID%TYPE)
/*****************************************************************
Propiedad intelectual de GDO.

Unidad         : LDC_fnuRetActaOrden
Descripción    : retorna el numero de acta generado a una orden
Autor          : Arquitecsoft/Millerlandy Moreno T.
Fecha          : 09-09-2013

Parametros             Descripcion
============        ===================
inuorder_id         Codigo de la orden sobre la cual se realizara la consulta

Historia de Modificaciones

DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
-----------  -------------------    -------------------------------------
******************************************************************/
RETURN NUMBER  IS
  --<<
  -- Variables del proceso
  -->>
  nuRetorno NUMBER := 0;
  --<<
  -- Cursor que obtiene el acta de una orden
  -->>
  CURSOR cuActa IS
  SELECT id_acta
    FROM OPEN.GE_DETALLE_ACTA GE_DETALLE_ACTA
   WHERE GE_DETALLE_ACTA.ID_ORDEN = inuorder_id
     AND ROWNUM = 1;

BEGIN
  --<<
  -- Obtiene el acta asociada a la orden
  -->>
   OPEN cuActa;
  FETCH cuActa INTO nuRetorno;
    IF cuActa%NOTFOUND THEN
      nuRetorno := 0;
    END IF;
  CLOSE cuActa;

  RETURN nuRetorno;
END LDC_fnuRetActaOrden;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNURETACTAORDEN', 'ADM_PERSON');
END;
/