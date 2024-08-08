PACKAGE BODY Or_BOLegalizeActivities
IS














































































































































































































































































































	
    CSBVERSION   CONSTANT VARCHAR2(20)            := 'SAO419879';

    

    GRCORDERACTIVITY        OR_BCORDERACTIVITIES.TYRCORDERACTIVITIES;
    TBACTIVITIESATTRIBCONF  OR_BCORDERACTIVITIES.TYTBACTIVITIESATTRIBCONF;
    GTBORDERACTIVITIES      OR_BCORDERACTIVITIES.TYTBORDERACTIVITIES;
    
    GTBNOTIFYWFACTIVITY     UT_STRING.TYTB_STRING;
    
    TYPE TYTBREQUIREDREADS   IS TABLE OF GE_ITEMS_SERIADO.SERIE%TYPE INDEX BY VARCHAR2(50);

    CNUCONTRACTOVERRUN      CONSTANT NUMBER(5)  := GE_BOPARAMETER.FNUGET('CONTRACT_OVERRUN');
    CNUSUCCESS_CLASS_CAUSAL CONSTANT NUMBER(4) := 1;
    CNUINVALIDREAD          CONSTANT NUMBER := 120622;
    
    CNUERR_CREATE_DIAG_ORDER CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 116181;
    
    CNUERR_7613             CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 7613;
    
    CNUERR_901056   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901056;
    
    
    CNUERR901477   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901477;
    
    
    CNU901528       CONSTANT   GE_MESSAGE.MESSAGE_ID%TYPE := 901528;
    
    
    CNUERR7486      CONSTANT   GE_MESSAGE.MESSAGE_ID%TYPE := 7486;
    
    CNUERR901711            CONSTANT    GE_MESSAGE.MESSAGE_ID%TYPE := 901711;
    
    
    CNUERR902296    CONSTANT   GE_MESSAGE.MESSAGE_ID%TYPE := 902296;
    
    
    
    CNUERR913132    CONSTANT   GE_MESSAGE.MESSAGE_ID%TYPE := 913132;

    CSBSEPARATOR_5          CONSTANT VARCHAR2(1)    := '>'; 

    CSBFWINSTANCENAME CONSTANT VARCHAR2(50) := 'FW_'||OR_BOCONSTANTS.CSBORDER_INSTANCE;

    
    TBCREATEDORDERS         DAOR_ORDER.TYTBORDER_ID;


    
    
    
    SBISUTILITIES       GE_BOITEMS.STYLETTER := GE_BOCONSTANTS.CSBNO;

	

	
	
	
    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    
    PROCEDURE SETCURRENTACTIVITYRECORD(IRCORDERACTIVITY IN OR_BCORDERACTIVITIES.TYRCORDERACTIVITIES)
    IS
    BEGIN
        GRCORDERACTIVITY := IRCORDERACTIVITY;
    END SETCURRENTACTIVITYRECORD;

    
    PROCEDURE CLEARACTIVITYRECORD
    IS
        RCORDERACTIVITYNULL OR_BCORDERACTIVITIES.TYRCORDERACTIVITIES;
    BEGIN
        GRCORDERACTIVITY := RCORDERACTIVITYNULL;
    END CLEARACTIVITYRECORD;

    
    PROCEDURE GETACTIVITYRECORD(ORCORDERACTIVITY OUT OR_BCORDERACTIVITIES.TYRCORDERACTIVITIES)
    IS
    BEGIN
        ORCORDERACTIVITY := GRCORDERACTIVITY;
    END GETACTIVITYRECORD;
    
    
    PROCEDURE INSERTSEALITEM
    (
        INUORDERID      IN  OR_ORDER.ORDER_ID%TYPE,
        INUORDERACTID   IN  OR_ORDER_ITEMS.ORDER_ACTIVITY_ID%TYPE,
        ISBSERIE        IN  OR_ORDER_ITEMS.SERIE%TYPE
    );

    
    PROCEDURE INSERTSEALITEMS
    (
        INUORDERID           IN  OR_ORDER.ORDER_ID%TYPE,
        INUORDERACTIVITYID   IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE
    );

    
    
    
    PROCEDURE VALIDATELEGALIZEACTIVITY
    (
        INUORDERID          IN OR_ORDER.ORDER_ID%TYPE,
        INUCAUSAL           IN OR_ORDER.CAUSAL_ID%TYPE,
        ITBORDERACTIVITIES  IN OR_BCORDERACTIVITIES.TYTBORDERACTIVITIES
    )
    IS
        NUINDEX     NUMBER;
        NUCOUNT     NUMBER;
        CNUONELEGALIZE  CONSTANT NUMBER := 120586;
        CNUFAILLEGALIZE CONSTANT NUMBER := 3907;
    BEGIN
        UT_TRACE.TRACE('INICIO Or_bolegalizeActivities.validateLegalizeActivity-', 15);
        NUINDEX :=  ITBORDERACTIVITIES.FIRST;

        WHILE NUINDEX IS NOT NULL LOOP
            IF ITBORDERACTIVITIES(NUINDEX).NULEGALIZECOUNT > GE_BOCONSTANTS.CNUFALSE THEN
                NUCOUNT := 1;
            END IF;
            NUINDEX :=  ITBORDERACTIVITIES.NEXT(NUINDEX);
        END LOOP;

        
        IF NVL(NUCOUNT,0) < 1 AND GE_BOCAUSAL.FBLGETSUCESSFULLCLASSCAUSAL(INUCAUSAL) THEN
            GE_BOERRORS.SETERRORCODE(CNUONELEGALIZE);
        END IF;

        
        IF NVL(NUCOUNT,0) = 1 AND NOT GE_BOCAUSAL.FBLGETSUCESSFULLCLASSCAUSAL(INUCAUSAL) THEN
            GE_BOERRORS.SETERRORCODE(CNUFAILLEGALIZE);
        END IF;

        UT_TRACE.TRACE('FIN Or_bolegalizeActivities.validateLegalizeActivity',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDATELEGALIZEACTIVITY;

    























    PROCEDURE TRYNOTIFYWFACTIVITY
    (
        INUORDERID          IN OR_ORDER.ORDER_ID%TYPE,
        INUINSTANCEID       IN OR_ORDER_ACTIVITY.INSTANCE_ID%TYPE,
        INUCAUSALID         IN OR_ORDER.CAUSAL_ID%TYPE,
        ITBORDERACTIVITIES  IN OR_BCORDERACTIVITIES.TYTBORDERACTIVITIES,
        ITBNOTIFYWORKFLOW   IN DAOR_REGENERA_ACTIVIDA.TYTBACTIVIDAD_WF
    )
    IS
        NUCAUSALWFID GE_CAUSAL.CAUSAL_ID%TYPE;
        NUINDEX      NUMBER;

    BEGIN
        UT_TRACE.TRACE('INICIO Or_bolegalizeActivities.TryNotifyWFActivity '||INUINSTANCEID, 15);

        
        
        IF ITBORDERACTIVITIES.COUNT > 1 THEN
            NUINDEX :=  ITBORDERACTIVITIES.FIRST;
            WHILE NUINDEX IS NOT NULL LOOP
                IF (INUINSTANCEID = NVL(ITBORDERACTIVITIES(NUINDEX).NUINSTANCEID, -1)
                    AND ITBNOTIFYWORKFLOW(NUINDEX) = GE_BOCONSTANTS.CSBNO)
                THEN
                    UT_TRACE.TRACE('No Notificar, por actividades pendientes', 15);
                    RETURN ;
                END IF;
                NUINDEX := ITBORDERACTIVITIES.NEXT(NUINDEX);
            END LOOP;
        END IF;

        
        IF OR_BCORDERACTIVITIES.FBLHASPENDINGACTIVITIES(INUORDERID,INUINSTANCEID) THEN
            RETURN ;
        END IF;
        

        NUCAUSALWFID := GE_BOEQUIVALENCVALUES.FNUGETTARGETVALUE
                            (
                                OR_BOCONSTANTS.CNUEQ_GROUP_NOTI_ORD_WF,
                                INUCAUSALID
                            );

        
        GTBNOTIFYWFACTIVITY(INUINSTANCEID) := NUCAUSALWFID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END TRYNOTIFYWFACTIVITY;

    
    
    
    PROCEDURE INSERTACTIVITYITEMS
    (
        INUORDERID          IN  OR_ORDER.ORDER_ID%TYPE,
        INUORDERACTIVITYID  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUITEMSID          IN  OR_ORDER_ITEMS.ITEMS_ID%TYPE,
        INUELEMENTTYPE      IN  IF_NODE.ELEMENT_TYPE_ID%TYPE,
        ISBELEMENTCODE      IN  IF_NODE.CODE%TYPE,
        INUELEMENTID        IN  IF_NODE.ID%TYPE DEFAULT NULL
    )
    IS
        NUELEMENTID     IF_NODE.ID%TYPE;
        NULEGALITEMAMOUNT OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT%TYPE;
        RCORDERITEMS    DAOR_ORDER_ITEMS.STYOR_ORDER_ITEMS;

        NUITEMSID       OR_ORDER_ITEMS.ITEMS_ID%TYPE;

        NUELEMENT IF_ASSIGNABLE.ID%TYPE;
        SBSERIALNUM IF_ASSIGNABLE.SERIAL_NUMBER%TYPE;
        NUCLASSID IF_ASSIGNABLE.CLASS_ID%TYPE;
        NUOPERATINGSECTOR OR_OPERATING_SECTOR.OPERATING_SECTOR_ID%TYPE;

    BEGIN
        UT_TRACE.TRACE('or_bolegalizeActivities.insertActivityItems: '||INUITEMSID,15);

        IF ISBELEMENTCODE IS NULL THEN
            RETURN;
        END IF;

        IF_BOELEMENTQUERY.GETELEMINFOFROMCODE
                    (
                    INUELEMENTTYPE,
                    ISBELEMENTCODE,
                    NUELEMENT,
                    SBSERIALNUM,
                    NUCLASSID,
                    NUOPERATINGSECTOR
                    );

        NUELEMENTID := NVL (INUELEMENTID,NUELEMENT);

        UT_TRACE.TRACE('Code: '||ISBELEMENTCODE||'-ID: '||NUELEMENTID||'-TYPE: '||INUELEMENTTYPE,15);

        IF OR_BCLEGALIZEITEMS.FNUEXISTELEMENT(INUORDERACTIVITYID,NUELEMENTID) = 0 THEN
            NULEGALITEMAMOUNT :=1;

            IF DAIF_ELEMENT_TYPE.FNUGETELEMENT_GROUP_ID(INUELEMENTTYPE ) = IF_BOCONSTANTS.CNUNODEELEMENT THEN
                UT_TRACE.TRACE('ElementONodal id: '||NUELEMENTID||'-Code: '|| ISBELEMENTCODE, 15);
                IF DAIF_NODE.FNUGETREAL_PROJ_STATUS_ID(NUELEMENTID) = IF_BOCONSTANTS.CNUREALELEMENT THEN
                    UT_TRACE.TRACE('Cantidad A legalizar: 0', 15);
                    NULEGALITEMAMOUNT := 0;
                END IF;
            END IF;

            UT_TRACE.TRACE('Insertando Elemento en Actividad',15);

            NUITEMSID := GE_BCITEMS.FNUGETITEMBYCLASSANDUSE(INUELEMENTTYPE, NUCLASSID, DAGE_ITEMS.FSBGETUSE_(INUITEMSID));

            IF NUITEMSID IS NULL THEN
                NUITEMSID := INUITEMSID;
            END IF;
            UT_TRACE.TRACE('Clase: '||NUCLASSID||'- item: '||INUITEMSID||'-item segun code: '||NUITEMSID,15);

            RCORDERITEMS.ITEMS_ID               :=  NUITEMSID;
            RCORDERITEMS.ORDER_ACTIVITY_ID      :=  INUORDERACTIVITYID;
            RCORDERITEMS.ELEMENT_CODE           :=  ISBELEMENTCODE;
            RCORDERITEMS.ELEMENT_ID             :=  NUELEMENTID;
            RCORDERITEMS.ORDER_ID               :=  INUORDERID;
            RCORDERITEMS.ASSIGNED_ITEM_AMOUNT   :=  1;
            RCORDERITEMS.LEGAL_ITEM_AMOUNT      :=  NULEGALITEMAMOUNT;
            RCORDERITEMS.VALUE                  :=  0;
            RCORDERITEMS.TOTAL_PRICE            :=  0;
            RCORDERITEMS.ORDER_ITEMS_ID         :=  OR_BOSEQUENCES.FNUNEXTOR_ORDER_ITEMS;

            DAOR_ORDER_ITEMS.INSRECORD(RCORDERITEMS);
        END IF;

        UT_TRACE.TRACE('Fin or_bolegalizeActivities.insertActivityItems: '||RCORDERITEMS.ORDER_ITEMS_ID,15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END INSERTACTIVITYITEMS;

    FUNCTION FBOSAMEITEMCHAGED
    (
        SBINSTANCE  IN GE_BOINSTANCECONTROL.STYSBNAME
    )
    RETURN BOOLEAN
    IS
        SBVALUE     GE_BOINSTANCECONTROL.STYSBVALUE;
    BEGIN
        
		IF GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(SBINSTANCE,
            NULL, 'OR_LEGALIZE_DATA', 'SAME_ITEM', SBVALUE)
        THEN
            UT_TRACE.TRACE('El item a retirar e instalar son el mismo', 10);
            RETURN TRUE;
        END IF;
        UT_TRACE.TRACE('El item a retirar e instalar son distintos', 10);
        RETURN FALSE;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBOSAMEITEMCHAGED;
    






    PROCEDURE PROCESSCHANGEAMOUNT
    (
        SBINSTANCE          IN GE_BOINSTANCECONTROL.STYSBNAME,
        INUORDERACTIVITYID  IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE
    )
    IS
        SBAMOUNT        GE_BOINSTANCECONTROL.STYSBVALUE;
        NUAMOUNT        OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT%TYPE;
        SBORDERITEMSID  GE_BOINSTANCECONTROL.STYSBVALUE;
        NUORDERITEMSID  OR_ORDER_ITEMS.ORDER_ITEMS_ID%TYPE;
    BEGIN
        
        SBAMOUNT:= OR_BOINSTANCEACTIVITIES.FSBGETATTRIBUTEVALUE('AMOUNT_TO_REPLACE',INUORDERACTIVITYID);

		IF SBAMOUNT IS NOT NULL THEN
            NUAMOUNT := TO_NUMBER(SBAMOUNT);
            IF GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(SBINSTANCE, NULL, 'OR_LEGALIZE_DATA', 'NEW_ORDER_ITEMS', SBORDERITEMSID) THEN
                GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'OR_LEGALIZE_DATA' ,'NEW_ORDER_ITEMS', SBORDERITEMSID);
                NUORDERITEMSID := TO_NUMBER(SBORDERITEMSID);
                DAOR_ORDER_ITEMS.UPDLEGAL_ITEM_AMOUNT(NUORDERITEMSID, NUAMOUNT);
            END IF;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END PROCESSCHANGEAMOUNT;

    

























































    PROCEDURE PROCESSACTWARRANTY
    (
        INUORDERID        IN  OR_ORDER_ACTIVITY.ORDER_ID%TYPE,
        IDTEXEFINDAT      IN    OR_ORDER.EXECUTION_FINAL_DATE%TYPE,
        IRCORDERACTIVITY  IN  OR_BCORDERACTIVITIES.TYRCORDERACTIVITIES,
        OTBACTIVITYITEMS  IN OUT OR_BCORDERACTIVITIES.TYTBACTIVITYITEMS
    )
    IS
        NUITEMID            GE_ITEMS.ITEMS_ID%TYPE;
        NUITEMWARRANTYID    GE_ITEM_WARRANTY.ITEM_WARRANTY_ID%TYPE;
        TBINSTAELEMSBYACT   OR_BCORDERACTIVITIES.TYTBACTIVITYITEMS;
        RCINSTAELEMSBYACT   OR_BCORDERACTIVITIES.TYRCACTIVITYITEM;
        TBWITHDELEMSBYACT   OR_BCORDERACTIVITIES.TYTBACTIVITYITEMS;
        RCWITHDELEMSBYACT   OR_BCORDERACTIVITIES.TYRCACTIVITYITEM;
        NUINSTITEMID        GE_ITEMS.ITEMS_ID%TYPE;
        BLISCLIENTPROPERTY  BOOLEAN;
        BLISCHANGE          BOOLEAN := FALSE;
        BLINWARRANTY        BOOLEAN;
        BLISCLIENTFAULT     BOOLEAN;
        SBINSTANCE_NAME     GE_BOINSTANCECONTROL.STYSBNAME;

        NUPRODUCTID         OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE;
        BLSAMEITEMCHANGED   BOOLEAN;
        DTFINALDATE         OR_ORDER.EXECUTION_FINAL_DATE%TYPE;

        TBELEMENTS          OR_BCORDERITEMS.TYTBELEMENTCHANGE;
        RCELEMENT           OR_BCORDERITEMS.TYELEMENTCHANGE;
        RCINSTALLELEMENT    OR_BCORDERITEMS.TYELEMENTCHANGE;
        RCRETIREELEMENT     OR_BCORDERITEMS.TYELEMENTCHANGE;

        
        NUELEMINDEX         NUMBER;

        BLINSTALL           BOOLEAN := FALSE;
        BLRETIRE            BOOLEAN := FALSE;
        BLCAMBIOMED         BOOLEAN := FALSE;

        NUELEMTYPEINST      IF_ELEMENT_TYPE.ELEMENT_TYPE_ID%TYPE;
        SBCODEINST          OR_ORDER_ITEMS.ELEMENT_CODE%TYPE;
        NUCLASSIDINST       IF_ELEMENT_CLASS.CLASS_ID%TYPE;

        NUELEMTYPERET      IF_ELEMENT_TYPE.ELEMENT_TYPE_ID%TYPE;
        SBCODERET          OR_ORDER_ITEMS.ELEMENT_CODE%TYPE;
        NUCLASSIDRET       IF_ELEMENT_CLASS.CLASS_ID%TYPE;

        RCACTIVITYITEM     OR_BCORDERACTIVITIES.TYRCACTIVITYITEM;

    BEGIN

        DTFINALDATE := IDTEXEFINDAT;
        IF DTFINALDATE IS NULL THEN
           DTFINALDATE:= SYSDATE;
        END IF;

        
        IF IRCORDERACTIVITY.NUPRODUCTID IS NULL THEN
            NUPRODUCTID := OR_BCORDERACTIVITIES.FNUGETPRODUCTIDBYORDER(INUORDERID);
        ELSE
            NUPRODUCTID := IRCORDERACTIVITY.NUPRODUCTID;
        END IF;

        UT_TRACE.TRACE('Fecha fin de ejecucion de la orden: '||TO_CHAR(DTFINALDATE,'dd/mm/yyyy hh24:mi:ss'),5);
        
        
        NUITEMID := DAOR_ORDER_ITEMS.FNUGETITEMS_ID(IRCORDERACTIVITY.NUORDERITEMID);

        
        TBELEMENTS.DELETE;
        RCELEMENT := NULL;
        RCINSTALLELEMENT := NULL;
        RCRETIREELEMENT := NULL;

        UT_TRACE.TRACE('Producto: '||NUPRODUCTID||' Orden: '||INUORDERID||' Actividad: '||IRCORDERACTIVITY.NUORDERACTIVITY);
        OR_BCORDERITEMS.GETELEMENTCHANGE(IRCORDERACTIVITY.NUORDERACTIVITY,TBELEMENTS);
        NUELEMINDEX :=  TBELEMENTS.FIRST;

        LOOP
            EXIT WHEN NUELEMINDEX IS NULL;

            RCELEMENT := TBELEMENTS(NUELEMINDEX);

            IF (RCELEMENT.USE_ = OR_BOCONSTANTS.CSBINSTALLUSE)THEN

                BLINSTALL := TRUE;
                RCINSTALLELEMENT := RCELEMENT;

            ELSIF (RCELEMENT.USE_ = OR_BOCONSTANTS.CSBWITHDRAWUSE)THEN

                BLRETIRE := TRUE;
                RCRETIREELEMENT := RCELEMENT;

            END IF;

            NUELEMINDEX := TBELEMENTS.NEXT(NUELEMINDEX);
            RCELEMENT := NULL;
        END LOOP;

        
        IF (BLINSTALL AND BLRETIRE) THEN
            BLCAMBIOMED := TRUE; 
        END IF;

        IF RCINSTALLELEMENT.ELEMENT_ID IS NOT NULL THEN
            IF_BOELEMENT.GETELEMENTTYPECODECLASS(RCINSTALLELEMENT.ELEMENT_ID,NUELEMTYPEINST,SBCODEINST,NUCLASSIDINST);
        END IF;

        UT_TRACE.TRACE('Elemento: '||RCINSTALLELEMENT.ELEMENT_ID||' Tipo: '||NUELEMTYPEINST||' Codigo: '||SBCODEINST||' Clase: '||NUCLASSIDINST);

        IF RCRETIREELEMENT.ELEMENT_ID IS NOT NULL THEN
          IF_BOELEMENT.GETELEMENTTYPECODECLASS(RCRETIREELEMENT.ELEMENT_ID, NUELEMTYPERET, SBCODERET, NUCLASSIDRET);
        END IF;

        UT_TRACE.TRACE('Elemento: '||RCRETIREELEMENT.ELEMENT_ID||' Tipo: '||NUELEMTYPERET||' Codigo: '||SBCODERET||' Clase: '||NUCLASSIDRET);


        
        OR_BCORDERACTIVITIES.LINKUNBOUNDITEMS(INUORDERID, IRCORDERACTIVITY.NUORDERACTIVITY);

        
        SBINSTANCE_NAME := OR_BOLEGALIZEACTIVITIES.CSBACTIVITYINSTANCE
            || IRCORDERACTIVITY.NUORDERACTIVITY;

        
        IF BLCAMBIOMED THEN
            OR_BCORDERACTIVITIES.GETITEMSBYACTIVITY(
                                                    IRCORDERACTIVITY.NUORDERACTIVITY,
                                                    OR_BOCONSTANTS.CSBINSTALLACTION,
                                                    RCINSTALLELEMENT.ELEMENT_ID,
                                                    TBINSTAELEMSBYACT 
                                                    );
        ELSE
            OR_BCORDERACTIVITIES.GETITEMSBYACTIVITY(
                                                IRCORDERACTIVITY.NUORDERACTIVITY,
                                                OR_BOCONSTANTS.CSBINSTALLACTION,
                                                TBINSTAELEMSBYACT 
                                                );
        END IF;


        
        BLSAMEITEMCHANGED := FBOSAMEITEMCHAGED(SBINSTANCE_NAME);
        IF BLSAMEITEMCHANGED THEN
            TBWITHDELEMSBYACT := TBINSTAELEMSBYACT;
        
        ELSE

            IF BLCAMBIOMED THEN
                OR_BCORDERACTIVITIES.GETITEMSBYACTIVITY(
                                                        IRCORDERACTIVITY.NUORDERACTIVITY,
                                                        OR_BOCONSTANTS.CSBDELETE,
                                                        RCRETIREELEMENT.ELEMENT_ID,
                                                        TBWITHDELEMSBYACT 
                                                        );
            ELSE
                OR_BCORDERACTIVITIES.GETITEMSBYACTIVITY(
                                                    IRCORDERACTIVITY.NUORDERACTIVITY,
                                                    OR_BOCONSTANTS.CSBDELETE,
                                                    TBWITHDELEMSBYACT 
                                                    );
            END IF;

        END IF;

        UT_TRACE.TRACE('Items a instalar: '||TBINSTAELEMSBYACT.COUNT||' Items a retirar: '||TBWITHDELEMSBYACT.COUNT, 3);

        IF (TBINSTAELEMSBYACT.COUNT >=1 OR BLCAMBIOMED) THEN
            IF (TBWITHDELEMSBYACT.COUNT >=1 OR BLCAMBIOMED) THEN
                
                IF NUELEMTYPERET IS NULL THEN
                    
                    IF ((NOT BLCAMBIOMED)
                         AND  TBWITHDELEMSBYACT.COUNT = 1
                         AND  TBINSTAELEMSBYACT.COUNT = 1 )
                    THEN
                        BLISCHANGE := TRUE;
                        BLINWARRANTY := GE_BOITEMWARRANTY.FBOITEMISINWARRANTY(TBINSTAELEMSBYACT(TBINSTAELEMSBYACT.FIRST).NUITEMID, NUPRODUCTID);
                        BLISCLIENTPROPERTY := FALSE;
                        IF BLINWARRANTY THEN
                            UT_TRACE.TRACE('es cambio de item generico-garantia:', 3);
                        ELSE
                            UT_TRACE.TRACE('es cambio de item generico-NO garantia:', 3);
                        END IF;

                    END IF;
                ELSE
                    
                    
                    IF BLCAMBIOMED
                    AND NUELEMTYPEINST = NUELEMTYPERET
                    THEN
                        BLISCHANGE := TRUE;

                        
                        NUINSTITEMID := GE_BCITEMS.FNUGETITEMBYCLASSANDUSE
                                        (
                                            NUELEMTYPERET,
                                            NUCLASSIDRET,
                                            OR_BOCONSTANTS.CSBINSTALLACTION
                                        );

                        UT_TRACE.TRACE('nuInstItemId: '||NUINSTITEMID);

                        BLINWARRANTY := GE_BOITEMWARRANTY.FBOELEMISINWARRANTY(NUINSTITEMID, RCRETIREELEMENT.ELEMENT_ID);

                        BLISCLIENTPROPERTY := IF_BOELEMENTQUERY.FSBISCLIENTPROPERTY(RCINSTALLELEMENT.ITEMS_ID,RCINSTALLELEMENT.ELEMENT_ID) = GE_BOCONSTANTS.CSBYES;

                        IF BLINWARRANTY THEN
                            UT_TRACE.TRACE('es cambio de elemento de red-garantia:', 3);
                        ELSE
                            UT_TRACE.TRACE('es cambio de elemento de red-NO garantia:', 3);
                        END IF;
                    END IF;
                END IF;

                
                IF BLISCHANGE THEN
                    
                    
                    

                    UT_TRACE.TRACE('Elemento de instalacion: '||RCINSTALLELEMENT.ELEMENT_ID);

                    IF (RCINSTALLELEMENT.ELEMENT_ID IS NULL) THEN
                        RCINSTAELEMSBYACT := TBINSTAELEMSBYACT(TBINSTAELEMSBYACT.FIRST);
                        RCINSTALLELEMENT.ITEMS_ID     := RCINSTAELEMSBYACT.NUITEMID;
                        RCINSTALLELEMENT.ELEMENT_CODE := RCINSTAELEMSBYACT.SBELEMENTCODE;
                        RCINSTALLELEMENT.ELEMENT_ID   := RCINSTAELEMSBYACT.NUELEMENTID;
                        RCINSTALLELEMENT.USE_         := RCINSTAELEMSBYACT.SBACTION;
                    END IF;

                    IF (RCRETIREELEMENT.ELEMENT_ID IS NULL) THEN
                        RCWITHDELEMSBYACT := TBWITHDELEMSBYACT(TBWITHDELEMSBYACT.FIRST);
                        RCRETIREELEMENT.ITEMS_ID     :=RCWITHDELEMSBYACT.NUITEMID;
                        RCRETIREELEMENT.ELEMENT_CODE :=RCWITHDELEMSBYACT.SBELEMENTCODE;
                        RCRETIREELEMENT.ELEMENT_ID   :=RCWITHDELEMSBYACT.NUELEMENTID;
                        RCRETIREELEMENT.USE_         :=RCWITHDELEMSBYACT.SBACTION;
                    END IF;

                    NUINSTITEMID := NVL(NUINSTITEMID, RCINSTALLELEMENT.ITEMS_ID);

                    UT_TRACE.TRACE('nuInstItemId2: '||NUINSTITEMID);
                    NUITEMWARRANTYID := GE_BCITEMWARRANTY.FNUGETITEMWARRANTY(NUINSTITEMID, RCRETIREELEMENT.ELEMENT_ID, NUPRODUCTID);

                    UT_TRACE.TRACE('nuItemWarrantyId: '||NUITEMWARRANTYID||' warrantyId: '||NUITEMWARRANTYID||' item instalacion: '||RCINSTALLELEMENT.ITEMS_ID, 3);

                    
                    IF DAGE_ITEM_WARRANTY.FBLEXIST(NUITEMWARRANTYID) THEN

                        
                        BLISCLIENTFAULT := OR_BOINSTANCEACTIVITIES.FBLCHARGEACTIVITYCAUSAL(IRCORDERACTIVITY.NUORDERACTIVITY);
                        IF BLISCLIENTFAULT THEN
                            UT_TRACE.TRACE('blIsClientFault: ', 3);
                        ELSE
                            UT_TRACE.TRACE('NOT blIsClientFault: ', 3);
                        END IF;

                        

                        IF (BLINWARRANTY
                            
                        AND NOT BLISCLIENTFAULT)
                        
                        OR BLISCLIENTPROPERTY THEN

                            UT_TRACE.TRACE('Se a�ade a garantia: '||RCINSTALLELEMENT.ITEMS_ID, 3);

                            
                            RCACTIVITYITEM.NUACTIVITYID := IRCORDERACTIVITY.NUORDERACTIVITY;
                            RCACTIVITYITEM.SBELEMENTCODE := RCINSTALLELEMENT.ELEMENT_CODE;
                            RCACTIVITYITEM.NUITEMID := RCINSTALLELEMENT.ITEMS_ID;
                            RCACTIVITYITEM.NUELEMENTTYPEID := NUELEMTYPEINST;
                            RCACTIVITYITEM.NUELEMENTCLASSID := NUCLASSIDINST;
                            RCACTIVITYITEM.NUELEMENTID := RCINSTALLELEMENT.ELEMENT_ID;
                            RCACTIVITYITEM.SBACTION := OR_BOCONSTANTS.CSBINSTALLACTION;

                            OTBACTIVITYITEMS(OTBACTIVITYITEMS.COUNT + 1) := RCACTIVITYITEM;

                        END IF; 

                         
                        IF NOT BLISCLIENTPROPERTY THEN
                            UT_TRACE.TRACE('No es propiedad del cliente',15);
                            GE_BOITEMWARRANTY.PROCESSELEMENTINSTALL
                            (
                                RCINSTALLELEMENT.ITEMS_ID,
                                RCINSTALLELEMENT.ELEMENT_ID,
                                RCINSTALLELEMENT.ELEMENT_CODE,
                                NUPRODUCTID,
                                INUORDERID,
                                NULL,
                                NULL,
                                DTFINALDATE
                            );
                        END IF;

                        IF NUITEMWARRANTYID IS NOT NULL THEN
                            DAGE_ITEM_WARRANTY.UPDIS_ACTIVE(NUITEMWARRANTYID, 'N');
                        END IF;

                     ELSIF BLISCLIENTPROPERTY THEN
                        
                        RCACTIVITYITEM.NUACTIVITYID := IRCORDERACTIVITY.NUORDERACTIVITY;
                        RCACTIVITYITEM.SBELEMENTCODE := RCINSTALLELEMENT.ELEMENT_CODE;
                        RCACTIVITYITEM.NUITEMID := RCINSTALLELEMENT.ITEMS_ID;
                        RCACTIVITYITEM.NUELEMENTTYPEID := NUELEMTYPEINST;
                        RCACTIVITYITEM.NUELEMENTCLASSID := NUCLASSIDINST;
                        RCACTIVITYITEM.NUELEMENTID := RCINSTALLELEMENT.ELEMENT_ID;
                        RCACTIVITYITEM.SBACTION := OR_BOCONSTANTS.CSBINSTALLACTION;

                        OTBACTIVITYITEMS(OTBACTIVITYITEMS.COUNT + 1) := RCACTIVITYITEM;

                     ELSE
                        GE_BOITEMWARRANTY.PROCESSELEMENTINSTALL
                        (
                            RCINSTALLELEMENT.ITEMS_ID,
                            RCINSTALLELEMENT.ELEMENT_ID,
                            RCINSTALLELEMENT.ELEMENT_CODE,
                            NUPRODUCTID,
                            INUORDERID,
                            NULL,
                            NULL,
                            DTFINALDATE
                        );

                     END IF; 
                END IF;
            END IF; 
            

            IF TBINSTAELEMSBYACT.COUNT > 0 AND NOT BLISCHANGE THEN
                UT_TRACE.TRACE('INSTALACION PURA', 3);
                FOR N IN TBINSTAELEMSBYACT.FIRST .. TBINSTAELEMSBYACT.LAST LOOP
                    

                     IF TBINSTAELEMSBYACT(N).SBACTION = OR_BOCONSTANTS.CSBINSTALLACTION THEN
                        IF TBINSTAELEMSBYACT(N).NUELEMENTTYPEID IS NOT NULL THEN
                            UT_TRACE.TRACE('Elemento de red a instalar:'||TBINSTAELEMSBYACT(N).NUITEMID, 3);
                            IF IF_BOELEMENTQUERY.FSBISCLIENTPROPERTY(TBINSTAELEMSBYACT(N).NUITEMID,TBINSTAELEMSBYACT(N).NUELEMENTID) = GE_BOCONSTANTS.CSBNO THEN

                                GE_BOITEMWARRANTY.PROCESSELEMENTINSTALL
                                (
                                    TBINSTAELEMSBYACT(N).NUITEMID,
                                    TBINSTAELEMSBYACT(N).NUELEMENTID,
                                    TBINSTAELEMSBYACT(N).SBELEMENTCODE,
                                    NUPRODUCTID,
                                    INUORDERID,
                                    NULL,
                                    NULL,
                                    DTFINALDATE
                                );
                            ELSE
                                OTBACTIVITYITEMS(OTBACTIVITYITEMS.COUNT + 1) := TBINSTAELEMSBYACT(N);
                            END IF;

                        ELSE
                            UT_TRACE.TRACE('Item generico a instalar:'||TBINSTAELEMSBYACT(N).NUITEMID, 3);
                            
                            
















                            GE_BOITEMWARRANTY.DEACTIVATEPREVIOUS (
                                NUPRODUCTID,
                                DTFINALDATE
                            );

                            UT_TRACE.TRACE('Fecha Base Garantia: ' || TO_CHAR(DTFINALDATE, 'dd/mm/yyyy hh24:mi:ss'), 3);

                            GE_BOITEMWARRANTY.PROCESSELEMENTINSTALL
                            (
                                TBINSTAELEMSBYACT(N).NUITEMID,
                                TBINSTAELEMSBYACT(N).NUELEMENTID,
                                TBINSTAELEMSBYACT(N).SBELEMENTCODE,
                                NUPRODUCTID,
                                INUORDERID,
                                NULL,
                                NULL,
                                DTFINALDATE
                            );
                        END IF;
                    END IF;
                END LOOP;
            ELSIF TBINSTAELEMSBYACT.COUNT > 0 AND BLCAMBIOMED THEN
                UT_TRACE.TRACE('INSTALACION PURA 2', 3);
                FOR N IN TBINSTAELEMSBYACT.FIRST .. TBINSTAELEMSBYACT.LAST LOOP
                    

                     IF TBINSTAELEMSBYACT(N).SBACTION = OR_BOCONSTANTS.CSBINSTALLACTION THEN
                        IF TBINSTAELEMSBYACT(N).NUELEMENTTYPEID IS NOT NULL THEN
                            UT_TRACE.TRACE('Elemento de red a instalar:'||TBINSTAELEMSBYACT(N).NUITEMID, 3);
                            IF IF_BOELEMENTQUERY.FSBISCLIENTPROPERTY(TBINSTAELEMSBYACT(N).NUITEMID,TBINSTAELEMSBYACT(N).NUELEMENTID) = GE_BOCONSTANTS.CSBNO THEN

                                UT_TRACE.TRACE('Fecha Base Garantia: ' || TO_CHAR(DTFINALDATE, 'dd/mm/yyyy hh24:mi:ss'), 3);

                                GE_BOITEMWARRANTY.PROCESSELEMENTINSTALL
                                (
                                    TBINSTAELEMSBYACT(N).NUITEMID,
                                    TBINSTAELEMSBYACT(N).NUELEMENTID,
                                    TBINSTAELEMSBYACT(N).SBELEMENTCODE,
                                    NUPRODUCTID,
                                    INUORDERID,
                                    NULL,
                                    NULL,
                                    DTFINALDATE
                                );

                            ELSE
                                UT_TRACE.TRACE('Propiedad del cliente...');
                                UT_TRACE.TRACE('**nuProductId: '||NUPRODUCTID);

                                
                                NUITEMWARRANTYID := GE_BCITEMWARRANTY.FNUGETITEMWARRDEACTIVATE
                                    (
                                        NUPRODUCTID,
                                        NULL
                                    );

                                UT_TRACE.TRACE('nuItemWarrantyId:'||NUITEMWARRANTYID, 3);

                                IF (NUITEMWARRANTYID IS NOT NULL) AND (NUITEMWARRANTYID != CC_BOCONSTANTS.CSBNULLSTRING) THEN
                                    DAGE_ITEM_WARRANTY.UPDIS_ACTIVE(NUITEMWARRANTYID, 'N');
                                END IF;
                                
                                OTBACTIVITYITEMS(OTBACTIVITYITEMS.COUNT + 1) := TBINSTAELEMSBYACT(N);
                            END IF;
                        ELSE
                            UT_TRACE.TRACE('Item generico a instalar:'||TBINSTAELEMSBYACT(N).NUITEMID, 3);

                            GE_BOITEMWARRANTY.PROCESSELEMENTINSTALL
                            (
                                TBINSTAELEMSBYACT(N).NUITEMID,
                                TBINSTAELEMSBYACT(N).NUELEMENTID,
                                TBINSTAELEMSBYACT(N).SBELEMENTCODE,
                                NUPRODUCTID,
                                INUORDERID,
                                NULL,
                                NULL,
                                DTFINALDATE
                            );
                        END IF;
                     END IF;
                END LOOP;
            END IF;
        END IF; 

        
        IF TBWITHDELEMSBYACT.COUNT > 0 AND NOT BLISCHANGE THEN
            UT_TRACE.TRACE('RETIRO PURO', 3);
            FOR M IN TBWITHDELEMSBYACT.FIRST .. TBWITHDELEMSBYACT.LAST LOOP
                 IF TBWITHDELEMSBYACT(M).SBACTION = OR_BOCONSTANTS.CSBDELETE THEN
                    
                    NUINSTITEMID := GE_BCITEMS.FNUGETITEMBYCLASSANDUSE
                                    (
                                        TBWITHDELEMSBYACT(M).NUELEMENTTYPEID,
                                        TBWITHDELEMSBYACT(M).NUELEMENTCLASSID,
                                        OR_BOCONSTANTS.CSBINSTALLACTION
                                    );
                    GE_BOITEMWARRANTY.PROCESSELEMENTWITHDRAWAL(NUINSTITEMID, TBWITHDELEMSBYACT(M).NUELEMENTID, NUPRODUCTID);
                 END IF;
            END LOOP;
        END IF;

        PROCESSCHANGEAMOUNT(SBINSTANCE_NAME, IRCORDERACTIVITY.NUORDERACTIVITY);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END PROCESSACTWARRANTY;

    




















    PROCEDURE ASSIGNNETELEMENTS
    (
        IRCACTIVITY IN OR_BCORDERACTIVITIES.TYRCORDERACTIVITIES
    )
    IS
        TBELEMENTS OR_BCORDERACTIVITIES.TYTBACTIVITYITEMS;
        RCELEM     OR_BCORDERACTIVITIES.TYRCACTIVITYITEM;
        SBACTION   IF_STATUS_ACTION.ACTION_ID%TYPE;
        NUINDEX    BINARY_INTEGER;

    BEGIN
        UT_TRACE.TRACE('assignNetElements: '||IRCACTIVITY.NUORDERACTIVITY, 5);

        TBELEMENTS.DELETE;

        
        OR_BCORDERACTIVITIES.GETELEMSBYACTIVITY(IRCACTIVITY.NUORDERACTIVITY,
            NULL, TBELEMENTS );

        
        NUINDEX := TBELEMENTS.FIRST;
        WHILE NUINDEX IS NOT NULL LOOP
            RCELEM := TBELEMENTS(NUINDEX);

            
            IF NVL(RCELEM.SBADDDATA,'0')  <> '0' THEN
                
                UT_TRACE.TRACE('ElementsData: '||RCELEM.SBADDDATA, 5);
                IF RCELEM.SBACTION = OR_BOCONSTANTS.CSBINSTALLACTION THEN
                    
                    IF_BOSERVICES_OR.VALELEMENT(RCELEM.SBELEMENTCODE,
                        RCELEM.NUELEMENTTYPEID, OR_BOCONSTANTS.CSBPREINSTALLACTION);
                    IF_BOELEMENTQUERY.VALIDATEASSIGNEDSTATUS(RCELEM.NUELEMENTTYPEID,
                        RCELEM.SBELEMENTCODE);
                    
                    IF_BOSERVICES_OR.CHANGEELSTAT(RCELEM.SBELEMENTCODE,
                        RCELEM.NUELEMENTTYPEID,
                        OR_BOCONSTANTS.CSBPREINSTALLACTION); 

                END IF;

                

            
            
                IF IRCACTIVITY.NUPROCESSID IN (
                    OR_BOCONSTANTS.CNUPROCESS_PREVENT_MAINT,
                    OR_BOCONSTANTS.CNUPROCESS_DAMAGES,
                    OR_BOCONSTANTS.CNUPROCESS_AUTONOMOUS )
                THEN
                    
                    SBACTION := IF_BOCONSTANTS.CNUBUSYACTION ;
                    IF RCELEM.SBACTION = OR_BOCONSTANTS.CSBDELETE THEN
                        SBACTION := IF_BOCONSTANTS.CNUFREEACTION ;
                    END IF;
                    
                    IF_BOEXECUTEACTION.EXECUTEACTION(IM_BOCONSTANTS.CNUIM_MODULE,
                        SBACTION,RCELEM.NUELEMENTTYPEID, RCELEM.NUELEMENTID);
                ELSE
                
                   IF RCELEM.SBACTION IN ( OR_BOCONSTANTS.CSBINSTALLACTION,
                            OR_BOCONSTANTS.CSBDELETE )
                        THEN
                            
                            IF_BOSERVICES_OR.VALELEMENT(RCELEM.SBELEMENTCODE,
                                RCELEM.NUELEMENTTYPEID, RCELEM.SBACTION);
                            
                            IF_BOSERVICES_OR.CHANGEELSTAT(RCELEM.SBELEMENTCODE,
                                RCELEM.NUELEMENTTYPEID, RCELEM.SBACTION); 

                        END IF;
                END IF;
            END IF;

            NUINDEX := TBELEMENTS.NEXT(NUINDEX);
        END LOOP;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END ASSIGNNETELEMENTS;

    












    PROCEDURE PROCESSUPDRECEQU
    (
        INUORDERID          IN      OR_ORDER.ORDER_ID%TYPE,
        RCITEMSSERIADO      IN OUT  DAGE_ITEMS_SERIADO.STYGE_ITEMS_SERIADO
    )
    IS
        NUORDERITEMSID      OR_ORDER_ITEMS.ORDER_ITEMS_ID%TYPE;
        NURECOVERYITEMID    GE_ITEMS.RECOVERY_ITEM_ID%TYPE;
    BEGIN
        IF (RCITEMSSERIADO.PROPIEDAD = GE_BOITEMSCONSTANTS.CSBEMPRESA) THEN
            
            NURECOVERYITEMID := DAGE_ITEMS.FNUGETRECOVERY_ITEM_ID(RCITEMSSERIADO.ITEMS_ID, 0);
            IF (NURECOVERYITEMID IS NOT NULL) THEN
                
                NUORDERITEMSID:= OR_BCORDERITEMS.FNUGETORDITEBYORDSER(INUORDERID, RCITEMSSERIADO.ID_ITEMS_SERIADO);
                DAOR_ORDER_ITEMS.UPDITEMS_ID(NUORDERITEMSID, NURECOVERYITEMID);

                
                RCITEMSSERIADO.ITEMS_ID := NURECOVERYITEMID;
                DAGE_ITEMS_SERIADO.UPDITEMS_ID(RCITEMSSERIADO.ID_ITEMS_SERIADO, NURECOVERYITEMID);
            END IF;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END PROCESSUPDRECEQU;

    













    PROCEDURE ASSOCIATESERIALCOMPONENT
    (
        ISBSERIE            GE_ITEMS_SERIADO.SERIE%TYPE
    );



    

























    PROCEDURE PROCESSACTIVITYREAD
    (
        INUORDERID              IN  OR_ORDER.ORDER_ID%TYPE,
        IDTEXEFINDAT            IN  OR_ORDER.EXECUTION_FINAL_DATE%TYPE,
        INUORDERACTIVITYID      IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUACTIVITYID           IN  OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE,
        INUPERSONID             IN  OR_ORDER_PERSON.PERSON_ID%TYPE,
        INUPRODUCTID            IN  OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE,
        IRCACTIVITIESATTRIBCONF IN  OR_BCORDERACTIVITIES.TYRCACTIVITIESATTRIBCONF
    )
    IS
        ORFPRODUCTELEMENT   CONSTANTS.TYREFCURSOR;
        TBEQUIPMENTREAD     OR_BOINSTANCEACTIVITIES.TYTBEQUIPMENTREAD;
        TBCURRENTREAD       OR_BOINSTANCEACTIVITIES.TYTBEQUIPREAD;
        NUREADIDX           NUMBER := NULL;
        SBSERIEREADS        GE_ITEMS_SERIADO.SERIE%TYPE := NULL;

        NUTMPPRODUCT    OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE;
        NUSERVCLASSID   PS_CLASS_SERVICE.CLASS_SERVICE_ID%TYPE;
        SBITEMDESC      GE_ITEMS.DESCRIPTION%TYPE;
        SBSERIE         GE_ITEMS_SERIADO.SERIE%TYPE;
        NUTMPITEMTIPO   GE_ITEMS.ID_ITEMS_TIPO%TYPE;
        NUTMPITEMGAMA   GE_ITEMS_GAMA.ID_ITEMS_GAMA%TYPE;

        CNUERRORPRODUCTOS       CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 300079; 
        CNUINVALIDINSTALLDATE   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 8101;
        NUQUANTITY              NUMBER := 0;
        DTREADDATE DATE;

    BEGIN
        UT_TRACE.TRACE('INICIO or_bolegalizeactivities.legalizeActivity.ProcessActivityRead  ',15);

        IF (OR_BOCONSTANTS.CNUREADINGCOMPONENT IN
            (IRCACTIVITIESATTRIBCONF.NUCOMPONENT1,IRCACTIVITIESATTRIBCONF.NUCOMPONENT2,
             IRCACTIVITIESATTRIBCONF.NUCOMPONENT3,IRCACTIVITIESATTRIBCONF.NUCOMPONENT4)) THEN

            OR_BOINSTANCEACTIVITIES.GETEQUIPMENTREAD(NULL, TBEQUIPMENTREAD);
            
            
            IF(TBEQUIPMENTREAD.COUNT =0) THEN
                GE_BOERRORS.SETERRORCODE(CNUERR902296);
            END IF;
            
            
            NUQUANTITY := 0;

            
            IF(IRCACTIVITIESATTRIBCONF.NUCOMPONENT1 = OR_BOCONSTANTS.CNUREADINGCOMPONENT ) THEN
                NUQUANTITY := NUQUANTITY+1;
            END IF;

            IF(IRCACTIVITIESATTRIBCONF.NUCOMPONENT2 = OR_BOCONSTANTS.CNUREADINGCOMPONENT ) THEN
                NUQUANTITY := NUQUANTITY+1;
            END IF;

            IF(IRCACTIVITIESATTRIBCONF.NUCOMPONENT3 = OR_BOCONSTANTS.CNUREADINGCOMPONENT ) THEN
                NUQUANTITY := NUQUANTITY+1;
            END IF;

            IF(IRCACTIVITIESATTRIBCONF.NUCOMPONENT4 = OR_BOCONSTANTS.CNUREADINGCOMPONENT ) THEN
                NUQUANTITY := NUQUANTITY+1;
            END IF;
            
            SBSERIEREADS := TBEQUIPMENTREAD.FIRST;
            UT_TRACE.TRACE('ReadSeries['||SBSERIEREADS||']nuQuantity['||NUQUANTITY, 15);

            
            WHILE SBSERIEREADS IS NOT NULL LOOP
                TBCURRENTREAD := TBEQUIPMENTREAD(SBSERIEREADS).TBREAD;

                IF(TBCURRENTREAD.COUNT =0) THEN
                    GE_BOERRORS.SETERRORCODEARGUMENT(CNUINVALIDREAD, SBSERIEREADS);
                END IF;

                
                NUQUANTITY := NUQUANTITY-1;

                
                NUREADIDX := TBCURRENTREAD.FIRST;
                
                WHILE (NUREADIDX IS NOT NULL ) LOOP

                    DTREADDATE :=IDTEXEFINDAT - 1/UT_DATE.CNUSECONDSBYDAY;
                    
                    IF (TBCURRENTREAD(NUREADIDX).CAUSAL = CM_BOCONSTANTS.CSBCAUS_LECT_INST ) THEN
                        DTREADDATE := IDTEXEFINDAT;
                    END IF;

                    UT_TRACE.TRACE('inuOrderActivityId '        ||INUORDERACTIVITYID                ||' - '
                        ||' inuOrderId'                         ||INUORDERID                        ||' - '
                        ||' inuOrderActivityId'                 ||INUORDERACTIVITYID                ||' - '
                        ||' inuActivityId'                      ||INUACTIVITYID                     ||' - '
                        ||' inuPersonId '                       ||INUPERSONID                       ||' - '
                        ||' inuProductId '                      ||INUPRODUCTID                      ||' - '
                        ||' tbCurrentRead(nuReadIdx).Serie '    ||TBCURRENTREAD(NUREADIDX).SERIE    ||' - '
                        ||' tbCurrentRead(nuReadIdx).ConsType ' ||TBCURRENTREAD(NUREADIDX).CONSTYPE ||' - '
                        ||' tbCurrentRead(nuReadIdx).Read '     ||TBCURRENTREAD(NUREADIDX).READ     ||' - '
                        ||' tbCurrentRead(nuReadIdx).Causal '   ||TBCURRENTREAD(NUREADIDX).CAUSAL   ||' - '
                        ||' tbCurrentRead(nuReadIdx).Comment1 ' ||TBCURRENTREAD(NUREADIDX).COMMENT1 ||' - '
                        ||' tbCurrentRead(nuReadIdx).Comment2 ' ||TBCURRENTREAD(NUREADIDX).COMMENT2 ||' - '
                        ||' tbCurrentRead(nuReadIdx).Comment3 ' ||TBCURRENTREAD(NUREADIDX).COMMENT3 ||' - ', 15 );
                        
                   CM_BOLECTELME.INSERTREADING
                   (
                    INUORDERACTIVITYID,
                    INUORDERID,
                    INUACTIVITYID,
                    INUPERSONID,
                    INUPRODUCTID,
                    TBCURRENTREAD(NUREADIDX).SERIE,
                    TBCURRENTREAD(NUREADIDX).CONSTYPE,
                    TBCURRENTREAD(NUREADIDX).READ,
                    TBCURRENTREAD(NUREADIDX).CAUSAL,
                    DTREADDATE,
                    TBCURRENTREAD(NUREADIDX).COMMENT1,
                    TBCURRENTREAD(NUREADIDX).COMMENT2,
                    TBCURRENTREAD(NUREADIDX).COMMENT3
                   );

                    NUREADIDX := TBCURRENTREAD.NEXT(NUREADIDX);
                END LOOP;
                
                SBSERIEREADS := TBEQUIPMENTREAD.NEXT(SBSERIEREADS);
            END LOOP;
            
            
            IF(NUQUANTITY > 0) THEN
                GE_BOERRORS.SETERRORCODE(CNUERR902296);
            END IF;

        ELSIF (OR_BOCONSTANTS.CNUREADPRODUCTCOMPONENT IN
            (IRCACTIVITIESATTRIBCONF.NUCOMPONENT1,IRCACTIVITIESATTRIBCONF.NUCOMPONENT2,
             IRCACTIVITIESATTRIBCONF.NUCOMPONENT3,IRCACTIVITIESATTRIBCONF.NUCOMPONENT4)) THEN

            GE_BOGENERALUTIL.CLOSE_REFCURSOR(ORFPRODUCTELEMENT);


            
            OR_BOLEGALIZEORDERREAD.GETORDERELEMENTDATA(INUPRODUCTID, ORFPRODUCTELEMENT);

            LOOP
                TBEQUIPMENTREAD.DELETE;
                TBCURRENTREAD.DELETE;

                FETCH ORFPRODUCTELEMENT INTO NUTMPPRODUCT, NUSERVCLASSID, SBITEMDESC, SBSERIE, NUTMPITEMTIPO, NUTMPITEMGAMA;
                EXIT WHEN ORFPRODUCTELEMENT%NOTFOUND;

                
                OR_BOINSTANCEACTIVITIES.GETEQUIPMENTREAD(SBSERIE, TBEQUIPMENTREAD);

                IF (TBEQUIPMENTREAD.EXISTS(SBSERIE)) THEN
                    TBCURRENTREAD := TBEQUIPMENTREAD(SBSERIE).TBREAD;

                    
                    NUREADIDX := TBCURRENTREAD.FIRST;
                    WHILE (NUREADIDX IS NOT NULL ) LOOP

                        DTREADDATE :=IDTEXEFINDAT - 1/UT_DATE.CNUSECONDSBYDAY;
                        
                        IF (TBCURRENTREAD(NUREADIDX).CAUSAL = CM_BOCONSTANTS.CSBCAUS_LECT_INST) THEN
                            DTREADDATE := IDTEXEFINDAT;
                        END IF;


                       CM_BOLECTELME.INSERTREADING
                       (
                        INUORDERACTIVITYID,
                        INUORDERID,
                        INUACTIVITYID,
                        INUPERSONID,
                        INUPRODUCTID,
                        TBCURRENTREAD(NUREADIDX).SERIE,
                        TBCURRENTREAD(NUREADIDX).CONSTYPE,
                        TBCURRENTREAD(NUREADIDX).READ,
                        TBCURRENTREAD(NUREADIDX).CAUSAL,
                        DTREADDATE,
                        TBCURRENTREAD(NUREADIDX).COMMENT1,
                        TBCURRENTREAD(NUREADIDX).COMMENT2,
                        TBCURRENTREAD(NUREADIDX).COMMENT3
                       );

                        NUREADIDX := TBCURRENTREAD.NEXT(NUREADIDX);
                    END LOOP;
                ELSE
                    GE_BOERRORS.SETERRORCODEARGUMENT(CNUINVALIDREAD, SBSERIE);
                END IF;
            END LOOP;

            GE_BOGENERALUTIL.CLOSE_REFCURSOR(ORFPRODUCTELEMENT);

        END IF;

        UT_TRACE.TRACE('FIN or_bolegalizeactivities.legalizeActivity.ProcessActivityRead  ',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(ORFPRODUCTELEMENT);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(ORFPRODUCTELEMENT);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END PROCESSACTIVITYREAD;

    




























































































































    PROCEDURE LEGALIZEACTIVITY
    (
        INUORDER                IN  OR_ORDER.ORDER_ID%TYPE,
        IDTEXEFINDAT            IN  OR_ORDER.EXECUTION_FINAL_DATE%TYPE,
        IRCORDERACTIVITY        IN  OR_BCORDERACTIVITIES.TYRCORDERACTIVITIES,
        IRCACTIVITIESCONF       IN  OR_BCORDERACTIVITIES.TYRCACTIVITIESCONF,
        IRCACTIVITIESATTRIBCONF IN  OR_BCORDERACTIVITIES.TYRCACTIVITIESATTRIBCONF,
        INUOPERATINGUNIT        IN  OR_ORDER.OPERATING_UNIT_ID%TYPE,
        INUPERSONID             IN  OR_ORDER_PERSON.PERSON_ID%TYPE,
        OTBACTIVITYITEMS        IN OUT OR_BCORDERACTIVITIES.TYTBACTIVITYITEMS
    )
    IS
        BLVALIDATEREQUIRED  BOOLEAN := TRUE;
        SBINSTANCE          VARCHAR2(1000);
        SBATTRIBVALUE1      VARCHAR2(2000);
        SBATTRIBVALUE2      VARCHAR2(2000);
        SBATTRIBVALUE3      VARCHAR2(2000);
        SBATTRIBVALUE4      VARCHAR2(2000);
        TBEQUIPMENT         OR_BCORDERITEMS.TYTBEQUIPMENT;
        
        NUPRCOMPONENTID     PR_COMPONENT.COMPONENT_ID%TYPE;
        NUADDRESSID         OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE;
        NUSUBSCRIBERID      OR_ORDER_ACTIVITY.SUBSCRIBER_ID%TYPE;
        NUTMPCOMPPRODID     OR_ORDER_ACTIVITY.COMPONENT_ID%TYPE;
        NUCOMPONENTTYPEID   PR_COMPONENT.COMPONENT_TYPE_ID%TYPE;
        NUCLASSSERVICEID    PR_COMPONENT.CLASS_SERVICE_ID%TYPE;
        NUPRODUCTID         OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE;
        NUPRODUCTTYPEID     PR_PRODUCT.PRODUCT_TYPE_ID%TYPE;
        ISBPROCESSEQUIP     GE_BOITEMS.STYLETTER := GE_BOCONSTANTS.CSBNO;
        ISBPROCESSREAD      GE_BOITEMS.STYLETTER := GE_BOCONSTANTS.CSBYES;

        














































        PROCEDURE INSERTITEMSERIADO
        (
            INUORDERID      IN  OR_ORDER.ORDER_ID%TYPE,
            INUORDERACTID   IN  OR_ORDER_ITEMS.ORDER_ACTIVITY_ID%TYPE,
            INUOPERUNITID   IN  OR_ORDER.OPERATING_UNIT_ID%TYPE,
            ISBSERIE        IN  OR_ORDER_ITEMS.SERIE%TYPE,
            IBLOUT          IN  BOOLEAN,
            INUCOMPONENTID  IN  MO_COMPONENT.COMPONENT_ID%TYPE,
            INUPRODUCTID    IN  OR_ORDER_ACTIVITY.PRODUCT_ID %TYPE DEFAULT NULL,
            ISBATTRIBUTE    IN  GE_ATTRIBUTES.NAME_ATTRIBUTE%TYPE DEFAULT ''
        )
        IS
            NUSERIALITEMID  GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%TYPE;
            NUITEMSTYPEID   GE_ITEMS_TIPO.ID_ITEMS_TIPO%TYPE;
            NUITEMSID       GE_ITEMS.ITEMS_ID%TYPE;
            SBDESCRIPTION   GE_ITEMS.DESCRIPTION%TYPE;
            RCORDERITEM     DAOR_ORDER_ITEMS.STYOR_ORDER_ITEMS;
            NULEGALITEMAMO  OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT%TYPE := 1;
            BLVALIDATE      BOOLEAN := TRUE;
            NUCOMPONENTID   MO_COMPONENT.COMPONENT_ID%TYPE;
        BEGIN
            UT_TRACE.TRACE(' INICIO or_bolegalizeactivities.insertItemSeriado: '
                                ||ISBSERIE                  ||' inuComponentId: '
                                ||TO_CHAR(INUCOMPONENTID)   ||' isbAttribute:'
                                ||ISBATTRIBUTE              ||' isbSerie: '
                                ||ISBSERIE                  ||' inuOrderActId: '
                                ||TO_CHAR(INUORDERACTID)    ||' inuOperUnitId: '
                                ||TO_CHAR(INUOPERUNITID)    , 2);
            
            IF (ISBATTRIBUTE = OR_BOCONSTANTS.CSBSERIALITEMWITHDRAW) THEN
                NULEGALITEMAMO := -1;
            END IF;

            IF IBLOUT THEN
                IF (ISBATTRIBUTE = OR_BOCONSTANTS.CSBSERIALITEMINSTALL) THEN
                    NUCOMPONENTID := NULL;
                ELSE
                    NUCOMPONENTID := INUCOMPONENTID;
                END IF;
                
                OR_BOACTIVITIESRULES.VALITEMSERIADO
                    (
                        INUORDERID,
                        INUOPERUNITID,
                        INUORDERACTID,
                        ISBSERIE,
                        NUSERIALITEMID,
                        NUITEMSTYPEID,
                        SBDESCRIPTION,
                        ISBATTRIBUTE,
                        NUCOMPONENTID
                    );
                RCORDERITEM.OUT_ := GE_BOCONSTANTS.CSBYES;
            ELSE
                BLVALIDATE := FALSE;
                OR_BOACTIVITIESRULES.VALITEMTORETIRE
                    (
                        ISBSERIE,
                        INUCOMPONENTID,
                        NUSERIALITEMID,
                        NUITEMSTYPEID,
                        INUPRODUCTID,
                        BLVALIDATE
                    );
                RCORDERITEM.OUT_ := GE_BOCONSTANTS.CSBNO;
            END IF;

            NUITEMSID := DAGE_ITEMS_SERIADO.FNUGETITEMS_ID(NUSERIALITEMID);

            RCORDERITEM.ITEMS_ID          := NUITEMSID;
            RCORDERITEM.ORDER_ACTIVITY_ID := INUORDERACTID;
            RCORDERITEM.SERIE             := UPPER(ISBSERIE);
            RCORDERITEM.SERIAL_ITEMS_ID   := NUSERIALITEMID;
            RCORDERITEM.ORDER_ID          := INUORDERID;
            RCORDERITEM.ASSIGNED_ITEM_AMOUNT  := 1;
            RCORDERITEM.LEGAL_ITEM_AMOUNT     := NULEGALITEMAMO;
            RCORDERITEM.VALUE                 := 0;
            RCORDERITEM.TOTAL_PRICE           := 0;
            RCORDERITEM.ORDER_ITEMS_ID  := OR_BOSEQUENCES.FNUNEXTOR_ORDER_ITEMS;

            
            DAOR_ORDER_ITEMS.INSRECORD(RCORDERITEM);
            UT_TRACE.TRACE('FIN or_bolegalizeactivities.insertItemSeriado', 2);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END INSERTITEMSERIADO;

        






























































        PROCEDURE PROCESSELEMENTITEMS
        (
            ISBATTRIBUTE    IN GE_ATTRIBUTES.NAME_ATTRIBUTE%TYPE,
            INUITEMS        IN GE_ITEMS.ITEMS_ID%TYPE,
            INUELEMENTTYPE  IN IF_NODE.ELEMENT_TYPE_ID%TYPE,
            OSBATTRIBFORMAT OUT VARCHAR2
        )
        IS
            SBVALUE VARCHAR2(2000) := NULL;
            BLSERIALINSTALL BOOLEAN;

            NUCOMPONENTID MO_COMPONENT.COMPONENT_ID%TYPE;
            
            RFEQUIPCURSOR   CONSTANTS.TYREFCURSOR;
            
            NUTEMPPRODUCTID         PR_COMPONENT.PRODUCT_ID%TYPE;
            NUTEMPCLASSSERVICEID    PR_COMPONENT.CLASS_SERVICE_ID%TYPE;
            SBTEMPITEMDESCRIPTION   GE_ITEMS.DESCRIPTION%TYPE;
            SBTEMPSERVICENUMBER     ELMESESU.EMSSCOEM%TYPE;
            NUTEMPITEMTYPE          GE_ITEMS.ID_ITEMS_TIPO%TYPE;
            NUTEMPITEMGAMA          GE_ITEMS_GAMA_ITEM.ID_ITEMS_GAMA%TYPE;
            NUMAINCOMPID            MO_COMPONENT.COMPONENT_ID%TYPE;
            
            RCMOCOMPONENT           DAMO_COMPONENT.STYMO_COMPONENT;
        BEGIN
            
            UT_TRACE.TRACE(' or_bolegalizeactivities.processElementItems: '||ISBATTRIBUTE||'-'||INUITEMS,15);
            IF  ISBATTRIBUTE IS NOT NULL THEN
                IF GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(SBINSTANCE,NULL,OR_BOCONSTANTS.CSBACTIVITYENTITY,ISBATTRIBUTE, SBVALUE)
                THEN
                    GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,OR_BOCONSTANTS.CSBACTIVITYENTITY,ISBATTRIBUTE, SBVALUE);
                    UT_TRACE.TRACE('    ValorInstancia['||SBVALUE||']', 15);
                    UT_TRACE.TRACE('    Atributo de retiro['||OR_BOCONSTANTS.CSBSERIALITEMWITHDRAW||']', 15);
                    
                    
                    IF ISBATTRIBUTE IN (OR_BOCONSTANTS.CSBSERIALITEMINSTALL, OR_BOCONSTANTS.CSBSERIALITEMRECOVERY, OR_BOCONSTANTS.CSBSERIALITEMWITHDRAW) THEN

                        BLSERIALINSTALL := OR_BOCONSTANTS.CSBSERIALITEMINSTALL = ISBATTRIBUTE;
                        NUCOMPONENTID   := DAOR_ORDER_ACTIVITY.FNUGETCOMPONENT_ID(IRCORDERACTIVITY.NUORDERACTIVITY );

                            INSERTITEMSERIADO
                            (
                                INUORDER,
                                IRCORDERACTIVITY.NUORDERACTIVITY,
                                INUOPERATINGUNIT,
                                SBVALUE,
                                BLSERIALINSTALL,
                                NUCOMPONENTID,
                                IRCORDERACTIVITY.NUPRODUCTID,
                                ISBATTRIBUTE
                            );
                            
                    ELSIF ISBATTRIBUTE = GE_BCATTRIBUTES.CSBRETIRAR_UTILITIES THEN

                        GE_BOGENERALUTIL.CLOSE_REFCURSOR(RFEQUIPCURSOR);

                        
                        OR_BOLEGALIZEORDERREAD.GETORDERELEMENTDATA(IRCORDERACTIVITY.NUPRODUCTID, RFEQUIPCURSOR);
                       
                        FETCH RFEQUIPCURSOR INTO NUTEMPPRODUCTID, NUTEMPCLASSSERVICEID, SBTEMPITEMDESCRIPTION, SBTEMPSERVICENUMBER, NUTEMPITEMTYPE, NUTEMPITEMGAMA;

                        IF RFEQUIPCURSOR%NOTFOUND AND SBVALUE IS NULL THEN
                           ISBPROCESSREAD  := GE_BOCONSTANTS.CSBNO;
                        ELSE

                            BLSERIALINSTALL := OR_BOCONSTANTS.CSBSERIALITEMINSTALL = ISBATTRIBUTE;
                            NUCOMPONENTID   := DAOR_ORDER_ACTIVITY.FNUGETCOMPONENT_ID(IRCORDERACTIVITY.NUORDERACTIVITY );

                            INSERTITEMSERIADO
                            (
                                INUORDER,
                                IRCORDERACTIVITY.NUORDERACTIVITY,
                                INUOPERATINGUNIT,
                                SBVALUE,
                                BLSERIALINSTALL,
                                NUCOMPONENTID,
                                IRCORDERACTIVITY.NUPRODUCTID,
                                ISBATTRIBUTE
                            );
                       END IF;
                       
                       GE_BOGENERALUTIL.CLOSE_REFCURSOR(RFEQUIPCURSOR);
                            
                    ELSIF (ISBATTRIBUTE = OR_BOCONSTANTS.CSBSERIALITEMASSOCIATE) THEN
                        
                        ASSOCIATESERIALCOMPONENT(UPPER(SBVALUE));
                        
                    
                    
                    ELSIF (ISBATTRIBUTE = GE_BCATTRIBUTES.CSBASSOCIATESEAL) THEN
                        IF(SBVALUE IS NOT NULL) THEN
                            OR_BOINSTANCEACTIVITIES.SETEQUIPTOASSOC
                                (
                                    SBVALUE,
                                    NULL,
                                    GE_BCITEMSSERIADO.CSBASSOCSEAL,
                                    IRCORDERACTIVITY.NUORDERACTIVITY,
                                    NULL
                                );
                        END IF;

                    
                    
                    ELSIF (ISBATTRIBUTE = GE_BCATTRIBUTES.CSBDISSOCIATESEAL) THEN
                        IF(SBVALUE IS NOT NULL) THEN
                            OR_BOINSTANCEACTIVITIES.SETEQUIPTOASSOC
                                (
                                    SBVALUE,
                                    NULL,
                                    GE_BCITEMSSERIADO.CSBDISSOCSEAL,
                                    IRCORDERACTIVITY.NUORDERACTIVITY,
                                    NULL
                                );
                        END IF;
                            
                    
                    
                    ELSIF (ISBATTRIBUTE = GE_BCATTRIBUTES.CSBASSOCIATEEQUIPMENT) THEN
                        IF SBVALUE IS NOT NULL THEN
                            OR_BOINSTANCEACTIVITIES.SETEQUIPMENTFORASOC
                            (
                                IRCORDERACTIVITY.NUORDERACTIVITY,
                                UPPER(SBVALUE)
                            );
                        END IF;

                    
                    ELSIF ( ISBATTRIBUTE = GE_BCATTRIBUTES.CSBINSTALAR_UTILITIES) THEN
                        SBISUTILITIES := GE_BOCONSTANTS.CSBYES;

                        BLSERIALINSTALL := GE_BCATTRIBUTES.CSBINSTALAR_UTILITIES = ISBATTRIBUTE;
                        NUCOMPONENTID   := DAOR_ORDER_ACTIVITY.FNUGETCOMPONENT_ID(IRCORDERACTIVITY.NUORDERACTIVITY );
                        
                        
                        IF NUCOMPONENTID IS NOT NULL THEN
                            DAMO_COMPONENT.GETRECORD(NUCOMPONENTID,RCMOCOMPONENT);
                        END IF;
                        
                        
                        
                        

                        
                        
                        NUCOMPONENTID := MO_BOCOMPONENTUPDATE.FNUGETMEASUREELEMCOMP
                                         (
                                            DAOR_ORDER_ACTIVITY.FNUGETMOTIVE_ID(IRCORDERACTIVITY.NUORDERACTIVITY,0)
                                         );
                        
                        IF (NUCOMPONENTID IS NOT NULL) AND (NUCOMPONENTID||'a' <> RCMOCOMPONENT.COMPONENT_ID||'a') THEN
                            DAMO_COMPONENT.GETRECORD(NUCOMPONENTID,RCMOCOMPONENT);
                            
                            UT_TRACE.TRACE('nuPrComponentId '||NUPRCOMPONENTID, 2 );
                            NUPRCOMPONENTID := RCMOCOMPONENT.COMPONENT_ID_PROD;
                        END IF;
                        

                        
                        
                        GE_BOMEASUREMETHOD.VALEQUIPMENT
                            (
                                RCMOCOMPONENT.CLASS_SERVICE_ID,
                                INUOPERATINGUNIT,
                                UPPER(SBVALUE)
                            );
                            
                        INSERTITEMSERIADO
                            (
                                INUORDER,
                                IRCORDERACTIVITY.NUORDERACTIVITY,
                                INUOPERATINGUNIT,
                                SBVALUE,
                                BLSERIALINSTALL,
                                NUCOMPONENTID,
                                IRCORDERACTIVITY.NUPRODUCTID,
                                ISBATTRIBUTE
                            );
                            
                        
                        NUMAINCOMPID := MO_BCCOMPONENT.FNUGETMAINCOMPONENTID(DAOR_ORDER_ACTIVITY.FNUGETMOTIVE_ID(IRCORDERACTIVITY.NUORDERACTIVITY));
                        DAMO_COMPONENT.UPDSERVICE_DATE(NUMAINCOMPID,IDTEXEFINDAT);

                    END IF;
                    
                    
                    
                    IF (ISBATTRIBUTE IN
                            (
                                OR_BOCONSTANTS.CSBSERIALITEMINSTALL,
                                OR_BOCONSTANTS.CSBSERIALITEMRECOVERY,
                                OR_BOCONSTANTS.CSBSERIALITEMWITHDRAW,
                                GE_BCATTRIBUTES.CSBRETIRAR_UTILITIES,
                                GE_BCATTRIBUTES.CSBINSTALAR_UTILITIES
                                )
                        )THEN
                        ISBPROCESSEQUIP := GE_BOCONSTANTS.CSBYES;
                    END IF;
                    
                    IF (ISBATTRIBUTE = GE_BCATTRIBUTES.CSBRETIRAR_UTILITIES AND ISBPROCESSREAD = GE_BOCONSTANTS.CSBNO) THEN
                        ISBPROCESSEQUIP := GE_BOCONSTANTS.CSBNO;
                    END IF;

                    
                    OSBATTRIBFORMAT := ISBATTRIBUTE || CSBSEPARATOR_5 || SBVALUE || CSBSEPARATOR_5 || CSBSEPARATOR_5 ;
                    IF INUITEMS IS NOT NULL THEN
                        INSERTACTIVITYITEMS(
                                            INUORDER,IRCORDERACTIVITY.NUORDERACTIVITY,
                                            INUITEMS,INUELEMENTTYPE,SBVALUE
                                           );

                    OSBATTRIBFORMAT := ISBATTRIBUTE || CSBSEPARATOR_5 || SBVALUE || CSBSEPARATOR_5 || INUELEMENTTYPE || CSBSEPARATOR_5;
                    END IF;
                END IF;
            END IF;
            UT_TRACE.TRACE('FIN or_bolegalizeactivities.processElementItems ',15);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                GE_BOGENERALUTIL.CLOSE_REFCURSOR(RFEQUIPCURSOR);
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                GE_BOGENERALUTIL.CLOSE_REFCURSOR(RFEQUIPCURSOR);
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END PROCESSELEMENTITEMS;

        
        
        
        PROCEDURE PROCESSCOMPONENT
        (
            INUORDERACTIVITY    IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
            INUCOMPONENTGI      IN GE_ITEMS_ATTRIBUTES.COMPONENT_1_ID%TYPE,
            INUATTRIBUTE        IN NUMBER,
            ISBACTION           IN GE_ITEMS.USE_%TYPE ,
            ISBATTRIBVALUE      IN VARCHAR2,
            OBLVALIDATEREQ     OUT BOOLEAN
        )
        IS
            SBATTRIALL          VARCHAR2(2000);
            SBCOMPONENTDATA     VARCHAR2(2000);
        BEGIN

            UT_TRACE.TRACE( 'INICIO or_bolegalizeactivities.ProcessComponent',15);
            OBLVALIDATEREQ := TRUE;

            IF INUCOMPONENTGI IN (OR_BOCONSTANTS.CNUREADINGCOMPONENT, OR_BOCONSTANTS.CNUREADPRODUCTCOMPONENT,
                                OR_BOCONSTANTS.CNUASOCOFSEAL) THEN
                OBLVALIDATEREQ := FALSE;
            END IF;

            SBATTRIALL  :=  ISBATTRIBVALUE  || INUCOMPONENTGI || CSBSEPARATOR_5 || SBCOMPONENTDATA;

            IF ( SBATTRIALL = CSBSEPARATOR_5) THEN
                SBATTRIALL := NULL;
            END IF;

            IF INUATTRIBUTE = 1 THEN
                DAOR_ORDER_ACTIVITY.UPDVALUE1(INUORDERACTIVITY,SBATTRIALL);
            ELSIF INUATTRIBUTE = 2 THEN
                DAOR_ORDER_ACTIVITY.UPDVALUE2(INUORDERACTIVITY,SBATTRIALL);
            ELSIF INUATTRIBUTE = 3 THEN
                DAOR_ORDER_ACTIVITY.UPDVALUE3(INUORDERACTIVITY,SBATTRIALL);
            ELSIF INUATTRIBUTE = 4 THEN
                DAOR_ORDER_ACTIVITY.UPDVALUE4(INUORDERACTIVITY,SBATTRIALL);
            END IF;

            UT_TRACE.TRACE('FIN or_bolegalizeactivities.processComponent ',15);

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END PROCESSCOMPONENT;

        
        
        
        PROCEDURE VALIDATEREQUIREDFLAG
        (
            INUORDERACTIVITY        OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
            ISBREQUIREDATTRIBUTE    IN GE_ITEMS_ATTRIBUTES.REQUIRED1%TYPE,
            ISBATTRIBUTENAME        IN GE_ATTRIBUTES.NAME_ATTRIBUTE%TYPE,
            ISBATTRIBUTEDSPLY       IN GE_ATTRIBUTES.DISPLAY_NAME%TYPE,
            IBLVALIDATEREQ          IN BOOLEAN
        )
        IS
        BEGIN
            UT_TRACE.TRACE('INICIO or_bolegalizeactivities.validateRequiredFlag ',15);
            IF IBLVALIDATEREQ AND NVL(ISBREQUIREDATTRIBUTE,GE_BOCONSTANTS.GETNO)  = GE_BOCONSTANTS.GETYES THEN
                IF OR_BOINSTANCEACTIVITIES.FSBGETATTRIBUTEVALUE(ISBATTRIBUTENAME,INUORDERACTIVITY)
                    IS NULL THEN
                    GE_BOERRORS.SETERRORCODEARGUMENT(950,ISBATTRIBUTEDSPLY);
                END IF;
            END IF;
            UT_TRACE.TRACE('FIN or_bolegalizeactivities.validateRequiredFlag ',15);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END VALIDATEREQUIREDFLAG;

    BEGIN

        
        SBISUTILITIES := GE_BOCONSTANTS.CSBNO;

        
        SETCURRENTACTIVITYRECORD(IRCORDERACTIVITY);
        
        
        SBINSTANCE := CSBACTIVITYINSTANCE ||IRCORDERACTIVITY.NUORDERACTIVITY;

        UT_TRACE.TRACE('INICIO or_bolegalizeactivities.legalizeActivity 1: '||SBINSTANCE,15);
        
        PROCESSELEMENTITEMS(IRCACTIVITIESATTRIBCONF.SBATTRIBUTE1,IRCACTIVITIESATTRIBCONF.NUITEMS1,
                            IRCACTIVITIESATTRIBCONF.NUELEMENTTYPE1, SBATTRIBVALUE1);
        
        PROCESSELEMENTITEMS(IRCACTIVITIESATTRIBCONF.SBATTRIBUTE2,IRCACTIVITIESATTRIBCONF.NUITEMS2,
                            IRCACTIVITIESATTRIBCONF.NUELEMENTTYPE2, SBATTRIBVALUE2);
        
        PROCESSELEMENTITEMS(IRCACTIVITIESATTRIBCONF.SBATTRIBUTE3,IRCACTIVITIESATTRIBCONF.NUITEMS3,
                            IRCACTIVITIESATTRIBCONF.NUELEMENTTYPE3, SBATTRIBVALUE3);
        
        PROCESSELEMENTITEMS(IRCACTIVITIESATTRIBCONF.SBATTRIBUTE4,IRCACTIVITIESATTRIBCONF.NUITEMS4,
                            IRCACTIVITIESATTRIBCONF.NUELEMENTTYPE4, SBATTRIBVALUE4);

        
        OR_BCORDERITEMS.GETEQUIPMENTBYACTIVI(IRCORDERACTIVITY.NUORDERACTIVITY, TBEQUIPMENT);

        
        OR_BOORDERACTIVITIES.GETPRODINFO
            (
                IRCORDERACTIVITY.NUORDERACTIVITY,
                NUADDRESSID,
                NUSUBSCRIBERID,
                NUCOMPONENTTYPEID,
                NUCLASSSERVICEID,
                NUPRODUCTID,
                NUPRODUCTTYPEID,
                NUPRCOMPONENTID
            );


        
        GE_BOITEMSSERIADO.VALSEALOFEQUIP
            (
                INUORDER,
                IRCORDERACTIVITY.NUORDERACTIVITY,
                NUADDRESSID,
                NUSUBSCRIBERID,
                NUPRCOMPONENTID,
                NUCOMPONENTTYPEID,
                NUCLASSSERVICEID,
                NUPRODUCTID,
                NUPRODUCTTYPEID
            );
            
        
        PROCESSCOMPONENT(IRCORDERACTIVITY.NUORDERACTIVITY,IRCACTIVITIESATTRIBCONF.NUCOMPONENT1,1,IRCACTIVITIESATTRIBCONF.SBACTION1,SBATTRIBVALUE1,BLVALIDATEREQUIRED);
        VALIDATEREQUIREDFLAG
        (
            IRCORDERACTIVITY.NUORDERACTIVITY,IRCACTIVITIESATTRIBCONF.SBREQUIRED1,
            IRCACTIVITIESATTRIBCONF.SBATTRIBUTE1,IRCACTIVITIESATTRIBCONF.SBDISPLAYNAME1,
            BLVALIDATEREQUIRED
        );

        PROCESSCOMPONENT(IRCORDERACTIVITY.NUORDERACTIVITY,IRCACTIVITIESATTRIBCONF.NUCOMPONENT2,2,IRCACTIVITIESATTRIBCONF.SBACTION2,SBATTRIBVALUE2,BLVALIDATEREQUIRED);
        VALIDATEREQUIREDFLAG
        (
            IRCORDERACTIVITY.NUORDERACTIVITY,IRCACTIVITIESATTRIBCONF.SBREQUIRED2,
            IRCACTIVITIESATTRIBCONF.SBATTRIBUTE2,IRCACTIVITIESATTRIBCONF.SBDISPLAYNAME2,
            BLVALIDATEREQUIRED
        );

        PROCESSCOMPONENT(IRCORDERACTIVITY.NUORDERACTIVITY,IRCACTIVITIESATTRIBCONF.NUCOMPONENT3,3,IRCACTIVITIESATTRIBCONF.SBACTION3,SBATTRIBVALUE3,BLVALIDATEREQUIRED);
        VALIDATEREQUIREDFLAG
        (
            IRCORDERACTIVITY.NUORDERACTIVITY,IRCACTIVITIESATTRIBCONF.SBREQUIRED3,
            IRCACTIVITIESATTRIBCONF.SBATTRIBUTE3,IRCACTIVITIESATTRIBCONF.SBDISPLAYNAME3,
            BLVALIDATEREQUIRED
        );

        PROCESSCOMPONENT(IRCORDERACTIVITY.NUORDERACTIVITY,IRCACTIVITIESATTRIBCONF.NUCOMPONENT4,4,IRCACTIVITIESATTRIBCONF.SBACTION4,SBATTRIBVALUE4,BLVALIDATEREQUIRED);
        VALIDATEREQUIREDFLAG
        (
            IRCORDERACTIVITY.NUORDERACTIVITY,IRCACTIVITIESATTRIBCONF.SBREQUIRED4,
            IRCACTIVITIESATTRIBCONF.SBATTRIBUTE4,IRCACTIVITIESATTRIBCONF.SBDISPLAYNAME4,
            BLVALIDATEREQUIRED
        );

        
        IF  IRCACTIVITIESCONF.SBLEGALIZEOBJECT IS NOT NULL THEN
            UT_TRACE.TRACE('ExecuteObject=>'||IRCACTIVITIESCONF.SBLEGALIZEOBJECT);
            GE_BOOBJECT.EXECOBJECTBYNAME_IMMEDIATE(IRCACTIVITIESCONF.SBLEGALIZEOBJECT);
        END IF;

        
        PROCESSACTWARRANTY(INUORDER,IDTEXEFINDAT , IRCORDERACTIVITY, OTBACTIVITYITEMS);

        
        GE_BOITEMWARRANTY.PROCESSACTIVITYWARRANTY(INUORDER,IRCORDERACTIVITY);

        
        GE_BOITEMWARRANTY.PROCESSSERIEDWARRANTY(INUORDER,IRCORDERACTIVITY);

        ASSIGNNETELEMENTS(IRCORDERACTIVITY);

        
        IF (ISBPROCESSEQUIP = GE_BOCONSTANTS.CSBYES) THEN
            
            GE_BOITEMS.PROCESSEQUIPMENTITEM
                (
                    INUORDER,
                    IRCORDERACTIVITY.NUORDERACTIVITY,
                    IRCORDERACTIVITY.NUCOMPONENTID,
                    IRCORDERACTIVITY.NUPACKAGEID,
                    INUOPERATINGUNIT,
                    SBISUTILITIES,
                    NUPRCOMPONENTID,
                    NUADDRESSID,
                    NUSUBSCRIBERID,
                    NUCOMPONENTTYPEID,
                    NUCLASSSERVICEID,
                    NUPRODUCTID,
                    NUPRODUCTTYPEID
                );
        END IF;

        IF (ISBPROCESSREAD = GE_BOCONSTANTS.CSBYES) THEN

            
            PROCESSACTIVITYREAD(INUORDER,
                            IDTEXEFINDAT,
                            IRCORDERACTIVITY.NUORDERACTIVITY,
                            IRCORDERACTIVITY.NUACTIVITYID,
                            INUPERSONID,
                            IRCORDERACTIVITY.NUPRODUCTID,
                            IRCACTIVITIESATTRIBCONF
                            );
        END IF;
        
        
        
        
        INSERTSEALITEMS
        (
            INUORDER,
            IRCORDERACTIVITY.NUORDERACTIVITY
        );

        
        DAOR_ORDER_ACTIVITY.UPDSTATUS(IRCORDERACTIVITY.NUORDERACTIVITY,OR_BOORDERACTIVITIES.CSBFINISHSTATUS);
        
        CLEARACTIVITYRECORD;
        
        UT_TRACE.TRACE('FIN or_bolegalizeactivities.legalizeActivity',15);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END LEGALIZEACTIVITY;

    























    PROCEDURE ACTIVIDADESAREGENERA
    (
        INUIDACTIVIDAD          IN  GE_ITEMS.ITEMS_ID%TYPE,
        INUIDCAUSAL             IN  GE_CAUSAL.CAUSAL_ID%TYPE,
        INUCUMPLIDA             IN  OR_REGENERA_ACTIVIDA.CUMPLIDA%TYPE,
        INUINTENTOS             IN  OR_ORDER_ACTIVITY.LEGALIZE_TRY_TIMES%TYPE,
        OTBACTIVIDAREGEN        OUT OR_BCREGENERAACTIVID.TYTBACTIVIDADREGEN
    )
    IS
    BEGIN
        UT_TRACE.TRACE('INICIO Or_BOLegalizeActivities.ActividadesARegenera', 9);

        
        OR_BCREGENERAACTIVID.ACTIVIDADESAREGENERA
        (
            INUIDACTIVIDAD,
            INUIDCAUSAL,
            INUCUMPLIDA,
            INUINTENTOS,
            OTBACTIVIDAREGEN
        );

        UT_TRACE.TRACE('FIN Or_BOLegalizeActivities.ActividadesARegenera', 9);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END ACTIVIDADESAREGENERA;
    
    
















    PROCEDURE REPROGRAMORDERACTION
    (
        INUORDERID          IN  OR_ORDER.ORDER_ID%TYPE,
        INUTIEMPOESPERA     IN  OR_REGENERA_ACTIVIDA.TIEMPO_ESPERA%TYPE
    )
    IS
        RCORDER         DAOR_ORDER.STYOR_ORDER;
    BEGIN

        RCORDER := DAOR_ORDER.FRCGETRECORD(INUORDERID);

        IF(INUTIEMPOESPERA > 0) THEN
            
            RCORDER.ASSIGNED_DATE := TRUNC(GE_BCCALENDAR.FDTGETNNEXTDATENONHOLIDAY(UT_DATE.FDTSYSDATE, INUTIEMPOESPERA));
            
            
            OR_BOORDERTRANSITION.CHANGESTATUS(RCORDER, OR_BOCONSTANTS.CNUORDER_ACTION_ASSIGN, OR_BOCONSTANTS.CNUORDER_STAT_PLANNED, FALSE);
            
            OR_BOPROCESSORDER.UPDBASICDATA(RCORDER, NULL, NULL);
        ELSE
            RCORDER.ASSIGNED_DATE := NULL;
        END IF;

        DAOR_ORDER.UPDRECORD(RCORDER);
            
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END REPROGRAMORDERACTION;

    
















    PROCEDURE ASSIGNORDERACTION
    (
        INUORDERID          IN  OR_ORDER.ORDER_ID%TYPE,
        INUOPERUNITID       IN  OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        INUTIEMPOESPERA     IN  OR_REGENERA_ACTIVIDA.TIEMPO_ESPERA%TYPE
    )
    IS
        RCORDER         DAOR_ORDER.STYOR_ORDER;
    BEGIN
    
        RCORDER := DAOR_ORDER.FRCGETRECORD(INUORDERID);

        IF(INUTIEMPOESPERA > 0) THEN
            
            RCORDER.ASSIGNED_DATE := TRUNC(GE_BCCALENDAR.FDTGETNNEXTDATENONHOLIDAY(UT_DATE.FDTSYSDATE, INUTIEMPOESPERA));
            
            RCORDER.OPERATING_UNIT_ID := INUOPERUNITID;
            
            OR_BOORDERTRANSITION.CHANGESTATUS(RCORDER, OR_BOCONSTANTS.CNUORDER_ACTION_ASSIGN, OR_BOCONSTANTS.CNUORDER_STAT_PLANNED, FALSE);
            DAOR_ORDER.UPDRECORD(RCORDER);
        ELSE
            OR_BOPROCESSORDER.PROCESSORDER(RCORDER.ORDER_ID, NULL, INUOPERUNITID);
        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ASSIGNORDERACTION;

    





















    PROCEDURE EXECACTIONBYTRYLEGALIZATION
    (
        INUORDERID          IN  OR_ORDER.ORDER_ID%TYPE,
        INUOPERUNITID       IN  OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        INUACTION           IN  OR_REGENERA_ACTIVIDA.ACTION%TYPE,
        INUTIEMPOESPERA     IN  OR_REGENERA_ACTIVIDA.TIEMPO_ESPERA%TYPE
    )
    IS
    BEGIN

        UT_TRACE.TRACE('INICIA - or_bolegalizeactivities.ExecActionByTryLegalization',15);
        UT_TRACE.TRACE('inuOrderId['||INUORDERID||'] - inuOperUnitId['||INUOPERUNITID||'] - inuAction['||INUACTION||'] - inuTiempoEspera['||INUTIEMPOESPERA||']',15);

        
        
        IF(OR_BCORDERACTIVITIES.FNUGETCOUNTORDERACTIVITIES(INUORDERID)>1)THEN
            RETURN;
        END IF;

        IF(INUACTION = OR_BOCONSTANTS.CNUTOBLOCKORDER) THEN
            OR_BOLOCKORDER .LOCKORDER
            (
                INUORDERID,
                OR_BOCONSTANTS.CNUGENERALTYPE
            );
        ELSIF(INUACTION = OR_BOCONSTANTS.CNUAUTOASSIGNORDER)THEN
            ASSIGNORDERACTION
            (
                INUORDERID,
                INUOPERUNITID,
                INUTIEMPOESPERA
            );
        ELSE
            REPROGRAMORDERACTION
            (
                INUORDERID,
                INUTIEMPOESPERA
            );
        END IF;
        
        UT_TRACE.TRACE('FIN - or_bolegalizeactivities.ExecActionByTryLegalization',15);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END EXECACTIONBYTRYLEGALIZATION;

    


































































































    PROCEDURE FINALIZEACTIVITY
    (
        INUORDER                IN  OR_ORDER.ORDER_ID%TYPE,
        IRCORDERACTIVITY        IN OUT OR_BCORDERACTIVITIES.TYRCORDERACTIVITIES,
        INUREGENTASKTYPE        IN  OR_ORDER_ACTIVITY.TASK_TYPE_ID%TYPE,
        IONUORDERGROUP          IN  OUT OR_ORDER.ORDER_ID%TYPE,
        IDTEXEFINDAT            IN  OR_ORDER_ACTIVITY.FINAL_DATE%TYPE,
        INUCAUSALID             IN  GE_CAUSAL.CAUSAL_ID%TYPE,
        INUOPERUNITID           IN  OR_ORDER.OPERATING_UNIT_ID%TYPE,
        OSBTRASLATEACTIVITY     OUT VARCHAR2,
        OBLACTREGENERATED       OUT BOOLEAN
    )
    IS
        RCORDERACTIVITY         DAOR_ORDER_ACTIVITY.STYOR_ORDER_ACTIVITY;
        NUORDERACTIVITYREGEN    OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE;
        NUORDERREGEN            OR_ORDER.ORDER_ID%TYPE;
        NUREGENELEMENTID        OR_ORDER_ACTIVITY.ELEMENT_ID%TYPE;

        NUDIAGACTIVITY          GE_ITEMS.ITEMS_ID%TYPE;
        TBACTIVIDAREGEN         OR_BCREGENERAACTIVID.TYTBACTIVIDADREGEN;
        NUINSTANCEID            OR_ORDER_ACTIVITY.INSTANCE_ID%TYPE;
        NUORDERTEMPLATEID       OR_ORDER_ACTIVITY.ORDER_TEMPLATE_ID%TYPE;
        
        RCORDER                 DAOR_ORDER.STYOR_ORDER;
        NUINTENTOS              OR_ORDER_ACTIVITY.LEGALIZE_TRY_TIMES%TYPE;
        
    BEGIN
        UT_TRACE.TRACE('INICIO or_bolegalizeactivities.finalizeActivity', 8);

        OBLACTREGENERATED   := FALSE;
        OSBTRASLATEACTIVITY  := NVL(IRCORDERACTIVITY.SBTRASLATEACTIVITY, GE_BOCONSTANTS.CSBNO);

        
        ACTIVIDADESAREGENERA
        (
            IRCORDERACTIVITY.NUACTIVITYID,
            INUCAUSALID,
            IRCORDERACTIVITY.NUSTATUSLEGALIZE,
            IRCORDERACTIVITY.NUTRYLEGALIZETIMES,
            TBACTIVIDAREGEN
        );
        
        IRCORDERACTIVITY.BLREGENACTIVITY := FALSE;

        IF TBACTIVIDAREGEN.FIRST IS NOT NULL THEN
            FOR NUINDEX IN TBACTIVIDAREGEN.FIRST..TBACTIVIDAREGEN.LAST LOOP

                UT_TRACE.TRACE('RegenerandoActividad =>'||TBACTIVIDAREGEN(NUINDEX).ACTIVIDADREGENERAR, 9);
                OSBTRASLATEACTIVITY    := GE_BOCONSTANTS.CSBNO;
                NUORDERACTIVITYREGEN   := NULL;
                NUORDERREGEN           := NULL;
                
                NUINSTANCEID := NULL;
                
                IF (TBACTIVIDAREGEN(NUINDEX).ACTIVIDADREGENERAR IS NOT NULL) THEN
                    
                    IF (TBACTIVIDAREGEN(NUINDEX).ACTIVIDAD_WF = GE_BOCONSTANTS.CSBYES) THEN
                       NUINSTANCEID := IRCORDERACTIVITY.NUINSTANCEID;
                       
                       OBLACTREGENERATED := TRUE;
                    END IF;

                    NUREGENELEMENTID        := DAOR_ORDER_ACTIVITY.FNUGETELEMENT_ID(IRCORDERACTIVITY.NUORDERACTIVITY);
                    NUORDERTEMPLATEID       := DAOR_ORDER_ACTIVITY.FNUGETORDER_TEMPLATE_ID(IRCORDERACTIVITY.NUORDERACTIVITY);

                    
                    IF(DAGE_ITEMS.FSBGETUSE_(TBACTIVIDAREGEN(NUINDEX).ACTIVIDADREGENERAR) IN (OR_BOCONSTANTS.CSBDIAGNOSTICUSE,OR_BOCONSTANTS.CSBCLIENT_MAINTENA_USE)) THEN
                        
                        
                        NUDIAGACTIVITY  := TT_BCDIAGNOSTIC.FNUVALIDACREATACTDIAG(INUORDER);

                        IF( NUDIAGACTIVITY > 0 ) THEN
                            GE_BOERRORS.SETERRORCODEARGUMENT(CNUERR_CREATE_DIAG_ORDER, TO_CHAR(IRCORDERACTIVITY.NUPACKAGEID)||'|'||TO_CHAR(NUDIAGACTIVITY));
                        END IF;
                    END IF;

                    NUINTENTOS := NVL(IRCORDERACTIVITY.NUTRYLEGALIZETIMES,0) + 1;
                    UT_TRACE.TRACE('nuIntentos ['||NUINTENTOS||']',15);

                    UT_TRACE.TRACE('cburbano tbActividaRegen(nuIndex).intentos ['||TBACTIVIDAREGEN(NUINDEX).INTENTOS||']',15);
                    OR_BOORDERACTIVITIES.CREATEACTIVITY
                    (
                        TBACTIVIDAREGEN(NUINDEX).ACTIVIDADREGENERAR,
                        IRCORDERACTIVITY.NUPACKAGEID,
                        IRCORDERACTIVITY.NUMOTIVEID,
                        IRCORDERACTIVITY.NUCOMPONENTID,
                        NUINSTANCEID,
                        IRCORDERACTIVITY.NUADDRESSID,
                        NUREGENELEMENTID ,
                        IRCORDERACTIVITY.NUSUBSCRIBERID,
                        IRCORDERACTIVITY.NUSUBSCRIPTIONID,
                        IRCORDERACTIVITY.NUPRODUCTID,
                        NULL,
                        INUOPERUNITID,
                        IRCORDERACTIVITY.DTEXECSTIMATEDATE,
                        IRCORDERACTIVITY.NUPROCESSID,
                        IRCORDERACTIVITY.SBCOMMENT,
                        FALSE,
                        NULL,       
                        NUORDERREGEN,
                        NUORDERACTIVITYREGEN,
                        NUORDERTEMPLATEID,
                        GE_BOCONSTANTS.CSBNO,                                   
                        NULL,                                                   
                        NULL,                                                   
                        NULL,                                                   
                        NUINTENTOS,                                             
                        IRCORDERACTIVITY.SBTAGNAME,
                        TRUE,
                        DAOR_ORDER_ACTIVITY.FNUGETVALUE_REFERENCE(IRCORDERACTIVITY.NUORDERACTIVITY)
                    );

                    IF NUORDERACTIVITYREGEN IS NOT NULL THEN
                        DAOR_ORDER_ACTIVITY.UPDORIGIN_ACTIVITY_ID(NUORDERACTIVITYREGEN,IRCORDERACTIVITY.NUORDERACTIVITY);
                    END IF;
                    
                    
                    
                    IF NUORDERREGEN IS NOT NULL THEN
                        
                        IF ( OR_BORELATEDORDER.FSBEXISTRELATION(INUORDER,
                                                                NUORDERREGEN,
                                                                OR_BOCONSTANTS.CNURELATEDORD_REGENER)
                                                    != GE_BOCONSTANTS.CSBYES ) THEN
                            OR_BORELATEDORDER.RELATEORDERS( INUORDER,
                                                            NUORDERREGEN,
                                                            OR_BOCONSTANTS.CNURELATEDORD_REGENER
                                                          );
                        END IF;
                    END IF;

                    IF TBCREATEDORDERS.COUNT = 0 OR  NOT(TBCREATEDORDERS.EXISTS(NUORDERREGEN)) THEN
                        TBCREATEDORDERS(NUORDERREGEN) := NUORDERREGEN;
                        
                        GE_BONOTIFMESGALERT.PROCSTAORDERFORALERT( DAOR_ORDER.FRCGETRECORD(NUORDERREGEN), NULL);
                    END IF;

                    
                    IF NUORDERREGEN IS NOT NULL THEN

                        IF( NVL(TBACTIVIDAREGEN(NUINDEX).ACTION, 0) > 0)THEN
                            EXECACTIONBYTRYLEGALIZATION
                            (
                                NUORDERREGEN,                                   
                                INUOPERUNITID,                                  
                                TBACTIVIDAREGEN(NUINDEX).ACTION,                
                                NVL(TBACTIVIDAREGEN(NUINDEX).TIEMPO_ESPERA, 0)  
                            );
                        ELSE
                            RCORDER := DAOR_ORDER.FRCGETRECORD(NUORDERREGEN);
                            
                            OR_BOPROCESSORDER.UPDBASICDATA(RCORDER, NULL, NULL);
                        END IF;
                    END IF;
                    
                    IRCORDERACTIVITY.BLREGENACTIVITY := TRUE;
                END IF;
            END LOOP;
        END IF;

        IF OSBTRASLATEACTIVITY = GE_BOCONSTANTS.CSBYES THEN

            RCORDERACTIVITY.ORDER_ACTIVITY_ID   :=  IRCORDERACTIVITY.NUORDERACTIVITY;
            RCORDERACTIVITY.ORDER_ITEM_ID       :=  IRCORDERACTIVITY.NUORDERITEMID;
            RCORDERACTIVITY.PACKAGE_ID          :=  IRCORDERACTIVITY.NUPACKAGEID;
            RCORDERACTIVITY.MOTIVE_ID           :=  IRCORDERACTIVITY.NUMOTIVEID;
            RCORDERACTIVITY.COMPONENT_ID        :=  IRCORDERACTIVITY.NUCOMPONENTID;
            RCORDERACTIVITY.INSTANCE_ID         :=  IRCORDERACTIVITY.NUINSTANCEID;
            RCORDERACTIVITY.ADDRESS_ID          :=  IRCORDERACTIVITY.NUADDRESSID;
            RCORDERACTIVITY.ELEMENT_ID          :=  IRCORDERACTIVITY.NUELEMENTID;
            RCORDERACTIVITY.SUBSCRIBER_ID       :=  IRCORDERACTIVITY.NUSUBSCRIBERID;
            RCORDERACTIVITY.SUBSCRIPTION_ID     :=  IRCORDERACTIVITY.NUSUBSCRIPTIONID;
            RCORDERACTIVITY.PRODUCT_ID          :=  IRCORDERACTIVITY.NUPRODUCTID;
            RCORDERACTIVITY.PROCESS_ID          :=  IRCORDERACTIVITY.NUPROCESSID;
            RCORDERACTIVITY.ACTIVITY_ID         :=  IRCORDERACTIVITY.NUACTIVITYID;
            RCORDERACTIVITY.ACTIVITY_GROUP_ID   :=  IRCORDERACTIVITY.NUACTIVITYGROUPID;
            RCORDERACTIVITY.SEQUENCE_           :=  IRCORDERACTIVITY.NUACTIVITYSEQUENCE;
            RCORDERACTIVITY.ORIGIN_ACTIVITY_ID  :=  IRCORDERACTIVITY.NUORIGINACTIVITY;
            RCORDERACTIVITY.COMMENT_            :=  IRCORDERACTIVITY.SBCOMMENT;
            RCORDERACTIVITY.TASK_TYPE_ID        :=  IRCORDERACTIVITY.NUTASKTYPE;
            RCORDERACTIVITY.FINAL_DATE          :=  IDTEXEFINDAT;   
            NUORDERTEMPLATEID                   :=  DAOR_ORDER_ACTIVITY.FNUGETORDER_TEMPLATE_ID(IRCORDERACTIVITY.NUORDERACTIVITY);
            RCORDERACTIVITY.ORDER_TEMPLATE_ID   :=  NUORDERTEMPLATEID;
            RCORDERACTIVITY.WF_TAG_NAME         :=  IRCORDERACTIVITY.SBTAGNAME;
            RCORDERACTIVITY.VALUE_REFERENCE     :=  DAOR_ORDER_ACTIVITY.FNUGETVALUE_REFERENCE(IRCORDERACTIVITY.NUORDERACTIVITY);


            
            OR_BOORDERACTIVITIES.UPDATEACTIVITY( RCORDERACTIVITY, IRCORDERACTIVITY.NUACTIVITYID,IONUORDERGROUP);

            TBCREATEDORDERS(IONUORDERGROUP) := IONUORDERGROUP;
            
            
            
            IF ( OR_BORELATEDORDER.FSBEXISTRELATION(INUORDER,
                                                    IONUORDERGROUP,
                                                    OR_BOCONSTANTS.CNURELATEDORD_LEGALIZPART)
                                        != GE_BOCONSTANTS.CSBYES ) THEN
                OR_BORELATEDORDER.RELATEORDERS( INUORDER,
                                                IONUORDERGROUP,
                                                OR_BOCONSTANTS.CNURELATEDORD_LEGALIZPART
                                              );
            END IF;
        END IF;

        UT_TRACE.TRACE('FIN or_bolegalizeactivities.finalizeActivity',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FINALIZEACTIVITY;

    

































































































      PROCEDURE LEGALIZEORDER
    (
        INUORDER        IN  OR_ORDER.ORDER_ID%TYPE,
        INUPERSON       IN  GE_PERSON.PERSON_ID%TYPE,
        INUCAUSALID     IN  OR_ORDER.CAUSAL_ID%TYPE,
        IDTEXEINIDAT    IN  OR_ORDER.EXEC_INITIAL_DATE%TYPE,
        IDTEXEFINDAT    IN  OR_ORDER.EXECUTION_FINAL_DATE%TYPE,
        INUTASKTYPEID   IN  OR_ORDER.TASK_TYPE_ID%TYPE,
        IDTCHANGEDATE   IN OR_ORDER_STAT_CHANGE.STAT_CHG_DATE%TYPE DEFAULT NULL
    )
    IS
        TBACTIVITIESCONF        OR_BCORDERACTIVITIES.TYTBACTIVITIESCONF;
        TBORDERACTIVITIES       OR_BCORDERACTIVITIES.TYTBORDERACTIVITIES;
        TBNOTIFYWORKFLOW        DAOR_REGENERA_ACTIVIDA.TYTBACTIVIDAD_WF;


        RCACTIVITIESATTRIBCONF  OR_BCORDERACTIVITIES.TYRCACTIVITIESATTRIBCONF;
        RCRECORDNULL            OR_BCORDERACTIVITIES.TYRCACTIVITIESATTRIBCONF;
        NUCURRENTACTIVITY       GE_ITEMS.ITEMS_ID%TYPE := NULL;
        NUGENERATEORDER         OR_ORDER.ORDER_ID%TYPE;
        NUIDX                   NUMBER ;
        SBISACTGROUPFINISHED    VARCHAR2(1);
        NUOPERUNITID            OR_ORDER.OPERATING_UNIT_ID%TYPE;
        NUREGENTASKTYPE         OR_ORDER_ACTIVITY.TASK_TYPE_ID%TYPE;
        TBACTIVITYITEMS         OR_BCORDERACTIVITIES.TYTBACTIVITYITEMS;
        BLACTREGENERATED        BOOLEAN := FALSE;
        RCACTIVITY              DAOR_ACTIVIDAD.STYOR_ACTIVIDAD;
        SBTRASLATEACTIVITY      VARCHAR2(1) := GE_BOCONSTANTS.CSBNO;
        
        NUCONTRACTORID          GE_CONTRATO.ID_CONTRATISTA%TYPE;
        
        NUCONTRACTID            GE_CONTRATO.ID_CONTRATO%TYPE;
        
        NUPACKAGEID             MO_PACKAGES.PACKAGE_ID%TYPE;
        
        NULIQMETHOD             PS_PACKAGE_TYPE.LIQUIDATION_METHOD%TYPE;
        
        NUWFINDEX               NUMBER;
        SBORDERASSTYPE       OR_ORDER.ASSIGNED_WITH%TYPE;
        SBOPERUNITASSTYPE    OR_OPERATING_UNIT.ASSIGN_TYPE%TYPE;
        NUVALDAYS            NUMBER;
    BEGIN

        UT_TRACE.TRACE('Or_boLegalizeActivities.legalizeOrder['||INUORDER||']',15);

        TBCREATEDORDERS.DELETE;

        
        OR_BOSUPPORTORDER.VALNOTHASSUPPORTORDERNOTLEG(INUORDER);
        
        OR_BOFWLEGALIZEORDER.VALIDATEFINALDATE (IDTEXEINIDAT,IDTEXEFINDAT);

        
        IF (DAGE_PARAMETER.FBLEXIST('VALID_INIT_EXEC_DATE')) THEN
            NUVALDAYS := GE_BOPARAMETER.FNUGET('VALID_INIT_EXEC_DATE');
        END IF;
        IF (NUVALDAYS IS NOT NULL) THEN
            IF (IDTEXEINIDAT < UT_DATE.FDTSYSDATE - NUVALDAYS) THEN
                GE_BOERRORS.SETERRORCODEARGUMENT(CNUERR913132,IDTEXEINIDAT||'|'||NUVALDAYS);
            END IF;
        END IF;
        
        
        OR_BOORDERCOMMENT.EXISTLEGALIZECOMMENT(INUORDER, INUTASKTYPEID);
        
        OR_BCITEMS.PROCESSITEMINSERTED(INUORDER);

        
        OR_BOLEGALIZEORDER.INSERTPERSONINCHARGE(INUORDER, INUPERSON);

        
        IF IDTEXEINIDAT IS NOT NULL THEN
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(OR_BOINSTANCE.CSBORDER_INSTANCE,NULL,OR_BOINSTANCE.CSBORDER_ENTITY, OR_BOINSTANCE.CSBEXECINITIALDATE, UT_DATE.FSBSTR_DATE(IDTEXEINIDAT));
        END IF;

        IF IDTEXEFINDAT IS NOT NULL THEN
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(OR_BOINSTANCE.CSBORDER_INSTANCE,NULL,OR_BOINSTANCE.CSBORDER_ENTITY,OR_BOINSTANCE.CSBEXECFINALDATE,UT_DATE.FSBSTR_DATE(IDTEXEFINDAT));
        END IF;

        GE_BOINSTANCECONTROL.GETATTRIBUTEOLDVALUE(OR_BOINSTANCE.CSBORDER_INSTANCE,NULL,OR_BOINSTANCE.CSBORDER_ENTITY,'OPERATING_UNIT_ID',NUOPERUNITID);

        DAOR_ORDER.UPDEXEC_INITIAL_DATE(INUORDER, IDTEXEINIDAT);
        DAOR_ORDER.UPDEXECUTION_FINAL_DATE(INUORDER,IDTEXEFINDAT);
        DAOR_ORDER.UPDCAUSAL_ID(INUORDER,INUCAUSALID);

        
        OR_BCORDERACTIVITIES.GETCONFIG (TBACTIVITIESCONF);
        
        IF TBACTIVITIESATTRIBCONF.COUNT <= 0 THEN
            OR_BCORDERACTIVITIES.GETCONFIGATTRIBS(TBACTIVITIESATTRIBCONF);
        END IF ;
        
        
        
        SBORDERASSTYPE := DAOR_ORDER.FSBGETASSIGNED_WITH(INUORDER);
        
        SBOPERUNITASSTYPE := DAOR_OPERATING_UNIT.FSBGETASSIGN_TYPE(NUOPERUNITID);
        
        
        IF (SBORDERASSTYPE = OR_BCORDEROPERATINGUNIT.CSBASSIGN_CAPACITY AND
            SBOPERUNITASSTYPE = OR_BCORDEROPERATINGUNIT.CSBASSIGN_CAPACITY) THEN
            OR_BOOPERATINGUNIT.UPDATEUSEDCAPACITY(INUORDER, NUOPERUNITID);
        END IF;
        
        
        
        
        
        ANULACIONPARCIAL(INUORDER);
        
        OR_BCORDERACTIVITIES.GETACTIVITIESBYORDER(INUORDER,  TBORDERACTIVITIES, FALSE);
        
        VALIDATELEGALIZEACTIVITY(INUORDER,INUCAUSALID, TBORDERACTIVITIES);

        
        NUIDX := TBORDERACTIVITIES.FIRST;

        
        IF NUIDX IS NULL THEN
            GE_BOERRORS.SETERRORCODE(10861);
        END IF;

        WHILE NUIDX IS NOT NULL LOOP
            
            TBORDERACTIVITIES(NUIDX).NULEGALIZECOUNT := NVL(TBORDERACTIVITIES(NUIDX).NULEGALIZECOUNT, 0);
            
            
            TBNOTIFYWORKFLOW(NUIDX) := GE_BOCONSTANTS.CSBNO;
            
            RCACTIVITIESATTRIBCONF  := RCRECORDNULL;
            NUCURRENTACTIVITY := TBORDERACTIVITIES(NUIDX).NUACTIVITYID;
            TBORDERACTIVITIES(NUIDX).NUSTATUSLEGALIZE := GE_BOCONSTANTS.CNUFALSE;
            TBORDERACTIVITIES(NUIDX).SBTRASLATEACTIVITY := GE_BOCONSTANTS.CSBYES;

            
            IF TBACTIVITIESATTRIBCONF.EXISTS(NUCURRENTACTIVITY) THEN
                RCACTIVITIESATTRIBCONF :=  TBACTIVITIESATTRIBCONF(NUCURRENTACTIVITY);
            END IF;

            
            IF TBORDERACTIVITIES(NUIDX).SBISCOMPENSATE = GE_BOCONSTANTS.CSBYES THEN

                TBORDERACTIVITIES(NUIDX).NULEGALIZECOUNT := GE_BOCONSTANTS.CNUFALSE;
                TBORDERACTIVITIES(NUIDX).SBTRASLATEACTIVITY := GE_BOCONSTANTS.CSBNO;

                RCACTIVITY := DAOR_ACTIVIDAD.FRCGETRECORD( NUCURRENTACTIVITY );
                DAOR_ORDER_ACTIVITY.UPDSTATUS(TBORDERACTIVITIES(NUIDX).NUORDERACTIVITY,OR_BOCONSTANTS.CSBFINISHSTATUS);
                
                IF  RCACTIVITY.OBJETO_COMPENSACION IS NOT NULL THEN
                
                    
                    
                    SETCURRENTACTIVITYRECORD( TBORDERACTIVITIES( NUIDX ) );

                    
                    GE_BOOBJECT.EXECOBJECTBYNAME_IMMEDIATE( DAGE_OBJECT.FSBGETNAME_( RCACTIVITY.OBJETO_COMPENSACION ) );

                    
                    CLEARACTIVITYRECORD;
                
                END IF;

            END IF;
            
            IF TBORDERACTIVITIES(NUIDX).NULEGALIZECOUNT > GE_BOCONSTANTS.CNUFALSE THEN

                TBORDERACTIVITIES(NUIDX).NUSTATUSLEGALIZE := GE_BOCONSTANTS.CNUTRUE;
                TBORDERACTIVITIES(NUIDX).SBTRASLATEACTIVITY := GE_BOCONSTANTS.CSBNO;

                LEGALIZEACTIVITY(
                                INUORDER,
                                IDTEXEFINDAT,
                                TBORDERACTIVITIES(NUIDX),
                                TBACTIVITIESCONF(NUCURRENTACTIVITY),
                                RCACTIVITIESATTRIBCONF,
                                NUOPERUNITID,
                                INUPERSON,
                                TBACTIVITYITEMS
                                );
            ELSIF TBORDERACTIVITIES(NUIDX).NULEGALIZECOUNT = GE_BOCONSTANTS.CNUFALSE THEN
            
                
                
                IF (OR_BCORDERACTIVITIES.FSBVALHASSUPPORTACT(INUORDER, TBORDERACTIVITIES(NUIDX).NUORDERACTIVITY) = GE_BOCONSTANTS.CSBYES) THEN
                    GE_BOERRORS.SETERRORCODEARGUMENT(CNU901528, '['||TBORDERACTIVITIES(NUIDX).NUACTIVITYID||' -  '||DAGE_ITEMS.FSBGETDESCRIPTION(TBORDERACTIVITIES(NUIDX).NUACTIVITYID)||']');
                END IF;

                
                OR_BOPLANNINGACTIVIT.DELETEPLANNEDACTIVITY(TBORDERACTIVITIES(NUIDX).NUORDERACTIVITY);
            ELSE
                
                GE_BOERRORS.SETERRORCODEARGUMENT(119001,TBORDERACTIVITIES(NUIDX).NULEGALIZECOUNT );
            END IF;

            NUIDX := TBORDERACTIVITIES.NEXT(NUIDX);
        END LOOP;

        
        IF DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(INUCAUSALID) <> CNUSUCCESS_CLASS_CAUSAL
            AND TBORDERACTIVITIES.COUNT = 1
        THEN
            TBORDERACTIVITIES(TBORDERACTIVITIES.FIRST).SBTRASLATEACTIVITY := GE_BOCONSTANTS.CSBNO;
            DAOR_ORDER_ACTIVITY.UPDSTATUS(TBORDERACTIVITIES(TBORDERACTIVITIES.FIRST).NUORDERACTIVITY,OR_BOORDERACTIVITIES.CSBFINISHSTATUS);
        END IF;

        NUCONTRACTID := DAOR_ORDER.FNUGETDEFINED_CONTRACT_ID(INUORDER);
        


        
        
        IF (NUCONTRACTID IS NULL AND NVL(CNUCONTRACTOVERRUN,-1) < 0) THEN
            CT_BOCONTRACT.GETCONTRACTTOLIQORDER(INUORDER, NUCONTRACTORID, NUCONTRACTID);
			DAOR_ORDER.UPDDEFINED_CONTRACT_ID(INUORDER, NUCONTRACTID);
        ELSIF(NUCONTRACTID IS NOT NULL) THEN
            
            NUCONTRACTORID := DAGE_CONTRATO.FNUGETID_CONTRATISTA(NUCONTRACTID, 0);
        END IF;

        UT_TRACE.TRACE('inuOrder: '||INUORDER||'nuContractorId: '||NUCONTRACTORID||'. nuContractId: '||NUCONTRACTID, 2 );

        
        
        IF (NUCONTRACTID IS NULL AND NUCONTRACTORID IS NOT NULL) THEN
            
            OR_BOITEMVALUE.GETLIQMETHOD(INUORDER, NUPACKAGEID, NULIQMETHOD);
            IF(NULIQMETHOD = OR_BOCONSTANTS.CNUMETODO_DELEGATE_PRICE) THEN
                GE_BOERRORS.SETERRORCODE(CNUERR901477);
            END IF;
        END IF;



        
        DAOR_ORDER.UPDIS_PENDING_LIQ(INUORDER, GE_BOCONSTANTS.CSBYES);

        OR_BOLEGALIZEORDER.LEGALIZEORDERACTIVITIES(INUORDER, NUOPERUNITID,INUCAUSALID, TBACTIVITYITEMS, NUCONTRACTORID, NUCONTRACTID);

        NUIDX := NULL;
        NUIDX := TBORDERACTIVITIES.FIRST;
        
        WHILE NUIDX IS NOT NULL LOOP
            NUGENERATEORDER := NULL;
            FINALIZEACTIVITY
            (
                INUORDER,
                TBORDERACTIVITIES(NUIDX),
                NUREGENTASKTYPE,
                NUGENERATEORDER,
                IDTEXEFINDAT,
                INUCAUSALID,
                NUOPERUNITID,
                SBTRASLATEACTIVITY,
                BLACTREGENERATED
            );

            
            SBISACTGROUPFINISHED := GE_BOCONSTANTS.CSBYES;
            
            
            IF DAOR_ORDER_ACTIVITY.FNUGETORDER_ID(TBORDERACTIVITIES(NUIDX).NUORDERACTIVITY) = INUORDER THEN
               
               DAOR_ORDER_ACTIVITY.UPDSTATUS(TBORDERACTIVITIES(NUIDX).NUORDERACTIVITY,OR_BOCONSTANTS.CSBFINISHSTATUS);
            END IF;
            
            
            IF TBORDERACTIVITIES(NUIDX).NUACTIVITYGROUPID IS NOT NULL THEN
                UT_TRACE.TRACE('Group=>'||DAOR_ORDER_ACTIVITY.FNUGETACTIVITY_GROUP_ID(TBORDERACTIVITIES(NUIDX).NUORDERACTIVITY),15 );
                OR_BOPLANNINGACTIVIT.GENNEXTEXECUTION(TBORDERACTIVITIES(NUIDX).NUACTIVITYGROUPID,
                                                      TBORDERACTIVITIES(NUIDX).NUACTIVITYSEQUENCE,
                                                      SBISACTGROUPFINISHED);

                UT_TRACE.TRACE('sbIsActGroupFinished='||SBISACTGROUPFINISHED, 15);
            END IF;

            IF (TBORDERACTIVITIES(NUIDX).NUINSTANCEID IS NOT NULL AND BLACTREGENERATED  = FALSE) THEN
                UT_TRACE.TRACE('-- Notificar a workflow', 15);
                TBNOTIFYWORKFLOW(NUIDX) := GE_BOCONSTANTS.CSBYES;
                
                IF (SBISACTGROUPFINISHED = GE_BOCONSTANTS.GETYES)  THEN
                    TRYNOTIFYWFACTIVITY(INUORDER,TBORDERACTIVITIES(NUIDX).NUINSTANCEID,INUCAUSALID,TBORDERACTIVITIES, TBNOTIFYWORKFLOW);
                END IF;
            END IF;

            NUIDX := TBORDERACTIVITIES.NEXT(NUIDX);
        END LOOP;

        
        GENADMINACTIVITIES(INUORDER,NUOPERUNITID,INUTASKTYPEID,TBORDERACTIVITIES,INUCAUSALID);
        
        OR_BOEXTERNALLEGALIZE.PROCESSEXTERNALDATA(INUORDER,INUCAUSALID,IDTEXEFINDAT,TBORDERACTIVITIES);
        
        OR_BOLEGALIZEORDER.FINISHLEGALIZE(INUORDER,INUCAUSALID,IDTEXEINIDAT,IDTEXEFINDAT, TBACTIVITYITEMS,IDTCHANGEDATE);
        
        
        OR_BOORDERITEMS.UPDATEREMAININGITEMS;

        
        OR_BOINSTANCEACTIVITIES.CLEAREQUIPREAD();
        
        
        NUWFINDEX := GTBNOTIFYWFACTIVITY.FIRST;

        IF (NUWFINDEX IS NOT NULL) THEN
            
            WHILE NUWFINDEX IS NOT NULL  LOOP
                
                WF_BOANSWER_RECEPTOR.ANSWERRECEPTOR(NUWFINDEX, GTBNOTIFYWFACTIVITY(NUWFINDEX));
                
                NUWFINDEX := GTBNOTIFYWFACTIVITY.NEXT(NUWFINDEX);
            END LOOP;
            
            
            GTBNOTIFYWFACTIVITY.DELETE;
        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            
            OR_BOINSTANCEACTIVITIES.CLEAREQUIPREAD();
            
            GTBNOTIFYWFACTIVITY.DELETE;
            
            OR_BOORDERITEMS.CLEARQUOTATIONCACHE;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            
            OR_BOINSTANCEACTIVITIES.CLEAREQUIPREAD();
            
            GTBNOTIFYWFACTIVITY.DELETE;
            
            OR_BOORDERITEMS.CLEARQUOTATIONCACHE;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END LEGALIZEORDER;

    
    
    
    FUNCTION FNUGETCURRMOTIVE
    RETURN OR_ORDER_ACTIVITY.MOTIVE_ID%TYPE
    IS
    BEGIN
        RETURN GRCORDERACTIVITY.NUMOTIVEID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETCURRMOTIVE;

    
    
    
    FUNCTION FNUGETCURRCOMPONENT
    RETURN OR_ORDER_ACTIVITY.COMPONENT_ID%TYPE
    IS
    BEGIN
        RETURN GRCORDERACTIVITY.NUCOMPONENTID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETCURRCOMPONENT;

    
    
    
    FUNCTION FNUGETCURRPACKAGE
    RETURN OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE
    IS
    BEGIN
        RETURN GRCORDERACTIVITY.NUPACKAGEID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETCURRPACKAGE;

    
    
    
    FUNCTION FNUGETCURRACTIVITY
    RETURN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE
    IS
    BEGIN
        RETURN GRCORDERACTIVITY.NUORDERACTIVITY;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETCURRACTIVITY;

    
    
    
    FUNCTION FNUGETCURRPRODUCT
    RETURN OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE
    IS
    BEGIN
        RETURN GRCORDERACTIVITY.NUPRODUCTID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETCURRPRODUCT;

    
    
    
    FUNCTION FNUGETCURRWFINSTANCE
    RETURN OR_ORDER_ACTIVITY.INSTANCE_ID%TYPE
    IS
    BEGIN
        RETURN GRCORDERACTIVITY.NUINSTANCEID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETCURRWFINSTANCE;

    





























    PROCEDURE SETATTRIBSACTIVITY
    (
        INUORDERITEMSID         IN OR_ORDER_ITEMS.ORDER_ITEMS_ID%TYPE,
        INUITEMSID              IN OR_ORDER_ITEMS.ITEMS_ID%TYPE,
        INUORDERACTIVITY        IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        OCURFGETDATA            OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBINSTANCE      VARCHAR2(200) := NULL;
        SBCURRINSTANCE  VARCHAR2(200) := NULL;
        SBELEMENTCODE   IF_NODE.CODE%TYPE;

        NUORDERID       OR_ORDER.ORDER_ID%TYPE;
        SBINITVALUE1    VARCHAR2(200)   := NULL;
        SBINITVALUE2    VARCHAR2(200)   := NULL;
        SBINITVALUE3    VARCHAR2(200)   := NULL;
        SBINITVALUE4    VARCHAR2(200)   := NULL;

        SBPARSEDADDR    VARCHAR2(200)   := NULL;

        NUELEMENTID1    IF_NODE.ID%TYPE := NULL;
        NUELEMENTID2    IF_NODE.ID%TYPE := NULL;
        NUELEMENTID3    IF_NODE.ID%TYPE := NULL;
        NUELEMENTID4    IF_NODE.ID%TYPE := NULL;

        NUELEMENTTYPE1  IF_NODE.ELEMENT_TYPE_ID%TYPE := NULL;
        NUELEMENTTYPE2  IF_NODE.ELEMENT_TYPE_ID%TYPE := NULL;
        NUELEMENTTYPE3  IF_NODE.ELEMENT_TYPE_ID%TYPE := NULL;
        NUELEMENTTYPE4  IF_NODE.ELEMENT_TYPE_ID%TYPE := NULL;
        NUELEMENTCLASS1 IF_NODE.CLASS_ID%TYPE := NULL;
        NUELEMENTCLASS2 IF_NODE.CLASS_ID%TYPE := NULL;
        NUELEMENTCLASS3 IF_NODE.CLASS_ID%TYPE := NULL;
        NUELEMENTCLASS4 IF_NODE.CLASS_ID%TYPE := NULL;

        TBORDERACTIVITIES   OR_BCORDERACTIVITIES.TYTBORDERACTIVITIES;

        NUBSSERR            GE_MESSAGE.MESSAGE_ID%TYPE;
        SBBSSERR            GE_ERROR_LOG.DESCRIPTION%TYPE;
        NUROUTE             OR_ROUTE.ROUTE_ID%TYPE;
        NULOT               AB_PREMISE.CONSECUTIVE%TYPE;

        PROCEDURE INSTANCEATTRIB(SBATTRIBUTE IN GE_ATTRIBUTES.NAME_ATTRIBUTE%TYPE)
        IS
        BEGIN
            IF SBATTRIBUTE IS NULL THEN
                RETURN;
            END IF;
            UT_TRACE.TRACE('Attributo='||SBATTRIBUTE);
            GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCE, NULL, OR_BOCONSTANTS.CSBACTIVITYENTITY,SBATTRIBUTE,NULL,TRUE);
        END INSTANCEATTRIB;

    BEGIN
        UT_TRACE.TRACE('Or_BOLegalizeActivities.setAttribsActivity['||INUORDERITEMSID||']['||INUITEMSID||']',15);
        
        NUORDERID := OR_BOLEGALIZEORDER.FNUGETCURRENTORDER;
        
        OR_BCORDERACTIVITIES.GETACTIVITIESBYORDER(NUORDERID,  TBORDERACTIVITIES);
        
        SETCURRENTACTIVITYRECORD(TBORDERACTIVITIES(INUORDERACTIVITY));

        GRCORDERACTIVITY.NUORDERACTIVITY := INUORDERACTIVITY;
        
        IF TBACTIVITIESATTRIBCONF.COUNT <= 0 THEN
            OR_BCORDERACTIVITIES.GETCONFIGATTRIBS(TBACTIVITIESATTRIBCONF);
        END IF;

        SBINSTANCE := OR_BOLEGALIZEACTIVITIES.CSBACTIVITYINSTANCE||INUORDERACTIVITY;

        IF TBACTIVITIESATTRIBCONF.EXISTS(INUITEMSID) THEN

            UT_TRACE.TRACE('traceInstance    ge_items_attributes=>Configurado['||SBINSTANCE||']',15);

            
            INSTANCEATTRIB(TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE1);
            INSTANCEATTRIB(TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE2);
            INSTANCEATTRIB(TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE3);
            INSTANCEATTRIB(TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE4);

            
            
            GE_BOINSTANCECONTROL.SETCURRENTDATA(SBINSTANCE, NULL, OR_BOCONSTANTS.CSBACTIVITYENTITY,TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE1);
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUORDERACTIVITY, OR_BOCONSTANTS.CSBCURRPOSITIONATTR,'1');
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUORDERACTIVITY, OR_BOCONSTANTS.CSBCURRATTRIBUTEID,TBACTIVITIESATTRIBCONF(INUITEMSID).NUATTRIBUTE1);
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUORDERACTIVITY, OR_BOCONSTANTS.CSBCURRELEMENTACT,TBACTIVITIESATTRIBCONF(INUITEMSID).SBACTION1);
            GE_BOINSTANCECONTROL.EXECUTEEXPRESSION (TBACTIVITIESATTRIBCONF(INUITEMSID).NUINITEXPRESSION1);

            
            GE_BOINSTANCECONTROL.SETCURRENTDATA(SBINSTANCE, NULL, OR_BOCONSTANTS.CSBACTIVITYENTITY,TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE2);
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUORDERACTIVITY, OR_BOCONSTANTS.CSBCURRPOSITIONATTR,'2');
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUORDERACTIVITY, OR_BOCONSTANTS.CSBCURRATTRIBUTEID,TBACTIVITIESATTRIBCONF(INUITEMSID).NUATTRIBUTE2);
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUORDERACTIVITY, OR_BOCONSTANTS.CSBCURRELEMENTACT,TBACTIVITIESATTRIBCONF(INUITEMSID).SBACTION2);
            GE_BOINSTANCECONTROL.EXECUTEEXPRESSION (TBACTIVITIESATTRIBCONF(INUITEMSID).NUINITEXPRESSION2);

            
            GE_BOINSTANCECONTROL.SETCURRENTDATA(SBINSTANCE, NULL, OR_BOCONSTANTS.CSBACTIVITYENTITY,TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE3);
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUORDERACTIVITY, OR_BOCONSTANTS.CSBCURRPOSITIONATTR,'3');
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUORDERACTIVITY, OR_BOCONSTANTS.CSBCURRATTRIBUTEID,TBACTIVITIESATTRIBCONF(INUITEMSID).NUATTRIBUTE3);
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUORDERACTIVITY, OR_BOCONSTANTS.CSBCURRELEMENTACT,TBACTIVITIESATTRIBCONF(INUITEMSID).SBACTION3);
            GE_BOINSTANCECONTROL.EXECUTEEXPRESSION (TBACTIVITIESATTRIBCONF(INUITEMSID).NUINITEXPRESSION3);

            
            GE_BOINSTANCECONTROL.SETCURRENTDATA(SBINSTANCE, NULL, OR_BOCONSTANTS.CSBACTIVITYENTITY,TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE4);
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUORDERACTIVITY, OR_BOCONSTANTS.CSBCURRPOSITIONATTR,'4');
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUORDERACTIVITY, OR_BOCONSTANTS.CSBCURRATTRIBUTEID,TBACTIVITIESATTRIBCONF(INUITEMSID).NUATTRIBUTE4);
            OR_BOINSTANCEACTIVITIES.SETATTRIBUTE(INUORDERACTIVITY, OR_BOCONSTANTS.CSBCURRELEMENTACT,TBACTIVITIESATTRIBCONF(INUITEMSID).SBACTION4);
            GE_BOINSTANCECONTROL.EXECUTEEXPRESSION (TBACTIVITIESATTRIBCONF(INUITEMSID).NUINITEXPRESSION4);

            
            IF TBACTIVITIESATTRIBCONF(INUITEMSID).NUATTRIBUTE1 IS NOT NULL THEN
                GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,OR_BOCONSTANTS.CSBACTIVITYENTITY,TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE1, SBINITVALUE1);
                
                IF SBINITVALUE1 IS NOT NULL THEN
                    IF (TBACTIVITIESATTRIBCONF(INUITEMSID).NUCOMPONENT1 = OR_BOCONSTANTS.CNUREADINGCOMPONENT) OR
                        TBACTIVITIESATTRIBCONF(INUITEMSID).NUITEMS1 IS NOT NULL THEN

                        IF_BOELEMENT.GETELEMENTTYPECODECLASS(SBINITVALUE1,NUELEMENTTYPE1,SBELEMENTCODE,NUELEMENTCLASS1);
                        NUELEMENTID1 :=  SBINITVALUE1;
                        SBINITVALUE1 := SBELEMENTCODE;
                        GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,OR_BOCONSTANTS.CSBACTIVITYENTITY, TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE1, SBINITVALUE1);
                    ELSIF TBACTIVITIESATTRIBCONF(INUITEMSID).NUCOMPONENT1 = OR_BOCONSTANTS.CNUADDRESSCOMPONENT THEN
                        IF DAAB_ADDRESS.FBLEXIST(TO_NUMBER(SBINITVALUE1)) THEN
                            SBPARSEDADDR := SBINITVALUE1;
                            SBINITVALUE1 := DAAB_ADDRESS.FSBGETADDRESS_PARSED(TO_NUMBER(SBINITVALUE1));
                        END IF;
                    END IF;
                END IF;
            END IF;

            IF TBACTIVITIESATTRIBCONF(INUITEMSID).NUATTRIBUTE2 IS NOT NULL THEN
                GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,OR_BOCONSTANTS.CSBACTIVITYENTITY,TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE2, SBINITVALUE2);
                
                IF SBINITVALUE2 IS NOT NULL THEN
                    IF (TBACTIVITIESATTRIBCONF(INUITEMSID).NUCOMPONENT2 = OR_BOCONSTANTS.CNUREADINGCOMPONENT) OR
                        TBACTIVITIESATTRIBCONF(INUITEMSID).NUITEMS2 IS NOT NULL THEN

                        IF_BOELEMENT.GETELEMENTTYPECODECLASS(SBINITVALUE2,NUELEMENTTYPE2,SBELEMENTCODE,NUELEMENTCLASS2);
                        NUELEMENTID2 :=  SBINITVALUE2;
                        SBINITVALUE2 := SBELEMENTCODE;
                        GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,OR_BOCONSTANTS.CSBACTIVITYENTITY, TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE2, SBINITVALUE2);
                    ELSIF TBACTIVITIESATTRIBCONF(INUITEMSID).NUCOMPONENT2 = OR_BOCONSTANTS.CNUADDRESSCOMPONENT THEN
                        IF DAAB_ADDRESS.FBLEXIST(TO_NUMBER(SBINITVALUE2)) THEN
                            SBPARSEDADDR := SBINITVALUE2;
                            SBINITVALUE2 := DAAB_ADDRESS.FSBGETADDRESS_PARSED(TO_NUMBER(SBINITVALUE2));
                        END IF;
                    END IF;
                END IF;
            END IF;

            IF TBACTIVITIESATTRIBCONF(INUITEMSID).NUATTRIBUTE3 IS NOT NULL THEN
                GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,OR_BOCONSTANTS.CSBACTIVITYENTITY,TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE3, SBINITVALUE3);
                
                IF SBINITVALUE3 IS NOT NULL THEN
                    IF (TBACTIVITIESATTRIBCONF(INUITEMSID).NUCOMPONENT3 = OR_BOCONSTANTS.CNUREADINGCOMPONENT) OR
                        TBACTIVITIESATTRIBCONF(INUITEMSID).NUITEMS3 IS NOT NULL THEN

                        IF_BOELEMENT.GETELEMENTTYPECODECLASS(SBINITVALUE3,NUELEMENTTYPE3,SBELEMENTCODE,NUELEMENTCLASS3);
                        NUELEMENTID3 :=  SBINITVALUE3;
                        SBINITVALUE3 := SBELEMENTCODE;
                        GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,OR_BOCONSTANTS.CSBACTIVITYENTITY, TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE3, SBINITVALUE3);
                    ELSIF TBACTIVITIESATTRIBCONF(INUITEMSID).NUCOMPONENT3 = OR_BOCONSTANTS.CNUADDRESSCOMPONENT THEN
                        IF DAAB_ADDRESS.FBLEXIST(TO_NUMBER(SBINITVALUE3)) THEN
                            SBPARSEDADDR := SBINITVALUE3;
                            SBINITVALUE3 := DAAB_ADDRESS.FSBGETADDRESS_PARSED(TO_NUMBER(SBINITVALUE3));
                        END IF;
                    END IF;
                END IF;
            END IF;

            IF TBACTIVITIESATTRIBCONF(INUITEMSID).NUATTRIBUTE4 IS NOT NULL THEN
                GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,OR_BOCONSTANTS.CSBACTIVITYENTITY,TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE4, SBINITVALUE4);
                
                IF SBINITVALUE4 IS NOT NULL THEN
                    IF (TBACTIVITIESATTRIBCONF(INUITEMSID).NUCOMPONENT4 = OR_BOCONSTANTS.CNUREADINGCOMPONENT) OR
                        TBACTIVITIESATTRIBCONF(INUITEMSID).NUITEMS4 IS NOT NULL THEN

                        IF_BOELEMENT.GETELEMENTTYPECODECLASS(SBINITVALUE4,NUELEMENTTYPE4,SBELEMENTCODE,NUELEMENTCLASS4);
                        NUELEMENTID4 := SBINITVALUE4;
                        SBINITVALUE4 := SBELEMENTCODE;
                        GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,OR_BOCONSTANTS.CSBACTIVITYENTITY, TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE4, SBINITVALUE4);
                    ELSIF TBACTIVITIESATTRIBCONF(INUITEMSID).NUCOMPONENT4 = OR_BOCONSTANTS.CNUADDRESSCOMPONENT THEN
                        IF DAAB_ADDRESS.FBLEXIST(TO_NUMBER(SBINITVALUE4)) THEN
                            SBPARSEDADDR := SBINITVALUE4;
                            SBINITVALUE4 := DAAB_ADDRESS.FSBGETADDRESS_PARSED(TO_NUMBER(SBINITVALUE4));
                        END IF;
                    END IF;
                END IF;
            END IF;

            
            
            
            
            
            NUELEMENTTYPE1 := NVL(NUELEMENTTYPE1,TBACTIVITIESATTRIBCONF(INUITEMSID).NUELEMENTTYPE1);
            NUELEMENTTYPE2 := NVL(NUELEMENTTYPE2,TBACTIVITIESATTRIBCONF(INUITEMSID).NUELEMENTTYPE2);
            NUELEMENTTYPE3 := NVL(NUELEMENTTYPE3,TBACTIVITIESATTRIBCONF(INUITEMSID).NUELEMENTTYPE3);
            NUELEMENTTYPE4 := NVL(NUELEMENTTYPE4,TBACTIVITIESATTRIBCONF(INUITEMSID).NUELEMENTTYPE4);

            
            IF TBACTIVITIESATTRIBCONF(INUITEMSID).NUCOMPONENT1 = OR_BOCONSTANTS.CNUADDRESSCOMPONENT OR
               TBACTIVITIESATTRIBCONF(INUITEMSID).NUCOMPONENT2 = OR_BOCONSTANTS.CNUADDRESSCOMPONENT OR
               TBACTIVITIESATTRIBCONF(INUITEMSID).NUCOMPONENT3 = OR_BOCONSTANTS.CNUADDRESSCOMPONENT OR
               TBACTIVITIESATTRIBCONF(INUITEMSID).NUCOMPONENT4 = OR_BOCONSTANTS.CNUADDRESSCOMPONENT THEN

               IF SBPARSEDADDR IS NOT NULL THEN
                
                GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCE,NULL,OR_BOCONSTANTS.CSBACTIVITYENTITY, 'ORDER_PARSED_ADDRESS', SBPARSEDADDR, TRUE);
               END IF;

            END IF;

            OPEN OCURFGETDATA FOR
            SELECT  TBACTIVITIESATTRIBCONF(INUITEMSID).NUATTRIBUTE1     ATTRIBUTE1,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUATTRIBUTE2     ATTRIBUTE2,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUATTRIBUTE3     ATTRIBUTE3,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUATTRIBUTE4     ATTRIBUTE4,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE1     ATTRIBUTENAME1,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE2     ATTRIBUTENAME2,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE3     ATTRIBUTENAME3,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).SBATTRIBUTE4     ATTRIBUTENAME4,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).SBDISPLAYNAME1   DISPLAYNAME1,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).SBDISPLAYNAME2   DISPLAYNAME2,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).SBDISPLAYNAME3   DISPLAYNAME3,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).SBDISPLAYNAME4   DISPLAYNAME4,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUCOMPONENT1     COMPONENT1,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUCOMPONENT2     COMPONENT2,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUCOMPONENT3     COMPONENT3,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUCOMPONENT4     COMPONENT4,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUVALIDEXPRESSION1 VALIDEXPRESSION1,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUVALIDEXPRESSION2 VALIDEXPRESSION2,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUVALIDEXPRESSION3 VALIDEXPRESSION3,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUVALIDEXPRESSION4 VALIDEXPRESSION4,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUSTATEMENT1     STATEMENT1,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUSTATEMENT2     STATEMENT2,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUSTATEMENT3     STATEMENT3,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUSTATEMENT4     STATEMENT4,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUITEMS1         ITEMS1,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUITEMS2         ITEMS2,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUITEMS3         ITEMS3,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).NUITEMS4         ITEMS4,
                    SBINITVALUE1    INITVALUE1,     SBINITVALUE2        INITVALUE2,
                    SBINITVALUE3    INITVALUE3,     SBINITVALUE4        INITVALUE4,
                    NUELEMENTID1    ELEMENT1,       NUELEMENTID2        ELEMENT2,
                    NUELEMENTID3    ELEMENT3,       NUELEMENTID4        ELEMENT4,
                    NUELEMENTTYPE1  ELEMENTTYPE1,   NUELEMENTTYPE2      ELEMENTTYPE2,
                    NUELEMENTTYPE3  ELEMENTTYPE3,   NUELEMENTTYPE4      ELEMENTTYPE4,
                    NUELEMENTCLASS1 ELEMENTCLASS1,  NUELEMENTCLASS2     ELEMENTCLASS2,
                    NUELEMENTCLASS3 ELEMENTCLASS3,  NUELEMENTCLASS4     ELEMENTCLASS4,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).SBACTION1        ACTION1,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).SBACTION2        ACTION2,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).SBACTION3        ACTION3,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).SBACTION4        ACTION4,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).SBREQUIRED1      REQUIRED1,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).SBREQUIRED2      REQUIRED2,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).SBREQUIRED3      REQUIRED3,
                    TBACTIVITIESATTRIBCONF(INUITEMSID).SBREQUIRED4      REQUIRED4
                FROM DUAL;
        ELSE
            
            OPEN OCURFGETDATA FOR
            SELECT  * FROM DUAL WHERE ROWNUM <1;
            
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(OCURFGETDATA);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(OCURFGETDATA);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETATTRIBSACTIVITY;

    
    
    
    PROCEDURE EXECVALEXPRESSION
    (
        INUORDER            IN OR_ORDER.ORDER_ID%TYPE,
        INUORDERACTIVITY    IN OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE,
        INUEXPRESSIONID     IN GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%TYPE,
        ISBATTRIBUTE        IN VARCHAR2,
        ISBVALUE            IN VARCHAR2
    )
    IS

    BEGIN
        IF INUEXPRESSIONID IS NULL THEN
            RETURN;
        END IF;
        
        IF NOT GTBORDERACTIVITIES.EXISTS(INUORDERACTIVITY) THEN
            OR_BCORDERACTIVITIES.GETACTIVITIESBYORDER(INUORDER,  GTBORDERACTIVITIES);
        END IF;
        
        SETCURRENTACTIVITYRECORD(GTBORDERACTIVITIES(INUORDERACTIVITY));
        
        GE_BOINSTANCE.SETINSTANCE(ISBATTRIBUTE,ISBVALUE);
        
        GE_BOINSTANCECONTROL.EXECUTEEXPRESSION (INUEXPRESSIONID);
        
        CLEARACTIVITYRECORD;

    END EXECVALEXPRESSION;


    PROCEDURE SETATTRIBUTENEWVALUE
    (
        INUORDER            IN OR_ORDER.ORDER_ID%TYPE,
        INUORDERACTIVITY    IN OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE,
        ISBATTRIBUTE        IN VARCHAR2,
        ISBVALUE            IN VARCHAR2
    )
    IS
        SBINSTANCE VARCHAR2(200) := NULL;
        SBACTION        VARCHAR2(1);
    BEGIN
        UT_TRACE.TRACE('[Or_BOLegalizeActivities.setAttributeNewValue] INICIO',2);
        SBINSTANCE := OR_BOLEGALIZEACTIVITIES.CSBACTIVITYINSTANCE||INUORDERACTIVITY;
        UT_TRACE.TRACE('sbInstance:'||SBINSTANCE||']Atrib['||ISBATTRIBUTE||']value: '||ISBVALUE);
        
        
        GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCE,NULL,OR_BOCONSTANTS.CSBACTIVITYENTITY,ISBATTRIBUTE,ISBVALUE, TRUE);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETATTRIBUTENEWVALUE;

    PROCEDURE GETATTRIBUTEVALUE
    (
        INUORDER            IN OR_ORDER.ORDER_ID%TYPE,
        INUORDERACTIVITY    IN OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE,
        ISBATTRIBUTE        IN VARCHAR2,
        OSBVALUE            OUT VARCHAR2
    )
    IS
        SBINSTANCE VARCHAR2(200) := NULL;
        SBACTION        VARCHAR2(1);
    BEGIN
        UT_TRACE.TRACE('[Or_BOLegalizeActivities.getAttributeValue] INICIO',2);
        SBINSTANCE := OR_BOLEGALIZEACTIVITIES.CSBACTIVITYINSTANCE||INUORDERACTIVITY;
        UT_TRACE.TRACE('sbInstance:'||SBINSTANCE||']Atrib['||ISBATTRIBUTE||']value: '||OSBVALUE);

        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,OR_BOCONSTANTS.CSBACTIVITYENTITY,ISBATTRIBUTE,OSBVALUE);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETATTRIBUTEVALUE;

    
    
    
    PROCEDURE GETORDERITEMS
    (
        INUORDERID      IN OR_ORDER.ORDER_ID%TYPE,
        INUTASKTYPEID   IN OR_ORDER.TASK_TYPE_ID%TYPE,
        OCURFORDER      OUT CONSTANTS.TYREFCURSOR
    ) IS
    BEGIN
        UT_TRACE.TRACE('[OR_BOFWLegalizeOrder.GetOrderItems] INICIO',2);
        OCURFORDER := OR_BCLEGALIZEITEMS.FRFGETORDERITEMS(INUORDERID, INUTASKTYPEID);
        UT_TRACE.TRACE('[OR_BOFWLegalizeOrder.GetOrderItems] FIN',2);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(OCURFORDER);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(OCURFORDER);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETORDERITEMS;

        













    PROCEDURE GETLABORDERITEMS
    (
        INUORDERID      IN OR_ORDER.ORDER_ID%TYPE,
        INUTASKTYPEID   IN OR_ORDER.TASK_TYPE_ID%TYPE,
        OCURFORDER      OUT CONSTANTS.TYREFCURSOR
    ) IS
    BEGIN
        UT_TRACE.TRACE('[OR_BOLegalizeActivities.GetLabOrderItems] INICIO',2);
        OCURFORDER := OR_BCLEGALIZEITEMS.FRFGETLABORDERITEMS(INUORDERID, INUTASKTYPEID);

        UT_TRACE.TRACE('[OR_BOLegalizeActivities.GetLabOrderItems] FIN',2);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF OCURFORDER%ISOPEN THEN CLOSE OCURFORDER; END IF;
            RAISE;
        WHEN OTHERS THEN
            IF OCURFORDER%ISOPEN THEN CLOSE OCURFORDER; END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETLABORDERITEMS;
    
    
    
    PROCEDURE GETACTIVITYDESC
    (
        INUORDERACTIVITY        IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUITEMSID              IN OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE,
        OCURFGETDATA            OUT CONSTANTS.TYREFCURSOR
    ) IS
        SBDESCRIPTION VARCHAR2(200) := NULL;
    BEGIN

        SBDESCRIPTION := OR_BOBASICDATASERVICES.FSBGETACTIVITYDESC(INUORDERACTIVITY);
        OPEN OCURFGETDATA FOR
        SELECT  INUITEMSID  ID,
                SBDESCRIPTION DESCRIPTION
            FROM DUAL;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(OCURFGETDATA);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(OCURFGETDATA);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETACTIVITYDESC;


    
    
    
    PROCEDURE GETCOMPONENTDATA
    (
        INUCURRENTACTIVITY  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUCOMPONENTGI      IN  NUMBER,
        INUATTRIBUTE        IN  NUMBER,
        OCURFGETDATA        OUT CONSTANTS.TYREFCURSOR
    )
    IS
        OTBATTRIBUTES   OR_BCORDERACTIVITIES.TYTBACTIVITYITEMS;
        NUINDEX         NUMBER ;
        SBSELECT        VARCHAR2(10000);
        SBUNION         VARCHAR2(10) := ' UNION  ';
        SBLOCATION      VARCHAR2(200);

        SBELEMENTCODE   OR_ORDER_ITEMS.ELEMENT_CODE%TYPE;
        NUELEMENTID     OR_ORDER_ITEMS.ELEMENT_ID%TYPE;
        NUELEMENTTYPE   GE_ITEMS.ELEMENT_TYPE_ID%TYPE;
    BEGIN
        UT_TRACE.TRACE('Or_BOLegalizeActivities.getComponentData',15);
        UT_TRACE.TRACE('inuCurrentActivity='||INUCURRENTACTIVITY,15);
        UT_TRACE.TRACE('inuComponentGI='||INUCURRENTACTIVITY,15);
        UT_TRACE.TRACE('inuAttribute='||INUATTRIBUTE,15);
        OR_BOINSTANCEACTIVITIES.GETCOMPONENTDATA(INUCURRENTACTIVITY,INUCOMPONENTGI,INUATTRIBUTE,OTBATTRIBUTES);
        NUINDEX :=  OTBATTRIBUTES.FIRST;

        SBSELECT  := 'SELECT null ElementCode,null ElementType,null ElementId, null Location, -1 seq FROM DUAL  WHERE ROWNUM < 1';
        WHILE NUINDEX IS NOT NULL LOOP

            SBELEMENTCODE := OTBATTRIBUTES(NUINDEX).SBELEMENTCODE;
            NUELEMENTTYPE := OTBATTRIBUTES(NUINDEX).NUELEMENTTYPEID;
            NUELEMENTID   := OTBATTRIBUTES(NUINDEX).NUELEMENTID;
            SBLOCATION    := OTBATTRIBUTES(NUINDEX).SBADDDATA;

            IF NUELEMENTID IS NOT NULL THEN
                SBSELECT := SBSELECT||SBUNION;
                SBSELECT := SBSELECT||'SELECT  '''||SBELEMENTCODE||''' ElementCode, ';
                SBSELECT := SBSELECT||NUELEMENTTYPE||' ElementType, ';
                SBSELECT := SBSELECT||NUELEMENTID||' ElementId, ' ;
                SBSELECT := SBSELECT||''''||SBLOCATION||''' Location, '||NUINDEX||' seq FROM DUAL  ';
            END IF;
            NUINDEX :=  OTBATTRIBUTES.NEXT(NUINDEX);
        END LOOP;

        SBSELECT := 'SELECT * FROM ( '||SBSELECT||' ) ORDER BY seq ';
        UT_TRACE.TRACE('Sentencia='||SBSELECT,15);
        OPEN OCURFGETDATA FOR SBSELECT;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(OCURFGETDATA);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(OCURFGETDATA);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCOMPONENTDATA;


    












    PROCEDURE GETITEMSBYACTIVITY
    (
        INUACTIVITYID   IN  OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE,
        ORFQUERY        OUT CONSTANTS.TYREFCURSOR
    ) IS
    BEGIN
        ORFQUERY := OR_BCLEGALIZEITEMS.FRCITEMSBYACTIVITY(INUACTIVITYID);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(ORFQUERY);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(ORFQUERY);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETITEMSBYACTIVITY;


    
















    FUNCTION FNUGETELEMLOCATION
    (
        INUELEMENTID    IN OR_ORDER_ITEMS.ELEMENT_ID%TYPE
    ) RETURN NUMBER
    IS
    
        NUCURRENTACTIVITY   NUMBER;
        NULOCATION          NUMBER;

    BEGIN

        NUCURRENTACTIVITY := OR_BOLEGALIZEACTIVITIES.FNUGETCURRACTIVITY;
        NULOCATION := NULL;

        IF NUCURRENTACTIVITY IS NOT NULL THEN
            NULOCATION := OR_BOINSTANCEACTIVITIES.FSBGETATTRIBUTEVALUE('UBICACION',NUCURRENTACTIVITY);
        END IF;

        RETURN NULOCATION;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETELEMLOCATION;

    
    
    
    PROCEDURE VALLOCATIONPARAM
    (
        INUELEMENTTYPE      IN GE_ITEMS.ELEMENT_TYPE_ID%TYPE,
        ISBLOCATIONACTIVE   OUT VARCHAR2,
        ISBSTATEMENT        OUT GE_STATEMENT.STATEMENT_ID%TYPE
    )
    IS
        CNULOCATIONPARAM CONSTANT NUMBER := 1023;
    BEGIN
        ISBLOCATIONACTIVE := GE_BOCONSTANTS.CSBNO;
        ISBSTATEMENT := NULL;
        IF DAIF_ELEMENT_PARAM.FBLEXIST(INUELEMENTTYPE, CNULOCATIONPARAM) THEN
            UT_TRACE.TRACE('UbicacionActiva=>');
           ISBSTATEMENT := DAIF_ELEMENT_PARAM.FSBGETVALUE(INUELEMENTTYPE, CNULOCATIONPARAM);
           ISBLOCATIONACTIVE := GE_BOCONSTANTS.CSBYES;
        END IF;
        UT_TRACE.TRACE('Or_BOLegalizeActivities.valLocationParam: ['||ISBLOCATIONACTIVE||']Statement=>'||ISBSTATEMENT);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALLOCATIONPARAM;
    
    
    
    PROCEDURE ISMEASUREELEMENT
    (
        INUELEMENTTYPE  IN GE_ITEMS.ELEMENT_TYPE_ID%TYPE,
        ISBMEASURE      OUT VARCHAR2
    )
    IS
    BEGIN
        ISBMEASURE := GE_BOCONSTANTS.CSBYES;
        IF INUELEMENTTYPE IS NOT NULL THEN
            ISBMEASURE := DAIF_ELEMENT_TYPE.FSBGETIS_MEASURABLE(INUELEMENTTYPE);
        END IF;
        UT_TRACE.TRACE('Or_BOLegalizeActivities.isMeasureElement: ['||ISBMEASURE||']');
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ISMEASUREELEMENT;

    FUNCTION FSBGETCREATEDORDERS
    RETURN VARCHAR2
    IS
        NUINDEX     BINARY_INTEGER;
        SBORDERS    GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
    BEGIN

        SBORDERS    := '';
        NUINDEX     := TBCREATEDORDERS.FIRST;

        WHILE NUINDEX IS NOT NULL
        LOOP
            SBORDERS    := SBORDERS||','||TBCREATEDORDERS(NUINDEX);
            NUINDEX     := TBCREATEDORDERS.NEXT(NUINDEX);
        END LOOP;

        SBORDERS    :=  SUBSTR(SBORDERS, 2);
        UT_TRACE.TRACE('Or_BOLegalizeActivities.GetCreatedOrders: ',15);
        
		RETURN SBORDERS;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBGETCREATEDORDERS;

     























     PROCEDURE DELLEGALIZEACTIVITY
    (
        INUORDERACTIVITY    IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUORDERITEMSID     IN OR_ORDER_ACTIVITY.ORDER_ITEM_ID%TYPE
    )
    IS
        CNUERROR10861 CONSTANT NUMBER := 10861;
        NUORDERID   OR_ORDER_ACTIVITY.ORDER_ID%TYPE;
        SBCURRENTINSTANCE VARCHAR2(100) := NULL;
        PRAGMA AUTONOMOUS_TRANSACTION;
        TBORDERACTIVITIES OR_BCORDERACTIVITIES.TYTBORDERACTIVITIES;
    BEGIN
        UT_TRACE.TRACE('Or_BOLegalizeActivities.delLegalizeActivity: ['||INUORDERACTIVITY||']');

        NUORDERID := DAOR_ORDER_ACTIVITY.FNUGETORDER_ID(INUORDERACTIVITY);
        
        OR_BCORDERACTIVITIES.GETACTIVITIESBYORDER(NUORDERID,TBORDERACTIVITIES,FALSE);

        IF TBORDERACTIVITIES.COUNT > 1 THEN
        
                SBCURRENTINSTANCE :=OR_BOLEGALIZEACTIVITIES.CSBACTIVITYINSTANCE||INUORDERACTIVITY;
                GE_BOINSTANCECONTROL.DESTROYINSTANCE(SBCURRENTINSTANCE);

                
                DAOR_ORDER_ACTIVITY.DELRECORD(INUORDERACTIVITY);
                DAOR_ORDER_ITEMS.DELRECORD(INUORDERITEMSID);

                UT_TRACE.TRACE('FIN Or_BOLegalizeActivities.delLegalizeActivity');
                COMMIT;
        ELSE
            ERRORS.SETERROR(CNUERROR10861);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END DELLEGALIZEACTIVITY;

    
    
    
    PROCEDURE CRLEGALIZEACTIVITY
    (
        INUITEMSID      IN  OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE,
        INUORDERID      IN  OR_ORDER_ACTIVITY.ORDER_ID%TYPE,
        INUTASKTYPE     IN  OR_ORDER_ACTIVITY.TASK_TYPE_ID%TYPE,
        INUOPERUNIT     IN  OR_ORDER_ACTIVITY.OPERATING_UNIT_ID%TYPE,
        INUOPERSECT     IN  OR_ORDER_ACTIVITY.OPERATING_SECTOR_ID%TYPE,
        ONUACTIVITYID   OUT OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        ONUORDERITEM    OUT OR_ORDER_ACTIVITY.ORDER_ITEM_ID%TYPE
    )
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;

        RCORDERACTIVITY    DAOR_ORDER_ACTIVITY.STYOR_ORDER_ACTIVITY;
        NUORDERID OR_ORDER.ORDER_ID%TYPE;

        SBCURRENTINSTANCE VARCHAR2(100) := NULL;

    BEGIN
        ONUACTIVITYID   := -1;
        ONUORDERITEM    := NULL;

        IF DAGE_ITEMS.FNUGETITEM_CLASSIF_ID(INUITEMSID) = OR_BOORDERACTIVITIES.CNUACTIVITYTYPE THEN
            ONUACTIVITYID   := NULL;

            NUORDERID := INUORDERID;

            RCORDERACTIVITY.ACTIVITY_ID         :=  INUITEMSID;
            RCORDERACTIVITY.ORDER_ID            :=  INUORDERID;
            RCORDERACTIVITY.TASK_TYPE_ID        :=  INUTASKTYPE;
            RCORDERACTIVITY.OPERATING_UNIT_ID   :=  INUOPERUNIT;
            RCORDERACTIVITY.OPERATING_SECTOR_ID :=  INUOPERSECT;
            RCORDERACTIVITY.STATUS :=  OR_BOORDERACTIVITIES.CSBASSIGNEDSTATUS;

            RCORDERACTIVITY.ORDER_ACTIVITY_ID   := OR_BOSEQUENCES.FNUNEXTOR_ORDER_ACTIVITY;

            ONUACTIVITYID := RCORDERACTIVITY.ORDER_ACTIVITY_ID;

            DAOR_ORDER_ACTIVITY.INSRECORD(RCORDERACTIVITY);

            OR_BOORDERACTIVITIES.UPDATEACTIVITY(RCORDERACTIVITY,INUITEMSID,NUORDERID);

            ONUORDERITEM := DAOR_ORDER_ACTIVITY.FNUGETORDER_ITEM_ID(ONUACTIVITYID);

            
            SBCURRENTINSTANCE :=OR_BOLEGALIZEACTIVITIES.CSBACTIVITYINSTANCE||ONUACTIVITYID;

            GE_BOINSTANCECONTROL.CREATEINSTANCE
            (
                SBCURRENTINSTANCE,
                CSBFWINSTANCENAME
            );

            GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBCURRENTINSTANCE,NULL, 'OR_ORDER_ACTIVITY', 'ORDER_ITEM_ID',ONUORDERITEM);
            COMMIT;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CRLEGALIZEACTIVITY;


    






























    PROCEDURE ANULACIONPARCIAL
    (
        INUORDERID      IN OR_ORDER_ACTIVITY.ORDER_ID%TYPE
    )
    IS
        NUINDEX                 BINARY_INTEGER;


        TYTBACTIVITY            OR_BCORDERACTIVITIES.TYTBORDERACTIVITIES;

    BEGIN
        
        
        OR_BCORDERACTIVITIES.ACTIVIANULADASORDEN(INUORDERID, TYTBACTIVITY);

         
        NUINDEX := TYTBACTIVITY.FIRST;
        WHILE NUINDEX IS NOT NULL
        LOOP

            DAOR_ORDER_ACTIVITY.UPDFINAL_DATE(TYTBACTIVITY(NUINDEX).NUORDERACTIVITY,UT_DATE.FDTSYSDATE());
            DAOR_ORDER_ACTIVITY.UPDSTATUS(TYTBACTIVITY(NUINDEX).NUORDERACTIVITY,OR_BOCONSTANTS.CSBFINISHSTATUS);



            NUINDEX := TYTBACTIVITY.NEXT(NUINDEX);
        END LOOP;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ANULACIONPARCIAL;

    




    PROCEDURE CREARACTIVIDADAPOYO
    (
        INUORDERID          IN OR_ORDER_ACTIVITY.ORDER_ID%TYPE,
        INUOPERUNITID       IN  OR_ORDER.OPERATING_UNIT_ID%TYPE,
        INUORDERACTIVITYID  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUACTIVITYID       IN  OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE,
        INUACTIVIDADAPOYO   IN  OR_SUPPORT_ACTIVITY.SUPPORT_ACTIVITY_ID%TYPE,
        ONUORDERACTAPOYOID  IN  OUT OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        ONUORDERITEMID      OUT OR_ORDER_ACTIVITY.ORDER_ITEM_ID%TYPE
    )
    IS

        SBCURRENTINSTANCE   VARCHAR2(100) := NULL;

        NUACTIVITYID        OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE;
        NUORDERID           OR_ORDER_ACTIVITY.ORDER_ID%TYPE;

    BEGIN
        NUORDERID := INUORDERID;
        NUACTIVITYID := INUACTIVITYID ;
        IF NUACTIVITYID IS NULL THEN
            NUACTIVITYID := DAOR_ORDER_ACTIVITY.FNUGETACTIVITY_ID(INUORDERACTIVITYID);
        END IF;

        
        DAOR_SUPPORT_ACTIVITY.ACCKEY(NUACTIVITYID, INUACTIVIDADAPOYO);

        
        OR_BOCREATEACTSUPPORT.CREATEACTIVITSUPPORT(
                                            INUORDERACTIVITYID,
                                            INUACTIVIDADAPOYO,
                                            INUOPERUNITID,
                                            1,
                                            NUORDERID,
                                            CNUPROCESSACTAPOYO,
                                            ONUORDERACTAPOYOID,
                                            ONUORDERITEMID
                                            );

        
        OR_BOITEMS.INSERTORUPDATEITEMSTEMPTABLE(NUORDERID,
                                                INUACTIVIDADAPOYO,
                                                1,
                                                OR_BCLEGALIZEITEMS.FSBISOUT(DAOR_ORDER.FNUGETTASK_TYPE_ID(NUORDERID)),
                                                ONUORDERITEMID
                                                );
        
        SBCURRENTINSTANCE :=OR_BOLEGALIZEACTIVITIES.CSBACTIVITYINSTANCE||ONUORDERACTAPOYOID;

        GE_BOINSTANCECONTROL.CREATEINSTANCE
        (
            SBCURRENTINSTANCE,
            CSBFWINSTANCENAME
        );
        GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBCURRENTINSTANCE,NULL, 'OR_ORDER_ACTIVITY', 'ORDER_ITEM_ID',ONUORDERITEMID);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CREARACTIVIDADAPOYO;

    






    PROCEDURE CRACTIVIDADAPOYO
    (
        INUORDERID          IN OR_ORDER_ACTIVITY.ORDER_ID%TYPE,
        INUOPERUNITID       IN  OR_ORDER.OPERATING_UNIT_ID%TYPE,
        INUORDERACTIVITYID  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUACTIVITYID       IN  OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE,
        INUACTIVIDADAPOYO   IN  OR_SUPPORT_ACTIVITY.SUPPORT_ACTIVITY_ID%TYPE,
        ONUORDERACTAPOYOID  IN  OUT OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        ONUORDERITEMID      OUT OR_ORDER_ACTIVITY.ORDER_ITEM_ID%TYPE
    )
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        OR_BOORDERACTIVITIES.SBUPDATEORDER := GE_BOCONSTANTS.CSBNO;
        
        CREARACTIVIDADAPOYO
        (
            INUORDERID,
            INUOPERUNITID,
            INUORDERACTIVITYID,
            INUACTIVITYID,
            INUACTIVIDADAPOYO,
            ONUORDERACTAPOYOID,
            ONUORDERITEMID
        );

        OR_BOORDERACTIVITIES.SBUPDATEORDER := GE_BOCONSTANTS.CSBYES;
        
        COMMIT;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CRACTIVIDADAPOYO;

    





















    PROCEDURE GENADMINACTIVITIES
    (
        INUORDER            IN OR_ORDER.ORDER_ID%TYPE,
        INUOPERUNITID       IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        INUTASKTYPEID       IN OR_ORDER.TASK_TYPE_ID%TYPE,
        ITBORDERACTIVITIES  IN OR_BCORDERACTIVITIES.TYTBORDERACTIVITIES,
        INUCAUSAL           IN OR_ORDER.CAUSAL_ID%TYPE
     )
    IS
        NUADMINBASEID       GE_BASE_ADMINISTRA.ID_BASE_ADMINISTRA%TYPE;
        RCORDERACTIVITIES   OR_BCORDERACTIVITIES.TYRCORDERACTIVITIES;
        TBADMINACTIVITIES   OR_BCREGENERAACTIVID.TYTBACTIVIDADREGEN;
        RCADMINACTIVITIES   OR_BCREGENERAACTIVID.STYACTIVIDADREGEN;
        TBFINALADMINACT     OR_BCREGENERAACTIVID.TYTBACTIVIDADREGEN;
        RCFINALADMINACT     OR_BCREGENERAACTIVID.STYACTIVIDADREGEN;
        NUFINALINDEX        NUMBER;
        NUINDEX             NUMBER;
        NUINDEX2            NUMBER;
    BEGIN
        UT_TRACE.TRACE('INICIO Or_BOLegalizeActivities.genAdminActivities',5);
        NUADMINBASEID := DAOR_OPERATING_UNIT.FNUGETADMIN_BASE_ID(INUOPERUNITID);
        
        IF DAOR_TASK_TYPE.FSBGETGEN_ADMIN_ORDER(INUTASKTYPEID) = GE_BOCONSTANTS.CSBNO
           OR DAOR_OPERATING_UNIT.FSBGETGEN_ADMIN_ORDER(INUOPERUNITID) = GE_BOCONSTANTS.CSBNO
           OR DAGE_BASE_ADMINISTRA.FSBGETGEN_ADMIN_ORDER(NUADMINBASEID) = GE_BOCONSTANTS.CSBNO THEN
            RETURN;
        END IF;

        
        IF ITBORDERACTIVITIES.COUNT > 0 THEN
            NUINDEX := ITBORDERACTIVITIES.FIRST;
            WHILE NUINDEX IS NOT NULL LOOP
                RCORDERACTIVITIES := ITBORDERACTIVITIES(NUINDEX);
                OR_BCREGENERAACTIVID.ACTIVIDADESADMIN(RCORDERACTIVITIES.NUACTIVITYID,
                                                      INUCAUSAL,
                                                      OR_BOCONSTANTS.CNUORDER_STAT_CLOSED,
                                                      RCORDERACTIVITIES.NULEGALIZECOUNT,
                                                      TBADMINACTIVITIES);
                
                IF TBADMINACTIVITIES.COUNT > 0 THEN
                    NUINDEX2 := TBADMINACTIVITIES.FIRST;
                    WHILE NUINDEX2 IS NOT NULL LOOP
                        RCADMINACTIVITIES := TBADMINACTIVITIES(NUINDEX2);
                        NUFINALINDEX := RCADMINACTIVITIES.ACTIVIDADREGENERAR;
                        IF TBFINALADMINACT.EXISTS(NUFINALINDEX) THEN
                            IF TBFINALADMINACT(NUFINALINDEX).TIEMPO_ESPERA > RCADMINACTIVITIES.TIEMPO_ESPERA THEN
                                TBFINALADMINACT(NUFINALINDEX).TIEMPO_ESPERA := RCADMINACTIVITIES.TIEMPO_ESPERA;
                            END IF;
                        ELSE
                            TBFINALADMINACT(NUFINALINDEX).ACTIVIDADREGENERAR := RCADMINACTIVITIES.ACTIVIDADREGENERAR;
                            TBFINALADMINACT(NUFINALINDEX).TIEMPO_ESPERA := RCADMINACTIVITIES.TIEMPO_ESPERA;
                        END IF;
                        NUINDEX2 := TBADMINACTIVITIES.NEXT(NUINDEX2);
                    END LOOP;
                END IF;
                NUINDEX := ITBORDERACTIVITIES.NEXT(NUINDEX);
            END LOOP;
        END IF;

        
        IF TBFINALADMINACT.COUNT > 0 THEN
            NUFINALINDEX := TBFINALADMINACT.FIRST;
            WHILE NUFINALINDEX IS NOT NULL LOOP
                RCFINALADMINACT := TBFINALADMINACT(NUFINALINDEX);
                OR_BOADMINORDER.CREATEORDERJOB(RCFINALADMINACT.ACTIVIDADREGENERAR,INUORDER,INUOPERUNITID,
                                               RCFINALADMINACT.TIEMPO_ESPERA);
                NUFINALINDEX := TBFINALADMINACT.NEXT(NUFINALINDEX);
            END LOOP;
        END IF;

        UT_TRACE.TRACE('FIN Or_BOLegalizeActivities.genAdminActivities',5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    













    PROCEDURE GETVISIBLEITEMSBYACTIVITY
    (
        INUACTIVITYID   IN  OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE,
        ORFQUERY        OUT CONSTANTS.TYREFCURSOR
    ) IS
    BEGIN
        ORFQUERY := OR_BCLEGALIZEITEMS.FRCVISIBLEITEMSBYACTIVITY(INUACTIVITYID);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(ORFQUERY);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(ORFQUERY);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETVISIBLEITEMSBYACTIVITY;

    





























    PROCEDURE EXCHANGEEQUIPMENT
    (
        INUORDERID          IN  OR_ORDER.ORDER_ID%TYPE,
        INUCOMPONENTID      IN  PR_COMPONENT.COMPONENT_ID%TYPE,
        INUMOCOMPONENTID    IN  OR_ORDER_ACTIVITY.COMPONENT_ID%TYPE,
        INUCOMPONENTTYPEID  IN  PS_COMPONENT_TYPE.COMPONENT_TYPE_ID%TYPE,
        INUITEMSERREC       IN  GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%TYPE,
        INUITEMSERINS       IN  GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%TYPE,
        ISBISUTILITIES      IN  GE_BOITEMS.STYLETTER
    )
    IS
        RCITEMSERREC            DAGE_ITEMS_SERIADO.STYGE_ITEMS_SERIADO;
        RCITEMSERINS            DAGE_ITEMS_SERIADO.STYGE_ITEMS_SERIADO;
        NUITEMSGAMAREC          GE_ITEMS_GAMA.ID_ITEMS_GAMA%TYPE;
        NUITEMSGAMAINS          GE_ITEMS_GAMA.ID_ITEMS_GAMA%TYPE;
        NUITEMSSHAREDREC        GE_ITEMS.SHARED%TYPE;
        NUITEMSSHAREDINS        GE_ITEMS.SHARED%TYPE;
        TBITEMSCAPACITYREC      DAGE_ITEM_SERIADO_CAP.TYTBGE_ITEM_SERIADO_CAP;
        TBITEMSCAPACITYINS      DAGE_ITEM_SERIADO_CAP.TYTBGE_ITEM_SERIADO_CAP;
        RCITEMSERIADOCAP        DAGE_ITEM_SERIADO_CAP.STYGE_ITEM_SERIADO_CAP;
        TBIDCAPACITYREC         DAGE_ITEM_SERIADO_CAP.TYTBITEM_SERIADO_CAP_ID;

        
        CNUSTAT_NOT_VALID       CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 143787;
        
        CNUERR_DIF_GAMAS        CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE :=  16462;
        
        CNUNOT_SHARED           CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 17982;
        
        
        CNUNOT_CAPACITY         CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 18004;

        NUINDEX                 BINARY_INTEGER;
        NUINDEX2                BINARY_INTEGER;
        NUIDX                   BINARY_INTEGER;
        BLMATCH                 BOOLEAN;
        SBMOVETYPE              OR_UNI_ITEM_BALA_MOV.MOVEMENT_TYPE%TYPE;
        NUUNIITEMMOVID          OR_UNI_ITEM_BALA_MOV.UNI_ITEM_BALA_MOV_ID%TYPE;
        RFREFCURSOR             CONSTANTS.TYREFCURSOR;
        TBCOMPONENTSREC         DAPR_COMPONENT.TYTBPR_COMPONENT;

        
        PROCEDURE UPDCOMPONENTNCAPACITY
        (
            ITBCOMPONENTS       IN OUT  DAPR_COMPONENT.TYTBPR_COMPONENT,
            INUITEMSERIADO      IN      GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%TYPE,
            ISBSERIE            IN      GE_ITEMS_SERIADO.SERIE%TYPE
        )
        IS
            TYPE TYRCCOMPONENT IS RECORD
            (
                TBROWID         DAPR_COMPONENT.TYTBROWID,
                PRODUCT_TYPE_ID DAPR_PRODUCT.TYTBPRODUCT_TYPE_ID
            );
            RCRECORDOFTABLES    TYRCCOMPONENT;
        BEGIN
            UT_TRACE.TRACE('-- [INICIO] Or_BOLegalizeActivities.UpdComponentNCapacity ', 13);
            
            

            NUIDX := ITBCOMPONENTS.FIRST;
            LOOP
                EXIT WHEN NUIDX IS NULL;
                RCRECORDOFTABLES.TBROWID(NUIDX) := ITBCOMPONENTS(NUIDX).ROWID;
                RCRECORDOFTABLES.PRODUCT_TYPE_ID(NUIDX) :=
                DAPR_PRODUCT.FNUGETPRODUCT_TYPE_ID(ITBCOMPONENTS(NUIDX).PRODUCT_ID);
                NUIDX := ITBCOMPONENTS.NEXT(NUIDX);
            END LOOP;

            IF (ISBISUTILITIES = GE_BOCONSTANTS.CSBNO) THEN
            FORALL NUINDEX IN ITBCOMPONENTS.FIRST..ITBCOMPONENTS.LAST
                UPDATE  PR_COMPONENT
                SET     SERVICE_NUMBER = ISBSERIE
                WHERE   ROWID = RCRECORDOFTABLES.TBROWID(NUINDEX);
            END IF;

            FORALL NUINDEX IN ITBCOMPONENTS.FIRST..ITBCOMPONENTS.LAST
                UPDATE  GE_ITEM_SERIADO_CAP
                SET     CAPACITY_OCCUPIED = CAPACITY_OCCUPIED + 1
                WHERE   ID_ITEMS_SERIADO = INUITEMSERIADO
                AND     PRODUCT_TYPE_ID =  RCRECORDOFTABLES.PRODUCT_TYPE_ID(NUINDEX);

            UT_TRACE.TRACE('-- [FIN] Or_BOLegalizeActivities.UpdComponentNCapacity ', 13);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END;

    BEGIN
        UT_TRACE.TRACE('-- [INICIO] Or_BOLegalizeActivities.exchangeEquipment ' ||
            'inuOrderId:        [' || TO_CHAR(INUORDERID)       || '] - ' ||
            'inuComponentId:    [' || TO_CHAR(INUCOMPONENTID)   || '] - ' ||
            'inuItemSerRec:     [' || TO_CHAR(INUITEMSERREC)    || '] - ' ||
            'inuItemSerIns:     [' || TO_CHAR(INUITEMSERINS)    || '] - ' ||
            'isbISUtilities:    [' || ISBISUTILITIES            || ']', 2);

        
        DAGE_ITEMS_SERIADO.GETRECORD(INUITEMSERREC, RCITEMSERREC);
        DAGE_ITEMS_SERIADO.GETRECORD(INUITEMSERINS, RCITEMSERINS);

        
        IF (RCITEMSERINS.ID_ITEMS_ESTADO_INV != GE_BOITEMSCONSTANTS.CNUSTATUS_DISPONIBLE) THEN
            ERRORS.SETERROR (
                CNUSTAT_NOT_VALID,
                RCITEMSERINS.ID_ITEMS_ESTADO_INV || ' - '||
                DAGE_ITEMS_ESTADO_INV.FSBGETDESCRIPCION(RCITEMSERINS.ID_ITEMS_ESTADO_INV)
                || '|' || RCITEMSERINS.SERIE
            );
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        


        IF (ISBISUTILITIES = GE_BOCONSTANTS.CSBNO) THEN

        
            NUITEMSGAMAREC := GE_BCITEMS_GAMA_ITEM.FNUOBTENERITEMGAMA(RCITEMSERREC.ITEMS_ID);
            NUITEMSGAMAINS := GE_BCITEMS_GAMA_ITEM.FNUOBTENERITEMGAMA(RCITEMSERINS.ITEMS_ID);
            UT_TRACE.TRACE('--[1] nuItemsGamaRec: [' || TO_CHAR(NUITEMSGAMAREC)
                || '] - ' || 'nuItemsGamaIns: [' || TO_CHAR(NUITEMSGAMAINS) || ']', 12);
            IF ( NUITEMSGAMAREC != NUITEMSGAMAINS ) THEN
                ERRORS.SETERROR (
                    CNUERR_DIF_GAMAS,
                    NUITEMSGAMAREC || '|' || RCITEMSERREC.SERIE || '|' ||
                    NUITEMSGAMAINS || '|' || ''
                );
                RAISE EX.CONTROLLED_ERROR;
            END IF;
        END IF;

        
        NUITEMSSHAREDREC := NVL(DAGE_ITEMS.FSBGETSHARED(RCITEMSERREC.ITEMS_ID, 0), GE_BOCONSTANTS.CSBNO );
        NUITEMSSHAREDINS := NVL(DAGE_ITEMS.FSBGETSHARED(RCITEMSERINS.ITEMS_ID, 0), GE_BOCONSTANTS.CSBNO );
        IF ( NUITEMSSHAREDREC <> NUITEMSSHAREDINS ) THEN
            ERRORS.SETERROR(CNUNOT_SHARED);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        
        IF ( NUITEMSSHAREDREC = GE_BOCONSTANTS.CSBYES  ) THEN
            UT_TRACE.TRACE('--[2] Procesando �tem compartido ['||TO_CHAR(INUITEMSERREC)||']', 12);
            
            TBITEMSCAPACITYREC := GE_BCITEMCAPACITY.FTBGETCAPSSERBYITEM(INUITEMSERREC, NULL);
            TBITEMSCAPACITYINS := GE_BCITEMCAPACITY.FTBGETCAPSSERBYITEM(INUITEMSERINS, NULL);

            
            NUINDEX := TBITEMSCAPACITYREC.FIRST;
            LOOP
                EXIT WHEN NUINDEX IS NULL;
                
                IF ( TBITEMSCAPACITYREC(NUINDEX).CAPACITY_OCCUPIED > 0 ) THEN
                    
                    NUINDEX2    := TBITEMSCAPACITYINS.FIRST;
                    BLMATCH     := FALSE;

                    
                    LOOP
                        EXIT WHEN NUINDEX2 IS NULL;
                        
                        IF ( TBITEMSCAPACITYREC(NUINDEX).PRODUCT_TYPE_ID =
                            TBITEMSCAPACITYINS(NUINDEX2).PRODUCT_TYPE_ID ) THEN

                            
                            IF ( TBITEMSCAPACITYREC(NUINDEX).CAPACITY_OCCUPIED <=
                                TBITEMSCAPACITYINS(NUINDEX2).CAPACITY_TOTAL ) THEN
                                BLMATCH := TRUE;
                                EXIT;
                            END IF;
                        END IF;

                        NUINDEX2 := TBITEMSCAPACITYINS.NEXT(NUINDEX2);
                    END LOOP;

                    
                    
                    IF ( NOT BLMATCH) THEN
                        ERRORS.SETERROR(
                            CNUNOT_CAPACITY,
                            RCITEMSERREC.SERIE || '|' ||
                            TBITEMSCAPACITYREC(NUINDEX).PRODUCT_TYPE_ID || ' - ' ||
                            PKTBLSERVICIO.FSBGETDESCRIPTION(TBITEMSCAPACITYREC(NUINDEX).PRODUCT_TYPE_ID) || '|' ||
                            RCITEMSERINS.SERIE
                        );
                        RAISE EX.CONTROLLED_ERROR;
                    END IF;

                END IF;  
                NUINDEX := TBITEMSCAPACITYREC.NEXT(NUINDEX);
            END LOOP;

            UT_TRACE.TRACE('--[3] Procesando capacidades ', 12);
            
            
            NUIDX := TBITEMSCAPACITYREC.FIRST;
            LOOP
                EXIT WHEN NUIDX IS NULL;
                DAGE_ITEM_SERIADO_CAP.LOCKBYPK(
                    TBITEMSCAPACITYREC(NUIDX).ITEM_SERIADO_CAP_ID,
                    RCITEMSERIADOCAP
                );
                
                
                TBIDCAPACITYREC(NUIDX) := TBITEMSCAPACITYREC(NUIDX).ITEM_SERIADO_CAP_ID;

                NUIDX := TBITEMSCAPACITYREC.NEXT(NUIDX);
            END LOOP;

            
            FORALL NUIDX IN TBITEMSCAPACITYREC.FIRST .. TBITEMSCAPACITYREC.LAST
                UPDATE  GE_ITEM_SERIADO_CAP
                SET     CAPACITY_OCCUPIED = 0
                WHERE   ITEM_SERIADO_CAP_ID = TBIDCAPACITYREC(NUIDX);

            
            UT_TRACE.TRACE('--[4] Procesando componentes -> [' || RCITEMSERREC.SERIE||']', 12);
            RFREFCURSOR := PR_BCCOMPONENT.FRFGETCOMPONENTSBYTYPE(
                RCITEMSERREC.SERIE,
                NVL(INUCOMPONENTTYPEID, PS_BOCOMPONENTTYPE.FNUGETCOMPTYPEQUIPO)
            );
            FETCH RFREFCURSOR BULK COLLECT INTO TBCOMPONENTSREC;
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(RFREFCURSOR);

            
            UPDCOMPONENTNCAPACITY( TBCOMPONENTSREC, INUITEMSERINS, RCITEMSERINS.SERIE);
        ELSE
            
            
            UT_TRACE.TRACE('--[5] Actualizando Componente -> [' || TO_CHAR(INUCOMPONENTID) ||']', 12);
            IF ( NOT INUCOMPONENTID IS NULL AND ISBISUTILITIES = GE_BOCONSTANTS.CSBNO) THEN
                DAPR_COMPONENT.UPDSERVICE_NUMBER (
                    INUCOMPONENTID,
                    RCITEMSERINS.SERIE
                );
            END IF;

            
            IF (INUMOCOMPONENTID IS NOT NULL AND ISBISUTILITIES = GE_BOCONSTANTS.CSBNO) THEN
                DAMO_COMPONENT.UPDSERVICE_NUMBER ( INUMOCOMPONENTID,   RCITEMSERINS.SERIE );
            END IF;

        END IF;

        
        UT_TRACE.TRACE('--[6] Generando Movimientos -> [' || TO_CHAR(INUCOMPONENTID) ||']', 12);
        IF NVL(DAGE_ITEMS.FSBGETRECOVERY(RCITEMSERREC.ITEMS_ID, 0), GE_BOCONSTANTS.CSBNO) = GE_BOCONSTANTS.CSBNO THEN
            SBMOVETYPE := OR_BOITEMSMOVE.CSBNEUTRALMOVETYPE;
        ELSE
            SBMOVETYPE := OR_BOITEMSMOVE.CSBINCREASEMOVETYPE;
        END IF;

        
        PROCESSUPDRECEQU(INUORDERID, RCITEMSERREC);

        OR_BOITEMSMOVE.CREATEMOVBYLEGALIZE (
            INUORDERID,
            RCITEMSERINS.OPERATING_UNIT_ID,
            RCITEMSERREC.ITEMS_ID,
            RCITEMSERREC,
            SBMOVETYPE,
            1,
            NULL,
            NUUNIITEMMOVID
        );

        
        SBMOVETYPE := OR_BOITEMSMOVE.CSBDECREASEMOVETYPE;
        OR_BOITEMSMOVE.CREATEMOVBYLEGALIZE (
            INUORDERID,
            RCITEMSERINS.OPERATING_UNIT_ID,
            RCITEMSERINS.ITEMS_ID,
            RCITEMSERINS,
            SBMOVETYPE,
            1,
            NULL,
            NUUNIITEMMOVID
        );

        UT_TRACE.TRACE('-- [FIN] Or_BOLegalizeActivities.exchangeEquipment ', 12);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END EXCHANGEEQUIPMENT;
    
    



























    PROCEDURE CRMEASUREELEMENT
    (
        IRCCOMPONENT    IN  DAPR_COMPONENT.STYPR_COMPONENT,
        INUITEMSGAMA    IN  GE_ITEMS_GAMA.ID_ITEMS_GAMA%TYPE,
        ISBSERIE        IN  GE_ITEMS_SERIADO.SERIE%TYPE,
        INUITEMSERIADO  IN  GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%TYPE,
        INUSUBSCRIBERID IN  SUSCRIPC.SUSCCLIE%TYPE,
        ONUELEMENTID    OUT ELEMMEDI.ELMEIDEM%TYPE
    )
     IS
        NUELMENUDC          ELEMMEDI.ELMENUDC%TYPE;
        NUELMETOPE          ELEMMEDI.ELMETOPE%TYPE;
        NUELMECLEM          ELEMMEDI.ELMECLEM%TYPE;
        NUERRORCODE         MENSAJE.MENSCODI%TYPE;
        SBERRORMESSAGE      MENSAJE.MENSDESC%TYPE;
        NULOCATION          ELEMMEDI.ELMEUIEM%TYPE;
        NUITEMSTIPOATTRID   GE_ITEMS_TIPO_ATR.ID_ITEMS_TIPO_ATR%TYPE;
        NUITEMTYPEID        GE_ITEMS_TIPO.ID_ITEMS_TIPO%TYPE;
        NUIDATRIBVALUE      GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_TIPO_AT_VAL%TYPE;
        CSBTECHNICALNAME    CONSTANT    GE_ENTITY_ATTRIBUTES.TECHNICAL_NAME%TYPE := 'UBICACION';
    BEGIN
        UT_TRACE.TRACE('INICIO Or_BOLegalizeActivities.crMeasureElement. inuitemsGama '
                        ||TO_CHAR(INUITEMSGAMA)||' isbSerie '
                        ||ISBSERIE,2);

        
        IF ( PKMEASUREMENTELEMENMGR.FBLEXISTMEASUREELEMENT( ISBSERIE,PKCONSTANTE.NOCACHE )) THEN

            
        	ONUELEMENTID := PKMEASUREMENTELEMENMGR.FNUGETMEASUREELEMENTID
                                (
                                    ISBSERIE
                                );
            UT_TRACE.TRACE('El elemento de medici�n Existe['||TO_CHAR(ONUELEMENTID)||']',15);
        ELSE
            NUELMENUDC := GE_BOPARAMETER.FNUGET('DEF_METER_DIGI_NUMB');
            PKPARAMETERMGR.GETNULLNUMBER(NUELMECLEM);
            NUELMETOPE := GE_BOPARAMETER.FNUGET('DEF_METER_MAX_VALUE');

             
            PKMEASUREMENTELEMEN.REGISTER(ISBSERIE,
                                     NUELMECLEM,
                                     NUELMENUDC,
                                     1,
                                     NUELMETOPE,
                                     NUERRORCODE,
                                     SBERRORMESSAGE,
                                     ONUELEMENTID
                                    );
            GW_BOERRORS.CHECKERROR(NUERRORCODE,SBERRORMESSAGE);
        END IF;
        
        IF (ONUELEMENTID IS NOT NULL) THEN
            
            PR_BOMEASUREMENTELEMENT.CREATEMEASUREELEMENTLINK(ONUELEMENTID,IRCCOMPONENT);

            IF (INUITEMSERIADO IS NOT NULL) THEN
                DAGE_ITEMS_SERIADO.UPDSUBSCRIBER_ID(INUITEMSERIADO, INUSUBSCRIBERID);
            END IF;
            
            
            
            NULOCATION := OR_BOLEGALIZEACTIVITIES.FNUGETELEMLOCATION(NULL);

            IF (NULOCATION IS NOT NULL) THEN

                
                PKTBLUBINELME.ACCKEY(NULOCATION);
                
                
                NUITEMTYPEID := GE_BCITEMSSERIADO.FNUGETITEMTYPEBYIDSERIE
                                    (
                                        INUITEMSERIADO
                                    );
                                    
                
                IF(NUITEMTYPEID IS NOT NULL) THEN
                    
                    NUITEMSTIPOATTRID := GE_BCITEMSSERIADO.FNUGETIDATTRIBUTE
                                            (
                                                NUITEMTYPEID ,
                                                CSBTECHNICALNAME,
                                                FALSE
                                            );
                END IF;

                
                IF (NUITEMSTIPOATTRID IS NOT NULL) THEN
                    
                    GE_BOITEMSSERIADO.ACTUALIZARATRIBUTO
                        (
                            NUITEMSTIPOATTRID,
                            INUITEMSERIADO,
                            NULOCATION,
                            NUIDATRIBVALUE
                        );
                END IF;
                
                
                PKTBLELEMMEDI.UPDELMEUIEM(ONUELEMENTID, NULOCATION);
                
            END IF;
        END IF;
        UT_TRACE.TRACE('-- FIN Or_BOLegalizeActivities.crMeasureElement. onuElementId '
                                ||TO_CHAR(ONUELEMENTID)     ||'. nuLocation: '
                                ||TO_CHAR(NULOCATION)       ||'. nuItemTypeId: '
                                ||TO_CHAR(NUITEMTYPEID)     ||'. nuItemsTipoAttrId: '
                                ||TO_CHAR(NUITEMSTIPOATTRID), 10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
        	RAISE;
        WHEN OTHERS THEN
        	ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
     END CRMEASUREELEMENT;
     
     





















    PROCEDURE CREATEPLANELME
    (
        INUPRODUCTID        IN  PR_COMPONENT.PRODUCT_ID%TYPE,
        INUSERVICEDATE      IN  PR_COMPONENT.SERVICE_DATE%TYPE,
        ISBSERIE            IN  OR_ORDER_ITEMS.SERIE%TYPE
    )
     IS

        NUPLANCOMERCIALID   CC_COMMERCIAL_PLAN.COMMERCIAL_PLAN_ID%TYPE;
        NURATINGPLAN        CC_COMMERCIAL_PLAN.RATING_PLAN%TYPE;
    BEGIN
        UT_TRACE.TRACE('-- INICIO Or_BOLegalizeActivities.createPlanElme',15);

        
        NUPLANCOMERCIALID := DAPR_PRODUCT.FNUGETCOMMERCIAL_PLAN_ID(INUPRODUCTID);
        
        
        
        IF (NUPLANCOMERCIALID IS NOT NULL) THEN
            NURATINGPLAN := DACC_COMMERCIAL_PLAN.FNUGETRATING_PLAN(NUPLANCOMERCIALID);

            
            IF (NURATINGPLAN IS NOT NULL AND
                NURATINGPLAN <> PKGENERALPARAMETERSMGR.FNUGETNUMBERPARAMETER('NULLNUMS')) THEN
                    LE_BOPLANPORELEMMEDI.CREARPLANELME
                        (
                            ISBSERIE,
                           	NURATINGPLAN,
                           	INUSERVICEDATE,
                            UT_DATE.FDTMAXDATE
                        );
            END IF;
        END IF;

        UT_TRACE.TRACE('-- FIN Or_BOLegalizeActivities.createPlanElme',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
        	RAISE;
        WHEN OTHERS THEN
        	ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
     END CREATEPLANELME;
     
     























































    PROCEDURE SETMEASURABLESEQUIP
    (
        IRCCOMPONENT    IN  DAPR_COMPONENT.STYPR_COMPONENT,
        INUITEMSGAMA    IN  GE_ITEMS_GAMA.ID_ITEMS_GAMA%TYPE,
        INUORDERID      IN  OR_ORDER.ORDER_ID%TYPE,
        INUSUBSCRIBERID IN  SUSCRIPC.SUSCCLIE%TYPE,
        ONUELEMENTID    OUT ELEMMEDI.ELMEIDEM%TYPE
    )
     IS
         NUORDERACTID   OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
         
         NUEQUIPINDEX   BINARY_INTEGER;
         
         RCEQUIPMENT    OR_BCORDERITEMS.TYRCEQUIPMENT;
         
         TBEQUIPMENT    OR_BCORDERITEMS.TYTBEQUIPMENT;
         
         RCITEMSERIADO  DAGE_ITEMS_SERIADO.STYGE_ITEMS_SERIADO;
         
         RCCOMPONENT    DAPR_COMPONENT.STYPR_COMPONENT;
    BEGIN
        UT_TRACE.TRACE('-- INICIO Or_BOLegalizeActivities.setMeasurablesEquip. inuOrderId '||INUORDERID||' inuitemsGama '||INUITEMSGAMA, 2);
        
        
        NUORDERACTID := OR_BOLEGALIZEACTIVITIES.FNUGETCURRACTIVITY;
        
        
        OR_BCORDERITEMS.GETEQUIPMENTBYACTIVI(NUORDERACTID, TBEQUIPMENT);

        NUEQUIPINDEX := TBEQUIPMENT.FIRST;
        
        WHILE (NUEQUIPINDEX IS NOT NULL) LOOP
        
            RCEQUIPMENT := TBEQUIPMENT(NUEQUIPINDEX);

            IF (RCEQUIPMENT.ITEMAMOUNT > 0) THEN
                DAGE_ITEMS_SERIADO.GETRECORD(RCEQUIPMENT.ITEMSERIADOID, RCITEMSERIADO);
                
                UT_TRACE.TRACE('SERIE['||RCITEMSERIADO.SERIE||']OUT='||RCEQUIPMENT.OUT_, 15);

                RCCOMPONENT := IRCCOMPONENT;
                
                
                IF (RCEQUIPMENT.OUT_ = GE_BOCONSTANTS.CSBYES) THEN

                    
                    OR_BOLEGALIZEACTIVITIES.INSTALLPROCESS
                        (
                            RCCOMPONENT,
                            INUORDERID,
                            SBISUTILITIES,
                            RCITEMSERIADO.SERIE,
                            RCITEMSERIADO.ID_ITEMS_SERIADO,
                            INUSUBSCRIBERID,
                            ONUELEMENTID
                        );
                        
                
                ELSE
                    
                    OR_BOLEGALIZEACTIVITIES.RETIREPROCESS
                        (
                            RCITEMSERIADO.SERIE,
                            RCCOMPONENT.PRODUCT_ID,
                            INUORDERID,
                            NUORDERACTID,
                            ONUELEMENTID
                        );
                END IF;
            END IF;
            NUEQUIPINDEX := TBEQUIPMENT.NEXT(NUEQUIPINDEX);
        END LOOP;
        UT_TRACE.TRACE('-- FIN Or_BOLegalizeActivities.setMeasurablesEquip',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
        	RAISE;
        WHEN OTHERS THEN
        	ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
     END SETMEASURABLESEQUIP;
    
    
















    PROCEDURE ASSOCIATESERIALCOMPONENT
    (
        ISBSERIE            GE_ITEMS_SERIADO.SERIE%TYPE
    )
    IS
        
        CNUNOTFOUND_ITEM    CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 143751;
        CNUERROR_INV_STATUS CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 143787;
        CNUNOTFOUND_ITEMCAP CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 18023;
        CNUINV_CAPACITY     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 18027;
        CNUERROR_ITEM_USE   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 150009;
        CNUERROR_ITEM_TYPE  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 20202;
        CNUERROR_ITEM_GAMMA CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 20203;

        
        NUCOMPONENTID      MO_COMPONENT.COMPONENT_ID%TYPE;
        RCCOMPONENT        DAMO_COMPONENT.STYMO_COMPONENT;
        NUPRODUCTTYPEID   PR_PRODUCT.PRODUCT_TYPE_ID%TYPE;
        RCITEMSERIADO      DAGE_ITEMS_SERIADO.STYGE_ITEMS_SERIADO;
        TBITEMSERCAP       DAGE_ITEM_SERIADO_CAP.TYTBGE_ITEM_SERIADO_CAP;
        NUITEMTIPOID       GE_ITEMS.ID_ITEMS_TIPO%TYPE;
        NUITEMSGAMAID      GE_ITEMS_GAMA_ITEM.ID_ITEMS_GAMA%TYPE ;
        NUCOMPITEMSID      GE_ITEMS.ITEMS_ID%TYPE;
        NUCOMPITEMSTIPOID  GE_ITEMS.ID_ITEMS_TIPO%TYPE;
        NUCOMPITEMSGAMAID  GE_ITEMS_GAMA_ITEM.ID_ITEMS_GAMA%TYPE ;
        NUPACKAGEID        MO_PACKAGES.PACKAGE_ID%TYPE;
        NUSELLERID         GE_PERSON.PERSON_ID%TYPE;

        CNUITEM_BLACKLIST           CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 6243;
        CNUNO_SERVICE_CLASS         CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 150004;
        CNUINVALID_ITEM_SELLER      CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 508;

    BEGIN
        UT_TRACE.TRACE('INICIO Or_BOLegalizeActivities.AssociateSerialComponent', 1);
        UT_TRACE.TRACE('Serie : '||ISBSERIE, 2);

        
        GE_BOITEMSSERIADO.GETITEMSERBYSERIE(ISBSERIE, RCITEMSERIADO);

        
        IF (RCITEMSERIADO.ID_ITEMS_SERIADO IS NULL) THEN
            GE_BOERRORS.SETERRORCODEARGUMENT(CNUNOTFOUND_ITEM, ISBSERIE);
        END IF;

        
        IF (RCITEMSERIADO.ID_ITEMS_ESTADO_INV NOT IN
                          (GE_BOITEMSCONSTANTS.CNUSTATUS_DISPONIBLE,
                           GE_BOITEMSCONSTANTS.CNUSTATUS_ENUSO)
           ) THEN
           GE_BOERRORS.SETERRORCODEARGUMENT
           (
            CNUERROR_INV_STATUS,
            ''||DAGE_ITEMS_ESTADO_INV.FSBGETDESCRIPCION
                                      (
                                       RCITEMSERIADO.ID_ITEMS_ESTADO_INV,
                                       0
                                      )||'|'||ISBSERIE
           );
        END IF;


        
        IF (GE_BCITEMSSERIADO.FBLITEMBLACKLIST(ISBSERIE)) THEN
            GE_BOERRORS.SETERRORCODE(CNUITEM_BLACKLIST);
        END IF;


        
        
        IF (NVL(RCITEMSERIADO.PROPIEDAD, GE_BOITEMSCONSTANTS.CSBEMPRESA) !=
            GE_BOITEMSCONSTANTS.CSBTRAIDO_CLIENTE) THEN

            NUPACKAGEID := OR_BOLEGALIZEACTIVITIES.FNUGETCURRPACKAGE;

            IF (NUPACKAGEID IS NOT NULL) THEN

                NUSELLERID := DAMO_PACKAGES.FNUGETPERSON_ID(NUPACKAGEID);

                IF (NUSELLERID IS NOT NULL) THEN
                    
                    
                    IF (GE_BCITEMSSERIADO.FBLVALITEMFORSEL(ISBSERIE, NUSELLERID)) THEN
                        GI_BOERRORS.SETERROR(CNUINVALID_ITEM_SELLER);
                    END IF;
                END IF;
            END IF;
        END IF;

        
        NUCOMPONENTID := OR_BOLEGALIZEACTIVITIES.FNUGETCURRCOMPONENT;
        UT_TRACE.TRACE('nuComponentId : '||NUCOMPONENTID, 2);

        
        DAMO_COMPONENT.GETRECORD(NUCOMPONENTID, RCCOMPONENT);

        
        IF (DAGE_ITEMS.FSBGETSHARED(RCITEMSERIADO.ITEMS_ID) = GE_BOCONSTANTS.CSBYES) THEN

            UT_TRACE.TRACE('Es compartido : '||RCITEMSERIADO.ITEMS_ID, 2);

            NUPRODUCTTYPEID := DAPR_PRODUCT.FNUGETPRODUCT_TYPE_ID(RCCOMPONENT.PRODUCT_ID,1);
            
            TBITEMSERCAP := GE_BCITEMCAPACITY.FTBGETCAPSSERBYITEM
                            (
                               RCITEMSERIADO.ID_ITEMS_SERIADO,
                               NUPRODUCTTYPEID
                            );

            
            IF (TBITEMSERCAP.COUNT  < 1) THEN
                GE_BOERRORS.SETERRORCODEARGUMENT(CNUNOTFOUND_ITEMCAP, ISBSERIE||'|'||PKTBLSERVICIO.FSBGETDESCRIPTION(NUPRODUCTTYPEID) );
            END IF;

            
            IF (TBITEMSERCAP(TBITEMSERCAP.FIRST).CAPACITY_OCCUPIED >= TBITEMSERCAP(TBITEMSERCAP.FIRST).CAPACITY_TOTAL) THEN
                GE_BOERRORS.SETERRORCODEARGUMENT(CNUINV_CAPACITY, ISBSERIE||'|'||PKTBLSERVICIO.FSBGETDESCRIPTION(NUPRODUCTTYPEID));
            END IF;

            
            DAGE_ITEM_SERIADO_CAP.UPDCAPACITY_OCCUPIED
            (
                TBITEMSERCAP(TBITEMSERCAP.FIRST).ITEM_SERIADO_CAP_ID,
                TBITEMSERCAP(TBITEMSERCAP.FIRST).CAPACITY_OCCUPIED + 1
            );

        
        ELSIF (RCITEMSERIADO.ID_ITEMS_ESTADO_INV = GE_BOITEMSCONSTANTS.CNUSTATUS_ENUSO) THEN
            GE_BOERRORS.SETERRORCODEARGUMENT(CNUERROR_INV_STATUS, ''||DAGE_ITEMS_ESTADO_INV.FSBGETDESCRIPCION(RCITEMSERIADO.ID_ITEMS_ESTADO_INV,0)||'|'||ISBSERIE);

        
        ELSIF (PR_BOCOMPONENT.FNUGETCOMPIDBYSERVNUMB(ISBSERIE, RCCOMPONENT.COMPONENT_TYPE_ID) IS NOT NULL) THEN
            GE_BOERRORS.SETERRORCODEARGUMENT(CNUERROR_ITEM_USE, ISBSERIE);
        END IF;

        
        NUITEMTIPOID := DAGE_ITEMS.FNUGETID_ITEMS_TIPO(RCITEMSERIADO.ITEMS_ID);

        
        NUCOMPITEMSID := DAPS_CLASS_SERVICE.FNUGETITEM_ID(RCCOMPONENT.CLASS_SERVICE_ID, 0);

        
        IF (RCITEMSERIADO.ITEMS_ID != NVL(NUCOMPITEMSID, -1)) THEN
            ERRORS.SETERROR(CNUNO_SERVICE_CLASS);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        MO_BOCOMPONENT.UPDSERVICENUMBER(NUCOMPONENTID, ISBSERIE);

        PR_BOCOMPONENT.UPDSERVICENUMBER(RCCOMPONENT.COMPONENT_ID_PROD, ISBSERIE);

        UT_TRACE.TRACE('FIN Or_BOLegalizeActivities.AssociateSerialomponent', 1);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('CONTROLLED_ERROR Or_BOLegalizeActivities.AssociateSerialComponent', 1);
            RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('OTHERS Or_BOLegalizeActivities.AssociateSerialComponent', 1);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ASSOCIATESERIALCOMPONENT;
        
    













    PROCEDURE INITORIGINACTIVITY
    IS
        NUCURRENTACTIVITYID OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
        NUORIGINACTIVITYID  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
    BEGIN
        UT_TRACE.TRACE('BEGIN OR_BOLegalizeActivities.InitOriginActivity', 1);
        NUCURRENTACTIVITYID := OR_BOLEGALIZEACTIVITIES.FNUGETCURRACTIVITY;
        UT_TRACE.TRACE('nuCurrentActivityId ['||NUCURRENTACTIVITYID||']', 2);
        
        NUORIGINACTIVITYID :=   DAOR_ORDER_ACTIVITY.FNUGETORIGIN_ACTIVITY_ID(NUCURRENTACTIVITYID,0);
        UT_TRACE.TRACE('nuOriginActivityId ['||NUORIGINACTIVITYID||']', 2);
        
        
        GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(NUORIGINACTIVITYID);
        
        UT_TRACE.TRACE('END OR_BOLegalizeActivities.InitOriginActivity', 1);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('CONTROLLED_ERROR OR_BOLegalizeActivities.InitOriginActivity', 1);
            RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('OTHERS OR_BOLegalizeActivities.InitOriginActivity', 1);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END; 
    
    
    













    PROCEDURE CREATEFRAUDTOSEAL(INUORDER_ID IN OR_ORDER.ORDER_ID%TYPE,
                                                      NUPRODUCTID               IN FM_POSSIBLE_NTL.PRODUCT_ID%TYPE,
                                                      INUGEOGRAPHLOCATION  IN FM_POSSIBLE_NTL.GEOGRAP_LOCATION_ID%TYPE,
                                                      NUPRODUCTTYPEID          IN FM_POSSIBLE_NTL.PRODUCT_TYPE_ID%TYPE,
                                                      ISBCOMMENTGENERIC   IN FM_POSSIBLE_NTL.COMMENT_%TYPE,
                                                      INUDISCOVERYTYPE       IN FM_POSSIBLE_NTL.DISCOVERY_TYPE_ID%TYPE,
                                                      ONUCODECREATEDFRAUD OUT FM_POSSIBLE_NTL.POSSIBLE_NTL_ID%TYPE ) IS
      
      RCORDER DAOR_ORDER.STYOR_ORDER;
      
    BEGIN
      
      
       UT_TRACE.TRACE('INICIA Creaci�n del fraudes para asociaci�n de sellos [OR_BOLegalizeActivities.CreateFraudToSeal]', 3);                         
                                                
       DAOR_ORDER.GETRECORD(INUORDER_ID,RCORDER);
                                                
      
      GE_BOITEMSSERIADO.PROCESSFRAUD(NUPRODUCTID,
                                                       RCORDER.GEOGRAP_LOCATION_ID,
                                                       NUPRODUCTTYPEID,
                                                       ISBCOMMENTGENERIC,
                                                       INUDISCOVERYTYPE,
                                                       ONUCODECREATEDFRAUD);
                                                                                                   
      UT_TRACE.TRACE('Posible Fraude creado ==> '||ONUCODECREATEDFRAUD,10);
      UT_TRACE.TRACE('FIN Creaci�n del fraudes para asociaci�n de sellos [OR_BOLegalizeActivities.CreateFraudToSeal]', 3);                           

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('CONTROLLED_ERROR OR_BOLegalizeActivities.CreateFraudToSeal', 10);
            RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('OTHERS OR_BOLegalizeActivities.CreateFraudToSeal', 10);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CREATEFRAUDTOSEAL;
    
    
























    PROCEDURE RETIREPROCESS
    (
        ISBSERIE        IN  GE_ITEMS_SERIADO.SERIE%TYPE,
        INUPRODUCTID    IN  PR_PRODUCT.PRODUCT_ID%TYPE,
        INUORDERID      IN  OR_ORDER_ITEMS.ORDER_ID%TYPE,
        INUORDERACTID   IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        ONUELEMENTID    OUT ELEMMEDI.ELMEIDEM%TYPE
    )
    IS
        NUERRORCODE             GE_MESSAGE.MESSAGE_ID%TYPE;
        SBERRORMESSAGE          GE_MESSAGE.DESCRIPTION%TYPE;
        NUPRODUCTID             PR_PRODUCT.PRODUCT_ID%TYPE;
        DTRETIREDATE            PR_COMPONENT.SERVICE_DATE%TYPE;
    BEGIN
        UT_TRACE.TRACE('INICIO Or_BOLegalizeActivities.retireProcess. isbSerie: '
                        ||ISBSERIE              ||' inuProductId: '
                        ||TO_CHAR(INUPRODUCTID) ||' inuOrderId: '
                        ||TO_CHAR(INUORDERID)   ||' inuOrderActId: '
                        ||TO_CHAR(INUORDERACTID), 2 );
                        
        MO_BOUTILITIES.INITIALIZEOUTPUT(NUERRORCODE,SBERRORMESSAGE);

        
        PKMEASUREMENTELEMEN.GETMEASUREELEMENTID
            (
                ISBSERIE,
                ONUELEMENTID,
                NUERRORCODE,
                SBERRORMESSAGE
            );
            
        
        GW_BOERRORS.CHECKERROR(NUERRORCODE,SBERRORMESSAGE);
            
        NUPRODUCTID := INUPRODUCTID;

        
        IF (NUPRODUCTID IS NULL) THEN
            NUPRODUCTID := DAOR_ORDER_ACTIVITY.FNUGETPRODUCT_ID(INUORDERACTID);
        END IF;

        
        IF (NUPRODUCTID IS NULL) THEN
            GE_BOERRORS.SETERRORCODE(CNUERR901711);
        END IF;

        
        DTRETIREDATE := DAOR_ORDER.FDTGETEXECUTION_FINAL_DATE(INUORDERID) - (1/UT_DATE.CNUSECONDSBYDAY);

        
        LE_BCPLANELME.RETIROELEMENTOSPRODUCTO
        (
            ISBSERIE,
            DTRETIREDATE
        );

        
        
        PKMEASUREMENTELEMENTREQUEST.RETELEMMEASUSERVSUBS
        (
            ONUELEMENTID,
            NUPRODUCTID,
            DTRETIREDATE,
            NUERRORCODE,
            SBERRORMESSAGE
        );

        
        GW_BOERRORS.CHECKERROR(NUERRORCODE,SBERRORMESSAGE);

        UT_TRACE.TRACE('FIN Or_BOLegalizeActivities.retireProcess. onuElementId: '||TO_CHAR(ONUELEMENTID), 2 );
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END RETIREPROCESS;
    
    






















    PROCEDURE INSTALLPROCESS
    (
        RCCOMPONENT     IN OUT  DAPR_COMPONENT.STYPR_COMPONENT,
        INUORDERID      IN      OR_ORDER.ORDER_ID%TYPE,
        ISBISUTILITIES  IN      GE_BOITEMS.STYLETTER DEFAULT GE_BOCONSTANTS.CSBNO,
        ISBSERIE        IN      GE_ITEMS_SERIADO.SERIE%TYPE,
        INUSERIALITEMID IN      GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%TYPE,
        INUSUBSCRIBERID IN      SUSCRIPC.SUSCCLIE%TYPE,
        ONUELEMENTID    OUT     ELEMMEDI.ELMEIDEM%TYPE
    )
    IS
        NUITEMSGAMA    GE_ITEMS_GAMA.ID_ITEMS_GAMA%TYPE;
        NUITEMSID      GE_ITEMS_GAMA_ITEM.ITEMS_ID%TYPE;
    BEGIN
        UT_TRACE.TRACE('INICIO Or_BOLegalizeActivities.installProcess. inuOrderId: '
                    ||TO_CHAR(INUORDERID)               ||' isbISUtilities: '
                    ||ISBISUTILITIES                    ||' isbSerie: '
                    ||ISBSERIE                          ||' inuSerialItemId: '
                    ||TO_CHAR(INUSERIALITEMID)          ||' inuSubscriberId: '
                    ||TO_CHAR(INUSUBSCRIBERID)          || ' rcComponent.component_Id: '
                    ||TO_CHAR(RCCOMPONENT.COMPONENT_ID) , 2 );

        RCCOMPONENT.SERVICE_DATE := DAOR_ORDER.FDTGETEXECUTION_FINAL_DATE(INUORDERID);

        IF (ISBISUTILITIES = GE_BOCONSTANTS.CSBNO) THEN
            RCCOMPONENT.SERVICE_NUMBER := ISBSERIE;
        END IF;

        DAPR_COMPONENT.UPDRECORD(RCCOMPONENT);

        GE_BCITEMS_GAMA_ITEM.GETGAMMABYSERIE(ISBSERIE, NUITEMSGAMA, NUITEMSID);
         
         
        OR_BOLEGALIZEACTIVITIES.CRMEASUREELEMENT
        (
            RCCOMPONENT,
            NUITEMSGAMA,
            ISBSERIE,
            INUSERIALITEMID,
            INUSUBSCRIBERID,
            ONUELEMENTID
        );

        IF (ONUELEMENTID IS NOT NULL) THEN
            
            
            OR_BOLEGALIZEACTIVITIES.CREATEPLANELME
                (
                    RCCOMPONENT.PRODUCT_ID,
                    RCCOMPONENT.SERVICE_DATE,
                    ISBSERIE
                );
        END IF;

        UT_TRACE.TRACE('FIN Or_BOLegalizeActivities.installProcess. onuElementId: '||TO_CHAR(ONUELEMENTID), 2 );
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END INSTALLPROCESS;
    

    



















    PROCEDURE INSERTSEALITEMS
    (
        INUORDERID           IN  OR_ORDER.ORDER_ID%TYPE,
        INUORDERACTIVITYID   IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE
    )
    IS
        TBASSOSEALTOEQUIP       OR_BOINSTANCEACTIVITIES.TYTBASSOSEALTOEQUIP;
        SBINDEXSEALTOASSO       GE_ITEMS_SERIADO.SERIE%TYPE;
    BEGIN
        UT_TRACE.TRACE(' INICIO or_bolegalizeactivities.insertSealItems:('||
                       'inuOrderId='||INUORDERID||',inuActivityId='||INUORDERACTIVITYID||')',2);
        
        
        OR_BOINSTANCEACTIVITIES.GETEQUIPTOASSOC(NULL, TBASSOSEALTOEQUIP);

        
        IF TBASSOSEALTOEQUIP.FIRST IS NOT NULL THEN

            UT_TRACE.TRACE(' N�mero de sellos en memoria:'||TBASSOSEALTOEQUIP.COUNT ,2);

            SBINDEXSEALTOASSO := TBASSOSEALTOEQUIP.FIRST;

            
            WHILE (SBINDEXSEALTOASSO IS NOT NULL) LOOP
            
                IF TBASSOSEALTOEQUIP(SBINDEXSEALTOASSO).ACTIVITYID = INUORDERACTIVITYID AND
                   TBASSOSEALTOEQUIP(SBINDEXSEALTOASSO).ISTOASSOC  = GE_BCITEMSSERIADO.CSBASSOCSEAL
                THEN
                    INSERTSEALITEM
                    (
                        INUORDERID,
                        INUORDERACTIVITYID,
                        TBASSOSEALTOEQUIP(SBINDEXSEALTOASSO).SEALSERIE
                    );
                END IF;

                SBINDEXSEALTOASSO := TBASSOSEALTOEQUIP.NEXT(SBINDEXSEALTOASSO);
            END LOOP;
        END IF;
        
        
        OR_BOINSTANCEACTIVITIES.CLEAREQUIPTOASSO;

        UT_TRACE.TRACE('FIN or_bolegalizeactivities.insertSealItems', 2);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END INSERTSEALITEMS;


    

















    PROCEDURE INSERTSEALITEM
    (
        INUORDERID      IN  OR_ORDER.ORDER_ID%TYPE,
        INUORDERACTID   IN  OR_ORDER_ITEMS.ORDER_ACTIVITY_ID%TYPE,
        ISBSERIE        IN  OR_ORDER_ITEMS.SERIE%TYPE
    )
    IS
        NUSERIALITEMID  GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%TYPE;
        NUITEMSID       GE_ITEMS.ITEMS_ID%TYPE;
        RCORDERITEM     DAOR_ORDER_ITEMS.STYOR_ORDER_ITEMS;
    BEGIN
        UT_TRACE.TRACE(' INICIO or_bolegalizeactivities.insertSealItem:('
                            ||' inuOrderId:'   ||INUORDERID
                            ||' inuOrderActId:'||INUORDERACTID
                            ||' isbSerie: '    ||ISBSERIE ,2);
                            
        GE_BOITEMSSERIADO.GETIDBYSERIE(ISBSERIE,NUSERIALITEMID);
        
        IF NUSERIALITEMID IS NULL THEN
            
            ERRORS.SETERROR(5206,ISBSERIE);
            RAISE EX.CONTROLLED_ERROR;
        ELSE
            RCORDERITEM.OUT_                  := GE_BOCONSTANTS.CSBYES;
            NUITEMSID                         := DAGE_ITEMS_SERIADO.FNUGETITEMS_ID(NUSERIALITEMID);
            RCORDERITEM.ITEMS_ID              := NUITEMSID;
            RCORDERITEM.ORDER_ACTIVITY_ID     := INUORDERACTID;
            RCORDERITEM.SERIE                 := UPPER(ISBSERIE);
            RCORDERITEM.SERIAL_ITEMS_ID       := NUSERIALITEMID;
            RCORDERITEM.ORDER_ID              := INUORDERID;
            RCORDERITEM.ASSIGNED_ITEM_AMOUNT  := 1;
            RCORDERITEM.LEGAL_ITEM_AMOUNT     := 1;
            RCORDERITEM.VALUE                 := 0;
            RCORDERITEM.TOTAL_PRICE           := 0;
            RCORDERITEM.ORDER_ITEMS_ID        := OR_BOSEQUENCES.FNUNEXTOR_ORDER_ITEMS;

            DAOR_ORDER_ITEMS.INSRECORD(RCORDERITEM);
        END IF;
        
        UT_TRACE.TRACE('FIN or_bolegalizeactivities.insertSealItem', 2);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END INSERTSEALITEM;


END OR_BOLEGALIZEACTIVITIES;