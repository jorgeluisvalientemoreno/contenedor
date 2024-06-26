PACKAGE pkMeasurementElementRequest IS




















































































        CNUFECHARETINV
        
        

         TYPE TYRCCOMPCHANGEMEASURE IS RECORD
	       (
            NUEMSSCMSS    ELMESESU.EMSSCMSS%TYPE,
            NUEMSSSESU    ELMESESU.EMSSSESU%TYPE,
            SBEMSSCOEMRE  ELMESESU.EMSSCOEM%TYPE,
            SBEMSSCOEMIN  ELMESESU.EMSSCOEM%TYPE,
            DTEMSSFEIN    ELMESESU.EMSSFEIN%TYPE,
            DTEMSSFERE    ELMESESU.EMSSFERE%TYPE,
            NUEMACEMRE    ELEMMEDI.ELMEEMAC%TYPE  
	       );

         TYPE TYTBCOMPCHANGEMEASURE IS TABLE OF TYRCCOMPCHANGEMEASURE INDEX BY BINARY_INTEGER;


    
    
    
       SBERRMSG            VARCHAR2(2000); 

    
    
    

    CNUFECHAINSTWRONG   CONSTANT MENSAJE.MENSCODI%TYPE := 4497;
    CNUMSGPORCEXCE      CONSTANT MENSAJE.MENSCODI%TYPE := 10023;
    CNUFECHARETNULA     CONSTANT MENSAJE.MENSCODI%TYPE := 10025;
    CNUNOHAYSESUPORELME CONSTANT MENSAJE.MENSCODI%TYPE := 10026;
    CNUPORCIGUAL        CONSTANT MENSAJE.MENSCODI%TYPE := 10027;
    CNUPERCENTCHFIX     CONSTANT MENSAJE.MENSCODI%TYPE := 10030;
    CNUPERCENTCHCON     CONSTANT MENSAJE.MENSCODI%TYPE := 10031;
    CNUFECHARETINV        CONSTANT MENSAJE.MENSCODI%TYPE := 10034;
    CNUFECHARETMAYORFECHAINST    CONSTANT MENSAJE.MENSCODI%TYPE := 10035;
    CNUELEMINSTIGUALELEMRETI    CONSTANT MENSAJE.MENSCODI%TYPE := 10036;
    CNUINVALIDDATE            CONSTANT MENSAJE.MENSCODI%TYPE := 11053;
    CNUINVALIDFINALDATE         CONSTANT MENSAJE.MENSCODI%TYPE := 11500;
    
       
    
    PROCEDURE CHANELEMMEASUSERVSUBS(
        INUEMSSELMER    IN ELMESESU.EMSSELME%TYPE,
        INUEMSSSESU     IN ELMESESU.EMSSSESU%TYPE,
        IDTEMSSFERE     IN ELMESESU.EMSSFERE%TYPE,
        INUEMSSELMEI    IN ELMESESU.EMSSELME%TYPE,
        IDTEMSSFEIN     IN ELMESESU.EMSSFEIN%TYPE,
        ONUERRORCODE   OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBMESSAGE     OUT GE_ERROR_LOG.DESCRIPTION%TYPE,
        INUELEM_EMAC    IN  ELMESESU.EMSSELME%TYPE DEFAULT NULL
                );

    
    
    
    
    PROCEDURE CHANELEMMEASUSERVSUBS
    (
        INUEMSSELMER    IN     ELMESESU.EMSSELME%TYPE,
        INUEMSSSESU     IN     ELMESESU.EMSSSESU%TYPE,
        IDTEMSSFERE     IN     ELMESESU.EMSSFERE%TYPE,
        INUEMSSELMEI    IN     ELMESESU.EMSSELME%TYPE,
        IDTEMSSFEIN     IN     ELMESESU.EMSSFEIN%TYPE,
        INUELEM_EMAC    IN      ELMESESU.EMSSELME%TYPE,
        INUOLDLEEMLETO    IN    LECTELME.LEEMLETO%TYPE,
        IDTOLDLEEMFELE    IN    LECTELME.LEEMFELE%TYPE,
        ISBOLDLEEMCLEC    IN    LECTELME.LEEMCLEC%TYPE,
        INUOLDLEEMTCON    IN    LECTELME.LEEMTCON%TYPE,
        INUOLDLEEMFAME    IN    LECTELME.LEEMFAME%TYPE,
        INUNEWLEEMLETO    IN    LECTELME.LEEMLETO%TYPE,
        IDTNEWLEEMFELE    IN    LECTELME.LEEMFELE%TYPE,
        ISBNEWLEEMCLEC    IN    LECTELME.LEEMCLEC%TYPE,
        INUNEWLEEMTCON    IN    LECTELME.LEEMTCON%TYPE,
        INUNEWLEEMFAME    IN    LECTELME.LEEMFAME%TYPE,
        ONUERRORCODE   OUT     GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBMESSAGE     OUT     GE_ERROR_LOG.DESCRIPTION%TYPE
        );

    
    
    
    PROCEDURE REGISELEMMEASUSERVSUBS(
                INUEMSSELME     IN  ELMESESU.EMSSELME%TYPE,
                INUEMSSESU      IN  ELMESESU.EMSSSESU%TYPE,
                INUCOMPONENT    IN  ELMESESU.EMSSCMSS%TYPE,
                IDTEMSSFEIN     IN  ELMESESU.EMSSFEIN%TYPE,
                ONUERRORCODE    OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE,
                INUELEM_EMAC    IN  ELMESESU.EMSSELME%TYPE,
                INUSSSPR        IN ELMESESU.EMSSSSPR%TYPE DEFAULT NULL
    );

    
    
    
    PROCEDURE RETELEMMEASUSERVSUBS
    (
        INUEMSSELMER        IN  ELMESESU.EMSSELME%TYPE,
        INUEMSSSESU         IN  ELMESESU.EMSSSESU%TYPE,
        IDTEMSSFERE         IN  ELMESESU.EMSSFERE%TYPE,
        ONUERRORCODE        OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBERRORMESSAGE     OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    );

    PROCEDURE UPADITIONALDATA
    (
        INUEMSSELMER    IN ELMESESU.EMSSELME%TYPE,
        INUEMSSSESU     IN ELMESESU.EMSSSESU%TYPE,
        ISBADITINALDATA IN COMPSESU.CMSSDAAD%TYPE,
        ISBUSERCODE     IN COMPSESU.CMSSCOUC%TYPE
    );

    PROCEDURE CHANELEMMEASUBYWRONGREG(ITBCOMPCHANGEMEASURE IN OUT TYTBCOMPCHANGEMEASURE);
    
    
    FUNCTION FSBVERSION  RETURN VARCHAR2;

END PKMEASUREMENTELEMENTREQUEST;