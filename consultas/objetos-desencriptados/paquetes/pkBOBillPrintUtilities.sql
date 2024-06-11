PACKAGE BODY pkBOBillPrintUtilities AS































































































































    
    
    

    TYPE RCACCUMTABLE IS RECORD(
         
         VALUE_     NUMBER,
         
         ISACCUM    BOOLEAN
    );

    
    TYPE TYTBACCUMTABLE IS TABLE OF RCACCUMTABLE INDEX BY VARCHAR2(250);
    
    TYPE TYTBCOUNTBLOQS IS TABLE OF NUMBER INDEX BY VARCHAR2(250);

    
    GTBACCUMBYVARTABLE TYTBACCUMTABLE;
    GTBCOUNTBLOQS      TYTBCOUNTBLOQS;
    GTBCOUNTVAR        TYTBCOUNTBLOQS;
    
    
    

    
    CSBVERSION         CONSTANT VARCHAR2(250) := 'SAO214228';
    
    CNUERROR_GENERAL   CONSTANT GE_ERROR_LOG.ERROR_LOG_ID%TYPE :=  2741;
    CNUERROR_ROUTE     CONSTANT GE_ERROR_LOG.ERROR_LOG_ID%TYPE :=  14772;

    
    
    

    
    SBERRMSG	                           GE_ERROR_LOG.DESCRIPTION%TYPE;

    
    GSBBILLIDENTIFIER                      VARCHAR2(100);
    
    
    GSBACCUMULATEDVAR                      VARCHAR2(250);
    
    
    

    
    
    
    
    














    FUNCTION FBOEXISTSORDERACTIVITY
    (
        INUACTIVITYID       IN  OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE,
        INUSUBSCRIPTIONID   IN  OR_ORDER_ACTIVITY.SUBSCRIPTION_ID%TYPE,
        INUREFERENCEVALUE   IN  OR_ORDER_ACTIVITY.VALUE_REFERENCE%TYPE,
        INUADDRESSID        IN  OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE
    )
    RETURN BOOLEAN
    IS
        TBACTIVITY          DAOR_ORDER_ACTIVITY.TYTBOR_ORDER_ACTIVITY;
    BEGIN
        UT_TRACE.TRACE('Begin pkBOBillPrintUtilities.fboExistsOrderActivity['||INUACTIVITYID||']['||INUSUBSCRIPTIONID||']['||INUREFERENCEVALUE||']['||INUADDRESSID||']', 15 );
        
        
        OR_BCORDERACTIVITIES.GETSUSBACTIBYREFVALUE
        (
            INUSUBSCRIPTIONID,
            INUREFERENCEVALUE,
            INUACTIVITYID,
            TBACTIVITY
        );
        
        
        IF  (TBACTIVITY.COUNT > 0) THEN
        
            FOR I IN TBACTIVITY.FIRST .. TBACTIVITY.LAST LOOP
            
                IF  (TBACTIVITY(I).ADDRESS_ID = INUADDRESSID) THEN
                    UT_TRACE.TRACE('End pkBOBillPrintUtilities.fboExistsOrderActivity OK', 15 );
                    RETURN TRUE;
                END IF;
            
            END LOOP;
        
        END IF;

        UT_TRACE.TRACE('End pkBOBillPrintUtilities.fboExistsOrderActivity NOK', 15 );
        
        RETURN FALSE;
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBOEXISTSORDERACTIVITY;

    

























    PROCEDURE GENORDERACTIVITY
    (
        INUACTIVITYID       IN  OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE,
        INUSUBSCRIPTIONID   IN  OR_ORDER_ACTIVITY.SUBSCRIPTION_ID%TYPE,
        INUREFERENCEVALUE   IN  OR_ORDER_ACTIVITY.VALUE_REFERENCE%TYPE,
        INUADDRESSID        IN  OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE
    )
    IS
        NUORDERID           OR_ORDER_ACTIVITY.ORDER_ID%TYPE;
        NUORDERACTIVITYID   OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
    BEGIN
        UT_TRACE.TRACE('Begin pkBOBillPrintUtilities.GenOrderActivity['||INUACTIVITYID||']['||INUSUBSCRIPTIONID||']['||INUREFERENCEVALUE||']['||INUADDRESSID||']', 15 );

        
        IF  NOT PKBOBILLPRINTUTILITIES.FBOEXISTSORDERACTIVITY
            (
                INUACTIVITYID,
                INUSUBSCRIPTIONID,
                INUREFERENCEVALUE,
                INUADDRESSID
            )
        THEN
            
            OR_BOORDERACTIVITIES.CREATEACTIVITY
            (
                INUACTIVITYID,          
                NULL,                   
                NULL,                   
                NULL,                   
                NULL,                   
                INUADDRESSID,           
                NULL,                   
                NULL,                   
                INUSUBSCRIPTIONID,      
                NULL,                   
                NULL,                   
                NULL,                   
                NULL,                   
                NULL,                   
                NULL,                   
                FALSE,                  
                NULL,                   
                NUORDERID,              
                NUORDERACTIVITYID,      
                NULL,                   
                GE_BOCONSTANTS.CSBNO,   
                NULL,                   
                NULL,                   
                NULL,                   
                NULL,                   
                NULL,                   
                TRUE,                   
                INUREFERENCEVALUE       
            );

        END IF;

        UT_TRACE.TRACE('End pkBOBillPrintUtilities.GenOrderActivity['||NUORDERACTIVITYID||']['||NUORDERID||']', 15 );
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GENORDERACTIVITY;

    
    
    

    























    FUNCTION FSBVERSION RETURN VARCHAR2 IS

    BEGIN
        
        RETURN (CSBVERSION);
    END FSBVERSION;

    































    FUNCTION FSBDATEFORMAT
    (
        IDTDATE         IN      DATE,
        ISBFORMAT       IN      VARCHAR2
    ) RETURN VARCHAR2
    IS
    
        
        SBFORMATTEDDATE         VARCHAR2(200);
        
    BEGIN
    
        PKERRORS.PUSH( 'pkBOBillPrintUtilities.fsbDateFormat' );

        SBFORMATTEDDATE := TO_CHAR( IDTDATE, ISBFORMAT );

        PKERRORS.POP;

        RETURN SBFORMATTEDDATE;

    EXCEPTION
    
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    
    END FSBDATEFORMAT;

    




















    FUNCTION FNUROUND (INUNUMBER NUMBER, INUROUND NUMBER) RETURN NUMBER
    IS
        NUVALOR NUMBER;
    BEGIN
        PKERRORS.PUSH('pkBOBillPrintUtilities.fnuRound');

        NUVALOR := ROUND(INUNUMBER, INUROUND);

        PKERRORS.POP;

        RETURN NUVALOR;

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
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    
    END FNUROUND;

    




















    FUNCTION FNUTRUNC (INUNUMBER NUMBER, INUTRUNC NUMBER) RETURN NUMBER
    IS
        NUVALOR NUMBER;
    BEGIN
        PKERRORS.PUSH('pkBOBillPrintUtilities.fnuTrunc');

        NUVALOR := TRUNC(INUNUMBER, INUTRUNC);

        PKERRORS.POP;

        RETURN NUVALOR;

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
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    
    END FNUTRUNC;

    




















    FUNCTION FSBASCII (INUASCII NUMBER) RETURN VARCHAR
    IS
        SBVALOR VARCHAR2(250);
    BEGIN
        PKERRORS.PUSH('pkBOBillPrintUtilities.fsbAscii');

        SBVALOR := CHR(INUASCII);

        PKERRORS.POP;

        RETURN SBVALOR;

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
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    
    END FSBASCII;

    



















    FUNCTION FSBFILL
    (
        ISBSTRING   IN  VARCHAR2,
        INULENGTH   IN  NUMBER,
        ISBFILLER   IN  VARCHAR2
    )
    RETURN VARCHAR2
    IS
        
        
        
        SBVALUE     VARCHAR2(1000);
    BEGIN

        PKERRORS.PUSH ('pkBOBillPrintUtilities.fsbFill');

        IF LENGTH(ISBSTRING) >= INULENGTH THEN

            SBVALUE := ISBSTRING;
            
        ELSE
            
            SBVALUE := LPAD( ISBSTRING, INULENGTH, ISBFILLER );
            
        END IF;
        
        PKERRORS.POP;

        RETURN SBVALUE;

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

    END FSBFILL;

    



















    FUNCTION FNUGETITERATIONNUMBER
    RETURN NUMBER
    IS
        
        
        
        NUITERATNUMBER  NUMBER;
    BEGIN

        PKERRORS.PUSH ('pkBOBillPrintUtilities.fnuGetIterationNumber');

        NUITERATNUMBER := PKBODATAEXTRACTOR.FNUGETITERATIONNUMBER;

        PKERRORS.POP;

        RETURN NUITERATNUMBER;

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

    END FNUGETITERATIONNUMBER;

    



























    FUNCTION FSBCONVERTDATE
    (
        ISBDATE         VARCHAR2,
        ISBORIGINFORMAT VARCHAR2,
        ISBTARGETFORMAT VARCHAR2
    )
    RETURN VARCHAR2
    IS
        SBFECHA VARCHAR2(200);
    BEGIN
        PKERRORS.PUSH('pkBOBillPrintUtilities.fsbConvertDate');

        SBFECHA := TO_CHAR( TO_DATE(ISBDATE,ISBORIGINFORMAT), ISBTARGETFORMAT );

        PKERRORS.POP;

        RETURN TRIM( SBFECHA );

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
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    END FSBCONVERTDATE;
    
    
    
























    
    FUNCTION FSBTRIM
    (
        ISBSTRING   IN  VARCHAR2,
        ISBTRIMMODE IN  VARCHAR2
    ) RETURN VARCHAR2
    IS
    
        
        
        
        
        
        CSBLEFTTRIM     VARCHAR2(1) := 'L';
        
        
        
        CSBRIGHTTRIM    VARCHAR2(1) := 'R';
    
    BEGIN
    
        PKERRORS.PUSH( 'pkBOBillPrintUtilities.fsbTrim' );
        PKERRORS.POP;

        IF ( ISBTRIMMODE = CSBLEFTTRIM ) THEN
            RETURN LTRIM( ISBSTRING );
        ELSIF ( ISBTRIMMODE = CSBRIGHTTRIM ) THEN
            RETURN RTRIM( ISBSTRING );
        ELSE
            RETURN TRIM( ISBSTRING );
        END IF;

    EXCEPTION
    
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    
    END FSBTRIM;
    
    
    

























    FUNCTION FSBNUMBERFORMAT
    (
        INUNUMBER       IN  NUMBER,
        ISBFORMAT       IN  VARCHAR2,
        ISBNLSPARAMS    IN  VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2
    IS
    
        
        
        SBFORMATTEDNUMBER       VARCHAR2(50);
    
    BEGIN
    
        PKERRORS.PUSH( 'pkBOBillPrintUtilities.fsbNumberFormat' );
        
        
        IF ( ISBNLSPARAMS IS NOT NULL ) THEN
        
            
            SBFORMATTEDNUMBER := TO_CHAR( INUNUMBER, ISBFORMAT, ISBNLSPARAMS );
        
        ELSE
        
            
            SBFORMATTEDNUMBER := TO_CHAR( INUNUMBER, ISBFORMAT );
        
        END IF;
        
        PKERRORS.POP;

        RETURN SBFORMATTEDNUMBER;

    EXCEPTION

        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    
    END FSBNUMBERFORMAT;

    
    































    FUNCTION FNUGETACCUMULATEDVALUE
    (
        ISBVAR VARCHAR2 DEFAULT NULL

    )
    RETURN NUMBER
    IS
        BILLIDENTIFIER      VARCHAR2(100);
        SBVAR               VARCHAR2(250);
    BEGIN
    
        PKERRORS.PUSH('pkBOBillPrintUtilities.fnuGetAccumulatedValue');

        
        PKBOINSTANCEPRINTINGDATA.GETBILLIDENTIFIER(BILLIDENTIFIER);

        
        IF( GSBBILLIDENTIFIER <> BILLIDENTIFIER ) THEN
             GTBACCUMBYVARTABLE.DELETE;
        END IF;
        
        
        IF (ISBVAR IS NULL) THEN
            
            SBVAR := GSBACCUMULATEDVAR;
        ELSE
            
            SBVAR := ISBVAR;
        END IF;
        
        
        
        IF( GTBACCUMBYVARTABLE.EXISTS(SBVAR)) THEN
        
            
            
            
            GTBACCUMBYVARTABLE(SBVAR).ISACCUM := FALSE;
            
            PKERRORS.POP;
            
            RETURN (GTBACCUMBYVARTABLE(SBVAR).VALUE_);

        
        ELSE
            PKERRORS.POP;
            RETURN 0;
        END IF;


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
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    
    END FNUGETACCUMULATEDVALUE;
    
    
    






















    
    PROCEDURE SETACCUMULATEDVALUE
    (
        ISBVAR VARCHAR2,
        INUVALUE NUMBER
    )
    IS
    NUVALUE NUMBER;
    BILLIDENTIFIER                       VARCHAR2(100);
    
    BEGIN

        PKERRORS.PUSH('pkBOBillPrintUtilities.SetAccumulatedValue');

        
        PKBOINSTANCEPRINTINGDATA.GETBILLIDENTIFIER(BILLIDENTIFIER);

        
        IF(GSBBILLIDENTIFIER <> BILLIDENTIFIER) THEN
             GTBACCUMBYVARTABLE.DELETE;
        END IF;

        IF(ISBVAR IS NULL) THEN
            PKERRORS.POP;
            RETURN;
        END IF;

        NUVALUE:= NVL(INUVALUE,0);

        
        IF(NOT(GTBACCUMBYVARTABLE.EXISTS(ISBVAR))) THEN

           
           GTBACCUMBYVARTABLE(ISBVAR).VALUE_:=0;
           
           GTBACCUMBYVARTABLE(ISBVAR).ISACCUM :=TRUE;
           
        END IF;

        
        IF(GTBACCUMBYVARTABLE(ISBVAR).ISACCUM) THEN
           
           GTBACCUMBYVARTABLE(ISBVAR).VALUE_ := GTBACCUMBYVARTABLE(ISBVAR).VALUE_ + NUVALUE;
        ELSE
            
            GTBACCUMBYVARTABLE(ISBVAR).VALUE_ := NUVALUE;
            GTBACCUMBYVARTABLE(ISBVAR).ISACCUM := TRUE;
        END IF;

        GSBBILLIDENTIFIER := BILLIDENTIFIER;

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
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    
    END SETACCUMULATEDVALUE;
    
    















    FUNCTION FSBGETAPPLICATION
    RETURN VARCHAR2
    IS
        
        
        
        
        SBVALUE     VARCHAR2(1000);
    BEGIN

        PKERRORS.PUSH ('pkBOBillPrintUtilities.fsbGetApplication');

        
        SBVALUE:=PKERRORS.FSBGETAPPLICATION;

        PKERRORS.POP;
        
        RETURN SBVALUE;

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

    END FSBGETAPPLICATION;
    
    
    















    FUNCTION FSBSETBLOCKACCUMVALUES
    RETURN VARCHAR2
    IS
        
        
        
    BEGIN

        PKERRORS.PUSH ('pkBOBillPrintUtilities.fsbSetBlockAccumValues');

        
        IF ( GTBACCUMBYVARTABLE.FIRST IS NULL ) THEN
            PKBODATAEXTRACTOR.PROCESSNEXTBLOCK;
            PKERRORS.POP;
            RETURN( NULL );
        END IF;

        
        IF ( GSBACCUMULATEDVAR IS NULL ) THEN
            GSBACCUMULATEDVAR := GTBACCUMBYVARTABLE.FIRST;
        ELSE
            GSBACCUMULATEDVAR := GTBACCUMBYVARTABLE.NEXT( GSBACCUMULATEDVAR );
        END IF;

        
        IF ( GSBACCUMULATEDVAR IS NULL ) THEN
            
            GTBACCUMBYVARTABLE.DELETE;
            
            
            PKBODATAEXTRACTOR.PROCESSNEXTBLOCK;
        END IF;

        PKERRORS.POP;

        RETURN( NULL );

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

    END FSBSETBLOCKACCUMVALUES;


    




















    FUNCTION FSBGETVARDESCRIPTION
    RETURN VARCHAR2
    IS
        BILLIDENTIFIER      VARCHAR2(100);
    BEGIN

        PKERRORS.PUSH('pkBOBillPrintUtilities.fsbGetVarDescription');

        
        PKBOINSTANCEPRINTINGDATA.GETBILLIDENTIFIER(BILLIDENTIFIER);

        
        IF( GSBBILLIDENTIFIER <> BILLIDENTIFIER ) THEN
             GTBACCUMBYVARTABLE.DELETE;
        END IF;

        
        IF( GTBACCUMBYVARTABLE.EXISTS(GSBACCUMULATEDVAR)) THEN

            PKERRORS.POP;
            
            RETURN (GSBACCUMULATEDVAR);

        
        ELSE
            PKERRORS.POP;
            RETURN NULL;
        END IF;


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
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    
    END FSBGETVARDESCRIPTION;
    
    
    


























    PROCEDURE GENDELIVERYORDER
    (
        INUDELIVERYACT      IN  GE_ITEMS.ITEMS_ID%TYPE,
        INUSUSCCODI         IN  SUSCRIPC.SUSCCODI%TYPE,
        ONUORDERID          OUT OR_ORDER_ACTIVITY.ORDER_ID%TYPE,
        ONUORDERACTIVITY    OUT OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE
    )
    IS
        NUADDRESSID     OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE;
        NUBASEADDRESSID AB_ADDRESS.ADDRESS_ID%TYPE;
        NUTASKTYPEID    OR_ROUTE_TASK_TYPE.TASK_TYPE_ID%TYPE;
        NUPREMISEID     OR_ROUTE_PREMISE.PREMISE_ID%TYPE;
        NUROUTEID       OR_ROUTE_PREMISE.ROUTE_ID%TYPE;
        NUCONSECUTIVE   OR_ROUTE_PREMISE.CONSECUTIVE%TYPE;
    BEGIN

        PKERRORS.PUSH('pkBOBillPrintUtilities.GenDeliveryOrder');

        
        PKTBLSUSCRIPC.ACCKEY(INUSUSCCODI);
        
        NUADDRESSID := PKTBLSUSCRIPC.FNUGETADDRESS_ID(INUSUSCCODI);

        
        NUBASEADDRESSID := AB_BOADDRESS.FNUGETBASEADDR(NUADDRESSID);
        NUPREMISEID := DAAB_ADDRESS.FNUGETESTATE_NUMBER(NUBASEADDRESSID);
        NUTASKTYPEID := OR_BCORDERACTIVITIES.FNUGETTASKTYPEBYACTID(INUDELIVERYACT);
        OR_BCROUTEPREMISE.GETDEDICROUTEPREMTASK(NUPREMISEID,NUTASKTYPEID,NUROUTEID,NUCONSECUTIVE);
        
        
        OR_BOORDERACTIVITIES.CREATEACTIVITY(
                INUDELIVERYACT,         
                NULL,                   
                NULL,                   
                NULL,                   
                NULL,                   
                NUADDRESSID,            
                NULL,                   
                NULL,                   
                INUSUSCCODI,            
                NULL,                   
                NULL,                   
                NULL,                   
                NULL,                   
                NULL,                   
                NULL,                   
                FALSE,                  
                NULL,                   
                ONUORDERID,             
                ONUORDERACTIVITY,       
                NULL,                   
                GE_BOCONSTANTS.CSBNO,   
                NULL,                   
                NUROUTEID,              
                NUCONSECUTIVE           
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
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    END GENDELIVERYORDER;
    
    

















    PROCEDURE COUNTBLOQS
    (
        ISBBLOQNAME         IN ED_BLOQUE.BLOQDESC%TYPE
    )
    IS
        NUCOUNT     NUMBER;
    BEGIN
    
        NUCOUNT := 0;
        
        IF(GTBCOUNTBLOQS.EXISTS(ISBBLOQNAME)) THEN
            NUCOUNT := GTBCOUNTBLOQS(ISBBLOQNAME);
        END IF;

        GTBCOUNTBLOQS(ISBBLOQNAME) := NUCOUNT + 1;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    END COUNTBLOQS;
    
    

















    FUNCTION FNUGETCOUNTBLOQS
    (
        ISBBLOQNAME         IN ED_BLOQUE.BLOQDESC%TYPE
    )
    RETURN NUMBER
    IS
        NUCOUNT     NUMBER;
    BEGIN
    
        NUCOUNT := 0;

        IF(GTBCOUNTBLOQS.EXISTS(ISBBLOQNAME)) THEN
            NUCOUNT := GTBCOUNTBLOQS(ISBBLOQNAME);
        END IF;
        
        RETURN NUCOUNT;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    END FNUGETCOUNTBLOQS;
    
    















    PROCEDURE CLEARCOUNTBLOQS
    IS
    BEGIN

        GTBCOUNTBLOQS.DELETE;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    END CLEARCOUNTBLOQS;
    
    

















    PROCEDURE SETACCUMULATEDVAR
    (
        ISBVARNAME      IN      VARCHAR2,
        INUVALUE        IN      NUMBER
    )
    IS
        NUCOUNT     NUMBER;
    BEGIN
    
        NUCOUNT := 0;

        IF(GTBCOUNTVAR.EXISTS(ISBVARNAME)) THEN
            NUCOUNT := GTBCOUNTVAR(ISBVARNAME);
        END IF;

        GTBCOUNTVAR(ISBVARNAME) := NUCOUNT + INUVALUE;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    END SETACCUMULATEDVAR;
    
    














    FUNCTION FNUGETCOUNTVAR
    (
        ISBVARNAME      IN      VARCHAR2
    )
    RETURN NUMBER
    IS
        NUCOUNT     NUMBER;
    BEGIN

        NUCOUNT := 0;

        IF(GTBCOUNTVAR.EXISTS(ISBVARNAME)) THEN
            NUCOUNT := GTBCOUNTVAR(ISBVARNAME);
        END IF;
        
        RETURN NUCOUNT;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    END FNUGETCOUNTVAR;
    
    













    PROCEDURE CLEARCOUNTVAR
    IS
    BEGIN

        GTBCOUNTVAR.DELETE;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    END CLEARCOUNTVAR;
    
    



























    PROCEDURE GENBILLPRINTORDER
    (
        INUPRINTITEMID      IN  GE_ITEMS.ITEMS_ID%TYPE,
        INUOPERUNITID       IN  OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        INUBILLQUANTITY     IN  NUMBER
    )
    IS
        NUADDRESSID         OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE;
        CSBDEFAULT_ADDRESS  GE_PARAMETER.PARAMETER_ID%TYPE := 'DEFAULT_ADDRESS';
        
        NUORDERID           OR_ORDER_ACTIVITY.ORDER_ID%TYPE;
        NUORDERACTIVITY     OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
    BEGIN
        
        DAGE_ITEMS.ACCKEY(INUPRINTITEMID);

        
        NUADDRESSID := DAOR_OPERATING_UNIT.FNUGETSTARTING_ADDRESS(INUOPERUNITID);
        
        IF(NUADDRESSID IS NULL) THEN
            
            NUADDRESSID := GE_BOPARAMETER.FNUGET(CSBDEFAULT_ADDRESS);
        END IF;

        
        OR_BOORDERACTIVITIES.CREATEACTIVITY(
                INUPRINTITEMID,         
                NULL,                   
                NULL,                   
                NULL,                   
                NULL,                   
                NUADDRESSID,            
                NULL,                   
                NULL,                   
                NULL,                   
                NULL,                   
                NULL,                   
                INUOPERUNITID,          
                NULL,                   
                NULL,                   
                NULL,                   
                FALSE,                  
                NULL,                   
                NUORDERID,              
                NUORDERACTIVITY,        
                NULL,                   
                GE_BOCONSTANTS.CSBNO,   
                NULL,                   
                NULL,                   
                NULL,                   
                0,
                NULL,
                TRUE,
                INUBILLQUANTITY
            );
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    END GENBILLPRINTORDER;
    
    
    






























    FUNCTION FSBGENDELIVERYORDER
    (
        INUPRODUCTTYPE              IN      SERVSUSC.SESUSERV%TYPE,
        INUITEMNEIGHEQUAL           IN      GE_ITEMS.ITEMS_ID%TYPE,
        INUITEMNEIGHDIFERENT        IN      GE_ITEMS.ITEMS_ID%TYPE
    )
    RETURN VARCHAR2
    IS
        BONEIGHBORTHOODEQUAL    BOOLEAN := FALSE;
        SBPRODUCTS              VARCHAR2(10);
        RCBILL                  FACTURA%ROWTYPE;
        RCPRODUCT               SERVSUSC%ROWTYPE;
        RCSUBSCRIPTION          SUSCRIPC%ROWTYPE;
        NUADDRESS               PR_PRODUCT.ADDRESS_ID%TYPE;
        NUITEMID                GE_ITEMS.ITEMS_ID%TYPE;
        RCADDRESS               DAAB_ADDRESS.STYAB_ADDRESS;
        RCADDRESSPRODUCT        DAAB_ADDRESS.STYAB_ADDRESS;
        TBPRODUCTS              PKBOINSTANCEPRINTINGDATA.TYTBPRODUCTS;

    BEGIN
        UT_TRACE.TRACE('[INICIA] pkBOBillPrintUtilities.fsbGenDeliveryOrder('||
                        INUPRODUCTTYPE||','||INUITEMNEIGHEQUAL||','||
                        INUITEMNEIGHDIFERENT||');',1);

        
        PKBOINSTANCEPRINTINGDATA.GETCONTRACT( RCSUBSCRIPTION );

        
        PKBOINSTANCEPRINTINGDATA.GETBILL( RCBILL );

        UT_TRACE.TRACE('Procesa suscripci�n ' || RCSUBSCRIPTION.SUSCCODI ,2);

        
        DAAB_ADDRESS.GETRECORD(RCSUBSCRIPTION.SUSCIDDI, RCADDRESS);

        
        PKBOINSTANCEPRINTINGDATA.GETPRODUCTS(TBPRODUCTS);

        UT_TRACE.TRACE('Obtiene los productos',2);

        RCPRODUCT   := NULL;
        SBPRODUCTS  := TBPRODUCTS.FIRST;

        LOOP
            EXIT WHEN SBPRODUCTS IS NULL;
            IF( TBPRODUCTS(SBPRODUCTS).SESUSERV = INUPRODUCTTYPE )THEN
                RCPRODUCT   :=  TBPRODUCTS(SBPRODUCTS);
                EXIT;
            END IF;
            SBPRODUCTS  := TBPRODUCTS.NEXT(SBPRODUCTS);
        END LOOP;

        UT_TRACE.TRACE('Obtiene el producto ' || RCPRODUCT.SESUNUSE ,2);

        
        IF ( RCPRODUCT.SESUNUSE IS NULL ) THEN
            ERRORS.SETERROR(CNUERROR_GENERAL, 'No se encontr� producto del tipo de producto ' || INUPRODUCTTYPE);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        NUADDRESS   :=  DAPR_PRODUCT.FNUGETADDRESS_ID(RCPRODUCT.SESUNUSE);

        
        RCADDRESSPRODUCT    :=  DAAB_ADDRESS.FRCGETRCDATA(NUADDRESS);

        
        IF( RCADDRESSPRODUCT.NEIGHBORTHOOD_ID = RCADDRESS.NEIGHBORTHOOD_ID )THEN
            BONEIGHBORTHOODEQUAL := TRUE;
        END IF;

        UT_TRACE.TRACE('rcAddressProduct.neighborthood_id = '|| RCADDRESSPRODUCT.NEIGHBORTHOOD_ID ||
                       ' | rcAddress.neighborthood_id = '|| RCADDRESS.NEIGHBORTHOOD_ID||
                       ' | rcAddress.address_id = ' || RCADDRESS.ADDRESS_ID, 2);

        
        NUITEMID :=  INUITEMNEIGHEQUAL;

        IF ( NOT BONEIGHBORTHOODEQUAL ) THEN
            NUITEMID :=  INUITEMNEIGHDIFERENT;
        END IF;

        
        PKBOBILLPRINTUTILITIES.GENORDERACTIVITY
        (
            INUACTIVITYID=>NUITEMID,
            INUSUBSCRIPTIONID=>RCSUBSCRIPTION.SUSCCODI,
            INUREFERENCEVALUE=>RCBILL.FACTCODI,
            INUADDRESSID=>RCSUBSCRIPTION.SUSCIDDI
        );
        
        UT_TRACE.TRACE('[FIN] pkBOBillPrintUtilities.fsbGenDeliveryOrder',1);
        RETURN NULL;
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('[CONTROLLED ERROR] pkBOBillPrintUtilities.fsbGenDeliveryOrder',1);
            RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('[OTHERS ERROR] pkBOBillPrintUtilities.fsbGenDeliveryOrder',1);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBGENDELIVERYORDER;

END PKBOBILLPRINTUTILITIES;