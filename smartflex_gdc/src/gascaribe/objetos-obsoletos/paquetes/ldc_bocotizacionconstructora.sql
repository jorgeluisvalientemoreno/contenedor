create or replace PACKAGE ldc_boCotizacionConstructora IS

    csbTipoTrabajoInterna        CONSTANT ldc_tipos_trabajo_cot.tipo_trabajo_desc%TYPE := 'IN'; -- Tipo de trabajo Interna
    csbTipoTrabajoCargoXConexion CONSTANT ldc_tipos_trabajo_cot.tipo_trabajo_desc%TYPE := 'CC'; -- Tipo de trabajo cargo por conexion
    csbTipoTrabajoCertificacion  CONSTANT ldc_tipos_trabajo_cot.tipo_trabajo_desc%TYPE := 'CE'; -- Tipo de trabajo certificacon
    csbCotizacionPreAprobada ldc_cotizacion_construct.estado%TYPE := 'P';
    csbCotizacionAprobada    ldc_cotizacion_construct.estado%TYPE := 'A';

    PROCEDURE proCreaCotizacion(inuProyecto                ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                isbObservacion             ldc_cotizacion_construct.observacion%TYPE, -- Observacion
                                inuLista_costo             ldc_cotizacion_construct.lista_costo%TYPE, -- Lista costo
                                idtFechaVigencia           ldc_cotizacion_construct.fecha_vigencia%TYPE, -- Fecha vigencia
                                inuValorCotizado           ldc_cotizacion_construct.valor_cotizado%TYPE, --Valor cotizado
                                inuPlanComercial           ldc_cotizacion_construct.plan_comercial_espcl%TYPE, --Plan comercial
                                isbFormaPago               ldc_proyecto_constructora.forma_pago%TYPE DEFAULT NULL, --Forma de Pago
                                inuUnidInsta                ldc_cotizacion_construct.UND_INSTALADORA_ID%TYPE, --unidad instaladora
                                inuUnidadCert              ldc_cotizacion_construct.UND_CERTIFICADORA_ID%TYPE, --unidad certificadora
                                isbFlagGoga                LDC_COTIZACION_CONSTRUCT.FLGOGASO%TYPE, --flag genera orden de gasodomestico    
                                onuId_cotizacion_detallada OUT ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                                osbError                   OUT VARCHAR2);

    PROCEDURE proModifDatosBasicosCotizacion(inuProyecto                ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                             inuId_cotizacion_detallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, --Cotizacion detallada
                                             isbObservacion             ldc_cotizacion_construct.observacion%TYPE, -- Observacion
                                             inuLista_costo             ldc_cotizacion_construct.lista_costo%TYPE, -- Lista costo
                                             idtFechaVigencia           ldc_cotizacion_construct.fecha_vigencia%TYPE, -- Fecha vigencia
                                             inuValorCotizado           ldc_cotizacion_construct.valor_cotizado%TYPE, --Valor cotizado
                                             inuPlanComercial           ldc_cotizacion_construct.plan_comercial_espcl%TYPE, --Plan comercial
                                             isbFormaPago               ldc_proyecto_constructora.forma_pago%TYPE, --Forma de Pago
                                             inuUnidInsta                ldc_cotizacion_construct.UND_INSTALADORA_ID%TYPE, --unidad instaladora
                                             inuUnidadCert              ldc_cotizacion_construct.UND_CERTIFICADORA_ID%TYPE, --unidad certificadora
                                             isbFlagGoga                LDC_COTIZACION_CONSTRUCT.FLGOGASO%TYPE, --flag genera orden de gasodomestico   
                                             osbError                   OUT VARCHAR2);

    PROCEDURE proModifItemsUnidPred(inuProyecto            ldc_items_por_unid_pred.id_proyecto%TYPE, -- Proyecto
                                    inuCotizacionDetallada ldc_items_por_unid_pred.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                    inuPiso                ldc_items_por_unid_pred.id_piso%TYPE, -- Piso
                                    inuUnidPredial         ldc_items_por_unid_pred.id_unidad_predial%TYPE, -- Unidad predial
                                    inuItemCotizado        ldc_items_por_unid_pred.id_item_cotizado%TYPE, -- Item cotizado
                                    inuNuevoItem           ldc_items_por_unid_pred.id_item%TYPE, -- Item
                                    inuNuevaCantidad       ldc_items_por_unid_pred.cantidad%TYPE, -- Cantidad
                                    inuNuevoPrecio         ldc_items_por_unid_pred.precio%TYPE, -- Precio
                                    inuNuevoValFijo        ldc_items_por_unid_pred.id_val_fijo%TYPE, -- ValFijo
                                    inuNuevoPrecioTotal    ldc_items_por_unid_pred.precio_total%TYPE, -- Precio total
                                    osbError               OUT VARCHAR -- Error
                                    );

    PROCEDURE proModifConsolidaCotizacion(inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                                          inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                          inuTipoTrabajo         or_task_type.task_type_id%TYPE, -- Tipo de trabajo
                                          inuCosto               ldc_consolid_cotizacion.costo%TYPE, --Costo
                                          inuPrecio              ldc_consolid_cotizacion.precio%TYPE, --Precio
                                          inuMargen              ldc_consolid_cotizacion.margen%TYPE, --margen
                                          inuIva                 ldc_consolid_cotizacion.iva%TYPE, --iva
                                          isbOperacion           VARCHAR2);

    PROCEDURE proModifTiposTrabajo(inuCotizacionDetallada ldc_val_fijos_unid_pred.id_cotizacion_detallada%TYPE, -- Cotizacion
                                   inuProyecto            ldc_val_fijos_unid_pred.id_proyecto%TYPE, -- Proyecto
                                   isbTipoTrabDesc        ldc_tipos_trabajo_cot.tipo_trabajo_desc%TYPE, -- Tipo Trabajo
                                   inuTipoTrab            ldc_tipos_trabajo_cot.id_tipo_trabajo%TYPE,
                                   inuActividad           ldc_tipos_trabajo_cot.id_actividad_principal%TYPE,
                                   isbOperacion           VARCHAR2,
                                   osbError               OUT VARCHAR2 -- Error
                                   );

    PROCEDURE proModifItemsFijos(inuCotizacionDetallada ldc_items_cotiz_proy.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                 inuProyecto            ldc_items_cotiz_proy.id_proyecto%TYPE, -- Proyecto
                                 inuItem                ldc_items_cotiz_proy.id_item%TYPE, -- Item
                                 inuNuevaCantidad       ldc_items_cotiz_proy.cantidad%TYPE, -- Cantidad
                                 inuNuevoPrecio         ldc_items_cotiz_proy.precio%TYPE, -- Precio
                                 inuNuevoCosto          ldc_items_cotiz_proy.precio%TYPE, --Costo
                                 isbTipoItem            ldc_items_cotiz_proy.tipo_item%TYPE, -- Tipo item
                                 inuTipoTrab            ldc_items_cotiz_proy.tipo_trab%TYPE, -- Tipo de trabajo
                                 isbTipoOperacion       VARCHAR2,
                                 osbError               OUT VARCHAR2 -- Error
                                 );

    PROCEDURE proModifMetrajeXPisoYTipo(inuCotizacionDetallada ldc_detalle_met_cotiz.id_cotizacion_detallada%TYPE, -- Cotizacion
                                        inuProyecto            ldc_detalle_met_cotiz.id_proyecto%TYPE, -- Proyecto
                                        inuPiso                ldc_detalle_met_cotiz.id_piso%TYPE, -- Piso
                                        inuTipo                ldc_detalle_met_cotiz.id_tipo%TYPE, -- Tipo
                                        inuFlauta              ldc_detalle_met_cotiz.flauta%TYPE, -- Flauta
                                        inuHorno               ldc_detalle_met_cotiz.horno%TYPE, -- Horno
                                        inuBBQ                 ldc_detalle_met_cotiz.bbq%TYPE, -- BBQ
                                        inuEstufa              ldc_detalle_met_cotiz.estufa%TYPE, -- Estufa
                                        inuSecadora            ldc_detalle_met_cotiz.secadora%TYPE, -- Secadora
                                        inuCalentador          ldc_detalle_met_cotiz.calentador%TYPE, -- Calentador
                                        inuLongValBaj          ldc_detalle_met_cotiz.long_val_baj%TYPE, -- LongValVaj
                                        inuLongBajante         ldc_detalle_met_cotiz.long_bajante%TYPE, -- LongBajante
                                        inuLongBajTab          ldc_detalle_met_cotiz.long_baj_tab%TYPE, -- LongBajTab
                                        inuLongTablero         ldc_detalle_met_cotiz.long_tablero%TYPE, -- LongTablero
                                        inuCantUnidPred        ldc_detalle_met_cotiz.cant_unid_pred%TYPE -- CantUnidPred
                                        );

    PROCEDURE proModifValoresFijos(inuCotizacionDetallada ldc_val_fijos_unid_pred.id_cotizacion_detallada%TYPE, -- Cotizacion
                                   inuProyecto            ldc_val_fijos_unid_pred.id_proyecto%TYPE, -- Proyecto
                                   inuNuevaCantidad       ldc_val_fijos_unid_pred.cantidad%TYPE, -- Nueva cantidad
                                   inuNuevoPrecio         ldc_val_fijos_unid_pred.precio%TYPE, -- Nuevo precio
                                   inuValFijo             ldc_val_fijos_unid_pred.id_item%TYPE, -- Valor fijo
                                   inuTipoTrab            or_task_type.task_type_id%TYPE, --Tipo de Trabajo
                                   isbDescripcion         ldc_val_fijos_unid_pred.descripcion%TYPE, --Descripcion
                                   isbOperacion           VARCHAR2);

    PROCEDURE proModifItemsXMetraje(inuCotizacionDetallada ldc_items_metraje_cot.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                    inuProyecto            ldc_items_metraje_cot.id_proyecto%TYPE, -- Proyecto
                                    inuItem                ldc_items_metraje_cot.id_item%TYPE, -- Item
                                    isbFlauta              ldc_items_metraje_cot.flauta%TYPE, -- Flauta
                                    isbBBQ                 ldc_items_metraje_cot.bbq%TYPE, -- BBQ
                                    isbHorno               ldc_items_metraje_cot.horno%TYPE, -- Horno
                                    isbEstufa              ldc_items_metraje_cot.estufa%TYPE, -- Estufa
                                    isbSecadora            ldc_items_metraje_cot.secadora%TYPE, -- Secadora
                                    isbCalentador          ldc_items_metraje_cot.calentador%TYPE, -- Calentador
                                    isbLongValBajante      ldc_items_metraje_cot.log_val_bajante%TYPE, -- LongValBajante
                                    isbLongBajante         ldc_items_metraje_cot.long_bajante%TYPE, -- LongBajante
                                    isbLongBajTablero      ldc_items_metraje_cot.long_baj_tablero%TYPE, -- LongBajTablero
                                    isbLongTablero         ldc_items_metraje_cot.long_tablero%TYPE, -- LongTablero
                                    inuCosto               ldc_items_por_unid_pred.costo%TYPE, --Costo
                                    inuPrecio              ldc_items_por_unid_pred.precio%TYPE, --Precio
                                    isbTipoItem            VARCHAR2,
                                    isbOperacion           VARCHAR2);

    PROCEDURE proModifItemsUnidPredial(inuCotizacionDetallada ldc_items_cotiz_proy.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                       inuProyecto            ldc_items_cotiz_proy.id_proyecto%TYPE, -- Proyecto
                                       inuItem                ldc_items_cotiz_proy.id_item%TYPE, -- Item
                                       inuNuevaCantidad       ldc_items_cotiz_proy.cantidad%TYPE, -- Cantidad
                                       inuNuevoPrecio         ldc_items_cotiz_proy.precio%TYPE, -- Precio
                                       inuNuevoCosto          ldc_items_cotiz_proy.precio%TYPE, --Costo
                                       isbTipoItem            ldc_items_cotiz_proy.tipo_item%TYPE, -- Tipo item
                                       inuTipoTrab            ldc_items_cotiz_proy.tipo_trab%TYPE,
                                       isbTipoOperacion       VARCHAR2);

    PROCEDURE proModifValFijoUnidPredial(inuCotizacionDetallada ldc_items_cotiz_proy.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                         inuProyecto            ldc_items_cotiz_proy.id_proyecto%TYPE, -- Proyecto
                                         inuItem                ldc_items_por_unid_pred.id_val_fijo%TYPE, -- Item
                                         inuNuevaCantidad       ldc_items_cotiz_proy.cantidad%TYPE, -- Cantidad
                                         inuNuevoPrecio         ldc_items_cotiz_proy.precio%TYPE, -- Precio
                                         isbTipoItem            ldc_items_cotiz_proy.tipo_item%TYPE, -- Tipo item
                                         inuTipoTrab            or_task_type.task_type_id%TYPE, --Tipo de Trabajo
                                         isbTipoOperacion       VARCHAR2);

    PROCEDURE proModifItemsMetUnidPredial(inuCotizacionDetallada ldc_items_cotiz_proy.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                          inuProyecto            ldc_items_cotiz_proy.id_proyecto%TYPE, -- Proyecto
                                          inuItem                ldc_items_por_unid_pred.id_val_fijo%TYPE, -- Item
                                          inuNuevoPrecio         ldc_items_cotiz_proy.precio%TYPE, -- Precio
                                          inuNuevoCosto          ldc_items_cotiz_proy.costo%TYPE, --Costo
                                          isbTipoItem            ldc_items_cotiz_proy.tipo_item%TYPE, -- Tipo item
                                          isbTipoOperacion       VARCHAR2);

    PROCEDURE proCreaTiposTrabajoxCot(inuCotizacionDetallada ldc_tipos_trabajo_cot.id_cotizacion_detallada%TYPE, -- Cotizacion
                                      inuProyecto            ldc_tipos_trabajo_cot.id_proyecto%TYPE, -- Proyecto
                                      inuTipoTrab            ldc_tipos_trabajo_cot.id_tipo_trabajo%TYPE, --Tipo de trabajo
                                      inuItem                ldc_tipos_trabajo_cot.id_actividad_principal%TYPE,
                                      isbTipoTrab            ldc_tipos_trabajo_cot.tipo_trabajo_desc%TYPE);

    PROCEDURE proCreaItemsFijos(inuCotizacionDetallada ldc_items_cotiz_proy.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                inuProyecto            ldc_items_cotiz_proy.id_proyecto%TYPE, -- Proyecto
                                inuItem                ldc_items_cotiz_proy.id_item%TYPE, -- Item
                                inuCantidad            ldc_items_cotiz_proy.cantidad%TYPE, -- Cantidad
                                inuPrecio              ldc_items_cotiz_proy.precio%TYPE, -- Precio
                                inuCosto               ldc_items_cotiz_proy.costo%TYPE, -- Costo
                                isbTipoItem            ldc_items_cotiz_proy.tipo_item%TYPE, -- Tipo item
                                inuTipoTrab            ldc_items_cotiz_proy.tipo_trab%TYPE, -- Tipo de trabajo
                                osbError               OUT VARCHAR2 -- Error
                                );

    PROCEDURE proCreaValoresFijos(inuItem                ldc_val_fijos_unid_pred.id_item%TYPE, -- Item
                                  inuCotizacionDetallada ldc_val_fijos_unid_pred.id_cotizacion_detallada%TYPE, -- Cotizacion
                                  inuProyecto            ldc_val_fijos_unid_pred.id_proyecto%TYPE, -- Proyecto
                                  isbDescripcion         ldc_val_fijos_unid_pred.descripcion%TYPE, -- Descripcion
                                  inuCantidad            ldc_val_fijos_unid_pred.cantidad%TYPE, -- Cantidad
                                  inuPrecio              ldc_val_fijos_unid_pred.precio%TYPE, -- Precio
                                  inuTipoTrab            or_task_type.task_type_id%TYPE, --Tipo trabajo
                                  osbError               OUT VARCHAR2);

    PROCEDURE proCreaMetrajeXPisoYTipo(inuCotizacionDetallada ldc_detalle_met_cotiz.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                       inuPiso                ldc_detalle_met_cotiz.id_piso%TYPE, -- Piso
                                       inuTipo                ldc_detalle_met_cotiz.id_tipo%TYPE, -- Tipo unidad predial
                                       inuFlauta              ldc_detalle_met_cotiz.flauta%TYPE, -- Flauta
                                       inuHorno               ldc_detalle_met_cotiz.horno%TYPE, -- Horno
                                       inuBBQ                 ldc_detalle_met_cotiz.bbq%TYPE, -- BBQ
                                       inuEstufa              ldc_detalle_met_cotiz.estufa%TYPE, -- Estufa
                                       inuSecadora            ldc_detalle_met_cotiz.secadora%TYPE, -- Secadora
                                       inuCalentador          ldc_detalle_met_cotiz.calentador%TYPE, -- Calentador
                                       inuLongValBaj          ldc_detalle_met_cotiz.long_val_baj%TYPE, -- Longitud val bajante
                                       inuLongBajante         ldc_detalle_met_cotiz.long_bajante%TYPE, -- Longitud bajante
                                       inuLongBajTab          ldc_detalle_met_cotiz.long_baj_tab%TYPE, -- Longitud bajante a tablero
                                       inuLongTablero         ldc_detalle_met_cotiz.long_tablero%TYPE, -- Longitud tablero
                                       inuProyecto            ldc_detalle_met_cotiz.id_proyecto%TYPE, -- Id proyecto
                                       osbError               OUT VARCHAR2);

    PROCEDURE proCreaItemsXMetraje(inuCotizacion     ldc_items_metraje_cot.id_cotizacion_detallada%TYPE,
                                   inuItem           ldc_items_metraje_cot.id_item%TYPE, -- Item
                                   inuPrecio         ldc_items_metraje_cot.precio%TYPE, -- Precio
                                   inuCosto          ldc_items_metraje_cot.precio%TYPE, -- Costo
                                   isbFlauta         ldc_items_metraje_cot.flauta%TYPE, -- Flauta
                                   isbBbq            ldc_items_metraje_cot.bbq%TYPE, -- Bbq
                                   isbHorno          ldc_items_metraje_cot.horno%TYPE, -- Horno
                                   isbEstufa         ldc_items_metraje_cot.estufa%TYPE, -- Estufa
                                   isbSecadora       ldc_items_metraje_cot.secadora%TYPE, -- Secadora
                                   isbCalentador     ldc_items_metraje_cot.calentador%TYPE, -- Calentador
                                   isbValBajante     ldc_items_metraje_cot.log_val_bajante%TYPE, -- Valor bajante
                                   isbLongBajante    ldc_items_metraje_cot.long_bajante%TYPE, -- Longitud bajante
                                   isbLongBajTablero ldc_items_metraje_cot.long_baj_tablero%TYPE, -- Long bajante tablero
                                   isbLongTablero    ldc_items_metraje_cot.long_tablero%TYPE, -- Long tablero
                                   inuProyecto       ldc_items_metraje_cot.id_proyecto %TYPE, -- Proyecto
                                   inuTipoTrabajo    ldc_items_por_unid_pred.id_tipo_trabajo%TYPE, --Tipo de Trabajo
                                   osbError          OUT VARCHAR2 -- Error
                                   );

    PROCEDURE proCreaItemsMetUnidPredial(inuCotizacionDetallada ldc_items_cotiz_proy.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                         inuProyecto            ldc_items_cotiz_proy.id_proyecto%TYPE, -- Proyecto
                                         inuItem                ldc_items_por_unid_pred.id_val_fijo%TYPE, -- Item
                                         inuNuevoPrecio         ldc_items_cotiz_proy.precio%TYPE, -- Precio
                                         inuNuevoCosto          ldc_items_cotiz_proy.costo%TYPE, --Costo
                                         inuTipoTrabajo         ldc_items_por_unid_pred.id_tipo_trabajo%TYPE --Tipo trabajo
                                         );

    PROCEDURE proCreaItemsUnidPred(inuProyecto            ldc_items_por_unid_pred.id_proyecto%TYPE, -- Proyecto
                                   inuCotizacionDetallada ldc_items_por_unid_pred.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                   inuUnidPredial         ldc_items_por_unid_pred.id_unidad_predial%TYPE, -- Unidad predial
                                   inuTipoTrabajo         ldc_items_por_unid_pred.id_tipo_trabajo%TYPE, -- Tipo de trabajo
                                   inuItem                ldc_items_por_unid_pred.id_item%TYPE, -- Item
                                   inuValFijo             ldc_items_por_unid_pred.id_val_fijo%TYPE, -- Valor fijo
                                   inuCantidad            ldc_items_por_unid_pred.cantidad%TYPE, -- Cantidad
                                   inuPrecio              ldc_items_por_unid_pred.precio%TYPE, -- Precio
                                   inuPiso                ldc_items_por_unid_pred.id_piso%TYPE, -- Piso
                                   osbError               OUT VARCHAR2 -- Error
                                   );

    PROCEDURE proCreaItemsUnidPredGenerico(inuProyecto            ldc_items_por_unid_pred.id_proyecto%TYPE, -- Proyecto
                                           inuCotizacionDetallada ldc_items_por_unid_pred.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                           inuItem                ldc_items_por_unid_pred.id_item%TYPE, -- Item
                                           inuTipoTrab            ldc_items_cotiz_proy.tipo_trab%TYPE, -- Tipo de trabajo
                                           inuValFijo             ldc_items_por_unid_pred.id_val_fijo%TYPE, -- Valor fijo
                                           inuCantidad            ldc_items_por_unid_pred.cantidad%TYPE, -- Cantidad
                                           inuPrecio              ldc_items_por_unid_pred.precio%TYPE, -- Precio
                                           inuCosto               ldc_items_por_unid_pred.precio%TYPE, -- Costo
                                           inuPiso                ldc_items_por_unid_pred.id_piso%TYPE, -- Piso
                                           inuTipo                ldc_unidad_predial.id_tipo_unid_pred%TYPE, --Tipo
                                           isbTipoItem            ldc_items_por_unid_pred.tipo_item%TYPE);

    PROCEDURE proCreaConsolidaCotizacion(inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                                         inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                         inuTipoTrabajo         or_task_type.task_type_id%TYPE, -- Tipo de trabajo
                                         inuIva                 ldc_consolid_cotizacion.iva%TYPE, -- Iva
                                         inuPrecio              ldc_consolid_cotizacion.precio%TYPE,
                                         inuCosto               ldc_consolid_cotizacion.costo%TYPE,
                                         inuMargen              ldc_consolid_cotizacion.margen%TYPE,
                                         inuPrecioTotal         ldc_consolid_cotizacion.precio_total%TYPE);

    PROCEDURE proImprimePrecupon(inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                                 inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, -- Cotizacion
                                 isbRuta                VARCHAR2, -- Ruta en la que se almacenara el archivo PDF
                                 isbNombreArchivo       VARCHAR2, -- Nombre del archivo a generar
                                 osbError               OUT VARCHAR2 -- Error
                                 );

    PROCEDURE proCopiarCotizacionDetallada(inuProyecto                  ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                           inuCotizacionDetalladaOrigen ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion origen
                                           onuNuevaCotizacionDetallada  OUT ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion nueva
                                           osbError                     OUT VARCHAR2);

    PROCEDURE proPreAprueba(inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                            inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                            inuDireccionCobro      suscripc.susciddi%TYPE, -- Direccion de cobro del contrato a crear
                            inuActividad           ge_items.items_id%TYPE, -- Actividad inicial
                            inuCiclo               ciclo.ciclcodi%TYPE, --Ciclo
                            osbError OUT VARCHAR2);

    PROCEDURE proCrearContratoOSF(inuDireccionCobro   IN suscripc.susciddi%TYPE, -- Direccion de cobro
                                  inuProyecto         IN ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                  inuCiclo            IN ciclo.ciclcodi%TYPE, --Ciclo
                                  onuNuevoContratoOSF OUT ldc_proyecto_constructora.suscripcion%TYPE, -- Contrato generado en OSF
                                  osbError            OUT VARCHAR2);

    PROCEDURE proCreaCotizacionOSF(inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                   inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                                   inuSolicitudVenta      mo_packages.package_id%TYPE, -- Solicitud venta
                                   inuActividad           ge_items.items_id%TYPE, -- Actividad
                                   inuModalidadPago       ld_parameter.numeric_value%TYPE,
                                   osbError               OUT VARCHAR2);

    PROCEDURE proCreaVentaConstructora(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                       inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                       inuMedioRecepcion      GE_RECEPTION_TYPE.RECEPTION_TYPE_ID%TYPE DEFAULT 1, -- Medio de recepcion
                                       inuActividad           ge_items.items_id%TYPE, -- Actividad
                                       onuSolicitudVenta      OUT mo_packages.package_id%TYPE, -- Solicitud venta
                                       osbError               OUT VARCHAR2 -- Error
                                       );

    PROCEDURE ProAnulaCotizacion;

    PROCEDURE Process_solventa;

    PROCEDURE proAsociaVentaConProyecto(inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                                        inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                        inuSolicitudVenta      mo_packages.package_id%TYPE, -- Solicitud venta
                                        osbError               OUT VARCHAR2);

    PROCEDURE proEnviaCorreoMargen(inuProyecto  IN  ldc_proyecto_constructora.id_proyecto%TYPE,
                                   inuCotizacion IN ldc_cotizacion_construct.id_cotizacion_detallada%TYPE,
                                   inuMargenInt  IN NUMBER,
                                   inuValMargenInt  IN NUMBER);

    PROCEDURE proEnviaCorreo(isbPara    VARCHAR2, -- Para quien va dirigido el correo
                             isbCC      VARCHAR2 DEFAULT NULL, --Copia del correo
                             isbAsunto  VARCHAR2, -- Asunto del correo
                             iclMensaje CLOB -- Mensaje
                             );

    PROCEDURE proGeneraCuponInicial(inuPackage  IN mo_packages.package_id%TYPE);
      /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proGeneraCuponInicial
        Descripcion:        genera cupon de cuota inciial plan 110

        Autor    : Josh Brito
        Fecha    :25/01/2019

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------

        ******************************************************************/
    FUNCTION 	FNUVALIVENTESP (inuPackage  IN mo_packages.package_id%TYPE) RETURN NUMBER;
      /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: FNUVALIVENTESP
        Descripcion:        valida si la venta de cnstructora es especial o no

        Autor    : Josh Brito
        Fecha    :10/04/2019
        Ticket   : 200-2022


        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------

	     ******************************************************************/

  PROCEDURE 	proGetActividadesPlEspe (inuplanespe  IN LDC_COTIZACION_CONSTRUCT.PLAN_COMERCIAL_ESPCL%TYPE,
                                       onuActividadcxc  OUT NUMBER,
                                      onuActividadins  OUT NUMBER,
                                      osbPlanEspe  OUT VARCHAR2);
      /*****************************************************************
      Propiedad intelectual de Gases del Caribe.

      Nombre del Paquete: proGetActividadesPlEspe
      Descripcion:        Retorna actividades de cxc y certi a constructora

      Autor    : Josh Brito
      Fecha    :10/04/2019
      Ticket   : 200-2022

      Datos de Entrada
      inuplanespe  plan especial
      Datos de salida
      onuActividadcxc actividad cxc 1 si 0 no
      onuActividadins actividad insp 1 si 0 no

      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.              Modificacion
      -----------  -------------------    -------------------------------------
    ******************************************************************/
     TYPE tyRefCursor IS REF CURSOR;
     
     FUNCTION FrfOrdenInternas(inuProyecto number) RETURN tyRefCursor;
      /*****************************************************************
      Propiedad intelectual de Gases del Caribe.

      Nombre del proceso: FrfOrdenInternas
      Descripcion:        Retorna ordenes de internas

      Autor    : Horbath
      Fecha    :16/10/2019
      Ticket   : 153

      Datos de Entrada
      inuProyecto  codigo del proyecto

      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.              Modificacion
      -----------  -------------------    -------------------------------------
    ******************************************************************/
    
    FUNCTION FrfOrdenInternasMod(inuProyecto number) RETURN tyRefCursor;
    /*****************************************************************
      Propiedad intelectual de Gases del Caribe.

      Nombre del proceso: FrfOrdenInternasMod
      Descripcion:        Retorna ordenes de internas

      Autor    : Horbath
      Fecha    :16/10/2019
      Ticket   : 153

      Datos de Entrada
      inuProyecto  codigo del proyecto

      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.              Modificacion
      -----------  -------------------    -------------------------------------
    ******************************************************************/
    
      PROCEDURE  prPermLegaOrden( inuOrden in number,
                                inuSolicitud IN NUMBER,
                                inuProyecto IN NUMBER,
                                isbEstado IN VARCHAR2,
                                onuok out number,
                                osberror out varchar2);
      /*****************************************************************
      Propiedad intelectual de Gases del Caribe.

      Nombre del proceso: prPermLegaOrden
      Descripcion:        permite o no legalizar la orden

      Autor    : Horbath
      Fecha    :16/10/2019
      Ticket   : 153

      Datos de Entrada
      inuOrden  codigo de la orden
      inuSolicitud  numero de la solicitud
      inuProyecto   numero del proyecto
      isbEstado  estado
      Datos de salida
      onuok   -1 error 0 correcto
      osberror  mensaje de error
      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.              Modificacion
      -----------  -------------------    -------------------------------------
    ******************************************************************/
    
    PROCEDURE  prModiOrdInte( inuOrdenOrig in number,
                              inuOrdenDest IN NUMBER,                               
                              onuok out number,
                              osberror out varchar2);
      /*****************************************************************
      Propiedad intelectual de Gases del Caribe.

      Nombre del proceso: prModiOrdInte
      Descripcion:        modifica orden interna

      Autor    : Horbath
      Fecha    :16/10/2019
      Ticket   : 153

      Datos de Entrada
        inuOrden  codigo de la orden
        inuSolicitud  numero de la solicitud
        inuProyecto   numero del proyecto
        isbEstado  estado
      Datos de salida
        onuok   -1 error 0 correcto
        osberror  mensaje de error
      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.              Modificacion
      -----------  -------------------    -------------------------------------
    ******************************************************************/
END ldc_boCotizacionConstructora;
/
create or replace PACKAGE BODY ldc_boCotizacionConstructora IS

        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: ldc_boCotizacionConstructora
        Descripcion:        

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Creacion
		01/11/2023   Jsoto					OSF-1780 Ajustes para cambiar uso de algunos objetos de producto
											por objetos personalizados. Manejo de trazas, errores y llamados a otros
											objetos para armado de xml para solicitudes
        ******************************************************************/

    ------------------------------------------------------------------------------------------------
    -- Datos de paquete
    ------------------------------------------------------------------------------------------------
    csbPaquete            VARCHAR2(30) := 'ldc_boCotizacionConstructora';
    gsbUpdateOperation    VARCHAR2(1) := 'U';
    gsbDeleteOperation    VARCHAR2(1) := 'D';
    gsbItemsFijosProyecto VARCHAR2(2) := 'FP';
    gsbItemsFijosUnidad   VARCHAR2(2) := 'FU';
    gsbValoresFijos       VARCHAR2(2) := 'VF';
    gsbItemsPorUnidad     VARCHAR2(2) := 'IU';
    gsbItemsPorMetraje    VARCHAR2(2) := 'IM';
    cnuDescriptionError   CONSTANT NUMBER := 2741;
    cnuNullValue          CONSTANT NUMBER := 2126;
    csbCotizAprobada      CONSTANT VARCHAR2(1) := 'A';
    csbCotizPreaprobada   CONSTANT VARCHAR2(1) := 'P';
    csbCotizAnulada	      CONSTANT VARCHAR2(1) := 'N';
    cnuProductoGas        CONSTANT NUMBER := dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS',0);
    cnuProductoGenerico   CONSTANT NUMBER := dald_parameter.fnuGetNumeric_Value('COD_PRO_GEN',0);
    cnuprod_motive_comp_id CONSTANT NUMBER:=90;
    cnucomponent_type_id   CONSTANT NUMBER:=6260;
    cnuMotive_type_id      CONSTANT NUMBER :=108;
    cnumotive_status_id    CONSTANT NUMBER:= 15;
    cnuProductMotiveId     CONSTANT NUMBER:= 114;
    csbTagName             CONSTANT VARCHAR2(600):='C_GENERICO_90';
	
		--CONSTANTES
	sbXmlSol  constants_per.tipo_xml_sol%type;
		-- Constantes para el control de la traza
	cnuNVLTRC 	CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;


    ------------------------------------------------------------------------------------------------
    -- Errores
    ------------------------------------------------------------------------------------------------
    cnuDescripcionError NUMBER := 2741; -- Descripcion del error

    PROCEDURE proDatosModifCotizacion(inuProyecto   ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                      inuCotizacion ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                                      osbError      OUT VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDatosModifCotizacion
        Descripcion:        Modifica la fecha y usuario de modificacion de una cotizacion

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'.proDatosModifCotizacion';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        UPDATE ldc_cotizacion_construct lcc
        SET    lcc.fecha_ult_modif = SYSDATE,
               lcc.usua_ult_modif  = USER
        WHERE  lcc.id_cotizacion_detallada = inuCotizacion
        AND    lcc.id_proyecto = inuProyecto;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
			pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proModifDatosBasicosCotizacion(inuProyecto                ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                             inuId_cotizacion_detallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, --Cotizacion detallada
                                             isbObservacion             ldc_cotizacion_construct.observacion%TYPE, -- Observacion
                                             inuLista_costo             ldc_cotizacion_construct.lista_costo%TYPE, -- Lista costo
                                             idtFechaVigencia           ldc_cotizacion_construct.fecha_vigencia%TYPE, -- Fecha vigencia
                                             inuValorCotizado           ldc_cotizacion_construct.valor_cotizado%TYPE, --Valor cotizado
                                             inuPlanComercial           ldc_cotizacion_construct.plan_comercial_espcl%TYPE, --Plan comercial
                                             isbFormaPago               ldc_proyecto_constructora.forma_pago%TYPE, --Forma de Pago
                                             inuUnidInsta                ldc_cotizacion_construct.UND_INSTALADORA_ID%TYPE, --unidad instaladora
                                             inuUnidadCert              ldc_cotizacion_construct.UND_CERTIFICADORA_ID%TYPE, --unidad certificadora
                                             isbFlagGoga                LDC_COTIZACION_CONSTRUCT.FLGOGASO%TYPE, --flag genera orden de gasodomestico   
                                             osbError                   OUT VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proModifDatosBasicosCotizacion
        Descripcion:        Actualiza los datos basicos de una cotizacion detallada

        Autor    : KCienfuegos
        Fecha    : 23-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        09/10/2019    horbath               ca 153 se agrega nuevo campo flag genera orden de gasodomestico  
         20-04-2019     jbrito               ca 200-2022 se agregan campos unidad cerificadora, unidad instaladora, plan especial
        31-05-2016   Sandra Mu?oz           Registrar la ultima modificacion en la cotizacion
        23-04-2016   KCienfuegos            Creacion
        ******************************************************************/

        sbProceso    VARCHAR2(4000) := csbPaquete||'.proModifDatosBasicosCotizacion';
        nuPaso       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcCotizacion daLdc_Cotizacion_Construct.styLDC_COTIZACION_CONSTRUCT; -- Cotizacion
        rcProyecto   ldc_proyecto_constructora%ROWTYPE; -- Proyecto
        recProyecto  daldc_proyecto_constructora.styLDC_PROYECTO_CONSTRUCTORA;
        rcLista      ge_list_unitary_cost%ROWTYPE; -- Lista de costo

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Validacion de datos
        nuPaso := 10;
        ldc_bcProyectoConstructora.proDatosProyecto(inuproyecto => inuProyecto,
                                                    orcproyecto => rcProyecto,
                                                    osbError    => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(cnuDescriptionError, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        nuPaso := 20;

        IF inuLista_costo IS NOT NULL THEN
            ldc_bcCotizacionConstructora.proDatosListaCostos(inuListaCostos => inuLista_costo,
                                                             orcLista       => rcLista,
                                                             osbError       => osbError);

            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage(cnuDescriptionError, osbError);
                RAISE pkg_error.controlled_error;
            END IF;
        END IF;

        rcCotizacion := daldc_cotizacion_construct.frcGetRecord(inuID_COTIZACION_DETALLADA => inuId_cotizacion_detallada,
                                                                inuID_PROYECTO             => inuProyecto);
        nuPaso       := 30;

        recProyecto := daldc_proyecto_constructora.frcGetRecord(inuID_PROYECTO => inuProyecto);
        IF UPPER(isbObservacion) <> UPPER(rcCotizacion.observacion) THEN
            nuPaso                   := 40;
            rcCotizacion.observacion := isbObservacion;
        END IF;

        IF inuLista_costo <> rcCotizacion.lista_costo THEN
            nuPaso                   := 50;
            rcCotizacion.lista_costo := inuLista_costo;
        END IF;

        IF idtFechaVigencia <> nvl(rcCotizacion.fecha_vigencia, SYSDATE) THEN
            nuPaso                      := 60;
            rcCotizacion.fecha_vigencia := idtFechaVigencia;
        END IF;

        pkg_traza.trace('rcCotizacion.fecha_vigencia ' || rcCotizacion.fecha_vigencia,cnuNVLTRC);
        pkg_traza.trace('idtFechaVigencia ' || idtFechaVigencia,cnuNVLTRC);

        IF inuValorCotizado <> rcCotizacion.valor_cotizado THEN
            nuPaso                      := 70;
            rcCotizacion.valor_cotizado := inuValorCotizado;
        END IF;

        IF inuPlanComercial <> rcCotizacion.plan_comercial_espcl THEN
            nuPaso                      := 80;
            if inuPlanComercial = -1 then
                 rcCotizacion.plan_comercial_espcl := null;
              else
                 rcCotizacion.plan_comercial_espcl    := inuPlanComercial;
              end if;

        END IF;

        IF (nvl(recProyecto.forma_pago, -1) <> isbFormaPago) THEN
            recProyecto.forma_pago := isbFormaPago;
        END IF;

        nuPaso                       := 90;
        rcCotizacion.fecha_ult_modif := SYSDATE;
        nuPaso                       := 100;
        rcCotizacion.usua_ult_modif  := USER;
        --inici0 CA 200-2022
        IF inuUnidInsta <> rcCotizacion.UND_INSTALADORA_ID THEN
            nuPaso                      := 110;
            rcCotizacion.UND_INSTALADORA_ID := inuUnidInsta;
        END IF;

        IF inuUnidadCert <> rcCotizacion.UND_CERTIFICADORA_ID THEN
            nuPaso                      := 80;
            rcCotizacion.UND_CERTIFICADORA_ID := inuUnidadCert;
        END IF;
        --FIN CA 200-2022
        
        --TICKET 153 HT-- se actauliza campo de flag de la tabla        
        IF rcCotizacion.FLGOGASO <> isbFlagGoga THEN
           nupaso:= 120;
           rcCotizacion.FLGOGASO := isbFlagGoga;
        END IF;
        --FIN CA 153
        recProyecto.Fech_Ult_Modif    := SYSDATE;
        recProyecto.Usuario_Ult_Modif := USER;

        -- Modificacion del registro
        nuPaso := 110;
        daldc_cotizacion_construct.updRecord(rcCotizacion);
        daldc_proyecto_constructora.updRecord(recProyecto);
        
        -- Registrar la ultima modificacion en la cotizacion
        proDatosModifCotizacion(inuProyecto   => inuProyecto,
                                inuCotizacion => inuId_cotizacion_detallada,
                                osbError      => osbError);
        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(cnuDescriptionError, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proModifItemsUnidPred(inuProyecto            ldc_items_por_unid_pred.id_proyecto%TYPE, -- Proyecto
                                    inuCotizacionDetallada ldc_items_por_unid_pred.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                    inuPiso                ldc_items_por_unid_pred.id_piso%TYPE, -- Piso
                                    inuUnidPredial         ldc_items_por_unid_pred.id_unidad_predial%TYPE, -- Unidad predial
                                    inuItemCotizado        ldc_items_por_unid_pred.id_item_cotizado%TYPE, -- Item cotizado
                                    inuNuevoItem           ldc_items_por_unid_pred.id_item%TYPE, -- Item
                                    inuNuevaCantidad       ldc_items_por_unid_pred.cantidad%TYPE, -- Cantidad
                                    inuNuevoPrecio         ldc_items_por_unid_pred.precio%TYPE, -- Precio
                                    inuNuevoValFijo        ldc_items_por_unid_pred.id_val_fijo%TYPE, -- ValFijo
                                    inuNuevoPrecioTotal    ldc_items_por_unid_pred.precio_total%TYPE, -- Precio total
                                    osbError               OUT VARCHAR -- Error
                                    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proModifCantPrecUnidPred
        Descripcion:        Modifica el precio y cantidad en la unidad predial

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Registrar la ultima modificacion en la cotizacion
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'.proModifItemsUnidPred';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Valida que solo se ingrese uno de los campos item o valor fijo
        IF inuNuevoItem IS NOT NULL AND inuNuevoValFijo IS NOT NULL THEN
            osbError := 'Solo se puede ingresar un item o un valor fijo, no los dos al tiempo';
            RAISE exError;
        END IF;

        -- Se actualiza el mismo apartamento en todas las torres
        UPDATE ldc_items_por_unid_pred lipup
        SET    id_item      = inuNuevoItem,
               cantidad     = inuNuevaCantidad,
               precio       = inuNuevoPrecio,
               id_val_fijo  = inuNuevoValFijo,
               precio_total = inuNuevoPrecioTotal,
               costo_total  = costo * inuNuevaCantidad
        WHERE  lipup.id_proyecto = inuProyecto
        AND    lipup.id_cotizacion_detallada = inuCotizacionDetallada
        AND    lipup.id_piso = inuPiso
        AND    lipup.id_unidad_predial = inuUnidPredial
        AND    lipup.id_item_cotizado = inuItemCotizado;

        -- Registrar la ultima modificacion en la cotizacion
        proDatosModifCotizacion(inuProyecto   => inuProyecto,
                                inuCotizacion => inuCotizacionDetallada,
                                osbError      => osbError);
        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proModifConsolidaCotizacion(inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                                          inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                          inuTipoTrabajo         or_task_type.task_type_id%TYPE, -- Tipo de trabajo
                                          inuCosto               ldc_consolid_cotizacion.costo%TYPE, --Costo
                                          inuPrecio              ldc_consolid_cotizacion.precio%TYPE, --Precio
                                          inuMargen              ldc_consolid_cotizacion.margen%TYPE, --margen
                                          inuIva                 ldc_consolid_cotizacion.iva%TYPE, --iva
                                          isbOperacion           VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proModifConsolidaCotizacion
        Descripcion:        Totaliza la cotizacion

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Registrar la ultima modificacion en la cotizacion
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso     VARCHAR2(4000) := csbPaquete||'.proModifConsolidaCotizacion';
        nuPaso        NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        nuNuevoPrecio NUMBER; --- Nuevo precio
        osbError      VARCHAR2(32767);
        rcconsolidado daldc_consolid_cotizacion.styLDC_CONSOLID_COTIZACION;

        CURSOR cuNuevoValor IS
            SELECT SUM(nvl(lipup.precio, 0) * SUM(lipup.cantidad)) precio,
                   SUM(nvl(lipup.costo, 0) * SUM(lipup.cantidad)) costo
            FROM   ldc_items_por_unid_pred lipup
            WHERE  lipup.id_proyecto = inuProyecto
            AND    lipup.id_cotizacion_detallada = inuCotizacionDetallada
            AND    lipup.id_tipo_trabajo = inuTipoTrabajo
            GROUP  BY lipup.id_tipo_trabajo;

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        IF (isbOperacion = gsbUpdateOperation) THEN
            rcconsolidado := daldc_consolid_cotizacion.frcGetRecord(inuID_COTIZACION_DETALLADA => inuCotizacionDetallada,
                                                                    inuID_PROYECTO             => inuProyecto,
                                                                    inuID_TIPO_TRABAJO         => inuTipoTrabajo);

            IF (inuCosto IS NULL) THEN
                pkg_error.setErrorMessage(cnuNullValue, 'Costo');
                RAISE pkg_error.controlled_error;
            END IF;

            IF (inuPrecio IS NULL) THEN
                pkg_error.setErrorMessage(cnuNullValue, 'Precio');
                RAISE pkg_error.controlled_error;
            END IF;

            IF (inuIva IS NULL) THEN
                pkg_error.setErrorMessage(cnuNullValue, 'IVA');
                RAISE pkg_error.controlled_error;
            END IF;

            rcconsolidado.costo        := inuCosto;
            rcconsolidado.precio       := inuPrecio;
            rcconsolidado.margen       := rcconsolidado.precio - rcconsolidado.costo;
            rcconsolidado.iva          := inuIva;
            rcconsolidado.precio_total := rcconsolidado.precio * (1 + (rcconsolidado.iva / 100));

            daldc_consolid_cotizacion.updRecord(ircLDC_CONSOLID_COTIZACION => rcconsolidado);
        ELSE
            daldc_consolid_cotizacion.delRecord(inuID_COTIZACION_DETALLADA => inuCotizacionDetallada,
                                                inuID_PROYECTO             => inuProyecto,
                                                inuID_TIPO_TRABAJO         => inuTipoTrabajo);
        END IF;

        -- Registrar la ultima modificacion en la cotizacion
        proDatosModifCotizacion(inuProyecto   => inuProyecto,
                                inuCotizacion => inuCotizacionDetallada,
                                osbError      => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(cnuDescriptionError, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proModifTiposTrabajo(inuCotizacionDetallada ldc_val_fijos_unid_pred.id_cotizacion_detallada%TYPE, -- Cotizacion
                                   inuProyecto            ldc_val_fijos_unid_pred.id_proyecto%TYPE, -- Proyecto
                                   isbTipoTrabDesc        ldc_tipos_trabajo_cot.tipo_trabajo_desc%TYPE, -- Tipo Trabajo
                                   inuTipoTrab            ldc_tipos_trabajo_cot.id_tipo_trabajo%TYPE,
                                   inuActividad           ldc_tipos_trabajo_cot.id_actividad_principal%TYPE,
                                   isbOperacion           VARCHAR2,
                                   osbError               OUT VARCHAR2 -- Error
                                   ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proModifTiposTrabajo
        Descripcion:        Modificar los tipos de trabajo de la cotizacion

        Autor    : KCienfuegos
        Fecha    : 23-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Registrar la ultima modificacion en la cotizacion
        23-05-2016   KCienfuegos          Creacion
        ******************************************************************/

        sbProceso      VARCHAR2(4000) := csbPaquete||'.proModifTiposTrabajo';
        nuPaso         NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcTiposTrabajo daldc_tipos_trabajo_cot.styLDC_TIPOS_TRABAJO_COT;
        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        IF (isbOperacion = 'D') THEN
            daldc_tipos_trabajo_cot.delRecord(inuID_COTIZACION_DETALLADA => inuCotizacionDetallada,
                                              inuID_PROYECTO             => inuProyecto,
                                              isbTIPO_TRABAJO_DESC       => isbTipoTrabDesc);

            daldc_consolid_cotizacion.delRecord(inuID_COTIZACION_DETALLADA => inuCotizacionDetallada,
                                                inuID_PROYECTO             => inuProyecto,
                                                inuID_TIPO_TRABAJO         => inuTipoTrab);
        END IF;

        IF (isbOperacion = gsbUpdateOperation) THEN
            UPDATE ldc_tipos_trabajo_cot tc
            SET    tc.id_actividad_principal = inuActividad
            WHERE  tc.id_cotizacion_detallada = inuCotizacionDetallada
            AND    tc.id_proyecto = inuProyecto
            AND    tc.tipo_trabajo_desc = isbTipoTrabDesc;
        END IF;

        -- Registrar la ultima modificacion en la cotizacion
        proDatosModifCotizacion(inuProyecto   => inuProyecto,
                                inuCotizacion => inuCotizacionDetallada,
                                osbError      => osbError);
        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proModifItemsFijos(inuCotizacionDetallada ldc_items_cotiz_proy.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                 inuProyecto            ldc_items_cotiz_proy.id_proyecto%TYPE, -- Proyecto
                                 inuItem                ldc_items_cotiz_proy.id_item%TYPE, -- Item
                                 inuNuevaCantidad       ldc_items_cotiz_proy.cantidad%TYPE, -- Cantidad
                                 inuNuevoPrecio         ldc_items_cotiz_proy.precio%TYPE, -- Precio
                                 inuNuevoCosto          ldc_items_cotiz_proy.precio%TYPE, --Costo
                                 isbTipoItem            ldc_items_cotiz_proy.tipo_item%TYPE, -- Tipo item
                                 inuTipoTrab            ldc_items_cotiz_proy.tipo_trab%TYPE, -- Tipo de trabajo
                                 isbTipoOperacion       VARCHAR2,
                                 osbError               OUT VARCHAR2 -- Error
                                 ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proModifItemsFijos
        Descripcion:        Se actualizan los items fijos por proyecto y por vivienda, y con base a esto
                            se actualiza los items por unidades prediales.

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Registrar la ultima modificacion en la cotizacion
        10-05-2016   Sandra Mu?oz           Creacion.
        26-05-2016   KCienfuegos            Se modifica para que trabaje de acuerdo a la operacion
                                            que reciba por parametro.
        ******************************************************************/

        sbProceso    VARCHAR2(4000) := csbPaquete||'.proModifItemsFijos';
        nuPaso       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcItemsFijos daldc_items_cotiz_proy.styLDC_ITEMS_COTIZ_PROY; --Items fijos

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        IF (isbTipoOperacion = gsbUpdateOperation) THEN

            rcItemsFijos := daldc_items_cotiz_proy.frcGetRecord(inuID_COTIZACION_DETALLADA => inuCotizacionDetallada,
                                                                inuID_PROYECTO             => inuProyecto,
                                                                isbTIPO_ITEM               => isbTipoItem,
                                                                inuTIPO_TRAB               => inuTipoTrab,
                                                                inuID_ITEM                 => inuItem);

            IF (rcItemsFijos.cantidad <> inuNuevaCantidad) THEN
                rcItemsFijos.cantidad := inuNuevaCantidad;
            END IF;

            IF (rcItemsFijos.precio <> inuNuevoPrecio) THEN
                rcItemsFijos.precio := inuNuevoPrecio;
            END IF;

            IF (rcItemsFijos.costo <> inuNuevoCosto) THEN
                rcItemsFijos.costo := inuNuevoCosto;
            END IF;

            rcItemsFijos.total_costo  := rcItemsFijos.costo * rcItemsFijos.cantidad;
            rcItemsFijos.total_precio := rcItemsFijos.precio * rcItemsFijos.cantidad;

            daldc_items_cotiz_proy.updRecord(rcItemsFijos);

            proModifItemsUnidPredial(inuCotizacionDetallada,
                                     inuProyecto,
                                     inuItem,
                                     inuNuevaCantidad,
                                     inuNuevoPrecio,
                                     inuNuevoCosto,
                                     isbTipoItem,
                                     inuTipoTrab,
                                     isbTipoOperacion);
        END IF;

        IF (isbTipoOperacion = gsbDeleteOperation) THEN
            daldc_items_cotiz_proy.delRecord(inuID_COTIZACION_DETALLADA => inuCotizacionDetallada,
                                             inuID_PROYECTO             => inuProyecto,
                                             inuID_ITEM                 => inuItem,
                                             inuTIPO_TRAB               => inuTipoTrab,
                                             isbTIPO_ITEM               => isbTipoItem);

            proModifItemsUnidPredial(inuCotizacionDetallada,
                                     inuProyecto,
                                     inuItem,
                                     inuNuevaCantidad,
                                     inuNuevoPrecio,
                                     inuNuevoCosto,
                                     isbTipoItem,
                                     inuTipoTrab,
                                     isbTipoOperacion);
        END IF;

        -- Registrar la ultima modificacion en la cotizacion
        proDatosModifCotizacion(inuProyecto   => inuProyecto,
                                inuCotizacion => inuCotizacionDetallada,
                                osbError      => osbError);
        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proModifMetrajeXPisoYTipo(inuCotizacionDetallada ldc_detalle_met_cotiz.id_cotizacion_detallada%TYPE, -- Cotizacion
                                        inuProyecto            ldc_detalle_met_cotiz.id_proyecto%TYPE, -- Proyecto
                                        inuPiso                ldc_detalle_met_cotiz.id_piso%TYPE, -- Piso
                                        inuTipo                ldc_detalle_met_cotiz.id_tipo%TYPE, -- Tipo
                                        inuFlauta              ldc_detalle_met_cotiz.flauta%TYPE, -- Flauta
                                        inuHorno               ldc_detalle_met_cotiz.horno%TYPE, -- Horno
                                        inuBBQ                 ldc_detalle_met_cotiz.bbq%TYPE, -- BBQ
                                        inuEstufa              ldc_detalle_met_cotiz.estufa%TYPE, -- Estufa
                                        inuSecadora            ldc_detalle_met_cotiz.secadora%TYPE, -- Secadora
                                        inuCalentador          ldc_detalle_met_cotiz.calentador%TYPE, -- Calentador
                                        inuLongValBaj          ldc_detalle_met_cotiz.long_val_baj%TYPE, -- LongValVaj
                                        inuLongBajante         ldc_detalle_met_cotiz.long_bajante%TYPE, -- LongBajante
                                        inuLongBajTab          ldc_detalle_met_cotiz.long_baj_tab%TYPE, -- LongBajTab
                                        inuLongTablero         ldc_detalle_met_cotiz.long_tablero%TYPE, -- LongTablero
                                        inuCantUnidPred        ldc_detalle_met_cotiz.cant_unid_pred%TYPE -- CantUnidPred
                                        ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:   proModifMetrajeXPisoYTipo
        Descripcion:          Modifica el metraje por piso y tipo de apartamento

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Registrar la ultima modificacion en la cotizacion
        10-05-2016   Sandra Mu?oz           Creacion
        26-05-2016   KCienfuegos            Se corrige la actualizacion del metraje
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'.proModifMetrajeXPisoYTipo';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Actualiza los datos de metraje por piso y tipo
        UPDATE ldc_detalle_met_cotiz
        SET    flauta         = inuFlauta,
               horno          = inuHorno,
               bbq            = inuBBQ,
               estufa         = inuEstufa,
               secadora       = inuSecadora,
               calentador     = inuCalentador,
               long_val_baj   = inuLongValBaj,
               long_bajante   = inuLongBajante,
               long_baj_tab   = inuLongBajTab,
               long_tablero   = inuLongTablero,
               cant_unid_pred = inuCantUnidPred
        WHERE  id_proyecto = inuProyecto
        AND    id_cotizacion_detallada = inuCotizacionDetallada
        AND    id_piso = inuPiso
        AND    id_tipo = inuTipo;

        -- Registrar la ultima modificacion en la cotizacion
        proDatosModifCotizacion(inuProyecto   => inuProyecto,
                                inuCotizacion => inuCotizacionDetallada,
                                osbError      => sbError);
        IF sbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_traza.trace(sbProceso||'TERMINO CON ERROR '|| '(' || nuPaso || '):'||sbError,cnuNVLTRC,pkg_traza.csbFIN_ERC);
		    pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proModifValoresFijos(inuCotizacionDetallada ldc_val_fijos_unid_pred.id_cotizacion_detallada%TYPE, -- Cotizacion
                                   inuProyecto            ldc_val_fijos_unid_pred.id_proyecto%TYPE, -- Proyecto
                                   inuNuevaCantidad       ldc_val_fijos_unid_pred.cantidad%TYPE, -- Nueva cantidad
                                   inuNuevoPrecio         ldc_val_fijos_unid_pred.precio%TYPE, -- Nuevo precio
                                   inuValFijo             ldc_val_fijos_unid_pred.id_item%TYPE, -- Valor fijo
                                   inuTipoTrab            or_task_type.task_type_id%TYPE, --Tipo de Trabajo
                                   isbDescripcion         ldc_val_fijos_unid_pred.descripcion%TYPE, --Descripcion
                                   isbOperacion           VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proModifValoresFijos
        Descripcion:        Se actualizan los valores fijos, y con base a esto
                            se actualizan los valores fijos de las unidades prediales.

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Registrar la ultima modificacion en la cotizacion
        10-05-2016   Sandra Mu?oz           Creacion
        26-05-2016   KCienfuegos            Se modifica para que trabaje de acuerdo a la operacion
                                            que reciba por parametro.
        ******************************************************************/

        sbProceso      VARCHAR2(4000) := csbPaquete||'.proModifValoresFijos';
        rcValoresFijos daldc_val_fijos_unid_pred.styLDC_VAL_FIJOS_UNID_PRED; --Valores fijos
        nuPaso         NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError        VARCHAR2(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        IF (isbOperacion = gsbUpdateOperation) THEN

            rcValoresFijos := daldc_val_fijos_unid_pred.frcGetRecord(inuID_COTIZACION_DETALLADA => inuCotizacionDetallada,
                                                                     inuID_PROYECTO             => inuProyecto,
                                                                     inuID_ITEM                 => inuValFijo,
                                                                     inuTIPO_TRAB               => inuTipoTrab);

            IF (nvl(rcValoresFijos.cantidad, -1) <> inuNuevaCantidad) THEN
                rcValoresFijos.cantidad := inuNuevaCantidad;
            END IF;

            IF (nvl(rcValoresFijos.precio, -1) <> inuNuevoPrecio) THEN
                rcValoresFijos.precio := inuNuevoPrecio;
            END IF;

            IF (nvl(rcValoresFijos.descripcion, -1) <> isbDescripcion) THEN
                rcValoresFijos.descripcion := isbDescripcion;
            END IF;

            rcValoresFijos.total_precio := rcValoresFijos.precio * rcValoresFijos.cantidad;

            daldc_val_fijos_unid_pred.updRecord(rcValoresFijos);

            proModifValFijoUnidPredial(inuCotizacionDetallada,
                                       inuProyecto,
                                       inuValFijo,
                                       inuNuevaCantidad,
                                       inuNuevoPrecio,
                                       gsbValoresFijos,
                                       inuTipoTrab,
                                       isbOperacion);
        END IF;

        IF (isbOperacion = gsbDeleteOperation) THEN

            daldc_val_fijos_unid_pred.delRecord(inuID_COTIZACION_DETALLADA => inuCotizacionDetallada,
                                                inuID_PROYECTO             => inuProyecto,
                                                inuID_ITEM                 => inuValFijo,
                                                inuTIPO_TRAB               => inuTipoTrab);

            proModifValFijoUnidPredial(inuCotizacionDetallada,
                                       inuProyecto,
                                       inuValFijo,
                                       inuNuevaCantidad,
                                       inuNuevoPrecio,
                                       gsbValoresFijos,
                                       inuTipoTrab,
                                       isbOperacion);
        END IF;

        -- Registrar la ultima modificacion en la cotizacion
        proDatosModifCotizacion(inuProyecto   => inuProyecto,
                                inuCotizacion => inuCotizacionDetallada,
                                osbError      => sbError);
        IF sbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proModifItemsXMetraje(inuCotizacionDetallada ldc_items_metraje_cot.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                    inuProyecto            ldc_items_metraje_cot.id_proyecto%TYPE, -- Proyecto
                                    inuItem                ldc_items_metraje_cot.id_item%TYPE, -- Item
                                    isbFlauta              ldc_items_metraje_cot.flauta%TYPE, -- Flauta
                                    isbBBQ                 ldc_items_metraje_cot.bbq%TYPE, -- BBQ
                                    isbHorno               ldc_items_metraje_cot.horno%TYPE, -- Horno
                                    isbEstufa              ldc_items_metraje_cot.estufa%TYPE, -- Estufa
                                    isbSecadora            ldc_items_metraje_cot.secadora%TYPE, -- Secadora
                                    isbCalentador          ldc_items_metraje_cot.calentador%TYPE, -- Calentador
                                    isbLongValBajante      ldc_items_metraje_cot.log_val_bajante%TYPE, -- LongValBajante
                                    isbLongBajante         ldc_items_metraje_cot.long_bajante%TYPE, -- LongBajante
                                    isbLongBajTablero      ldc_items_metraje_cot.long_baj_tablero%TYPE, -- LongBajTablero
                                    isbLongTablero         ldc_items_metraje_cot.long_tablero%TYPE, -- LongTablero
                                    inuCosto               ldc_items_por_unid_pred.costo%TYPE, --Costo
                                    inuPrecio              ldc_items_por_unid_pred.precio%TYPE, --Precio
                                    isbTipoItem            VARCHAR2,
                                    isbOperacion           VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proModifItemsXMetraje
        Descripcion:        Descripcion

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Registrar la ultima modificacion en la cotizacion
        10-05-2016   Sandra Mu?oz           Creacion
        26-05-2016   KCienfuegos            Se modifican los parametros de entrada y se corrigen
                                            las tablas a actualizar

        ******************************************************************/

        sbProceso       VARCHAR2(4000) := csbPaquete||'.proModifItemsXMetraje';
        nuPaso          NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcItemsxMetraje daldc_items_metraje_cot.styLDC_ITEMS_METRAJE_COT; --Valores fijos
        exError EXCEPTION; -- Error controlado
        sbError VARCHAR2(4000);

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        IF (isbOperacion = gsbUpdateOperation) THEN
            rcItemsxMetraje := daldc_items_metraje_cot.frcGetRecord(inuID_COTIZACION_DETALLADA => inuCotizacionDetallada,
                                                                    inuID_PROYECTO             => inuProyecto,
                                                                    inuID_ITEM                 => inuItem);

            rcItemsxMetraje.flauta           := isbFlauta;
            rcItemsxMetraje.bbq              := isbBBQ;
            rcItemsxMetraje.horno            := isbHorno;
            rcItemsxMetraje.estufa           := isbEstufa;
            rcItemsxMetraje.secadora         := isbSecadora;
            rcItemsxMetraje.calentador       := isbCalentador;
            rcItemsxMetraje.log_val_bajante  := isbLongValBajante;
            rcItemsxMetraje.long_bajante     := isbLongBajante;
            rcItemsxMetraje.long_baj_tablero := isbLongBajTablero;
            rcItemsxMetraje.long_tablero     := isbLongTablero;

            daldc_items_metraje_cot.updRecord(rcItemsxMetraje);

            --Se actualizan los items de las unidades prediales
            proModifItemsMetUnidPredial(inuCotizacionDetallada,
                                        inuProyecto,
                                        inuItem,
                                        inuPrecio,
                                        inuCosto,
                                        isbTipoItem,
                                        isbOperacion);

        END IF;

        IF (isbOperacion = gsbDeleteOperation) THEN
            daldc_items_metraje_cot.delRecord(inuID_COTIZACION_DETALLADA => inuCotizacionDetallada,
                                              inuID_PROYECTO             => inuProyecto,
                                              inuID_ITEM                 => inuItem);

            --Se borran los items de las unidades prediales
            proModifItemsMetUnidPredial(inuCotizacionDetallada,
                                        inuProyecto,
                                        inuItem,
                                        inuPrecio,
                                        inuCosto,
                                        isbTipoItem,
                                        isbOperacion);

        END IF;

        -- Registrar la ultima modificacion en la cotizacion
        proDatosModifCotizacion(inuProyecto   => inuProyecto,
                                inuCotizacion => inuCotizacionDetallada,
                                osbError      => sbError);
        IF sbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proModifItemsUnidPredial(inuCotizacionDetallada ldc_items_cotiz_proy.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                       inuProyecto            ldc_items_cotiz_proy.id_proyecto%TYPE, -- Proyecto
                                       inuItem                ldc_items_cotiz_proy.id_item%TYPE, -- Item
                                       inuNuevaCantidad       ldc_items_cotiz_proy.cantidad%TYPE, -- Cantidad
                                       inuNuevoPrecio         ldc_items_cotiz_proy.precio%TYPE, -- Precio
                                       inuNuevoCosto          ldc_items_cotiz_proy.precio%TYPE, --Costo
                                       isbTipoItem            ldc_items_cotiz_proy.tipo_item%TYPE, -- Tipo item
                                       inuTipoTrab            ldc_items_cotiz_proy.tipo_trab%TYPE,
                                       isbTipoOperacion       VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proModifCantPrecUnidPred
        Descripcion:        Modifica el precio y cantidad en la unidad predial

        Autor    : KCienfuegos
        Fecha    : 26-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Registrar la ultima modificacion en la cotizacion
        26-05-2016   KCienfuegos          Creacion
        ******************************************************************/

        sbProceso          VARCHAR2(4000) := csbPaquete||'.proModifItemsUnidPredial';
        rcItemUnitPred     daldc_items_por_unid_pred.styLDC_ITEMS_POR_UNID_PRED; -- Items por unidad predial.
        nuPaso             NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        nuCantidadUnidades ldc_proyecto_constructora.cantidad_torres%TYPE;
        exError EXCEPTION; -- Error controlado
        sbError VARCHAR2(4000);

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        IF (isbTipoOperacion = gsbUpdateOperation) THEN
            -- Se actualiza el mismo apartamento en todas las torres
            nuCantidadUnidades := daldc_proyecto_constructora.fnuGetCANT_UNID_PREDIAL(inuProyecto);

            IF (isbTipoItem = gsbItemsFijosProyecto) THEN
                UPDATE ldc_items_por_unid_pred lipup
                SET    cantidad     = inuNuevaCantidad,
                       precio      =
                       (inuNuevoPrecio / nuCantidadUnidades),
                       precio_total =
                       (inuNuevoPrecio * inuNuevaCantidad / nuCantidadUnidades),
                       costo       =
                       (inuNuevoCosto / nuCantidadUnidades),
                       costo_total =
                       (inuNuevoCosto * inuNuevaCantidad / nuCantidadUnidades)
                WHERE  lipup.id_proyecto = inuProyecto
                AND    lipup.id_cotizacion_detallada = inuCotizacionDetallada
                AND    lipup.tipo_item = isbTipoItem
                AND    lipup.id_item = inuItem
                AND    lipup.id_tipo_trabajo = inuTipoTrab;
            END IF;

            IF (isbTipoItem = gsbItemsFijosUnidad OR isbTipoItem = gsbItemsPorUnidad) THEN
                UPDATE ldc_items_por_unid_pred lipup
                SET    cantidad     = inuNuevaCantidad,
                       precio       = inuNuevoPrecio,
                       precio_total =
                       (inuNuevoPrecio * inuNuevaCantidad),
                       costo        = inuNuevoCosto,
                       costo_total =
                       (inuNuevoCosto * inuNuevaCantidad)
                WHERE  lipup.id_proyecto = inuProyecto
                AND    lipup.id_cotizacion_detallada = inuCotizacionDetallada
                AND    lipup.tipo_item = isbTipoItem
                AND    lipup.id_item = inuItem
                AND    lipup.id_tipo_trabajo = inuTipoTrab;
            END IF;
        END IF;

        IF (isbTipoOperacion = gsbDeleteOperation) THEN
            -- Se elimina independientemente de las torres
            DELETE ldc_items_por_unid_pred lipup
            WHERE  lipup.id_proyecto = inuProyecto
            AND    lipup.id_cotizacion_detallada = inuCotizacionDetallada
            AND    lipup.tipo_item = isbTipoItem
            AND    lipup.id_item = inuItem
            AND    lipup.id_tipo_trabajo = inuTipoTrab;
        END IF;

        -- Registrar la ultima modificacion en la cotizacion
        proDatosModifCotizacion(inuProyecto   => inuProyecto,
                                inuCotizacion => inuCotizacionDetallada,
                                osbError      => sbError);
        IF sbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proModifValFijoUnidPredial(inuCotizacionDetallada ldc_items_cotiz_proy.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                         inuProyecto            ldc_items_cotiz_proy.id_proyecto%TYPE, -- Proyecto
                                         inuItem                ldc_items_por_unid_pred.id_val_fijo%TYPE, -- Item
                                         inuNuevaCantidad       ldc_items_cotiz_proy.cantidad%TYPE, -- Cantidad
                                         inuNuevoPrecio         ldc_items_cotiz_proy.precio%TYPE, -- Precio
                                         isbTipoItem            ldc_items_cotiz_proy.tipo_item%TYPE, -- Tipo item
                                         inuTipoTrab            or_task_type.task_type_id%TYPE, --Tipo de Trabajo
                                         isbTipoOperacion       VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proModifCantPrecUnidPred
        Descripcion:        Modifica el precio y cantidad en la unidad predial

        Autor    : KCienfuegos
        Fecha    : 26-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Registrar la ultima modificacion en la cotizacion
        26-05-2016   KCienfuegos          Creacion
        ******************************************************************/

        sbProceso      VARCHAR2(4000) := csbPaquete||'.proModifValFijoUnidPredial';
        rcItemUnitPred daldc_items_por_unid_pred.styLDC_ITEMS_POR_UNID_PRED; -- Items por unidad predial.
        exError EXCEPTION; -- Error controlado
        sbError VARCHAR2(4000);
        nuPaso  NUMBER;

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        nuPaso := 10;
        IF (isbTipoOperacion = gsbUpdateOperation) THEN
            -- Se actualiza el mismo apartamento en todas las torres
            UPDATE ldc_items_por_unid_pred lipup
            SET    cantidad     = inuNuevaCantidad,
                   costo       = inuNuevoPrecio,
                   costo_total =
                   (inuNuevoPrecio * inuNuevaCantidad)
            WHERE  lipup.id_proyecto = inuProyecto
            AND    lipup.id_cotizacion_detallada = inuCotizacionDetallada
            AND    lipup.tipo_item = isbTipoItem
            AND    lipup.id_val_fijo = inuItem
            AND    lipup.id_tipo_trabajo = inuTipoTrab;

        END IF;

        nuPaso := 20;
        IF (isbTipoOperacion = gsbDeleteOperation) THEN
            -- Se elimina independientemente de las torres
            DELETE ldc_items_por_unid_pred lipup
            WHERE  lipup.id_proyecto = inuProyecto
            AND    lipup.id_cotizacion_detallada = inuCotizacionDetallada
            AND    lipup.tipo_item = isbTipoItem
            AND    lipup.id_val_fijo = inuItem
            AND    lipup.id_tipo_trabajo = inuTipoTrab;
        END IF;

        -- Registrar la ultima modificacion en la cotizacion
        nuPaso := 30;
        proDatosModifCotizacion(inuProyecto   => inuProyecto,
                                inuCotizacion => inuCotizacionDetallada,
                                osbError      => sbError);
        IF sbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proModifItemsMetUnidPredial(inuCotizacionDetallada ldc_items_cotiz_proy.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                          inuProyecto            ldc_items_cotiz_proy.id_proyecto%TYPE, -- Proyecto
                                          inuItem                ldc_items_por_unid_pred.id_val_fijo%TYPE, -- Item
                                          inuNuevoPrecio         ldc_items_cotiz_proy.precio%TYPE, -- Precio
                                          inuNuevoCosto          ldc_items_cotiz_proy.costo%TYPE, --Costo
                                          isbTipoItem            ldc_items_cotiz_proy.tipo_item%TYPE, -- Tipo item
                                          isbTipoOperacion       VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proModifItemsMetUnidPredial
        Descripcion:        Se actualizan las cantidades de los items por metraje de las unidades

        Autor    : KCienfuegos
        Fecha    : 26-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Registrar la ultima modificacion en la cotizacion
        26-05-2016   KCienfuegos          Creacion
        ******************************************************************/

        sbProceso      VARCHAR2(4000) := csbPaquete||'.proModifItemsMetUnidPredial';
        rcItemUnitPred daldc_items_por_unid_pred.styLDC_ITEMS_POR_UNID_PRED; -- Items por unidad predial.
        rcItemsMetraje daldc_items_metraje_cot.styLDC_ITEMS_METRAJE_COT;
        exError EXCEPTION; -- Error controlado
        nuCantidad ldc_items_cotiz_proy.cantidad%TYPE;
        sbError    VARCHAR2(4000);
        nuPaso     NUMBER;

        CURSOR CuUnidadesPrediales IS
            SELECT DISTINCT up.id_piso,
                            up.id_tipo_unid_pred, up.id_unidad_predial
            FROM   ldc_items_por_unid_pred iu,
                   ldc_unidad_predial      up
            WHERE  up.id_unidad_predial = iu.id_unidad_predial
            AND    up.id_proyecto = iu.id_proyecto
            AND    iu.id_cotizacion_detallada = inuCotizacionDetallada
            AND    iu.id_proyecto = inuProyecto
            AND    iu.id_item = inuItem
            AND    iu.tipo_item = isbTipoItem
            ORDER  BY 1;

        CURSOR cuDetalleMetraje(nuPiso ldc_piso_proyecto.id_piso%TYPE,
                                nuTipo ldc_tipo_unid_pred_proy.id_tipo_unid_pred%TYPE) IS
            SELECT (decode(im.flauta, 'S', nvl(dm.flauta, 0), 0) +
                   decode(im.bbq, 'S', nvl(dm.bbq, 0), 0) +
                   decode(im.horno, 'S', nvl(dm.horno, 0), 0) +
                   decode(im.estufa, 'S', nvl(dm.estufa, 0), 0) +
                   decode(im.secadora, 'S', nvl(dm.secadora, 0), 0) +
                   decode(im.calentador, 'S', nvl(dm.calentador, 0), 0) +
                   decode(im.log_val_bajante, 'S', nvl(dm.long_val_baj, 0), 0) +
                   decode(im.long_bajante, 'S', nvl(dm.long_bajante, 0), 0) +
                   decode(im.long_baj_tablero, 'S', nvl(dm.long_baj_tab, 0), 0) +
                   decode(im.long_tablero, 'S', nvl(dm.long_tablero, 0), 0)) cant
            FROM   ldc_items_metraje_cot im,
                   ldc_detalle_met_cotiz dm
            WHERE  im.id_cotizacion_detallada = dm.id_cotizacion_detallada
            AND    im.id_proyecto = dm.id_proyecto
            AND    im.id_item = inuItem
            AND    im.id_proyecto = inuProyecto
            AND    im.id_cotizacion_detallada = inuCotizacionDetallada
            AND    dm.id_piso = nuPiso
            AND    dm.id_tipo = nuTipo;

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);
        --Pendiente
        nuPaso := 10;
        IF (isbTipoOperacion = gsbUpdateOperation) THEN

            /*rcItemsMetraje := daldc_items_metraje_cot.frcGetRecord(inuID_COTIZACION_DETALLADA => inuCotizacionDetallada,
            inuID_PROYECTO => inuProyecto,
            inuID_ITEM => inuItem);*/

            FOR i IN CuUnidadesPrediales LOOP

                nuPaso := 20;
                OPEN cuDetalleMetraje(i.id_piso, i.id_tipo_unid_pred);
                FETCH cuDetalleMetraje
                    INTO nuCantidad;
                CLOSE cuDetalleMetraje;

                nuPaso     := 30;
                nuCantidad := nvl(nuCantidad, 0);

                nuPaso := 40;
                UPDATE ldc_items_por_unid_pred a
                SET    cantidad     = nuCantidad,
                       precio       = inuNuevoPrecio,
                       costo        = inuNuevoCosto,
                       precio_total =
                       (inuNuevoPrecio * nuCantidad),
                       costo_total =
                       (inuNuevoCosto * nuCantidad)
                WHERE  id_proyecto = inuProyecto
                AND    id_cotizacion_detallada = inuCotizacionDetallada
                AND    tipo_item = isbTipoItem
                AND    id_item = inuItem
                AND    a.id_piso = i.id_piso
                AND    a.id_unidad_predial = i.id_unidad_predial ;

            END LOOP;
        END IF;

        IF (isbTipoOperacion = gsbDeleteOperation) THEN
            -- Se elimina independientemente de las torres
            nuPaso := 50;
            DELETE ldc_items_por_unid_pred lipup
            WHERE  lipup.id_proyecto = inuProyecto
            AND    lipup.id_cotizacion_detallada = inuCotizacionDetallada
            AND    lipup.tipo_item = isbTipoItem
            AND    lipup.id_item = inuItem;

        END IF;

        -- Registrar la ultima modificacion en la cotizacion
        nuPaso := 60;
        proDatosModifCotizacion(inuProyecto   => inuProyecto,
                                inuCotizacion => inuCotizacionDetallada,
                                osbError      => sbError);
        IF sbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCreaTiposTrabajoxCot(inuCotizacionDetallada ldc_tipos_trabajo_cot.id_cotizacion_detallada%TYPE, -- Cotizacion
                                      inuProyecto            ldc_tipos_trabajo_cot.id_proyecto%TYPE, -- Proyecto
                                      inuTipoTrab            ldc_tipos_trabajo_cot.id_tipo_trabajo%TYPE, --Tipo de trabajo
                                      inuItem                ldc_tipos_trabajo_cot.id_actividad_principal%TYPE,
                                      isbTipoTrab            ldc_tipos_trabajo_cot.tipo_trabajo_desc%TYPE) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proValoresFijos
        Descripcion:        Almacena los tipos de trabajo por cotizacion

        Autor    : KCienfuegos
        Fecha    : 20-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        20-05-2016   KCienfuegos           Creacion
        ******************************************************************/

        sbProceso    VARCHAR2(4000) := csbPaquete||'.proCreaTiposTrabajoxCot';
        nuPaso       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcTipoTrab   daldc_tipos_trabajo_cot.styLDC_TIPOS_TRABAJO_COT; -- Tipos de trabajo
        rcCotizacion ldc_cotizacion_construct%ROWTYPE; -- Cotizacion
        osbError     VARCHAR2(32737);

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Validacion de datos existentes
        nuPaso := 10;
        ldc_bcCotizacionConstructora.proDatosCotizacion(inuCotizacionDetallada => inuCotizacionDetallada,
                                                        inuProyecto            => inuProyecto,
                                                        orcCotizacionDetallada => rcCotizacion,
                                                        osbError               => osbError);
        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        -- Construccion del registro
        nuPaso                             := 20;
        rcTipoTrab.Id_Cotizacion_Detallada := inuCotizacionDetallada;
        nuPaso                             := 30;
        rcTipoTrab.Id_Proyecto             := inuProyecto;
        nuPaso                             := 40;
        rcTipoTrab.id_tipo_trabajo         := inuTipoTrab;
        nuPaso                             := 50;
        rcTipoTrab.tipo_trabajo_desc       := isbTipoTrab;
        nuPaso                             := 60;
        rcTipoTrab.id_actividad_principal  := inuItem;

        -- Guarda registro
        nuPaso := 70;
        daldc_tipos_trabajo_cot.insRecord(ircLDC_TIPOS_TRABAJO_COT => rcTipoTrab);

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCreaItemsFijos(inuCotizacionDetallada ldc_items_cotiz_proy.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                inuProyecto            ldc_items_cotiz_proy.id_proyecto%TYPE, -- Proyecto
                                inuItem                ldc_items_cotiz_proy.id_item%TYPE, -- Item
                                inuCantidad            ldc_items_cotiz_proy.cantidad%TYPE, -- Cantidad
                                inuPrecio              ldc_items_cotiz_proy.precio%TYPE, -- Precio
                                inuCosto               ldc_items_cotiz_proy.costo%TYPE, -- Costo
                                isbTipoItem            ldc_items_cotiz_proy.tipo_item%TYPE, -- Tipo item
                                inuTipoTrab            ldc_items_cotiz_proy.tipo_trab%TYPE, -- Tipo de trabajo
                                osbError               OUT VARCHAR2 -- Error
                                ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaItemsFijos
        Descripcion:        Almacena los items fijos por proyecto y por vivienda

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso   VARCHAR2(4000) := csbPaquete||'.proCreaItemsFijos';
        nuPaso      NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcItemCotiz daldc_items_cotiz_proy.styLDC_ITEMS_COTIZ_PROY; -- Items
        rcItem      ge_items%ROWTYPE; -- Item
        rcCosto     ge_unit_cost_ite_lis%ROWTYPE; -- Costo de un item

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Validacion de datos existentes
        nuPaso := 10;
        ldc_bcCotizacionConstructora.proDatosItem(inuitem       => inuItem,
                                                  inucotizacion => inuCotizacionDetallada,
                                                  inuproyecto   => inuProyecto,
                                                  orcitem       => rcItem,
                                                  osberror      => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(2741, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        ldc_bcCotizacionConstructora.proExisteTipoTrabajo(inutipotrabajo => inuTipoTrab,
                                                          osberror       => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(2741, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        -- Obtener el costo del item
        nuPaso := 20;
        ldc_bcCotizacionConstructora.proCostoItem(inucotizaciondetallada => inuCotizacionDetallada,
                                                  inuproyecto            => inuProyecto,
                                                  inuitem                => inuItem,
                                                  orccosto               => rcCosto,
                                                  osberror               => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(2741, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        -- Construccion del registro
        nuPaso                              := 30;
        rcItemCotiz.id_cotizacion_detallada := inuCotizacionDetallada;
        nuPaso                              := 40;
        rcItemCotiz.id_proyecto             := inuProyecto;
        nuPaso                              := 50;
        rcItemCotiz.id_item                 := inuItem;
        nuPaso                              := 60;
        rcItemCotiz.cantidad                := inuCantidad;
        nuPaso                              := 70;
        rcItemCotiz.costo                   := inuCosto;
        nuPaso                              := 80;
        rcItemCotiz.precio                  := inuPrecio;
        nuPaso                              := 90;
        rcItemCotiz.tipo_item               := isbTipoItem;
        nuPaso                              := 100;
        rcItemCotiz.tipo_trab               := inuTipoTrab;
        nuPaso                              := 120;
        rcItemCotiz.total_costo             := rcItemCotiz.costo * rcItemCotiz.cantidad;
        nuPaso                              := 130;
        rcItemCotiz.total_precio            := rcItemCotiz.precio * rcItemCotiz.cantidad;
        -- Almacenar registro
        nuPaso := 140;
        daldc_items_cotiz_proy.insRecord(ircldc_items_cotiz_proy => rcItemCotiz);

        -- Se registra el item en items por unidades prediales
        proCreaItemsUnidPredGenerico(inuProyecto,
                                     inuCotizacionDetallada,
                                     inuItem,
                                     inuTipoTrab,
                                     NULL,
                                     inuCantidad,
                                     inuPrecio,
                                     inuCosto,
                                     -1,
                                     -1,
                                     isbTipoItem);

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCreaValoresFijos(inuItem                ldc_val_fijos_unid_pred.id_item%TYPE, -- Item
                                  inuCotizacionDetallada ldc_val_fijos_unid_pred.id_cotizacion_detallada%TYPE, -- Cotizacion
                                  inuProyecto            ldc_val_fijos_unid_pred.id_proyecto%TYPE, -- Proyecto
                                  isbDescripcion         ldc_val_fijos_unid_pred.descripcion%TYPE, -- Descripcion
                                  inuCantidad            ldc_val_fijos_unid_pred.cantidad%TYPE, -- Cantidad
                                  inuPrecio              ldc_val_fijos_unid_pred.precio%TYPE, -- Precio
                                  inuTipoTrab            or_task_type.task_type_id%TYPE, --Tipo trabajo
                                  osbError               OUT VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proValoresFijos
        Descripcion:        Almacena los valores fijos por cada vivienda

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso    VARCHAR2(4000) := csbPaquete||'.proValoresFijos';
        nuPaso       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcItemCotiz  daldc_val_fijos_unid_pred.styLDC_VAL_FIJOS_UNID_PRED; -- Valores fijos
        rcCotizacion ldc_cotizacion_construct%ROWTYPE; -- Cotizacion
        rcItem       ge_items%ROWTYPE; -- Item

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Validacion de datos existentes
        nuPaso := 10;
        ldc_bcCotizacionConstructora.proDatosCotizacion(inuCotizacionDetallada => inuCotizacionDetallada,
                                                        inuProyecto            => inuProyecto,
                                                        orcCotizacionDetallada => rcCotizacion,
                                                        osbError               => osbError);
        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(2741, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        -- Construccion del registro
        nuPaso                              := 30;
        rcItemCotiz.Id_Cotizacion_Detallada := inuCotizacionDetallada;
        nuPaso                              := 40;
        rcItemCotiz.Id_Proyecto             := inuProyecto;
        nuPaso                              := 50;
        rcItemCotiz.Descripcion             := isbDescripcion;
        nuPaso                              := 60;
        rcItemCotiz.Cantidad                := inuCantidad;
        nuPaso                              := 70;
        rcItemCotiz.Precio                  := inuPrecio;
        nuPaso                              := 80;
        rcItemCotiz.Id_Item                 := inuItem;
        nuPaso                              := 90;
        rcItemCotiz.tipo_trab               := inuTipoTrab;
        nuPaso                              := 100;
        rcItemCotiz.total_Precio            := inuPrecio * inuCantidad;

        -- Guarda registro
        nuPaso := 110;
        daldc_val_fijos_unid_pred.insRecord(ircldc_val_fijos_unid_pred => rcItemCotiz);

        -- Se registra el item en items por unidades prediales
        proCreaItemsUnidPredGenerico(inuProyecto,
                                     inuCotizacionDetallada,
                                     NULL,
                                     inuTipoTrab,
                                     inuItem,
                                     inuCantidad,
                                     inuPrecio,
                                     NULL,
                                     -1,
                                     -1,
                                     'VF');

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCreaMetrajeXPisoYTipo(inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                                       inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                       osbError               OUT VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:  proCreaMetrajeXPisoYTipo
        Descripcion:         Almacena la informacion en LDC_DETALLE_ET_COTIZ

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso    VARCHAR2(4000) := csbPaquete||'.proCreaMetrajeXPisoYTipo';
        nuPaso       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcCotizacion ldc_cotizacion_construct%ROWTYPE; -- Cotizacion

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Validacion de datos obligatorios
        nuPaso := 10;
        ldc_bcCotizacionConstructora.proDatosCotizacion(inuCotizacionDetallada => inuCotizacionDetallada,
                                                        inuProyecto            => inuProyecto,
                                                        orcCotizacionDetallada => rcCotizacion,
                                                        osberror               => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(2741, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        -- Inserta datos
        nuPaso := 20;
        INSERT INTO ldc_detalle_met_cotiz
            SELECT inuCotizacionDetallada,
                   lup.id_piso,
                   lup.id_tipo_unid_pred,
                   lmtup.flauta,
                   lmtup.horno,
                   lmtup.bbq,
                   lmtup.estufa,
                   lmtup.secadora,
                   lmtup.calentador,
                   lmtup.long_val_bajante,
                   lmp.long_bajante,
                   lmtup.long_bajante_tabl,
                   lmtup.long_tablero,
                   COUNT(*),
                   inuProyecto
            FROM   ldc_unidad_predial         lup,
                   ldc_metraje_tipo_unid_pred lmtup,
                   ldc_metraje_piso           lmp
            WHERE  lup.id_proyecto = inuProyecto
            AND    lmtup.id_proyecto = lup.id_proyecto
            AND    lup.id_tipo_unid_pred = lmtup.tipo_unid_predial
            AND    lup.id_piso = lmp.id_piso
            AND    lmp.id_proyecto = lup.id_proyecto
            GROUP  BY inuCotizacionDetallada,
                      lup.id_piso,
                      lup.id_tipo_unid_pred,
                      lmtup.flauta,
                      lmtup.horno,
                      lmtup.bbq,
                      lmtup.estufa,
                      lmtup.secadora,
                      lmtup.calentador,
                      lmtup.long_val_bajante,
                      lmp.long_bajante,
                      lmtup.long_bajante_tabl,
                      lmtup.long_tablero,
                      inuProyecto;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCreaMetrajeXPisoYTipo(inuCotizacionDetallada ldc_detalle_met_cotiz.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                       inuPiso                ldc_detalle_met_cotiz.id_piso%TYPE, -- Piso
                                       inuTipo                ldc_detalle_met_cotiz.id_tipo%TYPE, -- Tipo unidad predial
                                       inuFlauta              ldc_detalle_met_cotiz.flauta%TYPE, -- Flauta
                                       inuHorno               ldc_detalle_met_cotiz.horno%TYPE, -- Horno
                                       inuBBQ                 ldc_detalle_met_cotiz.bbq%TYPE, -- BBQ
                                       inuEstufa              ldc_detalle_met_cotiz.estufa%TYPE, -- Estufa
                                       inuSecadora            ldc_detalle_met_cotiz.secadora%TYPE, -- Secadora
                                       inuCalentador          ldc_detalle_met_cotiz.calentador%TYPE, -- Calentador
                                       inuLongValBaj          ldc_detalle_met_cotiz.long_val_baj%TYPE, -- Longitud val bajante
                                       inuLongBajante         ldc_detalle_met_cotiz.long_bajante%TYPE, -- Longitud bajante
                                       inuLongBajTab          ldc_detalle_met_cotiz.long_baj_tab%TYPE, -- Longitud bajante a tablero
                                       inuLongTablero         ldc_detalle_met_cotiz.long_tablero%TYPE, -- Longitud tablero
                                       inuProyecto            ldc_detalle_met_cotiz.id_proyecto%TYPE, -- Id proyecto
                                       osbError               OUT VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:  proCreaMetrajeXPisoYTipo
        Descripcion:         Almacena la informacion en LDC_DETALLE_ET_COTIZ

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso               VARCHAR2(4000) := csbPaquete||'.proCreaMetrajeXPisoYTipo';
        nuPaso                  NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcCotizacion            ldc_cotizacion_construct%ROWTYPE; -- Cotizacion
        rcProyecto              ldc_proyecto_constructora%ROWTYPE; -- Proyecto
        rcLdc_Detalle_Met_Cotiz daLdc_Detalle_Met_Cotiz.styLDC_DETALLE_MET_COTIZ; -- Detalle
        exError EXCEPTION; -- Error controlado

		CURSOR cuCantUnidades(nuProyecto ldc_unidad_predial.id_proyecto%TYPE,
							  nuPiso ldc_unidad_predial.id_piso%TYPE,
							  nuTipo ldc_unidad_predial.id_tipo_unid_pred%TYPE) IS
        SELECT COUNT(1) cant_unidades
        FROM   ldc_unidad_predial lup
        WHERE  lup.id_proyecto = nuProyecto
        AND    lup.id_piso = nuPiso
        AND    lup.id_tipo_unid_pred = nuTipo;
		


    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Validacion de datos obligatorios
        nuPaso := 10;
        ldc_bcCotizacionConstructora.proDatosCotizacion(inuCotizacionDetallada => inuCotizacionDetallada,
                                                        inuProyecto            => inuProyecto,
                                                        orcCotizacionDetallada => rcCotizacion,
                                                        osberror               => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(2741, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        -- Construye el registro
        nuPaso                                          := 20;
        rcLdc_Detalle_Met_Cotiz.id_cotizacion_detallada := inuCotizacionDetallada;
        nuPaso                                          := 30;
        rcLdc_Detalle_Met_Cotiz.id_piso                 := inuPiso;
        nuPaso                                          := 40;
        rcLdc_Detalle_Met_Cotiz.id_tipo                 := inuTipo;
        nuPaso                                          := 50;
        rcLdc_Detalle_Met_Cotiz.flauta                  := inuFlauta;
        nuPaso                                          := 60;
        rcLdc_Detalle_Met_Cotiz.horno                   := inuHorno;
        nuPaso                                          := 70;
        rcLdc_Detalle_Met_Cotiz.bbq                     := inuBBQ;
        nuPaso                                          := 80;
        rcLdc_Detalle_Met_Cotiz.estufa                  := inuEstufa;
        nuPaso                                          := 90;
        rcLdc_Detalle_Met_Cotiz.secadora                := inuSecadora;
        nuPaso                                          := 100;
        rcLdc_Detalle_Met_Cotiz.calentador              := inuCalentador;
        nuPaso                                          := 130;

		IF cuCantUnidades%ISOPEN THEN
			CLOSE cuCantUnidades;
		END IF;
		
		OPEN cuCantUnidades(inuProyecto,inuPiso,inuTipo);
		FETCH cuCantUnidades INTO rcLdc_Detalle_Met_Cotiz.cant_unid_pred;
		CLOSE cuCantUnidades;
		
        nuPaso                               := 140;
        rcLdc_Detalle_Met_Cotiz.long_val_baj := inuLongValBaj;
        nuPaso                               := 150;
        rcLdc_Detalle_Met_Cotiz.long_bajante := inuLongBajante;
        nuPaso                               := 160;
        rcLdc_Detalle_Met_Cotiz.long_baj_tab := inuLongBajTab;
        nuPaso                               := 170;
        rcLdc_Detalle_Met_Cotiz.long_tablero := inuLongTablero;
        nuPaso                               := 180;
        rcLdc_Detalle_Met_Cotiz.id_proyecto  := inuProyecto;
        nuPaso                               := 190;

        -- Almacena el registro
        nuPaso := 200;
        daLdc_Detalle_Met_Cotiz.insRecord(ircldc_detalle_met_cotiz => rcLdc_Detalle_Met_Cotiz);

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCreaItemsXMetraje(inuCotizacion     ldc_items_metraje_cot.id_cotizacion_detallada%TYPE,
                                   inuItem           ldc_items_metraje_cot.id_item%TYPE, -- Item
                                   inuPrecio         ldc_items_metraje_cot.precio%TYPE, -- Precio
                                   inuCosto          ldc_items_metraje_cot.precio%TYPE, -- Costo
                                   isbFlauta         ldc_items_metraje_cot.flauta%TYPE, -- Flauta
                                   isbBbq            ldc_items_metraje_cot.bbq%TYPE, -- Bbq
                                   isbHorno          ldc_items_metraje_cot.horno%TYPE, -- Horno
                                   isbEstufa         ldc_items_metraje_cot.estufa%TYPE, -- Estufa
                                   isbSecadora       ldc_items_metraje_cot.secadora%TYPE, -- Secadora
                                   isbCalentador     ldc_items_metraje_cot.calentador%TYPE, -- Calentador
                                   isbValBajante     ldc_items_metraje_cot.log_val_bajante%TYPE, -- Valor bajante
                                   isbLongBajante    ldc_items_metraje_cot.long_bajante%TYPE, -- Longitud bajante
                                   isbLongBajTablero ldc_items_metraje_cot.long_baj_tablero%TYPE, -- Long bajante tablero
                                   isbLongTablero    ldc_items_metraje_cot.long_tablero%TYPE, -- Long tablero
                                   inuProyecto       ldc_items_metraje_cot.id_proyecto %TYPE, -- Proyecto
                                   inuTipoTrabajo    ldc_items_por_unid_pred.id_tipo_trabajo%TYPE, --Tipo de Trabajo
                                   osbError          OUT VARCHAR2 -- Error
                                   ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaItemsXMetraje
        Descripcion:        Almacena los items por metraje

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso      VARCHAR2(4000) := csbPaquete||'.proCreaItemsXMetraje';
        nuPaso         NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcItemXMetraje daLDC_ITEMS_METRAJE_COT.styLDC_ITEMS_METRAJE_COT; -- Items por metraje
        rcCotizacion   ldc_cotizacion_construct%ROWTYPE; -- Cotizacion

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Validacion de datos existentes
        nuPaso := 10;
        ldc_bcCotizacionConstructora.proDatosCotizacion(inucotizaciondetallada => inuCotizacion,
                                                        inuproyecto            => inuProyecto,
                                                        orccotizaciondetallada => rcCotizacion,
                                                        osberror               => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(2741, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        -- Construccion del registro
        nuPaso                                 := 20;
        rcItemXMetraje.id_cotizacion_detallada := inuCotizacion;
        nuPaso                                 := 30;
        rcItemXMetraje.id_item                 := inuItem;
        rcItemXMetraje.precio                  := inuPrecio;
        rcItemXMetraje.costo                   := inuCosto;
        nuPaso                                 := 40;
        rcItemXMetraje.flauta                  := isbFlauta;
        nuPaso                                 := 50;
        rcItemXMetraje.bbq                     := isbBbq;
        nuPaso                                 := 60;
        rcItemXMetraje.horno                   := isbHorno;
        nuPaso                                 := 70;
        rcItemXMetraje.estufa                  := isbEstufa;
        nuPaso                                 := 80;
        rcItemXMetraje.secadora                := isbSecadora;
        nuPaso                                 := 90;
        rcItemXMetraje.calentador              := isbCalentador;
        nuPaso                                 := 100;
        rcItemXMetraje.log_val_bajante         := isbValBajante;
        nuPaso                                 := 110;
        rcItemXMetraje.long_bajante            := isbLongBajante;
        nuPaso                                 := 120;
        rcItemXMetraje.long_baj_tablero        := isbLongBajTablero;
        nuPaso                                 := 130;
        rcItemXMetraje.long_tablero            := isbLongTablero;
        nuPaso                                 := 140;
        rcItemXMetraje.id_proyecto             := inuProyecto;

        -- Inserta el registro
        nuPaso := 150;
        daldc_items_metraje_cot.insRecord(rcItemXMetraje);

        proCreaItemsMetUnidPredial(inuCotizacion,
                                   inuProyecto,
                                   inuItem,
                                   inuPrecio,
                                   inuCosto,
                                   inuTipoTrabajo);

        --Se llenan los items por unidades prediales

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCreaItemsMetUnidPredial(inuCotizacionDetallada ldc_items_cotiz_proy.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                         inuProyecto            ldc_items_cotiz_proy.id_proyecto%TYPE, -- Proyecto
                                         inuItem                ldc_items_por_unid_pred.id_val_fijo%TYPE, -- Item
                                         inuNuevoPrecio         ldc_items_cotiz_proy.precio%TYPE, -- Precio
                                         inuNuevoCosto          ldc_items_cotiz_proy.costo%TYPE, --Costo
                                         inuTipoTrabajo         ldc_items_por_unid_pred.id_tipo_trabajo%TYPE --Tipo trabajo
                                         ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaItemsMetUnidPredial
        Descripcion:        Se registran los items por metraje para cada unidad predial

        Autor    : KCienfuegos
        Fecha    : 26-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        26-05-2016   KCienfuegos            Creacion
        ******************************************************************/

        sbProceso      VARCHAR2(4000) := csbPaquete||'.proCreaItemsMetUnidPredial';
        rcItemUnitPred daldc_items_por_unid_pred.styLDC_ITEMS_POR_UNID_PRED; -- Items por unidad predial.
        rcItemsMetraje daldc_items_metraje_cot.styLDC_ITEMS_METRAJE_COT;
        rcItems        daldc_items_por_unid_pred.styLDC_ITEMS_POR_UNID_PRED; -- Items
        exError EXCEPTION; -- Error controlado
        nuCantidad ldc_items_cotiz_proy.cantidad%TYPE;
        sbError    VARCHAR2(4000);
        nuPaso     NUMBER;

        CURSOR cuUNIDADESPREDIALES IS
            SELECT up.id_unidad_predial,
                   up.id_piso,
                   up.id_torre,
                   up.id_tipo_unid_pred
            FROM   ldc_unidad_predial up
            WHERE  up.id_proyecto = inuProyecto;

        CURSOR cuDetalleMetraje(nuPiso ldc_piso_proyecto.id_piso%TYPE,
                                nuTipo ldc_tipo_unid_pred_proy.id_tipo_unid_pred%TYPE) IS
            SELECT (decode(im.flauta, 'S', nvl(dm.flauta, 0), 0) +
                   decode(im.bbq, 'S', nvl(dm.bbq, 0), 0) +
                   decode(im.horno, 'S', nvl(dm.horno, 0), 0) +
                   decode(im.estufa, 'S', nvl(dm.estufa, 0), 0) +
                   decode(im.secadora, 'S', nvl(dm.secadora, 0), 0) +
                   decode(im.calentador, 'S', nvl(dm.calentador, 0), 0) +
                   decode(im.log_val_bajante, 'S', nvl(dm.long_val_baj, 0), 0) +
                   decode(im.long_bajante, 'S', nvl(dm.long_bajante, 0), 0) +
                   decode(im.long_baj_tablero, 'S', nvl(dm.long_baj_tab, 0), 0) +
                   decode(im.long_tablero, 'S', nvl(dm.long_tablero, 0), 0)) cant
            FROM   ldc_items_metraje_cot im,
                   ldc_detalle_met_cotiz dm
            WHERE  im.id_cotizacion_detallada = dm.id_cotizacion_detallada
            AND    im.id_proyecto = dm.id_proyecto
            AND    im.id_item = inuItem
            AND    im.id_proyecto = inuProyecto
            AND    im.id_cotizacion_detallada = inuCotizacionDetallada
            AND    dm.id_piso = nuPiso
            AND    dm.id_tipo = nuTipo;


		CURSOR cuItemCoti(nuProyecto ldc_items_por_unid_pred.id_proyecto%TYPE,
						  nuCotizacionDetallada ldc_items_por_unid_pred.id_cotizacion_detallada%TYPE,
						  nuUnidadPredial ldc_items_por_unid_pred.id_unidad_predial%TYPE,
						  nuid_piso ldc_items_por_unid_pred.id_piso%TYPE
						  ) IS
            SELECT nvl(MAX(lipup.id_item_cotizado), 0) + 1
            FROM   ldc_items_por_unid_pred lipup
            WHERE  lipup.id_proyecto = nuProyecto
            AND    lipup.id_cotizacion_detallada = nuCotizacionDetallada
            AND    lipup.id_unidad_predial = nuUnidadPredial
            AND    lipup.id_piso = nuid_piso;
		



    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);
        --Pendiente
        nuPaso := 10;

        FOR i IN CuUnidadesPrediales LOOP

            nuPaso := 20;
            OPEN cuDetalleMetraje(i.id_piso, i.id_tipo_unid_pred);
            FETCH cuDetalleMetraje
                INTO nuCantidad;
            CLOSE cuDetalleMetraje;

            nuPaso     := 30;
            nuCantidad := nvl(nuCantidad, 0);

            nuPaso := 40;
            -- Construye el registro
            rcItems.id_proyecto             := inuProyecto;
            rcItems.id_cotizacion_detallada := inuCotizacionDetallada;
            rcItems.id_unidad_predial       := i.id_unidad_predial;
            rcItems.id_item                 := inuItem;
            rcItems.cantidad                := nvl(nuCantidad, 0);
            rcItems.precio                  := nvl(inuNuevoPrecio, 0);
            rcItems.costo                   := nvl(inuNuevoCosto, 0);
            rcItems.id_torre                := i.id_torre;
            rcItems.id_piso                 := i.id_piso;
            rcItems.id_tipo_trabajo         := inuTipoTrabajo;
            rcItems.id_val_fijo             := NULL;
            rcItems.costo_total             := rcItems.costo * rcItems.cantidad;
            rcItems.precio_total            := rcItems.precio * rcItems.cantidad;
            rcItems.tipo_item               := gsbItemsPorMetraje;

			IF cuItemCoti%ISOPEN THEN
				CLOSE cuItemCoti;
			END IF;

			OPEN cuItemCoti(inuProyecto,inuCotizacionDetallada,i.id_unidad_predial,i.id_piso);
			FETCH cuItemCoti INTO rcItems.id_item_cotizado;
			CLOSE cuItemCoti;
			

            -- Inserta registro
            nuPaso := 180;
            daLdc_Items_Por_Unid_Pred.insRecord(ircLdc_items_por_unid_pred => rcItems);

        END LOOP;

        IF sbError IS NOT NULL THEN
            pkg_error.setErrorMessage(cnuDescriptionError, sbError);
            RAISE pkg_error.controlled_error;
        END IF;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCreaItemsUnidPred(inuProyecto            ldc_items_por_unid_pred.id_proyecto%TYPE, -- Proyecto
                                   inuCotizacionDetallada ldc_items_por_unid_pred.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                   inuUnidPredial         ldc_items_por_unid_pred.id_unidad_predial%TYPE, -- Unidad predial
                                   inuTipoTrabajo         ldc_items_por_unid_pred.id_tipo_trabajo%TYPE, -- Tipo de trabajo
                                   inuItem                ldc_items_por_unid_pred.id_item%TYPE, -- Item
                                   inuValFijo             ldc_items_por_unid_pred.id_val_fijo%TYPE, -- Valor fijo
                                   inuCantidad            ldc_items_por_unid_pred.cantidad%TYPE, -- Cantidad
                                   inuPrecio              ldc_items_por_unid_pred.precio%TYPE, -- Precio
                                   inuPiso                ldc_items_por_unid_pred.id_piso%TYPE, -- Piso
                                   osbError               OUT VARCHAR2 -- Error
                                   ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:  proCreaItemsUnidPred
        Descripcion:         Crea la cotizacion por cada apartamento

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso    VARCHAR2(4000) := csbPaquete||'.proCreaItemsUnidPred';
        nuPaso       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcItems      daldc_items_por_unid_pred.styLDC_ITEMS_POR_UNID_PRED; -- Items
        rcCotizacion ldc_cotizacion_construct%ROWTYPE; -- Cotizacion
        rcProyecto   ldc_proyecto_constructora%ROWTYPE; -- Proyecto
        rcPiso       ldc_piso_proyecto%ROWTYPE; -- Piso
        rcTorre      ldc_torres_proyecto%ROWTYPE; -- Torres
        rcCosto      ge_unit_cost_ite_lis%ROWTYPE; -- Costo item
        rcInterna    ldc_tipos_trabajo_cot%ROWTYPE; -- Interna
        rcValFijo    ldc_val_fijos_unid_pred%ROWTYPE; -- Valores fijos

        exError EXCEPTION; -- Error controlado

		CURSOR cuItemCoti(nuProyecto ldc_items_por_unid_pred.id_proyecto%TYPE,
						  nuCotizacionDetallada ldc_items_por_unid_pred.id_cotizacion_detallada%TYPE,
						  nuUnidadPredial ldc_items_por_unid_pred.id_unidad_predial%TYPE,
						  nuid_piso ldc_items_por_unid_pred.id_piso%TYPE
						  ) IS
            SELECT nvl(MAX(lipup.id_item_cotizado), 0) + 1
            FROM   ldc_items_por_unid_pred lipup
            WHERE  lipup.id_proyecto = nuProyecto
            AND    lipup.id_cotizacion_detallada = nuCotizacionDetallada
            AND    lipup.id_unidad_predial = nuUnidadPredial
            AND    lipup.id_piso = nuid_piso;


    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Validacion de datos existentes
        nuPaso := 10;
        ldc_bcCotizacionConstructora.proDatosCotizacion(inucotizaciondetallada => inuCotizacionDetallada,
                                                        inuproyecto            => inuProyecto,
                                                        orccotizaciondetallada => rcCotizacion,
                                                        osbError               => osbError);
        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(2741, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        ldc_bcCotizacionConstructora.proExisteTipoTrabajo(inutipotrabajo => inuTipoTrabajo,
                                                          osbError       => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(2741, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        -- Obtener los datos del item para identificar su costo
        nuPaso := 20;
        IF inuItem IS NOT NULL THEN
            ldc_bcCotizacionConstructora.proCostoItem(inuCotizacionDetallada => inuCotizacionDetallada,
                                                      inuProyecto            => inuProyecto,
                                                      inuItem                => inuItem,
                                                      orcCosto               => rcCosto,
                                                      osbError               => osbError);

            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage(2741, osbError);
                RAISE pkg_error.controlled_error;
            END IF;
        ELSIF inuValFijo IS NOT NULL THEN
            ldc_bcCotizacionConstructora.proDatosValFijo(inuvalfijo             => inuValFijo,
                                                         inucotizaciondetallada => inuCotizacionDetallada,
                                                         inuproyecto            => inuProyecto,
                                                         inuTipoTrab            => inuTipoTrabajo,
                                                         orcvalfijo             => rcValFijo,
                                                         osberror               => osbError);

            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage(2741, osbError);
                RAISE pkg_error.controlled_error;
            END IF;

        END IF;

        -- Obtener los datos del proyecto para saber cuantas torres tiene
        nuPaso := 30;
        ldc_bcProyectoConstructora.proDatosProyecto(inuproyecto => inuProyecto,
                                                    orcproyecto => rcProyecto,
                                                    osberror    => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(2741, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        -- Procesa el mismo apartamento por cada torre
        nuPaso := 40;
        FOR nuTorre IN 1 .. rcProyecto.Cantidad_Torres LOOP

            -- Verifica que la unidad predial existe en la torre procesada
            nuPaso := 50;
            ldc_bcProyectoConstructora.proDatosUnidPredial(inuUnidadPredial => inuUnidPredial,
                                                           inuPiso          => inuPiso,
                                                           inuTorre         => nuTorre,
                                                           inuProyecto      => inuProyecto,
                                                           osbError         => osbError);
            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage(2741, osbError);
                RAISE pkg_error.controlled_error;
            END IF;

            -- Construye el registro
            nuPaso                          := 60;
            rcItems.id_proyecto             := inuProyecto;
            nuPaso                          := 70;
            rcItems.id_cotizacion_detallada := inuCotizacionDetallada;
            nuPaso                          := 80;
            rcItems.id_unidad_predial       := inuUnidPredial;
            nuPaso                          := 90;
            rcItems.id_item                 := inuItem;
            nuPaso                          := 100;
            rcItems.cantidad                := inuCantidad;
            nuPaso                          := 110;
            rcItems.precio                  := inuPrecio;
            nuPaso                          := 120;
            IF inuItem IS NOT NULL THEN
                rcItems.costo := rcCosto.Price;
            ELSIF inuValFijo IS NOT NULL THEN
                rcItems.costo := rcValFijo.Precio;
            END IF;
            nuPaso                  := 130;
            rcItems.id_torre        := nuTorre;
            nuPaso                  := 140;
            rcItems.id_piso         := inuPiso;
            nuPaso                  := 150;
            rcItems.id_tipo_trabajo := inuTipoTrabajo;
            nuPaso                  := 160;
            rcItems.id_val_fijo     := inuValFijo;
            nuPaso                  := 170;

			IF cuItemCoti%ISOPEN THEN
				CLOSE cuItemCoti;
			END IF;

			OPEN cuItemCoti(inuProyecto,inuCotizacionDetallada,inuUnidPredial,inuPiso);
			FETCH cuItemCoti INTO rcItems.id_item_cotizado;
			CLOSE cuItemCoti;


            -- Inserta registro
            nuPaso := 180;
            daLdc_Items_Por_Unid_Pred.insRecord(ircLdc_items_por_unid_pred => rcItems);

        END LOOP;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            osbError := sbProceso||', TERMINO CON ERROR NO CONTROLADO  ' || '(' ||nuPaso || '): ' || SQLCODE;
            pkg_traza.trace(osbError,cnuNVLTRC);
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END;

    PROCEDURE proCreaItemsUnidPredGenerico(inuProyecto            ldc_items_por_unid_pred.id_proyecto%TYPE, -- Proyecto
                                           inuCotizacionDetallada ldc_items_por_unid_pred.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                           inuItem                ldc_items_por_unid_pred.id_item%TYPE, -- Item
                                           inuTipoTrab            ldc_items_cotiz_proy.tipo_trab%TYPE, -- Tipo de trabajo
                                           inuValFijo             ldc_items_por_unid_pred.id_val_fijo%TYPE, -- Valor fijo
                                           inuCantidad            ldc_items_por_unid_pred.cantidad%TYPE, -- Cantidad
                                           inuPrecio              ldc_items_por_unid_pred.precio%TYPE, -- Precio
                                           inuCosto               ldc_items_por_unid_pred.precio%TYPE, -- Costo
                                           inuPiso                ldc_items_por_unid_pred.id_piso%TYPE, -- Piso
                                           inuTipo                ldc_unidad_predial.id_tipo_unid_pred%TYPE, --Tipo
                                           isbTipoItem            ldc_items_por_unid_pred.tipo_item%TYPE) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:  proCreaItemsUnidPredGenerico
        Descripcion:         Crea la cotizacion por cada apartamento

        Autor    : KCienfuegos
        Fecha    : 01-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        01-06-2016   KCienfuegos            Creacion
        ******************************************************************/

        sbProceso    VARCHAR2(4000) := csbPaquete||'.proCreaItemsUnidPredGenerico';
        nuPaso       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcItems      daldc_items_por_unid_pred.styLDC_ITEMS_POR_UNID_PRED; -- Items
        rcCotizacion ldc_cotizacion_construct%ROWTYPE; -- Cotizacion
        rcProyecto   ldc_proyecto_constructora%ROWTYPE; -- Proyecto
        rcPiso       ldc_piso_proyecto%ROWTYPE; -- Piso
        rcTorre      ldc_torres_proyecto%ROWTYPE; -- Torres
        rcCosto      ge_unit_cost_ite_lis%ROWTYPE; -- Costo item
        rcInterna    ldc_tipos_trabajo_cot%ROWTYPE; -- Interna
        rcValFijo    ldc_val_fijos_unid_pred%ROWTYPE; -- Valores fijos
        nuPrecio     ldc_items_por_unid_pred.precio%TYPE;
        nuCosto      ldc_items_por_unid_pred.precio%TYPE;
        nuCantUnid   NUMBER;
        osbError     VARCHAR2(32767);

        exError EXCEPTION; -- Error controlado

        CURSOR cuUNIDADESPREDIALES IS
            SELECT id_unidad_predial,
                   id_piso,
                   id_torre
            FROM   ldc_unidad_predial up
            WHERE  up.id_proyecto = inuProyecto
            AND    up.id_piso = decode(inupiso, -1, id_piso, inupiso)
            AND    up.id_tipo_unid_pred = decode(inuTipo, -1, id_tipo_unid_pred, inuTipo);


		CURSOR cuItemCoti(nuProyecto ldc_items_por_unid_pred.id_proyecto%TYPE,
						  nuCotizacionDetallada ldc_items_por_unid_pred.id_cotizacion_detallada%TYPE,
						  nuUnidadPredial ldc_items_por_unid_pred.id_unidad_predial%TYPE,
						  nuid_piso ldc_items_por_unid_pred.id_piso%TYPE
						  ) IS
            SELECT nvl(MAX(lipup.id_item_cotizado), 0) + 1
            FROM   ldc_items_por_unid_pred lipup
            WHERE  lipup.id_proyecto = nuProyecto
            AND    lipup.id_cotizacion_detallada = nuCotizacionDetallada
            AND    lipup.id_unidad_predial = nuUnidadPredial
            AND    lipup.id_piso = nuid_piso;



    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Validacion de datos existentes
        nuPaso := 10;
        ldc_bcCotizacionConstructora.proDatosCotizacion(inucotizaciondetallada => inuCotizacionDetallada,
                                                        inuproyecto            => inuProyecto,
                                                        orccotizaciondetallada => rcCotizacion,
                                                        osbError               => osbError);
        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(2741, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        IF inuTipoTrab IS NOT NULL THEN
            ldc_bcCotizacionConstructora.proExisteTipoTrabajo(inutipotrabajo => inuTipoTrab,
                                                              osbError       => osbError);

            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage(2741, osbError);
                RAISE pkg_error.controlled_error;
            END IF;

        END IF;

        -- Obtener los datos del item para identificar su costo
        nuPaso := 20;
        IF inuItem IS NOT NULL THEN
            ldc_bcCotizacionConstructora.proCostoItem(inuCotizacionDetallada => inuCotizacionDetallada,
                                                      inuProyecto            => inuProyecto,
                                                      inuItem                => inuItem,
                                                      orcCosto               => rcCosto,
                                                      osbError               => osbError);

            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage(2741, osbError);
                RAISE pkg_error.controlled_error;
            END IF;

        ELSIF inuValFijo IS NOT NULL THEN
            ldc_bcCotizacionConstructora.proDatosValFijo(inuvalfijo             => inuValFijo,
                                                         inucotizaciondetallada => inuCotizacionDetallada,
                                                         inuproyecto            => inuProyecto,
                                                         inuTipoTrab            => inuTipoTrab,
                                                         orcvalfijo             => rcValFijo,
                                                         osberror               => osbError);

            IF osbError IS NOT NULL THEN
                pkg_error.setErrorMessage(2741, osbError);
                RAISE pkg_error.controlled_error;
            END IF;

        END IF;

        -- Obtener los datos del proyecto para saber cuantas torres tiene
        nuPaso := 30;
        ldc_bcProyectoConstructora.proDatosProyecto(inuproyecto => inuProyecto,
                                                    orcproyecto => rcProyecto,
                                                    osberror    => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(2741, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        nuCantUnid := daldc_proyecto_constructora.fnuGetCANT_UNID_PREDIAL(inuID_PROYECTO => inuProyecto);

        IF (isbTipoItem = gsbItemsFijosProyecto) THEN
            nuPrecio := nvl(inuPrecio, 0) / nvl(nuCantUnid, 1);
            nuCosto  := nvl(inuCosto, 0) / nvl(nuCantUnid, 1);
        ELSIF (isbTipoItem = gsbValoresFijos) THEN
            nuPrecio := 0;
            nuCosto  := nvl(inuPrecio, 0);
        ELSE
            nuPrecio := nvl(inuPrecio, 0);
            nuCosto  := nvl(inuCosto, 0);
        END IF;

        -- Procesa el mismo apartamento por cada torre
        nuPaso := 40;
        FOR i IN cuUNIDADESPREDIALES LOOP

            -- Construye el registro
            rcItems.id_proyecto             := inuProyecto;
            rcItems.id_cotizacion_detallada := inuCotizacionDetallada;
            rcItems.id_unidad_predial       := i.id_unidad_predial;
            rcItems.id_item                 := inuItem;
            rcItems.cantidad                := nvl(inuCantidad, 0);
            rcItems.precio                  := nvl(nuPrecio, 0);
            rcItems.costo                   := nvl(nuCosto, 0);
            rcItems.id_torre                := i.id_torre;
            rcItems.id_piso                 := i.id_piso;
            rcItems.id_tipo_trabajo         := inuTipoTrab;
            rcItems.id_val_fijo             := inuValFijo;
            rcItems.costo_total             := rcItems.costo * rcItems.cantidad;
            rcItems.precio_total            := rcItems.precio * rcItems.cantidad;
            rcItems.tipo_item               := isbTipoItem;


			IF cuItemCoti%ISOPEN THEN
				CLOSE cuItemCoti;
			END IF;

			OPEN cuItemCoti(inuProyecto,inuCotizacionDetallada,i.id_unidad_predial,i.id_piso);
			FETCH cuItemCoti INTO rcItems.id_item_cotizado;
			CLOSE cuItemCoti;

            -- Inserta registro
            nuPaso := 180;
            daLdc_Items_Por_Unid_Pred.insRecord(ircLdc_items_por_unid_pred => rcItems);

        END LOOP;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCreaConsolidaCotizacion(inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                                         inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                         inuTipoTrabajo         or_task_type.task_type_id%TYPE, -- Tipo de trabajo
                                         inuIva                 ldc_consolid_cotizacion.iva%TYPE, -- Iva
                                         inuPrecio              ldc_consolid_cotizacion.precio%TYPE,
                                         inuCosto               ldc_consolid_cotizacion.costo%TYPE,
                                         inuMargen              ldc_consolid_cotizacion.margen%TYPE,
                                         inuPrecioTotal         ldc_consolid_cotizacion.precio_total%TYPE) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaConsolidaCotizacion
        Descripcion:        Totaliza la cotizacion

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso     VARCHAR2(4000) := csbPaquete||'.proCreaConsolidaCotizacion';
        nuPaso        NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcConsolidado daLdc_consolid_cotizacion.styLDC_CONSOLID_COTIZACION;
        sbError       VARCHAR2(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Construccion del registro
        nuPaso                                := 10;
        rcConsolidado.id_proyecto             := inuProyecto;
        nuPaso                                := 20;
        rcConsolidado.id_cotizacion_detallada := inuCotizacionDetallada;
        nuPaso                                := 30;
        rcConsolidado.id_tipo_trabajo         := inuTipoTrabajo;
        nuPaso                                := 40;
        rcConsolidado.costo                   := nvl(inuCosto, 0);
        nuPaso                                := 50;
        rcConsolidado.precio                  := nvl(inuPrecio, 0);
        nuPaso                                := 60;
        rcConsolidado.margen                  := rcConsolidado.precio - rcConsolidado.costo;
        nuPaso                                := 70;
        rcConsolidado.iva                     := inuIva;
        nuPaso                                := 80;
        rcConsolidado.precio_total            := inuPrecioTotal;
        nuPaso                                := 90;

        -- Almacenar registro
        nuPaso := 90;
        daLdc_consolid_cotizacion.insRecord(ircldc_consolid_cotizacion => rcConsolidado);

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCreaCotizacionOSF(inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                   inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                                   inuSolicitudVenta      mo_packages.package_id%TYPE, -- Solicitud venta
                                   inuActividad           ge_items.items_id%TYPE, -- Actividad
                                   inuModalidadPago       ld_parameter.numeric_value%TYPE,
                                   osbError               OUT VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaCotizacionOSF_sms
        Descripcion:        Crea la cotizacion en OSF a partir de la cotizacion detallada de proyecto
                            constructora

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        09-06-2016   Sandra Mu?oz           Se toma el producto 7014 por parametro
                                            Se toma la forma de pago del proyecto
                                            Se envia a la cotizacion el valor del anticipo
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'.proCreaCotizacionOSF';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        nuExiste  NUMBER; -- Evalua si un elemento existe
        exError EXCEPTION; -- Error controlado
        nuError           NUMBER;
        rcProyecto        ldc_proyecto_constructora%ROWTYPE; -- Datos del proyecto
        rcCotizacion      ldc_cotizacion_construct%ROWTYPE; -- Cotizacion
        nuValorTotalXUnid cc_quotation.total_items_value%TYPE; -- Subtotal cotizacion
        nuvalorTotalIva   cc_quotation.total_tax_value%TYPE; -- Iva cotizacion
        nuCotizacionOSF   cc_quotation.quotation_id%TYPE; -- Consecutivo de la cotizacion OSF
        --nuModalidadPago   ld_parameter.numeric_value%TYPE; -- Modalidad de pago
        nuServicioGas     ld_parameter.numeric_value%TYPE; -- Servicio gas 7014
        nuTotalItems      cc_quotation.total_items_value%TYPE; -- Total items
        nuIva             cc_quotation.total_tax_value%TYPE; -- Total del iva
        nuCuotaInicial    cc_quotation.initial_payment%TYPE; -- Anticipo
        nuTipoProducto    pr_product.product_type_id%TYPE;

        CURSOR cuCotizacionDetallada IS
            SELECT lcc.id_tipo_trabajo,
                   lttc.id_actividad_principal,
                   lcc.precio,
                   lcc.iva,
                   lcc.precio_total
            FROM   ldc_consolid_cotizacion lcc,
                   ldc_tipos_trabajo_cot   lttc
            WHERE  lcc.id_proyecto = inuProyecto
            AND    lcc.id_cotizacion_detallada = inuCotizacionDetallada
            AND    lcc.id_tipo_trabajo = lttc.id_tipo_trabajo
            AND    lcc.id_proyecto = lttc.id_proyecto
            AND    lcc.id_cotizacion_detallada = lttc.id_cotizacion_detallada;

         CURSOR cuObtTipoProducto IS
          SELECT i.product_type_id
            FROM ps_engineering_activ i
           WHERE items_id = inuActividad;

		CURSOR cuValores (nuProyecto ldc_consolid_cotizacion.id_proyecto%TYPE,
						  nuCotizacionDetallada ldc_consolid_cotizacion.id_cotizacion_detallada%TYPE) IS
        SELECT SUM(nvl(lcc.precio, 0)),
               SUM(decode(lcc.precio, 0, 0, nvl(lcc.iva, 0) / 100 * lcc.precio)) iva
        FROM   ldc_consolid_cotizacion lcc
        WHERE  lcc.id_proyecto = nuProyecto
        AND    lcc.id_cotizacion_detallada = nuCotizacionDetallada;


    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);
        -- Limpia lo datos en memoria
        nuPaso := 10;
        cc_bsquotationregistry.clearquotationitemsmem(onuerrorcode    => nuError,
                                                      osberrormessage => osbError);

        -- Obtiene los datos del proyecto
        nuPaso := 20;
        ldc_bcproyectoconstructora.proDatosProyecto(inuproyecto => inuProyecto,
                                                    orcproyecto => rcProyecto,
                                                    osberror    => osbError);

        IF osbError IS NOT NULL THEN
            RAISE pkg_error.controlled_error;
        END IF;

        -- Obtiene los datos de la cotizacion
        nuPaso := 30;
        ldc_bccotizacionconstructora.proDatosCotizacion(inucotizaciondetallada => inuCotizacionDetallada,
                                                        inuproyecto            => inuProyecto,
                                                        orccotizaciondetallada => rcCotizacion,
                                                        osberror               => osbError);
        IF osbError IS NOT NULL THEN
            RAISE pkg_error.controlled_error;
        END IF;

        -- Crear los items de la cotizacion
        FOR rcItems IN cuCotizacionDetallada LOOP
            nuPaso := 40;
            CC_BSQuotationRegistry.AddQuotationItem(inuquotitemid    => cc_bosequence.fnunextcc_quotation_item,
                                                    inutasktypeid    => rcItems.Id_Tipo_Trabajo,
                                                    inuitemid        => rcItems.Id_Actividad_Principal,
                                                    inuitemparent    => NULL,
                                                    inuquantity      => rcProyecto.Cant_Unid_Predial,
                                                    inuunitvalue     => rcItems.Precio,
                                                    inuunitdiscvalue => 0,
                                                    inuunittaxvalue  => rcItems.Precio * rcItems.Iva / 100,
                                                    inuitemsequence  => NULL,
                                                    iboisplanned     => NULL,
                                                    onuerrorcode     => nuError,
                                                    osberrormessage  => osbError);

            IF osbError <> '-' THEN
                osbError := 'Error al crear el item ' || rcItems.Id_Actividad_Principal ||
                            ' en la cotizacion de OSF. ' || osbError;
                RAISE pkg_error.controlled_error;
            ELSE
                osbError := NULL;
            END IF;

            pkg_traza.trace('rcItems.Id_Tipo_Trabajo ' || rcItems.Id_Tipo_Trabajo,cnuNVLTRC);
            pkg_traza.trace('rcItems.Precio ' || rcItems.Precio,cnuNVLTRC);
            pkg_traza.trace('rcItems.Iva ' || rcItems.Precio * rcItems.Iva / 100, cnuNVLTRC);

        END LOOP;

        -- Crear la cotizacion
        nuPaso := 50;

		IF cuValores%ISOPEN THEN
			CLOSE cuValores;
		END IF;

		OPEN cuValores(inuProyecto,inuCotizacionDetallada);
		FETCH cuValores INTO nuValorTotalXUnid,nuvalorTotalIva;
		CLOSE cuValores;
		
        -- Obtener la modalidad de pago de la venta
        nuPaso := 60;

        -- Obtener
        BEGIN
            nuServicioGas := dald_parameter.fnuGetNumeric_Value(inuparameter_id => 'COD_SERV_GAS');
        EXCEPTION
            WHEN OTHERS THEN
                osbError := 'No fue posible obtener el valor del parametro COD_SERV_GAS. ' ||
                            SQLERRM;
                RAISE pkg_error.controlled_error;
        END;

        IF nuServicioGas IS NULL THEN
            osbError := 'No se ha definido valor para el parametro COD_SERV_GAS';
            RAISE pkg_error.controlled_error;
        END IF;

        BEGIN
            SELECT COUNT(1) INTO nuExiste FROM servicio s WHERE s.servcodi = nuServicioGas;
        EXCEPTION
            WHEN no_data_found THEN
                osbError := 'No se encontro un servicio con codigo ' || nuServicioGas;
                RAISE pkg_error.controlled_error;
        END;

        nuTotalItems   := nuValorTotalXUnid * rcProyecto.Cant_Unid_Predial;
        nuIva          := nvl(nuvalorTotalIva, 0) * rcProyecto.Cant_Unid_Predial;
        --nuCuotaInicial := (nuTotalItems + nvl(nuIva, 0)) * nvl(rcProyecto.Porc_Cuot_Ini, 0) / 100;

        OPEN cuObtTipoProducto;
        FETCH cuObtTipoProducto INTO nuTipoProducto;
        CLOSE cuObtTipoProducto;

        nuPaso := 80;
        CC_BSQuotationRegistry.RegisterQuotation(isbdescription      => substr(rcCotizacion.Observacion,0,100),
                                                 idtregisterdate     => SYSDATE,
                                                 inusubscriberid     => rcProyecto.Cliente,
                                                 inupackageid        => inuSolicitudVenta,
                                                 idtenddate          => rcCotizacion.Fecha_Vigencia,
                                                 inuregisterpersonid => pkg_bopersonal.fnugetpersonaid,
                                                 inudownpayment      => NULL,
                                                 isbpaymode          => NULL /*rcProyecto.Forma_Pago*/,
                                                 inudiscountperc     => NULL,
                                                 inutotalitemsvalue  => nuTotalItems,
                                                 inutotaldiscvalue   => 0,
                                                 inutotaltaxvalue    => nuIva,
                                                 ibonoquotitemcharge => NULL,
                                                 inupaymodality      => inuModalidadPago,
                                                 inuproducttype      => nuTipoProducto/*nuServicioGas*/, --
                                                 inuauipercentage    => NULL,
                                                 inutotalaiuvalue    => 0,
                                                 onuquotationid      => nuCotizacionOSF,
                                                 onuerrorcode        => nuError,
                                                 osberrormessage     => osbError);

        IF osbError <> '-' THEN
            RAISE pkg_error.controlled_error;
        ELSE
            daldc_cotizacion_construct.updID_COTIZACION_OSF(inuID_COTIZACION_DETALLADA => inuCotizacionDetallada,
                                                            inuID_PROYECTO             => inuProyecto,
                                                            inuID_COTIZACION_OSF$      => nuCotizacionOSF);
            osbError := NULL;
        END IF;

        pkg_traza.trace('nuValorTotalXUnid ' ||
                             nuValorTotalXUnid * rcProyecto.Cant_Unid_Predial,cnuNVLTRC);
        pkg_traza.trace('inutotaltaxvalue ' || nuvalorTotalIva * rcProyecto.Cant_Unid_Predial,cnuNVLTRC);

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCreaVentaConstructora(inuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                       inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion detallada
                                       inuMedioRecepcion      GE_RECEPTION_TYPE.RECEPTION_TYPE_ID%TYPE DEFAULT 1, -- Medio de recepcion
                                       inuActividad           ge_items.items_id%TYPE, -- Actividad
                                       onuSolicitudVenta      OUT mo_packages.package_id%TYPE, -- Solicitud venta
                                       osbError               OUT VARCHAR2 -- Error
                                       ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaVentaConstructora
        Descripcion:        Crea la solicitud 323 -> venta a constructoras

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        27-04-2017   KCienfuegos            Se modifica para registrar el tipo de vivienda
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        nuPaso    			NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        nuExiste  			NUMBER; -- Evalua si un elemento existe
        exError 			EXCEPTION; -- Error controlado
        csbPaquete          VARCHAR2(100) := 'LDC_BOCotizacionDetallada';
        sbProceso 			VARCHAR2(4000) := csbPaquete||'.proCreaVentaConstructora';
        sbXML                constants_per.tipo_xml_sol%type; -- XML de creacion de la solicitud
        nuInteraccion        mo_packages.package_id%TYPE; -- Interaccion
        nuNumeroSol          mo_packages.package_id%TYPE; -- Solicitud
        rcProyecto           ldc_proyecto_constructora%ROWTYPE; -- Datos del proyecto
        nuFuncionario        ge_person.person_id%TYPE; -- Funcionario
        nuUnidadOperativa    or_operating_unit.operating_unit_id%TYPE; -- Unidad operativa
        nuDireccionRespuesta ab_address.address_id%TYPE; -- Direccion de respuesta
        sbObservacion        mo_packages.comment_%TYPE; -- Observacion
        nuMotiveId           mo_motive.motive_id%TYPE; -- Motivo generado
        rcComponent          damo_component.stymo_component;
        rcmo_comp_link       damo_comp_link.stymo_comp_link;
        nuError              NUMBER; -- Error
        nuPosInstance        NUMBER;
        num                  NUMBER;
        nuCont               NUMBER;

         CURSOR cuComponente IS
           SELECT COUNT(1)
             FROM MO_COMPONENT C
            WHERE C.PACKAGE_ID= onuSolicitudVenta;

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        nuPaso := 10;
        ldc_bcproyectoconstructora.proDatosProyecto(inuproyecto => inuProyecto,
                                                    orcproyecto => rcProyecto,
                                                    osberror    => osbError);

        IF osbError IS NOT NULL THEN
            RAISE exError;
        END IF;

        nuPaso               := 20;
        nuInteraccion        := CC_BOPetitionMgr.fnuGetPetitionID(inuSubscriberId => rcProyecto.Cliente);
        nuPaso               := 30;
        nuNumeroSol          := CC_BOPetitionMgr.fnuGetPetitionID(inuSubscriberId => rcProyecto.Cliente);
        nuPaso               := 40;
        nuFuncionario        := pkg_bopersonal.fnugetpersonaid;
        nuPaso               := 50;
        nuUnidadOperativa    := pkg_bopersonal.fnugetpuntoatencionid(nuFuncionario);
        nuPaso               := 60;
        nuDireccionRespuesta := dage_subscriber.fnugetaddress_id(inusubscriber_id => rcProyecto.Cliente);
        nuPaso               := 70;
        sbObservacion        := rcProyecto.Descripcion;
        nuPaso               := 80;
        IF nuUnidadOperativa IS NULL THEN
            osbError := 'No se encontro la unidad operativa a la que pertenece el usuario ' ||
                        nuFuncionario;
            RAISE exError;
        END IF;

        nuPaso := 90;
        IF inuMedioRecepcion IS NULL THEN
            osbError := 'Debe indicarse el medio de recepcion';
            RAISE exError;
        END IF;

        nuPaso := 100;
        IF rcProyecto.Cliente IS NULL THEN
            osbError := 'El proyecto ' || inuProyecto ||
                        ' no tiene cliente asociado y es requerido para asignarlo como solicitante de la venta';
            RAISE exError;
        END IF;

        nuPaso := 110;
        IF nuDireccionRespuesta IS NULL THEN
            osbError := 'El cliente ' || rcProyecto.Cliente ||
                        ' no tiene direccion y se requiere para asignarla como direccion de respuesta de la solicitud ';
            RAISE exError;
        END IF;

        nuPaso := 120;
        IF rcProyecto.Suscripcion IS NULL THEN
            osbError := 'El proyecto ' || rcProyecto.Id_Proyecto ||
                        ' no tiene contrato de OSF asociado y se requiere para registrar la solicitud de venta';
            RAISE exError;
        END IF;

        nuPaso := 130;
        IF inuActividad IS NULL THEN
            osbERror := 'No se ha definido una actividad para la solicitud de venta';
            RAISE exError;
        END IF;

        nuPaso := 140;
        IF rcProyecto.Id_Direccion IS NULL THEN
            osbError := 'El proyecto ' || rcProyecto.Id_Proyecto ||
                        ' no tiene direccion y esta es requerida como direccion de ejecucion de los trabajos';
            RAISE exError;
        END IF;

        nuPaso := 170;

        sbXML := pkg_xml_soli_venta.getSolicitudConstructora(nuFuncionario,
															 nuUnidadOperativa,
															 inuMedioRecepcion,
															 rcProyecto.Cliente,
															 nuDireccionRespuesta,
															 nvl(sbObservacion,'-'),
															 rcProyecto.Suscripcion,
															 inuActividad,
															 NULL, --Causal
															 rcProyecto.Id_Direccion,
															 rcProyecto.Tipo_Vivienda
															 );
		
		
        pkg_traza.trace(sbXML,cnuNVLTRC);

        nuPaso := 180;

        api_registerRequestByXml(sbXML, onuSolicitudVenta, nuMotiveId, nuError, osbError);

        IF osbError IS NOT NULL THEN
            osbError := 'Error al generar la solicitud ' || osbError;
            pkg_traza.trace(sbXML,cnuNVLTRC);
            RAISE pkg_error.controlled_error;
        END IF;

        OPEN cuComponente;
        FETCH cuComponente INTO nucont;
        CLOSE cuComponente;

        --Se registra el componente
        IF (nucont=0)THEN
          rcComponent.component_id           := MO_BOSEQUENCES.FNUGETCOMPONENTID();
          rcComponent.component_number       :=1;
          rcComponent.status_change_date     :=SYSDATE;
          rcComponent.recording_date         :=SYSDATE;
          rcComponent.obligatory_flag        :='N';
          rcComponent.obligatory_change      :='N';
          rcComponent.notify_assign_flag     :='N';
          rcComponent.authoriz_letter_flag   :='N';
          rcComponent.custom_decision_flag   :='N';
          rcComponent.keep_number_flag       :='N';
          rcComponent.is_included            :='N';
          rcComponent.directionality_id      :='BI';
          rcComponent.motive_id              :=nuMotiveId;
          rcComponent.package_id             :=onuSolicitudVenta;
          rcComponent.prod_motive_comp_id    :=cnuprod_motive_comp_id;
          rcComponent.component_type_id      :=cnucomponent_type_id;
          rcComponent.motive_type_id         :=cnuMotive_type_id;
          rcComponent.motive_status_id       :=cnumotive_status_id;
          rcComponent.product_motive_id      :=cnuProductMotiveId;
          rcComponent.quantity               :=1;
          rcComponent.tag_name               :=csbTagName;
          damo_component.Insrecord(rcComponent);

          IF(nuMotiveId IS NOT NULL)THEN
            rcmo_comp_link.child_component_id := rcComponent.component_id;
            rcmo_comp_link.motive_id          := nuMotiveId;
            damo_comp_link.insrecord(rcmo_comp_link);
          END IF;

        END IF;

        daldc_proyecto_constructora.updID_SOLICITUD(inuID_PROYECTO   => inuProyecto,
                                                    inuID_SOLICITUD$ => onuSolicitudVenta);

        mo_boGenerateRequest.ProcessRequest(onuSolicitudVenta);

        pkg_traza.trace('onuSolicitudVenta ' || onuSolicitudVenta,cnuNVLTRC);

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
             pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCreaCotizacion(inuProyecto                ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                isbObservacion             ldc_cotizacion_construct.observacion%TYPE, -- Observacion
                                inuLista_costo             ldc_cotizacion_construct.lista_costo%TYPE, -- Lista costo
                                idtFechaVigencia           ldc_cotizacion_construct.fecha_vigencia%TYPE, -- Fecha vigencia
                                inuValorCotizado           ldc_cotizacion_construct.valor_cotizado%TYPE, --Valor cotizado
                                inuPlanComercial           ldc_cotizacion_construct.plan_comercial_espcl%TYPE, --Plan comercial
                                isbFormaPago               ldc_proyecto_constructora.forma_pago%TYPE DEFAULT NULL, --Forma de Pago
                                inuUnidInsta                ldc_cotizacion_construct.UND_INSTALADORA_ID%TYPE, --unidad instaladora
                                inuUnidadCert              ldc_cotizacion_construct.UND_CERTIFICADORA_ID%TYPE, --unidad certificadora
                                isbFlagGoga                LDC_COTIZACION_CONSTRUCT.FLGOGASO%TYPE, --flag genera orden de gasodomestico   
                                onuId_cotizacion_detallada OUT ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                                osbError                   OUT VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaCotizacion
        Descripcion:        Almacena los datos basicos de una cotizacion detallada

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        20-04-2019     jbrito               ca 200-2022 se agregan campos unidad cerificadora, unidad instaladora, plan especial
        09/10/2019    horbath               ca 153 se agrega nuevo campo flag genera orden de gasodomestico   
        ******************************************************************/

        sbProceso    VARCHAR2(4000) := csbPaquete||'.proCreaCotizacion';
        nuPaso       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcCotizacion daLdc_Cotizacion_Construct.styLDC_COTIZACION_CONSTRUCT; -- Cotizacion
        rcProyecto   ldc_proyecto_constructora%ROWTYPE; -- Proyecto
        rcLista      ge_list_unitary_cost%ROWTYPE; -- Lista de costo

        exError EXCEPTION; -- Error controlado
		
		CURSOR cuConsecutivo(nuProyecto ldc_cotizacion_construct.id_proyecto%TYPE) IS
        SELECT nvl(MAX(lcc.id_cotizacion_detallada), 0) + 1
        FROM   ldc_cotizacion_construct lcc
        WHERE  lcc.id_proyecto = nuProyecto;


    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Validacion de datos
        nuPaso := 10;
        ldc_bcProyectoConstructora.proDatosProyecto(inuproyecto => inuProyecto,
                                                    orcproyecto => rcProyecto,
                                                    osbError    => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(cnuDescriptionError, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        nuPaso := 20;
        ldc_bcCotizacionConstructora.proDatosListaCostos(inuListaCostos => inuLista_costo,
                                                         orcLista       => rcLista,
                                                         osbError       => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(cnuDescriptionError, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        nuPaso := 30;
        IF (idtFechaVigencia IS NOT NULL) THEN
            IF trunc(idtFechaVigencia) < trunc(SYSDATE) THEN
                osbError := 'La fecha de vigencia debe ser futura';
                pkg_error.setErrorMessage(cnuDescriptionError, osbError);
                RAISE pkg_error.controlled_error;
            END IF;
        END IF;

        -- Consecutivo de la cotizacion
        nuPaso := 40;

		IF cuConsecutivo%ISOPEN THEN
			CLOSE cuConsecutivo;
		END IF;

		OPEN cuConsecutivo(inuProyecto);
		FETCH cuConsecutivo INTO onuId_cotizacion_detallada;
		CLOSE cuConsecutivo;

        -- Construccion del registro
        nuPaso                               := 50;
        rcCotizacion.id_cotizacion_detallada := onuId_cotizacion_detallada;
        nuPaso                               := 60;
        rcCotizacion.id_proyecto             := inuProyecto;
        nuPaso                               := 70;
        rcCotizacion.estado                  := 'R'; -- Registrado
        nuPaso                               := 80;
        rcCotizacion.observacion             := isbObservacion;
        nuPaso                               := 90;
        rcCotizacion.lista_costo             := inuLista_costo;
        nuPaso                               := 100;
        rcCotizacion.fecha_vigencia          := idtFechaVigencia;
        nuPaso                               := 110;
        rcCotizacion.fecha_creacion          := SYSDATE;
        nuPaso                               := 120;
        rcCotizacion.usua_creacion           := USER;
        nuPaso                               := 130;
        rcCotizacion.valor_cotizado          := inuValorCotizado;
        nuPaso                               := 140;
        --INICIO CA 200-2022
        if inuPlanComercial = -1 then
           rcCotizacion.plan_comercial_espcl := null;
        else
           rcCotizacion.plan_comercial_espcl    := inuPlanComercial;
        end if;
        rcCotizacion.plan_comercial_espcl    := inuPlanComercial;
        nuPaso                               := 150;
        rcCotizacion.UND_INSTALADORA_ID    := inuUnidInsta;
        nuPaso                               := 160;
        rcCotizacion.UND_CERTIFICADORA_ID    := inuUnidadCert;
        nuPaso                               := 170;
        --FINC CAO 200-2022
        rcCotizacion.id_consecutivo          := seq_ldc_cotizacion_construct.nextval;
        
        --INICIO Ca 153
        rcCotizacion.FLGOGASO := isbFlagGoga;
        --fin ca 153
        -- Creacion del registro
        nuPaso := 140;
        daldc_cotizacion_construct.insRecord(ircLdc_Cotizacion_Construct => rcCotizacion);

        -- Actualiza la forma de pago en el proyecto
        nuPaso := 150;

        IF isbFormaPago IS NOT NULL THEN
            daldc_proyecto_constructora.updFORMA_PAGO(inuid_proyecto => inuProyecto,
                                                      isbforma_pago$ => rcProyecto.Forma_Pago);
        END IF;
       
        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
		
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCrearContratoOSF(inuDireccionCobro   IN suscripc.susciddi%TYPE, -- Direccion de cobro
                                  inuProyecto         IN ldc_proyecto_constructora.id_proyecto%TYPE, -- Proyecto
                                  inuCiclo            IN ciclo.ciclcodi%TYPE, --Ciclo
                                  onuNuevoContratoOSF OUT ldc_proyecto_constructora.suscripcion%TYPE, -- Contrato generado en OSF
                                  osbError            OUT VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCrearContratoOSF
        Descripcion:        Crea contrato OSF

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso               VARCHAR2(4000) := csbPaquete||'.proCrearContratoOSF';
        nuPaso                  NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        nuProceso               NUMBER := 0; -- Proceso que crea el suscriptor
        sbCodigoTipoDirCobro    suscripc.susctdco%TYPE := 'VT'; -- Codigo tipo direccion cobro
        nuTipoSuscriptor        suscripc.susctisu%TYPE := -1; -- Tipo de suscriptor
        nuTipoCuentaBancaria    suscripc.susctcba%TYPE := 1; -- Tipo de cuenta bancaria
        sbTipoTarjParaPago      suscripc.suscttpa%TYPE := 1; -- Tipo de tarjeta
        sbEnvioFactXCorreoElect suscripc.suscefce%TYPE := 'N'; -- Envio de factura por correo electronico
        nuProgramaCartera       suscripc.suscprca%TYPE := -1; -- Programa de cartera
        rcsuscripc              suscripc%ROWTYPE; -- Datos del contrato a crear
        nuExiste                NUMBER; -- Indica si existe un dato en la base de datos
        rcProyecto              ldc_proyecto_constructora%ROWTYPE; -- Datos del proyecto

		CURSOR cuSistema IS
		SELECT s.sistcodi 
		FROM sistema s;


    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Obtiene los datos del proyecto
        ldc_bcproyectoconstructora.proDatosProyecto(inuproyecto => inuProyecto,
                                                    orcproyecto => rcProyecto,
                                                    osberror    => osbError);

        IF osbError IS NOT NULL THEN
            RAISE pkg_error.controlled_error;
        END IF;

        IF(inuCiclo IS NULL)THEN
           osbError := 'Debe indicar el ciclo';
           RAISE pkg_error.controlled_error;
        END IF;

        -- Codigo del suscriptor
        rcsuscripc.susccodi := pkgeneralservices.fnugetnextsequenceval('SQ_SUSCRIPC_897');
        onuNuevoContratoOSF := rcsuscripc.susccodi;

        -- Tipo de suscriptor
        rcSuscripc.Susctisu := nuTipoSuscriptor;

        -- Obtener el ciclo de constructora
        nuPaso := 30;
        BEGIN
            rcSuscripc.susccicl := inuCiclo;
        EXCEPTION
            WHEN OTHERS THEN
                osbError := sqlerrm;
                RAISE pkg_error.controlled_error;
        END;

        nuPaso := 40;
        IF rcSuscripc.susccicl IS NULL THEN
            osbError := 'No se especifico el ciclo del contrato';
            RAISE pkg_error.controlled_error;
        END IF;

        nuPaso := 50;
        SELECT COUNT(1) INTO nuExiste FROM ciclo c WHERE c.ciclcodi = rcSuscripc.susccicl;

        IF nuExiste = 0 THEN
            osbError := 'No se encontro el ciclo ' || rcSuscripc.susccicl;
            RAISE pkg_error.controlled_error;
        END IF;

        -- Proceso que crea el suscriptor
        rcSuscripc.suscnupr := nuProceso;

        -- Id direccion de cobro
        IF inuDireccionCobro IS NULL THEN
            osbError := 'Falta indicar la direccion de cobro del contrato OSF a crear';
            RAISE pkg_error.controlled_error;
        END IF;

        -- Codigo tipo direccion cobro
        rcSuscripc.susciddi := inuDireccionCobro;

        rcSuscripc.susctdco := sbCodigoTipoDirCobro;
        rcSuscripc.susctcba := nuTipoCuentaBancaria;
        rcSuscripc.suscttpa := sbTipoTarjParaPago;
        rcSuscripc.suscclie := rcProyecto.Cliente;

		IF cuSistema%ISOPEN THEN
			CLOSE cuSistema;
		END IF;

        OPEN cuSistema;
		FETCH cuSistema INTO rcSuscripc.suscsist;
		CLOSE cuSistema;
		

        rcSuscripc.suscefce := sbEnvioFactXCorreoElect;

        rcSuscripc.susctitt := dage_subscriber.fnuGetIdent_type_id(inusubscriber_id => rcProyecto.Cliente);
        rcSuscripc.suscidtt := dage_subscriber.fsbGetIdentification(inusubscriber_id => rcProyecto.Cliente);
        rcSuscripc.suscprca := nuProgramaCartera;

        -- Saldo a favor
        rcSuscripc.suscsafa := 0;

        -- Inserta el registro
        pktblsuscripc.insrecord(ircrecord => rcsuscripc);

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    /*****************************************************************
    Propiedad intelectual de CSC (c).

    Unidad         : proCierraOT
    Descripcion    : Metodo para cerrar ot
    Autor          : KCienfuegos
    Fecha          : 11-08-2016
    Caso           : CA200-162

    Parametros           Descripcion
    ============         ===================
    inuOrderId    	     Codigo de la orden

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    11-08-2016    KCienfuegos.CA200-162          Creacion
    ******************************************************************/
    PROCEDURE proCierraOT(inuOrden               IN   or_order.order_id%type,
                          idtFechaLegalizacion   IN   or_order.legalization_date%TYPE DEFAULT SYSDATE,
                          inuCausal              IN   ge_causal.causal_id%TYPE,
                          inuCantItem            IN   or_order_items.legal_item_amount%TYPE) IS

      sbProceso            VARCHAR2(4000) := csbPaquete||'.proCierraOT';
      nuPersonId           ge_person.person_id%type;
      nuActivity           ge_items.items_id%type;
      nuOperUnit           or_operating_unit.operating_unit_id%type;
      rcorder              daor_order.styor_order;
      rcorderperson        daor_order_person.styor_order_person;
      nuActividadOrden     or_order_activity.order_activity_id%TYPE;

      CURSOR cuObtActividadOrden IS
        SELECT order_activity_id
          FROM or_order_activity oa
         WHERE oa.order_id = inuOrden;

    BEGIN

      pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

      --Se obtiene el id de la persona conectada
      nuPersonId := pkg_bopersonal.fnugetpersonaid;

      --Se obtiene la unidad operativa
      nuOperUnit := pkg_bopersonal.fnugetpuntoatencionid(nuPersonId);

      --Se obtiene el registro de la orden
      rcorder:= daor_order.frcgetrecord(inuOrden);

      or_bcorderactivities.updactofordertoclose(inuOrden, or_boconstants.csbfinishstatus ,idtFechaLegalizacion);

      --Se setean los datos
      rcorder.order_status_id         := or_boconstants.cnuorder_stat_closed;
      rcorder.causal_id               := inuCausal;
      rcorder.operating_unit_id       := nuOperUnit;
      rcorder.is_pending_liq          := ge_boconstants.csbyes;
      rcorder.legalization_date       := idtFechaLegalizacion;
      rcorder.assigned_date           := idtFechaLegalizacion;
      rcorder.exec_initial_date       := idtFechaLegalizacion;
      rcorder.execution_final_date    := idtFechaLegalizacion;
      rcorder.exec_estimate_date      := idtFechaLegalizacion;
      rcorder.legalize_try_times      := NVL(rcorder.legalize_try_times, 0) + 1;

      --Se actualiza la orden
      daor_order.updrecord(rcorder);

      rcorderperson.order_id          := inuOrden;
      rcorderperson.operating_unit_id := nuOperUnit;
      rcorderperson.person_id         := nuPersonId;

      IF (daor_order_person.fblexist(rcorderperson.operating_unit_id, rcorderperson.order_id) = FALSE) THEN
          daor_order_person.insrecord(rcorderperson);
      END IF;

      --Se registra el cambio de estado
      or_bcorderstatchang.insrecord
      (
        rcorder.order_id,
        or_boconstants.cnuorder_action_assign,
        or_boconstants.cnuorder_stat_registered,
        or_boconstants.cnuorder_stat_assigned,
        idtFechaLegalizacion,
        NULL,
        NULL,
        NULL,
        nuOperUnit,
        NULL,
        NULL,
        idtFechaLegalizacion);

        --Se registra el cambio de estado
        or_bcorderstatchang.insrecord
        (rcorder.order_id,
         or_boconstants.cnuorder_action_close,
         or_boconstants.cnuorder_stat_assigned,
         or_boconstants.cnuorder_stat_closed,
         NULL,
         NULL,
         NULL,
         nuOperUnit,
         nuOperUnit,
         NULL,
         inuCausal,
         idtFechaLegalizacion);

         OPEN cuObtActividadOrden;
         FETCH cuObtActividadOrden INTO nuActividadOrden;
         CLOSE cuObtActividadOrden;

         daor_order_items.updlegal_item_amount(daor_order_activity.fnugetorder_item_id(nuActividadOrden),inuCantItem);

      pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
	  

    EXCEPTION
      WHEN pkg_error.controlled_error THEN
		pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
        RAISE pkg_error.controlled_error;
      WHEN OTHERS THEN
        pkg_error.setError;
		pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
        RAISE pkg_error.controlled_error;
    END;

    PROCEDURE proPreAprueba(inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                            inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                            inuDireccionCobro      suscripc.susciddi%TYPE, -- Direccion de cobro del contrato a crear
                            inuActividad           ge_items.items_id%TYPE, -- Actividad inicial
                            inuCiclo               ciclo.ciclcodi%TYPE, --Ciclo
                            osbError OUT VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proPreAprueba
        Descripcion:        Pre aprueba una cotizacion detallada

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Registrar la ultima modificacion en la cotizacion
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso          VARCHAR2(4000) := csbPaquete||'.proPreAprueba';
        nuPaso             NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcProyecto         ldc_proyecto_constructora%ROWTYPE; -- Proyecto
        nuMedioRecepcion   ld_parameter.numeric_value%TYPE; -- Medio de recepcion para la solicitud de venta
        nuExiste           NUMBER;
        nuSolicitudVenta   mo_packages.package_id%TYPE; -- Solicitud de venta
        nuNuevoContratoOSF suscripc.susccodi%TYPE; -- Nuevo contrato generado para la constructora
        nuValorCotizado    ldc_cotizacion_construct.valor_cotizado%TYPE; -- Valor cotizado
        nuMargen           NUMBER;
        nuValMargen        NUMBER;
        nuMinMargen        NUMBER := dald_parameter.fnuGetNumeric_Value('MIN_MARG_INST_INTERNA',0);
        nuOrden            or_order.order_id%TYPE;
        nuCausal           ge_causal.causal_id%TYPE;
        nuTipoTrabajo      or_task_type.task_type_id%TYPE;
        nuPaymentMod       ps_engineering_activ.pay_modality%TYPE;

        CURSOR cuObtModPago IS
          SELECT pay_modality
            FROM ps_engineering_activ
           WHERE items_id = inuActividad;

        --Cursor para obtener la causal de exito del tipo de trabajo de la orden creada
        CURSOR cuObtCausalExito IS
          SELECT c.causal_id
            FROM or_task_type_causal tc, ge_causal c
           WHERE task_type_id = nuTipoTrabajo
             AND c.causal_id = tc.causal_id
             AND class_causal_id = MO_BOCausal.fnuGetSuccess;

        CURSOR cuObtieneOrden IS
         SELECT ORDER_ID, TASK_TYPE_ID
           FROM OR_ORDER_ACTIVITY OA
          WHERE OA.PACKAGE_ID = nuSolicitudVenta
            AND OA.ACTIVITY_ID= inuActividad;

        CURSOR cuObtieneMargen IS
          SELECT decode(cc.precio, 0,0,round(nvl(cc.margen,0)/nvl(cc.precio,1)*100,2)) margen_porc, cc.margen margen
            FROM ldc_consolid_cotizacion cc
           WHERE cc.id_cotizacion_detallada = inuCotizacionDetallada
             AND cc.id_proyecto = inuProyecto
             AND cc.id_tipo_trabajo = dald_parameter.fnuGetNumeric_Value('TIPO_TRAB_RED_INTERNA',0);


		CURSOR cuValidaCoti(nuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE,
							nuProyecto ldc_cotizacion_construct.id_proyecto%TYPE) IS
        SELECT COUNT(1)
        FROM   ldc_cotizacion_construct lcd
        WHERE  lcd.id_cotizacion_detallada <> nuCotizacionDetallada
        AND    lcd.id_proyecto = nuProyecto
        AND    lcd.estado NOT IN ('R', 'N');
		
		CURSOR cuMedioRecep(inuMedioRecepcion GE_RECEPTION_TYPE.RECEPTION_TYPE_ID%TYPE) IS
		SELECT COUNT(1)
        FROM   ge_reception_type grt
        WHERE  grt.reception_type_id = inuMedioRecepcion;
		
		CURSOR cuValorCoti(nuCotizacionDetallada ldc_consolid_cotizacion.id_cotizacion_detallada%TYPE,
						   nuProyecto ldc_consolid_cotizacion.id_proyecto%TYPE)IS
        SELECT SUM(nvl(lcc.precio_total, 0))
        FROM   ldc_consolid_cotizacion lcc
        WHERE  lcc.id_proyecto = nuProyecto
        AND    lcc.id_cotizacion_detallada = nuCotizacionDetallada;


    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Trae los datos del proyecto
        nuPaso := 10;
        Ldc_Bcproyectoconstructora.proDatosProyecto(inuproyecto => inuProyecto,
                                                    orcproyecto => rcProyecto,
                                                    osberror    => osbError);

        IF osbError IS NOT NULL THEN
            NULL;
        END IF;

		IF cuValidaCoti%ISOPEN THEN
			CLOSE cuValidaCoti;
		END IF;
		
		OPEN cuValidaCoti(inuCotizacionDetallada,inuProyecto);
		FETCH cuValidaCoti INTO nuExiste;
		CLOSE cuValidaCoti;


        IF nuExiste > 0 THEN
            osbError := 'Ya existen cotizaciones pre-aprobadas o aprobadas para el proyecto ' ||
                        inuProyecto || ', por tanto no es posible pre-aprobar la cotizacion ' ||
                        inuCotizacionDetallada;
            pkg_error.setErrorMessage(2741, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        -- Validar que el proyecto tenga la direccion ingresada
        nuPaso := 20;
        IF rcProyecto.Id_Direccion IS NULL THEN
            osbError := 'Se requiere que el proyecto ' || rcProyecto.Id_Proyecto || ' - ' ||
                        rcProyecto.Nombre ||
                        ' tenga la direccion para poder realizar la pre-aprobacion de la cotizacion';
            RAISE pkg_error.controlled_error;
        END IF;

        -- Obtener el medio de recepcion para registrar la venta
        nuPaso := 30;
        BEGIN
            nuMedioRecepcion := Dald_Parameter.fnuGetNumeric_Value(inuparameter_id => 'MEDIO_RECEPCION_CONSTRUCTORA');
        EXCEPTION
            WHEN OTHERS THEN
                osbError := 'No fue posible obtener el valor del parametro MEDIO_RECEPCION_CONSTRUCTORA';
                RAISE pkg_error.controlled_error;
        END;

        nuPaso := 40;
        IF nuMedioRecepcion IS NULL THEN
            osbError := 'No se encontro valor numerico para el parametro MEDIO_RECEPCION_CONSTRUCTORA';
            RAISE pkg_error.controlled_error;
        END IF;

        nuPaso := 50;
		
		IF cuMedioRecep%ISOPEN THEN
			CLOSE cuMedioRecep;
		END IF;
		
		OPEN cuMedioRecep(nuMedioRecepcion);
		FETCH cuMedioRecep INTO nuExiste;
		CLOSE cuMedioRecep;
		
        IF nuExiste = 0 THEN
            osbError := 'No se encontro el formato ' || nuMedioRecepcion;
            RAISE pkg_error.controlled_error;
        END IF;

        -- Crea el contrato en OSF
        nuPaso := 53;
        proCrearContratoOSF(inuDireccionCobro   => inuDireccionCobro,
                            inuProyecto         => inuProyecto,
                            inuCiclo            => inuCiclo,
                            onuNuevoContratoOSF => nuNuevoContratoOSF,
                            osbError            => osbError);

        IF osbError IS NOT NULL THEN
            RAISE pkg_error.controlled_error;
        END IF;

        -- Asigna el contrato OSF al proyecto de constructora
        nuPaso := 55;
        daldc_proyecto_constructora.updSUSCRIPCION(inuid_proyecto  => inuProyecto,
                                                   inususcripcion$ => nuNuevoContratoOSF);

        -- Crea venta en OSF
        nuPaso := 58;
        proCreaVentaConstructora(inuProyecto            => inuProyecto,
                                 inuCotizacionDetallada => inuCotizacionDetallada,
                                 inuMedioRecepcion      => nuMedioRecepcion,
                                 inuActividad           => inuActividad,
                                 onuSolicitudVenta      => nuSolicitudVenta,
                                 osbError               => osbError);
        IF osbError IS NOT NULL THEN
            RAISE pkg_error.controlled_error;
        END IF;

        -- Actualiza al numero de la solicitud en el proyecto
        nuPaso := 59;
        daldc_proyecto_constructora.updID_SOLICITUD(inuid_proyecto   => inuProyecto,
                                                    inuid_solicitud$ => nuSolicitudVenta);

        OPEN cuObtModPago;
        FETCH cuObtModPago INTO nuPaymentMod;
        CLOSE cuObtModPago;

        -- Crea cotizacion en OSF
        nuPaso := 60;
        proCreaCotizacionOSF(inuProyecto            => inuProyecto,
                             inuCotizacionDetallada => inuCotizacionDetallada,
                             inuSolicitudVenta      => nuSolicitudVenta,
                             inuActividad           => inuActividad,
                             inuModalidadPago       => nuPaymentMod,
                             osbError               => osbError);
        IF osbError IS NOT NULL THEN
            RAISE pkg_error.controlled_error;
        END IF;

        -- Calcular el valor de la cotizacion
        nuPaso := 70;

		IF cuValorCoti%ISOPEN THEN
			CLOSE cuValidaCoti;
		END IF;
		
		OPEN cuValorCoti(inuCotizacionDetallada,inuProyecto);
		FETCH cuValorCoti INTO nuValorCotizado;
		CLOSE cuValorCoti;

        -- Cambiar de estado la cotizacion detallada y el valor cotizado
        nuPaso := 80;
        BEGIN
            UPDATE ldc_cotizacion_construct lcc
            SET    lcc.valor_cotizado = nuValorCotizado * rcProyecto.Cant_Unid_Predial,
                   lcc.estado         = csbCotizacionPreAprobada,
                   lcc.fecha_aprobacion = sysdate
            WHERE  lcc.id_proyecto = inuProyecto
            AND    lcc.id_cotizacion_detallada = inuCotizacionDetallada;

        EXCEPTION
            WHEN OTHERS THEN
                osbError := 'No fue posible actualizar el estado ' || csbCotizacionPreAprobada ||
                            'ni el valor cotizado (' || nuValorCotizado ||
                            ') en la cotizacion detallada ' || inuCotizacionDetallada ||
                            ' del proyecto ' || inuProyecto;
                RAISE pkg_error.controlled_error;

        END;

        -- Actualiza el valor del contrato
        nuPaso := 90;
        daldc_proyecto_constructora.updVALOR_FINAL_APROB(inuid_proyecto        => inuProyecto,
                                                         inuvalor_final_aprob$ => nuValorCotizado * rcProyecto.Cant_Unid_Predial);

        -- Registrar la ultima modificacion en la cotizacion
        nuPaso := 100;
        proDatosModifCotizacion(inuProyecto   => inuProyecto,
                                inuCotizacion => inuCotizacionDetallada,
                                osbError      => osbError);
        IF osbError IS NOT NULL THEN
            RAISE pkg_error.controlled_error;
        END IF;
         nuPaso := 101;
        --Se valida el margen de la instalacion interna
        OPEN cuObtieneMargen;
        FETCH cuObtieneMargen INTO nuMargen, nuValMargen;
        CLOSE cuObtieneMargen;
nuPaso := 102;
        IF(nuMargen < nuMinMargen)THEN
          proEnviaCorreoMargen(inuProyecto => inuProyecto,
                               inuCotizacion => inuCotizacionDetallada,
                               inuMargenInt => nuMargen,
                               inuValMargenInt => nuValMargen);
        END IF;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            pkg_traza.trace(nuPaso,cnuNVLTRC);
            IF (osbError IS NOT NULL)THEN
             pkg_error.setErrorMessage(cnuDescripcionError,osbError||nuPaso);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proEnviaCorreo(isbPara    VARCHAR2, -- Para quien va dirigido el correo
                             isbCC      VARCHAR2 DEFAULT NULL, --Copia del correo
                             isbAsunto  VARCHAR2, -- Asunto del correo
                             iclMensaje CLOB -- Mensaje
                             ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proEnviaCorreo
        Descripcion:        En via

        Autor    : Sandra Mu?oz
        Fecha    : 31-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'.proEnviaCorreo';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        sbhost    VARCHAR2(50); --Servidor de correo de la Gasera
        sbfrom    VARCHAR2(50); --Correo de salida de la Gasera
        nuError   NUMBER;
		sbInstanciaBD  VARCHAR2(20);
        exError EXCEPTION; -- Error controlado
		conn       utl_smtp.connection;
		sbAsunto  VARCHAR2(4000);--

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Obtengo el servidor de correo
        nuPaso := 10;
        BEGIN
            nuPaso := 20;
            sbhost := dald_parameter.fsbgetvalue_chain('LDC_SMTP_HOST');
			sbInstanciaBD := ldc_boconsgenerales.fsbgetdatabasedesc();

			if (length(sbInstanciaBD) > 0) then
			  sbInstanciaBD := 'BD '||sbInstanciaBD||': ';
			end if;
			sbAsunto := sbInstanciaBD ||isbasunto;


            nuPaso := 30;
            IF sbhost IS NOT NULL THEN

                -- Obtengo el correo desde donde se va a enviar el mensaje [ Equivale a sbhost   := ge_boparameter.fsbget('HOST_MAIL');]
                nuPaso := 40;
                sbfrom := dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER');

                IF sbFrom IS NOT NULL THEN

                    -- Se pasan los parametros del correo a la funcion ut_mail.
                    nuPaso := 50;
                    
					conn := LDC_Email.begin_mail(sbfrom, isbPara,sbAsunto,LDC_Email.MULTIPART_MIME_TYPE);

					-- Mensaje
					LDC_Email.write_boundary(conn, false);
					LDC_Email.write_mime_header(conn,'Content-Type','text/html; charset="iso-8859-1"' ||utl_tcp.CRLF);
					LDC_Email.write_text(conn,iclMensaje||unistr('\000D\000A')) ;
					-- Cierre
					LDC_Email.end_mail(conn);
					
                END IF;

            ELSE
                pkg_traza.trace('No se encontro el valor para el parametro LDC_SMTP_SENDER');

            END IF;

        EXCEPTION
            WHEN OTHERS THEN
                pkg_traza.trace('No se encontro el parametro LDC_SMTP_HOST');
        END;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proAsociaVentaConProyecto(inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                                        inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                        inuSolicitudVenta      mo_packages.package_id%TYPE, -- Solicitud venta
                                        osbError               OUT VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proAsociaVentaConProyecto
        Descripcion:        Asocia la solicitud de venta con el proyecto

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        23-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso        VARCHAR2(4000) := csbPaquete||'.proAsociaVentaConProyecto';
        nuPaso           NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcProyecto       ldc_proyecto_constructora%ROWTYPE; -- Proyecto
        nuMedioRecepcion ld_parameter.numeric_value%TYPE; -- Medio de recepcion para la solicitud de venta
        nuExiste         NUMBER;
        nuValorCotizado  ldc_cotizacion_construct.valor_cotizado%TYPE; -- Valor cotizado
        inuActividad     ge_items.items_id%TYPE := 4295774;
        nuContratoOSF    suscripc.susccodi%TYPE;
		
		CURSOR cuValidaCoti(nuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE,
							nuProyecto ldc_cotizacion_construct.id_proyecto%TYPE) IS
        SELECT COUNT(1)
        FROM   ldc_cotizacion_construct lcd
        WHERE  lcd.id_cotizacion_detallada <> nuCotizacionDetallada
        AND    lcd.id_proyecto = nuProyecto
        AND    lcd.estado NOT IN ('R', 'N');
		
		CURSOR cuContSolicitud(nuSolicitudVenta mo_packages.package_id%TYPE) IS
        SELECT mm.subscription_id
        FROM   mo_motive mm
        WHERE  mm.package_id = nuSolicitudVenta;
		
		CURSOR cuValorCotizacion(nuProyecto ldc_consolid_cotizacion.id_proyecto%TYPE,
								 nuCotizacionDetallada ldc_consolid_cotizacion.id_cotizacion_detallada%TYPE)IS
        SELECT SUM(nvl(lcc.precio, 0))
        FROM   ldc_consolid_cotizacion lcc
        WHERE  lcc.id_proyecto = nuProyecto
        AND    lcc.id_cotizacion_detallada = nuCotizacionDetallada;


    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Trae los datos del proyecto
        nuPaso := 10;
        Ldc_Bcproyectoconstructora.proDatosProyecto(inuproyecto => inuProyecto,
                                                    orcproyecto => rcProyecto,
                                                    osberror    => osbError);

        IF osbError IS NOT NULL THEN
            NULL;
        END IF;
		
		IF cuValidaCoti%ISOPEN THEN
			CLOSE cuValidaCoti;
		END IF;
		
		OPEN cuValidaCoti(inuCotizacionDetallada,inuProyecto);
		FETCH cuValidaCoti INTO nuExiste;
		CLOSE cuValidaCoti;

        IF nuExiste > 0 THEN
            osbError := 'Ya existen cotizaciones pre-aprobadas o aprobadas para el proyecto ' ||
                        inuProyecto || ', por tanto no es posible pre-aprobar la cotizacion ' ||
                        inuCotizacionDetallada;
            pkg_error.setErrorMessage(2741, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        -- Validar que el proyecto tenga la direccion ingresada
        nuPaso := 20;
        IF rcProyecto.Id_Direccion IS NULL THEN
            osbError := 'Se requiere que el proyecto ' || rcProyecto.Id_Proyecto || ' - ' ||
                        rcProyecto.Nombre ||
                        ' tenga la direccion para poder realizar la pre-aprobacion de la cotizacion';
            RAISE pkg_error.controlled_error;
        END IF;

        -- Validar que la cotizacion ya tenga la forma de pago definida
        nuPaso := 25;
        IF rcProyecto.Forma_Pago IS NULL THEN
            osbError := 'Se requiere que el proyecto ' || rcProyecto.Id_Proyecto || ' - ' ||
                        rcProyecto.Nombre ||
                        ' tenga definida la forma de pago para realizar la pre-aprobacion';
            RAISE pkg_error.controlled_error;
        END IF;

        -- Buscar el contrato asociado a la solicitud
		IF cuContSolicitud%ISOPEN THEN
			CLOSE cuContSolicitud;
		END IF;
		
		OPEN cuContSolicitud(inuSolicitudVenta);
		FETCH cuContSolicitud INTO nuContratoOSF;
		CLOSE cuContSolicitud;
		
        -- Asigna el contrato OSF al proyecto de constructora
        nuPaso := 55;
        daldc_proyecto_constructora.updSUSCRIPCION(inuid_proyecto  => inuProyecto,
                                                   inususcripcion$ => nuContratoOSF);

        -- Actualiza al numero de la solicitud en el proyecto
        nuPaso := 59;
        daldc_proyecto_constructora.updID_SOLICITUD(inuid_proyecto   => inuProyecto,
                                                    inuid_solicitud$ => inuSolicitudVenta);

        -- Crea cotizacion en OSF
        nuPaso := 60;

        IF osbError IS NOT NULL THEN
            RAISE pkg_error.controlled_error;
        END IF;

        -- Calcular el valor de la cotizacion
		
		IF cuValorCotizacion%ISOPEN THEN
			CLOSE cuValorCotizacion;
		END IF;
		
		OPEN cuValorCotizacion(inuProyecto,inuCotizacionDetallada);
		FETCH cuValorCotizacion INTO nuValorCotizado;
		CLOSE cuValorCotizacion;
		

        -- Cambiar de estado la cotizacion detallada y el valor cotizado
        BEGIN
            UPDATE ldc_cotizacion_construct lcc
            SET    lcc.valor_cotizado = nuValorCotizado * rcProyecto.Cant_Unid_Predial,
                   lcc.estado         = csbCotizacionPreAprobada
            WHERE  lcc.id_proyecto = inuProyecto
            AND    lcc.id_cotizacion_detallada = inuCotizacionDetallada;

        EXCEPTION
            WHEN OTHERS THEN
                osbError := 'No fue posible actualizar el estado ' || csbCotizacionPreAprobada ||
                            'ni el valor cotizado (' || nuValorCotizado ||
                            ') en la cotizacion detallada ' || inuCotizacionDetallada ||
                            ' del proyecto ' || inuProyecto;
                RAISE pkg_error.controlled_error;

        END;

        -- Registrar la ultima modificacion en la cotizacion
        nuPaso := 80;
        proDatosModifCotizacion(inuProyecto   => inuProyecto,
                                inuCotizacion => inuCotizacionDetallada,
                                osbError      => osbError);
        IF osbError IS NOT NULL THEN
            RAISE pkg_error.controlled_error;
        END IF;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proImprimePrecupon(inuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion
                                 inuProyecto            ldc_cotizacion_construct.id_proyecto%TYPE, -- Cotizacion
                                 isbRuta                VARCHAR2, -- Ruta en la que se almacenara el archivo PDF
                                 isbNombreArchivo       VARCHAR2, -- Nombre del archivo a generar
                                 osbError               OUT VARCHAR2 -- Error
                                 ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proImprimePrecupon
        Descripcion:        Impresion del pre-cupon

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso             VARCHAR2(4000) := csbPaquete||'.proImprimePrecupon';
        nuPaso                NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbEjecutableImpresion ld_parameter.value_chain%TYPE; -- Ejecutable para imprimir el formato para imprimir pre-cupon
        nuEjecutable          sa_executable.executable_id%TYPE; -- Codigo del ejecutable
        -- Datos para la impresion
        nuPosInstance     NUMBER;
        nuExecutableId    sa_executable.executable_id%TYPE;
        sbEvent           VARCHAR2(100) := 'POST_REGISTER';
        rcDatos           Dald_Temp_Clob_Fact.styLD_temp_clob_fact;
        nuFormatoPrecupon ed_formato.formcodi%TYPE; -- Formato precupon
        nuExiste          NUMBER; -- Indica si existe un elemento
        sbPlantilla       ld_parameter.value_chain%TYPE; -- Plantilla para precupon
        nuConsCotizUnico  ldc_cotizacion_construct.id_consecutivo%TYPE; -- Cotizacion unico de la cotizacion

        exError EXCEPTION; -- Error controlado
		
		CURSOR cuValidaFormato(inuFormatoPrecupon ed_formato.formcodi%TYPE) IS
        SELECT COUNT(1) 
		FROM ed_formato ef 
		WHERE ef.formcodi = inuFormatoPrecupon;

		CURSOR cuConsecutivo(nuProyecto ldc_cotizacion_construct.id_proyecto%TYPE,
							 nuCotizacionDetallada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE)IS
        SELECT lcc.id_consecutivo
        FROM   ldc_cotizacion_construct lcc
        WHERE  lcc.id_proyecto = nuProyecto
        AND    lcc.id_cotizacion_detallada = nuCotizacionDetallada;
		
		CURSOR cuValidaPlantilla(nuPlantilla ed_plantill.plannomb%TYPE)IS
        SELECT COUNT(1)
        FROM   ed_plantill ep
        WHERE  ep.plannomb = nuPlantilla;


    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Construir el registro para insertar en LDC_TEMP_CLOB_FACT que es donde se toma la informacion
        -- para luego imprimir
        nuPaso                    := 10;
        rcDatos.temp_clob_fact_id := LD_BOSequence.Fnuseqld_temp_clob_fact;
        nuPaso                    := 20;
        rcDatos.sesion            := userenv('SESSIONID');

        -- Obtener el codigo de extraccion y mezcla
        nuPaso := 30;
        BEGIN
            nuFormatoPrecupon := Dald_Parameter.fnuGetNumeric_Value(inuparameter_id => 'FORMATO_PRECUPON');
        EXCEPTION
            WHEN OTHERS THEN
                osbError := 'No fue posible obtener el valor del parametro FORMATO_PRECUPON';
                RAISE exError;
        END;

        nuPaso := 40;
        IF nuFormatoPrecupon IS NULL THEN
            osbError := 'No se encontro valor numerico para el parametro FORMATO_PRECUPON';
            RAISE exError;
        END IF;

        nuPaso := 50;

		IF cuValidaFormato%ISOPEN THEN
			CLOSE cuValidaFormato;
		END IF;
		
		OPEN cuValidaFormato(nuFormatoPrecupon);
		FETCH cuValidaFormato INTO nuExiste;
		CLOSE cuValidaFormato;
		

        IF nuExiste = 0 THEN
            osbError := 'No se encontro el formato ' || nuFormatoPrecupon;
            RAISE exError;
        END IF;

        -- Obtener la informacion a imprimir en el precupon
		
		IF cuConsecutivo%ISOPEN THEN
			CLOSE cuConsecutivo;
		END IF;
		
		OPEN cuConsecutivo(inuProyecto,inuCotizacionDetallada);
		FETCH cuConsecutivo INTO nuConsCotizUnico;
		CLOSE cuConsecutivo;
		

        nuPaso := 60;
        ldc_bcprecupon.gnuCotizacionDetallada := inuCotizacionDetallada;
        ldc_bcprecupon.gnuProyecto            := inuProyecto;

        nuPaso := 70;
        pkBODataExtractor.ExecuteRules(inuformatcode => nuFormatoPrecupon,
                                       oclclobdata   => rcDatos.docudocu);

        -- Insertar en la tabla temporal
        nuPaso := 80;
        Dald_Temp_Clob_Fact.insRecord(ircld_temp_clob_fact => rcDatos);

        pkg_traza.trace('rcDatos.temp_clob_fact_id  ' || rcDatos.temp_clob_fact_id,cnuNVLTRC);
        

        COMMIT;

        -- Obtener el nombre del formato de precupon
        nuPaso := 90;
        BEGIN
            ld_bosubsidy.globalsbTemplate := Dald_Parameter.fsbGetValue_Chain(inuparameter_id => 'PLANTILLA_PRECUPON');
        EXCEPTION
            WHEN OTHERS THEN
                osbError := 'No fue posible obtener el valor del parametro PLANTILLA_PRECUPON';
                RAISE exError;
        END;

        nuPaso := 100;
        IF ld_bosubsidy.globalsbTemplate IS NULL THEN
            osbError := 'No se encontro valor numerico para el parametro PLANTILLA_PRECUPON';
            RAISE exError;
        END IF;

        nuPaso := 110;
		
		IF cuValidaPlantilla%ISOPEN THEN
			CLOSE cuValidaPlantilla;
		END IF;
		
		OPEN cuValidaPlantilla(ld_bosubsidy.globalsbTemplate);
		FETCH cuValidaPlantilla INTO nuExiste;
		CLOSE cuValidaPlantilla;

        IF nuExiste = 0 THEN
            osbError := 'No se encontro la plantilla  ' || ld_bosubsidy.globalsbTemplate;
            RAISE exError;
        END IF;

        -- Imprimir el precupon
        nuPaso := 120;
        pkg_traza.trace('isbRuta ' || isbRuta || ' isbNombreArchivo ' || isbNombreArchivo,cnuNVLTRC); 
		
        Ld_BoSubsidy.ProcExportBillDuplicateToPDF(isbsource   => isbRuta,
                                                  isbfilename => isbNombreArchivo,
                                                  iclclob     => rcDatos.docudocu);

        nuPaso       := 140;
        nuEjecutable := sa_boexecutable.fnuGetExecutableIdbyName('EXME', FALSE);

        nuPaso := 150;

        IF (NOT GE_BOInstanceControl.fblIsInitInstanceControl) THEN
            GE_BOInstanceControl.InitInstanceManager;
        END IF;

        nuPaso := 160;
        IF (NOT GE_BOInstanceControl.fblAcckeyInstanceStack('WORK_INSTANCE', nuPosInstance)) THEN
            GE_BOInstanceControl.CreateInstance('WORK_INSTANCE', NULL);
        END IF;

        nuPaso := 170;
        GE_BOInstanceControl.AddAttribute('WORK_INSTANCE',
                                          NULL,
                                          'IOPENEXECUTABLE',
                                          sbEvent,
                                          nuEjecutable);

        nuPaso := 180;
        Ld_Bosubsidy.Callapplication('EXME');

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCopiarCotizacionDetallada(inuProyecto                  ldc_cotizacion_construct.id_proyecto%TYPE, -- Proyecto
                                           inuCotizacionDetalladaOrigen ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion origen
                                           onuNuevaCotizacionDetallada  OUT ldc_cotizacion_construct.id_cotizacion_detallada%TYPE, -- Cotizacion nueva
                                           osbError                     OUT VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCopiarCotizacionDetallada
        Descripcion:        Copiar Cotizacion: Genera una nueva cotizacion basada en el codigo de la
                            cotizacion actual en pantalla, retorna el nuevo nmro de cotizacion:
                            LDC_VAL_FIJOS_UNID_PRED, LDC_COTIZACION_CONSTRUCT, LDC_ITEMS_COTIZ_PROY,
                            LDC_TIPOS_TRABAJO_COT,  LDC_ITEM_METRAJE_COT. LDC_DETALLE_MET_COTIZ,
                            LDC_ITEMS_POR_UNID_PRED

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        10-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso             VARCHAR2(4000) := csbPaquete||'.proCopiarCotizacionDetallada';
        nuPaso                NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rcCotizacionDetallada ldc_cotizacion_construct%ROWTYPE; -- Cotizacion detallada

        exError EXCEPTION; -- Error controlado
		
		CURSOR cuConsecutivo(nuProyecto ldc_cotizacion_construct.id_proyecto%TYPE)IS
		SELECT nvl(MAX(lcc.id_cotizacion_detallada), 0) + 1
        FROM   ldc_cotizacion_construct lcc
        WHERE  lcc.id_proyecto = nuProyecto;

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Obtener los datos de la cotizacion original
        ldc_bcCotizacionConstructora.proDatosCotizacion(inucotizaciondetallada => inuCotizacionDetalladaOrigen,
                                                        inuproyecto            => inuProyecto,
                                                        orccotizaciondetallada => rcCotizacionDetallada,
                                                        osberror               => osbError);

        IF osbError IS NOT NULL THEN
            pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            RAISE pkg_error.controlled_error;
        END IF;


        -- Obtener el nuevo consecutivo
		IF cuConsecutivo%ISOPEN THEN
			CLOSE cuConsecutivo;
		END IF;
		
		OPEN cuConsecutivo(inuProyecto);
		FETCH cuConsecutivo INTO onuNuevaCotizacionDetallada;
		CLOSE cuConsecutivo;


        -- Crear la cotizacion
        INSERT INTO ldc_cotizacion_construct
            (id_cotizacion_detallada,
             id_proyecto,
             estado,
             observacion,
             lista_costo,
             id_cotizacion_osf,
             valor_cotizado,
             fecha_vigencia,
             fecha_aprobacion,
             fecha_creacion,
             fecha_ult_modif,
             usua_creacion,
             usua_ult_modif,
             id_consecutivo)
            SELECT onuNuevaCotizacionDetallada,
                   id_proyecto,
                   'R',
                   observacion,
                   lista_costo,
                   NULL,
                   valor_cotizado,
                   fecha_vigencia,
                   NULL,
                   SYSDATE,
                   NULL,
                   USER,
                   NULL,
                   seq_ldc_cotizacion_construct.nextval
            FROM   ldc_cotizacion_construct lcc
            WHERE  lcc.id_cotizacion_detallada = inuCotizacionDetalladaOrigen
            AND    lcc.id_proyecto = inuProyecto;

        IF SQL%ROWCOUNT = 0 THEN
            osbError := 'No fue posible crear la cotizacion a partir de la cotizacion ' ||
                        inuCotizacionDetalladaOrigen || SQLERRM;
            pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            RAISE pkg_error.controlled_error;
        END IF;

        BEGIN

            -- Crear los valores fijos
            INSERT INTO LDC_VAL_FIJOS_UNID_PRED
                (id_cotizacion_Detallada,
                 id_proyecto,
                 descripcion,
                 cantidad,
                 precio,
                 id_item,
                 total_precio,
                 tipo_trab)
                SELECT onuNuevaCotizacionDetallada,
                       inuProyecto,
                       descripcion,
                       cantidad,
                       precio,
                       id_item,
                       total_precio,
                       tipo_trab
                FROM   ldc_val_fijos_unid_pred lvfup
                WHERE  lvfup.id_cotizacion_detallada = inuCotizacionDetalladaOrigen
                AND    lvfup.id_proyecto = inuProyecto;
        EXCEPTION
            WHEN OTHERS THEN
                osbError := 'Se presento un error al intentar copiar los valores fijos por unidad predial a partir de la cotizacion ' ||
                            inuCotizacionDetalladaOrigen || '. ' || SQLERRM;
                pkg_error.setErrorMessage(cnuDescripcionError, osbError);
                RAISE pkg_error.controlled_error;
        END;

        BEGIN

            -- Crea los items fijos
            INSERT INTO ldc_items_cotiz_proy
                (id_cotizacion_Detallada,
                 id_proyecto,
                 id_item,
                 cantidad,
                 costo,
                 precio,
                 tipo_item,
                 tipo_trab,
                 total_costo,
                 total_precio)
                SELECT onuNuevaCotizacionDetallada,
                       id_proyecto,
                       id_item,
                       cantidad,
                       costo,
                       precio,
                       tipo_item,
                       tipo_trab,
                       total_costo,
                       total_precio
                FROM   ldc_items_cotiz_proy licp
                WHERE  licp.id_cotizacion_detallada = inuCotizacionDetalladaOrigen
                AND    licp.id_proyecto = inuProyecto;

        EXCEPTION
            WHEN OTHERS THEN
                osbError := 'Se presento un error al intentar copiar los items fijos por unidad predial a partir de la cotizacion ' ||
                            inuCotizacionDetalladaOrigen || '. ' || SQLERRM;
                pkg_error.setErrorMessage(cnuDescripcionError, osbError);
        END;

        BEGIN

            -- Creacion de los tipos de trabajo de cotizacion
            INSERT INTO ldc_tipos_trabajo_cot
                (id_cotizacion_Detallada,
                 id_tipo_trabajo,
                 esta_ini_orden,
                 id_proyecto,
                 id_actividad_principal,
                 tipo_trabajo_desc)
                SELECT onuNuevaCotizacionDetallada,
                       id_tipo_trabajo,
                       esta_ini_orden,
                       id_proyecto,
                       id_actividad_principal,
                       tipo_trabajo_desc
                FROM   ldc_tipos_trabajo_cot lttc
                WHERE  lttc.id_cotizacion_detallada = inuCotizacionDetalladaOrigen
                AND    lttc.id_proyecto = inuProyecto;

        EXCEPTION
            WHEN OTHERS THEN
                osbError := 'Se presento un error al intentar copiar los tipos de trabajo a partir de la cotizacion ' ||
                            inuCotizacionDetalladaOrigen || '. ' || SQLERRM;
                pkg_error.setErrorMessage(cnuDescripcionError, osbError);
        END;

        BEGIN
            -- Creacion de los items de metraje
            INSERT INTO Ldc_Items_Metraje_Cot
                (id_cotizacion_detallada,
                 id_item,
                 flauta,
                 bbq,
                 horno,
                 estufa,
                 secadora,
                 calentador,
                 log_val_bajante,
                 long_bajante,
                 long_baj_tablero,
                 long_tablero,
                 id_proyecto,
                 costo,
                 precio)
                SELECT onuNuevaCotizacionDetallada,
                       id_item,
                       flauta,
                       bbq,
                       horno,
                       estufa,
                       secadora,
                       calentador,
                       log_val_bajante,
                       long_bajante,
                       long_baj_tablero,
                       long_tablero,
                       id_proyecto,
                       costo,
                       precio
                FROM   Ldc_Items_Metraje_Cot limc
                WHERE  limc.id_proyecto = inuProyecto
                AND    limc.id_cotizacion_detallada = inuCotizacionDetalladaOrigen;
        EXCEPTION
            WHEN OTHERS THEN
                osbError := 'Se presento un error al intentar copiar los items por metraje a partir de la cotizacion ' ||
                            inuCotizacionDetalladaOrigen || '. ' || SQLERRM;
                pkg_error.setErrorMessage(cnuDescripcionError, osbError);
        END;

        BEGIN
            -- Crear el detalle de metraje por cotizacion
            INSERT INTO ldc_detalle_met_cotiz
                (id_cotizacion_detallada,
                 id_piso,
                 id_tipo,
                 flauta,
                 horno,
                 bbq,
                 estufa,
                 secadora,
                 calentador,
                 long_val_baj,
                 long_bajante,
                 long_baj_tab,
                 long_tablero,
                 cant_unid_pred,
                 id_proyecto)
                SELECT onuNuevaCotizacionDetallada,
                       id_piso,
                       id_tipo,
                       flauta,
                       horno,
                       bbq,
                       estufa,
                       secadora,
                       calentador,
                       long_val_baj,
                       long_bajante,
                       long_baj_tab,
                       long_tablero,
                       cant_unid_pred,
                       id_proyecto
                FROM   ldc_detalle_met_cotiz ldmc
                WHERE  ldmc.id_cotizacion_detallada = inuCotizacionDetalladaOrigen
                AND    ldmc.id_proyecto = inuProyecto;

        EXCEPTION
            WHEN OTHERS THEN
                osbError := 'Se presento un error al intentar copiar el metraje por piso y tipo a partir de la cotizacion ' ||
                            inuCotizacionDetalladaOrigen || '. ' || SQLERRM;
                pkg_error.setErrorMessage(cnuDescripcionError, osbError);
        END;

        BEGIN
            -- Crear los items cotizados por unidad predial
            INSERT INTO ldc_items_por_unid_pred
                (id_proyecto,
                 id_cotizacion_detallada,
                 id_unidad_predial,
                 id_item,
                 cantidad,
                 precio,
                 costo,
                 id_torre,
                 id_piso,
                 id_tipo_trabajo,
                 id_val_fijo,
                 precio_total,
                 costo_total,
                 id_item_cotizado,
                 tipo_item)
                SELECT id_proyecto,
                       onuNuevaCotizacionDetallada,
                       id_unidad_predial,
                       id_item,
                       cantidad,
                       precio,
                       costo,
                       id_torre,
                       id_piso,
                       id_tipo_trabajo,
                       id_val_fijo,
                       precio_total,
                       costo_total,
                       id_item_cotizado,
                       tipo_item
                FROM   ldc_items_por_unid_pred lipup
                WHERE  lipup.id_proyecto = inuProyecto
                AND    lipup.id_cotizacion_detallada = inuCotizacionDetalladaOrigen;

        EXCEPTION
            WHEN OTHERS THEN
                osbError := 'Se presento un error al intentar copiar los items por unidad predial a partir de la cotizacion ' ||
                            inuCotizacionDetalladaOrigen || '. ' || SQLERRM;
                pkg_error.setErrorMessage(cnuDescripcionError, osbError);
        END;

        BEGIN
            -- Crear el consolidado de la cotizacion
            INSERT INTO ldc_consolid_cotizacion
                (id_proyecto,
                 id_cotizacion_detallada,
                 id_tipo_trabajo,
                 costo,
                 precio,
                 margen,
                 iva,
                 precio_total)
                SELECT id_proyecto,
                       onuNuevaCotizacionDetallada,
                       id_tipo_trabajo,
                       costo,
                       precio,
                       margen,
                       iva,
                       precio_total
                FROM   ldc_consolid_cotizacion lcc
                WHERE  lcc.id_proyecto = inuProyecto
                AND    lcc.id_cotizacion_detallada = inuCotizacionDetalladaOrigen;
        EXCEPTION
            WHEN OTHERS THEN
                osbError := 'Se presento un error al intentar copiar el consolidado a partir de la cotizacion ' ||
                            inuCotizacionDetalladaOrigen || '. ' || SQLERRM;
                pkg_error.setErrorMessage(cnuDescripcionError, osbError);
        END;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE ProAnulaCotizacion
    IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: ProAnulaCotizacion
        Descripcion:        Se anula la cotizacion de venta constructora

        Autor    : KCienfuegos
        Fecha    : 05-07-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
		    08-02-2017	 KCienfuegos.CA200-1030	Se anulan los flujos hijos de instalacion.
        05-07-2016   KCienfuegos            Creacion
        ******************************************************************/
        sbProceso                           VARCHAR2(4000) := csbPaquete||'.ProAnulaCotizacion';
        sbError                             VARCHAR2(4000);
        nuPaso                              NUMBER;
        sbID_PROYECTO                       ge_boInstanceControl.stysbValue;
        sbNOMBRE                            ge_boInstanceControl.stysbValue;
        sbID_COTIZACION_DETALLADA           ge_boInstanceControl.stysbValue;
        nuProyecto                          ldc_proyecto_constructora.id_proyecto%TYPE;
        nuCotizacion                        ldc_cotizacion_construct.id_cotizacion_detallada%TYPE;
        rcCotizacion                        daldc_cotizacion_construct.styLDC_COTIZACION_CONSTRUCT;
        nuCotizacionOsf                     cc_quotation.quotation_id%TYPE;
        nuSolicitudVenta                    cc_quotation.package_id%TYPE;
        nuPlanId                            wf_instance.instance_id%type;
        nuRetireType                        NUMBER :=2;
        nuNotas                             NUMBER;
        nuEstadoRetiro                      estacort.escocodi%TYPE := 95;
        nuEstadoProd                        pr_product.product_status_id%TYPE;

        CURSOR cuTramiteVenta IS
          SELECT mo_packages.package_id
            FROM mo_packages
           WHERE PACKAGE_type_id =
                 dald_parameter.fnuGetNumeric_Value('COD_TIPO_SOL_VENTAS_CONST',0)
             AND PACKAGE_id = nuSolicitudVenta;

        CURSOR cuProducto (nuPackageId   in mo_packages.package_id%type) is
          SELECT DISTINCT product_id, product_type_id
            FROM mo_motive
           WHERE package_id = nuPackageId;

        CURSOR cuPlanesHijos IS
           SELECT e.plan_id
             FROM wf_data_external e
            WHERE package_id = nuSolicitudVenta
              AND e.plan_id != nuPlanId;

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        sbID_PROYECTO := ge_boInstanceControl.fsbGetFieldValue ('LDC_COTIZACION_CONSTRUCT', 'ID_PROYECTO');
        sbNOMBRE := ge_boInstanceControl.fsbGetFieldValue ('LDC_PROYECTO_CONSTRUCTORA', 'NOMBRE');
        sbID_COTIZACION_DETALLADA := ge_boInstanceControl.fsbGetFieldValue ('LDC_COTIZACION_CONSTRUCT', 'ID_COTIZACION_DETALLADA');

        ------------------------------------------------
        -- User code
        ------------------------------------------------
        IF (sbID_PROYECTO IS NOT NULL) THEN
          nuProyecto := TO_NUMBER(sbID_PROYECTO);
        END IF;

        IF(sbID_COTIZACION_DETALLADA IS NOT NULL)THEN
          nuCotizacion := TO_NUMBER(sbID_COTIZACION_DETALLADA);
        END IF;

        nuPaso := 10;

        IF(daldc_cotizacion_construct.fblExist(inuID_COTIZACION_DETALLADA => nuCotizacion,
                                               inuID_PROYECTO => nuProyecto)) THEN

           nuPaso := 20;
           rcCotizacion := daldc_cotizacion_construct.frcGetRecord(inuID_COTIZACION_DETALLADA => nuCotizacion,
                                                                   inuID_PROYECTO => nuProyecto);

           IF(rcCotizacion.estado = csbCotizPreaprobada OR rcCotizacion.estado = csbCotizAprobada)THEN
              nuCotizacionOsf := rcCotizacion.ID_COTIZACION_OSF;

              IF(nuCotizacionOsf IS NOT NULL) THEN
                 nuPaso := 30;
                 -- Se anula la cotizacion de OSF
                 cc_boquotationmgr.UpdateQuotationStatus(nuCotizacionOsf, cc_boquotationutil.fsbGetQuotationAnnStat);

              END IF;

              nuPaso := 40;
              -- Se anula la cotizacion detallada
              daldc_cotizacion_construct.updESTADO(inuID_COTIZACION_DETALLADA => nuCotizacion,
                                                   inuID_PROYECTO => nuProyecto,
                                                   isbESTADO$ => csbCotizAnulada);

              daldc_cotizacion_construct.updFECHA_ULT_MODIF(inuID_COTIZACION_DETALLADA => nuCotizacion,
                                                            inuID_PROYECTO => nuProyecto,
                                                            idtFECHA_ULT_MODIF$ => SYSDATE);

              nuSolicitudVenta := dacc_quotation.fnugetpackage_id(inuquotation_id => nuCotizacionOsf);

              IF (nuSolicitudVenta IS NOT NULL) THEN

                 nuPaso := 50;
                 -- Se anula la transicion del paquete
                 mo_boannulment.packageinttransition(nuSolicitudVenta,ge_boparameter.fnuget('ANNUL_CAUSAL'));

                 nuPaso := 60;
                 -- Se reversan los cargos generados
                 nuNotas:=fnureqchargescancell(nuSolicitudVenta);

                 nuPaso := 70;
                 -- Se anulan las ordenes
                 or_boanullorder.anullactivities(nuSolicitudVenta,null,null);

                 nuPaso := 80;
                 -- Se obtiene el plan de la venta constructora
                 nuPlanId:=wf_boinstance.fnugetplanid(nuSolicitudVenta,17);

                 --Se anulan los planes hijos
                 FOR i IN cuPlanesHijos LOOP
                   BEGIN
                     mo_boannulment.annulwfplan(i.plan_id);
                   EXCEPTION
                     WHEN pkg_error.controlled_error THEN
                         RAISE pkg_error.controlled_error;
                      WHEN OTHERS THEN
                        RAISE;
                   END;
                 END LOOP;

                 IF nuPlanId IS NOT NULL THEN
                    nuPaso := 90;
                    BEGIN
                      mo_boannulment.annulwfplan(nuPlanId);
                    EXCEPTION
                      WHEN pkg_error.controlled_error THEN
                         RAISE pkg_error.controlled_error;
                      WHEN OTHERS THEN
                        RAISE;
                    END ;
                 END IF;

                 FOR rc IN cuProducto (nuSolicitudVenta) LOOP
                    nuPaso := 100;
                    -- Se retira el producto Gas
                    IF(rc.product_type_id = cnuProductoGas) THEN
                       nuEstadoProd := pkg_bcproducto.fnuestadoproducto(rc.product_id);

	                     IF(nuEstadoProd <> PR_BOConstants.CNUPRODUCT_UNINSTALL_RET)THEN
                         pr_boretire.RetireProduct(rc.product_id,nuRetireType, SYSDATE, SYSDATE, NULL, TRUE);
                       END IF;
                    END IF;

                    -- Se retira el producto generico
                    IF(rc.product_type_id = cnuProductoGenerico) THEN
                      nuPaso := 110;
                      pktblservsusc.updsesuesco(inuSesunuse => rc.product_id,
                                                inusesuesco$ => nuEstadoRetiro);

                      dapr_product.updproduct_status_id(inuProduct_Id => rc.product_id,inuproduct_status_id$ => pr_boconstants.cnuproduct_retire);


                    END IF;
                    nuEstadoProd := NULL;
                 END LOOP;

                 --Se inactivan las unidades prediales que se tenian para esa solicitud
                  BEGIN
                    UPDATE ldc_equival_unid_pred e
                       SET e.activa = 'N'
                     WHERE e.id_solicitud = nuSolicitudVenta
                       AND e.id_proyecto = nuProyecto;
                  EXCEPTION
                    WHEN OTHERS THEN
                      NULL;
                  END;

                  nuPaso := 120;

              END IF;
              -- Se actualiza la solicitud de venta del proyecto
              daldc_proyecto_constructora.updID_SOLICITUD(inuID_PROYECTO => nuProyecto,
                                                          inuID_SOLICITUD$ => NULL);

              -- Se actualiza el valor aprobado del proyecto
              daldc_proyecto_constructora.updVALOR_FINAL_APROB(inuID_PROYECTO => nuProyecto,
                                                               inuVALOR_FINAL_APROB$ => NULL);

              -- Se actualiza fecha de ultima modificacion
              daldc_proyecto_constructora.updFECH_ULT_MODIF(inuID_PROYECTO => nuProyecto,
                                                            idtFECH_ULT_MODIF$ => SYSDATE);
           ELSE
             sbError := 'La cotizacion debe estar Aprobada o Pre-aprobada para anularla';
             RAISE pkg_error.controlled_error;
           END IF;

        ELSE
          sbError := 'La cotizacion no existe';
          RAISE pkg_error.controlled_error;
        END IF;

        COMMIT;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            ROLLBACK;
            IF(sbError IS NOT NULL)THEN
	             pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            ROLLBACK;
            RAISE pkg_error.controlled_error;
    END;

    PROCEDURE proPlantilla_Intermedio(nuDato   NUMBER,
                                      osbError OUT VARCHAR2) IS
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

        sbProceso VARCHAR2(4000) := csbPaquete||'.proPlantilla_Intermedio';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN exError THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            osbError := 'TERMINO CON ERROR NO CONTROLADO  ' || sbProceso || '(' ||
                        nuPaso || '): ' || SQLCODE;
            pkg_traza.trace(osbError,cnuNVLTRC);
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
    END;

    PROCEDURE proPlantilla_Final(nuDato NUMBER) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:
        Descripcion:

        Autor    : Sandra Mu?oz
        Fecha    : 10-05-2016  CA 200-201

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        15-04-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'.proPlantilla_Final';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000); -- Mensaje de error

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        COMMIT;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN exError THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            ROLLBACK;
            pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error, sbError);

        WHEN OTHERS THEN
            sbError := 'TERMINO CON ERROR NO CONTROLADO  ' || csbPaquete || '.' || sbProceso || '(' ||
                       nuPaso || '): ' || SQLCODE;
            pkg_traza.trace(sbError,cnuNVLTRC);
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);

            ROLLBACK;

            pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error, sbError);

    END;

    PROCEDURE Process_solventa IS

		sbProceso VARCHAR2(4000) := csbPaquete||'.Process_solventa';
        onupackageid    mo_packages.package_id%TYPE;
        onumotiveid     mo_motive.motive_id%TYPE;
        onuerrorcode    NUMBER;
        osberrormessage VARCHAR2(4000);
		isbrequestxml	constants_per.tipo_xml_sol%type;

        sbID_COTIZACION_DETALLADA ge_boInstanceControl.stysbValue;
        sbID_PROYECTO             ge_boInstanceControl.stysbValue;
		
		nuFuncionario 			ge_person.person_id%TYPE;
		nuUnidadOperativa 		or_operating_unit.operating_unit_id%TYPE;
		nuMedioRecepcion		mo_packages.reception_type_id%TYPE;
		nuCliente				suscripc.suscclie%TYPE;
		nuDireccionRespuesta	ab_address.address_id%TYPE;
		sbObservacion			mo_packages.comment_%TYPE;
		nuContrato				suscripc.susccodi%TYPE;
		nuActividad				or_order_activity.order_activity_id%TYPE;
		nuCausal				ge_causal.causal_id%TYPE;
		Id_Direccion			ab_address.address_id%TYPE;
		Tipo_Vivienda			NUMBER;
		

    BEGIN
	
		
		
		isbrequestxml := pkg_xml_soli_venta.getSolicitudConstructora(nuFuncionario,
																	 nuUnidadOperativa,
																	 nuMedioRecepcion,
																	 nuCliente,
																	 nuDireccionRespuesta,
																	 sbObservacion,
																	 nuContrato,
																	 nuActividad,
																	 nuCausal,
																	 Id_Direccion,
																	 Tipo_Vivienda);
		
        api_registerRequestByXml (isbrequestxml,
                                  onupackageid    => onupackageid,
                                  onumotiveid     => onumotiveid,
                                  onuerrorcode    => onuerrorcode,
                                  osberrormessage => osberrormessage);

        pkg_traza.trace(

                       'onupackageid,       ' || onupackageid || ',' || 'onumotiveid,         ' ||
                       onumotiveid || ',' || 'onuerrorcode,         ' || onuerrorcode || ',' ||
                       'osberrormessage);      ' || osberrormessage || ');',
                       cnuNVLTRC);

        IF osberrormessage IS NOT NULL THEN
			pkg_traza.trace(sbProceso||': '||osberrormessage,cnuNVLTRC);
        END IF;
		
		pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
		
        COMMIT;

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            RAISE;
        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||' termina con errror ' || SQLERRM, cnuNVLTRC);
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;
    END;

    PROCEDURE proEnviaCorreoMargen(inuProyecto  IN  ldc_proyecto_constructora.id_proyecto%TYPE,
                                   inuCotizacion IN ldc_cotizacion_construct.id_cotizacion_detallada%TYPE,
                                   inuMargenInt  IN NUMBER,
                                   inuValMargenInt  IN NUMBER) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proEnviaCorreoMargen
        Descripcion:        Envia correo acerca del margen de instalacion interna

        Autor    : KCienfuegos
        Fecha    : 30-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        30-06-2016   KCienfuegos          Creacion
        ******************************************************************/
        osbError              VARCHAR2(4000);
        sbProceso             VARCHAR2(4000) := csbPaquete||'.proEnviaCorreoMargen';
        nuPaso                NUMBER;
        sbAsunto              VARCHAR2(600) := 'Notificacion del margen de Instalacion Interna';
        clMensaje             CLOB;
        sbNombreProyecto      ldc_proyecto_constructora.nombre%TYPE;
        sbTo                  VARCHAR2(10000);
        sbCC                  VARCHAR2(10000);
        blPrincipalDest       BOOLEAN := TRUE;
        sbParamCorreo         ld_parameter.value_chain%TYPE;
        nuMargenPorServ       NUMBER := 0;
        nuPorcMargen          NUMBER := 0;

        CURSOR cuEmails IS
		SELECT regexp_substr(sbParamCorreo, '[^;]+', 1, LEVEL)AS EMAIL
		FROM dual
		CONNECT BY regexp_substr(sbParamCorreo, '[^;]+', 1, LEVEL) IS NOT NULL;

        CURSOR cuObtieneMargenTotal IS
          SELECT SUM(nvl(cc.margen,0)) margen, decode(sum(nvl(cc.precio,1)),0,0, round(SUM(  nvl(cc.margen,0)) / SUM(ROUND(nvl(cc.precio,1),2))*100 ,2)) porc_margen
            FROM ldc_consolid_cotizacion cc
           WHERE cc.id_cotizacion_detallada = inuCotizacion
             AND cc.id_proyecto = inuProyecto;

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        sbParamCorreo := dald_parameter.fsbGetValue_Chain('EMAIL_NOTIF_MARGEN_MIN',0);

        IF(sbParamCorreo IS NOT NULL) THEN
          sbNombreProyecto := daldc_proyecto_constructora.fsbGetNOMBRE(inuProyecto);

          OPEN cuObtieneMargenTotal;
          FETCH cuObtieneMargenTotal INTO nuMargenPorServ, nuPorcMargen;
          CLOSE cuObtieneMargenTotal;

          nuMargenPorServ := NVL(nuMargenPorServ,0);

          clMensaje := 'Cordial Saludo.'||CHR(10)||CHR(10)||
                       'Mediante la presente se informa, que para el proyecto '||inuProyecto||'-'||sbNombreProyecto ||
                       ','||CHR(10)|| 'se ha pre-aprobado la cotizacion '||inuCotizacion||', donde el margen de la instalacion interna esta por debajo del permitido ['||
                       dald_parameter.fnuGetNumeric_Value('MIN_MARG_INST_INTERNA',0)||'%]: '||
                       'El margen de interna es de '||'$'||to_char(inuValMargenInt,'FM999,999,990.00')||' ['||inuMargenInt ||'%] y el margen por servicio: $'||to_char(nuMargenPorServ,'FM999,999,990.00')||' ['||nuPorcMargen||'%].';

          FOR I IN cuEmails LOOP
            IF blPrincipalDest THEN
              sbTo := I.EMAIL;
              blPrincipalDest := FALSE;
            ELSE
              sbCC := I.EMAIL ||','||sbCC;
            END IF;
          END LOOP;

          proEnviaCorreo(isbPara => sbTo,
                         isbCC => sbCC,
                         isbAsunto => sbAsunto,
                         iclMensaje => clMensaje);
        ELSE
          osbError := 'El parametro EMAIL_NOTIF_MARGEN_MIN  no esta configurado.';
          RAISE pkg_error.controlled_error;
        END IF;

        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR '||'('||nuPaso||'):'||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO'||'(' ||nuPaso || '):' || SQLERRM,cnuNVLTRC); 
			pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;
    END;

    PROCEDURE proGeneraCuponInicial(inuPackage  IN mo_packages.package_id%TYPE) IS
      /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proGeneraCuponInicial
        Descripcion:        genera cupon de cuota inciial plan 110

        Autor    : Josh Brito
        Fecha    :25/01/2019

        Entrada
          inuPackage numero de solicitud
        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------

        ******************************************************************/
      rgMotivos            	DAMO_MOTIVE.STYMO_MOTIVE;
      nuValorInicial        CC_QUOTATION.INITIAL_PAYMENT%TYPE;
	  sbProceso             VARCHAR2(4000) := csbPaquete||'.proGeneraCuponInicial';

      nuCupon      CUPON.CUPONUME%TYPE;

    CURSOR cuConsValorIni IS
    SELECT cp.CONFCUOTAINI * p.cant_unid_predial valor_inicial
    FROM LDC_COTIZACION_CONSTRUCT c, ldc_proyecto_constructora p, LDC_CONFPLCO cp
    WHERE p.ID_SOLICITUD = inuPackage
      AND p.ID_PROYECTO = c.ID_PROYECTO
      AND c.ESTADO IN ('A', 'P')
      AND c.plan_comercial_espcl = cp.codconfplco;

  BEGIN

	pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);
	
    pkg_traza.trace('InuPackage  ['||inuPackage||']',cnuNVLTRC);

    --se consulta si hay cuota inicial a pagar
    OPEN cuConsValorIni;
    FETCH cuConsValorIni INTO nuValorInicial;
    CLOSE cuConsValorIni;

    IF(nuValorInicial IS NOT NULL AND nuValorInicial > 0)THEN

        rgMotivos := MO_BOPACKAGES.FRCGETINITIALMOTIVE(inuPackage);

        IF(rgMotivos.SUBSCRIPTION_ID IS NULL)THEN
            pkg_error.setErrorMessage(2741,'La solicitud ['||inuPackage||'] no tiene un contrato asociado');
            RAISE pkg_error.controlled_error;
        END IF;

        IF(rgMotivos.PRODUCT_ID IS NULL)THEN

            pkg_error.setErrorMessage(900167,inuPackage);
            RAISE pkg_error.controlled_error;

        END IF;

        RC_BODEPOSITPAYMENTPROCESS.CREATEDEPOSITVALUE
        (
            inuPackage,
            nuValorInicial
          );


        RC_BODEPOSITPAYMENTPROCESS.CREATEDEPOSITCOUPON
        (
            inuPackage,
            nuCupon
        );

        pkg_traza.trace('Cupon ['||nuCupon||']',cnuNVLTRC);

    END IF;
	
	pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);

 EXCEPTION
    WHEN pkg_error.controlled_error THEN
	pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
    RAISE;

   WHEN OTHERS THEN
          pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO EN '|| SQLERRM, cnuNVLTRC);
		  pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
          pkg_error.setError;
          RAISE pkg_error.controlled_error;
  END proGeneraCuponInicial;

  FUNCTION 	FNUVALIVENTESP (inuPackage  IN mo_packages.package_id%TYPE) RETURN NUMBER IS
      /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: FNUVALIVENTESP
        Descripcion:        valida si la venta de cnstructora es especial o no

        Autor    : Josh Brito
        Fecha    :10/04/2019

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------

        ******************************************************************/
     nuIsEspecial NUMBER := 0;
	 
     sbProceso             VARCHAR2(4000) := csbPaquete||'.FNUVALIVENTESP';


     sbdatos VARCHAR2(1);
     -- Se valida si es tramite especial
     CURSOR cuValidaPlanEspec IS
     SELECT '1'
     FROM ldc_proyecto_constructora p,
           ldc_cotizacion_construct lcc
      WHERE lcc.estado IN   ('A', 'P')
        AND lcc.id_proyecto = p.id_proyecto
        AND  p.id_solicitud = inuPackage
        AND plan_comercial_espcl IS NOT NULL
		AND  plan_comercial_espcl <> -1;


  BEGIN
  
  pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);
  
    IF fblAplicaentregaxcaso('200-2022') THEN
         OPEN cuValidaPlanEspec;
         FETCH cuValidaPlanEspec INTO sbdatos;
         IF cuValidaPlanEspec%FOUND THEN
            nuIsEspecial := 1;
         END IF;
         CLOSE cuValidaPlanEspec;
    END IF;
	
  pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
	

    RETURN nuIsEspecial;

  EXCEPTION
    WHEN pkg_error.controlled_error THEN
      RAISE pkg_error.controlled_error;
	  pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
      RETURN nuIsEspecial;
   WHEN OTHERS THEN
          pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO EN FNUVALIVENTESP'|| SQLERRM, cnuNVLTRC);
		  pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
          pkg_error.setError;
          RAISE pkg_error.controlled_error;
  END FNUVALIVENTESP;

  PROCEDURE 	proGetActividadesPlEspe (inuplanespe  IN LDC_COTIZACION_CONSTRUCT.PLAN_COMERCIAL_ESPCL%TYPE,
                                       onuActividadcxc  OUT NUMBER,
                                      onuActividadins  OUT NUMBER,
                                      osbPlanEspe  OUT VARCHAR2) IS
      /*****************************************************************
      Propiedad intelectual de Gases del Caribe.

      Nombre del Paquete: proGetActividadesPlEspe
      Descripcion:        Retorna actividades de cxc y certi a constructora

      Autor    : Josh Brito
      Fecha    :10/04/2019
      Ticket   : 200-2022

      Datos de Entrada
      inuplanespe  plan especial
      Datos de salida
      onuActividadcxc actividad cxc 1 si 0 no
      onuActividadins actividad insp 1 si 0 no

      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.              Modificacion
      -----------  -------------------    -------------------------------------
    ******************************************************************/
    nuRespHijo    NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_PARPERSONAHIJO', NULL);--se almacena codigo de responsable hijo
	
	sbProceso             VARCHAR2(4000) := csbPaquete||'.proGetActividadesPlEspe';

    --se consulta que actividades cotienen la el plan especial
    CURSOR cuDatosActividades IS
     SELECT  decode(CONFRESPCXC, nuRespHijo, 0, 1) activcxc,
             decode(CONFRESPCERT, nuRespHijo, 0, 1) actirevcer,
             confplcc
    FROM ldc_confplco
    WHERE codconfplco = inuplanespe;

  BEGIN

	 pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);
	 
     onuActividadcxc := 0;
     onuActividadins := 0;

     --se carga informacion del plan
     OPEN cuDatosActividades;
     FETCH cuDatosActividades INTO onuActividadcxc, onuActividadins, osbPlanEspe;
     IF cuDatosActividades%NOTFOUND THEN
       onuActividadcxc := 0;
        onuActividadins := 0;
        osbPlanEspe := 'N';
     END IF;
     CLOSE cuDatosActividades;
	 
	 pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_error.controlled_error THEN
	  pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
      RAISE pkg_error.controlled_error;
   WHEN OTHERS THEN
          pkg_traza.trace(sbProceso||'TERMINO CON ERROR NO CONTROLADO EN proGetActividadesPlEspe'|| SQLERRM, cnuNVLTRC);
		  pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
          pkg_error.setError;
          RAISE pkg_error.controlled_error;

  END proGetActividadesPlEspe;
  
  FUNCTION FrfOrdenInternas(inuProyecto number) RETURN tyRefCursor IS
      /*****************************************************************
      Propiedad intelectual de Gases del Caribe.

      Nombre del proceso: FrfOrdenInternas
      Descripcion:        Retorna ordenes de internas

      Autor    : Horbath
      Fecha    :16/10/2019
      Ticket   : 153

      Datos de Entrada
      inuProyecto  codigo del proyecto

      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.              Modificacion
      -----------  -------------------    -------------------------------------
    ******************************************************************/
      rfQuery tyRefCursor;
      
      sbTitrInterna VARCHAR2(4000) := dald_parameter.fsbgetvalue_chain('LDC_TITRINTERNA', null);
	  
	  sbProceso             VARCHAR2(4000) := csbPaquete||'.FrfOrdenInternas';
    
    BEGIN
	
	pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);
    pkg_traza.trace('Proyecto [' || inuProyecto || ']', cnuNVLTRC);

  
    open rfQuery for
    SELECT NVL((SELECT estado FROM LDC_ORINPERLEG WHERE orden = o.order_id),'N') id,
             o.order_id orden, 
             oa.package_id solicitud,
             oa.subscription_id contrato,
             oa.product_id producto ,
             daab_address.fsbgetaddress_parsed(oa.address_id,null) direccion
      FROM or_order o, or_order_activity oa, ldc_proyecto_constructora pc
      WHERE o.order_id = oa.order_id 
       AND pc.id_solicitud = oa.package_id 
       AND pc.id_proyecto = inuProyecto
       AND o.task_type_id IN ( SELECT to_number(regexp_substr(sbTitrInterna,'[^,]+', 1, LEVEL)) AS titr
                              FROM   dual 
                              CONNECT BY regexp_substr(sbTitrInterna, '[^,]+', 1, LEVEL) IS NOT NULL)
       AND o.order_status_id NOT IN (SELECT oe.order_status_id
                                     FROM or_order_status oe
                                     WHERE oe.is_final_status = 'Y')
       ;
  
    pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
  
    return(rfQuery);
  EXCEPTION
    when pkg_error.controlled_error then
	  pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
      raise pkg_error.controlled_error;
    when others then
      pkg_error.setError;
	  pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;    
    END FrfOrdenInternas;
    
    FUNCTION FrfOrdenInternasMod(inuProyecto number) RETURN tyRefCursor IS
    /*****************************************************************
      Propiedad intelectual de Gases del Caribe.

      Nombre del proceso: FrfOrdenInternasMod
      Descripcion:        Retorna ordenes de internas

      Autor    : Horbath
      Fecha    :16/10/2019
      Ticket   : 153

      Datos de Entrada
      inuProyecto  codigo del proyecto

      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.              Modificacion
      -----------  -------------------    -------------------------------------
    ******************************************************************/
        rfQuery tyRefCursor;
      
      sbTitrInterna VARCHAR2(4000) := dald_parameter.fsbgetvalue_chain('LDC_TITRINTERNA', null);
	  
	  sbProceso             VARCHAR2(4000) := csbPaquete||'.FrfOrdenInternasMod';
    
    BEGIN
	
		pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);
        pkg_traza.trace('Proyecto [' || inuProyecto || ']', cnuNVLTRC);

  
        open rfQuery for
        SELECT o.order_id orden
          FROM or_order o, or_order_activity oa, ldc_proyecto_constructora pc
          WHERE o.order_id = oa.order_id 
           AND pc.id_solicitud = oa.package_id 
           AND pc.id_proyecto = inuProyecto
           AND o.task_type_id IN ( SELECT to_number(regexp_substr(sbTitrInterna,'[^,]+', 1, LEVEL)) AS titr
                                  FROM   dual 
                                  CONNECT BY regexp_substr(sbTitrInterna, '[^,]+', 1, LEVEL) IS NOT NULL)
           ;
      
        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
      
        return(rfQuery);
  EXCEPTION
    when pkg_error.controlled_error then
	  pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
      raise pkg_error.controlled_error;
    when others then
      pkg_error.setError;
	  pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;    
    END FrfOrdenInternasMod;
  
    PROCEDURE  prPermLegaOrden( inuOrden in number,
                                inuSolicitud IN NUMBER,
                                inuProyecto IN NUMBER,
                                isbEstado IN VARCHAR2,
                                onuok out number,
                                osberror out varchar2) is
      /*****************************************************************
      Propiedad intelectual de Gases del Caribe.

      Nombre del proceso: prPermLegaOrden
      Descripcion:        permite o no legalizar la orden

      Autor    : Horbath
      Fecha    :16/10/2019
      Ticket   : 153

      Datos de Entrada
      inuOrden  codigo de la orden
      inuSolicitud  numero de la solicitud
      inuProyecto   numero del proyecto
      isbEstado  estado
      Datos de salida
      onuok   -1 error 0 correcto
      osberror  mensaje de error
      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.              Modificacion
      -----------  -------------------    -------------------------------------
    ******************************************************************/
      --se consulta estado de la orden 
      CURSOR cuEstadoOrden IS
      SELECT estado
      FROM LDC_ORINPERLEG
      WHERE ORDEN = inuOrden;
            sbEstadoActual LDC_ORINPERLEG.estado%type;-- se almacena de estado de permitir legalizar  orden 
			
	  sbProceso             VARCHAR2(4000) := csbPaquete||'.prPermLegaOrden';
	  
    BEGIN
		
		pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);
		
        pkg_traza.trace(' orden ['|| inuOrden||'] solicitud ['|| inuSolicitud||'] proyecto ['||inuProyecto||'] estado ['||isbEstado||']', cnuNVLTRC);
    
        --se carga orden 
        OPEN cuEstadoOrden;
        FETCH cuEstadoOrden INTO sbEstadoActual;
        IF cuEstadoOrden%NOTFOUND THEN
           pkg_traza.trace('Ingreso a insertar', cnuNVLTRC);
            INSERT INTO LDC_ORINPERLEG(ORDEN, SOLICITUD,   PROYECTO,   FECHA_PERMISO, USUARIO, ESTADO)
                VALUES (inuOrden, inuSolicitud, inuProyecto, sysdate, user, isbEstado);
        ELSE
           UPDATE LDC_ORINPERLEG SET FECHA_PERMISO= SYSDATE, USUARIO = USER, ESTADO = isbEstado WHERE orden = inuOrden;
           pkg_traza.trace('Ingreso a modificar', cnuNVLTRC);
        END IF;
        CLOSE cuEstadoOrden;
        onuok := 0;
        osberror := '';
        commit;
        pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    
    EXCEPTION
      when pkg_error.controlled_error then
         pkg_error.getError(onuok, osberror);
		 pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
          ROLLBACK;
      when others then
        pkg_error.setError;
		pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
         ROLLBACK;
        raise pkg_error.controlled_error;  
    END prPermLegaOrden;
    
     PROCEDURE  prModiOrdInte( inuOrdenOrig in number,
                              inuOrdenDest IN NUMBER,                               
                              onuok out number,
                              osberror out varchar2) IS
      /*****************************************************************
      Propiedad intelectual de Gases del Caribe.

      Nombre del proceso: prModiOrdInte
      Descripcion:        modifica orden interna

      Autor    : Horbath
      Fecha    :16/10/2019
      Ticket   : 153

      Datos de Entrada
        inuOrden  codigo de la orden
        inuSolicitud  numero de la solicitud
        inuProyecto   numero del proyecto
        isbEstado  estado
      Datos de salida
        onuok   -1 error 0 correcto
        osberror  mensaje de error
      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.              Modificacion
      -----------  -------------------    -------------------------------------
    ******************************************************************/
	
	sbProceso             VARCHAR2(4000) := csbPaquete||'.prModiOrdInte';
      --se consulta la informacion de la orden origen
      CURSOR cugetOrdenOrig IS
      SELECT oa.ADDRESS_ID direcori,
             oa.SUBSCRIPTION_ID contratoori,
            oa.PRODUCT_ID productoori,
            o.OPERATING_SECTOR_ID sectorig
      FROM or_order_activity oa, or_order o
      WHERE oa.order_id = inuOrdenOrig
       AND oa.order_id = o.order_id;
      
      regOrdenorig cugetOrdenOrig%rowtype;
      
     --se consulta la informacion de la orden destino
      CURSOR cugetOrdenDest IS
      SELECT oa.ADDRESS_ID direcdest,
             oa.SUBSCRIPTION_ID contratodest,
            oa.PRODUCT_ID productodest,
            o.OPERATING_SECTOR_ID sectdest
      FROM or_order_activity oa, or_order o
      WHERE oa.order_id = inuOrdenDest
        AND oa.order_id = o.order_id;
        
        regOrdenDest cugetOrdenDest%rowtype;
      
   
   BEGIN
      pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);
	  
      pkg_traza.trace(' orden orig ['||inuOrdenOrig||'] orden destino ['||inuOrdenDest||']', cnuNVLTRC);
	  
      --se carga informacion de la orden origen
      OPEN cugetOrdenOrig;
      FETCH cugetOrdenOrig INTO regOrdenorig;
      IF cugetOrdenOrig%NOTFOUND THEN
        onuok := -1;
        osberror := 'Orden Origen['||inuOrdenOrig||'] no existe';
        CLOSE cugetOrdenOrig;
        raise pkg_error.controlled_error; 
      END IF;
      CLOSE cugetOrdenOrig;
      
       --se carga informacion de la orden destino
      OPEN cugetOrdenDest;
      FETCH cugetOrdenDest INTO regOrdenDest;
      IF cugetOrdenDest%NOTFOUND THEN
        onuok := -1;
        osberror := 'Orden Destino['||inuOrdenDest||'] no existe';
        CLOSE cugetOrdenDest;
        raise pkg_error.controlled_error; 
      END IF;
      CLOSE cugetOrdenDest;
      --Se actualiza orden origen
      UPDATE or_order_activity oa 
         SET oa.ADDRESS_ID = regOrdenDest.direcdest,
             oa.SUBSCRIPTION_ID = regOrdenDest.contratodest,
            oa.PRODUCT_ID = regOrdenDest.productodest
      WHERE oa.order_id = inuOrdenOrig;
      
      UPDATE or_order o 
           SET  o.OPERATING_SECTOR_ID = regOrdenDest.sectdest,
                o.external_address_id = regOrdenDest.direcdest
      WHERE o.order_id = inuOrdenOrig;
      
       --Se actualiza orden destino
      UPDATE or_order_activity oa 
           SET oa.ADDRESS_ID = regOrdenorig.direcori,
              oa.SUBSCRIPTION_ID = regOrdenorig.contratoori,
              oa.PRODUCT_ID = regOrdenorig.productoori
      WHERE oa.order_id = inuOrdenDest;
      
      UPDATE or_order o 
           SET  o.OPERATING_SECTOR_ID = regOrdenorig.sectorig, 
                o.external_address_id = regOrdenorig.direcori
      WHERE o.order_id = inuOrdenDest;
      
      onuok := 0;
      osberror := '';
      commit;
      pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN);
    
    EXCEPTION
      when pkg_error.controlled_error then
         pkg_error.getError(onuok, osberror);
		 pkg_traza.trace(sbProceso||osberror,cnuNVLTRC);
         pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERC);
         ROLLBACK;
      when others then
        pkg_error.setError;
         ROLLBACK;
		 pkg_traza.trace(sbProceso,cnuNVLTRC,pkg_traza.csbFIN_ERR);
        raise pkg_error.controlled_error;  
    end prModiOrdInte;
END ldc_boCotizacionConstructora;
/