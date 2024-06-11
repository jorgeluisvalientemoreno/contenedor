PACKAGE BODY or_boChargesGenerate IS










































































































	
    CSBVERSION   CONSTANT VARCHAR2(20) := 'SAO388381';

    CSBDEBITSIGN            VARCHAR2(100);
    CSBCREDITSIGN           VARCHAR2(100);
    CHDELIMITER             VARCHAR2(3) := '>';
    CNUFINANCINGPLAN        GE_MESSAGE.MESSAGE_ID%TYPE := 3636;

      
    CNUTECHNICAL_SERV_REQ   CONSTANT PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%TYPE := 22;

    
    CNUATTRIBUTEDCLIENT CONSTANT NUMBER := 1;
    

    
    CNUERR_INACTIVE_PRODUCT     CONSTANT NUMBER := 111642;

    TYPE TYTBNUMERIC IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

    TYPE TYRCCHARGESPRODUCT IS RECORD
    (
      NUPRODUCTID      NUMBER,
      TBCHARGESCONCEPT  TYTBNUMERIC
    );

    TYPE TYTBCHARGESPRODUCT  IS TABLE  OF TYRCCHARGESPRODUCT INDEX BY VARCHAR2(16);

    PROCEDURE LOAD
    IS
    BEGIN
        CSBDEBITSIGN  := PKBILLCONST.DEBITO;
        CSBCREDITSIGN := PKBILLCONST.CREDITO;
    END;

	
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    





































    PROCEDURE GENCHARGES
    (
        INUPRODUCT_ID       IN  PR_PRODUCT.PRODUCT_ID%TYPE,
        ISBCHARGE_TYPE      IN  VARCHAR2,
        INUCONCEPT          IN  OR_TASK_TYPE.CONCEPT %TYPE,
        INUCAUSAL           IN  NUMBER ,
        INUVALUE            IN  OR_ORDER.ORDER_VALUE%TYPE,
        ISBDOCUMENT         IN  VARCHAR2,
        IDTFECHA            IN  DATE,
        INUORDERID          IN  OR_ORDER.ORDER_ID%TYPE,
        ONUERRORCODE	    OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
    	OSBERRORMESSAGE	    OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    ) IS

        NUUNITS             NUMBER(4) := 1;
        NUVALUE             OR_ORDER.ORDER_VALUE%TYPE;
    BEGIN
        UT_TRACE.TRACE('or_boChargesGenerate.GenCharges INICIO',3);

        UT_TRACE.TRACE('inuProduct_id['||INUPRODUCT_ID||']- inuConcept['||INUCONCEPT||'] - inuCausal['||INUCAUSAL||'] - isbDocument['||ISBDOCUMENT||'] - isbCharge_type['||ISBCHARGE_TYPE||']',5);
        UT_TRACE.TRACE('inuValue['||INUVALUE||'] - idtFecha['||IDTFECHA||'] - Or_BOConstants.csbORDERS['||OR_BOCONSTANTS.CSBORDERS||'] - nuUnits['||NUUNITS||']',5);

        NUVALUE     := INUVALUE;

        
        FA_BOPOLITICAREDONDEO.APLICAPOLITICA (INUPRODUCT_ID, NUVALUE);

        
        PKBILLDEFERRED.GENERATECHARGE
        (
            INUPRODUCT_ID                     , 
            INUCONCEPT                        , 
            INUCAUSAL                         , 
            ISBDOCUMENT                       , 
            ISBCHARGE_TYPE                    , 
            NUVALUE                           , 
            IDTFECHA                          , 
            OR_BOCONSTANTS.CSBORDERS          , 
            NUUNITS                           , 
            INUORDERID                        , 
            ONUERRORCODE                      ,
            OSBERRORMESSAGE
        );
        
        UT_TRACE.TRACE('[Cargo BSS] nuErrorCode:['|| ONUERRORCODE ||'] sbErrorMessage:['|| OSBERRORMESSAGE ||']',15);

        

        GW_BOERRORS.CHECKERROR(ONUERRORCODE,OSBERRORMESSAGE);

        IF (ONUERRORCODE != 0) THEN
            UT_TRACE.TRACE('ERROR BSS =>'||ONUERRORCODE,3);
            ERRORS.SETERROR(ONUERRORCODE);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        UT_TRACE.TRACE('or_boChargesGenerate.GenCharges] FIN',3);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GENCHARGES;

     















    PROCEDURE GETCREDITPARAM
    (
        INUORDERID  IN OR_ORDER_ACTIVITY.ORDER_ID%TYPE,
        TBCHARGES OUT OR_BCORDERACTIVITIES.TYTBITEMS
    )
    IS
        TBACTIVITY      UT_STRING.TYTB_STRING;
        NUITEM          GE_ITEMS.ITEMS_ID%TYPE;
        NUVALUE         NUMBER;
        NUINDEX         NUMBER := NULL;
        SBVALUES        OR_ORDER_ACTIVITY.VALUE1%TYPE;
        NUAMOUNT        OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT%TYPE;
        NUCREDITAMOUNT  OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT%TYPE;

    BEGIN
        UT_TRACE.TRACE('getCreditParam Begin',2);
        OR_BCORDERACTIVITIES.GETACTIVITIESBYORDER(INUORDERID, GE_BOITEMSCONSTANTS.CNUCREDITACTIVITY, TBACTIVITY);

        NUINDEX := TBACTIVITY.FIRST;
        WHILE NUINDEX IS NOT NULL LOOP

            
            SBVALUES := DAOR_ORDER_ACTIVITY.FSBGETVALUE1(TBACTIVITY(NUINDEX));

            NUITEM := NULL;

            IF SBVALUES IS NOT NULL THEN
                NUITEM := UT_STRING.EXTSTRFIELD(SBVALUES,CHDELIMITER,2);
            END IF;

            IF NOT TBCHARGES.EXISTS(NUITEM) THEN
                NUVALUE := OR_BCORDERITEMS.FNUVALUEITEMORDER(INUORDERID, NUITEM, NUAMOUNT);
                UT_TRACE.TRACE('nuValue:'||NUVALUE,3);
                IF NVL(NUVALUE,0) > 0 THEN

                    SBVALUES := DAOR_ORDER_ACTIVITY.FSBGETVALUE2(TBACTIVITY(NUINDEX));

                    NUCREDITAMOUNT := 0;
                    IF SBVALUES IS NOT NULL THEN
                        NUCREDITAMOUNT := TO_NUMBER(UT_STRING.EXTSTRFIELD(SBVALUES,CHDELIMITER,2));
                    END IF;

                    
                    UT_TRACE.TRACE('nuCreditAmount:'||NUCREDITAMOUNT,3);

                    IF NUCREDITAMOUNT < 1 THEN
                        NUCREDITAMOUNT := 0;
                    END IF;
                    IF NUCREDITAMOUNT > NUAMOUNT THEN
                        NUCREDITAMOUNT := NUAMOUNT;
                    END IF;
                    TBCHARGES(NUITEM) :=  NUCREDITAMOUNT*NUVALUE/NUAMOUNT;
                    UT_TRACE.TRACE('tbCharges(nuItem):'||TBCHARGES(NUITEM),3);
                END IF;
            END IF;

            NUINDEX := TBACTIVITY.NEXT(NUINDEX);
        END LOOP;
        UT_TRACE.TRACE('getCreditParam End',2);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCREDITPARAM;
    
    
















    PROCEDURE GETCOMMONAREAPRODUCT
    (
        INUORDERID          IN  OR_ORDER.ORDER_ID%TYPE,
        INUPRODUCTID        IN  PR_PRODUCT.PRODUCT_ID%TYPE,
        ONUCOMMONPRODUCTID  OUT PR_PRODUCT.PRODUCT_ID%TYPE
    )
    IS
        TBACTIVITY      UT_STRING.TYTB_STRING;
        NUINDEX         NUMBER := NULL;
    BEGIN

        UT_TRACE.TRACE('INICIA - or_boChargesGenerate.getCommonAreaProduct ',15);
        UT_TRACE.TRACE('inuOrderId ['||INUORDERID||'] - inuProductId ['||INUPRODUCTID||']',15);
        OR_BCORDERACTIVITIES.GETACTIVITIESBYORDER(INUORDERID, GE_BOITEMSCONSTANTS.CNUCOMMONAREACHARGEACTIVITY, TBACTIVITY);

        ONUCOMMONPRODUCTID := NULL;

        NUINDEX := TBACTIVITY.FIRST;

        IF(NUINDEX IS NOT NULL AND INUPRODUCTID IS NOT NULL) THEN

            
            ONUCOMMONPRODUCTID := FA_BOAPPORTIONMENTCHARGES.FNUGETCOMMONAREAPRODUCT(INUPRODUCTID);

        END IF;

        

        IF(NUINDEX IS NOT NULL AND ONUCOMMONPRODUCTID IS NULL)THEN
            GE_BOERRORS.SETERRORCODEARGUMENT(1, 'ESTE MENSAJE DEBO CAMBIARLO ');
        END IF;

        UT_TRACE.TRACE('FIN - or_boChargesGenerate.getCommonAreaProduct - onuCommonProductId ['||ONUCOMMONPRODUCTID||']',15);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCOMMONAREAPRODUCT;
    
    




















    PROCEDURE GETDISTRIBUTIONPARAM
    (
        INUORDERID      IN  OR_ORDER_ACTIVITY.ORDER_ID%TYPE,
        INUPRODUCTID    IN  PR_PRODUCT.PRODUCT_ID%TYPE,
        ITBGENCHARGES   IN  OR_BCCONCEPTVALUE.TBCONCEPTS,
        OTBCHARGESPROD  OUT TYTBCHARGESPRODUCT

    )
    IS
        CNUMEDGAS       IF_ELEMENT_TYPE.ELEMENT_TYPE_ID%TYPE := 41;
        CNUMEDAGUA      IF_ELEMENT_TYPE.ELEMENT_TYPE_ID%TYPE := 38;
        CNUMEDENERGIA   IF_ELEMENT_TYPE.ELEMENT_TYPE_ID%TYPE := 404;
        CNUSERVNUMBER   NUMBER := 1;
        CNUINVALIDRANGE NUMBER := 121182; 
        CNUINVALIDSUM   NUMBER := 3635;
        NUINVALIDMETER  NUMBER := 3637;

        TBACTIVITY      UT_STRING.TYTB_STRING;
        TBCHARGCREDITS  TYTBNUMERIC;

        NUINDEX         NUMBER := NULL;
        NUCHARGESIDX    NUMBER := NULL; 
        NUDISTRIB       NUMBER;
        NUTOTALDISTRIB  NUMBER := 0;

        NUTYPE          NUMBER;
        SBCODIGO        VARCHAR2(100);

        NUPRODUCTID     PR_PRODUCT.PRODUCT_ID%TYPE;
        NUELEMENTID     IF_ASSIGNABLE.ID%TYPE;

        SBVALUES        OR_ORDER_ACTIVITY.VALUE1%TYPE;
        SBPRODUCTID     VARCHAR2(16);
        NUACTIVITYID    OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;

    BEGIN
        UT_TRACE.TRACE('getDistributionParam',15);
        OR_BCORDERACTIVITIES.GETACTIVITIESBYORDER(INUORDERID, GE_BOITEMSCONSTANTS.CNUDISTRIBUTEACTIVITY, TBACTIVITY);

        NUINDEX := TBACTIVITY.FIRST;

        WHILE NUINDEX IS NOT NULL LOOP

            NUACTIVITYID := TBACTIVITY(NUINDEX);
            
            
            SBVALUES := DAOR_ORDER_ACTIVITY.FSBGETVALUE1(NUACTIVITYID);

            IF SBVALUES IS NOT NULL THEN
                NUDISTRIB := UT_STRING.EXTSTRFIELD(SBVALUES,CHDELIMITER,2);
            END IF;


            IF NVL(NUDISTRIB,0) <= 0 OR NUDISTRIB > 100  THEN
                ERRORS.SETERROR(CNUINVALIDRANGE );
                RAISE EX.CONTROLLED_ERROR;
            END IF;

            
            SBVALUES := DAOR_ORDER_ACTIVITY.FSBGETVALUE2(NUACTIVITYID);

            IF SBVALUES IS NOT NULL THEN
                NUTYPE := UT_STRING.EXTSTRFIELD(SBVALUES,CHDELIMITER,2);
            END IF;

            
            SBVALUES := DAOR_ORDER_ACTIVITY.FSBGETVALUE3(NUACTIVITYID);

            IF SBVALUES IS NOT NULL THEN
                SBCODIGO := UT_STRING.EXTSTRFIELD(SBVALUES,CHDELIMITER,2);
            END IF;

            IF SBCODIGO IS NOT NULL THEN
                UT_TRACE.TRACE('CodigoAProcesar['||SBCODIGO||']tipo='||NUTYPE,15);
                IF NUTYPE IN (CNUMEDGAS, CNUMEDAGUA,CNUMEDENERGIA) THEN

                    IF_BOASSIGNABLE.GETIDFROMCODE(NUTYPE, SBCODIGO,NUELEMENTID);

                    PR_BONETWORK_ELEM_OPER.GETPRODUCTIDBYELEMID(NUELEMENTID,NUPRODUCTID ) ;

                    IF NUPRODUCTID IS NULL THEN
                        ERRORS.SETERROR(NUINVALIDMETER,SBCODIGO);
                        RAISE EX.CONTROLLED_ERROR;
                    END IF;

                ELSIF NUTYPE = CNUSERVNUMBER THEN

                    PR_BOPRODUCT.GETPRODUCTIDBYSERVNUM(SBCODIGO,NUPRODUCTID);

                END IF;

                
                DAPR_PRODUCT.ACCKEY(NUPRODUCTID);

                IF  NUPRODUCTID != INUPRODUCTID THEN
                    SBPRODUCTID := TO_CHAR(NUPRODUCTID);
                    IF NOT OTBCHARGESPROD.EXISTS(SBPRODUCTID) THEN

                        IF NOT PR_BOPRODUCT.ACTIVE(NUPRODUCTID) THEN
                            ERRORS.SETERROR(CNUERR_INACTIVE_PRODUCT);
                            RAISE EX.CONTROLLED_ERROR;
                        END IF;

                        PKSERVNUMBERMGR.VALISBILLABLESERVNUMBER( NUPRODUCTID );

                        

                        NUTOTALDISTRIB := NUTOTALDISTRIB + NUDISTRIB;

                        IF NUTOTALDISTRIB > 100 THEN
                            ERRORS.SETERROR(CNUINVALIDSUM  );
                            RAISE EX.CONTROLLED_ERROR;
                        END IF;

                        NUCHARGESIDX := ITBGENCHARGES.FIRST;
                        
                        
                        
                        WHILE NUCHARGESIDX IS NOT NULL LOOP

                            IF NOT TBCHARGCREDITS.EXISTS(NUCHARGESIDX) THEN
                                TBCHARGCREDITS(NUCHARGESIDX) := 0;
                            END IF;

                            IF NUTOTALDISTRIB = 100 THEN
                                
                                
                                OTBCHARGESPROD(SBPRODUCTID).TBCHARGESCONCEPT(NUCHARGESIDX) :=
                                                ITBGENCHARGES(NUCHARGESIDX).NUVALUE - TBCHARGCREDITS(NUCHARGESIDX);
                            ELSE
                                OTBCHARGESPROD(SBPRODUCTID).TBCHARGESCONCEPT(NUCHARGESIDX) :=
                                                ITBGENCHARGES(NUCHARGESIDX).NUVALUE*(NUDISTRIB/100);
                            END IF;

                            TBCHARGCREDITS(NUCHARGESIDX) := TBCHARGCREDITS(NUCHARGESIDX) + OTBCHARGESPROD(SBPRODUCTID).TBCHARGESCONCEPT(NUCHARGESIDX);
                            
                            NUCHARGESIDX := ITBGENCHARGES.NEXT(NUCHARGESIDX);
                        END LOOP;
                    END IF;
                END IF;
            END IF;

            NUINDEX := TO_NUMBER(TBACTIVITY.NEXT(NUINDEX));
        END LOOP;

        NUCHARGESIDX := ITBGENCHARGES.FIRST;
        
        
        
        WHILE NUCHARGESIDX IS NOT NULL LOOP
            IF NOT TBCHARGCREDITS.EXISTS(NUCHARGESIDX) THEN
                TBCHARGCREDITS(NUCHARGESIDX) := 0;
            END IF;
            
            OTBCHARGESPROD(TO_CHAR(INUPRODUCTID)).TBCHARGESCONCEPT(NUCHARGESIDX) :=
                    ITBGENCHARGES(NUCHARGESIDX).NUVALUE - TBCHARGCREDITS(NUCHARGESIDX);
            NUCHARGESIDX := ITBGENCHARGES.NEXT(NUCHARGESIDX);
        END LOOP;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETDISTRIBUTIONPARAM;

    






















    PROCEDURE GETFINANCINGPARAM
    (
        INUORDERID      IN OR_ORDER_ACTIVITY.ORDER_ID%TYPE,
        ONUFINANPLAN    OUT OR_TASK_TYPE_LIQUID.PLAN_FINANCIACION%TYPE,
        ONUCUOTA        OUT PLANDIFE.PLDICUMA%TYPE,
        ONUMETODO       OUT PLANDIFE.PLDIMCCD%TYPE,
        ONUTASAINT      OUT PLANDIFE.PLDITAIN%TYPE,
        ONUSPREAD       OUT PLANDIFE.PLDISPMA%TYPE

    )
    IS
        TYTBACTIVITY    UT_STRING.TYTB_STRING;
        RCPLANDIFE      PLANDIFE%ROWTYPE;

        NUINDEX         NUMBER := NULL;

        CNUINVFINAN     GE_MESSAGE.MESSAGE_ID%TYPE := 3632;
        SBVALUES        OR_ORDER_ACTIVITY.VALUE1%TYPE;
    BEGIN

        OR_BCORDERACTIVITIES.GETACTIVITIESBYORDER(INUORDERID, GE_BOITEMSCONSTANTS.CNUFINANCEACTIVITY, TYTBACTIVITY);

        IF TYTBACTIVITY.COUNT > 1 THEN
            ERRORS.SETERROR(CNUINVFINAN);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        NUINDEX := TYTBACTIVITY.FIRST;
        IF NUINDEX IS NOT NULL THEN

            SBVALUES := DAOR_ORDER_ACTIVITY.FSBGETVALUE1(TYTBACTIVITY(NUINDEX));

            IF SBVALUES IS NOT NULL THEN
                ONUFINANPLAN := UT_STRING.EXTSTRFIELD(SBVALUES,CHDELIMITER,2);
            END IF;

            IF ONUFINANPLAN IS NULL THEN
                ERRORS.SETERROR(CNUFINANCINGPLAN);
                RAISE EX.CONTROLLED_ERROR;
            END IF;

            SBVALUES := DAOR_ORDER_ACTIVITY.FSBGETVALUE2(TYTBACTIVITY(NUINDEX));

            IF SBVALUES IS NOT NULL THEN
                ONUCUOTA := UT_STRING.EXTSTRFIELD(SBVALUES,CHDELIMITER,2);
            END IF;

            RCPLANDIFE := PKTBLPLANDIFE.FRCGETRECORD( ONUFINANPLAN );

            IF ONUCUOTA < RCPLANDIFE.PLDICUMI  OR ONUCUOTA > RCPLANDIFE.PLDICUMA
                OR ONUCUOTA IS NULL THEN
                ONUCUOTA := RCPLANDIFE.PLDICUMA;
            END IF;

            ONUMETODO   := RCPLANDIFE.PLDIMCCD;
            ONUTASAINT  := RCPLANDIFE.PLDITAIN;
            ONUSPREAD   := RCPLANDIFE.PLDISPMA;

        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETFINANCINGPARAM;

    

































    PROCEDURE APPLIQUIDATIONPARAM
    (
        INUORDERID      IN  OR_ORDER.ORDER_ID%TYPE,
        INUPRODUCTID    IN  PR_PRODUCT.PRODUCT_ID%TYPE,
        ITBGENCHARGES   IN  OR_BCCONCEPTVALUE.TBCONCEPTS,
        ISBDOCSOPORTE   IN  VARCHAR2,
        IDTFECHA        IN  DATE,
        INULIQUIDMETHOD IN  PS_PACKAGE_TYPE.LIQUIDATION_METHOD%TYPE
    )
    IS

        NUCHARGEVALUE       OR_ORDER_ITEMS.VALUE%TYPE := 0;
        NUCONCEPT           OR_TASK_TYPE.CONCEPT%TYPE;
        NUCONCINTERES       CONCEPTO.CONCCOIN%TYPE;
        NUPORCENTINT        PLANDIFE.PLDIPOIN%TYPE;
        NUMETODO            PLANDIFE.PLDIMCCD%TYPE;
        NUTASAINT           PLANDIFE.PLDITAIN%TYPE;
        NUSPREAD            PLANDIFE.PLDISPMA%TYPE;
        NUCUOTA             NUMBER;

        NUINDEX             NUMBER;
        NUCHARGEIDX         NUMBER;

        TBREALCHARGES       OR_BCCONCEPTVALUE.TBCONCEPTS;
        TBCHARGESPROD       TYTBCHARGESPRODUCT;
    	TBVALUES            OR_BCORDERACTIVITIES.TYTBITEMS;
    	SBPRODUCTID         VARCHAR2(16);
    	NUPRODUCTID         PR_PRODUCT.PRODUCT_ID%TYPE;
        BLVALIDATE          BOOLEAN    := TRUE;
        NUFINANIVA          NUMBER     := 0;

        NUFINANPLAN         OR_TASK_TYPE_LIQUID.PLAN_FINANCIACION%TYPE;
        NUNUMERODIFERIDO    DIFERIDO.DIFECODI%TYPE;

        NUERRORCODE	        GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
    	SBERRORMESSAGE	    GE_ERROR_LOG.DESCRIPTION%TYPE;

        
        NUCHARGECAUSE       CAUSCARG.CACACODI%TYPE;
        NUCOMMONCHARGECAUSE CAUSCARG.CACACODI%TYPE;


        
        NUACCCHARGECAUSE     CAUSCARG.CACACODI%TYPE;
        
        
        NUFINCHARGECAUSE     CAUSCARG.CACACODI%TYPE;
        
        
        NUDISCHARGECAUSE     CAUSCARG.CACACODI%TYPE;
        
        
        NUPRODUCTTYPE       SERVICIO.SERVCODI%TYPE;
        NUCOMMONPRODTYPEID  SERVICIO.SERVCODI%TYPE;

        
        NUCOMMONPRODUCTID   PR_PRODUCT.PRODUCT_ID%TYPE;
        


        CURSOR CUVALPRODUCT
        (
            INUORDERID   IN OR_ORDER.ORDER_ID%TYPE,
            INUPRODUCTID IN OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE
        )
        IS
        SELECT COUNT('1') VALIDAR
          FROM OR_ORDER_ACTIVITY, MO_MOTIVE
         WHERE OR_ORDER_ACTIVITY.ORDER_ID = INUORDERID
           AND OR_ORDER_ACTIVITY.PRODUCT_ID = INUPRODUCTID
           AND OR_ORDER_ACTIVITY.MOTIVE_ID = MO_MOTIVE.MOTIVE_ID
           AND MO_MOTIVE.MOTIVE_TYPE_ID IN
            (SELECT MOTIVE_TYPE_ID FROM PS_MOTIVE_TYPE WHERE ACTIVITY_TYPE = 'I')
            AND ROWNUM = 1;
    BEGIN

        TBREALCHARGES   := ITBGENCHARGES;
        TBVALUES.DELETE;

        
        NUFINANIVA := 0;
        
        
        IF PKGENERALPARAMETERSMGR.FSBGETSTRINGVALUE('FINANIVA' ) = 'S' THEN
            NUFINANIVA := NULL;
        END IF;

        


        IF INULIQUIDMETHOD IN
        (
            OR_BOCONSTANTS.CNUMETODO_FIXED_PRICE,
            OR_BOCONSTANTS.CNUMETODO_DELEGATE_PRICE,
            OR_BOCONSTANTS.CNUMETODO_UNITARY_PRICE
        )
        AND TBREALCHARGES.FIRST IS NOT NULL
        THEN
         
            NUCONCEPT       := TBREALCHARGES(TBREALCHARGES.FIRST).NUCONCEPTID;

            


            UT_TRACE.TRACE('Or_bochargesGenerate.Acreditar',15);

            
            NUPRODUCTTYPE := PKTBLSERVSUSC.FNUGETSERVICE(INUPRODUCTID);

            
            NUACCCHARGECAUSE := FA_BOCHARGECAUSES.FNUORDERACCREDITCHCAUSE(NUPRODUCTTYPE);

            GETCREDITPARAM(INUORDERID, TBVALUES);
            NUINDEX := TBVALUES.FIRST;

            WHILE NUINDEX IS NOT NULL  LOOP

                IF  (INULIQUIDMETHOD = OR_BOCONSTANTS.CNUMETODO_UNITARY_PRICE) THEN
                    
                    NUCONCEPT := DAGE_ITEMS.FNUGETCONCEPT(NUINDEX);
                END IF;

                IF NUCONCEPT IS NOT NULL THEN
                    
                    
                    TBREALCHARGES(NUCONCEPT).NUVALUE := TBREALCHARGES(NUCONCEPT).NUVALUE - TBVALUES(NUINDEX);

                    
                    GENCHARGES
                    (
                        INUPRODUCTID,
                        CSBCREDITSIGN,
                        NUCONCEPT,
                        NUACCCHARGECAUSE,
                        TBVALUES(NUINDEX), 
                        ISBDOCSOPORTE,
                        IDTFECHA,
                        0, 
                        
                        NUERRORCODE,
                	    SBERRORMESSAGE
                    );

                    
                    GW_BOERRORS.CHECKERROR(NUERRORCODE,SBERRORMESSAGE);

                END IF;

                NUINDEX := TBVALUES.NEXT(NUINDEX);

            END LOOP;

            TBVALUES.DELETE;
            TBCHARGESPROD.DELETE;

            


            UT_TRACE.TRACE('Or_bochargesGenerate.Distribuir',15);

            GETDISTRIBUTIONPARAM(INUORDERID, INUPRODUCTID, TBREALCHARGES,TBCHARGESPROD);

            SBPRODUCTID := TBCHARGESPROD.FIRST;
            WHILE SBPRODUCTID IS NOT NULL  LOOP
                NUPRODUCTID := TO_NUMBER(SBPRODUCTID);
            
                IF NUPRODUCTID != INUPRODUCTID THEN

                    NUCHARGEIDX :=  TBCHARGESPROD(SBPRODUCTID).TBCHARGESCONCEPT.FIRST;
                    
                    WHILE NUCHARGEIDX IS NOT NULL LOOP
                        IF TBCHARGESPROD(SBPRODUCTID).TBCHARGESCONCEPT(NUCHARGEIDX) > 0 THEN
                            
                            
                            
                            
                            NUPRODUCTTYPE := PKTBLSERVSUSC.FNUGETSERVICE(INUPRODUCTID);
                            
                            
                            NUDISCHARGECAUSE := FA_BOCHARGECAUSES.FNUORDERDISTRCHCAUSE(NUPRODUCTTYPE);

                            
                            GENCHARGES
                            (
                                INUPRODUCTID,
                                CSBCREDITSIGN,
                                NUCHARGEIDX,
                                NUDISCHARGECAUSE,
                                TBCHARGESPROD(SBPRODUCTID).TBCHARGESCONCEPT(NUCHARGEIDX) ,
                                ISBDOCSOPORTE,
                                IDTFECHA,
                                0, 
                                
                                NUERRORCODE,
                    	        SBERRORMESSAGE
                            );
                            
                            GW_BOERRORS.CHECKERROR(NUERRORCODE,SBERRORMESSAGE);
                            
                            
                            
                            
                            NUPRODUCTTYPE := PKTBLSERVSUSC.FNUGETSERVICE(NUPRODUCTID);

                            
                            NUDISCHARGECAUSE := FA_BOCHARGECAUSES.FNUORDERDISTRCHCAUSE(NUPRODUCTTYPE);

                            
                            GENCHARGES
                            (
                                NUPRODUCTID,
                                CSBDEBITSIGN,
                                NUCHARGEIDX,
                                NUDISCHARGECAUSE,
                                TBCHARGESPROD(SBPRODUCTID).TBCHARGESCONCEPT(NUCHARGEIDX),
                                ISBDOCSOPORTE,
                                IDTFECHA,
                                0, 
                                
                                NUERRORCODE,
                	            SBERRORMESSAGE
                            );
                            
                            GW_BOERRORS.CHECKERROR(NUERRORCODE,SBERRORMESSAGE);

                        END IF;
                        NUCHARGEIDX := TBCHARGESPROD(SBPRODUCTID).TBCHARGESCONCEPT.NEXT(NUCHARGEIDX);

                    END LOOP;
                END IF;

                SBPRODUCTID := TBCHARGESPROD.NEXT(SBPRODUCTID);
            
            END LOOP;
            


            UT_TRACE.TRACE('Or_bochargesGenerate.Financiar',15);

            GETFINANCINGPARAM
            (
                INUORDERID,
                NUFINANPLAN,
                NUCUOTA,
                NUMETODO,
                NUTASAINT,
                NUSPREAD
            );

            IF NUFINANPLAN IS NOT NULL THEN

                
                FOR RG IN CUVALPRODUCT(INUORDERID, INUPRODUCTID) LOOP
                    IF RG.VALIDAR = 1 THEN
                        BLVALIDATE := FALSE;
                    END IF;
                END LOOP;

                IF NUCUOTA IS NOT NULL THEN
                    
                    SBPRODUCTID := TBCHARGESPROD.FIRST;

                    WHILE SBPRODUCTID IS NOT NULL LOOP

                        NUPRODUCTID := TO_NUMBER(SBPRODUCTID);
                        
                        
                        NUPRODUCTTYPE := PKTBLSERVSUSC.FNUGETSERVICE(NUPRODUCTID);

                        
                        NUFINCHARGECAUSE := FA_BOCHARGECAUSES.FNUORDERFINANCINGCHCAUSE(NUPRODUCTTYPE);

                        
                        NUCHARGEIDX := TBCHARGESPROD(SBPRODUCTID).TBCHARGESCONCEPT.FIRST;

                        
                        WHILE NUCHARGEIDX IS NOT NULL LOOP

                            
                            IF PKTBLCONCEPTO.FSBGETDEFERABLEFLAG(NUCHARGEIDX) = 'S' THEN
                            
                                NUCONCINTERES   := PKTBLCONCEPTO.FNUGETINTERESTCONC(NUCHARGEIDX);

                                IF NUCONCINTERES = PKCONSTANTE.NULLNUM THEN
                                    NUCONCINTERES := NULL;
                                    NUPORCENTINT  := 0;
                                ELSE
                                    NUPORCENTINT    := PKEFFECTIVEINTERESTRATEMGR.FNUINTERESRATEVALUE(NUTASAINT, IDTFECHA);
                                END IF;

                                
                                NUCHARGEVALUE := TBCHARGESPROD(SBPRODUCTID).TBCHARGESCONCEPT(NUCHARGEIDX);

                                IF NUCHARGEVALUE > 0 THEN

                                    
                                    GENCHARGES
                                    (
                                        NUPRODUCTID,            
                                        CSBCREDITSIGN,
                                        NUCHARGEIDX,            
                                        NUFINCHARGECAUSE,
                                        NUCHARGEVALUE,
                                        ISBDOCSOPORTE,
                                        IDTFECHA,
                                        0, 
                                        
                                        NUERRORCODE,
                    	                SBERRORMESSAGE
                                    );

                                    
                                    GW_BOERRORS.CHECKERROR(NUERRORCODE,SBERRORMESSAGE);

                                    IF NUINDEX = INUPRODUCTID THEN
                                        PKDEFERRED.SETVALSERVICENUMBER(BLVALIDATE);
                                    ELSE
                                        PKDEFERRED.SETVALSERVICENUMBER(TRUE);
                                    END IF;

                                    
                                    PKDEFERRED.CREATEDEFERRED
                                    (
                                        NUPRODUCTID,                
                                        NUCHARGEIDX,                
                                        CSBDEBITSIGN,
                                        NUMETODO,                   
                                        IDTFECHA,
                                        NUCHARGEVALUE,
                                        NUPORCENTINT ,
                                        NUCUOTA,                    
                                        ISBDOCSOPORTE,              
                                        OR_BOCONSTANTS.CSBORDERS,   
                                        NUFINANPLAN,
                                        NUTASAINT,
                                        NUSPREAD,                   
                                        IDTFECHA,                   
                                        NULL,                       
                                        NULL,                       
                                        NUCONCINTERES,
                                        TRUE,                       
                                        NUNUMERODIFERIDO,           
                                        NUERRORCODE,                
                                        SBERRORMESSAGE              
                                    );

                                    PKDEFERRED.SETVALSERVICENUMBER(TRUE);
                                    
                                    GW_BOERRORS.CHECKERROR(NUERRORCODE,SBERRORMESSAGE);

                                END IF;
                            
                            END IF;
                            NUCHARGEIDX := TBCHARGESPROD(SBPRODUCTID).TBCHARGESCONCEPT.NEXT(NUCHARGEIDX);
                        END LOOP;

                        SBPRODUCTID := TBCHARGESPROD.NEXT(SBPRODUCTID);
                    END LOOP;

                END IF;

            END IF;
            
            


            GETCOMMONAREAPRODUCT(INUORDERID, INUPRODUCTID, NUCOMMONPRODUCTID);

            UT_TRACE.TRACE('/******** COBRAR �REA COM�N **********/',15);

            IF(INUPRODUCTID IS NOT NULL AND NUCOMMONPRODUCTID IS NOT NULL) THEN

                NUINDEX := ITBGENCHARGES.FIRST;

                
                NUPRODUCTTYPE := PKTBLSERVSUSC.FNUGETSERVICE(INUPRODUCTID);
                NUCHARGECAUSE := FA_BOCHARGECAUSES.FNUORDERDISTRCHCAUSE(NUPRODUCTTYPE);

                
                NUCOMMONPRODTYPEID := PKTBLSERVSUSC.FNUGETSERVICE(NUCOMMONPRODUCTID);
                NUCOMMONCHARGECAUSE := FA_BOCHARGECAUSES.FNUORDERCHCAUSE(NUPRODUCTTYPE);

                UT_TRACE.TRACE('nuChargeCause ['||NUCHARGECAUSE||'] - nuCommonChargeCause ['||NUCOMMONCHARGECAUSE||']',15);

                WHILE NUINDEX IS NOT NULL
                LOOP

                    UT_TRACE.TRACE('itbGenCharges(nuIndex).nuConceptId ['||ITBGENCHARGES(NUINDEX).NUCONCEPTID||'] - itbGenCharges(nuIndex).nuValue ['||ITBGENCHARGES(NUINDEX).NUVALUE||']',15);

                    UT_TRACE.TRACE('/* Se crean cargos CR�DITO por el valor que se va a diferir para el producto de la orden */ ',15);
                    
                    GENCHARGES
                    (
                        INUPRODUCTID,           
                        CSBCREDITSIGN,
                        ITBGENCHARGES(NUINDEX).NUCONCEPTID,            
                        NUCHARGECAUSE,
                        ITBGENCHARGES(NUINDEX).NUVALUE,
                        ISBDOCSOPORTE,
                        IDTFECHA,
                        INUORDERID,
                        NUERRORCODE,
    	                SBERRORMESSAGE
                    );

                    
                    GW_BOERRORS.CHECKERROR(NUERRORCODE,SBERRORMESSAGE);

                    UT_TRACE.TRACE('/* Se crean cargos D�BITO por el valor que se va a diferir para el producto de �rea com�n */ ',15);
                    
                    GENCHARGES
                    (
                        NUCOMMONPRODUCTID,
                        CSBDEBITSIGN,
                        ITBGENCHARGES(NUINDEX).NUCONCEPTID,
                        NUCOMMONCHARGECAUSE,
                        ITBGENCHARGES(NUINDEX).NUVALUE,
                        ISBDOCSOPORTE,
                        IDTFECHA,
                        INUORDERID,
        	            NUERRORCODE,
                    	SBERRORMESSAGE
                    );

                    
                    GW_BOERRORS.CHECKERROR(NUERRORCODE,SBERRORMESSAGE);

                    UT_TRACE.TRACE('Concepto cargo: '||NUINDEX,15);
                    NUINDEX := ITBGENCHARGES.NEXT(NUINDEX);
                END LOOP;

            END IF;
         
        END IF;


    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END APPLIQUIDATIONPARAM;
    
    





























    PROCEDURE APPDISCOUNTBYQUOTATION
    (
        INUORDERID            IN    OR_ORDER.ORDER_ID%TYPE,
        INUPRODUCTID          IN    PR_PRODUCT.PRODUCT_ID%TYPE,
        ISBDOCSOPORTE         IN    VARCHAR2,
        IDTFECHA              IN    DATE,
        INULIQUIDMETHOD       IN    PS_PACKAGE_TYPE.LIQUIDATION_METHOD%TYPE,
        TBDISCOUNTCONCEPTS    IN    OR_BCCONCEPTVALUE.TYTBDISCOUNTCONCEPTS
    )
    IS
        NUINDEX             BINARY_INTEGER;
        NUERRORCODE	        GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
    	SBERRORMESSAGE	    GE_ERROR_LOG.DESCRIPTION%TYPE;

        
        NUCHARGECAUSE       CAUSCARG.CACACODI%TYPE;

        
        NUPRODUCTTYPE       SERVICIO.SERVCODI%TYPE;
    BEGIN

        
        NUPRODUCTTYPE := PKTBLSERVSUSC.FNUGETSERVICE(INUPRODUCTID);

        
        NUCHARGECAUSE := FA_BOCHARGECAUSES.FNUORDERACCREDITCHCAUSE(NUPRODUCTTYPE);

        NUINDEX := TBDISCOUNTCONCEPTS.FIRST;

        WHILE (NUINDEX IS NOT NULL) LOOP

            
            GENCHARGES
            (
                INUPRODUCTID,
                CSBCREDITSIGN,
                TBDISCOUNTCONCEPTS(NUINDEX).NUDISCOUNTCONCEPTID,
                NUCHARGECAUSE,
                TBDISCOUNTCONCEPTS(NUINDEX).NUDISCOUNTVALUE, 
                ISBDOCSOPORTE,
                IDTFECHA,
                0, 
                NUERRORCODE,
        	    SBERRORMESSAGE
            );

            
            GW_BOERRORS.CHECKERROR(NUERRORCODE,SBERRORMESSAGE);

            NUINDEX := TBDISCOUNTCONCEPTS.NEXT(NUINDEX);

        END LOOP;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
            
    END APPDISCOUNTBYQUOTATION;
    
    






















    PROCEDURE VALLIQUIDATIONPARAM
    (
        INUORDERID      IN  OR_ORDER.ORDER_ID%TYPE,
        INUPRODUCTID    IN  PR_PRODUCT.PRODUCT_ID%TYPE,
        ITBGENCHARGES   IN  OR_BCCONCEPTVALUE.TBCONCEPTS,
        ISBDOCSOPORTE   IN  VARCHAR2,
        IDTFECHA        IN  DATE,
        INULIQUIDMETHOD IN  PS_PACKAGE_TYPE.LIQUIDATION_METHOD%TYPE
    )
    IS
        NUCHARGEVALUE       OR_ORDER_ITEMS.VALUE%TYPE := 0;
        NUCONCEPT           OR_TASK_TYPE.CONCEPT%TYPE;
        NUCONCINTERES       CONCEPTO.CONCCOIN%TYPE;
        NUPORCENTINT        PLANDIFE.PLDIPOIN%TYPE;
        NUMETODO            PLANDIFE.PLDIMCCD%TYPE;
        NUTASAINT           PLANDIFE.PLDITAIN%TYPE;
        NUSPREAD            PLANDIFE.PLDISPMA%TYPE;
        NUCUOTA             NUMBER;

        NUINDEX             NUMBER;
        NUCHARGEIDX         NUMBER;
        NUPRODUCTID         PR_PRODUCT.PRODUCT_ID%TYPE;
        TBREALCHARGES       OR_BCCONCEPTVALUE.TBCONCEPTS;
        TBCHARGESPROD       TYTBCHARGESPRODUCT;
    	TBVALUES            OR_BCORDERACTIVITIES.TYTBITEMS;
        SBPRODUCTID         VARCHAR2(16);
        BLVALIDATE          BOOLEAN    := TRUE   ;

        NUFINANPLAN         OR_TASK_TYPE_LIQUID.PLAN_FINANCIACION%TYPE;
        NUNUMERODIFERIDO    DIFERIDO.DIFECODI%TYPE;

        NUERRORCODE	        GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
    	SBERRORMESSAGE	    GE_ERROR_LOG.DESCRIPTION%TYPE;

        CURSOR CUVALPRODUCT
        (
            INUORDERID   IN OR_ORDER.ORDER_ID%TYPE,
            INUPRODUCTID IN OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE
        )
        IS
        SELECT COUNT('1') VALIDAR
          FROM OR_ORDER_ACTIVITY, MO_MOTIVE
         WHERE OR_ORDER_ACTIVITY.ORDER_ID = INUORDERID
           AND OR_ORDER_ACTIVITY.PRODUCT_ID = INUPRODUCTID
           AND OR_ORDER_ACTIVITY.MOTIVE_ID = MO_MOTIVE.MOTIVE_ID
           AND MO_MOTIVE.MOTIVE_TYPE_ID IN
            (SELECT MOTIVE_TYPE_ID FROM PS_MOTIVE_TYPE WHERE ACTIVITY_TYPE = 'I')
            AND ROWNUM = 1;
    BEGIN

        TBREALCHARGES   := ITBGENCHARGES;
        TBVALUES.DELETE;
        UT_TRACE.TRACE('Init Or_bochargesGenerate.valLiquidationParam',15);
        


        IF INULIQUIDMETHOD IN
        (
            OR_BOCONSTANTS.CNUMETODO_FIXED_PRICE,
            OR_BOCONSTANTS.CNUMETODO_DELEGATE_PRICE,
            OR_BOCONSTANTS.CNUMETODO_UNITARY_PRICE
        )
        AND TBREALCHARGES.FIRST IS NOT NULL
        THEN
         
            NUCONCEPT       := TBREALCHARGES(TBREALCHARGES.FIRST).NUCONCEPTID;

            


            UT_TRACE.TRACE('Or_bochargesGenerate.Acreditar',15);

            GETCREDITPARAM(INUORDERID, TBVALUES);
            NUINDEX := TBVALUES.FIRST;

            WHILE NUINDEX IS NOT NULL  LOOP

                IF (INULIQUIDMETHOD = OR_BOCONSTANTS.CNUMETODO_UNITARY_PRICE)
                THEN
                    
                    NUCONCEPT := DAGE_ITEMS.FNUGETCONCEPT(NUINDEX);
                END IF;

                IF NUCONCEPT IS NOT NULL THEN
                    
                    
                    TBREALCHARGES(NUCONCEPT).NUVALUE := TBREALCHARGES(NUCONCEPT).NUVALUE - TBVALUES(NUINDEX);

                END IF;

                NUINDEX := TBVALUES.NEXT(NUINDEX);

            END LOOP;

            TBVALUES.DELETE;
            TBCHARGESPROD.DELETE;

            


            UT_TRACE.TRACE('Or_bochargesGenerate.Distribuir',15);

            GETDISTRIBUTIONPARAM(INUORDERID, INUPRODUCTID, TBREALCHARGES,TBCHARGESPROD);

            


            UT_TRACE.TRACE('Or_bochargesGenerate.Financiar',15);

            GETFINANCINGPARAM
            (
                INUORDERID,
                NUFINANPLAN,
                NUCUOTA,
                NUMETODO,
                NUTASAINT,
                NUSPREAD
            );

            IF NUFINANPLAN IS NOT NULL THEN

                
                FOR RG IN CUVALPRODUCT(INUORDERID, INUPRODUCTID) LOOP
                    IF RG.VALIDAR = 1 THEN
                        BLVALIDATE := FALSE;
                    END IF;
                END LOOP;

                IF NUCUOTA IS NOT NULL THEN
                    
                    SBPRODUCTID := TBCHARGESPROD.FIRST;

                    WHILE SBPRODUCTID IS NOT NULL LOOP
                    
                        NUPRODUCTID := TO_NUMBER(SBPRODUCTID);
                        
                        NUCHARGEIDX :=  TBCHARGESPROD(SBPRODUCTID).TBCHARGESCONCEPT.FIRST;

                        
                        WHILE NUCHARGEIDX IS NOT NULL LOOP

                            NUCONCINTERES   := PKTBLCONCEPTO.FNUGETINTERESTCONC(NUCHARGEIDX);

                            IF NUCONCINTERES = PKCONSTANTE.NULLNUM THEN
                                NUCONCINTERES := NULL;
                                NUPORCENTINT  := 0;
                            ELSE
                                NUPORCENTINT    := PKEFFECTIVEINTERESTRATEMGR.FNUINTERESRATEVALUE(NUTASAINT, IDTFECHA);
                            END IF;

                            
                            NUCHARGEVALUE := TBCHARGESPROD(SBPRODUCTID).TBCHARGESCONCEPT(NUCHARGEIDX);

                            IF NUCHARGEVALUE > 0 THEN

                                IF NUPRODUCTID = INUPRODUCTID THEN
                                    IF BLVALIDATE THEN
                                        PKSERVNUMBERMGR.VALISBILLABLESERVNUMBER(INUPRODUCTID);
                                    END IF;
                                ELSE
                                    PKSERVNUMBERMGR.VALISBILLABLESERVNUMBER(NUPRODUCTID);
                                END IF;
                            END IF;

                            NUCHARGEIDX :=  TBCHARGESPROD(SBPRODUCTID).TBCHARGESCONCEPT.NEXT(NUCHARGEIDX);
                        END LOOP;

                        SBPRODUCTID := TBCHARGESPROD.NEXT(SBPRODUCTID);
                    END LOOP;

                END IF;

            END IF;
         
        END IF;
       UT_TRACE.TRACE('End Or_bochargesGenerate.valLiquidationParam',15);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALLIQUIDATIONPARAM;
    
    






























































    PROCEDURE GENCHARGESBYORDER
    (
        IORCORDER       IN OUT    DAOR_ORDER.STYOR_ORDER,
        IBLADJORDERCALL IN        BOOLEAN DEFAULT FALSE
	)
	IS
        NULIQUIDATIONMETHOD PS_PACKAGE_TYPE.LIQUIDATION_METHOD%TYPE;
        NUPRODUCTID         PR_PRODUCT.PRODUCT_ID%TYPE;
        NUPACKAGEID         MO_PACKAGES.PACKAGE_ID%TYPE;

        TBCONCEPT           OR_BCCONCEPTVALUE.TBCONCEPTS;
        TBDISCOUNTCONCEPTS  OR_BCCONCEPTVALUE.TYTBDISCOUNTCONCEPTS;

        SBDOCSOPORTE        VARCHAR2(2000);
        DTFECHA             DATE;

        NUINDEX             NUMBER;
        
         
        NUCOMM_PLAN_ID      PR_PRODUCT.COMMERCIAL_PLAN_ID%TYPE;

        
        NURATING_PACKAGE_ID MO_PACKAGE_PAYMENT.PACKAGE_PAYMENT_ID%TYPE;


	    NUERRORCODE	       GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
    	SBERRORMESSAGE	   GE_ERROR_LOG.DESCRIPTION%TYPE;
    	
    	NUPACKAGEIDTEMP    MO_PACKAGES.PACKAGE_ID%TYPE;

        
        NUORDERCHARGECAUSE  CAUSCARG.CACACODI%TYPE;

        
        NUPRODUCTTYPE       SERVICIO.SERVCODI%TYPE;

        RCPERIFACT 	 PERIFACT%ROWTYPE ;		
 BEGIN
 
        UT_TRACE.TRACE('INICIA or_boChargesGenerate.GenChargesByOrder='||TO_CHAR(IORCORDER.ORDER_ID), 2);

        OR_BOITEMVALUE.GETLIQMETHOD(IORCORDER.ORDER_ID, NUPACKAGEID, NULIQUIDATIONMETHOD);

        IF(NUPACKAGEID IS  NOT NULL) THEN
            
            NUPRODUCTID := MO_BOENGINEERINGSERV.FNUGETENGINSERVPRODUCT(NUPACKAGEID);
        END IF;

        
        
        
        IF (NULIQUIDATIONMETHOD IS NULL) OR
           (NULIQUIDATIONMETHOD NOT IN (OR_BOCONSTANTS.CNUMETODO_FIXED_PRICE, OR_BOCONSTANTS.CNUMETODO_UNITARY_PRICE,
                                       OR_BOCONSTANTS.CNUMETODO_DELEGATE_PRICE)) THEN
            UT_TRACE.TRACE('El tipo de trabajo no tiene generacion de cargos por 1, 2, 3 o 5',15);
            IORCORDER.CHARGE_STATUS := OR_BOCONSTANTS.CNUCHARGE_NOT_GENERATE;
            RETURN;
        END IF;

        
        IF (NUPRODUCTID IS NULL) THEN
            
            NUPRODUCTID := OR_BCORDERACTIVITIES.FNUGETPRODUCTIDBYORDER(IORCORDER.ORDER_ID);
        END IF;

        
        IF NUPRODUCTID IS NULL THEN
            UT_TRACE.TRACE('No existe producto asociado a la orden',15);
            IORCORDER.CHARGE_STATUS := OR_BOCONSTANTS.CNUCHARGE_NOT_GENERATE;
            RETURN;
        END IF;

        
        NUPACKAGEIDTEMP := NUPACKAGEID;

        
        OR_BOCONCEPTVALUE.GETCONCEPTVALUEBYORDERID(IORCORDER,NULIQUIDATIONMETHOD,TBCONCEPT, NUPACKAGEID, TBDISCOUNTCONCEPTS);
        
        UT_TRACE.TRACE('tbDiscountConcepts.count ['||TBDISCOUNTCONCEPTS.COUNT||']',15);
        
        
        
        IF (IBLADJORDERCALL) THEN
            TBDISCOUNTCONCEPTS.DELETE;
        END IF;

        SBDOCSOPORTE := CSBPREFIJODOC||CSBSEPDOCPAYMENT||NUPACKAGEID;
        DTFECHA      := SYSDATE;

        
        IF  (TBCONCEPT.COUNT = 0) THEN
            UT_TRACE.TRACE('No existen conceptos asociados',15);
            RETURN;
        END IF;

        
        IF TBCONCEPT.COUNT = 1 THEN
            IF (TBCONCEPT(TBCONCEPT.FIRST).NUCONCEPTID IS NULL) THEN
            
                UT_TRACE.TRACE('Concepto Nulos no se generan cargos',15);

                
                IORCORDER.CHARGE_STATUS := OR_BOCONSTANTS.CNUCHARGE_PENDING;
                RETURN;
            END IF;
        END IF;


        


        
         






        
         
        IF(NUPACKAGEIDTEMP IS NOT NULL)THEN

            
            IF( DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(NUPACKAGEIDTEMP) = CNUTECHNICAL_SERV_REQ ) THEN

                UT_TRACE.TRACE('Generacion de cargos para servicio tecnico',15);

                
                MO_BOPACKAGEPAYMENT.GETIDPACKPAYMENT(
                        NUPACKAGEIDTEMP,
                        NURATING_PACKAGE_ID,
                        FALSE);

                
                IF( NURATING_PACKAGE_ID IS NULL ) THEN
                    
                    NUCOMM_PLAN_ID := DAPR_PRODUCT.FNUGETCOMMERCIAL_PLAN_ID(NUPRODUCTID);

                    
                    MO_BOPACKAGEPAYMENT.INSERTREGBASIC(
                            NUPACKAGEIDTEMP,
                            NUCOMM_PLAN_ID,
                            NURATING_PACKAGE_ID);
                END IF;
            END IF;
         END IF;

        
        NUPRODUCTTYPE := PKTBLSERVSUSC.FNUGETSERVICE(NUPRODUCTID);

        UT_TRACE.TRACE('nuProductType ['||NUPRODUCTTYPE||']',15);

        
        NUORDERCHARGECAUSE := FA_BOCHARGECAUSES.FNUORDERCHCAUSE(NUPRODUCTTYPE);

        UT_TRACE.TRACE('Or_bochargesGenerate.Liquidacion',15);
        NUINDEX := TBCONCEPT.FIRST;
        LOOP
            
            GENCHARGES
            (
                NUPRODUCTID,
                CSBDEBITSIGN,
                TBCONCEPT(NUINDEX).NUCONCEPTID,
                NUORDERCHARGECAUSE,
                TBCONCEPT(NUINDEX).NUVALUE,
                SBDOCSOPORTE,
                DTFECHA,
                IORCORDER.ORDER_ID,
	            NUERRORCODE,
            	SBERRORMESSAGE
            );
            
    		IF (  NUERRORCODE <> GE_BOCONSTANTS.CNUSUCCESS ) THEN
                IORCORDER.CHARGE_STATUS := OR_BOCONSTANTS.CNUCHARGE_PENDING;
                UT_TRACE.TRACE('Generacion de Cargos pendientes ',15);
                RETURN;
            END IF;
            UT_TRACE.TRACE('Concepto cargo: '||NUINDEX,15);

            EXIT WHEN NUINDEX = TBCONCEPT.LAST;
            NUINDEX := TBCONCEPT.NEXT(NUINDEX);
        END LOOP;


        
        APPDISCOUNTBYQUOTATION(IORCORDER.ORDER_ID,NUPRODUCTID, SBDOCSOPORTE, DTFECHA,NULIQUIDATIONMETHOD, TBDISCOUNTCONCEPTS);


        PKINSTANCEDATAMGR.SETCG_CONSUMPERIOD(NULL);
        PKINSTANCEDATAMGR.SETTG_SUPPDOC(NULL);

        PKSUBSCRIBERMGR.ACCCURRENTPERIOD(
		DAPR_PRODUCT.FNUGETSUBSCRIPTION_ID(NUPRODUCTID),
		RCPERIFACT,
		PKCONSTANTE.NOCACHE
	    );

        PKBOLIQUIDATETAX.LIQTAXVALUE(
            PKTBLSERVSUSC.FRCGETRECORD(NUPRODUCTID),
            RCPERIFACT,
            SBDOCSOPORTE,
            NULL,
            DTFECHA
        );
        
        APPLIQUIDATIONPARAM(IORCORDER.ORDER_ID,NUPRODUCTID, TBCONCEPT, SBDOCSOPORTE, DTFECHA,NULIQUIDATIONMETHOD);

        IORCORDER.CHARGE_STATUS := OR_BOCONSTANTS.CNUCHARGE_GENERATE;

        UT_TRACE.TRACE('FINALIZA or_boChargesGenerate.GenChargesByOrder',1);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Controlled-Error Generando cargos ',15);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Others Error Generando cargos ',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GENCHARGESBYORDER;
    
    
    














    PROCEDURE GENADJUSTCHARGES
    (
        IRCOLDORDER     IN  DAOR_ORDER.STYOR_ORDER,
        IORCNEWORDER    IN OUT  DAOR_ORDER.STYOR_ORDER
    )
    IS
        NULIQUIDATIONMETHOD PS_PACKAGE_TYPE.LIQUIDATION_METHOD%TYPE;
        NUPRODUCTID         PR_PRODUCT.PRODUCT_ID%TYPE;
        NUPACKAGEID         MO_PACKAGES.PACKAGE_ID%TYPE;
        NUCONCEPT           OR_TASK_TYPE.CONCEPT%TYPE;
        NUTOTALVALUE        OR_ORDER.ORDER_VALUE%TYPE;
        TBCONCEPT           OR_BCCONCEPTVALUE.TBCONCEPTS;
        


        SBDOCSOPORTE        VARCHAR2(2000);
        DTFECHA             DATE;

        NUINDEX             NUMBER;

         
        NUCOMM_PLAN_ID      PR_PRODUCT.COMMERCIAL_PLAN_ID%TYPE;

        
        NURATING_PACKAGE_ID MO_PACKAGE_PAYMENT.PACKAGE_PAYMENT_ID%TYPE;


	    NUERRORCODE	       GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
    	SBERRORMESSAGE	   GE_ERROR_LOG.DESCRIPTION%TYPE;

        
        NUORDERCHARGECAUSE  CAUSCARG.CACACODI%TYPE;

        
        NUPRODUCTTYPE       SERVICIO.SERVCODI%TYPE;

    
        CURSOR CUGETVALUE
        (
            INUOLDORDERID   IN  OR_ORDER.ORDER_ID%TYPE,
            INUNEWORDERID   IN  OR_ORDER.ORDER_ID%TYPE
        )
        IS
        SELECT AJUSTE.ITEMS_ID ,  ORIGINAL.TOTAL_PRICE*AJUSTE.LEGAL_ITEM_AMOUNT/ORIGINAL.LEGAL_ITEM_AMOUNT  VALOR
        FROM OR_ORDER_ITEMS ORIGINAL, OR_ORDER_ITEMS AJUSTE
            WHERE AJUSTE.ITEMS_ID = ORIGINAL.ITEMS_ID
                AND AJUSTE.OUT_ = 'N'  AND ORIGINAL.OUT_ = 'Y'
                AND ORIGINAL.LEGAL_ITEM_AMOUNT > 0
                AND ORIGINAL.TOTAL_PRICE>0
                AND AJUSTE.ORDER_ID = INUNEWORDERID
                AND ORIGINAL.ORDER_ID = INUOLDORDERID;
    BEGIN
        UT_TRACE.TRACE('INIT or_boChargesGenerate.genAdjustCharges',1);
        
        
        IF (IRCOLDORDER.CHARGE_STATUS=OR_BOCONSTANTS.CNUCHARGE_GENERATE) THEN

            OR_BOITEMVALUE.GETLIQMETHOD(IORCNEWORDER.ORDER_ID, NUPACKAGEID, NULIQUIDATIONMETHOD);

            IF(NUPACKAGEID IS  NOT NULL) THEN
                
                NUPRODUCTID := MO_BOENGINEERINGSERV.FNUGETENGINSERVPRODUCT(NUPACKAGEID);
            END IF;

            
            IF(NULIQUIDATIONMETHOD = OR_BOCONSTANTS.CNUMETODO_FIXED_PRICE) THEN
                UT_TRACE.TRACE('Metodo de liquidacion 1 - Costo Fijo, no requiere devolucion',15);
                IORCNEWORDER.CHARGE_STATUS := OR_BOCONSTANTS.CNUCHARGE_NOT_GENERATE;
                RETURN;
            END IF;
            
            
            
            
            IF (NULIQUIDATIONMETHOD IS NULL) OR
               (NULIQUIDATIONMETHOD NOT IN (OR_BOCONSTANTS.CNUMETODO_UNITARY_PRICE,
                                           OR_BOCONSTANTS.CNUMETODO_DELEGATE_PRICE)) THEN
                UT_TRACE.TRACE('El tipo de trabajo no tiene generacion de cargos por 2 o 3',15);
                IORCNEWORDER.CHARGE_STATUS := OR_BOCONSTANTS.CNUCHARGE_NOT_GENERATE;
                RETURN;
            END IF;

            
            IF (NUPRODUCTID IS NULL) THEN
                
                NUPRODUCTID := OR_BCORDERACTIVITIES.FNUGETPRODUCTIDBYORDER(IORCNEWORDER.ORDER_ID);

                
                IF NUPRODUCTID IS NULL THEN
                    UT_TRACE.TRACE('No existe producto asociado a la orden',15);
                    IORCNEWORDER.CHARGE_STATUS := OR_BOCONSTANTS.CNUCHARGE_NOT_GENERATE;
                    RETURN;
                END IF;
                
            END IF;
            
            NUTOTALVALUE := 0;
            
            
            FOR RCITEMVALUE IN  CUGETVALUE(IRCOLDORDER.ORDER_ID, IORCNEWORDER.ORDER_ID)  LOOP

                NUCONCEPT := DAGE_ITEMS.FNUGETCONCEPT(RCITEMVALUE.ITEMS_ID);
                
                UT_TRACE.TRACE('rcItemValue.items_id='||RCITEMVALUE.ITEMS_ID||'-'||RCITEMVALUE.VALOR||'-'||NUCONCEPT,10);
                
                IF(NUCONCEPT IS NOT NULL) AND (RCITEMVALUE.VALOR > 0) THEN
                
                    
                    IF(TBCONCEPT.EXISTS(NUCONCEPT)) THEN
                        TBCONCEPT(NUCONCEPT).NUVALUE := TBCONCEPT(NUCONCEPT).NUVALUE + RCITEMVALUE.VALOR;
                    ELSE
                    
                        TBCONCEPT(NUCONCEPT).NUCONCEPTID := NUCONCEPT;
                        TBCONCEPT(NUCONCEPT).NUVALUE := RCITEMVALUE.VALOR;
                    END IF;
                    
                END IF;
                
                NUTOTALVALUE := NUTOTALVALUE + RCITEMVALUE.VALOR;
                
            END LOOP;
            
            UT_TRACE.TRACE('nuTotalValue='||NUTOTALVALUE,10);
            
            IF NULIQUIDATIONMETHOD IN (OR_BOCONSTANTS.CNUMETODO_DELEGATE_PRICE) THEN

                TBCONCEPT.DELETE;

                NUCONCEPT := DAOR_TASK_TYPE.FNUGETCONCEPT(IORCNEWORDER.TASK_TYPE_ID);

                IF (NUCONCEPT IS NOT NULL AND NUTOTALVALUE > 0) THEN
                
                    TBCONCEPT(NUCONCEPT).NUCONCEPTID := NUCONCEPT;
                    TBCONCEPT(NUCONCEPT).NUVALUE := NUTOTALVALUE;
                END IF;
            
            ELSIF  (NULIQUIDATIONMETHOD <> OR_BOCONSTANTS.CNUMETODO_UNITARY_PRICE) THEN
            
                TBCONCEPT.DELETE;
            END IF;
            
            IF(TBCONCEPT.COUNT > 0) THEN

                SBDOCSOPORTE := CSBPREFIJODOC||CSBSEPDOCPAYMENT||NUPACKAGEID;
                DTFECHA      := SYSDATE;

                
                NUPRODUCTTYPE := PKTBLSERVSUSC.FNUGETSERVICE(NUPRODUCTID);

                UT_TRACE.TRACE('nuProductType ['||NUPRODUCTTYPE||']',15);

                
                NUORDERCHARGECAUSE := FA_BOCHARGECAUSES.FNUORDERCHCAUSE(NUPRODUCTTYPE);

                UT_TRACE.TRACE('Or_bochargesGenerate.liquidandoAjuste',15);
                NUINDEX := TBCONCEPT.FIRST;
                LOOP
                    
                    GENCHARGES
                    (
                        NUPRODUCTID,
                        CSBCREDITSIGN,
                        TBCONCEPT(NUINDEX).NUCONCEPTID,
                        NUORDERCHARGECAUSE,
                        TBCONCEPT(NUINDEX).NUVALUE,
                        SBDOCSOPORTE,
                        DTFECHA,
                        IORCNEWORDER.ORDER_ID,
                        NUERRORCODE,
                    	SBERRORMESSAGE
                    );
                    
                	IF (  NUERRORCODE <> GE_BOCONSTANTS.CNUSUCCESS ) THEN
                        IORCNEWORDER.CHARGE_STATUS := OR_BOCONSTANTS.CNUCHARGE_PENDING;
                        UT_TRACE.TRACE('Generacion de Cargos de Ajuste pendientes ',15);
                        RETURN;
                    END IF;
                    UT_TRACE.TRACE('Concepto cargo: '||NUINDEX,15);

                    EXIT WHEN NUINDEX = TBCONCEPT.LAST;
                    NUINDEX := TBCONCEPT.NEXT(NUINDEX);
                END LOOP;


                IORCNEWORDER.CHARGE_STATUS := OR_BOCONSTANTS.CNUCHARGE_GENERATE;
                
            END IF;

            
            
        END IF;
        
        
    
        UT_TRACE.TRACE('FINALIZA or_boChargesGenerate.genAdjustCharges',1);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Controlled-Error Generando cargos de ajuste',15);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Others Error Generando cargos de ajuste',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GENADJUSTCHARGES;

    


































    PROCEDURE GENCHARGESBYDAMAGEID
    (
        INUPACKAGEID    IN    OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE
    )
    IS
        TBCONCEPT           OR_BCCONCEPTVALUE.TBCONCEPTS;
        TBORDERS            DAOR_ORDER.TYTBORDER_ID;
        NUPRODUCTID         PR_PRODUCT.PRODUCT_ID%TYPE;
        NUDAMCAUSALID       TT_DAMAGE.DAMAGE_CAUSAL_ID%TYPE;
        NUATTRIBUTEDTO      GE_CAUSAL.ATTRIBUTED_TO%TYPE:= -1;
        NUORDER_ID          OR_ORDER.ORDER_ID%TYPE;
        SBDOCSOPORTE        VARCHAR2(2000);
        DTFECHA             DATE;
        NUINDEX             NUMBER;
	    NUERRORCODE	        GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
    	SBERRORMESSAGE	    GE_ERROR_LOG.DESCRIPTION%TYPE;

        CNUATTRIBUTEDCLIENT CONSTANT NUMBER := 1;
        NULIQUIDMETHODID    PS_PACKAGE_TYPE.LIQUIDATION_METHOD%TYPE;
        RCORDER             DAOR_ORDER.STYOR_ORDER;
        TBCHARGES           OR_BCCONCEPTVALUE.TBCONCEPTS;
        TBDISCOUNTCONCEPTS  OR_BCCONCEPTVALUE.TYTBDISCOUNTCONCEPTS;
        
        
        NUORDERCHARGECAUSE  CAUSCARG.CACACODI%TYPE;

        
        NUPRODUCTTYPE       SERVICIO.SERVCODI%TYPE;

        
        PROCEDURE UPDORDERCHARGESTATUS IS
        BEGIN
            NUINDEX := TBORDERS.FIRST;
            WHILE (NUINDEX IS NOT NULL) LOOP
                NUORDER_ID := TBORDERS(NUINDEX);
                DAOR_ORDER.UPDCHARGE_STATUS(NUORDER_ID, OR_BOCONSTANTS.CNUCHARGE_GENERATE);
                NUINDEX := TBORDERS.NEXT(NUINDEX);
            END LOOP;
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END;

    BEGIN
    
        UT_TRACE.TRACE('INICIA or_boChargesGenerate.GenChargesByDamageId='||TO_CHAR(INUPACKAGEID), 1);

        NUDAMCAUSALID   := DATT_DAMAGE.FNUGETDAMAGE_CAUSAL_ID(INUPACKAGEID);

        IF (NUDAMCAUSALID IS NOT NULL) THEN
            NUATTRIBUTEDTO  := DAGE_CAUSAL.FNUGETATTRIBUTED_TO(NUDAMCAUSALID);
        END IF;
        
        IF (NUATTRIBUTEDTO <> CNUATTRIBUTEDCLIENT)THEN
            UT_TRACE.TRACE('No es imputable al cliente retorna',5);
            RETURN;
        END IF;

        
        NUPRODUCTID := MO_BOPACKAGES.FRCGETINITIALMOTIVE(INUPACKAGEID, FALSE).PRODUCT_ID;
        UT_TRACE.TRACE('Producto a generarle cargos['||NUPRODUCTID||']',5);

        
        
        
        OR_BOCONCEPTVALUE.GETCONCEPTVALUEBYDAMAGEID(INUPACKAGEID, TBCONCEPT, TBORDERS, TBDISCOUNTCONCEPTS);

        SBDOCSOPORTE := CSBPREFIJODOC||CSBSEPDOCPAYMENT||INUPACKAGEID;
        DTFECHA      := SYSDATE;
        
        
        IF  (TBCONCEPT.COUNT = 0) THEN
            UPDORDERCHARGESTATUS;
            UT_TRACE.TRACE('No existen conceptos asociados',5);
            RETURN;
        END IF;
        
        
        NUPRODUCTTYPE := PKTBLSERVSUSC.FNUGETSERVICE(NUPRODUCTID);

        
        NUORDERCHARGECAUSE := FA_BOCHARGECAUSES.FNUORDERCHCAUSE(NUPRODUCTTYPE);

        NUINDEX := TBCONCEPT.FIRST;
        LOOP
            
            BEGIN

                
                GENCHARGES
                (
                    NUPRODUCTID,
                    CSBDEBITSIGN,
                    TBCONCEPT(NUINDEX).NUCONCEPTID,
                    NUORDERCHARGECAUSE,
                    TBCONCEPT(NUINDEX).NUVALUE,
                    SBDOCSOPORTE,
                    DTFECHA,
                    TBCONCEPT(NUINDEX).NUORDERID,
    	            NUERRORCODE,
                	SBERRORMESSAGE
                 );

             EXCEPTION
                WHEN OTHERS THEN
                    UT_TRACE.TRACE('Erroro generando cargos BSS',5);
                    NULL;
            END;
            
            EXIT WHEN NUINDEX = TBCONCEPT.LAST;
            NUINDEX := TBCONCEPT.NEXT(NUINDEX);
        END LOOP;

        

        NUINDEX := TBORDERS.FIRST;
        WHILE (NUINDEX IS NOT NULL) LOOP
            DAOR_ORDER.GETRECORD(TBORDERS(NUINDEX),RCORDER);

            UT_TRACE.TRACE('ProcesandoOrden='||TBORDERS(NUINDEX), 15);

            
            
            
            TBCHARGES.DELETE;
            IF  (RCORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED) AND
                (RCORDER.CHARGE_STATUS <> OR_BOCONSTANTS.CNUCHARGE_GENERATE) AND
                (DAGE_CAUSAL.FNUGETATTRIBUTED_TO(RCORDER.CAUSAL_ID) = CNUATTRIBUTEDCLIENT) THEN

                UT_TRACE.TRACE('Se generan cargos a la orden='||TBORDERS(NUINDEX), 15);

                
                NULIQUIDMETHODID := MO_BOPACKAGES.FNUGETLIQUIDMETHOD(INUPACKAGEID);
                
                
                OR_BOCONCEPTVALUE.GETCONCEPTVALUEBYORDERID(RCORDER, NULIQUIDMETHODID,TBCHARGES, INUPACKAGEID, TBDISCOUNTCONCEPTS);
                
                APPDISCOUNTBYQUOTATION(TBORDERS(NUINDEX), NUPRODUCTID, SBDOCSOPORTE, DTFECHA, NULIQUIDMETHODID, TBDISCOUNTCONCEPTS);
                
                APPLIQUIDATIONPARAM(TBORDERS(NUINDEX),NUPRODUCTID, TBCHARGES, SBDOCSOPORTE, DTFECHA,NULIQUIDMETHODID);
            END IF;

             DAOR_ORDER.UPDCHARGE_STATUS(TBORDERS(NUINDEX), OR_BOCONSTANTS.CNUCHARGE_GENERATE);
            NUINDEX := TBORDERS.NEXT(NUINDEX);
        END LOOP;

         UT_TRACE.TRACE('FINALIZA or_boChargesGenerate.GenChargesByDamageId',10);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END GENCHARGESBYDAMAGEID;

    














    PROCEDURE VALCUOTASFINANCIAR
    IS
        NUPLANDIFE  PLANDIFE.PLDICODI%TYPE;
        NUCUOTAS    NUMBER;

        RCPLANDIFE  PLANDIFE%ROWTYPE;
        SBATTRIBUTE VARCHAR2(100);
    BEGIN
        UT_TRACE.TRACE('Inicia or_boChargesGenerate.valCuotasFinanciar',15);

        NUPLANDIFE := OR_BOINSTANCEACTIVITIES.FSBGETATTRIBUTEVALUE('FINANCING_PLAN_',OR_BOLEGALIZEACTIVITIES.FNUGETCURRACTIVITY);

        IF NUPLANDIFE IS NULL THEN
            ERRORS.SETERROR(CNUFINANCINGPLAN);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        GE_BOINSTANCE.GETINSTANCE(SBATTRIBUTE, NUCUOTAS); 

        RCPLANDIFE := PKTBLPLANDIFE.FRCGETRECORD( NUPLANDIFE );

        IF NVL(NUCUOTAS,-1) < RCPLANDIFE.PLDICUMI  OR NUCUOTAS > RCPLANDIFE.PLDICUMA THEN
            ERRORS.SETERROR(1428,RCPLANDIFE.PLDICUMI||'|'||RCPLANDIFE.PLDICUMA||'|'||RCPLANDIFE.PLDIDESC);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        UT_TRACE.TRACE('Finaliza or_boChargesGenerate.valCuotasFinanciar',15);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALCUOTASFINANCIAR;

    BEGIN
        LOAD;
END OR_BOCHARGESGENERATE;