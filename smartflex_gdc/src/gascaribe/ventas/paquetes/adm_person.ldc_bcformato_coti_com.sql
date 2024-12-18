CREATE OR REPLACE PACKAGE adm_person.LDC_BCFORMATO_COTI_COM IS

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : LDC_BCFORMATO_COTI_COM
  Descripcion    : Paquete que contiene la logica de negocio para la impresi?n del formato
                   de cotizaci?n de ventas comerciales e industriales
  Autor          : KCienfuegos
  Fecha          : 04-11-2016
  Caso           : CA200-535

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  23/07/2024    PAcosta                      OSF-2952: Cambio de esquema ADM_PERSON
  04-11-2016    KCienfuegos.CA200-535        Creacion
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proObtieneEncabezado
  Descripcion    : Metodo para obtener los datos del encabezado de la cotizacion
  Autor          : KCienfuegos
  Fecha          : 04-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  04-11-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proObtieneEncabezado(orfcursor OUT constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proObtieneDatosCliente
  Descripcion    : Metodo para obtener datos basicos del cliente
  Autor          : KCienfuegos
  Fecha          : 04-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  04-11-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proObtieneDatosCliente(orfcursor OUT constants.tyRefCursor);

    /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proObtieneDetalleItems
  Descripcion    : Metodo para obtener el detalle de los ?tems
  Autor          : KCienfuegos
  Fecha          : 04-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  04-11-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proObtieneDetalleItems(orfcursor OUT constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proObtieneFormaPago
  Descripcion    : Metodo para obtener los datos de la forma de pago
  Autor          : KCienfuegos
  Fecha          : 04-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  04-11-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proObtieneFormaPago(orfcursor OUT constants.tyRefCursor);

END LDC_BCFORMATO_COTI_COM;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BCFORMATO_COTI_COM IS

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : LDC_BCFORMATO_COTI_COM
  Descripcion    : Paquete que contiene la logica de negocio para la impresion del formato
                   de cotizacion de ventas comerciales e industriales
  Autor          : KCienfuegos
  Fecha          : 04-11-2016
  Caso           : CA200-535

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  04-11-2016    KCienfuegos.CA200-535        Creacion
  ******************************************************************/

  --Constantes
  csbPaquete                CONSTANT           VARCHAR2(60) := 'ldc_bcformato_coti_com';
  cnuCodigoError            CONSTANT           NUMBER       := 2741;
  csbEstadoRegistrada       CONSTANT           VARCHAR2(2)  := 'R';

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proObtieneEncabezado
  Descripcion    : Metodo para obtener los datos del encabezado de la cotizacion
  Autor          : KCienfuegos
  Fecha          : 04-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  04-11-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proObtieneEncabezado(orfcursor OUT constants.tyRefCursor)
    IS

    sbProceso             VARCHAR2(500) := 'proObtieneEncabezado';
    sbError               VARCHAR2(4000);
    nuCotizacion          ldc_cotizacion_comercial.id_cot_comercial%TYPE;
    nuCotiOSF             cc_quotation.quotation_id%TYPE;

  BEGIN

    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);

      nuCotizacion := to_number(obtenervalorinstancia('LDC_COTIZACION_COMERCIAL', 'ID_COT_COMERCIAL'));

      nuCotiOSF := ldc_bccotizacioncomercial.fnuCotizacionOSF(nuCotizacion);

      OPEN orfcursor FOR
          SELECT nuCotiOSF consecutivo_cotizacion,
                 c.fecha_registro,
                 c.fecha_vigencia,
                 c.sol_cotizacion solicitud,
                 pktblsistema.fsbgetsistnitc(99) nit,
                 pktblsistema.fsbgetsistdire(99) direccion,
                 pktblsistema.fsbgetsistciud(99) ciudad
            FROM ldc_cotizacion_comercial c
           WHERE c.id_cot_comercial = nuCotizacion;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso,10);

  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso ||sbError,10);
      IF(sbError IS NOT NULL)THEN
         ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
      END IF;
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso||' '||SQLERRM,10);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proObtieneDatosCliente
  Descripcion    : Metodo para obtener datos basicos del cliente
  Autor          : KCienfuegos
  Fecha          : 04-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  04-11-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proObtieneDatosCliente(orfcursor OUT constants.tyRefCursor)
    IS

    sbProceso             VARCHAR2(500) := 'proObtieneDatosCliente';
    sbError               VARCHAR2(4000);
    sbEstado              ldc_cotizacion_comercial.estado%TYPE;
    nuSolVenta            ldc_cotizacion_comercial.sol_venta%TYPE;
    nuCotizacion          ldc_cotizacion_comercial.id_cot_comercial%TYPE;
    nuCliente             ge_subscriber.subscriber_id%TYPE;
    nuProducto            servsusc.sesunuse%TYPE;
    nuContrato            servsusc.sesususc%TYPE;

  BEGIN

    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);

      nuCotizacion := to_number(obtenervalorinstancia('LDC_COTIZACION_COMERCIAL', 'ID_COT_COMERCIAL'));

      sbEstado := daldc_cotizacion_comercial.fsbGetESTADO(nuCotizacion,0);

      nuCliente := daldc_cotizacion_comercial.fnuGetCLIENTE(nuCotizacion,0);

      BEGIN
        SELECT sesunuse, sesususc
          INTO nuProducto, nuContrato
          FROM(
          SELECT sesunuse, sesususc
            FROM suscripc s, servsusc p
           WHERE s.suscclie = nuCliente
             AND s.susccodi = p.sesususc
             AND p.sesuserv = dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS', 0)
           ORDER BY sesunuse DESC)
         WHERE rownum<=1;
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;

      nuSolVenta := daldc_cotizacion_comercial.fnuGetSOL_VENTA(nuCotizacion,0);

      IF(sbEstado = csbEstadoRegistrada OR nuSolVenta IS NULL)THEN
          OPEN orfcursor FOR
              SELECT
                     nuContrato contrato,
                     nuProducto producto,
                     ab.address_parsed direccion,
                     su.subscriber_name || ' ' || su.subs_last_name nombre_cliente,
                     su.phone telefono_cliente,
                     su.identification identificacion,
                     pr.category_ || ' ' ||
                     (select catedesc from categori where catecodi= pr.category_) categoria,
                     pr.subcategory_ || ' ' ||
                     (select sucadesc from subcateg where sucacate= pr.category_ and sucacodi= pr.subcategory_) subcategoria,
                     dage_geogra_location.fsbgetdescription(dage_geogra_location.fnugetgeo_loca_father_id(ab.geograp_location_id,
                                                                                                              0),0)departamento,
                     dage_geogra_location.fsbgetdescription(ab.geograp_location_id,
                                                                0) localidad,
                     NULL contratista,
                     NULL formulario,
                     cc.observacion observacion
                FROM ab_address    ab,
                     ge_subscriber su,
                     ab_premise    pr,
                     ldc_cotizacion_comercial cc
               WHERE cc.id_cot_comercial = nuCotizacion
                 AND cc.cliente = su.subscriber_id
                 AND ab.address_id (+)= cc.id_direccion
                 AND ab.estate_number = pr.premise_id(+);

      ELSE

          OPEN orfcursor FOR
              SELECT
                     m.subscription_id contrato,
                     m.product_id producto,
                     ab.address_parsed direccion,
                     su.subscriber_name || ' ' || su.subs_last_name nombre_cliente,
                     su.phone telefono_cliente,
                     su.identification identificacion,
                     pr.category_ || ' ' ||
                     (select catedesc from categori where catecodi= pr.category_) categoria,
                     pr.subcategory_ || ' ' ||
                     (select sucadesc from subcateg where sucacate= pr.category_ and sucacodi= pr.subcategory_) subcategoria,
                     dage_geogra_location.fsbgetdescription(dage_geogra_location.fnugetgeo_loca_father_id(ab.geograp_location_id,
                                                                                                              0),0)departamento,
                     dage_geogra_location.fsbgetdescription(ab.geograp_location_id,
                                                                0) localidad,
                     daor_operating_unit.fnugetcontractor_id(p.pos_oper_unit_id,0)||' - '||dage_contratista.fsbgetnombre_contratista(daor_operating_unit.fnugetcontractor_id(p.pos_oper_unit_id,0),0) contratista,
                     p.document_key formulario,
                     cc.observacion observacion
                FROM ab_address    ab,
                     ge_subscriber su,
                     ab_premise    pr,
                     mo_packages p,
                     mo_motive m,
                     ldc_cotizacion_comercial cc
               WHERE cc.id_cot_comercial = nuCotizacion
                 AND cc.cliente = su.subscriber_id
                 AND ab.address_id = cc.id_direccion
                 AND ab.estate_number = pr.premise_id
                 AND p.package_id = nuSolVenta
                 AND m.package_id = p.package_id
                 AND p.subscriber_id = cc.cliente
                 AND m.motive_id = (SELECT MIN(mm.motive_id) FROM mo_motive mm WHERE m.package_id = mm.package_id);
      END IF;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso,10);

  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso ||sbError,10);
      IF(sbError IS NOT NULL)THEN
         ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
      END IF;
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso||' '||SQLERRM,10);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proObtieneDetalleItems
  Descripcion    : Metodo para obtener el detalle de los ?tems
  Autor          : KCienfuegos
  Fecha          : 04-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  04-11-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proObtieneDetalleItems(orfcursor OUT constants.tyRefCursor)
    IS

    sbProceso             VARCHAR2(500) := 'proObtieneDetalleItems';
    sbError               VARCHAR2(4000);
    nuCotizacion          ldc_cotizacion_comercial.id_cot_comercial%TYPE;
    --nuPorcDescuento       NUMBER;
  BEGIN

    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);

      nuCotizacion := to_number(obtenervalorinstancia('LDC_COTIZACION_COMERCIAL', 'ID_COT_COMERCIAL'));

       --nuPorcDescuento := daldc_cotizacion_comercial.fnuGetDESCUENTO(TO_NUMBER(OBTENERVALORINSTANCIA('LDC_COTIZACION_COMERCIAL', 'ID_COT_COMERCIAL')),0);

      OPEN orfcursor FOR
          SELECT tipo_trabajo,
                 id_item,
                 item_desc,
                 costo_venta,
                 aiu,
                 cantidad,
                 precio_total,
                 valor_iva,
                 valor_total
                 FROM(
            SELECT
                   daor_task_type.fsbgetdescription(di.tipo_trabajo,0) tipo_trabajo,
                   di.id_item,
                   UPPER(dage_items.fsbgetdescription(di.id_item,0)) item_desc,
                   round(di.costo_venta,0) costo_venta,
                   round(di.aiu,0) aiu,
                   di.cantidad,
                   round(di.precio_total,0) precio_total,
                   di.iva/*decode(t.abreviatura,'CE',round(((di.precio_total-di.descuento) * t.iva / 100)), round(((di.aiu) * t.iva / 100*50/100))-(round(((di.aiu) * t.iva / 100*50/100))*nuPorcDescuento/100))*/ valor_iva,
                   round((di.iva + precio_total),0) valor_total
              FROM ldc_items_cotizacion_com di, ldc_tipotrab_coti_com t
             WHERE di.id_cot_comercial = nuCotizacion
               AND t.tipo_trabajo = di.tipo_trabajo
               AND di.id_cot_comercial = t.id_cot_comercial
             ORDER BY tipo_trabajo, id_item);

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso,10);

  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso ||sbError,10);
      IF(sbError IS NOT NULL)THEN
         ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
      END IF;
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso||' '||SQLERRM,10);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : proObtieneFormaPago
  Descripcion    : Metodo para obtener los datos de la forma de pago
  Autor          : KCienfuegos
  Fecha          : 04-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  04-11-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/
  PROCEDURE proObtieneFormaPago(orfcursor OUT constants.tyRefCursor)
    IS

    sbProceso             VARCHAR2(500) := 'proObtieneFormaPago';
    sbError               VARCHAR2(4000);
    nuCotizacion          ldc_cotizacion_comercial.id_cot_comercial%TYPE;
  BEGIN

    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);

      nuCotizacion := to_number(obtenervalorinstancia('LDC_COTIZACION_COMERCIAL', 'ID_COT_COMERCIAL'));

      OPEN orfcursor FOR
        SELECT nvl((select p.pldicodi||'-'||p.pldidesc from plandife p where p.pldicodi= cf.financing_plan_id),' ') modalidad_pago,
               nvl(cf.quotas_number,0) numero_cuotas,
               nvl(qu.total_disc_value,(select sum(i.descuento) from ldc_items_cotizacion_com i where i.id_cot_comercial=nuCotizacion)) descuento,
               nvl(qu.initial_payment,0) cuota_inicial,
               nvl(cf.value_to_finance,0) valor_financiar
          FROM cc_quot_financ_cond cf, cc_quotation qu, ldc_cotizacion_comercial cc
         WHERE cf.quotation_id (+)= qu.quotation_id
           AND qu.package_id (+)= cc.sol_cotizacion
           AND cc.id_cot_comercial = nuCotizacion;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso,10);

  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso ||sbError,10);
      IF(sbError IS NOT NULL)THEN
         ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
      END IF;
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso||' '||SQLERRM,10);
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END;

END LDC_BCFORMATO_COTI_COM;
/
PROMPT Otorgando permisos de ejecucion a LDC_BCFORMATO_COTI_COM
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BCFORMATO_COTI_COM', 'ADM_PERSON');
END;
/