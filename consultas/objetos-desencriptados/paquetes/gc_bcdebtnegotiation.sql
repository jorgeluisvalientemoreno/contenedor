PACKAGE BODY GC_BCDebtNegotiation IS
    










































































    
    
    
    CSBVERSION                  CONSTANT VARCHAR2(10) := 'SAO300356';
    
    
    CNUTRACE_LEVEL              CONSTANT NUMBER := 6;

    CSBYES VARCHAR(1):= GE_BOCONSTANTS.CSBYES;
    CSBNO  VARCHAR(1):= GE_BOCONSTANTS.CSBNO;

    
    SBERRMSG GE_ERROR_LOG.DESCRIPTION%TYPE  ;
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    














    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;
    
    



















    PROCEDURE GETDEBTNEGOTIATIONDATA
    (
        INUPACKAGE_ID               IN          MO_PACKAGES.PACKAGE_ID%TYPE,
        ORCGC_DEBT_NEGOTIATION      OUT NOCOPY  GC_DEBT_NEGOTIATION%ROWTYPE
    )
    IS
        RFCURSOR                                CONSTANTS.TYREFCURSOR;
    BEGIN
    
        UT_TRACE.TRACE('Inicio [GC_BCDebtNegotiation.GetDebtNegotiationData]', 3);

        
        OPEN RFCURSOR FOR
        SELECT  /*+ index(gc_debt_negotiation, IDX_GC_DEBT_NEGOTIATION02) */
                *
        FROM    GC_DEBT_NEGOTIATION             
        WHERE   PACKAGE_ID = INUPACKAGE_ID;

        FETCH RFCURSOR INTO ORCGC_DEBT_NEGOTIATION;
        CLOSE RFCURSOR;

        UT_TRACE.TRACE('Fin [GC_BCDebtNegotiation.GetDebtNegotiationData]', 3);
    
    EXCEPTION
    
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR [GC_BCDebtNegotiation.GetDebtNegotiationData]', 3);
    	    RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UT_TRACE.TRACE('OTHERS [GC_BCDebtNegotiation.GetDebtNegotiationData]', 3);
            RAISE EX.CONTROLLED_ERROR;
    
    END GETDEBTNEGOTIATIONDATA;
    
    
    




















    PROCEDURE GETASSOCFINANCINGREQ
    (
        INUDEBTNEGOTIATIONID  IN GC_DEBT_NEGOTIATION.DEBT_NEGOTIATION_ID%TYPE,
        ORCFINANCINGREQUEST  OUT CC_FINANCING_REQUEST%ROWTYPE
    )
    IS
        
        
        CURSOR CUFINANREQUASOC
        IS
            SELECT /*+ leading(b)
                    index (b PK_GC_DEBT_NEGOTIATION)
                    index (a PK_CC_FINANCING_REQUEST)*/
                   A.*
            FROM   CC_FINANCING_REQUEST A,
                   GC_DEBT_NEGOTIATION B
            WHERE  A.FINANCING_REQUEST_ID = B.PACKAGE_ID
            AND    B.DEBT_NEGOTIATION_ID = INUDEBTNEGOTIATIONID;

    BEGIN
        UT_TRACE.TRACE( 'INICIO: GC_BCDebtNegotiation.GetAssocFinancingReq('||INUDEBTNEGOTIATIONID||')', 5 );

        
        IF ( CUFINANREQUASOC%ISOPEN ) THEN
            CLOSE CUFINANREQUASOC;
        END IF;

        
        
        OPEN CUFINANREQUASOC;
        FETCH CUFINANREQUASOC INTO ORCFINANCINGREQUEST;
        CLOSE CUFINANREQUASOC;

        UT_TRACE.TRACE( 'FIN: GC_BCDebtNegotiation.GetAssocFinancingReq', 5 );
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            IF ( CUFINANREQUASOC%ISOPEN ) THEN
                CLOSE CUFINANREQUASOC;
            END IF;
            UT_TRACE.TRACE( 'CONTROLLED_ERROR: [GC_BCDebtNegotiation.GetAssocFinancingReq]', 5 );
            RAISE;
        WHEN OTHERS THEN
            IF ( CUFINANREQUASOC%ISOPEN ) THEN
                CLOSE CUFINANREQUASOC;
            END IF;
            ERRORS.SETERROR;
            UT_TRACE.TRACE( 'others Error: [GC_BCDebtNegotiation.GetAssocFinancingReq]', 5 );
            RAISE EX.CONTROLLED_ERROR;
    END GETASSOCFINANCINGREQ;


    



















    PROCEDURE GETASSOCNEGOTINGREQ
    (
        INUFINANCINGREQID    IN CC_FINANCING_REQUEST.FINANCING_REQUEST_ID%TYPE,
        ORCDEBTNEGOTIATION  OUT GC_DEBT_NEGOTIATION%ROWTYPE
    )
    IS
        
        
        CURSOR CUNEGOTREQASOC
        IS
            SELECT  /*+ leading(b)
                    index (b PK_CC_FINANCING_REQUEST)
                    index (a IDX_GC_DEBT_NEGOTIATION02)*/
                    A.*
            FROM    GC_DEBT_NEGOTIATION A,
                    CC_FINANCING_REQUEST B
            WHERE   A.PACKAGE_ID = B.PACKAGE_ID
            AND     B.FINANCING_REQUEST_ID = INUFINANCINGREQID;

    BEGIN
        UT_TRACE.TRACE( 'INICIO: GC_BCDebtNegotiation.GetAssocNegotingReq('||INUFINANCINGREQID||')', 5 );

        
        IF ( CUNEGOTREQASOC%ISOPEN ) THEN
            CLOSE CUNEGOTREQASOC;
        END IF;

        
        
        OPEN CUNEGOTREQASOC;
        FETCH CUNEGOTREQASOC INTO ORCDEBTNEGOTIATION;
        CLOSE CUNEGOTREQASOC;

        UT_TRACE.TRACE( 'FIN: GC_BCDebtNegotiation.GetAssocNegotingReq', 5 );
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            IF ( CUNEGOTREQASOC%ISOPEN ) THEN
                CLOSE CUNEGOTREQASOC;
            END IF;
            UT_TRACE.TRACE( 'CONTROLLED_ERROR: [GC_BCDebtNegotiation.GetAssocNegotingReq]', 5 );
            RAISE;
        WHEN OTHERS THEN
            IF ( CUNEGOTREQASOC%ISOPEN ) THEN
                CLOSE CUNEGOTREQASOC;
            END IF;
            ERRORS.SETERROR;
            UT_TRACE.TRACE( 'others_Error: [GC_BCDebtNegotiation.GetAssocNegotingReq]', 5 );
            RAISE EX.CONTROLLED_ERROR;
    END GETASSOCNEGOTINGREQ;
    
    
    

























    PROCEDURE  GETFINANCINGREQUEST
    (
        INUFINANCINGID IN  CC_FINANCING_REQUEST.FINANCING_ID%TYPE,
        OTBFINANCING   OUT NOCOPY MO_TYTBFINANCING
    )
    IS
        RCFINANREQ   CC_FINANCING_REQUEST%ROWTYPE;

        CURSOR CUFINANCING
        (
            INUFINANCING IN CC_FINANCING_REQUEST.FINANCING_ID%TYPE
        )
        IS
            SELECT /*+ index(f IDX_CC_FINANCING_REQUEST_01)
                   index (p PK_MO_PACKAGES) */  F.*
            FROM   MO_PACKAGES P, CC_FINANCING_REQUEST F
                   /*+ GC_BCDebtNegotiation.GetFinancingRequest */
            WHERE  P.PACKAGE_ID = F.FINANCING_REQUEST_ID
            AND    F.FINANCING_ID = INUFINANCING;

    BEGIN

        UT_TRACE.TRACE('INICIO: GC_BCDebtNegotiation.GetFinancingRequest('||INUFINANCINGID||')', 6);

        
        OTBFINANCING := MO_TYTBFINANCING();

        OPEN  CUFINANCING (INUFINANCINGID);
        FETCH CUFINANCING INTO RCFINANREQ;
        CLOSE CUFINANCING;

        OTBFINANCING.EXTEND;
        OTBFINANCING(OTBFINANCING.COUNT) := MO_TYOBFINANCING
                                            (
                                                RCFINANREQ.FINANCING_ID,
                                                RCFINANREQ.FINANCING_PLAN_ID,
                                                RCFINANREQ.COMPUTE_METHOD_ID,
                                                RCFINANREQ.INTEREST_RATE_ID,
                                                RCFINANREQ.VALUE_TO_FINANCE,
                                                RCFINANREQ.INTEREST_PERCENT,
                                                RCFINANREQ.QUOTAS_NUMBER,
                                                RCFINANREQ.QUOTA_VALUE,
                                                RCFINANREQ.SPREAD,
                                                RCFINANREQ.VALUE_TO_FINANCE,    
                                                0,                              
                                                0,                              
                                                RCFINANREQ.RECORD_DATE,
                                                RCFINANREQ.DOCUMENT_SUPPORT,
                                                0,                              
                                                0,                              
                                                RCFINANREQ.RECORD_FUNCTIONARY,  
                                                RCFINANREQ.RECORD_DATE,         
                                                RCFINANREQ.RECORD_PROGRAM,
                                                SUBSTR(RCFINANREQ.RECORD_FUNCTIONARY,1,6),
                                                RCFINANREQ.SUBSCRIPTION_ID,
                                                0,                              
                                                NULL,                           
                                                RCFINANREQ.FINANCING_REQUEST_ID
                                            );

        UT_TRACE.TRACE('FIN: GC_BCDebtNegotiation.GetFinancingRequest',6);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETFINANCINGREQUEST;

    























    PROCEDURE GETPRODUTSFROMCOLL
    (
        ITBPRODUCTS     IN  CC_TYTBPRODUCT,
        OCUPRODUCTS     OUT PKCONSTANTE.TYREFCURSOR
    )
    IS
    BEGIN

        UT_TRACE.TRACE('INICIO GC_BCDebtNegotiation.GetProdutsFromColl',CNUTRACE_LEVEL);

        OPEN OCUPRODUCTS FOR
            SELECT  /*+ leading(products)
                        use_nl(products servicio)
                        use_nl(products estacort)
                        use_nl(products categori)
                        use_nl(products subcateg)
                        use_nl(products ab_address)
                        index(servicio pk_servicio)
                        index(estacort pk_estacort)
                        index(categori pk_estacort)
                        index(subcateg pk_subcateg)
                        index(ab_address pl_ab_address)
                    */
                    ROW_NUMBER_         ROWNUMBER,
                    PRODUCT_ID          PRODUCTID,
                    PRODUCT_TYPE_ID     PRODUCTTYPEID,
                    SERVICIO.SERVDESC   PRODUCTTYPEDES,
                    STATUS_ID           STATUSID,
                    ESTACORT.ESCODESC   STATUSDES,
                    CATEGORY_ID         CATEGORYID,
                    CATEGORI.CATEDESC   CATEGORYDES,
                    SUBCATEGORY_ID      SUBCATEGORYID,
                    SUBCATEG.SUCADESC   SUBCATEGORYDES,
                    PENDING_BALANCE     PENDINGBALANCE,
                    DEFERRED_PENDING_BAL    DEFERREDPENDINGBALANCE,
                    AB_ADDRESS.ADDRESS_PARSED,
                    ARREARS_BILLED          ARREARSBILLED,
                    ARREARS_NOT_BILLED      ARREARSNOTBILLED,
                    SEL_EXO_RE_INSTALL      SELEXOREINSTALL,
                    BASE_PRODUCT_ID         PRODUCTBASEID,
                    SELECTED,
                    PUNISH_BALANCE      PUNISHBALANCE
            FROM    /*+ GC_BCDebtNegotiation.GetProdutsFromColl*/
                    (TABLE( CAST( ITBPRODUCTS AS CC_TYTBPRODUCT ))) PRODUCTS,
                    SERVICIO, ESTACORT, CATEGORI, SUBCATEG, AB_ADDRESS
            WHERE   SERVICIO.SERVCODI = PRODUCT_TYPE_ID
            AND     ESTACORT.ESCOCODI = STATUS_ID
            AND     CATEGORI.CATECODI(+) = CATEGORY_ID
            AND     SUBCATEG.SUCACATE(+) = CATEGORY_ID
            AND     SUBCATEG.SUCACODI(+) = SUBCATEGORY_ID
            AND     AB_ADDRESS.ADDRESS_ID(+) = INSTALL_ADDRESS_ID;
            
            UT_TRACE.TRACE('FIN GC_BCDebtNegotiation.GetProdutsFromColl',CNUTRACE_LEVEL);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETPRODUTSFROMCOLL;

    
















































    PROCEDURE LOADCONCEPTBALANCE
    (
        INUCONTRACT         IN          SUSCRIPC.SUSCCODI%TYPE,
        INUPRODUCTID        IN          SERVSUSC.SESUNUSE%TYPE,
        ISBSELECTED         IN          CC_TMP_BAL_BY_CONC.SELECTED%TYPE,
        ISBONLYEXPIREDACC   IN          CC_FINANCING_REQUEST.ONLY_EXPIRED_ACC%TYPE,
        ITBBILLCHARGES      IN          MO_TYTBCHARGES,
        ITBDEFCHARGES       IN          MO_TYTBCHARGES,
        ONUCONTRACT         OUT NOCOPY  SUSCRIPC.SUSCCODI%TYPE
    )
    IS
 	    
        PRAGMA AUTONOMOUS_TRANSACTION;

        NUTIPOBASICO        NUMBER := PKBILLCONST.FNUOBTTIPOBASICO;

        
        DTSYSTEMMAXDATE     DATE := TRUNC( UT_DATE.FDTMAXDATE );

        
        CNUNOTDATATOPROCESS CONSTANT NUMBER(6) := 117900;

    BEGIN
    
        UT_TRACE.TRACE( 'INICIO GC_BCDebtNegotiation.LoadConceptBalance ( '
            || TO_CHAR( INUCONTRACT ) || ', ' || TO_CHAR( INUPRODUCTID ) || ' )]', CNUTRACE_LEVEL );

        
        DELETE CC_TMP_BAL_BY_CONC;

        INSERT INTO CC_TMP_BAL_BY_CONC
        (
            TMP_BAL_BY_CONCEPT_ID ,
            SELECTED              ,
            SUBSCRIPTION_ID       ,
            PRODUCT_ID            ,
            BASE_PRODUCT_ID       ,
            PRODUCT_TYPE_ID       ,
            CONCEPT_ID            ,
            DEFERRABLE            ,
            PENDING_BALANCE       ,
            ORIG_PENDING_BALANCE  ,
            LIST_DIST_CREDITS     ,
            TAX_PENDING_BALANCE   ,
            FINANCING_BALANCE     ,
            TAX_FINANCING_BALANCE ,
            NOT_FINANCING_BALANCE ,
            CANCEL_SERV_ESTAT_ID  ,
            ACCOUNT_NUMBER        ,
            FINANCING_CONCEPT_ID  ,
            BALANCE_ACCOUNT       ,
            AMOUNT_ACCOUNT_TOTAL  ,
            PAYMENT_DATE          ,
            EXPIRATION_DATE       ,
            COMPANY_ID            ,
            IS_INTEREST_CONCEPT   ,
            DISCOUNT_PERCENTAGE
        )
        SELECT  /*+ leading( charges )
                    use_nl( charges concepto )
                    use_nl( charges servsusc )
                    use_nl( servsusc estacort )
                    index( concepto PK_CONCEPTO )
                    index( servsusc PK_SERVSUSC )
                    index( estacort PK_ESTACORT ) */
            ROWNUM NUINDEX,     
            CSBNO SELECTED,
            SESUSUSC,           
            PRODUCT_ID,         
            


            DECODE( INUCONTRACT, NULL, NULL, CC_BCFINANCING.FNUBASEPRODUCT( PRODUCT_ID ) ),
            SESUSERV PRODUCT_TYPE_ID,       
            CONCEPT_ID,                     
            NVL( CONCDIFE, PKCONSTANTE.NO ) DEFERRABLE,
            SALDOCONC,
            ORIGINAL_BALANCE,
            LIST_DIST_CREDITS,
            PKBILLCONST.CERO SALDOIVA,
            
            CC_BCFINANCING.FNUFINANCINGVALUE( PRODUCT_ID, NVL( CONCDIFE, PKCONSTANTE.NO ), NVL( CONCTICL, NUTIPOBASICO ), SALDOCONC, EXPIRATION_DATE, ISBONLYEXPIREDACC ) FINANCING_BALANCE,
            PKBILLCONST.CERO       TAX_FINANCING_BALANCE, 
            ( SALDOCONC - CC_BCFINANCING.FNUFINANCINGVALUE( PRODUCT_ID, NVL( CONCDIFE, PKCONSTANTE.NO ), NVL( CONCTICL, NUTIPOBASICO ), SALDOCONC, EXPIRATION_DATE, ISBONLYEXPIREDACC ) ) NOT_FINANCING_BALANCE,
            SESUESCO,               
            BILL_ACCOUNT_ID,        
            CONCCORE,
            BILL_ACCOUNT_BALANCE,   
            BILL_ACC_TOTAL_VALUE,   
            PAYMENT_DATE,           
            EXPIRATION_DATE,        
            SESUSIST,
            (
                 SELECT /*+ index(concepto IX_CONC_COIN) */
                        CSBYES
                 FROM   CONCEPTO
                 WHERE  ( CONCCOIN = CONCEPT_ID AND ROWNUM = 1 )
            )  SOURCECONCEPTISINTCONCEPT,
            DISCOUNT_PERCENTAGE
        FROM    /*+ GC_BCDebtNegoCharges.LoadConceptBalance */
            (
                SELECT  





                        ALLCHARGES.PRODUCT_ID,
                        ALLCHARGES.CONCEPT_ID,
                        NVL(ALLCHARGES.BALANCE, 0) SALDOCONC,
                        ALLCHARGES.ORIGINAL_BALANCE,
                        ALLCHARGES.LIST_DIST_CREDITS,
                        ALLCHARGES.BILL_ACCOUNT_ID,
                        0 BILL_ACCOUNT_BALANCE,
                        0 BILL_ACC_TOTAL_VALUE,
                        DECODE( ACCOUNTS.CUCOCODI, PKCONSTANTE.NULLNUM, DTSYSTEMMAXDATE, ACCOUNTS.CUCOFEPA ) PAYMENT_DATE,
                        DECODE( ACCOUNTS.CUCOCODI, PKCONSTANTE.NULLNUM, DTSYSTEMMAXDATE, ACCOUNTS.CUCOFEVE ) EXPIRATION_DATE,
                        ALLCHARGES.DISCOUNT_PERCENTAGE
                FROM
                    (
                        
                        
                        
                        SELECT  CHARGES.PRODUCT_ID,
                                CHARGES.CONCEPT_ID,
                                CHARGES.BALANCE,
                                CHARGES.ORIGINAL_BALANCE,
                                CHARGES.LIST_DIST_CREDITS,
                                CHARGES.BILL_ACCOUNT_ID,
                                0 DISCOUNT_PERCENTAGE
                        FROM    TABLE( CAST( ITBBILLCHARGES AS MO_TYTBCHARGES ) ) CHARGES
                        WHERE   CHARGES.BALANCE       <>   PKBILLCONST.CERO
                        AND     CHARGES.SIGN_         IN  ( PKBILLCONST.DEBITO, PKBILLCONST.CREDITO )
                        AND     CHARGES.PRODUCT_ID    =   DECODE( INUPRODUCTID, NULL, CHARGES.PRODUCT_ID, INUPRODUCTID )
                        UNION ALL
                        
                        


                        SELECT  CHARGES.PRODUCT_ID,
                                CHARGES.CONCEPT_ID,
                                CHARGES.BALANCE,
                                CHARGES.ORIGINAL_BALANCE,
                                CHARGES.LIST_DIST_CREDITS,
                                CHARGES.BILL_ACCOUNT_ID,
                                PKCONSTANTE.NULLNUM DISCOUNT_PERCENTAGE
                        FROM    TABLE( CAST( ITBDEFCHARGES AS MO_TYTBCHARGES ) ) CHARGES
                        WHERE   CHARGES.BALANCE       <>   PKBILLCONST.CERO
                        AND     CHARGES.SIGN_         IN  ( PKBILLCONST.DEBITO, PKBILLCONST.CREDITO )
                    )   ALLCHARGES, CUENCOBR ACCOUNTS
                WHERE   ALLCHARGES.BILL_ACCOUNT_ID  =   ACCOUNTS.CUCOCODI
            ) FINCHARGES,
            CONCEPTO, SERVSUSC, ESTACORT
        WHERE   CONCCODI = CONCEPT_ID
        AND     SESUNUSE = PRODUCT_ID
        AND     ESCOCODI = SESUESCO;

        
        IF ( SQL%ROWCOUNT > 0 ) THEN
        
            UT_TRACE.TRACE( 'Se insertaron ' || SQL%ROWCOUNT || ' registros en la tabla temporal', CNUTRACE_LEVEL + 1);

            

            BEGIN
                SELECT SUBSCRIPTION_ID
                INTO   ONUCONTRACT
                FROM   CC_TMP_BAL_BY_CONC
                WHERE  ROWNUM = 1;
                UT_TRACE.TRACE( 'Se redefine contrato = [' || ONUCONTRACT || ']', CNUTRACE_LEVEL +1 );

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    ERRORS.SETERROR( CNUNOTDATATOPROCESS );
                    RAISE EX.CONTROLLED_ERROR;
                WHEN OTHERS THEN
                    ERRORS.SETERROR;
                    RAISE EX.CONTROLLED_ERROR;
            END;
        END IF;

        
        UPDATE  CC_TMP_BAL_BY_CONC
        SET     IS_INTEREST_CONCEPT = NVL( IS_INTEREST_CONCEPT, PKCONSTANTE.NO ),
                PEND_BALANCE_TO_FINANCE = 0,
                TAX_BAL_TO_FINANCE = 0;

        
        PKGENERALSERVICES.COMMITTRANSACTION;

        UT_TRACE.TRACE( 'FIN GC_BCDebtNegotiation.LoadConceptBalance', CNUTRACE_LEVEL );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            
            PKGENERALSERVICES.ROLLBACKTRANSACTION;
            RAISE;
        WHEN OTHERS THEN
            
            PKGENERALSERVICES.ROLLBACKTRANSACTION;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END LOADCONCEPTBALANCE;

    
















    PROCEDURE GETACCOUNTSBYCHARGES
    (
        ITBBILLCHARGES  IN          MO_TYTBCHARGES,
        ITBDEFCHARGES   IN          MO_TYTBCHARGES,
        OTBACCOUNTS     OUT NOCOPY  MO_TYTBBILLACCOUNT
    )
    IS
    BEGIN
    
        UT_TRACE.TRACE( 'INICIO GC_BCDebtNegotiation.GetAccountsByCharges', CNUTRACE_LEVEL );

        SELECT CAST
        (   MULTISET
            (   SELECT  /*+ leading( accounts  )
                            use_nl( accounts cuencobr )
                            index( cuencobr PK_CUENCOBR ) */
                        CUCOCODI,   
                        NULL,       
                        CUCODEPA,   
                        CUCOLOCA,   
                        CUCOPLSU,   
                        CUCOCATE,   
                        CUCOSUCA,   
                        CUCOVAAP,   
                        CUCOVARE,   
                        CUCOVAAB,   
                        CUCOVATO,   
                        CUCOFEPA,   
                        CUCONUSE,   
                        CUCOSACU,   
                        CUCOVRAP,   
                        CUCOFACT,   
                        NULL,       
                        CUCOFAAG,   
                        CUCOFEVE,   
                        CUCOVAFA,   
                        CUCOIMFA,   
                        CUCOSIST,   
                        CUCOGRIM    
                FROM
                    
                (   SELECT  BILL_ACCOUNT_ID
                    FROM    TABLE( CAST( ITBBILLCHARGES AS MO_TYTBCHARGES ) )
                    UNION
                    
                    SELECT  BILL_ACCOUNT_ID
                    FROM    TABLE( CAST( ITBDEFCHARGES AS MO_TYTBCHARGES ) )
                )   ACCOUNTS, CUENCOBR
                WHERE CUENCOBR.CUCOCODI = ACCOUNTS.BILL_ACCOUNT_ID
            )   AS MO_TYTBBILLACCOUNT
        )
        INTO OTBACCOUNTS
        FROM DUAL;

        UT_TRACE.TRACE( 'FIN GC_BCDebtNegotiation.GetAccountsByCharges', CNUTRACE_LEVEL );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETACCOUNTSBYCHARGES;


    















    PROCEDURE GETVALUESTOFINANCE
    (
        ONUFINANBALANCE     OUT NUMBER,
        ONUNOTFINANBALANCE  OUT NUMBER
    )
    IS

        CURSOR CUFINANVALUES
        IS
            SELECT  SUM( DECODE( SELECTED, CSBYES, FINANCING_BALANCE, 0 ) ) FINANCING_BALANCE,
                    SUM( DECODE( SELECTED, CSBNO,  PENDING_BALANCE , NOT_FINANCING_BALANCE ) ) NOT_FINANCING_BALANCE
            FROM    CC_TMP_BAL_BY_CONC;

        
        
        
        PROCEDURE CLOSECURSORS
        IS
        BEGIN
            
            IF ( CUFINANVALUES%ISOPEN ) THEN
                CLOSE CUFINANVALUES;
            END IF;
        END;

    BEGIN
        UT_TRACE.TRACE( 'INCIO GC_BCDebtNegotiation.GetValuesToFinance', CNUTRACE_LEVEL );

        OPEN CUFINANVALUES;
        FETCH CUFINANVALUES INTO ONUFINANBALANCE, ONUNOTFINANBALANCE;
        CLOSE CUFINANVALUES;

        UT_TRACE.TRACE( 'FIN GC_BCDebtNegotiation.GetValuesToFinance : Saldo Financiable= '
                        ||ONUFINANBALANCE|| ' Saldo No Financiable= '||ONUNOTFINANBALANCE, CNUTRACE_LEVEL );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            CLOSECURSORS;
            RAISE;
        WHEN OTHERS THEN
            CLOSECURSORS;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETVALUESTOFINANCE;


    





























    FUNCTION GETACCBYACCOUNPRIORITY
    (
        NUID_NEGOTIATION GC_DEBT_NEGOT_PROD.DEBT_NEGOTIATION_ID%TYPE,
        SBPRIORITY PARAMETR.PAMECHAR%TYPE DEFAULT 'SE'
    )
    RETURN TBACCOUNTS
    IS
        
        NUZERO CONSTANT NUMBER := PKBILLCONST.CERO;

        
        TBACCOUNTSBYNEG TBACCOUNTS;
        
        
        CSBCC_PRIORITY CONSTANT PARAMETR.PAMECHAR%TYPE := 'CC';

        
        RCACCOUNTS PKCONSTANTE.TYREFCURSOR;
        
        
        SBQUERY VARCHAR2(2000);
    BEGIN
         PKERRORS.PUSH('GC_BCDebtNegotiation.GetAccByAccounPriority');

         
         SBQUERY :=
         '
         SELECT
                   cucocodi "Cuenta Cobro" ,
                   nvl(cucosacu, :B1) "Saldo Cuenta" ,
                   nvl(cucovare, :B1) "Valor Reclamo",
                   cuconuse "Servicio Suscrito" ,
                   nvl(value_to_pay, :B1) "Valor Negociado",
                   servflfi "Fideliza"
         FROM      /*+ GC_BCDebtNegotiation.GetAccByAccounPriority */
                   gc_debt_negot_prod,
                   servsusc,
                   cuencobr,
                   factura,
                   servicio
         WHERE     gc_debt_negot_prod.debt_negotiation_id = :Negot -- ID Negociaci�n
            AND    servsusc.sesunuse = gc_debt_negot_prod.sesunuse -- Producto negociado
            AND    cuencobr.cuconuse = gc_debt_negot_prod.sesunuse -- Cuenta negociado
            AND    factura.factcodi = cuencobr.cucofact            -- Factura cuenta
            AND    servicio.servcodi = servsusc.sesuserv           -- Prioridad Servicio
            AND    nvl(cucosacu, :B1) > :B1
            ';

         
         IF SBPRIORITY = CSBCC_PRIORITY THEN
            SBQUERY := SBQUERY||CHR(10)||'ORDER BY  factfege, servprre';
         ELSE
            SBQUERY := SBQUERY||CHR(10)||'ORDER BY  servprre, factfege';
        END IF;

         
         OPEN RCACCOUNTS FOR SBQUERY USING NUZERO,            
                                         NUZERO,            
                                         NUZERO,            
                                         NUID_NEGOTIATION,  
                                         NUZERO,            
                                         NUZERO;            
         FETCH RCACCOUNTS BULK COLLECT INTO TBACCOUNTSBYNEG;

         PKERRORS.POP;
         RETURN TBACCOUNTSBYNEG;
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
           PKERRORS.POP;
    	   RAISE;
        WHEN OTHERS THEN
    	   PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
    	   PKERRORS.POP;
    	   RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END GETACCBYACCOUNPRIORITY;
    
    
    
















    PROCEDURE GETARREARSUNBILLED
    (
        ITBARREARS      IN  CC_TYTBARREAR,
        OCUARREARS      OUT PKCONSTANTE.TYREFCURSOR
    )
    IS
    BEGIN

        UT_TRACE.TRACE('INICIO GC_BCDebtNegotiation.GetArrearsUnbilled',CNUTRACE_LEVEL);

        OPEN OCUARREARS FOR
            SELECT  PRODUCT_ID,             
                    CONCEPT_ID,             
                    LAST_DATE_LIQ,          
                    LATE_DAYS,              
                    TAX_PERCENT,            
                    BASE_VALUE,             
                    GEN_LATE_VALUE,         
                    NOT_GEN_LATE_VALUE,     
                    TOTAL_DEBT              
            FROM    /*+ GC_BCDebtNegotiation.GetArrearsUnbilled */
                    (TABLE( CAST( ITBARREARS AS CC_TYTBARREAR ))) ARREARS;

            UT_TRACE.TRACE('FIN GC_BCDebtNegotiation.GetArrearsUnbilled',CNUTRACE_LEVEL);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error [CONTROLLED_ERROR] GC_BCDebtNegotiation.GetArrearsUnbilled', 2);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error [others] GC_BCDebtNegotiation.GetArrearsUnbilled', 2);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETARREARSUNBILLED;
    
    























    FUNCTION FNUGETFIRSTACCCOLLEC
    (
        INUDEBTNEGOTIATIONID  IN    GC_DEBT_NEGOTIATION.DEBT_NEGOTIATION_ID%TYPE,
        ISBPRIORITY           IN    PARAMETR.PAMECHAR%TYPE DEFAULT 'SE'
    )
    RETURN CUENCOBR.CUCOCODI%TYPE
    IS

        
        NUZERO CONSTANT NUMBER := PKBILLCONST.CERO;

        
        NUACCOUNT   CUENCOBR.CUCOCODI%TYPE;

        
        CSBCC_PRIORITY CONSTANT PARAMETR.PAMECHAR%TYPE := 'CC';

        
        RCACCOUNTS PKCONSTANTE.TYREFCURSOR;

        
        SBQUERY VARCHAR2(2000);
    BEGIN
         PKERRORS.PUSH('GC_BCDebtNegotiation.fnuGetFirstAccCollec');

         
         SBQUERY :=
         '
         SELECT
                   cucocodi "Cuenta Cobro"
         FROM      /*+ GC_BCDebtNegotiation.fnuGetFirstAccCollec */
                   gc_debt_negot_prod,
                   servsusc,
                   cuencobr,
                   factura,
                   servicio
         WHERE     gc_debt_negot_prod.debt_negotiation_id = :Negot -- ID Negociaci�n
            AND    servsusc.sesunuse = gc_debt_negot_prod.sesunuse -- Producto negociado
            AND    cuencobr.cuconuse = gc_debt_negot_prod.sesunuse -- Cuenta negociado
            AND    factura.factcodi = cuencobr.cucofact            -- Factura cuenta
            AND    servicio.servcodi = servsusc.sesuserv           -- Prioridad Servicio
            ';

         
         IF ISBPRIORITY = CSBCC_PRIORITY THEN
            SBQUERY := SBQUERY||CHR(10)||'ORDER BY  factfege DESC, servprre';
         ELSE
            SBQUERY := SBQUERY||CHR(10)||'ORDER BY  servprre, factfege DESC';
        END IF;

         
         OPEN RCACCOUNTS FOR SBQUERY USING INUDEBTNEGOTIATIONID;
         FETCH RCACCOUNTS  INTO NUACCOUNT;

         PKERRORS.POP;
         RETURN NUACCOUNT;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
           PKERRORS.POP;
    	   RAISE;
        WHEN OTHERS THEN
    	   PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
    	   PKERRORS.POP;
    	   RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END FNUGETFIRSTACCCOLLEC;
    
    













    PROCEDURE SORTCHARGESBYACCOUNT
    (
        ITBPUNISHCHARGES    IN       MO_TYTBCHARGES,
        OTBSORTCHARGES      OUT      PKBCCHARGES.TYTBREACCHARGES
    )
    IS
    BEGIN
        UT_TRACE.TRACE( 'Inicio: [GC_BCDebtNegotiation.SortChargesByAccount]', CNUTRACE_LEVEL );

        SELECT  /*+
                    index  (cuencobr PK_CUENCOBR)
                */
                CHARGE_VALUE, OUTSIDER_MONEY_VALUE, CHARGE_CAUSE, CONCEPT_ID,
                BILL_ACCOUNT_ID, SIGN_, DOCUMENT_SUPPORT
        BULK COLLECT INTO    OTBSORTCHARGES
        FROM    /*+GC_BODebtNegoCharge.SortChargesByAccount */
                (TABLE(CAST(ITBPUNISHCHARGES AS MO_TYTBCHARGES))) CHARGES,
                CUENCOBR
        WHERE   CHARGES.BILL_ACCOUNT_ID = CUCOCODI
        ORDER BY CUCOFEVE, CUCOCODI DESC;

        UT_TRACE.TRACE( 'Ordenados '||OTBSORTCHARGES.COUNT, CNUTRACE_LEVEL );
        UT_TRACE.TRACE( 'Fin: [GC_BCDebtNegotiation.SortChargesByAccount]', CNUTRACE_LEVEL );
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error GC_BCDebtNegotiation.SortChargesByAccount', CNUTRACE_LEVEL);
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SORTCHARGESBYACCOUNT;

END GC_BCDEBTNEGOTIATION;