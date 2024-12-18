CREATE OR REPLACE PACKAGE adm_person.ldc_boSubscription IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    23/07/2024              PAcosta         OSF-2952: Cambio de esquema ADM_PERSON                              
    **************************************************************/

    FUNCTION FSBVERSION  RETURN VARCHAR2;


    PROCEDURE GETSUBSCRIBER
    (
        INUSUBSCRIPTION IN NUMBER,
        ONUSUBSCRIBER   OUT NUMBER
    );


    PROCEDURE GETSUBSCRIPTIONS
    (
        ISBIDENTIFICATION   IN VARCHAR2,
        ISBNAME             IN VARCHAR2,
        ISBLASTNAME         IN VARCHAR2,
        ISBCONTACTPHONE     IN VARCHAR2,
        INUSUBSCRIPTION     IN NUMBER,
        ISBEMAIL            IN VARCHAR2,
        ISBADDRESSID        IN VARCHAR2,
        ISBSUBSCRIPTIONTYPE IN VARCHAR2,
        ISBADDRESSSTRING    IN VARCHAR2,
        ISBGEOGRAPLOCATION  IN VARCHAR2,
        OCUCURSOR           OUT CONSTANTS.TYREFCURSOR
    );

    PROCEDURE GETCONTRACTS
    (
        INUSUBSCRIPTION         IN SUSCRIPC.SUSCCODI%TYPE,
        ISBIDENTIFICATION       IN GE_SUBSCRIBER.IDENTIFICATION%TYPE,
        ISBNAME                 IN GE_SUBSCRIBER.SUBSCRIBER_NAME%TYPE,
        ISBLASTNAME             IN GE_SUBSCRIBER.SUBS_LAST_NAME%TYPE,
        ISBCONTACTPHONE         IN GE_SUBSCRIBER.PHONE%TYPE,
        ISBEMAIL                IN GE_SUBSCRIBER.E_MAIL%TYPE,
        INUGEOGRAPHLOCATIONID   IN AB_ADDRESS.GEOGRAP_LOCATION_ID%TYPE,
        INUNEIGHBORTHOODID      IN AB_ADDRESS.NEIGHBORTHOOD_ID%TYPE,
        ISBADDRESSSTRING        IN AB_ADDRESS.ADDRESS%TYPE,
        OCUCURSOR           OUT CONSTANTS.TYREFCURSOR
    );



    PROCEDURE GETCONTRACTSWHITVALADD
    (
        INUSUBSCRIPTION         IN SUSCRIPC.SUSCCODI%TYPE,
        ISBIDENTIFICATION       IN GE_SUBSCRIBER.IDENTIFICATION%TYPE,
        ISBNAME                 IN GE_SUBSCRIBER.SUBSCRIBER_NAME%TYPE,
        ISBLASTNAME             IN GE_SUBSCRIBER.SUBS_LAST_NAME%TYPE,
        ISBCONTACTPHONE         IN GE_SUBSCRIBER.PHONE%TYPE,
        ISBEMAIL                IN GE_SUBSCRIBER.E_MAIL%TYPE,
        INUGEOGRAPHLOCATIONID   IN AB_ADDRESS.GEOGRAP_LOCATION_ID%TYPE,
        ISBADDRESSSTRING        IN AB_ADDRESS.ADDRESS%TYPE,
        OCUCURSOR               OUT CONSTANTS.TYREFCURSOR
    );


    PROCEDURE GETSUBSCRIBERSUBSCRIPTIONS
    (
        INUSUBSCRIBER IN NUMBER,
        OCUCURSOR     OUT CONSTANTS.TYREFCURSOR
    );

    PROCEDURE GETSUBSCRIPTION
    (
        INUSUBSCRIPTION IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    );

    PROCEDURE GETCONTRACTWHITVALADD
    (
        INUSUBSCRIPTION IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    );

    PROCEDURE GETSUBSCRIPTIONFROMROUTE
    (
        INUADDRESSID  IN  AB_ADDRESS.ADDRESS_ID%TYPE,
        OCUCURSOR     OUT CONSTANTS.TYREFCURSOR
    );



    PROCEDURE GETPACKAGES
    (
        INUSUBSCRIPTION IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    );




    PROCEDURE GETCOMPLAINTS
    (
        INUSUBSCRIPTION IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    );

    PROCEDURE GETCLAIMS
    (
        INUSUBSCRIPTION IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    );


    PROCEDURE GETBILL
    (
        INUSUBSCRIPTION IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    );

    PROCEDURE GETBILLACCOUNT
    (
        INUSUBSCRIPTION IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    );

    PROCEDURE GETPAYMENT
    (
        INUSUBSCRIPTION IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    );




    PROCEDURE GETATTACHFILES
    (
        INUCONTRACT         IN   SUSCRIPC.SUSCCODI%TYPE,
        OCUATTACHFILES      OUT  CONSTANTS.TYREFCURSOR
    );



    PROCEDURE GETBUNDLED
    (
        INUCONTRACT IN SUSCRIPC.SUSCCODI%TYPE,
        OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
    );


    PROCEDURE GETPROMOTIONS
    (
        INUCONTRACT IN SUSCRIPC.SUSCCODI%TYPE,
        OCUCURSOR    OUT CONSTANTS.TYREFCURSOR
    );

END ldc_boSubscription;
/
CREATE OR REPLACE PACKAGE BODY adm_person.ldc_boSubscription IS


    CSBVERSION CONSTANT VARCHAR2(250) := 'SAO223559';




    SBSUBSCRIPTIONSQL           VARCHAR2(8000);

    TBSUBSCRIPTIONATTRIBUTES    CC_TYTBATTRIBUTE;



    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;



    PROCEDURE GETSUBSCRIBER
    (
        INUSUBSCRIPTION IN NUMBER,
        ONUSUBSCRIBER   OUT NUMBER
    )
    IS
    BEGIN
        IF INUSUBSCRIPTION IS NULL THEN
            ONUSUBSCRIBER := NULL;
            RETURN;
        END IF;


        PKTBLSUSCRIPC.ACCKEY(INUSUBSCRIPTION);
        ONUSUBSCRIBER := PKTBLSUSCRIPC.FNUGETCUSTOMER(INUSUBSCRIPTION);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ONUSUBSCRIBER := NULL;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;




    PROCEDURE FILLSUBSCRIPTIONSATTRIBUTES
    IS
        SBATTRIBUTES          VARCHAR2(5000);
        SBIDENTIFICATIONTYPE  VARCHAR2(300);
        SBCHARGENEIGHBORTHOOD VARCHAR2(300);
        SBCHARGECITY          VARCHAR2(300);
        SBCHARGESTATE         VARCHAR2(300);
        SBCICLE               VARCHAR2(300);
        SBFINANCIALSTATUS     VARCHAR2(300);
        SBCOINTYPE            VARCHAR2(300);
        SBBALCLAIMPAYNOPAID   VARCHAR2(512);
        SBCARDTYPE            VARCHAR2(300);
        SBSUBSCRIPTIONTYPE    VARCHAR2(300);
        SBDEFBALANCE          VARCHAR2(500);
        SBTOTALCUOTE          VARCHAR2(500);
        SBSUBSCCOMPANY        VARCHAR2(500);
        SBIDENTTYPETT         VARCHAR2(500);
        SBCOUNTBILLNOPAY      VARCHAR2(500);
        SBCLAIMNOPAY          VARCHAR2(500);
        SBDEPOSIT             VARCHAR2(500);
        SBNOVDEBAUTINCLUSION  VARCHAR2(500);
        SBNOVDEBAUTEXCLUSION  VARCHAR2(500);
        SBPUNISHVALUE         VARCHAR2(500);
        SBSECTOROPERATIVO     VARCHAR2(500);

    BEGIN
        CC_BOBSSSUBSCRIPTIONDATA.INIT;

        IF SBSUBSCRIPTIONSQL IS NOT NULL THEN
            RETURN;
        END IF;

        SBIDENTIFICATIONTYPE  := 'cc_boBssSubscriptionData.fnuGetIdentType(suscripc.susccodi)'   || CC_BOBOSSUTIL.CSBSEPARATOR ||'cc_boBssSubscriptionData.fsbIdentTypeDesc(suscripc.susccodi)';
        SBSUBSCRIPTIONTYPE    := 'suscripc.susctisu'|| CC_BOBOSSUTIL.CSBSEPARATOR ||'cc_boOssDescription.fsbSubscriptionType(suscripc.susctisu)';
        SBCHARGENEIGHBORTHOOD := 'cc_boBssSubscriptionData.fnuChargeNeighborthood (suscripc.susccodi)'|| CC_BOBOSSUTIL.CSBSEPARATOR ||'cc_boBssSubscriptionData.fsbChargeNeighborthood (suscripc.susccodi)';
        SBCHARGESTATE         := 'cc_boBssSubscriptionData.fnuChargeState (suscripc.susccodi)'        || CC_BOBOSSUTIL.CSBSEPARATOR ||'cc_boBssSubscriptionData.fsbChargeState (suscripc.susccodi)';
        SBCICLE               := 'cc_boBssSubscriptionData.fnuCicle (suscripc.susccodi)'              || CC_BOBOSSUTIL.CSBSEPARATOR ||'cc_boBssSubscriptionData.fsbCicle (suscripc.susccodi)';
        SBCHARGECITY          := 'cc_boBssSubscriptionData.fnuChargeCity (suscripc.susccodi)'         || CC_BOBOSSUTIL.CSBSEPARATOR ||'cc_boBssSubscriptionData.fsbChargeCity (suscripc.susccodi)';
        SBCOINTYPE            := 'cc_boBssSubscriptionData.fsbCoinType (suscripc.susccodi)'           || CC_BOBOSSUTIL.CSBSEPARATOR ||'cc_boBssSubscriptionData.fsbCoinTypeDescription (suscripc.susccodi)';
        SBBALCLAIMPAYNOPAID   := 'cc_boBssSubscriptionData.fnuBalClaimPayNoPaid(suscripc.susccodi) ';
        SBCARDTYPE            := 'cc_boBssSubscriptionData.fsbGetCardType(suscripc.susccodi)'         || CC_BOBOSSUTIL.CSBSEPARATOR ||'cc_boBssSubscriptionData.fsbGetCardTypeDesc(suscripc.susccodi)';
        SBDEFBALANCE          := 'cc_boBssSubscriptionData.fnuGetDefBalance(suscripc.susccodi)';
        SBTOTALCUOTE          := 'cc_boBssSubscriptionData.fnuGetTotalCuote(suscripc.susccodi)';
        SBSUBSCCOMPANY        := 'suscripc.suscsist'|| CC_BOBOSSUTIL.CSBSEPARATOR ||'cc_boOssDescription.fsbGetCompanyName(suscripc.suscsist)';
        SBIDENTTYPETT         := 'suscripc.SUSCTITT' || CC_BOBOSSUTIL.CSBSEPARATOR ||'cc_boOssDescription.fsbIdentificationType(suscripc.SUSCTITT)';
        SBCOUNTBILLNOPAY      := 'pkAccountStatusMgr.fnuGetSubscNumAccWithBal(suscripc.susccodi)';
        SBCLAIMNOPAY          := 'cc_boBssSubscriptionData.fnuGetClaimNoPay(suscripc.susccodi)';
        SBDEPOSIT             := 'RC_BCPositiveBalance.fnuGetDepPosBalBySusc(suscripc.susccodi)';
        SBNOVDEBAUTINCLUSION  := 'pkBOAutomaticDebitNovelty.fdtObtDebiAutoNove(suscripc.susccodi,'||PKGENERALPARAMETERSMGR.FNUGETNUMBERVALUE('TIPO_NOVE_INCLUSION')||')';
        SBNOVDEBAUTEXCLUSION  := 'pkBOAutomaticDebitNovelty.fdtObtDebiAutoNove(suscripc.susccodi,'||PKGENERALPARAMETERSMGR.FNUGETNUMBERVALUE('TIPO_NOVE_RETIRO')||')';
        SBPUNISHVALUE         := 'cc_boBssSubscriptionData.fnuPunishValue(suscripc.susccodi)';
        SBSECTOROPERATIVO     := 'FSBSECTOROPERATIVO(suscripc.susccodi)';


        CC_BOBOSSUTIL.ADDATTRIBUTE ('suscripc.susccodi',                                                  'SUBSCRIPTION_ID',      CC_BOBOSSUTIL.CNUNUMBER,   SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES, TRUE);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBSUBSCRIPTIONTYPE,                                                   'SUBSCRIPTION_TYPE',    CC_BOBOSSUTIL.CNUNUMBER,   SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('suscripc.suscclie',                                                  'SUBSCRIBER_ID',        CC_BOBOSSUTIL.CNUNUMBER,   SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fsbGetSubscriberName(suscripc.susccodi)',   'SUBSCRIPTION_NAME',    CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fsbGetSubsLastName(suscripc.susccodi)',     'SUBS_LAST_NAME',       CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fsbGetIdentification(suscripc.susccodi)',   'IDENTIFICATION',       CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fsbGetPhone(suscripc.susccodi)',            'PHONE',                CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBIDENTIFICATIONTYPE,                                                 'IDENTIFICATION_TYPE',  CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);

        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fsbContactAddressParsed(suscripc.susccodi)',      'CONTACT_ADDRESS',      CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fsbContactNeighbor(suscripc.susccodi)',     'CONTACT_NEIGHBORHOOD', CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fsbContactGeoLoc(suscripc.susccodi)',       'CONTACT_GEO_LOC',      CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fsbRoute (suscripc.susccodi)',              'ROUTE',                CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBCICLE,                                                              'CICLE',                CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);

        CC_BOBOSSUTIL.ADDATTRIBUTE (SBSECTOROPERATIVO,                                                    'sector_operativo',     CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);

        CC_BOBOSSUTIL.ADDATTRIBUTE ('pkBCAccountStatus.fnuGetBillBalBySusc (suscripc.susccodi)',          'BALANCE',              CC_BOBOSSUTIL.CNUCURRENCY, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fnuGetBalAccNum (suscripc.susccodi)',       'ACCOUNT_WITH_BALANCE', CC_BOBOSSUTIL.CNUNUMBER,   SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fnuFavorBalance (suscripc.susccodi)',       'FAVOR_BALANCE',        CC_BOBOSSUTIL.CNUCURRENCY, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fnuClaimBalance (suscripc.susccodi)',       'CLAIM_BALANCE',        CC_BOBOSSUTIL.CNUCURRENCY, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBBALCLAIMPAYNOPAID,                                                  'CLAIM_BALANCE_NO_PAID',CC_BOBOSSUTIL.CNUCURRENCY, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fdtFinalDate (suscripc.susccodi)',          'FINALDATE',            CC_BOBOSSUTIL.CNUDATE,     SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fdtPayDateAct (suscripc.susccodi)',            'PAYDATE',              CC_BOBOSSUTIL.CNUDATE,     SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fdtPayLimitDateAct (suscripc.susccodi)',       'PAYLIMITDATE',         CC_BOBOSSUTIL.CNUDATE,     SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBCOINTYPE,                                                           'COIN_TYPE',            CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);

        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fsbChargeAddress (suscripc.susccodi)',      'CHARGE_ADDRESS',       CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBCHARGENEIGHBORTHOOD,                                                'CHARGE_NEIGHBORTHOOD', CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBCHARGECITY,                                                         'CHARGE_CITY',          CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBCHARGESTATE,                                                        'CHARGE_STATE',         CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fsbChargeType(suscripc.susccodi)',          'susctdco',             CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fsbChargeAccountType(suscripc.susccodi)',   'susctcba',             CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fsbChargeBank(suscripc.susccodi)',          'suscbanc',             CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fsbChargeBranchOffice(suscripc.susccodi)',  'suscsuba',             CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fsbChargeBankAccount(suscripc.susccodi)',   'susccuco',             CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fsbChargeCardExpDate(suscripc.susccodi)',   'suscvetc',             CC_BOBOSSUTIL.CNUDATE,     SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);

        CC_BOBOSSUTIL.ADDATTRIBUTE (SBCARDTYPE,                                                           'CARD_TYPE',            CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);

        CC_BOBOSSUTIL.ADDATTRIBUTE (SBDEFBALANCE,                                                         'DEF_BALANCE',          CC_BOBOSSUTIL.CNUNUMBER,   SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);

        CC_BOBOSSUTIL.ADDATTRIBUTE (SBTOTALCUOTE,                                                         'TOTAL_CUOTE',          CC_BOBOSSUTIL.CNUNUMBER,   SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);

        CC_BOBOSSUTIL.ADDATTRIBUTE (SBSUBSCCOMPANY,                                                       'COMPANY',              CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);

        CC_BOBOSSUTIL.ADDATTRIBUTE ('suscripc.SUSCEFCE',                                                  'SUSCEFCE',             CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBIDENTTYPETT,                                                        'SUSCTITT',             CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('suscripc.SUSCIDTT',                                                  'SUSCIDTT',             CC_BOBOSSUTIL.CNUVARCHAR2, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);


        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_boBssSubscriptionData.fdtFinalDistDate(suscripc.susccodi)',       'FINAL_DIST_DATE',      CC_BOBOSSUTIL.CNUDATE,     SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);

        CC_BOBOSSUTIL.ADDATTRIBUTE (SBCOUNTBILLNOPAY,                                                     'count_bill_no_pay',    CC_BOBOSSUTIL.CNUNUMBER,   SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBCLAIMNOPAY,                                                         'claim_no_pay',         CC_BOBOSSUTIL.CNUNUMBER,   SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBDEPOSIT,                                                            'deposit',              CC_BOBOSSUTIL.CNUNUMBER,   SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBNOVDEBAUTINCLUSION,                                                 'NOVEFENO_REG',         CC_BOBOSSUTIL.CNUDATE,   SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBNOVDEBAUTEXCLUSION,                                                 'NOVEFENO_DEL',         CC_BOBOSSUTIL.CNUDATE,   SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBPUNISHVALUE,                                                        'punish_value',         CC_BOBOSSUTIL.CNUCURRENCY, SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);

        CC_BOBOSSUTIL.ADDATTRIBUTE (':parent_id',                                                         'PARENT_ID',            CC_BOBOSSUTIL.CNUNUMBER,   SBATTRIBUTES, TBSUBSCRIPTIONATTRIBUTES);

        SBSUBSCRIPTIONSQL := 'select '|| SBATTRIBUTES ||CHR(10)||'from suscripc';

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    PROCEDURE GETSUBSCRIPTIONS
    (
        ISBIDENTIFICATION   IN VARCHAR2,
        ISBNAME             IN VARCHAR2,
        ISBLASTNAME         IN VARCHAR2,
        ISBCONTACTPHONE     IN VARCHAR2,
        INUSUBSCRIPTION     IN NUMBER,
        ISBEMAIL            IN VARCHAR2,
        ISBADDRESSID        IN VARCHAR2,
        ISBSUBSCRIPTIONTYPE IN VARCHAR2,
        ISBADDRESSSTRING    IN VARCHAR2,
        ISBGEOGRAPLOCATION  IN VARCHAR2,
        OCUCURSOR           OUT CONSTANTS.TYREFCURSOR
    )
    IS

    SBIDENTIFICATION   VARCHAR2(500);
    SBNAME             VARCHAR2(500);
    SBLASTNAME         VARCHAR2(500);
    SBCONTACTPHONE     VARCHAR2(500);
    SBEMAIL            VARCHAR2(500);
    SBADDRESSID        VARCHAR2(500);
    SBSUBSCRIPTIONTYPE VARCHAR2(500);
    SBADDRESSSTRING    VARCHAR2(500);
    SBGEOGRAPLOCATION  VARCHAR2(500);

    SBWHERE   VARCHAR2(2000);
    SBSQL     VARCHAR2(8000);


    NUSUBSCRIPTION     NUMBER;

    BEGIN
        NUSUBSCRIPTION     := NVL(INUSUBSCRIPTION, CC_BOCONSTANTS.CNUAPPLICATIONNULL);
        SBIDENTIFICATION   := TRIM (UPPER (NVL (CC_BOBOSSUTIL.FSBFIXCRITERION (ISBIDENTIFICATION), CC_BOCONSTANTS.CSBNULLSTRING)));
        SBNAME             := TRIM (UPPER (NVL (CC_BOBOSSUTIL.FSBFIXCRITERION (ISBNAME),           CC_BOCONSTANTS.CSBNULLSTRING)));
        SBLASTNAME         := TRIM (UPPER (NVL (CC_BOBOSSUTIL.FSBFIXCRITERION (ISBLASTNAME),       CC_BOCONSTANTS.CSBNULLSTRING)));
        SBCONTACTPHONE     := TRIM (UPPER (NVL (CC_BOBOSSUTIL.FSBFIXCRITERION (ISBCONTACTPHONE),   CC_BOCONSTANTS.CSBNULLSTRING)));

        SBEMAIL            := TRIM (NVL (CC_BOBOSSUTIL.FSBFIXCRITERION (ISBEMAIL),            CC_BOCONSTANTS.CSBNULLSTRING));
        SBADDRESSID        := TRIM (NVL (CC_BOBOSSUTIL.FSBFIXCRITERION (ISBADDRESSID),        CC_BOCONSTANTS.CSBNULLSTRING));
        SBSUBSCRIPTIONTYPE := TRIM (NVL (CC_BOBOSSUTIL.FSBFIXCRITERION (ISBSUBSCRIPTIONTYPE), CC_BOCONSTANTS.CSBNULLSTRING));
        SBADDRESSSTRING    := TRIM (NVL (CC_BOBOSSUTIL.FSBFIXCRITERION (ISBADDRESSSTRING),    CC_BOCONSTANTS.CSBNULLSTRING));
        SBGEOGRAPLOCATION  := TRIM (NVL (CC_BOBOSSUTIL.FSBFIXCRITERION (ISBGEOGRAPLOCATION),  CC_BOCONSTANTS.CSBNULLSTRING));

        FILLSUBSCRIPTIONSATTRIBUTES;

        SBWHERE := NULL;

        IF NUSUBSCRIPTION != CC_BOCONSTANTS.CNUAPPLICATIONNULL THEN
            SBWHERE := SBWHERE ||'and suscripc.susccodi = :nuSubscription '|| CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :nuSubscription = '|| NUSUBSCRIPTION ||CHR(10);
        END IF;


        IF SBIDENTIFICATION != CC_BOCONSTANTS.CSBNULLSTRING THEN
            SBWHERE := SBWHERE ||'and a.identification like :sbIdentification '||'||'||CHR(39)||'%'||CHR(39)||CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :sbIdentification = '||CHR(39)|| SBIDENTIFICATION ||CHR(39)||CHR(10);
        END IF;

        IF SBNAME != CC_BOCONSTANTS.CSBNULLSTRING THEN
            SBWHERE := SBWHERE ||'and a.subscriber_name like :sbName '||'||'||CHR(39)||'%'||CHR(39)||CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :sbName = '||CHR(39)|| SBNAME ||CHR(39)||CHR(10);
        END IF;

        IF SBLASTNAME != CC_BOCONSTANTS.CSBNULLSTRING THEN
            SBWHERE := SBWHERE ||'and a.subs_last_name like :sbLastName '||'||'||CHR(39)||'%'||CHR(39)||CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :sbLastName = '||CHR(39)|| SBLASTNAME ||CHR(39)||CHR(10);
        END IF;

        IF SBCONTACTPHONE != CC_BOCONSTANTS.CSBNULLSTRING THEN
            SBWHERE := SBWHERE ||'and b.phone like :sbContactPhone '||'||'||CHR(39)||'%'||CHR(39)||CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :sbContactPhone = '||CHR(39)|| SBCONTACTPHONE ||CHR(39)||CHR(10);
        END IF;

        IF SBEMAIL != CC_BOCONSTANTS.CSBNULLSTRING THEN
            SBWHERE := SBWHERE ||'and a.e_mail like :sbEmail'||'||'||CHR(39)||'%'||CHR(39)||CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :sbEmail = '||CHR(39)|| SBEMAIL ||CHR(39)||CHR(10);
        END IF;

        IF SBADDRESSID != CC_BOCONSTANTS.CSBNULLSTRING THEN
            SBWHERE := SBWHERE ||'and suscripc.susciddi = :sbAddressId '||CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :sbAddressId = '||CHR(39)|| SBADDRESSID ||CHR(39)||CHR(10);
        END IF;

        IF SBSUBSCRIPTIONTYPE != CC_BOCONSTANTS.CSBNULLSTRING THEN
            SBWHERE := SBWHERE ||'and suscripc.susctisu = :sbSubscriptionType ' ||CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :sbSubscriptionType = '||CHR(39)|| SBSUBSCRIPTIONTYPE ||CHR(39)||CHR(10);
        END IF;

        IF ISBADDRESSSTRING != CC_BOCONSTANTS.CSBNULLSTRING AND ISBGEOGRAPLOCATION != CC_BOCONSTANTS.CSBNULLSTRING THEN
            SBWHERE := SBWHERE ||' and ab_address.geograp_location_id+0 = :sbGeograpLocation '||CHR(10);
            SBWHERE := SBWHERE ||' and ab_address.address_parsed like :sbAddressString '||'||'||CHR(39)||'%'||CHR(39)||CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :sbGeograpLocation = '||CHR(39)|| SBGEOGRAPLOCATION ||CHR(39)||CHR(10);
            SBWHERE := SBWHERE ||'and :sbAddressString = '||CHR(39)|| SBADDRESSSTRING ||CHR(39)||CHR(10);
        END IF;

        SBSQL := SBSUBSCRIPTIONSQL ||',ge_subscriber a,ge_subscriber b,ab_address'||CHR(10)||
                            'where ab_address.address_id = suscripc.susciddi AND '||CHR(10)||
                            'a.subscriber_id = suscripc.suscclie AND  b.subscriber_id (+) = a.contact_id ';

        IF SBWHERE IS NOT NULL THEN

            SBSQL := SBSQL ||CHR(10)|| SBWHERE;

        END IF;

        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, NUSUBSCRIPTION, SBIDENTIFICATION, SBNAME,
                                       SBLASTNAME, SBCONTACTPHONE, LOWER(SBEMAIL), SBADDRESSID, SBSUBSCRIPTIONTYPE,
                                       SBGEOGRAPLOCATION, SBADDRESSSTRING;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    PROCEDURE GETCONTRACTS
    (
        INUSUBSCRIPTION         IN SUSCRIPC.SUSCCODI%TYPE,
        ISBIDENTIFICATION       IN GE_SUBSCRIBER.IDENTIFICATION%TYPE,
        ISBNAME                 IN GE_SUBSCRIBER.SUBSCRIBER_NAME%TYPE,
        ISBLASTNAME             IN GE_SUBSCRIBER.SUBS_LAST_NAME%TYPE,
        ISBCONTACTPHONE         IN GE_SUBSCRIBER.PHONE%TYPE,
        ISBEMAIL                IN GE_SUBSCRIBER.E_MAIL%TYPE,
        INUGEOGRAPHLOCATIONID   IN AB_ADDRESS.GEOGRAP_LOCATION_ID%TYPE,
        INUNEIGHBORTHOODID      IN AB_ADDRESS.NEIGHBORTHOOD_ID%TYPE,
        ISBADDRESSSTRING        IN AB_ADDRESS.ADDRESS%TYPE,
        OCUCURSOR           OUT CONSTANTS.TYREFCURSOR
    )
    IS
    NUADDRESSID AB_ADDRESS.ADDRESS_ID%TYPE;
    SBADDRESS AB_ADDRESS.ADDRESS%TYPE:=NULL;
    NUERROR GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
    SBERRORS GE_ERROR_LOG.DESCRIPTION%TYPE;
    BEGIN

        IF (INUGEOGRAPHLOCATIONID IS NULL AND ISBADDRESSSTRING IS NOT NULL) THEN
             GE_BOERRORS.SETERRORCODE(399);

        END IF;


        IF (INUGEOGRAPHLOCATIONID IS NOT NULL AND ISBADDRESSSTRING IS  NULL) THEN
             GE_BOERRORS.SETERRORCODE(403);
        END IF;


        IF (ISBADDRESSSTRING IS NOT NULL AND
            INUGEOGRAPHLOCATIONID IS NOT NULL AND INSTR(ISBADDRESSSTRING,CHR(37))<=0
            ) THEN
                                UT_TRACE.TRACE(ISBADDRESSSTRING);
            NUADDRESSID := AB_BOADDRESSPARSER.CHECKIFADDRESSEXISTSINDB
            (
                ISBADDRESSSTRING,
                INUGEOGRAPHLOCATIONID,
                NUERROR,
                SBERRORS
            );

            IF (NUADDRESSID=-1) THEN
                GE_BOERRORS.SETERRORCODE(70);
            END IF;
            UT_JAVA.VALIDATEERROR(NUERROR, SBERRORS);
        ELSE

            SBADDRESS:= ISBADDRESSSTRING;
        END IF;

        GETSUBSCRIPTIONS
        (
            ISBIDENTIFICATION,
            ISBNAME,
            ISBLASTNAME,
            ISBCONTACTPHONE,
            INUSUBSCRIPTION,
            ISBEMAIL,
            TO_CHAR(NUADDRESSID),
            NULL,
            SBADDRESS,
            TO_CHAR(INUGEOGRAPHLOCATIONID),
            OCUCURSOR
        );

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN

            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN

            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    PROCEDURE GETCONTRACTSWHITVALADD
    (
        INUSUBSCRIPTION         IN SUSCRIPC.SUSCCODI%TYPE,
        ISBIDENTIFICATION       IN GE_SUBSCRIBER.IDENTIFICATION%TYPE,
        ISBNAME                 IN GE_SUBSCRIBER.SUBSCRIBER_NAME%TYPE,
        ISBLASTNAME             IN GE_SUBSCRIBER.SUBS_LAST_NAME%TYPE,
        ISBCONTACTPHONE         IN GE_SUBSCRIBER.PHONE%TYPE,
        ISBEMAIL                IN GE_SUBSCRIBER.E_MAIL%TYPE,
        INUGEOGRAPHLOCATIONID   IN AB_ADDRESS.GEOGRAP_LOCATION_ID%TYPE,
        ISBADDRESSSTRING        IN AB_ADDRESS.ADDRESS%TYPE,
        OCUCURSOR               OUT CONSTANTS.TYREFCURSOR
    )
    IS
        NUADDRESSID AB_ADDRESS.ADDRESS_ID%TYPE;
        SBADDRESS AB_ADDRESS.ADDRESS%TYPE := NULL;
        NUERROR GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
        SBERRORS GE_ERROR_LOG.DESCRIPTION%TYPE;

        SBIDENTIFICATION   VARCHAR2(500);
        SBNAME             VARCHAR2(500);
        SBLASTNAME         VARCHAR2(500);
        SBCONTACTPHONE     VARCHAR2(500);
        SBEMAIL            VARCHAR2(500);
        SBADDRESSID        VARCHAR2(500);
        SBADDRESSSTRING    VARCHAR2(500);
        SBGEOGRAPLOCATION  VARCHAR2(500);

        SBWHERE   VARCHAR2(2000);
        SBSQL     VARCHAR2(8000);


        NUSUBSCRIPTION     NUMBER;

    BEGIN

        IF (INUGEOGRAPHLOCATIONID IS NULL AND ISBADDRESSSTRING IS NOT NULL) THEN
             GE_BOERRORS.SETERRORCODE(399);

        END IF;


        IF (INUGEOGRAPHLOCATIONID IS NOT NULL AND ISBADDRESSSTRING IS  NULL) THEN
             GE_BOERRORS.SETERRORCODE(403);
        END IF;


        IF (ISBADDRESSSTRING IS NOT NULL AND
            INUGEOGRAPHLOCATIONID IS NOT NULL AND
            INSTR(ISBADDRESSSTRING,CHR(37))<=0
            ) THEN
            NUADDRESSID := AB_BOADDRESSPARSER.CHECKIFADDRESSEXISTSINDB
            (
                ISBADDRESSSTRING,
                INUGEOGRAPHLOCATIONID,
                NUERROR,
                SBERRORS
            );

            IF (NUADDRESSID=-1) THEN
                GE_BOERRORS.SETERRORCODE(70);
            END IF;
            UT_JAVA.VALIDATEERROR(NUERROR, SBERRORS);
        ELSE
            SBADDRESS:= ISBADDRESSSTRING;
        END IF;

        NUSUBSCRIPTION     := NVL(INUSUBSCRIPTION, CC_BOCONSTANTS.CNUAPPLICATIONNULL);
        SBIDENTIFICATION   := TRIM (UPPER (NVL (CC_BOBOSSUTIL.FSBFIXCRITERION (ISBIDENTIFICATION),  CC_BOCONSTANTS.CSBNULLSTRING)));
        SBNAME             := TRIM (UPPER (NVL (CC_BOBOSSUTIL.FSBFIXCRITERION (ISBNAME),            CC_BOCONSTANTS.CSBNULLSTRING)));
        SBLASTNAME         := TRIM (UPPER (NVL (CC_BOBOSSUTIL.FSBFIXCRITERION (ISBLASTNAME),        CC_BOCONSTANTS.CSBNULLSTRING)));
        SBCONTACTPHONE     := TRIM (UPPER (NVL (CC_BOBOSSUTIL.FSBFIXCRITERION (ISBCONTACTPHONE),    CC_BOCONSTANTS.CSBNULLSTRING)));

        SBEMAIL            := TRIM (NVL (CC_BOBOSSUTIL.FSBFIXCRITERION (ISBEMAIL),                  CC_BOCONSTANTS.CSBNULLSTRING));
        SBADDRESSID        := TRIM (NVL (CC_BOBOSSUTIL.FSBFIXCRITERION (TO_CHAR(NUADDRESSID)), CC_BOCONSTANTS.CSBNULLSTRING));
        SBADDRESSSTRING    := TRIM (NVL (CC_BOBOSSUTIL.FSBFIXCRITERION (SBADDRESS),                 CC_BOCONSTANTS.CSBNULLSTRING));
        SBGEOGRAPLOCATION  := TRIM (NVL(CC_BOBOSSUTIL.FSBFIXCRITERION(TO_CHAR(INUGEOGRAPHLOCATIONID)), CC_BOCONSTANTS.CSBNULLSTRING));

        FILLSUBSCRIPTIONSATTRIBUTES;

        SBWHERE := NULL;

        IF NUSUBSCRIPTION != CC_BOCONSTANTS.CNUAPPLICATIONNULL THEN
            SBWHERE := SBWHERE ||'and suscripc.susccodi = :nuSubscription '|| CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :nuSubscription = '|| NUSUBSCRIPTION ||CHR(10);
        END IF;


        IF SBIDENTIFICATION != CC_BOCONSTANTS.CSBNULLSTRING THEN
            SBWHERE := SBWHERE ||'and a.identification like :sbIdentification '||'||'||CHR(39)||'%'||CHR(39)||CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :sbIdentification = '||CHR(39)|| SBIDENTIFICATION ||CHR(39)||CHR(10);
        END IF;

        IF SBNAME != CC_BOCONSTANTS.CSBNULLSTRING THEN
            SBWHERE := SBWHERE ||'and a.subscriber_name like :sbName '||'||'||CHR(39)||'%'||CHR(39)||CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :sbName = '||CHR(39)|| SBNAME ||CHR(39)||CHR(10);
        END IF;

        IF SBLASTNAME != CC_BOCONSTANTS.CSBNULLSTRING THEN
            SBWHERE := SBWHERE ||'and a.subs_last_name like :sbLastName '||'||'||CHR(39)||'%'||CHR(39)||CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :sbLastName = '||CHR(39)|| SBLASTNAME ||CHR(39)||CHR(10);
        END IF;

        IF SBCONTACTPHONE != CC_BOCONSTANTS.CSBNULLSTRING THEN
            SBWHERE := SBWHERE ||'and b.phone like :sbContactPhone '||'||'||CHR(39)||'%'||CHR(39)||CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :sbContactPhone = '||CHR(39)|| SBCONTACTPHONE ||CHR(39)||CHR(10);
        END IF;

        IF SBEMAIL != CC_BOCONSTANTS.CSBNULLSTRING THEN
            SBWHERE := SBWHERE ||'and a.e_mail like :sbEmail'||'||'||CHR(39)||'%'||CHR(39)||CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :sbEmail = '||CHR(39)|| SBEMAIL ||CHR(39)||CHR(10);
        END IF;

        IF SBADDRESSID != CC_BOCONSTANTS.CSBNULLSTRING THEN
            SBWHERE := SBWHERE ||'and suscripc.susciddi = :sbAddressId '||CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :sbAddressId = '||CHR(39)|| SBADDRESSID ||CHR(39)||CHR(10);
        END IF;

        IF SBADDRESS != CC_BOCONSTANTS.CSBNULLSTRING AND INUGEOGRAPHLOCATIONID != CC_BOCONSTANTS.CSBNULLSTRING THEN
            SBWHERE := SBWHERE ||' and ab_address.geograp_location_id+0 = :sbGeograpLocation '||CHR(10);
            SBWHERE := SBWHERE ||' and ab_address.address_parsed like :sbAddressString '||'||'||CHR(39)||'%'||CHR(39)||CHR(10);
        ELSE
            SBWHERE := SBWHERE ||'and :sbGeograpLocation = '||CHR(39)|| SBGEOGRAPLOCATION ||CHR(39)||CHR(10);
            SBWHERE := SBWHERE ||'and :sbAddressString = '||CHR(39)|| SBADDRESSSTRING ||CHR(39)||CHR(10);
        END IF;

        SBSQL := SBSUBSCRIPTIONSQL ||',ge_subscriber a,ge_subscriber b,ab_address,ab_premise,ab_segments,or_route'||CHR(10)||
                            'where a.subscriber_id = suscripc.suscclie '||CHR(10)||
                            'and  b.subscriber_id (+) = a.contact_id ' ||CHR(10)||
                            'and ab_address.address_id = suscripc.susciddi ' ||CHR(10)||
                            'and ab_address.segment_id = ab_segments.segments_id '||CHR(10)||
                            'and or_route.route_id = ab_segments.route_id '||CHR(10)||
                            'and ab_address.estate_number = ab_premise.premise_id ';

        IF SBWHERE IS NOT NULL THEN

            SBSQL := SBSQL ||CHR(10)|| SBWHERE;

        END IF;

        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, NUSUBSCRIPTION, SBIDENTIFICATION, SBNAME,
                                       SBLASTNAME, SBCONTACTPHONE, LOWER(SBEMAIL), SBADDRESSID,
                                       SBGEOGRAPLOCATION, SBADDRESSSTRING;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END GETCONTRACTSWHITVALADD;


    PROCEDURE GETSUBSCRIBERSUBSCRIPTIONS
    (
        INUSUBSCRIBER IN NUMBER,
        OCUCURSOR     OUT CONSTANTS.TYREFCURSOR
    )
    IS

    SBSQL VARCHAR2(8000);

    BEGIN
        FILLSUBSCRIPTIONSATTRIBUTES;

        IF INUSUBSCRIBER = 0 THEN
            SBSQL := SBSUBSCRIPTIONSQL ||CHR(10)|| 'where suscripc.suscclie != suscripc.suscclie';

            OPEN OCUCURSOR FOR SBSQL USING INUSUBSCRIBER;
        ELSE
            SBSQL := SBSUBSCRIPTIONSQL ||CHR(10)|| 'where suscripc.suscclie = :Subscriber';

            OPEN OCUCURSOR FOR SBSQL USING INUSUBSCRIBER, INUSUBSCRIBER;
        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    PROCEDURE GETSUBSCRIPTION
    (
        INUSUBSCRIPTION IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS

    SBSQL VARCHAR2(8000);

    BEGIN
        FILLSUBSCRIPTIONSATTRIBUTES;

        SBSQL := SBSUBSCRIPTIONSQL ||CHR(10)|| 'where susccodi = :Subscription';

        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INUSUBSCRIPTION;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;




    PROCEDURE GETCONTRACTWHITVALADD
    (
        INUSUBSCRIPTION IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS

    SBSQL VARCHAR2(8000);

    BEGIN
        FILLSUBSCRIPTIONSATTRIBUTES;

        SBSQL := SBSUBSCRIPTIONSQL || ',or_route,ab_segments,ab_premise,ab_address '||CHR(10)||
         'where '||CHR(10)||
         'susccodi = :Subscription' ||CHR(10)||
         'and ab_address.address_id = suscripc.susciddi '||CHR(10)||
         'and ab_address.segment_id = ab_segments.segments_id '||CHR(10)||
         'and or_route.route_id = ab_segments.route_id '||CHR(10)||
         'and ab_address.estate_number = ab_premise.premise_id';

        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INUSUBSCRIPTION;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCONTRACTWHITVALADD;




    PROCEDURE GETSUBSCRIPTIONFROMROUTE
    (
        INUADDRESSID IN  AB_ADDRESS.ADDRESS_ID%TYPE,
        OCUCURSOR     OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQL VARCHAR2(8000);
    BEGIN

        FILLSUBSCRIPTIONSATTRIBUTES;
        SBSQL := SBSUBSCRIPTIONSQL || ',or_route,ab_segments,ab_premise,ab_address '||CHR(10)||
                 'where '||CHR(10)||
                 'suscripc.susciddi = :nuAddressId '||CHR(10)||
                 'and ab_address.address_id = suscripc.susciddi '||CHR(10)||
                 'and ab_address.segment_id = ab_segments.segments_id '||CHR(10)||
                 'and or_route.route_id = ab_segments.route_id '||CHR(10)||
                 'and ab_address.estate_number = ab_premise.premise_id';

        OPEN OCUCURSOR FOR SBSQL USING INUADDRESSID, INUADDRESSID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    PROCEDURE GETPACKAGES
    (
        INUSUBSCRIPTION IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS

    SBSQL     VARCHAR2(32767);
    SBPACKAGEHINTS    VARCHAR2(6000);

    BEGIN
        CC_BOOSSPACKAGE.FILLPACKAGEATTRIBUTES;

        SBPACKAGEHINTS :=  '/*+ leading (mo_motive) use_nl(mo_motive a)'                        ||CHR(10)||
                            'use_nl(a b) use_nl(a c) use_nl(a e) use_nl(a f)'                   ||CHR(10)||
                            'use_nl(a g) use_nl(a r) use_nl(r s) use_nl(a k)'                   ||CHR(10)||
                            'use_nl(a l) use_nl(a m) use_nl(a n) use_nl(a o)'                   ||CHR(10)||
                            'use_nl(a p) use_nl(a q) use_nl(s u)' ||CHR(10)||
                            'index (mo_motive IDX_MO_MOTIVE_03) index (a PK_MO_PACKAGES)'       ||CHR(10)||
                            'index (f PK_GE_PERSON) index (g PK_GE_ORGANIZAT_AREA)'             ||CHR(10)||
                            'index (r PK_GE_SUBSCRIBER) index (s PK_AB_ADDRESS)'                ||CHR(10)||
                            'index (k PK_OR_OPERATING_UNIT) index (l PK_PM_PROJECT)'            ||CHR(10)||
                            'index (o PK_GE_SUBSCRIBER) index (p PK_AB_ADDRESS) index (u PK_GE_GEOGRA_LOCATION)*/';

            SBSQL := 'SELECT '|| SBPACKAGEHINTS                                             ||CHR(10)||
                                 CC_BOOSSPACKAGE.SBPACKAGEATTRIBUTES                        ||CHR(10)||
                     'FROM '  || CC_BOOSSPACKAGE.SBPACKAGEFROM ||', mo_motive '             ||CHR(10)||
                     'WHERE ' || 'mo_motive.subscription_id = :Subscription'                ||CHR(10)||
                     'AND '   || 'mo_motive.package_id = a.package_id'                      ||CHR(10)||
                     'AND '   || CC_BOOSSPACKAGE.SBPACKAGEWHERE                             ||CHR(10)||
               'order by 1 desc';

        OPEN OCUCURSOR FOR SBSQL USING INUSUBSCRIPTION, INUSUBSCRIPTION;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;





    PROCEDURE GETCOMPLAINTS
    (
        INUSUBSCRIPTION IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQL   VARCHAR2(32767);
        SBHINTS VARCHAR2(4000);
    BEGIN
        UT_TRACE.TRACE('Inicio: cc_boOssSubscriber.GetComplaints', 1);

        CC_BOOSSCOMPLAINT.FILLCOMPLAINTATTRIBUTES;

        SBHINTS := 'leading (e)'                        ||CHR(10)||
                   'use_nl(e a) use_nl(e n) use_nl(e p) use_nl(a b) use_nl(a c) '||CHR(10)||
                   'use_nl(a f) use_nl(a g) use_nl(a h) use_nl(a i) use_nl(a j) '||CHR(10)||
                   'use_nl(a o) use_nl(a q) use_nl(a r) use_nl(c d) use_nl(e m)'||CHR(10)||
                   'use_nl(a k) use_nl(a l) use_nl(r loc) use_nl(r neig)'       ||CHR(10)||
                   'index(e IDX_MO_MOTIVE_03)'          ||CHR(10)||
                   'index(a pk_mo_packages)'            ||CHR(10)||
                   'index(b pk_ge_subscriber)'          ||CHR(10)||
                   'index(c pk_ge_subscriber)'          ||CHR(10)||
                   'index(g pk_OR_operating_unit)'      ||CHR(10)||
                   'index(i pk_ge_distribut_admin)'     ||CHR(10)||
                   'index(j pk_ge_distribut_admin)'     ||CHR(10)||
                   'index(k pk_ge_organizat_area)'      ||CHR(10)||
                   'index(n pk_cc_causal)'              ||CHR(10)||
                   'index(p pk_ge_person)'              ||CHR(10)||
                   'index(r pk_ab_address)'             ||CHR(10)||
                   'index(loc pk_ge_geogra_location)'   ||CHR(10)||
                   'index(neig pk_ge_geogra_location)'  ;

        SBSQL := 'SELECT /*+ '||SBHINTS||' */'                  ||CHR(10)||
                             CC_BOOSSCOMPLAINT.SBCOMPATTRIBUTES ||CHR(10)||
                 '  FROM /*+ cc_boOssSubscription.GetComplaints */' ||CHR(10)||
                             CC_BOOSSCOMPLAINT.SBCOMPFROM       ||CHR(10)||
                 ' WHERE e.subscription_id = :inuSubscription'  ||CHR(10)||
                 '   AND '||CC_BOOSSCOMPLAINT.SBCOMPWHERE;

        OPEN OCUCURSOR FOR SBSQL USING INUSUBSCRIPTION, INUSUBSCRIPTION;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCOMPLAINTS;


    PROCEDURE GETCLAIMS
    (
        INUSUBSCRIPTION IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS

    SBSQL   VARCHAR2(32767);

    BEGIN

        CC_BOBSSCLAIM.FILLCLAIMATTRIBUTES;

        SBSQL :=      CC_BOBSSCLAIM.SBCLAIMSQL
        ||CHR(10)||   ' AND mo_packages.PACKAGE_id in ( '
        ||CHR(10)||   ' SELECT PACKAGE_id FROM mo_motive WHERE motive_id in ('
        ||CHR(10)||   ' SELECT catrmoti FROM cargtram, servsusc WHERE catrnuse = sesunuse AND sesususc = :Subscription))';


        OPEN OCUCURSOR FOR SBSQL USING INUSUBSCRIPTION, INUSUBSCRIPTION;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;




    PROCEDURE GETBILL
    (
        INUSUBSCRIPTION IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS

    SBSQL VARCHAR2(2000);

    BEGIN
        CC_BOBSSBILL.FILLBILLATTRIBUTES;

        SBSQL := CC_BOBSSBILL.SBBILLSQL ||CHR(10)|| 'and factura.factsusc = :Subscription';

        OPEN OCUCURSOR FOR SBSQL USING INUSUBSCRIPTION, INUSUBSCRIPTION;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;



    PROCEDURE GETBILLACCOUNT
    (
        INUSUBSCRIPTION IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS

    SBSQL VARCHAR2(2000);

    BEGIN
        CC_BOBSSBILLACCOUNT.FILLBILLACCOUNTATTRIBUTES;

        SBSQL := CC_BOBSSBILLACCOUNT.SBBILLACCOUNTSQL ||CHR(10)|| 'and factura.factsusc = :Subscription';

        OPEN OCUCURSOR FOR SBSQL USING INUSUBSCRIPTION, INUSUBSCRIPTION;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;



    PROCEDURE GETPAYMENT
    (
        INUSUBSCRIPTION IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS

    SBSQL  VARCHAR2(1000);

    BEGIN

        UT_TRACE.TRACE('Inicio cc_boOssSubscription.GetPayment',10);
        ldc_boPayment.FILLPAYMENTATTRIBUTES;

        SBSQL := 'select /*+ leading (vwrc_payments) index(vwrc_payments.pagos_norm IX_PAGO_SUSC)
            use_nl_with_index(cupon pk_cupon)
            use_nl_with_index(banco pk_banco)
            use_nl_with_index(sucubanc pk_sucubanc)*/'|| ldc_boPayment.SBPAYMENTATTRIBUTES ||CHR(10)||
                   'from '|| ldc_boPayment.SBPAYMENTFROM       ||CHR(10)||
                  'where '|| ldc_boPayment.SBPAYMENTWHERE      ||CHR(10)||
                    'and pagosusc = :Subscription';

        TD(SBSQL);
        TD('suscripcion: ' || INUSUBSCRIPTION);
        UT_TRACE.TRACE('Sentencia: ' || SBSQL,10);
        UT_TRACE.TRACE('suscripcion: '|| INUSUBSCRIPTION,10);
        UT_TRACE.TRACE('End cc_boOssSubscription.GetPayment',10);

        OPEN OCUCURSOR FOR SBSQL USING INUSUBSCRIPTION, INUSUBSCRIPTION;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    PROCEDURE GETATTACHFILES
    (
            INUCONTRACT         IN   SUSCRIPC.SUSCCODI%TYPE,
            OCUATTACHFILES      OUT  CONSTANTS.TYREFCURSOR
    )
    IS
        SBLEVEL            CC_FILE.OBJECT_LEVEL%TYPE := 'CONTRACT';
    BEGIN
        UT_TRACE.TRACE('Iniciando cc_boOssSubscription.GetAttachFiles Contrato ['||INUCONTRACT||']', 5);

        CC_BOOSSATTACHFILES.GETATTACHEDFILES(SBLEVEL,INUCONTRACT,OCUATTACHFILES);

        UT_TRACE.TRACE('Fin cc_boOssSubscription.GetAttachFiles ', 5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETATTACHFILES;

    PROCEDURE GETBUNDLED
    (
        INUCONTRACT IN SUSCRIPC.SUSCCODI%TYPE,
        OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
    )
    IS
    SBSQL     VARCHAR2(32767);

    BEGIN
        UT_TRACE.TRACE('Iniciando cc_boOssSubscription.GetBundled Contrato['||INUCONTRACT||']', 5);

        CC_BOOSSBUNDLED.FILLBUNDLEDATTRIBUTES;

        SBSQL  :=   ' SELECT '|| CC_BOOSSBUNDLED.SBBUNDLEDATTRIBUTES || CHR(10) ||
                     ' FROM    cc_bundled'  || CHR(10) ||
                     ' WHERE cc_bundled.subscription_id = :inuContract';

        OPEN OCUCURSOR FOR SBSQL USING INUCONTRACT, INUCONTRACT;

        UT_TRACE.TRACE('Fin de cc_boOssSubscription.GetBundled ', 5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    PROCEDURE GETPROMOTIONS
    (
        INUCONTRACT IN SUSCRIPC.SUSCCODI%TYPE,
        OCUCURSOR    OUT CONSTANTS.TYREFCURSOR
    )
    IS

    SBSQL     VARCHAR2(4000);
    SBHINT      VARCHAR2(4000);

    BEGIN
        UT_TRACE.TRACE('Iniciando cc_boOssSubscription.GetPromotions inuContract['||INUCONTRACT||']', 5);

        CC_BOOSSPROMOTION.FILLPROMOTIONATTRIBUTES;

        SBHINT :=  '/*+ leading (pr_product)
                    use_nl (pr_product pr_promotion)
                    use_nl (pr_promotion cc_promotion)
                    use_nl (pr_promotion pr_component)
                    use_nl (pr_product servicio)
                    use_nl (pr_component ps_component_type)
                    use_nl (pr_component ps_class_service) */ ';

        SBSQL :=
             'SELECT '||SBHINT|| CC_BOOSSPROMOTION.SBPROMOTIONATTRIBUTES ||CHR(10)||
             '  FROM PR_PROMOTION, CC_PROMOTION,PR_PRODUCT, SERVICIO, PR_COMPONENT, PS_COMPONENT_TYPE, PS_CLASS_SERVICE /*+ cc_boOssSubscription.GetPromotions */'   ||CHR(10)||
             ' WHERE pr_product.subscription_id = :inuContract '                                                            ||CHR(10)||
             '  AND  pr_promotion.product_id = pr_product.product_id '                                                      ||CHR(10)||
             '  AND  pr_promotion.asso_promotion_id = cc_promotion.promotion_id '                                           ||CHR(10)||
             '  AND  pr_promotion.component_id = pr_component.component_id (+)'                                             ||CHR(10)||
             '  AND  cc_promotion.product_type_id = servicio.servcodi '                                                   ||CHR(10)||
             '  AND  pr_component.component_type_id = ps_component_type.component_type_id (+) '                         ||CHR(10)||
             '  AND  pr_component.class_service_id = ps_class_service.class_service_id (+)';

        OPEN OCUCURSOR FOR SBSQL USING INUCONTRACT, INUCONTRACT;

        UT_TRACE.TRACE('Fin de cc_boOssSubscription.GetPromotions ', 5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

BEGIN
    SBSUBSCRIPTIONSQL := NULL;
END ldc_boSubscription;
/
PROMPT Otorgando permisos de ejecucion a LDC_BOSUBSCRIPTION
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BOSUBSCRIPTION', 'ADM_PERSON');
END;
/