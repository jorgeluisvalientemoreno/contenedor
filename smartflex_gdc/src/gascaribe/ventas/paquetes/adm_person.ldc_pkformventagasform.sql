CREATE OR REPLACE PACKAGE adm_person.ldc_pkformventagasform IS
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   26/06/2024   OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
  CSB_TIPOFORMULARIO      MO_PACKAGES.DOCUMENT_TYPE_ID%TYPE := NULL;
  CSB_NUMFORMULARIO       MO_PACKAGES.DOCUMENT_KEY%TYPE := NULL;
  CSB_TIPOIDENT           GE_SUBSCRIBER.IDENT_TYPE_ID%type := NULL;
  CSB_IDENT               GE_SUBSCRIBER.IDENTIFICATION%type := NULL;
  CSB_NOMBRE              VARCHAR2(1000) := NULL;
  CSB_APELLIDO            VARCHAR2(1000) := NULL;
  CSB_DIRECCION           VARCHAR2(1000) := NULL;
  CSB_PLANCOMERCIAL       MO_MOTIVE.COMMERCIAL_PLAN_ID%TYPE := NULL;
  CSB_SUBSIDIO_UNO        NUMBER := NULL;
  CSB_SUBSIDIO_DOS        NUMBER := NULL;
  CSB_PLANFINAN           NUMBER := NULL;
  CSB_VALORTOTAL          MO_GAS_SALE_DATA.TOTAL_VALUE%type := NULL;
  CSB_CUOTAMENSUAL        NUMBER := NULL;
  CSB_NUMERODCUOTAS       NUMBER := NULL;
  CSB_SALDOAFINANCIAR     NUMBER := NULL;


  /*****************************************************************
  Propiedad intelectual de HORBATH TECHNOLOGIES (c).

  Unidad         : AutrTratmDatosPersonal
  Descripcion    : procedimiento para extraer los datos personales
                   para el tratamiento de datos.
  Autor          :
  Fecha          : 02/03/2018

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del cliente para la venta por formulario.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  02-03-2018      Josh Brito             Creacion.
  ******************************************************************/
  Procedure AutrTratmDatosPersonal(orfcursor Out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de HORBATH TECHNOLOGIES (c).

  Unidad         : ContratoPrestacionServicio
  Descripcion    : procedimiento para extraer los datos del suscriptor
                   para el Contrato del prestacion de servicio.
  Autor          :
  Fecha          : 02/03/2018

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del suscriptor para la venta por formulario.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  02-03-2018      Josh Brito             Creacion.
  ******************************************************************/
  Procedure ContratoPrestacionServicio(orfcursor Out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de HORBATH TECHNOLOGIES (c).

  Unidad         : FormatoFinanciacion
  Descripcion    : procedimiento para extraer los datos del suscriptor
                   para el Formato de financiacion.
  Autor          :
  Fecha          : 06/03/2018

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos de la finaciacion para la venta por formulario.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  06-03-2018      Josh Brito             Creacion.
  ******************************************************************/
  Procedure FormatoFinanciacion(orfcursor Out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de HORBATH TECHNOLOGIES (c).

  Unidad         : PagarePersonaNatural
  Descripcion    : procedimiento para extraer los datos del suscriptor
                   para el Formato de pagare.
  Autor          :
  Fecha          : 07/03/2018

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos de pagare y carta de instrucciones
                       para la venta por formulario.


  Fecha             Autor             Modificacion
  =========       =========           ====================
  07-03-2018      Josh Brito             Creacion.
  ******************************************************************/
  Procedure PagarePersonaNatural(orfcursor Out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de HORBATH TECHNOLOGIES (c).

  Unidad         : CartaAceptaSubsidio
  Descripcion    : procedimiento para extraer los datos del suscriptor
                   para el Formato de subsidio.
  Autor          :
  Fecha          : 08/03/2018

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del subsidio
                       para la venta por formulario.


  Fecha             Autor             Modificacion
  =========       =========           ====================
  08-03-2018      Josh Brito             Creacion.
  ******************************************************************/
  Procedure CartaAceptaSubsidio(orfcursor Out constants.tyRefCursor);

   /*****************************************************************
  Propiedad intelectual de HORBATH TECHNOLOGIES (c).

  Unidad         : CartaAceptaSubsidioDos
  Descripcion    : procedimiento para extraer los datos del suscriptor
                   para el Formato de subsidio.
  Autor          :
  Fecha          : 09/05/2018

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del subsidio
                       para la venta por formulario.


  Fecha             Autor             Modificacion
  =========       =========           ====================
  09-05-2018      Josh Brito             Creacion.
  ******************************************************************/
  Procedure CartaAceptaSubsidioDos(orfcursor Out constants.tyRefCursor);

END LDC_PKFORMVENTAGASFORM;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKFORMVENTAGASFORM
IS
  /*****************************************************************
  Propiedad intelectual de HORBATH TECHNOLOGIES (c).

  Unidad         : AutrTratmDatosPersonal
  Descripcion    : procedimiento para extraer los datos personales
                   para el tratamiento de datos.
  Autor          :
  Fecha          : 02/03/2018

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del cliente para la venta por formulario.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  02-03-2018      Josh Brito             Creacion.
  ******************************************************************/
  Procedure AutrTratmDatosPersonal(orfcursor Out constants.tyRefCursor) IS

  begin
    ut_trace.trace('*************************** Inicio [AutrTratmDatosPersonal]', 10);

    open orfcursor for
      SELECT LDC_PKFORMVENTAGASFORM.CSB_IDENT CEDULA,
      LDC_PKFORMVENTAGASFORM.CSB_NOMBRE NOMBRE,
      LDC_PKFORMVENTAGASFORM.CSB_APELLIDO APELLIDO,
      to_char(SYSDATE,'dd/mm/yyyy') FECHA_ACTUAL
      FROM DUAL;

    ut_trace.trace('Fin [AutrTratmDatosPersonal]', 10);

   EXCEPTION
        WHEN OTHERS THEN
            Dbms_Output.Put_Line(SQLERRM);
            PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  end AutrTratmDatosPersonal;

  /*****************************************************************
  Propiedad intelectual de HORBATH TECHNOLOGIES (c).

  Unidad         : ContratoPrestacionServicio
  Descripcion    : procedimiento para extraer los datos del suscriptor
                   para el Contrato del prestacion de servicio.
  Autor          :
  Fecha          : 02/03/2018

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del suscriptor para la venta por formulario.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  02-03-2018      Josh Brito             Creacion.
  ******************************************************************/
  Procedure ContratoPrestacionServicio(orfcursor Out constants.tyRefCursor) is
  begin
    ut_trace.trace('******* Inicio [ContratoPrestacionServicio]', 10);

    open orfcursor for
      SELECT LDC_PKFORMVENTAGASFORM.CSB_NOMBRE||' '||LDC_PKFORMVENTAGASFORM.CSB_APELLIDO NOMBRE,
      EXTRACT(DAY FROM SYSDATE) DIA,
      to_char(to_date(to_char(EXTRACT(MONTH FROM SYSDATE)),'mm'),'Month','NLS_DATE_LANGUAGE = SPANISH') MES,
      EXTRACT(YEAR FROM SYSDATE) ANO,
      LDC_PKFORMVENTAGASFORM.CSB_NUMFORMULARIO NUMERO_FORMULARIO
      FROM DUAL;

        ut_trace.trace('Fin [ContratoPrestacionServicio]', 10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  end ContratoPrestacionServicio;

  /*****************************************************************
  Propiedad intelectual de HORBATH TECHNOLOGIES (c).

  Unidad         : FormatoFinanciacion
  Descripcion    : procedimiento para extraer los datos del suscriptor
                   para el Formato de financiacion.
  Autor          :
  Fecha          : 06/03/2018

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos de la finaciacion para la venta por formulario.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  06-03-2018      Josh Brito             Creacion.
  ******************************************************************/
  Procedure FormatoFinanciacion(orfcursor Out constants.tyRefCursor) is
    sbAplica            NUMBER DEFAULT 0;
  begin
    ut_trace.trace('******* Inicio [FormatoFinanciacion]', 10);

    IF LDC_PKFORMVENTAGASFORM.CSB_SALDOAFINANCIAR > 0 THEN
        sbAplica := 1;
    END IF;

        open orfcursor for
          SELECT sbAplica APLICA,
          LDC_PKFORMVENTAGASFORM.CSB_IDENT CEDULA,
          LDC_PKFORMVENTAGASFORM.CSB_NOMBRE NOMBRE,
          LDC_PKFORMVENTAGASFORM.CSB_APELLIDO APELLIDO,
          (select l.DESCRIPTION
            from GE_GEOGRA_LOCATION l, AB_ADDRESS a
            where l.GEOGRAP_LOCATION_ID = a.GEOGRAP_LOCATION_ID
            and a.ADDRESS_ID = LDC_PKFORMVENTAGASFORM.CSB_DIRECCION) LOCALIDAD,
          LDC_PKFORMVENTAGASFORM.CSB_SALDOAFINANCIAR SALDO_FINANCIAR,
          (SELECT COTIPORC --NVL(ROUND(COTIPORC,2),0)
            FROM CONFTAIN
            WHERE COTITAIN = (SELECT PLDITAIN FROM plandife WHERE PLDICODI = LDC_PKFORMVENTAGASFORM.CSB_PLANFINAN)
            AND SYSDATE BETWEEN COTIFEIN AND COTIFEFI) INTERES_FINANCIERO,
         (SELECT TV.VITPPORC --NVL(ROUND(TV.VITPPORC,2),0)
            FROM TA_VIGETACP TV, TA_TARICOPR TT, TA_CONFTACO TC
            WHERE TV.VITPTACP = TT.TACPCONS
            AND TT.TACPCOTC = TC.COTCCONS
            AND TV.VITPTIPO = 'B'
            AND SYSDATE BETWEEN TV.VITPFEIN AND TV.VITPFEFI
            AND COTCSERV = 7014
           -- AND TT.TACPPRTA = OPEN.DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_PAR_PROYECTOTARIFA') --4327 --PROYECTO DE TARIFA
            AND TC.COTCCONC = OPEN.DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_PAR_CONCEPTOTARIFA') --156 --CONCEPTO DE TARIFA
            AND ROWNUM < 2
          ) INTERES_MORA,
          LDC_PKFORMVENTAGASFORM.CSB_NUMERODCUOTAS NUMERO_CUOTAS,
          LDC_PKFORMVENTAGASFORM.CSB_CUOTAMENSUAL CUOTA_INICIAL,
          EXTRACT(DAY FROM SYSDATE) DIA,
          to_char(to_date(to_char(EXTRACT(MONTH FROM SYSDATE)),'mm'),'Month','NLS_DATE_LANGUAGE = SPANISH') MES,
          EXTRACT(YEAR FROM SYSDATE) ANO
          FROM DUAL;
        ut_trace.trace('Fin [FormatoFinanciacion]', 10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  end FormatoFinanciacion;

  /*****************************************************************
  Propiedad intelectual de HORBATH TECHNOLOGIES (c).

  Unidad         : PagarePersonaNatural
  Descripcion    : procedimiento para extraer los datos del suscriptor
                   para el Formato de pagare.
  Autor          :
  Fecha          : 07/03/2018

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos de pagare y carta de instrucciones
                       para la venta por formulario.


  Fecha             Autor             Modificacion
  =========       =========           ====================
  07-03-2018      Josh Brito             Creacion.
  ******************************************************************/
  Procedure PagarePersonaNatural(orfcursor Out constants.tyRefCursor) is
  begin
    ut_trace.trace('******* Inicio [PagarePersonaNatural]', 10);

    open orfcursor for
      SELECT LDC_PKFORMVENTAGASFORM.CSB_IDENT CEDULA,
      LDC_PKFORMVENTAGASFORM.CSB_NOMBRE NOMBRE,
      LDC_PKFORMVENTAGASFORM.CSB_APELLIDO APELLIDO
      FROM DUAL;

        ut_trace.trace('Fin [PagarePersonaNatural]', 10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  end PagarePersonaNatural;

  /*****************************************************************
  Propiedad intelectual de HORBATH TECHNOLOGIES (c).

  Unidad         : CartaAceptaSubsidio
  Descripcion    : procedimiento para extraer los datos del suscriptor
                   para el Formato de subsidio.
  Autor          :
  Fecha          : 08/03/2018

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del subsidio
                       para la venta por formulario.


  Fecha             Autor             Modificacion
  =========       =========           ====================
  08-03-2018      Josh Brito             Creacion.
  ******************************************************************/
  Procedure CartaAceptaSubsidio(orfcursor Out constants.tyRefCursor) is
    sbAplica            NUMBER DEFAULT 0;
    nuSaldoFianciar     NUMBER DEFAULT NULL;
    nuCoutas            NUMBER DEFAULT NULL;
    sbConvenio          LD_DEAL.DESCRIPTION%TYPE DEFAULT NULL;
    sbValorConvenio     LD_SUBSIDY_DETAIL.SUBSIDY_VALUE%TYPE DEFAULT NULL;

  begin
    ut_trace.trace('******* Inicio [CartaAceptaSubsidio]', 10);

    BEGIN
        SELECT CONV.DESCRIPTION, SUM(SD.SUBSIDY_VALUE) INTO sbConvenio, sbValorConvenio
        FROM LD_SUBSIDY S, LD_DEAL CONV, LD_UBICATION U, LD_SUBSIDY_DETAIL SD, AB_ADDRESS A, AB_SEGMENTS SG
        WHERE S.SUBSIDY_ID = U.SUBSIDY_ID
        AND U.UBICATION_ID = SD.UBICATION_ID
        AND CONV.DEAL_ID = S.DEAL_ID
        AND U.GEOGRA_LOCATION_ID = A.GEOGRAP_LOCATION_ID
        AND A.SEGMENT_ID = SG.SEGMENTS_ID
        AND U.SUCACATE = SG.CATEGORY_
        AND U.SUCACODI = SG.SUBCATEGORY_
        AND SYSDATE BETWEEN S.INITIAL_DATE AND S.FINAL_DATE
        AND CONV.DEAL_ID  = LDC_PKFORMVENTAGASFORM.CSB_SUBSIDIO_UNO
        AND A.ADDRESS_ID = LDC_PKFORMVENTAGASFORM.CSB_DIRECCION
        GROUP BY CONV.DESCRIPTION;
    EXCEPTION
      WHEN no_data_found THEN
        sbConvenio := NULL;
        sbValorConvenio := NULL;
    END;

    IF sbConvenio IS NOT NULL AND sbValorConvenio IS NOT NULL THEN
        sbAplica := 1;
    END IF;

    IF LDC_PKFORMVENTAGASFORM.CSB_SALDOAFINANCIAR > 0 THEN
        nuCoutas := LDC_PKFORMVENTAGASFORM.CSB_NUMERODCUOTAS;
        nuSaldoFianciar := LDC_PKFORMVENTAGASFORM.CSB_SALDOAFINANCIAR;
    END IF;

        open orfcursor for
          SELECT sbAplica APLICA,
          to_char(SYSDATE,'dd/mm/yyyy') FECHA_ACTUAL,
          LDC_PKFORMVENTAGASFORM.CSB_IDENT CEDULA,
          LDC_PKFORMVENTAGASFORM.CSB_NOMBRE NOMBRE,
          LDC_PKFORMVENTAGASFORM.CSB_APELLIDO APELLIDO,
          (select address from AB_ADDRESS where ADDRESS_ID = LDC_PKFORMVENTAGASFORM.CSB_DIRECCION) DIRECCION_PREDIO,
          (select l.DESCRIPTION||'-'||(select DESCRIPTION from GE_GEOGRA_LOCATION where GEOGRAP_LOCATION_ID = l.GEO_LOCA_FATHER_ID)
            from GE_GEOGRA_LOCATION l, AB_ADDRESS a
            where l.GEOGRAP_LOCATION_ID = a.GEOGRAP_LOCATION_ID
            and a.ADDRESS_ID = LDC_PKFORMVENTAGASFORM.CSB_DIRECCION) LOCALI_PREDIO,
          NVL(nuCoutas,0) CUOTAS_PLAZO,
          NVL(nuSaldoFianciar,0) VALOR_FINANCIADO,
          expresar_en_letras.numero_a_letras(nuCoutas) CUOTAS_PLAZO_LETRA,
          sbConvenio NOMBRE_CONVENIO,
           NVL(nuSaldoFianciar,0) VALOR_CONVENIO
          FROM DUAL;

        ut_trace.trace('Fin [CartaAceptaSubsidio]', 10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  end CartaAceptaSubsidio;

  /*****************************************************************
  Propiedad intelectual de HORBATH TECHNOLOGIES (c).

  Unidad         : CartaAceptaSubsidioDos
  Descripcion    : procedimiento para extraer los datos del suscriptor
                   para el Formato de subsidio.
  Autor          :
  Fecha          : 09/05/2018

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del subsidio
                       para la venta por formulario.


  Fecha             Autor             Modificacion
  =========       =========           ====================
  09-05-2018      Josh Brito             Creacion.
  ******************************************************************/
  Procedure CartaAceptaSubsidioDos(orfcursor Out constants.tyRefCursor) is
    sbAplica            NUMBER DEFAULT 0;
    nuSaldoFianciar     NUMBER DEFAULT NULL;
    nuCoutas            NUMBER DEFAULT NULL;
    sbConvenio          LD_DEAL.DESCRIPTION%TYPE DEFAULT NULL;
    sbValorConvenio     LD_SUBSIDY_DETAIL.SUBSIDY_VALUE%TYPE DEFAULT NULL;

  begin
    ut_trace.trace('******* Inicio [CartaAceptaSubsidioDos]', 10);

    BEGIN
        SELECT CONV.DESCRIPTION,  SUM(SD.SUBSIDY_VALUE) INTO sbConvenio, sbValorConvenio
        FROM LD_SUBSIDY S, LD_DEAL CONV, LD_UBICATION U, LD_SUBSIDY_DETAIL SD, AB_ADDRESS A, AB_SEGMENTS SG
        WHERE S.SUBSIDY_ID = U.SUBSIDY_ID
        AND U.UBICATION_ID = SD.UBICATION_ID
        AND CONV.DEAL_ID = S.DEAL_ID
        AND U.GEOGRA_LOCATION_ID = A.GEOGRAP_LOCATION_ID
        AND A.SEGMENT_ID = SG.SEGMENTS_ID
        AND U.SUCACATE = SG.CATEGORY_
        AND U.SUCACODI = SG.SUBCATEGORY_
        AND SYSDATE BETWEEN S.INITIAL_DATE AND S.FINAL_DATE
        AND CONV.DEAL_ID  = LDC_PKFORMVENTAGASFORM.CSB_SUBSIDIO_DOS
        AND A.ADDRESS_ID = LDC_PKFORMVENTAGASFORM.CSB_DIRECCION
		GROUP BY CONV.DESCRIPTION;

    EXCEPTION
      WHEN no_data_found THEN
        sbConvenio := NULL;
        sbValorConvenio := NULL;
    END;

    IF sbConvenio IS NOT NULL AND sbValorConvenio IS NOT NULL THEN
        sbAplica := 1;
    END IF;

    IF LDC_PKFORMVENTAGASFORM.CSB_SALDOAFINANCIAR > 0 THEN
        nuCoutas := LDC_PKFORMVENTAGASFORM.CSB_NUMERODCUOTAS;
        nuSaldoFianciar := LDC_PKFORMVENTAGASFORM.CSB_SALDOAFINANCIAR;
    END IF;

        open orfcursor for
          SELECT sbAplica APLICA,
          to_char(SYSDATE,'dd/mm/yyyy') FECHA_ACTUAL,
          LDC_PKFORMVENTAGASFORM.CSB_IDENT CEDULA,
          LDC_PKFORMVENTAGASFORM.CSB_NOMBRE NOMBRE,
          LDC_PKFORMVENTAGASFORM.CSB_APELLIDO APELLIDO,
          (select address from AB_ADDRESS where ADDRESS_ID = LDC_PKFORMVENTAGASFORM.CSB_DIRECCION) DIRECCION_PREDIO,
          (select l.DESCRIPTION||'-'||(select DESCRIPTION from GE_GEOGRA_LOCATION where GEOGRAP_LOCATION_ID = l.GEO_LOCA_FATHER_ID)
            from GE_GEOGRA_LOCATION l, AB_ADDRESS a
            where l.GEOGRAP_LOCATION_ID = a.GEOGRAP_LOCATION_ID
            and a.ADDRESS_ID = LDC_PKFORMVENTAGASFORM.CSB_DIRECCION) LOCALI_PREDIO,
          NVL(nuCoutas,0) CUOTAS_PLAZO,
          NVL(nuSaldoFianciar,0) VALOR_FINANCIADO,
          expresar_en_letras.numero_a_letras(nuCoutas) CUOTAS_PLAZO_LETRA,
          sbConvenio NOMBRE_CONVENIO,
           NVL(nuSaldoFianciar,0) VALOR_CONVENIO
          FROM DUAL;

        ut_trace.trace('Fin [CartaAceptaSubsidioDos]', 10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  end CartaAceptaSubsidioDos;

END LDC_PKFORMVENTAGASFORM;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKFORMVENTAGASFORM
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKFORMVENTAGASFORM', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS EXECUTE a REXEREPORTES sobre LDC_PKFORMVENTAGASFORM
GRANT EXECUTE ON ADM_PERSON.LDC_PKFORMVENTAGASFORM TO REXEREPORTES;
/