PACKAGE BODY pkMeasurementElementRequest AS

























































































    
    
    CSBVERSION      CONSTANT VARCHAR2(250) := 'SAO382956';

    
    
    
    NUIDX          NUMBER(10) := 0;    
    NUSERVSUSC       ELMESESU.EMSSSESU%TYPE;
    NUCOMPONENT ELMESESU.EMSSCMSS%TYPE;
    CNURECORD_NO_EXISTE_EMAC CONSTANT  NUMBER := 10053;
    CNUNO_EXISTEN_MED        CONSTANT  NUMBER := 10954;
    
    TYPE TYRCLECTELME IS RECORD
	(
        ELMECODI    ELEMMEDI.ELMECODI%TYPE,
        LEEMLETO    LECTELME.LEEMLETO%TYPE,
        LEEMTCON    LECTELME.LEEMTCON%TYPE,
        LEEMCANL    LECTELME.LEEMCLEC%TYPE, 
        LEEMOBLE    LECTELME.LEEMOBLE%TYPE  
	);

    TYPE TYTBLECTELME IS TABLE OF TYRCLECTELME INDEX BY BINARY_INTEGER;
    
    
    
    
    
    CURSOR CUELMESESU (NUELEMID IN ELMESESU.EMSSELME%TYPE)
    IS
        SELECT  EMSSSESU
        FROM    ELMESESU
        WHERE   EMSSELME = NUELEMID
        AND     EMSSFEIN <= SYSDATE             
        AND     EMSSFERE > SYSDATE;

    
    
    
    
    
    
    
    PROCEDURE CHANGEMEASREADING
    (

        INUEMSSELMER    IN     ELMESESU.EMSSELME%TYPE,
        INUEMSSSESU     IN     ELMESESU.EMSSSESU%TYPE,
        IDTEMSSFERE     IN     ELMESESU.EMSSFERE%TYPE,
        INUEMSSELMEI    IN     ELMESESU.EMSSELME%TYPE,
        IDTEMSSFEIN     IN     ELMESESU.EMSSFEIN%TYPE,
        INUOLDLEEMLETO  IN     LECTELME.LEEMLETO%TYPE,
        IDTOLDLEEMFELE  IN     LECTELME.LEEMFELE%TYPE,
        ISBOLDLEEMCLEC  IN     LECTELME.LEEMCLEC%TYPE,
        INUOLDLEEMTCON  IN     LECTELME.LEEMTCON%TYPE,
        INUOLDLEEMFAME  IN     LECTELME.LEEMFAME%TYPE,
        INUNEWLEEMLETO  IN     LECTELME.LEEMLETO%TYPE,
        IDTNEWLEEMFELE  IN     LECTELME.LEEMFELE%TYPE,
        ISBNEWLEEMCLEC  IN     LECTELME.LEEMCLEC%TYPE,
        INUNEWLEEMTCON  IN     LECTELME.LEEMTCON%TYPE,
        INUNEWLEEMFAME  IN     LECTELME.LEEMFAME%TYPE,
        ONUERRORCODE   OUT     GE_ERROR_LOG.ERROR_LOG_ID%TYPE,

        OSBMESSAGE     OUT     GE_ERROR_LOG.DESCRIPTION%TYPE
    );














































    PROCEDURE CHANGEMEASREADING
    (
        INUEMSSELMER    IN     ELMESESU.EMSSELME%TYPE,
        INUEMSSSESU     IN     ELMESESU.EMSSSESU%TYPE,
        IDTEMSSFERE     IN     ELMESESU.EMSSFERE%TYPE,
        INUEMSSELMEI    IN     ELMESESU.EMSSELME%TYPE,
        IDTEMSSFEIN     IN     ELMESESU.EMSSFEIN%TYPE,
        INUOLDLEEMLETO  IN     LECTELME.LEEMLETO%TYPE,
        IDTOLDLEEMFELE  IN     LECTELME.LEEMFELE%TYPE,
        ISBOLDLEEMCLEC  IN     LECTELME.LEEMCLEC%TYPE,
        INUOLDLEEMTCON  IN     LECTELME.LEEMTCON%TYPE,
        INUOLDLEEMFAME  IN     LECTELME.LEEMFAME%TYPE,
        INUNEWLEEMLETO  IN     LECTELME.LEEMLETO%TYPE,
        IDTNEWLEEMFELE  IN     LECTELME.LEEMFELE%TYPE,
        ISBNEWLEEMCLEC  IN     LECTELME.LEEMCLEC%TYPE,
        INUNEWLEEMTCON  IN     LECTELME.LEEMTCON%TYPE,
        INUNEWLEEMFAME  IN     LECTELME.LEEMFAME%TYPE,
        ONUERRORCODE   OUT     GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBMESSAGE     OUT     GE_ERROR_LOG.DESCRIPTION%TYPE
    ) IS

        NULEEMPEFA          LECTELME.LEEMPEFA%TYPE;
        SBLEEMCLEC          LECTELME.LEEMCLEC%TYPE;
        NUSESUSUSC          SERVSUSC.SESUSUSC%TYPE;
        SBCODIGOELEMMEDI    ELMESESU.EMSSCOEM%TYPE;
        SBACTIVEOSS         PARAMETR.PAMECHAR%TYPE;
        BOACTIVEOSS         BOOLEAN;

    BEGIN
    
        PKERRORS.PUSH('pkMeasurementElementRequest.ChangeMeasReading');

        ONUERRORCODE := PKCONSTANTE.EXITO;
        OSBMESSAGE := NULL;
        NUSESUSUSC := PKTBLSERVSUSC.FNUGETSUSCRIPTION(INUEMSSSESU);
        PKSUBSCRIBERMGR.ACCCURRENTPERIOD(NUSESUSUSC,NULEEMPEFA);

        
        SBACTIVEOSS := PKGENERALPARAMETERSMGR.FSBGETSTRINGVALUE ('EXIST_OSS');
        BOACTIVEOSS := (SBACTIVEOSS = PKCONSTANTE.SI);

        
        
        
        

        IF (NOT BOACTIVEOSS) THEN
        
            
            
            
            
            
            
            
            IF (IDTOLDLEEMFELE > IDTEMSSFERE) THEN
            
                PKERRORS.SETERRORCODE
                (
                    PKCONSTANTE.CSBDIVISION ,
                    PKCONSTANTE.CSBMOD_CUS,
                    CNUINVALIDFINALDATE
                );
                RAISE LOGIN_DENIED;
            
            END IF;

            SBLEEMCLEC := ISBOLDLEEMCLEC;

            IF (ISBOLDLEEMCLEC IS NULL) THEN
                SBLEEMCLEC := CM_BOCONSTANTS.CSBCAUS_LECT_RETI;
            END IF;

            
            
            
            SBCODIGOELEMMEDI := PKTBLELEMMEDI.FSBGETMEASELEMCODE (INUEMSSELMER);

            PKMEASELEMREADINGSMGR.INSREADWITHOUTVALID
            (
                SBCODIGOELEMMEDI,
                INUOLDLEEMLETO,
                IDTOLDLEEMFELE,
                SBLEEMCLEC,
                INUOLDLEEMTCON
            );
        
        END IF; 

        
        
        
        
        IF ( IDTNEWLEEMFELE < IDTEMSSFEIN ) THEN
        
            PKERRORS.SETERRORCODE
            (
                PKCONSTANTE.CSBDIVISION ,
                PKCONSTANTE.CSBMOD_CUS,
                CNUINVALIDDATE
            );
            RAISE LOGIN_DENIED;
        
        END IF;

        SBLEEMCLEC := ISBNEWLEEMCLEC;

        IF (ISBNEWLEEMCLEC IS NULL) THEN
            SBLEEMCLEC := CM_BOCONSTANTS.CSBCAUS_LECT_INST;
        END IF;

        
        
        
        SBCODIGOELEMMEDI := PKTBLELEMMEDI.FSBGETMEASELEMCODE (INUEMSSELMEI);

        PKMEASELEMREADINGSMGR.INSREADWITHOUTVALID
        (
                SBCODIGOELEMMEDI,
                INUNEWLEEMLETO,
                IDTNEWLEEMFELE,
                SBLEEMCLEC,
                INUNEWLEEMTCON
        );

        PKERRORS.POP;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR (PKERRORS.FSBLASTOBJECT,SQLERRM,SBERRMSG);
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR (PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    
    END CHANGEMEASREADING;










































































PROCEDURE CHANELEMMEASUSERVSUBS
(
    INUEMSSELMER IN  ELMESESU.EMSSELME%TYPE        ,
    INUEMSSSESU  IN  ELMESESU.EMSSSESU%TYPE        ,
    IDTEMSSFERE  IN  ELMESESU.EMSSFERE%TYPE        ,
    INUEMSSELMEI IN  ELMESESU.EMSSELME%TYPE        ,
    IDTEMSSFEIN  IN  ELMESESU.EMSSFEIN%TYPE        ,
    ONUERRORCODE OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
    OSBMESSAGE   OUT GE_ERROR_LOG.DESCRIPTION%TYPE ,
    INUELEM_EMAC IN  ELMESESU.EMSSELME%TYPE DEFAULT NULL
)
IS
    
    
    
    PROCEDURE INITIALIZE IS
    BEGIN
        
        PKERRORS.INITIALIZE;
        ONUERRORCODE    := PKCONSTANTE.EXITO;
        OSBMESSAGE := NULL;
    END INITIALIZE;
    
    PROCEDURE VALINPUTDATA IS
    BEGIN
        PKERRORS.PUSH(
        'pkMeasurementElementRequest.ChanElemMeasuServSubs.ValInputData');
        
        IF ( IDTEMSSFERE > IDTEMSSFEIN ) THEN
            PKERRORS.SETERRORCODE(PKCONSTANTE.CSBDIVISION,
                      PKCONSTANTE.CSBMOD_EME,
                          CNUFECHARETMAYORFECHAINST);
            RAISE LOGIN_DENIED;
        END IF;

        
        
        IF ( INUEMSSELMER = INUEMSSELMEI ) THEN
            PKERRORS.SETERRORCODE(  PKCONSTANTE.CSBDIVISION,
                        PKCONSTANTE.CSBMOD_EME,
                        CNUELEMINSTIGUALELEMRETI );
            RAISE LOGIN_DENIED;
        END IF;
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT,SQLERRM,SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    END;

    
    PROCEDURE CHANGEELEMMEAS
    IS
        
        
        
        RCELEMSESURET   ELMESESU%ROWTYPE;

         
        NUELMEEMAC      ELEMMEDI.ELMEEMAC%TYPE;
    BEGIN
        PKERRORS.PUSH('pkMeasurementElementRequest.ChanElemMeasuServSubs.ChangeElemMeas');

        
        RCELEMSESURET := PKBCELMESESU.FRCRECORDBYSUSBSERVMEASELEM(
                                                                    INUEMSSELMER,
                                                                    INUEMSSSESU
                                                                 );

        
        
        
        NUELMEEMAC := PKTBLELEMMEDI.FRCGETRECORD(INUEMSSELMER).ELMEEMAC;
        
        
        NUCOMPONENT := PKMEASELEMSUBSSERVMGR.FNUGETCOMPONENTBYELEM
                        (
                            INUEMSSELMER,
                            INUEMSSSESU
                        );

        
        PKMEASUREMENTELEMENTREQUEST.RETELEMMEASUSERVSUBS
        (
            INUEMSSELMER,
            INUEMSSSESU,
            IDTEMSSFERE,
            ONUERRORCODE,
            OSBMESSAGE
        );

        IF ( ONUERRORCODE <> PKCONSTANTE.EXITO ) THEN
            RAISE LOGIN_DENIED;
        END IF;

        PKMEASUREMENTELEMENTREQUEST.REGISELEMMEASUSERVSUBS
        (
            INUEMSSELMEI,
            INUEMSSSESU,
            NUCOMPONENT,
            IDTEMSSFEIN,
            ONUERRORCODE,
            OSBMESSAGE,
            INUELEM_EMAC,
            RCELEMSESURET.EMSSSSPR
        );
        IF ( ONUERRORCODE <> PKCONSTANTE.EXITO ) THEN
            RAISE LOGIN_DENIED;
        END IF;

        
        
        
        
        PKMEASUREMENTELEMENMGR.ACTMEDIDORAREACOMUN
        (
            INUEMSSELMER,   
            INUEMSSELMEI,   
            NUELMEEMAC      
        );

        PKERRORS.POP;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT,SQLERRM,SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    END CHANGEELEMMEAS;

BEGIN

    PKERRORS.PUSH('pkMeasurementElementRequest.ChanElemMeasuServSubs');

    
    INITIALIZE;

    
    VALINPUTDATA;

    
    CHANGEELEMMEAS;


    PKERRORS.POP;

EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        PKERRORS.GETERRORVAR( ONUERRORCODE,OSBMESSAGE );

    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
        PKERRORS.GETERRORVAR( ONUERRORCODE, OSBMESSAGE );
END  CHANELEMMEASUSERVSUBS;


















































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
    ) IS
    BEGIN
        PKERRORS.PUSH('pkMeasurementElementRequest.ChanElemMeasuServSubs');
        

        DBMS_OUTPUT.PUT_LINE('pkMeasurementElementRequest.ChanElemMeasuServSubs.UpdateCommonAreaMeas');
        DBMS_OUTPUT.PUT_LINE('EMAC '||INUELEM_EMAC);

        CHANELEMMEASUSERVSUBS
            (
                INUEMSSELMER    ,
                INUEMSSSESU     ,
                IDTEMSSFERE     ,
                INUEMSSELMEI    ,
                IDTEMSSFEIN     ,
                ONUERRORCODE       ,
                OSBMESSAGE,
                INUELEM_EMAC
            );
            
        DBMS_OUTPUT.PUT_LINE('que putas pasa');
        IF ( ONUERRORCODE <> PKCONSTANTE.EXITO ) THEN
        RAISE LOGIN_DENIED;
        END IF;
        
        
        
        
        CHANGEMEASREADING
            (
                INUEMSSELMER    ,
                INUEMSSSESU     ,
                IDTEMSSFERE     ,
                INUEMSSELMEI    ,
                IDTEMSSFEIN     ,
                INUOLDLEEMLETO    ,
                IDTOLDLEEMFELE    ,
                ISBOLDLEEMCLEC    ,
                INUOLDLEEMTCON    ,
                INUOLDLEEMFAME    ,
                INUNEWLEEMLETO    ,
                IDTNEWLEEMFELE    ,
                ISBNEWLEEMCLEC    ,
                INUNEWLEEMTCON    ,
                INUNEWLEEMFAME    ,
                ONUERRORCODE    ,
                OSBMESSAGE
            ) ;

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        PKERRORS.GETERRORVAR( ONUERRORCODE,OSBMESSAGE );
        WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
        PKERRORS.GETERRORVAR( ONUERRORCODE,
                      OSBMESSAGE );
    END  CHANELEMMEASUSERVSUBS;































































    PROCEDURE REGISELEMMEASUSERVSUBS(
        INUEMSSELME     IN  ELMESESU.EMSSELME%TYPE,
        INUEMSSESU      IN  ELMESESU.EMSSSESU%TYPE,
        INUCOMPONENT    IN  ELMESESU.EMSSCMSS%TYPE,
        IDTEMSSFEIN     IN  ELMESESU.EMSSFEIN%TYPE,
        ONUERRORCODE    OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE,
        INUELEM_EMAC    IN  ELMESESU.EMSSELME%TYPE,
        INUSSSPR        IN ELMESESU.EMSSSSPR%TYPE DEFAULT NULL
    )
    IS
        
        
        
        NUSTATUS_COMP   COMPSESU.CMSSESCM%TYPE := NULL; 
                              
        NUSERVICIO      SERVSUSC.SESUSERV%TYPE := NULL;   
                              
        NUELEM_EMAC     ELMESESU.EMSSELME%TYPE;
        
        
        
        
        PROCEDURE CLEARMEMORY IS
        BEGIN
            PKERRORS.PUSH(
                'pkMeasurementElementRequest.RegisElemMeasuServSubs.ClearMemory');
            
            
            PKTBLELEMMEDI.CLEARMEMORY;
            
            PKTBLCOMPSESU.CLEARMEMORY;
            
            PKTBLSERVSUSC.CLEARMEMORY;
            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
                PKERRORS.POP;
                RAISE;
            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT,SQLERRM,SBERRMSG );
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
        END CLEARMEMORY;
        
        PROCEDURE INITIALIZE IS
        BEGIN
            
            PKERRORS.INITIALIZE;
            ONUERRORCODE    := PKCONSTANTE.EXITO;
            OSBERRORMESSAGE := NULL;
        END INITIALIZE;
        
        PROCEDURE GETPARAMETERS
        IS
        BEGIN
            NUSTATUS_COMP := PKGENERALPARAMETERSMGR.FNUGETNUMBERVALUE(
                            'BIL_DEFAULT_STATUS_COMP');
        END;
       
        PROCEDURE VALDEPENDENTMEASELEMENT
        (
            INUELEM_EMAC    IN  ELEMMEDI.ELMEIDEM%TYPE
        ) IS
        BEGIN
            PKERRORS.PUSH('pkChangeMeasuElement.ValInputData.ValDependentMeasElement');

            IF (INUELEM_EMAC IS NULL) THEN
                PKERRORS.POP;
                RETURN;
            END IF;

            BEGIN

                PKTBLELEMMEDI.ACCKEY ( INUELEM_EMAC );
            EXCEPTION
                WHEN LOGIN_DENIED THEN
                       PKERRORS.SETERRORCODE (
                            PKCONSTANTE.CSBDIVISION,
                            PKCONSTANTE.CSBMOD_EME,
                                                CNURECORD_NO_EXISTE_EMAC
                          );
                    RAISE LOGIN_DENIED;
            END;

            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR  PKCONSTANTE.EXERROR_LEVEL2 THEN
                PKERRORS.POP;
                RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
        END VALDEPENDENTMEASELEMENT;
       
        PROCEDURE VALINPUTDATA
        IS
        BEGIN
            PKERRORS.PUSH(
                'pkMeasurementElementRequest.RegisElemMeasuServSubs.ValInputData');
            
            PKMEASELEMSUBSSERVMGR.VALNULLINSTALLDATE( IDTEMSSFEIN ) ;
            
            PKMEASELEMSUBSSERVMGR.VALINSTALLDATELESSCURR( IDTEMSSFEIN );
            PKGENERALSERVICES.VALDATEY2K( IDTEMSSFEIN );
            
            PKMEASUREMENTELEMENMGR.VALBASICDATA(INUEMSSELME);
            
            PKSERVNUMBERMGR.VALBASICDATA(INUEMSSESU);
            
            PKSERVNUMBERMGR.VALISBILLABLESERVNUMBER(INUEMSSESU);
            
            NUSERVICIO := PKTBLSERVSUSC.FNUGETSERVICE( INUEMSSESU );
            
            
            IF ( NOT PKMEASELEMSUBSSERVMGR.FBLEXISTASSOACTIVEBYSERVICE
                                                        (INUEMSSELME,
                             NUSERVICIO ))THEN
                PKERRORS.POP;
                RETURN;
            END IF;
            
            
            PKMEASELEMSUBSSERVMGR.VALDUPSUBSSERVBYMEEL( INUEMSSELME,
                                    INUEMSSESU,
                                    PKCONSTANTE.NOCACHE );

                
                VALDEPENDENTMEASELEMENT (INUELEM_EMAC);

            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
                PKERRORS.POP;
                RAISE LOGIN_DENIED;
            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT,SQLERRM,SBERRMSG );
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
        END VALINPUTDATA;
       
        PROCEDURE INSELMESESU
        IS
                DTEMSSFERE      ELMESESU.EMSSFERE%TYPE;
                DTFECHAACT        DATE;
                SBEMSSCOEM      ELMESESU.EMSSCOEM%TYPE;
            BEGIN
            PKERRORS.PUSH('pkMeasurementElementRequest.RegisElemMeasuServSubs.InsElmeSeSu');
            
            SBEMSSCOEM := PKTBLELEMMEDI.FSBGETMEASELEMCODE( INUEMSSELME );

            
            PKMEASELEMSUBSSERVMGR.GENMEASELEMCOMPBASIC
                                        (
                                                INUEMSSELME, SBEMSSCOEM,
                                                IDTEMSSFEIN, INUCOMPONENT,
                                                NULL, INUSSSPR
                                        );
            
            
            
            
            
            DTFECHAACT := PKTBLSERVSUSC.FDTGETINSTALLATIONDATE( INUEMSSESU );
            IF ( DTFECHAACT IS NULL OR DTFECHAACT = DTEMSSFERE ) THEN
                 PKTBLSERVSUSC.UPINSTALLATIONDATE( INUEMSSESU, IDTEMSSFEIN );
            END IF;

                
                
                PKMEASUREMENTELEMENMGR.UPDATEDEPENDENTCOMMONAREA (
                                                                   INUEMSSELME,
                                                                   INUELEM_EMAC
                                                                 );

            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
                PKERRORS.POP;
                RAISE LOGIN_DENIED;
            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT,SQLERRM,SBERRMSG );
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
        END INSELMESESU;

        
        
        
    BEGIN
        PKERRORS.PUSH('pkMeasurementElementRequest.RegisElemMeasuServSubs');
        
        INITIALIZE;
        
        CLEARMEMORY;
        
        GETPARAMETERS;
        
        VALINPUTDATA;
        
        INSELMESESU;
        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
           PKERRORS.GETERRORVAR( ONUERRORCODE,OSBERRORMESSAGE );
        WHEN OTHERS THEN
           PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
           PKERRORS.POP;
           PKERRORS.GETERRORVAR( ONUERRORCODE,OSBERRORMESSAGE );
    END REGISELEMMEASUSERVSUBS;



















































    PROCEDURE RETELEMMEASUSERVSUBS
    (
        INUEMSSELMER    IN  ELMESESU.EMSSELME%TYPE,
        INUEMSSSESU     IN  ELMESESU.EMSSSESU%TYPE,
        IDTEMSSFERE     IN  ELMESESU.EMSSFERE%TYPE,
        ONUERRORCODE    OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS
        
        
        
        PROCEDURE CLEARMEMORY IS
        BEGIN
            PKERRORS.PUSH('pkMeasurementElementRequest.RetElemMeasuServSubs.ClearMemory');
            
            
            PKTBLELEMMEDI.CLEARMEMORY;
            
            PKTBLSERVSUSC.CLEARMEMORY;
            PKERRORS.POP;
        EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
        END CLEARMEMORY;
        
        PROCEDURE INITIALIZE IS
        BEGIN
            
            PKERRORS.INITIALIZE;
            ONUERRORCODE    := PKCONSTANTE.EXITO;
            OSBERRORMESSAGE := NULL;
        END INITIALIZE;
        
        PROCEDURE VALINPUTDATA
        IS
        BEGIN
            PKERRORS.PUSH('pkMeasurementElementRequest.RetElemMeasuServSubs.ValInputData');
            
            
            PKSERVNUMBERMGR.VALBASICDATA(INUEMSSSESU);
            
            PKMEASUREMENTELEMENMGR.VALBASICDATA(INUEMSSELMER);
            
            
            PKMEASELEMSUBSSERVMGR.VALEXISUBSSERVBYMEEL(INUEMSSELMER,INUEMSSSESU);
            
            IF ( IDTEMSSFERE IS NULL ) THEN
                PKERRORS.SETERRORCODE(PKCONSTANTE.CSBDIVISION,
                          PKCONSTANTE.CSBMOD_EME,
                          CNUFECHARETNULA);
                RAISE LOGIN_DENIED;
            END IF;
            IF ( IDTEMSSFERE > SYSDATE ) THEN
                PKERRORS.SETERRORCODE(PKCONSTANTE.CSBDIVISION,
                          PKCONSTANTE.CSBMOD_GRL,
                          CNUFECHARETINV);
                RAISE LOGIN_DENIED;
            END IF;
            
            PKGENERALSERVICES.VALDATEY2K( IDTEMSSFERE);
            PKERRORS.POP;
        EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
        END VALINPUTDATA;
        
        PROCEDURE RETELEMMEAS
        IS
        BEGIN
            PKERRORS.PUSH('pkMeasurementElementRequest.RetElemMeasuServSubs.RetElemMeas');
            
            
            
            
            PKMEASELEMSUBSSERVMGR.UPDATEWITHDRAWALDATE( INUEMSSELMER,
                                    INUEMSSSESU,
                                    IDTEMSSFERE );

                
                
                PKMEASUREMENTELEMENMGR.UPDATEDEPENDENTCOMMONAREA (
                                                                   INUEMSSELMER,
                                                                   NULL
                                                                 );

            PKERRORS.POP;
        EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
        END RETELEMMEAS;
        
        
        
    BEGIN
        PKERRORS.PUSH('pkMeasurementElementRequest.RetElemMeasuServSubs');
        
        INITIALIZE;
        
        CLEARMEMORY;
        
        VALINPUTDATA;
        
        RETELEMMEAS;
        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            PKERRORS.GETERRORVAR( ONUERRORCODE,OSBERRORMESSAGE );
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.POP;
            PKERRORS.GETERRORVAR( ONUERRORCODE,
                          OSBERRORMESSAGE );
    END  RETELEMMEASUSERVSUBS;























    PROCEDURE UPADITIONALDATA
    (
        INUEMSSELMER    IN ELMESESU.EMSSELME%TYPE,
        INUEMSSSESU     IN ELMESESU.EMSSSESU%TYPE,
        ISBADITINALDATA IN COMPSESU.CMSSDAAD%TYPE,
        ISBUSERCODE     IN COMPSESU.CMSSCOUC%TYPE
    )
    IS
        NUCOMPONENTID  COMPSESU.CMSSIDCO%TYPE;
    BEGIN
        PKERRORS.PUSH('pkMeasurementElementRequest.UpAditionalData');

        
        NUCOMPONENTID :=  PKMEASELEMSUBSSERVMGR.FNUGETCOMPONENTBYELEM
                                                (
                                                        INUEMSSELMER,
                                                        INUEMSSSESU
                                                );
        
        PKSUBSSERVCOMPONENTMGR.UPADITIONALDATA ( NUCOMPONENT,
                                                 ISBADITINALDATA,
                                                 ISBUSERCODE
                                               );

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    END UPADITIONALDATA;
    
    















































































   PROCEDURE CHANELEMMEASUBYWRONGREG(ITBCOMPCHANGEMEASURE IN OUT TYTBCOMPCHANGEMEASURE)
   IS
        NUERRORCODE     GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
        SBERRORMESSAGE  GE_ERROR_LOG.DESCRIPTION%TYPE;
        TBLECTELME      TYTBLECTELME;

        
        PROCEDURE VALINPUTDATA IS
        BEGIN
            PKERRORS.PUSH('pkMeasurementElementRequest.ChanElemMeasuByWrongReg.ValInputData');
            IF ( ITBCOMPCHANGEMEASURE.FIRST IS NULL ) THEN
                
                PKERRORS.SETERRORCODE(PKCONSTANTE.CSBDIVISION,PKCONSTANTE.CSBMOD_EME,CNUNO_EXISTEN_MED);
    		    RAISE LOGIN_DENIED;
            END IF ;
            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
                PKERRORS.POP;
                RAISE;
            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
        END VALINPUTDATA;

        PROCEDURE LOADLASTREADMEASELEM
        (
            INUSERVSUSC         IN  LECTELME.LEEMSESU%TYPE,
            INUELEMENTID        IN  LECTELME.LEEMELME%TYPE,
            ISBELEMENTCODE      IN  ELEMMEDI.ELMECODI%TYPE
        )
        IS
            NUCOUNT             NUMBER;
            RCLECTMEASELEM      LECTELME%ROWTYPE;
            TBCONSUMPTYPE       GE_BCCONSTYPEBYGAMA.TYTBCONSUMPTIONTYPE;
            TBULTVALIDREADINGS CM_TYTBREADINGS;
            NUIDX               NUMBER:=0;
        BEGIN

            PKERRORS.PUSH('pkMeasurementElementRequest.ChanElemMeasuByWrongReg.loadLastReadMeasElem');

            
            GE_BCCONSTYPEBYGAMA.GETCONSUMPTYPEBYSERIE(ISBELEMENTCODE,TBCONSUMPTYPE);

            TD('Cantidad Tipos de consumo X Serie del equipo['||ISBELEMENTCODE||'] -> ['||TBCONSUMPTYPE.COUNT||']');

            
            IF (TBCONSUMPTYPE.COUNT > 0)THEN
                
                FOR IDX IN TBCONSUMPTYPE.FIRST..TBCONSUMPTYPE.LAST LOOP

                    
                    
                    CM_BCMEASCONSUMPTIONS.GETPRODUCTREADINGS(INUSERVSUSC,TBCONSUMPTYPE(IDX).TCONCODI,INUELEMENTID,SYSDATE,52,TBULTVALIDREADINGS);

                    IF TBULTVALIDREADINGS.COUNT > 0 THEN
                        FOR NUIDX IN TBULTVALIDREADINGS.FIRST..TBULTVALIDREADINGS.LAST LOOP

                               
                               
                               IF TBULTVALIDREADINGS(NUIDX).LEEMVALI = 'S' THEN

                                    
                                    
                                    
                                        NUCOUNT:=TBLECTELME.COUNT;
                                        TBLECTELME(NUCOUNT).ELMECODI:=ISBELEMENTCODE;
                                        TBLECTELME(NUCOUNT).LEEMLETO:=TBULTVALIDREADINGS(NUIDX).LEEMLETO; 
                                        TBLECTELME(NUCOUNT).LEEMTCON:=TBULTVALIDREADINGS(NUIDX).LEEMTCON;
                                        TBLECTELME(NUCOUNT).LEEMOBLE:=NULL;  

                                    
                                    EXIT;

                                END IF;
                         END LOOP;

                     ELSE  
                        NUCOUNT:=TBLECTELME.COUNT;
                        TBLECTELME(NUCOUNT).ELMECODI:=ISBELEMENTCODE;
                        TBLECTELME(NUCOUNT).LEEMLETO:=0; 
                        TBLECTELME(NUCOUNT).LEEMTCON:=TBCONSUMPTYPE(IDX).TCONCODI;
                     END IF;  
                    
                  END LOOP;

            END IF;

            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED OR
                PKCONSTANTE.EXERROR_LEVEL2 OR
                EX.CONTROLLED_ERROR THEN
                PKERRORS.POP;
                RAISE;
            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
                RAISE;
        END LOADLASTREADMEASELEM;

        

        PROCEDURE  INSREADELEMENT
        (
            ISBELEMENTCODE   IN ELEMMEDI.ELMECODI%TYPE,
            ISBREADCAUSAL    IN LECTELME.LEEMCLEC%TYPE,
            IDTREADDATE      IN LECTELME.LEEMFELE%TYPE,
            INUPRODUCTID     IN PR_PRODUCT.PRODUCT_ID%TYPE
        )
        IS
        BEGIN

            PKERRORS.PUSH('pkMeasurementElementRequest.ChanElemMeasuByWrongReg.insReadElement');

            TD('Cantidad Lecturas ['||TBLECTELME.COUNT||']');
            IF (TBLECTELME.COUNT > 0)THEN

                FOR IDX IN TBLECTELME.FIRST..TBLECTELME.LAST
                LOOP

                    
                    IF (TBLECTELME(IDX).ELMECODI=ISBELEMENTCODE) THEN
                    
                        TD('Insertando Lectura Tomada ['||TBLECTELME(IDX).LEEMLETO||']');

                        CM_BOLECTELME.INSERTREADING
                        (
                            NULL,                         
                            NULL,                         
                            NULL,                         
                            GE_BOPERSONAL.FNUGETPERSONID, 
                            INUPRODUCTID,                 
                            ISBELEMENTCODE,               
                            TBLECTELME(IDX).LEEMTCON,     
                            TBLECTELME(IDX).LEEMLETO,     
                            ISBREADCAUSAL,                
                            IDTREADDATE,                  
                            TBLECTELME(IDX).LEEMOBLE,     
                            NULL,                         
                            NULL,                         
                            FALSE                         
                        );

                    
                    END IF;
                END LOOP;
            END IF;
            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED OR
                PKCONSTANTE.EXERROR_LEVEL2 OR
                EX.CONTROLLED_ERROR THEN
                PKERRORS.POP;
                RAISE;
            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
                RAISE;
        END INSREADELEMENT;

        

        PROCEDURE PROCESS IS

            
            
            
            TYPE TYRCHIJOS IS RECORD
            (
                NUELEMHIJO  ELMESESU.EMSSELME%TYPE,
                NUELMEINST  ELMESESU.EMSSELME%TYPE
            );

            TYPE TYTBHIJOS IS TABLE OF TYRCHIJOS INDEX BY BINARY_INTEGER;

            
            
            

            
            NUELMEEMAC          ELEMMEDI.ELMEEMAC%TYPE;
            
            NUELEMENTORETIRAR   ELEMMEDI.ELMEIDEM%TYPE;
            
            NUELEMENTOINSTALAR  ELEMMEDI.ELMEIDEM%TYPE;


            
            
            TBHIJOS     TYTBHIJOS;
            TBELMEIDEM  PKTBLELEMMEDI.TYELMEIDEM;

            NUIND  NUMBER := 1;
            RCSERIALITEM    DAGE_ITEMS_SERIADO.STYGE_ITEMS_SERIADO;
            NUSUBSCRIBER_ID  SUSCRIPC.SUSCCLIE%TYPE;
        BEGIN
            PKERRORS.PUSH('pkMeasurementElementRequest.ChanElemMeasuByWrongReg.Process');

            
            
            
            FOR IDX IN ITBCOMPCHANGEMEASURE.FIRST..ITBCOMPCHANGEMEASURE.LAST
            LOOP
                TD('');
                TD('-- -- LOOP Retiros -- -- ('||IDX||')');
                
                
                
                NUELEMENTORETIRAR :=
                PKMEASUREMENTELEMENMGR.FNUGETMEASUREELEMENTID
                (
                    ITBCOMPCHANGEMEASURE(IDX).SBEMSSCOEMRE, 
                    PKCONSTANTE.NOCACHE
                );
                NUELEMENTOINSTALAR :=
                PKMEASUREMENTELEMENMGR.FNUGETMEASUREELEMENTID
                (
                    ITBCOMPCHANGEMEASURE(IDX).SBEMSSCOEMIN, 
                    PKCONSTANTE.NOCACHE
                );

                TD('[1.1] ID Retirar['||NUELEMENTORETIRAR||'] ID Instalar['||NUELEMENTOINSTALAR||']');

                
                
                
                
                PKBCELEMMEDI.GETMEASELEMENTBYEMAC
                (
                    NUELEMENTORETIRAR,  
                    TBELMEIDEM          
                );
                TD('[1.2] Cant Hijos (de Retirado) ['||TBELMEIDEM.COUNT||']');

                
                
                
                
                IF  ( TBELMEIDEM.FIRST IS NOT NULL ) THEN
                
                    TD('[1.3] Guardando Hijos...');
                    FOR IND IN TBELMEIDEM.FIRST..TBELMEIDEM.LAST
                    LOOP

                        
                        
                        IF ( TBELMEIDEM(IND) = NUELEMENTOINSTALAR ) THEN
                        
                            TBHIJOS(NUIND).NUELEMHIJO := NUELEMENTORETIRAR; 
                            TBHIJOS(NUIND).NUELMEINST := TBELMEIDEM(IND);

                        ELSE
                            TBHIJOS(NUIND).NUELEMHIJO := TBELMEIDEM(IND);
                            TBHIJOS(NUIND).NUELMEINST := NUELEMENTOINSTALAR;
                        
                        END IF;

                        TD('      Hijo['||TBHIJOS(NUIND).NUELEMHIJO||'] Inst['||TBHIJOS(NUIND).NUELMEINST||'] ('||NUIND||')');
                        NUIND := NUIND +1;
                    END LOOP;
                
                END IF;

                
                
                
                TD('[1.4] Cargando Lecturas');
                LOADLASTREADMEASELEM
                (
                    ITBCOMPCHANGEMEASURE(IDX).NUEMSSSESU,
                    NUELEMENTORETIRAR,
                    ITBCOMPCHANGEMEASURE(IDX).SBEMSSCOEMRE
                );

                
                
                
                
                TD('[1.5] Insertando lecturas con Causal de Retiro');
                INSREADELEMENT
                (
                    ITBCOMPCHANGEMEASURE(IDX).SBEMSSCOEMRE,
                    CM_BOCONSTANTS.CSBCAUS_LECT_RETI,
                    ITBCOMPCHANGEMEASURE(IDX).DTEMSSFERE,
                    ITBCOMPCHANGEMEASURE(IDX).NUEMSSSESU
                );

                
                
                
                
                ITBCOMPCHANGEMEASURE(IDX).NUEMACEMRE := PKTBLELEMMEDI.FRCGETRECORD(NUELEMENTORETIRAR).ELMEEMAC;
                TD('[1.6] Padre (si aplica)['||ITBCOMPCHANGEMEASURE(IDX).NUEMACEMRE||']');

                
                
                
                TD('[1.7] Retirando');
                PKMEASUREMENTELEMENTREQUEST.RETELEMMEASUSERVSUBS
                (
                    NUELEMENTORETIRAR,
                    ITBCOMPCHANGEMEASURE(IDX).NUEMSSSESU,
                    ITBCOMPCHANGEMEASURE(IDX).DTEMSSFERE,
                    NUERRORCODE,
                    SBERRORMESSAGE
                );


                IF ( NUERRORCODE <> PKCONSTANTE.EXITO ) THEN
                
                    TD('Error retirando elemento!');
                    RAISE LOGIN_DENIED;
                
                END IF;

            END LOOP;

            
            
            
            FOR IDX IN ITBCOMPCHANGEMEASURE.FIRST..ITBCOMPCHANGEMEASURE.LAST
            LOOP
                TD('');
                TD('-- -- LOOP Instalaciones -- -- ('||IDX||')');
                
                
                
                NUELEMENTOINSTALAR :=
                PKMEASUREMENTELEMENMGR.FNUGETMEASUREELEMENTID
                (
                    ITBCOMPCHANGEMEASURE(IDX).SBEMSSCOEMIN, 
                    PKCONSTANTE.NOCACHE
                );
                NUELEMENTORETIRAR :=
                PKMEASUREMENTELEMENMGR.FNUGETMEASUREELEMENTID
                (
                    ITBCOMPCHANGEMEASURE(IDX).SBEMSSCOEMRE, 
                    PKCONSTANTE.NOCACHE
                );
                TD('[2.1] ID Retirar['||NUELEMENTORETIRAR||'] ID Instalar['||NUELEMENTOINSTALAR||']');

                
                
                
                
                TD('[2.2] Registrando Instalacion');
                PKMEASUREMENTELEMENTREQUEST.REGISELEMMEASUSERVSUBS
                (
                    NUELEMENTOINSTALAR,
                    ITBCOMPCHANGEMEASURE(IDX).NUEMSSSESU,
                    ITBCOMPCHANGEMEASURE(IDX).NUEMSSCMSS,
                    ITBCOMPCHANGEMEASURE(IDX).DTEMSSFEIN,
                    NUERRORCODE,
                    SBERRORMESSAGE,
                    NULL
                );

                
                
                
                TD('[2.2.1] Actualizacion del cliente en el item seriado');
                RCSERIALITEM := GE_BCITEMSSERIADO.FRCSERIALITEMBYSERIE(ITBCOMPCHANGEMEASURE(IDX).SBEMSSCOEMIN);
                NUSUBSCRIBER_ID := PKBCSUSCRIPC.FNUGETSUBSCRIBERID((PKTBLSERVSUSC.FNUGETSESUSUSC(ITBCOMPCHANGEMEASURE(IDX).NUEMSSSESU)));
                DAGE_ITEMS_SERIADO.UPDSUBSCRIBER_ID(RCSERIALITEM.ID_ITEMS_SERIADO, NUSUBSCRIBER_ID);

                DAGE_ITEMS_SERIADO.UPDNUMERO_SERVICIO(RCSERIALITEM.ID_ITEMS_SERIADO, ITBCOMPCHANGEMEASURE(IDX).NUEMSSSESU);

                IF ( NUERRORCODE <> PKCONSTANTE.EXITO ) THEN
                
                    TD('Error asociando Elemento de Medicion!');
                    RAISE LOGIN_DENIED;
                
                END IF;

                
                
                
                
                TD('[2.4] Insertando lecturas con Causal de Instalacion');
                INSREADELEMENT
                (
                    ITBCOMPCHANGEMEASURE(IDX).SBEMSSCOEMIN,
                    CM_BOCONSTANTS.CSBCAUS_LECT_INST,
                    ITBCOMPCHANGEMEASURE(IDX).DTEMSSFEIN,
                    ITBCOMPCHANGEMEASURE(IDX).NUEMSSSESU
                );

                
                
                
                
                TD('[2.5] Instalando['||NUELEMENTOINSTALAR||'] Padre['||ITBCOMPCHANGEMEASURE(IDX).NUEMACEMRE||']');
                IF ( NUELEMENTOINSTALAR <> ITBCOMPCHANGEMEASURE(IDX).NUEMACEMRE ) THEN
                
                    TD('   Instalar['||NUELEMENTOINSTALAR||'] Padre['||ITBCOMPCHANGEMEASURE(IDX).NUEMACEMRE||']');
                    
                    
                    PKTBLELEMMEDI.UPDATEDEPENDENTCOMMONAREA
                    (
                        NUELEMENTOINSTALAR,
                        ITBCOMPCHANGEMEASURE(IDX).NUEMACEMRE
                    );
                
                END IF;

                
                
                IF ( NUELEMENTOINSTALAR = ITBCOMPCHANGEMEASURE(IDX).NUEMACEMRE ) THEN
                
                    TD('   Instalar['||NUELEMENTOINSTALAR||'] Padre['||NUELEMENTORETIRAR||'] (CE)');
                    PKTBLELEMMEDI.UPDATEDEPENDENTCOMMONAREA
                    (
                        NUELEMENTOINSTALAR,
                        NUELEMENTORETIRAR
                    );
                
                END IF;

            END LOOP;

            
            
            
            IF  ( TBHIJOS.FIRST IS NOT NULL ) THEN
            
                TD('[3] Moviendo Hijos');
                FOR IND IN TBHIJOS.FIRST..TBHIJOS.LAST
                LOOP

                    IF ( TBHIJOS(IND).NUELEMHIJO <> TBHIJOS(IND).NUELMEINST ) THEN

                        TD('['||TBHIJOS(IND).NUELEMHIJO||'] depende de ['||TBHIJOS(IND).NUELMEINST||']');
                        PKTBLELEMMEDI.UPDATEDEPENDENTCOMMONAREA
                        (
                            TBHIJOS(IND).NUELEMHIJO,
                            TBHIJOS(IND).NUELMEINST
                        );

                    END IF;

                END LOOP;
            
            END IF;

            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED OR
                PKCONSTANTE.EXERROR_LEVEL2 OR
                EX.CONTROLLED_ERROR THEN
                PKERRORS.POP;
                RAISE;
            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
                RAISE;
        END PROCESS;

        

    BEGIN

        PKERRORS.PUSH('pkMeasurementElementRequest.ChanElemMeasuByWrongReg');

        
        TD('-- Inicializando --');
        PKERRORS.INITIALIZE;
        NUERRORCODE    := PKCONSTANTE.EXITO;
        SBERRORMESSAGE := NULL;

        
        TD('-- Validando Datos --');
        VALINPUTDATA;


        
        TD('-- Procesando --');
        PROCESS;

        PKERRORS.POP;

    EXCEPTION
        WHEN LOGIN_DENIED OR
            PKCONSTANTE.EXERROR_LEVEL2 OR
            EX.CONTROLLED_ERROR THEN
            PKERRORS.POP;
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
            RAISE;
    END CHANELEMMEASUBYWRONGREG;
    























FUNCTION FSBVERSION
RETURN VARCHAR2
IS

BEGIN


    PKERRORS.PUSH ('pkChangeMeasuElement.fsbVersion');

    PKERRORS.POP;

    
    RETURN ( CSBVERSION );

EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
        RAISE LOGIN_DENIED;

    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        
        PKERRORS.POP;
        RAISE PKCONSTANTE.EXERROR_LEVEL2;


    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);

END FSBVERSION;

END PKMEASUREMENTELEMENTREQUEST;