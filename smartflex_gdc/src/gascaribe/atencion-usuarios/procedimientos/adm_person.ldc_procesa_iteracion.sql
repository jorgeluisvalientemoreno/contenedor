CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PROCESA_ITERACION IS
    /***********************************************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: LDC_PROCESA_ITERACION
    Descripci?n:        Permite actualizar la informaci?n del medio de recepci?n y la direcci?n
                        de respuesta para la petici?n. Una vez ejecutado este proceso, se anular?
                        el flujo actual de interacci?n junto con sus ?rdenes y despu?s se crear?
                        un nuevo flujo de interacci?n, de esta forma, el nuevo flujo tomar? el
                        camino adecuado seg?n la informaci?n reci?n editada.
                        Este proceso s?lo debe permitir ejecutarse si la interacci?n a?n se
                        encuentra registrada.
                        La solicitud de interacci?n no cambiar?, lo que suceder? es que se anular?
                        su flujo actual y se crear? un nuevo flujo, pero siempre conservando el
                        mismo c?digo de solicitud de interacci?n.

    Autor    : Sandra Mu?oz
    Fecha    : 02-07-2016 cA200-83

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    02-07-2016   Sandra Mu?oz           Creaci?n
    07-12-2018    ELAL - 200-2314       se coloca validacion para cuando no se encuentre instancia de espera ordenes hija genere error.
                                        se adiciono cursor para consultar por los nuevos parametros (LDC_TIPOUNIDAD, LDC_CODACCION) la instancia de ordenes hijas
    04/03/2020   HORBATH                CASO 335: Reestablecer logica existente del CASO 86. Cambio de medio de recpecion de solciitudes
                                                  asociadas a la solcucitud de interaccion.
    ***********************************************************************************************/

    cnuNULL_ATTRIBUTE    CONSTANT NUMBER := 2126;
    csbCRM_SAC_SMS_20083 CONSTANT VARCHAR2(100) := 'CRM_SAC_SMS_20083_6';
    csbCRM_SAC_ELAL_2002163 CONSTANT VARCHAR2(100) := 'CRM_SAC_ELAL_2002163_2';


    nuPlan                       wf_instance.plan_id%TYPE; -- Flujo a anular
    nuSolicitudInteraccion       mo_packages.package_id%TYPE; -- N?mero de solicitud ingresada por par?metro
    sbRECEPTION_TYPE_ID          ge_boInstanceControl.stysbValue; -- Contenido del campo en la pantalla
    sbADDRESS_ID                 ge_boInstanceControl.stysbValue; -- Contenido del campo en la pantalla
    sbPackage_ID                 ge_boInstanceControl.stysbValue; -- Contenido del campo en la pantalla
    nuPaso                       NUMBER; -- ?ltimo paso ejecutado
    sbNombreProcedimiento        VARCHAR2(100) := 'LDC_PROCESA_ITERACION'; -- Nombre del procedimiento ejecutado
    sbError                      VARCHAR2(4000); -- Mensaje de error a mostrar al usuario
    sbErrorTecnico               VARCHAR2(4000); -- Error para mostrar en traza
    nuMedioRecepcionActual       ge_reception_type.reception_type_id%TYPE; -- Medio de recepci?n aactual de la solicitud
    sbMedioEscrito               ge_reception_type.is_write%TYPE; -- Medio escrito
    nuOrdenInteraccion           or_order.order_id%TYPE; --Orden asociada a la solicitud de interacci?n
    minInstancia                 wf_instance.instance_id%TYPE;
    nuCerrada                    ld_parameter.numeric_value%TYPE := DALD_PARAMETER.fnuGetNumeric_Value('COD_ORDER_STATUS'); -- Ordenes cerradas
    nuAnulada                    ld_parameter.numeric_value%TYPE := DALD_PARAMETER.fnuGetNumeric_Value('COD_STATE_CANCEL_OT'); -- Ordenes anuladas
    nuRegistrada                 ld_parameter.numeric_value%TYPE := DALD_PARAMETER.fnuGetNumeric_Value('FNB_ESTADOSOL_REG'); -- Solicitudes registradas
    nuEstadoSolicitudInteraccion mo_motive.motive_status_id%TYPE; -- Estado de la solicitud de interacci?n
    sbTipoTrabajo                VARCHAR2(1000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TITRNOTI',NULL);  --TICKET 200-2163 ELAL --  se almacena tipo de trabajo de notificacion
    nuOrdenNoti                  or_order.order_id%type;  --TICKET 200-2163 ELAL -- se almacena orden de noti
    nuestadoOrden                or_order.order_status_id%type;  --TICKET 200-2163 ELAL --  se almacena estado de la orden de noti


    exError EXCEPTION; -- Excepci?n del programa

    -- Ordenes asociadas a la interacci?n
    CURSOR cuOrdenesInteraccion IS
        SELECT ooa.order_id
        FROM   or_order_activity ooa,
               or_order          oo
        WHERE  ooa.package_id = nuSolicitudInteraccion
        AND    ooa.order_id = oo.order_id
        AND    oo.order_status_id NOT IN (nuCerrada, nuAnulada);

   --TICKET 200-2163 ELAL -- se consulta orden de la interaccion del tipo de trabajo configurada en el parametro LDC_TITRNOTI
   CURSOR cuOrdenesNoti IS
   SELECT ooa.order_id, oo.order_status_id
   FROM or_order_activity ooa,
        or_order oo
   WHERE  ooa.package_id = nuSolicitudInteraccion
    AND    ooa.order_id = oo.order_id
    AND    OO.TASK_TYPE_ID IN (SELECT to_number(column_value)
                             FROM TABLE(open.ldc_boutilities.splitstrings(sbTipoTrabajo,',')));

   nuTipoUnidad  NUMBER:= DALD_PARAMETER.fnuGetNumeric_Value('LDC_TIPOUNIDAD',NULL);--TICKET 200-2314 ELAL -- se almacena tipo de unidad
   nuCodAccion   NUMBER:= DALD_PARAMETER.fnuGetNumeric_Value('LDC_CODACCION',NULL);--TICKET 200-2314 ELAL -- se almacena codigo de accion

   --TICKET 200-2314 ELAL -- se consulta instancia de espera orden hijas
   CURSOR cuInstanciaEspe IS
   SELECT t.instance_id
   FROM wf_instance t
   WHERE  t.plan_id = nuPlan
     AND t.action_id = nuCodAccion
     AND t.UNIT_ID = nuTipoUnidad;

    nuInstanciaEs    wf_instance.instance_id%type; --TICKET 200-2314 ELAL -- se almacena instancia


    --CASO 335
    -- Solicitudes asociadas a la interacci?n
    CURSOR cuSolicitudes (inuSolInteraccion mo_packages.package_id%TYPE)is
       SELECT mp.package_id
       FROM   mo_packages mp
       WHERE  mp.cust_care_reques_num = to_char(inuSolInteraccion);
    ----------------------

BEGIN
    ut_trace.trace('Inicio LDC_PROCESA_ITERACION', 10);
    nuPaso := 10;

    -- Validaci?n de la entrega
    IF NOT fblAplicaEntrega(csbCRM_SAC_SMS_20083) THEN
        sbError := 'No se encuentra aplicada la entrega ' || csbCRM_SAC_SMS_20083;
        RAISE exError;
    END IF;

    -- Leer el c?digo de la solicitud de interaccion
    nuPaso := 20;
    BEGIN
        sbPACKAGE_ID           := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES', 'PACKAGE_ID');
        nuSolicitudInteraccion := to_number(sbPACKAGE_ID);

    EXCEPTION
        WHEN OTHERS THEN
            sbError := 'Error al leer el c?digo de la solicitud. ';
            RAISE exError;
    END;

    -- Leer el nuevo medio de recepci?n
    nuPaso := 30;
    BEGIN
        sbRECEPTION_TYPE_ID := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                                     'RECEPTION_TYPE_ID');
    EXCEPTION
        WHEN OTHERS THEN
            sbError := 'Error al leer el medio de recepci?n. ';
            RAISE exError;
    END;

    -- Leer la nueva direcci?n
    nuPaso := 40;
    BEGIN
        sbADDRESS_ID := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES', 'ADDRESS_ID');
    EXCEPTION
        WHEN OTHERS THEN
            sbError := 'Error al leer la direcci?n. ';
            RAISE exError;
    END;

    -- Validar los par?metros obligatorios
    nuPaso := 50;
    IF (sbPACKAGE_ID IS NULL) THEN
        Errors.SetError(cnuNULL_ATTRIBUTE, 'Solicitud');
        RAISE ex.CONTROLLED_ERROR;
    END IF;

    nuPaso := 60;
    IF (sbRECEPTION_TYPE_ID IS NULL) THEN
        Errors.SetError(cnuNULL_ATTRIBUTE, 'Medio de recepci?n');
        RAISE ex.CONTROLLED_ERROR;
    END IF;

    nuPaso := 70;

    -- Valida que la solicitud est? registrada
    BEGIN
        nuEstadoSolicitudInteraccion := damo_packages.fnugetmotive_status_id(inupackage_id => nuSolicitudInteraccion);
    EXCEPTION
        WHEN OTHERS THEN
            sbError := 'No fue posible determinar el estado de la solicitud ' ||
                       nuSolicitudInteraccion;
            RAISE exError;
    END;

    IF nuEstadoSolicitudInteraccion <> nuRegistrada THEN
        sbError := 'No se puede cambiar la direcci?n ni el medio de recepci?n a una solicitud de interacci?n que est? en un estado diferente a registrada';
        RAISE exError;
    END IF;

    -- Valida que el medio de recepci?n actual sea de medio escrito
    BEGIN
        nuMedioRecepcionActual := damo_packages.fnugetreception_type_id(inupackage_id => nuSolicitudInteraccion);
    EXCEPTION
        WHEN OTHERS THEN
            sbError := 'No fue posible determinar el medio de recepci?n actual de la solicitud ' ||
                       nuSolicitudInteraccion;
            RAISE exError;
    END;

    BEGIN
        SELECT grt.is_write
        INTO   sbMedioEscrito
        FROM   GE_RECEPTION_TYPE grt
        WHERE  grt.reception_type_id = nuMedioRecepcionActual;

    EXCEPTION
        WHEN OTHERS THEN
            sbError        := 'No es posible determinar si el medio de recepci?n actual es escrito.' ||
                              SQLERRM;
            sbErrorTecnico := ' damo_packages.updaddress_id(inupackage_id  => to_number(' ||
                              sbPACKAGE_ID || '),
                                inuaddress_id$ => to_number(' ||
                              sbADDRESS_ID || '));';
            RAISE exError;
    END;

    IF sbMedioEscrito = 'N' THEN
        sbError := 'Esta acci?n s?lo se puede realizar si el medio de recepci?n actual de la solicitud es escrito.';
        RAISE exError;
    END IF;

    --TICKET 200-2163 ELAL --se valida si aplica la entrega
    IF fblAplicaEntrega(csbCRM_SAC_ELAL_2002163) THEN
       --TICKET 200-2163 ELAL -- se realiza validacion de estado de la orden de notificacion
        OPEN cuOrdenesNoti;
        FETCH cuOrdenesNoti INTO nuOrdenNoti, nuestadoOrden;
        IF cuOrdenesNoti%NOTFOUND THEN
            sbError := 'No existe orden de los tipo de trabajo ['||sbTipoTrabajo||'] asociado a la interraccion ['||nuSolicitudInteraccion||']';
        END IF;
        CLOSE cuOrdenesNoti;
         --TICKET 200-2163 ELAL -- se valida que la orden no este cerrada
        IF nuestadoOrden IS NOT NULL AND nuestadoOrden IN (nuCerrada, nuAnulada) THEN
           IF nuestadoOrden = nuCerrada THEN
             sbError := 'No puede realizarse la anulaci?n de la interacci?n['||nuSolicitudInteraccion||'], ya que la orden #'||nuOrdenNoti ||'se encuentra cerrada';
           ELSE
              sbError := 'No puede realizarse la anulaci?n de la interacci?n['||nuSolicitudInteraccion||'], ya que la orden #'||nuOrdenNoti ||'se encuentra anulada';
           END IF;
           RAISE exError;
        END IF;
    END IF;

    -- Se actualiza la informaci?n del medio de recepci?n y la direcci?n de la interacion
    nuPaso := 80;
    BEGIN
        damo_packages.updaddress_id(inupackage_id  => nuSolicitudInteraccion,
                                    inuaddress_id$ => to_number(sbADDRESS_ID));
    EXCEPTION
        WHEN OTHERS THEN
            sbError        := 'Error actualizar la direcci?n.' || SQLERRM;
            sbErrorTecnico := ' damo_packages.updaddress_id(inupackage_id  => to_number(' ||
                              nuSolicitudInteraccion || '),
                                inuaddress_id$ => to_number(' ||
                              sbADDRESS_ID || '));';
            RAISE exError;
    END;

    nuPaso := 90;
    BEGIN
        damo_packages.updreception_type_id(inupackage_id         => nuSolicitudInteraccion,
                                           inureception_type_id$ => to_number(sbRECEPTION_TYPE_ID));
    EXCEPTION
        WHEN OTHERS THEN
            sbError        := 'Error al actualizar el medio de recepci?n';
            sbErrorTecnico := 'damo_packages.updreception_type_id(inupackage_id         => ' ||
                              nuSolicitudInteraccion || '),
                                       inureception_type_id$ => to_number(' ||
                              sbRECEPTION_TYPE_ID || '));';
            RAISE exError;
    END;

    -- Obtener el flujo actual de la interacci?n
    nuPaso := 100;
    BEGIN
        SELECT DISTINCT wi.plan_id
        INTO   nuPlan
        FROM   WF_INSTANCE wi
        WHERE  wi.external_id = to_char(nuSolicitudInteraccion);
    EXCEPTION
        WHEN OTHERS THEN
            sbError        := 'Error al obtener el c?digo del plan asociado a la solicitud ' ||
                              sbPACKAGE_ID;
            sbErrorTecnico := '  SELECT DISTINCT wi.plan_id
							 INTO   nuPlan
							 FROM   WF_INSTANCE wi
							 WHERE  wi.external_id = to_char(' || nuSolicitudInteraccion || ');';
            RAISE exError;
    END;

    ut_trace.trace('nuPlan ' || nuPlan, 10);

    -- Anula el flujo
    nuPaso := 120;
    BEGIN
        MO_BOANNULMENT.ANNULWFPLAN(nuPlan);
    EXCEPTION
        WHEN OTHERS THEN
            sbError        := 'Error al anular el flujo ' || nuPlan;
            sbErrorTecnico := 'MO_BOANNULMENT.ANNULWFPLAN(' || nuPlan || ');';
            RAISE exError;
    END;

    -- cambiar estado
    BEGIN

        ut_trace.trace('update wf_instance t set t.status_id = 1
      where t.plan_id=' || nuPlan,
                       10);
        UPDATE wf_instance t SET t.status_id = 1 WHERE t.plan_id = nuPlan;

        ut_trace.trace('select min(w.instance_id) into minInstancia from wf_instance w where w.plan_id' ||
                       nuPlan,
                       10);
        SELECT MIN(w.instance_id) INTO minInstancia FROM wf_instance w WHERE w.plan_id = nuPlan;

        ut_trace.trace('update wf_instance t set t.status_id = 4
      where t.plan_id= ' || nuPlan || ' and t.instance_id = ' ||
                       minInstancia,
                       10);
        UPDATE wf_instance t
        SET    t.status_id = 4
        WHERE  t.plan_id = nuPlan
        AND    t.instance_id = minInstancia;

        ut_trace.trace('update wf_instance t set t.status_id = 6 where t.plan_id= ' || nuPlan ||
                       ' and t.instance_id = ' || to_number(minInstancia + 1),
                       10);
        UPDATE wf_instance t
        SET    t.status_id = 6
        WHERE  t.plan_id = nuPlan
        AND    t.instance_id = to_number(minInstancia + 1);

        ut_trace.trace('update wf_instance t set t.status_id = 4
      where t.plan_id= ' || nuPlan || ' and t.instance_id = ' ||
                       to_number(minInstancia + 3),
                       10);
       --TICKET 200-2314 ELAL -- se consulta intancia de Esperar solicitudes Hijas
       OPEN cuInstanciaEspe;
       FETCH cuInstanciaEspe INTO nuInstanciaEs;
       IF cuInstanciaEspe%NOTFOUND THEN
          sbError := 'Error no se encuentra instancia Esperar Solicitudes hijas, para la instancia ' || minInstancia;
          sbErrorTecnico := 'cursor cuInstanciaEspe ' ||
                minInstancia || ',
                           SYSDATE);';
          RAISE exError;
       END IF;
       CLOSE cuInstanciaEspe;

        UPDATE wf_instance t
        SET    t.status_id = 4
        WHERE  t.plan_id = nuPlan
        AND    t.instance_id = nuInstanciaEs;

         IF SQL%ROWCOUNT = 0 THEN
            sbError := 'No se actualizo corretamente la instancia '||nuInstanciaEs||' para el plan de workflow '|| nuPlan;
           RAISE exError;
         END IF;

        ut_trace.trace('update wf_instance_trans ff set ff.status = 1
      where ff.origin_id = ' || nuInstanciaEs,
                       10);
        UPDATE wf_instance_trans ff
        SET    ff.status = 1
        WHERE  ff.origin_id = nuInstanciaEs;

        IF SQL%ROWCOUNT <> 0 THEN
            ut_trace.trace('estados actualizado con exito', 10);
        ELSE
          sbError := 'No se actualizo corretamente la transaccion '||nuInstanciaEs||' para el plan de workflow '|| nuPlan;
           RAISE exError;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            sbError        := 'No fue posible cambiar el estado: Error[ ' ||sbError||']' ||nuOrdenInteraccion;
            sbErrorTecnico := SQLERRM || '
           update wf_instance t set t.status_id = 4
      where t.external_id=' || nuOrdenInteraccion || '
          and t.description= Esperar solicitudes Hijas;';
            RAISE exError;
    END;

    -- Anular las ?rdenes en curso de la interacci?n
    FOR rgOrdenesInteraccion IN cuOrdenesInteraccion LOOP
        BEGIN
            Or_BOAnullOrder.AnullOrderWithOutVal(rgOrdenesInteraccion.order_id, SYSDATE);
        EXCEPTION
            WHEN OTHERS THEN
                sbError        := 'Error al anular la orden ' || rgOrdenesInteraccion.order_id;
                sbErrorTecnico := ' Or_BOAnullOrder.AnullOrderWithOutVal(' ||
                                  rgOrdenesInteraccion.order_id || ',
                                             SYSDATE);';
                RAISE exError;
        END;
    END LOOP;

    -- Actualiza el flujo
    BEGIN

        mo_bowf_pack_interfac.PrepNotToWfPack(nuSolicitudInteraccion,
                                              289,
                                              MO_BOCausal.fnuGetsuccess,
                                              3,
                                              FALSE);

        ut_trace.trace('mo_bowf_pack_interfac.PrepNotToWfPack
                    ( ' || nuSolicitudInteraccion || ',289,' ||
                       MO_BOCausal.fnuGetsuccess || ',3,FALSE)',
                       10);
    EXCEPTION
        WHEN OTHERS THEN
            sbError        := 'No fue posible actualizar Flujo ';
            sbErrorTecnico := SQLERRM || ' mo_bowf_pack_interfac.PrepNotToWfPack(' ||
                              nuSolicitudInteraccion || ',289,' || MO_BOCausal.fnuGetsuccess ||
                              ',3,FALSE)';
            RAISE exError;
    END;

    --CASO 335
    if fblaplicaentregaxcaso('0000335') then

      FOR rgSolicitudes IN cuSolicitudes (nuSolicitudInteraccion) LOOP

        BEGIN
            damo_packages.updreception_type_id(inupackage_id         => rgSolicitudes.package_id,
                                               inureception_type_id$ => to_number(sbRECEPTION_TYPE_ID));
        EXCEPTION
            WHEN OTHERS THEN
                sbError        := 'Error al actualizar el medio de recepci?n';
                sbErrorTecnico := 'damo_packages.updreception_type_id(inupackage_id         => ' ||
                                  rgSolicitudes.package_id || '),
                                           inureception_type_id$ => to_number(' ||
                                  sbRECEPTION_TYPE_ID || '));';
                RAISE exError;
        END;

      END LOOP;

    end if;  --if fblaplicaentregaxcaso('0000335') then
    ---------------------------------------

    COMMIT;

    ut_trace.trace('Fin LDC_PROCESA_ITERACION', 10);

EXCEPTION

    WHEN exError THEN
        ut_trace.trace(sbNombreProcedimiento || ' - (' || nuPaso || ' - ' || sbErrorTecnico, 10);

        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbError);
        rollback;
    WHEN ex.CONTROLLED_ERROR THEN
        RAISE;

    WHEN OTHERS THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;

END LDC_PROCESA_ITERACION;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROCESA_ITERACION', 'ADM_PERSON');
END;
/
