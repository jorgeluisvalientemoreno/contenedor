create or replace PACKAGE adm_person.LDC_PKVENTAGAS IS

  globalsesion number; --variable global para manejar el codigo de la sesion

  /*****************************************************************
    Propiedad intelectual de SINCECOMP (c).

    Unidad         : LDC_PKVENTAGAS
    Descripcion    : Paquete creado para formato de venta para las gaseras.
    Autor          : Sincecomp
    Fecha          : 23/03/2016


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    26/06/2024        PAcosta            OSF-2878: Cambio de esquema ADM_PERSON  
  ******************************************************************/

  -- Obtiene la Version actual del Paquete
  FUNCTION FSBVERSION RETURN VARCHAR2;

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : PBPlantillaNet
  Descripcion    : procedimiento para generar PDF del formato de venta gas.
  Autor          : Sincecomp
  Fecha          : 28/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PBPlantillaNet;

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfDatosVentaGas
  Descripcion    : procedimiento para obtener todos los datos asociados a la venta de servico de gas.
  Autor          : Sincecomp
  Fecha          : 13/07/2015

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RfDatosVentaGas(orfcursor OUT constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfDetalleVentaGas
  Descripcion    : procedimiento para obtener todos los detalles de la venta de servico de gas.
  Autor          : Sincecomp
  Fecha          : 13/07/2015

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RfDetalleVentaGas(orfcursor OUT constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfDatoCotizacion
  Descripcion    : procedimiento para obtener datos relacionado con la cotizacion de la venta de servico de gas.
                   para comercia. En caso que imprima para tipo residencial sera NULO
  Autor          : Sincecomp
  Fecha          : 31/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RfDatoCotizacion(orfcursor OUT constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfTotalVentaGas
  Descripcion    : procedimiento para obtener el total de IVA y TOTAL A PAGAS de la venta de servico de gas.
  Autor          : Sincecomp
  Fecha          : 31/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RfTotalVentaGas(orfcursor OUT constants.tyRefCursor);

  ---Inicio servicios para GDC

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfDatosVentaGasGDC
  Descripcion    : procedimiento para obtener todos los datos asociados a la venta de servico de gas.
  Autor          : Sincecomp
  Fecha          : 23/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RfDatosVentaGasGDC(orfcursor Out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfDetalleNoIVAGasGDC
  Descripcion    : procedimiento para obtener todos los detalles de la venta de servico de gas.
  Autor          : Sincecomp
  Fecha          : 22/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  PROCEDURE RfDetalleNoIVAGasGDC(orfcursor OUT constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfDetalleIVAGasGDC
  Descripcion    : procedimiento para obtener todos los detalles de la venta de servico de gas.
  Autor          : Sincecomp
  Fecha          : 22/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  20-05-2019	 JOSH BRITO			 Se modifica procedimiento para que tenga en cuenta el IVA por concepto de red interna
  ******************************************************************/

  PROCEDURE RfDetalleIVAGasGDC(orfcursor OUT constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfDatoCotizacionGDC
  Descripcion    : procedimiento para obtener datos relacionado con la cotizacion de la venta de servico de gas.
                   para comercia. En caso que imprima para tipo residencial sera NULO
  Autor          : Sincecomp
  Fecha          : 31/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  PROCEDURE RfDatoCotizacionGDC(orfcursor OUT constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfTotalVentaGasGDC
  Descripcion    : procedimiento para obtener el total de IVA y TOTAL A PAGAS de la venta de servico de gas.
  Autor          : Sincecomp
  Fecha          : 31/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  20-05-2019	 JOSH BRITO			 Se modifica procedimiento para que el total en la impresiÃ³n de la
									 factura tenga en cuenta el concepto de IVA por red interna
  ******************************************************************/

  PROCEDURE RfTotalVentaGasGDC(orfcursor OUT constants.tyRefCursor);

---Fin servicios para GDC

END LDC_PKVENTAGAS;

/

create or replace PACKAGE BODY adm_person.LDC_PKVENTAGAS IS

  CSBVERSION CONSTANT VARCHAR2(40) := 'CASO_200_52';

  /*****************************************************************
    Propiedad intelectual de SINCECOMP (c).

    Unidad         : LDC_PKVENTAGAS
    Descripcion    : Paquete creado para formato de venta para las gaseras.
    Autor          : Sincecomp
    Fecha          : 23/03/2016


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

  -- Obtiene la Version actual del Paquete
  FUNCTION FSBVERSION RETURN VARCHAR2 IS
  BEGIN
    return CSBVERSION;
  END FSBVERSION;

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : PBPlantillaNet
  Descripcion    : procedimiento para generar PDF del formato de venta gas.
  Autor          : Sincecomp
  Fecha          : 28/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  PROCEDURE PBPlantillaNet is

    -- Variables:
    clClobData       clob;
    nuConfexmeId     ed_confexme.coemcodi%type; /* Codigo configuracion de extraccion y mezcla (configurado como parametro ) */
    rcTemplate       pktblED_ConfExme.cuEd_Confexme%rowtype; /* Plantilla */
    sbFormatIdent    ed_confexme.coempada%type; /* Identificador del formato */
    nuDigiFormatCode ed_formato.formcodi%type; /* Codigo del formato */
    sbTemplate       ed_confexme.coempadi%type; /* Template */

    cnuNULL_ATTRIBUTE constant number := 2126;

    sbCOEMCODI number;
    sbCOEMDESC varchar2(4000);

    --obtener el codigo del cliente del contrato
    cursor cususcripciongas(isbsesususc servsusc.sesususc%type) is
      select s.suscclie cliente
        from open.suscripc s
       where s.susccodi = isbsesususc
         and rownum = 1;

    rfcususcripciongas cususcripciongas%rowtype;

    --obtener el servicio gas del contrato
    cursor cuserviciogas(isbsesususc servsusc.sesususc%type) is
      select s.sesunuse servicio
        from open.servsusc s
       where s.sesususc = isbsesususc
         and s.sesuserv = 7014
         and rownum = 1;

    rfcuserviciogas cuserviciogas%rowtype;

    --obtener la ultima venta gas asociada al prodcuto
    cursor cuultimaventagas(isbsesunuse servsusc.sesunuse%type) is
      SELECT UNIQUE             A.PRODUCT_ID Prodcuto,
             mp.package_id      Solicitud,
             mp.package_type_id tiposolicitud
        FROM open.or_order o, open.mo_packages mp, open.or_order_activity a
       WHERE o.order_id = a.order_id
         AND a.package_id = mp.package_id
            --AND mp.package_type_id IN (271, 100229, 329, 323)
         AND mp.package_type_id IN
             (select to_number(column_value)
                from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_SOL_VEN_GAS_LDCGFV',
                                                                                                   NULL),
                                                             ',')))
         and mp.request_date =
             (SELECT max(mp.request_date)
                FROM open.or_order          o,
                     open.mo_packages       mp,
                     open.or_order_activity a
               WHERE o.order_id = a.order_id
                 AND a.package_id = mp.package_id
                 AND mp.package_type_id IN
                     (select to_number(column_value)
                        from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_SOL_VEN_GAS_LDCGFV',
                                                                                                           NULL),
                                                                     ',')))
                 AND A.PRODUCT_ID = isbsesunuse
                 and mp.motive_status_id =
                     open.DALD_PARAMETER.fnuGetNumeric_Value('ID_ESTADO_PKG_ATENDTIDO',
                                                             NULL))
            --AND O.TASK_TYPE_ID IN
            --   (12149, 12151, 12154, 12150, 12152, 12153, 10495)
         AND A.PRODUCT_ID = isbsesunuse
         and mp.motive_status_id =
             open.DALD_PARAMETER.fnuGetNumeric_Value('ID_ESTADO_PKG_ATENDTIDO',
                                                     NULL);
    rfcuultimaventagas cuultimaventagas%rowtype;

    --obtener la factura venta gas asociado a la venta del producto
    cursor cufacturaventagas(isbsesunuse  servsusc.sesunuse%type,
                             nupackage_id mo_packages.package_id%type) is
      select cc.cucofact codigo_factura
        from cuencobr cc
       where cc.cucocodi in (SELECT distinct c.cargcuco
                               FROM open.cargos c, concepto
                              WHERE c.cargtipr = 'A'
                                AND c.cargsign IN ('DB', 'CR')
                                AND c.cargdoso LIKE 'PP-' || nupackage_id
                                AND c.cargnuse = isbsesunuse
                                AND c.cargcuco > 0
                                AND conccodi = cargconc)
         and rownum = 1;

    rfcufacturaventagas cufacturaventagas%rowtype;

    sbSUSCCODI ge_boInstanceControl.stysbValue;
    sbSUSCMAIL ge_boInstanceControl.stysbValue;

    cursor CuCotizacion(isbsesunuse servsusc.sesunuse%type,
                        inususcclie suscripc.suscclie%type) is
      SELECT (select f.fopadesc
                from open.formpago f
               where f.fopacodi = a.init_payment_mode
                 and rownum = 1) FORMA_PAGO,
             a.comment_ MOTIVO_VENTA
        FROM cc_quotation a,
             ge_person b,
             (SELECT UNIQUE A.PRODUCT_ID, mp.package_id
                FROM open.or_order          o,
                     open.mo_packages       mp,
                     open.or_order_activity a
               WHERE o.order_id = a.order_id
                 AND a.package_id = mp.package_id
                 AND mp.package_type_id IN
                     (select to_number(column_value)
                        from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_SOL_VEN_GAS_LDCGFV',
                                                                                                           NULL),
                                                                     ',')))
                 and mp.request_date =
                     (SELECT max(mp.request_date)
                        FROM open.or_order          o,
                             open.mo_packages       mp,
                             open.or_order_activity a
                       WHERE o.order_id = a.order_id
                         AND a.package_id = mp.package_id
                         AND mp.package_type_id IN
                             (select to_number(column_value)
                                from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_SOL_VEN_GAS_LDCGFV',
                                                                                                                   NULL),
                                                                             ',')))
                         AND A.PRODUCT_ID = isbsesunuse
                         and mp.motive_status_id =
                             open.DALD_PARAMETER.fnuGetNumeric_Value('ID_ESTADO_PKG_ATENDTIDO',
                                                                     NULL))
                    --AND O.TASK_TYPE_ID IN
                    --   (12149, 12151, 12154, 12150, 12152, 12153, 10495)
                 AND A.PRODUCT_ID = isbsesunuse
                 and mp.motive_status_id =
                     open.DALD_PARAMETER.fnuGetNumeric_Value('ID_ESTADO_PKG_ATENDTIDO',
                                                             NULL)) estacone
       WHERE a.register_person_id = b.person_id
         and a.subscriber_id = inususcclie
         and a.package_id = estacone.package_id
         and rownum = 1;

    rfCuCotizacion CuCotizacion%rowtype;

  BEGIN

    sbSUSCCODI := ge_boInstanceControl.fsbGetFieldValue('SUSCRIPC',
                                                        'SUSCCODI');

    sbSUSCMAIL := ge_boInstanceControl.fsbGetFieldValue('SUSCRIPC',
                                                        'SUSCMAIL');

    UT_TRACE.TRACE('Contrato [' || sbSUSCCODI || ']', 10);

    open cususcripciongas(to_number(sbSUSCCODI));
    fetch cususcripciongas
      into rfcususcripciongas;
    close cususcripciongas;

    if (rfcususcripciongas.cliente is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE,
                      'No tiene codigo de cliente valido');
      raise ex.CONTROLLED_ERROR;
    end if;

    UT_TRACE.TRACE('Cliente [' || rfcususcripciongas.cliente || ']', 10);

    open cuserviciogas(to_number(sbSUSCCODI));
    fetch cuserviciogas
      into rfcuserviciogas;
    close cuserviciogas;

    if (rfcuserviciogas.servicio is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'No tiene servicio de gas valido');
      raise ex.CONTROLLED_ERROR;
    end if;

    UT_TRACE.TRACE('Servicio [' || rfcuserviciogas.servicio || ']', 10);

    --Inicio Obtener Datos de la utlima solicitud venta gas
    open cuultimaventagas(rfcuserviciogas.servicio);
    fetch cuultimaventagas
      into rfcuultimaventagas;
    close cuultimaventagas;
    --Fin Obtener Datos de la utlima solicitud venta gas

    open cufacturaventagas(rfcuserviciogas.servicio,
                           rfcuultimaventagas.solicitud);
    fetch cufacturaventagas
      into rfcufacturaventagas;
    close cufacturaventagas;

    if (rfcufacturaventagas.codigo_factura is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'No tiene factura valido');
      raise ex.CONTROLLED_ERROR;
    end if;

    UT_TRACE.TRACE('Factura [' || rfcufacturaventagas.codigo_factura || ']',
                   10);

    open CuCotizacion(rfcuserviciogas.servicio, rfcususcripciongas.cliente);
    fetch CuCotizacion
      into rfCuCotizacion;
    close CuCotizacion;

    --inicio datos para instanciar al paquete del formato de factura venta
    GE_BOINSTANCECONTROL.ADDGLOBALATTRIBUTE('FACTCODI',
                                            rfcufacturaventagas.codigo_factura);
    GE_BOINSTANCECONTROL.ADDGLOBALATTRIBUTE('SOLICITUD',
                                            rfcuultimaventagas.solicitud);
    GE_BOINSTANCECONTROL.ADDGLOBALATTRIBUTE('TIPOSOLICITUD',
                                            rfcuultimaventagas.tiposolicitud);
    GE_BOINSTANCECONTROL.ADDGLOBALATTRIBUTE('FORMPAGO',
                                            rfCuCotizacion.Forma_Pago);
    GE_BOINSTANCECONTROL.ADDGLOBALATTRIBUTE('MOTIVENT',
                                            rfCuCotizacion.Motivo_Venta);
    GE_BOINSTANCECONTROL.ADDGLOBALATTRIBUTE('SUSCCODI', sbSUSCCODI);
    --fin datos instanciados

    --sbCOEMCODI := '95';
    sbCOEMCODI := open.DALD_PARAMETER.fnuGetNumeric_Value('COD_EXT_MEZ_NET_LDCGFV',
                                                          NULL);
    sbCOEMDESC := 'C';
    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    if (sbCOEMCODI is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE,
                      'Parametro COD_EXT_MEZ_NET_LDCGFV');
      raise ex.CONTROLLED_ERROR;
    end if;

    --Este el el codigo de mi configuracion de extraccion y mezcla
    nuConfexmeId := sbCOEMCODI;

    UT_TRACE.TRACE('Este el el codigo de mi configuracion de extraccion y mezcla - nuConfexmeId --> ' ||
                   nuConfexmeId,
                   10);

    -- Proceso:
    pkBCED_Confexme.ObtieneRegistro(nuConfexmeId, rcTemplate);

    --Obtiene la configuracion de extraccion y mezcla
    sbFormatIdent := rcTemplate.coempada;
    UT_TRACE.TRACE('Obtiene la configuracion de extraccion y mezcla - sbFormatIdent --> ' ||
                   sbFormatIdent,
                   10);

    /* Obtiene el formato */
    nuDigiFormatCode := pkBOInsertMgr.GetCodeFormato(sbFormatIdent);
    UT_TRACE.TRACE('Obtiene el formato - nuDigiFormatCode --> ' ||
                   nuDigiFormatCode,
                   10);

    --  Ejecuta proceso de extraccion de datos, puede retornar datos en texto plano, xml o html
    pkBODataExtractor.ExecuteRules(nuDigiFormatCode, clClobData);

    -- Almancena en memoria el archivo para el proceso de extraccion y mezcla
    --  pkboed_documentmem.Set_PrintDoc(clClobData);

    /* Obtiene el template */
    sbTemplate := rcTemplate.coempadi;
    UT_TRACE.TRACE('Obtiene el template - sbTemplate --> ' || sbTemplate,
                   10);

    -- Almancena en memoria la plantilla para extraccion y mezcla
    --pkboed_documentmem.SetTemplate(sbTemplate);

    -- GE_BOIOpenExecutable.PrintPreviewerRule();

    id_bogeneralprinting.ExportToPDFFromMem(sbSUSCMAIL, --sbCOEMDESC || ':\' /*isbPath*/,
                                            'VENTA_GAS_' || sbSUSCCODI /*isbFileName*/,
                                            sbTemplate,
                                            clClobData);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;

    when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END PBPlantillaNet;

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfDatosVentaGas
  Descripcion    : procedimiento para obtener todos los datos asociados a la venta de servico de gas.
  Autor          : Sincecomp
  Fecha          : 23/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RfDatosVentaGas(orfcursor Out constants.tyRefCursor) IS

    sbFactcodi varchar2(20); --ge_boInstanceControl.stysbValue;

    --/*
    CURSOR cuDatos IS
      SELECT CC.CUCOCODI /*fc.factcodi*/ CODIGO_FACTURA, --2
             To_Char(fc.factfege, 'dd/MON/yyyy') FECHA_EXPEDICION,
             To_Char(cc.cucofeve, 'dd/MON/yyyy') FECHA_VENCIMIENTO,
             dage_subscriber.fsbgetsubscriber_name(b.suscclie) || ' ' ||
             dage_subscriber.fsbgetsubs_last_name(b.suscclie) CLIENTE,
             (CASE
               WHEN (dage_subscriber.fnugetident_type_id(b.suscclie) = 110 OR
                    dage_subscriber.fnugetident_type_id(b.suscclie) = 1) THEN
                dage_subscriber.fsbgetidentification(b.suscclie)
             END) NIT_CLIENTE, -- 26
             dage_subscriber.fsbgetsubscriber_name(dage_subscriber.fnugetcontact_id(b.suscclie,
                                                                                    null),
                                                   null) || ' ' ||
             dage_subscriber.fsbgetsubs_last_name(dage_subscriber.fnugetcontact_id(b.suscclie,
                                                                                   null),
                                                  null) CONTACTO,
             daab_address.fsbgetaddress_parsed(b.susciddi) DIRECCION,
             dage_geogra_location.fsbgetdescription(daab_address.fnugetgeograp_location_id(b.susciddi,
                                                                                           null),
                                                    null) CIUDAD,
             dage_subscriber.fsbgete_mail(b.suscclie) CORREO,
             dage_subscriber.fsbgetphone(b.suscclie) TELEFONO
        FROM open.factura  fc,
             open.cuencobr cc,
             open.suscripc b,
             open.servsusc s
       WHERE fc.factcodi = To_Number(sbFactcodi) --:factura --obtenervalorinstancia('FACTURA','FACTCODI')
         AND fc.factcodi = cc.cucofact
         AND fc.factsusc = b.susccodi
         AND b.susccodi = s.sesususc
         AND cc.cuconuse = s.sesunuse;

    /*
      SELECT
      --Incio Datos Suscriptor
      --Inicio Grilla 1
       fc.factcodi CODIGO_FACTURA,
       To_Char(fc.factfege, 'dd/MON/yyyy') FECHA_EXPEDICION,
       To_Char(cc.cucofeve, 'dd/MON/yyyy') FECHA_VENCIMIENTO,
       --Fin Grilla 1
       --Inicio Grilla 2
       dage_subscriber.fsbgetsubscriber_name(b.suscclie) || ' ' ||
       dage_subscriber.fsbgetsubs_last_name(b.suscclie) CLIENTE,
       dage_subscriber.fsbgetidentification(b.suscclie) NIT_CLIENTE,
       dage_subscriber.fsbgetsubscriber_name(b.suscclie) || ' ' ||
       dage_subscriber.fsbgetsubscriber_name(dage_subscriber.fnugetcontact_id(b.suscclie,
                                                                              null),
                                             null) || ' ' ||
       dage_subscriber.fsbgetsubs_last_name(dage_subscriber.fnugetcontact_id(b.suscclie,
                                                                             null),
                                            null) CONTACTO,
       daab_address.fsbgetaddress_parsed(b.susciddi) DIRECCION,
       --substr(dage_geogra_location.fsbgetdescription(dage_geogra_location.fnugetgeo_loca_father_id(daab_address.fnugetgeograp_location_id(b.susccodi,
       --                                                                                                                                 null),
       --                                                                                        null),
       --                                        null),
       --0,
       --3)
       dage_geogra_location.fsbgetdescription(daab_address.fnugetgeograp_location_id(b.susciddi,null),null) CIUDAD,
       dage_subscriber.fsbgete_mail(b.suscclie) CORREO,
       dage_subscriber.fsbgetphone(b.suscclie) TELEFONO
      --Fin Grilla 2
      --Fin Datos Suscriptor
        FROM open.factura  fc,
             open.cuencobr cc,
             open.suscripc b,
             open.servsusc s
       WHERE fc.factcodi = To_Number(sbFactcodi)
         AND fc.factcodi = cc.cucofact
         AND fc.factsusc = b.susccodi
         AND b.susccodi = s.sesususc
         AND cc.cuconuse = s.sesunuse;
    --*/

    rccuDatos cuDatos%ROWTYPE;
    --*/

    /*
    CURSOR cuDatos IS
      SELECT
      --Incio Datos Suscriptor
      --Inicio Grilla 1
       fc.factcodi CODIGO_FACTURA,
       To_Char(fc.factfege, 'dd/MON/yyyy') FECHA_EXPEDICION,
       To_Char(fc.factfege, 'dd/MON/yyyy') FECHA_VENCIMIENTO,
       --Fin Grilla 1
       --Inicio Grilla 2
       dage_subscriber.fsbgetsubscriber_name(b.suscclie) || ' ' ||
       dage_subscriber.fsbgetsubs_last_name(b.suscclie) CLIENTE,
       dage_subscriber.fsbgetidentification(b.suscclie) NIT_CLIENTE,
       dage_subscriber.fsbgetsubscriber_name(b.suscclie) || ' ' ||
       dage_subscriber.fsbgetsubs_last_name(b.suscclie) CONTACTO,
       daab_address.fsbgetaddress_parsed(b.susciddi) DIRECCION,
       'NO TIENE' CIUDAD,
       dage_subscriber.fsbgete_mail(b.suscclie) CORREO,
       dage_subscriber.fsbgetphone(b.suscclie) TELEFONO
      --Fin Grilla 2
      --Fin Datos Suscriptor
        FROM open.factura  fc,
             open.cuencobr cc,
             open.suscripc b,
             open.servsusc s
       WHERE fc.factcodi = To_Number(sbFactcodi)
         AND fc.factcodi = cc.cucofact
         AND fc.factsusc = b.susccodi
         AND b.susccodi = s.sesususc
         AND cc.cuconuse = s.sesunuse;

    rccuDatos cuDatos%ROWTYPE;
    --*/

    sbSOLICITUD varchar2(15);
    sbSUSCCODI  varchar2(400);
    sbCRM_VR_JLVM_CA_200_52 CONSTANT varchar2(100) := 'CRM_VR_JLVM_CA_200_52';
    nuVALIDAGASERA number := 0;

  BEGIN

    ut_trace.trace('[CASO_200_52] Inicio LDC_PKVENTAGAS.RfDatosVentaGas',
                   10);
    ut_trace.trace('[CASO_200_52] Inicio Proceso Recuperacion Datos Suscriptor',
                   10);
    --Obtiene el codigo de la factura
    --sbFactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');
    --sbFactcodi := ge_boInstanceControl.fsbGetFieldValue('FACTURA',
    --                                                  'FACTCODI');

    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('FACTCODI', sbFactcodi);
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('SOLICITUD', sbsolicitud);
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('SUSCCODI', sbSUSCCODI);

    IF LDC_CONFIGURACIONRQ.aplicaParaGDC(sbCRM_VR_JLVM_CA_200_52) or
       LDC_CONFIGURACIONRQ.aplicaParaEfigas(sbCRM_VR_JLVM_CA_200_52) then
      nuVALIDAGASERA := 1;
    end if;

    ut_trace.trace('[CASO_200_52] Codigo de facutra [' || sbFactcodi ||
                   '] para formato de venta gas',
                   10);

    ut_trace.trace('[CASO_200_52] Solicitud [' || sbsolicitud || ']', 10);

    ut_trace.trace('[CASO_200_52] Contrato [' || sbSUSCCODI || ']', 10);

    --Obtiene los datos principales
    OPEN cuDatos;
    FETCH cuDatos
      INTO rccuDatos;
    CLOSE cuDatos;

    OPEN orfcursor FOR
      SELECT
      /*
      --/*Datos qeumados para probar el formato de venta
      --Incio Datos Suscriptor
      --Inicio Grilla 1
       --To_Char(rccuDatos.Codigo_Factura)
       '1234567' Codigo_Factura,
       --To_Char(rccuDatos.Fecha_Expedicion)
       '28/SEP/2016' Fecha_Expedicion,
       '30/SEP/2016' Fecha_Vencimiento,
       --Fin Grilla 1
       --Inicio Grilla 2
       --To_Char(rccuDatos.Cliente)
       'PRUEBA CUEVA' Cliente,
       --To_Char(rccuDatos.Nit_Cliente)
       '12345678' Nit_Cliente,
       --To_Char(rccuDatos.Contacto)
       'CONTACO' Contacto,
       --To_Char(rccuDatos.Direccion)
       'KR 46 CL 56 - 51 PISO 402' Direccion,
       --To_Char(rccuDatos.Ciudad)
       'no tiene' Ciudad,
       --To_Char(rccuDatos.Correo)
       'notiene@correo.com' Correo,
       --To_Char(rccuDatos.Telefono)
       '5555555' Telefono
      --Fin Grilla 2
      --Fin Datos Suscriptor
      --*/

      --/* Sentencia para obtener los datos y pasarlos para el formato de factura de venta
      --Incio Datos Suscriptor
      --Inicio Grilla 1
      --decode(nuVALIDAGASERA,0,To_Char(rccuDatos.Codigo_Factura),to_number(sbFactcodi)) Codigo_Factura,
       to_number(sbFactcodi) Codigo_Factura,
       decode(nuVALIDAGASERA,
              0,
              to_char(damo_packages.fdtgetattention_date(to_number(sbsolicitud),
                                                         null)),
              To_Char(rccuDatos.Fecha_Expedicion)) Fecha_Expedicion,
       To_Char(rccuDatos.Fecha_Vencimiento) Fecha_Vencimiento,
       --Fin Grilla 1
       --Inicio Grilla 2
       To_Char(rccuDatos.Cliente) Cliente,
       To_Char(rccuDatos.Nit_Cliente) Nit_Cliente,
       decode(nuVALIDAGASERA, 0, sbSUSCCODI, To_Char(rccuDatos.Contacto)) Contacto,
       To_Char(rccuDatos.Direccion) Direccion,
       To_Char(rccuDatos.Ciudad) Ciudad,
       To_Char(rccuDatos.Correo) Correo,
       To_Char(rccuDatos.Telefono) Telefono
      --Fin Grilla 2
      --Fin Datos Suscriptor
      --*/
        FROM dual;

    ut_trace.trace('[CASO_200_52] Fin Consulta Datos a mostrar del Suscriptor',
                   10);
    ut_trace.trace('[CASO_200_52] Fin LDC_PKVENTAGAS.RfDatosVentaGas', 10);

  EXCEPTION
    WHEN OTHERS THEN
      Dbms_Output.Put_Line(SQLERRM);
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END RfDatosVentaGas;

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfDetalleVentaGas
  Descripcion    : procedimiento para obtener todos los detalles de la venta de servico de gas.
  Autor          : Sincecomp
  Fecha          : 22/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  PROCEDURE RfDetalleVentaGas(orfcursor OUT constants.tyRefCursor) IS

    sbFactcodi      varchar2(20); --ge_boInstanceControl.stysbValue;
    sbSOLICITUD     varchar2(15);
    sbTIPOSOLICITUD varchar2(15);
    nucantidad      number;

    CURSOR CUEXISTE(nutiposolicitud number) IS
      SELECT count(1) cantidad
        FROM DUAL
       WHERE nutiposolicitud IN
             (select to_number(column_value)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_SOL_VEN_GAS_SIN_COT_LDCGFV',
                                                                                         NULL),
                                                        ',')));

    --venta de gas sin cotizacion
    --fin venta de gas sin cotizacion en sistema

    --venta de gas con cotizacion
    CURSOR CUCOTIZACION IS
      SELECT (SELECT QUOTATION_ID
                FROM open.cc_quotation qu, open.cargos
               where qu.subscriber_id = b.suscclie
                 and cargos.cargnuse = s.sesunuse
                 and cargos.cargdoso like 'PP-%'
                 and qu.package_id =
                     substr(cargdoso,
                            instr(cargdoso, '-') + 1,
                            length(cargdoso))
                 and qu.status = 'C'
                 and rownum <= 1) QUOTATION_ID
        FROM open.factura  fc,
             open.cuencobr cc,
             open.suscripc b,
             open.servsusc s
       WHERE fc.factcodi = To_Number(sbFactcodi) --:factura --obtenervalorinstancia('FACTURA','FACTCODI')
         AND fc.factcodi = cc.cucofact
         AND fc.factsusc = b.susccodi
         AND b.susccodi = s.sesususc
         AND cc.cuconuse = s.sesunuse;

    rcCUCOTIZACION CUCOTIZACION%ROWTYPE;
    --venta de gas con cotizaciones

    sbCRM_VR_JLVM_CA_200_52 CONSTANT varchar2(100) := 'CRM_VR_JLVM_CA_200_52';
    nuVALIDAGASERA number := 0;

  BEGIN

    ut_trace.trace('[CASO_200_52] Inicio LDC_PKVENTAGAS.RfDetalleVentaGas',
                   10);
    ut_trace.trace('[CASO_200_52] Inicio Obtener Detalles de la Venta Gas',
                   10);

    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('FACTCODI', sbFactcodi);
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('SOLICITUD', sbsolicitud);
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('TIPOSOLICITUD',
                                            sbtiposolicitud);

    --sbFactcodi := 1024056482;

    /*--valida si el tipo de solciitud genera cotizacion en el sistema
    OPEN CUEXISTE(to_number(sbTIPOSOLICITUD));
    FETCH CUEXISTE
      INTO nucantidad;
    CLOSE CUEXISTE;

    --
    --Obtiene los datos principales
    --Venta Gas asociada a una Cotizacion
    if nvl(nucantidad, 0) = 0 then

      OPEN CUCOTIZACION;
      FETCH CUCOTIZACION
        INTO rcCUCOTIZACION;
      CLOSE CUCOTIZACION;

      OPEN orfcursor FOR
        SELECT CO.CONCCODI CODIGO,
               --a.quotation_item_id quotation_item_id,
               --a.items_id||' - '||b.description item,
               co.concdesc CONCEPTO,
               --a.task_type_id||' - '||c.description TASK_TYPE,
               a.items_quantity CANTIDAD,
               --
               Nvl(Decode(Decode(e.liquidation_method,
                                  null,
                                  f.liquidation_method,
                                  e.liquidation_method),
                           3,
                           a.unit_value +
                           (a.unit_value * nvl(d.aui_percentage, 0) / 100),
                           a.unit_value),
                    0)
               --
                VALOR,
               --a.unit_discount_value unit_discount_value,
               --
               Nvl((to_number(decode(decode(e.liquidation_method,
                                             null,
                                             f.liquidation_method,
                                             e.liquidation_method),
                                      3,
                                      a.unit_value +
                                      (a.unit_value *
                                      nvl(d.aui_percentage, 0) / 100),
                                      a.unit_value)) -
                    a.unit_discount_value) * a.items_quantity,
                    0)
               --
                VALOR_TOTAL
          FROM cc_quotation_item a,
               ge_items          b,
               or_task_type      c,
               cc_quotation      d,
               mo_packages       e,
               ps_package_type   f,
               concepto          co
         WHERE a.quotation_id = rcCUCOTIZACION.Quotation_Id --:inuQuotation
           AND a.item_parent IS NULL
           AND a.items_id = b.items_id
           AND a.task_type_id = c.task_type_id
           AND a.quotation_id = d.quotation_id
           AND d.package_id = e.package_id
           AND co.conccodi = b.CONCEPT
           AND e.package_type_id = f.package_type_id;

    else

      --Inicio CA 200-52 Variables
      IF LDC_CONFIGURACIONRQ.aplicaParaGDC(sbCRM_VR_JLVM_CA_200_52) or
        LDC_CONFIGURACIONRQ.aplicaParaEfigas(sbCRM_VR_JLVM_CA_200_52) then
        nuVALIDAGASERA := 1;
      end if;
      --Inicio CA 200-52 Variables

      if nuVALIDAGASERA = 1 then
          --tipo de solicitud que NO genera cortizacion
      */

    OPEN orfcursor FOR
      SELECT CONCEPTO.CONCCODI CODIGO,
             CONCEPTO.CONCDESC CONCEPTO,
             decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1)) CANTIDAD,
             Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) VALOR,
             (Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
             decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1))) VALOR_TOTAL
        FROM open.cargos c, open.concepto, open.cuencobr cc, open.factura f
       WHERE c.cargtipr = 'A'
         AND c.cargsign IN ('DB', 'CR')
         AND c.cargcuco > 0
            --and CONCEPTO.CONCCODI NOT IN
            --  (select to_number(column_value)
            --   from table(open.ldc_boutilities.splitstrings('287', ',')))
            /*
            and (select count(i.clcodesc)
                   from open.ic_clascont i
                  where i.clcocodi IN
                        (select to_number(column_value)
                           from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_CLA_CON_IMP_LDCGFV',
                                                                                                              NULL),
                                                                        ',')))
                    and i.clcocodi = open.CONCEPTO.concclco) = 0
            --*/
         AND conccodi = c.cargconc
         and cc.cucocodi = c.cargcuco
         AND f.factcodi = cc.cucofact
         and f.factcodi = To_Number(sbFactcodi)
         order by CONCEPTO.CONCCODI;
    /*
      else
        --tipo de solicitud que NO genera cortizacion
        --obtiene los detalles con los conceptos de IVA incluyidos
        OPEN orfcursor FOR
          SELECT CONCEPTO.CONCCODI CODIGO,
                 CONCEPTO.CONCDESC CONCEPTO,
                 nvl(C.CARGUNID, 1) CANTIDAD,
                 Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) VALOR,
                 (Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
                 nvl(C.CARGUNID, 1)) VALOR_TOTAL
            FROM open.cargos   c,
                 open.concepto,
                 open.cuencobr cc,
                 open.factura  f
           WHERE c.cargtipr = 'A'
             AND c.cargsign IN ('DB', 'CR')
             AND c.cargcuco > 0
             AND conccodi = c.cargconc
             and cc.cucocodi = c.cargcuco
             AND f.factcodi = cc.cucofact
             and f.factcodi = To_Number(sbFactcodi);
      end if;
    end if;
    --*/

    /*
      SELECT CONCEPTO.CONCCODI CODIGO,
             CONCEPTO.CONCDESC CONCEPTO,
             nvl(C.CARGUNID, 1) CANTIDAD,
             Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) VALOR,
             (Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
             nvl(C.CARGUNID, 1)) VALOR_TOTAL
        FROM open.cargos c, open.concepto, open.cuencobr cc, open.factura f
       WHERE c.cargtipr = 'A'
         AND c.cargsign IN ('DB', 'CR')
         AND c.cargcuco > 0
         and CONCEPTO.CONCCODI NOT IN
             (select to_number(column_value)
                from table(open.ldc_boutilities.splitstrings('287', ',')))
         AND conccodi = c.cargconc
         and cc.cucocodi = c.cargcuco
         AND f.factcodi = cc.cucofact
         and f.factcodi = To_Number(sbFactcodi);
    --*/
    /*
    SELECT
    --Incio Detalle Venta
     To_Char(rccuRef.Codigo) Codigo,
     To_Char(rccuRef.Concepto) Concepto,
     To_Char(rccuRef.Cantidad) Cantidad,
     To_Char(rccuRef.Valor) Valor,
     To_Char(rccuRef.Valor_Total) Valor_Total
    --Fin Detalle Venta
      FROM dual;
      */
    --

    ut_trace.trace('[CASO_200_52] Fin Obtener Detalles de la Venta Gas',
                   10);
    ut_trace.trace('[CASO_200_52] Fin LDC_PKVENTAGAS.RfDetalleVentaGas',
                   10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

  END RfDetalleVentaGas;

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfDatoCotizacion
  Descripcion    : procedimiento para obtener datos relacionado con la cotizacion de la venta de servico de gas.
                   para comercia. En caso que imprima para tipo residencial sera NULO
  Autor          : Sincecomp
  Fecha          : 31/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  PROCEDURE RfDatoCotizacion(orfcursor OUT constants.tyRefCursor) IS

    sbFORMPAGO VARCHAR2(100); --ge_boInstanceControl.stysbValue;
    sbMOTIVENT VARCHAR2(2000); --ge_boInstanceControl.stysbValue;

  BEGIN

    ut_trace.trace('[CASO_200_52] Inicio LDC_PKVENTAGAS.RfDatoCotizacion',
                   10);

    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('FORMPAGO', sbFORMPAGO);
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('MOTIVENT', sbMOTIVENT);

    OPEN orfcursor FOR
      SELECT sbFORMPAGO FORMA_PAGO, substr(sbMOTIVENT, 1, 50) MOTIVO_VENTA
        FROM dual;
    --

    ut_trace.trace('[CASO_200_52] Fin LDC_PKVENTAGAS.RfDatoCotizacion', 10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

  END RfDatoCotizacion;

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfTotalVentaGas
  Descripcion    : procedimiento para obtener el total de IVA y TOTAL A PAGAS de la venta de servico de gas.
  Autor          : Sincecomp
  Fecha          : 31/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  PROCEDURE RfTotalVentaGas(orfcursor OUT constants.tyRefCursor) IS

    sbFactcodi varchar2(20); --ge_boInstanceControl.stysbValue;

    CURSOR CUCOTIZACION IS
      SELECT (SELECT QUOTATION_ID
                FROM open.cc_quotation qu, open.cargos
               where qu.subscriber_id = b.suscclie
                 and cargos.cargnuse = s.sesunuse
                 and cargos.cargdoso like 'PP-%'
                 and qu.package_id =
                     substr(cargdoso,
                            instr(cargdoso, '-') + 1,
                            length(cargdoso))
                 and qu.status = 'C'
                 and rownum <= 1) QUOTATION_ID
        FROM open.factura  fc,
             open.cuencobr cc,
             open.suscripc b,
             open.servsusc s
       WHERE fc.factcodi = To_Number(sbFactcodi) --:factura --obtenervalorinstancia('FACTURA','FACTCODI')
         AND fc.factcodi = cc.cucofact
         AND fc.factsusc = b.susccodi
         AND b.susccodi = s.sesususc
         AND cc.cuconuse = s.sesunuse;

    rcCUCOTIZACION CUCOTIZACION%ROWTYPE;

    orfcursorOrg constants.tyRefCursor;
    INUQUOTATION CC_QUOTATION.QUOTATION_ID%TYPE;
    OCUCURSOR    CONSTANTS.TYREFCURSOR;

    --Datos de la  cotizacion
    CURSOR cuDatoCoti IS
      SELECT a.quotation_id quotation_id,
             a.description description,
             a.register_date register_date,
             a.status || ' - ' || decode(a.status,
                                         'R',
                                         'Registrada',
                                         'A',
                                         'Aprobada',
                                         'N',
                                         'Anulada',
                                         'C',
                                         'Aceptada',
                                         null) status,
             a.register_person_id || ' - ' || b.name_ register_person,
             a.end_date end_date,
             a.initial_payment initial_payment,
             a.total_items_value total_itemsValue,
             a.total_tax_value total_taxValue,
             a.total_disc_value total_discount,
             a.total_aiu_value total_aiu_value,
             a.total_items_value + a.total_tax_value + a.total_aiu_value -
             a.total_disc_value total_value,
             a.pay_modality || ' - ' ||
             decode(a.pay_modality,
                    '1',
                    'Antes de hacer los Trabajos',
                    '2',
                    'Al Finalizar Trabajos',
                    '3',
                    'Segun Avance de Obra',
                    '4',
                    'Sin Cotizacion',
                    null) pay_modality,
             a.comment_ comment_,
             '' parent_id
        FROM cc_quotation a, ge_person b
       where a.status = 'C';

    rccuDatoCoti cuDatoCoti%ROWTYPE;

    CURSOR CUEXISTE(nutiposolicitud number) IS
      SELECT count(1) cantidad
        FROM DUAL
       WHERE nutiposolicitud IN
             (select to_number(column_value)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_SOL_VEN_GAS_SIN_COT_LDCGFV',
                                                                                         NULL),
                                                        ',')));
    nucantidad      number;
    sbTIPOSOLICITUD varchar2(15);

    ---totales venta gas sin cotizacion
    CURSOR cuRefTotalVenta IS
      SELECT SUM(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
                 decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1))) VALOR_TOTAL_PAGAR
        FROM open.cargos c, open.concepto, open.cuencobr cc, open.factura f
       WHERE c.cargtipr = 'A'
         AND c.cargsign IN ('DB', 'CR')
         AND c.cargcuco > 0
            --and CONCEPTO.CONCCODI NOT IN
            --  (select to_number(column_value)
            --   from table(open.ldc_boutilities.splitstrings('287', ',')))
            /*
            and (select count(i.clcodesc)
                   from open.ic_clascont i
                  where i.clcocodi IN
                        (select to_number(column_value)
                           from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_CLA_CON_IMP_LDCGFV',
                                                                                                              NULL),
                                                                        ',')))
                    and i.clcocodi = open.CONCEPTO.concclco) = 0
            --*/
         AND conccodi = c.cargconc
         and cc.cucocodi = c.cargcuco
         AND f.factcodi = cc.cucofact
         and f.factcodi = To_Number(sbFactcodi);

    rccuRefTotalVenta cuRefTotalVenta%ROWTYPE;

    CURSOR cuRefTotalIVAVenta IS
      SELECT SUM(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO)) VALOR_IVA
        FROM open.cargos c, open.concepto, open.cuencobr cc, open.factura f
       WHERE c.cargtipr = 'A'
         AND c.cargsign IN ('DB', 'CR')
         AND c.cargcuco > 0
         and concepto.conccodi IN
             (select to_number(column_value)
                from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_CON_IVA_LDCGFV',
                                                                                                   NULL),
                                                             ',')))
            --and CONCEPTO.CONCCODI IN
            --    (select to_number(column_value)
            --     from table(open.ldc_boutilities.splitstrings('287', ',')))

            /*
            and (select count(i.clcodesc)
                   from open.ic_clascont i
                  where i.clcocodi IN
                        (select to_number(column_value)
                           from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_CLA_CON_IMP_LDCGFV',
                                                                                                              NULL),
                                                                        ',')))
                    and i.clcocodi = open.CONCEPTO.concclco) > 0
            */
         AND conccodi = c.cargconc
         and cc.cucocodi = c.cargcuco
         AND f.factcodi = cc.cucofact
         and f.factcodi = To_Number(sbFactcodi);

    rccuRefTotalIVAVenta cuRefTotalIVAVenta%ROWTYPE;
    ---fin total venta gas sin cotizacion

  BEGIN

    ut_trace.trace('[CASO_200_52] Inicio LDC_PKVENTAGAS.RfTotalVentaGas',
                   10);
    ut_trace.trace('[CASO_200_52] Inicio Obtener Total de la Venta Gas',
                   10);

    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('FACTCODI', sbFactcodi);
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('TIPOSOLICITUD',
                                            sbtiposolicitud);

    --sbFactcodi := 1024056482;

    /*    --valida si el tipo de solciitud genera cotizacion en el sistema
    OPEN CUEXISTE(to_number(sbTIPOSOLICITUD));
    FETCH CUEXISTE
      INTO nucantidad;
    CLOSE CUEXISTE;

    --
    --Obtiene los datos principales
    --Venta Gas asociada a una Cotizacion
    if nvl(nucantidad, 0) = 0 then

      --sbFactcodi := 1024056482;

      --Obtiene los datos principales
      OPEN CUCOTIZACION;
      FETCH CUCOTIZACION
        INTO rcCUCOTIZACION;
      CLOSE CUCOTIZACION;

      --Obtiene el codigo de cotizacion de la consulta principal
      INUQUOTATION := rcCUCOTIZACION.Quotation_Id;

      --LLamado al servicio que obtiene los datos de la cotizacion
      cc_boOssQuotations.GetQuotation(INUQUOTATION, OCUCURSOR);

      orfcursorOrg := OCUCURSOR;

      --Obtiene los datos del servicio de cotizacion
      --\*
      LOOP
        FETCH orfcursorOrg
          INTO rccuDatoCoti;
        EXIT WHEN orfcursorOrg%NOTFOUND;
        --INUQUOTATION := rccuDatoCoti.QUOTATION_ID;
        --DBMS_OUTPUT.PUT_LINE(' rccuDatoCoti.QUOTATION_ID  '||rccuDatoCoti.QUOTATION_ID);
      END LOOP;
      --*\
      OPEN orfcursor FOR
        SELECT Nvl(rccuDatoCoti.total_taxValue, 0) Valor_Iva,
               Nvl(rccuDatoCoti.total_value, 0) Valor_Total_Pagar
          FROM dual;
    else*/
    --Obtiene los datos principales
    OPEN cuRefTotalVenta;
    FETCH cuRefTotalVenta
      INTO rccuRefTotalVenta;
    CLOSE cuRefTotalVenta;

    OPEN cuRefTotalIVAVenta;
    FETCH cuRefTotalIVAVenta
      INTO rccuRefTotalIVAVenta;
    CLOSE cuRefTotalIVAVenta;

    OPEN orfcursor FOR
      SELECT nvl(rccuRefTotalIVAVenta.Valor_Iva, 0) Valor_Iva,
             --(nvl(rccuRefTotalVenta.Valor_Total_Pagar, 0) +
             --nvl(rccuRefTotalIVAVenta.Valor_Iva, 0))
             nvl(rccuRefTotalVenta.Valor_Total_Pagar, 0) Valor_Total_Pagar
        FROM dual;
    --end if;

    ut_trace.trace('[CASO_200_52] Fin Obtener Total de la Venta Gas', 10);
    ut_trace.trace('[CASO_200_52] Fin LDC_PKVENTAGAS.RfTotalVentaGas', 10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

  END RfTotalVentaGas;

  ---Inicio servicios para GDC

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfDatosVentaGasGDC
  Descripcion    : procedimiento para obtener todos los datos asociados a la venta de servico de gas.
  Autor          : Sincecomp
  Fecha          : 23/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RfDatosVentaGasGDC(orfcursor Out constants.tyRefCursor) IS

    sbFactcodi varchar2(20); --ge_boInstanceControl.stysbValue;

    --/*
    CURSOR cuDatos IS
      SELECT fc.factnufi CODIGO_FACTURA, --2
             To_Char(fc.factfege, 'dd/MON/yyyy') FECHA_EXPEDICION,
             To_Char(cc.cucofeve, 'dd/MON/yyyy') FECHA_VENCIMIENTO,
             dage_subscriber.fsbgetsubscriber_name(b.suscclie) || ' ' ||
             dage_subscriber.fsbgetsubs_last_name(b.suscclie) CLIENTE,
             (CASE
               WHEN (dage_subscriber.fnugetident_type_id(b.suscclie) = 110 OR
                    dage_subscriber.fnugetident_type_id(b.suscclie) = 1) THEN
                dage_subscriber.fsbgetidentification(b.suscclie)
             END) NIT_CLIENTE, -- 26
             dage_subscriber.fsbgetsubscriber_name(dage_subscriber.fnugetcontact_id(b.suscclie,
                                                                                    null),
                                                   null) || ' ' ||
             dage_subscriber.fsbgetsubs_last_name(dage_subscriber.fnugetcontact_id(b.suscclie,
                                                                                   null),
                                                  null) CONTACTO,
             daab_address.fsbgetaddress_parsed(b.susciddi) DIRECCION,
             dage_geogra_location.fsbgetdescription(daab_address.fnugetgeograp_location_id(b.susciddi,
                                                                                           null),
                                                    null) CIUDAD,
             dage_subscriber.fsbgete_mail(b.suscclie) CORREO,
             dage_subscriber.fsbgetphone(b.suscclie) TELEFONO
        FROM open.factura  fc,
             open.cuencobr cc,
             open.suscripc b,
             open.servsusc s
       WHERE fc.factcodi = To_Number(sbFactcodi) --:factura --obtenervalorinstancia('FACTURA','FACTCODI')
         AND fc.factcodi = cc.cucofact
         AND fc.factsusc = b.susccodi
         AND b.susccodi = s.sesususc
         AND cc.cuconuse = s.sesunuse;

    rccuDatos cuDatos%ROWTYPE;

    sbSOLICITUD varchar2(15);
    sbSUSCCODI  varchar2(400);
    sbCRM_VR_JLVM_CA_200_52 CONSTANT varchar2(100) := 'CRM_VR_JLVM_CA_200_52';
    nuVALIDAGASERA number := 0;

  BEGIN

    ut_trace.trace('[CASO_200_52] Inicio LDC_PKVENTAGAS.RfDatosVentaGasGDC',
                   10);
    ut_trace.trace('[CASO_200_52] Inicio Proceso Recuperacion Datos Suscriptor',
                   10);
    --Obtiene el codigo de la factura
    --sbFactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');
    --sbFactcodi := ge_boInstanceControl.fsbGetFieldValue('FACTURA',
    --                                                  'FACTCODI');

    --/*
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('FACTCODI', sbFactcodi);
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('SOLICITUD', sbsolicitud);
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('SUSCCODI', sbSUSCCODI);
    --*/

    IF LDC_CONFIGURACIONRQ.aplicaParaGDC(sbCRM_VR_JLVM_CA_200_52) or
       LDC_CONFIGURACIONRQ.aplicaParaEfigas(sbCRM_VR_JLVM_CA_200_52) then
      nuVALIDAGASERA := 1;
    end if;

    ut_trace.trace('[CASO_200_52] Codigo de facutra [' || sbFactcodi ||
                   '] para formato de venta gas',
                   10);

    ut_trace.trace('[CASO_200_52] Solicitud [' || sbsolicitud || ']', 10);

    ut_trace.trace('[CASO_200_52] Contrato [' || sbSUSCCODI || ']', 10);

    --Obtiene los datos principales
    OPEN cuDatos;
    FETCH cuDatos
      INTO rccuDatos;
    CLOSE cuDatos;

    OPEN orfcursor FOR
      SELECT
      /*
      --/*Datos qeumados para probar el formato de venta
      --Incio Datos Suscriptor
      --Inicio Grilla 1
       --To_Char(rccuDatos.Codigo_Factura)
       '1234567' Codigo_Factura,
       --To_Char(rccuDatos.Fecha_Expedicion)
       '28/SEP/2016' Fecha_Expedicion,
       '30/SEP/2016' Fecha_Vencimiento,
       --Fin Grilla 1
       --Inicio Grilla 2
       --To_Char(rccuDatos.Cliente)
       'PRUEBA CUEVA' Cliente,
       --To_Char(rccuDatos.Nit_Cliente)
       '12345678' Nit_Cliente,
       --To_Char(rccuDatos.Contacto)
       'CONTACO' Contacto,
       --To_Char(rccuDatos.Direccion)
       'KR 46 CL 56 - 51 PISO 402' Direccion,
       --To_Char(rccuDatos.Ciudad)
       'no tiene' Ciudad,
       --To_Char(rccuDatos.Correo)
       'notiene@correo.com' Correo,
       --To_Char(rccuDatos.Telefono)
       '5555555' Telefono
      --Fin Grilla 2
      --Fin Datos Suscriptor
      --*/

      --/* Sentencia para obtener los datos y pasarlos para el formato de factura de venta
      --Incio Datos Suscriptor
      --Inicio Grilla 1
      --decode(nuVALIDAGASERA,0,To_Char(rccuDatos.Codigo_Factura),to_number(sbFactcodi)) Codigo_Factura,
       rccuDatos.Codigo_Factura Codigo_Factura,
       decode(nuVALIDAGASERA,
              0,
              to_char(damo_packages.fdtgetattention_date(to_number(sbsolicitud),
                                                         null)),
              To_Char(rccuDatos.Fecha_Expedicion)) Fecha_Expedicion,
       To_Char(rccuDatos.Fecha_Vencimiento) Fecha_Vencimiento,
       --Fin Grilla 1
       --Inicio Grilla 2
       To_Char(rccuDatos.Cliente) Cliente,
       To_Char(rccuDatos.Nit_Cliente) Nit_Cliente,
       decode(nuVALIDAGASERA, 0, sbSUSCCODI, To_Char(rccuDatos.Contacto)) Contacto,
       To_Char(rccuDatos.Direccion) Direccion,
       To_Char(rccuDatos.Ciudad) Ciudad,
       To_Char(rccuDatos.Correo) Correo,
       To_Char(rccuDatos.Telefono) Telefono
      --Fin Grilla 2
      --Fin Datos Suscriptor
      --*/
        FROM dual;

    ut_trace.trace('[CASO_200_52] Fin Consulta Datos a mostrar del Suscriptor',
                   10);
    ut_trace.trace('[CASO_200_52] Fin LDC_PKVENTAGAS.RfDatosVentaGasGDC',
                   10);

  EXCEPTION
    WHEN OTHERS THEN
      Dbms_Output.Put_Line(SQLERRM);
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END RfDatosVentaGasGDC;

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfDetalleNoIVAGasGDC
  Descripcion    : procedimiento para obtener todos los detalles de la venta de servico de gas.
  Autor          : Sincecomp
  Fecha          : 22/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/

  PROCEDURE RfDetalleNoIVAGasGDC(orfcursor OUT constants.tyRefCursor) IS

    sbFactcodi      varchar2(20); --ge_boInstanceControl.stysbValue;
    sbSOLICITUD     varchar2(15);
    sbTIPOSOLICITUD varchar2(15);
    nucantidad      number;

    CURSOR CUEXISTE(nutiposolicitud number) IS
      SELECT count(1) cantidad
        FROM DUAL
       WHERE nutiposolicitud IN
             (select to_number(column_value)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_SOL_VEN_GAS_SIN_COT_LDCGFV',
                                                                                         NULL),
                                                        ',')));

    --venta de gas sin cotizacion
    --fin venta de gas sin cotizacion en sistema

    --venta de gas con cotizacion
    CURSOR CUCOTIZACION IS
      SELECT (SELECT QUOTATION_ID
                FROM open.cc_quotation qu, open.cargos
               where qu.subscriber_id = b.suscclie
                 and cargos.cargnuse = s.sesunuse
                 and cargos.cargdoso like 'PP-%'
                 and qu.package_id =
                     substr(cargdoso,
                            instr(cargdoso, '-') + 1,
                            length(cargdoso))
                 and qu.status = 'C'
                 and rownum <= 1) QUOTATION_ID
        FROM open.factura  fc,
             open.cuencobr cc,
             open.suscripc b,
             open.servsusc s
       WHERE fc.factcodi = To_Number(sbFactcodi) --:factura --obtenervalorinstancia('FACTURA','FACTCODI')
         AND fc.factcodi = cc.cucofact
         AND fc.factsusc = b.susccodi
         AND b.susccodi = s.sesususc
         AND cc.cuconuse = s.sesunuse;

    rcCUCOTIZACION CUCOTIZACION%ROWTYPE;
    --venta de gas con cotizaciones

    sbCRM_VR_JLVM_CA_200_52 CONSTANT varchar2(100) := 'CRM_VR_JLVM_CA_200_52';
    nuVALIDAGASERA number := 0;

  BEGIN

    ut_trace.trace('[CASO_200_52] Inicio LDC_PKVENTAGAS.RfDetalleNoIVAGasGDC',
                   10);
    ut_trace.trace('[CASO_200_52] Inicio Obtener Detalles de la Venta Gas',
                   10);

    --/*
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('FACTCODI', sbFactcodi);
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('SOLICITUD', sbsolicitud);
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('TIPOSOLICITUD',
                                            sbtiposolicitud);
    --*/

    OPEN orfcursor FOR
      SELECT CONCEPTO.CONCCODI CODIGO,
             CONCEPTO.CONCDESC CONCEPTO,
             decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1)) CANTIDAD,
             Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) VALOR,
             (Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
             decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1))) VALOR_TOTAL
        FROM open.cargos c, open.concepto, open.cuencobr cc, open.factura f
       WHERE c.cargtipr = 'A'
         AND c.cargsign IN ('DB', 'CR')
         AND c.cargcuco > 0
         and concepto.conccodi NOT IN
             (select to_number(column_value)
                from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_CON_IVA_LDCGFV',
                                                                                                   NULL),
                                                             ',')))
            --and CONCEPTO.CONCCODI NOT IN
            --  (select to_number(column_value)
            --   from table(open.ldc_boutilities.splitstrings('287', ',')))
            /*
            and (select count(i.clcodesc)
                   from open.ic_clascont i
                  where i.clcocodi IN
                        (select to_number(column_value)
                           from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_CLA_CON_IMP_LDCGFV',
                                                                                                              NULL),
                                                                        ',')))
                    and i.clcocodi = open.CONCEPTO.concclco) = 0
            --*/
         AND conccodi = c.cargconc
         and cc.cucocodi = c.cargcuco
         AND f.factcodi = cc.cucofact
         and f.factcodi = To_Number(sbFactcodi);

    ut_trace.trace('[CASO_200_52] Fin Obtener Detalles de la Venta Gas',
                   10);
    ut_trace.trace('[CASO_200_52] Fin LDC_PKVENTAGAS.RfDetalleNoIVAGasGDC',
                   10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

  END RfDetalleNoIVAGasGDC;

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfDetalleIVAGasGDC
  Descripcion    : procedimiento para obtener todos los detalles de la venta de servico de gas.
  Autor          : Sincecomp
  Fecha          : 22/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  20-05-2019	 JOSH BRITO			 Se modifica procedimiento para que tenga en cuenta el IVA por concepto de red interna
  ******************************************************************/

  PROCEDURE RfDetalleIVAGasGDC(orfcursor OUT constants.tyRefCursor) IS

    sbFactcodi      varchar2(20); --ge_boInstanceControl.stysbValue;
    sbSOLICITUD     varchar2(15);
    sbTIPOSOLICITUD varchar2(15);
    nucantidad      number;

    CURSOR CUEXISTE(nutiposolicitud number) IS
      SELECT count(1) cantidad
        FROM DUAL
       WHERE nutiposolicitud IN
             (select to_number(column_value)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_SOL_VEN_GAS_SIN_COT_LDCGFV',
                                                                                         NULL),
                                                        ',')));

    --venta de gas sin cotizacion
    --fin venta de gas sin cotizacion en sistema

    --venta de gas con cotizacion
    CURSOR CUCOTIZACION IS
      SELECT (SELECT QUOTATION_ID
                FROM open.cc_quotation qu, open.cargos
               where qu.subscriber_id = b.suscclie
                 and cargos.cargnuse = s.sesunuse
                 and cargos.cargdoso like 'PP-%'
                 and qu.package_id =
                     substr(cargdoso,
                            instr(cargdoso, '-') + 1,
                            length(cargdoso))
                 and qu.status = 'C'
                 and rownum <= 1) QUOTATION_ID
        FROM open.factura  fc,
             open.cuencobr cc,
             open.suscripc b,
             open.servsusc s
       WHERE fc.factcodi = To_Number(sbFactcodi) --:factura --obtenervalorinstancia('FACTURA','FACTCODI')
         AND fc.factcodi = cc.cucofact
         AND fc.factsusc = b.susccodi
         AND b.susccodi = s.sesususc
         AND cc.cuconuse = s.sesunuse;

    rcCUCOTIZACION CUCOTIZACION%ROWTYPE;
    --venta de gas con cotizaciones

    sbCRM_VR_JLVM_CA_200_52 CONSTANT varchar2(100) := 'CRM_VR_JLVM_CA_200_52';
    nuVALIDAGASERA number := 0;

  BEGIN

    ut_trace.trace('[CASO_200_52] Inicio LDC_PKVENTAGAS.RfDetalleIVAGasGDC',
                   10);
    ut_trace.trace('[CASO_200_52] Inicio Obtener Detalles de la Venta Gas',
                   10);

    --/*
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('FACTCODI', sbFactcodi);
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('SOLICITUD', sbsolicitud);
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('TIPOSOLICITUD',
                                            sbtiposolicitud);
    --*/

    --sbFactcodi := 1024056482;

    OPEN orfcursor FOR
      SELECT open.DALD_PARAMETER.fnuGetNumeric_Value('CON_INT_RED_INT_IVA_OBR_CIV_2',
                                                     NULL) CODIGO,
             (select c1.concdesc
                from concepto c1
               where c1.conccodi in
                     open.DALD_PARAMETER.fnuGetNumeric_Value('CON_INT_RED_INT_IVA_OBR_CIV_2',
                                                             NULL)) CONCEPTO,
             decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1)) CANTIDAD,
             round((Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) /
                   nvl(open.DALD_PARAMETER.fnuGetNumeric_Value('VAL_DIV_LDCGFV',
                                                                NULL),
                        1)),
                   0) VALOR,
             round(((Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) /
                   nvl(open.DALD_PARAMETER.fnuGetNumeric_Value('VAL_DIV_LDCGFV',
                                                                 NULL),
                         1)) * nvl(open.DALD_PARAMETER.fnuGetNumeric_Value('VAL_IVA_LDCGFV',
                                                                            NULL),
                                    0)),
                   0) VALOR_TOTAL
        FROM open.cargos c, open.concepto, open.cuencobr cc, open.factura f
       WHERE c.cargtipr = 'A'
         AND c.cargsign IN ('DB', 'CR')
         AND c.cargcuco > 0
		 --CA 200-2635
         and concepto.conccodi IN (select to_number(column_value)
                        from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('CON_INT_RED_INT_IVA_OBR_CIV_1',
                                                                                                           NULL),
                                                                     ',')))
            /* open.DALD_PARAMETER.fnuGetNumeric_Value('CON_INT_RED_INT_IVA_OBR_CIV_1',
                                                     NULL)*/
         AND conccodi = c.cargconc
         and cc.cucocodi = c.cargcuco
         AND f.factcodi = cc.cucofact
         and f.factcodi = To_Number(sbFactcodi)
      UNION ALL
      SELECT open.DALD_PARAMETER.fnuGetNumeric_Value('CER_INT_PRE_IVA_SER_VAR_2',
                                                     NULL) CODIGO,
             (select c1.concdesc
                from concepto c1
               where c1.conccodi in
                     open.DALD_PARAMETER.fnuGetNumeric_Value('CER_INT_PRE_IVA_SER_VAR_2',
                                                             NULL)) CONCEPTO,
             decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1)) CANTIDAD,
             Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) VALOR,
             round((Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
                   nvl(open.DALD_PARAMETER.fnuGetNumeric_Value('VAL_IVA_LDCGFV',
                                                                NULL),
                        0)),
                   0) VALOR_TOTAL
        FROM open.cargos c, open.concepto, open.cuencobr cc, open.factura f
       WHERE c.cargtipr = 'A'
         AND c.cargsign IN ('DB', 'CR')
         AND c.cargcuco > 0
         and concepto.conccodi IN
             open.DALD_PARAMETER.fnuGetNumeric_Value('CER_INT_PRE_IVA_SER_VAR_1',
                                                     NULL)
         AND conccodi = c.cargconc
         and cc.cucocodi = c.cargcuco
         AND f.factcodi = cc.cucofact
         and f.factcodi = To_Number(sbFactcodi)
      UNION ALL
      SELECT CONCEPTO.CONCCODI CODIGO,
             CONCEPTO.CONCDESC CONCEPTO,
             decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1)) CANTIDAD,
             Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) VALOR,
             (Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
             decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1))) VALOR_TOTAL
        FROM open.cargos c, open.concepto, open.cuencobr cc, open.factura f
       WHERE c.cargtipr = 'A'
         AND c.cargsign IN ('DB', 'CR')
         AND c.cargcuco > 0
         and concepto.conccodi IN
             (select to_number(column_value)
                from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_CON_IVA_LDCGFV',
                                                                                                   NULL),
                                                             ',')))
         and concepto.conccodi not IN (nvl(open.DALD_PARAMETER.fnuGetNumeric_Value('CER_INT_PRE_IVA_SER_VAR_2',
                                                                                   NULL),
                                           0),
                                       nvl(open.DALD_PARAMETER.fnuGetNumeric_Value('CON_INT_RED_INT_IVA_OBR_CIV_2',
                                                                                   NULL),
                                           0))
         AND conccodi = c.cargconc
         and cc.cucocodi = c.cargcuco
         AND f.factcodi = cc.cucofact
         and f.factcodi = To_Number(sbFactcodi);
    /*SELECT CONCEPTO.CONCCODI CODIGO,
          CONCEPTO.CONCDESC CONCEPTO,
          decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1)) CANTIDAD,
          Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) VALOR,
          (Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
          decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1))) VALOR_TOTAL
     FROM open.cargos c, open.concepto, open.cuencobr cc, open.factura f
    WHERE c.cargtipr = 'A'
      AND c.cargsign IN ('DB', 'CR')
      AND c.cargcuco > 0
      and concepto.conccodi IN
          (select to_number(column_value)
             from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_CON_IVA_LDCGFV',
                                                                                                NULL),
                                                          ',')))
         --and CONCEPTO.CONCCODI NOT IN
         --  (select to_number(column_value)
         --   from table(open.ldc_boutilities.splitstrings('287', ',')))
         \*
         and (select count(i.clcodesc)
                from open.ic_clascont i
               where i.clcocodi IN
                     (select to_number(column_value)
                        from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_CLA_CON_IMP_LDCGFV',
                                                                                                           NULL),
                                                                     ',')))
                 and i.clcocodi = open.CONCEPTO.concclco) = 0
         --*\
      AND conccodi = c.cargconc
      and cc.cucocodi = c.cargcuco
      AND f.factcodi = cc.cucofact
      and f.factcodi = To_Number(sbFactcodi);*/

    ut_trace.trace('[CASO_200_52] Fin Obtener Detalles de la Venta Gas',
                   10);
    ut_trace.trace('[CASO_200_52] Fin LDC_PKVENTAGAS.RfDetalleIVAGasGDC',
                   10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

  END RfDetalleIVAGasGDC;

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfDatoCotizacionGDC
  Descripcion    : procedimiento para obtener datos relacionado con la cotizacion de la venta de servico de gas.
                   para comercia. En caso que imprima para tipo residencial sera NULO
  Autor          : Sincecomp
  Fecha          : 31/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  PROCEDURE RfDatoCotizacionGDC(orfcursor OUT constants.tyRefCursor) IS

    sbFORMPAGO VARCHAR2(100); --ge_boInstanceControl.stysbValue;
    sbMOTIVENT VARCHAR2(2000); --ge_boInstanceControl.stysbValue;

  BEGIN

    ut_trace.trace('[CASO_200_52] Inicio LDC_PKVENTAGAS.RfDatoCotizacionGDC',
                   10);

    --/*
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('FORMPAGO', sbFORMPAGO);
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('MOTIVENT', sbMOTIVENT);
    --*/

    OPEN orfcursor FOR
      SELECT sbFORMPAGO FORMA_PAGO, substr(sbMOTIVENT, 1, 50) MOTIVO_VENTA
        FROM dual;
    --

    ut_trace.trace('[CASO_200_52] Fin LDC_PKVENTAGAS.RfDatoCotizacionGDC',
                   10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

  END RfDatoCotizacionGDC;

  /*****************************************************************
  Propiedad intelectual de Sincecomp (c).

  Unidad         : RfTotalVentaGasGDC
  Descripcion    : procedimiento para obtener el total de IVA y TOTAL A PAGAS de la venta de servico de gas.
  Autor          : Sincecomp
  Fecha          : 31/03/2016

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  20-05-2019	 JOSH BRITO			Se modifica procedimiento para que el total en la impresiÃ³n de la
									            factura tenga en cuenta el concepto de IVA por red interna
  ******************************************************************/

  PROCEDURE RfTotalVentaGasGDC(orfcursor OUT constants.tyRefCursor) IS

    sbFactcodi varchar2(20); --ge_boInstanceControl.stysbValue;

    CURSOR CUCOTIZACION IS
      SELECT (SELECT QUOTATION_ID
                FROM open.cc_quotation qu, open.cargos
               where qu.subscriber_id = b.suscclie
                 and cargos.cargnuse = s.sesunuse
                 and cargos.cargdoso like 'PP-%'
                 and qu.package_id =
                     substr(cargdoso,
                            instr(cargdoso, '-') + 1,
                            length(cargdoso))
                 and qu.status = 'C'
                 and rownum <= 1) QUOTATION_ID
        FROM open.factura  fc,
             open.cuencobr cc,
             open.suscripc b,
             open.servsusc s
       WHERE fc.factcodi = To_Number(sbFactcodi) --:factura --obtenervalorinstancia('FACTURA','FACTCODI')
         AND fc.factcodi = cc.cucofact
         AND fc.factsusc = b.susccodi
         AND b.susccodi = s.sesususc
         AND cc.cuconuse = s.sesunuse;

    rcCUCOTIZACION CUCOTIZACION%ROWTYPE;

    orfcursorOrg constants.tyRefCursor;
    INUQUOTATION CC_QUOTATION.QUOTATION_ID%TYPE;
    OCUCURSOR    CONSTANTS.TYREFCURSOR;

    --Datos de la  cotizacion
    CURSOR cuDatoCoti IS
      SELECT a.quotation_id quotation_id,
             a.description description,
             a.register_date register_date,
             a.status || ' - ' || decode(a.status,
                                         'R',
                                         'Registrada',
                                         'A',
                                         'Aprobada',
                                         'N',
                                         'Anulada',
                                         'C',
                                         'Aceptada',
                                         null) status,
             a.register_person_id || ' - ' || b.name_ register_person,
             a.end_date end_date,
             a.initial_payment initial_payment,
             a.total_items_value total_itemsValue,
             a.total_tax_value total_taxValue,
             a.total_disc_value total_discount,
             a.total_aiu_value total_aiu_value,
             a.total_items_value + a.total_tax_value + a.total_aiu_value -
             a.total_disc_value total_value,
             a.pay_modality || ' - ' ||
             decode(a.pay_modality,
                    '1',
                    'Antes de hacer los Trabajos',
                    '2',
                    'Al Finalizar Trabajos',
                    '3',
                    'Segun Avance de Obra',
                    '4',
                    'Sin Cotizacion',
                    null) pay_modality,
             a.comment_ comment_,
             '' parent_id
        FROM cc_quotation a, ge_person b
       where a.status = 'C';

    rccuDatoCoti cuDatoCoti%ROWTYPE;

    CURSOR CUEXISTE(nutiposolicitud number) IS
      SELECT count(1) cantidad
        FROM DUAL
       WHERE nutiposolicitud IN
             (select to_number(column_value)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_SOL_VEN_GAS_SIN_COT_LDCGFV',
                                                                                         NULL),
                                                        ',')));
    nucantidad      number;
    sbTIPOSOLICITUD varchar2(15);

    ---totales venta gas sin cotizacion
    CURSOR cuRefTotalVenta IS
      SELECT SUM(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
                 decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1))) VALOR_TOTAL_PAGAR
        FROM open.cargos c, open.concepto, open.cuencobr cc, open.factura f
       WHERE c.cargtipr = 'A'
         AND c.cargsign IN ('DB', 'CR')
         AND c.cargcuco > 0
         and concepto.conccodi NOT IN
             (select to_number(column_value)
                from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_CON_IVA_LDCGFV',
                                                                                                   NULL),
                                                             ',')))
         and concepto.conccodi not IN (nvl(open.DALD_PARAMETER.fnuGetNumeric_Value('CER_INT_PRE_IVA_SER_VAR_2',
                                                                                   NULL),
                                           0),
                                       nvl(open.DALD_PARAMETER.fnuGetNumeric_Value('CON_INT_RED_INT_IVA_OBR_CIV_2',
                                                                                   NULL),
                                           0))
            --and CONCEPTO.CONCCODI NOT IN
            --  (select to_number(column_value)
            --   from table(open.ldc_boutilities.splitstrings('287', ',')))
            /*
            and (select count(i.clcodesc)
                   from open.ic_clascont i
                  where i.clcocodi IN
                        (select to_number(column_value)
                           from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_CLA_CON_IMP_LDCGFV',
                                                                                                              NULL),
                                                                        ',')))
                    and i.clcocodi = open.CONCEPTO.concclco) = 0
            --*/
         AND conccodi = c.cargconc
         and cc.cucocodi = c.cargcuco
         AND f.factcodi = cc.cucofact
         and f.factcodi = To_Number(sbFactcodi);

    rccuRefTotalVenta cuRefTotalVenta%ROWTYPE;

    CURSOR cuRefTotalIVAVenta IS
      select nvl((SELECT round(((Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) /
                          nvl(open.DALD_PARAMETER.fnuGetNumeric_Value('VAL_DIV_LDCGFV',
                                                                        NULL),
                                1)) * nvl(open.DALD_PARAMETER.fnuGetNumeric_Value('VAL_IVA_LDCGFV',
                                                                                    NULL),
                                            0)),
                          0) VALOR_IVA
                    FROM open.cargos   c,
                        open.concepto,
                        open.cuencobr cc,
                        open.factura  f
                  WHERE c.cargtipr = 'A'
                    AND c.cargsign IN ('DB', 'CR')
                    AND c.cargcuco > 0
                    and concepto.conccodi IN
                        (select to_number(column_value)
                            from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('CON_INT_RED_INT_IVA_OBR_CIV_1',
                                                                                                              NULL),
                                                                        ',')))
                    AND conccodi = c.cargconc
                    and cc.cucocodi = c.cargcuco
                    AND f.factcodi = cc.cucofact
                    and f.factcodi = To_Number(sbFactcodi)),0)
            --
            + -- OSF-401 
            --
            nvl((SELECT round((Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
                          nvl(open.DALD_PARAMETER.fnuGetNumeric_Value('VAL_IVA_LDCGFV',
                                                                        NULL),
                                0)),
                          0) VALOR_IVA
                    FROM open.cargos   c,
                        open.concepto,
                        open.cuencobr cc,
                        open.factura  f
                  WHERE c.cargtipr = 'A'
                    AND c.cargsign IN ('DB', 'CR')
                    AND c.cargcuco > 0
                    and concepto.conccodi IN
                        open.DALD_PARAMETER.fnuGetNumeric_Value('CER_INT_PRE_IVA_SER_VAR_1',
                                                                NULL)
                    AND conccodi = c.cargconc
                    and cc.cucocodi = c.cargcuco
                    AND f.factcodi = cc.cucofact
                    and f.factcodi = To_Number(sbFactcodi)),0)
            --
            + -- OSF-401 
            --
            nvl((SELECT SUM(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO)) VALOR_IVA
                    FROM open.cargos   c,
                        open.concepto,
                        open.cuencobr cc,
                        open.factura  f
                  WHERE c.cargtipr = 'A'
                    AND c.cargsign IN ('DB', 'CR')
                    AND c.cargcuco > 0
                    and concepto.conccodi IN
                        (select to_number(column_value)
                            from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_CON_IVA_LDCGFV',
                                                                                                              NULL),
                                                                        ',')))
                    and concepto.conccodi not IN (nvl(open.DALD_PARAMETER.fnuGetNumeric_Value('CER_INT_PRE_IVA_SER_VAR_2',
                                                                                              NULL),
                                                      0),
                                                  nvl(open.DALD_PARAMETER.fnuGetNumeric_Value('CON_INT_RED_INT_IVA_OBR_CIV_2',
                                                                                              NULL),
                                                      0))
                    AND conccodi = c.cargconc
                    and cc.cucocodi = c.cargcuco
                    AND f.factcodi = cc.cucofact
                    and f.factcodi = To_Number(sbFactcodi)),0) VALOR_IVA
        -- OSF-401 
        from dual;

    /*SELECT SUM(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO)) VALOR_IVA
     FROM open.cargos c, open.concepto, open.cuencobr cc, open.factura f
    WHERE c.cargtipr = 'A'
      AND c.cargsign IN ('DB', 'CR')
      AND c.cargcuco > 0
      and concepto.conccodi IN
          (select to_number(column_value)
             from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_CON_IVA_LDCGFV',
                                                                                                NULL),
                                                          ',')))
         --and CONCEPTO.CONCCODI IN
         --    (select to_number(column_value)
         --     from table(open.ldc_boutilities.splitstrings('287', ',')))

         \*
         and (select count(i.clcodesc)
                from open.ic_clascont i
               where i.clcocodi IN
                     (select to_number(column_value)
                        from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('COD_CLA_CON_IMP_LDCGFV',
                                                                                                           NULL),
                                                                     ',')))
                 and i.clcocodi = open.CONCEPTO.concclco) > 0
         *\
      AND conccodi = c.cargconc
      and cc.cucocodi = c.cargcuco
      AND f.factcodi = cc.cucofact
      and f.factcodi = To_Number(sbFactcodi);*/

    rccuRefTotalIVAVenta cuRefTotalIVAVenta%ROWTYPE;
    ---fin total venta gas sin cotizacion

  BEGIN

    ut_trace.trace('[CASO_200_52] Inicio LDC_PKVENTAGAS.RfTotalVentaGasGDC',
                   10);
    ut_trace.trace('[CASO_200_52] Inicio Obtener Total de la Venta Gas',
                   10);

    --/*
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('FACTCODI', sbFactcodi);
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('TIPOSOLICITUD',
                                            sbtiposolicitud);
    --*/

    --sbFactcodi := 1024056482;

    /*    --valida si el tipo de solciitud genera cotizacion en el sistema
    OPEN CUEXISTE(to_number(sbTIPOSOLICITUD));
    FETCH CUEXISTE
      INTO nucantidad;
    CLOSE CUEXISTE;

    --
    --Obtiene los datos principales
    --Venta Gas asociada a una Cotizacion
    if nvl(nucantidad, 0) = 0 then

      --sbFactcodi := 1024056482;

      --Obtiene los datos principales
      OPEN CUCOTIZACION;
      FETCH CUCOTIZACION
        INTO rcCUCOTIZACION;
      CLOSE CUCOTIZACION;

      --Obtiene el codigo de cotizacion de la consulta principal
      INUQUOTATION := rcCUCOTIZACION.Quotation_Id;

      --LLamado al servicio que obtiene los datos de la cotizacion
      cc_boOssQuotations.GetQuotation(INUQUOTATION, OCUCURSOR);

      orfcursorOrg := OCUCURSOR;

      --Obtiene los datos del servicio de cotizacion
      --\*
      LOOP
        FETCH orfcursorOrg
          INTO rccuDatoCoti;
        EXIT WHEN orfcursorOrg%NOTFOUND;
        --INUQUOTATION := rccuDatoCoti.QUOTATION_ID;
        --DBMS_OUTPUT.PUT_LINE(' rccuDatoCoti.QUOTATION_ID  '||rccuDatoCoti.QUOTATION_ID);
      END LOOP;
      --*\
      OPEN orfcursor FOR
        SELECT Nvl(rccuDatoCoti.total_taxValue, 0) Valor_Iva,
               Nvl(rccuDatoCoti.total_value, 0) Valor_Total_Pagar
          FROM dual;
    else*/
    --Obtiene los datos principales
    OPEN cuRefTotalVenta;
    FETCH cuRefTotalVenta
      INTO rccuRefTotalVenta;
    CLOSE cuRefTotalVenta;

    OPEN cuRefTotalIVAVenta;
    FETCH cuRefTotalIVAVenta
      INTO rccuRefTotalIVAVenta;
    CLOSE cuRefTotalIVAVenta;

    OPEN orfcursor FOR
      SELECT nvl(rccuRefTotalIVAVenta.Valor_Iva, 0) Valor_Iva,
             (nvl(rccuRefTotalVenta.Valor_Total_Pagar, 0) +
              nvl(rccuRefTotalIVAVenta.Valor_Iva, 0))
             --nvl(rccuRefTotalVenta.Valor_Total_Pagar, 0)
              Valor_Total_Pagar
        FROM dual;
    --end if;

    ut_trace.trace('[CASO_200_52] Fin Obtener Total de la Venta Gas', 10);
    ut_trace.trace('[CASO_200_52] Fin LDC_PKVENTAGAS.RfTotalVentaGasGDC',
                   10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

  END RfTotalVentaGasGDC;

---Fin servicios para GDC

END ldc_pkventagas;

/
PROMPT Otorgando permisos de ejecucion a LDC_PKVENTAGAS
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKVENTAGAS', 'ADM_PERSON');
END;
/