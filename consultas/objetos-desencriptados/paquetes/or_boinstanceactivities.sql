PACKAGE BODY Or_BoInstanceActivities IS






























































    CSBVERSION              CONSTANT VARCHAR2(20) := 'SAO212060';

    CSBCOMPELEMENTID        VARCHAR2(100) := OR_BOCONSTANTS.CSBCOMP4ELEMENTID;
    CSBCOMPELEMENTTYPE      VARCHAR2(100) := OR_BOCONSTANTS.CSBCOMP4ELEMENTTYPE;
    CSBCOMPELEMENTCODE      VARCHAR2(100) := OR_BOCONSTANTS.CSBCOMP4ELEMENTCODE;
    CSBCOMPELEMENTACTION    VARCHAR2(100) := OR_BOCONSTANTS.CSBCOMP4ELEMENTACTION;
    CSBCOMPELEMENTLOCATION  VARCHAR2(100) := OR_BOCONSTANTS.CSBCOMP4ELEMENTLOC;
    CSBCOMPONENTINSTANCE    VARCHAR2(100) := OR_BOCONSTANTS.CSBCOMPONENTINSTANCE;
    CSBCOMPONENTENTITY      VARCHAR2(100) := OR_BOCONSTANTS.CSBCOMPONENTENTITY;

	GTBEQUIPTOASSOC     TYTBASSOSEALTOEQUIP;
	
	GTBEQUIPREAD     TYTBEQUIPMENTREAD;
	
    
    GTBEQUIPFORASOC         TYTBEQUIPMENTFORASOC;
    


    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;
	
    FUNCTION FSBGETATTRIBUTEVALUE
    (
        ISBATTRIBUTE            GE_ATTRIBUTES.NAME_ATTRIBUTE%TYPE,
        INUORDERACTIVITYID      OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE
    ) RETURN GE_BOINSTANCECONTROL.STYSBVALUE
    IS
        SBVALUE         GE_BOINSTANCECONTROL.STYSBVALUE;
        SBINSTANCENAME  GE_BOINSTANCECONTROL.STYSBNAME;
        NUINDEX         GE_BOINSTANCECONTROL.STYNUINDEX;
    BEGIN

        SBINSTANCENAME := CSBACTIVITYINSTANCE||INUORDERACTIVITYID;
        UT_TRACE.TRACE('OR_BOInstanceActivities sbInstanceName='||SBINSTANCENAME||
                        ',isbAttribute='||ISBATTRIBUTE, 2 );
        IF GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(SBINSTANCENAME,NULL,'OR_ORDER_ACTIVITY' ,ISBATTRIBUTE, SBVALUE) THEN
            GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCENAME,NULL,'OR_ORDER_ACTIVITY' ,ISBATTRIBUTE, SBVALUE);
        END IF;
        
        RETURN SBVALUE;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBGETATTRIBUTEVALUE;

    
    
    
    PROCEDURE SETATTRIBUTE
    (
        INUORDERACTIVITYID  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        ISBATTRIBUTE        IN  GE_ATTRIBUTES.NAME_ATTRIBUTE%TYPE,
        ISBVALUE            IN  GE_BOINSTANCECONTROL.STYSBVALUE
    )
    IS
        SBINSTANCENAME  GE_BOINSTANCECONTROL.STYSBNAME;
    BEGIN

        SBINSTANCENAME := CSBACTIVITYINSTANCE||INUORDERACTIVITYID;
        GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCENAME,
                                          NULL,
                                          'OR_ORDER_ACTIVITY',
                                          ISBATTRIBUTE,
                                          ISBVALUE,
                                          GE_BOCONSTANTS.GETTRUE
                                          );
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    


















    PROCEDURE INITCOMPONENTINSTANCE
    (
        INUCURRENTACTIVITY  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUCOMPONENT        IN  NUMBER,
        INUATTRIBUTE        IN  NUMBER
    )
    IS
        SBINSTANCENAME      GE_BOINSTANCECONTROL.STYSBNAME;
        SBFATHERINSTANCE    GE_BOINSTANCECONTROL.STYSBNAME;
        SBATTRIBUTE         VARCHAR2(100);

    BEGIN

        IF INUCOMPONENT IN (OR_BOCONSTANTS.CNUELEMTSKTYPECOMPONENT )
        THEN
            SBFATHERINSTANCE    := CSBACTIVITYINSTANCE||INUCURRENTACTIVITY;
            SBINSTANCENAME      := CSBCOMPONENTINSTANCE||INUCURRENTACTIVITY||'_'||INUATTRIBUTE;
            GE_BOINSTANCECONTROL.CREATEINSTANCE (SBINSTANCENAME, SBFATHERINSTANCE);
            GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,CSBCOMPELEMENTTYPE||'1',NULL);
            GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,CSBCOMPELEMENTCODE||'1',NULL);
            GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,CSBCOMPELEMENTID||'1',NULL);
            GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,CSBCOMPELEMENTACTION ||'1',NULL);
            GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,CSBCOMPELEMENTLOCATION ||'1',NULL);

        
        ELSIF INUCOMPONENT = OR_BOCONSTANTS.CNUPOWERINSPECCOMPONENT THEN
        
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUCURRENTACTIVITY,OR_BOCONSTANTS.CSBPOWERINSPECCIRCUIT,NULL);
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUCURRENTACTIVITY,OR_BOCONSTANTS.CSBPOWERINSPECDISTANCE,NULL);
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUCURRENTACTIVITY,OR_BOCONSTANTS.CSBPOWERINSPECCAPACITY,NULL);
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUCURRENTACTIVITY,OR_BOCONSTANTS.CSBPOWERINSPECDEMAND,NULL);
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUCURRENTACTIVITY,OR_BOCONSTANTS.CSBPOWERINSPECSERVTYPE,NULL);
        ELSIF INUCOMPONENT =  OR_BOCONSTANTS.CNUREADPRODUCTCOMPONENT THEN
            SBFATHERINSTANCE    := CSBACTIVITYINSTANCE||INUCURRENTACTIVITY;
            SBINSTANCENAME      := CSBCOMPONENTINSTANCE||INUCURRENTACTIVITY||'_'||INUATTRIBUTE;
            GE_BOINSTANCECONTROL.CREATEINSTANCE (SBINSTANCENAME, SBFATHERINSTANCE);
             GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,CSBCOMPELEMENTCODE||'1',NULL);
        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END INITCOMPONENTINSTANCE;
    
    
    
    
    PROCEDURE SETCOMPONENTATTRIBVALUE
    (
        INUCURRENTACTIVITY  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUCOMPONENTGI      IN  NUMBER,
        INUATTRIBUTE        IN  NUMBER,
        INUSEQATTRIB        IN  NUMBER,
        INUELEMENTID        IN OR_ORDER_ITEMS.ELEMENT_ID%TYPE,
        INUELEMENTTYPE      IN IF_ELEMENT_TYPE.ELEMENT_TYPE_ID%TYPE,
        ISBELEMENTCODE      IN OR_ORDER_ITEMS.ELEMENT_CODE%TYPE,
        ISBELEMENTACTION    IN VARCHAR2,
        ISBLOCATION         IN VARCHAR2
    )
    IS
        SBINSTANCENAME          GE_BOINSTANCECONTROL.STYSBNAME;
        SBFATHERINSTANCE        GE_BOINSTANCECONTROL.STYSBNAME;
        SBATTRIBUTE             VARCHAR2(100);
        SBVALUE                 VARCHAR2(2000);

    BEGIN
        UT_TRACE.TRACE('Init Or_BoInstanceActivities.setComponentAttribValue',15);
        IF NVL(INUCOMPONENTGI,-1)
            NOT IN (OR_BOCONSTANTS.CNUELEMTSKTYPECOMPONENT)
        THEN
            RETURN;
        END IF;

        SBFATHERINSTANCE    := CSBACTIVITYINSTANCE||INUCURRENTACTIVITY;
        SBINSTANCENAME      := CSBCOMPONENTINSTANCE||INUCURRENTACTIVITY||'_'||INUATTRIBUTE;

        
        IF  NOT GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,CSBCOMPELEMENTTYPE||INUSEQATTRIB, SBVALUE)
                THEN
            GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,CSBCOMPELEMENTTYPE||INUSEQATTRIB,NULL);
            GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,CSBCOMPELEMENTCODE||INUSEQATTRIB,NULL);
            GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,CSBCOMPELEMENTID||INUSEQATTRIB,NULL);
            GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY, CSBCOMPELEMENTACTION ||INUSEQATTRIB,NULL);
            GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,CSBCOMPELEMENTLOCATION ||INUSEQATTRIB,NULL);
        END IF;

        
        GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,CSBCOMPELEMENTTYPE||INUSEQATTRIB,INUELEMENTTYPE);
        GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,CSBCOMPELEMENTCODE||INUSEQATTRIB,ISBELEMENTCODE);
        GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,CSBCOMPELEMENTID||INUSEQATTRIB,INUELEMENTID);
        GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,CSBCOMPELEMENTACTION||INUSEQATTRIB,ISBELEMENTACTION);
        GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,CSBCOMPELEMENTLOCATION||INUSEQATTRIB,ISBLOCATION);
        
        UT_TRACE.TRACE('End Or_BoInstanceActivities.setComponentAttribValue',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETCOMPONENTATTRIBVALUE;
    

    
    
    
    PROCEDURE GETCOMPONENTDATA
    (
        INUCURRENTACTIVITY  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUCOMPONENTGI      IN  NUMBER,
        INUATTRIBUTE        IN  NUMBER,
        OTBATTRIBUTES       OUT OR_BCORDERACTIVITIES.TYTBACTIVITYITEMS
    )
    IS
        SBINSTANCENAME       GE_BOINSTANCECONTROL.STYSBNAME;
        SBATTRIBUTE          VARCHAR2(100);
        NUATTRIBUTEIDX       NUMBER;
        SBVALUE              VARCHAR2(2000);
        NUINDEX              NUMBER;
        RCATTRIBUTE          GE_BOINSTANCECONTROL.TYRCATTRIBUTESTACK;
        NUINSTANCEIDX        NUMBER;
    BEGIN

        UT_TRACE.TRACE('Or_BoInstanceActivities.getComponentData',15);
        IF NVL(INUCOMPONENTGI,-1)
            NOT IN (OR_BOCONSTANTS.CNUELEMTSKTYPECOMPONENT)
         THEN
            RETURN;
        END IF;
        
        SBINSTANCENAME := CSBCOMPONENTINSTANCE||INUCURRENTACTIVITY||'_'||INUATTRIBUTE;
        
        NUINDEX := NULL;
        
        IF GE_BOINSTANCECONTROL.FBLACCKEYINSTANCESTACK(SBINSTANCENAME,NUINSTANCEIDX) THEN
            GE_BOINSTANCECONTROL.GETFIRSTENTITYATTRIBUTE(SBINSTANCENAME,NULL,CSBCOMPONENTENTITY,NUINDEX);
        END IF;
        
        
        WHILE NUINDEX IS NOT NULL LOOP
            GE_BOINSTANCECONTROL.GETATTRIBUTE(NUINDEX, RCATTRIBUTE);

            SBATTRIBUTE := RCATTRIBUTE.SBATTRIBUTE ;
            SBVALUE := RCATTRIBUTE.SBNEWVALUE ;
            
            IF SBATTRIBUTE LIKE '%'||CSBCOMPELEMENTID||'%' THEN
                NUATTRIBUTEIDX := TO_NUMBER(SUBSTR(SBATTRIBUTE,LENGTH(CSBCOMPELEMENTID)+1,LENGTH(SBATTRIBUTE)));
                UT_TRACE.TRACE('csbCompElementId='||CSBCOMPELEMENTID||'<=>'||NUATTRIBUTEIDX,15);
                OTBATTRIBUTES(NUATTRIBUTEIDX).NUELEMENTID := SBVALUE;
            ELSIF SBATTRIBUTE LIKE '%'||CSBCOMPELEMENTTYPE||'%' THEN
                NUATTRIBUTEIDX := TO_NUMBER(SUBSTR(SBATTRIBUTE,LENGTH(CSBCOMPELEMENTTYPE)+1,LENGTH(SBATTRIBUTE)));
                UT_TRACE.TRACE('csbCompElementType='||CSBCOMPELEMENTTYPE||'<=>'||NUATTRIBUTEIDX,15);
                OTBATTRIBUTES(NUATTRIBUTEIDX).NUELEMENTTYPEID := SBVALUE;
            ELSIF SBATTRIBUTE LIKE '%'||CSBCOMPELEMENTCODE||'%' THEN
                NUATTRIBUTEIDX := TO_NUMBER(SUBSTR(SBATTRIBUTE,LENGTH(CSBCOMPELEMENTCODE)+1,LENGTH(SBATTRIBUTE)) );
                UT_TRACE.TRACE('csbCompElementCode='||CSBCOMPELEMENTCODE||'<=>'||NUATTRIBUTEIDX,15);
                OTBATTRIBUTES(NUATTRIBUTEIDX).SBELEMENTCODE := SBVALUE;
            ELSIF SBATTRIBUTE LIKE '%'||CSBCOMPELEMENTACTION||'%' THEN
                NUATTRIBUTEIDX := TO_NUMBER(SUBSTR(SBATTRIBUTE,LENGTH(CSBCOMPELEMENTACTION)+1,LENGTH(SBATTRIBUTE)) );
                UT_TRACE.TRACE('csbCompElementAction='||CSBCOMPELEMENTACTION||'<=>'||NUATTRIBUTEIDX,15);
                OTBATTRIBUTES(NUATTRIBUTEIDX).SBACTION := SBVALUE;
            ELSIF SBATTRIBUTE LIKE '%'||CSBCOMPELEMENTLOCATION ||'%' THEN
                NUATTRIBUTEIDX := TO_NUMBER(SUBSTR(SBATTRIBUTE,LENGTH(CSBCOMPELEMENTLOCATION )+1,LENGTH(SBATTRIBUTE)) );
                UT_TRACE.TRACE('csbCompElementLocation ='||CSBCOMPELEMENTLOCATION ||'<=>'||NUATTRIBUTEIDX,15);
                OTBATTRIBUTES(NUATTRIBUTEIDX).SBADDDATA := SBVALUE;
            END IF;
            
            GE_BOINSTANCECONTROL.GETNEXTENTITYATTRIBUTE(NUINDEX);
            UT_TRACE.TRACE('index=>'||NUINDEX);
        END LOOP;
        UT_TRACE.TRACE('End Or_BoInstanceActivities.getComponentData',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCOMPONENTDATA;
    
    PROCEDURE INSTANCEINSPECTDATA
    (
        INUCURRENTACTIVITY  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUPOLEDISTANCE     IN  NUMBER,
        INUCAPACITY         IN  NUMBER,
        INUMAXDEMAND        IN NUMBER,
        INUCIRCUIT          IN NUMBER,
        INUSERVICETYPE      IN GE_SERVICE_TYPE.SERVICE_TYPE_ID%TYPE
    )
    IS
    BEGIN
        OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUCURRENTACTIVITY,OR_BOCONSTANTS.CSBPOWERINSPECDISTANCE,INUPOLEDISTANCE);
        OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUCURRENTACTIVITY,OR_BOCONSTANTS.CSBPOWERINSPECCAPACITY,INUCAPACITY);
        OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUCURRENTACTIVITY,OR_BOCONSTANTS.CSBPOWERINSPECDEMAND,INUMAXDEMAND);
        OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUCURRENTACTIVITY,OR_BOCONSTANTS.CSBPOWERINSPECCIRCUIT,INUCIRCUIT);
        OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUCURRENTACTIVITY,OR_BOCONSTANTS.CSBPOWERINSPECSERVTYPE,INUSERVICETYPE);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END INSTANCEINSPECTDATA;
    
    PROCEDURE GETINSTANCEINSPECTDATA
    (
        INUCURRENTACTIVITY  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        ONUPOLEDISTANCE     OUT NUMBER,
        ONUCAPACITY         OUT NUMBER,
        ONUMAXDEMAND        OUT NUMBER,
        ONUCIRCUIT          OUT NUMBER,
        ONUSERVICETYPE      OUT GE_SERVICE_TYPE.SERVICE_TYPE_ID%TYPE
    )
    IS
    BEGIN
        
        ONUPOLEDISTANCE := OR_BOINSTANCEACTIVITIES.FSBGETATTRIBUTEVALUE(OR_BOCONSTANTS.CSBPOWERINSPECDISTANCE,INUCURRENTACTIVITY);
        ONUCAPACITY     := OR_BOINSTANCEACTIVITIES.FSBGETATTRIBUTEVALUE(OR_BOCONSTANTS.CSBPOWERINSPECCAPACITY,INUCURRENTACTIVITY);
        ONUMAXDEMAND    := OR_BOINSTANCEACTIVITIES.FSBGETATTRIBUTEVALUE(OR_BOCONSTANTS.CSBPOWERINSPECDEMAND,INUCURRENTACTIVITY);
        ONUCIRCUIT      := OR_BOINSTANCEACTIVITIES.FSBGETATTRIBUTEVALUE(OR_BOCONSTANTS.CSBPOWERINSPECCIRCUIT,INUCURRENTACTIVITY);
        ONUSERVICETYPE  := OR_BOINSTANCEACTIVITIES.FSBGETATTRIBUTEVALUE(OR_BOCONSTANTS.CSBPOWERINSPECSERVTYPE,INUCURRENTACTIVITY);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETINSTANCEINSPECTDATA;

    FUNCTION FBLCHARGEACTIVITYCAUSAL
    (
        INUCURRENTACTIVITY  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE
    )
    RETURN BOOLEAN
    IS
        NUCAUSAL        GE_CAUSAL.CAUSAL_ID%TYPE;
        NUATTRIBUTEDTO  GE_CAUSAL.ATTRIBUTED_TO%TYPE;
    BEGIN

        
        NUCAUSAL := OR_BOINSTANCEACTIVITIES.FSBGETATTRIBUTEVALUE('CAUSALCAMBIO',INUCURRENTACTIVITY);

        
        IF NUCAUSAL IS NOT NULL AND DAGE_CAUSAL.FBLEXIST(NUCAUSAL) THEN
            NUATTRIBUTEDTO := DAGE_CAUSAL.FNUGETATTRIBUTED_TO(NUCAUSAL);
            
            IF NUATTRIBUTEDTO = 1 OR NUATTRIBUTEDTO = 3 THEN
                RETURN TRUE;
            ELSE
                RETURN FALSE;
            END IF;
        END IF;
        
        RETURN NULL;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBLCHARGEACTIVITYCAUSAL;
    
    

















    PROCEDURE SETEQUIPMENTREAD
    (
        ISBSERIE    	IN GE_ITEMS_SERIADO.SERIE%TYPE,
        INUCONSTYPE     IN LECTELME.LEEMTCON%TYPE,
        INUREAD     	IN LECTELME.LEEMLETO%TYPE,
        INUCAUSAL   	IN LECTELME.LEEMCLEC%TYPE,
        ISBCOMMENT1 	IN LECTELME.LEEMOBLE%TYPE,
        ISBCOMMENT2 	IN LECTELME.LEEMOBSB%TYPE,
        ISBCOMMENT3 	IN LECTELME.LEEMOBSC%TYPE
    )
    IS

    BEGIN

    GTBEQUIPREAD(ISBSERIE).TBREAD(INUCONSTYPE).SERIE     := ISBSERIE;
    GTBEQUIPREAD(ISBSERIE).TBREAD(INUCONSTYPE).CONSTYPE  := INUCONSTYPE;
    GTBEQUIPREAD(ISBSERIE).TBREAD(INUCONSTYPE).READ      := INUREAD;
    GTBEQUIPREAD(ISBSERIE).TBREAD(INUCONSTYPE).CAUSAL    := INUCAUSAL;
    GTBEQUIPREAD(ISBSERIE).TBREAD(INUCONSTYPE).COMMENT1  := ISBCOMMENT1;
    GTBEQUIPREAD(ISBSERIE).TBREAD(INUCONSTYPE).COMMENT2  := ISBCOMMENT2;
    GTBEQUIPREAD(ISBSERIE).TBREAD(INUCONSTYPE).COMMENT3  := ISBCOMMENT3;


    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETEQUIPMENTREAD;
    
    


















    
    PROCEDURE SETEQUIPMENTFORASOC
    (
        INUORDERACTIVITYID IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        ISBSERIE           IN GE_ITEMS_SERIADO.SERIE%TYPE
    )
    IS
    BEGIN
        UT_TRACE.TRACE('Or_BoInstanceActivities.setEquipmentForAsoc(inuOrderActivityId='||INUORDERACTIVITYID||
                       ' isbSerie='||ISBSERIE||')',15);

        GTBEQUIPFORASOC(INUORDERACTIVITYID||'_'||ISBSERIE).SBSERIE           := ISBSERIE;
        GTBEQUIPFORASOC(INUORDERACTIVITYID||'_'||ISBSERIE).NUORDERACTIVITYID := INUORDERACTIVITYID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETEQUIPMENTFORASOC;

    

















    PROCEDURE GETEQUIPMENTFORASOC
    (
        OGTBEQUIPFORASOC  OUT  TYTBEQUIPMENTFORASOC
    )
    IS
    BEGIN
        OGTBEQUIPFORASOC := GTBEQUIPFORASOC;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETEQUIPMENTFORASOC;

    





















    PROCEDURE SETEQUIPTOASSOC
    (
        ISBSEALSERIE        IN  GE_ITEMS_SERIADO.SERIE%TYPE,
        INUMETEREQUIP       IN  GE_ITEMS.ITEMS_ID%TYPE,
        ISBISTOASSOC        IN  VARCHAR2,
        INUACTIVITYID       IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        ISBLOCATION         IN  GE_ITEMS_TIPO_AT_VAL.VALOR%TYPE
    )
     IS

    BEGIN
        UT_TRACE.TRACE('-- INICIO Or_BoInstanceActivities.setEquipToAssoc. isbSealSerie '
                        ||TO_CHAR(ISBSEALSERIE)     ||', inuMeterEquip '
                        ||TO_CHAR(INUMETEREQUIP)    ||', isbIsToAssoc '
                        ||ISBISTOASSOC              ||', inuActivityId '
                        ||TO_CHAR(INUACTIVITYID)    ||', isbLocation '
                        ||ISBLOCATION, 2 );

        GTBEQUIPTOASSOC(ISBSEALSERIE).SEALSERIE  := ISBSEALSERIE;
        GTBEQUIPTOASSOC(ISBSEALSERIE).METEREQUIP := INUMETEREQUIP;
        GTBEQUIPTOASSOC(ISBSEALSERIE).ISTOASSOC  := ISBISTOASSOC;
        GTBEQUIPTOASSOC(ISBSEALSERIE).ACTIVITYID := INUACTIVITYID;
        GTBEQUIPTOASSOC(ISBSEALSERIE).LOCATION := ISBLOCATION;
        
        UT_TRACE.TRACE('-- FIN Or_BoInstanceActivities.setEquipToAssoc', 2 );

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETEQUIPTOASSOC;
    
    
    















    PROCEDURE GETEQUIPMENTREAD
    (
        ISBSERIE    	  IN  GE_ITEMS_SERIADO.SERIE%TYPE DEFAULT NULL,
        OTBEQUIPMENTREAD  OUT TYTBEQUIPMENTREAD
    )
    IS

    BEGIN
        UT_TRACE.TRACE('-- INICIO Or_BoInstanceActivities.getEquipmentRead', 2 );
        UT_TRACE.TRACE('isbSerie '||ISBSERIE, 2 );

        IF (GTBEQUIPREAD.EXISTS(ISBSERIE)) THEN
            OTBEQUIPMENTREAD(ISBSERIE) := GTBEQUIPREAD(ISBSERIE);
        ELSE
            OTBEQUIPMENTREAD := GTBEQUIPREAD;
        END IF;

        UT_TRACE.TRACE('-- FIN Or_BoInstanceActivities.getEquipmentRead', 2 );

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETEQUIPMENTREAD;
    
    
















    PROCEDURE GETEQUIPTOASSOC
    (
        ISBSEALSERIE        IN  GE_ITEMS_SERIADO.SERIE%TYPE DEFAULT NULL,
        OTBASSOSEALTOEQUIP  OUT TYTBASSOSEALTOEQUIP
    )
    IS

    BEGIN
        IF (GTBEQUIPTOASSOC.EXISTS(ISBSEALSERIE)) THEN
            OTBASSOSEALTOEQUIP(ISBSEALSERIE) := GTBEQUIPTOASSOC(ISBSEALSERIE);
        ELSE
            OTBASSOSEALTOEQUIP := GTBEQUIPTOASSOC;
        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETEQUIPTOASSOC;
    
    























    PROCEDURE UPDEQUIPTOASSOC
    (
        ISBSEALSERIE        IN  GE_ITEMS_SERIADO.SERIE%TYPE,
        INUMETEREQUIP       IN  GE_ITEMS.ITEMS_ID%TYPE,
        ISBISTOASSOC        IN  VARCHAR2,
        INUACTIVITYID       IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        ISBLOCATION         IN  GE_ITEMS_TIPO_AT_VAL.VALOR%TYPE
    )
    IS
    BEGIN
        UT_TRACE.TRACE('INICIO Or_BoInstanceActivities.UpdEquipToAssoc. isbSealSerie: '||ISBSEALSERIE||', inuMeterEquip: '||INUMETEREQUIP||', isbIsToAssoc: '||ISBISTOASSOC||', inuActivityId: '||INUACTIVITYID||', isbLocation:'||ISBLOCATION, 2 );
        
        
        IF (GTBEQUIPTOASSOC.EXISTS(ISBSEALSERIE)) THEN
            UT_TRACE.TRACE('Se actualiza gtbEquiptoAssoc', 2 );
            GTBEQUIPTOASSOC(ISBSEALSERIE).SEALSERIE     := ISBSEALSERIE;
            GTBEQUIPTOASSOC(ISBSEALSERIE).METEREQUIP    := INUMETEREQUIP;
            GTBEQUIPTOASSOC(ISBSEALSERIE).ISTOASSOC     := ISBISTOASSOC;
            GTBEQUIPTOASSOC(ISBSEALSERIE).ACTIVITYID    := INUACTIVITYID;
            GTBEQUIPTOASSOC(ISBSEALSERIE).LOCATION      := ISBLOCATION;
        END IF;
        
        UT_TRACE.TRACE('INICIO Or_BoInstanceActivities.UpdEquipToAssoc',2);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDEQUIPTOASSOC;
    
    

















    PROCEDURE CLEAREQUIPTOASSO
    IS
    BEGIN
    
        GTBEQUIPTOASSOC.DELETE;
    
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CLEAREQUIPTOASSO;
    
    

















    PROCEDURE CLEAREQUIPREAD
    IS
    BEGIN

        GTBEQUIPREAD.DELETE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CLEAREQUIPREAD;
    
    



















    PROCEDURE CLEARTEMPTABLES
    IS
    BEGIN

        GTBEQUIPTOASSOC.DELETE;
        GTBEQUIPREAD.DELETE;
        GTBEQUIPFORASOC.DELETE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CLEARTEMPTABLES;
    
END OR_BOINSTANCEACTIVITIES;