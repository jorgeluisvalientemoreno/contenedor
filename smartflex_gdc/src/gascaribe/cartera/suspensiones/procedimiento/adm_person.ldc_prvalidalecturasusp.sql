create or replace PROCEDURE adm_person.ldc_prvalidalecturasusp IS
  /**************************************************************************
  Nombre      : LDC_PRVALIDALECTURASUSP
  Autor       : Jorge Valiente
  Fecha       : 31/08/2022
  OSF         : 523
  Descripci?n : Valida la lectura legalizada en la OT de suspensi?n

  Par?metros Entrada

  Valor de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  19-04-2024   Adrianavg   OSF-2569: Se migra del esquema OPEN al esquema ADM_PERSON  
  ***************************************************************************/

  nuerrorcode    NUMBER; --se almacena codigo de error
  sberrormessage VARCHAR2(4000); --se almacena mensaje de error
  nuOrderId      NUMBER; --se almacen orden de trabajo
  nuClaseCausal  NUMBER; --clase de causal
  nuTipoTrabajo  NUMBER; --clase de causal

  nuLectura      NUMBER; --se almacena lectura de legalizacion
  dtFechaFinEj   DATE; --se almacena fecha de ejecucion
  nuProducto     NUMBER; --se almacena codigo del producto
  nuctividadSusp NUMBER; --se almacena codigo del producto

  --se valida actividad de la ordem
  CURSOR cuValidaActi IS
    SELECT oa.product_id, oa.order_activity_id
      FROM or_order_activity oa
     WHERE oa.order_id = nuOrderId
       and oa.FINAL_DATE is null
       and oa.task_type_id = nuTipoTrabajo;

  --se consulta medidor ylectura de instalacion
  CURSOR cugetLectMedi IS
    SELECT lm.leemleto
      FROM lectelme lm
     WHERE lm.leemsesu = nuProducto
       and lm.leemdocu = nuctividadSusp
       AND trunc(lm.leemfele) = trunc(dtFechaFinEj);

BEGIN

  nuOrderId     := or_bolegalizeorder.fnuGetCurrentOrder; -- Obtenemos la orden que se esta legalizando
  nuClaseCausal := dage_causal.fnugetclass_causal_id(Daor_order.fnugetCausal_id(nuOrderId,
                                                                                null),
                                                     null); --se obtiene clase de causal
  nuTipoTrabajo := Daor_order.Fnugettask_Type_Id(nuOrderId, null);

  --UT_TRACE.TRACE('nuOrderId['|| nuOrderId|| '] - nuClaseCausal['|| nuClaseCausal||']', 10);

  --se valida clase de causal de legalizacion exito
  IF nuClaseCausal = 1 THEN
    --se valida la actviidad de la orden
    OPEN cuValidaActi;
    FETCH cuValidaActi
      INTO nuProducto, nuctividadSusp;
    CLOSE cuValidaActi;

    --UT_TRACE.TRACE('nuProducto['|| nuProducto|| ']', 10);

    --si la actividad es de notificacion se valida lectura
    IF nuProducto IS NOT NULL THEN
      dtFechaFinEj := trunc(daor_order.fdtgetexecution_final_date(nuorderid));

      --UT_TRACE.TRACE('dtFechaFinEj['|| dtFechaFinEj|| ']', 10);

      OPEN cugetLectMedi;
      FETCH cugetLectMedi
        INTO nuLectura;
      CLOSE cugetLectMedi;

      --UT_TRACE.TRACE('nuLectura['|| nuLectura|| '] - nuLecturaMini[' || nuLecturaMini || ']', 10);

      IF trim(nuLectura) is null THEN
        ERRORS.SETERROR(2741,
                        'La lectura de suspensión no debe ser nula, si la causal de legalización es de tipo éxito. Digite Lectura mayor o igual a 0.');
        RAISE ex.controlled_error;
      END IF;
    END IF;
  END IF;

EXCEPTION
  WHEN ex.controlled_error THEN
    errors.geterror(nuerrorcode, sberrormessage);
    RAISE ex.controlled_error;
  WHEN OTHERS THEN
    errors.seterror;
    errors.geterror(nuerrorcode, sberrormessage);
    RAISE ex.controlled_error;
END LDC_PRVALIDALECTURASUSP;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO LDC_PRVALIDALECTURASUSP
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRVALIDALECTURASUSP', 'ADM_PERSON'); 
END;
/