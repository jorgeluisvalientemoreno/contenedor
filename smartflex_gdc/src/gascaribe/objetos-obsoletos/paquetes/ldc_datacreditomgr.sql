CREATE OR REPLACE PACKAGE LDC_DATACREDITOMGR
IS
/*****************************************************************
Package	: LDC_DATACREDITOMGR
Descripcion : Paquete para la generacion de muestras
                aleatorias y reportes maestros para
                Datacredito

Autor	: Manuel Mejia
Fecha	: 22-05-2017

Historia de Modificaciones
Fecha	    IDEntrega               Descripción
==========  ====================  ============================================
22-05-2017  Mmejia       Creación
******************************************************************/

    -------------------
    --Types
    -------------------
    TYPE tyrcProductInfo IS RECORD(
                                    ident_type_id ge_subscriber.ident_type_id%TYPE,
                                    identification ge_subscriber.identification%TYPE,
                                    account_number VARCHAR2(18)
                                  );

    TYPE tytbProductInfo IS TABLE OF tyrcProductInfo INDEX BY VARCHAR2(45);
    tbProductInfo tytbProductInfo;
    sbIndexProdInfo VARCHAR2(45);

    FUNCTION fsbVersion RETURN VARCHAR2;

    /*****************************************************************
    Metodo      :  GenerateSampleData
    Descripcion	:  Metodo inicial para creacion de muestras aleatorias
                    y reportes maestros

    Autor       : Manuel Mejia
    Fecha       : 22-05-2017
    ******************************************************************/
    PROCEDURE GenerateSampleData(inuCreditBureauId  IN ld_credit_bureau.credit_bureau_id%TYPE,
                                 inuSectorTypeId    IN ld_type_sector.type_id%TYPE,
                                 isbExecutableName  IN sa_executable.name%TYPE,
                                 idtFechCierr       IN DATE
                                );

    /*****************************************************************
    Metodo      :  GenSampleDetailRecords
    Descripcion	:  Genera registros de reporte para los productos de los clientes
                    que cumplan con las condiciones dadas.

    Autor       : Manuel Mejia
    Fecha       : 22-05-2017
    Parametros
                isbProgramName:     Identificador del programa ejecutado en ESTAPROG
                inuFatherId:        identificador del registro en LD_SAMPLE o LD_RANDOM_SAMPLE
                                        dependiendo del proceso ejecutado
                inuCreditBureauId:  Central de riesgo procesada.
                inuSectorTypeId:    Sector procesado.
                onuNoveltySum:      sumatoria de campo novedad para todos los registros inserados

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    22-05-2017   Mmejia        Creación
    ******************************************************************/
    PROCEDURE GenSampleDetailRecords(inuCicoAno         IN LDC_OSF_SESUCIER.nuano%TYPE,
                                     inuCicoMes         IN LDC_OSF_SESUCIER.numes%TYPE,
                                     isbProgramName     IN estaprog.esprprog%TYPE,
                                     inuFatherId        IN ld_sample.sample_id%TYPE,
                                     inuProductId       IN pr_product.product_id%TYPE,
                                     inuCreditBureauId  IN ld_credit_bureau.credit_bureau_id%TYPE,
                                     inuSectorTypeId    IN ld_type_sector.type_id%Type,
                                     inuTotalRecords    IN OUT NUMBER,
                                     idtFechCierr       IN DATE,
                                     boForceInsert      IN BOOLEAN,
                                     onuNoveltySum      OUT ld_sample_fin.sum_of_new%TYPE
                                     );

    /*****************************************************************
    Metodo      :  ReCalculateENDRecord
    Descripcion	:  Recalcula los datos de fin para muestra  reporte
                    maestro.

    Autor       : Manuel Mejia
    Fecha       : 22-05-2017
    Parametros
                inuFatherId:        identificador del registro en LD_SAMPLE o LD_RANDOM_SAMPLE
                                        dependiendo del proceso ejecutado

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    22-05-2017   Mmejia        Creación
    ******************************************************************/
    PROCEDURE ReCalculateENDRecord(
                                inuFatherId IN ld_random_sample.random_sample_id%TYPE
                                );

    /*****************************************************************
    Propiedad intelectual de REDI. (c).

    Procedure	: FrFGetCreditDetaiBySubscriber
    Descripción	: Obtener datos de reporte centrales

    Parámetros	:	Descripción

    Retorno     :

    Autor	: Manuel Mejia
    Fecha	: 24-06-2017

    Historia de Modificaciones
    Fecha       Autor
    ----------  --------------------
    24-06-2017  Mmejia
    Creación.
    *****************************************************************/
    FUNCTION FrFGetCreditDetaiBySubscriber
    RETURN CONSTANTS.TYREFCURSOR;

END LDC_DATACREDITOMGR;
/
CREATE OR REPLACE PACKAGE BODY LDC_DATACREDITOMGR
IS
/*****************************************************************
Package	: LDC_DATACREDITOMGR
Descripcion : Paquete para la generacion de muestras
                aleatorias y reportes maestros para
                Datacredito

Autor	: Manuel Mejia
Fecha	: 22-05-2017

Historia de Modificaciones
Fecha	    IDEntrega               Descripción
==========  ====================  ============================================
22-05-2017  Mmejia       Creación
******************************************************************/
    --------------------------------------------
    -- Constantes
    --------------------------------------------
    csbVersion                CONSTANT VARCHAR2(250)  := 'SAS200-1112';
    csbReportExecName         CONSTANT sa_executable.name%type := 'FGRCG';
    cnuDatacredCreditBureau   CONSTANT ld_credit_bureau.credit_bureau_id%type := 1;--DATACREDITO
    cnuMinValReportMora       CONSTANT NUMBER :=1000;
    gsbMessage                ge_error_log.description%TYPE;
    csbDateIniDataCredito     LD_PARAMETER.VALUE_CHAIN%TYPE := DALD_PARAMETER.FSBGETVALUE_CHAIN('DATE_INI_REPDATACREDITO', 0);

    --------------------------------------------
    -- Cursores
    --------------------------------------------
    -- Obtener equivalencia del tipo de identificacion Smartflex/Datacredito
    CURSOR cuGetIdentTypeEq(inuIdentTypeId ge_subscriber.ident_type_id%type) IS
        SELECT  type_identificacion_id
        FROM    LD_TYPE_IDENTIFICAT_DC
        WHERE   type_identification_equi = inuIdentTypeId
        AND     ROWNUM = 1;

    -- Obtener fecha de inicio de la obligaci�n
    CURSOR cuGetInitDebtDate(inuDifecofi DIFERIDO.difecofi%TYPE) IS
        SELECT difefein
        FROM (
                SELECT difefein
                FROM DIFERIDO
                WHERE difecofi = inuDifecofi
                ORDER BY difefein ASC
             )
        WHERE rownum = 1;

    -- Obtiene el valor de la cuota
    CURSOR cuGetDefMonthlyValue(inuDifecofi DIFERIDO.difecofi%TYPE) IS
        SELECT nvl(sum(difevacu), 0) difevacu
        FROM diferido
        WHERE difecofi = inuDifecofi;
        ---AND difesape > 0;

    -- Cursor que Obtiene el total de cuotas pactadas
    CURSOR cuGetDefTotalShares(inuDifecofi DIFERIDO.difecofi%TYPE) IS
        SELECT Nvl(Max(difenucu), 0) difenucu
        FROM diferido
        WHERE difecofi = inuDifecofi;
        ---AND difesape > 0;

    -- Obtiene la fecha de fin estimada del diferido
    CURSOR cuGetEndDebDate(inuDifecofi DIFERIDO.difecofi%TYPE) IS
        SELECT *
        FROM (
            SELECT Add_Months(difefein, difenucu) dueDate
            FROM diferido
            WHERE difecofi = inuDifecofi
            ---AND diferido.difesape > 0
            ORDER BY Add_Months(difefein, difenucu) DESC
        )
        WHERE rownum = 1;

    /*
    Obtiene la fecha de pago y la fecha de vencimiento de la
    ultima cuota de un diferido .Busqueda historica entre todos
    los diferidos, no importa si no tienen saldo pendiente
    */
    CURSOR cuGetLastChrgPayHist(inuDifecofi DIFERIDO.difecofi%TYPE) IS
        SELECT *
        FROM (
            SELECT  cuencobr.cucofepa, cuencobr.cucofeve
            FROM    diferido, cargos, cuencobr
            WHERE   diferido.difecofi = inuDifecofi
            AND     cargos.cargdoso = 'DF-'||diferido.difecodi
            AND     cargos.cargcuco = cuencobr.cucocodi
            ORDER BY cuencobr.cucofepa desc,cuencobr.cucofeve desc
        )
        WHERE ROWNUM = 1;

    /*
    Obtiene la fecha de pago y la fecha de vencimiento entre los
    diferidos activos (con saldo pendiente)
    */
    CURSOR cuGetLastChrgPay(inuDifecofi DIFERIDO.difecofi%TYPE) IS
        SELECT *
        FROM (
            SELECT  cuencobr.cucofepa, cuencobr.cucofeve
            FROM    diferido, cargos, cuencobr
            WHERE   diferido.difecofi = inuDifecofi
            ----AND     diferido.difesape > 0
            AND     cargos.cargdoso = 'DF-'||diferido.difecodi
            AND     cargos.cargcuco = cuencobr.cucocodi
            ORDER BY cuencobr.cucofepa desc,cuencobr.cucofeve desc
        )
        WHERE ROWNUM = 1;

    --22-05-2017
    --SAS200-1112
    --Mmejia
    --Se modifica el cursor para que redonde los valores de mora
    --mayores a cero y menores a mil pesos
    -- Obtiene informacion de mora del dierido (Valor en mora, facturas vencidas, fecha de inicio de mora)
    -- de las cuentas de cocbro con saldo con fecha de vencimiento mayor a valor del parametro
    CURSOR cuGetArrearInfo(inuProductId servsusc.sesunuse%TYPE,
                           inuDifecofi DIFERIDO.difecofi%TYPE,
                           nuDATACREDITOEdadMora NUMBER
                           ) IS
        SELECT
        CASE
          WHEN valor > 0  AND valor < cnuMinValReportMora THEN
              cnuMinValReportMora
          ELSE
            valor
        END VALOR,
        TOTAL,
        CUCOFEVE
        FROM
        (
        SELECT
        Nvl(Sum(cargos.cargvalo),0) valor,
        --Nvl(Sum(cucosacu),0) valor,
        Count(DISTINCT(factpefa)) total,
        Min(cucofeve) cucofeve
        FROM cuencobr, factura,cargos,diferido
        WHERE cucofact = factcodi
        AND cuconuse = inuProductId
        AND Nvl(cucosacu, 0) > 0
        AND cargos.cargcuco = cuencobr.cucocodi
        AND cucofeve < SYSDATE
        AND factfege < SYSDATE
        AND DIFERIDO.difecofi = inuDifecofi
        AND (cargos.cargdoso = 'DF-'||DIFERIDO.difecodi
            OR cargos.cargdoso = 'ID-'||DIFERIDO.difecodi)
        AND cargos.cargsign = 'DB'
        AND Ceil(SYSDATE - cucofeve) >= nuDATACREDITOEdadMora
        );


    -- Obtiene el saldo diferido y corriente de un producto
    CURSOR cuGetPortfolioBalance (inuProductId servsusc.sesunuse%TYPE,
                                  inuDifecofi DIFERIDO.difecofi%TYPE) IS
        SELECT difesape_sum, saldo_sum
        FROM(
                SELECT Nvl(Sum(difesape), 0) difesape_sum
                FROM diferido
                WHERE difecofi = inuDifecofi
            ) dif,
            (
                SELECT Sum(cargos.cargvalo) saldo_sum
                --Nvl(Sum(Nvl(cucosacu, 0) + nvl(cucovare, 0) + nvl(cucovrap, 0)), 0) saldo_sum
                FROM cuencobr,cargos,diferido
                WHERE cuconuse = inuProductId
                AND DIFERIDO.difecofi = inuDifecofi
                AND (cargos.cargdoso = 'DF-'||DIFERIDO.difecodi
                    OR cargos.cargdoso = 'ID-'||DIFERIDO.difecodi)
                AND cargos.cargsign = 'DB'
                AND cargos.cargcuco = cuencobr.cucocodi
                AND cuencobr.cucosacu > 0
            ) cuenc;

    CURSOR cuGetPenaltyExcDate(inuProductId servsusc.sesunuse%type) IS
        SELECT cargfecr
        FROM (
                SELECT *
                FROM cargos
                WHERE cargnuse = inuProductId
                AND cargcaca = 58
                ORDER BY cargfecr
        )
        WHERE rownum = 1
        AND EXISTS (
                    SELECT  *
                    FROM    GC_PRODPRCA
                    WHERE   prpcnuse = inuProductId
                    AND     prpcsaca = prpcsare
                   );

    -- Obtiene el id del cliente
    CURSOR cuGetSubsInfo(inuProductId pr_product.product_id%type) IS
        SELECT ge_subscriber.subscriber_id, ge_subscriber.e_mail
        FROM pr_product, suscripc, ge_subscriber
        WHERE pr_product.subscription_id = suscripc.susccodi
        AND suscripc.suscclie = ge_subscriber.subscriber_id
        AND pr_product.product_id = inuProductId;

    -- obtiene el nombre de la ciudad de un cliente
    CURSOR cuGetAddressInfo(inuSubscriberId ge_subscriber.subscriber_id%type) IS
        SELECT ge_geogra_location.display_description, ab_address.address
        FROM ge_subscriber, ab_address, ge_geogra_location
        WHERE ge_subscriber.address_id = ab_address.address_id
        AND ab_address.geograp_location_id = ge_geogra_location.geograp_location_id
        AND subscriber_id = inuSubscriberId;

    CURSOR cuGetPhone(inuSubscriberId ge_subscriber.subscriber_id%type, isbNumberType VARCHAR2) IS
        SELECT phone
        FROM (
                SELECT phone
                FROM ge_subs_phone
                WHERE ge_subs_phone.phone_type_id in (SELECT column_value
                                                            FROM TABLE(ldc_boutilities.SPLITstrings(isbNumberType,','))
                                                      )
                AND ge_subs_phone.subscriber_id = inuSubscriberId
                ORDER BY ge_subs_phone.subs_phone_id desc
             )
        WHERE ROWNUM = 1;

    --<<
    --22-05-2017
    --SAS200-1112
    --Mmejia
    --Se modifica el cursor para que cuenta el numero de cuotas en cuntas
    --de cobro sin saldo, luego sume estas cuotas y tome el maximo de
    --todos los diferidos
    -->>
    CURSOR cuGetMontlyPaids(inuProductId servsusc.sesunuse%TYPE,
                            inuDifecofi DIFERIDO.difecofi%TYPE
                            ) IS
        SELECT Nvl(Max(cuotas),0) FROM (
      SELECT Sum(cuotas) cuotas,difecofi
            FROM (
                    SELECT  DISTINCT diferido.difecofi,
                            cuencobr.cucocodi,
                            1 cuotas
                    FROM    diferido, cargos, cuencobr
                    WHERE   cargos.cargdoso = 'DF-'||diferido.difecodi
                    AND     cargos.cargcuco = cuencobr.cucocodi
                    AND     diferido.difecofi = inuDifecofi
                    AND     cargos.cargnuse = inuProductId
                    AND     Nvl(cuencobr.cucosacu, 0) = 0
                    AND     cuencobr.cucovato > 0
                    AND     cargos.cargcaca NOT IN(50)
                    ---AND     diferido.difesape >0
                    GROUP BY diferido.difecofi,cuencobr.cucocodi
                )GROUP BY difecofi
                );

    --<<
    --22-05-2017
    --SAS200-1112
    --Mmejia
    ----Cursor que obtiene el total de cuotas generadas
    -->>
    CURSOR cuGetMontlyGen(inuProductId servsusc.sesunuse%TYPE,inuDifecofi DIFERIDO.difecofi%TYPE) IS
    SELECT Nvl(Max(cuotas),0) FROM (
      SELECT Sum(cuotas) cuotas,difecodi
            FROM (
                    SELECT  DISTINCT diferido.difecodi,
                            cuencobr.cucocodi,
                            1 cuotas
                    FROM    diferido, cargos, cuencobr
                    WHERE   cargos.cargdoso = 'DF-'||diferido.difecodi
                    AND     cargos.cargcuco = cuencobr.cucocodi
                    AND     diferido.difecofi = inuDifecofi
                    AND     cargos.cargnuse = inuProductId
                    AND     cuencobr.cucovato > 0
                    ---AND     diferido.difesape >0
                    GROUP BY diferido.difecodi,cuencobr.cucocodi
                )GROUP BY difecodi
                );

    CURSOR cuGetAllocatedQuota(inuDifecofi DIFERIDO.difecofi%TYPE) IS
        SELECT Sum(DIFERIDO.DIFEVATD)
        FROM   diferido
        WHERE  difecofi = inuDifecofi;

    CURSOR cuCuentSaldo(inuProductId servsusc.sesunuse%TYPE)
    IS
    SELECT Count(DISTINCT(CUCOFACT)) cantidad
         FROM   cuencobr
         WHERE  (NVL(cucosacu,0) + NVL(cucovare,0) + NVL(cucovrap,0)) > 0
         AND CUCONUSE = inuProductId;

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
      RETURN csbVersion;
    END;

    /*****************************************************************
    Metodo      :  raiseError
    Descripcion	:  Eleva error controlado y actualiza el registro de ESTAPROG
                    como finalizado con error

    Autor       : Manuel Mejia
    Fecha       : 22-05-2017
    Parametros
                isbPrgName:         Identificador del programa ejecutado en ESTAPROG
                sbErrMsg:           Mensaje de error.

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    22-05-2017   Mmejia        Creación
    ******************************************************************/
    PROCEDURE raiseError(isbPrgName IN estaprog.esprprog%type,
                            sbErrMsg IN ge_error_log.description%type)
    IS
    BEGIN
      ut_trace.trace('INICIA LDC_DATACREDITOMGR.GenerateControlRecord.raiseError', 10);
      Pkstatusexeprogrammgr.Processfinishnok(isbPrgName, sbErrMsg);
      Pkgeneralservices.Committransaction;

      errors.seterror(Ld_Boconstans.cnuGeneric_Error, sbErrMsg);
      RAISE ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Metodo      :  GenerateControlRecord
    Descripcion	:  Crea registro de control para muestra aleatoria o reporte

    Autor       : Manuel Mejia
    Fecha       : 22-05-2017
    Parametros
                isbProgramName:     Identificador del programa ejecutado en ESTAPROG
                inuFatherId:        identificador del registro en LD_SAMPLE o LD_RANDOM_SAMPLE
                                        dependiendo del proceso ejecutado
                inuCreditBureauId:  Central de riesgo procesada.
                inuSectorTypeId:    Sector procesado.

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    22-05-2017   Mmejia        Creación
    ******************************************************************/
    PROCEDURE GenerateControlRecord(isbProgramName IN estaprog.esprprog%type,
                                    inuFatherId IN ld_random_sample.random_sample_id%type,
                                    inuCreditBureauId IN ld_credit_bureau.credit_bureau_id%Type,
                                    inuSectorTypeId  IN ld_type_sector.type_id%Type)
    IS
        sbInitialRecordIdent    ld_random_sample_cont.initial_record_identifier%type;
        nuDatacredSuscCode      ld_random_sample_cont.code_of_subscriber%type;
        nuAccountType           ld_random_sample_cont.type_account%type;
        sbFourDigitYearFormat   ld_random_sample_cont.enlargement_goals%type;
        sbThousandIndicator     ld_random_sample_cont.indicator_values_in_mil%type;
        sbDeliveryType          ld_random_sample_cont.type_of_delivery%type;
        sbSplitIndicator        ld_random_sample_cont.indicator_from%type;
        sbFiller                ld_random_sample_cont.filler%type;

        sbErrorMsg              ge_error_log.description%type;

        nuDummy                 ld_general_parameters.numercial_value%type;
        sbDummy                 ld_general_parameters.text_value%type;

        rcSampleCont            dald_sample_cont.styLD_SAMPLE_CONT;

        CURSOR cuGetCurrentDate IS
            SELECT TO_CHAR(sysdate, 'YYYYMMDD')
            FROM dual;

    BEGIN
        ut_trace.trace('INICIA LDC_DATACREDITOMGR.GenerateControlRecord', 10);

        /*Bloque de obtencion de parametros*/
        provapatapa('INITIAL_RECORD_IDENTIFIER', 'S', nuDummy, sbInitialRecordIdent);

        IF(sbInitialRecordIdent IS NULL) THEN
            raiseError(isbProgramName, 'Parametro INITIAL_RECORD_IDENTIFIER esta vacio');
        END IF;

        provapatapa('CODIGO_DATACREDITO', 'N', nuDatacredSuscCode, sbDummy);

        IF(nuDatacredSuscCode IS NULL) THEN
            raiseError(isbProgramName, 'Parametro CODIGO_DATACREDITO esta vacio');
        END IF;

        provapatapa('TYPE_ACCOUNT', 'N', nuAccountType, sbDummy);

        IF(nuAccountType IS NULL) THEN
            raiseError(isbProgramName, 'Parametro TYPE_ACCOUNT esta vacio');
        END IF;

        provapatapa('ENLARGEMENT_GOALS', 'S', nuDummy, sbFourDigitYearFormat);

        IF(sbFourDigitYearFormat IS NULL) THEN
            raiseError(isbProgramName, 'Parametro ENLARGEMENT_GOALS esta vacio');
        END IF;

        provapatapa('INDICATOR_VALUES_IN_MIL', 'S', nuDummy, sbThousandIndicator);

        IF(sbThousandIndicator IS NULL) THEN
            raiseError(isbProgramName, 'Parametro INDICATOR_VALUES_IN_MIL esta vacio');
        END IF;

        provapatapa('TYPE_OF_DELIVERY', 'S', nuDummy, sbDeliveryType);

        IF(sbDeliveryType IS NULL) THEN
            raiseError(isbProgramName, 'Parametro TYPE_OF_DELIVERY esta vacio');
        END IF;

        provapatapa('INDICATOR_FROM', 'S', nuDummy, sbSplitIndicator);

        IF(sbSplitIndicator IS NULL) THEN
            raiseError(isbProgramName, 'Parametro INDICATOR_FROM esta vacio');
        END IF;

        provapatapa('FILLER', 'S', nuDummy, sbFiller);

        IF(sbFiller IS NULL) THEN
            raiseError(isbProgramName, 'Parametro FILLER esta vacio');
        END IF;

        IF (isbProgramName like(csbReportExecName||'%')) THEN
            rcSampleCont.id_sample_cont := seq_ld_sample_cont.nextval;
            rcSampleCont.sample_id := inuFatherId;
            rcSampleCont.initial_record_identifier := sbInitialRecordIdent;
            rcSampleCont.code_of_subscriber := nuDatacredSuscCode;
            rcSampleCont.type_account := nuAccountType;
            rcSampleCont.statement_date := sysdate;
            rcSampleCont.enlargement_goals := sbFourDigitYearFormat;
            rcSampleCont.indicator_values_in_mil := sbThousandIndicator;
            rcSampleCont.type_of_delivery := sbDeliveryType;
            rcSampleCont.indicator_from := sbSplitIndicator;
            rcSampleCont.filler := sbFiller;
            rcSampleCont.credit_bureau := inuCreditBureauId;
            rcSampleCont.sector_type := inuSectorTypeId;
            rcSampleCont.product_type_id := -1;

            dald_sample_cont.insRecord(rcSampleCont);

        END IF;

        Pkgeneralservices.Committransaction;
        ut_trace.trace('FIN LDC_DATACREDITOMGR.GenerateControlRecord', 10);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END GenerateControlRecord;

    /*****************************************************************
    Metodo      :  GenSampleDetailRecords
    Descripcion	:  Genera registros de reporte para los productos de los clientes
                    que cumplan con las condiciones dadas.

    Autor       : Manuel Mejia
    Fecha       : 22-05-2017
    Parametros
                isbProgramName:     Identificador del programa ejecutado en ESTAPROG
                inuFatherId:        identificador del registro en LD_SAMPLE o LD_RANDOM_SAMPLE
                                        dependiendo del proceso ejecutado
                inuCreditBureauId:  Central de riesgo procesada.
                inuSectorTypeId:    Sector procesado.
                onuNoveltySum:      sumatoria de campo novedad para todos los registros inserados

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    22-05-2017   Mmejia        Creación
    ******************************************************************/
    PROCEDURE GenSampleDetailRecords(inuCicoAno         IN LDC_OSF_SESUCIER.nuano%TYPE,
                                     inuCicoMes         IN LDC_OSF_SESUCIER.numes%TYPE,
                                     isbProgramName     IN estaprog.esprprog%TYPE,
                                     inuFatherId        IN ld_sample.sample_id%TYPE,
                                     inuProductId       IN pr_product.product_id%TYPE,
                                     inuCreditBureauId  IN ld_credit_bureau.credit_bureau_id%TYPE,
                                     inuSectorTypeId    IN ld_type_sector.type_id%Type,
                                     inuTotalRecords    IN OUT NUMBER,
                                     idtFechCierr       IN DATE,
                                     boForceInsert      IN BOOLEAN,
                                     onuNoveltySum      OUT ld_sample_fin.sum_of_new%TYPE
                                     ) IS

        nuProcessedRecords      NUMBER(20) := 0;
        nuArrearBalance         NUMBER := 0;
        nuCuentasSaldo          NUMBER := 0;
        nuOverdueBills          NUMBER := 0;
        nuMoraAge               NUMBER :=0;
        dtArrearInitDate        cuencobr.cucofeve%type;
        dtDate                  DATE;
        dtDuedate               cuencobr.cucofeve%type;
        dtPaymentDate           cuencobr.cucofepa%type;
        nuDeferrredBalance      diferido.difesape%type;
        nuCurrentBalance        cuencobr.cucosacu%type;
        nuSusbcriberId          ge_subscriber.subscriber_id%type;
        nuSubsMail              ge_subscriber.e_mail%type;
        sbCity                  ge_geogra_location.display_description%type;
        sbAddress               ab_address.address%type;
        nuAprobValue            NUMBER := 0;
        nuSharesCanceled        NUMBER := 0;
        nuMonthlyValue          NUMBER := 0;
        nuTotalShares           NUMBER := 0;
        nuMontlyGen             NUMBER;
        dtPenaltyExcDate        cargos.cargfecr%type;
        nuVDPosition            NUMBER;
        sbAccountNumber         VARCHAR2(50);
        v_num_identifica        ld_sample_detai.identification_number%Type;--sucursal
        boValProdDupli          BOOLEAN;
        boValProd               BOOLEAN;--Valida si el producto lo procesa

        rcSampleDetail          dald_sample_detai.styLD_SAMPLE_DETAI;

        sbDATACREDITODepart     ld_general_parameters.text_value%TYPE;
        sbDATACREDITOLocal      ld_general_parameters.text_value%TYPE;
        sbDATACREDITOCycle      ld_general_parameters.text_value%TYPE;
        sbDATACREDITOCate       ld_general_parameters.text_value%TYPE;
        sbDATACREDITOSubCate    ld_general_parameters.text_value%TYPE;

        sbDATACREDITOEdadMora   ld_general_parameters.text_value%TYPE;
        sbDATACREDITOCuentSaldo ld_general_parameters.text_value%TYPE;

        sbDummyValue            ld_general_parameters.text_value%TYPE;
        nuDummyValue            ld_general_parameters.numercial_value%TYPE;
        ocuCursor               CONSTANTS.TYREFCURSOR;
        rcProductPerSusc        LDC_BCDATACREDITO.cuGetProdsPerSusc%ROWTYPE ;
        nuTotalRecords          NUMBER :=0;
    BEGIN
        ut_trace.trace('INICIA LDC_DATACREDITOMGR.GenSampleDetailRecords', 10);

        ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords isbprogramname '||isbprogramname, 10);
        ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords inuFatherId '||inuFatherId, 10);
        ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords inuProductId '||inuProductId, 10);
        ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords inuCreditBureauId '||inuCreditBureauId, 10);
        ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords inuSectorTypeId '||inuSectorTypeId, 10);
        ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords inuTotalRecords '||inuTotalRecords, 10);
        ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords onuNoveltySum '||onuNoveltySum, 10);

        -- se inicializa la sumatoria del campo 15.NOVEDAD
        onuNoveltySum := 0;

        -- se busca el parametro DEPARTAMENTO a procesar
        provapatapa('DATACREDITO_DEPART', 'S', nuDummyValue, sbDATACREDITODepart);

        -- se busca el parametro LOCALIDAD a procesar
        provapatapa('DATACREDITO_LOCAL', 'S', nuDummyValue, sbDATACREDITOLocal);

        -- se busca el parametro ciclos a procesar
        provapatapa('DATACREDITO_CYCLE', 'S', nuDummyValue, sbDATACREDITOCycle);

        -- se busca el parametro categorias a procesar
        provapatapa('DATACREDITO_CATE', 'S', nuDummyValue, sbDATACREDITOCate);

        -- se busca el parametro SUBCATEGORIA a procesar
        provapatapa('DATACREDITO_SUBCATE', 'S', nuDummyValue, sbDATACREDITOSubCate);

        -- se busca el parametro Edad de mora a procesar
        provapatapa('DATACREDITO_EDADMORA', 'S', nuDummyValue, sbDATACREDITOEdadMora);

        -- se busca el parametro cuentas con saldo a procesar
        provapatapa('DATACREDITO_CUENSALDO', 'S', nuDummyValue, sbDATACREDITOCuentSaldo);

        ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords sbDATACREDITODepart '||sbDATACREDITODepart, 10);
        ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords sbDATACREDITOLocal '||sbDATACREDITOLocal, 10);
        ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords sbDATACREDITOCycle '||sbDATACREDITOCycle, 10);
        ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords sbDATACREDITOCate '||sbDATACREDITOCate, 10);
        ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords sbDATACREDITOSubCate '||sbDATACREDITOSubCate, 10);
        ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords sbDATACREDITOEdadMora '||sbDATACREDITOEdadMora, 10);
        ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords sbDATACREDITOCuentSaldo '||sbDATACREDITOCuentSaldo, 10);
        ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords csbDateIniDataCredito '||csbDateIniDataCredito, 10);

        --<<
        --Se valida si se forza a insertar el producto por lo general
        --este parametro es para usar la forma FCDCRG  cargaue de prouctos
        --por archivos planos
        -->>
        IF(boForceInsert)THEN
           sbDATACREDITODepart := '-1';
           sbDATACREDITOLocal := '-1';
           sbDATACREDITOCycle := '-1';
           sbDATACREDITOCate := '-1';
           sbDATACREDITOSubCate := '-1';
        END IF;

        --<<
        --Abre el cursor de los productos
        -->>
        LDC_BCDATACREDITO.GetProdsPerSusc(inuCicoAno,inuCicoMes,sbDATACREDITODepart,sbDATACREDITOLocal,sbDATACREDITOCycle,sbDATACREDITOCate,sbDATACREDITOSubCate,csbDateIniDataCredito,inuProductId,ocuCursor );

        LOOP
           FETCH ocuCursor INTO rcProductPerSusc;
            EXIT WHEN ocuCursor%NOTFOUND;
          --FOR rcProductPerSusc IN LDC_BCDATACREDITO.cuGetProdsPerSusc(sbDATACREDITOEstaFian,sbDATACREDITOCycle,sbDATACREDITOCate,csbDateIniDataCredito,inuProductId) LOOP

            ut_trace.trace('Cliente procesado: '||rcProductPerSusc.full_name||
                            ' tipo ident: '||rcProductPerSusc.ident_type_id||
                            ' identificacion: '||rcProductPerSusc.identification||
                            ' producto: '||rcProductPerSusc.product_id||
                            ' FINANCING_ID : '||rcProductPerSusc.FINANCING_ID||
                            ' estado financiero: '||rcProductPerSusc.sesuesfn||
                            ' tipo de reporte (D:Deudor/C:Codeudor) '||rcProductPerSusc.REPORT_TYPE||'.', 10);

            ut_trace.trace('INICIA EXTRACCION DE DATOS', 10);

            --Calculo de dias de la edad de mora
            --nuMoraAge := Ceil(SYSDATE-dtArrearInitDate);
            nuMoraAge := rcProductPerSusc.EDAD - sbDATACREDITOEdadMora;
            IF(nuMoraAge < 0)THEN
              nuMoraAge := 0;
            END IF;
            ut_trace.trace('nuMoraAge: '||nuMoraAge, 10);

            --Obtiene el tipo de identificacion
            OPEN cuGetIdentTypeEq(rcProductPerSusc.ident_type_id);
            FETCH cuGetIdentTypeEq INTO rcSampleDetail.type_identification_dc;
            CLOSE cuGetIdentTypeEq;
            ut_trace.Trace('LDC_DATACREDITOMGR.GenRandomSampDetRecords rcSampleDetail.type_identification_dc '||rcSampleDetail.type_identification_dc, 10);

            --Valida el numero de identificacion
            IF(rcProductPerSusc.ident_type_id = 110) THEN

                nuVDPosition := INSTR(rcProductPerSusc.identification, '-');
                --Se valida si tiene el caracter - para indetificar la posicion
                --del digito de verificacion
                IF(nuVDPosition > 0)  THEN
                    v_num_identifica := LPad(SubStr(rcProductPerSusc.identification, 0, nuVDPosition-1), 11, '0');
                ELSE
                    v_num_identifica := LPad(rcProductPerSusc.identification, 11, '0');
                END IF;
            ELSE
                v_num_identifica := LPad(rcProductPerSusc.identification, 11, '0');
            END IF;
            ut_trace.Trace('LDC_DATACREDITOMGR.GenRandomSampDetRecords v_num_identifica '||v_num_identifica, 10);

            --ACCOUNT_NUMBER
            --sbAccountNumber := 'P'||rcProductPerSusc.product_id;
            sbAccountNumber :=rcProductPerSusc.FINANCING_ID;

            --Valida que el codigo de producto sea -1
            IF(inuProductId < 0 )THEN
              --Se crea el index de la tabla  PL de duplicados
              sbIndexProdInfo := LPad(rcProductPerSusc.FINANCING_ID,15,'0')||LPAD(rcProductPerSusc.IDENT_TYPE_ID,4,'0')
                              ||LPad(rcProductPerSusc.IDENTIFICATION,20,'0');
            ELSE

                OPEN cuGetIdentTypeEq(rcProductPerSusc.ident_type_id);
                FETCH cuGetIdentTypeEq INTO rcSampleDetail.type_identification_dc;
                CLOSE cuGetIdentTypeEq;

                --Se valida el tipo de idntificacion NIT
                IF(rcProductPerSusc.ident_type_id = 110) THEN
                  nuVDPosition := INSTR(rcProductPerSusc.identification, '-');
                  --Se valida si tiene el caracter - para indetificar la posicion
                  --del digito de verificacion
                  IF(nuVDPosition > 0)  THEN
                      v_num_identifica := LPAD(SUBSTR(rcProductPerSusc.identification, 0, nuVDPosition-1), 11, '0');
                  ELSE
                      v_num_identifica := LPAD(rcProductPerSusc.identification, 11, '0');
                  END IF;
                ELSE
                  v_num_identifica := LPAD(rcProductPerSusc.identification, 11, '0');
                END IF;

              --Se crea el index de la tabla  PL de duplicados
              sbIndexProdInfo := LPad(sbAccountNumber,15,'0')||LPAD(rcSampleDetail.type_identification_dc,4,'0')
                              ||LPad(v_num_identifica,20,'0');
              ut_trace.Trace('LDC_DATACREDITOMGR.GenRandomSampDetRecords sbIndexProdInfo:'||sbIndexProdInfo, 10);
            END IF;

            boValProdDupli := FALSE;

            -- : Valida si previamente ya se han procesado registros para el producto
            IF(NOT LDC_DATACREDITOMGR.tbProductInfo.EXISTS(sbIndexProdInfo)) THEN
                ut_trace.Trace('LDC_DATACREDITOMGR.GenRandomSampDetRecords NO EXISTE ', 10);
                LDC_DATACREDITOMGR.tbProductInfo(sbIndexProdInfo).ident_type_id := rcProductPerSusc.ident_type_id;
                LDC_DATACREDITOMGR.tbProductInfo(sbIndexProdInfo).identification := rcProductPerSusc.identification;
            ELSE
                ut_trace.Trace('LDC_DATACREDITOMGR.GenRandomSampDetRecords EXISTE ', 10);
                boValProdDupli := TRUE;
            END IF;

            --Valida que no tenga registros duplicados
            IF(NOT boValProdDupli)THEN

              --Setea el registro en NULL
              rcSampleDetail := NULL;

              --Setea la variable para procesar el producto
              boValProd := TRUE;

              --Valida que el producto este en mora o castigado para calcula el valor de la mora
              ---tambien se agrega el estado D deuda al dia ya que este no cambia a  M Mora hasta que
              --se lance el proceso de suspensiones
              IF(rcProductPerSusc.sesuesfn = 'M' OR rcProductPerSusc.sesuesfn = 'C' OR rcProductPerSusc.sesuesfn = 'D') THEN

                    OPEN cuGetArrearInfo(rcProductPerSusc.PRODUCT_ID,rcProductPerSusc.FINANCING_ID,sbDATACREDITOEdadMora);
                    FETCH cuGetArrearInfo INTO nuArrearBalance, nuOverdueBills, dtArrearInitDate;
                    IF(cuGetArrearInfo%NOTFOUND)THEN
                       nuArrearBalance  := 0;
                       nuOverdueBills   := 0;
                       dtArrearInitDate :=SYSDATE;
                    END IF;
                    CLOSE cuGetArrearInfo;
                  ut_trace.Trace('LDC_DATACREDITOMGR.GenRandomSampDetRecords nuArrearBalance '||nuArrearBalance, 10);

                  ut_trace.Trace('LDC_DATACREDITOMGR.GenRandomSampDetRecords sbDATACREDITOEdadMora '||sbDATACREDITOEdadMora, 10);
                  ut_trace.Trace('LDC_DATACREDITOMGR.GenRandomSampDetRecords  Nvl(Ceil(SYSDATE-dtArrearInitDate),0) '||( Nvl(Ceil(SYSDATE-dtArrearInitDate),0)), 10);
                  ut_trace.Trace('LDC_DATACREDITOMGR.GenRandomSampDetRecords rcProductPerSusc.EDAD  '||rcProductPerSusc.EDAD, 10);

                  --Valida si el valor de mora es valido
                  IF(nuArrearBalance > 0  AND nuArrearBalance < cnuMinValReportMora --AND
                     --Nvl(Ceil(SYSDATE-dtArrearInitDate),0) < To_Number(sbDATACREDITOEdadMora) ---EDAD DE MORA
                     ---rcProductPerSusc.EDAD < To_Number(sbDATACREDITOEdadMora) ---EDAD DE MORA
                    )THEN
                     boValProd := FALSE;
                  END IF;

                  IF(boValProd)THEN
                    OPEN cuCuentSaldo(rcProductPerSusc.PRODUCT_ID);
                    FETCH cuCuentSaldo INTO nuCuentasSaldo;
                    CLOSE cuCuentSaldo;

                    --Valida que el producto cumple con el parametro de cuentas con saldo
                    IF(nuCuentasSaldo < To_Number(sbDATACREDITOCuentSaldo))THEN
                      boValProd := FALSE;
                    END IF;
                  END IF;

                  --Valida si el estado es deuda al dia D y tienen valor mora cambie a mora
                  IF(rcProductPerSusc.sesuesfn = 'D'  AND nuArrearBalance >0)THEN
                      rcProductPerSusc.sesuesfn := 'M';
                  ELSIF(nuArrearBalance =0 AND  (rcProductPerSusc.sesuesfn = 'D' OR rcProductPerSusc.sesuesfn = 'M' OR rcProductPerSusc.sesuesfn = 'C'))THEN
                      rcProductPerSusc.sesuesfn := 'A';
                  END IF;
              END IF;

              --Valida si procesa el producto
              IF(boValProd)THEN
                  --Calcula las cuotas canceladas
                  OPEN cuGetMontlyPaids(rcProductPerSusc.PRODUCT_ID,rcProductPerSusc.FINANCING_ID);
                  FETCH cuGetMontlyPaids INTO nuSharesCanceled;
                  IF(cuGetMontlyPaids%NOTFOUND)THEN
                   nuSharesCanceled :=0;
                  END IF;
                  CLOSE cuGetMontlyPaids;
                  ut_trace.trace('nuSharesCanceled: '||nuSharesCanceled, 10);

                  --Calcula total cuotas
                  OPEN cuGetDefTotalShares(rcProductPerSusc.FINANCING_ID);
                  FETCH cuGetDefTotalShares INTO nuTotalShares;
                  IF(cuGetDefTotalShares%NOTFOUND)THEN
                   nuTotalShares :=0;
                  END IF;
                  CLOSE cuGetDefTotalShares;
                  ut_trace.trace('nuTotalShares: '||nuTotalShares, 10);

                  --Obtiene el total de cuotas generadas(facturadas)
                  OPEN cuGetMontlyGen(rcProductPerSusc.PRODUCT_ID,rcProductPerSusc.FINANCING_ID);
                  FETCH cuGetMontlyGen INTO nuMontlyGen;
                  IF(cuGetMontlyGen%NOTFOUND)THEN
                   nuMontlyGen :=0;
                  END IF;
                  CLOSE cuGetMontlyGen;
                  ut_trace.trace('nuMontlyGen: '||nuMontlyGen, 10);

                -- 1. Tipo de identificacion
                OPEN cuGetIdentTypeEq(rcProductPerSusc.ident_type_id);
                FETCH cuGetIdentTypeEq INTO rcSampleDetail.type_identification_dc;
                CLOSE cuGetIdentTypeEq;
                ut_trace.trace('type_identification_dc: '||rcSampleDetail.type_identification_dc, 10);

                -- 2. Numero de identificacion
                --Se valida el tipo de idntificacion NIT
                IF(rcProductPerSusc.ident_type_id = 110) THEN

                  nuVDPosition := InStr(rcProductPerSusc.identification, '-');
                  --Se valida si tiene el caracter - para indetificar la posicion
                  --del digito de verificacion
                  IF(nuVDPosition > 0)  THEN
                      v_num_identifica := LPad(SubStr(rcProductPerSusc.identification, 0, nuVDPosition-1), 11, '0');
                  ELSE
                      v_num_identifica := LPad(rcProductPerSusc.identification, 11, '0');
                  END IF;
                ELSE
                  v_num_identifica := LPad(rcProductPerSusc.identification, 11, '0');
                END IF;

                --rcSampleDetail.identification_number := rcProductPerSusc.identification;
                rcSampleDetail.identification_number := v_num_identifica;
                ut_trace.trace('identification_number: '||rcSampleDetail.identification_number, 10);

                -- 3. Numero de obligacion (Codigo diferido)
                rcSampleDetail.account_number :=rcProductPerSusc.FINANCING_ID;
                ut_trace.trace('account_number: '||rcSampleDetail.account_number, 10);

                -- NIVEL
                rcSampleDetail.nivel :='P';
                ut_trace.trace('nivel: '||rcSampleDetail.nivel, 10);

                -- 4. Nombre Completo
                rcSampleDetail.full_name := SubStr(rcProductPerSusc.full_name, 0, 45);
                ut_trace.trace('full_name: '||rcSampleDetail.full_name, 10);

                --5. Situacion del titular
                rcSampleDetail.situation_holder_dc := 0;
                ut_trace.trace('situation_holder_dc: '||rcSampleDetail.situation_holder_dc, 10);

                dtDate := null;
                  OPEN cuGetInitDebtDate(rcProductPerSusc.FINANCING_ID);
                  FETCH cuGetInitDebtDate INTO dtDate;
                  IF(cuGetInitDebtDate%NOTFOUND)THEN
                   dtDate :=SYSDATE;
                  END IF;
                  CLOSE cuGetInitDebtDate;
                  ut_trace.trace('2dtDate: '||dtDate, 10);
                ut_trace.trace('dtDate: '||dtDate, 10);

                --6. Fecha de apertura de la obligación
                rcSampleDetail.opening_date := To_Number(To_Char(dtDate, 'YYYYMMDD'));
                ut_trace.trace('opening_date: '||rcSampleDetail.opening_date, 10);

                dtDate := NULL;
                  OPEN cuGetEndDebDate(rcProductPerSusc.FINANCING_ID);
                  FETCH cuGetEndDebDate INTO dtDate;
                  IF(cuGetEndDebDate%NOTFOUND)THEN
                   dtDate :=SYSDATE;
                  END IF;
                  CLOSE cuGetEndDebDate;
                ut_trace.trace('dtDate: '||dtDate, 10);

                  OPEN cuGetLastChrgPayHist(rcProductPerSusc.FINANCING_ID);
                  FETCH cuGetLastChrgPayHist INTO dtPaymentDate, dtDuedate;
                  IF(cuGetLastChrgPayHist%NOTFOUND)THEN
                    dtPaymentDate  := SYSDATE ;
                    dtDuedate  := SYSDATE;
                  END IF;
                  CLOSE cuGetLastChrgPayHist;
                ut_trace.trace('dtPaymentDate: '||dtPaymentDate, 10);
                ut_trace.trace('dtDuedate: '||dtDuedate, 10);

                /*
                Si la fecha viene vacia significa que ya no hay saldo diferido
                pendiente para la obligacion.
                Se procede a buscar la ultima fecha de pago de esa obligacion,
                en dado caso que aun no haya pagado esa cuota se obtiene la fecha
                en la que se espera el cliente pague.
                */
                IF(dtDate IS NULL) THEN
                    dtDate := Nvl(dtPaymentDate, dtDuedate);
                END IF;

                --7. Fecha de vencimiento (Estimada)
                --Se debe validar que la fecha de vencimiento sea igual
                --o posterior a la fecha de corte para ese caso la fecha de corte
                --es la fecha del sistema
                --IF(dtDate < SYSDATE)THEN
                IF(dtDate < idtFechCierr)THEN
                  rcSampleDetail.due_date_dc := To_Number(To_Char(idtFechCierr, 'YYYYMMDD'));
                ELSE
                  rcSampleDetail.due_date_dc := To_Number(To_Char(dtDate, 'YYYYMMDD'));
                END IF;

                ut_trace.trace('due_date_dc: '||rcSampleDetail.due_date_dc, 10);

                -- 8. Responsable o calidad de deudor
                IF(rcProductPerSusc.report_type = 'D') THEN
                  rcSampleDetail.responsible_dc := 0;
                ELSIF(rcProductPerSusc.report_type = 'C') THEN
                  rcSampleDetail.responsible_dc := 1;
                END IF;
                ut_trace.trace('responsible_dc: '||rcSampleDetail.responsible_dc, 10);

                -- 9. Tipo de obligacion
                rcSampleDetail.type_obligation_id_dc := 1;
                ut_trace.trace('type_obligation_id_dc: '||rcSampleDetail.type_obligation_id_dc, 10);

                -- 10. Subsidio hipotecario
                rcSampleDetail.mortgage_subsidy_dc := 0;
                ut_trace.trace('mortgage_subsidy_dc: '||rcSampleDetail.mortgage_subsidy_dc, 10);

                -- 11. Fecha de subsidio
                rcSampleDetail.date_subsidy_dc := 0;
                ut_trace.trace('date_subsidy_dc: '||rcSampleDetail.date_subsidy_dc, 10);

                --12. Termino del contrato
                rcSampleDetail.term_contract_dc := 2;
                ut_trace.trace('term_contract_dc: '||rcSampleDetail.term_contract_dc, 10);

                --Obtiene el saldo del producto  y el diferido
                OPEN cuGetPortfolioBalance(rcProductPerSusc.PRODUCT_ID,rcProductPerSusc.FINANCING_ID);
                FETCH cuGetPortfolioBalance INTO nuDeferrredBalance, nuCurrentBalance;
                --FETCH cuGetPortfolioBalance INTO nuDeferrredBalance;
                IF(cuGetPortfolioBalance%NOTFOUND)THEN
                  nuDeferrredBalance := 0 ;
                  nuCurrentBalance  := 0;
                END IF;
                CLOSE cuGetPortfolioBalance;
                --nuDeferrredBalance :=rcProductPerSusc.SALDO_DIFE;
                --nuCurrentBalance  := 0;

                --La forma de pago se modifica para que sea siempre 0 al dia ya qu
                --para  Brilla no aplica el 1 pago voluntario al ser brilla
                --un cupo rotativo.
                rcSampleDetail.method_payment_id_dc := 0;
                ut_trace.trace('method_payment_id_dc: '||rcSampleDetail.method_payment_id_dc, 10);

                -- 14. Periodicidad de pago
                rcSampleDetail.periodicity_id_dc := 1;
                ut_trace.trace('periodicity_id_dc: '||rcSampleDetail.periodicity_id_dc, 10);

                -- 15. Novedad
                ut_trace.trace('rcProductPerSusc.sesuesfn: '||rcProductPerSusc.sesuesfn, 10);
                -- A: Al Dia, D: Deuda no vencida, C: Castigado, M: Mora
                IF(rcProductPerSusc.sesuesfn = 'D') THEN
                    rcSampleDetail.new_portfolio_id_dc := 1;
                    --Edad de mora
                    rcSampleDetail.mora_age := 0;
                ELSIF (rcProductPerSusc.sesuesfn = 'A') THEN

                    OPEN cuGetPenaltyExcDate(rcProductPerSusc.product_id);
                    FETCH cuGetPenaltyExcDate INTO dtPenaltyExcDate;
                    IF(cuGetPenaltyExcDate%NOTFOUND)THEN
                      dtPenaltyExcDate := NULL;
                    END IF;
                    CLOSE cuGetPenaltyExcDate;

                    -- Si la exclusion es de menos de un mes, se reporta 14 - recuperado
                    IF(dtPenaltyExcDate > ADD_MONTHS(SYSDATE, -1)) THEN
                        rcSampleDetail.new_portfolio_id_dc := 14;
                    ELSE
                    -- sino el usuario no paso de Castigado a Al Dia en el ultimo mes
                        rcSampleDetail.new_portfolio_id_dc := 1;
                    END IF;

                    --Edad de mora
                    rcSampleDetail.mora_age := 0;

                --Se realiza modifiacion para incluir el estado Castigado
                ELSIF(rcProductPerSusc.sesuesfn = 'M' OR rcProductPerSusc.sesuesfn = 'C') THEN

                    --Calculo de dias de la edad de mora
                    --nuMoraAge := Ceil(SYSDATE-dtArrearInitDate);
                    --nuMoraAge := rcProductPerSusc.EDAD;
                    --ut_trace.trace('nuMoraAge: '||nuMoraAge, 10);

                    --validacion de los dias de mora
                    IF((nuMoraAge) BETWEEN 0 AND 29) THEN  -- MORA 0
                        --Novedad
                        rcSampleDetail.new_portfolio_id_dc := 1;
                        --Edad de mora
                        rcSampleDetail.mora_age := 0;
                    ELSIF((nuMoraAge) BETWEEN 30 AND 59) THEN  -- MORA 30
                        --novedad
                        rcSampleDetail.new_portfolio_id_dc := 6;
                        --Edad de mora
                        rcSampleDetail.mora_age := 30;
                    ELSIF((nuMoraAge) BETWEEN 60 AND 89) THEN -- MORA 60
                        --novedad
                        rcSampleDetail.new_portfolio_id_dc := 7;
                        --Edad de mora
                        rcSampleDetail.mora_age := 60;
                    ELSIF((nuMoraAge) BETWEEN 90 AND 119) THEN -- MORA 90
                        --novedad
                        rcSampleDetail.new_portfolio_id_dc := 8;
                        --Edad de mora
                        rcSampleDetail.mora_age :=90;
                    ELSIF((nuMoraAge) >= 120) THEN -- MORA 120
                        --novedad
                        rcSampleDetail.new_portfolio_id_dc := 9;
                        --Edad de mora
                        rcSampleDetail.mora_age := 120;
                    END IF;
                END IF;
                ut_trace.trace('new_portfolio_id_dc: '||rcSampleDetail.new_portfolio_id_dc, 10);

                onuNoveltySum := onuNoveltySum + rcSampleDetail.new_portfolio_id_dc;

                -- 16. Estado origen de la cuenta
                rcSampleDetail.source_state_id := 0;
                ut_trace.trace('source_state_id: '||rcSampleDetail.source_state_id, 10);

                -- 17. Fecha estado origen
                --se asigna la fecha del ultimo diferido a la fecha estado de origen
                rcSampleDetail.date_status_origin := rcSampleDetail.opening_date;
                ut_trace.trace('date_status_origin: '||rcSampleDetail.date_status_origin, 10);

                --18. Estado de la cuenta
                --Se modifica para solo dejar la logica para los casos que aplica
                IF(rcSampleDetail.method_payment_id_dc = 0 AND rcSampleDetail.new_portfolio_id_dc = 1) THEN
                    rcSampleDetail.account_state_id_dc := 1;
                ELSIF(rcSampleDetail.method_payment_id_dc = 0 AND rcSampleDetail.new_portfolio_id_dc IN (6,7,8,9)) THEN
                    rcSampleDetail.account_state_id_dc := 2;
                END IF;
                ut_trace.trace('account_state_id_dc: '||rcSampleDetail.account_state_id_dc, 10);

                --19. fecha estado de la cuenta
                --Si esta abierta la fecha de vencimiento rcSampleDetail.account_state_id_dc(1,2,6)
                --Si esta cerrada la fecha de pago rcSampleDetail.account_state_id_dc(3)
                --Se modifica para usar la fecha de corte
                --segun el manual se usa la fecha de corte para las fecha
                --de estado de cuenta cuando la obligacion vigente formade pago (0)

                rcSampleDetail.date_status_account := To_Number(To_Char(SYSDATE, 'YYYYMMDD'));
                ut_trace.trace('date_status_account: '||rcSampleDetail.date_status_account, 10);

                -- Campos aplican solo si el estado financiero es mora
                IF(rcProductPerSusc.sesuesfn = 'M') THEN

                    --31. Edad de mora
                    --rcSampleDetail.mora_age := trunc(sysdate - dtArrearInitDate);
                    rcSampleDetail.mora_age := rcSampleDetail.mora_age;
                    ut_trace.trace('mora_age: '||rcSampleDetail.mora_age, 10);

                    --36. valor saldo en mora
                    rcSampleDetail.value_delay := Round(nuArrearBalance);
                    ut_trace.trace('value_delay: '||rcSampleDetail.value_delay, 10);

                    --39. Cuotas en mora
                    --Se modifica el calculo de las cuotas en mora para usar las cuotas
                    --generadas menos cuotas canceladas.
                    --nuOverdueBills := nuSharesCanceled;
                    --Se valida si el total de cuotas pactadas
                    --es igual a total cutoas pagadas, cuotas en mora es 0
                    nuOverdueBills := 0;
                    IF(nuSharesCanceled = nuTotalShares)THEN
                      nuOverdueBills :=  0;
                    ELSE
                      --Calculo de cuotas en mora para estado M  mora o C castigado
                      IF(rcProductPerSusc.sesuesfn = 'M' or rcProductPerSusc.sesuesfn = 'C')THEN
                        nuOverdueBills := nuMontlyGen - Nvl(nuSharesCanceled,0);
                      END IF;
                    END IF;
                    rcSampleDetail.shares_debt := nuOverdueBills;
                    ut_trace.trace('shares_debt: '||rcSampleDetail.shares_debt, 10);
                END IF;

                --27. Tipo de moneda
                rcSampleDetail.type_money_dc := 1;

                --28. Tipo de garantia
                rcSampleDetail.type_warranty_dc := 1;

                --Obtiene el valor inicial
                OPEN  cuGetAllocatedQuota(rcProductPerSusc.FINANCING_ID);
                FETCH cuGetAllocatedQuota INTO nuAprobValue;
                CLOSE cuGetAllocatedQuota;

                --32. Valor inicial
                rcSampleDetail.initial_values_dc := Round(Nvl(nuAprobValue, 0));
                ut_trace.trace('initial_values_dc: '||rcSampleDetail.initial_values_dc, 10);

                --33. Saldo deuda
                rcSampleDetail.debt_to_dc := round(nuDeferrredBalance + nuCurrentBalance);
                --rcSampleDetail.debt_to_dc := Round(nuDeferrredBalance);
                ut_trace.trace('debt_to_dc: '||rcSampleDetail.debt_to_dc, 10);

                --Valida que el saldo de la deuda sea mayor o igual
                --al saldo de la mora
                IF(rcSampleDetail.debt_to_dc < rcSampleDetail.value_delay)THEN
                  rcSampleDetail.debt_to_dc := rcSampleDetail.value_delay;
                END IF;

                --34. Valor disponible
                rcSampleDetail.value_available := 0;
                ut_trace.trace('value_available: '||rcSampleDetail.value_available, 10);

                OPEN cuGetDefMonthlyValue(rcProductPerSusc.FINANCING_ID);
                FETCH cuGetDefMonthlyValue INTO nuMonthlyValue;
                IF(cuGetDefMonthlyValue%NOTFOUND)THEN
                  nuMonthlyValue := 0;
                END IF;
                CLOSE cuGetDefMonthlyValue;
                ut_trace.trace('nuMonthlyValue: '||nuMonthlyValue, 5);

                --Valida si el valor de la cuota es cero y el producto
                --tiene valor en mora , el valor de la cuota se setea
                --con dicho valor
                IF((rcSampleDetail.total_shares = 0 OR rcSampleDetail.shares_debt =0  OR nuMonthlyValue = 0 ) AND rcProductPerSusc.sesuesfn = 'M' AND nuArrearBalance >0 )THEN
                  --Valor de cuota
                  IF(nuMonthlyValue = 0)THEN
                     nuMonthlyValue := nuArrearBalance;
                  END IF;
                  ut_trace.trace('monthly_value: '||nuMonthlyValue, 5);

                  --Se modifica el valor seteado en total cuotas a 1
                  IF(rcSampleDetail.total_shares = 0)THEN
                    rcSampleDetail.total_shares := 1;
                  END IF;
                  ut_trace.trace('total_shares: '||rcSampleDetail.total_shares, 5);

                  --Se modifica el valor seteado en cuotas en mora a 1
                  IF(rcSampleDetail.shares_debt = 0)THEN
                    rcSampleDetail.shares_debt :=1;
                  END IF;
                  ut_trace.trace('shares_debt: '||rcSampleDetail.shares_debt, 5);
                END IF;

                rcSampleDetail.monthly_value := Round(nuMonthlyValue);
                ut_trace.trace('monthly_value: '||rcSampleDetail.monthly_value, 10);

                --37. Total cuotas
                rcSampleDetail.total_shares := Round(nuTotalShares);
                ut_trace.trace('total_shares: '||rcSampleDetail.total_shares, 10);

                --38. Cuotas canceladas
                IF(nuSharesCanceled > 999) THEN
                    rcSampleDetail.shares_canceled := 999;
                ELSE
                    rcSampleDetail.shares_canceled := nuSharesCanceled;
                END IF;

                ut_trace.trace('shares_canceled: '||rcSampleDetail.shares_canceled, 10);

                dtPaymentDate := NULL;
                dtDuedate := NULL;

                OPEN cuGetLastChrgPay(rcProductPerSusc.FINANCING_ID);
                FETCH cuGetLastChrgPay INTO dtPaymentDate, dtDuedate;
                IF(cuGetLastChrgPay%NOTFOUND)THEN
                  dtPaymentDate  := NULL;
                  dtDuedate  := SYSDATE;
                END IF;
                CLOSE cuGetLastChrgPay;
                ut_trace.trace('dtPaymentDate: '||dtPaymentDate, 10);

                --42. Fecha limite de pago
                --Se debe validar que la fecha limite no sea mayor a la fecha de corte
                IF( dtDuedate > SYSDATE OR dtDuedate IS NULL)THEN
                  rcSampleDetail.payment_deadline_dc := To_Number(To_Char(SYSDATE, 'YYYYMMDD'));
                ELSE
                  rcSampleDetail.payment_deadline_dc := To_Number(To_Char(dtDuedate, 'YYYYMMDD'));
                END IF;

                ut_trace.trace('payment_deadline_dc: '||rcSampleDetail.payment_deadline_dc, 10);

                --43. Fecha de pago
                --Se valida que se tenga fecha de pago en caso que no se tenga la fecha
                --de pago se debe enviar cero.
                IF( dtPaymentDate IS NULL )THEN
                  -- A: Al Dia, D: Deuda no vencida, C: Castigado, M: Mora
                  IF(rcProductPerSusc.sesuesfn IN('A','D') )THEN
                    rcSampleDetail.payment_date := To_Number(To_Char(SYSDATE, 'YYYYMMDD'));
                  ELSE
                    rcSampleDetail.payment_date := To_Number(0);
                  END IF;
                ELSE
                  rcSampleDetail.payment_date := To_Number(To_Char(dtPaymentDate, 'YYYYMMDD'));
                END IF;
                ut_trace.trace('payment_date: '||rcSampleDetail.payment_date, 10);

                --44. Oficina de radicación
                rcSampleDetail.radication_office_dc := SubStr(pktblsistema.fsbgetcompanyname(99), 0, 30);
                ut_trace.trace('radication_office_dc: '||rcSampleDetail.radication_office_dc, 10);

                OPEN cuGetSubsInfo(rcProductPerSusc.product_id);
                FETCH cuGetSubsInfo INTO nuSusbcriberId, nuSubsMail;
                CLOSE cuGetSubsInfo;

                sbCity := NULL;
                sbAddress := NULL;
                ut_trace.trace('cuGetAddressInfo: '||nuSusbcriberId, 10);
                OPEN cuGetAddressInfo(nuSusbcriberId);
                FETCH cuGetAddressInfo INTO sbCity, sbAddress;
                CLOSE cuGetAddressInfo;
                ut_trace.trace('cuGetAddressInfo: '||nuSusbcriberId, 10);

                --45 Ciudad de radicacion
                rcSampleDetail.city_radication_office_dc := Upper(SubStr(pktblsistema.fsbgetsistciud(99), 0, 20));

                --50. Direccion de residencia
                rcSampleDetail.residential_address_dc := SubStr(sbAddress, 0, 60);
                ut_trace.trace('residential_address_dc: '||rcSampleDetail.residential_address_dc, 10);

                -- Identificador de la entidad
                rcSampleDetail.detail_sample_id := seq_ld_sample_detai.NEXTVAL;
                rcSampleDetail.sample_id := inuFatherId;
                ut_trace.trace('detail_sample_id: '||rcSampleDetail.detail_sample_id, 10);
                ut_trace.trace('sample_id: '||rcSampleDetail.sample_id, 10);

                --llenado de campos NOT NULL de la entidad ld_sample_detai.
                rcSampleDetail.quality_cf := 'P';
                rcSampleDetail.state_cf := 0;
                rcSampleDetail.statement_date_cf := SYSDATE;
                rcSampleDetail.type_identification_cf := 1;
                rcSampleDetail.record_type_id_cf := 0;
                rcSampleDetail.branch_office_cf := ' ';
                rcSampleDetail.mora_age := Nvl(rcSampleDetail.mora_age, 0);
                rcSampleDetail.value_delay := Nvl(rcSampleDetail.value_delay, 0);
                rcSampleDetail.shares_debt := Nvl(rcSampleDetail.shares_debt, 0);
                rcSampleDetail.is_approved := 'Y';
                rcSampleDetail.source := rcProductPerSusc.source;
                rcSampleDetail.SUBSCRIBER_ID := rcProductPerSusc.SUBSCRIBER_ID;
                rcSampleDetail.PRODUCT_ID := rcProductPerSusc.PRODUCT_ID;
                rcSampleDetail.SUBSCRIPTION_ID := rcProductPerSusc.SUBSCRIPTION_ID;

                -- Inserta el registro
                dald_sample_detai.insRecord(rcSampleDetail);
                nuTotalRecords := nuTotalRecords +1;
                ut_trace.trace('USUARIO PROCESADO: ', 10);
              ELSE
                  ut_trace.Trace('LDC_DATACREDITOMGR.GenSampleDetailRecords Producto no valido para reportar product_id'||rcProductPerSusc.product_id, 10);
              END IF;--Validacion del producto valido
          END IF;--Validacion de duplicados

          nuProcessedRecords := nuProcessedRecords + 1;

          -- commit cada 500 clientes
          IF(MOD(nuProcessedRecords,500) = 0) THEN
            Pkstatusexeprogrammgr.Upstatusexeprogramat(isbProgramName, 'Proceso en ejecucion...', inuTotalRecords, nuProcessedRecords);
            Pkgeneralservices.Committransaction;
          END IF;

        END LOOP;

        Pkstatusexeprogrammgr.Upstatusexeprogramat(isbProgramName, 'Proceso en ejecucion...', inuTotalRecords, nuProcessedRecords);
        Pkgeneralservices.Committransaction;

        --Total registros creados en la tabla de detalles
        inuTotalRecords := nuTotalRecords;

        ut_trace.trace('FIN LDC_DATACREDITOMGR.GenSampleDetailRecords', 10);
    EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
        Dbms_Output.Put_Line(SQLERRM ||' sbAccountNumber'||sbAccountNumber);
        --Dbms_Output.Put_Line(' sbIndexProdInfo '||sbIndexProdInfo);
        raise ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        Dbms_Output.Put_Line(SQLERRM ||' sbAccountNumber'||sbAccountNumber);
        ---Dbms_Output.Put_Line(' sbIndexProdInfo '||sbIndexProdInfo);
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END GenSampleDetailRecords;


    /*****************************************************************
    Metodo      :  GenerateENDRecord
    Descripcion	:  Crea registro de fin para muestra aleatoria o reporte
                    maestro.

    Autor       : Manuel Mejia
    Fecha       : 22-05-2017
    Parametros
                isbProgramName:     Identificador del programa ejecutado en ESTAPROG
                inuFatherId:        identificador del registro en LD_SAMPLE o LD_RANDOM_SAMPLE
                                        dependiendo del proceso ejecutado
                inuTotalRecords:    Total de registros con informacion de clientes insertados
                inuNoveltySum:      sumatoria de campo novedad para todos los registros inserados

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    22-05-2017   Mmejia        Creación
    ******************************************************************/
    PROCEDURE GenerateENDRecord(isbProgramName IN estaprog.esprprog%type,
                                inuFatherId IN ld_random_sample.random_sample_id%type,
                                inuTotalRecords IN ld_random_sample_fin.number_of_record%type,
                                inuNoveltySum  IN ld_random_sample_fin.sum_of_new%type) IS

        sbFinalRecordIdent      ld_random_sample_fin.final_record_indicator%type;

        nuDummy                 ld_general_parameters.numercial_value%type;


        rcSampleFin             dald_sample_fin.styLD_SAMPLE_FIN;

    BEGIN
        ut_trace.trace('INICIA LDC_DATACREDITOMGR.GenerateENDRecord', 10);

        /*Bloque de obtencion de parametros*/
        provapatapa('FINAL_RECORD_INDICATOR', 'S', nuDummy, sbFinalRecordIdent);

        IF(sbFinalRecordIdent IS NULL) THEN
            raiseError(isbProgramName, 'Parametro FINAL_RECORD_INDICATOR esta vacio');
        END IF;

        IF(isbProgramName like(csbReportExecName||'%')) THEN

            --Obtiene el consecutivo de la secuencia
            rcSampleFin.id := seq_ld_sample_fin.NEXTVAL;
            rcSampleFin.sample_id := inuFatherId;
            rcSampleFin.final_record_indicator := sbFinalRecordIdent;
            rcSampleFin.date_of_process := SYSDATE;
            rcSampleFin.NUMBER_OF_RECORD := inuTotalRecords + 2;
            rcSampleFin.sum_of_new := inuNoveltySum;
            rcSampleFin.filler := RPad('0', 757, '0');

            dald_sample_fin.insRecord(rcSampleFin);

        END IF;

        Pkgeneralservices.Committransaction;
        ut_trace.trace('FIN LDC_DATACREDITOMGR.GenerateENDRecord', 10);

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR then
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END GenerateENDRecord;


    /*****************************************************************
    Metodo      :  ReCalculateENDRecord
    Descripcion	:  Recalcula los datos de fin para muestra  reporte
                    maestro.

    Autor       : Manuel Mejia
    Fecha       : 22-05-2017
    Parametros
                inuFatherId:        identificador del registro en LD_SAMPLE o LD_RANDOM_SAMPLE
                                        dependiendo del proceso ejecutado

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    22-05-2017   Mmejia        Creación
    ******************************************************************/
    PROCEDURE ReCalculateENDRecord(
                                inuFatherId IN ld_random_sample.random_sample_id%TYPE
                                )
    IS

      CURSOR cuDatoFin
      IS
        SELECT *
          FROM LD_SAMPLE_FIN
          WHERE sample_id = inuFatherId;

      CURSOR cuDatosDetail
      IS
        SELECT Sum(new_portfolio_id_dc)sum_of_new,Count(*) NUMBER_OF_RECORD
          FROM LD_SAMPLE_DETAI
          WHERE sample_id = inuFatherId
          AND IS_APPROVED ='Y';

      rccuDatosDetail cuDatosDetail%ROWTYPE;
      rccuDatoFin cuDatoFin%ROWTYPE;
      rcSampleFin             dald_sample_fin.styLD_SAMPLE_FIN;
    BEGIN
        ut_trace.trace('INICIA LDC_DATACREDITOMGR.GenerateENDRecord', 10);

        --Abre cursor de los datos FIN
        OPEN cuDatoFin;
        FETCH cuDatoFin INTO rccuDatoFin;
        CLOSE cuDatoFin;

        --Abre cursor de los datos DETALLE
        OPEN cuDatosDetail;
        FETCH cuDatosDetail INTO rccuDatosDetail;
        CLOSE cuDatosDetail;

        dald_sample_fin.getrecord(rccuDatoFin.id, rcSampleFin );

        rcSampleFin.NUMBER_OF_RECORD := rccuDatosDetail.NUMBER_OF_RECORD + 2;
        rcSampleFin.sum_of_new := Nvl(rccuDatosDetail.sum_of_new,0);
        dald_sample_fin.updrecord(rcSampleFin);

        ut_trace.trace('FIN LDC_DATACREDITOMGR.GenerateENDRecord', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR then
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END ReCalculateENDRecord;


    /*****************************************************************
    Metodo      :  GenerateSampleData
    Descripcion	:  Metodo inicial para creacion de muestras aleatorias
                    y reportes maestros

    Autor       : Manuel Mejia
    Fecha       : 22-05-2017
    Parametros
                inuCreditBureauId:  Central de riesgo procesada.
                inuSectorTypeId:    Sector procesado.
                isbExecutableName:  Nombre del ejecutable desde donde se lanza el proceso.


    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    22-05-2017   Mmejia        Creación
    ******************************************************************/
    PROCEDURE GenerateSampleData(inuCreditBureauId IN ld_credit_bureau.credit_bureau_id%Type,
                                 inuSectorTypeId   IN ld_type_sector.type_id%Type,
                                 isbExecutableName IN sa_executable.name%TYPE,
                                 idtFechCierr      IN DATE
                                 )
    IS
      sbProgramName             estaprog.esprprog%TYPE;
      nuTotalRecords            NUMBER(20) := 0;
      nuProcessedRecords        NUMBER(20) := 0;
      rcSample                  dald_sample.styLD_SAMPLE;
      nuDummyValue              ld_general_parameters.numercial_value%TYPE;
      sbDummyValue              ld_general_parameters.text_value%TYPE;
      nuNoveltySum              ld_random_sample_fin.sum_of_new%type;
      sbErrorMsg                VARCHAR2(200);
      nuError                   NUMBER;

      sbDATACREDITODepart     ld_general_parameters.text_value%TYPE;
      sbDATACREDITOLocal      ld_general_parameters.text_value%TYPE;
      sbDATACREDITOCycle      ld_general_parameters.text_value%TYPE;
      sbDATACREDITOCate       ld_general_parameters.text_value%TYPE;
      sbDATACREDITOSubCate    ld_general_parameters.text_value%TYPE;

      sbRandSampleAprovValidat  ld_random_sample_cont.enlargement_goals%TYPE;
      nuId                      ld_sample.sample_id%TYPE;

      rccuCierr LDC_BCDATACREDITO.cuCierr%ROWTYPE;
    BEGIN
        ut_trace.trace('INICIA LDC_DATACREDITOMGR.GenerateSampleData', 10);

        -- Crea el nombre del proceso
        sbProgramName := isbExecutableName||Sqesprprog.NEXTVAL;

        -- Se define el numero de registros a procesar
        IF(isbExecutableName = csbReportExecName) THEN
          -- En reporte maestro el numero es todos los clientes de ld_send_authorized
          -- con productos del tipo definido para el sector y la central de riesgo
          ut_trace.trace('INICIA LDC_DATACREDITOMGR.GenerateSampleData ANTES', 10);

          -- se busca el parametro DEPARTAMENTO a procesar
          provapatapa('DATACREDITO_DEPART', 'S', nuDummyValue, sbDATACREDITODepart);

          -- se busca el parametro LOCALIDAD a procesar
          provapatapa('DATACREDITO_LOCAL', 'S', nuDummyValue, sbDATACREDITOLocal);

          -- se busca el parametro ciclos a procesar
          provapatapa('DATACREDITO_CYCLE', 'S', nuDummyValue, sbDATACREDITOCycle);

          -- se busca el parametro categorias a procesar
          provapatapa('DATACREDITO_CATE', 'S', nuDummyValue, sbDATACREDITOCate);

          -- se busca el parametro SUBCATEGORIA a procesar
          provapatapa('DATACREDITO_SUBCATE', 'S', nuDummyValue, sbDATACREDITOSubCate);

          ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords sbDATACREDITODepart '||sbDATACREDITODepart, 10);
          ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords sbDATACREDITOLocal '||sbDATACREDITOLocal, 10);
          ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords sbDATACREDITOCycle '||sbDATACREDITOCycle, 10);
          ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords sbDATACREDITOCate '||sbDATACREDITOCate, 10);
          ut_trace.trace('LDC_DATACREDITOMGR.GenSampleDetailRecords sbDATACREDITOSubCate '||sbDATACREDITOSubCate, 10);

          ut_trace.trace(' LDC_DATACREDITOMGR.GenerateSampleData idtFechCierr '||idtFechCierr, 10);

          --Obtiene datos del cierre
          OPEN LDC_BCDATACREDITO.cuCierr(idtFechCierr);
          FETCH LDC_BCDATACREDITO.cuCierr INTO rccuCierr;
          CLOSE LDC_BCDATACREDITO.cuCierr;

          ut_trace.trace(' LDC_DATACREDITOMGR.GenerateSampleData rccuCierr.cicoano '||rccuCierr.cicoano, 10);
          ut_trace.trace(' LDC_DATACREDITOMGR.GenerateSampleData rccuCierr.cicomes '||rccuCierr.cicomes, 10);
          nuTotalRecords := LDC_BCDATACREDITO.fnuGetProcessedRecords(rccuCierr.cicoano,rccuCierr.cicomes,sbDATACREDITODepart,sbDATACREDITOLocal, sbDATACREDITOCycle,sbDATACREDITOCate,sbDATACREDITOSubCate,csbDateIniDataCredito);

          ut_trace.trace(' LDC_DATACREDITOMGR.GenerateSampleData nuTotalRecords '||nuTotalRecords, 10);
        ELSE
          RETURN;
        END IF;

        ut_trace.trace('Nombre del proceso: '||sbProgramName, 10);

        -- Inserta registo de seguimiento en ESTAPROG
        Pkstatusexeprogrammgr.Addrecord(sbProgramName, 'Proceso en ejecucion ...', nuTotalRecords);
        Pkgeneralservices.Committransaction;

        ut_trace.trace('Registros a procesar: '||nuTotalRecords, 10);

        IF(isbExecutableName = csbReportExecName) THEN
          /* VALIDACION DE APROBACIÿN DE MUESTRA ALEATORIA */
          -- Se obtiene el flag que define si se debe aprobar muestra alatoria
          sbRandSampleAprovValidat := dald_credit_bureau.fsbGetAPROVE_SAMPLE(inuCreditBureauId);

          ut_trace.trace('Central de riesgo requiere aprobación de muestra aleatoria? '||sbRandSampleAprovValidat, 10);

          -- Obtiene la secuencia de LD_SAMPLE
          nuId := SEQ_LD_GENERATESAMPLE.NEXTVAL;

          rcSample.sample_id := nuId;
          rcSample.generation_date := idtFechCierr;
          rcSample.register_date := SYSDATE;
          rcSample.type_sector := inuSectorTypeId;
          rcSample.user_id := sa_bouser.fnugetuserid;
          rcSample.credit_bureau_id := inuCreditBureauId;
          rcSample.flag := 'N';
          rcSample.type_product_id := -1;

          dald_sample.insRecord(rcSample);
        END IF;

        Pkgeneralservices.Committransaction;

        ut_trace.trace('LDC_DATACREDITOMGR.GenerateSampleData inuCreditBureauId'||inuCreditBureauId, 10);
        ut_trace.trace('LDC_DATACREDITOMGR.GenerateSampleData cnuDatacredCreditBureau'||cnuDatacredCreditBureau, 10);

        IF(inuCreditBureauId = cnuDatacredCreditBureau) THEN
          /************ D A T A C R E D I T O ************/
          -- Crea registro de control (para el reporte)
          GenerateControlRecord(sbProgramName, nuId, inuCreditBureauId, inuSectorTypeId);

          --Valida si el ejecutable es Reporte
          IF(isbExecutableName = csbReportExecName) THEN
            -- inserta los registros en LD_SAMPLE_DETAI
            GenSampleDetailRecords(rccuCierr.cicoano,
                                   rccuCierr.cicomes,
                                    sbProgramName,
                                    nuId,
                                    -1,--Todos los productos
                                    inuCreditBureauId,
                                    inuSectorTypeId,
                                    nuTotalRecords,
                                    idtFechCierr,
                                    FALSE,--forzar insert por producto
                                    nuNoveltySum
                                    );
          END IF;

          -- crea registro de fin (para muestra aleatoria o reporte)
          GenerateENDRecord(sbProgramName, nuId, nuTotalRecords, nuNoveltySum);
        END IF;

        -- Finaliza proceso en estaprog
        Pkstatusexeprogrammgr.Processfinishnok(sbProgramName, 'Proceso Finalizado');

        ut_trace.trace('FIN LDC_DATACREDITOMGR.GenerateSampleData', 10);
    EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
        Dbms_Output.Put_Line(SQLERRM);
        errors.geterror(nuError,sbErrorMsg);
        Pkstatusexeprogrammgr.Processfinishnok(sbProgramName, sbErrorMsg);
        COMMIT;
        RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        Dbms_Output.Put_Line(SQLERRM);
        Errors.setError;
        errors.geterror(nuError ,sbErrorMsg);
        Pkstatusexeprogrammgr.Processfinishnok(sbProgramName, sbErrorMsg);
        COMMIT;
        RAISE ex.CONTROLLED_ERROR;
    END GenerateSampleData;


    /*****************************************************************
    Propiedad intelectual de REDI. (c).

    Procedure	: FrFGetCreditDetaiBySubscriber
    Descripción	: Obtener datos de reporte centrales

    Parámetros	:	Descripción

    Retorno     :

    Autor	: Manuel Mejia
    Fecha	: 24-06-2017

    Historia de Modificaciones
    Fecha       Autor
    ----------  --------------------
    24-06-2017  Mmejia
    Creación.
    *****************************************************************/
    FUNCTION FrFGetCreditDetaiBySubscriber
    RETURN CONSTANTS.TYREFCURSOR
    IS
        /* Cursor */
        rfCursor       CONSTANTS.TYREFCURSOR;
        sbElementId     GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        inuSubscriberId GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE;

        /*****************************************************************
        Propiedad intelectual de REDI. (c).

        Procedure	: GetInstanceData
        Descripción	: Obtener datos de la instancia

        Parámetros	:	Descripción

        Retorno     :

        Autor	: Manuel Mejia
        Fecha	: 22-04-2016

        Historia de Modificaciones
        Fecha       Autor
        ----------  --------------------
        22-04-2016  Mmejia
        Creación.
        *****************************************************************/
        PROCEDURE GetInstanceData
        IS
        BEGIN
        pkErrors.push('FrFGetCreditDetaiBySubscriber.GetInstanceData');
        ut_trace.trace('INICIO FrFGetCreditDetaiBySubscriber.GetInstanceData',1);

        /* Obtiene Subcriber de la instancia */
        GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE(GE_BOINSTANCECONSTANTS.CSBGLOBAL_ID,sbElementId);

        IF (sbElementId IS NOT NULL) THEN
            IF (UT_STRING.EXTSTRFIELD(sbElementId,'-',1) IS NOT NULL) THEN
                inuSubscriberId := To_Number(Trim(UT_STRING.EXTSTRFIELD(sbElementId,'-',1)));
            ELSE
                inuSubscriberId := To_Number(Trim(sbElementId));
            END IF;
        ELSE
            inuSubscriberId := NULL;
        END IF;

        ut_trace.trace('FIN FrFGetCreditDetaiBySubscriber.GetInstanceData',1);
        pkErrors.pop;
        EXCEPTION
          WHEN LOGIN_DENIED THEN
        	  pkErrors.pop;
        	  RAISE LOGIN_DENIED;
          WHEN pkConstante.exERROR_LEVEL2 then
        	  -- Error Oracle nivel dos
        	  pkErrors.pop;
        	  RAISE pkConstante.exERROR_LEVEL2;
          WHEN OTHERS THEN
        	  pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, gsbMessage);
        	  pkErrors.pop;
        	  raise_application_error(pkConstante.nuERROR_LEVEL2,gsbMessage);
        END GetInstanceData;

    BEGIN
        pkErrors.push('LDC_DATACREDITOMGR.FrFGetCreditDetaiBySubscriber');
        ut_trace.trace('INICIO LDC_DATACREDITOMGR.FrFGetCreditDetaiBySubscriber',1);

        /*********************************************************
        * Obtiene datos de la instancia
        *********************************************************/
        GetInstanceData;
        ut_trace.trace('LDC_DATACREDITOMGR.FrFGetCreditDetaiBySubscriber inuSubscriberId '||inuSubscriberId,1);

        /* Obtiene el costo */
        LDC_BCDATACREDITO.GetCreditDetaiBySubscriber
        (
          inuSubscriberId,
          rfCursor
        );

        ut_trace.trace('FIN LDC_DATACREDITOMGR.FrFGetCreditDetaiBySubscriber',1);
        RETURN rfCursor;
        pkErrors.pop;
    EXCEPTION
      WHEN LOGIN_DENIED THEN
        ROLLBACK;
    	  pkErrors.pop;
    	  RAISE ex.CONTROLLED_ERROR;
      WHEN ex.CONTROLLED_ERROR THEN
        rollback;
        pkErrors.pop;
    	  RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        ROLLBACK;
    	  pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, gsbMessage);
    	  pkErrors.pop;
    	  RAISE ex.CONTROLLED_ERROR;
    END FrFGetCreditDetaiBySubscriber;

END LDC_DATACREDITOMGR;
/
GRANT EXECUTE on LDC_DATACREDITOMGR to SYSTEM_OBJ_PRIVS_ROLE;
/
