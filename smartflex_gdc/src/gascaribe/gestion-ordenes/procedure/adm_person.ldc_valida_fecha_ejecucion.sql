CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_VALIDA_FECHA_EJECUCION
   IS
   /******************************************************************
   Propiedad intelectual de PETI.

   Unidad         : LDC_VALIDA_FECHA_EJECUCION
   Descripcion    : Caso 100 - 8785 Solicitud reconexion detenida
                    Valida que la fecha de ejecuci?n inicial y final que digita
                    el usuario no puede ser menor a la fecha de creaci?n de la orden

   Autor          : Nivis Luz Carrasquilla Zu?iga.
   Fecha          : 12/02/2016

   Parametros              Descripcion
   ============         ===================


   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================
   02/05/2024       PACOSTA            OSF-2638: Se crea el objeto en el esquema adm_person  
   ******************************************************************/


     nuOrderId               or_order.order_id%type;
     dtCreacionOT            or_order.Created_Date%type;
     dtEjecucionInicial      or_order.Exec_Initial_Date%type;
     dtEjecucionFinal        or_order.Execution_Final_Date%type;
  begin

    ut_trace.trace('Inicio LDC_VALIDA_FECHA_EJECUCION', 10);

    -- Obtener orden de la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('nuOrderId => '||nuOrderId, 10);

    -- Obtener fecha de creaci?n de la orden de la instancia
    dtCreacionOT := daor_order.fdtGetCreated_Date(nuOrderId);
    ut_trace.trace('dtCreacionOT => '||dtCreacionOT, 10);

    -- Obtener fecha de ejecuci?n inicial
    dtEjecucionInicial := daor_order.fdtGetExec_Initial_Date(nuOrderId);
    ut_trace.trace('dtEjecucionInicial => '||dtEjecucionInicial, 10);

    -- Obtener fecha de ejecuci?n final
    dtEjecucionFinal := daor_order.fdtGetExecution_Final_Date(nuOrderId);
    ut_trace.trace('dtEjecucionFinal =>'||dtEjecucionFinal, 10);

    -- Valide que la fecha de ejecuci?n inicial y final que digita el usuario no puede ser menor a la fecha de creaci?n de la orden
    if dtEjecucionInicial < dtCreacionOT then
      ut_trace.trace('dtEjecucionFinal < dtCreacionOT =>'||dtEjecucionInicial||', '||dtCreacionOT, 10);
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                   'La fecha de Ejecución Inicial dbe ser mayor a la fecha de Creación de la OT --> ('||to_char(dtCreacionOT,'dd-mm-yyyy hh24:mi:ss') ||')');

      raise ex.CONTROLLED_ERROR;
    /*else
        if dtEjecucionFinal < dtCreacionOT then
        ut_trace.trace('dtEjecucionFinal < dtCreacionOT =>'||dtEjecucionFinal||', '||dtCreacionOT, 10);
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                     'La fecha de Ejecución Final dbe ser mayor a la fecha de Creación de la OT --> ('||to_char(dtCreacionOT,'dd-mm-yyyy hh24:mi:ss') ||')');
          raise ex.CONTROLLED_ERROR;
      end if;*/
    end if;
    ut_trace.trace('Fin LDC_VALIDA_FECHA_EJECUCION', 10);

  exception
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;

  end LDC_VALIDA_FECHA_EJECUCION;
/
PROMPT Otorgando permisos de ejecucion a LDC_VALIDA_FECHA_EJECUCION
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_VALIDA_FECHA_EJECUCION', 'ADM_PERSON');
END;
/