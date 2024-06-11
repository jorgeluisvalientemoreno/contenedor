PACKAGE BODY CC_BOOssDamages
IS

































    
    
    
    
    
    
    
    
    

    
    
    CSBVERSION CONSTANT VARCHAR2(250) := 'SAO198525';

    
    CNUTRACELEVEL       CONSTANT    NUMBER  := 6;

    
    
    
    
    
    
    
    
    
    
    
    

    
    
    

    
























    FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
    
        RETURN CSBVERSION;
    
    EXCEPTION
    
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END FSBVERSION;

    
























    PROCEDURE FILLDAMAGEATTRIBUTES
    IS
        SBPACKAGETYPE           VARCHAR2(300);
        SBPACKAGESTATUS         VARCHAR2(300);
        SBRECEPTIONTYPE         VARCHAR2(300);
        SBVENDOR                VARCHAR2(300);
        SBSUBSCRIBERNAME        VARCHAR2(300);
        SBSUBSCRIBERIDENT       VARCHAR2(300);

        
        SBORGANIZAT_AREA        VARCHAR2(300);
        SBMANAGEMENT_AREA       VARCHAR2(300);
        SBOPERUNITPOS           VARCHAR2(300);

        
        SBANSWERMODE            VARCHAR2(300);
        SBREFERMODE             VARCHAR2(300);
        SBCONTACTNAME           VARCHAR2(300);
        SBCONTACTIDENT          VARCHAR2(300);

        
        SBANSWERNEIGHBOR        VARCHAR2(300);
        SBANSWERGEOGLOCA        VARCHAR2(300);

        
        SBADDRESS               VARCHAR2(300);
        SBADD_GEO_LOC_ID        VARCHAR2(300);
        SBADD_NEIGHBOR_ID       VARCHAR2(300);

        SBPRODUCTTYPE           VARCHAR2(300);
        SBANSWER                VARCHAR2(300);
        SBANSWERTYPE            VARCHAR2(300);
        SBCAUSAL                VARCHAR2(300);
        SBCAUSALTYPE            VARCHAR2(300);
    BEGIN
    
        UT_TRACE.TRACE('Inicio: CC_BOOssDamages.FillDamageAttributes', CNUTRACELEVEL+1);

        
        IF  (GSBDAMAGEATTRIBUTES IS NOT NULL) AND
            (GSBDAMAGEFROM       IS NOT NULL) AND
            (GSBDAMAGEWHERE      IS NOT NULL) AND
            (GSBDAMAGEHINTS      IS NOT NULL)
        THEN
            RETURN;
        END IF;
        
        
        GSBDAMAGEHINTS :=   'use_nl(pack pack_stat)'                 || CHR(10) ||
                            'use_nl(pack rece_type)'                 || CHR(10) ||
                            'use_nl(pack pers)'                      || CHR(10) ||
                            'use_nl(pack orga_area)'                 || CHR(10) ||
                            'use_nl(pack mana_area)'                 || CHR(10) ||
                            'use_nl(pack subs)'                      || CHR(10) ||
                            'use_nl(subs susb_ident)'                || CHR(10) ||
                            'use_nl(pack oper_unit)'                 || CHR(10) ||
                            'use_nl(pack cont)'                      || CHR(10) ||
                            'use_nl(cont cont_ident)'                || CHR(10) ||
                            'use_nl(pack answ_addr)'                 || CHR(10) ||
                            'use_nl(answ_addr answ_neig)'            || CHR(10) ||
                            'use_nl(answ_addr answ_geog)'            || CHR(10) ||
                            'use_nl(pack answ_mode)'                 || CHR(10) ||
                            'use_nl(moti answ)'                      || CHR(10) ||
                            'use_nl(moti caus)'                      || CHR(10) ||
                            'use_nl(moti prod_type)'                 || CHR(10) ||
                            'use_nl(caus caus_type)'                 || CHR(10) ||
                            'use_nl(answ answ_type)'                 || CHR(10) ||

                            'index(pack_stat PK_PS_MOTIVE_STATUS)'   || CHR(10) ||
                            'index(rece_type PK_GE_RECEPTION_TYPE)'  || CHR(10) ||
                            'index(pers PK_GE_PERSON)'               || CHR(10) ||
                            'index(orga_area PK_GE_ORGANIZAT_AREA)'  || CHR(10) ||
                            'index(mana_area PK_GE_ORGANIZAT_AREA)'  || CHR(10) ||
                            'index(oper_unit PK_OR_OPERATING_UNIT)'  || CHR(10) ||
                            'index(subs PK_GE_SUBSCRIBER)'           || CHR(10) ||
                            'index(subs_ident PK_GE_IDENTIFICA_TYPE)'|| CHR(10) ||
                            'index(cont PK_GE_SUBSCRIBER)'           || CHR(10) ||
                            'index(cont_ident PK_GE_IDENTIFICA_TYPE)'|| CHR(10) ||
                            'index(answ_addr PK_AB_ADDRESS)'         || CHR(10) ||
                            'index(answ_neig PK_GE_GEOGRA_LOCATION)' || CHR(10) ||
                            'index(answ_geog PK_GE_GEOGRA_LOCATION)' || CHR(10) ||
                            'index(answ_mode PK_CC_ANSWER_MODE)'     || CHR(10) ||
                            'index(prod_type PK_SERVICIO)'           || CHR(10) ||
                            'index(caus PK_CC_CAUSAL)'               || CHR(10) ||
                            'index(caus_type PK_CC_CAUSAL_TYPE)'     || CHR(10) ||
                            'index(answ PK_CC_ANSWER)'               || CHR(10) ||
                            'index(answ_type PK_CC_ANSWER_TYPE)'     || CHR(10);

        SBSUBSCRIBERNAME    := 'subs.subscriber_name||'' ''||subs.subs_last_name';
        SBSUBSCRIBERIDENT   := 'subs_ident.description'|| CC_BOBOSSUTIL.CSBSEPARATOR ||'subs.identification';
        SBCONTACTNAME       := 'cont.subscriber_name||'' ''||cont.subs_last_name';
        SBCONTACTIDENT      := 'cont_ident.description'|| CC_BOBOSSUTIL.CSBSEPARATOR ||'cont.identification';
        SBPACKAGESTATUS     := 'pack_stat.motive_status_id'     || CC_BOBOSSUTIL.CSBSEPARATOR || 'pack_stat.description';
        SBRECEPTIONTYPE     := 'rece_type.reception_type_id'    || CC_BOBOSSUTIL.CSBSEPARATOR || 'rece_type.description';
        SBVENDOR            := 'pers.person_id'                 || CC_BOBOSSUTIL.CSBSEPARATOR || 'pers.name_';
        SBORGANIZAT_AREA    := 'orga_area.organizat_area_id'    || CC_BOBOSSUTIL.CSBSEPARATOR || 'orga_area.display_description';
        SBMANAGEMENT_AREA   := 'mana_area.organizat_area_id'    || CC_BOBOSSUTIL.CSBSEPARATOR || 'mana_area.display_description';
        SBOPERUNITPOS       := 'oper_unit.operating_unit_id'    || CC_BOBOSSUTIL.CSBSEPARATOR || 'oper_unit.name';
        SBANSWERMODE        := 'answ_mode.answer_mode_id'       || CC_BOBOSSUTIL.CSBSEPARATOR || 'answ_mode.description';
        SBANSWERNEIGHBOR    := 'answ_neig.geograp_location_id'  || CC_BOBOSSUTIL.CSBSEPARATOR || 'answ_neig.description';
        SBANSWERGEOGLOCA    := 'answ_geog.geograp_location_id'  || CC_BOBOSSUTIL.CSBSEPARATOR || 'answ_geog.display_description';

        
        SBADDRESS           := 'cc_boOssPackageData.fsbGetAddress(pack.package_id)';
        SBADD_GEO_LOC_ID    := 'cc_boOssPackageData.fsbAddressGeoLoc(pack.package_id)';
        SBADD_NEIGHBOR_ID   := 'cc_boOssPackageData.fsbAddressNeighbor(pack.package_id)';

        
        SBPRODUCTTYPE       := 'prod_type.servcodi'         || CC_BOBOSSUTIL.CSBSEPARATOR || 'prod_type.servdesc';
        SBANSWER            := 'answ.answer_id'             || CC_BOBOSSUTIL.CSBSEPARATOR || 'answ.description';
        SBANSWERTYPE        := 'answ_type.answer_type_id'   || CC_BOBOSSUTIL.CSBSEPARATOR || 'answ_type.description';
        SBCAUSAL            := 'caus.causal_id'             || CC_BOBOSSUTIL.CSBSEPARATOR || 'caus.description';
        SBCAUSALTYPE        := 'caus_type.causal_type_id'   || CC_BOBOSSUTIL.CSBSEPARATOR || 'caus_type.description';

        CC_BOBOSSUTIL.ADDATTRIBUTE ('pack.package_id',           'package_id',               GSBDAMAGEATTRIBUTES);

        
        CC_BOBOSSUTIL.ADDATTRIBUTE ('subs.subscriber_id',        'subscriber_id',            GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBSUBSCRIBERNAME,            'subscriber_name',          GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBSUBSCRIBERIDENT,           'subscriber_ident',         GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('subs.phone',                'subscriber_phone',         GSBDAMAGEATTRIBUTES);

        CC_BOBOSSUTIL.ADDATTRIBUTE ('moti.subscription_id',      'subscription_id',          GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('moti.product_id',           'product_id',               GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('moti.service_number',       'service_number',           GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBPRODUCTTYPE,               'product_type',             GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('pack.request_date',         'request_date',             GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('pack.expect_atten_date',    'expect_atten_date',        GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBPACKAGESTATUS,             'package_status',           GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('pack.user_id',              'user_id',                  GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('pack.attention_date',       'attention_date',           GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('pack.comment_',             'comment_',                 GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBRECEPTIONTYPE,             'reception_type',           GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBVENDOR,                    'vendor',                   GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBORGANIZAT_AREA,            'organizat_area',           GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBMANAGEMENT_AREA,           'management_area',          GSBDAMAGEATTRIBUTES);


        CC_BOBOSSUTIL.ADDATTRIBUTE ('pack.cust_care_reques_num', 'cust_care_reques_num',     GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBOPERUNITPOS,               'pos',                      GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('pack.insistently_counter',  'insistently_counter',      GSBDAMAGEATTRIBUTES);

        
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBADDRESS,                   'address',                  GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBADD_GEO_LOC_ID,            'add_geo_loc_id',           GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBADD_NEIGHBOR_ID,           'add_neighbor_id',          GSBDAMAGEATTRIBUTES);

        
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cont.subscriber_id',        'contact_id',               GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBCONTACTNAME,               'contact_name',             GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBCONTACTIDENT,              'contact_ident',            GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('cont.phone',                'contact_phone',            GSBDAMAGEATTRIBUTES);

        
        CC_BOBOSSUTIL.ADDATTRIBUTE ('answ_addr.address_id',      'answer_address_id',        GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('answ_addr.address_parsed',  'answer_address',           GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBANSWERNEIGHBOR,            'answer_neighborthood',     GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBANSWERGEOGLOCA,            'answer_geogr_locat',       GSBDAMAGEATTRIBUTES);


        
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBANSWER,                    'answer',                   GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBANSWERTYPE,                'answer_type',              GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBCAUSAL,                    'causal',                   GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBCAUSALTYPE,                'causal_type',              GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBANSWERMODE,                'answer_mode',              GSBDAMAGEATTRIBUTES);
        CC_BOBOSSUTIL.ADDATTRIBUTE (':parent_id',                'parent_id',                GSBDAMAGEATTRIBUTES);

        
        GSBDAMAGEFROM   :=  'mo_packages pack,'             || CHR(10) ||
                            'ps_motive_status pack_stat,'   || CHR(10) ||
                            'ge_reception_type rece_type,'  || CHR(10) ||
                            'ge_person pers,'               || CHR(10) ||
                            'ge_organizat_area orga_area,'  || CHR(10) ||
                            'ge_organizat_area mana_area,'  || CHR(10) ||
                            'or_operating_unit oper_unit,'  || CHR(10) ||
                            'ge_subscriber subs,'           || CHR(10) ||
                            'ge_identifica_type subs_ident,'|| CHR(10) ||
                            'ge_subscriber cont,'           || CHR(10) ||
                            'ge_identifica_type cont_ident,'|| CHR(10) ||
                            'ab_address answ_addr,'         || CHR(10) ||
                            'ge_geogra_location answ_neig,' || CHR(10) ||
                            'ge_geogra_location answ_geog,' || CHR(10) ||
                            'cc_answer_mode answ_mode,'     || CHR(10) ||
                            'mo_motive moti,'               || CHR(10) ||
                            'servicio prod_type,'           || CHR(10) ||
                            'cc_causal caus,'               || CHR(10) ||
                            'cc_causal_type caus_type,'     || CHR(10) ||
                            'cc_answer answ,'               || CHR(10) ||
                            'cc_answer_type answ_type';

        
        GSBDAMAGEWHERE  :=  'pack.tag_name = '||GE_BOUTILITIES.FSBTOSTRING(PS_BOPACKAGETYPE.CSBTAGINDIV_DAMAGE)|| CHR(10) ||
                            'AND pack.motive_status_id = pack_stat.motive_status_id'                || CHR(10) ||
                            'AND pack.reception_type_id = rece_type.reception_type_id (+)'          || CHR(10) ||
                            'AND pack.person_id = pers.person_id (+)'                               || CHR(10) ||
                            'AND pack.organizat_area_id = orga_area.organizat_area_id (+)'          || CHR(10) ||
                            'AND pack.management_area_id = mana_area.organizat_area_id (+)'         || CHR(10) ||
                            'AND pack.subscriber_id = subs.subscriber_id (+)'                       || CHR(10) ||
                            'AND subs.ident_type_id = subs_ident.ident_type_id (+)'                 || CHR(10) ||
                            'AND pack.POS_oper_unit_id = oper_unit.operating_unit_id (+)'           || CHR(10) ||
                            'AND pack.contact_id = cont.subscriber_id (+)'                          || CHR(10) ||
                            'AND cont.ident_type_id = cont_ident.ident_type_id (+)'                 || CHR(10) ||
                            'AND pack.address_id = answ_addr.address_id (+)'                        || CHR(10) ||
                            'AND answ_addr.neighborthood_id = answ_neig.geograp_location_id (+)'    || CHR(10) ||
                            'AND answ_addr.geograp_location_id = answ_geog.geograp_location_id (+)' || CHR(10) ||
                            'AND pack.answer_mode_id = answ_mode.answer_mode_id (+)'                || CHR(10) ||
                            'AND moti.package_id = pack.package_id'                                 || CHR(10) ||
                            'AND moti.answer_id = answ.answer_id (+)'                               || CHR(10) ||
                            'AND answ.answer_type_id = answ_type.answer_type_id (+)'                || CHR(10) ||
                            'AND moti.causal_id = caus.causal_id'                                   || CHR(10) ||
                            'AND caus.causal_type_id = caus_type.causal_type_id'                    || CHR(10) ||
                            'AND moti.product_type_id = prod_type.servcodi';

        UT_TRACE.TRACE('Fin: CC_BOOssDamages.FillDamageAttributes', CNUTRACELEVEL+1);
    
    EXCEPTION
    
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR: CC_BOOssDamages.FillDamageAttributes', CNUTRACELEVEL+1);
        	RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('others: CC_BOOssDamages.FillDamageAttributes', CNUTRACELEVEL+1);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END FILLDAMAGEATTRIBUTES;

    




























    PROCEDURE GETDAMAGE
    (
        INUDAMAGEID        IN          MO_PACKAGES.PACKAGE_ID%TYPE,
        ORFRESULT           OUT         PKCONSTANTE.TYREFCURSOR
    )
    IS
    BEGIN
    
        UT_TRACE.TRACE('Inicio: CC_BOOssDamages.GetDamage', CNUTRACELEVEL);

        
        CC_BOOSSDAMAGES.FILLDAMAGEATTRIBUTES;

        
        OPEN    ORFRESULT
        FOR     'SELECT'|| CHR(10) ||
                        '/*+' || CHR(10) ||
                        'leading(pack)' || CHR(10) ||
                        'use_nl(pack moti)' || CHR(10) ||
                        'index(pack PK_MO_PACKAGES)' || CHR(10) ||
                        'index(moti IDX_MO_MOTIVE_02)' || CHR(10) ||
                        GSBDAMAGEHINTS || CHR(10) ||
                        '*/' || CHR(10) ||
                        GSBDAMAGEATTRIBUTES || CHR(10) ||
                'FROM'  || CHR(10) ||
                        GSBDAMAGEFROM || CHR(10) ||
                        '/*+ CC_BOOssDamages.GetDamage */' || CHR(10) ||
                'WHERE  pack.package_id = :nuPackageID AND' || CHR(10) ||
                        GSBDAMAGEWHERE
        USING   CC_BOBOSSUTIL.CNUNULL, INUDAMAGEID;

        UT_TRACE.TRACE('Fin: CC_BOOssDamages.GetDamage', CNUTRACELEVEL);
    
    EXCEPTION
    
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR: CC_BOOssDamages.GetDamage', CNUTRACELEVEL);
        	RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('others: CC_BOOssDamages.GetDamage', CNUTRACELEVEL);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END GETDAMAGE;

    





























    PROCEDURE GETDAMAGEBYPRODUCT
    (
        INUPRODUCTID            IN          MO_MOTIVE.PRODUCT_ID%TYPE,
        ORFRESULT               OUT         PKCONSTANTE.TYREFCURSOR
    )
    IS
    BEGIN
    
        UT_TRACE.TRACE('Inicio: CC_BOOssDamages.GetDamageByProduct', CNUTRACELEVEL);

        
        CC_BOOSSDAMAGES.FILLDAMAGEATTRIBUTES;

        
        OPEN    ORFRESULT
        FOR     'SELECT'|| CHR(10) ||
                        '/*+' || CHR(10) ||
                        'leading(moti)' || CHR(10) ||
                        'use_nl(moti pack)' || CHR(10) ||
                        'index(moti IDX_MO_MOTIVE13)' || CHR(10) ||
                        'index(pack PK_MO_PACKAGES)' || CHR(10) ||
                        GSBDAMAGEHINTS || CHR(10) ||
                        '*/' || CHR(10) ||
                        GSBDAMAGEATTRIBUTES || CHR(10) ||
                'FROM'  || CHR(10) ||
                        GSBDAMAGEFROM || CHR(10) ||
                        '/*+ CC_BOOssDamages.GetDamageByProduct */' || CHR(10) ||
                'WHERE  moti.product_id = :inuProductID AND' || CHR(10) ||
                        GSBDAMAGEWHERE
        USING   INUPRODUCTID, INUPRODUCTID;

        UT_TRACE.TRACE('Fin: CC_BOOssDamages.GetDamageByProduct', CNUTRACELEVEL);
    
    EXCEPTION
    
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR: CC_BOOssDamages.GetDamageByProduct', CNUTRACELEVEL);
        	RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('others: CC_BOOssDamages.GetDamageByProduct', CNUTRACELEVEL);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END GETDAMAGEBYPRODUCT;
    
    




























    PROCEDURE GETPRODUCTBYDAMAGE
    (
        INUDAMAGEID             IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        ONUPRODUCTID            OUT MO_MOTIVE.PRODUCT_ID%TYPE
    )
    IS
    BEGIN
    
        UT_TRACE.TRACE('Inicio: CC_BOOssDamages.GetProductByDamage', CNUTRACELEVEL);
        
        ONUPRODUCTID    := MO_BOPACKAGES.FRCGETINITIALMOTIVE(INUDAMAGEID, FALSE).PRODUCT_ID;
        
        UT_TRACE.TRACE('Fin: CC_BOOssDamages.GetProductByDamage', CNUTRACELEVEL);
    
    EXCEPTION
    
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR: CC_BOOssDamages.GetProductByDamage', CNUTRACELEVEL);
        	RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('others: CC_BOOssDamages.GetProductByDamage', CNUTRACELEVEL);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END GETPRODUCTBYDAMAGE;






























    PROCEDURE GETDAMAGES
    (
        INUDAMAGEID         IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        INUINTERATIONID     IN  MO_PACKAGES.CUST_CARE_REQUES_NUM%TYPE,
        INUSUBSCRIPTIONID   IN  MO_MOTIVE.SUBSCRIPTION_ID%TYPE,
        INUPRODUCTTYPEID    IN  MO_MOTIVE.PRODUCT_TYPE_ID%TYPE,
        ISBSERVICENUMBER    IN  MO_MOTIVE.SERVICE_NUMBER%TYPE,
        ISBIDENTIFICATION   IN  GE_SUBSCRIBER.IDENTIFICATION%TYPE,
        ISBNAME             IN  GE_SUBSCRIBER.SUBSCRIBER_NAME%TYPE,
        ISBLASTNAME         IN  GE_SUBSCRIBER.SUBS_LAST_NAME%TYPE,
        IDTINITIALDATE      IN  MO_PACKAGES.REQUEST_DATE%TYPE,
        IDTFINALDATE        IN  MO_PACKAGES.REQUEST_DATE%TYPE,
        INUDAMAGESTATUSID   IN  MO_PACKAGES.MOTIVE_STATUS_ID%TYPE,
        ORFRESULT           OUT CONSTANTS.TYREFCURSOR
    )
    IS
        NUDAMAGEID          MO_PACKAGES.PACKAGE_ID%TYPE;
        NUINTERATIONID      MO_PACKAGES.CUST_CARE_REQUES_NUM%TYPE;
        NUDAMAGESTATUSID    MO_PACKAGES.MOTIVE_STATUS_ID%TYPE;
        SBIDENTIFICATION    GE_SUBSCRIBER.IDENTIFICATION%TYPE;
        SBNAME              GE_SUBSCRIBER.SUBSCRIBER_NAME%TYPE;
        SBLASTNAME          GE_SUBSCRIBER.SUBS_LAST_NAME%TYPE;
        DTINITIALDATE       MO_PACKAGES.REQUEST_DATE%TYPE;
        DTFINALDATE         MO_PACKAGES.REQUEST_DATE%TYPE;
        
        NUSUBSCRIPTIONID    MO_MOTIVE.SUBSCRIPTION_ID%TYPE;
        NUPRODUCTTYPEID     MO_MOTIVE.PRODUCT_TYPE_ID%TYPE;
        SBSERVICENUMBER     MO_MOTIVE.SERVICE_NUMBER%TYPE;

        SBSQL               GE_BOUTILITIES.STYSTATEMENT;
        SBHINTS             GE_BOUTILITIES.STYSTATEMENT;
        SBCOMMONHINTS       GE_BOUTILITIES.STYSTATEMENT;
        SBPACKAGEHINTS      GE_BOUTILITIES.STYSTATEMENT;
        SBSUBSCRIBERHINTS   GE_BOUTILITIES.STYSTATEMENT;
        SBMOTIVEHINTS       GE_BOUTILITIES.STYSTATEMENT;
        SBWHERE             GE_BOUTILITIES.STYSTATEMENT;
        NUPARENTID          NUMBER;
    BEGIN
        DTINITIALDATE       := IDTINITIALDATE;
        DTFINALDATE         := IDTFINALDATE;
        
        
        IF  (IDTINITIALDATE IS NOT NULL OR IDTFINALDATE IS NOT NULL) THEN
            CC_BOBOSSUTIL.QUERYTYPEDATES(CC_BOBOSSUTIL.FNUQUERYBYBETWEEN, NULL, DTINITIALDATE, DTFINALDATE);
        END IF;

        SBIDENTIFICATION    := UPPER(TRIM(ISBIDENTIFICATION));
        SBNAME              := UPPER(TRIM(ISBNAME));
        SBLASTNAME          := UPPER(TRIM(ISBLASTNAME));

        NUINTERATIONID      := INUINTERATIONID;
        NUDAMAGEID          := INUDAMAGEID;
        NUDAMAGESTATUSID    := INUDAMAGESTATUSID;
        
        NUSUBSCRIPTIONID    := INUSUBSCRIPTIONID;
        NUPRODUCTTYPEID     := INUPRODUCTTYPEID;
        SBSERVICENUMBER     := UPPER(TRIM(ISBSERVICENUMBER));

        CC_BOOSSDAMAGES.FILLDAMAGEATTRIBUTES;

        SBCOMMONHINTS       :=  'use_nl(pack pack_stat)'                 || CHR(10) ||
                                'use_nl(pack rece_type)'                 || CHR(10) ||
                                'use_nl(pack pers)'                      || CHR(10) ||
                                'use_nl(pack orga_area)'                 || CHR(10) ||
                                'use_nl(pack mana_area)'                 || CHR(10) ||
                                'use_nl(subs susb_ident)'                || CHR(10) ||
                                'use_nl(pack oper_unit)'                 || CHR(10) ||
                                'use_nl(pack cont)'                      || CHR(10) ||
                                'use_nl(cont cont_ident)'                || CHR(10) ||
                                'use_nl(pack answ_addr)'                 || CHR(10) ||
                                'use_nl(answ_addr answ_neig)'            || CHR(10) ||
                                'use_nl(answ_addr answ_geog)'            || CHR(10) ||
                                'use_nl(pack answ_mode)'                 || CHR(10) ||
                                'use_nl(moti answ)'                      || CHR(10) ||
                                'use_nl(moti caus)'                      || CHR(10) ||
                                'use_nl(moti prod_type)'                 || CHR(10) ||
                                'use_nl(caus caus_type)'                 || CHR(10) ||
                                'use_nl(answ answ_type)'                 || CHR(10) ||

                                'index(pack_stat PK_PS_MOTIVE_STATUS)'   || CHR(10) ||
                                'index(rece_type PK_GE_RECEPTION_TYPE)'  || CHR(10) ||
                                'index(pers PK_GE_PERSON)'               || CHR(10) ||
                                'index(orga_area PK_GE_ORGANIZAT_AREA)'  || CHR(10) ||
                                'index(mana_area PK_GE_ORGANIZAT_AREA)'  || CHR(10) ||
                                'index(oper_unit PK_OR_OPERATING_UNIT)'  || CHR(10) ||
                                'index(subs PK_GE_SUBSCRIBER)'           || CHR(10) ||
                                'index(subs_ident PK_GE_IDENTIFICA_TYPE)'|| CHR(10) ||
                                'index(cont PK_GE_SUBSCRIBER)'           || CHR(10) ||
                                'index(cont_ident PK_GE_IDENTIFICA_TYPE)'|| CHR(10) ||
                                'index(answ_addr PK_AB_ADDRESS)'         || CHR(10) ||
                                'index(answ_neig PK_GE_GEOGRA_LOCATION)' || CHR(10) ||
                                'index(answ_geog PK_GE_GEOGRA_LOCATION)' || CHR(10) ||
                                'index(answ_mode PK_CC_ANSWER_MODE)'     || CHR(10) ||
                                'index(prod_type PK_SERVICIO)'           || CHR(10) ||
                                'index(caus PK_CC_CAUSAL)'               || CHR(10) ||
                                'index(caus_type PK_CC_CAUSAL_TYPE)'     || CHR(10) ||
                                'index(answ PK_CC_ANSWER)'               || CHR(10) ||
                                'index(answ_type PK_CC_ANSWER_TYPE)'     || CHR(10);

        SBPACKAGEHINTS      :=  'leading (pack)'                         || CHR(10) ||
                                'index(subs PK_GE_SUBSCRIBER)'           || CHR(10) ||
                                'index(moti IDX_MO_MOTIVE_02)'           || CHR(10) ||
                                'use_nl(pack subs)'                      || CHR(10) ||
                                'use_nl(pack moti)'                      || CHR(10);

        SBSUBSCRIBERHINTS   :=  'leading (subs)'                         || CHR(10) ||
                                'index(pack IDX_MO_PACKAGES_02)'         || CHR(10) ||
                                'index(moti IDX_MO_MOTIVE_02)'           || CHR(10) ||
                                'use_nl(subs pack)'                      || CHR(10) ||
                                'use_nl(pack moti)'                      || CHR(10);

        SBMOTIVEHINTS       :=  'leading(moti)'                          || CHR(10) ||
                                'index(pack PK_MO_PACKAGES)'             || CHR(10) ||
                                'index(subs PK_GE_SUBSCRIBER)'           || CHR(10) ||
                                'use_nl(moti pack)'                      || CHR(10) ||
                                'use_nl(pack subs)'                      || CHR(10);

        NUPARENTID  := NUDAMAGEID;
        
        
        IF  NUDAMAGEID IS NULL THEN
            SBWHERE  := SBWHERE ||' AND :DamageID IS NULL';
        ELSE
            SBHINTS  := NVL(SBHINTS, SBPACKAGEHINTS || CHR(10) || 'index(pack PK_MO_PACKAGES)');

            SBWHERE  := SBWHERE ||' AND pack.package_id = :DamageID';
        END IF;

        
        IF  NUINTERATIONID IS NULL THEN
            SBWHERE := SBWHERE ||' AND :InterationID IS NULL';
        ELSE
            SBHINTS := NVL(SBHINTS, SBPACKAGEHINTS ||  CHR(10) ||  'index(pack IDX_MO_PACKAGES_12)');

            SBWHERE := SBWHERE ||' AND pack.cust_care_reques_num = :InterationID';
        END IF;

        
        IF  SBSERVICENUMBER IS NULL THEN
            SBWHERE := SBWHERE ||' AND :ServiceNumber IS NULL';
        ELSE
            SBHINTS := NVL(SBHINTS, SBMOTIVEHINTS || CHR(10) || 'index(moti IDX_MO_MOTIVE01)');

            SBWHERE := SBWHERE ||' AND moti.service_number = :ServiceNumber';
        END IF;

        
        IF  NUSUBSCRIPTIONID IS NULL THEN
            SBWHERE := SBWHERE ||' AND :SubscriptionID IS NULL';
        ELSE
            SBHINTS := NVL(SBHINTS, SBMOTIVEHINTS || CHR(10) || 'index(moti IDX_MO_MOTIVE_03)');

            SBWHERE := SBWHERE ||' AND moti.subscription_id = :SubscriptionID';
        END IF;

        
        IF  SBIDENTIFICATION IS NULL THEN
            SBWHERE := SBWHERE ||' AND :Identification IS NULL';
        ELSE
            SBHINTS := NVL(SBHINTS, SBSUBSCRIBERHINTS || CHR(10) || 'index(subs IDX_GE_SUBSCRIBER_02)');

            SBWHERE := SBWHERE ||' AND subs.identification like :Identification||'||CHR(39)||'%'||CHR(39);
        END IF;

        
        IF  SBNAME IS NULL THEN
            SBWHERE := SBWHERE || ' AND :Name IS NULL';
        ELSE
            SBHINTS := NVL(SBHINTS, SBSUBSCRIBERHINTS || CHR(10) || 'index(subs IDX_GE_SUBSCRIBER_04)');

            SBWHERE := SBWHERE || ' AND subs.subscriber_name like :Name||'||CHR(39)||'%'||CHR(39);
        END IF;

        
        IF  SBLASTNAME IS NULL THEN
            SBWHERE := SBWHERE || ' AND :LastName IS NULL';
        ELSE
            SBHINTS := NVL(SBHINTS, SBSUBSCRIBERHINTS || CHR(10) || 'index(subs IDX_GE_SUBSCRIBER_05)');

            SBWHERE := SBWHERE || ' AND subs.subs_last_name like :LastName||'||CHR(39)||'%'||CHR(39);
        END IF;
        
        
        IF  (DTINITIALDATE IS NULL) THEN
            SBWHERE := SBWHERE || ' AND :InitialDate IS NULL';
        ELSE
            SBHINTS := NVL(SBHINTS, SBPACKAGEHINTS || CHR(10) || 'index(pack IDX_MO_PACKAGES_015)');

            SBWHERE := SBWHERE || ' AND pack.request_date >= :InitialDate';
        END IF;

        
        IF  (DTFINALDATE IS NULL) THEN
            SBWHERE := SBWHERE || ' AND :FinalDate IS NULL';
        ELSE
            SBHINTS := NVL(SBHINTS, SBPACKAGEHINTS || CHR(10) || 'index(pack IDX_MO_PACKAGES_015)');

            SBWHERE := SBWHERE || ' AND pack.request_date <= :FinalDate';
        END IF;

        
        IF  NUDAMAGESTATUSID IS NULL THEN
            SBWHERE := SBWHERE ||' AND :DamageStatusID IS NULL';
        ELSE
            SBHINTS := NVL(SBHINTS, SBPACKAGEHINTS || CHR(10) || 'index(pack IX_MO_PACKAGES15)');
            
            SBWHERE := SBWHERE ||' AND pack.motive_status_id = :DamageStatusID';
        END IF;

        
        IF  NUPRODUCTTYPEID IS NULL THEN
            SBWHERE := SBWHERE ||' AND :ProductTypeID IS NULL';
        ELSE
            SBHINTS := NVL(SBHINTS, SBMOTIVEHINTS || CHR(10) || 'index(moti IX_MO_MOTIVE16)');

            SBWHERE := SBWHERE ||' AND moti.product_type_id = :ProductTypeID';
        END IF;
        
        SBHINTS := NVL(SBHINTS, SBPACKAGEHINTS || CHR(10) || 'index(pack IDX_MO_PACKAGES_13)');

        
        OPEN    ORFRESULT
        FOR     'SELECT'|| CHR(10) ||
                        '/*+' || CHR(10) ||
                        SBHINTS || CHR(10) ||
                        SBCOMMONHINTS || CHR(10) ||
                        '*/' || CHR(10) ||
                        GSBDAMAGEATTRIBUTES || CHR(10) ||
                'FROM'  || CHR(10) ||
                        GSBDAMAGEFROM || CHR(10) ||
                        '/*+ CC_BOOssDamages.GetDamages */' || CHR(10) ||
                'WHERE' || CHR(10) ||
                        GSBDAMAGEWHERE || CHR(10) ||
                        SBWHERE
        USING   NUPARENTID,
                NUDAMAGEID,             
                NUINTERATIONID,         
                SBSERVICENUMBER,        
                NUSUBSCRIPTIONID,       
                SBIDENTIFICATION,       
                SBNAME,                 
                SBLASTNAME,             
                DTINITIALDATE,          
                DTFINALDATE,            
                NUDAMAGESTATUSID,       
                NUPRODUCTTYPEID;        

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETDAMAGES;
END CC_BOOSSDAMAGES;