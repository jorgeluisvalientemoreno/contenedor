CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FVATELSUBSCRIBER" (inusubscriber_id  GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE)
/*****************************************************************
Propiedad intelectual de GDO.

Unidad         : LDC_fvaTelSubscriber
Descripción    : Retorna los telefonos de un ge_subscriber.
Autor          : Arquitecsoft/Millerlandy Moreno T.
Fecha          : 26-09-2013

Parametros             Descripcion
============        ===================
inusubscriber_id    Codigo del cliente


Historia de Modificaciones

DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
-----------  -------------------    -------------------------------------
******************************************************************/
RETURN VARCHAR2 IS
  --<<
  -- Variables del proceso
  -->>
  vaRetorno VARCHAR2(3000) := NULL;  -- Variable de retorno
  --<<
  -- Cursor que consulta los telefonos de un ge_subscriber.
  -->>
  CURSOR cuTeleGesubscriber IS
  SELECT phone
    FROM OPEN.GE_SUBS_PHONE
   WHERE GE_SUBS_PHONE.SUBSCRIBER_ID = inusubscriber_id;


BEGIN
  --<<
  -- Obtiene los telefonos del ge_subscriber
  -->>
  FOR rgcuTeleGesubscriber IN cuTeleGesubscriber LOOP
    IF vaRetorno IS NULL THEN
      vaRetorno := rgcuTeleGesubscriber.phone;
    ELSE
      vaRetorno := vaRetorno||'/'||rgcuTeleGesubscriber.phone;
    END IF;
  END LOOP;
  RETURN vaRetorno;
END LDC_fvaTelSubscriber;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FVATELSUBSCRIBER', 'ADM_PERSON');
END;
/
