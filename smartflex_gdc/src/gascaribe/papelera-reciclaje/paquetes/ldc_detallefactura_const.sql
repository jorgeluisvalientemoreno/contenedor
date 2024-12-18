CREATE OR REPLACE PACKAGE      LDC_DETALLEFACTURA_CONST
IS

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : Ldc_PaymentFormat
    Descripcion    : Paquete que permitir obtener los datos necesarios
                     para el detalle de la factura.
    Autor          : Llozada
    Fecha          : 01/10/2013

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
  Fecha          : 01/10/2013

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  01-10-2013      Llozada             Creacion.
  ******************************************************************/
  Procedure RfDetalleFactura(orfcursor Out constants.tyRefCursor);

      /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDetalleFactura
  Descripcion    : procedimiento para extraer los datos relacionados
                   con la factura.
  Autor          :
  Fecha          : 02/10/2013

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  02-10-2013      Llozada             Creacion.
  ******************************************************************/
  Procedure RfDatosFactura(orfcursor Out constants.tyRefCursor);

  FUNCTION fnuGetIteresesFinanciacion(inuFactcodi in factura.factcodi%type)
  RETURN number;

  FUNCTION fnuGetIteresesMora(inuFactcodi in factura.factcodi%type)
  RETURN number;

  FUNCTION fnuGetIva(inuFactcodi in factura.factcodi%type)
  RETURN number;

END Ldc_DetalleFactura_Const;
/
CREATE OR REPLACE PACKAGE BODY      LDC_DETALLEFACTURA_CONST
IS

    CSBVERSION      CONSTANT varchar2(40)           := 'Aran_3244';
    csbNitGDO       CONSTANT sistema.sistnitc%type  := '800167643-5';
    csbEntrega200591 CONSTANT VARCHAR2(100) := 'CRM_VTA_NCZ_200591';

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : Ldc_PaymentFormat
    Descripcion    : Paquete que permitir obtener los datos necesarios
                     para el detalle de la factura.
    Autor          : Llozada
    Fecha          : 28/09/2013

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
      return CSBVERSION;
    END FSBVERSION;


      /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetIteresesFinanciacion
  Descripcion    : procedimiento para obtener el total de los intereses de
                    financiacion de la factura.
  Autor          :
  Fecha          : 05/11/2013

  Parametros              Descripcion
  ============         ===================
  inuFactcodi          Identificador de la factura

  Fecha             Autor             Modificacion
  =========       =========           ====================
  05-11-2013      smejia             Creacion.
  ******************************************************************/
  FUNCTION fnuGetIteresesFinanciacion(inuFactcodi in factura.factcodi%type)
  RETURN number
  IS
    nuIteresesFinanciacion number;

  BEGIN
    --ut_trace.init;
    --ut_trace.setlevel(99);
    --ut_trace.setoutput(ut_trace.fntrace_output_db);

    ut_trace.trace('*************************** [llozada] fnuIteresesFinanciacion Constructora sbFactcodi: '||inuFactcodi, 2);

    BEGIN
        select  nvl(sum(Intereses),0)
        INTO  nuIteresesFinanciacion
        from
        (
            select  concorim orden,
                    concdefa concepto_desc,
                    conctico tipo_concepto,
                    sum(Intereses) Intereses
            from
            ( select    c.concorim,
                        c.conccodi,
                        c.concdefa,
                        c.conctico,
                        cg.cargconc,
                        cargsign,
               decode(substr(nvl(cg.cargdoso,' '),1,3),'DF-',substr(nvl(cg.cargdoso,' '),4)) Nrodiferido,
               decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) cargvalo,
               (select nvl (sum(cargvalo), 0)
                from open.cuencobr qcc, open.cargos qcg, open.concepto co
                where qcc.cucofact = cc.cucofact --obtenervalorinstancia('FACTURA','FACTCODI')
                  and qcc.cucocodi = qcg.cargcuco
                  and co.conccodi = qcg.cargconc
                  and qcg.cargdoso = 'ID-'||decode(substr(nvl(cg.cargdoso,' '),1,3),'DF-',substr(nvl(cg.cargdoso,' '),4))) Intereses,
               0 Por_IVA
            from open.cuencobr cc, open.cargos cg, open.concepto c
            where cc.cucofact= inuFactcodi --215 --obtenervalorinstancia('FACTURA','FACTCODI')
              and cc.cucocodi = cg.cargcuco
              and cg.cargconc = c.conccodi
              --and c.concticl <> 4
              and (substr(nvl(cargdoso,' '),1,3) NOT IN ('CO-','CB-','ID-') OR cargconc=137)
              AND cargsign <> 'SA'
            )
            group by concorim,concdefa,conctico
            );

    EXCEPTION
            when no_data_found then
                nuIteresesFinanciacion := 0;
    END;

    ut_trace.trace('[llozada] Fin fnuIteresesFinanciacion Constructora', 10);

    return nuIteresesFinanciacion;

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

  END fnuGetIteresesFinanciacion;


  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetIteresesMora
  Descripcion    : procedimiento para obtener el total de los intereses de
                    mora de la factura.
  Autor          :
  Fecha          : 05/11/2013

  Parametros              Descripcion
  ============         ===================
  inuFactcodi          Identificador de la factura

  Fecha             Autor             Modificacion
  =========       =========           ====================
  05-11-2013      smejia             Creacion.
  ******************************************************************/
  FUNCTION fnuGetIteresesMora(inuFactcodi in factura.factcodi%type)
  RETURN number
  IS
    nuIteresesMora number;
  BEGIN

    ut_trace.trace('*************************** [llozada] fnuIteresesMora Constructora sbFactcodi: '||inuFactcodi, 2);

    BEGIN
      select  nvl(sum(Total),0)
      INTO nuIteresesMora
        from
        (
            select  orden, concepto_desc,
                    sum(Total) Total,
                    tipo_concepto
            from(
            select c.concorim orden,
                   c.concdefa concepto_desc,
                   c.conctico tipo_concepto,
                   decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) Total
            from open.cuencobr cc, open.cargos cg, open.concepto c
            where cc.cucofact  = inuFactcodi --215 --obtenervalorinstancia('FACTURA','FACTCODI')
              and cc.cucocodi = cg.cargcuco
              AND c.concticl = 5
              and (substr(nvl(cargdoso,' '),1,3) IN ('CO-','CB-', 'AJ-')
              OR (cargconc=137 and (substr(nvl(cargdoso,' '),1,3) not IN ('ID-','DF-'))) )
              and cg.cargconc = c.conccodi
              --and c.concticl in (1,2,4)  -- consumo
            union all
            select  concorim orden,
                    concdefa concepto_desc,
                    conctico tipo_concepto,
                    decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) Total
            from
            ( select    c.concorim,
                        c.conccodi,
                        c.concdefa,
                        c.conctico,
                        cg.cargconc,
                        cargsign,
               decode(substr(nvl(cg.cargdoso,' '),1,3),'DF-',substr(nvl(cg.cargdoso,' '),4)) Nrodiferido,
               decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) cargvalo,
               (select nvl (sum(cargvalo), 0)
                from open.cuencobr qcc, open.cargos qcg, open.concepto co
                where qcc.cucofact = cc.cucofact --obtenervalorinstancia('FACTURA','FACTCODI')
                  and qcc.cucocodi = qcg.cargcuco
                  and co.conccodi = qcg.cargconc
                  and qcg.cargdoso = 'ID-'||decode(substr(nvl(cg.cargdoso,' '),1,3),'DF-',substr(nvl(cg.cargdoso,' '),4))) Intereses,
               0 Por_IVA
            from open.cuencobr cc, open.cargos cg, open.concepto c
            where cc.cucofact= inuFactcodi --215 --obtenervalorinstancia('FACTURA','FACTCODI')
              and cc.cucocodi = cg.cargcuco
              and cg.cargconc = c.conccodi
              AND c.concticl = 5
              --and c.concticl <> 4
              and (substr(nvl(cargdoso,' '),1,3) NOT IN ('CO-','CB-','ID-') OR cargconc=137)
              AND cargsign <> 'SA'
            )
                )group by orden,concepto_desc,tipo_concepto
            );

    EXCEPTION
            when no_data_found then
                nuIteresesMora:=0;
    END;

    ut_trace.trace('[llozada] Fin fnuIteresesMora Constructora', 10);

    return nuIteresesMora;

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

  END fnuGetIteresesMora;

    /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetIva
  Descripcion    : Obtiene el valor del impuesto de IVA.
  Autor          :
  Fecha          : 05/11/2013

  Parametros              Descripcion
  ============         ===================
  inuFactcodi          Identificador de la factura

  Fecha             Autor             Modificacion
  =========       =========           ====================
  05-11-2013      smejia             Creacion.
  26-03-2014      smejia             Aranda 3244. Se modifica la consulta para que sume los totales de los
                                     cargos de IVA, cuand la factura tenga asociados varios cargos de IVA..
  02-09-2016      NCarrasquilla       Caso 200-591. Se modifica la consulta para que tome en cuenta la causal 50.
  ******************************************************************/
  FUNCTION fnuGetIva(inuFactcodi in factura.factcodi%type)
  RETURN number
  IS
    nuIva number;
  BEGIN

    ut_trace.trace('*************************** [llozada] fnuIteresesMora Constructora sbFactcodi: '||inuFactcodi, 2);

    BEGIN

      IF fblaplicaentrega(csbEntrega200591) THEN
        select  nvl(sum(Total),0)
        INTO  nuIva
           FROM (
          select c.concorim   orden,
                 c.concdefa   concepto_desc,
                 c.conctico   tipo_concepto,
                 0            cod_financia,
                 0            Saldo_Anterior,
                 0            Abono_Capital,
                 0            Intereses,
                 (case when cargconc=137 then cargvalo else 0 end) Iva,
                 decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) Total,
                 0            Saldo_posterior_pago,
                 0            Cuotas_pendientes,
                 0            interes_financiacion
          from factura f,cuencobr cc, cargos cg, concepto c
          where cg.cargconc = c.conccodi
            and f.factcodi = cc.cucofact
            and cc.cucocodi = cg.cargcuco
            and c.concticl = 4
            AND cg.cargcaca in (15,53,50)
            and factcodi  =  inuFactcodi)
              ;
      ELSE
        select  nvl(sum(Total),0)
        INTO  nuIva
           FROM (
          select c.concorim   orden,
                 c.concdefa   concepto_desc,
                 c.conctico   tipo_concepto,
                 0            cod_financia,
                 0            Saldo_Anterior,
                 0            Abono_Capital,
                 0            Intereses,
                 (case when cargconc=137 then cargvalo else 0 end) Iva,
                 decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) Total,
                 0            Saldo_posterior_pago,
                 0            Cuotas_pendientes,
                 0            interes_financiacion
          from factura f,cuencobr cc, cargos cg, concepto c
          where cg.cargconc = c.conccodi
            and f.factcodi = cc.cucofact
            and cc.cucocodi = cg.cargcuco
            and c.concticl = 4
            AND cg.cargcaca in (15,53)
            and factcodi  =  inuFactcodi)
              ;
      END IF;
    EXCEPTION
            when no_data_found then
                nuIva:=0;
    END;

    ut_trace.trace('[llozada] Fin fnuIteresesMora Constructora', 10);

    return nuIva;

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

  END fnuGetIva;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDetalleFactura
  Descripcion    : procedimiento para extraer los datos relacionados
                   con el detalle de la factura.
  Autor          :
  Fecha          : 01/10/2013

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  01-10-2013      Llozada             Creacion.
  02/09/2014      oparra              Aranda 4507 - TEAM 1599
                                      Modificacion en el formato de factura constructoras, para que no retorne
                                      el cargo de Saldo anterior para GDO.
  02-09-2016      NCarrasquilla       Caso 200-591. Se modifica la consulta para que no muestre el IVA en el detalle
  ******************************************************************/
  Procedure RfDetalleFactura(orfcursor Out constants.tyRefCursor) IS

    sbFactcodi      ge_boInstanceControl.stysbValue;
    sbNitEmpresa    sistema.sistnitc%type;
    nuFlagGDO       number;

    -- Cursor para consultar el NIT de la Empresa
    CURSOR cuNitEmpresa is
        select sistnitc
        from open.sistema;

  BEGIN

    ut_trace.trace('*************************** [llozada] RfDetalleFactura Constructora', 10);

    -- validacion si aplica para GDO
    open cuNitEmpresa;
    fetch cuNitEmpresa into sbNitEmpresa;
    close cuNitEmpresa;

    if sbNitEmpresa is not null then
        if trim(sbNitEmpresa) = csbNitGDO then
            nuFlagGDO := 1;
        else
            nuFlagGDO := 0;
        end if;
    end if;

    sbFactcodi := obtenervalorinstancia('FACTURA','FACTCODI');
    -- Por si no funciona la factura en la instancia
    --sbDOCUCODI := Pkboca_Print.fnuGetDocumentBox;
    ut_trace.trace('*************************** [llozada] RfDetalleFactura Constructora sbFactcodi: '||sbFactcodi, 2);

    IF fblaplicaentrega(csbEntrega200591) THEN
    open orfcursor for
        SELECT  concepto_desc,
          '$'||to_char(Saldo_Anterior, 'FM999,999,990.00' ) Saldo_Anterior,
          '$'||to_char(Abono_Capital, 'FM999,999,990.00' ) Abono_Capital,
          '$'||to_char(Intereses, 'FM999,999,990.00' ) Intereses,
          Iva,
          '$'||to_char(Total, 'FM999,999,990.00' ) Total,
          Saldo_posterior_pago,
          Cuotas_pendientes,
          Interes_financiacion||'%' Interes_financiacion,
          tipo_concepto,
          CUOTASPACT
          from (
                        SELECT   concepto_desc,
                                 tipo_concepto,
                                 cod_financia,
                                 Saldo_Anterior,
                                 Abono_Capital,
                                 Intereses,
                                 Iva,
                                 Total,
                                 Saldo_posterior_pago,
                                 Cuotas_pendientes,
                                 interes_financiacion,
                                 0            CUOTASPACT
                           FROM (
                          select c.concorim   orden,
                                 c.concdefa   concepto_desc,
                                 c.conctico   tipo_concepto,
                                 0            cod_financia,
                                 0            Saldo_Anterior,
                                 0            Abono_Capital,
                                 0            Intereses,
                                 (case when cargconc=137 then cargvalo else 0 end) Iva,
                                 decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) Total,
                                 0            Saldo_posterior_pago,
                                 0            Cuotas_pendientes,
                                 0            interes_financiacion
                          from factura f,cuencobr cc, cargos cg, concepto c
                          where cg.cargconc = c.conccodi
                            and f.factcodi = cc.cucofact
                            and cc.cucocodi = cg.cargcuco
                            and (substr(nvl(cargdoso,' '),1,3) IN ('CO-','CB-') OR (cargconc in (137,196,37) and (substr(nvl(cargdoso,' '),1,3) not IN ('ID-','DF-'))) )
                            and c.concticl in (1,2)  -- consumo
                            and factcodi  =  sbFactcodi)
                          WHERE Total <> 0

                          union all

                          select  concepto_desc,tipo_concepto, 0 cod_financia,
                          sum(Saldo_Anterior) Saldo_Anterior , 0 Abono_Capital,
                          sum(Intereses) Intereses, sum(Iva) Iva, sum( Total),
                          sum(Saldo_posterior_pago) Saldo_posterior_pago,
                          max(Cuotas_pendientes) Cuotas_pendientes,
                          max(interes_financiacion) interes_financiacion,
                          max(CUOTASPACT)            CUOTASPACT
                          from(
                              select  concorim    orden,
                                      concdefa    concepto_desc,
                                      conctico    tipo_concepto,
                                      nvl((   select difesape
                                              from diferido
                                              where difecodi = Nrodiferido
                                           )+cargvalo,0) Saldo_Anterior,
                                      cargvalo    Abono_Capital,
                                      Intereses   Intereses,
                                      (case when cargconc=137 then cargvalo else 0 end) Iva,
                                      cargvalo Total,
                                      nvl((select difesape
                                          from diferido
                                          where difecodi = Nrodiferido),0) Saldo_posterior_pago,
                                      nvl((select (difenucu-difecupa)
                                      from diferido where difecodi = Nrodiferido),0) Cuotas_pendientes,
                                      nvl((select difeinte
                                      from diferido where difecodi = Nrodiferido),0) interes_financiacion,
                                      nvl((select difenucu from open.diferido where difecodi = Nrodiferido),0)            CUOTASPACT
                              FROM ( select   c.concorim, c.conccodi, c.concdefa, c.conctico, cg.cargsign, cg.cargdoso, cg.cargconc,
                                              decode(substr(nvl(cg.cargdoso,' '),1,3),'DF-',substr(nvl(cg.cargdoso,' '),4)) Nrodiferido,
                                              decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) cargvalo,
                                              (   select
                                                          nvl (sum(cargvalo), 0)
                                                  from factura qf,cuencobr qcc, cargos qcg, concepto co
                                                  where qf.factcodi = qcc.cucofact
                                                  and qcc.cucocodi = qcg.cargcuco
                                                  and co.conccodi = qcg.cargconc
                                                  and qcg.cargdoso = 'ID-'||decode(substr(nvl(cg.cargdoso,' '),1,3),'DF-',substr(nvl(cg.cargdoso,' '),4))
                                                  and qf.factcodi = f.factcodi
                                                ) Intereses
                                             ,0 Por_IVA
                                      from factura f,cuencobr cc, cargos cg, concepto c
                                      where cg.cargconc = c.conccodi
                                        and f.factcodi = cc.cucofact
                                        and cc.cucocodi = cg.cargcuco
                                        and (c.concticl <> 4 /*or cg.cargcaca not in (15,53)*/)
                                        AND cargconc not in (137,196,37)
                                        and (substr(nvl(cargdoso,' '),1,3) NOT IN ('CO-','DF-','ID-','CB-') )
                                        AND cargsign <> 'SA'
                                        and f.factcodi   = sbFactcodi
                                      )
                           )
                       group by concepto_desc,tipo_concepto
                       HAVING sum(Abono_Capital)+sum(Intereses)+sum(Total) <>0

                       UNION ALL


                       SELECT   concepto_desc, tipo_concepto, cod_financia, sum(Saldo_Anterior) Saldo_Anterior,
                                sum(Abono_Capital) Abono_Capital, sum(Intereses) Intereses, sum(Iva) Iva, sum(Total) Total,
                                sum(Saldo_posterior_pago) Saldo_posterior_pago, max(Cuotas_pendientes) Cuotas_pendientes,
                                max(interes_financiacion) interes_financiacion,
                                max(CUOTASPACT)            CUOTASPACT
                       FROM (
                       select     concorim    orden,
                                  concdefa    concepto_desc,
                                  conctico    tipo_concepto,
                                  (select difecofi
                                  from diferido where difecodi = Nrodiferido) cod_financia,
                                  nvl((   select difesape
                                          from diferido
                                          where difecodi = Nrodiferido
                                       )+cargvalo,0)   Saldo_Anterior,
                                  cargvalo    Abono_Capital,
                                  nvl(Intereses,0)   Intereses,
                                  (case when cargconc=173 then cargvalo else 0 end) Iva,
                                  0 Total,
                                  (nvl((select difesape
                                          from diferido
                                          where difecodi = Nrodiferido),0))  Saldo_posterior_pago,
                                  (nvl((select (difenucu-difecupa)
                                  from diferido where difecodi = Nrodiferido),0)) Cuotas_pendientes,

                                  ((power( 1 + nvl( (select difeinte
                                                      from diferido
                                                      where difecodi = Nrodiferido),0)/100,
                                       (1/12) ) -1) *100)
                                  interes_financiacion,
                                  nvl((select difenucu from open.diferido where difecodi = Nrodiferido),0)            CUOTASPACT
                          FROM ( select   cargcuco,c.concorim, c.conccodi, c.concdefa, c.conctico, cg.cargsign, cg.cargdoso, cg.cargconc,
                                          decode(substr(nvl(cg.cargdoso,' '),1,3),'DF-',substr(nvl(cg.cargdoso,' '),4)) Nrodiferido,
                                          decode(substr(nvl(cargdoso,' '),1,3),'DF-',cargvalo,0) cargvalo,
                                          --decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) cargvalo,
                                          (select cargvalo
                                           from cargos abz where cg.cargcuco = abz.cargcuco
                                                                  and substr(nvl(abz.cargdoso,' '),4,length(abz.cargdoso)) = substr(nvl(cg.cargdoso,' '),4,length(cg.cargdoso))
                                                                  and substr(nvl(cargdoso,' '),1,3) IN ('ID-')
                                                                   ) Intereses
                                          --decode(substr(nvl(cargdoso,' '),1,3),'ID-',cargvalo,0) Intereses
                                         ,0 Por_IVA
                                  from factura f,cuencobr cc, cargos cg, concepto c
                                  where cg.cargconc = c.conccodi
                                    and f.factcodi = cc.cucofact
                                    and cc.cucocodi = cg.cargcuco
                                    --and c.concticl <> 4
                                    and (substr(nvl(cargdoso,' '),1,3) IN ('DF-') )
                                    AND cargsign <> 'SA'
                                    and f.factcodi   = sbFactcodi
                                  ))
                         group by concepto_desc,tipo_concepto,cod_financia
                         HAVING sum(Abono_Capital)+sum(Intereses)+sum(Total) <>0

                         UNION ALL

                         SELECT   concepto_desc, tipo_concepto, cod_financia, sum(Saldo_Anterior) Saldo_Anterior,
                                sum(Abono_Capital) Abono_Capital, sum(Intereses) Intereses, sum(Iva) Iva, sum(Total) Total,
                                sum(Saldo_posterior_pago) Saldo_posterior_pago, max(Cuotas_pendientes) Cuotas_pendientes,
                                max(interes_financiacion) interes_financiacion,
                                max(CUOTASPACT)            CUOTASPACT
                          FROM (
                           select     concorim    orden,
                                      concdefa    concepto_desc,
                                      conctico    tipo_concepto,
                                      (select difecofi
                                      from diferido where difecodi = Nrodiferido) cod_financia,
                                      nvl((   select difesape
                                              from diferido
                                              where difecodi = Nrodiferido
                                           )+cargvalo,0)   Saldo_Anterior,
                                      cargvalo    Abono_Capital,
                                      nvl(Intereses,0)   Intereses,
                                      (case when cargconc=173 then cargvalo else 0 end) Iva,
                                      0 Total,
                                      (nvl((select difesape
                                              from diferido
                                              where difecodi = Nrodiferido),0))  Saldo_posterior_pago,
                                      (nvl((select (difenucu-difecupa)
                                      from diferido where difecodi = Nrodiferido),0)) Cuotas_pendientes,

                                      ((power( 1 + nvl( (select difeinte
                                                          from diferido
                                                          where difecodi = Nrodiferido),0)/100,
                                           (1/12) ) -1) *100)
                                      interes_financiacion
                                      ,nrodiferido
                                      ,nvl((select difenucu from open.diferido where difecodi = Nrodiferido),0)            CUOTASPACT

                              FROM ( select   cargcuco,c.concorim, c.conccodi, c.concdefa, c.conctico, cg.cargsign, cg.cargdoso, cg.cargconc,
                                              decode(substr(nvl(cg.cargdoso,' '),1,3),'ID-',substr(nvl(cg.cargdoso,' '),4)) Nrodiferido,
                                              decode(substr(nvl(cargdoso,' '),1,3),'ID-',cargvalo,0) cargvalo,
                                              --decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) cargvalo,
                                              0 Intereses
                                              --decode(substr(nvl(cargdoso,' '),1,3),'ID-',cargvalo,0) Intereses
                                             ,0 Por_IVA
                                      from factura f,cuencobr cc, cargos cg, concepto c
                                      where cg.cargconc = c.conccodi
                                        and f.factcodi = cc.cucofact
                                        and cc.cucocodi = cg.cargcuco
                                        --and c.concticl <> 4
                                        and (substr(nvl(cargdoso,' '),1,3) IN ('ID-') )
                                        AND cargsign <> 'SA'
                                        and f.factcodi   = sbFactcodi
                                      ) a
                                  WHERE not exists (
                                  SELECT 1 FROM (
                                  SELECT cargcuco, cargconc, decode(substr(nvl(cg.cargdoso,' '),1,3),'DF-',substr(nvl(cg.cargdoso,' '),4)) Nrodiferido
                                  from factura f,cuencobr cc, cargos cg, concepto c
                                  where cg.cargconc = c.conccodi
                                        and f.factcodi = cc.cucofact
                                        and cc.cucocodi = cg.cargcuco
                                        --and c.concticl <> 4
                                        and (substr(nvl(cargdoso,' '),1,3) IN ('DF-') )
                                        AND cargsign <> 'SA'
                                        and f.factcodi   = sbFactcodi ) b
                                   WHERE a.cargcuco = b.cargcuco
                                   AND a.Nrodiferido = b.Nrodiferido
                                  )
                                  )
                             group by concepto_desc,tipo_concepto,cod_financia
                             HAVING sum(Abono_Capital)+sum(Intereses)+sum(Total) <>0
          )
          /**** Aranda 4507 - TEAM 1599 - Si la compa?ia es GDO no aplica este bloque *****/
          union all
          select 'SALDO ANTERIOR' concepto_desc,
              '$0.00' Saldo_Anterior,
              '$0.00' Abono_Capital,
              '$0.00' Intereses,
              0 Iva,
              '$'||to_char(PKBOBILLPRINTHEADERRULES.FNUGETTOTALPREVIOUSBALANCE, 'FM999,999,990.00') Total,
              0 Saldo_posterior_pago,
              0 Cuotas_pendientes,
              to_char(0)||'%' interes_financiacion,
              0 tipo_concepto
              , 0            CUOTASPACT
          FROM DUAL
          WHERE PKBOBILLPRINTHEADERRULES.FNUGETTOTALPREVIOUSBALANCE <> 0
          and 0 = decode(nuflagGDO, 1, 1, 0, 0, 0)
          /******-------------------------*****/
/*          UNION ALL
          SELECT     'IVA' concepto_desc,
                   '$0.00' Saldo_Anterior,
                   '$0.00' Abono_Capital,
                   '$0.00' Intereses,
                   0 Iva,
                   '$'||to_char(sum(Total), 'FM999,999,990.00') Total,
                   0 Saldo_posterior_pago,
                   0 Cuotas_pendientes,
                   to_char(0)||'%' interes_financiacion,
                   0 tipo_concepto,
                  0            CUOTASPACT
           FROM (
          select c.concorim   orden,
                 c.concdefa   concepto_desc,
                 c.conctico   tipo_concepto,
                 0            cod_financia,
                 0            Saldo_Anterior,
                 0            Abono_Capital,
                 0            Intereses,
                 (case when cargconc=137 then cargvalo else 0 end) Iva,
                 decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) Total,
                 0            Saldo_posterior_pago,
                 0            Cuotas_pendientes,
                 0            interes_financiacion
          from factura f,cuencobr cc, cargos cg, concepto c
          where cg.cargconc = c.conccodi
            and f.factcodi = cc.cucofact
            and cc.cucocodi = cg.cargcuco
            and c.concticl = 4
            AND cg.cargcaca in (15,53)
            and factcodi  =  sbFactcodi)
          HAVING sum(Total) <> 0*/
          ;
    ELSE
      open orfcursor for
        SELECT  concepto_desc,
          '$'||to_char(Saldo_Anterior, 'FM999,999,990.00' ) Saldo_Anterior,
          '$'||to_char(Abono_Capital, 'FM999,999,990.00' ) Abono_Capital,
          '$'||to_char(Intereses, 'FM999,999,990.00' ) Intereses,
          Iva,
          '$'||to_char(Total, 'FM999,999,990.00' ) Total,
          Saldo_posterior_pago,
          Cuotas_pendientes,
          Interes_financiacion||'%' Interes_financiacion,
          tipo_concepto,
          CUOTASPACT
          from (
                        SELECT   concepto_desc,
                                 tipo_concepto,
                                 cod_financia,
                                 Saldo_Anterior,
                                 Abono_Capital,
                                 Intereses,
                                 Iva,
                                 Total,
                                 Saldo_posterior_pago,
                                 Cuotas_pendientes,
                                 interes_financiacion,
                                 0            CUOTASPACT
                           FROM (
                          select c.concorim   orden,
                                 c.concdefa   concepto_desc,
                                 c.conctico   tipo_concepto,
                                 0            cod_financia,
                                 0            Saldo_Anterior,
                                 0            Abono_Capital,
                                 0            Intereses,
                                 (case when cargconc=137 then cargvalo else 0 end) Iva,
                                 decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) Total,
                                 0            Saldo_posterior_pago,
                                 0            Cuotas_pendientes,
                                 0            interes_financiacion
                          from factura f,cuencobr cc, cargos cg, concepto c
                          where cg.cargconc = c.conccodi
                            and f.factcodi = cc.cucofact
                            and cc.cucocodi = cg.cargcuco
                            and (substr(nvl(cargdoso,' '),1,3) IN ('CO-','CB-') OR (cargconc in (137,196,37) and (substr(nvl(cargdoso,' '),1,3) not IN ('ID-','DF-'))) )
                            and c.concticl in (1,2)  -- consumo
                            and factcodi  =  sbFactcodi)
                          WHERE Total <> 0

                          union all

                          select  concepto_desc,tipo_concepto, 0 cod_financia,
                          sum(Saldo_Anterior) Saldo_Anterior , 0 Abono_Capital,
                          sum(Intereses) Intereses, sum(Iva) Iva, sum( Total),
                          sum(Saldo_posterior_pago) Saldo_posterior_pago,
                          max(Cuotas_pendientes) Cuotas_pendientes,
                          max(interes_financiacion) interes_financiacion,
                          max(CUOTASPACT)            CUOTASPACT
                          from(
                              select  concorim    orden,
                                      concdefa    concepto_desc,
                                      conctico    tipo_concepto,
                                      nvl((   select difesape
                                              from diferido
                                              where difecodi = Nrodiferido
                                           )+cargvalo,0) Saldo_Anterior,
                                      cargvalo    Abono_Capital,
                                      Intereses   Intereses,
                                      (case when cargconc=137 then cargvalo else 0 end) Iva,
                                      cargvalo Total,
                                      nvl((select difesape
                                          from diferido
                                          where difecodi = Nrodiferido),0) Saldo_posterior_pago,
                                      nvl((select (difenucu-difecupa)
                                      from diferido where difecodi = Nrodiferido),0) Cuotas_pendientes,
                                      nvl((select difeinte
                                      from diferido where difecodi = Nrodiferido),0) interes_financiacion,
                                      nvl((select difenucu from open.diferido where difecodi = Nrodiferido),0)            CUOTASPACT
                              FROM ( select   c.concorim, c.conccodi, c.concdefa, c.conctico, cg.cargsign, cg.cargdoso, cg.cargconc,
                                              decode(substr(nvl(cg.cargdoso,' '),1,3),'DF-',substr(nvl(cg.cargdoso,' '),4)) Nrodiferido,
                                              decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) cargvalo,
                                              (   select
                                                          nvl (sum(cargvalo), 0)
                                                  from factura qf,cuencobr qcc, cargos qcg, concepto co
                                                  where qf.factcodi = qcc.cucofact
                                                  and qcc.cucocodi = qcg.cargcuco
                                                  and co.conccodi = qcg.cargconc
                                                  and qcg.cargdoso = 'ID-'||decode(substr(nvl(cg.cargdoso,' '),1,3),'DF-',substr(nvl(cg.cargdoso,' '),4))
                                                  and qf.factcodi = f.factcodi
                                                ) Intereses
                                             ,0 Por_IVA
                                      from factura f,cuencobr cc, cargos cg, concepto c
                                      where cg.cargconc = c.conccodi
                                        and f.factcodi = cc.cucofact
                                        and cc.cucocodi = cg.cargcuco
                                        and (c.concticl <> 4 or cg.cargcaca not in (15,53))
                                        AND cargconc not in (137,196,37)
                                        and (substr(nvl(cargdoso,' '),1,3) NOT IN ('CO-','DF-','ID-','CB-') )
                                        AND cargsign <> 'SA'
                                        and f.factcodi   = sbFactcodi
                                      )
                           )
                       group by concepto_desc,tipo_concepto
                       HAVING sum(Abono_Capital)+sum(Intereses)+sum(Total) <>0

                       UNION ALL


                       SELECT   concepto_desc, tipo_concepto, cod_financia, sum(Saldo_Anterior) Saldo_Anterior,
                                sum(Abono_Capital) Abono_Capital, sum(Intereses) Intereses, sum(Iva) Iva, sum(Total) Total,
                                sum(Saldo_posterior_pago) Saldo_posterior_pago, max(Cuotas_pendientes) Cuotas_pendientes,
                                max(interes_financiacion) interes_financiacion,
                                max(CUOTASPACT)            CUOTASPACT
                       FROM (
                       select     concorim    orden,
                                  concdefa    concepto_desc,
                                  conctico    tipo_concepto,
                                  (select difecofi
                                  from diferido where difecodi = Nrodiferido) cod_financia,
                                  nvl((   select difesape
                                          from diferido
                                          where difecodi = Nrodiferido
                                       )+cargvalo,0)   Saldo_Anterior,
                                  cargvalo    Abono_Capital,
                                  nvl(Intereses,0)   Intereses,
                                  (case when cargconc=173 then cargvalo else 0 end) Iva,
                                  0 Total,
                                  (nvl((select difesape
                                          from diferido
                                          where difecodi = Nrodiferido),0))  Saldo_posterior_pago,
                                  (nvl((select (difenucu-difecupa)
                                  from diferido where difecodi = Nrodiferido),0)) Cuotas_pendientes,

                                  ((power( 1 + nvl( (select difeinte
                                                      from diferido
                                                      where difecodi = Nrodiferido),0)/100,
                                       (1/12) ) -1) *100)
                                  interes_financiacion,
                                  nvl((select difenucu from open.diferido where difecodi = Nrodiferido),0)            CUOTASPACT
                          FROM ( select   cargcuco,c.concorim, c.conccodi, c.concdefa, c.conctico, cg.cargsign, cg.cargdoso, cg.cargconc,
                                          decode(substr(nvl(cg.cargdoso,' '),1,3),'DF-',substr(nvl(cg.cargdoso,' '),4)) Nrodiferido,
                                          decode(substr(nvl(cargdoso,' '),1,3),'DF-',cargvalo,0) cargvalo,
                                          --decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) cargvalo,
                                          (select cargvalo
                                           from cargos abz where cg.cargcuco = abz.cargcuco
                                                                  and substr(nvl(abz.cargdoso,' '),4,length(abz.cargdoso)) = substr(nvl(cg.cargdoso,' '),4,length(cg.cargdoso))
                                                                  and substr(nvl(cargdoso,' '),1,3) IN ('ID-')
                                                                   ) Intereses
                                          --decode(substr(nvl(cargdoso,' '),1,3),'ID-',cargvalo,0) Intereses
                                         ,0 Por_IVA
                                  from factura f,cuencobr cc, cargos cg, concepto c
                                  where cg.cargconc = c.conccodi
                                    and f.factcodi = cc.cucofact
                                    and cc.cucocodi = cg.cargcuco
                                    --and c.concticl <> 4
                                    and (substr(nvl(cargdoso,' '),1,3) IN ('DF-') )
                                    AND cargsign <> 'SA'
                                    and f.factcodi   = sbFactcodi
                                  ))
                         group by concepto_desc,tipo_concepto,cod_financia
                         HAVING sum(Abono_Capital)+sum(Intereses)+sum(Total) <>0

                         UNION ALL

                         SELECT   concepto_desc, tipo_concepto, cod_financia, sum(Saldo_Anterior) Saldo_Anterior,
                                sum(Abono_Capital) Abono_Capital, sum(Intereses) Intereses, sum(Iva) Iva, sum(Total) Total,
                                sum(Saldo_posterior_pago) Saldo_posterior_pago, max(Cuotas_pendientes) Cuotas_pendientes,
                                max(interes_financiacion) interes_financiacion,
                                max(CUOTASPACT)            CUOTASPACT
                          FROM (
                           select     concorim    orden,
                                      concdefa    concepto_desc,
                                      conctico    tipo_concepto,
                                      (select difecofi
                                      from diferido where difecodi = Nrodiferido) cod_financia,
                                      nvl((   select difesape
                                              from diferido
                                              where difecodi = Nrodiferido
                                           )+cargvalo,0)   Saldo_Anterior,
                                      cargvalo    Abono_Capital,
                                      nvl(Intereses,0)   Intereses,
                                      (case when cargconc=173 then cargvalo else 0 end) Iva,
                                      0 Total,
                                      (nvl((select difesape
                                              from diferido
                                              where difecodi = Nrodiferido),0))  Saldo_posterior_pago,
                                      (nvl((select (difenucu-difecupa)
                                      from diferido where difecodi = Nrodiferido),0)) Cuotas_pendientes,

                                      ((power( 1 + nvl( (select difeinte
                                                          from diferido
                                                          where difecodi = Nrodiferido),0)/100,
                                           (1/12) ) -1) *100)
                                      interes_financiacion
                                      ,nrodiferido
                                      ,nvl((select difenucu from open.diferido where difecodi = Nrodiferido),0)            CUOTASPACT

                              FROM ( select   cargcuco,c.concorim, c.conccodi, c.concdefa, c.conctico, cg.cargsign, cg.cargdoso, cg.cargconc,
                                              decode(substr(nvl(cg.cargdoso,' '),1,3),'ID-',substr(nvl(cg.cargdoso,' '),4)) Nrodiferido,
                                              decode(substr(nvl(cargdoso,' '),1,3),'ID-',cargvalo,0) cargvalo,
                                              --decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) cargvalo,
                                              0 Intereses
                                              --decode(substr(nvl(cargdoso,' '),1,3),'ID-',cargvalo,0) Intereses
                                             ,0 Por_IVA
                                      from factura f,cuencobr cc, cargos cg, concepto c
                                      where cg.cargconc = c.conccodi
                                        and f.factcodi = cc.cucofact
                                        and cc.cucocodi = cg.cargcuco
                                        --and c.concticl <> 4
                                        and (substr(nvl(cargdoso,' '),1,3) IN ('ID-') )
                                        AND cargsign <> 'SA'
                                        and f.factcodi   = sbFactcodi
                                      ) a
                                  WHERE not exists (
                                  SELECT 1 FROM (
                                  SELECT cargcuco, cargconc, decode(substr(nvl(cg.cargdoso,' '),1,3),'DF-',substr(nvl(cg.cargdoso,' '),4)) Nrodiferido
                                  from factura f,cuencobr cc, cargos cg, concepto c
                                  where cg.cargconc = c.conccodi
                                        and f.factcodi = cc.cucofact
                                        and cc.cucocodi = cg.cargcuco
                                        --and c.concticl <> 4
                                        and (substr(nvl(cargdoso,' '),1,3) IN ('DF-') )
                                        AND cargsign <> 'SA'
                                        and f.factcodi   = sbFactcodi ) b
                                   WHERE a.cargcuco = b.cargcuco
                                   AND a.Nrodiferido = b.Nrodiferido
                                  )
                                  )
                             group by concepto_desc,tipo_concepto,cod_financia
                             HAVING sum(Abono_Capital)+sum(Intereses)+sum(Total) <>0
          )
          /**** Aranda 4507 - TEAM 1599 - Si la compa?ia es GDO no aplica este bloque *****/
          union all
          select 'SALDO ANTERIOR' concepto_desc,
              '$0.00' Saldo_Anterior,
              '$0.00' Abono_Capital,
              '$0.00' Intereses,
              0 Iva,
              '$'||to_char(PKBOBILLPRINTHEADERRULES.FNUGETTOTALPREVIOUSBALANCE, 'FM999,999,990.00') Total,
              0 Saldo_posterior_pago,
              0 Cuotas_pendientes,
              to_char(0)||'%' interes_financiacion,
              0 tipo_concepto
              , 0            CUOTASPACT
          FROM DUAL
          WHERE PKBOBILLPRINTHEADERRULES.FNUGETTOTALPREVIOUSBALANCE <> 0
          and 0 = decode(nuflagGDO, 1, 1, 0, 0, 0)
          /******-------------------------*****/
          UNION ALL
          SELECT     'IVA' concepto_desc,
                   '$0.00' Saldo_Anterior,
                   '$0.00' Abono_Capital,
                   '$0.00' Intereses,
                   0 Iva,
                   '$'||to_char(sum(Total), 'FM999,999,990.00') Total,
                   0 Saldo_posterior_pago,
                   0 Cuotas_pendientes,
                   to_char(0)||'%' interes_financiacion,
                   0 tipo_concepto,
                  0            CUOTASPACT
           FROM (
          select c.concorim   orden,
                 c.concdefa   concepto_desc,
                 c.conctico   tipo_concepto,
                 0            cod_financia,
                 0            Saldo_Anterior,
                 0            Abono_Capital,
                 0            Intereses,
                 (case when cargconc=137 then cargvalo else 0 end) Iva,
                 decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) Total,
                 0            Saldo_posterior_pago,
                 0            Cuotas_pendientes,
                 0            interes_financiacion
          from factura f,cuencobr cc, cargos cg, concepto c
          where cg.cargconc = c.conccodi
            and f.factcodi = cc.cucofact
            and cc.cucocodi = cg.cargcuco
            and c.concticl = 4
            AND cg.cargcaca in (15,53)
            and factcodi  =  sbFactcodi)
          HAVING sum(Total) <> 0;
    END IF;
    ut_trace.trace('[llozada] Fin RfDetalleFactura Constructora', 10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

  END RfDetalleFactura;

    /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDetalleFactura
  Descripcion    : procedimiento para extraer los datos relacionados
                   con la factura.
  Autor          :
  Fecha          : 02/10/2013

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del detalle de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  02-10-2013      Llozada             Creacion.
  25-11-2013      smejia              No conformidad 464 v4. Se modifica la obtencion del valor de contrato,
                                      subtotal de servicios contratados, amortizacion de anticipo, total a pagar, y
                                      valor a pagar del cupon y codigo de barras. Adicionalmente se modifica el formato de presentacion
                                      de la fecha de expedicion, totales y subtotales.
  16-06-2014      oparra              Aranda 3787.
                                      Cambio campo "Total a Pagar", se resta la amortizaci?n concepto Aplicacion Saldo
                                      a Favor  Codigo 9. (Se consulta de la tabla PARAFACT)
  02/09/2014      oparra              Aranda 4507 - TEAM 1599
                                      Modificacion en el formato de factura constructoras
                                      Amortizaci?n y valor total.
  29/10/2014       oparra             Team 3262. Se cambia el formato de la plantilla para GDO
                                      No se resta la amortizacion en el "Valor total a pagar" y
                                      se adiciona descripcion de Retenedor de Impuesto, parametro en "sbDesImpuesto"
  ******************************************************************/
  Procedure RfDatosFactura(orfcursor Out constants.tyRefCursor) IS

    sbFactcodi      ge_boInstanceControl.stysbValue;
    sbCodBarras     ld_parameter.value_chain%type;
    sbDesImpuesto   ld_parameter.value_chain%type;
    nuConAntVe      number;                 -- Concepto Anticipo de venta (301)
    nuConcASAF      number;                 -- nuevo Concepto aplicaci?n saldo a Favor (9)

    sbNitEmpresa    sistema.sistnitc%type;
    nuFlagGDO       number;

    -- Cursor para consultar el NIT de la Empresa
    CURSOR cuNitEmpresa is
        select sistnitc
        from open.sistema;

  BEGIN
    --ut_trace.init;
    --ut_trace.setlevel(99);
    --ut_trace.setoutput(ut_trace.fntrace_output_db);

    ut_trace.trace('*************************** [llozada] RfDatosFactura Constructora', 10);

    sbFactcodi := obtenervalorinstancia('FACTURA','FACTCODI');
    -- Por si no funciona la factura en la instancia
    --sbDOCUCODI := Pkboca_Print.fnuGetDocumentBox;
    sbCodBarras    := dald_parameter.fsbGetValue_Chain('COD_EAN_CODIGO_BARRAS');
    sbDesImpuesto  := dald_parameter.fsbGetValue_Chain('DESC_RETENEDOR_IMPUESTO');

    nuConAntVe  := 301;     -- se asigna el codigo 301, concepto del Anticipo de Venta
                            -- Se usa en las columnas t_servicios, Total_pay y amortizacion

    begin
        select pafaasaf
        into nuConcASAF
        from open.PARAFACT
        where rownum = 1;

    exception
        when no_data_found then
            nuConcASAF := 9;
    end;


    ---- validacion si aplica para GDO  TS 3262 ----
    open cuNitEmpresa;
    fetch cuNitEmpresa into sbNitEmpresa;
    close cuNitEmpresa;

    if sbNitEmpresa is not null then
        if trim(sbNitEmpresa) = csbNitGDO then
            nuFlagGDO := 1;
        else
            nuFlagGDO := 0;
        end if;
    end if;
    --------

    ut_trace.trace('*************************** [llozada] RfDatosFactura Constructora sbFactcodi: '||sbFactcodi, 2);

    open orfcursor for
            SELECT fc.factcodi                                                  account_number, --2
            dage_subscriber.fsbgetsubscriber_name(b.suscclie)||' '||
            dage_subscriber.fsbgetsubs_last_name(b.suscclie)                    client_name ,
            daab_address.fsbgetaddress_parsed(b.susciddi)                       client_address,
            s.sesusuca                                                          subcategory,  --5
            open.pktblcategori.fsbgetdescription(s.sesucate)                    category, --6
            b.susccicl                                                          billing_cycle,--7
            to_char(to_date(pf.pefames,'mm'), 'MONTH')                          billing_month, --8
            b.susccodi suscripcion,--9
            LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('AB_PREMISE','PREMISE_ID','CONSECUTIVE', b.susciddi)
                ||lpad(daab_segments.fnugetroute_id(daab_address.fnugetsegment_id(b.susciddi)),10,'0')   route,
            to_char(fc.factfege, 'dd/MON/yyyy')                                 date_initial_per,--11
            to_char(pc.pecsfecf, 'dd mm yyyy')                                  date_end_per,--12
            case when (open.LDC_BOFORMATOFACTURA.fsbPagoInmediato(s.sesunuse)=1)
                    then 'INMEDIATO'
                else to_char(cc.cucofeve, 'dd/MON/yyyy') end date_limited_per,--13
            decode(nuFlagGDO, 1,
                '$'||to_char((SELECT sum(cucovato) FROM cuencobr WHERE cucofact = fc.factcodi ),'FM999,999,990.00') ,
                '$'||to_char((SELECT sum(cucovato) FROM cuencobr WHERE cucofact = fc.factcodi ) -
                   nvl((select sum(cargvalo) FROM cargos WHERE cargcuco = cc.cucocodi AND cargconC in (nuConAntVe,nuConcASAF)),0), 'FM999,999,990.00' ) )  Total_pay, --14
            to_char(open.LDC_BOFORMATOFACTURA.fnuGetCostCompValid(156,1, 6),'FM999,999,990.00') interest_mora, -- 15
            open.LDC_BOFORMATOFACTURA.fsbPorcSuboContri(fc.factcodi) Percen_sc, -- 16
            open.LDC_BOFORMATOFACTURA.fnuGetIndiceCalidad(s.sesunuse, pf.pefafimo, pf.pefaffmo) time_desc, --17
            open.dage_geogra_location.fnugetgeo_loca_father_id(daab_address.fnugetgeograp_location_id(b.susciddi)) state, --18
            daab_address.fnugetgeograp_location_id(b.susciddi)  city,
            '$'||to_char(((select  sum(case when conctico=1 then decode(CARGSIGN,'CR',CARGVALO*-1,'PA',CARGVALO*-1,'AS',
                CARGVALO*-1,'DB',CARGVALO,CARGVALO*-1) else 0 end)
                from open.cargos,open.concepto
                where cargconc=conccodi
                and cargcuco=cc.cucocodi)), 'FM999,999,990.00' ) t_servicios_publicos, --20
            0 t_bienes,                                     --21
            '$'||to_char((select sum(case when conccodi in (nuConAntVe,nuConcASAF) then 0 else decode(CARGSIGN,'CR',CARGVALO*-1,'PA',CARGVALO*-1,'AS',
                CARGVALO*-1,'DB',CARGVALO,CARGVALO*-1) end)
                from open.cargos,open.concepto
                where cargconc=conccodi
                AND conctico in (1, 3)
                AND concticl <> 4
                and cargcuco=cc.cucocodi), 'FM999,999,990.00') t_servicios, --22
            open.dage_geogra_location.fsbgetdescription(daab_address.fnugetgeograp_location_id(b.susciddi)) neighborthood,
            open.PKBOBILLPRINTHEADERRULES.FNUGETTOTALPREVIOUSBALANCE Saldo_Anterior, --24
            (select em.emsscoem from open.elmesesu em where em.emsssesu=s.sesunuse and rownum=1) meter, --25
            (case when (dage_subscriber.fnugetident_type_id(b.suscclie) =110
                        OR dage_subscriber.fnugetident_type_id(b.suscclie)=1)
                        then dage_subscriber.fsbgetidentification(b.suscclie) end) Client_Nit, -- 26
            b.suscclie suscriptor,
            round(pc.pecsfecf -  pc.pecsfeci) days_cons,
            --Sergio Mej?a: LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('CC_QUOTED_WORK','QUOTATION_ID','WORK_NAME', qu.QUOTATION_ID) PROYECTO,
            --Paula Garc?a: Se modifica para que tenga en cuenta los datos que pertenecen a Financiaciones
            --              cambiando la forma de obtener el c?digo de la cotizaci?n.
            nvl((select qw.WORK_NAME
                    from open.cc_quotation qu,
                         open.cargos,
                         open.cc_quoted_work qw
                    where   subscriber_id = b.suscclie
                    and     cargos.cargnuse = s.sesunuse
                    and     cargos.cargdoso like 'PP-%'
                    and     qu.package_id = substr(cargdoso,instr(cargdoso,'-') + 1,length(cargdoso))
                    and     qw.QUOTATION_ID = qu.QUOTATION_ID
                    and rownum <= 1), -1)  PROYECTO,
            --Sergio Mej?a: LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('MO_ADDRESS','PACKAGE_ID','ADDRESS', qu.package_id) DIRPROYECTO,
            --Paula Garc?a: Se modifica para que tenga en cuenta los datos que pertenecen a Financiaciones
            --              cambiando la forma de obtener el c?digo de la cotizaci?n.
            (select ma.ADDRESS
                    from open.cc_quotation qu,
                         open.cargos,
                         open.MO_ADDRESS ma
                   where   subscriber_id = b.suscclie
                    and     cargos.cargnuse = s.sesunuse
                    and     cargos.cargdoso like 'PP-%'
                    and     qu.package_id = substr(cargdoso,instr(cargdoso,'-') + 1,length(cargdoso))
                    and     ma.package_id = qu.package_id
                    and rownum <= 1)   DIRPROYECTO,
            --Sergio Mej?a:  qu.QUOTATION_ID                          NUMCOTIZACION,
            --Paula Garc?a: Se modifica para que tenga en cuenta los datos que pertenecen a Financiaciones
            --              cambiando la forma de obtener el c?digo de la cotizaci?n.
            (select qu.quotation_id
                    from open.cc_quotation qu,
                         open.cargos
                    where   subscriber_id = b.suscclie
                    and     cargos.cargnuse = s.sesunuse
                    and     cargos.cargdoso like 'PP-%'
                    and     qu.package_id = substr(cargdoso,instr(cargdoso,'-') + 1,length(cargdoso))
                    and rownum <= 1) NUMCOTIZACION,
            -- Sergio Mej?a: qu.package_id                            SOLICITUD,
            --Paula Garc?a: Se modifica para que tenga en cuenta los datos que pertenecen a Financiaciones
            --              cambiando la forma de obtener el c?digo de la cotizaci?n.
            (select qu.package_id
                    from open.cc_quotation qu,
                         open.cargos
                    where   subscriber_id = b.suscclie
                    and     cargos.cargnuse = s.sesunuse
                    and     cargos.cargdoso like 'PP-%'
                    and     qu.package_id = substr(cargdoso,instr(cargdoso,'-') + 1,length(cargdoso))
                    and rownum <= 1)   SOLICITUD,
            LDC_BOFORMATOFACTURA.fnuGetNumCupon(fc.factcodi,fc.factsusc)                  cupon_referencia,
            --Sergio Mej?a: '$'||to_char(qu.total_items_value + qu.total_tax_value,'FM999,999,990.00')    VALOCOTI,
            --Paula Garc?a: Se modifica para que tenga en cuenta los datos que pertenecen a Financiaciones
            --              cambiando la forma de obtener el c?digo de la cotizaci?n.
            (select '$'||to_char(qu.total_items_value + qu.total_tax_value,'FM999,999,990.00')
                    from open.cc_quotation qu,
                         open.cargos
                    where   subscriber_id = b.suscclie
                    and     cargos.cargnuse = s.sesunuse
                    and     cargos.cargdoso like 'PP-%'
                    and     qu.package_id = substr(cargdoso,instr(cargdoso,'-') + 1,length(cargdoso))
                    and rownum <= 1) VALOCOTI,
            to_char(open.LDC_BOFORMATOFACTURA.fnuGetTasaInteresMora(), '9990.00')                        TASA_INTERES_MORA,
            '$'||to_char(Ldc_DetalleFactura_Const.fnuGetIteresesMora(fc.factcodi), 'FM999,999,990.00' )     INTERES_MORA,
            '$'||to_char(Ldc_DetalleFactura_Const.fnuGetIteresesFinanciacion(fc.factcodi), 'FM999,999,990.00')   INTERES_FINANCIACION,
            '$'||to_char(Ldc_DetalleFactura_Const.fnuGetIva(fc.factcodi), 'FM999,999,990.00' )              IMPUESTO_IVA,
            /*Sergio Mej?a: '$'||to_char(decode (qu.INITIAL_PAYMENT,
                                    0,(select safavalo
                                       from open.saldfavo
                                       where safadocu = substr(cargdoso,instr(cargdoso,'-') + 1,length(cargdoso))),
                                    qu.INITIAL_PAYMENT), 'FM999,999,990.00')                   INITIAL_PAYMENT, */
            --Paula Garc?a: Se modifica para que tenga en cuenta los datos que pertenecen a Financiaciones
            --              cambiando la forma de obtener el c?digo de la cotizaci?n.
            (select '$'||to_char(decode (qu.INITIAL_PAYMENT,
                                    0,(select safavalo
                                       from open.saldfavo
                                       where safadocu = substr(ca.cargdoso,instr(ca.cargdoso,'-') + 1,length(ca.cargdoso))),
                                    qu.INITIAL_PAYMENT), 'FM999,999,990.00')
                    from open.cc_quotation qu,
                         open.cargos
                    where   subscriber_id = b.suscclie
                    and     cargos.cargnuse = s.sesunuse
                    and     cargos.cargdoso like 'PP-%'
                    and     qu.package_id = substr(cargdoso,instr(cargdoso,'-') + 1,length(cargdoso))
                    and rownum <= 1)   INITIAL_PAYMENT,
            '$'||to_char(nvl((select sum(cargvalo) FROM cargos WHERE cargcuco = cc.cucocodi AND cargconC in (nuConAntVe,nuConcASAF)),0), 'FM999,999,990.00') AMORTIZACION,
            (select '(415)'||sbCodBarras||'(8020)'||lpad(cu.cuponume,10,'0')||
                '(3900)'||lpad(round(cu.cupovalo),10,'0')||'(96)'||to_char(cc.cucofeve, 'yyyymmdd')
                from cupon cu
                where cu.cuponume = LDC_BOFORMATOFACTURA.fnuGetNumCupon(fc.factcodi,fc.factsusc)) CODIGOBARRAS,
             sbDesImpuesto  RET_IMPUESTO,
                nvl((select  DISTINCT CC_QUOTATION_ITEM.ITEMS_QUANTITY
                from    or_order_activity, cc_quotation, CC_QUOTATION_ITEM
                where   cc_quotation.package_id = or_order_activity.package_id
                and cc_quotation.QUOTATION_ID = CC_QUOTATION_ITEM.QUOTATION_ID
                and     cc_quotation.status = 'C'
                AND CC_QUOTATION_ITEM.ITEMS_ID = 4295271
                and     or_order_activity.package_id = substr(cargdoso,instr(cargdoso,'-') + 1,length(cargdoso))),0) UNID_PRED_CONTRAT,
              (SELECT cc.id_proyecto
              FROM cc_quotation qu,
                   cargos,
                   ldc_cotizacion_construct cc
              WHERE subscriber_id = b.suscclie
                AND  cargos.cargnuse = s.sesunuse
                AND cargos.cargdoso = 'PP-'||qu.package_id
                AND cc.id_cotizacion_osf = qu.quotation_id
                AND ROWNUM <= 1) COD_PROYECTO
             FROM open.factura fc,
                  open.cuencobr cc,
                  open.suscripc b,
                  open.servsusc s,
                  open.perifact pf,
                  open.pericose pc,
                  open.cargos ca
                  --open.cc_quotation qu
              WHERE fc.factcodi= to_number(sbFactcodi) --:factura --obtenervalorinstancia('FACTURA','FACTCODI')
              AND fc.factcodi = cc.cucofact
              AND fc.factsusc = b.susccodi
              AND b.susccodi = s.sesususc
              AND ca.cargcuco = cc.cucocodi
              --AND qu.package_id = substr(cargdoso,instr(cargdoso,'-') + 1,length(cargdoso))
              --AND ca.cargdoso like 'PP-%'
              AND pf.pefacodi = fc.factpefa
              ANd pc.pecscons = open.LDC_BOFORMATOFACTURA.fnuObtPerConsumo(pf.pefacicl, pf.pefacodi)
              and rownum=1;

        ut_trace.trace('[llozada] Fin RfDatosFactura Constructora', 10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  end RfDatosFactura;

END Ldc_DetalleFactura_Const;
/
GRANT EXECUTE on LDC_DETALLEFACTURA_CONST to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LDC_DETALLEFACTURA_CONST to REXEOPEN;
GRANT EXECUTE on LDC_DETALLEFACTURA_CONST to RSELSYS;
/
