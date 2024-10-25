CREATE OR REPLACE PACKAGE "LDC_PKCRMFINANCIACION" IS

  --Inicio CASO 200-1948
  SBCRM_SC_JLV_2001948 varchar2(4000) := 'CRM_SC_JLV_2001948_1';
  --Fin CASO 200-1948

  /*****************************************************************
  Propiedad intelectual de PETI.
  Unidad         : LDC_PKCRMFINANCIACION
  Descripcion    : PAQUETE PARA FINANCIAR DEUDA DEL SUSCRIPTOR
  Autor          : Jorge Valiente
  Fecha          : 06/11/2015

   Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  29-08-2017      oparra              Se modifica el m?todo <<FRCDUPLICADO>>
  ******************************************************************/

  /*VACTOR PARA ALMACENAR LOS DATOS PROVENIENETES LINEA DE ARCHIVO*/
  TYPE TBARRAY IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         :PRFINANCIARDUPLICADO
  Descripcion    :PROCEDIMIENTO ENCARGADO DE GENERAR LA FINANCIACION DEL DUPLICADO DESDE EL JOB.

  Autor          :Jorge Valiente
  Fecha          :06/11/2015

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE PRFINANCIARDUPLICADO;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : FRFORDENES
  Descripcion    : FUNCION QUE PERMITE RETORNAR LOS CUPONES QUE SE HAN GENERADO POR
                   SOLLICITUD DE ESTADO DE CUENTA CON CARGO A LA -1 Y NO TENGAN
                   FINANCIACION DEL VALOR DEL DUPLICADO.

  Autor          : Jorge Valiente
  Fecha          : 09/11/2015

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha                   Autor             Modificacion
  =========            =========           ====================
  ******************************************************************/
  FUNCTION FRCDUPLICADO RETURN pkConstante.tyRefCursor;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PRGENERATRABAJOADCIONAL
  Descripcion    : PROCEDIMIENTO QUE PERMITE FINANCIAR LOS CUPONES QUE SE HAN GENERADO POR
                   SOLLICITUD DE ESTADO DE CUENTA CON CARGO A LA -1 Y NO TENGAN
                   FINANCIACION DEL VALOR DEL DUPLICADO.

  Autor          : Jorge Valiente
  Fecha          : 20/08/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PRFINANCIARDUPLICADOPB(isbId           IN VARCHAR2,
                                   inuCurrent      IN NUMBER,
                                   inuTotal        IN NUMBER,
                                   onuErrorCode    OUT NUMBER,
                                   osbErrorMessage OUT VARCHAR2);

END LDC_PKCRMFINANCIACION;
/
CREATE OR REPLACE PACKAGE BODY "LDC_PKCRMFINANCIACION" IS

  /*****************************************************************
  Propiedad intelectual de PETI.
  Unidad         : LDC_PKCRMFINANCIACION
  Descripcion    : PAQUETE PARA FINANCIAR DEUDA DEL SUSCRIPTOR
  Autor          : Jorge Valiente
  Fecha          : 06/11/2015

   Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         :
  Descripcion    :

  Autor          :
  Fecha          :

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE PROCEDIMIENTO(NUCODIGOERROOR IN OUT NUMBER,
                          SBMENSAJEERROR IN OUT VARCHAR2) IS

  BEGIN

    NUCODIGOERROOR := 0;
    SBMENSAJEERROR := NULL;

    UT_TRACE.TRACE('INICIO LDC_PKCRMFINANCIACION.PROCEDIMIENTO', 10);
    UT_TRACE.TRACE('FIN LDC_PKCRMFINANCIACION.PROCEDIMIENTO', 10);

  EXCEPTION
    WHEN OTHERS THEN
      NUCODIGOERROOR := -1;
      SBMENSAJEERROR := 'ERROR';
  END PROCEDIMIENTO;

  /**********************************************************************
  Propiedad intelectual de Arquitecsoft
  Nombre   fsbGetData
  Autor    heiber Barco
  Fecha    12/08/2013

  Descripci?n: Funcion que retorna el valor dada la posiscion en una cadena con
               un caracter separador

  Historia de Modificaciones
  Fecha             Autor             Modificaci?n
  25/10/2015       Oparra             1. Llamado
  ***********************************************************************/
  FUNCTION fsbGetData(inuPosicion NUMBER,
                      ivaString   VARCHAR2,
                      ivaSeparate VARCHAR2) return VARCHAR2 IS
    vaStringFound VARCHAR2(200);

  BEGIN

    IF (INSTR(ivaString, ivaSeparate) > 0) AND (inuPosicion > 0) THEN
      IF inuPosicion = 1 THEN
        vaStringFound := SUBSTR(ivaString,
                                0,
                                INSTR(ivaString, ivaSeparate, 1, 1) - 1);
      ELSE
        IF (INSTR(ivaString, ivaSeparate, 1, inuPosicion - 1) > 0) AND
           (INSTR(ivaString, ivaSeparate, 1, inuPosicion) > 0) THEN
          vaStringFound := SUBSTR(ivaString,
                                  INSTR(ivaString,
                                        ivaSeparate,
                                        1,
                                        inuPosicion - 1) + 1,
                                  (INSTR(ivaString,
                                         ivaSeparate,
                                         1,
                                         inuPosicion) - 1 -
                                  INSTR(ivaString,
                                         ivaSeparate,
                                         1,
                                         inuPosicion - 1)));
        ELSIF (INSTR(ivaString, ivaSeparate, 1, inuPosicion - 1) > 0) AND
              (INSTR(ivaString, ivaSeparate, 1, inuPosicion) = 0) THEN
          vaStringFound := SUBSTR(ivaString,
                                  INSTR(ivaString,
                                        ivaSeparate,
                                        1,
                                        inuPosicion - 1) + 1,
                                  (LENGTH(ivaString) -
                                  INSTR(ivaString,
                                         ivaSeparate,
                                         1,
                                         inuPosicion - 1)));
        END IF;
      END IF;
    END IF;

    RETURN vaStringFound;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END fsbGetData;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         :
  Descripcion    :

  Autor          :
  Fecha          :

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  FUNCTION FSBFUNCION(NUCODIGOERROOR IN OUT NUMBER,
                      SBMENSAJEERROR IN OUT VARCHAR2) RETURN VARCHAR2 IS

    SBFINISHLINE   VARCHAR2(4000);
    SBSUBLINE      VARCHAR2(4000);
    SBARRAYVARCHAR TBARRAY;

  BEGIN

    RETURN(0);

  EXCEPTION
    WHEN OTHERS THEN
      NUCODIGOERROOR := -1;
      SBMENSAJEERROR := 'ERROR';

  END FSBFUNCION;

  ------------------CODIGO FUENTE
  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         :PRFINANCIARDUPLICADO
  Descripcion    :PROCEDIMIENTO ENCARGADO DE GENERAR LA FINANCIACION DEL DUPLICADO DESDE EL JOB.

  Autor          :Jorge Valiente
  Fecha          :06/11/2015

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  06/04/2016      Jorge Valiente      100-11746: Se adiciona la logica manifestada por OPEN en la qeu informa
                                                 la modificaci?n del paquete LDC_PKCRMFINANCIACION.
                                                 PRFINANCIARDUPLICADO para activar y desactivar un flag ACTIVE
                                                 en la tabla MO_MOTIVE_PAYMENT, antes y despu?s de realizar
                                                 el proceso de finaciaci?n, respectivamente.
  17/06/2016      Jorge Valiente      SAO 386766:Solucion enviada por OPEN para el inconveninte presentado
                                                 para el proceso de financiacion.
                                                 La logica aplicada es exactamente la misma que define OPEN
                                                 para evitar inconvenietes en el proceso de financiacion.
  25/04/2017      oparra              CA. 200-904: Ajuste financiacion Kiosko, procesar cupones que no
                                                 tiene solicitud asociada.
  14/02/2018      Jorge Valiente      CASO 200-1600: Modifcacion de sentencia agregando un indice llamado PK_LD_CUPON_CAUSAL
                                                     en la sentencia del cursor CU_LD_CUPON_CAUSAL y cursor CU_CUPON_PACKAGE
  26/06/2018      Jorge Valiente      CASO 200-1948: Crear nueva logica para el proceso de financiacion de GDC y omitir
                                                     la logica del CASO 200-904
  ******************************************************************/
  PROCEDURE PRFINANCIARDUPLICADO IS

    ---Inicio CASO 200-1948
    CURSOR CU_LDCUPONCAUSAL IS
      SELECT /*+ index(C PK_CUPON) index (lcc PK_LD_CUPON_CAUSAL) */
       LCC.*, C.CUPOSUSC
        FROM OPEN.LD_CUPON_CAUSAL LCC, OPEN.CUPON C
       WHERE LCC.CUPONUME = C.CUPONUME
         AND LCC.PACKAGE_ID <> 0
         AND C.CUPOTIPO = 'FA'
            --AND TRUNC(C.CUPOFECH) >= sbCPSCFEINGDC
            --AND TRUNC(C.CUPOFECH) < sbCPSCFEFIGDC
         AND C.CUPOFECH > TO_CHAR(SYSDATE, 'DD/MM/YYYY')
         AND NOT EXISTS (select 1
                from open.CC_Sales_Financ_Cond CSFC
               where CSFC.PACKAGE_ID = lcc.package_id)
         /*and EXISTS
       (SELECT 1
                FROM open.CARGOS c1, open.servsusc s
               WHERE s.sesususc = c.cuposusc
                 and s.sesunuse = c1.cargnuse
                 and c1.cargcuco = -1
                 AND C1.CARGDOSO = 'PP-' || LCC.PACKAGE_ID)*/;
    /*SELECT \*+ index(C PK_CUPON) index (lcc PK_LD_CUPON_CAUSAL) *\
    LCC.*, C.CUPOSUSC
     FROM OPEN.LD_CUPON_CAUSAL LCC, OPEN.CUPON C
    WHERE LCC.CUPONUME = C.CUPONUME
      AND LCC.PACKAGE_ID <> 0
      AND C.CUPOTIPO = 'FA'
      AND C.CUPOFECH > TO_CHAR(SYSDATE, 'DD/MM/YYYY')
      AND NOT EXISTS
    (select 1
             from open.CC_Sales_Financ_Cond CSFC
            where CSFC.PACKAGE_ID = lcc.package_id);*/

    RFCU_LDCUPONCAUSAL CU_LDCUPONCAUSAL%rowtype;
    ---Fin CASO 200-1948

    CURSOR CU_LD_CUPON_CAUSAL IS
      SELECT /*+ index(C PK_CUPON) index (lcc PK_LD_CUPON_CAUSAL) */
       LCC.*, C.CUPOSUSC
        FROM OPEN.LD_CUPON_CAUSAL LCC, OPEN.CUPON C
       WHERE LCC.CUPONUME = C.CUPONUME
         AND LCC.PACKAGE_ID <> 0
         AND C.CUPOTIPO = 'FA'
         AND TRUNC(C.CUPOFECH) = TRUNC(SYSDATE)
         AND NOT EXISTS
       (select 1
                from CC_Sales_Financ_Cond CSFC
               where CSFC.PACKAGE_ID = lcc.package_id);

    -- 200-904: Consultar cupones sin solicitud
    CURSOR CU_CUPON_PACKAGE IS
      SELECT /*+ index(C PK_CUPON) index (lcc PK_LD_CUPON_CAUSAL) */
       lcc.*, c.cuposusc, c.cupofech
        FROM OPEN.LD_CUPON_CAUSAL LCC, open.CUPON C
       WHERE LCC.CUPONUME = C.CUPONUME
         and c.cupotipo = 'FA'
         and lcc.package_id = 0
         AND TRUNC(C.Cupofech) = TRUNC(SYSDATE);

    nuSegundos number := dald_parameter.fnuGetNumeric_Value('NUM_SEG_DIF_CUPON');

    -- 200-904: Consultar solicitud de informacion general
    CURSOR cuSolicitud(inuContrato number, idtcupofech date) IS
      select mo_packages.package_id
        from mo_packages, mo_motive
       where mo_packages.package_id = mo_motive.package_id
         and mo_motive.subscription_id = inuContrato
         and mo_packages.package_type_id in
             (SELECT TO_NUMBER(COLUMN_VALUE)
                FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(dald_parameter.fsbGetValue_Chain('COD_SOLIC_INFO_GRAL'),
                                                        ',')))
         and request_date between idtcupofech and
             (idtcupofech + nuSegundos / 86400)
         and rownum < 2;

    /*
    SELECT LCC.*
      FROM OPEN.LD_CUPON_CAUSAL LCC, CUPON C
     WHERE LCC.CUPONUME = C.CUPONUME
       AND TRUNC(C.CUPOFECH) = TRUNC(SYSDATE);
       */

    --/*
    nuProduct cargos.cargnuse%type;
    --nuConcept         cargos.cargconc%type;
    --nuUnits           cargos.cargunid%type;
    --nuChargeCause     cargos.cargcaca%type;
    --nuValue           cargos.cargvalo%type;
    --bsSupportDocument cargos.cargdoso%type;
    --nuPeriodCons      cargos.cargpeco%type;

    nuCupon    cupon.cuponume%type;
    nuSuscripc cupon.cuposusc%type;
    --
    nuPackage_id mo_packages.package_id%type;
    --blValExisteCargo boolean := false;
    --*/
    sbAplica200904 varchar2(200) := 'CRM_SAC_OAP_200904_12';

    TEMPCU_LD_CUPON_CAUSAL CU_LD_CUPON_CAUSAL%ROWTYPE;
    TEMPCU_CUPON_PACKAGE   CU_CUPON_PACKAGE%ROWTYPE;

    -- Tipo de dato condiciones de financiaci?n
    rcSalesFinanCond DACC_Sales_Financ_Cond.styCC_Sales_Financ_Cond;

    --PARAMETRO CODIGO PLAN DE FINANCIACION
    NUCOD_PLA_FIN_SOL_EST_CUE LD_PARAMETER.PARAMETER_ID%TYPE := DALD_PARAMETER.fnuGetNumeric_Value('COD_PLA_FIN_SOL_EST_CUE',
                                                                                                   NULL);

    -- Mensaje de error
    OSBERRORMESSAGE GE_ERROR_LOG.DESCRIPTION%TYPE;
    -- Codigo de error
    ONUERRORCODE GE_ERROR_LOG.ERROR_LOG_ID%TYPE;

    function GetFirstProduct(inususcrip number) return number is
      --Retorna los productos que se encuentran con un estado de corte facturable.
      -- Retorna producto de Gas en estado facturable.
      cursor cuProductGasActivo(suscrip number) is
        select sesunuse
          from servsusc, confesco
         where sesususc = suscrip
           and sesuesco = coeccodi
           and sesuserv = coecserv
           and sesuserv = 7014 -- Servicio Gas
           and coecfact = 'S'
           and rownum <= 1;

      -- Retorna productos del contrato en estado facturable.
      cursor cuProductsActivo(suscrip number) is
        select sesunuse
          from servsusc, confesco
         where sesususc = suscrip
           and sesuesco = coeccodi
           and sesuserv = coecserv
           and coecfact = 'S'
           and rownum <= 1;

      nuProduct_id number := 0;
    begin

      OPEN cuProductGasActivo(inususcrip);
      FETCH cuProductGasActivo
        INTO nuProduct_id;
      CLOSE cuProductGasActivo;

      if ((nuProduct_id = 0) or (nuProduct_id is null)) then
        OPEN cuProductsActivo(inususcrip);
        FETCH cuProductsActivo
          INTO nuProduct_id;
        CLOSE cuProductsActivo;
      end if;

      return nuProduct_id;

    EXCEPTION
      when no_data_found then
        return 0;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    end GetFirstProduct;

  BEGIN

    UT_TRACE.TRACE('INICIO LDC_PKCRMFINANCIACION.PRFINANCIARDUPLICADO', 10);
    dbms_output.put_line('INICIO LDC_PKCRMFINANCIACION.PRFINANCIARDUPLICADO');

    --Inicio CASO 200-1948
    if fblAplicaEntrega(SBCRM_SC_JLV_2001948) then

      FOR RFCU_LDCUPONCAUSAL IN CU_LDCUPONCAUSAL LOOP

        BEGIN

          --codigo cupon
          nuCupon := RFCU_LDCUPONCAUSAL.CUPONUME;
          --codigo contrato
          nuSuscripc := RFCU_LDCUPONCAUSAL.CUPOSUSC; --pktblcupon.fnugetcuposusc(nuCupon);
          --codigo del primer prodcuto. Funcion obtendia del TRIGGER de la tabla LD_CUPON_CAUSAL
          nuProduct := GetFirstProduct(nuSuscripc);

          ---actualiza el codigo del prodcuto al motivo de la socliitud si no tiene el codigo del prodcuto

          update mo_motive mm
             set mm.product_id = nuProduct
           where mm.package_id = RFCU_LDCUPONCAUSAL.PACKAGE_ID
             and mm.product_id is null;

          dbms_output.put_line('**************** Financiacion inicio con exito');
          ut_trace.trace('**************** Financiacion inicio con exito');

          dbms_output.put_line('**************** SOLICITUD [' ||
                               RFCU_LDCUPONCAUSAL.PACKAGE_ID || ']');
          ut_trace.trace('**************** SOLICITUD [' ||
                         RFCU_LDCUPONCAUSAL.PACKAGE_ID || ']');

          UT_TRACE.TRACE('**************** CC_BOREQUESTRATING.REQUESTRATINGBYFGCA',
                         10);
          dbms_output.put_line('**************** CC_BOREQUESTRATING.REQUESTRATINGBYFGCA');
          CC_BOREQUESTRATING.REQUESTRATINGBYFGCA(RFCU_LDCUPONCAUSAL.PACKAGE_ID);

          ut_trace.trace('**************** CC_BOACCOUNTS.GENERATEACCOUNTBYPACK',
                         10);
          dbms_output.put_line('-- Uso del servicio CC_BOACCOUNTS.GENERATEACCOUNTBYPACK');
          CC_BOACCOUNTS.GENERATEACCOUNTBYPACK(RFCU_LDCUPONCAUSAL.PACKAGE_ID);

          --Actualiza los campos CC_SALES_FINANC_COND
          ut_trace.trace('-- Actualiza los campos CC_SALES_FINANC_COND',
                         10);
          dbms_output.put_line('-- Actualiza los campos CC_SALES_FINANC_COND');
          rcSalesFinanCond.package_id          := RFCU_LDCUPONCAUSAL.PACKAGE_ID; -- Solicitud
          rcSalesFinanCond.financing_plan_id   := NUCOD_PLA_FIN_SOL_EST_CUE; -- Plan de financiaci?n
          rcSalesFinanCond.compute_method_id   := pktblplandife.fnugetpaymentmethod(NUCOD_PLA_FIN_SOL_EST_CUE); -- M?todo financiaci?n
          rcSalesFinanCond.interest_rate_id    := pktblplandife.fnugetinterestratecod(NUCOD_PLA_FIN_SOL_EST_CUE); -- Inter?s
          rcSalesFinanCond.first_pay_date      := sysdate;
          rcSalesFinanCond.percent_to_finance  := 100;
          rcSalesFinanCond.interest_percent    := 0;
          rcSalesFinanCond.spread              := 0;
          rcSalesFinanCond.quotas_number       := 1; -- N?mero de cuotas
          rcSalesFinanCond.tax_financing_one   := 'N';
          rcSalesFinanCond.value_to_finance    := 0;
          rcSalesFinanCond.document_support    := 'PP-' ||
                                                  RFCU_LDCUPONCAUSAL.PACKAGE_ID;
          rcSalesFinanCond.initial_payment     := 0;
          rcSalesFinanCond.average_quote_value := 0;

          -- Insertar datos
          ut_trace.trace('**************** DACC_Sales_Financ_Cond.insrecord',
                         10);
          dbms_output.put_line('**************** DACC_Sales_Financ_Cond.insrecord');
          DACC_Sales_Financ_Cond.insrecord(rcSalesFinanCond);

          ut_trace.trace('**************** CC_BOFINANCING.FINANCINGORDER',
                         10);
          dbms_output.put_line('**************** CC_BOFINANCING.FINANCINGORDER');

          --Inicio Logica SAO 386766
          /* Actualizar Flag ACTIVE antes de la financiaci?n */
          Begin
            UPDATE mo_motive_payment mp
               SET mp.active = 'N'
             WHERE mp.package_payment_id =
                   (SELECT pp.package_payment_id
                      FROM mo_package_payment pp
                     WHERE pp.package_id = RFCU_LDCUPONCAUSAL.PACKAGE_ID)
               AND mp.coupon_id = nuCupon;
            commit;
          end;
          --Fin Logica SAO 386766

          CC_BOFINANCING.FINANCINGORDER(RFCU_LDCUPONCAUSAL.PACKAGE_ID);

          dbms_output.put_line('**************** Financiacion termino con exito');
          ut_trace.trace('**************** Financiacion termino con exito)',
                         10);
          --COMMIT;
        EXCEPTION
          when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            Errors.getError(ONUERRORCODE, OSBERRORMESSAGE);
            dbms_output.put_line('ONUERRORCODE[' || ONUERRORCODE ||
                                 '] - OSBERRORMESSAGE[' || OSBERRORMESSAGE || ']');
            ut_trace.trace('-- Financiacion termino con errores - Codigo[' ||
                           ONUERRORCODE || '] - Mensaje[' ||
                           OSBERRORMESSAGE || ']',
                           10);
            rollback;
          when others then
            Errors.getError(ONUERRORCODE, OSBERRORMESSAGE);
            dbms_output.put_line('ONUERRORCODE[' || ONUERRORCODE ||
                                 '] - OSBERRORMESSAGE[' || OSBERRORMESSAGE || ']');
            ut_trace.trace('-- Financiacion termino con errores - Codigo[' ||
                           ONUERRORCODE || '] - Mensaje[' ||
                           OSBERRORMESSAGE || ']',
                           10);
            rollback;
        END;

      END LOOP;
      --Fin CASO 200-1948
    else

      FOR TEMPCU_LD_CUPON_CAUSAL IN CU_LD_CUPON_CAUSAL LOOP

        BEGIN

          --codigo cupon
          nuCupon := TEMPCU_LD_CUPON_CAUSAL.CUPONUME;
          --codigo contrato
          nuSuscripc := TEMPCU_LD_CUPON_CAUSAL.CUPOSUSC; --pktblcupon.fnugetcuposusc(nuCupon);
          --codigo del primer prodcuto. Funcion obtendia del TRIGGER de la tabla LD_CUPON_CAUSAL
          nuProduct := GetFirstProduct(nuSuscripc);

          ---actualiza el codigo del prodcuto al motivo de la socliitud si no tiene el codigo del prodcuto

          update mo_motive mm
             set mm.product_id = nuProduct
           where mm.package_id = TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID
             and mm.product_id is null;

          dbms_output.put_line('**************** Financiacion inicio con exito');
          ut_trace.trace('**************** Financiacion inicio con exito');

          dbms_output.put_line('**************** SOLICITUD [' ||
                               TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID || ']');
          ut_trace.trace('**************** SOLICITUD [' ||
                         TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID || ']');

          UT_TRACE.TRACE('**************** CC_BOREQUESTRATING.REQUESTRATINGBYFGCA',
                         10);
          dbms_output.put_line('**************** CC_BOREQUESTRATING.REQUESTRATINGBYFGCA');
          CC_BOREQUESTRATING.REQUESTRATINGBYFGCA(TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID);

          ut_trace.trace('**************** CC_BOACCOUNTS.GENERATEACCOUNTBYPACK',
                         10);
          dbms_output.put_line('-- Uso del servicio CC_BOACCOUNTS.GENERATEACCOUNTBYPACK');
          CC_BOACCOUNTS.GENERATEACCOUNTBYPACK(TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID);

          --Actualiza los campos CC_SALES_FINANC_COND
          ut_trace.trace('-- Actualiza los campos CC_SALES_FINANC_COND',
                         10);
          dbms_output.put_line('-- Actualiza los campos CC_SALES_FINANC_COND');
          rcSalesFinanCond.package_id          := TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID; -- Solicitud
          rcSalesFinanCond.financing_plan_id   := NUCOD_PLA_FIN_SOL_EST_CUE; -- Plan de financiaci?n
          rcSalesFinanCond.compute_method_id   := pktblplandife.fnugetpaymentmethod(NUCOD_PLA_FIN_SOL_EST_CUE); -- M?todo financiaci?n
          rcSalesFinanCond.interest_rate_id    := pktblplandife.fnugetinterestratecod(NUCOD_PLA_FIN_SOL_EST_CUE); -- Inter?s
          rcSalesFinanCond.first_pay_date      := sysdate;
          rcSalesFinanCond.percent_to_finance  := 100;
          rcSalesFinanCond.interest_percent    := 0;
          rcSalesFinanCond.spread              := 0;
          rcSalesFinanCond.quotas_number       := 1; -- N?mero de cuotas
          rcSalesFinanCond.tax_financing_one   := 'N';
          rcSalesFinanCond.value_to_finance    := 0;
          rcSalesFinanCond.document_support    := 'PP-' ||
                                                  TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID;
          rcSalesFinanCond.initial_payment     := 0;
          rcSalesFinanCond.average_quote_value := 0;

          -- Insertar datos
          ut_trace.trace('**************** DACC_Sales_Financ_Cond.insrecord',
                         10);
          dbms_output.put_line('**************** DACC_Sales_Financ_Cond.insrecord');
          DACC_Sales_Financ_Cond.insrecord(rcSalesFinanCond);

          ut_trace.trace('**************** CC_BOFINANCING.FINANCINGORDER',
                         10);
          dbms_output.put_line('**************** CC_BOFINANCING.FINANCINGORDER');

          --Inicio Logica SAO 386766
          /* Actualizar Flag ACTIVE antes de la financiaci?n */
          Begin
            UPDATE mo_motive_payment mp
               SET mp.active = 'N'
             WHERE mp.package_payment_id =
                   (SELECT pp.package_payment_id
                      FROM mo_package_payment pp
                     WHERE pp.package_id = TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID)
               AND mp.coupon_id = nuCupon;
            commit;
          end;
          --Fin Logica SAO 386766

          CC_BOFINANCING.FINANCINGORDER(TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID);

          dbms_output.put_line('**************** Financiacion termino con exito');
          ut_trace.trace('**************** Financiacion termino con exito)',
                         10);
          --COMMIT;
        EXCEPTION
          when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            Errors.getError(ONUERRORCODE, OSBERRORMESSAGE);
            dbms_output.put_line('ONUERRORCODE[' || ONUERRORCODE ||
                                 '] - OSBERRORMESSAGE[' || OSBERRORMESSAGE || ']');
            ut_trace.trace('-- Financiacion termino con errores - Codigo[' ||
                           ONUERRORCODE || '] - Mensaje[' ||
                           OSBERRORMESSAGE || ']',
                           10);
            rollback;
          when others then
            Errors.getError(ONUERRORCODE, OSBERRORMESSAGE);
            dbms_output.put_line('ONUERRORCODE[' || ONUERRORCODE ||
                                 '] - OSBERRORMESSAGE[' || OSBERRORMESSAGE || ']');
            ut_trace.trace('-- Financiacion termino con errores - Codigo[' ||
                           ONUERRORCODE || '] - Mensaje[' ||
                           OSBERRORMESSAGE || ']',
                           10);
            rollback;
        END;

      END LOOP;

      -- CA. 200-904: procesa los cupones que no tienen solicitud asociada
      if fblaplicaentrega(sbAplica200904) then

        FOR TEMPCU_CUPON_PACKAGE IN CU_CUPON_PACKAGE LOOP

          BEGIN

            --codigo cupon
            nuCupon := TEMPCU_CUPON_PACKAGE.CUPONUME;
            --codigo contrato
            nuSuscripc := TEMPCU_CUPON_PACKAGE.CUPOSUSC; --pktblcupon.fnugetcuposusc(nuCupon);
            --codigo del primer prodcuto. Funcion obtendia del TRIGGER de la tabla LD_CUPON_CAUSAL
            nuProduct := GetFirstProduct(nuSuscripc);

            -- Consultar solicitud de informacion general
            open cuSolicitud(nuSuscripc, TEMPCU_CUPON_PACKAGE.CUPOFECH);
            fetch cuSolicitud
              into nuPackage_id;
            if (cuSolicitud%notfound) then
              nuPackage_id := 0;
              --close cuSolicitud;
            end if;
            close cuSolicitud;

            --- actualiza el codigo del prodcuto al motivo de la solicitud si no tiene el codigo del prodcuto
            update mo_motive mm
               set mm.product_id = nuProduct
             where mm.package_id = nuPackage_id
               and mm.product_id is null;

            -- CA 200-904: Proceso Actualizar Cargo
            update open.cargos
               set cargdoso = 'PP-' || nuPackage_id
             where cargnuse = nuProduct
               and cargcuco = -1
               and cargdoso = 'PP-0'
               and cargconc = 24;

            dbms_output.put_line('**************** Financiacion inicio con exito');
            ut_trace.trace('**************** Financiacion inicio con exito');

            dbms_output.put_line('**************** SOLICITUD [' ||
                                 nuPackage_id || ']');
            ut_trace.trace('**************** SOLICITUD [' || nuPackage_id || ']');

            UT_TRACE.TRACE('**************** CC_BOREQUESTRATING.REQUESTRATINGBYFGCA',
                           10);
            dbms_output.put_line('**************** CC_BOREQUESTRATING.REQUESTRATINGBYFGCA');

            -- Liquidar Solicitud
            CC_BOREQUESTRATING.REQUESTRATINGBYFGCA(nuPackage_id); --TEMPCU_CUPON_PACKAGE.PACKAGE_ID);

            ut_trace.trace('**************** CC_BOACCOUNTS.GENERATEACCOUNTBYPACK',
                           10);
            dbms_output.put_line('-- Uso del servicio CC_BOACCOUNTS.GENERATEACCOUNTBYPACK');

            -- Generar Factura para la Solicitud
            CC_BOACCOUNTS.GENERATEACCOUNTBYPACK(nuPackage_id); --TEMPCU_CUPON_PACKAGE.PACKAGE_ID);

            -- Actualiza los campos CC_SALES_FINANC_COND
            ut_trace.trace('-- Actualiza los campos CC_SALES_FINANC_COND',
                           10);
            dbms_output.put_line('-- Actualiza los campos CC_SALES_FINANC_COND');

            rcSalesFinanCond.package_id          := nuPackage_id; --TEMPCU_CUPON_PACKAGE.PACKAGE_ID; -- Solicitud
            rcSalesFinanCond.financing_plan_id   := NUCOD_PLA_FIN_SOL_EST_CUE; -- Plan de financiaci?n
            rcSalesFinanCond.compute_method_id   := pktblplandife.fnugetpaymentmethod(NUCOD_PLA_FIN_SOL_EST_CUE); -- M?todo financiaci?n
            rcSalesFinanCond.interest_rate_id    := pktblplandife.fnugetinterestratecod(NUCOD_PLA_FIN_SOL_EST_CUE); -- Inter?s
            rcSalesFinanCond.first_pay_date      := sysdate;
            rcSalesFinanCond.percent_to_finance  := 100;
            rcSalesFinanCond.interest_percent    := 0;
            rcSalesFinanCond.spread              := 0;
            rcSalesFinanCond.quotas_number       := 1; -- Numero de cuotas
            rcSalesFinanCond.tax_financing_one   := 'N';
            rcSalesFinanCond.value_to_finance    := 0;
            rcSalesFinanCond.document_support    := 'PP-' || nuPackage_id; --TEMPCU_CUPON_PACKAGE.PACKAGE_ID;
            rcSalesFinanCond.initial_payment     := 0;
            rcSalesFinanCond.average_quote_value := 0;

            -- Insertar datos
            ut_trace.trace('**************** DACC_Sales_Financ_Cond.insrecord',
                           10);
            dbms_output.put_line('**************** DACC_Sales_Financ_Cond.insrecord');
            DACC_Sales_Financ_Cond.insrecord(rcSalesFinanCond);

            ut_trace.trace('**************** CC_BOFINANCING.FINANCINGORDER',
                           10);
            dbms_output.put_line('**************** CC_BOFINANCING.FINANCINGORDER');

            --Inicio Logica SAO 386766
            /* Actualizar Flag ACTIVE antes de la financiaci?n */
            Begin
              UPDATE mo_motive_payment mp
                 SET mp.active = 'N'
               WHERE mp.package_payment_id =
                     (SELECT pp.package_payment_id
                        FROM mo_package_payment pp
                       WHERE pp.package_id = nuPackage_id --TEMPCU_CUPON_PACKAGE.PACKAGE_ID
                      )
                 AND mp.coupon_id = nuCupon;
              commit;
            end;
            --Fin Logica SAO 386766

            CC_BOFINANCING.FINANCINGORDER(nuPackage_id); --TEMPCU_CUPON_PACKAGE.PACKAGE_ID);

            -- CA 200-904: Proceso Actualizar ld_cupon_causal
            begin
              update open.ld_cupon_causal
                 set package_id = nuPackage_id
               where cuponume = nuCupon
                 and package_id = 0;

            exception
              when others then
                ut_trace.trace('Error Actualiza Tabla LD_CUPON_CAUSAL', 10);
                null;
            end;

            dbms_output.put_line('**************** Financiacion termino con exito');
            ut_trace.trace('**************** Financiacion termino con exito)',
                           10);
            COMMIT;
          EXCEPTION
            when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
              Errors.getError(ONUERRORCODE, OSBERRORMESSAGE);
              dbms_output.put_line('ONUERRORCODE[' || ONUERRORCODE ||
                                   '] - OSBERRORMESSAGE[' ||
                                   OSBERRORMESSAGE || ']');
              ut_trace.trace('-- Financiacion termino con errores - Codigo[' ||
                             ONUERRORCODE || '] - Mensaje[' ||
                             OSBERRORMESSAGE || ']',
                             10);
              rollback;
            when others then
              Errors.getError(ONUERRORCODE, OSBERRORMESSAGE);
              dbms_output.put_line('ONUERRORCODE[' || ONUERRORCODE ||
                                   '] - OSBERRORMESSAGE[' ||
                                   OSBERRORMESSAGE || ']');
              ut_trace.trace('-- Financiacion termino con errores - Codigo[' ||
                             ONUERRORCODE || '] - Mensaje[' ||
                             OSBERRORMESSAGE || ']',
                             10);
              rollback;
          END;

        END LOOP;
      end if;

    end if;

    commit;
    UT_TRACE.TRACE('FIN LDC_PKCRMFINANCIACION.PRFINANCIARDUPLICADO', 10);
    dbms_output.put_line('FIN LDC_PKCRMFINANCIACION.PRFINANCIARDUPLICADO');

  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := 'ERROR';
  END PRFINANCIARDUPLICADO;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : FRFORDENES
  Descripcion    : FUNCION QUE PERMITE RETORNAR LOS CUPONES QUE SE HAN GENERADO POR
                   SOLLICITUD DE ESTADO DE CUENTA CON CARGO A LA -1 Y NO TENGAN
                   FINANCIACION DEL VALOR DEL DUPLICADO.

  Autor          : Jorge Valiente
  Fecha          : 09/11/2015

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha                   Autor             Modificacion
  =========            =========           ====================
  14/02/2018           Jorge Valiente      CASO 200-1600: Modifcacion de sentencia agregando un indice llamado PK_LD_CUPON_CAUSAL
                                                          en la sentencia de de la variable SBAPLICA200904
  29/08/2017            oparra             CA. 200-904: Se optimiza la consulta.
  25/04/2017            oparra             CA. 200-904: consultar cupones que no
                                                       tiene solicitud asociada.
  26/06/2018           Jorge Valiente      CASO 200-1948: Crear nueva logica para el proceso de financiacion de GDC y omitir
                                                          la logica del CASO 200-904
  ******************************************************************/
  FUNCTION FRCDUPLICADO RETURN pkConstante.tyRefCursor IS

    rfcursor pkConstante.tyRefCursor;

    sbINITIAL  ge_boInstanceControl.stysbValue;
    sbFINAL    ge_boInstanceControl.stysbValue;
    sbCOMMENTS ge_boInstanceControl.stysbValue;

    cnuNULL_ATTRIBUTE constant number := 2126;

    sbCPSCFEIN ge_boInstanceControl.stysbValue;
    sbCPSCFEFI ge_boInstanceControl.stysbValue;

    sbAplica200904 varchar2(200) := 'CRM_SAC_OAP_200904_12';
    nuSegundos     number := dald_parameter.fnuGetNumeric_Value('NUM_SEG_DIF_CUPON');

    dtCPSCFEIN DATE;
    dtCPSCFEFI DATE;

    csbCOD_SOLIC_INFO_GRAL ld_parameter.VALUE_CHAIN%TYPE;

    --Inicio CASO 200-1948
    sbCPSCFEINGDC ge_boInstanceControl.stysbValue;
    sbCPSCFEFIGDC ge_boInstanceControl.stysbValue;
    --Fin CASO 200-1948

  BEGIN
    sbCPSCFEIN := ge_boInstanceControl.fsbGetFieldValue('PP_COPPSSCO',
                                                        'CPSCFEIN');
    sbCPSCFEFI := ge_boInstanceControl.fsbGetFieldValue('PP_COPPSSCO',
                                                        'CPSCFEFI');

    dtCPSCFEIN := trunc(to_date(sbCPSCFEIN));
    dtCPSCFEFI := trunc(to_date(sbCPSCFEFI)) + 1;

    csbCOD_SOLIC_INFO_GRAL := dald_parameter.fsbGetValue_Chain('COD_SOLIC_INFO_GRAL');

    UT_TRACE.TRACE('INICIO LDC_PKCRMFINANCIACION.FRCDUPLICADO -> sbCPSCFEIN ' ||
                   sbCPSCFEIN,
                   10);
    UT_TRACE.TRACE('INICIO LDC_PKCRMFINANCIACION.FRCDUPLICADO -> sbCPSCFEFI ' ||
                   sbCPSCFEFI,
                   10);

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    if (sbCPSCFEIN is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'FECHA INICIAL');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (sbCPSCFEFI is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'FECHA FINAL');
      raise ex.CONTROLLED_ERROR;
    end if;

    ut_trace.trace('Inicio LDC_PKCRMFINANCIACION.FRCDUPLICADO', 10);
    ut_trace.trace('sbCPSCFEIN[' || sbCPSCFEIN || '] - sbCPSCFEFI[' ||
                   sbCPSCFEFI || ']',
                   10);

    --Inicio CASO 200-1948
    if fblAplicaEntrega(SBCRM_SC_JLV_2001948) then

      sbCPSCFEINGDC := TO_CHAR(TO_DATE(sbCPSCFEIN), 'DD/MM/YYYY');
      sbCPSCFEFIGDC := TO_CHAR(TO_DATE(sbCPSCFEFI) + 1, 'DD/MM/YYYY');

      ut_trace.trace('sbCPSCFEIN - FINAL[' || sbCPSCFEINGDC ||
                     '] - sbCPSCFEFI - FINAL[' || sbCPSCFEFIGDC || ']',
                     10);

      OPEN rfcursor FOR
        SELECT /*+ index(C PK_CUPON) index (lcc PK_LD_CUPON_CAUSAL) */
         LCC.CUPONUME || '-' || LCC.PACKAGE_ID "CUPON-SOLICITUD",
         C.CUPOSUSC "CONTRATO"
          FROM OPEN.LD_CUPON_CAUSAL LCC, OPEN.CUPON C
         WHERE LCC.CUPONUME = C.CUPONUME
           AND LCC.PACKAGE_ID <> 0
           AND C.CUPOTIPO = 'FA'
           --AND TRUNC(C.CUPOFECH) >= sbCPSCFEINGDC
           --AND TRUNC(C.CUPOFECH) < sbCPSCFEFIGDC
           AND C.CUPOFECH >= sbCPSCFEINGDC
           AND C.CUPOFECH < sbCPSCFEFIGDC
           AND NOT EXISTS (select 1
                  from open.CC_Sales_Financ_Cond CSFC
                 where CSFC.PACKAGE_ID = lcc.package_id)
         /*
           and EXISTS
         (SELECT 1
                  FROM open.CARGOS c1, open.servsusc s
                 WHERE s.sesususc = c.cuposusc
                   and s.sesunuse = c1.cargnuse
                   and c1.cargcuco = -1
                   AND C1.CARGDOSO = 'PP-' || LCC.PACKAGE_ID)*/;

      /*
      SELECT \*+ index(C PK_CUPON) index (lcc PK_LD_CUPON_CAUSAL) *\
       LCC.CUPONUME || '-' || LCC.PACKAGE_ID, C.CUPOSUSC
        FROM OPEN.LD_CUPON_CAUSAL LCC, OPEN.CUPON C
       WHERE LCC.CUPONUME = C.CUPONUME
         AND LCC.PACKAGE_ID <> 0
         AND C.CUPOTIPO = 'FA'
            --AND C.CUPOFECH > TO_CHAR(SYSDATE, 'DD/MM/YYYY')
         AND C.CUPOFECH >= sbCPSCFEINGDC
         AND C.CUPOFECH < sbCPSCFEFIGDC
         AND NOT EXISTS
       (select 1
                from open.CC_Sales_Financ_Cond CSFC
               where CSFC.PACKAGE_ID = lcc.package_id);
         */
      --Inicio CASO 200-1948
    else

      -- CA. 200-904: Incluir los cupones que no tienen asociado la solicitud
      if fblaplicaentrega(sbAplica200904) then
        ut_trace.trace('****************fblaplicaentrega(sbAplica200904)',
                       10);

        OPEN rfcursor FOR
          WITH CUPONES AS
           (select /*+ index(C PK_CUPON)  index (lcc PK_LD_CUPON_CAUSAL)*/
             lcc.*, c.cuposusc, c.cupofech
              from OPEN.ld_cupon_causal lcc, OPEN.cupon c
             where lcc.cuponume = c.cuponume
               and lcc.package_id = 0
               and c.cupotipo = 'FA'
                  --AND trunc(c.cupofech) BETWEEN trunc(dtCPSCFEIN) AND trunc(dtCPSCFEFI)
               AND TRUNC(c.cupofech) >= dtCPSCFEIN
               AND TRUNC(c.cupofech) < dtCPSCFEFI)
          select *
            from (SELECT CASE
                           WHEN cc.package_id = 0 THEN
                            (SELECT cc.cuponume || '-' || p.package_id "CUPON-SOLICITUD"
                               FROM open.mo_packages p, open.mo_motive m
                              WHERE p.package_id = m.package_id
                                AND m.subscription_id = cc.cuposusc
                                AND request_date BETWEEN cc.cupofech AND
                                    (cc.cupofech + nuSegundos / 86400)
                                AND package_type_id IN
                                    (SELECT TO_NUMBER(COLUMN_VALUE)
                                       FROM TABLE(OPEN.ldc_boutilities.splitstrings(csbCOD_SOLIC_INFO_GRAL,
                                                                                    ',')))
                                AND ROWNUM < 2)
                         END "CUPON-SOLICITUD",
                         cc.cuposusc CONTRATO
                    FROM cupones cc
                  --open.cupon c
                  --WHERE c.cuponume = cc.cuponume
                  )
           where "CUPON-SOLICITUD" is not null
          union all
          --dbms_output.put_line(sysdate);
          SELECT /*+ index(LCC PK_LD_CUPON_CAUSAL) index(C PK_CUPON) */
           LCC.CUPONUME || '-' || LCC.PACKAGE_ID "CUPON-SOLICITUD",
           c.cuposusc CONTRATO --,
          ---c.cupofech FECHA_GENERACION
            FROM OPEN.LD_CUPON_CAUSAL LCC, CUPON C, CARGOS CC
           WHERE LCC.PACKAGE_ID <> 0
             AND LCC.CUPONUME = C.CUPONUME
             AND CC.CARGDOSO = 'PP-' || LCC.PACKAGE_ID
                --AND TRUNC(C.CUPOFECH) BETWEEN TO_DATE(&sbCPSCFEIN, 'DD/MM/YYYY') AND
                --    TRUNC(C.CUPOFECH)
             AND TRUNC(C.CUPOFECH) >= dtCPSCFEIN --sbCPSCFEIN
             AND TRUNC(C.CUPOFECH) < dtCPSCFEFI --sbCPSCFEFI
             and (select count(CSFC.PACKAGE_ID)
                    from CC_Sales_Financ_Cond CSFC
                   where CSFC.PACKAGE_ID = lcc.package_id) = 0;
        /*SELECT \*+ index(LCC PK_LD_CUPON_CAUSAL) index(C PK_CUPON) *\
         LCC.CUPONUME || '-' || LCC.PACKAGE_ID "CUPON-SOLICITUD",
         c.cuposusc "CONTRATO"--,
        ---c.cupofech FECHA_GENERACION
          FROM OPEN.LD_CUPON_CAUSAL LCC, CUPON C, CARGOS CC
         WHERE LCC.PACKAGE_ID <> 0
           AND LCC.CUPONUME = C.CUPONUME
           AND CC.CARGDOSO = 'PP-' || LCC.PACKAGE_ID
              --AND TRUNC(C.CUPOFECH) BETWEEN TO_DATE(&sbCPSCFEIN, 'DD/MM/YYYY') AND
              --    TRUNC(C.CUPOFECH)
           AND TRUNC(C.CUPOFECH) >= dtCPSCFEIN--TO_DATE(sbCPSCFEIN, 'DD/MM/YYYY') --sbCPSCFEIN
           AND TRUNC(C.CUPOFECH) < dtCPSCFEFI--TO_DATE(sbCPSCFEFI, 'DD/MM/YYYY') + 1 --sbCPSCFEFI
           and (select count(CSFC.PACKAGE_ID)
                  from CC_Sales_Financ_Cond CSFC
                 where CSFC.PACKAGE_ID = lcc.package_id) = 0
         ORDER BY LCC.CUPONUME DESC;*/

        /*WITH CUPONES
        AS
        (
            select \*+ index(C PK_CUPON)  index (lcc PK_LD_CUPON_CAUSAL)*\ lcc.*, c.cuposusc, c.cupofech
            from OPEN.ld_cupon_causal lcc,
                 OPEN.cupon c
            where lcc.cuponume = c.cuponume
            and cupotipo = 'FA'
            AND c.cupofech BETWEEN to_date(sbCPSCFEIN,'dd/mm/yyyy hh24:mi:ss')
                    AND to_date(sbCPSCFEFI,'dd/mm/yyyy hh24:mi:ss')
        )
        select * from
        (
        SELECT CASE
            WHEN cc.package_id = 0 THEN
                (SELECT cc.cuponume|| '-' ||p.package_id "CUPON-SOLICITUD"
                 FROM open.mo_packages p,
                      open.mo_motive m
                 WHERE p.package_id = m.package_id
                 AND m.subscription_id = cc.cuposusc
                 AND request_date BETWEEN cc.cupofech AND (cc.cupofech + nuSegundos / 86400)
                 AND package_type_id IN ( SELECT TO_NUMBER (COLUMN_VALUE)
                                          FROM TABLE (OPEN.ldc_boutilities.splitstrings
                                                  (csbCOD_SOLIC_INFO_GRAL,
                                                         ','
                                                   )
                                                   ))
                 AND ROWNUM < 2)
            ELSE (SELECT cc.cuponume || '-' || cc.package_id "CUPON-SOLICITUD"
                  FROM dual --open.mo_motive mo
                  WHERE --mo.PACKAGE_ID = cc.PACKAGE_ID
                  --AND
                  NOT EXISTS (SELECT 'x'
                                  FROM OPEN.cc_sales_financ_cond csfc
                                  WHERE csfc.package_id = cc.package_id)
                  AND EXISTS (SELECT'x'
                              FROM open.CARGOS
                              WHERE cargnuse = pr_boproduct.fnugetprodbysuscandtype(7014,cc.cuposusc)
                              AND cargcuco = -1
                              and cargconc = 24
                              AND cargdoso = 'PP-' || cc.package_id))
            END "CUPON-SOLICITUD",
            cc.cuposusc CONTRATO
        FROM cupones cc
             --open.cupon c
        --WHERE c.cuponume = cc.cuponume
        )
        where "CUPON-SOLICITUD" is not null;*/
      else
        ut_trace.trace('****************ESLE', 10);
        OPEN rfcursor FOR
          SELECT lcc.cuponume || '-' || lcc.package_id "CUPON-SOLICITUD",
                 cuposusc "CONTRATO"
            FROM OPEN.ld_cupon_causal lcc, OPEN.cupon c, open.mo_motive mo
           WHERE lcc.package_id > 0
             AND c.cupofech >= dtCPSCFEIN
             AND c.cupofech < dtCPSCFEFI
             AND lcc.cuponume = c.cuponume
             AND lcc.PACKAGE_ID = mo.PACKAGE_ID
             AND NOT EXISTS (SELECT 'x'
                    FROM OPEN.cc_sales_financ_cond csfc
                   WHERE csfc.package_id = lcc.package_id)
             AND EXISTS
           (SELECT 'x'
                    FROM open.CARGOS cc
                   WHERE cargnuse = mo.PRODUCT_ID
                     AND cargcuco = -1
                     AND cc.cargdoso = 'PP-' || lcc.package_id);
      end if;

      /*
      SELECT LCC.PACKAGE_ID || '-' || LCC.CUPONUME "SOLICITUD-CUPON",--"SOLICITUD", --|| '-' || LCC.CUPONUME "SOLICITUD-CUPON",
             LCC.CUPONUME   "CUPON",
             CC.CARGNUSE "NUMERO SERVICIO"
        FROM OPEN.LD_CUPON_CAUSAL LCC, CUPON C, CARGOS CC
       WHERE LCC.CUPONUME = C.CUPONUME
         AND TRUNC(C.CUPOFECH) >= sbCPSCFEIN
         AND TRUNC(C.CUPOFECH) <= sbCPSCFEFI
            --AND TRUNC(C.CUPOFECH) >= TRUNC(TO_DATE(sbCPSCFEIN, 'DD/MM/YYYY'))
            --AND TRUNC(C.CUPOFECH) <= TRUNC(TO_DATE(sbCPSCFEFI, 'DD/MM/YYYY'))
            --AND TRUNC(C.CUPOFECH) >= TRUNC(SYSDATE - 60)
            --AND TRUNC(C.CUPOFECH) <= TRUNC(SYSDATE)
         and (select count(CSFC.PACKAGE_ID)
                from CC_Sales_Financ_Cond CSFC
               where CSFC.PACKAGE_ID = lcc.package_id) = 0
         AND CC.CARGDOSO = 'PP-' || LCC.PACKAGE_ID;
         --*/
    end if;

    ut_trace.trace('Fin LDC_PKCRMFINANCIACION.FRCDUPLICADO', 10);

    return(rfcursor);

  EXCEPTION
    WHEN OTHERS THEN
      OPEN rfcursor FOR
        SELECT 'No se puedo ejecutar la sentencia de forma adecuada valide con el Administrador.' "Error Sentencia"
          FROM DUAL;

      return(rfcursor);

  END FRCDUPLICADO;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PRGENERATRABAJOADCIONAL
  Descripcion    : PROCEDIMIENTO QUE PERMITE FINANCIAR LOS CUPONES QUE SE HAN GENERADO POR
                   SOLLICITUD DE ESTADO DE CUENTA CON CARGO A LA -1 Y NO TENGAN
                   FINANCIACION DEL VALOR DEL DUPLICADO.

  Autor          : Jorge Valiente
  Fecha          : 20/08/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  06/04/2016      Jorge Valiente      100-11746: Se adiciona la logica manifestada por OPEN en la qeu informa
                                                 la modificaci?n del paquete LDC_PKCRMFINANCIACION.
                                                 PRFINANCIARDUPLICADO para activar y desactivar un flag ACTIVE
                                                 en la tabla MO_MOTIVE_PAYMENT, antes y despu?s de realizar
                                                 el proceso de finaciaci?n, respectivamente.
  17/06/2016      Jorge Valiente      SAO 386766:Solucion enviada por OPEN para el inconveninte presentado
                                                 para el proceso de financiacion.
                                                 La logica aplicada es exactamente la misma que define OPEN
                                                 para evitar inconvenietes en el proceso de financiacion.
  25/04/2017      oparra              CA. 200-904: Ajuste financiacion Kiosko, procesar cupones que no
                                                 tiene solicitud asociada.
   ******************************************************************/
  PROCEDURE PRFINANCIARDUPLICADOPB(isbId           IN VARCHAR2,
                                   inuCurrent      IN NUMBER,
                                   inuTotal        IN NUMBER,
                                   onuErrorCode    OUT NUMBER,
                                   osbErrorMessage OUT VARCHAR2) IS

    CURSOR CU_LD_CUPON_CAUSAL IS
      SELECT LCC.*
        FROM OPEN.LD_CUPON_CAUSAL LCC
       WHERE LCC.CUPONUME || '-' || LCC.PACKAGE_ID = isbId;

    --/*
    nuProduct cargos.cargnuse%type;
    --nuConcept         cargos.cargconc%type;
    --nuUnits           cargos.cargunid%type;
    --nuChargeCause     cargos.cargcaca%type;
    --nuValue           cargos.cargvalo%type;
    --bsSupportDocument cargos.cargdoso%type;
    --nuPeriodCons      cargos.cargpeco%type;

    nuCupon    cupon.cuponume%type;
    nuSuscripc cupon.cuposusc%type;
    nuPackage  mo_packages.package_id%type;
    --
    --nuSegundos  number  := dald_parameter.fnuGetNumeric_Value('NUM_SEG_DIF_CUPON');
    --blValExisteCargo boolean := false;
    --*/

    TEMPCU_LD_CUPON_CAUSAL CU_LD_CUPON_CAUSAL%ROWTYPE;

    -- Tipo de dato condiciones de financiaci?n
    rcSalesFinanCond DACC_Sales_Financ_Cond.styCC_Sales_Financ_Cond;

    --PARAMETRO CODIGO PLAN DE FINANCIACION
    NUCOD_PLA_FIN_SOL_EST_CUE LD_PARAMETER.PARAMETER_ID%TYPE := DALD_PARAMETER.fnuGetNumeric_Value('COD_PLA_FIN_SOL_EST_CUE',
                                                                                                   NULL);

    function GetFirstProduct(inususcrip number) return number is
      --Retorna los productos que se encuentran con un estado de corte facturable.
      -- Retorna producto de Gas en estado facturable.
      cursor cuProductGasActivo(suscrip number) is
        select sesunuse
          from servsusc, confesco
         where sesususc = suscrip
           and sesuesco = coeccodi
           and sesuserv = coecserv
           and sesuserv = 7014 -- Servicio Gas
           and coecfact = 'S'
           and rownum <= 1;

      -- Retorna productos del contrato en estado facturable.
      cursor cuProductsActivo(suscrip number) is
        select sesunuse
          from servsusc, confesco
         where sesususc = suscrip
           and sesuesco = coeccodi
           and sesuserv = coecserv
           and coecfact = 'S'
           and rownum <= 1;

      nuProduct_id number := 0;
    begin

      OPEN cuProductGasActivo(inususcrip);
      FETCH cuProductGasActivo
        INTO nuProduct_id;
      CLOSE cuProductGasActivo;

      if ((nuProduct_id = 0) or (nuProduct_id is null)) then
        OPEN cuProductsActivo(inususcrip);
        FETCH cuProductsActivo
          INTO nuProduct_id;
        CLOSE cuProductsActivo;
      end if;

      return nuProduct_id;

    EXCEPTION
      when no_data_found then
        return 0;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    end GetFirstProduct;

  BEGIN

    UT_TRACE.TRACE('INICIO LDC_PKCRMFINANCIACION.PRFINANCIARDUPLICADOPB',
                   10);

    -- CA. 200-904: NO se requiere consultar nuevamente la informacion del cupon
    /*OPEN CU_LD_CUPON_CAUSAL;
    FETCH CU_LD_CUPON_CAUSAL
      INTO TEMPCU_LD_CUPON_CAUSAL;
    CLOSE CU_LD_CUPON_CAUSAL; */

    --codigo cupon
    --nuCupon     := TEMPCU_LD_CUPON_CAUSAL.CUPONUME;
    nuCupon := to_number(fsbGetData(1, isbId, '-'));
    -- codigo solicitud
    nuPackage := to_number(fsbGetData(2, isbId, '-'));
    --codigo contrato
    nuSuscripc := pktblcupon.fnugetcuposusc(nuCupon);
    --codigo del primer prodcuto. Funcion obtendia del TRIGGER de la tabla LD_CUPON_CAUSAL
    nuProduct := GetFirstProduct(nuSuscripc);

    ---actualiza el codigo del prodcuto al motivo de la socliitud si no tiene el codigo del prodcuto

    update mo_motive mm
       set mm.product_id = nuProduct
     where mm.package_id = nuPackage --TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID
       and mm.product_id is null;

    if fblaplicaentrega(SBCRM_SC_JLV_2001948) = FALSE then
      -- CA 200-904: Proceso Actualizar Cargo
      update open.cargos
         set cargdoso = 'PP-' || nuPackage
       where cargnuse = nuProduct
         and cargcuco = -1
         and cargdoso = 'PP-0'
         and cargconc = 24;
    end if;

    dbms_output.put_line('**************** Financiacion inicio con exito');
    ut_trace.trace('**************** Financiacion inicio con exito');

    dbms_output.put_line('**************** SOLICITUD [' || nuPackage || ']');
    --TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID || ']');
    ut_trace.trace('**************** SOLICITUD [' || nuPackage || ']');
    --TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID || ']');

    UT_TRACE.TRACE('**************** CC_BOREQUESTRATING.REQUESTRATINGBYFGCA',
                   10);
    dbms_output.put_line('**************** CC_BOREQUESTRATING.REQUESTRATINGBYFGCA');

    -- Liquidar Solicitud
    CC_BOREQUESTRATING.REQUESTRATINGBYFGCA(nuPackage); --TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID);

    ut_trace.trace('**************** CC_BOACCOUNTS.GENERATEACCOUNTBYPACK',
                   10);
    dbms_output.put_line('-- Uso del servicio CC_BOACCOUNTS.GENERATEACCOUNTBYPACK');

    -- Generar Factura para la Solicitud
    CC_BOACCOUNTS.GENERATEACCOUNTBYPACK(nuPackage); --TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID);

    --Actualiza los campos CC_SALES_FINANC_COND
    ut_trace.trace('-- Actualiza los campos CC_SALES_FINANC_COND', 10);
    dbms_output.put_line('-- Actualiza los campos CC_SALES_FINANC_COND');

    rcSalesFinanCond.package_id         := nuPackage; --TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID; -- Solicitud
    rcSalesFinanCond.financing_plan_id  := NUCOD_PLA_FIN_SOL_EST_CUE; -- Plan de financiaci?n
    rcSalesFinanCond.compute_method_id  := pktblplandife.fnugetpaymentmethod(NUCOD_PLA_FIN_SOL_EST_CUE); -- M?todo financiaci?n
    rcSalesFinanCond.interest_rate_id   := pktblplandife.fnugetinterestratecod(NUCOD_PLA_FIN_SOL_EST_CUE); -- Inter?s
    rcSalesFinanCond.first_pay_date     := sysdate;
    rcSalesFinanCond.percent_to_finance := 100;
    rcSalesFinanCond.interest_percent   := 0;
    rcSalesFinanCond.spread             := 0;
    rcSalesFinanCond.quotas_number      := 1; -- N?mero de cuotas
    rcSalesFinanCond.tax_financing_one  := 'N';
    rcSalesFinanCond.value_to_finance   := 0;
    rcSalesFinanCond.document_support   := 'PP-' || nuPackage;
    --TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID;
    rcSalesFinanCond.initial_payment     := 0;
    rcSalesFinanCond.average_quote_value := 0;

    -- Insertar datos
    ut_trace.trace('**************** DACC_Sales_Financ_Cond.insrecord', 10);
    dbms_output.put_line('**************** DACC_Sales_Financ_Cond.insrecord');

    DACC_Sales_Financ_Cond.insrecord(rcSalesFinanCond);

    ut_trace.trace('**************** CC_BOFINANCING.FINANCINGORDER', 10);
    dbms_output.put_line('**************** CC_BOFINANCING.FINANCINGORDER');

    --Inicio Logica SAO 386766
    /* Actualizar Flag ACTIVE antes de la financiaci?n */
    Begin
      UPDATE mo_motive_payment mp
         SET mp.active = 'N'
       WHERE mp.package_payment_id = (SELECT pp.package_payment_id
                                        FROM mo_package_payment pp
                                       WHERE pp.package_id = nuPackage --TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID
                                      )
         AND mp.coupon_id = nuCupon;
      commit;
    end;
    --Fin Logica SAO 386766

    -- Financiaci?n de Solicitud
    CC_BOFINANCING.FINANCINGORDER(nuPackage); --TEMPCU_LD_CUPON_CAUSAL.PACKAGE_ID);

    if fblaplicaentrega(SBCRM_SC_JLV_2001948) = FALSE then
      -- CA 200-904: Proceso Actualizar ld_cupon_causal
      begin
        update open.ld_cupon_causal
           set package_id = nuPackage
         where cuponume = nuCupon
           and package_id = 0;
        commit;
      exception
        when others then
          ut_trace.trace('Error Actualiza Tabla LD_CUPON_CAUSAL', 10);
          null;
      end;
    end if;

    dbms_output.put_line('**************** Financiacion termino con exito');
    ut_trace.trace('**************** Financiacion termino con exito)', 10);

    --COMMIT;

    UT_TRACE.TRACE('FIN LDC_PKCRMFINANCIACION.PRFINANCIARDUPLICADOPB', 10);

  EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
      Errors.getError(ONUERRORCODE, OSBERRORMESSAGE);
      dbms_output.put_line('ONUERRORCODE[' || ONUERRORCODE ||
                           '] - OSBERRORMESSAGE[' || OSBERRORMESSAGE || ']');
      ut_trace.trace('-- Financiacion termino con errores - Codigo[' ||
                     ONUERRORCODE || '] - Mensaje[' || OSBERRORMESSAGE || ']',
                     10);
      rollback;
    when others then
      Errors.getError(ONUERRORCODE, OSBERRORMESSAGE);
      dbms_output.put_line('ONUERRORCODE[' || ONUERRORCODE ||
                           '] - OSBERRORMESSAGE[' || OSBERRORMESSAGE || ']');
      ut_trace.trace('-- Financiacion termino con errores - Codigo[' ||
                     ONUERRORCODE || '] - Mensaje[' || OSBERRORMESSAGE || ']',
                     10);
      rollback;

  END PRFINANCIARDUPLICADOPB;

END LDC_PKCRMFINANCIACION;
/
