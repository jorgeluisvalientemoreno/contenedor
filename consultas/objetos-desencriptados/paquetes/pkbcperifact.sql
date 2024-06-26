PACKAGE BODY pkBCPerifact AS
































































    
    
    
    
    CSBVERSION          CONSTANT VARCHAR2(250) := 'SAO199172';
    
    
    CNUCYCLEWHITOUTPERIOD	CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 2915;

    
    CNUMOREPERIODBYCYCLE	CONSTANT MENSAJE.MENSCODI%TYPE := 9190;
    
    
    
    
    SBERRMSG      GE_ERROR_LOG.DESCRIPTION%TYPE;   
    BLISLOADED    BOOLEAN:=FALSE ;          

    
    
    
    TYPE TYTBPEFACODI IS TABLE OF PERIFACT.PEFACODI%TYPE INDEX BY VARCHAR2(200);

    
    TBPERIXMES	TYTBPEFACODI ;

    
    TBBILLINGPERIOD TYTBBILLINGPERIOD;

    
    
    TBPERIODOS	TYTBPEFACODI ;

    
    
    
    
    
    
    




















PROCEDURE GETDATESMOVPERIOD
    (
        INUANO          IN PERIFACT.PEFAANO%TYPE,
        INUMES          IN PERIFACT.PEFAMES%TYPE,
        ODTMINPEFAFIMO  OUT PERIFACT.PEFAFIMO%TYPE,
        ODTMAXPEFAFFMO  OUT PERIFACT.PEFAFFMO%TYPE
    )
    IS
BEGIN

    PKERRORS.PUSH('pkBCPerifact.GetDatesMovPeriod');

    OPEN CUDATESMOV ( INUANO, INUMES );
    
    FETCH CUDATESMOV INTO ODTMINPEFAFIMO,ODTMAXPEFAFFMO;
    
    CLOSE CUDATESMOV;

    PKERRORS.POP;

EXCEPTION

    WHEN OTHERS THEN
        IF ( CUDATESMOV%ISOPEN ) THEN
            CLOSE CUDATESMOV;
        END IF;
        PKERRORS.POP;
        RAISE LOGIN_DENIED;

END GETDATESMOVPERIOD;































PROCEDURE GETCURRPERIODBYCYCLE
(
    INUCICLO         IN      CICLO.CICLCODI%TYPE,
    ORCPERIFACT      OUT     PERIFACT%ROWTYPE
) IS

RCTMP_PERIFACT PERIFACT%ROWTYPE;

BEGIN

    PKERRORS.PUSH('pkbcPerifact.GetCurrPeriodByCycle');
    
    OPEN CUDATAPERIODBYCYCLE ( INUCICLO );

    FETCH CUDATAPERIODBYCYCLE INTO ORCPERIFACT;

    IF ( CUDATAPERIODBYCYCLE%NOTFOUND ) THEN
        ERRORS.SETERROR(CNUCYCLEWHITOUTPERIOD, INUCICLO);
        RAISE LOGIN_DENIED;
        
    END IF;
    
    FETCH CUDATAPERIODBYCYCLE INTO RCTMP_PERIFACT;
    
    IF ( CUDATAPERIODBYCYCLE%FOUND ) THEN
    
        PKERRORS.SETERRORCODE (
				                PKCONSTANTE.CSBDIVISION,
				                PKCONSTANTE.CSBMOD_SAT,
				                CNUMOREPERIODBYCYCLE
			                   );

        RAISE LOGIN_DENIED;
    END IF;
    
    CLOSE CUDATAPERIODBYCYCLE;

    PKERRORS.POP;
    
EXCEPTION

    WHEN LOGIN_DENIED THEN
        
        IF (CUDATAPERIODBYCYCLE%ISOPEN) THEN
	        CLOSE CUDATAPERIODBYCYCLE;
	    END IF;
        PKERRORS.POP;
        RAISE LOGIN_DENIED;
        
    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        
        IF (CUDATAPERIODBYCYCLE%ISOPEN) THEN
	        CLOSE CUDATAPERIODBYCYCLE;
	    END IF;
        
        PKERRORS.POP;
        RAISE PKCONSTANTE.EXERROR_LEVEL2;
        
    WHEN OTHERS THEN
        
        IF (CUDATAPERIODBYCYCLE%ISOPEN) THEN
	        CLOSE CUDATAPERIODBYCYCLE;
	    END IF;
        PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
END GETCURRPERIODBYCYCLE;

























PROCEDURE GETPERIODSBYMONTH
(
    INUANO              IN PERIFACT.PEFAANO%TYPE,
    INUMES              IN PERIFACT.PEFAMES%TYPE,
    OTBPERIODOS         OUT NOCOPY TYTBPEFACODIRANGE

) IS

BEGIN

    PKERRORS.PUSH('pkBCPerifact.GetPeriodsByMonth');

    
    OTBPERIODOS.DELETE;


    

    OPEN  CUPERIODSBYMONTH ( INUANO , INUMES );

    FETCH CUPERIODSBYMONTH BULK COLLECT INTO OTBPERIODOS;

    CLOSE CUPERIODSBYMONTH;

    PKERRORS.POP;

EXCEPTION

    WHEN LOGIN_DENIED THEN
        
        IF (CUPERIODSBYMONTH%ISOPEN) THEN
	        CLOSE CUPERIODSBYMONTH;
	    END IF;
        PKERRORS.POP;
        RAISE LOGIN_DENIED;
    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        
        IF (CUPERIODSBYMONTH%ISOPEN) THEN
	        CLOSE CUPERIODSBYMONTH;
	    END IF;
        
        PKERRORS.POP;
        RAISE PKCONSTANTE.EXERROR_LEVEL2;
    WHEN OTHERS THEN
        
        IF (CUPERIODSBYMONTH%ISOPEN) THEN
	        CLOSE CUPERIODSBYMONTH;
	    END IF;
        PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);

END GETPERIODSBYMONTH;

    





























PROCEDURE GETPERIODBYDATE
    (
	INUCICLO	IN	PERIFACT.PEFACICL%TYPE,
        INUANO		IN	PERIFACT.PEFAANO%TYPE,
        INUMES		IN	PERIFACT.PEFAMES%TYPE,
        ONUPERIODO	OUT	PERIFACT.PEFACODI%TYPE
    ) 
    IS

    
    NUPERIODO	PERIFACT.PEFACODI%TYPE ;

    
    CURSOR CUPERIODO IS
    SELECT PEFACODI
    FROM   PERIFACT
    WHERE  PEFACICL = INUCICLO
    AND    PEFAANO  = INUANO
    AND    PEFAMES  = INUMES ;

BEGIN


    PKERRORS.PUSH ('pkBCPerifact.GetPeriodByDate');

    
    IF (CUPERIODO%ISOPEN) THEN
	CLOSE CUPERIODO ;
    END IF;

    
    OPEN  CUPERIODO ;
    FETCH CUPERIODO INTO NUPERIODO ;
    CLOSE CUPERIODO ;

    ONUPERIODO := NUPERIODO ;
    PKERRORS.POP;

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


END GETPERIODBYDATE ;

    


































PROCEDURE GETCACHEPERIODBYDATE
    (
	INUCICLO	IN	PERIFACT.PEFACICL%TYPE,
        INUANO		IN	PERIFACT.PEFAANO%TYPE,
        INUMES		IN	PERIFACT.PEFAMES%TYPE,
        ONUPERIODO	OUT	PERIFACT.PEFACODI%TYPE
    ) 
    IS

    
    SBKEY	VARCHAR2(20) ;

    
    NUPERIODO	PERIFACT.PEFACODI%TYPE ;

BEGIN


    PKERRORS.PUSH ('pkBCPerifact.GetCachePeriodByDate');

    
    SBKEY := TO_CHAR(INUCICLO, 'FM0009') || TO_CHAR(INUANO, 'FM0009') || 
             TO_CHAR(INUMES, 'FM09') ;

    
    IF (TBPERIXMES.EXISTS (SBKEY) ) THEN
	ONUPERIODO := TBPERIXMES (SBKEY) ;
	PKERRORS.POP;
	RETURN;
    END IF;

    
    GETPERIODBYDATE 
	(
	    INUCICLO,
	    INUANO,
	    INUMES,
	    NUPERIODO
	) ;

    
    TBPERIXMES (SBKEY) := NUPERIODO ;

    
    ONUPERIODO := NUPERIODO ;

    PKERRORS.POP;

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


END GETCACHEPERIODBYDATE ;

    



























PROCEDURE CLEARCACHEPERIODBYDATE IS

BEGIN

    
    TBPERIXMES.DELETE ;

END CLEARCACHEPERIODBYDATE ;

    





















FUNCTION FSBVERSION  RETURN VARCHAR2 IS
BEGIN

  
    RETURN CSBVERSION;
  

END;
    






















PROCEDURE GETALLPERIODS
(
    OCUALLPERIODS OUT PKCONSTANTE.TYREFCURSOR
)
IS
BEGIN

    PKERRORS.PUSH ('pkBCPerifact.GetAllPeriods');

    IF ( OCUALLPERIODS%ISOPEN ) THEN
       CLOSE OCUALLPERIODS;
    END IF;

    OPEN OCUALLPERIODS FOR
        SELECT PEFACODI CODE, PEFADESC DESCRIPTION
        FROM   PERIFACT
        ORDER BY PEFACODI;

    PKERRORS.POP;

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

END GETALLPERIODS;
























FUNCTION FRCGETPERIOD
(
    INUPERIFACT IN  PERIFACT.PEFACODI%TYPE
)RETURN PERIFACT%ROWTYPE
IS

    RCPERIFACT  PERIFACT%ROWTYPE;

BEGIN

    PKERRORS.PUSH ('pkBCPerifact.frcGetPeriod');


    
    IF ( TBBILLINGPERIOD.EXISTS(INUPERIFACT) ) THEN
    
        RCPERIFACT := TBBILLINGPERIOD(INUPERIFACT);
        
    ELSE
        
        RCPERIFACT := PKTBLPERIFACT.FRCGETRECORD(INUPERIFACT);
        TBBILLINGPERIOD(INUPERIFACT) := RCPERIFACT;
    END IF;
    
    
    RETURN(RCPERIFACT);
    
    PKERRORS.POP;

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

END FRCGETPERIOD;







































PROCEDURE GETBILLPERBYCONSPER
(
    INUCICLO	IN	PERIFACT.PEFACICL%TYPE,
    INUPERIODOC	IN	PERICOSE.PECSCONS%TYPE,
    ONUPERIODOF	OUT	PERIFACT.PEFACODI%TYPE,
    ISBTIPOCOBR IN  SERVICIO.SERVTICO%TYPE DEFAULT 'V',
    ISBFORMALIQ IN  CONCEPTO.CONCTICC%TYPE DEFAULT 'C'
)
IS

    
    NUPERIODO	PERICOSE.PECSCONS%TYPE ;

    
    RCPERICOSE  PERICOSE%ROWTYPE;

    
    DTREFDATE   DATE;

    
    CURSOR CUPERIODOANT IS
    SELECT PEFACODI
    FROM   PERIFACT
    WHERE  PEFACICL = INUCICLO
    AND    PEFAFFMO >= DTREFDATE
    ORDER BY PEFAFFMO ASC;

    
    CURSOR CUPERIODOSIG IS
    SELECT PEFACODI
    FROM   PERIFACT
    WHERE  PEFACICL = INUCICLO
    AND    PEFAFFMO <= DTREFDATE
    ORDER BY PEFAFFMO DESC;

    
    PROCEDURE CLOSECURSORS
    IS
    BEGIN

        PKERRORS.PUSH ('pkBCPerifact.GetBillPerByConsPer.CloseCursors');

        IF (CUPERIODOANT%ISOPEN) THEN
        	CLOSE CUPERIODOANT ;
        END IF;
        IF (CUPERIODOSIG%ISOPEN) THEN
        	CLOSE CUPERIODOSIG ;
        END IF;
        PKERRORS.POP;

    END CLOSECURSORS;

BEGIN


    PKERRORS.PUSH ('pkBCPerifact.GetBillPerByConsPer');

    
    PKBCPERICOSE.GETCACHERECORDEX(INUPERIODOC, RCPERICOSE);

    
    IF ( ISBTIPOCOBR = PKBILLCONST.CSBTIPO_COBRO_VEN ) THEN
    
        
        IF ( ISBFORMALIQ = PKCONSTANTE.CSBCONSUMO ) THEN

            
            DTREFDATE := RCPERICOSE.PECSFECF;
        ELSE
            
            DTREFDATE := RCPERICOSE.PECSFEAF;
        END IF;

        IF (CUPERIODOANT%ISOPEN) THEN
        	CLOSE CUPERIODOANT ;
        END IF;

        
        OPEN  CUPERIODOANT;
        FETCH CUPERIODOANT INTO NUPERIODO ;
        CLOSE CUPERIODOANT ;
        
    ELSE
        
        IF ( ISBFORMALIQ = PKCONSTANTE.CSBCONSUMO ) THEN

            
            DTREFDATE := RCPERICOSE.PECSFECI;
        ELSE
            
            DTREFDATE := RCPERICOSE.PECSFEAI;
        END IF;

        IF (CUPERIODOSIG%ISOPEN) THEN
        	CLOSE CUPERIODOSIG ;
        END IF;

        
        OPEN  CUPERIODOSIG;
        FETCH CUPERIODOSIG INTO NUPERIODO ;
        CLOSE CUPERIODOSIG ;
    END IF;

    ONUPERIODOF := NUPERIODO ;

    PKERRORS.POP;

EXCEPTION

    WHEN LOGIN_DENIED THEN
        
        CLOSECURSORS;
        PKERRORS.POP;
        RAISE LOGIN_DENIED;

    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        
        CLOSECURSORS;
        
        PKERRORS.POP;
        RAISE PKCONSTANTE.EXERROR_LEVEL2;

    WHEN OTHERS THEN
        
        CLOSECURSORS;
        PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);


END GETBILLPERBYCONSPER ;

    






























    PROCEDURE GETNPREVBILLPERIOD
    (
        INUBILLINGPERIOD    IN  PERIFACT.PEFACODI%TYPE,
        INUNVALUE           IN  NUMBER,
        ORCNPREVBILLPER     OUT PERIFACT%ROWTYPE
    )
    IS

        
        RCBILLINGPERIOD PERIFACT%ROWTYPE;
        
        
        NUCOUNTER       NUMBER;

        
        CURSOR CUPREVBILLPERIOD
        IS
            SELECT  /*+ index_desc(perifact IX_PEFA_FIMO_CICL) */ *
            FROM    PERIFACT
            WHERE   PEFACICL = RCBILLINGPERIOD.PEFACICL
            AND     PEFAFIMO < RCBILLINGPERIOD.PEFAFIMO;

    BEGIN
        PKERRORS.PUSH('pkBCPerifact.GetNPrevBillPeriod');

        RCBILLINGPERIOD := PKBCPERIFACT.FRCGETPERIOD(INUBILLINGPERIOD);

        IF (CUPREVBILLPERIOD%ISOPEN) THEN
            CLOSE CUPREVBILLPERIOD;
        END IF;

        
        NUCOUNTER := 0;
        
        OPEN CUPREVBILLPERIOD;
        
        
        LOOP
            ORCNPREVBILLPER := NULL;
            FETCH CUPREVBILLPERIOD INTO ORCNPREVBILLPER;
            NUCOUNTER := NUCOUNTER + 1;
            EXIT WHEN NUCOUNTER = INUNVALUE OR CUPREVBILLPERIOD%NOTFOUND;
        END LOOP;
        
        CLOSE CUPREVBILLPERIOD;

        PKERRORS.POP;

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

    END GETNPREVBILLPERIOD;
    
    















    
    FUNCTION FNUBILLPERBYCONSPER
    (
        INUCONSPER  IN  PERICOSE.PECSCONS%TYPE
    )
    RETURN PERIFACT.PEFACODI%TYPE
    IS
        
        RCPERICOSE  PERICOSE%ROWTYPE;
        
        NUCYCLE     CICLO.CICLCODI%TYPE;
        
        NUPERIFACT  PERIFACT.PEFACODI%TYPE;
        
        CNUPERIOD_NOT_FOUND CONSTANT NUMBER := 900956;

    BEGIN
        PKERRORS.PUSH('pkBCPerifact.fnuBillPerByConsPer');

        
        RCPERICOSE := PKTBLPERICOSE.FRCGETRECORD(INUCONSPER);
        
        PKBCCICLO.GETBILLINGCYCLEBYCONSCYCLE(RCPERICOSE.PECSCICO, NUCYCLE);

        
        GETBILLPERBYCONSPER(NUCYCLE,
                            INUCONSPER,
                            NUPERIFACT);

        
        IF (NUPERIFACT IS NULL) THEN
            ERRORS.SETERROR
            (
                CNUPERIOD_NOT_FOUND,
                INUCONSPER||'|'||NUCYCLE
            );
            RAISE LOGIN_DENIED;
        END IF;

        
        RETURN NUPERIFACT;

        PKERRORS.POP;
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
    END  FNUBILLPERBYCONSPER;
    
    


























    PROCEDURE GETPERIODBYDATE(
                            	INUCYCLE	IN	PERIFACT.PEFACICL%TYPE,
                                INUYEAR		IN	PERIFACT.PEFAANO%TYPE,
                                INUMONTH	IN	PERIFACT.PEFAMES%TYPE,
                                ORCPERIOD	OUT	PERIFACT%ROWTYPE
                             )
    IS

        
        NUPERIODO	PERIFACT.PEFACODI%TYPE ;

        
        CURSOR CUPERIODO
        IS
            SELECT  /*+
                        index ( perifact UX_PERIFACT01 )
                    */
                    *
            FROM    PERIFACT
                    /*+ pkBCPerifact.GetPeriodByDate */
            WHERE   PEFACICL = INUCYCLE
            AND     PEFAANO  = INUYEAR
            AND     PEFAMES  = INUMONTH;

    BEGIN
        PKERRORS.PUSH ('pkBCPerifact.GetPeriodByDate');

        
        IF CUPERIODO%ISOPEN THEN
            CLOSE CUPERIODO ;
        END IF;

        
        OPEN  CUPERIODO;
        FETCH CUPERIODO INTO ORCPERIOD;
        CLOSE CUPERIODO;

        PKERRORS.POP;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            
            IF CUPERIODO%ISOPEN THEN
                CLOSE CUPERIODO ;
            END IF;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            
            PKERRORS.POP;
            
            IF CUPERIODO%ISOPEN THEN
                CLOSE CUPERIODO ;
            END IF;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            PKERRORS.POP;
            
            IF CUPERIODO%ISOPEN THEN
                CLOSE CUPERIODO ;
            END IF;
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END GETPERIODBYDATE ;


    

























    PROCEDURE GETCACHEBILLPERBYCONSPER
    (
        INUCICLO	IN	PERIFACT.PEFACICL%TYPE,
        INUPERIODOC	IN	PERICOSE.PECSCONS%TYPE,
        ONUPERIODOF	OUT	PERIFACT.PEFACODI%TYPE,
        ISBTIPOCOBR IN  SERVICIO.SERVTICO%TYPE DEFAULT 'V',
        ISBFORMALIQ IN  CONCEPTO.CONCTICC%TYPE DEFAULT 'C'
    )
    IS
        
        SBKEY	    VARCHAR2(100) ;

        
        NUPERIODO	PERIFACT.PEFACODI%TYPE ;
    BEGIN
    
        PKERRORS.PUSH ('pkBCPerifact.GetCacheBillPerByConsPer');

        
        SBKEY := TO_CHAR(INUCICLO, 'FM0009') ||
                 TO_CHAR(INUPERIODOC, 'FM000000000000009') ||
                 ISBTIPOCOBR||ISBFORMALIQ;

        
        IF (TBPERIODOS.EXISTS (SBKEY) ) THEN
        
        	ONUPERIODOF := TBPERIODOS (SBKEY) ;
        	PKERRORS.POP;
            RETURN;
        
        END IF;

        
        GETBILLPERBYCONSPER
        (
            INUCICLO,
            INUPERIODOC,
            NUPERIODO,
            ISBTIPOCOBR,
            ISBFORMALIQ
        );

        
        TBPERIODOS (SBKEY) := NUPERIODO ;

        
        ONUPERIODOF := NUPERIODO ;

        PKERRORS.POP;
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
    
    END GETCACHEBILLPERBYCONSPER ;
    
    























    PROCEDURE GETNPREVBILLPERIODS
    (
        INUBILLINGPERIOD    IN  PERIFACT.PEFACODI%TYPE,
        INUNUMPERIODS       IN  NUMBER,
        OTBPREVPERIODS      OUT TYTBBILLINGPERIOD
    )
    IS

        
        RCBILLPERIOD    PERIFACT%ROWTYPE;

        
        CURSOR CUPREVBILLPERIOD
        (
            INUCYCLE        IN  PERIFACT.PEFACICL%TYPE,
            INUENDDATE      IN  PERIFACT.PEFAFFMO%TYPE
        )
        IS
            SELECT  /*+ index_desc(perifact IX_PEFA_CICL_FFMO) */ *
            FROM    PERIFACT
                    /*+ pkBCPerifact.GetNPrevBillPeriods */
            WHERE   PEFACICL = INUCYCLE
            AND     PEFAFFMO < INUENDDATE;

    BEGIN
        PKERRORS.PUSH('pkBCPerifact.GetNPrevBillPeriods');

        
        RCBILLPERIOD := FRCGETPERIOD(INUBILLINGPERIOD);

        IF ( CUPREVBILLPERIOD%ISOPEN ) THEN
            CLOSE CUPREVBILLPERIOD;
        END IF;

        
        OPEN CUPREVBILLPERIOD(RCBILLPERIOD.PEFACICL, RCBILLPERIOD.PEFAFFMO);
        FETCH CUPREVBILLPERIOD BULK COLLECT INTO OTBPREVPERIODS LIMIT INUNUMPERIODS;
        CLOSE CUPREVBILLPERIOD;

        PKERRORS.POP;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        	PKERRORS.POP;
        	IF (CUPREVBILLPERIOD%ISOPEN) THEN
                CLOSE CUPREVBILLPERIOD;
            END IF;
        	RAISE;

        WHEN OTHERS THEN
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	IF (CUPREVBILLPERIOD%ISOPEN) THEN
                CLOSE CUPREVBILLPERIOD;
            END IF;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END GETNPREVBILLPERIODS;
    
    
























    PROCEDURE GETBILLPERIODSBYDATES
    (
        INUCYCLE            IN  PERIFACT.PEFACICL%TYPE,
        IDTINITDATE         IN  PERIFACT.PEFAFIMO%TYPE,
        IDTENDDATE          IN  PERIFACT.PEFAFIMO%TYPE,
        INUNUMPERIODS       IN  NUMBER,
        OTBPREVPERIODS      OUT TYTBBILLINGPERIOD
    )
    IS

        
        CURSOR CUPERIODSBYDATES
        (
            INUCYCLE        IN  PERIFACT.PEFACICL%TYPE,
            IDTINITDATE     IN  PERIFACT.PEFAFIMO%TYPE,
            INUENDDATE      IN  PERIFACT.PEFAFFMO%TYPE
        )
        IS
            SELECT  /*+ index_desc(perifact IX_PEFA_CICL_FFMO) */ *
            FROM    PERIFACT
                    /*+ pkBCPerifact.GetBillPeriodsByDates */
            WHERE   PEFACICL = INUCYCLE
            AND     PEFAFFMO >= IDTINITDATE
            AND     PEFAFFMO <= INUENDDATE;

    BEGIN
        PKERRORS.PUSH('pkBCPerifact.GetBillPeriodsByDates');

        IF ( CUPERIODSBYDATES%ISOPEN ) THEN
            CLOSE CUPERIODSBYDATES;
        END IF;

        
        OPEN CUPERIODSBYDATES(INUCYCLE, IDTINITDATE, IDTENDDATE);

        
        IF ( INUNUMPERIODS = PKCONSTANTE.NULLNUM ) THEN
            
            
            FETCH CUPERIODSBYDATES BULK COLLECT INTO OTBPREVPERIODS;
        ELSE
            
            
            FETCH CUPERIODSBYDATES BULK COLLECT INTO OTBPREVPERIODS LIMIT INUNUMPERIODS;
        END IF;

        CLOSE CUPERIODSBYDATES;

        PKERRORS.POP;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        	PKERRORS.POP;
        	IF (CUPERIODSBYDATES%ISOPEN) THEN
                CLOSE CUPERIODSBYDATES;
            END IF;
        	RAISE;

        WHEN OTHERS THEN
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	IF (CUPERIODSBYDATES%ISOPEN) THEN
                CLOSE CUPERIODSBYDATES;
            END IF;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END GETBILLPERIODSBYDATES;
    
    





















    PROCEDURE GETPERIODBYMOVENDDATE
    (
        INUCYCLE        IN  PERIFACT.PEFACICL%TYPE,
        INULASTMOVDATE  IN  PERIFACT.PEFAFFMO%TYPE,
        ORCPERIOD       OUT PERIFACT%ROWTYPE
    )
    IS

        
        RCPERIOD    PERIFACT%ROWTYPE;

        
        CURSOR CUPERIOD IS
        SELECT /*+ index(perifact IX_PEFA_CICL_FFMO)*/ *
        FROM   PERIFACT /*+ pkBCPerifact.GetPeriodByMovEndDate */
        WHERE  PEFACICL = INUCYCLE
        AND    PEFAFFMO = INULASTMOVDATE;

    BEGIN

        PKERRORS.PUSH ('pkBCPerifact.GetPeriodByMovEndDate');

        
        IF (CUPERIOD%ISOPEN)
        THEN
               CLOSE CUPERIOD;
        END IF;

        
        OPEN  CUPERIOD;
        FETCH CUPERIOD INTO RCPERIOD;
        CLOSE CUPERIOD;

        ORCPERIOD := RCPERIOD;
        PKERRORS.POP;
        
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        	PKERRORS.POP;
        	IF (CUPERIOD%ISOPEN) THEN
                CLOSE CUPERIOD;
            END IF;
        	RAISE;

        WHEN OTHERS THEN
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	IF (CUPERIOD%ISOPEN) THEN
                CLOSE CUPERIOD;
            END IF;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);

    END GETPERIODBYMOVENDDATE;
    
    























FUNCTION FRCGETCURRBILPERBYCYC
    (
        INUCYCLEID IN CICLO.CICLCODI%TYPE
    )
RETURN PERIFACT%ROWTYPE
IS
    
    
    
    RCPERIFACT               PERIFACT%ROWTYPE;

BEGIN

    PKERRORS.PUSH('pkBCPerifact.frcGetCurrBilPerByCyc');

    IF ( CUDATAPERIODBYCYCLE%ISOPEN ) THEN
        CLOSE CUDATAPERIODBYCYCLE;
    END IF;

    OPEN CUDATAPERIODBYCYCLE ( INUCYCLEID );

    FETCH CUDATAPERIODBYCYCLE INTO RCPERIFACT;
    
    CLOSE CUDATAPERIODBYCYCLE;

    PKERRORS.POP;
    RETURN RCPERIFACT;

EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        IF (CUDATAPERIODBYCYCLE%ISOPEN) THEN
            CLOSE CUDATAPERIODBYCYCLE;
        END IF;
        RAISE;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
        IF (CUDATAPERIODBYCYCLE%ISOPEN) THEN
            CLOSE CUDATAPERIODBYCYCLE;
        END IF;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);

END FRCGETCURRBILPERBYCYC;
    
END PKBCPERIFACT;