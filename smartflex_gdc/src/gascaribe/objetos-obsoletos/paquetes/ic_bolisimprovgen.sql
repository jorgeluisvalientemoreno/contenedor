CREATE OR REPLACE PACKAGE ic_bolisimprovgen AS
    /*
        Propiedad intelectual de Open International Systems. (c).

        Paquete     :   IC_BOLisimProvGen
        Descripci?n :   Objeto de negocio para Provisionar Cartera.

        Autor       :   Claudia Liliana Rodr?guez
        Fecha       :   23-03-2012 15:00:49

        Historia de Modificaciones
        Fecha     IDEntrega

        25-01-2014  eurbano.SAO230831
        Se modifica el m?todo <GetLimitApprovSMMLV>
                              <fnuGetPromtriDaysOnDef>.

        22-11-2013  arendon.SAO224405
        Se modifican los m?todos
        - ValEjecucionPLISIM
        - ProcessLisimGen

        17-07-2013  hlopez.SAO212472
        Se adiciona el atributo Clasificaci?n Contable del Contrato.
        - Se modifica el m?todo <ProcessLisimGen>

        06-05-2013  crodriguez.SAO207548
        Se modifica el m?todo <ValParamProgram>

        12-10-2012  hlopez.SAO194064
        Se modifica el m?todo <ValEjecucionPLISIM>

        01-10-2012  gduque.SAO183760
        Se elimina el m?todo:
                - <fnuConCartCoco>
        Se modifica los m?todos:
                - <ProcessLisimGen>

        11-09-2012  gduque.SAO190015
        Se adiciona los m?todos:
                - <GetProcessDate>
                - <CreateDocument>
        Se modifica los m?todos:
                - <ProcessLisimGen>
                - <ValEjecucionPLISIM>

        16-08-2012  gduqueSAO188626
        Se modifica el metodo <ValEjecucionPLISIM> para eliminar el parametro
        inuNumHilos.

        23-03-2012  crodriguezSAO180613
        Creaci?n.
    */

    ----------------------------------------------------------------------------
    -- M?todos
    ----------------------------------------------------------------------------

    -- Obtiene versi?n actual del paquete
    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Ejecuta Generaci?n de provisi?n de Cartera
    PROCEDURE ProcessLisimGen
    (
        isbEstaprog    IN estaprog.esprprog%TYPE,
        idtProcessDate IN DATE,
        isbTyPrEx      IN VARCHAR2,
        inuPivote      IN ic_cartcoco.cacccons%TYPE,
        inuNumHilos    IN NUMBER,
        inuHilo        IN NUMBER
    );

    -- Valida que el proceso de Provisi?n no se haya ejecutado
    PROCEDURE ValEjecucionPLISIM
    (
        isbFrecuencia   IN ge_process_schedule.frequency%TYPE,
        idtFechaProv    IN DATE,
        inuDiasRetraso  IN NUMBER,
        odtFechaProceso OUT DATE
    );

    PROCEDURE ValParamProgram(isbFrecuencia IN ge_process_schedule.frequency%TYPE);

    -- Obtiene Fecha Final
    FUNCTION fdtFinishDate RETURN DATE;

    -- Genera movimientos de Provisi?n
    PROCEDURE GenerateMovs;

    PROCEDURE GetLisimDetail
    (
        inuProducto    IN servsusc.sesunuse%TYPE,
        idtProcessDate IN DATE
    );

    --Fecha Final
    dtProcessDate DATE;

END IC_BOLisimProvGen;
/
CREATE OR REPLACE PACKAGE BODY ic_bolisimprovgen AS
    /*
        Propiedad intelectual de Open International Systems (c).

        Paquete     :   IC_BOLisimProvGen
        Descripci?n :   Variables, procedimientos y funciones del paquete
                        IC_BOLisimProvGen.

        Autor       :   Claudia Liliana Rodriguez
        Fecha       :   23-03-2012

        Historia de Modificaciones
        Fecha       IDEntrega

        18-09-2014 JLizardoCastro  TEAM 571 - IMPLEMENTACION DEL CALCULO DE PERDIDA ESPERADA
        Se crean los procedimientos: fnuGetMoraMaxtriDaysOnDef, fnuGetContSemDaysOnDef,
                                     fnuGetContYearDaysOnDef, fnuGetContGreSemDaysOnDef

        11-06-2014  aesguerra.3811
        Se modifica <<GetMaxZerYearDaysOnDef>>

        03-06-2014  aesguerra.3722
        Se modifica <<GetFinPercofUsedQuo>>

        21-05-2014  aesguerra.3551
        Se modifica <<fnuGetDaysOnDefault>>

        02-04-2014  aesguerra.3551
        Se modifica el m?todo <GetLimitApprovSMMLV>
                                <ProcessLisimGen>
                                <GetLisimDetail>

        25-01-2014  eurbano.SAO230831
        Se modifica el m?todo <GetLimitApprovSMMLV>
                              <fnuGetPromtriDaysOnDef>.

        14-12-2013  arendon.SAO227508
        Se modifican los m?todos:
            - ValBasicData
            - ValEjecucionPLISIM

        22-11-2013  arendon.SAO224405
        Se modifica el m?todo <ValEjecucionPLISIM>

        11-10-2013  sgomez.SAO219973
        Se corrige par?metro de entrada de un procedimiento para evitar error
        "ORA-06502: number precision too large".

        17-07-2013  hlopez.SAO212472
        Se adiciona el atributo Clasificaci?n Contable del Contrato.
        - Se modifica el m?todo <ProcessLisimGen>

        06-05-2013  crodriguez.SAO207548
        Se modifica el m?todo <ValParamProgram>

        08-04-2013   sgomez.SAO205719
        Se modifica <Provisi?n LISIM> por impacto en <Hechos Econ?micos>
        (adici?n de atributo <?tem>).

        24-01-2013  gduque.SAO200257
        Se modifica el m?todo <ValEjecucionPLISIM>

        16-10-2012  gduque.SAO194162
        Se modifica el m?todo <ValEjecucionPLISIM>.

        12-10-2012  hlopez.SAO194064
        Se modifica el m?todo <ValEjecucionPLISIM>

        01-10-2012  gduque.SAO183760
        Se elimina el m?todo:
                - <fnuConCartCoco>
        Se modifica los m?todos:
                - <ProcessLisimGen>
                - <GetLisimDetail>
        Se adiciona el nombre del paquete a todas las variables globales.

        11-09-2012  gduque.SAO190015
        Se adiciona los m?todos:
                - <GetProcessDate>
                - <CreateDocument>
        Se modifica los m?todos:
                - <ProcessLisimGen>
                - <ValEjecucionPLISIM>
                - <GetLisimDetail>

        29-08-2012  gduqueSAO189287
        Se modifican los metodos <GetLisimDetail> y <ValEjecucionPLISIM>.

        29-08-2012  sgomez.SAO188677
        Se eliminan referencias a la columna <IC_MOVIPROV.MVPRTIAC>.

        16-08-2012  gduqueSAO188626
        Se modifica el metodo <ValEjecucionPLISIM>.

        13-08-2012  gduqueSAO188355
        Se modifica los metodos <GetLisimDetail>, <ProcessLisimGen> y <GenerateMovs>.

        11-08-2012  gduqueSAO183771
        Se modifica el metodo <ProcessLisimGen>.

        23-03-2012  crodriguezSAO180613
        Creaci?n.
    */

    ----------------------------------------------------------------------------
    -- Constantes
    ----------------------------------------------------------------------------

    -- Versi?n de paquete
    csbVERSION CONSTANT VARCHAR2(250) := '3811';
    -- Tipo Documento de Cartera
    cnuTIDOCART CONSTANT ic_tidotimo.tdtmtido%TYPE := 76;
    -- Tipo Movimiento de Cartera
    cnuTiMoCart CONSTANT ic_tidotimo.tdtmtimo%TYPE := 59;
    -- Tipo de Hecho Economico Provisi?n
    csbTIHE CONSTANT ic_movimien.movitihe%TYPE := 'PC';

    -- Variables de LISIM:

    -- D?as de Mora (Edad de Mora m?xima de las Cuentas de Cobro con Saldo Pendiente en el mes anterior.)
    cnuVARDIMO CONSTANT NUMBER := 1;
    -- M?ximo Anual Mora (Edad de Mora m?xima de las Cuentas de Cobro del ?ltimo a?o.)
    cnuMXANMOR CONSTANT NUMBER := 2;
    -- M?ximo Semestral Mora (Edad de Mora m?xima de las Cuentas de Cobro de los ?ltimos SEIS (6) meses.)
    cnuMXSMMOR CONSTANT NUMBER := 3;
    -- Promedio Semestral Mora (Edad de Mora promedio de las Cuentas de Cobros de los ?ltimos SEIS (6) meses.)
    cnuPRSMMOR CONSTANT NUMBER := 4;
    -- Promedio Trimestral Mora (Edad de Mora promedio de las Cuentas de Cobros de los ?ltimos TRES (3) meses.)
    cnuPRTRMOR CONSTANT NUMBER := 5;
    -- Mora Cero (0) Anual (Cantidad de Cuentas de Cobro con Edad de CERO (0) en el ultimo a?o.)
    cnuCEANMOR CONSTANT NUMBER := 6;
    -- Cupo Aprobado ( Valor Total del Cupo Aprobado.)
    cnuCUPAPRO CONSTANT NUMBER := 7;
    -- Cuota M?xima (N?mero de Cuotas m?ximo de los Diferidos con Saldo Pendiente del ?ltimo a?o.)
    cnuCUOTMAX CONSTANT NUMBER := 8;
    -- Porcentaje Cupo Usado Final (Se suman los Saldos Pendientes de Diferidos sobre el Cupo Aprobado.)
    cnuPrCuFin CONSTANT NUMBER := 9;
    -- Intercept (Constante que representa el riesgo promedio de la poblaci?n analizada
    --            y se almacenar? en la Configuraci?n de Variables LISIM.)
    cnuINTERCE CONSTANT NUMBER := 10;
    -- Perdida de Incumplimiento (Se obtiene a partir de los d?as de mora)
    cnuPERCUM CONSTANT NUMBER := 11;

    --Team 571 nuevas variables

    -- Contador Mora 1-30 d?as  en el ultimo a?o
    cnuConMUA CONSTANT NUMBER := 12;
    --Contador Mora 1-30 d?as en el ultimo Semestre
    cnuConMUS CONSTANT NUMBER := 13;
    --Contador Mora Mayor a 60 dias Semestral
    cnuConMMS CONSTANT NUMBER := 14;
    --Mora Maxima en el ultimo Trimestre
    cnuMorMUT CONSTANT NUMBER := 15;
    --Porcentaje de utilizacion
    cnuPorUti CONSTANT NUMBER := 16;
    --Constante para usar el nuevo Esquema de Perdida Incurrida
    sbNombreEntrega CONSTANT VARCHAR2(100) := 'FNB_JLC_RQ_571';

    ----------------------------------------------------------------------------
    -- Variables
    ----------------------------------------------------------------------------
    --Fecha Inicial
    dtInitDate DATE;
    --Fecha Final
    dtFinishDate DATE;

    -- Descripci?n mensaje de error
    sbMensajeError ge_error_log.description%TYPE;

    -- Indice de la tabla temporal donde se almacenan los registros de provisi?n
    -- a partir de cartera castigada
    tmpIC_cartprov pktblic_cartprov.tytbIc_Cartprov;

    -- Indice de la tabla temporal donde se almacenan los registros de provisi?n
    -- a partir de cartera castigada
    nuIndTemp NUMBER;

    -- Contiene ID Estado del proceso
    sbEstaprog estaprog.esprprog%TYPE;

    -- C?digo Usuario
    sbUserName ic_movimien.moviusua%TYPE;

    -- Terminal
    sbTerminal ic_movimien.moviterm%TYPE;

    -- Contiene las cuentas de cobro de un Producto
    tmp_tbCuentasProd IC_BCLisimProvGen.tytbCuentaxProd;

    -- Tabla hash contiene detalle de LISIM por Producto
    TYPE tytbdetlisim IS TABLE OF pktblic_detlisim.tytbIc_Detlisim INDEX BY VARCHAR2(30);

    tmp_tbDetLisim tytbdetlisim;

    -- Tabla hash con indices de las tablas de HE y CartProv
    TYPE tytbhash IS TABLE OF ic_cartprov.caprmovi%TYPE INDEX BY VARCHAR2(250);
    tmp_tbhashIndex tytbhash;

    -- Indice para campo de la tabla hash
    nuIndHash NUMBER;

    -- Tabla que contiene los registros de HE
    tmp_tbIc_moviprov pktblic_moviprov.tytbIc_Moviprov;

    -- Tabla que contiene configuraci?n de SMLV
    tb_ConfSMMLV dage_indicator_values.tyrcGE_indicator_values;

    csbBSS_FAC_LFG_10031316 VARCHAR2(100) := 'BSS_CAR_LFG_10031316_2';

    ------------------------------------------------------------------------
    -- M?todos
    ------------------------------------------------------------------------

    /*
     Propiedad intelectual de Open International Systems. (c).

     Funci?n   :   fsbVersion
     Descripcion :   Obtiene SAO que identifica versi?n asociada a ?ltima
                     entrega del paquete.

     Retorno     :
         csbVERSION      Versi?n de paquete.

     Autor     :   Claudia Liliana Rodr?guez
     Fecha     :   23-03-2012 15:00:49

     Historia de Modificaciones
     Fecha     IDEntrega

     23-03-2011  crodriguezSAO180613
     Creaci?n.
    */

    FUNCTION fsbVersion RETURN VARCHAR2

     IS
    BEGIN

        pkErrors.Push('IC_BOLisimProvGen.fsbVersion');

        pkErrors.Pop;

        RETURN IC_BOLisimProvGen.csbVERSION;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            pkErrors.Pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            pkErrors.Pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
            pkErrors.Pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);
    END fsbVersion;

    /***********************************************************************
    Propiedad Intelectual de Open International Systems (c).
    Procedure     : GetAccountsByProduct

    Descripcion     :  Obtiene las cuentas de cobro de un producto generadas
                       en el ?ltimo a?o y la edad de la deuda

    Parametros     :    Descripcion

    Autor    : Claudia Liliana Rodr?guez
    Fecha    : 26-03-2012

    Historia de Modificaciones
    Fecha       IDEntrega

    12-09-2012  gduque.SAO190015
    Se  elimina el parametro idtFechaProc.

    26-03-2012 crodriguezSAO180613
    creacion
    ***********************************************************************/

    PROCEDURE GetAccountsByProduct(inuProduct IN servsusc.sesunuse%TYPE) IS
        -- Constante cantidad de meses a descontar de la fecha de contabilizaci?n
        cnuCtdMes CONSTANT NUMBER := 12;

        -- Segundos a disminuir para una fecha
        cnuSeg CONSTANT NUMBER := 0.999991574;

        -- Fecha Inicial
        dtFechaIni factura.factfege%TYPE;

        -- Fecha Final
        dtFechaFin factura.factfege%TYPE;

        -- Edad de Mora
        nuEdadMora ic_detlisim.delidimo%TYPE;

        /*
            Propiedad intelectual de Open International Systems. (c).

            Procedure : IniciCuByPro

            Descripcion : Limpiar Tabla PL que contiene las cuentas por
                          producto  e inicializa variables

            Parametros  : Descripcion

            Retorno     :

            Autor : Claudia Liliana Rodr?guez
            Fecha : 23-03-2012

            Historia de Modificaciones
            Fecha    IDEntrega

            12-09-2012  gduque.SAO190015
            Se  elimina el parametro idtFechaProc.

            23-03-2012    crodr?guezSAO180613
            Creacion.
        */
        PROCEDURE IniciCuByPro(inuProduct IN servsusc.sesunuse%TYPE) IS
        BEGIN

            -- Edad de Mora
            nuEdadMora := 0;

            -- Obtiene el rango de fechas para obtener las cuentas
            dtFechaIni := IC_BOLisimProvGen.dtInitDate;
            dtFechaFin := IC_BOLisimProvGen.dtFinishDate + cnuSeg;

            pkgeneralservices.TraceData('Fecha Inicial: ' || dtFechaIni);
            pkgeneralservices.TraceData('Fecha Final: ' || dtFechaFin);

            IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOCODI.delete;
            IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOVAAP.delete;
            IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOVARE.delete;
            IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOVAAB.delete;
            IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOVATO.delete;
            IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOFEPA.delete;
            IC_BOLisimProvGen.tmp_tbCuentasProd.CUCONUSE.delete;
            IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOSACU.delete;
            IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOVRAP.delete;
            IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOFACT.delete;
            IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOFEVE.delete;
            IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOVAFA.delete;
            IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOFEGE.delete;
            IC_BOLisimProvGen.tmp_tbCuentasProd.CUCODIMO.delete;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END IniciCuByPro;

    BEGIN
        pkErrors.Push('IC_BOLisimProvGen.GetAccountsByProduct');

        -- Inicializar
        IniciCuByPro(inuProduct);

        -- Obtiene cuentas de cobro del producto
        IC_BCLisimProvGen.GetAccountsByProduct(dtFechaIni, dtFechaFin, inuProduct, IC_BOLisimProvGen.tmp_tbCuentasProd);

        pkgeneralservices.TraceData('Producto: ' || inuProduct);
        pkgeneralservices.TraceData('Cuentas a procesar: ' ||
                                    IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.count);

        IF (IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.first IS NOT NULL) THEN
            FOR nuIdx IN IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.first .. IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.last
            LOOP

                --  Cuentas CON saldo EM = (Fecha Vencimiento - Ultimo d?a del mes de ejecuci?n)
                IF (IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOSACU(nuIdx) <> 0) THEN
                    -- Calcula la edad de la mora
                    IF (IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOFEVE(nuIdx) <
                       dtFechaFin) THEN
                        nuEdadMora := trunc(dtFechaFin) -
                                      trunc(IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOFEVE(nuIdx));
                    ELSE
                        nuEdadMora := 0;
                    END IF;

                ELSE
                    --  Cuentas SIN saldo EM = (Fecha de Pago - Fecha Vencimiento)
                    IF (IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOFEPA(nuIdx) >
                       IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOFEVE(nuIdx)) THEN
                        -- Calcula la edad de la mora
                        nuEdadMora := trunc(IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOFEPA(nuIdx)) -
                                      trunc(IC_BOLisimProvGen.tmp_tbCuentasProd.CUCOFEVE(nuIdx));
                    ELSE
                        -- Fecha de Pago menor a Fecha de Vencimiento  EM = 0
                        nuEdadMora := 0;
                    END IF;

                END IF;

                pkgeneralservices.TraceData('nuEdadMora: ' || nuEdadMora);

                -- Asigna edad de mora a la cuenta de cobro
                IC_BOLisimProvGen.tmp_tbCuentasProd.CUCODIMO(nuIdx) := nuEdadMora;

            END LOOP;

        END IF;

        pkErrors.Pop;

    EXCEPTION
        WHEN LOGIN_DENIED
             OR ex.CONTROLLED_ERROR THEN
            pkErrors.pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            pkErrors.pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
            pkErrors.pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

    END GetAccountsByProduct;

    /***********************************************************************
    Propiedad Intelectual de Open International Systems (c).
    Procedure     : GetLisimDetail

    Descripcion     :  Obtiene el detalle LISIM para calcular la Provisi?n

    Parametros     :    Descripcion
        inuProducto     Producto


    Autor    : Claudia Liliana Rodr?guez
    Fecha    : 27-03-2012

    Historia de Modificaciones
    Fecha       IDEntrega

    02-04-2014  aesguerra.3551
    Se modifica encabezado para recibir la fecha de procesamiento como entrada

    01-10-2012  gduque.SAO183760
    Se modifica:
            - <GetQuotMaxDife>
            - <GetFinPercofUsedQuo>

    12-09-2012  gduque.SAO190015
    Se modifica los m?todos:
            - <fnuGetDaysOnDefault>
            - <fnuGetPromtriDaysOnDef>
            - <GetQuotMaxDife>
            - <GetPromMaxSemDaysOnDef>
    Se  elimina el parametro idtFecProc.

    29-08-2012  gduqueSAO189287
    Se modifica para corregir ortografia del mensaje de error cuando
    se calcula la Probabilidad de Cumplimiento.
    Se modifica los metodos <fnuGetDaysOnDefault> y <GetQuotMaxDife>.

    16-08-2012  gduqueSAO188626
    Se modifica el metodo <GetDaysOnDefault>

    13-08-2012  gduqueSAO188355
    Se modifica los metodos <GetFinPercofUsedQuo> y <GetPromMaxSemDaysOnDef>

    27-03-2012 crodriguezSAO180613
    creacion
    ***********************************************************************/

    PROCEDURE GetLisimDetail
    (
        inuProducto    IN servsusc.sesunuse%TYPE,
        idtProcessDate IN DATE
    )

     IS

        -- D?as de Mora
        nuVarDiMo ic_confpuvl.copvliin%TYPE;
        -- M?ximo Anual Mora
        nuMxAnMor ic_confpuvl.copvliin%TYPE;
        -- M?ximo Semestral Mora
        nuMxSmMor ic_confpuvl.copvliin%TYPE;
        -- Promedio Semestral Mora
        nuPrSmMor ic_confpuvl.copvliin%TYPE;
        -- Promedio Trimestral Mora
        nuPrTrMor ic_confpuvl.copvliin%TYPE;
        -- Mora Cero (0) Anual
        nuCeAnMor ic_confpuvl.copvliin%TYPE;
        -- Cupo Aprobado SMLV
        nuCupAproSMLV ic_confpuvl.copvliin%TYPE;
        -- Cupo Aprobado
        nuCupApro ge_indicator_values.indicator_value%TYPE;
        -- Saldo Pendiente de Diferidos
        nuSaPeDif diferido.difesape%TYPE;
        -- Cuota M?xima
        nuCuotMax ic_confpuvl.copvliin%TYPE;
        -- Porcentaje Cupo Usado Final
        nuPrCuFin ic_confpuvl.copvliin%TYPE;
        -- Intercept
        nuInterce ic_confpuvl.copvliin%TYPE;
        -- Perdida Cumplimiento
        nuPerCum ic_confpuvl.copvliin%TYPE;
        -- Contiene la Suma de los puntajes
        nuFactor NUMBER;
        -- Diferidos por Producto
        tmpDifexProd ic_bclisimprovgen.tytbDifexProd;
        -- Registro Servicios por suscripci?n
        rcServsusc Servsusc%ROWTYPE;

        --Nuevas variables TEAM 571

        -- Contador Mora 1-30 d?as  en el ultimo a?o
        nuConMUA NUMBER(4);
        --Contador Mora 1-30 d?as en el ultimo Semestre
        nuConMUS NUMBER(4);
        --Contador Mora Mayor a 60 d?as Semestral
        nuConMMS NUMBER(4);
        --Mora M?xima en el ultimo Trimestre
        nuMorMUT NUMBER(4);
        --Cupo Usado
        nuCupoUsado ic_cartprov.caprsape%TYPE;
        --Saldo Final
        nuSalFin ic_cartprov.caprsape%TYPE;
        --Porcentaje de utilizacion
        nuPorUti ic_detlisim.delipout%TYPE;
        --Cuentas de cobro con saldo
        nuCuenSald NUMBER(4);

        /***********************************************************************
            Propiedad Intelectual de Open International Systems (c).
            Procedure     : fnuGetDaysOnDefault

            Descripcion     : Retorna Edad de Mora Max de las cuentas de cobro del
                              producto

            Parametros     :  Descripcion
                inuProducto   Producto


            Autor    : Claudia Liliana Rodr?guez
            Fecha    : 27-03-2012

            Historia de Modificaciones
            Fecha       IDEntrega

            21-05-2014  aesguerra.3551
            Se modifica para que tome la fecha de procesamiento
        en lugar de la fecha final de procesamiento

            12-09-2012  gduque.SAO190015
            Se elimina el parametro idtFechProc

            25-08-2012  gduqueSAO189287
            Se obtiene edad mora para el ultima dia del mes anterior.

            16-08-2012  gduqueSAO188626
            Se obtiene la edad de mora maxima  del producto.

            27-03-2012 crodriguezSAO180613
            creacion
            ***********************************************************************/

        FUNCTION fnuGetDaysOnDefault(inuProducto IN servsusc.sesunuse%TYPE)
            RETURN NUMBER IS
            -- M?ximo Dias de Mora
            nuMxDimo NUMBER := 0;

        BEGIN

            pkErrors.Push('IC_BOLisimProvGen.GetLisimDetail.fnuGetDaysOnDefault');
            pkgeneralservices.TraceData('inuProducto: ' || inuProducto);
            pkgeneralservices.TraceData('idtFechProc: ' ||
                                        to_char(idtProcessDate));

            -- Retorna los d?as de mora del producto.
            nuMxDimo := IC_BCLisimProvGen.fnuDaysOnDefByProduct(idtProcessDate, inuProducto);

            pkErrors.Pop;

            RETURN nuMxDimo;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END fnuGetDaysOnDefault;

        /***********************************************************************
        Propiedad Intelectual de Open International Systems (c).
        Procedure     : fnuGetPromtriDaysOnDef

        Descripcion     :  Retorna Edad de Mora promedio de las Cuentas de Cobro
                           del los ?ltimos 3 meses

        Parametros     :    Descripcion
            inuProducto     Producto
            idtFechCont     Fecha de Procesamiento

        Autor    : Claudia Liliana Rodr?guez
        Fecha    : 27-03-2012

        Historia de Modificaciones
        Fecha       IDEntrega

        25-01-2014 eurbano.SAO230831
        Se modifica para recorrer la tabla tmp_tbCuentasProd, solo si tiene
        cuentas.

        12-09-2012  gduque.SAO190015
        Se elimina el parametro idtFechProc

        27-03-2012 crodriguezSAO180613
        creacion
        ***********************************************************************/

        FUNCTION fnuGetPromtriDaysOnDef(inuProducto IN servsusc.sesunuse%TYPE)
            RETURN NUMBER IS
            -- M?ximo Dias de Mora
            nuTriDimo NUMBER;
            -- Promedio d?as de Mora
            nuProDimo NUMBER;
            -- Cantidad de Cuentas
            nuCtdCue NUMBER;
            -- Fecha 3 meses atras a la fecha de ejecuci?n
            dtFchTri DATE;

        BEGIN

            pkErrors.Push('IC_BOLisimProvGen.GetLisimDetail.fnuGetPromtriDaysOnDef');
            nuProDimo := 0;
            nuTriDimo := 0;
            nuCtdCue  := 0;
            dtFchTri  := add_months(IC_BOLisimProvGen.dtFinishDate, -3);

            -- Obtiene la edad de mora m?xima ?ltimos 3 meses
            IF (IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.count > 0) THEN

                FOR nuidx IN IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.first .. IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.last
                LOOP
                    IF (IC_BOLisimProvGen.tmp_tbCuentasProd.cucofege(nuidx) >=
                       dtFchTri) THEN

                        nuTriDimo := nuTriDimo +
                                     IC_BOLisimProvGen.tmp_tbCuentasProd.cucodimo(nuidx);
                        nuCtdCue  := nuCtdCue + 1;

                    END IF;
                END LOOP;
            END IF;

            IF (nuCtdCue <> 0) THEN
                nuProDimo := nuTriDimo / nuCtdCue;
            END IF;

            RETURN nuProDimo;

            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END fnuGetPromtriDaysOnDef;

        /***********************************************************************
        Propiedad Intelectual de Open International Systems (c).
        Procedure     : GetlimitApprovSMMLV

        Descripcion     :  Obtiene el Cupo Aprobado en SMMLV

        Parametros     :    Descripcion
            inuSaldPend     Saldo Pendiente
            inuCupoApro     Cupo Aprobado

        Retorna        :    Descripci?n
            onuCupoUsado      Cupo Usado


        Autor    : Claudia Liliana Rodr?guez
        Fecha    : 27-03-2012

        Historia de Modificaciones
        Fecha       IDEntrega

        02-04-2014  aesguerra.3551
        Se modifica el llamado a LD_BONONBANKFINANCING.GetTotalQuotaWithOutExtra
        para que reciba la fecha de procesamiento como entrada

        25-01-2014  eurbano.SAO230831
        Se modifica para recorrer los registros de tb_ConfSMMLV con los
        indicadores solo si la tabla est? llena.

        01-10-2012  gduque.SAO183760
        Se invoca el m?todo <GetTotalQuotaWithOutExtra>

        27-03-2012 crodriguezSAO180613
        creacion
        ***********************************************************************/

        PROCEDURE GetLimitApprovSMMLV
        (
            inuProducto      IN servsusc.sesunuse%TYPE,
            onuCupoAproSMMLV OUT ic_detlisim.delicuap%TYPE,
            onuCupoApro      OUT ge_indicator_values.indicator_value%TYPE
        ) IS
            -- Fecha Aprobaci?n
            dtFechaApro DATE;

            -- Indicador SMLV
            cnuIndicator CONSTANT ge_indicator.indicator_id%TYPE := 1;

            -- Salario Minimo Legal Vigente
            nuSMMLV ge_indicator_values.indicator_value%TYPE;

            -- Mes Aprobaci?n
            nuMesApro ge_indicator_values.indicator_month%TYPE;
            -- A?o Aprobaci?n
            nuAnoApro ge_indicator_values.indicator_year%TYPE;

            -- Registro Cupo Aprobado
            rcIndicadorValues dage_indicator_values.styGE_indicator_values;

        BEGIN

            pkErrors.Push('IC_BOLisimProvGen.GetLimitApprovSMMLV');

            -- Obtener Cupo Aprobado
            td('Suscripci?n ' || rcServsusc.sesususc);

            LD_BONONBANKFINANCING.GetTotalQuotaWithOutExtra(rcServsusc.sesususc, onuCupoApro, dtFechaApro, idtProcessDate);
            td('Cupo Aprobado ' || onuCupoApro);

            td('Fecha Aprobaci?n ' || dtFechaApro);

            -- Inicializar Cupo Aprobado SMMLV
            onuCupoAproSMMLV := 0;

            -- Si CupoAprobado diferente CERO
            IF (onuCupoApro <> 0) THEN

                -- Si configuraci?n en memoria
                IF (IC_BOLisimProvGen.tb_ConfSMMLV.Indicator_Value_Cons.first IS NULL) THEN

                    -- Obtener configuraci?n de SMLV
                    IC_BCLisimProvGen.GetIndicatorValueSMMLV(cnuIndicator, to_char(dtFechaApro, 'YYYY'), IC_BOLisimProvGen.tb_ConfSMMLV);
                END IF;

                -- Obtener Mes
                nuMesApro := to_char(dtFechaApro, 'MM');

                -- Obtener A?o
                nuAnoApro := to_char(dtFechaApro, 'YYYY');

                /*se valida si la tabla tiene datos*/
                IF (IC_BOLisimProvGen.tb_ConfSMMLV.Indicator_Id.count > 0) THEN
                    -- Recorre registros obtenidos de configuraci?n y almacena en tabla global
                    FOR nuidx IN IC_BOLisimProvGen.tb_ConfSMMLV.Indicator_Id.first .. IC_BOLisimProvGen.tb_ConfSMMLV.Indicator_Id.last
                    LOOP

                        pkgeneralservices.TraceData('Indicador ' ||
                                                    IC_BOLisimProvGen.tb_ConfSMMLV.Indicator_Value_Cons(nuidx) ||
                                                    ' A?o: ' ||
                                                    IC_BOLisimProvGen.tb_ConfSMMLV.Indicator_Year(nuidx) ||
                                                    ' Mes: ' ||
                                                    IC_BOLisimProvGen.tb_ConfSMMLV.Indicator_Month(nuidx) ||
                                                    ' SMMLV: ' ||
                                                    IC_BOLisimProvGen.tb_ConfSMMLV.Indicator_Value(nuidx));

                        -- Si A?oAprobaci?n es igual A?oIndicador
                        IF (nuAnoApro =
                           IC_BOLisimProvGen.tb_ConfSMMLV.Indicator_Year(nuidx)) THEN

                            -- Si MesAprobaci?n mayor o igual MesIndicador
                            IF (nuMesApro >=
                               IC_BOLisimProvGen.tb_ConfSMMLV.Indicator_Month(nuidx)) THEN
                                -- Obtener SMMLV
                                nuSMMLV := IC_BOLisimProvGen.tb_ConfSMMLV.Indicator_Value(nuidx);
                                -- Salir del Loop
                                EXIT;
                            END IF;

                            -- Si MesAprobaci?n menor o igual MesIndicador
                            IF (nuMesApro <=
                               IC_BOLisimProvGen.tb_ConfSMMLV.Indicator_Month(nuidx)) THEN
                                -- Obtener SMMLV
                                nuSMMLV := IC_BOLisimProvGen.tb_ConfSMMLV.Indicator_Value(nuidx);

                            END IF;
                        END IF;
                    END LOOP;
                END IF; /*finaliza validaci?n de conteo de registros*/
                pkgeneralservices.TraceData('onuCupoApro: ' || onuCupoApro);
                pkgeneralservices.TraceData('dtFechaApro: ' || dtFechaApro);
                pkgeneralservices.TraceData('nuSMMLV: ' || nuSMMLV);

                -- Si SMMLV diferente CERO
                IF (nuSMMLV <> 0) THEN

                    -- Obtener Cupo Aprobado en SMLV
                    onuCupoAproSMMLV := onuCupoApro / nuSMMLV;

                ELSE
                    -- Obtener Cupo Aprobado en SMLV
                    onuCupoAproSMMLV := 0;

                END IF;

                pkgeneralservices.TraceData('onuCupoAproSMMLV: ' ||
                                            onuCupoAproSMMLV);

            END IF; /*finaliza validaci?n de cupo aprobado <> 0*/
            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END GetLimitApprovSMMLV;

        /***********************************************************************
        Propiedad Intelectual de Open International Systems (c).
        Procedure     : GetQuotMaxDife

        Descripcion     :  Obtiene el n?mero de la cuotas m?xima con saldo pendiente
                           y el saldo pendiente de los Diferidos en el ?ltimo a?o

        Parametros     :    Descripcion
            inuProducto     Producto
            idtFechCont     Fecha de Procesamiento

        Retorna        :    Descripci?n
           onucuotamax      Cantidad de cuota m?xima
           onuSalPenDif     Saldo Pendiente Diferidos

        Autor    : Claudia Liliana Rodr?guez
        Fecha    : 27-03-2012

        Historia de Modificaciones
        Fecha       IDEntrega

        01-10-2012  gduque.SAO183760
        Se elimina el parametro onuSalPenDif

        12-09-2012  gduque.SAO190015
        Se elimina el parametro idtFechProc

        29-08-2012  gduqueSAO189287
        Se elimina los parametros fechas para invocar el metodo GetDifeByProduct

        27-03-2012 crodriguezSAO180613
        creacion
        ***********************************************************************/

        PROCEDURE GetQuotMaxDife
        (
            inuProducto IN servsusc.sesunuse%TYPE,
            onucuotamax OUT ic_detlisim.delicumx%TYPE
        ) IS
            -- Fecha 3 meses atras a la fecha de ejecuci?n
            dtFchTri DATE;
        BEGIN

            pkErrors.Push('IC_BOLisimProvGen.GetLisimDetail.GetQuotMaxDife');
            -- Cuota M?xima
            onucuotamax := 0;

            tmpDifexProd.difecodi.delete;
            tmpDifexProd.difenucu.delete;
            tmpDifexProd.difesape.delete;
            tmpDifexProd.difesign.delete;

            -- Obtener Diferidos
            ic_bclisimprovgen.GetDifeByProduct(inuProducto, tmpDifexProd);

            -- Si existen diferidos
            IF (tmpDifexProd.difenucu.first IS NOT NULL) THEN

                FOR nuidx IN tmpDifexProd.difenucu.first .. tmpDifexProd.difenucu.last
                LOOP

                    IF (tmpDifexProd.difesape(nuidx) > 0) THEN

                        -- Obtiene cuota m?xima de diferidos con Saldo Pendiente
                        IF (tmpDifexProd.difenucu(nuidx) > onucuotamax) THEN
                            onucuotamax := tmpDifexProd.difenucu(nuidx);
                        END IF;

                    END IF;

                END LOOP;

            END IF;

            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END GetQuotMaxDife;

        /***********************************************************************
            Propiedad Intelectual de Open International Systems (c).
            Procedure     : GetFinPercofUsedQuo

            Descripcion     :  Obtiene el porcentaje de cupo usado final
                               Saldo Pendiente Dif / Cupo Aprobado

            Parametros     :    Descripcion
                inuSaldPend     Saldo Pendiente
                inuCupoApro     Cupo Aprobado

            Retorna        :    Descripci?n
                onuCupoUsado      Cupo Usado


            Autor    : Claudia Liliana Rodr?guez
            Fecha    : 27-03-2012

            Historia de Modificaciones
            Fecha       IDEntrega

            03-06-2014  aesguerra.3722
            Se modifica para calcular el porcentaje de cupo usado a partir de la deuda a la fecha de
        provisi?n para los conceptos de brilla.

            11-10-2013  sgomez.SAO219973
            Se modifica el tipo de variable de <inuCupoApro> para evitar error
            "ORA-06502: number precision too large".
            Anteriormente se defin?a como tipo de dato de "porcentaje de cupo"
            pero en realidad tiene un valor de un cupo.

            01-10-212   gduque.SAO183760
            Se invoca el m?todo <availableQuota>  y se elimina el parametro
            inuSaldPend

            13-08-2012  gduqueSAO188355
            Se modifica el tipo de dato del parametro onuCupoUsado.

            27-03-2012 crodriguezSAO180613
            creacion
            ***********************************************************************/

        PROCEDURE GetFinPercofUsedQuo
        (
            inuCupoApro      IN ic_cartprov.caprsape%TYPE,
            onuPorcCupoUsado OUT ic_detlisim.delicuuf%TYPE
        ) IS

            nuCupoUsado ic_cartprov.caprsape%TYPE := 0;

        BEGIN

            pkErrors.Push('IC_BOLisimProvGen.GetLisimDetail.GetFinPercofUsedQuo');

            ut_trace.trace('Cupo aprobado ' || inuCupoApro, 1);

            nuCupoUsado := IC_BCLisimProvGen.fnuGetUsedQuotaByProdDate(inuProducto, idtProcessDate);

            ut_trace.trace('Cupo usado ' || nuCupoUsado, 1);

            IF NOT (inuCupoApro > 0) THEN
                onuPorcCupoUsado := 0;
            ELSIF (nuCupoUsado < inuCupoApro) THEN
                onuPorcCupoUsado := (nuCupoUsado / inuCupoApro) * 100;
            ELSE
                onuPorcCupoUsado := 100;
            END IF;

            onuPorcCupoUsado := nvl(onuPorcCupoUsado, 0);

            ut_trace.trace('Resultado: ' || onuPorcCupoUsado, 1);

            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END GetFinPercofUsedQuo;

        /***********************************************************************
        Propiedad Intelectual de Open International Systems (c).
        Procedure     : GetMaxZerYearDaysOnDef

        Descripcion     :  Retorna Edad de Mora m?xima y cantidad de cuentas con
                           mora cero del ?ltimo a?o

        Parametros     :    Descripcion
            inuProducto     Producto

        Retorna        :    Descripcion
            onuMxDimo     Edad de Mora M?xima del ?ltimo a?o
            onuCeDimo     Cantidad de periodos con Edad de Mora cero


        Autor    : Claudia Liliana Rodr?guez
        Fecha    : 27-03-2012

        Historia de Modificaciones
        Fecha       IDEntrega
        27-02-2018  rcolpasSAO2001692
        Se modifica para que valide primero si el periodo consultado no sea nulo

        11-06-2014  aesguerra.3811
        Se modifica para calcular la cantidad de periodos con mora cero en lugar de la cantidad de
        cuentas de cobro con mora cero

        27-03-2012 crodriguezSAO180613
        creacion
        ***********************************************************************/

        PROCEDURE GetMaxZerYearDaysOnDef
        (
            inuProducto IN servsusc.sesunuse%TYPE,
            onuMxDimo   OUT NUMBER,
            onuCeDimo   OUT NUMBER
        )

         IS

            TYPE tytbPeriodos IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

            tbPeriodos tytbPeriodos;

            nuPeriodo factura.factpefa%TYPE;

            nuIdx NUMBER;

        BEGIN

            pkErrors.Push('IC_BOLisimProvGen.GetMaxZerYearDaysOnDef');
            onuMxDimo := 0;
            onuCeDimo := 0;

            FOR nuidx IN IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.first .. IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.last
            LOOP

                nuPeriodo := IC_BOLisimProvGen.tmp_tbCuentasProd.cucopefa(nuidx);

                --Caso 200-1692 Se Modifica para que valida si el perio no es nulo
                IF nuPeriodo IS NOT NULL THEN

                  IF NOT tbPeriodos.exists(nuPeriodo) THEN
                      tbPeriodos(nuPeriodo) := 0;
                  END IF;

                  -- Obtiene la edad de mora m?xima
                  IF (IC_BOLisimProvGen.tmp_tbCuentasProd.cucodimo(nuidx) >
                     onuMxDimo) THEN
                      onuMxDimo := IC_BOLisimProvGen.tmp_tbCuentasProd.cucodimo(nuidx);
                  END IF;

                  -- Obtiene la cantidad de cuentas con edad de mora mayor a cero por periodo
                  IF (IC_BOLisimProvGen.tmp_tbCuentasProd.cucodimo(nuidx) > 0) THEN

                      tbPeriodos(nuPeriodo) := tbPeriodos(nuPeriodo) + 1;

                  END IF;

                END IF;
            END LOOP;

            /*Si se encontraron cuentas de cobro*/
            IF tbPeriodos.count > 0 THEN

                /*
                        Se recorren los periodos de facturaci?n para validar cuantos de ellos no tienen
                        edad de mora mayor a cero
                */
                nuIdx := tbPeriodos.first;

                LOOP
                    EXIT WHEN nuIdx IS NULL;

                    IF tbPeriodos(nuIdx) = 0 THEN
                        onuCeDimo := onuCeDimo + 1;
                    END IF;

                    nuIdx := tbPeriodos.next(nuIdx);

                END LOOP;

            END IF;

            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END GetMaxZerYearDaysOnDef;

        /***********************************************************************
        Propiedad Intelectual del de Grupo Promigas.
        Procedure     : fnuGetMoraMaxtriDaysOnDef

        Descripcion     :  Retorna Edad de Mora maxima  de los ?ltimos 3 meses

        Parametros     :    Descripcion
            inuProducto     Producto

        Retorna       :     Descripci?n
            onuMaxDimo      D?as de Mora m?ximo de los ?ltimos 3 meses

        Autor    : Jos? Lizardo Castro
        Fecha    : 15-09-2014

        Historia de Modificaciones
        Fecha       IDEntrega

        creacion
        15-09-2014  JLizardoCastro
        ***********************************************************************/

        PROCEDURE fnuGetMoraMaxtriDaysOnDef
        (
            inuProducto IN servsusc.sesunuse%TYPE,
            onuMaxDimo  OUT NUMBER
        ) IS
            -- M?ximo Dias de Mora
            nuMxDimo NUMBER;
            -- Cantidad de Cuentas
            nuCantCu NUMBER;
            -- Fecha 3 meses atras a la fecha de contabilizaci?n
            dtFchSem DATE;
        BEGIN
            ut_trace.trace('-- PASO 10. [JOSELC - fnuGetMoraMaxtriDaysOnDef]-entra', 1);

            pkErrors.Push('IC_BOLisimProvGen.GetLisimDetail.fnuGetMoraMaxtriDaysOnDef');
            nuMxDimo := 0;
            dtFchSem := add_months(IC_BOLisimProvGen.dtFinishDate, -3);

            -- Obtiene la edad de mora m?xima ?ltimos 3 meses
            FOR nuidx IN IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.first .. IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.last
            LOOP
                IF (IC_BOLisimProvGen.tmp_tbCuentasProd.cucofege(nuidx) >=
                   dtFchSem) THEN
                    IF (IC_BOLisimProvGen.tmp_tbCuentasProd.cucodimo(nuidx) >
                       nuMxDimo) THEN
                        nuMxDimo := IC_BOLisimProvGen.tmp_tbCuentasProd.cucodimo(nuidx);
                    END IF;
                END IF;
            END LOOP;

            onuMaxDimo := nvl(nuMxDimo, 0);

            pkErrors.Pop;

            ut_trace.trace('-- PASO 10. [JOSELC - fnuGetMoraMaxtriDaysOnDef]-sale', 1);

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END fnuGetMoraMaxtriDaysOnDef;

        /***********************************************************************
        Propiedad Intelectual del de Grupo Promigas.
        Procedure     : fnuGetContSemDaysOnDef

        Descripcion     :  Retorna el contador de  Mora 1-30 d?as en el ?ltimo Semestre.

        Parametros     :    Descripcion
            inuProducto     Producto

        Retorna       :     Descripci?n
            onuConMor     Contador de mora de 1-30 d?as en el ultimo semestre

        Autor    : Jos? Lizardo Castro
        Fecha    : 16-09-2014

        Historia de Modificaciones
        Fecha       IDEntrega
        27-02-2018  rcolpasSAO2001692
        Se modifica para que valide primero si el periodo consultado no sea nulo

        creacion
        16-09-2014  JLizardoCastro
        ***********************************************************************/

        PROCEDURE fnuGetContSemDaysOnDef
        (
            inuProducto IN servsusc.sesunuse%TYPE,
            onuConMora  OUT NUMBER
        ) IS
            TYPE tytbPeriMora IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

            tbPeriMora tytbPeriMora;

            nuPeriodo factura.factpefa%TYPE;

            nuEdad30d NUMBER := 30; --variable para comparar si el cucodimo es menor a 30 dias
            nuIdx     NUMBER;
            -- Fecha 6 meses atras a la fecha de contabilizaci?n
            dtFchSem DATE;

        BEGIN

            ut_trace.trace('-- PASO 11. [JOSELC - fnuGetContSemDaysOnDef]-entra', 1);

            pkErrors.Push('IC_BOLisimProvGen.GetLisimDetail.fnuGetContSemDaysOnDef');
            onuConMora := 0;
            dtFchSem   := add_months(IC_BOLisimProvGen.dtFinishDate, -6);

            FOR nuidx IN IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.first .. IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.last
            LOOP
                IF (IC_BOLisimProvGen.tmp_tbCuentasProd.cucofege(nuidx) >=
                   dtFchSem) THEN
                    nuPeriodo := IC_BOLisimProvGen.tmp_tbCuentasProd.cucopefa(nuidx);

                    --Caso 200-1692 Se Modifica para que valida si el perio no es nulo
                    IF nuPeriodo IS NOT NULL THEN

                      IF NOT tbPeriMora.exists(nuPeriodo) THEN
                          tbPeriMora(nuPeriodo) := 0;
                      END IF;
                      -- Obtiene las edades de mora entre 1-30
                      IF (IC_BOLisimProvGen.tmp_tbCuentasProd.cucodimo(nuidx) >= 1 AND
                         IC_BOLisimProvGen.tmp_tbCuentasProd.cucodimo(nuidx) <=
                         nuEdad30d) THEN
                          tbPeriMora(nuPeriodo) := tbPeriMora(nuPeriodo) + 1;
                      END IF;

                    END IF;
                END IF;
            END LOOP;

            /*Si se encontraron cuentas de cobro con edad de mora entre 1-30*/
            IF tbPeriMora.count > 0 THEN

                /*
                        Se recorren los periodos de facturaci?n para validar cuantos de ellos tienen
                        edad de mora entre 1-30
                */
                nuIdx := tbPeriMora.first;

                LOOP
                    EXIT WHEN nuIdx IS NULL;

                    IF tbPeriMora(nuIdx) = 0 THEN
                        onuConMora := onuConMora + 1;
                    END IF;

                    nuIdx := tbPeriMora.next(nuIdx);

                END LOOP;

            END IF;

            pkErrors.Pop;
            ut_trace.trace('-- PASO 11. [JOSELC - fnuGetContSemDaysOnDef]-sale', 1);

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END fnuGetContSemDaysOnDef;

        /***********************************************************************
        Propiedad Intelectual del de Grupo Promigas.
        Procedure     : fnuGetContYearDaysOnDef

        Descripcion     :  Retorna el contador de  Mora 1-30 d?as en el ?ltimo a?o.

        Parametros     :    Descripcion
            inuProducto     Producto

        Retorna       :     Descripci?n
            onuConMor     Contador de mora de 1-30 d?as en el ultimo a?o

        Autor    : Jos? Lizardo Castro
        Fecha    : 16-09-2014

        Historia de Modificaciones
        Fecha       IDEntrega
        27-02-2018  rcolpasSAO2001692
        Se modifica para que valide primero si el periodo consultado no sea nulo

        creacion
        16-09-2014  JLizardoCastro
        ***********************************************************************/

        PROCEDURE fnuGetContYearDaysOnDef
        (
            inuProducto IN servsusc.sesunuse%TYPE,
            onuConMora  OUT NUMBER
        ) IS
            TYPE tytbPeriMora IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

            tbPeriMora tytbPeriMora;

            nuPeriodo factura.factpefa%TYPE;

            nuEdad30d NUMBER := 30; --variable para comparar si el cucodimo es menor a 30 dias
            nuIdx     NUMBER;
            -- Fecha 12 meses atras a la fecha de contabilizaci?n
            dtFchSem DATE;

        BEGIN

            ut_trace.trace('-- PASO 12. [JOSELC - fnuGetContYearDaysOnDef]-entra', 1);

            pkErrors.Push('IC_BOLisimProvGen.GetLisimDetail.fnuGetContYearDaysOnDef');
            onuConMora := 0;
            dtFchSem   := add_months(IC_BOLisimProvGen.dtFinishDate, -12);

            FOR nuidx IN IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.first .. IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.last
            LOOP
                IF (IC_BOLisimProvGen.tmp_tbCuentasProd.cucofege(nuidx) >=
                   dtFchSem) THEN
                    nuPeriodo := IC_BOLisimProvGen.tmp_tbCuentasProd.cucopefa(nuidx);

                    --Caso 200-1692 Se Modifica para que valida si el perio no es nulo
                    IF nuPeriodo IS NOT NULL THEN

                      IF NOT tbPeriMora.exists(nuPeriodo) THEN
                          tbPeriMora(nuPeriodo) := 0;
                      END IF;
                      -- Obtiene las edades de mora entre 1-30
                      IF (IC_BOLisimProvGen.tmp_tbCuentasProd.cucodimo(nuidx) >= 1 AND
                         IC_BOLisimProvGen.tmp_tbCuentasProd.cucodimo(nuidx) <=
                         nuEdad30d) THEN
                          tbPeriMora(nuPeriodo) := tbPeriMora(nuPeriodo) + 1;
                      END IF;

                    END IF;
                END IF;
            END LOOP;

            /*Si se encontraron cuentas de cobro con edad de mora entre 1-30*/
            IF tbPeriMora.count > 0 THEN

                /*
                        Se recorren los periodos de facturaci?n para validar cuantos de ellos tienen
                        edad de mora entre 1-30
                */
                nuIdx := tbPeriMora.first;

                LOOP
                    EXIT WHEN nuIdx IS NULL;

                    IF tbPeriMora(nuIdx) = 0 THEN
                        onuConMora := onuConMora + 1;
                    END IF;

                    nuIdx := tbPeriMora.next(nuIdx);

                END LOOP;

            END IF;

            pkErrors.Pop;
            ut_trace.trace('-- PASO 12. [JOSELC - fnuGetContYearDaysOnDef]-sale', 1);

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END fnuGetContYearDaysOnDef;

        /***********************************************************************
        Propiedad Intelectual del de Grupo Promigas.
        Procedure     : fnuGetContGreSemDaysOnDef

        Descripcion     :  Retorna el contador de  Mora mayor a 60 d?as en el ?ltimo semestre.

        Parametros     :    Descripcion
            inuProducto     Producto

        Retorna       :     Descripci?n
            onuConMor     Contador de mora mayor a 60 d?as en el ultimo semestre

        Autor    : Jos? Lizardo Castro
        Fecha    : 17-09-2014

        Historia de Modificaciones
        Fecha       IDEntrega
        27-02-2018  rcolpasSAO2001692
        Se modifica para que valide primero si el periodo consultado no sea nulo

        creacion
        17-09-2014  JLizardoCastro
        ***********************************************************************/

        PROCEDURE fnuGetContGreSemDaysOnDef
        (
            inuProducto IN servsusc.sesunuse%TYPE,
            onuConMora  OUT NUMBER
        ) IS

            TYPE tytbPeriMora IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

            tbPeriMora tytbPeriMora;

            nuPeriodo factura.factpefa%TYPE;

            nuEdad60d NUMBER := 60; --variable para comparar si el cucodimo es menor a 30 dias
            nuIdx     NUMBER;
            -- Fecha 6 meses atras a la fecha de contabilizaci?n
            dtFchSem DATE;

        BEGIN
            ut_trace.trace('-- PASO 13. [JOSELC - fnuGetContGreSemDaysOnDef]-entra', 1);

            pkErrors.Push('IC_BOLisimProvGen.GetLisimDetail.fnuGetContGreSemDaysOnDef');
            onuConMora := 0;
            dtFchSem   := add_months(IC_BOLisimProvGen.dtFinishDate, -6);

            FOR nuidx IN IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.first .. IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.last
            LOOP
                IF (IC_BOLisimProvGen.tmp_tbCuentasProd.cucofege(nuidx) >=
                   dtFchSem) THEN
                    nuPeriodo := IC_BOLisimProvGen.tmp_tbCuentasProd.cucopefa(nuidx);

                    --Caso 200-1692 Se Modifica para que valida si el perio no es nulo
                    IF nuPeriodo IS NOT NULL THEN

                      IF NOT tbPeriMora.exists(nuPeriodo) THEN
                          tbPeriMora(nuPeriodo) := 0;
                      END IF;
                      -- Obtiene las edades de mora mayor a 60
                      IF (IC_BOLisimProvGen.tmp_tbCuentasProd.cucodimo(nuidx) >=
                         nuEdad60d) THEN
                          tbPeriMora(nuPeriodo) := tbPeriMora(nuPeriodo) + 1;
                      END IF;

                    END IF;
                END IF;
            END LOOP;

            /*Si se encontraron cuentas de cobro con edad de mora mayor a 60*/
            IF tbPeriMora.count > 0 THEN

                /*
                        Se recorren los periodos de facturaci?n para validar cuantos de ellos tienen
                        edad de mora mayor 60
                */
                nuIdx := tbPeriMora.first;

                LOOP
                    EXIT WHEN nuIdx IS NULL;

                    IF tbPeriMora(nuIdx) = 0 THEN
                        onuConMora := onuConMora + 1;
                    END IF;

                    nuIdx := tbPeriMora.next(nuIdx);

                END LOOP;

            END IF;

            pkErrors.Pop;
            ut_trace.trace('-- PASO 13. [JOSELC - fnuGetContGreSemDaysOnDef]-sale', 1);

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END fnuGetContGreSemDaysOnDef;

        /***********************************************************************
        Propiedad Intelectual de Open International Systems (c).
        Procedure     : GetPromMaxSemDaysOnDef

        Descripcion     :  Retorna Edad de Mora m?xima y Promedio de las Cuentas
                           de Cobro del los ?ltimos 6 meses

        Parametros     :    Descripcion
            inuProducto     Producto
            idtFechCont     Fecha de Procesamiento


        Retorna       :     Descripci?n
            onuMaxDimo      D?as de Mora m?ximo de los ?ltimos 6 meses
            onuProDimo      D?as de Mora promedio de los ?ltimos 6 meses

        Autor    : Claudia Liliana Rodr?guez
        Fecha    : 27-03-2012

        Historia de Modificaciones
        Fecha       IDEntrega

        12-09-2012  gduque.SAO190015
        Se elimina el parametro idtFechProc

        19-03-2012  gduqueSAO188355
        Se inicializa la variable onuProDimo;

        27-03-2012 crodriguezSAO180613
        creacion
        ***********************************************************************/

        PROCEDURE GetPromMaxSemDaysOnDef
        (
            inuProducto IN servsusc.sesunuse%TYPE,
            onuMaxDimo  OUT NUMBER,
            onuProDimo  OUT NUMBER
        ) IS
            -- M?ximo Dias de Mora
            nuMxDimo NUMBER;
            -- Promedio D?as de Mora
            nuPrDimo NUMBER;
            -- Cantidad de Cuentas
            nuCantCu NUMBER;
            -- Fecha 6 meses atras a la fecha de contabilizaci?n
            dtFchSem DATE;
        BEGIN

            pkErrors.Push('IC_BOLisimProvGen.GetLisimDetail.GetPromMaxSemDaysOnDef');
            nuMxDimo   := 0;
            nuPrDimo   := 0;
            nuCantCu   := 0;
            onuProDimo := 0;

            dtFchSem := add_months(IC_BOLisimProvGen.dtFinishDate, -6);

            -- Obtiene la edad de mora m?xima ?ltimos 6 meses
            FOR nuidx IN IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.first .. IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.last
            LOOP
                IF (IC_BOLisimProvGen.tmp_tbCuentasProd.cucofege(nuidx) >=
                   dtFchSem) THEN
                    IF (IC_BOLisimProvGen.tmp_tbCuentasProd.cucodimo(nuidx) >
                       nuMxDimo) THEN
                        nuMxDimo := IC_BOLisimProvGen.tmp_tbCuentasProd.cucodimo(nuidx);
                    END IF;
                    nuCantCu := nuCantCu + 1;
                    nuPrDimo := nuPrDimo +
                                IC_BOLisimProvGen.tmp_tbCuentasProd.cucodimo(nuidx);
                END IF;
            END LOOP;

            onuMaxDimo := nuMxDimo;

            IF (nuCantCu <> 0) THEN
                onuProDimo := nuPrDimo / nuCantCu;
            END IF;

            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END GetPromMaxSemDaysOnDef;

    BEGIN
        ut_trace.trace('-- PASO 14. [JOSELC - detalle lisim]-entra', 1);

        pkErrors.Push('IC_BOLisimProvGen.GetLisimDetail');

        dbms_output.put_line('inuProducto ' || inuProducto);
        dbms_output.put_line('idtProcessDate ' || idtProcessDate);

        --Valida que el producto tenga cuentas de cobro con saldo
        nuCuenSald := IC_BCLisimProvGen.fnuGetAccoutsBalance(inuProducto);

        dbms_output.put_line('nuCuenSald ' || nuCuenSald);

        IF ( /*nuCuenSald > 0 OR */
            fblAplicaEntrega(csbBSS_FAC_LFG_10031316)) THEN
            ut_trace.trace('-- PASO 15. [JOSELC - detalle lisim]-entra validacion factura cero', 1);
            -- Obtiene registro del servicio
            rcServsusc := pktblServsusc.frcGetRecord(inuProducto);

            -- Verifica si el producto es dependiente
            IF (rcServsusc.sesusesb <> pkconstante.NULLNUM) THEN

                -- Obtiene registro de Producto Base
                rcServsusc := pktblServsusc.frcGetRecord(rcServsusc.sesusesb);
            END IF;

            -- Obtiene  las variables LISIM [1-10]

            -- D?as de Mora
            nuVarDiMo := fnuGetDaysOnDefault(inuProducto);
            dbms_output.put_line('nuVarDiMo ' || nuVarDiMo);
            -- Promedio Trimestral Mora
            nuPrTrMor := fnuGetPromtriDaysOnDef(inuProducto);
            dbms_output.put_line('nuPrTrMor ' || nuPrTrMor);
            -- Cupo Aprobado
            GetLimitApprovSMMLV(inuProducto, nuCupAproSMLV, nuCupApro);
            dbms_output.put_line('nuCupAproSMLV,nuCupApro ' || nuCupAproSMLV ||
                                 ' , ' || nuCupApro);
            -- Cuota M?xima y Saldo Pendiente de Diferidos
            GetQuotMaxDife(inuProducto, nuCuotMax);
            dbms_output.put_line('nuCuotMax ' || nuCuotMax);
            -- Porcentaje Cupo Usado Final
            GetFinPercofUsedQuo(nuCupApro, nuPrCuFin);
            dbms_output.put_line('nuCupApro,nuPrCuFin ' || nuCupApro || ' , ' ||
                                 nuPrCuFin);
            -- Intercept
            nuInterce := ge_boconstants.cnuNULLNUM;
            --D?as de Mora Maximo anual y Periodos con Mora cero
            GetMaxZerYearDaysOnDef(inuProducto, nuMxAnMor, nuCeAnMor);
            dbms_output.put_line('nuMxAnMor,nuCeAnMor ' || nuMxAnMor || ' , ' ||
                                 nuCeAnMor);
            -- Dias de Mora Maximo y Promedio semestral
            GetPromMaxSemDaysOnDef(inuProducto, nuMxSmMor, nuPrSmMor);
            dbms_output.put_line('nuMxSmMor,nuPrSmMor ' || nuMxSmMor || ' , ' ||
                                 nuPrSmMor);

            --Nuevas variables TEAM 571

            --Mora M?xima en el ultimo Trimestre
            fnuGetMoraMaxtriDaysOnDef(inuProducto, nuMorMUT);
            dbms_output.put_line('nuMorMUT ' || nuMorMUT);

            --Contador Mora 1-30 d?as en el ultimo Semestre
            fnuGetContSemDaysOnDef(inuProducto, nuConMUS);
            dbms_output.put_line('nuConMUS ' || nuConMUS);

            --Contador Mora 1-30 d?as  en el ultimo a?o
            fnuGetContYearDaysOnDef(inuProducto, nuConMUA);
            dbms_output.put_line('nuConMUA ' || nuConMUA);
            ut_trace.trace('-- PASO 19. [JOSELC - detalle lisim]-sale variable 3', 1);
            --Contador Mora Mayor a 60 d?as Semestral
            fnuGetContGreSemDaysOnDef(inuProducto, nuConMMS);
            dbms_output.put_line('nuConMMS ' || nuConMMS);
            ut_trace.trace('-- PASO 20. [JOSELC - detalle lisim]-sale variable 3', 1);
            --Cupo Usado

            nuCupoUsado := IC_BCLisimProvGen.fnuGetUsedQuotaByProdDate(inuProducto, idtProcessDate);
            dbms_output.put_line('nuCupoUsado ' || nuCupoUsado);
            ut_trace.trace('-- PASO 21. [JOSELC - detalle lisim]-Variables calculo saldo final-- ' ||
                           inuProducto || '--CupoUsado--' || nuCupoUsado ||
                           '--cupoAprobado--' || nuCupApro, 1);

            nuSalfin := nuCupApro - nuCupoUsado;
            dbms_output.put_line('nuSalfin ' || nuSalfin);
            ut_trace.trace('-- PASO 30. [JOSELC - detalle lisim]-Saldo final ' ||
                           nuSalfin, 1);

            pkgeneralservices.TraceData('nuVarDiMo: ' || nuVarDiMo);
            pkgeneralservices.TraceData('nuPrTrMor: ' || nuPrTrMor);
            pkgeneralservices.TraceData('nuCupApro: ' || nuCupApro);
            pkgeneralservices.TraceData('nuCuotMax: ' || nuCuotMax);
            pkgeneralservices.TraceData('nuPrCuFin: ' || nuPrCuFin);
            pkgeneralservices.TraceData('nuMxAnMor: ' || nuMxAnMor);
            pkgeneralservices.TraceData('nuCeAnMor: ' || nuCeAnMor);
            pkgeneralservices.TraceData('nuMxSmMor: ' || nuMxSmMor);
            pkgeneralservices.TraceData('nuPrSmMor: ' || nuPrSmMor);
            --TEAM 571
            pkgeneralservices.TraceData('nuMorMUT: ' || nuMorMUT);
            pkgeneralservices.TraceData('nuConMUS: ' || nuConMUS);
            pkgeneralservices.TraceData('nuConMUA: ' || nuConMUA);
            pkgeneralservices.TraceData('nuConMMS: ' || nuConMMS);
            pkgeneralservices.TraceData('nuPorUti: ' || nuPorUti);

            dbms_output.put_line('nuVarDiMo: ' || nuVarDiMo);
            dbms_output.put_line('nuPrTrMor: ' || nuPrTrMor);
            dbms_output.put_line('nuCupApro: ' || nuCupApro);
            dbms_output.put_line('nuCuotMax: ' || nuCuotMax);
            dbms_output.put_line('nuPrCuFin: ' || nuPrCuFin);
            dbms_output.put_line('nuMxAnMor: ' || nuMxAnMor);
            dbms_output.put_line('nuCeAnMor: ' || nuCeAnMor);
            dbms_output.put_line('nuMxSmMor: ' || nuMxSmMor);
            dbms_output.put_line('nuPrSmMor: ' || nuPrSmMor);
            --TEAM 571
            dbms_output.put_line('nuMorMUT: ' || nuMorMUT);
            dbms_output.put_line('nuConMUS: ' || nuConMUS);
            dbms_output.put_line('nuConMUA: ' || nuConMUA);
            dbms_output.put_line('nuConMMS: ' || nuConMMS);
            dbms_output.put_line('nuPorUti: ' || nuPorUti);

            -- Obtiene datos para registro Detalle LISIM
            -- consecutivo
            tmp_tbDetLisim(inuProducto).delicons(1) := NULL;
            --  Producto
            tmp_tbDetLisim(inuProducto).delinuse(1) := inuProducto;
            -- Fecha de Contabilizaci?n
            tmp_tbDetLisim(inuProducto).delifeco(1) := IC_BOLisimProvGen.dtFinishDate;
            -- d?as de mora
            tmp_tbDetLisim(inuProducto).delidimo(1) := nuVarDiMo;
            -- puntaje d?as de mora
            tmp_tbDetLisim(inuProducto).delipudm(1) := IC_BOLisimScorConfVal.fnuGetScoreByVar(cnuVARDIMO, nuVarDiMo);
            -- m?ximo anual mora
            tmp_tbDetLisim(inuProducto).delimxam(1) := nuMxAnMor;
            -- puntaje m?ximo anual mora
            tmp_tbDetLisim(inuProducto).delipmam(1) := IC_BOLisimScorConfVal.fnuGetScoreByVar(cnuMXANMOR, nuMxAnMor);
            -- m?ximo semestral mora
            tmp_tbDetLisim(inuProducto).delimxsm(1) := nuMxSmMor;
            -- puntaje m?ximo semestral mora
            tmp_tbDetLisim(inuProducto).delipmsm(1) := IC_BOLisimScorConfVal.fnuGetScoreByVar(cnuMXSMMOR, nuMxSmMor);
            -- promedio semestral mora
            tmp_tbDetLisim(inuProducto).deliprsm(1) := nuPrSmMor;
            -- puntaje promedio semestral mora
            tmp_tbDetLisim(inuProducto).delippsm(1) := IC_BOLisimScorConfVal.fnuGetScoreByVar(cnuPRSMMOR, nuPrSmMor);
            -- promedio trimestral mora
            tmp_tbDetLisim(inuProducto).deliprtm(1) := nuPrTrMor;
            -- puntaje promedio trimestral mora
            tmp_tbDetLisim(inuProducto).delipptm(1) := IC_BOLisimScorConfVal.fnuGetScoreByVar(cnuPRTRMOR, nuPrTrMor);
            ut_trace.trace('-- PASO 22. [JOSELC - detalle lisim]-puntaje promedio trimestral mora-- OPEN ' || tmp_tbDetLisim(inuProducto)
                           .delipptm(1) || '--PRODUCTO--' || inuProducto, 1);
            -- mora cero anual
            tmp_tbDetLisim(inuProducto).delimoca(1) := nuCeAnMor;
            -- puntaje mora cero anual
            tmp_tbDetLisim(inuProducto).delipmca(1) := IC_BOLisimScorConfVal.fnuGetScoreByVar(cnuCEANMOR, nuCeAnMor);
            -- cupo aprobado
            tmp_tbDetLisim(inuProducto).delicuap(1) := nuCupAproSMLV;
            -- puntaje cupo aprobado
            tmp_tbDetLisim(inuProducto).delipcap(1) := IC_BOLisimScorConfVal.fnuGetScoreByVar(cnuCUPAPRO, nuCupAproSMLV);
            -- cuota m?xima
            tmp_tbDetLisim(inuProducto).delicumx(1) := nuCuotMax;
            -- puntaje cuota m?xima
            tmp_tbDetLisim(inuProducto).delipcmx(1) := IC_BOLisimScorConfVal.fnuGetScoreByVar(cnuCUOTMAX, nuCuotMax);
            -- cupo usado final
            tmp_tbDetLisim(inuProducto).delicuuf(1) := nuPrCuFin;
            -- puntaje cupo usado final
            tmp_tbDetLisim(inuProducto).delipcuf(1) := IC_BOLisimScorConfVal.fnuGetScoreByVar(cnuPRCUFIN, nuPrCuFin);
            -- intercept
            tmp_tbDetLisim(inuProducto).deliinte(1) := IC_BOLisimScorConfVal.fnuGetScoreByVar(cnuINTERCE, nuInterce);
            -- p?rdida de incumplimiento
            tmp_tbDetLisim(inuProducto).delipecu(1) := IC_BOLisimScorConfVal.fnuGetScoreByVar(cnuPERCUM, nuVarDiMo);
            --TEAM 571
            -- Contador Mora 1-30 d?as  en el ?ltimo a?o
            tmp_tbDetLisim(inuProducto).delimoua(1) := IC_BOLisimScorConfVal.fnuGetScoreByVar(cnuConMUA, nuConMUA);
            ut_trace.trace('-- PASO 22. [JOSELC - detalle lisim]-Contador Mora 1-30 d?as  en el ?ltimo a?o ' || tmp_tbDetLisim(inuProducto)
                           .delimoua(1) || '--PRODUCTO--' || inuProducto, 1);
            --Contador Mora 1-30 d?as en el ?ltimo Semestre
            tmp_tbDetLisim(inuProducto).delimous(1) := IC_BOLisimScorConfVal.fnuGetScoreByVar(cnuConMUS, nuConMUS);
            ut_trace.trace('-- PASO 23. [JOSELC - detalle lisim]-Contador Mora 1-30 d?as en el ?ltimo Semestre' || tmp_tbDetLisim(inuProducto)
                           .delimous(1) || '--PRODUCTO--' || inuProducto, 1);

            --Contador Mora Mayor a 60 d?as Semestral
            tmp_tbDetLisim(inuProducto).delimoss(1) := IC_BOLisimScorConfVal.fnuGetScoreByVar(cnuConMMS, nuConMMS);
            ut_trace.trace('-- PASO 24. [JOSELC - detalle lisim]-Contador Mora Mayor a 60 d?as Semestral' || tmp_tbDetLisim(inuProducto)
                           .delimoss(1) || '--PRODUCTO--' || inuProducto, 1);

            --Mora M?xima en el ?ltimo Trimestre
            tmp_tbDetLisim(inuProducto).delimout(1) := IC_BOLisimScorConfVal.fnuGetScoreByVar(cnuMorMUT, nuMorMUT);
            ut_trace.trace('-- PASO 25. [JOSELC - detalle lisim]-Mora M?xima en el ?ltimo Trimestre' || tmp_tbDetLisim(inuProducto)
                           .delimout(1) || '--PRODUCTO--' || inuProducto, 1);

            --Porcentaje de Utilizacion
            IF (nuCupApro <> 0) THEN
                tmp_tbDetLisim(inuProducto).delipout(1) := (nuSalfin /
                                                           nuCupApro) * 100;

                ut_trace.trace('-- PASO 40. [JOSELC - detalle lisim]-Porcentaje de Utilizacion- producto--' ||
                               inuProducto || '--nuCupApro--' || nuCupApro ||
                               '--nuSalfin--' || nuSalfin, 1);

                ut_trace.trace('-- PASO 26. [JOSELC - detalle lisim]-Porcentaje de Utilizacion' || tmp_tbDetLisim(inuProducto)
                               .delipout(1), 1);
            ELSE
                tmp_tbDetLisim(inuProducto).delipout(1) := 0;
            END IF;

            td('delipudm : ' || tmp_tbDetLisim(inuProducto).delipudm(1));
            td('delipmam : ' || tmp_tbDetLisim(inuProducto).delipmam(1));
            td('delipmsm : ' || tmp_tbDetLisim(inuProducto).delipmsm(1));
            td('delippsm : ' || tmp_tbDetLisim(inuProducto).delippsm(1));
            td('delipptm : ' || tmp_tbDetLisim(inuProducto).delipptm(1));
            td('delipmca : ' || tmp_tbDetLisim(inuProducto).delipmca(1));
            td('delipcap : ' || tmp_tbDetLisim(inuProducto).delipcap(1));
            td('delipcmx : ' || tmp_tbDetLisim(inuProducto).delipcmx(1));
            td('delipcuf : ' || tmp_tbDetLisim(inuProducto).delipcuf(1));
            td('deliinte : ' || tmp_tbDetLisim(inuProducto).deliinte(1));
            --TEAM 571
            td('delimoua : ' || tmp_tbDetLisim(inuProducto).delimoua(1));
            td('delimous : ' || tmp_tbDetLisim(inuProducto).delimous(1));
            td('delimoss : ' || tmp_tbDetLisim(inuProducto).delimoss(1));
            td('delimout : ' || tmp_tbDetLisim(inuProducto).delimout(1));
            td('delipout : ' || tmp_tbDetLisim(inuProducto).delipout(1));

            dbms_output.put_line('delipudm : ' || tmp_tbDetLisim(inuProducto)
                                 .delipudm(1));
            dbms_output.put_line('delipmam : ' || tmp_tbDetLisim(inuProducto)
                                 .delipmam(1));
            dbms_output.put_line('delipmsm : ' || tmp_tbDetLisim(inuProducto)
                                 .delipmsm(1));
            dbms_output.put_line('delippsm : ' || tmp_tbDetLisim(inuProducto)
                                 .delippsm(1));
            dbms_output.put_line('delipptm : ' || tmp_tbDetLisim(inuProducto)
                                 .delipptm(1));
            dbms_output.put_line('delipmca : ' || tmp_tbDetLisim(inuProducto)
                                 .delipmca(1));
            dbms_output.put_line('delipcap : ' || tmp_tbDetLisim(inuProducto)
                                 .delipcap(1));
            dbms_output.put_line('delipcmx : ' || tmp_tbDetLisim(inuProducto)
                                 .delipcmx(1));
            dbms_output.put_line('delipcuf : ' || tmp_tbDetLisim(inuProducto)
                                 .delipcuf(1));
            dbms_output.put_line('deliinte : ' || tmp_tbDetLisim(inuProducto)
                                 .deliinte(1));
            --TEAM 571
            dbms_output.put_line('delimoua : ' || tmp_tbDetLisim(inuProducto)
                                 .delimoua(1));
            dbms_output.put_line('delimous : ' || tmp_tbDetLisim(inuProducto)
                                 .delimous(1));
            dbms_output.put_line('delimoss : ' || tmp_tbDetLisim(inuProducto)
                                 .delimoss(1));
            dbms_output.put_line('delimout : ' || tmp_tbDetLisim(inuProducto)
                                 .delimout(1));
            dbms_output.put_line('delipout : ' || tmp_tbDetLisim(inuProducto)
                                 .delipout(1));

            IF LDC_CONFIGURACIONRQ.aplicaParaEfigas(sbNombreEntrega)
               OR LDC_CONFIGURACIONRQ.aplicaParaSurtigas(sbNombreEntrega)
               OR LDC_CONFIGURACIONRQ.aplicaParaGDC(sbNombreEntrega)
               OR LDC_CONFIGURACIONRQ.aplicaParaGDO(sbNombreEntrega) THEN

                --  Factor
                nuFactor := tmp_tbDetLisim(inuProducto)
                            .delimxam(1) + --Maximo anual mora
                            tmp_tbDetLisim(inuProducto).delimoua(1) + --Contador Mora 1-30 d?as  en el ?ltimo a?o
                            tmp_tbDetLisim(inuProducto).delimous(1) + --Contador Mora 1-30 d?as en el ?ltimo Semestre
                            tmp_tbDetLisim(inuProducto).delipmsm(1) + --Maximo semestral mora
                            tmp_tbDetLisim(inuProducto).delimoss(1) + --Contador Mora Mayor a 60 d?as Semestral
                            tmp_tbDetLisim(inuProducto).delimout(1) + --Mora M?xima en el ?ltimo Trimestre
                            tmp_tbDetLisim(inuProducto).delipout(1) + --Porcentaje de utilizacion
                            tmp_tbDetLisim(inuProducto).delicumx(1); --Cuota maxima
                ut_trace.trace('-- PASO 27. [JOSELC - detalle lisim]-factor metodo nuevo' ||
                               nuFactor, 1);

                ut_trace.trace('-- PASO 28. [JOSELC - variables metodo nuevo lisim]- var1--' || tmp_tbDetLisim(inuProducto)
                               .delimxam(1) || '--var2--' || tmp_tbDetLisim(inuProducto)
                               .delimoua(1) || '--var3--' || tmp_tbDetLisim(inuProducto)
                               .delimous(1) || '--var4--' || tmp_tbDetLisim(inuProducto)
                               .delipmsm(1) || '--var5--' || tmp_tbDetLisim(inuProducto)
                               .delimoss(1) || '--var6--' || tmp_tbDetLisim(inuProducto)
                               .delimout(1) || '--var7--' || tmp_tbDetLisim(inuProducto)
                               .delipout(1) || '--var8--' || tmp_tbDetLisim(inuProducto)
                               .delicumx(1), 1);

            ELSE

                --  Factor
                nuFactor := tmp_tbDetLisim(inuProducto).delipudm(1) + tmp_tbDetLisim(inuProducto)
                            .delipmam(1) + tmp_tbDetLisim(inuProducto)
                            .delipmsm(1) + tmp_tbDetLisim(inuProducto)
                            .delippsm(1) + tmp_tbDetLisim(inuProducto)
                            .delipptm(1) + tmp_tbDetLisim(inuProducto)
                            .delipmca(1) + tmp_tbDetLisim(inuProducto)
                            .delipcap(1) + tmp_tbDetLisim(inuProducto)
                            .delipcmx(1) + tmp_tbDetLisim(inuProducto)
                            .delipcuf(1) + tmp_tbDetLisim(inuProducto)
                            .deliinte(1);

                ut_trace.trace('-- PASO 27. [JOSELC - detalle lisim]-factor metodo anterior' ||
                               nuFactor, 1);

                ut_trace.trace('-- PASO 28. [JOSELC - variables metodo anterior lisim]- var1--' || tmp_tbDetLisim(inuProducto)
                               .delipudm(1) || '--var2--' || tmp_tbDetLisim(inuProducto)
                               .delipmam(1) || '--var3--' || tmp_tbDetLisim(inuProducto)
                               .delipmsm(1) || '--var4--' || tmp_tbDetLisim(inuProducto)
                               .delippsm(1) || '--var5--' || tmp_tbDetLisim(inuProducto)
                               .delipptm(1) || '--var6--' || tmp_tbDetLisim(inuProducto)
                               .delipmca(1) || '--var7--' || tmp_tbDetLisim(inuProducto)
                               .delipcap(1) || '--var8--' || tmp_tbDetLisim(inuProducto)
                               .delipcmx(1) || '--var9--' || tmp_tbDetLisim(inuProducto)
                               .delipcuf(1) || '--var10--' || tmp_tbDetLisim(inuProducto)
                               .deliinte(1), 1);

            END IF;

            --tmp_tbDetLisim(inuProducto).delipecu(1) ;

            pkgeneralservices.TraceData('nuFactor: ' || nuFactor);

            tmp_tbDetLisim(inuProducto).delifact(1) := nuFactor; -- factor

            dbms_output.put_line('nuFactor ' || nuFactor);

            BEGIN

                -- Obtener Probabilidad de Cumplimiento   EXP (Factor) / (1 + EXP (Factor))
                tmp_tbDetLisim(inuProducto).deliprcu(1) := EXP(nuFactor) /
                                                           (1 + EXP(nuFactor));

                dbms_output.put_line('tmp_tbDetLisim(inuProducto).deliprcu(1) ' || tmp_tbDetLisim(inuProducto)
                                     .deliprcu(1));

                ut_trace.trace('-- PASO 50. [JOSELC - detalle lisim]-probabilidad de cumplimiento' || tmp_tbDetLisim(inuProducto)
                               .deliprcu(1), 1);

            EXCEPTION
                WHEN OTHERS THEN

                    errors.SetError(1, 'Para el producto ' || inuProducto ||
                                     ' el Factor hallado es superior al soportado por la f?rmula aplicada para el c?lculo de la P?rdida de Cumplimiento. Verifique los puntajes de las variables.');
                    -- Se levanta excepci?n
                    RAISE ex.CONTROLLED_ERROR;

            END;

            pkgeneralservices.TraceData('Probabilidad de Cumplimiento: ' || tmp_tbDetLisim(inuProducto)
                                        .deliprcu(1));

            -- Obtener Probabilidad de Incumplimiento (1- Probabilidad de Cumplimiento)*100
            tmp_tbDetLisim(inuProducto).deliprin(1) := (1 - tmp_tbDetLisim(inuProducto)
                                                       .deliprcu(1)) * 100;

            ut_trace.trace('-- PASO 50. [JOSELC - detalle lisim]-probabilidad de incumplimiento' || tmp_tbDetLisim(inuProducto)
                           .deliprin(1), 1);

            pkgeneralservices.TraceData('Probabilidad de Incumplimiento: ' || tmp_tbDetLisim(inuProducto)
                                        .deliprin(1));
            dbms_output.put_line('Probabilidad de Incumplimiento: ' || tmp_tbDetLisim(inuProducto)
                                 .deliprin(1));

        END IF;
        pkErrors.Pop;

    EXCEPTION
        WHEN LOGIN_DENIED
             OR ex.CONTROLLED_ERROR THEN
            pkErrors.pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            pkErrors.pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
            pkErrors.pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

    END GetLisimDetail;

    /*
    Propiedad intelectual de Open International Systems. (c).

    Procedure : ValParamProgram

    Descripcion : Validar parametros de entrada del proceso (Componente de Programaci?n)

    Parametros  : Descripcion
        isbFrecuencia  Frecuencia


    Retorno     :
        odtFecha      Fecha Generaci?n


    Autor : Claudia Liliana Rodr?guez
    Fecha : 23-03-2012

    Historia de Modificaciones
    Fecha ID Entrega

    06-05-2013  crodriguez.SAO207548
    Se modifica el m?todo para obtener el mensaje de validaci?n de la
    frecuencia de la entidad ge_message

    23-03-2012    crodriguezSAO180613
    creacion
    */

    PROCEDURE ValParamProgram(isbFrecuencia IN ge_process_schedule.frequency%TYPE) IS
        -- C?digo mensaje atributos null
        cnuNULL_ATTRIBUTE CONSTANT NUMBER := 9973;
        -- Frecuencia
        cnuFRECUENCIA CONSTANT ge_message.message_id%TYPE := 900128;

    BEGIN
        pkErrors.Push('IC_BOLisimProvGen.ValParamProgram');

        -- Ejecuta mensaje de error si la frecuencia es nula
        IF (isbFrecuencia IS NULL) THEN
            pkErrors.SetErrorCode(pkconstante.csbDIVISION, pkconstante.csbMOD_BIL, cnuNULL_ATTRIBUTE);
            pkErrors.ChangeMessage('%1', 'Frecuencia');
            RAISE LOGIN_DENIED;
        END IF;

        -- si frecuencia diferente a Mensual o Solo una vez (Generaci?n)
        IF (isbFrecuencia NOT IN
           (GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbMensual)) THEN

            Errors.SetError(cnuFRECUENCIA);
            RAISE LOGIN_DENIED;

        END IF;

        pkErrors.Pop;

    EXCEPTION
        WHEN LOGIN_DENIED
             OR ex.CONTROLLED_ERROR THEN
            pkErrors.pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            pkErrors.pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
            pkErrors.pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);
    END ValParamProgram;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   SetProcessDate
        Descripci?n     :   Asigna las fechas inicial y final, a partir de la
                            fecha de procesamiento

        Par?metros
        Entrada          :       Descripci?n
            idtProcessDate          Fecha de procesamiento

        Autor    :  Alejandro Rend?n G?mez
        Fecha    :  22-11-2013 18:22:27

        Historia de Modificaciones
        Fecha       IDEntrega

        22-11-2013  arendon.SAO224405
        Creaci?n.
    */
    PROCEDURE SetProcessDates(idtProcessDate IN DATE) IS

    BEGIN
        pkErrors.Push('IC_BOLisimProvGen.SetProcessDates');

        -- Fecha inicial es el primer d?a del mes 1 a?o atras
        IC_BOLisimProvGen.dtInitDate := add_months(trunc(idtProcessDate, 'MM'), -11);

        -- Fecha final es el ?ltimo d?a del mes actual
        IC_BOLisimProvGen.dtFinishDate := last_day(trunc(idtProcessDate));

        -- Fecha final es el ?ltimo d?a del mes actual
        IC_BOLisimProvGen.dtProcessDate := last_day(trunc(idtProcessDate));

        pkgeneralservices.TraceData('gdtInitDate ' ||
                                    IC_BOLisimProvGen.dtInitDate);
        pkgeneralservices.TraceData('gdtFinishDate ' ||
                                    IC_BOLisimProvGen.dtFinishDate);

        pkErrors.Pop;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            pkErrors.pop;
            RAISE LOGIN_DENIED;

        WHEN pkConstante.exERROR_LEVEL2 THEN
            -- Error Oracle nivel dos
            pkErrors.pop;
            RAISE pkConstante.exERROR_LEVEL2;

        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
            pkErrors.pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);
    END SetProcessDates;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   CreateDocument
        Descripci?n     :   Valida y crea el documento si no existe.

        Autor       :   German Alexis Duque
        Fecha       :   12-09-2012

        Retorno     :
           onuDocument  N?mero Documento
        Historia de Modificaciones
        Fecha       IDEntrega

        22-11-2013  arendon.SAO224405
        Se adiciona la fecha de contabilizacion como par?metro de entrada.

        12-09-2012  gduque.SAO190015
        Creaci?n.
    */
    PROCEDURE CreateDocument
    (
        idtDate     IN DATE,
        onuDocument OUT ic_docugene.dogenudo%TYPE
    ) IS
        -------------------
        -- Constantes
        -------------------
        csbDETAIL CONSTANT VARCHAR2(100) := 'Creado por PROVISI?N DE CARTERA LISIM';

    BEGIN
        pkErrors.Push('IC_BOProcessProvision.CreateDocument');

        -- Verifica si para el d?a final existe creado un documento.
        onuDocument := pkBCIc_Docugene.fnuGetNumeDocByTido(cnuTIDOCART, idtDate);

        -- Si no existe Documento, lo crea
        IF (onuDocument IS NULL) THEN
            pkBCIc_Docugene.CreateDocument(cnuTIDOCART, idtDate, idtDate, csbDETAIL);

            -- Asienta la transacci?n en BD
            pkGeneralServices.CommitTransaction;

        END IF;

        -- Verifica si para el d?a final existe creado un documento.
        onuDocument := pkBCIc_Docugene.fnuGetNumeDocByTido(cnuTIDOCART, idtDate);

        pkErrors.Pop;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            pkErrors.pop;
            RAISE LOGIN_DENIED;

        WHEN pkConstante.exERROR_LEVEL2 THEN
            -- Error Oracle nivel dos
            pkErrors.pop;
            RAISE pkConstante.exERROR_LEVEL2;

        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
            pkErrors.pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);
    END CreateDocument;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   ValBasicData
        Descripci?n     :   Valida datos b?sicos del proceso

        Par?metros
        Entrada         :       Descripci?n
            idtFechaProv            Fecha de provisi?n

        Salida          :       Descripci?n

        Autor       :   Alejandro Rend?n G?mez
        Fecha       :   22-11-2013 16:22:48

        Historia de Modificaciones
        Fecha       IDEntrega

        14-12-2013  arendon.SAO227508
        Se modifica para eliminar la validaci?n de la Generaci?n de Informaci?n
        de Cartera.

        22-11-2013  arendon.SAO224405
        Creaci?n.
    */
    PROCEDURE ValBasicData(idtFechaProv IN DATE) IS
        --Tipo de Documento de Cartera
        cnuTido NUMBER := 76;

        --Parametro
        csbParameter CONSTANT VARCHAR2(1) := '%';

        -- Caracter PIPE
        csbPIPE CONSTANT VARCHAR2(1) := '|';

        -- Formato Fecha
        csbFORMAT_DATE CONSTANT VARCHAR2(10) := 'DD-MM-YYYY';

        -- Posici?n Fecha en el parametro
        nuPosDate NUMBER := 2;

    BEGIN

        pkErrors.Push('IC_BOLisimProvGen.ValBasicData');

        -- Valida el proceso hilado y el inverso
        pkBOProcessConcurrenceCtrl.ValidateConcurrence(to_char(idtFechaProv, csbFORMAT_DATE), 'RPLISIM');

        pkBOProcessConcurrenceCtrl.ValExecuteProcess(pkboprocessconcurrencectrl.csbEXECNAME_ICBGIC ||
                                                     csbParameter, pkboprocessconcurrencectrl.csbEXECNAME_ICBGIC_REV, csbParameter);

        -- Validaci?n Generaci?n de HE
        pkBOProcessConcurrenceCtrl.ValExecuteProcess(pkboprocessconcurrencectrl.csbEXECNAME_FGHE ||
                                                     csbParameter, pkboprocessconcurrencectrl.csbEXECNAME_FGHE_REV, cnuTido ||
                                                      csbPIPE ||
                                                      to_char(idtFechaProv, csbFORMAT_DATE) ||
                                                      csbPIPE ||
                                                      SA_BOSystem.fnuGetUserCompanyId, nuPosDate);

        --- Validaci?n Provision de Cartera Cascada
        pkBOProcessConcurrenceCtrl.ValExecuteProcess(pkboprocessconcurrencectrl.csbEXECNAME_PPCA ||
                                                     csbParameter, pkboprocessconcurrencectrl.csbEXECNAME_PPCA_REV, csbParameter);

        --- Validaci?n Provision de Facturaci?n
        pkBOProcessConcurrenceCtrl.ValExecuteProcess(pkboprocessconcurrencectrL.csbEXECNAME_FPHE ||
                                                     csbParameter, pkboprocessconcurrencectrL.csbEXECNAME_FPHE_REV, csbParameter);

        --- Validaci?n Provision de Actas
        pkBOProcessConcurrenceCtrl.ValExecuteProcess(pkboprocessconcurrencectrL.csbEXECNAME_ICBPPA ||
                                                     csbParameter, pkboprocessconcurrencectrL.csbEXECNAME_ICBPPA_REV, csbParameter);

        pkErrors.Pop;

    EXCEPTION
        WHEN LOGIN_DENIED
             OR ex.CONTROLLED_ERROR THEN
            pkErrors.pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            pkErrors.pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
            pkErrors.pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

    END ValBasicData;

    /*
        Propiedad intelectual de Open International Systems. (c).

        Procedure : ValInputData

        Descripcion : Valida Datos de Entrada

        Parametros  : Descripcion
            isbFrecuencia   Frecuencia
            idtFechaProv    Fecha de Provisi?n
            inuDiasRetraso  D?as de Retraso

        Autor : Alejandro Rend?n G?mez
        Fecha : 22-11-2013 17:39:51

        Historia de Modificaciones
        Fecha ID Entrega

        22-11-2013  arendon.SAO224405
        creacion
    */

    PROCEDURE ValInputData
    (
        isbFrecuencia  IN ge_process_schedule.frequency%TYPE,
        idtFechaProv   IN DATE,
        inuDiasRetraso IN NUMBER
    ) IS

        --------------------------------------------------------------------
        -- Constantes
        --------------------------------------------------------------------

        -- Mensage "El atributo Frecuencia debe ser s?lo una vez o mensual"
        cnuMENS_FREC_INV CONSTANT ge_message.message_id%TYPE := 900128;
        -- Mensaje "%s1 ingresar %s2 para %s3"
        cnuMENS_INGRESO_AT CONSTANT ge_message.message_id%TYPE := 901380;
        -- D?as de Retraso No Nulo para Frecuencia = "S?lo Una Vez"
        csbDIAS_RET_NO_NULO CONSTANT ge_message.description%TYPE := 'No debe|D?as de Retraso|Frecuencia S?lo Una Vez';
        -- Fecha de Provisi?n No Nula para Frecuencia = "Mensual"
        csbFECHA_NO_NULA CONSTANT ge_message.description%TYPE := 'No debe|Fecha de Provisi?n|Frecuencia Mensual';

    BEGIN

        pkErrors.Push('IC_BOLisimProvGen.ValInputData');

        -- Frecuencia no soportada
        IF (isbFrecuencia NOT IN
           (GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbMensual)) THEN

            Errors.SetError(cnuMENS_FREC_INV);
            RAISE LOGIN_DENIED;

        END IF;

        -- Frecuencia = "S?lo Una Vez"
        IF (isbFrecuencia = GE_BOSchedule.csbSoloUnaVez) THEN

            -- Ingres? D?as de Retraso
            IF (inuDiasRetraso IS NOT NULL) THEN

                Errors.SetError(cnuMENS_INGRESO_AT, csbDIAS_RET_NO_NULO);
                RAISE LOGIN_DENIED;

            END IF;

            -------
            -- NOTA: Si NO ingres? D?as Retraso, debi? ingresar Fecha Provisi?n.
            -------

            -- Valida Fecha de Provisi?n MENOR que Fecha Actual
            pkGeneralServices.ValFechaMenorActual(trunc(idtFechaProv));

            -- Frecuencia = "Mensual"
        ELSE

            -- Ingres? Fecha de Provisi?n
            IF (idtFechaProv IS NOT NULL) THEN

                Errors.SetError(cnuMENS_INGRESO_AT, csbFECHA_NO_NULA);
                RAISE LOGIN_DENIED;

            END IF;

            -------
            -- NOTA: Si NO ingres? Fecha Provisi?n, debi? ingresar D?as Retraso.
            -------

        END IF;

        pkErrors.Pop;

    EXCEPTION
        WHEN LOGIN_DENIED
             OR ex.CONTROLLED_ERROR THEN
            pkErrors.pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            pkErrors.pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
            pkErrors.pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);
    END ValInputData;

    /*
    Propiedad intelectual de Open International Systems. (c).

    Procedure : ValEjecucionPLISIM

    Descripcion : Validar seg?n el proceso lo siguiente:
                      1.Se haya ejecutado el proceso de GHE de Cartera
                      2.El proceso de cartera se haya ejecutado
                      3.No se haya ejecutado el proceso de Generaci?n de RC


    Parametros
    Entrada     :       Descripcion
        isbFrecuencia       Frecuencia
        idtFechaProv        Fecha de provision
        inuDiasRetraso      Dias de retraso

    Salida      :       Descripci?n
        odtFechaProceso     Fecha real de proceso

    Autor : Claudia Liliana Rodr?guez
    Fecha : 23-03-2012

    Historia de Modificaciones
    Fecha    IDEntrega

    14-12-2013  arendon.SAO227508
    Se adiciona validaci?n de la Generaci?n de Informaci?n de Cartera para la
    fecha de corte.
    Se validan datos b?sicos y se crea el docugene para el ?ltimo dia del mes

    22-11-2013  arendon.SAO224405
    Se adicionan los par?metros:
        - isbFrecuencia
        - idtFechaProv
        - inuDiasRetraso

    24-01-2013  gduque.SAO200257
    Se modifica la validaci?n de control de proceso de FGHE.

    16-10-2012  gduque.SAO194162
    Se eliminan las constantes:
        - csbRPPCA
        - csbPPCA
        - csbRPHE
        - csbFPHE
        - csbICBRPA
        - csbICBPPA
        - csbICBGIC
        - csbICBRIC
        - csbFGHE
        - csbFRHE
    Se Valida si existe Generaci?n de Informaci?n Cartera para la Fecha.

    12-10-2012  hlopez.SAO194064
    Se adiciona la creaci?n del IC_DOCUGENE.

    11-09-2012 gduque.SAO190015
    Se elimina el parametro idtFechaProceso.

    29-08-2012  gduqueSAO189287
    Se  elimina de csbICBGIC, csbPPCA, csbFPHE, csbICBPPA el '%'.

    16-08-2012  gduqueSAO188626
    Se valida los procesos de Provision de Cartera,Facturaci?n, Actas y
    Generaci?n de Cartera.

    23-03-2012   crodriguezSAO180613
    Creaci?n.
    */

    PROCEDURE ValEjecucionPLISIM
    (
        isbFrecuencia   IN ge_process_schedule.frequency%TYPE,
        idtFechaProv    IN DATE,
        inuDiasRetraso  IN NUMBER,
        odtFechaProceso OUT DATE
    ) IS
        -- Documento generado Dummy
        nuDocNumDummy ic_docugene.dogenudo%TYPE;

    BEGIN

        pkErrors.Push('IC_BOLisimProvGen.ValEjecucionPLISIM');

        /* Valida los datos de entrada */
        IC_BOLisimProvGen.ValInputData(isbFrecuencia, idtFechaProv, inuDiasRetraso);

        -- Obtiene Fecha de Proceso
        -- Ingres? Fecha de Provisi?n (Frecuencia = "S?lo Una Vez")
        IF (idtFechaProv IS NOT NULL) THEN
            odtFechaProceso := trunc(idtFechaProv);
            -- Ingres? D?as de Retraso (Frecuencia = "Mensual")
        ELSE
            odtFechaProceso := trunc(SYSDATE) - inuDiasRetraso;
        END IF;

        pkgeneralservices.TraceData('dtFechaProceso ' || odtFechaProceso);

        /* Valida datos b?sicos del proceso */
        IC_BOLisimProvGen.ValBasicData(last_day(odtFechaProceso));

        -- Valida si existe Generaci?n de Informaci?n Cartera
        IC_BOGenCartCompConc.ValExecution(odtFechaProceso, odtFechaProceso);

        -- Crea el Docugene
        CreateDocument(last_day(odtFechaProceso), nuDocNumDummy);

        pkErrors.Pop;

    EXCEPTION
        WHEN LOGIN_DENIED
             OR ex.CONTROLLED_ERROR THEN
            pkErrors.pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            pkErrors.pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
            pkErrors.pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

    END ValEjecucionPLISIM;

    /*
        Propiedad intelectual de Open International Systems (c).

        Funci?n     : ProcessLisimGen
        Descripci?n : Procesa la informaci?n de cartera y genera los registros de
                      provisi?n de cartera usando el m?todo LISIM.

        Par?metros    :
                 idtFechaGen    Fecha de Generaci?n del proceso
                 inuNumHilos    N?mero de Hilos
                 inuHilo        Hilo


        Autor     :   Claudia Liliana Rodr?guez Garc?a
        Fecha     :   23-03-2012 17:05:46

        Historia de Modificaciones
        Fecha     IDEntrega

        02-04-2014  aesguerra.3551
        Se modifica el llamado a GetLisimDetail para pasar por parametro
        la fecha de procesamiento

        22-11-2013  arendon.SAO224405
        Se adiciona la fecha de procesamiento como par?metro de entrada.

        17-07-2013  hlopez.SAO212472
        Se adiciona el atributo Clasificaci?n Contable del Contrato.
        - Se modifica el m?todo <ObtRelaHE_PortfProv>

        08-04-2013   sgomez.SAO205719
        Se modifica <Provisi?n LISIM> por impacto en <Hechos Econ?micos>
        (adici?n de atributo <?tem>).

        01-10-2012  gduque.SAO183760
        Se adiciona el parametro inuPivote.

        12-09-2012  gduque.SAO190015
        Se  elimina el parametro idtFechaGen.
        Se  elimina las variables dtFchPro y dtFchCon.
        Se modifica los m?todos:
                - <Initialize>
                - <FillrecordPortProv>

        13-08-2012 gduqueSAO188355
        Se modifica el metodo <ObtRelaHE_PortfProv>

        11-08-2012 gduqueSAO183771
        Se modifica ol metodo <FillrecordPortProv>.

        23-03-2012  crodriguezSAO180613
        Creaci?n.
    */

    PROCEDURE ProcessLisimGen
    (
        isbEstaprog    IN estaprog.esprprog%TYPE,
        idtProcessDate IN DATE,
        isbTyPrEx      IN VARCHAR2,
        inuPivote      IN ic_cartcoco.cacccons%TYPE,
        inuNumHilos    IN NUMBER,
        inuHilo        IN NUMBER
    ) IS
        -----------------------------------------------------------------------------
        -- Constantes
        -----------------------------------------------------------------------------

        -----------------------------------------------------------------------------
        -- Variables
        -----------------------------------------------------------------------------
        -- ID del producto usado para obtener el n?mero de cuentas con saldo
        nuProducto servsusc.sesunuse%TYPE;

        -- Pivote usado para obtener los registros de Cartera
        nuPivote ic_cartprov.caprcons%TYPE;

        -- Record de Tablas que contiene los registros de Cartera
        rctbCartera pktblic_cartprov.tytbIc_Cartprov;

        -- Contiene el valor de provisi?n a aplicar para cada registro
        nuValProv ic_cartprov.caprvapr%TYPE;

        -- Documento Generado
        nuDogenudo ic_docugene.dogenudo%TYPE;

        -- Documento Generado mes anterior
        nuDogeant ic_docugene.dogenudo%TYPE;

        -- Mensaje de error cuando no se ha ejecutado el PGHE
        cnuEJECHE NUMBER := 13662;

        -- Cantidad de registros procesados
        nuRegProc NUMBER;

        -- Porcentaje de Avance
        nuPorcentaje NUMBER;

        -- Fecha Proceso
        dtFechaProceso DATE;

        /*
            Propiedad intelectual de Open International Systems. (c).

            Procedure : ClearMemory

            Descripcion : Limpiar Tabla PL con registros de cartera

            Parametros  : Descripcion

            Retorno     :

            Autor : Claudia Liliana Rodr?guez
            Fecha : 23-03-2012

            Historia de Modificaciones
            Fecha    IDEntrega

            23-03-2012    crodr?guezSAO180613
            Creacion.
        */
        PROCEDURE ClearMemory IS
        BEGIN

            -- Indice de la tabla PL temporal donde se almacenan los registros
            -- de cartera provisionada
            IC_BOLisimProvGen.nuIndTemp := 1;

            IC_BOLisimProvGen.tmpIC_cartprov.caprcons.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprnaca.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprticl.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.capridcl.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprclie.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprsusc.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprserv.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprnuse.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.capresco.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprcate.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprsuca.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprtico.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprpref.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprnufi.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprcomp.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprcuco.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprconc.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprfeve.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprfege.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprsape.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprvapr.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprubg1.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprubg2.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprubg3.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprubg4.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprubg5.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprfeco.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprmovi.delete;
            IC_BOLisimProvGen.tmpIC_cartprov.caprcopc.delete;

            -- Inicializar Variable
            nuRegProc := 0;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END ClearMemory;

        /*
            Propiedad intelectual de Open International Systems. (c).

            Procedure : Initialize

            Descripcion : Inicializar variables

            Parametros  : Descripcion

            Retorno     :

            Autor : Claudia Liliana Rodr?guez
            Fecha : 23-03-2012

            Historia de Modificaciones
            Fecha    IDEntrega

            12-09-2012  gduque.SAO190015
            Se  elimina las variables:
                    - dtFchPro
                    -dtFchCon
            Se invoca el m?todo <CreateDocument>.

            23-03-2012    crodr?guezSAO180613
            Creacion.
        */
        PROCEDURE Initialize IS

        BEGIN

            pkErrors.Push('IC_BOLisimProvGen.ProcessGen.Initialize');

            -- Inicializa variables
            pkErrors.Initialize;

            /* Calcula la fecha inicial y final para el c?lculo de las variables */
            IC_BOLisimProvGen.SetProcessDates(idtProcessDate);

            ----------------------------------------------------------------------------
            -- Variables
            ----------------------------------------------------------------------------
            -- Descripci?n mensaje de error
            sbMensajeError := pkConstante.NULLSB;

            -- Limpia Tabla PL temporal contiene los registros de cartera
            -- provisionada
            ClearMemory;

            -- ID del producto, se usa  para obtener el n?mero de cuentas con saldo
            nuProducto := 0;

            -- Pivote usado para obtener los registros de Cartera
            nuPivote := inuPivote - 1;

            -- Puntaje de provisi?n a aplicar para cada registro
            nuValProv := 0;

            -- Indice del campo de la tabla Hash
            IC_BOLisimProvGen.nuIndHash := 1;

            -- Usuario Ejecutor
            IC_BOLisimProvGen.sbUserName := pkGeneralServices.fsbGetUserName;

            -- Terminal
            IC_BOLisimProvGen.sbTerminal := pkGeneralServices.fsbGetTerminal;

            -- Obtiene el Dogenudo
            CreateDocument(IC_BOLisimProvGen.dtFinishDate, nuDogenudo);

            -- Indice Cantidad de Reg Procesados
            nuRegProc := 0;

            -- Inicializar variable de Estado del proceso
            IC_BOLisimProvGen.sbEstaprog := isbEstaprog;

            /* Asigna fecha de proceso */
            dtFechaProceso := idtProcessDate;

            pkgeneralservices.TraceData('dtFechaProceso ' || dtFechaProceso);

            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);
        END Initialize;

        /*
        Propiedad intelectual de Open International Systems (c).

        Procedimiento : FillrecordPortProv
        Descripci?n   : Almacena registros de provisi?n en la tabla temporal

        Autor     :   Claudia Liliana Rodr?guez
        Fecha     :   23-03-2012 08:37:57

        Historia de Modificaciones
        Fecha     IDEntrega

        12-09-2012  gduque.SAO190015
        Se  elimina las variables dtFchCon.

        11-08-2012  gduqueSAO183771
        Se adiciona campo caprcopc

        23-03-2012  crodriguezSAO180613
        Creaci?n.
        */
        PROCEDURE FillrecordPortProv
        (
            isbcaprnaca IN ic_cartprov.caprnaca%TYPE,
            inucaprticl IN ic_cartprov.caprticl%TYPE,
            isbcapridcl IN ic_cartprov.capridcl%TYPE,
            inucaprclie IN ic_cartprov.caprclie%TYPE,
            inucaprsusc IN ic_cartprov.caprsusc%TYPE,
            inucaprserv IN ic_cartprov.caprserv%TYPE,
            inucaprnuse IN ic_cartprov.caprnuse%TYPE,
            inucapresco IN ic_cartprov.capresco%TYPE,
            inucaprcate IN ic_cartprov.caprcate%TYPE,
            inucaprsuca IN ic_cartprov.caprsuca%TYPE,
            inucaprtico IN ic_cartprov.caprtico%TYPE,
            isbcaprpref IN ic_cartprov.caprpref%TYPE,
            inucaprnufi IN ic_cartprov.caprnufi%TYPE,
            inucaprcomp IN ic_cartprov.caprcomp%TYPE,
            inucaprcuco IN ic_cartprov.caprcuco%TYPE,
            inucaprconc IN ic_cartprov.caprconc%TYPE,
            inucaprfeve IN ic_cartprov.caprfeve%TYPE,
            inucaprfege IN ic_cartprov.caprfege%TYPE,
            inucaprsape IN ic_cartprov.caprsape%TYPE,
            inucaprvapr IN ic_cartprov.caprvapr%TYPE,
            inucaprubg1 IN ic_cartprov.caprubg1%TYPE,
            inucaprubg2 IN ic_cartprov.caprubg2%TYPE,
            inucaprubg3 IN ic_cartprov.caprubg3%TYPE,
            inucaprubg4 IN ic_cartprov.caprubg4%TYPE,
            inucaprubg5 IN ic_cartprov.caprubg5%TYPE,
            inucaprcicl IN ic_cartprov.caprcicl%TYPE

        ) IS
        BEGIN
            pkerrors.Push('IC_BOLisimProvGen.Process.FillrecordPortProv');

            pkgeneralservices.TraceData('inucaprnuse ' || inucaprnuse);
            pkgeneralservices.TraceData('inucaprconc ' || inucaprconc);
            pkgeneralservices.TraceData('inucaprcuco ' || inucaprcuco);
            pkgeneralservices.TraceData('isbcaprnaca ' || isbcaprnaca);
            pkgeneralservices.TraceData('inucaprvapr ' || inucaprvapr);

            IC_BOLisimProvGen.tmpIC_cartprov.caprcons(IC_BOLisimProvGen.nuIndTemp) := pkgeneralservices.fnuGetNextSequenceVal('SQ_IC_CARTPROV_174919');
            IC_BOLisimProvGen.tmpIC_cartprov.caprfeco(IC_BOLisimProvGen.nuIndTemp) := IC_BOLisimProvGen.dtFinishDate;
            IC_BOLisimProvGen.tmpIC_cartprov.caprnaca(IC_BOLisimProvGen.nuIndTemp) := isbcaprnaca;
            IC_BOLisimProvGen.tmpIC_cartprov.caprticl(IC_BOLisimProvGen.nuIndTemp) := inucaprticl;
            IC_BOLisimProvGen.tmpIC_cartprov.capridcl(IC_BOLisimProvGen.nuIndTemp) := isbcapridcl;
            IC_BOLisimProvGen.tmpIC_cartprov.caprclie(IC_BOLisimProvGen.nuIndTemp) := inucaprclie;
            IC_BOLisimProvGen.tmpIC_cartprov.caprsusc(IC_BOLisimProvGen.nuIndTemp) := inucaprsusc;
            IC_BOLisimProvGen.tmpIC_cartprov.caprserv(IC_BOLisimProvGen.nuIndTemp) := inucaprserv;
            IC_BOLisimProvGen.tmpIC_cartprov.caprnuse(IC_BOLisimProvGen.nuIndTemp) := inucaprnuse;
            IC_BOLisimProvGen.tmpIC_cartprov.capresco(IC_BOLisimProvGen.nuIndTemp) := inucapresco;
            IC_BOLisimProvGen.tmpIC_cartprov.caprcate(IC_BOLisimProvGen.nuIndTemp) := inucaprcate;
            IC_BOLisimProvGen.tmpIC_cartprov.caprsuca(IC_BOLisimProvGen.nuIndTemp) := inucaprsuca;
            IC_BOLisimProvGen.tmpIC_cartprov.caprtico(IC_BOLisimProvGen.nuIndTemp) := inucaprtico;
            IC_BOLisimProvGen.tmpIC_cartprov.caprpref(IC_BOLisimProvGen.nuIndTemp) := isbcaprpref;
            IC_BOLisimProvGen.tmpIC_cartprov.caprnufi(IC_BOLisimProvGen.nuIndTemp) := inucaprnufi;
            IC_BOLisimProvGen.tmpIC_cartprov.caprcomp(IC_BOLisimProvGen.nuIndTemp) := inucaprcomp;
            IC_BOLisimProvGen.tmpIC_cartprov.caprcuco(IC_BOLisimProvGen.nuIndTemp) := inucaprcuco;
            IC_BOLisimProvGen.tmpIC_cartprov.caprconc(IC_BOLisimProvGen.nuIndTemp) := inucaprconc;
            IC_BOLisimProvGen.tmpIC_cartprov.caprfeve(IC_BOLisimProvGen.nuIndTemp) := inucaprfeve;
            IC_BOLisimProvGen.tmpIC_cartprov.caprfege(IC_BOLisimProvGen.nuIndTemp) := inucaprfege;
            IC_BOLisimProvGen.tmpIC_cartprov.caprsape(IC_BOLisimProvGen.nuIndTemp) := inucaprsape;
            IC_BOLisimProvGen.tmpIC_cartprov.caprvapr(IC_BOLisimProvGen.nuIndTemp) := inucaprvapr;
            IC_BOLisimProvGen.tmpIC_cartprov.caprubg1(IC_BOLisimProvGen.nuIndTemp) := inucaprubg1;
            IC_BOLisimProvGen.tmpIC_cartprov.caprubg2(IC_BOLisimProvGen.nuIndTemp) := inucaprubg2;
            IC_BOLisimProvGen.tmpIC_cartprov.caprubg3(IC_BOLisimProvGen.nuIndTemp) := inucaprubg3;
            IC_BOLisimProvGen.tmpIC_cartprov.caprubg4(IC_BOLisimProvGen.nuIndTemp) := inucaprubg4;
            IC_BOLisimProvGen.tmpIC_cartprov.caprubg5(IC_BOLisimProvGen.nuIndTemp) := inucaprubg5;
            IC_BOLisimProvGen.tmpIC_cartprov.caprcicl(IC_BOLisimProvGen.nuIndTemp) := inucaprcicl;
            IC_BOLisimProvGen.tmpIC_cartprov.caprmovi(IC_BOLisimProvGen.nuIndTemp) := NULL;
            IC_BOLisimProvGen.tmpIC_cartprov.caprcopc(IC_BOLisimProvGen.nuIndTemp) := NULL;

            pkgeneralservices.TraceData('IC_BOLisimProvGen.nuIndTemp: ' ||
                                        IC_BOLisimProvGen.nuIndTemp);

            IC_BOLisimProvGen.nuIndTemp := IC_BOLisimProvGen.nuIndTemp + 1;

            pkerrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END FillrecordPortProv;

        /*
            Propiedad intelectual de Open International Systems (c).

            Procedimiento : InsertSetOfPortProv
            Descripci?n   : Inserta Registros en la entidad Provisi?n de Cartera.

            Autor     :   Claudia Liliana Rodr?guez
            Fecha     :   23-03-2012 08:37:57

            Historia de Modificaciones
            Fecha     IDEntrega

            23-03-2012  crodriguezSAO180613
            Creaci?n.
        */

        PROCEDURE InsertSetOfPortProv IS
        BEGIN

            pkErrors.Push('IC_BOLisimProvGen.ProcessGen.InsertSetOfRecordPortProv');

            pkgeneralservices.TraceData('Cantidad de registros a insertar: ' ||
                                        to_char(IC_BOLisimProvGen.tmpIC_cartprov.caprserv.count));

            IF (IC_BOLisimProvGen.tmpIC_cartprov.caprserv.first IS NOT NULL) THEN

                pktblic_cartprov.InsRecords(IC_BOLisimProvGen.tmpIC_cartprov);

            END IF;

            pkgeneralservices.TraceData('Termina Insercion en cartprov');

            pkerrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END InsertSetOfPortProv;

        /*
            Propiedad intelectual de Open International Systems (c).

            Procedimiento : InsertSetOfDetLisim
            Descripci?n   : Inserta Registros en la entidad Detalle LISIM.

            Autor     :   Claudia Liliana Rodr?guez
            Fecha     :   23-03-2012 08:37:57

            Historia de Modificaciones
            Fecha     IDEntrega

            23-03-2012  crodriguezSAO180613
            Creaci?n.
        */

        PROCEDURE InsertSetOfDetLisim IS
            nuIdHash   NUMBER;
            rcDetLisim ic_detlisim%ROWTYPE;
        BEGIN

            pkErrors.Push('IC_BOLisimProvGen.ProcessLisimGen.InsertSetOfDetLisim');

            nuIdHash := tmp_tbDetLisim.first;

            LOOP

                -- Condici?n de salida
                EXIT WHEN nuIdHash IS NULL;

                -- Se insertan los registros cuyo Porcentaje de Incumplimiento y
                -- Perdida de Cumplimiento sean diferente de cero

                td('tmp_tbDetLisim(nuIdHash).delicons(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delicons(1));
                td('tmp_tbDetLisim(nuIdHash).delidimo(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delidimo(1));
                td('tmp_tbDetLisim(nuIdHash).delipudm(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delipudm(1));
                td('tmp_tbDetLisim(nuIdHash).delimxam(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delimxam(1));
                td('tmp_tbDetLisim(nuIdHash).delipmam(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delipmam(1));
                td('tmp_tbDetLisim(nuIdHash).delimxsm(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delimxsm(1));
                td('tmp_tbDetLisim(nuIdHash).delipmsm(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delipmsm(1));
                td('tmp_tbDetLisim(nuIdHash).deliprsm(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .deliprsm(1));
                td('tmp_tbDetLisim(nuIdHash).delippsm(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delippsm(1));
                td('tmp_tbDetLisim(nuIdHash).deliprtm(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .deliprtm(1));
                td('tmp_tbDetLisim(nuIdHash).delipptm(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delipptm(1));
                td('tmp_tbDetLisim(nuIdHash).delimoca(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delimoca(1));
                td('tmp_tbDetLisim(nuIdHash).delipmca(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delipmca(1));
                td('tmp_tbDetLisim(nuIdHash).delicuap(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delicuap(1));
                td('tmp_tbDetLisim(nuIdHash).delipcap(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delipcap(1));
                td('tmp_tbDetLisim(nuIdHash).delicumx(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delicumx(1));
                td('tmp_tbDetLisim(nuIdHash).delipcmx(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delipcmx(1));
                td('tmp_tbDetLisim(nuIdHash).delicuuf(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delicuuf(1));
                td('tmp_tbDetLisim(nuIdHash).delipcuf(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delipcuf(1));
                td('tmp_tbDetLisim(nuIdHash).deliinte(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .deliinte(1));
                td('tmp_tbDetLisim(nuIdHash).delifact(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delifact(1));
                td('tmp_tbDetLisim(nuIdHash).delipecu(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delipecu(1));
                td('tmp_tbDetLisim(nuIdHash).deliprcu(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .deliprcu(1));
                td('tmp_tbDetLisim(nuIdHash).deliprin(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .deliprin(1));
                td('tmp_tbDetLisim(nuIdHash).delinuse(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delinuse(1));
                td('tmp_tbDetLisim(nuIdHash).delifeco(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delifeco(1));
                --TEAM 571  IC_DETLISIM
                td('tmp_tbDetLisim(nuIdHash).delimout(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delimout(1));
                td('tmp_tbDetLisim(nuIdHash).delimoua(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delimoua(1));
                td('tmp_tbDetLisim(nuIdHash).delimous(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delimous(1));
                td('tmp_tbDetLisim(nuIdHash).delimoss(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delimoss(1));
                td('tmp_tbDetLisim(nuIdHash).delipout(1) : ' || tmp_tbDetLisim(nuIdHash)
                   .delipout(1));
                IF (tmp_tbDetLisim(nuIdHash).deliprin(1) <> 0 AND tmp_tbDetLisim(nuIdHash)
                   .delipecu(1) <> 0) THEN
                    td('Registro de producto a insertar: ' || nuIdHash);
                    rcDetLisim.delicons := pkgeneralservices.fnuGetNextSequenceVal('SQ_IC_DETLISIM_184460');
                    rcDetLisim.delidimo := tmp_tbDetLisim(nuIdHash).delidimo(1);
                    rcDetLisim.delipudm := tmp_tbDetLisim(nuIdHash).delipudm(1);
                    rcDetLisim.delimxam := tmp_tbDetLisim(nuIdHash).delimxam(1);
                    rcDetLisim.delipmam := tmp_tbDetLisim(nuIdHash).delipmam(1);
                    rcDetLisim.delimxsm := tmp_tbDetLisim(nuIdHash).delimxsm(1);
                    rcDetLisim.delipmsm := tmp_tbDetLisim(nuIdHash).delipmsm(1);
                    rcDetLisim.deliprsm := tmp_tbDetLisim(nuIdHash).deliprsm(1);
                    rcDetLisim.delippsm := tmp_tbDetLisim(nuIdHash).delippsm(1);
                    rcDetLisim.deliprtm := tmp_tbDetLisim(nuIdHash).deliprtm(1);
                    rcDetLisim.delipptm := tmp_tbDetLisim(nuIdHash).delipptm(1);
                    rcDetLisim.delimoca := tmp_tbDetLisim(nuIdHash).delimoca(1);
                    rcDetLisim.delipmca := tmp_tbDetLisim(nuIdHash).delipmca(1);
                    rcDetLisim.delicuap := tmp_tbDetLisim(nuIdHash).delicuap(1);
                    rcDetLisim.delipcap := tmp_tbDetLisim(nuIdHash).delipcap(1);
                    rcDetLisim.delicumx := tmp_tbDetLisim(nuIdHash).delicumx(1);
                    rcDetLisim.delipcmx := tmp_tbDetLisim(nuIdHash).delipcmx(1);
                    rcDetLisim.delicuuf := tmp_tbDetLisim(nuIdHash).delicuuf(1);
                    rcDetLisim.delipcuf := tmp_tbDetLisim(nuIdHash).delipcuf(1);
                    rcDetLisim.deliinte := tmp_tbDetLisim(nuIdHash).deliinte(1);
                    rcDetLisim.delifact := tmp_tbDetLisim(nuIdHash).delifact(1);
                    rcDetLisim.delipecu := tmp_tbDetLisim(nuIdHash).delipecu(1);
                    rcDetLisim.deliprcu := tmp_tbDetLisim(nuIdHash).deliprcu(1);
                    rcDetLisim.deliprin := tmp_tbDetLisim(nuIdHash).deliprin(1);
                    rcDetLisim.delinuse := tmp_tbDetLisim(nuIdHash).delinuse(1);
                    rcDetLisim.delifeco := tmp_tbDetLisim(nuIdHash).delifeco(1);
                    --TEAM 571
                    rcDetLisim.delimout := tmp_tbDetLisim(nuIdHash).delimout(1);
                    rcDetLisim.delimoua := tmp_tbDetLisim(nuIdHash).delimoua(1);
                    rcDetLisim.delimous := tmp_tbDetLisim(nuIdHash).delimous(1);
                    rcDetLisim.delimoss := tmp_tbDetLisim(nuIdHash).delimoss(1);
                    rcDetLisim.delipout := tmp_tbDetLisim(nuIdHash).delipout(1);

                    pktblic_detlisim.InsRecord(rcDetLisim);

                END IF;

                -- Actualiza el ?ndice con la siguiente posici?n de la tabla
                nuIdHash := tmp_tbDetLisim.next(nuIdHash);

            END LOOP;

            pkgeneralservices.TraceData('Termina Insercion en IC_detLisim');

            pkerrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END InsertSetOfDetLisim;

        /*
            Propiedad intelectual de Open International Systems (c).

            Procedimiento : InsertSetOfMoviprov
            Descripci?n   : Inserta Registros en la entidad Provisi?n de Cartera.

            Autor     :   Claudia Liliana Rodr?guez
            Fecha     :   23-03-2012 08:37:57

            Historia de Modificaciones
            Fecha     IDEntrega

            23-03-2012  crodriguezSAO180613
            Creaci?n.
        */

        PROCEDURE InsertSetOfMoviprov IS
            -----------------------------------------------------------------------
            -- Variables
            -----------------------------------------------------------------------
            -- Record para insertar datos en la entidad ic_cartprov

            rcIC_moviprov ic_moviprov%ROWTYPE;

        BEGIN

            pkErrors.Push('IC_BOLisimProvGen.ProcessGen.InsertSetOfMoviprov');

            pkgeneralservices.TraceData('Cantidad de registros a insertar: ' ||
                                        to_char(IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprtido.count));

            IF (IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprtido.first IS NOT NULL) THEN

                -- Ingresa el registro en la entidad
                pktblic_moviprov.insRecords(IC_BOLisimProvGen.tmp_tbIc_moviprov);

            END IF;

            pkerrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END InsertSetOfMoviprov;

        /*
            Propiedad intelectual de Open International Systems (c).

            Procedimiento : ObtRelaHE_PortfProv
            Descripci?n   : Obtener relaci?n de registros de HE con Provisi?n de
                            cartera.

            Autor     :   Claudia Liliana Rodr?guez
            Fecha     :   23-03-2012 08:37:57

            Historia de Modificaciones
            Fecha     IDEntrega

            17-07-2013  hlopez.SAO212472
            Se adiciona el atributo Clasificaci?n Contable del Contrato.
            - Se modifica el m?todo <FillTbMoviProv>

            13-08-2012 gduqueSAO188355
            Se modifica el metodo <GetAdditionalData>

            23-03-2012  crodriguezSAO180613
            Creaci?n.
        */
        PROCEDURE ObtRelaHE_PortfProv
        (
            inuDogenudo IN ic_movimien.movinudo%TYPE,
            dtFchCon    IN ic_cartprov.caprfeco%TYPE
        ) IS

            -- Llave hash
            sbhash VARCHAR2(250);
            -- Nit Tercero de cobro
            sbNitSerCon ic_movimien.movinips%TYPE;

            -- Centro de costo
            sbceco suscripc.suscceco%TYPE;
            -- Identificaci?n del Cliente
            sbIdentClie ge_subscriber.identification%TYPE;
            -- Tipo de Cartera
            sbPortfoType ic_movimien.movitica%TYPE;
            -- Empresa Prestadora del servicio
            sbsipr ic_movimien.movisipr%TYPE;
            -- Empresa Due?a de la Factura
            sbsifa ic_movimien.movisifa%TYPE;
            -- Empresa Due?a del Ciclo de Facturaci?n
            nusicl ciclo.ciclsist%TYPE;
            -- Periodo de Facturaci?n
            nuPeriodo perifact.pefacodi%TYPE;
            -- Rc entidad periodo
            rcPeriodo perifact%ROWTYPE;
            -- Unidad de Negocio
            nuUniNego servempr.seemempr%TYPE;
            -- Nit del Tercero de Cobro
            sbNitTercCo ic_movimien.movinips%TYPE;

            -- METODOS PRIVADOS

            /***********************************************************************
                Propiedad Intelectual de Open International Systems (c).
                Procedure     : GetNiTerCo

                Descripcion     :  Retorna el NIT de Tercero

                Parametros     :    Descripcion

                Autor    : Claudia Liliana Rodr?guez
                Fecha    : 23-03-2012

                Historia de Modificaciones
                Fecha       IDEntrega

                23-03-2012 crodriguezSAO180613
                creacion
            ***********************************************************************/
            PROCEDURE GetNiTerCo
            (
                inuService IN servempr.seemserv%TYPE,
                inuConcept IN concepto.conccodi%TYPE,
                osbNit     OUT ic_movimien.movinips%TYPE
            ) IS
                -- Registro de servicio
                rcServicio servicio%ROWTYPE;

            BEGIN

                pkErrors.Push('IC_BOLisimProvGen.GetNiTerCo');

                osbNit := NULL;

                IF (pktblServicio.fblExist(inuService)) THEN
                    -- Obtiene registro de tipo de producto
                    rcServicio := pktblServicio.frcGetRecord(inuService);

                    -- Si el concepto y el servicio es de un tercero se obtiene nit
                    -- del tercero
                    IF pktblConcterc.fblExist(rcServicio.servteco, inuConcept) THEN

                        IF (pktblTerccobr.fblExist(rcServicio.servteco)) THEN
                            -- Nit del tercero
                            osbNit := pktblTerccobr.frcGetRecord(rcServicio.servteco)
                                      .teconit;
                        END IF;
                        -- Obtiene nit de la empresa del usuario que ejecuta el poceso.
                    ELSE
                        -- Nit de la empreas
                        osbNit := pktblSistema.frcGetRecord(Sa_bosystem.fnuGetUserCompanyId)
                                  .sistnitc;
                    END IF;

                END IF;

                pkErrors.Pop;

            EXCEPTION
                WHEN LOGIN_DENIED
                     OR ex.CONTROLLED_ERROR THEN
                    pkErrors.pop;
                    RAISE LOGIN_DENIED;
                WHEN pkConstante.exERROR_LEVEL2 THEN
                    pkErrors.pop;
                    RAISE pkConstante.exERROR_LEVEL2;
                WHEN OTHERS THEN
                    pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                    pkErrors.pop;
                    raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

            END GetNiTerCo;

            /***********************************************************************
                 Propiedad Intelectual de Open International Systems (c).
                 Procedure     : GetSuscDeta

                 Descripcion     :  Retorna la Identificaci?n del cliente y el centro de
                                    costo a partir del atributo (Contabilidad Detallada)

                 Parametros     :    Descripcion

                 Autor    : Claudia Liliana Rodr?guez
                 Fecha    : 23-03-2012

                 Historia de Modificaciones
                 Fecha       IDEntrega

                 23-03-2012 crodriguezSAO180613
                 creacion
            *************************************************************************/

            PROCEDURE GetSuscDeta
            (
                inuSusc IN suscripc.susccodi%TYPE,
                inuIdcl IN ge_subscriber.identification%TYPE,
                osbceco OUT suscripc.suscceco%TYPE,
                osbIdcl OUT ge_subscriber.identification%TYPE,
                onusifa OUT suscripc.suscsist%TYPE
            ) IS
                -- Registro de servicio
                rcSuscripc suscripc%ROWTYPE;
            BEGIN

                pkErrors.Push('IC_BOLisimProvGen.GetSuscDeta');

                osbceco := NULL;
                osbIdcl := NULL;

                IF (pktblsuscripc.fblExist(inuSusc)) THEN

                    -- Obtiene registro de tipo de producto
                    rcSuscripc := pktblsuscripc.frcGetRecord(inuSusc);

                    -- Si el contrato requiere Contabilidad Detallada
                    IF (rcSuscripc.suscdeta = 'S') THEN
                        osbceco := rcSuscripc.suscceco;
                        osbIdcl := inuIdcl;
                    END IF;

                    onusifa := rcSuscripc.suscsist;

                END IF;

                pkErrors.Pop;
            EXCEPTION
                WHEN LOGIN_DENIED
                     OR ex.CONTROLLED_ERROR THEN
                    pkErrors.pop;
                    RAISE LOGIN_DENIED;
                WHEN pkConstante.exERROR_LEVEL2 THEN
                    pkErrors.pop;
                    RAISE pkConstante.exERROR_LEVEL2;
                WHEN OTHERS THEN
                    pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                    pkErrors.pop;
                    raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

            END GetSuscDeta;

            /***********************************************************************
                Propiedad Intelectual de Open International Systems (c).
                Procedure     : GetCompany

                Descripcion     :  Retorna las empresas
                                   1. Prestadora del servicio
                                   2. Due?a de la factura

                Parametros     :    Descripcion

                Autor    : Claudia Liliana Rodr?guez
                Fecha    : 23-03-2012

                Historia de Modificaciones
                Fecha       IDEntrega

                23-03-2012 crodriguezSAO180613
                creacion
            ***********************************************************************/
            PROCEDURE GetCompany
            (
                inuNuse IN servsusc.sesunuse%TYPE,
                onusipr OUT ic_movimien.movisipr%TYPE
            )

             IS

                rcServsusc servsusc%ROWTYPE;

            BEGIN

                pkErrors.Push('IC_BOLisimProvGen.GetCompany');

                -- Obtiene empresa Due?a del producto
                rcServsusc := pktblservsusc.frcGetRecord(inuNuse);
                onusipr    := rcServsusc.sesusist;

                pkErrors.Pop;

            EXCEPTION
                WHEN LOGIN_DENIED
                     OR ex.CONTROLLED_ERROR THEN
                    pkErrors.pop;
                    RAISE LOGIN_DENIED;
                WHEN pkConstante.exERROR_LEVEL2 THEN
                    pkErrors.pop;
                    RAISE pkConstante.exERROR_LEVEL2;
                WHEN OTHERS THEN
                    pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                    pkErrors.pop;
                    raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

            END GetCompany;

            /***********************************************************************
                Propiedad Intelectual de Open International Systems (c).
                Procedure     : BussUnit

                Descripcion     :  Retorna la Unidad de Negocio

                Parametros     :    Descripcion

                Autor    : Claudia Liliana Rodr?guez
                Fecha    : 23-03-2012

                Historia de Modificaciones
                Fecha       IDEntrega

                23-03-2012 crodriguezSAO180613
                creacion
            ***********************************************************************/

            PROCEDURE BussUnit
            (
                inuService  IN servempr.seemserv%TYPE,
                onuBussUnit OUT servempr.seemempr%TYPE
            ) IS
                rcServempr servempr%ROWTYPE;
            BEGIN

                pkErrors.Push('IC_BOLisimProvGen.BussUnit ');

                -- Obtiene empresa asociada al servicio suscrito
                rcServempr  := pktblServempr.frcGetRecord(inuService);
                onuBussUnit := rcServempr.seemempr;

                pkErrors.Pop;

            EXCEPTION
                WHEN OTHERS THEN
                    pkErrors.Pop;
                    onuBussUnit := NULL;
            END BussUnit;

            /*
                 Propiedad intelectual de Open International Systems (c).

                 Funci?n     : FillTbMoviProv
                 Descripci?n : Llenar tabla PL de Ic_moviprov

                 Par?metros    :
                                 inuIndProvCart   : Indice de la tabla tm cartprov
                                 inuIndMovi       : Indice de la tabla tm movimien
                                 inuciclo         : Ciclo
                                 isbsipr          : Empresa Producto
                                 isbsifa          : Empresa Facrtura
                                 iTermShort       : Plazo Cartera
                                 isbPortfoType    : Tipo Cartera
                                 inuUniNego       : Unidad Negocio
                                 isbNitTercCo     : Nit Tercero Cobro
                                 isbceco          : Centro Costo
                                 isbIdentClie     : Id Cliente
                                 inuDogenudo      : Documento Generado IC
                                 idtFechaCo       : Fecha Contabilizaci?n



                 Autor     :   Claudia Liliana Rodr?guez Garc?a
                 Fecha     :   23-03-2012 17:05:46

                 Historia de Modificaciones
                 Fecha     IDEntrega

                 17-07-2013  hlopez.SAO212472
                 Se adiciona el atributo Clasificaci?n Contable del Contrato.

                 08-04-2013   sgomez.SAO205719
                 Se modifica <Provisi?n LISIM> por impacto en <Hechos Econ?micos>
                 (adici?n de atributo <?tem>).

                 19-08-2012  gduqueSAO188626
                 Se adiciona los campos MVPRNUFA,MVPRCALE,MVPRTITR,MVPRTIUO,MVPRTIBR,
                 MVPRNIBT,MVPRNIBR,MVPRNICA,MVPRCUPO,MVPRVABA.
                 Se elimina los campos MVPRTIPR,MVPRESPR,MVPRORDE,MVPRCONT

                 23-03-2012  crodriguezSAO180613
                 Creaci?n.
            */

            PROCEDURE FillTbMoviProv
            (
                inuIndProvCart IN NUMBER,
                inuIndMovi     IN NUMBER,
                inusicl        IN ic_movimien.movisici%TYPE,
                inusipr        IN ic_movimien.movisipr%TYPE,
                inusifa        IN ic_movimien.movisifa%TYPE,
                inuUniNego     IN servempr.seemempr%TYPE,
                isbNitTercCo   IN ic_movimien.movinips%TYPE,
                isbceco        IN suscripc.suscceco%TYPE,
                isbIdentClie   IN ge_subscriber.identification%TYPE,
                inuDogenudo    IN ic_movimien.movinudo%TYPE,
                idtFechaCo     IN ic_movimien.movifeco%TYPE
            ) IS
            BEGIN
                pkerrors.Push('IC_BOLisimProvGen.ProcessLisimGen.ObtRelaHE_PortfProv.FillTbMoviProv');

                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprtido(inuIndMovi) := IC_BOLisimProvGen.cnuTIDOCART;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprnudo(inuIndMovi) := inuDogenudo;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprtimo(inuIndMovi) := cnuTIMOCART;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprfeco(inuIndMovi) := trunc(idtFechaCo);
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprvalo(inuIndMovi) := IC_BOLisimProvGen.tmpIC_cartprov.caprvapr(inuIndProvCart);
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprcicl(inuIndMovi) := IC_BOLisimProvGen.tmpIC_cartprov.caprcicl(inuIndProvCart);
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprserv(inuIndMovi) := IC_BOLisimProvGen.tmpIC_cartprov.caprserv(inuIndProvCart);
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprempr(inuIndMovi) := inuUniNego;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprcate(inuIndMovi) := IC_BOLisimProvGen.tmpIC_cartprov.caprcate(inuIndProvCart);
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprsuca(inuIndMovi) := IC_BOLisimProvGen.tmpIC_cartprov.caprsuca(inuIndProvCart);
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprconc(inuIndMovi) := IC_BOLisimProvGen.tmpIC_cartprov.caprconc(inuIndProvCart);
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprcaca(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprbanc(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprsuba(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprtdsr(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprtitb(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprbatr(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprcuba(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprnutr(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprfetr(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprsusc(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprceco(inuIndMovi) := isbceco;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprterc(inuIndMovi) := isbIdentClie;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprusua(inuIndMovi) := sbUserName;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprterm(inuIndMovi) := sbTerminal;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprfopa(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprcldp(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprsipr(inuIndMovi) := inusipr;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprsire(inuIndMovi) := NULL; -- Usuario Ejecutor
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprtidi(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprfeap(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprfeve(inuIndMovi) := trunc(IC_BOLisimProvGen.tmpIC_cartprov.caprfeve(inuIndProvCart));
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprvatr(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprnips(inuIndMovi) := isbNitTercCo;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprtica(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprancb(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprmecb(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprsivr(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprsifa(inuIndMovi) := inusifa;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprsici(inuIndMovi) := inusicl;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprubg1(inuIndMovi) := IC_BOLisimProvGen.tmpIC_cartprov.caprubg1(inuIndProvCart);
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprubg2(inuIndMovi) := IC_BOLisimProvGen.tmpIC_cartprov.caprubg2(inuIndProvCart);
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprubg3(inuIndMovi) := IC_BOLisimProvGen.tmpIC_cartprov.caprubg3(inuIndProvCart);
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprubg4(inuIndMovi) := IC_BOLisimProvGen.tmpIC_cartprov.caprubg4(inuIndProvCart);
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprubg5(inuIndMovi) := IC_BOLisimProvGen.tmpIC_cartprov.caprubg5(inuIndProvCart);
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprnaca(inuIndMovi) := IC_BOLisimProvGen.tmpIC_cartprov.caprnaca(inuIndProvCart);
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprproy(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprvaba(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprcupo(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprnica(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprclit(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprnibr(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprnibt(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprtibr(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprtiuo(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprtitr(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprcale(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprnufa(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprtihe(inuIndMovi) := csbTIHE;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprcons(inuIndMovi) := pkgeneralservices.fnuGetNextSequenceVal('SQ_IC_MOVIMIEN_175553');
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprtoim(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.Mvprimp1(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.Mvprimp2(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.Mvprimp3(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprvtir(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.Mvprvir1(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.Mvprvir2(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.Mvprvir3(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprunid(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprdipr(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvpritem(inuIndMovi) := NULL;
                IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprclcc(inuIndMovi) := NULL;

                IF (IC_BOLisimProvGen.tmpIC_cartprov.caprsape(inuIndProvCart) > 0) THEN
                    IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprsign(inuIndMovi) := 'D';
                ELSE
                    IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprsign(inuIndMovi) := 'C';

                END IF;

                pkerrors.Pop;

            EXCEPTION
                WHEN LOGIN_DENIED
                     OR ex.CONTROLLED_ERROR THEN
                    pkErrors.pop;
                    RAISE LOGIN_DENIED;
                WHEN pkConstante.exERROR_LEVEL2 THEN
                    pkErrors.pop;
                    RAISE pkConstante.exERROR_LEVEL2;
                WHEN OTHERS THEN
                    pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                    pkErrors.pop;
                    raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);
            END FillTbMoviProv;

            /*
                Propiedad intelectual de Open International Systems (c).

                Funci?n     : GetAdditionalData
                Descripci?n : Obtiene informaci?n adicional para los movimientos HE

                Par?metros    :
                         idx            Indice de la tabla que contiene los registros de Provisi?n
                         osbNitTercCo   Nit del Tercero de Cobro
                         osbceco        Centro de Costo
                         osbIdentClie   Id del Cliente
                         onusifa        Empresa due?a Factura
                         onusipr        Empresa due?a Producto
                         onusicl        Empresa due?a del Ciclo
                         onuUniNego     Unidad de Negocio

                Autor     :   Claudia Liliana Rodr?guez Garc?a
                Fecha     :   23-03-2012 17:05:46

                Historia de Modificaciones
                Fecha     IDEntrega

                13-08-2012  gduqueSAO188355
                Se valida si el producto es dependiente

                23-03-2012  crodriguezSAO180613
                Creaci?n.
            */

            PROCEDURE GetAdditionalData
            (
                idx          IN NUMBER,
                osbNitTercCo OUT ic_movimien.movinips%TYPE,
                osbceco      OUT suscripc.suscceco%TYPE,
                osbIdentClie OUT ge_subscriber.identification%TYPE,
                onusifa      OUT ic_movimien.movisifa%TYPE,
                onusipr      OUT ic_movimien.movisipr%TYPE,
                onusicl      OUT ciclo.ciclsist%TYPE,
                onuUniNego   OUT servempr.seemempr%TYPE
            ) IS

                rcServsusc Servsusc%ROWTYPE;
                -- Variables
                rcSubscriber dage_subscriber.styGE_subscriber;

            BEGIN
                pkerrors.Push('IC_BOPortfolioProv.ProcessGen.ObtRelaHE_PortfProv.GetAdditionalData');

                -- Obtiene registro del servicio
                rcServsusc := pktblServsusc.frcGetRecord(IC_BOLisimProvGen.tmpIC_cartprov.caprnuse(idx));

                -- Verifica si el producto es dependiente
                IF (rcServsusc.sesusesb <> pkconstante.NULLNUM) THEN

                    -- Obtiene registro de Producto Base
                    rcServsusc := pktblServsusc.frcGetRecord(rcServsusc.sesusesb);

                    -- Obtiene registro de Cliente
                    rcSubscriber := dage_subscriber.frcGetRecord(pktblSuscripc.fnuGetCustomer(rcServsusc.sesususc));

                    -- Centro de costo
                    GetSuscDeta(rcServsusc.sesususc, rcSubscriber.subscriber_id, osbceco, osbIdentClie, onusifa);

                    -- Empresas
                    GetCompany(rcServsusc.sesunuse, onusipr);

                ELSE

                    -- Centro de costo
                    GetSuscDeta(IC_BOLisimProvGen.tmpIC_cartprov.caprSusc(idx), IC_BOLisimProvGen.tmpIC_cartprov.caprIdcl(idx), osbceco, osbIdentClie, onusifa);

                    -- Empresas
                    GetCompany(IC_BOLisimProvGen.tmpIC_cartprov.caprnuse(idx), onusipr);

                END IF;

                -- Nit del Tercero de Cobro
                GetNiTerCo --nips
                (IC_BOLisimProvGen.tmpIC_cartprov.caprserv(idx), IC_BOLisimProvGen.tmpIC_cartprov.caprconc(idx), osbNitTercCo);

                -- Ciclo de Facturaci?n
                IF (IC_BOLisimProvGen.tmpIC_cartprov.caprcicl(idx) IS NOT NULL) THEN
                    -- Obtiene empresa del ciclo de Facturaci?n
                    onusicl := pktblciclo.fnuGetCiclsist(IC_BOLisimProvGen.tmpIC_cartprov.caprcicl(idx));

                ELSE
                    onusicl := NULL;
                END IF;

                -- Unidad de Negocio
                BussUnit(IC_BOLisimProvGen.tmpIC_cartprov.caprserv(idx), onuUniNego);

                pkerrors.Pop;

            EXCEPTION
                WHEN LOGIN_DENIED
                     OR ex.CONTROLLED_ERROR THEN
                    pkErrors.pop;
                    RAISE LOGIN_DENIED;
                WHEN pkConstante.exERROR_LEVEL2 THEN
                    pkErrors.pop;
                    RAISE pkConstante.exERROR_LEVEL2;
                WHEN OTHERS THEN
                    pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                    pkErrors.pop;
                    raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

            END GetAdditionalData;

        BEGIN
            pkerrors.Push('IC_BOLisimProvGen.ProcessGen.ObtRelaHE_PortfProv');

            -- Recorre tabla temporal que contiene los registros de cartera provisionada
            IF (IC_BOLisimProvGen.tmpIC_cartprov.caprserv.first IS NOT NULL) THEN

                -- Recorre tabla temporal con registros de cartera provisionada
                FOR idx IN IC_BOLisimProvGen.tmpIC_cartprov.caprserv.first .. IC_BOLisimProvGen.tmpIC_cartprov.caprserv.last
                LOOP

                    -- Obtienen datos para armar llave Hash
                    GetAdditionalData(idx, sbNitTercCo, sbceco, sbIdentClie, sbsifa, sbsipr, nusicl, nuUniNego);

                    -- Arma llave Hash ic_cartprov para obtener los HE
                    sbhash := IC_BOLisimProvGen.tmpIC_cartprov.caprserv(idx) || '|' || -- Tipo de Producto
                              IC_BOLisimProvGen.tmpIC_cartprov.caprconc(idx) || '|' || -- Concepto
                              IC_BOLisimProvGen.tmpIC_cartprov.caprcate(idx) || '|' || -- Categoria
                              IC_BOLisimProvGen.tmpIC_cartprov.caprsuca(idx) || '|' || -- Subcategoria
                              IC_BOLisimProvGen.tmpIC_cartprov.caprcicl(idx) || '|' || -- Ciclo
                              nusicl || '|' || -- Empresa Due?a del Ciclo
                              trunc(IC_BOLisimProvGen.tmpIC_cartprov.caprfeve(idx)) || '|' || -- Fecha de Vencimiento
                              sbsipr || '|' || -- Empresa Due?a del producto
                              sbsifa || '|' || -- Empresa Due?a de la Factura
                              IC_BOLisimProvGen.tmpIC_cartprov.caprnaca(idx) || '|' || -- Naturaleza de Cartera
                              nuUniNego || '|' || -- Unidad de Negocio
                              sbNitTercCo || '|' || -- Nit del tercero de cobro
                              sbceco || '|' || -- Centro de Costo
                              sbIdentClie || '|' || -- Id Cliente
                              IC_BOLisimProvGen.tmpIC_cartprov.caprubg1(idx) || '|' ||
                              IC_BOLisimProvGen.tmpIC_cartprov.caprubg2(idx) || '|' ||
                              IC_BOLisimProvGen.tmpIC_cartprov.caprubg3(idx) || '|' ||
                              IC_BOLisimProvGen.tmpIC_cartprov.caprubg4(idx) || '|' ||
                              IC_BOLisimProvGen.tmpIC_cartprov.caprubg5(idx);

                    pkgeneralservices.TraceData('Indice Hash: ' || sbhash);

                    IF (NOT IC_BOLisimProvGen.tmp_tbhashIndex.exists(sbhash)) THEN
                        -- Crea nuevo registro en la tabla hash con el indice en ic_movimien
                        IC_BOLisimProvGen.tmp_tbhashIndex(sbhash) := IC_BOLisimProvGen.nuIndHash;

                        -- Crea Registro en la tabla de Ic_movimien
                        FillTbMoviProv(idx, -- Indice de tabla con cartprov
                                       IC_BOLisimProvGen.nuIndHash, -- Indice almac en tb hash
                                       nusicl, sbsipr, sbsifa, nuUniNego, sbNitTercCo, sbceco, sbIdentClie, inuDogenudo, dtFchCon);
                        pkgeneralservices.TraceData('IC_BOLisimProvGen.tmp_tbhashIndex(sbhash): ' ||
                                                    IC_BOLisimProvGen.nuIndHash);
                        -- Actualiza Indice
                        IC_BOLisimProvGen.nuIndHash := IC_BOLisimProvGen.nuIndHash + 1;

                        -- El HE ya existe
                    ELSE
                        -- Actualiza el valor Total en la tabla de Ic_movimien
                        IF (IC_BOLisimProvGen.tmpIC_cartprov.caprvapr(idx)) > 0 THEN
                            -- Actualiza el valor del HE (Positivos)
                            IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprvalo(IC_BOLisimProvGen.tmp_tbhashIndex(sbhash)) := IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprvalo(IC_BOLisimProvGen.tmp_tbhashIndex(sbhash)) +
                                                                                                                       IC_BOLisimProvGen.tmpIC_cartprov.caprvapr(idx);
                        ELSE
                            -- Actualiza el valor del HE (Negativos)
                            IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprvalo(IC_BOLisimProvGen.tmp_tbhashIndex(sbhash)) := IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprvalo(IC_BOLisimProvGen.tmp_tbhashIndex(sbhash)) -
                                                                                                                       IC_BOLisimProvGen.tmpIC_cartprov.caprvapr(idx);
                        END IF;

                    END IF;

                    -- Actualiza consecutivo de HE en la entidad de Provisi?n de Cartera para cada registro
                    IC_BOLisimProvGen.tmpIC_cartprov.caprmovi(idx) := IC_BOLisimProvGen.tmp_tbIc_moviprov.mvprcons(IC_BOLisimProvGen.tmp_tbhashIndex(sbhash));
                    pkgeneralservices.TraceData('IC_BOLisimProvGen.tmpIC_cartprov.caprcons(idx): ' ||
                                                IC_BOLisimProvGen.tmpIC_cartprov.caprmovi(idx));

                END LOOP;
            END IF;

            pkerrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

        END ObtRelaHE_PortfProv;

    BEGIN
        --        ut_trace.init;
        --        ut_trace.setlevel(99);

        ut_trace.trace('-- PASO 1. [JOSELC - IC_BOLISIMPROVGEN]. Inicio', 1);
        pkErrors.Push('IC_BOLisimProvGen.ProcessLisimGen');

        -- Inicializa variables
        Initialize;
        ut_trace.trace('-- PASO 2. [JOSELC - IC_BOLISIMPROVGEN]. Inicializar', 1);
        -- Inicia ciclo para procesar los datos de cartera.
        pkgeneralservices.TraceData('Obtiene Reg Cartera Fecha: ' ||
                                    IC_BOLisimProvGen.dtFinishDate);
        ut_trace.trace('-- PASO 3. [JOSELC - IC_BOLISIMPROVGEN]. Inicia ciclo para procesar los datos de cartera', 1);
        LOOP
            -- Obtiene registros de Cartera con Hilos
            ic_bclisimprovGen.ObtCartera(dtFechaProceso, nuPivote, isbTyPrEx, inuNumHilos, inuHilo, rctbCartera);

            EXIT WHEN rctbCartera.caprserv.first IS NULL;

            -- Cantidad de registros procesados
            nuRegProc := rctbCartera.caprserv.count;

            pkgeneralservices.TraceData('Reg Obtenidos: ' || nuRegProc);
            pkgeneralservices.TraceData('Tipos Productos Excluidos: ' ||
                                        isbTyPrEx);

            -- Recorre los registros para asignar el valor  de provisi?n
            FOR nuidx IN rctbCartera.caprserv.first .. rctbCartera.caprserv.last
            LOOP

                -- Obtiene el producto
                nuProducto := rctbCartera.caprnuse(nuidx);

                -- Verifica si las variables LISIM ya se calcularon para el producto
                IF (NOT tmp_tbDetLisim.exists(nuProducto)) THEN

                    -- Obtiene las cuentas de cobro del producto
                    GetAccountsByProduct(nuProducto);

                    -- V?lida que existan cuentas de cobro.
                    IF (IC_BOLisimProvGen.tmp_tbCuentasProd.cucocodi.first IS NOT NULL) THEN

                        -- Obtiene las variables para el producto
                        GetLisimDetail(nuProducto, dtFechaProceso);

                    END IF;

                END IF;

                -- Valida que exista detalle LISIM (No existen cuentas a procesar  para el ?ltimo a?o)
                IF (tmp_tbDetLisim.exists(nuProducto)) THEN

                    -- Obtiene valor a provisionar (Probabilidad Incumplimiento * Perdida Cumplimiento * Saldo Pendiente)
                    nuValProv := (tmp_tbDetLisim(nuProducto).deliprin(1) / 100) *
                                 (tmp_tbDetLisim(nuProducto).delipecu(1) / 100) *
                                 rctbCartera.caprsape(nuidx);

                    td('nuValProv : ' || nuValProv);
                    td('Probabilidad Incumplimiento: ' ||
                       (tmp_tbDetLisim(nuProducto).deliprin(1) / 100));
                    td('Perdida Cumplimiento: ' ||
                       (tmp_tbDetLisim(nuProducto).delipecu(1) / 100));
                    td('Saldo Pendiente: ' || rctbCartera.caprsape(nuidx));
                    td('Cuenta: ' || rctbCartera.caprcuco(nuidx));

                    -- Incluya registro en la tabla temporal si el valor  a provisionar es
                    -- diferente de cero.
                    /*if  (nuValProv <> 0  ) then*/ --lmfg
                    -- Llamado al metodo para insertar el registro en la tabla PL temporal
                    FillrecordPortProv(rctbCartera.caprnaca(nuidx), rctbCartera.caprticl(nuidx), rctbCartera.capridcl(nuidx), rctbCartera.caprclie(nuidx), rctbCartera.caprsusc(nuidx), rctbCartera.caprserv(nuidx), rctbCartera.caprnuse(nuidx), rctbCartera.capresco(nuidx), rctbCartera.caprcate(nuidx), rctbCartera.caprsuca(nuidx), rctbCartera.caprtico(nuidx), rctbCartera.caprpref(nuidx), rctbCartera.caprnufi(nuidx), rctbCartera.caprcomp(nuidx), rctbCartera.caprcuco(nuidx), rctbCartera.caprconc(nuidx), rctbCartera.caprfeve(nuidx), rctbCartera.caprfege(nuidx), rctbCartera.caprsape(nuidx), nuValProv, rctbCartera.caprubg1(nuidx), rctbCartera.caprubg2(nuidx), rctbCartera.caprubg3(nuidx), rctbCartera.caprubg4(nuidx), rctbCartera.caprubg5(nuidx), rctbCartera.caprcicl(nuidx));
                    /*END if;*/ --LMFG

                END IF;

            END LOOP;
            ut_trace.trace('-- PASO 4. [JOSELC - IC_BOLISIMPROVGEN]. Sale del Loop', 1);
            -- Asigna valor al pivote para procesar el siguiente bloque
            nuPivote := rctbCartera.caprcons(rctbCartera.caprcons.last);
            ut_trace.trace('-- PASO 5. [JOSELC - IC_BOLISIMPROVGEN]. nuPivote:' ||
                           nuPivote, 1);

            -- Procesa los registros obtenidos respecto a ic_movimien
            -- y arma llave hash con indices de la tabla
            ObtRelaHE_PortfProv(nuDogenudo, IC_BOLisimProvGen.dtFinishDate);
            ut_trace.trace('-- PASO 6. [JOSELC - IC_BOLISIMPROVGEN]. ObtRelaHE_PortfProv', 1);

            -- Llamado al metodo que inserta los registros de la tabla PL  en la
            -- entidad Cartera Provisionada
            InsertSetOfPortProv;
            ut_trace.trace('-- PASO 7. [JOSELC - IC_BOLISIMPROVGEN]. InsertSetOfPortProv', 1);

            -- Actualiza el estado del proceso
            pkStatusExeProgramMgr.UpdatePercentage(IC_BOLisimProvGen.sbEstaprog, 'Procesando...', nuRegProc, nuPorcentaje);
            ut_trace.trace('-- PASO 8. [JOSELC - IC_BOLISIMPROVGEN]. UpdatePercentage', 1);

            -- limpia tabla PL temporal para procesar otro bloque
            ClearMemory;

        END LOOP;
        ut_trace.trace('-- PASO 9. [JOSELC - IC_BOLISIMPROVGEN]. FIN LOOP PRINCIPAL', 1);

        -- Inserta registros de Detalle LISIM
        InsertSetOfDetLisim;
        ut_trace.trace('-- PASO 10. [JOSELC - IC_BOLISIMPROVGEN]. InsertSetOfDetLisim', 1);
        -- Insertar registros en ic_moviprov
        InsertSetOfMoviprov;
        ut_trace.trace('-- PASO 11. [JOSELC - IC_BOLISIMPROVGEN]. InsertSetOfDetLisim', 1);
        -- Realiza Comit
        pkgeneralservices.CommitTransaction;
        ut_trace.trace('-- PASO 12. [JOSELC - IC_BOLISIMPROVGEN]. CommitTransaction', 1);
        pkErrors.Pop;
        ut_trace.trace('-- PASO 13. [JOSELC - IC_BOLISIMPROVGEN]. FIN PROCESO', 1);

    EXCEPTION
        WHEN LOGIN_DENIED
             OR ex.CONTROLLED_ERROR THEN
            pkErrors.pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            pkErrors.pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
            pkErrors.pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

    END ProcessLisimGen;

    /*
    Propiedad intelectual de Open International Systems. (c).

    Procedure : GenerateMovs
                  Generate movements

    Descripcion : Genera Movimientos

    Parametros  : Descripcion

    Retorno     :

    Autor : Claudia Liliana Rodr?guez
    Fecha : 24-04-2012

    Historia de Modificaciones
    Fecha ID Entrega

    13-08-2012  gduqueSAO188355
    Se modifica para que solo tenga en cuenta la informacion de LISIM.

    24-04-2012   crodriguezSAO180610
    creacion
    */
    PROCEDURE GenerateMovs IS

        -- Tipo Documento
        cnuTIPODOCUMENT NUMBER := 76;

        -- Tipos de Producto a excluir
        sbTyPrEx VARCHAR2(30);

        -- Flag de eliminaci?n de datos
        odlFlagDatos BOOLEAN;

        -- Tipo Hecho economico Desprovisi?n
        csbTIPODESPROV tmp_ic_moviprov.mvprtihe%TYPE := 'DC';

        -- Tabla ic_moviprov
        csbTableMOVIPROV VARCHAR2(20) := 'ic_moviprov';

    BEGIN

        pkErrors.Push('IC_BOLisimProvGen.GenerateMovs');

        -- Obtiene tipos de producto a excluir
        sbTyPrEx := ic_boprodtypexcprov.fnuGetProdTypExc;

        -- Insertar movimientos
        IC_BCProcessProvision.InsMovProvision;

        -- Insertar movimientos de devolucion de provision
        IC_BCLisimProvGen.InsMovDesProvision(cnuTIPODOCUMENT, sbTyPrEx, 'S');

        -- Limpiar tabla tmp_ic_moviprov con mov de provisi?n de FACT
        odlFlagDatos := TRUE;

        LOOP

            IC_BCLisimProvGen.DelTmpMovProvCart(cnuTIPODOCUMENT, sbTyPrEx, odlFlagDatos);
            EXIT WHEN NOT odlFlagDatos;
        END LOOP;

        -- Insertar movimientos de provision en TMP
        IC_BCProcessProvision.InsTmpMovProvision(csbTIPODESPROV);

        -- Limpiar tabla ic_moviprov
        pkGeneralServices.TableTruncate(csbTableMOVIPROV);

        pkgeneralservices.CommitTransaction;

        pkErrors.Pop;

    EXCEPTION
        WHEN LOGIN_DENIED
             OR ex.CONTROLLED_ERROR THEN
            pkErrors.pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            pkErrors.pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
            pkErrors.pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);

    END GenerateMovs;

    /*
        Propiedad intelectual de Open International Systems. (c).

        Procedimiento :   fdtFinishDate
        Descripci?n   :   Cuenta los registros de Cartera por concepto a procesar

        Par?metros    :
            idtFecha          Fecha del proceso

        Retorno     :
            nuCuenta        N?mero de registros.

        Autor     :   Claudia Liliana Rodr?guez
        Fecha     :   01-03-2012 14:28:10

        Historia de Modificaciones
        Fecha     IDEntrega

        01-03-2012  crodriguezSAO180613
        Creaci?n.
    */

    FUNCTION fdtFinishDate RETURN DATE IS

        ------------------------------------------------------------------------
        -- Variables
        ------------------------------------------------------------------------

    BEGIN

        pkErrors.Push('IC_BOPortfolioProvGen.fdtFinishDate');

        pkErrors.Pop;

        RETURN IC_BOLisimProvGen.dtFinishDate;

    EXCEPTION
        WHEN LOGIN_DENIED
             OR ex.CONTROLLED_ERROR THEN
            pkErrors.Pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            pkErrors.Pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BOLisimProvGen.sbMensajeError);
            pkErrors.Pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BOLisimProvGen.sbMensajeError);
    END;

END IC_BOLisimProvGen;
/
GRANT EXECUTE on IC_BOLISIMPROVGEN to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on IC_BOLISIMPROVGEN to REXEOPEN;
GRANT EXECUTE on IC_BOLISIMPROVGEN to RSELSYS;
/
