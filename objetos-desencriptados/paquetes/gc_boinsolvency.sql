PACKAGE BODY GC_BOInsolvency AS
    


















































































































   
   CSBVERSION   CONSTANT VARCHAR2(250)  := 'SAO406388';
   CNUUPDATE_DB	CONSTANT NUMBER         := 1;

   CSBREORGACHAR              CONSTANT VARCHAR2(1) := 'R'; 

   CSBREORGCOSTCENTER         CONSTANT GE_ATTRIBUTES.NAME_ATTRIBUTE%TYPE := 'REORGANIZATION_COST_CENTER';

   CSBLIQCOSTCENTER           CONSTANT GE_ATTRIBUTES.NAME_ATTRIBUTE%TYPE := 'LIQUIDATION_COST_CENTER';

   
   CNUACTIVITYINSOLVENCY  CONSTANT NUMBER := 901233; 
   
   CNUSUSCRIPTIONDEBT         CONSTANT NUMBER := 901181; 
   CNUINSOLVENTCONTRACT       CONSTANT NUMBER := 901172; 
   CNUINSOLVENCYPRODUCT       CONSTANT NUMBER := 901272; 
   CNUWFPACKAGETYPEINSOLVENCY CONSTANT NUMBER := 302;    
   CNUDEFAULT_COMMERCIAL_PLAN CONSTANT NUMBER := 176;    
   CNUEXISTINSOLV             CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 902660; 

   CNUCOMMPLANNUMPARERROR     CONSTANT NUMBER := 901771; 
   CNUCOMMPLANPARERROR        CONSTANT NUMBER := 901772; 


   TYPE TYTBACCADJUS IS TABLE OF CUENCOBR.CUCOCODI%TYPE INDEX BY VARCHAR2(20);
   TBACCADJUS     TYTBACCADJUS;
    
    
    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    PROCEDURE GENMOVIDIFADJUST
    (
        INUDEFERRED     IN  DIFERIDO.DIFECODI%TYPE,
        IDTINSOLVENCY   IN  MO_DATA_INSOLVENCY.BEGIN_DATE%TYPE
    );

   

















































    PROCEDURE GENCHARGESADJUST
    (
        INUINSOLVENCYID     IN  MO_DATA_INSOLVENCY.DATA_INSOLVENCY_ID%TYPE,
        INUSUBSCRIPTIONID   IN  SERVSUSC.SESUSUSC%TYPE,
        IDTINSOLVENCY       IN  MO_DATA_INSOLVENCY.BEGIN_DATE%TYPE
    )
    IS
        
        
        
        TYPE TYTBBILLCHARGES    IS TABLE OF PKBCCARGOS.TYTBRCCARGOS
                                INDEX BY VARCHAR2(20);
        TYPE TYTBBILLNOTES      IS TABLE OF NOTAS.NOTANUME%TYPE
                                INDEX BY VARCHAR2(20);
        TYPE TYTBDEFERREDS      IS TABLE OF VARCHAR2(1)
                                INDEX BY VARCHAR2(20);
        
        
        
        TBBILLCHARGES   TYTBBILLCHARGES;
        TBBILLNOTES     TYTBBILLNOTES;
        
        
        
        PROCEDURE GETCHARGESBYBILL
        IS
            NUIDX	        BINARY_INTEGER;
            NUIDXCHARGE     BINARY_INTEGER;
            SBIDXBILL	    VARCHAR2(20);
            RCCHARGE        CARGOS%ROWTYPE;
            RCPROGRAM       PROCESOS%ROWTYPE;
            NUPRODTYPE      SERVSUSC.SESUSERV%TYPE;
            NUCHARGECAUSE   CAUSCARG.CACACODI%TYPE;
            NUUSER          CARGOS.CARGUSUA%TYPE;
            NUPROGRAM       CARGOS.CARGPROG%TYPE;
            TBCHARGES       GC_BCINSOLVENCY.TYTBBILLCHARGES;
        BEGIN

            UT_TRACE.TRACE( 'GC_BOInsolvency.GenChargesAdjust.GetChargesByBill', 16 );

            GC_BCINSOLVENCY.GETCHARGESTOADJUST(INUSUBSCRIPTIONID,
                                             IDTINSOLVENCY,
                                             TBCHARGES );

            RCPROGRAM := GE_BCPROCESOS.FRCPROGRAMA( GC_BOCONSTANTS.CSB_INSOLVENCYPROGRAM );
            NUPROGRAM := RCPROGRAM.PROCCONS;
            NUUSER := SA_BOSYSTEM.GETSYSTEMUSERID;

            NUIDX  := TBCHARGES.FIRST;

            WHILE ( NUIDX IS NOT NULL ) LOOP

                
                SBIDXBILL := TO_CHAR( TBCHARGES(NUIDX).FACTCODI );

                
                RCCHARGE.CARGCUCO := TBCHARGES(NUIDX).CARGCUCO;
                RCCHARGE.CARGNUSE := TBCHARGES(NUIDX).CARGNUSE;
                RCCHARGE.CARGCONC := TBCHARGES(NUIDX).CARGCONC;
                RCCHARGE.CARGSIGN := TBCHARGES(NUIDX).CARGSIGN;
                RCCHARGE.CARGVALO := TBCHARGES(NUIDX).CARGVALO;
                RCCHARGE.CARGDOSO := TBCHARGES(NUIDX).CARGDOSO;
                RCCHARGE.CARGUNID := TBCHARGES(NUIDX).CARGUNID;
                RCCHARGE.CARGCOLL := TBCHARGES(NUIDX).CARGCOLL;
                RCCHARGE.CARGPECO := TBCHARGES(NUIDX).CARGPECO;
                RCCHARGE.CARGTICO := TBCHARGES(NUIDX).CARGTICO;
                RCCHARGE.CARGVABL := TBCHARGES(NUIDX).CARGVABL;
                RCCHARGE.CARGTACO := TBCHARGES(NUIDX).CARGTACO;
                
                RCCHARGE.CARGPEFA := TBCHARGES(NUIDX).FACTPEFA;

                
                NUPRODTYPE := PKTBLSERVSUSC.FNUGETSERVICE( RCCHARGE.CARGNUSE );

                
                NUCHARGECAUSE := FA_BOCHARGECAUSES.FNUADJINSOLVENCYCHCAUSE( NUPRODTYPE );

                RCCHARGE.CARGCACA := NUCHARGECAUSE;
                RCCHARGE.CARGFECR := SYSDATE;
                RCCHARGE.CARGUSUA := NUUSER;
                RCCHARGE.CARGPROG := NUPROGRAM;
                RCCHARGE.CARGTIPR := PKBILLCONST.POST_FACTURACION;
                
                IF ( TBBILLCHARGES.EXISTS(SBIDXBILL) ) THEN
                    NUIDXCHARGE := TBBILLCHARGES( SBIDXBILL ).COUNT + 1;
                ELSE
                    NUIDXCHARGE := 1;
                END IF;
                
                TBBILLCHARGES( SBIDXBILL )( NUIDXCHARGE ) := RCCHARGE;

                NUIDX  := TBCHARGES.NEXT( NUIDX );

            END LOOP;

            UT_TRACE.TRACE( 'Fin GC_BOInsolvency.GenChargesAdjust.GetChargesByBill', 16 );

        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END GETCHARGESBYBILL;
        
        PROCEDURE GENNOTES
        IS
            NUSIGN          NUMBER;
            NUIDX	        BINARY_INTEGER;
            SBIDXBILL	    VARCHAR2(20);
            SBDEFERRED      VARCHAR2(20);
            RCCHARGE        CARGOS%ROWTYPE;
            NUDOCUMENTTYPE  NOTAS.NOTACONS%TYPE;
            NUNOTE          NOTAS.NOTANUME%TYPE;
            SBSUPPDOC       NOTAS.NOTADOSO%TYPE;
            SBCARGDOSO      CARGOS.CARGDOSO%TYPE;
            SBNOTESSUPPDOC  NOTAS.NOTADOSO%TYPE;
            NUNOTEVALUE     CARGOS.CARGVALO%TYPE;
            SBSIGNO         CARGOS.CARGSIGN%TYPE;
            TBDEFERREDS     TYTBDEFERREDS;
        BEGIN

            UT_TRACE.TRACE( 'GC_BOInsolvency.GenChargesAdjust.GenNotes', 16 );

            
            SBNOTESSUPPDOC := GC_BOCONSTANTS.FSBGETSUPPORTDOCINSOLV( INUINSOLVENCYID );

            SBIDXBILL := TBBILLCHARGES.FIRST;

            
            WHILE ( SBIDXBILL IS NOT NULL ) LOOP

                
                NUNOTEVALUE := 0;

                NUIDX := TBBILLCHARGES(SBIDXBILL).FIRST;

                
                WHILE ( NUIDX IS NOT NULL ) LOOP

                    NUSIGN := PKBILLCONST.CNUSUMA_CARGO;
                    IF ( TBBILLCHARGES(SBIDXBILL)(NUIDX).CARGSIGN =
                         PKBILLCONST.CREDITO )
                    THEN
                        NUSIGN := PKBILLCONST.CNURESTA_CARGO;
                    END IF;

                    
                    NUNOTEVALUE := NUNOTEVALUE +
                                   TBBILLCHARGES(SBIDXBILL)(NUIDX).CARGVALO * NUSIGN;

                    NUIDX := TBBILLCHARGES(SBIDXBILL).NEXT( NUIDX );

                END LOOP;

                
                IF ( NUNOTEVALUE > 0 ) THEN

                    SBSUPPDOC := PKBILLCONST.CSBTOKEN_NOTA_CREDITO;
                    NUDOCUMENTTYPE := GE_BOCONSTANTS.FNUGETDOCTYPECRENOTE;

                ELSE

                    SBSUPPDOC := PKBILLCONST.CSBTOKEN_NOTA_DEBITO;
                    NUDOCUMENTTYPE := GE_BOCONSTANTS.FNUGETDOCTYPEDEBNOTE;

                END IF;

                NUIDX := TBBILLCHARGES( SBIDXBILL ).FIRST;

                
                PKBILLINGNOTEMGR.CREATEBILLINGNOTE(
                                        TBBILLCHARGES(SBIDXBILL)(NUIDX).CARGNUSE,
                                        TBBILLCHARGES(SBIDXBILL)(NUIDX).CARGCUCO,
                                        NUDOCUMENTTYPE,
                                        SYSDATE,
                                        PKBILLINGNOTEMGR.CSBINSA,
                                        SBSUPPDOC,
                                        NUNOTE );

                
                PKBILLINGNOTEMGR.GETDOCUMSOP(SBSUPPDOC);

                
                TBBILLNOTES( SBIDXBILL ) := NUNOTE;

                
                WHILE ( NUIDX IS NOT NULL ) LOOP

                    RCCHARGE := TBBILLCHARGES( SBIDXBILL )( NUIDX );

                    
                    IF RCCHARGE.CARGSIGN = PKBILLCONST.DEBITO THEN
                        SBSIGNO := PKBILLCONST.CREDITO;
                    ELSE
                        SBSIGNO := PKBILLCONST.DEBITO;
                    END IF;

                    
                    FA_BOBILLINGNOTES.DETAILREGISTER
                                         (
                                            NUNOTE,                        
                                            RCCHARGE.CARGNUSE,             
                                            INUSUBSCRIPTIONID,             
                                            RCCHARGE.CARGCUCO,             
                                            RCCHARGE.CARGCONC,             
                                            RCCHARGE.CARGCACA,             
                                            ABS( RCCHARGE.CARGVALO ),      
                                            NULL,                          
                                    	    SBSUPPDOC,                     
                                            SBSIGNO,                       
                                            PKCONSTANTE.NO,                
                                            SBNOTESSUPPDOC,                
                        	                PKCONSTANTE.NO                 
                                        );
                                        
                    
                    SBCARGDOSO := TBBILLCHARGES(SBIDXBILL)(NUIDX).CARGDOSO;

                    
                    IF NOT TBACCADJUS.EXISTS(RCCHARGE.CARGCUCO) THEN

                        
                        TBACCADJUS ( TO_CHAR ( RCCHARGE.CARGCUCO ) ) := RCCHARGE.CARGNUSE;

                    END IF;

                    
                    IF ( SUBSTR( SBCARGDOSO, 1, 3 )
                    IN ( PKBILLCONST.CSBTOKEN_CUOTA_EXTRA,
                         PKBILLCONST.CSBTOKEN_DIFERIDO,
                         PKBILLCONST.CSBTOKEN_TRANS_DIFCOR,
                         PKBILLCONST.CSBTOKEN_INTERES_DIFERIDO ) )
                    THEN

                        
                        SBDEFERRED := SUBSTR( SBCARGDOSO, INSTR( SBCARGDOSO, '-' ) + 1 );

                        
                        IF ( NOT TBDEFERREDS.EXISTS( SBDEFERRED ) ) THEN

                            
                            GENMOVIDIFADJUST( TO_NUMBER(SBDEFERRED), IDTINSOLVENCY );

                            
                            TBDEFERREDS( SBDEFERRED ) := NULL;

                        END IF;

                    END IF;

                    NUIDX := TBBILLCHARGES( SBIDXBILL ).NEXT( NUIDX );

                END LOOP;

                SBIDXBILL := TBBILLCHARGES.NEXT( SBIDXBILL );

            END LOOP;

            UT_TRACE.TRACE( 'Fin GC_BOInsolvency.GenChargesAdjust.GenNotes', 16 );

        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END GENNOTES;
        
        PROCEDURE GENLATECHARGES
        IS
            NUIDX	        BINARY_INTEGER;
            SBIDXBILL	    VARCHAR2(20);
            SBIDXPRODCONC   VARCHAR2(20);
            RCBILLPERIOD    PERIFACT%ROWTYPE;
            RCCONCEPT       CONCEPTO%ROWTYPE;
            NUCONCEPT       CARGOS.CARGCONC%TYPE;
            NUPRODUCT       CARGOS.CARGNUSE%TYPE;
            NUBILLPERIOD    CARGOS.CARGPEFA%TYPE;
            NUACCOUNT       CARGOS.CARGCUCO%TYPE;
            TBPRODCONCEPTS  TYTBDEFERREDS;
        BEGIN

            UT_TRACE.TRACE( 'GC_BOInsolvency.GenChargesAdjust.GenLateCharges', 16 );

            SBIDXBILL := TBBILLCHARGES.FIRST;

            
            WHILE ( SBIDXBILL IS NOT NULL ) LOOP

                NUIDX := TBBILLCHARGES(SBIDXBILL).FIRST;

                
                WHILE ( NUIDX IS NOT NULL ) LOOP

                    
                    NUCONCEPT := TBBILLCHARGES(SBIDXBILL)(NUIDX).CARGCONC;

                    
                    PKINSTANCEDATAMGR.GETRECORDCONCEPT( NUCONCEPT, RCCONCEPT );

                    
                    IF ( RCCONCEPT.CONCTICL = PKBILLCONST.FNUOBTTIPORECAMORA ) THEN

                        
                        NUBILLPERIOD := TBBILLCHARGES(SBIDXBILL)(NUIDX).CARGPEFA;

                        
                        PKINSTANCEDATAMGR.GETRECORDBILLINGPERIOD( NUBILLPERIOD, RCBILLPERIOD );

                        
                        IF ( IDTINSOLVENCY BETWEEN
                             RCBILLPERIOD.PEFAFIMO AND RCBILLPERIOD.PEFAFFMO )
                        THEN

                            
                            NUPRODUCT := TBBILLCHARGES(SBIDXBILL)(NUIDX).CARGNUSE;

                            
                            SBIDXPRODCONC := NUPRODUCT || '|' || NUCONCEPT;

                            
                            IF ( NOT TBPRODCONCEPTS.EXISTS( SBIDXPRODCONC ) ) THEN

                                
                                NUACCOUNT := TBBILLCHARGES(SBIDXBILL)(NUIDX).CARGCUCO;

                                
                                BI_BOLATESERVICES.CALCULATELATEVALUE(
                                                            INUSUBSCRIPTIONID,
                                                            NUPRODUCT,
                                                            NUACCOUNT,
                                                            NUCONCEPT,
                                                            TBBILLNOTES( SBIDXBILL ),
                                                            INUINSOLVENCYID,
                                                            IDTINSOLVENCY,
                                                            NUBILLPERIOD );

                                
                                TBPRODCONCEPTS( SBIDXPRODCONC ) := NULL;

                            END IF;

                        END IF;

                    END IF;

                    NUIDX := TBBILLCHARGES( SBIDXBILL ).NEXT( NUIDX );

                END LOOP;

                SBIDXBILL := TBBILLCHARGES.NEXT( SBIDXBILL );

            END LOOP;

            UT_TRACE.TRACE( 'Fin GC_BOInsolvency.GenChargesAdjust.GenLateCharges', 16 );

        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END GENLATECHARGES;
        
    BEGIN
    
        UT_TRACE.TRACE( 'Inicia GC_BOInsolvency.GenChargesAdjust para la suscripci�n ['||INUSUBSCRIPTIONID||']', 20 );

        
        GETCHARGESBYBILL;

        
        GENNOTES;

        
        GENLATECHARGES;
        
        UT_TRACE.TRACE('Finaliza GC_BOInsolvency.GenChargesAdjust para la suscripci�n ['||INUSUBSCRIPTIONID||']',20);
      
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GENCHARGESADJUST;
    
   





































    PROCEDURE GENMOVIDIFADJUST
    (
        INUDEFERRED     IN  DIFERIDO.DIFECODI%TYPE,
        IDTINSOLVENCY   IN  MO_DATA_INSOLVENCY.BEGIN_DATE%TYPE
    )
    IS
        
        
        
        OTBMOVIDIF     GC_BCINSOLVENCY.TYTBMOVIDIF;
        NUIDX	       NUMBER;
        RCMOVIDIFE     MOVIDIFE%ROWTYPE;
        RCPROGRAM      PROCESOS%ROWTYPE;
        NUPROGRAM      PROCESOS.PROCCONS%TYPE;
        NUCAUSE        MOVIDIFE.MODICACA%TYPE;
        NUUSER         MOVIDIFE.MODIUSUA%TYPE;
        SBSIGN         VARCHAR2(2);
        NUBALANCE      NUMBER := 0;
        NUACUMMODIVACU NUMBER := 0;
        DTLASTDATE     DATE;
        NUPRODUCT      SERVSUSC.SESUNUSE%TYPE;
        NUPRODTYPE      SERVSUSC.SESUSERV%TYPE;
        
    BEGIN

        UT_TRACE.TRACE( 'GC_BOInsolvency.GenMoviDifAdjust', 20 );
      
        GC_BCINSOLVENCY.GETMOVIDIFTOADJUST( INUDEFERRED,
                                            IDTINSOLVENCY,
                                            OTBMOVIDIF );

        RCPROGRAM := GE_BCPROCESOS.FRCPROGRAMA( GC_BOCONSTANTS.CSB_INSOLVENCYPROGRAM );
        NUPROGRAM := RCPROGRAM.PROCCONS;
        
        
        NUPRODUCT := PKTBLDIFERIDO.FNUGETSERVNUMBER(INUDEFERRED);

        
        NUPRODTYPE := PKTBLSERVSUSC.FNUGETSERVICE(NUPRODUCT);

        NUCAUSE := FA_BOCHARGECAUSES.FNUADJINSOLVENCYCHCAUSE(NUPRODTYPE);

        NUUSER := SA_BOSYSTEM.GETSYSTEMUSERID;

        NUIDX := OTBMOVIDIF.FIRST;
        
        WHILE ( NUIDX IS NOT NULL ) LOOP

            UT_TRACE.TRACE('Inicia el ajuste de los movimientos en la tabla Movidife ['||OTBMOVIDIF(NUIDX).MODIDIFE||']',25);
            

            
            IF OTBMOVIDIF(NUIDX).MODISIGN = PKBILLCONST.DEBITO THEN
                SBSIGN := PKBILLCONST.CREDITO;
            ELSE
                SBSIGN := PKBILLCONST.DEBITO;
            END IF;

            RCMOVIDIFE.MODIDIFE := OTBMOVIDIF(NUIDX).MODIDIFE;
            RCMOVIDIFE.MODISUSC := OTBMOVIDIF(NUIDX).MODISUSC;
            RCMOVIDIFE.MODICUAP := OTBMOVIDIF(NUIDX).MODICUAP;
            RCMOVIDIFE.MODIVACU := OTBMOVIDIF(NUIDX).MODIVACU;
            RCMOVIDIFE.MODINUSE := OTBMOVIDIF(NUIDX).MODINUSE;
            RCMOVIDIFE.MODICODO := OTBMOVIDIF(NUIDX).MODICODO;

            RCMOVIDIFE.MODISIGN := SBSIGN;
            RCMOVIDIFE.MODIFECH := SYSDATE;
            RCMOVIDIFE.MODIFECA := SYSDATE;
            RCMOVIDIFE.MODIDOSO := GC_BOCONSTANTS.FSBGETSUPPORTDOCINSOLV(RCMOVIDIFE.MODIDIFE);
            RCMOVIDIFE.MODICACA := NUCAUSE;
            RCMOVIDIFE.MODIUSUA := NUUSER;
            RCMOVIDIFE.MODITERM := PKGENERALSERVICES.FSBGETTERMINAL;
            RCMOVIDIFE.MODIPROG := NUPROGRAM;
            RCMOVIDIFE.MODIDIIN := 0;
            RCMOVIDIFE.MODIPOIN := 0;
            RCMOVIDIFE.MODIVAIN := 0;

            
            PKTBLMOVIDIFE.INSRECORD(RCMOVIDIFE);

            
            NUACUMMODIVACU :=  NUACUMMODIVACU + OTBMOVIDIF(NUIDX).MODIVACU;
            UT_TRACE.TRACE(' Acumulado movimiento=['||NUACUMMODIVACU||']',4);

            
            DTLASTDATE := OTBMOVIDIF(NUIDX).MAXDATE;
            
            PKTBLDIFERIDO.UPLASTMOVDATE( OTBMOVIDIF(NUIDX).MODIDIFE, DTLASTDATE );

            UT_TRACE.TRACE('Finaliza el ajuste de los movimientos en la tabla Movidife ['||OTBMOVIDIF(NUIDX).MODIDIFE||']',25);

            NUIDX := OTBMOVIDIF.NEXT( NUIDX );

        END LOOP;
        
        
        NUBALANCE := PKTBLDIFERIDO.FNUGETBALANCE( INUDEFERRED , PKCONSTANTE.NOCACHE);
        UT_TRACE.TRACE('Balance=['||NUBALANCE||'] Acumulado=['||NUACUMMODIVACU||']',4);
        PKTBLDIFERIDO.UPBALANCE( INUDEFERRED, NUBALANCE + NUACUMMODIVACU );
      
        UT_TRACE.TRACE( 'Fin GC_BOInsolvency.GenMoviDifAdjust', 20 );
      
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GENMOVIDIFADJUST;
    
    




































    PROCEDURE GENMOVCURRENTDEBT
    (
        ITBBALANCEACCOUNTS  IN  FA_BOACCOUNTSTATUSTODATE.TYTBBALANCEACCOUNTS,
        INUCAUSCARG         IN  CAUSCARG.CACACODI%TYPE,
        INUPRODUCTIDSOURCE  IN  SERVSUSC.SESUNUSE%TYPE,
        INUPRODUCTIDDEST    IN  SERVSUSC.SESUNUSE%TYPE,
        INUCUCOBRODEST      IN  CUENCOBR.CUCOCODI%TYPE,
        IONUNEWPRODNOTE     IN  OUT NOTAS.NOTANUME%TYPE,
        IOTBOLDPRODNOTES    IN  OUT NOCOPY PKTBLNOTAS.TYNOTANUME
    )
    IS
        
        
        
        NUIDX            VARCHAR2(20);
        NUNOTA           NOTAS.NOTANUME%TYPE;    
        RCCARGOS         CARGOS%ROWTYPE;
        RCACCOUNT        CUENCOBR%ROWTYPE;
        SBSUPDOCOLDPROD  NOTAS.NOTADOSO%TYPE;
        NUDOCTYPEOLDPROD NOTAS.NOTACONS%TYPE;
        NUDOCTYPENEWPROD NOTAS.NOTACONS%TYPE;
        SBSIGNOLDPROD    CARGOS.CARGSIGN%TYPE;
        SBSIGNNEWPROD    CARGOS.CARGSIGN%TYPE;
        NUSUBSCRIPTIONID SUSCRIPC.SUSCCODI%TYPE;
        NUPERIODO		 PERIFACT.PEFACODI%TYPE;
        
        NUCUENTA        CARGOS.CARGCUCO%TYPE;

    BEGIN

       UT_TRACE.TRACE('Inicia gc_boInsolvency.GenMovCurrentDebt ',20);

       UT_TRACE.TRACE('Producto origen ['||INUPRODUCTIDSOURCE||'] y producto destino ['||INUPRODUCTIDDEST||']',22);

       NUIDX := ITBBALANCEACCOUNTS.FIRST;

       WHILE (NUIDX IS NOT NULL) LOOP
       
            UT_TRACE.TRACE('Cuenta de cobro ['||ITBBALANCEACCOUNTS(NUIDX).CUCOCODI||']',25);

            
            IF ( ITBBALANCEACCOUNTS(NUIDX).SALDVALO > 0 ) THEN
            
                SBSIGNOLDPROD    := PKBILLCONST.CREDITO;
                SBSIGNNEWPROD    := PKBILLCONST.DEBITO;

            ELSE

                SBSIGNOLDPROD    := PKBILLCONST.DEBITO;
                SBSIGNNEWPROD    := PKBILLCONST.CREDITO;

            END IF;

            
            NUCUENTA := ITBBALANCEACCOUNTS(NUIDX).CUCOCODI;
            TBACCADJUS ( TO_CHAR ( NUCUENTA ) ) := INUPRODUCTIDSOURCE;

            
            RCACCOUNT := PKTBLCUENCOBR.FRCGETRECORD( NUCUENTA );

            
            IF ( IOTBOLDPRODNOTES.EXISTS( RCACCOUNT.CUCOFACT ) ) THEN

                
                NUNOTA := IOTBOLDPRODNOTES( RCACCOUNT.CUCOFACT );

            ELSE

                
                PKBILLINGNOTEMGR.CREATEBILLINGNOTE(
                                            INUPRODUCTIDSOURCE,
                                            ITBBALANCEACCOUNTS(NUIDX).CUCOCODI,
                                            GE_BOCONSTANTS.FNUGETDOCTYPECRENOTE,
                                            SYSDATE,
                                            PKBILLINGNOTEMGR.CSBINSA,
                                            PKBILLCONST.CSBTOKEN_NOTA_CREDITO,
                                            NUNOTA );   
                                                    
                
                IOTBOLDPRODNOTES( RCACCOUNT.CUCOFACT ) := NUNOTA;

            END IF;

            
            NUSUBSCRIPTIONID := DAPR_PRODUCT.FNUGETSUBSCRIPTION_ID(INUPRODUCTIDSOURCE);

            RCCARGOS.CARGCUCO := ITBBALANCEACCOUNTS(NUIDX).CUCOCODI;
            RCCARGOS.CARGNUSE := INUPRODUCTIDSOURCE;
            RCCARGOS.CARGCONC := ITBBALANCEACCOUNTS(NUIDX).CONCCODI;
            RCCARGOS.CARGSIGN := SBSIGNOLDPROD;
            RCCARGOS.CARGDOSO := GC_BOCONSTANTS.FSBGETSUPPORTDOCINSOLV(ITBBALANCEACCOUNTS(NUIDX).CUCOCODI);
            RCCARGOS.CARGCACA := INUCAUSCARG;
            RCCARGOS.CARGVALO := ABS( ITBBALANCEACCOUNTS(NUIDX).SALDVALO );

            
            PKBILLINGPERIODMGR.ACCCURRENTPERIOD(PKTBLSUSCRIPC.FNUGETBILLINGCYCLE(NUSUBSCRIPTIONID),NUPERIODO);
            RCCARGOS.CARGPEFA := NUPERIODO;

            RCCARGOS.CARGTIPR := PKBILLCONST.POST_FACTURACION;

            RCCARGOS.CARGFECR := SYSDATE;

            RCCARGOS.CARGUSUA := SA_BOSYSTEM.GETSYSTEMUSERID;
            RCCARGOS.CARGPROG := GE_BCPROCESOS.FRCPROGRAMA(GC_BOCONSTANTS.CSB_INSOLVENCYPROGRAM).PROCCONS;

            
            RCCARGOS.CARGCODO := NUNOTA;

            
            PKTBLCARGOS.INSRECORD( RCCARGOS );

            UT_TRACE.TRACE('Se actualiza la cartera del producto origen',25);

            PKUPDACCORECEIV.UPDACCOREC( PKBILLCONST.CNUSUMA_CARGO,
                                        RCCARGOS.CARGCUCO,
                                        NUSUBSCRIPTIONID,
                                        RCCARGOS.CARGNUSE,
                                        RCCARGOS.CARGCONC,
                                        RCCARGOS.CARGSIGN,
                                        ABS( RCCARGOS.CARGVALO ),
                                        CNUUPDATE_DB );
				                         
            
            IF ( IONUNEWPRODNOTE IS NOT NULL ) THEN

                
                NUNOTA := IONUNEWPRODNOTE;

            ELSE

                
                PKBILLINGNOTEMGR.CREATEBILLINGNOTE(
                                            INUPRODUCTIDDEST,
                                            INUCUCOBRODEST,
                                            GE_BOCONSTANTS.FNUGETDOCTYPEDEBNOTE,
                                            SYSDATE,
                                            PKBILLINGNOTEMGR.CSBINSA,
                                            PKBILLCONST.CSBTOKEN_NOTA_DEBITO,
                                            NUNOTA );

                
                IONUNEWPRODNOTE := NUNOTA;

            END IF;
            
            
            NUSUBSCRIPTIONID := DAPR_PRODUCT.FNUGETSUBSCRIPTION_ID(INUPRODUCTIDDEST);

            
            RCCARGOS.CARGCUCO := INUCUCOBRODEST;
            RCCARGOS.CARGNUSE := INUPRODUCTIDDEST;
            RCCARGOS.CARGSIGN := SBSIGNNEWPROD;
            RCCARGOS.CARGDOSO := GC_BOCONSTANTS.FSBGETSUPPORTDOCINSOLV(INUCUCOBRODEST);
            RCCARGOS.CARGTIPR := PKBILLCONST.POST_FACTURACION;
            RCCARGOS.CARGFECR := SYSDATE;
            RCCARGOS.CARGUSUA := SA_BOSYSTEM.GETSYSTEMUSERID;
            RCCARGOS.CARGPROG := GE_BCPROCESOS.FRCPROGRAMA(GC_BOCONSTANTS.CSB_INSOLVENCYPROGRAM).PROCCONS;

            TBACCADJUS ( TO_CHAR ( INUCUCOBRODEST ) ) := INUPRODUCTIDDEST;

            
            RCCARGOS.CARGCODO := NUNOTA;

            
            PKTBLCARGOS.INSRECORD( RCCARGOS );

            UT_TRACE.TRACE('Se actualiza la cartera del producto destino',25);

            PKUPDACCORECEIV.UPDACCOREC( PKBILLCONST.CNUSUMA_CARGO,
                                        RCCARGOS.CARGCUCO,
                                        NUSUBSCRIPTIONID,
               				            RCCARGOS.CARGNUSE,
                                        RCCARGOS.CARGCONC,
   				                        RCCARGOS.CARGSIGN,
                                        ABS( RCCARGOS.CARGVALO ),
				                        CNUUPDATE_DB);

            NUIDX := ITBBALANCEACCOUNTS.NEXT(NUIDX);
        
        END LOOP;
        
        
        IOTBOLDPRODNOTES.DELETE;
        IONUNEWPRODNOTE   := NULL;

        UT_TRACE.TRACE('Fin del movimiento de cargos entre el producto origen ['||INUPRODUCTIDSOURCE||'] y el producto destino ['||INUPRODUCTIDDEST||']',22);

        UT_TRACE.TRACE('Finaliza gc_boInsolvency.GenMovCurrentDebt ',20);
       
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GENMOVCURRENTDEBT;
    
    




























    PROCEDURE GENTRANFERDEBT (
                              INUCAUSCARG             IN    CAUSCARG.CACACODI%TYPE,
                              INUPRODUCTIDSOURCE      IN    SERVSUSC.SESUNUSE%TYPE,
                              INUPRODUCTIDDEST        IN    SERVSUSC.SESUNUSE%TYPE,
                              ITBCARGOS               IN    GC_BCINSOLVENCY.TYTBCHARGES,
                              INUCUCOBRODEST          IN    CUENCOBR.CUCOCODI%TYPE,
                              IDTINSOLVDATE           IN    MO_DATA_INSOLVENCY.BEGIN_DATE%TYPE
                              )
    IS
       NUIDX             NUMBER := 0;
       NUNOTA            NOTAS.NOTANUME%TYPE;    
       RCCARGOS          CARGOS%ROWTYPE;
       INUSUBSCRIPTIONID SUSCRIPC.SUSCCODI%TYPE;
       SBDOSOC           VARCHAR2(3);
       SBDOSOD           VARCHAR2(3);
       NUCUENTA          CARGOS.CARGCUCO%TYPE;
       NUINTERESTDAYS    MOVIDIFE.MODIDIIN%TYPE;
       NUINSOLVDAYS      MOVIDIFE.MODIDIIN%TYPE;
       NUDESTPRODINTDAYS MOVIDIFE.MODIDIIN%TYPE;
       NUCHARGEVALUE     CARGOS.CARGVALO%TYPE;
       NUDESTPRODINTVAL  CARGOS.CARGVALO%TYPE;

    BEGIN
    
       UT_TRACE.TRACE('Inicia gc_boInsolvency.GenTranferDebt ',20);

       UT_TRACE.TRACE('Se inicia el movimiento de los cargos de traslado entre el producto origen ['||INUPRODUCTIDSOURCE||'] y el producto destino ['||INUPRODUCTIDDEST||']',22);

       NUIDX := ITBCARGOS.FIRST;
       WHILE (NUIDX IS NOT NULL) LOOP

           UT_TRACE.TRACE('Inicia gc_boInsolvency.GenTranferDebt para la cuenta de cobro ['||ITBCARGOS(NUIDX).CARGCUCO||']',25);
           
           
           NUCHARGEVALUE :=  ITBCARGOS(NUIDX).CARGVALO;

           
           IF (ITBCARGOS(NUIDX).CARGDOSO LIKE PKBILLCONST.CSBTOKEN_TRANS_DIFCOR||CHR(37)) THEN
           
                
                NUINTERESTDAYS :=  GC_BCINSOLVENCY.FNUGETINTERESTDAYS(ITBCARGOS(NUIDX).CARGNUSE,
                                                                      ITBCARGOS(NUIDX).CARGDOSO,
                                                                      ITBCARGOS(NUIDX).CARGFECR);
                
                
                NUINSOLVDAYS   := TRUNC(SYSDATE) - TRUNC(IDTINSOLVDATE);
                
                
                IF NUINTERESTDAYS > NUINSOLVDAYS THEN
                
                    
                    NUDESTPRODINTDAYS := NUINTERESTDAYS - NUINSOLVDAYS;

                    
                    NUDESTPRODINTVAL  := (ITBCARGOS(NUIDX).CARGVALO/NUINTERESTDAYS)*NUDESTPRODINTDAYS;
                    
                    
                    IF  (NUDESTPRODINTVAL >  PKBILLCONST.CERO) THEN
                    
                        
                        FA_BOPOLITICAREDONDEO.APLICAPOLITICA(ITBCARGOS(NUIDX).CARGNUSE, NUDESTPRODINTVAL);

                        
                        NUCHARGEVALUE :=  NUDESTPRODINTVAL;
                    
                    END IF;

                ELSE
                    
                    NUCHARGEVALUE := PKBILLCONST.CERO;
                
                END IF;
           
           END IF;
           
           
           
           
           
           IF (NUCHARGEVALUE > PKBILLCONST.CERO) THEN
           
                 

                 SBDOSOC := PKBILLCONST.CSBTOKEN_NOTA_CREDITO;
                 SBDOSOD := PKBILLCONST.CSBTOKEN_NOTA_DEBITO;

                 PKBILLINGNOTEMGR.CREATEBILLINGNOTE (
                                                         INUPRODUCTIDSOURCE,
                                                         ITBCARGOS(NUIDX).CARGCUCO,
                                                         GE_BOCONSTANTS.FNUGETDOCTYPECRENOTE,
                                                         SYSDATE,
                                                         PKBILLINGNOTEMGR.CSBINSA,
                                                         SBDOSOC,
                                                         NUNOTA
                                                     );

                 RCCARGOS := ITBCARGOS(NUIDX);

                 RCCARGOS.CARGSIGN := PKBILLCONST.CREDITO;
                 RCCARGOS.CARGDOSO := GC_BOCONSTANTS.FSBGETSUPPORTDOCINSOLV(ITBCARGOS(NUIDX).CARGCUCO);
                 RCCARGOS.CARGCACA := INUCAUSCARG;
                 RCCARGOS.CARGTIPR := PKBILLCONST.POST_FACTURACION;

                 RCCARGOS.CARGFECR := SYSDATE;

                 RCCARGOS.CARGUSUA := SA_BOSYSTEM.GETSYSTEMUSERID;
                 RCCARGOS.CARGPROG := GE_BCPROCESOS.FRCPROGRAMA(GC_BOCONSTANTS.CSB_INSOLVENCYPROGRAM).PROCCONS;

                 
                 NUCUENTA := ITBCARGOS(NUIDX).CARGCUCO;
                 TBACCADJUS ( TO_CHAR ( NUCUENTA ) ) := INUPRODUCTIDSOURCE;

                 
                 RCCARGOS.CARGCODO := NUNOTA;

                 
                 RCCARGOS.CARGVALO := NUCHARGEVALUE;

                 
                 PKTBLCARGOS.INSRECORD( RCCARGOS );

                 
                 INUSUBSCRIPTIONID := DAPR_PRODUCT.FNUGETSUBSCRIPTION_ID(INUPRODUCTIDSOURCE);

                 UT_TRACE.TRACE('Se actualiza la cartera del producto origen',25);

                 PKUPDACCORECEIV.UPDACCOREC( PKBILLCONST.CNUSUMA_CARGO,
    			                   	         RCCARGOS.CARGCUCO, INUSUBSCRIPTIONID,
                    				         RCCARGOS.CARGNUSE, RCCARGOS.CARGCONC,
       				                         RCCARGOS.CARGSIGN, RCCARGOS.CARGVALO,
    				                         CNUUPDATE_DB);


                 
                 

                 PKBILLINGNOTEMGR.CREATEBILLINGNOTE (
                                                         INUPRODUCTIDDEST,
                                                         INUCUCOBRODEST,
                                                         GE_BOCONSTANTS.FNUGETDOCTYPEDEBNOTE,
                                                         SYSDATE,
                                                         PKBILLINGNOTEMGR.CSBINSA,
                                                         SBDOSOD,
                                                         NUNOTA
                                                     );

                 
                 RCCARGOS := ITBCARGOS(NUIDX);

                 RCCARGOS.CARGCUCO := INUCUCOBRODEST;
                 RCCARGOS.CARGNUSE := INUPRODUCTIDDEST;
                 RCCARGOS.CARGSIGN := PKBILLCONST.DEBITO;
                 RCCARGOS.CARGDOSO := GC_BOCONSTANTS.FSBGETSUPPORTDOCINSOLV(INUCUCOBRODEST);
                 RCCARGOS.CARGTIPR := PKBILLCONST.POST_FACTURACION;
                 RCCARGOS.CARGFECR := SYSDATE;
                 RCCARGOS.CARGUSUA := SA_BOSYSTEM.GETSYSTEMUSERID;
                 RCCARGOS.CARGPROG := GE_BCPROCESOS.FRCPROGRAMA(GC_BOCONSTANTS.CSB_INSOLVENCYPROGRAM).PROCCONS;

                 
                 RCCARGOS.CARGCACA := INUCAUSCARG;

                 TBACCADJUS ( TO_CHAR ( INUCUCOBRODEST ) ) := INUPRODUCTIDDEST;

                 
                 RCCARGOS.CARGCODO := NUNOTA;

                 
                 RCCARGOS.CARGVALO := NUCHARGEVALUE;

                 
                 PKTBLCARGOS.INSRECORD( RCCARGOS );

                 
                 INUSUBSCRIPTIONID := DAPR_PRODUCT.FNUGETSUBSCRIPTION_ID(INUPRODUCTIDDEST);

                 UT_TRACE.TRACE('Se actualiza la cartera del producto destino',25);

                 PKUPDACCORECEIV.UPDACCOREC( PKBILLCONST.CNUSUMA_CARGO,
    			                   	         RCCARGOS.CARGCUCO, INUSUBSCRIPTIONID,
                    				         RCCARGOS.CARGNUSE, RCCARGOS.CARGCONC,
       				                         RCCARGOS.CARGSIGN, RCCARGOS.CARGVALO,
    				                         CNUUPDATE_DB);

    			 RCCARGOS := NULL;

                 UT_TRACE.TRACE('Fin gc_boInsolvency.GenTranferDebt para la cuenta de cobro ['||ITBCARGOS(NUIDX).CARGCUCO||']',25);
           
           END IF;

        NUIDX := ITBCARGOS.NEXT(NUIDX);

       END LOOP;

       UT_TRACE.TRACE('Fin gc_boInsolvency.GenTranferDebt ',20);

       UT_TRACE.TRACE('Fin el movimiento de los cargos de traslado entre el producto origen ['||INUPRODUCTIDSOURCE||'] y el producto destino ['||INUPRODUCTIDDEST||']',22);

    END GENTRANFERDEBT;

    






















































































    PROCEDURE PROCESSINSOLVENCY
    (
        INUMOTIVE_ID    IN  MO_MOTIVE.MOTIVE_ID%TYPE
    )
    IS
        
        
        
        NUPERIFACT              PERIFACT.PEFACODI%TYPE;
        RCBILLPERIOD            PERIFACT%ROWTYPE;
        RCINSOLVENCY            MO_DATA_INSOLVENCY%ROWTYPE;
        NUBILLINGCYCLE          SERVSUSC.SESUCICL%TYPE;
        NUCOMPANY               SISTEMA.SISTCODI%TYPE;
        RCSUSCRIPCOPY           SUSCRIPC%ROWTYPE;
        RCSOURCESUBSCRIPTION    SUSCRIPC%ROWTYPE;
        RCSERVSUSCCOPY          SERVSUSC%ROWTYPE;
        RCSERVSUSC              SERVSUSC%ROWTYPE;
        TBPRODUCTSINDEBT        DAPR_PRODUCT.TYTBPR_PRODUCT;
        NUIDX	                NUMBER := 0;
        RCDATAPROD              DAPR_PRODUCT.STYPR_PRODUCT;
        SBPARAMETER             VARCHAR2(4000);
        
        NUCURRENTACCOUNTTOTAL   NUMBER;
        NUCREDITBALANCE         NUMBER;
        NUCLAIMVALUE            NUMBER;
        NUDEFCLAIMVALUE         NUMBER;
        NUDEFERREDACCOUNTTOTAL  NUMBER;
        TBBALANCEACCOUNTS       FA_BOACCOUNTSTATUSTODATE.TYTBBALANCEACCOUNTS;
        TBDEFERREDBALANCE       FA_BOACCOUNTSTATUSTODATE.TYTBDEFERREDBALANCE;
        
        NUESTADOCUENT	        FACTURA.FACTCODI%TYPE;
        NUCUENTA                CUENCOBR.CUCOCODI%TYPE;
        NUCAUSCARG              CAUSCARG.CACACODI%TYPE;
        NUNEWPRODNOTE           NOTAS.NOTANUME%TYPE;
        TBOLDPRODNOTES          PKTBLNOTAS.TYNOTANUME;
        NUCOSTCENTERID          GE_ATTRIBUTES.ATTRIBUTE_ID%TYPE;
        SBCOSTCENTER            SUSCRIPC.SUSCCECO%TYPE;
        DTPROCESSDATE           DATE := SYSDATE;
        TBTRANSDEFCURR          GC_BCINSOLVENCY.TYTBCHARGES;

        SBIDXCTA                VARCHAR2(20);
        SBSIGAJUS               CARGOS.CARGSIGN%TYPE;
        NUVALAJUS               CARGOS.CARGVALO%TYPE;
        DTCHARGEDATE            DATE := SYSDATE;
        NUCICLOCONS             PERICOSE.PECSCICO%TYPE;

    BEGIN

        UT_TRACE.TRACE('INICIO GC_BOInsolvency.ProcessInsolvency',5);

        

        NUCICLOCONS:= PKBILLCONST.CNUCICLO_VENT;

        
        UT_TRACE.TRACE('Obtienen los datos de la insolvencia con id de motivo ['||INUMOTIVE_ID||']',6);
        RCINSOLVENCY := GC_BCINSOLVENCY.FRCGETRECORD(INUMOTIVE_ID);

        ERRORS.SETAPPLICATION(GC_BOCONSTANTS.CSB_INSOLVENCYPROGRAM);
        TBACCADJUS.DELETE;

        
        GENCHARGESADJUST( RCINSOLVENCY.DATA_INSOLVENCY_ID,
                          RCINSOLVENCY.SUBSCRIPTION_ID,
                          RCINSOLVENCY.BEGIN_DATE );

        
        IF PKDEFERREDMGR.FNUGETDEFERREDBAL(RCINSOLVENCY.SUBSCRIPTION_ID) > 0 THEN
        
            UT_TRACE.TRACE('Validar si existen productos a trasladar',10);
            PKFB_UIDEFTOCURTRANSFER.TRANSFERDTCPROCESS(
                                            RCINSOLVENCY,
                                            GC_BOCONSTANTS.CSB_INSOLVENCYPROGRAM );
        END IF;

        RCSOURCESUBSCRIPTION := PKTBLSUSCRIPC.FRCGETRECORD(RCINSOLVENCY.SUBSCRIPTION_ID);

        
        IF RCINSOLVENCY.INSOLVENCY_TYPE = CSBREORGACHAR THEN
            
            NUCOSTCENTERID := GE_BCATTRIBUTES.FNUGETATTRIDBYNAME( CSBREORGCOSTCENTER );

            
            SBCOSTCENTER := PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(
                                                                CNUWFPACKAGETYPEINSOLVENCY,
                                                                NUCOSTCENTERID );
        ELSE
            
            NUCOSTCENTERID := GE_BCATTRIBUTES.FNUGETATTRIDBYNAME( CSBLIQCOSTCENTER );

            
            SBCOSTCENTER := PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(
                                                                CNUWFPACKAGETYPEINSOLVENCY,
                                                                NUCOSTCENTERID );
        END IF;

        
        RCSUSCRIPCOPY := GC_BCINSOLVENCY.FRCSUBSCRIPTINSOLV(
                                                    RCINSOLVENCY.SUBSCRIPTION_ID,
                                                    SBCOSTCENTER );

        UT_TRACE.TRACE('La suscripci�n de tipo insolvencia ['||RCSUSCRIPCOPY.SUSCCODI||']',6);

        
        IF ( RCSUSCRIPCOPY.SUSCCODI IS NULL ) THEN

            
            UT_TRACE.TRACE('Inicia la copia de la suscripci�n original si no existe una suscripci�n de insolvencia',10);
            PKBOPERIFACT.FNUOBTPERIFACTDUMMYACTUAL(NUPERIFACT);
            
            RCBILLPERIOD   := PKTBLPERIFACT.FRCGETRECORD(NUPERIFACT);
            NUBILLINGCYCLE := RCBILLPERIOD.PEFACICL;
            NUCOMPANY := NVL(RCSOURCESUBSCRIPTION.SUSCSIST, GE_BOPARAMETER.FNUGET('DEFAULT_COMPANY'));

            
            CC_BOCOPYSUBSCRIPTION.COPYSUBSCRIPTION(RCSOURCESUBSCRIPTION, NUBILLINGCYCLE, NUCOMPANY, RCSUSCRIPCOPY);

            UT_TRACE.TRACE('Copia de la suscripci�n original ['||RCSUSCRIPCOPY.SUSCCODI||']',10);

            
            RCSUSCRIPCOPY.SUSCDETA := 'S';
            RCSUSCRIPCOPY.SUSCPRCA := GC_BOCONSTANTS.FNUGETSUCRIPPROGCART;
            RCSUSCRIPCOPY.SUSCTISU := GC_BOCONSTANTS.FNUGETSUCRIPTYPEINSOLV;

            RCSUSCRIPCOPY.SUSCCECO := SBCOSTCENTER;

            PKTBLSUSCRIPC.UPRECORD(RCSUSCRIPCOPY);

        END IF;

        
       
        PR_BCPRODUCT.GETPRODUCTSSUBSCRIPTION( RCINSOLVENCY.SUBSCRIPTION_ID, TBPRODUCTSINDEBT );

        NUIDX := TBPRODUCTSINDEBT.FIRST;

        UT_TRACE.TRACE('Inicia la copia de los productos con deuda',15);
        WHILE (NUIDX IS NOT NULL) LOOP
        
            IF(TRUNC(RCINSOLVENCY.BEGIN_DATE)+(1-(1/(24*60*60))) < DTCHARGEDATE) THEN
                DTCHARGEDATE := TRUNC(RCINSOLVENCY.BEGIN_DATE)+(1-(1/(24*60*60)));
            END IF;

            
            FA_BOACCOUNTSTATUSTODATE.PRODUCTBALANCEACCOUNTSTODATE(
                                TBPRODUCTSINDEBT(NUIDX).PRODUCT_ID,
                                DTCHARGEDATE,
                                NUCURRENTACCOUNTTOTAL,
                                NUDEFERREDACCOUNTTOTAL,
                                NUCREDITBALANCE,
                                NUCLAIMVALUE,
                                NUDEFCLAIMVALUE,
                                TBBALANCEACCOUNTS,
                                TBDEFERREDBALANCE);

            
            GC_BCINSOLVENCY.GETLASTCHARGESTOTRANSFER(
                                            TBPRODUCTSINDEBT(NUIDX).PRODUCT_ID,
                                            DTPROCESSDATE,
                                            TBTRANSDEFCURR );

            
            IF (NVL(NUCURRENTACCOUNTTOTAL, 0)  > 0 OR TBTRANSDEFCURR.COUNT > 0 ) THEN

                UT_TRACE.TRACE('Copia del producto ['||TBPRODUCTSINDEBT(NUIDX).PRODUCT_ID||']',15);

                RCDATAPROD := TBPRODUCTSINDEBT(NUIDX);
                
                RCSERVSUSC := PKTBLSERVSUSC.FRCGETRECORD(TBPRODUCTSINDEBT(NUIDX).PRODUCT_ID);

                
                PR_BOCOPYPRODUCT.COPYPRODUCT(RCDATAPROD, RCSERVSUSC, TRUE, TRUE, FALSE, TRUE, RCSERVSUSCCOPY,FALSE);

                UT_TRACE.TRACE('Termina copia del producto ['||TBPRODUCTSINDEBT(NUIDX).PRODUCT_ID||']',15);

                
                UT_TRACE.TRACE('Actualiza el nuevo producto ['||RCSERVSUSCCOPY.SESUNUSE||'] con el contrato de insolvencia ['||RCSUSCRIPCOPY.SUSCCODI||']',15);

                DAPR_PRODUCT.UPDSUBSCRIPTION_ID(RCSERVSUSCCOPY.SESUNUSE, RCSUSCRIPCOPY.SUSCCODI);
                PKTBLSERVSUSC.UPDSESUSUSC(RCSERVSUSCCOPY.SESUNUSE, RCSUSCRIPCOPY.SUSCCODI);

                
                UT_TRACE.TRACE('Actualiza el estado de corte y plan comercial del producto ['||RCSERVSUSCCOPY.SESUNUSE||']',15);

                
                PKTBLSERVSUSC.UPDSESUCICO(RCSERVSUSCCOPY.SESUNUSE, NUCICLOCONS);

                


                IF RCINSOLVENCY.INSOLVENCY_TYPE = CSBREORGACHAR THEN
                    PKTBLSERVSUSC.UPDSESUESCO(RCSERVSUSCCOPY.SESUNUSE, GC_BOCONSTANTS.FNUGETESTACORTINSOLVREO);
                ELSE
                    PKTBLSERVSUSC.UPDSESUESCO(RCSERVSUSCCOPY.SESUNUSE, GC_BOCONSTANTS.FNUGETESTACORTINSOLVLIQ);
                END IF;

                
                
                SBPARAMETER := PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(CNUWFPACKAGETYPEINSOLVENCY,CNUDEFAULT_COMMERCIAL_PLAN);
                IF (SBPARAMETER IS NOT NULL) THEN
                    IF NOT UT_CONVERT.IS_NUMBER(SBPARAMETER) THEN
                        ERRORS.SETERROR(CNUCOMMPLANNUMPARERROR);
                        RAISE EX.CONTROLLED_ERROR;
                    ELSE
                        DAPR_PRODUCT.UPDCOMMERCIAL_PLAN_ID(RCSERVSUSCCOPY.SESUNUSE,UT_CONVERT.FNUCHARTONUMBER(SBPARAMETER));
                    END IF;
                ELSE
                    ERRORS.SETERROR(CNUCOMMPLANPARERROR);
                    RAISE EX.CONTROLLED_ERROR;
                END IF;

                
                
                NUESTADOCUENT := NULL;

                PKACCOUNTMGR.GETORCREACURRACCOUNT (RCSERVSUSCCOPY,
                                            NUESTADOCUENT,NUCUENTA,TRUE,
                                            GC_BOCONSTANTS.CSB_INSOLVENCYPROGRAM );

                
                IF NUESTADOCUENT IS NOT NULL THEN
                    PKTBLFACTURA.UPDFACTSUSC(NUESTADOCUENT, RCSUSCRIPCOPY.SUSCCODI);
                END IF;

                UT_TRACE.TRACE('Cuenta de Cobro para el nuevo producto ['||NUCUENTA||']',20);

                
                IF RCINSOLVENCY.INSOLVENCY_TYPE = CSBREORGACHAR THEN
                    NUCAUSCARG := FA_BOCHARGECAUSES.FNUREORGINSOLVENCYCHCAUSE(RCSERVSUSC.SESUSERV);
                ELSE
                    NUCAUSCARG := FA_BOCHARGECAUSES.FNULIQINSOLVENCYCHCAUSE(RCSERVSUSC.SESUSERV);
                END IF;

                
                UT_TRACE.TRACE('Inicia el traslado de la deuda corriente del producto ['||TBPRODUCTSINDEBT(NUIDX).PRODUCT_ID||'] al producto ['||RCSERVSUSCCOPY.SESUNUSE||']',15);

                GENMOVCURRENTDEBT( TBBALANCEACCOUNTS,
                                   NUCAUSCARG,
                                   TBPRODUCTSINDEBT(NUIDX).PRODUCT_ID,
                                   RCSERVSUSCCOPY.SESUNUSE,
                                   NUCUENTA,
                                   NUNEWPRODNOTE,                      
                                   TBOLDPRODNOTES );                   

                
                GENTRANFERDEBT( NUCAUSCARG,
                                TBPRODUCTSINDEBT(NUIDX).PRODUCT_ID,
                                RCSERVSUSCCOPY.SESUNUSE,
                                TBTRANSDEFCURR,
                                NUCUENTA,
                                RCINSOLVENCY.BEGIN_DATE);

                UT_TRACE.TRACE('Finaliza el traslado de la deuda corriente del producto ['||TBPRODUCTSINDEBT(NUIDX).PRODUCT_ID||'] al producto ['||RCSERVSUSCCOPY.SESUNUSE||']',15);

            END IF;

            NUIDX := TBPRODUCTSINDEBT.NEXT(NUIDX);

        END LOOP;
        
        
        SBIDXCTA := TBACCADJUS.FIRST;
        WHILE (SBIDXCTA IS NOT NULL) LOOP

            UT_TRACE.TRACE('Ajusta Cuenta de cobro  ['||SBIDXCTA||']',25);
            NUCUENTA := TO_NUMBER (SBIDXCTA);

            
        	PKACCOUNTMGR.ADJUSTACCOUNT (
                                        NUCUENTA,
                                        TBACCADJUS(SBIDXCTA),
                                        NUCAUSCARG,
                                        GE_BCPROCESOS.FRCPROGRAMA(GC_BOCONSTANTS.CSB_INSOLVENCYPROGRAM).PROCCONS, 
                                        PKBILLCONST.CNUUPDATE_DB,
                                        SBSIGAJUS,
                                        NUVALAJUS,
                                        PKBILLCONST.POST_FACTURACION 
                                       );

            
            PKACCOUNTMGR.GENPOSITIVEBAL( NUCUENTA );

            
            PKACCOUNTMGR.APPLYPOSITIVEBALSERV (
                                                    TBACCADJUS(SBIDXCTA),
                                                    NUCUENTA
                                              );

            SBIDXCTA := TBACCADJUS.NEXT(SBIDXCTA);
        END LOOP;
        
        UT_TRACE.TRACE( 'Fin GC_BOInsolvency.ProcessInsolvency', 16 );
           
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END PROCESSINSOLVENCY;

    


















    PROCEDURE VALIDATERESTRICTIONS (INUPRODUCTID      IN  SERVSUSC.SESUNUSE%TYPE)
    IS
       NUPRODTYPE        SERVICIO.SERVCODI%TYPE;
       SBHASRESTRICTIONLIQ  VARCHAR2(1);
       SBHASRESTRICTIONREO  VARCHAR2(1);
       SBPROGRAM         PROCESOS.PROCCODI%TYPE;
    BEGIN
       NUPRODTYPE := DAPR_PRODUCT.FNUGETPRODUCT_TYPE_ID(INUPRODUCTID);
       
       SBPROGRAM := PKERRORS.FSBGETAPPLICATION;

       SBHASRESTRICTIONLIQ := GC_BCINSOLVENCY.FSBVALIDATERESTRICTIONS(NUPRODTYPE, SBPROGRAM, GC_BOCONSTANTS.FNUGETESTACORTINSOLVLIQ);
       SBHASRESTRICTIONREO := GC_BCINSOLVENCY.FSBVALIDATERESTRICTIONS(NUPRODTYPE, SBPROGRAM, GC_BOCONSTANTS.FNUGETESTACORTINSOLVREO);
       IF (SBHASRESTRICTIONLIQ = 'Y' OR SBHASRESTRICTIONREO = 'Y' ) THEN
           ERRORS.SETERROR(CNUINSOLVENCYPRODUCT, INUPRODUCTID);
           RAISE EX.CONTROLLED_ERROR;
       END IF;
    END VALIDATERESTRICTIONS;

    


















    PROCEDURE VALIDATESUSCRIPTIONTYPE (INUSUBSCRIPTIONID IN SUSCRIPC.SUSCCODI%TYPE,
                                       OSBISINSOLVENT    OUT NOCOPY VARCHAR2)
    IS
        NUSUSCTISU SUSCRIPC.SUSCTISU%TYPE;
    BEGIN

        NUSUSCTISU := PKTBLSUSCRIPC.FNUGETTYPESUSCRIPTION(INUSUBSCRIPTIONID);
        
        IF NUSUSCTISU <> GC_BOCONSTANTS.FNUGETSUCRIPTYPEINSOLV THEN
           OSBISINSOLVENT := GE_BOCONSTANTS.CSBNO;
        ELSE
           OSBISINSOLVENT := GE_BOCONSTANTS.CSBYES;
        END IF;
        
    END VALIDATESUSCRIPTIONTYPE;
    
    















    PROCEDURE GETSUBSCRIPTYPEBYCONTRACT
    (
        INUSUBSCRIPTION  IN  SUSCRIPC.SUSCCODI%TYPE
    ) IS

    BEGIN

      UT_TRACE.TRACE('Inicia gc_boInsolvency.getSubscripTypeByContract',15);

      IF PKTBLSUSCRIPC.FNUGETTYPESUSCRIPTION(INUSUBSCRIPTION) = GC_BOCONSTANTS.FNUGETSUCRIPTYPEINSOLV THEN
          ERRORS.SETERROR(CNUINSOLVENTCONTRACT, INUSUBSCRIPTION );
          RAISE EX.CONTROLLED_ERROR;
      END IF;

      UT_TRACE.TRACE('Fin gc_boInsolvency.getSubscripTypeByContract' ,15);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETSUBSCRIPTYPEBYCONTRACT;
    
    


















    PROCEDURE GENERATEACTIVITY
    (
        INUACTIVITY         IN  GE_ITEMS.ITEMS_ID%TYPE,
        INUPRODUCTID        IN  PR_PRODUCT.PRODUCT_ID%TYPE
    )
    IS
        
        NUORDERID           OR_ORDER.ORDER_ID%TYPE;
        NUORDERACTIVITYID   OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;

        
        NUADDRESSID         GE_SUBSCRIBER.ADDRESS_ID%TYPE;
        NUSUBSCRIPTION      SUSCRIPC.SUSCCODI%TYPE;
        NUSUBSCRIBER        GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE;

    BEGIN

        UT_TRACE.TRACE('INICIO GC_BOInsolvency.GenerateActivity',5);
        
        
        IF GC_BCINSOLVENCY.FSBGETACTIVITYTASKTYPE(INUACTIVITY)  = 'N' THEN
          ERRORS.SETERROR(CNUACTIVITYINSOLVENCY, INUACTIVITY );
          RAISE EX.CONTROLLED_ERROR;
        END IF;


        
        NUSUBSCRIPTION := DAPR_PRODUCT.FNUGETSUBSCRIPTION_ID(INUPRODUCTID);
        NUADDRESSID := DAPR_PRODUCT.FNUGETADDRESS_ID(INUPRODUCTID);
        NUSUBSCRIBER := PKTBLSUSCRIPC.FNUGETCUSTOMER(NUSUBSCRIPTION);
        UT_TRACE.TRACE('Obtienen la direcci�n del cliente ['||NUADDRESSID||']',6);

        OR_BOORDERACTIVITIES.CREATEACTIVITY
        (
            INUACTIVITY,           
            NULL,                   
            NULL,                   
            NULL,                   
            NULL,                   
            NUADDRESSID,            
            NULL,                   
            NUSUBSCRIBER,           
            NUSUBSCRIPTION,         
            INUPRODUCTID,           
            NULL,                   
            NULL,                   
            SYSDATE,                
            NULL,                   
            NULL,                   
            FALSE,                  
            NULL,                   
            NUORDERID,              
            NUORDERACTIVITYID       
        );

        UT_TRACE.TRACE('nuOrderId   ['|| NUORDERID ||']',6);
        UT_TRACE.TRACE('nuOrderActivityId ['|| NUORDERACTIVITYID ||']',6);

        
       

        UT_TRACE.TRACE('FIN GC_BOInsolvency.GenerateActivity',5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GENERATEACTIVITY;
    
   































    PROCEDURE GENPRODUCTWITHDRAWAL (INUSERVICENBR IN  SERVSUSC.SESUNUSE%TYPE)
    IS
       
       NUTIPOSUSCRIPC            SUSCRIPC.SUSCTISU%TYPE;
       NUSUSCRIPTIONID           SUSCRIPC.SUSCCODI%TYPE;
       
       
       NUCURRENTACCOUNTTOTAL    NUMBER;
       NUCREDITBALANCE          NUMBER;
       NUDEFERREDACCOUNTTOTAL   NUMBER;
       TBBALANCEACCOUNTS        FA_BOACCOUNTSTATUSTODATE.TYTBBALANCEACCOUNTS;
       TBDEFERREDBALANCE        FA_BOACCOUNTSTATUSTODATE.TYTBDEFERREDBALANCE;
       NUCLAIMVALUE             NUMBER;
       NUDEFCLAIMVALUE          NUMBER;

    BEGIN
       UT_TRACE.TRACE('Inicia GC_BOInsolvency.GenProductWithdrawal para el producto ['||INUSERVICENBR||']', 5);
       NUSUSCRIPTIONID := PKTBLSERVSUSC.FNUGETSUSCRIPTION(INUSERVICENBR);

       NUTIPOSUSCRIPC := PKTBLSUSCRIPC.FNUGETTYPESUSCRIPTION(NUSUSCRIPTIONID);
       
       IF (NUTIPOSUSCRIPC = GC_BOCONSTANTS.FNUGETSUCRIPTYPEINSOLV) THEN
       
           UT_TRACE.TRACE('El producto es de Insolvencia por lo tanto se consultar� la cartera del mismo', 5);
           
           FA_BOACCOUNTSTATUSTODATE.PRODUCTBALANCEACCOUNTSTODATE (INUSERVICENBR,
                                                               TRUNC(SYSDATE)+(1-(1/(24*60*60))),
                                                               NUCURRENTACCOUNTTOTAL,
                                                               NUDEFERREDACCOUNTTOTAL,
                                                               NUCREDITBALANCE,
                                                               NUCLAIMVALUE,
                                                               NUDEFCLAIMVALUE,
                                                               TBBALANCEACCOUNTS,
                                                               TBDEFERREDBALANCE);
       
           IF (NVL(NUCURRENTACCOUNTTOTAL,0) + NVL(NUDEFERREDACCOUNTTOTAL,0) = 0) THEN

              UT_TRACE.TRACE('Inicia el retiro del componente',10);

              
              PKTBLSERVSUSC.UPDSESUESCO(INUSERVICENBR, GE_BOPARAMETER.FNUGET('ESTACORT_RET_UNINST'));
              DAPR_PRODUCT.UPDPRODUCT_STATUS_ID(INUSERVICENBR, PR_BOCONSTANTS.CNUPRODUCT_UNINSTALL_RET);
              DAPR_PRODUCT.UPDPROVISIONAL_END_DATE(INUSERVICENBR, SYSDATE);
              DAPR_PRODUCT.UPDRETIRE_DATE(INUSERVICENBR, SYSDATE);

              
              GC_BCINSOLVENCY.UPDPRCOMPONENTBYPRODUCTRET(INUSERVICENBR);
              UT_TRACE.TRACE('Finaliza el retiro del componente',10);
          
           END IF;
       END IF;
       UT_TRACE.TRACE('FIN GC_BOInsolvency.GenProductWithdrawal',5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GENPRODUCTWITHDRAWAL;

    














    FUNCTION FRFADDITIONALINSOLVENCYDATA
    RETURN CONSTANTS.TYREFCURSOR
    IS
        RFCURSOR    CONSTANTS.TYREFCURSOR;
        NUPACKAGE   MO_PACKAGES.PACKAGE_ID%TYPE;
        SBPACKAGE   GE_BOINSTANCECONTROL.STYSBVALUE;
    BEGIN

        UT_TRACE.TRACE('Inicio GC_BOInsolvency.frfAdditionalInsolvencyData',5);
        
        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE
        (
            GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
            NULL,
            MO_BOCONSTANTS.CSBMO_PACKAGES,
            MO_BOCONSTANTS.CSBPACKAGE_ID,
            SBPACKAGE
        );

        
        NUPACKAGE :=  TO_NUMBER(SBPACKAGE);

        GC_BCINSOLVENCY.GETADDITIONALINSOLVENCYDATA(NUPACKAGE,RFCURSOR);
        
        UT_TRACE.TRACE('Fin GC_BOInsolvency.frfAdditionalInsolvencyData',5);

        RETURN RFCURSOR;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FRFADDITIONALINSOLVENCYDATA;

    















    PROCEDURE VALIDATEBALANCESUBSCRIPTION (INUSUBSCRIPTIONID IN MO_DATA_INSOLVENCY.SUBSCRIPTION_ID%TYPE)
    IS
       NUDEFERREDBALANCE         NUMBER;
       NUCURRENTBALANCE          NUMBER;
    BEGIN

        UT_TRACE.TRACE('Inicia gc_boInsolvency.ValidateBalanceSuscription',15);

        UT_TRACE.TRACE('Valida si la suscripci�n ['||INUSUBSCRIPTIONID||'] tiene productos con saldo a la fecha',20);
        NUDEFERREDBALANCE := PKDEFERREDMGR.FNUGETDEFERREDBAL(INUSUBSCRIPTIONID);
        NUCURRENTBALANCE  := PKBCSUBSCRIPTION.FNUGETOUTSTANDBAL(INUSUBSCRIPTIONID);

        
        IF (NUDEFERREDBALANCE + NUCURRENTBALANCE) <= 0 THEN
          UT_TRACE.TRACE('Subscripci�n ['||INUSUBSCRIPTIONID||'] sin saldo a la fecha',25);
          ERRORS.SETERROR(CNUSUSCRIPTIONDEBT, INUSUBSCRIPTIONID);
          RAISE EX.CONTROLLED_ERROR;
        END IF;

            UT_TRACE.TRACE('Fin gc_boInsolvency.ValidateBalanceSuscription' ,15);

        EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDATEBALANCESUBSCRIPTION;
    
    



















    PROCEDURE VALBALANCESUBSCRIPTIONTODATE (INUSUBSCRIPTIONID IN MO_DATA_INSOLVENCY.SUBSCRIPTION_ID%TYPE,
                                            IDTINSOLVENCY     IN MO_DATA_INSOLVENCY.BEGIN_DATE%TYPE)
    IS
       NUCURRENTACCOUNTTOTAL    NUMBER;
       NUCREDITBALANCE          NUMBER;
       NUCLAIMVALUE             NUMBER;
       NUDEFCLAIMVALUE          NUMBER;
       NUDEFERREDACCOUNTTOTAL   NUMBER;
       RFRESUMEACCOUNTDETAIL    PKCONSTANTE.TYREFCURSOR;
       RFACCOUNTDETAIL          PKCONSTANTE.TYREFCURSOR;
    BEGIN

        UT_TRACE.TRACE('Inicia gc_boInsolvency.ValBalanceSuscriptionToDate',15);

        UT_TRACE.TRACE('Valida si la suscripci�n ['||INUSUBSCRIPTIONID||'] tiene productos con saldo a lafecha ['||IDTINSOLVENCY||']',20);

          
          FA_BOACCOUNTSTATUSTODATE.SUBSCRIPTACCOUNTSTATUSTODATE(INUSUBSCRIPTIONID,
                                                                TRUNC(IDTINSOLVENCY)+(1-(1/(24*60*60))),
                                                                NUCURRENTACCOUNTTOTAL,
                                                                NUDEFERREDACCOUNTTOTAL,
                                                                NUCREDITBALANCE,
                                                                NUCLAIMVALUE,
                                                                NUDEFCLAIMVALUE,
                                                                RFRESUMEACCOUNTDETAIL,
                                                                RFACCOUNTDETAIL);

          IF ((NUCURRENTACCOUNTTOTAL + NUDEFERREDACCOUNTTOTAL) <= 0) THEN
             UT_TRACE.TRACE('Subscripci�n ['||INUSUBSCRIPTIONID||'] sin saldo a la fecha ['||IDTINSOLVENCY||']' ,25);
             
             ERRORS.SETERROR(CNUSUSCRIPTIONDEBT, INUSUBSCRIPTIONID);
             RAISE EX.CONTROLLED_ERROR;
          END IF;

            UT_TRACE.TRACE('Fin gc_boInsolvency.ValBalanceSuscriptionToDate' ,15);

        EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALBALANCESUBSCRIPTIONTODATE;
    
    

















    PROCEDURE VALEXISTINSOLVSUSCS
    (
        INUSUBSCRIPTIONID       IN  MO_DATA_INSOLVENCY.SUBSCRIPTION_ID%TYPE,
        ISBINSOLVENCYTYPE       IN  MO_DATA_INSOLVENCY.INSOLVENCY_TYPE%TYPE
    )
    IS
        NUCOSTCENTERID          GE_ATTRIBUTES.ATTRIBUTE_ID%TYPE;
        SBCOSTCENTER            SUSCRIPC.SUSCCECO%TYPE;
        
        RCINSOLVSUBSC           SUSCRIPC%ROWTYPE;
    BEGIN

        UT_TRACE.TRACE( 'INICIO GC_BOInsolvency.ValExistInsolvSuscs', 15 );
        
        
        IF ISBINSOLVENCYTYPE = CSBREORGACHAR THEN
            
            NUCOSTCENTERID := GE_BCATTRIBUTES.FNUGETATTRIDBYNAME( CSBREORGCOSTCENTER );

            
            SBCOSTCENTER := PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(
                                                                CNUWFPACKAGETYPEINSOLVENCY,
                                                                NUCOSTCENTERID );
        ELSE
            
            NUCOSTCENTERID := GE_BCATTRIBUTES.FNUGETATTRIDBYNAME( CSBLIQCOSTCENTER );

            
            SBCOSTCENTER := PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(
                                                                CNUWFPACKAGETYPEINSOLVENCY,
                                                                NUCOSTCENTERID );
        END IF;

        
        RCINSOLVSUBSC := GC_BCINSOLVENCY.FRCEXISTINSOLVSUSCS(INUSUBSCRIPTIONID, SBCOSTCENTER);

        
        IF ( RCINSOLVSUBSC.SUSCCODI IS NOT NULL ) THEN
            UT_TRACE.TRACE('Se encontr� suscripci�n de tipo insolvencia ['||RCINSOLVSUBSC.SUSCCODI||']',6);
            
            ERRORS.SETERROR(CNUEXISTINSOLV);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        UT_TRACE.TRACE( 'FIN GC_BOInsolvency.ValExistInsolvSuscs', 15 );

     EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALEXISTINSOLVSUSCS;

END GC_BOINSOLVENCY;