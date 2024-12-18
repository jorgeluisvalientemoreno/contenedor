CREATE OR REPLACE PACKAGE adm_person.ldc_BCProyectoConstructora IS

    -- Traer información
    PROCEDURE proDatosCliente(inuCliente            ge_subscriber.subscriber_id%TYPE, -- Código del cliente
                              onuTipoIdentificacion OUT ge_identifica_type.ident_type_id%TYPE, -- Tipo de identificación
                              osbNroIdentificacion  OUT ge_subscriber.identification%TYPE, -- Número de identificación
                              osbNombre             OUT VARCHAR2);

    PROCEDURE proDatosTipoConstruccion(inuTipoConstruccion ldc_tipo_construccion.id_tipo_construccion%TYPE, -- Tipo de construcción
                                       orcTipoConstruccion OUT ldc_tipo_construccion%ROWTYPE, -- Información tipo de construcción
                                       osbError            VARCHAR2);

    PROCEDURE proDatosProyecto(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                               orcProyecto OUT ldc_proyecto_constructora%ROWTYPE, -- Datos del proyectp
                               osbError    OUT VARCHAR2 -- Error
                               );

    PROCEDURE proDatosProyecto(inuProyecto      ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                               osbNombre        OUT ldc_proyecto_constructora.nombre%TYPE, --nombre,
                               osbObservacion   OUT ldc_proyecto_constructora.descripcion%TYPE, --observacion,
                               onuDireccion     OUT ldc_proyecto_constructora.id_direccion%TYPE, --dir,
                               onuLocalidad     OUT ldc_proyecto_constructora.id_localidad%TYPE, --localidad,
                               onuFechaCreacion OUT ldc_proyecto_constructora.fecha_creacion%TYPE, --fecha de registro,
                               onuFechaUltModif OUT ldc_proyecto_constructora.fech_ult_modif%TYPE, --fecha de última modificación,
                               onuPisos         OUT ldc_proyecto_constructora.cantidad_pisos%TYPE, --cantidad de pisos,
                               onuTorres        OUT ldc_proyecto_constructora.cantidad_torres%TYPE, --torres,
                               onuTiposUnidPred OUT ldc_proyecto_constructora.tipo_construccion%TYPE, --tipos
                               onuTotalAptos    OUT ldc_proyecto_constructora.cant_unid_predial%TYPE, --total de apartamentos
                               onuContrato      OUT ldc_proyecto_constructora.contrato%TYPE, -- contrato y pagaré
                               onuPagare        OUT ldc_proyecto_constructora.pagare%TYPE, -- pagare
                               osbFormaPago     OUT ldc_proyecto_constructora.forma_pago%TYPE, --Forma de Pago
                               onuTipoVivienda  OUT ldc_proyecto_constructora.tipo_vivienda%TYPE, --Tipo Vivienda
                               osbError         OUT VARCHAR2 -- Error
                               );

    PROCEDURE proDatosTipoUnidad(inuProyecto   ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                 inuTipoUnidad ldc_tipo_unid_pred_proy.id_tipo_unid_pred%TYPE, -- Tipo unidad
                                 orcTipoUnidad OUT ldc_tipo_unid_pred_proy%ROWTYPE, -- Datos del tipo de unidad
                                 osbError      OUT VARCHAR2 -- Error
                                 );

    PROCEDURE proDatosPiso(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                           inuPiso     ldc_piso_proyecto.id_piso%TYPE, -- Tipo unidad
                           orcPiso     OUT ldc_piso_proyecto%ROWTYPE, -- Datos del piso
                           osbError    OUT VARCHAR2 -- Error
                           );

    PROCEDURE proDatosTorre(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                            inuTorre    ldc_torres_proyecto.id_torre%TYPE, -- Torre
                            orcTorre    OUT ldc_torres_proyecto%ROWTYPE, -- Datos de la torre
                            osbError    OUT VARCHAR2 -- Error
                            );

    PROCEDURE proDatosUnidPredial(inuUnidadPredial ldc_unidad_predial.id_unidad_predial%TYPE, -- Unidad predial
                                  inuPiso          ldc_unidad_predial.id_piso%TYPE, -- Piso
                                  inuTorre         ldc_unidad_predial.id_torre%TYPE, -- Torre
                                  inuProyecto      ldc_unidad_predial.id_proyecto%TYPE, -- Proyecto
                                  osbError         OUT VARCHAR2 -- Error
                                  );

    -- Para mostrar en pantalla
    FUNCTION fcrMetrajesXPiso(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE -- Proyecto
                              ) RETURN PKCONSTANTE.TYREFCURSOR;

    FUNCTION fcrMetrajesXTipoUnid(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE -- Proyecto
                                  ) RETURN PKCONSTANTE.TYREFCURSOR;

    FUNCTION fnuUnidadesPorPisoYTipo(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                     inuPiso     ldc_piso_proyecto.id_piso%TYPE, --piso
                                     inuTipo     ldc_tipo_unid_pred_proy.id_tipo_unid_pred%TYPE --tipo
                                     ) RETURN NUMBER;

    FUNCTION fnuUnidadesPorTorre(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE) RETURN NUMBER;
    -- Existencia de datos

    FUNCTION fblTieneCotizaciones(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE -- Proyecto
                                  ) RETURN BOOLEAN;

    PROCEDURE proValidaLocalidadDireccion(inuDireccion ab_address.address_id%TYPE, -- Direccion
                                          inuLocalidad ge_geogra_location.geograp_location_id%TYPE -- Localidad
                                          );

    FUNCTION fblProyectoConVenta(inuProyecto ldc_cuotas_proyecto.id_proyecto%TYPE -- Proyecto
                                 ) RETURN BOOLEAN;

    FUNCTION fblProyConVentaAprob(inuProyecto ldc_cuotas_proyecto.id_proyecto%TYPE -- Proyecto
                                 ) RETURN BOOLEAN;

END ldc_BCProyectoConstructora;
/
CREATE OR REPLACE PACKAGE BODY adm_person.ldc_BCProyectoConstructora IS

    ------------------------------------------------------------------------------------------------
    -- Datos de paquete
    ------------------------------------------------------------------------------------------------
    csbPaquete VARCHAR2(30) := 'ldc_BCProyectoConstructora';

    ------------------------------------------------------------------------------------------------
    -- Errores
    ------------------------------------------------------------------------------------------------
    cnuDescripcionError NUMBER := 2741; -- Descripcion del error

    PROCEDURE proValidaLocalidadDireccion(inuDireccion ab_address.address_id%TYPE, -- Direccion
                                          inuLocalidad ge_geogra_location.geograp_location_id%TYPE -- Localidad
                                          ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proValidaLocalidadDireccion
        Descripción:        Valida que la dirección pertenezca a la localidad

        Autor    : Sandra Muñoz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Muñoz           Creación
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proValidaLocalidadDireccion';
        nuPaso    NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        exError EXCEPTION; -- Error controlado
        nuLocalidadDireccion ab_address.geograp_location_id%TYPE; -- Localidad de la dirección ingresada
        sbDireccion          ab_address.address_parsed%TYPE; -- Dirección parseada
        sbLocalidadDireccion ge_geogra_location.description%TYPE; -- Descripción de la localidad de la dirección que ingresa por parámetro
        sbLocalidadParametro ge_geogra_location.description%TYPE; -- Descripción de la localidad que ingresa por parámetro

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        BEGIN
            SELECT aa.geograp_location_id,
                   aa.address_parsed
            INTO   nuLocalidadDireccion,
                   sbDireccion
            FROM   ab_address aa
            WHERE  aa.address_id = inuDireccion;
        EXCEPTION
            WHEN no_data_found THEN
                sbError := 'No se encontró la dirección ' || inuDireccion;
                RAISE exError;
        END;

        BEGIN
            SELECT gl.description
            INTO   sbLocalidadParametro
            FROM   ge_geogra_location gl
            WHERE  gl.geograp_location_id = inuLocalidad;
        EXCEPTION
            WHEN no_data_found THEN
                sbError := 'No se encontró la localidad ' || inuLocalidad;
                RAISE exError;
        END;

        SELECT ggl.description
        INTO   sbLocalidadDireccion
        FROM   ge_geogra_location ggl
        WHERE  ggl.geograp_location_id = nuLocalidadDireccion;

        IF nuLocalidadDireccion <> inuLocalidad THEN
            sbError := 'La dirección ' || sbDireccion || ' no está asociada a la localidad ' ||
                       nuLocalidadDireccion || ' - ' || sbLocalidadDireccion;
            RAISE exError;
        END IF;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    PROCEDURE proDatosCliente(inuCliente            ge_subscriber.subscriber_id%TYPE, -- Código del cliente
                              onuTipoIdentificacion OUT ge_identifica_type.ident_type_id%TYPE, -- Tipo de identificación
                              osbNroIdentificacion  OUT ge_subscriber.identification%TYPE, -- Número de identificación
                              osbNombre             OUT VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDatosCliente
        Descripción:        Datos del cliente

        Autor    : Sandra Muñoz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proDatosCliente';
        nuPaso    NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000); -- Error
        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        -- Datos del cliente
        BEGIN
            SELECT gs.identification,
                   gs.subscriber_name || ' ' || gs.subs_last_name,
                   gs.ident_type_id
            INTO   osbNroIdentificacion,
                   osbNombre,
                   onuTipoIdentificacion
            FROM   ge_subscriber gs
            WHERE  gs.subscriber_id = inuCliente;
        EXCEPTION
            WHEN no_data_found THEN
                sbError := 'No se encuentra el cliente con código ' || inuCliente;
                RAISE exError;
        END;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    PROCEDURE proExisteProyecto(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE -- Proyecto
                                ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proExisteProyecto
        Descripción:        Valida si existe un proyecto

        Autor    : Sandra Muñoz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Muñoz           Creación
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proExisteProyecto';
        nuPaso    NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        nuExiste  NUMBER; -- Evalúa si un elemento existe
        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        BEGIN
            SELECT 1
            INTO   nuExiste
            FROM   ldc_proyecto_constructora lpc
            WHERE  lpc.id_proyecto = inuProyecto;
        EXCEPTION
            WHEN no_data_found THEN
                sbError := 'No se encuentra el proyecto ' || inuProyecto;
                RAISE exError;
        END;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    PROCEDURE proExisteTipoUnidad(inuProyecto        ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                  inuTipoUnidPredial ldc_tipo_unid_pred_proy.id_tipo_unid_pred%TYPE -- Tipo de unidad
                                  ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proExisteProyecto
        Descripción:        Valida si existe un proyecto

        Autor    : Sandra Muñoz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Muñoz           Creación
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proExisteTipoUnidad';
        nuPaso    NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        nuExiste  NUMBER; -- Evalúa si un elemento existe
        exError EXCEPTION; -- Error controlado
        sbNombreProyecto ldc_proyecto_constructora.nombre%TYPE; -- Proyecto constructora

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        BEGIN
            SELECT 1
            INTO   nuExiste
            FROM   ldc_tipo_unid_pred_proy ltupp
            WHERE  ltupp.id_proyecto = inuProyecto
            AND    ltupp.id_tipo_unid_pred = inuTipoUnidPredial;
        EXCEPTION
            WHEN no_data_found THEN
                BEGIN
                    SELECT lpc.nombre
                    INTO   sbNombreProyecto
                    FROM   ldc_proyecto_constructora lpc
                    WHERE  lpc.id_proyecto = inuProyecto;
                EXCEPTION
                    WHEN no_data_found THEN
                        sbError := 'No se encuentra el proyecto ' || inuProyecto;
                        RAISE exError;
                END;

                sbError := 'No se encuentra el tipo de unidad ' || inuTipoUnidPredial ||
                           ' definida para el proyecto ' || inuProyecto || '-' || sbNombreProyecto;
                RAISE exError;
        END;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    PROCEDURE proDatosTipoConstruccion(inuTipoConstruccion ldc_tipo_construccion.id_tipo_construccion%TYPE, -- Tipo de construcción
                                       orcTipoConstruccion OUT ldc_tipo_construccion%ROWTYPE, -- Información tipo de construcción
                                       osbError            VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDatosTipoConstruccion
        Descripción:        Tipo de construcción

        Autor    : Sandra Muñoz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Muñoz           Creación
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proDatosTipoConstruccion';
        nuPaso    NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        nuExiste  NUMBER; -- Evalúa si un elemento existe
        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        nuPaso := 10;
        BEGIN
            SELECT *
            INTO   orcTipoConstruccion
            FROM   ldc_tipo_construccion ltc
            WHERE  ltc.id_tipo_construccion = inuTipoConstruccion;
        EXCEPTION
            WHEN no_data_found THEN
                sbError := 'No se encuentra el tipo de construcción ' || inuTipoConstruccion;
                RAISE exError;
        END;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    PROCEDURE proDatosProyecto(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                               orcProyecto OUT ldc_proyecto_constructora%ROWTYPE, -- Datos del proyecto
                               osbError    OUT VARCHAR2 -- Error
                               ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDatosProyecto
        Descripción:        Datos de proyecto

        Autor    : Sandra Muñoz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Muñoz           Creación
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proDatosProyecto';
        nuPaso    NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        nuExiste  NUMBER; -- Evalúa si un elemento existe
        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        BEGIN
            SELECT *
            INTO   orcProyecto
            FROM   ldc_proyecto_constructora lpc
            WHERE  lpc.id_proyecto = inuProyecto;
        EXCEPTION
            WHEN no_data_found THEN
                sbError := 'No se encontró el proyecto ' || inuProyecto;
                RAISE exError;
        END;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    PROCEDURE proDatosProyecto(inuProyecto      ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                               osbNombre        OUT ldc_proyecto_constructora.nombre%TYPE, --nombre,
                               osbObservacion   OUT ldc_proyecto_constructora.descripcion%TYPE, --observacion,
                               onuDireccion     OUT ldc_proyecto_constructora.id_direccion%TYPE, --dir,
                               onuLocalidad     OUT ldc_proyecto_constructora.id_localidad%TYPE, --localidad,
                               onuFechaCreacion OUT ldc_proyecto_constructora.fecha_creacion%TYPE, --fecha de registro,
                               onuFechaUltModif OUT ldc_proyecto_constructora.fech_ult_modif%TYPE, --fecha de última modificación,
                               onuPisos         OUT ldc_proyecto_constructora.cantidad_pisos%TYPE, --cantidad de pisos,
                               onuTorres        OUT ldc_proyecto_constructora.cantidad_torres%TYPE, --torres,
                               onuTiposUnidPred OUT ldc_proyecto_constructora.tipo_construccion%TYPE, --tipos
                               onuTotalAptos    OUT ldc_proyecto_constructora.cant_unid_predial%TYPE, --total de apartamentos
                               onuContrato      OUT ldc_proyecto_constructora.contrato%TYPE, -- contrato y pagaré
                               onuPagare        OUT ldc_proyecto_constructora.pagare%TYPE, -- pagare
                               osbFormaPago     OUT ldc_proyecto_constructora.forma_pago%TYPE, --Forma de Pago
                               onuTipoVivienda  OUT ldc_proyecto_constructora.tipo_vivienda%TYPE, --Tipo Vivienda
                               osbError         OUT VARCHAR2 -- Error
                               ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDatosProyecto
        Descripción:        Datos de proyecto

        Autor    : Sandra Muñoz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        27-04-2017   KCienfuegos            CA200-473: Se agrega el Tipo de Vivienda
        10-05-2016   Sandra Muñoz           Creación
        ******************************************************************/

        sbProceso  VARCHAR2(4000) := 'proDatosProyecto';
        nuPaso     NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        sbError    VARCHAR2(4000);
        nuExiste   NUMBER; -- Evalúa si un elemento existe
        rcProyecto ldc_proyecto_constructora%ROWTYPE; -- Proyecto

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        -- Datos de proyecto
        nuPaso := 10;
        proDatosProyecto(inuproyecto => inuProyecto,
                         orcproyecto => rcProyecto,
                         osberror    => osbError);

        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        -- Llena las variables de salida
        nuPaso           := 20;
        osbNombre        := rcProyecto.Nombre;
        nuPaso           := 30;
        osbObservacion   := rcProyecto.Descripcion;
        nuPaso           := 40;
        onuDireccion     := rcProyecto.Id_Direccion;
        nuPaso           := 50;
        onuLocalidad     := rcProyecto.Id_Localidad;
        nuPaso           := 60;
        onuFechaCreacion := rcProyecto.Fecha_Creacion;
        nuPaso           := 70;
        onuFechaUltModif := rcProyecto.Fech_Ult_Modif;
        nuPaso           := 80;
        onuPisos         := rcProyecto.Cantidad_Pisos;
        nuPaso           := 90;
        onuTorres        := rcProyecto.Cantidad_Torres;
        nuPaso           := 100;
        onuTiposUnidPred := rcProyecto.Cant_Tip_Unid_Pred;
        nuPaso           := 110;
        onuTotalAptos    := rcProyecto.Cant_Unid_Predial;
        nuPaso           := 120;
        onuPagare        := rcProyecto.Pagare;
        nuPaso           := 130;
        onuContrato      := rcProyecto.Contrato;
        nuPaso           := 140;
        osbFormaPago     := rcProyecto.Forma_Pago;
        nuPaso           := 150;
        onuTipoVivienda  := rcProyecto.Tipo_Vivienda;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    PROCEDURE proDatosTipoUnidad(inuProyecto   ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                 inuTipoUnidad ldc_tipo_unid_pred_proy.id_tipo_unid_pred%TYPE, -- Tipo unidad
                                 orcTipoUnidad OUT ldc_tipo_unid_pred_proy%ROWTYPE, -- Datos del tipo de unidad
                                 osbError      OUT VARCHAR2 -- Error
                                 ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDatosTipoUnidad
        Descripción:        Datos de tipo de unidad

        Autor    : Sandra Muñoz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Muñoz           Creación
        ******************************************************************/

        sbProceso          VARCHAR2(4000) := 'proDatosTipoUnidad';
        nuPaso             NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        sbError            VARCHAR2(4000);
        nuExiste           NUMBER; -- Evalúa si un elemento existe
        rcProyecto         ldc_proyecto_constructora%ROWTYPE; -- Proyecto
        rcTipoConstruccion ldc_tipo_construccion%ROWTYPE; -- Tipo de construcción

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        proDatosProyecto(inuproyecto => inuProyecto,
                         orcproyecto => rcProyecto,
                         osberror    => osbError);

        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        BEGIN
            SELECT *
            INTO   orcTipoUnidad
            FROM   ldc_tipo_unid_pred_proy ltupp
            WHERE  ltupp.id_proyecto = inuProyecto
            AND    ltupp.id_tipo_unid_pred = inuTipoUnidad;
        EXCEPTION
            WHEN no_data_found THEN
                sbError := 'No se encontró el tipo de unidad ' || inuTipoUnidad ||
                           ' para el proyecto ' || inuProyecto;
                RAISE exError;
        END;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN ex.Controlled_error THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            RAISE ex.Controlled_error;
        WHEN OTHERS THEN
            sbError := 'TERMINÿ CON ERROR NO CONTROLADO  ' || csbPaquete || '.' || sbProceso || '(' ||
                       nuPaso || '): ' || SQLCODE;
            ut_trace.trace(sbError);
            RAISE ex.Controlled_error;
    END;

    PROCEDURE proDatosPiso(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                           inuPiso     ldc_piso_proyecto.id_piso%TYPE, -- Tipo unidad
                           orcPiso     OUT ldc_piso_proyecto%ROWTYPE, -- Datos del piso
                           osbError    OUT VARCHAR2 -- Error
                           ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDatosPiso
        Descripción:        Datos de tipo de unidad

        Autor    : Sandra Muñoz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Muñoz           Creación
        ******************************************************************/

        sbProceso          VARCHAR2(4000) := 'proDatosPiso';
        nuPaso             NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        sbError            VARCHAR2(4000);
        nuExiste           NUMBER; -- Evalúa si un elemento existe
        rcProyecto         ldc_proyecto_constructora%ROWTYPE; -- Datos del proyecto
        rcTipoConstruccion ldc_tipo_construccion%ROWTYPE; -- Tipo de construcción

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        nuPaso := 10;

        proDatosProyecto(inuproyecto => inuProyecto,
                         orcproyecto => rcProyecto,
                         osberror    => osbError);

        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        nuPaso := 20;

        proDatosTipoConstruccion(inutipoconstruccion => rcProyecto.Tipo_Construccion,
                                 orctipoconstruccion => rcTipoConstruccion,
                                 osberror            => osbError);

        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        nuPaso := 30;

        BEGIN
            SELECT *
            INTO   orcPiso
            FROM   ldc_piso_proyecto lpp
            WHERE  lpp.id_proyecto = inuProyecto
            AND    lpp.id_piso = inuPiso;
        EXCEPTION
            WHEN no_data_found THEN
                sbError := 'No se encontró el(la) ' || lower(rcTipoConstruccion.Desc_Pisos) || ' ' ||
                           inuPiso || ' para el proyecto ' || inuProyecto || ' - ' ||
                           rcProyecto.Nombre;
                RAISE exError;
        END;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    PROCEDURE proDatosTorre(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                            inuTorre    ldc_torres_proyecto.id_torre%TYPE, -- Torre
                            orcTorre    OUT ldc_torres_proyecto%ROWTYPE, -- Datos de la torre
                            osbError    OUT VARCHAR2 -- Error
                            ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDatosTorre
        Descripción:        Datos de la torre

        Autor    : Sandra Muñoz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Muñoz           Creación
        ******************************************************************/

        sbProceso          VARCHAR2(4000) := 'proDatosTorre';
        nuPaso             NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        sbError            VARCHAR2(4000);
        nuExiste           NUMBER; -- Evalúa si un elemento existe
        rcProyecto         ldc_proyecto_constructora%ROWTYPE; -- Datos del proyecto
        rcTipoConstruccion ldc_tipo_construccion%ROWTYPE; -- Tipo de construcción

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        nuPaso := 10;

        proDatosProyecto(inuproyecto => inuProyecto,
                         orcproyecto => rcProyecto,
                         osberror    => osbError);

        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        nuPaso := 20;

        proDatosTipoConstruccion(inutipoconstruccion => rcProyecto.Tipo_Construccion,
                                 orctipoconstruccion => rcTipoConstruccion,
                                 osberror            => osbError);

        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        nuPaso := 30;

        BEGIN
            SELECT *
            INTO   orcTorre
            FROM   ldc_torres_proyecto ltp
            WHERE  ltp.id_proyecto = inuProyecto
            AND    ltp.id_torre = inuTorre;
        EXCEPTION
            WHEN no_data_found THEN
                sbError := 'No se encontró el(la) ' || lower(rcTipoConstruccion.Desc_Torre) || ' ' ||
                           inuTorre || ' para el proyecto ' || inuProyecto || ' - ' ||
                           rcProyecto.Nombre;
                RAISE exError;
        END;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    PROCEDURE proDatosUnidPredial(inuUnidadPredial ldc_unidad_predial.id_unidad_predial%TYPE, -- Unidad predial
                                  inuPiso          ldc_unidad_predial.id_piso%TYPE, -- Piso
                                  inuTorre         ldc_unidad_predial.id_torre%TYPE, -- Torre
                                  inuProyecto      ldc_unidad_predial.id_proyecto%TYPE, -- Proyecto
                                  osbError         OUT VARCHAR2 -- Error
                                  ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDatosUnidPredial
        Descripción:        Obtiene los datos de una unidad predial

        Autor    : Sandra Muñoz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Muñoz           Creación
        ******************************************************************/

        sbProceso       VARCHAR2(4000) := 'proDatosUnidPredial';
        nuPaso          NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        rcUnidadPredial ldc_unidad_predial%ROWTYPE; -- Unidad predial
        rcPiso          ldc_piso_proyecto%ROWTYPE; -- Piso
        rcTorre         ldc_torres_proyecto%ROWTYPE; -- Torre

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        -- Validar datos existentes
        ldc_bcProyectoConstructora.proDatosPiso(inuproyecto => inuProyecto,
                                                inupiso     => inuPiso,
                                                orcpiso     => rcPiso,
                                                osberror    => osbError);

        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        ldc_bcProyectoConstructora.proDatosTorre(inuProyecto => inuProyecto,
                                                 inuTorre    => inuTorre,
                                                 orcTorre    => rcTorre,
                                                 osberror    => osbError);

        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        BEGIN
            SELECT *
            INTO   rcUnidadPredial
            FROM   ldc_unidad_predial lup
            WHERE  lup.id_unidad_predial = inuUnidadPredial
            AND    lup.id_proyecto = inuProyecto
            AND    lup.id_piso = inuPiso
            AND    lup.id_torre = inuTorre;
        EXCEPTION
            WHEN no_data_found THEN
                osbError := 'No se encontró la unidad predial ' || inuUnidadPredial;
                RAISE exError;
        END;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           OsbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => OsbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    FUNCTION fblTieneCotizaciones(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE -- Proyecto
                                  ) RETURN BOOLEAN IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: fblTieneCotizaciones
        Descripción:        Indica si el proyecto tiene cotizaciones asociadas

        Autor    : Sandra Muñoz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Muñoz           Creación
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proInsertarMantenimientoNota';
        nuPaso    NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        nuExiste  NUMBER; -- Evalúa si un elemento existe
        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        SELECT COUNT(1)
        INTO   nuExiste
        FROM   ldc_cotizacion_construct lcc
        WHERE  lcc.id_proyecto = inuProyecto;

        IF nuExiste = 0 THEN
            RETURN FALSE;
        END IF;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);

        RETURN TRUE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    FUNCTION fcrMetrajesXPiso(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE -- Proyecto
                              ) RETURN PKCONSTANTE.TYREFCURSOR IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: fcrMetrajesXPiso
        Descripción:        Devuelve los metrajes por piso

        Autor    : Sandra Muñoz

        Fecha    : 15-04-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        sbProceso  VARCHAR2(4000) := 'fcrMetrajesXPiso';
        nuPaso     NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        crMetrajes PKCONSTANTE.TYREFCURSOR;
        sbError    VARCHAR2(4000); -- Error

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        -- Consulta cursor referenciado
        OPEN crMetrajes FOR
            SELECT lmp.id_piso,
                   pp.descripcion,
                   lmp.long_bajante,
                   lmp.id_proyecto
            FROM   ldc_metraje_piso  lmp,
                   ldc_piso_proyecto pp
            WHERE  lmp.id_proyecto = inuProyecto
            AND    pp.id_piso = lmp.id_piso
            AND    pp.id_proyecto = lmp.id_proyecto
            ORDER  BY lmp.id_piso;

        RETURN crMetrajes;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    FUNCTION fcrMetrajesXTipoUnid(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE -- Proyecto
                                  ) RETURN PKCONSTANTE.TYREFCURSOR IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: fcrMetrajesXTipoUnid
        Descripción:        Devuelve los metrajes por tipo de unidad predial

        Autor    : Sandra Muñoz

        Fecha    : 15-04-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Muñoz           Creación
        ******************************************************************/

        sbProceso  VARCHAR2(4000) := 'fcrMetrajesXTipoUnid';
        nuPaso     NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        crMetrajes PKCONSTANTE.TYREFCURSOR;
        sbError    VARCHAR2(4000); -- Error

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        -- Consulta cursor referenciado
        OPEN crMetrajes FOR
            SELECT tipo_unid_predial,
                   tu.descripcion,
                   tu.id_proyecto,
                   flauta,
                   horno,
                   bbq,
                   estufa,
                   secadora,
                   calentador,
                   long_val_bajante,
                   long_bajante_tabl,
                   long_tablero
            FROM   ldc_metraje_tipo_unid_pred lmtup,
                   ldc_tipo_unid_pred_proy    tu
            WHERE  lmtup.id_proyecto = inuProyecto
            AND    tu.id_proyecto = lmtup.id_proyecto
            AND    tu.id_tipo_unid_pred = lmtup.tipo_unid_predial
            ORDER  BY lmtup.tipo_unid_predial;

        RETURN crMetrajes;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN ex.Controlled_error THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            RAISE ex.Controlled_error;
        WHEN OTHERS THEN
            sbError := 'TERMINÿ CON ERROR NO CONTROLADO  ' || csbPaquete || '.' || sbProceso || '(' ||
                       nuPaso || '): ' || SQLCODE;
            ut_trace.trace(sbError);
            RAISE ex.Controlled_error;
    END;

    FUNCTION fnuUnidadesPorPisoYTipo(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                     inuPiso     ldc_piso_proyecto.id_piso%TYPE, --piso
                                     inuTipo     ldc_tipo_unid_pred_proy.id_tipo_unid_pred%TYPE --tipo
                                     ) RETURN NUMBER IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: fnuUnidadesPorPisoYTipo
        Descripción:        Obtiene el número de unidades prediales por piso y tipo

        Autor    : KCienfuegos
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        10-05-2016   KCienfuegos          Creación
        ******************************************************************/

        sbProceso  VARCHAR2(4000) := 'fnuUnidadesPorPisoYTipo';
        nuPaso     NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        sbError    VARCHAR2(4000);
        nuContador NUMBER; -- Evalúa si un elemento existe
        exError EXCEPTION; -- Error controlado
        nuTorres NUMBER := 0;

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        SELECT COUNT(*)
        INTO   nuContador
        FROM   ldc_unidad_predial up
        WHERE  up.id_proyecto = inuProyecto
        AND    up.id_piso = inuPiso
        AND    up.id_tipo_unid_pred = inuTipo;

        SELECT COUNT(*)
        INTO   nuTorres
        FROM   ldc_torres_proyecto tp
        WHERE  tp.id_proyecto = inuProyecto;

        IF (nuTorres = 0) THEN
            nuTorres := 1;
        END IF;

        nuContador := nuContador / nuTorres;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);

        RETURN nuContador;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    FUNCTION fnuUnidadesPorTorre(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE) RETURN NUMBER IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: fnuUnidadesPorPisoYTipo
        Descripción:        Obtiene el número de unidades prediales por piso y tipo

        Autor    : KCienfuegos
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        10-05-2016   KCienfuegos          Creación
        ******************************************************************/
        sbProceso  VARCHAR2(4000) := 'fnuUnidadesPorTorre';
        sbError    VARCHAR2(4000);
        nuTorres   NUMBER := 0;
        nuCantUnit NUMBER := 0;
        nuPaso     NUMBER;

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        nuCantUnit := daldc_proyecto_constructora.fnuGetCANT_UNID_PREDIAL(inuID_PROYECTO => inuProyecto);

        nuTorres := daldc_proyecto_constructora.fnuGetCANTIDAD_TORRES(inuID_PROYECTO => inuProyecto);

        nuCantUnit := nuCantUnit / nuTorres;
        nuCantUnit := nvl(nuCantUnit, 0);

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);

        RETURN nuCantUnit;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    FUNCTION fblProyectoConVenta(inuProyecto ldc_cuotas_proyecto.id_proyecto%TYPE -- Proyecto
                                 ) RETURN BOOLEAN IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: fblProyectoConVenta
        Descripción:        Devuelve valor booleano indicando si al proyecto
                            ya se le realizó la venta

        Autor    : KCienfuegos
        Fecha    : 23-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        23-06-2016   KCienfuegos           Creación
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'fblProyectoConVenta';
        nuPaso    NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        nuVenta   ldc_proyecto_constructora.id_solicitud%TYPE;

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso, 10);

        daldc_proyecto_constructora.AccKey(inuProyecto);
        nuVenta := daldc_proyecto_constructora.fnuGetID_SOLICITUD(inuID_PROYECTO => inuProyecto);

        IF nuVenta IS NULL THEN
          RETURN FALSE;
        END IF;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso, 10);

        RETURN TRUE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    FUNCTION fblProyConVentaAprob(inuProyecto ldc_cuotas_proyecto.id_proyecto%TYPE -- Proyecto
                                 ) RETURN BOOLEAN IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: fblProyConVentaAprob
        Descripción:        Devuelve valor booleano indicando si la venta asociada al proyecto
                            ya fue aprobada.

        Autor    : KCienfuegos
        Fecha    : 07-06-2017

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        07-06-2017   KCienfuegos           Creación
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'fblProyConVentaAprob';
        nuPaso    NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        nuCont    NUMBER;
        sbError   VARCHAR2(4000);
        nuVenta   ldc_proyecto_constructora.id_solicitud%TYPE;

        CURSOR cuVentaAprob IS
          SELECT COUNT(1)
            FROM cc_quotation c
           WHERE c.package_id = nuVenta
             AND c.status IN('A','C');

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso, 10);

        daldc_proyecto_constructora.AccKey(inuProyecto);
        nuVenta := daldc_proyecto_constructora.fnuGetID_SOLICITUD(inuID_PROYECTO => inuProyecto);

        OPEN  cuVentaAprob;
        FETCH cuVentaAprob INTO nuCont;
        CLOSE cuVentaAprob;

        IF nuCont > 0 THEN
          RETURN TRUE;
        END IF;

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso, 10);

        RETURN FALSE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proPlantilla(nuDato NUMBER) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:
        Descripción:

        Autor    : Sandra Muñoz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Muñoz           Creación
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proInsertarMantenimientoNota';
        nuPaso    NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        nuExiste  NUMBER; -- Evalúa si un elemento existe
        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            dbms_output.put_line('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' ||
                                 nuPaso || '):' || sbError);
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbError);

        WHEN OTHERS THEN
            sbError := 'TERMINÿ CON ERROR NO CONTROLADO  ' || csbPaquete || '.' || sbProceso || '(' ||
                       nuPaso || '): ' || SQLERRM;
            ut_trace.trace(sbError);
            dbms_output.put_line(sbError);
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbError);
    END;

    PROCEDURE proPlantilla_Intermedio(nuDato   NUMBER,
                                      osbError OUT VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:
        Descripción:

        Autor    : Sandra Muñoz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Muñoz           Creación
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proInsertarMantenimientoNota';
        nuPaso    NUMBER; -- ÿltimo paso ejecutado antes de ocurrir el error

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN exError THEN
            ut_trace.trace('TERMINÿ CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           osbError);
        WHEN OTHERS THEN
            osbError := 'TERMINÿ CON ERROR NO CONTROLADO  ' || csbPaquete || '.' || sbProceso || '(' ||
                        nuPaso || '): ' || SQLCODE;
            ut_trace.trace(osbError);
    END;

END ldc_BCProyectoConstructora;
/
PROMPT Otorgando permisos de ejecucion a LDC_BCPROYECTOCONSTRUCTORA
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BCPROYECTOCONSTRUCTORA', 'ADM_PERSON');
END;
/