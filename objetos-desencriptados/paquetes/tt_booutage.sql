PACKAGE BODY TT_BOOutage
IS
    


































    
    
    
    CSBVERSION                  CONSTANT VARCHAR2(10) := 'SAO206341';

    
    
    
    CSBDAO_USE_CACHE       CONSTANT GE_PARAMETER.PARAMETER_ID%TYPE := 'DAO_USE_CACHE'; 
    
    CNUREQ_ATT_ERROR       CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 2126;   
    CNUINV_VALUE_ERROR     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 119369; 
    CNUORDER_STATUS_ERROR  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 9581;   
    CNUINV_DATE_ERROR      CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 3852;   
    CNUNEG_VALUE_ERROR     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 4784;   
    CNUINV_ATT_VALUE_ERROR CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 1907;   
    CNUIS_NOT_OUTAGE_ERROR CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901118; 
    CNUIS_OUTAGE_ERROR     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901229; 
    CNUPROC_LIMIT_ERROR    CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901111; 
    CNUNO_PRODS_PROC_ERROR CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901117; 
    CNUMAX_VALUE_ERROR     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 114422; 
    
    CNUMAX_TIME_VALUE      CONSTANT NUMBER := 999999;                     

    
    
    

    
    
    

    
    
    
    













    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;

    





















    PROCEDURE VALREGISTEROUTAGE
    (
        INUFAULTTYPEID IN TT_DAMAGE.REG_DAMAGE_TYPE_ID%TYPE,
        IDTOUTAGEINIT  IN TT_DAMAGE.INITIAL_DATE%TYPE,
        INUORDERID     IN OR_ORDER.ORDER_ID%TYPE,
        INUTIME        IN NUMBER,
        ISBCLASS       IN TT_DAMAGE.CLASS%TYPE
    )
    IS
    BEGIN
        
        IF (INUFAULTTYPEID IS NULL) THEN
            ERRORS.SETERROR(CNUREQ_ATT_ERROR,
                            'inuFaultTypeId');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        IF (INUORDERID IS NULL) THEN
            ERRORS.SETERROR(CNUREQ_ATT_ERROR,
                            'inuOrderId');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        IF (ISBCLASS IS NULL) THEN
            ERRORS.SETERROR(CNUREQ_ATT_ERROR,
                            'isbClass');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        DATT_DAMAGE_TYPE.ACCKEY(INUFAULTTYPEID);
        
        IF (INUFAULTTYPEID = TT_BCCONSTANTS.CNUCONTROL_FAULT_TYPE) THEN
            ERRORS.SETERROR(CNUINV_VALUE_ERROR,
                            'inuFaultTypeId');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        DAOR_ORDER.ACCKEY(INUORDERID);
        
        IF (OR_BCORDER.FSBISORDERINFINALSTATUS(INUORDERID) = GE_BOCONSTANTS.CSBYES) THEN
            ERRORS.SETERROR(CNUORDER_STATUS_ERROR);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        IF (IDTOUTAGEINIT IS NOT NULL) THEN
            IF (IDTOUTAGEINIT > UT_DATE.FDTSYSDATE) THEN
                ERRORS.SETERROR(CNUINV_DATE_ERROR);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
        END IF;
        
        IF (INUTIME IS NOT NULL) THEN
            IF (INUTIME <= 0) THEN
                ERRORS.SETERROR(CNUNEG_VALUE_ERROR,
                                'Tiempo para el Restablecimiento (min.)');
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            IF (INUTIME > CNUMAX_TIME_VALUE) THEN
                ERRORS.SETERROR(CNUMAX_VALUE_ERROR,
                                '[Tiempo para el Restablecimiento (min.)]|'||CNUMAX_TIME_VALUE);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
        END IF;
        
        IF (ISBCLASS NOT IN (TT_BCCONSTANTS.CSBCLASS_PROGRAM,
                             TT_BCCONSTANTS.CSBCLASS_NOT_PROGRAM)) THEN
            ERRORS.SETERROR(CNUINV_ATT_VALUE_ERROR,
                            'isbClass|'||TT_BCCONSTANTS.CSBCLASS_PROGRAM||', '||TT_BCCONSTANTS.CSBCLASS_NOT_PROGRAM);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALREGISTEROUTAGE;

    




















    PROCEDURE REGISTEROUTAGE
    (
        INUFAULTTYPEID   IN  TT_DAMAGE.REG_DAMAGE_TYPE_ID%TYPE,
        IDTOUTAGEINIT    IN  TT_DAMAGE.INITIAL_DATE%TYPE,
        INUORDERID       IN  OR_ORDER.ORDER_ID%TYPE,
        INUTIME          IN  NUMBER,
        ISBCLASS         IN  TT_DAMAGE.CLASS%TYPE,
        ISBCOMMENT       IN  MO_COMMENT.COMMENT_%TYPE,
        ONUFAULTID       OUT TT_DAMAGE.PACKAGE_ID%TYPE
    )
    IS
        NUTIME NUMBER; 
    BEGIN
        
        IF (INUTIME IS NOT NULL) THEN
            NUTIME := INUTIME/60;
        END IF;
        
        TT_BOFAULT.REGISTERFAULT(INUFAULTTYPEID, 
                                 IDTOUTAGEINIT,  
                                 INUORDERID,     
                                 NUTIME,         
                                 ISBCLASS,       
                                 ISBCOMMENT,     
                                 NULL,           
                                 NULL,           
                                 NULL,           
                                 NULL,           
                                 ONUFAULTID);    
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END REGISTEROUTAGE;
    
    















    PROCEDURE VALISOUTAGE
    (
        INUFAULTID IN TT_DAMAGE.PACKAGE_ID%TYPE
    )
    IS
        RCDAMAGE DATT_DAMAGE.STYTT_DAMAGE; 
    BEGIN
        DATT_DAMAGE.GETRECORD(INUFAULTID,
                              RCDAMAGE);
        
        IF ((RCDAMAGE.ELEMENT_ID IS NOT NULL)
            OR
            (RCDAMAGE.ORDER_ACTIVITY_ID IS NULL)) THEN
            ERRORS.SETERROR(CNUIS_NOT_OUTAGE_ERROR);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALISOUTAGE;
    
    














    PROCEDURE VALISNOTOUTAGE
    (
        INUFAULTID IN TT_DAMAGE.PACKAGE_ID%TYPE
    )
    IS
        RCDAMAGE DATT_DAMAGE.STYTT_DAMAGE; 
    BEGIN
        DATT_DAMAGE.GETRECORD(INUFAULTID,
                              RCDAMAGE);
        
        IF (RCDAMAGE.ELEMENT_ID IS NULL) THEN
            ERRORS.SETERROR(CNUIS_OUTAGE_ERROR,
                            'interrupciones de servicio');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALISNOTOUTAGE;
    
    


















    PROCEDURE VALPRODSOUTAGE
    (
        INUFAULTID       IN TT_DAMAGE.PACKAGE_ID%TYPE,
        ISBAFFECTEDPRODS IN VARCHAR2
    )
    IS
    BEGIN
        
        IF (INUFAULTID IS NULL) THEN
            ERRORS.SETERROR(CNUREQ_ATT_ERROR,
                            'inuFaultId');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        IF (ISBAFFECTEDPRODS IS NULL) THEN
            ERRORS.SETERROR(CNUREQ_ATT_ERROR,
                            'isbAffectedProds');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        
        TT_BOFAULT.VALFAULTSTATUS(INUFAULTID);
        
        TT_BOOUTAGE.VALISOUTAGE(INUFAULTID);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALPRODSOUTAGE;
    
    



















    PROCEDURE EXTPRODUCTS
    (
        ISBAFFECTEDPRODS IN         VARCHAR2,
        IBLVALIDATEPRODS IN         BOOLEAN,
        IBLVALPRODSTATUS IN         BOOLEAN,
        OTBAFFECTEDPRODS OUT NOCOPY DAPR_PRODUCT.TYTBPRODUCT_ID
    )
    IS
        TBSTRING        UT_STRING.TYTB_STRING;      
        NUINDEX         BINARY_INTEGER;             
        NUPRODUCTID     PR_PRODUCT.PRODUCT_ID%TYPE; 
    BEGIN
        
        IF (ISBAFFECTEDPRODS IS NOT NULL) THEN
            UT_STRING.EXTSTRING(ISBAFFECTEDPRODS,
                                GE_BOCONSTANTS.CSBPIPE,
                                TBSTRING);
                                
            NUINDEX := TBSTRING.FIRST;

            LOOP
                EXIT WHEN NUINDEX IS NULL;
                NUPRODUCTID := TO_NUMBER(TBSTRING(NUINDEX));
                
                TT_BOPRODUCT.VALPRODUCT(NUPRODUCTID,
                                        IBLVALPRODSTATUS);
                OTBAFFECTEDPRODS(NUINDEX) := NUPRODUCTID;
                NUINDEX := TBSTRING.NEXT(NUINDEX);
            END LOOP;
            
            
            IF (    IBLVALIDATEPRODS
                AND (OTBAFFECTEDPRODS.COUNT = 0)) THEN
                ERRORS.SETERROR(CNUNO_PRODS_PROC_ERROR);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            
            IF (OTBAFFECTEDPRODS.COUNT > TT_BCCONSTANTS.CNUAPI_MAX_REC_PROC) THEN
                ERRORS.SETERROR(CNUPROC_LIMIT_ERROR,
                                TT_BCCONSTANTS.CNUAPI_MAX_REC_PROC);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END EXTPRODUCTS;
    
    
















    PROCEDURE UNLOCKFAULT
    (
        INUFAULTID IN TT_DAMAGE.PACKAGE_ID%TYPE,
        IBLLOCKED  IN BOOLEAN
    )
    IS
    BEGIN
        IF (IBLLOCKED) THEN
            TT_BOFAULT.UNLOCKTT_DAMAGE(INUFAULTID);
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UNLOCKFAULT;
    
    
















    PROCEDURE SETCACHE
    (
        IBLUSECACHE IN BOOLEAN
    )
    IS
    BEGIN
        DAGE_MESSAGE.SETUSECACHE(IBLUSECACHE);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETCACHE;
    
    















    PROCEDURE ADDPRODSTOOUTAGE
    (
        INUFAULTID        IN            TT_DAMAGE.PACKAGE_ID%TYPE,
        IOTBAFFECTEDPRODS IN OUT NOCOPY DAPR_PRODUCT.TYTBPRODUCT_ID
    )
    IS
        BLLOCKED   BOOLEAN;        
        BLUSECACHE BOOLEAN := GE_BOPARAMETER.FSBGET(CSBDAO_USE_CACHE) = GE_BOCONSTANTS.CSBYES; 
        NUINDEX    BINARY_INTEGER; 
        NUID       TT_DAMAGE_PRODUCT.DAMAGES_PRODUCT_ID%TYPE; 
    BEGIN
        
        TT_BOFAULT.LOCKTT_DAMAGE(INUFAULTID);
        BLLOCKED := TRUE;
        
        SETCACHE(TRUE);

        
        NUINDEX := IOTBAFFECTEDPRODS.FIRST;
        LOOP
            EXIT WHEN NUINDEX IS NULL;
            TT_BOPRODUCT.ADDPRODTOFAULT(INUFAULTID,                
                                        IOTBAFFECTEDPRODS(NUINDEX),
                                        NULL,                      
                                        NULL,                      
                                        NUID);                     
            NUINDEX := IOTBAFFECTEDPRODS.NEXT(NUINDEX);
        END LOOP;
        
        
        TT_BOFAULT.UPDFAULTPRIORITY(INUFAULTID,
                                    NULL);     
        
        SETCACHE(BLUSECACHE);

        
        TT_BOFAULT.UNLOCKTT_DAMAGE(INUFAULTID);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            SETCACHE(BLUSECACHE);
            UNLOCKFAULT(INUFAULTID,
                        BLLOCKED);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            SETCACHE(BLUSECACHE);
            UNLOCKFAULT(INUFAULTID,
                        BLLOCKED);
            RAISE EX.CONTROLLED_ERROR;
    END ADDPRODSTOOUTAGE;
    
    















    PROCEDURE ADDPRODTOOUTAGE
    (
        INUFAULTID   IN TT_DAMAGE.PACKAGE_ID%TYPE,
        INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE
    )
    IS
        BLLOCKED        BOOLEAN;        
        BLUSECACHE      BOOLEAN := GE_BOPARAMETER.FSBGET(CSBDAO_USE_CACHE) = GE_BOCONSTANTS.CSBYES; 
        NUID            TT_DAMAGE_PRODUCT.DAMAGES_PRODUCT_ID%TYPE; 
        SBAFFECTEDPRODS VARCHAR2(1) := '|'; 
    BEGIN
        
        TT_BOOUTAGE.VALPRODSOUTAGE(INUFAULTID,
                                   SBAFFECTEDPRODS);
                                   
        SETCACHE(TRUE);
        
        
        TT_BOPRODUCT.VALPRODUCT(INUPRODUCTID,
                                TRUE);

        
        TT_BOFAULT.LOCKTT_DAMAGE(INUFAULTID);
        BLLOCKED := TRUE;

        
        TT_BOPRODUCT.ADDPRODTOFAULT(INUFAULTID,  
                                    INUPRODUCTID,
                                    NULL,        
                                    NULL,        
                                    NUID);       

        
        TT_BOFAULT.UPDFAULTPRIORITY(INUFAULTID,
                                    NULL);     

        SETCACHE(BLUSECACHE);

        
        TT_BOFAULT.UNLOCKTT_DAMAGE(INUFAULTID);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            SETCACHE(BLUSECACHE);
            UNLOCKFAULT(INUFAULTID,
                        BLLOCKED);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            SETCACHE(BLUSECACHE);
            UNLOCKFAULT(INUFAULTID,
                        BLLOCKED);
            RAISE EX.CONTROLLED_ERROR;
    END ADDPRODTOOUTAGE;

    















    PROCEDURE REMPRODSFROMOUTAGE
    (
        INUFAULTID        IN            TT_DAMAGE.PACKAGE_ID%TYPE,
        IOTBAFFECTEDPRODS IN OUT NOCOPY DAPR_PRODUCT.TYTBPRODUCT_ID
    )
    IS
        BLLOCKED   BOOLEAN;        
        BLUSECACHE BOOLEAN := GE_BOPARAMETER.FSBGET(CSBDAO_USE_CACHE) = GE_BOCONSTANTS.CSBYES; 
        NUINDEX    BINARY_INTEGER; 
        NUID       TT_DAMAGE_PRODUCT.DAMAGES_PRODUCT_ID%TYPE; 
    BEGIN
        
        TT_BOFAULT.LOCKTT_DAMAGE(INUFAULTID);
        BLLOCKED := TRUE;

        SETCACHE(TRUE);

        
        NUINDEX := IOTBAFFECTEDPRODS.FIRST;
        LOOP
            EXIT WHEN NUINDEX IS NULL;
            TT_BOPRODUCT.REMPRODFROMFAULT(INUFAULTID,                 
                                          IOTBAFFECTEDPRODS(NUINDEX));
            NUINDEX := IOTBAFFECTEDPRODS.NEXT(NUINDEX);
        END LOOP;

        
        TT_BOFAULT.UPDFAULTPRIORITY(INUFAULTID,
                                    NULL);     

        SETCACHE(BLUSECACHE);

        
        TT_BOFAULT.UNLOCKTT_DAMAGE(INUFAULTID);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            SETCACHE(BLUSECACHE);
            UNLOCKFAULT(INUFAULTID,
                        BLLOCKED);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            SETCACHE(BLUSECACHE);
            UNLOCKFAULT(INUFAULTID,
                        BLLOCKED);
            RAISE EX.CONTROLLED_ERROR;
    END REMPRODSFROMOUTAGE;
    
    






















    PROCEDURE VALATTENDOUTAGE
    (
        INUFAULTID        IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        INUFAULTTYPEID    IN  TT_DAMAGE.FINAL_DAMAGE_TYPE_ID%TYPE,
        INUCLOSURECAUSEID IN  TT_DAMAGE.DAMAGE_CAUSAL_ID%TYPE,
        IDTOUTAGEINIT     IN  TT_DAMAGE.INITIAL_DATE%TYPE,
        IDTOUTAGEEND      IN  TT_DAMAGE.END_DATE%TYPE
    )
    IS
    BEGIN
        
        TT_BOFAULT.VALFAULTSTATUS(INUFAULTID);

        
        TT_BOOUTAGE.VALISOUTAGE(INUFAULTID);

        
        TT_BOFAULT.VALATTENDFAULT(INUFAULTID,
                                  INUFAULTTYPEID,
                                  IDTOUTAGEINIT,
                                  IDTOUTAGEEND,
                                  INUCLOSURECAUSEID);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALATTENDOUTAGE;
    
    




















    PROCEDURE ATTENDOUTAGE
    (
        INUFAULTID        IN            TT_DAMAGE.PACKAGE_ID%TYPE,
        INUFAULTTYPEID    IN            TT_DAMAGE.FINAL_DAMAGE_TYPE_ID%TYPE,
        INUCLOSURECAUSEID IN            TT_DAMAGE.DAMAGE_CAUSAL_ID%TYPE,
        IDTOUTAGEINIT     IN            TT_DAMAGE.INITIAL_DATE%TYPE,
        IDTOUTAGEEND      IN            TT_DAMAGE.END_DATE%TYPE,
        IOTBAFFECTEDPRODS IN OUT NOCOPY DAPR_PRODUCT.TYTBPRODUCT_ID
    )
    IS
        NUPERSONID GE_PERSON.PERSON_ID%TYPE; 
        NUINDEX    BINARY_INTEGER;           
    BEGIN
        
        NUINDEX := IOTBAFFECTEDPRODS.FIRST;
        LOOP
            EXIT WHEN NUINDEX IS NULL;
            TT_BOFAULT.SETPRODUCT(INUFAULTID,
                                  IOTBAFFECTEDPRODS(NUINDEX));
            NUINDEX := IOTBAFFECTEDPRODS.NEXT(NUINDEX);
        END LOOP;

        
        NUPERSONID := GE_BOPERSONAL.FNUGETPERSONID;

        
        TT_BOFAULT.ATTENDFAULT(INUFAULTID,       
                               INUFAULTTYPEID,   
                               IDTOUTAGEINIT,    
                               IDTOUTAGEEND,     
                               INUCLOSURECAUSEID,
                               NULL,             
                               NUPERSONID);      

        
        TT_BOFAULT.DELETETABLES;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            
            TT_BOFAULT.DELETETABLES;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            
            TT_BOFAULT.DELETETABLES;
            RAISE EX.CONTROLLED_ERROR;
    END ATTENDOUTAGE;
    
    


















    PROCEDURE VALUPDATEOUTAGE
    (
        INUFAULTID     IN TT_DAMAGE.PACKAGE_ID%TYPE,
        INUFAULTTYPEID IN TT_DAMAGE.FINAL_DAMAGE_TYPE_ID%TYPE,
        IDTOUTAGEINIT  IN TT_DAMAGE.INITIAL_DATE%TYPE,
        INUADDRESSID   IN AB_ADDRESS.ADDRESS_ID%TYPE
    )
    IS
    BEGIN
        
        TT_BOFAULT.VALFAULTSTATUS(INUFAULTID);

        
        TT_BOOUTAGE.VALISOUTAGE(INUFAULTID);

        
        TT_BOFAULT.VALUPDATEFAULT(INUFAULTID,
                                  INUFAULTTYPEID,
                                  IDTOUTAGEINIT);

        
        IF (INUADDRESSID IS NULL) THEN
            ERRORS.SETERROR(CNUREQ_ATT_ERROR,
                            'inuAddressId');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        DAAB_ADDRESS.ACCKEY(INUADDRESSID);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALUPDATEOUTAGE;
    
    















    PROCEDURE UPDATEOUTAGEADDR
    (
        INUFAULTID   IN TT_DAMAGE.PACKAGE_ID%TYPE,
        INUADDRESSID IN AB_ADDRESS.ADDRESS_ID%TYPE
    )
    IS
        NUOLDADDRESSID AB_ADDRESS.ADDRESS_ID%TYPE; 
        RCAB_ADDRESS   DAAB_ADDRESS.STYAB_ADDRESS; 
        RCMO_ADDRESS   DAMO_ADDRESS.STYMO_ADDRESS; 
    BEGIN
        
        NUOLDADDRESSID := MO_BOADDRESS.FNUGETPARSERADDRIDBYPACK(INUFAULTID);
        
        IF (NUOLDADDRESSID IS NULL) THEN
            
            UT_TRACE.TRACE('La Direccion no existe en Mo_packages ['||INUADDRESSID||']',4);
            RCAB_ADDRESS := DAAB_ADDRESS.FRCGETRECORD(INUADDRESSID);

            RCMO_ADDRESS.ADDRESS             := RCAB_ADDRESS.ADDRESS;
            RCMO_ADDRESS.ADDRESS_ID          := MO_BOSEQUENCES.FNUGETADDRESSID;
            RCMO_ADDRESS.ADDRESS_TYPE_ID     := MO_BOADDRESS.CNUADDRESSTYPEMAIN;
            RCMO_ADDRESS.GEOGRAP_LOCATION_ID := RCAB_ADDRESS.GEOGRAP_LOCATION_ID;
            RCMO_ADDRESS.IS_ADDRESS_MAIN     := RCAB_ADDRESS.IS_MAIN;
            RCMO_ADDRESS.PACKAGE_ID          := INUFAULTID;
            RCMO_ADDRESS.PARSER_ADDRESS_ID   := RCAB_ADDRESS.ADDRESS_ID;
            DAMO_ADDRESS.INSRECORD(RCMO_ADDRESS);
        ELSE
            
            
            IF (NUOLDADDRESSID <> INUADDRESSID) THEN
                
                MO_BOADDRESS.CHANGEADDRESSORPREMISEDATA(INUFAULTID,
                                                        INUADDRESSID);
            END IF;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDATEOUTAGEADDR;

END TT_BOOUTAGE;