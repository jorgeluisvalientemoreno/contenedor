create or replace PACKAGE adm_person.LDC_BCCOTIZACIONCOMERCIAL IS

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas
  
  Unidad         : LDC_BCCOTIZACIONCOMERCIAL
  Descripcion    : Paquete que contiene la logica de negocio para las cotizaciones de
                   ventas comerciales e industriales.
  Autor          : KCienfuegos
  Fecha          : 20-10-2016
  Caso           : CA200-535
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  20-10-2016    KCienfuegos.CA200-535        Creacion
  17-01-2018    Stapias.CA200-1640           Se agrega servicio <<fcrItemsVigentesPorUnidad>>
  17-07-2018    Stapias.CA200-1640           Se nodifica el servicio <<fcrItemsPorTipoTrabajo>>
  ******************************************************************/
  csbEntrega CONSTANT VARCHAR2(100) := '200535_4';

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : proObtieneDatosCliente
  Descripcion    : Metodo para obtener datos b?sicos del cliente
  Autor          : KCienfuegos
  Fecha          : 20-10-2016
  Caso           : CA200-535
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  20-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proObtieneDatosCliente(inuCliente         IN ge_subscriber.subscriber_id%TYPE,
                                   onuTipoId          OUT ge_subscriber.ident_type_id%TYPE,
                                   osbIdentificacion  OUT ge_subscriber.identification%TYPE,
                                   osbNombre          OUT VARCHAR2,
                                   onuProducto        OUT pr_product.product_id%TYPE,
                                   onuContrato        OUT suscripc.susccodi%TYPE,
                                   osbClienteEspecial OUT VARCHAR2);

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : proObtieneDatosCotizacion
  Descripcion    : Metodo para obtener datos b?sicos de la cotizacion
  Autor          : KCienfuegos
  Fecha          : 20-10-2016
  Caso           : CA200-535
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  20-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proObtieneDatosCotizacion(inuCotizacion    IN ldc_cotizacion_comercial.id_cot_comercial%TYPE,
                                      osbEstado        OUT ldc_cotizacion_comercial.Estado%TYPE,
                                      onuDireccion     OUT ldc_cotizacion_comercial.id_direccion%TYPE,
                                      odtFechaVigencia OUT ldc_cotizacion_comercial.fecha_vigencia%TYPE,
                                      onuSolicitudCot  OUT ldc_cotizacion_comercial.sol_cotizacion%TYPE,
                                      onuVenta         OUT ldc_cotizacion_comercial.sol_venta%TYPE,
                                      onuProducto      OUT pr_product.product_id%TYPE,
                                      onuContrato      OUT suscripc.susccodi%TYPE,
                                      onuValorCotizado OUT ldc_cotizacion_comercial.Valor_Cotizado%TYPE,
                                      onuDescuento     OUT ldc_cotizacion_comercial.Descuento%TYPE,
                                      osbObservacion   OUT ldc_cotizacion_comercial.observacion%TYPE,
                                      odtFechaRegistro OUT ldc_cotizacion_comercial.fecha_registro%TYPE,
                                      odtFechaModif    OUT ldc_cotizacion_comercial.fecha_modificacion%TYPE,
                                      odtSectorComerci OUT ldc_cotizacion_comercial.COMERCIAL_SECTOR_ID%TYPE,
                                      odtNumFormulario OUT ldc_cotizacion_comercial.NUMERO_FORMULARIO%TYPE,
                                      odtUnidadOperati OUT ldc_cotizacion_comercial.OPERATING_UNIT_ID%TYPE,
                                      odtSolicitud     OUT ldc_cotizacion_comercial.PACKAGE_ID%TYPE);

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fblTieneCondFinanc
  Descripcion    : Metodo para determinar si la cotizacion de OSF tiene las condiciones 
                   de financiacion definidas
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
  FUNCTION fblTieneCondFinanc(inuCotizacion IN ldc_cotizacion_comercial.id_cot_comercial%TYPE)
    RETURN BOOLEAN;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fnuCotizacionOSF
  Descripcion    : Funcion para obtener numero de cotizacion de OSF
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
  FUNCTION fnuCotizacionOSF(inuCotizacion IN ldc_cotizacion_comercial.id_cot_comercial%TYPE)
    RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fcrTiposTrabajo
  Descripcion    : Metodo para obtener los tipos de trabajo de la cotizacion
  Autor          : KCienfuegos
  Fecha          : 20-10-2016
  Caso           : CA200-535
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  20-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  FUNCTION fcrTiposTrabajo(inuCotizacion IN ldc_cotizacion_comercial.id_cot_comercial%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fcrItemsPorTipoTrabajo
  Descripcion    : Metodo para obtener los items cotizados por tipo de trabajo
  Autor          : KCienfuegos
  Fecha          : 20-10-2016
  Caso           : CA200-535
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  20-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  FUNCTION fcrItemsPorTipoTrabajo(inuCotizacion  IN ldc_cotizacion_comercial.id_cot_comercial%TYPE,
                                  isbTipoTrabAbr IN ldc_tipotrab_coti_com.abreviatura%TYPE)
  
   RETURN PKCONSTANTE.TYREFCURSOR;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fcrActividadesPorTipoTrabajo
  Descripcion    : Metodo para obtener las actividades por tipo de trabajo
  Autor          : KCienfuegos
  Fecha          : 20-10-2016
  Caso           : CA200-535
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  20-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  FUNCTION fcrActividadesPorTipoTrabajo RETURN PKCONSTANTE.TYREFCURSOR;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fcrItemsVigentes
  Descripcion    : Metodo para obtener los items de las listas de costos vigentes
  Autor          : KCienfuegos
  Fecha          : 27-10-2016
  Caso           : CA200-535
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  27-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  FUNCTION fcrItemsVigentes(inuLocalidad ab_address.geograp_location_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fcrItemsVigentesPorUnidad
  Descripcion    : Metodo para obtener los items de las listas de costos vigentes
                   por unidad de trabajo.
  Autor          : Sebastian Tapias
  Fecha          : 17/01/2018
  Caso           : CA200-1640
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  17/01/2018    Stapias.CA200-1640         Creacion.
  ******************************************************************/
  FUNCTION fcrItemsVigentesPorUnidad(inuOperUnit ab_address.geograp_location_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR;

END LDC_BCCOTIZACIONCOMERCIAL;
/

create or replace PACKAGE BODY adm_person.LDC_BCCOTIZACIONCOMERCIAL IS

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas
  
  Unidad         : LDC_BCCOTIZACIONCOMERCIAL
  Descripcion    : Paquete que contiene la logica de negocio para las cotizaciones de
                   ventas comerciales e industriales.
  Autor          : KCienfuegos
  Fecha          : 20-10-2016
  Caso           : CA200-535
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  20-10-2016    KCienfuegos.CA200-535        Creacion
  17-01-2018    Stapias.CA200-1640           Se agrega servicio <<fcrItemsVigentesPorUnidad>>
  17-07-2018    Stapias.CA200-1640           Se nodifica el servicio <<fcrItemsPorTipoTrabajo>>
  ******************************************************************/

  --Constantes
  csbPaquete                VARCHAR2(60) := 'ldc_bccotizacioncomercial';
  cnuCodigoError            NUMBER := 2741;
  cnuClasificacionActividad NUMBER := DALD_PARAMETER.fnuGetNumeric_Value('COD_CLA_ITEM_ACT',
                                                                         0);

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : proObtieneDatosCliente
  Descripcion    : Metodo para obtener datos b?sicos del cliente
  Autor          : KCienfuegos
  Fecha          : 20-10-2016
  Caso           : CA200-535
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  20-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proObtieneDatosCliente(inuCliente         IN ge_subscriber.subscriber_id%TYPE,
                                   onuTipoId          OUT ge_subscriber.ident_type_id%TYPE,
                                   osbIdentificacion  OUT ge_subscriber.identification%TYPE,
                                   osbNombre          OUT VARCHAR2,
                                   onuProducto        OUT pr_product.product_id%TYPE,
                                   onuContrato        OUT suscripc.susccodi%TYPE,
                                   osbClienteEspecial OUT VARCHAR2) IS
  
    sbProceso VARCHAR2(500) := 'proObtieneDatosCliente';
    sbError   VARCHAR2(4000);
  
  BEGIN
  
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso, 10);
  
    BEGIN
      SELECT s.ident_type_id,
             s.identification,
             s.subscriber_name || ' ' || s.subs_last_name
        INTO onuTipoId, osbIdentificacion, osbNombre
        FROM ge_subscriber s
       WHERE s.subscriber_id = inuCliente;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        sbError := 'No se encuentra el cliente con codigo ' || inuCliente;
        RAISE EX.CONTROLLED_ERROR;
    END;
  
    BEGIN
      SELECT sesunuse, sesususc
        INTO onuProducto, onuContrato
        FROM (SELECT sesunuse, sesususc
                FROM suscripc s, servsusc p
               WHERE s.suscclie = inuCliente
                 AND s.susccodi = p.sesususc
                 AND p.sesuserv =
                     dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS', 0)
               ORDER BY sesunuse DESC)
       WHERE rownum <= 1;
    EXCEPTION
      WHEN OTHERS THEN
        onuProducto := NULL;
        onuContrato := NULL;
    END;
  
    BEGIN
      SELECT ce.cliente_especial
        INTO osbClienteEspecial
        FROM ldc_cliente_especial ce
       WHERE ce.id_cliente = inuCliente;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        osbClienteEspecial := 'N';
    END;
  
    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso, 10);
  
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || sbError,
                     10);
      IF (sbError IS NOT NULL) THEN
        ERRORS.SETERROR(inuapperrorcode => cnuCodigoError,
                        isbargument     => sbError);
      END IF;
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ut_trace.trace('TERMINO CON ERROR NO CONTROLADO ' || csbPaquete || '.' ||
                     sbProceso || SQLERRM,
                     10);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : proObtieneDatosCotizacion
  Descripcion    : Metodo para obtener datos b?sicos de la cotizacion
  Autor          : KCienfuegos
  Fecha          : 20-10-2016
  Caso           : CA200-535
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  20-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proObtieneDatosCotizacion(inuCotizacion    IN ldc_cotizacion_comercial.id_cot_comercial%TYPE,
                                      osbEstado        OUT ldc_cotizacion_comercial.Estado%TYPE,
                                      onuDireccion     OUT ldc_cotizacion_comercial.id_direccion%TYPE,
                                      odtFechaVigencia OUT ldc_cotizacion_comercial.fecha_vigencia%TYPE,
                                      onuSolicitudCot  OUT ldc_cotizacion_comercial.sol_cotizacion%TYPE,
                                      onuVenta         OUT ldc_cotizacion_comercial.sol_venta%TYPE,
                                      onuProducto      OUT pr_product.product_id%TYPE,
                                      onuContrato      OUT suscripc.susccodi%TYPE,
                                      onuValorCotizado OUT ldc_cotizacion_comercial.Valor_Cotizado%TYPE,
                                      onuDescuento     OUT ldc_cotizacion_comercial.Descuento%TYPE,
                                      osbObservacion   OUT ldc_cotizacion_comercial.observacion%TYPE,
                                      odtFechaRegistro OUT ldc_cotizacion_comercial.fecha_registro%TYPE,
                                      odtFechaModif    OUT ldc_cotizacion_comercial.fecha_modificacion%TYPE,
                                      odtSectorComerci OUT ldc_cotizacion_comercial.COMERCIAL_SECTOR_ID%TYPE,
                                      odtNumFormulario OUT ldc_cotizacion_comercial.NUMERO_FORMULARIO%TYPE,
                                      odtUnidadOperati OUT ldc_cotizacion_comercial.OPERATING_UNIT_ID%TYPE,
                                      odtSolicitud     OUT ldc_cotizacion_comercial.PACKAGE_ID%TYPE) IS
  
    sbProceso VARCHAR2(500) := 'proObtieneDatosCotizacion';
    sbError   VARCHAR2(4000);
  
  BEGIN
  
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso, 10);
  
    BEGIN
      SELECT c.estado,
             c.id_direccion,
             c.fecha_vigencia,
             c.sol_cotizacion,
             c.sol_venta,
             c.valor_cotizado,
             c.observacion,
             c.descuento,
             c.fecha_registro,
             c.fecha_modificacion,
             c.COMERCIAL_SECTOR_ID,
             c.NUMERO_FORMULARIO,
             c.OPERATING_UNIT_ID,
             c.PACKAGE_ID
        INTO osbEstado,
             onuDireccion,
             odtFechaVigencia,
             onuSolicitudCot,
             onuVenta,
             onuValorCotizado,
             osbObservacion,
             onuDescuento,
             odtFechaRegistro,
             odtFechaModif,
             odtSectorComerci,
             odtNumFormulario,
             odtUnidadOperati,
             odtSolicitud
        FROM ldc_cotizacion_comercial c
       WHERE c.id_cot_comercial = inuCotizacion;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        sbError := 'No se encuentra la cotizacion con codigo ' ||
                   inuCotizacion;
        RAISE EX.CONTROLLED_ERROR;
    END;
  
    IF (onuSolicitudCot IS NOT NULL) THEN
      BEGIN
        SELECT subscription_id, product_id
          INTO onuContrato, onuProducto
          FROM mo_motive m
         WHERE m.package_id = onuSolicitudCot
           AND m.motive_id =
               (SELECT MIN(motive_id)
                  FROM mo_motive mm
                 WHERE mm.package_id = onuSolicitudCot);
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
    END IF;
  
    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso, 10);
  
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || sbError,
                     10);
      IF (sbError IS NOT NULL) THEN
        ERRORS.SETERROR(inuapperrorcode => cnuCodigoError,
                        isbargument     => sbError);
      END IF;
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ut_trace.trace('TERMINO CON ERROR NO CONTROLADO ' || csbPaquete || '.' ||
                     sbProceso || SQLERRM,
                     10);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fblTieneCondFinanc
  Descripcion    : Metodo para determinar si la cotizacion de OSF tiene las condiciones 
                   de financiacion definidas
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
  FUNCTION fblTieneCondFinanc(inuCotizacion IN ldc_cotizacion_comercial.id_cot_comercial%TYPE)
    RETURN BOOLEAN IS
  
    sbProceso       VARCHAR2(500) := 'fblTieneCondFinanc';
    sbError         VARCHAR2(4000);
    nuCotizacionOSF cc_quotation.quotation_id%TYPE;
  
  BEGIN
  
    nuCotizacionOSF := ldc_bccotizacioncomercial.fnuCotizacionOSF(inuCotizacion);
  
    RETURN dacc_quot_financ_cond.fblexist(inuQuotation_Id => nuCotizacionOSF);
  
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || sbError,
                     10);
      IF (sbError IS NOT NULL) THEN
        ERRORS.SETERROR(inuapperrorcode => cnuCodigoError,
                        isbargument     => sbError);
      END IF;
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ut_trace.trace('TERMINO CON ERROR NO CONTROLADO ' || csbPaquete || '.' ||
                     sbProceso || SQLERRM,
                     10);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fnuCotizacionOSF
  Descripcion    : Funcion para obtener numero de cotizacion de OSF
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
  FUNCTION fnuCotizacionOSF(inuCotizacion IN ldc_cotizacion_comercial.id_cot_comercial%TYPE)
    RETURN NUMBER IS
  
    sbProceso       VARCHAR2(500) := 'fnuCotizacionOSF';
    sbError         VARCHAR2(4000);
    nuCotizacionOSF cc_quotation.quotation_id%TYPE;
    rcCotizacion    daldc_cotizacion_comercial.styLDC_COTIZACION_COMERCIAL;
  
  BEGIN
  
    IF (NOT
        daldc_cotizacion_comercial.fblExist(inuID_COT_COMERCIAL => inuCotizacion)) THEN
      sbError := 'La cotizacion con codigo ' || inuCotizacion ||
                 ' no existe en la base de datos';
      RAISE EX.CONTROLLED_ERROR;
    END IF;
  
    rcCotizacion := daldc_cotizacion_comercial.frcGetRecord(inuID_COT_COMERCIAL => inuCotizacion);
  
    BEGIN
      SELECT c.Quotation_Id
        INTO nuCotizacionOSF
        FROM cc_quotation c
       WHERE c.package_id = rcCotizacion.sol_cotizacion;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
      WHEN OTHERS THEN
        sbError := SQLERRM;
        RAISE ex.Controlled_Error;
    END;
  
    RETURN nuCotizacionOSF;
  
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || sbError,
                     10);
      IF (sbError IS NOT NULL) THEN
        ERRORS.SETERROR(inuapperrorcode => cnuCodigoError,
                        isbargument     => sbError);
      END IF;
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ut_trace.trace('TERMINO CON ERROR NO CONTROLADO ' || csbPaquete || '.' ||
                     sbProceso || SQLERRM,
                     10);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fcrTiposTrabajo
  Descripcion    : Metodo para obtener los tipos de trabajo de la cotizacion
  Autor          : KCienfuegos
  Fecha          : 20-10-2016
  Caso           : CA200-535
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  20-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  FUNCTION fcrTiposTrabajo(inuCotizacion IN ldc_cotizacion_comercial.id_cot_comercial%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR IS
  
    sbProceso      VARCHAR2(500) := 'fcrTiposTrabajo';
    sbError        VARCHAR2(4000);
    crTiposTrabajo PKCONSTANTE.TYREFCURSOR;
  
  BEGIN
  
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso, 10);
  
    OPEN crTiposTrabajo FOR
      SELECT t.id_cot_comercial id_cotizacion,
             t.tipo_trabajo,
             t.abreviatura,
             t.actividad,
             t.iva,
             t.aplica_desc      aplica_descuento
        FROM ldc_tipotrab_coti_com t
       WHERE t.id_cot_comercial = inuCotizacion;
  
    RETURN crTiposTrabajo;
  
    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso, 10);
  
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || sbError,
                     10);
      IF (sbError IS NOT NULL) THEN
        ERRORS.SETERROR(inuapperrorcode => cnuCodigoError,
                        isbargument     => sbError);
      END IF;
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ut_trace.trace('TERMINO CON ERROR NO CONTROLADO ' || csbPaquete || '.' ||
                     sbProceso || SQLERRM,
                     10);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fcrItemsPorTipoTrabajo
  Descripcion    : Metodo para obtener los items cotizados por tipo de trabajo
  Autor          : KCienfuegos
  Fecha          : 20-10-2016
  Caso           : CA200-535
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  20-10-2016    KCienfuegos.CA200-535         Creacion.
  17-07-2018    STapias.CA200-1640            Se agrega descripcion adicinal al item
                                              Para diferencias C - Contratista y G - Generico
  ******************************************************************/
  FUNCTION fcrItemsPorTipoTrabajo(inuCotizacion  IN ldc_cotizacion_comercial.id_cot_comercial%TYPE,
                                  isbTipoTrabAbr IN ldc_tipotrab_coti_com.abreviatura%TYPE)
  
   RETURN PKCONSTANTE.TYREFCURSOR IS
  
    sbProceso          VARCHAR2(500) := 'fcrItemsPorTipoTrabajo';
    sbError            VARCHAR2(4000);
    crItemsTipoTrabajo PKCONSTANTE.TYREFCURSOR;
    nuDescuento        NUMBER;
  
  BEGIN
  
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso, 10);
  
    nuDescuento := daldc_cotizacion_comercial.fnuGetDESCUENTO(inuCotizacion,
                                                              0);
  
    OPEN crItemsTipoTrabajo FOR
      SELECT it.consecutivo,
             it.id_cot_comercial id_cotizacion,
             it.tipo_trabajo,
             it.actividad,
             it.id_lista,
             it.id_item,
             i.description || ' - ' || nvl(ita.class_item, 'N/A') descripcion, --200-1640
             it.costo_venta,
             it.aiu,
             it.cantidad,
             it.descuento,
             it.precio_total,
             it.iva valor_iva,
             t.iva,
             decode(t.aplica_desc, 'S', nuDescuento, 0) porc_descuento,
             t.abreviatura
        FROM ldc_items_cotizacion_com it,
             ldc_itemscoticomer_adic  ita, --200-1640
             ge_items                 i,
             ldc_tipotrab_coti_com    t
       WHERE it.consecutivo = ita.consecutivo(+) --200-1640
         AND it.id_item = i.items_id
         AND t.tipo_trabajo = it.tipo_trabajo
         AND t.id_cot_comercial = it.id_cot_comercial
         AND t.abreviatura = isbTipoTrabAbr
         AND it.id_cot_comercial = inuCotizacion
       ORDER BY it.id_item ASC;
  
    RETURN crItemsTipoTrabajo;
  
    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso, 10);
  
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || sbError,
                     10);
      IF (sbError IS NOT NULL) THEN
        ERRORS.SETERROR(inuapperrorcode => cnuCodigoError,
                        isbargument     => sbError);
      END IF;
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ut_trace.trace('TERMINO CON ERROR NO CONTROLADO ' || csbPaquete || '.' ||
                     sbProceso || SQLERRM,
                     10);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fcrActividadesPorTipoTrabajo
  Descripcion    : Metodo para obtener las actividades por tipo de trabajo
  Autor          : KCienfuegos
  Fecha          : 20-10-2016
  Caso           : CA200-535
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  20-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  FUNCTION fcrActividadesPorTipoTrabajo RETURN PKCONSTANTE.TYREFCURSOR IS
  
    sbProceso     VARCHAR2(500) := 'fcrActividadesPorTipoTrabajo';
    sbError       VARCHAR2(4000);
    crActividades PKCONSTANTE.TYREFCURSOR;
  
  BEGIN
  
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso, 10);
  
    OPEN crActividades FOR
      SELECT t.task_type_id     id_tipo_trabajo,
             tt.description     tipo_trabajo,
             i.items_id         id_actividad,
             i.description      actividad,
             i.discount_concept
        FROM or_task_types_items t, ge_items i, or_task_type tt
       WHERE t.items_id = i.items_id
         AND t.task_type_id = tt.task_type_id
         AND i.item_classif_id = cnuClasificacionActividad
         AND t.task_type_id IN
             (SELECT column_value
                FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_INT_COM_IND'),
                                                        '|')))
         AND i.items_id IN
             (SELECT column_value
                FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('ACT_INT_COM_IND'),
                                                        '|')))
      UNION
      SELECT t.task_type_id     id_tipo_trabajo,
             tt.description     tipo_trabajo,
             i.items_id         id_actividad,
             i.description      actividad,
             i.discount_concept
        FROM or_task_types_items t, ge_items i, or_task_type tt
       WHERE t.items_id = i.items_id
         AND t.task_type_id = tt.task_type_id
         AND i.item_classif_id = cnuClasificacionActividad
         AND t.task_type_id IN
             (SELECT column_value
                FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_CXC_COM_IND'),
                                                        '|')))
         AND i.items_id IN
             (SELECT column_value
                FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('ACT_CXC_COM_IND'),
                                                        '|')))
      UNION
      SELECT t.task_type_id     id_tipo_trabajo,
             tt.description     tipo_trabajo,
             i.items_id         id_actividad,
             i.description      actividad,
             i.discount_concept
        FROM or_task_types_items t, ge_items i, or_task_type tt
       WHERE t.items_id = i.items_id
         AND t.task_type_id = tt.task_type_id
         AND i.item_classif_id = cnuClasificacionActividad
         AND t.task_type_id IN
             (SELECT column_value
                FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_INSP_COM_IND'),
                                                        '|')))
         AND i.items_id IN
             (SELECT column_value
                FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('ACT_INSP_COM_IND'),
                                                        '|')));
  
    RETURN crActividades;
  
    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso, 10);
  
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || sbError,
                     10);
      IF (sbError IS NOT NULL) THEN
        ERRORS.SETERROR(inuapperrorcode => cnuCodigoError,
                        isbargument     => sbError);
      END IF;
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ut_trace.trace('TERMINO CON ERROR NO CONTROLADO ' || csbPaquete || '.' ||
                     sbProceso || SQLERRM,
                     10);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fcrItemsVigentes
  Descripcion    : Metodo para obtener los items de las listas de costos vigentes
  Autor          : KCienfuegos
  Fecha          : 27-10-2016
  Caso           : CA200-535
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  27-10-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  FUNCTION fcrItemsVigentes(inuLocalidad ab_address.geograp_location_id%TYPE)
  
   RETURN PKCONSTANTE.TYREFCURSOR IS
  
    sbProceso VARCHAR2(500) := 'fcrItemsVigentes';
    sbError   VARCHAR2(4000);
    crItems   PKCONSTANTE.TYREFCURSOR;
  
  BEGIN
  
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso, 10);
  
    IF (inuLocalidad != -1) THEN
      OPEN crItems FOR
        SELECT i.items_id             id_item,
               ii.description         nombre_item,
               i.price                costo_venta,
               l.list_unitary_cost_id id_lista,
               l.description          nombre_lista
          FROM ge_unit_cost_ite_lis i, ge_items ii, ge_list_unitary_cost l
         WHERE i.list_unitary_cost_id = l.list_unitary_cost_id
           AND i.items_id = ii.items_id
           AND ii.item_classif_id IN
               (SELECT column_value
                  FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('CLASIF_ITEMS_COT_COM'),
                                                          '|')))
           AND l.geograp_location_id = inuLocalidad
           AND TRUNC(SYSDATE) BETWEEN TRUNC(l.validity_start_date) AND
               TRUNC(l.validity_final_date)
         ORDER BY i.items_id;
    
    ELSE
      OPEN crItems FOR
        SELECT 1 id_item,
               'X' nombre_item,
               1 costo_venta,
               1 id_lista,
               'Y' nombre_lista
          FROM dual
         WHERE 1 = 2;
    
    END IF;
  
    RETURN crItems;
  
    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso, 10);
  
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || sbError,
                     10);
      IF (sbError IS NOT NULL) THEN
        ERRORS.SETERROR(inuapperrorcode => cnuCodigoError,
                        isbargument     => sbError);
      END IF;
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ut_trace.trace('TERMINO CON ERROR NO CONTROLADO ' || csbPaquete || '.' ||
                     sbProceso || SQLERRM,
                     10);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END;
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fcrItemsVigentesPorUnidad
  Descripcion    : Metodo para obtener los items de las listas de costos vigentes
                   por unidad de trabajo.
  Autor          : Sebastian Tapias
  Fecha          : 17/01/2018
  Caso           : CA200-1640
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  17/01/2018    Stapias.CA200-1640         Creacion.
  ******************************************************************/
  FUNCTION fcrItemsVigentesPorUnidad(inuOperUnit ab_address.geograp_location_id%TYPE)
  
   RETURN PKCONSTANTE.TYREFCURSOR IS
  
    sbProceso VARCHAR2(500) := 'fcrItemsVigentes';
    sbError   VARCHAR2(4000);
    crItems   PKCONSTANTE.TYREFCURSOR;
  
  BEGIN
  
    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso, 10);
  
    IF (inuOperUnit != -1) THEN
      OPEN crItems FOR
        SELECT i.items_id id_item,
               ii.description || ' - C' nombre_item,
               i.price costo_venta,
               l.list_unitary_cost_id id_lista,
               l.description nombre_lista
          FROM ge_unit_cost_ite_lis i, ge_items ii, ge_list_unitary_cost l
         WHERE i.list_unitary_cost_id = l.list_unitary_cost_id
           AND i.items_id = ii.items_id
           AND ii.item_classif_id IN
               (SELECT column_value
                  FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('CLASIF_ITEMS_COT_COM'),
                                                          '|')))
           AND l.operating_unit_id = inuOperUnit
           AND TRUNC(SYSDATE) BETWEEN TRUNC(l.validity_start_date) AND
               TRUNC(l.validity_final_date)
        UNION
        SELECT i.items_id id_item,
               ii.description || ' - G' nombre_item,
               i.price costo_venta,
               l.list_unitary_cost_id id_lista,
               l.description nombre_lista
          FROM ge_unit_cost_ite_lis i, ge_items ii, ge_list_unitary_cost l
         WHERE i.list_unitary_cost_id = l.list_unitary_cost_id
           AND i.items_id = ii.items_id
           AND ii.item_classif_id IN
               (SELECT column_value
                  FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('CLASIF_ITEMS_COT_COM'),
                                                          '|')))
           AND l.operating_unit_id IS NULL
           AND l.contractor_id IS NULL
           AND l.contract_id IS NULL
           AND l.geograp_location_id IS NULL
           AND l.description LIKE '%MATERIALES%'
           AND TRUNC(SYSDATE) BETWEEN TRUNC(l.validity_start_date) AND
               TRUNC(l.validity_final_date)
        UNION
        SELECT i.items_id id_item,
               ii.description || ' - G' nombre_item,
               i.price costo_venta,
               l.list_unitary_cost_id id_lista,
               l.description nombre_lista
          FROM ge_unit_cost_ite_lis i, ge_items ii, ge_list_unitary_cost l
         WHERE i.list_unitary_cost_id = l.list_unitary_cost_id
           AND i.items_id = ii.items_id
           AND i.items_id IN
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
         ORDER BY id_item;
    
    ELSE
      OPEN crItems FOR
        SELECT 1 id_item,
               'X' nombre_item,
               1 costo_venta,
               1 id_lista,
               'Y' nombre_lista
          FROM dual
         WHERE 1 = 2;
    
    END IF;
  
    RETURN crItems;
  
    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso, 10);
  
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' ||
                     sbProceso || sbError,
                     10);
      IF (sbError IS NOT NULL) THEN
        ERRORS.SETERROR(inuapperrorcode => cnuCodigoError,
                        isbargument     => sbError);
      END IF;
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ut_trace.trace('TERMINO CON ERROR NO CONTROLADO ' || csbPaquete || '.' ||
                     sbProceso || SQLERRM,
                     10);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END;

END LDC_BCCOTIZACIONCOMERCIAL;
/
PROMPT Otorgando permisos de ejecucion a LDC_BCCOTIZACIONCOMERCIAL
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BCCOTIZACIONCOMERCIAL', 'ADM_PERSON');
END;
/