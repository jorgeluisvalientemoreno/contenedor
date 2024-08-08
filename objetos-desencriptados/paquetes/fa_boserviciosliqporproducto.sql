
PACKAGE FA_BOServiciosLiqPorProducto AS



















































































































































    
    
    
    
    
    
    
    
    
    
    
    

    FUNCTION FSBVERSION
    RETURN VARCHAR2 ;

    FUNCTION FNUOBTTIPOPRODUCTO RETURN NUMBER;

    FUNCTION FNUOBTOTROPRODDIRECINSTACTUAL
    (
        INUTIPOPRODUCTO IN  SERVSUSC.SESUSERV%TYPE
    )
    RETURN NUMBER;
    
    FUNCTION FNUCONCLIQUIDADOENDIRECINST
    (
        INUCONCEPTO             IN  CONCEPTO.CONCCODI%TYPE,
        IRCPRODUCTO             IN  SERVSUSC%ROWTYPE,
        INUPERIODOCONSUMO       IN  PERICOSE.PECSCONS%TYPE,
        INUCICLOCONSUMO         IN  CICLO.CICLCODI%TYPE,
        IRCPERIFACT             IN  PERIFACT%ROWTYPE
    )
    RETURN NUMBER;
    
    FUNCTION FNUOBTENERCARGOPROD
    (
        INUCONCEPTO     IN CONCEPTO.CONCCODI%TYPE,
        INUMODORECLAMO  IN NUMBER,
        INUSERVSUSC     IN SERVSUSC.SESUNUSE%TYPE DEFAULT NULL,
        ISBDOSO         IN CARGOS.CARGDOSO%TYPE DEFAULT NULL
    )
    RETURN NUMBER;

    FUNCTION FNUOBTDIASACTIVOSPROD
    (
        INUMODORECLAMO  IN NUMBER,
        INUCONSUMPERIOD IN PERICOSE.PECSCONS%TYPE

    )
    RETURN NUMBER;

    FUNCTION FNUOBTENERTOTLIQBASEPROD
    (
        INUCONCEPTO        IN CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO        IN SERVSUSC.SESUNUSE%TYPE,
        INUSERVICIO        IN SERVSUSC.SESUSERV%TYPE,
        INUPERICOSE        IN PERICOSE.PECSCONS%TYPE,
        INUCICLOCONSUMO    IN CICLCONS.CICOCODI%TYPE,
        INUPERIFACT        IN PERIFACT.PEFACODI%TYPE,
        INUCUENTACOBRO     IN CUENCOBR.CUCOCODI%TYPE
    )
    RETURN NUMBER;
    
    FUNCTION FNUMODORECLAMO
    RETURN NUMBER;

    FUNCTION FSBOBTFECHAPERIFACT
    (
        IRCPERIFACT         PERIFACT%ROWTYPE
    )
    RETURN VARCHAR;
    
    FUNCTION FSBOBTCADPEFAPECOLIQ
    (
        INUPERICOSE IN  PERICOSE.PECSCONS%TYPE,
        INUSESUSERV IN  SERVSUSC.SESUSERV%TYPE,
        INUCICLO    IN  CICLO.CICLCODI%TYPE,
        ISBTIPOPER  IN  CONCEPTO.CONCTICC%TYPE
    )
    RETURN VARCHAR;

    FUNCTION FNUOBTCANTPRODPORTIPRYDIIN
    (
        INUTIPOPROD     IN  SERVSUSC.SESUSERV%TYPE,
        INUDIREINST     IN  PR_PRODUCT.ADDRESS_ID%TYPE,
        INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE,
        ISBFORMALIQ     IN  CONCEPTO.CONCTICC%TYPE
    )
    RETURN NUMBER;

    FUNCTION FNUOBTCANTPRODPORCLIEYTIPR
    (
        INUSUSCRIPC     IN  SERVSUSC.SESUSUSC%TYPE,
        INUTIPOPROD     IN  SERVSUSC.SESUSERV%TYPE,
        INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE,
        ISBFORMALIQ     IN  CONCEPTO.CONCTICC%TYPE
    )
    RETURN NUMBER;

    FUNCTION FNUOBTCANTPRODPORSUSCYTIPR
    (
        INUSUSCRIPC     IN  SERVSUSC.SESUSUSC%TYPE,
        INUTIPOPROD     IN  SERVSUSC.SESUSERV%TYPE,
        INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE,
        ISBFORMALIQ     IN  CONCEPTO.CONCTICC%TYPE
    )
    RETURN NUMBER;

    FUNCTION FNUOBTCUENTASVENCIDAS
    (
        INUSERVSUSC     IN  SERVSUSC.SESUNUSE%TYPE
    )
    RETURN NUMBER;
    
    FUNCTION FSBOBTENERCALLEDIRE
    (
        INUSERVSUSC     IN  SERVSUSC.SESUNUSE%TYPE
    )
    RETURN AB_WAY_BY_LOCATION.DESCRIPTION%TYPE;

    FUNCTION FSBOBTENERALTURADIRE
    (
        INUSERVSUSC     IN  SERVSUSC.SESUNUSE%TYPE
    )
    RETURN VARCHAR2;
    
    FUNCTION FNUVALIDARRETIROPROD
    (
        IRCPRODUCTO      IN  SERVSUSC%ROWTYPE,
        IRCPERIFACT      IN  PERIFACT%ROWTYPE
    )
    RETURN NUMBER;

    FUNCTION FNUVALPRODPORTIPRYCLIE
    (
        INUSUSCRIPC     IN  SERVSUSC.SESUSUSC%TYPE,
        INUTIPOPROD     IN  SERVSUSC.SESUSERV%TYPE,
        INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE
    )
    RETURN NUMBER;

    FUNCTION FNUVALPRODPORTIPRYSUSC
    (
        INUSUSCRIPC     IN  SERVSUSC.SESUSUSC%TYPE,
        INUTIPOPROD     IN  SERVSUSC.SESUSERV%TYPE,
        INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE
    )
    RETURN NUMBER;
    
    FUNCTION FNUVALIDARPROMVIGENTE
    (
        INUSERVSUSC     IN  SERVSUSC.SESUNUSE%TYPE,
        INUPROMOID      IN  CC_PROMOTION.PROMOTION_ID%TYPE,
        INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE,
        ISBFORMALIQ     IN  CONCEPTO.CONCTICC%TYPE
    )
    RETURN NUMBER;
    
    FUNCTION FNUOBTMESESTRANSPROMO
    (
        INUSERVSUSC     IN  SERVSUSC.SESUNUSE%TYPE,
        INUPROMOID      IN  CC_PROMOTION.PROMOTION_ID%TYPE,
        INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE,
        ISBFORMALIQ     IN  CONCEPTO.CONCTICC%TYPE
    )
    RETURN NUMBER;
    
    FUNCTION FNUOBTTOTALMESESPROMO
    (
        INUSERVSUSC     IN  SERVSUSC.SESUNUSE%TYPE,
        INUPROMOID      IN  CC_PROMOTION.PROMOTION_ID%TYPE,
        INUPERIODOC     IN  PERICOSE.PECSCONS%TYPE,
        ISBFORMALIQ     IN  CONCEPTO.CONCTICC%TYPE
    )
    RETURN NUMBER;
    
    FUNCTION FSBVALBILLPUNCTUALPAY
    (
        IRCPRODUCT          SERVSUSC%ROWTYPE,
        INUCONCEPT          CONCEPTO.CONCCODI%TYPE,
        INUCONSPERIOD       PERICOSE.PECSCONS%TYPE
    )
    RETURN VARCHAR;

    FUNCTION FNUGETTOTLIQBASECONC
    (
        IRCPRODUCT              SERVSUSC%ROWTYPE,
        IRCCURRENTBILLPERIOD    PERIFACT%ROWTYPE,
        INUCONCEPT              CONCEPTO.CONCCODI%TYPE,
        INUCONSPERIOD           PERICOSE.PECSCONS%TYPE
    )
    RETURN VARCHAR;

    FUNCTION FSBVALBALANCEOUTOFDATE
    (
        INUPRODUCT  SERVSUSC.SESUNUSE%TYPE
    )
    RETURN VARCHAR;

    
    FUNCTION FNUEVALPROTYPSUBSCTION
    (
        INUTIPOPRODUCTO IN  SERVSUSC.SESUSERV%TYPE,
        INUSUSCRIPCION  IN  SUSCRIPC.SUSCCODI%TYPE,
        IDTFECHFINPECO  IN  PERICOSE.PECSFEAF%TYPE
    )
    RETURN NUMBER;

    FUNCTION FNUEVALPROTYPSUBSCBER
    (
        INUTIPOPRODUCTO IN  SERVSUSC.SESUSERV%TYPE,
        INUCLIENTE      IN  SUSCRIPC.SUSCCLIE%TYPE,
        IDTFECHFINPECO  IN  PERICOSE.PECSFEAF%TYPE
    )
    RETURN NUMBER;
    
    PROCEDURE OBTFECHASPERICOSE
    (
        INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE,
        ISBFORMALIQ     IN  CONCEPTO.CONCTICC%TYPE,
        ODTFECHAINI     OUT DATE,
        ODTFECHAFIN     OUT DATE
    );
    

END FA_BOSERVICIOSLIQPORPRODUCTO;
PACKAGE BODY FA_BOServiciosLiqPorProducto AS
































































































































































    
    
    
    
    
    CSBVERSION CONSTANT VARCHAR2(250) := 'SAO302749';

    
    SBERRMSG    GE_ERROR_LOG.DESCRIPTION%TYPE;
    
    
    CNUPRODUCTONOEXISTE     CONSTANT NUMBER := 4845;

    
    
    CSBSEPARATOR	CONSTANT VARCHAR2(50):= '----------Trace Data----------';


    
    
    
    
    GSBCALLE        AB_WAY_BY_LOCATION.DESCRIPTION%TYPE;
    GSBALTURA       VARCHAR2(15);
    
    
    GTBPRODUCTSBYCONT   DAPR_PRODUCT.TYTBPR_PRODUCT;
    GNUPRODBYCONTINMEM  SUSCRIPC.SUSCCODI%TYPE;

    
    
    
    
    
    

    























    PROCEDURE OBTENERCALLEALTURA
    (
        INUSERVSUSC     IN  SERVSUSC.SESUNUSE%TYPE
    )
    IS
        
        NUADDRESS       PR_PRODUCT.ADDRESS_ID%TYPE;

        
        RCADDRESS       DAAB_ADDRESS.STYAB_ADDRESS;
    BEGIN
    
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.ObtenerCalleAltura');
        
        
        NUADDRESS := DAPR_PRODUCT.FNUGETADDRESS_ID(INUSERVSUSC);

        
        RCADDRESS := DAAB_ADDRESS.FRCGETRECORD(NUADDRESS);

        
        IF ( RCADDRESS.WAY_ID IS NULL ) THEN
            
            GSBCALLE := PKCONSTANTE.NULLSB;
        ELSE
            
            GSBCALLE := DAAB_WAY_BY_LOCATION.FSBGETDESCRIPTION(RCADDRESS.WAY_ID);
        END IF;

        
        GSBALTURA := NVL(TO_CHAR(RCADDRESS.HOUSE_NUMBER),'')||' '||NVL(RCADDRESS.HOUSE_LETTER,'');

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
    
    END OBTENERCALLEALTURA;
    
    





























    PROCEDURE OBTFECHASPERICOSE
    (
        INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE,
        ISBFORMALIQ     IN  CONCEPTO.CONCTICC%TYPE,
        ODTFECHAINI     OUT DATE,
        ODTFECHAFIN     OUT DATE
    )
    IS
        
        RCPERICOSE      PERICOSE%ROWTYPE;
    BEGIN
    
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.ObtFechasPericose');
        
        
        PKBCPERICOSE.GETCACHERECORD(INUPERICOSE, RCPERICOSE);
        
        PKBCPERICOSE.GETDATESBYLIQTYPE
        (
            RCPERICOSE,
            ISBFORMALIQ,
            ODTFECHAINI,
            ODTFECHAFIN
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
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
    END OBTFECHASPERICOSE;
    
    
    
    
    




















    FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
    
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fsbVersion');
        PKERRORS.POP;
        
        RETURN (CSBVERSION);
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


    























    FUNCTION FNUOBTTIPOPRODUCTO
    RETURN NUMBER
    IS
        NUSESUSERV  SERVSUSC.SESUSERV%TYPE;
    BEGIN
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtTipoProducto');

        PKINSTANCEDATAMGR.GETCG_SERVICE(NUSESUSERV);
        
        IF (NUSESUSERV IS NULL) THEN

            NUSESUSERV:= PKCONSTANTE.NULLNUM;
            
        END IF;

        PKERRORS.POP;
        RETURN NUSESUSERV;
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
     END FNUOBTTIPOPRODUCTO;

     
























    FUNCTION FNUOBTOTROPRODDIRECINSTACTUAL(
        INUTIPOPRODUCTO IN  SERVSUSC.SESUSERV%TYPE
    )
    RETURN NUMBER
    IS
        NUADDRESSIDPRODACT  PR_PRODUCT.ADDRESS_ID%TYPE;
        RCSERVSUSC          SERVSUSC%ROWTYPE;
        NUIDOTROPRODUCTO    PR_PRODUCT.PRODUCT_ID%TYPE;
        NUIDPRODUCT         PR_PRODUCT.PRODUCT_ID%TYPE;
        NUCONTRATO          PR_PRODUCT.SUBSCRIPTION_ID%TYPE;
        RFPRODUCTS          CONSTANTS.TYREFCURSOR;
        RCPRODUCT           DAPR_PRODUCT.STYPR_PRODUCT;

    BEGIN
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtOtroProdDirecInstActual');

        NUIDOTROPRODUCTO := PKCONSTANTE.NULLNUM; 
        
        PKINSTANCEDATAMGR.GETCG_PRODUCTRECORD(RCSERVSUSC);

        NUIDPRODUCT := RCSERVSUSC.SESUNUSE;
        NUCONTRATO  := RCSERVSUSC.SESUSUSC;
        NUADDRESSIDPRODACT := DAPR_PRODUCT.FNUGETADDRESS_ID(NUIDPRODUCT);

        
        RFPRODUCTS := PKBCSUSCRIPC.FRFGETPRODUCTS(NUCONTRATO);

        FETCH RFPRODUCTS INTO RCPRODUCT;
        LOOP
            EXIT WHEN RFPRODUCTS%NOTFOUND OR NUIDOTROPRODUCTO <> PKCONSTANTE.NULLNUM;

            IF (NUADDRESSIDPRODACT = RCPRODUCT.ADDRESS_ID AND
                INUTIPOPRODUCTO = RCPRODUCT.PRODUCT_TYPE_ID AND
                NUIDPRODUCT <> RCPRODUCT.PRODUCT_ID ) THEN
                
                 NUIDOTROPRODUCTO := RCPRODUCT.PRODUCT_ID;

            END IF;

            FETCH RFPRODUCTS INTO RCPRODUCT;
        END LOOP ;

        CLOSE RFPRODUCTS;

        PKERRORS.POP;
        RETURN NUIDOTROPRODUCTO;
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
     END FNUOBTOTROPRODDIRECINSTACTUAL;

    








































    FUNCTION FNUCONCLIQUIDADOENDIRECINST (
        INUCONCEPTO             IN  CONCEPTO.CONCCODI%TYPE,
        IRCPRODUCTO             IN  SERVSUSC%ROWTYPE,
        INUPERIODOCONSUMO       IN  PERICOSE.PECSCONS%TYPE,
        INUCICLOCONSUMO         IN  CICLO.CICLCODI%TYPE,
        IRCPERIFACT             IN  PERIFACT%ROWTYPE
    )
    RETURN NUMBER
    IS
        NUADDRESSIDPRODACT  PR_PRODUCT.ADDRESS_ID%TYPE;
        ONUCARGVALO         CARGOS.CARGVALO%TYPE;
        NUENCONTRO          NUMBER  := 1;
        NUPERIODOCONSUMO    PERICOSE.PECSCONS%TYPE;

        
        TBPRODUCTOS         DAPR_PRODUCT.TYTBPR_PRODUCT;
        RFPRODUCTS          CONSTANTS.TYREFCURSOR;

        NUIDX               NUMBER;

    BEGIN
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuConcLiquidadoEnDirecInst');

        NUPERIODOCONSUMO :=  INUPERIODOCONSUMO;
        
        IF (NUPERIODOCONSUMO IS NULL) THEN
            PKINSTANCEDATAMGR.GETCG_CONSUMPERIOD(NUPERIODOCONSUMO);
        END IF;

        
        NUADDRESSIDPRODACT := DAPR_PRODUCT.FNUGETADDRESS_ID(IRCPRODUCTO.SESUNUSE);
        
        
        IF (GNUPRODBYCONTINMEM = IRCPRODUCTO.SESUSUSC) THEN
            TBPRODUCTOS := GTBPRODUCTSBYCONT;
        ELSE
            
            GTBPRODUCTSBYCONT.DELETE;
            GNUPRODBYCONTINMEM := NULL;

            RFPRODUCTS := PKBCSUSCRIPC.FRFGETPRODUCTS(IRCPRODUCTO.SESUSUSC);
            FETCH  RFPRODUCTS BULK COLLECT INTO  TBPRODUCTOS;
            CLOSE  RFPRODUCTS;

            GTBPRODUCTSBYCONT := TBPRODUCTOS;
            GNUPRODBYCONTINMEM := IRCPRODUCTO.SESUSUSC;

        END IF;

        
        NUIDX := TBPRODUCTOS.FIRST;
        
        LOOP
        
            EXIT WHEN NUIDX IS NULL OR NUENCONTRO = 0;
            
            UT_TRACE.TRACE('Producto: '||TBPRODUCTOS(NUIDX).PRODUCT_ID||
                            ' Direcci�n: '||TBPRODUCTOS(NUIDX).ADDRESS_ID,10);

            
            IF ( TBPRODUCTOS(NUIDX).ADDRESS_ID = NUADDRESSIDPRODACT ) THEN

                
                PKBCCARGOS.OBTCARGOCONCPRODPECO
                    (
                        TBPRODUCTOS(NUIDX).PRODUCT_ID,
                        INUCONCEPTO,
                        NUPERIODOCONSUMO,
                        IRCPERIFACT.PEFACODI,
                        -1,
                        ONUCARGVALO);

                 IF (ONUCARGVALO <> 0) THEN
                    NUENCONTRO := 0;
                 END IF;
                 
            END IF;
            
             NUIDX := TBPRODUCTOS.NEXT(NUIDX);
             
        END LOOP;

        PKERRORS.POP;
        RETURN NUENCONTRO;
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
     END FNUCONCLIQUIDADOENDIRECINST;
     
    




























































    FUNCTION FNUOBTENERCARGOPROD(
        INUCONCEPTO     IN      CONCEPTO.CONCCODI%TYPE,
        INUMODORECLAMO  IN      NUMBER,
        INUSERVSUSC     IN      SERVSUSC.SESUNUSE%TYPE DEFAULT NULL,
        ISBDOSO         IN      CARGOS.CARGDOSO%TYPE DEFAULT NULL
    )
    RETURN NUMBER
    IS
        


        
        
        RCSERVSUSC              SERVSUSC%ROWTYPE;

        
        RCPERIFACT              PERIFACT%ROWTYPE;

        
        NUCONSUMPCYCLE          SERVSUSC.SESUCICO%TYPE;

        
        NUSERVSUSC              SERVSUSC.SESUNUSE%TYPE;
        
        
        NUCONSUMPERIOD          PERICOSE.PECSCONS%TYPE;
        
        
        NUCARGVALO              NUMBER := 0;

        
        NUCLAIMCONCEPT          CONCEPTO.CONCCODI%TYPE;
        
        
        NUACCOUNT               CARGOS.CARGCUCO%TYPE := -1;
        
        BOLCARGOENRECLAMO       BOOLEAN := FALSE;

        
        NUIDX                   NUMBER;
        
        
        TBCARGNUSE             PKTBLCARGOS.TYCARGNUSE;
    	TBCARGSIGN             PKTBLCARGOS.TYCARGSIGN;
    	TBCARGDOSO             PKTBLCARGOS.TYCARGDOSO;
    	TBCARGVALO             PKTBLCARGOS.TYCARGVALO;
    	TBCARGUNID             PKTBLCARGOS.TYCARGUNID;
    	TBCARGTIPR             PKTBLCARGOS.TYCARGTIPR;
    	TBCARGPEFA             PKTBLCARGOS.TYCARGPEFA;
    	TBCARGCODO             PKTBLCARGOS.TYCARGCODO;
    	TBCARGTICO             PKTBLTIPOCONS.TYTCONCODI;
    	TBCARGPECO             PKTBLPERICOSE.TYPECSCONS;
    	TBCARGMEMO             PKBCCARGOS.TYTBCARGFLFA;

        


        





















        PROCEDURE INICIALIZAR
        IS
        BEGIN
            PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtenerCargoProd.inicializar');
        
            
            IF (INUSERVSUSC IS NULL)  THEN
            
                PKINSTANCEDATAMGR.GETCG_PRODUCTRECORD(RCSERVSUSC);
                
            ELSE
                RCSERVSUSC := PKTBLSERVSUSC.FRCGETRECORD(INUSERVSUSC);
                
            END IF;

            
            NUSERVSUSC := RCSERVSUSC.SESUNUSE;

            
            PKINSTANCEDATAMGR.GETCG_CONSUMPTIONCYCLE(NUCONSUMPCYCLE);

            
            PKINSTANCEDATAMGR.GETCG_BILLPERIODRECORD(RCPERIFACT);

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
        END INICIALIZAR;

        

















        PROCEDURE INITRECLAMO
        IS
        BEGIN
            PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtenerCargoProd.initReclamo');
            
            
            PKBOCLAIMMEMORY.GETPARENTCLAIMCONCEPT(NUCLAIMCONCEPT);

            
            PKBOCLAIMMEMORY.GETACCOUNT(NUACCOUNT);

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
        END INITRECLAMO;


    BEGIN
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtenerCargoProd');

        
        
        IF ( INUSERVSUSC = PKCONSTANTE.NULLNUM ) THEN
            RETURN 0;
        END IF;

        INICIALIZAR;

        IF ( INUMODORECLAMO = 1) THEN
            INITRECLAMO;
            
            
            IF (NUCLAIMCONCEPT = INUCONCEPTO) THEN
                NUCARGVALO          := PKBOCLAIMMEMORY.FNUGETPARENTCLAIMVALUE;
                BOLCARGOENRECLAMO   := TRUE;
            ELSE
               
               
                NUACCOUNT:= NULL;
            END IF;

        END IF;
        
        IF ( BOLCARGOENRECLAMO = FALSE ) THEN

            
            PKINSTANCEDATAMGR.GETCG_CONSUMPERIOD(NUCONSUMPERIOD);

            TD('Parametros para buscar el cargo');
            TD('nuServsusc: ' || NUSERVSUSC
            ||' inuConcepto: ' || INUCONCEPTO
            ||' Periodo Consumo: ' || NUCONSUMPERIOD
            ||' Periodo Facturaci�n: ' || RCPERIFACT.PEFACODI
            ||' Doc. Soporte: ' || ISBDOSO);

            
            PKBORATINGMEMORYMGR.GETCHRGARRBYCONC
            (
                INUCONCEPTO,
                TBCARGNUSE,
            	TBCARGSIGN,
            	TBCARGDOSO,
            	TBCARGVALO,
            	TBCARGUNID,
            	TBCARGTIPR,
            	TBCARGPEFA,
            	TBCARGCODO,
            	TBCARGTICO,
            	TBCARGPECO,
            	TBCARGMEMO
            );

            PKGENERALSERVICES.TRACEDATA('Cargos en memoria: '||TBCARGPECO.COUNT);

            
            NUIDX := TBCARGPECO.FIRST;

            
            LOOP
            
                
                EXIT WHEN NUIDX IS NULL;

                

                IF ( NOT (INSTR('-'||TBCARGDOSO(NUIDX)||'-','-'||PKBILLCONST.CSBTOKEN_DIFERIDO) > 0 OR
                      INSTR('-'||TBCARGDOSO(NUIDX)||'-','-'||PKBILLCONST.CSBTOKEN_CUOTA_EXTRA) > 0
                     )
                ) THEN

                    
                    
                    IF
                    (
                        TBCARGNUSE(NUIDX) = NUSERVSUSC AND
                        TBCARGPECO(NUIDX) = NUCONSUMPERIOD AND
                        TBCARGPEFA(NUIDX) = NVL(RCPERIFACT.PEFACODI,TBCARGPEFA(NUIDX)) AND
                        TBCARGDOSO(NUIDX) = NVL(ISBDOSO,TBCARGDOSO(NUIDX)) AND
                        TBCARGTIPR(NUIDX) = PKBILLCONST.AUTOMATICO
                    )
                    THEN
                    
                        
                        IF ( TBCARGSIGN(NUIDX) = PKBILLCONST.CREDITO ) THEN
                            NUCARGVALO := NUCARGVALO - TBCARGVALO(NUIDX);
                        ELSIF ( TBCARGSIGN(NUIDX) = PKBILLCONST.DEBITO ) THEN
                            NUCARGVALO := NUCARGVALO + TBCARGVALO(NUIDX);
                        END IF;
                    
                    END IF;
                    
                END IF;

                
                NUIDX := TBCARGPECO.NEXT(NUIDX);
            
            END LOOP;

            PKGENERALSERVICES.TRACEDATA('nuCargvalo: '||NUCARGVALO);

            
            IF ( NUCARGVALO = 0 ) THEN
            
                
                PKBCCARGOS.OBTCARGOCONCPRODPECO
                (
                    NUSERVSUSC,
                    INUCONCEPTO,
                    NUCONSUMPERIOD,
                    RCPERIFACT.PEFACODI,
                    NUACCOUNT,
                    NUCARGVALO,
                    ISBDOSO
                );
            END IF;
        END IF;

        TD('inuConcepto: ' || INUCONCEPTO ||' nuCargvalo:'|| NUCARGVALO);

        IF (NUCARGVALO IS NULL) THEN
            NUCARGVALO := 0;
        END IF;

        PKERRORS.POP;
        RETURN NUCARGVALO;
        
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
     END FNUOBTENERCARGOPROD;

    















































    FUNCTION FNUOBTDIASACTIVOSPROD(

        INUMODORECLAMO      IN NUMBER,
        INUCONSUMPERIOD     PERICOSE.PECSCONS%TYPE
    )
    RETURN NUMBER
    IS
        



        
        NUCONCEPTO             CONCEPTO.CONCCODI%TYPE;
        
        
        RCSERVSUSC              SERVSUSC%ROWTYPE;
        
        
        NUCONTRATO              SERVSUSC.SESUSUSC%TYPE;

        
        NUPRODUCTO              SERVSUSC.SESUNUSE%TYPE;
        
        
        NUSERVICIO              SERVSUSC.SESUSERV%TYPE;
        
        
        RCPERIFACT              PERIFACT%ROWTYPE;
        
        
        RCSERVICIO              SERVICIO%ROWTYPE;

        
        DTFECHAINICONSUM       PERICOSE.PECSFECI%TYPE;

        
        DTFECHAFINCONSUM        PERICOSE.PECSFECF%TYPE;

    	
    	
    	TBCAMBIOSESTADO        PKBOPRODUCTBASICCHARGE.TYTBSTATUSCHANGES;

      	
      	NUSTATUSINDEX 			NUMBER;

        
      	DTFECHAINSTAL           DATE;
        
        
        DTFECHARETIRO           DATE;
        
        
        DTFECHAINICALC          DATE;

        
        DTFECHAFINCALC          DATE;
        
        
        NUDIASACT               NUMBER;

        
        NUDIASNOLIQ          NUMBER;
        
        
        RCPERIODOC          PERICOSE%ROWTYPE;
        
        
        RCCONFESCO              CONFESCO%ROWTYPE;

        


        



































        PROCEDURE INICIALIZAR
        IS
            RCFEULLICO  FEULLICO%ROWTYPE;
            
            
            SBADJUSTMODE    FA_APROMOFA.APMOPRGA%TYPE;

            
            SBRESTRATMODE  FA_APROMOFA.APMOPRGA%TYPE;
            
            
            BOISBUDGET BOOLEAN;
            
        BEGIN
            PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtDiasActivosProd.inicializar');

            
            SBADJUSTMODE := FA_BOAPPROBILLADJUSTMOV.FSBGETAPPROVALMODE;
            
            SBRESTRATMODE := FA_BOAPPROBILLADJUSTMOV.CSBRESTRAT;

            
            PKINSTANCEDATAMGR.GETCG_PRODUCTRECORD(RCSERVSUSC);
            
            IF (INUMODORECLAMO = 1) THEN

                
                PKBOCLAIMMEMORY.GETPARENTCLAIMCONCEPT(NUCONCEPTO);

            ELSE
                
                PKINSTANCEDATAMGR.GETCG_CONCEPT(NUCONCEPTO);

            END IF;

            
            NUCONTRATO := RCSERVSUSC.SESUSUSC;

            
            NUPRODUCTO := RCSERVSUSC.SESUNUSE;

            
            NUSERVICIO := RCSERVSUSC.SESUSERV;




            IF( INUCONSUMPERIOD IS NULL ) THEN
                
                PKINSTANCEDATAMGR.GETCG_CONSPERIODRECORD(RCPERIODOC);

                IF( RCPERIODOC.PECSCONS IS NULL) THEN
                    PKINSTANCEDATAMGR.GETCG_CONSUMPERIOD(RCPERIODOC.PECSCONS);
                    
                    PKBCPERICOSE.GETCACHERECORD(RCPERIODOC.PECSCONS, RCPERIODOC);
                END IF;
            ELSE
                
                PKBCPERICOSE.GETCACHERECORD(INUCONSUMPERIOD, RCPERIODOC);
            END IF;
            
            
            DTFECHAINICONSUM := TRUNC(RCPERIODOC.PECSFEAI);
            
            
            DTFECHAFINCONSUM := TRUNC(RCPERIODOC.PECSFEAF);
            
            
            
            
            IF (SBADJUSTMODE IS NULL OR SBADJUSTMODE <> SBRESTRATMODE) THEN

                
                IF (FA_BCFEULLICO.FBOEXISTS(NUPRODUCTO,NUCONCEPTO)) THEN

                    
                    FA_BCFEULLICO.GETRECORD(NUPRODUCTO,NUCONCEPTO, RCFEULLICO);

                    
                END IF;
            
            END IF;
                
            
            
            
            
            
            

            BOISBUDGET := FA_BOBUDGET.FBOGETISBUDGET;

            IF ( BOISBUDGET ) THEN
                DTFECHAINSTAL := NVL(TRUNC(RCFEULLICO.FELIFEUL)+1,TRUNC(RCSERVSUSC.SESUFEIN));
            ELSE
                DTFECHAINSTAL := NVL(TRUNC(RCFEULLICO.FELIFEUL)+1,TRUNC(RCSERVSUSC.SESUFEIN+1));
            END IF;
            

            
            DTFECHARETIRO  := NVL(TRUNC(RCSERVSUSC.SESUFERE),TRUNC(PKGENERALSERVICES.FDTGETMAXDATE));

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
        END INICIALIZAR;
        
        























        PROCEDURE OBTCAMBIOSESTADO
        IS
            
            
            TBHISTCAMBIOSEST                   PKBCHICAESCO.TYTBHICAESCO;
            
            
            DTFECHAINICAMBIOEST                DATE;

            
            BLESTADONOLIQ                      BOOLEAN;

            
            DTFECHATOPE                        DATE;

        	
        	NUHISTINDEX                        NUMBER;

        BEGIN
        
            PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtDiasActivosProd.ObtCambiosEstado');
            
            
            IF (DTFECHAINSTAL <= DTFECHAINICONSUM) THEN
                DTFECHAINICALC := DTFECHAINICONSUM;
            ELSE
                DTFECHAINICALC := DTFECHAINSTAL;
            END IF;

            
            IF (DTFECHARETIRO >= DTFECHAFINCONSUM) THEN
                DTFECHAFINCALC := DTFECHAFINCONSUM;
            ELSE
                DTFECHAFINCALC := DTFECHARETIRO;
            END IF;

            UT_TRACE.TRACE('- dtFechaIniCalc: '||DTFECHAINICALC,2);
            UT_TRACE.TRACE('- dtFechaFinCalc: '||DTFECHAFINCALC,2);
            
            


            DTFECHATOPE := TO_DATE(TO_CHAR(DTFECHAFINCALC,'DD-MM-YYYY')||' 23:59:59','dd-mm-yyyy hh24:mi:ss');
            
            
            
            
            PKBCHICAESCO.GETSTATUSCHANGES
            (
                NUCONTRATO,                     
                NUPRODUCTO,                     
                DTFECHATOPE,                    
                TBHISTCAMBIOSEST                
            );

            
            IF ( TBHISTCAMBIOSEST.FIRST IS NULL )
            THEN
            
                PKERRORS.POP;
                RETURN;
            
            END IF ;

            
            
            DTFECHAINICAMBIOEST := DTFECHAINICALC;

            
            NUHISTINDEX := TBHISTCAMBIOSEST.FIRST;

            LOOP
            
                EXIT WHEN NUHISTINDEX IS NULL;

                
                
                IF ( TBHISTCAMBIOSEST(NUHISTINDEX).HCECFECH >= DTFECHAINICALC  ) THEN
                

                    
                    PKINSTANCEDATAMGR.GETRECORDCONFSTATUSSUSPEND
                	(
                	    NUSERVICIO,
                	    TBHISTCAMBIOSEST(NUHISTINDEX).HCECECAN,
                	    RCCONFESCO
                	);

                    UT_TRACE.TRACE('Estado Servicio: '||RCCONFESCO.COECCODI||'-'||RCCONFESCO.COECFACT,2);

                    
                    IF( RCCONFESCO.COECFACT = PKCONSTANTE.NO ) THEN
                        BLESTADONOLIQ := TRUE;

                    ELSE
                        
                        BLESTADONOLIQ := PKBCCNLISEES.FBLEXISTS (
                            NUSERVICIO,                                
                            TBHISTCAMBIOSEST(NUHISTINDEX).HCECECAN,    
                            NUCONCEPTO );                              

                    END IF;

                    
            		

            		IF ( BLESTADONOLIQ ) THEN
                    
                        
                        IF ( TRUNC(TBHISTCAMBIOSEST(NUHISTINDEX).HCECFECH) - TRUNC(DTFECHAINICAMBIOEST) > 0 ) THEN
                        
                            
                            
                            NUSTATUSINDEX := NVL(NUSTATUSINDEX,0) + 1;
                            TBCAMBIOSESTADO( NUSTATUSINDEX ).HCECESCO := TBHISTCAMBIOSEST(NUHISTINDEX).HCECECAN;
                            TBCAMBIOSESTADO( NUSTATUSINDEX ).HCECFEIN := DTFECHAINICAMBIOEST;
                            TBCAMBIOSESTADO( NUSTATUSINDEX ).HCECFEFI := TBHISTCAMBIOSEST(NUHISTINDEX).HCECFECH - 1;
                        
                        END IF;
                    
            		END IF;
                
                END IF;
                
                IF TBHISTCAMBIOSEST(NUHISTINDEX).HCECFECH > DTFECHAINICAMBIOEST THEN
                    
                    DTFECHAINICAMBIOEST := TBHISTCAMBIOSEST(NUHISTINDEX).HCECFECH;
                END IF;

                
                NUHISTINDEX := TBHISTCAMBIOSEST.NEXT( NUHISTINDEX );
            
            END LOOP;

            
            
            IF ( DTFECHAINICAMBIOEST < DTFECHAINICALC ) THEN
                DTFECHAINICAMBIOEST := DTFECHAINICALC;
            END IF ;

        	
        	
            NUHISTINDEX := TBHISTCAMBIOSEST.LAST;

            
            PKINSTANCEDATAMGR.GETRECORDCONFSTATUSSUSPEND
        	(
        	    NUSERVICIO,
        	    TBHISTCAMBIOSEST(NUHISTINDEX).HCECECAC,
        	    RCCONFESCO
        	);

        	UT_TRACE.TRACE('- Estado actual: '||RCCONFESCO.COECCODI||'-'||RCCONFESCO.COECFACT,2);

            
            IF( RCCONFESCO.COECFACT = PKCONSTANTE.NO ) THEN
                BLESTADONOLIQ := TRUE;
            ELSE
                
                BLESTADONOLIQ := PKBCCNLISEES.FBLEXISTS(
                    NUSERVICIO,                                
                    TBHISTCAMBIOSEST(NUHISTINDEX).HCECECAC,    
                    NUCONCEPTO );                              
            END IF;

       		
       		
        	IF ( BLESTADONOLIQ ) THEN
            
                
                
                NUSTATUSINDEX := NVL(NUSTATUSINDEX,0) + 1;
                TBCAMBIOSESTADO( NUSTATUSINDEX ).HCECESCO := TBHISTCAMBIOSEST(NUHISTINDEX).HCECECAC;
                TBCAMBIOSESTADO( NUSTATUSINDEX ).HCECFEIN := DTFECHAINICAMBIOEST;
                TBCAMBIOSESTADO( NUSTATUSINDEX ).HCECFEFI := DTFECHAFINCALC;
            
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
                PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
        END OBTCAMBIOSESTADO;
        
        
        















        PROCEDURE OBTDIASNOLIQ
        IS
        	
        	DTFECHAINIPROC	  	     DATE;

        	
        	DTFECHAFINPROC	  	     DATE;
        	
            
          	TBDIASNOLIQ              PKBOPRODUCTBASICCHARGE.TYTBDAYSNOTRATED;

       	    
        	NUDAYSINDEX				 NUMBER;

        BEGIN
        
            PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtDiasActivosProd.ObtDiasNoLiq');
            
        	
        	NUSTATUSINDEX := TBCAMBIOSESTADO.FIRST;

        	LOOP
            
                
        	    EXIT WHEN NUSTATUSINDEX IS NULL;

                
                
        		DTFECHAINIPROC := TRUNC(TBCAMBIOSESTADO( NUSTATUSINDEX ).HCECFEIN);
        		DTFECHAFINPROC := TRUNC(TBCAMBIOSESTADO( NUSTATUSINDEX ).HCECFEFI);

        		LOOP
                
        		    EXIT WHEN DTFECHAINIPROC > DTFECHAFINPROC;

                    
                    
            		NUDAYSINDEX := TO_NUMBER( TO_CHAR(DTFECHAINIPROC,'YYYYMMDD') );
        			TBDIASNOLIQ( NUDAYSINDEX ) := DTFECHAINIPROC;
        			DTFECHAINIPROC := DTFECHAINIPROC + 1;

            		
            		PKGENERALSERVICES.TRACEDATA(CSBSEPARATOR);
            		PKGENERALSERVICES.TRACEDATA('Informacion de dia no liquidado ');
            		PKGENERALSERVICES.TRACEDATA('Dia '|| TBDIASNOLIQ( NUDAYSINDEX ) );
            		PKGENERALSERVICES.TRACEDATA(CSBSEPARATOR);
                
        		END LOOP;

                
        		NUSTATUSINDEX := TBCAMBIOSESTADO.NEXT( NUSTATUSINDEX );
            
        	END LOOP;
        	
        	NUDIASNOLIQ := TBDIASNOLIQ.COUNT;
        	
            UT_TRACE.TRACE('Cant. D�as No liq.: '||TBDIASNOLIQ.COUNT,5);

            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
                PKERRORS.POP;
                RAISE;
            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
        
        END OBTDIASNOLIQ;
        
        














        PROCEDURE CALCDIASACTIVOS
        IS
            
            DTFECHAINICALC          DATE;

            
            DTFECHAFINCALC          DATE;

        BEGIN
            PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtDiasActivosProd.CalcDiasActivos');

            IF (DTFECHAINSTAL <= DTFECHAINICONSUM) THEN
                DTFECHAINICALC := DTFECHAINICONSUM;
            ELSE
                DTFECHAINICALC := DTFECHAINSTAL;
            END IF;


            IF (DTFECHARETIRO >= DTFECHAFINCONSUM) THEN
                DTFECHAFINCALC := DTFECHAFINCONSUM;
            ELSE
                DTFECHAFINCALC := DTFECHARETIRO;
            END IF;

            
            NUDIASACT := DTFECHAFINCALC - DTFECHAINICALC + 1 - NUDIASNOLIQ;

            IF (NUDIASACT < 0) THEN
               NUDIASACT := 0;
            END IF;

            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
                PKERRORS.POP;
                RAISE;
            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
        END CALCDIASACTIVOS;

    BEGIN
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtDiasActivosProd');

        
        INICIALIZAR;

        
        OBTCAMBIOSESTADO;
        
        
        OBTDIASNOLIQ;
        
        
        CALCDIASACTIVOS;

        PKGENERALSERVICES.TRACEDATA('Numero Dias Activos: ' || NUDIASACT);

        PKERRORS.POP;
        RETURN NUDIASACT;
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

     END FNUOBTDIASACTIVOSPROD;

    
































    FUNCTION FNUOBTENERTOTLIQBASEPROD(
        INUCONCEPTO        IN CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO        IN SERVSUSC.SESUNUSE%TYPE,
        INUSERVICIO        IN SERVSUSC.SESUSERV%TYPE,
        INUPERICOSE        IN PERICOSE.PECSCONS%TYPE,
        INUCICLOCONSUMO    IN CICLCONS.CICOCODI%TYPE,
        INUPERIFACT        IN PERIFACT.PEFACODI%TYPE,
        INUCUENTACOBRO     IN CUENCOBR.CUCOCODI%TYPE
    )
    RETURN NUMBER
    IS

        TBCONCEPTS      PKBCCONCBALI.TYCOBLCONC;
        NUTOTALCARGOS   CARGOS.CARGVALO%TYPE :=0;
        NUCARGVALO      CARGOS.CARGVALO%TYPE :=0;
        NUIDX           NUMBER;
        NUPERICOSE      PERICOSE.PECSCONS%TYPE;

    BEGIN
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtenerTotLiqBaseProd');
    
        NUPERICOSE := INUPERICOSE;
        
        
        
        IF (NUPERICOSE IS NULL) THEN
            PKINSTANCEDATAMGR.GETCG_CONSUMPERIOD(NUPERICOSE);
        END IF;

        
        
        PKBCCONCBALI.GETCONCEPTSBYBASECONC
            (
                INUCONCEPTO,
                TBCONCEPTS
            );


        NUIDX := TBCONCEPTS.FIRST ;

        IF (NUIDX IS NULL )  THEN
            NUTOTALCARGOS := 0;

        ELSE

            LOOP
                EXIT WHEN NUIDX IS NULL;

                
                PKBCCARGOS.OBTCARGOCONCPRODPECO
                    (
                        INUPRODUCTO,
                        TBCONCEPTS(NUIDX),
                        NUPERICOSE,
                        INUPERIFACT,
                        INUCUENTACOBRO,
                        NUCARGVALO
                    );

                NUTOTALCARGOS := NUTOTALCARGOS + NVL(NUCARGVALO,0);

                NUIDX := TBCONCEPTS.NEXT (NUIDX) ;

            END LOOP;
        END IF;

        PKERRORS.POP;
        RETURN NUTOTALCARGOS;
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
    END FNUOBTENERTOTLIQBASEPROD;
    
    


















    FUNCTION FNUMODORECLAMO
    RETURN NUMBER
    IS
        NUMODORECLAMO NUMBER;
    BEGIN
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuModoReclamo');

        IF (PKBOCLAIMMEMORY.FBLCONSUMPUNITSLOADED) THEN
                NUMODORECLAMO := 1;
        ELSE
                NUMODORECLAMO := 0;
        END IF;
        
        PKERRORS.POP;
        RETURN NUMODORECLAMO;
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
    END FNUMODORECLAMO;
    

    




















    FUNCTION FSBOBTFECHAPERIFACT
    (
        IRCPERIFACT         PERIFACT%ROWTYPE
    )
    RETURN VARCHAR
    IS
        SBFECHAPERIFACT     VARCHAR2(10);
    BEGIN
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fsbObtFechaPeriFact');

        SBFECHAPERIFACT:= TRIM( TO_CHAR( IRCPERIFACT.PEFAANO,'9999' ) )
                               || TRIM( TO_CHAR( IRCPERIFACT.PEFAMES,'09' ) );

        PKERRORS.POP;
        RETURN SBFECHAPERIFACT;
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
    END FSBOBTFECHAPERIFACT;


    



































    FUNCTION FSBOBTCADPEFAPECOLIQ
    (
        INUPERICOSE IN  PERICOSE.PECSCONS%TYPE,
        INUSESUSERV IN  SERVSUSC.SESUSERV%TYPE,
        INUCICLO    IN  CICLO.CICLCODI%TYPE,
        ISBTIPOPER  IN  CONCEPTO.CONCTICC%TYPE
    )
    RETURN VARCHAR
    IS
        SBFECHAPERIFACT     VARCHAR2(10);

        NUPEFAPECO          PERIFACT.PEFACODI%TYPE;
        
        RCSERVICIO          SERVICIO%ROWTYPE;

        RCPERIFACT          PERIFACT%ROWTYPE;
    BEGIN
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fsbObtCadPefaPecoLiq');
        
        
        RCSERVICIO := PKBCSERVICIO.FRCGETPRODUCTTYPERECORD(INUSESUSERV);

        
        PKBCPERIFACT.GETBILLPERBYCONSPER
        (
            INUCICLO,
            INUPERICOSE,
            NUPEFAPECO,
            RCSERVICIO.SERVTICO,
            ISBTIPOPER
        );
        
        
        RCPERIFACT := PKBCPERIFACT.FRCGETPERIOD(NUPEFAPECO);

        SBFECHAPERIFACT := TRIM( TO_CHAR( RCPERIFACT.PEFAANO,'9999' ) )
                               || TRIM( TO_CHAR( RCPERIFACT.PEFAMES,'09' ) );

        PKERRORS.POP;
        RETURN SBFECHAPERIFACT;
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
    END FSBOBTCADPEFAPECOLIQ;


    































    FUNCTION FNUOBTCANTPRODPORTIPRYDIIN
    (
        INUTIPOPROD     IN  SERVSUSC.SESUSERV%TYPE,
        INUDIREINST     IN  PR_PRODUCT.ADDRESS_ID%TYPE,
        INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE,
        ISBFORMALIQ     IN  CONCEPTO.CONCTICC%TYPE
    )
    RETURN NUMBER
    IS
        
        NUCANTPROD      NUMBER;

        
        DTFECHAINI      DATE;
        
        
        DTFECHAFIN      DATE;
    BEGIN
    
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtCantProdPorTiprYDiin');

        
        OBTFECHASPERICOSE
        (
            INUPERICOSE,
            ISBFORMALIQ,
            DTFECHAINI,
            DTFECHAFIN
        );

        
        NUCANTPROD := PKBCSERVNUMBER.FNUOBTCANTPRODPORTIPRYDIIN
                      (
                          INUTIPOPROD,
                          INUDIREINST,
                          DTFECHAINI
                      );

        PKERRORS.POP;
        RETURN ( NUCANTPROD );
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
    
    END FNUOBTCANTPRODPORTIPRYDIIN;

    

































    FUNCTION FNUOBTCANTPRODPORCLIEYTIPR
    (
        INUSUSCRIPC     IN  SERVSUSC.SESUSUSC%TYPE,
        INUTIPOPROD     IN  SERVSUSC.SESUSERV%TYPE,
        INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE,
        ISBFORMALIQ     IN  CONCEPTO.CONCTICC%TYPE
    )
    RETURN NUMBER
    IS
        
        NUCANTPROD      NUMBER := 0;

        
        NUCLIENTE       GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE;

        
        DTFECHAINI      DATE;

        
        DTFECHAFIN      DATE;

        
        TBSUSCRIP       PKBCSUSCRIPC.TYTBSUSCRIPC;
        NUIDX           BINARY_INTEGER;
    BEGIN
    
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtCantProdPorClieYTipr');

        
        OBTFECHASPERICOSE
        (
            INUPERICOSE,
            ISBFORMALIQ,
            DTFECHAINI,
            DTFECHAFIN
        );

        
        NUCLIENTE := PKTBLSUSCRIPC.FNUGETCUSTOMER(INUSUSCRIPC);

        
        TBSUSCRIP := PKBCSUSCRIPC.FTBSUBSCBYCLIENTID(NUCLIENTE);

        
        NUIDX := TBSUSCRIP.FIRST;

        
        LOOP
        
            
            EXIT WHEN NUIDX IS NULL;

            
            IF  GC_BCCASTIGOCARTERA.FSBSUSCESTACASTIGADA( TBSUSCRIP(NUIDX).SUSCCODI ) =
                PKCONSTANTE.NO
            THEN
                
                NUCANTPROD := NUCANTPROD +
                              PKBCSERVNUMBER.FNUOBTCANTPRODPORSUSCYTIPR(
                                                    TBSUSCRIP(NUIDX).SUSCCODI,
                                                    INUTIPOPROD,
                                                    DTFECHAINI );
            END IF;
            
            
            NUIDX := TBSUSCRIP.NEXT( NUIDX );
        
        END LOOP;

        PKERRORS.POP;
        RETURN ( NUCANTPROD );
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
    
    END FNUOBTCANTPRODPORCLIEYTIPR;

    

































    FUNCTION FNUOBTCANTPRODPORSUSCYTIPR
    (
        INUSUSCRIPC     IN  SERVSUSC.SESUSUSC%TYPE,
        INUTIPOPROD     IN  SERVSUSC.SESUSERV%TYPE,
        INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE,
        ISBFORMALIQ     IN  CONCEPTO.CONCTICC%TYPE
    )
    RETURN NUMBER
    IS
        
        NUCANTPROD      NUMBER;

        
        DTFECHAINI      DATE;

        
        DTFECHAFIN      DATE;
    BEGIN
    
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtCantProdPorSuscYTipr');

        
        OBTFECHASPERICOSE
        (
            INUPERICOSE,
            ISBFORMALIQ,
            DTFECHAINI,
            DTFECHAFIN
        );

        
        IF GC_BCCASTIGOCARTERA.FSBSUSCESTACASTIGADA( INUSUSCRIPC ) = PKCONSTANTE.NO
        THEN
        
            NUCANTPROD := 0;

        ELSE
            
            NUCANTPROD := PKBCSERVNUMBER.FNUOBTCANTPRODPORSUSCYTIPR
                          (
                              INUSUSCRIPC,
                              INUTIPOPROD,
                              DTFECHAINI
                          );
        END IF;
        
        PKERRORS.POP;
        RETURN ( NUCANTPROD );
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
    
    END FNUOBTCANTPRODPORSUSCYTIPR;
    
    





















    FUNCTION FNUOBTCUENTASVENCIDAS
    (
        INUSERVSUSC     IN  SERVSUSC.SESUNUSE%TYPE
    )
    RETURN NUMBER
    IS
        
        NUCANTCUCO      NUMBER;

        
        CUCUENTAS   PKCONSTANTE.TYREFCURSOR;

        
        TBCUCOCODI      PKTBLCUENCOBR.TYCUCOCODI;
        TBCUCOSACU      PKTBLCUENCOBR.TYCUCOSACU;
    BEGIN
    
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtCuentasVencidas');
        
        
        CUCUENTAS := PKBCACCOUNTS.FCUGETACCWITHBALEXP
                     (
                         INUSERVSUSC,
                         SYSDATE
                     );

        
        FETCH CUCUENTAS BULK COLLECT INTO TBCUCOCODI, TBCUCOSACU;
        CLOSE CUCUENTAS;

        
        IF ( TBCUCOCODI.FIRST IS NOT NULL) THEN
            NUCANTCUCO := TBCUCOCODI.COUNT;
        ELSE
            NUCANTCUCO := 0;
        END IF;

        PKERRORS.POP;
        RETURN ( NUCANTCUCO );
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
    
    END FNUOBTCUENTASVENCIDAS;
    
    





















    FUNCTION FSBOBTENERCALLEDIRE
    (
        INUSERVSUSC     IN  SERVSUSC.SESUNUSE%TYPE
    )
    RETURN AB_WAY_BY_LOCATION.DESCRIPTION%TYPE
    IS
    BEGIN
    
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fsbObtenerCalleDire');
        
        
        IF ( GSBCALLE IS NULL ) THEN
            
            OBTENERCALLEALTURA(INUSERVSUSC);
        END IF;

        PKERRORS.POP;
        RETURN (GSBCALLE);
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
    
    END FSBOBTENERCALLEDIRE;

    





















    FUNCTION FSBOBTENERALTURADIRE
    (
        INUSERVSUSC     IN  SERVSUSC.SESUNUSE%TYPE
    )
    RETURN VARCHAR2
    IS
    BEGIN
    
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fsbObtenerAlturaDire');
        
        
        IF ( GSBALTURA IS NULL ) THEN
            
            OBTENERCALLEALTURA(INUSERVSUSC);
        END IF;

        PKERRORS.POP;
        RETURN (GSBALTURA);
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
    
    END FSBOBTENERALTURADIRE;
    

    























    FUNCTION FNUVALIDARRETIROPROD
    (
        IRCPRODUCTO      IN  SERVSUSC%ROWTYPE,
        IRCPERIFACT      IN  PERIFACT%ROWTYPE
    )
    RETURN NUMBER
    IS
        NURETIRADO NUMBER :=0;
        
    BEGIN
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuValidarRetiroProd');
        
        IF (IRCPRODUCTO.SESUFERE BETWEEN IRCPERIFACT.PEFAFIMO AND IRCPERIFACT.PEFAFFMO) THEN
            NURETIRADO := 1;
        END IF;
        
        PKERRORS.POP;
        RETURN NURETIRADO;
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

    END FNUVALIDARRETIROPROD;
    
    
































    FUNCTION FNUVALPRODPORTIPRYCLIE
    (
        INUSUSCRIPC     IN  SERVSUSC.SESUSUSC%TYPE,
        INUTIPOPROD     IN  SERVSUSC.SESUSERV%TYPE,
        INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE
    )
    RETURN NUMBER
    IS
        
        NUVALIDAR       NUMBER;

        
        NUCLIENTE       GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE;

        
        DTFECHAMAX      DATE := TO_DATE('01/01/1900 00:00:00','DD/MM/YYYY hh24:MI:SS');

        
        NUSESUNUSE      SERVSUSC.SESUNUSE%TYPE;

        
        NUSESUCICO      SERVSUSC.SESUCICO%TYPE;

        
        TBSESUNUSE      PKTBLSERVSUSC.TYSESUNUSE;
        TBSESUFERE      PKTBLSERVSUSC.TYSESUFERE;
        TBSESUCICO      PKTBLSERVSUSC.TYSESUCICO;

        
        RCPERIODOACT    PERICOSE%ROWTYPE;
    BEGIN
    
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuValProdPorTiPrYClie');
        
        
        NUCLIENTE := PKTBLSUSCRIPC.FNUGETCUSTOMER(INUSUSCRIPC);

        
        PKBCSERVNUMBER.OBTPRODPORTIPRYCLIE
        (
            NUCLIENTE,
            INUTIPOPROD,
            TBSESUNUSE,
            TBSESUFERE,
            TBSESUCICO
        );

        
        IF ( TBSESUNUSE.FIRST IS NULL ) THEN
        
            PKERRORS.POP;
            RETURN ( PKCONSTANTE.NULLNUM );
        
        END IF;

        
        FOR NUINDPROD IN TBSESUNUSE.FIRST .. TBSESUNUSE.LAST LOOP
        
            
            IF ( TBSESUFERE(NUINDPROD) > PKGENERALSERVICES.FDTGETSYSTEMDATE )
            THEN
            
                PKERRORS.POP;
                RETURN ( PKBILLCONST.CERO );
            
            END IF;

            
            IF ( TBSESUFERE(NUINDPROD) > DTFECHAMAX ) THEN
                
                DTFECHAMAX := TBSESUFERE(NUINDPROD);
                NUSESUNUSE := TBSESUNUSE(NUINDPROD);
                NUSESUCICO := TBSESUCICO(NUINDPROD);
            END IF;
        
        END LOOP;

        
        PKBCPERICOSE.GETCACHERECORDEX(INUPERICOSE, RCPERIODOACT);

        
        NUVALIDAR := PKBCPERICOSE.FNUOBTPERIODOSFECHAINS
                     (
                         RCPERIODOACT,
                         DTFECHAMAX,
                         NUSESUCICO,
                         PKCONSTANTE.CSBABONO
                     );

        PKERRORS.POP;
        RETURN ( NUVALIDAR );
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
    
    END FNUVALPRODPORTIPRYCLIE;

    
































    FUNCTION FNUVALPRODPORTIPRYSUSC
    (
        INUSUSCRIPC     IN  SERVSUSC.SESUSUSC%TYPE,
        INUTIPOPROD     IN  SERVSUSC.SESUSERV%TYPE,
        INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE
    )
    RETURN NUMBER
    IS
        
        NUVALIDAR       NUMBER;

        
        DTFECHAMAX      DATE := TO_DATE('01/01/1900 00:00:00','DD/MM/YYYY hh24:MI:SS');

        
        NUSESUNUSE      SERVSUSC.SESUNUSE%TYPE;

        
        NUSESUCICO      SERVSUSC.SESUCICO%TYPE;

        
        TBSESUNUSE      PKTBLSERVSUSC.TYSESUNUSE;
        TBSESUFERE      PKTBLSERVSUSC.TYSESUFERE;
        TBSESUCICO      PKTBLSERVSUSC.TYSESUCICO;

        
        RCPERIODOACT    PERICOSE%ROWTYPE;
    BEGIN
    
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuValProdPorTiPrYSusc');
        
        
        PKBCSERVSUSC.OBTPRODPORTIPRYSUSC
        (
            INUSUSCRIPC,
            INUTIPOPROD,
            TBSESUNUSE,
            TBSESUFERE,
            TBSESUCICO
        );

        
        IF ( TBSESUNUSE.FIRST IS NULL ) THEN
        
            PKERRORS.POP;
            RETURN ( PKCONSTANTE.NULLNUM );
        
        END IF;

        
        FOR NUINDPROD IN TBSESUNUSE.FIRST .. TBSESUNUSE.LAST LOOP
        
            
            IF ( TBSESUFERE(NUINDPROD) > PKGENERALSERVICES.FDTGETSYSTEMDATE )
            THEN
            
                PKERRORS.POP;
                RETURN ( PKBILLCONST.CERO );
            
            END IF;

            
            IF ( TBSESUFERE(NUINDPROD) > DTFECHAMAX ) THEN
                
                DTFECHAMAX := TBSESUFERE(NUINDPROD);
                NUSESUNUSE := TBSESUNUSE(NUINDPROD);
                NUSESUCICO := TBSESUCICO(NUINDPROD);
            END IF;
        
        END LOOP;

        
        PKBCPERICOSE.GETCACHERECORDEX(INUPERICOSE, RCPERIODOACT);

        
        NUVALIDAR := PKBCPERICOSE.FNUOBTPERIODOSFECHAINS
                     (
                         RCPERIODOACT,
                         DTFECHAMAX,
                         NUSESUCICO,
                         PKCONSTANTE.CSBABONO
                     );

        PKERRORS.POP;
        RETURN ( NUVALIDAR );
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
    
    END FNUVALPRODPORTIPRYSUSC;
    
    



































    FUNCTION FNUVALIDARPROMVIGENTE
    (
        INUSERVSUSC     IN  SERVSUSC.SESUNUSE%TYPE,
        INUPROMOID      IN  CC_PROMOTION.PROMOTION_ID%TYPE,
        INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE,
        ISBFORMALIQ     IN  CONCEPTO.CONCTICC%TYPE
    )
    RETURN NUMBER
    IS
        
        NUVALIDAR       NUMBER := 0;

        
        DTFECHAINI      DATE;

        
        DTFECHAFIN      DATE;
    BEGIN
    
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuValidarPromVigente');

        
        OBTFECHASPERICOSE
        (
            INUPERICOSE,
            ISBFORMALIQ,
            DTFECHAINI,
            DTFECHAFIN
        );

        
        NUVALIDAR := PR_BCPROMOTION.FNUVALIDATEPROMOBYPROD
                     (
                         INUSERVSUSC,
                         INUPROMOID,
                         DTFECHAFIN
                     );

        PKERRORS.POP;
        RETURN ( NUVALIDAR );
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
    
    END FNUVALIDARPROMVIGENTE;
    
    































    FUNCTION FNUOBTMESESTRANSPROMO
    (
        INUSERVSUSC     IN  SERVSUSC.SESUNUSE%TYPE,
        INUPROMOID      IN  CC_PROMOTION.PROMOTION_ID%TYPE,
        INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE,
        ISBFORMALIQ     IN  CONCEPTO.CONCTICC%TYPE
    )
    RETURN NUMBER
    IS
        
        NUMESACTUAL     NUMBER := 0;

        
        DTFECHAINI      PERICOSE.PECSFEAI%TYPE;

        
        DTFECHAFIN      PERICOSE.PECSFEAF%TYPE;
    BEGIN
    
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtMesesTransPromo');

        
        OBTFECHASPERICOSE
        (
            INUPERICOSE,
            ISBFORMALIQ,
            DTFECHAINI,
            DTFECHAFIN
        );

        
        NUMESACTUAL := PR_BCPROMOTION.FNUGETCURRENTMONTH
                       (
                           INUSERVSUSC,
                           INUPROMOID,
                           DTFECHAINI,
                           DTFECHAFIN
                       );

        PKERRORS.POP;
        RETURN ( NUMESACTUAL );
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
    
    END FNUOBTMESESTRANSPROMO;
    
    

































    FUNCTION FNUOBTTOTALMESESPROMO
    (
        INUSERVSUSC     IN  SERVSUSC.SESUNUSE%TYPE,
        INUPROMOID      IN  CC_PROMOTION.PROMOTION_ID%TYPE,
        INUPERIODOC     IN  PERICOSE.PECSCONS%TYPE,
        ISBFORMALIQ     IN  CONCEPTO.CONCTICC%TYPE
    )
    RETURN NUMBER
    IS
        
        NUTOTALMESES    NUMBER := 0;
        
        
        DTFECHAINI      PERICOSE.PECSFEAI%TYPE;

        
        DTFECHAFIN      PERICOSE.PECSFEAF%TYPE;
    BEGIN
    
        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuObtTotalMesesPromo');
        
        
        OBTFECHASPERICOSE
        (
            INUPERIODOC,
            ISBFORMALIQ,
            DTFECHAINI,
            DTFECHAFIN
        );

        
        NUTOTALMESES := PR_BCPROMOTION.FNUGETTOTALMONTHS
                        (
                            INUSERVSUSC,
                            INUPROMOID,
                            DTFECHAINI,
                            DTFECHAFIN
                        );

        PKERRORS.POP;
        RETURN ( NUTOTALMESES );
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
    
    END FNUOBTTOTALMESESPROMO;


    






































    FUNCTION FSBVALBILLPUNCTUALPAY
    (
        IRCPRODUCT          SERVSUSC%ROWTYPE,
        INUCONCEPT          CONCEPTO.CONCCODI%TYPE,
        INUCONSPERIOD       PERICOSE.PECSCONS%TYPE
    )
    RETURN VARCHAR
    IS
        
        NUBILLINGPERIOD     PERIFACT.PEFACODI%TYPE;

        
        RCPRODUCTTYPE       SERVICIO%ROWTYPE;

        
        RCPREVBILLPERIOD    PERIFACT%ROWTYPE;
        
        
        RCBILL              FACTURA%ROWTYPE;
        
        
        RCCONCEPT           CONCEPTO%ROWTYPE;
        
        
        TBACCOUNTS          PKBCCUENCOBR.TYTBACCOUNTS;
        
        
        NUINDEX             BINARY_INTEGER;
        
        
        RCACCOUNT           CUENCOBR%ROWTYPE;
        
        
        SBPUNCTUAL          VARCHAR2(2);
        
    BEGIN

        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fsbValBillPunctualPay');

        
        SBPUNCTUAL := PKCONSTANTE.SI;

        
        RCPRODUCTTYPE := PKBCSERVICIO.FRCGETPRODUCTTYPERECORD(IRCPRODUCT.SESUSERV);
        
        
        PKCONCEPTMGR.GETRECORD(INUCONCEPT, RCCONCEPT);
        
        
        PKBCPERIFACT.GETBILLPERBYCONSPER(IRCPRODUCT.SESUCICL   ,
                                         INUCONSPERIOD         ,
                                         NUBILLINGPERIOD       ,
                                         RCPRODUCTTYPE.SERVTICO,
                                         RCCONCEPT.CONCTICC    );

        
        PKBILLINGPERIODMGR.GETPREVBILLPERIODBYDATE(NUBILLINGPERIOD,
                                                   RCPREVBILLPERIOD);

        
        RCBILL := PKBCFACTURA.FRCGETSUSCBILLBYPERIOD(IRCPRODUCT.SESUSUSC             ,
                                                     RCPREVBILLPERIOD.PEFACODI       ,
                                                     GE_BOCONSTANTS.FNUGETDOCTYPECONS);
        
        
        IF (RCBILL.FACTCODI IS NOT NULL) THEN

            
            
            IF (PKBCACCOUNTSTATUS.FNUGETBALANCE(RCBILL.FACTCODI) > 0) THEN

                SBPUNCTUAL := PKCONSTANTE.NO;
            ELSE

                
                PKBCCUENCOBR.GETACCOUNTSBYBILL(RCBILL.FACTCODI, TBACCOUNTS);

                
                NUINDEX := TBACCOUNTS.FIRST;

                LOOP
                    EXIT WHEN NUINDEX IS NULL;

                    
                    RCACCOUNT := TBACCOUNTS(NUINDEX);

                    
                    IF (NVL(RCACCOUNT.CUCOFEPA, PKGENERALSERVICES.FDTGETMAXDATE) > RCACCOUNT.CUCOFEVE) THEN
                        
                        
                        SBPUNCTUAL := PKCONSTANTE.NO;
                        EXIT;
                    END IF;

                    NUINDEX := TBACCOUNTS.NEXT (NUINDEX) ;

                END LOOP;
                
            END IF;
        END IF;
        
        PKERRORS.POP;
        
        RETURN SBPUNCTUAL;
        
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
    END FSBVALBILLPUNCTUALPAY;

    

































    FUNCTION FNUGETTOTLIQBASECONC
    (
        IRCPRODUCT              SERVSUSC%ROWTYPE,
        IRCCURRENTBILLPERIOD    PERIFACT%ROWTYPE,
        INUCONCEPT              CONCEPTO.CONCCODI%TYPE,
        INUCONSPERIOD           PERICOSE.PECSCONS%TYPE
    )
    RETURN VARCHAR
    IS

        
        NUCHARGEVALUE       CARGOS.CARGVALO%TYPE;

        
        NUTOTALVALUE        CARGOS.CARGVALO%TYPE;
        
        
        TBCONCEPTS          PKBCCONCBALI.TYTBCONCBALI;
        
        
        NUIDX               BINARY_INTEGER;
        
        
        BOMEMORY            BOOLEAN;

    BEGIN

        PKERRORS.PUSH('FA_BOServiciosLiqPorProducto.fnuGetTotLiqBaseConc');

        
        NUTOTALVALUE := 0;

        
        PKBCCONCBALI.GETRECORDBYCONCLIQU
            (
                INUCONCEPT,
                TBCONCEPTS
            );

        NUIDX := TBCONCEPTS.FIRST ;
        
        LOOP
            EXIT WHEN NUIDX IS NULL;

            PKBORATINGMEMORYMGR.GETCHARGEVALUE(IRCPRODUCT.SESUNUSE          ,
                                               IRCCURRENTBILLPERIOD.PEFACODI,
                                               INUCONSPERIOD                ,
                                               TBCONCEPTS(NUIDX).COBLCOBA   ,
                                               NUCHARGEVALUE
                                               );

            
            NUTOTALVALUE := NUTOTALVALUE + NVL(NUCHARGEVALUE,0);
			ut_trace.trace ('PKBORATINGMEMORYMGR.GETCHARGEVALUE :TBCONCEPTS(NUIDX).COBLCOBA'||TBCONCEPTS(NUIDX).COBLCOBA,3);
			ut_trace.trace ('PKBORATINGMEMORYMGR.GETCHARGEVALUE :NUCHARGEVALUE'||NUCHARGEVALUE,3);
            NUIDX := TBCONCEPTS.NEXT (NUIDX) ;
			

        END LOOP;
		ut_trace.trace ('PKBORATINGMEMORYMGR.GETCHARGEVALUE :NUCHARGEVALUE'||NUTOTALVALUE,3);
        PKERRORS.POP;
        
        
        RETURN NUTOTALVALUE;
        
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
    END FNUGETTOTLIQBASECONC;
    
    





















    FUNCTION FSBVALBALANCEOUTOFDATE
    (
        INUPRODUCT  SERVSUSC.SESUNUSE%TYPE
    )
    RETURN VARCHAR
    IS
        
        TBACCOUNTS      PKBCCUENCOBR.TYTBACCOUNTS;
        
        
        SBBALOUTOFDATE  VARCHAR2(1);
    BEGIN

        PKERRORS.PUSH ('FA_BOServiciosLiqPorProducto.fsbValBalanceOutOfDate');
        
        
        SBBALOUTOFDATE := PKCONSTANTE.NO;
        
        
        PKBCCUENCOBR.GETACCWITHBALOUTOFDATE(INUPRODUCT, TBACCOUNTS);
        
        
        IF (TBACCOUNTS.COUNT > 0) THEN
            SBBALOUTOFDATE := PKCONSTANTE.SI;
        END IF;
        
        PKERRORS.POP;
        
        RETURN SBBALOUTOFDATE;

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

    END FSBVALBALANCEOUTOFDATE;
    
    
    
    
    































    FUNCTION FNUEVALPROTYPSUBSCBER
    (
        INUTIPOPRODUCTO IN  SERVSUSC.SESUSERV%TYPE,
        INUCLIENTE      IN  SUSCRIPC.SUSCCLIE%TYPE,
        IDTFECHFINPECO  IN  PERICOSE.PECSFEAF%TYPE
    )
        RETURN NUMBER
    IS

        
        
        

        
        TBSESUNUSE      PKTBLSERVSUSC.TYSESUNUSE;
        
        TBSESUFERE      PKTBLSERVSUSC.TYSESUFERE;
        
        TBSESUCICO      PKTBLSERVSUSC.TYSESUCICO;

        
        
        

        
        RCPERICOSE      PERICOSE%ROWTYPE;

        
        
        

        
        NUNUMPERIODOS   NUMBER;
        
        DTFECHAMAX      DATE := TO_DATE( '01/01/1900 00:00:00','DD/MM/YYYY hh24:MI:SS' );
        
        NUSESUCICO      SERVSUSC.SESUCICO%TYPE;

    BEGIN

        PKERRORS.PUSH
        (
            'FA_BOServiciosLiqPorProducto.fnuEvalProTypSubscber'
        );

        
        PKBCSERVNUMBER.OBTPRODPORTIPRYCLIE
        (
            INUCLIENTE     ,
            INUTIPOPRODUCTO,
            TBSESUNUSE     ,
            TBSESUFERE     ,
            TBSESUCICO
        );

        
        IF( TBSESUNUSE.FIRST IS NULL ) THEN

            PKERRORS.POP;

            
            RETURN PKCONSTANTE.NULLNUM;

        END IF;

        
        FOR NUIND IN TBSESUNUSE.FIRST .. TBSESUNUSE.LAST LOOP

            
            IF( TBSESUFERE( NUIND ) > PKGENERALSERVICES.FDTGETSYSTEMDATE ) THEN

                PKERRORS.POP;

                
                RETURN PKBILLCONST.CERO;

            END IF;

            
            IF( TBSESUFERE( NUIND ) > DTFECHAMAX ) THEN

                
                DTFECHAMAX := TBSESUFERE( NUIND );

                
                NUSESUCICO := TBSESUCICO( NUIND );

            END IF;

        END LOOP;

        
        RCPERICOSE.PECSFEAF := IDTFECHFINPECO;

        
        NUNUMPERIODOS :=    PKBCPERICOSE.FNUOBTPERIODOSFECHAINS
                            (
                                RCPERICOSE          ,
                                DTFECHAMAX          ,
                                NUSESUCICO          ,
                                PKCONSTANTE.CSBABONO
                            );

        PKERRORS.POP;

        
        RETURN NUNUMPERIODOS;

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
                PKERRORS.FSBLASTOBJECT               ,
                SQLERRM                              ,
                FA_BOSERVICIOSLIQPORPRODUCTO.SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2           ,
                FA_BOSERVICIOSLIQPORPRODUCTO.SBERRMSG
            );
    END FNUEVALPROTYPSUBSCBER;

    
































    FUNCTION FNUEVALPROTYPSUBSCTION
    (
        INUTIPOPRODUCTO IN  SERVSUSC.SESUSERV%TYPE,
        INUSUSCRIPCION  IN  SUSCRIPC.SUSCCODI%TYPE,
        IDTFECHFINPECO  IN  PERICOSE.PECSFEAF%TYPE
    )
        RETURN NUMBER
    IS

        
        
        

        
        TBSESUNUSE      PKTBLSERVSUSC.TYSESUNUSE;
        
        TBSESUFERE      PKTBLSERVSUSC.TYSESUFERE;
        
        TBSESUCICO      PKTBLSERVSUSC.TYSESUCICO;

        
        
        

        
        RCPERICOSE      PERICOSE%ROWTYPE;

        
        
        

        
        NUNUMPERIODOS   NUMBER;
        
        DTFECHAMAX      DATE := TO_DATE( '01/01/1900 00:00:00','DD/MM/YYYY hh24:MI:SS' );
        
        NUSESUCICO      SERVSUSC.SESUCICO%TYPE;

    BEGIN

        PKERRORS.PUSH
        (
            'FA_BOServiciosLiqPorProducto.fnuEvalProTypSubsction'
        );

        
        PKBCSERVSUSC.OBTPRODPORTIPRYSUSC
        (
            INUSUSCRIPCION ,
            INUTIPOPRODUCTO,
            TBSESUNUSE     ,
            TBSESUFERE     ,
            TBSESUCICO
        );

        
        IF( TBSESUNUSE.FIRST IS NULL ) THEN

            PKERRORS.POP;

            
            RETURN PKCONSTANTE.NULLNUM;

        END IF;

        
        FOR NUIND IN TBSESUNUSE.FIRST .. TBSESUNUSE.LAST LOOP

            
            IF( TBSESUFERE( NUIND ) > PKGENERALSERVICES.FDTGETSYSTEMDATE ) THEN

                PKERRORS.POP;

                
                RETURN PKBILLCONST.CERO;

            END IF;

            
            IF( TBSESUFERE( NUIND ) > DTFECHAMAX ) THEN

                
                DTFECHAMAX := TBSESUFERE( NUIND );

                
                NUSESUCICO := TBSESUCICO( NUIND );

            END IF;

        END LOOP;

        
        RCPERICOSE.PECSFEAF := IDTFECHFINPECO;

        
        NUNUMPERIODOS :=    PKBCPERICOSE.FNUOBTPERIODOSFECHAINS
                            (
                                RCPERICOSE          ,
                                DTFECHAMAX          ,
                                NUSESUCICO          ,
                                PKCONSTANTE.CSBABONO
                            );

        PKERRORS.POP;

        
        RETURN NUNUMPERIODOS;

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
                PKERRORS.FSBLASTOBJECT               ,
                SQLERRM                              ,
                FA_BOSERVICIOSLIQPORPRODUCTO.SBERRMSG
            );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2           ,
                FA_BOSERVICIOSLIQPORPRODUCTO.SBERRMSG
            );
    END FNUEVALPROTYPSUBSCTION;
END FA_BOSERVICIOSLIQPORPRODUCTO;