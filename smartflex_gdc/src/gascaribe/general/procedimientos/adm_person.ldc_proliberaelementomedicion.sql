CREATE OR REPLACE PROCEDURE adm_person.ldc_proLiberaElementoMedicion IS
    /***********************************************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: ldc_proLiberaElementoMedicion
    Descripci�n:        Marcar� como retirado un �tem seriado al momento de la legalizaci�n

    Autor    : Sandra Mu�oz
    Fecha    : 16-09-2016 cA200-763

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci�n
    -----------  -------------------    -------------------------------------
    16-09-2016   Sandra Mu�oz           Creaci�n
    22-02-2017   Miguel Angel Lopez     CA 200-1104 se cambia tabla ge_item_seriado por elmesesu y se adiciona outerjoin en la consulta que Busca el tipo de solicitud a la que pertenece la ot que se est� legalizando
    02/05/2024   PACOSTA                OSF-2638: Se retita el llamado al esquema OPEN (open.)                                   
                                        Se crea el objeto en el esquema adm_person
    ***********************************************************************************************/
    nuOrderId               or_order.order_id%TYPE; -- N�mero ot
    nuTipoSolicitud         mo_packages.package_type_id%TYPE; -- Tipo de solicitud
    nuTipoSolicitudTraslado ld_parameter.numeric_value%TYPE; -- Tipo de solicitud de traslado
    nuNuevoEstadoMedidor    ld_parameter.numeric_value%TYPE; -- Estado en el que queda un medidor despu�s del traslado
    nuActividadCancContrato ld_parameter.numeric_value%TYPE; -- Actividad que debe ser legalizada para poder liberar un elemento de medici�n
    sbPropiedad             ld_parameter.value_chain%TYPE; -- Estado en el que queda un medidor despu�s del traslado
    sbSerie                 ge_items_seriado.serie%TYPE; -- Serie del medidor
    sbError                 VARCHAR2(4000); -- Error
    nuExiste                NUMBER; -- Indica si existe un elemento en el sistema
    exNoLiberar EXCEPTION; -- Entrega no aplicada
    nuActividadLegalizada or_order_activity.activity_id%TYPE; -- Actividad de la ot
    csbEntrega200273 CONSTANT VARCHAR2(30) := 'CRM_VEN_SMS_200763_1';
    cnuError NUMBER := 2741;

BEGIN
    UT_TRACE.TRACE('Inicio ldc_proLiberaElementoMedicion', 1);

    IF NOT fblAplicaEntrega(csbEntrega200273) THEN
        RAISE exNoLiberar;
    END IF;

    -- Leer de la pantalla el n�mero de orden que se est� procesando
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;

    -- Recuperar el par�metro que indica la actividad que debe legalizarse para que se pueda
    -- realizar la liberaci�n del medidor
    BEGIN
        nuActividadCancContrato := dald_parameter.fnuGetNumeric_Value(inuparameter_id => 'ACTIVIDAD_TRASLADO');
    EXCEPTION
        WHEN OTHERS THEN
            sbError := 'No se pudo recuperar el par�metro ACTIVIDAD_TRASLADO. ' || SQLERRM;
            RAISE ex.Controlled_Error;
    END;

    IF nuActividadCancContrato IS NULL THEN
        sbError := 'No se encontr� valor para el par�metro ACTIVIDAD_TRASLADO';
        RAISE ex.Controlled_Error;
    END IF;

    BEGIN
        SELECT COUNT(1) INTO nuExiste FROM ge_items gi WHERE gi.items_id = nuActividadCancContrato;
    EXCEPTION
        WHEN OTHERS THEN
            sbError := 'No fue posible determinar si el valor ' || nuActividadCancContrato ||
                       ' pertenece a una actividad registrada en el sistema. ' || SQLERRM;
            RAISE ex.Controlled_Error;
    END;

    IF nuExiste = 0 THEN
        sbError := 'No existe en el sistema una actividad con el c�digo ' ||
                   nuActividadCancContrato ||
                   ' la cual est� definida en el par�metro general ACTIVIDAD_TRASLADO';
        RAISE ex.Controlled_Error;
    END IF;

    -- Buscar el tipo de solicitud a la que pertenece la ot que se est� legalizando
    SELECT mp.package_type_id,
           gis.emsscoem serie,
           ooa.activity_id
INTO   nuTipoSolicitud,
           sbSerie,
           nuActividadLegalizada
    FROM   mo_packages       mp,
           or_order_activity ooa,
           pr_product pr,
           pr_product pr1,
           ELMESESU  gis --CA 200-1104 se cambia tabla ge_item_seriado por elmesesu y se adiciona outerjoin
    WHERE  mp.package_id(+) = ooa.package_id
    AND    ooa.order_id = nuOrderId
    and    ooa.product_id = pr.product_id
    and    pr.subscription_id = pr1.subscription_id
    and    pr1.product_type_id = dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS')
    AND    pr1.product_id = gis.emsssesu
    and    (gis.EMSSFERE is null or gis.EMSSFERE > sysdate) ;

    IF nuActividadLegalizada <> nuActividadCancContrato THEN
        RAISE exNoLiberar;
    END IF;

    -- Recuperar el valor del parametro TIPO_SOL_TRASLADO
    BEGIN
        nuTipoSolicitudTraslado := dald_parameter.fnuGetNumeric_Value('TIPO_SOL_TRASLADO');
    EXCEPTION
        WHEN OTHERS THEN
            sbError := 'No fue posible obtener el par�metro TIPO_SOL_TRASLADO. ' || SQLERRM;
            RAISE ex.Controlled_Error;
    END;

    IF nuTipoSolicitudTraslado IS NULL THEN
        sbError := 'El par�metro TIPO_SOL_TRASLADO no tiene valor definido';
        RAISE ex.Controlled_Error;
    END IF;

    BEGIN
        SELECT COUNT(1)
        INTO   nuExiste
        FROM   ps_package_type ppt
        WHERE  ppt.package_type_id = nuTipoSolicitudTraslado;
    EXCEPTION
        WHEN no_data_found THEN
            sbError := 'No se encontr� el tipo de solicitud ' || nuTipoSolicitudTraslado ||
                       ' definido en el par�metro general TIPO_SOL_TRASLADO no tiene valor definido';
            RAISE ex.Controlled_Error;
        WHEN OTHERS THEN
            sbError := 'No se pudo determinar si existe un tipo de solicitud ' ||
                       nuTipoSolicitudTraslado ||
                       ' definido en el par�metro general TIPO_SOL_TRASLADO no tiene valor definido. ' ||
                       SQLERRM;
            RAISE ex.Controlled_Error;
    END;

    IF nuTipoSolicitud = nuTipoSolicitudTraslado THEN

        -- Obtener nuevo estado para medidor
        BEGIN
            nuNuevoEstadoMedidor := dald_parameter.fnuGetNumeric_Value('NUEVO_ESTADO_MED_TRASLADO');
        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible obtener el par�metro ' || nuNuevoEstadoMedidor;
                RAISE ex.Controlled_error;
        END;

        IF nuNuevoEstadoMedidor IS NULL THEN
            sbError := 'El par�metro NUEVO_ESTADO_MED_TRASLADO no tiene valor';
            RAISE ex.Controlled_error;
        END IF;

        BEGIN
            SELECT COUNT(1)
            INTO   nuExiste
            FROM   ge_items_estado_inv giei
            WHERE  giei.id_items_estado_inv = nuNuevoEstadoMedidor;
        EXCEPTION
            WHEN no_data_found THEN
                sbError := 'No se encontr� un estado de �tem seriado con el c�digo ' ||
                           nuNuevoEstadoMedidor ||
                           ' el cual est� definido en el par�metro general NUEVO_ESTADO_MED_TRASLADO';
                RAISE ex.Controlled_Error;
            WHEN OTHERS THEN
                sbError := 'No se pudo determinar si existe un estado de �tem seriado con el c�digo ' ||
                           nuNuevoEstadoMedidor ||
                           ' el cual est� definido en el par�metro general NUEVO_ESTADO_MED_TRASLADO. ' ||
                           SQLERRM;
                RAISE ex.Controlled_Error;
        END;

        -- Obtener el nuevo tipo de propiedad para el medidor
        BEGIN
            sbPropiedad := dald_parameter.fsbGetValue_Chain('PROPIETARIO_MED_TRASLADADO');
        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible obtener el par�metro PROPIETARIO_MED_TRASLADADO ' ||
                           SQLERRM;
                RAISE ex.Controlled_Error;
        END;

        IF sbPropiedad IS NULL THEN
            sbError := 'No se ha definido un valor para el par�metro PROPIETARIO_MED_TRASLADADO';
            RAISE ex.Controlled_Error;
        END IF;

        IF sbPropiedad NOT IN ('E', -- EMPRESA
                               'T', -- tERCERO
                               'C', -- TRA�DO POR CLIENTE,
                               'V' -- VENDIDO AL CLIENTE
                               ) THEN
            sbError := 'Se ha encontrado un valor inv�lido definido en el par�metro PROPIETARIO_MED_TRASLADADO';
            RAISE ex.Controlled_Error;
        END IF;

        -- actualizar el �tem seriado (GE_ITEMS_SERIADO) asociado al elemento de
        -- medici�n del producto al que pertenece la actividad: se debe cambiar el estado del �tem
        -- seriado (ge_items_seriado.id_items_estado_inv) a un n�mero definido en un par�metro (para el
        -- desarrollo este par�metro debe estar inicializado con el n�mero 8)
        BEGIN
            UPDATE ge_items_seriado gis
            SET    gis.id_items_estado_inv = nuNuevoEstadoMedidor,
                   gis.numero_servicio     = NULL,
                   gis.subscriber_id       = NULL,
                   gis.propiedad           = sbPropiedad
            WHERE  gis.serie = sbSerie;

            ut_trace.trace('UPDATE ge_items_seriado gis
                              SET    gis.id_items_estado_inv = ' ||
                           nuNuevoEstadoMedidor || ',
                                     gis.numero_servicio = NULL,
                                     gis.subscriber_id = NULL
                                     gis.propiedad = ' || sbPropiedad || '
                              WHERE  gis.serie = ' || sbSerie || ')');
        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible realizar la actualizaci�n de informacion en el �tem seriado. ' ||
                           SQLERRM;
                RAISE ex.Controlled_Error;
        END;

    END IF;

    UT_TRACE.TRACE('Fin ldc_proLiberaElementoMedicion', 1);

EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        Errors.SetError(cnuError, sbError);
        RAISE;
    WHEN exNoLiberar THEN
        NULL;
    WHEN OTHERS THEN
        Errors.SetError(cnuError, sbError);
        RAISE ex.CONTROLLED_ERROR;

END ldc_proLiberaElementoMedicion;
/
PROMPT Otorgando permisos de ejecucion a LDC_PROLIBERAELEMENTOMEDICION
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PROLIBERAELEMENTOMEDICION', 'ADM_PERSON');
END;
/