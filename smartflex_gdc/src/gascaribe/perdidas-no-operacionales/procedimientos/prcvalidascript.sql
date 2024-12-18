create or replace PROCEDURE PRCVALIDASCRIPT(INUPRODUCT NUMBER) IS
  /***********************************************************************************************************************************
  Autor       : Horbath Technologies
  Fecha       : 20/09/2019
  Ticket      : 0000056
  Descripcion : Procedimiento para la validación de productos con solicitudes PNO asociadas.
  
  
          HISTORIAL DE MODIFICACIONES
  =========       =========     =========         ====================
    Fecha          Ticket         Autor               Modificacion
  =========       =========     =========         ====================
  22/02/2024      OSF-2364      Jorge Valiente    Se retira logica donde se valida si el prodcuto tiene un proyecto PNO. 
                                                  Se cambia logica para validar si el producto tiene OT 12669 no legalizado 
                                                    para no permitir generar proyecto PNO si cumple esta condicion
  **************************************************************************************************************************************/
  nutsess   NUMBER;
  sbparuser VARCHAR(100);
  onuok     NUMBER;
  sbError   VARCHAR2(4000);

  NUADDRESS number;

  CNURECORDEXISTS    number := dald_parameter.fnuGetNumeric_Value('CODIGO_MENSAJE_ADVERTENCIA',
                                                                  NULL);
  ONUID              number;
  NUGEOGRAPHLOCATION number;

  NUPRODUCTTYPE NUMBER;

  --Inicio OSF-2364
  csbMT_NAME                     VARCHAR2(70) := 'PRCVALIDASCRIPT';
  sbTipoTrabajoValidaCreacionPNO varchar2(4000) := null;
  sbEstadoOrdenValidaCreacionPNO varchar2(4000) := null;

  cursor cuOTSinLegalizar is
    select count(1)
      from or_order oo
     inner join or_order_activity ooa
        on oo.order_id = oo.order_id
     inner join fm_possible_ntl fpn
        on fpn.product_id = ooa.product_id
       and fpn.product_id = INUPRODUCT
       and fpn.address_id = NUADDRESS
       and fpn.product_type_id = NUPRODUCTTYPE
     where oo.order_id = ooa.order_id
       and ooa.product_id = fpn.product_id
       and ooa.address_id = fpn.address_id
       and oo.order_status_id in
           (SELECT to_number(regexp_substr(sbEstadoOrdenValidaCreacionPNO,
                                           '[^,]+',
                                           1,
                                           LEVEL)) AS EstadoOrdenValidaCreacionPNO
              FROM dual
            CONNECT BY regexp_substr(sbEstadoOrdenValidaCreacionPNO,
                                     '[^,]+',
                                     1,
                                     LEVEL) IS NOT NULL)
       and oo.task_type_id in
           (SELECT to_number(regexp_substr(sbTipoTrabajoValidaCreacionPNO,
                                           '[^,]+',
                                           1,
                                           LEVEL)) AS TipoTrabajoValidaCreacionPNO
              FROM dual
            CONNECT BY regexp_substr(sbTipoTrabajoValidaCreacionPNO,
                                     '[^,]+',
                                     1,
                                     LEVEL) IS NOT NULL);

  nuOTSinLegalizar number := 0;
  --Fin OSF-2364  

BEGIN
  pkg_traza.trace(csbMT_NAME,
                  pkg_traza.cnuNivelTrzDef,
                  pkg_traza.csbINICIO);

  --OBTENEMOS TIPO DE PRODUCTO Y DIRECCION DEL PRODUCTO
  IF INUPRODUCT IS NOT NULL THEN
    NUADDRESS     := PKG_BCPRODUCTO.FNUIDDIRECCINSTALACION(INUPRODUCT);
    NUPRODUCTTYPE := PKG_BCPRODUCTO.FNUTIPOPRODUCTO(INUPRODUCT);
  END IF;

  --Inicio OSF-2364
  sbTipoTrabajoValidaCreacionPNO := pkg_parametros.fsbGetValorCadena('TIPO_TRABAJO_VALIDA_CREACION_PNO');
  if sbTipoTrabajoValidaCreacionPNO is null then
    pkg_error.seterrormessage(isbMsgErrr => 'El parametro TIPO_TRABAJO_VALIDA_CREACION_PNO no tiene valor definido.');
  end if;
  sbEstadoOrdenValidaCreacionPNO := pkg_parametros.fsbGetValorCadena('ESTADO_ORDEN_VALIDA_CREACION_PNO');
  if sbEstadoOrdenValidaCreacionPNO is null then
    pkg_error.seterrormessage(isbMsgErrr => 'El parametro ESTADO_ORDEN_VALIDA_CREACION_PNO no tiene valor definido.');
  end if;

  pkg_traza.trace('Producto: ' || INUPRODUCT, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Codigo Direccion: ' || NUADDRESS,
                  pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Tipo Producto: ' || NUPRODUCTTYPE,
                  pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Estado de orden a validar en PNO: ' ||
                  sbEstadoOrdenValidaCreacionPNO,
                  pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Tipo de Trabajo de orden a validar en PNO: ' ||
                  sbTipoTrabajoValidaCreacionPNO,
                  pkg_traza.cnuNivelTrzDef);

  nuOTSinLegalizar := pkg_boregistropno.fnuCantidadOTSinLegalizar(INUPRODUCT,
                                                                 NUADDRESS,
                                                                 NUPRODUCTTYPE,
                                                                 sbEstadoOrdenValidaCreacionPNO,
                                                                 sbTipoTrabajoValidaCreacionPNO);

  if nuOTSinLegalizar > 0 then
    pkg_error.seterrormessage(isbMsgErrr => 'El producto ' || INUPRODUCT ||
                                            ' tiene alguna orden u ordenes de PNO con TT [' ||
                                            sbTipoTrabajoValidaCreacionPNO ||
                                            '] sin legalizar.');
  end if;
  --Fin OSF-2364

  pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
  WHEN pkg_error.CONTROLLED_ERROR THEN
    pkg_Error.getError(onuok, sberror);
    pkg_traza.trace('Error: ' || sberror, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
    raise pkg_error.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(onuok, sberror);
    pkg_traza.trace('Error: ' || sberror, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
    raise pkg_error.CONTROLLED_ERROR;
  
END PRCVALIDASCRIPT;
/
