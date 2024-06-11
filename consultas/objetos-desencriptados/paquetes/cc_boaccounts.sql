PACKAGE BODY CC_BOAccounts IS
    
    CSBVERSION  CONSTANT VARCHAR2(250)  := 'SAO301847';

	
    GSBPROGRAM   VARCHAR2(10) :=  CC_BOCONSTANTS.CSBCUSTOMERCARE;
    
    
    GNUACCOUNTSTATE FACTURA.FACTCODI%TYPE;
    
    CNUERROR_968               CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 968;
    
    CNUERROR_3038               CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 3038;

	
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;


  	























    PROCEDURE  ACCOUNTBYSUBSSERVICE (
		INUMOTIVE_ID      IN MO_MOTIVE.MOTIVE_ID%TYPE,
		INUTIPODOC        IN NUMBER DEFAULT NULL
    )
    IS
		NUERRORCODE       GE_MESSAGE.MESSAGE_ID%TYPE;
		SBERRORMESSAGE    GE_MESSAGE.DESCRIPTION%TYPE;
		NUPACKAGEID       MO_MOTIVE.PACKAGE_ID%TYPE;
		NUPRODUCTID       MO_MOTIVE.PRODUCT_ID%TYPE;
		NUCONTRACT        PR_PRODUCT.SUBSCRIPTION_ID%TYPE;
        NUPRODMOTIVE    PS_PRODUCT_MOTIVE.PRODUCT_MOTIVE_ID%TYPE;
        NUDAYSLIMIT     NUMBER;
        DTLIMITDATE     DATE;
        NUVLRCUENTA     NUMBER;
        NUCUENTA        NUMBER;
        NUESTADOCTA     NUMBER;
        NUPAYMENTMODE   NUMBER;

        PROCEDURE VALIDATEDATA IS

        BEGIN

            DAMO_MOTIVE.ACCKEY( INUMOTIVE_ID);
            NUPACKAGEID    := DAMO_MOTIVE.FNUGETPACKAGE_ID(INUMOTIVE_ID);
            NUPRODUCTID    := DAMO_MOTIVE.FNUGETPRODUCT_ID(INUMOTIVE_ID);
            DAPR_PRODUCT.ACCKEY( NUPRODUCTID);
            NUCONTRACT     := DAPR_PRODUCT.FNUGETSUBSCRIPTION_ID( NUPRODUCTID);
            NUPAYMENTMODE  := INUTIPODOC;
            NUPRODMOTIVE   := DAMO_MOTIVE.FNUGETPRODUCT_MOTIVE_ID( INUMOTIVE_ID );
            NUDAYSLIMIT    := CC_BOUTIL.FNUGETDAYSLIMIT(NUPRODMOTIVE);
            DTLIMITDATE    := SYSDATE + NVL(NUDAYSLIMIT,0);

            IF (NUPAYMENTMODE IS NULL) THEN
                NUPAYMENTMODE  := MO_BCDATA_ADDIT_SALES.FNUPAYMENTMODE( NUPACKAGEID );
            END IF;

        EXCEPTION
    	    WHEN EX.CONTROLLED_ERROR THEN
        	  RAISE EX.CONTROLLED_ERROR ;
    	    WHEN OTHERS THEN
        	  ERRORS.SETERROR;
        	  RAISE EX.CONTROLLED_ERROR;
        END;

		PROCEDURE GENACCOUNTBYSUBSSERVICE IS
		    DTEXPIRATIONDATE      DATE;
		BEGIN
            PKONLINEBILLING.GENACCOUNTSBYSUBSSERVICE( NUCONTRACT, NUPRODUCTID, NUPAYMENTMODE,
                                           GSBPROGRAM,
                                           NUESTADOCTA, NUCUENTA,NUVLRCUENTA,
                                           NUERRORCODE, SBERRORMESSAGE) ;

            IF (  NUERRORCODE <> GE_BOCONSTANTS.OK ) THEN
    	    	ERRORS.SETERROR
                (
                    CC_BOCONSTERROR.CNUBILLSERVICEERROR,
                    'pkOnlineBilling.GenAccountsBySubsService' || '|' ||
                    NUERRORCODE||' - ' || SBERRORMESSAGE
                );
    		    RAISE EX.CONTROLLED_ERROR ;
    	    END IF;
		    NUESTADOCTA := NVL(NUESTADOCTA, -1);
		    NUVLRCUENTA := NVL(NUVLRCUENTA,0);
		     IF (NUCUENTA  IS NOT NULL AND NUCUENTA  != -1) THEN
		         DTEXPIRATIONDATE := PKTBLCUENCOBR.FDTGETEXPIRATIONDATE (NUCUENTA);
		         DTLIMITDATE      := NVL(DTEXPIRATIONDATE,DTLIMITDATE);
		     END IF;

        EXCEPTION
    	    WHEN EX.CONTROLLED_ERROR THEN
        	  RAISE EX.CONTROLLED_ERROR ;
    	    WHEN OTHERS THEN
        	  ERRORS.SETERROR;
        	  RAISE EX.CONTROLLED_ERROR;
		END;
    BEGIN

        VALIDATEDATA ;

        GENACCOUNTBYSUBSSERVICE ;

        IF (NUESTADOCTA != -1) THEN
            
            MO_BOMOTIVEPAYMENT.REGISTER(
                    INUMOTIVE_ID ,
                    NUPACKAGEID ,
                    TO_CHAR(NUESTADOCTA),
                    DTLIMITDATE  ,
                    NUVLRCUENTA ,
                    NULL,
                    NUESTADOCTA );
        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    
    




























































    
    PROCEDURE GENERATEACCOUNTBYPACK
        (
		   INUPACKAGEID       IN  MO_PACKAGES.PACKAGE_ID%TYPE,
		   IBLALLCHARGES      IN  BOOLEAN,
		   ISBGENERATENBILLS  IN  VARCHAR2 DEFAULT PKCONSTANTE.NO
        )
    IS
        
        
        
        NURATING_PACKAGE_ID     MO_PACKAGE_PAYMENT.PACKAGE_PAYMENT_ID%TYPE;
        NUESTADOCTA             NUMBER;
        NUCUPON                 NUMBER;
        NUPAYMENTMODE           NUMBER;
        DTLIMITDATE             DATE;
        NUVLRCUENTA             NUMBER;
        NUPAYMENTVALUE          MO_PACKAGE_PAYMENT.PAYMENT_VALUE%TYPE;
        NUCUENTA                NUMBER;
        NUINDEXSTATACCOANDBAL   NUMBER;
        
        
        
        TBSTATACCOANDBALANCE    TYTBSTATACCOANDBALANCE;
        
        
        
        RCPACKAGES              DAMO_PACKAGES.STYMO_PACKAGES;

        
        
























        
        PROCEDURE VALIDATEDATA
        IS
            NUFACTURADO     MO_PACKAGE_PAYMENT.BILLING_VALUE%TYPE;
            NUTOTALVALUE    MO_PACKAGE_PAYMENT.TOTAL_VALUE%TYPE;
            SBSUPPDOC       CARGOS.CARGDOSO%TYPE;
            NUPRODUCTID     PR_PRODUCT.PRODUCT_ID%TYPE;
            
            TBCHARGES       PKBCCHARGES.TYTBCHARGS;
            

        BEGIN

            UT_TRACE.TRACE('Comienza CC_BOAccounts.GenerateAccountByPack.ValidateData',20);
            
            
            RCPACKAGES := DAMO_PACKAGES.FRCGETRECORD(INUPACKAGEID);

            MO_BOPACKAGEPAYMENT.GETIDPACKPAYMENT(INUPACKAGEID,NURATING_PACKAGE_ID,FALSE);
            
            
            NUPRODUCTID := MO_BOPACKAGES.FNUFINDPRODUCTID(INUPACKAGEID);

            IF(IBLALLCHARGES)THEN
                SBSUPPDOC := NULL;
            ELSE
                SBSUPPDOC := CC_BOCONSTANTS.CSBPREFIJODOC ||
                             CC_BOCONSTANTS.CSBSEPDOCPAYMENT ||
                             INUPACKAGEID;
            END IF;
            
            
            TBCHARGES := PKBCCHARGES.FTBNOTBILLCHARSBYPROD(NUPRODUCTID, SBSUPPDOC);
            
            
            IF(NURATING_PACKAGE_ID IS NULL AND TBCHARGES.COUNT > 0)THEN
                MO_BOPACKAGEPAYMENT.INSERTREGBASIC (
                                                        INUPACKAGEID,
                                                        NULL,
                                                        NURATING_PACKAGE_ID
                                                    );
            END IF;
            
            NUPAYMENTMODE  := GE_BOCONSTANTS.FNUGETDOCTYPECONS;
            
            UT_TRACE.TRACE('Finaliza CC_BOAccounts.GenerateAccountByPack.ValidateData',20);
            
        EXCEPTION
    	    WHEN EX.CONTROLLED_ERROR THEN
        	  RAISE EX.CONTROLLED_ERROR ;
    	    WHEN OTHERS THEN
        	  ERRORS.SETERROR;
        	  RAISE EX.CONTROLLED_ERROR;
        END;

        PROCEDURE GENERATEACCOUNT
        IS
		    NUERRORCODE       NUMBER;
		    SBERRORMESSAGE	  VARCHAR2(2000);
		    DTEXPIRATIONDATE  DATE;
        BEGIN
             
            GNUACCOUNTSTATE:=NULL;

            
            PKBOFISCALNUMBER.SETTERMINAL(RCPACKAGES.TERMINAL_ID);

            
            PKBOFISCALNUMBER.SETUSER(RCPACKAGES.USER_ID);

            PKGENERATEINVOICE.GENERATEBYREQUEST(INUPACKAGEID, NUCUPON, NUPAYMENTMODE,
                                                NUESTADOCTA, NUVLRCUENTA, NUERRORCODE,
                                                SBERRORMESSAGE, IBLALLCHARGES );

            IF (NUERRORCODE <> GE_BOCONSTANTS.OK) THEN
		    	ERRORS.SETERROR
                (
                    CC_BOCONSTERROR.CNUBILLSERVICEERROR,
                    'pkGenerateInvoice.GenerateByRequest' || '|' ||
                    NUERRORCODE||' - ' || SBERRORMESSAGE
                );
			    RAISE EX.CONTROLLED_ERROR ;
		     END IF;

		     NUVLRCUENTA    := NVL(NUVLRCUENTA,0);
		     NUESTADOCTA    := NVL(NUESTADOCTA,-1);
		     
		     
             GNUACCOUNTSTATE := NUESTADOCTA;

        END;
        
        







































        PROCEDURE GENERATENACCOUNTS
        IS
            
            
            
            NUERRORCODE           NUMBER;
		    SBERRORMESSAGE	      VARCHAR2(2000);
		    NUPRODUCTID           PR_PRODUCT.PRODUCT_ID%TYPE;
		    NUCONTRACTID          SUSCRIPC.SUSCCODI%TYPE;
		    SBSUPPDOC             CARGOS.CARGDOSO%TYPE;
		    NUINDEXPRODUCT        NUMBER;
		    NUINDEXSTATACCOBAL    NUMBER;
		    
            
            
		    TBCHILDPRODUCTS       DAPR_PRODUCT.TYTBPRODUCT_ID;

        BEGIN

            UT_TRACE.TRACE('Comienza CC_BOAccounts.GenerateAccountByPack.GenerateNAccounts',20);
            
            
            PKBOFISCALNUMBER.SETTERMINAL(RCPACKAGES.TERMINAL_ID);

            
            
            PKBOFISCALNUMBER.SETUSER(RCPACKAGES.USER_ID);

            
            NUPRODUCTID := MO_BOPACKAGES.FNUFINDPRODUCTID(INUPACKAGEID);

            
            SBSUPPDOC := CC_BOCONSTANTS.CSBPREFIJODOC ||
                         CC_BOCONSTANTS.CSBSEPDOCPAYMENT ||
                         INUPACKAGEID;

            
            
            PKACCOUNTMGR.SETREQUESTINMEMORY(INUPACKAGEID);

            
            TBCHILDPRODUCTS := FA_BOAPPORTIONMENTCHARGES.FTBGETPRODUCTSTODISTRIBUTE
                               (
                                  NUPRODUCTID
                               );

            
            
            

            NUINDEXPRODUCT := TBCHILDPRODUCTS.LAST;
            
            NUINDEXPRODUCT := NVL(NUINDEXPRODUCT, 0) + 1;

            TBCHILDPRODUCTS(NUINDEXPRODUCT) := NUPRODUCTID;

            
            
            NUINDEXPRODUCT := TBCHILDPRODUCTS.FIRST;
            NUINDEXSTATACCOBAL := 1;

            LOOP
                EXIT WHEN NUINDEXPRODUCT IS NULL;
                
                NUCONTRACTID := PKTBLSERVSUSC.FNUGETSUSCRIPTION(TBCHILDPRODUCTS(NUINDEXPRODUCT));

                PKGENERATEINVOICE.GENERATE(
                                            NUCONTRACTID,
                                            TBCHILDPRODUCTS(NUINDEXPRODUCT),
                                            SBSUPPDOC,
                                            NULL,
                                            NUPAYMENTMODE,
                                            NUESTADOCTA,
                                            NUCUENTA,
                                            NUVLRCUENTA,
                                            NUERRORCODE,
                                            SBERRORMESSAGE
                                          );

                
                IF ( NUERRORCODE <> GE_BOCONSTANTS.OK ) THEN
                  ERRORS.SETERROR
                  (
                      CC_BOCONSTERROR.CNUBILLSERVICEERROR,
                      'pkGenerateInvoice.Generate' || '|' ||
                      NUERRORCODE || ' - ' || SBERRORMESSAGE
                  );
                  RAISE EX.CONTROLLED_ERROR ;
                END IF;

                IF(NUESTADOCTA IS NOT NULL) THEN
                    
                    TBSTATACCOANDBALANCE(NUINDEXSTATACCOBAL).STATUSACCOUNT := NUESTADOCTA;
                    
                    TBSTATACCOANDBALANCE(NUINDEXSTATACCOBAL).ACCOUNTVALUE  := NVL(NUVLRCUENTA, 0);
                    NUINDEXSTATACCOBAL := NUINDEXSTATACCOBAL + 1;
                END IF;
                NUINDEXPRODUCT := TBCHILDPRODUCTS.NEXT(NUINDEXPRODUCT);
            END LOOP;

             
             IF(TBSTATACCOANDBALANCE.COUNT < 1)THEN
		        NUESTADOCTA     := -1;
             ELSE
                NUESTADOCTA     := 1;
             END IF;

            
            PKACCOUNTMGR.CLEARREQUESTINMEMORY;

             UT_TRACE.TRACE('Finaliza CC_BOAccounts.GenerateAccountByPack.GenerateNAccounts',20);

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                PKACCOUNTMGR.CLEARREQUESTINMEMORY;
            	RAISE EX.CONTROLLED_ERROR ;
        	WHEN OTHERS THEN
                PKACCOUNTMGR.CLEARREQUESTINMEMORY;
            	ERRORS.SETERROR;
            	RAISE EX.CONTROLLED_ERROR;
        END GENERATENACCOUNTS;
        
        PROCEDURE TRANSREQPOSBALANCE
        IS
            
            NUERRORCODE     GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
            SBERRORMESSAGE  GE_ERROR_LOG.DESCRIPTION%TYPE;
        BEGIN
            
            PKBSTRANSFERCREDITS.TRANSPOSBALBYREQUEST
            (
                INUPACKAGEID,
                NUERRORCODE,
                SBERRORMESSAGE
            );
            
            IF ( NUERRORCODE <> GE_BOCONSTANTS.OK ) THEN
                ERRORS.SETERROR
                (
                    CC_BOCONSTERROR.CNUBILLSERVICEERROR,
                    'pkBSTransferCredits.TransPosBalByRequest' || '|' ||
                    NUERRORCODE || ' - ' || SBERRORMESSAGE
                );
			    RAISE EX.CONTROLLED_ERROR ;
            END IF;
        END;
        
    BEGIN

        UT_TRACE.TRACE('Comienza CC_BOAccounts.GenerateAccountByPack',20);
        
        
        UT_TRACE.TRACE('Generacion estado de cuenta - Solicitud  ['||INUPACKAGEID||']',20);

        VALIDATEDATA;
        
        
        IF (ISBGENERATENBILLS = PKCONSTANTE.NO) THEN
            GENERATEACCOUNT;
        ELSIF (ISBGENERATENBILLS = PKCONSTANTE.SI) THEN
            GENERATENACCOUNTS;
        END IF;

        IF (NUESTADOCTA != -1) THEN

            
            TRANSREQPOSBALANCE;
            
            
            IF(NURATING_PACKAGE_ID IS NULL)THEN
                 MO_BOPACKAGEPAYMENT.INSERTREGBASIC(
                                                        INUPACKAGEID,
                                                        NULL,
                                                        NURATING_PACKAGE_ID
                                                    );
            END IF;

             
            IF(ISBGENERATENBILLS = PKCONSTANTE.NO) THEN
            
                
                DTLIMITDATE:=CC_BOBSSUTIL.FDTGETBILLACCOUNTEXPIRATION(NUESTADOCTA);

                
                NUPAYMENTVALUE := RC_BCPAYMENTQUERIES.FNUSUMPAYMENTSBYDOC( PKBILLCONST.CSBTOKEN_SOLICITUD, TO_CHAR( INUPACKAGEID ) );

                
                MO_BOMOTIVEPAYMENT.REGISTER(
                        NULL,
                        INUPACKAGEID,
                        UT_CONVERT.FSBTOCHAR(NUESTADOCTA),
                        DTLIMITDATE ,
                        NUVLRCUENTA,
                        NULL,
                        NUESTADOCTA,
                        NUPAYMENTVALUE);
            ELSIF(ISBGENERATENBILLS = PKCONSTANTE.SI) THEN
                
                
                NUINDEXSTATACCOANDBAL := TBSTATACCOANDBALANCE.FIRST;
                LOOP
                    EXIT WHEN NUINDEXSTATACCOANDBAL IS NULL;

                    
                    DTLIMITDATE:=CC_BOBSSUTIL.FDTGETBILLACCOUNTEXPIRATION(TBSTATACCOANDBALANCE(NUINDEXSTATACCOANDBAL).STATUSACCOUNT);

                    MO_BOMOTIVEPAYMENT.REGISTER(
                        NULL,
                        INUPACKAGEID,
                        UT_CONVERT.FSBTOCHAR(TBSTATACCOANDBALANCE(NUINDEXSTATACCOANDBAL).STATUSACCOUNT),
                        DTLIMITDATE,
                        TBSTATACCOANDBALANCE(NUINDEXSTATACCOANDBAL).ACCOUNTVALUE,
                        NULL,
                        TBSTATACCOANDBALANCE(NUINDEXSTATACCOANDBAL).STATUSACCOUNT
                        );

                    NUINDEXSTATACCOANDBAL := TBSTATACCOANDBALANCE.NEXT(NUINDEXSTATACCOANDBAL);
                END LOOP;
             END IF;
        END IF;
        
        UT_TRACE.TRACE('Finaliza CC_BOAccounts.GenerateAccountByPack',20);
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
        	RAISE EX.CONTROLLED_ERROR ;
    	WHEN OTHERS THEN
        	ERRORS.SETERROR;
        	RAISE EX.CONTROLLED_ERROR;
    END GENERATEACCOUNTBYPACK;
    
    
    


















    
    PROCEDURE GENERATEACCOUNTBYPACK
        (
		   INUPACKAGEID     IN  MO_PACKAGES.PACKAGE_ID%TYPE
        )
    IS
    BEGIN
       
       
       
       
       
       GENERATEACCOUNTBYPACK
        (
		   INUPACKAGEID,
           FALSE
        );
    END;
    
    





















    PROCEDURE GENERATENACCOUNTSBYPACK
        (
		   INUPACKAGEID     IN  MO_PACKAGES.PACKAGE_ID%TYPE
        )
    IS
    BEGIN
       UT_TRACE.TRACE('Comienza CC_BOAccounts.GenerateNAccountsByPack',20);
       GENERATEACCOUNTBYPACK
        (
		   INUPACKAGEID,
           PKCONSTANTE.FALSO,
           PKCONSTANTE.SI
        );
        UT_TRACE.TRACE('Finaliza CC_BOAccounts.GenerateNAccountsByPack',20);
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR: CC_BOAccounts.GenerateNAccountsByPack',4);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('others: CC_BOAccounts.GenerateNAccountsByPack',4);
            RAISE EX.CONTROLLED_ERROR;

    END GENERATENACCOUNTSBYPACK;


    
    



















    
    PROCEDURE GENERATEACCOUNTBYPRODUCT
        (
		   INUPACKAGEID     IN  MO_PACKAGES.PACKAGE_ID%TYPE
        )
    IS
    BEGIN
       
       
       
       
       
       
       
       GENERATEACCOUNTBYPACK
        (
		   INUPACKAGEID,
           TRUE
        );
    END;

        















    FUNCTION GETACCOUNTSTATE
    RETURN NUMBER
    IS
    BEGIN

        UT_TRACE.TRACE('Estado de Cuenta: ['||GNUACCOUNTSTATE||']',1);

        
        RETURN GNUACCOUNTSTATE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETACCOUNTSTATE;

    



























    PROCEDURE GETPRODCURRENTACCOUNT
    (
        INUCONTRACTID       IN      SUSCRIPC.SUSCCODI%TYPE,
        INUPRODUCTID        IN      SERVSUSC.SESUNUSE%TYPE,
        ORCACCOUNT          OUT     CUENCOBR%ROWTYPE
    )
    IS
        
        NUBILLID            FACTURA.FACTCODI%TYPE;
    BEGIN
    
        UT_TRACE.TRACE('INICIO: CC_BOAccounts.GetProdCurrentAccount',4);
        
        
        NUBILLID := PKBCFACTURA.FNUGETLASTBILLBYSUSC(INUCONTRACTID);
        
        
        ORCACCOUNT := PKBCCUENCOBR.FRCGETACCBYPRODBILL(NUBILLID, INUPRODUCTID);
        
        UT_TRACE.TRACE('FIN: CC_BOAccounts.GetProdCurrentAccount',4);
    
    EXCEPTION
    
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR: CC_BOAccounts.GetProdCurrentAccount',4);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('others: CC_BOAccounts.GetProdCurrentAccount',4);
            RAISE EX.CONTROLLED_ERROR;
    
    END GETPRODCURRENTACCOUNT ;
    
    

























    PROCEDURE FILLPARTIALACCOUNTS
    (
        IRCACCOUNT          IN      CUENCOBR%ROWTYPE,
        INUACCOUNTVALUE     IN      CUENCOBR.CUCOVAAP%TYPE
    )
    IS
    BEGIN
    
        UT_TRACE.TRACE('INICIO: CC_BOAccounts.FillPartialAccounts',4);
        
        
        PKTBLCUENCOBR.UPAUTHORIZEDPAYAMOUNT(IRCACCOUNT.CUCOCODI, INUACCOUNTVALUE);
        
        UT_TRACE.TRACE('FIN: CC_BOAccounts.FillPartialAccounts',4);
    
    EXCEPTION
    
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR: CC_BOAccounts.FillPartialAccounts',4);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('others: CC_BOAccounts.FillPartialAccounts',4);
            RAISE EX.CONTROLLED_ERROR;
    
    END FILLPARTIALACCOUNTS ;


END CC_BOACCOUNTS;