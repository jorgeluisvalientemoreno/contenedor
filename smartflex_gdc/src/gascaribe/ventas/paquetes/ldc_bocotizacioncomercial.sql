create or replace PACKAGE LDC_BOCOTIZACIONCOMERCIAL IS

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : LDC_BOCOTIZACIONCOMERCIAL
  Descripcion    : Paquete que contiene la logica de negocio para las cotizaciones de
                   ventas comerciales e industriales.
  Autor          : KCienfuegos
  Fecha          : 20-10-2016
  Caso           : CA200-535

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  14-12-2022    jpinedc.JIRA-750            Creacion
  20-10-2016    KCienfuegos.CA200-535        Creacion
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proCreaCotizacion
  Descripcion    : Metodo para crear cotizaci?n
  Autor          : KCienfuegos
  Fecha          : 21-10-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                           Modificacion
  ===============================================================
  14-12-2022    JpinedC.JIRA-750                Se modifica proEnviaACotizadorOSF          
  21-10-2016    KCienfuegos.CA200-535           Creacion.
  ******************************************************************/
  PROCEDURE proCreaCotizacion(inuCliente        IN     ge_subscriber.subscriber_id%TYPE, -- Cliente
                              inuDireccion      IN     ldc_cotizacion_comercial.id_direccion%TYPE, -- Direccion
                              inuValorCotizado  IN     ldc_cotizacion_comercial.valor_cotizado %TYPE, -- Valor Cotizado
                              inuDescuento      IN     ldc_cotizacion_comercial.descuento%TYPE, -- Descuento
                              isbObservacion    IN     ldc_cotizacion_comercial.observacion %TYPE, -- Observacion
                              idtFechaVigencia  IN     ldc_cotizacion_comercial.fecha_vigencia %TYPE, -- Fecha Vigencia
                              idtSectorComerci  IN     ldc_cotizacion_comercial.COMERCIAL_SECTOR_ID %TYPE, -- SECTOR COMERCIAL
                              idtNumFormulario  IN     ldc_cotizacion_comercial.NUMERO_FORMULARIO %TYPE, -- numero de formulario
                              idtUnidadOperati  IN     ldc_cotizacion_comercial.OPERATING_UNIT_ID %TYPE, -- unidad operativa
                              idtSolicitud      IN     ldc_cotizacion_comercial.PACKAGE_ID %TYPE, -- SOLICITUD
                              onuCotizacion     OUT    ldc_cotizacion_comercial.id_cot_comercial%TYPE -- Id Cotizacion
                              );

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proCreaTipoTrabajo
  Descripcion    : Metodo para crear el tipo de trabajo a cotizar
  Autor          : KCienfuegos
  Fecha          : 21-10-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  21-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proCreaTipoTrabajo(inuCotizacion     IN    ldc_cotizacion_comercial.id_cot_comercial%TYPE, -- Id Cotizacion
                               isbAbreviatura    IN    ldc_tipotrab_coti_com.abreviatura%TYPE, -- Abreviatura
                               inuTipoTrabajo    IN    ldc_tipotrab_coti_com.tipo_trabajo  %TYPE, -- Tipo Trabajo
                               inuActividad      IN    ldc_tipotrab_coti_com.actividad%TYPE, -- Actividad
                               inuIva            IN    ldc_tipotrab_coti_com.iva%TYPE, -- IVA
                               isbAplicaDesc     IN    ldc_tipotrab_coti_com.aplica_desc%TYPE -- Aplica Descuento?
                               );

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proCreaItem
  Descripcion    : Metodo para crear los items cotizados
  Autor          : KCienfuegos
  Fecha          : 21-10-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  21-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proCreaItem(inuCotizacion    IN      ldc_cotizacion_comercial.id_cot_comercial%TYPE, -- Cotizacion
                        inuTipoTrab      IN      ldc_items_cotizacion_com.tipo_trabajo%TYPE, -- Tipo de trabajo
                        inuActividad     IN      ldc_items_cotizacion_com.actividad%TYPE, -- Actividad
                        inuLista         IN      ldc_items_cotizacion_com.id_lista%TYPE, -- Lista
                        inuItem          IN      ldc_items_cotizacion_com.id_item%TYPE, -- Item
                        inuCosto         IN      ldc_items_cotizacion_com.costo_venta%TYPE, -- Costo
                        inuAiu           IN      ldc_items_cotizacion_com.aiu%TYPE, -- AIU
                        inuCantidad      IN      ldc_items_cotizacion_com.cantidad%TYPE, -- Cantidad
                        inuDescuento     IN      ldc_items_cotizacion_com.descuento%TYPE, -- Descuento
                        inuPrecioTotal   IN      ldc_items_cotizacion_com.precio_total%TYPE, -- Precio Total
                        inuIva           IN      ldc_items_cotizacion_com.Iva%TYPE --IVA
                        );

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proModificaCotizacion
  Descripcion    : Metodo para modificar cotizaci?n
  Autor          : KCienfuegos
  Fecha          : 21-10-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  21-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proModificaCotizacion(inuCotizacion     IN    ldc_cotizacion_comercial.id_cot_comercial%TYPE, -- Id Cotizacion
                                  inuDireccion      IN    ldc_cotizacion_comercial.id_direccion%TYPE, -- Direccion
                                  inuValorCotizado  IN    ldc_cotizacion_comercial.valor_cotizado %TYPE, -- Valor Cotizado
                                  inuDescuento      IN    ldc_cotizacion_comercial.descuento%TYPE, -- Descuento
                                  isbObservacion    IN    ldc_cotizacion_comercial.observacion %TYPE, -- Observacion
                                  idtFechaVigencia  IN    ldc_cotizacion_comercial.fecha_vigencia %TYPE, -- Fecha Vigencia
                                  idtSectorComerci  IN     ldc_cotizacion_comercial.COMERCIAL_SECTOR_ID %TYPE, -- SECTOR COMERCIAL
                                  idtNumFormulario  IN     ldc_cotizacion_comercial.NUMERO_FORMULARIO %TYPE, -- numero de formulario
                                  idtUnidadOperati  IN     ldc_cotizacion_comercial.OPERATING_UNIT_ID %TYPE, -- unidad operativa
                                  idtSolicitud      IN     ldc_cotizacion_comercial.PACKAGE_ID %TYPE -- SOLICITUD
                                  );

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proModificaTipoTrabajo
  Descripcion    : Metodo para modificar el tipo de trabajo a cotizar
  Autor          : KCienfuegos
  Fecha          : 21-10-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  21-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proModificaTipoTrabajo(inuCotizacion     IN    ldc_cotizacion_comercial.id_cot_comercial%TYPE, -- Id Cotizacion
                                   isbAbreviatura    IN    ldc_tipotrab_coti_com.abreviatura%TYPE, -- Abreviatura
                                   inuTipoTrabajo    IN    ldc_tipotrab_coti_com.tipo_trabajo  %TYPE, -- Tipo Trabajo
                                   inuActividad      IN    ldc_tipotrab_coti_com.actividad%TYPE, -- Actividad
                                   inuIva            IN    ldc_tipotrab_coti_com.iva%TYPE, -- IVA
                                   isbAplicaDesc     IN    ldc_tipotrab_coti_com.aplica_desc%TYPE, -- Aplica Descuento?
                                   isbOperacion      IN    VARCHAR2 --Operacion
                                   );

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proModificaItem
  Descripcion    : Metodo para modificar los items cotizados
  Autor          : KCienfuegos
  Fecha          : 21-10-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  21-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proModificaItem(inuConsecutivo   IN      ldc_items_cotizacion_com.consecutivo%TYPE, --Consecutivo
                            inuCotizacion    IN      ldc_cotizacion_comercial.id_cot_comercial%TYPE, -- Id Cotizacion
                            inuTipoTrab      IN      ldc_items_cotizacion_com.tipo_trabajo%TYPE, -- Tipo de trabajo
                            inuActividad     IN      ldc_items_cotizacion_com.actividad%TYPE, -- Actividad
                            inuLista         IN      ldc_items_cotizacion_com.id_lista%TYPE, -- Lista
                            inuItem          IN      ldc_items_cotizacion_com.id_item%TYPE, -- Item
                            inuCosto         IN      ldc_items_cotizacion_com.costo_venta%TYPE, -- Costo
                            inuAiu           IN      ldc_items_cotizacion_com.aiu%TYPE, -- AIU
                            inuCantidad      IN      ldc_items_cotizacion_com.cantidad%TYPE, -- Cantidad
                            inuDescuento     IN      ldc_items_cotizacion_com.descuento%TYPE, -- Descuento
                            inuPrecioTotal   IN      ldc_items_cotizacion_com.precio_total%TYPE, -- Precio Total
                            inuIva           IN      ldc_items_cotizacion_com.Iva%TYPE, --IVA
                            isbOperacion     IN      VARCHAR2 --Operacion
                            );

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proActualizaUltModif
  Descripcion    : Metodo para actualizar fecha y usuario que realiza
                   la ?ltima modificaci?n en la cotizaci?n.
  Autor          : KCienfuegos
  Fecha          : 21-10-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  21-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proActualizaUltModif(inuCotizacion    IN      ldc_cotizacion_comercial.id_cot_comercial%TYPE -- Id Cotizacion
                                 );

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proMarcaClienteEspecial
  Descripcion    : Metodo para marcar a un cliente especial
  Autor          : KCienfuegos
  Fecha          : 21-10-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  21-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proMarcaClienteEspecial(inuCliente   IN      ge_subscriber.subscriber_id%TYPE, -- Id Cliente
                                    isbClienteEspecial IN VARCHAR2 -- Cliente especial?
                                    );

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proOrdVerifClienteEsp
  Descripcion    : Metodo para crear orden de verificaci?n de cliente especial
  Autor          : KCienfuegos
  Fecha          : 15-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  15-11-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proOrdVerifClienteEsp(inuSolicitud   IN  mo_packages.package_id%TYPE,
                                  inuCliente     IN  ge_subscriber.subscriber_id%TYPE  DEFAULT NULL,
                                  inuSolCot      IN  mo_packages.package_id%TYPE  DEFAULT NULL);

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proGenOrdCambioCiclo
  Descripcion    : Metodo para crear orden de cambio de ciclo, dependiendo de
                   la causal utilizada para legalizar la orden de verificaci?n
                   de cambio de ciclo. (Utilizado en PLUGIN)
  Autor          : KCienfuegos
  Fecha          : 16-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  16-11-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proGenOrdCambioCiclo;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proRegistraPresion
  Descripcion    : Metodo para registrar la presi?n. (Utilizado en FMIO)
  Autor          : KCienfuegos
  Fecha          : 28-12-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  28-12-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proRegistraPresion;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proEnviaACotizadorOSF
  Descripcion    : Metodo para enviar cotizacion comercial al cotizador de OSF
  Autor          : KCienfuegos
  Fecha          : 01-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  01-11-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proEnviaACotizadorOSF(inuCotizacion    IN      ldc_cotizacion_comercial.id_cot_comercial%TYPE);

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proActualizaCotiOSF
  Descripcion    : Metodo para actualizar la cotizacion de OSF
  Autor          : KCienfuegos
  Fecha          : 10-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  10-11-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proActualizaCotiOSF(inuCotizacion    IN    ldc_cotizacion_comercial.id_cot_comercial%TYPE,
                                blBorracondfin   IN    BOOLEAN);

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proImprimeCotizacion
  Descripcion    : Metodo para imprimir la cotizaci?n de venta comercial/industrial
  Autor          : KCienfuegos
  Fecha          : 09-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  09-11-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proImprimeCotizacion(inuCotizacion     IN    ldc_cotizacion_comercial.id_cot_comercial%TYPE -- Id Cotizacion
                                 );

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proCotizacionDataAdicional
  Descripcion    : Metodo para registrar Data Adicional a la cotizacion
  Autor          : Jorge Valiente
  Fecha          : 10-10-2023
  Caso           : OSF-1492

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  PROCEDURE proRegistraAIUCotizacion(InuCotizacion    IN ldc_cotizacion_comercial.id_cot_comercial%TYPE,
                                     InuAIUPorcentaje IN number);

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : proActualizaAIUCotizacion
  Descripcion    : Metodo para Actualizar AIU de la cotizacion
  Autor          : Jorge Valiente
  Fecha          : 10-10-2023
  Caso           : OSF-1492
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  PROCEDURE proActualizaAIUCotizacion(InuCotizacion    IN ldc_cotizacion_comercial.id_cot_comercial%TYPE,
                                      InuAIUPorcentaje IN number);

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fnuObtenerAIUCotizacion
  Descripcion    : Metodo para Obtener AIU de la cotizacion
  Autor          : Jorge Valiente
  Fecha          : 10-10-2023
  Caso           : OSF-1492
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  FUNCTION fnuObtenerAIUCotizacion(inuCotizacion IN number) RETURN NUMBER;

END LDC_BOCOTIZACIONCOMERCIAL;
/

create or replace PACKAGE BODY LDC_BOCOTIZACIONCOMERCIAL IS

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : LDC_BOCOTIZACIONCOMERCIAL
  Descripcion    : Paquete que contiene la logica de negocio para las cotizaciones de
                   ventas comerciales e industriales.
  Autor          : KCienfuegos
  Fecha          : 20-10-2016
  Caso           : CA200-535

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  20-10-2016    KCienfuegos.CA200-535        Creacion
  ******************************************************************/

  --Constantes
  csbPaquete                               VARCHAR2(60) := 'ldc_bocotizacioncomercial';
  cnuCodigoError              CONSTANT     NUMBER       := 2741;
  csbEstadoRegistrada         CONSTANT     VARCHAR2(2)  := 'R';
  csbEstadoEnviadaOSF         CONSTANT     VARCHAR2(2)  := 'E';
  csbEstadoAprobada           CONSTANT     VARCHAR2(2)  := 'A';
  csbOperacionBorrar          CONSTANT     VARCHAR2(2)  := 'D';
  csbOperacionActualizar      CONSTANT     VARCHAR2(2)  := 'U';
  cnuMetodoLiquidacion        CONSTANT     NUMBER := dald_parameter.fnuGetNumeric_Value('MET_LIQU_COT_COMERCIAL',0);
  cnuConfexme                 CONSTANT     ed_confexme.coemcodi%TYPE := dald_parameter.fnuGetNumeric_Value('CONFEXME_COT_COMERCIAL',0);
  cnuActVerifClienteEspecial  CONSTANT     or_order_activity.activity_id%TYPE := dald_parameter.fnuGetNumeric_Value('ACT_VERIF_CLIENTE_ESP',0);
  cnuActCambioCiclo           CONSTANT     or_order_activity.activity_id%TYPE := dald_parameter.fnuGetNumeric_Value('ACT_CAMBIO_CICLO',0);
  cnuDepartamentoAtlant       CONSTANT     ge_geogra_location.geograp_location_id%TYPE := dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_ATLANTICO',0);
  cnuDepartamentoCesar        CONSTANT     ge_geogra_location.geograp_location_id%TYPE := dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_CESAR',0);
  cnuDepartamentoMag          CONSTANT     ge_geogra_location.geograp_location_id%TYPE := dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_MAGDALENA',0);
  cnuDepartamentoQuindio      CONSTANT     ge_geogra_location.geograp_location_id%TYPE := dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_QUINDIO',0);
  cnuDepartamentoCaldas       CONSTANT     ge_geogra_location.geograp_location_id%TYPE := dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_CALDAS',0);
  cnuDepartamentoRis          CONSTANT     ge_geogra_location.geograp_location_id%TYPE := dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_RISARALDA',0);

  csbNOMPKG            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';--constante nombre del paquete    
  csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;--Nivel de traza para este paquete. 

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proCreaCotizacion
  Descripcion    : Metodo para crear cotizaci?n
  Autor          : KCienfuegos
  Fecha          : 21-10-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  21-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proCreaCotizacion(inuCliente        IN     ge_subscriber.subscriber_id%TYPE, -- Cliente
                              inuDireccion      IN     ldc_cotizacion_comercial.id_direccion%TYPE, -- Direccion
                              inuValorCotizado  IN     ldc_cotizacion_comercial.valor_cotizado %TYPE, -- Valor Cotizado
                              inuDescuento      IN     ldc_cotizacion_comercial.descuento%TYPE, -- Descuento
                              isbObservacion    IN     ldc_cotizacion_comercial.observacion %TYPE, -- Observacion
                              idtFechaVigencia  IN     ldc_cotizacion_comercial.fecha_vigencia %TYPE, -- Fecha Vigencia
                              idtSectorComerci  IN     ldc_cotizacion_comercial.COMERCIAL_SECTOR_ID %TYPE, -- SECTOR COMERCIAL
                              idtNumFormulario  IN     ldc_cotizacion_comercial.NUMERO_FORMULARIO %TYPE, -- numero de formulario
                              idtUnidadOperati  IN     ldc_cotizacion_comercial.OPERATING_UNIT_ID %TYPE, -- unidad operativa
                              idtSolicitud      IN     ldc_cotizacion_comercial.PACKAGE_ID %TYPE, -- SOLICITUD
                              onuCotizacion     OUT    ldc_cotizacion_comercial.id_cot_comercial%TYPE -- Id Cotizacion
                              ) IS

        sbProceso                              VARCHAR2(500) := csbPaquete || '.' || 'proCreaCotizacion';
        rcCotizacion                           daldc_cotizacion_comercial.styLDC_COTIZACION_COMERCIAL;
        sbError                                VARCHAR2(4000);
        
        inuProducto                            LDC_PROD_COMERC_SECTOR.PRODUCT_ID%TYPE;
        countP                                 NUMBER;
        isNull                                 varchar2(2000);
        nuSolicitudRed                         number;

        onuErrorCode    number;
        osbErrorMessage varchar2(4000);

    BEGIN

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        if idtSolicitud = 0 then
          nuSolicitudRed := null;
        else
          nuSolicitudRed := idtSolicitud;
        end if;

        rcCotizacion.id_cot_comercial    := seq_ldc_cotizacion_comercial.Nextval;
        rcCotizacion.estado              := csbEstadoRegistrada;
        rcCotizacion.cliente             := inuCliente;
        rcCotizacion.id_direccion        := inuDireccion;
        rcCotizacion.valor_cotizado      := inuValorCotizado;
        rcCotizacion.descuento           := inuDescuento;
        rcCotizacion.observacion         := isbObservacion;
        rcCotizacion.fecha_vigencia      := idtFechaVigencia;
        rcCotizacion.fecha_registro      := SYSDATE;
        rcCotizacion.usuario_registra    := USER;
        rcCotizacion.fecha_modificacion  := SYSDATE;        
        rcCotizacion.usuario_modif       := USER;
        rcCotizacion.COMERCIAL_SECTOR_ID := idtSectorComerci;
        rcCotizacion.NUMERO_FORMULARIO   := idtNumFormulario;
        rcCotizacion.OPERATING_UNIT_ID   := idtUnidadOperati;
        rcCotizacion.PACKAGE_ID          := nuSolicitudRed;

        daldc_cotizacion_comercial.insRecord(ircLDC_COTIZACION_COMERCIAL => rcCotizacion);
        
        LDC_BCCOTIZACIONCOMERCIAL.proObtieneDatosCliente(inuCliente,isNull,isNull,isNull,inuProducto,isNull,isNull);
        
        IF inuProducto IS NOT NULL THEN
          SELECT COUNT(1) INTO countP FROM LDC_PROD_COMERC_SECTOR WHERE PRODUCT_ID = inuProducto;
          IF countP > 0 THEN            
            UPDATE LDC_PROD_COMERC_SECTOR SET COMERCIAL_SECTOR_ID = idtSectorComerci WHERE PRODUCT_ID = inuProducto;
          ELSE
            INSERT INTO LDC_PROD_COMERC_SECTOR (PRODUCT_ID, COMERCIAL_SECTOR_ID) VALUES (inuProducto, idtSectorComerci);
          END IF;
          --commit;
        END IF;

        onuCotizacion := rcCotizacion.id_cot_comercial;

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
    END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proCreaTipoTrabajo
  Descripcion    : Metodo para crear el tipo de trabajo a cotizar
  Autor          : KCienfuegos
  Fecha          : 21-10-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  21-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proCreaTipoTrabajo(inuCotizacion     IN    ldc_cotizacion_comercial.id_cot_comercial%TYPE, -- Id Cotizacion
                               isbAbreviatura    IN    ldc_tipotrab_coti_com.abreviatura%TYPE, -- Abreviatura
                               inuTipoTrabajo    IN    ldc_tipotrab_coti_com.tipo_trabajo  %TYPE, -- Tipo Trabajo
                               inuActividad      IN    ldc_tipotrab_coti_com.actividad%TYPE, -- Actividad
                               inuIva            IN    ldc_tipotrab_coti_com.iva%TYPE, -- IVA
                               isbAplicaDesc     IN    ldc_tipotrab_coti_com.aplica_desc%TYPE -- Aplica Descuento?
                               ) IS

        sbProceso                              VARCHAR2(500) := csbPaquete || '.' || 'proCreaTipoTrabajo';
        rcTipoTrabajo                          daldc_tipotrab_coti_com.styLDC_TIPOTRAB_COTI_COM;
        sbError                                VARCHAR2(4000);

        onuErrorCode    number;
        osbErrorMessage varchar2(4000);

    BEGIN

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        rcTipoTrabajo.id_cot_comercial    := inuCotizacion;
        rcTipoTrabajo.abreviatura         := isbAbreviatura;
        rcTipoTrabajo.tipo_trabajo        := inuTipoTrabajo;
        rcTipoTrabajo.actividad           := inuActividad;
        rcTipoTrabajo.iva                 := nvl(inuIva,0);
        rcTipoTrabajo.aplica_desc         := nvl(isbAplicaDesc,'N');
        rcTipoTrabajo.fecha_registro      := SYSDATE;
        rcTipoTrabajo.usuario_registra    := USER;

        daldc_tipotrab_coti_com.insRecord(ircLDC_TIPOTRAB_COTI_COM => rcTipoTrabajo);

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;   END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proCreaItem
  Descripcion    : Metodo para crear los items cotizados
  Autor          : KCienfuegos
  Fecha          : 21-10-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  21-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proCreaItem(inuCotizacion    IN      ldc_cotizacion_comercial.id_cot_comercial%TYPE, -- Cotizacion
                        inuTipoTrab      IN      ldc_items_cotizacion_com.tipo_trabajo%TYPE, -- Tipo de trabajo
                        inuActividad     IN      ldc_items_cotizacion_com.actividad%TYPE, -- Actividad
                        inuLista         IN      ldc_items_cotizacion_com.id_lista%TYPE, -- Lista
                        inuItem          IN      ldc_items_cotizacion_com.id_item%TYPE, -- Item
                        inuCosto         IN      ldc_items_cotizacion_com.costo_venta%TYPE, -- Costo
                        inuAiu           IN      ldc_items_cotizacion_com.aiu%TYPE, -- AIU
                        inuCantidad      IN      ldc_items_cotizacion_com.cantidad%TYPE, -- Cantidad
                        inuDescuento     IN      ldc_items_cotizacion_com.descuento%TYPE, -- Descuento
                        inuPrecioTotal   IN      ldc_items_cotizacion_com.precio_total%TYPE, -- Precio Total
                        inuIva           IN      ldc_items_cotizacion_com.Iva%TYPE --IVA
                        ) IS

        sbProceso                              VARCHAR2(500) := csbPaquete || '.' || 'proCreaItem';
        rcItem                                 daldc_items_cotizacion_com.styldc_items_cotizacion_com;
        sbError                                VARCHAR2(4000);

        onuErrorCode    number;
        osbErrorMessage varchar2(4000);

    BEGIN

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        rcItem.consecutivo         := seq_ldc_items_cotizacion_com.Nextval;
        rcItem.id_cot_comercial    := inuCotizacion;
        rcItem.tipo_trabajo        := inuTipoTrab;
        rcItem.actividad           := inuActividad;
        rcItem.id_lista            := inuLista;
        rcItem.id_item             := inuItem;
        rcItem.costo_venta         := inuCosto;
        rcItem.aiu                 := inuAiu;
        rcItem.cantidad            := inuCantidad;
        rcItem.descuento           := inuDescuento;
        rcItem.precio_total        := inuPrecioTotal;
        rcItem.iva                 := inuIva;
        rcItem.fecha_registro      := sysdate;
        rcItem.usuario_registra    := user;

        daldc_items_cotizacion_com.insRecord(ircLDC_ITEMS_COTIZACION_COM => rcItem);

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
    END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proModificaCotizacion
  Descripcion    : Metodo para modificar cotizaci?n
  Autor          : KCienfuegos
  Fecha          : 21-10-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  21-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proModificaCotizacion(inuCotizacion     IN    ldc_cotizacion_comercial.id_cot_comercial%TYPE, -- Id Cotizacion
                                  inuDireccion      IN    ldc_cotizacion_comercial.id_direccion%TYPE, -- Direccion
                                  inuValorCotizado  IN    ldc_cotizacion_comercial.valor_cotizado%TYPE, -- Valor Cotizado
                                  inuDescuento      IN    ldc_cotizacion_comercial.descuento%TYPE, -- Descuento
                                  isbObservacion    IN    ldc_cotizacion_comercial.observacion%TYPE, -- Observacion
                                  idtFechaVigencia  IN    ldc_cotizacion_comercial.fecha_vigencia%TYPE, -- Fecha Vigencia
                                  idtSectorComerci  IN     ldc_cotizacion_comercial.COMERCIAL_SECTOR_ID %TYPE, -- SECTOR COMERCIAL
                                  idtNumFormulario  IN     ldc_cotizacion_comercial.NUMERO_FORMULARIO %TYPE, -- numero de formulario
                                  idtUnidadOperati  IN     ldc_cotizacion_comercial.OPERATING_UNIT_ID %TYPE, -- unidad operativa
                                  idtSolicitud      IN     ldc_cotizacion_comercial.PACKAGE_ID %TYPE -- SOLICITUD
                                  ) IS

        sbProceso                              VARCHAR2(500) := csbPaquete || '.' || 'proModificaCotizacion';
        rcCotizacion                           daldc_cotizacion_comercial.styLDC_COTIZACION_COMERCIAL;
        sbError                                VARCHAR2(4000);
        
        inuProducto                            LDC_PROD_COMERC_SECTOR.PRODUCT_ID%TYPE;
        countP                                 NUMBER;
        isNull                                 varchar2(2000);
        nuSolicitudRed                         number;

        onuErrorCode    number;
        osbErrorMessage varchar2(4000);

    BEGIN

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        if idtSolicitud = 0 then
          nuSolicitudRed := null;
        else
          nuSolicitudRed := idtSolicitud;
        end if;

        rcCotizacion           := daldc_cotizacion_comercial.frcGetRecord(inuID_COT_COMERCIAL => inuCotizacion);

        rcCotizacion.id_direccion        := inuDireccion;
        rcCotizacion.valor_cotizado      := nvl(inuValorCotizado,0);
        rcCotizacion.descuento           := inuDescuento;
        rcCotizacion.observacion         := isbObservacion;
        rcCotizacion.fecha_vigencia      := idtFechaVigencia;
        rcCotizacion.fecha_modificacion  := SYSDATE;
        rcCotizacion.usuario_modif       := USER;
        rcCotizacion.COMERCIAL_SECTOR_ID := idtSectorComerci;
        rcCotizacion.NUMERO_FORMULARIO   := idtNumFormulario;
        rcCotizacion.OPERATING_UNIT_ID   := idtUnidadOperati;
        rcCotizacion.PACKAGE_ID          := nuSolicitudRed;

        daldc_cotizacion_comercial.updRecord(ircLDC_COTIZACION_COMERCIAL => rcCotizacion);
        
        LDC_BCCOTIZACIONCOMERCIAL.proObtieneDatosCliente( daldc_cotizacion_comercial.fnuGetCLIENTE(inuCotizacion)
                                                          ,isNull
                                                          ,isNull
                                                          ,isNull
                                                          ,inuProducto
                                                          ,isNull
                                                          ,isNull);
        
        IF inuProducto IS NOT NULL THEN
          SELECT COUNT(1) INTO countP FROM LDC_PROD_COMERC_SECTOR WHERE PRODUCT_ID = inuProducto;
          IF countP > 0 THEN            
            UPDATE LDC_PROD_COMERC_SECTOR SET COMERCIAL_SECTOR_ID = idtSectorComerci WHERE PRODUCT_ID = inuProducto;
          ELSE
            INSERT INTO LDC_PROD_COMERC_SECTOR (PRODUCT_ID, COMERCIAL_SECTOR_ID) VALUES (inuProducto, idtSectorComerci);
          END IF;
          --commit;
        END IF;

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
    END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proModificaTipoTrabajo
  Descripcion    : Metodo para modificar el tipo de trabajo a cotizar
  Autor          : KCienfuegos
  Fecha          : 21-10-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  21-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proModificaTipoTrabajo(inuCotizacion     IN    ldc_cotizacion_comercial.id_cot_comercial%TYPE, -- Id Cotizacion
                                   isbAbreviatura    IN    ldc_tipotrab_coti_com.abreviatura%TYPE, -- Abreviatura
                                   inuTipoTrabajo    IN    ldc_tipotrab_coti_com.tipo_trabajo  %TYPE, -- Tipo Trabajo
                                   inuActividad      IN    ldc_tipotrab_coti_com.actividad%TYPE, -- Actividad
                                   inuIva            IN    ldc_tipotrab_coti_com.iva%TYPE, -- IVA
                                   isbAplicaDesc     IN    ldc_tipotrab_coti_com.aplica_desc%TYPE, -- Aplica Descuento?
                                   isbOperacion      IN    VARCHAR2 --Operacion
                                   ) IS

        sbProceso                              VARCHAR2(500) := csbPaquete || '.' || 'proModificaTipoTrabajo';
        rcTipoTrabajo                          daldc_tipotrab_coti_com.styLDC_TIPOTRAB_COTI_COM;
        sbError                                VARCHAR2(4000);

        onuErrorCode    number;
        osbErrorMessage varchar2(4000);

    BEGIN

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF(NOT daldc_tipotrab_coti_com.fblExist(inuID_COT_COMERCIAL => inuCotizacion,
                                                isbABREVIATURA => isbAbreviatura))THEN
          sbError := 'El tipo de trabajo que intenta procesar no existe';
          pkg_error.setErrorMessage(isbMsgErrr =>sbError);
        END IF;

        rcTipoTrabajo          := daldc_tipotrab_coti_com.frcGetRecord(inuID_COT_COMERCIAL => inuCotizacion,
                                                                       isbABREVIATURA => isbAbreviatura);

        IF (isbOperacion = csbOperacionActualizar)THEN
           rcTipoTrabajo.tipo_trabajo        := inuTipoTrabajo;
           rcTipoTrabajo.actividad           := inuActividad;
           rcTipoTrabajo.iva                 := nvl(inuIva,0);
           rcTipoTrabajo.aplica_desc         := nvl(isbAplicaDesc,'N');

           daldc_tipotrab_coti_com.updRecord(ircLDC_TIPOTRAB_COTI_COM => rcTipoTrabajo);

        ELSIF (isbOperacion = csbOperacionBorrar)THEN

          daldc_tipotrab_coti_com.delRecord(inuID_COT_COMERCIAL => inuCotizacion,
                                            isbABREVIATURA => isbAbreviatura);
        END IF;

        proActualizaUltModif(inuCotizacion);


        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
   END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proModificaItem
  Descripcion    : Metodo para modificar los items cotizados
  Autor          : KCienfuegos
  Fecha          : 21-10-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  21-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proModificaItem(inuConsecutivo   IN      ldc_items_cotizacion_com.consecutivo%TYPE, --Consecutivo
                            inuCotizacion    IN      ldc_cotizacion_comercial.id_cot_comercial%TYPE, -- Id Cotizacion
                            inuTipoTrab      IN      ldc_items_cotizacion_com.tipo_trabajo%TYPE, -- Tipo de trabajo
                            inuActividad     IN      ldc_items_cotizacion_com.actividad%TYPE, -- Actividad
                            inuLista         IN      ldc_items_cotizacion_com.id_lista%TYPE, -- Lista
                            inuItem          IN      ldc_items_cotizacion_com.id_item%TYPE, -- Item
                            inuCosto         IN      ldc_items_cotizacion_com.costo_venta%TYPE, -- Costo
                            inuAiu           IN      ldc_items_cotizacion_com.aiu%TYPE, -- AIU
                            inuCantidad      IN      ldc_items_cotizacion_com.cantidad%TYPE, -- Cantidad
                            inuDescuento     IN      ldc_items_cotizacion_com.descuento%TYPE, -- Descuento
                            inuPrecioTotal   IN      ldc_items_cotizacion_com.precio_total%TYPE, -- Precio Total
                            inuIva           IN      ldc_items_cotizacion_com.Iva%TYPE, --IVA
                            isbOperacion     IN      VARCHAR2 --Operacion
                            ) IS

        sbProceso                              VARCHAR2(500) := csbPaquete || '.' || 'proModificaItem';
        rcItem                                 daldc_items_cotizacion_com.styldc_items_cotizacion_com;
        sbError                                VARCHAR2(4000);

        onuErrorCode    number;
        osbErrorMessage varchar2(4000);

    BEGIN

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF(NOT daldc_items_cotizacion_com.fblExist(inuCONSECUTIVO => inuConsecutivo))THEN
          sbError := 'El item que intenta procesar no existe';
          pkg_error.setErrorMessage(isbMsgErrr =>sbError);
        END IF;

        rcItem                 := daldc_items_cotizacion_com.frcGetRecord(inuCONSECUTIVO => inuConsecutivo);

        IF (isbOperacion = csbOperacionActualizar)THEN

            rcItem.tipo_trabajo        := inuTipoTrab;
            rcItem.actividad           := inuActividad;
            rcItem.id_lista            := inuLista;
            rcItem.id_item             := inuItem;
            rcItem.costo_venta         := inuCosto;
            rcItem.aiu                 := inuAiu;
            rcItem.cantidad            := inuCantidad;
            rcItem.descuento           := inuDescuento;
            rcItem.precio_total        := inuPrecioTotal;
            rcItem.iva                 := inuIva;
            rcItem.fecha_registro      := SYSDATE;
            rcItem.usuario_registra    := USER;

           daldc_items_cotizacion_com.updRecord(ircLDC_ITEMS_COTIZACION_COM => rcItem);

        ELSIF (isbOperacion = csbOperacionBorrar)THEN

          daldc_items_cotizacion_com.delRecord(inuCONSECUTIVO => inuConsecutivo);

        END IF;

        proActualizaUltModif(inuCotizacion);

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proActualizaUltModif
    Descripcion    : Metodo para actualizar fecha y usuario que realiza
                     la ?ltima modificaci?n en la cotizaci?n.
    Autor          : KCienfuegos
    Fecha          : 21-10-2016
    Caso           : CA200-535

    Parametros           Descripcion
    ============         ===================

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    21-10-2016    KCienfuegos.CA200-535         Creacion.
    ******************************************************************/
    PROCEDURE proActualizaUltModif(inuCotizacion    IN      ldc_cotizacion_comercial.id_cot_comercial%TYPE -- Id Cotizacion
                                   ) IS

          sbProceso                              VARCHAR2(500) := csbPaquete || '.' || 'proActualizaUltModif';
          sbError                                VARCHAR2(4000);

        onuErrorCode    number;
        osbErrorMessage varchar2(4000);

    BEGIN

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        daldc_cotizacion_comercial.updUSUARIO_MODIF(inuID_COT_COMERCIAL => inuCotizacion,
                                                    isbUSUARIO_MODIF$ => USER);

        daldc_cotizacion_comercial.updFECHA_MODIFICACION(inuID_COT_COMERCIAL => inuCotizacion,
                                                         idtFECHA_MODIFICACION$ => SYSDATE);

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proMarcaClienteEspecial
    Descripcion    : Metodo para marcar a un cliente especial
    Autor          : KCienfuegos
    Fecha          : 21-10-2016
    Caso           : CA200-535

    Parametros           Descripcion
    ============         ===================

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    21-10-2016    KCienfuegos.CA200-535         Creacion.
    ******************************************************************/
    PROCEDURE proMarcaClienteEspecial(inuCliente   IN      ge_subscriber.subscriber_id%TYPE, -- Id Cliente
                                      isbClienteEspecial IN VARCHAR2 -- Cliente especial?
                                      ) IS

          sbProceso                     VARCHAR2(500) := csbPaquete || '.' || 'proMarcaClienteEspecial';
          sbError                       VARCHAR2(4000);
          rcCliente                     daldc_cliente_especial.styLDC_CLIENTE_ESPECIAL;

        onuErrorCode    number;
        osbErrorMessage varchar2(4000);

    BEGIN

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (daldc_cliente_especial.fblExist(inuID_CLIENTE => inuCliente))THEN
           daldc_cliente_especial.updCLIENTE_ESPECIAL(inuID_CLIENTE => inuCliente,
                                                      isbCLIENTE_ESPECIAL$ => isbClienteEspecial);
        ELSE
           rcCliente.id_cliente        := inuCliente;
           rcCliente.cliente_especial  := isbClienteEspecial;
           rcCliente.fecha_registro    := sysdate;
           rcCliente.fecha_ult_modif   := sysdate;
           rcCliente.usuario_registro  := USER;
           rcCliente.usuario_ult_modif := USER;

           daldc_cliente_especial.insRecord(ircLDC_CLIENTE_ESPECIAL => rcCliente);
        END IF;

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proOrdVerifClienteEsp
    Descripcion    : Metodo para crear orden de verificaci?n de cliente especial
    Autor          : KCienfuegos
    Fecha          : 15-11-2016
    Caso           : CA200-535

    Parametros           Descripcion
    ============         ===================

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    15-11-2016    KCienfuegos.CA200-535         Creacion.
    28/12/2023    Jorge Valiente                OSF-1492: se retira loigca contenida en fblaplicaentregaxcaso(ldc_bccotizacioncomercial.csbEntrega) 
                                                          debio a que retornaba FALSE en PL, Validado con el DBA Cristian Mendez y 
                                                          autorizado por el grupo de estander OSF V8.    
    ******************************************************************/
    PROCEDURE proOrdVerifClienteEsp(inuSolicitud   IN  mo_packages.package_id%TYPE,
                                    inuCliente     IN  ge_subscriber.subscriber_id%TYPE DEFAULT NULL,
                                    inuSolCot      IN  mo_packages.package_id%TYPE DEFAULT NULL)
    IS
        sbError                        VARCHAR2(32000);
        sbProceso                      VARCHAR2(500) := csbPaquete || '.' || 'proOrdVerifClienteEsp';
        nuOrden                        or_order.order_id%TYPE;
        nuOrdenAct                     or_order_activity.order_activity_id%TYPE;
        nuMotivo                       mo_motive.motive_id%TYPE;
        rcMotivoPrincipal              damo_motive.stymo_motive;
        nuIdCotizacionDet              ldc_cotizacion_comercial.id_cot_comercial%TYPE;
        nuSolCotizacion                mo_packages.package_id%TYPE;
        nuIdDireccion                  ab_address.address_id%TYPE;

        onuErrorCode    number;
        osbErrorMessage varchar2(4000);

        CURSOR cuObtSolCotizacion IS
          SELECT pa.package_id_asso
            FROM mo_packages_asso pa
           WHERE pa.package_id = inuSolicitud;

    BEGIN

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkg_traza.trace('Solicitud de Venta ' || inuSolicitud, pkg_traza.cnuNivelTrzDef);

        IF(inuSolCot IS NULL) THEN
          OPEN cuObtSolCotizacion;
          FETCH cuObtSolCotizacion INTO nuSolCotizacion;
          CLOSE cuObtSolCotizacion;

        ELSE
          nuSolCotizacion := inuSolCot;
        END IF;

        pkg_traza.trace('Solicitud de Cotizacion ' || nuSolCotizacion, pkg_traza.cnuNivelTrzDef);

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
    END proOrdVerifClienteEsp;

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proGenOrdCambioCiclo
    Descripcion    : Metodo para crear orden de cambio de ciclo, dependiendo de
                     la causal utilizada para legalizar la orden de verificaci?n
                     de cambio de ciclo. (Utilizado en PLUGIN)
    Autor          : KCienfuegos
    Fecha          : 16-11-2016
    Caso           : CA200-535

    Parametros           Descripcion
    ============         ===================

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    16-11-2016    KCienfuegos.CA200-535         Creacion.
    28/12/2023    Jorge Valiente                OSF-1492: se retira loigca contenida en fblaplicaentregaxcaso(ldc_bccotizacioncomercial.csbEntrega) 
                                                          debio a que retornaba FALSE en PL, Validado con el DBA Cristian Mendez y 
                                                          autorizado por el grupo de estander OSF V8.    
    ******************************************************************/
    PROCEDURE proGenOrdCambioCiclo
    IS
        sbError                        VARCHAR2(32000);
        sbProceso                      VARCHAR2(500) := csbPaquete || '.' || 'proGenOrdCambioCiclo';
        nuOrden                        or_order.order_id%TYPE;
        nuNuevaOrden                   or_order.order_id%TYPE;
        nuNuevaOrdenAct                or_order_activity.order_activity_id%TYPE;
        nuMotivo                       mo_motive.motive_id%TYPE;
        rcMotivoPrincipal              damo_motive.stymo_motive;
        nuIdCausal                     ge_causal.causal_id%TYPE;
        nuCliente                      ge_subscriber.subscriber_id%TYPE;
        nuDireccion                    ab_address.address_id%TYPE;
        nuDepartamento                 ge_geogra_location.geograp_location_id%TYPE;
        nuUnidadOperativa              or_operating_unit.operating_unit_id%TYPE;
        nuActOrigen                    or_order_activity.order_activity_id%TYPE;
        nuCausalValida                 NUMBER := 0;

        onuErrorCode    number;
        osbErrorMessage varchar2(4000);

    BEGIN

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
    END proGenOrdCambioCiclo;

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proRegistraPresion
    Descripcion    : Metodo para registrar la presi?n. (Utilizado en FMIO)
    Autor          : KCienfuegos
    Fecha          : 28-12-2016
    Caso           : CA200-535

    Parametros           Descripcion
    ============         ===================

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    28-12-2016    KCienfuegos.CA200-535         Creacion.
    28/12/2023    Jorge Valiente                OSF-1492: se retira loigca contenida en fblaplicaentregaxcaso(ldc_bccotizacioncomercial.csbEntrega) 
                                                          debio a que retornaba FALSE en PL, Validado con el DBA Cristian Mendez y 
                                                          autorizado por el grupo de estander OSF V8.
    ******************************************************************/
    PROCEDURE proRegistraPresion
    IS
        sbError                   VARCHAR2(32000);
        sbProceso                 VARCHAR2(500) := csbPaquete || '.' || 'proRegistraPresion';
        nuCausal                  or_order.causal_id%type;
        nuOrden                   or_order.order_id%type;
        nuActOrden                or_order_activity.order_activity_id %type;
        nuProducto                or_order_activity.product_id%type;
        nuPresion                 cm_vavafaco.vvfcvalo%type;
        rcDummyRegVar             cm_vavafaco%rowtype;
        nuDummyAvgRegCount        NUMBER;
        sbAtribPresion            VARCHAR2(50) := 'RES_PROD_PRESSURE';

        onuErrorCode    number;
        osbErrorMessage varchar2(4000);

    BEGIN

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
    END proRegistraPresion;

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proEnviaACotizadorOSF
    Descripcion    : Metodo para enviar cotizacion comercial al cotizador de OSF
    Autor          : KCienfuegos
    Fecha          : 01-11-2016
    Caso           : CA200-535

    Parametros           Descripcion
    ============         ===================

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    11/10/2023    Jorge Valiente                OSF-1492 Obtener el AIU registrado en al venta cotizada
    14-12-2022    JpinedC.JIRA-750              Si CC_BSQuotationRegistry.RegQuotationProduct
                                                retorna error se hace raise
    01-11-2016    KCienfuegos.CA200-535         Creacion.
    ******************************************************************/
    PROCEDURE proEnviaACotizadorOSF(inuCotizacion    IN    ldc_cotizacion_comercial.id_cot_comercial%TYPE)
    IS
        nuError                        NUMBER;
        sbError                        VARCHAR2(32000);
        sbProceso                      VARCHAR2(500) := csbPaquete || '.' || 'proEnviaACotizadorOSF';

        rcCotizacion                   daldc_cotizacion_comercial.styLDC_COTIZACION_COMERCIAL;
        nuCotizacionOSF                cc_quotation.quotation_id%TYPE;
        nuSolicitudCotizacion          ldc_cotizacion_comercial.sol_cotizacion%TYPE;
        sbDescCategoria                categori.catedesc%TYPE;
        sbDescSubcategoria             subcateg.sucadesc%TYPE;
        dtFechaSistema                 DATE;
        blActualizarItems              BOOLEAN;
        nuFormaPago                    NUMBER;
        nuTipoProducto                 pr_product.product_type_id%TYPE;
        nuMetodoLiquidacion            NUMBER;
        nuContrato                     suscripc.susccodi%TYPE;
        nuProducto                     pr_product.product_id%TYPE;
        nuTotalItemValue               NUMBER;
        nuTotalTaxValue                NUMBER;
        nuTotalDiscValue               NUMBER;
        sbModuloOriginal               VARCHAR2(200);

       onuErrorCode    number;
       osbErrorMessage varchar2(4000);

        CURSOR cuItemsCotizados IS
          SELECT it.tipo_trabajo,
                 it.actividad,
                 sum(it.precio_total) valor_unitario,
                 sum(round(it.descuento, 2)) descuento,
                 sum(round(it.iva, 2)) iva
            FROM ldc_items_cotizacion_com it, ldc_tipotrab_coti_com t
           WHERE t.tipo_trabajo = it.tipo_trabajo
             AND t.id_cot_comercial = it.id_cot_comercial
             AND it.id_cot_comercial = inuCotizacion
           GROUP BY it.tipo_trabajo, it.actividad;

      --Inicio OSF-1492
      nuAIU_Porcentaje number;
      --Fin OSF-1492

    BEGIN

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        sbModuloOriginal := pkg_session.fsbObtenerModulo;

        ut_session.setModule ('LDC_FCVC', 'LDC_FCVC', 'N');

        IF(NOT daldc_cotizacion_comercial.fblExist(inuID_COT_COMERCIAL => inuCotizacion))THEN
           sbError := 'La cotizacion con codigo '||inuCotizacion||' no existe en la base de datos';
           pkg_error.setErrorMessage(isbMsgErrr =>sbError);
        END IF;

        rcCotizacion  := daldc_cotizacion_comercial.frcGetRecord(inuID_COT_COMERCIAL => inuCotizacion);

        -- Se valida el registro
        CC_BOQuotationRegistry.ValRegistryProcess(Ionusubscriberid => rcCotizacion.cliente,
                                                  Ionuaddressid => rcCotizacion.id_direccion,
                                                  Inupackageid => nuSolicitudCotizacion,
                                                  Onuproductid => nuProducto,
                                                  Osbcategorydesc => sbDescCategoria,
                                                  Osbsubcategdesc => sbDescSubcategoria,
                                                  Odtsystemdate => dtFechaSistema,
                                                  Obocanupdateitems => blActualizarItems,
                                                  Onupaymodality => nuFormaPago,
                                                  Onuproducttype => nuTipoProducto,
                                                  Onuliquidmethod => nuMetodoLiquidacion,
                                                  Onusubscriptionid => nuContrato);

        IF(nuProducto IS NULL)THEN
            CC_BSQuotationRegistry.RegQuotationProduct(Inuaddressid => rcCotizacion.id_direccion,
                                                     Inusubscriberid => rcCotizacion.cliente,
                                                     Inuregisterpersonid => ge_bopersonal.fnuGetPersonId,
                                                     Onuproductid => nuProducto,
                                                     Onusubsriptionid => nuContrato,
                                                     Onuerrorcode => nuError,
                                                     Osberrormessage => sbError);
            IF nuError <> pkConstante.Exito THEN
                pkg_error.setErrorMessage(isbMsgErrr =>sbError);
            END IF;                                                     
        END IF;

        --Se borran los ?tems que est?n en memoria
        cc_bsquotationregistry.clearquotationitemsmem(onuerrorcode => nuError,
                                                      osberrormessage => sbError);

        --Se setean los ?tems
        FOR rcItems IN cuItemsCotizados LOOP
           CC_BSQuotationRegistry.AddQuotationItem(inuquotitemid    => cc_bosequence.fnunextcc_quotation_item,
                                                   inutasktypeid    => rcItems.tipo_trabajo,
                                                   inuitemid        => rcItems.actividad,
                                                   inuitemparent    => NULL,
                                                   inuquantity      => 1,
                                                   inuunitvalue     => round(rcItems.valor_unitario,0),
                                                   inuunitdiscvalue => round(rcItems.descuento,0),
                                                   inuunittaxvalue  => round(rcItems.Iva,0),
                                                   inuitemsequence  => NULL,
                                                   iboisplanned     => NULL,
                                                   onuerrorcode     => nuError,
                                                   osberrormessage  => sbError);

           IF sbError <> '-' THEN
              sbError := 'Error al crear el item ' || rcItems.actividad ||
                          ' en la cotizacion de OSF. ' || sbError;
              pkg_error.setErrorMessage(isbMsgErrr =>sbError);
           ELSE
              sbError := NULL;
           END IF;
        END LOOP;

        BEGIN
          SELECT SUM(round(nvl(c.precio_total,0),0)),
                 SUM(round(nvl(c.descuento,0),0)),
                 SUM(round(nvl(c.iva,0),0))
                 INTO nuTotalItemValue,
                      nuTotalDiscValue,
                      nuTotalTaxValue
            FROM ldc_items_cotizacion_com c
           WHERE c.id_cot_comercial = inuCotizacion;
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;

        --Inicio OSF-1492
        nuAIU_Porcentaje := pkg_bocotizacioncomercial.fnuObtenerAIUCotizacion(inuCotizacion);
        --Fin OSF-1492

        nuMetodoLiquidacion := nvl(nuMetodoLiquidacion,cnuMetodoLiquidacion);

        -- Se registra la solicitud de cotizaci?n
        CC_BSQuotationRegistry.RegQuotationRequest(Inuproductid => nuProducto,
                                                   Inuaddressid => rcCotizacion.id_direccion,
                                                   inusubscriberid => rcCotizacion.cliente,
                                                   inuregisterpersonid => ge_bopersonal.fnuGetPersonId,
                                                   inuliquidmethod => nuMetodoLiquidacion,
                                                   onupackageid => nuSolicitudCotizacion,
                                                   onuerrorcode => nuError,
                                                   osberrormessage => sbError);

        IF(nuError <> GE_BOCONSTANTS.CNUSUCCESS)THEN
           pkg_error.setErrorMessage(isbMsgErrr =>sbError);
        END IF;

        --Se registra la cotizacion
        CC_BSQuotationRegistry.RegisterQuotation(isbdescription     => substr(rcCotizacion.observacion,1,100),
                                                 idtregisterdate     => SYSDATE,
                                                 inusubscriberid     => rcCotizacion.cliente,
                                                 inupackageid        => nuSolicitudCotizacion,
                                                 idtenddate          => rcCotizacion.Fecha_Vigencia,
                                                 inuregisterpersonid => ge_bopersonal.fnuGetPersonId,
                                                 inudownpayment      => NULL,
                                                 isbpaymode          => NULL,
                                                 inudiscountperc     => rcCotizacion.descuento,
                                                 inutotalitemsvalue  => nuTotalItemValue, --PENDIENTE
                                                 inutotaldiscvalue   => nuTotalDiscValue,
                                                 inutotaltaxvalue    => nuTotalTaxValue, --PENDIENTE
                                                 ibonoquotitemcharge => NULL,
                                                 inupaymodality      => NULL,
                                                 inuproducttype      => nuTipoProducto, --PENDIENTE
                                                 inuauipercentage    => 0, --nuAIU_Porcentaje, --OSF-1492 
                                                 inutotalaiuvalue    => 0,
                                                 onuquotationid      => nuCotizacionOSF,
                                                 onuerrorcode        => nuError,
                                                 osberrormessage     => sbError);

        IF sbError <> '-' THEN
            pkg_error.setErrorMessage(isbMsgErrr =>sbError);
        ELSE
            CC_BOQuotationRegistry.AddRegComment(nuCotizacionOSF, rcCotizacion.observacion);
            daldc_cotizacion_comercial.updSOL_COTIZACION(inuID_COT_COMERCIAL => inuCotizacion,
                                                         inuSOL_COTIZACION$ => nuSolicitudCotizacion);

            daldc_cotizacion_comercial.updESTADO(inuID_COT_COMERCIAL => inuCotizacion,
                                                 isbESTADO$ => csbEstadoEnviadaOSF);

            proActualizaUltModif(inuCotizacion);
            sbError := NULL;
        END IF;

        ut_session.setModule (sbModuloOriginal, sbModuloOriginal, 'N');

       pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
    END proEnviaACotizadorOSF;

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proActualizaCotiOSF
    Descripcion    : Metodo para actualizar la cotizacion de OSF
    Autor          : KCienfuegos
    Fecha          : 10-11-2016
    Caso           : CA200-535

    Parametros           Descripcion
    ============         ===================

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    10-11-2016    KCienfuegos.CA200-535         Creacion.
    ******************************************************************/
    PROCEDURE proActualizaCotiOSF(inuCotizacion    IN    ldc_cotizacion_comercial.id_cot_comercial%TYPE,
                                  blBorracondfin   IN    BOOLEAN)
    IS
        nuError                        NUMBER;
        sbError                        VARCHAR2(32000);
        sbProceso                      VARCHAR2(500) := csbPaquete || '.' || 'proActualizaCotiOSF';
        sbModuloOriginal               VARCHAR2(200);
        rcCotizacion                   daldc_cotizacion_comercial.styLDC_COTIZACION_COMERCIAL;
        rcCotizacionOSF                dacc_quotation.stycc_quotation;
        nuCotizacionOSF                cc_quotation.quotation_id%TYPE;
        nuTotalItemValue               NUMBER;
        nuTotalTaxValue                NUMBER;
        nuTotalDiscValue               NUMBER;

       onuErrorCode    number;
       osbErrorMessage varchar2(4000);

        CURSOR cuItemsCotizados IS
          SELECT it.tipo_trabajo,
                 it.actividad,
                 sum(it.precio_total) valor_unitario,
                 sum(round(it.descuento, 2)) descuento,
                 sum(round(it.iva, 2)) iva
            FROM ldc_items_cotizacion_com it, ldc_tipotrab_coti_com t
           WHERE t.tipo_trabajo = it.tipo_trabajo
             AND t.id_cot_comercial = it.id_cot_comercial
             AND it.id_cot_comercial = inuCotizacion
           GROUP BY it.tipo_trabajo, it.actividad;
    BEGIN

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        sbModuloOriginal := pkg_session.fsbObtenerModulo;

        ut_session.setModule ('LDC_FCVC', 'LDC_FCVC', 'N');

        IF(NOT daldc_cotizacion_comercial.fblExist(inuID_COT_COMERCIAL => inuCotizacion))THEN
           sbError := 'La cotizacion con codigo '||inuCotizacion||' no existe en la base de datos';
           pkg_error.setErrorMessage(isbMsgErrr =>sbError);
        END IF;

        -- Se obtiene el registro de la cotizacion detallada
        rcCotizacion  := daldc_cotizacion_comercial.frcGetRecord(inuID_COT_COMERCIAL => inuCotizacion);

        nuCotizacionOSF := ldc_bccotizacioncomercial.fnuCotizacionOSF(inuCotizacion);

        -- Se obtiene el registro de la cotizacion de OSF
        rcCotizacionOSF := dacc_quotation.frcgetrecord(nuCotizacionOSF);

        IF(rcCotizacionOSF.status = csbEstadoAprobada)THEN
           sbError := 'La cotizacion de OSF ya fue aprobada por tanto no puede ser actualizada';
           pkg_error.setErrorMessage(isbMsgErrr =>sbError);
        END IF;

        IF(blBorracondfin)THEN
          --Se borran los items que estan en memoria
          cc_bsquotationregistry.clearquotationitemsmem(onuerrorcode => nuError,
                                                        osberrormessage => sbError);

          --Se setean los items
          FOR rcItems IN cuItemsCotizados LOOP
             CC_BSQuotationRegistry.AddQuotationItem(inuquotitemid    => cc_bosequence.fnunextcc_quotation_item,
                                                     inutasktypeid    => rcItems.tipo_trabajo,
                                                     inuitemid        => rcItems.actividad,
                                                     inuitemparent    => NULL,
                                                     inuquantity      => 1,
                                                     inuunitvalue     => round(rcItems.valor_unitario,0),
                                                     inuunitdiscvalue => round(rcItems.descuento,0),
                                                     inuunittaxvalue  => round(rcItems.Iva,0),
                                                     inuitemsequence  => NULL,
                                                     iboisplanned     => NULL,
                                                     onuerrorcode     => nuError,
                                                     osberrormessage  => sbError);

             IF sbError <> '-' THEN
                sbError := 'Error al crear el item ' || rcItems.actividad ||
                            ' en la cotizacion de OSF. ' || sbError;
                pkg_error.setErrorMessage(isbMsgErrr =>sbError);
             ELSE
                sbError := NULL;
             END IF;

          END LOOP;
         END IF;

        BEGIN
          SELECT SUM(round(nvl(c.precio_total,0),0)),
                 SUM(round(nvl(c.descuento,0),0)),
                 SUM(round(nvl(c.iva,0),0))
                 INTO nuTotalItemValue,
                      nuTotalDiscValue,
                      nuTotalTaxValue
            FROM ldc_items_cotizacion_com c
           WHERE c.id_cot_comercial = inuCotizacion;
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;

        -- Se borran las condiciones de financiacion
        IF(blBorracondfin)THEN
           CC_BOQuotFinanCond.DelQuotFinancCond(Inuquotation => nuCotizacionOSF);
        END IF;

        -- Se actualizan los datos de la cotizaci?n
        CC_BSQuotationRegistry.UpdateQuotation(Inuquotationid => nuCotizacionOSF,
                                               Isbdescription =>  rcCotizacionOSF.description,
                                               Idtenddate => rcCotizacion.fecha_vigencia,
                                               Inuupdatepersonid => ge_bopersonal.fnuGetPersonId,
                                               Inudownpayment => rcCotizacionOSF.initial_payment,
                                               Iboitemsupdated => blBorracondfin,
                                               Isbpaymode =>  rcCotizacionOSF.pay_modality,
                                               Inudiscountperc => rcCotizacion.descuento,
                                               Inutotalitemsvalue => nuTotalItemValue,
                                               Inutotaldiscvalue => nuTotalDiscValue,
                                               Inutotaltaxvalue =>  nuTotalTaxValue,
                                               Ibonoquotitemcharge => FALSE,
                                               Inuauipercentage => rcCotizacionOSF.aui_percentage,
                                               Inutotalaiuvalue => rcCotizacionOSF.total_aiu_value,
                                               Onuerrorcode => nuError,
                                               Osberrormessage => sbError);


        IF(nuError <> GE_BOCONSTANTS.CNUSUCCESS)THEN
           pkg_error.setErrorMessage(isbMsgErrr =>sbError);
        END IF;

        ut_session.setModule (sbModuloOriginal, sbModuloOriginal, 'N');

       pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
    END proActualizaCotiOSF;

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proImprimeCotizacion
    Descripcion    : Metodo para imprimir la cotizaci?n de venta comercial/industrial
    Autor          : KCienfuegos
    Fecha          : 09-11-2016
    Caso           : CA200-535

    Parametros           Descripcion
    ============         ===================

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    09-11-2016    KCienfuegos.CA200-535         Creacion.
    ******************************************************************/
    PROCEDURE proImprimeCotizacion(inuCotizacion     IN    ldc_cotizacion_comercial.id_cot_comercial%TYPE -- Id Cotizacion
                                   ) IS

        sbProceso                              VARCHAR2(500) := csbPaquete || '.' || 'proImprimeCotizacion';
        rcCotizacion                           daldc_cotizacion_comercial.styLDC_COTIZACION_COMERCIAL;
        rcConfexme                             pktbled_confexme.cued_confexme%rowtype;
        clData                                 CLOB;
        nuFormato                              ed_formato.formcodi%type;
        sbError                                VARCHAR2(4000);

       onuErrorCode    number;
       osbErrorMessage varchar2(4000);

    BEGIN

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        rcCotizacion           := daldc_cotizacion_comercial.frcGetRecord(inuID_COT_COMERCIAL => inuCotizacion);

        pkbced_confexme.obtieneregistro(cnuConfexme, rcConfexme);

        pkbodataextractor.instancebaseentity(rcCotizacion.id_cot_comercial, 'LDC_COTIZACION_COMERCIAL', pkconstante.verdadero);

        nuFormato := pkbced_formato.fnugetformcodibyiden(rcconfexme.coempada);

        pkbodataextractor.executerules(nuFormato, clData);

        pkboed_documentmem.set_printdocid(inuCotizacion);

        pkboed_documentmem.set_printdoc(clData);

        pkboed_documentmem.settemplate(rcconfexme.coempadi);

        pkg_traza.trace(sbProceso, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(sbProceso,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
    END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proRegistraDatosCotizacion
  Descripcion    : Metodo para registrar Data Adicional a la cotizacion
  Autor          : Jorge Valiente
  Fecha          : 10-10-2023
  Caso           : OSF-1492

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  PROCEDURE proRegistraAIUCotizacion(InuCotizacion    IN ldc_cotizacion_comercial.id_cot_comercial%TYPE,
                                     InuAIUPorcentaje IN number) IS
    csbMetodo CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                        'proRegistraAIUCotizacion'; --nombre del metodo

    onuErrorCode    number;
    osbErrorMessage varchar2(4000);

  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Registra Cotizacion: ' || InuCotizacion ||
                    ' - Porcentaje AIU:' || InuAIUPorcentaje,
                    pkg_traza.cnuNivelTrzDef);
  
    PKG_BOCOTIZACIONCOMERCIAL.proRegistraAIUCotizacion(InuCotizacion,
                                                       InuAIUPorcentaje);

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
    
  END proRegistraAIUCotizacion;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : proActualizaAIUCotizacion
  Descripcion    : Metodo para Actualizar AIU de la cotizacion
  Autor          : Jorge Valiente
  Fecha          : 10-10-2023
  Caso           : OSF-1492
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  PROCEDURE proActualizaAIUCotizacion(InuCotizacion    IN ldc_cotizacion_comercial.id_cot_comercial%TYPE,
                                      InuAIUPorcentaje IN number) IS
    csbMetodo CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                        'proActualizaAIUCotizacion'; --nombre del metodo
    onuErrorCode    number;
    osbErrorMessage varchar2(4000);

  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
    
    pkg_traza.trace('Actualiza Porcentaje AIU:' || InuAIUPorcentaje ||
                    ' de la Cotizacion: ' || InuCotizacion,
                    pkg_traza.cnuNivelTrzDef);
                      
    PKG_BOCOTIZACIONCOMERCIAL.promodificaaiucotizacion(InuCotizacion,
                                                       InuAIUPorcentaje);

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
    
  END proActualizaAIUCotizacion;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fnuObtenerAIUCotizacion
  Descripcion    : Metodo para Obtener AIU de la cotizacion
  Autor          : Jorge Valiente
  Fecha          : 10-10-2023
  Caso           : OSF-1492
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  FUNCTION fnuObtenerAIUCotizacion(inuCotizacion IN number) RETURN NUMBER IS
  
    csbMetodo CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                        'fnuObtenerAIUCotizacion'; --nombre del metodo
  
    nuAIUCotizacion number;

    onuErrorCode    number;
    osbErrorMessage varchar2(4000);

  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    nuAIUCotizacion := PKG_BOCOTIZACIONCOMERCIAL.fnuObtenerAIUCotizacion(inuCotizacion);
  
    pkg_traza.trace('Obtener Porcentaje AIU:' || nuAIUCotizacion ||
                    ' de la Cotizacion: ' || InuCotizacion,
                    pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    return nuAIUCotizacion;
  
    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
        pkg_traza.trace('sberror: ' || OsbErrorMessage,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
  END;

END LDC_BOCOTIZACIONCOMERCIAL;
/