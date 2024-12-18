CREATE OR REPLACE PACKAGE adm_person.ldc_BOProyectoConstructora IS

    PROCEDURE proCreaProyecto(inuProyectoOrigen   ldc_proyecto_constructora.id_proyecto_origen%TYPE DEFAULT NULL, -- Proyecto origen
                              isbNombre           ldc_proyecto_constructora.nombre%TYPE, -- Nombre proyecto
                              isbDescripcion      ldc_proyecto_constructora.descripcion%TYPE, -- Descripcion
                              inuCliente          ldc_proyecto_constructora.cliente%TYPE, -- Cliente
                              inuTipoConstruccion ldc_proyecto_constructora.tipo_construccion%TYPE, -- Tipo de construccion
                              inuCantPisos        ldc_proyecto_constructora.cantidad_pisos%TYPE, -- Cantidad de pisos
                              inuCantTorres       ldc_proyecto_constructora.cantidad_torres%TYPE, -- Cantidad de torres
                              inuCantTipUnidPred  ldc_proyecto_constructora.cant_tip_unid_pred%TYPE, -- Cantidad tipos unidad predial
                              inuLocalidad        ldc_proyecto_constructora.id_localidad%TYPE DEFAULT NULL, -- Localidad
                              inuDireccion        ldc_proyecto_constructora.id_direccion%TYPE DEFAULT NULL, -- Direccion
                              inuTipoVivienda     ldc_proyecto_constructora.tipo_vivienda%TYPE, -- Tipo de Vivienda
                              onuProyecto         OUT ldc_proyecto_constructora.id_proyecto%TYPE -- Codigo proyecto generado
                              );

    PROCEDURE proCreaDefinicionProyecto(inuProyecto         ldc_piso_proyecto.id_proyecto%TYPE, -- Proyecto
                                        inuTipoConstruccion ldc_tipo_construccion.id_tipo_construccion%TYPE, -- Tipo construccion
                                        inuCantPisos        NUMBER, -- Cantidad de pisos
                                        inuCantTipUnidPred  NUMBER, -- Tipo de unidad por ejemplo: Apartamento tipo 1, apartamento tipo 2
                                        inuCantTorres       NUMBER, -- Cantidad de torres
                                        osbError            OUT VARCHAR2 -- Error
                                        );

    PROCEDURE proCopiaProyecto(inuProyectoOrigen   ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto origen
                               onuProyectoNuevo    OUT ldc_proyecto_constructora.id_proyecto%TYPE -- Proyecto creado
                               );

    PROCEDURE proCreaUnidadesPrediales(inuProyecto     ldc_unidad_predial.id_proyecto%TYPE, -- Proyecto
                                       inuPiso         ldc_unidad_predial.id_piso%TYPE, -- Piso
                                       inuCantTorres   ldc_unidad_predial.id_torre%TYPE, -- Torre
                                       inuTipoUnidad   ldc_unidad_predial.id_tipo_unid_pred%TYPE, -- Tipo unidad
                                       inuCantUnidades NUMBER -- Cantidad de unidades a crear
                                       );

    PROCEDURE proCreaMetrajeXTipoUnidPredial(inuProyecto        ldc_metraje_tipo_unid_pred.id_proyecto%TYPE, -- Proyecto
                                             inuTipoUnidPredial ldc_metraje_tipo_unid_pred.tipo_unid_predial%TYPE, -- Tipo unidad predial
                                             inuFlauta          ldc_metraje_tipo_unid_pred.flauta%TYPE, -- Flauta
                                             inuHorno           ldc_metraje_tipo_unid_pred.horno%TYPE, -- Horno
                                             inuBbq             ldc_metraje_tipo_unid_pred.bbq%TYPE, -- Bbq
                                             inuEstufa          ldc_metraje_tipo_unid_pred.estufa%TYPE, -- Estufa
                                             inuSecadora        ldc_metraje_tipo_unid_pred.secadora%TYPE, -- Secadora
                                             inuCalentador      ldc_metraje_tipo_unid_pred.calentador%TYPE, -- Calentador
                                             inuLongValBajante  ldc_metraje_tipo_unid_pred.long_val_bajante%TYPE, -- Longitud valor bajante
                                             inuLongBajanteTabl ldc_metraje_tipo_unid_pred.long_bajante_tabl%TYPE, -- Longitud bajante al tablero
                                             inuLongTablero     ldc_metraje_tipo_unid_pred.long_tablero%TYPE -- Longitud tblero
                                             );

    PROCEDURE proCreaMetrajeXpiso(inuPiso        ldc_metraje_piso.id_piso%TYPE, -- Piso
                                  inuProyecto    ldc_metraje_piso.id_proyecto%TYPE, -- Proyecto
                                  inuLongBajante ldc_metraje_piso.long_bajante%TYPE -- Longitud del bajand
                                  );

    PROCEDURE proModifDatosBasicosProyecto(inuProyecto    ldc_metraje_piso.id_proyecto%TYPE, -- Proyecto
                                           isbNombre           ldc_proyecto_constructora.nombre%TYPE, -- Nombre proyecto
                                           isbDescripcion      ldc_proyecto_constructora.descripcion%TYPE, -- Descripcion
                                           inuLocalidad        ldc_proyecto_constructora.id_localidad%TYPE DEFAULT NULL, -- Localidad
                                           isbFormaPago        ldc_proyecto_constructora.forma_pago%TYPE, --Forma de pago
                                           inuDireccion        ldc_proyecto_constructora.id_direccion%TYPE DEFAULT NULL, -- Direccion
                                           inuTipoVivienda     ldc_proyecto_constructora.tipo_vivienda%TYPE -- Tipo de Vivienda
                                           );

    PROCEDURE proModifDefinicionProyecto(inuProyecto    ldc_metraje_piso.id_proyecto%TYPE,
                                         inuCantTorres  ldc_proyecto_constructora.cantidad_torres%TYPE,
                                         inuCantPisos   ldc_proyecto_constructora.cantidad_pisos%TYPE,
                                         inuCantTipo    ldc_proyecto_constructora.cant_tip_unid_pred %TYPE DEFAULT NULL,
                                         inuCantUnid    ldc_proyecto_constructora.cant_unid_predial%TYPE DEFAULT NULL
                                         );

    PROCEDURE proModifMetrajeXpiso(inuProyecto    ldc_metraje_piso.id_proyecto%TYPE, -- Proyecto
                                   inuPiso        ldc_metraje_piso.id_piso%TYPE, -- Piso
                                   inuLongBajante ldc_metraje_piso.long_bajante%TYPE -- Longitud del bajand
                                   );

    PROCEDURE proModifMetrajXTipoUnidPredial(inuProyecto            ldc_detalle_met_cotiz.id_proyecto%TYPE, -- Proyecto
                                              inuTipo                ldc_detalle_met_cotiz.id_tipo%TYPE, -- Tipo
                                              inuFlauta              ldc_detalle_met_cotiz.flauta%TYPE, -- Flauta
                                              inuHorno               ldc_detalle_met_cotiz.horno%TYPE, -- Horno
                                              inuBBQ                 ldc_detalle_met_cotiz.bbq%TYPE, -- BBQ
                                              inuEstufa              ldc_detalle_met_cotiz.estufa%TYPE, -- Estufa
                                              inuSecadora            ldc_detalle_met_cotiz.secadora%TYPE, -- Secadora
                                              inuCalentador          ldc_detalle_met_cotiz.calentador%TYPE, -- Calentador
                                              inuLongValBaj          ldc_detalle_met_cotiz.long_val_baj%TYPE, -- LongValVaj
                                              inuLongBajTab          ldc_detalle_met_cotiz.long_baj_tab%TYPE, -- LongBajTab
                                              inuLongTablero         ldc_detalle_met_cotiz.long_tablero%TYPE -- LongTablero
                                              );

    PROCEDURE proModificaContratoYPagare(inuProyecto    ldc_metraje_piso.id_proyecto%TYPE, -- Proyecto
                                         isbContrato    ldc_proyecto_constructora.contrato%TYPE, -- Contrato
                                         isbPagare      ldc_proyecto_constructora.pagare%TYPE --Pagare
                                         );

    PROCEDURE proBorraProyecto(inuProyecto   ldc_proyecto_constructora.id_proyecto%TYPE -- Proyecto
                               );

END ldc_BOProyectoConstructora;
/
CREATE OR REPLACE PACKAGE BODY adm_person.ldc_BOProyectoConstructora IS

    ------------------------------------------------------------------------------------------------
    -- Datos de paquete
    ------------------------------------------------------------------------------------------------
    gsbPaquete VARCHAR2(30) := 'ldc_BOProyectoConstructora';
    cnuDescriptionError      CONSTANT NUMBER := 2741;
    cnuNullValue             CONSTANT NUMBER := 2126;
    csbEntregaConstructora   CONSTANT VARCHAR2(100) := 'CRM_VTA_KCM_200162_3';

    PROCEDURE proCreaIdentificacionProyecto(inuProyectoOrigen   ldc_piso_proyecto.id_proyecto%TYPE DEFAULT NULL, -- Proyecto origen
                                            isbNombre           ldc_proyecto_constructora.nombre%TYPE, -- Nombre proyecto
                                            isbDescripcion      ldc_proyecto_constructora.descripcion%TYPE, -- Descripcion
                                            inuCliente          ldc_proyecto_constructora.cliente%TYPE, -- Cliente
                                            inuTipoConstruccion ldc_proyecto_constructora.tipo_construccion%TYPE, -- Tipo de construccion
                                            inuCantPisos        ldc_proyecto_constructora.cantidad_pisos%TYPE, -- Cantidad de pisos
                                            inuCantTorres       ldc_proyecto_constructora.cantidad_torres%TYPE, -- Cantidad de torres
                                            inuCantTipUnidPred  ldc_proyecto_constructora.cant_tip_unid_pred%TYPE, -- Cantidad tipos unidad predial
                                            inuLocalidad        ldc_proyecto_constructora.id_localidad%TYPE DEFAULT NULL, -- Localidad
                                            inuDireccion        ldc_proyecto_constructora.id_direccion%TYPE DEFAULT NULL, -- Direccion
                                            inuTipoVivienda     ldc_proyecto_constructora.tipo_vivienda%TYPE, -- Tipo de Vivienda
                                            onuProyecto         OUT ldc_proyecto_constructora.id_proyecto%TYPE, -- Codigo del proyecto
                                            osbError            OUT VARCHAR2 -- Error
                                            ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaProyecto
        Descripcion:        Crear un proyecto

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        26-04-2017   KCienfuegos            Se modifica para registrar el tipo de vivienda
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/
        sbProceso                   VARCHAR2(4000) := 'proCreaIdentificacionProyecto';
        nuPaso                      NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcLdc_Proyecto_Constructora DALDC_PROYECTO_CONSTRUCTORA.styLDC_PROYECTO_CONSTRUCTORA; -- Datos del proyecto
        sbError                     VARCHAR2(4000);

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 10);

        nuPaso := 10;

        onuProyecto := seq_ldc_proyecto_constructora.nextval;

        rcLdc_Proyecto_Constructora.id_proyecto := onuProyecto;

        nuPaso                             := 20;
        rcLdc_Proyecto_Constructora.nombre := isbNombre;

        nuPaso                                  := 30;
        rcLdc_Proyecto_Constructora.descripcion := isbDescripcion;

        nuPaso                              := 40;
        rcLdc_Proyecto_Constructora.cliente := inuCliente;

        nuPaso                                     := 50;
        rcLdc_Proyecto_Constructora.fecha_creacion := SYSDATE;

        nuPaso                                        := 60;
        rcLdc_Proyecto_Constructora.tipo_construccion := inuTipoConstruccion;

        nuPaso                                     := 70;
        rcLdc_Proyecto_Constructora.cantidad_pisos := inuCantPisos;

        nuPaso                                      := 80;
        rcLdc_Proyecto_Constructora.cantidad_torres := inuCantTorres;

        nuPaso                                         := 90;
        rcLdc_Proyecto_Constructora.cant_tip_unid_pred := inuCantTipUnidPred;

        nuPaso                                   := 100;
        rcLdc_Proyecto_Constructora.usu_creacion := USER;

        nuPaso                                         := 110;
        rcLdc_Proyecto_Constructora.id_proyecto_origen := inuProyectoOrigen;

        nuPaso                                   := 120;
        rcLdc_Proyecto_Constructora.id_localidad := inuLocalidad;

        nuPaso                                   := 120;
        rcLdc_Proyecto_Constructora.id_direccion := inuDireccion;

        nuPaso                                   := 130;
        rcLdc_Proyecto_Constructora.tipo_vivienda := inuTipoVivienda;

        nuPaso := 140;
        daldc_proyecto_constructora.insrecord(ircldc_proyecto_constructora => rcLdc_Proyecto_Constructora);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescriptionError,
                            isbargument     => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    PROCEDURE proCreaDefinicionProyecto(inuProyecto         ldc_piso_proyecto.id_proyecto%TYPE, -- Proyecto
                                        inuTipoConstruccion ldc_tipo_construccion.id_tipo_construccion%TYPE, -- Tipo construccion
                                        inuCantPisos        NUMBER, -- Cantidad de pisos
                                        inuCantTipUnidPred  NUMBER, -- Tipo de unidad por ejemplo: Apartamento tipo 1, apartamento tipo 2
                                        inuCantTorres       NUMBER, -- Cantidad de torres
                                        osbError            OUT VARCHAR2 -- Error
                                        ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:     proCreaDefinicionProyecto
        Descripcion:            Crea los pisos, torres, tipos de unidad de un proyecto

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso          VARCHAR2(4000) := 'proCreaDefinicionProyecto';
        nuPaso             NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcTipoConstruccion ldc_tipo_construccion%ROWTYPE; -- Tipo de construccion
        rcProyecto         ldc_proyecto_constructora%ROWTYPE; -- Proyecto
        rcPiso             daLDC_PISO_PROYECTO.styLDC_PISO_PROYECTO; -- Registro piso
        rcTorre            daLDC_TORRES_PROYECTO.styLDC_TORRES_PROYECTO; -- Registro piso
        rcTipoUnidades     daLDC_TIPO_UNID_PRED_PROY.styLDC_TIPO_UNID_PRED_PROY; -- Tipos de unidades prediales
        sbError            VARCHAR2(4000);

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 10);

        -- Obtener los datos del proyecto
        nuPaso := 10;
        ldc_bcProyectoConstructora.proDatosProyecto(inuproyecto => inuProyecto,
                                                    orcproyecto => rcProyecto,
                                                    osbError    => osbError);
        IF osbError IS NOT NULL THEN
            RAISE ex.Controlled_Error;
        END IF;

        -- Obtener los datos del tipo de construccion
        nuPaso := 20;
        ldc_bcProyectoConstructora.proDatosTipoConstruccion(inuTipoConstruccion => inuTipoConstruccion,
                                                            orcTipoConstruccion => rcTipoConstruccion,
                                                            osbError            => osbError);

        IF osbError IS NOT NULL THEN
            RAISE ex.Controlled_Error;
        END IF;

        -- Crear los pisos del proyecto
        nuPaso := 30;
        IF nvl(inuCantPisos, 0) > 0 THEN
            nuPaso             := 40;
            rcPiso.id_proyecto := inuProyecto;

            FOR nuPiso IN 1 .. inuCantPisos LOOP
                nuPaso             := 50;
                rcPiso.id_piso     := nuPiso; --seq_ldc_piso_proyecto.nextval;
                nuPaso             := 60;
                rcPiso.descripcion := rcTipoConstruccion.desc_pisos || ' ' || nuPiso;
                nuPaso             := 70;
                daLDC_PISO_PROYECTO.insRecord(ircldc_piso_proyecto => rcPiso);
            END LOOP;
        END IF;

        -- Crear las torres del proyecto
        nuPaso := 60;
        IF nvl(inuCantTorres, 0) > 0 THEN
            nuPaso              := 80;
            rcTorre.id_proyecto := inuProyecto;
            nuPaso              := 90;
            FOR nuTorre IN 1 .. inuCantTorres LOOP
                nuPaso              := 100;
                rcTorre.id_torre    := nuTorre;
                nuPaso              := 110;
                rcTorre.descripcion := rcTipoConstruccion.desc_torre || ' ' || nuTorre;
                nuPaso              := 120;
                daLDC_TORRES_PROYECTO.insRecord(ircldc_torres_proyecto => rcTorre);
            END LOOP;
        END IF;

        -- Crear los tipos de unidades prediales
        nuPaso := 120;
        IF nvl(inuCantTipUnidPred, 0) > 0 THEN
            nuPaso                     := 130;
            rcTipoUnidades.id_proyecto := inuProyecto;
            nuPaso                     := 140;
            FOR nuTipoUnidPredial IN 1 .. inuCantTipUnidPred LOOP
                nuPaso                           := 150;
                rcTipoUnidades.id_tipo_unid_pred := nuTipoUnidPredial;
                nuPaso                           := 160;
                rcTipoUnidades.descripcion       := rcTipoConstruccion.desc_tipo_unidad || ' ' ||
                                                    nuTipoUnidPredial;
                nuPaso                           := 170;
                daLDC_TIPO_UNID_PRED_PROY.insRecord(ircldc_tipo_unid_pred_proy => rcTipoUnidades);
            END LOOP;

        END IF;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescriptionError,
                            isbargument     => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    PROCEDURE proCreaProyecto(inuProyectoOrigen   ldc_proyecto_constructora.id_proyecto_origen%TYPE DEFAULT NULL, -- Proyecto origen
                              isbNombre           ldc_proyecto_constructora.nombre%TYPE, -- Nombre proyecto
                              isbDescripcion      ldc_proyecto_constructora.descripcion%TYPE, -- Descripcion
                              inuCliente          ldc_proyecto_constructora.cliente%TYPE, -- Cliente
                              inuTipoConstruccion ldc_proyecto_constructora.tipo_construccion%TYPE, -- Tipo de construccion
                              inuCantPisos        ldc_proyecto_constructora.cantidad_pisos%TYPE, -- Cantidad de pisos
                              inuCantTorres       ldc_proyecto_constructora.cantidad_torres%TYPE, -- Cantidad de torres
                              inuCantTipUnidPred  ldc_proyecto_constructora.cant_tip_unid_pred%TYPE, -- Cantidad tipos unidad predial
                              inuLocalidad        ldc_proyecto_constructora.id_localidad%TYPE DEFAULT NULL, -- Localidad
                              inuDireccion        ldc_proyecto_constructora.id_direccion%TYPE DEFAULT NULL, -- Direccion
                              inuTipoVivienda     ldc_proyecto_constructora.tipo_vivienda%TYPE, -- Tipo de Vivienda
                              onuProyecto         OUT ldc_proyecto_constructora.id_proyecto%TYPE -- Codigo proyecto generado
                              ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaProyecto
        Descripcion:        Crea un proyecto en blanco

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        26-04-2017   KCienfuegos            Se modifica para registrar el tipo de vivienda
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso          VARCHAR2(4000) := 'proCreaProyecto';
        nuPaso             NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError            VARCHAR2(4000);
        nuExiste           NUMBER; -- Elemento
        rcTipoConstruccion ldc_tipo_construccion%ROWTYPE;-- Tipo de construccion

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 10);

        IF(NOT fblaplicaentrega(csbEntregaConstructora))THEN
          sbError := 'El desarrollo '||csbEntregaConstructora||' no esta activo para la gasera';
          RAISE ex.Controlled_Error;
        END IF;

        -- Validar datos obligatorios
        nuPaso := 10;
        IF inuCliente IS NULL THEN
            sbError := 'Falta ingresar el codigo del cliente asociado al proyecto';
            RAISE ex.Controlled_Error;
        END IF;

        nuPaso := 20;
        SELECT COUNT(1) INTO nuExiste FROM ge_subscriber WHERE subscriber_id = inuCliente;

        nuPaso := 30;
        IF nuExiste = 0 THEN
            sbError := 'No existe el cliente con codigo ' || inuCliente;
            RAISE ex.Controlled_Error;
        END IF;

        -- Datos para la descripcion y la validacion de datos obligatorios
        nuPaso := 40;

        ldc_bcProyectoConstructora.proDatosTipoConstruccion(inuTipoConstruccion => inuTipoConstruccion,
                                                            orcTipoConstruccion => rcTipoconstruccion,
                                                            osbError            => sbError);

        IF sbError IS NOT NULL THEN
            RAISE ex.Controlled_Error;
        END IF;

        -- Validar si se ingresaron los datos obligatorios y estos estan correctos
        nuPaso := 50;
        IF rcTipoConstruccion.desc_pisos IS NOT NULL AND inuCantPisos IS NULL THEN
            sbError := 'Para proyectos con tipo de construccion ' ||
                       rcTipoConstruccion.desc_tipo_construcion ||
                       ' se debe indicar la cantidad de ' || lower(rcTipoConstruccion.desc_pisos) || 's';
            RAISE ex.Controlled_Error;
        END IF;

        nuPaso := 60;
        IF rcTipoConstruccion.desc_torre IS NOT NULL AND inuCantTorres IS NULL THEN
            sbError := 'Para proyectos con tipo de construccion ' ||
                       rcTipoConstruccion.desc_tipo_construcion ||
                       ' se debe indicar la cantidad de ' || lower(rcTipoConstruccion.desc_torre) || 's';
            RAISE ex.Controlled_Error;
        END IF;

        nuPaso := 70;
        IF inuCantTipUnidPred IS NULL THEN
            sbError := 'Se debe indicar el tipo de unidad predial';
            RAISE ex.Controlled_Error;
        END IF;

        -- Validar si la localidad y la direccion ingresadas son correctas
        nuPaso := 75;
        IF inuDireccion IS NOT NULL AND inuLocalidad IS NOT NULL THEN
            ldc_BCProyectoConstructora.proValidaLocalidadDireccion(inuDireccion => inuDireccion,
                                                                   inuLocalidad => inuLocalidad);
        END IF;

        -- Registra los datos basicos de un proyecto
        nuPaso := 80;
        proCreaIdentificacionProyecto(inuProyectoOrigen   => inuProyectoOrigen,
                                      isbNombre           => isbNombre,
                                      isbDescripcion      => isbDescripcion,
                                      inuCliente          => inuCliente,
                                      inuTipoConstruccion => inuTipoConstruccion,
                                      inuCantPisos        => inuCantPisos,
                                      inuCantTorres       => inuCantTorres,
                                      inuCantTipUnidPred  => inuCantTipUnidPred,
                                      inuLocalidad        => inuLocalidad,
                                      inuDireccion        => inuDireccion,
                                      inuTipoVivienda     => inuTipoVivienda,
                                      onuProyecto         => onuProyecto,
                                      osbError            => sbError);
        IF sbError IS NOT NULL THEN
            RAISE ex.Controlled_Error;
        END IF;

        -- Crea los pisos, torres, tipos de unidad predial
        nuPaso := 90;
        proCreaDefinicionProyecto(inuProyecto         => onuProyecto,
                                  inuTipoConstruccion => inuTipoConstruccion,
                                  inuCantPisos        => inuCantPisos,
                                  inuCantTipUnidPred  => inuCantTipUnidPred,
                                  inuCantTorres       => inuCantTorres,
                                  osbError            => sbError);

        IF sbError IS NOT NULL THEN
            RAISE ex.Controlled_Error;
        END IF;

        nuPaso := 100;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 10);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            IF(sbError IS NOT NULL) THEN
               ERRORS.SETERROR(inuapperrorcode => cnuDescriptionError,
                               isbargument     => sbError);
            END IF;
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proCreaUnidadesPrediales(inuProyecto     ldc_unidad_predial.id_proyecto%TYPE, -- Proyecto
                                       inuPiso         ldc_unidad_predial.id_piso%TYPE, -- Piso
                                       inuCantTorres   ldc_unidad_predial.id_torre%TYPE, -- Cantidad Torre
                                       inuTipoUnidad   ldc_unidad_predial.id_tipo_unid_pred%TYPE, -- Tipo unidad
                                       inuCantUnidades NUMBER -- Cantidad de unidades a crear
                                       ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaUnidadesPrediales
        Descripcion:        Crea los apartamentos

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proCreaUnidadesPrediales';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);

        rcTipoConstruccion      ldc_tipo_construccion%ROWTYPE; -- Tipo de construccion
        rcPiso                  ldc_piso_proyecto%ROWTYPE; -- Registro piso
        rcTorre                 ldc_torres_proyecto%ROWTYPE; -- Registro piso
        rcTipoUnidades          ldc_tipo_unid_pred_proy%ROWTYPE; -- Tipos de unidades prediales
        rcUnidadPredial         daldc_unidad_predial.styldc_unidad_predial; -- Unidad predial
        rcProyecto              ldc_proyecto_constructora%ROWTYPE; -- Proyecto constructora
        nuUnidad                ldc_unidad_predial.id_unidad_predial%TYPE; -- Consecutivo de la unidad
        nuConsecUnidad          ldc_unidad_predial.id_unidad_predial%TYPE; -- Consecutivo de la unidad
        nuExiste                NUMBER; -- Indica si un elemento existe en la base de datos
        nuCantUnidadesPrediales ldc_proyecto_constructora.cant_unid_predial%TYPE; -- Cantidad de unidades prediales del proyecto

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 10);

        -- Traer los datos del proyecto
        ldc_bcProyectoConstructora.proDatosProyecto(inuProyecto => inuProyecto,
                                                    orcProyecto => rcProyecto,
                                                    osbError    => sbError);

        IF sbError IS NOT NULL THEN
            RAISE ex.Controlled_Error;
        END IF;

        -- Datos para la descripcion y la validacion de datos obligatorios
        nuPaso := 20;
        ldc_bcProyectoConstructora.proDatosTipoConstruccion(inutipoconstruccion => rcProyecto.Tipo_Construccion,
                                                            orctipoconstruccion => rcTipoConstruccion,
                                                            osbError            => sbError);

        IF sbError IS NOT NULL THEN
            RAISE ex.Controlled_Error;
        END IF;

        -- Validar si se ingresaron los datos obligatorios y estos estan correctos
        IF rcTipoConstruccion.desc_pisos IS NOT NULL THEN
            nuPaso := 30;
            IF inuPiso IS NULL THEN
                sbError := 'Para proyectos con tipo de construccion ' ||
                           rcTipoConstruccion.desc_tipo_construcion || ' se debe indicar el(la) ' ||
                           lower(rcTipoConstruccion.desc_pisos);
                RAISE ex.Controlled_Error;
            ELSE
                ldc_bcProyectoConstructora.proDatosPiso(inuproyecto => inuProyecto,
                                                        inupiso     => inuPiso,
                                                        orcpiso     => rcpiso,
                                                        osberror    => sbError);

                IF sbError IS NOT NULL THEN
                    RAISE ex.Controlled_Error;
                END IF;

            END IF;
        END IF;

        nuPaso := 70;
        IF rcTipoConstruccion.desc_torre IS NOT NULL THEN

            nuPaso := 80;
            IF inuCantTorres IS NULL THEN
                sbError := 'Para proyectos con tipo de construccion ' ||
                           rcTipoConstruccion.desc_tipo_construcion || ' se debe indicar el(la) ' ||
                           lower(rcTipoConstruccion.desc_torre);
                RAISE ex.Controlled_Error;
            ELSE
                -- Verificar si la torre existe
                nuPaso := 90;
                SELECT COUNT(1)
                INTO   nuExiste
                FROM   ldc_torres_proyecto ltp
                WHERE  ltp.id_torre = inuCantTorres
                AND    ltp.id_proyecto = inuProyecto;

                nuPaso := 100;
                IF nuExiste = 0 THEN

                    sbError := 'No existe el(la) ' || lower(rcTipoConstruccion.desc_torre) || ' ' ||
                               inuCantTorres || ' definida para el proyecto ' ||
                               rcProyecto.id_proyecto;
                    RAISE ex.Controlled_Error;
                END IF;

            END IF;

        END IF;

        IF inuTipoUnidad IS NULL THEN
            sbError := 'Para proyectos con tipo de construccion ' ||
                       rcTipoConstruccion.desc_tipo_construcion ||
                       ' se debe indicar el tipo de unidad predial';
            RAISE ex.Controlled_Error;
        ELSE

            nuPaso := 120;
            SELECT COUNT(1)
            INTO   nuExiste
            FROM   ldc_tipo_unid_pred_proy ltupp
            WHERE  ltupp.id_tipo_unid_pred = inuTipoUnidad
            AND    ltupp.id_proyecto = inuProyecto;

            IF nuExiste = 0 THEN

                sbError := 'No existe el tipo de unidad ' || inuTipoUnidad ||
                           ' definida para el proyecto ' || rcProyecto.id_proyecto;
                RAISE ex.Controlled_Error;
            END IF;
        END IF;

        -- Crea los apartamentos para las torres
        FOR nuTorre IN 1 .. inuCantTorres LOOP
            -- Datos comunes
            nuPaso                            := 130;
            rcUnidadPredial.id_proyecto       := inuProyecto;
            nuPaso                            := 140;
            rcUnidadPredial.id_tipo_unid_pred := inuTipoUnidad;
            nuPaso                            := 150;
            rcUnidadPredial.id_piso           := inuPiso;
            nuPaso                            := 160;
            rcUnidadPredial.id_torre          := nuTorre;

            -- Obtener el consecutivo del piso
            nuPaso := 170;
            SELECT COUNT(1)
            INTO   nuConsecUnidad
            FROM   ldc_unidad_predial lup
            WHERE  lup.id_proyecto = inuProyecto
            AND    (nvl(lup.id_piso, inuPiso) = inuPiso OR (inuPiso IS NULL))
            AND    (nvl(lup.id_torre, nuTorre) = nuTorre OR (nuTorre IS NULL));

            -- Construir el registro
            nuPaso := 180;
            FOR nuUnidad IN (nuConsecUnidad + 1) .. (inuCantUnidades + nuConsecUnidad) LOOP
                rcUnidadPredial.fech_creacion           := SYSDATE;
                rcUnidadPredial.id_unidad_predial       := nuUnidad; --seq_ldc_unidad_predial.nextval;
                rcUnidadPredial.descripcion             := rcTipoConstruccion.desc_unidad || ' ' ||
                                                           nuUnidad;
                rcUnidadPredial.id_unidad_predial_unico := seq_ldc_unidad_predial.nextval;
                daLDC_UNIDAD_PREDIAL.insRecord(rcUnidadPredial);
            END LOOP;

        END LOOP;

        -- Actualizar el numero de unidades prediales en el proyecto
        nuPaso := 190;
        SELECT COUNT(1)
        INTO   nuCantUnidadesPrediales
        FROM   ldc_unidad_predial lup
        WHERE  lup.id_proyecto = inuProyecto;

        nuPaso := 200;
        UPDATE ldc_proyecto_constructora lpc
        SET    lpc.cant_unid_predial = nucantUnidadesPrediales,
               lpc.usuario_ult_modif = USER,
               lpc.fech_ult_modif = SYSDATE
        WHERE  lpc.id_proyecto = inuProyecto;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 10);


    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescriptionError,
                            isbargument     => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proCreaMetrajeXTipoUnidPredial(inuProyecto        ldc_metraje_tipo_unid_pred.id_proyecto%TYPE, -- Proyecto
                                             inuTipoUnidPredial ldc_metraje_tipo_unid_pred.tipo_unid_predial%TYPE, -- Tipo unidad predial
                                             inuFlauta          ldc_metraje_tipo_unid_pred.flauta%TYPE, -- Flauta
                                             inuHorno           ldc_metraje_tipo_unid_pred.horno%TYPE, -- Horno
                                             inuBbq             ldc_metraje_tipo_unid_pred.bbq%TYPE, -- Bbq
                                             inuEstufa          ldc_metraje_tipo_unid_pred.estufa%TYPE, -- Estufa
                                             inuSecadora        ldc_metraje_tipo_unid_pred.secadora%TYPE, -- Secadora
                                             inuCalentador      ldc_metraje_tipo_unid_pred.calentador%TYPE, -- Calentador
                                             inuLongValBajante  ldc_metraje_tipo_unid_pred.long_val_bajante%TYPE, -- Longitud valor bajante
                                             inuLongBajanteTabl ldc_metraje_tipo_unid_pred.long_bajante_tabl%TYPE, -- Longitud bajante al tablero
                                             inuLongTablero     ldc_metraje_tipo_unid_pred.long_tablero%TYPE -- Longitud tblero
                                             ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaMetrajeXTipoUnidPredial
        Descripcion:        Crea metraje por tipo de unidad predial para el proyecto

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso    VARCHAR2(4000) := 'proCreaMetrajeXTipoUnidPredial';
        nuPaso       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError      VARCHAR2(4000);
        rcMetraje    daLDC_METRAJE_TIPO_UNID_PRED.styLDC_METRAJE_TIPO_UNID_PRED;
        nuExiste     NUMBER; -- Evalua si un elemento existe
        rcProyecto   ldc_proyecto_constructora%ROWTYPE; -- Datos del proyecto
        rcTipoUnidad ldc_tipo_unid_pred_proy%ROWTYPE; -- Datos del tipo de unidad

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 10);

        -- Validacion de datos
        nuPaso := 10;
        ldc_bcProyectoConstructora.proDatosProyecto(inuProyecto => inuproyecto,
                                                    orcProyecto => rcProyecto,
                                                    osbError    => sbError);

        IF sbError IS NOT NULL THEN
            RAISE ex.Controlled_Error;
        END IF;

        nuPaso := 20;
        ldc_bcProyectoConstructora.proDatosTipoUnidad(inuProyecto   => inuproyecto,
                                                      inuTipoUnidad => inutipounidpredial,
                                                      orcTipoUnidad => rcTipoUnidad,
                                                      osbERror      => sbError);

        IF sbError IS NOT NULL THEN
            RAISE ex.Controlled_Error;
        END IF;

        -- Construccion del registro
        nuPaso                      := 30;
        rcMetraje.tipo_unid_predial := inuTipoUnidPredial;
        nuPaso                      := 40;
        rcMetraje.id_proyecto       := inuProyecto;
        nuPaso                      := 50;
        rcMetraje.flauta            := inuFlauta;
        nuPaso                      := 60;
        rcMetraje.horno             := inuHorno;
        nuPaso                      := 70;
        rcMetraje.bbq               := inuBbq;
        nuPaso                      := 80;
        rcMetraje.estufa            := inuEstufa;
        nuPaso                      := 90;
        rcMetraje.secadora          := inuSecadora;
        nuPaso                      := 100;
        rcMetraje.calentador        := inuCalentador;
        nuPaso                      := 110;
        rcMetraje.long_val_bajante  := inuLongValBajante;
        nuPaso                      := 120;
        rcMetraje.long_bajante_tabl := inuLongBajanteTabl;
        nuPaso                      := 130;
        rcMetraje.long_tablero      := inuLongTablero;

        -- Inserta el registro
        nuPaso := 140;
        daldc_METRAJE_TIPO_UNID_PRED.insRecord(ircldc_metraje_tipo_unid_pred => rcMetraje);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescriptionError,
                            isbargument     => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proCreaMetrajeXpiso(inuPiso        ldc_metraje_piso.id_piso%TYPE, -- Piso
                                  inuProyecto    ldc_metraje_piso.id_proyecto%TYPE, -- Proyecto
                                  inuLongBajante ldc_metraje_piso.long_bajante%TYPE -- Longitud del bajand
                                  ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaMetrajeXpiso
        Descripcion:        Crea metraje por tipo de unidad predial para el proyecto

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso  VARCHAR2(4000) := 'proCreaMetrajeXpiso';
        nuPaso     NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError    VARCHAR2(4000);
        rcMetraje  daLDC_METRAJE_PISO.styLDC_METRAJE_PISO;
        nuExiste   NUMBER; -- Evalua si un elemento existe
        rcProyecto ldc_proyecto_constructora%ROWTYPE; -- Datos del proyecto
        rcPiso     ldc_piso_proyecto%ROWTYPE; -- Datos del piso

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 10);

        -- Validacion de datos
        nuPaso := 10;
        ldc_bcProyectoConstructora.proDatosProyecto(inuProyecto => inuproyecto,
                                                    orcProyecto => rcProyecto,
                                                    osbError    => sbError);

        IF sbError IS NOT NULL THEN
            RAISE ex.Controlled_Error;
        END IF;

        nuPaso := 20;
        ldc_bcProyectoConstructora.proDatosPiso(inuProyecto => inuProyecto,
                                                inuPiso     => inuPiso,
                                                orcPiso     => rcPiso,
                                                osbError    => sbError);

        IF sbError IS NOT NULL THEN
            RAISE ex.Controlled_Error;
        END IF;

        -- Construye el registro a insertar
        nuPaso                 := 30;
        rcMetraje.id_piso      := inuPiso;
        nuPaso                 := 40;
        rcMetraje.id_proyecto  := inuProyecto;
        nuPaso                 := 50;
        rcMetraje.long_bajante := inuLongBajante;

        -- Inserta el registro
        nuPaso := 60;
        daLdc_Metraje_Piso.insRecord(ircldc_metraje_piso => rcMetraje);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescriptionError,
                            isbargument     => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proModifDatosBasicosProyecto(inuProyecto    ldc_metraje_piso.id_proyecto%TYPE, -- Proyecto
                                           isbNombre           ldc_proyecto_constructora.nombre%TYPE, -- Nombre proyecto
                                           isbDescripcion      ldc_proyecto_constructora.descripcion%TYPE, -- Descripcion
                                           inuLocalidad        ldc_proyecto_constructora.id_localidad%TYPE DEFAULT NULL, -- Localidad
                                           isbFormaPago        ldc_proyecto_constructora.forma_pago%TYPE, --Forma de pago
                                           inuDireccion        ldc_proyecto_constructora.id_direccion%TYPE DEFAULT NULL, -- Direccion
                                           inuTipoVivienda     ldc_proyecto_constructora.tipo_vivienda%TYPE -- Tipo de Vivienda
                                           ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proModifDatosBasicosProyecto
        Descripcion:        Modifica datos basicos del proyecto

        Autor    : KCienfuegos
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   KCienfuegos           Creacion
        ******************************************************************/

        sbProceso  VARCHAR2(4000) := 'proModifDatosBasicosProyecto';
        nuPaso     NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError    VARCHAR2(4000);
        rcProyecto ldc_proyecto_constructora%ROWTYPE; -- Datos del proyecto
        rcProyect  daldc_proyecto_constructora.styLDC_PROYECTO_CONSTRUCTORA;



    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 10);

        ut_trace.trace (gsbPaquete || '.' || sbProceso ||'isbDescripcion: '||isbDescripcion, 10);
        ut_trace.trace (gsbPaquete || '.' || sbProceso ||'inuLocalidad: '||inuLocalidad, 10);
        ut_trace.trace (gsbPaquete || '.' || sbProceso ||'inuDireccion: '||inuDireccion, 10);

        rcProyect := daldc_proyecto_constructora.frcGetRecord(inuID_PROYECTO => inuProyecto);

        IF(isbNombre IS NULL)THEN
            sbError := 'Debe indicar un nombre para el proyecto';
            raise ex.CONTROLLED_ERROR;
        END IF;

        IF(ldc_BCProyectoConstructora.fblProyectoConVenta(inuProyecto))THEN
            rcProyect.id_direccion := daldc_proyecto_constructora.fnuGetID_DIRECCION(inuProyecto,0);
            IF(rcProyect.id_direccion<>nvl(inuDireccion,-1))THEN
               sbError := 'No esta permitido modificar la direccion debido a que el proyecto ya tiene una venta registrada';
               raise ex.CONTROLLED_ERROR;
            END IF;

        END IF;

        IF(rcProyect.tipo_vivienda<>NVL(inuTipoVivienda,-2))THEN
           IF(ldc_BCProyectoConstructora.fblProyConVentaAprob(inuProyecto))THEN
              sbError := 'No es posible modificar el programa de vivienda para un proyecto con cotizacion aprobada';
              raise ex.CONTROLLED_ERROR;
           END IF;
        END IF;

        rcProyect.nombre := isbNombre;
        rcProyect.descripcion := isbDescripcion;
        rcProyect.id_localidad := inuLocalidad;
        rcProyect.id_direccion := inuDireccion;
        rcProyect.fech_ult_modif := SYSDATE;
        rcProyect.forma_pago := isbFormaPago;
        rcProyect.tipo_vivienda := inuTipoVivienda;
        rcProyect.usuario_ult_modif := dasa_user.fsbgetmask(sa_bouser.fnugetuserid);

        daldc_proyecto_constructora.updRecord(rcProyect);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso,10);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            IF (sbError IS NOT NULL)THEN
              ERRORS.SETERROR(inuapperrorcode => cnuDescriptionError,
                              isbargument     => sbError);
            END IF;
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proModifDefinicionProyecto(inuProyecto    ldc_metraje_piso.id_proyecto%TYPE,
                                         inuCantTorres  ldc_proyecto_constructora.cantidad_torres%TYPE,
                                         inuCantPisos   ldc_proyecto_constructora.cantidad_pisos%TYPE,
                                         inuCantTipo    ldc_proyecto_constructora.cant_tip_unid_pred %TYPE DEFAULT NULL,
                                         inuCantUnid    ldc_proyecto_constructora.cant_unid_predial%TYPE DEFAULT NULL
                                         ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proModifDatosBasicosProyecto
        Descripcion:        Modifica datos basicos del proyecto

        Autor    : KCienfuegos
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   KCienfuegos           Creacion
        ******************************************************************/

        sbProceso  VARCHAR2(4000) := 'proModifDefinicionProyecto';
        nuPaso     NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError    VARCHAR2(4000);
        rcProyecto ldc_proyecto_constructora%ROWTYPE; -- Datos del proyecto
        rcProyect  daldc_proyecto_constructora.styLDC_PROYECTO_CONSTRUCTORA;
        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 10);

        ut_trace.trace (gsbPaquete || '.' || sbProceso ||'inuCantTorres: '||inuCantTorres, 10);
        ut_trace.trace (gsbPaquete || '.' || sbProceso ||'inuCantPisos: '||inuCantPisos, 10);
        ut_trace.trace (gsbPaquete || '.' || sbProceso ||'inuCantTipo: '||inuCantTipo, 10);

        rcProyect := daldc_proyecto_constructora.frcGetRecord(inuID_PROYECTO => inuProyecto);

        rcProyect.cantidad_pisos  := inuCantPisos;
        rcProyect.cantidad_torres  := inuCantTorres;
        rcProyect.cant_unid_predial  := inuCantUnid;
        rcProyect.cant_tip_unid_pred  := inuCantTipo;
        rcProyect.fech_ult_modif := sysdate;
        rcProyect.usuario_ult_modif := dasa_user.fsbgetmask(sa_bouser.fnugetuserid);

        daldc_proyecto_constructora.updRecord(rcProyect);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso,10);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescriptionError,
                            isbargument     => sbError);
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proModifMetrajeXpiso(inuProyecto    ldc_metraje_piso.id_proyecto%TYPE, -- Proyecto
                                   inuPiso        ldc_metraje_piso.id_piso%TYPE, -- Piso
                                   inuLongBajante ldc_metraje_piso.long_bajante%TYPE -- Longitud del bajand
                                   ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proModifMetrajeXpiso
        Descripcion:        Modifica el metraje por piso

        Autor    : KCienfuegos
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   KCienfuegos           Creacion
        ******************************************************************/

        sbProceso  VARCHAR2(4000) := 'proModifMetrajeXpiso';
        nuPaso     NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError    VARCHAR2(4000);
        rcMetraje  daLDC_METRAJE_PISO.styLDC_METRAJE_PISO;
        nuExiste   NUMBER; -- Evalua si un elemento existe
        rcProyecto ldc_proyecto_constructora%ROWTYPE; -- Datos del proyecto
        rcPiso     ldc_piso_proyecto%ROWTYPE; -- Datos del piso

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 10);

       UPDATE ldc_metraje_piso
          SET long_bajante = inuLongBajante
        WHERE id_piso = inuPiso
          AND id_proyecto = inuProyecto;

        daldc_proyecto_constructora.updFECH_ULT_MODIF(inuID_PROYECTO => inuProyecto,
                                                      idtFECH_ULT_MODIF$ => sysdate);

        daldc_proyecto_constructora.updUSUARIO_ULT_MODIF(inuID_PROYECTO => inuProyecto,
                                                         isbUSUARIO_ULT_MODIF$ => dasa_user.fsbgetmask(sa_bouser.fnugetuserid));


        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 10);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescriptionError,
                            isbargument     => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proModifMetrajXTipoUnidPredial(inuProyecto            ldc_detalle_met_cotiz.id_proyecto%TYPE, -- Proyecto
                                              inuTipo                ldc_detalle_met_cotiz.id_tipo%TYPE, -- Tipo
                                              inuFlauta              ldc_detalle_met_cotiz.flauta%TYPE, -- Flauta
                                              inuHorno               ldc_detalle_met_cotiz.horno%TYPE, -- Horno
                                              inuBBQ                 ldc_detalle_met_cotiz.bbq%TYPE, -- BBQ
                                              inuEstufa              ldc_detalle_met_cotiz.estufa%TYPE, -- Estufa
                                              inuSecadora            ldc_detalle_met_cotiz.secadora%TYPE, -- Secadora
                                              inuCalentador          ldc_detalle_met_cotiz.calentador%TYPE, -- Calentador
                                              inuLongValBaj          ldc_detalle_met_cotiz.long_val_baj%TYPE, -- LongValVaj
                                              inuLongBajTab          ldc_detalle_met_cotiz.long_baj_tab%TYPE, -- LongBajTab
                                              inuLongTablero         ldc_detalle_met_cotiz.long_tablero%TYPE -- LongTablero
                                              ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:   proModifMetrajeXPisoYTipo
        Descripcion:          Modifica el metraje por tipo de unidad predial

        Autor    : KCienfuegos
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   KCienfuegos           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proModifMetrajeXTipoUnidPredial';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 10);

        -- Actualiza los datos de metraje por piso y tipo
        UPDATE ldc_metraje_tipo_unid_pred
        SET    flauta         = inuFlauta,
               horno          = inuHorno,
               bbq            = inuBBQ,
               estufa         = inuEstufa,
               secadora       = inuSecadora,
               calentador     = inuCalentador,
               long_val_bajante  = inuLongValBaj,
               long_bajante_tabl = inuLongBajTab,
               long_tablero      = inuLongTablero
        WHERE  id_proyecto       = inuProyecto
        AND    tipo_unid_predial = inuTipo;

        daldc_proyecto_constructora.updFECH_ULT_MODIF(inuID_PROYECTO => inuProyecto,
                                                      idtFECH_ULT_MODIF$ => sysdate);

        daldc_proyecto_constructora.updUSUARIO_ULT_MODIF(inuID_PROYECTO => inuProyecto,
                                                         isbUSUARIO_ULT_MODIF$ => dasa_user.fsbgetmask(sa_bouser.fnugetuserid));

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescriptionError,
                            isbargument     => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proModificaContratoYPagare(inuProyecto    ldc_metraje_piso.id_proyecto%TYPE, -- Proyecto
                                         isbContrato    ldc_proyecto_constructora.contrato%TYPE, -- Contrato
                                         isbPagare      ldc_proyecto_constructora.pagare%TYPE --Pagare
                                         ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proModificaContratoYPagare
        Descripcion:        Modifica el contrato y pagare de un proyecto

        Autor    : KCienfuegos
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   KCienfuegos           Creacion
        ******************************************************************/

        sbProceso  VARCHAR2(4000) := 'proModificaContratoYPagare';
        nuPaso     NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError    VARCHAR2(4000);
        rcProyecto daldc_proyecto_constructora.styLDC_PROYECTO_CONSTRUCTORA; -- Datos del proyecto

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 10);

        rcProyecto := daldc_proyecto_constructora.frcGetRecord(inuID_PROYECTO => inuProyecto);

        rcProyecto.contrato := isbContrato;
        rcProyecto.pagare   := isbPagare;
        rcProyecto.fech_ult_modif := sysdate;
        rcProyecto.usuario_ult_modif := dasa_user.fsbgetmask(sa_bouser.fnugetuserid);
        daldc_proyecto_constructora.updRecord(rcProyecto);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 10);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescriptionError,
                            isbargument     => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proCopiaProyecto(inuProyectoOrigen   ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto origen
                               onuProyectoNuevo    OUT ldc_proyecto_constructora.id_proyecto%TYPE -- Proyecto creado
                               ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCopiaProyecto
        Descripcion:        Copia un proyecto

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        26-04-2017   KCienfuegos            Se modifica para registrar el tipo de vivienda
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso  VARCHAR2(4000) := 'proCopiaProyecto';
        nuPaso     NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError    VARCHAR2(4000);
        nuExiste   NUMBER; -- Evalua si un elemento existe
        rcProyecto ldc_proyecto_constructora%ROWTYPE;

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 10);

        -- Obtiene los datos del proyecto actual
        ldc_bcproyectoconstructora.proDatosProyecto(inuproyecto => inuProyectoOrigen,
                                                    orcproyecto => rcProyecto,
                                                    osberror    => sbError);

        IF sbError IS NOT NULL THEN
            RAISE ex.Controlled_Error;
        END IF;

        IF sbError IS NULL THEN
            RAISE ex.Controlled_Error;
        END IF;

        -- Crea el nuevo proyecto
        proCreaProyecto(inuProyectoOrigen   => inuProyectoOrigen,
                        isbnombre           => rcProyecto.Nombre,
                        isbdescripcion      => rcProyecto.Descripcion,
                        inucliente          => rcProyecto.Cliente,
                        inutipoconstruccion => rcProyecto.tipo_construccion ,
                        inucantpisos        => rcProyecto.cantidad_pisos ,
                        inucanttorres       => rcProyecto.cantidad_torres ,
                        inucanttipunidpred  => rcProyecto.Cant_Tip_Unid_Pred ,
                        inulocalidad        => rcProyecto.id_localidad ,
                        inudireccion        => rcProyecto.id_direccion ,
                        inuTipoVivienda     => rcProyecto.Tipo_Vivienda,
                        onuproyecto         => onuProyectoNuevo);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescriptionError,
                            isbargument     => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proBorraProyecto(inuProyecto   ldc_proyecto_constructora.id_proyecto%TYPE -- Proyecto
                               ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proBorraProyecto
        Descripcion:        Borra los datos de un proyecto: Pisos, Tipos de unidades, Metraje.

        Autor    : KCienfuegos
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   KCienfuegos           Creacion
        ******************************************************************/

        sbProceso  VARCHAR2(4000) := 'proBorraProyecto';
        nuPaso     NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError    VARCHAR2(4000);
        nuExiste   NUMBER; -- Evalua si un elemento existe
        rcProyecto ldc_proyecto_constructora%ROWTYPE;

        exError EXCEPTION; -- Error controlado

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso, 10);

        -- Obtiene los datos del proyecto actual
        delete ldc_unidad_predial up where up.id_proyecto = inuProyecto;
        delete ldc_metraje_piso mp where mp.id_proyecto = inuProyecto;
        delete ldc_metraje_tipo_unid_pred mt where mt.id_proyecto = inuProyecto;
        delete ldc_torres_proyecto tp where tp.id_proyecto = inuProyecto;
        delete ldc_piso_proyecto p where p.id_proyecto = inuProyecto;
        delete ldc_tipo_unid_pred_proy t where t.id_proyecto = inuProyecto;

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso, 10);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescriptionError,
                            isbargument     => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proPlantilla(nuDato NUMBER) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:
        Descripcion:

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := 'proInsertarMantenimientoNota';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        nuExiste  NUMBER; -- Evalua si un elemento existe

    BEGIN
        ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

        ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                           sbError);
            ERRORS.SETERROR(inuapperrorcode => cnuDescriptionError,
                            isbargument     => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || gsbPaquete || '.' || sbProceso || '(' ||
                           nuPaso || '):' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

END ldc_BOProyectoConstructora;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('LDC_BOPROYECTOCONSTRUCTORA', 'ADM_PERSON'); 
END;
/