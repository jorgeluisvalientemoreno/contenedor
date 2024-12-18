CREATE OR REPLACE PROCEDURE adm_person.LDCLEGGENNOT_TEMP IS
  /*****************************************************************
  UNIDAD       : LDCLEGGENNOT_TEMP
  DESCRIPCION  : 

  AUTOR          : 
  FECHA          : 

  HISTORIA DE MODIFICACIONES
  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================  
  26/04/2024      PACOSTA             OSF-2598: Se crea el objeto en el esquema adm_person
  ******************************************************************/
  
    sbError             VARCHAR2(4000);
    nuTotalRegis        NUMBER;
    csbMetodo           CONSTANT VARCHAR2(50)  := $$PLSQL_UNIT;
    csbPrograma         CONSTANT VARCHAR2(100) := 'LEGGENNOT'||'_'||to_char(SYSDATE, 'DDMMYYHHMISS');
    nuTipoComentario    NUMBER := pkg_parametros.fnugetvalornumerico('TIPO_COMENTARIO_GENERAL');

    sbdataorder       	VARCHAR2 (32767);
    inuorderact_id      NUMBER;

    -- Cursor ordenes de notificacion personal
    CURSOR cuordenesnotper
    IS
    SELECT  orden_nro,dias_habiles,direccion,cliente,paquete,motive
    FROM    (
              SELECT  ot.order_id orden_nro,
                      ot.created_date fecha_creacion,
                      (
                          SELECT  COUNT(1)
                          FROM    ge_calendar t
                          WHERE   t.day_type_id = 1
                          AND t.country_id  = dald_parameter.fnugetnumeric_value('CODIGO_PAIS')
                          AND date_ BETWEEN trunc(ot.created_date) AND trunc(SYSDATE)
                      ) dias_habiles,
                      cl.address_id direccion,
                      cl.subscriber_id cliente,
                      oa.package_id paquete,
                      oa.motive_id motive
              FROM    or_order ot,or_order_activity oa,ge_subscriber cl
              WHERE   ot.task_type_id = 10004
              AND     oa.task_type_id    = 10004
              AND     ot.order_status_id IN(0,5)
              AND     ot.order_id        = oa.order_id
              AND     oa.subscriber_id   = cl.subscriber_id
            )
    WHERE   dias_habiles > dald_parameter.fnugetnumeric_value('PARAM_DIAS_HABILES_NOTI');

    nuerror        NUMBER(2);
    nucantiregcom  NUMBER(15) DEFAULT 0;
    sbmensa        VARCHAR2(4000);
    error          NUMBER;

    nuHilos        NUMBER := 1;
    nuLogProceso   ge_log_process.log_process_id%TYPE;
    sbParametros   ge_process_schedule.parameters_%TYPE;
    nuordentrabajo or_order.order_id%TYPE;
    ionuorderid    or_order.order_id%TYPE;
    nupack         mo_packages.package_id%TYPE;
    nuconta        NUMBER(6);
    nuotenco       NUMBER(15) DEFAULT 0;
    nuotenge       NUMBER(15) DEFAULT 0;
    nuparamorden   or_order.order_id%TYPE;
    sbmensamen     VARCHAR2(4000);

    CURSOR cuCuentaOrdenes
    (
        inuCliente    IN or_order.subscriber_id%TYPE,
        inuSolicitud  IN or_order_activity.package_id%TYPE
    )
    IS
    SELECT  COUNT(1) 
    FROM    or_order otq,
            or_order_activity oaq
    WHERE   otq.subscriber_id   = inuCliente
    AND     otq.order_status_id <> 8
    AND     otq.task_type_id    = 10005
    AND     oaq.package_id = inuSolicitud 
    AND     otq.order_id   = oaq.order_id;

BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzApi,pkg_traza.csbINICIO);

    pkg_estaproc.prInsertaEstaproc(csbPrograma,NULL);

    nuotenco      := 0;
    nuotenge      := 0;
    nuparamorden  := nvl(nuparamorden,-1);

    IF (cuordenesnotper%ISOPEN) THEN
        CLOSE cuordenesnotper;
    END IF;

    FOR i IN cuordenesnotper LOOP

        pkg_traza.trace('Ingreso a recorrer ordenes');

        nuordentrabajo := i.orden_nro;
        nuotenco       := nuotenco + 1;
        error          := 0;
        sbmensa        := NULL;
        nupack          := i.paquete;
        sbdataorder := NULL;

        pkg_traza.trace('nuordentrabajo: ['||nuordentrabajo||']');
        
        pkg_traza.trace('nuTipoComentario: ['||nuTipoComentario||']');

        pkg_cadena_legalizacion.prSetDatosBasicos
        (
            nuordentrabajo,
            dald_parameter.fnugetnumeric_value('PARAM_CAUSA_LEGA_FALLA'),
            dald_parameter.fnugetnumeric_value('PARAM_PERSO_LEGA_NOTI'),
            nuTipoComentario,
            'PROCESO [ldcleggennot_TEMP]. Se legaliza automaticamente la ot : '||to_char(nuordentrabajo)
        );

        pkg_cadena_legalizacion.prAgregaActividadOrden;

        sbdataorder:= pkg_cadena_legalizacion.fsbCadenaLegalizacion;

        pkg_traza.trace('sbdataorder: '||sbdataorder);

        api_legalizeorders
        (
            sbdataorder,
            SYSDATE,
            SYSDATE,
            SYSDATE,
            error,
            sbmensa
        );

        ionuorderid := NULL;

        IF (nvl(error,0) = 0) THEN
            nucantiregcom := nucantiregcom + 1;

            IF (cuCuentaOrdenes%ISOPEN)  THEN
                CLOSE cuCuentaOrdenes;
            END IF;

            OPEN cuCuentaOrdenes(i.cliente,i.paquete);
            FETCH cuCuentaOrdenes INTO nuconta;
            CLOSE cuCuentaOrdenes;

            IF nuconta = 0 THEN
                error   := NULL;
                sbmensa := NULL;

                api_createorder(    200004,--inuItemsid
                                    i.paquete,           --inuPackageid
                                    i.motive,           --inuMotiveid
                                    NULL,           --inuComponentid
                                    NULL,           --inuInstanceid
                                    i.direccion,    --inuAddressid
                                    NULL,           --inuElementid
                                    i.cliente,      --inuSubscriberid
                                    NULL,           --inuSubscriptionid
                                    NULL,           --inuProductid
                                    NULL,           --inuOperunitid
                                    sysdate,        --idtExecestimdate
                                    NULL,           --inuProcessid
                                    'PROCESO [ldcleggennot_TEMP]. Se legaliza ot : '||to_char(nuordentrabajo)||' se genera ot de Envio notif. x aviso.',           --isbComment
                                    FALSE,          --iblProcessorder
                                    NULL,           --inuPriorityid
                                    NULL,           --inuOrdertemplateid
                                    NULL,           --isbCompensate
                                    NULL,           --inuConsecutive
                                    NULL,           --inuRouteid
                                    NULL,           --inuRouteConsecutive
                                    NULL,           --inuLegalizetrytimes
                                    NULL,           --isbTagname
                                    TRUE,           --iblIsacttoGroup
                                    NULL,           --inuRefvalue
                                    NULL,           --inuActionid
                                    ionuorderid,    --ionuOrderid
                                    inuorderact_id, --ionuOrderactivityid
                                    error,   --onuErrorCode
                                    sbmensa --osbErrorMessage
                                );

                IF nvl(error,0) = 0 THEN
                    UPDATE  or_order_activity oat
                    SET     oat.comment_='PROCESO [ldcleggennot_TEMP]. Se legaliza ot : '||to_char(nuordentrabajo)||' se genera ot de Envio notif. x aviso.' ||to_char(ionuorderid)
                    WHERE   oat.order_id  = ionuorderid;

                    nuotenge := nuotenge + 1;
                END IF;
            END IF;
        END IF;

        nucantiregcom := nucantiregcom + 1;

        pkg_estaproc.prActualizaAvance
        (
            csbPrograma,
            'Procesando: '||nuotenco,
            nuotenco,
            nuTotalRegis
        );

        COMMIT;
    END LOOP;


    IF sbmensa IS NOT NULL THEN
        sbmensamen := 'PROCESO [ldcleggennot_TEMP].Proceso termino con errores, orden de trabajo : '||to_char(nuordentrabajo)||' ERROR : '||sbmensa;
    ELSE
        sbmensamen := 'PROCESO [ldcleggennot_TEMP].Proceso termino ok. Se proceso la orden de trabajo : '||to_char(nuordentrabajo) ||' se genera ot de Envio notif. x aviso.' ||to_char(ionuorderid);
    END IF;

    pkg_estaproc.practualizaestaproc
    (
        csbPrograma,
        'OK',
        sbmensamen
    );
    COMMIT;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzApi, pkg_traza.csbFIN);
EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        ROLLBACK;
        pkg_Error.getError( nuerror,sberror);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        pkg_estaproc.practualizaestaproc( csbPrograma, 'Error', nuerror||'-'||sberror);
    WHEN OTHERS THEN
        ROLLBACK;
        pkg_error.seterror;
        pkg_error.geterror(nuerror, sberror  );
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        error   := -1;
        sbmensa := to_char(error)||' Error en ldcleggennot_TEMP..lineas error '||to_char(nuerror)||' orden de trabajo : ' || to_char(nuordentrabajo) || ' ' || SQLERRM;
        pkg_estaproc.practualizaestaproc( csbPrograma, 'Error', sbmensa);  
END LDCLEGGENNOT_TEMP;
/
BEGIN
    pkg_utilidades.praplicarpermisos('LDCLEGGENNOT_TEMP', 'ADM_PERSON');
END;
/