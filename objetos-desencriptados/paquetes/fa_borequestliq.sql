PACKAGE BODY FA_BORequestLiq AS

    

























    
    GSBERRMSG           GE_ERROR_LOG.DESCRIPTION%TYPE;
    
    
    
    
    CSBVERSION          CONSTANT VARCHAR2(10) := 'SAO197843';
    
    
    CSBREQCONTTABLE     CONSTANT VARCHAR2(20) := 'CONCSOPL';
    CSBPROMOTIONTABLE   CONSTANT VARCHAR2(20) := 'CONCPROM';

    
    GTBFUNCTIONS         PKBORULESMGR.TYTBRULES;

    
    CNUERR_RULE_EXCEP   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE:= 901960;

    
    CURSOR CUREQUESTCONCEPTS
    (
        INUPLAN       IN CONCPLSU.COPSPLSU%TYPE,
        INUSERVICE    IN SERVSUSC.SESUSERV%TYPE,
        ISBTAGNAME    IN MO_PACKAGES.TAG_NAME%TYPE,
        INUMOTIVE   IN MO_MOTIVE.MOTIVE_ID%TYPE
    )
    IS
        WITH VWCONCSOL AS(
            SELECT  /*+ index(concsopl PK_CONCSOPL) */
                    '1CONCSOPL' TABLA,
                    COSOCONC    IDCONCEPTO,
                    COSOSERV    IDSERVICIO,
                    COSOORGE    ORDENGEN
            FROM    CONCSOPL
            WHERE   COSOTAGN  = ISBTAGNAME
            AND     (COSOSERV = INUSERVICE OR COSOPLSU = -1)
            AND     (COSOPLSU = INUPLAN OR COSOPLSU = -1)
            AND     COSOACTI  = 'S'

            UNION ALL

            SELECT  /*+ leading(c) use_nl(c b) index(c IDX_MO_MOT_PROMOTION01) index(b IDX_CC_PROM_DETAIL01) */
                    '2CONCPROM'          TABLA,
                    B.CONCEPT_ID         IDCONCEPTO,
                    A.PRODUCT_TYPE_ID    IDSERVICIO,
                    B.GENERATION_ORDER   ORDENGEN
            FROM    MO_MOT_PROMOTION C, CC_PROM_DETAIL B, CC_PROMOTION A
            WHERE   C.PROMOTION_ID = B.PROMOTION_ID
            AND     C.PROMOTION_ID = A.PROMOTION_ID
            AND     C.MOTIVE_ID    = INUMOTIVE
            AND     A.PRODUCT_TYPE_ID = INUSERVICE
            AND     B.APPLY_LEVEL  = CC_BOUIPROMOTION.CNUCODIAPPLYLEVELSOL
            )
        SELECT  IDSERVICIO SERVICIOVW,
                IDCONCEPTO CONCEPTOVW,
                SUBSTR (MAX(TABLA || TO_CHAR(IDCONCEPTO, '0000')), 11) CONCDUMMY,
                NVL (SUBSTR (MAX (TABLA || TO_CHAR(ORDENGEN, '0000') ), 11), '-1' ) SECUENCIA,
                SUBSTR (MAX(TABLA) , 2) TABLAVW
        FROM VWCONCSOL
        /*+ FA_BORequestLiq.cuRequestConcepts */
        GROUP BY IDSERVICIO, IDCONCEPTO
        ORDER BY SECUENCIA;


    
















    FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN

        RETURN (CSBVERSION);

    END FSBVERSION;
    
    
    















    PROCEDURE CLEARDATAPROCESS
    IS
    BEGIN
        PKERRORS.PUSH('FA_BORequestLiq.ClearDataProcess');
        UT_TRACE.TRACE('Inicia FA_BORequestLiq.ClearDataProcess', 5);

        
        PKBORATINGMEMORYMGR.CLEARINSTANCEDATACNC ;

        
        PKBORATINGMEMORYMGR.CLEARCONCEPTCACHE ;

        
        PKBORULESMGR.CLOSEDYNCURSORS (GTBFUNCTIONS);

        
        GTBFUNCTIONS.DELETE;

        
        FA_BCCHARGESGERATION.SETDAOUSECACHE(FALSE);

        UT_TRACE.TRACE('Finaliza FA_BORequestLiq.ClearDataProcess', 5);
        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE;
        WHEN EX.CONTROLLED_ERROR THEN
            PKERRORS.POP;
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, GSBERRMSG);
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, GSBERRMSG);
     END CLEARDATAPROCESS;
    




















    PROCEDURE EXECUTERULE
    (
    	ISBRULE 	 IN CONCPLSU.COPSFUFA%TYPE
    )
    IS
        
        NUCHARGEVALUE    CARGOS.CARGVALO%TYPE;

        
        SBERRORADDINFO  GE_ERROR_LOG.DESCRIPTION%TYPE;
        
        
        NUCONCEPT       CONCEPTO.CONCCODI%TYPE;
        
        
        NUPRODTYPE      SERVICIO.SERVCODI%TYPE;

    BEGIN

        PKERRORS.PUSH ('FA_BORequestLiq.ExecuteRule');
        UT_TRACE.TRACE('Inicio FA_BORequestLiq.ExecuteRule',5);
        UT_TRACE.TRACE('Ejecuntado regla: ' || ISBRULE, 6);

        
        IF (ISBRULE IS NOT NULL) THEN

            BEGIN
                
                PKBORULESMGR.EXECUTEFUNCTION
        	    (
            		ISBRULE,
            		GTBFUNCTIONS ,
                    NUCHARGEVALUE
        	    );

            EXCEPTION
        	    
            	WHEN OTHERS THEN
                    PKINSTANCEDATAMGR.GETCG_CONCEPT(NUCONCEPT);
                    PKINSTANCEDATAMGR.GETCG_SERVICE(NUPRODTYPE);

                    
                    SBERRORADDINFO := NUCONCEPT||'|'||NUPRODTYPE||'|'||ISBRULE
                                ||'|'||SUBSTR(PKERRORS.FSBGETERRORMESSAGE,0,1800);
                    
                    
                    ERRORS.SETERROR(CNUERR_RULE_EXCEP, SBERRORADDINFO);

                    UT_TRACE.TRACE('Error en regla: ' || PKERRORS.FSBGETERRORMESSAGE, 6);

            		
            		RAISE LOGIN_DENIED;
            END;

            
            IF (NUCHARGEVALUE != 0) THEN

            	
            	PKBORATINGMEMORYMGR.ADDINDIVCHARGE (NUCHARGEVALUE) ;

            END IF;
        END IF;

        UT_TRACE.TRACE('Fin FA_BORequestLiq.ExecuteRule [Valor cargo = ' || NUCHARGEVALUE || ']',5);
        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        	PKERRORS.POP;
        	RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR (PKCONSTANTE.NUERROR_LEVEL2, GSBERRMSG);

    END EXECUTERULE;


    






































    PROCEDURE LIQUIDATE
    (
    	INUPRODUCT	    IN	SERVSUSC.SESUNUSE%TYPE,
    	INUPROGRAM	    IN	CARGOS.CARGPROG%TYPE,
    	INUPACKAGE      IN  MO_PACKAGES.PACKAGE_ID%TYPE,
    	INUMOTIVE       IN  MO_MOTIVE.MOTIVE_ID%TYPE,
    	ISBSUPPDOC      IN  CARGOS.CARGDOSO%TYPE,
    	ONUERRORCODE    OUT	NUMBER,
    	OSBERRORMESSAGE OUT	VARCHAR2,
    	ONUERRORLOGID   OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE
    )
    IS
        
        RCPRODUCT       SERVSUSC%ROWTYPE;
        
        
        NUCONCEPT       CONCEPTO.CONCCODI%TYPE;

        
        RCCONCEPT       CONCEPTO%ROWTYPE;
        
        
        RCPERIFACT      PERIFACT%ROWTYPE;
        
        
        SBPAYTYPE       SERVICIO.SERVTICO%TYPE;

        
        SBTABLENAME     VARCHAR2(30);

        
        SBRULE          CONCSOPL.COSOFUFA%TYPE;
        
        
        RCREQCON        CONCSOPL%ROWTYPE;

        
        TBVWSERVICIOTMP	PKTBLSERVICIO.TYSERVCODI ;
        TBVWCONCDUMMTMP	PKTBLCONCEPTO.TYCONCCODI ;
        TBVWCONCEPTOTMP	PKTBLCONCEPTO.TYCONCCODI ;
        TBVWORDLIQTMP	PKTBLCONCEPTO.TYCONCORLI ;
        TBVWNOMTABLATMP	PKTBLCONCEPTO.TYCONCDESC ;

        
        NUIND	        NUMBER;

        
        RCPERICONSUMO   PERICOSE%ROWTYPE;

        
        RCPERIABONO     PERICOSE%ROWTYPE;

        
        RCPERIACTU      PERICOSE%ROWTYPE;

        
        SBLIQWAY        CONCEPTO.CONCTICC%TYPE;

        
        RCMOTIVE        DAMO_MOTIVE.STYMO_MOTIVE;
        
        
        SBTAGNAME       MO_PACKAGES.TAG_NAME%TYPE;

        
        RCPACKAGE       DAMO_PACKAGES.STYMO_PACKAGES;
        
        
        NUBILLINGPLAN   SERVSUSC.SESUPLFA%TYPE;
        
        
        BOISBILLIABLE   BOOLEAN;
        
        



















        PROCEDURE INITIALIZE
        IS
        BEGIN
            PKERRORS.PUSH('FA_BORequestLiq.Liquidate.Initialize');
            UT_TRACE.TRACE('Inicia FA_BORequestLiq.Liquidate.Initialize', 5);

            
           	PKERRORS.SETAPPLICATION(GE_BCPROCESOS.FRCGETPROCESS(INUPROGRAM).PROCCODI);
           	
        	
        	RCPRODUCT     := PKTBLSERVSUSC.FRCGETRECORD(INUPRODUCT);
        	
        	
            SBPAYTYPE := PKBCSERVICIO.FRCGETPRODUCTTYPERECORD(RCPRODUCT.SESUSERV).SERVTICO;

            
            PKERRORS.GETERRORVAR
    	    (
        		ONUERRORCODE,
        		OSBERRORMESSAGE,
        		PKCONSTANTE.INITIALIZE
    	    );

            
            ERRORS.RCGE_ERROR_LOG := NULL;
            
            
            OSBERRORMESSAGE := TO_CHAR(PKCONSTANTE.EXITO);

        	
        	GTBFUNCTIONS.DELETE;

        	
        	PKBILLFUNCPARAMETERS.INITMEMTABLE ;

        	
        	PKGRLPARAMEXTENDEDMGR.SETCACHEON ;

            
            RCPERIFACT := PKBILLINGPERIODMGR.FRCGETCACHEDCURRENTPER
                  	      (
                            RCPRODUCT.SESUCICL
                		  );

            UT_TRACE.TRACE('Periodo de facturacion: ' || RCPERIFACT.PEFACODI, 6);
            UT_TRACE.TRACE('Tipo de producto      : ' || RCPRODUCT.SESUSERV, 6);
            UT_TRACE.TRACE('Plan de facturacion   : ' || RCPRODUCT.SESUPLFA, 6);

            IF (INUPACKAGE IS NOT NULL) THEN
            
                
                RCPACKAGE := DAMO_PACKAGES.FRCGETRECORD(INUPACKAGE);
                PKINSTANCEDATAMGR.SETCG_PACKAGE(INUPACKAGE);
                PKINSTANCEDATAMGR.SETRECORDPACKAGE(RCPACKAGE);
                PKINSTANCEDATAMGR.SETRECORDMOTIVE(NULL);

                
                IF (INUMOTIVE IS NULL) THEN
                
                    
                    SBTAGNAME:= RCPACKAGE.TAG_NAME;
                ELSE
                    
                    RCMOTIVE := DAMO_MOTIVE.FRCGETRECORD(INUMOTIVE);
                    PKINSTANCEDATAMGR.SETRECORDMOTIVE(RCMOTIVE);
                    SBTAGNAME := RCMOTIVE.TAG_NAME;

                    
                    IF (RCMOTIVE.MOTIVE_TYPE_ID = PS_BOMOTIVETYPE.FNUPLANCHANGE_MOTI_TYPE AND
                        RCMOTIVE.COMMERCIAL_PLAN_ID IS NOT NULL) THEN
                        
                        
                        NUBILLINGPLAN := DACC_COMMERCIAL_PLAN.FNUGETBILLING_PLAN(RCMOTIVE.COMMERCIAL_PLAN_ID);

                        
                        PKINSTANCEDATAMGR.SETCG_BILLPLAN(NUBILLINGPLAN);
                    END IF;
                END IF;
            END IF;
            
            UT_TRACE.TRACE('Etiqueta: ' || SBTAGNAME, 6);

        	
        	PKINSTANCEDATAMGR.SETCG_BILLPERIODRECORD (RCPERIFACT) ;

        	
        	PKINSTANCEDATAMGR.SETCG_USER(SA_BOSYSTEM.GETSYSTEMUSERID) ;

        	
        	PKINSTANCEDATAMGR.SETCG_TERMINAL(PKGENERALSERVICES.FSBGETTERMINAL) ;

        	
        	PKINSTANCEDATAMGR.SETCG_PROGRAM(INUPROGRAM) ;

        	
        	PKINSTANCEDATAMGR.SETCG_CURRDATE(PKGENERALSERVICES.FDTGETSYSTEMDATE) ;

            
            FA_BCCHARGESGERATION.SETDAOUSECACHE(TRUE);

            
            PKBORATINGMEMORYMGR.CLEARSYNCRARRAYS ;

        	
        	PKBORATINGMEMORYMGR.CLEARPRODUCTCACHE ;

        	
        	PKBORATINGMEMORYMGR.CLEARINSTANCEDATAPRO ;

        	
        	PKINSTANCEDATAMGR.SETCG_TIPOPROC(NULL);

            UT_TRACE.TRACE('Finaliza FA_BORequestLiq.Liquidate.Initialize', 5);
            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
                PKERRORS.POP;
                RAISE;
            WHEN EX.CONTROLLED_ERROR THEN
                PKERRORS.POP;
                RAISE;
            WHEN OTHERS THEN
                PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, GSBERRMSG);
                PKERRORS.POP;
                RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, GSBERRMSG);
         END INITIALIZE;

    BEGIN

        PKERRORS.PUSH ('FA_BORequestLiq.Liquidate');
        UT_TRACE.TRACE('INICIO FA_BORequestLiq.Liquidate', 4);

        UT_TRACE.TRACE('Producto: ' || INUPRODUCT, 5);
        UT_TRACE.TRACE('Programa: ' || INUPROGRAM, 5);
        UT_TRACE.TRACE('Paquete : ' || INUPACKAGE, 5);
        UT_TRACE.TRACE('Motivo  : ' || INUMOTIVE , 5);
        UT_TRACE.TRACE('Doc. Sop: ' || ISBSUPPDOC, 5);
        
        
        INITIALIZE;
        
        
        PKBOPROCESSSECURITY.VALIDATEPRODUCTSECURITY(INUPRODUCT,
                                                    PKERRORS.FSBGETAPPLICATION);

        
        BOISBILLIABLE := PKSERVNUMBERMGR.FBOISBILLABLE(INUPRODUCT,
                                    		           PKCONSTANTE.CACHE,
                                    		           RCPRODUCT.SESUSERV,
                                                       RCPRODUCT.SESUESCO);

        
        IF (NOT BOISBILLIABLE) THEN
        
            UT_TRACE.TRACE('Producto ' || INUPRODUCT || ' no facturable', 5);
            PKERRORS.POP ;
            RETURN ;
        END IF;
        
        
        FA_BCCHARGESGERATION.SETPRODDATA(RCPRODUCT);
        
        
        IF (CUREQUESTCONCEPTS%ISOPEN) THEN
            CLOSE CUREQUESTCONCEPTS;
        END IF;

    	
    	OPEN CUREQUESTCONCEPTS (RCPRODUCT.SESUPLFA,
                			    RCPRODUCT.SESUSERV,
                                SBTAGNAME,
                                RCMOTIVE.MOTIVE_ID);

    	FETCH CUREQUESTCONCEPTS BULK COLLECT INTO TBVWSERVICIOTMP, TBVWCONCDUMMTMP,
                                                  TBVWCONCEPTOTMP, TBVWORDLIQTMP,
                                                  TBVWNOMTABLATMP;
    	CLOSE CUREQUESTCONCEPTS ;

        
        IF (TBVWCONCEPTOTMP.FIRST IS NULL) THEN
            UT_TRACE.TRACE('No encontro conceptos a liquidar para el producto ' || INUPRODUCT, 5);
            PKERRORS.POP ;
            RETURN ;
        END IF;

        
        PKBCPERICOSE.GETCONSPERBYBILLPER(
                                            RCPRODUCT.SESUCICO,
                                            RCPERIFACT.PEFACODI,
                                            RCPERICONSUMO,
                                            SBPAYTYPE,
                                            PKCONSTANTE.CSBCONSUMO
                                        );

        UT_TRACE.TRACE('Periodo de consumo (consumos): ' || RCPERICONSUMO.PECSCONS, 5);

        
        PKBCPERICOSE.GETCONSPERBYBILLPER(
                                            RCPRODUCT.SESUCICO,
                                            RCPERIFACT.PEFACODI,
                                            RCPERIABONO,
                                            SBPAYTYPE,
                                            PKCONSTANTE.CSBABONO
                                        );
                                        
        UT_TRACE.TRACE('Periodo de consumo (abonos): ' || RCPERIABONO.PECSCONS, 5);
        UT_TRACE.TRACE('Conceptos a procesar: ' || TBVWCONCEPTOTMP.COUNT, 5);
        UT_TRACE.TRACE('Tipo de cobro: ' || SBPAYTYPE, 5);
        
        
        NUIND := TBVWCONCEPTOTMP.FIRST ;

        
        LOOP

            
            EXIT WHEN NUIND IS NULL ;

            UT_TRACE.TRACE('**** Ciclo por conceptos ****', 5);

            
            NUCONCEPT  := TBVWCONCEPTOTMP (NUIND) ;
            SBTABLENAME  := TBVWNOMTABLATMP (NUIND) ;
            
            
            PKCONCEPTMGR.GETRECORD(NUCONCEPT, RCCONCEPT);
            SBLIQWAY := RCCONCEPT.CONCTICC;
            
            
            
            IF ( SBLIQWAY = PKCONSTANTE.CSBCONSUMO ) THEN

                
                RCPERIACTU := RCPERICONSUMO;
            ELSE

                
                RCPERIACTU := RCPERIABONO;
            END IF;
            
            UT_TRACE.TRACE('Concepto       : ' || NUCONCEPT, 5);
            UT_TRACE.TRACE('Tabla          : ' || SBTABLENAME, 5);
            UT_TRACE.TRACE('Forma liquidar : ' || SBLIQWAY, 5);
            UT_TRACE.TRACE('Periodo Consumo: ' || SBLIQWAY, 5);

            
            PKBORATINGMEMORYMGR.CLEARINSTANCEDATACNC;

            
            PKBORATINGMEMORYMGR.CLEARCONCEPTCACHE;

            
            PKINSTANCEDATAMGR.SETCG_CONSUMPERIOD(RCPERIACTU.PECSCONS);

            
            PKINSTANCEDATAMGR.SETCG_CONCEPT( NUCONCEPT );

            
            PKINSTANCEDATAMGR.SETCG_SUPPDOCU(ISBSUPPDOC);
            PKINSTANCEDATAMGR.SETTG_SUPPDOC(ISBSUPPDOC);

            
            IF (SBTABLENAME = CSBREQCONTTABLE) THEN
            
                
                FA_BCCONCSOPL.GETRECORD(NUCONCEPT,
                                        SBTAGNAME,
                                        RCPRODUCT.SESUSERV,
                                        RCPRODUCT.SESUPLFA,
                                        RCREQCON);

                
                SBRULE := RCREQCON.COSOFUFA;

            ELSIF (SBTABLENAME = CSBPROMOTIONTABLE) THEN

                
                FA_BCREQUESTLIQ.GETPROMRULE(NUCONCEPT,
                                            RCMOTIVE.MOTIVE_ID,
                                            SBRULE);

            END IF;

            
            EXECUTERULE(SBRULE);

            
            PKBORATINGMEMORYMGR.COMMITCONCEPT;

        	
            NUIND := TBVWCONCEPTOTMP.NEXT (NUIND) ;

        END LOOP;

        
        PKBOLIQUIDATETAX.LIQTAXVALUETOMEMORY(RCPRODUCT, RCPERIFACT , ISBSUPPDOC);
        
        
        PKBORATINGMEMORYMGR.COMMITPRODUCT;
        
        
        PKBORATINGMEMORYMGR.SYNCHRONIZE ;

        
        CLEARDATAPROCESS;

        UT_TRACE.TRACE('FIN FA_BORequestLiq.Liquidate', 4);

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        	PKERRORS.POP;
            
            CLEARDATAPROCESS;
            ERRORS.SETERROR;
            PKERRORS.GETERRORVAR ( ONUERRORCODE, OSBERRORMESSAGE );
            UT_TRACE.TRACE(ONUERRORCODE||'-'||OSBERRORMESSAGE,5);
            ONUERRORLOGID := ERRORS.RCGE_ERROR_LOG.ERROR_LOG_ID;
        WHEN OTHERS THEN
        	PKERRORS.NOTIFYERROR (PKERRORS.FSBLASTOBJECT, SQLERRM, GSBERRMSG);
        	PKERRORS.POP;
            
            CLEARDATAPROCESS;
            PKERRORS.GETERRORVAR ( ONUERRORCODE, OSBERRORMESSAGE );
            UT_TRACE.TRACE(ONUERRORCODE||'-'||OSBERRORMESSAGE,5);
            ONUERRORLOGID := ERRORS.RCGE_ERROR_LOG.ERROR_LOG_ID;
    END LIQUIDATE;

END FA_BOREQUESTLIQ;