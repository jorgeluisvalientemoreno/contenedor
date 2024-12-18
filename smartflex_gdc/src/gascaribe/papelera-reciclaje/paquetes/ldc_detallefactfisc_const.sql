CREATE OR REPLACE PACKAGE LDC_DETALLEFACTFISC_CONST IS

    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : LDC_DETALLEFACTFISC_CONST
      Descripcion    : Paquete que permitir obtener los datos necesarios
                       para el detalle de la factura.
      Autor          : Mmejia. ARA.7043  se toma de la fuente ldc_detallefactura_const

      Fecha          : 13/07/2015

      Metodos

      Nombre         :
      Parametros         Descripcion
      ============  ===================


      Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
    ******************************************************************/

    -- Obtiene la Version actual del Paquete
    FUNCTION FSBVERSION RETURN VARCHAR2;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RfDetalleFactura
    Descripcion    : procedimiento para extraer los datos relacionados
                     con el detalle de la factura.
    Autor          :
    Fecha          : 13/07/2015

    Parametros              Descripcion
    ============         ===================
    orfcursor            Retorna los datos del detalle de la factura.

    Fecha             Autor             Modificacion
    =========       =========           ====================
    13-07-2015      Mmejia             Creacion.
    ******************************************************************/
    PROCEDURE RfDetalleFactura(orfcursor OUT constants.tyRefCursor);

    /*****************************************************************
    Propiedad intelectual de HORBATH TECHNOLOGIES (c).

    Unidad         : RfDetalleFacturaIva
    Descripcion    : procedimiento para extraer los datos relacionados
                     con el detalle de IVA de la factura caso 200-1117.
    Autor          :
    Fecha          : 22/02/2018

    Parametros              Descripcion
    ============         ===================
    orfcursor            Retorna los datos del detalle de la factura.

    Fecha             Autor             Modificacion
    =========       =========           ====================
    22-02-2018      JOSH BRITO             Creacion.
    ******************************************************************/
    PROCEDURE RfDetalleFacturaIva(orfcursor OUT constants.tyRefCursor);

    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : LDC_DETALLEFACTFISC_CONST
      Descripcion    : Paquete que permitir obtener los datos necesarios
                       para el detalle de la factura.
      Autor          : Mmejia. ARA.7043  se toma de la fuente ldc_detallefactura_const

      Fecha          : 13/07/2015

      Metodos

      Nombre         :
      Parametros         Descripcion
      ============  ===================


      Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
    ******************************************************************/
    PROCEDURE RfDatosFactura(orfcursor OUT constants.tyRefCursor);

    ---CASO 200-136 Factura EFIGAS

    ----Inicio CASO 200-139 Servicios Factura Contratista EFIGAS FCED
    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RfDetalleFacturaEFIGAS
    Descripcion    : procedimiento para extraer los datos relacionados
                     con el detalle de la factura.
    Autor          :
    Fecha          : 08/08/2016

    Parametros              Descripcion
    ============         ===================
    orfcursor            Retorna los datos del detalle de la factura.

    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE RfDetalleFacturaEFIGAS(orfcursor OUT constants.tyRefCursor);

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RfDatosFacturaEFGIAS
    Descripcion    : procedimiento para extraer los datos relacionados
                     con la factura.
    Autor          :
    Fecha          : 08/08/2016

    Parametros              Descripcion
    ============         ===================
    orfcursor            Retorna los datos del generales de la factura.

    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE RfDatosFacturaEFGIAS(orfcursor OUT constants.tyRefCursor);
    PROCEDURE RfDetalleFacturaEFIGAS_OS(orfcursor OUT constants.tyRefCursor);
    ---Fin CASO 200-136 Factura Contratista EFIGAS FCED
    PROCEDURE RfDatosFacturaEFGIAS_OS(orfcursor OUT constants.tyRefCursor);
     PROCEDURE RfDetalleFactura_os(orfcursor OUT constants.tyRefCursor);
      PROCEDURE RfDatosFactura_OS(orfcursor OUT constants.tyRefCursor);
END LDC_DETALLEFACTFISC_CONST;
/
CREATE OR REPLACE PACKAGE BODY LDC_DETALLEFACTFISC_CONST IS

    CSBVERSION CONSTANT VARCHAR2(40) := 'Aran_7034';

    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : Ldc_PaymentFormat
      Descripcion    : Paquete que permitir obtener los datos necesarios
                       para el detalle de la factura.
      Autor          : Mmejia
      Fecha          : 13/07/2015

      Metodos

      Nombre         :
      Parametros         Descripcion
      ============  ===================


      Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
    ******************************************************************/

    /*
    Funcion que devuelve la version del pkg*/
    FUNCTION FSBVERSION RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RfDetalleFactura
    Descripcion    : procedimiento para extraer los datos relacionados
                     con el detalle de la factura.
    Autor          :
    Fecha          : 13/07/2015

    Parametros              Descripcion
    ============         ===================
    orfcursor            Retorna los datos del detalle de la factura.

    Fecha             Autor             Modificacion
    =========       =========           ====================
    13-07-2015      Mmejia             Creacion.
    22-04-2016      Jorge Valiente     CASO 200-139: Modificar el cursor cuDatos colocando en
                                                     la sentencia un filtro donde el campo
                                                     STATUS sea igual a C.
    ******************************************************************/
    PROCEDURE RfDetalleFactura(orfcursor OUT constants.tyRefCursor) IS

        sbFactcodi   ge_boInstanceControl.stysbValue;
        INUQUOTATION CC_QUOTATION.QUOTATION_ID%TYPE;
        OCUCURSOR    CONSTANTS.TYREFCURSOR;

        --<<
        --Cursor que obtiene la cotizacion
        -->>
        CURSOR cuDatos IS
            SELECT (SELECT QUOTATION_ID
                    FROM open.cc_quotation qu, open.cargos
                    WHERE qu.subscriber_id = b.suscclie
                          AND cargos.cargnuse = s.sesunuse
                          AND cargos.cargdoso LIKE 'PP-%'
                          AND cargdoso = 'PP-'||qu.package_id
                          AND qu.status in ('C','A') --CASO 200-139
                          AND rownum <= 1) QUOTATION_ID
            FROM open.factura  fc,
                 open.cuencobr cc,
                 open.suscripc b,
                 open.servsusc s
            WHERE fc.factcodi = To_Number(sbFactcodi) --:factura --obtenervalorinstancia('FACTURA','FACTCODI')
                  AND fc.factcodi = cc.cucofact
                  AND fc.factsusc = b.susccodi
                  AND b.susccodi = s.sesususc;

        rccuDatos cuDatos%ROWTYPE;

        ---Inicio CASO 200-1329
        CURSOR cuDetalles IS
            SELECT (SELECT QUOTATION_ID
                    FROM open.cc_quotation qu, open.cargos
                    WHERE cargos.cargnuse = s.sesunuse
                          AND cargos.cargdoso LIKE 'PP-%'
                          AND cargdoso = 'PP-'||qu.package_id
                          AND qu.status in ('C','A') --CASO 200-139
                          AND rownum = 1) QUOTATION_ID
            FROM open.factura fc, open.cuencobr cc, open.servsusc s
            WHERE fc.factcodi = To_Number(sbFactcodi)
                  AND fc.factcodi = cc.cucofact
                  AND fc.factsusc = s.sesususc;
        /*SELECT qu.quotation_id
         FROM open.factura      fc,
              open.suscripc     b,
              open.servsusc     s,
              open.cc_quotation qu
        WHERE fc.factcodi = To_Number(sbFactcodi)
          AND fc.factsusc = b.susccodi
          AND b.susccodi = s.sesususc
          and qu.subscriber_id = b.suscclie
          and qu.status = 'C';*/

        rccuDetalles cuDetalles%ROWTYPE;
        ---Fin CASO 200-139
        nuContar    NUMBER;

    BEGIN

        ut_trace.trace('*************************** [Mmejia] RfDetalleFactura Constructora', 10);

        sbFactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');
        -- Por si no funciona la factura en la instancia
        --sbDOCUCODI := Pkboca_Print.fnuGetDocumentBox;
        ut_trace.trace('*************************** [Mmejia] RfDetalleFactura Constructora sbFactcodi: ' ||
                       sbFactcodi, 2);

        OPEN cuDatos;
        FETCH cuDatos
            INTO rccuDatos;
        CLOSE cuDatos;

        ---Inicio CASO 200-139
        --INUQUOTATION := rccuDatos.QUOTATION_ID;
        IF rccuDatos.Quotation_Id IS NULL THEN
            OPEN cuDetalles;
            FETCH cuDetalles
                INTO rccuDetalles;
            CLOSE cuDetalles;
            INUQUOTATION := rccuDetalles.Quotation_Id;
            ut_trace.trace('*CASO 200-139 Ejecutar otro proceso Cotizacion [' ||
                           INUQUOTATION || ']', 10);
        ELSE
            INUQUOTATION := rccuDatos.QUOTATION_ID;
            ut_trace.trace('*************************** Cotizacion [' ||
                           INUQUOTATION || ']', 10);
        END IF;
        --IFin CASO 200-139

        --Servicio del cual se obtiene los datos de  detalles d ela cotizacion mostrados
        --en elCNCRM
        --cc_boOssQuotationItems.GETACTIVITIES(INUQUOTATION,OCUCURSOR);

        --orfcursor := OCUCURSOR;

        --------------------------------------INICIO CAMBIO 186-----------------------------------------------
         ---------------------INICO CAMBIO 186 --------------------------------
        SELECT COUNT(1)
        INTO  nuContar
        FROM factura fa,
             cuencobr cb,
             cargos ca
        WHERE  fa.factcodi =  To_Number(sbFactcodi) --ND: 22698190 -- PP: 2050408260
        AND    fa.factcodi = cb.cucofact
        AND    cb.cucocodi = ca.cargcuco
        AND    (ca.cargdoso LIKE 'N_-%'
        OR     ca.cargdoso NOT LIKE 'PP-%');


        IF nuContar >0 THEN
        OPEN orfcursor FOR
        SELECT ROWNUM CONCEPTO_COD,
                   co.concdesc CONCEPTO_DESC,
                   1 CANTIDAD,
                   To_Char((select sum(ca.cargvalo)
                            from OPEN.factura fa,
                                 OPEN.cuencobr cb,
                                 OPEN.cargos ca
                            where  fa.factcodi = To_Number(sbFactcodi)
                            and    fa.factcodi = cb.cucofact
                            and    cb.cucocodi = ca.cargcuco
                            and    ca.cargconc = co.conccodi), 'FM999,999,999,990') UNITARIO,
                   --a.unit_discount_value unit_discount_value,
                   To_Char((select sum(ca.cargvalo)
                            from OPEN.factura fa,
                                 OPEN.cuencobr cb,
                                 OPEN.cargos ca
                            where  fa.factcodi = To_Number(sbFactcodi)  --ND: 22698190 -- PP: 2050408260
                            and    fa.factcodi = cb.cucofact
                            and    cb.cucocodi = ca.cargcuco
                            and    ca.cargconc = co.conccodi), 'FM999,999,999,990') TOTAL
            FROM OPEN.cc_quotation_item a,
                 OPEN.ge_items          b,
                 OPEN.or_task_type      c,
                 OPEN.cc_quotation      d,
                 OPEN.mo_packages       e,
                 OPEN.ps_package_type   f,
                 OPEN.concepto          co
            WHERE a.quotation_id IN (select qu.quotation_id
                                      from OPEN.factura fa,
                                           OPEN.mo_motive mo,
                                           OPEN.mo_packages pa,
                                           OPEN.cc_quotation qu
                                      where fa.factcodi = To_Number(sbFactcodi)
                                      and fa.factsusc = mo.subscription_id
                                      and mo.package_id = pa.package_id
                                      and pa.package_type_id =323
                                      and pa.package_id = qu.package_id
                                      and rownum <= 1)--:inuQuotation
                  AND a.item_parent IS NULL
                  AND a.items_id = b.items_id
                  AND a.task_type_id = c.task_type_id
                  AND a.quotation_id = d.quotation_id
                  AND d.package_id = e.package_id
                  AND co.conccodi = b.CONCEPT
                  AND e.package_type_id = f.package_type_id
                  and co.conccodi in (select c.cargconc
                                        FROM OPEN.factura fa,
                                           OPEN.cuencobr cb,
                                           open.cargos c,
                                           OPEN.concepto co
                                     where (c.cargdoso like 'N_-%'
                                       OR  c.cargsign IN ('DB', 'CR'))
                                       AND fa.factcodi = To_Number(sbFactcodi)
                                       and fa.factcodi = cb.cucofact
                                       and cb.cucocodi = c.cargcuco
                                       and c.CARGCONC = co.CONCCODI);
        ELSE

        OPEN orfcursor FOR
            SELECT ROWNUM CONCEPTO_COD,
                   --a.quotation_item_id quotation_item_id,
                   --a.items_id||' - '||b.description item,
                   co.concdesc CONCEPTO_DESC,
                   --a.task_type_id||' - '||c.description TASK_TYPE,
                   a.items_quantity CANTIDAD,
                   To_Char(Nvl(Decode(Decode(e.liquidation_method, NULL, f.liquidation_method, e.liquidation_method), 3, a.unit_value +
                                       (a.unit_value *
                                       nvl(d.aui_percentage, 0) / 100), a.unit_value), 0), 'FM999,999,999,990') UNITARIO,
                   --a.unit_discount_value unit_discount_value,
                   To_Char(Nvl((to_number(decode(decode(e.liquidation_method, NULL, f.liquidation_method, e.liquidation_method), 3, a.unit_value +
                                                  (a.unit_value *
                                                  nvl(d.aui_percentage, 0) / 100), a.unit_value)) -
                               a.unit_discount_value) * a.items_quantity, 0), 'FM999,999,999,990') TOTAL
            FROM cc_quotation_item a,
                 ge_items          b,
                 or_task_type      c,
                 cc_quotation      d,
                 mo_packages       e,
                 ps_package_type   f,
                 concepto          co
            WHERE a.quotation_id = INUQUOTATION --:inuQuotation
                  AND a.item_parent IS NULL
                  AND a.items_id = b.items_id
                  AND a.task_type_id = c.task_type_id
                  AND a.quotation_id = d.quotation_id
                  AND d.package_id = e.package_id
                  AND co.conccodi = b.CONCEPT
                  AND e.package_type_id = f.package_type_id;
        END IF;
        --------------------------------------FIN CAMBIO 186-----------------------------------------------

        ut_trace.trace('[Mmejia] Fin RfDetalleFactura Constructora', 10);

    EXCEPTION
        WHEN OTHERS THEN
            PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

    END RfDetalleFactura;

    /*****************************************************************
    Propiedad intelectual de HORBATH TECHNOLOGIES (c).

    Unidad         : RfDetalleFacturaIva
    Descripcion    : procedimiento para extraer los datos relacionados
                     con el detalle de IVA de la factura CA 200-1117.
    Autor          :
    Fecha          : 22/02/2018

    Parametros              Descripcion
    ============         ===================
    orfcursor            Retorna los datos del detalle de iva de la factura.

    Fecha             Autor             Modificacion
    =========       =========           ====================
    22-02-2018      JOSH BRITO             Creacion.
    ******************************************************************/
    PROCEDURE RfDetalleFacturaIva(orfcursor OUT constants.tyRefCursor) IS
        sbFactcodi   ge_boInstanceControl.stysbValue;
        INUQUOTATION CC_QUOTATION.QUOTATION_ID%TYPE;
        OCUCURSOR    CONSTANTS.TYREFCURSOR;

        --<<
        --Cursor que obtiene la cotizacion
        -->>
        CURSOR cuDatos IS
            SELECT (SELECT QUOTATION_ID
                    FROM open.cc_quotation qu, open.cargos
                    WHERE qu.subscriber_id = b.suscclie
                          AND cargos.cargnuse = s.sesunuse
                          AND cargos.cargdoso LIKE 'PP-%'
                          AND cargdoso = 'PP-'||qu.package_id
                          AND qu.status in ('C','A')
                          AND rownum <= 1) QUOTATION_ID
            FROM open.factura  fc,
                 open.cuencobr cc,
                 open.suscripc b,
                 open.servsusc s
            WHERE fc.factcodi = To_Number(sbFactcodi) --:factura --obtenervalorinstancia('FACTURA','FACTCODI')
                  AND fc.factcodi = cc.cucofact
                  AND fc.factsusc = b.susccodi
                  AND b.susccodi = s.sesususc;

        rccuDatos cuDatos%ROWTYPE;

        CURSOR cuDetalles IS
            SELECT (SELECT QUOTATION_ID
                    FROM open.cc_quotation qu, open.cargos
                    WHERE cargos.cargnuse = s.sesunuse
                          AND cargos.cargdoso LIKE 'PP-%'
                          AND cargdoso = 'PP-'||qu.package_id
                          AND qu.status in ('C','A') --CASO 200-139
                          AND rownum = 1) QUOTATION_ID
            FROM open.factura fc, open.cuencobr cc, open.servsusc s
            WHERE fc.factcodi = To_Number(sbFactcodi)
                  AND fc.factcodi = cc.cucofact
                  AND fc.factsusc = s.sesususc;

        rccuDetalles cuDetalles%ROWTYPE;
        nuContar     NUMBER;


    BEGIN

        ut_trace.trace('*************************** [Mmejia] RfDetalleFacturaIva Constructora', 10);

        sbFactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');
        ut_trace.trace('*************************** [Mmejia] RfDetalleFacturaIva Constructora sbFactcodi: ' ||
                       sbFactcodi, 2);

        OPEN cuDatos;
        FETCH cuDatos
            INTO rccuDatos;
        CLOSE cuDatos;


        --INUQUOTATION := rccuDatos.QUOTATION_ID;
        IF rccuDatos.Quotation_Id IS NULL THEN
            OPEN cuDetalles;
            FETCH cuDetalles
                INTO rccuDetalles;
            CLOSE cuDetalles;
            INUQUOTATION := rccuDetalles.Quotation_Id;
            ut_trace.trace('*CASO 200-1117 Ejecutar otro proceso Cotizacion [' ||
                           INUQUOTATION || ']', 10);
        ELSE
            INUQUOTATION := rccuDatos.QUOTATION_ID;
            ut_trace.trace('*************************** Cotizacion [' ||
                           INUQUOTATION || ']', 10);
        END IF;

        ut_trace.trace('/----------------------------------INICIO CAMBIO 186-------------------------/', 10);
        ---------------------INICO CAMBIO 186 --------------------------------
        SELECT COUNT(1)
        INTO  nuContar
        FROM factura fa,
             cuencobr cb,
             cargos ca
        WHERE  fa.factcodi =  To_Number(sbFactcodi) --ND: 22698190 -- PP: 2050408260
        AND    fa.factcodi = cb.cucofact
        AND    cb.cucocodi = ca.cargcuco
        AND    (ca.cargdoso LIKE 'N_-%'
        OR     ca.cargdoso NOT LIKE 'PP-%');

        IF nuContar >0 THEN
          OPEN orfcursor FOR
            SELECT c.CARGCONC CONCEPCOD_IVA,
                   co.CONCDESC CONCEPDESC_IVA,
                   COUNT(DISTINCT(NVL(C.CARGUNID, 1))) CANTIDAD_IVA,
                   (select sum(ca.cargvalo)
                      from cargos ca, concbali cc
                     where c.cargcuco = ca.cargcuco
                       and ca.cargconc = cc.coblcoba
                       and cc.coblconc = c.cargconc) VALORBASE_IVA,
                   SUM(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO)) VALORTOTAL_IVA
              FROM OPEN.factura  fa,
                   OPEN.cuencobr cb,
                   open.cargos   c,
                   OPEN.concepto co
             where c.cargsign IN ('DB', 'CR')
               AND fa.factcodi = To_Number(sbFactcodi)
               and fa.factcodi = cb.cucofact
               and cb.cucocodi = c.cargcuco
               and c.CARGCONC = co.CONCCODI
               and co.concticl = 4
             group by c.CARGCONC, co.CONCDESC, c.cargcuco, c.cargconc;
          /*
          OPEN orfcursor FOR
                    SELECT co.CONCCODI CONCEPCOD_IVA,
                 co.CONCDESC CONCEPDESC_IVA,
                 decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1)) CANTIDAD_IVA,
                 to_char((select sum(ca.cargvalo)
                          from cargos ca
                          where c.cargcuco = ca.cargcuco
                          and ca.cargconc <> co.conccodi), 'FM999,999,999,990') VALORBASE_IVA,
                 to_char(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO), 'FM999,999,999,990') VALORTOTAL_IVA
                 FROM OPEN.factura fa,
                     OPEN.cuencobr cb,
                     open.cargos c,
                     OPEN.concepto co
               where c.cargdoso like 'N_-%'
                 AND c.cargsign IN ('DB', 'CR')
                 AND fa.factcodi = To_Number(sbFactcodi)
                 and fa.factcodi = cb.cucofact
                 and cb.cucocodi = c.cargcuco
                 and c.CARGCONC = co.CONCCODI
                 AND CO.CONCCODI NOT IN (select i.CONCEPT
                                        from cc_quotation_item a,cc_quotation d, ge_items i
                                        where a.QUOTATION_ID = d.QUOTATION_ID
                                        and i.ITEMS_ID = a.ITEMS_ID
                                        and d.QUOTATION_ID IN (select QU.QUOTATION_ID
                                                                from factura fa,
                                                                     mo_motive mo,
                                                                     mo_packages pa,
                                                                     cc_quotation qu
                                                                where fa.factcodi = To_Number(sbFactcodi)
                                                                and fa.factsusc = mo.subscription_id
                                                                and mo.package_id = pa.package_id
                                                                and pa.package_type_id =323
                                                                and pa.package_id = qu.package_id
                                                                and rownum <= 1));*/
         ut_trace.trace('/-----------------------ENTRO CONSULTA NUEVA-------------------------/', 10);
        ELSE
         ut_trace.trace('/-----------------------ENTRO CONSULTA VIEJA------------------------/', 10);
        OPEN orfcursor FOR
          SELECT co.CONCCODI CONCEPCOD_IVA,
                co.CONCDESC CONCEPDESC_IVA,
                decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1)) CANTIDAD_IVA,
                to_char(c.CARGVABL, 'FM999,999,999,990') VALORBASE_IVA,
                to_char(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO), 'FM999,999,999,990') VALORTOTAL_IVA
                FROM open.cc_quotation qu, open.cargos c, concepto co
               where c.cargdoso like 'PP-%'
                 AND cargdoso = 'PP-'||qu.package_id
                 and qu.status = 'C'
                 AND c.cargsign IN ('DB', 'CR')
                 and qu.QUOTATION_ID = INUQUOTATION
                 and c.CARGCONC = co.CONCCODI
                 and co.CONCCODI not in (select i.CONCEPT
                                          from cc_quotation_item a,cc_quotation d, ge_items i
                                          where a.QUOTATION_ID = d.QUOTATION_ID
                                          and i.ITEMS_ID = a.ITEMS_ID
                                          and d.QUOTATION_ID = qu.QUOTATION_ID);
       END IF;

        ut_trace.trace('/-------------------------FIN CAMBIO 186-------------------------/', 10);
       ------------------------------ FIN CAMBIO 186 ------------------------------------------

      ut_trace.trace('[Mmejia] Fin RfDetalleFacturaIva Constructora', 10);

    EXCEPTION
        WHEN OTHERS THEN
            PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

    END RfDetalleFacturaIva;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RfDetalleFactura
    Descripcion    : procedimiento para extraer los datos relacionados
                     con la factura.
    Autor          :
    Fecha          : 13/07/2015

    Parametros              Descripcion
    ============         ===================
    orfcursor            Retorna los datos del detalle de la factura.

    Fecha             Autor             Modificacion
    =========       =========           ====================
    13-07-2015      Mmejia             Creacion.
    22-04-2016      Jorge Valiente     CASO 200-139: Modificar el cursor cuDatos colocando una
                                                     subconsulta en el campo DATE_INITIAL_PER
                                                     para obtener la fecha de pagos del cupon
                                                     del anticipo.
    16-08-2017      Jorge Valiente     CASO 200-1428: Modificar la sentencia del cursor cuDatos retirando
                                                      use_nl_with_index de los indices IDXCUCO_RELA y IX_CARG_CUCO_CONC.
    ******************************************************************/
    PROCEDURE RfDatosFactura(orfcursor OUT constants.tyRefCursor) IS

        sbFactcodi   ge_boInstanceControl.stysbValue;
        orfcursorOrg constants.tyRefCursor;
        INUQUOTATION CC_QUOTATION.QUOTATION_ID%TYPE;
        OCUCURSOR    CONSTANTS.TYREFCURSOR;

        CURSOR cuDatos IS
            SELECT fc.factcodi ACCOUNT_NUMBER, --2
                   dage_subscriber.fsbgetsubscriber_name(b.suscclie) || ' ' ||
                   dage_subscriber.fsbgetsubs_last_name(b.suscclie) CLIENT_NAME,
                   (CASE
                       WHEN (dage_subscriber.fnugetident_type_id(b.suscclie) = 110 OR
                            dage_subscriber.fnugetident_type_id(b.suscclie) = 1) THEN
                        dage_subscriber.fsbgetidentification(b.suscclie)
                   END) CLIENT_NIT, -- 26
                   daab_address.fsbgetaddress_parsed(b.susciddi) CLIENT_ADDRESS,
                   open.dage_geogra_location.fsbgetdescription(daab_address.fnugetgeograp_location_id(b.susciddi)) NEIGHBORTHOOD,
                   dage_subscriber.fsbgete_mail(b.suscclie) CLIENT_E_MAIL,
                   dage_subscriber.fsbgetphone(b.suscclie) CLIENT_PHONE,
                   CASE
                       WHEN (open.LDC_BOFORMATOFACTURA.fsbPagoInmediato(s.sesunuse) = 1) THEN
                        'INMEDIATO'
                       ELSE
                        To_Char(cc.cucofeve, 'dd/MON/yyyy')
                   END DATE_LIMITED_PER, --13
                   ---Inicio CASO 200-139
                   --To_Char(fc.factfege, 'dd/MON/yyyy')
                   To_Char((SELECT /*+leading (mo_package_payment) index(mo_package_payment IDX_MO_PACKAGE_PAYMENT)
                                                                                                                                                                                                                                                                                                                                                                                                                                                              use_nl_with_index(sucubanc pk_sucubanc)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                use_nl_with_index(banco pk_banco)*/
                           DISTINCT pagofepa pagofepa
                           FROM open.pagos,
                                open.banco,
                                open.sucubanc,
                                open.cupon,
                                open.mo_motive_payment  mp,
                                open.mo_package_payment pp,
                                open.factura,
                                open.cuencobr,
                                open.cargos
                           WHERE pagobanc = banccodi
                                 AND pagobanc = subabanc
                                 AND pagosuba = subacodi
                                 AND pagocupo = cuponume
                                 AND
                                 pp.package_payment_id = mp.package_payment_id
                                 AND mp.payment_value > 0
                                 AND mp.active = 'Y'
                                 AND mp.account = factcodi
                                 AND factcodi = cucofact
                                 AND cargcuco = cucocodi
                                 AND cargdoso LIKE 'PA%'
                                 AND cargsign = 'PA'
                                 AND cargcodo = cuponume
                                 AND (cupotipo = 'AF' OR cupotipo = 'PP')
                                 AND cuponume = pagocupo
                                 AND cupodocu = To_Number(sbFactcodi)), 'dd/MON/yyyy') DATE_INITIAL_PER, --11
                   ---Fin CASO 200-139
                   b.SUSCCLIE,
                   cc.CUCONUSE,
                   (SELECT QUOTATION_ID
                    FROM open.cc_quotation qu, open.cargos
                    WHERE qu.subscriber_id = b.suscclie
                          AND cargos.cargnuse = s.sesunuse
                          AND cargos.cargdoso LIKE 'PP-%'
                          AND cargdoso = 'PP-'||qu.package_id
                          AND qu.status in ('C','A')
                          AND rownum <= 1) QUOTATION_ID,
                   (SELECT mo.comment_
                    FROM open.cc_quotation qu, open.cargos, OPEN.mo_packages mo
                    WHERE qu.subscriber_id = b.suscclie
                          AND cargos.cargnuse = s.sesunuse
                          AND cargos.cargdoso LIKE 'PP-%'
                          AND cargdoso = 'PP-'||qu.package_id
                          AND mo.package_id = qu.package_id
                          AND qu.status in ('C','A')
                          AND rownum <= 1) MOTIVE_PAQ,
                  	(SELECT cc.id_proyecto
                    FROM cc_quotation qu,
                         cargos,
                         ldc_cotizacion_construct cc
                    WHERE subscriber_id = b.suscclie
                      AND  cargos.cargnuse = s.sesunuse
                      AND cargos.cargdoso = 'PP-'||qu.package_id
                      AND cc.id_cotizacion_osf = qu.quotation_id
                      AND ROWNUM <= 1) COD_PROYECTO
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

        --Datos de la  cotizacion
        CURSOR cuDatoCoti IS
            SELECT a.quotation_id quotation_id,
                   a.description description,
                   a.register_date register_date,
                   a.status || ' - ' ||
                   decode(a.status, 'R', 'Registrada', 'A', 'Aprobada', 'N', 'Anulada', 'C', 'Aceptada', NULL) status,
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
                   decode(a.pay_modality, '1', 'Antes de hacer los Trabajos', '2', 'Al Finalizar Trabajos', '3', 'Segun Avance de Obra', '4', 'Sin Cotizacion', NULL) pay_modality,
                   a.comment_ comment_,
                   '' parent_id
            FROM cc_quotation a, ge_person b
            WHERE a.status in ('C','A');

        rccuDatoCoti cuDatoCoti%ROWTYPE;

        ---Inicio CASO 200-1329
        CURSOR cuCotizacion IS
            SELECT (SELECT QUOTATION_ID
                    FROM open.cc_quotation qu, open.cargos
                    WHERE cargos.cargnuse = s.sesunuse
                          AND cargos.cargdoso LIKE 'PP-%'
                          AND cargdoso = 'PP-'||qu.package_id
                          AND qu.status in ('C','A') --CASO 200-139
                          AND rownum = 1) QUOTATION_ID
            FROM open.factura fc, open.cuencobr cc, open.servsusc s
            WHERE fc.factcodi = To_Number(sbFactcodi)
                  AND fc.factcodi = cc.cucofact
                  AND fc.factsusc = s.sesususc;

        rfcuCotizacion cuCotizacion%ROWTYPE;
        ---Fin CASO 200-139

        ---CASO 186
        CURSOR cuTotales IS
          SELECT (SELECT SUM(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO)) VALORTOTAL_IVA
                    FROM OPEN.factura  fa,
                         OPEN.cuencobr cb,
                         open.cargos   c,
                         OPEN.concepto co
                   where c.cargsign IN ('DB', 'CR')
                     AND fa.factcodi = To_Number(sbFactcodi)
                     and fa.factcodi = cb.cucofact
                     and cb.cucocodi = c.cargcuco
                     and c.CARGCONC = co.CONCCODI
                     and co.concticl = 4) VALORTOTAL_IVA,
                 (SELECT SUM(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO)) VALORTOTAL_FACTURA
                    FROM OPEN.factura  fa,
                         OPEN.cuencobr cb,
                         open.cargos   c,
                         OPEN.concepto co
                   where c.cargsign IN ('DB', 'CR')
                     AND fa.factcodi = To_Number(sbFactcodi)
                     and fa.factcodi = cb.cucofact
                     and cb.cucocodi = c.cargcuco
                     and c.CARGCONC = co.CONCCODI) VALOR_TOTAL
            FROM DUAL;


        /*
        SELECT
         SUM(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO)) VALORTOTAL_IVA,
         sum (cb.cucovato)  VALOR_TOTAL
         FROM OPEN.factura fa,
             OPEN.cuencobr cb,
             open.cargos c,
             OPEN.concepto co
        where (c.cargdoso like 'N_-%'
         OR  c.cargsign IN ('DB', 'CR'))
         AND fa.factcodi = To_Number(sbFactcodi)
         and fa.factcodi = cb.cucofact
         and cb.cucocodi = c.cargcuco
         and c.CARGCONC = co.CONCCODI
         AND CO.CONCCODI NOT IN (select i.CONCEPT
                                from cc_quotation_item a,cc_quotation d, ge_items i
                                where a.QUOTATION_ID = d.QUOTATION_ID
                                and i.ITEMS_ID = a.ITEMS_ID
                                and d.QUOTATION_ID IN (select QU.QUOTATION_ID
                                                        from factura fa,
                                                             mo_motive mo,
                                                             mo_packages pa,
                                                             cc_quotation qu
                                                        where fa.factcodi = To_Number(sbFactcodi)
                                                        and fa.factsusc = mo.subscription_id
                                                        and mo.package_id = pa.package_id
                                                        and pa.package_type_id =323
                                                        and pa.package_id = qu.package_id
                                                        and rownum <= 1));*/

     --Caso 186
     rfcuTotales cuTotales%ROWTYPE;
     nuContar    number;

     /*CURSOR cuTOTAL_PAY IS
        SELECT SUM(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO)) VALORTOTAL_FACTURA
         FROM OPEN.factura fa, OPEN.cuencobr cb, open.cargos c, OPEN.concepto co
        where c.cargsign IN ('DB', 'CR')
          AND fa.factcodi = To_Number(sbFactcodi)
          and fa.factcodi = cb.cucofact
          and cb.cucocodi = c.cargcuco
          and c.CARGCONC = co.CONCCODI;

     rfcuTOTAL_PAY cuTOTAL_PAY%ROWTYPE;
     nuTOTAL_PAY number;

     CURSOR cuIMPUESTO_IVA IS
       SELECT SUM(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO)) VALORTOTAL_IVA
         FROM OPEN.factura  fa,
              OPEN.cuencobr cb,
              open.cargos   c,
              OPEN.concepto co
        where c.cargsign IN ('DB', 'CR')
          AND fa.factcodi = To_Number(sbFactcodi)
          and fa.factcodi = cb.cucofact
          and cb.cucocodi = c.cargcuco
          and c.CARGCONC = co.CONCCODI
          and co.concticl = 4;

     rfcuIMPUESTO_IVA cuIMPUESTO_IVA%ROWTYPE;
     nuIMPUESTO_IVA number;*/
     --Caso 186


    BEGIN

        ut_trace.trace('*************************** [Mmejia] LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora', 10);

        sbFactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');

        ut_trace.trace('*************************** [Mmejia] LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora sbFactcodi: ' ||
                       sbFactcodi, 2);

        --Obtiene los datos principales
        OPEN cuDatos;
        FETCH cuDatos
            INTO rccuDatos;
        CLOSE cuDatos;

        --Obtiene el codigo de cotizacion de la consulta principal
        ---Inicio CASO 200-139
        --INUQUOTATION := rccuDatos.QUOTATION_ID;
        IF rccuDatos.Quotation_Id IS NULL THEN
            OPEN cuCotizacion;
            FETCH cuCotizacion
                INTO rfcuCotizacion;
            CLOSE cuCotizacion;
            INUQUOTATION := rfcuCotizacion.Quotation_Id;
            ut_trace.trace('*CASO 200-139 Ejecutar otro proceso Cotizacion [' ||
                           INUQUOTATION || ']', 10);
        ELSE
            INUQUOTATION := rccuDatos.QUOTATION_ID;
            ut_trace.trace('*************************** Cotizacion [' ||
                           INUQUOTATION || ']', 10);
        END IF;
        --IFin CASO 200-139

        ut_trace.trace('[Mmejia] LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora INUQUOTATION  [' ||
                       INUQUOTATION || ']', 10);
        --LLamado al servicio que obtiene los datos de la cotizacion
        cc_boOssQuotations.GetQuotation(INUQUOTATION, OCUCURSOR);

        orfcursorOrg := OCUCURSOR;

        ut_trace.trace('[Mmejia] LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora Obtien los datos del curosor de datoad e cotizacion', 10);

        --Obtiene los datos del servicio de cotizacion
        LOOP
            FETCH orfcursorOrg
                INTO rccuDatoCoti;
            EXIT WHEN orfcursorOrg%NOTFOUND;
            --INUQUOTATION := rccuDatoCoti.QUOTATION_ID;
            --DBMS_OUTPUT.PUT_LINE(' rccuDatoCoti.QUOTATION_ID  '||rccuDatoCoti.QUOTATION_ID);
        END LOOP;

        ut_trace.trace('[Mmejia] LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora total_value  [' ||
                       rccuDatoCoti.total_value || ']', 10);


         ---------------------INICO CAMBIO 186 --------------------------------
        nuContar:=0;
        SELECT COUNT(1)
        INTO  nuContar
        FROM factura fa,
             cuencobr cb,
             cargos ca
        WHERE  fa.factcodi =  To_Number(sbFactcodi) --ND: 22698190 -- PP: 2050408260
        AND    fa.factcodi = cb.cucofact
        AND    cb.cucocodi = ca.cargcuco
        AND    (ca.cargdoso LIKE 'N_-%'
        OR     ca.cargdoso NOT LIKE 'PP-%');


        IF nuContar >0 THEN

        OPEN cuTotales;
        FETCH cuTotales
            INTO rfcuTotales;
        CLOSE cuTotales;

        OPEN orfcursor FOR
            SELECT (select FACTNUFI from factura where FACTCODI = rccuDatos.ACCOUNT_NUMBER) ACCOUNT_NUMBER,
                   To_Char(rccuDatos.CLIENT_NAME) CLIENT_NAME,
                   To_Char(rccuDatos.CLIENT_NIT) CLIENT_NIT,
                   To_Char(rccuDatos.CLIENT_ADDRESS) CLIENT_ADDRESS,
                   To_Char(rccuDatos.NEIGHBORTHOOD) NEIGHBORTHOOD,
                   To_Char(rccuDatos.CLIENT_E_MAIL) CLIENT_E_MAIL,
                   To_Char(rccuDatos.CLIENT_PHONE) CLIENT_PHONE,
                   To_Char(rccuDatos.DATE_LIMITED_PER) DATE_LIMITED_PER,
                   to_char((select FACTFEGE from factura where FACTCODI = rccuDatos.ACCOUNT_NUMBER), 'dd/MON/yyyy') DATE_INITIAL_PER,
                   To_Char(rccuDatos.SUSCCLIE) SUSCCLIE,
                   To_Char(rccuDatos.CUCONUSE) CUCONUSE,
                   To_Char(rccuDatos.QUOTATION_ID) QUOTATION_ID,
                   TO_CHAR(nvl(rfcuTotales.Valor_Total, 0), 'FM999,999,999,990') TOTAL_PAY,
                   To_Char(Nvl(rfcuTotales.Valortotal_Iva, 0), 'FM999,999,999,990') IMPUESTO_IVA,
                   To_Char('Motivo: ' || rccuDatos.MOTIVE_PAQ) MOTIVE_PAQ,
                   To_Char(rccuDatos.COD_PROYECTO) COD_PROYECTO
            FROM dual;
         ELSE

         OPEN orfcursor FOR
            SELECT (select FACTNUFI from factura where FACTCODI = rccuDatos.ACCOUNT_NUMBER) ACCOUNT_NUMBER,
                   To_Char(rccuDatos.CLIENT_NAME) CLIENT_NAME,
                   To_Char(rccuDatos.CLIENT_NIT) CLIENT_NIT,
                   To_Char(rccuDatos.CLIENT_ADDRESS) CLIENT_ADDRESS,
                   To_Char(rccuDatos.NEIGHBORTHOOD) NEIGHBORTHOOD,
                   To_Char(rccuDatos.CLIENT_E_MAIL) CLIENT_E_MAIL,
                   To_Char(rccuDatos.CLIENT_PHONE) CLIENT_PHONE,
                   To_Char(rccuDatos.DATE_LIMITED_PER) DATE_LIMITED_PER,
                   to_char((select FACTFEGE from factura where FACTCODI = rccuDatos.ACCOUNT_NUMBER), 'dd/MON/yyyy') DATE_INITIAL_PER,
                   To_Char(rccuDatos.SUSCCLIE) SUSCCLIE,
                   To_Char(rccuDatos.CUCONUSE) CUCONUSE,
                   To_Char(rccuDatos.QUOTATION_ID) QUOTATION_ID,
                   TO_CHAR(Nvl(rccuDatoCoti.total_value, 0), 'FM999,999,999,990') TOTAL_PAY,
                   To_Char(Nvl(rccuDatoCoti.total_taxValue, 0), 'FM999,999,999,990') IMPUESTO_IVA,
                   To_Char('Motivo: ' || rccuDatos.MOTIVE_PAQ) MOTIVE_PAQ,
                   To_Char(rccuDatos.COD_PROYECTO) COD_PROYECTO
            FROM dual;
        END IF;

        ut_trace.trace('[Mmejia] Fin LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora', 10);

    EXCEPTION
        WHEN OTHERS THEN
            Dbms_Output.Put_Line(SQLERRM);
            PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
    END RfDatosFactura;

    ----Inicio CASO 200-139 Servicios Factura Contratista EFIGAS FCED
    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RfDetalleFacturaEFIGAS
    Descripcion    : procedimiento para extraer los datos relacionados
                     con el detalle de la factura.
    Autor          :
    Fecha          : 08/08/2016

    Parametros              Descripcion
    ============         ===================
    orfcursor            Retorna los datos del detalle de la factura.

    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE RfDetalleFacturaEFIGAS(orfcursor OUT constants.tyRefCursor) IS

        sbFactcodi   ge_boInstanceControl.stysbValue;
        INUQUOTATION CC_QUOTATION.QUOTATION_ID%TYPE;
        OCUCURSOR    CONSTANTS.TYREFCURSOR;

        --<<
        --Cursor que obtiene la cotizacion
        -->>
        CURSOR cuDatos IS
            SELECT (SELECT QUOTATION_ID
                    FROM open.cc_quotation qu, open.cargos
                    WHERE qu.subscriber_id = b.suscclie
                          AND cargos.cargnuse = s.sesunuse
                          AND cargos.cargdoso LIKE 'PP-%'
                          AND cargdoso = 'PP-'||qu.package_id
                          AND qu.status = 'C' --CASO 200-139
                          AND rownum <= 1) QUOTATION_ID
            FROM open.factura  fc,
                 open.cuencobr cc,
                 open.suscripc b,
                 open.servsusc s
            WHERE fc.factcodi = To_Number(sbFactcodi) --:factura --obtenervalorinstancia('FACTURA','FACTCODI')
                  AND fc.factcodi = cc.cucofact
                  AND fc.factsusc = b.susccodi
                  AND b.susccodi = s.sesususc;

        rccuDatos cuDatos%ROWTYPE;

        ---Inicio CASO 200-1329
        CURSOR cuDetalles IS
            SELECT (SELECT QUOTATION_ID
                    FROM open.cc_quotation qu, open.cargos
                    WHERE cargos.cargnuse = s.sesunuse
                          AND cargos.cargdoso LIKE 'PP-%'
                          AND cargdoso = 'PP-'||qu.package_id
                          AND qu.status in ('C','A') --CASO 200-139
                          AND rownum = 1) QUOTATION_ID
            FROM open.factura fc, open.cuencobr cc, open.servsusc s
            WHERE fc.factcodi = To_Number(sbFactcodi)
                  AND fc.factcodi = cc.cucofact
                  AND fc.factsusc = s.sesususc;
        /*      SELECT qu.quotation_id
         FROM open.factura      fc,
              open.suscripc     b,
              open.servsusc     s,
              open.cc_quotation qu
        WHERE fc.factcodi = To_Number(sbFactcodi)
          AND fc.factsusc = b.susccodi
          AND b.susccodi = s.sesususc
          and qu.subscriber_id = b.suscclie
          and qu.status = 'C';*/

        rccuDetalles cuDetalles%ROWTYPE;
        ---Fin CASO 200-139

    BEGIN
        /*
        ut_trace.trace('*************************** RfDetalleFacturaEFIGAS RfDetalleFactura Constructora',
                       10);

        sbFactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');
        -- Por si no funciona la factura en la instancia
        --sbDOCUCODI := Pkboca_Print.fnuGetDocumentBox;
        ut_trace.trace('*************************** RfDetalleFacturaEFIGAS Constructora sbFactcodi: ' ||
                       sbFactcodi,
                       2);

        OPEN cuDatos;
        FETCH cuDatos
          INTO rccuDatos;
        CLOSE cuDatos;

        ---Inicio CASO 200-139
        --INUQUOTATION := rccuDatos.QUOTATION_ID;
        if rccuDatos.Quotation_Id is null then
          OPEN cuDetalles;
          FETCH cuDetalles
            INTO rccuDetalles;
          CLOSE cuDetalles;
          INUQUOTATION := rccuDetalles.Quotation_Id;
          ut_trace.trace('*CASO 200-139 Ejecutar otro proceso Cotizacion [' ||
                         INUQUOTATION || ']',
                         10);
        else
          INUQUOTATION := rccuDatos.QUOTATION_ID;
          ut_trace.trace('*************************** Cotizacion [' ||
                         INUQUOTATION || ']',
                         10);
        end if;

        --IFin CASO 200-139

        --Servicio del cual se obtiene los datos de  detalles d ela cotizacion mostrados
        --en elCNCRM
        --cc_boOssQuotationItems.GETACTIVITIES(INUQUOTATION,OCUCURSOR);

        --orfcursor := OCUCURSOR;

        \*
        OPEN orfcursor FOR
          SELECT co.conccodi CONCEPTO_COD,
                 --a.quotation_item_id quotation_item_id,
                 --a.items_id||' - '||b.description item,
                 co.concdesc CONCEPTO_DESC,
                 --a.task_type_id||' - '||c.description TASK_TYPE,
                 a.items_quantity CANTIDAD,
                 To_Char(Nvl(Decode(Decode(e.liquidation_method,
                                           null,
                                           f.liquidation_method,
                                           e.liquidation_method),
                                    3,
                                    a.unit_value +
                                    (a.unit_value * nvl(d.aui_percentage, 0) / 100),
                                    a.unit_value),
                             0),
                         'FM999,999,999,990') UNITARIO,
                 --a.unit_discount_value unit_discount_value,
                 To_Char(Nvl((to_number(decode(decode(e.liquidation_method,
                                                      null,
                                                      f.liquidation_method,
                                                      e.liquidation_method),
                                               3,
                                               a.unit_value +
                                               (a.unit_value *
                                               nvl(d.aui_percentage, 0) / 100),
                                               a.unit_value)) -
                             a.unit_discount_value) * a.items_quantity,
                             0),
                         'FM999,999,999,990') TOTAL
            FROM cc_quotation_item a,
                 ge_items          b,
                 or_task_type      c,
                 cc_quotation      d,
                 mo_packages       e,
                 ps_package_type   f,
                 concepto          co
           WHERE a.quotation_id = INUQUOTATION --:inuQuotation
             AND a.item_parent IS NULL
             AND a.items_id = b.items_id
             AND a.task_type_id = c.task_type_id
             AND a.quotation_id = d.quotation_id
             AND d.package_id = e.package_id
             AND co.conccodi = b.CONCEPT
             AND e.package_type_id = f.package_type_id
             union all
          SELECT co.conccodi CONCEPTO_COD,
                 --a.quotation_item_id quotation_item_id,
                 --a.items_id||' - '||b.description item,
                 co.concdesc CONCEPTO_DESC,
                 --a.task_type_id||' - '||c.description TASK_TYPE,
                 1 CANTIDAD,
                 To_Char(cg.cargvalo,'FM999,999,999,990') UNITARIO,
                 --a.unit_discount_value unit_discount_value,
                 To_Char(cg.cargvalo,'FM999,999,999,990') TOTAL
            FROM cargos            cg,
                 cc_quotation      d,
                 concepto          co
           WHERE d.quotation_id = INUQUOTATION --:inuQuotation
             AND cg.cargdoso like 'PP-' || d.package_id
             AND cg.cargconc  IN
                 (select to_number(column_value)
                    from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CONC_FACT_CONT_IMFC_EFIGAS',
                                                                                             NULL),

                                                            ',')))
             AND co.conccodi = cg.cargconc;
        --*\

        ---obtener conceptos registrados en la venta con el codigo de la factura.
        OPEN orfcursor FOR
            SELECT CONCEPTO.CONCCODI CODIGO,
                   CONCEPTO.CONCDESC CONCEPTO,
                   decode(nvl(C.CARGUNID, 1),0,1,nvl(C.CARGUNID, 1)) CANTIDAD,
                   Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) VALOR,
                   (Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
                   decode(nvl(C.CARGUNID, 1),0,1,nvl(C.CARGUNID, 1))) VALOR_TOTAL
              FROM open.cargos   c,
                   open.concepto,
                   open.cuencobr cc,
                   open.factura  f
             WHERE c.cargtipr = 'A'
               AND c.cargsign IN ('DB', 'CR')
               AND c.cargcuco > 0
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
           and f.factcodi = To_Number(sbFactcodi);
        ----------------------------------------------------------------------------

        ut_trace.trace('Fin RfDetalleFacturaEFIGAS Constructora', 10);
        */

        ut_trace.trace('*************************** [200-139] RfDetalleFacturaEFIGAS Constructora', 10);

        sbFactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');
        -- Por si no funciona la factura en la instancia
        --sbDOCUCODI := Pkboca_Print.fnuGetDocumentBox;
        ut_trace.trace('*************************** [200-139] RfDetalleFacturaEFIGAS Constructora sbFactcodi: ' ||
                       sbFactcodi, 2);

        OPEN cuDatos;
        FETCH cuDatos
            INTO rccuDatos;
        CLOSE cuDatos;

        ---Inicio CASO 200-139
        --INUQUOTATION := rccuDatos.QUOTATION_ID;
        IF rccuDatos.Quotation_Id IS NULL THEN
            OPEN cuDetalles;
            FETCH cuDetalles
                INTO rccuDetalles;
            CLOSE cuDetalles;
            INUQUOTATION := rccuDetalles.Quotation_Id;
            ut_trace.trace('*CASO 200-139 Ejecutar otro proceso Cotizacion [' ||
                           INUQUOTATION || ']', 10);
        ELSE
            INUQUOTATION := rccuDatos.QUOTATION_ID;
            ut_trace.trace('*************************** Cotizacion [' ||
                           INUQUOTATION || ']', 10);
        END IF;

        --IFin CASO 200-139

        --Servicio del cual se obtiene los datos de  detalles d ela cotizacion mostrados
        --en elCNCRM
        --cc_boOssQuotationItems.GETACTIVITIES(INUQUOTATION,OCUCURSOR);

        --orfcursor := OCUCURSOR;

        OPEN orfcursor FOR
            SELECT co.conccodi CODIGO,
                   --a.quotation_item_id quotation_item_id,
                   --a.items_id||' - '||b.description item,
                   co.concdesc CONCEPTO,
                   --a.task_type_id||' - '||c.description TASK_TYPE,
                   a.items_quantity CANTIDAD,
                   To_Char(Nvl(Decode(Decode(e.liquidation_method, NULL, f.liquidation_method, e.liquidation_method), 3, a.unit_value +
                                       (a.unit_value *
                                       nvl(d.aui_percentage, 0) / 100), a.unit_value), 0), 'FM999,999,999,990') VALOR,
                   --a.unit_discount_value unit_discount_value,
                   To_Char(Nvl((to_number(decode(decode(e.liquidation_method, NULL, f.liquidation_method, e.liquidation_method), 3, a.unit_value +
                                                  (a.unit_value *
                                                  nvl(d.aui_percentage, 0) / 100), a.unit_value)) -
                               a.unit_discount_value) * a.items_quantity, 0), 'FM999,999,999,990') VALOR_TOTAL
            FROM cc_quotation_item a,
                 ge_items          b,
                 or_task_type      c,
                 cc_quotation      d,
                 mo_packages       e,
                 ps_package_type   f,
                 concepto          co
            WHERE a.quotation_id = INUQUOTATION --:inuQuotation
                  AND a.item_parent IS NULL
                  AND a.items_id = b.items_id
                  AND a.task_type_id = c.task_type_id
                  AND a.quotation_id = d.quotation_id
                  AND d.package_id = e.package_id
                  AND co.conccodi = b.CONCEPT
                  AND e.package_type_id = f.package_type_id
            --/*-----
            UNION ALL
            ----
            SELECT CONCEPTO.CONCCODI CODIGO,
                   CONCEPTO.CONCDESC CONCEPTO,
                   decode(nvl(C1.CARGUNID, 1), 0, 1, nvl(C1.CARGUNID, 1)) CANTIDAD,
                   To_Char(Decode(c1.cargsign, 'DB', c1.CARGVALO, -c1.CARGVALO), 'FM999,999,999,990') VALOR,
                   To_Char((Decode(c1.cargsign, 'DB', c1.CARGVALO, -c1.CARGVALO) *
                           decode(nvl(C1.CARGUNID, 1), 0, 1, nvl(C1.CARGUNID, 1))), 'FM999,999,999,990') VALOR_TOTAL
            FROM open.cargos   c1,
                 open.concepto,
                 open.cuencobr cc1,
                 open.factura  f1
            WHERE c1.cargtipr = 'A'
                  AND c1.cargsign IN ('DB') --, 'CR')
                  AND c1.cargcuco > 0
                  AND
                  c1.cargconc IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('CONC_FACT_CONT_IMFC_EFIGAS', NULL), ',')))
                  AND conccodi = c1.cargconc
                  AND cc1.cucocodi = c1.cargcuco
                  AND f1.factcodi = cc1.cucofact
                  AND f1.factcodi = To_Number(sbFactcodi);
        --*/;

        ut_trace.trace('[200-139] Fin RfDetalleFacturaEFIGAS Constructora', 10);

    EXCEPTION
        WHEN OTHERS THEN
            PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

    END RfDetalleFacturaEFIGAS;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RfDatosFacturaEFGIAS
    Descripcion    : procedimiento para extraer los datos relacionados
                     con la factura.
    Autor          :
    Fecha          : 08/08/2016

    Parametros              Descripcion
    ============         ===================
    orfcursor            Retorna los datos del detalle de la factura.

    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE RfDatosFacturaEFGIAS(orfcursor OUT constants.tyRefCursor) IS

        sbFactcodi   ge_boInstanceControl.stysbValue;
        orfcursorOrg constants.tyRefCursor;
        INUQUOTATION CC_QUOTATION.QUOTATION_ID%TYPE;
        OCUCURSOR    CONSTANTS.TYREFCURSOR;

        CURSOR cuDatos IS
            SELECT fc.factcodi ACCOUNT_NUMBER, --2
                   dage_subscriber.fsbgetsubscriber_name(b.suscclie) || ' ' ||
                   dage_subscriber.fsbgetsubs_last_name(b.suscclie) CLIENT_NAME,
                   (CASE
                       WHEN (dage_subscriber.fnugetident_type_id(b.suscclie) = 110 OR
                            dage_subscriber.fnugetident_type_id(b.suscclie) = 1) THEN
                        dage_subscriber.fsbgetidentification(b.suscclie)
                   END) CLIENT_NIT, -- 26
                   daab_address.fsbgetaddress_parsed(b.susciddi) CLIENT_ADDRESS,
                   open.dage_geogra_location.fsbgetdescription(daab_address.fnugetgeograp_location_id(b.susciddi)) NEIGHBORTHOOD,
                   dage_subscriber.fsbgete_mail(b.suscclie) CLIENT_E_MAIL,
                   dage_subscriber.fsbgetphone(b.suscclie) CLIENT_PHONE,
                   CASE
                       WHEN (open.LDC_BOFORMATOFACTURA.fsbPagoInmediato(s.sesunuse) = 1) THEN
                        'INMEDIATO'
                       ELSE
                        To_Char(cc.cucofeve, 'dd/MON/yyyy')
                   END DATE_LIMITED_PER, --13
                   ---Inicio CASO 200-139
                   --To_Char(fc.factfege, 'dd/MON/yyyy')
                   /*
                   To_Char((SELECT /*+leading (mo_package_payment) index(mo_package_payment IDX_MO_PACKAGE_PAYMENT)
                                    use_nl_with_index(mo_motive_payment IDX_MO_MOTIVE_PAYMENT_05)
                                    use_nl_with_index(factura pk_factura)
                                    use_nl_with_index(cuencobr IDXCUCO_RELA)
                                    use_nl_with_index(cargos IX_CARG_CUCO_CONC)
                                    use_nl_with_index(cupon pk_cupon)
                                    use_nl_with_index(pagos pk_pagos)
                                    use_nl_with_index(sucubanc pk_sucubanc)
                                    use_nl_with_index(banco pk_banco)*
                           distinct pagofepa pagofepa
                             FROM open.pagos,
                                  open.banco,
                                  open.sucubanc,
                                  open.cupon,
                                  open.mo_motive_payment  mp,
                                  open.mo_package_payment pp,
                                  open.factura,
                                  open.cuencobr,
                                  open.cargos
                            WHERE pagobanc = banccodi
                              and pagobanc = subabanc
                              and pagosuba = subacodi
                              and pagocupo = cuponume
                              AND pp.package_payment_id = mp.package_payment_id
                              AND mp.payment_value > 0
                              AND mp.active = 'Y'
                              AND mp.account = factcodi
                              AND factcodi = cucofact
                              AND cargcuco = cucocodi
                              AND cargdoso LIKE 'PA%'
                              AND cargsign = 'PA'
                              AND cargcodo = cuponume
                              AND (cupotipo = 'AF' OR cupotipo = 'PP')
                              AND cuponume = pagocupo
                              and cupodocu = To_Number(sbFactcodi)),
                           'dd/MON/yyyy')
                           --*/
                   (SELECT To_Char(mo.attention_date, 'dd/MON/yyyy')
                    FROM open.cc_quotation qu, open.cargos, OPEN.mo_packages mo
                    WHERE qu.subscriber_id = b.suscclie
                          AND cargos.cargnuse = s.sesunuse
                          AND cargos.cargdoso LIKE 'PP-%'
                          AND
                          qu.package_id =
                          substr(cargdoso, instr(cargdoso, '-') + 1, length(cargdoso))
                          AND mo.package_id = qu.package_id
                          AND qu.status = 'C'
                          AND rownum <= 1) DATE_INITIAL_PER, --11
                   ---Fin CASO 200-139
                   b.SUSCCLIE,
                   cc.CUCONUSE,
                   (SELECT QUOTATION_ID
                    FROM open.cc_quotation qu, open.cargos
                    WHERE qu.subscriber_id = b.suscclie
                          AND cargos.cargnuse = s.sesunuse
                          AND cargos.cargdoso LIKE 'PP-%'
                          AND
                          qu.package_id =
                          substr(cargdoso, instr(cargdoso, '-') + 1, length(cargdoso))
                          AND qu.status = 'C'
                          AND rownum <= 1) QUOTATION_ID,
                   (SELECT mo.comment_
                    FROM open.cc_quotation qu, open.cargos, OPEN.mo_packages mo
                    WHERE qu.subscriber_id = b.suscclie
                          AND cargos.cargnuse = s.sesunuse
                          AND cargos.cargdoso LIKE 'PP-%'
                          AND
                          qu.package_id =
                          substr(cargdoso, instr(cargdoso, '-') + 1, length(cargdoso))
                          AND mo.package_id = qu.package_id
                          AND qu.status = 'C'
                          AND rownum <= 1) MOTIVE_PAQ,
                   b.susccodi Contrato
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

        --Datos de la  cotizacion
        CURSOR cuDatoCoti IS
            SELECT a.quotation_id quotation_id,
                   a.description description,
                   a.register_date register_date,
                   a.status || ' - ' ||
                   decode(a.status, 'R', 'Registrada', 'A', 'Aprobada', 'N', 'Anulada', 'C', 'Aceptada', NULL) status,
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
                   decode(a.pay_modality, '1', 'Antes de hacer los Trabajos', '2', 'Al Finalizar Trabajos', '3', 'Segun Avance de Obra', '4', 'Sin Cotizacion', NULL) pay_modality,
                   a.comment_ comment_,
                   '' parent_id
            FROM cc_quotation a, ge_person b
            WHERE a.status = 'C';

        rccuDatoCoti cuDatoCoti%ROWTYPE;

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
                  AND cc.cucocodi = c.cargcuco
                  AND f.factcodi = cc.cucofact
                  AND f.factcodi = To_Number(sbFactcodi);

        rccuRefTotalVenta cuRefTotalVenta%ROWTYPE;

        ---Inicio CASO 200-1329
        CURSOR cuCotizacion IS
            SELECT (SELECT QUOTATION_ID
                    FROM open.cc_quotation qu, open.cargos
                    WHERE cargos.cargnuse = s.sesunuse
                          AND cargos.cargdoso LIKE 'PP-%'
                          AND
                          qu.package_id =
                          substr(cargdoso, instr(cargdoso, '-') + 1, length(cargdoso))
                          AND qu.status = 'C' --CASO 200-139
                          AND rownum = 1) QUOTATION_ID
            FROM open.factura fc, open.cuencobr cc, open.servsusc s
            WHERE fc.factcodi = To_Number(sbFactcodi)
                  AND fc.factcodi = cc.cucofact
                  AND fc.factsusc = s.sesususc;

        rfcuCotizacion cuCotizacion%ROWTYPE;
        ---Fin CASO 200-139

    BEGIN

        ut_trace.trace('*************************** [Mmejia] LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora', 10);

        sbFactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');

        ut_trace.trace('*************************** [Mmejia] LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora sbFactcodi: ' ||
                       sbFactcodi, 2);

        --Obtiene los datos principales
        OPEN cuDatos;
        FETCH cuDatos
            INTO rccuDatos;
        CLOSE cuDatos;

        --Obtiene el codigo de cotizacion de la consulta principal
        ---Inicio CASO 200-139
        --INUQUOTATION := rccuDatos.QUOTATION_ID;
        IF rccuDatos.Quotation_Id IS NULL THEN
            OPEN cuCotizacion;
            FETCH cuCotizacion
                INTO rfcuCotizacion;
            CLOSE cuCotizacion;
            INUQUOTATION := rfcuCotizacion.Quotation_Id;
            ut_trace.trace('*CASO 200-139 Ejecutar otro proceso Cotizacion [' ||
                           INUQUOTATION || ']', 10);
        ELSE
            INUQUOTATION := rccuDatos.QUOTATION_ID;
            ut_trace.trace('*************************** Cotizacion [' ||
                           INUQUOTATION || ']', 10);
        END IF;
        --IFin CASO 200-139

        ut_trace.trace('[Mmejia] LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora INUQUOTATION  [' ||
                       INUQUOTATION || ']', 10);
        --LLamado al servicio que obtiene los datos de la cotizacion
        cc_boOssQuotations.GetQuotation(INUQUOTATION, OCUCURSOR);

        orfcursorOrg := OCUCURSOR;

        ut_trace.trace('[Mmejia] LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora Obtien los datos del curosor de datoad e cotizacion', 10);

        --Obtiene los datos del servicio de cotizacion
        LOOP
            FETCH orfcursorOrg
                INTO rccuDatoCoti;
            EXIT WHEN orfcursorOrg%NOTFOUND;
            --INUQUOTATION := rccuDatoCoti.QUOTATION_ID;
            --DBMS_OUTPUT.PUT_LINE(' rccuDatoCoti.QUOTATION_ID  '||rccuDatoCoti.QUOTATION_ID);
        END LOOP;

        ut_trace.trace('[Mmejia] LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora total_value  [' ||
                       rccuDatoCoti.total_value || ']', 10);

        OPEN cuRefTotalVenta;
        FETCH cuRefTotalVenta
            INTO rccuRefTotalVenta;
        CLOSE cuRefTotalVenta;

        OPEN orfcursor FOR
            SELECT To_Char(rccuDatos.ACCOUNT_NUMBER) ACCOUNT_NUMBER,
                   To_Char(rccuDatos.CLIENT_NAME) CLIENT_NAME,
                   To_Char(rccuDatos.CLIENT_NIT) CLIENT_NIT,
                   To_Char(rccuDatos.CLIENT_ADDRESS) CLIENT_ADDRESS,
                   To_Char(rccuDatos.NEIGHBORTHOOD) NEIGHBORTHOOD,
                   To_Char(rccuDatos.CLIENT_E_MAIL) CLIENT_E_MAIL,
                   To_Char(rccuDatos.CLIENT_PHONE) CLIENT_PHONE,
                   To_Char(rccuDatos.DATE_LIMITED_PER) DATE_LIMITED_PER,
                   To_Char(rccuDatos.DATE_INITIAL_PER) DATE_INITIAL_PER,
                   To_Char(rccuDatos.SUSCCLIE) SUSCCLIE,
                   To_Char(rccuDatos.CUCONUSE) CUCONUSE,
                   To_Char(rccuDatos.QUOTATION_ID) QUOTATION_ID,
                   TO_CHAR(Nvl(rccuDatoCoti.total_value, 0), 'FM999,999,999,990') TOTAL_PAY,
                   --TO_CHAR(Nvl(rccuRefTotalVenta.Valor_Total_Pagar, 0), 'FM999,999,999,990') TOTAL_PAY,
                   To_Char(Nvl(rccuDatoCoti.total_taxValue, 0), 'FM999,999,999,990') IMPUESTO_IVA,
                   To_Char('Motivo de venta:' || rccuDatos.MOTIVE_PAQ) MOTIVE_PAQ,
                   To_Char(rccuDatos.Contrato) CONTRATO
            FROM dual;

        ut_trace.trace('[Mmejia] Fin LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora', 10);

    EXCEPTION
        WHEN OTHERS THEN
            Dbms_Output.Put_Line(SQLERRM);
            PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
    END RfDatosFacturaEFGIAS;
    ----Fin CASO 200-139 Servicios Facturas Contratista EFIGAS FCED

    ----Inicio CASO 200-1389 Servicios Factura Contratista EFIGAS FCED
    /*****************************************************************
    Propiedad intelectual de GDC (c).

    Unidad         : RfDetalleFacturaEFIGAS_OS
    Descripcion    : procedimiento para extraer los datos relacionados
                     con el detalle de la factura de otros servicios.
    Autor          :
    Fecha          : 29/09/2017

    Parametros              Descripcion
    ============         ===================
    orfcursor            Retorna los datos del detalle de la factura.

    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE RfDetalleFacturaEFIGAS_OS(orfcursor OUT constants.tyRefCursor) IS

        sbFactcodi   ge_boInstanceControl.stysbValue;
        INUQUOTATION factura.factcodi%TYPE;
        OCUCURSOR    CONSTANTS.TYREFCURSOR;

        --<<
        --Cursor que obtiene la solicitud asociada al estado de cuenta que requieren imprimir
        -->>
        CURSOR cuDatos IS
            SELECT substr(cargdoso, instr(cargdoso, '-') + 1, length(cargdoso)) package_id
            FROM open.cargos   ca,
                 open.factura  fa,
                 open.cuencobr c,
                 open.servsusc s
            WHERE fa.factcodi = sbFactcodi
                  AND ca.cargcuco = c.cucocodi
                  AND c.cucofact = fa.factcodi
                  AND c.cuconuse = ca.cargnuse
                  AND ca.cargdoso LIKE 'PP-%'
                  AND s.sesunuse = ca.cargnuse
                  AND
                  s.sesuserv NOT IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('SERV_EXC_IMFC', NULL), ',')))
                  AND
                  fa.factprog IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARAPROG_IMFC', NULL), ',')))
                  AND
                  ca.cargcaca NOT IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CAUS_EXC_IMFC', NULL), ',')))
                         AND rownum <= 1;

        rccuDatos cuDatos%ROWTYPE;

    BEGIN

        ut_trace.trace('*************************** [200-139] RfDetalleFacturaEFIGAS Constructora', 10);


        sbFactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');



        -- Por si no funciona la factura en la instancia
        --sbDOCUCODI := Pkboca_Print.fnuGetDocumentBox;
        ut_trace.trace('*************************** [200-139] RfDetalleFacturaEFIGAS Constructora sbFactcodi: ' ||
                       sbFactcodi, 2);

        OPEN cuDatos;
        FETCH cuDatos
            INTO rccuDatos;
        CLOSE cuDatos;

        IF rccuDatos.Package_Id IS NOT NULL THEN
            INUQUOTATION := rccuDatos.Package_Id;
            ut_trace.trace('*************************** Cotizacion [' ||
                           INUQUOTATION || ']', 10);
        END IF;

        OPEN orfcursor FOR
            SELECT CONCEPTO.CONCCODI CODIGO,
                   CONCEPTO.CONCDESC CONCEPTO,
                   decode(nvl(C1.CARGUNID, 1), 0, 1, nvl(C1.CARGUNID, 1)) CANTIDAD,
                   To_Char(Decode(c1.cargsign, 'DB', c1.CARGVALO, -c1.CARGVALO), 'FM999,999,999,990') VALOR,
                   To_Char((Decode(c1.cargsign, 'DB', c1.CARGVALO, -c1.CARGVALO) *
                           decode(nvl(C1.CARGUNID, 1), 0, 1, nvl(C1.CARGUNID, 1))), 'FM999,999,999,990') VALOR_TOTAL
            FROM open.cargos   c1,
                 open.concepto,
                 open.cuencobr cc1,
                 open.factura  f1
            WHERE c1.cargtipr = 'A'
                --  AND c1.cargsign IN ('DB') --, 'CR')
                  AND c1.cargcuco > 0
                  AND
                  f1.factprog IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARAPROG_IMFC', NULL), ',')))
                  AND
                  c1.cargcaca NOT IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CAUS_EXC_IMFC', NULL), ',')))
                  AND conccodi = c1.cargconc
                  AND cc1.cucocodi = c1.cargcuco
                  AND f1.factcodi = cc1.cucofact
                  AND f1.factcodi = To_Number(sbFactcodi)
                  AND substr(cargdoso, instr(cargdoso, '-') + 1, length(cargdoso)) =
                  INUQUOTATION;

        ut_trace.trace('[200-139] Fin RfDetalleFacturaEFIGAS Constructora', 10);

    EXCEPTION
        WHEN OTHERS THEN
            PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

    END RfDetalleFacturaEFIGAS_OS;

    PROCEDURE RfDatosFacturaEFGIAS_OS(orfcursor OUT constants.tyRefCursor) IS

        sbFactcodi   ge_boInstanceControl.stysbValue;
        orfcursorOrg constants.tyRefCursor;
        INUQUOTATION FACTURA.FACTCODI%TYPE;
        OCUCURSOR    CONSTANTS.TYREFCURSOR;

        CURSOR cuDatos IS
            SELECT DISTINCT fc.factcodi ACCOUNT_NUMBER, --2
                            open.dage_subscriber.fsbgetsubscriber_name(b.suscclie) || ' ' ||
                            open.dage_subscriber.fsbgetsubs_last_name(b.suscclie) CLIENT_NAME,
                            (CASE
                                WHEN (open.dage_subscriber.fnugetident_type_id(b.suscclie) = 110 OR
                                     open.dage_subscriber.fnugetident_type_id(b.suscclie) = 1) THEN
                                 open.dage_subscriber.fsbgetidentification(b.suscclie)
                            END) CLIENT_NIT, -- 26
                            open.daab_address.fsbgetaddress_parsed(b.susciddi) CLIENT_ADDRESS,
                            open.dage_geogra_location.fsbgetdescription(open.daab_address.fnugetgeograp_location_id(b.susciddi)) NEIGHBORTHOOD,
                            open.dage_subscriber.fsbgete_mail(b.suscclie) CLIENT_E_MAIL,
                            open.dage_subscriber.fsbgetphone(b.suscclie) CLIENT_PHONE,
                            CASE
                                WHEN (open.LDC_BOFORMATOFACTURA.fsbPagoInmediato(s.sesunuse) = 1) THEN
                                 'INMEDIATO'
                                ELSE
                                 To_Char(cc.cucofeve, 'dd/MON/yyyy')
                            END DATE_LIMITED_PER, --13
                            To_Char(mo.attention_date, 'dd/MON/yyyy') DATE_INITIAL_PER, --11
                            b.SUSCCLIE,
                            cc.CUCONUSE,
                            package_id QUOTATION_ID,
                           '' MOTIVE_PAQ,
                            b.susccodi Contrato

            FROM open.factura     fc,
                 open.cuencobr    cc,
                 open.suscripc    b,
                 open.servsusc    s,
                 open.Mo_Packages MO,
                 open.CARGOS      CA
            WHERE fc.factcodi = To_Number(sBfACTCODI) --:factura --obtenervalorinstancia('FACTURA','FACTCODI')
                  AND fc.factcodi = cc.cucofact
                  AND fc.factsusc = b.susccodi
                  AND b.susccodi = s.sesususc
                  AND cc.cuconuse = s.sesunuse
                     --   AND rownum <= 1
                  AND
                  MO.package_id =
                  substr(cargdoso, instr(cargdoso, '-') + 1, length(cargdoso))
                  AND ca.cargcuco = cc.cucocodi
                  AND
                  s.sesuserv NOT IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('SERV_EXC_IMFC', NULL), ',')))
                  AND
                  fc.factprog IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARAPROG_IMFC', NULL), ',')))
                  AND
                  ca.cargcaca NOT IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CAUS_EXC_IMFC', NULL), ',')));

        rccuDatos cuDatos%ROWTYPE;

        CURSOR cuRefTotalVenta IS
            SELECT SUM(Decode(cA.cargsign, 'DB', cA.CARGVALO, -cA.CARGVALO) *
                       decode(nvl(CA.CARGUNID, 1), 0, 1, nvl(CA.CARGUNID, 1))) VALOR_TOTAL_PAGAR
             FROM open.factura     fc,
                 open.cuencobr    cc,
                 open.suscripc    b,
                 open.servsusc    s,
                 open.Mo_Packages MO,
                 open.CARGOS      CA
            WHERE fc.factcodi = To_Number(sBfACTCODI) --:factura --obtenervalorinstancia('FACTURA','FACTCODI')
                  AND fc.factcodi = cc.cucofact
                  AND fc.factsusc = b.susccodi
                  AND b.susccodi = s.sesususc
                  AND cc.cuconuse = s.sesunuse
                        --AND rownum <= 1
                  AND
                  MO.package_id =
                  substr(cargdoso, instr(cargdoso, '-') + 1, length(cargdoso))
                  AND ca.cargcuco = cc.cucocodi
                  AND
                  s.sesuserv NOT IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('SERV_EXC_IMFC', NULL), ',')))
                  AND
                  fc.factprog IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARAPROG_IMFC', NULL), ',')))
                  AND
                  ca.cargcaca NOT IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CAUS_EXC_IMFC', NULL), ',')));

        CURSOR CurIVa IS
            SELECT SUM(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
                       decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1))) VALOR_TOTAL_PAGAR
            FROM open.cargos   c,
                 open.concepto,
                 open.cuencobr cc,
                 open.factura  f,
                 open.servsusc s
            WHERE c.cargtipr = 'A'
                  ---AND c.cargsign IN ('DB', 'CR')
                  AND c.cargcuco > 0
                      --  AND rownum <= 1
                  AND conccodi = c.cargconc
                  AND cc.cucocodi = c.cargcuco
                  AND f.factcodi = cc.cucofact
                  AND f.factcodi = To_Number(sbFactcodi)
                  AND s.sesunuse = c.cargnuse
                  AND c.cargnuse = cc.cuconuse
                  AND
                  s.sesuserv NOT IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('SERV_EXC_IMFC', NULL), ',')))
                  AND
                  f.factprog IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARAPROG_IMFC', NULL), ',')))
                  AND
                  c.cargcaca NOT IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CAUS_EXC_IMFC', NULL), ',')))
                  AND UPPER(OPEN.CONCEPTo.CONCDESC) LIKE '%IVA%';

        rccuRefTotalVenta cuRefTotalVenta%ROWTYPE;

        rEGcuRefTotaliva CurIVa%ROWTYPE;

    BEGIN

        ut_trace.trace('*************************** [Mmejia] LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora', 10);

        sbFactcodi :=obtenervalorinstancia('FACTURA', 'FACTCODI');

        ut_trace.trace('*************************** [Mmejia] LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora sbFactcodi: ' ||
                       sbFactcodi, 2);

        --Obtiene los datos principales
        OPEN cuDatos;
        FETCH cuDatos
            INTO rccuDatos;
        CLOSE cuDatos;

        --Obtiene los datos del servicio de cotizacion

        OPEN cuRefTotalVenta;
        FETCH cuRefTotalVenta
            INTO rccuRefTotalVenta;
        CLOSE cuRefTotalVenta;

        OPEN CurIVa;
        FETCH CurIVa
            INTO rEGcuRefTotaliva;
        CLOSE CurIVa;

        OPEN orfcursor FOR
            SELECT To_Char(rccuDatos.ACCOUNT_NUMBER) ACCOUNT_NUMBER,
                   To_Char(rccuDatos.CLIENT_NAME) CLIENT_NAME,
                   To_Char(rccuDatos.CLIENT_NIT) CLIENT_NIT,
                   To_Char(rccuDatos.CLIENT_ADDRESS) CLIENT_ADDRESS,
                   To_Char(rccuDatos.NEIGHBORTHOOD) NEIGHBORTHOOD,
                   To_Char(rccuDatos.CLIENT_E_MAIL) CLIENT_E_MAIL,
                   To_Char(rccuDatos.CLIENT_PHONE) CLIENT_PHONE,
                   To_Char(rccuDatos.DATE_LIMITED_PER) DATE_LIMITED_PER,
                   To_Char(rccuDatos.DATE_INITIAL_PER) DATE_INITIAL_PER,
                   To_Char(rccuDatos.SUSCCLIE) SUSCCLIE,
                   To_Char(rccuDatos.CUCONUSE) CUCONUSE,
                   To_Char(rccuDatos.QUOTATION_ID) QUOTATION_ID,
                   TO_CHAR(Nvl(rccuRefTotalVenta.Valor_Total_Pagar, 0), 'FM999,999,999,990') TOTAL_PAY,
                   --TO_CHAR(Nvl(rccuRefTotalVenta.Valor_Total_Pagar, 0), 'FM999,999,999,990') TOTAL_PAY,
                   To_Char(Nvl(rEGcuRefTotaliva.Valor_Total_Pagar, 0), 'FM999,999,999,990') IMPUESTO_IVA,
                   To_Char('' || rccuDatos.MOTIVE_PAQ) MOTIVE_PAQ,
                   To_Char(rccuDatos.Contrato) CONTRATO
            FROM dual;

        ut_trace.trace('[Mmejia] Fin LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora', 10);

    EXCEPTION
        WHEN OTHERS THEN
            Dbms_Output.Put_Line(SQLERRM);
            PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
    END RfDatosFacturaEFGIAS_OS;


    /*****************************************************************
    Propiedad intelectual de GDC (c).

    Unidad         : RfDetalleFactura_os
    Descripcion    : procedimiento para extraer los datos relacionados
                     con el detalle de la factura  para otros servicios suministrador por la compa?ia.
    Autor          :
    Fecha          : 13/07/2015

    Parametros              Descripcion
    ============         ===================
    orfcursor            Retorna los datos del detalle de la factura para otros servicios suministrador por la compa?ia.

    Fecha             Autor             Modificacion
    =========       =========           ====================
    02-10-2017      jsilvera             Creacion.

    ******************************************************************/
    PROCEDURE RfDetalleFactura_os(orfcursor OUT constants.tyRefCursor) IS

        sbFactcodi   ge_boInstanceControl.stysbValue;
        INUQUOTATION factura.factcodi%TYPE;
        OCUCURSOR    CONSTANTS.TYREFCURSOR;

        --<<
        --Cursor que obtiene la cotizacion
        -->>
        CURSOR cuDatos IS

            SELECT substr(cargdoso, instr(cargdoso, '-') + 1, length(cargdoso)) package_id
            FROM open.cargos   ca,
                 open.factura  fa,
                 open.cuencobr c,
                 open.servsusc s
            WHERE fa.factcodi = sbFactcodi
                  AND ca.cargcuco = c.cucocodi
                  AND c.cucofact = fa.factcodi
                  AND c.cuconuse = ca.cargnuse
                  AND ca.cargdoso LIKE 'PP-%'
                  AND s.sesunuse = ca.cargnuse
                  AND
                  s.sesuserv NOT IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('SERV_EXC_IMFC', NULL), ',')))
                  AND
                  fa.factprog IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARAPROG_IMFC', NULL), ',')))
                  AND
                  ca.cargcaca NOT IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CAUS_EXC_IMFC', NULL), ',')))
                   AND rownum <= 1;

        rccuDatos cuDatos%ROWTYPE;


    BEGIN

        ut_trace.trace('*************************** [Mmejia] RfDetalleFactura Constructora', 10);

        sbFactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');
        -- Por si no funciona la factura en la instancia
        --sbDOCUCODI := Pkboca_Print.fnuGetDocumentBox;
        ut_trace.trace('*************************** [Mmejia] RfDetalleFactura Constructora sbFactcodi: ' ||
                       sbFactcodi, 2);

        OPEN cuDatos;
        FETCH cuDatos
            INTO rccuDatos;
        CLOSE cuDatos;

        ---Inicio CASO 200-139
        INUQUOTATION := rccuDatos.Package_Id;

        --IFin CASO 200-139

        --Servicio del cual se obtiene los datos de  detalles d ela cotizacion mostrados
        --en elCNCRM
        --cc_boOssQuotationItems.GETACTIVITIES(INUQUOTATION,OCUCURSOR);

        --orfcursor := OCUCURSOR;

        OPEN orfcursor FOR
           SELECT CONCEPTO.CONCCODI CODIGO,
                   CONCEPTO.CONCDESC CONCEPTO,
                   decode(nvl(C1.CARGUNID, 1), 0, 1, nvl(C1.CARGUNID, 1)) CANTIDAD,
                   To_Char(Decode(c1.cargsign, 'DB', c1.CARGVALO, -c1.CARGVALO), 'FM999,999,999,990') VALOR,
                   To_Char((Decode(c1.cargsign, 'DB', c1.CARGVALO, -c1.CARGVALO) *
                           decode(nvl(C1.CARGUNID, 1), 0, 1, nvl(C1.CARGUNID, 1))), 'FM999,999,999,990') VALOR_TOTAL
            FROM open.cargos   c1,
                 open.concepto,
                 open.cuencobr cc1,
                 open.factura  f1
            WHERE c1.cargtipr = 'A'
                --  AND c1.cargsign IN ('DB') --, 'CR')
                  AND c1.cargcuco > 0
                  AND
                  f1.factprog IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARAPROG_IMFC', NULL), ',')))
                  AND
                  c1.cargcaca NOT IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CAUS_EXC_IMFC', NULL), ',')))
                  AND conccodi = c1.cargconc
                  AND cc1.cucocodi = c1.cargcuco
                  AND f1.factcodi = cc1.cucofact
                  AND f1.factcodi = To_Number(sbFactcodi)
                  AND substr(cargdoso, instr(cargdoso, '-') + 1, length(cargdoso)) =
                  INUQUOTATION;

        ut_trace.trace('[Mmejia] Fin RfDetalleFactura Constructora', 10);

    EXCEPTION
        WHEN OTHERS THEN
            PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

    END RfDetalleFactura_os;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RfDetalleFactura_OS
    Descripcion    : procedimiento para extraer los datos relacionados
                     con la factura.
    Autor          :
    Fecha          : 13/07/2015

    Parametros              Descripcion
    ============         ===================
    orfcursor            Retorna los datos del detalle de la factura de otros servicios ofrecidos por la compa?ia.

    Fecha             Autor             Modificacion
    =========       =========           ====================
    02-10-2017      jsilvera             Creacion.
    ******************************************************************/
    PROCEDURE RfDatosFactura_OS(orfcursor OUT constants.tyRefCursor) IS

        sbFactcodi   ge_boInstanceControl.stysbValue;
        orfcursorOrg constants.tyRefCursor;
        INUQUOTATION factura.factcodi%TYPE;
        OCUCURSOR    CONSTANTS.TYREFCURSOR;

        CURSOR cuDatos IS
            SELECT distinct fc.factcodi ACCOUNT_NUMBER, --2
                   dage_subscriber.fsbgetsubscriber_name(b.suscclie) || ' ' ||
                   dage_subscriber.fsbgetsubs_last_name(b.suscclie) CLIENT_NAME,
                   (CASE
                       WHEN (dage_subscriber.fnugetident_type_id(b.suscclie) = 110 OR
                            dage_subscriber.fnugetident_type_id(b.suscclie) = 1) THEN
                        dage_subscriber.fsbgetidentification(b.suscclie)
                   END) CLIENT_NIT, -- 26
                   daab_address.fsbgetaddress_parsed(b.susciddi) CLIENT_ADDRESS,
                   open.dage_geogra_location.fsbgetdescription(daab_address.fnugetgeograp_location_id(b.susciddi)) NEIGHBORTHOOD,
                   dage_subscriber.fsbgete_mail(b.suscclie) CLIENT_E_MAIL,
                   dage_subscriber.fsbgetphone(b.suscclie) CLIENT_PHONE,
                   CASE
                       WHEN (open.LDC_BOFORMATOFACTURA.fsbPagoInmediato(s.sesunuse) = 1) THEN
                        'INMEDIATO'
                       ELSE
                        To_Char(cc.cucofeve, 'dd/MON/yyyy')
                   END DATE_LIMITED_PER, --13
                   ---Inicio CASO 200-139
                   --To_Char(fc.factfege, 'dd/MON/yyyy')
                   To_Char((SELECT /*+leading (mo_package_payment) index(mo_package_payment IDX_MO_PACKAGE_PAYMENT)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      use_nl_with_index(mo_motive_payment IDX_MO_MOTIVE_PAYMENT_05)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      use_nl_with_index(factura pk_factura)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      (cuencobr IDXCUCO_RELA)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      (cargos IX_CARG_CUCO_CONC)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      use_nl_with_index(cupon pk_cupon)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      use_nl_with_index(pagos pk_pagos)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      use_nl_with_index(sucubanc pk_sucubanc)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      use_nl_with_index(banco pk_banco)*/
                           DISTINCT pagofepa pagofepa
                           FROM open.pagos,
                                open.banco,
                                open.sucubanc,
                                open.cupon,
                                open.mo_motive_payment  mp,
                                open.mo_package_payment pp,
                                open.factura,
                                open.cuencobr,
                                open.cargos
                           WHERE pagobanc = banccodi
                                 AND pagobanc = subabanc
                                 AND pagosuba = subacodi
                                 AND pagocupo = cuponume
                                 AND
                                 pp.package_payment_id = mp.package_payment_id
                                 AND mp.payment_value > 0
                                 AND mp.active = 'Y'
                                 AND mp.account = factcodi
                                 AND factcodi = cucofact
                                 AND cargcuco = cucocodi
                                 AND cargdoso LIKE 'PA%'
                                 AND cargsign = 'PA'
                                 AND cargcodo = cuponume
                                 AND (cupotipo = 'AF' OR cupotipo = 'PP')
                                 AND cuponume = pagocupo
                                 AND cupodocu = To_Number(sbFactcodi)), 'dd/MON/yyyy') DATE_INITIAL_PER, --11
                   ---Fin CASO 200-139
                   b.SUSCCLIE,
                   cc.CUCONUSE,
                   mo.package_id   QUOTATION_ID,
                   '' MOTIVE_PAQ
            FROM open.factura  fc,
                 open.cuencobr cc,
                 open.suscripc b,
                 open.servsusc s,
                 OPEN.mo_packages mo,
                 open.cargos ca
            WHERE fc.factcodi = To_Number(sbFactcodi) --:factura --obtenervalorinstancia('FACTURA','FACTCODI')
                  AND fc.factcodi = cc.cucofact
                  AND fc.factsusc = b.susccodi
                  AND b.susccodi = s.sesususc
                  AND cc.cuconuse = s.sesunuse
                  and ca.cargnuse = s.sesunuse
                  AND ca.cargdoso LIKE 'PP-%'
                  AND mo.package_id =  substr(cargdoso, instr(cargdoso, '-') + 1, length(cargdoso))

                  and ca.cargcuco = cc.cucocodi
   and ca.cargnuse = cc.cuconuse
   AND s.sesuserv NOT IN
       (SELECT to_number(column_value)
          FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('SERV_EXC_IMFC',
                                                                                             NULL),
                                                       ',')))
   AND fc.factprog IN
       (SELECT to_number(column_value)
          FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARAPROG_IMFC',
                                                                                             NULL),
                                                       ',')))
   AND ca.cargcaca NOT IN
       (SELECT to_number(column_value)
          FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CAUS_EXC_IMFC',
                                                                                             NULL),
                                                       ',')));


        rccuDatos cuDatos%ROWTYPE;
     CURSOR cuRefTotalVenta IS
            SELECT SUM(Decode(cA.cargsign, 'DB', cA.CARGVALO, -cA.CARGVALO) *
                       decode(nvl(CA.CARGUNID, 1), 0, 1, nvl(CA.CARGUNID, 1))) VALOR_TOTAL_PAGAR
             FROM open.factura     fc,
                 open.cuencobr    cc,
                 open.suscripc    b,
                 open.servsusc    s,
                 open.Mo_Packages MO,
                 open.CARGOS      CA
            WHERE fc.factcodi = To_Number(sBfACTCODI) --:factura --obtenervalorinstancia('FACTURA','FACTCODI')
                  AND fc.factcodi = cc.cucofact
                  AND fc.factsusc = b.susccodi
                  AND b.susccodi = s.sesususc
                  AND cc.cuconuse = s.sesunuse
                        --AND rownum <= 1
                  AND
                  MO.package_id =
                  substr(cargdoso, instr(cargdoso, '-') + 1, length(cargdoso))
                  AND ca.cargcuco = cc.cucocodi
                  AND
                  s.sesuserv NOT IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('SERV_EXC_IMFC', NULL), ',')))
                  AND
                  fc.factprog IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARAPROG_IMFC', NULL), ',')))
                  AND
                  ca.cargcaca NOT IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CAUS_EXC_IMFC', NULL), ',')));

        CURSOR CurIVa IS
            SELECT SUM(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
                       decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1))) VALOR_TOTAL_PAGAR
            FROM open.cargos   c,
                 open.concepto,
                 open.cuencobr cc,
                 open.factura  f,
                 open.servsusc s
            WHERE c.cargtipr = 'A'
                  ---AND c.cargsign IN ('DB', 'CR')
                  AND c.cargcuco > 0
                      --  AND rownum <= 1
                  AND conccodi = c.cargconc
                  AND cc.cucocodi = c.cargcuco
                  AND f.factcodi = cc.cucofact
                  AND f.factcodi = To_Number(sbFactcodi)
                  AND s.sesunuse = c.cargnuse
                  AND c.cargnuse = cc.cuconuse
                  AND
                  s.sesuserv NOT IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('SERV_EXC_IMFC', NULL), ',')))
                  AND
                  f.factprog IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARAPROG_IMFC', NULL), ',')))
                  AND
                  c.cargcaca NOT IN
                  (SELECT to_number(column_value)
                   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CAUS_EXC_IMFC', NULL), ',')))
                  AND UPPER(OPEN.CONCEPTo.CONCDESC) LIKE '%IVA%';

       rccuRefTotalVenta cuRefTotalVenta%ROWTYPE;

        rEGcuRefTotaliva CurIVa%ROWTYPE;

    BEGIN

        ut_trace.trace('*************************** [Mmejia] LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora', 10);

        sbFactcodi :=obtenervalorinstancia('FACTURA', 'FACTCODI');

        ut_trace.trace('*************************** [Mmejia] LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora sbFactcodi: ' ||
                       sbFactcodi, 2);

        --Obtiene los datos principales
        OPEN cuDatos;
        FETCH cuDatos
            INTO rccuDatos;
        CLOSE cuDatos;

        --Obtiene el codigo de cotizacion de la consulta principal
        ---Inicio CASO 200-139
        INUQUOTATION := rccuDatos.Quotation_Id;

         OPEN cuRefTotalVenta;
        FETCH cuRefTotalVenta
            INTO rccuRefTotalVenta;
        CLOSE cuRefTotalVenta;

        OPEN CurIVa;
        FETCH CurIVa
            INTO rEGcuRefTotaliva;
        CLOSE CurIVa;


        OPEN orfcursor FOR
            SELECT To_Char(rccuDatos.ACCOUNT_NUMBER) ACCOUNT_NUMBER,
                   To_Char(rccuDatos.CLIENT_NAME) CLIENT_NAME,
                   To_Char(rccuDatos.CLIENT_NIT) CLIENT_NIT,
                   To_Char(rccuDatos.CLIENT_ADDRESS) CLIENT_ADDRESS,
                   To_Char(rccuDatos.NEIGHBORTHOOD) NEIGHBORTHOOD,
                   To_Char(rccuDatos.CLIENT_E_MAIL) CLIENT_E_MAIL,
                   To_Char(rccuDatos.CLIENT_PHONE) CLIENT_PHONE,
                   To_Char(rccuDatos.DATE_LIMITED_PER) DATE_LIMITED_PER,
                   To_Char(rccuDatos.DATE_INITIAL_PER) DATE_INITIAL_PER,
                   To_Char(rccuDatos.SUSCCLIE) SUSCCLIE,
                   To_Char(rccuDatos.CUCONUSE) CUCONUSE,
                   To_Char(rccuDatos.QUOTATION_ID) QUOTATION_ID,
                   TO_CHAR(Nvl(rccuRefTotalVenta.Valor_Total_Pagar, 0), 'FM999,999,999,990') TOTAL_PAY,
                   To_Char(Nvl(rEGcuRefTotaliva.Valor_Total_Pagar, 0), 'FM999,999,999,990') IMPUESTO_IVA,
                   To_Char('' || rccuDatos.MOTIVE_PAQ) MOTIVE_PAQ
            FROM dual;

        ut_trace.trace('[Mmejia] Fin LDC_DETALLEFACTFISC_CONST.RfDatosFactura Constructora', 10);

    EXCEPTION
        WHEN OTHERS THEN
            Dbms_Output.Put_Line(SQLERRM);
            PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
    END RfDatosFactura_OS;

END LDC_DETALLEFACTFISC_CONST;
/
GRANT EXECUTE on LDC_DETALLEFACTFISC_CONST to SYSTEM_OBJ_PRIVS_ROLE;
/
