PACKAGE BODY GC_BODebtNegoCharges
IS
    































































































































































































































    
    
    
    CSBVERSION              CONSTANT VARCHAR2(10) := 'SAO545487';

    
    
    
    CNUTRACE_LEVEL          CONSTANT NUMBER := 7;
    CSBREACTIV_CHARGE       CONSTANT VARCHAR2(1) := 'R';

    
    
    
    TYPE TYTBCHARGBYACCOUNT IS TABLE OF MO_TYTBCHARGES INDEX BY VARCHAR(10);

    
    
    

    
    GTBCHARGESSUBTOTAL          MO_TYTBCHARGES;
    
    GTBCHARGESCREDITS           MO_TYTBCHARGES;
    
    
    GTBCHARGESDETAIL            MO_TYTBCHARGES;
    
    GTBCHARGESREACTIVE          MO_TYTBCHARGES;
    
    GTBCHARGESNOBILLED          MO_TYTBCHARGES;
    
    GTBCHARGESDEFERRED          MO_TYTBCHARGES;
    
    GTBACCOUNTS                 MO_TYTBBILLACCOUNT;

    
    GNUADJUSTCONCEPT            CONCEPTO.CONCCODI%TYPE;
    
    
    GTBDISCOUNTCHARGES          MO_TYTBCHARGES;
    
    
    GTBCHARGESPUNISHBAL         TYTBCHARGESBYPROD;
    
    
    GBOREVERSE                  BOOLEAN;
    GTBCHARGESSUBTOTALTMP       MO_TYTBCHARGES;
    GTBCHARGESCREDITSTMP        MO_TYTBCHARGES;
    GTBCHARGESDEFERREDTMP       MO_TYTBCHARGES;
    
    
    GTBTAXDISCBYACCOUNT         MO_TYTBCHARGES;
    
    
    GTBUPDATEDTAXES             GE_TYTBNUMBER;
    
    
    
    
    PROCEDURE ADJUSTACCOUNTS
    (
        IOTBCHARGESSUBTOTAL IN  OUT NOCOPY MO_TYTBCHARGES,
        ITBCHARGESDEFERRED  IN  OUT NOCOPY MO_TYTBCHARGES,
        INUADJUSTCONCEPT    IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTID        IN  SERVSUSC.SESUNUSE%TYPE  DEFAULT NULL
    );
    
    
    PROCEDURE SETDISCOUNTCHARGES
    (
        IRCCHARGE        IN MO_TYOBCHARGES,
        INUDISCOUNTVALUE IN NUMBER,
        ISBSIGN          IN VARCHAR2 DEFAULT  PKBILLCONST.CREDITO
    );
    
    
    PROCEDURE GETDISCOUNTCHARGES
    (
        INUPRODUCT     IN      SERVSUSC.SESUNUSE%TYPE
    );
    

    PROCEDURE ADDDISTCHARGESDISCOUNT
    (
        IRCCHARGE    IN  MO_TYOBCHARGES
    );

    PROCEDURE DISTRIBUTECREDITADJUST
    (
        IOTBCHARGESSUBTOTAL IN  OUT NOCOPY MO_TYTBCHARGES,
        ITBCHARGESDEFERRED  IN  OUT NOCOPY MO_TYTBCHARGES,
        INUADJUSTCONCEPT    IN  CONCEPTO.CONCCODI%TYPE,
        IONUADJUSTVALUE     IN  OUT NUMBER,
        INUPRODUCTID        IN  SERVSUSC.SESUNUSE%TYPE,
        INUCUCOCODI         IN  CUENCOBR.CUCOCODI%TYPE
    );
    
    PROCEDURE COPYCHARGESTABLE
    (
        ITBCHARGESORIGINAL  IN          MO_TYTBCHARGES,
        ITBCHARGESCOPY      IN  OUT     MO_TYTBCHARGES
    );

    
    
    
    
    














    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;

    























    PROCEDURE SAVECHARGESNOBILLED
    (
        IRCCHARGESNOBILLED  IN  MO_TYOBCHARGES,
        INUPRODNEGDEUDA     IN  GC_DEBT_NEGOT_CHARGE.DEBT_NEGOT_PROD_ID%TYPE,
        INUPERSONID         IN  GE_PERSON.PERSON_ID%TYPE
    )
    IS
        COLLECTVALUE        NUMBER;
        RCCARGONEGOCDEUDA   DAGC_DEBT_NEGOT_CHARGE.STYGC_DEBT_NEGOT_CHARGE;

    BEGIN

        UT_TRACE.TRACE( 'INICIO: GC_BODebtNegoCharges.SaveChargesNoBilled', 20 );

        RCCARGONEGOCDEUDA.DEBT_NEGOT_CHARGE_ID := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SEQ_GC_DEBT_NEGOT_C_197160');
        RCCARGONEGOCDEUDA.DEBT_NEGOT_PROD_ID   := INUPRODNEGDEUDA;
        RCCARGONEGOCDEUDA.CONCCODI             := IRCCHARGESNOBILLED.CONCEPT_ID;
        RCCARGONEGOCDEUDA.BILLED_UNITS         := IRCCHARGESNOBILLED.UNITS;
        RCCARGONEGOCDEUDA.BILLED_VALUE         := IRCCHARGESNOBILLED.CHARGE_VALUE;
        RCCARGONEGOCDEUDA.BILLED_BASE_VALUE    := IRCCHARGESNOBILLED.OUTSIDER_MONEY_VALUE;
        RCCARGONEGOCDEUDA.CREATION_DATE        := SYSDATE;
        RCCARGONEGOCDEUDA.SUPPORT_DOCUMENT     := IRCCHARGESNOBILLED.DOCUMENT_SUPPORT;
        RCCARGONEGOCDEUDA.DOCUMENT_CONSECUTIVE := IRCCHARGESNOBILLED.DOCUMENT_ID;
        RCCARGONEGOCDEUDA.CALL_CONSECUTIVE     := NULL;
        RCCARGONEGOCDEUDA.USER_ID              := INUPERSONID;
        RCCARGONEGOCDEUDA.SIGNCODI             := IRCCHARGESNOBILLED.SIGN_;
        RCCARGONEGOCDEUDA.PEFACODI             := IRCCHARGESNOBILLED.BILLING_PERIOD;
        RCCARGONEGOCDEUDA.CUCOCODI             := NVL(IRCCHARGESNOBILLED.BILL_ACCOUNT_ID, PKCONSTANTE.NULLNUM);
        RCCARGONEGOCDEUDA.CACACODI             := IRCCHARGESNOBILLED.CHARGE_CAUSE;
        RCCARGONEGOCDEUDA.IS_DISCOUNT          := IRCCHARGESNOBILLED.IS_DISCOUNT;

        
        DAGC_DEBT_NEGOT_CHARGE.INSRECORD( RCCARGONEGOCDEUDA );

        UT_TRACE.TRACE( 'Fin GC_BODebtNegoCharges.SaveChargesNoBilled', 20 );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
        	RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SAVECHARGESNOBILLED;


    




















    PROCEDURE SAVECHARGES
    (
        IRCCHARGES           IN  MO_TYOBCHARGES,
        INUPRODNEGDEUDA     IN  GC_DEBT_NEGOT_CHARGE.DEBT_NEGOT_PROD_ID%TYPE,
        INUPERSONID         IN  GE_PERSON.PERSON_ID%TYPE
    )
    IS
        RCCARGONEGOCDEUDA   DAGC_DEBT_NEGOT_CHARGE.STYGC_DEBT_NEGOT_CHARGE;
    BEGIN

        UT_TRACE.TRACE( 'Inicio GC_BODebtNegoCharges.SaveCharges', 20 );

        RCCARGONEGOCDEUDA.DEBT_NEGOT_CHARGE_ID := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SEQ_GC_DEBT_NEGOT_C_197160');
        RCCARGONEGOCDEUDA.DEBT_NEGOT_PROD_ID   := INUPRODNEGDEUDA;
        RCCARGONEGOCDEUDA.CONCCODI             := IRCCHARGES.CONCEPT_ID;
        RCCARGONEGOCDEUDA.BILLED_UNITS         := IRCCHARGES.UNITS;
        RCCARGONEGOCDEUDA.BILLED_VALUE         := IRCCHARGES.CHARGE_VALUE;
        RCCARGONEGOCDEUDA.BILLED_BASE_VALUE    := IRCCHARGES.OUTSIDER_MONEY_VALUE;
        RCCARGONEGOCDEUDA.CREATION_DATE        := SYSDATE;
        RCCARGONEGOCDEUDA.SUPPORT_DOCUMENT     := IRCCHARGES.DOCUMENT_SUPPORT;
        RCCARGONEGOCDEUDA.DOCUMENT_CONSECUTIVE := IRCCHARGES.DOCUMENT_ID;
        RCCARGONEGOCDEUDA.CALL_CONSECUTIVE     := NULL;
        RCCARGONEGOCDEUDA.USER_ID              := INUPERSONID;
        RCCARGONEGOCDEUDA.SIGNCODI             := IRCCHARGES.SIGN_;
        RCCARGONEGOCDEUDA.PEFACODI             := IRCCHARGES.BILLING_PERIOD;
        RCCARGONEGOCDEUDA.CUCOCODI             := IRCCHARGES.BILL_ACCOUNT_ID;
        RCCARGONEGOCDEUDA.CACACODI             := IRCCHARGES.CHARGE_CAUSE;
        RCCARGONEGOCDEUDA.IS_DISCOUNT          := IRCCHARGES.IS_DISCOUNT;
        
        
        DAGC_DEBT_NEGOT_CHARGE.INSRECORD( RCCARGONEGOCDEUDA );

        UT_TRACE.TRACE( 'Fin GC_BODebtNegoCharges.SaveCharges', 20 );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
        	RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SAVECHARGES;



    






























    PROCEDURE REGISTERCHARGENEGO
    (
        INUPRODNEGDEUDA IN      GC_DEBT_NEGOT_CHARGE.DEBT_NEGOT_PROD_ID%TYPE,
        INUPRODUCTO     IN      SERVSUSC.SESUNUSE%TYPE,
        INUPERSONID     IN      GE_PERSON.PERSON_ID%TYPE,
        ONUVALNOFACT    OUT     GC_DEBT_NEGOT_PROD.NOT_BILLED_VALUE%TYPE,
        ONUVALTRASDEF   OUT     NUMBER
    )
    IS
        
        NUINDEXNOBILLED     NUMBER;
        
        NUINDEXREACTIVE     NUMBER;
        
        NUINDEXDEFERRED     NUMBER;
    BEGIN
        UT_TRACE.TRACE( 'INICIO: GC_BODebtNegoCharges.RegisterChargeNego('||
                        INUPRODNEGDEUDA||','||INUPRODUCTO||','||INUPERSONID||')', CNUTRACE_LEVEL );

        ONUVALNOFACT := 0;
        ONUVALTRASDEF := 0;

        NUINDEXNOBILLED := GTBCHARGESNOBILLED.FIRST;

        
        LOOP
            EXIT WHEN NUINDEXNOBILLED IS NULL;

            IF(GTBCHARGESNOBILLED (NUINDEXNOBILLED).PRODUCT_ID = INUPRODUCTO)
            THEN
                SAVECHARGESNOBILLED(GTBCHARGESNOBILLED(NUINDEXNOBILLED), INUPRODNEGDEUDA, INUPERSONID);

                IF(GTBCHARGESNOBILLED(NUINDEXNOBILLED).SIGN_ = PKBILLCONST.DEBITO)
                THEN
                    ONUVALNOFACT := ONUVALNOFACT + GTBCHARGESNOBILLED(NUINDEXNOBILLED).CHARGE_VALUE;
                ELSE
                    ONUVALNOFACT := ONUVALNOFACT - GTBCHARGESNOBILLED(NUINDEXNOBILLED).CHARGE_VALUE;
                END IF;
                
            END IF;

            NUINDEXNOBILLED := GTBCHARGESNOBILLED.NEXT(NUINDEXNOBILLED);
        END LOOP;
        UT_TRACE.TRACE( 'Guard� Cargos no Facturados', CNUTRACE_LEVEL +1);

        
        
        
        NUINDEXREACTIVE := GTBCHARGESREACTIVE.FIRST;
        
        LOOP
            EXIT WHEN NUINDEXREACTIVE IS NULL;

            IF(GTBCHARGESREACTIVE (NUINDEXREACTIVE).PRODUCT_ID = INUPRODUCTO)
            THEN
                SAVECHARGES(GTBCHARGESREACTIVE(NUINDEXREACTIVE), INUPRODNEGDEUDA, INUPERSONID);
            END IF;

            NUINDEXREACTIVE := GTBCHARGESREACTIVE.NEXT(NUINDEXREACTIVE);
        END LOOP;
        UT_TRACE.TRACE( 'Guard� Cargos de Reactivaci�n', CNUTRACE_LEVEL +1);
        
        
        
        NUINDEXDEFERRED := GTBCHARGESDEFERRED.FIRST;

        LOOP
            EXIT WHEN NUINDEXDEFERRED IS NULL;

            IF(GTBCHARGESDEFERRED(NUINDEXDEFERRED).PRODUCT_ID = INUPRODUCTO)
            THEN
                
                IF(GTBCHARGESDEFERRED(NUINDEXDEFERRED).BILL_ACCOUNT_ID = PKCONSTANTE.NULLNUM)
                THEN
                    SAVECHARGESNOBILLED(GTBCHARGESDEFERRED(NUINDEXDEFERRED), INUPRODNEGDEUDA, INUPERSONID);
                ELSE
                    SAVECHARGES(GTBCHARGESDEFERRED(NUINDEXDEFERRED), INUPRODNEGDEUDA, INUPERSONID);
                END IF;
                
                
                IF(GTBCHARGESDEFERRED(NUINDEXDEFERRED).SIGN_ = PKBILLCONST.DEBITO)
                THEN
                    ONUVALTRASDEF := ONUVALTRASDEF + GTBCHARGESDEFERRED(NUINDEXDEFERRED).CHARGE_VALUE;
                ELSE
                    ONUVALTRASDEF := ONUVALTRASDEF - GTBCHARGESDEFERRED(NUINDEXDEFERRED).CHARGE_VALUE;
                END IF;
            END IF;

            NUINDEXDEFERRED := GTBCHARGESDEFERRED.NEXT(NUINDEXDEFERRED);
        END LOOP;
        UT_TRACE.TRACE( 'Guard� Cargos de Diferidos', CNUTRACE_LEVEL +1);
        
        UT_TRACE.TRACE( 'FIN: GC_BODebtNegoCharges.RegisterChargeNego', CNUTRACE_LEVEL );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
        	RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END REGISTERCHARGENEGO;


    




























    PROCEDURE INITIALIZEDATA
    IS
    BEGIN

        UT_TRACE.TRACE('INICIO GC_BODebtNegoCharges.InitializeData',CNUTRACE_LEVEL);

        
        PKBILLINGPARAMMGR.GETADJUSTCONCEPT( GNUADJUSTCONCEPT );

        GTBCHARGESSUBTOTAL := MO_TYTBCHARGES();
        GTBCHARGESCREDITS  := MO_TYTBCHARGES();
        GTBCHARGESDETAIL   := MO_TYTBCHARGES();
        GTBCHARGESREACTIVE := MO_TYTBCHARGES();
        GTBCHARGESNOBILLED := MO_TYTBCHARGES();
        GTBCHARGESDEFERRED := MO_TYTBCHARGES();
        GTBACCOUNTS        := MO_TYTBBILLACCOUNT();
        GTBDISCOUNTCHARGES := MO_TYTBCHARGES();
        GTBTAXDISCBYACCOUNT:= MO_TYTBCHARGES();
        GTBUPDATEDTAXES    := GE_TYTBNUMBER();

        GTBCHARGESSUBTOTALTMP   := MO_TYTBCHARGES();
        GTBCHARGESDEFERREDTMP   := MO_TYTBCHARGES();
        GTBCHARGESCREDITSTMP    := MO_TYTBCHARGES();
        GBOREVERSE              :=  FALSE;

        UT_TRACE.TRACE('FIN GC_BODebtNegoCharges.InitializeData',CNUTRACE_LEVEL);

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END INITIALIZEDATA;


    










































    PROCEDURE LOADCHARGESFORDEBTNEG
    (
        ITBPRODUCTS     IN      CC_TYTBPRODUCT,
        OCUCHARGES      OUT     PKCONSTANTE.TYREFCURSOR
    )
    IS
        
        
        
        TBCHARGESFILTER     MO_TYTBCHARGES;
        
        
        NUINDEXREACTIVE     NUMBER;
        
        
        
        TBCHARGESDETAIL     MO_TYTBCHARGES;
        
        
        NUINDEX                 NUMBER;
    BEGIN

        UT_TRACE.TRACE('INICIA GC_BODebtNegoCharges.LoadChargesForDebtNeg ['||ITBPRODUCTS.COUNT||']',CNUTRACE_LEVEL);
        
        
        GTBTAXDISCBYACCOUNT.DELETE;
        GTBTAXDISCBYACCOUNT := MO_TYTBCHARGES();

        TBCHARGESDETAIL    := MO_TYTBCHARGES();
        TBCHARGESDETAIL    := GTBCHARGESDETAIL;
        
        UT_TRACE.TRACE('1 conteo ['||TBCHARGESDETAIL.COUNT||']',CNUTRACE_LEVEL);
        
        NUINDEXREACTIVE    := GTBCHARGESREACTIVE.FIRST;
        LOOP
            EXIT WHEN NUINDEXREACTIVE IS NULL;

            
            TBCHARGESDETAIL.EXTEND;
            NUINDEX := TBCHARGESDETAIL.LAST;
                
            TBCHARGESDETAIL(NUINDEX) := GTBCHARGESREACTIVE(NUINDEXREACTIVE);

            NUINDEXREACTIVE := GTBCHARGESREACTIVE.NEXT(NUINDEXREACTIVE);
        END LOOP;
        
        UT_TRACE.TRACE('2 conteo ['||TBCHARGESDETAIL.COUNT||']',CNUTRACE_LEVEL);

        
        GC_BCDEBTNEGOCHARGE.FILTERCHARGESFORPROD( ITBPRODUCTS,
                                                  TBCHARGESDETAIL,
                                                  TBCHARGESFILTER );    
                                                  
        UT_TRACE.TRACE('3 conteo ['||TBCHARGESFILTER.COUNT||']',CNUTRACE_LEVEL);

        
        CC_BOFINANCING.DISTRIBPAYINTOCHARGES( TBCHARGESFILTER );
        
        UT_TRACE.TRACE('4 conteo ['||TBCHARGESFILTER.COUNT||']',CNUTRACE_LEVEL);

        
        GC_BCDEBTNEGOCHARGE.FILTERCHARGESFORBAL( TBCHARGESFILTER,
                                                 GTBCHARGESSUBTOTAL );  
                                                 
        UT_TRACE.TRACE('5 conteo ['||GTBCHARGESSUBTOTAL.COUNT||']',CNUTRACE_LEVEL);

        
        GC_BCDEBTNEGOTIATION.GETACCOUNTSBYCHARGES( GTBCHARGESSUBTOTAL,
                                                   GTBCHARGESDEFERRED,
                                                   GTBACCOUNTS );       
                                                   
        
        GTBCHARGESCREDITS.DELETE;
        GTBCHARGESCREDITS  := MO_TYTBCHARGES();

        
        ADJUSTACCOUNTS( GTBCHARGESSUBTOTAL, GTBCHARGESDEFERRED, GNUADJUSTCONCEPT ); 
        
        UT_TRACE.TRACE('6 Ajuste ['||GTBCHARGESSUBTOTAL.COUNT||']',CNUTRACE_LEVEL);
        UT_TRACE.TRACE('gnuAdjustConcept ['||GNUADJUSTCONCEPT||']',CNUTRACE_LEVEL);

        
        GC_BCDEBTNEGOCHARGE.GETCHARGESFORDEBTNEG( GNUADJUSTCONCEPT,
                                                  GTBCHARGESSUBTOTAL,
                                                  GTBCHARGESDEFERRED,
                                                  OCUCHARGES );
                                                  
        UT_TRACE.TRACE('gtbChargesSubTotal.count ['||GTBCHARGESSUBTOTAL.COUNT||']',CNUTRACE_LEVEL);
        UT_TRACE.TRACE('gtbChargesDeferred.count ['||GTBCHARGESDEFERRED.COUNT||']',CNUTRACE_LEVEL);

        UT_TRACE.TRACE('FIN GC_BODebtNegoCharges.LoadChargesForDebtNeg ['||ITBPRODUCTS.COUNT||']',CNUTRACE_LEVEL);
        
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END LOADCHARGESFORDEBTNEG;
    

    




















    PROCEDURE SETCHARGESBILLED
    (
        INUPRODUCTID        IN      SERVSUSC.SESUNUSE%TYPE,
        ONUBALANCE          OUT     NUMBER
    )
    IS
        
        NUINDNEWCHARGES     NUMBER;

        
        NUINDEX             NUMBER;

        
        TBACCOUNTSPROD      MO_TYTBBILLACCOUNT;

        
        TBCHARGES           MO_TYTBCHARGES;
        RCCHARGE            MO_TYOBCHARGES;

        
        NUSIGN              NUMBER := PKBILLCONST.CNUSUMA_CARGO;
    BEGIN
        UT_TRACE.TRACE('INICIA GC_BODebtNegoCharges.SetChargesBilled Producto['||INUPRODUCTID||']', CNUTRACE_LEVEL);

        
        ONUBALANCE := 0.0;
        
        
        TBACCOUNTSPROD := MO_TYTBBILLACCOUNT();

        
        CC_BCFINANCING.LOADBILLACCBYPRODUCT( INUPRODUCTID, TBACCOUNTSPROD );

        
        CC_BCFINANCING.LOADCHARGESFROMBILLACC (TBACCOUNTSPROD, TBCHARGES);

        
        NUINDNEWCHARGES :=  TBCHARGES.FIRST;

        LOOP
            EXIT WHEN NUINDNEWCHARGES IS NULL;

            
            IF ( TBCHARGES(NUINDNEWCHARGES).SIGN_ IN (PKBILLCONST.CREDITO,PKBILLCONST.ANULASALDO,PKBILLCONST.APLSALDFAV,PKBILLCONST.PAGO) )
            THEN
                
                NUSIGN := PKBILLCONST.CNURESTA_CARGO;
            ELSIF( TBCHARGES(NUINDNEWCHARGES).SIGN_ IN (PKBILLCONST.DEBITO,PKBILLCONST.SALDOFAVOR,PKBILLCONST.ANULAPAGO) )
            THEN
                
                NUSIGN := PKBILLCONST.CNUSUMA_CARGO;
            ELSE
               
                NUSIGN := PKBILLCONST.CERO;
            END IF;

            
            GTBCHARGESDETAIL.EXTEND;
            NUINDEX := GTBCHARGESDETAIL.LAST;

            
            RCCHARGE := TBCHARGES(NUINDNEWCHARGES);
            RCCHARGE.ROW_NUMBER_ := NUINDEX;
            RCCHARGE.BALANCE := RCCHARGE.CHARGE_VALUE * NUSIGN;

            
            GTBCHARGESDETAIL(NUINDEX) := RCCHARGE;

            
            ONUBALANCE := ONUBALANCE +  RCCHARGE.CHARGE_VALUE * NUSIGN;

            NUINDNEWCHARGES := TBCHARGES.NEXT(NUINDNEWCHARGES);
        END LOOP;

        UT_TRACE.TRACE('FIN GC_BODebtNegoCharges.SetChargesBilled', CNUTRACE_LEVEL);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE;
    END SETCHARGESBILLED;

    






























    PROCEDURE SETCHARGESNOBILLED
    (
        ITBNEWCHARGES               IN          PKBCCARGOS.TYTBRCCARGOS,
        ONUBALANCE                  OUT         NUMBER
    )
    IS
        
        NUINDNEWCHARGES         NUMBER;

        
        NUINDEX                 NUMBER;
        
        
        RCCHARGE                MO_TYOBCHARGES;

        
        NUSIGN                  NUMBER := PKBILLCONST.CNUSUMA_CARGO;
    BEGIN
    
        UT_TRACE.TRACE('INICIA GC_BODebtNegoCharges.SetChargesNoBilled ['||ITBNEWCHARGES.COUNT||']', CNUTRACE_LEVEL);

         
        ONUBALANCE := 0.0;

        
        NUINDNEWCHARGES :=  ITBNEWCHARGES.FIRST;

        LOOP
            EXIT WHEN NUINDNEWCHARGES IS NULL;

            IF( ITBNEWCHARGES(NUINDNEWCHARGES).CARGSIGN IN ( PKBILLCONST.DEBITO,PKBILLCONST.CREDITO )
                AND  ITBNEWCHARGES(NUINDNEWCHARGES).CARGCONC <> GNUADJUSTCONCEPT)
            THEN
                
                IF ( ITBNEWCHARGES(NUINDNEWCHARGES).CARGSIGN = PKBILLCONST.CREDITO ) THEN
                    
                    NUSIGN := PKBILLCONST.CNURESTA_CARGO;
                ELSE
                    
                    NUSIGN := PKBILLCONST.CNUSUMA_CARGO;
                END IF;
                
                
                GTBCHARGESDETAIL.EXTEND;
                NUINDEX := GTBCHARGESDETAIL.COUNT;
                
                
                RCCHARGE := MO_TYOBCHARGES
                (
                    ITBNEWCHARGES(NUINDNEWCHARGES).CARGCUCO,            
                    ITBNEWCHARGES(NUINDNEWCHARGES).CARGNUSE,            
                    CC_BCFINANCING.FNUPRODUCTTYPE( ITBNEWCHARGES(NUINDNEWCHARGES).CARGNUSE ),     
                    ITBNEWCHARGES(NUINDNEWCHARGES).CARGCONC,            
                    ITBNEWCHARGES(NUINDNEWCHARGES).CARGCACA,            
                    ITBNEWCHARGES(NUINDNEWCHARGES).CARGSIGN,            
                    ITBNEWCHARGES(NUINDNEWCHARGES).CARGPEFA,            
                    ITBNEWCHARGES(NUINDNEWCHARGES).CARGVALO,            
                    ITBNEWCHARGES(NUINDNEWCHARGES).CARGDOSO,            
                    NVL(ITBNEWCHARGES(NUINDNEWCHARGES).CARGCODO,PKCONSTANTE.NULLNUM),
                    NULL,                                               
                    ITBNEWCHARGES(NUINDNEWCHARGES).CARGUNID,            
                    ITBNEWCHARGES(NUINDNEWCHARGES).CARGFECR,            
                    NULL,                                               
                    NULL,                                               
                    ITBNEWCHARGES(NUINDNEWCHARGES).CARGVABL,            
                    ITBNEWCHARGES(NUINDNEWCHARGES).CARGVALO*NUSIGN,     
                    ITBNEWCHARGES(NUINDNEWCHARGES).CARGVALO*NUSIGN,     
                    NULL,                                               
                    NUINDEX,                                            
                    GE_BOCONSTANTS.CSBNO,                               
                    PKBILLCONST.CERO,                                   
                    NULL                                                
                );
                
                
                GTBCHARGESDETAIL(NUINDEX) := RCCHARGE;
                
                GTBCHARGESNOBILLED.EXTEND;
                GTBCHARGESNOBILLED(GTBCHARGESNOBILLED.LAST) := RCCHARGE;
                
                
                ONUBALANCE := ONUBALANCE + RCCHARGE.CHARGE_VALUE * NUSIGN;
                
            END IF;

            NUINDNEWCHARGES := ITBNEWCHARGES.NEXT(NUINDNEWCHARGES);
        END LOOP;

        UT_TRACE.TRACE('FIN GC_BODebtNegoCharges.SetChargesNoBilled', CNUTRACE_LEVEL);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETCHARGESNOBILLED;

    















































    PROCEDURE SETCHARGESREACTIVE
    (
        INUPRODUCTID                IN          SERVSUSC.SESUNUSE%TYPE,
        ITBCHARGESREACT             IN          PKBCCHARGES.TYTBREACCHARGES,
        ONUBALANCEREACT             OUT         NUMBER
    )
    IS
        
        NUINDNEWCHARGES         NUMBER;
        
        
        NUINDEX                 NUMBER;
        
        
        RCCHARGE                MO_TYOBCHARGES;
        
        
        NUSIGN                  NUMBER := PKBILLCONST.CNUSUMA_CARGO;
        
        
        NUPRODTYPEID            SERVICIO.SERVCODI%TYPE;
    BEGIN
        UT_TRACE.TRACE('INICIA GC_BODebtNegoCharges.SetChargesReactive ['||INUPRODUCTID||']['||ITBCHARGESREACT.COUNT||']',CNUTRACE_LEVEL);

        
        ONUBALANCEREACT := 0.0;
        
        
        NUPRODTYPEID := CC_BCFINANCING.FNUPRODUCTTYPE(INUPRODUCTID);

        
        NUINDNEWCHARGES:=  ITBCHARGESREACT.FIRST;

        WHILE ( NUINDNEWCHARGES IS NOT NULL ) LOOP

            IF ( ITBCHARGESREACT( NUINDNEWCHARGES ).SBSIGN
            IN ( PKBILLCONST.DEBITO, PKBILLCONST.CREDITO ) )
            THEN
            
                
                IF ( ITBCHARGESREACT(NUINDNEWCHARGES).SBSIGN = PKBILLCONST.CREDITO ) THEN
                    
                    NUSIGN := PKBILLCONST.CNURESTA_CARGO;
                ELSE
                    
                    NUSIGN := PKBILLCONST.CNUSUMA_CARGO;
                END IF;
                
                
                RCCHARGE := MO_TYOBCHARGES
                (
                    ITBCHARGESREACT(NUINDNEWCHARGES).NUACCOUNT,         
                    INUPRODUCTID,                                       
                    NUPRODTYPEID,                                       
                    ITBCHARGESREACT(NUINDNEWCHARGES).NUCHARGECONC,      
                    ITBCHARGESREACT(NUINDNEWCHARGES).NUCHARGECAUSE,     
                    ITBCHARGESREACT(NUINDNEWCHARGES).SBSIGN,            
                    PKCONSTANTE.NULLNUM,                                
                    ITBCHARGESREACT(NUINDNEWCHARGES).NUCHARGEVALUE,     
                    ITBCHARGESREACT(NUINDNEWCHARGES).SBSUPPORTDOC,      
                    PKCONSTANTE.NULLNUM,                                
                    NULL,                                               
                    NULL,                                               
                    SYSDATE,                                            
                    NULL,                                               
                    NULL,                                               
                    ITBCHARGESREACT(NUINDNEWCHARGES).NUBASECHVALUE,     
                    ITBCHARGESREACT(NUINDNEWCHARGES).NUCHARGEVALUE*NUSIGN, 
                    ITBCHARGESREACT(NUINDNEWCHARGES).NUCHARGEVALUE*NUSIGN, 
                    NULL,                                                  
                    NUINDEX,                                            
                    GE_BOCONSTANTS.CSBNO,                               
                    PKBILLCONST.CERO,                                   
                    CSBREACTIV_CHARGE                                   
                );
                
                GTBCHARGESREACTIVE.EXTEND;
                GTBCHARGESREACTIVE(GTBCHARGESREACTIVE.LAST) := RCCHARGE;

                
                ONUBALANCEREACT := ONUBALANCEREACT +  RCCHARGE.CHARGE_VALUE * NUSIGN;
            END IF;
            
            NUINDNEWCHARGES := ITBCHARGESREACT.NEXT(NUINDNEWCHARGES);
        END LOOP;

        UT_TRACE.TRACE('FIN GC_BODebtNegoCharges.SetChargesReactive', CNUTRACE_LEVEL);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETCHARGESREACTIVE;
    

    

































    PROCEDURE SETCHARGESDEFERRED
    (
        IRCDEFCHARGES   IN  PKCHARGEMGR.TYRCTBCHARGES
    )
    IS
        
        RCCHARGE                MO_TYOBCHARGES;
        
        
        NUINDNEWCHARGE          NUMBER;

        
        NUINDEX                 NUMBER;

        
        NUSIGN                  NUMBER := PKBILLCONST.CNUSUMA_CARGO;

    BEGIN
        UT_TRACE.TRACE('INICIA GC_BODebtNegoCharges.SetChargesDeferred ['||IRCDEFCHARGES.CARGCONC.COUNT||']',CNUTRACE_LEVEL);

         
        IF(GTBCHARGESDEFERRED IS NULL)
        THEN
           GTBCHARGESDEFERRED := MO_TYTBCHARGES();
        ELSE
           GTBCHARGESDEFERRED.DELETE;
        END IF;
        
        
        NUINDNEWCHARGE := IRCDEFCHARGES.CARGCONC.FIRST;

        LOOP
            EXIT WHEN NUINDNEWCHARGE IS NULL;

            IF( IRCDEFCHARGES.CARGSIGN( NUINDNEWCHARGE ) IN ( PKBILLCONST.DEBITO, PKBILLCONST.CREDITO )
                AND IRCDEFCHARGES.CARGCONC( NUINDNEWCHARGE ) <> GNUADJUSTCONCEPT )
            THEN
                
                IF ( IRCDEFCHARGES.CARGSIGN( NUINDNEWCHARGE ) = PKBILLCONST.CREDITO )
                THEN
                    
                    NUSIGN := PKBILLCONST.CNURESTA_CARGO;
                ELSE
                    
                    NUSIGN := PKBILLCONST.CNUSUMA_CARGO;
                END IF;

                
                GTBCHARGESDEFERRED.EXTEND;
                NUINDEX := GTBCHARGESDEFERRED.LAST;

                
                RCCHARGE := MO_TYOBCHARGES
                (
                    IRCDEFCHARGES.CARGCUCO( NUINDNEWCHARGE ),   
                    IRCDEFCHARGES.CARGNUSE( NUINDNEWCHARGE ),   
                    CC_BCFINANCING.FNUPRODUCTTYPE( IRCDEFCHARGES.CARGNUSE( NUINDNEWCHARGE ) ),  
                    IRCDEFCHARGES.CARGCONC( NUINDNEWCHARGE ),   
                    IRCDEFCHARGES.CARGCACA( NUINDNEWCHARGE ),   
                    IRCDEFCHARGES.CARGSIGN( NUINDNEWCHARGE ),   
                    IRCDEFCHARGES.CARGPEFA( NUINDNEWCHARGE ),   
                    IRCDEFCHARGES.CARGVALO( NUINDNEWCHARGE ),   
                    IRCDEFCHARGES.CARGDOSO( NUINDNEWCHARGE ),   
                    NVL(IRCDEFCHARGES.CARGCODO( NUINDNEWCHARGE ),PKCONSTANTE.NULLNUM),  
                    IRCDEFCHARGES.CARGTIPR( NUINDNEWCHARGE ),   
                    IRCDEFCHARGES.CARGUNID( NUINDNEWCHARGE ),   
                    IRCDEFCHARGES.CARGFECR( NUINDNEWCHARGE ),   
                    NULL,                                       
                    IRCDEFCHARGES.CARGCOLL( NUINDNEWCHARGE ),   
                    IRCDEFCHARGES.CARGVABL( NUINDNEWCHARGE ),   
                    IRCDEFCHARGES.CARGVALO( NUINDNEWCHARGE )*NUSIGN,    
                    IRCDEFCHARGES.CARGVALO( NUINDNEWCHARGE )*NUSIGN,    
                    NULL,                                               
                    NUINDEX,                                    
                    GE_BOCONSTANTS.CSBNO,                       
                    PKBILLCONST.CERO,                           
                    IRCDEFCHARGES.CARGUSUA( NUINDNEWCHARGE )    
                );

                GTBCHARGESDEFERRED(NUINDEX) := RCCHARGE;
                
            END IF;
            
            
            NUINDNEWCHARGE := IRCDEFCHARGES.CARGCONC.NEXT( NUINDNEWCHARGE );
        
        END LOOP;

        UT_TRACE.TRACE('FIN GC_BODebtNegoCharges.SetChargesDeferred',CNUTRACE_LEVEL);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETCHARGESDEFERRED;

    
























































    PROCEDURE SETVALUECHARGE
    (
        INUPRODUCT      IN  SERVSUSC.SESUNUSE%TYPE,
        INUCONCEPT      IN  CONCEPTO.CONCCODI%TYPE,
        INUDISCOUNTVAL  IN  NUMBER,
        ORFCHARGES      OUT PKCONSTANTE.TYREFCURSOR
    )
    IS
        
        
        
        CSBNORMAL       CONSTANT VARCHAR2(1) := 'N';
        CSBDEFERRED     CONSTANT VARCHAR2(1) := 'D';
        
        
        
        NUDISCOUNTBAL   NUMBER;
        NUIDX           BINARY_INTEGER;
        NUIDXFILL       BINARY_INTEGER;
        TBPRODCHARGES   MO_TYTBCHARGES := MO_TYTBCHARGES();
        TBPRODDEFER     MO_TYTBCHARGES := MO_TYTBCHARGES();
        TBDELTACHARGES  MO_TYTBCHARGES := MO_TYTBCHARGES();
        NUBALANCE           NUMBER;
        NUORIGINALBALANCE   NUMBER;
        DTDATENULL          DATE := NULL;

        
        
        
        CURSOR CUCHARGES
        IS  SELECT  /*+  index  ( factura pk_factura ) */
                    CHARGES.*
            FROM
            (   SELECT  ROW_NUMBER_,
                        BILL_ACCOUNT_ID,
                        CHARGE_VALUE,
                        BALANCE,
                        ORIGINAL_BALANCE,
                        CSBNORMAL COLLECTION
                FROM    TABLE( CAST( GTBCHARGESSUBTOTAL AS MO_TYTBCHARGES ) )
                WHERE   PRODUCT_ID = INUPRODUCT
                AND     CONCEPT_ID = INUCONCEPT
                UNION ALL
                SELECT  ROW_NUMBER_,
                        BILL_ACCOUNT_ID,
                        CHARGE_VALUE,
                        BALANCE,
                        ORIGINAL_BALANCE,
                        CSBDEFERRED COLLECTION
                FROM    TABLE( CAST( GTBCHARGESDEFERRED AS MO_TYTBCHARGES ) )
                WHERE   PRODUCT_ID = INUPRODUCT
                AND     CONCEPT_ID = INUCONCEPT
            )       CHARGES,
                    TABLE( CAST( GTBACCOUNTS AS MO_TYTBBILLACCOUNT ) ) ACCOUNTS,
                    FACTURA /*+ GC_BODebtNegoCharges.SetValueCharge */
            WHERE   CHARGES.BILL_ACCOUNT_ID = ACCOUNTS.BILL_ACCOUNT_ID
            AND     ACCOUNTS.BILL_ID = FACTURA.FACTCODI
            
            ORDER   BY DECODE( ACCOUNTS.BILL_ACCOUNT_ID,
                               PKCONSTANTE.NULLNUM,
                               DTDATENULL,
                               FACTFEGE );
        
        
        
        PROCEDURE RESTABBALANCE
        (
            IOTBCHARGES IN  OUT NOCOPY MO_TYTBCHARGES
        )
        IS
            NUSIGN  NUMBER;
        BEGIN

            UT_TRACE.TRACE( 'INICIO: GC_BODebtNegoCharges.SetValueCharge.RestabBalance', 16 );

            NUIDX := IOTBCHARGES.FIRST;

            WHILE ( NUIDX IS NOT NULL ) LOOP

                IF ( IOTBCHARGES(NUIDX).PRODUCT_ID = INUPRODUCT
                AND  IOTBCHARGES(NUIDX).CONCEPT_ID = INUCONCEPT )
                THEN
                    NUSIGN := PKBILLCONST.CNUSUMA_CARGO;
                    
                    IF ( IOTBCHARGES(NUIDX).SIGN_ = PKBILLCONST.CREDITO ) THEN
                        NUSIGN := PKBILLCONST.CNURESTA_CARGO;
                    END IF;

                    UT_TRACE.TRACE('iotbCharges(nuIdx).charge_value: '|| IOTBCHARGES(NUIDX).CHARGE_VALUE ,10);
                    UT_TRACE.TRACE('iotbCharges(nuIdx).balance: '|| IOTBCHARGES(NUIDX).BALANCE ,10);
                    UT_TRACE.TRACE('iotbCharges(nuIdx).original_balance: '|| IOTBCHARGES(NUIDX).ORIGINAL_BALANCE ,10);
                    
                    
                    
                    IF (IOTBCHARGES(NUIDX).CHARGE_VALUE <> IOTBCHARGES(NUIDX).BALANCE) THEN
                         
                         IF (IOTBCHARGES(NUIDX).SIGN_ = PKBILLCONST.CREDITO) THEN
                             IOTBCHARGES(NUIDX).ORIGINAL_BALANCE := IOTBCHARGES(NUIDX).ORIGINAL_BALANCE -
                               ABS(IOTBCHARGES(NUIDX).CHARGE_VALUE - IOTBCHARGES(NUIDX).BALANCE);
                         ELSE
                             IOTBCHARGES(NUIDX).ORIGINAL_BALANCE := IOTBCHARGES(NUIDX).ORIGINAL_BALANCE +
                               ABS(IOTBCHARGES(NUIDX).CHARGE_VALUE - IOTBCHARGES(NUIDX).BALANCE);
                         END IF;
                    END IF;

                    
                    IOTBCHARGES(NUIDX).BALANCE :=
                                        IOTBCHARGES(NUIDX).CHARGE_VALUE * NUSIGN;
                                        
                    UT_TRACE.TRACE('Despues de restablecer. Balance: '|| IOTBCHARGES(NUIDX).BALANCE ||' - Original_balance: '|| IOTBCHARGES(NUIDX).ORIGINAL_BALANCE, 10);
                END IF;

                NUIDX := IOTBCHARGES.NEXT( NUIDX );

            END LOOP;

            UT_TRACE.TRACE( 'FIN: GC_BODebtNegoCharges.SetValueCharge.RestabBalance', 16 );

        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END RESTABBALANCE;
        
        



        PROCEDURE GETPRODUCTCHARGES
        (
            ITBALLCHARGES   IN  OUT NOCOPY  MO_TYTBCHARGES
        )
        IS
            
            CSBPUNISH   CONSTANT VARCHAR2(10) := 'PUN-';
            BOELIMINAR  BOOLEAN;
            NUIDXANT    BINARY_INTEGER;
        BEGIN
        
            UT_TRACE.TRACE( 'INICIO: GC_BODebtNegoCharges.SetValueCharge.GetProductCharges', CNUTRACE_LEVEL+1 );
            
            NUIDX := ITBALLCHARGES.FIRST;

            
            WHILE ( NUIDX IS NOT NULL ) LOOP
                BOELIMINAR := FALSE;

                
                IF ( ITBALLCHARGES( NUIDX ).CONCEPT_ID = GNUADJUSTCONCEPT
                AND  NVL( ITBALLCHARGES( NUIDX ).DOCUMENT_SUPPORT,
                          PKCONSTANTE.NULLSB ) NOT LIKE CSBPUNISH || '%'
                AND  ITBALLCHARGES( NUIDX ).PRODUCT_ID = INUPRODUCT ) THEN
                    BOELIMINAR := TRUE;
                    NUIDXANT := NUIDX;
                END IF;

                NUIDX := ITBALLCHARGES.NEXT( NUIDX );
                
                IF BOELIMINAR THEN
                    UT_TRACE.TRACE('Eliminando ajuste indice: '|| NUIDXANT,10);
                    ITBALLCHARGES.DELETE(NUIDXANT);
                END IF;
            END LOOP;

            UT_TRACE.TRACE( 'Fin GC_BODebtNegoCharges.SetValueCharge.GetProductCharges', CNUTRACE_LEVEL+1 );

        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END GETPRODUCTCHARGES;
        

        




















        PROCEDURE UPDATECHARGE
        (
            INUINDEX            IN      NUMBER,
            INUBALANCE          IN      NUMBER,
            INUORIGINALBALANCE  IN      NUMBER,
            ITBCHARGESORIGINAL  IN OUT  MO_TYTBCHARGES
        )
        IS
            NUIDX       BINARY_INTEGER;
        BEGIN
            UT_TRACE.TRACE('INICIA GC_BODebtNegoCharges.SetValueCharge.UpdateCharge', 1);


            NUIDX   :=  ITBCHARGESORIGINAL.FIRST;
            
            WHILE (NUIDX IS NOT NULL) LOOP

                
                IF( ITBCHARGESORIGINAL(NUIDX).ROW_NUMBER_ = INUINDEX)THEN
                    
                    UT_TRACE.TRACE('Antes balance: ' || ITBCHARGESORIGINAL(NUIDX).BALANCE || ' original_balance: ' || ITBCHARGESORIGINAL(NUIDX).ORIGINAL_BALANCE, 2);

                    ITBCHARGESORIGINAL(NUIDX).BALANCE := INUBALANCE;
                    ITBCHARGESORIGINAL(NUIDX).ORIGINAL_BALANCE := INUORIGINALBALANCE;

                    UT_TRACE.TRACE('Despues balance: ' || INUBALANCE || ' original_balance: ' || INUORIGINALBALANCE, 2);
                    EXIT;
                END IF;

                NUIDX   :=  ITBCHARGESORIGINAL.NEXT(NUIDX);
            END LOOP;

            UT_TRACE.TRACE('FIN GC_BODebtNegoCharges.SetValueCharge.UpdateCharge', 1);
        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR OR PKCONSTANTE.EXERROR_LEVEL2 THEN
                UT_TRACE.TRACE( 'Error: [GC_BODebtNegoCharges.SetValueCharge.UpdateCharge]', 6 );
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                UT_TRACE.TRACE( 'Error no controlado: [GC_BODebtNegoCharges.SetValueCharge.UpdateCharge]', 6 );
                RAISE EX.CONTROLLED_ERROR;
        END UPDATECHARGE;

        

    BEGIN
        UT_TRACE.TRACE( 'INICIO: GC_BODebtNegoCharges.SetValueCharge(Producto='||
                        INUPRODUCT||', Concepto='||INUCONCEPT||', ValDesc=' ||INUDISCOUNTVAL||')', CNUTRACE_LEVEL );

        
        FA_BOPOLITICAREDONDEO.VALIDAPOLITICA(INUPRODUCT, INUDISCOUNTVAL);

        IF( GBOREVERSE )THEN
            
            COPYCHARGESTABLE( GTBCHARGESSUBTOTALTMP, GTBCHARGESSUBTOTAL );
            COPYCHARGESTABLE( GTBCHARGESDEFERREDTMP, GTBCHARGESDEFERRED );
            COPYCHARGESTABLE( GTBCHARGESCREDITSTMP, GTBCHARGESCREDITS );
            GBOREVERSE  :=  FALSE;
        END IF;
        
        
        RESTABBALANCE( GTBCHARGESSUBTOTAL );
        RESTABBALANCE( GTBCHARGESDEFERRED );

        
        NUDISCOUNTBAL := INUDISCOUNTVAL;

        
        FOR RCCHARGE IN CUCHARGES LOOP
        
            
            IF ( RCCHARGE.BALANCE > 0 ) THEN
        
                
                IF ( RCCHARGE.BALANCE > NUDISCOUNTBAL ) THEN
                    UT_TRACE.TRACE('El saldo del cargo ($'||RCCHARGE.BALANCE||') es mayor al valor a descontar: '|| NUDISCOUNTBAL,CNUTRACE_LEVEL+1);

                    
                    NUBALANCE := RCCHARGE.CHARGE_VALUE - NUDISCOUNTBAL;
                    NUORIGINALBALANCE := RCCHARGE.ORIGINAL_BALANCE - NUDISCOUNTBAL;

                    
                    IF ( RCCHARGE.COLLECTION = CSBNORMAL ) THEN
                        UT_TRACE.TRACE('Cargo normal',CNUTRACE_LEVEL+1);
                        
                        UPDATECHARGE(RCCHARGE.ROW_NUMBER_, NUBALANCE, NUORIGINALBALANCE, GTBCHARGESSUBTOTAL);
                    ELSE
                        UT_TRACE.TRACE('Cargo por traslado de diferidos',CNUTRACE_LEVEL+1);
                        
                        UPDATECHARGE(RCCHARGE.ROW_NUMBER_, NUBALANCE, NUORIGINALBALANCE, GTBCHARGESDEFERRED);
                    END IF;

                    
                    EXIT;

                ELSE
                    UT_TRACE.TRACE('El saldo del cargo es menor al valor a descontar',CNUTRACE_LEVEL+1);
                    
                    
                    NUBALANCE := PKBILLCONST.CERO;
                    NUORIGINALBALANCE := RCCHARGE.ORIGINAL_BALANCE - RCCHARGE.BALANCE;
                    
                    
                    IF ( RCCHARGE.COLLECTION = CSBNORMAL ) THEN
                        UT_TRACE.TRACE('Cargo normal',CNUTRACE_LEVEL+1);
                        
                        UPDATECHARGE(RCCHARGE.ROW_NUMBER_, NUBALANCE, NUORIGINALBALANCE, GTBCHARGESSUBTOTAL);
                    ELSE
                        UT_TRACE.TRACE('Cargo por traslado de diferidos',CNUTRACE_LEVEL+1);
                        
                        UPDATECHARGE(RCCHARGE.ROW_NUMBER_, NUBALANCE, NUORIGINALBALANCE, GTBCHARGESDEFERRED);
                    END IF;

                    
                    UT_TRACE.TRACE('nuDiscountBal: ' || NUDISCOUNTBAL || ' Cargo: ' || RCCHARGE.CHARGE_VALUE, 2);
                    NUDISCOUNTBAL := NUDISCOUNTBAL - RCCHARGE.CHARGE_VALUE;
                    UT_TRACE.TRACE('Diferencia nuDiscountBal: ' || NUDISCOUNTBAL, 2);
                END IF;
            END IF;
        END LOOP;

        
        GETPRODUCTCHARGES( GTBCHARGESSUBTOTAL ); 
        GETPRODUCTCHARGES( GTBCHARGESDEFERRED );   
        GETPRODUCTCHARGES( GTBCHARGESCREDITS );
        
        
        ADJUSTACCOUNTS( GTBCHARGESSUBTOTAL, GTBCHARGESDEFERRED, GNUADJUSTCONCEPT, INUPRODUCT ); 

        OPEN ORFCHARGES
        FOR SELECT  CHARGES.PRODUCT_ID      PRODUCTID,
                    CHARGES.CONCEPT_ID      CONCEPTID,
                    NULL                    CONCEPTDESC,
                    SUM( BALANCE )  VALUE_,
                    SUM( BALANCE )  BALANCE,
                    GE_BOCONSTANTS.CSBNO    DEFERRABLE,
                    GE_BOCONSTANTS.CSBNO    ENABLED
            FROM    TABLE( CAST( GTBCHARGESSUBTOTAL AS MO_TYTBCHARGES ) ) CHARGES
                    /*+ GC_BCDebtNegoCharge.GetChargesForDebtNeg */
            WHERE   CONCEPT_ID = GNUADJUSTCONCEPT AND
                    PRODUCT_ID = INUPRODUCT
            GROUP BY PRODUCT_ID, CONCEPT_ID;
        
        UT_TRACE.TRACE( 'FIN: GC_BODebtNegoCharges.SetValueCharge', CNUTRACE_LEVEL );
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETVALUECHARGE;
    
    


    PROCEDURE GETDATA
    (
        ORFCHARGES  OUT PKCONSTANTE.TYREFCURSOR
    ) IS
    BEGIN
        OPEN ORFCHARGES
        FOR
        SELECT
            CHARGES.BILL_ACCOUNT_ID,
            CHARGES.CONCEPT_ID,
            CHARGES.SIGN_,
            CHARGES.BALANCE,
            CHARGES.ORIGINAL_BALANCE,
            CHARGES.LIST_DIST_CREDITS,
            CHARGES.IS_DISCOUNT
         FROM   TABLE( CAST( GTBCHARGESSUBTOTAL AS MO_TYTBCHARGES ) ) CHARGES
        UNION ALL
        SELECT
            CHARGES.BILL_ACCOUNT_ID,
            CHARGES.CONCEPT_ID,
            CHARGES.SIGN_,
            CHARGES.BALANCE,
            CHARGES.ORIGINAL_BALANCE,
            CHARGES.LIST_DIST_CREDITS,
            CHARGES.IS_DISCOUNT
         FROM   TABLE( CAST( GTBCHARGESDEFERRED AS MO_TYTBCHARGES ) ) CHARGES;
    END ;

    































    PROCEDURE SETCHARGEFINANCING
    (
        INUSUSCRIPTION      IN      SUSCRIPC.SUSCCODI%TYPE,
        INUSERVICENUMBER    IN      SERVSUSC.SESUNUSE%TYPE
    )
    IS
        NUCONTRACT          SUSCRIPC.SUSCCODI%TYPE;
    BEGIN
        UT_TRACE.TRACE('INICIO GC_BODebtNegoCharges.SetChargeFinancing',CNUTRACE_LEVEL);

        UT_TRACE.TRACE('Cargos en corriente ['|| GTBCHARGESSUBTOTAL.COUNT||']', CNUTRACE_LEVEL + 2);
        UT_TRACE.TRACE('Cargos por Traslado ['|| GTBCHARGESDEFERRED.COUNT||']', CNUTRACE_LEVEL + 2);

        
        DISTRIBUTECREDITS;

        
        GC_BCDEBTNEGOTIATION.LOADCONCEPTBALANCE
        (
            INUSUSCRIPTION,
            INUSERVICENUMBER,
            GE_BOCONSTANTS.CSBNO,
            GE_BOCONSTANTS.CSBNO,
            GTBCHARGESSUBTOTAL,
            GTBCHARGESDEFERRED,
            NUCONTRACT
        );

        UT_TRACE.TRACE('FIN GC_BODebtNegoCharges.SetChargeFinancing',CNUTRACE_LEVEL);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETCHARGEFINANCING;

    












    FUNCTION FNUADJUSTVALUE
    (
        INUVALUE 	    IN	CUENCOBR.CUCOVATO%TYPE,
        INUADJUSTFACTOR IN  TIMOEMPR.TMEMFAAJ%TYPE
    )
    RETURN CUENCOBR.CUCOVATO%TYPE
    IS
        SBAJUSTSIGN     CARGOS.CARGSIGN%TYPE;
        NUAJUSTVALUE    CARGOS.CARGVALO%TYPE;
    BEGIN
        
        PKACCOUNTMGR.CALCVALORAJUSTE
        (
            INUADJUSTFACTOR,
            INUVALUE,
            NUAJUSTVALUE,
            SBAJUSTSIGN
        );

        
        IF  (SBAJUSTSIGN = PKBILLCONST.CREDITO) THEN
            RETURN INUVALUE - NUAJUSTVALUE;
        ELSE
            RETURN INUVALUE + NUAJUSTVALUE;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUADJUSTVALUE;

    




























    FUNCTION FNUVALUEREACTIVE
    (
        INUSUBSCRIPTIONID   IN  SERVSUSC.SESUSUSC%TYPE,
        INUPRODUCTID        IN  SERVSUSC.SESUNUSE%TYPE DEFAULT NULL
    )
    RETURN NUMBER
    IS
        
        
        
        BLAJUSTVALUE            BOOLEAN := FALSE;
        
        NUAJUSTFACTOR           TIMOEMPR.TMEMFAAJ%TYPE := PKBILLCONST.CERO;
        DTLASTREACTACCDATE      FACTURA.FACTFEGE%TYPE;
        NUREACTIVEVALUE         NUMBER := 0;
    BEGIN
        UT_TRACE.TRACE('Begin GC_BODebtNegoCharges.fnuValueReactive['||INUSUBSCRIPTIONID||']['||INUPRODUCTID||']', CNUTRACE_LEVEL);

        
        FA_BOPOLITICAREDONDEO.OBTIENEPOLITICAAJUSTE
        (
            INUSUBSCRIPTIONID,
            BLAJUSTVALUE,
            NUAJUSTFACTOR
        );

        
        SELECT  /*+
                    index  (cuencobr PK_CUENCOBR)
                    index  (factura  PK_FACTURA)
                */
                MAX(FACTFEGE)
        INTO    DTLASTREACTACCDATE
        FROM    /*+GC_BODebtNegoCharges.fnuValueReactive */
                (TABLE(CAST(GTBCHARGESREACTIVE AS MO_TYTBCHARGES))) CHARGES,
                CUENCOBR,
                FACTURA
        WHERE   CHARGES.PRODUCT_ID      = NVL(INUPRODUCTID, CHARGES.PRODUCT_ID)
        AND     CHARGES.BILL_ACCOUNT_ID = CUCOCODI
        AND     CUCOFACT                = FACTCODI;

        UT_TRACE.TRACE('LastDate['||DTLASTREACTACCDATE||']', CNUTRACE_LEVEL);

        

        IF  (BLAJUSTVALUE) THEN

            SELECT  SUM(GC_BODEBTNEGOCHARGES.FNUADJUSTVALUE(CHARGES.BALANCE, NUAJUSTFACTOR))
            INTO    NUREACTIVEVALUE
            FROM
            (
                SELECT  /*+
                            index  (cuencobr PK_CUENCOBR)
                            index  (factura  PK_FACTURA)
                        */
                        SUM(BALANCE) BALANCE
                FROM    (
                            SELECT  *
                            FROM    TABLE(CAST(GTBCHARGESSUBTOTAL AS MO_TYTBCHARGES))
                            UNION ALL
                            SELECT  *
                            FROM    TABLE(CAST(GTBCHARGESDEFERRED AS MO_TYTBCHARGES))
                        ) CHARGES,
                        CUENCOBR,
                        FACTURA
                        /*+ GC_BODebtNegoCharges.fnuValueReactive */
                WHERE   CHARGES.PRODUCT_ID      = NVL(INUPRODUCTID, CHARGES.PRODUCT_ID)
                AND     CHARGES.BILL_ACCOUNT_ID = CUCOCODI
                AND     CUCOFACT                = FACTCODI
                AND     FACTFEGE                <= DTLASTREACTACCDATE
                GROUP BY CHARGES.BILL_ACCOUNT_ID
            ) CHARGES;

        ELSE

            SELECT  /*+
                        index  (cuencobr PK_CUENCOBR)
                        index  (factura  PK_FACTURA)
                    */
                    SUM(BALANCE) BALANCE
            INTO    NUREACTIVEVALUE
            FROM    (
                        SELECT  *
                        FROM    TABLE(CAST(GTBCHARGESSUBTOTAL AS MO_TYTBCHARGES))
                        UNION ALL
                        SELECT  *
                        FROM    TABLE(CAST(GTBCHARGESDEFERRED AS MO_TYTBCHARGES))
                    ) CHARGES,
                    CUENCOBR,
                    FACTURA
                    /*+ GC_BODebtNegoCharges.fnuValueReactive */
            WHERE   CHARGES.PRODUCT_ID      = NVL(INUPRODUCTID, CHARGES.PRODUCT_ID)
            AND     CHARGES.BILL_ACCOUNT_ID = CUCOCODI
            AND     CUCOFACT                = FACTCODI
            AND     FACTFEGE                <= DTLASTREACTACCDATE;

        END IF;

        UT_TRACE.TRACE('FIN GC_BODebtNegoCharges.fnuValueReactive ['||NUREACTIVEVALUE||']',CNUTRACE_LEVEL);

        RETURN  NUREACTIVEVALUE;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUVALUEREACTIVE;

    




















































    PROCEDURE ADJUSTACCOUNTS
    (
        IOTBCHARGESSUBTOTAL IN  OUT NOCOPY MO_TYTBCHARGES,
        ITBCHARGESDEFERRED  IN  OUT NOCOPY MO_TYTBCHARGES,
        INUADJUSTCONCEPT    IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTID        IN  SERVSUSC.SESUNUSE%TYPE  DEFAULT NULL
    )
    IS
        
        
        
        NUIDX           BINARY_INTEGER;
        BOADJUST        BOOLEAN;
        NUPRODUCT       SERVSUSC.SESUNUSE%TYPE;
        NUSUBSCRIP      SUSCRIPC.SUSCCODI%TYPE;
        NUADJUSTFACTOR  TIMOEMPR.TMEMFAAJ%TYPE;
        NUADJUSTVALUE   CUENCOBR.CUCOSACU%TYPE;
        SBSIGN          CARGOS.CARGSIGN%TYPE;
        NUSIGN          CUENCOBR.CUCOSACU%TYPE;
        RCCHARGE        MO_TYOBCHARGES;
        SBINDICE        NUMBER;
        BOCREOAJUSTE    BOOLEAN := FALSE;
        
        
        
        CURSOR CUACCOUNTSWITHDEF
        IS
            SELECT  SUM( BALANCE ) BALANCE, PRODUCT_ID, BILL_ACCOUNT_ID
            FROM
            (   SELECT  BILL_ACCOUNT_ID, PRODUCT_ID, BALANCE
                FROM    TABLE( CAST( IOTBCHARGESSUBTOTAL AS MO_TYTBCHARGES ) )
                UNION   ALL
                SELECT  BILL_ACCOUNT_ID, PRODUCT_ID, BALANCE
                FROM    TABLE( CAST( ITBCHARGESDEFERRED AS MO_TYTBCHARGES ) )
            )
            WHERE PRODUCT_ID = NVL(INUPRODUCTID, PRODUCT_ID)
            GROUP BY BILL_ACCOUNT_ID, PRODUCT_ID;

    BEGIN
        UT_TRACE.TRACE( 'INICIO: GC_BODebtNegoCharges.AdjustAccounts', 15 );
        UT_TRACE.TRACE( 'Concepto de ajuste: '||INUADJUSTCONCEPT, 15 );

        IF ( IOTBCHARGESSUBTOTAL.COUNT > 0 ) THEN

            NUIDX := IOTBCHARGESSUBTOTAL.FIRST;
            NUPRODUCT := IOTBCHARGESSUBTOTAL( NUIDX ).PRODUCT_ID;

        ELSE
            IF (ITBCHARGESDEFERRED.COUNT > 0 ) THEN

                NUIDX := ITBCHARGESDEFERRED.FIRST;
                NUPRODUCT := ITBCHARGESDEFERRED( NUIDX ).PRODUCT_ID;
            ELSE
                UT_TRACE.TRACE('No hay cargos para procesar.', 16);
                UT_TRACE.TRACE('FIN: GC_BODebtNegoCharges.AdjustAccounts', 15);
                RETURN;
            END IF;

        END IF;

        
        NUSUBSCRIP := PKTBLSERVSUSC.FNUGETSUSCRIPTION( NUPRODUCT );

        
        FA_BOPOLITICAREDONDEO.OBTIENEPOLITICAAJUSTE( NUSUBSCRIP,
                                                     BOADJUST,          
                                                     NUADJUSTFACTOR );  
        
        IF ( NOT BOADJUST ) THEN
            UT_TRACE.TRACE( 'FIN: GC_BODebtNegoCharges.AdjustAccounts (No se debe ajustar)', 15 );
            RETURN;
        END IF;
        
        
        FOR RCACCOUNT IN CUACCOUNTSWITHDEF LOOP

            UT_TRACE.TRACE('CalcValorAjuste.... Cuenta cobro: '|| RCACCOUNT.BILL_ACCOUNT_ID ||' - Balance: '|| RCACCOUNT.BALANCE,10);

            
            PKACCOUNTMGR.CALCVALORAJUSTE( NUADJUSTFACTOR,
                                          RCACCOUNT.BALANCE,
                                          NUADJUSTVALUE,        
                                          SBSIGN );             
                                          
            UT_TRACE.TRACE('nuAdjustValue: '|| NUADJUSTVALUE ,10);
            UT_TRACE.TRACE('sbSign: '|| SBSIGN ,10);
            
            NUSIGN := PKBILLCONST.CNUSUMA_CARGO;
            IF( SBSIGN = PKBILLCONST.CREDITO  )THEN
                NUSIGN := PKBILLCONST.CNURESTA_CARGO;
            END IF;

            IF  NUADJUSTVALUE <> 0 THEN
                
                IOTBCHARGESSUBTOTAL.EXTEND;
                NUIDX := IOTBCHARGESSUBTOTAL.LAST;

                
                UT_TRACE.TRACE('Agregando cargo. Concepto: '||  INUADJUSTCONCEPT ||
                               ' - Valor: '|| NUADJUSTVALUE, 10);

                RCCHARGE := MO_TYOBCHARGES
                (
                    RCACCOUNT.BILL_ACCOUNT_ID,    
                    RCACCOUNT.PRODUCT_ID,   
                    NULL,                   
                    INUADJUSTCONCEPT,       
                    NULL,                   
                    SBSIGN,                 
                    NULL,                   
                    NUADJUSTVALUE,          
                    NULL,                   
                    NULL,                   
                    NULL,                   
                    NULL,                   
                    SYSDATE,                
                    NULL,                   
                    NULL,                   
                    NULL,                   
                    NUADJUSTVALUE * NUSIGN, 
                    NUADJUSTVALUE * NUSIGN, 
                    NULL,                   
                    NUIDX,                  
                    GE_BOCONSTANTS.CSBNO,   
                    PKBILLCONST.CERO,       
                    NULL                    
                );

                IF( SBSIGN = PKBILLCONST.CREDITO )THEN
                    GTBCHARGESCREDITS.EXTEND;
                    GTBCHARGESCREDITS( GTBCHARGESCREDITS.LAST )  := RCCHARGE;
                END IF;

                IOTBCHARGESSUBTOTAL( NUIDX ) := RCCHARGE;
            END IF;
        END LOOP;
        
        UT_TRACE.TRACE( 'FIN: GC_BODebtNegoCharges.AdjustAccounts', 15 );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ADJUSTACCOUNTS;
    
    
    






























    PROCEDURE DISTRIBUTECREDITADJUST
    (
        IOTBCHARGESSUBTOTAL IN  OUT NOCOPY MO_TYTBCHARGES,
        ITBCHARGESDEFERRED  IN  OUT NOCOPY MO_TYTBCHARGES,
        INUADJUSTCONCEPT    IN  CONCEPTO.CONCCODI%TYPE,
        IONUADJUSTVALUE     IN  OUT NUMBER,
        INUPRODUCTID        IN  SERVSUSC.SESUNUSE%TYPE,
        INUCUCOCODI         IN  CUENCOBR.CUCOCODI%TYPE
    )
    IS
        
        
        
        SBINDICE           NUMBER;
        NUIDX              BINARY_INTEGER;
        RCCHARGE           MO_TYOBCHARGES;
        NUADJUSTVALUEORIG  NUMBER;
    BEGIN
        UT_TRACE.TRACE( 'INICIO: GC_BODebtNegoCharges.DistributeCreditAdjust', 15 );
        
        NUADJUSTVALUEORIG := IONUADJUSTVALUE;

        
        
        
        UT_TRACE.TRACE('DistributeCreditAdjust - 1. Busca cargo de ajuste en colecci�n de cargos' ,10);
        SBINDICE := IOTBCHARGESSUBTOTAL.FIRST;

        LOOP
          EXIT WHEN (SBINDICE IS NULL OR IONUADJUSTVALUE=0);

          
          
          IF(   IOTBCHARGESSUBTOTAL(SBINDICE).CONCEPT_ID = INUADJUSTCONCEPT AND
                IOTBCHARGESSUBTOTAL(SBINDICE).PRODUCT_ID = INUPRODUCTID AND
                IOTBCHARGESSUBTOTAL(SBINDICE).BALANCE > IONUADJUSTVALUE AND
                IOTBCHARGESSUBTOTAL(SBINDICE).BILL_ACCOUNT_ID = INUCUCOCODI AND
                IOTBCHARGESSUBTOTAL(SBINDICE).SIGN_ <> PKBILLCONST.CREDITO
            ) THEN

                 UT_TRACE.TRACE('Encontro cargo de ajuste.  Balance: '|| IOTBCHARGESSUBTOTAL(SBINDICE).BALANCE ||
                                ' - Original: '|| IOTBCHARGESSUBTOTAL(SBINDICE).ORIGINAL_BALANCE, 10);
                                
                 IOTBCHARGESSUBTOTAL(SBINDICE).BALANCE :=
                           IOTBCHARGESSUBTOTAL(SBINDICE).BALANCE -
                           IONUADJUSTVALUE;

                 IOTBCHARGESSUBTOTAL(SBINDICE).CHARGE_VALUE :=
                           IOTBCHARGESSUBTOTAL(SBINDICE).CHARGE_VALUE -
                           IONUADJUSTVALUE;

                 IOTBCHARGESSUBTOTAL(SBINDICE).ORIGINAL_BALANCE :=
                           IOTBCHARGESSUBTOTAL(SBINDICE).ORIGINAL_BALANCE -
                           IONUADJUSTVALUE;

                 IONUADJUSTVALUE := 0;
          END IF;

          SBINDICE := IOTBCHARGESSUBTOTAL.NEXT(SBINDICE);
        END LOOP;
        

        
        
        
        IF  IONUADJUSTVALUE > 0 THEN
            UT_TRACE.TRACE('DistributeCreditAdjust - 2. Busca cargo de ajuste en colecci�n de cargos de diferidos' ,10);

            SBINDICE := ITBCHARGESDEFERRED.FIRST;

            LOOP
              EXIT WHEN (SBINDICE IS NULL OR IONUADJUSTVALUE=0);

              
              
              IF(   ITBCHARGESDEFERRED(SBINDICE).CONCEPT_ID = INUADJUSTCONCEPT AND
                    ITBCHARGESDEFERRED(SBINDICE).PRODUCT_ID = INUPRODUCTID AND
                    ITBCHARGESDEFERRED(SBINDICE).BALANCE > IONUADJUSTVALUE  AND
                    ITBCHARGESDEFERRED(SBINDICE).BILL_ACCOUNT_ID = INUCUCOCODI  AND
                    ITBCHARGESDEFERRED(SBINDICE).SIGN_ <> PKBILLCONST.CREDITO
                ) THEN

                     UT_TRACE.TRACE('Encontro cargo de ajuste.  Balance: '|| ITBCHARGESDEFERRED(SBINDICE).BALANCE ||
                                    ' - Original: '|| ITBCHARGESDEFERRED(SBINDICE).ORIGINAL_BALANCE, 10);
                     ITBCHARGESDEFERRED(SBINDICE).BALANCE :=
                               ITBCHARGESDEFERRED(SBINDICE).BALANCE -
                               IONUADJUSTVALUE;

                     ITBCHARGESDEFERRED(SBINDICE).CHARGE_VALUE :=
                               ITBCHARGESDEFERRED(SBINDICE).CHARGE_VALUE -
                               IONUADJUSTVALUE;

                     ITBCHARGESDEFERRED(SBINDICE).ORIGINAL_BALANCE :=
                               ITBCHARGESDEFERRED(SBINDICE).ORIGINAL_BALANCE -
                               IONUADJUSTVALUE;

                     IONUADJUSTVALUE := 0;
              END IF;

              SBINDICE := ITBCHARGESDEFERRED.NEXT(SBINDICE);
            END LOOP;
        END IF;
        

        
        
        
        IF  IONUADJUSTVALUE > 0 THEN
            UT_TRACE.TRACE('DistributeCreditAdjust - 3. Busca un cargo <> ajuste' ,10);

            SBINDICE := IOTBCHARGESSUBTOTAL.FIRST;

            LOOP
              EXIT WHEN (SBINDICE IS NULL OR IONUADJUSTVALUE=0);

              
              
              IF(   IOTBCHARGESSUBTOTAL(SBINDICE).CONCEPT_ID <> INUADJUSTCONCEPT AND
                    IOTBCHARGESSUBTOTAL(SBINDICE).PRODUCT_ID = INUPRODUCTID AND
                    IOTBCHARGESSUBTOTAL(SBINDICE).BALANCE > IONUADJUSTVALUE AND
                    IOTBCHARGESSUBTOTAL(SBINDICE).BILL_ACCOUNT_ID = INUCUCOCODI AND
                    IOTBCHARGESSUBTOTAL(SBINDICE).SIGN_ <> PKBILLCONST.CREDITO
                )THEN

                     UT_TRACE.TRACE('Encontro cargo. Concepto: '|| IOTBCHARGESSUBTOTAL(SBINDICE).CONCEPT_ID ||
                                    ' - Balance: '|| IOTBCHARGESSUBTOTAL(SBINDICE).BALANCE ||
                                    ' - Original: '|| IOTBCHARGESSUBTOTAL(SBINDICE).ORIGINAL_BALANCE ||
                                    ' - Lista distribuci�n: '|| IOTBCHARGESSUBTOTAL(SBINDICE).LIST_DIST_CREDITS, 10);
                     IOTBCHARGESSUBTOTAL(SBINDICE).BALANCE :=
                               IOTBCHARGESSUBTOTAL(SBINDICE).BALANCE -
                               IONUADJUSTVALUE;

                     IOTBCHARGESSUBTOTAL(SBINDICE).CHARGE_VALUE :=
                               IOTBCHARGESSUBTOTAL(SBINDICE).CHARGE_VALUE -
                               IONUADJUSTVALUE;

                     IOTBCHARGESSUBTOTAL(SBINDICE).LIST_DIST_CREDITS :=
                               NVL(IOTBCHARGESSUBTOTAL(SBINDICE).LIST_DIST_CREDITS, '') ||
                               INUADJUSTCONCEPT || '|' || IONUADJUSTVALUE ||',';

                     UT_TRACE.TRACE('DESPUES. Concepto: '|| IOTBCHARGESSUBTOTAL(SBINDICE).CONCEPT_ID ||
                                    ' - Balance: '|| IOTBCHARGESSUBTOTAL(SBINDICE).BALANCE ||
                                    ' - Original: '|| IOTBCHARGESSUBTOTAL(SBINDICE).ORIGINAL_BALANCE ||
                                    ' - Lista distribuci�n: '|| IOTBCHARGESSUBTOTAL(SBINDICE).LIST_DIST_CREDITS, 10);

                     IONUADJUSTVALUE := 0;
              END IF;

              SBINDICE := IOTBCHARGESSUBTOTAL.NEXT(SBINDICE);
            END LOOP;
        END IF;
        
        
        
        
        
        IF  IONUADJUSTVALUE > 0 THEN
            UT_TRACE.TRACE('DistributeCreditAdjust - 4. Busca un cargo <> ajuste en cargos diferidos' ,10);

            SBINDICE := ITBCHARGESDEFERRED.FIRST;

            LOOP
              EXIT WHEN (SBINDICE IS NULL OR IONUADJUSTVALUE=0);

              
              
               IF(  ITBCHARGESDEFERRED(SBINDICE).CONCEPT_ID <> INUADJUSTCONCEPT AND
                    ITBCHARGESDEFERRED(SBINDICE).PRODUCT_ID = INUPRODUCTID AND
                    ITBCHARGESDEFERRED(SBINDICE).BALANCE > IONUADJUSTVALUE AND
                    ITBCHARGESDEFERRED(SBINDICE).BILL_ACCOUNT_ID = INUCUCOCODI AND
                    ITBCHARGESDEFERRED(SBINDICE).SIGN_ <> PKBILLCONST.CREDITO
                ) THEN

                     UT_TRACE.TRACE('Encontro cargo. Concepto: '|| ITBCHARGESDEFERRED(SBINDICE).CONCEPT_ID ||
                                    ' - Balance: '|| ITBCHARGESDEFERRED(SBINDICE).BALANCE ||
                                    ' - Original: '|| ITBCHARGESDEFERRED(SBINDICE).ORIGINAL_BALANCE ||
                                    ' - Lista distribuci�n: '|| ITBCHARGESDEFERRED(SBINDICE).LIST_DIST_CREDITS, 10);
                                    
                     ITBCHARGESDEFERRED(SBINDICE).BALANCE :=
                               ITBCHARGESDEFERRED(SBINDICE).BALANCE -
                               IONUADJUSTVALUE;

                     ITBCHARGESDEFERRED(SBINDICE).CHARGE_VALUE :=
                               ITBCHARGESDEFERRED(SBINDICE).CHARGE_VALUE -
                               IONUADJUSTVALUE;

                     ITBCHARGESDEFERRED(SBINDICE).LIST_DIST_CREDITS :=
                               NVL(ITBCHARGESDEFERRED(SBINDICE).LIST_DIST_CREDITS, '') ||
                               INUADJUSTCONCEPT || '|' || IONUADJUSTVALUE ||',';

                     UT_TRACE.TRACE('DESPUES. Concepto: '|| ITBCHARGESDEFERRED(SBINDICE).CONCEPT_ID ||
                                    ' - Balance: '|| ITBCHARGESDEFERRED(SBINDICE).BALANCE ||
                                    ' - Original: '|| ITBCHARGESDEFERRED(SBINDICE).ORIGINAL_BALANCE ||
                                    ' - Lista distribuci�n: '|| ITBCHARGESDEFERRED(SBINDICE).LIST_DIST_CREDITS, 10);

                     IONUADJUSTVALUE := 0;
              END IF;

              SBINDICE := ITBCHARGESDEFERRED.NEXT(SBINDICE);
            END LOOP;
        END IF;
        


        UT_TRACE.TRACE( 'FIN: GC_BODebtNegoCharges.DistributeCreditAdjust', 15 );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END DISTRIBUTECREDITADJUST;

    
    


















    PROCEDURE REGISTERDISCOUNTNEGO
    (
        INUDEBTNEGOTPROD IN GC_DEBT_NEGOT_CHARGE.DEBT_NEGOT_PROD_ID%TYPE,
        INUPRODUCT       IN SERVSUSC.SESUNUSE%TYPE,
        INUPERSONID      IN GE_PERSON.PERSON_ID%TYPE
    )
    IS
        
        NUINDEXDISCOUNT     NUMBER;
        
        
        NUINDEXTAXCHARGES   NUMBER;

    BEGIN
        UT_TRACE.TRACE( 'INICIO: GC_BODebtNegoCharges.RegisterDiscountNego('||
                        INUDEBTNEGOTPROD||','||INUPRODUCT||','||INUPERSONID||')', CNUTRACE_LEVEL );

        
        GETDISCOUNTCHARGES(INUPRODUCT);
        
        IF ( GTBDISCOUNTCHARGES.COUNT > 0 ) THEN

            
            NUINDEXDISCOUNT := GTBDISCOUNTCHARGES.FIRST;

            WHILE ( NUINDEXDISCOUNT IS NOT NULL ) LOOP

                
                IF ( GTBDISCOUNTCHARGES(NUINDEXDISCOUNT).PRODUCT_ID = INUPRODUCT ) THEN
                    SAVECHARGESNOBILLED(GTBDISCOUNTCHARGES(NUINDEXDISCOUNT), INUDEBTNEGOTPROD, INUPERSONID);
                END IF;

                NUINDEXDISCOUNT := GTBDISCOUNTCHARGES.NEXT(NUINDEXDISCOUNT);
            END LOOP;
            
        END IF;
        
        
        UT_TRACE.TRACE('Cantidad de cargos de impuesto en gtbTaxCharges: '||GTBTAXDISCBYACCOUNT.COUNT,CNUTRACE_LEVEL);
        
        IF ( GTBTAXDISCBYACCOUNT.COUNT > 0 ) THEN

            
            NUINDEXTAXCHARGES := GTBTAXDISCBYACCOUNT.FIRST;

            WHILE ( NUINDEXTAXCHARGES IS NOT NULL ) LOOP

                
                IF ( GTBTAXDISCBYACCOUNT(NUINDEXTAXCHARGES).PRODUCT_ID = INUPRODUCT ) THEN
                    SAVECHARGESNOBILLED(GTBTAXDISCBYACCOUNT(NUINDEXTAXCHARGES), INUDEBTNEGOTPROD, INUPERSONID);
                END IF;

                NUINDEXTAXCHARGES := GTBTAXDISCBYACCOUNT.NEXT(NUINDEXTAXCHARGES);
            END LOOP;

        END IF;
        
        UT_TRACE.TRACE( 'Guard� Cargos de Descuento para el producto'||INUPRODUCT, CNUTRACE_LEVEL +1);
        UT_TRACE.TRACE( 'FIN: GC_BODebtNegoCharges.RegisterDiscountNego', CNUTRACE_LEVEL );
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            UT_TRACE.TRACE( 'ex.CONTROLLED_ERROR: GC_BODebtNegoCharges.RegisterDiscountNego', CNUTRACE_LEVEL );
            RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE( 'ERROR: GC_BODebtNegoCharges.RegisterDiscountNego', CNUTRACE_LEVEL );
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END REGISTERDISCOUNTNEGO;
    

    

























    PROCEDURE SETDISCOUNTCHARGES
    (
        IRCCHARGE        IN MO_TYOBCHARGES,
        INUDISCOUNTVALUE IN NUMBER,
        ISBSIGN          IN VARCHAR2 DEFAULT  PKBILLCONST.CREDITO
    )
    IS
        
        NUINDEX      NUMBER;

        
        RCCHARGE     MO_TYOBCHARGES;

        
        NUSIGN       NUMBER := PKBILLCONST.CNUSUMA_CARGO;
        
        BOEXIST      BOOLEAN := FALSE;

    BEGIN
        UT_TRACE.TRACE('INICIO: GC_BODebtNegoCharges.SetDiscountCharges (Concepto:['
                        ||IRCCHARGE.CONCEPT_ID||'], Valor:'||INUDISCOUNTVALUE,')', CNUTRACE_LEVEL);
        
        IF ( INUDISCOUNTVALUE > 0 ) THEN
            
            RCCHARGE := MO_TYOBCHARGES
            (
                IRCCHARGE.BILL_ACCOUNT_ID,
                IRCCHARGE.PRODUCT_ID,
                IRCCHARGE.PRODUCT_TYPE_ID,
                IRCCHARGE.CONCEPT_ID,
                IRCCHARGE.CHARGE_CAUSE,
                ISBSIGN,        
                IRCCHARGE.BILLING_PERIOD,
                INUDISCOUNTVALUE,           
                IRCCHARGE.DOCUMENT_SUPPORT,
                PKCONSTANTE.NULLNUM,        
                IRCCHARGE.PROCESS_TYPE,
                IRCCHARGE.UNITS,
                IRCCHARGE.CREATION_DATE,
                IRCCHARGE.PROGRAM,
                IRCCHARGE.CALL_SEQUENCE,
                NULL,                       
                IRCCHARGE.BALANCE,
                IRCCHARGE.BALANCE,
                NULL,
                IRCCHARGE.ROW_NUMBER_,
                GE_BOCONSTANTS.CSBYES,      
                IRCCHARGE.DISCOUNT_PERCENTAGE,
                IRCCHARGE.USERNAME
            );
            
            GTBDISCOUNTCHARGES.EXTEND;
            GTBDISCOUNTCHARGES(GTBDISCOUNTCHARGES.LAST) := RCCHARGE;
        END IF;
        
        UT_TRACE.TRACE('FIN: GC_BODebtNegoCharges.SetDiscountCharges', CNUTRACE_LEVEL);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETDISCOUNTCHARGES;
    
    
    




















    PROCEDURE GETDISCOUNTCHARGES
    (
        INUPRODUCT     IN      SERVSUSC.SESUNUSE%TYPE
    )
    IS
        


        NUCHARGESIDX        NUMBER;

        
        NUCHGDEFERIDX     NUMBER;
        
        
        NUINDEXDISCOUNT     NUMBER;
        NUCURRENTCONCEPT    GC_DEBT_NEGOT_CHARGE.CONCCODI%TYPE;
        
        NUDISCOUNTBAL       NUMBER;

    BEGIN
        UT_TRACE.TRACE( 'INICIO: GC_BODebtNegoCharges.GetDiscountCharges('||INUPRODUCT||')', CNUTRACE_LEVEL );

        UT_TRACE.TRACE('Cargos ['||GTBCHARGESSUBTOTAL.COUNT||']',15);

        IF ( GTBCHARGESSUBTOTAL.COUNT > 0 ) THEN
            
            NUCHARGESIDX := GTBCHARGESSUBTOTAL.FIRST;

            LOOP
                EXIT WHEN NUCHARGESIDX IS NULL;

                UT_TRACE.TRACE('Signo ['||GTBCHARGESSUBTOTAL(NUCHARGESIDX).SIGN_||']',CNUTRACE_LEVEL);
                UT_TRACE.TRACE('Producto ['||GTBCHARGESSUBTOTAL(NUCHARGESIDX).PRODUCT_ID||']',CNUTRACE_LEVEL);

                IF ( GTBCHARGESSUBTOTAL(NUCHARGESIDX).SIGN_ = PKBILLCONST.DEBITO
                AND  GTBCHARGESSUBTOTAL(NUCHARGESIDX).PRODUCT_ID = INUPRODUCT )  THEN
                    UT_TRACE.TRACE('Producto: '||GTBCHARGESSUBTOTAL(NUCHARGESIDX).PRODUCT_ID,CNUTRACE_LEVEL+1);
                    UT_TRACE.TRACE('Concepto: '||GTBCHARGESSUBTOTAL(NUCHARGESIDX).CONCEPT_ID,CNUTRACE_LEVEL+1);
                    UT_TRACE.TRACE('Valor:    '||GTBCHARGESSUBTOTAL(NUCHARGESIDX).CHARGE_VALUE,CNUTRACE_LEVEL+1);
                    UT_TRACE.TRACE('Balance:  '||GTBCHARGESSUBTOTAL(NUCHARGESIDX).BALANCE,CNUTRACE_LEVEL+1);

                    NUDISCOUNTBAL := GTBCHARGESSUBTOTAL(NUCHARGESIDX).CHARGE_VALUE - ABS(GTBCHARGESSUBTOTAL(NUCHARGESIDX).BALANCE);
                    UT_TRACE.TRACE('Descuento calculado: '||NUDISCOUNTBAL,CNUTRACE_LEVEL+1);
                    UT_TRACE.TRACE('-----------------------',CNUTRACE_LEVEL+1);
                ELSE
                    NUDISCOUNTBAL := 0;
                END IF;

                UT_TRACE.TRACE('Descuento ['||NUDISCOUNTBAL||']',CNUTRACE_LEVEL);
                
                IF (NUDISCOUNTBAL > 0) THEN
                    
                    
                    UT_TRACE.TRACE('Balance ['||GTBCHARGESSUBTOTAL(NUCHARGESIDX).BALANCE||']',CNUTRACE_LEVEL);
                    IF (ABS(GTBCHARGESSUBTOTAL(NUCHARGESIDX).BALANCE) = 0) THEN
                        UT_TRACE.TRACE('Cargo de descuento: '||
                          ' Distribuci�n: '|| GTBCHARGESSUBTOTAL(NUCHARGESIDX).LIST_DIST_CREDITS ||
                          ' - charge_value: '|| GTBCHARGESSUBTOTAL(NUCHARGESIDX).CHARGE_VALUE ||
                          ' - balance: '|| GTBCHARGESSUBTOTAL(NUCHARGESIDX).BALANCE ||
                          ' - original_balance: '|| GTBCHARGESSUBTOTAL(NUCHARGESIDX).ORIGINAL_BALANCE, 10);

                        
                        SETDISCOUNTCHARGES(GTBCHARGESSUBTOTAL(NUCHARGESIDX), NUDISCOUNTBAL + NVL(GTBCHARGESSUBTOTAL(NUCHARGESIDX).ORIGINAL_BALANCE, 0));

                        
                        ADDDISTCHARGESDISCOUNT(GTBCHARGESSUBTOTAL(NUCHARGESIDX));
                    ELSE
                        SETDISCOUNTCHARGES(GTBCHARGESSUBTOTAL(NUCHARGESIDX), NUDISCOUNTBAL);
                    END IF;
                END IF;

                NUCHARGESIDX := GTBCHARGESSUBTOTAL.NEXT(NUCHARGESIDX);
            END LOOP;
        
        END IF;
        
        UT_TRACE.TRACE('Diferidos ['||GTBCHARGESDEFERRED.COUNT||']',15);
        
        IF ( GTBCHARGESDEFERRED.COUNT > 0 ) THEN
        
            
            NUCHGDEFERIDX := GTBCHARGESDEFERRED.FIRST;

            LOOP
                EXIT WHEN NUCHGDEFERIDX IS NULL;

                UT_TRACE.TRACE('Signo ['||GTBCHARGESDEFERRED(NUCHGDEFERIDX).SIGN_||']',CNUTRACE_LEVEL);
                UT_TRACE.TRACE('Producto ['||GTBCHARGESDEFERRED(NUCHGDEFERIDX).PRODUCT_ID||']',CNUTRACE_LEVEL);
                
                IF(GTBCHARGESDEFERRED(NUCHGDEFERIDX).SIGN_ = PKBILLCONST.DEBITO
                AND  GTBCHARGESDEFERRED(NUCHGDEFERIDX).PRODUCT_ID = INUPRODUCT )  THEN
                    NUDISCOUNTBAL := GTBCHARGESDEFERRED(NUCHGDEFERIDX).CHARGE_VALUE - ABS(GTBCHARGESDEFERRED(NUCHGDEFERIDX).BALANCE);
                ELSE
                    NUDISCOUNTBAL := 0;
                END IF;

                UT_TRACE.TRACE('Descuento ['||NUDISCOUNTBAL||']',CNUTRACE_LEVEL);

                IF (NUDISCOUNTBAL > 0) THEN
                    
                    
                    UT_TRACE.TRACE('Balance ['||GTBCHARGESDEFERRED(NUCHGDEFERIDX).BALANCE||']',CNUTRACE_LEVEL);
                    IF (ABS(GTBCHARGESDEFERRED(NUCHGDEFERIDX).BALANCE) = 0) THEN
                        UT_TRACE.TRACE('Cargo de descuento: '||
                          ' Distribuci�n: '|| GTBCHARGESDEFERRED(NUCHGDEFERIDX).LIST_DIST_CREDITS ||
                          ' - charge_value: '|| GTBCHARGESDEFERRED(NUCHGDEFERIDX).CHARGE_VALUE ||
                          ' - balance: '|| GTBCHARGESDEFERRED(NUCHGDEFERIDX).BALANCE ||
                          ' - original_balance: '|| GTBCHARGESDEFERRED(NUCHGDEFERIDX).ORIGINAL_BALANCE, 10);

                        
                        SETDISCOUNTCHARGES(GTBCHARGESDEFERRED(NUCHGDEFERIDX), NUDISCOUNTBAL + NVL(GTBCHARGESDEFERRED(NUCHGDEFERIDX).ORIGINAL_BALANCE, 0));

                        
                        ADDDISTCHARGESDISCOUNT(GTBCHARGESDEFERRED(NUCHGDEFERIDX));
                    ELSE
                        SETDISCOUNTCHARGES(GTBCHARGESDEFERRED(NUCHGDEFERIDX), NUDISCOUNTBAL);
                    END IF;
                END IF;

                NUCHGDEFERIDX := GTBCHARGESDEFERRED.NEXT(NUCHGDEFERIDX);
            END LOOP;
        
        END IF;
        
        UT_TRACE.TRACE( 'FIN: GC_BODebtNegoCharges.GetDiscountCharges', CNUTRACE_LEVEL );
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETDISCOUNTCHARGES;
    
    
    


















    PROCEDURE ADDDISTCHARGESDISCOUNT
    (
        IRCCHARGE    IN  MO_TYOBCHARGES
    )
    IS
        
        NUINDX              NUMBER;

        TBLISTADO           UT_STRING.TYTB_STRING;
        TBDIST              UT_STRING.TYTB_STRING;

        NUVALORCREDITO      NUMBER;
        NUVALORDEBITO       NUMBER;
        NUTOTALCREDITOS     NUMBER;
        
        RCCHARGECOPIA       MO_TYOBCHARGES;

        

        NUROUNDFACTOR       TIMOEMPR.TMEMFARE%TYPE;
    BEGIN
           UT_TRACE.TRACE( 'INICIO: GC_BODebtNegoCharges.AddDistChargesDiscount', CNUTRACE_LEVEL );
           IF IRCCHARGE.LIST_DIST_CREDITS IS NOT NULL THEN
               UT_STRING.EXTSTRING(IRCCHARGE.LIST_DIST_CREDITS, ',', TBLISTADO);

               NUVALORDEBITO := IRCCHARGE.ORIGINAL_BALANCE;
               NUTOTALCREDITOS := 0;

               NUINDX := TBLISTADO.FIRST;

               LOOP
                EXIT WHEN NUINDX IS NULL;
                   IF TBLISTADO(NUINDX) IS NOT NULL AND LENGTH(TBLISTADO(NUINDX)) > 0 THEN
                        UT_STRING.EXTSTRING(TBLISTADO(NUINDX), '|', TBDIST);

                        UT_TRACE.TRACE('Distribuci�n: '|| TBLISTADO(NUINDX), 10);

                        NUVALORCREDITO := TBDIST(2);

                        UT_TRACE.TRACE('Valor Cr�dito: '|| NUVALORCREDITO, 10);

                        NUTOTALCREDITOS := NUTOTALCREDITOS + NUVALORCREDITO;
                        UT_TRACE.TRACE('Total de cr�ditos: '|| NUTOTALCREDITOS, 10);

                        
                        
                        
                        
                        IF (NUINDX = (TBLISTADO.LAST-1)) THEN
                           UT_TRACE.TRACE('Ultimo. Valor referencia: '|| IRCCHARGE.ORIGINAL_BALANCE ||
                                          ' - Saldo del concepto sin descuento: '|| IRCCHARGE.CHARGE_VALUE, 10);

                           IF (IRCCHARGE.ORIGINAL_BALANCE > NUTOTALCREDITOS) THEN
                              NUVALORCREDITO := NUVALORCREDITO + ABS(IRCCHARGE.ORIGINAL_BALANCE - NUTOTALCREDITOS);
                              UT_TRACE.TRACE('Valor Cr�dito Despues: '|| NUVALORCREDITO,  10);
                           ELSIF (IRCCHARGE.ORIGINAL_BALANCE < NUTOTALCREDITOS) THEN
                              NUVALORCREDITO := NUVALORCREDITO - ABS(IRCCHARGE.ORIGINAL_BALANCE-NUTOTALCREDITOS);
                              UT_TRACE.TRACE('Valor Cr�dito Despues: '|| NUVALORCREDITO, 10);
                           END IF;
                        END IF;

                        
                        RCCHARGECOPIA := IRCCHARGE;
                        RCCHARGECOPIA.CONCEPT_ID := TBDIST(1);

                        
                        UT_TRACE.TRACE('Agrega cargo descuento. ' ,10);
                        SETDISCOUNTCHARGES( RCCHARGECOPIA, NUVALORCREDITO, PKBILLCONST.DEBITO);
                   END IF;

                NUINDX := TBLISTADO.NEXT(NUINDX);
               END LOOP;
           END IF;
           UT_TRACE.TRACE( 'FIN: GC_BODebtNegoCharges.AddDistChargesDiscount', CNUTRACE_LEVEL );
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE;
    END ADDDISTCHARGESDISCOUNT;
    
    
    

















    PROCEDURE ADJUSTLOADPRODDEBTNEG
    (
        INUPRODUCTID        IN  CUENCOBR.CUCONUSE%TYPE,
        ONUADJUSTVALUE     OUT  CUENCOBR.CUCOSACU%TYPE
    )
    IS
        
        
        
        BOADJUST        BOOLEAN;
        NUSUBSCRIP      SUSCRIPC.SUSCCODI%TYPE;
        NUADJUSTFACTOR  TIMOEMPR.TMEMFAAJ%TYPE;
        NUADJUSTVALUE   CUENCOBR.CUCOSACU%TYPE;
        SBSIGN          CARGOS.CARGSIGN%TYPE;
        NUSIGN          CUENCOBR.CUCOSACU%TYPE;
        
        
        
        CURSOR CUACCOUNTS
        IS
            SELECT  BILL_ACCOUNT_ID, SUM( BALANCE ) BALANCE
            FROM    TABLE( CAST( GTBCHARGESDETAIL AS MO_TYTBCHARGES ) ) CHARGES
            WHERE   INUPRODUCTID = PRODUCT_ID
            GROUP BY BILL_ACCOUNT_ID;

    BEGIN
        UT_TRACE.TRACE( 'INICIO: GC_BODebtNegoCharges.AdjustLoadProdDebtNeg', 7 );

        ONUADJUSTVALUE := 0;

        
        NUSUBSCRIP := PKTBLSERVSUSC.FNUGETSUSCRIPTION( INUPRODUCTID );

        
        FA_BOPOLITICAREDONDEO.OBTIENEPOLITICAAJUSTE
        (
            NUSUBSCRIP,
            BOADJUST,          
            NUADJUSTFACTOR   
        );
        
        
        IF ( NOT BOADJUST ) THEN
            UT_TRACE.TRACE( 'FIN: GC_BODebtNegoCharges.AdjustLoadProdDebtNeg (No se debe ajustar)', 7 );
            RETURN;
        END IF;

        
        FOR RCACCOUNT IN CUACCOUNTS LOOP
        
            
            PKACCOUNTMGR.CALCVALORAJUSTE
            (
                NUADJUSTFACTOR,
                RCACCOUNT.BALANCE,
                NUADJUSTVALUE,        
                SBSIGN                
            );

            NUSIGN := 1;
            IF ( SBSIGN = PKBILLCONST.CREDITO ) THEN
                NUSIGN := -1;
            END IF;

            ONUADJUSTVALUE := ONUADJUSTVALUE + NUADJUSTVALUE * NUSIGN;

        END LOOP;

        UT_TRACE.TRACE( 'FIN: GC_BODebtNegoCharges.AdjustLoadProdDebtNeg - Valor a ajustar: '||ONUADJUSTVALUE, 7 );
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ADJUSTLOADPRODDEBTNEG;

    















    PROCEDURE GETCHARGES
    (
        OCUCHARGES   OUT   PKCONSTANTE.TYREFCURSOR
    )
    IS
    BEGIN
        UT_TRACE.TRACE( 'Inicio: [GC_BODebtNegoCharge.GetCharges]', CNUTRACE_LEVEL );
        
        GC_BCDEBTNEGOCHARGE.GETCHARGES
        (
          GTBCHARGESSUBTOTAL,
          GTBCHARGESDEFERRED,
          OCUCHARGES
        );
        
        UT_TRACE.TRACE( 'Fin: [GC_BODebtNegoCharge.GetCharges]', CNUTRACE_LEVEL );
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCHARGES;
    
    












    PROCEDURE DISTRIBUTECREDITS
    IS
        NUIDX               BINARY_INTEGER;
        NUIDXTMP            BINARY_INTEGER;
    BEGIN
        UT_TRACE.TRACE( 'Inicio: [GC_BODebtNegoCharge.DistributeCredits]', 2 );

        
        COPYCHARGESTABLE( GTBCHARGESSUBTOTAL, GTBCHARGESSUBTOTALTMP );
        COPYCHARGESTABLE( GTBCHARGESDEFERRED, GTBCHARGESDEFERREDTMP );
        COPYCHARGESTABLE( GTBCHARGESCREDITS, GTBCHARGESCREDITSTMP );
        GBOREVERSE              :=  TRUE;

        
        UT_TRACE.TRACE('gtbChargesCredits.count ' || GTBCHARGESCREDITS.COUNT, 2);
        NUIDX   :=  GTBCHARGESCREDITS.FIRST;
        
        WHILE (NUIDX IS NOT NULL) LOOP

            UT_TRACE.TRACE('gtbChargesCredits(nuIdx).BILL_ACCOUNT_ID ' || GTBCHARGESCREDITS(NUIDX).BILL_ACCOUNT_ID, 2);
            UT_TRACE.TRACE('gtbChargesCredits(nuIdx).PRODUCT_ID ' || GTBCHARGESCREDITS(NUIDX).PRODUCT_ID, 2);
            UT_TRACE.TRACE('gtbChargesCredits(nuIdx).CHARGE_VALUE ' || GTBCHARGESCREDITS(NUIDX).CHARGE_VALUE, 2);
            
            DISTRIBUTECREDITADJUST
            (
                GTBCHARGESSUBTOTAL,
                GTBCHARGESDEFERRED,
                GNUADJUSTCONCEPT,
                GTBCHARGESCREDITS(NUIDX).CHARGE_VALUE,
                GTBCHARGESCREDITS(NUIDX).PRODUCT_ID,
                GTBCHARGESCREDITS(NUIDX).BILL_ACCOUNT_ID
            );
            NUIDXTMP    :=  NUIDX;
            NUIDX   :=  GTBCHARGESCREDITS.NEXT(NUIDX);
            
            
            UT_TRACE.TRACE('Se elimina el registro ' || GTBCHARGESCREDITS(NUIDXTMP).ROW_NUMBER_ || 'gtbChargesSubTotal', 2);
            GTBCHARGESSUBTOTAL.DELETE(GTBCHARGESCREDITS(NUIDXTMP).ROW_NUMBER_);
            UT_TRACE.TRACE('Se elimina el registro ' || NUIDXTMP || 'gtbChargesCredits', 2);
            GTBCHARGESCREDITS.DELETE(NUIDXTMP);
            UT_TRACE.TRACE('Registros eliminados ', 2);
        END LOOP;

        UT_TRACE.TRACE( 'Fin: [GC_BODebtNegoCharge.DistributeCredits]', 2 );
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error GC_BODebtNegoCharge.DistributeCredits ', 2);
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END DISTRIBUTECREDITS;
    
    












    PROCEDURE COPYCHARGESTABLE
    (
        ITBCHARGESORIGINAL  IN          MO_TYTBCHARGES,
        ITBCHARGESCOPY      IN  OUT     MO_TYTBCHARGES
    )
    IS
        NUIDX       BINARY_INTEGER;
        RCCHARGE    MO_TYOBCHARGES;
    BEGIN
        UT_TRACE.TRACE( 'Inicio: [GC_BODebtNegoCharge.CopyChargesTable]', 2 );

        ITBCHARGESCOPY.DELETE;
        
        NUIDX   :=  ITBCHARGESORIGINAL.FIRST;
        
        WHILE (NUIDX IS NOT NULL) LOOP

            RCCHARGE := MO_TYOBCHARGES
            (
                ITBCHARGESORIGINAL(NUIDX).BILL_ACCOUNT_ID,
                ITBCHARGESORIGINAL(NUIDX).PRODUCT_ID,
                ITBCHARGESORIGINAL(NUIDX).PRODUCT_TYPE_ID,
                ITBCHARGESORIGINAL(NUIDX).CONCEPT_ID,
                ITBCHARGESORIGINAL(NUIDX).CHARGE_CAUSE,
                ITBCHARGESORIGINAL(NUIDX).SIGN_,
                ITBCHARGESORIGINAL(NUIDX).BILLING_PERIOD,
                ITBCHARGESORIGINAL(NUIDX).CHARGE_VALUE,
                ITBCHARGESORIGINAL(NUIDX).DOCUMENT_SUPPORT,
                ITBCHARGESORIGINAL(NUIDX).DOCUMENT_ID,
                ITBCHARGESORIGINAL(NUIDX).PROCESS_TYPE,
                ITBCHARGESORIGINAL(NUIDX).UNITS,
                ITBCHARGESORIGINAL(NUIDX).CREATION_DATE,
                ITBCHARGESORIGINAL(NUIDX).PROGRAM,
                ITBCHARGESORIGINAL(NUIDX).CALL_SEQUENCE,
                ITBCHARGESORIGINAL(NUIDX).OUTSIDER_MONEY_VALUE,
                ITBCHARGESORIGINAL(NUIDX).BALANCE,
                ITBCHARGESORIGINAL(NUIDX).ORIGINAL_BALANCE,
                ITBCHARGESORIGINAL(NUIDX).LIST_DIST_CREDITS,
                ITBCHARGESORIGINAL(NUIDX).ROW_NUMBER_,
                ITBCHARGESORIGINAL(NUIDX).IS_DISCOUNT,
                ITBCHARGESORIGINAL(NUIDX).DISCOUNT_PERCENTAGE,
                ITBCHARGESORIGINAL(NUIDX).USERNAME
            );
            
            ITBCHARGESCOPY.EXTEND;
            ITBCHARGESCOPY(ITBCHARGESCOPY.LAST) := RCCHARGE;
            
            NUIDX   :=  ITBCHARGESORIGINAL.NEXT(NUIDX);
        END LOOP;

        UT_TRACE.TRACE( 'Fin: [GC_BODebtNegoCharge.CopyChargesTable]', 2 );
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error GC_BODebtNegoCharge.CopyChargesTable ', 2);
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END COPYCHARGESTABLE;
    
    



















    PROCEDURE SETPUNISHCHARGES
    (
        INUPRODUCTID                IN          SERVSUSC.SESUNUSE%TYPE,
        ITBPUNISHCHARGES            IN          PKBCCHARGES.TYTBREACCHARGES,
        ONUPUNISHBALANCE            OUT         NUMBER
    )
    IS
        
        NUINDNEWCHARGES         NUMBER;

        
        NUSIGN                  NUMBER := PKBILLCONST.CNUSUMA_CARGO;
        
        
        RCCHARGES               TYRCCHARGESBYPROD;
        
        
        TBPUNISHCHARGES         PKBCCHARGES.TYTBREACCHARGES;

    BEGIN
        UT_TRACE.TRACE('INICIA GC_BODebtNegoCharges.SetPunishCharges ['||INUPRODUCTID||']['||ITBPUNISHCHARGES.COUNT||']',CNUTRACE_LEVEL);

        
        ONUPUNISHBALANCE := 0.0;

        
        NUINDNEWCHARGES:=  ITBPUNISHCHARGES.FIRST;

        WHILE ( NUINDNEWCHARGES IS NOT NULL ) LOOP
            UT_TRACE.TRACE('carg ['||ITBPUNISHCHARGES(NUINDNEWCHARGES).NUCHARGECONC||']['||
                       ITBPUNISHCHARGES(NUINDNEWCHARGES).NUCHARGEVALUE||']['||
                       ITBPUNISHCHARGES(NUINDNEWCHARGES).SBSIGN||']'||
                       ITBPUNISHCHARGES(NUINDNEWCHARGES).NUACCOUNT||']',CNUTRACE_LEVEL);
            
            IF ( ITBPUNISHCHARGES( NUINDNEWCHARGES ).SBSIGN
            IN ( PKBILLCONST.DEBITO, PKBILLCONST.CREDITO )
            AND  ITBPUNISHCHARGES(NUINDNEWCHARGES).NUCHARGEVALUE > 0)
            THEN

                
                IF ( ITBPUNISHCHARGES(NUINDNEWCHARGES).SBSIGN = PKBILLCONST.CREDITO ) THEN
                    
                    NUSIGN := PKBILLCONST.CNURESTA_CARGO;
                ELSE
                    
                    NUSIGN := PKBILLCONST.CNUSUMA_CARGO;
                END IF;

                
                ONUPUNISHBALANCE := ONUPUNISHBALANCE + ITBPUNISHCHARGES(NUINDNEWCHARGES).NUCHARGEVALUE * NUSIGN;
                
                TBPUNISHCHARGES(NUINDNEWCHARGES) := ITBPUNISHCHARGES(NUINDNEWCHARGES);
            END IF;

            NUINDNEWCHARGES := ITBPUNISHCHARGES.NEXT(NUINDNEWCHARGES);
        END LOOP;

        RCCHARGES.NUPRODUCTID := INUPRODUCTID;
        RCCHARGES.TBCHARGES := TBPUNISHCHARGES;
        
        GTBCHARGESPUNISHBAL(INUPRODUCTID) := RCCHARGES;
        
        UT_TRACE.TRACE('FIN GC_BODebtNegoCharges.SetPunishCharges '||TBPUNISHCHARGES.COUNT, CNUTRACE_LEVEL);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETPUNISHCHARGES;
    
    















    PROCEDURE GETPUNISHCHARGES
    (
        INUPRODUCTID                IN          SERVSUSC.SESUNUSE%TYPE,
        OTBPUNISHCHARGES            OUT         PKBCCHARGES.TYTBREACCHARGES
    )
    IS
    BEGIN
        UT_TRACE.TRACE('INICIA GC_BODebtNegoCharges.GetPunishCharges ['||INUPRODUCTID||']',CNUTRACE_LEVEL);

        IF(GTBCHARGESPUNISHBAL.EXISTS(INUPRODUCTID)) THEN
            OTBPUNISHCHARGES := GTBCHARGESPUNISHBAL(INUPRODUCTID).TBCHARGES;
        END IF;

        UT_TRACE.TRACE('FIN GC_BODebtNegoCharges.GetPunishCharges '||OTBPUNISHCHARGES.COUNT, CNUTRACE_LEVEL);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETPUNISHCHARGES;

    












    PROCEDURE INITCHARGESREACTIVE
    IS
    BEGIN
        UT_TRACE.TRACE( 'Inicio: [GC_BODebtNegoCharge.InitChargesReactive]', 2 );

        GTBCHARGESREACTIVE.DELETE;
        GTBCHARGESREACTIVE := MO_TYTBCHARGES();
        
        UT_TRACE.TRACE( 'Fin: [GC_BODebtNegoCharge.InitChargesReactive]', 2 );
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error GC_BODebtNegoCharge.InitChargesReactive ', 2);
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END INITCHARGESREACTIVE;
    
    

















    PROCEDURE CONVERTCHARGES
    (
        INUPRODUCTID          IN          PR_PRODUCT.PRODUCT_ID%TYPE,
        ITBCHARGES            IN          PKBCCHARGES.TYTBREACCHARGES,
        OTBCHARGES            OUT         MO_TYTBCHARGES
    )
    IS
        
        NUINDNEWCHARGES         NUMBER;

        
        RCCHARGE                MO_TYOBCHARGES;

        
        NUSIGN                  NUMBER := PKBILLCONST.CNUSUMA_CARGO;

        
        NUPRODTYPEID            SERVICIO.SERVCODI%TYPE;

    BEGIN
        UT_TRACE.TRACE('INICIA GC_BODebtNegoCharges.ConvertCharges',CNUTRACE_LEVEL);

        
        NUPRODTYPEID := CC_BCFINANCING.FNUPRODUCTTYPE(INUPRODUCTID);

        
        OTBCHARGES := MO_TYTBCHARGES();

        
        NUINDNEWCHARGES:=  ITBCHARGES.FIRST;

        WHILE ( NUINDNEWCHARGES IS NOT NULL ) LOOP

            IF ( ITBCHARGES( NUINDNEWCHARGES ).SBSIGN
            IN ( PKBILLCONST.DEBITO, PKBILLCONST.CREDITO ) )
            THEN

                
                IF ( ITBCHARGES(NUINDNEWCHARGES).SBSIGN = PKBILLCONST.CREDITO ) THEN
                    
                    NUSIGN := PKBILLCONST.CNURESTA_CARGO;
                ELSE
                    
                    NUSIGN := PKBILLCONST.CNUSUMA_CARGO;
                END IF;

                
                RCCHARGE := MO_TYOBCHARGES
                (
                    ITBCHARGES(NUINDNEWCHARGES).NUACCOUNT,         
                    INUPRODUCTID,                                       
                    NUPRODTYPEID,                                       
                    ITBCHARGES(NUINDNEWCHARGES).NUCHARGECONC,      
                    ITBCHARGES(NUINDNEWCHARGES).NUCHARGECAUSE,     
                    ITBCHARGES(NUINDNEWCHARGES).SBSIGN,            
                    PKCONSTANTE.NULLNUM,                                
                    ITBCHARGES(NUINDNEWCHARGES).NUCHARGEVALUE,     
                    ITBCHARGES(NUINDNEWCHARGES).SBSUPPORTDOC,      
                    PKCONSTANTE.NULLNUM,                                
                    NULL,                                               
                    NULL,                                               
                    SYSDATE,                                            
                    NULL,                                               
                    NULL,                                               
                    ITBCHARGES(NUINDNEWCHARGES).NUBASECHVALUE,     
                    ITBCHARGES(NUINDNEWCHARGES).NUCHARGEVALUE*NUSIGN, 
                    ITBCHARGES(NUINDNEWCHARGES).NUCHARGEVALUE*NUSIGN, 
                    NULL,                                                  
                    NUINDNEWCHARGES,                                            
                    GE_BOCONSTANTS.CSBNO,                               
                    PKBILLCONST.CERO,                                   
                    CSBREACTIV_CHARGE                                   
                );

                OTBCHARGES.EXTEND;
                OTBCHARGES(OTBCHARGES.LAST) := RCCHARGE;

            END IF;

            NUINDNEWCHARGES := ITBCHARGES.NEXT(NUINDNEWCHARGES);
        END LOOP;

        UT_TRACE.TRACE('FIN GC_BODebtNegoCharges.ConvertCharges ', CNUTRACE_LEVEL);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CONVERTCHARGES;
    
    






















    PROCEDURE GROUPCHARGESBYACC
    (
        ITBCHARGES            IN          PKBCCHARGES.TYTBREACCHARGES,
        OTBCHARGES            OUT         TYTBCHARGESBYACC
    )
    IS
        
        NUINDNEWCHARGES         NUMBER;
        
        NUSIGN                  NUMBER := PKBILLCONST.CNUSUMA_CARGO;
        
        NUACCOUNTID             CUENCOBR.CUCOCODI%TYPE;
        
        NUVALUE                 CARGOS.CARGVALO%TYPE;
        
        RCCHARGESBYACC          TYRCCHARGESBYACC;
        
        NUINDEX                 NUMBER;
        
        
        TYPE TYTBPOSACCOUNT     IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
        TBPOSACCOUNT            TYTBPOSACCOUNT;
    BEGIN
        UT_TRACE.TRACE('INICIA GC_BODebtNegoCharges.GroupChargesByAcc',CNUTRACE_LEVEL);

        
        NUINDNEWCHARGES:=  ITBCHARGES.FIRST;
        
        NUINDEX := 1;

        WHILE ( NUINDNEWCHARGES IS NOT NULL ) LOOP

            IF ( ITBCHARGES( NUINDNEWCHARGES ).SBSIGN
            IN ( PKBILLCONST.DEBITO, PKBILLCONST.CREDITO ) )
            THEN
                
                IF ( ITBCHARGES(NUINDNEWCHARGES).SBSIGN = PKBILLCONST.CREDITO ) THEN
                    
                    NUSIGN := PKBILLCONST.CNURESTA_CARGO;
                ELSE
                    
                    NUSIGN := PKBILLCONST.CNUSUMA_CARGO;
                END IF;

                NUACCOUNTID     := ITBCHARGES(NUINDNEWCHARGES).NUACCOUNT;
                NUVALUE         := ITBCHARGES(NUINDNEWCHARGES).NUCHARGEVALUE*NUSIGN;
                RCCHARGESBYACC  := NULL;
                
                UT_TRACE.TRACE('nuAccountId '||NUACCOUNTID||' nuValue '||NUVALUE, CNUTRACE_LEVEL);
                
                IF(TBPOSACCOUNT.EXISTS(NUACCOUNTID)) THEN

                    RCCHARGESBYACC := OTBCHARGES(TBPOSACCOUNT(NUACCOUNTID));
                    RCCHARGESBYACC.TBCHARGES(RCCHARGESBYACC.TBCHARGES.COUNT) := ITBCHARGES(NUINDNEWCHARGES);
                    RCCHARGESBYACC.NUVALUE := RCCHARGESBYACC.NUVALUE + NUVALUE;
                    
                    OTBCHARGES(TBPOSACCOUNT(NUACCOUNTID)) := RCCHARGESBYACC;
                ELSE
                
                    RCCHARGESBYACC.NUACCOUNTID := NUACCOUNTID;
                    RCCHARGESBYACC.NUVALUE := NUVALUE;
                    RCCHARGESBYACC.TBCHARGES(RCCHARGESBYACC.TBCHARGES.COUNT) := ITBCHARGES(NUINDNEWCHARGES);
                    
                    OTBCHARGES(NUINDEX) := RCCHARGESBYACC;
                    
                    TBPOSACCOUNT(NUACCOUNTID) := NUINDEX;
                    NUINDEX := NUINDEX + 1;
                END IF;
            END IF;

            NUINDNEWCHARGES := ITBCHARGES.NEXT(NUINDNEWCHARGES);
        END LOOP;

        UT_TRACE.TRACE('FIN GC_BODebtNegoCharges.GroupChargesByAcc '||OTBCHARGES.COUNT, CNUTRACE_LEVEL);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GROUPCHARGESBYACC;
    
    





















    PROCEDURE DISTVALUEINCHARGES
    (
        INUPRODUCTID                IN          PR_PRODUCT.PRODUCT_ID%TYPE,
        INUVALUE                    IN          NUMBER,
        ITBCHARGES                  IN          PKBCCHARGES.TYTBREACCHARGES,
        OTBDISTCHARGES              OUT         PKBCCHARGES.TYTBREACCHARGES
    )
    IS
        RCCHARGE                PKBCCHARGES.TYRCREACCHARGE;

        
        NUINDCHARGES            NUMBER;
        
        
        TBCARGDIST              PKCONCEPTVALUESMGR.TYTBCARGOSDIST;
        TBSBSTRKEY              PKCONCEPTVALUESMGR.TYSTRING;
        TBNUDISTRVALBYCONCEPT   PKCONCEPTVALUESMGR.TYNUMBER;
        TBNUDISTRVBLBYCONCEPT   PKCONCEPTVALUESMGR.TYNUMBER;
        RCKEYDATA               PKCONCEPTVALUESMGR.RTYDATAKEYCTA;
        
        SBINDK                  VARCHAR2(100);
        NUINDDIS                NUMBER;
        
        NUCHARGECAUSE           CARGOS.CARGCACA%TYPE;
        NUACCOUNT               CARGOS.CARGCUCO%TYPE;
        SBSUPPORTDOC            CARGOS.CARGDOSO%TYPE;
    BEGIN
        UT_TRACE.TRACE('INICIA GC_BODebtNegoCharges.DistValueInCharges ['||INUVALUE||']',CNUTRACE_LEVEL);

        NUINDDIS := 1;
        NUINDCHARGES := ITBCHARGES.FIRST;

        WHILE (NUINDCHARGES IS NOT NULL) LOOP
        
            RCCHARGE := ITBCHARGES(NUINDCHARGES);
            
            TBCARGDIST(NUINDDIS).CARGTERM := PKCONCEPTVALUESMGR.FSBKEY(TO_CHAR(RCCHARGE.NUCHARGECONC),1);
            TBCARGDIST(NUINDDIS).CARGSIGN := RCCHARGE.SBSIGN;
            TBCARGDIST(NUINDDIS).CARGVALO := RCCHARGE.NUCHARGEVALUE;
            TBCARGDIST(NUINDDIS).CARGVABL := RCCHARGE.NUBASECHVALUE;
            
            TBCARGDIST(NUINDDIS).CARGFECR := TRUNC(SYSDATE);
            TBCARGDIST(NUINDDIS).CARGFLFA := GE_BOCONSTANTS.CSBNO;

            NUINDCHARGES := ITBCHARGES.NEXT(NUINDCHARGES);
            
            NUINDDIS := NUINDDIS + 1;
            
            NUCHARGECAUSE   := RCCHARGE.NUCHARGECAUSE;
            NUACCOUNT       := RCCHARGE.NUACCOUNT;
            SBSUPPORTDOC    := RCCHARGE.SBSUPPORTDOC;
        END LOOP;
        
        
        TBCARGDIST(NUINDDIS).CARGSIGN := PKBILLCONST.PAGO;
        TBCARGDIST(NUINDDIS).CARGVALO := INUVALUE;
        TBCARGDIST(NUINDDIS).CARGVABL := 0;
        TBCARGDIST(NUINDDIS).CARGFECR := SYSDATE;
        TBCARGDIST(NUINDDIS).CARGFLFA := PKCONSTANTE.SI;
        
        UT_TRACE.TRACE('Cantidad cargos a distribuir + pago ['||TBCARGDIST.COUNT||']',CNUTRACE_LEVEL);
        
        PKCONCEPTVALUESMGR.GETPAYMENTBYCONC
        (
            INUPRODUCTID,
            TBCARGDIST,
            TBSBSTRKEY,
            TBNUDISTRVALBYCONCEPT,
            TBNUDISTRVBLBYCONCEPT,
            1,
            0,
            TRUE
        );
        
        UT_TRACE.TRACE('Cantidad cargos distribuidos ['||TBSBSTRKEY.COUNT||']',CNUTRACE_LEVEL);
        
        SBINDK := TBSBSTRKEY.FIRST;

        LOOP
        
            EXIT WHEN SBINDK IS NULL;

            PKCONCEPTVALUESMGR.DECODEKEY(TBSBSTRKEY(SBINDK),RCKEYDATA);

            NUINDDIS := OTBDISTCHARGES.COUNT;
            
            OTBDISTCHARGES(NUINDDIS).NUCHARGECONC   := TO_NUMBER(RCKEYDATA.SBROWID);
            OTBDISTCHARGES(NUINDDIS).NUCHARGEVALUE  := ABS(TBNUDISTRVALBYCONCEPT(SBINDK));
            OTBDISTCHARGES(NUINDDIS).NUBASECHVALUE  := ABS(TBNUDISTRVBLBYCONCEPT(SBINDK));
            OTBDISTCHARGES(NUINDDIS).NUACCOUNT      := NUACCOUNT;
            OTBDISTCHARGES(NUINDDIS).NUCHARGECAUSE  := NUCHARGECAUSE;
            OTBDISTCHARGES(NUINDDIS).SBSUPPORTDOC   := SBSUPPORTDOC;

            IF(TBNUDISTRVALBYCONCEPT(SBINDK) > 0) THEN
                OTBDISTCHARGES(NUINDDIS).SBSIGN := PKBILLCONST.DEBITO;
            ELSE
                OTBDISTCHARGES(NUINDDIS).SBSIGN := PKBILLCONST.CREDITO;
            END IF;

            SBINDK := TBSBSTRKEY.NEXT(SBINDK);
        
        END LOOP;

        UT_TRACE.TRACE('FIN GC_BODebtNegoCharges.DistValueInCharges ', CNUTRACE_LEVEL);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END DISTVALUEINCHARGES;
    
    


















    PROCEDURE DISTREACTCHARGES
    (
        INUPRODUCTID                IN          SERVSUSC.SESUNUSE%TYPE,
        INUREACTVALUE               IN          NUMBER,
        ITBPUNISHCHARGES            IN          PKBCCHARGES.TYTBREACCHARGES,
        OTBDISTCHARGES              OUT         PKBCCHARGES.TYTBREACCHARGES
    )
    IS
        RCCHARGE                PKBCCHARGES.TYRCREACCHARGE;
        RCCHARGESBYACC          TYRCCHARGESBYACC;

        TBCHARGES               PKBCCHARGES.TYTBREACCHARGES;
        TBSORTCHARGES           PKBCCHARGES.TYTBREACCHARGES;
        TBGROUPCHARGES          TYTBCHARGESBYACC;
        TBTMPCHARGES            MO_TYTBCHARGES;
        
        
        NUINDCHARGES            NUMBER;
        
        NUINDACCOUNT            NUMBER;
        
        NUREACTVALUE            NUMBER := 0.0;
    BEGIN
        UT_TRACE.TRACE('INICIA GC_BODebtNegoCharges.DistReactCharges ['||INUPRODUCTID||']['||INUREACTVALUE||']',CNUTRACE_LEVEL);

        
        
        CONVERTCHARGES(INUPRODUCTID, ITBPUNISHCHARGES, TBTMPCHARGES);

        
        
        GC_BCDEBTNEGOTIATION.SORTCHARGESBYACCOUNT(TBTMPCHARGES, TBSORTCHARGES);
        
        GROUPCHARGESBYACC(TBSORTCHARGES, TBGROUPCHARGES);
        
        
        NUREACTVALUE := INUREACTVALUE;
        
        
        NUINDACCOUNT :=  TBGROUPCHARGES.FIRST;

        WHILE (NUINDACCOUNT IS NOT NULL AND NUREACTVALUE > 0) LOOP

            RCCHARGESBYACC := TBGROUPCHARGES(NUINDACCOUNT);
            UT_TRACE.TRACE('Cuenta '||RCCHARGESBYACC.NUACCOUNTID||' Valor '||RCCHARGESBYACC.NUVALUE, CNUTRACE_LEVEL);
            
            IF(RCCHARGESBYACC.NUVALUE <= NUREACTVALUE) THEN
                UT_TRACE.TRACE('Se reactiva toda la Cuenta', CNUTRACE_LEVEL);
                
                
                
                TBCHARGES := RCCHARGESBYACC.TBCHARGES;
            ELSE
                UT_TRACE.TRACE('Se realiza distribucci�n', CNUTRACE_LEVEL);
                
                DISTVALUEINCHARGES
                (
                    INUPRODUCTID,
                    NUREACTVALUE,
                    RCCHARGESBYACC.TBCHARGES,
                    TBCHARGES
                );
            END IF;
            
            NUINDCHARGES := TBCHARGES.FIRST;

            WHILE (NUINDCHARGES IS NOT NULL) LOOP
                UT_TRACE.TRACE('nuIndCharges '||NUINDCHARGES, CNUTRACE_LEVEL);
                RCCHARGE := TBCHARGES(NUINDCHARGES);
                
                UT_TRACE.TRACE('Cuenta '||RCCHARGE.NUACCOUNT, CNUTRACE_LEVEL);
                UT_TRACE.TRACE('Concepto '||RCCHARGE.NUCHARGECONC, CNUTRACE_LEVEL);
                UT_TRACE.TRACE('Valor '||RCCHARGE.NUCHARGEVALUE, CNUTRACE_LEVEL);

                OTBDISTCHARGES(OTBDISTCHARGES.COUNT) := RCCHARGE;
                NUINDCHARGES := TBCHARGES.NEXT(NUINDCHARGES);
            END LOOP;
            
            NUREACTVALUE := NUREACTVALUE - RCCHARGESBYACC.NUVALUE;

            NUINDACCOUNT := TBGROUPCHARGES.NEXT(NUINDACCOUNT);
        END LOOP;
        
        UT_TRACE.TRACE('FIN GC_BODebtNegoCharges.DistReactCharges ', CNUTRACE_LEVEL);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END DISTREACTCHARGES;


    






















    PROCEDURE UPDTAXDISCOUNT
    (
        INUPRODUCTID            IN  SERVSUSC.SESUNUSE%TYPE,
        INUACCOUNTID            IN  CUENCOBR.CUCOCODI%TYPE,
        INUCONCEPID             IN  CARGOS.CARGCONC%TYPE,
        INUDISCOUNT             IN  CARGOS.CARGVALO%TYPE,
        ISBSIGN                 IN  CARGOS.CARGSIGN%TYPE,
        ORCTAX                  OUT NOCOPY MO_TYOBCHARGES,
        ONUDISCNOAPPLY          OUT NOCOPY CARGOS.CARGVALO%TYPE
    )
    IS
        NUINDEXCHARGES          NUMBER;
        NUDISCOUNT              CARGOS.CARGVALO%TYPE;

        BLHAVETAX               BOOLEAN := FALSE;
        DTCHARGEDATE            CARGOS.CARGFECR%TYPE := UT_DATE.FDTMAXDATE;
    BEGIN
        UT_TRACE.TRACE('BEGIN GC_BODebtNegoCharges.UpdTaxDiscount',15);
        UT_TRACE.TRACE('Producto['||INUPRODUCTID||'] Cuenta['||INUACCOUNTID||']',15);
        UT_TRACE.TRACE('Concepto['||INUCONCEPID||'] Descuento['||INUDISCOUNT||']',15);
        UT_TRACE.TRACE('Signo['||ISBSIGN||']',15);

        IF(ISBSIGN = PKBILLCONST.CREDITO)
        THEN
            
            NUDISCOUNT := ABS(INUDISCOUNT);
        ELSE
            
            
            NUDISCOUNT := ABS(INUDISCOUNT) * -1;
        END IF;

        UT_TRACE.TRACE('Descuento ['||NUDISCOUNT||']',15);
        UT_TRACE.TRACE('Cargos ['||GTBCHARGESSUBTOTAL.COUNT||']',15);

        NUINDEXCHARGES := GTBCHARGESSUBTOTAL.FIRST;
        LOOP
            EXIT WHEN NUINDEXCHARGES IS NULL;

            UT_TRACE.TRACE('Producto ['||GTBCHARGESSUBTOTAL(NUINDEXCHARGES).PRODUCT_ID||']',15);
            UT_TRACE.TRACE('Cuenta ['||GTBCHARGESSUBTOTAL(NUINDEXCHARGES).BILL_ACCOUNT_ID||']',15);
            UT_TRACE.TRACE('Concepto ['||GTBCHARGESSUBTOTAL(NUINDEXCHARGES).CONCEPT_ID||']',15);
            UT_TRACE.TRACE('Valor ['||GTBCHARGESSUBTOTAL(NUINDEXCHARGES).CHARGE_VALUE||']',15);

            IF( GTBCHARGESSUBTOTAL(NUINDEXCHARGES).PRODUCT_ID = INUPRODUCTID AND
                GTBCHARGESSUBTOTAL(NUINDEXCHARGES).BILL_ACCOUNT_ID = INUACCOUNTID AND
                GTBCHARGESSUBTOTAL(NUINDEXCHARGES).CONCEPT_ID = INUCONCEPID )
            THEN

                IF(GTBCHARGESSUBTOTAL(NUINDEXCHARGES).CHARGE_VALUE >= NUDISCOUNT)
                THEN
                    GTBCHARGESSUBTOTAL(NUINDEXCHARGES).CHARGE_VALUE := GTBCHARGESSUBTOTAL(NUINDEXCHARGES).CHARGE_VALUE - NUDISCOUNT;
                    GTBCHARGESSUBTOTAL(NUINDEXCHARGES).BALANCE := GTBCHARGESSUBTOTAL(NUINDEXCHARGES).BALANCE - NUDISCOUNT;

                    NUDISCOUNT := 0;
                ELSE
                    NUDISCOUNT := NUDISCOUNT - GTBCHARGESSUBTOTAL(NUINDEXCHARGES).CHARGE_VALUE;

                    GTBCHARGESSUBTOTAL(NUINDEXCHARGES).CHARGE_VALUE := 0;
                    GTBCHARGESSUBTOTAL(NUINDEXCHARGES).BALANCE := 0;
                END IF;
                
                UT_TRACE.TRACE('Valor actualizado ['||GTBCHARGESSUBTOTAL(NUINDEXCHARGES).CHARGE_VALUE||']',15);
                UT_TRACE.TRACE('Balance ['||GTBCHARGESSUBTOTAL(NUINDEXCHARGES).CHARGE_VALUE||']',15);
                UT_TRACE.TRACE('Descuento ['||NUDISCOUNT||']',15);
                
                
                IF((NOT BLHAVETAX) OR (DTCHARGEDATE > GTBCHARGESSUBTOTAL(NUINDEXCHARGES).CREATION_DATE) )
                THEN
                    UT_TRACE.TRACE('Se retorna el primer cargo de impuesto',15);
                    ORCTAX := GTBCHARGESSUBTOTAL(NUINDEXCHARGES);
                    BLHAVETAX := TRUE;
                    DTCHARGEDATE := GTBCHARGESSUBTOTAL(NUINDEXCHARGES).CREATION_DATE;
                END IF;
                
            END IF;

            EXIT WHEN NUDISCOUNT = 0;

            NUINDEXCHARGES := GTBCHARGESSUBTOTAL.NEXT(NUINDEXCHARGES);
        END LOOP;

        UT_TRACE.TRACE('Descuento ['||NUDISCOUNT||']',15);

        IF(NUDISCOUNT = 0)
        THEN
            ONUDISCNOAPPLY := NUDISCOUNT;
            UT_TRACE.TRACE('END GC_BODebtNegoCharges.UpdTaxDiscount [Sin Revisar Diferidos]', CNUTRACE_LEVEL);
            RETURN;
        END IF;

        UT_TRACE.TRACE('Diferidos ['||GTBCHARGESDEFERRED.COUNT||']',15);
        
        NUINDEXCHARGES := GTBCHARGESDEFERRED.FIRST;
        LOOP
            EXIT WHEN NUINDEXCHARGES IS NULL;

            UT_TRACE.TRACE('Producto ['||GTBCHARGESDEFERRED(NUINDEXCHARGES).PRODUCT_ID||']',15);
            UT_TRACE.TRACE('Cuenta ['||GTBCHARGESDEFERRED(NUINDEXCHARGES).BILL_ACCOUNT_ID||']',15);
            UT_TRACE.TRACE('Concepto ['||GTBCHARGESDEFERRED(NUINDEXCHARGES).CONCEPT_ID||']',15);
            UT_TRACE.TRACE('Valor ['||GTBCHARGESDEFERRED(NUINDEXCHARGES).CHARGE_VALUE||']',15);
            
            IF( GTBCHARGESDEFERRED(NUINDEXCHARGES).PRODUCT_ID = INUPRODUCTID AND
                GTBCHARGESDEFERRED(NUINDEXCHARGES).BILL_ACCOUNT_ID = INUACCOUNTID AND
                GTBCHARGESDEFERRED(NUINDEXCHARGES).CONCEPT_ID = INUCONCEPID )
            THEN

                IF(GTBCHARGESDEFERRED(NUINDEXCHARGES).CHARGE_VALUE >= NUDISCOUNT)
                THEN
                    GTBCHARGESDEFERRED(NUINDEXCHARGES).CHARGE_VALUE := GTBCHARGESDEFERRED(NUINDEXCHARGES).CHARGE_VALUE - NUDISCOUNT;
                    GTBCHARGESDEFERRED(NUINDEXCHARGES).BALANCE := GTBCHARGESDEFERRED(NUINDEXCHARGES).BALANCE - NUDISCOUNT;

                    NUDISCOUNT := 0;
                ELSE
                    NUDISCOUNT := NUDISCOUNT - GTBCHARGESDEFERRED(NUINDEXCHARGES).CHARGE_VALUE;

                    GTBCHARGESDEFERRED(NUINDEXCHARGES).CHARGE_VALUE := 0;
                    GTBCHARGESDEFERRED(NUINDEXCHARGES).BALANCE := 0;
                END IF;
                
                UT_TRACE.TRACE('Valor actualizado ['||GTBCHARGESDEFERRED(NUINDEXCHARGES).CHARGE_VALUE||']',15);
                UT_TRACE.TRACE('Balance ['||GTBCHARGESDEFERRED(NUINDEXCHARGES).CHARGE_VALUE||']',15);
                UT_TRACE.TRACE('Descuento ['||NUDISCOUNT||']',15);
                
                
                IF((NOT BLHAVETAX) OR (DTCHARGEDATE > GTBCHARGESDEFERRED(NUINDEXCHARGES).CREATION_DATE) )
                THEN
                    UT_TRACE.TRACE('Se retorna el primer cargo de impuesto',15);
                    ORCTAX := GTBCHARGESDEFERRED(NUINDEXCHARGES);
                    BLHAVETAX := TRUE;
                    DTCHARGEDATE := GTBCHARGESDEFERRED(NUINDEXCHARGES).CREATION_DATE;
                END IF;
            END IF;

            EXIT WHEN NUDISCOUNT = 0;

            NUINDEXCHARGES := GTBCHARGESDEFERRED.NEXT(NUINDEXCHARGES);
        END LOOP;
        
        ONUDISCNOAPPLY := NUDISCOUNT;
        UT_TRACE.TRACE('Descuento no aplicado ['||ONUDISCNOAPPLY||']',15);
        UT_TRACE.TRACE('END GC_BODebtNegoCharges.UpdTaxDiscount [Revisa Diferidos]', CNUTRACE_LEVEL);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDTAXDISCOUNT;

    







































    PROCEDURE GENTAXBYACCOUNT
    (
        IRCPRODUCT              IN  SERVSUSC%ROWTYPE,
        INUACCOUNTID            IN  CUENCOBR.CUCOCODI%TYPE,
        ITBDISCOUNTS            IN  MO_TYTBCHARGES,
        IOTBTAXDISCOUNTS        IN  OUT NOCOPY MO_TYTBCHARGES
    )
    IS
        NUINDEXCHARGE           NUMBER;

        TBCHARGESPROC           PKBORATINGMEMORYMGR.TYTBLIQCHARGES;
        NUINDEXCHPROC           NUMBER;

        NUTAXVALUEDEFER         CARGOS.CARGVALO%TYPE;
        NUTAXVALUENODEFER       CARGOS.CARGVALO%TYPE;

        TBTAXCHARGES            PKBORATINGMEMORYMGR.TYTBLIQCHARGES;
        NUINDEXTAX              NUMBER;
        SBSIGN                  CARGOS.CARGSIGN%TYPE;

        NUBILLID                FACTURA.FACTCODI%TYPE;
        NUPEFACODI              FACTURA.FACTPEFA%TYPE;
        
        RCTAX                   MO_TYOBCHARGES;
        NUDISCNOAPPLY           CARGOS.CARGVALO%TYPE;
    BEGIN
        UT_TRACE.TRACE('BEGIN GC_BODebtNegoCharges.GenTaxByAccount',15);
        UT_TRACE.TRACE('Producto['||IRCPRODUCT.SESUNUSE||'] Cuenta['||INUACCOUNTID||']',15);

        UT_TRACE.TRACE('Descuentos ['||ITBDISCOUNTS.COUNT||']',15);
        
        NUINDEXCHARGE := ITBDISCOUNTS.FIRST;
        LOOP
            EXIT WHEN NUINDEXCHARGE IS NULL;

            NUINDEXCHPROC := TBCHARGESPROC.COUNT;

            
            TBCHARGESPROC(NUINDEXCHPROC).NUCONCEPT  := ITBDISCOUNTS(NUINDEXCHARGE).CONCEPT_ID;
            TBCHARGESPROC(NUINDEXCHPROC).SBDOCUSOPO := ITBDISCOUNTS(NUINDEXCHARGE).DOCUMENT_SUPPORT;

            IF(ITBDISCOUNTS(NUINDEXCHARGE).SIGN_ = PKBILLCONST.DEBITO)
            THEN
                TBCHARGESPROC(NUINDEXCHPROC).NUVALUE    := ITBDISCOUNTS(NUINDEXCHARGE).CHARGE_VALUE;
            ELSE
                TBCHARGESPROC(NUINDEXCHPROC).NUVALUE    := ITBDISCOUNTS(NUINDEXCHARGE).CHARGE_VALUE * -1;
            END IF;
            
            UT_TRACE.TRACE('Concepto[' ||TBCHARGESPROC(NUINDEXCHPROC).NUCONCEPT||'] Valor['||TBCHARGESPROC(NUINDEXCHPROC).NUVALUE||']',15);

            NUINDEXCHARGE := ITBDISCOUNTS.NEXT(NUINDEXCHARGE);
        END LOOP;

        IF(INUACCOUNTID != PKCONSTANTE.NULLNUM)
        THEN
            
            NUBILLID := PKTBLCUENCOBR.FNUGETCUCOFACT(INUACCOUNTID);
            NUPEFACODI := PKTBLFACTURA.FNUGETFACTPEFA(NUBILLID);
        ELSE
            NUBILLID := NULL;
            NUPEFACODI := NULL;
        END IF;

        
        PKTAXESMGR.GETTAXVALUEWITHROUND
        (
            IRCPRODUCT,
            NUPEFACODI,
            TBCHARGESPROC,
            NUTAXVALUEDEFER,
            NUTAXVALUENODEFER,
            TBTAXCHARGES
        );
        
        UT_TRACE.TRACE('Cantidad de Impuestos[' ||TBTAXCHARGES.COUNT||'] ',15);

        
        
        NUINDEXTAX :=  TBTAXCHARGES.FIRST;
        LOOP
            EXIT WHEN NUINDEXTAX IS NULL;

            IF(TBTAXCHARGES(NUINDEXTAX).NUVALUE != 0)
            THEN
                IF(TBTAXCHARGES(NUINDEXTAX).NUVALUE >= 0)
                THEN
                    SBSIGN := PKBILLCONST.DEBITO;
                ELSE
                    SBSIGN := PKBILLCONST.CREDITO;
                END IF;

                UT_TRACE.TRACE('Impuesto Concepto[' ||TBTAXCHARGES(NUINDEXTAX).NUCONCEPT||'] ',15);
                UT_TRACE.TRACE('Impuesto Valor[' ||TBTAXCHARGES(NUINDEXTAX).NUVALUE||'] ',15);
                UT_TRACE.TRACE('Impuesto Valor Base[' ||TBTAXCHARGES(NUINDEXTAX).NUBASEVAL||'] ',15);
                UT_TRACE.TRACE('Impuesto Documento de Soporte[' ||TBTAXCHARGES(NUINDEXTAX).SBDOCUSOPO||'] ',15);

                UPDTAXDISCOUNT
                (
                    IRCPRODUCT.SESUNUSE,
                    INUACCOUNTID,
                    TBTAXCHARGES(NUINDEXTAX).NUCONCEPT,
                    ABS(TBTAXCHARGES(NUINDEXTAX).NUVALUE),
                    SBSIGN,
                    RCTAX,
                    NUDISCNOAPPLY
                );

                UT_TRACE.TRACE('Impuesto CHARGE_CAUSE[' ||RCTAX.CHARGE_CAUSE||'] ',15);
                UT_TRACE.TRACE('Impuesto DOCUMENT_SUPPORT[' ||RCTAX.DOCUMENT_SUPPORT||'] ',15);
                UT_TRACE.TRACE('Impuesto DOCUMENT_ID[' ||RCTAX.DOCUMENT_ID||'] ',15);

                IOTBTAXDISCOUNTS.EXTEND;
                IOTBTAXDISCOUNTS(IOTBTAXDISCOUNTS.LAST) := MO_TYOBCHARGES
                (
                    INUACCOUNTID,                                           
                    IRCPRODUCT.SESUNUSE,                                    
                    IRCPRODUCT.SESUSERV,                                    
                    TBTAXCHARGES(NUINDEXTAX).NUCONCEPT,                     
                    NVL(RCTAX.CHARGE_CAUSE,PKCONSTANTE.NULLNUM),            
                    SBSIGN,                                                 
                    COALESCE(NUPEFACODI, COALESCE(RCTAX.BILLING_PERIOD, PKCONSTANTE.NULLNUM)),                  
                    ABS(TBTAXCHARGES(NUINDEXTAX).NUVALUE) - NUDISCNOAPPLY,  
                    NVL(RCTAX.DOCUMENT_SUPPORT,PKCONSTANTE.NULLNUM),        
                    NVL(RCTAX.DOCUMENT_ID,PKCONSTANTE.NULLNUM),             
                    NULL,                                                   
                    NULL,                                                   
                    SYSDATE,                                                
                    NULL,                                                   
                    NULL,                                                   
                    ABS(TBTAXCHARGES(NUINDEXTAX).NUBASEVAL),                
                    ABS(TBTAXCHARGES(NUINDEXTAX).NUVALUE) - NUDISCNOAPPLY,  
                    ABS(TBTAXCHARGES(NUINDEXTAX).NUVALUE) - NUDISCNOAPPLY,  
                    NULL,                                                   
                    NULL,                                                   
                    GE_BOCONSTANTS.CSBYES,                                  
                    NULL,                                                   
                    NULL                                                    
                );
                
                
                GTBUPDATEDTAXES.EXTEND;
                GTBUPDATEDTAXES(GTBUPDATEDTAXES.COUNT) := GE_TYOBNUMBER(TBTAXCHARGES(NUINDEXTAX).NUCONCEPT);
            
            END IF;

            NUINDEXTAX :=  TBTAXCHARGES.NEXT(NUINDEXTAX);
        END LOOP;

        UT_TRACE.TRACE('END GC_BODebtNegoCharges.GenTaxByAccount',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('CONTROLLED_ERROR GC_BODebtNegoCharges.GenTaxByAccount',15);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('others GC_BODebtNegoCharges.GenTaxByAccount',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GENTAXBYACCOUNT;

    



















    PROCEDURE GENTAXVALUES
    (
        IRCPRODUCT              IN  SERVSUSC%ROWTYPE,
        ITBDISCBYACCOUNT        IN  TYTBCHARGBYACCOUNT,
        IOTBTAXDISCOUNTS        IN  OUT NOCOPY MO_TYTBCHARGES
    )
    IS
        NUACCOUNTID             CUENCOBR.CUCOCODI%TYPE;
        NUINDEXCHARGE           NUMBER;
    BEGIN
        UT_TRACE.TRACE('BEGIN GC_BODebtNegoCharges.GenTaxValues',15);
        UT_TRACE.TRACE('Descuentos ['||ITBDISCBYACCOUNT.COUNT||']',15);
        
        NUACCOUNTID := ITBDISCBYACCOUNT.FIRST;
        LOOP
            EXIT WHEN NUACCOUNTID IS NULL;

            GENTAXBYACCOUNT
            (
                IRCPRODUCT,
                NUACCOUNTID,
                ITBDISCBYACCOUNT(NUACCOUNTID),
                IOTBTAXDISCOUNTS
            );

            NUACCOUNTID := ITBDISCBYACCOUNT.NEXT(NUACCOUNTID);
        END LOOP;

        UT_TRACE.TRACE('END GC_BODebtNegoCharges.GenTaxValues',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GENTAXVALUES;

    























    PROCEDURE GROUPDISCOUNTS
    (
        ITBDISCOUNTCHARGES      IN  MO_TYTBCHARGES,
        OTBDISCBYACCOUNT        OUT TYTBCHARGBYACCOUNT
    )
    IS
        NUINDEXDISCOUNT         NUMBER;
        NUACCOUNTID             CUENCOBR.CUCOCODI%TYPE;

        NUINDEXACCDISC          NUMBER;
    BEGIN
        UT_TRACE.TRACE('BEGIN GC_BODebtNegoCharges.GroupDiscounts',15);

        UT_TRACE.TRACE('Descuentos ['||ITBDISCOUNTCHARGES.COUNT||']',15);
        
        NUINDEXDISCOUNT := ITBDISCOUNTCHARGES.FIRST;
        LOOP
            EXIT WHEN NUINDEXDISCOUNT IS NULL;
            
            UT_TRACE.TRACE('Valor ['||ITBDISCOUNTCHARGES(NUINDEXDISCOUNT).CHARGE_VALUE||']',15);
            UT_TRACE.TRACE('Documento ['||ITBDISCOUNTCHARGES(NUINDEXDISCOUNT).DOCUMENT_SUPPORT||']',15);
            
            IF(ITBDISCOUNTCHARGES(NUINDEXDISCOUNT).CHARGE_VALUE > 0
               AND INSTR(ITBDISCOUNTCHARGES(NUINDEXDISCOUNT).DOCUMENT_SUPPORT, PKBILLCONST.CSBTOKEN_DIFERIDO) = 0)
            THEN
            
                NUACCOUNTID := ITBDISCOUNTCHARGES(NUINDEXDISCOUNT).BILL_ACCOUNT_ID;
                NUACCOUNTID := NVL(NUACCOUNTID, PKCONSTANTE.NULLNUM);
                
                UT_TRACE.TRACE('BILL_ACCOUNT_ID ['||NUACCOUNTID||']',15);
                UT_TRACE.TRACE('CONCEPT_ID ['||ITBDISCOUNTCHARGES(NUINDEXDISCOUNT).CONCEPT_ID||']',15);
                UT_TRACE.TRACE('CHARGE_VALUE ['||ITBDISCOUNTCHARGES(NUINDEXDISCOUNT).CHARGE_VALUE||']',15);
                UT_TRACE.TRACE('BALANCE ['||ITBDISCOUNTCHARGES(NUINDEXDISCOUNT).BALANCE||']',15);

                IF(NOT OTBDISCBYACCOUNT.EXISTS(NUACCOUNTID))
                THEN
                    OTBDISCBYACCOUNT(NUACCOUNTID) := MO_TYTBCHARGES();
                END IF;

                OTBDISCBYACCOUNT(NUACCOUNTID).EXTEND;
                OTBDISCBYACCOUNT(NUACCOUNTID)(OTBDISCBYACCOUNT(NUACCOUNTID).LAST) := ITBDISCOUNTCHARGES(NUINDEXDISCOUNT);
            END IF;

            NUINDEXDISCOUNT := ITBDISCOUNTCHARGES.NEXT(NUINDEXDISCOUNT);
        END LOOP;

        UT_TRACE.TRACE('END GC_BODebtNegoCharges.GroupDiscounts',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GROUPDISCOUNTS;

    



















    PROCEDURE REVESETAXDISCOUNTS
    (
        ITBTAXDISCOUNTS         IN MO_TYTBCHARGES
    )
    IS
        NUINDEXDISCOUNT         NUMBER;
        SBSIGN                  CARGOS.CARGSIGN%TYPE;
        RCTAX                   MO_TYOBCHARGES;
        NUDISCNOAPPLY           CARGOS.CARGVALO%TYPE;
    BEGIN
        UT_TRACE.TRACE('BEGIN GC_BODebtNegoCharges.ReveseTaxDiscounts',15);

        UT_TRACE.TRACE('Descuentos de impuestos ['||ITBTAXDISCOUNTS.COUNT||']',15);

        NUINDEXDISCOUNT := ITBTAXDISCOUNTS.FIRST;
        LOOP
            EXIT WHEN NUINDEXDISCOUNT IS NULL;

            UT_TRACE.TRACE('Signo ['||ITBTAXDISCOUNTS(NUINDEXDISCOUNT).SIGN_||']',15);

            
            IF(ITBTAXDISCOUNTS(NUINDEXDISCOUNT).SIGN_ = PKBILLCONST.CREDITO)
            THEN
                SBSIGN := PKBILLCONST.DEBITO;
            ELSE
                SBSIGN := PKBILLCONST.CREDITO;
            END IF;

            UPDTAXDISCOUNT
            (
                ITBTAXDISCOUNTS(NUINDEXDISCOUNT).PRODUCT_ID,
                ITBTAXDISCOUNTS(NUINDEXDISCOUNT).BILL_ACCOUNT_ID,
                ITBTAXDISCOUNTS(NUINDEXDISCOUNT).CONCEPT_ID,
                ITBTAXDISCOUNTS(NUINDEXDISCOUNT).CHARGE_VALUE,
                SBSIGN,
                RCTAX,
                NUDISCNOAPPLY
            );

            
            GTBUPDATEDTAXES.EXTEND;
            GTBUPDATEDTAXES(GTBUPDATEDTAXES.COUNT) := GE_TYOBNUMBER(ITBTAXDISCOUNTS(NUINDEXDISCOUNT).CONCEPT_ID);

            NUINDEXDISCOUNT := ITBTAXDISCOUNTS.NEXT(NUINDEXDISCOUNT);
        END LOOP;

        UT_TRACE.TRACE('END GC_BODebtNegoCharges.ReveseTaxDiscounts',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END REVESETAXDISCOUNTS;

    























    PROCEDURE RECALCULATETAXES
    (
        ORFCHARGES              OUT CONSTANTS.TYREFCURSOR
    )
    IS
        TBPRODUCTIDS            DAPR_PRODUCT.TYTBPRODUCT_ID;
        NUINDEXPRODID           NUMBER;
        
        RCPRODUCT               SERVSUSC%ROWTYPE;

        TBDISCBYACCOUNT         TYTBCHARGBYACCOUNT;

        CURSOR CUPRODUCTS IS
        SELECT DISTINCT CHARGES.PRODUCT_ID
        FROM
        (   SELECT  PRODUCT_ID
            FROM    TABLE( CAST( GTBCHARGESSUBTOTAL AS MO_TYTBCHARGES ) )
            UNION ALL
            SELECT  PRODUCT_ID
            FROM    TABLE( CAST( GTBCHARGESDEFERRED AS MO_TYTBCHARGES ) )
        ) CHARGES;

    BEGIN
        UT_TRACE.TRACE('Inicia GC_BODebtNegoCharges.RecalculateTaxes', 10);

        REVESETAXDISCOUNTS(GTBTAXDISCBYACCOUNT);
        GTBTAXDISCBYACCOUNT.DELETE;
        GTBTAXDISCBYACCOUNT := MO_TYTBCHARGES();

        
        OPEN CUPRODUCTS;
        FETCH CUPRODUCTS BULK COLLECT INTO TBPRODUCTIDS;
        CLOSE CUPRODUCTS;

        UT_TRACE.TRACE('Productos ['||TBPRODUCTIDS.COUNT||']',15);

        NUINDEXPRODID := TBPRODUCTIDS.FIRST;
        LOOP
            EXIT WHEN NUINDEXPRODID IS NULL;

            
            RCPRODUCT := PKTBLSERVSUSC.FRCGETRECORD(TBPRODUCTIDS(NUINDEXPRODID));

            
            GETDISCOUNTCHARGES(RCPRODUCT.SESUNUSE);

            
            GROUPDISCOUNTS(GTBDISCOUNTCHARGES,TBDISCBYACCOUNT);

            
            GTBDISCOUNTCHARGES.DELETE;

            
            GENTAXVALUES(RCPRODUCT,TBDISCBYACCOUNT,GTBTAXDISCBYACCOUNT);

            NUINDEXPRODID := TBPRODUCTIDS.NEXT(NUINDEXPRODID);
        END LOOP;

        
        OPEN ORFCHARGES FOR
        WITH TAX_CONCEPTS AS
        (
            SELECT  UNIQUE ID CONCEPT_ID
            FROM    TABLE(CAST(GTBUPDATEDTAXES AS GE_TYTBNUMBER))
        ),
        CHARGES_IN_NEGO AS
        (   SELECT  PRODUCT_ID, CONCEPT_ID, BALANCE, CHARGE_VALUE
            FROM    TABLE( CAST( GTBCHARGESSUBTOTAL AS MO_TYTBCHARGES ) )
            UNION ALL
            SELECT  PRODUCT_ID, CONCEPT_ID, BALANCE, CHARGE_VALUE
            FROM    TABLE( CAST( GTBCHARGESDEFERRED AS MO_TYTBCHARGES ) )
        )
        SELECT  CHARGES_IN_NEGO.PRODUCT_ID  PRODUCTID,
                CHARGES_IN_NEGO.CONCEPT_ID  CONCEPTID,
                NULL                        CONCEPTDESC,
                SUM(CHARGE_VALUE)           VALUE_,
                SUM(BALANCE)                BALANCE,
                GE_BOCONSTANTS.CSBNO        DEFERRABLE,
                GE_BOCONSTANTS.CSBNO        ENABLED
        FROM    TAX_CONCEPTS, CHARGES_IN_NEGO
        WHERE   CHARGES_IN_NEGO.CONCEPT_ID IN (SELECT CONCEPT_ID FROM TAX_CONCEPTS)
        GROUP   BY CHARGES_IN_NEGO.PRODUCT_ID, CHARGES_IN_NEGO.CONCEPT_ID;

        UT_TRACE.TRACE('Finaliza GC_BODebtNegoCharges.RecalculateTaxes',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END RECALCULATETAXES;

    
END GC_BODEBTNEGOCHARGES;