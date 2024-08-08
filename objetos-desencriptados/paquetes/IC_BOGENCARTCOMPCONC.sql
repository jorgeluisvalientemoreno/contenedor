PACKAGE IC_BOGenCartCompConc IS
























































    
    
    
    
    CNUGENERATION   CONSTANT NUMBER(1) := 1;

    
    CNUROLLBACK     CONSTANT NUMBER(1) := 2;
    
    
    CSBDEF_PORTFOLIO CONSTANT VARCHAR2(1) := 'F';

    
    CSBNOT_DEF_PORTFOLIO CONSTANT VARCHAR2(1) := 'N';
    
    
    CSBSHORT_TERM CONSTANT VARCHAR2(1) := 'C';

    
    CSBLONG_TERM CONSTANT VARCHAR2(1) := 'L';
    
    
    

    
    FUNCTION FSBVERSION
        RETURN VARCHAR2;

    PROCEDURE INITCONCURRENCECTRL
    (
        IDTPORTFDATE    IN  DATE,
        ISBSENTENCE     IN  CONCPROC.COPRSEEJ%TYPE
    );

    PROCEDURE PROCESS
    (
        IDTGENDATE      IN  DATE,
        INUTHREADS      IN  NUMBER,
        INUTHREAD       IN  NUMBER,
        INUPROCPROG     IN  GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE,
        ISBPROCSTATUS   IN  ESTAPROG.ESPRPROG%TYPE
    );

    PROCEDURE VALPROCESS
    (
        IDTINITDATE     IN  DATE,
        IDTFINALDATE    IN  DATE
    );

    PROCEDURE VALEXECUTION
    (
        IDTINITIALDATE  IN  DATE,
        IDTFINALDATE    IN  DATE
    );

    PROCEDURE VALPRECONDITIONS
    (
        IDTPORTFDATE    IN  DATE,
        INUDELAYDAYS    IN  NUMBER,
        ISBFREQUENCY    IN  VARCHAR2,
        OSBPROCESSDATE  OUT VARCHAR2
    );
    
    PROCEDURE GENACCOUNTSBALANCE
    (
        IDTPORTFDATE    IN  DATE
    );
    
    PROCEDURE VALBASICDATA
    (
        IDTPORTFDATE    IN  DATE
    );
    
    FUNCTION FDTLASTDATE
        RETURN DATE;

END IC_BOGENCARTCOMPCONC;
/
PACKAGE BODY IC_BOGenCartCompConc IS




































































































    
    
    

    
    CSBVERSION          CONSTANT VARCHAR2(250) := 'SAO541750';

    
    CSBDUMMY            CONSTANT VARCHAR2(1) := '%';
    
    
    CSBPIPE             CONSTANT VARCHAR2(1) := '|';
    
    
    CSBDATE_FORMAT      CONSTANT VARCHAR2(10) := 'dd-mm-yyyy';

    
    CSBCOMPL_DATE_FORMAT  CONSTANT VARCHAR2(25) := 'dd-mm-yyyy hh24:mi:ss';

    
    CSBLAST_DAY_SEC     CONSTANT VARCHAR2(20) := ' 23:59:59';

    
    CSBGENERATION_PROCESS CONSTANT VARCHAR2(10) := 'ICBGIC';

    
    CSBROLLBACK_PROCESS CONSTANT VARCHAR2(10) := 'ICBRIC';

    
    CNULIMIT            CONSTANT NUMBER := 100;
    
    
    CSBSEQUENCE CONSTANT VARCHAR2(100) := 'SQ_IC_CARTCOCO_174995';

    
    CSBINGRESO      CONSTANT VARCHAR2(100) := 'Ingres�';
    CSBNO_INGRESO   CONSTANT VARCHAR2(100) := 'No ingres�';
    CSBDEBE         CONSTANT VARCHAR2(100) := 'debe';
    CSBNO_DEBE      CONSTANT VARCHAR2(100) := 'no debe';

    
    
    
    SBERRMSG            GE_MESSAGE.DESCRIPTION%TYPE;

    
    BOLOADED            BOOLEAN;

    
    NUNIVELUBGE1    GE_GEOGRA_LOCA_TYPE.GEOG_LOCA_AREA_TYPE%TYPE;
    
    NUNIVELUBGE2    GE_GEOGRA_LOCA_TYPE.GEOG_LOCA_AREA_TYPE%TYPE;
    
    NUNIVELUBGE3    GE_GEOGRA_LOCA_TYPE.GEOG_LOCA_AREA_TYPE%TYPE;
    
    NUNIVELUBGE4    GE_GEOGRA_LOCA_TYPE.GEOG_LOCA_AREA_TYPE%TYPE;
    
    NUNIVELUBGE5    GE_GEOGRA_LOCA_TYPE.GEOG_LOCA_AREA_TYPE%TYPE;

    
    SBLOCBAR1       VARCHAR2(1);
    
    SBLOCBAR2       VARCHAR2(1);
    
    SBLOCBAR3       VARCHAR2(1);
    
    SBLOCBAR4       VARCHAR2(1);
    
    SBLOCBAR5       VARCHAR2(1);

    
    SBDEPOSITRECTYPE    DIFERIDO.DIFETIRE%TYPE;
    
    
    NUMESESPLAZO   NUMBER;
    
    GNUREPORTE  REPORTES.REPONUME%TYPE;
    
    
    
    
    TYPE TYTBTIPOCOMP IS TABLE OF NUMEAUTO.NUAUTICO%TYPE INDEX BY VARCHAR2(20);
    
    
    
    
    
    TBPORTFOLIO PKTBLIC_CARTCOCO.TYTBIC_CARTCOCO;
    
    
    TBTIPOCOMP TYTBTIPOCOMP;
    
    
    
    
   



















    FUNCTION FSBVERSION
        RETURN VARCHAR2
    IS
    BEGIN

        RETURN IC_BOGENCARTCOMPCONC.CSBVERSION;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
            RETURN NULL;
    END FSBVERSION;

    













    PROCEDURE CREAREPORTE
    (
        ISBPROCSTATUS   IN  ESTAPROG.ESPRPROG%TYPE
    )
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        PKERRORS.PUSH('IC_BOGenCartCompConc.CreaReporte');

        GNUREPORTE := NULL;

        
        CC_BOUTILREPORTS.CREATEREPORT(
                                        'Inconsistencias ICBGIC',
                                        ISBPROCSTATUS,
                                        GNUREPORTE
                                      );
        PKSTATUSEXEPROGRAMMGR.UPINFOEXEPROGRAM (
                                        ISBPROCSTATUS,
                                        'Reporte Inconsistencias: '||GNUREPORTE
                                      );
        COMMIT;
        PKERRORS.POP;
    EXCEPTION
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR (PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            PKERRORS.POP;
    END CREAREPORTE;

    













    PROCEDURE PROCESAINCONSISTENCIA
    (
        INUCODIGO  IN NUMBER,
        INUPRODUCT IN NUMBER,
        ISBNACA    IN VARCHAR2
    )
    IS

        RCREPOINCO REPOINCO%ROWTYPE;
        NUREPORTE  REPORTES.REPONUME%TYPE;
        
        NUCODERR GE_MESSAGE.MESSAGE_ID%TYPE;
        SBERRMSG GE_MESSAGE.DESCRIPTION%TYPE;

        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        PKERRORS.PUSH('IC_BOGenCartCompConc.ProcesaInconsistencia');

        NUCODERR := PKERRORS.FNUGETERRORCODE;
        SBERRMSG := PKERRORS.FSBGETERRORMESSAGE;
        PKERRORS.INITIALIZE;

        
        RCREPOINCO.REINREPO := GNUREPORTE;
        RCREPOINCO.REINCODI := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SQ_REPOINCO_REINCODI');
        RCREPOINCO.REINLON1 := TO_CHAR (INUPRODUCT);
        RCREPOINCO.REINDES1 := TO_CHAR (INUCODIGO);
        RCREPOINCO.REINCHR1 := ISBNACA;
        IF (ISBNACA = IC_BOGENCARTCOMPCONC.CSBDEF_PORTFOLIO) THEN
            RCREPOINCO.REINCHR2 := 'DIFERIDO';
        ELSE
            RCREPOINCO.REINCHR2 := 'CUENCOBR';
        END IF;
        RCREPOINCO.REINOBSE := NUCODERR||' - '||SBERRMSG;

        
        PKTBLREPOINCO.INSRECORD(RCREPOINCO);
        
        COMMIT;

        PKERRORS.POP;
    EXCEPTION
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR (PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            PKERRORS.POP;
    END PROCESAINCONSISTENCIA;

    













    PROCEDURE GETPARAMETERS
    IS
        
        
        
        
        CSBMESES_PLAZO CONSTANT VARCHAR2(20) := 'MESES_PLAZO_CARTERA';

        
        CNUMESES_DEFECTO CONSTANT NUMBER := 12;

        
        CSBDEPOSIT_REC_TYPE CONSTANT PARAMETR.PAMECODI%TYPE
                                            := 'TIPO_REGIS_DEPOSITO_GARANTIA';
                                            
    BEGIN
        PKERRORS.PUSH('IC_BOGenCartCompConc.GetParameters');

        
        IF ( IC_BOGENCARTCOMPCONC.BOLOADED ) THEN
            PKERRORS.POP;
            RETURN;
        END IF;

        
        GE_BOGEOGRA_LOCATION.GETUBGES
        (
            IC_BOGENCARTCOMPCONC.NUNIVELUBGE1,
            IC_BOGENCARTCOMPCONC.NUNIVELUBGE2,
            IC_BOGENCARTCOMPCONC.NUNIVELUBGE3,
            IC_BOGENCARTCOMPCONC.NUNIVELUBGE4,
            IC_BOGENCARTCOMPCONC.NUNIVELUBGE5,
            IC_BOGENCARTCOMPCONC.SBLOCBAR1,
            IC_BOGENCARTCOMPCONC.SBLOCBAR2,
            IC_BOGENCARTCOMPCONC.SBLOCBAR3,
            IC_BOGENCARTCOMPCONC.SBLOCBAR4,
            IC_BOGENCARTCOMPCONC.SBLOCBAR5
        );
        
        
        IC_BOGENCARTCOMPCONC.SBDEPOSITRECTYPE
                        := PKGENERALPARAMETERSMGR.FSBGETSTRINGVALUE
                             (
                               CSBDEPOSIT_REC_TYPE
                             );
                             
        
        BEGIN
            IC_BOGENCARTCOMPCONC.NUMESESPLAZO := GE_BOPARAMETER.FNUVALORNUMERICO
                                                  (
                                                      CSBMESES_PLAZO
                                                  );
        EXCEPTION
            WHEN OTHERS THEN
                IC_BOGENCARTCOMPCONC.NUMESESPLAZO := NULL;
        END;

        
        IF ( IC_BOGENCARTCOMPCONC.NUMESESPLAZO IS NULL ) THEN
            IC_BOGENCARTCOMPCONC.NUMESESPLAZO := CNUMESES_DEFECTO;
        END IF;

        
        IC_BOGENCARTCOMPCONC.BOLOADED := TRUE;

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
    END GETPARAMETERS;
    
    































    
    PROCEDURE VALINPUTDATA
    (
        IDTPORTFDATE    IN  DATE
    )
    IS
    BEGIN
        PKERRORS.PUSH('IC_BOGenCartCompConc.ValInputData');

        
        PKGENERALSERVICES.VALFECHAMENORACTUAL( IDTPORTFDATE );

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
    END VALINPUTDATA;
    
    
















































    PROCEDURE VALBASICDATA
    (
        IDTPORTFDATE    IN  DATE
    )
    IS
        
        
        
        
        CNUINIT_DATE_INVALID    CONSTANT NUMBER := 901519;
        
        
        CSBPOSTERIOR            CONSTANT VARCHAR2(15) := ' o posterior';

        
        
        
        
        DTTOEXECDATE    DATE;

    BEGIN
        PKERRORS.PUSH('IC_BOGenCartCompConc.ValBasicData');

        
        
        
        
        DTTOEXECDATE := IC_BOGENCARTCOMPCONC.FDTLASTDATE + 1 ;
        
        
        IF ( DTTOEXECDATE IS NULL ) THEN

            
            DTTOEXECDATE := IDTPORTFDATE;

        END IF;

        
        IF ( IDTPORTFDATE < DTTOEXECDATE ) THEN
            ERRORS.SETERROR
            (
                CNUINIT_DATE_INVALID,
                TO_CHAR( IDTPORTFDATE, IC_BOGENCARTCOMPCONC.CSBDATE_FORMAT) ||
                IC_BOGENCARTCOMPCONC.CSBPIPE ||
                TO_CHAR( DTTOEXECDATE, IC_BOGENCARTCOMPCONC.CSBDATE_FORMAT) ||
                CSBPOSTERIOR
            );

            RAISE LOGIN_DENIED;
        END IF;

        PKERRORS.POP;
        
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
    END VALBASICDATA;

    































    
    PROCEDURE VALFREQUENCY
    (
        IDTPORTFDATE    IN  DATE,
        INUDELAYDAYS    IN  NUMBER,
        ISBFREQUENCY    IN  VARCHAR2
    )
    IS
    
        
        
        

        
        CNUFREQ_NO_VAL          CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 902061;
        
        CNUPORT_DATE_NO_VAL     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 902064;
        
        CNUERROR_DATE_VS_DAYS   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 902062;
        
        CNUDAYS_LESS_EQ_ZERO    CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 902092;
        
        CNUPORTF_DATE_NULL      CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 902082;
    
    BEGIN
        PKERRORS.PUSH('IC_BOGenCartCompConc.ValFrequency');
        
        
        IF ( ISBFREQUENCY NOT IN ( GE_BOSCHEDULE.CSBSOLOUNAVEZ,
                                  GE_BOSCHEDULE.CSBDIARIO,
                                  GE_BOSCHEDULE.CSBMENSUAL)) THEN

            ERRORS.SETERROR
            (
                CNUFREQ_NO_VAL
            );
            
            RAISE LOGIN_DENIED;
        END IF;

        
        IF ( ISBFREQUENCY = GE_BOSCHEDULE.CSBDIARIO
             OR
             ISBFREQUENCY = GE_BOSCHEDULE.CSBMENSUAL ) THEN

            
            IF ( IDTPORTFDATE IS NOT NULL ) THEN
                ERRORS.SETERROR
                (
                    CNUPORT_DATE_NO_VAL
                );
                
                RAISE LOGIN_DENIED;
            END IF;

            
            IF ( INUDELAYDAYS IS NULL ) THEN
                ERRORS.SETERROR
                (
                    CNUERROR_DATE_VS_DAYS,
                    IC_BOGENCARTCOMPCONC.CSBNO_INGRESO ||
                        IC_BOGENCARTCOMPCONC.CSBPIPE ||
                        IC_BOGENCARTCOMPCONC.CSBDEBE
                );
                RAISE LOGIN_DENIED;
            END IF;

            
            IF ( INUDELAYDAYS <= 0 ) THEN
                ERRORS.SETERROR
                (
                    CNUDAYS_LESS_EQ_ZERO
                );
                    
                RAISE LOGIN_DENIED;
            END IF;

        END IF;

        
        IF ( ISBFREQUENCY = GE_BOSCHEDULE.CSBSOLOUNAVEZ ) THEN

            
            IF ( IDTPORTFDATE IS NULL ) THEN
                ERRORS.SETERROR
                (
                    CNUPORTF_DATE_NULL
                );
                RAISE LOGIN_DENIED;
            END IF;

            
            IF ( INUDELAYDAYS IS NOT NULL ) THEN
                ERRORS.SETERROR
                (
                    CNUERROR_DATE_VS_DAYS,
                    IC_BOGENCARTCOMPCONC.CSBINGRESO || '|' ||
                    IC_BOGENCARTCOMPCONC.CSBNO_DEBE
                );
                RAISE LOGIN_DENIED;
            END IF;
        END IF;

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
    END VALFREQUENCY;

    





























    PROCEDURE VALIDATECONCURRENCE
    (
        IDTPORTFDATE    IN  DATE
    )
    IS
    BEGIN
        PKERRORS.PUSH('IC_BOGenCartCompConc.ValidateConcurrence');


        
        PKBOPROCESSCONCURRENCECTRL.VALIDATECONCURRENCE
        (
            TO_CHAR( IDTPORTFDATE, IC_BOGENCARTCOMPCONC.CSBDATE_FORMAT),
            IC_BOGENCARTCOMPCONC.CSBROLLBACK_PROCESS
        );

        
        PKBOPROCESSCONCURRENCECTRL.VALEXECUTEPROCESS
        (
            IC_BOGENCARTCOMPCONC.CSBGENERATION_PROCESS ||
                IC_BOGENCARTCOMPCONC.CSBDUMMY,
            IC_BOGENCARTCOMPCONC.CSBROLLBACK_PROCESS,
            CSBDUMMY
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
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
    END VALIDATECONCURRENCE;

    


























    PROCEDURE INITCONCURRENCECTRL
    (
        IDTPORTFDATE    IN  DATE,
        ISBSENTENCE     IN  CONCPROC.COPRSEEJ%TYPE
    )
    IS
    BEGIN
        PKERRORS.PUSH('IC_BOGenCartCompConc.InitConcurrenceCtrl');

        
        PKBOPROCESSCONCURRENCECTRL.GENCONTROLPROCESSAT
        (
            TO_CHAR( IDTPORTFDATE, IC_BOGENCARTCOMPCONC.CSBDATE_FORMAT ),
            ISBSENTENCE
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
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
    END INITCONCURRENCECTRL;

    

















    PROCEDURE FINALIZECONCURRENCECTRL
    (
        IDTDATE IN  DATE
    )
    IS
    BEGIN
        PKERRORS.PUSH('IC_BOGenCartCompConc.FinalizeConcurrenceCtrl');

        
        PKBOPROCESSCONCURRENCECTRL.FINCONCURRENCECONTROL
        (
            TO_CHAR( IDTDATE, IC_BOGENCARTCOMPCONC.CSBDATE_FORMAT )
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
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
    END FINALIZECONCURRENCECTRL;

    






















    PROCEDURE GETPROCESSDATE
    (
        IDTPORTFDATE    IN  DATE,
        INUDELAYDAYS    IN  NUMBER,
        ODTPROCESSDATE  OUT NOCOPY DATE
    )
    IS
    BEGIN
        PKERRORS.PUSH('IC_BOGenCartCompConc.GetProcessDate');

        
        
        
        
        
        
        IF ( INUDELAYDAYS IS NOT NULL ) THEN
            ODTPROCESSDATE := TRUNC( SYSDATE ) - INUDELAYDAYS;

        ELSE
            ODTPROCESSDATE := IDTPORTFDATE;
            
        END IF;

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM,
                SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                SBERRMSG
            );
    END GETPROCESSDATE;
    

    





























































    PROCEDURE PROCESS
    (
        IDTGENDATE      IN  DATE,
        INUTHREADS      IN  NUMBER,
        INUTHREAD       IN  NUMBER,
        INUPROCPROG     IN  GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE,
        ISBPROCSTATUS   IN  ESTAPROG.ESPRPROG%TYPE
    )
    IS
        
        
        
        
        CNUZERO     CONSTANT NUMBER := 0;
        
        
        CNUONE      CONSTANT NUMBER := 1;
        
        
        
        
        
        DTGENDATELASTSECOND   DATE;

        
        NUACCNTSCOUNT   NUMBER;
        
        
        NUDEFERREDCOUNT NUMBER;

        
        NUTOTALSTEP   NUMBER;
        
        
        NUPARTIALSTEP   NUMBER;
        
        
      	TYPE TYTBDETFEVE IS TABLE OF DATE INDEX BY VARCHAR2(20);
      	
      	
        TBDETFEVE       TYTBDETFEVE;
        TBDETFEVENULL   TYTBDETFEVE;
        
        TBINTERESRATE   PKTBLCONFTAIN.TYCOTIPORC;

        
        
        
        



















        PROCEDURE INITIALIZE
        IS
            
            
            
            CSBSENTENCE CONSTANT CONCPROC.COPRSEEJ%TYPE
                                    := 'IC_BOGenCartCompConc.Process';

            
            CSBPROCESS  CONSTANT VARCHAR2(10) := 'ICBGIC-';

            
            CSBPROCESANDO CONSTANT VARCHAR2(15) := 'Procesando...';

        BEGIN
            PKERRORS.PUSH('IC_BOGenCartCompConc.Process.Initialize');

            
            PKERRORS.INITIALIZE;

            
            DTGENDATELASTSECOND :=  TO_DATE
                                    (
                                        TO_CHAR
                                        (
                                            IDTGENDATE,
                                            IC_BOGENCARTCOMPCONC.CSBDATE_FORMAT
                                        ) || IC_BOGENCARTCOMPCONC.CSBLAST_DAY_SEC,
                                        IC_BOGENCARTCOMPCONC.CSBCOMPL_DATE_FORMAT
                                    );

            
            PKERRORS.SETAPPLICATION(CSBPROCESS||INUTHREAD);

            
            IC_BOGENCARTCOMPCONC.INITCONCURRENCECTRL
            (
                IDTGENDATE,
                CSBSENTENCE
            );

            
            PKSTATUSEXEPROGRAMMGR.VALIDATERECORDAT
            (
                ISBPROCSTATUS
            );

            
            PKSTATUSEXEPROGRAMMGR.UPEXEPROGPROGPROC
            (
                ISBPROCSTATUS,
                INUPROCPROG
            );


            
            
            NUACCNTSCOUNT := IC_BCGENCARTCOMPCONC.FNUACCOUNTSTOPROCESS
                                (
                                    INUTHREAD,
                                    INUTHREADS
                                );
                                
            
            NUDEFERREDCOUNT := IC_BCGENCARTCOMPCONC.FNUDEFERREDTOPROCESS
                                (
                                    INUTHREAD,
                                    INUTHREADS
                                );
            
            

            NUTOTALSTEP := NUACCNTSCOUNT + NUDEFERREDCOUNT;
            
            
            PKSTATUSEXEPROGRAMMGR.UPSTATUSEXEPROGRAMAT
            (
                ISBPROCSTATUS,
                CSBPROCESANDO,
                NUTOTALSTEP,
                CNUZERO
            );

            
            PKCONCEPTVALUESMGR.SETPROCESSDATE( IDTGENDATE );

            
            CREAREPORTE (ISBPROCSTATUS);

            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED THEN
                PKERRORS.POP;
                RAISE LOGIN_DENIED;

            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
                
                PKERRORS.POP;
                RAISE PKCONSTANTE.EXERROR_LEVEL2;

            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR
                (
                    PKERRORS.FSBLASTOBJECT,
                    SQLERRM,
                    IC_BOGENCARTCOMPCONC.SBERRMSG
                );
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR
                (
                    PKCONSTANTE.NUERROR_LEVEL2,
                    IC_BOGENCARTCOMPCONC.SBERRMSG
                );
        END INITIALIZE;
        
        













        PROCEDURE DELTEMPTABLE
        IS
        BEGIN
            PKERRORS.PUSH('IC_BOGenCartCompConc.Process.DelTempTable');
            
            
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCONS.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCATE.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCICL.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCLIE.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCOMP.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCONC.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCUCO.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCESCO.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCFEGE.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCFEVE.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCIDCL.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCNACA.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCPLCA.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCNUFI.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCNUSE.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCPREF.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCSAPE.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCSERV.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCSUCA.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCSUSC.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCTICL.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCTICO.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCVABL.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCUBG1.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCUBG2.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCUBG3.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCUBG4.DELETE;
            IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCUBG5.DELETE;

            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED THEN
                PKERRORS.POP;
                RAISE LOGIN_DENIED;

            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
                
                PKERRORS.POP;
                RAISE PKCONSTANTE.EXERROR_LEVEL2;

            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR
                (
                    PKERRORS.FSBLASTOBJECT,
                    SQLERRM,
                    IC_BOGENCARTCOMPCONC.SBERRMSG
                );
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR
                (
                    PKCONSTANTE.NUERROR_LEVEL2,
                    IC_BOGENCARTCOMPCONC.SBERRMSG
                );
        END DELTEMPTABLE;
        
        

























        PROCEDURE GETGEOGRAPLOCS
        (
            INUUBGEA    IN  GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE,
            INUUBGEB    IN  GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE,
            ONUUBGE1    OUT NOCOPY GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE,
            ONUUBGE2    OUT NOCOPY GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE,
            ONUUBGE3    OUT NOCOPY GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE,
            ONUUBGE4    OUT NOCOPY GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE,
            ONUUBGE5    OUT NOCOPY GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE
        )
        IS
        BEGIN
            PKERRORS.PUSH('IC_BOGenCartCompConc.Process.GetGeograpLocs');

            
            IF  IC_BOGENCARTCOMPCONC.SBLOCBAR1 = PKCONSTANTE.SI THEN
                ONUUBGE1 := GE_BCGEOGRA_LOCATION.FNUGETFIRSTUPPERLEVEL
                            (
                                INUUBGEA,
                                IC_BOGENCARTCOMPCONC.NUNIVELUBGE1
                            );
            ELSE
                ONUUBGE1 := GE_BCGEOGRA_LOCATION.FNUGETFIRSTUPPERLEVEL
                            (
                                INUUBGEB,
                                IC_BOGENCARTCOMPCONC.NUNIVELUBGE1
                            );
            END IF;

            
            IF  IC_BOGENCARTCOMPCONC.SBLOCBAR2 = PKCONSTANTE.SI THEN
                ONUUBGE2 := GE_BCGEOGRA_LOCATION.FNUGETFIRSTUPPERLEVEL
                            (
                                INUUBGEA,
                                IC_BOGENCARTCOMPCONC.NUNIVELUBGE2
                            );
            ELSE
                ONUUBGE2 := GE_BCGEOGRA_LOCATION.FNUGETFIRSTUPPERLEVEL
                            (
                                INUUBGEB,
                                IC_BOGENCARTCOMPCONC.NUNIVELUBGE2
                            );
            END IF;

            
            IF  IC_BOGENCARTCOMPCONC.SBLOCBAR3 = PKCONSTANTE.SI THEN
                ONUUBGE3 := GE_BCGEOGRA_LOCATION.FNUGETFIRSTUPPERLEVEL
                            (
                                INUUBGEA,
                                IC_BOGENCARTCOMPCONC.NUNIVELUBGE3
                            );
            ELSE
                ONUUBGE3 := GE_BCGEOGRA_LOCATION.FNUGETFIRSTUPPERLEVEL
                            (
                                INUUBGEB,
                                IC_BOGENCARTCOMPCONC.NUNIVELUBGE3
                            );
            END IF;

            
            IF  IC_BOGENCARTCOMPCONC.SBLOCBAR4 = PKCONSTANTE.SI THEN
                ONUUBGE4 := GE_BCGEOGRA_LOCATION.FNUGETFIRSTUPPERLEVEL
                            (
                                INUUBGEA,
                                IC_BOGENCARTCOMPCONC.NUNIVELUBGE4
                            );
            ELSE
                ONUUBGE4 := GE_BCGEOGRA_LOCATION.FNUGETFIRSTUPPERLEVEL
                            (
                                INUUBGEB,
                                IC_BOGENCARTCOMPCONC.NUNIVELUBGE4
                            );
            END IF;

            
            IF  IC_BOGENCARTCOMPCONC.SBLOCBAR5 = PKCONSTANTE.SI THEN
                ONUUBGE5 := GE_BCGEOGRA_LOCATION.FNUGETFIRSTUPPERLEVEL
                            (
                                INUUBGEA,
                                IC_BOGENCARTCOMPCONC.NUNIVELUBGE5
                            );
            ELSE
                ONUUBGE5 := GE_BCGEOGRA_LOCATION.FNUGETFIRSTUPPERLEVEL
                            (
                                INUUBGEB,
                                IC_BOGENCARTCOMPCONC.NUNIVELUBGE5
                            );
            END IF;

            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED THEN
                PKERRORS.POP;
                RAISE LOGIN_DENIED;

            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
                
                PKERRORS.POP;
                RAISE PKCONSTANTE.EXERROR_LEVEL2;

            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR
                (
                    PKERRORS.FSBLASTOBJECT,
                    SQLERRM,
                    IC_BOGENCARTCOMPCONC.SBERRMSG
                );
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR
                (
                    PKCONSTANTE.NUERROR_LEVEL2,
                    IC_BOGENCARTCOMPCONC.SBERRMSG
                );
        END GETGEOGRAPLOCS;

        
























        PROCEDURE GETVOUCHERTYPE
        (
            INUCONSECUT     IN  CONSECUT.CONSCODI%TYPE,
            ONUVOUCHERTYPE  OUT NOCOPY NUMEAUTO.NUAUTICO%TYPE
        )
        IS
            
            
            
            
            RCCONSECUT  CONSECUT%ROWTYPE;

            
            RCNUMEAUTO  NUMEAUTO%ROWTYPE;

        BEGIN
            PKERRORS.PUSH('IC_BOGenCartCompConc.Process.GetVoucherType');

            
            IF ( INUCONSECUT IS NOT NULL ) THEN

                
                
                IF ( NOT TBTIPOCOMP.EXISTS( INUCONSECUT ) ) THEN
                    
                    RCCONSECUT := PKTBLCONSECUT.FRCGETRECORD( INUCONSECUT );

                    
                    RCNUMEAUTO :=   PKTBLNUMEAUTO.FRCGETRECORD
                                    (
                                        RCCONSECUT.CONSNAUT
                                    );

                    
                    TBTIPOCOMP( INUCONSECUT ) := RCNUMEAUTO.NUAUTICO;

                END IF;

                
                ONUVOUCHERTYPE := TBTIPOCOMP( INUCONSECUT );

            ELSE
                
                ONUVOUCHERTYPE := NULL;
            END IF;

            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED THEN
                PKERRORS.POP;
                RAISE LOGIN_DENIED;

            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
                
                PKERRORS.POP;
                RAISE PKCONSTANTE.EXERROR_LEVEL2;

            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR
                (
                    PKERRORS.FSBLASTOBJECT,
                    SQLERRM,
                    IC_BOGENCARTCOMPCONC.SBERRMSG
                );
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR
                (
                    PKCONSTANTE.NUERROR_LEVEL2,
                    IC_BOGENCARTCOMPCONC.SBERRMSG
                );
        END GETVOUCHERTYPE;

        



























        PROCEDURE FILLTABLETODIST
        (
            IRCCHARGES      IN  PKCONCEPTVALUESMGR.TYRCCARGOSDIST,
            IOTBCHGSTODIST  IN  OUT NOCOPY PKCONCEPTVALUESMGR.TYTBCARGOSDIST
        )
        IS
            
            NUIDX       NUMBER;

        BEGIN
            PKERRORS.PUSH('IC_BOGenCartCompConc.Process.FillTableToDist');

            
            NUIDX := NVL(IOTBCHGSTODIST.LAST, 0) + 1;

            
            IOTBCHGSTODIST(NUIDX).CARGTERM := IRCCHARGES.CARGTERM;
            IOTBCHGSTODIST(NUIDX).CARGSIGN := IRCCHARGES.CARGSIGN;
            IOTBCHGSTODIST(NUIDX).CARGVALO := IRCCHARGES.CARGVALO;
            IOTBCHGSTODIST(NUIDX).CARGVABL := IRCCHARGES.CARGVABL;
            IOTBCHGSTODIST(NUIDX).CARGFECR := IRCCHARGES.CARGFECR;
            IOTBCHGSTODIST(NUIDX).CARGUNID := IRCCHARGES.CARGUNID;
            IOTBCHGSTODIST(NUIDX).CARGDOSO := IRCCHARGES.CARGDOSO;
            IOTBCHGSTODIST(NUIDX).CARGCODO := IRCCHARGES.CARGCODO;

            
            
            
            IF
            (
                (
                    IRCCHARGES.CARGSIGN = PKBILLCONST.APLSALDFAV
                    OR
                    IRCCHARGES.CARGSIGN = PKBILLCONST.SALDOFAVOR
                    OR
                    IRCCHARGES.CARGSIGN = PKBILLCONST.PAGO
                )
                AND
                IRCCHARGES.CARGFECR <= DTGENDATELASTSECOND
            ) THEN
                
                IOTBCHGSTODIST(NUIDX).CARGFLFA := PKCONSTANTE.SI;
            ELSE
                
                IOTBCHGSTODIST(NUIDX).CARGFLFA := PKCONSTANTE.NO;
            END IF;

            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED THEN
                PKERRORS.POP;
                RAISE LOGIN_DENIED;

            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
                
                PKERRORS.POP;
                RAISE PKCONSTANTE.EXERROR_LEVEL2;

            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR
                (
                    PKERRORS.FSBLASTOBJECT,
                    SQLERRM,
                    IC_BOGENCARTCOMPCONC.SBERRMSG
                );
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR
                (
                    PKCONSTANTE.NUERROR_LEVEL2,
                    IC_BOGENCARTCOMPCONC.SBERRMSG
                );
        END FILLTABLETODIST;

        

























        PROCEDURE MASSIVEINSERTION
        (
            IRCPORTFOLIO        IN  IC_CARTCOCO%ROWTYPE,
            ITBKEYS             IN  PKCONCEPTVALUESMGR.TYSTRING,
            ITBVALO             IN  PKCONCEPTVALUESMGR.TYNUMBER,
            ITBVABL             IN  PKCONCEPTVALUESMGR.TYNUMBER
        )
        IS
            
            
            
            
            SBIDX   VARCHAR2(100);
            
            
            NUIDX   NUMBER;

            
            RCCARGDATA      PKCONCEPTVALUESMGR.RTYDATAKEY;

        BEGIN
            PKERRORS.PUSH('IC_BOGenCartCompConc.Process.MassiveInsertion');

            
            SBIDX := ITBKEYS.FIRST;

            LOOP
                
                EXIT WHEN SBIDX IS NULL;

                
                PKCONCEPTVALUESMGR.DECODEKEY
                (
                    ITBKEYS( SBIDX ),
                    RCCARGDATA,
                    1,
                    0
                );

                
                IF ( ITBVALO( SBIDX ) <> 0 ) THEN

            		
                    NUIDX := NVL
                             (
                                 IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCONS.LAST,
                                 0
                              ) + 1;

                    
                    
                    
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCONS( NUIDX ) :=
                               PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL(CSBSEQUENCE);
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCATE( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCCATE;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCICL( NUIDX ) :=
                                                    RCCARGDATA.CARGCICL;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCLIE( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCCLIE;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCOMP( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCCOMP;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCONC( NUIDX ) :=
                                                    RCCARGDATA.CARGCONC;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCUCO( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCCUCO;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCESCO( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCESCO;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCFEGE( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCFEGE;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCFEVE( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCFEVE;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCNACA( NUIDX ) :=
                                        IC_BOGENCARTCOMPCONC.CSBNOT_DEF_PORTFOLIO;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCPLCA( NUIDX ) :=
                                        IC_BOGENCARTCOMPCONC.CSBSHORT_TERM;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCNUFI( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCNUFI;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCNUSE( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCNUSE;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCPREF( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCPREF;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCSAPE( NUIDX ) :=
                                                    ITBVALO( SBIDX );
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCSERV( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCSERV;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCSUCA( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCSUCA;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCSUSC( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCSUSC;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCVABL( NUIDX ) := NULL;

                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCIDCL( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCIDCL;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCTICL( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCTICL;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCTICO( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCTICO;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCUBG1( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCUBG1;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCUBG2( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCUBG2;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCUBG3( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCUBG3;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCUBG4( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCUBG4;
                    
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCUBG5( NUIDX ) :=
                                                    IRCPORTFOLIO.CACCUBG5;

                END IF;
                
                
                SBIDX := ITBKEYS.NEXT( SBIDX );

            END LOOP;

            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED THEN
                PKERRORS.POP;
                RAISE LOGIN_DENIED;

            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
                
                PKERRORS.POP;
                RAISE PKCONSTANTE.EXERROR_LEVEL2;

            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR
                (
                    PKERRORS.FSBLASTOBJECT,
                    SQLERRM,
                    IC_BOGENCARTCOMPCONC.SBERRMSG
                );
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR
                (
                    PKCONSTANTE.NUERROR_LEVEL2,
                    IC_BOGENCARTCOMPCONC.SBERRMSG
                );
        END MASSIVEINSERTION;
        
        



















        PROCEDURE LOADADDITIONALPAYMENTS
        (
            INUDIFECODI IN  CUOTEXTR.CUEXDIFE%TYPE,
            INUDIFECUPA IN  CUOTEXTR.CUEXNUME%TYPE
        )
        IS
            
            
            
            
            TBEXTRAQUOTAS   PKTBLCUOTEXTR.TYTBCUOTEXTR;

            
            RCCUOTEXTR      CUOTEXTR%ROWTYPE;

            
            NUIDX           NUMBER;

        BEGIN
            PKERRORS.PUSH
            (
                'IC_BOGenCartCompConc.Process.LoadAdditionalPayments'
            );

            
            PKADITIONALPAYMENTMGR.CLEARMEMORY;

            
            IC_BCGENCARTCOMPCONC.GETEXTRAPAYMTSBYDEF
            (
                INUDIFECODI,
                TBEXTRAQUOTAS
            );

            NUIDX := TBEXTRAQUOTAS.CUEXNUME.FIRST;

            LOOP
                
                EXIT WHEN NUIDX IS NULL;

                
                IF ( TBEXTRAQUOTAS.CUEXNUME( NUIDX ) > INUDIFECUPA ) THEN

                    
                    RCCUOTEXTR.CUEXDIFE := TBEXTRAQUOTAS.CUEXDIFE( NUIDX );
                    RCCUOTEXTR.CUEXVALO := TBEXTRAQUOTAS.CUEXVALO( NUIDX );
                    RCCUOTEXTR.CUEXCOBR := TBEXTRAQUOTAS.CUEXCOBR( NUIDX );
                    RCCUOTEXTR.CUEXNUME := TBEXTRAQUOTAS.CUEXNUME( NUIDX )
                                            - INUDIFECUPA;

                    
                    
                    PKADITIONALPAYMENTMGR.ADDRECORD( RCCUOTEXTR );
                END IF;
                
                NUIDX := TBEXTRAQUOTAS.CUEXNUME.NEXT( NUIDX );

            END LOOP;

            PKERRORS.POP;
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END LOADADDITIONALPAYMENTS;

        






















        PROCEDURE CALCULATEBALANCETERM
        (
            ITBCUOTAS   IN  PKDEFERREDMGR.TYTBCUOTAS,
            INUCUOTAINI IN  DIFERIDO.DIFENUCU%TYPE,
            INUCUOTAFIN IN  DIFERIDO.DIFENUCU%TYPE,
            ONUBALANCE    OUT NUMBER
        )
        IS
            
            
            
            
            NUIDX   NUMBER;

            
            NUBALANCE NUMBER;

        BEGIN
            PKERRORS.PUSH
            (
                'IC_BOGenCartCompConc.Process.CalculateBalanceTerm'
            );

            
            NUBALANCE := 0;

            
            NUIDX := INUCUOTAINI;

            LOOP
                
                
                
                IF
                (
                    NUIDX > INUCUOTAFIN
                    OR
                    NUIDX IS NULL
                    OR
                    NOT ITBCUOTAS.EXISTS( NUIDX )
                ) THEN
                    EXIT;
                END IF;

                
                NUBALANCE := NUBALANCE + ITBCUOTAS( NUIDX ).NUVLRCAPITAL +
                            ITBCUOTAS( NUIDX ).NUVLRCUOEXTR;

                
                NUIDX := ITBCUOTAS.NEXT( NUIDX );

            END LOOP;

            ONUBALANCE := NUBALANCE;

            PKERRORS.POP;
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END CALCULATEBALANCETERM;

        






































        PROCEDURE FILLTABLE
        (
            INUCACCNUSE IN  IC_CARTCOCO.CACCNUSE%TYPE,
            INUCACCCATE IN  IC_CARTCOCO.CACCCATE%TYPE,
            INUCACCCICL IN  IC_CARTCOCO.CACCCICL%TYPE,
            INUCACCCLIE IN  IC_CARTCOCO.CACCCLIE%TYPE,
            INUCACCESCO IN  IC_CARTCOCO.CACCESCO%TYPE,
            ISBCACCIDCL IN  IC_CARTCOCO.CACCIDCL%TYPE,
            INUCACCSERV IN  IC_CARTCOCO.CACCSERV%TYPE,
            INUCACCSUCA IN  IC_CARTCOCO.CACCSUCA%TYPE,
            INUCACCSUSC IN  IC_CARTCOCO.CACCSUSC%TYPE,
            INUCACCTICL IN  IC_CARTCOCO.CACCTICL%TYPE,
            INUCACCUBG1 IN  IC_CARTCOCO.CACCUBG1%TYPE,
            INUCACCUBG2 IN  IC_CARTCOCO.CACCUBG2%TYPE,
            INUCACCCONC IN  IC_CARTCOCO.CACCCONC%TYPE,
            IDTCACCFEGE IN  IC_CARTCOCO.CACCFEGE%TYPE,
            INUCACCSAPE IN  IC_CARTCOCO.CACCSAPE%TYPE,
            ISBCACCPLCA IN  IC_CARTCOCO.CACCPLCA%TYPE
        )
        IS
            
            
            
            
            NUIDX   NUMBER;
            
            
            NUCACCUBG1  IC_CARTCOCO.CACCUBG1%TYPE;
            NUCACCUBG2  IC_CARTCOCO.CACCUBG2%TYPE;
            NUCACCUBG3  IC_CARTCOCO.CACCUBG3%TYPE;
            NUCACCUBG4  IC_CARTCOCO.CACCUBG4%TYPE;
            NUCACCUBG5  IC_CARTCOCO.CACCUBG5%TYPE;


        BEGIN
            PKERRORS.PUSH
            (
                'IC_BOGenCartCompConc.Process.FillTable'
            );

            
            IF ( INUCACCSAPE <> 0 ) THEN

        		
                NUIDX := NVL
                         (
                             IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCONS.LAST,
                             0
                          ) + 1;
                          
                
                GETGEOGRAPLOCS
                (
                    INUCACCUBG1,
                    INUCACCUBG2,
                    NUCACCUBG1,
                    NUCACCUBG2,
                    NUCACCUBG3,
                    NUCACCUBG4,
                    NUCACCUBG5
                );

                
                
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCONS( NUIDX ) :=
                           PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL(CSBSEQUENCE);
                           
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCATE( NUIDX ) := INUCACCCATE;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCICL( NUIDX ) := INUCACCCICL;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCLIE( NUIDX ) := INUCACCCLIE;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCOMP( NUIDX ) := NULL;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCONC( NUIDX ) := INUCACCCONC;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCUCO( NUIDX ) := NULL;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCESCO( NUIDX ) := INUCACCESCO;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCFEGE( NUIDX ) := IDTCACCFEGE;
                
                
                IF( TBDETFEVE.EXISTS( INUCACCNUSE )) THEN
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCFEVE( NUIDX ) := TBDETFEVE(INUCACCNUSE);
                ELSE
                    TBDETFEVE(INUCACCNUSE) :=   IC_BCGENCARTCOMPCONC.OBTFECHAVENC
                                                (
                                                    INUCACCNUSE
                                                );
                    IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCFEVE( NUIDX ) := TBDETFEVE(INUCACCNUSE);
                END IF;
                    
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCNACA( NUIDX ) :=
                                    IC_BOGENCARTCOMPCONC.CSBDEF_PORTFOLIO;
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCPLCA( NUIDX ) := ISBCACCPLCA;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCNUFI( NUIDX ) := NULL;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCNUSE( NUIDX ) := INUCACCNUSE;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCPREF( NUIDX ) := NULL;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCSAPE( NUIDX ) := INUCACCSAPE;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCSERV( NUIDX ) := INUCACCSERV;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCSUCA( NUIDX ) := INUCACCSUCA;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCSUSC( NUIDX ) := INUCACCSUSC;

                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCVABL( NUIDX ) := NULL;

                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCIDCL( NUIDX ) := ISBCACCIDCL;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCTICL( NUIDX ) := INUCACCTICL;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCTICO( NUIDX ) := NULL;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCUBG1( NUIDX ) := NUCACCUBG1;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCUBG2( NUIDX ) := NUCACCUBG2;
                
                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCUBG3( NUIDX ) := NUCACCUBG3;

                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCUBG4( NUIDX ) := NUCACCUBG4;

                
                IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCUBG5( NUIDX ) := NUCACCUBG5;

            END IF;

            PKERRORS.POP;
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END FILLTABLE;
        
        




































        PROCEDURE CREATEMOVS
        (
            IDTDATE     IN      DATE,
            IRCDEFERRED IN      IC_BCGENCARTCOMPCONC.TYRCDEFERRED
        )
        IS
            
            
            
            
            TBQUOTAS    PKDEFERREDMGR.TYTBCUOTAS;

            
            NULIMITQUOTA NUMBER;

            
            NUBALANCE   NUMBER;
            NUINTERESRATE   NUMBER;
            NUNOMINALPERC   NUMBER;
            NUSPREAD        NUMBER;
            NUQUOTAVALUE    NUMBER;
            NUCUOTAS        NUMBER;

        BEGIN
            PKERRORS.PUSH('IC_BOGenCartCompConc.Process.CreateMovs');
            
            SAVEPOINT PROCESO_DIFERIDO;

            
            LOADADDITIONALPAYMENTS
            (
                IRCDEFERRED.DIFECODI,
                IRCDEFERRED.DIFECUPA 
            );

            
            IF (TBINTERESRATE.EXISTS(IRCDEFERRED.DIFETAIN)) THEN
               NUINTERESRATE := TBINTERESRATE(IRCDEFERRED.DIFETAIN);
            ELSE

                PKEFFECTIVEINTERESTRATEMGR.GETVALINTERESTRATE
                (
                    IRCDEFERRED.DIFETAIN,
                    0,
                    TRUNC (DTGENDATELASTSECOND),
                    NUINTERESRATE
                );

                TBINTERESRATE(IRCDEFERRED.DIFETAIN) := NUINTERESRATE;
            END IF;

            
            NUSPREAD := IRCDEFERRED.DIFESPRE;
            
            PKDEFERREDMGR.VALINTERESTSPREAD
            (
                IRCDEFERRED.DIFEMECA, 
                NUINTERESRATE,        
                NUSPREAD,             
                NUNOMINALPERC         
            );

            
            NUCUOTAS := IRCDEFERRED.DIFENUCU-IRCDEFERRED.DIFECUPA;
            PKDEFERREDMGR.CALCULATEPAYMENT
            (
                IRCDEFERRED.DIFESAPE, 
                NUCUOTAS,             
                NUNOMINALPERC,        
                IRCDEFERRED.DIFEMECA, 
                NUSPREAD,             
                NUINTERESRATE + IRCDEFERRED.DIFEFAGR, 
                NUQUOTAVALUE          
            );

            
            FA_BOPOLITICAREDONDEO.APLICAPOLITICA (IRCDEFERRED.DIFENUSE, NUQUOTAVALUE);

            
            PKDEFERREDMGR.STOREINSTALLMENTS
            (
                IRCDEFERRED.DIFENUSE, 
            	IRCDEFERRED.DIFEFEIN, 
            	IRCDEFERRED.DIFESAPE, 
            	NUINTERESRATE,        
            	IRCDEFERRED.DIFESPRE, 
            	IRCDEFERRED.DIFEMECA, 
            	NUQUOTAVALUE, 
            	NUCUOTAS, 
            	IRCDEFERRED.DIFESIGN, 
            	IRCDEFERRED.DIFEVATD, 
            	IRCDEFERRED.DIFEFAGR, 
            	TBQUOTAS              
            );

            
            
            IF ( TBQUOTAS.FIRST IS NULL ) THEN
                PKERRORS.POP;
                RETURN;
            END IF;

            
            NULIMITQUOTA := IC_BOGENCARTCOMPCONC.NUMESESPLAZO;

            
            CALCULATEBALANCETERM
            (
                TBQUOTAS,       
                TBQUOTAS.FIRST, 
                NULIMITQUOTA,   
                NUBALANCE       
            );

            
            IF ( NUBALANCE > 0 ) THEN

                
                FILLTABLE
                (
                    IRCDEFERRED.DIFENUSE,
                    IRCDEFERRED.SESUCATE,
                    IRCDEFERRED.SUSCCICL,
                    IRCDEFERRED.SUSCCLIE,
                    IRCDEFERRED.SESUESCO,
                    IRCDEFERRED.IDENTIFICATION,
                    IRCDEFERRED.SESUSERV,
                    IRCDEFERRED.SESUSUCA,
                    IRCDEFERRED.SESUSUSC,
                    IRCDEFERRED.SUBSCRIBER_TYPE_ID,
                    IRCDEFERRED.GEOGRAP_LOCATION_ID,
                    IRCDEFERRED.NEIGHBORTHOOD_ID,
                    IRCDEFERRED.DIFECONC,
                    IDTDATE,
                    NUBALANCE,
                    IC_BOGENCARTCOMPCONC.CSBSHORT_TERM
                );
            END IF;

            
            IF ( TBQUOTAS.LAST > NULIMITQUOTA ) THEN
                
                CALCULATEBALANCETERM
                (
                    TBQUOTAS,          
                    NULIMITQUOTA + 1, 
                    TBQUOTAS.LAST,     
                    NUBALANCE            
                );

                
                IF ( NUBALANCE > 0 ) THEN

                    
                    FILLTABLE
                    (
                        IRCDEFERRED.DIFENUSE,
                        IRCDEFERRED.SESUCATE,
                        IRCDEFERRED.SUSCCICL,
                        IRCDEFERRED.SUSCCLIE,
                        IRCDEFERRED.SESUESCO,
                        IRCDEFERRED.IDENTIFICATION,
                        IRCDEFERRED.SESUSERV,
                        IRCDEFERRED.SESUSUCA,
                        IRCDEFERRED.SESUSUSC,
                        IRCDEFERRED.SUBSCRIBER_TYPE_ID,
                        IRCDEFERRED.GEOGRAP_LOCATION_ID,
                        IRCDEFERRED.NEIGHBORTHOOD_ID,
                        IRCDEFERRED.DIFECONC,
                        IDTDATE,
                        NUBALANCE,
                        IC_BOGENCARTCOMPCONC.CSBLONG_TERM
                    );
                END IF;
            END IF;

            PKERRORS.POP;
        EXCEPTION
            WHEN OTHERS THEN
                PKERRORS.POP;
                ROLLBACK TO PROCESO_DIFERIDO;
                PROCESAINCONSISTENCIA(IRCDEFERRED.DIFECODI,IRCDEFERRED.DIFENUSE, IC_BOGENCARTCOMPCONC.CSBDEF_PORTFOLIO);
        END CREATEMOVS;

        


























        PROCEDURE PROCESSDEFERRED
        IS
            
            
            
            
            CSBPROC_FINAN   CONSTANT VARCHAR2(50) :=
                                        'Procesando cartera financiada...';

            
            
            
            
            NUPIVOT IC_CUENSALD.CUSADIFE%TYPE := -1;
            
            
            TBDEFERREDINFO  IC_BCGENCARTCOMPCONC.TYTBDEFERRED;
            
            
            NUIDX   NUMBER;
            
        BEGIN
            PKERRORS.PUSH('IC_BOGenCartCompConc.Process.ProcessDeferred');

            LOOP
            
                
                TBDEFERREDINFO.DELETE;
            
                
                IC_BCGENCARTCOMPCONC.GETDEFERREDINFO
                (
                    NUPIVOT,
                    IC_BOGENCARTCOMPCONC.CNULIMIT,
                    INUTHREAD,
                    INUTHREADS,
                    TBDEFERREDINFO
                );

                
                NUIDX := TBDEFERREDINFO.FIRST;

                LOOP
                    
                    EXIT WHEN NUIDX IS NULL;

                    CREATEMOVS
                    (
                        IDTGENDATE,
                        TBDEFERREDINFO( NUIDX )
                    );

                    
                    NUIDX := TBDEFERREDINFO.NEXT( NUIDX );

                END LOOP;
                
                
                IF ( IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCONS.COUNT > 0 ) THEN
                    PKTBLIC_CARTCOCO.INSRECORDS
                    (
                        IC_BOGENCARTCOMPCONC.TBPORTFOLIO
                    );
                END IF;

                
                PKGENERALSERVICES.COMMITTRANSACTION;

                
                DELTEMPTABLE;
                
                NUPARTIALSTEP := NUPARTIALSTEP + TBDEFERREDINFO.COUNT;

                
                PKSTATUSEXEPROGRAMMGR.UPSTATUSEXEPROGRAMAT
                (
                    ISBPROCSTATUS,
                    CSBPROC_FINAN,
                    NUTOTALSTEP,
                    NUPARTIALSTEP
                );
            
                


                EXIT WHEN TBDEFERREDINFO.COUNT < IC_BOGENCARTCOMPCONC.CNULIMIT;
                
                
                NUPIVOT := TBDEFERREDINFO(TBDEFERREDINFO.LAST).DIFECODI;
                
            END LOOP;

            
            PKGENERALSERVICES.COMMITTRANSACTION;
                
            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED THEN
                PKERRORS.POP;
                RAISE LOGIN_DENIED;

            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
                
                PKERRORS.POP;
                RAISE PKCONSTANTE.EXERROR_LEVEL2;

            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR
                (
                    PKERRORS.FSBLASTOBJECT,
                    SQLERRM,
                    IC_BOGENCARTCOMPCONC.SBERRMSG
                );
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR
                (
                    PKCONSTANTE.NUERROR_LEVEL2,
                    IC_BOGENCARTCOMPCONC.SBERRMSG
                );
        END PROCESSDEFERRED;

        




















        PROCEDURE PROCESSACCOUNT
        (
            IRCACCOUNTINFO  IN  IC_BCGENCARTCOMPCONC.TYRCACCOUNTS
        )
        IS
            
            
            
            
            NUNUAUTICO  NUMEAUTO.NUAUTICO%TYPE;
            
            
            NUUBGEO1    GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE;
            NUUBGEO2    GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE;
            NUUBGEO3    GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE;
            NUUBGEO4    GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE;
            NUUBGEO5    GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE;
            
            
            TBCHARGES   PKCONCEPTVALUESMGR.TYTBCARGOSDIST;
            
            
            NUIDX       NUMBER;

            
            RCPORTFOLIO IC_CARTCOCO%ROWTYPE;

            
            TBCHARGESTODIST PKCONCEPTVALUESMGR.TYTBCARGOSDIST;

            
            TBKEYS          PKCONCEPTVALUESMGR.TYSTRING;
            
            TBVALO          PKCONCEPTVALUESMGR.TYNUMBER;
            
            TBVABL          PKCONCEPTVALUESMGR.TYNUMBER;
            
        BEGIN
            PKERRORS.PUSH('IC_BOGenCartCompConc.Process.ProcessAccount');

            SAVEPOINT PROCESO_CUENTA;

            
            GETVOUCHERTYPE
            (
                IRCACCOUNTINFO.FACTCONF,
                NUNUAUTICO
            );
            
            
            GETGEOGRAPLOCS
            (
                IRCACCOUNTINFO.CACCUBG1,
                IRCACCOUNTINFO.CACCUBG2,
                NUUBGEO1,
                NUUBGEO2,
                NUUBGEO3,
                NUUBGEO4,
                NUUBGEO5
            );

            
            
            
            
    		RCPORTFOLIO.CACCNACA := IC_BOGENCARTCOMPCONC.CSBNOT_DEF_PORTFOLIO;
    		
    		RCPORTFOLIO.CACCTICL := IRCACCOUNTINFO.CACCTICL;
    		
    		RCPORTFOLIO.CACCIDCL := IRCACCOUNTINFO.CACCIDCL;
    		
    		RCPORTFOLIO.CACCCLIE := IRCACCOUNTINFO.CACCCLIE;
    		
    		RCPORTFOLIO.CACCSUSC := IRCACCOUNTINFO.CACCSUSC;
    		
    		RCPORTFOLIO.CACCSERV := IRCACCOUNTINFO.CACCSERV;
    		
    		RCPORTFOLIO.CACCNUSE := IRCACCOUNTINFO.CACCNUSE;
    		
    		RCPORTFOLIO.CACCESCO := IRCACCOUNTINFO.CACCESCO;
    		
    		RCPORTFOLIO.CACCUBG1 := NUUBGEO1;
    		
    		RCPORTFOLIO.CACCUBG2 := NUUBGEO2;
    		
    		RCPORTFOLIO.CACCUBG3 := NUUBGEO3;
    		
    		RCPORTFOLIO.CACCUBG4 := NUUBGEO4;
    		
    		RCPORTFOLIO.CACCUBG5 := NUUBGEO5;
    		
    		RCPORTFOLIO.CACCCATE := IRCACCOUNTINFO.CACCCATE;
    		
    		RCPORTFOLIO.CACCSUCA := IRCACCOUNTINFO.CACCSUCA;
    		
    		RCPORTFOLIO.CACCTICO := NUNUAUTICO;
    		
    		RCPORTFOLIO.CACCPREF := IRCACCOUNTINFO.CACCPREF;
    		
    		RCPORTFOLIO.CACCNUFI := IRCACCOUNTINFO.CACCNUFI;
    		
    		RCPORTFOLIO.CACCCOMP := IRCACCOUNTINFO.CACCCOMP;
    		
    		RCPORTFOLIO.CACCCUCO := IRCACCOUNTINFO.CACCCUCO;
    		
    		RCPORTFOLIO.CACCFEVE := IRCACCOUNTINFO.CACCFEVE;
    		
    		RCPORTFOLIO.CACCFEGE := IDTGENDATE;

            
            IC_BCGENCARTCOMPCONC.GETCHARGES
            (
                IRCACCOUNTINFO.CACCCUCO,
                DTGENDATELASTSECOND,
                TBCHARGES
            );
            
            NUIDX := TBCHARGES.FIRST;

            
            IF ( NUIDX IS NOT NULL ) THEN

                
                
                LOOP
                    EXIT WHEN NUIDX IS NULL;

                    
                    FILLTABLETODIST
                    (
                        TBCHARGES( NUIDX ),
                        TBCHARGESTODIST
                    );

                    
                    NUIDX := TBCHARGES.NEXT( NUIDX );

                END LOOP;

                
                PKCONCEPTVALUESMGR.GETBALANCEBYCONC
                (
                    RCPORTFOLIO.CACCNUSE,
                    TBCHARGESTODIST,
                    TBKEYS,
                    TBVALO,
                    TBVABL,
                    1,
                    0,
                    FALSE
                );

                
                MASSIVEINSERTION
                (
                    RCPORTFOLIO,
                    TBKEYS,
                    TBVALO,
                    TBVABL
                );

            END IF;
            
            PKERRORS.POP;
        EXCEPTION
            WHEN OTHERS THEN
                PKERRORS.POP;
                ROLLBACK TO PROCESO_CUENTA;
                PROCESAINCONSISTENCIA(IRCACCOUNTINFO.CACCCUCO,IRCACCOUNTINFO.CACCNUSE,IC_BOGENCARTCOMPCONC.CSBNOT_DEF_PORTFOLIO);
        END PROCESSACCOUNT;

        













        PROCEDURE PROCESSPORTFOLIO
        IS
            
            
            
            

            CSBPROC_NO_FINAN CONSTANT VARCHAR2(50) :=
                                        'Procesando cartera no financiada...';
            
            
            
            
            
            TBACCOUNTS  IC_BCGENCARTCOMPCONC.TYTBACCOUNTS;
            
            
            NUPIVOTACC  IC_CUENSALD.CUSACUCO%TYPE := -1;
            
            
            NUIDX       NUMBER;

        BEGIN
            PKERRORS.PUSH('IC_BOGenCartCompConc.Process.ProcessPortfolio');
            
            
            NUPARTIALSTEP := CNUZERO;
            
            
            TBDETFEVE := TBDETFEVENULL;
            
            
            LOOP
                
                TBACCOUNTS.DELETE;

                
                IC_BCGENCARTCOMPCONC.GETACCOUNTS
                (
                    NUPIVOTACC,
                    INUTHREAD,
                    INUTHREADS,
                    IC_BOGENCARTCOMPCONC.CNULIMIT,
                    TBACCOUNTS
                );

                
                NUIDX := TBACCOUNTS.FIRST;

                LOOP
                    
                    EXIT WHEN NUIDX IS NULL;

                    PKGENERALSERVICES.TRACEDATA('Account: '||TBACCOUNTS( NUIDX ).CACCCUCO);

                    
                    PROCESSACCOUNT( TBACCOUNTS( NUIDX ) );

                    
                    NUIDX := TBACCOUNTS.NEXT( NUIDX );

                END LOOP;

                
                IF ( IC_BOGENCARTCOMPCONC.TBPORTFOLIO.CACCCONS.COUNT > 0 ) THEN
                    PKTBLIC_CARTCOCO.INSRECORDS
                    (
                        IC_BOGENCARTCOMPCONC.TBPORTFOLIO
                    );
                END IF;
                
                
                PKGENERALSERVICES.COMMITTRANSACTION;
                
                
                DELTEMPTABLE;

                
                NUPARTIALSTEP := NUPARTIALSTEP + TBACCOUNTS.COUNT;

                
                PKSTATUSEXEPROGRAMMGR.UPSTATUSEXEPROGRAMAT
                (
                    ISBPROCSTATUS,
                    CSBPROC_NO_FINAN,
                    NUTOTALSTEP,
                    NUPARTIALSTEP
                );

                
                EXIT WHEN TBACCOUNTS.COUNT < IC_BOGENCARTCOMPCONC.CNULIMIT;

                
                NUPIVOTACC := TBACCOUNTS(TBACCOUNTS.LAST).CACCCUCO;

            END LOOP;
            
            
            PROCESSDEFERRED;

            
            PKGENERALSERVICES.COMMITTRANSACTION;

            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED THEN
                PKERRORS.POP;
                RAISE LOGIN_DENIED;

            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
                
                PKERRORS.POP;
                RAISE PKCONSTANTE.EXERROR_LEVEL2;

            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR
                (
                    PKERRORS.FSBLASTOBJECT,
                    SQLERRM,
                    IC_BOGENCARTCOMPCONC.SBERRMSG
                );
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR
                (
                    PKCONSTANTE.NUERROR_LEVEL2,
                    IC_BOGENCARTCOMPCONC.SBERRMSG
                );
        END PROCESSPORTFOLIO;

    BEGIN
        PKERRORS.PUSH('IC_BOGenCartCompConc.Process');
        
        
        GETPARAMETERS;

        
        INITIALIZE;

        
        PROCESSPORTFOLIO;
        
        
        IC_BOGENCARTCOMPCONC.FINALIZECONCURRENCECTRL( IDTGENDATE );

        
        PKSTATUSEXEPROGRAMMGR.PROCESSFINISHOKAT
        (
            ISBPROCSTATUS
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
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
    END PROCESS;
    
    


















    PROCEDURE VALPROCESS
    (
        IDTINITDATE     IN  DATE,
        IDTFINALDATE    IN  DATE
    )
    IS
        
        
        
        
        DTCURRENT   DATE;
        
    BEGIN
        PKERRORS.PUSH('IC_BOGenCartCompConc.ValProcess');
        
        DTCURRENT := IDTINITDATE;
        
        LOOP
            
            EXIT WHEN DTCURRENT > IDTFINALDATE;

            
            PKBOPROCESSCONCURRENCECTRL.VALIDATECONCURRENCE
            (
                TO_CHAR( DTCURRENT, IC_BOGENCARTCOMPCONC.CSBDATE_FORMAT),
                IC_BOGENCARTCOMPCONC.CSBGENERATION_PROCESS,
                IC_BOGENCARTCOMPCONC.CSBROLLBACK_PROCESS
            );

            
            DTCURRENT := DTCURRENT + 1;
        END LOOP;

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
    END VALPROCESS;

    


















    PROCEDURE VALEXECUTION
    (
        IDTINITIALDATE  IN  DATE,
        IDTFINALDATE    IN  DATE
    )
    IS
        
        
        
        CNUERROR    CONSTANT GE_ERROR_LOG.ERROR_LOG_ID%TYPE := 901728;
        
        
        
        
        DTCURRENT       DATE;
        
        
        SBPARAMETER     CONCPROC.COPRPARA%TYPE;
        
        
        BOGENERATION    BOOLEAN;
        
        
        BOROLLBACK      BOOLEAN;
        
    BEGIN
        PKERRORS.PUSH('IC_BOGenCartCompConc.ValExecution');

        DTCURRENT := IDTINITIALDATE;

        LOOP
            
            EXIT WHEN DTCURRENT > IDTFINALDATE;
            
            SBPARAMETER :=  TO_CHAR
                            (
                                DTCURRENT,
                                IC_BOGENCARTCOMPCONC.CSBDATE_FORMAT
                            );

            
            PKBOPROCESSCONCURRENCECTRL.VALEXECUTEPROCESS
            (
                IC_BOGENCARTCOMPCONC.CSBGENERATION_PROCESS||CSBDUMMY,
                IC_BOGENCARTCOMPCONC.CSBROLLBACK_PROCESS,
                SBPARAMETER
            );
            
            
            BOGENERATION := PKBCCONCPROC.FBLFINISHEDPROCESS
                            (
                                SBPARAMETER,
                                IC_BOGENCARTCOMPCONC.CSBGENERATION_PROCESS ||
                                    CSBDUMMY
                            );
                            
            
            IF ( BOGENERATION ) THEN

                
                BOROLLBACK := PKBCCONCPROC.FBLFINISHEDREVERSE
                                (
                                    SBPARAMETER,
                                    IC_BOGENCARTCOMPCONC.CSBGENERATION_PROCESS||
                                        CSBDUMMY,
                                    IC_BOGENCARTCOMPCONC.CSBROLLBACK_PROCESS
                                );
            END IF;
            
            
            IF ( (NOT BOGENERATION) OR BOROLLBACK ) THEN
            
                
                ERRORS.SETERROR
                (
                    CNUERROR,
                    SBPARAMETER
                );
                
                RAISE LOGIN_DENIED;
            
            END IF;

            
            DTCURRENT := DTCURRENT + 1;
        END LOOP;
        
        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
    END VALEXECUTION;

    





















    PROCEDURE VALPRECONDITIONS
    (
        IDTPORTFDATE    IN  DATE,
        INUDELAYDAYS    IN  NUMBER,
        ISBFREQUENCY    IN  VARCHAR2,
        OSBPROCESSDATE  OUT VARCHAR2
    )
    IS
        
        
        
        
        DTPROCESSDATE   DATE;
        
    BEGIN
        PKERRORS.PUSH('IC_BOGenCartCompConc.ValPreConditions');

        
        IC_BOGENCARTCOMPCONC.GETPROCESSDATE
        (
            IDTPORTFDATE,
            INUDELAYDAYS,
            DTPROCESSDATE
        );

        
        IC_BOGENCARTCOMPCONC.VALINPUTDATA
        (
            DTPROCESSDATE
        );

        
        IC_BOGENCARTCOMPCONC.VALFREQUENCY
        (
            IDTPORTFDATE,
            INUDELAYDAYS,
            ISBFREQUENCY
        );

        
        IC_BOGENCARTCOMPCONC.VALIDATECONCURRENCE
        (
            DTPROCESSDATE
        );
        
        
        IC_BOGENCARTCOMPCONC.VALBASICDATA
        (
            DTPROCESSDATE
        );

        
        OSBPROCESSDATE := TO_CHAR(DTPROCESSDATE, FSBFMTODATE);

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
    END VALPRECONDITIONS;

    

























    PROCEDURE GENACCOUNTSBALANCE
    (
        IDTPORTFDATE    IN  DATE
    )
    IS
        
        
        
        
        CSBCUENCOSA CONSTANT VARCHAR2(15) := 'IC_CUENSALD';
        
        
        CNUMAX_DIST CONSTANT NUMBER := 9999;
        
        
        CSBSENTENCE CONSTANT CONCPROC.COPRSEEJ%TYPE
                                    := 'IC_BOGenCartCompConc.GenAccountsBalance';

        
        CSBPROCESS  CONSTANT VARCHAR2(10) := 'ICBGIC-GEN';

        
        
        
        
        DTLASTGENDATE   IC_CARTCOCO.CACCFEGE%TYPE;
        
        
        NUDISTFROMLASTEXEC  NUMBER;
        
        
        NUDISTTOCURRENTDATE NUMBER;
        
        
        DTPORFDATELASTSEC   DATE;
        
        
        DTGENDATELASTSECOND DATE;
        
    BEGIN
        PKERRORS.PUSH('IC_BOGenCartCompConc.GenAccountsBalance');
        
        
        GETPARAMETERS;
        
        
        PKERRORS.SETAPPLICATION(CSBPROCESS);

        
        IC_BOGENCARTCOMPCONC.INITCONCURRENCECTRL
        (
            IDTPORTFDATE,
            CSBSENTENCE
        );
        
        
        
        PKGENERALSERVICES.TABLETRUNCATE(CSBCUENCOSA);

        
        DTLASTGENDATE := IC_BOGENCARTCOMPCONC.FDTLASTDATE;
        
        
        DTGENDATELASTSECOND :=  TO_DATE
                                (
                                    TO_CHAR
                                    (
                                        IDTPORTFDATE,
                                        IC_BOGENCARTCOMPCONC.CSBDATE_FORMAT
                                    ) || IC_BOGENCARTCOMPCONC.CSBLAST_DAY_SEC,
                                    IC_BOGENCARTCOMPCONC.CSBCOMPL_DATE_FORMAT
                                );
        
        




        
        
        IF ( DTLASTGENDATE IS NOT NULL) THEN
            NUDISTFROMLASTEXEC := IDTPORTFDATE - DTLASTGENDATE;
        ELSE
            NUDISTFROMLASTEXEC := CNUMAX_DIST;
        END IF;
        
        
        NUDISTTOCURRENTDATE := TRUNC(SYSDATE) - IDTPORTFDATE;
        
        IF ( NUDISTTOCURRENTDATE <= NUDISTFROMLASTEXEC ) THEN
        
            
            DTPORFDATELASTSEC := TO_DATE
                                    (
                                        TO_CHAR
                                        (
                                            IDTPORTFDATE,
                                            IC_BOGENCARTCOMPCONC.CSBDATE_FORMAT
                                        ) || IC_BOGENCARTCOMPCONC.CSBLAST_DAY_SEC,
                                        IC_BOGENCARTCOMPCONC.CSBCOMPL_DATE_FORMAT
                                    );
        
            
            IC_BCGENCARTCOMPCONC.GENACCOUNTSBALSYSDATE
            (
                IDTPORTFDATE,
                DTPORFDATELASTSEC
            );
        ELSE
            
            
            IC_BCGENCARTCOMPCONC.GENACCOUNTSBALPASTPORT
            (
                IDTPORTFDATE,
                DTLASTGENDATE,
                IC_BOGENCARTCOMPCONC.CSBNOT_DEF_PORTFOLIO
            );
        END IF;

        
        IC_BCGENCARTCOMPCONC.GENDEFERREDINFO
        (
            DTGENDATELASTSECOND,
            IC_BOGENCARTCOMPCONC.SBDEPOSITRECTYPE
        );

        
        PKGENERALSERVICES.COMMITTRANSACTION;

        
        IC_BOGENCARTCOMPCONC.FINALIZECONCURRENCECTRL( IDTPORTFDATE );

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
    END GENACCOUNTSBALANCE;
    
    
















    FUNCTION FDTLASTDATE
        RETURN DATE
    IS
        
        
        
        
        DTMAXDATE   DATE := SYSDATE;
        
        
        BOEXECUTION BOOLEAN := TRUE;
        
    BEGIN
        PKERRORS.PUSH('IC_BOGenCartCompConc.fdtLastDate');

        LOOP
            EXIT WHEN NOT BOEXECUTION;

            
            DTMAXDATE := PKBCCONCPROC.FDTMAXDATEPARAMETER
                         (
                             IC_BOGENCARTCOMPCONC.CSBGENERATION_PROCESS||
                                IC_BOGENCARTCOMPCONC.CSBDUMMY,
                             IC_BOGENCARTCOMPCONC.CSBROLLBACK_PROCESS,
                             DTMAXDATE
                         );

            
            BOEXECUTION :=  PKBCCONCPROC.FBONOTFINISHEDPROCESS
                            (
                                IC_BOGENCARTCOMPCONC.CSBGENERATION_PROCESS||
                                    IC_BOGENCARTCOMPCONC.CSBDUMMY,
                                TO_CHAR
                                (
                                    DTMAXDATE,
                                    IC_BOGENCARTCOMPCONC.CSBDATE_FORMAT
                                )
                            );

        END LOOP;


        PKERRORS.POP;
        
        
        RETURN DTMAXDATE;
        
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                IC_BOGENCARTCOMPCONC.SBERRMSG
            );
            RETURN NULL;
    END FDTLASTDATE;
    
END IC_BOGENCARTCOMPCONC;