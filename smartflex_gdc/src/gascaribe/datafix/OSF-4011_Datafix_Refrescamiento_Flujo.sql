SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-4011"
prompt "-----------------"

DECLARE

    CURSOR cuSolPro IS
    SELECT package_id
    FROM   open.mo_packages
    WHERE  package_id IN ( 223823887, 223690555, 223836180, 223494333, 223826184,
                            223757215, 223835836, 223510126, 223820008, 223819964,
                            223850401, 223514793, 223630758, 223476392, 223757203,
                            223511697, 223838975, 223820206, 223700846, 223836295,
                            223850272, 223848850, 223841525, 223847407, 223730578,
                            223731295, 223730742, 223825095, 223825036, 223779883,
                            223060516, 223824883, 223820099, 223823545, 223825937,
                            223723367, 223836024, 223828707, 223728359, 223626416,
                            223699582, 223704085, 223671679, 223692517, 223733065,
                            223730184, 223730150, 223673443, 223685675, 223822046,
                            223822408, 223816089, 223817035, 223817043, 223812868,
                            223812878, 223822931, 223815225, 223817349, 223817238,
                            223818240, 223821024, 223813462, 223815420, 223821267,
                            223698347, 223851253, 223696010, 223848718, 223848599,
                            223735211, 223850255, 223575706, 223850942, 223849810,
                            223849798, 223732269, 223526914, 223807079, 223808244,
                            223799458, 223807657, 223807734, 223809873, 223811166,
                            223801138, 223803614, 223804926, 223809202, 223802926,
                            223802610, 223798447, 223799315, 223806199, 223728741,
                            223843372, 223843334, 223841293, 223841673, 223847209,
                            223841169, 223841283, 223841509, 223625512, 223847748,
                            223729529, 223212849, 223713368, 223844843, 223844618,
                            223844696, 223842228, 223840464, 223844956, 223556217,
                            223845223, 223848126, 223727119, 223845179, 223845501,
                            223846702, 223849168, 223687690, 223845681, 223230828,
                            223723093, 223785443, 223844059, 223727395, 223578236,
                            223833934, 223517535, 223668880, 223468937, 223665928,
                            223672521, 223541434, 222931566, 223839859, 223840319,
                            223623874, 223623838, 223841107, 223839484, 223465501,
                            223465583, 223712307, 223796584, 223759410, 223604048,
                            223612668, 223526217, 223575866, 223724706, 223562627,
                            223466724, 223775150, 223732197, 223617740, 223605090,
                            223666395, 223768269, 223611927, 223763488, 223763320,
                            223768982, 223615043, 223762410, 223689797, 223490419,
                            223629850, 223241254, 223539444, 223598545, 223586602,
                            223255550, 223760169, 223495073, 223699088, 223526678,
                            223524317, 223541222, 223564974, 223606733, 222956303,
                            223693123, 223533993, 223037901, 223335324, 223687347,
                            223561082, 223717026, 223733975, 223823045, 223822400,
                            223623968, 223849372, 223513744, 223810652, 223524634,
                            223629154, 223601591, 223600215, 223598929,
                            223693671, 223463995, 223699900, 223677082, 223719311,
                            223257869, 223555926, 223581927, 223556266, 223270075,
                            223758381, 223524031, 223765416, 223314794, 223545514,
                            223490062, 223671815, 223441992, 223539270, 223619014,
                            223628721, 223724712 );

    PROCEDURE LDC_PROCESA_ITERACION (
        nusolicitudinteraccion IN mo_packages.package_id%TYPE -- N?mero de solicitud ingresada por par?metro   
    ) IS

        nuplan                wf_instance.plan_id%TYPE; -- Flujo a anular

        sbpackage_id          ge_boinstancecontrol.stysbvalue; -- Contenido del campo en la pantalla
        nupaso                NUMBER; -- ?ltimo paso ejecutado
        sbnombreprocedimiento VARCHAR2(100) := 'LDC_PROCESA_ITERACION'; -- Nombre del procedimiento ejecutado
        sberror               VARCHAR2(4000); -- Mensaje de error a mostrar al usuario
        sberrortecnico        VARCHAR2(4000); -- Error para mostrar en traza  
        nuordeninteraccion    or_order.order_id%TYPE; --Orden asociada a la solicitud de interacci?n
        mininstancia          wf_instance.instance_id%TYPE;
        nucerrada             ld_parameter.numeric_value%TYPE := dald_parameter.fnugetnumeric_value('COD_ORDER_STATUS'); -- Ordenes cerradas
        nuanulada             ld_parameter.numeric_value%TYPE := dald_parameter.fnugetnumeric_value('COD_STATE_CANCEL_OT'); -- Ordenes anuladas

        exerror EXCEPTION; -- Excepci?n del programa

    -- Ordenes asociadas a la interacci?n
        CURSOR cuordenesinteraccion IS
        SELECT
            ooa.order_id
        FROM
            or_order_activity ooa,
            or_order          oo
        WHERE
                ooa.package_id = nusolicitudinteraccion
            AND ooa.order_id = oo.order_id
            AND oo.order_status_id NOT IN ( nucerrada, nuanulada );

        nutipounidad          NUMBER := dald_parameter.fnugetnumeric_value('LDC_TIPOUNIDAD', NULL);--TICKET 200-2314 ELAL -- se almacena tipo de unidad
        nucodaccion           NUMBER := dald_parameter.fnugetnumeric_value('LDC_CODACCION', NULL);--TICKET 200-2314 ELAL -- se almacena codigo de accion

   --TICKET 200-2314 ELAL -- se consulta instancia de espera orden hijas
        CURSOR cuinstanciaespe IS
        SELECT
            t.instance_id
        FROM
            wf_instance t
        WHERE
                t.plan_id = nuplan
            AND t.action_id = nucodaccion
            AND t.unit_id = nutipounidad;

        nuinstanciaes         wf_instance.instance_id%TYPE; --TICKET 200-2314 ELAL -- se almacena instancia

    BEGIN

    -- Obtener el flujo actual de la interacci?n
        nupaso := 100;
        BEGIN
            SELECT DISTINCT
                wi.plan_id
            INTO nuplan
            FROM
                wf_instance wi
            WHERE
                wi.external_id = to_char(nusolicitudinteraccion);

        EXCEPTION
            WHEN OTHERS THEN
                sberror := 'Error al obtener el c?digo del plan asociado a la solicitud ' || sbpackage_id;
                sberrortecnico := '  SELECT DISTINCT wi.plan_id
 INTO   nuPlan
 FROM   WF_INSTANCE wi
 WHERE  wi.external_id = to_char('
                                  || nusolicitudinteraccion
                                  || ');';
                RAISE exerror;
        END;

        ut_trace.trace('nuPlan ' || nuplan, 10);

    -- Anula el flujo
        nupaso := 120;
        BEGIN
            mo_boannulment.annulwfplan(nuplan);
        EXCEPTION
            WHEN OTHERS THEN
                sberror := 'Error al anular el flujo ' || nuplan;
                sberrortecnico := 'MO_BOANNULMENT.ANNULWFPLAN('
                                  || nuplan
                                  || ');';
                RAISE exerror;
        END;

    -- cambiar estado
        BEGIN
            ut_trace.trace('update wf_instance t set t.status_id = 1
      where t.plan_id=' || nuplan, 10);
            UPDATE wf_instance t
            SET
                t.status_id = 1
            WHERE
                t.plan_id = nuplan;

            ut_trace.trace('select min(w.instance_id) into minInstancia from wf_instance w where w.plan_id' || nuplan, 10);
            SELECT
                MIN(w.instance_id)
            INTO mininstancia
            FROM
                wf_instance w
            WHERE
                w.plan_id = nuplan;

            ut_trace.trace('update wf_instance t set t.status_id = 4
      where t.plan_id= '
                           || nuplan
                           || ' and t.instance_id = '
                           || mininstancia, 10);
            UPDATE wf_instance t
            SET
                t.status_id = 4
            WHERE
                    t.plan_id = nuplan
                AND t.instance_id = mininstancia;

            ut_trace.trace('update wf_instance t set t.status_id = 6 where t.plan_id= '
                           || nuplan
                           || ' and t.instance_id = '
                           || to_number(mininstancia + 1), 10);

            UPDATE wf_instance t
            SET
                t.status_id = 6
            WHERE
                    t.plan_id = nuplan
                AND t.instance_id = to_number(mininstancia + 1);

            ut_trace.trace('update wf_instance t set t.status_id = 4
      where t.plan_id= '
                           || nuplan
                           || ' and t.instance_id = '
                           || to_number(mininstancia + 3), 10);
       --TICKET 200-2314 ELAL -- se consulta intancia de Esperar solicitudes Hijas
            OPEN cuinstanciaespe;
            FETCH cuinstanciaespe INTO nuinstanciaes;
            IF cuinstanciaespe%notfound THEN
                sberror := 'Error no se encuentra instancia Esperar Solicitudes hijas, para la instancia ' || mininstancia;
                sberrortecnico := 'cursor cuInstanciaEspe '
                                  || mininstancia
                                  || ',
                           SYSDATE);';
                RAISE exerror;
            END IF;

            CLOSE cuinstanciaespe;
            UPDATE wf_instance t
            SET
                t.status_id = 4
            WHERE
                    t.plan_id = nuplan
                AND t.instance_id = nuinstanciaes;

            IF SQL%rowcount = 0 THEN
                sberror := 'No se actualizo corretamente la instancia '
                           || nuinstanciaes
                           || ' para el plan de workflow '
                           || nuplan;
                RAISE exerror;
            END IF;

            ut_trace.trace('update wf_instance_trans ff set ff.status = 1
      where ff.origin_id = ' || nuinstanciaes, 10);
            UPDATE wf_instance_trans ff
            SET
                ff.status = 1
            WHERE
                ff.origin_id = nuinstanciaes;

            IF SQL%rowcount <> 0 THEN
                ut_trace.trace('estados actualizado con exito', 10);
            ELSE
                sberror := 'No se actualizo corretamente la transaccion '
                           || nuinstanciaes
                           || ' para el plan de workflow '
                           || nuplan;
                RAISE exerror;
            END IF;

        EXCEPTION
            WHEN OTHERS THEN
                sberror := 'No fue posible cambiar el estado: Error[ '
                           || sberror
                           || ']'
                           || nuordeninteraccion;
                sberrortecnico := sqlerrm
                                  || '
           update wf_instance t set t.status_id = 4
      where t.external_id='
                                  || nuordeninteraccion
                                  || '
          and t.description= Esperar solicitudes Hijas;';
                RAISE exerror;
        END;

    -- Anular las ?rdenes en curso de la interacci?n
        FOR rgordenesinteraccion IN cuordenesinteraccion LOOP
            BEGIN
                or_boanullorder.anullorderwithoutval(rgordenesinteraccion.order_id, sysdate);
            EXCEPTION
                WHEN OTHERS THEN
                    sberror := 'Error al anular la orden ' || rgordenesinteraccion.order_id;
                    sberrortecnico := ' Or_BOAnullOrder.AnullOrderWithOutVal('
                                      || rgordenesinteraccion.order_id
                                      || ',
                                             SYSDATE);';
                    RAISE exerror;
            END;
        END LOOP;

    -- Actualiza el flujo
        BEGIN
            mo_bowf_pack_interfac.prepnottowfpack(nusolicitudinteraccion, 289, mo_bocausal.fnugetsuccess, 3, false);
            ut_trace.trace('mo_bowf_pack_interfac.PrepNotToWfPack
                    ( '
                           || nusolicitudinteraccion
                           || ',289,'
                           || mo_bocausal.fnugetsuccess
                           || ',3,FALSE)', 10);

        EXCEPTION
            WHEN OTHERS THEN
                sberror := 'No fue posible actualizar Flujo ';
                sberrortecnico := sqlerrm
                                  || ' mo_bowf_pack_interfac.PrepNotToWfPack('
                                  || nusolicitudinteraccion
                                  || ',289,'
                                  || mo_bocausal.fnugetsuccess
                                  || ',3,FALSE)';

                RAISE exerror;
        END;

        COMMIT;
        ut_trace.trace('Fin LDC_PROCESA_ITERACION', 10);
    EXCEPTION
        WHEN exerror THEN
            ut_trace.trace(sbnombreprocedimiento
                           || ' - ('
                           || nupaso
                           || ' - '
                           || sberrortecnico, 10);

            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, sberror);
            ROLLBACK;
        WHEN ex.controlled_error THEN
            RAISE;
        WHEN OTHERS THEN
            errors.seterror;
            RAISE ex.controlled_error;
    END ldc_procesa_iteracion;   
    

BEGIN
    for rcsol in cuSolPro loop
    
        DBMS_OUTPUT.PUT_LINE('Procesando flujo solicitud: ' ||rcsol.package_id);
        ldc_procesa_iteracion(rcsol.package_id);
    end loop;
END;
/
prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-4011-----"
prompt "-----------------------"
SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;
prompt Fin Proceso!!
set serveroutput off
quit
/