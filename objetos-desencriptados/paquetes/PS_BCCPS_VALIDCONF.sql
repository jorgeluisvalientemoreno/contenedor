PACKAGE PS_BCCPS_VALIDCONF AS
    







































    
    CNUENTITYTITLE CONSTANT GE_ENTITY.NAME_%TYPE :=  'GI_TITLE_ATTRIBS';


    
    
    
    TYPE TYRCENTITIES IS RECORD
    (
        NUSECUENCE_     PS_CNF_ENTITY.SEQUENCE_%TYPE,
        NUENTITY        PS_CNF_ENTITY.ENTITY%TYPE
    );

    TYPE TYTBENTITIES  IS TABLE OF  TYRCENTITIES INDEX BY BINARY_INTEGER;
    TYPE TYREFCURSOR IS  REF CURSOR;
    TYPE TYTBCLASSCOMP IS TABLE OF PS_CLASS_SERVIC_COMP%ROWTYPE INDEX BY BINARY_INTEGER;


    
    
    
    CURSOR CUPRODENTITYTYPE
    (
        INUENTITYVALUE        IN      NUMBER,
        INUENTITYID           IN      NUMBER
    )IS
        SELECT  A.*, A.ROWID
        FROM    PS_PROD_ENTITY_TYPE A
        WHERE   A.ENTITY_ID = INUENTITYID
        AND     A.ENTITY_VALUE = INUENTITYVALUE;

    CURSOR CUEXECUTABLEANDADMINROLE
    (
        ISBSERVTXML        IN      SERVICIO.SERVTXML%TYPE
    )IS
        SELECT  A.*, A.ROWID
        FROM    SA_EXECUTABLE A
        WHERE   A.NAME = ISBSERVTXML
        AND     EXISTS (
            SELECT 'x' FROM SA_ROLE_EXECUTABLES B
            WHERE B.EXECUTABLE_ID = A.EXECUTABLE_ID
        );
        
    CURSOR CUCONFESCO
    (
        INUPRODUCTTYPE        IN      SERVICIO.SERVCODI%TYPE
    )IS
        SELECT  *
        FROM    CONFESCO
        WHERE   COECSERV = INUPRODUCTTYPE;

    CURSOR CUREFCOMPTYPE
    (
        INUPRODTYPEID        IN      SERVICIO.SERVCODI%TYPE
    )IS
          SELECT A.*, A.ROWID
            FROM PS_COMPONENT_TYPE A
           WHERE PRODUCT_TYPE_ID = INUPRODTYPEID;

    CURSOR CUPRODCOMPOSITION
    (
        INUPRODTYPEID        IN      SERVICIO.SERVCODI%TYPE
    )IS
          SELECT A.*, A.ROWID
            FROM PS_PROD_COMPOSITION A
           WHERE PRODUCT_TYPE_ID = INUPRODTYPEID
           AND   IS_MAIN='Y';

    CURSOR CUUNITTYPE
    (
        INUPRODTYPEID        IN      SERVICIO.SERVCODI%TYPE
    )IS
          SELECT A.*, A.ROWID
            FROM PS_PACKAGE_UNITTYPE A
           WHERE PRODUCT_TYPE_ID = INUPRODTYPEID;
           
    CURSOR CUWFATTRIBEQUIV
    (
        INUPRODTYPEID        IN      SERVICIO.SERVCODI%TYPE
    )IS
          SELECT A.*, A.ROWID
            FROM WF_ATTRIBUTES_EQUIV A
           WHERE VALUE_2 = INUPRODTYPEID;

    CURSOR CUCOMPOSITION
    (
        INUEXTERNALTYPE        IN      GI_COMPOSITION.EXTERNAL_TYPE_ID%TYPE,
        INUENTITYTYPE          IN      GI_COMPOSITION.ENTITY_TYPE_ID%TYPE
    )IS
          SELECT    A.*, A.ROWID
            FROM    GI_COMPOSITION A
           WHERE    A.EXTERNAL_TYPE_ID = INUEXTERNALTYPE
           AND      A.ENTITY_TYPE_ID = INUENTITYTYPE;

    CURSOR CUCNFMOTIVE
    (
        INUPRODUCTMOTIVE        IN      PS_CNF_MOTIVE.PRODUCT_MOTIVE%TYPE
    )IS
        SELECT  A.*, A.ROWID
        FROM    PS_CNF_MOTIVE A
        WHERE    A.PRODUCT_MOTIVE = INUPRODUCTMOTIVE;

    CURSOR CUCNFINSTANCE
    (
        INUOBJECT        IN      PS_CNF_INSTANCE.OBJECT_ID%TYPE,
        INUOBJECTTYPE          IN      PS_CNF_INSTANCE.OBJECT_TYPE%TYPE
    )IS
          SELECT    A.*, A.ROWID
            FROM    PS_CNF_INSTANCE A
           WHERE    A.OBJECT_ID = INUOBJECT
           AND      A.OBJECT_TYPE = INUOBJECTTYPE;
           
    CURSOR CUPRODMOTIATTRIB
    (
        INUPRODUCTMOTIVE IN PS_PRODUCT_MOTIVE.PRODUCT_MOTIVE_ID%TYPE
    )IS
        SELECT A.*, A.ROWID
        FROM PS_PROD_MOTI_ATTRIB A
        WHERE A.PRODUCT_MOTIVE_ID = INUPRODUCTMOTIVE;
        
    CURSOR CUCOMPATTRIBS
    (
        INUEXTERNAL        IN      GI_COMP_ATTRIBS.EXTERNAL_ID%TYPE,
        INUENTITY          IN      GI_COMP_ATTRIBS.ENTITY_ID%TYPE
    )IS
          SELECT    A.*, A.ROWID
            FROM    GI_COMP_ATTRIBS A
           WHERE    A.EXTERNAL_ID = INUEXTERNAL
           AND      A.ENTITY_ID = INUENTITY;

    CURSOR CUCOMPFRAMEATTRIB
    (
        INUCOMPATTRIBS IN GI_COMP_ATTRIBS.COMP_ATTRIBS_ID%TYPE
    )IS
        SELECT A.*, A.ROWID
        FROM GI_COMP_FRAME_ATTRIB A
        WHERE A.COMP_ATTRIBS_ID = INUCOMPATTRIBS;

    CURSOR CUCNFATTRIBUTE
    (
        INUOBJECT        IN      PS_CNF_ATTRIBUTE.OBJECT_ID%TYPE,
        INUOBJECTTYPE          IN      PS_CNF_ATTRIBUTE.OBJECT_TYPE%TYPE,
        INUATTRIBUTE     IN     PS_CNF_ATTRIBUTE.ATTRIBUTE_%TYPE
    )IS
          SELECT    A.*, A.ROWID
            FROM    PS_CNF_ATTRIBUTE A
           WHERE    A.OBJECT_ID = INUOBJECT
           AND      A.OBJECT_TYPE = INUOBJECTTYPE
           AND      A.ATTRIBUTE_ = INUATTRIBUTE;

    CURSOR CUPRODMOTIVECOMP
    (
        INUPRODUCTMOTIVE IN PS_PRODUCT_MOTIVE.PRODUCT_MOTIVE_ID%TYPE
    )IS
        SELECT A.*, A.ROWID
        FROM PS_PROD_MOTIVE_COMP A
        WHERE A.PRODUCT_MOTIVE_ID = INUPRODUCTMOTIVE;

    CURSOR CUMOTICOMPATTRIB
    (
        INUPRODMOTICOMP IN PS_MOTI_COMP_ATTRIBS.PROD_MOTIVE_COMP_ID%TYPE
    )IS
        SELECT A.*, A.ROWID
        FROM PS_MOTI_COMP_ATTRIBS A
        WHERE A.PROD_MOTIVE_COMP_ID = INUPRODMOTICOMP;

    CURSOR CUPACKAGEATTRIBS
    (
        INUPACKAGETYPE IN PS_PACKAGE_ATTRIBS.PACKAGE_TYPE_ID%TYPE
    )IS
        SELECT A.*, A.ROWID
        FROM PS_PACKAGE_ATTRIBS A
        WHERE A.PACKAGE_TYPE_ID = INUPACKAGETYPE;

    CURSOR CUCNFPACKAGE
    (
        INUPACKAGETYPE        IN      PS_CNF_PACKAGE.PACKAGE_TYPE%TYPE
    )IS
        SELECT  A.*, A.ROWID
        FROM    PS_CNF_PACKAGE A
        WHERE    A.PACKAGE_TYPE = INUPACKAGETYPE;

    CURSOR CUPRDMOTIVPACK
    (
        INUPACKAGETYPE        IN      PS_PRD_MOTIV_PACKAGE.PACKAGE_TYPE_ID%TYPE
    )IS
        SELECT  A.*, A.ROWID
        FROM    PS_PRD_MOTIV_PACKAGE A
        WHERE    A.PACKAGE_TYPE_ID = INUPACKAGETYPE;

    
    CURSOR CUCONFIG
    (
        INUPACKAGETYPE        IN      PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%TYPE
    )IS
        SELECT  CONFIG_ID
        FROM    GI_CONFIG
        WHERE   EXTERNAL_ROOT_ID = INUPACKAGETYPE
        AND     CONFIG_TYPE_ID=4
        AND     ENTITY_ROOT_ID=2012;

    CURSOR CUCOMPOSITIONBYCONFIG
    (
        INUCONFIG        IN      GI_CONFIG.CONFIG_ID%TYPE
    )IS
        SELECT  COMPOSITION_ID
        FROM    GI_COMPOSITION
        WHERE   CONFIG_ID = INUCONFIG;

    CURSOR CUFRAMEBYCOMPOSITION
    (
        INUCOMPOSITION        IN      GI_COMPOSITION.COMPOSITION_ID%TYPE
    )IS
        SELECT  FRAME_ID
        FROM    GI_FRAME
        WHERE   COMPOSITION_ID = INUCOMPOSITION;
    
    CURSOR CUTITLEATT
    (
        INUENTITY IN GE_ENTITY_ATTRIBUTES.ENTITY_ID%TYPE
    )IS
        SELECT  ENTITY_ATTRIBUTE_ID
        FROM    GE_ENTITY_ATTRIBUTES
        WHERE   ENTITY_ID=INUENTITY
        ORDER BY ENTITY_ATTRIBUTE_ID DESC;

    
    
    
    FUNCTION FSBVERSION  RETURN VARCHAR2;

    












    PROCEDURE GETCOMPBYCLASSSERV
    (
        INUPRODMOTIID   IN    PS_PROD_MOTIVE_COMP.PRODUCT_MOTIVE_ID%TYPE,
        OTYTBCOMPBYCLASSSERV     OUT NOCOPY   TYTBCLASSCOMP
    );
    
    
    FUNCTION FBOCOMPTYPEMULT
    (
        INUCOMPTYPE IN PS_PROD_MOTIVE_COMP.COMPONENT_TYPE_ID%TYPE
    )
    RETURN BOOLEAN;
    
    













    PROCEDURE GETINSTPRODMOT
    (
        INUPRODMOTIVE IN PS_CNF_INSTANCE.PRODUCT_MOTIVE%TYPE,
        OTBINSTANCES  OUT NOCOPY DAPS_CNF_INSTANCE.TYTBSEQUENCE_
    );
    
    














    PROCEDURE GETPACKMOTIINSTANCE
    (
        INUPRODMOTIVE    IN  PS_CNF_PACKAGE_MOTIVE.PRODUCT_MOTIVE%TYPE,
        ONUPACKMOTIINST  OUT PS_CNF_PACKAGE_MOTIVE.SEQUENCE_%TYPE
    );
    
    














    PROCEDURE GETENTITIESINSTANCE
    (
        INUPRODMOTIVE IN PS_CNF_ENTITY.PRODUCT_MOTIVE%TYPE,
        OTBENTITIES   OUT NOCOPY TYTBENTITIES
    );
    
    














    PROCEDURE GETATTRIBUTESINTANCE
    (
        INUPRODMOTIVE IN PS_CNF_ATTRIBUTE.PRODUCT_MOTIVE%TYPE,
        INUENTITYID   IN PS_CNF_ATTRIBUTE.ENTITY%TYPE,
        OTBATTRIBUTES OUT NOCOPY DAPS_CNF_ATTRIBUTE.TYTBSEQUENCE_
    );
    
END PS_BCCPS_VALIDCONF;