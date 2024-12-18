CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_BCPRECUPON IS

    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : ldc_bcPreCupon
      Descripcion    : Obtiene los datos a presentar el el formato PRE_CUPON
      Autor          : Sandra Mu?oz
      Fecha          : 21-05-2016

      Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
    ******************************************************************/

    gnuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE;
    gnuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE;

    PROCEDURE proEncabezado(orfcursor OUT constants.tyRefCursor);

    PROCEDURE proDetalle(orfcursor OUT constants.tyRefCursor);

    PROCEDURE proTotal(orfcursor OUT constants.tyRefCursor);

END;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_BCPRECUPON IS

    gsbPaquete CONSTANT VARCHAR2(4000) := 'ldc_bcPreCupon'; --

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : proEncabezado
    Descripcion    : Obtiene la informaci?n para mostrar en el encabezado del cup?n
    Autor          : Sandra Mu?oz
    Fecha          : 21-05-2016

    Fecha             Autor             Modificacion
    =========       =========           ====================
    24-05-2016      Sandra Mu?oz        Correcci?n en los valores a mostrar
    21-05-2016      Sandra Mu?oz        Creaci?n
    ******************************************************************/
    PROCEDURE proEncabezado(orfcursor OUT constants.tyRefCursor) IS

        nuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE; -- Cotizaci?n detallada
        nuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE; -- Proyecto
        sbProceso             VARCHAR2(30) := 'proEncabezado';
        rcProyecto            daldc_proyecto_constructora.styLDC_PROYECTO_CONSTRUCTORA;

    BEGIN

        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        nuCotizacionDetallada := gnuCotizacionDetallada;
        nuProyecto            := gnuProyecto;

        BEGIN
        rcProyecto := daldc_proyecto_constructora.frcGetRecord(nuProyecto);
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;
        ut_trace.trace('nuCotizacionDetallada ' || nuCotizacionDetallada);
        ut_trace.trace('nuProyecto ' || nuProyecto);

        OPEN orfcursor FOR
            SELECT gs.subscriber_name || ' ' || gs.subs_last_name nombre_cliente,
                   gs.identification ident,
                   git.description tipo_ident_desc,
                   dir_cliente.address_parsed dir_cliente,
                   dir_entrega.address_parsed dir_entrega,
                   ggl.description localidad,
                   lpc.nombre nombre_proyecto,
                   (SELECT '$'||to_char(SUM(nvl(lcc.precio_total,0) *
                             nvl(rcProyecto.Cant_Unid_Predial, 0)),'FM999,999,990.00')
                      FROM   ldc_consolid_cotizacion lcc,
                             or_task_type            ott
                     WHERE  lcc.id_tipo_trabajo = ott.task_type_id
                       AND    lcc.id_cotizacion_detallada = nuCotizacionDetallada
                       AND    lcc.id_proyecto = nuProyecto) valor_contrato,
                   lpc.cant_unid_predial unid_pred_contrat,
                   to_char(SYSDATE, 'dd-mm-yyyy') fecha_expedicion,
                   lcc.id_cotizacion_osf numero_cotizacion,
                   lpc.suscripcion contrato,
                   dacc_quotation.fnugetpackage_id(lcc.id_cotizacion_osf,0) solicitud,
                   (SELECT '$'||to_char(SUM(nvl(rcProyecto.Porc_Cuot_Ini / 100, 0) * nvl(lcc.precio_total,0) *
                             nvl(rcProyecto.Cant_Unid_Predial, 0)),'FM999,999,990.00')
                      FROM   ldc_consolid_cotizacion lcc,
                             or_task_type            ott
                     WHERE  lcc.id_tipo_trabajo = ott.task_type_id
                       AND    lcc.id_cotizacion_detallada = nuCotizacionDetallada
                       AND    lcc.id_proyecto = nuProyecto) anticipo
            FROM   ldc_cotizacion_construct  lcc, -- Cotizaci?n
                   ldc_proyecto_constructora lpc, -- Proyecto
                   ge_subscriber             gs, -- Cliente
                   ge_identifica_type        git, -- Tipo de identificacion
                   ab_address                dir_cliente, -- Direcci?n del cliente
                   ab_address                dir_entrega, -- Dir entrega
                   ge_geogra_location        ggl
            WHERE  lcc.id_cotizacion_detallada = nuCotizacionDetallada
            AND    lcc.id_proyecto = nuProyecto
            AND    lcc.id_proyecto = lpc.id_proyecto
            AND    lpc.cliente = gs.subscriber_id
            AND    gs.ident_type_id = git.ident_type_id
            AND    lpc.id_direccion = dir_entrega.address_id(+)
            AND    gs.address_id = dir_cliente.address_id
            AND    lpc.id_localidad = ggl.geograp_location_id(+);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN OTHERS THEN
            PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
    END proEncabezado;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : proDetalle
    Descripcion    : Obtiene la informaci?n para mostrar en el detalle
    Autor          : Sandra Mu?oz
    Fecha          : 21-05-2016

    Fecha             Autor             Modificacion
    =========       =========           ====================
        24-05-2016      Sandra Mu?oz        Correcci?n en los valores a mostrar
    21-05-2016      Sandra Mu?oz        Creaci?n
    ******************************************************************/
    PROCEDURE proDetalle(orfcursor OUT constants.tyRefCursor) IS

        nuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE; -- Cotizaci?n detallada
        nuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE; -- Proyecto
        nuExiste              NUMBER; -- Indica si existe un dato
        sbProceso             VARCHAR2(30) := 'proDetalle';
        rcProyecto            ldc_proyecto_constructora%ROWTYPE;
        sbError               VARCHAR2(4000);

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        nuCotizacionDetallada := gnuCotizacionDetallada;
        nuProyecto            := gnuProyecto;

        ut_trace.trace('nuCotizacionDetallada ' || nuCotizacionDetallada);
        ut_trace.trace('nuProyecto ' || nuProyecto);

        -- Obtener los datos del proyecto
        ldc_bcproyectoconstructora.proDatosProyecto(inuproyecto => nuProyecto,
                                                    orcproyecto => rcProyecto,
                                                    osberror    => sbError);

        IF sbError IS NULL THEN

            -- Verificar si existen datos a mostrar
            SELECT COUNT(1)
            INTO   nuExiste
            FROM   ldc_consolid_cotizacion lcc,
                   or_task_type            ott
            WHERE  lcc.id_tipo_trabajo = ott.task_type_id
            AND    lcc.id_cotizacion_detallada = nuCotizacionDetallada
            AND    lcc.id_proyecto = nuProyecto;

            IF nuExiste > 0 THEN

                OPEN orfcursor FOR
                    SELECT ott.description desc_tipo_trabajo,
                           '$'||to_char(nvl(rcProyecto.Porc_Cuot_Ini / 100, 0) * lcc.precio *
                           nvl(rcProyecto.Cant_Unid_Predial, 0),'FM999,999,990.00') total_servicio,
                           '$'||to_char((nvl(lcc.precio_total, 0) - nvl(lcc.precio, 0)) *
                           nvl(rcProyecto.Cant_Unid_Predial, 0),'FM999,999,990.00') iva,
                           '$'||to_char(nvl(rcProyecto.Porc_Cuot_Ini / 100, 0) * nvl(lcc.precio_total,0) *
                           nvl(rcProyecto.Cant_Unid_Predial, 0),'FM999,999,990.00') precio_total
                    FROM   ldc_consolid_cotizacion lcc,
                           or_task_type            ott
                    WHERE  lcc.id_tipo_trabajo = ott.task_type_id
                    AND    lcc.id_cotizacion_detallada = nuCotizacionDetallada
                    AND    lcc.id_proyecto = nuProyecto;

            ELSE
                OPEN orfcursor FOR
                    SELECT NULL desc_tipo_trabajo,
                           NULL total_servicio,
                           NULL iva,
                           NULL precio_total
                    FROM   dual;
            END IF;

        END IF;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);

    EXCEPTION
        WHEN OTHERS THEN
            PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
    END proDetalle;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : proTotal
    Descripcion    : Obtiene la informaci?n para mostrar en la secci?n de totales
    Autor          : Sandra Mu?oz
    Fecha          : 21-05-2016

    Fecha             Autor             Modificacion
    =========       =========           ====================
    24-05-2016      Sandra Mu?oz        Correcci?n en los valores a mostrar
    21-05-2016      Sandra Mu?oz        Creaci?n
    ******************************************************************/
    PROCEDURE proTotal(orfcursor OUT constants.tyRefCursor) IS

        nuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE; -- Cotizaci?n detallada
        nuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE; -- Proyecto
        rcProyecto            ldc_proyecto_constructora%ROWTYPE;
        sbError               VARCHAR2(4000);

    BEGIN

        ut_trace.trace('INICIO proTotal');

        nuCotizacionDetallada := gnuCotizacionDetallada;
        nuProyecto            := gnuProyecto;

        ut_trace.trace('nuCotizacionDetallada ' || nuCotizacionDetallada);
        ut_trace.trace('nuProyecto ' || nuProyecto);

        -- Obtener los datos del proyecto
        ldc_bcproyectoconstructora.proDatosProyecto(inuproyecto => nuProyecto,
                                                    orcproyecto => rcProyecto,
                                                    osberror    => sbError);

        OPEN orfcursor FOR
            SELECT /*rcProyecto.Porc_Cuot_Ini/100 * SUM(nvl(lcc.precio, 0)) total_servicios,
                                           SUM(nvl(lcc.precio_total, 0)) - SUM(nvl(lcc.precio, 0)) iva,
                                           SUM(nvl(lcc.precio_total, 0)) precio_total*/
             '$'||to_char(SUM(nvl(rcProyecto.Porc_Cuot_Ini / 100, 0) * nvl(lcc.precio,0) *
                 nvl(rcProyecto.Cant_Unid_Predial, 0)),'FM999,999,990.00') total_servicios,
              '$'||to_char(SUM((nvl(lcc.precio_total, 0) - nvl(lcc.precio, 0)) *
                 nvl(rcProyecto.Cant_Unid_Predial, 0) * rcProyecto.Porc_Cuot_Ini/100),'FM999,999,990.00') iva,
             '$'||to_char(SUM(nvl(rcProyecto.Porc_Cuot_Ini / 100, 0) * nvl(lcc.precio_total,0) *
                 nvl(rcProyecto.Cant_Unid_Predial, 0)),'FM999,999,990.00') precio_total
            FROM   ldc_consolid_cotizacion lcc,
                   or_task_type            ott
            WHERE  lcc.id_tipo_trabajo = ott.task_type_id
            AND    lcc.id_cotizacion_detallada = nuCotizacionDetallada
            AND    lcc.id_proyecto = nuProyecto;

        ut_trace.trace('FIN proTotal');

    EXCEPTION
        WHEN OTHERS THEN
            ut_trace.trace('Error ' || SQLERRM);
            PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
    END proTotal;

END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BCPRECUPON', 'ADM_PERSON'); 
END;
/
