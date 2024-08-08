PACKAGE BODY GC_BODebtNegotiation IS

    






































































































































































































































































    
    
    
    CSBVERSION                  CONSTANT    VARCHAR2(15) := 'SAO496789';

    
    
    
    
    CSBRESTRICTION              CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 1898;
    
    CSBEXISTSCHARGES            CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901226;
    
    CSBEXISTSDEBTNEGOREQ        CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901433;
    
    CNUNULL_ATTRIBUTE           CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 119562;
    
    CNUNOT_NEGOT_SIGN           CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901426;
    
    CNUNOT_USER_SIGN            CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901432;
    
    CNURECORD_NOT_EXIST         CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 1;
    
    CNUSUSP_STAT_ERROR_COD      CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 10063;
    
    CNUPROD_NO_DEBT             CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901499;
    
    CNUVAL_MIN_TO_PAY           CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901616;
    
    
    CSBDEBTNEGOTIATION          CONSTANT VARCHAR2(100) := 'P_SOLICITUD_DE_NEGOCIACION_DE_DEUDA_328';
     
    CNUDEBT_NEGOT_MOTY_TYPE     CONSTANT PS_MOTIVE_TYPE.MOTIVE_TYPE_ID%TYPE := PS_BOMOTIVETYPE.FNUMOTITYPEBYTAG(PS_BOMOTIVETYPE.CSBTAG_M_DEBT_NEGOTIATION);
    
    CNUWAIT_SIGN                CONSTANT GE_ACTION_MODULE.ACTION_ID%TYPE := 301;
    
    CNUACTION_AMOUNT_ID         CONSTANT GE_FINANCIAL_PROFILE.ACTION_AMOUNT_ID%TYPE := 6;
    
    
    CNUSELECT_PROD_EVENT   CONSTANT CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE  := 141;
    
    

    CSBTOKEN_OBSE_NOTE          CONSTANT    VARCHAR2(3) := 'NG-';
    
    
    CNUORDER_CONEXION           CONSTANT SERVSUSC.SESUESCO%TYPE:= PKGENERALPARAMETERSMGR.FNUGETNUMBERVALUE('CON_ORDEN_DE_CONEXION');
    
    
    CNUTRACE_LEVEL              CONSTANT NUMBER := 6;

    
    
    
    
    
    
    GNUDEBTNEGOTREQUESTID       GC_DEBT_NEGOTIATION.PACKAGE_ID%TYPE;
    GTBPRODUCTS                 CC_TYTBPRODUCT;
    GNUINDXPRODUCTS             NUMBER;
    GTBARREARS                  CC_TYTBARREAR;
    GNUINDXARREARS              NUMBER;
    GNUPRODUCTID                SERVSUSC.SESUNUSE%TYPE;
    
    
    
    
    FUNCTION GETBASEVALUE
    (
        RCCHARGE     IN    PKBCCHARGES.TYRCNOTECHARGE,
        RCSERVSUSC   IN    SERVSUSC%ROWTYPE
    )
    RETURN NUMBER;

    














    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;
    
    
















    PROCEDURE ADDARREARDATA
    (
        NUPRODUCTID         IN  PR_PRODUCT.PRODUCT_ID%TYPE,
        RCARREARDATA        IN  FA_BOLIQLATECONCEPTS.TYRCLATEDATA
    )
    IS
        RCOBARREAR      CC_TYOBARREAR;
    BEGIN
    
        UT_TRACE.TRACE('Inicio [GC_BODebtNegotiation.AddArrearData]', 2);

        GTBARREARS.EXTEND;
        GNUINDXARREARS := GTBARREARS.COUNT;

        
        RCOBARREAR :=   CC_TYOBARREAR
                        (
                            NUPRODUCTID,                    
                            RCARREARDATA.NUCONCEPT,         
                            RCARREARDATA.DTFECHAULTLIQ,     
                            RCARREARDATA.NULATEDAYS,        
                            RCARREARDATA.NUTAXPERC,         
                            RCARREARDATA.NUBASEVALUE,       
                            RCARREARDATA.NUGENLATEVALUE,    
                            RCARREARDATA.NUNOTGENLATEVALUE, 
                            RCARREARDATA.NUDEUDATOTAL       
                        );
                            
        
        GTBARREARS(GNUINDXARREARS) := RCOBARREAR;

        UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.AddArrearData]', 2);
    
    EXCEPTION
    
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.AddArrearData]', 2);
    	    RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.AddArrearData]', 2);
            RAISE EX.CONTROLLED_ERROR;
    
    END ADDARREARDATA;
    
    











































































































    PROCEDURE PROCESSDEBTNEGOTIATION
    (
        INUPACKAGE_ID   IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        ONUATTENDREQ    OUT NUMBER
    )
    IS
        
        
        
        NUACCOUNTID     CUENCOBR.CUCOCODI%TYPE;
        
        
        RCMOTIVE                                DAMO_MOTIVE.STYMO_MOTIVE;
        
        
        RCGC_DEBT_NEGOTIATION                   GC_DEBT_NEGOTIATION%ROWTYPE;
        
        
        TBDEBNEGOPRODUCTS                       GC_BCDEBTNEGOPRODUCT.TYTBDEBTNEGOPRODUCTS;
        
        
        NUIDXPRODS                              BINARY_INTEGER;
        
        
        RCSUBSCRIPTION                          SUSCRIPC%ROWTYPE;
        
        
        NUBILLNUMBER                            FACTURA.FACTCODI%TYPE;
        
        
        NUBILLVALUE                             CUENCOBR.CUCOVAFA%TYPE;
        
        
        TBDEFERREDCHARGES                       GC_BCDEBTNEGOCHARGE.TYTBDEBTNEGOCHARGES;
        
        
        TBDISCOUNTCHARGES                       GC_BCDEBTNEGOCHARGE.TYTBDEBTNEGOCHARGES;
        
        
        BOWAYPAYISFINANCING                     BOOLEAN := FALSE;

        
        NUSUSCRIPC            SUSCRIPC.SUSCCODI%TYPE;
        
        
        NUSUSCRIPCTYPE        GE_SUBSCRIPTION_TYPE.SUBSCRIPTION_TYPE%TYPE;
        
        
        RCSERVSUSC            SERVSUSC%ROWTYPE;
        
        
        CNUEST_FACT_CONVENIO  CONSTANT  PARAMETR.PAMECODI%TYPE := PKGENERALPARAMETERSMGR.FNUGETNUMBERVALUE('EST_FACT_CONVENIO');
        
        
        CSBNEGO_FLAG_AJUSTE  CONSTANT GE_PARAMETER.PARAMETER_ID%TYPE := 'NEGO_FLAG_AJUSTE';

        
        SBNEGO_FLAG_AJUSTE  GE_PARAMETER.VALUE%TYPE;
        
        
        CSBNEGO_CONC_AJUSTE  CONSTANT GE_PARAMETER.PARAMETER_ID%TYPE := 'NEGO_CONC_AJUSTE';

        
        NUNEGO_CONC_AJUSTE   CONCEPTO.CONCCODI%TYPE;

        
        
        

        
        



















        PROCEDURE UPDLASTBILLDATEBYCONC
        (
            RCCONCEPT   IN  CONCEPTO%ROWTYPE,
            INUPRODUCT  IN  SERVSUSC.SESUNUSE%TYPE,
            IDTNEGDATE  IN  DATE
        )
        IS
            
            RCFEULLICO      FEULLICO%ROWTYPE;
        BEGIN
            PKERRORS.PUSH('GC_BODebtNegotiation.ProcessDebtNegotiation.UpdLastBillDateByConc');

            UT_TRACE.TRACE('Inicia [GC_BODebtNegotiation.ProcessDebtNegotiation.UpdLastBillDateByConc]',2);

            
            IF (RCCONCEPT.CONCTICL = PKBILLCONST.FNUOBTTIPORECAMORA) THEN

                
                RCFEULLICO.FELISESU := INUPRODUCT;
                RCFEULLICO.FELICONC := RCCONCEPT.CONCCODI;
                RCFEULLICO.FELIFEUL := IDTNEGDATE;

                
                IF (PKTBLFEULLICO.FBLEXIST(INUPRODUCT,RCCONCEPT.CONCCODI)) THEN
                    
                    PKTBLFEULLICO.UPRECORD(RCFEULLICO);
                ELSE
                    
                    PKTBLFEULLICO.INSRECORD(RCFEULLICO);
                END IF;

            END IF;

            UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.ProcessDebtNegotiation.UpdLastBillDateByConc]',5);

            PKERRORS.POP;

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.ProcessDebtNegotiation.UpdLastBillDateByConc]', 2);
        	    RAISE EX.CONTROLLED_ERROR;

            WHEN OTHERS THEN
                ERRORS.SETERROR;
                UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.ProcessDebtNegotiation.UpdLastBillDateByConc]', 2);
                RAISE EX.CONTROLLED_ERROR;
        END UPDLASTBILLDATEBYCONC;

        














        PROCEDURE GETPROCESSDATA
        IS
        BEGIN
        
            UT_TRACE.TRACE('Inicio [GC_BODebtNegotiation.ProcessDebtNegotiation.GetProcessData]', 2);
            
            
            IF( RCGC_DEBT_NEGOTIATION.PAYMENT_METHOD = CSBFINANCING ) THEN
            
                BOWAYPAYISFINANCING := TRUE;
            
            END IF;
            
            
            GC_BCDEBTNEGOPRODUCT.GETDEBTNEGOPRODUCTS
            (
                RCGC_DEBT_NEGOTIATION.DEBT_NEGOTIATION_ID,
                TBDEBNEGOPRODUCTS
            );
            
            
            OPEN MO_BCMOTIVE.CUMOTIVESBYPACKAGE( INUPACKAGE_ID );
            FETCH MO_BCMOTIVE.CUMOTIVESBYPACKAGE INTO RCMOTIVE;
            CLOSE MO_BCMOTIVE.CUMOTIVESBYPACKAGE;
            
            
            RCSUBSCRIPTION := PKTBLSUSCRIPC.FRCGETRECORD( RCMOTIVE.SUBSCRIPTION_ID );
            
            UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.ProcessDebtNegotiation.GetProcessData]', 2);
        
        EXCEPTION
        
            WHEN EX.CONTROLLED_ERROR THEN
                UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.ProcessDebtNegotiation.GetProcessData]', 2);
        	    RAISE EX.CONTROLLED_ERROR;

            WHEN OTHERS THEN
                ERRORS.SETERROR;
                UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.ProcessDebtNegotiation.GetProcessData]', 2);
                RAISE EX.CONTROLLED_ERROR;
        
        END GETPROCESSDATA;


        



















        PROCEDURE DISTRIBPAYINTOCHARG
        (
            IRCTBCHARGES       IN PKTBLCARGOS.TYTBCARGOS,
            INUPRODUCTID       IN CARGOS.CARGNUSE%TYPE,
            OTBCHARGESTODISTR OUT MO_TYTBCHARGES
        )
        IS
            NUCHARGEIDX       BINARY_INTEGER;
            NUINDEX           BINARY_INTEGER;
            NUSIGN            NUMBER := PKBILLCONST.CNUSUMA_CARGO;
            NUPRODUCTTYPEID   PR_PRODUCT.PRODUCT_TYPE_ID%TYPE;

            
            RCCHARGETODISTR   MO_TYOBCHARGES;

        BEGIN
            UT_TRACE.TRACE('INICIO: GC_BODebtNegotiation.ProcessDebtNegotiation.DistribPayIntoCharg', 5);

            
            OTBCHARGESTODISTR := MO_TYTBCHARGES();

            NUPRODUCTTYPEID := CC_BCFINANCING.FNUPRODUCTTYPE( INUPRODUCTID );

            NUCHARGEIDX := IRCTBCHARGES.CARGCUCO.FIRST;
            LOOP
                EXIT WHEN NUCHARGEIDX IS NULL;

                
                IF ( IRCTBCHARGES.CARGSIGN(NUCHARGEIDX) = PKBILLCONST.CREDITO ) THEN
                    
                    NUSIGN := PKBILLCONST.CNURESTA_CARGO;
                ELSE
                    
                    NUSIGN := PKBILLCONST.CNUSUMA_CARGO;
                END IF;

                RCCHARGETODISTR := MO_TYOBCHARGES
                                   (
                                      IRCTBCHARGES.CARGCUCO(NUCHARGEIDX),
                                      INUPRODUCTID,
                                      NUPRODUCTTYPEID,
                                      IRCTBCHARGES.CARGCONC(NUCHARGEIDX),
                                      IRCTBCHARGES.CARGCACA(NUCHARGEIDX),
                                      IRCTBCHARGES.CARGSIGN(NUCHARGEIDX),
                                      IRCTBCHARGES.CARGPEFA(NUCHARGEIDX),
                                      IRCTBCHARGES.CARGVALO(NUCHARGEIDX),
                                      IRCTBCHARGES.CARGDOSO(NUCHARGEIDX),
                                      IRCTBCHARGES.CARGCODO(NUCHARGEIDX),
                                      IRCTBCHARGES.CARGTIPR(NUCHARGEIDX),
                                      IRCTBCHARGES.CARGUNID(NUCHARGEIDX),
                                      IRCTBCHARGES.CARGFECR(NUCHARGEIDX),
                                      IRCTBCHARGES.CARGPROG(NUCHARGEIDX),
                                      IRCTBCHARGES.CARGCOLL(NUCHARGEIDX),
                                      IRCTBCHARGES.CARGVABL(NUCHARGEIDX),
                                      IRCTBCHARGES.CARGVALO(NUCHARGEIDX) * NUSIGN,
                                      IRCTBCHARGES.CARGVALO(NUCHARGEIDX) * NUSIGN,
                                      NULL,
                                      NUCHARGEIDX,
                                      GE_BOCONSTANTS.CSBNO,
                                      PKBILLCONST.CERO,
                                      IRCTBCHARGES.CARGUSUA(NUCHARGEIDX)
                                   );

                OTBCHARGESTODISTR.EXTEND;
                OTBCHARGESTODISTR(OTBCHARGESTODISTR.LAST) := RCCHARGETODISTR;

                NUCHARGEIDX := IRCTBCHARGES.CARGCUCO.NEXT( NUCHARGEIDX );

            END LOOP;

            
            CC_BOFINANCING.DISTRIBPAYINTOCHARGES( OTBCHARGESTODISTR );

            UT_TRACE.TRACE('FIN: GC_BODebtNegotiation.ProcessDebtNegotiation.DistribPayIntoCharg', 5);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
                UT_TRACE.TRACE('CONTROLLED_ERROR: GC_BODebtNegotiation.ProcessDebtNegotiation.DistribPayIntoCharg', 5);
                RAISE;
            WHEN OTHERS THEN
                UT_TRACE.TRACE('ERROR: GC_BODebtNegotiation.ProcessDebtNegotiation.DistribPayIntoCharg', 5);
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END DISTRIBPAYINTOCHARG;
        
        













        PROCEDURE GENERATEBILL
        IS
        BEGIN
        
            UT_TRACE.TRACE('Inicio [GC_BODebtNegotiation.ProcessDebtNegotiation.GenerateBill]', 2);

            
            PKACCOUNTSTATUSMGR.GETNEWACCOSTATUSNUM( NUBILLNUMBER );
            
            
            PKACCOUNTSTATUSMGR.ADDNEWRECORD
            (
                INUESTADOCTA    =>  NUBILLNUMBER,
                INUAPPLICATION  =>  PKGENERALSERVICES.FNUIDPROCESO,
                IRCSUSCRIPC     =>  RCSUBSCRIPTION,
                INUTIPODOC      =>  GE_BOCONSTANTS.FNUGETDOCTYPECONS
            );
            
            UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.ProcessDebtNegotiation.GenerateBill]', 2);
        
        EXCEPTION
        
            WHEN EX.CONTROLLED_ERROR THEN
                UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.ProcessDebtNegotiation.GenerateBill]', 2);
        	    RAISE EX.CONTROLLED_ERROR;

            WHEN OTHERS THEN
                ERRORS.SETERROR;
                UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.ProcessDebtNegotiation.GenerateBill]', 2);
                RAISE EX.CONTROLLED_ERROR;
        
        END GENERATEBILL;
        
        















        PROCEDURE GENERATEACCOUNT
        (
            IRCPRODUCT              IN          SERVSUSC%ROWTYPE,
            ONUACCOUNT              OUT         CUENCOBR.CUCOCODI%TYPE
        )
        IS
        BEGIN
        
            UT_TRACE.TRACE('Inicio [GC_BODebtNegotiation.ProcessDebtNegotiation.GenerateAccount]', 2);

            
            PKACCOUNTMGR.GETNEWACCOUNTNUM( ONUACCOUNT );

            
            PKACCOUNTMGR.ADDNEWRECORD
            (
                NUBILLNUMBER,
                ONUACCOUNT,
                IRCPRODUCT
            );

            UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.ProcessDebtNegotiation.GenerateAccount]', 2);
        
        EXCEPTION
        
            WHEN EX.CONTROLLED_ERROR THEN
                UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.ProcessDebtNegotiation.GenerateAccount]', 2);
        	    RAISE EX.CONTROLLED_ERROR;

            WHEN OTHERS THEN
                ERRORS.SETERROR;
                UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.ProcessDebtNegotiation.GenerateAccount]', 2);
                RAISE EX.CONTROLLED_ERROR;
        
        END GENERATEACCOUNT;

        






















        PROCEDURE PROCESSACCOUNT
        (
            INUACCOUNT                  IN          CUENCOBR.CUCOCODI%TYPE,
            INUPRODUCT                  IN          SERVSUSC.SESUNUSE%TYPE,
            INUBILLVALUE                IN          CUENCOBR.CUCOVAFA%TYPE,
            INUTAXVALUE                 IN          CUENCOBR.CUCOIMFA%TYPE
        )
        IS
            
            SBADJUSTSIGN                            CARGOS.CARGSIGN%TYPE;

            
            NUADJUSTVALUE                           CARGOS.CARGVALO%TYPE;

            
            NUBILLVALUE                             CUENCOBR.CUCOVAFA%TYPE;
        BEGIN
        
            UT_TRACE.TRACE('Inicio [GC_BODebtNegotiation.ProcessDebtNegotiation.ProcessAccount]', 2);

            
            PKACCOUNTMGR.ADJUSTACCOUNT
        	(
                INUCUENTA       =>  INUACCOUNT,
                INUNUMSERV      =>  INUPRODUCT,
                INUCAUSACARG    =>  PKCONSTANTE.NULLNUM,
                INUFLAGBD       =>  PKBILLCONST.CNUUPDATE_DB,
                OSBSIGNO        =>  SBADJUSTSIGN,
                ONUVLRAJUSTE    =>  NUADJUSTVALUE
            );

            
            NUBILLVALUE :=  INUBILLVALUE;

            
            IF( SBADJUSTSIGN = PKBILLCONST.DEBITO ) THEN
            
                NUBILLVALUE := NUBILLVALUE + NUADJUSTVALUE;
            
            ELSE
            
                NUBILLVALUE := NUBILLVALUE - NUADJUSTVALUE;
            
            END IF;
            

        	
        	PKTBLCUENCOBR.UPBILLEDVALUES
        	(
                INUCUENTA       =>  INUACCOUNT,
                INUVALOR        =>  NUBILLVALUE,
                INUVALORIVA     =>  INUTAXVALUE
            );

            UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.ProcessDebtNegotiation.ProcessAccount]', 2);
        
        EXCEPTION
        
            WHEN EX.CONTROLLED_ERROR THEN
                UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.ProcessDebtNegotiation.ProcessAccount]', 2);
        	    RAISE EX.CONTROLLED_ERROR;

            WHEN OTHERS THEN
                ERRORS.SETERROR;
                UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.ProcessDebtNegotiation.ProcessAccount]', 2);
                RAISE EX.CONTROLLED_ERROR;
        
        END PROCESSACCOUNT;

        

































        PROCEDURE CREATECHARGE
        (
            INUPRODUCT              IN          SERVSUSC.SESUNUSE%TYPE,
            INUACCOUNT              IN          CUENCOBR.CUCOCODI%TYPE,
            INUCONCEPT              IN          CONCEPTO.CONCCODI%TYPE,
            INUCHARGECAUSE          IN          CARGOS.CARGCACA%TYPE,
            IONUCHARGEVALUE         IN OUT      CARGOS.CARGVALO%TYPE,
            ISBSIGN                 IN          CARGOS.CARGSIGN%TYPE,
            ISBSUPPDOC              IN          CARGOS.CARGDOSO%TYPE,
            INUCONSSUPPDOC          IN          CARGOS.CARGCODO%TYPE,
            INUUNITS                IN          CARGOS.CARGUNID%TYPE,
            INUEVENTCONS            IN          CARGOS.CARGCOLL%TYPE,
            ONUBILLVALUE            OUT         CUENCOBR.CUCOVAFA%TYPE,
            ONUTAXVALUE             OUT         CUENCOBR.CUCOIMFA%TYPE,
            INUBASEVALUE            IN          CARGOS.CARGVABL%TYPE
        )
        IS
            RCSERVSUSC  SERVSUSC%ROWTYPE;
            RCPERIFACT  PERIFACT%ROWTYPE;
            NUBASE      NUMBER;
        BEGIN
        
            UT_TRACE.TRACE('Inicio [GC_BODebtNegotiation.ProcessDebtNegotiation.CreateCharge]', 2);
            
            
            ONUBILLVALUE := 0;
            ONUTAXVALUE := 0;
            
            
            RCSERVSUSC := PKTBLSERVSUSC.FRCGETRECORD(INUPRODUCT);
            
        	
    	    PKSUBSCRIBERMGR.ACCCURRENTPERIOD
    	    (
        		RCSERVSUSC.SESUSUSC,
        		RCPERIFACT
    	    );
            
            IF (INUBASEVALUE IS NULL) THEN
                
                PKBOLIQUIDATETAX.GETTAXBASEVALUE
                (
                    RCSERVSUSC,
                    RCPERIFACT.PEFACODI,
                    INUCONCEPT,
                    IONUCHARGEVALUE,
                    NUBASE
                );
                
            ELSE
                NUBASE := INUBASEVALUE;

            END IF;

            UT_TRACE.TRACE('Base: '|| NUBASE, 10);

            
            PKCHARGEMGR.SETBASEVALUE(NUBASE);

            
            PKCHARGEMGR.GENERATECHARGE
            (
                INUNUMESERV     =>  INUPRODUCT,
                INUCUCOCODI     =>  INUACCOUNT,
                INUCONCCODI     =>  INUCONCEPT,
                INUCAUSCARG     =>  INUCHARGECAUSE,
                IONUCARGVALO    =>  IONUCHARGEVALUE,
                ISBCARGSIGN     =>  ISBSIGN,
                ISBCARGDOSO     =>  ISBSUPPDOC,
                ISBCARGTIPR     =>  PKBILLCONST.AUTOMATICO,
                INUCARGCODO     =>  INUCONSSUPPDOC,
                INUCARGUNID     =>  INUUNITS,
                INUCARGCOLL     =>  INUEVENTCONS,
                INUSESUCARG     =>  INUPRODUCT,
            	IBOKEEPTIPR     =>  NULL
            );
            
            PKCHARGEMGR.CLEARVALUES;

            
            PKUPDACCORECEIV.UPDACCOREC
            (
                INUOPERACION    =>  PKBILLCONST.CNUSUMA_CARGO,
                INUCTA          =>  INUACCOUNT,
                INUSUSC         =>  RCSUBSCRIPTION.SUSCCODI,
                INUSESU         =>  INUPRODUCT,
                INUCONCEPTO     =>  INUCONCEPT,
                ISBSIGNO        =>  ISBSIGN,
                INUVLRCARGO     =>  IONUCHARGEVALUE,
                INUFLAGBD       =>  PKBILLCONST.CNUUPDATE_DB
            );
            
            
            IF( ISBSIGN = PKBILLCONST.DEBITO ) THEN
            
                ONUBILLVALUE := ONUBILLVALUE + IONUCHARGEVALUE;

                
                IF( PKGENERATEINDBILL.FBLESIMPUESTO( INUCONCEPT ) ) THEN
                
                     ONUTAXVALUE := ONUTAXVALUE + IONUCHARGEVALUE;
                
                END IF;
            
            ELSE
            
                ONUBILLVALUE := ONUBILLVALUE - IONUCHARGEVALUE;

                
                IF( PKGENERATEINDBILL.FBLESIMPUESTO( INUCONCEPT ) ) THEN
                
                     ONUTAXVALUE := ONUTAXVALUE - IONUCHARGEVALUE;
                
                END IF;
            
            END IF;

            UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.ProcessDebtNegotiation.CreateCharge]', 2);
        
        EXCEPTION
        
            WHEN EX.CONTROLLED_ERROR THEN
                UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.ProcessDebtNegotiation.CreateCharge]', 2);
        	    RAISE EX.CONTROLLED_ERROR;

            WHEN OTHERS THEN
                ERRORS.SETERROR;
                UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.ProcessDebtNegotiation.CreateCharge]', 2);
                RAISE EX.CONTROLLED_ERROR;
        
        END CREATECHARGE;

        
















        PROCEDURE UPDATECONSUMPTION
        (
            INUPRODUCT              IN          CONSSESU.COSSSESU%TYPE,
            ISBSUPPDOC              IN          CARGOS.CARGDOSO%TYPE,
            INUCONSSUPPDOC          IN          CARGOS.CARGCODO%TYPE
        )
        IS
            
            NUCONSUMPTIONTYPE                   TIPOCONS.TCONCODI%TYPE;
            
            
            NUBILLCYCLE                         CICLO.CICLCODI%TYPE;
            
            
            NUCONSUMPTIONCYCLE                  CICLCONS.CICOCODI%TYPE;
            
            
            NUCONSUMPTIONPERIOD                 PERICOSE.PECSCONS%TYPE;
            
            
            NUCONSPERIYEAR                      NUMBER;
            
            
            NUCONSPERIMONTH                     NUMBER;
            
            
            SBTMPSUPPDOC                        VARCHAR2(30);
            
            
            DTCONSUMPTIONDATE                   DATE;
            
            
            RCBILLPERIOD                        PERIFACT%ROWTYPE;
        
        BEGIN
        
            UT_TRACE.TRACE('Inicio [GC_BODebtNegotiation.ProcessDebtNegotiation.UpdateConsumption]', 2);
            
            
            NUCONSUMPTIONTYPE   :=  TO_NUMBER
                                    (
                                        SUBSTR
                                        (
                                            ISBSUPPDOC,
                                            INSTR(ISBSUPPDOC,PKBILLCONST.CSBTOKEN_TIPO_CONSUMO)+
                                            LENGTH(PKBILLCONST.CSBTOKEN_TIPO_CONSUMO),
                                            LENGTH(ISBSUPPDOC)
                                        )
                                    );
            
            
            NUBILLCYCLE := PKTBLSERVSUSC.FNUGETBILLINGCYCLE(INUPRODUCT);
            
            
            NUCONSUMPTIONCYCLE := PKTBLSERVSUSC.FNUGETCYCLE(INUPRODUCT);
            
            
            SBTMPSUPPDOC := SUBSTR(ISBSUPPDOC,1,LENGTH(ISBSUPPDOC)-8);

            
            NUCONSPERIYEAR := SUBSTR(SBTMPSUPPDOC,LENGTH(SBTMPSUPPDOC)-5,4);
            
            
            NUCONSPERIMONTH :=  SUBSTR(SBTMPSUPPDOC,LENGTH(SBTMPSUPPDOC)-1);
            
            
            DTCONSUMPTIONDATE := TO_DATE('15-'||NUCONSPERIMONTH||'-'||NUCONSPERIYEAR,'DD-MM-YYYY');
            
            

            PKBCPERIFACT.GETPERIODBYDATE
            (
                NUBILLCYCLE,
                NUCONSPERIYEAR,
                NUCONSPERIMONTH,
                RCBILLPERIOD
            );

            
            PKBCPERICOSE.GETCONSPERBYBILLPER
            (
                NUCONSUMPTIONCYCLE,
                RCBILLPERIOD.PEFACODI,
                NUCONSUMPTIONPERIOD
            );

            
            PKBCCONSSESU.UPDCONSUMPTOLIQUIDATED
            (
                INUPRODUCT,
                NUCONSUMPTIONTYPE,
                NUCONSUMPTIONPERIOD,
                RCMOTIVE.MOTIV_RECORDING_DATE,
                INUCONSSUPPDOC
            );
            
            UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.ProcessDebtNegotiation.UpdateConsumption]', 2);
        
        EXCEPTION
        
            WHEN EX.CONTROLLED_ERROR THEN
                UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.ProcessDebtNegotiation.UpdateConsumption]', 2);
        	    RAISE EX.CONTROLLED_ERROR;

            WHEN OTHERS THEN
                ERRORS.SETERROR;
                UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.ProcessDebtNegotiation.UpdateConsumption]', 2);
                RAISE EX.CONTROLLED_ERROR;
        
        END UPDATECONSUMPTION;

        

























































        PROCEDURE PROCPRODDEBTNEGOCHARGS
        (
            INUDEBTNEGOPRODID       IN          GC_DEBT_NEGOT_PROD.DEBT_NEGOT_PROD_ID%TYPE,
            INUPRODUCT              IN          GC_DEBT_NEGOT_PROD.SESUNUSE%TYPE
        )
        IS
            
            TBDEBNEGOCHARGES                    GC_BCDEBTNEGOCHARGE.TYTBDEBTNEGOCHARGES;
            
            
            NUIDX                               BINARY_INTEGER;
            
            
            RCPRODUCT                           SERVSUSC%ROWTYPE;
            
            
            NUACCOUNT                           CUENCOBR.CUCOCODI%TYPE;
            
            
            NUTMPACCBILLVALUE                   CUENCOBR.CUCOVAFA%TYPE;
            
            
            NUTMPACCTAXVALUE                    CUENCOBR.CUCOIMFA%TYPE;
            
            
            NUSUMACCBILLVALUE                   CUENCOBR.CUCOVAFA%TYPE;

            
            NUSUMACCTAXVALUE                    CUENCOBR.CUCOIMFA%TYPE;
            
            
            NUBILLEDCHARGESCOUNTER              NUMBER;
            
            
            RCCONCEPT                           CONCEPTO%ROWTYPE;
            
            
            DTNEGOREGISTERDATE                  MO_PACKAGES.REQUEST_DATE%TYPE;
            
        BEGIN
        
            UT_TRACE.TRACE('Inicio [GC_BODebtNegotiation.ProcessDebtNegotiation.ProcProdDebtNegoChargs]', 2);
            
            UT_TRACE.TRACE('Procesando producto: '||INUPRODUCT, 3);
            
            NUTMPACCBILLVALUE := 0;
            NUTMPACCTAXVALUE := 0;
            NUSUMACCBILLVALUE := 0;
            NUSUMACCTAXVALUE := 0;
            NUACCOUNT := NULL;
            NUBILLEDCHARGESCOUNTER := 0;
            
            
            DTNEGOREGISTERDATE := DAMO_PACKAGES.FDTGETREQUEST_DATE( RCGC_DEBT_NEGOTIATION.PACKAGE_ID );

            
            GC_BCDEBTNEGOCHARGE.GETDEBTNEGOCHARGES
            (
                INUDEBTNEGOPRODID,
                TBDEBNEGOCHARGES
            );
            
            
            GC_BOCASTIGOCARTERA.REACTNEGOCIATEDDEBT
            (
                TBDEBNEGOCHARGES,
                INUPRODUCT
            );

            
            NUIDX := TBDEBNEGOCHARGES.FIRST;

            LOOP
            
                EXIT WHEN NUIDX IS NULL;
                
                
                IF ( TBDEBNEGOCHARGES(NUIDX).CUCOCODI = PKCONSTANTE.NULLNUM
                AND TBDEBNEGOCHARGES(NUIDX).IS_DISCOUNT = GE_BOCONSTANTS.CSBNO
                AND NOT (SUBSTR(TBDEBNEGOCHARGES(NUIDX).SUPPORT_DOCUMENT, 1, 3) = PKBILLCONST.CSBTOKEN_DIFERIDO)) THEN
                
                    

                    IF( NUBILLNUMBER IS NULL ) THEN
                    
                        
                        GENERATEBILL;
                        UT_TRACE.TRACE('Factura generada: '||NUBILLNUMBER, 3);
                    
                    END IF;
                    
                    


                    IF( NUACCOUNT IS NULL ) THEN
                    
                        
                        RCPRODUCT := PKTBLSERVSUSC.FRCGETRECORD(TBDEBNEGOPRODUCTS(NUIDXPRODS).SESUNUSE);

                        
                        GENERATEACCOUNT
                        (
                            RCPRODUCT,
                            NUACCOUNT
                        );
                        UT_TRACE.TRACE('Cuenta generada: '||NUACCOUNT, 3);
                    
                    END IF;
                    
                    
                    PKCONCEPTMGR.GETRECORD( TBDEBNEGOCHARGES(NUIDX).CONCCODI, RCCONCEPT );

                    

                    UPDLASTBILLDATEBYCONC
                    (
                        RCCONCEPT,
                        INUPRODUCT,
                        DTNEGOREGISTERDATE
                    );

                    
                    CREATECHARGE
                    (
                        INUPRODUCT,
                        NUACCOUNT,
                        TBDEBNEGOCHARGES(NUIDX).CONCCODI,
                        TBDEBNEGOCHARGES(NUIDX).CACACODI,
                        TBDEBNEGOCHARGES(NUIDX).BILLED_VALUE,
                        TBDEBNEGOCHARGES(NUIDX).SIGNCODI,
                        TBDEBNEGOCHARGES(NUIDX).SUPPORT_DOCUMENT,
                        TBDEBNEGOCHARGES(NUIDX).DOCUMENT_CONSECUTIVE,
                        NULL,
                        TBDEBNEGOCHARGES(NUIDX).CALL_CONSECUTIVE,
                        NUTMPACCBILLVALUE,
                        NUTMPACCTAXVALUE,
                        TBDEBNEGOCHARGES(NUIDX).BILLED_BASE_VALUE
                    );
                    UT_TRACE.TRACE('Cargo de facturacion generado', 3);
                    
                    
                    NUSUMACCBILLVALUE := NUSUMACCBILLVALUE + NUTMPACCBILLVALUE;
                    NUSUMACCTAXVALUE := NUSUMACCTAXVALUE + NUTMPACCTAXVALUE;
                    
                    

                    DAGC_DEBT_NEGOT_CHARGE.UPDCUCOCODI
                    (
                        TBDEBNEGOCHARGES(NUIDX).DEBT_NEGOT_CHARGE_ID,
                        NUACCOUNT
                    );
                    UT_TRACE.TRACE('Cargo en negociacion actualizado: '||TBDEBNEGOCHARGES(NUIDX).DEBT_NEGOT_CHARGE_ID, 3);

                    


                    NUBILLEDCHARGESCOUNTER := NUBILLEDCHARGESCOUNTER + 1;
                    
                    
                    IF( TBDEBNEGOCHARGES(NUIDX).SUPPORT_DOCUMENT LIKE 'CO-%' ) THEN
                    
                        
                        UPDATECONSUMPTION
                        (
                            INUPRODUCT,
                            TBDEBNEGOCHARGES(NUIDX).SUPPORT_DOCUMENT,
                            TBDEBNEGOCHARGES(NUIDX).DOCUMENT_CONSECUTIVE
                        );
                        UT_TRACE.TRACE('El cargo es de consumo. Se han actualizado datos del consumo.', 3);
                    
                    END IF;
                    
                
                END IF;

                
                IF ( SUBSTR(TBDEBNEGOCHARGES(NUIDX).SUPPORT_DOCUMENT, 1, 3) = PKBILLCONST.CSBTOKEN_DIFERIDO
                AND TBDEBNEGOCHARGES(NUIDX).IS_DISCOUNT = GE_BOCONSTANTS.CSBNO ) THEN
                
                    
                    IF TBDEBNEGOCHARGES(NUIDX).CUCOCODI = PKCONSTANTE.NULLNUM THEN
                    
                    
                        

                        IF( NUBILLNUMBER IS NULL ) THEN
                        
                            
                            GENERATEBILL;
                            UT_TRACE.TRACE('Factura generada: '||NUBILLNUMBER, 3);
                        
                        END IF;

                        


                        IF( NUACCOUNT IS NULL ) THEN
                        
                            
                            RCPRODUCT := PKTBLSERVSUSC.FRCGETRECORD(TBDEBNEGOPRODUCTS(NUIDXPRODS).SESUNUSE);

                            
                            GENERATEACCOUNT
                            (
                                RCPRODUCT,
                                NUACCOUNT
                            );
                            UT_TRACE.TRACE('Cuenta generada: '||NUACCOUNT, 3);
                        
                        END IF;
                    
                        UT_TRACE.TRACE('Cargo de traslado, se asigna cuenta: '||NUACCOUNT, 3);

                        TBDEBNEGOCHARGES(NUIDX).CUCOCODI := NUACCOUNT;

                        UT_TRACE.TRACE('Actualiza el cargo de negociaci�n: '||TBDEBNEGOCHARGES(NUIDX).DEBT_NEGOT_CHARGE_ID, 3);

                        

                        DAGC_DEBT_NEGOT_CHARGE.UPDCUCOCODI
                        (
                            TBDEBNEGOCHARGES(NUIDX).DEBT_NEGOT_CHARGE_ID,
                            TBDEBNEGOCHARGES(NUIDX).CUCOCODI
                        );

                        


                        NUBILLEDCHARGESCOUNTER := NUBILLEDCHARGESCOUNTER + 1;
                        
                    
                    END IF;
                    
                    
                    TBDEFERREDCHARGES(TBDEFERREDCHARGES.COUNT + 1) := TBDEBNEGOCHARGES(NUIDX);
                    UT_TRACE.TRACE('Cargo agregado a coleccion de diferidos: '||TBDEBNEGOCHARGES(NUIDX).DEBT_NEGOT_CHARGE_ID, 3);
                
                END IF;

                
                IF ( TBDEBNEGOCHARGES(NUIDX).IS_DISCOUNT = GE_BOCONSTANTS.CSBYES ) THEN

                    
                    TBDISCOUNTCHARGES((TBDISCOUNTCHARGES.COUNT + 1)) := TBDEBNEGOCHARGES(NUIDX);
                    UT_TRACE.TRACE('>> Cargo agregado a coleccion de descuentos: '||TBDEBNEGOCHARGES(NUIDX).DEBT_NEGOT_CHARGE_ID, 3);
                    UT_TRACE.TRACE('>> Cuenta de cobro: '||TBDEBNEGOCHARGES(NUIDX).CUCOCODI||' - Concepto: '||TBDEBNEGOCHARGES(NUIDX).CONCCODI ,3);
                    
                END IF;
                
                NUIDX := TBDEBNEGOCHARGES.NEXT( NUIDX );
                
            
            END LOOP;
            
            UT_TRACE.TRACE('Se agregaron '||TBDISCOUNTCHARGES.COUNT||' cargos en la coleccion de descuentos.',3);
            
            
            IF( NUACCOUNT IS NOT NULL ) THEN
            
                
                PROCESSACCOUNT
                (
                    NUACCOUNT,
                    TBDEBNEGOPRODUCTS(NUIDXPRODS).SESUNUSE,
                    NUSUMACCBILLVALUE,
                    NUSUMACCTAXVALUE
                );
                UT_TRACE.TRACE('Cuenta de cobro '||NUACCOUNT||' procesada', 3);
            
            END IF;
            
            
            IF( BOWAYPAYISFINANCING ) THEN
            
                UT_TRACE.TRACE('Forma de pago es financiacion', 3);
                
                IF( NUBILLEDCHARGESCOUNTER > 0 ) THEN
                
                    
                    CC_BCFIN_REQ_CONCEPT.UPDFINANACCOUNTS
                    (
                        RCGC_DEBT_NEGOTIATION.PACKAGE_ID,
                        INUPRODUCT,
                        NUACCOUNT
                    );
                    UT_TRACE.TRACE('Se ha actualizado la cuenta de cobro en los detalles de la financiacion.', 3);
                
                END IF;
            
            END IF;

            UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.ProcessDebtNegotiation.ProcProdDebtNegoChargs]', 2);
        
        EXCEPTION
        
            WHEN EX.CONTROLLED_ERROR THEN
                UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.ProcessDebtNegotiation.ProcProdDebtNegoChargs]', 2);
        	    RAISE EX.CONTROLLED_ERROR;

            WHEN OTHERS THEN
                ERRORS.SETERROR;
                UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.ProcessDebtNegotiation.ProcProdDebtNegoChargs]', 2);
                RAISE EX.CONTROLLED_ERROR;
        
        END PROCPRODDEBTNEGOCHARGS;
        
        


















































        PROCEDURE PROCESSDEFERRED
        IS
        
            
            NUIDX                               BINARY_INTEGER;
            
            
            RCCHARGE                            PKBCCHARGES.TYRCNOTECHARGE;
            
            
            TBCHARGES                           PKBCCHARGES.TYTBNOTECHARGES;
            
            
            TBGENERATEDNOTES                    PKBILLINGNOTEMGR.TYTBNOTAMEM;
            
            
            RCPRODUCT                           SERVSUSC%ROWTYPE;

            
            NUDEFERREDID                        DIFERIDO.DIFECODI%TYPE;
            
            
            RCDEFERRED                          DIFERIDO%ROWTYPE;
            
            
            NUDEFERREDINTEREST                  CARGOS.CARGVALO%TYPE;
            
            
            SBDEFSUPPDOC                        CARGOS.CARGDOSO%TYPE;
            
        BEGIN
        
            UT_TRACE.TRACE('Inicio [GC_BODebtNegotiation.ProcessDebtNegotiation.ProcessDeferred]', 2);
            
            
            IF( TBDEFERREDCHARGES.COUNT = 0 ) THEN
            
                UT_TRACE.TRACE('No hay diferidos para procesar.', 2);
                UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.ProcessDebtNegotiation.ProcessDeferred]', 2);
                RETURN;
            
            END IF;
            
            

            NUIDX := TBDEFERREDCHARGES.FIRST;

            LOOP
            
                EXIT WHEN NUIDX IS NULL;
                
                
                RCPRODUCT := PKTBLSERVSUSC.FRCGETRECORD
                (
                    DAGC_DEBT_NEGOT_PROD.FNUGETSESUNUSE(TBDEFERREDCHARGES(NUIDX).DEBT_NEGOT_PROD_ID)
                );

                
                RCCHARGE.CARGIDEN := TBDEFERREDCHARGES(NUIDX).DEBT_NEGOT_CHARGE_ID;
                RCCHARGE.CARGCUCO := TBDEFERREDCHARGES(NUIDX).CUCOCODI;
                RCCHARGE.CARGNUSE := RCPRODUCT.SESUNUSE;
                RCCHARGE.CARGCONC := TBDEFERREDCHARGES(NUIDX).CONCCODI;
                RCCHARGE.CARGCACA := FA_BOCHARGECAUSES.FNUDEBTNEGOCHARGECAUSE(RCPRODUCT.SESUSERV);
                RCCHARGE.CARGSIGN := TBDEFERREDCHARGES(NUIDX).SIGNCODI;
                RCCHARGE.CARGDOSO := TBDEFERREDCHARGES(NUIDX).SUPPORT_DOCUMENT;
                RCCHARGE.CARGVACO := TBDEFERREDCHARGES(NUIDX).BILLED_VALUE;
                
                RCCHARGE.CARGVBLC := GETBASEVALUE(RCCHARGE, RCPRODUCT);

                
                TBCHARGES(RCCHARGE.CARGIDEN) := RCCHARGE;

                
                NUDEFERREDID := TO_NUMBER(SUBSTR(TBDEFERREDCHARGES(NUIDX).SUPPORT_DOCUMENT,4,30));
                
                
                RCDEFERRED := PKTBLDIFERIDO.FRCGETRECORD(NUDEFERREDID);

                
                PKTBLDIFERIDO.UPDDIFESAPE(NUDEFERREDID, 0);
                
                
                NUDEFERREDINTEREST  :=  PKDEFERREDMGR.FNUDEFERREDINTEREST
                                        (
                                            IRCDIFERIDO     =>  RCDEFERRED,
                                            IDTENDMOVPER    =>  SYSDATE,
                                            IBOUSURY        =>  TRUE,
                                            IBOVALGRACEPER  =>  FALSE,
                                            OSBSUPPORTDOCUM =>  SBDEFSUPPDOC
                                        );
                                        
                
                PKTRANSDEFTOCURRDEBTMGR.TRANSFERDEFERRED
                (
                    NUDEFERREDID,
                    CSBGCNED,
                    SYSDATE, 
                    SYSDATE, 
                    TBDEFERREDCHARGES( NUIDX ).BILLED_VALUE,
                    NUDEFERREDINTEREST
                );

                
                NUIDX := TBDEFERREDCHARGES.NEXT( NUIDX );
            
            END LOOP;

            
            FA_BOBILLINGNOTES.SETUPDATEDATABASEFLAG(TRUE);

            
            FA_BOBILLINGNOTES.CREATENOTESFROMMEMORY
            (
                INUSUSCCODI         =>  RCSUBSCRIPTION.SUSCCODI,
                ISBNOTAOBSE         =>  CSBTOKEN_OBSE_NOTE || INUPACKAGE_ID,
                IOTBCHARGES         =>  TBCHARGES,
                ISBNOTATINO         =>  FA_BOBILLINGNOTES.CSBRECLASIF_NOTE_TYPE,
                OTBGENERATEDNOTES   =>  TBGENERATEDNOTES,
                IBOKEEPDOSO         =>  TRUE
            );
            
            
            NUIDX := TBCHARGES.FIRST;

            LOOP
            
                EXIT WHEN NUIDX IS NULL;

                

                DAGC_DEBT_NEGOT_CHARGE.UPDSUPPORT_DOCUMENT
                (
                    TBCHARGES(NUIDX).CARGIDEN,
                    TBCHARGES(NUIDX).CARGDOSO
                );
                
                DAGC_DEBT_NEGOT_CHARGE.UPDCACACODI
                (
                    TBCHARGES(NUIDX).CARGIDEN,
                    TBCHARGES(NUIDX).CARGCACA
                );

                NUIDX := TBCHARGES.NEXT( NUIDX );
            
            END LOOP;

            UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.ProcessDebtNegotiation.ProcessDeferred]', 2);
        
        EXCEPTION
        
            WHEN EX.CONTROLLED_ERROR THEN
                UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.ProcessDebtNegotiation.ProcessDeferred]', 2);
        	    RAISE EX.CONTROLLED_ERROR;

            WHEN OTHERS THEN
                ERRORS.SETERROR;
                UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.ProcessDebtNegotiation.ProcessDeferred]', 2);
                RAISE EX.CONTROLLED_ERROR;
        
        END PROCESSDEFERRED;
        
        

        




















































        PROCEDURE PROCESSDISCOUNT
        IS
        
            
            NUIDX                  BINARY_INTEGER;
            NUIDXCHG               BINARY_INTEGER;

            
            RCCHARGE               PKBCCHARGES.TYRCNOTECHARGE;
            NUIDXNOTECHG           NUMBER := 0;

            
            TBCHARGES              PKBCCHARGES.TYTBNOTECHARGES;

            
            TBGENERATEDNOTES       PKBILLINGNOTEMGR.TYTBNOTAMEM;

            
            RCPRODUCT              SERVSUSC%ROWTYPE;

            NUDISCOUNTBAL          NUMBER;
            
            
            NUCARGCACA             CARGOS.CARGCACA%TYPE;

        BEGIN
            UT_TRACE.TRACE('INICIO: GC_BODebtNegotiation.ProcessDebtNegotiation.ProcessDiscount', 2);

            
            IF( TBDISCOUNTCHARGES.COUNT = 0 ) THEN
                UT_TRACE.TRACE('No hay descuentos para procesar.', 2);
                UT_TRACE.TRACE('FIN: GC_BODebtNegotiation.ProcessDebtNegotiation.ProcessDiscount', 2);
                RETURN;
            END IF;

            

            NUIDX := TBDISCOUNTCHARGES.FIRST;

            LOOP
                EXIT WHEN NUIDX IS NULL;

                UT_TRACE.TRACE('C�digo del cargo por negociaci�n de deuda: '||TBDISCOUNTCHARGES(NUIDX).DEBT_NEGOT_CHARGE_ID,3);

                
                RCPRODUCT := PKTBLSERVSUSC.FRCGETRECORD
                             (DAGC_DEBT_NEGOT_PROD.FNUGETSESUNUSE(TBDISCOUNTCHARGES(NUIDX).DEBT_NEGOT_PROD_ID));

                
                NUDISCOUNTBAL := TBDISCOUNTCHARGES(NUIDX).BILLED_VALUE;
                UT_TRACE.TRACE('Valor de descuento a aplicar para el concepto '||TBDISCOUNTCHARGES(NUIDX).CONCCODI ||': '||NUDISCOUNTBAL,3);

                
                NUCARGCACA :=  FA_BOCHARGECAUSES.FNUSPECIALFINCHCAUSE(RCPRODUCT.SESUSERV);

                
                RCCHARGE.CARGIDEN := NUIDXNOTECHG;
                RCCHARGE.CARGNUSE := RCPRODUCT.SESUNUSE;
                RCCHARGE.CARGCONC := TBDISCOUNTCHARGES(NUIDX).CONCCODI;
                RCCHARGE.CARGCACA := NUCARGCACA;
                RCCHARGE.CARGSIGN := TBDISCOUNTCHARGES(NUIDX).SIGNCODI;
                RCCHARGE.CARGDOSO := TBDISCOUNTCHARGES(NUIDX).SUPPORT_DOCUMENT;
                RCCHARGE.CARGNEGO := TBDISCOUNTCHARGES(NUIDX).DEBT_NEGOT_CHARGE_ID;
                RCCHARGE.CARGVACO := NUDISCOUNTBAL;
                    
                IF ( TBDISCOUNTCHARGES(NUIDX).CUCOCODI != PKCONSTANTE.NULLNUM) THEN
                    UT_TRACE.TRACE('Cargo de descuento (conc: '|| TBDISCOUNTCHARGES(NUIDX).CONCCODI ||' - desc: '|| NUDISCOUNTBAL ||') sobre cuenta de cobro ('|| TBDISCOUNTCHARGES(NUIDX).CUCOCODI ||').' ,10);
                    
                    RCCHARGE.CARGCUCO := TBDISCOUNTCHARGES(NUIDX).CUCOCODI;
                ELSE
                    

                    NUACCOUNTID := PKACCOUNTMGR.FNUGETLASTACCOUNTSERV(RCPRODUCT.SESUNUSE);
                    UT_TRACE.TRACE('Cargo de descuento (conc: '|| TBDISCOUNTCHARGES(NUIDX).CONCCODI ||' - desc: '|| NUDISCOUNTBAL ||') sobre cuenta de cobro ('|| NUACCOUNTID ||').' ,10);
                    RCCHARGE.CARGCUCO := NUACCOUNTID;
                END IF;
                
                
                RCCHARGE.CARGVBLC := GETBASEVALUE(RCCHARGE, RCPRODUCT);
                
                TBCHARGES(RCCHARGE.CARGIDEN) := RCCHARGE;
                
                NUIDXNOTECHG := NUIDXNOTECHG + 1;
                
                NUDISCOUNTBAL := 0;

                
                NUIDX := TBDISCOUNTCHARGES.NEXT( NUIDX );

            END LOOP;
            
            UT_TRACE.TRACE('Se crear�n '||TBCHARGES.COUNT||' notas de descuento',2);
            
            
            FA_BOBILLINGNOTES.SETUPDATEDATABASEFLAG(TRUE);

            
            FA_BOBILLINGNOTES.CREATENOTESFROMMEMORY
            (
                INUSUSCCODI         =>  RCSUBSCRIPTION.SUSCCODI,
                ISBNOTAOBSE         =>  CSBTOKEN_OBSE_NOTE || INUPACKAGE_ID,
                IOTBCHARGES         =>  TBCHARGES,
                ISBNOTATINO         =>  FA_BOBILLINGNOTES.CSBCREDIT_NOTE_TYPE,  
                OTBGENERATEDNOTES   =>  TBGENERATEDNOTES
            );

            
            IF ( TBGENERATEDNOTES.COUNT > 0 ) THEN
                
                FOR NUIND IN TBGENERATEDNOTES.FIRST .. TBGENERATEDNOTES.LAST LOOP
                    
                    PKBILLINGNOTEMGR.PROCESONUMERACIONFISCAL( TBGENERATEDNOTES( NUIND ).NOTANUME );
                END LOOP;
            END IF;
            
            
            NUIDXCHG := TBCHARGES.FIRST;

            LOOP
                EXIT WHEN NUIDXCHG IS NULL;

                

                DAGC_DEBT_NEGOT_CHARGE.UPDSUPPORT_DOCUMENT
                (
                    TBCHARGES(NUIDXCHG).CARGNEGO,
                    TBCHARGES(NUIDXCHG).CARGDOSO
                );

                DAGC_DEBT_NEGOT_CHARGE.UPDCACACODI
                (
                    TBCHARGES(NUIDXCHG).CARGNEGO,
                    TBCHARGES(NUIDXCHG).CARGCACA
                );

                NUIDXCHG := TBCHARGES.NEXT( NUIDXCHG );
            END LOOP;

            UT_TRACE.TRACE('FIN: GC_BODebtNegotiation.ProcessDebtNegotiation.ProcessDiscount', 2);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.ProcessDebtNegotiation.ProcessDiscount]', 2);
        	    RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.ProcessDebtNegotiation.ProcessDiscount]', 2);
                RAISE EX.CONTROLLED_ERROR;
        END PROCESSDISCOUNT;
        
        







        PROCEDURE ADJUSTACCOUNTS
        IS
            NUVALUE NUMBER;
            SBSIGNO VARCHAR2(20);
            SBCREDITNOTETYPE    NUMBER;
            SBTOKENNOTE     VARCHAR(5);
            NUNOTE          NOTAS.NOTANUME%TYPE;
            
            CNUCREDIT_NOTE_DOC_TYP  CONSTANT    NUMBER          :=  GE_BOCONSTANTS.FNUGETDOCTYPECRENOTE;
            
            CNUDEBIT_NOTE_DOC_TYPE  CONSTANT    NUMBER          :=  GE_BOCONSTANTS.FNUGETDOCTYPEDEBNOTE;
            

        
            CURSOR CUACCOUNTS( INUPROD CUENCOBR.CUCONUSE%TYPE )
            IS  SELECT  *
                FROM    CUENCOBR
                WHERE   CUCONUSE = INUPROD
                AND     CUCOSACU <> 0;
        BEGIN
        
            
            NUIDXPRODS := TBDEBNEGOPRODUCTS.FIRST;

            WHILE ( NUIDXPRODS IS NOT NULL ) LOOP

                
                FOR RCACCOUNT IN CUACCOUNTS( TBDEBNEGOPRODUCTS(NUIDXPRODS).SESUNUSE )
                LOOP
                    
                    IF ( ABS(RCACCOUNT.CUCOSACU) < 100 ) THEN
                    
                        
                        IF RCACCOUNT.CUCOSACU < 0 THEN
                           SBSIGNO := PKBILLCONST.DEBITO;
                           SBCREDITNOTETYPE := CNUDEBIT_NOTE_DOC_TYPE;
                           SBTOKENNOTE := PKBILLCONST.CSBTOKEN_NOTA_DEBITO;
                        ELSE
                           SBSIGNO := PKBILLCONST.CREDITO;
                           SBCREDITNOTETYPE := CNUCREDIT_NOTE_DOC_TYP;
                           SBTOKENNOTE := PKBILLCONST.CSBTOKEN_NOTA_CREDITO;
                        END IF;

                        
                        NUVALUE := ABS(RCACCOUNT.CUCOSACU);

                        
                        
                        
                        FA_BOBILLINGNOTES.SETUPDATEDATABASEFLAG(TRUE);

                        
                        PKBILLINGNOTEMGR.CREATEBILLINGNOTE
                        (
                            RCACCOUNT.CUCONUSE,
                            RCACCOUNT.CUCOCODI,
                            SBCREDITNOTETYPE,
                            SYSDATE,
                            CSBTOKEN_OBSE_NOTE || INUPACKAGE_ID,
                            SBTOKENNOTE,
                            NUNOTE
                        );

                        
                        FA_BOBILLINGNOTES.DETAILREGISTER
                        (
                            NUNOTE,
                            RCACCOUNT.CUCONUSE,
                            PKTBLSERVSUSC.FNUGETSESUSUSC( RCACCOUNT.CUCONUSE ),
                            RCACCOUNT.CUCOCODI,
                            2,
                            -1,
                            NUVALUE,
                            NULL,
                            SBTOKENNOTE || NUNOTE,
                            SBSIGNO,
                            PKCONSTANTE.NO,
                            NULL,
                            PKCONSTANTE.NO  
                        );

                    END IF;
                    
                END LOOP;

                NUIDXPRODS := TBDEBNEGOPRODUCTS.NEXT( NUIDXPRODS );

            END LOOP;

        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END ADJUSTACCOUNTS;
        
        
















        PROCEDURE ADJUSTACCOUNTSWITHBAL
        IS
        
            NUVALUE          NUMBER;
            NUNOTE           NOTAS.NOTANUME%TYPE;

            
            CNUCREDIT_NOTE_DOC_TYP  CONSTANT    NUMBER    :=  GE_BOCONSTANTS.FNUGETDOCTYPECRENOTE;

            
            
            CURSOR CUACCOUNTSWITHBAL (INUPROD CUENCOBR.CUCONUSE%TYPE)
            IS
                SELECT  *
                FROM    CUENCOBR
                WHERE   CUCONUSE = INUPROD
                AND     CUCOSACU > 0;
                
        BEGIN

            UT_TRACE.TRACE('INICIO: GC_BODebtNegotiation.ProcessDebtNegotiation.AdjustAccountsWithBal', 2);
            
            
            SBNEGO_FLAG_AJUSTE := GE_BOPARAMETER.FSBGET(CSBNEGO_FLAG_AJUSTE);
            UT_TRACE.TRACE('P�rametro <NEGO_FLAG_AJUSTE> ['||SBNEGO_FLAG_AJUSTE||']', 2 );
            
            
            NUNEGO_CONC_AJUSTE := GE_BOPARAMETER.FNUGET(CSBNEGO_CONC_AJUSTE);
            UT_TRACE.TRACE('P�rametro <NEGO_CONC_AJUSTE> ['||NUNEGO_CONC_AJUSTE||']', 2 );
            
            
            IF (SBNEGO_FLAG_AJUSTE IS NOT NULL AND NUNEGO_CONC_AJUSTE IS NOT NULL) THEN
        
                
                IF (SBNEGO_FLAG_AJUSTE = 'S') THEN
                
                    
                    NUIDXPRODS := TBDEBNEGOPRODUCTS.FIRST;

                    WHILE ( NUIDXPRODS IS NOT NULL ) LOOP

                        
                        FOR RCACCOUNT IN CUACCOUNTSWITHBAL( TBDEBNEGOPRODUCTS(NUIDXPRODS).SESUNUSE )
                        LOOP

                            
                            NUVALUE := RCACCOUNT.CUCOSACU;

                            UT_TRACE.TRACE('Producto ['||TBDEBNEGOPRODUCTS(NUIDXPRODS).SESUNUSE||
                                           '] Cuenta de cobro ['||RCACCOUNT.CUCOCODI||'] Valor ajuste ['||NUVALUE||']', 2 );

                            
                            FA_BOBILLINGNOTES.SETUPDATEDATABASEFLAG(TRUE);

                            
                            PKBILLINGNOTEMGR.CREATEBILLINGNOTE
                            (
                                RCACCOUNT.CUCONUSE,
                                RCACCOUNT.CUCOCODI,
                                CNUCREDIT_NOTE_DOC_TYP,
                                SYSDATE,
                                CSBTOKEN_OBSE_NOTE || INUPACKAGE_ID,
                                PKBILLCONST.CSBTOKEN_NOTA_CREDITO,
                                NUNOTE
                            );

                            
                            FA_BOBILLINGNOTES.DETAILREGISTER
                            (
                                NUNOTE,
                                RCACCOUNT.CUCONUSE,
                                PKTBLSERVSUSC.FNUGETSESUSUSC( RCACCOUNT.CUCONUSE ),
                                RCACCOUNT.CUCOCODI,
                                NUNEGO_CONC_AJUSTE,
                                -1,
                                NUVALUE,
                                NULL,
                                PKBILLCONST.CSBTOKEN_NOTA_CREDITO || NUNOTE,
                                PKBILLCONST.CREDITO,
                                PKCONSTANTE.NO,
                                NULL,
                                PKCONSTANTE.NO
                            );

                        END LOOP;

                        NUIDXPRODS := TBDEBNEGOPRODUCTS.NEXT( NUIDXPRODS );

                    END LOOP;
                
                END IF;
                
            END IF;
            
            UT_TRACE.TRACE('FIN: GC_BODebtNegotiation.ProcessDebtNegotiation.AdjustAccountsWithBal', 2);

        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END ADJUSTACCOUNTSWITHBAL;

        


        
    BEGIN
    
        UT_TRACE.TRACE('Inicio [GC_BODebtNegotiation.ProcessDebtNegotiation]', 1);
        
        
        GC_BCDEBTNEGOTIATION.GETDEBTNEGOTIATIONDATA( INUPACKAGE_ID,
                                                     RCGC_DEBT_NEGOTIATION );
                                                     
        
        VALFGCAISINEXECUTION(INUPACKAGE_ID);

        
        IF ( FBODEBTHASCHANGED(INUPACKAGE_ID) ) THEN

            UT_TRACE.TRACE('Se modific� la cartera de los productos negociados', 2);
            
            IF( RCGC_DEBT_NEGOTIATION.REQUIRE_PAYMENT = GE_BOCONSTANTS.CSBYES )THEN
                UT_TRACE.TRACE('Se requiere pago', 3);
                
                RC_BOAPPLYPENDPAYMENT.PAYMENTANNULREQUEST( INUPACKAGE_ID );
            END IF;

            
            ONUATTENDREQ := GE_BOCONSTANTS.NOK;

            UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.ProcessDebtNegotiation]', 1);
            
            RETURN;

        END IF;
        
        
        SETDEBTNEGOTPACKAGE(INUPACKAGE_ID);
        
        
        PKERRORS.SETAPPLICATION(CSBGCNED);
        
        

        GETPROCESSDATA;
        
        
        NUIDXPRODS := TBDEBNEGOPRODUCTS.FIRST;

        WHILE ( NUIDXPRODS IS NOT NULL ) LOOP

            
            PROCPRODDEBTNEGOCHARGS
            (
                TBDEBNEGOPRODUCTS(NUIDXPRODS).DEBT_NEGOT_PROD_ID,
                TBDEBNEGOPRODUCTS(NUIDXPRODS).SESUNUSE
            );

            
            NUSUSCRIPC := PKTBLSERVSUSC.FNUGETSESUSUSC( TBDEBNEGOPRODUCTS(NUIDXPRODS).SESUNUSE );
            
            
            NUSUSCRIPCTYPE := PKTBLSUSCRIPC.FNUGETSUSCTISU( NUSUSCRIPC );
            
            
            RCSERVSUSC := PKTBLSERVSUSC.FRCGETRECORD(TBDEBNEGOPRODUCTS(NUIDXPRODS).SESUNUSE);
            
            
            IF ( NUSUSCRIPCTYPE = GC_BOCONSTANTS.FNUGETSUCRIPTYPEINSOLV ) THEN
                
                PKTBLRECAESCO.ACCKEY(RCSERVSUSC.SESUSERV, CNUEST_FACT_CONVENIO, RCSERVSUSC.SESUESCO );
                
                PKTBLSERVSUSC.UPDSESUESCO(TBDEBNEGOPRODUCTS(NUIDXPRODS).SESUNUSE , CNUEST_FACT_CONVENIO);
            END IF;
            
            NUIDXPRODS := TBDEBNEGOPRODUCTS.NEXT( NUIDXPRODS );

        
        END LOOP;

        
        PROCESSDEFERRED;

        
        PROCESSDISCOUNT;

        
        IF( BOWAYPAYISFINANCING ) THEN
        
            
            CC_BOWAITFORPAYMENT.EXECFINANCING( INUPACKAGE_ID );

            
            CC_BOFINANCING.COMMITFINANC;
        
        END IF;
        
        
        IF ( RCGC_DEBT_NEGOTIATION.REQUIRE_PAYMENT = GE_BOCONSTANTS.CSBYES ) THEN
        
            
            RC_BOAPPLYPENDPAYMENT.PAYMENTPENDREQUEST( INUPACKAGE_ID );

        END IF;
        
        
        ADJUSTACCOUNTS;
        
        
        ADJUSTACCOUNTSWITHBAL;

        
        ONUATTENDREQ := GE_BOCONSTANTS.OK;

        UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.ProcessDebtNegotiation]', 1);
    
    EXCEPTION
    
        WHEN EX.CONTROLLED_ERROR THEN
            GC_BODEBTNEGOTIATION.SETDEBTNEGOTPACKAGE(NULL);
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.ProcessDebtNegotiation]', 1);
    	    RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            GC_BODEBTNEGOTIATION.SETDEBTNEGOTPACKAGE(NULL);
            ERRORS.SETERROR;
            UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.ProcessDebtNegotiation]', 1);
            RAISE EX.CONTROLLED_ERROR;
    
    END PROCESSDEBTNEGOTIATION;

    
















    PROCEDURE GETSUBSCBYDEBTNEGOT
    (
        INUDEBTNEGOTIATIONID  IN GC_DEBT_NEGOTIATION.DEBT_NEGOTIATION_ID%TYPE,
        ONUSUBSCRIPTIONID    OUT MO_MOTIVE.SUBSCRIPTION_ID%TYPE
    )
    IS
        NUDEBTNEGOTPACKAGE  GC_DEBT_NEGOTIATION.PACKAGE_ID%TYPE;
        CUMOTIVE            CONSTANTS.TYREFCURSOR;
        RCMOTIVE            DAMO_MOTIVE.STYMO_MOTIVE;

    BEGIN
        UT_TRACE.TRACE( 'INICIO: GC_BODebtNegotiation.GetSubscByDebtNegot('||INUDEBTNEGOTIATIONID||')', 6 );

        
        NUDEBTNEGOTPACKAGE := DAGC_DEBT_NEGOTIATION.FNUGETPACKAGE_ID(INUDEBTNEGOTIATIONID);
        UT_TRACE.TRACE( 'Solicitud de la negociaci�n de la deuda: '||NUDEBTNEGOTPACKAGE, 7 );

        
        CUMOTIVE := MO_BCMOTIVE.FRFMOTIVESBYPACKAGEID(NUDEBTNEGOTPACKAGE);

        
        FETCH CUMOTIVE INTO RCMOTIVE;
        CLOSE CUMOTIVE;
        UT_TRACE.TRACE( 'Motivo asociado a la solicitud de la negociaci�n: '||RCMOTIVE.MOTIVE_ID, 7 );

        
        ONUSUBSCRIPTIONID := DAMO_MOTIVE.FNUGETSUBSCRIPTION_ID(RCMOTIVE.MOTIVE_ID);

        UT_TRACE.TRACE( 'FIN: GC_BODebtNegotiation.GetSubscByDebtNegot('||
                        INUDEBTNEGOTIATIONID||','||ONUSUBSCRIPTIONID||')', 6 );
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETSUBSCBYDEBTNEGOT;


    













    PROCEDURE SETDEBTNEGOTPACKAGE
    (
         INUDEBTNEGOTREQUESTID GC_DEBT_NEGOTIATION.PACKAGE_ID%TYPE
    )
    IS
    BEGIN
        UT_TRACE.TRACE( 'GC_BODebtNegotiation.SetDebtNegotPackage', 7 );
        GNUDEBTNEGOTREQUESTID := INUDEBTNEGOTREQUESTID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETDEBTNEGOTPACKAGE;
    
    
    













    FUNCTION FNUGETDEBTNEGOTPACKAGE
    RETURN GC_DEBT_NEGOTIATION.PACKAGE_ID%TYPE
    IS
    BEGIN
        UT_TRACE.TRACE( 'GC_BODebtNegotiation.fnuGetDebtNegotPackage', 7 );
        RETURN GC_BODEBTNEGOTIATION.GNUDEBTNEGOTREQUESTID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETDEBTNEGOTPACKAGE;
    


    




















    PROCEDURE VALDEBTNEGOPENDREQUEST
    (
        INUSERVICENUMBER    IN    SERVSUSC.SESUNUSE%TYPE
    )
    IS
        

        BOEXISTSREQUEST    BOOLEAN := FALSE;
        
    BEGIN
    
        UT_TRACE.TRACE('Inicio: GC_BODebtNegotiation.ValDebtNegoPendRequest',6);

        

        FOR RC IN GC_BCDEBTNEGOTIATION.CUDEBNEGOBYPRODANDSTAT(INUSERVICENUMBER) LOOP
            BOEXISTSREQUEST := TRUE;
            EXIT;
        END LOOP;

        IF (BOEXISTSREQUEST) THEN
            ERRORS.SETERROR(CSBEXISTSDEBTNEGOREQ,INUSERVICENUMBER);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        UT_TRACE.TRACE('Fin: GC_BODebtNegotiation.ValDebtNegoPendRequest',6);
        
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error: GC_BODebtNegotiation.ValDebtNegoPendRequest',6);
            RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error: GC_BODebtNegotiation.ValDebtNegoPendRequest',6);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALDEBTNEGOPENDREQUEST;


    





























    PROCEDURE VALPRODFORNEGOTIATION
    (
        INUSERVICENUMBER    IN    SERVSUSC.SESUNUSE%TYPE
    )
    IS
        
        
        
        
        CNUPOSITIVE_BAL     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 524;
        
        
        
        
        NUPACKAGETYPE       PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%TYPE;
        
        BORESTRICTION       BOOLEAN;
        
        BOEXISTSCHARGES     BOOLEAN;
        
        SBAPPLICATION       PROCESOS.PROCCODI%TYPE;
    BEGIN

        UT_TRACE.TRACE('Inicio: GC_BODebtNegotiation.ValProdForNegotiation',4);
        UT_TRACE.TRACE('Producto['||INUSERVICENUMBER||']',5);
        
        
        PKSERVNUMBERMGR.VALIDATENULL(INUSERVICENUMBER);

        
        PKSERVNUMBERMGR.VALIDATENULLAPP(INUSERVICENUMBER);

        
        IF ( RC_BCPOSITIVEBALANCE.FNUGETPOSITIVEBALANCE(INUSERVICENUMBER) > 0 ) THEN

            
            GE_BOERRORS.SETERRORCODEARGUMENT( CNUPOSITIVE_BAL,
                                              TO_CHAR( INUSERVICENUMBER ) );
        END IF;

        

        PKBOPROCESSSECURITY.VALIDATEPRODUCTSECURITY(INUSERVICENUMBER,CSBGCNED);

        
        NUPACKAGETYPE := PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME(CSBDEBTNEGOTIATION);

        

        BORESTRICTION := CC_BORESTRICTION.FBLEXISTRESTBYPRODANDPKGTYPE(INUSERVICENUMBER,NULL,NULL,NUPACKAGETYPE);

        IF(BORESTRICTION) THEN
            ERRORS.SETERROR(CSBRESTRICTION);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        PKSERVNUMBERMGR.VALWITHOUTCLAIM(INUSERVICENUMBER);

        
        BOEXISTSCHARGES := PKCHARGEMGR.FBLEXISTCHARGBILLNULLSERVICE(INUSERVICENUMBER);

        IF(BOEXISTSCHARGES) THEN
            ERRORS.SETERROR(CSBEXISTSCHARGES,INUSERVICENUMBER);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        

        VALDEBTNEGOPENDREQUEST(INUSERVICENUMBER);

        

        CC_BCWAITFORPAYMENT.VALFINREQINPROCCESS(INUSERVICENUMBER);
        
        
         SBAPPLICATION := PKERRORS.FSBGETAPPLICATION;
         UT_TRACE.TRACE('Aplicaci�n['||SBAPPLICATION||']',5);

         IF (SBAPPLICATION IS NOT NULL) THEN

             GNUPRODUCTID := INUSERVICENUMBER;
             
             CC_BOACTIONEVENT.RAISEACTIONEVENT( CNUSELECT_PROD_EVENT,
                                                SBAPPLICATION
                                              );
         END IF;

        UT_TRACE.TRACE('Fin: GC_BODebtNegotiation.ValProdForNegotiation',4);

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error: GC_BODebtNegotiation.ValProdForNegotiation',4);
            RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error: GC_BODebtNegotiation.ValProdForNegotiation',4);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALPRODFORNEGOTIATION;
    


    















    PROCEDURE GETPRODUCTFORDEBTNEG
    (
        ONUPRODUCTID    OUT  SERVSUSC.SESUNUSE%TYPE
    )
    IS
    BEGIN
    UT_TRACE.TRACE( 'INICIO GC_BODebtNegotiation.GetProductForDebtNeg', CNUTRACE_LEVEL + 1);

        ONUPRODUCTID := GNUPRODUCTID;

    UT_TRACE.TRACE( 'FIN GC_BODebtNegotiation.GetProductForDebtNeg', CNUTRACE_LEVEL + 1 );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETPRODUCTFORDEBTNEG;
    

    

















    PROCEDURE VALPRODFORNEGOTIATION
    (
        INUSERVICENUMBER    IN      SERVSUSC.SESUNUSE%TYPE,
        ONUERRORCODE        OUT     NUMBER,
        OSBERRORMESSAGE     OUT     VARCHAR2
    )
    IS
    BEGIN

        UT_TRACE.TRACE( 'INICIO GC_BODebtNegotiation.ValProdForNegotiation', CNUTRACE_LEVEL + 1);

        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE,OSBERRORMESSAGE);

        VALPRODFORNEGOTIATION(INUSERVICENUMBER);

        UT_TRACE.TRACE( 'FIN GC_BODebtNegotiation.ValProdForNegotiation', CNUTRACE_LEVEL + 1 );

    EXCEPTION
         WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    END VALPRODFORNEGOTIATION;
    


    


















    PROCEDURE VALIDBASICDEBTNEGOT
    (
        INUDEBTNEGOTREQUEST    IN    GC_DEBT_NEGOTIATION.PACKAGE_ID%TYPE,
        ONUDEBTNEGOTID         OUT   GC_DEBT_NEGOTIATION.DEBT_NEGOTIATION_ID%TYPE
    )
    IS
        
        RCGC_DEBT_NEGOTIATION    GC_DEBT_NEGOTIATION%ROWTYPE;
    BEGIN

        UT_TRACE.TRACE('Inicio GC_BODebtNegotiation.ValidBasicDebtNegot',5);

        
        IF ( INUDEBTNEGOTREQUEST IS NULL ) THEN
            ERRORS.SETERROR(CNUNULL_ATTRIBUTE,'Solicitud de Negociaci�n de Deuda');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        
        RCGC_DEBT_NEGOTIATION := NULL;

        
        GC_BCDEBTNEGOTIATION.GETDEBTNEGOTIATIONDATA( INUDEBTNEGOTREQUEST,
                                                     RCGC_DEBT_NEGOTIATION
                                                   );

        
        IF (RCGC_DEBT_NEGOTIATION.DEBT_NEGOTIATION_ID IS NULL) THEN
            ERRORS.SETERROR(CNURECORD_NOT_EXIST,'Negociaci�n De Deuda ['||RCGC_DEBT_NEGOTIATION.DEBT_NEGOTIATION_ID||']');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        
        ONUDEBTNEGOTID := RCGC_DEBT_NEGOTIATION.DEBT_NEGOTIATION_ID;
        UT_TRACE.TRACE('Identificador de la negociaci�n de Deuda['||ONUDEBTNEGOTID||']',6);
        UT_TRACE.TRACE('Fin GC_BODebtNegotiation.ValidBasicDebtNegot',5);

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDBASICDEBTNEGOT;



    



















    PROCEDURE VALIDWAITSIGNACTIVITY
    (
        INUDEBTNEGOTREQUEST    IN    GC_DEBT_NEGOTIATION.PACKAGE_ID%TYPE
    )
    IS
        

        BOWAITSIGN    BOOLEAN;

    BEGIN

        UT_TRACE.TRACE('Inicio GC_BODebtNegotiation.ValidWaitSignActivity',5);

        

        BOWAITSIGN := MO_BOWF_PACK_INTERFAC.FBLACTIVITYEXIST ( INUDEBTNEGOTREQUEST,
                                                               CNUWAIT_SIGN,
                                                               MO_BOSTATUSPARAMETER.FNUGETSTA_ACTIV_STANDBY
                                                             );

        

        IF ( NOT BOWAITSIGN ) THEN
            UT_TRACE.TRACE('ERROR - La actividad actual del flujo de negocio no corresponde a ''Espera Visado Negociaci�n''',6);
            ERRORS.SETERROR(CNUNOT_NEGOT_SIGN,'Solicitud['||INUDEBTNEGOTREQUEST||']');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        UT_TRACE.TRACE('Fin GC_BODebtNegotiation.ValidWaitSignActivity',5);

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDWAITSIGNACTIVITY;


    



















    PROCEDURE VALIDFINANCIALPROFILE
    (
        INUDEBTNEGOTREQUEST    IN    GC_DEBT_NEGOTIATION.PACKAGE_ID%TYPE
    )
    IS
        
        NUUSERID              SA_USER.USER_ID%TYPE;
       
        SBSIGN                VARCHAR2(1);

    BEGIN

        UT_TRACE.TRACE('Inicio GC_BODebtNegotiation.ValidFinancialProfile',5);

        
        NUUSERID := SA_BOUSER.FNUGETUSERID;
        UT_TRACE.TRACE('Identificador del Usuario ['||NUUSERID||']',5);

        

        SBSIGN := GC_BODEBTNEGOTIATION.FSBCANBESIGN( INUDEBTNEGOTREQUEST,
                                                     NUUSERID
                                                   );

        IF (SBSIGN = CC_BOCONSTANTS.CSBNO) THEN
            UT_TRACE.TRACE('ERROR - El usuario['||NUUSERID||'] no est� autorizado para visar la negociaci�n de deuda',5);
            ERRORS.SETERROR(CNUNOT_USER_SIGN,NUUSERID||'|'||'Solicitud['||INUDEBTNEGOTREQUEST||']');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        UT_TRACE.TRACE('Fin GC_BODebtNegotiation.ValidFinancialProfile',5);

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDFINANCIALPROFILE;



    























    PROCEDURE SIGNDEBTNEGOTIATION
    (
        INUDEBTNEGOTREQUEST    IN    GC_DEBT_NEGOTIATION.PACKAGE_ID%TYPE
    )
    IS
        
        RCDEBTNEGOTIATION    DAGC_DEBT_NEGOTIATION.STYGC_DEBT_NEGOTIATION;
        
        NUPERSONID           GC_DEBT_NEGOTIATION.PERSON_ID%TYPE;
        
        SBTERMINAL           GC_DEBT_NEGOTIATION.SIGN_TERMINAL%TYPE;
        
        NUDEBTNEGOTID        GC_DEBT_NEGOTIATION.DEBT_NEGOTIATION_ID%TYPE;

    BEGIN

        UT_TRACE.TRACE('Inicio GC_BODebtNegotiation.SignDebtNegotiation',4);
        UT_TRACE.TRACE('Solicitud de Negociaci�n de Deuda ['||INUDEBTNEGOTREQUEST||']',5);
        
        
        IF( GC_BODEBTNEGOTIATION.FBODEBTHASCHANGED( INUDEBTNEGOTREQUEST ) ) THEN
        
            
            MO_BOWF_PACK_INTERFAC.PREPNOTTOWFPACK
            (
                INUDEBTNEGOTREQUEST,
                CNUWAIT_SIGN,
                MO_BOCAUSAL.FNUGETFAIL,
                MO_BOSTATUSPARAMETER.FNUGETSTA_ACTIV_STANDBY,
                FALSE
            );

            
            RETURN;
        
        END IF;

        
        VALIDBASICDEBTNEGOT(INUDEBTNEGOTREQUEST, NUDEBTNEGOTID);

        

        VALIDWAITSIGNACTIVITY(INUDEBTNEGOTREQUEST);

        

        VALIDFINANCIALPROFILE(INUDEBTNEGOTREQUEST);

        
        RCDEBTNEGOTIATION := DAGC_DEBT_NEGOTIATION.FRCGETRECORD(NUDEBTNEGOTID);

        
        NUPERSONID := GE_BOPERSONAL.FNUGETPERSONID;
        UT_TRACE.TRACE('Identificador del Funcionario ['||NUPERSONID||']',5);

        
        SBTERMINAL := PKGENERALSERVICES.FSBGETTERMINAL;
        UT_TRACE.TRACE('Terminal ['||SBTERMINAL||']',5);

        
        RCDEBTNEGOTIATION.SIGNED          := CC_BOCONSTANTS.CSBSI;
        RCDEBTNEGOTIATION.SIGN_DATE       := SYSDATE;
        RCDEBTNEGOTIATION.PERSON_ID       := NUPERSONID;
        RCDEBTNEGOTIATION.SIGN_TERMINAL   := SBTERMINAL;

        
        DAGC_DEBT_NEGOTIATION.UPDRECORD(RCDEBTNEGOTIATION);

        

        MO_BOWF_PACK_INTERFAC.PREPNOTTOWFPACK ( RCDEBTNEGOTIATION.PACKAGE_ID,
                                                CNUWAIT_SIGN,
                                                MO_BOCAUSAL.FNUGETSUCCESS,
                                                MO_BOSTATUSPARAMETER.FNUGETSTA_ACTIV_STANDBY,
                                                FALSE
                                              );

        UT_TRACE.TRACE('Fin GC_BODebtNegotiation.SignDebtNegotiation',4);

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SIGNDEBTNEGOTIATION;



    


















    PROCEDURE CANCELDEBTNEGOTIATION
    (
        INUDEBTNEGOTREQUEST    IN    GC_DEBT_NEGOTIATION.PACKAGE_ID%TYPE
    )
    IS
        
        NUDEBTNEGOTID        GC_DEBT_NEGOTIATION.DEBT_NEGOTIATION_ID%TYPE;
    
    BEGIN

        UT_TRACE.TRACE('Inicio GC_BODebtNegotiation.CancelDebtNegotiation',4);
        UT_TRACE.TRACE('Solicitud de Negociaci�n de Deuda ['||INUDEBTNEGOTREQUEST||']',5);

        
        VALIDBASICDEBTNEGOT(INUDEBTNEGOTREQUEST, NUDEBTNEGOTID);

        

        VALIDWAITSIGNACTIVITY(INUDEBTNEGOTREQUEST);

        

        VALIDFINANCIALPROFILE(INUDEBTNEGOTREQUEST);

        

        MO_BOWF_PACK_INTERFAC.PREPNOTTOWFPACK ( INUDEBTNEGOTREQUEST,
                                                CNUWAIT_SIGN,
                                                MO_BOCAUSAL.FNUGETFAIL,
                                                MO_BOSTATUSPARAMETER.FNUGETSTA_ACTIV_STANDBY,
                                                FALSE
                                              );

        UT_TRACE.TRACE('Fin GC_BODebtNegotiation.CancelDebtNegotiation',4);

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CANCELDEBTNEGOTIATION;



    





















    FUNCTION FNUDISCOUNTEDVALUE
    (
        INUDEBTNEGOTID    IN    GC_DEBT_NEGOTIATION.DEBT_NEGOTIATION_ID%TYPE
    )
    RETURN NUMBER
    IS
        
        TBPRODBYDEBTNEGOT     GC_BCDEBTNEGOPRODUCT.TYTBDEBTNEGOPRODUCTS;
        
        NUINDEXPROD           NUMBER;
        
        TBCHARGEBYDEBNEGOT    GC_BCDEBTNEGOCHARGE.TYTBDEBTNEGOCHARGES;
        
        NUINDEXCHARGE         NUMBER;
        
        NUDISCOUNTEDVALUE     NUMBER := 0;

    BEGIN

        UT_TRACE.TRACE('Inicio GC_BODebtNegotiation.fnuDiscountedValue', 4);
        UT_TRACE.TRACE('Identificador Negociaci�n de Deuda ['||INUDEBTNEGOTID||']',5);

        
        GC_BCDEBTNEGOPRODUCT.GETDEBTNEGOPRODUCTS(INUDEBTNEGOTID, TBPRODBYDEBTNEGOT);

        
        NUINDEXPROD := TBPRODBYDEBTNEGOT.FIRST;
        WHILE (NUINDEXPROD IS NOT NULL) LOOP
            UT_TRACE.TRACE('Producto ['||TBPRODBYDEBTNEGOT(NUINDEXPROD).SESUNUSE||']',6);

            
            GC_BCDEBTNEGOCHARGE.GETDEBTNEGOCHARGES(TBPRODBYDEBTNEGOT(NUINDEXPROD).DEBT_NEGOT_PROD_ID, TBCHARGEBYDEBNEGOT);

            
            NUINDEXCHARGE := TBCHARGEBYDEBNEGOT.FIRST;
            WHILE(NUINDEXCHARGE IS NOT NULL) LOOP
                UT_TRACE.TRACE('Concepto ['||TBCHARGEBYDEBNEGOT(NUINDEXCHARGE).CONCCODI||']',7);

                
                IF ( TBCHARGEBYDEBNEGOT(NUINDEXCHARGE).IS_DISCOUNT = GE_BOCONSTANTS.CSBYES ) THEN
                    NUDISCOUNTEDVALUE := NUDISCOUNTEDVALUE + TBCHARGEBYDEBNEGOT(NUINDEXCHARGE).BILLED_VALUE;
                END IF;

                
                NUINDEXCHARGE := TBCHARGEBYDEBNEGOT.NEXT(NUINDEXCHARGE);
            END LOOP;

            
            NUINDEXPROD := TBPRODBYDEBTNEGOT.NEXT(NUINDEXPROD);
        END LOOP;

        UT_TRACE.TRACE('Valor de Descuento ['||NUDISCOUNTEDVALUE||']',5);
        UT_TRACE.TRACE('Fin GC_BODebtNegotiation.fnuDiscountedValue', 4);
        RETURN NUDISCOUNTEDVALUE;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUDISCOUNTEDVALUE;



    




















    FUNCTION FSBCANBESIGN
    (
        INUDEBTNEGOTREQUEST    IN    GC_DEBT_NEGOTIATION.PACKAGE_ID%TYPE,
        INUUSERID              IN    SA_USER.USER_ID%TYPE DEFAULT NULL
    )RETURN VARCHAR2
    IS
        
        NUDISCOUNTEDVALUE    NUMBER;
        
        NUUSERID             SA_USER.USER_ID%TYPE;
        
        NUDEBTNEGOTID        GC_DEBT_NEGOTIATION.DEBT_NEGOTIATION_ID%TYPE;
        
        RCDEBTNEGOTMOTIVE    DAMO_MOTIVE.STYMO_MOTIVE;
        
        NUCOMPANYID          SUSCRIPC.SUSCSIST%TYPE;
        
        SBSUBSMONEYTYPE      SISTEMA.SISTMOLO%TYPE;
        


        OBOVALIDBUDGET       BOOLEAN;


    BEGIN

        UT_TRACE.TRACE('Inicio GC_BODebtNegotiation.fsbCanBeSign',4);
        UT_TRACE.TRACE('Solicitud de Negociaci�n de Deuda ['||INUDEBTNEGOTREQUEST||']',5);

        
        VALIDBASICDEBTNEGOT(INUDEBTNEGOTREQUEST, NUDEBTNEGOTID);

        
        NUDISCOUNTEDVALUE := GC_BODEBTNEGOTIATION.FNUDISCOUNTEDVALUE(NUDEBTNEGOTID);
        UT_TRACE.TRACE('Valor a Descontar por la Negociaci�n de Deuda ['||NUDISCOUNTEDVALUE||']',5);
        
        
        RCDEBTNEGOTMOTIVE := MO_BOPACKAGES.FRCGETMOTIBYMOTITYPE(INUDEBTNEGOTREQUEST, CNUDEBT_NEGOT_MOTY_TYPE, TRUE, FALSE);
        UT_TRACE.TRACE('Motivo de Negociaci�n de Deuda ['||RCDEBTNEGOTMOTIVE.MOTIVE_ID||']',5);
        
        
        NUCOMPANYID := PKTBLSUSCRIPC.FNUGETSUSCSIST(RCDEBTNEGOTMOTIVE.SUBSCRIPTION_ID);
        UT_TRACE.TRACE('Empresa de la Suscripci�n ['||NUCOMPANYID||']',5);
        
        
        SBSUBSMONEYTYPE := PKTBLSISTEMA.FSBGETLOCALCURRENCY(NUCOMPANYID);
        UT_TRACE.TRACE('Tipo de Moneda de la Empresa ['||SBSUBSMONEYTYPE||']',5);

        
        IF (INUUSERID IS NULL) THEN
            NUUSERID := SA_BOUSER.FNUGETUSERID;
        ELSE
            NUUSERID := INUUSERID;
        END IF;
        UT_TRACE.TRACE('Identificador del usuario ['||NUUSERID||']',5);

        


        GE_BOFINANCIALPROFILE.VERIFYUSERMAXBUDGET( NUUSERID,
                                                   CNUACTION_AMOUNT_ID,
                                                   NUDISCOUNTEDVALUE,
                                                   SBSUBSMONEYTYPE,
                                                   OBOVALIDBUDGET
                                                 );

        IF (OBOVALIDBUDGET) THEN
            UT_TRACE.TRACE('Visar Negociaci�n de Deuda',5);
            UT_TRACE.TRACE('Fin GC_BODebtNegotiation.fsbCanBeSign',4);
            RETURN CC_BOCONSTANTS.CSBSI;
        ELSE
             UT_TRACE.TRACE('No Visar Negociaci�n de Deuda',5);
             UT_TRACE.TRACE('Fin GC_BODebtNegotiation.fsbCanBeSign',4);
            RETURN CC_BOCONSTANTS.CSBNO;
        END IF;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBCANBESIGN;
    

    



















    PROCEDURE VALIDATEPRODBAL
    (
        INUROWNUMBER        IN      NUMBER
    )
    IS
    BEGIN

        UT_TRACE.TRACE( 'Inicio GC_BODebtNegotiation.ValidateProdBal ['||GTBPRODUCTS(INUROWNUMBER).PRODUCT_ID||']['||GTBPRODUCTS(INUROWNUMBER).PENDING_BALANCE||']['||GTBPRODUCTS(INUROWNUMBER).DEFERRED_PENDING_BAL||']', CNUTRACE_LEVEL);

        IF(GTBPRODUCTS(INUROWNUMBER).PENDING_BALANCE <= PKBILLCONST.CERO
            AND GTBPRODUCTS(INUROWNUMBER).DEFERRED_PENDING_BAL <= PKBILLCONST.CERO
            AND GTBPRODUCTS(INUROWNUMBER).PUNISH_BALANCE <= PKBILLCONST.CERO)
        THEN
            GE_BOERRORS.SETERRORCODEARGUMENT(CNUPROD_NO_DEBT, GTBPRODUCTS(INUROWNUMBER).PRODUCT_ID);
        END IF;

        UT_TRACE.TRACE( 'Fin GC_BODebtNegotiation.ValidateProdBal', CNUTRACE_LEVEL);

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDATEPRODBAL;

    
















    PROCEDURE VALIDATEPRODBAL
    (
        INUROWNUMBER        IN      NUMBER,
        ONUERRORCODE        OUT     NUMBER,
        OSBERRORMESSAGE     OUT     VARCHAR2
    )
    IS
    BEGIN

        UT_TRACE.TRACE( 'INICIO GC_BODebtNegotiation.ValidateProdBal', CNUTRACE_LEVEL + 1);

        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE,OSBERRORMESSAGE);

        VALIDATEPRODBAL(INUROWNUMBER);

        UT_TRACE.TRACE( 'FIN GC_BODebtNegotiation.ValidateProdBal', CNUTRACE_LEVEL + 1);

    EXCEPTION
         WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    END VALIDATEPRODBAL;

    

































    PROCEDURE REGISTERPRODDEBTNEG
    (
        INUNEGOTIATIONID    IN  GC_DEBT_NEGOT_PROD.DEBT_NEGOTIATION_ID%TYPE,
        INUPAYMENTMETHOD    IN  GC_DEBT_NEGOTIATION.PAYMENT_METHOD%TYPE,
        INUPERSONID         IN  GE_PERSON.PERSON_ID%TYPE
    )
    IS
        RCNEGPRODUCT    DAGC_DEBT_NEGOT_PROD.STYGC_DEBT_NEGOT_PROD;
        NUINDEX         NUMBER;

        
        NUVALNOFACT     GC_DEBT_NEGOT_PROD.NOT_BILLED_VALUE%TYPE;
        NUVALTRASDEF    NUMBER;

    BEGIN
        UT_TRACE.TRACE( 'INICIO GC_BODebtNegotiation.RegisterProdDebtNeg('||
                        INUNEGOTIATIONID||','||INUPAYMENTMETHOD||','||INUPERSONID||')', CNUTRACE_LEVEL + 1);

        NUINDEX := GTBPRODUCTS.FIRST;

        LOOP
            EXIT WHEN NUINDEX IS NULL;

            IF(GTBPRODUCTS(NUINDEX).SELECTED = GE_BOCONSTANTS.CSBYES)
            THEN

                
                RCNEGPRODUCT.DEBT_NEGOT_PROD_ID   := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SEQ_GC_DEBT_NEGOT_P_197149');
                RCNEGPRODUCT.DEBT_NEGOTIATION_ID  := INUNEGOTIATIONID;
                RCNEGPRODUCT.SESUNUSE             := GTBPRODUCTS(NUINDEX).PRODUCT_ID;
                RCNEGPRODUCT.LATE_CHARGE_LIQ_DATE := GTBPRODUCTS(NUINDEX).ARREARS_LAST_LIQ_DATE;
                RCNEGPRODUCT.LATE_CHARGE_DAYS     := GTBPRODUCTS(NUINDEX).ARREARS_DAYS;
                RCNEGPRODUCT.BILLED_LATE_CHARGE   := GTBPRODUCTS(NUINDEX).ARREARS_BILLED;
                RCNEGPRODUCT.NOT_BILLED_LATE_CHA  := GTBPRODUCTS(NUINDEX).ARREARS_NOT_BILLED;
                RCNEGPRODUCT.NOT_BILLED_VALUE     := 0;
                RCNEGPRODUCT.PENDING_BALANCE      := 0;

                IF (INUPAYMENTMETHOD = GC_BODEBTNEGOTIATION.CSBFINANCING ) THEN
                    RCNEGPRODUCT.VALUE_TO_PAY   := CC_BOFINANCING.FNUGETPRODUCTBALANCE(GTBPRODUCTS(NUINDEX).PRODUCT_ID);
                ELSE
                    RCNEGPRODUCT.VALUE_TO_PAY   := GTBPRODUCTS(NUINDEX).VALUE_TO_PAY;
                END IF;

                RCNEGPRODUCT.EXONER_RECONN_CHARGE := GTBPRODUCTS(NUINDEX).EXO_RE_INSTALL;

                DAGC_DEBT_NEGOT_PROD.INSRECORD(RCNEGPRODUCT);
                UT_TRACE.TRACE('Se registr� el producto negociado '||RCNEGPRODUCT.DEBT_NEGOT_PROD_ID, CNUTRACE_LEVEL + 2);

                


                GC_BODEBTNEGOCHARGES.DISTRIBUTECREDITS;

                
                GC_BODEBTNEGOCHARGES.REGISTERCHARGENEGO
                (
                    RCNEGPRODUCT.DEBT_NEGOT_PROD_ID,
                    RCNEGPRODUCT.SESUNUSE,
                    INUPERSONID,
                    NUVALNOFACT,
                    NUVALTRASDEF
                );
                
                
                GC_BODEBTNEGOCHARGES.REGISTERDISCOUNTNEGO
                (
                    RCNEGPRODUCT.DEBT_NEGOT_PROD_ID,
                    RCNEGPRODUCT.SESUNUSE,
                    INUPERSONID
                );

                
                RCNEGPRODUCT.NOT_BILLED_VALUE     := NUVALNOFACT;
                RCNEGPRODUCT.PENDING_BALANCE      := GTBPRODUCTS(NUINDEX).PENDING_BALANCE + NVL(GTBPRODUCTS(NUINDEX).REACTIV_VALUE, 0) + NUVALTRASDEF;
                
                UT_TRACE.TRACE('Valores NO facturados: '||RCNEGPRODUCT.NOT_BILLED_VALUE, CNUTRACE_LEVEL + 2);
                UT_TRACE.TRACE('Valores facturados: '||RCNEGPRODUCT.PENDING_BALANCE, CNUTRACE_LEVEL + 2);

                DAGC_DEBT_NEGOT_PROD.UPDRECORD(RCNEGPRODUCT);

            END IF;

            NUINDEX := GTBPRODUCTS.NEXT(NUINDEX);
        END LOOP;

        UT_TRACE.TRACE( 'FIN GC_BODebtNegotiation.RegisterProdDebtNeg', CNUTRACE_LEVEL + 1  );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END REGISTERPRODDEBTNEG;

    













































    PROCEDURE SAVENEGOTIATION
    (
        INUPROGRAM              IN  GC_DEBT_NEGOTIATION.PROCCONS%TYPE,
        INUPACKAGEID            IN  GC_DEBT_NEGOTIATION.PACKAGE_ID%TYPE,
        INUPERSONID             IN  GE_PERSON.PERSON_ID%TYPE,
        INUSUBSCRIPTION         IN  SUSCRIPC.SUSCCODI%TYPE,
        INUPAYMENTMETHOD        IN  GC_DEBT_NEGOTIATION.PAYMENT_METHOD%TYPE,
        INUVALUETONEGO          IN  DECIMAL,
        INUVALUETOPAY           IN  DECIMAL,
        INUPAYMAGREEMPLAN       IN  GC_DEBT_NEGOTIATION.PAYM_AGREEM_PLAN_ID%TYPE,
        OSBREQSIGNING           OUT GC_DEBT_NEGOTIATION.REQUIRE_SIGNING%TYPE,
        OSBREQPAYMENT           OUT GC_DEBT_NEGOTIATION.REQUIRE_PAYMENT%TYPE,
        ONUDEBTNEGOTIATIONID    OUT GC_DEBT_NEGOTIATION.DEBT_NEGOTIATION_ID%TYPE
    )
    IS
        
        RCNEGOTIATION DAGC_DEBT_NEGOTIATION.STYGC_DEBT_NEGOTIATION;
    
        
        SBREQSIGNING        VARCHAR2(1);
        SBREQPAYMENT        VARCHAR2(1);
        
        
        BOVALIDBUDGET       BOOLEAN;
        NUCOMPANY           SISTEMA.SISTCODI%TYPE;
    BEGIN

        UT_TRACE.TRACE( 'INCIO GC_BODebtNegotiation.SaveNegotiation', CNUTRACE_LEVEL );

        
        NUCOMPANY := PKTBLSUSCRIPC.FNUGETCOMPANY(INUSUBSCRIPTION);
        GE_BOFINANCIALPROFILE.VERIFYUSERMAXBUDGET
        (
            DAGE_PERSON.FNUGETUSER_ID(INUPERSONID),
            CNUACTION_AMOUNT_ID,
            INUVALUETONEGO,
            PKTBLSISTEMA.FSBGETLOCALCURRENCY(NUCOMPANY),
            BOVALIDBUDGET
        );

        
        IF(BOVALIDBUDGET)
        THEN
            SBREQSIGNING := GE_BOCONSTANTS.CSBNO;
        ELSE
            SBREQSIGNING := GE_BOCONSTANTS.CSBYES;
        END IF;
        UT_TRACE.TRACE('Requiere visado? R/: '||SBREQSIGNING, CNUTRACE_LEVEL+1);
        
        
        IF(INUVALUETOPAY > PKBILLCONST.CERO)
        THEN
            SBREQPAYMENT := GE_BOCONSTANTS.CSBYES;
        ELSE
            SBREQPAYMENT := GE_BOCONSTANTS.CSBNO;
        END IF;
        UT_TRACE.TRACE('Requiere pago? R/: '||SBREQPAYMENT, CNUTRACE_LEVEL+1);

        
        RCNEGOTIATION.DEBT_NEGOTIATION_ID   := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SEQ_GC_DEBT_NEGOTIA_197137');
        RCNEGOTIATION.PAYMENT_METHOD        := INUPAYMENTMETHOD;
        RCNEGOTIATION.PROCCONS              := INUPROGRAM;
        RCNEGOTIATION.PACKAGE_ID            := INUPACKAGEID;
        RCNEGOTIATION.REQUIRE_SIGNING       := SBREQSIGNING;
        RCNEGOTIATION.SIGNED                := GE_BOCONSTANTS.CSBNO;
        RCNEGOTIATION.REQUIRE_PAYMENT       := SBREQPAYMENT;
        RCNEGOTIATION.PAYM_AGREEM_PLAN_ID   := INUPAYMAGREEMPLAN;

        DAGC_DEBT_NEGOTIATION.INSRECORD(RCNEGOTIATION);
        
        UT_TRACE.TRACE('Se registr� la negociaci�n '||RCNEGOTIATION.DEBT_NEGOTIATION_ID, CNUTRACE_LEVEL+1);

        
        REGISTERPRODDEBTNEG
        (
            RCNEGOTIATION.DEBT_NEGOTIATION_ID,
            INUPAYMENTMETHOD,
            INUPERSONID
        );
        
        
        IF(INUPAYMENTMETHOD != CSBFINANCING)
        THEN
            CC_BCWAITFORPAYMENT.SAVEDEFERREDSDATA(INUPACKAGEID);
        END IF;

        UT_TRACE.TRACE( 'FIN GC_BODebtNegotiation.SaveNegotiation', CNUTRACE_LEVEL);

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SAVENEGOTIATION;

    






























    PROCEDURE LOADARREARSPRODUCT
    (
        ITBARREARS          IN  FA_BOLIQLATECONCEPTS.TYTBLATEDATA,
        NUPRODUCTID         IN  PR_PRODUCT.PRODUCT_ID%TYPE,
        ODTARREARSLAST      OUT GC_DEBT_NEGOT_PROD.LATE_CHARGE_LIQ_DATE%TYPE,
        ONUARREARSDAYS      OUT GC_DEBT_NEGOT_PROD.LATE_CHARGE_DAYS%TYPE,
        ONUBASEVALUE        OUT NUMBER,
        ONUARREARSBILLED    OUT NUMBER,
        ONUARREARSNOBILLED  OUT GC_DEBT_NEGOT_PROD.NOT_BILLED_VALUE%TYPE
    )
    IS
        
        RCCONCEPTO          CONCEPTO%ROWTYPE;

        
        NUINDEX             NUMBER;

    BEGIN

        UT_TRACE.TRACE( 'INCIO GC_BODebtNegotiation.LoadArrearsProduct', CNUTRACE_LEVEL + 1);
        
        
        ONUARREARSDAYS      := 0;
        ONUBASEVALUE        := 0;
        ONUARREARSBILLED    := 0;
        ONUARREARSNOBILLED  := 0;

        NUINDEX :=  ITBARREARS.FIRST;

        LOOP

            EXIT WHEN NUINDEX IS NULL;

            
            IF ITBARREARS(NUINDEX).DTFECHAULTLIQ < ODTARREARSLAST OR ODTARREARSLAST IS NULL THEN
                ODTARREARSLAST := ITBARREARS(NUINDEX).DTFECHAULTLIQ;
            END IF;

            
            IF ITBARREARS(NUINDEX).NULATEDAYS > ONUARREARSDAYS THEN
                ONUARREARSDAYS := ITBARREARS(NUINDEX).NULATEDAYS;
            END IF;

            
            ONUBASEVALUE    := ONUBASEVALUE + NVL( ITBARREARS(NUINDEX).NUBASEVALUE, 0 );
            ONUARREARSBILLED:= ONUARREARSBILLED + NVL( ITBARREARS(NUINDEX).NUGENLATEVALUE, 0 );

            
            PKINSTANCEDATAMGR.GETRECORDCONCEPT(  ITBARREARS(NUINDEX).NUCONCEPT, RCCONCEPTO );

            
            IF RCCONCEPTO.CONCCONE = PKCONSTANTE.SI THEN
                
                ONUARREARSNOBILLED := ONUARREARSNOBILLED + NVL( ITBARREARS(NUINDEX).NUNOTGENLATEVALUE , 0 );
                
                ADDARREARDATA(NUPRODUCTID, ITBARREARS(NUINDEX));
            END IF;
            
            NUINDEX := ITBARREARS.NEXT(NUINDEX);

        END LOOP;

        UT_TRACE.TRACE( 'FIN GC_BODebtNegotiation.LoadArrearsProduct', CNUTRACE_LEVEL + 1);

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END LOADARREARSPRODUCT;


    















    PROCEDURE SEARCHPOSITION
    (
        INUPRODUCT      IN          SERVSUSC.SESUNUSE%TYPE,
        ONUROWNUMBER    OUT NOCOPY  NUMBER
    )
    IS
        NUINDEX NUMBER;
    BEGIN
        UT_TRACE.TRACE( 'INICIO GC_BODebtNegotiation.SearchPosition Producto['||INUPRODUCT||']', CNUTRACE_LEVEL +1 );
        
        ONUROWNUMBER := NULL;
        
        NUINDEX := GTBPRODUCTS.FIRST;
        
        LOOP
            EXIT WHEN NUINDEX IS NULL;
            
            IF(GTBPRODUCTS(NUINDEX).PRODUCT_ID = INUPRODUCT)
            THEN
                ONUROWNUMBER := NUINDEX;
                EXIT;
            END IF;
            
            NUINDEX := GTBPRODUCTS.NEXT(NUINDEX);
        END LOOP;
        
        UT_TRACE.TRACE( 'INICIO GC_BODebtNegotiation.SearchPosition Posicin['||ONUROWNUMBER||']', CNUTRACE_LEVEL +1 );
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SEARCHPOSITION;


    









































    PROCEDURE LOADINFOPRODUCT
    (
        IRCPRODUCT      IN          DAPR_PRODUCT.STYPR_PRODUCT,
        INUPRODUCTBASE  IN          SERVSUSC.SESUNUSE%TYPE,
        IBORAISE        IN          BOOLEAN,
        ONUROWNUMBER    OUT NOCOPY  NUMBER
    )
    IS
        
        RCSERVSUSC          SERVSUSC%ROWTYPE;
        
        SBPERMITEREINS      VARCHAR2(1);
        
        NUPRODBASE          SERVSUSC.SESUNUSE%TYPE;
        NUPOSPRODBASE       NUMBER;

        
        NUBALANCE           NUMBER:=0;
        NUBALANCEDIF        NUMBER:=0;
        NUBALANCEREACT      NUMBER:=0;
        NUBALACENOBILLED    NUMBER:=0;
        TBCHARGESNOBILLED   PKBCCARGOS.TYTBRCCARGOS;

        
        SBSELECTED          VARCHAR2(1);

        
        RCOBPRODUCTO        CC_TYOBPRODUCT;

        
        DTARREARSLAST       GC_DEBT_NEGOT_PROD.LATE_CHARGE_LIQ_DATE%TYPE;
        NUARREARSDAYS       GC_DEBT_NEGOT_PROD.LATE_CHARGE_DAYS%TYPE;
        NUBASEVALUE         NUMBER;
        NUARREARSBILLED     NUMBER;
        NUARREARSNOBILLED   GC_DEBT_NEGOT_PROD.NOT_BILLED_VALUE%TYPE;
        TBARREARS           FA_BOLIQLATECONCEPTS.TYTBLATEDATA;
        
        
        NUERRORCODE         GE_ERROR_LOG.MESSAGE_ID%TYPE;
        SBERRORMESSAGE      GE_ERROR_LOG.DESCRIPTION%TYPE;
        
        
        NUPUNISHBAL         NUMBER := 0;
        
        TBPUNISHBALCHARGES  PKBCCHARGES.TYTBREACCHARGES;
    BEGIN

        UT_TRACE.TRACE( 'INICIO GC_BODebtNegotiation.LoadInfoProduct', CNUTRACE_LEVEL +1 );
        
        



        VALPRODFORNEGOTIATION (IRCPRODUCT.PRODUCT_ID,NUERRORCODE,SBERRORMESSAGE);
        IF(IBORAISE AND NUERRORCODE !=  GE_BOCONSTANTS.CNUSUCCESS)
        THEN
            GE_BOERRORS.EXCEPTIONCONTROLLED;
        END IF;

        IF(NUERRORCODE = GE_BOCONSTANTS.CNUSUCCESS)
        THEN
            SBSELECTED := GE_BOCONSTANTS.CSBYES;
        ELSE
            SBSELECTED := GE_BOCONSTANTS.CSBNO;
        END IF;

        
        RCSERVSUSC := PKTBLSERVSUSC.FRCGETRECORD( IRCPRODUCT.PRODUCT_ID,
                                                  PKCONSTANTE.NOCACHE );

        
        IF(INUPRODUCTBASE IS NULL)
        THEN
            NUPRODBASE := CC_BCFINANCING.FNUBASEPRODUCT( IRCPRODUCT.PRODUCT_ID );
        ELSE
            NUPRODBASE := INUPRODUCTBASE;
        END IF;

        


        SBPERMITEREINS := GE_BOCONSTANTS.CSBNO;

        IF (PKCHGSTSUSPAYMENTMGR.FBLEXISTCHANGESTATUSRULE(RCSERVSUSC.SESUSERV,CNUORDER_CONEXION,RCSERVSUSC.SESUESCO))
        THEN
            SBPERMITEREINS := GE_BOCONSTANTS.CSBYES;
        END IF;

        


        
        GC_BODEBTNEGOCHARGES.SETPUNISHCHARGES(IRCPRODUCT.PRODUCT_ID, TBPUNISHBALCHARGES, NUPUNISHBAL);

        
        IF(RCSERVSUSC.SESUESFN = PKBILLCONST.CSBEST_CASTIGADO AND SBSELECTED = GE_BOCONSTANTS.CSBYES)
        THEN
        
            UT_TRACE.TRACE( 'Reactiva Cartera', CNUTRACE_LEVEL);

            GC_BOCASTIGOCARTERA.GETPUNISHBALANCEBYPROD(IRCPRODUCT.PRODUCT_ID, TBPUNISHBALCHARGES);
            GC_BODEBTNEGOCHARGES.SETPUNISHCHARGES(IRCPRODUCT.PRODUCT_ID, TBPUNISHBALCHARGES, NUPUNISHBAL);

        END IF;

         


        GC_BODEBTNEGOCHARGES.SETCHARGESBILLED(IRCPRODUCT.PRODUCT_ID, NUBALANCE);

        


        NUBALANCEDIF := PKDEFERREDMGR.FNUGETDEFERREDBALSERVICE( IRCPRODUCT.PRODUCT_ID );

        


        FA_BOLIQLATECONCEPTS.LIQCONCEPTS
        (
            IRCPRODUCT.PRODUCT_ID,
            SYSDATE,
            FA_BOLIQLATECONCEPTS.CSBNEGOTIATIONMODE,
            TBCHARGESNOBILLED,
            TBARREARS
        );
        
        GC_BODEBTNEGOCHARGES.SETCHARGESNOBILLED(TBCHARGESNOBILLED,NUBALACENOBILLED);

        LOADARREARSPRODUCT
        (
            TBARREARS,
            IRCPRODUCT.PRODUCT_ID,
            DTARREARSLAST,
            NUARREARSDAYS,
            NUBASEVALUE,
            NUARREARSBILLED,
            NUARREARSNOBILLED
        );
        
        GTBPRODUCTS.EXTEND;
        GNUINDXPRODUCTS := GTBPRODUCTS.COUNT;

        


        RCOBPRODUCTO := CC_TYOBPRODUCT( NULL, NULL, NULL, NULL, NULL,NULL, NULL, NULL, NULL, NULL,
                                        NULL, NULL, NULL, NULL, NULL,NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

        
        RCOBPRODUCTO.ROW_NUMBER_            := GNUINDXPRODUCTS;
        RCOBPRODUCTO.PRODUCT_ID             := IRCPRODUCT.PRODUCT_ID;
        RCOBPRODUCTO.PRODUCT_TYPE_ID        := IRCPRODUCT.PRODUCT_TYPE_ID;
        RCOBPRODUCTO.STATUS_ID              := RCSERVSUSC.SESUESCO;
        RCOBPRODUCTO.CATEGORY_ID            := IRCPRODUCT.CATEGORY_ID;
        RCOBPRODUCTO.SUBCATEGORY_ID         := IRCPRODUCT.SUBCATEGORY_ID;
        RCOBPRODUCTO.PENDING_BALANCE        := NUBALANCE + NUBALACENOBILLED + NUBALANCEREACT;
        RCOBPRODUCTO.DEFERRED_PENDING_BAL   := NUBALANCEDIF;
        RCOBPRODUCTO.NOT_FINANCING_BALANCE  := 0.0;
        RCOBPRODUCTO.VALUE_TO_COLLECT       := 0.0;
        RCOBPRODUCTO.VALUE_TO_PAY           := 0.0;
        RCOBPRODUCTO.INSTALL_ADDRESS_ID     := IRCPRODUCT.ADDRESS_ID;
        RCOBPRODUCTO.ARREARS_LAST_LIQ_DATE  := DTARREARSLAST;
        RCOBPRODUCTO.ARREARS_DAYS           := NUARREARSDAYS;
        RCOBPRODUCTO.ARREARS_BASE_VALUE     := NUBASEVALUE;
        RCOBPRODUCTO.ARREARS_BILLED         := NUARREARSBILLED;
        RCOBPRODUCTO.ARREARS_NOT_BILLED     := NUARREARSNOBILLED;
        RCOBPRODUCTO.SEL_EXO_RE_INSTALL     := SBPERMITEREINS;
        RCOBPRODUCTO.EXO_RE_INSTALL         := GE_BOCONSTANTS.CSBNO;
        RCOBPRODUCTO.SELECTED               := SBSELECTED;
        RCOBPRODUCTO.BASE_PRODUCT_ID        := NVL( NUPRODBASE, PKCONSTANTE.NULLNUM );
        RCOBPRODUCTO.PUNISH_BALANCE         := NUPUNISHBAL;
        RCOBPRODUCTO.REACTIV_VALUE          := NUPUNISHBAL;

        ONUROWNUMBER := GNUINDXPRODUCTS;

        GTBPRODUCTS(GNUINDXPRODUCTS) := RCOBPRODUCTO;

        


        VALIDATEPRODBAL(GNUINDXPRODUCTS,NUERRORCODE,SBERRORMESSAGE);
        IF(IBORAISE AND NUERRORCODE !=  GE_BOCONSTANTS.CNUSUCCESS)
        THEN
            GE_BOERRORS.EXCEPTIONCONTROLLED;
        END IF;
        
        IF(GTBPRODUCTS(GNUINDXPRODUCTS).SELECTED = GE_BOCONSTANTS.CSBYES  AND  NUERRORCODE != 0)
        THEN
            GTBPRODUCTS(GNUINDXPRODUCTS).SELECTED := GE_BOCONSTANTS.CSBNO;
        END IF;
        
        


        IF(GTBPRODUCTS(GNUINDXPRODUCTS).SELECTED = GE_BOCONSTANTS.CSBYES  AND
            GTBPRODUCTS(GNUINDXPRODUCTS).BASE_PRODUCT_ID != PKCONSTANTE.NULLNUM)
        THEN
            SEARCHPOSITION(GTBPRODUCTS(GNUINDXPRODUCTS).BASE_PRODUCT_ID,NUPOSPRODBASE);
            
            IF(NUPOSPRODBASE IS NOT NULL AND GTBPRODUCTS(NUPOSPRODBASE).SELECTED = GE_BOCONSTANTS.CSBNO)
            THEN
                GTBPRODUCTS(GNUINDXPRODUCTS).SELECTED := GE_BOCONSTANTS.CSBNO;
            END IF;
        END IF;

        UT_TRACE.TRACE( 'FIN GC_BODebtNegotiation.LoadInfoProduct', CNUTRACE_LEVEL +1 );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END LOADINFOPRODUCT;

    


































    PROCEDURE LOADPRODFORDEBTNEG
    (
        INUSUSCRIPTION      IN      SUSCRIPC.SUSCCODI%TYPE,
        INUSERVICENUMBER    IN      SERVSUSC.SESUNUSE%TYPE,
        OCUPRODUCTS         OUT     PKCONSTANTE.TYREFCURSOR,
        OCUDEFERREDS        OUT     PKCONSTANTE.TYREFCURSOR,
        OCUARREARSUNBILLED  OUT     PKCONSTANTE.TYREFCURSOR
    )
    IS
        
        RCPR_PRODUCT        DAPR_PRODUCT.STYPR_PRODUCT;
        TBPR_PRODUCTS       DAPR_PRODUCT.TYTBPR_PRODUCT;
        NUIDXPR_PRODUCTS    NUMBER;

        
        RCPRODSDEPEND       PKBCDEPENDINGPRODUCT.TYRCDEPENDINGPRODUCTS;
        NUIDXPRODSDEPEND    NUMBER;
        NUROWNUMBER         NUMBER;

        
        TBPRODUCTS          GE_TYTBNUMBER;
        NUIDX               BINARY_INTEGER;
        
        NUADJUSTVALUE       CUENCOBR.CUCOSACU%TYPE;
        NUSUMPENDINGBAL     NUMBER := 0;

        
        
        
        PROCEDURE INITCOLLECTIONS
        IS
        BEGIN
            
            IF(GTBPRODUCTS IS NULL)
            THEN
                GTBPRODUCTS := CC_TYTBPRODUCT();
            ELSE
                GTBPRODUCTS.DELETE;
            END IF;
            
            TBPRODUCTS := GE_TYTBNUMBER();
        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END INITCOLLECTIONS;

    BEGIN
        UT_TRACE.TRACE( 'INICIO GC_BODebtNegotiation.LoadProdForDebtNeg', CNUTRACE_LEVEL );

        
        INITCOLLECTIONS;

        GC_BODEBTNEGOCHARGES.INITIALIZEDATA;
        GTBARREARS := CC_TYTBARREAR();

        


        IF(INUSERVICENUMBER IS NULL)
        THEN

            
            OPEN PR_BCPRODUCT.CUPRODUCTSSUBSCRIPTION(INUSUSCRIPTION);
            FETCH PR_BCPRODUCT.CUPRODUCTSSUBSCRIPTION BULK COLLECT INTO TBPR_PRODUCTS;
            CLOSE PR_BCPRODUCT.CUPRODUCTSSUBSCRIPTION;

            NUIDXPR_PRODUCTS := TBPR_PRODUCTS.FIRST;

            LOOP
                EXIT WHEN NUIDXPR_PRODUCTS IS NULL;

                LOADINFOPRODUCT(TBPR_PRODUCTS(NUIDXPR_PRODUCTS),NULL,FALSE,NUROWNUMBER);

                NUIDXPR_PRODUCTS := TBPR_PRODUCTS.NEXT(NUIDXPR_PRODUCTS);
            END LOOP;

            
            CC_BOFINANCING.LOADDEFWITHBALBYSUBS(INUSUSCRIPTION);
        


        ELSE

            
            RCPR_PRODUCT :=  DAPR_PRODUCT.FRCGETRECORD(INUSERVICENUMBER);
            LOADINFOPRODUCT(RCPR_PRODUCT,NULL,TRUE,NUROWNUMBER);

            
            IF(GTBPRODUCTS(NUROWNUMBER).BASE_PRODUCT_ID != PKCONSTANTE.NULLNUM)
            THEN
                GE_BOERRORS.SETERRORCODEARGUMENT(901509, GTBPRODUCTS(NUROWNUMBER).PRODUCT_ID);
            END IF;

            
            TBPRODUCTS.EXTEND;
            TBPRODUCTS(TBPRODUCTS.COUNT) :=  NEW GE_TYOBNUMBER(RCPR_PRODUCT.PRODUCT_ID);

            
            PKBCDEPENDINGPRODUCT.GETDEPENDINGPRODUCTS( INUSERVICENUMBER,NULL,RCPRODSDEPEND );

            
            NUIDXPRODSDEPEND := RCPRODSDEPEND.TBSESUNUSE.FIRST;

            LOOP
                EXIT WHEN NUIDXPRODSDEPEND IS NULL;

                IF(RCPR_PRODUCT.SUBSCRIPTION_ID = RCPRODSDEPEND.TBSESUSUSC(NUIDXPRODSDEPEND))
                THEN
                    LOADINFOPRODUCT
                    (
                        DAPR_PRODUCT.FRCGETRECORD(RCPRODSDEPEND.TBSESUNUSE(NUIDXPRODSDEPEND)),
                        INUSERVICENUMBER,
                        FALSE,
                        NUROWNUMBER
                    );
                ELSE
                    LOADINFOPRODUCT
                    (
                        DAPR_PRODUCT.FRCGETRECORD(RCPRODSDEPEND.TBSESUNUSE(NUIDXPRODSDEPEND)),
                        PKCONSTANTE.NULLNUM,
                        FALSE,
                        NUROWNUMBER
                    );
                END IF;

                
                TBPRODUCTS.EXTEND;
                TBPRODUCTS(TBPRODUCTS.COUNT) := NEW GE_TYOBNUMBER(RCPRODSDEPEND.TBSESUNUSE(NUIDXPRODSDEPEND));

                NUIDXPRODSDEPEND := RCPRODSDEPEND.TBSESUNUSE.NEXT(NUIDXPRODSDEPEND);
            END LOOP;

            
            CC_BOFINANCING.LOADDEFWITHBALBYPRODS(TBPRODUCTS);

        END IF;
        
        UT_TRACE.TRACE( 'Productos ['||GTBPRODUCTS.COUNT||']', CNUTRACE_LEVEL + 1);

        
        NUIDX := GTBPRODUCTS.FIRST;
        LOOP
            EXIT WHEN NUIDX IS NULL;

            GC_BODEBTNEGOCHARGES.ADJUSTLOADPRODDEBTNEG
            (
                GTBPRODUCTS(NUIDX).PRODUCT_ID,
                NUADJUSTVALUE
            );

            GTBPRODUCTS(NUIDX).PENDING_BALANCE := GTBPRODUCTS(NUIDX).PENDING_BALANCE + NUADJUSTVALUE;
            NUSUMPENDINGBAL := NUSUMPENDINGBAL + GTBPRODUCTS(NUIDX).PENDING_BALANCE;

            NUIDX := GTBPRODUCTS.NEXT(NUIDX);
        END LOOP;
        
        UT_TRACE.TRACE('Deuda ajustada: '||NUSUMPENDINGBAL,8);
        

        
        GC_BCDEBTNEGOTIATION.GETPRODUTSFROMCOLL(GTBPRODUCTS,OCUPRODUCTS);

        
        CC_BOFINANCING.GETDEFERREDSFROMMEM(OCUDEFERREDS);
        
        
        GC_BCDEBTNEGOTIATION.GETARREARSUNBILLED(GTBARREARS, OCUARREARSUNBILLED);

        UT_TRACE.TRACE( 'FIN GC_BODebtNegotiation.LoadProdForDebtNeg', CNUTRACE_LEVEL );
	EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END LOADPRODFORDEBTNEG;


    


























    PROCEDURE GETCHARGES
    (
        ISBINDEXDEF         IN       VARCHAR2,
        OCUCHARGES          OUT      PKCONSTANTE.TYREFCURSOR
    )
    IS

        

        TBDEFCHARGES            PKCHARGEMGR.TYRCTBCHARGES;
        TBDEFERRED              MO_TYTBDEFERRED;

        NUIDX                   BINARY_INTEGER;
        NUPRODUCTID             PR_PRODUCT.PRODUCT_ID%TYPE;
        NUBALANCEREACT          NUMBER:=0;
        
        
        TBPUNISHCHARGES         PKBCCHARGES.TYTBREACCHARGES;
        
        TBCHARGESREACTIVE       PKBCCHARGES.TYTBREACCHARGES;
    BEGIN

        UT_TRACE.TRACE( 'INICIO GC_BODebtNegotiation.GetCharges', CNUTRACE_LEVEL );

        

        CC_BOFINANCING.SETSELECTEDDEFERRED(ISBINDEXDEF);
        
        
        CC_BOFINANCING.GETDEFERREDSCOLLECTION(TBDEFERRED);

        
        CC_BODEFTOCURTRANSFER.TRANSDEFINMEMORY
        (
            PKBILLCONST.CERO,
            SYSDATE,
            TBDEFERRED,
            TBDEFCHARGES
        );
        
        
        GC_BODEBTNEGOCHARGES.SETCHARGESDEFERRED(TBDEFCHARGES);
        
        
        GC_BODEBTNEGOCHARGES.INITCHARGESREACTIVE();
        
        NUIDX := GTBPRODUCTS.FIRST;
        LOOP
            EXIT WHEN NUIDX IS NULL;

            IF(GTBPRODUCTS(NUIDX).SELECTED = GE_BOCONSTANTS.CSBYES) THEN
            
                NUPRODUCTID := GTBPRODUCTS(NUIDX).PRODUCT_ID;
                UT_TRACE.TRACE( 'nuProductId '||NUPRODUCTID||' REACTIV_VALUE '||
                        GTBPRODUCTS(NUIDX).REACTIV_VALUE||' PUNISH_BALANCE '||
                        GTBPRODUCTS(NUIDX).PUNISH_BALANCE, CNUTRACE_LEVEL );
                
                
                GC_BODEBTNEGOCHARGES.GETPUNISHCHARGES(NUPRODUCTID, TBPUNISHCHARGES);
                
                IF(NVL(GTBPRODUCTS(NUIDX).REACTIV_VALUE, 0) < NVL(GTBPRODUCTS(NUIDX).PUNISH_BALANCE, 0)) THEN
                    
                    GC_BODEBTNEGOCHARGES.DISTREACTCHARGES(NUPRODUCTID, GTBPRODUCTS(NUIDX).REACTIV_VALUE, TBPUNISHCHARGES, TBCHARGESREACTIVE);
                ELSE
                    
                    TBCHARGESREACTIVE := TBPUNISHCHARGES;
                END IF;
                GC_BODEBTNEGOCHARGES.SETCHARGESREACTIVE(NUPRODUCTID, TBCHARGESREACTIVE, NUBALANCEREACT);
            END IF;

            NUIDX := GTBPRODUCTS.NEXT(NUIDX);
        END LOOP;
        

        
        GC_BODEBTNEGOCHARGES.LOADCHARGESFORDEBTNEG(GTBPRODUCTS,OCUCHARGES);
        
        UT_TRACE.TRACE( 'FIN GC_BODebtNegotiation.GetCharges', CNUTRACE_LEVEL );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCHARGES;

    


























    PROCEDURE SELECTPRODUCT
    (
        INUROWNUMBER    IN  NUMBER,
        IBOFLAG         IN  BOOLEAN
    )
    IS
    
        NUPOSPRODBASE       NUMBER;
    
    BEGIN
        UT_TRACE.TRACE( 'INICIO GC_BODebtNegotiation.SelectProduct', CNUTRACE_LEVEL );
        UT_TRACE.TRACE( 'Producto ['||GTBPRODUCTS(INUROWNUMBER).PRODUCT_ID||']', CNUTRACE_LEVEL + 1 );
        
        
        GNUPRODUCTID := GTBPRODUCTS(INUROWNUMBER).PRODUCT_ID;

        IF(IBOFLAG)
        THEN
            
            IF(GTBPRODUCTS(INUROWNUMBER).BASE_PRODUCT_ID != PKCONSTANTE.NULLNUM)
            THEN
                SEARCHPOSITION(GTBPRODUCTS(INUROWNUMBER).BASE_PRODUCT_ID,NUPOSPRODBASE);

                IF(NUPOSPRODBASE IS NOT NULL AND GTBPRODUCTS(NUPOSPRODBASE).SELECTED = GE_BOCONSTANTS.CSBNO)
                THEN
                    GE_BOERRORS.SETERRORCODEARGUMENT(901509, GTBPRODUCTS(INUROWNUMBER).PRODUCT_ID);
                END IF;
            END IF;
            
            
            VALPRODFORNEGOTIATION(GTBPRODUCTS(INUROWNUMBER).PRODUCT_ID);
            VALIDATEPRODBAL(INUROWNUMBER);

            GTBPRODUCTS(INUROWNUMBER).SELECTED := GE_BOCONSTANTS.CSBYES;
            UT_TRACE.TRACE( 'Selecci�n ['|| GE_BOCONSTANTS.CSBYES||']', CNUTRACE_LEVEL +1);
        ELSE
            GTBPRODUCTS(INUROWNUMBER).SELECTED := GE_BOCONSTANTS.CSBNO;
            UT_TRACE.TRACE( 'Selecci�n ['|| GE_BOCONSTANTS.CSBNO||']', CNUTRACE_LEVEL +1);
        END IF;

        UT_TRACE.TRACE( 'FIN GC_BODebtNegotiation.SelectProduct', CNUTRACE_LEVEL );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SELECTPRODUCT;

    
















    PROCEDURE SELECTEXOPRODUCT
    (
        INUROWNUMBER    IN  NUMBER,
        IBOFLAG         IN  BOOLEAN
    )
    IS
    BEGIN
        UT_TRACE.TRACE( 'INICIO GC_BODebtNegotiation.SelectExoProduct', CNUTRACE_LEVEL );
        UT_TRACE.TRACE( 'Producto ['||GTBPRODUCTS(INUROWNUMBER).PRODUCT_ID||']', CNUTRACE_LEVEL + 1 );

        IF(IBOFLAG)
        THEN
            GTBPRODUCTS(INUROWNUMBER).EXO_RE_INSTALL := GE_BOCONSTANTS.CSBYES;
            UT_TRACE.TRACE( 'Selecci�n ['|| GE_BOCONSTANTS.CSBYES||']', CNUTRACE_LEVEL +1);
        ELSE
            GTBPRODUCTS(INUROWNUMBER).EXO_RE_INSTALL := GE_BOCONSTANTS.CSBNO;
            UT_TRACE.TRACE( 'Selecci�n ['|| GE_BOCONSTANTS.CSBNO||']', CNUTRACE_LEVEL +1);
        END IF;

        UT_TRACE.TRACE( 'FIN GC_BODebtNegotiation.SelectExoProduct', CNUTRACE_LEVEL );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SELECTEXOPRODUCT;


    
























    PROCEDURE UPDATEVALUETOPAY
    (
        INUROWNUMBER    IN  NUMBER,
        INUVALUETOPAY   IN  NUMBER
    )
    IS
        NUVALUEREACTIVE     NUMBER;
        NUPRODUCTID         SERVSUSC.SESUNUSE%TYPE;
        NUSUBSCRIPTIONID    SUSCRIPC.SUSCCODI%TYPE;
    BEGIN
        UT_TRACE.TRACE( 'INICIO GC_BODebtNegotiation.UpdateValueToPay['||INUROWNUMBER||']['||INUVALUETOPAY||']', CNUTRACE_LEVEL );
        
        NUPRODUCTID         := GTBPRODUCTS(INUROWNUMBER).PRODUCT_ID;
        NUSUBSCRIPTIONID    := PKTBLSERVSUSC.FNUGETSESUSUSC(NUPRODUCTID);

        
        FA_BOPOLITICAREDONDEO.VALPOLITICAAJUSTESUSC(NUSUBSCRIPTIONID, INUVALUETOPAY);

        
        NUVALUEREACTIVE := GC_BODEBTNEGOCHARGES.FNUVALUEREACTIVE(NUSUBSCRIPTIONID, NUPRODUCTID);

        
        IF  (INUVALUETOPAY < NUVALUEREACTIVE) THEN
            GE_BOERRORS.SETERRORCODEARGUMENT( CNUVAL_MIN_TO_PAY, '$'||NUVALUEREACTIVE );
        ELSE
            GTBPRODUCTS(INUROWNUMBER).VALUE_TO_PAY := INUVALUETOPAY;
        END IF;

        UT_TRACE.TRACE( 'FIN GC_BODebtNegotiation.UpdateValueToPay', CNUTRACE_LEVEL );
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE( 'EX.Error: GC_BODebtNegotiation.UpdateValueToPay', CNUTRACE_LEVEL );
            RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE( 'Error: GC_BODebtNegotiation.UpdateValueToPay', CNUTRACE_LEVEL );
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDATEVALUETOPAY;

    






















    PROCEDURE SETCHARGEFINANCING
    (
        INUSUSCRIPTION      IN      SUSCRIPC.SUSCCODI%TYPE,
        INUSERVICENUMBER    IN      SERVSUSC.SESUNUSE%TYPE
    )
    IS

        NUCONTRACT  SUSCRIPC.SUSCCODI%TYPE;

    BEGIN
        UT_TRACE.TRACE('INICIO GC_BODebtNegotiation.SetChargeFinancing',CNUTRACE_LEVEL);

        
        GC_BODEBTNEGOCHARGES.SETCHARGEFINANCING
        (
            INUSUSCRIPTION,
            INUSERVICENUMBER
        );

        
        CC_BOFINANCING.INITFINANCINGDEBT(INUSUSCRIPTION);

        UT_TRACE.TRACE('FIN GC_BODebtNegotiation.SetChargeFinancing',CNUTRACE_LEVEL);
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETCHARGEFINANCING;


    















    PROCEDURE VALVALUEMINTOPAY
    IS
        NUVALUETOPAY        NUMBER := 0;
        NUVALUEREACTIVE     NUMBER := 0;
        NUSUBSCRIPTIONID    SUSCRIPC.SUSCCODI%TYPE;
    BEGIN
        UT_TRACE.TRACE('INICIO GC_BODebtNegotiation.ValValueMinToPay',CNUTRACE_LEVEL);

        IF  (GTBPRODUCTS.COUNT = 0) THEN
        	UT_TRACE.TRACE('FIN GC_BODebtNegotiation.ValValueMinToPay NOK',CNUTRACE_LEVEL);
            RETURN;
        END IF;

        
        SELECT  SUM(VALUE_TO_PAY)
        INTO    NUVALUETOPAY
        FROM    /*+ GC_BODebtNegotiation.ValValueMinToPay*/
                TABLE(CAST(GTBPRODUCTS AS CC_TYTBPRODUCT));

        
        NUSUBSCRIPTIONID    := PKTBLSERVSUSC.FNUGETSESUSUSC(GTBPRODUCTS(GTBPRODUCTS.FIRST).PRODUCT_ID);
        
        
        NUVALUEREACTIVE := GC_BODEBTNEGOCHARGES.FNUVALUEREACTIVE(NUSUBSCRIPTIONID);

        
        IF  (NUVALUETOPAY < NUVALUEREACTIVE) THEN
            GE_BOERRORS.SETERRORCODEARGUMENT( CNUVAL_MIN_TO_PAY, '$'||NUVALUEREACTIVE);
        END IF;

        UT_TRACE.TRACE('FIN GC_BODebtNegotiation.ValValueMinToPay OK',CNUTRACE_LEVEL);
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALVALUEMINTOPAY;

    















    PROCEDURE VALIDATESUSCRIPTION
    (
        INUSUBSCRIPTION      IN      SUSCRIPC.SUSCCODI%TYPE
    )
    IS
         
        NUPACKAGETYPE      PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%TYPE;
    BEGIN
        UT_TRACE.TRACE('INICIO GC_BODebtNegotiation.ValidateSuscription',CNUTRACE_LEVEL);

        
        PKSUBSCRIBERMGR.VALBASICDATA( INUSUBSCRIPTION );

        
        NUPACKAGETYPE := PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME(CSBDEBTNEGOTIATION);

        
        CC_BORESTRICTION.VALEXISTRESTBYPACKTYPE( INUSUBSCRIPTION, NULL, NULL, NUPACKAGETYPE);

        UT_TRACE.TRACE('FIN GC_BODebtNegotiation.ValidateSuscription',CNUTRACE_LEVEL);
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDATESUSCRIPTION;

    

















    FUNCTION FBOPRODDEBTHASCHANGED
    (
        INUPRODUCTID                IN          SUSCRIPC.SUSCCODI%TYPE,
        IDTDATE                     IN          MO_PACKAGES.REQUEST_DATE%TYPE
    )
    RETURN BOOLEAN
    IS
    BEGIN
    
        UT_TRACE.TRACE('Inicio [GC_BODebtNegotiation.fboProdDebtHasChanged]', 1);
        
        
        IF( PKBCCARGOS.FBOCHARGESAFTERDATE( INUPRODUCTID, IDTDATE ) ) THEN
        
            UT_TRACE.TRACE('Si hubo movimiento de cartera para el producto: '||INUPRODUCTID||' despues de la fecha: '||IDTDATE, 2);
            RETURN TRUE;
        
        END IF;

        UT_TRACE.TRACE('No hubo movimiento de cartera para el producto: '||INUPRODUCTID||' despues de la fecha: '||IDTDATE, 2);
        UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.fboProdDebtHasChanged]', 1);

        RETURN FALSE;
    
    EXCEPTION
    
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.fboProdDebtHasChanged]', 1);
    	    RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.fboProdDebtHasChanged]', 1);
            RAISE EX.CONTROLLED_ERROR;
    
    END FBOPRODDEBTHASCHANGED;
    
    
















    FUNCTION FBODEBTHASCHANGED
    (
        INUDEBTNEGOREQUEST          IN          GC_DEBT_NEGOTIATION.PACKAGE_ID%TYPE
    )
    RETURN BOOLEAN
    IS
    
        
        RCDEBTNEGOTIATION                       GC_DEBT_NEGOTIATION%ROWTYPE;
        
        
        DTNEGOREGISTERDATE                      MO_PACKAGES.REQUEST_DATE%TYPE;
        
        
        TBDEBTNEGOPRODUCTS                      GC_BCDEBTNEGOPRODUCT.TYTBDEBTNEGOPRODUCTS;
        
        
        NUPRODIDX                           BINARY_INTEGER;
    
    BEGIN
    
        UT_TRACE.TRACE('Inicio [GC_BODebtNegotiation.fboDebtHasChanged]', 2);
        
        
        DTNEGOREGISTERDATE := DAMO_PACKAGES.FDTGETREQUEST_DATE( INUDEBTNEGOREQUEST );
        
        
        GC_BCDEBTNEGOTIATION.GETDEBTNEGOTIATIONDATA
        (
            INUDEBTNEGOREQUEST,
            RCDEBTNEGOTIATION
        );

        
        GC_BCDEBTNEGOPRODUCT.GETDEBTNEGOPRODUCTS
        (
            RCDEBTNEGOTIATION.DEBT_NEGOTIATION_ID,
            TBDEBTNEGOPRODUCTS
        );
        
        
        NUPRODIDX := TBDEBTNEGOPRODUCTS.FIRST;

        LOOP
        
            EXIT WHEN NUPRODIDX IS NULL;

            

            IF( FBOPRODDEBTHASCHANGED( TBDEBTNEGOPRODUCTS(NUPRODIDX).SESUNUSE, DTNEGOREGISTERDATE ) ) THEN
            
                
                RETURN TRUE;
            
            END IF;

            
            NUPRODIDX := TBDEBTNEGOPRODUCTS.NEXT( NUPRODIDX );
        
        END LOOP;
        
        UT_TRACE.TRACE('No hubo cambios en cartera para los productos negociados con la solicitud: '||INUDEBTNEGOREQUEST||
        ' despues de la fecha: '||DTNEGOREGISTERDATE, 3);
        UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.fboDebtHasChanged]', 2);
        
        RETURN FALSE;
    
    EXCEPTION
    
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.fboDebtHasChanged]', 2);
    	    RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.fboDebtHasChanged]', 2);
            RAISE EX.CONTROLLED_ERROR;
    
    END FBODEBTHASCHANGED;
    
    














    PROCEDURE NEGOTIATIONVALFORPRINT
    (
        INUNEGOTIATIONID            IN          GC_DEBT_NEGOTIATION.DEBT_NEGOTIATION_ID%TYPE
    )
    IS
        
        CNUPRINTING_ERROR_118105    CONSTANT    GE_MESSAGE.MESSAGE_ID%TYPE := 118105;

        
        RCNEGOTIATIONINFO                       DAGC_DEBT_NEGOTIATION.STYGC_DEBT_NEGOTIATION;
        
        
        RCFINANCINGINFO                         DACC_FINANCING_REQUEST.STYCC_FINANCING_REQUEST;
        
    BEGIN
    
        UT_TRACE.TRACE('Inicio [GC_BODebtNegotiation.NegotiationValForPrint]', 1);
        
        
        RCNEGOTIATIONINFO := DAGC_DEBT_NEGOTIATION.FRCGETRECORD( INUNEGOTIATIONID );
        
        


        IF( RCNEGOTIATIONINFO.REQUIRE_PAYMENT = CC_BOCONSTANTS.CSBNO OR
            ( RCNEGOTIATIONINFO.REQUIRE_SIGNING = CC_BOCONSTANTS.CSBSI
              AND RCNEGOTIATIONINFO.SIGNED = CC_BOCONSTANTS.CSBNO ) ) THEN
        
            
            GE_BOERRORS.SETERRORCODE( CNUPRINTING_ERROR_118105 );
        
        END IF;
        
        
        IF( DACC_FINANCING_REQUEST.FBLEXIST( RCNEGOTIATIONINFO.PACKAGE_ID ) ) THEN
        
            
            RCFINANCINGINFO := DACC_FINANCING_REQUEST.FRCGETRECORD( RCNEGOTIATIONINFO.PACKAGE_ID );
            
            
            CC_BOWAITFORPAYMENT.FINANCINGVALSFORPRINT( RCFINANCINGINFO.FINANCING_ID );
        
        END IF;
        
        UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.NegotiationValForPrint]', 1);
    
    EXCEPTION
    
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.NegotiationValForPrint]', 1);
    	    RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.NegotiationValForPrint]', 1);
            RAISE EX.CONTROLLED_ERROR;
    
    END NEGOTIATIONVALFORPRINT;
    
    
    














    FUNCTION GETBASEVALUE
    (
        RCCHARGE     IN    PKBCCHARGES.TYRCNOTECHARGE,
        RCSERVSUSC   IN    SERVSUSC%ROWTYPE
    )
    RETURN NUMBER
    IS
        NUBASE       NUMBER;
        NUFACTCODI   FACTURA.FACTCODI%TYPE;
        NUPEFACODI   PERIFACT.PEFACODI%TYPE;
    BEGIN
        UT_TRACE.TRACE('Inicio [GC_BODebtNegotiation.GetBaseValue]', 1);

        
        NUFACTCODI := PKTBLCUENCOBR.FNUGETCUCOFACT(RCCHARGE.CARGCUCO);
        UT_TRACE.TRACE('Factura: '|| NUFACTCODI,10);

        
        NUPEFACODI := PKTBLFACTURA.FNUGETFACTPEFA(NUFACTCODI);
        UT_TRACE.TRACE('Periodo de facturaci�n: '|| NUPEFACODI, 10);

        
        PKBOLIQUIDATETAX.GETTAXBASEVALUE
        (
            RCSERVSUSC,
            NUPEFACODI,
            RCCHARGE.CARGCONC,  
            RCCHARGE.CARGVACO,
            NUBASE
        );
        
        UT_TRACE.TRACE('Fin [GC_BODebtNegotiation.GetBaseValue]', 1);
        
        RETURN NUBASE;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.GetBaseValue]', 1);
    	    RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.GetBaseValue]', 1);
            RAISE EX.CONTROLLED_ERROR;
    END GETBASEVALUE;

    















    PROCEDURE SETREACTVBALPRODUCT
    (
        INUROWNUMBER    IN  NUMBER,
        INUVALUE        IN  NUMBER
    )
    IS
    BEGIN
        UT_TRACE.TRACE( 'INICIO GC_BODebtNegotiation.SetReactvBalProduct', CNUTRACE_LEVEL );
        UT_TRACE.TRACE( 'Producto ['||GTBPRODUCTS(INUROWNUMBER).PRODUCT_ID||']', CNUTRACE_LEVEL + 1 );
        UT_TRACE.TRACE( 'inuValue ['||INUVALUE||']', CNUTRACE_LEVEL +1);
        
        GTBPRODUCTS(INUROWNUMBER).REACTIV_VALUE := INUVALUE;

        UT_TRACE.TRACE( 'FIN GC_BODebtNegotiation.SetReactvBalProduct', CNUTRACE_LEVEL );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETREACTVBALPRODUCT;
    
    



















    PROCEDURE VALFGCAISINEXECUTION
    (
        INUPACKAGE_ID   IN  MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS
    
        
        CNUERRFGCAINPROGRESS    CONSTANT    GE_MESSAGE.MESSAGE_ID%TYPE := 905316;
        
        NUCONTRACTID    SUSCRIPC.SUSCCODI%TYPE;
        NUCYCLE         CICLO.CICLCODI%TYPE;
        RCPERIFACT      PERIFACT%ROWTYPE;
        
        
        CSBEJECUCION	CONSTANT VARCHAR2(1) := 'E';
        CSBFGCAPROGRAM  CONSTANT VARCHAR2(10) := 'FGCA';
        
        
        CURSOR CUPROCESSCONTROL
        (
            INUBILLINGPERIOD    IN PROCEJEC.PREJCOPE%TYPE
        )
        IS
            SELECT *
              FROM ESPRSEPE
             WHERE EPSPPROG LIKE CSBFGCAPROGRAM || '%'
               AND EPSPPEFA = INUBILLINGPERIOD
               AND EPSPESTA = CSBEJECUCION;
    
    BEGIN
    
        UT_TRACE.TRACE('Inicia GC_BODebtNegotiation.ValFgcaIsInExecution', 1);
    
        
        NUCONTRACTID := MO_BOPACKAGES.FNUGETCONTRACTBYPACK(INUPACKAGE_ID);
        
        NUCYCLE := PKSUSCRIPC.FNUCICLFACT(NUCONTRACTID);
        
        RCPERIFACT := PKBILLINGPERIODMGR.FRCGETACCCURRENTPERIOD(NUCYCLE);
        
        UT_TRACE.TRACE('Periodo de facturaci�n: '||RCPERIFACT.PEFACODI, 1);
        
        FOR RCESPRSEPE IN CUPROCESSCONTROL ( RCPERIFACT.PEFACODI ) LOOP
        
            IF ( PKSESSIONMGR.FBLEXISTSESSION( RCESPRSEPE.EPSPPRID ) ) THEN
            
                UT_TRACE.TRACE('FGCA est� en ejecuci�n ERROR', 1);
                
                GE_BOERRORS.SETERRORCODE( CNUERRFGCAINPROGRESS );
            
            END IF;
        
        END LOOP;
        
        UT_TRACE.TRACE('FGCA no esta en ejecuci�n', 1);
    
        PKERRORS.POP;
        
        UT_TRACE.TRACE('Finaliza GC_BODebtNegotiation.ValFgcaIsInExecution', 1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BODebtNegotiation.ValFgcaIsInExecution]', 1);
    	    RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('OTHERS [GC_BODebtNegotiation.ValFgcaIsInExecution]', 1);
            RAISE EX.CONTROLLED_ERROR;
    END VALFGCAISINEXECUTION;
    
END GC_BODEBTNEGOTIATION;