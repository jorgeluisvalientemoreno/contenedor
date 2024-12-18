CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_BCCOTIZACIONCONSTRUCTORA IS

  CURSOR cuItemsFijo(inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE,
                     inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE,
                     isbTipoItem            VARCHAR2,
                     inuItem                ge_items.items_id%TYPE,
                     inuTipoTrab            ldc_items_por_unid_pred.id_tipo_trabajo%TYPE) IS
    SELECT id_unidad_predial,
           id_torre,
           id_piso,
           id_proyecto,
           id_item_cotizado,
           id_cotizacion_detallada
      FROM ldc_items_por_unid_pred iu
     WHERE iu.id_cotizacion_detallada = inuCotizacionDetallada
       AND iu.id_proyecto = inuProyecto
       AND iu.tipo_item = isbTipoItem
       AND iu.id_item = inuItem
       AND iu.id_tipo_trabajo = inuTipoTrab;

  PROCEDURE proDatosListaCostosCot(inuCotizacion ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                                   inuProyecto   ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                   orcLista      OUT GE_LIST_UNITARY_COST%ROWTYPE, -- Lista
                                   osbError      OUT VARCHAR2);

  PROCEDURE proDatosCotizacion(inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- C?digo de la cotizaci?n
                               inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, --
                               orcCotizacionDetallada OUT ldc_cotizacion_construct%ROWTYPE, -- Datos cotizaci?n
                               osbError               OUT VARCHAR2);

  PROCEDURE proDatosCotizacion(inuConsecCotizacion    ldc_cotizacion_construct.id_consecutivo%TYPE, -- Consecutivo cotizacion
                               onuCotizacionDetallada OUT ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                               onuListaPrecios        OUT ldc_cotizacion_construct.lista_costo%TYPE, -- Lista de precios
                               odtFechaVigencia       OUT ldc_cotizacion_construct.fecha_vigencia%TYPE, -- Fecha vigencia
                               osbFormaPago           OUT ldc_proyecto_constructora.forma_pago%TYPE, -- Forma de pago
                               onuValorCotizado       OUT ldc_cotizacion_construct.valor_cotizado%TYPE, --  Valor cotizado
                               onuEstado              OUT ldc_cotizacion_construct.estado%TYPE, -- Estado
                               osbObservacion         OUT ldc_cotizacion_construct.observacion%TYPE, -- Observaci?n
                               odtFechaRegistro       OUT ldc_cotizacion_construct.fecha_creacion%TYPE, -- Fecha registro
                               odtFechaUltModif       OUT ldc_cotizacion_construct.fecha_ult_modif%TYPE, -- Fecha utima modificacion
                               onuPlanComerEsp        OUT LDC_COTIZACION_CONSTRUCT.PLAN_COMERCIAL_ESPCL%TYPE,
                                onuUnidadInsta         OUT LDC_COTIZACION_CONSTRUCT.UND_INSTALADORA_ID%TYPE,
                               onuUnidadCerti         OUT LDC_COTIZACION_CONSTRUCT.UND_CERTIFICADORA_ID%TYPE,
							   OSBFLAGGOGA            OUT LDC_COTIZACION_CONSTRUCT.FLGOGASO%TYPE);

  PROCEDURE proDatosItem(inuItem       ge_items.items_id%TYPE, -- Item
                         inuCotizacion ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                         inuProyecto   ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                         orcItem       OUT ge_items%ROWTYPE, -- Datos del ?tem
                         osbError      OUT VARCHAR2);

  PROCEDURE proCostoItem(inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                         inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                         inuItem                ge_items.items_id%TYPE, -- Item
                         orcCosto               OUT ge_unit_cost_ite_lis%ROWTYPE, -- Costo del ?tem
                         osbError               OUT VARCHAR2);

  PROCEDURE proDatosListaCostos(inuListaCostos ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                orcLista       OUT GE_LIST_UNITARY_COST%ROWTYPE, -- Lista
                                osbError       OUT VARCHAR2);

  PROCEDURE proExisteTipoTrabajo(inuTipoTrabajo or_task_type.task_type_id%TYPE, -- Tipo de trabajo
                                 osbError       OUT VARCHAR2 -- Error
                                 );

  PROCEDURE proDatosValFijo(inuValFijo             ldc_val_fijos_unid_pred.id_item%TYPE, -- Valor fijo
                            inuCotizacionDetallada ldc_val_fijos_unid_pred.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                            inuProyecto            ldc_val_fijos_unid_pred.id_proyecto%TYPE, -- Proyecto
                            inuTipoTrab            or_task_type.task_type_id%TYPE, --Tipo trabajo
                            orcValFijo             OUT ldc_val_fijos_unid_pred%ROWTYPE, -- Valor fijo
                            osbError               OUT VARCHAR2);

  /*  PROCEDURE proInternaCotizacion(inuCotizacionDetallada ldc_tipos_trabajo_cot.id_tipo_trabajo%TYPE, -- Cotizacion
                                     inuProyecto            ldc_tipos_trabajo_cot.id_proyecto%TYPE, -- Proyecto
                                     orcInternaCotizacion   OUT ldc_tipos_trabajo_cot%ROWTYPE, -- Tipo de trabajo cotizado para interna
                                     osbError               OUT VARCHAR2);
  */
  -- Para mostrar en pantalla
  -- Funciones
  FUNCTION fcrItemsFijos(inuListaPrecios ge_list_unitary_cost.list_unitary_cost_id%TYPE -- Lista de precios
                         ) RETURN PKCONSTANTE.TYREFCURSOR;

  FUNCTION fcrMetrajexPisoxTipoProy(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE -- Id Proyecto
                                    ) RETURN PKCONSTANTE.TYREFCURSOR;

  FUNCTION fcrMetrajexPisoxTipoCot(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Id Proyecto
                                   inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE --Id cotizaci?n detallada
                                   ) RETURN PKCONSTANTE.TYREFCURSOR;

  FUNCTION fcrTipoTrabajoCotizacion(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Id Proyecto
                                    inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE --Id cotizaci?n detallada
                                    ) RETURN PKCONSTANTE.TYREFCURSOR;

  FUNCTION fcrItemsFijosCot(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Id Proyecto
                            inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, --Cotizacion detallada
                            isbTipoItem            ldc_items_cotiz_proy.tipo_item%TYPE, --Tipo de Item
                            inuTipoTrab            or_task_type.task_type_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR;

  FUNCTION fcrValoresFijosCot(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Id Proyecto
                              inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, --Cotizacion detallada
                              inuTipoTrab            or_task_type.task_type_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR;

  FUNCTION fcrItemsxMetraje(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Id Proyecto
                            inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE --Cotizacion detallada
                            ) RETURN PKCONSTANTE.TYREFCURSOR;

  FUNCTION fcrPisosTiposProy(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE -- Id Proyecto
                             ) RETURN PKCONSTANTE.TYREFCURSOR;

  FUNCTION fcrItemsTipoTrab RETURN PKCONSTANTE.TYREFCURSOR;

  FUNCTION fcrItemsxMetrajexUnidPredCot(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Id Proyecto
                                        inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, --Cotizacion detallada,
                                        isbTipoItem            ldc_items_por_unid_pred.tipo_item%TYPE,
                                        inuTipoTrab            or_task_type.task_type_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR;

  FUNCTION fcrConsolidadoCotizacion(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Id Proyecto
                                    inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE) --Cotizacion detallada,
   RETURN PKCONSTANTE.TYREFCURSOR;

  FUNCTION fblExisteCotizacion(inuConsecCotizacion ldc_cotizacion_construct.id_consecutivo%TYPE -- Consecutivo ?nico
                               ) RETURN BOOLEAN;

  FUNCTION fnuProyecto(inuConsecCotizacion ldc_cotizacion_construct.id_consecutivo%TYPE -- Identificador ?nico de una cotizaci?n detallada
                       ) RETURN NUMBER;

  FUNCTION fnuObtieneIVAInstInterna RETURN NUMBER;

  PROCEDURE proCotizacionDetalladaAprobada(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                           onuCotizacionDetallada OUT ldc_cotizacion_construct.id_cotizacion_detallada%TYPE -- Cotizaci?n detallada aprobada
                                           );

END LDC_BCCOTIZACIONCONSTRUCTORA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_BCCOTIZACIONCONSTRUCTORA IS

  ------------------------------------------------------------------------------------------------
  -- Datos de paquete
  ------------------------------------------------------------------------------------------------
  csbPaquete               VARCHAR2(30) := 'ldcBC_cotizacionConstructora';
  csbCotizacionPreAprobada ldc_cotizacion_construct.estado%TYPE := 'P';
  csbCotizacionAprobada    ldc_cotizacion_construct.estado%TYPE := 'A';

  ------------------------------------------------------------------------------------------------
  -- Errores
  ------------------------------------------------------------------------------------------------
  cnuDescripcionError NUMBER := 2741; -- Descripcion del error

  PROCEDURE proDatosListaCostos(inuListaCostos ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                orcLista       OUT GE_LIST_UNITARY_COST%ROWTYPE, -- Lista
                                osbError       OUT VARCHAR2) IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: proDatosListaCostosCot
    Descripci?n:        Obtiene los datos de la lista de precios

    Autor    : Sandra Mu?oz
    Fecha    : 10-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    15-04-2016   Sandra Mu?oz           Creaci?n
    ******************************************************************/

    sbProceso VARCHAR2(4000) := 'proDatosListaCostosCot';
    nuPaso    NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Obtener datos de la lista de costos
    BEGIN
      SELECT *
        INTO orcLista
        FROM ge_list_unitary_cost gluc
       WHERE gluc.list_unitary_cost_id = inuListaCostos;
    EXCEPTION
      WHEN no_data_found THEN
        osbError := 'La lista ' || inuListaCostos || ' no existe';
        RAISE exError;
    END;

    -- Verifica que la lista de precios est? vigente
    IF trunc(SYSDATE) NOT BETWEEN orcLista.Validity_Start_Date AND
       orcLista.Validity_Final_Date THEN
      osbError := 'La lista de precios ' || orcLista.List_Unitary_Cost_Id ||
                  ' - ' || orcLista.Description ||
                  ' tiene fecha de vigencia desde ' ||
                  to_char(orcLista.Validity_Start_Date, 'dd-mm-yyyy') ||
                  ' hasta ' ||
                  to_char(orcLista.Validity_Final_Date, 'dd-mm-yyyy');
      RAISE exError;
    END IF;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || osbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => osbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  PROCEDURE proDatosListaCostosCot(inuCotizacion ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                                   inuProyecto   ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                   orcLista      OUT GE_LIST_UNITARY_COST%ROWTYPE, -- Lista
                                   osbError      OUT VARCHAR2) IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: proDatosListaCostosCot
    Descripci?n:        Obtiene los datos de la lista de precios

    Autor    : Sandra Mu?oz
    Fecha    : 10-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    15-04-2016   Sandra Mu?oz           Creaci?n
    ******************************************************************/

    sbProceso             VARCHAR2(4000) := 'proDatosListaCostosCot';
    nuPaso                NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    rcLista               GE_LIST_UNITARY_COST%ROWTYPE; -- Lista de precios
    rcProyecto            ldc_proyecto_constructora%ROWTYPE; -- Proyecto
    rcCotizacion          ldc_cotizacion_construct%ROWTYPE; -- Cotizacion
    sbLocalidadProyecto   ge_geogra_location.description%TYPE; -- Descripci?n de la localidad del proyecto
    sbLocalidadListaCotiz ge_geogra_location.description%TYPE; -- Descripci?n de la localidad de la lista de la cotizaci?n

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Validaci?n datos
    proDatosCotizacion(inucotizaciondetallada => inuCotizacion,
                       inuproyecto            => inuProyecto,
                       orccotizaciondetallada => rcCotizacion,
                       osberror               => osbError);

    IF osbError IS NOT NULL THEN
      RAISE exError;
    END IF;

    ldc_bcProyectoConstructora.proDatosProyecto(inuProyecto => inuProyecto,
                                                orcProyecto => rcProyecto,
                                                osbError    => osbError);

    IF osbError IS NOT NULL THEN
      RAISE exError;
    END IF;

    IF rcProyecto.id_localidad IS NULL THEN
      osbError := 'No se ha definido localidad para el proyecto ' ||
                  inuProyecto || ' - ' || rcProyecto.nombre;
      RAISE exError;
    END IF;

    proDatosListaCostos(inulistacostos => rcCotizacion.Lista_Costo,
                        orclista       => orclista,
                        osberror       => osbError);

    IF osbError IS NOT NULL THEN
      RAISE exError;
    END IF;

    -- Verifica que la lista sea v?lida para la localidad del proyecto
    IF rcLista.Geograp_Location_Id <> rcProyecto.id_localidad THEN
      sbLocalidadProyecto   := dage_geogra_location.fsbgetDescription(rcProyecto.id_localidad);
      sbLocalidadListaCotiz := dage_geogra_location.fsbgetDescription(rcLista.Geograp_Location_Id);
      osbError              := 'La lista de precios ' ||
                               rcLista.List_Unitary_Cost_Id || ' - ' ||
                               rcLista.Description ||
                               ' est? definida para la localidad ' ||
                               rcLista.Geograp_Location_Id ||
                               ', pero el proyecto ' ||
                               rcProyecto.id_proyecto || ' - ' ||
                               rcProyecto.nombre ||
                               ' tiene definida la localidad ' ||
                               rcProyecto.id_localidad;
    END IF;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || osbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => osbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  PROCEDURE proDatosCotizacion(inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- C?digo de la cotizaci?n
                               inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, --
                               orcCotizacionDetallada OUT ldc_cotizacion_construct%ROWTYPE, -- Datos cotizaci?n
                               osbError               OUT VARCHAR2) IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete:  proDatosCotizacion
    Descripci?n:         Obtiene los datos de la cotizaci?n

    Autor    : Sandra Mu?oz
    Fecha    : 10-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    10-05-2016   Sandra Mu?oz           Creaci?n
    ******************************************************************/

    sbProceso  VARCHAR2(4000) := 'proDatosCotizacion';
    nuPaso     NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    rcProyecto ldc_proyecto_constructora%ROWTYPE; -- Proyecto

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Validaci?n de datos
    ldc_bcproyectoconstructora.proDatosProyecto(inuproyecto => inuProyecto,
                                                orcproyecto => rcProyecto,
                                                osberror    => osbError);

    IF osbError IS NOT NULL THEN
      RAISE exError;
    END IF;

    -- Obtener los datos de la cotizaci?n
    BEGIN
      SELECT *
        INTO orcCotizacionDetallada
        FROM ldc_cotizacion_construct lcc
       WHERE lcc.id_cotizacion_detallada = inuCotizacionDetallada
         AND lcc.id_proyecto = inuProyecto;
    EXCEPTION
      WHEN no_data_found THEN
        osbError := 'No se encontr? la cotizaci?n ' ||
                    inuCotizacionDetallada || ' asociada al proyecto ' ||
                    inuProyecto;
        RAISE exError;
    END;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || osbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => osbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  PROCEDURE proDatosItem(inuItem       ge_items.items_id%TYPE, -- Item
                         inuCotizacion ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                         inuProyecto   ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                         orcItem       OUT ge_items%ROWTYPE, -- Datos del ?tem
                         osbError      OUT VARCHAR2) IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: proDatosItem
    Descripci?n:        Obtiene la informaci?n de un ?tem

    Autor    : Sandra Mu?oz
    Fecha    : 10-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    10-05-2016   Sandra Mu?oz           Creaci?n
    ******************************************************************/

    sbProceso VARCHAR2(4000) := 'proDatosItem';
    nuPaso    NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    nuExiste  NUMBER; -- Indica si un elemento existe en el sistem

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Valida que el ?tem exista en el sistema
    BEGIN
      SELECT * INTO orcItem FROM ge_items gi WHERE gi.items_id = inuItem;
    EXCEPTION
      WHEN no_data_found THEN
        osbError := 'No se encontr? el ?tem ' || inuItem;
        RAISE exError;
    END;

    /* -- Valida que el ?tem est? asociado a un tipo de trabajo correcto y de los asociados a la }
        -- cotizaci?n

        SELECT COUNT(1)
        INTO   nuExiste
        FROM   or_task_types_items   otti,
               ldc_tipos_trabajo_cot lttc
        WHERE  otti.task_type_id = lttc.id_tipo_trabajo
        AND    otti.items_id = inuItem
        AND    lttc.id_cotizacion_detallada = inuCotizacion
        AND    lttc.id_proyecto = inuProyecto;

        IF nuExiste = 0 THEN
            osbError := 'No se encontr? asociado el ?tem ' || orcItem.Items_Id || ' - ' ||
                        orcItem.Description ||
                        ' a los tipos de trabajo definidos en la cotizacion ' || inuCotizacion;
            RAISE exError;
        END IF;
    */
    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || osbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => osbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  PROCEDURE proDatosValFijo(inuValFijo             ldc_val_fijos_unid_pred.id_item%TYPE, -- Valor fijo
                            inuCotizacionDetallada ldc_val_fijos_unid_pred.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                            inuProyecto            ldc_val_fijos_unid_pred.id_proyecto%TYPE, -- Proyecto
                            inuTipoTrab            or_task_type.task_type_id%TYPE, --Tipo trabajo
                            orcValFijo             OUT ldc_val_fijos_unid_pred%ROWTYPE, -- Valor fijo
                            osbError               OUT VARCHAR2) IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: proDatosValFijo
    Descripci?n:        Obtiene la informaci?n de un ?tem

    Autor    : Sandra Mu?oz
    Fecha    : 10-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    10-05-2016   Sandra Mu?oz           Creaci?n
    ******************************************************************/

    sbProceso    VARCHAR2(4000) := 'proDatosValFijo';
    nuPaso       NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    nuExiste     NUMBER; -- Indica si un elemento existe en el sistem
    rcCotizacion ldc_cotizacion_construct%ROWTYPE; -- Cotizacion

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Valida la existencia de la cotizacion
    ldc_bcCotizacionConstructora.proDatosCotizacion(inuCotizacionDetallada => inuCotizacionDetallada,
                                                    inuProyecto            => inuProyecto,
                                                    orcCotizacionDetallada => rcCotizacion,
                                                    osbError               => osbError);
    IF osbError IS NOT NULL THEN
      RAISE exError;
    END IF;

    -- Valida que el valor fijo exista en el sistema
    BEGIN
      SELECT *
        INTO orcValFijo
        FROM ldc_val_fijos_unid_pred lvfup
       WHERE lvfup.id_cotizacion_detallada = inuCotizacionDetallada
         AND lvfup.id_proyecto = inuProyecto
         AND lvfup.id_item = inuValFijo
         AND lvfup.tipo_trab = inuTipoTrab;
    EXCEPTION
      WHEN no_data_found THEN
        osbError := 'No se encontr? el valor fijo ' || inuValFijo ||
                    ' en la cotizaci?n ' || inuCotizacionDetallada ||
                    ' del proyect ' || inuProyecto;
        RAISE exError;
    END;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || osbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => osbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  PROCEDURE proCostoItem(inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                         inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                         inuItem                ge_items.items_id%TYPE, -- Item
                         orcCosto               OUT ge_unit_cost_ite_lis%ROWTYPE, -- Costo del ?tem
                         osbError               OUT VARCHAR2) IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: proCostoItem
    Descripci?n:        Costo del ?tem

    Autor    : Sandra Mu?oz
    Fecha    : 10-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    10-05-2016   Sandra Mu?oz           Creaci?n
    ******************************************************************/

    sbProceso     VARCHAR2(4000) := 'proCostoItem';
    nuPaso        NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    rcListaCostos ge_list_unitary_cost%ROWTYPE; -- Lista de costos
    rcItem        ge_items%ROWTYPE; -- Item

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Validaci?n de existencia de datos
    proDatosItem(inuitem       => inuItem,
                 inucotizacion => inuCotizacionDetallada,
                 inuproyecto   => inuCotizacionDetallada,
                 orcitem       => rcItem,
                 osberror      => osbError);

    IF osbError IS NOT NULL THEN
      RAISE exError;
    END IF;

    proDatosListaCostosCot(inucotizacion => inuCotizacionDetallada,
                           inuproyecto   => inuProyecto,
                           orclista      => rcListaCostos,
                           osberror      => osbError);
    IF osbError IS NOT NULL THEN
      RAISE exError;
    END IF;

    /* BEGIN
        SELECT *
          INTO orcCosto
          FROM ge_unit_cost_ite_lis gucil
         WHERE gucil.items_id = inuItem
           AND gucil.list_unitary_cost_id =
               rcListaCostos.List_Unitary_Cost_Id;
      EXCEPTION
        WHEN no_data_found THEN
          osbError := 'No se encontro?el ?tem ' || inuItem || ' - ' ||
                      rcItem.Description || ' asociado a la lista ' ||
                      rcListaCostos.List_Unitary_Cost_Id || ' - ' ||
                      rcListaCostos.Description;
          RAISE exError;
      END;
    */
    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || osbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => osbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  FUNCTION fcrItemsFijos(inuListaPrecios ge_list_unitary_cost.list_unitary_cost_id%TYPE -- Lista de precios
                         ) RETURN PKCONSTANTE.TYREFCURSOR IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fcrItemsFijos
    Descripci?n:        Crear una funci?n que regrese en un cursor referenciado lo siguientes
                        datos: tipo trab, item id, item descript, precio, costo. Se recibe como
                        par?metro la lista de costos y tres par?metros m?s para tipos de trabajo.

    Autor    : Sandra Mu?oz

    Fecha    : 10-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    10-05-2016   Sandra Mu?oz           Creaci?n
    17-07-2018   Sebastian Tapias       REQ.2001640: Se agregan UNION con items
                                        Pertenecientes a una lista generica.
    ******************************************************************/

    sbProceso       VARCHAR2(4000) := 'fcrItemsFijos';
    nuPaso          NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    crItems         PKCONSTANTE.TYREFCURSOR;
    sbError         VARCHAR2(4000); -- Error
    sbItemsMaterial ld_parameter.value_chain%TYPE; -- Items de material

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Obtener la clasificaci?n de ?tems de material
    sbItemsMaterial := dald_parameter.fsbGetValue_Chain('CLASIF_ITEMS_CONSTRUCT',
                                                        NULL);

    -- Consulta cursor referenciado
    -- 200-1640 Se Agrega UNION para mostrar items pertenecientes a lista generica.
    OPEN crItems FOR
      SELECT gi.items_id || 'C' items_id,
             gi.items_id || ' - ' || gi.description || ' - C' item_descripcion,
             nvl(gucil.sales_value, 0) item_precio,
             nvl(gucil.price, 0) item_costo
        FROM ge_unit_cost_ite_lis gucil, ge_items gi
       WHERE gucil.list_unitary_cost_id = inuListaPrecios
         AND gi.items_id = gucil.items_id
         AND instr(sbItemsMaterial, to_char(gi.item_classif_id)) > 0
      UNION
      SELECT gi.items_id || 'G' items_id,
             gi.items_id || ' - ' || gi.description || ' - G' item_descripcion,
             nvl(gucil.sales_value, 0) item_precio,
             nvl(gucil.price, 0) item_costo
        FROM ge_unit_cost_ite_lis gucil,
             ge_items             gi,
             ge_list_unitary_cost l
       WHERE gucil.list_unitary_cost_id = l.list_unitary_cost_id
         AND gi.items_id = gucil.items_id
         AND instr(sbItemsMaterial, to_char(gi.item_classif_id)) > 0
         AND l.operating_unit_id IS NULL
         AND l.contractor_id IS NULL
         AND l.contract_id IS NULL
         AND l.geograp_location_id IS NULL
         AND l.description LIKE '%MATERIALES%'
         AND TRUNC(SYSDATE) BETWEEN TRUNC(l.validity_start_date) AND
             TRUNC(l.validity_final_date)
      UNION
      SELECT gi.items_id || 'G' items_id,
             gi.items_id || ' - ' || gi.description || ' - G' item_descripcion,
             nvl(gucil.sales_value, 0) item_precio,
             nvl(gucil.price, 0) item_costo
        FROM ge_unit_cost_ite_lis gucil,
             ge_items             gi,
             ge_list_unitary_cost l
       WHERE gucil.list_unitary_cost_id = l.list_unitary_cost_id
         AND gi.items_id = gucil.items_id
         AND gucil.items_id IN
             (SELECT column_value
                FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('ID_ITEMS_FIJOS_COMERCONS',
                                                                                         null),
                                                        '|')))
         AND l.list_unitary_cost_id IN
             (SELECT column_value
                FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('ID_LIST_COST_COMERCONS',
                                                                                         null),
                                                        '|')))
         AND TRUNC(SYSDATE) BETWEEN TRUNC(l.validity_start_date) AND
             TRUNC(l.validity_final_date)
       ORDER BY 1, 2;

    RETURN crItems;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => sbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  FUNCTION fcrMetrajexPisoxTipoProy(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE -- Id Proyecto
                                    ) RETURN PKCONSTANTE.TYREFCURSOR IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fcrMetrajexPisoxTipoProy
    Descripci?n:        Funci?n que regresa un cursor referenciado con el metraje
                        por tipo y piso definido a nivel de proyecto.

    Autor    : KCienfuegos

    Fecha    : 20-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    20-05-2016   KCienfuegos           Creaci?n
    ******************************************************************/

    sbProceso               VARCHAR2(4000) := 'fcrMetrajexPisoxTipoProy';
    nuPaso                  NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    crMetrajexPisoxTipoProy PKCONSTANTE.TYREFCURSOR;
    sbError                 VARCHAR2(4000); -- Error

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Consulta cursor referenciado
    OPEN crMetrajexPisoxTipoProy FOR
      SELECT mp.id_proyecto,
             mp.id_piso,
             NULL QUOTATION_ID,
             p.descripcion PISO_DESC,
             mt.tipo_unid_predial,
             t.descripcion TIPO_DESC,
             nvl(mt.flauta, 0) FLAUTA,
             nvl(mt.horno, 0) HORNO,
             nvl(mt.bbq, 0) BBQ,
             nvl(mt.estufa, 0) ESTUFA,
             nvl(mt.secadora, 0) SECADORA,
             nvl(mt.calentador, 0) CALENTADOR,
             nvl(mt.long_val_bajante, 0) LONG_VAL_BAJANTE,
             nvl(mt.long_bajante_tabl, 0) LONG_BAJANTE_TABL,
             nvl(mt.long_tablero, 0) LONG_TABLERO,
             nvl(mp.long_bajante, 0) LONG_BAJANTE,
             'N' OPERACION,
             COUNT(up.id_tipo_unid_pred) cantidad
        FROM ldc_metraje_piso           mp,
             ldc_metraje_tipo_unid_pred mt,
             ldc_unidad_predial         up,
             ldc_piso_proyecto          p,
             ldc_tipo_unid_pred_proy    t
       WHERE mt.id_proyecto = mp.id_proyecto
         AND mt.tipo_unid_predial = up.id_tipo_unid_pred
         AND mp.id_piso = up.id_piso
         AND mt.id_proyecto = inuProyecto
         AND t.id_proyecto = mt.id_proyecto
         AND p.id_proyecto = mt.id_proyecto
         AND p.id_proyecto = up.id_proyecto
         AND p.id_piso = mp.id_piso
         AND t.id_tipo_unid_pred = mt.tipo_unid_predial
       GROUP BY mp.id_proyecto,
                mp.id_piso,
                p.descripcion,
                mt.tipo_unid_predial,
                t.descripcion,
                mt.flauta,
                mt.horno,
                mt.bbq,
                mt.estufa,
                mt.secadora,
                mt.calentador,
                mt.long_val_bajante,
                mt.long_bajante_tabl,
                mt.long_tablero,
                mp.long_bajante
       ORDER BY 2, 5;

    RETURN crMetrajexPisoxTipoProy;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => sbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  FUNCTION fcrMetrajexPisoxTipoCot(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Id Proyecto
                                   inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fcrMetrajexPisoxTipoCot
    Descripci?n:        Funci?n que regresa un cursor referenciado con el metraje
                        por tipo y piso de la cotizaci?n

    Autor    : KCienfuegos

    Fecha    : 23-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    23-05-2016   KCienfuegos           Creaci?n
    ******************************************************************/

    sbProceso              VARCHAR2(4000) := 'fcrMetrajexPisoxTipoCot';
    nuPaso                 NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    crMetrajexPisoxTipoCot PKCONSTANTE.TYREFCURSOR;
    sbError                VARCHAR2(4000); -- Error

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Consulta cursor referenciado
    OPEN crMetrajexPisoxTipoCot FOR
      SELECT dm.id_piso ID_PISO,
             dm.id_tipo TIPO_UNID_PREDIAL,
             dm.id_proyecto ID_PROYECTO,
             dm.id_cotizacion_detallada QUOTATION_ID,
             p.descripcion PISO_DESC,
             t.descripcion TIPO_DESC,
             dm.flauta FLAUTA,
             dm.horno HORNO,
             dm.bbq BBQ,
             dm.estufa ESTUFA,
             dm.secadora SECADORA,
             dm.calentador CALENTADOR,
             dm.long_val_baj LONG_VAL_BAJANTE,
             dm.long_baj_tab LONG_BAJANTE_TABL,
             dm.long_tablero LONG_TABLERO,
             dm.long_bajante LONG_BAJANTE,
             dm.cant_unid_pred CANTIDAD,
             'N' OPERACION
        FROM ldc_detalle_met_cotiz   dm,
             ldc_tipo_unid_pred_proy t,
             ldc_piso_proyecto       p
       WHERE dm.id_proyecto = inuProyecto
         AND dm.id_cotizacion_detallada = inuCotizacionDetallada
         AND dm.id_piso = p.id_piso
         AND dm.id_proyecto = p.id_proyecto
         AND dm.id_tipo = t.id_tipo_unid_pred
         AND dm.id_proyecto = t.id_proyecto
       ORDER BY 1, 2;

    RETURN crMetrajexPisoxTipoCot;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => sbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  FUNCTION fcrTipoTrabajoCotizacion(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Id Proyecto
                                    inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fcrTipoTrabajoCotizacion
    Descripci?n:        Funci?n que regresa un cursor referenciado con los tipos de
                        trabajo de la cotizaci?n.

    Autor    : KCienfuegos

    Fecha    : 23-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    23-05-2016   KCienfuegos           Creaci?n
    ******************************************************************/

    sbProceso               VARCHAR2(4000) := 'fcrTipoTrabajoCotizacion';
    nuPaso                  NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    crTipoTrabajoCotizacion PKCONSTANTE.TYREFCURSOR;
    sbError                 VARCHAR2(4000); -- Error

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Consulta cursor referenciado
    OPEN crTipoTrabajoCotizacion FOR
      SELECT tc.id_proyecto ID_PROYECTO,
             tc.id_cotizacion_detallada QUOTATION_ID,
             tc.id_tipo_trabajo TIPO_TRABAJO,
             tc.tipo_trabajo_desc TRABAJO_CLASIFICACION,
             tc.id_actividad_principal ITEM_ID,
             'N' OPERACION
        FROM ldc_tipos_trabajo_cot tc
       WHERE tc.id_proyecto = inuProyecto
         AND tc.id_cotizacion_detallada = inuCotizacionDetallada
       ORDER BY 2;

    RETURN crTipoTrabajoCotizacion;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => sbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  FUNCTION fcrItemsFijosCot(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Id Proyecto
                            inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, --Cotizacion detallada
                            isbTipoItem            ldc_items_cotiz_proy.tipo_item%TYPE, --Tipo de Item
                            inuTipoTrab            or_task_type.task_type_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fcrItemsFijosCot
    Descripci?n:        Funci?n que regresa un cursor referenciado con los items fijos
                        de la cotizaci?n.

    Autor    : KCienfuegos

    Fecha    : 23-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    23-05-2016   KCienfuegos           Creaci?n
    19-07-2018   Sebastian Tapias      REQ.2001640: se agrega info adicional
    ******************************************************************/

    sbProceso      VARCHAR2(4000) := 'fcrItemsFijosCot';
    nuPaso         NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    crTipoItemsCot PKCONSTANTE.TYREFCURSOR;
    sbError        VARCHAR2(4000); -- Error

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Consulta cursor referenciado
    OPEN crTipoItemsCot FOR
      SELECT ic.id_cotizacion_detallada QUOTATION_ID,
             ic.id_proyecto ID_PROYECTO,
             ic.id_item || nvl(ica.class_item, 'N/A') ID_ITEM, --200-1640
             i.description || ' - ' || nvl(ica.class_item, 'N/A') ITEM_DESC, --200-1640
             ic.Tipo_Trab TIPO_TRAB,
             ic.cantidad CANTIDAD,
             ic.costo COSTO,
             ic.precio PRECIO,
             ic.tipo_item TIPO_ITEM,
             'N' OPERACION
        FROM ge_items                  i,
             ldc_items_cotiz_proy      ic,
             ldc_itemscoticonstru_adic ica --200-1640
       WHERE ic.id_item = i.items_id
         AND ic.id_proyecto = inuProyecto
         AND ic.id_cotizacion_detallada = inuCotizacionDetallada
         AND ic.tipo_item = isbTipoItem
         AND ic.tipo_trab = inuTipoTrab
         AND ic.id_cotizacion_detallada = ica.id_cotizacion(+) --200-1640
         AND ic.id_proyecto = ica.id_proyecto(+) --200-1640
         AND ic.id_item = ica.id_item(+) --200-1640
         AND ic.tipo_item = ica.tipo_item(+) --200-1640
         AND ic.tipo_trab = ica.tipo_trab(+); --200-1640

    RETURN crTipoItemsCot;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => sbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  FUNCTION fcrValoresFijosCot(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Id Proyecto
                              inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, --Cotizacion detallada
                              inuTipoTrab            or_task_type.task_type_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fcrValoresFijosCot
    Descripci?n:        Funci?n que regresa un cursor referenciado con los valores fijos
                        de la cotizaci?n.

    Autor    : KCienfuegos

    Fecha    : 23-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    23-05-2016   KCienfuegos           Creaci?n
    19-07-2018   Sebastian Tapias      REQ.2001640: se agrega info adicional
    ******************************************************************/

    sbProceso         VARCHAR2(4000) := 'fcrValoresFijosCot';
    nuPaso            NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    crValoresFijosCot PKCONSTANTE.TYREFCURSOR;
    sbError           VARCHAR2(4000); -- Error

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Consulta cursor referenciado
    OPEN crValoresFijosCot FOR
      SELECT vf.id_item || nvl(vfa.class_item, 'N/A') ID, --200-1640
             vf.id_cotizacion_detallada QUOTATION_ID,
             vf.id_proyecto ID_PROYECTO,
             vf.descripcion || ' - ' || nvl(vfa.class_item, 'N/A') DESCRIPCION, --200-1640
             vf.cantidad CANTIDAD,
             vf.precio PRECIO,
             'VF' TIPO_ITEM,
             vf.tipo_trab TIPO_TRABAJO,
             'N' OPERACION
        FROM ldc_val_fijos_unid_pred vf, ldc_itemscotivalfijos_adic vfa --200-1640
       WHERE vf.id_proyecto = inuProyecto
         AND vf.id_cotizacion_detallada = inuCotizacionDetallada
         AND vf.tipo_trab = inuTipoTrab
         AND vf.id_cotizacion_detallada = vfa.id_cotizacion(+) --200-1640
         AND vf.id_proyecto = vfa.id_proyecto(+) --200-1640
         AND vf.id_item = vfa.id_item(+) --200-1640
         AND vf.tipo_trab = vfa.tipo_trab(+) --200-1640
       ORDER BY 1;

    RETURN crValoresFijosCot;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => sbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  FUNCTION fcrItemsxMetraje(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Id Proyecto
                            inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE --Cotizacion detallada
                            ) RETURN PKCONSTANTE.TYREFCURSOR IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fcrItemsxMetraje
    Descripci?n:        Funci?n que regresa un cursor referenciado con los items por metraje
                        de la cotizaci?n.

    Autor    : KCienfuegos

    Fecha    : 23-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    23-05-2016   KCienfuegos           Creaci?n
    19-07-2018   Sebastian Tapias      REQ.2001640: se agrega info adicional
    ******************************************************************/

    sbProceso       VARCHAR2(4000) := 'fcrItemsxMetraje';
    nuPaso          NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    crItemsxMetraje PKCONSTANTE.TYREFCURSOR;
    sbError         VARCHAR2(4000); -- Error

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Consulta cursor referenciado
    OPEN crItemsxMetraje FOR
      SELECT im.id_proyecto ID_PROYECTO,
             im.id_cotizacion_detallada QUOTATION_ID,
             im.id_item || nvl(ima.class_item, 'N/A') ID_ITEM, --200-1640
             i.description || ' - ' || nvl(ima.class_item, 'N/A') ITEM_DESC, --200-1640
             im.precio PRECIO,
             im.costo COSTO,
             im.flauta FLAUTA,
             im.horno HORNO,
             im.bbq BBQ,
             im.estufa ESTUFA,
             im.secadora SECADORA,
             im.calentador CALENTADOR,
             im.log_val_bajante LONG_VAL_BAJANTE,
             im.long_baj_tablero LONG_BAJANTE_TABL,
             im.long_tablero LONG_TABLERO,
             im.long_bajante LONG_BAJANTE,
             'IM' TIPO_ITEM,
             'N' OPERACION
        FROM ldc_items_metraje_cot     im,
             ge_items                  i,
             ldc_itemscotimetraje_adic ima --200-1640
       WHERE im.id_proyecto = inuProyecto
         AND im.id_cotizacion_detallada = inuCotizacionDetallada
         AND i.items_id = im.id_item
         AND im.id_cotizacion_detallada = ima.id_cotizacion(+) --200-1640
         AND im.id_item = ima.id_item(+) --200-1640
         AND im.id_proyecto = ima.id_proyecto(+) --200-1640
       ORDER BY 3;

    RETURN crItemsxMetraje;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN ex.Controlled_error THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError);
      RAISE ex.Controlled_error;
    WHEN OTHERS THEN
      sbError := 'TERMIN? CON ERROR NO CONTROLADO  ' || csbPaquete || '.' ||
                 sbProceso || '(' || nuPaso || '): ' || SQLCODE;
      ut_trace.trace(sbError);
      RAISE ex.Controlled_error;
  END;

  FUNCTION fcrPisosTiposProy(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE -- Id Proyecto
                             ) RETURN PKCONSTANTE.TYREFCURSOR IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fcrPisosTiposProy
    Descripci?n:        Funci?n que regresa un cursor referenciado con los pisos y tipos de unidad predial
                        por proyecto

    Autor    : KCienfuegos

    Fecha    : 24-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    24-05-2016   KCienfuegos           Creaci?n
    ******************************************************************/

    sbProceso        VARCHAR2(4000) := 'fcrPisosTiposProy';
    nuPaso           NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    crPisosTiposProy PKCONSTANTE.TYREFCURSOR;
    sbError          VARCHAR2(4000); -- Error

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Consulta cursor referenciado
    OPEN crPisosTiposProy FOR
      SELECT p.id_piso           ID_PISO,
             t.id_tipo_unid_pred ID_TIPO_UNID_PRED,
             p.descripcion       PISO_DESC,
             t.descripcion       TIPO_UNID_DESC,
             p.id_proyecto       ID_PROYECTO
        FROM ldc_piso_proyecto p, ldc_tipo_unid_pred_proy t
       WHERE p.id_proyecto = t.id_proyecto
         AND p.id_proyecto = inuProyecto
         AND EXISTS (SELECT 1
                FROM ldc_unidad_predial
               where id_tipo_unid_pred = t.id_tipo_unid_pred
                 and id_piso = p.id_piso
                 and id_proyecto = inuProyecto)
       ORDER BY 1, 2;

    RETURN crPisosTiposProy;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => sbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  FUNCTION fcrItemsTipoTrab RETURN PKCONSTANTE.TYREFCURSOR IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fcrItemsTipoTrab
    Descripci?n:        Funci?n que regresa un cursor referenciado con los items (tipo actividad)
                        de los tipos de trabajo.

    Autor    : KCienfuegos

    Fecha    : 31-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    31-05-2016   KCienfuegos           Creaci?n
    ******************************************************************/

    sbProceso       VARCHAR2(4000) := 'fcrItemsTipoTrab';
    nuPaso          NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    crItemsTipoTrab PKCONSTANTE.TYREFCURSOR;
    sbError         VARCHAR2(4000); -- Error

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Consulta cursor referenciado
    OPEN crItemsTipoTrab FOR
      SELECT /*+ rule */
       g.items_id     item_id,
       t.task_type_id tipo_trab,
       t.description  tipo_trab_desc
        FROM ge_items g, or_task_types_items ti, or_task_type t
       WHERE g.items_id = ti.items_id
         AND t.task_type_id = ti.task_type_id
         AND g.item_classif_id = 2
         AND t.task_type_id IN
             (SELECT column_value
                FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_RED_INTERNA'),
                                                        '|')))
      UNION
      SELECT /*+ rule */
       g.items_id     item_id,
       t.task_type_id tipo_trab,
       t.description  tipo_trab_desc
        FROM ge_items g, or_task_types_items ti, or_task_type t
       WHERE g.items_id = ti.items_id
         AND t.task_type_id = ti.task_type_id
         AND g.item_classif_id = 2
         AND t.task_type_id IN
             (SELECT column_value
                FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_CARG_CONEX'),
                                                        '|')))
      UNION
      SELECT /*+ rule */
       g.items_id     item_id,
       t.task_type_id tipo_trab,
       t.description  tipo_trab_desc
        FROM ge_items g, or_task_types_items ti, or_task_type t
       WHERE g.items_id = ti.items_id
         AND t.task_type_id = ti.task_type_id
         AND g.item_classif_id = 2
         AND t.task_type_id IN
             (SELECT column_value
                FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_CERTIF'),
                                                        '|')));

    RETURN crItemsTipoTrab;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => sbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  FUNCTION fcrItemsxMetrajexUnidPredCot(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Id Proyecto
                                        inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, --Cotizacion detallada,
                                        isbTipoItem            ldc_items_por_unid_pred.tipo_item%TYPE,
                                        inuTipoTrab            or_task_type.task_type_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fcrItemsxMetrajexUnidPredCot
    Descripci?n:        Funci?n que regresa un cursor referenciado con los items por unidad predial

    Autor    : KCienfuegos

    Fecha    : 01-06-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    01-06-2016   KCienfuegos           Creaci?n
    ******************************************************************/

    sbProceso                VARCHAR2(4000) := 'fcrItemsxMetrajexUnidPredCot';
    nuPaso                   NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    crItemsxMetrajexUnidPred PKCONSTANTE.TYREFCURSOR;
    sbError                  VARCHAR2(4000); -- Error

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Consulta cursor referenciado
    OPEN crItemsxMetrajexUnidPred FOR
      SELECT DISTINCT up.id_proyecto ID_PROYECTO,
                      ip.id_cotizacion_detallada QUOTATION_ID,
                      up.id_piso ID_PISO,
                      up.id_tipo_unid_pred ID_TIPO_UNID_PRED,
                      ip.id_tipo_trabajo TIPO_TRAB,
                      ip.id_item ID_ITEM,
                      dage_items.fsbgetdescription(ip.id_item, 0) ITEM_DESC,
                      ip.cantidad CANTIDAD,
                      ip.precio PRECIO,
                      ip.costo COSTO,
                      tipo_item TIPO_ITEM,
                      'N' OPERACION
        FROM ldc_items_por_unid_pred ip, ldc_unidad_predial up
       WHERE ip.id_cotizacion_detallada = inuCotizacionDetallada
         AND ip.id_proyecto = inuProyecto
         AND ip.id_unidad_predial = up.id_unidad_predial
         AND ip.id_piso = up.id_piso
         AND ip.id_proyecto = up.id_proyecto
         AND tipo_item = isbTipoItem
         AND ip.id_tipo_trabajo = inuTipoTrab
       ORDER BY 3, 4;

    RETURN crItemsxMetrajexUnidPred;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN ex.Controlled_error THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError);
      RAISE ex.Controlled_error;
    WHEN OTHERS THEN
      sbError := 'TERMIN? CON ERROR NO CONTROLADO  ' || csbPaquete || '.' ||
                 sbProceso || '(' || nuPaso || '): ' || SQLCODE;
      ut_trace.trace(sbError);
      RAISE ex.Controlled_error;
  END;

  FUNCTION fcrConsolidadoCotizacion(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Id Proyecto
                                    inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE) --Cotizacion detallada,
   RETURN PKCONSTANTE.TYREFCURSOR IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fcrConsolidadoCotizacion
    Descripci?n:        Funci?n que  retorna el consolidado de la cotizaci?n

    Autor    : KCienfuegos

    Fecha    : 10-06-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    10-06-2016     KCienfuegos           Creaci?n
    ******************************************************************/

    sbProceso        VARCHAR2(4000) := 'fcrConsolidadoCotizacion';
    nuPaso           NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    crConsolidadoCot PKCONSTANTE.TYREFCURSOR;
    sbError          VARCHAR2(4000); -- Error

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Consulta cursor referenciado
    OPEN crConsolidadoCot FOR
      SELECT c.Id_Proyecto,
             c.id_cotizacion_detallada,
             c.id_tipo_trabajo,
             t.description             tipo_trab_desc,
             tc.id_actividad_principal actividad,
             c.costo,
             c.precio,
             c.margen,
             c.iva,
             c.precio_total,
             tc.tipo_trabajo_desc      acronimo
        FROM ldc_consolid_cotizacion c,
             or_task_type            t,
             ldc_tipos_trabajo_cot   tc
       WHERE c.id_cotizacion_detallada = tc.id_cotizacion_detallada
         AND c.id_tipo_trabajo = t.task_type_id
         AND c.id_proyecto = tc.id_proyecto
         AND c.id_tipo_trabajo = tc.id_tipo_trabajo
         AND c.id_cotizacion_detallada = inuCotizacionDetallada
         AND c.id_proyecto = inuProyecto;

    RETURN crConsolidadoCot;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => sbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  PROCEDURE proExisteTipoTrabajo(inuTipoTrabajo or_task_type.task_type_id%TYPE, -- Tipo de trabajo
                                 osbError       OUT VARCHAR2 -- Error
                                 ) IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: proDatosTipoTrabajo
    Descripci?n:        Verifica si un Tipo de tabajo existe

    Autor    : Sandra Mu?oz
    Fecha    : 10-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    10-05-2016   Sandra Mu?oz           Creaci?n
    ******************************************************************/

    sbProceso VARCHAR2(4000) := 'proDatosTipoTrabajo';
    nuPaso    NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    nuExiste  NUMBER; -- Indica si el elemento existe

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    nuPaso := 10;
    SELECT COUNT(1)
      INTO nuExiste
      FROM or_Task_type
     WHERE task_type_id = inuTipoTrabajo;

    nuPaso := 20;
    IF nuExiste = 0 THEN
      osbError := 'El tipo de trabajo ' || inuTipoTrabajo || ' no existe.';
      RAISE exError;
    END IF;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN exError THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || osbError);
    WHEN OTHERS THEN
      osbError := 'TERMIN? CON ERROR NO CONTROLADO  ' || csbPaquete || '.' ||
                  sbProceso || '(' || nuPaso || '): ' || SQLCODE;
      ut_trace.trace(osbError);
  END;

  /* PROCEDURE proInternaCotizacion(inuCotizacionDetallada ldc_tipos_trabajo_cot.id_tipo_trabajo%TYPE, -- Cotizacion
                                 inuProyecto            ldc_tipos_trabajo_cot.id_proyecto%TYPE, -- Proyecto
                                 orcInternaCotizacion   OUT ldc_tipos_trabajo_cot%ROWTYPE, -- Tipo de trabajo cotizado para interna
                                 osbError               OUT VARCHAR2) IS
      \*****************************************************************
      Propiedad intelectual de Gases del Caribe.

      Nombre del Paquete: proInternaCotizacion
      Descripci?n:

      Autor    : Sandra Mu?oz
      Fecha    : 10-05-2016

      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.              Modificaci?n
      -----------  -------------------    -------------------------------------
      10-05-2016   Sandra Mu?oz           Creaci?n
      ******************************************************************\

      sbProceso VARCHAR2(4000) := 'proInternaCotizacion';
      nuPaso    NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error

      exError EXCEPTION; -- Error controlado

  BEGIN
      ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

      BEGIN
          SELECT *
          INTO   orcInternaCotizacion
          FROM   ldc_tipos_trabajo_cot lttc
          WHERE  lttc.id_cotizacion_detallada = inuCotizacionDetallada
          AND    lttc.id_proyecto = inuProyecto
          AND    lttc.tipo_trabajo_desc = 'IN';
      EXCEPTION
          WHEN no_data_found THEN
              NULL;
      END;

      ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
      WHEN exError THEN
          ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' || sbProceso || '(' || nuPaso || '):' ||
                         osbError);
      WHEN OTHERS THEN
          osbError := 'TERMIN? CON ERROR NO CONTROLADO  ' || csbPaquete || '.' || sbProceso || '(' ||
                      nuPaso || '): ' || SQLCODE;
          ut_trace.trace(osbError);
  END;*/

  -- Existencia de datos
  FUNCTION fblExisteCotizacion(inuConsecCotizacion ldc_cotizacion_construct.id_consecutivo%TYPE -- Consecutivo ?nico
                               ) RETURN BOOLEAN IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete:  fblExisteCotizacion
    Descripci?n:         Indica si una cotizaci?n existe dado su consecutivo ?nico

    Autor    : Sandra Mu?oz
    Fecha    : 10-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    10-05-2016   Sandra Mu?oz           Creaci?n
    ******************************************************************/

    sbProceso VARCHAR2(4000) := 'fblExisteCotizacion';
    nuPaso    NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    nuExiste  NUMBER; -- Indica si existe un elemento
    sbError   VARCHAR2(4000); --  Error

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    BEGIN
      SELECT COUNT(1)
        INTO nuExiste
        FROM ldc_cotizacion_construct lcc
       WHERE lcc.id_consecutivo = inuConsecCotizacion;
    EXCEPTION
      WHEN OTHERS THEN
        sbError := 'Errror ' || SQLERRM ||
                   ' SELECT COUNT (1)
        INTO   nuExiste
        FROM   ldc_cotizacion_construct lcc
        WHERE  lcc.id_cotizacion_unico = ' ||
                   inuConsecCotizacion;
        RAISE exError;
    END;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);

    IF nuExiste = 0 THEN
      RETURN FALSE;
    END IF;

    RETURN TRUE;

  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => sbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  FUNCTION fnuProyecto(inuConsecCotizacion ldc_cotizacion_construct.id_consecutivo%TYPE -- Identificador ?nico de una cotizaci?n detallada
                       ) RETURN NUMBER IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fnuProyecto
    Descripci?n:        Retorna el n?mero del proyecto al que est? asociada la cotizaci?n

    Autor    : Sandra Mu?oz
    Fecha    : 10-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    10-05-2016   Sandra Mu?oz           Creaci?n
    ******************************************************************/

    sbProceso  VARCHAR2(4000) := 'fnuProyecto';
    nuPaso     NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    nuProyecto ldc_cotizacion_construct.id_proyecto%TYPE; -- Proyecto al que est? asociada la cotizaci?n
    sbError    VARCHAR2(4000); -- Error en el proceso

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    SELECT lcc.id_proyecto
      INTO nuProyecto
      FROM ldc_cotizacion_construct lcc
     WHERE lcc.id_consecutivo = inuConsecCotizacion;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);

    RETURN nuProyecto;

  EXCEPTION
    WHEN exError THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError);
    WHEN OTHERS THEN
      sbError := 'TERMIN? CON ERROR NO CONTROLADO  ' || csbPaquete || '.' ||
                 sbProceso || '(' || nuPaso || '): ' || SQLCODE;
      ut_trace.trace(sbError);
  END;

  FUNCTION fnuObtieneIVAInstInterna RETURN NUMBER IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fnuIVAInstInterna
    Descripci?n:        Retorna el porcentaje de IVA correspondiente al tipo de trabajo
                        de instalaci?n Interna.

    Autor    : KCienfuegos
    Fecha    : 30-06-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    06-01-2017   KCienfuegos            Se valida que la tarifa del concepto est? vigente
    30-06-2016   KCienfuegos           Creaci?n
    ******************************************************************/

    sbProceso    VARCHAR2(4000) := 'fnuIVAInstInterna';
    nuPaso       NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    nuPorcentaje ldc_consolid_cotizacion.iva%TYPE;
    sbError      VARCHAR2(4000); -- Error en el proceso

    CURSOR cuObtieneIVA IS
      SELECT ravtporc
        FROM open.ta_conftaco c,
             open.ta_tariconc t,
             open.ta_vigetaco v,
             open.ta_rangvitc r
       WHERE c.cotcconc =
             dald_parameter.fnuGetNumeric_Value('CONC_LIQIVA_INST_INTERNA',
                                                0)
         AND c.cotcserv =
             dald_parameter.fnuGetNumeric_Value('COD_PRO_GEN', 0)
         AND c.cotccons = t.tacocotc
         AND t.tacocons = v.vitctaco
         AND v.vitccons = r.ravtvitc
         AND SYSDATE BETWEEN v.vitcfein AND v.vitcfefi
         AND cotcvige = 'S';
  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    OPEN cuObtieneIVA;
    FETCH cuObtieneIVA
      INTO nuPorcentaje;
    CLOSE cuObtieneIVA;

    nuPorcentaje := nvl(nuPorcentaje, 0);

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);

    RETURN nuPorcentaje;

  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => sbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END;

  PROCEDURE proDatosCotizacion(inuConsecCotizacion    ldc_cotizacion_construct.id_consecutivo%TYPE, -- Consecutivo cotizacion
                               onuCotizacionDetallada OUT ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                               onuListaPrecios        OUT ldc_cotizacion_construct.lista_costo%TYPE, -- Lista de precios
                               odtFechaVigencia       OUT ldc_cotizacion_construct.fecha_vigencia%TYPE, -- Fecha vigencia
                               osbFormaPago           OUT ldc_proyecto_constructora.forma_pago%TYPE, -- Forma de pago
                               onuValorCotizado       OUT ldc_cotizacion_construct.valor_cotizado%TYPE, --  Valor cotizado
                               onuEstado              OUT ldc_cotizacion_construct.estado%TYPE, -- Estado
                               osbObservacion         OUT ldc_cotizacion_construct.observacion%TYPE, -- Observaci?n
                               odtFechaRegistro       OUT ldc_cotizacion_construct.fecha_creacion%TYPE, -- Fecha registro
                               odtFechaUltModif       OUT ldc_cotizacion_construct.fecha_ult_modif%TYPE, -- Fecha utima modificacion
                               onuPlanComerEsp        OUT LDC_COTIZACION_CONSTRUCT.PLAN_COMERCIAL_ESPCL%TYPE,
                               onuUnidadInsta         OUT LDC_COTIZACION_CONSTRUCT.UND_INSTALADORA_ID%TYPE,
                               onuUnidadCerti         OUT LDC_COTIZACION_CONSTRUCT.UND_CERTIFICADORA_ID%TYPE,
							   OSBFLAGGOGA            OUT LDC_COTIZACION_CONSTRUCT.FLGOGASO%TYPE) IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fcrDatosCotizacion
    Descripci?n:        Traer n?mero de la cotizaci?n detallada, lista de precios,
                        fecha de vigencia, forma de pago, valor cotizado, estado,
                        observaci?n, fecha de registro, fecha de ?ltima modificaci?n
                        todos esos datos, a partir del campo que me creaste ahorita

    Autor    : Sandra Mu?oz
    Fecha    : 10-05-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    10-05-2016   Sandra Mu?oz           Creaci?n
	09/10/2019   horbath                ca 153 se agrega campo de flag de generacion de orden gasodomestico
    ******************************************************************/

    sbProceso VARCHAR2(4000) := 'fcrDatosCotizacion';
    nuPaso    NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    sbError   VARCHAR2(4000); -- Error

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    -- Consulta cursor referenciado
    SELECT lcc.id_cotizacion_detallada,
           lcc.lista_costo,
           lcc.fecha_vigencia,
           lpc.forma_pago,
           lcc.valor_cotizado,
           lcc.estado,
           lcc.observacion,
           lcc.fecha_creacion,
           lcc.fecha_ult_modif,
           lcc.PLAN_COMERCIAL_ESPCL,
           lcc.UND_INSTALADORA_ID,
           lcc.UND_CERTIFICADORA_ID,
		   lcc.FLGOGASO
      INTO onuCotizacionDetallada,
           onuListaPrecios,
           odtFechaVigencia,
           osbFormaPago,
           onuValorCotizado,
           onuEstado,
           osbObservacion,
           odtFechaRegistro,
           odtFechaUltModif,
           onuPlanComerEsp,
           onuUnidadInsta,
           onuUnidadCerti,
		   OSBFLAGGOGA
      FROM ldc_cotizacion_construct lcc, ldc_proyecto_constructora lpc
     WHERE lcc.id_consecutivo = inuConsecCotizacion
       AND lcc.id_proyecto = lpc.id_proyecto;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => sbError);
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;

  END;

  PROCEDURE proCotizacionDetalladaAprobada(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                           onuCotizacionDetallada OUT ldc_cotizacion_construct.id_cotizacion_detallada%TYPE -- Cotizaci?n detallada aprobada
                                           ) IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: proCotizacionDetalladaAprobada
    Descripci?n:        Retorna la cotizaci?n detallada aprobada para el proyecto

    Autor    : Sandra Mu?oz
    Fecha    : 17-06-2016  CA 200-201

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    17-06-2016   Sandra Mu?oz           Creaci?n
    ******************************************************************/

    sbProceso VARCHAR2(4000) := 'proCotizacionDetalladaAprobada';
    nuPaso    NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    sbError   VARCHAR2(4000); -- Error

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    BEGIN
      SELECT lcc.id_cotizacion_detallada
        INTO onuCotizacionDetallada
        FROM ldc_cotizacion_construct lcc
       WHERE lcc.id_proyecto = inuProyecto
         AND lcc.estado IN
             (csbCotizacionAprobada, csbCotizacionPreAprobada);
    EXCEPTION
      WHEN no_data_found THEN
        sbError := 'No existe cotizaci?n aprobada ni preaprobada para el proyecto ' ||
                   inuProyecto;
        RAISE ex.Controlled_Error;
      WHEN too_many_rows THEN
        sbError := 'Existen varias cotizaciones en estado aprobado/preaprobado para el proyecto ' ||
                   inuProyecto;
        RAISE ex.Controlled_Error;
    END;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError,
                     1);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => sbError);
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ut_trace.trace('TERMIN? CON ERROR NO CONTROLADO' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || SQLERRM,
                     1);
      ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError,
                      isbargument     => sbError);
      RAISE EX.CONTROLLED_ERROR;
  END;

  PROCEDURE proPlantilla(nuDato NUMBER, osbError OUT VARCHAR2) IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete:
    Descripci?n:

    Autor    : Sandra Mu?oz
    Fecha    : 10-05-2016  CA 200-201

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    15-04-2016   Sandra Mu?oz           Creaci?n
    ******************************************************************/

    sbProceso VARCHAR2(4000) := 'proInsertarMantenimientoNota';
    nuPaso    NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error

    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso);

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN exError THEN
      ut_trace.trace('TERMIN? CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || osbError);
    WHEN OTHERS THEN
      osbError := 'TERMIN? CON ERROR NO CONTROLADO  ' || csbPaquete || '.' ||
                  sbProceso || '(' || nuPaso || '): ' || SQLCODE;
      ut_trace.trace(osbError);
  END;

END LDC_BCCOTIZACIONCONSTRUCTORA;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BCCOTIZACIONCONSTRUCTORA', 'ADM_PERSON'); 
END;
/
