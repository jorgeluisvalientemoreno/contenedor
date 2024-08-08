PACKAGE BODY CM_BORegLect IS




































































































	CSBVERSION  CONSTANT VARCHAR2(250)  := 'SAO207480';

    CNUNOPRODUCTIDERROR         CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 900451;
    CNUINVALIDPRODSTATUSERROR   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 900452;
    CNUNOLIEUPRODUCTERROR       CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 900453;
    CNUNOCONSCYCLEERROR         CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 900584;
    CNUCONSCYCLEERROR           CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 900454;
    CNUCONSPERIODERROR          CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 900455;
    CNUPENDINGPRODLIEUERROR     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 900456;
    CNUCRITICISCLOSEDERROR      CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 902167; 
    CNUCRITICISNOTCLOSEDERROR   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 902168; 
    
    CNUPRODUCT_INSTALL_PENDING  CONSTANT NUMBER := PR_BOCONSTANTS.CNUPRODUCT_INSTALL_PENDING;
    CNUPRODUCT_RETIRE           CONSTANT NUMBER := PR_BOCONSTANTS.CNUPRODUCT_RETIRE;
    CNUPRODUCT_UNINSTALL_RET    CONSTANT NUMBER := PR_BOCONSTANTS.CNUPRODUCT_UNINSTALL_RET;
    
    CSBNO                       CONSTANT VARCHAR2(2) := GE_BOCONSTANTS.CSBNO;
    
    CNULIEUINSPACTIVITY         CONSTANT GE_ITEMS.ITEMS_ID%TYPE := GE_BOITEMSCONSTANTS.CNULIEUINSPACTIVITY;
    
    NULIEUINSPTASKTYPE          OR_TASK_TYPE.TASK_TYPE_ID%TYPE; 

	
	SBERRMSG   VARCHAR2(2000);  

    FUNCTION FSBVERSION RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;
    
    


















    PROCEDURE GENINSPECTIONACTIVITY
    (
        INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE
    )
    IS
        SBPRODUCT           VARCHAR2(100);                              
        RCPRODUCT           DAPR_PRODUCT.STYPR_PRODUCT;                 
        RCAFORSESU          AFORSESU%ROWTYPE;                           
        NUCYCLE             SERVSUSC.SESUCICO%TYPE;                     
        SBCYCLE             VARCHAR2(100);                              
        RCCICLCONS          CICLCONS%ROWTYPE;                           
        NUPECSCONS          PERICOSE.PECSCONS%TYPE;                     
        RCPERICOSE          PERICOSE%ROWTYPE;                           
        RCCM_OBSESESA       CM_OBSESESA%ROWTYPE;                        
        RCNULLCM_OBSESESA   CM_OBSESESA%ROWTYPE;                        
        NUORDERID           OR_ORDER_ACTIVITY.ORDER_ID%TYPE;            
        NUORDERACTIVITY     OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;   
        
        SBISFINALSTATUS     VARCHAR2(1);                                
        
        NUBASEADDRESSID     AB_ADDRESS.ADDRESS_ID%TYPE;
        NUPREMISEID         OR_ROUTE_PREMISE.PREMISE_ID%TYPE;
        NUROUTEID           OR_ROUTE_PREMISE.ROUTE_ID%TYPE;
        NUCONSECUTIVE       OR_ROUTE_PREMISE.CONSECUTIVE%TYPE;
    BEGIN
        
        IF (INUPRODUCTID IS NULL) THEN
            ERRORS.SETERROR(CNUNOPRODUCTIDERROR);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        DAPR_PRODUCT.ACCKEY(INUPRODUCTID);
        
        DAPR_PRODUCT.GETRECORD(INUPRODUCTID,
                               RCPRODUCT);
        SBPRODUCT := 'con n�mero de servicio ['||RCPRODUCT.SERVICE_NUMBER||']';
        
        IF (RCPRODUCT.PRODUCT_STATUS_ID IN (CNUPRODUCT_INSTALL_PENDING,
                                            CNUPRODUCT_RETIRE,
                                            CNUPRODUCT_UNINSTALL_RET)) THEN
            
            
            ERRORS.SETERROR(CNUINVALIDPRODSTATUSERROR,
                            SBPRODUCT);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        
        IF (PKBCAFORSESU.CUAFOROBYPRODUCT%ISOPEN) THEN
            CLOSE PKBCAFORSESU.CUAFOROBYPRODUCT;
        END IF;

        OPEN PKBCAFORSESU.CUAFOROBYPRODUCT(INUPRODUCTID,
                                           UT_DATE.FDTSYSDATE);
        FETCH PKBCAFORSESU.CUAFOROBYPRODUCT INTO RCAFORSESU;

        
        
        IF (PKBCAFORSESU.CUAFOROBYPRODUCT%NOTFOUND) THEN
            CLOSE PKBCAFORSESU.CUAFOROBYPRODUCT;
            ERRORS.SETERROR(CNUNOLIEUPRODUCTERROR,
                            SBPRODUCT);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        CLOSE PKBCAFORSESU.CUAFOROBYPRODUCT;
        
        
        NUCYCLE    := PKTBLSERVSUSC.FNUGETCYCLE(INUPRODUCTID);
        IF (NUCYCLE IS NULL) THEN
            ERRORS.SETERROR(CNUNOCONSCYCLEERROR,
                            SBPRODUCT);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        RCCICLCONS := PKTBLCICLCONS.FRCGETRECORD(PKTBLSERVSUSC.FNUGETCYCLE(INUPRODUCTID));
        SBCYCLE    := '['||RCCICLCONS.CICOCODI||' - '||RCCICLCONS.CICODESC||']';

        
        
        
        IF (NVL(RCCICLCONS.CICOGELE,
                'N') = 'N') THEN
            ERRORS.SETERROR(CNUCONSCYCLEERROR,
                            SBCYCLE||'|'||SBPRODUCT);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        
        NUPECSCONS := CM_BCREGLECT.FNUGETCURRCONSPERIODBYPROD(INUPRODUCTID);
        
        
        IF (NUPECSCONS = -1) THEN
            ERRORS.SETERROR(CNUCONSPERIODERROR,
                            SBCYCLE||'|'||SBPRODUCT);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        
        RCPERICOSE := PKTBLPERICOSE.FRCGETRECORD(NUPECSCONS);
        
        
        
        BEGIN
            RCCM_OBSESESA := CM_BCOBSESESA.FRCOBSESESAPORSESUPECO(INUPRODUCTID,
                                                                  NUPECSCONS);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RCCM_OBSESESA := RCNULLCM_OBSESESA;
            WHEN OTHERS THEN
                RCCM_OBSESESA := RCNULLCM_OBSESESA;
        END;
        
        
        IF (RCCM_OBSESESA.OBSECONS IS NULL) THEN
            IF (NULIEUINSPTASKTYPE IS NULL) THEN
                NULIEUINSPTASKTYPE := OR_BCORDERACTIVITIES.FNUGETTASKTYPEBYACTID(CNULIEUINSPACTIVITY);
            END IF;

            
            NUBASEADDRESSID := AB_BOADDRESS.FNUGETBASEADDR(RCPRODUCT.ADDRESS_ID);
            NUPREMISEID := DAAB_ADDRESS.FNUGETESTATE_NUMBER(NUBASEADDRESSID);
            OR_BCROUTEPREMISE.GETDEDICROUTEPREMTASK(NUPREMISEID,
                                                    NULIEUINSPTASKTYPE,
                                                    NUROUTEID,
                                                    NUCONSECUTIVE);
        
            
            OR_BOORDERACTIVITIES.CREATEACTIVITY(CNULIEUINSPACTIVITY,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                RCPRODUCT.ADDRESS_ID,
                                                NULL,
                                                NULL,
                                                NULL,
                                                INUPRODUCTID,
                                                NULL,
                                                NULL,
                                                RCPERICOSE.PECSFECF,
                                                NULL,
                                                NULL,
                                                FALSE,
                                                NULL,
                                                NUORDERID,
                                                NUORDERACTIVITY,
                                                NULL,
                                                CSBNO,
                                                NULL,
                                                NUROUTEID,
                                                NUCONSECUTIVE);
                                                
            RCCM_OBSESESA := RCNULLCM_OBSESESA;
            
            RCCM_OBSESESA.OBSECONS := CM_BOSEQUENCE.FNUOBSESESANEXTSEQVAL;
            RCCM_OBSESESA.OBSESESU := INUPRODUCTID;
            RCCM_OBSESESA.OBSEPECO := NUPECSCONS;
            RCCM_OBSESESA.OBSEDOCU := NUORDERACTIVITY;
            RCCM_OBSESESA.OBSEOBS1 := NULL;
            RCCM_OBSESESA.OBSEOBS2 := NULL;
            RCCM_OBSESESA.OBSEOBS3 := NULL;
            RCCM_OBSESESA.OBSEFEOB := NULL;
            PKTBLCM_OBSESESA.INSRECORD(RCCM_OBSESESA);
        ELSE
            
            
            NUORDERID := DAOR_ORDER_ACTIVITY.FNUGETORDER_ID(RCCM_OBSESESA.OBSEDOCU);
            SBISFINALSTATUS := OR_BCORDER.FSBISORDERINFINALSTATUS(NUORDERID);
            
            
            IF (SBISFINALSTATUS = GE_BOCONSTANTS.CSBYES) THEN
                
                CM_BOHISTOROBSERVAFORAD.CREARHISTORICO(RCCM_OBSESESA.OBSECONS);
                
                IF (NULIEUINSPTASKTYPE IS NULL) THEN
                    NULIEUINSPTASKTYPE := OR_BCORDERACTIVITIES.FNUGETTASKTYPEBYACTID(CNULIEUINSPACTIVITY);
                END IF;

                
                NUBASEADDRESSID := AB_BOADDRESS.FNUGETBASEADDR(RCPRODUCT.ADDRESS_ID);
                NUPREMISEID := DAAB_ADDRESS.FNUGETESTATE_NUMBER(NUBASEADDRESSID);
                OR_BCROUTEPREMISE.GETDEDICROUTEPREMTASK(NUPREMISEID,
                                                        NULIEUINSPTASKTYPE,
                                                        NUROUTEID,
                                                        NUCONSECUTIVE);
                
                
                NUORDERID := NULL;
                OR_BOORDERACTIVITIES.CREATEACTIVITY(CNULIEUINSPACTIVITY,
                                                    NULL,
                                                    NULL,
                                                    NULL,
                                                    NULL,
                                                    RCPRODUCT.ADDRESS_ID,
                                                    NULL,
                                                    NULL,
                                                    NULL,
                                                    INUPRODUCTID,
                                                    NULL,
                                                    NULL,
                                                    RCPERICOSE.PECSFECF,
                                                    NULL,
                                                    NULL,
                                                    FALSE,
                                                    NULL,
                                                    NUORDERID,
                                                    NUORDERACTIVITY,
                                                    NULL,
                                                    GE_BOCONSTANTS.CSBNO,
                                                    NULL,
                                                    NUROUTEID,
                                                    NUCONSECUTIVE);
                                                    
                
                RCCM_OBSESESA.OBSEDOCU := NUORDERACTIVITY;
                







                PKTBLCM_OBSESESA.UPRECORD(RCCM_OBSESESA);
            ELSE
                
                
                
                
                ERRORS.SETERROR(CNUPENDINGPRODLIEUERROR,
                                SBPRODUCT);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
        END IF;
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (PKBCAFORSESU.CUAFOROBYPRODUCT%ISOPEN) THEN
                CLOSE PKBCAFORSESU.CUAFOROBYPRODUCT;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (PKBCAFORSESU.CUAFOROBYPRODUCT%ISOPEN) THEN
                CLOSE PKBCAFORSESU.CUAFOROBYPRODUCT;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GENINSPECTIONACTIVITY;
    
    





































    PROCEDURE GENREADINGACTIVITIES
    (
        INUFOREHANDDAYS IN NUMBER
    )
    IS
        DTDATETOPROCESS DATE;                            
        TBCONSPERS      CM_BCREGLECT.TYTBPERICOSE;       
        RCCONSPER       CM_BCREGLECT.TYPERICOSE;         
        RCCONSPERNULL   CM_BCREGLECT.TYPERICOSE;         
        
        SBCONSUMPTIONPERIODS VARCHAR2(32767);            
        SBCONSUMPTIONCYCLES  VARCHAR2(32767);            
        SBSEPARATOR          VARCHAR2(1) := '';          
        
        NUFIRST NUMBER;                                  
        NULAST  NUMBER;                                  
        
        SBPATH             VARCHAR2(300);                
        SBPROGRAMID        VARCHAR2(4);                  
        SBTERMINAL         VARCHAR2(300);                
        SBCOMMAND          VARCHAR2(2000);               
        SBCONNECTIONSTRING VARCHAR2(1000);               
        SBTRACENAME        VARCHAR2(500);                
        NUSESSIONID        NUMBER;                       
        
        NUPERIFACT         PERIFACT.PEFACODI%TYPE;       
        NUPREVPERICOSE     PERICOSE.PECSCONS%TYPE;       
        NUPREVPERIFACT     PERIFACT.PEFACODI%TYPE;       

        


















        PROCEDURE ADDPERIODTOPROCESS
        (
            INUPECSCONS IN PERICOSE.PECSCONS%TYPE,
            INUCICLCONS IN CICLCONS.CICOCODI%TYPE
        )
        IS
            RCPERICOSE PERICOSE%ROWTYPE; 
            RCREACGELE REACGELE%ROWTYPE; 
        BEGIN
            
            RCPERICOSE := PKTBLPERICOSE.FRCGETRECORD(INUPECSCONS);
            
            RCPERICOSE.PECSPROC := 'N';
            PKTBLPERICOSE.UPRECORD(RCPERICOSE);
            
            FOR I IN 0..9 LOOP
                RCREACGELE := PKBCREACGELE.FRCGETREGBYPECSDIVI(INUPECSCONS,
                                                               I);
                IF (RCREACGELE.RAGLCONS IS NOT NULL) THEN
                    RCREACGELE.RAGLFINA := 'N' ;
                    PKTBLREACGELE.UPRECORD(RCREACGELE);
                END IF;
            END LOOP;

            
            SBCONSUMPTIONPERIODS := SBCONSUMPTIONPERIODS || SBSEPARATOR || INUPECSCONS;
            SBCONSUMPTIONCYCLES  := SBCONSUMPTIONCYCLES  || SBSEPARATOR || INUCICLCONS;
            SBSEPARATOR          := '|';
        END ADDPERIODTOPROCESS;
    BEGIN
        
        
        
        
        DTDATETOPROCESS := TRUNC(SYSDATE) + INUFOREHANDDAYS;
        CM_BCREGLECT.GETCONSPERTOPROC(DTDATETOPROCESS,
                                      TBCONSPERS);
                                      
        NUFIRST := TBCONSPERS.FIRST;
        NULAST  := TBCONSPERS.LAST;
        
        
        IF (NUFIRST IS NULL) THEN
            RETURN;
        END IF;
        
        FOR I IN NUFIRST..NULAST LOOP
            RCCONSPER := TBCONSPERS(I);
            IF (RCCONSPER.PECSCONS IS NOT NULL) THEN
                
                NUPERIFACT := PKBCPERIFACT.FNUBILLPERBYCONSPER(RCCONSPER.PECSCONS);
                
                IF (NOT(CM_BCCHANGEMETER.FBLCRITICISCLOSED(NUPERIFACT))) THEN
                    
                    NUPREVPERICOSE := CM_BCREGLECT.FNUGETPREVCONSPERIOD(RCCONSPER.PECSCONS,
                                                                        RCCONSPER.PECSFECI,
                                                                        RCCONSPER.PECSCICO);
                    
                    IF (NUPREVPERICOSE IS NULL) THEN
                        
                        ADDPERIODTOPROCESS(RCCONSPER.PECSCONS,
                                           RCCONSPER.PECSCICO);
                    ELSE
                        
                        NUPREVPERIFACT := PKBCPERIFACT.FNUBILLPERBYCONSPER(NUPREVPERICOSE);
                        
                        IF (CM_BCCHANGEMETER.FBLCRITICISCLOSED(NUPREVPERIFACT)) THEN
                            
                            ADDPERIODTOPROCESS(RCCONSPER.PECSCONS,
                                               RCCONSPER.PECSCICO);
                        END IF;
                    END IF;
                END IF;
            END IF;
            RCCONSPER := RCCONSPERNULL;
        END LOOP;
        
        
        IF (SBCONSUMPTIONPERIODS IS NULL) THEN
            RETURN;
        END IF;
        
        
        PKGENERALSERVICES.COMMITTRANSACTION;

        
        SBPATH      := PKGENERALPARAMETERSMGR.FSBGETSTRINGVALUE ('RUTA_TRAZA');
        IF (SBPATH IS NULL) THEN
             SBPATH := '/tmp';
        END IF;
        SBPROGRAMID := CSBPROGRAM;
        SBTERMINAL  := PKGENERALSERVICES.FSBGETTERMINAL;
        
        
        SBTERMINAL  := UT_STRING.STRREPLACE(SBTERMINAL,
                                            '\',
                                            '_');
        SBTERMINAL  := UT_STRING.STRREPLACE(SBTERMINAL,
                                            '/',
                                            '_');
                                            
        
        NUSESSIONID := SYS_CONTEXT('USERENV','SESSIONID');

        SBTRACENAME :=  'FGRL' || '_' || SBTERMINAL || '_' || NUSESSIONID ||'_'||
                        TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') || '.trc';

        SBCONNECTIONSTRING := GE_BODATABASECONNECTION.FSBGETDEFAULTCONNECTIONSTRING;
        
        








        
        SBCOMMAND := 'fgrl' ||' '||
                     SBCONNECTIONSTRING ||' "'||
                     SBCONSUMPTIONPERIODS ||'" "'||
                     SBCONSUMPTIONCYCLES ||'" "FALSE" "'||
                     SBPROGRAMID ||'" "'||
                     PKCONSTANTE.NULLNUM ||'" "'||
                     SBTRACENAME ||'" > '||
                     SBPATH || '/' ||
                     SBTRACENAME || ' 2>'||CHR(38)||'1 '||CHR(38);
        LLAMASIST(SBCOMMAND);
                                      
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GENREADINGACTIVITIES;
    
    



















    PROCEDURE GENREADINGACTBYPERIOD
    IS
        
        SBPECSCONS      GE_BOINSTANCECONTROL.STYSBVALUE;
        
        
        NUPROGRAM       GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE;

        
        RCPROGRAM       DAGE_PROCESS_SCHEDULE.STYGE_PROCESS_SCHEDULE;

        
        SBPARAMETERS    GE_PROCESS_SCHEDULE.PARAMETERS_%TYPE;

        
        SBCONNECSTRING  VARCHAR2(500) := NULL;
        
        
        SBCONENCRIP     VARCHAR2(500);
        
        
        SBUSER           VARCHAR2(100);
        SBPASSWORD       VARCHAR2(100);
        SBINSTANCE       VARCHAR2(100);
        
        















        
        FUNCTION FSBENCRIPTACADENA(
                                    ISBSTRING   IN VARCHAR2
                                  )
        RETURN VARCHAR2 IS
            
            SBINPUT VARCHAR(200);
            
            
            SBKEY VARCHAR2(2000):='_OPEN_BILLING_PROCESS_ENCRYPT_';
            
            
            RRETURN LONG;

            
            SBOBFUSCATION    VARCHAR2(2000);
        BEGIN

            
            SBINPUT := RPAD( ISBSTRING, (TRUNC(LENGTH(ISBSTRING)/8)+1)*8, CHR(0));

            
            DBMS_OBFUSCATION_TOOLKIT.DESENCRYPT(
                                                INPUT_STRING => SBINPUT,
                                                KEY_STRING => SBKEY, ENCRYPTED_STRING =>
                                                RRETURN
                                               );

            SBOBFUSCATION := UTL_RAW.CAST_TO_RAW(RRETURN);

            RETURN SBOBFUSCATION;
            
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END;
    BEGIN
        
        SBPECSCONS := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ( 'PERICOSE', 'PECSCONS' );
        
        
        NUPROGRAM := GE_BOSCHEDULE.FNUGETSCHEDULEINMEMORY;

        
        RCPROGRAM := DAGE_PROCESS_SCHEDULE.FRCGETRECORD( NUPROGRAM );

        
        SBPARAMETERS := RCPROGRAM.PARAMETERS_;

        
        GE_BODATABASECONNECTION.GETCONNECTIONSTRING(SBUSER, SBPASSWORD, SBINSTANCE);

        
        SBCONNECSTRING := SBUSER || '/' || SBPASSWORD || '@' || SBINSTANCE;

        
        SBCONENCRIP := FSBENCRIPTACADENA( SBCONNECSTRING );

        
        SBPARAMETERS := SBPARAMETERS||'CON='||SBCONENCRIP||'|';

        
        RCPROGRAM.PARAMETERS_ := SBPARAMETERS;
        DAGE_PROCESS_SCHEDULE.UPDRECORD( RCPROGRAM );

	  	
	  	PKGENERALSERVICES.COMMITTRANSACTION;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GENREADINGACTBYPERIOD;

    


























    PROCEDURE EXECUTEREADINGACTBYPERIOD(
                                            INUPERICOSE     IN  PERICOSE.PECSCONS%TYPE,
                                            ISBCONNSTRING   IN  VARCHAR2,
                                            INUPROGRAM      IN  GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE
                                       )
    IS
        
        SBCONSUMPTIONPERIODS VARCHAR2(15);
        
        SBCONSUMPTIONCYCLES  VARCHAR2(15);
        
        SBPATH             VARCHAR2(300);
        
        SBPROGRAMID        VARCHAR2(4);
        
        SBCOMMAND          VARCHAR2(2000);
        
        SBTRACENAME        VARCHAR2(500);
        
        RCPERICOSE         PERICOSE%ROWTYPE;
        
        SBCONNECTION       VARCHAR2(100);
        
        NUPERIFACT         PERIFACT.PEFACODI%TYPE;
        
        NUPREVPERICOSE     PERICOSE.PECSCONS%TYPE;
        
        NUPREVPERIFACT     PERIFACT.PEFACODI%TYPE;
        
        RCREACGELE         REACGELE%ROWTYPE;
        
        


















        PROCEDURE SETERROR
        (
            INUERRORMESSAGEID IN GE_MESSAGE.MESSAGE_ID%TYPE,
            INUPECSCONS       IN PERICOSE.PECSCONS%TYPE,
            INUPROCESSSCHEDID IN GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE,
            INUPEFACODI       IN PERIFACT.PEFACODI%TYPE
        )
        IS
            
            SBESTAPROG ESTAPROG.ESPRPROG%TYPE;
            
            NUERRORCODE     GE_ERROR_LOG.MESSAGE_ID%TYPE;  
            SBERRORMESSAGE  GE_ERROR_LOG.DESCRIPTION%TYPE; 
        BEGIN
            
            ERRORS.SETERROR(INUERRORMESSAGEID,
                            TO_CHAR(INUPECSCONS));
            ERRORS.GETERROR(NUERRORCODE,
                            SBERRORMESSAGE);
            
            FA_BOBILLINGCONSOLE.SETPROCESSENDDATE(INUPROCESSSCHEDID);
            
            SBESTAPROG := 'FGRL' || PKSTATUSEXEPROGRAMMGR.FNUGETPROCESSNUMBER;
            
            PKSTATUSEXEPROGRAMMGR.ADDRECORD
            (
                SBESTAPROG,
                SBERRORMESSAGE,
                0,
                0,
                INUPEFACODI
            );
            
            PKGENERALSERVICES.COMMITTRANSACTION;
            
            PKSTATUSEXEPROGRAMMGR.UPEXEPROGPROGPROC(SBESTAPROG,
                                                    INUPROCESSSCHEDID);
            RAISE EX.CONTROLLED_ERROR;
        END SETERROR;
    BEGIN
        
        IF INUPERICOSE IS NULL THEN
            
            RETURN;
        END IF;

        
        NUPERIFACT := PKBCPERIFACT.FNUBILLPERBYCONSPER(INUPERICOSE);
        
        
        IF (CM_BCCHANGEMETER.FBLCRITICISCLOSED(NUPERIFACT)) THEN
            
            SETERROR(CNUCRITICISCLOSEDERROR,
                     INUPERICOSE,
                     INUPROGRAM,
                     NUPERIFACT);
        END IF;

        
        RCPERICOSE := PKTBLPERICOSE.FRCGETRECORD(INUPERICOSE);
        
        
        NUPREVPERICOSE := CM_BCREGLECT.FNUGETPREVCONSPERIOD(INUPERICOSE,
                                                            RCPERICOSE.PECSFECI,
                                                            RCPERICOSE.PECSCICO);
        
        
        IF (NUPREVPERICOSE IS NOT NULL) THEN
            
            NUPREVPERIFACT := PKBCPERIFACT.FNUBILLPERBYCONSPER(NUPREVPERICOSE);

            
            IF (NOT(CM_BCCHANGEMETER.FBLCRITICISCLOSED(NUPREVPERIFACT))) THEN
                
                SETERROR(CNUCRITICISNOTCLOSEDERROR,
                         INUPERICOSE,
                         INUPROGRAM,
                         NUPERIFACT);
            END IF;
        END IF;
        
        
        RCPERICOSE.PECSPROC := 'N';
        PKTBLPERICOSE.UPRECORD(RCPERICOSE);
        
        FOR I IN 0..9 LOOP
            RCREACGELE := PKBCREACGELE.FRCGETREGBYPECSDIVI(INUPERICOSE,
                                                           I);
            IF (RCREACGELE.RAGLCONS IS NOT NULL) THEN
                RCREACGELE.RAGLFINA := 'N' ;
                PKTBLREACGELE.UPRECORD(RCREACGELE);
            END IF;
        END LOOP;
        
        PKGENERALSERVICES.COMMITTRANSACTION;

        SBCONSUMPTIONPERIODS := INUPERICOSE;
        SBCONSUMPTIONCYCLES  := RCPERICOSE.PECSCICO;

        
        SBPATH      := PKGENERALPARAMETERSMGR.FSBGETSTRINGVALUE ('RUTA_TRAZA');
        IF (SBPATH IS NULL) THEN
             SBPATH := '/tmp';
        END IF;
        SBPROGRAMID := CSBPROGRAM;

        SBTRACENAME :=  'FGRL' || '_' || TO_CHAR( INUPERICOSE ) || '_' || TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') || '.trc';

        
        SBCONNECTION := RTRIM( FA_UIPROCESOSFACT.FSBDESENCRIPTACADENA( ISBCONNSTRING ) );
        










        SBCOMMAND := 'fgrl' ||' '||
                     SBCONNECTION ||' "'||
                     SBCONSUMPTIONPERIODS ||'" "'||
                     SBCONSUMPTIONCYCLES ||'" "FALSE" "'||
                     SBPROGRAMID ||'" "'||
                     INUPROGRAM  ||'" "'||
                     SBTRACENAME ||'" > '||
                     SBPATH || '/' ||
                     SBTRACENAME || ' 2>'||CHR(38)||'1 '||CHR(38);

        LLAMASIST(SBCOMMAND);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END EXECUTEREADINGACTBYPERIOD;
END CM_BOREGLECT;