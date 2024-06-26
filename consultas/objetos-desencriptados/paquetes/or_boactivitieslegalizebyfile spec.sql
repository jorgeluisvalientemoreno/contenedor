PACKAGE OR_BOActivitiesLegalizeByFile
IS


























































































































































































































































	
    SUBTYPE STYSBCODE IS VARCHAR2(50); 

    TYPE TYRCELEMENTPRODUCTID IS RECORD
    (
        NUPRODUCT_ID        PR_PRODUCT.PRODUCT_ID%TYPE
    );

    TYPE TYTBELEMENTPRODUCTID  IS TABLE OF TYRCELEMENTPRODUCTID INDEX BY STYSBCODE;
    
    
    SUBTYPE STYSIZELINE           IS         VARCHAR2(32000);

    
    
    CNUMAXLENGTHTOLEG CONSTANT  NUMBER:=32000;

	

	
	FUNCTION FSBVERSION  RETURN VARCHAR2;

    


 	
    PROCEDURE LEGALIZEFROMFILE
    (
        ISBDIRECTORY         IN VARCHAR2,
        ISBFILENAME          IN VARCHAR2,
        IDTINITEXTDATE       IN DATE,
        IDTFINALEXTDATE      IN DATE,
        INUOPERATINGUNIT     IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE
    );
    
    




    PROCEDURE UPDATTRIBUTEACTIVITY
    (
        INUORDERID          IN  OR_ORDER.ORDER_ID%TYPE,
        INUORDERACTIVITYID  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUACTIVITYID       IN  OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE,
        ISBATTRIBUESDATA    IN  VARCHAR2,
        INUATTIBUTEINDEX    IN  INTEGER,
        IOTBELEMPRODUCT     IN  OUT TYTBELEMENTPRODUCTID
    );

    


















    PROCEDURE INSTANCEATTRIBSACTIVITY
    (
        INUORDERID        IN  OR_ORDER.ORDER_ID%TYPE,
        INUORDERACTIVITYID  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE
    );

    


    PROCEDURE LEGALIZEORDERBYLINE
    (
        INUORDERID      IN  OR_ORDER.ORDER_ID%TYPE,
        INUPERSON       IN  GE_PERSON.PERSON_ID%TYPE,
        INUCAUSALID     IN  OR_ORDER.CAUSAL_ID%TYPE,
        INUOPERUNITID   IN  OR_ORDER.OPERATING_UNIT_ID%TYPE,
        IDTEXEINIDATE   IN  OR_ORDER.EXEC_INITIAL_DATE%TYPE,
        IDTEXEFINDATE   IN  OR_ORDER.EXECUTION_FINAL_DATE%TYPE,
        ITBLINE         IN  UT_STRING.TYTB_STRING,
        ONUERRORCODE    OUT NUMBER,
        OSBERRORMESSAGE OUT VARCHAR2,
        IDTCHANGEDATE   IN OR_ORDER_STAT_CHANGE.STAT_CHG_DATE%TYPE DEFAULT NULL
    );
    
    




    PROCEDURE PROCESSREADDATA
    (
        ISBEQUIPMENTREADS   IN  VARCHAR2,
        INUPOSITION         IN  NUMBER
    );
    
    




    PROCEDURE PROCESSREADBYLINE
    (
        ISBALLREADS   IN  VARCHAR2
    );
    
    




    PROCEDURE ASSOCIATESEALCOMP
    (
        INUORDERID         IN   OR_ORDER.ORDER_ID%TYPE,
        ISBATTRIBUTE       IN   GE_ATTRIBUTES.NAME_ATTRIBUTE%TYPE,
        INUORDERACTIVITYID IN   OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        ISBCOMPONENTDATA   IN   VARCHAR2,
        INUATTIBUTEINDEX   IN   NUMBER,
        INUCOMPONENTID     IN   NUMBER,
        ISBVALUE           IN   VARCHAR2
    );
    

    






    PROCEDURE VALASSOSEALCOMP
    (
        ISBSERIE            IN  GE_ITEMS_SERIADO.SERIE%TYPE,
        INUORDERACTIVITYID  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        ISBISTOASSOC        IN  VARCHAR2,
        ORCSERIALITEM       OUT DAGE_ITEMS_SERIADO.STYGE_ITEMS_SERIADO
    );
    
    




    PROCEDURE LOADANDVALIDINITIALDATA
    (
        ISBLINE          IN VARCHAR2,
        INULINENUMBER    IN NUMBER,
        ONUORDERID      OUT OR_ORDER.ORDER_ID%TYPE,
        ONUCAUSAL       OUT OR_ORDER.CAUSAL_ID%TYPE,
        ONUPERSON       OUT GE_PERSON.PERSON_ID%TYPE,
        OTBLINE         OUT NOCOPY UT_STRING.TYTB_STRING,
        ONUERRORCODE    OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    );
    
    





    PROCEDURE LEGALIZEORDERADM
    (
        INUORDERID      IN  OR_ORDER.ORDER_ID%TYPE,
        INUCAUSALID     IN  OR_ORDER.CAUSAL_ID%TYPE,
        ISBCOMENTALL    IN  VARCHAR2,
        ONUERRORCODE    OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    );
    
    




    PROCEDURE VALIDINITDATATOLEGALBYFILE
    (
        ISBDATAORDER        IN  VARCHAR2,
        IDTINITDATE         IN  OR_ORDER.EXEC_INITIAL_DATE%TYPE,
        IDTFINALDATE        IN  OR_ORDER.EXECUTION_FINAL_DATE%TYPE,
        OSBISADMINORDER     OUT VARCHAR2,
        ONUORDERID          OUT OR_ORDER.ORDER_ID%TYPE,
        ONUPERSONID         OUT GE_PERSON.PERSON_ID%TYPE,
        ONUCAUSALID         OUT OR_ORDER.CAUSAL_ID%TYPE,
        ONUOPERUNITID       OUT OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        OTBLINE             OUT UT_STRING.TYTB_STRING,
        ONUERRORCODE        OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBERRORMESSAGE     OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    );
    

    




    FUNCTION   FBLGETISLEGALBYFILE
    RETURN BOOLEAN;

    




    PROCEDURE SETORDERUSEDCAPACITY
    (
        INUUSEDCAPACITY IN  NUMBER
    );

END OR_BOACTIVITIESLEGALIZEBYFILE;