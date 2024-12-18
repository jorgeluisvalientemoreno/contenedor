CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKCRMFINBRILLAPORTAL
AS
    /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

             PAQUETE : LDCI_PKCRMFINBRILLAPORTAL
             AUTOR   : Karem Baquero
             FECHA   : 29/01/2014
             RICEF   : I065-I066-I070
     DESCRIPCION : Paquete de integraci??A???A?n que contiene todas las funcionalidades referentes
                   a las financiaci??A???A?n brilla portal web



     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     KBaquero    27/04/2017     caso 200-1075 se valida que el suscriptor cumpla con pol?tica brilla.
                                 para asignarle cupo Extra
     Llozada      08-10-2014   Se modifica el paquete <<proRegisCoDeuFNB>>
     KARBAQ       19/05/2014   Creacion del paquete
     KARBAQ       19/05/2014   Creacion Validacion de facturas proceso <<proValFact>>
     KARBAQ       22/05/2014   Creacion consulta de extra cupo Brilla <<proConsExtraCupoFNB>>
     KARBAQ       22/05/2014   Creacion consulta de la funcion extra cupo Brilla <<frfgetExtraQuoteBySubs>>
     KARBAQ       23/05/2014   Creacion validacion codeudor <<proValconsignerFNB>>
     KARBAQ       30/07/2014   Creacion Consulta servicio suscrto <<Fnugetsesunuse>>
     KARBAQ       09/09/2014    se modifica el metodo <<proRegisVentaFNB>> segun
                                NC 1840.
     KARBAQ       19/11/2014    Creaci?n calculo de la cuota mensual <<Fnugetcalcuota>>
     KARBAQ       01/07/2015    se modifica el metodo <<proRegisDeuFNB>>
     sampac       14/03/2016    caso 100-9793 se adiciona parametro de entrada servicio proValconsignerFNB
                                que identifica si el deudor es titular de la factura o no.
    jpinedc       10/05/2024    OSF-2603: * Ajustes por últimos estandares de programación
                                * Se cambia ldc_email.mail por pkg_Correo.prcEnviaCorreo
    ************************************************************************/
    /*Tipo Record para Lineas*/
    TYPE rectasint IS RECORD
    (
        LINE_ID              LD_FINAN_PLAN_FNB.LINE_ID%TYPE,
        DESCRIPTION          LD_LINE.DESCRIPTION%TYPE,
        FINAN_PLAN_FNB_ID    LD_FINAN_PLAN_FNB.FINAN_PLAN_FNB_ID%TYPE,
        FINANCING_PLAN_ID    LD_FINAN_PLAN_FNB.FINANCING_PLAN_ID%TYPE,
        PLDIDESC             PLANDIFE.PLDIDESC%TYPE,
        CATEGORY_ID          LD_FINAN_PLAN_FNB.CATEGORY_ID%TYPE,
        CATEDESC             CATEGORI.CATEDESC%TYPE,
        PLDICUMI             PLANDIFE.PLDICUMI%TYPE,
        PLDICUMA             PLANDIFE.PLDICUMA%TYPE,
        PLDITAIN             PLANDIFE.PLDITAIN%TYPE,
        COTIPORC             CONFTAIN.COTIPORC%TYPE,
        TASA_NNAL_MENSUAL    NUMBER
    );

    TYPE tbtsaint IS TABLE OF rectasint;

    rectasinte   tbtsaint := tbtsaint ();

    FUNCTION Fnugetsesunuse (inususcripc     IN servsusc.sesususc%TYPE,
                             inuRaiseError   IN NUMBER DEFAULT 1)
        RETURN servsusc.sesunuse%TYPE;

    FUNCTION Fnugetcalcuota (nuvalototal   IN NUMBER,
                             nuplazo       IN NUMBER,
                             nuarti           ld_article.article_id%TYPE)
        RETURN NUMBER;

    PROCEDURE proValFact (inuSuscCodi       IN     SUSCRIPC.SUSCCODI%TYPE,
                          inuBill1                 factura.factcodi%TYPE,
                          idtBill1                 factura.factfege%TYPE,
                          inuBill2                 factura.factcodi%TYPE,
                          idtBill2                 factura.factfege%TYPE,
                          onuErrorCode      IN OUT NUMBER,
                          osbErrorMessage   IN OUT VARCHAR2);

    PROCEDURE proConsExtraCupoFNB (
        inususc             IN     suscripc.susccodi%TYPE,
        inuprov             IN     ld_extra_quota.supplier_id%TYPE,
        inuline             IN     ld_extra_quota.line_id%TYPE,
        inuSALE_CHANEL_ID   IN     ld_extra_quota.sale_chanel_id%TYPE,
        orfCursor              OUT Constants.tyRefCursor,
        onuErrorCode           OUT NUMBER,
        osbErrorMessage        OUT VARCHAR2);

    FUNCTION frfgetExtraQuoteBySubs (
        inuSubscription     IN suscripc.susccodi%TYPE,
        inuproveed          IN ld_extra_quota.supplier_id%TYPE,
        inuline             IN ld_extra_quota.line_id%TYPE,
        inuSALE_CHANEL_ID   IN ld_extra_quota.sale_chanel_id%TYPE)
        RETURN constants.tyrefcursor;

    PROCEDURE proRegisDeuFNB (
        inuSubscriberId        IN     ge_subscriber.subscriber_id%TYPE,
        inuPromissory_id       IN     ld_promissory.promissory_id%TYPE,
        isbHolder_Bill         IN     ld_promissory.holder_bill%TYPE,
        isbDebtorName          IN     ld_promissory.debtorname%TYPE,
        inuIdentType           IN     ld_promissory.ident_type_id%TYPE,
        isbIdentification      IN     ld_promissory.identification%TYPE,
        inuForwardingPlace     IN     ld_promissory.forwardingplace%TYPE,
        idtForwardingDate      IN     ld_promissory.forwardingdate%TYPE,
        isbGender              IN     ld_promissory.gender%TYPE,
        inuCivil_State_Id      IN     ld_promissory.civil_state_id%TYPE,
        idtBirthdayDate        IN     ld_promissory.birthdaydate%TYPE,
        inuSchool_Degree_      IN     ld_promissory.school_degree_%TYPE,
        inuAddress_Id          IN     ld_promissory.address_id%TYPE,
        isbPropertyPhone       IN     ld_promissory.propertyphone_id%TYPE,
        inuDependentsNumber    IN     ld_promissory.dependentsnumber%TYPE,
        inuHousingTypeId       IN     ld_promissory.housingtype%TYPE,
        inuHousingMonth        IN     ld_promissory.housingmonth%TYPE,
        isbHolderRelation      IN     ld_promissory.holderrelation%TYPE,
        isbOccupation          IN     ld_promissory.occupation%TYPE,
        isbCompanyName         IN     ld_promissory.companyname%TYPE,
        inuCompanyAddress_Id   IN     ld_promissory.companyaddress_id%TYPE,
        isbPhone1              IN     ld_promissory.phone1_id%TYPE,
        isbPhone2              IN     ld_promissory.phone2_id%TYPE,
        isbMovilPhone          IN     ld_promissory.movilphone_id%TYPE,
        inuOldLabor            IN     ld_promissory.oldlabor%TYPE,
        inuActivityId          IN     ld_promissory.activity%TYPE,
        inuMonthlyIncome       IN     ld_promissory.monthlyincome%TYPE,
        inuExpensesIncome      IN     ld_promissory.expensesincome%TYPE,
        isbFamiliarReference   IN     ld_promissory.familiarreference%TYPE,
        isbPhoneFamiRefe       IN     ld_promissory.phonefamirefe%TYPE,
        inuMovilPhoFamiRefe    IN     ld_promissory.movilphofamirefe%TYPE,
        inuaddressfamirefe     IN     ld_promissory.addresspersrefe%TYPE,
        isbPersonalReference   IN     ld_promissory.personalreference%TYPE,
        isbPhonePersRefe       IN     ld_promissory.phonepersrefe%TYPE,
        isbMovilPhoPersRefe    IN     ld_promissory.movilphopersrefe%TYPE,
        inuaddresspersrefe     IN     ld_promissory.addresspersrefe%TYPE,
        isbcommerreference     IN     ld_promissory.commerreference%TYPE,
        isbphonecommrefe       IN     ld_promissory.phonecommrefe%TYPE,
        isbmovilphocommrefe    IN     ld_promissory.movilphocommrefe%TYPE,
        inuaddresscommrefe     IN     ld_promissory.addresscommrefe%TYPE,
        isbEmail               IN     ld_promissory.email%TYPE,
        inuPackage_Id          IN     ld_promissory.package_id%TYPE,
        inuCategoryId          IN     ld_promissory.category_id%TYPE,
        inuSubcategoryId       IN     ld_promissory.subcategory_id%TYPE,
        inuContractType        IN     ld_promissory.contract_type_id%TYPE,
        isblastname            IN     ld_promissory.last_name%TYPE,
        onuPromissory_id          OUT ld_promissory.promissory_id%TYPE,
        onuErrorCode              OUT NUMBER,
        osbErrorMessage           OUT VARCHAR2);

    PROCEDURE proRegisCoDeuFNB ( /*inuSubscriberId      in ge_subscriber.subscriber_id%type,*/
        inuPromissory_id       IN     ld_promissory.promissory_id%TYPE,
        isbHolder_Bill         IN     ld_promissory.holder_bill%TYPE,
        isbDebtorName          IN     ld_promissory.debtorname%TYPE,
        inuIdentType           IN     ld_promissory.ident_type_id%TYPE,
        isbIdentification      IN     ld_promissory.identification%TYPE,
        inuForwardingPlace     IN     ld_promissory.forwardingplace%TYPE,
        idtForwardingDate      IN     ld_promissory.forwardingdate%TYPE,
        isbGender              IN     ld_promissory.gender%TYPE,
        inuCivil_State_Id      IN     ld_promissory.civil_state_id%TYPE,
        idtBirthdayDate        IN     ld_promissory.birthdaydate%TYPE,
        inuSchool_Degree_      IN     ld_promissory.school_degree_%TYPE,
        inuAddress_Id          IN     ld_promissory.address_id%TYPE,
        isbPropertyPhone       IN     ld_promissory.propertyphone_id%TYPE,
        inuDependentsNumber    IN     ld_promissory.dependentsnumber%TYPE,
        inuHousingTypeId       IN     ld_promissory.housingtype%TYPE,
        inuHousingMonth        IN     ld_promissory.housingmonth%TYPE,
        isbHolderRelation      IN     ld_promissory.holderrelation%TYPE,
        isbOccupation          IN     ld_promissory.occupation%TYPE,
        isbCompanyName         IN     ld_promissory.companyname%TYPE,
        inuCompanyAddress_Id   IN     ld_promissory.companyaddress_id%TYPE,
        isbPhone1              IN     ld_promissory.phone1_id%TYPE,
        isbPhone2              IN     ld_promissory.phone2_id%TYPE,
        isbMovilPhone          IN     ld_promissory.movilphone_id%TYPE,
        inuOldLabor            IN     ld_promissory.oldlabor%TYPE,
        inuActivityId          IN     ld_promissory.activity%TYPE,
        inuMonthlyIncome       IN     ld_promissory.monthlyincome%TYPE,
        inuExpensesIncome      IN     ld_promissory.expensesincome%TYPE,
        isbFamiliarReference   IN     ld_promissory.familiarreference%TYPE,
        isbPhoneFamiRefe       IN     ld_promissory.phonefamirefe%TYPE,
        inuMovilPhoFamiRefe    IN     ld_promissory.movilphofamirefe%TYPE,
        inuaddressfamirefe     IN     ld_promissory.addresspersrefe%TYPE,
        isbPersonalReference   IN     ld_promissory.personalreference%TYPE,
        isbPhonePersRefe       IN     ld_promissory.phonepersrefe%TYPE,
        isbMovilPhoPersRefe    IN     ld_promissory.movilphopersrefe%TYPE,
        inuaddresspersrefe     IN     ld_promissory.addresspersrefe%TYPE,
        isbcommerreference     IN     ld_promissory.commerreference%TYPE,
        isbphonecommrefe       IN     ld_promissory.phonecommrefe%TYPE,
        isbmovilphocommrefe    IN     ld_promissory.movilphocommrefe%TYPE,
        inuaddresscommrefe     IN     ld_promissory.addresscommrefe%TYPE,
        isbEmail               IN     ld_promissory.email%TYPE,
        inuPackage_Id          IN     ld_promissory.package_id%TYPE,
        inuCategoryId          IN     ld_promissory.category_id%TYPE,
        inuSubcategoryId       IN     ld_promissory.subcategory_id%TYPE,
        inuContractType        IN     ld_promissory.contract_type_id%TYPE,
        isblastname            IN     ld_promissory.last_name%TYPE,
        onuErrorCode              OUT NUMBER,
        osbErrorMessage           OUT VARCHAR2);

    PROCEDURE proValconsignerFNB (
        inuSupplierId       IN     ld_extra_quota.supplier_id%TYPE,
        isbIdentification   IN     ld_promissory.identification%TYPE,
        inuIdent_Type_Id    IN     ge_subscriber.Ident_Type_Id%TYPE,
        inususcdeud         IN     suscripc.susccodi%TYPE,
        inususccodeud       IN     suscripc.susccodi%TYPE, --contrato del codeudor
        isbholder_bill      IN     ld_promissory.holder_bill%TYPE, --identifica si el deudor es titular o no
        OblResult              OUT VARCHAR2,
        -- blResult          OUT boolean,
        onuErrorCode           OUT NUMBER,
        osbErrorMessage        OUT VARCHAR2);

    PROCEDURE proConImpPagareFNB (
        nuPackageId                IN     ld_promissory.package_id%TYPE,
        sbPromissoryTypeDebtor     IN     ld_promissory.promissory_type%TYPE,
        sbPromissoryTypeCosigner   IN     ld_promissory.promissory_type%TYPE,
        orfCursor                     OUT Constants.tyRefCursor,
        onuErrorCode                  OUT NUMBER,
        osbErrorMessage               OUT VARCHAR2);

    PROCEDURE proConsprovLine (inuline           IN     ld_line.line_id%TYPE,
                               orfCursor            OUT Constants.tyRefCursor,
                               onuErrorCode      IN OUT NUMBER,
                               osbErrorMessage   IN OUT VARCHAR2);

    PROCEDURE proConsArtprovLine (
        inuline           IN     ld_line.line_id%TYPE,
        inuprov           IN     ld_article.supplier_id%TYPE,
        orfCursor            OUT Constants.tyRefCursor,
        onuErrorCode      IN OUT NUMBER,
        osbErrorMessage   IN OUT VARCHAR2);

    PROCEDURE proConsplanfiLineaFNB (
        inuline           IN     ld_line.line_id%TYPE,
        orfCursor            OUT Constants.tyRefCursor,
        onuErrorCode         OUT NUMBER,
        osbErrorMessage      OUT VARCHAR2);

    PROCEDURE proRegisVentaFNB (
        inuSubscription      IN     MO_PACKAGES.SUBSCRIPTION_PEND_ID%TYPE,
        inuclient            IN     ge_subscriber.subscriber_id%TYPE,
        inuCupoAprob         IN     ld_quota_by_subsc.quota_value%TYPE,
        inuCupoUtil          IN     ld_quota_by_subsc.quota_value%TYPE,
        inuExtraCupo         IN     ld_quota_by_subsc.quota_value%TYPE,
        inuCupoManUtil       IN     ld_quota_by_subsc.quota_value%TYPE,
        inuBill1             IN     factura.factcodi%TYPE,
        inuBill2             IN     factura.factcodi%TYPE,
        inuoperunit          IN     or_operating_unit.contractor_id%TYPE,
        inuSale_Channel_Id   IN     MO_PACKAGES.SALE_CHANNEL_ID%TYPE,
        inuPerson            IN     GE_PERSON.PERSON_ID%TYPE,
        idtsaleDate          IN     LD_NON_BA_FI_REQU.Sale_Date%TYPE,
        inuReception_Type    IN     MO_PACKAGES.RECEPTION_TYPE_ID%TYPE,
        isbPerioGrace        IN     LD_NON_BA_FI_REQU.Take_Grace_Period%TYPE,
        isbEntrPunt          IN     LD_NON_BA_FI_REQU.Delivery_Point%TYPE,
        inupayment           IN     ld_non_ba_fi_requ.payment%TYPE,
        isbComment_          IN     MO_PACKAGES.COMMENT_%TYPE,
        icuArticle           IN     CLOB,
        inuPromissory_id     IN     ld_promissory.promissory_id%TYPE,
        -- inuPromissory_idcod in ld_promissory.promissory_id%type,
        onuPackage_Id           OUT MO_PACKAGES.PACKAGE_ID%TYPE,
        onuErrorCode            OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        osbErrorMessage         OUT GE_MESSAGE.DESCRIPTION%TYPE);

    PROCEDURE OS_FinanBrillaPackages (
        inuSubscription      IN     MO_PACKAGES.SUBSCRIPTION_PEND_ID%TYPE,
        inuclient            IN     ge_subscriber.subscriber_id%TYPE,
        inuCupoAprob         IN     ld_quota_by_subsc.quota_value%TYPE,
        inuCupoUtil          IN     ld_quota_by_subsc.quota_value%TYPE,
        inuExtraCupo         IN     ld_quota_by_subsc.quota_value%TYPE,
        inuCupoManUtil       IN     ld_quota_by_subsc.quota_value%TYPE,
        inuBill1             IN     factura.factcodi%TYPE,
        inuBill2             IN     factura.factcodi%TYPE,
        inuoperunit          IN     or_operating_unit.operating_unit_id%TYPE,
        inuSale_Channel_Id   IN     MO_PACKAGES.SALE_CHANNEL_ID%TYPE,
        inuPerson            IN     GE_PERSON.PERSON_ID%TYPE,
        idtsaleDate          IN     LD_NON_BA_FI_REQU.Sale_Date%TYPE,
        inuReception_Type    IN     MO_PACKAGES.RECEPTION_TYPE_ID%TYPE,
        isbPerioGrace        IN     LD_NON_BA_FI_REQU.Take_Grace_Period%TYPE,
        isbEntrPunt          IN     LD_NON_BA_FI_REQU.Delivery_Point%TYPE,
        inupayment           IN     ld_non_ba_fi_requ.payment%TYPE,
        isbComment_          IN     MO_PACKAGES.COMMENT_%TYPE,
        icuArticle           IN     CLOB,
        onuPackage_Id           OUT MO_PACKAGES.PACKAGE_ID%TYPE,
        onuErrorCode            OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        osbErrorMessage         OUT GE_MESSAGE.DESCRIPTION%TYPE);

    FUNCTION funGetOperUnit (inuproveed IN ld_extra_quota.supplier_id%TYPE)
        RETURN NUMBER;

    PROCEDURE procvalIdenRedferido (
        ISBIDENTIFICACION   IN     LD_Result_Consult.Identification%TYPE,
        onuErrorCode           OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        osbErrorMessage        OUT GE_MESSAGE.DESCRIPTION%TYPE);

    PROCEDURE procConsultPagare (
        inuprov           IN     ld_extra_quota.supplier_id%TYPE,
        orfCursor            OUT Constants.tyRefCursor,
        onuErrorCode         OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        osbErrorMessage      OUT GE_MESSAGE.DESCRIPTION%TYPE);

    PROCEDURE procConsultPrecargue (
        inususc           IN     suscripc.susccodi%TYPE,
        orfCursor            OUT Constants.tyRefCursor,
        onuErrorCode         OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        osbErrorMessage      OUT GE_MESSAGE.DESCRIPTION%TYPE);

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fblValidateBills
    Descripcion    : Valida las facturas ingresadas.

    Autor          :
    Fecha          : 11/07/2012

    Parametros              Descripcion
    ============         ===================
    inuPackageId: Numero de la solicitud.


    Historia de Modificaciones
    Fecha       Autor                 Modificacion
    =========   =========             ====================
    30-08-2013  lfernandez.SAO211609  Se corrige validacion de la fecha de la
                                      factura 2
    29-08-2013  lfernandez.SAO211609  Se muestran mensajes de error cuando se
                                      ingresan valores invalidos
    ******************************************************************/
    FUNCTION fblValidateBills (inuSubscription   suscripc.susccodi%TYPE,
                               inuBill1          factura.factcodi%TYPE,
                               idtBill1          factura.factfege%TYPE,
                               inuBill2          factura.factcodi%TYPE,
                               idtBill2          factura.factfege%TYPE)
        RETURN BOOLEAN;
END LDCI_PKCRMFINBRILLAPORTAL;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKCRMFINBRILLAPORTAL
AS

		-- Constantes para el control de la traza
	csbSP_NAME 	CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
	cnuNVLTRC 	CONSTANT NUMBER 		:= pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;


    FUNCTION Fnugetsesunuse (inususcripc     IN servsusc.sesususc%TYPE,
                             inuRaiseError   IN NUMBER DEFAULT 1)
        RETURN servsusc.sesunuse%TYPE
    IS
        /***************************************************************
         PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

                 PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.Fnugetsesunuse
                 AUTOR   : Sincecomp/Karem Baquero
                 FECHA   : 30/07/2014
                 RICEF   : l078
           DESCRIPCION   : Se realizala consulta del servicio suscrito
                           a traves del suscriptor para el registro de la venta brilla
                           con solicitud de venta FNB.
         Parametros de Salida

         Historia de Modificaciones

         Autor        Fecha       Descripcion.
        SEBTAP        29/09/2017   Se ajusatan los servicios (proRegisVentaFNB, OS_FinanBrillaPackages)
                                   para evitar ventas repetidas Ca200-1382
        **************************************************************************/

        nusesunuse                    servsusc.sesunuse%TYPE;
        cnuInactiveService   CONSTANT servsusc.sesuesco%TYPE := 96;

        CURSOR cuProduct IS
            SELECT /*+ leading( a )
                                                                                                                    index( a IDX_PR_PRODUCT_010 )
                                                                                                                    index( s PK_SERVSUSC )
                                                                                                                    index( c PK_PS_PRODUCT_STATUS ) */
                   s.sesunuse
              FROM pr_product a, servsusc s, ps_product_status c
             WHERE     a.subscription_id = inususcripc
                   AND a.product_type_id = ld_boconstans.cnuGasService
                   AND s.sesunuse = a.product_id
                   AND (s.sesufere IS NULL OR s.sesufere > SYSDATE)
                   AND a.product_status_id = c.product_status_id            --
                   AND c.is_active_product = 'Y'
                   AND c.is_final_status = 'Y'
                   AND s.sesuesco <> cnuInactiveService
                   AND ROWNUM = 1;
    BEGIN
        pkg_Traza.Trace ('Inicio Ld_BcSubsidy.Fnugetsesunuse', 10);

        OPEN cuProduct;

        FETCH cuProduct INTO nusesunuse;

        CLOSE cuProduct;

        pkg_Traza.Trace ('Fin Ld_BcSubsidy.Fnugetsesunuse ', 10);
        RETURN (nusesunuse);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            IF inuRaiseError = 1
            THEN
                Errors.setError;
                RAISE ex.CONTROLLED_ERROR;
            ELSE
                RETURN NULL;
            END IF;
    END Fnugetsesunuse;

    ---------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    FUNCTION Fnugetcalcuota (nuvalototal   IN NUMBER,
                             nuplazo       IN NUMBER,
                             nuarti           ld_article.article_id%TYPE)
        RETURN NUMBER
    IS
        /***************************************************************
         PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

                 PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.Fnugetcalcuota
                 AUTOR   : Sincecomp/Karem Baquero
                 FECHA   : 19/11/2014
                 RICEF   : l078
           DESCRIPCION   : Se realiza el calculo del valor de la cuota aproximada
                           mensual.
         Parametros de Salida

         Historia de Modificaciones

         Autor        Fecha       Descripcion.

        **************************************************************************/
        nuvalcuota        NUMBER;
        nuinteres         NUMBER;
        rfCursorlinea     constants.tyRefCursor; --Cursor para obtener la tasa de interes
        nuNextline        NUMBER;                      -- revision de la linea
        rfline            ldci_pkcrmfinbrillaportal.rectasinte%TYPE;
        onuErrorCode      GE_MESSAGE.MESSAGE_ID%TYPE;
        osbErrorMessage   GE_MESSAGE.DESCRIPTION%TYPE;
        nusubline         ld_subline.subline_id%TYPE;
        nuline            ld_line.line_id%TYPE;
        NUFinanPercent    NUMBER;              --porcentaje de interes vigente
        dbTmp             NUMBER;
    BEGIN
        pkg_Traza.Trace ('Inicio LDCI_PKCRMFINBRILLAPORTAL.Fnugetcalcuota',
                        10);

        --nuinteres = dbInt / 100;

        /*Obtener tasa de interes*/

        LDCI_PKCRMFINBRILLA.proConsLineaFNB (NULL,
                                             rfCursorlinea,
                                             onuErrorCode,
                                             osbErrorMessage);

        /*
                   nuNextline     number;-- revision de la linea
        rfline          ldci_pkcrmfinbrillaportal.rectasinte%type;*/

        LOOP
            FETCH rfCursorlinea BULK COLLECT INTO rfline LIMIT 10;

            nuNextline := rfline.FIRST;

            WHILE (nuNextline IS NOT NULL)
            LOOP
                nusubline := dald_article.fnuGetSubline_Id (nuarti);
                nuline := dald_subline.fnuGetLine_Id (nusubline);

                IF nuline = rfline (nuNextline).LINE_ID
                THEN
                    NUFinanPercent := rfline (nuNextline).TASA_NNAL_MENSUAL;
                END IF;

                nuNextline := rfline.NEXT (nuNextline);
            END LOOP;

            EXIT WHEN rfCursorlinea%NOTFOUND;
        END LOOP;

        nuinteres := NUFinanPercent / 100;                         -- valor de

        dbTmp := POWER ((1.00 + nuinteres), nuPlazo);

        -- select power((1.00 + nuinteres),nuPlazo)into dbTmp from dual;

        nuvalcuota :=
            ROUND (nuvalototal * ((nuinteres * dbTmp) / (dbTmp - 1.00)));

        pkg_Traza.Trace ('Fin LDCI_PKCRMFINBRILLAPORTAL.Fnugetcalcuota', 10);
        RETURN (nuvalcuota);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END Fnugetcalcuota;

    ---------------------------------------------------------------------------
    ----------------------------------------------------------------------------

    PROCEDURE proValFact (inuSuscCodi       IN     SUSCRIPC.SUSCCODI%TYPE,
                          inuBill1          IN     factura.factcodi%TYPE,
                          idtBill1          IN     factura.factfege%TYPE,
                          inuBill2          IN     factura.factcodi%TYPE,
                          idtBill2          IN     factura.factfege%TYPE,
                          onuErrorCode      IN OUT NUMBER,
                          osbErrorMessage   IN OUT VARCHAR2)
    AS
        /***************************************************************
         PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

                 PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.proValFact
                 AUTOR   : Sincecomp/Karem Baquero
                 FECHA   : 19/05/2014
                 RICEF   : I066
           DESCRIPCION   : Proceso que realiza la validaci??n de las
                           facturas y la fecha de emisi??n para la venta
                           de brilla.
         Parametros de Salida

         Historia de Modificaciones

         Autor        Fecha       Descripcion.
         KARBAQ      19/05/2014   Creacion del proceso

        **************************************************************************/
        nurespuesta   BOOLEAN;
    BEGIN
        pkg_Traza.Trace ('LDCI_PKCRMFINBRILLAPORTAL.proValFact', 15);

        IF inuBill1 <> NVL (inuBill2, -1)
        THEN
            nurespuesta :=
                fblValidateBills (inuSuscCodi,
                                  inuBill1,
                                  idtBill1,
                                  inuBill2,
                                  idtBill2);

            onuErrorCode := 0;
            osbErrorMessage := '';
        ELSE
            GE_BOErrors.SetErrorCodeArgument (
                2741,
                'Las facturas deben ser diferentes');
        END IF;

        pkg_Traza.Trace ('LDCI_PKCRMFINBRILLAPORTAL.proValFact', 15);
    EXCEPTION
        WHEN OTHERS
        THEN
            errors.geterror (onuErrorCode, osbErrorMessage);
    END proValFact;

    --------------------------------------------------------------------------
    ------------------------------------------------------------------------------
    PROCEDURE proConsExtraCupoFNB (
        inususc             IN     suscripc.susccodi%TYPE,
        inuprov             IN     ld_extra_quota.supplier_id%TYPE,
        inuline             IN     ld_extra_quota.line_id%TYPE,
        inuSALE_CHANEL_ID   IN     ld_extra_quota.sale_chanel_id%TYPE,
        orfCursor              OUT Constants.tyRefCursor,
        onuErrorCode           OUT NUMBER,
        osbErrorMessage        OUT VARCHAR2)
    AS
    /***************************************************************
        PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

                PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.proConsLineaFNB
                AUTOR   : Sincecomp/Karem Baquero
                FECHA   : 22/05/2014
                RICEF   : l065
          DESCRIPCION   : Se obtiene la informacion de la configuracion del
                          extra cupo
        Parametros de Salida

        Historia de Modificaciones

        Autor        Fecha       Descripcion.
        Karbaq      22/05/2014   Creacion del proceso

    **************************************************************************/

    BEGIN
        pkg_Traza.Trace (
               'INICIO LDCI_PKCRMFINBRILLAPORTAL.proConsExtraCupoFNB['
            || inususc
            || ']',
            10);

        orfCursor :=
            LDCI_PKCRMFINBRILLAPORTAL.frfgetExtraQuoteBySubs (
                inususc,
                inuprov,
                inuline,
                inuSALE_CHANEL_ID);

        --#TODO:
        IF (orfCursor%ISOPEN = FALSE)
        THEN
            OPEN orfCursor FOR SELECT -1          LINEA,
                                      -1          SUBLINEA,
                                      -1          PROVEEDOR,
                                      -1          CANAL,
                                      -1          VALOR,
                                      SYSDATE     FECHAINI,
                                      SYSDATE     FECHAFIN,
                                      -1          EXTRACUPO
                                 FROM DUAL
                                WHERE 1 = 1;

            DBMS_OUTPUT.PUT_LINE ('orfCursor%ISOPEN = false');
        END IF;                          -- IF (orfCursor%ISOPEN = false) then

        onuErrorCode := 0;
        osbErrorMessage := '';

        pkg_Traza.Trace (
               'FIN LDCI_PKCRMFINBRILLAPORTAL.proConsExtraCupoFNB['
            || inususc
            || ']',
            10);
    EXCEPTION
        WHEN OTHERS
        THEN
            osbErrorMessage :=
                   'Error en proceso de consulta de saldo brilla: '
                || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            onuErrorCode := -1;

            OPEN orfCursor FOR SELECT -1          LINEA,
                                      -1          SUBLINEA,
                                      -1          PROVEEDOR,
                                      -1          CANAL,
                                      -1          VALOR,
                                      SYSDATE     FECHAINI,
                                      SYSDATE     FECHAFIN,
                                      -1          EXTRACUPO
                                 FROM DUAL
                                WHERE 1 = 1;

            errors.geterror (onuErrorCode, osbErrorMessage);
    END proConsExtraCupoFNB;

    ---------------------------------------------------------------------------
    ---------------------------------------------------------------------------

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ftbgetExtraQuoteBySubs
    Descripcion    : Se obtiene la informacion de la configuracion del
                     extra cupo
    PAQUETE        : LDCI_PKCRMFINBRILLAPORTAL.frfgetExtraQuoteBySubs
    RICEF          : l065
    Autor          : Sincecomp/Karem Baquero
    Fecha          : 22/05/2014

    Parametros              Descripcion
    ============         ===================
    ENTRADA
    inuSubscription        Identificador del contrato.
    inuproveed             Identificador del proveedor.

    Historia de Modificaciones
      Autor            Fecha              Modificacion
    =========         =========           ====================
       KBaquero    27/04/2017caso 200-1075  Se valida que el suscriptor cumpla con pol?tica brilla.
                                           para asignarle cupo Extra
    ******************************************************************/
    FUNCTION frfgetExtraQuoteBySubs (
        inuSubscription     IN suscripc.susccodi%TYPE,
        inuproveed          IN ld_extra_quota.supplier_id%TYPE,
        inuline             IN ld_extra_quota.line_id%TYPE,
        inuSALE_CHANEL_ID   IN ld_extra_quota.sale_chanel_id%TYPE)
        RETURN constants.tyrefcursor
    IS
        nuGASProduct      NUMBER;
        rcab_address      daab_address.styAB_address;
        sbParentsGeoLoc   VARCHAR2 (2000);
        sbSelect          VARCHAR2 (5000);
        sbFrom            VARCHAR2 (5000);
        sbWhere           VARCHAR2 (5000);
        SbSQL             VARCHAR2 (5000);
        cuCursor          constants.tyrefcursor;
        rcServ            servsusc%ROWTYPE;
        rcProduct         dapr_product.stypr_product;
        nuQuotaValue      ld_quota_by_subsc.quota_value%TYPE;
        vnuTotal          NUMBER := 0;
        Sbaplica_quota    ld_parameter.value_chain%TYPE
            := DALD_PARAMETER.fsbGetValue_Chain (
                   'APLICA_POLITICAS_QUOTA_FIACE');
    --nuOperatingUnitId or_operating_unit.operating_unit_id%type;
    --rcOperatingUnit daor_operating_unit.styor_operating_unit;

    BEGIN
        pkg_Traza.Trace (
               'INICIO LDCI_PKCRMFINBRILLAPORTAL.frfgetExtraQuoteBySubs['
            || inuSubscription
            || ']',
            1);

        --200-1075 valida que el suscriptor tenga cupo asignado por cumplimiento de politica
        ld_bononbankfinancing.AllocateQuota (inuSubscription, vnuTotal);

        IF LD_BOCONSTANS.csbokFlag = Sbaplica_quota AND vnuTotal <= 0
        THEN
            sbSelect :=
                   'select l.extra_quota_id identificador,'
                || 'nvl2(line_id, line_id ||'' - ''||DALD_LINE.fsbGetDescription(line_id,0), ''Todas'') Linea,'
                || 'nvl2(subline_id, subline_id||'' - ''||DALD_SUBLINE.fsbGetDescription(subline_id,0), ''Todas'') Sublinea,'
                || 'supplier_id||'' - ''||DAGE_CONTRATISTA.fsbgetnombre_contratista(supplier_id,0) Proveedor,'
                || 'nvl2(sale_chanel_id, sale_chanel_id||'' - ''||DAGE_RECEPTION_TYPE.fsbGetDescription(sale_chanel_id,0), ''Todos'') Chanel_Sale,'
                || 'decode(quota_option, ''P'', ''Porcentaje'',''V'', ''Valor'') Quota_Type,'
                || 'value,'
                || 'initial_date,'
                || 'final_date,'
                || inuSubscription
                || '  parent_id  ';
            sbFrom := 'from ld_extra_quota l ';
            sbWhere := 'where (l.extra_quota_id = -1)';

            --|| 'and l.initial_date < sysdate ' || 'and l.final_date > sysdate ';

            SbSQL := sbSelect || sbFrom || sbWhere;

            pkg_Traza.Trace (SbSQL, 10);

            OPEN cuCursor FOR sbSql;

            RETURN cuCursor;
        -- end if;

        ELSE
            nuGASProduct :=
                ld_bononbankfinancing.fnugetGasProduct (
                    inuSubscription   => inuSubscription);

            IF nuGASProduct IS NOT NULL
            THEN
                rcServ := pktblservsusc.frcGetRecord (nuGASProduct);
                rcProduct := dapr_product.frcGetRecord (nuGASProduct);

                rcab_address :=
                    daab_address.frcGetRecord (
                        inuAddress_Id   => rcProduct.ADDRESS_ID);

                IF     rcab_address.NEIGHBORTHOOD_ID IS NOT NULL
                   AND rcab_address.NEIGHBORTHOOD_ID !=
                       ld_boconstans.cnuallrows
                THEN
                    ge_bogeogra_location.getgeograpparents (
                        inuChildGeoLocId   => rcab_address.NEIGHBORTHOOD_ID,
                        isbText            => sbParentsGeoLoc);
                ELSIF rcab_address.GEOGRAP_LOCATION_ID IS NOT NULL
                THEN
                    ge_bogeogra_location.getgeograpparents (
                        inuChildGeoLocId   => rcab_address.GEOGRAP_LOCATION_ID,
                        isbText            => sbParentsGeoLoc);
                ELSE
                    sbParentsGeoLoc :=
                        ' nvl( l.geograp_location_id, l.geograp_location_id) ';
                END IF;
            ELSE
                rcServ.Sesucate := 0;

                rcServ.Sesusuca := 0;

                sbParentsGeoLoc := 0;
            END IF;

            SELECT ld_quota_by_subsc.quota_value
              INTO nuQuotaValue
              FROM ld_quota_by_subsc
             WHERE ld_quota_by_subsc.subscription_id = inuSubscription;

            sbSelect :=
                   'select  line_id||decode(line_id, null, null,''-'') || dald_line.fsbGetDescription(line_id,0) LINEA,
                subline_id||decode(subline_id, null, null,''-'') || dald_subline.fsbGetDescription(subline_id,0) SUBLINEA,
                supplier_id||decode(supplier_id, null, null,''-'') || dage_contratista.fsbgetnombre_contratista(supplier_id,0) PROVEEDOR,
                sale_chanel_id||decode(sale_chanel_id, null, null,''-'') || dage_reception_type.fsbGetDescription(sale_chanel_id,0) CANAL,
                (LD_BONONBANKFINANCING.fnuQuotaTotal('
                || nuQuotaValue
                || ',value,l.quota_option))- nvl(f.used_quota,0) VALOR,
                initial_date FECHAINI, final_date FECHAFIN,  l.extra_quota_id EXTRACUPO ';
            sbFrom := 'from ld_extra_quota l, ld_extra_quota_fnb f ';
            sbWhere :=
                   'where l.extra_quota_id = f.extra_quota_id(+)
                AND f.subscription_id(+) = '
                || inuSubscription
                || '
                AND (l.category_id is null or l.category_id = '
                || TO_CHAR (rcServ.Sesucate)
                || ') and (l.subcategory_id is null or l.subcategory_id = '
                || TO_CHAR (rcServ.Sesusuca)
                || ') and (l.geograp_location_id is null or l.geograp_location_id in ('
                || sbParentsGeoLoc
                || ' )) and trunc(sysdate) between trunc(l.initial_date) and trunc(l.final_date)
                 and (l.line_id ='
                || inuline
                || ' OR l.line_id IS null)';

            /* Si la clasificacion de la unidad operativa es 71 - Proveedor de Brilla,
            se debe mostrar el cupo extra configurado para el mismo */

            --IF rcOperatingUnit.oper_unit_classif_id = 71 THEN
            IF inuSALE_CHANEL_ID IS NOT NULL
            THEN
                sbWhere :=
                       sbWhere
                    || ' AND (l.supplier_id = '
                    || inuproveed           /*rcOperatingUnit.contractor_id */
                    || ' OR l.supplier_id IS null)';
            END IF;

            IF inuSALE_CHANEL_ID IS NOT NULL
            THEN
                sbWhere :=
                       sbWhere
                    || ' AND (l.sale_chanel_id  = '
                    || inuSALE_CHANEL_ID    /*rcOperatingUnit.contractor_id */
                    || ' OR l.sale_chanel_id IS null)';
            END IF;

            --END IF;

            SbSQL := sbSelect || sbFrom || sbWhere;

            DBMS_OUTPUT.put_line (SbSQL);

            OPEN cuCursor FOR sbSql;

            RETURN cuCursor;
        END IF;

        pkg_Traza.Trace (
            'FIN LDCI_PKCRMFINBRILLAPORTAL.frfgetExtraQuoteBySubs',
            1);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END frfgetExtraQuoteBySubs;

    ----------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------
    PROCEDURE proRegisDeuFNB (
        inuSubscriberId        IN     ge_subscriber.subscriber_id%TYPE,
        inuPromissory_id       IN     ld_promissory.promissory_id%TYPE,
        isbHolder_Bill         IN     ld_promissory.holder_bill%TYPE,
        isbDebtorName          IN     ld_promissory.debtorname%TYPE,
        inuIdentType           IN     ld_promissory.ident_type_id%TYPE,
        isbIdentification      IN     ld_promissory.identification%TYPE,
        inuForwardingPlace     IN     ld_promissory.forwardingplace%TYPE,
        idtForwardingDate      IN     ld_promissory.forwardingdate%TYPE,
        isbGender              IN     ld_promissory.gender%TYPE,
        inuCivil_State_Id      IN     ld_promissory.civil_state_id%TYPE,
        idtBirthdayDate        IN     ld_promissory.birthdaydate%TYPE,
        inuSchool_Degree_      IN     ld_promissory.school_degree_%TYPE,
        inuAddress_Id          IN     ld_promissory.address_id%TYPE,
        isbPropertyPhone       IN     ld_promissory.propertyphone_id%TYPE,
        inuDependentsNumber    IN     ld_promissory.dependentsnumber%TYPE,
        inuHousingTypeId       IN     ld_promissory.housingtype%TYPE,
        inuHousingMonth        IN     ld_promissory.housingmonth%TYPE,
        isbHolderRelation      IN     ld_promissory.holderrelation%TYPE,
        isbOccupation          IN     ld_promissory.occupation%TYPE,
        isbCompanyName         IN     ld_promissory.companyname%TYPE,
        inuCompanyAddress_Id   IN     ld_promissory.companyaddress_id%TYPE,
        isbPhone1              IN     ld_promissory.phone1_id%TYPE,
        isbPhone2              IN     ld_promissory.phone2_id%TYPE,
        isbMovilPhone          IN     ld_promissory.movilphone_id%TYPE,
        inuOldLabor            IN     ld_promissory.oldlabor%TYPE,
        inuActivityId          IN     ld_promissory.activity%TYPE,
        inuMonthlyIncome       IN     ld_promissory.monthlyincome%TYPE,
        inuExpensesIncome      IN     ld_promissory.expensesincome%TYPE,
        isbFamiliarReference   IN     ld_promissory.familiarreference%TYPE,
        isbPhoneFamiRefe       IN     ld_promissory.phonefamirefe%TYPE,
        inuMovilPhoFamiRefe    IN     ld_promissory.movilphofamirefe%TYPE,
        inuaddressfamirefe     IN     ld_promissory.addresspersrefe%TYPE,
        isbPersonalReference   IN     ld_promissory.personalreference%TYPE,
        isbPhonePersRefe       IN     ld_promissory.phonepersrefe%TYPE,
        isbMovilPhoPersRefe    IN     ld_promissory.movilphopersrefe%TYPE,
        inuaddresspersrefe     IN     ld_promissory.addresspersrefe%TYPE,
        isbcommerreference     IN     ld_promissory.commerreference%TYPE,
        isbphonecommrefe       IN     ld_promissory.phonecommrefe%TYPE,
        isbmovilphocommrefe    IN     ld_promissory.movilphocommrefe%TYPE,
        inuaddresscommrefe     IN     ld_promissory.addresscommrefe%TYPE,
        isbEmail               IN     ld_promissory.email%TYPE,
        inuPackage_Id          IN     ld_promissory.package_id%TYPE,
        inuCategoryId          IN     ld_promissory.category_id%TYPE,
        inuSubcategoryId       IN     ld_promissory.subcategory_id%TYPE,
        inuContractType        IN     ld_promissory.contract_type_id%TYPE,
        isblastname            IN     ld_promissory.last_name%TYPE,
        onuPromissory_id          OUT ld_promissory.promissory_id%TYPE,
        onuErrorCode              OUT NUMBER,
        osbErrorMessage           OUT VARCHAR2)
    AS
        /***************************************************************
            PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

                    PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.proRegisDeuFNB
                    AUTOR   : Sincecomp/Karem Baquero
                    FECHA   : 28/05/2014
                    RICEF   : l071
              DESCRIPCION   : registro de la informacion del deudor.
            Parametros de Salida

            Historia de Modificaciones

            Autor        Fecha       Descripcion.
            Karbaq      28/05/2014   Creacion del proceso
            Karbaq      05/12/2014   Se le coloca por defecto unas variables para que se pueda registrar
                                     la venta desde Smartflex, luego de una WEB.
           Karbaq       01/07/2015   Se modifica para que cuando sea un inquilido se le coloque el nombre que
                                     viene por parametro.
        **************************************************************************/

        rcSubsGenData     DAGE_Subs_General_Data.styGE_Subs_General_Data;
        rcLd_Promissory   dald_promissory.styld_promissory;
        sbDebtorName      Ld_Promissory.debtorname%TYPE;
        sblastname        Ld_Promissory.Last_Name%TYPE;
    BEGIN
        rcLd_Promissory.promissory_id :=
            GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE ('LD_PROMISSORY',
                                                 'SEQ_LD_PROMISSORY');

        onuPromissory_id := rcLd_Promissory.promissory_id;
        pkg_Traza.Trace (
               'INICIO LDCI_PKCRMFINBRILLAPORTAL.proRegisDeuFNB['
            || inuPromissory_id
            || ']',
            10);
        rcLd_Promissory.holder_bill := isbHolder_Bill;

        /*Se valida si es titular de la factura entonces se busca el nombre del cliente*/
        IF isbHolder_Bill = ld_boconstans.csbYesFlag
        THEN
            /*se busca el dato del nombre del cliente para insertarlo completo en historico
            de deudores*/
            sbDebtorName :=
                dage_subscriber.fsbgetsubscriber_name (inuSubscriberId);
            sblastname :=
                dage_subscriber.fsbgetsubs_last_name (inuSubscriberId);
        /*Se valida si no es titular de la factura entonces se coloca el que viene x parametro*/
        ELSIF isbHolder_Bill = ld_boconstans.csbNOFlag
        THEN
            sbDebtorName := isbDebtorName;
            sblastname := isblastname; --dage_subscriber.fsbgetsubs_last_name(inuSubscriberId);
        END IF;

        rcLd_Promissory.debtorname := sbDebtorName;           --isbDebtorName;
        rcLd_Promissory.identification := isbIdentification;
        rcLd_Promissory.ident_type_id := inuIdentType;
        rcLd_Promissory.forwardingplace := inuForwardingPlace;
        rcLd_Promissory.forwardingdate := idtForwardingDate;
        rcLd_Promissory.gender := isbGender;
        rcLd_Promissory.civil_state_id := inuCivil_State_Id;
        rcLd_Promissory.birthdaydate := idtBirthdayDate;
        rcLd_Promissory.school_degree_ := inuSchool_Degree_;
        rcLd_Promissory.address_id := inuAddress_Id;
        rcLd_Promissory.propertyphone_id := isbPropertyPhone;

        IF inuDependentsNumber IS NULL
        THEN
            rcLd_Promissory.dependentsnumber := 0;
        ELSE
            rcLd_Promissory.dependentsnumber := inuDependentsNumber;
        END IF;

        rcLd_Promissory.housingtype := inuHousingTypeId;
        rcLd_Promissory.housingmonth := inuHousingMonth;

        IF isbHolderRelation IS NULL
        THEN
            rcLd_Promissory.holderrelation := 7;
        ELSE
            rcLd_Promissory.holderrelation := isbHolderRelation;
        END IF;

        rcLd_Promissory.occupation := isbOccupation;
        rcLd_Promissory.companyname := isbCompanyName;
        rcLd_Promissory.companyaddress_id := inuCompanyAddress_Id;
        rcLd_Promissory.phone1_id := isbPhone1;
        rcLd_Promissory.phone2_id := isbPhone2;
        rcLd_Promissory.movilphone_id := isbMovilPhone;
        rcLd_Promissory.oldlabor := inuOldLabor;
        rcLd_Promissory.activity := inuActivityId;

        IF inuMonthlyIncome IS NULL
        THEN
            rcLd_Promissory.monthlyincome := 1;
        ELSE
            rcLd_Promissory.monthlyincome := inuMonthlyIncome;
        END IF;

        IF inuExpensesIncome IS NULL
        THEN
            rcLd_Promissory.expensesincome := 1;
        ELSE
            rcLd_Promissory.expensesincome := inuExpensesIncome;
        END IF;

        rcLd_Promissory.familiarreference := isbFamiliarReference;
        rcLd_Promissory.phonefamirefe := isbPhoneFamiRefe;
        rcLd_Promissory.movilphofamirefe := inuMovilPhoFamiRefe;
        rcld_promissory.addressfamirefe := inuaddressfamirefe;
        rcld_promissory.category_id := inuCategoryId;
        rcld_promissory.subcategory_id := inuSubcategoryId;
        rcld_promissory.contract_type_id := inuContractType;

        rcLd_Promissory.personalreference := isbPersonalReference;
        rcLd_Promissory.phonepersrefe := isbPhonePersRefe;
        rcLd_Promissory.movilphopersrefe := isbMovilPhoPersRefe;
        rcld_promissory.addresspersrefe := inuaddresspersrefe;

        IF (isbcommerreference IS NOT NULL)
        THEN
            rcld_promissory.commerreference := isbcommerreference;
            rcld_promissory.phonecommrefe := isbphonecommrefe;
            rcld_promissory.movilphocommrefe := isbmovilphocommrefe;
            rcld_promissory.addresscommrefe := inuaddresscommrefe;
        END IF;

        rcLd_Promissory.email := isbEmail;
        rcLd_Promissory.package_id := inuPackage_Id;
        rcLd_Promissory.promissory_type := ld_boconstans.csbDEUDORPROTYPE;

        --sblastname := dage_subscriber.fsbgetsubs_last_name(inuSubscriberId);

        rcLd_Promissory.last_name := sblastname;
        rcLd_Promissory.SOLIDARITY_DEBTOR := 'N';
        rcLd_Promissory.causal_id := -1;

        /*guarda en la tabla*/
        dald_promissory.insRecord (ircLd_Promissory => rcLd_Promissory);

        --  Si es el titular de la factura
        IF (isbHolder_Bill = GE_BOConstants.csbYES)
        THEN
            --  Si existe informacion general del cliente
            IF (DAGE_Subs_General_Data.fblExist (inuSubscriberId))
            THEN
                --  Si no tiene genero
                IF (DAGE_Subs_General_Data.fsbGetGender (inuSubscriberId)
                        IS NULL)
                THEN
                    --  Actualiza el genero
                    DAGE_Subs_General_Data.updGender (inuSubscriberId,
                                                      isbGender);
                END IF;
            ELSE
                --  Crea el registro de la informacion general
                rcSubsGenData.subscriber_id := inuSubscriberId;
                rcSubsGenData.gender := isbGender;

                DAGE_Subs_General_Data.insRecord (rcSubsGenData);
            END IF;
        END IF;

        onuErrorCode := 0;
        osbErrorMessage := '';

        pkg_Traza.Trace (
               'FIN LDCI_PKCRMFINBRILLAPORTAL.proRegisDeuFNB['
            || inuPromissory_id
            || ']',
            10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            Errors.getError (onuErrorCode, osbErrorMessage);
        WHEN OTHERS
        THEN
            errors.geterror (onuErrorCode, osbErrorMessage);
    END proRegisDeuFNB;

    ----------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------
    PROCEDURE proRegisCoDeuFNB (
        inuPromissory_id       IN     ld_promissory.promissory_id%TYPE,
        isbHolder_Bill         IN     ld_promissory.holder_bill%TYPE,
        isbDebtorName          IN     ld_promissory.debtorname%TYPE,
        inuIdentType           IN     ld_promissory.ident_type_id%TYPE,
        isbIdentification      IN     ld_promissory.identification%TYPE,
        inuForwardingPlace     IN     ld_promissory.forwardingplace%TYPE,
        idtForwardingDate      IN     ld_promissory.forwardingdate%TYPE,
        isbGender              IN     ld_promissory.gender%TYPE,
        inuCivil_State_Id      IN     ld_promissory.civil_state_id%TYPE,
        idtBirthdayDate        IN     ld_promissory.birthdaydate%TYPE,
        inuSchool_Degree_      IN     ld_promissory.school_degree_%TYPE,
        inuAddress_Id          IN     ld_promissory.address_id%TYPE,
        isbPropertyPhone       IN     ld_promissory.propertyphone_id%TYPE,
        inuDependentsNumber    IN     ld_promissory.dependentsnumber%TYPE,
        inuHousingTypeId       IN     ld_promissory.housingtype%TYPE,
        inuHousingMonth        IN     ld_promissory.housingmonth%TYPE,
        isbHolderRelation      IN     ld_promissory.holderrelation%TYPE,
        isbOccupation          IN     ld_promissory.occupation%TYPE,
        isbCompanyName         IN     ld_promissory.companyname%TYPE,
        inuCompanyAddress_Id   IN     ld_promissory.companyaddress_id%TYPE,
        isbPhone1              IN     ld_promissory.phone1_id%TYPE,
        isbPhone2              IN     ld_promissory.phone2_id%TYPE,
        isbMovilPhone          IN     ld_promissory.movilphone_id%TYPE,
        inuOldLabor            IN     ld_promissory.oldlabor%TYPE,
        inuActivityId          IN     ld_promissory.activity%TYPE,
        inuMonthlyIncome       IN     ld_promissory.monthlyincome%TYPE,
        inuExpensesIncome      IN     ld_promissory.expensesincome%TYPE,
        isbFamiliarReference   IN     ld_promissory.familiarreference%TYPE,
        isbPhoneFamiRefe       IN     ld_promissory.phonefamirefe%TYPE,
        inuMovilPhoFamiRefe    IN     ld_promissory.movilphofamirefe%TYPE,
        inuaddressfamirefe     IN     ld_promissory.addresspersrefe%TYPE,
        isbPersonalReference   IN     ld_promissory.personalreference%TYPE,
        isbPhonePersRefe       IN     ld_promissory.phonepersrefe%TYPE,
        isbMovilPhoPersRefe    IN     ld_promissory.movilphopersrefe%TYPE,
        inuaddresspersrefe     IN     ld_promissory.addresspersrefe%TYPE,
        isbcommerreference     IN     ld_promissory.commerreference%TYPE,
        isbphonecommrefe       IN     ld_promissory.phonecommrefe%TYPE,
        isbmovilphocommrefe    IN     ld_promissory.movilphocommrefe%TYPE,
        inuaddresscommrefe     IN     ld_promissory.addresscommrefe%TYPE,
        isbEmail               IN     ld_promissory.email%TYPE,
        inuPackage_Id          IN     ld_promissory.package_id%TYPE,
        inuCategoryId          IN     ld_promissory.category_id%TYPE,
        inuSubcategoryId       IN     ld_promissory.subcategory_id%TYPE,
        inuContractType        IN     ld_promissory.contract_type_id%TYPE,
        isblastname            IN     ld_promissory.last_name%TYPE,
        onuErrorCode              OUT NUMBER,
        osbErrorMessage           OUT VARCHAR2)
    AS
        sbDeudorSolidario       ld_promissory.solidarity_debtor%TYPE;
        nuCausalId              ld_promissory.causal_id%TYPE;
        /***************************************************************
            PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

                    PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.proRegisCoDeuFNB
                    AUTOR   : Sincecomp/Karem Baquero
                    FECHA   : 28/05/2014
                    RICEF   : l071
              DESCRIPCION   : registro de la informacion del deudor.
            Parametros de Salida

            Historia de Modificaciones

            Autor        Fecha       Descripcion
            Karbaq       17/12/2014  se modifica para actualizar la tabla de ldc_codeudores para
                                     realizar las validaciones del codeudor del req 1218 desde
                                     el portal web de brilla. Adem?s se agrega una consulta con
                                     la que se obtiene la informaci?n del deudor.
            Llozada     08-10-2014   Se envia por Defecto N al campo Deudor Solidario
            Karbaq      28/05/2014   Creacion del proceso
        **************************************************************************/

        INUIDENTCODEUDOR        ld_promissory.identification%TYPE;
        INUIDENTTYPEDEUDOR      ld_promissory.ident_type_id%TYPE;
        INUIDENDEUDOR           ld_promissory.identification%TYPE;
        ISBFLAGDEUDORSOL        ldc_codeudor.codeudor_solidario%TYPE := 'N'; --Flag que indica si es deudor solidario
        INUIDENTTYPECODEUDOR    ld_promissory.ident_type_id%TYPE;
        inuPromissory_idDeu     ld_promissory.promissory_id%TYPE;
        inuPromissory_idcoDeu   ld_promissory.promissory_id%TYPE;
    BEGIN
        /*pkg_Traza.Trace('INICIO LDCI_PKCRMFINBRILLAPORTAL.proRegisCoDeuFNB[' ||
        inuPromissory_id || ']',
        10);  */
        sbDeudorSolidario := 'N';
        nuCausalId := -1;

        /*Imprime la informacion del cursor*/
        --08-10-2014 Llozada [RQ 1218]: Se envia por Defecto N al campo Deudor Solidario /*inuSubscriberId      ,*/
        /*se consulta la informaci?n del deudor teniendo en cuenta la solicitud de venta ingresada*/
        BEGIN
            SELECT o.promissory_id
              INTO inuPromissory_idDeu
              FROM ld_promissory o
             WHERE     o.package_id = inuPackage_Id
                   AND o.promissory_type = 'D'
                   AND ROWNUM = 1;
        EXCEPTION
            WHEN OTHERS
            THEN
                osbErrorMessage :=
                       'Error Consultando la informaci?n del deudor de la venta: '
                    || inuPackage_Id
                    || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
                onuErrorCode := -1;
                Errors.getError (onuErrorCode, osbErrorMessage);
        END;

        /**/

        LD_BONONBANKFINANCING.RegisterCosignerData (inuPromissory_id,
                                                    isbHolder_Bill,
                                                    isbDebtorName,
                                                    inuIdentType,
                                                    isbIdentification,
                                                    inuForwardingPlace,
                                                    idtForwardingDate,
                                                    isbGender,
                                                    inuCivil_State_Id,
                                                    idtBirthdayDate,
                                                    inuSchool_Degree_,
                                                    inuAddress_Id,
                                                    isbPropertyPhone,
                                                    inuDependentsNumber,
                                                    inuHousingTypeId,
                                                    inuHousingMonth,
                                                    isbHolderRelation,
                                                    isbOccupation,
                                                    isbCompanyName,
                                                    inuCompanyAddress_Id,
                                                    isbPhone1,
                                                    isbPhone2,
                                                    isbMovilPhone,
                                                    inuOldLabor,
                                                    inuActivityId,
                                                    inuMonthlyIncome,
                                                    inuExpensesIncome,
                                                    isbFamiliarReference,
                                                    isbPhoneFamiRefe,
                                                    inuMovilPhoFamiRefe,
                                                    inuaddressfamirefe,
                                                    isbPersonalReference,
                                                    isbPhonePersRefe,
                                                    isbMovilPhoPersRefe,
                                                    inuaddresspersrefe,
                                                    isbcommerreference,
                                                    isbphonecommrefe,
                                                    isbmovilphocommrefe,
                                                    inuaddresscommrefe,
                                                    isbEmail,
                                                    inuPackage_Id,
                                                    inuCategoryId,
                                                    inuSubcategoryId,
                                                    inuContractType,
                                                    isblastname,
                                                    sbDeudorSolidario,
                                                    nuCausalId);

        -- if inuPromissory_id is not null then
        /*Informaci?n de codeudor*/
        --  INUIDENTTYPECODEUDOR := dald_promissory.fnuGetIDENT_TYPE_ID(inuPromissory_id);
        --INUIDENTCODEUDOR     := dald_promissory.fsbGetIDENTIFICATION(inuPromissory_id);
        /*Informaci?n de deudor*/
        INUIDENTTYPEDEUDOR :=
            dald_promissory.fnuGetIDENT_TYPE_ID (inuPromissory_idDeu);
        INUIDENDEUDOR :=
            dald_promissory.fsbGetIDENTIFICATION (inuPromissory_idDeu);

        -- dald_promissory.updPackage_Id(inuPromissory_idcod, onuPackage_Id);

        ldc_codeudores.RegisterCosignerData (inuIdentType,
                                             isbIdentification,
                                             ISBFLAGDEUDORSOL,
                                             inuPackage_Id,
                                             INUIDENTTYPEDEUDOR,
                                             INUIDENDEUDOR);
        -- end if;

        onuErrorCode := 0;
        osbErrorMessage := '';

        pkg_Traza.Trace (
               'FIN LDCI_PKCRMFINBRILLAPORTAL.proRegisCoDeuFNB['
            || inuPromissory_id
            || ']',
            10);
    EXCEPTION
        WHEN OTHERS
        THEN
            errors.geterror (onuErrorCode, osbErrorMessage);
    END proRegisCoDeuFNB;

    ----------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------
    PROCEDURE proValconsignerFNB (
        inuSupplierId       IN     ld_extra_quota.supplier_id%TYPE,
        isbIdentification   IN     ld_promissory.identification%TYPE,
        inuIdent_Type_Id    IN     ge_subscriber.Ident_Type_Id%TYPE,
        inususcdeud         IN     suscripc.susccodi%TYPE, --contrato del deudor
        inususccodeud       IN     suscripc.susccodi%TYPE, --contrato del codeudor
        isbholder_bill      IN     ld_promissory.holder_bill%TYPE, --identifica si el deudor es titular o no
        OblResult              OUT VARCHAR2,
        onuErrorCode           OUT NUMBER,
        osbErrorMessage        OUT VARCHAR2)
    AS
        /***************************************************************
            PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

                    PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.proConsLineaFNB
                    AUTOR   : Karem Baquero
                    FECHA   : 23/05/2014
                    RICEF   : l069
              DESCRIPCION   : Validaciones realizadas a el codeudor
            Parametros de Salida

            Historia de Modificaciones

            Autor        Fecha       Descripcion.
            sampac       14/03/2016  caso 100-9793 se adiciona parametro de entrada que identifica
                                     si el deudor es titular de la factura o no.
            Karbaq      16/12/2014   Se modifica para agregar la validaci?n que se realizaron de
                                     codeudor para el requerimiento 1218.
            Karbaq      23/05/2014   Creacion del proceso

        **************************************************************************/
        blResult                 BOOLEAN;
        oblResultDE              BOOLEAN;
        OblResultdeu             VARCHAR2 (1000);

        inuIdent_Type            ge_subscriber.ident_type_id%TYPE;
        isbIdentificatio         ge_subscriber.identification%TYPE; --identificaci?n del deudor

        inusubsdeud              ge_subscriber.subscriber_id%TYPE; --cliente deudor
        inuIdent_Type_Iddeud     ge_subscriber.ident_type_id%TYPE; --tipo de identificaci?n del deudor
        isbIdentificationdeu     ge_subscriber.identification%TYPE; --identificaci?n del deudor

        inusubscodeud            ge_subscriber.subscriber_id%TYPE; --cliente codeudor
        inuIdent_Type_Idcodeud   ge_subscriber.ident_type_id%TYPE; --tipo de identificaci?n del codeudor
        isbIdentificationcodeu   ge_subscriber.identification%TYPE; --identificaci?n del codeudor
    BEGIN
        pkg_Traza.Trace (
               'INICIO LDCI_PKCRMFINBRILLAPORTAL.proValconsignerFNB['
            || inuSupplierId
            || ']',
            10);

        inuIdent_Type := inuIdent_Type_Id; -- asignaci?n de los parametros de entrada
        isbIdentificatio := isbIdentification; -- asignaci?n de los parametros de entrada

        /*busqueda de la informaci?n del contrato deudor*/
        inusubsdeud := pktblsuscripc.fnugetsuscclie (inususcdeud);
        inuIdent_Type_Iddeud :=
            dage_subscriber.fnugetident_type_id (inusubsdeud);
        isbIdentificationdeu :=
            dage_subscriber.fsbgetidentification (inusubsdeud);

        IF     isbIdentification IS NULL
           AND inuIdent_Type_Id IS NULL
           AND inususccodeud IS NULL
        THEN
            ge_boerrors.seterrorcodeargument (
                ld_boconstans.cnuGeneric_Error,
                'Se debe ingresar el contrato o la identificacion');
        ELSE
            /*busqueda de la informaci?n del contrato codeudor*/
            IF inususccodeud IS NOT NULL
            THEN
                inusubscodeud := pktblsuscripc.fnugetsuscclie (inususccodeud);
                inuIdent_Type_Idcodeud :=
                    dage_subscriber.fnugetident_type_id (inusubscodeud);
                isbIdentificationcodeu :=
                    dage_subscriber.fsbgetidentification (inusubscodeud);

                isbIdentificatio := isbIdentificationcodeu;
                inuIdent_Type := inuIdent_Type_Idcodeud;
            END IF;

            Ld_bononbankfinancing.validateCosigner (inuSupplierId,
                                                    isbIdentificatio,
                                                    inuIdent_Type,
                                                    blResult);

            IF NOT blResult
            THEN
                OblResult := 'FALSE';
            ELSE
                OblResult := 'TRUE';
            END IF;

            ldc_codeudores.blValidateCodeudor (isbIdentification,
                                               inuIdent_Type_Id,
                                               isbIdentificationdeu,
                                               inuIdent_Type_Iddeud,
                                               'N',
                                               oblResultDE);

            IF NOT oblResultDE
            THEN
                -- OblResultdeu := 'FALSE';
                OblResult := 'FALSE';
            ELSE
                --      OblResultdeu := 'TRUE';
                OblResult := 'TRUE';
            END IF;

            onuErrorCode := 0;
            osbErrorMessage := '';
        END IF;

        pkg_Traza.Trace (
               'FIN LDCI_PKCRMFINBRILLAPORTAL.proValconsignerFNB['
            || inuSupplierId
            || ']',
            10);
    EXCEPTION
        WHEN OTHERS
        THEN
            errors.geterror (onuErrorCode, osbErrorMessage);
    END proValconsignerFNB;

    ----------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------
    PROCEDURE proConImpPagareFNB (
        nuPackageId                IN     ld_promissory.package_id%TYPE,
        sbPromissoryTypeDebtor     IN     ld_promissory.promissory_type%TYPE,
        sbPromissoryTypeCosigner   IN     ld_promissory.promissory_type%TYPE,
        orfCursor                     OUT Constants.tyRefCursor,
        onuErrorCode                  OUT NUMBER,
        osbErrorMessage               OUT VARCHAR2)
    AS
        /***************************************************************
            PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

                    PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.proConImpPagareFNB
                    AUTOR   : Karem Baquero
                    FECHA   : 27/05/2014
                    RICEF   : l070
              DESCRIPCION   : Consulta de la informacion para la impresion
                              del pagare.
            Parametros de Salida

            Historia de Modificaciones

            Autor        Fecha       Descripcion.
            Karbaq      27/05/2014   Creacion del proceso

        **************************************************************************/
        MaxQuotaNumber   NUMBER;
        InterestPct      NUMBER;
    BEGIN
        pkg_Traza.Trace (
               'INICIO LDCI_PKCRMFINBRILLAPORTAL.proConImpPagareFNB['
            || nuPackageId
            || ']',
            10);

        /*Imprime la informacion del cursor*/
        /* orfCursor := LD_BCPortafolio.FtrfPromissory(nuPackageId,
        sbPromissoryTypeDebtor,
        sbPromissoryTypeCosigner);*/
        SELECT MAX (quotas_number)
          INTO MaxQuotaNumber
          FROM ld_non_ban_fi_item
         WHERE non_ba_fi_requ_id = nuPackageId;

        SELECT MAX (
                   ld_bcnonbankfinancing.fnuGetInterestPct (
                       plditain,
                       dald_non_ba_fi_requ.fdtGetSale_Date (nuPackageId)))
          INTO InterestPct
          FROM ld_non_ban_fi_item, plandife
         WHERE finan_plan_id = pldicodi AND non_ba_fi_requ_id = nuPackageId;

        OPEN orfCursor FOR
            SELECT /*+
                         use_nl(ld_non_ban_fi_item)
                         index(ld_non_ban_fi_item ix_ld_non_ban_fi_item02)
                         leading(ld_non_ban_fi_item)
                         */
                   a.Article_Id,
                   a.reference,
                   a.description,
                   deu.*,
                   cod.*,
                   (ADD_MONTHS (request_date, MaxQuotaNumber))
                       loan_fin_date,
                   InterestPct
                       rem_interest,
                   /* a.article_id,
                          reference,
                          description,*/
                   amount,
                   /*       (select round(l.value_total) from ld_non_ba_fi_requ l where l.non_ba_fi_requ_id=nuPackageId)*/
                    (SELECT SUM (
                                  NVL (t.unit_value, 0) * t.amount
                                + NVL (t.vat, 0) * t.amount)
                       FROM LD_NON_BAN_FI_ITEM t
                      WHERE t.non_ba_fi_requ_id = nuPackageId)
                       unit_value,
                   MaxQuotaNumber
                       quotas_number,
                   --EVESAN 18/Julio/2013
                   TRIM (
                       TO_CHAR (
                           dald_non_ba_fi_requ.fnuGetQuota_Aprox_Month (
                               ld_non_ban_fi_item.non_ba_fi_requ_id,
                               0),
                           '$999G999G999G999G999'))
                       "CUOTA_MENSUAL_APROX",
                   TRIM (
                       TO_CHAR (
                           dald_aditional_fnb_info.fnuGetAPROX_MONTH_INSURANCE (
                               ld_non_ban_fi_item.non_ba_fi_requ_id,
                               0),
                           '$999G999G999G999G999'))
                       "VALOR_SEGURO",
                   (SELECT comment_
                      FROM mo_packages
                     WHERE package_id = nuPackageId)
                       Observacion
              FROM (SELECT /*+ use_nl(ld_promissory)
                                            index(ld_promissory IDX_LD_PROMISSORY02)
                                            leading(ld_promissory)
                                         */
                           promissory_id,
                           holder_bill,
                           debtorname || ' ' || last_name
                               debtorname,
                           identification,
                           DAge_geogra_location.fsbGetDescription (
                               forwardingplace)
                               forwardingplace,
                           --trunc(forwardingdate) forwardingdate,
                           TO_CHAR (forwardingdate, 'DD/MM/YYYY')
                               forwardingdate,
                           gender,
                           DAge_civil_state.fsbGetDescription (
                               civil_state_id)
                               civil_state_id,
                           TO_CHAR (birthdaydate, 'DD/MM/YYYY')
                               birthdaydate,
                           DAge_school_degree.fsbGetDescription (
                               school_degree_)
                               school_degree_,
                           (SELECT address_parsed
                              FROM ab_address
                             WHERE ab_address.address_id =
                                   ld_promissory.address_id)
                               address_id,
                           (SELECT ge_geogra_location.description
                              FROM ab_address, ge_geogra_location
                             WHERE     ab_address.neighborthood_id =
                                       ge_geogra_location.geograp_location_id
                                   AND ab_address.address_id =
                                       ld_promissory.address_id)
                               NEIGHBORTHOOD_ID,
                           (SELECT ge_geogra_location.description
                              FROM ab_address, ge_geogra_location
                             WHERE     ab_address.address_id =
                                       ld_promissory.address_id
                                   AND ab_address.geograp_location_id =
                                       ge_geogra_location.geograp_location_id)
                               CITY,
                           (SELECT A.DESCRIPTION
                              FROM GE_GEOGRA_LOCATION  A,
                                   GE_GEOGRA_LOCATION  B,
                                   AB_ADDRESS          C
                             WHERE     C.ADDRESS_ID =
                                       ld_promissory.address_id
                                   AND C.GEOGRAP_LOCATION_ID =
                                       B.GEOGRAP_LOCATION_ID
                                   AND A.GEOGRAP_LOCATION_ID =
                                       B.GEO_LOCA_FATHER_ID)
                               department,
                           propertyphone_id,
                           dependentsnumber
                               "DEU_PERSONAS_CARGO",
                           DAGE_HOUSE_TYPE.fsbGetDescription (housingtype)
                               housingtype,
                           housingmonth,
                           holderrelation,
                           (SELECT description
                              FROM ge_profession
                             WHERE profession_id = TO_NUMBER (occupation))
                               occupation,
                           companyname,
                           (SELECT address
                              FROM ab_address
                             WHERE ab_address.address_id =
                                   ld_promissory.companyaddress_id)
                               companyaddress_id,
                           phone1_id,
                           phone2_id,
                           movilphone_id,
                           oldlabor,
                           activity,
                           monthlyincome,
                           expensesincome,
                           commerreference,
                           phonecommrefe,
                           movilphocommrefe,
                           daab_address.fsbgetaddress_parsed (
                               addresscommrefe,
                               0)
                               addresscommrefe,
                           familiarreference,
                           phonefamirefe,
                           movilphofamirefe,
                           daab_address.fsbgetaddress_parsed (
                               addressfamirefe,
                               0)
                               addressfamirefe,
                           personalreference,
                           phonepersrefe,
                           movilphopersrefe,
                           addresspersrefe,
                           email,
                           package_id,
                           promissory_type,
                           --santiman_START
                            (SELECT mo_packages.subscription_pend_id
                               FROM mo_packages
                              WHERE mo_packages.package_id = nuPackageId)
                               Subscription_id,
                           (SELECT ld_bcnonbankfinancing.fnuGetInterestPct (
                                       pktblparametr.fnugetvaluenumber (
                                           'BIL_TASA_USURA'),
                                       dald_non_ba_fi_requ.fdtGetSale_Date (
                                           nuPackageId))
                              FROM DUAL)
                               max_interest,
                           (SELECT value_total
                              FROM ld_non_ba_fi_requ
                             WHERE non_ba_fi_requ_id = nuPackageId)
                               tot_sale_value,
                           --santiman_END
                            (SELECT digital_prom_note_cons
                               FROM ld_non_ba_fi_requ t
                              WHERE non_ba_fi_requ_id = nuPackageId)
                               digital_prom_note_cons,
                           (SELECT TRUNC (request_date)
                              FROM mo_packages
                             WHERE package_id = nuPackageId)
                               request_date,
                           (SELECT   TRUNC (request_date)
                                   + pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                         'DAYS_AVAILABLE_PAGARE')
                              FROM mo_packages
                             WHERE package_id = nuPackageId)
                               effective_date,
                           (SELECT person_id
                              FROM mo_packages
                             WHERE package_id = nuPackageId)
                               person_id,
                           (SELECT payment
                              FROM ld_non_ba_fi_requ
                             WHERE non_ba_fi_requ_id = nuPackageId)
                               payment,
                           (SELECT subscriber_name || ' ' || subs_last_name
                              FROM ge_subscriber
                             WHERE subscriber_id IN
                                       (SELECT mo_packages.subscriber_id
                                          FROM mo_packages
                                         WHERE mo_packages.package_id =
                                               nuPackageId))
                               subscriber_name,
                           contract_type_id,
                           (SELECT catedesc
                              FROM categori
                             WHERE catecodi = category_id)
                               categoria,
                           (SELECT sucadesc
                              FROM subcateg
                             WHERE     sucacate = category_id
                                   AND sucacodi = subcategory_id)
                               subcategoria,
                           (SELECT description
                              FROM ge_identifica_type
                             WHERE ge_identifica_type.ident_type_id =
                                   ld_promissory.ident_type_id)
                               ident_type_id
                      FROM ld_promissory
                     WHERE     package_id = nuPackageId
                           AND promissory_type = sbPromissoryTypeDebtor) deu,
                   --FIN DEUDOR
                    (SELECT /*+ use_nl(ld_promissory)
                                                                                                                                                                                                                                                                                                                                                                          index(ld_promissory IDX_LD_PROMISSORY02)
                                                                                                                                                                                                                                                                                                                                                                          leading(ld_promissory)
                                                                                                                                                                                                                                                                                                                                                                       */
                            promissory_id
                                "CODE_PAGARE_ID",
                            holder_bill
                                "CODE_TITULAR_FACT",
                            debtorname || ' ' || last_name
                                "CODE_NOMBRE",
                            identification
                                "CODE_IDENTIFICATION",
                            DAge_geogra_location.fsbGetDescription (
                                forwardingplace)
                                "CODE_LUGAR_EXPEDICION",
                            TO_CHAR (forwardingdate, 'DD/MM/YYYY')
                                "CODE_FECHA_EXPEDICION",
                            gender
                                "CODE_GENERO",
                            DAge_civil_state.fsbGetDescription (
                                civil_state_id)
                                "CODE_ESTADO_CIVIL",
                            TO_CHAR (birthdaydate, 'DD/MM/YYYY')
                                "CODE_FEC_NAC",
                            DAge_school_degree.fsbGetDescription (
                                school_degree_)
                                "CODE_NIVEL_ESTUDIO",
                            (SELECT address_parsed
                               FROM ab_address
                              WHERE ab_address.address_id =
                                    ld_promissory.address_id)
                                "CODE_DIRECCION",
                            (SELECT ge_geogra_location.description
                               FROM ab_address, ge_geogra_location
                              WHERE     ab_address.address_id =
                                        ld_promissory.address_id
                                    AND ab_address.neighborthood_id =
                                        ge_geogra_location.geograp_location_id)
                                "CODE_BARRIO",             --neighborthood_id,
                            (SELECT ge_geogra_location.description
                               FROM ab_address, ge_geogra_location
                              WHERE     ab_address.address_id =
                                        ld_promissory.address_id
                                    AND ab_address.geograp_location_id =
                                        ge_geogra_location.geograp_location_id)
                                "CODE_CIUDAD",                         --city,
                            (SELECT A.DESCRIPTION
                               FROM GE_GEOGRA_LOCATION  A,
                                    GE_GEOGRA_LOCATION  B,
                                    AB_ADDRESS          C
                              WHERE     C.ADDRESS_ID =
                                        ld_promissory.address_id
                                    AND C.GEOGRAP_LOCATION_ID =
                                        B.GEOGRAP_LOCATION_ID
                                    AND A.GEOGRAP_LOCATION_ID =
                                        B.GEO_LOCA_FATHER_ID)
                                "CODE_DEPARTAMENTO",
                            propertyphone_id
                                "CODE_TELEFONO",
                            dependentsnumber
                                "CODE_PERSONAS_CARGO",
                            DAGE_HOUSE_TYPE.fsbGetDescription (housingtype)
                                "CODE_TIPO_VIVI",               --housingtype,
                            housingmonth
                                "CODE_ANTIGUEDAD",
                            holderrelation
                                "CODE_RELAC_TITU",
                            (SELECT description
                               FROM ge_profession
                              WHERE profession_id = TO_NUMBER (occupation))
                                "CODE_OCUPACION",                --occupation,
                            companyname
                                "CODE_NOMBRE_EMPRESA",
                            (SELECT address
                               FROM ab_address
                              WHERE ab_address.address_id =
                                    ld_promissory.companyaddress_id)
                                "CODE_DIRECC_EMPRESA",    --companyaddress_id,
                            phone1_id
                                "CODE_TEL1",
                            phone2_id
                                "CODE_TEL2",
                            movilphone_id
                                "CODE_CELULAR",
                            oldlabor
                                "CODE_TIPO_CONTRATO",
                            activity
                                "CODE_ACTI",
                            TRIM (
                                TO_CHAR (monthlyincome,
                                         '$999G999G999G999G999D99'))
                                "CODE_INGRESO_MENSUAL",
                            TRIM (
                                TO_CHAR (expensesincome,
                                         '$999G999G999G999G999D99'))
                                "C_EXPENSESINCOME",
                            commerreference
                                "C_COMMERREFERENCE",
                            phonecommrefe
                                "C_PHONECOMMREFE",
                            movilphocommrefe
                                "C_MOVILPHOCOMMREFE",
                            daab_address.fsbGetAddress (addresscommrefe, 0)
                                "C_ADDRESSCOMMREFE",
                            familiarreference
                                "C_FAMILIARREFERENCE",
                            phonefamirefe
                                "C_PHONEFAMIREFE",
                            movilphofamirefe
                                "C_MOVILPHOFAMIREFE",
                            daab_address.fsbGetAddress (addressfamirefe, 0)
                                "C_ADDRESSFAMIREFE",
                            personalreference
                                "C_PERSONALREFERENCE",
                            phonepersrefe
                                "C_PHONEPERSREFE",
                            movilphopersrefe
                                "C_MOVILPHOPERSREFE",
                            addresspersrefe
                                "C_ADDRESSPERSREFE",
                            email
                                "C_EMAIL",
                            package_id
                                "C_PACKAGE_ID",
                            promissory_type
                                "C_PROMISSORY_TYPE",
                            (SELECT digital_prom_note_cons
                               FROM ld_non_ba_fi_requ t
                              WHERE non_ba_fi_requ_id = nuPackageId)
                                "C_DIGITAL_PROM_NOTE_CONS",
                            (SELECT TRUNC (request_date)
                               FROM mo_packages
                              WHERE package_id = nuPackageId)
                                "C_REQUEST_DATE",
                            (SELECT   TRUNC (request_date)
                                    + pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                          'DAYS_AVAILABLE_PAGARE')
                               FROM mo_packages
                              WHERE package_id = nuPackageId)
                                "C_EFFECTIVE_DATE",
                            (SELECT person_id
                               FROM mo_packages
                              WHERE package_id = nuPackageId)
                                "C_PERSON_ID",
                            (SELECT payment
                               FROM ld_non_ba_fi_requ
                              WHERE non_ba_fi_requ_id = nuPackageId)
                                "C_PAYMENT",
                            (SELECT subscriber_name || ' ' || subs_last_name
                               FROM ge_subscriber
                              WHERE subscriber_id IN
                                        (SELECT mo_packages.subscriber_id
                                           FROM mo_packages
                                          WHERE mo_packages.package_id =
                                                nuPackageId))
                                "C_SUBSCRIBER_NAME",
                            contract_type_id
                                "C_contract_type_id",
                            (SELECT catedesc
                               FROM categori
                              WHERE catecodi = category_id)
                                "C_CATEGORIA",
                            (SELECT sucadesc
                               FROM subcateg
                              WHERE     sucacate = category_id
                                    AND sucacodi = subcategory_id)
                                "C_SUBCATEGORIA",
                            (SELECT description
                               FROM ge_identifica_type
                              WHERE ge_identifica_type.ident_type_id =
                                    ld_promissory.ident_type_id)
                                "C_IDENT_TYPE_ID"
                       FROM ld_promissory
                      WHERE     package_id = nuPackageId
                            AND promissory_type = sbPromissoryTypeCosigner)
                   cod,
                   --FIN CODEUDOR
                   ld_non_ban_fi_item,
                   ld_article  a
             /*+ Ubicacion: LD_BCPortafolio.FtrfPromissory */
             WHERE     ld_non_ban_fi_item.non_ba_fi_requ_id = nuPackageId
                   AND package_id = ld_non_ban_fi_item.non_ba_fi_requ_id
                   AND ld_non_ban_fi_item.article_id = a.article_id
                   AND PACKAGE_ID = "C_PACKAGE_ID"(+);

        DBMS_OUTPUT.PUT_LINE ('orfCursor%ISOPEN = false');

        onuErrorCode := 0;
        osbErrorMessage := '';

        pkg_Traza.Trace (
               'FIN LDCI_PKCRMFINBRILLAPORTAL.proConImpPagareFNB['
            || nuPackageId
            || ']',
            10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            ROLLBACK;
            Errors.geterror (onuErrorCode, osbErrorMessage);
        WHEN OTHERS
        THEN
            errors.geterror (onuErrorCode, osbErrorMessage);
    END proConImpPagareFNB;

    ---------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    PROCEDURE proConsprovLine (inuline           IN     ld_line.line_id%TYPE,
                               orfCursor            OUT Constants.tyRefCursor,
                               onuErrorCode      IN OUT NUMBER,
                               osbErrorMessage   IN OUT VARCHAR2)
    AS
    /***************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

             PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.proConsprovLine
             AUTOR   : Sincecomp/Karem Baquero
             FECHA   : 03/06/2014
             RICEF   : I073
       DESCRIPCION   : Proceso que realiza la consulta de proveedores por
                       linea.
     Parametros de Salida

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     KARBAQ      06/06/2014   Creacion del proceso

    **************************************************************************/

    BEGIN
        pkg_Traza.Trace ('LDCI_PKCRMFINBRILLAPORTAL.proConsLineprov', 15);

        OPEN orfCursor FOR
              SELECT DISTINCT
                     g.id_contratista, g.descripcion nombre_contratista
                FROM ge_contrato   c,
                     ge_contratista g,
                     ld_subline    l,
                     ld_article    a
               WHERE     l.line_id = DECODE (inuline, NULL, l.line_id, inuline)
                     AND g.status = 'DI'
                     AND a.active = 'Y'
                     AND a.avalible = 'Y'
                     AND a.approved = 'Y'
                     AND c.status = 'AB'
                     AND c.id_contratista = g.id_contratista
                     AND g.id_contratista = a.supplier_id
                     AND a.subline_id = l.subline_id
            ORDER BY nombre_contratista ASC;

        onuErrorCode := 0;
        osbErrorMessage := '';

        IF (orfCursor%ISOPEN = FALSE)
        THEN
            OPEN orfCursor FOR
                SELECT -1 id_contratista, -1 nombre_contratista
                  FROM DUAL
                 WHERE 1 = 1;

            DBMS_OUTPUT.PUT_LINE ('orfCursor%ISOPEN = false');
        END IF;                          -- IF (orfCursor%ISOPEN = false) then

        pkg_Traza.Trace ('LDCI_PKCRMFINBRILLAPORTAL.proConsLineprov', 15);
    EXCEPTION
        WHEN OTHERS
        THEN
            errors.geterror (onuErrorCode, osbErrorMessage);
    END proConsprovLine;

    ---------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    PROCEDURE proConsArtprovLine (
        inuline           IN     ld_line.line_id%TYPE,
        inuprov           IN     ld_article.supplier_id%TYPE,
        orfCursor            OUT Constants.tyRefCursor,
        onuErrorCode      IN OUT NUMBER,
        osbErrorMessage   IN OUT VARCHAR2)
    AS
    /***************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

             PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.proConsArtprovLine
             AUTOR   : Sincecomp/Karem Baquero
             FECHA   : 03/06/2014
             RICEF   : I076
       DESCRIPCION   : Proceso que realiza la consulta de articulos por proveedores por
                       linea.
     Parametros de Salida

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     KARBAQ      03/06/2014   Creacion del proceso

    **************************************************************************/

    BEGIN
        pkg_Traza.Trace ('LDCI_PKCRMFINBRILLAPORTAL.proConsLineprov', 15);

        OPEN orfCursor FOR
              SELECT DISTINCT a.article_id,
                              a.description,
                              a.vat         iva,
                              l.line_id     linea
                FROM ge_contratista g, ld_subline l, ld_article a
               WHERE     l.line_id = DECODE (inuline, NULL, l.line_id, inuline)
                     AND g.status = 'DI'
                     AND a.supplier_id =
                         DECODE (inuprov, NULL, a.supplier_id, inuprov) --inuprov --346
                     AND g.id_contratista = a.supplier_id
                     AND a.subline_id = l.subline_id
                     AND a.active = 'Y'
                     AND a.avalible = 'Y'
                     AND a.approved = 'Y'
            ORDER BY a.description ASC;

        onuErrorCode := 0;
        osbErrorMessage := '';

        IF (orfCursor%ISOPEN = FALSE)
        THEN
            OPEN orfCursor FOR SELECT -1 article_id, -1 description
                                 FROM DUAL
                                WHERE 1 = 1;

            DBMS_OUTPUT.PUT_LINE ('orfCursor%ISOPEN = false');
        END IF;                          -- IF (orfCursor%ISOPEN = false) then

        pkg_Traza.Trace ('LDCI_PKCRMFINBRILLAPORTAL.proConsLineprov', 15);
    EXCEPTION
        WHEN OTHERS
        THEN
            OPEN orfCursor FOR SELECT -1 article_id, -1 description
                                 FROM DUAL
                                WHERE 1 = 1;

            errors.geterror (onuErrorCode, osbErrorMessage);
    END proConsArtprovLine;

    ---------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    PROCEDURE proConsplanfiLineaFNB (
        inuline           IN     ld_line.line_id%TYPE,
        orfCursor            OUT Constants.tyRefCursor,
        onuErrorCode         OUT NUMBER,
        osbErrorMessage      OUT VARCHAR2)
    AS
    /***************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

             PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.proConsplanfiLineaFNB
             AUTOR   : Sincecomp/Karem Baquero
             FECHA   : 03/06/2014
             RICEF   : l077
       DESCRIPCION   : Se obtiene la informacion de las lineas
     Parametros de Salida

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     MAURICIOFO    29/01/2013  Creacion del paquete
     CARLOSVL      17/07/2013  Ajuste para el calculo de la tasa nominal mensual
     CARLOSVL      23/10/2013  #NC-1287 - CRM-INTEGRACIONES-PORTAL-BRILLA-LISTA DESPLEGABLE LINEAS
     Juanda        12/11/2013  Orden de Lineas de Financiacion
	 JSOTO		   30/11/2023  OSF-1816 Manejo y control de errores y trazas se reemplaza por personalizados.
    **************************************************************************/
	
	csbMT_NAME 	CONSTANT VARCHAR(70) := csbSP_NAME || '.proConsplanfiLineaFNB';		 


    BEGIN
	
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
        OPEN orfCursor FOR
              SELECT pf.LINE_ID                                           IDLINEA,
                     li.DESCRIPTION                                       LINEA,
                     pf.FINANCING_PLAN_ID                                 IDPLANFINAN,
                     pd.PLDIDESC                                          PLANFINAN,
                     pf.CATEGORY_ID                                       IDCATEGORIA,
                     ca.CATEDESC                                          CATEGORIA,
                     pd.PLDICUMI                                          CUOTAMIN,
                     pd.PLDICUMA                                          CUOTAMAX,
                     pd.PLDITAIN                                          IDTASAINTERES,
                     ct.COTIPORC                                          PORCENTAJE,
                     LDCI_PKCRMFINBRILLA.fnuGetTasaNominalMensual (ct.COTIPORC,
                                                                   12)    TASA_NNAL_MENSUAL
                FROM LD_FINAN_PLAN_FNB pf,
                     LD_LINE          li,
                     PLANDIFE         pd,
                     CONFTAIN         ct,
                     CATEGORI         ca
               WHERE     CURRENT_DATE BETWEEN pd.PLDIFEIN AND pd.PLDIFEFI
                     AND li.APPROVED = 'Y'
                     AND pf.LINE_ID = inuline
                     AND pf.LINE_ID = li.LINE_ID
                     AND pf.FINANCING_PLAN_ID = pd.PLDICODI
                     AND pf.CATEGORY_ID = ca.CATECODI
                     AND pd.PLDITAIN = ct.COTITAIN
                     AND pf.SUBCATEGORY_ID IS NULL /*NC-1287 ajuste LISTA DESPLEGABLE LINEAS*/
                     AND pf.SUBLINE_ID IS NULL /*NC-1287 ajuste LISTA DESPLEGABLE LINEAS*/
                     AND pf.GEOGRAP_LOCATION_ID IS NULL /*NC-1287 ajuste LISTA DESPLEGABLE LINEAS*/
                     AND pf.SALE_CHANEL_ID IS NULL /*NC-1287 ajuste LISTA DESPLEGABLE LINEAS*/
                     AND SYSDATE BETWEEN ct.COTIFEIN AND ct.COTIFEFI
            ORDER BY li.DESCRIPTION ASC;

        onuErrorCode := 0;
        osbErrorMessage := '';
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
    EXCEPTION
        WHEN OTHERS
        THEN
        pkg_Error.setError;
        pkg_Error.getError(onuErrorCode, osbErrorMessage);
        pkg_traza.trace('osbErrorMessage: ' || osbErrorMessage, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END proConsplanfiLineaFNB;

    ---------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    PROCEDURE proRegisVentaFNB (
        inuSubscription      IN     MO_PACKAGES.SUBSCRIPTION_PEND_ID%TYPE,
        inuclient            IN     ge_subscriber.subscriber_id%TYPE,
        inuCupoAprob         IN     ld_quota_by_subsc.quota_value%TYPE,
        inuCupoUtil          IN     ld_quota_by_subsc.quota_value%TYPE,
        inuExtraCupo         IN     ld_quota_by_subsc.quota_value%TYPE,
        inuCupoManUtil       IN     ld_quota_by_subsc.quota_value%TYPE,
        inuBill1             IN     factura.factcodi%TYPE,
        inuBill2             IN     factura.factcodi%TYPE,
        inuoperunit          IN     or_operating_unit.contractor_id%TYPE,
        inuSale_Channel_Id   IN     MO_PACKAGES.SALE_CHANNEL_ID%TYPE,
        inuPerson            IN     GE_PERSON.PERSON_ID%TYPE,
        idtsaleDate          IN     LD_NON_BA_FI_REQU.Sale_Date%TYPE,
        inuReception_Type    IN     MO_PACKAGES.RECEPTION_TYPE_ID%TYPE,
        isbPerioGrace        IN     LD_NON_BA_FI_REQU.Take_Grace_Period%TYPE,
        isbEntrPunt          IN     LD_NON_BA_FI_REQU.Delivery_Point%TYPE,
        inupayment           IN     ld_non_ba_fi_requ.payment%TYPE,
        isbComment_          IN     MO_PACKAGES.COMMENT_%TYPE,
        icuArticle           IN     CLOB,
        inuPromissory_id     IN     ld_promissory.promissory_id%TYPE,
        --inuPromissory_idcod in ld_promissory.promissory_id%type,
        onuPackage_Id           OUT MO_PACKAGES.PACKAGE_ID%TYPE,
        onuErrorCode            OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        osbErrorMessage         OUT GE_MESSAGE.DESCRIPTION%TYPE)
    AS
        /***************************************************************
         PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

                 PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.proRegisVentaFNB
                 AUTOR   : Sincecomp/Karem Baquero
                 FECHA   : 06/06/2014
                 RICEF   : l078
           DESCRIPCION   : Se realiza el registro de la venta brilla con
                           solicitud de venta FNB.
         Parametros de Salida

         Historia de Modificaciones

         Autor        Fecha       Descripcion.
        SEBTAP        29/09/2017   Se ajusata para evitar ventas repetidas Ca200-1382
        **************************************************************************/
        nuoperunit             or_operating_unit.operating_unit_id%TYPE;
        nuperson               or_oper_unit_persons.person_id%TYPE;
        sbcorreos              ld_parameter.value_chain%TYPE;

        vRealizaVenta          NUMBER;
        ExcepcVenta            EXCEPTION;
        
        sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
            
    BEGIN
        pkg_Traza.Trace ('LDCI_PKCRMFINBRILLAPORTAL.proRegisVentaFNB', 15);

        /*Se obtiene la unidad operativa desde el parametro*/
        nuoperunit := funGetOperUnit (inuoperunit);

        BEGIN
            SELECT o.person_id
              INTO nuperson
              FROM or_oper_unit_persons o
             WHERE operating_unit_id = nuoperunit AND ROWNUM = 1;
        EXCEPTION
            WHEN OTHERS
            THEN
                osbErrorMessage :=
                       'Error Consultando la persona de la unidad operativa: '
                    || nuoperunit
                    || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
                onuErrorCode := -1;
                pkg_Error.getError (onuErrorCode, osbErrorMessage);
        END;

        /*Modificacion CA 200-1382*/
        vRealizaVenta := ldc_fnurealizaventaweb (inuclient, inuSubscription);

        IF (vRealizaVenta = 1)
        THEN
            onuPackage_id := NULL;
            onuErrorCode := -1;
            osbErrorMessage :=
                'SE ENCUENTRA GENERADA UNA SOLICITUD ANTERIOR EN EL MISMO LAPSO DE TIEMPO';
            RAISE ExcepcVenta;
        END IF;

        /*Fin CA 200-1382*/


        OS_FinanBrillaPackages (inuSubscription,
                                inuclient,
                                inuCupoAprob,
                                inuCupoUtil,
                                inuExtraCupo,
                                inuCupoManUtil,
                                inuBill1,
                                inuBill2,
                                nuoperunit,
                                inuSale_Channel_Id,
                                nuperson,                         --inuPerson,
                                idtsaleDate,
                                inuReception_Type,
                                isbPerioGrace,
                                isbEntrPunt,
                                inupayment,
                                isbComment_,
                                icuArticle,
                                onuPackage_Id,
                                onuErrorCode,
                                osbErrorMessage);

        IF onuPackage_Id IS NOT NULL
        THEN
            dald_promissory.updPackage_Id (inuPromissory_id, onuPackage_Id);
        ELSE
            sbcorreos :=
                pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_SMTP_RECIBE_FNB_WEB');

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => sbcorreos,
                isbAsunto           => 'Error registro de venta Brilla Portal Web',
                isbMensaje          => 'El proveedor es: '
                                        || inuoperunit
                                        || 'El contrato : '
                                        || inuSubscription
                                        || 'Se encuentra realizando un registro de venta brilla desde el portal web
                                         y se presento el siguiente error, favor validar:  '
                                        || onuErrorCode
                                        || ' - '
                                        || 'Descripcion del error '
                                        || osbErrorMessage
            );

        END IF;

        pkg_Traza.Trace ('LDCI_PKCRMFINBRILLAPORTAL.proRegisVentaFNB', 15);
    EXCEPTION
        WHEN ExcepcVenta
        THEN
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
        WHEN OTHERS
        THEN
            osbErrorMessage :=
                   'Error en proceso de registro de venta brilla: '
                || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            onuErrorCode := -1;
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
    END proRegisVentaFNB;
    ------------------------------------------------------------------------
    -------------------------------------------------------------------------

    PROCEDURE OS_FinanBrillaPackages (
        inuSubscription      IN     MO_PACKAGES.SUBSCRIPTION_PEND_ID%TYPE,
        inuclient            IN     ge_subscriber.subscriber_id%TYPE,
        inuCupoAprob         IN     ld_quota_by_subsc.quota_value%TYPE,
        inuCupoUtil          IN     ld_quota_by_subsc.quota_value%TYPE,
        inuExtraCupo         IN     ld_quota_by_subsc.quota_value%TYPE,
        inuCupoManUtil       IN     ld_quota_by_subsc.quota_value%TYPE,
        inuBill1             IN     factura.factcodi%TYPE,
        inuBill2             IN     factura.factcodi%TYPE,
        inuoperunit          IN     or_operating_unit.operating_unit_id%TYPE,
        inuSale_Channel_Id   IN     MO_PACKAGES.SALE_CHANNEL_ID%TYPE,
        inuPerson            IN     GE_PERSON.PERSON_ID%TYPE,
        idtsaleDate          IN     LD_NON_BA_FI_REQU.Sale_Date%TYPE,
        inuReception_Type    IN     MO_PACKAGES.RECEPTION_TYPE_ID%TYPE,
        isbPerioGrace        IN     LD_NON_BA_FI_REQU.Take_Grace_Period%TYPE,
        isbEntrPunt          IN     LD_NON_BA_FI_REQU.Delivery_Point%TYPE,
        inupayment           IN     ld_non_ba_fi_requ.payment%TYPE,
        isbComment_          IN     MO_PACKAGES.COMMENT_%TYPE,
        icuArticle           IN     CLOB,
        onuPackage_Id           OUT MO_PACKAGES.PACKAGE_ID%TYPE,
        onuErrorCode            OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        osbErrorMessage         OUT GE_MESSAGE.DESCRIPTION%TYPE)
    IS
        /***************************************************************
         PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

                 PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.OS_FinanBrillaPackages
                 AUTOR   : Sincecomp/Karem Baquero
                 FECHA   : 06/06/2014
                 RICEF   : l078
           DESCRIPCION   : Se realiza el registro de la venta brilla con
                           solicitud de venta FNB.
         Parametros de Salida

         Historia de Modificaciones

         Autor        Fecha        Descripcion.
        SEBTAP        29/09/2017   Se ajusata para evitar ventas repetidas Ca200-1382
        KBaquero      29/09/2014  Se ajusta para que el valor del seguro no sea multiplicado
                                  por el numero de cuotas, si no que sea pleno.
		JSOTO		  30/11/2023   OSF-1816 Se elimina lógica que use API's de OPEN

        **************************************************************************/

    BEGIN

	NULL;

    END OS_FinanBrillaPackages;

    ---------------------------------------------------------------------------
    ---------------------------------------------------------------------------

    FUNCTION funGetOperUnit (inuproveed IN ld_extra_quota.supplier_id%TYPE)
        RETURN NUMBER
    IS
        /*****************************************************************
        Propiedad intelectual de Open International Systems (c).

        Unidad         : funGetOperUnit
        Descripcion    : Se obtiene la unidad operativa de venta por portal web
                         dependiendo del proveedor configurado
        Autor          : Sincecomp/Karem Baquero
        Fecha          : 10/06/2014
        RICEF          : l078
        Parametros              Descripcion
        ============         ===================
        ENTRADA
         inuproveed             Identificador del proveedor.

        Historia de Modificaciones
        Fecha             Autor               Modificacion
        =========         =========           ====================

        ******************************************************************/
        CURSOR cuoperunit IS
            SELECT o.operating_unit_id
              FROM or_operating_unit o
             WHERE o.contractor_id = inuproveed;

        nuok      NUMBER;
        onuoper   NUMBER;
    BEGIN
        pkg_Traza.Trace (
               'INICIO LDCI_PKCRMFINBRILLAPORTAL.funGetOperUnit['
            || inuproveed
            || ']',
            1);

        FOR rgoperunit IN cuoperunit
        LOOP
            SELECT COUNT (*)
              INTO nuok
              FROM DUAL
             WHERE rgoperunit.operating_unit_id IN
                       ( (SELECT TO_NUMBER (COLUMN_VALUE)
                            FROM TABLE (
                                     ldc_boutilities.splitstrings (
                                         DALD_PARAMETER.fsbGetValue_Chain (
                                             'UNITY_TRAB_PORTAL_WEB',
                                             NULL),
                                         ','))));

            IF nuok = 1
            THEN
                onuoper := rgoperunit.operating_unit_id;
            END IF;
        END LOOP;

        RETURN onuoper;

        pkg_Traza.Trace ('FIN LDCI_PKCRMFINBRILLAPORTAL.funGetOperUnit', 1);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END funGetOperUnit;

    ---------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    PROCEDURE procvalIdenRedferido (
        ISBIDENTIFICACION   IN     LD_Result_Consult.Identification%TYPE,
        onuErrorCode           OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        osbErrorMessage        OUT GE_MESSAGE.DESCRIPTION%TYPE)
    AS
        /***************************************************************
         PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

                 PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.procvalIdenRedferido
                 AUTOR   : Sincecomp/Karem Baquero
                 FECHA   : 24/06/2014
                 RICEF   : l084
           DESCRIPCION   : Se realiza la validacion de la cedula de
                          referidor, para que no sea un tecnico activo
                          de la empresa.
         Parametros de Salida

         Historia de Modificaciones

         Autor        Fecha       Descripcion.

        **************************************************************************/
        nucont   NUMBER;
    BEGIN
        pkg_Traza.Trace (
            'INICIO LDCI_PKCRMFINBRILLAPORTAL.procvalIdenRedferido',
            10);

        SELECT COUNT (*)
          INTO nucont
          FROM ge_person p, cc_orga_area_seller a, or_operating_unit c
         WHERE     p.number_id = ISBIDENTIFICACION                --'94074880'
               --AND IS_current = 'Y'
               AND c.oper_unit_status_id IN (1, 3)
               AND a.person_id = p.person_id
               AND a.organizat_area_id = c.orga_area_id
               AND a.organizat_area_id = c.operating_unit_id;

        IF nucont = 0
        THEN
            onuErrorCode := 0;
            osbErrorMessage := '';
        ELSE
            GE_BOErrors.SetErrorCodeArgument (
                2741,
                   'Esta identificacion '
                || ISBIDENTIFICACION
                || ' Pertence a un tecnico activo');
        END IF;

        pkg_Traza.Trace ('FIN LDCI_PKCRMFINBRILLAPORTAL.procvalIdenRedferido',
                        10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            errors.geterror (onuErrorCode, osbErrorMessage);
        -- raise ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            errors.geterror (onuErrorCode, osbErrorMessage);
    -- raise ex.CONTROLLED_ERROR;
    END procvalIdenRedferido;

    ---------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    PROCEDURE procConsultPagare (
        inuprov           IN     ld_extra_quota.supplier_id%TYPE,
        orfCursor            OUT Constants.tyRefCursor,
        onuErrorCode         OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        osbErrorMessage      OUT GE_MESSAGE.DESCRIPTION%TYPE)
    AS
        /***************************************************************
         PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

                 PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.procConsultPagare
                 AUTOR   : Sincecomp/Karem Baquero
                 FECHA   : 01/07/2014
                 RICEF   : l091
           DESCRIPCION   : Se realiza la consulta de pagares pendiente por el
                           proveedor.
         Parametros de Salida

         Historia de Modificaciones

         Autor        Fecha       Descripcion.

        **************************************************************************/
        nuoperunit   or_operating_unit.operating_unit_id%TYPE;
    BEGIN
        pkg_Traza.Trace ('INICIO LDCI_PKCRMFINBRILLAPORTAL.procConsultPagare',
                        10);

        /*Se obtiene la unidad operativa desde el parametro*/
        nuoperunit := funGetOperUnit (inuprov);

        OPEN orfCursor FOR
            SELECT DISTINCT
                   l.digital_prom_note_cons                Pagare,
                   (SELECT subscriber_name || ' ' || subs_last_name
                      FROM ge_subscriber
                     WHERE subscriber_id IN
                               (SELECT mo_packages.subscriber_id
                                  FROM mo_packages
                                 WHERE mo_packages.package_id =
                                       o.package_id))      Nombre,
                   (SELECT TO_CHAR (request_date, 'dd/mm/yyyy')
                      FROM mo_packages
                     WHERE package_id = o.package_id)      Fecha_solicitud,
                   TO_CHAR (l.SALE_DATE, 'dd/mm/yyyy')     fecha_venta,
                   ot.order_id                             order_id,
                   ot.operating_unit_id                    Unidad_operativa,
                   o.package_id                            solicitud,
                   o.subscription_id                       contrato,
                   (SELECT comment_
                      FROM mo_packages
                     WHERE package_id = o.package_id)      Observacion,
                   l.first_bill_id                         first_bill_id,
                   (SELECT TO_CHAR (f.factfege, 'dd/mm/yyyy')
                      FROM factura f
                     WHERE factcodi = l.first_bill_id)     factpefa_1,
                   l.second_bill_id                        second_bill_id,
                   (SELECT TO_CHAR (f.factfege, 'dd/mm/yyyy')
                      FROM factura f
                     WHERE factcodi = l.second_bill_id)    factpefa_2
              FROM or_order_activity o, or_order ot, ld_non_ba_fi_requ l
             WHERE     ot.operating_unit_id = nuoperunit                 --766
                   AND o.activity_id =
                       pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                           'SALE_ORDER_WEB_FNB_ACTIVI_TYPE')
                   AND ot.order_status_id NOT IN (8, 12)
                   AND ot.order_id = o.order_id
                   AND l.non_ba_fi_requ_id = o.package_id;

        onuErrorCode := 0;
        osbErrorMessage := '';

        pkg_Traza.Trace ('FIN LDCI_PKCRMFINBRILLAPORTAL.procConsultPagare',
                        10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            errors.geterror (onuErrorCode, osbErrorMessage);
        -- raise ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            errors.geterror (onuErrorCode, osbErrorMessage);
    -- raise ex.CONTROLLED_ERROR;
    END procConsultPagare;

    ---------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    PROCEDURE procConsultPrecargue (
        inususc           IN     suscripc.susccodi%TYPE,
        orfCursor            OUT Constants.tyRefCursor,
        onuErrorCode         OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        osbErrorMessage      OUT GE_MESSAGE.DESCRIPTION%TYPE)
    AS
        /***************************************************************
         PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

                 PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.procConsultPagare
                 AUTOR   : Sincecomp/Karem Baquero
                 FECHA   : 01/07/2014
                 RICEF   : l091
           DESCRIPCION   : Se realiza la consulta de pagares pendiente por el
                           proveedor.
         Parametros de Salida

         Historia de Modificaciones

         Autor        Fecha       Descripcion.

        **************************************************************************/
        nugesubs       ge_subscriber.subscriber_id%TYPE;
        sbidtificate   ge_subscriber.identification%TYPE;
    BEGIN
        pkg_Traza.Trace ('INICIO LDCI_PKCRMFINBRILLAPORTAL.procConsultPagare',
                        10);

        /*Se obtiene la informacion del cliente a raiz del suscriptor*/
        nugesubs := pktblsuscripc.fnugetsuscclie (inususc);
        sbidtificate := dage_subscriber.fsbgetidentification (nugesubs);

        OPEN orfCursor FOR
              SELECT /*+
                           use_nl(ld_non_ban_fi_item)
                           index(ld_non_ban_fi_item ix_ld_non_ban_fi_item02)
                           leading(ld_non_ban_fi_item)
                           */
                     a.Article_Id,
                     a.reference,
                     a.description,
                     deu.*,
                     (ADD_MONTHS (
                          request_date,
                          (SELECT MAX (quotas_number)
                             FROM ld_non_ban_fi_item
                            WHERE non_ba_fi_requ_id =
                                  deu.package_id)))
                         loan_fin_date,
                     (SELECT MAX (
                                 ld_bcnonbankfinancing.fnuGetInterestPct (
                                     plditain,
                                     dald_non_ba_fi_requ.fdtGetSale_Date (
                                         deu.package_id)))
                        FROM ld_non_ban_fi_item, plandife
                       WHERE     finan_plan_id = pldicodi
                             AND non_ba_fi_requ_id = deu.package_id)
                         rem_interest,
                     /* a.article_id,
                            reference,
                            description,*/
                     amount,
                     unit_value,
                     (SELECT MAX (quotas_number)
                        FROM ld_non_ban_fi_item
                       WHERE non_ba_fi_requ_id = deu.package_id)
                         quotas_number,
                     --EVESAN 18/Julio/2013
                     TRIM (
                         TO_CHAR (
                             dald_non_ba_fi_requ.fnuGetQuota_Aprox_Month (
                                 ld_non_ban_fi_item.non_ba_fi_requ_id,
                                 0),
                             '$999G999G999G999G999D99'))
                         "CUOTA_MENSUAL_APROX",
                     TRIM (
                         TO_CHAR (
                             dald_aditional_fnb_info.fnuGetAPROX_MONTH_INSURANCE (
                                 ld_non_ban_fi_item.non_ba_fi_requ_id,
                                 0),
                             '$999G999G999G999G999D99'))
                         "VALOR_SEGURO"
                FROM (SELECT /*+ use_nl(ld_promissory)
                                              index(ld_promissory IDX_LD_PROMISSORY02)
                                              leading(ld_promissory)
                                           */
                             promissory_id,
                             holder_bill,
                             debtorname || ' ' || last_name
                                 debtorname,
                             identification,
                             DAge_geogra_location.fsbGetDescription (
                                 forwardingplace)
                                 forwardingplace,
                             TO_CHAR (forwardingdate, 'dd/mm/yyyy')
                                 forwardingdate,
                             gender,
                                civil_state_id
                             || '-'
                             || DAge_civil_state.fsbGetDescription (
                                    civil_state_id)
                                 civil_state_id,
                             TO_CHAR (birthdaydate, 'dd/mm/yyyy')
                                 birthdaydate,
                                school_degree_
                             || '-'
                             || DAge_school_degree.fsbGetDescription (
                                    school_degree_)
                                 school_degree_,
                             (SELECT address_parsed
                                FROM ab_address
                               WHERE ab_address.address_id =
                                     ld_promissory.address_id)
                                 address_id,
                             (SELECT ge_geogra_location.description
                                FROM ab_address, ge_geogra_location
                               WHERE     ab_address.neighborthood_id =
                                         ge_geogra_location.geograp_location_id
                                     AND ab_address.address_id =
                                         ld_promissory.address_id)
                                 NEIGHBORTHOOD_ID,
                             (SELECT ge_geogra_location.description
                                FROM ab_address, ge_geogra_location
                               WHERE     ab_address.address_id =
                                         ld_promissory.address_id
                                     AND ab_address.geograp_location_id =
                                         ge_geogra_location.geograp_location_id)
                                 CITY,
                             (SELECT A.DESCRIPTION
                                FROM GE_GEOGRA_LOCATION A,
                                     GE_GEOGRA_LOCATION B,
                                     AB_ADDRESS        C
                               WHERE     C.ADDRESS_ID =
                                         ld_promissory.address_id
                                     AND C.GEOGRAP_LOCATION_ID =
                                         B.GEOGRAP_LOCATION_ID
                                     AND A.GEOGRAP_LOCATION_ID =
                                         B.GEO_LOCA_FATHER_ID)
                                 department,
                             propertyphone_id,
                             dependentsnumber
                                 "DEU_PERSONAS_CARGO",
                                housingtype
                             || '-'
                             || DAGE_HOUSE_TYPE.fsbGetDescription (housingtype)
                                 housingtype,
                             housingmonth,
                             holderrelation,
                             (SELECT activity_id || '-' || description
                                FROM ge_activity
                               WHERE activity_id = TO_NUMBER (occupation))
                                 occupation,
                             companyname,
                             (SELECT address
                                FROM ab_address
                               WHERE ab_address.address_id =
                                     ld_promissory.companyaddress_id)
                                 companyaddress_id,
                             phone1_id,
                             phone2_id,
                             movilphone_id,
                             oldlabor,
                             activity,
                             monthlyincome,
                             expensesincome,
                             commerreference,
                             phonecommrefe,
                             movilphocommrefe,
                             daab_address.fsbgetaddress_parsed (
                                 addresscommrefe,
                                 0)
                                 addresscommrefe,
                             familiarreference,
                             phonefamirefe,
                             movilphofamirefe,
                             daab_address.fsbgetaddress_parsed (
                                 addressfamirefe,
                                 0)
                                 addressfamirefe,
                             personalreference,
                             phonepersrefe,
                             movilphopersrefe,
                             addresspersrefe,
                             email,
                             package_id,
                             promissory_type,
                             --/*
                             --santiman_START
                             /* (select mo_packages.subscription_pend_id
                                             from mo_packages
                                            where mo_packages.Subscriber_Id = 811878
                                            and mo_packages.package_type_id='100264'
                                            \*AND ROWNUM = 1*\) Subscription_id,*/
                              (SELECT ld_bcnonbankfinancing.fnuGetInterestPct (
                                          pktblparametr.fnugetvaluenumber (
                                              'BIL_TASA_USURA'),
                                          dald_non_ba_fi_requ.fdtGetSale_Date (
                                              Package_Id))
                                 FROM DUAL)
                                 max_interest,
                             (SELECT value_total
                                FROM ld_non_ba_fi_requ
                               WHERE non_ba_fi_requ_id = Package_Id)
                                 tot_sale_value,
                             --santiman_END
                             --*/
                              (SELECT digital_prom_note_cons
                                 FROM ld_non_ba_fi_requ t
                                WHERE non_ba_fi_requ_id = Package_Id)
                                 digital_prom_note_cons,
                             --*/
                              (SELECT TO_CHAR (request_date, 'dd/mm/yyyy')
                                 FROM mo_packages
                                WHERE package_id = Package_Id AND ROWNUM = 1)
                                 request_date,
                             --*/
                              (SELECT   TRUNC (request_date)
                                      + pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                            'DAYS_AVAILABLE_PAGARE')
                                 FROM mo_packages
                                WHERE package_id = Package_Id AND ROWNUM = 1)
                                 effective_date,
                             --*/
                              (SELECT person_id
                                 FROM mo_packages
                                WHERE package_id = Package_Id AND ROWNUM = 1)
                                 person_id,
                             --*/
                              (SELECT payment
                                 FROM ld_non_ba_fi_requ
                                WHERE non_ba_fi_requ_id = Package_Id)
                                 payment,
                             --*/
                              (SELECT subscriber_name || ' ' || subs_last_name
                                 FROM ge_subscriber
                                WHERE subscriber_id IN
                                          (SELECT mo_packages.subscriber_id
                                             FROM mo_packages
                                            WHERE     mo_packages.package_id =
                                                      Package_Id
                                                  AND ROWNUM = 1))
                                 subscriber_name,
                             contract_type_id,
                             --*/
                              (SELECT catecodi || '-' || catedesc
                                 FROM categori
                                WHERE catecodi = category_id)
                                 categoria,
                             (SELECT sucacodi || '-' || sucadesc
                                FROM subcateg
                               WHERE     sucacate = category_id
                                     AND sucacodi = subcategory_id)
                                 subcategoria,
                             (SELECT ident_type_id || '-' || description
                                FROM ge_identifica_type
                               WHERE ge_identifica_type.ident_type_id =
                                     ld_promissory.ident_type_id)
                                 ident_type_id,
                             dage_subscriber.fsbgetidentification (nugesubs)
                                 identificacion
                        --*/
                        FROM ld_promissory
                       WHERE     Identification = sbidtificate --TO_CHAR(1047408409)
                             AND promissory_type = 'D') deu,
                     ld_non_ban_fi_item,
                     ld_article a
               /*+ Ubicacion: LD_BCPortafolio.FtrfPromissory */
               WHERE     ld_non_ban_fi_item.non_ba_fi_requ_id = deu.package_id
                     AND package_id = ld_non_ban_fi_item.non_ba_fi_requ_id
                     AND ld_non_ban_fi_item.article_id = a.article_id
            ORDER BY non_ba_fi_requ_id;

        onuErrorCode := 0;
        osbErrorMessage := '';

        pkg_Traza.Trace ('FIN LDCI_PKCRMFINBRILLAPORTAL.procConsultPagare',
                        10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            errors.geterror (onuErrorCode, osbErrorMessage);
        -- raise ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            errors.geterror (onuErrorCode, osbErrorMessage);
    -- raise ex.CONTROLLED_ERROR;
    END procConsultPrecargue;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fblValidateBills
    Descripcion    : Valida las facturas ingresadas.

    Autor          :
    Fecha          : 11/07/2012

    Parametros              Descripcion
    ============         ===================
    inuPackageId: Numero de la solicitud.


    Historia de Modificaciones
    Fecha       Autor                 Modificacion
    =========   =========             ====================
    30-08-2013  lfernandez.SAO211609  Se corrige validacion de la fecha de la
                                      factura 2
    29-08-2013  lfernandez.SAO211609  Se muestran mensajes de error cuando se
                                      ingresan valores invalidos
    ******************************************************************/
    FUNCTION fblValidateBills (inuSubscription   suscripc.susccodi%TYPE,
                               inuBill1          factura.factcodi%TYPE,
                               idtBill1          factura.factfege%TYPE,
                               inuBill2          factura.factcodi%TYPE,
                               idtBill2          factura.factfege%TYPE)
        RETURN BOOLEAN
    IS
        ------------------------------------------------------------------------
        --  Variables
        ------------------------------------------------------------------------
        rcBill1          factura%ROWTYPE;
        rcBill2          factura%ROWTYPE;
        dtBill1          DATE;
        dtBill2          DATE;
        nuMesesValFact   ld_parameter.numeric_value%TYPE;
    BEGIN
        pkg_Traza.Trace ('LD_BONonBankFinancing.fblValidateBills', 15);

        nuMesesValFact :=
            NVL (pkg_BCLD_Parameter.fnuObtieneValorNumerico ('NUM_MESES_VAFA_FNB'),
                 0);

        --  Si se envio la factura 1
        IF (inuBill1 IS NOT NULL)
        THEN
            --  Obtiene la informacion de la factura 1
            rcBill1 := pkTblFactura.frcGetRecord (inuBill1);

            --  Si la suscripcion de la factura es diferente a la enviada
            IF (rcBill1.factsusc <> inuSubscription)
            THEN
                GE_BOErrors.SetErrorCodeArgument (
                    2741,
                    'La primera factura no pertenece a la suscripcion');
            END IF;

            --  Si las fechas son diferentes
            IF (TRUNC (rcBill1.factfege) <> TRUNC (idtBill1))
            THEN
                GE_BOErrors.SetErrorCodeArgument (
                    2741,
                    'La fecha de generacion ingresada de la primera factura no es igual a la fecha de generacion de la primera factura');
            END IF;

            IF (ABS (MONTHS_BETWEEN (rcBill1.factfege, SYSDATE)) >
                nuMesesValFact)
            THEN
                GE_BOErrors.SetErrorCodeArgument (
                    2741,
                       'La fecha de generacion de la primera factura no pueden ser inferior a: '
                    || nuMesesValFact
                    || ' meses.');
            END IF;
        END IF;

        --  Si se envio la factura 2
        IF (inuBill2 IS NOT NULL)
        THEN
            --  Obtiene la informacion de la factura 2
            rcBill2 := pkTblFactura.frcGetRecord (inuBill2);

            --  Si la suscripcion de la factura es diferente a la enviada
            IF (rcBill2.factsusc <> inuSubscription)
            THEN
                GE_BOErrors.SetErrorCodeArgument (
                    2741,
                    'La segunda factura no pertenece a la suscripcion');
            END IF;

            --  Si las fechas son diferentes
            IF (TRUNC (rcBill2.factfege) <> TRUNC (idtBill2))
            THEN
                GE_BOErrors.SetErrorCodeArgument (
                    2741,
                    'La fecha de generacion ingresada de la segunda factura no es igual a la fecha de generacion de la segunda factura');
            END IF;

            IF (ABS (MONTHS_BETWEEN (rcBill2.factfege, SYSDATE)) >
                nuMesesValFact)
            THEN
                GE_BOErrors.SetErrorCodeArgument (
                    2741,
                       'La fecha de generacion de la segunda factura no pueden ser inferior a: '
                    || nuMesesValFact
                    || ' meses.');
            END IF;
        END IF;

        --  Si los valores enviados son correctos
        --Caso 200-816
        IF (inuBill2 IS NOT NULL)
        THEN
            IF (    rcBill1.factsusc = inuSubscription
                AND rcBill2.factsusc = inuSubscription
                AND TRUNC (rcBill1.factfege) = TRUNC (idtBill1)
                AND TRUNC (rcBill2.factfege) = TRUNC (idtBill2))
            THEN
                RETURN TRUE;
            ELSE
                RETURN FALSE;
            END IF;
        ELSE
            --Caso 200-816
            IF (    rcBill1.factsusc = inuSubscription
                AND TRUNC (rcBill1.factfege) = TRUNC (idtBill1))
            THEN
                RETURN TRUE;
            ELSE
                RETURN FALSE;
            END IF;
        END IF;
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END fblValidateBills;
END LDCI_PKCRMFINBRILLAPORTAL;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_PKCRMFINBRILLAPORTAL', 'ADM_PERSON'); 
END;
/
GRANT EXECUTE ON ADM_PERSON.LDCI_PKCRMFINBRILLAPORTAL TO INTEGRACIONES;
/
GRANT EXECUTE ON ADM_PERSON.LDCI_PKCRMFINBRILLAPORTAL TO INTEGRADESA;
/