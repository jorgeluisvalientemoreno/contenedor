PACKAGE BODY OR_BCOrderItems AS



















































    
    
    
    
    CSBVERSION  CONSTANT VARCHAR2(20)  := 'SAO388051';

	
    
    
    TBEQUIPMENT TYTBEQUIPMENT;
    
    
    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;




    PROCEDURE GETPRSLISTITEMBYPRSLIST
    (
        INUPRICELISTING     IN  GE_UNIT_COST_ITE_LIS.LIST_UNITARY_COST_ID%TYPE,
        OTBPRSLISTITEM     OUT  DAGE_UNIT_COST_ITE_LIS.TYTBGE_UNIT_COST_ITE_LIS,
        ONUCOUNT           OUT  NUMBER
    )
    IS
        CURSOR CUPRSLIST
        (
            PRSLIST    GE_UNIT_COST_ITE_LIS.LIST_UNITARY_COST_ID%TYPE
        )
        IS
            SELECT GE_UNIT_COST_ITE_LIS.*, GE_UNIT_COST_ITE_LIS.ROWID
            FROM  GE_UNIT_COST_ITE_LIS
            WHERE GE_UNIT_COST_ITE_LIS.LIST_UNITARY_COST_ID = PRSLIST;

        PROCEDURE CLOSECURSORS IS
        BEGIN
            IF CUPRSLIST%ISOPEN THEN
                CLOSE CUPRSLIST;
            END IF;
        END;
    BEGIN

        OTBPRSLISTITEM.DELETE;
        OPEN  CUPRSLIST(INUPRICELISTING);
        FETCH CUPRSLIST BULK COLLECT INTO OTBPRSLISTITEM;
        CLOSE CUPRSLIST;
        ONUCOUNT := OTBPRSLISTITEM.COUNT;

    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
    		CLOSECURSORS;
			RAISE;
        WHEN OTHERS THEN
            CLOSECURSORS;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    PROCEDURE GETORDERITEMSBYORDER
    (
        INUORDERID          IN  OR_ORDER.ORDER_ID%TYPE,
        INUACTIVITY         IN  OR_ORDER_ITEMS.ITEMS_ID%TYPE,
        OTBORDERITEM        OUT CONSTANTS.TY_TBNUMBER
    )
    IS

      CURSOR CUORDERITEMS
      (
      NUORDERID OR_ORDER.ORDER_ID%TYPE,
      NUACTIVITY OR_ORDER_ITEMS.ITEMS_ID%TYPE
      ) IS
      SELECT OR_ORDER_ITEMS.ORDER_ITEMS_ID
      FROM OR_ORDER_ITEMS
      WHERE OR_ORDER_ITEMS.ORDER_ID = NUORDERID
      AND OR_ORDER_ITEMS.ITEMS_ID = NUACTIVITY;

      PROCEDURE CLOSECURSORS IS
      BEGIN
            IF CUORDERITEMS%ISOPEN THEN
                CLOSE CUORDERITEMS;
            END IF;
      END;
    BEGIN

        OTBORDERITEM.DELETE;
        OPEN  CUORDERITEMS(INUORDERID,INUACTIVITY);
        FETCH CUORDERITEMS BULK COLLECT INTO OTBORDERITEM;
        CLOSE CUORDERITEMS;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            CLOSECURSORS;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            CLOSECURSORS;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
	END;



    FUNCTION FBLEXISTORDERELEMENT
    (
        INUORDERID      IN OR_ORDER.ORDER_ID%TYPE,
        INUELEMENTID    IN OR_ORDER_ITEMS.ELEMENT_ID%TYPE,
        INUORDERACTIVITY IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUITEMS         IN OR_ORDER_ITEMS.ITEMS_ID%TYPE
    ) RETURN BOOLEAN
    IS

        BLRETURN BOOLEAN;

          CURSOR CUORDERITEMS
          (
              NUORDERID       OR_ORDER.ORDER_ID%TYPE,
              NUELEMENTID     OR_ORDER_ITEMS.ELEMENT_ID%TYPE,
              NUORDERACTIVITY OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
              NUITEMS         OR_ORDER_ITEMS.ITEMS_ID%TYPE
          ) IS
          SELECT OR_ORDER_ITEMS.ORDER_ITEMS_ID
            FROM OR_ORDER_ITEMS
           WHERE OR_ORDER_ITEMS.ORDER_ID = NUORDERID
             AND OR_ORDER_ITEMS.ELEMENT_ID = NUELEMENTID
             AND OR_ORDER_ITEMS.ORDER_ACTIVITY_ID = NUORDERACTIVITY
             AND OR_ORDER_ITEMS.ITEMS_ID = INUITEMS
             AND ROWNUM = 1;

        RCORDERITEM  CUORDERITEMS%ROWTYPE;
        
        
        
        PROCEDURE CLOSECURSORS IS
        BEGIN
            IF CUORDERITEMS%ISOPEN THEN
                CLOSE CUORDERITEMS;
            END IF;
        END;
    BEGIN

        OPEN  CUORDERITEMS(INUORDERID, INUELEMENTID, INUORDERACTIVITY, INUITEMS);

        FETCH CUORDERITEMS INTO RCORDERITEM;

        IF  CUORDERITEMS%NOTFOUND THEN
            CLOSE CUORDERITEMS;
            RETURN FALSE;
        END IF;

        CLOSE CUORDERITEMS;

        RETURN TRUE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            CLOSECURSORS;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            CLOSECURSORS;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
	END;


    PROCEDURE DELORDERITEMBYELEMENT
    (
        INUORDERID      IN OR_ORDER.ORDER_ID%TYPE,
        INUELEMENTID    IN OR_ORDER_ITEMS.ELEMENT_ID%TYPE,
        INUORDERACTIVITY IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUITEMS         IN OR_ORDER_ITEMS.ITEMS_ID%TYPE
    )
    IS

    BEGIN

          DELETE OR_ORDER_ITEMS
           WHERE OR_ORDER_ITEMS.ORDER_ID = INUORDERID
             AND OR_ORDER_ITEMS.ELEMENT_ID = INUELEMENTID
             AND OR_ORDER_ITEMS.ORDER_ACTIVITY_ID = INUORDERACTIVITY
             AND OR_ORDER_ITEMS.ITEMS_ID = INUITEMS
             AND ROWNUM = 1;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
	END;


    PROCEDURE GETORDERITEMBYORDER
    (
      INUORDERID   IN OR_ORDER_ITEMS.ORDER_ID%TYPE,
      OTBORDERITEM OUT OR_BCORDERITEMS.TYTBORDERITEMS
    )
    IS
        SBINDEX VARCHAR2(32);

        CURSOR CUORDERITEM
        (
            NUORDERID       OR_ORDER_ITEMS.ORDER_ID%TYPE
        )
        IS
            SELECT OR_ORDER_ITEMS.ORDER_ITEMS_ID,
                   OR_ORDER_ITEMS.ORDER_ID, OR_ORDER_ITEMS.ITEMS_ID,
                   OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT
            FROM  OR_ORDER_ITEMS
            WHERE OR_ORDER_ITEMS.ORDER_ID = NUORDERID;

        PROCEDURE CLOSECURSORS IS
        BEGIN
            IF CUORDERITEM%ISOPEN THEN
                CLOSE CUORDERITEM;
            END IF;
        END;

    BEGIN

        OTBORDERITEM.DELETE;

        FOR RCORDERITEMS IN CUORDERITEM(INUORDERID) LOOP
            SBINDEX := RCORDERITEMS.ORDER_ID||'-'||RCORDERITEMS.ITEMS_ID;
            OTBORDERITEM(SBINDEX).NUORDERITEMSID := RCORDERITEMS.ORDER_ITEMS_ID;
            OTBORDERITEM(SBINDEX).NUORDERID := RCORDERITEMS.ORDER_ID;
            OTBORDERITEM(SBINDEX).NUITEMSID := RCORDERITEMS.ITEMS_ID;
            OTBORDERITEM(SBINDEX).NULEGALITEMAMOUNT := RCORDERITEMS.LEGAL_ITEM_AMOUNT;
        END LOOP;


    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
    		CLOSECURSORS;
			RAISE;
        WHEN OTHERS THEN
            CLOSECURSORS;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    PROCEDURE GETNORMALITEMSBYORDER
    (
        INUORDERID         IN   OR_ORDER_ITEMS.ORDER_ID%TYPE,
        OTBORORDERITEMS    OUT  OR_BCORDERITEMS.TYTBORDERITEMSBI,
        ONUCOUNT           OUT  NUMBER
    )

    IS
        CURSOR CUORDERITEM
        (
            NUORDERID       OR_ORDER_ITEMS.ORDER_ID%TYPE
        )
        IS
            SELECT
                OR_ORDER_ITEMS.ORDER_ITEMS_ID,
                OR_ORDER_ITEMS.ORDER_ID,
                OR_ORDER_ITEMS.ITEMS_ID,
                OR_ORDER_ITEMS.ELEMENT_ID,
                OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT,
                GE_ITEMS.ITEM_CLASSIF_ID,
                GE_ITEMS.ELEMENT_TYPE_ID
            FROM  OR_ORDER_ITEMS, GE_ITEMS
            WHERE OR_ORDER_ITEMS.ITEMS_ID = GE_ITEMS.ITEMS_ID
              AND GE_ITEMS.ITEM_CLASSIF_ID  NOT IN (OR_BOCONSTANTS.CNUITEMS_CLASS_TO_ACTIVITY,
                                           OR_BOCONSTANTS.CNUITEMS_CLASS_TO_ELEM_INST,
                                           OR_BOCONSTANTS.CNUITEMS_CLASS_TO_ELEM_RET)
              AND  OR_ORDER_ITEMS.ORDER_ID = NUORDERID;
    BEGIN

        OTBORORDERITEMS.DELETE;

        OPEN  CUORDERITEM(INUORDERID);
        FETCH CUORDERITEM  BULK COLLECT INTO OTBORORDERITEMS;
        CLOSE CUORDERITEM;

        ONUCOUNT := OTBORORDERITEMS.COUNT;

    EXCEPTION
        WHEN OTHERS THEN
            IF CUORDERITEM%ISOPEN THEN
                CLOSE CUORDERITEM;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETNORMALITEMSBYORDER;


    PROCEDURE GETELEMTYPEBYORDERITEMCLASS
    (
        INUORDERID       IN   OR_ORDER_ITEMS.ORDER_ID%TYPE,
        INUITEMCLASSIFID IN   GE_ITEMS.ITEM_CLASSIF_ID%TYPE,
        OTBELEMENTTYPEID OUT  DAGE_ITEMS.TYTBELEMENT_TYPE_ID,
        ONUCOUNT         OUT  NUMBER
    )
    IS
        CURSOR CUORDERITEM
        (
            NUORDERID       OR_ORDER_ITEMS.ORDER_ID%TYPE,
            NUITEMCLASSIFID GE_ITEMS.ITEM_CLASSIF_ID%TYPE
        )
        IS
            SELECT GE_ITEMS.ELEMENT_TYPE_ID
              FROM OR_ORDER_ITEMS, GE_ITEMS
             WHERE OR_ORDER_ITEMS.ITEMS_ID = GE_ITEMS.ITEMS_ID
               AND GE_ITEMS.ITEM_CLASSIF_ID = NUITEMCLASSIFID
              AND  OR_ORDER_ITEMS.ORDER_ID = NUORDERID
              GROUP BY ELEMENT_TYPE_ID;
    BEGIN

        OTBELEMENTTYPEID.DELETE;

        OPEN  CUORDERITEM(INUORDERID, INUITEMCLASSIFID);
        FETCH CUORDERITEM  BULK COLLECT INTO OTBELEMENTTYPEID;
        CLOSE CUORDERITEM;

        ONUCOUNT := OTBELEMENTTYPEID.COUNT;

    EXCEPTION
        WHEN OTHERS THEN
            IF CUORDERITEM%ISOPEN THEN
                CLOSE CUORDERITEM;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETELEMTYPEBYORDERITEMCLASS;

    
















    PROCEDURE GETELEMENTSBYORDER (
                                    INUORDERID       IN OR_ORDER_ITEMS.ORDER_ID%TYPE,
                                    OTBELEMENTS     OUT TBELEMENTS
                                 )
    IS
        NUINDEX BINARY_INTEGER;

        CURSOR CUORDERITEM
        (
            NUORDERID       OR_ORDER_ITEMS.ORDER_ID%TYPE
        )
        IS
            SELECT OR_ORDER_ITEMS.ORDER_ITEMS_ID, GE_ITEMS.USE_, OR_ORDER_ITEMS.ELEMENT_CODE,
                   OR_ORDER_ITEMS.ELEMENT_ID, GE_ITEMS.ELEMENT_TYPE_ID
              FROM OR_ORDER_ITEMS, GE_ITEMS
             WHERE OR_ORDER_ITEMS.ITEMS_ID = GE_ITEMS.ITEMS_ID
               AND GE_ITEMS.ITEM_CLASSIF_ID IN (OR_BOCONSTANTS.CNUITEMS_CLASS_TO_ELEM_INST,OR_BOCONSTANTS.CNUITEMS_CLASS_TO_ELEM_RET)
               AND OR_ORDER_ITEMS.ORDER_ID = NUORDERID;
    BEGIN
        OTBELEMENTS.DELETE;

        FOR RC IN CUORDERITEM(INUORDERID) LOOP
            NUINDEX := RC.ORDER_ITEMS_ID;

            OTBELEMENTS(NUINDEX).ACTION                 := RC.USE_;
            OTBELEMENTS(NUINDEX).CODE                   := RC.ELEMENT_CODE;
            OTBELEMENTS(NUINDEX).ELEMENT_ID             := RC.ELEMENT_ID;
            OTBELEMENTS(NUINDEX).ELEMENT_TYPE_ID        := RC.ELEMENT_TYPE_ID;
            OTBELEMENTS(NUINDEX).ORDER_ID               := INUORDERID;

            IF RC.ELEMENT_ID IS NOT NULL THEN
                IF DAIF_ELEMENT_TYPE.FNUGETELEMENT_GROUP_ID(RC.ELEMENT_TYPE_ID) = 1 THEN
                    OTBELEMENTS(NUINDEX).CLASS_ID           := DAIF_NODE.FNUGETCLASS_ID(RC.ELEMENT_ID);
                    OTBELEMENTS(NUINDEX).COMPOSITE_CODE     := DAIF_NODE.FSBGETCOMPOSITE_CODE(RC.ELEMENT_ID);
                    OTBELEMENTS(NUINDEX).OPERATING_SECTOR_ID:= DAIF_NODE.FNUGETOPERATING_SECTOR_ID(RC.ELEMENT_ID);
                    OTBELEMENTS(NUINDEX).SOURCE_            := NULL;
                ELSE
                    OTBELEMENTS(NUINDEX).CLASS_ID           := DAIF_ASSIGNABLE.FNUGETCLASS_ID(RC.ELEMENT_ID);
                    OTBELEMENTS(NUINDEX).COMPOSITE_CODE     := DAIF_ASSIGNABLE.FSBGETCOMPOSITE_CODE(RC.ELEMENT_ID);
                    OTBELEMENTS(NUINDEX).OPERATING_SECTOR_ID:= DAIF_ASSIGNABLE.FNUGETOPERATING_SECTOR_ID(RC.ELEMENT_ID);
                    OTBELEMENTS(NUINDEX).SOURCE_            := DAIF_ASSIGNABLE.FSBGETSOURCE_(RC.ELEMENT_ID);
                END IF;
            END IF;
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            IF CUORDERITEM%ISOPEN THEN
                CLOSE CUORDERITEM;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETELEMENTSBYORDER;

    
    
    
    PROCEDURE GETBASICSITEMS (
                                INUORDERID    IN OR_ORDER_ITEMS.ORDER_ID%TYPE,
                                OTBITEMS     OUT TBITEMS
                             )

    IS
        CURSOR CUORDERITEMS
        (
            NUORDERID       OR_ORDER_ITEMS.ORDER_ID%TYPE
        )
        IS
            SELECT
                OR_ORDER_ITEMS.ORDER_ID,
                OR_ORDER_ITEMS.ITEMS_ID,
                OR_ORDER_ITEMS.ASSIGNED_ITEM_AMOUNT,
                OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT,
                OR_ORDER_ITEMS.VALUE,
                OR_ORDER_ITEMS.ORDER_ITEMS_ID
            FROM  OR_ORDER_ITEMS, GE_ITEMS
            WHERE OR_ORDER_ITEMS.ITEMS_ID = GE_ITEMS.ITEMS_ID
              AND GE_ITEMS.ITEM_CLASSIF_ID  NOT IN (OR_BOCONSTANTS.CNUITEMS_CLASS_TO_ACTIVITY,
                                           OR_BOCONSTANTS.CNUITEMS_CLASS_TO_ELEM_INST,
                                           OR_BOCONSTANTS.CNUITEMS_CLASS_TO_ELEM_RET)
              AND  OR_ORDER_ITEMS.ORDER_ID = NUORDERID;
    BEGIN
        OPEN  CUORDERITEMS(INUORDERID);
        FETCH CUORDERITEMS  BULK COLLECT INTO OTBITEMS;
        CLOSE CUORDERITEMS;

    EXCEPTION
        WHEN OTHERS THEN
            IF CUORDERITEMS%ISOPEN THEN
                CLOSE CUORDERITEMS;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETBASICSITEMS;

    
    
    
    FUNCTION FNUVALUEITEMORDER
    (
        INUORDERID  IN  OR_ORDER_ITEMS.ORDER_ID%TYPE,
        INUITEMSID  IN  OR_ORDER_ITEMS.ITEMS_ID%TYPE
    )
    RETURN  OR_ORDER_ITEMS.VALUE%TYPE
    IS
        NUVALUE    OR_ORDER_ITEMS.VALUE%TYPE;

        CURSOR CUGETITEMS
        IS
        SELECT ITEMS_ID, SUM(VALUE) VALOR FROM OR_ORDER_ITEMS
            WHERE ORDER_ID = INUORDERID
                AND ITEMS_ID = INUITEMSID
                GROUP BY ITEMS_ID;

    BEGIN
        FOR RGITEMS IN CUGETITEMS LOOP
            NUVALUE := RGITEMS.VALOR;
        END LOOP;

        RETURN NVL(NUVALUE,0);
    EXCEPTION
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUVALUEITEMORDER;

    
    
    
    FUNCTION FNUVALUEITEMORDER
    (
        INUORDERID  IN  OR_ORDER_ITEMS.ORDER_ID%TYPE,
        INUITEMSID  IN  OR_ORDER_ITEMS.ITEMS_ID%TYPE,
        ONUAMOUNT   OUT OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT%TYPE
    )
    RETURN  OR_ORDER_ITEMS.VALUE%TYPE
    IS
        NUVALUE    OR_ORDER_ITEMS.VALUE%TYPE;

        CURSOR CUGETITEMS
        IS
        SELECT ITEMS_ID, SUM(VALUE) VALOR, SUM(LEGAL_ITEM_AMOUNT) CANTIDAD FROM OR_ORDER_ITEMS
            WHERE ORDER_ID = INUORDERID
                AND ITEMS_ID = INUITEMSID
                GROUP BY ITEMS_ID;

    BEGIN
        FOR RGITEMS IN CUGETITEMS LOOP
            NUVALUE := RGITEMS.VALOR;
            ONUAMOUNT := RGITEMS.CANTIDAD;
        END LOOP;

        RETURN NVL(NUVALUE,0);
    EXCEPTION
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUVALUEITEMORDER;

    












    PROCEDURE GETEQUIPMENTBYACTIVI
    (
        INUORDERACTIVITYID  IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        OTBEQUIPMENT         OUT TYTBEQUIPMENT
    )
    IS
        CURSOR CUEQUIPMENTBYACTIVI
        IS
           SELECT ORDER_ACTIVITY_ID,
                  SERIAL_ITEMS_ID,
                  SERIE,
                  OUT_,
                  LEGAL_ITEM_AMOUNT,
                  ITEMS_ID
            FROM  OR_ORDER_ITEMS
            WHERE SERIAL_ITEMS_ID IS NOT NULL
              AND ORDER_ACTIVITY_ID = INUORDERACTIVITYID;
    BEGIN
        TBEQUIPMENT.DELETE;
        OPEN  CUEQUIPMENTBYACTIVI;
        FETCH CUEQUIPMENTBYACTIVI  BULK COLLECT INTO TBEQUIPMENT;
        CLOSE CUEQUIPMENTBYACTIVI;

        OTBEQUIPMENT := TBEQUIPMENT;
    EXCEPTION
        WHEN OTHERS THEN
            IF CUEQUIPMENTBYACTIVI%ISOPEN THEN
                CLOSE CUEQUIPMENTBYACTIVI;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETEQUIPMENTBYACTIVI;

     
    
    
    PROCEDURE GETELEMENTCHANGE
    (
        INUACTIVITYID   IN  OR_ORDER_ITEMS.ORDER_ACTIVITY_ID%TYPE,
        OTBELEMENTS   OUT NOCOPY  TYTBELEMENTCHANGE
    )
    IS
        
        CURSOR CUELEMENTS IS
            SELECT
                OR_ORDER_ITEMS.ITEMS_ID , OR_ORDER_ITEMS.ELEMENT_CODE ,OR_ORDER_ITEMS.ELEMENT_ID, GE_ITEMS.USE_
            FROM GE_ITEMS,OR_ORDER_ITEMS
            WHERE
                GE_ITEMS.ITEMS_ID = OR_ORDER_ITEMS.ITEMS_ID
                AND OR_ORDER_ITEMS.ELEMENT_CODE IS NOT NULL
                AND OR_ORDER_ITEMS.ORDER_ACTIVITY_ID = INUACTIVITYID;
    BEGIN

        UT_TRACE.TRACE('Numero de la actividad: '||INUACTIVITYID);

        
        IF CUELEMENTS%ISOPEN THEN
            CLOSE CUELEMENTS;
        END IF;

        
        OTBELEMENTS.DELETE;

        
        OPEN CUELEMENTS;

        
        FETCH CUELEMENTS BULK COLLECT INTO OTBELEMENTS;

        
        CLOSE CUELEMENTS;

    EXCEPTION
        WHEN OTHERS THEN
            IF CUELEMENTS%ISOPEN THEN
                CLOSE CUELEMENTS;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETELEMENTCHANGE;

    















    FUNCTION FNUGETORDITEBYORDSER
    (
        INUORDERID      IN  OR_ORDER_ITEMS.ORDER_ID%TYPE,
        INUSERIALITEMID IN  OR_ORDER_ITEMS.SERIAL_ITEMS_ID%TYPE
    ) RETURN OR_ORDER_ITEMS.ORDER_ITEMS_ID%TYPE
    IS
        NUDATA  OR_ORDER_ITEMS.ORDER_ITEMS_ID%TYPE;
        CURSOR CURECORD
    	IS
    		SELECT /*+ index(or_order_items IDX_OR_ORDER_ITEMS_01) */
                   OR_ORDER_ITEMS.ORDER_ITEMS_ID
    		FROM   OR_ORDER_ITEMS /*+ OR_BCOrderItems.fnuGetOrdIteByOrdSer */
    		WHERE  ORDER_ID = INUORDERID
              AND  SERIAL_ITEMS_ID = INUSERIALITEMID;

        PROCEDURE CLOSECURSORS IS
        BEGIN
            IF CURECORD%ISOPEN THEN CLOSE CURECORD; END IF;
        END CLOSECURSORS;
	BEGIN
        OPEN CURECORD;
        FETCH CURECORD INTO NUDATA;
        CLOSE CURECORD;

		RETURN NUDATA;
    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
    		CLOSECURSORS;
			RAISE;
        WHEN OTHERS THEN
            CLOSECURSORS;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETORDITEBYORDSER;

    














    FUNCTION FTBGETORDERITEMS
    (
        INUORDID    IN  OR_ORDER_ITEMS.ORDER_ID%TYPE
    )
    RETURN DAOR_ORDER_ITEMS.TYTBOR_ORDER_ITEMS
    IS
        CURFGETDATA         CONSTANTS.TYREFCURSOR;
        TBOR_ORDER_ITEMS    DAOR_ORDER_ITEMS.TYTBOR_ORDER_ITEMS;
    BEGIN
    
        UT_TRACE.TRACE('Inicio OR_BCOrderItems.ftbGetOrderItems ['||INUORDID||']',10);

        IF (CURFGETDATA%ISOPEN) THEN
            CLOSE CURFGETDATA;
        END IF;

        OPEN CURFGETDATA FOR
            SELECT /*+ OR_BCOrderItems.ftbGetOrderItems */
                   OR_ORDER_ITEMS.*, OR_ORDER_ITEMS.ROWID
              FROM OR_ORDER_ITEMS
             WHERE OR_ORDER_ITEMS.ORDER_ID = INUORDID;

        FETCH CURFGETDATA BULK COLLECT INTO TBOR_ORDER_ITEMS;
        CLOSE CURFGETDATA;

        UT_TRACE.TRACE('Fin OR_BCOrderItems.ftbGetOrderItems ',10);
        RETURN TBOR_ORDER_ITEMS;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END FTBGETORDERITEMS;

    


















    PROCEDURE GETORDERALLITEMBYORD
    (
      INUORDERID   IN OR_ORDER_ITEMS.ORDER_ID%TYPE,
      OTBORDERITEM OUT NOCOPY OR_BCORDERITEMS.TYTBORDERITEMS
    )
    IS
        SBINDEX VARCHAR2(32);

        CURSOR CUORDERITEM
        (
            NUORDERID       OR_ORDER_ITEMS.ORDER_ID%TYPE
        )
        IS
            SELECT OR_ORDER_ITEMS.ORDER_ITEMS_ID,
                   OR_ORDER_ITEMS.ORDER_ID, OR_ORDER_ITEMS.ITEMS_ID,
                   OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT
            FROM  OR_ORDER_ITEMS
            WHERE OR_ORDER_ITEMS.ORDER_ID = NUORDERID;

        PROCEDURE CLOSECURSORS IS
        BEGIN
            IF CUORDERITEM%ISOPEN THEN CLOSE CUORDERITEM; END IF;
        END;

    BEGIN
        
        UT_TRACE.TRACE('INICIO OR_BCOrderItems.GetOrderAllItemByOrd',15);

        OTBORDERITEM.DELETE;

        FOR RCORDERITEMS IN CUORDERITEM(INUORDERID) LOOP
            SBINDEX := RCORDERITEMS.ORDER_ITEMS_ID;
            OTBORDERITEM(SBINDEX).NUORDERITEMSID := RCORDERITEMS.ORDER_ITEMS_ID;
            OTBORDERITEM(SBINDEX).NUORDERID := RCORDERITEMS.ORDER_ID;
            OTBORDERITEM(SBINDEX).NUITEMSID := RCORDERITEMS.ITEMS_ID;
            OTBORDERITEM(SBINDEX).NULEGALITEMAMOUNT := RCORDERITEMS.LEGAL_ITEM_AMOUNT;
        END LOOP;

        UT_TRACE.TRACE('FIN OR_BCOrderItems.GetOrderAllItemByOrd',15);
    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
    		CLOSECURSORS;
			RAISE;
        WHEN OTHERS THEN
            CLOSECURSORS;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    
















    PROCEDURE UPDLEGALITEMAMOUNT
    (
        INUORDERID      IN  OR_ORDER.ORDER_ID%TYPE,
        INUSERIALITEMID IN  GE_ITEMS_SERIADO.SERIE%TYPE,
        INUAMOUNT       IN  OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT%TYPE
    )
    IS
    BEGIN

        
        UPDATE OR_ORDER_ITEMS
        SET    LEGAL_ITEM_AMOUNT = INUAMOUNT
        WHERE  ORDER_ID = INUORDERID
               AND SERIAL_ITEMS_ID = INUSERIALITEMID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDLEGALITEMAMOUNT;
    
    
    













    FUNCTION FBLEXISTITEMORDER
    (
        INUORDERID  IN  OR_ORDER.ORDER_ID%TYPE,
        INUITEMSID  IN  GE_ITEMS.ITEMS_ID%TYPE
    ) RETURN BOOLEAN
    IS
        
        SBVAR       VARCHAR2(1);
        
        CURSOR CUORDERITEMEXIST
        (
            INUORDER  OR_ORDER.ORDER_ID%TYPE,
            INUITEMS  GE_ITEMS.ITEMS_ID%TYPE
        )
        IS
            SELECT 'X'
            FROM OR_ORDER_ITEMS
            WHERE OR_ORDER_ITEMS.ORDER_ID = INUORDER
            AND OR_ORDER_ITEMS.ITEMS_ID = INUITEMS;
    BEGIN
        
        UT_TRACE.TRACE( 'INICIO OR_BCOrderItems.fblExistItemOrder', 7 );

        OPEN CUORDERITEMEXIST(INUORDERID,INUITEMSID);
        FETCH CUORDERITEMEXIST INTO SBVAR;

        IF CUORDERITEMEXIST%FOUND THEN
            CLOSE CUORDERITEMEXIST;
            UT_TRACE.TRACE( 'FIN OR_BCOrderItems.fblExistItemOrder [return true]', 7 );
            RETURN TRUE;
        END IF;
        
        CLOSE CUORDERITEMEXIST;
        
        UT_TRACE.TRACE( 'FIN OR_BCOrderItems.fblExistItemOrder', 7 );
        RETURN FALSE;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBLEXISTITEMORDER;

    

















    PROCEDURE UPDLEGITEMAMOUNTCOLL
    (
        ITBORDERITEMS   IN  GE_TYTBNUMBER,
        INUAMOUNT       IN  OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT%TYPE
    )
    IS
    BEGIN
    
        UT_TRACE.TRACE( 'OR_BCOrderItems.UpdLegItemAmountColl', 15 );
    
        UPDATE  /*+ index( a PK_OR_ORDER_ITEMS ) */
                OR_ORDER_ITEMS A
        SET     A.LEGAL_ITEM_AMOUNT = INUAMOUNT
        WHERE   A.ORDER_ITEMS_ID IN
        (   SELECT  ID
            FROM    TABLE( CAST( ITBORDERITEMS AS GE_TYTBNUMBER ) )
        );

        UT_TRACE.TRACE( 'Fin OR_BCOrderItems.UpdLegItemAmountColl', 15 );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDLEGITEMAMOUNTCOLL;

    
















    PROCEDURE GETORDERACTIVITIES
    (
        INUORDER        IN  OR_ORDER.ORDER_ID%TYPE,
        OTBACTIVITIES   OUT NOCOPY DAOR_ORDER_ACTIVITY.TYTBOR_ORDER_ACTIVITY
    )
    IS
        
        
        
        CNUACTIVITY_TYPE    CONSTANT NUMBER := 2;
        
        
        
        CURSOR CUACTIVITIES
        IS  SELECT  /*+ leading( a )
                        index( a IDX_OR_ORDER_ACTIVITY_05 )
                        index( oi PK_OR_ORDER_ITEMS )
                        index( i PK_GE_ITEMS ) */
                    A.*, A.ROWID
            FROM    OR_ORDER_ACTIVITY A, OR_ORDER_ITEMS OI, GE_ITEMS I
            WHERE   A.ORDER_ID = INUORDER
            AND     A.ORDER_ITEM_ID = OI.ORDER_ITEMS_ID
            AND     OI.ITEMS_ID = I.ITEMS_ID
            AND     I.ITEM_CLASSIF_ID = CNUACTIVITY_TYPE;
    BEGIN

        UT_TRACE.TRACE( 'OR_BCOrderItems.GetOrderActivities', 15 );

        OPEN CUACTIVITIES;
        FETCH CUACTIVITIES BULK COLLECT INTO OTBACTIVITIES;
        CLOSE CUACTIVITIES;

        UT_TRACE.TRACE( 'Fin OR_BCOrderItems.GetOrderActivities', 15 );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETORDERACTIVITIES;
    
    
    

















    FUNCTION FNUGETTOTALITEMVALUE
    (
        INUORDERID IN OR_ORDER.ORDER_ID%TYPE
    )
    RETURN OR_ORDER.ESTIMATED_COST%TYPE
    IS
        NUTOTALVALUE    OR_ORDER.ESTIMATED_COST%TYPE;
        
        CURSOR CUGETVALUE IS
        SELECT SUM(DECODE(NVL(OUT_,'Y'), 'N', -VALUE, VALUE))
            FROM OR_ORDER_ITEMS
            WHERE ORDER_ID = INUORDERID;
    BEGIN
    
        OPEN CUGETVALUE;
        FETCH CUGETVALUE INTO NUTOTALVALUE;
        CLOSE CUGETVALUE;
        
        RETURN NVL(NUTOTALVALUE, 0);
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETTOTALITEMVALUE;
    
    

END OR_BCORDERITEMS;