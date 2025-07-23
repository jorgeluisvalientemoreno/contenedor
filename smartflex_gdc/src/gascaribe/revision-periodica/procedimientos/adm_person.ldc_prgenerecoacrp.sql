CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRGENERECOACRP IS
  /**************************************************************************
  Autor       : OLSOFTWARE
  Fecha       : 2021-01-25
  Proceso     : LDC_PRGENERECOACRP
  Ticket      : 547
  Descripcion : plugin que se encargue de generar la solicitud de acometida
  
  Parametros Entrada
  
  Valor de salida
  
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  25/11/2021   DANVAL      CA 833_1 : La orden instanciada se validara en OR_REQU_DATA_VALUE para ver si
                           posee el dato adicional definido en el parametro DATOADICION_UNIDADOPER
                           si existe se registrara en la tabla LDC_ORDENTRAMITERP
  28/02/2022   JORVAL      GLPI 949: Agrega comentario de la solciitud asociada a la orden legalizada a la
                           nueva solicitud generada
  28/02/2022   JORVAL      OSF-3821: Agregar logica de asignacion automatica con el servicio ldc_procrearegasiunioprevper
                           Establecer pautas tecnicas
  ***************************************************************************/
  --CA 833_1
  sbDatoAdicional ldc_pararepe.paravast%type := pkg_bcldc_pararepe.fsbobtienevalorcadena('DATOADICION_UNIDADOPER');
  nuCodDatoAdicic ldc_pararepe.parevanu%type := pkg_bcldc_pararepe.fnuobtienevalornumerico('COD_DATOADICION_UNIDADOPER');

  sbTipoTrabFalloRP ldc_pararepe.paravast%TYPE := pkg_bcldc_pararepe.fsbobtienevalorcadena('TIPOTRABAJO_FALLORP');
  sbCausalFalloRP   ldc_pararepe.paravast%TYPE := pkg_bcldc_pararepe.fsbobtienevalorcadena('CAUSAL_FALLORP');

  nuTipoTrabFalloRP NUMBER;
  nuCausalFalloRP   NUMBER;
  nuCausal          NUMBER;
  NUUNITOPERADDDATA NUMBER;
  sbValorPRCDA      VARCHAR2(2000);
  --
  numedRecRp       ldc_pararepe.parevanu%TYPE;
  sbTiTrPortal     ldc_pararepe.paravast%TYPE := pkg_bcldc_pararepe.fsbobtienevalorcadena('LDC_TIPOTRABPORTAL');
  nuestadoProducto pr_product.product_status_id%TYPE;
  nuEstacort       servsusc.sesuesco%TYPE;
  sbEstadoFina     servsusc.sesuesfn%TYPE;
  nuTitrOt         or_order.task_type_id%TYPE;
  nuSoliOt         mo_packages.package_id%TYPE;
  nuPackageId      NUMBER;
  nuMotiveId       NUMBER;
  nuOrderId        NUMBER;
  nuProducto       NUMBER;
  ONUERRORCODE     NUMBER := NULL;
  OSBERRORMESSAGE  VARCHAR2(4000);

  --se consulta cargos de certificacion
  CURSOR cuGetProducto IS
    SELECT oa.product_id, p.product_status_id, sesuesfn, sesuesco
      FROM or_order_activity oa, pr_product p, servsusc
     WHERE oa.order_id = nuOrderId
       and oa.product_id = p.product_id
       and oa.product_id = sesunuse;

  -- datos para generar xml
  CURSOR cudatosXml IS
    select di.ADDRESS_PARSED,
           di.ADDRESS_ID,
           di.GEOGRAP_LOCATION_ID,
           pr.CATEGORY_ID,
           pr.SUBCATEGORY_ID,
           pr.SUBSCRIPTION_ID,
           sc.SUSCCLIE SUBSCRIBER_ID,
           pr.product_id
      from pr_product pr, SUSCRIPC sc, ab_address di
     where pr.ADDRESS_ID = di.ADDRESS_ID
       and pr.SUBSCRIPTION_ID = sc.SUSCCODI
       and pr.product_id = nuproducto;

  regProducto cudatosXml%ROWTYPE;
  sbComment   VARCHAR2(4000);
  sbComment1  VARCHAR2(4000);
  sbmensa     VARCHAR2(4000);

  --OSF-3821
  CURSOR cuExisteValorNumerico(nuValor NUMBER, sbCadena VARCHAR2) IS
    SELECT COUNT(1) cantidad
      FROM dual
     WHERE nuValor IN
           (SELECT to_number(regexp_substr(sbCadena, '[^,]+', 1, LEVEL)) AS column_value
              FROM dual
            CONNECT BY regexp_substr(sbCadena, '[^,]+', 1, LEVEL) IS NOT NULL);

  csbMetodo CONSTANT VARCHAR2(100) := $$PLSQL_UNIT;
  cnuNVLTRC CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
  csbInicio CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
  csbFin    CONSTANT VARCHAR2(35) := pkg_traza.fsbFIN;
  nuExisteTT NUMBER;

  sbFlag ldc_conftitra_caus_asig_aut.asig_auto%TYPE;

BEGIN

  pkg_traza.trace(csbMetodo, cnuNVLTRC, csbInicio);

  nuOrderId := pkg_bcordenes.fnuobtenerotinstancialegal; -- Obtenemos la orden que se esta legalizando
  pkg_traza.trace('Orden: ' || nuOrderId, cnuNVLTRC);

  nuTitrOt := pkg_bcordenes.fnuobtienetipotrabajo(nuOrderId);
  pkg_traza.trace('Tipo Trabajo: ' || nuTitrOt, cnuNVLTRC);

  OPEN cuExisteValorNumerico(nuTitrOt, sbTiTrPortal);
  FETCH cuExisteValorNumerico
    INTO nuExisteTT;
  CLOSE cuExisteValorNumerico;

  IF nuExisteTT > 0 THEN
    numedRecRp := pkg_bcldc_pararepe.fnuobtienevalornumerico('LDC_MEDIRECERP');
  else
    numedRecRp := 10;
  end if;
  pkg_traza.trace('Medio Recepcion: ' || numedRecRp, cnuNVLTRC);

  --se obtiene producto
  OPEN cuGetProducto;
  FETCH cuGetProducto
    INTO nuProducto, nuestadoProducto, sbEstadoFina, nuEstacort;
  IF cuGetProducto%NOTFOUND THEN
    Pkg_Error.SetErrorMessage(isbMsgErrr => 'Orden de trabajo [' ||
                                            nuOrderId ||
                                            '] no tiene informacion de producto.');
  END IF;
  CLOSE cuGetProducto;

  pkg_traza.trace('Producto: ' || nuProducto, cnuNVLTRC);
  pkg_traza.trace('Solicitud Ot Legalizada: ' || nuSoliOt, cnuNVLTRC);

  pkg_LDC_ORDENES_RP.prcInstarRegistro(nuProducto, nuOrderId, nuSoliOt);

  --CAMBIO 949
  --Obtener comentario de la solicitude asociada a la orden legalizada.
  sbComment1 := pkg_bcsolicitudes.fsbGetComentario(pkg_bcordenes.fnuObtieneSolicitud(nuOrderId));

  sbComment := SUBSTR('Solicitud generada por proceso LDC_PRGENERECOACRP, legalizacion de la orden [' ||
                      nuOrderId || '] ' || sbComment1,
                      0,
                      1999);

  open cudatosXml;
  fetch cudatosXml
    into regProducto;
  close cudatosXml;

  --Se genera reconexion
  ldc_pkgeneraTramiteRp.prGenera100321(numedRecRp,
                                       sbcomment,
                                       regProducto.SUBSCRIBER_ID,
                                       regProducto.PRODUCT_ID,
                                       regProducto.SUBSCRIPTION_ID,
                                       regProducto.ADDRESS_PARSED,
                                       regProducto.ADDRESS_ID,
                                       regProducto.GEOGRAP_LOCATION_ID,
                                       regProducto.CATEGORY_ID,
                                       regProducto.SUBCATEGORY_ID,
                                       -1,
                                       nuPackageId,
                                       nuMotiveId,
                                       ONUERRORCODE,
                                       OSBERRORMESSAGE);

  pkg_traza.trace('Solicitud Generada: ' || nuPackageId, cnuNVLTRC);
  pkg_traza.trace('Codigo Error: ' || ONUERRORCODE, cnuNVLTRC);
  pkg_traza.trace('Mensaje Error: ' || OSBERRORMESSAGE, cnuNVLTRC);

  IF ONUERRORCODE <> 0 THEN
    PKG_LDC_LOGERRLEORRESU.PRC_INS_LDC_LOGERRLEORRESU(NULL,
                                                      nuOrderId,
                                                      'LDC_PRGENERECOACRP',
                                                      'Error al generar proceso de Rp [' ||
                                                      OSBERRORMESSAGE || ']',
                                                      SYSDATE,
                                                      USER);
    Pkg_Error.SetErrorMessage(isbMsgErrr => 'Error al generar proceso de Rp [' ||
                                            OSBERRORMESSAGE || ']');
  ELSE
  
    /*Si el Tipo de Trabajo esta definido en el  Parametro TIPOTRABAJO_OPERARP y la causal es de Exito*/
    sbValorPRCDA := ldc_boordenes.fsbDatoAdicTmpOrden(nuOrderId,
                                                      nuCodDatoAdicic,
                                                      TRIM(sbDatoAdicional));
    IF sbValorPRCDA IS NOT NULL THEN
      nuUnitOperAdddata := to_number(sbValorPRCDA);
      IF pkg_bcunidadoperativa.fblexiste(nuUnitOperAdddata) = FALSE THEN
        sbmensa := 'Proceso termino con errores: La Unidad Operativa [' ||
                   NUUNITOPERADDDATA ||
                   '] registrada en el Dato Adicional [' || sbDatoAdicional ||
                   '] no existe';
        Pkg_Error.SetErrorMessage(isbMsgErrr => sbmensa);
      END IF;
    END IF;
  
    OPEN cuExisteValorNumerico(nuTitrOt, sbTipoTrabFalloRP);
    FETCH cuExisteValorNumerico
      INTO nuTipoTrabFalloRP;
    CLOSE cuExisteValorNumerico;
  
    nuCausal := PKG_BCORDENES.FNUOBTIENECAUSAL(nuOrderId);
    OPEN cuExisteValorNumerico(nuCausal, sbCausalFalloRP);
    FETCH cuExisteValorNumerico
      INTO nuCausalFalloRP;
    CLOSE cuExisteValorNumerico;
  
    IF nuTipoTrabFalloRP > 0 AND nuCausalFalloRP > 0 AND
       NUUNITOPERADDDATA IS NOT NULL THEN
      nuCausal := PKG_BCORDENES.FNUOBTIENECAUSAL(nuOrderId);
      pkg_ldc_ordentramiterp.prcInsertaRegistro(nuOrderId,
                                                nuTitrOt,
                                                nuCausal,
                                                nuPackageId,
                                                NUUNITOPERADDDATA);
    END IF;
  
    --Inicio OSF-3821
    pkg_traza.trace('Tipo Trabajo: ' || nuTitrOt, cnuNVLTRC);    
    pkg_traza.trace('Causal: ' || nuCausal, cnuNVLTRC);    
    
    sbflag := ldc_fsbretornaaplicaasigauto(nuTitrOt, nuCausal);
    pkg_traza.trace('sbflag: ' || sbflag, cnuNVLTRC);    
    IF nvl(sbflag, 'N') = 'S' THEN
      ldc_procrearegasiunioprevper(NUUNITOPERADDDATA,
                                   nuProducto,
                                   nuTitrOt,
                                   nuOrderId,
                                   nuPackageId);
    END IF;
    --Fin OSF-3821
  
  END IF;

  pkg_LDC_ORDENES_RP.prBorRegistro(nuProducto, nuOrderId, nuSoliOt);

  pkg_traza.trace(csbMetodo, cnuNVLTRC, csbFin);

EXCEPTION
  WHEN pkg_error.CONTROLLED_ERROR THEN
    pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
    pkg_traza.trace('Error: ' || OsbErrorMessage, cnuNVLTRC);
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
    RAISE pkg_error.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
    pkg_traza.trace('Error: ' || OsbErrorMessage, cnuNVLTRC);
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
    RAISE pkg_error.CONTROLLED_ERROR;
END LDC_PRGENERECOACRP;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRGENERECOACRP', 'ADM_PERSON');
END;
/
