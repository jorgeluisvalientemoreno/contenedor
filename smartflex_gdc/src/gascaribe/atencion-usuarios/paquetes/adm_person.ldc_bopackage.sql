CREATE OR REPLACE PACKAGE adm_person.ldc_boPackage AS
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
    ****************************************************************/   

    SBCLAIMSQL          VARCHAR2(32767);

    SBPACKAGEATTRIBUTES VARCHAR2(32767);
    SBPACKAGEFROM       VARCHAR2(6000);
    SBPACKAGEWHERE      VARCHAR2(6000);

    SBMOTIVEATTRIBUTES  VARCHAR2(6000);
    SBMOTIVEHINTS       VARCHAR2(6000);
    SBMOTIVEFROM        VARCHAR2(6000);
    SBMOTIVEWHERE       VARCHAR2(6000);

    CSBREQUEST          VARCHAR2(20)    := 'REQUEST';


    FUNCTION FSBVERSION RETURN VARCHAR2;


    PROCEDURE FILLPACKAGEATTRIBUTES;


    PROCEDURE GETSUBSCRIBER
    (
        INUPACKAGE    IN NUMBER,
        ONUSUBSCRIBER OUT NUMBER
    );

    PROCEDURE GETPACKAGES
    (
        INUPACKAGE          IN MO_PACKAGES.PACKAGE_ID%TYPE,
        INUBEFOREDAYS       IN GE_CALENDAR.DAY_TYPE_ID%TYPE,
        INUBEFOREMONTHS     IN GE_CALENDAR.DAY_TYPE_ID%TYPE,
        IDTINITIALDATE      IN MO_PACKAGES.REQUEST_DATE%TYPE,
        IDTFINALDATE        IN MO_PACKAGES.REQUEST_DATE%TYPE,
        INUPACKAGETYPE      IN MO_PACKAGES.PACKAGE_TYPE_ID%TYPE DEFAULT NULL,
        INUPRODUCTTYPE      IN PR_PRODUCT.PRODUCT_TYPE_ID%TYPE DEFAULT NULL,
        INUMOTIVESTATUS     IN MO_PACKAGES.MOTIVE_STATUS_ID%TYPE DEFAULT NULL,
        INUPERSONID         IN MO_PACKAGES.PERSON_ID%TYPE,
        INUUSERID           IN SA_USER.USER_ID%TYPE,
        INUSALECHANNELID    IN MO_PACKAGES.SALE_CHANNEL_ID%TYPE,
        ISBRESTRICTION      IN VARCHAR2,
        INUCUSTREQUESTNUM   IN MO_PACKAGES.CUST_CARE_REQUES_NUM%TYPE,
        INUFORMNUMBER       IN FA_HISTCODI.HICDNUME%TYPE,
        INUVOUCHERTYPE      IN FA_HISTCODI.HICDTICO%TYPE,
        OCUCURSOR           OUT CONSTANTS.TYREFCURSOR
    );


    PROCEDURE GETPACKAGE
    (
        INUPACKAGE IN NUMBER,
        OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
    );



    PROCEDURE GETMOTIVES
    (
        INUPACKAGE IN NUMBER,
        OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
    );



    PROCEDURE GETCOUPONS
    (
        INUPACKAGE IN NUMBER,
        OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
    );



    PROCEDURE GETPAYMENTS
    (
        INUPACKAGE IN NUMBER,
        OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
    );


    PROCEDURE GETCOMMENTS
    (
        INUPACKAGE IN NUMBER,
        OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
    );


    PROCEDURE GETMOTIVESBYADDRESS
    (
        INUADDRESSID   IN AB_ADDRESS.ADDRESS_ID%TYPE,
        OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
    );




    PROCEDURE GETRESTRICTIONS
    (
        INUPACKAGEID        IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        OCUDATACURSOR       OUT CONSTANTS.TYREFCURSOR
    );




    PROCEDURE GETASSOMOTIVES
    (
        INUPACKAGEID  IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
    );





    PROCEDURE GETATTACHFILES
    (
        INUPACKAGE          IN   MO_PACKAGES.PACKAGE_ID%TYPE,
        OCUATTACHFILES      OUT  CONSTANTS.TYREFCURSOR
    );




    PROCEDURE GETRESTRICTIONBYID
    (
        INURESTRICTIONID    IN  MO_RESTRICTION.RESTRICTION_ID%TYPE,
        OCUDATACURSOR       OUT CONSTANTS.TYREFCURSOR
    );



    PROCEDURE GETPACKBYRESTRICTION
    (
        INURESTRICTIONID    IN  MO_RESTRICTION.RESTRICTION_ID%TYPE,
        ONUPACKAGEID        OUT MO_PACKAGES.PACKAGE_ID%TYPE
    );



    PROCEDURE FILLMOTIVEATTRIBUTES;


    PROCEDURE GETNOTIFICATIONS
    (
        INUPACKAGEID  IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
    );

    PROCEDURE GETADMINACTIVITIES
    (
        INUPACKAGEID  IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
    );





    FUNCTION FRFGETDATESADDITIONALS
    RETURN CONSTANTS.TYREFCURSOR;





    PROCEDURE GETPROMOTIONS
    (
        INUPACKAGE   IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        ORFCURSOR    OUT CONSTANTS.TYREFCURSOR
    );

    PROCEDURE GETAPPRAMOUNREQUQUERY
    (
        OSBSQLHINTS                 OUT         VARCHAR2,
        OSBSQLQUERY                 OUT         VARCHAR2
    );

    PROCEDURE FINDAPPRAMOUNREQUEST
    (
        INUSUBSCRIPTIONID           IN          MO_MOTIVE.SUBSCRIPTION_ID%TYPE,
        INUPACKAGE_ID               IN          MO_PACKAGES.PACKAGE_ID%TYPE,
        INUINTERACTION              IN          MO_PACKAGES.CUST_CARE_REQUES_NUM%TYPE,
        ISBIDENTIFICATION           IN          GE_SUBSCRIBER.IDENTIFICATION%TYPE,
        ISBNAME                     IN          GE_SUBSCRIBER.SUBSCRIBER_NAME%TYPE,
        ISBLASTNAME                 IN          GE_SUBSCRIBER.SUBS_LAST_NAME%TYPE,
        IDTINITIALDATE              IN          MO_PACKAGES.REQUEST_DATE%TYPE,
        IDTFINALDATE                IN          MO_PACKAGES.REQUEST_DATE%TYPE,
        INUPACKAGESTATUSID          IN          MO_PACKAGES.MOTIVE_STATUS_ID%TYPE,
        IDTINICIEXPECATTEND         IN          MO_PACKAGES.EXPECT_ATTEN_DATE%TYPE,
        IDTFINALEXPECATTEND         IN          MO_PACKAGES.EXPECT_ATTEN_DATE%TYPE,
        OCUCURSOR                   OUT         CONSTANTS.TYREFCURSOR
    );

    PROCEDURE SEARCHAPPRAMOUNREQUEST
    (
        INUPACKAGE_ID               IN          MO_PACKAGES.PACKAGE_ID%TYPE,
        OCUCURSOR                   OUT         CONSTANTS.TYREFCURSOR
    );

    PROCEDURE FINDAPPRAMOUNREQBYSUS
    (
        INUSUBSCRIPTIONID           IN          MO_MOTIVE.SUBSCRIPTION_ID%TYPE,
        OCUCURSOR                   OUT         CONSTANTS.TYREFCURSOR
    );





    PROCEDURE GETNTLREQUEST
    (
        INUNTLID      IN NUMBER,
        OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
    );




    PROCEDURE GETSUBSCRIBERREQUEST
    (
        INUSUBSCRIBER IN NUMBER,
        OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
    );






    FUNCTION FRFGETDATACLAIM
    RETURN CONSTANTS.TYREFCURSOR;






    FUNCTION FRFGETADDDATAREQUEST
    RETURN CONSTANTS.TYREFCURSOR;





    PROCEDURE GETREVIEWPACKAGE
    (
        INUPACKAGEID    IN  NUMBER,
        ORFCURSOR       OUT CONSTANTS.TYREFCURSOR
    );





    PROCEDURE GETREVIEWPACKAGES
    (
        INUPACKAGEID        IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        INUCUSTREQUESTNUM   IN  MO_PACKAGES.CUST_CARE_REQUES_NUM%TYPE,
        ISBSERVICENUMBER    IN  PR_PRODUCT.SERVICE_NUMBER%TYPE,
        OCUCURSOR           OUT CONSTANTS.TYREFCURSOR
    );





    PROCEDURE GETPRODUCTREQUEST
    (
        INUPRODUCTID    IN NUMBER,
        OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
    );





    PROCEDURE GETPRODUCT
    (
        INUPACKAGEID    IN NUMBER,
        ONUPRODUCTID    OUT NUMBER
    );
END ldc_boPackage;
/
CREATE OR REPLACE PACKAGE BODY adm_person.ldc_boPackage AS



    CSBVERSION  CONSTANT VARCHAR2(250)  := 'SAO200010';


    CNUREQUESTADDRTYPE CONSTANT NUMBER := GE_BOPARAMETER.FNUGET('REGISTER_ADDRESS_TYP');

    CNURESPONSEADDRTYPE CONSTANT NUMBER := GE_BOPARAMETER.FNUGET('RETURN_ADDRESS_TYPE');



    CNUENTITY_PACKAGE       CONSTANT NUMBER := DAGE_PARAMETER.FSBGETVALUE(MO_BOCONSTANTS.CSBENTITY_PACKAGES);

    CNUENTITY_MOTIVE        CONSTANT NUMBER := DAGE_PARAMETER.FSBGETVALUE(MO_BOCONSTANTS.CSBENTITY_MOTIVE);

    CNUENTITY_COMPONENT     CONSTANT NUMBER := DAGE_PARAMETER.FSBGETVALUE(MO_BOCONSTANTS.CSBENTITY_COMPONENT);



    CSBYES  VARCHAR2(1);

    SBADDRESSPREMISEATTRIBUTES      VARCHAR2(4000);
    SBRESTRICTIONATTRIBUTES         VARCHAR2(4000);
    SBASSOMOTIVESATT                VARCHAR2(4000);

    TBADDRESSPREMISEATTRIBUTES      CC_TYTBATTRIBUTE;
    TBRESTRICTIONATTRIBUTES         CC_TYTBATTRIBUTE;




FUNCTION FSBVERSION
RETURN VARCHAR2
IS
BEGIN
    RETURN CSBVERSION;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;

PROCEDURE GETSUBSCRIBER
(
    INUPACKAGE    IN NUMBER,
    ONUSUBSCRIBER OUT NUMBER
)
IS
BEGIN
    IF INUPACKAGE IS NULL THEN
        ONUSUBSCRIBER := NULL;
        RETURN;
    END IF;

    DAMO_PACKAGES.ACCKEY (INUPACKAGE);

    ONUSUBSCRIBER := DAMO_PACKAGES.FNUGETSUBSCRIBER_ID (INUPACKAGE);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        ONUSUBSCRIBER := NULL;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;


PROCEDURE FILLPACKAGEATTRIBUTES
IS

SBPACKAGETYPE           VARCHAR2(300);
SBPACKAGESTATUS         VARCHAR2(300);
SBRECEPTIONTYPE         VARCHAR2(300);
SBVENDOR                VARCHAR2(300);
SBNEIGHBORTHOOD         VARCHAR2(300);
SBSUBSCRIBER            VARCHAR2(300);
SBCONTACTPHONENUMBER    VARCHAR2(300);


SBORGANIZAT_AREA        VARCHAR2(300);
SBMANAGEMENT_AREA       VARCHAR2(300);
SBOPERUNITPOS           VARCHAR2(300);
SBCAMPAIGN              VARCHAR2(300);


SBANSWERMODE            VARCHAR2(300);
SBREFERMODE             VARCHAR2(300);
SBCONTACT               VARCHAR2(300);


SBFORMTYPE              VARCHAR2(300);
SBFORM                  VARCHAR2(300);


SBADDRESS               VARCHAR2(300);
SBADD_GEO_LOC_ID        VARCHAR2(300);
SBADD_NEIGHBOR_ID       VARCHAR2(300);


SBCHANGE_DETAIL         VARCHAR2(300);


SBLIQUIDATIONMETHOD     VARCHAR2(300);

BEGIN

    CC_BOOSSPACKAGEDATA.INIT;

    IF SBPACKAGEATTRIBUTES IS NOT NULL THEN
        RETURN;
    END IF;

    SBSUBSCRIBER        := 'a.subscriber_id'      || CC_BOBOSSUTIL.CSBSEPARATOR || 'r.subscriber_name||'' ''||r.subs_last_name';
    SBPACKAGETYPE       := 'a.package_type_id'    || CC_BOBOSSUTIL.CSBSEPARATOR || 'b.description';
    SBPACKAGESTATUS     := 'a.motive_status_id'   || CC_BOBOSSUTIL.CSBSEPARATOR || 'c.description';
    SBRECEPTIONTYPE     := 'a.reception_type_id'  || CC_BOBOSSUTIL.CSBSEPARATOR || 'e.description';
    SBVENDOR            := 'a.person_id'          || CC_BOBOSSUTIL.CSBSEPARATOR || 'f.name_';
    SBORGANIZAT_AREA    := 'a.organizat_area_id'  || CC_BOBOSSUTIL.CSBSEPARATOR || 'g.display_description';
    SBMANAGEMENT_AREA   := 'a.management_area_id' || CC_BOBOSSUTIL.CSBSEPARATOR || 't.display_description';
    SBOPERUNITPOS       := 'a.POS_Oper_Unit_Id'   || CC_BOBOSSUTIL.CSBSEPARATOR || 'k.name';
    SBCAMPAIGN          := 'a.Project_Id'         || CC_BOBOSSUTIL.CSBSEPARATOR || 'l.project_description';

    SBNEIGHBORTHOOD     := 'u.geograp_location_id'|| CC_BOBOSSUTIL.CSBSEPARATOR || 'u.description';

    SBADDRESS           := 'cc_boOssPackageData.fsbGetAddress(a.package_id)';
    SBADD_GEO_LOC_ID    := 'cc_boOssPackageData.fsbAddressGeoLoc(a.package_id)';
    SBADD_NEIGHBOR_ID   := 'cc_boOssPackageData.fsbAddressNeighbor(a.package_id)';

    SBCHANGE_DETAIL     := 'cc_boOssPackageData.fsbGetPackChanDetail(a.package_id, a.package_type_id)';


    SBANSWERMODE        := 'a.answer_mode_id'     || CC_BOBOSSUTIL.CSBSEPARATOR || 'm.description';
    SBREFERMODE         := 'a.refer_mode_id'      || CC_BOBOSSUTIL.CSBSEPARATOR || 'n.description';
    SBCONTACT           := 'a.contact_id'         || CC_BOBOSSUTIL.CSBSEPARATOR || 'o.subscriber_name||'' ''||o.subs_last_name';
    SBFORMTYPE          := 'a.document_type_id'   || CC_BOBOSSUTIL.CSBSEPARATOR || 'q.ticodesc';

    SBLIQUIDATIONMETHOD := 'decode(a.liquidation_method, null, b.liquidation_method, a.liquidation_method)'
                           || CC_BOBOSSUTIL.CSBSEPARATOR ||
                           ' cc_boquotationutil.fsbGetLiquidMethod(decode(a.liquidation_method, null, b.liquidation_method, a.liquidation_method))';

    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.package_id',              'package_id',               SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBSUBSCRIBER,                'subscriber',               SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBPACKAGETYPE,               'package_type',             SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.package_type_id',         'package_type_id',          SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.request_date',            'request_date',             SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.Expect_Atten_Date',       'Expect_Atten_Date',        SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBPACKAGESTATUS,             'package_status',           SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.user_id',                 'user_id',                  SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.attention_date',          'attention_date',           SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.comment_',                'comment_',                 SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBRECEPTIONTYPE,             'reception_type',           SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBVENDOR,                    'vendor',                   SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBORGANIZAT_AREA,            'organizat_area_id',        SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBMANAGEMENT_AREA,           'management_area',          SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.number_of_prod',          'number_of_prod',           SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('s.address_parsed',          'client_address',           SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBNEIGHBORTHOOD,             'client_neighborthood',     SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('o.phone',                   'contact_phone_number',     SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.cust_care_reques_num',    'cust_care_reques_num',     SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBOPERUNITPOS,               'POS_Oper_Unit_Id',         SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBCAMPAIGN,                  'Project_Id',               SBPACKAGEATTRIBUTES);

    CC_BOBOSSUTIL.ADDATTRIBUTE (SBADDRESS,                   'address',                  SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBADD_GEO_LOC_ID,            'add_geo_loc_id',           SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBADD_NEIGHBOR_ID,           'add_neighbor_id',          SBPACKAGEATTRIBUTES);

    CC_BOBOSSUTIL.ADDATTRIBUTE (SBCHANGE_DETAIL,             'change_detail',            SBPACKAGEATTRIBUTES);

    CC_BOBOSSUTIL.ADDATTRIBUTE (SBANSWERMODE,                'answer_mode',              SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBREFERMODE,                 'refer_mode',               SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBCONTACT,                   'contact',                  SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('p.address_parsed',          'answer_address',           SBPACKAGEATTRIBUTES);

    CC_BOBOSSUTIL.ADDATTRIBUTE ('a.document_key',            'form_number',              SBPACKAGEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBFORMTYPE,                  'form_type',                SBPACKAGEATTRIBUTES);

    CC_BOBOSSUTIL.ADDATTRIBUTE (SBLIQUIDATIONMETHOD,         'liquidation_method',       SBPACKAGEATTRIBUTES);

    CC_BOBOSSUTIL.ADDATTRIBUTE (':parent_id',                'parent_id',                SBPACKAGEATTRIBUTES);

    SBPACKAGEFROM   :=  'mo_packages a, ps_package_type b, ps_motive_status c,'  ||CHR(10)||
                        'ge_reception_type e, ge_person f, ge_organizat_area g,' ||CHR(10)||
                        'or_operating_unit k, pm_project l, cc_answer_mode m,'   ||CHR(10)||
                        'cc_refer_mode n, ge_subscriber o, ab_Address p,'        ||CHR(10)||
                        'tipocomp q, ge_subscriber r, ab_address s,'             ||CHR(10)||
                        'ge_organizat_area t, ge_geogra_location u';

    SBPACKAGEWHERE  :=  'a.package_type_id = b.package_type_id'              ||CHR(10)||
                        'AND a.motive_status_id = c.motive_status_id'        ||CHR(10)||
                        'AND a.reception_type_id = e.reception_type_id (+)'  ||CHR(10)||
                        'AND a.person_id = f.person_id (+)'                  ||CHR(10)||
                        'AND a.organizat_area_id = g.organizat_area_id (+)'  ||CHR(10)||
                        'AND a.management_area_id = t.organizat_area_id (+)' ||CHR(10)||
                        'AND a.subscriber_id = r.subscriber_id (+)'          ||CHR(10)||
                        'AND r.address_id = s.address_id (+)'                ||CHR(10)||
                        'AND s.neighborthood_id = u.geograp_location_id (+)' ||CHR(10)||
                        'AND a.POS_Oper_Unit_Id = k.operating_unit_id (+)'   ||CHR(10)||
                        'AND a.Project_Id = l.Project_Id (+)'                ||CHR(10)||
                        'AND a.answer_mode_id = m.answer_mode_id (+)'        ||CHR(10)||
                        'AND a.refer_mode_id = n.refer_mode_id (+)'          ||CHR(10)||
                        'AND a.contact_id = o.subscriber_id (+)'             ||CHR(10)||
                        'AND a.address_id = p.address_id (+)'                ||CHR(10)||
                        'AND a.document_type_id = q.ticocodi (+)';


EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END FILLPACKAGEATTRIBUTES;



PROCEDURE GETPACKAGES
(
    INUPACKAGE           IN     MO_PACKAGES.PACKAGE_ID%TYPE,
    INUBEFOREDAYS        IN     GE_CALENDAR.DAY_TYPE_ID%TYPE,
    INUBEFOREMONTHS      IN     GE_CALENDAR.DAY_TYPE_ID%TYPE,
    IDTINITIALDATE       IN     MO_PACKAGES.REQUEST_DATE%TYPE,
    IDTFINALDATE         IN     MO_PACKAGES.REQUEST_DATE%TYPE,
    INUPACKAGETYPE       IN     MO_PACKAGES.PACKAGE_TYPE_ID%TYPE DEFAULT NULL,
    INUPRODUCTTYPE       IN     PR_PRODUCT.PRODUCT_TYPE_ID%TYPE DEFAULT NULL,
    INUMOTIVESTATUS      IN     MO_PACKAGES.MOTIVE_STATUS_ID%TYPE DEFAULT NULL,
    INUPERSONID          IN     MO_PACKAGES.PERSON_ID%TYPE,
    INUUSERID            IN     SA_USER.USER_ID%TYPE,
    INUSALECHANNELID     IN     MO_PACKAGES.SALE_CHANNEL_ID%TYPE,
    ISBRESTRICTION       IN     VARCHAR2,
    INUCUSTREQUESTNUM    IN     MO_PACKAGES.CUST_CARE_REQUES_NUM%TYPE,
    INUFORMNUMBER        IN     FA_HISTCODI.HICDNUME%TYPE,
    INUVOUCHERTYPE       IN     FA_HISTCODI.HICDTICO%TYPE,
    OCUCURSOR            OUT    CONSTANTS.TYREFCURSOR
)
IS
    IDTINITIALBYDAY   DATE;
    IDTINITIALBYMONTH DATE;
    IDTINITIAL        DATE;
    IDTFINAL          DATE;
    IDTINITIALBYRANGE DATE := IDTINITIALDATE;
    IDTFINALBYRANGE   DATE := IDTFINALDATE;

    IDTINITIALRESULT  DATE;
    IDTFINALRESULT    DATE;
    NUPACKAGE         MO_PACKAGES.PACKAGE_ID%TYPE;
    NUPACKAGETYPE     MO_PACKAGES.PACKAGE_TYPE_ID%TYPE;
    NUPRODUCTTYPE     PR_PRODUCT.PRODUCT_TYPE_ID%TYPE;
    NUMOTIVESTATUS    MO_PACKAGES.MOTIVE_STATUS_ID%TYPE;

    NUPERSONID        MO_PACKAGES.PERSON_ID%TYPE;
    SBUSERID          MO_PACKAGES.USER_ID%TYPE;

    NUSALECHANNELID   MO_PACKAGES.SALE_CHANNEL_ID%TYPE;
    NUCUSTREQUESTNUM  MO_PACKAGES.CUST_CARE_REQUES_NUM%TYPE;

    NUFORMNUMBER      FA_HISTCODI.HICDNUME%TYPE;
    NUFORMTYPE        FA_HISTCODI.HICDTICO%TYPE;

    SBSQL             VARCHAR2(32767) := '';
    SBPACKAGEHINTS    VARCHAR2(6000)  := '';
    SBHINTS           VARCHAR2(6000)  := NULL;
    SBWHERE           VARCHAR2(6000)  := '';

BEGIN

    UT_TRACE.TRACE('Inicia ldc_boPackage.getPackages',6 );

    IF (INUBEFOREDAYS IS NOT NULL) THEN
        CC_BOBOSSUTIL.QUERYTYPEDATES (CC_BOBOSSUTIL.FNUQUERYBYDAY, INUBEFOREDAYS, IDTINITIALBYDAY, IDTFINAL);
    END IF;

    IF (INUBEFOREMONTHS IS NOT NULL) THEN
       CC_BOBOSSUTIL.QUERYTYPEDATES (CC_BOBOSSUTIL.FNUQUERYBYMONTH, INUBEFOREMONTHS, IDTINITIALBYMONTH, IDTFINAL);
    END IF;

    IF (IDTINITIALDATE IS NOT NULL OR IDTFINALDATE IS NOT NULL) THEN
       CC_BOBOSSUTIL.QUERYTYPEDATES (CC_BOBOSSUTIL.FNUQUERYBYBETWEEN, NULL, IDTINITIALBYRANGE, IDTFINALBYRANGE);
    END IF;

    IF (IDTINITIALBYDAY IS NULL AND IDTINITIALBYMONTH IS NOT NULL) THEN
        IDTINITIAL :=IDTINITIALBYMONTH;
    END IF;

    IF (IDTINITIALBYDAY IS NOT NULL AND IDTINITIALBYMONTH IS NULL) THEN
        IDTINITIAL := IDTINITIALBYDAY;
    END IF;

    IF (IDTINITIALBYDAY IS NOT NULL AND IDTINITIALBYMONTH IS NOT NULL) THEN
        IF (IDTINITIALBYDAY > IDTINITIALBYMONTH) THEN
            IDTINITIAL := IDTINITIALBYDAY;
        ELSE
            IDTINITIAL:=IDTINITIALBYMONTH;
        END IF;
    END IF;

    IF (IDTINITIAL IS NOT NULL AND IDTFINAL IS NOT NULL AND IDTINITIALBYRANGE IS NULL AND IDTFINALBYRANGE IS NULL) THEN
        IDTINITIALRESULT := IDTINITIAL;
        IDTFINALRESULT := IDTFINAL;
    END IF;

    IF (IDTINITIAL IS  NULL AND IDTFINAL IS  NULL AND IDTINITIALBYRANGE IS NOT NULL AND IDTFINALBYRANGE IS NOT NULL) THEN
        IDTINITIALRESULT := IDTINITIALBYRANGE;
        IDTFINALRESULT := IDTFINALBYRANGE;
    END IF;

    IF (IDTINITIAL IS NOT NULL AND IDTFINAL IS NOT NULL AND IDTINITIALBYRANGE IS NOT NULL AND IDTFINALBYRANGE IS NOT NULL) THEN
        IF (IDTFINAL BETWEEN IDTINITIALBYRANGE AND IDTFINALBYRANGE) AND (IDTINITIAL < IDTINITIALBYRANGE) THEN
            IDTINITIALRESULT := IDTINITIALBYRANGE;
            IDTFINALRESULT := IDTFINAL;
        END IF;

        IF (IDTINITIAL BETWEEN IDTINITIALBYRANGE AND IDTFINALBYRANGE) AND (IDTFINAL> IDTFINALBYRANGE) THEN
            IDTINITIALRESULT := IDTINITIAL;
            IDTFINALRESULT := IDTFINALBYRANGE;
        END IF;

        IF (IDTINITIAL BETWEEN IDTINITIALBYRANGE AND IDTFINALBYRANGE) AND (IDTFINAL BETWEEN IDTINITIALBYRANGE AND IDTFINALBYRANGE) THEN
            IDTINITIALRESULT := IDTINITIAL;
            IDTFINALRESULT := IDTFINAL;
        END IF;

        IF (IDTFINALBYRANGE BETWEEN IDTINITIAL AND IDTFINAL) AND (IDTINITIALBYRANGE < IDTINITIALBYRANGE) THEN
            IDTINITIALRESULT := IDTINITIAL;
            IDTFINALRESULT := IDTFINALBYRANGE;
        END IF;

        IF (IDTINITIALBYRANGE BETWEEN IDTINITIAL AND IDTFINAL) AND (IDTFINALBYRANGE >IDTFINAL) THEN
            IDTINITIALRESULT := IDTINITIALBYRANGE;
            IDTFINALRESULT := IDTFINAL;
        END IF;

        IF (IDTINITIALBYRANGE BETWEEN  IDTINITIAL AND IDTFINAL) AND (IDTFINALBYRANGE BETWEEN IDTINITIAL AND IDTFINAL) THEN
            IDTINITIALRESULT := IDTINITIALBYRANGE;
            IDTFINALRESULT := IDTFINALBYRANGE;
        END IF;
    END IF;


    NUPACKAGE        := NVL (INUPACKAGE, CC_BOCONSTANTS.CNUAPPLICATIONNULL);
    NUPACKAGETYPE    := NVL (INUPACKAGETYPE, CC_BOCONSTANTS.CNUAPPLICATIONNULL);
    NUPRODUCTTYPE    := NVL (INUPRODUCTTYPE, CC_BOCONSTANTS.CNUAPPLICATIONNULL);
    NUMOTIVESTATUS   := NVL (INUMOTIVESTATUS, CC_BOCONSTANTS.CNUAPPLICATIONNULL);
    NUPERSONID       := NVL (INUPERSONID, CC_BOCONSTANTS.CNUAPPLICATIONNULL);
    NUSALECHANNELID  := NVL (INUSALECHANNELID, CC_BOCONSTANTS.CNUAPPLICATIONNULL);
    NUCUSTREQUESTNUM := NVL(INUCUSTREQUESTNUM, CC_BOCONSTANTS.CNUAPPLICATIONNULL);
    NUFORMNUMBER     := NVL( INUFORMNUMBER, CC_BOCONSTANTS.CNUAPPLICATIONNULL);
    NUFORMTYPE       := NVL( INUVOUCHERTYPE, CC_BOCONSTANTS.CNUAPPLICATIONNULL);

    IF (INUUSERID IS NOT NULL) THEN
        SBUSERID := DASA_USER.FSBGETMASK(INUUSERID);
    ELSE
        SBUSERID := CC_BOCONSTANTS.CSBAPPLICATIONNULL;
    END IF;

    FILLPACKAGEATTRIBUTES;

    SBPACKAGEHINTS  := 'leading (a) use_nl(a b) use_nl(a c) use_nl(a e)'        ||CHR(10)||
                       'use_nl(a f) use_nl(a g) use_nl(a r) use_nl(r s)'        ||CHR(10)||
                       'use_nl(a k) use_nl(a l) use_nl(a m) use_nl(a n)'        ||CHR(10)||
                       'use_nl(a o) use_nl(a p) use_nl(a q) use_nl(s u)'        ||CHR(10)||
                       'index (f PK_GE_PERSON) index (g PK_GE_ORGANIZAT_AREA)'  ||CHR(10)||
                       'index (r PK_GE_SUBSCRIBER) index (s PK_AB_ADDRESS)'     ||CHR(10)||
                       'index (k PK_OR_OPERATING_UNIT) index (l PK_PM_PROJECT)' ||CHR(10)||
                       'index (o PK_GE_SUBSCRIBER) index (p PK_AB_ADDRESS) index (u PK_GE_GEOGRA_LOCATION)';


    IF NUPACKAGE != CC_BOCONSTANTS.CNUAPPLICATIONNULL  THEN
        SBHINTS := 'index (a PK_MO_PACKAGES)';
        SBWHERE := SBWHERE|| 'a.package_id = :nuPackage '||CHR(10)||'AND ';
    ELSE
        SBWHERE := SBWHERE||CHR(39)||NUPACKAGE||CHR(39)||' = :nuPackage '||CHR(10)||'AND ';
    END IF;


    IF NUCUSTREQUESTNUM != CC_BOCONSTANTS.CNUAPPLICATIONNULL THEN
        SBHINTS := NVL(SBHINTS,'index (a IDX_MO_PACKAGES_12)');
        SBWHERE := SBWHERE ||' a.cust_care_reques_num = :nuCustRequestNum '||CHR(10)||'AND ';
    ELSE
        SBWHERE := SBWHERE||CHR(39)||NUCUSTREQUESTNUM||CHR(39)||' = :nuCustRequestNum '||CHR(10)||'AND ';
    END IF;


    IF NUPERSONID != CC_BOCONSTANTS.CNUAPPLICATIONNULL THEN
        SBHINTS := NVL(SBHINTS,'index (a IDX_MO_PACKAGES_04)');
        SBWHERE := SBWHERE||'a.person_id = :nuPersonId '||CHR(10)||'AND ';
    ELSE
        SBWHERE := SBWHERE||CHR(39)||NUPERSONID||CHR(39)||' = :nuPersonId '||CHR(10)||'AND ';
    END IF;


    IF SBUSERID != CC_BOCONSTANTS.CSBAPPLICATIONNULL THEN
        SBHINTS := NVL(SBHINTS,'index (a IDX_MO_PACKAGES_020)');
        SBWHERE := SBWHERE||'a.user_id = :sbUserId '||CHR(10)||'AND ';
    ELSE
        SBWHERE := SBWHERE||CHR(39)||SBUSERID||CHR(39)||' = :sbUserId '||CHR(10)||'AND ';
    END IF;


    IF NUSALECHANNELID != CC_BOCONSTANTS.CNUAPPLICATIONNULL THEN
        SBHINTS := NVL(SBHINTS,'index (a IDX_MO_PACKAGES_021)');
        SBWHERE := SBWHERE ||'a.sale_channel_id = :nuSaleChannelId '||CHR(10)||'AND ';
    ELSE
        SBWHERE := SBWHERE||CHR(39)||NUSALECHANNELID||CHR(39)||' = :nuSaleChannelId '||CHR(10)||'AND ';
    END IF;


    IF (IDTINITIALRESULT IS NOT NULL AND IDTFINALRESULT IS NOT NULL) THEN
        SBHINTS := NVL(SBHINTS,'index (a IDX_MO_PACKAGES_015)');
        SBWHERE := SBWHERE ||'a.request_date >= :InitialDate'||CHR(10)||
                             'AND a.request_date <= :FinalDate'||CHR(10)||'AND ';
    END IF;


    IF (NUPACKAGETYPE != CC_BOCONSTANTS.CNUAPPLICATIONNULL) THEN
        SBHINTS := NVL(SBHINTS,'index (a IDX_MO_PACKAGES_01)');
        SBWHERE := SBWHERE ||'a.package_type_id = :nuPackageType '||CHR(10)||'AND ';
    ELSE
        SBWHERE := SBWHERE||CHR(39)||NUPACKAGETYPE||CHR(39)||' = :nuPackageType '||CHR(10)||'AND ';
    END IF;


    IF (NUPRODUCTTYPE != CC_BOCONSTANTS.CNUAPPLICATIONNULL) THEN
        SBWHERE := SBWHERE ||'exists ( '||CHR(10)||
                                        'SELECT /*+ index(d IDX_MO_MOTIVE_02) */'||CHR(10)||
                                        ' ''X'' '||CHR(10)||
                                        'FROM mo_motive d'||CHR(10)||
                                        'WHERE d.package_id = a.package_id'||CHR(10)||
                                        'AND d.product_type_id = :nuProductType'||CHR(10)||
                                        'AND ROWNUM <= 1 '||CHR(10)||
                                     ') '||CHR(10)||'AND ';
    ELSE
        SBWHERE := SBWHERE||CHR(39)||NUPRODUCTTYPE||CHR(39)||' = :nuProductType '||CHR(10)||'AND ';
    END IF;


    IF (NUMOTIVESTATUS != CC_BOCONSTANTS.CNUAPPLICATIONNULL) THEN
        SBWHERE := SBWHERE ||'a.motive_status_id = :nuMotiveStatus '||CHR(10)||'AND ';
    ELSE
        SBWHERE := SBWHERE||CHR(39)||NUMOTIVESTATUS||CHR(39)||' = :nuMotiveStatus'||CHR(10)||'AND ';
    END IF;


    IF ( NUFORMNUMBER != CC_BOCONSTANTS.CNUAPPLICATIONNULL ) THEN
        SBWHERE := SBWHERE ||'a.document_key like :nuFormNumbe '||CHR(10)||'AND ';
    ELSE
        SBWHERE := SBWHERE||CHR(39)||NUFORMNUMBER||CHR(39)||' = :nuFormNumber'||CHR(10)||'AND ';
    END IF;


    IF ( NUFORMTYPE != CC_BOCONSTANTS.CNUAPPLICATIONNULL ) THEN
        SBWHERE := SBWHERE ||'a.document_type_id = :nuFormType '||CHR(10)||'AND ';
    ELSE
        SBWHERE := SBWHERE||CHR(39)||NUFORMTYPE||CHR(39)||' = :nuFormType'||CHR(10)||'AND ';
    END IF;


    IF (ISBRESTRICTION IS NOT NULL) THEN


        IF (ISBRESTRICTION = MO_BOPARAMETER.FSBGETYES) THEN

            SBWHERE := SBWHERE ||'exists ( '||CHR(10)||
                                               'SELECT ''X'''||CHR(10)||
                                               'FROM mo_restriction'||CHR(10)||
                                               'WHERE mo_restriction.package_id = a.package_id'||CHR(10)||
                                               'AND mo_restriction.active_flag = ''Y'''||CHR(10)||
                                               'AND rownum = 1'||CHR(10)||
                                            ')'||CHR(10)||'AND ';

        END IF;


        IF (ISBRESTRICTION = MO_BOPARAMETER.FSBGETNO) THEN

            SBWHERE := SBWHERE ||'not exists ( '||CHR(10)||
                                               'SELECT ''X'''||CHR(10)||
                                               'FROM mo_restriction'||CHR(10)||
                                               'WHERE mo_restriction.package_id = a.package_id'||CHR(10)||
                                               'AND mo_restriction.active_flag = ''Y'''||CHR(10)||
                                               'AND rownum = 1'||CHR(10)||
                                            ')'||CHR(10)||'AND ';

        END IF;


    END IF;

    SBSQL := 'SELECT '||'/*+ ' || SBPACKAGEHINTS || SBHINTS || ' */' || CHR(10) ||
                         SBPACKAGEATTRIBUTES                       || CHR(10) ||
             'FROM '  || '/*+ ldc_boPackage.GetPackages */'      || CHR(10) ||
                      SBPACKAGEFROM                                || CHR(10) ||
             'WHERE ' || SBWHERE || SBPACKAGEWHERE;


    UT_TRACE.TRACE('Consulta ['||SBSQL||']',1);

    IF (IDTINITIALRESULT IS NOT NULL AND IDTFINALRESULT IS NOT NULL)
    THEN
        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, NUPACKAGE, NUCUSTREQUESTNUM, NUPERSONID,SBUSERID,
        NUSALECHANNELID,IDTINITIALRESULT,IDTFINALRESULT,NUPACKAGETYPE,NUPRODUCTTYPE,NUMOTIVESTATUS,
        NUFORMNUMBER,NUFORMTYPE;
    ELSE
        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, NUPACKAGE, NUCUSTREQUESTNUM, NUPERSONID,SBUSERID,
        NUSALECHANNELID,NUPACKAGETYPE,NUPRODUCTTYPE,NUMOTIVESTATUS,NUFORMNUMBER,NUFORMTYPE;
    END IF;

    UT_TRACE.TRACE('Finaliza ldc_boPackage.getPackages',6 );

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;



PROCEDURE GETPACKAGE
(
    INUPACKAGE IN NUMBER,
    OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
)
IS

SBSQL             VARCHAR2(32767);
SBPACKAGEHINTS    VARCHAR2(6000);

BEGIN

    FILLPACKAGEATTRIBUTES;

    SBPACKAGEHINTS  :=  '/*+ leading (a) use_nl(a b) use_nl(a c) use_nl(a e)'       ||CHR(10)||
                        'use_nl(a f) use_nl(a g) use_nl(a r) use_nl(r s)'           ||CHR(10)||
                        'use_nl(a k) use_nl(a l) use_nl(a m) use_nl(a n)'           ||CHR(10)||
                        'use_nl(a o) use_nl(a p) use_nl(a q) use_nl(s u)'           ||CHR(10)||
                        'index (a PK_MO_PACKAGES) index (f PK_GE_PERSON)'           ||CHR(10)||
                        'index (g PK_GE_ORGANIZAT_AREA) index (r PK_GE_SUBSCRIBER)' ||CHR(10)||
                        'index (s PK_AB_ADDRESS) index (k PK_OR_OPERATING_UNIT)'    ||CHR(10)||
                        'index (l PK_PM_PROJECT) index (o PK_GE_SUBSCRIBER)'        ||CHR(10)||
                        'index (p PK_AB_ADDRESS)index (u PK_GE_GEOGRA_LOCATION) */';

    SBSQL := 'SELECT '|| SBPACKAGEHINTS                      || CHR(10) ||
                         SBPACKAGEATTRIBUTES                 || CHR(10) ||
             'FROM '  || '/*+ ldc_boPackage.GetPackage */' || CHR(10) ||
                         SBPACKAGEFROM                       || CHR(10) ||
             'WHERE ' || 'a.package_id = :Package'           || CHR(10) ||
             'AND '   || SBPACKAGEWHERE;

    UT_TRACE.TRACE('Consulta: ['||SBSQL||']', 1);

    OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INUPACKAGE;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;



PROCEDURE FILLMOTIVEATTRIBUTES
IS
SBPRODUCTMOTIVE         VARCHAR2(300);
SBMOTIVESTATUS          VARCHAR2(300);
SBSOCIOECONOMICSTRATUM  VARCHAR2(300);
SBANNULCAUSAL           VARCHAR2(300);
SBMOTIVETYPE            VARCHAR2(300);
SBTECHNOLOGYTYPEID      VARCHAR2(300);
SBTECHNOLOGYTYPE        VARCHAR2(300);
SBTABPK                 VARCHAR2(300);
SBCOMMERCIALPLAN        VARCHAR2(300);
SBANSWER                VARCHAR2(200);
SBCAUSE                 VARCHAR2(200);
SBPERSON                VARCHAR2(200);
SBMOTIVECAUSALTYPE      VARCHAR2(200);

SBADDRESS               VARCHAR2(300);
SBADDRESSGEOLOC         VARCHAR2(300);
SBADDRESSNEIGHBOR       VARCHAR2(300);

BEGIN
    CC_BOOSSMOTIVEDATA.INIT;

    IF SBMOTIVEATTRIBUTES IS NOT NULL THEN
        RETURN;
    END IF;

    SBPRODUCTMOTIVE        := ' a.product_motive_id'  || CC_BOBOSSUTIL.CSBSEPARATOR ||'b.description';
    SBMOTIVESTATUS         := ' a.motive_status_id'   || CC_BOBOSSUTIL.CSBSEPARATOR ||'c.Description';
    SBSOCIOECONOMICSTRATUM := ' a.category_id'||'||''_''||'||'a.subcategory_id'|| CC_BOBOSSUTIL.CSBSEPARATOR ||'d.catedesc||'' ''||e.sucadesc';
    SBANNULCAUSAL          := ' a.annul_causal_id'    || CC_BOBOSSUTIL.CSBSEPARATOR ||'f.description ';
    SBMOTIVETYPE           := ' a.motive_type_id'     || CC_BOBOSSUTIL.CSBSEPARATOR ||'g.description';
    SBCOMMERCIALPLAN       := ' a.commercial_plan_id' || CC_BOBOSSUTIL.CSBSEPARATOR ||'h.name';


    SBTECHNOLOGYTYPEID     := ' mo_boMotive.fnuGetTechnologyTypeMot(a.motive_id)';
    SBTECHNOLOGYTYPE       := ' ge_bobasicdataservices.fsbGetTechnologyType('||SBTECHNOLOGYTYPEID||')';

    SBADDRESS              := ' cc_boOssMotiveData.fsbGetAddress(a.motive_id)';
    SBADDRESSGEOLOC        := ' cc_boOssMotiveData.fsbAddressGeoLoc(a.motive_id)';
    SBADDRESSNEIGHBOR      := ' cc_boOssMotiveData.fsbAddressNeighbor(a.motive_id)';

    SBANSWER                := ' a.answer_id'          ||CC_BOBOSSUTIL.CSBSEPARATOR||'i.description';
    SBMOTIVECAUSALTYPE      := 'j.causal_type_id'      ||CC_BOBOSSUTIL.CSBSEPARATOR||'m.description';
    SBCAUSE                 := 'a.causal_id'           ||CC_BOBOSSUTIL.CSBSEPARATOR||'j.description';
    SBPERSON                := 'a.assigned_person_id'  ||CC_BOBOSSUTIL.CSBSEPARATOR||'k.name_';

    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.motive_id',                 'motive_id',                SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBPRODUCTMOTIVE,                'product_motive',           SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBMOTIVESTATUS,                 'motive_status',            SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.initial_process_date',      'initial_process_date',     SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.estimated_inst_date',       'estimated_inst_date',      SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.assign_date',               'assign_date',              SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.service_number',            'service_number',           SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBMOTIVETYPE,                   'motive_type',              SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBSOCIOECONOMICSTRATUM,         'socioeconomic_stratum',    SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBANNULCAUSAL,                  'annul_causal',             SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.attention_date',            'attention_date',           SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.annul_date',                'annul_date',               SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.provisional_flag',          'provisional_flag',         SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.credit_limit',              'credit_limit',             SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.credit_limit_covered',      'credit_limit_covered',     SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBTECHNOLOGYTYPE,               'technology_type',          SBMOTIVEATTRIBUTES);

    CC_BOBOSSUTIL.ADDATTRIBUTE (SBADDRESS,                      'address',                  SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBADDRESSGEOLOC,                'add_geo_loc_id',           SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBADDRESSNEIGHBOR,              'add_neighbor_id',          SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBCOMMERCIALPLAN,               'commercial_plan_id',       SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBANSWER,                       'motive_answer',            SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBMOTIVECAUSALTYPE,             'motive_causal_type',       SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBCAUSE,                        'motive_cause',             SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBPERSON,                       'motive_person',            SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.permanence',                'PERMANENCE',               SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.prov_initial_date',         'prov_initial_date',        SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.prov_final_date',           'prov_final_date',          SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.subscription_id',           'subscription_id',          SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.product_id',                'product_id',               SBMOTIVEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' :parent_id',                  'parent_id',                SBMOTIVEATTRIBUTES);

    SBMOTIVEHINTS   :=  ' use_nl(a b) use_nl(a c) use_nl(a d) use_nl(a e) '         ||CHR(10)||
                        ' use_nl(a f) use_nl(a g) use_nl(a h) use_nl(a i) '         ||CHR(10)||
                        ' use_nl(a j) use_nl(j m) use_nl(a k)             '         ||CHR(10)||
                        ' index(b pk_ps_product_motive) '                           ||CHR(10)||
                        ' index(f pk_cc_causal) '                                   ||CHR(10)||
                        ' index(g pk_ps_motive_type) '                              ||CHR(10)||
                        ' index(h pk_cc_commercial_plan) '                          ||CHR(10)||
                        ' index(j pk_cc_causal) '                                   ||CHR(10)||
                        ' index(m pk_cc_causal_type) '                              ||CHR(10)||
                        ' index(k pk_ge_person) ';

    SBMOTIVEFROM    :=  ' mo_motive a, ps_product_motive b, ps_motive_status c, '   ||CHR(10)||
                        ' categori d, subcateg e, cc_causal f, ps_motive_type g, '  ||CHR(10)||
                        ' cc_commercial_plan h, cc_answer i, cc_causal j, '         ||CHR(10)||
                        ' ge_person k, cc_causal_type m';

    SBMOTIVEWHERE   :=  ' a.product_motive_id = b.product_motive_id '               ||CHR(10)||
                        ' AND a.motive_status_id = c.motive_status_id '             ||CHR(10)||
                        ' AND a.category_id = d.catecodi(+) '                       ||CHR(10)||
                        ' AND a.category_id = e.sucacate(+) '                       ||CHR(10)||
                        ' AND a.subcategory_id = e.sucacodi(+) '                    ||CHR(10)||
                        ' AND a.annul_causal_id = f.causal_id(+) '                  ||CHR(10)||
                        ' AND a.motive_type_id = g.motive_type_id '                 ||CHR(10)||
                        ' AND a.commercial_plan_id = h.commercial_plan_id(+) '      ||CHR(10)||
                        ' AND a.answer_id = i.answer_id(+) '                        ||CHR(10)||
                        ' AND a.causal_id = j.causal_id(+) '                        ||CHR(10)||
                        ' AND j.causal_type_id = m.causal_type_id(+) '              ||CHR(10)||
                        ' AND a.assigned_person_id = k.person_id(+) ';

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END FILLMOTIVEATTRIBUTES;

PROCEDURE GETMOTIVES
(
    INUPACKAGE IN NUMBER,
    OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
)
IS

    SBSQL   VARCHAR2(32767);
BEGIN
    FILLMOTIVEATTRIBUTES;

    SBSQL := ' SELECT /*+ leading(a) index (a IDX_MO_MOTIVE_02) '   ||CHR(10)||
             SBMOTIVEHINTS||'*/'                                    ||CHR(10)||
             SBMOTIVEATTRIBUTES                                     ||CHR(10)||
             '   FROM /*+ldc_boPackage.GetMotives*/'               ||CHR(10)||
             SBMOTIVEFROM                                           ||CHR(10)||
             '  WHERE '||SBMOTIVEWHERE                              ||CHR(10)||
             ' AND a.package_id = :Package';

    OPEN OCUCURSOR FOR SBSQL USING INUPACKAGE, INUPACKAGE;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;


PROCEDURE GETCOUPONS
(
    INUPACKAGE IN NUMBER,
    OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
)
IS



    CSBPAY_PARTIAL  CONSTANT MO_PACKAGES.TAG_NAME%TYPE := 'P_GENER_IMPPAGOPARCIAL';
    CSBPAY_OF_TIME  CONSTANT MO_PACKAGES.TAG_NAME%TYPE := 'P_LBC_IMPRESION_DE_PAGO_ANTICIPADO_100040';
    CSBACCOUNT_STAT CONSTANT MO_PACKAGES.TAG_NAME%TYPE := 'P_SOLICITUD_DE_ESTADO_DE_CUENTA_979';



    CUCURSOR        CONSTANTS.TYREFCURSOR;
    SBATTRIB        VARCHAR2(4000);
    SBSQL1          VARCHAR2(4000);
    SBSQL2          VARCHAR2(4000);
    SBPACKAGETAG    MO_PACKAGES.TAG_NAME%TYPE;
    NUMOTIVEPAYMENT MO_MOTIVE_PAYMENT.MOTIVE_PAYMENT_ID%TYPE;
BEGIN


    SBPACKAGETAG := DAMO_PACKAGES.FSBGETTAG_NAME( INUPACKAGE );


    IF ( SBPACKAGETAG IN ( CSBPAY_PARTIAL,
                           CSBPAY_OF_TIME,
                           CSBACCOUNT_STAT,
                           PS_BOPACKAGETYPE.CSBP_FINANCING_DEBT ) )
    THEN

        SBSQL1:=
            'SELECT /*+ leading( pp )'                                          ||
                    '   index( pp IDX_MO_PACKAGE_PAYMENT )'                     ||
                    '   index( mp IDX_MO_MOTIVE_PAYMENT_05 )'                   ||
                    '   index( cupon PK_CUPON )'                                ||
                    '   index( pagos PK_PAGOS ) */'                             ||
                    ' mp.motive_payment_id  motive_payment_id,'                 ||
                    ' mp.limit_date         limit_date,'                        ||
                    ' mp.total_value        total_value,'                       ||
                    ' pagos.pagovapa        payment_value,'                     ||
                    ' mp.support_document   support_document,'                  ||
                    ' cupon.cuponume        coupon_id,'                         ||
                    ' cupon.cupofech        generation_date,'                   ||
                    ' pagos.pagofepa        payment_date,'                      ||
                    ' mp.account            account,'                           ||
                    ' :parent_id            parent_id'                          ||
            ' FROM  mo_package_payment pp, mo_motive_payment mp, cupon, pagos'  ||
            ' /*+ ldc_boPackage.GetCoupons */'                                ||
            ' WHERE pp.package_id  = :inuPackage'                               ||
            ' AND   pp.package_payment_id = mp.package_payment_id'              ||
            ' AND   cupon.cuponume = mp.coupon_id'                              ||
            ' AND   cupon.cuponume = pagos.pagocupo (+)'                        ||
            ' AND   mp.active = ''' || CC_BOBOSSUTIL.CSBYES || ''''             ||
            ' ORDER BY mp.motive_payment_id desc';

        OPEN OCUCURSOR FOR SBSQL1 USING INUPACKAGE, INUPACKAGE;
        RETURN;

    END IF;

    SBATTRIB := 'WITH CUPONES AS (
                SELECT no_pago_motivo.motive_payment_id     motive_payment_id,'||
                      ' no_pago_motivo. limit_date          limit_date,'||
                      ' no_pago_motivo.total_value          total_value,' ||
                      ' no_pago_motivo.payment_value        payment_value,'||
                      ' no_pago_motivo.support_document     support_document,'||
                      ' cupon.cuponume                      coupon_id,' ||
                      ' cc_boBssCouponData.fdtGenerationDate(no_pago_motivo.support_document)  generation_date,' ||
                      ' cc_boBssCouponData.fdtPaymentDate(no_pago_motivo.support_document)  payment_date,' ||
                      ' no_pago_motivo.account              account,' ||
                      ' :parent_id                          parent_id';

    SBSQL1:= ' FROM mo_package_payment pago_solicitud, mo_motive_payment no_pago_motivo, cupon '||
             ' WHERE pago_solicitud.package_id = :inuPackage '||
             ' AND pago_solicitud.package_payment_id = no_pago_motivo.package_payment_id '||
             ' AND no_pago_motivo.support_document = cupon.cupodocu '||
             ' AND cupon.cupotipo = '||CHR(39)|| PKBILLCONST.CSBTOKEN_APLICA_FACTURA ||CHR(39)||
             ' AND no_pago_motivo.active = '||CHR(39)|| CC_BOBOSSUTIL.CSBYES ||CHR(39)||
             ' AND (no_pago_motivo.payment_value = 0 OR no_pago_motivo.payment_value is null) '||
             ' ORDER BY no_pago_motivo.motive_payment_id';

    SBSQL2:= ' FROM  mo_motive_payment no_pago_motivo, mo_package_payment pago_solicitud, cupon '||
             ' WHERE pago_solicitud.package_id  = :inuPackage '||
             ' AND   cupon.cupodocu = to_char(pago_solicitud.package_id)'||
             ' AND   cupon.cupotipo = '||CHR(39)|| PKBILLCONST.CSBTOKEN_SOLICITUD ||CHR(39)||
             ' AND   no_pago_motivo.active = '||CHR(39)|| CC_BOBOSSUTIL.CSBYES ||CHR(39)||
             ' AND   pago_solicitud.package_payment_id = no_pago_motivo.package_payment_id '||
             ' AND  (no_pago_motivo.payment_value = 0 OR no_pago_motivo.payment_value is null) '||
             'AND NOT EXISTS
             (
                SELECT pago_motivo.motive_payment_id
                FROM mo_motive_payment pago_motivo
                WHERE pago_motivo.package_payment_id = no_pago_motivo.package_payment_id
                AND no_pago_motivo.motive_payment_id <> pago_motivo.motive_payment_id
                AND pago_motivo.payment_value > 0
             )
             ORDER BY no_pago_motivo.motive_payment_id
             )
             SELECT * FROM CUPONES
             WHERE ROWNUM = 1';

    OPEN CUCURSOR FOR 'SELECT no_pago_motivo.motive_payment_id' || SBSQL1 USING INUPACKAGE;
    FETCH CUCURSOR INTO NUMOTIVEPAYMENT;
    CLOSE CUCURSOR;


    IF ( NUMOTIVEPAYMENT IS NULL ) THEN
        OPEN OCUCURSOR FOR SBATTRIB || SBSQL2 USING INUPACKAGE, INUPACKAGE;
    ELSE
         SELECT REPLACE(
                        SBATTRIB,
                        'WITH CUPONES AS (',
                        ''
                       ) INTO SBATTRIB FROM DUAL;
        OPEN OCUCURSOR FOR SBATTRIB || SBSQL1 USING INUPACKAGE, INUPACKAGE;
    END IF;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END GETCOUPONS;




PROCEDURE GETPAYMENTS
(
    INUPACKAGE IN NUMBER,
    OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
)
IS

SBSQL                   VARCHAR2(4000);
SBPAYMENTFROMPACKAGE    VARCHAR2(800);

BEGIN
    ldc_boPayment.FILLPAYMENTATTRIBUTES;


    SELECT REPLACE(ldc_boPayment.SBPAYMENTFROM,'vwrc_payments', 'pagos') INTO SBPAYMENTFROMPACKAGE FROM DUAL;

    SBSQL := ' SELECT /*+leading (mo_package_payment) index(mo_package_payment IDX_MO_PACKAGE_PAYMENT)
                        use_nl_with_index(mo_motive_payment IDX_MO_MOTIVE_PAYMENT_05)
                        use_nl_with_index(factura pk_factura)
                        use_nl_with_index(cuencobr IDXCUCO_RELA)
                        use_nl_with_index(cargos IX_CARG_CUCO_CONC)
                        use_nl_with_index(cupon pk_cupon)
                        use_nl_with_index(pagos pk_pagos)
                        use_nl_with_index(sucubanc pk_sucubanc)
                        use_nl_with_index(banco pk_banco)*/' ||CHR(10)||
             ldc_boPayment.SBPAYMENTATTRIBUTES ||CHR(10)||
             ' FROM '|| SBPAYMENTFROMPACKAGE||', mo_motive_payment mp, mo_package_payment pp, factura, cuencobr, cargos' ||CHR(10)||
             ' WHERE '|| ldc_boPayment.SBPAYMENTWHERE ||CHR(10)||
             ' AND pp.package_id = :inuPackage'||CHR(10)||
             ' AND pp.package_payment_id = mp.package_payment_id'||CHR(10)||
             ' AND mp.payment_value > 0'||CHR(10)||
             ' AND mp.active = '||CHR(39)|| CC_BOBOSSUTIL.CSBYES ||CHR(39)||CHR(10)||
             ' AND mp.account = factcodi'||CHR(10)||
             ' AND factcodi = cucofact'||CHR(10)||
             ' AND cargcuco = cucocodi'||CHR(10)||
             ' AND cargdoso LIKE ''PA%'''||CHR(10)||
             ' AND cargsign = '||CHR(39)||PKBILLCONST.PAGO||CHR(39)||CHR(10)||
             ' AND cargcodo = cuponume'||CHR(10)||
             ' AND ( cupotipo = '||CHR(39)||PKBILLCONST.CSBTOKEN_APLICA_FACTURA||CHR(39)|| ' OR cupotipo = '||CHR(39)||PKBILLCONST.CSBTOKEN_SOLICITUD||CHR(39)||')'||CHR(10)||
             ' AND cuponume = pagocupo'||CHR(10)||
             ' ORDER BY pagocupo';

    DBMS_OUTPUT.PUT_LINE(SBSQL);

    UT_TRACE.TRACE('Consulta['||SBSQL||']', 5);

    OPEN OCUCURSOR FOR SBSQL USING INUPACKAGE, INUPACKAGE;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;


PROCEDURE GETCOMMENTS
(
    INUPACKAGE IN NUMBER,
    OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
)
IS
    SBSQL   VARCHAR2(10000);
BEGIN
    UT_TRACE.TRACE('Begin ldc_boPackage.GetComments',10);

    CC_BOOSSCOMMENT.FILLCOMMENTATTRIBUTES;


    SBSQL := 'SELECT '|| CC_BOOSSCOMMENT.SBCOMMENTATTRIBUTES ||CHR(10)||
             ' FROM mo_comment' ||CHR(10)||
             ' WHERE mo_comment.package_id = :inuPackage';

    UT_TRACE.TRACE('Consulta : '||SBSQL||' Paquete['||INUPACKAGE||']' ,10 );


    OPEN OCUCURSOR FOR SBSQL USING INUPACKAGE, INUPACKAGE;

    UT_TRACE.TRACE('End ldc_boPackage.GetComments',10);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;


PROCEDURE GETMOTIVESBYADDRESS
(
    INUADDRESSID   IN AB_ADDRESS.ADDRESS_ID%TYPE,
    OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
)
IS

   SBSQL VARCHAR2(6000);

BEGIN
    FILLMOTIVEATTRIBUTES;

    SBSQL := ' SELECT '                                                             ||CHR(10)||
                 '/*+ leading(pr_product) index(pr_product IDX_PR_PRODUCT_09) '     ||CHR(10)||
                 SBMOTIVEHINTS||'*/'                                                ||CHR(10)||
                 SBMOTIVEATTRIBUTES                                                 ||CHR(10)||
                 '   FROM /*+ldc_boPackage.GetMotives*/'                           ||CHR(10)||
                 SBMOTIVEFROM||', pr_product'                                       ||CHR(10)||
                 '  WHERE '||SBMOTIVEWHERE                                          ||CHR(10)||
                 ' AND a.product_id = pr_product.product_id'                        ||CHR(10)||
                 ' AND pr_product.address_id = :inuAddressId'                       ||CHR(10)||
             ' UNION '                                                              ||CHR(10)||
             ' SELECT '                                                             ||CHR(10)||
                 '/*+ leading(mo_address) index(mo_address IDX_MO_ADDRESS_1) '      ||CHR(10)||
                 ' index(a pk_motive) '                                             ||CHR(10)||
                 SBMOTIVEHINTS||'*/'                                                ||CHR(10)||
                 SBMOTIVEATTRIBUTES                                                 ||CHR(10)||
                 '   FROM /*+ldc_boPackage.GetMotives*/'                           ||CHR(10)||
                 SBMOTIVEFROM||', mo_address'                                       ||CHR(10)||
                 '  WHERE '||SBMOTIVEWHERE                                          ||CHR(10)||
                 ' AND a.motive_id = mo_address.motive_id'                          ||CHR(10)||
                 ' AND mo_address.parser_address_id = :inuAddressId';

    UT_TRACE.TRACE('Consulta MotivosXDirecci?n['||SBSQL||']', 5);

    OPEN OCUDATACURSOR FOR SBSQL USING INUADDRESSID, INUADDRESSID, INUADDRESSID, INUADDRESSID;


EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;


FUNCTION FSBPACKAGEADDRESS
(
    INUPACKAGE      IN MO_PACKAGES.PACKAGE_ID%TYPE,
    INUMOADDRESS    IN MO_ADDRESS.ADDRESS_ID%TYPE
)
RETURN MO_ADDRESS.ADDRESS%TYPE
IS

SBADDRESS  MO_ADDRESS.ADDRESS%TYPE;

    CURSOR CUADDRESS
    (
        NUPACKAGE   MO_PACKAGES.PACKAGE_ID%TYPE,
        NUMOADDRESS MO_ADDRESS.ADDRESS_ID%TYPE
    )
    IS
        SELECT ADDRESS
          FROM MO_ADDRESS
         WHERE PACKAGE_ID = NUPACKAGE
         AND   ADDRESS_ID = NUMOADDRESS;

BEGIN
    OPEN CUADDRESS (INUPACKAGE, INUMOADDRESS);
        FETCH CUADDRESS INTO SBADDRESS;

        IF CUADDRESS%NOTFOUND THEN
            SBADDRESS := NULL;
        END IF;

    CLOSE CUADDRESS;

    RETURN SBADDRESS;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        IF CUADDRESS%ISOPEN THEN
            CLOSE CUADDRESS;
        END IF;
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        IF CUADDRESS%ISOPEN THEN
            CLOSE CUADDRESS;
        END IF;
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;



FUNCTION FSBPACKAGEPREMISE
(
    INUPACKAGE      IN MO_PACKAGES.PACKAGE_ID%TYPE
)
RETURN AB_ADDRESS.ADDRESS%TYPE
IS

    SBPREMISE  AB_ADDRESS.ADDRESS%TYPE;

    CURSOR CUPREMISE
    (
        NUPACKAGE MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS
        SELECT AB_ADDRESS.ADDRESS
          FROM MO_MOTIVE, MO_ADDRESS, AB_ADDRESS
         WHERE MO_MOTIVE.PACKAGE_ID = INUPACKAGE
               AND MO_MOTIVE.MOTIVE_ID = MO_ADDRESS.MOTIVE_ID (+)
               AND MO_ADDRESS.PARSER_ADDRESS_ID = AB_ADDRESS.ADDRESS_ID (+)
               AND MO_ADDRESS.IS_ADDRESS_MAIN (+)  = 'Y'
               AND ROWNUM = 1
     ;

BEGIN
    OPEN CUPREMISE (INUPACKAGE);
        FETCH CUPREMISE INTO SBPREMISE;

        IF CUPREMISE%NOTFOUND THEN
            SBPREMISE := NULL;
        END IF;

    CLOSE CUPREMISE;

    RETURN SBPREMISE;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        IF CUPREMISE%ISOPEN THEN
            CLOSE CUPREMISE;
        END IF;
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        IF CUPREMISE%ISOPEN THEN
            CLOSE CUPREMISE;
        END IF;
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;


FUNCTION FNUPACKADDRESGEOLOCA
(
    INUPACKAGE      IN MO_PACKAGES.PACKAGE_ID%TYPE,
    INUMOADDRESS    IN MO_ADDRESS.ADDRESS_ID%TYPE
)
RETURN MO_ADDRESS.GEOGRAP_LOCATION_ID%TYPE
IS

NUGEOGRAPLOCATIONID  MO_ADDRESS.GEOGRAP_LOCATION_ID%TYPE;

    CURSOR CUGEOGRAPLOCATION
    (
        NUPACKAGE   MO_PACKAGES.PACKAGE_ID%TYPE,
        NUADDRESS   MO_ADDRESS.ADDRESS_ID%TYPE
    )
    IS
        SELECT GEOGRAP_LOCATION_ID
          FROM MO_ADDRESS
         WHERE PACKAGE_ID = NUPACKAGE
           AND ADDRESS_ID = NUADDRESS;

BEGIN
    OPEN CUGEOGRAPLOCATION (INUPACKAGE, INUMOADDRESS);
        FETCH CUGEOGRAPLOCATION INTO NUGEOGRAPLOCATIONID;

        IF CUGEOGRAPLOCATION%NOTFOUND THEN
            NUGEOGRAPLOCATIONID := NULL;
        END IF;

    CLOSE CUGEOGRAPLOCATION;

    RETURN NUGEOGRAPLOCATIONID;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        IF CUGEOGRAPLOCATION%ISOPEN THEN
            CLOSE CUGEOGRAPLOCATION;
        END IF;
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        IF CUGEOGRAPLOCATION%ISOPEN THEN
            CLOSE CUGEOGRAPLOCATION;
        END IF;
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;



FUNCTION FNUPACKPREMISEGEOLOCA
(
    INUPACKAGE IN MO_PACKAGES.PACKAGE_ID%TYPE
)
RETURN AB_ADDRESS.GEOGRAP_LOCATION_ID%TYPE
IS

    NUGEOGRAPLOCATIONID  AB_ADDRESS.GEOGRAP_LOCATION_ID%TYPE;

    CURSOR CUGEOGRAPLOCATION
    (
        NUPACKAGE MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS
        SELECT AB_ADDRESS.GEOGRAP_LOCATION_ID
          FROM MO_MOTIVE, MO_ADDRESS, AB_ADDRESS
         WHERE MO_MOTIVE.PACKAGE_ID = INUPACKAGE
               AND MO_MOTIVE.MOTIVE_ID = MO_ADDRESS.MOTIVE_ID (+)
               AND MO_ADDRESS.PARSER_ADDRESS_ID = AB_ADDRESS.ADDRESS_ID (+)
               AND MO_ADDRESS.IS_ADDRESS_MAIN (+)  = 'Y'
               AND ROWNUM = 1
        ;

BEGIN
    OPEN CUGEOGRAPLOCATION (INUPACKAGE);
        FETCH CUGEOGRAPLOCATION INTO NUGEOGRAPLOCATIONID;

        IF CUGEOGRAPLOCATION%NOTFOUND THEN
            NUGEOGRAPLOCATIONID := NULL;
        END IF;

    CLOSE CUGEOGRAPLOCATION;

    RETURN NUGEOGRAPLOCATIONID;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        IF CUGEOGRAPLOCATION%ISOPEN THEN
            CLOSE CUGEOGRAPLOCATION;
        END IF;
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        IF CUGEOGRAPLOCATION%ISOPEN THEN
            CLOSE CUGEOGRAPLOCATION;
        END IF;
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;



FUNCTION FNUPACKADDRESSNEIGHB
(
    INUMOADDRESS    IN MO_ADDRESS.ADDRESS_ID%TYPE
)
RETURN AB_ADDRESS.NEIGHBORTHOOD_ID%TYPE
IS

NUNEIGHBORTHOODID  AB_ADDRESS.NEIGHBORTHOOD_ID%TYPE;

    CURSOR CUNEIGHBORTHOOD
    (
        NUMOADDRESS     MO_ADDRESS.ADDRESS_ID%TYPE
    )
    IS
        SELECT AB_ADDRESS.NEIGHBORTHOOD_ID
        FROM MO_ADDRESS, AB_ADDRESS
        WHERE MO_ADDRESS.ADDRESS_ID = NUMOADDRESS
            AND MO_ADDRESS.ADDRESS_ID = AB_ADDRESS.ADDRESS_ID;

BEGIN
    OPEN CUNEIGHBORTHOOD (INUMOADDRESS);
        FETCH CUNEIGHBORTHOOD INTO NUNEIGHBORTHOODID;

        IF CUNEIGHBORTHOOD%NOTFOUND THEN
            NUNEIGHBORTHOODID := NULL;
        END IF;

    CLOSE CUNEIGHBORTHOOD;

    RETURN NUNEIGHBORTHOODID;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        IF CUNEIGHBORTHOOD%ISOPEN THEN
            CLOSE CUNEIGHBORTHOOD;
        END IF;
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        IF CUNEIGHBORTHOOD%ISOPEN THEN
            CLOSE CUNEIGHBORTHOOD;
        END IF;
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;



PROCEDURE FILLRESTRICTIONATTRIBUTES
IS

    SBRESTRTYPE    VARCHAR2(200);

BEGIN

    UT_TRACE.TRACE('Iniciando ldc_boPackage.FillRestrictionAttributes', 5);

    IF  SBRESTRICTIONATTRIBUTES IS NOT NULL THEN
       RETURN;
    END IF;
    SBRESTRTYPE   := 'mo_restriction.restriction_type_id' || CC_BOBOSSUTIL.CSBSEPARATOR ||'mo_boDescriptions.fsbGetDescRestType(mo_restriction.restriction_type_id)';

    CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_restriction.restriction_id','restriction_id',      CC_BOBOSSUTIL.CNUNUMBER, SBRESTRICTIONATTRIBUTES, TBRESTRICTIONATTRIBUTES, TRUE);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBRESTRTYPE                   , 'restriction_type_id',  CC_BOBOSSUTIL.CNUNUMBER, SBRESTRICTIONATTRIBUTES, TBRESTRICTIONATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_restriction.register_date', 'register_date',        CC_BOBOSSUTIL.CNUDATE, SBRESTRICTIONATTRIBUTES, TBRESTRICTIONATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_restriction.ending_date',   'ending_date',          CC_BOBOSSUTIL.CNUDATE, SBRESTRICTIONATTRIBUTES, TBRESTRICTIONATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_restriction.active_flag',   'active',               CC_BOBOSSUTIL.CNUVARCHAR2, SBRESTRICTIONATTRIBUTES, TBRESTRICTIONATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_restriction.final_package_id','final_package_id',   CC_BOBOSSUTIL.CNUNUMBER, SBRESTRICTIONATTRIBUTES, TBRESTRICTIONATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (':parent_id',                    'parent_id',           CC_BOBOSSUTIL.CNUNUMBER, SBRESTRICTIONATTRIBUTES, TBRESTRICTIONATTRIBUTES);

    UT_TRACE.TRACE('Termina ldc_boPackage.FillRestrictionAttributes', 5);
EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;

PROCEDURE GETRESTRICTIONS
(
    INUPACKAGEID    IN  MO_PACKAGES.PACKAGE_ID%TYPE,
    OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
)
IS

    SBSQL     VARCHAR2(32767);

BEGIN
    UT_TRACE.TRACE('Iniciando ldc_boPackage.GetRestrictions Paquete['||INUPACKAGEID||']', 5);


    SBRESTRICTIONATTRIBUTES := NULL;

    FILLRESTRICTIONATTRIBUTES;


    SBSQL := 'SELECT '|| SBRESTRICTIONATTRIBUTES ||CHR(10)||
             'FROM mo_restriction, mo_restriction_type'||CHR(10)||
             'WHERE mo_restriction.package_id             = :inuPackageId'||CHR(10)||
             'AND   mo_restriction.restriction_type_id    = mo_restriction_type.restriction_type_id'||CHR(10)||
             'ORDER BY mo_restriction.restriction_id';

    UT_TRACE.TRACE('Consulta de Restricciones de un paquete ['||SBSQL||']', 5);

    OPEN OCUDATACURSOR FOR SBSQL USING INUPACKAGEID, INUPACKAGEID;

    UT_TRACE.TRACE('Termina ldc_boPackage.GetRestrictions ', 5);
EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;



PROCEDURE GETASSOMOTIVES
(
    INUPACKAGEID   IN   MO_PACKAGES.PACKAGE_ID%TYPE,
    OCUDATACURSOR  OUT CONSTANTS.TYREFCURSOR
)
IS
    SBSQL     VARCHAR2(32767);
BEGIN
    UT_TRACE.TRACE('Iniciando ldc_boPackage.GetAssoMotives Paquete['||INUPACKAGEID||']', 5);

    CC_BOOSSMOTIVE.FILLASSOMOTIVESATT;

    SBSQL := 'SELECT '|| CC_BOOSSMOTIVE.SBASSOMOTIVESATT ||CHR(10)||
             'FROM mo_motive_asso a, mo_motive b, mo_packages c'||CHR(10)||
             'WHERE a.cus_car_req_num_asso = :inuPackageId'||CHR(10)||
             'AND   a.motive_id = b.motive_id'||CHR(10)||
             'AND   b.package_id = c.package_id'||CHR(10)||
             'UNION ' ||CHR(10)||
             'SELECT '|| CC_BOOSSMOTIVE.SBASSOMOTIVESATT ||CHR(10)||
             'FROM mo_motive_asso a, mo_motive b, mo_packages c, mo_motive d'||CHR(10)||
             'WHERE d.package_id = :inuPackageId'||CHR(10)||
             'AND   a.motive_id_asso = d.motive_id'||CHR(10)||
             'AND   a.motive_id = b.motive_id'||CHR(10)||
             'AND   b.package_id = c.package_id'||CHR(10)||
             'ORDER BY motive_id';

    UT_TRACE.TRACE('Consulta de los motivos asociados a un paquete ['||SBSQL||']', 5);

    OPEN OCUDATACURSOR FOR SBSQL USING INUPACKAGEID, INUPACKAGEID, INUPACKAGEID, INUPACKAGEID, INUPACKAGEID, INUPACKAGEID;

    UT_TRACE.TRACE('Fin ldc_boPackage.GetAssoMotives', 5);
EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END GETASSOMOTIVES;




PROCEDURE GETATTACHFILES
(
    INUPACKAGE          IN   MO_PACKAGES.PACKAGE_ID%TYPE,
    OCUATTACHFILES      OUT  CONSTANTS.TYREFCURSOR
)
IS
    RCPACKAGE           DAMO_PACKAGES.STYMO_PACKAGES;
    TBOBJECTLEVEL       GE_TYTBSTRING := NEW GE_TYTBSTRING();
BEGIN

    RCPACKAGE := DAMO_PACKAGES.FRCGETRECORD(INUPACKAGE);

    TBOBJECTLEVEL.EXTEND(1);
    TBOBJECTLEVEL(TBOBJECTLEVEL.COUNT) := ldc_boPackage.CSBREQUEST;

    IF  RCPACKAGE.TAG_NAME = TT_BOCONSTANTS.CSBTAGNAMEINDDAMAGE THEN
        TBOBJECTLEVEL.EXTEND(1);
        TBOBJECTLEVEL(TBOBJECTLEVEL.COUNT) := TT_BOSEARCHDATASERVICES.CSBTT_FW_PRODUCT_DAMAGES;
    ELSIF RCPACKAGE.TAG_NAME = TT_BOCONSTANTS.CSBTAGNAMEMASSDAMAGE THEN
        TBOBJECTLEVEL.EXTEND(1);
        TBOBJECTLEVEL(TBOBJECTLEVEL.COUNT) := TT_BOSEARCHDATASERVICES.CSBTT_FW_PRODUCT_DAMAGES;
    END IF;


    CC_BOOSSATTACHFILES.GETATTACHEDFILES(TBOBJECTLEVEL, INUPACKAGE, OCUATTACHFILES);
EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END GETATTACHFILES;


PROCEDURE GETRESTRICTIONBYID
(
    INURESTRICTIONID    IN  MO_RESTRICTION.RESTRICTION_ID%TYPE,
    OCUDATACURSOR       OUT CONSTANTS.TYREFCURSOR
)
IS

    SBSQL     VARCHAR2(32767);

BEGIN
    UT_TRACE.TRACE('Iniciando ldc_boPackage.GetRestrictionById Impedimento['||INURESTRICTIONID||']', 5);


    SBRESTRICTIONATTRIBUTES := NULL;

    FILLRESTRICTIONATTRIBUTES;


    SBSQL := 'SELECT '|| SBRESTRICTIONATTRIBUTES ||CHR(10)||
             'FROM mo_restriction'||CHR(10)||
             'WHERE mo_restriction.restriction_id = :inuRestrictionId';

    UT_TRACE.TRACE('Consulta de un Restriccion ['||SBSQL||']', 5);

    OPEN OCUDATACURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INURESTRICTIONID;

    UT_TRACE.TRACE('Termina ldc_boPackage.GetRestrictionById ', 5);
EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;

    PROCEDURE GETPACKBYRESTRICTION
    (
        INURESTRICTIONID    IN  MO_RESTRICTION.RESTRICTION_ID%TYPE,
        ONUPACKAGEID        OUT MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS
    BEGIN
        IF INURESTRICTIONID IS NULL THEN
            ONUPACKAGEID := NULL;
            RETURN;
        END IF;

        DAMO_RESTRICTION.ACCKEY (INURESTRICTIONID);

        ONUPACKAGEID := DAMO_RESTRICTION.FNUGETPACKAGE_ID(INURESTRICTIONID);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ONUPACKAGEID := NULL;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE GETNOTIFICATIONS
    (
        INUPACKAGEID  IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQL  VARCHAR2(10000);
    BEGIN
        CC_BOOSSNOTIFICATION.FILLNOTIFICATIONATTRIBUTES;

        SBSQL := ' SELECT unique '||CC_BOOSSNOTIFICATION.SBNOTIFICATIONATTRIBUTES||CHR(10)||
                 ' FROM  VW_CC_NOTIFY_LOG_PACK'||CHR(10)||
                 ' WHERE VW_CC_NOTIFY_LOG_PACK.package_id = :inuPackageId'||CHR(10)||
                 ' ORDER BY VW_CC_NOTIFY_LOG_PACK.notification_log_id';

        UT_TRACE.TRACE('Consulta ['||SBSQL||']', 5);

        OPEN OCUDATACURSOR FOR SBSQL USING INUPACKAGEID, INUPACKAGEID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;




    PROCEDURE GETADMINACTIVITIES
    (
        INUPACKAGEID  IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQL  VARCHAR2(10000);
    BEGIN
        UT_TRACE.TRACE('Inicio de ldc_boPackage.GetAdminActivities Solicitud ['||INUPACKAGEID||']', 5);

        CC_BOOSSADMINACTIVITY.FILLADMINACTATTRIBUTES;

        SBSQL :=    ' SELECT  /*+ use_nl(pack mo_admin_activity)  */  '||CC_BOOSSADMINACTIVITY.SBADMINACTATTRIB||CHR(10)||
                    ' FROM mo_admin_activity, '||CHR(10)||
                            '(SELECT   b.component_id external_id, '|| CHR(39)|| TO_CHAR(CNUENTITY_COMPONENT) ||CHR(39)||' entity_id '||CHR(10)||
                                     ' FROM Mo_Component b '||CHR(10)||
                                     ' WHERE b.Package_Id = :inuPackageId '||CHR(10)||
                                     ' union all '||CHR(10)||
                            ' SELECT   b.motive_id  external_id, '|| CHR(39)|| TO_CHAR(CNUENTITY_MOTIVE) ||CHR(39)||' entity_id '||CHR(10)||
                                       ' FROM Mo_Motive b '||CHR(10)||
                                       ' WHERE b.Package_Id = :inuPackageId '||CHR(10)||
                                       ' union all '||CHR(10)||
                             ' SELECT  to_number(:inuPackageId) external_id , '|| CHR(39)|| TO_CHAR(CNUENTITY_PACKAGE) ||CHR(39)||' entity_id '||CHR(10)||
                                       ' FROM dual ) pack /*+ ldc_boPackage.GetAdminActivities */ '||CHR(10)||
                    ' WHERE mo_admin_activity.external_id = pack.external_id '||CHR(10)||
                    ' AND  mo_admin_activity.entity_id = pack.entity_id ';


        UT_TRACE.TRACE('Consulta ['||SBSQL||']', 6);

        OPEN OCUDATACURSOR FOR SBSQL USING INUPACKAGEID, INUPACKAGEID, INUPACKAGEID, INUPACKAGEID;

        UT_TRACE.TRACE('Fin de ldc_boPackage.GetAdminActivities', 5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    FUNCTION FRFGETDATESADDITIONALS
    RETURN CONSTANTS.TYREFCURSOR
    IS
        RFCURSOR    CONSTANTS.TYREFCURSOR;
        NUPACKAGE   MO_PACKAGES.PACKAGE_ID%TYPE;
        SBPACKAGE   GE_BOINSTANCECONTROL.STYSBVALUE;
    BEGIN


        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE
        (
            GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
            NULL,
            MO_BOCONSTANTS.CSBMO_PACKAGES,
            MO_BOCONSTANTS.CSBPACKAGE_ID,
            SBPACKAGE
        );


        NUPACKAGE :=  TO_NUMBER(SBPACKAGE);

        CC_BCOSSPACKAGE.GETDATESADDITIONALS(NUPACKAGE,RFCURSOR);

        RETURN RFCURSOR;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FRFGETDATESADDITIONALS;




    PROCEDURE GETPROMOTIONS
    (
        INUPACKAGE   IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        ORFCURSOR    OUT CONSTANTS.TYREFCURSOR
    )
    IS

    TBPROMOTIONATTRIBUTES       CC_TYTBATTRIBUTE;
    SBPROMOTIONATTRIBUTES       VARCHAR2(3000);
    SBSQL                       VARCHAR2(4000);
    SBHINT                      VARCHAR2(4000);
    SBPROMOTYPE                 VARCHAR2(200);
    SBPRODUCTTYPE               VARCHAR2(200);
    SBACTIVE                    VARCHAR2(200);
    SBDESCRIPCION               VARCHAR2(1000);

    BEGIN
        UT_TRACE.TRACE('Iniciando ldc_boPackage.GetPromotions Solicitud['||INUPACKAGE||']', 5);

        SBPROMOTYPE      := 'cc_promotion.PROM_TYPE_ID '    || CC_BOBOSSUTIL.CSBSEPARATOR || ' cc_prom_type.DESCRIPTION';
        SBPRODUCTTYPE    := 'cc_promotion.PRODUCT_TYPE_ID ' || CC_BOBOSSUTIL.CSBSEPARATOR || ' servicio.SERVDESC';
        SBDESCRIPCION    := 'cc_promotion.PROMOTION_ID '    || CC_BOBOSSUTIL.CSBSEPARATOR || ' cc_promotion.DESCRIPTION';


        CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_mot_promotion.PROMOTION_ID',    'id',                   CC_BOBOSSUTIL.CNUNUMBER,    SBPROMOTIONATTRIBUTES, TBPROMOTIONATTRIBUTES, TRUE);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBDESCRIPCION,                      'description',          CC_BOBOSSUTIL.CNUVARCHAR2,  SBPROMOTIONATTRIBUTES, TBPROMOTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_mot_promotion.REGISTER_DATE',   'register_date',        CC_BOBOSSUTIL.CNUDATE,      SBPROMOTIONATTRIBUTES, TBPROMOTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBPROMOTYPE,                        'type_promotion',       CC_BOBOSSUTIL.CNUVARCHAR2,  SBPROMOTIONATTRIBUTES, TBPROMOTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBPRODUCTTYPE,                      'type_product',         CC_BOBOSSUTIL.CNUVARCHAR2,  SBPROMOTIONATTRIBUTES, TBPROMOTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_promotion.INIT_APPLY_DATE',     'date_ini_apply',       CC_BOBOSSUTIL.CNUDATE,      SBPROMOTIONATTRIBUTES, TBPROMOTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_promotion.FINAL_APPLY_DATE',    'date_fin_apply',       CC_BOBOSSUTIL.CNUDATE,      SBPROMOTIONATTRIBUTES, TBPROMOTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_promotion.AMOUNT_PERIODS',      'amount_periods',       CC_BOBOSSUTIL.CNUNUMBER,    SBPROMOTIONATTRIBUTES, TBPROMOTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_mot_promotion.ACTIVE',          'active',               CC_BOBOSSUTIL.CNUVARCHAR2,  SBPROMOTIONATTRIBUTES, TBPROMOTIONATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (':parent_id',                       'parent_id',            CC_BOBOSSUTIL.CNUNUMBER,    SBPROMOTIONATTRIBUTES, TBPROMOTIONATTRIBUTES);

        SBHINT :=  '/*+ leading (mo_motive)
                        use_nl  (mo_motive mo_mot_promotion)
                        use_nl  (mo_mot_promotion cc_promotion)
                        use_nl  (cc_promotion cc_prom_type)
                        use_nl  (cc_promotion servicio)
                        index   (cc_promotion PK_CC_PROMOTION)
                        index   (mo_mot_promotion IDX_MO_MOT_PROMOTION01)
                        index   (servicio PK_SERVICIO)
                   */ ';
        SBSQL :=
             'SELECT '|| SBHINT|| SBPROMOTIONATTRIBUTES                                                 ||CHR(10)||
             '  FROM MO_MOTIVE, MO_MOT_PROMOTION, CC_PROMOTION, CC_PROM_TYPE, SERVICIO /*+ ldc_boPackage.GetPromotions */ '       ||CHR(10)||
             ' WHERE mo_motive.PACKAGE_ID = :inuPackageId '                                    ||CHR(10)||
             '  AND  mo_mot_promotion.MOTIVE_ID = mo_motive.MOTIVE_ID '                        ||CHR(10)||
             '  AND  mo_mot_promotion.PROMOTION_ID = cc_promotion.PROMOTION_ID '               ||CHR(10)||
             '  AND  cc_promotion.PROM_TYPE_ID  = cc_prom_type.PROM_TYPE_ID '                  ||CHR(10)||
             '  AND  cc_promotion.PRODUCT_TYPE_ID = servicio.SERVCODI ';


        OPEN ORFCURSOR FOR SBSQL USING INUPACKAGE, INUPACKAGE;

        UT_TRACE.TRACE('Fin de ldc_boPackage.GetPromotions ', 5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETPROMOTIONS;



    PROCEDURE GETAPPRAMOUNREQUQUERY
    (
        OSBSQLHINTS                 OUT         VARCHAR2,
        OSBSQLQUERY                 OUT         VARCHAR2
    )
    IS
        NUAPPRAMOUREQUEST       PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%TYPE;
        NUXMLREESREQUEST        PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%TYPE;
    BEGIN

        UT_TRACE.TRACE('Inicio [ldc_boPackage.GetApprAmounRequQuery]', 1);


        NUAPPRAMOUREQUEST :=  PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME (
                                PS_BOPACKAGETYPE.CSBNOTE_PACK_TYPE_TAG_NAME
                              );


        NUXMLREESREQUEST :=  PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME (
                                PS_BOPACKAGETYPE.CSBREES_PACK_TYPE_TAG_NAME
                              );



        OSBSQLHINTS     :=  'select /*+ '||CHR(10)||
                            'use_nl(a b)'||CHR(10)||
                            'use_nl(b d)'||CHR(10)||
                            'use_nl(d c)'||CHR(10)||
                            'index(a, IDX_MO_PACKAGES_01)'||CHR(10)||
                            'index(a, IDX_MO_PACKAGES_02)'||CHR(10)||
                            'index(b, IDX_MO_MOTIVE_02)'||CHR(10)||
                            'index(c, PK_PS_MOTIVE_STATUS)'||CHR(10);


        OSBSQLQUERY     :=  'a.package_id, '||CHR(10)||
                            'a.cust_care_reques_num interaction, '||CHR(10)||
                            'a.request_date, '||CHR(10)||
                            'a.motive_status_id'||CC_BOBOSSUTIL.CSBSEPARATOR||'c.description package_status, '||CHR(10)||
                            'b.causal_id'||CC_BOBOSSUTIL.CSBSEPARATOR||'n.description causal, '||CHR(10)||
                            'b.answer_id'||CC_BOBOSSUTIL.CSBSEPARATOR||'o.description answer, '||CHR(10)||
                            'b.subscription_id, '||CHR(10)||
                            'd.ident_type_id'||CC_BOBOSSUTIL.CSBSEPARATOR||'l.description identification_type, '||CHR(10)||
                            'd.identification identification, '||CHR(10)||
                            'd.subscriber_name, '||CHR(10)||
                            'd.subs_last_name, '||CHR(10)||
                            'a.contact_id'||CC_BOBOSSUTIL.CSBSEPARATOR||'e.subscriber_name ||' || CHR(39)||' '||CHR(39)||'|| ' ||
                                'e.subs_last_name contact, '||CHR(10)||
                            'a.organizat_area_id'||CC_BOBOSSUTIL.CSBSEPARATOR||'f.display_description causing_area, '||CHR(10)||
                            'a.management_area_id'||CC_BOBOSSUTIL.CSBSEPARATOR||'g.display_description management_area, '||CHR(10)||
                            'a.comment_, '||CHR(10)||
                            'a.reception_type_id'||CC_BOBOSSUTIL.CSBSEPARATOR ||'p.description reception_type, '||CHR(10)||
                            'CC_BOClaimInstanceData.fnuGetClaimedValue(a.package_id) claimed_value, '||CHR(10)||
                            'a.person_id'||CC_BOBOSSUTIL.CSBSEPARATOR||'h.name_ employee, '||CHR(10)||
                            'CC_BOClaimInstanceData.fnuGetClaimedBill(a.package_id) bill_number, '||CHR(10)||
                            'CC_BOClaimInstanceData.fnuGetClaimedBillFiscN(a.package_id) fiscal_number, '||CHR(10)||
                            'CC_BOClaimInstanceData.fnuGetClaimedBillPrefi(a.package_id) fiscal_prefix, '||CHR(10)||
                            'a.pos_oper_unit_id'||CC_BOBOSSUTIL.CSBSEPARATOR||'i.name operating_unit, '||CHR(10)||
                            'a.expect_atten_date, '||CHR(10)||
                            'a.attention_date, '||CHR(10)||
                            'a.company_id'||CC_BOBOSSUTIL.CSBSEPARATOR ||'m.sistempr company, '||CHR(10)||
                            'a.answer_mode_id'||CC_BOBOSSUTIL.CSBSEPARATOR||'j.description answer_mode, '||CHR(10)||
                            'k.address_parsed answer_address, '||CHR(10)||
                            'k.neighborthood_id'||CC_BOBOSSUTIL.CSBSEPARATOR||'nei.description answer_neighborthood, '||CHR(10)||
                            'k.geograp_location_id'||CC_BOBOSSUTIL.CSBSEPARATOR||'loc.description answer_town, '||CHR(10)||
                            ':parent_id parent_id'||CHR(10)||

                            'from mo_packages a, mo_motive b, ps_motive_status c, ge_subscriber d, ge_subscriber e, '||CHR(10)||
                            'ge_organizat_area f, ge_organizat_area g, ge_person h, or_operating_unit i, cc_answer_mode j, '||CHR(10)||
                            'ab_address k, ge_geogra_location loc, ge_geogra_location nei, ge_identifica_type l, sistema m, '||CHR(10)||
                            'cc_causal n, cc_answer o, ge_reception_type p '||'/*+ ldc_boPackage.GetApprAmounRequQuery */'||CHR(10)||

                            'where b.package_id = a.package_id '||CHR(10)||
                            'and b.causal_id = n.causal_id(+) '||CHR(10)||
                            'and b.answer_id = o.answer_id(+)  '||CHR(10)||
                            'and a.contact_id = e.subscriber_id(+) '||CHR(10)||
                            'and a.subscriber_id = d.subscriber_id(+) '||CHR(10)||
                            'and a.motive_status_id = c.motive_status_id '||CHR(10)||
                            'and d.ident_type_id = l.ident_type_id(+) '||CHR(10)||
                            'and a.organizat_area_id = f.organizat_area_id(+) '||CHR(10)||
                            'and a.management_area_id = g.organizat_area_id(+) '||CHR(10)||
                            'and a.reception_type_id = p.reception_type_id(+) '||CHR(10)||
                            'and a.person_id = h.person_id(+) '||CHR(10)||
                            'and a.pos_oper_unit_id = i.operating_unit_id(+) '||CHR(10)||
                            'and a.company_id = m.sistcodi '||CHR(10)||
                            'and a.answer_mode_id = j.answer_mode_id(+) '||CHR(10)||
                            'and a.address_id = k.address_id(+) '||CHR(10)||
                            'and k.neighborthood_id = nei.geograp_location_id(+) '||CHR(10)||
                            'and k.geograp_location_id = loc.geograp_location_id(+)'||CHR(10)||

                            'and a.package_type_id in ('||NUAPPRAMOUREQUEST||','||NUXMLREESREQUEST||') '||CHR(10);

        UT_TRACE.TRACE('Fin [ldc_boPackage.GetApprAmounRequQuery] ', 1);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR [ldc_boPackage.GetApprAmounRequQuery]', 1);
          RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('OTHERS [ldc_boPackage.GetApprAmounRequQuery]', 1);
            RAISE EX.CONTROLLED_ERROR;

    END GETAPPRAMOUNREQUQUERY;



    PROCEDURE FINDAPPRAMOUNREQUEST
    (
        INUSUBSCRIPTIONID           IN          MO_MOTIVE.SUBSCRIPTION_ID%TYPE,
        INUPACKAGE_ID               IN          MO_PACKAGES.PACKAGE_ID%TYPE,
        INUINTERACTION              IN          MO_PACKAGES.CUST_CARE_REQUES_NUM%TYPE,
        ISBIDENTIFICATION           IN          GE_SUBSCRIBER.IDENTIFICATION%TYPE,
        ISBNAME                     IN          GE_SUBSCRIBER.SUBSCRIBER_NAME%TYPE,
        ISBLASTNAME                 IN          GE_SUBSCRIBER.SUBS_LAST_NAME%TYPE,
        IDTINITIALDATE              IN          MO_PACKAGES.REQUEST_DATE%TYPE,
        IDTFINALDATE                IN          MO_PACKAGES.REQUEST_DATE%TYPE,
        INUPACKAGESTATUSID          IN          MO_PACKAGES.MOTIVE_STATUS_ID%TYPE,
        IDTINICIEXPECATTEND         IN          MO_PACKAGES.EXPECT_ATTEN_DATE%TYPE,
        IDTFINALEXPECATTEND         IN          MO_PACKAGES.EXPECT_ATTEN_DATE%TYPE,
        OCUCURSOR                   OUT         CONSTANTS.TYREFCURSOR
    )
    IS
        NUSUBSCRIPTIONID                        MO_MOTIVE.SUBSCRIPTION_ID%TYPE;
        NUPACKAGE_ID                            MO_PACKAGES.PACKAGE_ID%TYPE;
        NUINTERACTION                           MO_PACKAGES.CUST_CARE_REQUES_NUM%TYPE;
        SBIDENTIFICATION                        GE_SUBSCRIBER.IDENTIFICATION%TYPE;
        SBNAME                                  GE_SUBSCRIBER.SUBSCRIBER_NAME%TYPE;
        SBLASTNAME                              GE_SUBSCRIBER.SUBS_LAST_NAME%TYPE;
        DTINITIALDATE                           MO_PACKAGES.REQUEST_DATE%TYPE;
        DTFINALDATE                             MO_PACKAGES.REQUEST_DATE%TYPE;
        NUPACKAGESTATUSID                       MO_PACKAGES.MOTIVE_STATUS_ID%TYPE;
        DTINICIEXPECATTEND                      MO_PACKAGES.EXPECT_ATTEN_DATE%TYPE;
        DTFINALEXPECATTEND                      MO_PACKAGES.EXPECT_ATTEN_DATE%TYPE;
        NUPARENT                                MO_PACKAGES.PACKAGE_ID%TYPE;

        SBSQLHINTS                              VARCHAR2(32767);
        SBSQLQUERY                              VARCHAR2(32767);
        SBSQLWHERE                              VARCHAR2(32767);
        SBPARTIALSQLHINTS                       VARCHAR2(32767);
        SBPARTIALSQLQUERY                       VARCHAR2(32767);
    BEGIN

        UT_TRACE.TRACE('Inicio [ldc_boPackage.FindApprAmounRequest]', 1);


        IF( IDTINITIALDATE IS NOT NULL OR IDTFINALDATE IS NOT NULL ) THEN

            DTINITIALDATE := IDTINITIALDATE;
            DTFINALDATE := IDTFINALDATE;
            CC_BOBOSSUTIL.QUERYTYPEDATES
            (
                CC_BOBOSSUTIL.FNUQUERYBYBETWEEN,
                NULL,
                DTINITIALDATE,
                DTFINALDATE
            );

        END IF;


        IF( IDTINICIEXPECATTEND IS NOT NULL OR IDTFINALEXPECATTEND IS NOT NULL) THEN

            DTINITIALDATE:=IDTINICIEXPECATTEND;
            DTFINALDATE := IDTFINALEXPECATTEND;

            CC_BOBOSSUTIL.QUERYTYPEDATES
            (
                CC_BOBOSSUTIL.FNUQUERYBYBETWEEN,
                NULL,
                DTINITIALDATE,
                DTFINALDATE
            );

        END IF;

        NUSUBSCRIPTIONID := NVL(INUSUBSCRIPTIONID, CC_BOCONSTANTS.CNUAPPLICATIONNULL);
        NUPACKAGE_ID := NVL(INUPACKAGE_ID, CC_BOCONSTANTS.CNUAPPLICATIONNULL);
        NUINTERACTION := NVL(INUINTERACTION, CC_BOCONSTANTS.CNUAPPLICATIONNULL);
        SBIDENTIFICATION := UPPER( TRIM ( NVL ( ISBIDENTIFICATION, CC_BOCONSTANTS.CSBNULLSTRING ) ) );
        SBNAME := UPPER( TRIM ( NVL ( ISBNAME, CC_BOCONSTANTS.CSBNULLSTRING ) ) );
        SBLASTNAME := UPPER( TRIM ( NVL ( ISBLASTNAME, CC_BOCONSTANTS.CSBNULLSTRING ) ) );
        DTINITIALDATE := NVL (IDTINITIALDATE, UT_DATE.FDTMINDATE);
        DTFINALDATE   := NVL (IDTFINALDATE,   UT_DATE.FDTMAXDATE);
        NUPACKAGESTATUSID := NVL(INUPACKAGESTATUSID, CC_BOCONSTANTS.CNUAPPLICATIONNULL);
        DTINICIEXPECATTEND := NVL (IDTINICIEXPECATTEND, UT_DATE.FDTMINDATE);
        DTFINALEXPECATTEND := NVL (IDTFINALEXPECATTEND, UT_DATE.FDTMAXDATE);



        IF( NUSUBSCRIPTIONID != CC_BOCONSTANTS.CNUAPPLICATIONNULL ) THEN

            SBSQLWHERE := SBSQLWHERE || 'and b.subscription_id = :subscription_id'||CHR(10);

        ELSE

            SBSQLWHERE := SBSQLWHERE||'and '||NUSUBSCRIPTIONID||' = :subscription_id'||CHR(10);

        END IF;


        IF( NUPACKAGE_ID != CC_BOCONSTANTS.CNUAPPLICATIONNULL ) THEN

            SBSQLWHERE := SBSQLWHERE || 'and a.package_id = :package_id'||CHR(10);

        ELSE

            SBSQLWHERE := SBSQLWHERE||'and '||NUPACKAGE_ID||' = :package_id'||CHR(10);

        END IF;


        IF( NUINTERACTION != CC_BOCONSTANTS.CNUAPPLICATIONNULL ) THEN

            SBSQLHINTS := SBSQLHINTS || 'index(a, IDX_MO_PACKAGES_12)'||CHR(10);
            SBSQLWHERE := SBSQLWHERE || 'and a.cust_care_reques_num = :interaction'||CHR(10);

        ELSE

            SBSQLWHERE := SBSQLWHERE||'and '||NUINTERACTION||' = :interaction'||CHR(10);

        END IF;


        IF( SBIDENTIFICATION != CC_BOCONSTANTS.CSBNULLSTRING ) THEN

            SBSQLHINTS := SBSQLHINTS || 'index(d, IDX_GE_SUBSCRIBER_02)'||CHR(10);
            SBSQLWHERE := SBSQLWHERE || 'and d.identification like :identification||'||CHR(39)||'%'||CHR(39)||CHR(10);

        ELSE

            SBSQLWHERE := SBSQLWHERE||'and '||SBIDENTIFICATION||' = :identification'||CHR(10);

        END IF;


        IF( SBNAME != CC_BOCONSTANTS.CSBNULLSTRING ) THEN

            SBSQLHINTS := SBSQLHINTS || 'index(d, IDX_GE_SUBSCRIBER_04)'||CHR(10);
            SBSQLWHERE := SBSQLWHERE || 'and d.subscriber_name like :name||'||CHR(39)||'%'||CHR(39)||CHR(10);

        ELSE

            SBSQLWHERE := SBSQLWHERE||'and '||SBNAME||' = :name'||CHR(10);

        END IF;


        IF( SBLASTNAME != CC_BOCONSTANTS.CSBNULLSTRING ) THEN

            SBSQLHINTS := SBSQLHINTS || 'index(d, IDX_GE_SUBSCRIBER_05)'||CHR(10);
            SBSQLWHERE := SBSQLWHERE || 'and d.subs_last_name like :last_name||'||CHR(39)||'%'||CHR(39)||CHR(10);

        ELSE

            SBSQLWHERE := SBSQLWHERE||'and '||SBLASTNAME||' = :last_name'||CHR(10);

        END IF;


        IF( NUPACKAGESTATUSID != CC_BOCONSTANTS.CNUAPPLICATIONNULL ) THEN

            SBSQLWHERE := SBSQLWHERE || 'and a.motive_status_id = :status'||CHR(10);

        ELSE

            SBSQLWHERE := SBSQLWHERE||'and '||NUPACKAGESTATUSID||' = :status'||CHR(10);

        END IF;


        SBSQLWHERE := SBSQLWHERE || 'and a.request_date >= :initial_date'||CHR(10);
        SBSQLWHERE := SBSQLWHERE || 'and a.request_date <= :final_date'||CHR(10);


        SBSQLWHERE := SBSQLWHERE || 'and nvl(a.expect_atten_date,ut_date.fdtMinDate) >= :limit_initial_date'||CHR(10);
        SBSQLWHERE := SBSQLWHERE || 'and nvl(a.expect_atten_date,ut_date.fdtMaxDate) <= :limit_final_date'||CHR(10);

        IF( DTINITIALDATE != UT_DATE.FDTMINDATE AND DTFINALDATE != UT_DATE.FDTMAXDATE ) THEN

            SBSQLHINTS := SBSQLHINTS || 'index(a, IDX_MO_PACKAGES_015)'||CHR(10);

        END IF;

        SBSQLHINTS := SBSQLHINTS||'*/'||CHR(10);


        GETAPPRAMOUNREQUQUERY
        (
            SBPARTIALSQLHINTS,
            SBPARTIALSQLQUERY
        );

        SBSQLQUERY :=  SBPARTIALSQLHINTS||SBSQLHINTS||SBPARTIALSQLQUERY||SBSQLWHERE;

        UT_TRACE.TRACE('sbSqlQuery: '||CHR(10)||SBSQLQUERY||CHR(10)||CHR(10),1);

        NUPARENT := NULL;

        OPEN    OCUCURSOR
        FOR     SBSQLQUERY
        USING   NUPARENT,
                NUSUBSCRIPTIONID,
                NUPACKAGE_ID,
                NUINTERACTION,
                SBIDENTIFICATION,
                SBNAME,
                SBLASTNAME,
                NUPACKAGESTATUSID,
                DTINITIALDATE,
                DTFINALDATE,
                DTINICIEXPECATTEND,
                DTFINALEXPECATTEND;


        UT_TRACE.TRACE('Fin [ldc_boPackage.FindApprAmounRequest]', 1);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR [ldc_boPackage.FindApprAmounRequest]', 1);
          RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('OTHERS [ldc_boPackage.FindApprAmounRequest]', 1);
            RAISE EX.CONTROLLED_ERROR;

    END FINDAPPRAMOUNREQUEST;




    PROCEDURE SEARCHAPPRAMOUNREQUEST
    (
        INUPACKAGE_ID               IN          MO_PACKAGES.PACKAGE_ID%TYPE,
        OCUCURSOR                   OUT         CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQLHINTS                              VARCHAR2(32767);
        SBSQLQUERY                              VARCHAR2(32767);
        SBSQLWHERE                              VARCHAR2(32767);
        SBPARTIALSQLHINTS                       VARCHAR2(32767);
        SBPARTIALSQLQUERY                       VARCHAR2(32767);
    BEGIN

        UT_TRACE.TRACE('Inicio [ldc_boPackage.SearchApprAmounRequest]', 1);

        SBSQLWHERE := 'and a.package_id = :package_id';


        GETAPPRAMOUNREQUQUERY
        (
            SBPARTIALSQLHINTS,
            SBPARTIALSQLQUERY
        );

        SBSQLQUERY :=  SBPARTIALSQLHINTS||' */'||SBPARTIALSQLQUERY||SBSQLWHERE;

        UT_TRACE.TRACE('sbSqlQuery: '||CHR(10)||SBSQLQUERY,1);

        OPEN    OCUCURSOR
        FOR     SBSQLQUERY
        USING   CC_BOBOSSUTIL.CNUNULL,
                INUPACKAGE_ID;

        UT_TRACE.TRACE('Fin [ldc_boPackage.SearchApprAmounRequest]', 1);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR [ldc_boPackage.SearchApprAmounRequest]', 1);
          RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('OTHERS [ldc_boPackage.SearchApprAmounRequest]', 1);
            RAISE EX.CONTROLLED_ERROR;

    END SEARCHAPPRAMOUNREQUEST;



    PROCEDURE FINDAPPRAMOUNREQBYSUS
    (
        INUSUBSCRIPTIONID           IN          MO_MOTIVE.SUBSCRIPTION_ID%TYPE,
        OCUCURSOR                   OUT         CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQLSQLHINTS                           VARCHAR2(32767);
        SBSQLQUERY                              VARCHAR2(32767);
        SBSQLWHERE                              VARCHAR2(32767);
        SBPARTIALSQLHINTS                       VARCHAR2(32767);
        SBPARTIALSQLQUERY                       VARCHAR2(32767);
    BEGIN

        UT_TRACE.TRACE('Inicio [ldc_boPackage.FindApprAmounReqBySus]', 1);

        SBSQLSQLHINTS := 'index(b, IDX_MO_MOTIVE_03) */';
        SBSQLWHERE := SBSQLWHERE || 'and b.subscription_id = :subscription';


        GETAPPRAMOUNREQUQUERY
        (
            SBPARTIALSQLHINTS,
            SBPARTIALSQLQUERY
        );

        SBSQLQUERY :=  SBPARTIALSQLHINTS||SBSQLSQLHINTS||CHR(10)||SBPARTIALSQLQUERY||SBSQLWHERE;

        UT_TRACE.TRACE('sbSqlQuery: '||CHR(10)||SBSQLQUERY||CHR(10),1);

        OPEN    OCUCURSOR
        FOR     SBSQLQUERY
        USING   INUSUBSCRIPTIONID,
                INUSUBSCRIPTIONID;

        UT_TRACE.TRACE('Fin [ldc_boPackage.FindApprAmounReqBySus]', 1);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR [ldc_boPackage.FindApprAmounReqBySus]', 1);
          RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('OTHERS [ldc_boPackage.FindApprAmounReqBySus]', 1);
            RAISE EX.CONTROLLED_ERROR;

    END FINDAPPRAMOUNREQBYSUS;


    PROCEDURE GETNTLREQUEST
    (
        INUNTLID      IN NUMBER,
        OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQL  VARCHAR2(32767);
    BEGIN

        UT_TRACE.TRACE('Inicio: ldc_boPackage.GetNTLRequest',1);
        FILLPACKAGEATTRIBUTES;


        SBSQL := 'SELECT '|| SBPACKAGEATTRIBUTES                 || CHR(10) ||
                 'FROM ' || SBPACKAGEFROM || ', fm_possible_ntl /*+ cc_boRequest.GetNTLRequest */ ' || CHR(10) ||
                 'WHERE ' || 'a.package_id = fm_possible_ntl.package_id'     || CHR(10) ||
                 'AND '   || 'fm_possible_ntl.possible_ntl_id = :inuPossibleNTL' || CHR(10) ||
                 'AND '   || SBPACKAGEWHERE                      || CHR(10) ||
                 'ORDER BY request_date DESC';

        OPEN OCUDATACURSOR FOR SBSQL USING INUNTLID, INUNTLID;

        UT_TRACE.TRACE('Sentencia:'||CHR(10)||SBSQL,2);
        UT_TRACE.TRACE('Fin: ldc_boPackage.GetNTLRequest',1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;



    PROCEDURE GETSUBSCRIBERREQUEST
    (
        INUSUBSCRIBER IN NUMBER,
        OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQL  VARCHAR2(32767);
        SBPACKAGEHINTS    VARCHAR2(6000);
    BEGIN

        UT_TRACE.TRACE('Inicio: ldc_boPackage.GetSubscriberRequest',1);
        FILLPACKAGEATTRIBUTES;


        SBSQL := 'SELECT '|| SBPACKAGEATTRIBUTES                 || CHR(10) ||
                 'FROM ' || SBPACKAGEFROM || ' /*+ ldc_boPackage.GetSubscriberRequest */ ' || CHR(10) ||
                 'WHERE ' || 'a.subscriber_id = :Subscriber'     || CHR(10) ||
                 'AND '   || SBPACKAGEWHERE                      || CHR(10) ||
                 'ORDER BY request_date DESC';

        OPEN OCUDATACURSOR FOR SBSQL USING INUSUBSCRIBER, INUSUBSCRIBER;

        UT_TRACE.TRACE('Sentencia:'||CHR(10)||SBSQL,2);
        UT_TRACE.TRACE('Fin: ldc_boPackage.GetSubscriberRequest',1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;



    PROCEDURE FILLCLAIMATTRIBUTES
    IS
        SBATTRIBUTES        VARCHAR2(32767);

        SBCLAIMVALUE        VARCHAR2(400);
        SBCLAIMACEPTVALUE   VARCHAR2(400);
        SBCLAIMADJUST       VARCHAR2(400);
        SBBILL              VARCHAR2(400);
        SBBILLACCOUNT       VARCHAR2(400);


        SBLEGALBILLPREF     VARCHAR2(400);
        SBLEGALBILLACCOUNT  VARCHAR2(400);


        NURECLAIM           NUMBER(4);

    BEGIN
        UT_TRACE.TRACE('Inicio: ldc_boPackage.FillClaimAttributes()',4);
        IF (SBCLAIMSQL IS NOT NULL) THEN
            RETURN;
        END IF;

        SBCLAIMVALUE       := 'cc_boBssUtil.fnuTotalClaimValue(mo_packages.package_id)';
        SBCLAIMACEPTVALUE  := 'cc_boBssUtil.fnuTotalClaimAceptValue(mo_packages.package_id)';
        SBCLAIMADJUST      := 'cc_boBssUtil.fnuTotalClaimAdjust(mo_packages.package_id)';

        SBBILLACCOUNT   := 'cc_boBssUtil.fnuTotalClaimBillAccount(mo_packages.package_id)';
        SBBILL          := 'cc_boBssUtil.fnuTotalClaimBill(mo_packages.package_id)';


        SBLEGALBILLPREF    := 'cc_bobssutil.fsbTotalClaimPrefBillAccount(mo_packages.package_id)';
        SBLEGALBILLACCOUNT := 'cc_bobssutil.fnuTotalClaimLegalBillAccount(mo_packages.package_id)';


        NURECLAIM       := PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME(PS_BOPACKAGETYPE.CSBTAGRECLAIM);

        SBATTRIBUTES := SBCLAIMVALUE       ||' "Valor Reclamo",'                 || CHR(10) ||
                        SBCLAIMACEPTVALUE  ||' "Valor Aceptado",'                || CHR(10) ||
                        SBCLAIMADJUST      ||' "Valor Ajuste",'                  || CHR(10) ||
                        SBBILLACCOUNT      ||' "Estado de Cuenta",'              || CHR(10) ||
                        SBBILL             ||' "Cuenta de Cobro",'               || CHR(10) ||
                        SBLEGALBILLPREF    ||' "Prefijo", '                      || CHR(10) ||
                        SBLEGALBILLACCOUNT ||' "N?mero Fiscal"'                  || CHR(10)  ;

        SBCLAIMSQL := 'SELECT /*+ index(mo_packages PK_MO_PACKAGES) */ '         || CHR(10) ||
                            SBATTRIBUTES                                         || CHR(10) ||
                      'FROM  mo_packages'                                        || CHR(10) ||
                            '/*+ ldc_boPackage.FillClaimAttributes */'            || CHR(10) ||
                      'WHERE mo_packages.package_type_id+0 in ('||NURECLAIM||')';

        UT_TRACE.TRACE('Fin: ldc_boPackage.FillClaimAttributes()',4);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FILLCLAIMATTRIBUTES;


    FUNCTION FRFGETDATACLAIM
    RETURN CONSTANTS.TYREFCURSOR
    IS
        SBELEMENTID   GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        INUREQUESTID  MO_PACKAGES.PACKAGE_ID%TYPE;
        SBSQL         VARCHAR2(32767);
        OCUCURSOR     CONSTANTS.TYREFCURSOR;
    BEGIN
        UT_TRACE.TRACE('Inicio: ldc_boPackage.frfGetDataClaim',3);


        GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE(GE_BOINSTANCECONSTANTS.CSBGLOBAL_ID,SBELEMENTID);

        IF (SBELEMENTID IS NOT NULL) THEN
            IF (UT_STRING.EXTSTRFIELD(SBELEMENTID,'-',1) IS NOT NULL) THEN
                INUREQUESTID := TO_NUMBER(TRIM(UT_STRING.EXTSTRFIELD(SBELEMENTID,'-',1)));
            ELSE
                INUREQUESTID := TO_NUMBER(TRIM(SBELEMENTID));
            END IF;
        ELSE
            INUREQUESTID := NULL;
        END IF;


        FILLCLAIMATTRIBUTES;
        SBSQL := SBCLAIMSQL || ' and mo_packages.package_id = :inuRequestId';

        UT_TRACE.TRACE( 'Cons: '||SBSQL, 4 );

        OPEN OCUCURSOR FOR SBSQL USING  INUREQUESTID;

        UT_TRACE.TRACE('Fin: ldc_boPackage.frfGetDataClaim',3);

        RETURN OCUCURSOR;
    EXCEPTION
        WHEN  EX.CONTROLLED_ERROR THEN
           RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FRFGETDATACLAIM;



    FUNCTION FRFGETADDDATAREQUEST
    RETURN CONSTANTS.TYREFCURSOR
    IS

        RFCURSOR    CONSTANTS.TYREFCURSOR;
        NUPACKAGE   MO_PACKAGES.PACKAGE_ID%TYPE;
        SBPACKAGE   GE_BOINSTANCECONTROL.STYSBVALUE;

    BEGIN
        UT_TRACE.TRACE('INICIO ldc_boPackage.frfGetAddDataRequest', 5);


        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE
        (
            GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
            NULL,
            MO_BOCONSTANTS.CSBMO_PACKAGES,
            MO_BOCONSTANTS.CSBPACKAGE_ID,
            SBPACKAGE
        );


        NUPACKAGE :=  TO_NUMBER(SBPACKAGE);

        CC_BCOSSPACKAGE.GETADDDATAREQUEST(NUPACKAGE,RFCURSOR);

        UT_TRACE.TRACE('TERMINA ldc_boPackage.frfGetAddDataRequest', 5);
        RETURN RFCURSOR;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FRFGETADDDATAREQUEST;



    PROCEDURE GETREVIEWPACKAGE
    (
        INUPACKAGEID    IN  NUMBER,
        ORFCURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS

    SBSQL             VARCHAR2(32767);
    SBPACKAGEHINTS    VARCHAR2(6000);

    BEGIN

        FILLPACKAGEATTRIBUTES;

        SBPACKAGEHINTS  :=  '/*+ leading (a) use_nl(a b) use_nl(a c) use_nl(a e)'       ||CHR(10)||
                            'use_nl(a f) use_nl(a g) use_nl(a r) use_nl(r s)'           ||CHR(10)||
                            'use_nl(a k) use_nl(a l) use_nl(a m) use_nl(a n)'           ||CHR(10)||
                            'use_nl(a o) use_nl(a p) use_nl(a q) use_nl(s u)'           ||CHR(10)||
                            'index (a PK_MO_PACKAGES) index (f PK_GE_PERSON)'           ||CHR(10)||
                            'index (g PK_GE_ORGANIZAT_AREA) index (r PK_GE_SUBSCRIBER)' ||CHR(10)||
                            'index (s PK_AB_ADDRESS) index (k PK_OR_OPERATING_UNIT)'    ||CHR(10)||
                            'index (l PK_PM_PROJECT) index (o PK_GE_SUBSCRIBER)'        ||CHR(10)||
                            'index (p PK_AB_ADDRESS)index (u PK_GE_GEOGRA_LOCATION) */';

        SBSQL := 'SELECT '|| SBPACKAGEHINTS                      || CHR(10) ||
                             SBPACKAGEATTRIBUTES                 || CHR(10) ||
                 'FROM '  || '/*+ ldc_boPackage.GetPackage */' || CHR(10) ||
                             SBPACKAGEFROM                       || CHR(10) ||
                 'WHERE ' || 'a.package_id = :Package'           || CHR(10) ||
                 'AND '   || SBPACKAGEWHERE                      || CHR(10) ||
                 'AND '   || 'a.package_type_id in (select package_type_id FROM ps_package_type WHERE tag_name in (''P_SOLICITUD_DE_REVISION_266'',''P_REVISION_PERIODICA_MASIVA_265'') )'|| CHR(10) ||
                 'ORDER BY a.request_date desc';

        UT_TRACE.TRACE('Consulta: ['||SBSQL||'] - ['||INUPACKAGEID||']', 1);

        OPEN ORFCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INUPACKAGEID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    PROCEDURE GETREVIEWPACKAGES
    (
        INUPACKAGEID        IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        INUCUSTREQUESTNUM   IN  MO_PACKAGES.CUST_CARE_REQUES_NUM%TYPE,
        ISBSERVICENUMBER    IN  PR_PRODUCT.SERVICE_NUMBER%TYPE,
        OCUCURSOR           OUT CONSTANTS.TYREFCURSOR
    )
    IS
        NUPACKAGEID         MO_PACKAGES.PACKAGE_ID%TYPE;
        NUCUSTREQUESTNUM    MO_PACKAGES.CUST_CARE_REQUES_NUM%TYPE;

        SBSQL               VARCHAR2(32767) := '';
        SBPACKAGEHINTS      VARCHAR2(6000)  := '';
        SBHINTS             VARCHAR2(6000)  := NULL;
        SBWHERE             VARCHAR2(6000)  := '';

    BEGIN

        UT_TRACE.TRACE('Inicia ldc_boPackage.getPackages '||INUPACKAGEID|| ' ' ||INUCUSTREQUESTNUM||' '||ISBSERVICENUMBER,6 );


        NUPACKAGEID     := NVL (INUPACKAGEID, CC_BOCONSTANTS.CNUAPPLICATIONNULL);
        NUCUSTREQUESTNUM:= NVL(INUCUSTREQUESTNUM, CC_BOCONSTANTS.CNUAPPLICATIONNULL);


        FILLPACKAGEATTRIBUTES;

        IF (INUPACKAGEID IS NOT NULL OR INUCUSTREQUESTNUM IS NOT NULL) THEN
            SBPACKAGEHINTS  := 'leading (a) use_nl(a b) use_nl(a c) use_nl(a e)'        ||CHR(10)||
                               'use_nl(a f) use_nl(a g) use_nl(a r) use_nl(r s)'        ||CHR(10)||
                               'use_nl(a k) use_nl(a l) use_nl(a m) use_nl(a n)'        ||CHR(10)||
                               'use_nl(a o) use_nl(a p) use_nl(a q) use_nl(s u)'        ||CHR(10)||
                               'index (f PK_GE_PERSON) index (g PK_GE_ORGANIZAT_AREA)'  ||CHR(10)||
                               'index (r PK_GE_SUBSCRIBER) index (s PK_AB_ADDRESS)'     ||CHR(10)||
                               'index (k PK_OR_OPERATING_UNIT) index (l PK_PM_PROJECT)' ||CHR(10)||
                               'index (o PK_GE_SUBSCRIBER) index (p PK_AB_ADDRESS) index (u PK_GE_GEOGRA_LOCATION)';
        ELSE
            SBPACKAGEHINTS  := 'use_nl(a b) use_nl(a c) use_nl(a e)'        ||CHR(10)||
                               'use_nl(a f) use_nl(a g) use_nl(a r) use_nl(r s)'        ||CHR(10)||
                               'use_nl(a k) use_nl(a l) use_nl(a m) use_nl(a n)'        ||CHR(10)||
                               'use_nl(a o) use_nl(a p) use_nl(a q) use_nl(s u)'        ||CHR(10)||
                               'index (f PK_GE_PERSON) index (g PK_GE_ORGANIZAT_AREA)'  ||CHR(10)||
                               'index (r PK_GE_SUBSCRIBER) index (s PK_AB_ADDRESS)'     ||CHR(10)||
                               'index (k PK_OR_OPERATING_UNIT) index (l PK_PM_PROJECT)' ||CHR(10)||
                               'index (o PK_GE_SUBSCRIBER) index (p PK_AB_ADDRESS) index (u PK_GE_GEOGRA_LOCATION)';

        END IF;


        IF NUCUSTREQUESTNUM != CC_BOCONSTANTS.CNUAPPLICATIONNULL THEN
            SBHINTS := NVL(SBHINTS,'index (a IDX_MO_PACKAGES_12)');
            SBWHERE := SBWHERE ||' a.cust_care_reques_num = :nuCustRequestNum '||CHR(10)||'AND ';
        ELSE
            SBWHERE := SBWHERE||CHR(39)||NUCUSTREQUESTNUM||CHR(39)||' = :nuCustRequestNum '||CHR(10)||'AND ';
        END IF;


        IF NUPACKAGEID != CC_BOCONSTANTS.CNUAPPLICATIONNULL  THEN
            SBHINTS := 'index (a PK_MO_PACKAGES)';
            SBWHERE := SBWHERE|| 'a.package_id = :nuPackage '||CHR(10)||'AND ';
        ELSE
            SBWHERE := SBWHERE||CHR(39)||NUPACKAGEID||CHR(39)||' = :nuPackage '||CHR(10)||'AND ';
        END IF;


        IF ISBSERVICENUMBER IS NOT NULL THEN

            SBHINTS := NVL(SBHINTS,'index (a PK_MO_PACKAGES)');
            SBWHERE := SBWHERE||'a.package_id in (select  /*+ ordered use_nl(PR_PRODUCT MO_MOTIVE) index(PR_PRODUCT IDX_PRODUCT_1)*/ mo_motive.PACKAGE_id FROM pr_product, mo_motive WHERE mo_motive.product_id = pr_product.product_id AND pr_product.service_number = '''||ISBSERVICENUMBER||''' ) '||CHR(10)||'AND ';
        END IF;

        SBWHERE := SBWHERE|| ' a.package_type_id in (select package_type_id FROM ps_package_type WHERE tag_name in (''P_SOLICITUD_DE_REVISION_266'',''P_REVISION_PERIODICA_MASIVA_265'') ) '||CHR(10) || ' AND ';

        SBSQL := 'SELECT '||'/*+ ' || SBPACKAGEHINTS || SBHINTS || ' */' || CHR(10) ||
                             SBPACKAGEATTRIBUTES || CHR(10) ||
                 'FROM '  || '/*+ ldc_boPackage.GetPackages */'      || CHR(10) ||
                          SBPACKAGEFROM                                || CHR(10) ||
                 'WHERE ' || SBWHERE || SBPACKAGEWHERE                 || CHR(10) ||
                 'ORDER BY a.request_date desc';


        UT_TRACE.TRACE('Consulta ['||SBSQL||']',1);

        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, NUCUSTREQUESTNUM, NUPACKAGEID;

        UT_TRACE.TRACE('Finaliza ldc_boPackage.getPackages',6 );

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;



    PROCEDURE GETPRODUCTREQUEST
    (
        INUPRODUCTID    IN NUMBER,
        OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQL  VARCHAR2(32767);
        SBPACKAGEHINTS    VARCHAR2(6000);
    BEGIN

        UT_TRACE.TRACE('Inicio: ldc_boPackage.GetProductRequest',1);
        FILLPACKAGEATTRIBUTES;


        SBSQL := 'SELECT '|| SBPACKAGEATTRIBUTES                 || CHR(10) ||
                 'FROM '  || SBPACKAGEFROM || ' /*+ ldc_boPackage.GetProductRequest */ ' || CHR(10) ||
                 'WHERE ' || 'a.package_id in (select mo_packages.PACKAGE_id FROM mo_motive, mo_packages WHERE mo_packages.package_type_id in (select package_type_id FROM ps_package_type WHERE tag_name in (''P_SOLICITUD_DE_REVISION_266'',''P_REVISION_PERIODICA_MASIVA_265'')) AND mo_motive.package_id = mo_packages.package_id AND product_id = :nuProductId )' || CHR(10) ||
                 'AND '   || SBPACKAGEWHERE                      || CHR(10) ||
                 'ORDER BY request_date DESC';

        UT_TRACE.TRACE('Sentencia:'||CHR(10)||SBSQL,2);

        OPEN OCUDATACURSOR FOR SBSQL USING INUPRODUCTID, INUPRODUCTID;

        UT_TRACE.TRACE('Fin: ldc_boPackage.GetProductRequest',1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;



    PROCEDURE GETPRODUCT
    (
        INUPACKAGEID    IN NUMBER,
        ONUPRODUCTID    OUT NUMBER
    )
    IS
    BEGIN
        IF INUPACKAGEID IS NULL THEN
            ONUPRODUCTID := NULL;
            RETURN;
        END IF;

        DAMO_PACKAGES.ACCKEY (INUPACKAGEID);

        ONUPRODUCTID := MO_BOPACKAGES.FNUFINDPRODUCTID(INUPACKAGEID);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ONUPRODUCTID := NULL;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

BEGIN
    SBPACKAGEATTRIBUTES := NULL;
    SBPACKAGEFROM       := NULL;
    SBPACKAGEWHERE      := NULL;

    SBMOTIVEATTRIBUTES  := NULL;
    SBMOTIVEHINTS       := NULL;
    SBMOTIVEFROM        := NULL;
    SBMOTIVEWHERE       := NULL;

    CSBYES := CC_BOBOSSUTIL.CSBYES;

END ldc_boPackage;
/
PROMPT Otorgando permisos de ejecucion a LDC_BOPACKAGE
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BOPACKAGE', 'ADM_PERSON');
END;
/