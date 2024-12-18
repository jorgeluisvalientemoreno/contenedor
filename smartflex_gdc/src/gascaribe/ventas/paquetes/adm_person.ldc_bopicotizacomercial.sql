CREATE OR REPLACE PACKAGE adm_person.LDC_BOPICOTIZACOMERCIAL IS

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : LDC_BOPICOTIZACOMERCIAL
  Descripcion    : Paquete que contiene la logica para obtener los datos
                   de las cotizaciones comerciales en el pi
  Autor          : KCienfuegos
  Fecha          : 15-11-2016
  Caso           : CA200-535

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  15-11-2016    KCienfuegos.CA200-535        Creacion
  17-07-2017    Stapias.CA200-1640           Se modifican los servicios <<proObtieneCotizacion>>
                                                                        <<proObtCotizacionxCliente>>
                                                                        <<proObtCotizacionxContrato>>
  23/07/2024    PAcosta                      OSF-2952: Cambio de esquema ADM_PERSON                                                                          
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proObtieneCotizacion
  Descripcion    : Servicio de consulta para obtener los datos de una cotizacion
                   comercial/industrial
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
  PROCEDURE proObtieneCotizacion(inuCotizacion IN ldc_cotizacion_comercial.id_cot_comercial%TYPE,
                                 ocuDatos      OUT CONSTANTS.TYREFCURSOR);

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proObtCotizacionxCliente
  Descripcion    : Servicio de consulta para obtener las cotizaciones
                   comerciales/industriales de un cliente
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
  PROCEDURE proObtCotizacionxCliente(inuCliente IN ge_subscriber.subscriber_id%TYPE,
                                     ocuDatos   OUT CONSTANTS.TYREFCURSOR);

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proObtCotizacionxCliente
  Descripcion    : Servicio de consulta para obtener las cotizaciones
                   comerciales/industriales de un contrato
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
  PROCEDURE proObtCotizacionxContrato(inuContrato IN suscripc.susccodi%TYPE,
                                      ocuDatos    OUT CONSTANTS.TYREFCURSOR);

END LDC_BOPICOTIZACOMERCIAL;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BOPICOTIZACOMERCIAL IS

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : LDC_BOPICOTIZACOMERCIAL
  Descripcion    : Paquete que contiene la logica para obtener los datos
                   de las cotizaciones comerciales en el pi
  Autor          : KCienfuegos
  Fecha          : 15-11-2016
  Caso           : CA200-535

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  15-11-2016    KCienfuegos.CA200-535        Creacion
  17-07-2017    Stapias.CA200-1640           Se modifican los servicios <<proObtieneCotizacion>>
                                                                        <<proObtCotizacionxCliente>>
                                                                        <<proObtCotizacionxContrato>>
  ******************************************************************/

  csbPaquete     VARCHAR2(60) := 'ldc_bopicotizacomercial';
  cnuCodigoError NUMBER := 2741;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proObtieneCotizacion
  Descripcion    : Servicio de consulta para obtener los datos de una cotizacion
                   comercial/industrial
  Autor          : KCienfuegos
  Fecha          : 15-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  15-11-2016    KCienfuegos.CA200-535         Creacion.
  17-07-2018    Stapias.CA200-1640            Se agrega al Select campo Unidad_Operativa
                                              obtenido de la tabla de datos adicionales
  ******************************************************************/
  PROCEDURE proObtieneCotizacion(inuCotizacion IN ldc_cotizacion_comercial.id_cot_comercial%TYPE,
                                 ocuDatos      OUT CONSTANTS.TYREFCURSOR) IS

    sbProceso   VARCHAR2(500) := 'proObtieneCotizacion';
    sbError     VARCHAR2(4000);
    sbCondicion VARCHAR2(4000);
    sbSentencia VARCHAR2(4000);
    sbCampos    VARCHAR2(4000);

  BEGIN

    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso, 10);

    sbCampos := 'c.id_cot_comercial id,
                 decode(c.estado, ''RE'', ''Registrada'', ''E'', ''Enviada a OSF'', ''A'', ''Aprobada'') estado,
                 c.sol_cotizacion solicitud_cotizacion,
                 c.sol_venta solicitud_venta,
                 c.observacion,
                 c.cliente parent_id,
                 c.id_direccion  || '' - '' || d.address_parsed direccion,
                 ''$''||to_char(nvl(c.valor_cotizado,0),''FM999,999,990.00'') valor_cotizado,
                 c.descuento,
                 c.fecha_registro fecha_registro,
                 c.fecha_vigencia fecha_vigencia,
                 c.fecha_modificacion fecha_modificacion,
                 c.usuario_registra usuario_registra,
                 c.usuario_modif usuario_modifica,
                 TO_CHAR((SELECT o.operating_unit_id || '' - '' || o.name FROM or_operating_unit o WHERE o.operating_unit_id = a.unidad_operativa)) unidad_operativa';

    -- Aplicar los filtros
    sbCondicion := 'c.id_direccion = d.address_id (+)
                      AND c.id_cot_comercial = nvl(:inuCotizacion,-1)
                      AND c.id_cot_comercial = a.id_cot_comercial(+)';

    -- Construir la sentencia
    sbSentencia := 'SELECT ' || sbCampos || '
                      FROM   ldc_cotizacion_comercial c, ldc_coticomercial_adic a,
                      ab_address d
                      WHERE  ' || sbCondicion || '
                      ORDER BY 1';

    ut_trace.trace(sbSentencia);
    dbms_output.put_line(sbSentencia);

    OPEN ocuDatos FOR sbSentencia
      USING inuCotizacion;

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

  Unidad         : proObtCotizacionxCliente
  Descripcion    : Servicio de consulta para obtener las cotizaciones
                   comerciales/industriales de un cliente
  Autor          : KCienfuegos
  Fecha          : 15-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  15-11-2016    KCienfuegos.CA200-535         Creacion.
  17-07-2018    Stapias.CA200-1640            Se agrega al Select campo Unidad_Operativa
                                              obtenido de la tabla de datos adicionales
  ******************************************************************/
  PROCEDURE proObtCotizacionxCliente(inuCliente IN ge_subscriber.subscriber_id%TYPE,
                                     ocuDatos   OUT CONSTANTS.TYREFCURSOR) IS

    sbProceso   VARCHAR2(500) := 'proObtCotizacionxCliente';
    sbError     VARCHAR2(4000);
    sbCondicion VARCHAR2(4000);
    sbSentencia VARCHAR2(4000);
    sbCampos    VARCHAR2(4000);

  BEGIN

    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso, 10);

    sbCampos := 'c.id_cot_comercial id,
                 decode(c.estado, ''RE'', ''Registrada'', ''E'', ''Enviada a OSF'', ''A'', ''Aprobada'') estado,
                 c.sol_cotizacion solicitud_cotizacion,
                 c.sol_venta solicitud_venta,
                 c.observacion,
                 c.cliente parent_id,
                 c.id_direccion  || '' - '' || d.address_parsed direccion,
                 ''$''||to_char(nvl(c.valor_cotizado,0),''FM999,999,990.00'') valor_cotizado,
                 c.descuento,
                 c.fecha_registro fecha_registro,
                 c.fecha_vigencia fecha_vigencia,
                 c.fecha_modificacion fecha_modificacion,
                 c.usuario_registra usuario_registra,
                 c.usuario_modif usuario_modifica,
                 TO_CHAR((SELECT o.operating_unit_id || '' - '' || o.name FROM or_operating_unit o WHERE o.operating_unit_id = a.unidad_operativa)) unidad_operativa';

    -- Aplicar los filtros
    sbCondicion := 'c.id_direccion = d.address_id (+)
                      AND c.cliente = nvl(:inuCliente,-1)
                      AND c.id_cot_comercial = a.id_cot_comercial(+)';

    -- Construir la sentencia
    sbSentencia := 'SELECT ' || sbCampos || '
                      FROM   ldc_cotizacion_comercial c, ldc_coticomercial_adic a,
                      ab_address d
                      WHERE  ' || sbCondicion || '
                      ORDER BY 1';

    ut_trace.trace(sbSentencia);
    dbms_output.put_line(sbSentencia);

    OPEN ocuDatos FOR sbSentencia
      USING inuCliente;

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

  Unidad         : proObtCotizacionxCliente
  Descripcion    : Servicio de consulta para obtener las cotizaciones
                   comerciales/industriales de un contrato
  Autor          : KCienfuegos
  Fecha          : 15-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  15-11-2016    KCienfuegos.CA200-535         Creacion.
  17-07-2018    Stapias.CA200-1640            Se agrega al Select campo Unidad_Operativa
                                              obtenido de la tabla de datos adicionales
  ******************************************************************/
  PROCEDURE proObtCotizacionxContrato(inuContrato IN suscripc.susccodi%TYPE,
                                      ocuDatos    OUT CONSTANTS.TYREFCURSOR) IS

    sbProceso   VARCHAR2(500) := 'proObtCotizacionxContrato';
    sbError     VARCHAR2(4000);
    sbCondicion VARCHAR2(4000);
    sbSentencia VARCHAR2(4000);
    sbCampos    VARCHAR2(4000);

  BEGIN

    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso, 10);

    sbCampos := 'c.id_cot_comercial id,
                 decode(c.estado, ''RE'', ''Registrada'', ''E'', ''Enviada a OSF'', ''A'', ''Aprobada'') estado,
                 c.sol_cotizacion solicitud_cotizacion,
                 c.sol_venta solicitud_venta,
                 c.observacion,
                 m.subscription_id parent_id,
                 c.id_direccion  || '' - '' || d.address_parsed direccion,
                 ''$''||to_char(nvl(c.valor_cotizado,0),''FM999,999,990.00'') valor_cotizado,
                 c.descuento,
                 c.fecha_registro fecha_registro,
                 c.fecha_vigencia fecha_vigencia,
                 c.fecha_modificacion fecha_modificacion,
                 c.usuario_registra usuario_registra,
                 c.usuario_modif usuario_modifica,
                 TO_CHAR((SELECT o.operating_unit_id || '' - '' || o.name FROM or_operating_unit o WHERE o.operating_unit_id = a.unidad_operativa)) unidad_operativa';

    -- Aplicar los filtros
    sbCondicion := 'c.id_direccion = d.address_id
                     AND  c.sol_cotizacion = p.package_id
                     AND  c.cliente = p.subscriber_id
                     AND m.package_id = p.package_id
                     AND m.motive_id = (SELECT MIN(mm.motive_id) FROM mo_motive mm WHERE m.package_id = mm.package_id)
                     AND m.subscription_id = nvl(:inuContrato, -1)
                     AND c.id_cot_comercial = a.id_cot_comercial(+)';

    -- Construir la sentencia
    sbSentencia := 'SELECT ' || sbCampos || '
                      FROM   mo_motive m,
                             mo_packages p,
                             ab_address d,
                             ldc_cotizacion_comercial c, ldc_coticomercial_adic a
                      WHERE  ' || sbCondicion || '
                      ORDER BY 1';

    ut_trace.trace(sbSentencia);
    dbms_output.put_line(sbSentencia);

    OPEN ocuDatos FOR sbSentencia
      USING inuContrato;

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

END LDC_BOPICOTIZACOMERCIAL;
/
PROMPT Otorgando permisos de ejecucion a LDC_BOPICOTIZACOMERCIAL
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BOPICOTIZACOMERCIAL', 'ADM_PERSON');
END;
/
