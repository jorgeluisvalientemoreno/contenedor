CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNURETINFOORDENRUTERO" (inuaddress_id OPEN.AB_ADDRESS.ADDRESS_ID%TYPE,ivaDato VARCHAR2)
/*****************************************************************
Propiedad intelectual de GDO.

Unidad         : LDC_fnuRetInfoOrdenRutero
Descripción    : retorna el numero de acta generado a una orden
Autor          : Arquitecsoft/Millerlandy Moreno T.
Fecha          : 09-09-2013

Parametros             Descripcion
============        ===================
inuaddress_id       Codigo de la direccion asociada a la campana
ivaDato             Dato que se requeriere obtener de la orden generada para la
                    direccion de la campana:
                    NO: Numero de orden
                    TT: Tipo de trabajo
                    FR: Fecha de registro
                    FL: Fecha de legalizacion
                    EO: Estado de la orden
                    UO: Unidad operativa
                    CO: contratista

Historia de Modificaciones

DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
-----------  -------------------    -------------------------------------
******************************************************************/
RETURN VARCHAR2   IS
  --<<
  -- Variables del proceso
  -->>
  vaRetorno           VARCHAR2(3000) := NULL;
  daregister_date     OR_ORDER_ACTIVITY.REGISTER_DATE%TYPE; -- Fecha de registro
  dalegalization_date OR_ORDER.LEGALIZATION_DATE%TYPE;      -- Fecha de legalizacion
  nuoperating_unit_id OR_ORDER.OPERATING_UNIT_ID%TYPE;
  --<<
  -- Cursor que obtiene la orden maxima para la direccion
  -->>
  CURSOR cuOrden IS
 SELECT Max(OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID) orden
   FROM OPEN.OR_ORDER_ACTIVITY
  WHERE OR_ORDER_ACTIVITY.ADDRESS_ID = inuaddress_id
    AND OR_ORDER_ACTIVITY.TASK_TYPE_ID IN (12644,12645)
    AND OR_ORDER_ACTIVITY.STATUS = 'F';
  --<<
  -- Obtiene la informacion del tipo de orden
  -->>
  CURSOR cuTipoTrabOrden(inuorder_activity_id OPEN.OR_ORDER_ACTIVITY.order_activity_id%TYPE) IS
  SELECT OR_ORDER_ACTIVITY.TASK_TYPE_ID||' - '||OPEN.daor_task_type.fsbGetdescription(task_type_id)
    FROM OPEN.OR_ORDER_ACTIVITY
   WHERE order_activity_id = inuorder_activity_id;
  --<<
  -- Obtiene la informacion de la fecha de registro de la orden
  -->>
  CURSOR cuFechaRegOrden(inuorder_activity_id OPEN.OR_ORDER_ACTIVITY.order_activity_id%TYPE) IS
  SELECT OR_ORDER_ACTIVITY.REGISTER_DATE fechaRegistro
    FROM OPEN.OR_ORDER_ACTIVITY
   WHERE order_activity_id = inuorder_activity_id;
  --<<
  -- Obtiene la informacion de la fecha de legalizacion de la orden
  -->>
  CURSOR cuFechaLegaOrden(inuorder_activity_id OPEN.OR_ORDER_ACTIVITY.order_activity_id%TYPE) IS
  SELECT OR_ORDER.LEGALIZATION_DATE FechaLegaliza
    FROM OPEN.OR_ORDER_ACTIVITY,
         OPEN.OR_ORDER
   WHERE OR_ORDER_ACTIVITY.ORDER_ID =  OR_ORDER.ORDER_ID
     AND order_activity_id = inuorder_activity_id;
  --<<
  -- Obtiene la informacion del estado de la orden
  -->>
  CURSOR cuEstadoOrden(inuorder_activity_id OPEN.OR_ORDER_ACTIVITY.order_activity_id%TYPE) IS
  SELECT OR_ORDER.ORDER_STATUS_ID||' - '||OPEN.daor_order_status.fsbGetdescription(OR_ORDER.ORDER_STATUS_ID)
    FROM OPEN.OR_ORDER_ACTIVITY,
         OPEN.OR_ORDER
   WHERE OR_ORDER_ACTIVITY.ORDER_ID =  OR_ORDER.ORDER_ID
     AND order_activity_id = inuorder_activity_id;
  --<<
  -- Obtiene la informacion de la unidad operativa de la orden
  -->>
  CURSOR cuUnidadOperativaOrden(inuorder_activity_id OPEN.OR_ORDER_ACTIVITY.order_activity_id%TYPE) IS
  SELECT OR_ORDER.OPERATING_UNIT_ID
    FROM OPEN.OR_ORDER_ACTIVITY,
         OPEN.OR_ORDER
   WHERE OR_ORDER_ACTIVITY.ORDER_ID =  OR_ORDER.ORDER_ID
     AND order_activity_id = inuorder_activity_id;
  --<<
  -- Obtiene el contratista
  -->>
  CURSOR cuContratistaOrden(inuorder_activity_id OPEN.OR_ORDER_ACTIVITY.order_activity_id%TYPE) IS
  SELECT OPEN.daor_operating_unit.fnuGetcontractor_id(OR_ORDER.OPERATING_UNIT_ID)||' - '||OPEN.dage_contratista.fsbGetnombre_contratista(OPEN.daor_operating_unit.fnuGetcontractor_id(OR_ORDER.OPERATING_UNIT_ID))
    FROM OPEN.OR_ORDER_ACTIVITY,
         OPEN.OR_ORDER
   WHERE OR_ORDER_ACTIVITY.ORDER_ID =  OR_ORDER.ORDER_ID
     AND order_activity_id = inuorder_activity_id;
BEGIN
  --<<
  -- Obtiene la ultima orden para la direccion de la campana
  -->>
  FOR rgcuOrden IN cuOrden LOOP
    --<<
    -- Numero de orden
    -->>
    IF ivaDato = 'NO' THEN
      vaRetorno := To_Char(rgcuOrden.orden);
    END IF;
    --<<
    -- Tipo de trabajo
    -->>
    IF (ivaDato = 'TT') THEN
      OPEN cuTipoTrabOrden(rgcuOrden.orden);
      FETCH cuTipoTrabOrden INTO vaRetorno;
      CLOSE cuTipoTrabOrden;
    END IF;
    --<<
    -- Fecha de registro
    -->>
    IF (ivaDato = 'FR') THEN
      OPEN cuFechaRegOrden(rgcuOrden.orden);
      FETCH cuFechaRegOrden INTO daregister_date;
      CLOSE cuFechaRegOrden;
      --<<
      -- Inicializa la variable de retorno.
      -->>
      vaRetorno := To_Char(daregister_date);
    END IF;
    --<<
    -- Fecha de legalizacion
    -->>
    IF (ivaDato = 'FL') THEN
       OPEN cuFechaLegaOrden(rgcuOrden.orden);
      FETCH cuFechaLegaOrden INTO dalegalization_date;
      CLOSE cuFechaLegaOrden;
      --<<
      -- Inicializa la variable de retorno.
      -->>
      vaRetorno := To_Char(dalegalization_date);
    END IF;
    --<<
    -- Estado de la orden
    -->>
    IF (ivaDato = 'EO') THEN
       OPEN cuEstadoOrden(rgcuOrden.orden);
      FETCH cuEstadoOrden INTO vaRetorno;
      CLOSE cuEstadoOrden;
    END IF;
    --<<
    -- Unidad operativa
    -->>
    IF ivaDato = 'UO' THEN
       OPEN cuUnidadOperativaOrden(rgcuOrden.orden);
      FETCH cuUnidadOperativaOrden INTO nuoperating_unit_id;
      CLOSE cuUnidadOperativaOrden;
      --<<
      -- Asigna el retorno a la variable de salida
      -->>
      vaRetorno := To_Number(nuoperating_unit_id);
    END IF;
    --<<
    -- Contratista
    -->>
    IF (ivaDato = 'CO') THEN
       OPEN cuContratistaOrden(rgcuOrden.orden);
      FETCH cuContratistaOrden INTO vaRetorno;
      CLOSE cuContratistaOrden;
    END IF;




  END LOOP;

  RETURN vaRetorno;
END LDC_fnuRetInfoOrdenRutero;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNURETINFOORDENRUTERO', 'ADM_PERSON');
END;
/