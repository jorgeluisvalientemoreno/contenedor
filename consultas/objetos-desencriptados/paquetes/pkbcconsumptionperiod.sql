PACKAGE BODY pkBCConsumptionPeriod
IS









































































    
    
    

    
    TYPE TYTRCPERIOF                        IS TABLE OF PERICOSE%ROWTYPE
                                            INDEX BY VARCHAR2(100);

    
    
    
    
    
    CSBVERSION   CONSTANT VARCHAR2(250) := 'SAO226208';

    
    
    

    SBERRMSG	  GE_ERROR_LOG.DESCRIPTION%TYPE;   
    BLISLOADED    BOOLEAN:=FALSE ;	    
    
    
    GTRCPERICOSE                            TYTRCPERIOF;
    
    
    GNUPRODUCT                              SERVSUSC.SESUNUSE%TYPE;

    
    GNUBILLPERIOD                           PERIFACT.PEFACODI%TYPE;

    
    GRCCONSUMPERIOD                         PERICOSE%ROWTYPE;
    
    
    CNUMSG_NO_PERIODO_CURRENT               CONSTANT NUMBER := 10582 ;

    
    CSBLABEL_CICLO                          CONSTANT VARCHAR2 (6) := 'CICLOC';

    
    CSBLABEL_PERIODO                        CONSTANT VARCHAR2 (8) := 'PERIODOF';

    
    
    
    CURSOR CUPREVIOUSPERIOD(INUCYCLE  IN  PERICOSE.PECSCICO%TYPE,
                            IDTDATE   IN  PERICOSE.PECSFECI%TYPE ) IS
     SELECT --+ index_desc (pericose IX_PERICOSE01)
           PECSCONS
      FROM  PERICOSE
     WHERE PECSCICO = INUCYCLE
       AND PECSFECI < IDTDATE;
    
    
    
    

    
    
    

























FUNCTION FSBVERSION
RETURN VARCHAR2
IS

BEGIN


    
    RETURN ( CSBVERSION );

EXCEPTION
    WHEN LOGIN_DENIED THEN
	RAISE LOGIN_DENIED;

    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
	
	RAISE PKCONSTANTE.EXERROR_LEVEL2;

    WHEN OTHERS THEN
	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);

END FSBVERSION;


































PROCEDURE GETPREVMONTHYEAR(INUCYCLE    IN   CICLCONS.CICOCODI%TYPE,
                           IDTDATE     IN   PERICOSE.PECSFECI%TYPE,
                           ONUANO      OUT  PERIFACT.PEFAANO%TYPE,
                           ONUMES      OUT  PERIFACT.PEFAMES%TYPE,
                           INUCICLFACT IN   CICLO.CICLCODI%TYPE,
                           ISBTIPOCOBR IN   SERVICIO.SERVTICO%TYPE
                           )
IS

    NUPERICOSE      PERICOSE.PECSCONS%TYPE;
    NUPEFACODI      PERIFACT.PEFACODI%TYPE;
    RCPERIFACT      PERIFACT%ROWTYPE;
    
    

BEGIN

    
    
    OPEN CUPREVIOUSPERIOD(INUCYCLE, IDTDATE) ;
    
    FETCH CUPREVIOUSPERIOD INTO NUPERICOSE;
    
    CLOSE CUPREVIOUSPERIOD;
    
    
    PKBCPERIFACT.GETBILLPERBYCONSPER(INUCICLFACT,NUPERICOSE,NUPEFACODI,ISBTIPOCOBR);
    
    
    RCPERIFACT := PKTBLPERIFACT.FRCGETRECORD(NUPEFACODI);
    
    
    ONUANO := RCPERIFACT.PEFAANO;
    ONUMES := RCPERIFACT.PEFAMES;

EXCEPTION
    WHEN LOGIN_DENIED THEN
    CLOSE CUPREVIOUSPERIOD;
	RAISE LOGIN_DENIED;

    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
	
    CLOSE CUPREVIOUSPERIOD;
	RAISE PKCONSTANTE.EXERROR_LEVEL2;

    WHEN OTHERS THEN
	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
    CLOSE CUPREVIOUSPERIOD;
	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);

END GETPREVMONTHYEAR;

























FUNCTION  FDTLASTRATEDPERIOD
RETURN PERICOSE.PECSFECF%TYPE
IS
    CSBFGCA      CONSTANT VARCHAR2(4) := 'FGCA';
    CSBFPVO      CONSTANT VARCHAR2(4) := 'FPVO';

    DTRETORNO    PERICOSE.PECSFECF%TYPE;
    
    CURSOR CULASTDATE IS
    SELECT MAX(PEFAFIMO)
    FROM PERIFACT, PROCEJEC
    WHERE PEFACODI = PREJCOPE
      AND PREJPROG IN (CSBFGCA, CSBFPVO);
BEGIN


    IF (CULASTDATE%ISOPEN) THEN
        CLOSE CULASTDATE;
    END IF;
    
    OPEN CULASTDATE;
    
    FETCH CULASTDATE INTO DTRETORNO;
    
    CLOSE CULASTDATE;

    
    RETURN ( DTRETORNO );

EXCEPTION
    WHEN LOGIN_DENIED THEN
    CLOSE CULASTDATE;
	RAISE LOGIN_DENIED;

    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
	
    CLOSE CULASTDATE;
	RAISE PKCONSTANTE.EXERROR_LEVEL2;

    WHEN OTHERS THEN
	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
    CLOSE CULASTDATE;
	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);

END FDTLASTRATEDPERIOD;























FUNCTION  FRCGETNOTPROCESS
(
    INUYEAR  IN  PERIFACT.PEFAANO%TYPE,
    INUMONTH  IN  PERIFACT.PEFAMES%TYPE
)
RETURN PKCONSTANTE.TYREFCURSOR
IS
    CRRECORD PKCONSTANTE.TYREFCURSOR;
    SBNO VARCHAR2(1) := PKCONSTANTE.NO;
    SBINITDATE VARCHAR2(15);
BEGIN
    
    SBINITDATE := '01-'||INUMONTH||'-'||INUYEAR;

    
    OPEN CRRECORD FOR
        SELECT PECSCONS, PECSFECI, PECSFECF, PECSCICO,
            DECODE(PECSCICO, NULL, ' ', PKTBLCICLCONS.FSBGETDESCRIPTION(PECSCICO)) DESCRIPTION
        FROM PERICOSE
            WHERE
            PECSFLAV =SBNO
            AND PECSFECF >= TO_DATE(SBINITDATE, UT_DATE.FSBDATE_FORMAT)
            AND PECSFECF <=  LAST_DAY(TO_DATE(SBINITDATE, UT_DATE.FSBDATE_FORMAT))
            ORDER BY PECSCONS;

    RETURN CRRECORD;

EXCEPTION
    WHEN LOGIN_DENIED THEN
	RAISE LOGIN_DENIED;

    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
	
	RAISE PKCONSTANTE.EXERROR_LEVEL2;

    WHEN OTHERS THEN
	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
END FRCGETNOTPROCESS;
























FUNCTION  FBLEXISTNOTPROCPERIOD
(
    INUYEAR  IN  PERIFACT.PEFAANO%TYPE,
    INUMONTH  IN  PERIFACT.PEFAMES%TYPE
)
RETURN BOOLEAN
IS
    CRRECORD PKCONSTANTE.TYREFCURSOR;
    SBNO VARCHAR2(1) := PKCONSTANTE.NO;
    SBINITDATE VARCHAR2(15);
    RCPERIODNOTPROCESS TYRCPERIODNOTPROCESS ;
BEGIN
    
    SBINITDATE := '01-'||INUMONTH||'-'||INUYEAR;


    OPEN CRRECORD FOR
        SELECT PECSCONS, PECSFECI, PECSFECF, PECSCICO,
            DECODE(PECSCICO, NULL, ' ', PKTBLCICLCONS.FSBGETDESCRIPTION(PECSCICO)) DESCRIPTION
        FROM PERICOSE
            WHERE
            PECSFLAV =SBNO
            AND PECSFECF >= TO_DATE(SBINITDATE, UT_DATE.FSBDATE_FORMAT)
            AND PECSFECF <=  LAST_DAY(TO_DATE(SBINITDATE, UT_DATE.FSBDATE_FORMAT))
            AND ROWNUM = 1;

      FETCH CRRECORD INTO   RCPERIODNOTPROCESS;
      
      IF  CRRECORD%NOTFOUND THEN
          RETURN FALSE;
      END IF;

    RETURN TRUE;

EXCEPTION
    WHEN LOGIN_DENIED THEN
	RAISE LOGIN_DENIED;

    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
	
	RAISE PKCONSTANTE.EXERROR_LEVEL2;

    WHEN OTHERS THEN
	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
END FBLEXISTNOTPROCPERIOD;























FUNCTION  FRCGETNOTPROCESSLOST
(
    INUYEAR  IN  PERIFACT.PEFAANO%TYPE,
    INUMONTH  IN  PERIFACT.PEFAMES%TYPE
)
RETURN PKCONSTANTE.TYREFCURSOR
IS
    CRRECORD PKCONSTANTE.TYREFCURSOR;
    SBNO VARCHAR2(1) := PKCONSTANTE.NO;
    SBINITDATE VARCHAR2(15);
    NUCOMPANY NUMBER;
BEGIN
    
    PKERRORS.PUSH ('pkBCConsumptionPeriod.frcGetNotProcess');

    SBINITDATE := '01-'||INUMONTH||'-'||INUYEAR;

    NUCOMPANY := SA_BOSYSTEM.FNUGETUSERCOMPANYID;

    OPEN CRRECORD FOR
        SELECT PERICOSE.PECSCONS, PERICOSE.PECSFECI, PERICOSE.PECSFECF, PERICOSE.PECSCICO, CICLCONS.CICODESC
        FROM PERICOSE, CICLCONS
        WHERE PERICOSE.PECSFLAV =SBNO
            AND PERICOSE.PECSFECF >= TO_DATE(SBINITDATE, UT_DATE.FSBDATE_FORMAT)
            AND PERICOSE.PECSFECF <=  LAST_DAY(TO_DATE(SBINITDATE, UT_DATE.FSBDATE_FORMAT))
            AND CICLCONS.CICOSIST = NUCOMPANY
            AND CICLCONS.CICOCODI = PERICOSE.PECSCICO
            ORDER BY PECSCONS;

    PKERRORS.POP;
    RETURN CRRECORD;

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
END FRCGETNOTPROCESSLOST;

























FUNCTION  FBLEXISTNOTPROCPERIODLOST
(
    INUYEAR  IN  PERIFACT.PEFAANO%TYPE,
    INUMONTH  IN  PERIFACT.PEFAMES%TYPE
)
RETURN BOOLEAN
IS
    CRRECORD PKCONSTANTE.TYREFCURSOR;
    SBNO VARCHAR2(1) := PKCONSTANTE.NO;
    SBINITDATE VARCHAR2(15);
    RCPERIODNOTPROCESS TYRCPERIODNOTPROCESS;
    NUCOMPANY NUMBER;
BEGIN
    
    PKERRORS.PUSH ('pkBCConsumptionPeriod.frcGetNotProcess');

    SBINITDATE := '01-'||INUMONTH||'-'||INUYEAR;

    NUCOMPANY := SA_BOSYSTEM.FNUGETUSERCOMPANYID;
    
    OPEN CRRECORD FOR
        SELECT PERICOSE.PECSCONS, PERICOSE.PECSFECI, PERICOSE.PECSFECF, PERICOSE.PECSCICO, CICLCONS.CICODESC
        FROM PERICOSE, CICLCONS
        WHERE PERICOSE.PECSFLAV =SBNO
            AND PERICOSE.PECSFECF >= TO_DATE(SBINITDATE, UT_DATE.FSBDATE_FORMAT)
            AND PERICOSE.PECSFECF <=  LAST_DAY(TO_DATE(SBINITDATE, UT_DATE.FSBDATE_FORMAT))
            AND CICLCONS.CICOSIST = NUCOMPANY
            AND CICLCONS.CICOCODI = PERICOSE.PECSCICO
            AND ROWNUM = 1;

      FETCH CRRECORD INTO RCPERIODNOTPROCESS;

      IF  CRRECORD%NOTFOUND THEN
          RETURN FALSE;
      END IF;

    PKERRORS.POP;
    RETURN TRUE;

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
END FBLEXISTNOTPROCPERIODLOST;


    
















    FUNCTION FRCGETNRPREVIOUSPERIOD
    (
        INUPRODUCT      IN SERVSUSC.SESUNUSE%TYPE,
        IDTINITIALDATE  IN PERICOSE.PECSFECI%TYPE
    )
    RETURN PERICOSE%ROWTYPE
    IS
        
        
        
        CURSOR CUPREVIOUSPERIOD IS
            SELECT PERICOSE.*
            FROM   PERICOSE, NR_ENLIENRE
            WHERE  PECSCONS = ELERPECO
            AND    PECSFECI < IDTINITIALDATE
            AND    ELERSESU = INUPRODUCT
            ORDER BY PECSFECI DESC;

        CURSOR CUPREVPERIODBYCYCLE( INUCYCLE IN PERICOSE.PECSCICO%TYPE ) IS
            SELECT *
            FROM   PERICOSE
            WHERE  PECSCICO = INUCYCLE
            AND    PECSFECI < IDTINITIALDATE
            ORDER BY PECSFECI DESC;
        
        
        
        RCPREVCONSPER PERICOSE%ROWTYPE;

    BEGIN

        
        IF CUPREVIOUSPERIOD%ISOPEN THEN
            CLOSE CUPREVIOUSPERIOD;
        END IF;

        
        OPEN  CUPREVIOUSPERIOD;
        FETCH CUPREVIOUSPERIOD INTO RCPREVCONSPER;
        CLOSE CUPREVIOUSPERIOD;

        IF RCPREVCONSPER.PECSCONS IS NULL THEN

            
            IF CUPREVPERIODBYCYCLE%ISOPEN THEN
                CLOSE CUPREVPERIODBYCYCLE;
            END IF;

            OPEN CUPREVPERIODBYCYCLE( PKTBLSERVSUSC.FNUGETCYCLE(INUPRODUCT) );
            FETCH CUPREVPERIODBYCYCLE INTO RCPREVCONSPER;
            CLOSE CUPREVPERIODBYCYCLE;

            IF RCPREVCONSPER.PECSCONS IS NULL THEN

                
                PKERRORS.SETERRORCODE( PKCONSTANTE.CSBDIVISION,
                                       PKCONSTANTE.CSBMOD_BIL,
                                       10750 );
                RAISE LOGIN_DENIED;

            END IF;

        END IF;

        RETURN RCPREVCONSPER;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            IF CUPREVIOUSPERIOD%ISOPEN THEN
                CLOSE CUPREVIOUSPERIOD;
            END IF;
            IF CUPREVPERIODBYCYCLE%ISOPEN THEN
                CLOSE CUPREVPERIODBYCYCLE;
            END IF;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            IF CUPREVIOUSPERIOD%ISOPEN THEN
                CLOSE CUPREVIOUSPERIOD;
            END IF;
            IF CUPREVPERIODBYCYCLE%ISOPEN THEN
                CLOSE CUPREVPERIODBYCYCLE;
            END IF;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            IF CUPREVIOUSPERIOD%ISOPEN THEN
                CLOSE CUPREVIOUSPERIOD;
            END IF;
            IF CUPREVPERIODBYCYCLE%ISOPEN THEN
                CLOSE CUPREVPERIODBYCYCLE;
            END IF;
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);

    END FRCGETNRPREVIOUSPERIOD;
































PROCEDURE OBTPERICONSPORPERIFACT
(
    INUPERIODOFACTURACION   IN  PERIFACT.PEFACODI%TYPE,
    INUCICLOCONSUMO         IN  PERICOSE.PECSCICO%TYPE,
    ONUPERIODOCONSUMO       OUT PERICOSE.PECSCONS%TYPE,
    ISBTIPOCOBR             IN  SERVICIO.SERVTICO%TYPE DEFAULT 'V'
)
IS


BEGIN

    PKBCPERICOSE.GETCONSPERBYBILLPER
    (
        INUCICLOCONSUMO,
        INUPERIODOFACTURACION,
        ONUPERIODOCONSUMO,
        ISBTIPOCOBR
    );

EXCEPTION
    WHEN LOGIN_DENIED THEN
        RAISE LOGIN_DENIED;

    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        RAISE PKCONSTANTE.EXERROR_LEVEL2;

    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);

END OBTPERICONSPORPERIFACT;

    





























    PROCEDURE OBTPERIODOSNOLIQPORPROD(
                                        INUPRODUCTO IN  SERVSUSC.SESUNUSE%TYPE,
                                        INUMETODO   IN  CONSSESU.COSSMECC%TYPE,
                                        INUCICO     IN  CICLCONS.CICOCODI%TYPE,
                                        OTBPERIODOS	OUT NOCOPY	PKTBLCONSSESU.TYCOSSPECS
                                     )
    IS

        
        
        CURSOR CUCONSNOLIQ
        IS
            SELECT  COSSPECS
            FROM    CONSSESU,PERICOSE
            WHERE   COSSPECS = PECSCONS
            AND     PECSCICO = INUCICO
            AND     COSSSESU = INUPRODUCTO
            AND     COSSMECC = INUMETODO
            AND     COSSFLLI = 'N'
            GROUP BY COSSPECS;

    BEGIN
    

        
        IF CUCONSNOLIQ%ISOPEN THEN
    	   CLOSE CUCONSNOLIQ;
        END IF;

        
        OPEN CUCONSNOLIQ;
        FETCH CUCONSNOLIQ BULK COLLECT INTO OTBPERIODOS;
        CLOSE CUCONSNOLIQ;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
        	IF CUCONSNOLIQ%ISOPEN THEN
        	   CLOSE CUCONSNOLIQ;
        	END IF;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            IF CUCONSNOLIQ%ISOPEN THEN
        	   CLOSE CUCONSNOLIQ;
        	END IF;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            IF CUCONSNOLIQ%ISOPEN THEN
        	   CLOSE CUCONSNOLIQ;
        	END IF;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );

    END OBTPERIODOSNOLIQPORPROD;
    

    























    PROCEDURE GETTOTALCONSUMPTION
    (
        INUPRODUCT             IN  CONSSESU.COSSSESU%TYPE,
        INUMETHODCALCULATION   IN  CONSSESU.COSSMECC%TYPE,
        INUCONSUMPTIONTYPE     IN  CONSSESU.COSSTCON%TYPE,
        IDTCONSUMPTIONPERIODI  IN  PERICOSE.PECSFECI%TYPE,
        IDTCONSUMPTIONPERIODF  IN  PERICOSE.PECSFECF%TYPE,
        ONUVALUE               OUT NUMBER
    )
    IS
        
        CURSOR CUTOTALCONSUMPTION
        IS
            SELECT  /*+
                        index( PERICOSE IX_PERICOSE02 )
                        index( CONSSESU IX_CONSSESU03 )
                    */
                    SUM(COSSCOCA)
              FROM  PERICOSE, CONSSESU
                    
             WHERE  COSSPECS =  PECSCONS
               AND  PECSFECI >= IDTCONSUMPTIONPERIODI
               AND  PECSFECF <= IDTCONSUMPTIONPERIODF
               AND  COSSMECC =  INUMETHODCALCULATION
               AND  COSSTCON =  INUCONSUMPTIONTYPE
               AND  COSSSESU =  INUPRODUCT;

    BEGIN
        
        IF CUTOTALCONSUMPTION%ISOPEN THEN
    	   CLOSE CUTOTALCONSUMPTION;
        END IF;

        
        OPEN CUTOTALCONSUMPTION;
        FETCH CUTOTALCONSUMPTION INTO ONUVALUE;
        CLOSE CUTOTALCONSUMPTION;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            IF CUTOTALCONSUMPTION%ISOPEN THEN
                CLOSE CUTOTALCONSUMPTION;
            END IF;
        	PKERRORS.POP;
        	RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            IF CUTOTALCONSUMPTION%ISOPEN THEN
                CLOSE CUTOTALCONSUMPTION;
            END IF;
        	
        	PKERRORS.POP;
        	RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
            IF CUTOTALCONSUMPTION%ISOPEN THEN
                CLOSE CUTOTALCONSUMPTION;
            END IF;
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END GETTOTALCONSUMPTION;
    
    
    




























    PROCEDURE GETPERIODBYPRODUCTANDDATE
    (
        INUPRODUCT             IN  CONSSESU.COSSSESU%TYPE,
        INUMETHODCALCULATION   IN  CONSSESU.COSSMECC%TYPE,
        INUCONSUMPTIONTYPE     IN  CONSSESU.COSSTCON%TYPE,
        IDTDATEINI             IN  PERICOSE.PECSFECI%TYPE,
        IDTDATEFIN             IN  PERICOSE.PECSFECI%TYPE,
        ODTPECSFECI            OUT PERICOSE.PECSFECI%TYPE
    )
    IS
        
        CURSOR CUCONSPERIOD
        IS
            SELECT  /*+
                        index( PERICOSE IX_PERICOSE02 )
                        index( CONSSESU IX_CONSSESU03 )
                    */
                    MIN( PECSFECI )
              FROM  PERICOSE, CONSSESU
                    
                    
             WHERE  PECSFECF >= IDTDATEINI
               AND  PECSFECF <= IDTDATEFIN
                    
               AND  COSSPECS =  PECSCONS
               AND  COSSMECC =  INUMETHODCALCULATION
               AND  COSSTCON =  INUCONSUMPTIONTYPE
               AND  COSSSESU =  INUPRODUCT;

    BEGIN
        PKERRORS.PUSH ('pkBCConsumptionPeriod.GetPeriodByProductAndDate');
        
        
        IF CUCONSPERIOD%ISOPEN THEN
    	   CLOSE CUCONSPERIOD;
        END IF;

        
        OPEN CUCONSPERIOD;
        FETCH CUCONSPERIOD INTO ODTPECSFECI;
        CLOSE CUCONSPERIOD;

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            IF CUCONSPERIOD%ISOPEN THEN
                CLOSE CUCONSPERIOD;
            END IF;
        	PKERRORS.POP;
        	RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            IF CUCONSPERIOD%ISOPEN THEN
                CLOSE CUCONSPERIOD;
            END IF;
        	
        	PKERRORS.POP;
        	RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
            IF CUCONSPERIOD%ISOPEN THEN
                CLOSE CUCONSPERIOD;
            END IF;
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END GETPERIODBYPRODUCTANDDATE;
    
    
    
























    PROCEDURE GETPERIODPREVIOUS
    (
        INUPRODUCT             IN  CONSSESU.COSSSESU%TYPE,
        INUMETHODCALCULATION   IN  CONSSESU.COSSMECC%TYPE,
        INUCONSUMPTIONTYPE     IN  CONSSESU.COSSTCON%TYPE,
        IDTDATE                IN  PERICOSE.PECSFECF%TYPE,
        ODTPECSFECF            OUT PERICOSE.PECSFECF%TYPE
    )
    IS
        
        CURSOR CUCONSPERIOD
        IS
            SELECT  /*+
                        index( PERICOSE IX_PERICOSE02 )
                        index( CONSSESU IX_CONSSESU03 )
                    */
                    MAX( PECSFECF )
              FROM  PERICOSE, CONSSESU
                    
                    
             WHERE  PECSFECF <= IDTDATE
                    
               AND  COSSPECS =  PECSCONS
               AND  COSSMECC =  INUMETHODCALCULATION
               AND  COSSTCON =  INUCONSUMPTIONTYPE
               AND  COSSSESU =  INUPRODUCT;

    BEGIN
        PKERRORS.PUSH ('pkBCConsumptionPeriod.GetPeriodPrevious');

        
        IF CUCONSPERIOD%ISOPEN THEN
    	   CLOSE CUCONSPERIOD;
        END IF;

        
        OPEN CUCONSPERIOD;
        FETCH CUCONSPERIOD INTO ODTPECSFECF;
        CLOSE CUCONSPERIOD;

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            IF CUCONSPERIOD%ISOPEN THEN
                CLOSE CUCONSPERIOD;
            END IF;
        	PKERRORS.POP;
        	RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            IF CUCONSPERIOD%ISOPEN THEN
                CLOSE CUCONSPERIOD;
            END IF;
        	
        	PKERRORS.POP;
        	RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
            IF CUCONSPERIOD%ISOPEN THEN
                CLOSE CUCONSPERIOD;
            END IF;
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END GETPERIODPREVIOUS;
    
    
    
	



















    PROCEDURE GETCONSUMTIONPERIOD
    (
        INUBILLINGCYCLE IN  CICLO.CICLCODI%TYPE,
        OCUOUTPUT       OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN

        OPEN OCUOUTPUT FOR
            SELECT  /*+
                        leading ( ciclo ciclcons )
                        index (ciclo PK_ciclo )
                        index (ciclcons PK_ciclcons )
                    */
                    CICLCONS.CICOCODI ID,CICLCONS.CICODESC DESCRIPTION
            FROM    CICLO,CICLCONS
            WHERE   CICLO.CICLCODI = INUBILLINGCYCLE
                AND CICLCONS.CICOCODI = CICLO.CICLCICO;


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
    END GETCONSUMTIONPERIOD;

    


END PKBCCONSUMPTIONPERIOD;