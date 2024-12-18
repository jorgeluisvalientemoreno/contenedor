CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNURETINFODATOADICORD" (inuOrder_id     OPEN.OR_ORDER.order_id%TYPE,
                                                      inutask_type_id OPEN.OR_TASK_TYPE.task_type_id%TYPE,
                                                      ivaDato         VARCHAR2
                                                     )
/*****************************************************************
Propiedad intelectual de GDO.

Unidad         : LDC_fnuRetInfoDatoAdicOrd
Descripción    : Retorna el valor del dato adicional ingresado por parametro para
                 el reporte de ruteros por contratista.
Autor          : Arquitecsoft/Millerlandy Moreno T.
Fecha          : 26-09-2013

Parametros             Descripcion
============        ===================
inuOrder_id         Codigo de la orden sobre la cual se requiere consultar el dato adicional
inutask_type_id     Codigo del tipo de trabajo de la orden sobre la cual se requiere consultar el dato adicional
ivaDato             Codigo del dato que se requiere.
                    RD: Requiere diseno
                    TF: Tipo de formulario
                    NF: Numero de formulario
                    DO: Donacion
                    TC: Tipo Contacto
                    NC: Nombre contacto
                    FT: Telefono fijo
                    CT: Telefono celular
                    EN: Energetico

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
  -- Cursor que obtiene el dato adicional Requiere diseno [REQ_DISENO] de una
  -- order por tipo de trabajo.
  -->>
  CURSOR cuReqDiseno IS
  SELECT OR_REQU_DATA_VALUE.value_1
    FROM OPEN.GE_ATTRIB_SET_ATTRIB,
        OPEN.OR_REQU_DATA_VALUE
  WHERE OR_REQU_DATA_VALUE.attribute_set_id = 10600  -- Fijo
    AND GE_ATTRIB_SET_ATTRIB.attribute_set_id = OR_REQU_DATA_VALUE.attribute_set_id
    AND GE_ATTRIB_SET_ATTRIB.ATTRIBUTE_ID = 5006000   -- Fijo
    AND OR_REQU_DATA_VALUE.TASK_TYPE_ID =  inutask_type_id -- Entrada
    AND OR_REQU_DATA_VALUE.ORDER_ID = inuOrder_id;
  --<<
  -- Cursor que obtiene el dato adicional Tipo de formulario [Tipo de Formulario] de una
  -- order por tipo de trabajo.
  -->>
  CURSOR cuTipoFormulario IS
  SELECT OR_REQU_DATA_VALUE.value_1
    FROM OPEN.GE_ATTRIB_SET_ATTRIB,
        OPEN.OR_REQU_DATA_VALUE
  WHERE OR_REQU_DATA_VALUE.attribute_set_id =  1804 -- Fijo
    AND GE_ATTRIB_SET_ATTRIB.attribute_set_id = OR_REQU_DATA_VALUE.attribute_set_id
    AND GE_ATTRIB_SET_ATTRIB.ATTRIBUTE_ID = 302112   -- Fijo
    AND OR_REQU_DATA_VALUE.TASK_TYPE_ID =  inutask_type_id -- Entrada
    AND OR_REQU_DATA_VALUE.ORDER_ID = inuOrder_id;
  --<<
  -- Cursor que obtiene el dato adicional Numero de formulario [Formulario de Venta] de una
  -- order por tipo de trabajo.
  -->>
  CURSOR cuNumeroFormulario IS
  SELECT OR_REQU_DATA_VALUE.value_2
    FROM OPEN.GE_ATTRIB_SET_ATTRIB,
        OPEN.OR_REQU_DATA_VALUE
  WHERE OR_REQU_DATA_VALUE.attribute_set_id =  1804 -- Fijo
    AND GE_ATTRIB_SET_ATTRIB.attribute_set_id = OR_REQU_DATA_VALUE.attribute_set_id
    AND GE_ATTRIB_SET_ATTRIB.ATTRIBUTE_ID = 302113   -- Fijo
    AND OR_REQU_DATA_VALUE.TASK_TYPE_ID =  inutask_type_id -- Entrada
    AND OR_REQU_DATA_VALUE.ORDER_ID = inuOrder_id;
  --<<
  -- Cursor que obtiene el dato adicional Es una donacion [ES_DONACION] de una
  -- order por tipo de trabajo.
  -->>
  CURSOR cuDonacion IS
  SELECT OR_REQU_DATA_VALUE.value_6
    FROM OPEN.GE_ATTRIB_SET_ATTRIB,
        OPEN.OR_REQU_DATA_VALUE
  WHERE OR_REQU_DATA_VALUE.attribute_set_id =  10600 -- Fijo
    AND GE_ATTRIB_SET_ATTRIB.attribute_set_id = OR_REQU_DATA_VALUE.attribute_set_id
    AND GE_ATTRIB_SET_ATTRIB.ATTRIBUTE_ID = 5006100   -- Fijo
    AND OR_REQU_DATA_VALUE.TASK_TYPE_ID =  inutask_type_id -- Entrada
    AND OR_REQU_DATA_VALUE.ORDER_ID = inuOrder_id ;
  --<<
  -- Cursor que obtiene el dato adicional Tipo de contacto [TIPO_CONTACTO] de una
  -- order por tipo de trabajo.
  -->>
  CURSOR cuTipoContacto IS
  SELECT OR_REQU_DATA_VALUE.value_7
    FROM OPEN.GE_ATTRIB_SET_ATTRIB,
        OPEN.OR_REQU_DATA_VALUE
  WHERE OR_REQU_DATA_VALUE.attribute_set_id =  10600 -- Fijo
    AND GE_ATTRIB_SET_ATTRIB.attribute_set_id = OR_REQU_DATA_VALUE.attribute_set_id
    AND GE_ATTRIB_SET_ATTRIB.ATTRIBUTE_ID = 5000139   -- Fijo
    AND OR_REQU_DATA_VALUE.TASK_TYPE_ID =  inutask_type_id -- Entrada
    AND OR_REQU_DATA_VALUE.ORDER_ID = inuOrder_id ;
  --<<
  -- Cursor que obtiene el dato adicional Nombre de contacto [NOMB_CONTAC] de una
  -- order por tipo de trabajo.
  -->>
  CURSOR cuNombreContacto IS
  SELECT OR_REQU_DATA_VALUE.value_10
    FROM OPEN.GE_ATTRIB_SET_ATTRIB,
        OPEN.OR_REQU_DATA_VALUE
  WHERE OR_REQU_DATA_VALUE.attribute_set_id =  10600 -- Fijo
    AND GE_ATTRIB_SET_ATTRIB.attribute_set_id = OR_REQU_DATA_VALUE.attribute_set_id
    AND GE_ATTRIB_SET_ATTRIB.ATTRIBUTE_ID = 5000142   -- Fijo
    AND OR_REQU_DATA_VALUE.TASK_TYPE_ID =  inutask_type_id -- Entrada
    AND OR_REQU_DATA_VALUE.ORDER_ID = inuOrder_id ;
  --<<
  -- Cursor que obtiene el dato adicional Telefono fijo de contacto [TEL_FIJ_CONTAC] de una
  -- order por tipo de trabajo.
  -->>
  CURSOR cuTelFijContacto IS
  SELECT OR_REQU_DATA_VALUE.value_11
    FROM OPEN.GE_ATTRIB_SET_ATTRIB,
        OPEN.OR_REQU_DATA_VALUE
  WHERE OR_REQU_DATA_VALUE.attribute_set_id =  10600 -- Fijo
    AND GE_ATTRIB_SET_ATTRIB.attribute_set_id = OR_REQU_DATA_VALUE.attribute_set_id
    AND GE_ATTRIB_SET_ATTRIB.ATTRIBUTE_ID = 5000143   -- Fijo
    AND OR_REQU_DATA_VALUE.TASK_TYPE_ID =  inutask_type_id -- Entrada
    AND OR_REQU_DATA_VALUE.ORDER_ID = inuOrder_id;
  --<<
  -- Cursor que obtiene el dato adicional Telefono Celular de contacto [TEL_CELU_CONTAC] de una
  -- order por tipo de trabajo.
  -->>
  CURSOR cuTelCelContacto IS
  SELECT OR_REQU_DATA_VALUE.value_12
    FROM OPEN.GE_ATTRIB_SET_ATTRIB,
        OPEN.OR_REQU_DATA_VALUE
  WHERE OR_REQU_DATA_VALUE.attribute_set_id =  10600 -- Fijo
    AND GE_ATTRIB_SET_ATTRIB.attribute_set_id = OR_REQU_DATA_VALUE.attribute_set_id
    AND GE_ATTRIB_SET_ATTRIB.ATTRIBUTE_ID = 5000144   -- Fijo
    AND OR_REQU_DATA_VALUE.TASK_TYPE_ID =  inutask_type_id -- Entrada
    AND OR_REQU_DATA_VALUE.ORDER_ID = inuOrder_id ;
  --<<
  -- Cursor que obtiene el dato adicional Energetico Actual [TIPO_ENERGITO] de una
  -- order por tipo de trabajo.
  -->>
  CURSOR cuEnergetico IS
  SELECT OR_REQU_DATA_VALUE.value_8
    FROM OPEN.GE_ATTRIB_SET_ATTRIB,
        OPEN.OR_REQU_DATA_VALUE
  WHERE OR_REQU_DATA_VALUE.attribute_set_id =  10600 -- Fijo
    AND GE_ATTRIB_SET_ATTRIB.attribute_set_id = OR_REQU_DATA_VALUE.attribute_set_id
    AND GE_ATTRIB_SET_ATTRIB.ATTRIBUTE_ID = 5000140   -- Fijo
    AND OR_REQU_DATA_VALUE.TASK_TYPE_ID =  inutask_type_id -- Entrada
    AND OR_REQU_DATA_VALUE.ORDER_ID = inuOrder_id ;

BEGIN
  --<<
  -- Valida si el dato requerido es requiere diseno.
  -->>
  IF ivaDato = 'RD' THEN
    --<<
    -- Obtiene el valor del dato
    -->>
     OPEN cuReqDiseno;
    FETCH cuReqDiseno INTO vaRetorno;
    CLOSE cuReqDiseno;
  END IF;
  --<<
  -- Valida si el dato requerido es tipo de formulario
  -->>
  IF ivaDato = 'TF' THEN
    --<<
    -- Obtiene el valor del dato
    -->>
     OPEN cuTipoFormulario;
    FETCH cuTipoFormulario INTO vaRetorno;
    CLOSE cuTipoFormulario;
  END IF;
  --<<
  -- Valida si el dato requerido es numero de formulario
  -->>
  IF ivaDato = 'NF' THEN
    --<<
    -- Obtiene el dato
    -->>
     OPEN cuNumeroFormulario;
    FETCH cuNumeroFormulario INTO vaRetorno;
    CLOSE cuNumeroFormulario;
  END IF;
  --<<
  -- Valida si el dato requerido es donacion
  -->>
  IF ivaDato = 'DO' THEN
    --<<
    -- Obtiene el dato
    -->>
     OPEN cuDonacion;
    FETCH cuDonacion INTO vaRetorno;
    CLOSE cuDonacion;
  END IF;
  --<<
  -- Valida si el dato requerido es tipo contacto
  -->>
  IF ivaDato = 'TC' THEN
    --<<
    -- Obtiene el dato
    -->>
     OPEN cuTipoContacto;
    FETCH cuTipoContacto INTO vaRetorno;
    CLOSE cuTipoContacto;
  END IF;
  --<<
  -- Valida si el dato requerido es nombre contacto
  -->>
  IF ivaDato = 'NC' THEN
    --<<
    -- Obtiene el dato
    -->>
     OPEN cuNombreContacto;
    FETCH cuNombreContacto INTO vaRetorno;
    CLOSE cuNombreContacto;
  END IF;
  --<<
  -- Valida si el dato requerido es telefono fijo
  -->>
  IF ivaDato = 'FT' THEN
    --<<
    -- Obtiene el dato
    -->>
     OPEN cuTelFijContacto;
    FETCH cuTelFijContacto INTO vaRetorno;
    CLOSE cuTelFijContacto;
  END IF;
  --<<
  -- Valida si el dato requerido es telefono celular
  -->>
  IF ivaDato = 'CT' THEN
    --<<
    -- Obtiene el dato
    -->>
     OPEN cuTelCelContacto;
    FETCH cuTelCelContacto INTO vaRetorno;
    CLOSE cuTelCelContacto;
  END IF;
  --<<
  -- Valida si el dato requerido es energetico
  -->>
  IF ivaDato = 'EN' THEN
    --<<
    -- Obtiene el dato
    -->>
     OPEN cuEnergetico;
    FETCH cuEnergetico INTO vaRetorno;
    CLOSE cuEnergetico;
  END IF;

  RETURN vaRetorno;
END LDC_fnuRetInfoDatoAdicOrd;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNURETINFODATOADICORD', 'ADM_PERSON');
END;
/