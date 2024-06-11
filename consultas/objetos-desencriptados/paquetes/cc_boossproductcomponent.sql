PACKAGE BODY cc_boOssProductComponent
AS
    
    
    
    CSBVERSION CONSTANT VARCHAR2(10) := 'SAO198525';

    
    
    
    SBPACKAGESQL             VARCHAR2(32767);
    SBWARRANTYATTRIBUTES     VARCHAR2(32767);
    SBEQUIPMENTATTRIBUTES    VARCHAR2(32767);
    SBBUILDINGATTRIBUTES     VARCHAR2(32767);
    SBCHILDCOMPATT           VARCHAR2(32767);
    SBRETIREATTRIBUTES       VARCHAR2(32767);

    TBCOMPONENTATTRIBUTES    CC_TYTBATTRIBUTE;
    TBRETIREATTRIBUTES       CC_TYTBATTRIBUTE;
    TBWARRANTYATTRIBUTES     CC_TYTBATTRIBUTE;
    TBEQUIPMENTATTRIBUTES    CC_TYTBATTRIBUTE;
    TBBUILDINGATTRIBUTES     CC_TYTBATTRIBUTE;
    TBCHILDCOMPATT           CC_TYTBATTRIBUTE;

    SBADDRESSPREMISEATTRIBUTES      VARCHAR2(4000);
    
    TBADDRESSPREMISEATTRIBUTES      CC_TYTBATTRIBUTE;
    
    
    

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














































































PROCEDURE FILLCOMPONENTATTRIBUTES
IS

SBCOMPONENTTYPE   VARCHAR2(300);
SBDIRECTIONALITY  VARCHAR2(300);
SBCOMPONENTSTATUS VARCHAR2(300);
SBSERVICECLASS    VARCHAR2(300);
SBGUARANTEE       VARCHAR2(300);
SBSALEMODALITY    VARCHAR2(300);
SBRETIREDATE      VARCHAR2(300);
SBCOMMERCIALPLAN  VARCHAR2(300);
SBPRODUCT         VARCHAR2(300);
SBPROVSERVNUM     VARCHAR2(300);
SBISMAIN          VARCHAR2(300);
SBCREATIONDATE    VARCHAR2(300);
SBCOMPRETIREDATE  VARCHAR2(300);
SBSERVICEDATE     VARCHAR2(300);

SBADDRESS         VARCHAR2(300);
SBADDRESSGEOLOC   VARCHAR2(300);
SBADDRESSNEIGHBOR VARCHAR2(300);


BEGIN
    IF SBCOMPONENTATTR IS NOT NULL THEN
        RETURN;
    END IF;

    SBCOMPONENTTYPE     := ' a.component_type_id'  ,, CC_BOBOSSUTIL.CSBSEPARATOR ,,'b.Description';
    SBCOMPONENTSTATUS   := ' a.component_status_id',, CC_BOBOSSUTIL.CSBSEPARATOR ,,'l.description';
    SBSERVICECLASS      := ' a.class_service_id'   ,, CC_BOBOSSUTIL.CSBSEPARATOR ,,'d.Description';
    SBCOMMERCIALPLAN    := ' a.commercial_plan_id' ,, CC_BOBOSSUTIL.CSBSEPARATOR ,,'e.name ';
    SBPRODUCT           := ' f.service_number';
    SBISMAIN            := ' nvl(a.is_main, ''N'')';
    
    SBDIRECTIONALITY    := ' a.directionality_id'  ,, CC_BOBOSSUTIL.CSBSEPARATOR ,,'c.Description';
    SBPROVSERVNUM       := ' dapr_component.fsbGetService_number(a.comp_prod_prov_id,0)';
    SBGUARANTEE         := ' pr_boCnfNetworkElement.fsbPhoneHasGuarantee(a.component_id)';
    SBSALEMODALITY      := ' cc_boOssProdCompData.fsbSaleModality(a.component_id,a.component_type_id)';

    
    
    SBRETIREDATE      := ' cc_boOssProdCompData.fdtDateValidation(cc_boOssDates.fdtProductCompRetireDate(a.component_id))';
    
    SBCREATIONDATE    := ' cc_boOssProdCompData.fdtDateValidation(a.creation_date)';
    
    SBCOMPRETIREDATE  := ' cc_boOssProdCompData.fdtDateValidation(k.cmssfere)';
    
    SBSERVICEDATE     := ' cc_boOssProdCompData.fdtDateValidation(a.service_date, a.component_status_id)';

    
    SBADDRESS           := ' g.address';
    SBADDRESSGEOLOC     := ' g.geograp_location_id',, CC_BOBOSSUTIL.CSBSEPARATOR ,,'h.display_description';
    SBADDRESSNEIGHBOR   := ' g.neighborthood_id'   ,, CC_BOBOSSUTIL.CSBSEPARATOR ,,'i.description';

    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.component_id',          'component_id',         SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBCOMPONENTTYPE,            'component_type',       SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBSERVICEDATE,              'service_date',         SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBDIRECTIONALITY,           'directionality',       SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBCOMPONENTSTATUS,          'component_status',     SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBSERVICECLASS,             'service_class',        SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBGUARANTEE,                'guarantee',            SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBRETIREDATE,               'retire_date',          SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBCOMMERCIALPLAN,           'commercial_plan',      SBCOMPONENTATTR);
    
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBSALEMODALITY,             'sale_modality',        SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBPRODUCT,                  'product',              SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.quantity',              'quantity',             SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBCREATIONDATE,             'creation_date',        SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.service_number',        'service_number',       SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.product_origin_id',     'product_origin_id',    SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.meter',                 'meter',                SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBISMAIN,                   'is_main',              SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' a.comp_prod_prov_id',     'comp_prod_prov_id',    SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBPROVSERVNUM,              'prov_service_number',  SBCOMPONENTATTR);
    
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBADDRESS,                  'address',              SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBADDRESSGEOLOC,            'add_geo_loc_id',       SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBADDRESSNEIGHBOR,          'add_neighbor_id',      SBCOMPONENTATTR);
    
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBCOMPRETIREDATE,           'comp_retire_date',     SBCOMPONENTATTR);
    CC_BOBOSSUTIL.ADDATTRIBUTE (' :parent_id',              'parent_id',            SBCOMPONENTATTR);

    SBCOMPHINTSDEF   :=' use_nl(a b) use_nl(a c) use_nl(a d) use_nl(a e) use_nl(a f) '   ,,CHR(10),,
                       ' use_nl(a g) use_nl(a k) use_nl(a l) use_nl(g h) use_nl(g i) */ ';

    SBCOMPONENTFROM  :=' pr_component a, ps_component_type b, ge_directionality c, '     ,,CHR(10),,
                       ' ps_class_service d, cc_commercial_plan e, pr_product f, '       ,,CHR(10),,
                       ' ab_address g, ge_geogra_location h, ge_geogra_location i, '     ,,CHR(10),,
                       ' Compsesu k, ps_product_status l';

    SBCOMPONENTWHERE :=' a.component_type_id = b.component_type_id'             ,,CHR(10),,
                       ' AND a.directionality_id = c.directionality_id(+)'      ,,CHR(10),,
                       ' AND a.class_service_id = d.class_service_id(+)'        ,,CHR(10),,
                       ' AND a.commercial_plan_id = e.commercial_plan_id(+)'    ,,CHR(10),,
                       ' AND a.component_id = k.cmssidco'                       ,,CHR(10),,
                       ' AND a.component_status_id = l.product_status_id'       ,,CHR(10),,
                       ' AND a.product_origin_id = f.product_id(+)'             ,,CHR(10),,
                       ' AND a.address_id = g.address_id(+)'                    ,,CHR(10),,
                       ' AND g.geograp_location_id = h.geograp_location_id(+)'  ,,CHR(10),,
                       ' AND g.neighborthood_id = i.geograp_location_id(+)';

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END FILLCOMPONENTATTRIBUTES;



















PROCEDURE FILLPACKAGEATTRIBUTES
IS

    SBPACKAGEHINTS    VARCHAR2(6000);

BEGIN
    IF SBPACKAGESQL IS NOT NULL THEN
        RETURN;
    END IF;

    CC_BOOSSPACKAGE.FILLPACKAGEATTRIBUTES;
    
    SBPACKAGEHINTS  :=  '/*+ leading (mo_component) use_nl(mo_component mo_motive)'     ,,CHR(10),,
                        'use_nl(mo_motive a) use_nl(a b) use_nl(a c) use_nl(a e)'       ,,CHR(10),,
                        'use_nl(a f) use_nl(a g) use_nl(a r) use_nl(r s)'               ,,CHR(10),,
                        'use_nl(a k) use_nl(a l) use_nl(a m) use_nl(a n)'               ,,CHR(10),,
                        'use_nl(a o) use_nl(a p) use_nl(a q) use_nl(s u)'               ,,CHR(10),,
                        'index (mo_component IDX_MO_COMPONENT_07)'                      ,,CHR(10),,
                        'index (mo_motive pk_mo_motive)'                                ,,CHR(10),,
                        'index (a PK_MO_PACKAGES)'                                      ,,CHR(10),,
                        'index (f PK_GE_PERSON)'                                        ,,CHR(10),,
                        'index (g PK_GE_ORGANIZAT_AREA) index (k PK_OR_OPERATING_UNIT)' ,,CHR(10),,
                        'index (l PK_PM_PROJECT) index (o PK_GE_SUBSCRIBER)'            ,,CHR(10),,
                        'index (p PK_AB_ADDRESS) index (u PK_GE_GEOGRA_LOCATION)*/';

    SBPACKAGESQL := 'SELECT ',, SBPACKAGEHINTS                                          ,,CHR(10),,
                                CC_BOOSSPACKAGE.SBPACKAGEATTRIBUTES                     ,,CHR(10),,
                    'FROM '  ,, '/*+ cc_boOssProductComponent.FillPackageAttributes*/'  ,,CHR(10),,
                                 CC_BOOSSPACKAGE.SBPACKAGEFROM,,', '                    ,,CHR(10),,
                                ' mo_component, mo_motive '                             ,,CHR(10),,
                    'WHERE ' ,, ' mo_component.component_id_prod =:Component'           ,,CHR(10),,
                    'AND '   ,, ' mo_component.motive_id = mo_motive.motive_id'         ,,CHR(10),,
                    'AND '   ,, ' mo_motive.package_id = a.package_id'                  ,,CHR(10),,
                    'AND '   ,, CC_BOOSSPACKAGE.SBPACKAGEWHERE;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;

PROCEDURE GETPACKAGES
(
    INUCOMPONENT IN NUMBER,
    OCUCURSOR    OUT CONSTANTS.TYREFCURSOR
)
IS
BEGIN
    FILLPACKAGEATTRIBUTES;

    OPEN OCUCURSOR FOR SBPACKAGESQL USING INUCOMPONENT, INUCOMPONENT;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;















PROCEDURE FILLRETIREATTRIBUTES
IS
SBRETIRETYPE  VARCHAR2(100);
BEGIN
    SBRETIRETYPE := 'pr_component_retire.retire_type_id',, CC_BOBOSSUTIL.CSBSEPARATOR ,,'ge_retire_type.description';

    CC_BOBOSSUTIL.ADDATTRIBUTE ('pr_component_retire.component_retire_id', 'retire_id',     CC_BOBOSSUTIL.CNUNUMBER,   SBRETIREATTRIBUTES, TBRETIREATTRIBUTES, TRUE);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBRETIRETYPE,                              'retire_type',   CC_BOBOSSUTIL.CNUVARCHAR2, SBRETIREATTRIBUTES, TBRETIREATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('pr_component_retire.register_date',       'register_date', CC_BOBOSSUTIL.CNUDATE,     SBRETIREATTRIBUTES, TBRETIREATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('pr_component_retire.retire_date',         'retire_date',   CC_BOBOSSUTIL.CNUDATE,     SBRETIREATTRIBUTES, TBRETIREATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (':parent_id',                              'parent_id',     CC_BOBOSSUTIL.CNUNUMBER,   SBRETIREATTRIBUTES, TBRETIREATTRIBUTES);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;















PROCEDURE GETRETIRES
(
    INUCOMPONENT IN NUMBER,
    OCUCURSOR    OUT CONSTANTS.TYREFCURSOR
)
IS
    SBRETIRESQL              VARCHAR2(32767);
BEGIN
    FILLRETIREATTRIBUTES;

    SBRETIRESQL := 'select ',, SBRETIREATTRIBUTES                                             ,,CHR(10),,
                     'from pr_component_retire, ge_retire_type'                               ,,CHR(10),,
                    'where ge_retire_type.retire_type_id = pr_component_retire.retire_type_id',,CHR(10),,
                      'and pr_component_retire.component_id = :Component';

    OPEN OCUCURSOR FOR SBRETIRESQL USING INUCOMPONENT, INUCOMPONENT;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;



PROCEDURE GETRETIRE
(
    INURETIRE   IN  PR_COMPONENT_RETIRE.COMPONENT_RETIRE_ID%TYPE,
    OCUCURSOR   OUT CONSTANTS.TYREFCURSOR
)
IS
    SBRETIRESQL              VARCHAR2(32767);
BEGIN
    FILLRETIREATTRIBUTES;

    SBRETIRESQL := 'select ',, SBRETIREATTRIBUTES                                             ,,CHR(10),,
                     'from pr_component_retire, ge_retire_type'                               ,,CHR(10),,
                    'where ge_retire_type.retire_type_id = pr_component_retire.retire_type_id',,CHR(10),,
                      'and pr_component_retire.component_retire_id = :inuRetire';

    OPEN OCUCURSOR FOR SBRETIRESQL USING CC_BOBOSSUTIL.CNUNULL, INURETIRE;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;




PROCEDURE GETCOMPONENTBYRETIRE
(
    INURETIRE       IN      PR_COMPONENT_RETIRE.COMPONENT_RETIRE_ID%TYPE,
    ONUCOMPONENT    OUT     PR_COMPONENT.COMPONENT_ID%TYPE
)
IS
BEGIN
    IF INURETIRE IS NULL THEN
        ONUCOMPONENT := NULL;
        RETURN;
    END IF;

    DAPR_COMPONENT_RETIRE.ACCKEY (INURETIRE);

    ONUCOMPONENT := DAPR_COMPONENT_RETIRE.FNUGETCOMPONENT_ID (INURETIRE);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        ONUCOMPONENT := NULL;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;



PROCEDURE GETSUSPENSIONS
(
    INUCOMPONENT IN NUMBER,
    OCUCURSOR    OUT CONSTANTS.TYREFCURSOR
)
IS
    SBSQL   VARCHAR2(1000);
BEGIN
    CC_BOOSSSUSPENSION.FILLCOMPSUSPATTRIBS;

    SBSQL := ' SELECT ',,CC_BOOSSSUSPENSION.SBCOMPSUSPATTRIBS,,CHR(10),,
             ' FROM pr_comp_suspension, ge_suspension_type',,CHR(10),,
             ' WHERE pr_comp_suspension.suspension_type_id = ge_suspension_type.suspension_type_id',,CHR(10),,
             ' AND pr_comp_suspension.component_id = :inuComponent';

    OPEN OCUCURSOR FOR SBSQL USING INUCOMPONENT, INUCOMPONENT;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;


























FUNCTION FSBPRODUCTCOMPADDRESS
(
    INUPRODUCTCOMPID            IN PR_COMPONENT.COMPONENT_ID%TYPE
)
RETURN AB_ADDRESS.ADDRESS%TYPE
IS
    SBADDRESS  AB_ADDRESS.ADDRESS%TYPE;

    CURSOR CUADDRESS
    (
        NUPRODUCTCOMPID        PR_COMPONENT.COMPONENT_ID%TYPE
    )
    IS
        SELECT  AB_ADDRESS.ADDRESS
        FROM    PR_COMPONENT,
                AB_ADDRESS
        WHERE   PR_COMPONENT.COMPONENT_ID = NUPRODUCTCOMPID
        AND     PR_COMPONENT.ADDRESS_ID = AB_ADDRESS.ADDRESS_ID
    ;

BEGIN
    OPEN CUADDRESS (INUPRODUCTCOMPID);
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























FUNCTION FSBPRODCOMPDATACONNECT
(
    INUPRODUCTCOMPID IN  PR_COMPONENT.COMPONENT_ID%TYPE
)
RETURN PR_DATA_CONNECTION.COMMENT_%TYPE
IS

SBADDRESS  PR_DATA_CONNECTION.COMMENT_%TYPE;

    CURSOR CUADDRESS
    (
        NUPRODUCTCOMPID  PR_COMPONENT.COMPONENT_ID%TYPE
    )
    IS
        SELECT PR_DATA_CONNECTION.COMMENT_
          FROM PR_DATA_CONNECTION
            WHERE PR_DATA_CONNECTION.COMPONENT_ID = NUPRODUCTCOMPID;

BEGIN
    OPEN CUADDRESS(INUPRODUCTCOMPID);
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











FUNCTION FSBGETPRODUCTCOMPADDRESS
(
    INUPRODUCTCOMPID    IN PR_COMPONENT.COMPONENT_ID%TYPE
)
RETURN VARCHAR2
IS
    SBADDRESS   AB_ADDRESS.ADDRESS%TYPE;
BEGIN
    UT_TRACE.TRACE('Iniciando CC_BOOssProductComponent.fsbGetProductCompAddress Componente[',,INUPRODUCTCOMPID,,']', 5);

    SBADDRESS := FSBPRODUCTCOMPADDRESS (INUPRODUCTCOMPID);

    UT_TRACE.TRACE('Direcci�n [',,SBADDRESS,,']', 5);

    UT_TRACE.TRACE('Fin CC_BOOssProductComponent.fsbGetProductCompAddress', 5);

    RETURN (SBADDRESS);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;





























FUNCTION FNUPRODCOMPADDRGEOLOCAT
(
    INUPRODUCTCOMP      IN PR_COMPONENT.COMPONENT_ID%TYPE
)
RETURN AB_ADDRESS.GEOGRAP_LOCATION_ID%TYPE
IS

    NUGEOGRAPLOCATIONID  AB_ADDRESS.GEOGRAP_LOCATION_ID%TYPE;

    CURSOR CUGEOGRAPLOCATION
    (
        NUPRODUCTCOMP      PR_COMPONENT.COMPONENT_ID%TYPE
    )
    IS
        SELECT  GEOGRAP_LOCATION_ID
        FROM    PR_COMPONENT,
                AB_ADDRESS
        WHERE   PR_COMPONENT.COMPONENT_ID = NUPRODUCTCOMP
        AND     PR_COMPONENT.ADDRESS_ID = AB_ADDRESS.ADDRESS_ID;

BEGIN
    OPEN CUGEOGRAPLOCATION (INUPRODUCTCOMP);
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




























FUNCTION FNUPRODCOMPPREMISEGEOLOCAT
(
    INUPRODUCTCOMP      IN PR_COMPONENT.COMPONENT_ID%TYPE
    
)
RETURN AB_ADDRESS.GEOGRAP_LOCATION_ID%TYPE
IS

    NUGEOGRAPLOCATIONID  AB_ADDRESS.GEOGRAP_LOCATION_ID%TYPE;

    CURSOR CUGEOGRAPLOCATION
    (
        NUPRODUCTCOMP       PR_COMPONENT.COMPONENT_ID%TYPE
        
    )
    IS
        




        SELECT AB_ADDRESS.GEOGRAP_LOCATION_ID
        FROM   AB_ADDRESS, PR_COMPONENT
        WHERE  PR_COMPONENT.COMPONENT_ID = NUPRODUCTCOMP
               AND AB_ADDRESS.ADDRESS_ID = PR_COMPONENT.ADDRESS_ID
        ;

BEGIN
    OPEN CUGEOGRAPLOCATION (INUPRODUCTCOMP  );
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




FUNCTION FSBGEOGLOCATBYPRODUCTCOMP
(
    INUPRODUCTCOMPID         IN PR_COMPONENT.COMPONENT_ID%TYPE
    
)
RETURN VARCHAR2
IS

NUGEOGRAPLOCATIONID     GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE := NULL;

BEGIN
    UT_TRACE.TRACE('Iniciando CC_BOOssProductComponent.fsbGeogLocatByProductComp Componente[',,INUPRODUCTCOMPID,,']', 5);

    
    NUGEOGRAPLOCATIONID := FNUPRODCOMPADDRGEOLOCAT (INUPRODUCTCOMPID);
    IF NUGEOGRAPLOCATIONID IS NULL THEN
        NUGEOGRAPLOCATIONID := FNUPRODCOMPPREMISEGEOLOCAT (INUPRODUCTCOMPID   );
    END IF;
    UT_TRACE.TRACE('Id Ubicaci�n Geogr�fica [',,NUGEOGRAPLOCATIONID,,']', 5);

     UT_TRACE.TRACE('Fin CC_BOOssMotive.fsbGeograpLocationByMot', 5);
    
    RETURN (CC_BOOSSDESCRIPTION.FSBGETDESCRIPTION(NUGEOGRAPLOCATIONID,CC_BOOSSDESCRIPTION.FSBGEOGRALOCATION(NUGEOGRAPLOCATIONID)) );

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;


























FUNCTION FNUPRODCOMPADDRNEIGH
(
    INUPRODUCTCOMPID    IN PR_COMPONENT.COMPONENT_ID%TYPE
)
RETURN AB_ADDRESS.NEIGHBORTHOOD_ID%TYPE
IS

    NUNEIGHBORTHOODID  AB_ADDRESS.NEIGHBORTHOOD_ID%TYPE;

    CURSOR CUNEIGHBORTHOOD
    (
        NUPRODUCTCOMPID    PR_COMPONENT.COMPONENT_ID%TYPE
    )
    IS
        SELECT  AB_ADDRESS.NEIGHBORTHOOD_ID
        FROM    PR_COMPONENT,
                AB_ADDRESS
        WHERE   PR_COMPONENT.COMPONENT_ID = NUPRODUCTCOMPID
        AND     PR_COMPONENT.ADDRESS_ID = AB_ADDRESS.ADDRESS_ID
    ;


BEGIN
    OPEN CUNEIGHBORTHOOD (INUPRODUCTCOMPID);
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




FUNCTION FSBNEIGHBYPRODUCTCOMP
(
    INUPRODUCTCOMPID         IN PR_COMPONENT.COMPONENT_ID%TYPE
)
RETURN VARCHAR2
IS

NUNEIGHBORTHOODID       AB_ADDRESS.NEIGHBORTHOOD_ID%TYPE := NULL;
SBNEIGHBORTHOODNAME     VARCHAR2(1000);
SBNEIGHBORTHOOD         VARCHAR2(1000);

BEGIN
    UT_TRACE.TRACE('Iniciando CC_BOOssProductComponent.fsbNeighByProductComp Componente[',,INUPRODUCTCOMPID,,']', 5);

    
    NUNEIGHBORTHOODID := FNUPRODCOMPADDRNEIGH(INUPRODUCTCOMPID);
    UT_TRACE.TRACE('Id Barrio [',,NUNEIGHBORTHOODID,,']', 5);

    
    IF NUNEIGHBORTHOODID IS NOT NULL THEN
        SBNEIGHBORTHOODNAME := GE_BOBASICDATASERVICES.FSBGETDESCNEIGHBORTHOOD(NUNEIGHBORTHOODID);
    END IF;
    UT_TRACE.TRACE('Nombre Barrio [',,SBNEIGHBORTHOODNAME,,']', 5);

    
    SBNEIGHBORTHOOD :=   NUNEIGHBORTHOODID,, GE_BOCONSTANTS.CSBSEPARADOR ,,SBNEIGHBORTHOODNAME;
    UT_TRACE.TRACE('Barrio [',,SBNEIGHBORTHOOD,,']', 5);

    UT_TRACE.TRACE('Fin CC_BOOssProductComponent.fsbNeighByProductComp', 5);
    RETURN (SBNEIGHBORTHOOD);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;
























PROCEDURE FILLADDRESSPREMISEATTRIBUTES
(
    INUPRODUCTCOMPID    IN  PR_COMPONENT.COMPONENT_ID%TYPE
)
IS
    SBADDRESSPREMISEID  VARCHAR2(300);
    SBADDRESS           VARCHAR2(300);
    SBGEOGRAPH          VARCHAR2(300);
    SBNEIGHBORHOOD      VARCHAR2(300);
    SBADDRESSTYPE       VARCHAR2(300);
    SBPREMISETYPE       VARCHAR2(300);
    
    SBPREMISE           VARCHAR2(300);
    SBADDRESSID         VARCHAR2(300);
    SBPREMISEID         VARCHAR2(300);

BEGIN
    UT_TRACE.TRACE('Iniciando CC_BOOssProductComponent.FillAddressPremiseAttributes Componente[',,INUPRODUCTCOMPID,,']', 5);

    IF SBADDRESSPREMISEATTRIBUTES IS NOT NULL THEN
        UT_TRACE.TRACE('Cadena de Atributos con valores [',,SBADDRESSPREMISEATTRIBUTES,,']', 5);
        RETURN;
    END IF;

    
    SBADDRESSPREMISEID := 'ab_address.address_id';
    
    SBADDRESS          := 'ab_address.address';
    
    SBPREMISE          := 'null';
    
    SBGEOGRAPH         := 'CC_BOOssProductComponent.fsbGeogLocatByProductComp(pr_component.component_id)';
    
    SBNEIGHBORHOOD     := 'CC_BOOssProductComponent.fsbNeighByProductComp(pr_component.component_id)';
    
    SBADDRESSID        := 'ab_address.address_id';
    
    SBPREMISEID        := 'ab_premise.premise_id';
    
    SBADDRESSTYPE      := 'decode(ab_address.is_main,null,null,''Y'',''1'',''N'',''2'')',,CC_BOBOSSUTIL.CSBSEPARATOR,,'decode(ab_address.is_main,null,null,''Y'',dage_address_type.fsbGetDescription(1),''N'',dage_address_type.fsbGetDescription(2))';
    
    SBPREMISETYPE      := 'ab_premise.premise_type_id ',, CC_BOBOSSUTIL.CSBSEPARATOR ,,' decode(null, ab_premise.premise_type_id, null, daab_premise_type.fsbGetDescription(ab_premise.premise_type_id))';

    CC_BOBOSSUTIL.ADDATTRIBUTE (SBADDRESSPREMISEID,                     'id',                    CC_BOBOSSUTIL.CNUVARCHAR2, SBADDRESSPREMISEATTRIBUTES, TBADDRESSPREMISEATTRIBUTES, TRUE);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBADDRESS,                              'address',               CC_BOBOSSUTIL.CNUVARCHAR2, SBADDRESSPREMISEATTRIBUTES, TBADDRESSPREMISEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBPREMISE,                              'description',           CC_BOBOSSUTIL.CNUVARCHAR2, SBADDRESSPREMISEATTRIBUTES, TBADDRESSPREMISEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBGEOGRAPH,                             'geograp_location_id',   CC_BOBOSSUTIL.CNUVARCHAR2, SBADDRESSPREMISEATTRIBUTES, TBADDRESSPREMISEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBNEIGHBORHOOD,                         'neighborthood_id',      CC_BOBOSSUTIL.CNUVARCHAR2, SBADDRESSPREMISEATTRIBUTES, TBADDRESSPREMISEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBADDRESSID,                            'address_id',            CC_BOBOSSUTIL.CNUNUMBER,   SBADDRESSPREMISEATTRIBUTES, TBADDRESSPREMISEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBPREMISEID,                            'manual_premise_id',     CC_BOBOSSUTIL.CNUNUMBER,   SBADDRESSPREMISEATTRIBUTES, TBADDRESSPREMISEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBADDRESSTYPE,                          'address_type_id',       CC_BOBOSSUTIL.CNUVARCHAR2, SBADDRESSPREMISEATTRIBUTES, TBADDRESSPREMISEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBPREMISETYPE,                          'premise_type_id',       CC_BOBOSSUTIL.CNUVARCHAR2, SBADDRESSPREMISEATTRIBUTES, TBADDRESSPREMISEATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (':parent_id',                           'parent_id',             CC_BOBOSSUTIL.CNUNUMBER,   SBADDRESSPREMISEATTRIBUTES, TBADDRESSPREMISEATTRIBUTES);

    UT_TRACE.TRACE('Fin CC_BOOssProductComponent.FillAddressPremiseAttributes', 5);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;

























PROCEDURE GETADDRESSANDPREMISE
(
    INUPRCOMPONENTID    IN  PR_COMPONENT.COMPONENT_ID%TYPE,
    OCUDATACURSOR       OUT CONSTANTS.TYREFCURSOR
)
IS
    SBSQL     VARCHAR2(32767);

BEGIN
    UT_TRACE.TRACE('Iniciando CC_BOOssProductComponent.GetAddressAndPremise Componente[',,INUPRCOMPONENTID,,']', 5);

    
    
    
    SBADDRESSPREMISEATTRIBUTES := NULL;

    FILLADDRESSPREMISEATTRIBUTES(INUPRCOMPONENTID);

    SBSQL :=    'SELECT ',, SBADDRESSPREMISEATTRIBUTES ,,CHR(10),,
                'FROM   ab_address, pr_component,ab_premise',,CHR(10),,
                'WHERE  ab_address.estate_number = (SELECT estate_number',,CHR(10),,
                '                                   FROM   ab_address',,CHR(10),,
                '                                   WHERE  address_id = ( SELECT address_id',,CHR(10),,
                '                                                         FROM   pr_component',,CHR(10),,
                '                                                         WHERE  component_id= :inuPrComponentId',,CHR(10),,
                '                                                       )',,CHR(10),,
                '                                   )',,CHR(10),,
                '       and pr_component.component_id= :inuPrComponentId',,CHR(10),,
                '       and ab_address.estate_number = ab_premise.premise_id ',,CHR(10),,
                'UNION ALL ',,CHR(10),,
                'SELECT ',, SBADDRESSPREMISEATTRIBUTES ,,CHR(10),,
                'FROM   ab_address, pr_component, (select TO_number(NULL) premise_id, TO_number(NULL) premise_type_id FROM dual) ab_premise ',,CHR(10),,
                'WHERE  ab_address.address_id = pr_component.address_id',,CHR(10),,
                '       AND ab_address.estate_number IS NULL',,CHR(10),,
                '       AND pr_component.component_id= :inuPrComponentId'
     ;

    UT_TRACE.TRACE('Consulta de direcciones de Componente [',,SBSQL,,']', 5);

    OPEN OCUDATACURSOR FOR SBSQL USING INUPRCOMPONENTID, INUPRCOMPONENTID, INUPRCOMPONENTID, INUPRCOMPONENTID, INUPRCOMPONENTID;
    
    UT_TRACE.TRACE('Termina CC_BOOssProductComponent.GetAddressAndPremise', 5);
EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;












PROCEDURE FILLWARRANTYATTRIBUTES
(
        INUPRODCOMPID IN  PR_COMPONENT.COMPONENT_ID%TYPE
)
IS
    SBWARRANTYCOMPID    VARCHAR2(300);
    SBVEHICLEID         VARCHAR2(300);
    SBSTARTDATE         VARCHAR2(300);
    SBINITIALMILIAGE    VARCHAR2(300);
    SBVALIDITYPERIOD    VARCHAR2(300);
    SBINSURANCECOMPANY  VARCHAR2(300);
BEGIN
    UT_TRACE.TRACE('Iniciando cc_boOssProductComponent.FillWarrantyAttributes Componente[',,INUPRODCOMPID,,']', 5);

    IF SBWARRANTYATTRIBUTES IS NOT NULL THEN
        UT_TRACE.TRACE('Cadena de Atributos con valores [',,SBWARRANTYATTRIBUTES,,']', 5);
        RETURN;
    END IF;

    SBWARRANTYCOMPID    := 'pr_warranty_comp.warranty_comp_id';
    SBVEHICLEID         := 'pr_warranty_comp.vehicle_id',, CC_BOBOSSUTIL.CSBSEPARATOR ,,'decode(pr_warranty_comp.vehicle_id, null, null, dacc_vehicle.fsbGetNumber_plate(pr_warranty_comp.vehicle_id))';
    SBSTARTDATE         := 'pr_warranty_comp.start_date';
    SBINITIALMILIAGE    := 'pr_warranty_comp.initial_miliage';
    SBVALIDITYPERIOD    := 'pr_warranty_comp.validity_period';
    SBINSURANCECOMPANY  := 'CC_BCInsurancePolicy.fnuGetInsuCompanyId(pr_warranty_comp.vehicle_id)',, CC_BOBOSSUTIL.CSBSEPARATOR ,,'dage_insurance_company.fsbGetInsurance_company_name(CC_BCInsurancePolicy.fnuGetInsuCompanyId(pr_warranty_comp.vehicle_id))';


    CC_BOBOSSUTIL.ADDATTRIBUTE (SBWARRANTYCOMPID,                     'warranty_comp_id',                   CC_BOBOSSUTIL.CNUVARCHAR2, SBWARRANTYATTRIBUTES, TBWARRANTYATTRIBUTES, TRUE);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBVEHICLEID,                          'vehicle',           CC_BOBOSSUTIL.CNUVARCHAR2, SBWARRANTYATTRIBUTES, TBWARRANTYATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBSTARTDATE,                          'start_date',           CC_BOBOSSUTIL.CNUVARCHAR2, SBWARRANTYATTRIBUTES, TBWARRANTYATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBINITIALMILIAGE,                     'initial_miliage',      CC_BOBOSSUTIL.CNUVARCHAR2, SBWARRANTYATTRIBUTES, TBWARRANTYATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBVALIDITYPERIOD,                     'validity_period',      CC_BOBOSSUTIL.CNUVARCHAR2, SBWARRANTYATTRIBUTES, TBWARRANTYATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBINSURANCECOMPANY,                   'InsuranceCompany',      CC_BOBOSSUTIL.CNUVARCHAR2, SBWARRANTYATTRIBUTES, TBWARRANTYATTRIBUTES);

    UT_TRACE.TRACE('Fin cc_boOssProductComponent.FillWarrantyAttributes', 5);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;











PROCEDURE GETWARRANTY
(
    INUPRCOMPONENTID    IN  PR_COMPONENT.COMPONENT_ID%TYPE,
    OCUDATACURSOR       OUT CONSTANTS.TYREFCURSOR
)
IS
    SBSELECT1 VARCHAR2(32767);
    SBSQL     VARCHAR2(32767);

BEGIN
    UT_TRACE.TRACE('Iniciando cc_boOssProductComponent.GetWarranty Componente[',,INUPRCOMPONENTID,,']', 5);

    
    
    SBWARRANTYATTRIBUTES := NULL;

    FILLWARRANTYATTRIBUTES(INUPRCOMPONENTID);

    SBSELECT1 :=           'SELECT ',, SBWARRANTYATTRIBUTES ,,CHR(10),,
                           'FROM PR_WARRANTY_COMP',,CHR(10),,
                            'WHERE PR_WARRANTY_COMP.COMPONENT_ID = :inuMoComponentId';

    UT_TRACE.TRACE('Consulta de Garantia Extendida de Componente de Motivo [',,SBSELECT1,,']', 5);




    SBSQL :=    SBSELECT1      ,,CHR(10);

    UT_TRACE.TRACE('Consulta Garantia Extendidas de Componente de Motivo [',,SBSQL,,']', 5);

    OPEN OCUDATACURSOR FOR SBSQL USING INUPRCOMPONENTID;

    UT_TRACE.TRACE('Fin cc_boOssProductComponent.GetWarranty', 5);
EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;











PROCEDURE FILLEQUIPMENTATTRIBUTES
(
    INUPRODCOMPID IN  PR_COMPONENT.COMPONENT_ID%TYPE
)
IS
    
    SBMARK      VARCHAR2(300);
    SBMODEL     VARCHAR2(300);
    SBSERIALNUMBER VARCHAR2(300);
    SBID        VARCHAR2(300);
BEGIN
    UT_TRACE.TRACE('Iniciando cc_boOssProductComponent.FillEquipmentAttributes Componente[',,INUPRODCOMPID,,']', 5);

    IF SBEQUIPMENTATTRIBUTES IS NOT NULL THEN
        UT_TRACE.TRACE('Cadena de Atributos con valores [',,SBEQUIPMENTATTRIBUTES,,']', 5);
        RETURN;
    END IF;

    SBSERIALNUMBER      := 'if_assignable.serial_number';
    SBMARK              := 'if_assignable.mark';
    SBMODEL             := 'if_assignable.model';
    SBID                := 'if_assignable.id';

    CC_BOBOSSUTIL.ADDATTRIBUTE (SBID,                     'element_id',                   CC_BOBOSSUTIL.CNUVARCHAR2, SBEQUIPMENTATTRIBUTES, TBEQUIPMENTATTRIBUTES, TRUE);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBSERIALNUMBER,           'serial_number',        CC_BOBOSSUTIL.CNUVARCHAR2, SBEQUIPMENTATTRIBUTES, TBEQUIPMENTATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBMARK,                   'mark',                 CC_BOBOSSUTIL.CNUVARCHAR2, SBEQUIPMENTATTRIBUTES, TBEQUIPMENTATTRIBUTES);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBMODEL,                  'model',                CC_BOBOSSUTIL.CNUVARCHAR2, SBEQUIPMENTATTRIBUTES, TBEQUIPMENTATTRIBUTES);

    UT_TRACE.TRACE('Fin cc_boOssProductComponent.FillEquipmentAttributes', 5);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;











PROCEDURE GETEQUIPMENT
(
    INUPRCOMPONENTID    IN  PR_COMPONENT.COMPONENT_ID%TYPE,
    OCUDATACURSOR       OUT CONSTANTS.TYREFCURSOR
)
IS
    SBSELECT1   VARCHAR2(32767);
    SBSQL       VARCHAR2(32767);
    NUCATESERV  NUMBER := IM_BOCONSTANTS.CNUCATEGORYSERVICES;

BEGIN
    UT_TRACE.TRACE('Iniciando cc_boOssProductComponent.GetEquipment Componente[',,INUPRCOMPONENTID,,']', 5);

    
    
    SBEQUIPMENTATTRIBUTES := NULL;

    FILLEQUIPMENTATTRIBUTES(INUPRCOMPONENTID);

    SBSELECT1 :=           'SELECT ',, SBEQUIPMENTATTRIBUTES ,,CHR(10),,
                           'FROM pr_network_elem_oper, if_assignable',,CHR(10),,
                            'WHERE pr_network_elem_oper.element_id = if_assignable.id  ',,CHR(10),,
                            'AND pr_network_elem_oper.COMPONENT_ID = :inuMoComponentId ',,CHR(10),,
                            'AND pr_network_elem_oper.category_id  = ',, NUCATESERV;

    UT_TRACE.TRACE('Consulta de equipos de seguridad de Componente de Producto [',,SBSELECT1,,']', 5);




    SBSQL :=    SBSELECT1      ,,CHR(10);

    UT_TRACE.TRACE('Consulta equipos de seguridad de Componente de Producto [',,SBSQL,,']', 5);

    OPEN OCUDATACURSOR FOR SBSQL USING INUPRCOMPONENTID;

    UT_TRACE.TRACE('Fin cc_boOssProductComponent.GetEquipment', 5);
EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;


PROCEDURE FILLCHILDCOMPATT
IS
SBCOMPTYPE      VARCHAR2(200);
SBCOMPSTATUS    VARCHAR2(200);
SBCLASSSERVICE  VARCHAR2(200);
SBCOMMPLAN      VARCHAR2(200);
BEGIN
    IF SBCHILDCOMPATT IS NOT NULL THEN
        RETURN;
    END IF;

    SBCOMPTYPE     := 'vw_pr_component.component_type_id'   ,, CC_BOBOSSUTIL.CSBSEPARATOR ,, 'cc_boOssDescription.fsbComponentType(vw_pr_component.component_type_id)';
    SBCOMPSTATUS   := 'vw_pr_component.component_status_id' ,, CC_BOBOSSUTIL.CSBSEPARATOR ,, 'cc_boOssDescription.fsbProductStatus(vw_pr_component.component_status_id)';
    SBCLASSSERVICE := 'vw_pr_component.class_service_id'    ,, CC_BOBOSSUTIL.CSBSEPARATOR ,, 'cc_boOssDescription.fsbServiceClass(vw_pr_component.class_service_id)';
    SBCOMMPLAN     := 'vw_pr_component.commercial_plan_id'  ,, CC_BOBOSSUTIL.CSBSEPARATOR ,, 'cc_boOssDescription.fsbCommercialPlan(vw_pr_component.commercial_plan_id)';

    CC_BOBOSSUTIL.ADDATTRIBUTE ('vw_pr_component.component_id',   'component_id',        CC_BOBOSSUTIL.CNUNUMBER,   SBCHILDCOMPATT, TBCHILDCOMPATT, TRUE);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('vw_pr_component.service_number', 'service_number',      CC_BOBOSSUTIL.CNUVARCHAR2, SBCHILDCOMPATT, TBCHILDCOMPATT);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBCOMPTYPE,                       'component_type_id',   CC_BOBOSSUTIL.CNUNUMBER,   SBCHILDCOMPATT, TBCHILDCOMPATT);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBCOMPSTATUS,                     'component_status_id', CC_BOBOSSUTIL.CNUNUMBER,   SBCHILDCOMPATT, TBCHILDCOMPATT);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBCLASSSERVICE,                   'class_service_id',    CC_BOBOSSUTIL.CNUNUMBER,   SBCHILDCOMPATT, TBCHILDCOMPATT);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('vw_pr_component.creation_date',  'creation_date',       CC_BOBOSSUTIL.CNUDATE,     SBCHILDCOMPATT, TBCHILDCOMPATT);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('vw_pr_component.quantity',       'quantity',            CC_BOBOSSUTIL.CNUNUMBER,   SBCHILDCOMPATT, TBCHILDCOMPATT);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBCOMMPLAN,                       'commercial_plan_id',  CC_BOBOSSUTIL.CNUNUMBER,   SBCHILDCOMPATT, TBCHILDCOMPATT);
    CC_BOBOSSUTIL.ADDATTRIBUTE (':parent_id',                     'parent_id',           CC_BOBOSSUTIL.CNUNUMBER,   SBCHILDCOMPATT, TBCHILDCOMPATT);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;

PROCEDURE GETCHILDCOMPONENTS
(
    INUCOMPONENTID  IN  PR_COMPONENT.COMPONENT_ID%TYPE,
    OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
)
IS
    SBSQL     VARCHAR2(32767);
BEGIN
    UT_TRACE.TRACE('Iniciando cc_boOssProductComponent.GetChildComponents Componente[',,INUCOMPONENTID,,']', 5);

    
    SBCHILDCOMPATT := NULL;

    FILLCHILDCOMPATT;

    SBSQL := 'SELECT ',, SBCHILDCOMPATT ,,CHR(10),,
             'FROM vw_pr_component, ps_component_type, ps_product_status, ps_class_service',,CHR(10),,
             'WHERE vw_pr_component.parent_component_id = :inuComponentId',,CHR(10),,
             'AND   vw_pr_component.component_type_id   = ps_component_type.component_type_id',,CHR(10),,
             'AND   vw_pr_component.component_status_id = ps_product_status.product_status_id',,CHR(10),,
             'AND   vw_pr_component.class_service_id    = ps_class_service.class_service_id (+)',,CHR(10),,
             'ORDER BY vw_pr_component.component_id';

    UT_TRACE.TRACE('Consulta de los componentes hijos [',,SBSQL,,']', 5);

    OPEN OCUDATACURSOR FOR SBSQL USING INUCOMPONENTID, INUCOMPONENTID;

    UT_TRACE.TRACE('Fin cc_boOssProductComponent.GetChildComponents', 5);
EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;


PROCEDURE GETCHILDCOMPONENBYID
(
    INUCOMPONENTID  IN  PR_COMPONENT.COMPONENT_ID%TYPE,
    OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
)
IS
    SBSQL     VARCHAR2(32767);
BEGIN
    UT_TRACE.TRACE('Iniciando cc_boOssProductComponent.GetChildComponenById Componente[',,INUCOMPONENTID,,']', 5);

    
    FILLCHILDCOMPATT;

    SBSQL := 'SELECT ',, SBCHILDCOMPATT ,,CHR(10),,
             'FROM vw_pr_component, ps_component_type, ps_product_status, ps_class_service',,CHR(10),,
             'WHERE vw_pr_component.component_id = :inuComponentId',,CHR(10),,
             'AND   vw_pr_component.component_type_id   = ps_component_type.component_type_id',,CHR(10),,
             'AND   vw_pr_component.component_status_id = ps_product_status.product_status_id',,CHR(10),,
             'AND   vw_pr_component.class_service_id    = ps_class_service.class_service_id (+)';

    UT_TRACE.TRACE('Consulta de componente hijo por Id [',,SBSQL,,']', 5);

    OPEN OCUDATACURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INUCOMPONENTID;

    UT_TRACE.TRACE('Fin cc_boOssProductComponent.GetChildComponenById', 5);
EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;


PROCEDURE GETPARENTCOMPBYCHILD
(
    INUCOMPONENTID  IN  PR_COMPONENT.COMPONENT_ID%TYPE,
    ONUCOMPONENTID  OUT PR_COMPONENT.COMPONENT_ID%TYPE
)
IS
    CURSOR CUGETPARENTCOMPBYCHILD
    (
        INUCHILDCOMP    IN  NUMBER
    )
    IS
        SELECT PARENT_COMPONENT_ID
            FROM VW_PR_COMPONENT
            WHERE COMPONENT_ID = INUCHILDCOMP;
BEGIN
    UT_TRACE.TRACE('Iniciando cc_boOssProductComponent.GetParentCompByChild Componente Hijo[',,INUCOMPONENTID,,']', 5);


    IF INUCOMPONENTID IS NULL THEN
        ONUCOMPONENTID := NULL;
        RETURN;
    END IF;

    OPEN CUGETPARENTCOMPBYCHILD(INUCOMPONENTID);
        FETCH CUGETPARENTCOMPBYCHILD INTO ONUCOMPONENTID;
    CLOSE CUGETPARENTCOMPBYCHILD;


    UT_TRACE.TRACE('Fin cc_boOssProductComponent.GetParentCompByChild Componente Padre[',,ONUCOMPONENTID,,']', 5);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        ONUCOMPONENTID := NULL;
        IF (CUGETPARENTCOMPBYCHILD%ISOPEN) THEN
            CLOSE CUGETPARENTCOMPBYCHILD;
        END IF;

    WHEN OTHERS THEN
        IF (CUGETPARENTCOMPBYCHILD%ISOPEN) THEN
            CLOSE CUGETPARENTCOMPBYCHILD;
        END IF;
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;


PROCEDURE GETPRODUCT
(
    INUCOMPONENT    IN NUMBER,
    ONUPRODUCT      OUT NUMBER
)
IS
BEGIN
    IF INUCOMPONENT IS NULL THEN
        ONUPRODUCT := NULL;
        RETURN;
    END IF;

    DAPR_COMPONENT.ACCKEY (INUCOMPONENT);

    ONUPRODUCT := DAPR_COMPONENT.FNUGETPRODUCT_ID (INUCOMPONENT);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        ONUPRODUCT := NULL;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;

    
















    PROCEDURE GETCOMPONENT
    (
        INUCOMPONENTID  IN PR_COMPONENT.COMPONENT_ID%TYPE,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQL  VARCHAR2(10000);
        SBHINTS  VARCHAR2(500);
    BEGIN
        FILLCOMPONENTATTRIBUTES;
        
        SBHINTS :=  ' /*+ leading(a) index(a PK_PR_COMPONENT ) ',,CHR(10),,
                    SBCOMPHINTSDEF;

        SBSQL :=  ' SELECT '                                ,,CHR(10),,
                  SBHINTS                                   ,,CHR(10),,
                  SBCOMPONENTATTR                           ,,CHR(10),,
                  ' FROM ',,'/*+ cc_boOssProductComponent.GetComponent*/' ,,CHR(10),,
                            SBCOMPONENTFROM                 ,,CHR(10),,
                  ' WHERE a.component_id = :inuComponentId' ,,CHR(10),,
                  ' AND ',,SBCOMPONENTWHERE;

        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INUCOMPONENTID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE GETPROMOTIONS
    (
        INUCOMPONENT IN  PR_COMPONENT.COMPONENT_ID%TYPE,
        OCUCURSOR    OUT CONSTANTS.TYREFCURSOR
    )
    IS

    SBSQL     VARCHAR2(4000);
    SBHINT      VARCHAR2(4000);
    
    BEGIN
        UT_TRACE.TRACE('Iniciando cc_boOssProductComponent.GetPromotions componente[',,INUCOMPONENT,,']', 5);

        CC_BOOSSPROMOTION.FILLPROMOTIONATTRIBUTES;

        SBHINT :=  '/*+ leading (pr_promotion) use_nl (pr_promotion pr_component) use_nl (pr_promotion cc_promotion) use_nl (pr_component ps_component_type) use_nl (pr_component ps_class_service)   */ ';

        SBSQL :=
             'SELECT ' ,,SBHINT,, CC_BOOSSPROMOTION.SBPROMOTIONATTRIBUTES                                                   ,,CHR(10),,
             '  FROM PR_PROMOTION, CC_PROMOTION, SERVICIO, PR_COMPONENT, PS_COMPONENT_TYPE, PS_CLASS_SERVICE /*+ cc_boOssProductComponent.GetPromotions */'               ,,CHR(10),,
             ' WHERE pr_promotion.component_id = :inuComponent '                                                            ,,CHR(10),,
             '  AND pr_promotion.component_id = pr_component.component_id'                                                  ,,CHR(10),,
             '  AND pr_component.component_type_id = ps_component_type.component_type_id '                                  ,,CHR(10),,
             '  AND pr_component.class_service_id = ps_class_service.class_service_id (+) '                                 ,,CHR(10),,
             '  AND pr_promotion.asso_promotion_id = cc_promotion.promotion_id '                                            ,,CHR(10),,
             '  AND cc_promotion.product_type_id= servicio.servcodi ';

        OPEN OCUCURSOR FOR SBSQL USING INUCOMPONENT, INUCOMPONENT;

        UT_TRACE.TRACE('Fin de cc_boOssProductComponent.GetPromotions ', 5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    FUNCTION FNUGETCOMPONENTPARENT
    (
        INUCHILDCOMPID IN PR_COMPONENT.COMPONENT_ID%TYPE
    )
    RETURN NUMBER
    IS
        RCBUNDLED_COMP      DACC_BUNDLED_COMP.STYCC_BUNDLED_COMP := NULL;
        RCCOMP_LINK         DAPR_COMPONENT_LINK.STYPR_COMPONENT_LINK := NULL;
        TBCC_BUNDLED_COMP   DACC_BUNDLED_COMP.TYTBCC_BUNDLED_COMP;
    BEGIN

        RCBUNDLED_COMP := CC_BCBUNDLEDCOMP.FRCFIRSTBUNDLECOMP(INUCHILDCOMPID);
        
        OPEN PR_BCCOMPONENT_LINK.CUCOMPONENTLINKBYCHILD(INUCHILDCOMPID);
        FETCH PR_BCCOMPONENT_LINK.CUCOMPONENTLINKBYCHILD INTO RCCOMP_LINK;
        CLOSE PR_BCCOMPONENT_LINK.CUCOMPONENTLINKBYCHILD;
        
        IF (RCBUNDLED_COMP.COMPONENT_ID IS NOT NULL) THEN
            RETURN RCCOMP_LINK.PARENT_COMPONENT_ID;
        ELSE
            
            
            RCBUNDLED_COMP := CC_BCBUNDLEDCOMP.FRCGETFATHERBUNDLE(INUCHILDCOMPID);
            
            
            IF (RCBUNDLED_COMP.COMPONENT_ID IS NULL) THEN
                RETURN RCCOMP_LINK.PARENT_COMPONENT_ID;
            END IF;
            
            OPEN CC_BCBUNDLEDCOMP.CUBUNDLEDCOMP(RCBUNDLED_COMP.COMPONENT_ID);
            FETCH  CC_BCBUNDLEDCOMP.CUBUNDLEDCOMP BULK COLLECT INTO TBCC_BUNDLED_COMP;
            CLOSE CC_BCBUNDLEDCOMP.CUBUNDLEDCOMP;
            
            IF (TBCC_BUNDLED_COMP.COUNT > 0) THEN
                FOR IDX IN TBCC_BUNDLED_COMP.FIRST .. TBCC_BUNDLED_COMP.LAST LOOP
                    IF ( RCCOMP_LINK.PARENT_COMPONENT_ID = TBCC_BUNDLED_COMP(IDX).CHILD_COMPONENT_ID) THEN
                        RETURN RCCOMP_LINK.PARENT_COMPONENT_ID;
                    END IF;
                END LOOP;
            END IF;
        END IF;
        
        RETURN RCBUNDLED_COMP.COMPONENT_ID;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END;

BEGIN
    SBCOMPHINTSDEF          := NULL;
    SBCOMPONENTATTR         := NULL;
    SBCOMPONENTFROM         := NULL;
    SBCOMPONENTWHERE        := NULL;
    SBPACKAGESQL            := NULL;
    SBWARRANTYATTRIBUTES    := NULL;
    SBEQUIPMENTATTRIBUTES   := NULL;
    SBBUILDINGATTRIBUTES    := NULL;
    SBCHILDCOMPATT          := NULL;

END CC_BOOSSPRODUCTCOMPONENT;