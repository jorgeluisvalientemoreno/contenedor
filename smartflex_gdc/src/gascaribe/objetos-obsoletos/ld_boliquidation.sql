CREATE OR REPLACE PACKAGE OPEN.Ld_BoLiquidation
IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Ld_BoLiquidation
    Descripcion    : Paquete BO con las funciones y/o
                     procedimientos para
    Autor          : AAcuna
    Fecha          : 13/11/2012 SAO 159764

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha          Autor              Modificacion
    =========   =========             ====================
    21-07-2014  KCienfuegos.RNP548    Se modifica la funcion <<FrfRestSearch>>
    29-01-2014  AEcheverrySAO231292   Se modifica <<ProcCancelBySinester>>
    11-12-2013  JCarmona.SAO225712    Se modifica el metodo <ProcCancelBySinester>
    03-12-2013  jrobayo.SAO225712     Se modifica el metodo <ProcLiquidationSearch>
    16-08-2013  hvera.SAO215048       Se modifican los metodos <FRFRESTSEARCH, ProcLiquidationProcess>
    15-08-2013  hvera.SAO213164       Se modifica el metodo <FnuValidatePackage>
    14-08-2013  hvera.SAO212868       Se modifica el metodo <ProcReLiquidationProcess>
    13-08-2013  hvera.SAO214193       Se modifica el metodo <Procaprliqu>
    ******************************************************************/

    -- Declaracion de Tipos de datos publicos

    -- Declaracion de variables publicas

    sbState          ld_parameter.value_chain%TYPE; -- Parametro del estado de la poliza
    sbCanBySin       ld_parameter.value_chain%TYPE; -- Parametro del tipo de cancelacion
    sbdtMinSin       ld_parameter.value_chain%TYPE; -- Parametro de la fecha minima
    nuCauseCancSin   ld_parameter.numeric_value%TYPE; -- Parametro causa de cancelacion por xml
    nuAnswerIdSin    ld_parameter.numeric_value%TYPE; -- Parametro de direccion de cancelacion por xml
    nuFin            ld_parameter.numeric_value%TYPE; --  Parametro de concepto de financiacion
    nuSec            ld_parameter.numeric_value%TYPE; --  Parametro de concepto de seguro
    nuFact           ld_parameter.numeric_value%TYPE; --  Parametro de concepto de facturacion
    cnuMotPackage    ld_parameter.numeric_value%TYPE; --  Parametro del numero de estado del paquete

    --------------------------------------------------------------------
    -- Variables
    --------------------------------------------------------------------
    --------------------------------------------------------------------
    -- Cursores
    --------------------------------------------------------------------

    -- Declaracion de metodos publicos

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure      :  fsbVersion
    Descripcion    :  Obtiene la Version actual del Paquete

    Parametros     :  Descripcion
    Retorno        :
    csbVersion        Version del Paquete

    Autor          :  13/11/2012 SAO 159764
    Fecha          :  20/09/2012

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    *****************************************************************/

    FUNCTION fsbVersion
        RETURN VARCHAR2;

    sbconsultation   VARCHAR2 (4000);

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProcCancelBySinester
    Descripcion    : Busca todas las polizas a partir del contrato y las cancela de acuerdo
                     al alcance del DAA 14787
    Autor          : AAcuna
    Fecha          : 18/10/2012 SAO 147879

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    PROCEDURE ProcCancelBySinester (
        inuPackage   IN mo_packages.package_id%TYPE);

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProcLiquidationSearch
    Descripcion    : Busca todas las polizas a partir del contrato y las cancela de acuerdo
                     al alcance del DAA 14787
    Autor          : AAcuna
    Fecha          : 18/10/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    FUNCTION ProcLiquidationSearch
        RETURN pkConstante.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProcLiquidationProcess
    Descripcion    : Busca todas las polizas a partir del contrato y las cancela de acuerdo
                     al alcance del DAA 14787
    Autor          : AAcuna
    Fecha          : 18/10/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    PROCEDURE ProcLiquidationProcess (isbDifCuen        IN     VARCHAR2,
                                      inuCurrent        IN     NUMBER,
                                      inuTotal          IN     NUMBER,
                                      onuErrorCode         OUT NUMBER,
                                      osbErrorMessage      OUT VARCHAR2);

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FrfRestSearch
    Descripcion    : Busca todas las polizas a partir del contrato y las cancela de acuerdo
                     al alcance del DAA 14787
    Autor          : AAcuna
    Fecha          : 18/10/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    FUNCTION FrfRestSearch
        RETURN pkConstante.tyRefCursor;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : ProcReLiquidationProcess
     Descripcion    : Procesa todas los cargos y cuentas de cobro que en el cual se habia cambiado
     Autor          : KBaquero
     Fecha          : 13/12/2012 SAO 159764

     Parametros         Descripcion
     ============   ===================
    isbDifCuen
    inuCurrent
    inuTotal
    onuErrorCode
    osbErrorMessage

     Historia de Modificaciones
     Fecha            Autor       Modificacion
     =========      =========  ====================
     ******************************************************************/

    PROCEDURE ProcReLiquidationProcess (isbDifCuen        IN     VARCHAR2,
                                        inuCurrent        IN     NUMBER,
                                        inuTotal          IN     NUMBER,
                                        onuErrorCode         OUT NUMBER,
                                        osbErrorMessage      OUT VARCHAR2);

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProcCancelBySinester
    Descripcion    : Busca todas las polizas a partir del contrato y las cancela de acuerdo
                     al alcance del DAA 14787
    Autor          : AAcuna
    Fecha          : 18/10/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    PROCEDURE GetIniLiquidation (
        inuPackage        IN     mo_packages.package_id%TYPE,
        onuSubscriberId      OUT ge_subscriber.subscriber_id%TYPE,
        osbSubName           OUT ge_subscriber.subscriber_name%TYPE);

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : GetProductByContract
    Descripcion    : Retorna 1 si la unidad operativa fue el mismo que realizo la venta y cancelacion
    Autor          : AAcuna
    Fecha          : 18/10/2012 SAO 147879

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    FUNCTION GetProductByContract (inuPackage IN mo_packages.package_id%TYPE)
        RETURN NUMBER;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ValidateProductFnb
    Descripcion    : Retorna 1 si el contrato tiene asociado algun tipo de producto 7055,7056
    Autor          : AAcuna
    Fecha          : 19/10/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    FUNCTION ValidateProductFnb (inuPackage IN mo_packages.package_id%TYPE)
        RETURN NUMBER;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : GetLiquidationAprovSearch
    Descripcion    : Busca todas la liquidacion de un contrato
                     al alcance del DAA 159764
    Autor          : KBaquero
    Fecha          : 04/12/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================


    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    FUNCTION GetLiquidationAprovSearch
        RETURN pkConstante.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuValidatePackage
    Descripcion    : Busca todas la liquidacion de un contrato
                     al alcance del DAA 159764
    Autor          : KBaquero
    Fecha          : 04/12/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================


    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    FUNCTION FnuValidatePackage (inuPackage mo_packages.package_id%TYPE)
        RETURN NUMBER;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : Procaprliqu
      Descripcion    : Busca la liquidacion de un contrato y una solicitud especifica
                       y actualiza cada campo seleccionado para aprobar la iquidacion

      Autor          : KBaquero
      Fecha          : 10/12/2012 SAO 159764

      Parametros         Descripcion
      ============   ===================
      inuPackage:      Numero del paquete

      Historia de Modificaciones
      Fecha            Autor       Modificacion
      =========      =========  ====================


    ******************************************************************/
    PROCEDURE Procaprliqu (isbDifCuen        IN     VARCHAR2,
                           inuCurrent        IN     NUMBER,
                           inuTotal          IN     NUMBER,
                           onuErrorCode         OUT NUMBER,
                           osbErrorMessage      OUT VARCHAR2);

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProcValidateContrac
    Descripcion    : Valida si un contrato tiene liquidacion para aprobar
                     al alcance del DAA 159764
    Autor          : KBaquero
    Fecha          : 12/12/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================


    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    PROCEDURE ProcValidateContrac (inususc suscripc.susccodi%TYPE);

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FrfRestSearch
    Descripcion    : Proceso que se encarga de retornar los datos de impresion para el reporte de liquidacion
                     de siniestros
    Autor          : AAcuna
    Fecha          : 18/12/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    FUNCTION frfGetReport (
        inuliquidationId     IN ld_liquidation.liquidation_id%TYPE,
        inusubscription_id   IN ld_liquidation.subscription_id%TYPE,
        inupackagedId        IN ld_liquidation.liqui_package_id%TYPE,
        inuinsuredId         IN ld_liquidation.insured_id%TYPE,
        idtclaimDate         IN ld_liquidation.loss_date%TYPE,
        idtsinesterDate      IN ld_liquidation.loss_date%TYPE,
        inucoverageType      IN ld_liquidation.coverage_type%TYPE)
        RETURN pkConstante.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProcGetParameterRep
    Descripcion    : Busca los parametros del reporte de siniestros
    Autor          : AAcuna
    Fecha          : 21/12/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha          Autor                 Modificacion
    =========      =========             ====================
    07/11/2013     Jhagudelo.SAO159764   Adicion de los parametros:
                                         - sbCity: Ciudad donde se firma la carta
                                         - sbUserFrm: Usuario que elabora la carta
    ******************************************************************/

    PROCEDURE ProcGetParameterRep (
        sbIdSigner       OUT ld_parameter.value_chain%TYPE,
        sbNameFun        OUT ld_parameter.value_chain%TYPE,
        sbHeaderLetter   OUT ld_parameter.value_chain%TYPE,
        sbReview         OUT ld_parameter.value_chain%TYPE,
        sbCity           OUT ld_parameter.value_chain%TYPE,
        sbUserFrm        OUT ld_parameter.value_chain%TYPE);

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbNameInsured
      Descripcion    : Retorna el nombre del asegurado a partir de la identificacion

      Autor          : AACuna
      Fecha          : 21/12/2012 SAO 159764

      Parametros         Descripcion
      ============   ===================
        isbIdInsured    :Identificacion del asegurado

      Historia de Modificaciones
      Fecha            Autor       Modificacion
      =========      =========  ====================

    ******************************************************************/

    FUNCTION FsbNameInsured (
        inuIdInsured   IN ge_subscriber.subscriber_id%TYPE)
        RETURN VARCHAR2;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbNameInsured
      Descripcion    : Actualiza el nombre del asegurado a partir del subscriber

      Autor          : AACuna
      Fecha          : 21/12/2012 SAO 159764

      Parametros         Descripcion
      ============   ===================
      inuPackage    : Numero de la solicitud

      Historia de Modificaciones
      Fecha            Autor       Modificacion
      =========      =========  ====================

    ******************************************************************/

    PROCEDURE UpdInsured (inuPackage IN mo_packages.package_id%TYPE);

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbDatInsured
      Descripcion    : Retorna los datos de inicializacion del asegurado para la liquidacion de
                       siniestros

      Autor          : AACuna
      Fecha          : 09/01/2013 SAO 159764

      Parametros         Descripcion
      ============   ===================
      inuPackage      :Numero de la solicitud
      osbInsured_id    Identificacion del asegurado
      osbInsured_name  Nombre del asegurado

      Historia de Modificaciones
      Fecha            Autor       Modificacion
      =========      =========  ====================

    ******************************************************************/

    PROCEDURE ProcDatInsured (
        inuPackage        IN     mo_packages.package_id%TYPE,
        osbInsured_idI       OUT ge_subscriber.subscriber_id%TYPE,
        osbInsured_name      OUT ld_sinester_claims.insured_name%TYPE,
        onuSuscripc          OUT suscripc.susccodi%TYPE,
        odtLossDate          OUT ld_sinester_claims.claims_date%TYPE);

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : FsbgetconceptsInt
     Descripcion    : Obtiene los conceptos asociados a los conceptos de interes de financiacion

     Autor          : AAcuna
     Fecha          : 28/04/2013

     Parametros       Descripcion
     ============     ===================
     isbConcept       Conceptos

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     28/04/2013       AAcuna.SAO159764      Creacion

    ******************************************************************/
    FUNCTION FsbgetconceptsInt (isbConcept IN VARCHAR2)
        RETURN VARCHAR2;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : ProcInDatRel
      Descripcion    : Inicializa los campos de la forma ldrqs (Liquidacion de siniestros)
                       Los campos que se inicializan son:
                       Fecha de siniestro, causal y tipo de cobertura con los datos que ya se tienen guardados en la liquidacion.

      Autor          : AACuna
      Fecha          : 08/05/2013 SAO 159764

      Parametros         Descripcion
      ============   ===================
      inuPackage    : Numero de la solicitud
      odtSinester   : Fecha del siniestro
      onuCausal     : Causal de la liquidacion
      onuCovType    : Tipo de cobertura
      onuError      : Error
      osbMessage    : Mensaje de error

      Historia de Modificaciones
      Fecha           Autor       Modificacion
      =========      =========  ====================
      08/05/2013     AAcuna     Creacion
    ******************************************************************/

    PROCEDURE ProcInDatRel (
        inuLiquidation   IN     ld_liquidation.liquidation_id%TYPE,
        odtSinester         OUT ld_liquidation.loss_date%TYPE,
        onuCausal           OUT ld_liquidation.application_cause_id%TYPE,
        onuCovType          OUT ld_liquidation.coverage_type%TYPE,
        onuError            OUT ge_message.message_id%TYPE,
        osbMessage          OUT ge_message.description%TYPE);

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ValidateProductFnbGnvSeguros
    Descripcion    : Esta funcion valida si el contrato, tiene por lo menos
                     algun producto ya sea de microseguros o de FNB
    Autor          : Kbaquero
    Fecha          : 29/05/2013 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inususc:        Id. del contrato

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    PROCEDURE ValidateProductFnbGnvSeguros (
        inususc   IN suscripc.susccodi%TYPE);

    /***************************************************************************
    Valida si existen polizas activas para el cliente y contrato ingresados
    ***************************************************************************/
    PROCEDURE ValidateActivePolicy (
        inuSusbcriptionId   IN suscripc.susccodi%TYPE,
        inuSubscriberId     IN ge_subscriber.subscriber_id%TYPE,
        inuProductId        IN pr_product.product_id%TYPE);
END Ld_BoLiquidation;
/

CREATE OR REPLACE PACKAGE BODY OPEN.Ld_BoLiquidation
IS
    -----------------------
    -- Constants
    -----------------------
    -- Constante con el SAO de la ultima version aplicada
    csbVERSION   CONSTANT VARCHAR2 (10) := 'SAO231292';

    -- Declaracion de variables y tipos globales privados del paquete

    nuPackageId           NUMBER;
    nuValueLiqRel         ld_liquidation.VALUE%TYPE;

    -- Definicion de metodos publicos y privados del paquete

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure      :  fsbVersion
    Descripcion    :  Obtiene la Version actual del Paquete

    Parametros     :  Descripcion
    Retorno        :
    csbVersion        Version del Paquete

    Autor          :  AAcu?a
    Fecha          :  13/11/2012 SAO 159764

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    *****************************************************************/

    FUNCTION fsbVersion
        RETURN VARCHAR2
    IS
    BEGIN
        pkErrors.Push ('Ld_BoLiquidation.fsbVersion');
        pkErrors.Pop;
        -- Retorna el SAO con que se realizo la ultima entrega
        RETURN (csbVersion);
    END fsbVersion;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProcCancelBySinester
    Descripcion    : Busca todas las polizas a partir del contrato y las cancela de acuerdo
                     al alcance del DAA 14787
    Autor          : AAcuna
    Fecha          : 18/10/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha            Autor                Modificacion
    =========      =========              ====================
    29-01-2014    AEcheverrySAO231292     Se incluye en el tramite de cancelacion
                                          de seguros por XML el campo person_id (ID)
                                          y se envia en este la persona que registro
                                          la solicitud de siniestro.
    11-12-2013     JCarmona.SAO227114     Se modifica para enviar en el campo
                                          contact_id el id del suscriptor y en el
                                          campo reception_type_id el medio de
                                          recepcion del usuario que reporto el
                                          siniestro.
    17-07-2013     hvera                  Se modifican etiquetas del xml
    ******************************************************************/

    PROCEDURE ProcCancelBySinester (
        inuPackage   IN mo_packages.package_id%TYPE)
    IS
        rcMo_Packages       damo_packages.styMO_packages;
        nuSuscripc          mo_packages.subscription_pend_id%TYPE;
        tbPackages          dald_secure_sale.tytbSecure_Sale_Id;
        nuPackages          ld_secure_sale.secure_sale_id%TYPE;
        rcSecure_Sale       dald_secure_sale.styLD_secure_sale;
        tbSinester          dald_sinester_claims.tytbLD_sinester_claims;

        rcMoPackage         damo_packages.styMO_packages;
        rcPolicy            dald_policy.styLD_policy;

        sbRequestXML        VARCHAR2 (8000);
        nuErrorCode         NUMBER;
        sbErrorMessage      VARCHAR2 (8000);
        nuPackageId         mo_packages.package_id%TYPE;
        nuMotiveId          mo_motive.motive_id%TYPE;
        sbSol               VARCHAR2 (100);
        nuSubscriberId      ge_subscriber.subscriber_id%TYPE;
        nuGeo               ge_geogra_location.geograp_location_id%TYPE;
        nuadd               ab_address.address%TYPE;

        -- Variables de archivo log

        sbTimeProc          VARCHAR2 (100);
        sbPath              VARCHAR2 (500);
        sbLog               VARCHAR2 (500);
        sbLineLog           VARCHAR2 (1000);

        sbFileManagementd   UTL_FILE.file_type;
        nuIndex             NUMBER;
    BEGIN
        ut_trace.Trace ('INICIO Ld_BoLiquidation.ProcCancelBySinester', 10);

        damo_packages.getRecord (inuPackage, rcMo_Packages);

        dald_sinester_claims.getRecords (
            ' ld_sinester_claims.package_id=' || inuPackage,
            tbSinester);

        nuSuscripc := rcMo_Packages.subscription_pend_id;


        sbState :=
            DALD_PARAMETER.fsbGetValue_Chain (
                LD_BOConstans.csbCodStatePolicy);
        sbCanBySin :=
            DALD_PARAMETER.fsbGetValue_Chain (LD_BOConstans.csbCanBySin);
        sbPath := DALD_PARAMETER.fsbGetValue_Chain ('RUT_FILE_SINESTER');
        nuCauseCancSin :=
            DALD_PARAMETER.fnuGetNumeric_Value (
                LD_BOConstans.cnuCauseCancSin);
        nuAnswerIdSin :=
            DALD_PARAMETER.fnuGetNumeric_Value (LD_BOConstans.cnuAnswerIdSin);

        IF (    (NVL (nuCauseCancSin, LD_BOConstans.cnuCero) <>
                 LD_BOConstans.cnuCero)
            AND (NVL (nuAnswerIdSin, LD_BOConstans.cnuCero) <>
                 LD_BOConstans.cnuCero))
        THEN
            sbTimeProc := TO_CHAR (SYSDATE, 'yyyymmdd_hh24miss');

            /* Arma nombre del archivo LOG */

            sbLog := 'SIN_' || sbTimeProc || '.LOG';

            DBMS_OUTPUT.put_line ('Log: ' || sbLog);

            /* Crea archivo Log */

            sbFileManagementd := pkUtlFileMgr.Fopen (sbPath, sbLog, 'w');

            sbLineLog :=
                   'INICIO PROCESO DE SINIESTRO '
                || TO_CHAR (SYSDATE, 'DD/MM/YYYY HH24:MI:SS');
            DBMS_OUTPUT.enable (99999999999999999999999999999999999999999);

            pkUtlFileMgr.Put_Line (sbFileManagementd, sbLineLog);

            BEGIN
                IF (tbSinester.COUNT > 0)
                THEN
                    nuIndex := tbSinester.FIRST;

                    /* Se recorren los tipos de poliza*/


                    ld_bcliquidation.ProcCancelBySinester (
                        nuSuscripc,
                        sbState,
                        tbSinester (nuIndex).insured_id,
                        tbPackages);
                END IF;

                ut_trace.Trace (
                    'Cantidad de solicitudes ' || tbPackages.COUNT,
                    10);

                IF tbPackages.COUNT > 0
                THEN
                    FOR i IN tbPackages.FIRST .. tbPackages.LAST
                    LOOP
                        IF tbPackages.EXISTS (i)
                        THEN
                            nuPackages := tbPackages (i);
                            ut_trace.Trace ('nuPackages ' || nuPackages, 10);

                            dald_secure_sale.getRecord (nuPackages,
                                                        rcSecure_Sale);
                            damo_packages.getRecord (
                                rcSecure_Sale.secure_sale_id,
                                rcMoPackage);

                            ut_trace.Trace (
                                   'rcMoPackage.reception_type_id '
                                || rcMoPackage.reception_type_id,
                                10);

                            dald_policy.getRecord (
                                rcSecure_Sale.policy_number,
                                rcPolicy);

                            ld_bosecuremanagement.GetAddressBySusc (
                                rcPolicy.suscription_id,
                                nuadd,
                                nuGeo);

                            sbSol := sbCanBySin;

                            /* Se obtiene el id del suscriptor dado el contrato */
                            nuSubscriberId :=
                                pktblsuscripc.fnugetsuscclie (
                                    rcPolicy.suscription_id);

                            sbRequestXML :=
                                   '<P_CANCELACION_DE_SEGUROS_XML_100266 ID_TIPOPAQUETE="100266">
                <ID>'
                                || rcMo_Packages.person_id
                                || '</ID>'
                                || '<RECEPTION_TYPE_ID>'
                                || rcMo_Packages.reception_type_id
                                || '</RECEPTION_TYPE_ID>
              <COMMENT_>Cancelada la poliza por solicitud de siniestros</COMMENT_>
              <FECHA_DE_SOLICITUD>'
                                || TRUNC (SYSDATE)
                                || '</FECHA_DE_SOLICITUD>
              <ADDRESS_ID>'
                                || nuadd
                                || '</ADDRESS_ID>
              <CONTACT_ID>'
                                || nuSubscriberId
                                || '</CONTACT_ID>
              <CONTRACT>'
                                || rcPolicy.suscription_id
                                || '</CONTRACT>
              <M_CANCELACION_DE_SEGUROS_XML_100273>
              <ANSWER_ID>'
                                || nuAnswerIdSin
                                || '</ANSWER_ID>
              <POLIZA_A_CANCELAR>'
                                || rcSecure_Sale.policy_number
                                || '</POLIZA_A_CANCELAR>
              <CAUSAL_DE_CANCELACION>'
                                || nuCauseCancSin
                                || '</CAUSAL_DE_CANCELACION>
              <OBSERVACIONES_DE_LA_POLIZA>Poliza cancelada por solicitud de siniestros</OBSERVACIONES_DE_LA_POLIZA>'
                                || '<SOLICITUD_QUE_FUE_REGISTRADA>'
                                || sbSol
                                || '</SOLICITUD_QUE_FUE_REGISTRADA>
              </M_CANCELACION_DE_SEGUROS_XML_100273>
              </P_CANCELACION_DE_SEGUROS_XML_100266>';

                            OS_RegisterRequestWithXML (sbRequestXML,
                                                       nuPackageId,
                                                       nuMotiveId,
                                                       nuErrorCode,
                                                       sbErrorMessage);

                            IF (nuErrorCode = 0)
                            THEN
                                sbLineLog :=
                                       ' Se creo la solicitud: '
                                    || nuPackageId
                                    || ' con el numero de motivo: '
                                    || nuMotiveId
                                    || ' para el contrato: '
                                    || nuSuscripc
                                    || ' y la poliza: '
                                    || rcSecure_Sale.policy_number;
                                pkUtlFileMgr.Put_Line (sbFileManagementd,
                                                       sbLineLog);
                            ELSE
                                sbLineLog :=
                                       ' Error creando la solicitud: '
                                    || nuPackageId
                                    || ' con el numero de motivo: '
                                    || nuMotiveId
                                    || ' para el contrato: '
                                    || nuSuscripc
                                    || ' y la poliza: '
                                    || rcSecure_Sale.policy_number
                                    || ' Error: '
                                    || nuErrorCode
                                    || ' Mensaje:'
                                    || sbErrorMessage;
                                pkUtlFileMgr.Put_Line (sbFileManagementd,
                                                       sbLineLog);

                                ge_boerrors.seterrorcodeargument (
                                    ld_boconstans.cnuGeneric_Error,
                                    sbLineLog);
                            END IF;
                        END IF;
                    END LOOP;
                ELSE
                    ge_boerrors.seterrorcodeargument (
                        ld_boconstans.cnuGeneric_Error,
                           'El contrato '
                        || nuSuscripc
                        || ' no tiene polizas Asociadas');
                END IF;
            EXCEPTION
                WHEN ex.CONTROLLED_ERROR
                THEN
                    Errors.setError;
                    Errors.getError (nuErrorCode, sbErrorMessage);
                    sbLineLog :=
                           '     Error ejecutando el api xml... numero de error '
                        || nuErrorCode
                        || ' Mensaje'
                        || sbErrorMessage;
                    pkUtlFileMgr.Put_Line (sbFileManagementd, sbLineLog);
                    pkUtlFileMgr.fClose (sbFileManagementd);
                    RAISE ex.CONTROLLED_ERROR;
                WHEN OTHERS
                THEN
                    Errors.setError;
                    Errors.getError (nuErrorCode, sbErrorMessage);
                    sbLineLog :=
                           '     Error ejecutando el api xml... numero de error '
                        || nuErrorCode
                        || ' Mensaje'
                        || sbErrorMessage;
                    pkUtlFileMgr.Put_Line (sbFileManagementd, sbLineLog);
                    pkUtlFileMgr.fClose (sbFileManagementd);
                    RAISE ex.CONTROLLED_ERROR;
            END;

            pkUtlFileMgr.fClose (sbFileManagementd);
        END IF;

        ut_trace.Trace ('FIN Ld_BoLiquidation.ProcCancelBySinester', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END ProcCancelBySinester;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProcLiquidationSearch
    Descripcion    : Busca todas las polizas a partir del contrato y las cancela de acuerdo
                     al alcance del DAA 14787
    Autor          : AAcuna
    Fecha          : 18/10/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    FUNCTION ProcLiquidationSearch
        RETURN pkConstante.tyRefCursor
    IS
        nuSuscripc       Ld_Liquidation.Subscription_Id%TYPE;
        nuPackage        Ld_Liquidation.liqui_package_id%TYPE;
        dtSynesterDate   Ld_Liquidation.Loss_Date%TYPE;
        rfcursor         pkConstante.tyRefCursor;
        rfCuencobr       pktblcuencobr.tyCUCOCODI;
        sbCuenCobr       VARCHAR2 (1000);
        nuCuenCobr       cuencobr.cucocodi%TYPE;
        rcMopackage      damo_packages.styMO_packages;
        nuValidate       NUMBER;
        sbConcepts       VARCHAR2 (32000);
        sbIntConcepts    VARCHAR2 (32000);
    BEGIN
        ut_trace.Trace ('INICIO Ld_BoLiquidation.ProcLiquidationSearch', 10);

        /*obtener los valores ingresados en la aplicacion PB LDDEA*/
        dtSynesterDate :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'LOSS_DATE');
        nuSuscripc :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'SUBSCRIPTION_ID');
        nuPackage :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'LIQUI_PACKAGE_ID');

        IF nuSuscripc IS NOT NULL
        THEN
            IF     (DALD_PARAMETER.fblexist (LD_BOConstans.cnuConSec))
               AND (DALD_PARAMETER.fblexist (LD_BOConstans.cnuConFin))
            THEN
                nuFin :=
                    DALD_PARAMETER.fnuGetNumeric_Value (
                        LD_BOConstans.cnuConFin);
                nuSec :=
                    DALD_PARAMETER.fnuGetNumeric_Value (
                        LD_BOConstans.cnuConSec);

                IF (    (NVL (nuFin, LD_BOConstans.cnuCero) <>
                         LD_BOConstans.cnuCero)
                    AND (NVL (nuSec, LD_BOConstans.cnuCero) <>
                         LD_BOConstans.cnuCero))
                THEN
                    nuValidate := ld_bcliquidation.FnuSuscByLiq (nuSuscripc);

                    /*Obtengo los conceptos asociados al concepto de facturacion de brilla*/

                    sbConcepts :=
                        '|' || LD_BOPackageFNB.Fsbgetarticlesconcepts || '|';
                    sbIntConcepts :=
                        '|' || FsbgetconceptsInt (sbConcepts) || '|';

                    IF (nuValidate = 0)
                    THEN
                        rfcursor :=
                            ld_bcliquidation.FrfLiquidationSearch (
                                nuPackage,
                                nuSuscripc,
                                dtSynesterDate,
                                damo_packages.fdtgetrequest_date (nuPackage),
                                nuFin,
                                nuSec,
                                sbIntConcepts);

                        RETURN (rfcursor);
                    ELSE
                        ge_boerrors.seterrorcodeargument (
                            ld_boconstans.cnuGeneric_Error,
                               'El contrato registrado ya tiene una liquidacion ingresada '
                            || 'entre a la forma LDRQS para su reliquidacion');
                    END IF;
                END IF;
            END IF;
        END IF;

        ut_trace.Trace ('INICIO Ld_BoLiquidation.ProcLiquidationSearch', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END ProcLiquidationSearch;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProcLiquidationProcess
    Descripcion    : Busca todas las polizas a partir del contrato y las cancela de acuerdo
                     al alcance del DAA 14787
    Autor          : AAcuna
    Fecha          : 18/10/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha            Autor            Modificacion
    =========      =========          ====================
    04-12-2013     jrobayo.SAO226066  Se modifica para tener en cuenta el tipo de cobertura
                                      rotura maquinaria para el tipo de producto GNCV.
    16-08-2013     hvera.SAO215048    Se obtienen los conceptos asociados a articulos
                                      para consultar diferidos.
    ******************************************************************/
    PROCEDURE ProcLiquidationProcess (isbDifCuen        IN     VARCHAR2,
                                      inuCurrent        IN     NUMBER,
                                      inuTotal          IN     NUMBER,
                                      onuErrorCode         OUT NUMBER,
                                      osbErrorMessage      OUT VARCHAR2)
    IS
        rcLiquidation            dald_liquidation.styLD_liquidation;
        tbDetailLiquidation      dald_detail_liquidation.tytbLD_detail_liquidation;
        rcDetailLiquidation      dald_detail_liquidation.styLD_detail_liquidation;
        nuPackage                ge_boInstanceControl.stysbValue;
        nuSuscripc               ge_boInstanceControl.stysbValue;
        nuInsured_Id             ge_boInstanceControl.stysbValue;
        nuCoverage_Type          ge_boInstanceControl.stysbValue;
        nuApplication_Cause_Id   ge_boInstanceControl.stysbValue;
        nuLocated                ge_boInstanceControl.stysbValue;
        nuLossDate               ge_boInstanceControl.stysbValue;
        nuProduct_Type_Id        ge_boInstanceControl.stysbValue;
        sbComparator             VARCHAR2 (1);
        sbCuenCobr               VARCHAR2 (1000);
        rcMopackage              damo_packages.styMO_packages;

        rfcursor                 pkConstante.tyRefCursor;
        rfCuencobr               pktblcuencobr.tyCUCOCODI;
        nuCuenCobr               cuencobr.cucocodi%TYPE;
        rcDeffered               diferido%ROWTYPE;
        rcCuencobr               cuencobr%ROWTYPE;
        nuDeffered               diferido.difecodi%TYPE;
        nuProdType               servsusc.sesuserv%TYPE;
        nuCucovato               cuencobr.cucovato%TYPE;
        nuUser                   ge_person.person_id%TYPE;
        nuValueLiq               ld_liquidation.VALUE%TYPE;
        rfDetailLiquidation      LD_BOConstans.rfdelliqs%TYPE;
        rfDetailLiq              constants.tyRefCursor;
        nuNextDetailLiq          NUMBER;
        sbConcepts               VARCHAR2 (32000);
        sbIntConcepts            VARCHAR2 (32000);
    BEGIN
        ut_trace.Trace ('INICIO: Ld_BoLiquidation.ProcLiquidationProcess',
                        10);

        nuCucovato := 0;

        nuPackage :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'LIQUI_PACKAGE_ID');

        nuSuscripc :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'SUBSCRIPTION_ID');

        nuInsured_Id :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'INSURED_ID');

        nuCoverage_Type :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'COVERAGE_TYPE');

        nuApplication_Cause_Id :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'APPLICATION_CAUSE_ID');

        nuProduct_Type_Id :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'PRODUCT_TYPE_ID');

        nuLocated :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'LOCATED');

        nuLossDate :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'LOSS_DATE');

        IF (nuPackage IS NULL)
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                'El campo solicitud es obligatorio');
        END IF;

        IF (nuSuscripc IS NULL)
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                'El campo contrato es obligatorio');
        END IF;

        IF (nuInsured_Id IS NULL)
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                'El campo identificacion es obligatorio');
        END IF;

        IF (nuCoverage_Type IS NULL)
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                'El campo tipo de cobertura es obligatorio');
        END IF;

        IF (nuApplication_Cause_Id IS NULL)
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                'El campo causa de solicitud es obligatorio');
        END IF;

        IF (nuProduct_Type_Id IS NULL)
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                'El campo tipo de producto es obligatorio');
        END IF;

        IF (nuLossDate IS NULL)
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                'El campo fecha de siniestro es obligatorio');
        ELSE
            damo_packages.getRecord (nuPackage, rcMopackage);

            IF (inuCurrent = 1)
            THEN
                nuValueLiqRel := 0;

                nuUser := GE_BOPersonal.fnuGetPersonId;

                rcLiquidation.liqui_package_id := nuPackage;
                rcLiquidation.liquidation_id :=
                    ld_bosequence.fnuSeqLiquidation;
                rcLiquidation.subscription_id := nuSuscripc;
                rcLiquidation.insured_id := nuInsured_Id;
                rcLiquidation.coverage_type := nuCoverage_Type;
                rcLiquidation.application_cause_id := nuApplication_Cause_Id;
                rcLiquidation.product_type_id := nuProduct_Type_Id;
                rcLiquidation.located := nuLocated;
                rcLiquidation.loss_date := nuLossDate;
                rcLiquidation.creation_date := SYSDATE;
                rcLiquidation.state := 'R';
                nuPackageId := rcLiquidation.liquidation_id;
                rcLiquidation.user_liquidation := nuUser;
                rcLiquidation.VALUE := nuValueLiq;

                dald_liquidation.insRecord (rcLiquidation);
            END IF;

            IF (    DALD_PARAMETER.fblexist (LD_BOConstans.cnuConSec)
                AND (DALD_PARAMETER.fblexist (LD_BOConstans.cnuConFin)))
            THEN
                nuFin :=
                    DALD_PARAMETER.fnuGetNumeric_Value (
                        LD_BOConstans.cnuConFin);
                nuSec :=
                    DALD_PARAMETER.fnuGetNumeric_Value (
                        LD_BOConstans.cnuConSec);

                IF (    (NVL (nuFin, LD_BOConstans.cnuCero) <>
                         LD_BOConstans.cnuCero)
                    AND (NVL (nuSec, LD_BOConstans.cnuCero) <>
                         LD_BOConstans.cnuCero))
                THEN
                    nuDeffered := TO_NUMBER (isbDifCuen);
                    nuProdType :=
                        dald_parameter.fnuGetNumeric_Value ('COD_TIPO_GNCV');

                    sbConcepts :=
                        '|' || LD_BOPackageFNB.Fsbgetarticlesconcepts || '|';
                    -- sbIntConcepts := '|'||FsbgetconceptsInt(sbConcepts)||'|';

                    ut_trace.Trace (
                           'nuSuscripc '
                        || nuSuscripc
                        || ' nuLossDate '
                        || nuLossDate
                        || ' rcMopackage.request_date '
                        || rcMopackage.request_date,
                        10);
                    ut_trace.Trace (
                           'nuFin '
                        || nuFin
                        || ' nuSec '
                        || nuSec
                        || ' nuDeffered '
                        || nuDeffered,
                        10);
                    ut_trace.Trace ('sbConcepts ' || sbConcepts, 10);

                    IF (    nuCoverage_Type = 2
                        AND nuProduct_Type_Id = nuProdType)
                    THEN
                        rfDetailLiq :=
                            ld_bcliquidation.FrfrTotalValDetMach (
                                nuPackage,
                                nuSuscripc,
                                nuLossDate,
                                rcMopackage.request_date,
                                nuFin,
                                nuSec,
                                sbConcepts,
                                nuDeffered);
                    ELSE
                        rfDetailLiq :=
                            ld_bcliquidation.FrfTotalValueDetail (
                                nuPackage,
                                nuSuscripc,
                                nuLossDate,
                                rcMopackage.request_date,
                                nuFin,
                                nuSec,
                                sbConcepts,
                                nuDeffered);
                    END IF;

                    LOOP
                        FETCH rfDetailLiq
                            BULK COLLECT INTO rfDetailLiquidation
                            LIMIT 20;

                        nuNextDetailLiq := rfDetailLiquidation.FIRST;

                        WHILE (nuNextDetailLiq IS NOT NULL)
                        LOOP
                            rcDeffered :=
                                pktbldiferido.frcGetRecord (nuDeffered);


                            IF (    (nuNextDetailLiq =
                                     rfDetailLiquidation.LAST)
                                AND (inuCurrent = inuTotal))
                            THEN
                                nuValueLiqRel :=
                                      nuValueLiqRel
                                    + rfDetailLiquidation (nuNextDetailLiq).valtd;
                            ELSE
                                nuValueLiqRel :=
                                      nuValueLiqRel
                                    + rfDetailLiquidation (nuNextDetailLiq).valtd
                                    - NVL (
                                          rfDetailLiquidation (
                                              nuNextDetailLiq).current_value,
                                          0);
                            END IF;


                            ut_trace.Trace ('nuDeffered ' || nuDeffered, 10);
                            ut_trace.Trace (
                                   'current '
                                || rfDetailLiquidation (nuNextDetailLiq).current_value,
                                10);

                            rcDetailLiquidation.detail_liquidation_id :=
                                ld_bosequence.fnuSeqDetLiquidation;
                            rcDetailLiquidation.package_id := nuPackage;
                            rcDetailLiquidation.state := 'R';
                            rcDetailLiquidation.financing_code_id :=
                                rcDeffered.difecodi;
                            rcDetailLiquidation.pending_balance :=
                                rcDeffered.difesape;
                            rcDetailLiquidation.concept_id :=
                                rcDeffered.difeconc;
                            rcDetailLiquidation.total_value :=
                                rfDetailLiquidation (nuNextDetailLiq).valtd;
                            rcDetailLiquidation.financing_interest :=
                                rfDetailLiquidation (nuNextDetailLiq).intfin;
                            rcDetailLiquidation.current_value :=
                                rfDetailLiquidation (nuNextDetailLiq).current_value;
                            rcDetailLiquidation.secure_value :=
                                rfDetailLiquidation (nuNextDetailLiq).secure_value;

                            rcDetailLiquidation.liquidation_id := nuPackageId;

                            dald_detail_liquidation.insRecord (
                                rcDetailLiquidation);

                            nuNextDetailLiq :=
                                rfDetailLiquidation.NEXT (nuNextDetailLiq);
                        END LOOP;

                        EXIT WHEN rfDetailLiq%NOTFOUND;
                    END LOOP;

                    CLOSE rfDetailLiq;
                END IF;
            END IF;

            IF (inuCurrent = inuTotal)
            THEN
                dald_liquidation.updValue (nuPackageId, nuValueLiqRel);
            END IF;
        END IF;

        ut_trace.Trace ('FIN: Ld_BoLiquidation.ProcLiquidationProcess', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END ProcLiquidationProcess;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FrfRestSearch
    Descripcion    : Busca la informacion para realizar la reliquidacion
                     DAA-159764 tramite de siniestros
    Autor          : AAcuna
    Fecha          : 18/10/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha            Autor            Modificacion
    =========      =========          ====================
    21-07-2014     KCienfuegos.RNP548 Se agregan los campos nuPackagLiq y nuSuscription y se quita
                                      la obligatoriedad del campo nuLiquidation para la busqueda.
    22-12-2013     jrobayo.SAO228573  Se modifica para obtener los valores correspondientes a
                                      la liquidacion del siniestro registrada sin recalcularla.
    16-08-2013     hvera.SAO215048    Se corrige el CURSOR, para que retornar el
                                      valor correspondiente a seguro y a saldo corriente
    ******************************************************************/
    FUNCTION FrfRestSearch
        RETURN pkConstante.tyRefCursor
    IS
        nuLiquidation      Ld_Liquidation.liquidation_id%TYPE;
        nuCuenCobr         cuencobr.cucocodi%TYPE;
        onuSuscripc        ld_liquidation.subscription_id%TYPE;
        onupackge          ld_liquidation.liqui_package_id%TYPE;
        odtRequestDate     ld_liquidation.creation_date%TYPE;
        odtfecloss         ld_liquidation.creation_date%TYPE;
        nuPackagLiq        ld_liquidation.liqui_package_id%TYPE;
        nuSuscription      ld_liquidation.subscription_id%TYPE;

        dtSynesterDate     ge_boInstanceControl.stysbValue;

        rfcursor           pkConstante.tyRefCursor;
        rfCuencobr         pktblcuencobr.tyCUCOCODI;
        rcMopackage        damo_packages.styMO_packages;

        /*sbCuenCobr       Ld_detail_Liquidation.Cucocodi_Id%type;*/
        sbquery            VARCHAR2 (32000);
        sbquerydet         VARCHAR2 (32000);
        sbqueryu           VARCHAR2 (32000);
        sbqueryreliqca     VARCHAR2 (32000);
        sbqueryreliq       VARCHAR2 (32000);
        sbqueryreliqdif    VARCHAR2 (32000);
        sbqueryliqdif      VARCHAR2 (32000);
        sbqueryreliqdif1   VARCHAR2 (32000);
        sbqueryliqcc       VARCHAR2 (32000);
        sbcadena           VARCHAR2 (32000);
    BEGIN
        ut_trace.Trace ('INICIO Ld_BoLiquidation.FrfRestSearch', 10);

        IF (    DALD_PARAMETER.fblexist (LD_BOConstans.cnuConSec)
            AND (DALD_PARAMETER.fblexist (LD_BOConstans.cnuConFin)))
        THEN
            nuFin :=
                DALD_PARAMETER.fnuGetNumeric_Value (LD_BOConstans.cnuConFin);
            nuSec :=
                DALD_PARAMETER.fnuGetNumeric_Value (LD_BOConstans.cnuConSec);

            IF (    (NVL (nuFin, LD_BOConstans.cnuCero) <>
                     LD_BOConstans.cnuCero)
                AND (NVL (nuSec, LD_BOConstans.cnuCero) <>
                     LD_BOConstans.cnuCero))
            THEN
                nuLiquidation :=
                    ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                           'LIQUIDATION_ID');

                dtSynesterDate :=
                    ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                           'LOSS_DATE');

                nuPackagLiq :=
                    ge_boInstanceControl.fsbGetFieldValue (
                        'LD_LIQUIDATION',
                        'LIQUI_PACKAGE_ID');

                nuSuscription :=
                    ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                           'SUBSCRIPTION_ID');

                sbquery :=
                    '  SELECT /*+ index (l PK_LD_LIQUIDATION_ID) use nl (l ld)*/ to_char(ld.financing_code_id) "Codigo Financiacion",
             ld.liquidation_id "Codigo liquidacion",
             ld.pending_balance "Saldo Pendiente",
             to_char(ld.concept_id)||'' - ''|| pktblconcepto.fsbgetdescription(ld.concept_id) "Concepto",
             ld.total_value "Valor Total",
             ld.financing_interest "Interes Financiacion",
             ld.secure_value "Valor Seguro",
             ld.current_value "Valor Corriente",
             ld.state Estado
        FROM ld_liquidation l, ld_detail_liquidation ld
        WHERE ld.liquidation_id = l.liquidation_id
        AND ld.state = ''R'' AND financing_code_id is not null ';

                IF nuLiquidation IS NOT NULL
                THEN
                    sbquerydet :=
                           sbquerydet
                        || ' AND l.liquidation_id = '
                        || nuLiquidation;

                    Ld_BcLiquidation.ProcSearchReLiq (nuLiquidation,
                                                      onuSuscripc,
                                                      odtRequestDate,
                                                      odtfecloss,
                                                      onupackge);
                /*else
                  ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                                   'Se debe digitar el identificador de la liquidacion');*/
                END IF;

                odtRequestDate := TRUNC (odtRequestDate);

                IF dtSynesterDate IS NOT NULL
                THEN
                    dtSynesterDate := SUBSTR (dtSynesterDate, 1, 10);

                    sbquerydet :=
                           sbquerydet
                        || ' AND trunc(l.loss_date) = '''
                        || dtSynesterDate
                        || '''';
                END IF;

                IF nuPackagLiq IS NOT NULL
                THEN
                    sbquerydet :=
                           sbquerydet
                        || ' AND l.liqui_package_id = '
                        || nuPackagLiq;
                END IF;

                IF nuSuscription IS NOT NULL
                THEN
                    sbquerydet :=
                           sbquerydet
                        || ' AND l.subscription_id = '
                        || nuSuscription;
                END IF;

                ut_trace.Trace ('init query', 5);

                sbquery := sbquery || sbquerydet;

                ut_trace.Trace ('sbquery ' || sbquery, 5);

                OPEN rfcursor FOR sbquery;

                RETURN (rfcursor);
            END IF;
        END IF;

        ut_trace.Trace ('INICIO Ld_BoLiquidation.FrfRestSearch', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
            DBMS_OUTPUT.put_line (SQLERRM);
    END FrfRestSearch;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : ProcReLiquidationProcess
     Descripcion    : Procesa todas los cargos y cuentas de cobro que en el cual se habia cambiado
     Autor          : KBaquero
     Fecha          : 13/12/2012 SAO 159764

     Parametros         Descripcion
     ============   ===================
    isbDifCuen
    inuCurrent
    inuTotal
    onuErrorCode
    osbErrorMessage

     Historia de Modificaciones
     Fecha            Autor           Modificacion
     =========      =========         ====================
     23-12-2013     jrobayo.SAO228573 Se modifica el metodo para realizar el calculo de la reliquidacion.
     14-08-2013     hvera.SAO212868   Se tienen en cuenta todos los registros del detalle del difeiedo
     ******************************************************************/
    PROCEDURE ProcReLiquidationProcess (isbDifCuen        IN     VARCHAR2,
                                        inuCurrent        IN     NUMBER,
                                        inuTotal          IN     NUMBER,
                                        onuErrorCode         OUT NUMBER,
                                        osbErrorMessage      OUT VARCHAR2)
    IS
        rcLiquidation            dald_liquidation.styLD_liquidation;
        tbDetailLiquidation      dald_detail_liquidation.tytbLD_detail_liquidation;
        rcDetailLiquidation      dald_detail_liquidation.styLD_detail_liquidation;

        nuCoverage_Type          ge_boInstanceControl.stysbValue;
        nuApplication_Cause_Id   ge_boInstanceControl.stysbValue;
        nuLossDate               ge_boInstanceControl.stysbValue;
        nuLiquidation            ge_boInstanceControl.stysbValue;
        nuUser                   NUMBER;

        onuSuscripc              ld_liquidation.subscription_id%TYPE;
        onupackge                ld_liquidation.liqui_package_id%TYPE;
        odtRequestDate           ld_liquidation.creation_date%TYPE;
        odtfecloss               ld_liquidation.creation_date%TYPE;
        onudetliq                ld_detail_liquidation.detail_liquidation_id%TYPE;
        nuCuenCobr               cuencobr.cucocodi%TYPE;
        nuNextdeli               NUMBER;

        sbComparator             VARCHAR2 (1);
        sbCuenCobr               VARCHAR2 (1000);

        rfcursor                 pkConstante.tyRefCursor;
        rfCuencobr               pktblcuencobr.tyCUCOCODI;
        rfCursordeliq            constants.tyRefCursor;
        rfdetli                  LD_BOConstans.rfdelliq%TYPE;

        rcDeffered               diferido%ROWTYPE;
        rcCuencobr               cuencobr%ROWTYPE;
        nuDeffered               diferido.difecodi%TYPE;
        nuCucovato               cuencobr.cucovato%TYPE;
        nuValueLiq               ld_liquidation.VALUE%TYPE;
        rfDetailLiquidation      LD_BOConstans.rfdelliqs%TYPE;
        rfDetailLiq              constants.tyRefCursor;
        nuNextDetailLiq          NUMBER;
        rcMopackage              damo_packages.styMO_packages;
        sbConcepts               ld_parameter.value_chain%TYPE;

        dtRequest                mo_packages.request_date%TYPE;
        onupackage               mo_packages.package_id%TYPE;
        nuProdType               servsusc.sesuserv%TYPE;
        nuDateLiqId              NUMBER;
    BEGIN
        ut_trace.Trace ('INICIO: Ld_BoLiquidation.ProcReLiquidationProcess',
                        10);

        nuCucovato := 0;

        /*obtener los valores ingresados en la aplicacion PB LDRQS*/
        nuLossDate :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'LOSS_DATE');

        nuLiquidation :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'LIQUIDATION_ID');

        nuCoverage_Type :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'COVERAGE_TYPE');

        nuApplication_Cause_Id :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'APPLICATION_CAUSE_ID');

        IF (nuLiquidation IS NULL)
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                'El campo Liquidacion es obligatorio');
        END IF;

        IF (nuCoverage_Type IS NULL)
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                'El campo tipo de cobertura es obligatorio');
        END IF;

        IF (nuApplication_Cause_Id IS NULL)
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                'El campo causa de solicitud es obligatorio');
        END IF;

        IF (nuLossDate IS NULL)
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                'El campo fecha de siniestro es obligatorio');
        ELSIF nuLossDate > SYSDATE
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                'El campo fecha de siniestro no puede ser mayor a la fecha del sistema');
        ELSE
            dald_liquidation.getRecord (nuLiquidation, rcLiquidation);
            damo_packages.getRecord (rcLiquidation.liqui_package_id,
                                     rcMopackage);

            IF (inuCurrent = 1)
            THEN
                nuValueLiqRel := 0;

                rfCursordeliq :=
                    Ld_BcLiquidation.FrfSerchDetaiLiq (nuLiquidation);

                LOOP
                    FETCH rfCursordeliq BULK COLLECT INTO rfdetli LIMIT 10;

                    nuNextdeli := rfdetli.FIRST;

                    WHILE (nuNextdeli IS NOT NULL)
                    LOOP
                        dald_detail_liquidation.updState (
                            rfdetli (nuNextdeli).onudetaliq,
                            isbState$   => 'D');

                        nuNextdeli := rfdetli.NEXT (nuNextdeli);
                    END LOOP;

                    EXIT WHEN rfCursordeliq%NOTFOUND;
                END LOOP;

                CLOSE rfCursordeliq;
            END IF;

            IF     (DALD_PARAMETER.fblexist (LD_BOConstans.cnuConSec))
               AND (DALD_PARAMETER.fblexist (LD_BOConstans.cnuConFin)) /*and
                    (DALD_PARAMETER.fblexist(LD_BOConstans.cnuConFact))*/
            THEN
                nuFin :=
                    DALD_PARAMETER.fnuGetNumeric_Value (
                        LD_BOConstans.cnuConFin);
                nuSec :=
                    DALD_PARAMETER.fnuGetNumeric_Value (
                        LD_BOConstans.cnuConSec);

                /* nuFact := DALD_PARAMETER.fnuGetNumeric_Value(LD_BOConstans.cnuConFact);*/

                IF (    (NVL (nuFin, LD_BOConstans.cnuCero) <>
                         LD_BOConstans.cnuCero)
                    AND (NVL (nuSec, LD_BOConstans.cnuCero) <>
                         LD_BOConstans.cnuCero)              /*and
(nvl(nuFact, LD_BOConstans.cnuCero) <> LD_BOConstans.cnuCero)*/
                                               )
                THEN
                    nuDeffered := TO_NUMBER (isbDifCuen);

                    ut_trace.trace ('nuDeffered: ' || nuDeffered, 10);

                    nuProdType :=
                        dald_parameter.fnuGetNumeric_Value ('COD_TIPO_GNCV');
                    /*Obtengo los conceptos asociados al concepto de facturacion de brilla*/

                    sbConcepts := LD_BOPackageFNB.Fsbgetarticlesconcepts;

                    /*Calculo de la nueva liquidacion*/
                    IF (    nuCoverage_Type = 2
                        AND rcLiquidation.product_type_id = nuProdType)
                    THEN
                        rfDetailLiq :=
                            ld_bcliquidation.FrfrTotalReliqDetMach (
                                rcMopackage.package_id,
                                rcLiquidation.subscription_id,
                                nuLossDate,
                                rcMopackage.request_date,
                                nuFin,
                                nuSec,
                                sbConcepts,
                                nuDeffered);
                    ELSE
                        rfDetailLiq :=
                            ld_bcliquidation.FrfTotalReliqValDetail (
                                rcMopackage.package_id,
                                rcLiquidation.subscription_id,
                                nuLossDate,
                                rcMopackage.request_date,
                                nuFin,
                                nuSec,
                                sbConcepts,
                                nuDeffered);
                    END IF;

                    LOOP
                        FETCH rfDetailLiq
                            BULK COLLECT INTO rfDetailLiquidation
                            LIMIT 20;

                        nuNextDetailLiq := rfDetailLiquidation.FIRST;
                        ut_trace.trace (
                            'nuNextDetailLiq: ' || nuNextDetailLiq,
                            10);

                        WHILE (nuNextDetailLiq IS NOT NULL)
                        LOOP
                            rcDeffered :=
                                pktbldiferido.frcGetRecord (nuDeffered);


                            IF (    (nuNextDetailLiq =
                                     rfDetailLiquidation.LAST)
                                AND (inuCurrent = inuTotal))
                            THEN
                                nuValueLiqRel :=
                                      nuValueLiqRel
                                    + rfDetailLiquidation (nuNextDetailLiq).valtd;
                            ELSE
                                nuValueLiqRel :=
                                      nuValueLiqRel
                                    + rfDetailLiquidation (nuNextDetailLiq).valtd
                                    - NVL (
                                          rfDetailLiquidation (
                                              nuNextDetailLiq).current_value,
                                          0);
                            END IF;

                            ut_trace.trace (
                                'nuValueLiqRel: ' || nuValueLiqRel,
                                10);

                            ut_trace.Trace ('nuDeffered ' || nuDeffered, 10);
                            ut_trace.trace (
                                   'ld_bosequence.fnuSeqDetLiquidation: '
                                || ld_bosequence.fnuSeqDetLiquidation,
                                10);
                            ut_trace.Trace (
                                   'current '
                                || rfDetailLiquidation (nuNextDetailLiq).current_value,
                                10);

                            rcDetailLiquidation.detail_liquidation_id :=
                                ld_bosequence.fnuSeqDetLiquidation;
                            rcDetailLiquidation.package_id :=
                                rcMopackage.package_id;
                            rcDetailLiquidation.state := 'R';
                            rcDetailLiquidation.financing_code_id :=
                                rcDeffered.difecodi;
                            rcDetailLiquidation.pending_balance :=
                                rcDeffered.difesape;
                            rcDetailLiquidation.concept_id :=
                                rcDeffered.difeconc;
                            rcDetailLiquidation.total_value :=
                                rfDetailLiquidation (nuNextDetailLiq).valtd;
                            rcDetailLiquidation.financing_interest :=
                                rfDetailLiquidation (nuNextDetailLiq).intfin;
                            rcDetailLiquidation.current_value :=
                                rfDetailLiquidation (nuNextDetailLiq).current_value;
                            rcDetailLiquidation.secure_value :=
                                rfDetailLiquidation (nuNextDetailLiq).secure_value;

                            rcDetailLiquidation.liquidation_id :=
                                rcLiquidation.liquidation_id;

                            dald_detail_liquidation.insRecord (
                                rcDetailLiquidation);

                            nuNextDetailLiq :=
                                rfDetailLiquidation.NEXT (nuNextDetailLiq);
                        END LOOP;

                        EXIT WHEN rfDetailLiq%NOTFOUND;
                    END LOOP;

                    CLOSE rfDetailLiq;
                END IF;
            END IF;

            IF (inuCurrent = inuTotal)
            THEN
                dald_liquidation.updApplication_Cause_Id (
                    nuLiquidation,
                    nuApplication_Cause_Id);
                dald_liquidation.updLoss_Date (nuLiquidation,
                                               SUBSTR (nuLossDate, 1, 10));
                dald_liquidation.updCoverage_Type (nuLiquidation,
                                                   nuCoverage_Type);
                dald_liquidation.updValue (nuLiquidation, nuValueLiqRel);
            END IF;

            nuUser := GE_BOPersonal.fnuGetPersonId;
            dald_liquidation.updUser_Reliquidation (nuliquidation, nuUser);
            dald_liquidation.updReassessment_Date (nuliquidation, SYSDATE);
        END IF;

        ut_trace.Trace ('FIN: Ld_BoLiquidation.ProcReLiquidationProcess', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END ProcReLiquidationProcess;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProcCancelBySinester
    Descripcion    : Busca todas las polizas a partir del contrato y las cancela de acuerdo
                     al alcance del DAA 14787
    Autor          : AAcuna
    Fecha          : 18/10/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    PROCEDURE GetIniLiquidation (
        inuPackage        IN     mo_packages.package_id%TYPE,
        onuSubscriberId      OUT ge_subscriber.subscriber_id%TYPE,
        osbSubName           OUT ge_subscriber.subscriber_name%TYPE)
    IS
        sbName       ge_subscriber.subscriber_name%TYPE;
        sbLastName   ge_subscriber.subs_last_name%TYPE;
    BEGIN
        ld_bcliquidation.GetIniLiquidation (inuPackage,
                                            onuSubscriberId,
                                            sbName,
                                            sbLastName);
        osbSubName := sbName || ' ' || sbLastName;
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END GetIniLiquidation;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : GetProductByContract
    Descripcion    : Retorna 1 si tiene producto de microseguros y 0 si no lo tiene
    Autor          : AAcuna
    Fecha          : 18/10/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    FUNCTION GetProductByContract (inuPackage IN mo_packages.package_id%TYPE)
        RETURN NUMBER
    IS
        rcMo_Packages   damo_packages.styMO_packages;

        nuSuscripc      mo_packages.subscription_pend_id%TYPE;

        nuReturn        NUMBER;
        nuProduct       NUMBER;
        tbGasProduct    dapr_product.tytbPR_product;
    BEGIN
        ut_trace.Trace ('INICIO Ld_BoLiquidation.GetProductByContract', 10);

        damo_packages.getRecord (inuPackage, rcMo_Packages);
        nuSuscripc := rcMo_Packages.subscription_pend_id;

        tbGasProduct := pr_bcproduct.ftbGetProdBySubsNType (nuSuscripc, 7053);

        IF (tbGasProduct.COUNT > 0)
        THEN
            nuReturn := 1;
        ELSE
            nuReturn := 0;
        END IF;

        RETURN nuReturn;

        ut_trace.Trace ('FIN Ld_BoLiquidation.GetProductByContract', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END GetProductByContract;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ValidateProductFnb
    Descripcion    : Retorna 1 si el contrato tiene asociado algun tipo de producto 7055,7056
    Autor          : AAcuna
    Fecha          : 19/10/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    FUNCTION ValidateProductFnb (inuPackage IN mo_packages.package_id%TYPE)
        RETURN NUMBER
    IS
        rcMo_Packages   damo_packages.styMO_packages;

        nuSuscripc      mo_packages.subscription_pend_id%TYPE;

        nuReturn        NUMBER;
        nuProduct       NUMBER;
    BEGIN
        ut_trace.Trace ('INICIO Ld_BoLiquidation.ValidateProductFnb', 10);

        damo_packages.getRecord (inuPackage, rcMo_Packages);
        nuSuscripc := rcMo_Packages.subscription_pend_id;

        nuProduct := Ld_BcLiquidation.ValidateProductFnb (nuSuscripc);

        IF (nuProduct >= 1)
        THEN
            nuReturn := 1;
        ELSE
            nuReturn := 0;
        END IF;

        RETURN nuReturn;

        ut_trace.Trace ('FIN Ld_BoLiquidation.ValidateProductFnb', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END ValidateProductFnb;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : GetLiquidationAprovSearch
    Descripcion    : Busca todas la liquidacion de un contrato
                     al alcance del DAA 159764
    Autor          : KBaquero
    Fecha          : 04/12/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================


    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    FUNCTION GetLiquidationAprovSearch
        RETURN pkConstante.tyRefCursor
    IS
        nuSuscripc       Ld_Liquidation.Subscription_Id%TYPE;
        dtSynesterDate   Ld_Liquidation.Loss_Date%TYPE;
        rfcursor         pkConstante.tyRefCursor;
        rfCuencobr       pkConstante.tyRefCursor;
        nuPackage        Ld_Liquidation.Liqui_Package_Id%TYPE;
        nuliqui          Ld_Liquidation.LIQUIDATION_ID%TYPE;
        sbquery          VARCHAR2 (2000);
        sbqueryu         VARCHAR2 (2000);
        sbquerydet       VARCHAR2 (2000);
    BEGIN
        ut_trace.Trace ('INICIO Ld_BoLiquidation.GetLiquidationAprovSearch',
                        10);

        /*obtener los valores ingresados en la aplicacion PB LDALS*/

        nuliqui :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'LIQUIDATION_ID');

        nuSuscripc :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'SUBSCRIPTION_ID');

        nuPackage :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'LIQUI_PACKAGE_ID');

        sbquery :=
            'SELECT to_char(d.financing_code_id) Diferido,d.pending_balance "Saldo Pendiente",
                d.concept_id concepto,d.total_value "Valor Total",d.financing_interest "Interes Financiacion",
                d.current_value "Valor Corriente", d.secure_value "Valor Seguro",decode(d.state,''R'',''Registrado'') Estado
                FROM LD_LIQUIDATION t, ld_detail_liquidation d
                WHERE t.liquidation_id=d.liquidation_id
                AND D.STATE=''R'' AND d.financing_code_id is not null ';

        IF nuSuscripc IS NOT NULL
        THEN
            sbquerydet := ' AND t.subscription_id= ' || nuSuscripc;
        END IF;

        IF nuPackage IS NOT NULL
        THEN
            sbquerydet :=
                sbquerydet || ' AND t.liqui_package_id= ' || nuPackage;
        END IF;

        IF nuliqui IS NOT NULL
        THEN
            sbquerydet := sbquerydet || ' AND t.liquidation_id= ' || nuliqui;
        END IF;

        sbquery := sbquery || sbquerydet;

        OPEN rfcursor FOR sbquery;

        RETURN (rfcursor);

        ut_trace.Trace ('INICIO Ld_BoLiquidation.GetLiquidationAprovSearch',
                        10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END GetLiquidationAprovSearch;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuValidatePackage
    Descripcion    : Busca todas la liquidacion de un contrato
                     al alcance del DAA 159764
    Autor          : AAcuna
    Fecha          : 04/12/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================


    Historia de Modificaciones
    Fecha            Autor            Modificacion
    =========      =========          ====================
    15-08-2013     hvera.SAO213164    Se modifica para tener en cuenta el estado
                                      registrado y no el estado atendido
    ******************************************************************/

    FUNCTION FnuValidatePackage (inuPackage mo_packages.package_id%TYPE)
        RETURN NUMBER
    IS
        nuResult      BOOLEAN;
        nuResultd     NUMBER;
        rcMopackage   damo_packages.styMO_packages;
    BEGIN
        ut_trace.Trace ('INICIO Ld_BoLiquidation.FnuValidatePackage', 10);

        IF (dald_parameter.fblexist (LD_BOConstans.cnuMotPackage))
        THEN
            cnuMotPackage := 13;

            IF ((NVL (cnuMotPackage, LD_BOConstans.cnuCero) <>
                 LD_BOConstans.cnuCero))
            THEN
                nuResult := damo_packages.fblExist (inuPackage);

                IF (nuResult = TRUE)
                THEN
                    damo_packages.getRecord (inuPackage, rcMopackage);

                    IF (    (rcMopackage.tag_name =
                             'P_SOLICITUD_DE_REPORTE_DE_SINIESTRO_100263')
                        AND (rcMopackage.motive_status_id = cnuMotPackage))
                    THEN
                        nuResultd := 1;
                    ELSE
                        nuResultd := 0;
                    END IF;
                ELSE
                    nuResultd := 0;
                END IF;

                RETURN (nuResultd);
            END IF;
        END IF;

        ut_trace.Trace ('INICIO Ld_BoLiquidation.FnuValidatePackage', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN NO_DATA_FOUND
        THEN
            RETURN 0;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END FnuValidatePackage;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : Procaprliqu
      Descripcion    : Busca la liquidacion de un contrato y una solicitud especifica
                       y actualiza cada campo seleccionado para aprobar la iquidacion

      Autor          : KBaquero
      Fecha          : 10/12/2012 SAO 159764

      Parametros         Descripcion
      ============   ===================
      inuPackage:      Numero del paquete

      Historia de Modificaciones
      Fecha            Autor              Modificacion
      =========      =========          ====================
      13-08-2013     hvera.SAO214193    Se actualiza el estado de todos los detalles
                                        de liquidacion.
    ******************************************************************/
    PROCEDURE Procaprliqu (isbDifCuen        IN     VARCHAR2,
                           inuCurrent        IN     NUMBER,
                           inuTotal          IN     NUMBER,
                           onuErrorCode         OUT NUMBER,
                           osbErrorMessage      OUT VARCHAR2)
    IS
        nuPackage             ld_liquidation.liqui_package_id%TYPE;
        nuSuscripc            ld_liquidation.subscription_id%TYPE;
        nudif                 ld_detail_liquidation.financing_code_id%TYPE;
        nudifenuse            diferido.difenuse%TYPE;
        nudifepldi            diferido.difepldi%TYPE;
        nucumaxpldi           plandife.pldicuma%TYPE;
        nucuminpldi           plandife.pldicumi%TYPE;
        nuUser                NUMBER;
        onucantdetl           ld_liquidation.liquidation_id%TYPE;
        nuGracePeriod         ld_parameter.numeric_value%TYPE;
        nutiemperigrac        ld_parameter.numeric_value%TYPE;
        nutiemperigra         FLOAT;
        inuliquidation        ld_liquidation.liquidation_id%TYPE;
        onudetliqc            ld_detail_liquidation.detail_liquidation_id%TYPE;
        nudetliqd             ld_detail_liquidation.detail_liquidation_id%TYPE;
        onuliq                ld_detail_liquidation.liquidation_id%TYPE;
        onuliqR               ld_detail_liquidation.liquidation_id%TYPE;
        onuCantdetliq         NUMBER;
        nuIndex               NUMBER;

        isbchec               ld_liquidation.state%TYPE;
        sbComparator          VARCHAR2 (1000);

        vdate                 DATE;

        rcDetailLiquidation   dald_detail_liquidation.styLD_detail_liquidation;
        --  rcdife                 diferido%rowtype;

        tbDetLiquidation      Ld_BcLiquidation.tytbDetLiquidation;
    BEGIN
        ut_trace.Trace ('INICIO Ld_BoLiquidation.Procaprliqu', 10);

        nuPackage :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'LIQUI_PACKAGE_ID');

        nuSuscripc :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'SUBSCRIPTION_ID');

        isbchec :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION', 'STATE');

        inuliquidation :=
            ge_boInstanceControl.fsbGetFieldValue ('LD_LIQUIDATION',
                                                   'LIQUIDATION_ID');

        IF (inuliquidation IS NULL)
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                'El campo liquidacion es obligatorio para el procesar');
        END IF;

        IF (isbchec = 'N')
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                'El campo aprobar es obligatorio para el procesar');
        END IF;

        nudif := TO_NUMBER (isbDifCuen);

        /*Obtiene el numero del servicio suscrito a traves del diferido*/
        nudifenuse := pktbldiferido.fnuGetDifenuse (nudif);

        /*Cambia el estado de la liquidacion*/
        Ld_BcLiquidation.ProcValAprovLiq (ld_boconstans.csBAproba,
                                          inudife   => nudif,
                                          onuliq    => onuliq);

        IF onuliq IS NULL
        THEN
            Ld_BcLiquidation.ProcValAprovLiq (LD_BOConstans.csBRegistro,
                                              inudife   => nudif,
                                              onuliq    => onuliqR);

            /*Proceso de congelacion de los diferidos*/
            /*Se obtiene el periodo de gracia configurado*/
            IF ((dald_parameter.fblexist (LD_BOConstans.csbnuPeriGrac)))
            THEN
                nuGracePeriod :=
                    TO_NUMBER (
                        dald_parameter.fnuGetNumeric_Value (
                            LD_BOConstans.csbnuPeriGrac));

                IF ((NVL (nuGracePeriod, LD_BOConstans.cnuCero) <>
                     LD_BOConstans.cnuCero))
                THEN
                    nudifepldi := pktbldiferido.fnuGetDifepldi (nudif);

                    /*Valores maximos y minimos del plan de diferidos*/
                    nucumaxpldi := pktblplandife.fnuGetPldicuma (nudifepldi);
                    nucuminpldi := pktblplandife.fnuGetPldicumi (nudifepldi);
                    /*Se obtiene el numero maximo de cuotas a cancelar del diferido*/
                    nutiemperigrac :=
                        dacc_grace_period.fnuGetMax_Grace_Days (
                            nuGracePeriod);
                    nutiemperigra := nutiemperigrac / 30;

                    /*Condicional para que el tiempo de gracia se encuentre dentro del plan de diferidos*/
                    IF     nucumaxpldi >= nutiemperigra
                       AND nutiemperigra >= nucuminpldi
                    THEN
                        /*Fecha de incio de la vigencia*/
                        vdate := SYSDATE + nutiemperigrac - 1;

                        /*Se congela el diferido*/
                        CC_BOGrace_Peri_Defe.RegGracePeriodByProd (
                            nudifenuse,
                            nuGracePeriod,
                            SYSDATE,
                            vdate);

                        /*Consulta los diferidos que se van aprobar*/
                        ld_bcliquidation.ProcAprovDif (nudif,
                                                       nuPackage,
                                                       inuliquidation,
                                                       tbDetLiquidation);

                        nuIndex := tbDetLiquidation.FIRST;

                        WHILE (nuIndex IS NOT NULL)
                        LOOP
                            nudetliqd := tbDetLiquidation (nuIndex);
                            /*Modifica el detalle de la liquidacion aprobada*/
                            dald_detail_liquidation.updState (
                                nudetliqd,
                                ld_boconstans.csBAproba);
                            nuIndex := tbDetLiquidation.NEXT (nuIndex);
                        END LOOP;
                    ELSE
                        ge_boerrors.seterrorcodeargument (
                            ld_boconstans.cnuGeneric_ValMess,
                            'El numero de dias se encuentra fuera del rango del plan diferido');
                    END IF;
                END IF;
            END IF;
        ELSE
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                   'Este diferido se encuentra ya en una liquidacion aprobada'
                || onuliq);
        END IF;

        /*Actualizacion del proceso de aprobacion de la liquidacion*/
        /*  ld_bcliquidation.ProcCantDetAprov(inuliquidation,
                                            ld_boconstans.csBAproba,
                                            onuCantdetliq => onuCantdetl);*/

        --if onuCantdetliq = LD_BOConstans.cnuCero then
        nuUser := GE_BOPersonal.fnuGetPersonId;
        dald_liquidation.updState (inuliquidation, ld_boconstans.csBAproba);
        dald_liquidation.updUser_Aprobe (inuliquidation, nuUser);
        dald_liquidation.updApproval_Date (inuliquidation, SYSDATE);

        --end if;

        ut_trace.Trace ('INICIO Ld_BoLiquidation.Procaprliqu', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END Procaprliqu;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProcValidateContrac
    Descripcion    : Valida si un contrato tiene liquidacion para aprobar
                     al alcance del DAA 159764
    Autor          : KBaquero
    Fecha          : 12/12/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================


    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    PROCEDURE ProcValidateContrac (inususc suscripc.susccodi%TYPE)
    IS
        onucantdetliq   NUMBER;
    BEGIN
        ut_trace.Trace ('INICIO Ld_BoLiquidation.ProcValidateContrac', 10);

        Ld_BcLiquidation.ProcValSearchAprov (inususc,
                                             ld_boconstans.csBRegistro,
                                             onucant   => onucantdetliq);

        IF onucantdetliq = 0
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                   'Este Contratro'
                || inususc
                || 'No tiene Liquidaciones para aprobar');
        END IF;

        ut_trace.Trace ('INICIO Ld_BoLiquidation.ProcValidateContrac', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END ProcValidateContrac;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : frfGetReport
    Descripcion    : Busca todas la liquidacion de un contrato
                     al alcance del DAA 159764
    Autor          : AAcuna
    Fecha          : 04/12/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================


    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    16-06-2013     usuario    Se modifica la manera de formatear la fecha
    ******************************************************************/

    FUNCTION frfGetReport (
        inuliquidationId     IN ld_liquidation.liquidation_id%TYPE,
        inusubscription_id   IN ld_liquidation.subscription_id%TYPE,
        inupackagedId        IN ld_liquidation.liqui_package_id%TYPE,
        inuinsuredId         IN ld_liquidation.insured_id%TYPE,
        idtclaimDate         IN ld_liquidation.loss_date%TYPE,
        idtsinesterDate      IN ld_liquidation.loss_date%TYPE,
        inucoverageType      IN ld_liquidation.coverage_type%TYPE)
        RETURN pkConstante.tyRefCursor
    IS
        rfcursor           pkConstante.tyRefCursor;
        sbquery            VARCHAR2 (32000);
        sbquerydet         VARCHAR2 (32000);
        sbquerydetC        VARCHAR2 (32000);
        sbqueryu           VARCHAR2 (32000);
        sbqueryuc          VARCHAR2 (32000);
        sbqueryliq         VARCHAR2 (32000);
        sbGroupby          VARCHAR2 (32000);
        nuSubscriber       ge_subscriber.subscriber_id%TYPE;
        idtclaimDatec      ld_liquidation.loss_date%TYPE;
        idtsinesterDatec   ld_liquidation.loss_date%TYPE;
    BEGIN
        ut_trace.Trace ('INICIO Ld_BoLiquidation.frfGetReport', 10);

        ut_trace.Trace (
               'Datos inuliquidationId '
            || inuliquidationId
            || ' inusubscription_id '
            || inusubscription_id,
            10);
        ut_trace.Trace (
               'inupackagedId '
            || inupackagedId
            || ' inuinsuredId '
            || inuinsuredId
            || ' inucoverageType '
            || inucoverageType,
            10);
        ut_trace.Trace (
               'Fechas idtclaimDate '
            || TO_CHAR (idtclaimDate)
            || ' idtsinesterDate '
            || TO_CHAR (idtsinesterDate),
            10);
        ut_trace.Trace ('sbdtMinSin ' || sbdtMinSin, 10);

        idtclaimDatec := idtclaimDate;
        idtsinesterDatec := idtsinesterDate;

        sbquery :=
            'SELECT  to_char(l.liquidation_id),
        to_char(l.subscription_id),
        to_char(l.liqui_package_id),
        to_char(l.located),
        to_char(l.loss_date),
        to_char(grd.DATE_BIRTH),
        to_char(l.creation_date),
        to_date(m.request_date),
        to_char(ge.subscriber_name||'' ''|| ge.subs_last_name),
        null solicitud,
        null difefein,
        to_char(ger.name_),
        to_char(l.value),
        to_char(0),
        to_char(l.subscription_id) CONTRATO,
        dage_geogra_location.fsbGetDescription(ge_bogeogra_location.fnuGetGeo_LocaByAddress(a.address_id,''LOC''),0) Localidad,
        ge.identification Identificacion
        FROM ld_liquidation l,
        ab_address           a,
        suscripc             s,
        ge_geogra_location,
        ge_subscriber ge,
        ge_subs_general_data grd,mo_packages m,
        ge_person ger
        WHERE  l.insured_id = ge.subscriber_id
        AND ge.subscriber_id = grd.subscriber_id
        AND m.package_id = l.liqui_package_id
        AND a.address_id = s.susciddi
        AND s.susccodi = l.subscription_id
        AND ge_geogra_location.GEOGRAP_LOCATION_ID = a.GEOGRAP_LOCATION_ID
        AND ger.person_id= l.user_liquidation
        AND l.state !=''D''';

        sbqueryu :=
            ' UNION ALL
                  SELECT  to_char(financing_code_id),
                  to_char(pending_balance),
                  to_char(ld.current_value),
                  to_char(ld.financing_interest),
                  to_char(ld.total_value),
                  to_char(secure_value),
                  to_char(0),
                  to_date(to_char(sysdate,''dd/mm/yyyy'')),
                  to_char(0),
                  Ld_BcLiquidation.FsbGetConsecBySolic(Ld_BcLiquidation.FsbPackageSale(ld.liquidation_id,ld.financing_code_id)) solicitud,
                  DAMO_packages.fdtgetrequest_date(Ld_BcLiquidation.FsbPackageSale(ld.liquidation_id,ld.financing_code_id),0) difefein,
                  to_char(0),
                  to_char(0),
                  to_char(0),
                  to_char(l.subscription_id) CONTRATO,
                  to_char(0),
                  to_char(0)
                  FROM ld_liquidation l, ld_detail_liquidation ld,diferido d,
                  mo_packages m,suscripc s
                  WHERE d.difecodi = financing_code_id
                  AND d.difesusc = l.subscription_id
                  AND s.susccodi = l.subscription_id
                  AND m.package_id = l.liqui_package_id
                  AND ld.state !=''D''';


        sbGroupby :=
            ' GROUP BY financing_code_id, pending_balance,current_value,financing_interest, total_value ,
                secure_value, l.subscription_id, Ld_BcLiquidation.FsbPackageSale(ld.liquidation_id,ld.financing_code_id)';

        IF inuliquidationId IS NOT NULL
        THEN
            sbquerydet :=
                sbquerydet || ' AND l.liquidation_id = ' || inuliquidationId;

            sbqueryu :=
                sbqueryu || ' AND l.liquidation_id = ' || inuliquidationId;

            sbquerydetC :=
                sbquerydetC || ' AND l.liquidation_id = ' || inuliquidationId;
        END IF;

        IF inusubscription_id IS NOT NULL
        THEN
            sbquerydet :=
                   sbquerydet
                || ' AND l.subscription_id = '
                || inusubscription_id;

            sbqueryu :=
                sbqueryu || ' AND l.subscription_id = ' || inusubscription_id;

            sbquerydetC :=
                   sbquerydetC
                || ' AND l.subscription_id = '
                || inusubscription_id;
        END IF;

        IF inupackagedId IS NOT NULL
        THEN
            sbquerydet :=
                sbquerydet || ' AND l.liqui_package_id = ' || inupackagedId;

            sbqueryu :=
                sbqueryu || ' AND l.liqui_package_id = ' || inupackagedId;

            sbquerydetC :=
                sbquerydetC || ' AND l.liqui_package_id = ' || inupackagedId;
        END IF;

        IF inuinsuredId IS NOT NULL
        THEN
            ld_bcsecuremanagement.GetSubscriberById (inuinsuredId,
                                                     nuSubscriber);

            sbquerydet :=
                sbquerydet || ' AND l.insured_id = ' || nuSubscriber;

            sbqueryu := sbqueryu || ' AND l.insured_id = ' || nuSubscriber;

            sbquerydetC :=
                sbquerydetC || ' AND l.insured_id = ' || nuSubscriber;
        END IF;

        IF idtclaimDatec IS NOT NULL
        THEN
            DBMS_OUTPUT.put_line ('Entro');

            ut_trace.Trace ('idtclaimDatec es not null ' || idtclaimDatec,
                            10);

            sbquerydet :=
                   sbquerydet
                || ' AND trunc(m.request_date) = trunc(to_date('''
                || idtclaimDatec
                || '''))';

            sbqueryu :=
                   sbqueryu
                || ' AND trunc(m.request_date) = trunc(to_date('''
                || idtclaimDatec
                || '''))';

            sbquerydetC :=
                   sbquerydetC
                || ' AND trunc(m.request_date) = trunc(to_date('''
                || idtclaimDatec
                || '''))';
        END IF;

        IF idtsinesterDatec IS NOT NULL
        THEN
            DBMS_OUTPUT.put_line ('Entro');
            ut_trace.Trace (
                'idtsinesterDatec es not null ' || idtsinesterDatec,
                10);
            sbquerydet :=
                   sbquerydet
                || ' AND trunc(l.loss_date) = trunc(to_date('''
                || idtsinesterDatec
                || '''))';

            sbqueryu :=
                   sbqueryu
                || ' AND trunc(l.loss_date) = trunc(to_date('''
                || idtsinesterDatec
                || '''))';

            sbquerydetC :=
                   sbquerydetC
                || ' AND trunc(l.loss_date) = trunc(to_date('''
                || idtsinesterDatec
                || '''))';
        END IF;

        IF inucoverageType IS NOT NULL
        THEN
            sbquerydet :=
                sbquerydet || ' AND l.coverage_type = ' || inucoverageType;

            sbqueryu :=
                sbqueryu || ' AND l.coverage_type = ' || inucoverageType;

            sbquerydetC :=
                sbquerydetC || ' AND l.coverage_type = ' || inucoverageType;
        END IF;

        sbquery := sbquery || sbquerydet || sbqueryu || sbGroupby;

        DBMS_OUTPUT.put_line (sbquery);

        ut_trace.Trace ('sbquery ' || sbquery, 10);

        OPEN rfcursor FOR sbquery;

        ut_trace.Trace ('Fin Ld_BoLiquidation.frfGetReport', 10);

        RETURN (rfcursor);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END frfGetReport;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProcGetParameterRep
    Descripcion    : Busca los parametros del reporte de siniestros
    Autor          : AAcuna
    Fecha          : 21/12/2012 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inuPackage:      Numero del paquete

    Historia de Modificaciones
    Fecha            Autor               Modificacion
    =========      =========             ====================
    07/11/2013     Jhagudelo.SAO159764   Adicion de los parametros:
                                         - sbCity: Ciudad donde se firma la carta
                                         - sbUserFrm: Usuario que elabora la carta
    ******************************************************************/

    PROCEDURE ProcGetParameterRep (
        sbIdSigner       OUT ld_parameter.value_chain%TYPE,
        sbNameFun        OUT ld_parameter.value_chain%TYPE,
        sbHeaderLetter   OUT ld_parameter.value_chain%TYPE,
        sbReview         OUT ld_parameter.value_chain%TYPE,
        sbCity           OUT ld_parameter.value_chain%TYPE,
        sbUserFrm        OUT ld_parameter.value_chain%TYPE)
    IS
    BEGIN
        ut_trace.Trace ('INICIO: Ld_BoLiquidation.ProcGetParameterRep', 10);

        IF (    (dald_parameter.fblexist (LD_BOConstans.csbSigner))
            AND (dald_parameter.fblexist (LD_BOConstans.csbNameFun))
            AND (dald_parameter.fblexist (LD_BOConstans.csbHeaderLett))
            AND (dald_parameter.fblexist (LD_BOConstans.csbCity))
            AND (dald_parameter.fblexist (LD_BOConstans.csbUserFrm))
            AND (dald_parameter.fblexist (LD_BOConstans.csbReviews)))
        THEN
            sbIdSigner :=
                dald_parameter.fsbGetValue_Chain (LD_BOConstans.csbSigner);
            sbNameFun :=
                dald_parameter.fsbGetValue_Chain (LD_BOConstans.csbNameFun);
            sbHeaderLetter :=
                dald_parameter.fsbGetValue_Chain (
                    LD_BOConstans.csbHeaderLett);
            sbReview :=
                dald_parameter.fsbGetValue_Chain (LD_BOConstans.csbReviews);
            sbCity :=
                dald_parameter.fsbGetValue_Chain (LD_BOConstans.csbCity);
            sbUserFrm :=
                dald_parameter.fsbGetValue_Chain (LD_BOConstans.csbUserFrm);
        END IF;

        ut_trace.Trace ('FIN: Ld_BoLiquidation.ProcGetParameterRep', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END ProcGetParameterRep;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbNameInsured
      Descripcion    : Retorna el nombre del asegurado a partir de la identificacion

      Autor          : AACuna
      Fecha          : 21/12/2012 SAO 159764

      Parametros         Descripcion
      ============   ===================
        isbIdInsured    :Identificacion del asegurado

      Historia de Modificaciones
      Fecha            Autor       Modificacion
      =========      =========  ====================

    ******************************************************************/

    FUNCTION FsbNameInsured (
        inuIdInsured   IN ge_subscriber.subscriber_id%TYPE)
        RETURN VARCHAR2
    IS
        RESULT   VARCHAR2 (1000);
    BEGIN
        ut_trace.Trace ('INICIO: Ld_BoLiquidation.FsbNameInsured', 10);
        RESULT := ld_bcliquidation.FsbNameInsured (inuIdInsured);

        RETURN (RESULT);

        ut_trace.Trace ('FIN: Ld_BoLiquidation.FsbNameInsured', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN NO_DATA_FOUND
        THEN
            RETURN '';
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END FsbNameInsured;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbNameInsured
      Descripcion    : Actualiza el nombre del asegurado a partir del subscriber

      Autor          : AACuna
      Fecha          : 21/12/2012 SAO 159764

      Parametros         Descripcion
      ============   ===================
      inuPackage    : Numero de la solicitud

      Historia de Modificaciones
      Fecha            Autor       Modificacion
      =========      =========  ====================

    ******************************************************************/

    PROCEDURE UpdInsured (inuPackage IN mo_packages.package_id%TYPE)
    IS
        rcSinester     dald_sinester_claims.styLD_sinester_claims;
        rcSubscriber   dage_subscriber.styge_subscriber;
    BEGIN
        ut_trace.Trace ('INICIO: Ld_BoLiquidation.UpdInsured', 10);

        dald_sinester_claims.getRecord (
            ld_bcliquidation.FnuGetDetailLiq (inuPackage),
            rcSinester);
        dage_subscriber.getrecord (rcSinester.insured_id, rcSubscriber);
        dald_sinester_claims.updInsured_Id (
            ld_bcliquidation.FnuGetDetailLiq (inuPackage),
            rcSubscriber.identification);

        ut_trace.Trace ('FIN: Ld_BoLiquidation.UpdInsured', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END UpdInsured;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : ProcDatInsured
      Descripcion    : Retorna los datos de inicializacion del asegurado para la liquidacion de
                       siniestros

      Autor          : AACuna
      Fecha          : 09/01/2013 SAO 159764

      Parametros         Descripcion
      ============   ===================
      inuPackage      :Numero de la solicitud
      osbInsured_id    Identificacion del asegurado
      osbInsured_name  Nombre del asegurado

      Historia de Modificaciones
      Fecha            Autor       Modificacion
      =========      =========  ====================

    ******************************************************************/

    PROCEDURE ProcDatInsured (
        inuPackage        IN     mo_packages.package_id%TYPE,
        osbInsured_idI       OUT ge_subscriber.subscriber_id%TYPE,
        osbInsured_name      OUT ld_sinester_claims.insured_name%TYPE,
        onuSuscripc          OUT suscripc.susccodi%TYPE,
        odtLossDate          OUT ld_sinester_claims.claims_date%TYPE)
    IS
        osbInsured_id       ld_sinester_claims.insured_id%TYPE;
        rcMopackage         damo_packages.styMO_packages;
        rcSinesterClaims    dald_sinester_claims.styLD_sinester_claims;
        nuSinester_claims   ld_sinester_claims.sinester_claims_id%TYPE;
    BEGIN
        ut_trace.Trace ('INICIO: Ld_BoLiquidation.FsbDatInsured', 10);

        ld_bcliquidation.ProcDatInsured (inuPackage,
                                         osbInsured_id,
                                         osbInsured_name);

        ld_bcsecuremanagement.GetSubscriberById (osbInsured_id,
                                                 osbInsured_idI);

        damo_packages.getRecord (inuPackage, rcMopackage);

        nuSinester_claims := ld_bcliquidation.FnuGetDetailLiq (inuPackage);

        dald_sinester_claims.getRecord (nuSinester_claims, rcSinesterClaims);

        onuSuscripc := rcMopackage.subscription_pend_id;

        odtLossDate := rcSinesterClaims.claims_date;

        ut_trace.Trace ('FIN: Ld_BoLiquidation.FsbDatInsured', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
            osbInsured_id := NULL;
            osbInsured_name := NULL;
        WHEN NO_DATA_FOUND
        THEN
            osbInsured_id := NULL;
            osbInsured_name := NULL;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
            osbInsured_id := NULL;
            osbInsured_name := NULL;
    END ProcDatInsured;

    /*****************************************************************
     Propiedad intelectual de Open International Systems (c).

     Unidad         : FsbgetconceptsInt
     Descripcion    : Obtiene los conceptos asociados a los conceptos de interes de financiacion

     Autor          : AAcuna
     Fecha          : 28/04/2013

     Parametros       Descripcion
     ============     ===================
     isbConcept       Conceptos

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     28/04/2013       AAcuna.SAO159764      Creacion

    ******************************************************************/
    FUNCTION FsbgetconceptsInt (isbConcept IN VARCHAR2)
        RETURN VARCHAR2
    IS
        CURSOR concepts IS
            SELECT LISTAGG (conccoin, '|') WITHIN GROUP (ORDER BY conccodi)    conccodi
              FROM concepto
             WHERE INSTR (isbConcept, '|' || conccodi || '|') > 0;

        sbanswer   VARCHAR2 (32000);
        sbTemp     VARCHAR2 (1000);
    BEGIN
        ut_trace.trace ('Inicio LD_BOLiquidation.FsbgetconceptsInt', 10);

        FOR rgconcepts IN concepts
        LOOP
            sbanswer := rgconcepts.conccodi;
        END LOOP;

        ut_trace.trace ('Fin LD_BOLiquidation.FsbgetconceptsInt', 10);

        RETURN (sbanswer);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END FsbgetconceptsInt;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : ProcInDatRel
      Descripcion    : Inicializa los campos de la forma ldrqs (Liquidacion de siniestros)
                       Los campos que se inicializan son:
                       Fecha de siniestro, causal y tipo de cobertura con los datos que ya se tienen guardados en la liquidacion.

      Autor          : AACuna
      Fecha          : 08/05/2013 SAO 159764

      Parametros         Descripcion
      ============   ===================
      inuPackage    : Numero de la solicitud
      odtSinester   : Fecha del siniestro
      onuCausal     : Causal de la liquidacion
      onuCovType    : Tipo de cobertura
      onuError      : Error
      osbMessage    : Mensaje de error

      Historia de Modificaciones
      Fecha           Autor       Modificacion
      =========      =========  ====================
      08/05/2013     AAcuna     Creacion
    ******************************************************************/

    PROCEDURE ProcInDatRel (
        inuLiquidation   IN     ld_liquidation.liquidation_id%TYPE,
        odtSinester         OUT ld_liquidation.loss_date%TYPE,
        onuCausal           OUT ld_liquidation.application_cause_id%TYPE,
        onuCovType          OUT ld_liquidation.coverage_type%TYPE,
        onuError            OUT ge_message.message_id%TYPE,
        osbMessage          OUT ge_message.description%TYPE)
    IS
    BEGIN
        ut_trace.Trace ('INICIO: Ld_BoLiquidation.ProcInDatRel', 10);

        odtSinester := dald_liquidation.fdtGetLoss_Date (inuLiquidation);

        onuCausal :=
            dald_liquidation.fnuGetApplication_Cause_Id (inuLiquidation);

        onuCovType := dald_liquidation.fnuGetCoverage_Type (inuLiquidation);

        ut_trace.Trace ('FIN: Ld_BoLiquidation.ProcInDatRel', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            Errors.getError (onuerror, osbMessage);
            DBMS_OUTPUT.put_line ('ERROR CONTROLLED');
            DBMS_OUTPUT.put_line ('error onuErrorCode: ' || onuerror);
            DBMS_OUTPUT.put_line ('error osbErrorMess: ' || osbMessage);
        WHEN OTHERS
        THEN
            Errors.setError;
            Errors.getError (onuerror, osbMessage);
            DBMS_OUTPUT.put_line ('ERROR OTHERS ');
            DBMS_OUTPUT.put_line ('error onuErrorCode: ' || onuerror);
            DBMS_OUTPUT.put_line ('error osbErrorMess: ' || osbMessage);
    END ProcInDatRel;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ValidateProductFnbGnvSeguros
    Descripcion    : Esta funcion valida si el contrato, tiene por lo menos
                     algun producto ya sea de microseguros o de FNB
    Autor          : Kbaquero
    Fecha          : 29/05/2013 SAO 159764

    Parametros         Descripcion
    ============   ===================
    inususc:        Id. del contrato

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/

    PROCEDURE ValidateProductFnbGnvSeguros (
        inususc   IN suscripc.susccodi%TYPE)
    IS
        nuProduct      NUMBER;
        nuProductfnb   NUMBER;
    BEGIN
        ut_trace.Trace (
            'INICIO Ld_BoLiquidation.ValidateProductFnbGnvSeguros',
            10);

        nuProduct := Ld_BcLiquidation.GetProductByContract (inususc);
        nuProductfnb := Ld_BcLiquidation.ValidateProductFnb (inususc);

        IF nuProductfnb = 0 AND nuProduct = 0
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                   'Este suscriptor no tiene tipo de producto de Brilla, ni Brillas Seguros,'
                || ' ni GNV activo');
        END IF;

        ut_trace.Trace ('FIN Ld_BoLiquidation.ValidateProductFnbGnvSeguros',
                        10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END ValidateProductFnbGnvSeguros;


    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  ValidateActivePolicy
    Descripcion :  Valida si existen polizas activas para el cliente y contrato
                   ingresados

    Autor       :  Hassan Hammad Lizalda
    Fecha       :  17-10-2013
    Parametros  :
        inuSuscriptionId                        Id de la suscripcion
        inuIdentification                       Identificacion del cliente
        inuProductId                            Id del producto

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    17-10-2013   hhammad.SAO220423  Creacion
    ***************************************************************/
    PROCEDURE ValidateActivePolicy (
        inuSusbcriptionId   IN suscripc.susccodi%TYPE,
        inuSubscriberId     IN ge_subscriber.subscriber_id%TYPE,
        inuProductId        IN pr_product.product_id%TYPE)
    IS
        tbPackages            dald_secure_sale.tytbSecure_Sale_Id;
        rcSubscriber          dage_subscriber.styGE_subscriber;
        nuBrillaProductType   pr_product.product_type_id%TYPE;
        rcProduct             dapr_product.stypr_product;
    BEGIN
        --{
        ut_trace.trace ('Inicio [Ld_BoLiquidation.ValidateActivePolicy]', 1);

        /* Consulta en el parametro general el estado activo de la poliza */
        sbState :=
            DALD_PARAMETER.fsbGetValue_Chain (
                LD_BOConstans.csbCodStatePolicy);

        /* Obtiene el tipo de producto brilla desde el parametro general */
        nuBrillaProductType :=
            dald_parameter.fnuGetNumeric_Value (
                inuParameter_Id   => ld_boconstans.cnuCodTypeProduct);

        /* Obtiene la informacion del producto ingresado */
        rcProduct := dapr_product.frcgetrecord (inuProductId);

        /* Si el producto ingresado no es de tipo "nuBrillaProductType", termina */
        IF (rcProduct.product_type_id <> nuBrillaProductType)
        THEN
            ut_trace.trace (
                   'El producto ingresado no es de tipo '
                || nuBrillaProductType
                || '. No se realiza validacion de polizas.',
                1);
            ut_trace.trace ('Fin [Ld_BoLiquidation.ValidateActivePolicy]', 1);
            RETURN;
        END IF;

        /* Obtiene la informacion del cliente */
        rcSubscriber := dage_subscriber.frcgetrecord (inuSubscriberId);

        /* Consulta las polizas activas para el cliente y contrato */
        ld_bcliquidation.ProcCancelBySinester (inuSusbcriptionId,
                                               sbState,
                                               rcSubscriber.identification,
                                               tbPackages);

        /* Si no encontro polizas activas, genera mensaje de error */
        IF (tbPackages.COUNT = 0)
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                   'El contrato '
                || inuSusbcriptionId
                || ' no tiene polizas asociadas al cliente con identificacion '
                || rcSubscriber.identification);
        END IF;

        ut_trace.trace ('Fin [Ld_BoLiquidation.ValidateActivePolicy]', 1);
    --}
    EXCEPTION
        --{
        WHEN ex.CONTROLLED_ERROR
        THEN
            ut_trace.trace (
                'ex.CONTROLLED_ERROR [Ld_BoLiquidation.ValidateActivePolicy]',
                1);
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.SetError;
            ut_trace.trace ('OTHERS [Ld_BoLiquidation.ValidateActivePolicy]',
                            1);
            RAISE ex.CONTROLLED_ERROR;
    --}
    END ValidateActivePolicy;
END Ld_BoLiquidation;
/
