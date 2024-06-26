PACKAGE BODY OR_BOOpeUniItemBala AS





























































    
    
    
    
    
    
    CSBVERSION   CONSTANT VARCHAR2(20)            := 'SAO403481';
    
    CNUBALANCEQUOTAERROR CONSTANT NUMBER := 111943;
    
    CNUERRORBALANCENOLESSCERO  CONSTANT NUMBER := 5182;
    
    CSBXML_MOVE_CAUSE CONSTANT VARCHAR2(100) := 'XML_MOVE_CAUSE';
    
    
    CNUERR_114651   CONSTANT NUMBER(6) := 114651;
    
    
    CNUERR_114652   CONSTANT NUMBER(6) := 114652;
    
    CNUQUOTA_LESS_THAN_CERO   CONSTANT NUMBER(6) := 10765;
    
    CNUOCC_QUOTA_LESS_CERO   CONSTANT NUMBER(6) := 10766;
    
    CNUERR_1965    CONSTANT NUMBER(6) := 1965;
    
    
    CNUERR_14767    CONSTANT NUMBER(6) := 14767;
     
    CNUMAXQUOTA CONSTANT OR_OPE_UNI_ITEM_BALA.QUOTA%TYPE := 999999.9999;
    
    
    CNUERR_114656  CONSTANT NUMBER(6) := 114656;
    
    CNUERR_114657  CONSTANT NUMBER(6) := 114657;

    CNUMAX_999999_99 CONSTANT OR_OPE_UNI_ITEM_BALA.BALANCE%TYPE := 999999.9999;
    CNUMAX_99999999999_99 CONSTANT OR_OPE_UNI_ITEM_BALA.TOTAL_COSTS%TYPE := 99999999999.99;

    
    
    
    
    
    
    
    
    
    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
    
        RETURN CSBVERSION;
    
    END;
    
    
    
    
    PROCEDURE ADDBALANCETOOPEUNIITEM
    (
        INUITEMSID       IN OR_OPE_UNI_ITEM_BALA.ITEMS_ID%TYPE,
        INUOPERATINGUNIT IN OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID%TYPE,
        INUMOVEMENTCAUSE IN OR_ITEM_MOVEME_CAUS.ITEM_MOVEME_CAUS_ID%TYPE DEFAULT -1,
        INUADDBALANCE    IN OR_OPE_UNI_ITEM_BALA.BALANCE%TYPE DEFAULT 1
    )
    IS
        NUOLDBALANCE       OR_OPE_UNI_ITEM_BALA.BALANCE%TYPE;
        NUNEWBALANCE       OR_OPE_UNI_ITEM_BALA.BALANCE%TYPE;
        RCOPEUNIITEMBALA   DAOR_OPE_UNI_ITEM_BALA.STYOR_OPE_UNI_ITEM_BALA;
    BEGIN

        UT_TRACE.TRACE('OR_BOOpeUniItemBala.AddBalanceToOpeUniItem INICIO');

        
        DAOR_OPE_UNI_ITEM_BALA.GETRECORD (INUITEMSID, INUOPERATINGUNIT, RCOPEUNIITEMBALA);

        
        NUOLDBALANCE := RCOPEUNIITEMBALA.BALANCE;
        
        NUNEWBALANCE := NUOLDBALANCE + INUADDBALANCE;

        UT_TRACE.TRACE('OR_BOOpeUniItemBala.AddBalanceToOpeUniItem inuItemsId:['||INUITEMSID||']');
        UT_TRACE.TRACE('OR_BOOpeUniItemBala.AddBalanceToOpeUniItem inuOperatingUnit:['||INUOPERATINGUNIT||']');
        UT_TRACE.TRACE('OR_BOOpeUniItemBala.AddBalanceToOpeUniItem inuMovementCause:['||INUMOVEMENTCAUSE||']');
        UT_TRACE.TRACE('OR_BOOpeUniItemBala.AddBalanceToOpeUniItem nuNewBalance:['||NUNEWBALANCE||']');
        UT_TRACE.TRACE('OR_BOOpeUniItemBala.AddBalanceToOpeUniItem nuQuota:['||RCOPEUNIITEMBALA.QUOTA||']');
        UT_TRACE.TRACE('OR_BOOpeUniItemBala.AddBalanceToOpeUniItem nuQuota Ocacional:['||RCOPEUNIITEMBALA.OCCACIONAL_QUOTA||']');

        
        IF NUNEWBALANCE > RCOPEUNIITEMBALA.QUOTA + RCOPEUNIITEMBALA.OCCACIONAL_QUOTA THEN
            
            ERRORS.SETERROR(CNUBALANCEQUOTAERROR,INUOPERATINGUNIT||'|'||INUITEMSID);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        IF ( NUNEWBALANCE < 0 ) THEN
            
            ERRORS.SETERROR
            (
                CNUERRORBALANCENOLESSCERO,
                DAOR_OPERATING_UNIT.FSBGETNAME( INUOPERATINGUNIT )||'|'||
                NUNEWBALANCE||'|'||
                DAGE_ITEMS.FSBGETDESCRIPTION( INUITEMSID )
            );
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        OR_BOITEMS.INSERTINTEMTAB( INUMOVEMENTCAUSE );

        
        DAOR_OPE_UNI_ITEM_BALA.UPDBALANCE( INUITEMSID,INUOPERATINGUNIT,NUNEWBALANCE );

        UT_TRACE.TRACE('OR_BOOpeUniItemBala.AddBalanceToOpeUniItem FIN');

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    















































    PROCEDURE GETDATAITEMSFORRETIRE
    (
        INUOPERATINGUNITID IN OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID%TYPE,
        INUITEMSID         IN OR_OPE_UNI_ITEM_BALA.ITEMS_ID%TYPE,
        INUQUANTITY        IN OR_OPE_UNI_ITEM_BALA.BALANCE%TYPE,
        INUPRICEQUANTITY   IN OR_OPE_UNI_ITEM_BALA.TOTAL_COSTS%TYPE,
        ONUBALANCE         OUT NUMBER,
        ONUBALANCEPRICE    OUT NUMBER,
        ONUPRICEQUANTITY   OUT NUMBER
    )
    IS
        NUOLDBALANCE       OR_OPE_UNI_ITEM_BALA.BALANCE%TYPE;
        NUNEWBALANCE       OR_OPE_UNI_ITEM_BALA.BALANCE%TYPE;
        NUQUOTA            OR_OPE_UNI_ITEM_BALA.QUOTA%TYPE;
        
        RCOPEUNIITEMBALA   DAOR_OPE_UNI_ITEM_BALA.STYOR_OPE_UNI_ITEM_BALA;

    BEGIN
        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.GetDataItemsForRetire] INICIO. inuOperatingUnitId:['
                        ||TO_CHAR(INUOPERATINGUNITID)   ||'] inuItemsId:['
                        ||TO_CHAR(INUITEMSID)           ||'] inuQuantity:['
                        ||TO_CHAR(INUQUANTITY)||'] inuPriceQuantity:['
                        ||TO_CHAR(INUPRICEQUANTITY)||']',4);

        
        DAOR_OPE_UNI_ITEM_BALA.GETRECORD(INUITEMSID, INUOPERATINGUNITID, RCOPEUNIITEMBALA);

        
        NUNEWBALANCE := RCOPEUNIITEMBALA.BALANCE - INUQUANTITY;
        UT_TRACE.TRACE('[package.metodo] **** nuNewBalance:['||NUNEWBALANCE ||']');

        
        IF ( NUNEWBALANCE < 0 ) THEN
            GE_BOERRORS.SETERRORCODEARGUMENT(CNUERR_1965, TO_CHAR(INUITEMSID)||'|'||TO_CHAR(INUOPERATINGUNITID));
        END IF;
        
        ONUBALANCE := NUNEWBALANCE;
        
        IF  INUPRICEQUANTITY IS NULL THEN
            
            IF RCOPEUNIITEMBALA.BALANCE = 0 THEN
                ONUPRICEQUANTITY := RCOPEUNIITEMBALA.TOTAL_COSTS * INUQUANTITY;
            ELSE
                ONUPRICEQUANTITY := RCOPEUNIITEMBALA.TOTAL_COSTS * INUQUANTITY / RCOPEUNIITEMBALA.BALANCE;
            END IF;

            
            
            
            
            IF  GE_BOPARAMETER.FSBGET('COST_PROM_UNID_SERV') != GE_BOCONSTANTS.CSBYES
                AND NVL(DAOR_OPERATING_UNIT.FSBGETES_EXTERNA(INUOPERATINGUNITID),GE_BOCONSTANTS.CSBNO) =
                    GE_BOCONSTANTS.CSBNO THEN
                ONUPRICEQUANTITY := OR_BCITEMSMOVE.FNUGETAVGCOSTALLUNISERV(INUITEMSID)* INUQUANTITY;
            END IF;

            
            ONUBALANCEPRICE := (RCOPEUNIITEMBALA.TOTAL_COSTS  -  ONUPRICEQUANTITY);

        ELSE
            ONUPRICEQUANTITY := INUPRICEQUANTITY;
            
            ONUBALANCEPRICE := RCOPEUNIITEMBALA.TOTAL_COSTS - ONUPRICEQUANTITY;
        END IF;
        

        IF ONUBALANCE > CNUMAX_999999_99 THEN
            
            ONUBALANCE := CNUMAX_999999_99;
        END IF;

        IF ONUBALANCEPRICE > CNUMAX_99999999999_99 THEN
            
            ONUBALANCEPRICE := CNUMAX_99999999999_99;
        END IF;
        
        IF ONUPRICEQUANTITY > CNUMAX_99999999999_99 THEN
            
            ONUPRICEQUANTITY := CNUMAX_99999999999_99;
        END IF;

        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.GetDataItemsForRetire] onuBalance:['||ONUBALANCE||
                       '] onuBalancePrice:['||ONUBALANCEPRICE||
                       '] onuPriceQuantity:['||ONUPRICEQUANTITY||'] ',4);
        
        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.GetDataItemsForRetire] FIN',3);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    


































    PROCEDURE GETDATAITEMSFORADD
    (
        INUOPERATINGUNITID IN OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID%TYPE,
        INUITEMSID         IN OR_OPE_UNI_ITEM_BALA.ITEMS_ID%TYPE,
        INUQUANTITY        IN OR_OPE_UNI_ITEM_BALA.BALANCE%TYPE,
        INUPRICEQUANTITY   IN OR_OPE_UNI_ITEM_BALA.TOTAL_COSTS%TYPE,
        ONUBALANCE         OUT NUMBER,
        ONUBALANCEPRICE    OUT NUMBER
    )
    IS
        RCOPEUNIITEMBALA   DAOR_OPE_UNI_ITEM_BALA.STYOR_OPE_UNI_ITEM_BALA;
    BEGIN
        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.GetDataItemsForAdd] INCIO'|| CHR(10)||
                       ' inuOperatingUnitId:['||INUOPERATINGUNITID||
                       '] inuItemsId:['||INUITEMSID||
                       '] inuQuantity:['||INUQUANTITY||
                       '] inuPriceQuantity:['||INUPRICEQUANTITY||']',4);

        IF DAGE_ITEMS.FBLEXIST(INUITEMSID) THEN
            
            IF DAOR_OPE_UNI_ITEM_BALA.FBLEXIST(INUITEMSID, INUOPERATINGUNITID) THEN
                DAOR_OPE_UNI_ITEM_BALA.GETRECORD(INUITEMSID, INUOPERATINGUNITID, RCOPEUNIITEMBALA);
            ELSE
                RCOPEUNIITEMBALA.ITEMS_ID := INUITEMSID;
                RCOPEUNIITEMBALA.OPERATING_UNIT_ID := INUOPERATINGUNITID;
                RCOPEUNIITEMBALA.BALANCE := 0;
                RCOPEUNIITEMBALA.TOTAL_COSTS := 0;
                RCOPEUNIITEMBALA.QUOTA := INUQUANTITY;
                RCOPEUNIITEMBALA.OCCACIONAL_QUOTA := NULL;
                DAOR_OPE_UNI_ITEM_BALA.INSRECORD(RCOPEUNIITEMBALA);
            END IF;
            
            ONUBALANCE := RCOPEUNIITEMBALA.BALANCE + INUQUANTITY;
            
            ONUBALANCEPRICE := RCOPEUNIITEMBALA.TOTAL_COSTS + NVL(INUPRICEQUANTITY, 0);
        ELSE
            ONUBALANCE := INUQUANTITY;
            ONUBALANCEPRICE  := INUPRICEQUANTITY;
        END IF;


        IF ONUBALANCE > CNUMAX_999999_99 THEN
            
            ONUBALANCE := CNUMAX_999999_99;
        END IF;

        IF  ONUBALANCE < 0  THEN
            
            ONUBALANCE := 0;
         END IF;
        
        IF  ONUBALANCEPRICE < 0 THEN
            ONUBALANCEPRICE := 0;
        END IF;

        IF ONUBALANCEPRICE > CNUMAX_99999999999_99 THEN
            
            ONUBALANCEPRICE := CNUMAX_99999999999_99;
        END IF;


        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.GetDataItemsForAdd] onuBalance:['||ONUBALANCE||
                       '] onuBalancePrice:['||ONUBALANCEPRICE||']',4);

        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.GetDataItemsForAdd] FIN',3);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE SETBALANANDPRICETOOPEUNIITEM
    (
        INUOPERATINGUNITID IN OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID%TYPE,
        INUITEMSID         IN OR_OPE_UNI_ITEM_BALA.ITEMS_ID%TYPE,
        INUQUANTITY        IN OR_OPE_UNI_ITEM_BALA.BALANCE%TYPE,
        INUPRICEQUANTITY   IN OR_OPE_UNI_ITEM_BALA.TOTAL_COSTS%TYPE
    )
    IS
        RCOPEUNIITEMBALA   DAOR_OPE_UNI_ITEM_BALA.STYOR_OPE_UNI_ITEM_BALA;
    BEGIN
        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.SetBalanAndPriceToOpeUniItem] INCIO'||CHR(10)||
                       ' inuOperatingUnitId:['||INUOPERATINGUNITID||
                       '] inuItemsId:['||INUITEMSID||
                       '] inuQuantity:['||INUQUANTITY||
                       '] inuPriceQuantity:['||INUPRICEQUANTITY||']',4);
        
        
        DAOR_OPE_UNI_ITEM_BALA.UPDBALANCE(INUITEMSID, INUOPERATINGUNITID, INUQUANTITY);
        DAOR_OPE_UNI_ITEM_BALA.UPDTOTAL_COSTS(INUITEMSID, INUOPERATINGUNITID, INUPRICEQUANTITY);
        DAOR_OPE_UNI_ITEM_BALA.UPDOCCACIONAL_QUOTA(INUITEMSID, INUOPERATINGUNITID, 0);

        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.SetBalanAndPriceToOpeUniItem] FIN',3);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    PROCEDURE ADDITEMBALANOTEXIST
    (
        INUOPERATINGUNITID IN OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID%TYPE,
        INUITEMSID         IN OR_OPE_UNI_ITEM_BALA.ITEMS_ID%TYPE
    )
    IS
        RCOPEUNIITEMBALA   DAOR_OPE_UNI_ITEM_BALA.STYOR_OPE_UNI_ITEM_BALA;

    BEGIN
        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.GetDataItemsForRetire] INICIO',3);

        DAGE_ITEMS.ACCKEY(INUITEMSID);
        DAOR_OPERATING_UNIT.ACCKEY(INUOPERATINGUNITID);

        IF DAOR_OPE_UNI_ITEM_BALA.FBLEXIST(INUITEMSID, INUOPERATINGUNITID) THEN
            RETURN;
        END IF;
        
        RCOPEUNIITEMBALA.OPERATING_UNIT_ID := INUOPERATINGUNITID;
        RCOPEUNIITEMBALA.ITEMS_ID :=  INUITEMSID;
        RCOPEUNIITEMBALA.BALANCE := 0;
        RCOPEUNIITEMBALA.QUOTA := CNUMAXQUOTA;
        RCOPEUNIITEMBALA.TOTAL_COSTS := 0;

        DAOR_OPE_UNI_ITEM_BALA.INSRECORD( RCOPEUNIITEMBALA );

        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.GetDataItemsForRetire] FIN',3);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    















































    PROCEDURE UPDBALANCE
    (
        INUITEM    IN OR_OPE_UNI_ITEM_BALA.ITEMS_ID%TYPE,
        INUOPEUNI  IN OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID%TYPE,
        INUAMOUNT  IN OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT%TYPE,
        ISBOUT_    IN OR_ORDER_ITEMS.OUT_%TYPE DEFAULT NULL
    )
    IS
        NUGETITEMCLASSIFID GE_ITEMS.ITEM_CLASSIF_ID%TYPE;
        RCOPEUNIITEMBALA   DAOR_OPE_UNI_ITEM_BALA.STYOR_OPE_UNI_ITEM_BALA;
        SBQUANTITYCONTROL  GE_ITEM_CLASSIF.QUANTITY_CONTROL%TYPE;
        SBDECREASE         OR_ORDER_ITEMS.OUT_%TYPE;
    BEGIN
        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.UpdBalance] INICIO',4);
        UT_TRACE.TRACE('inuItem:['||INUITEM||'] inuOpeUni:['||INUOPEUNI||'] inuAmount:['||INUAMOUNT ||']',4);

        
        NUGETITEMCLASSIFID := DAGE_ITEMS.FNUGETITEM_CLASSIF_ID(INUITEM);
        SBQUANTITYCONTROL := DAGE_ITEM_CLASSIF.FSBGETQUANTITY_CONTROL(NUGETITEMCLASSIFID);


        IF (SBQUANTITYCONTROL <> 'N') THEN
        
            IF ISBOUT_ IS NULL THEN
                IF SBQUANTITYCONTROL  = OR_BOCONSTANTS.CNUDECREASE THEN
                    SBDECREASE := GE_BOCONSTANTS.CSBYES;
                END IF;
                IF SBQUANTITYCONTROL  = OR_BOCONSTANTS.CNUINCREASE THEN
                    SBDECREASE := GE_BOCONSTANTS.CSBNO;
                END IF;
            ELSE
                SBDECREASE := ISBOUT_;
            END IF;

            
            IF DAOR_OPE_UNI_ITEM_BALA.FBLEXIST(INUITEM, INUOPEUNI) THEN
                
                DAOR_OPE_UNI_ITEM_BALA.GETRECORD(INUITEM, INUOPEUNI, RCOPEUNIITEMBALA);
                
                
                IF (SBDECREASE  = GE_BOCONSTANTS.CSBYES) THEN
                    RCOPEUNIITEMBALA.BALANCE := RCOPEUNIITEMBALA.BALANCE - INUAMOUNT;
                ELSIF (SBDECREASE  = GE_BOCONSTANTS.CSBNO)  THEN
                    RCOPEUNIITEMBALA.BALANCE := RCOPEUNIITEMBALA.BALANCE + INUAMOUNT;
                END IF;

                
                IF ( RCOPEUNIITEMBALA.BALANCE < 0 ) THEN
                    RCOPEUNIITEMBALA.BALANCE := 0;
                    IF ( DAGE_ITEM_CLASSIF.FSBGETQUOTA(NUGETITEMCLASSIFID) <> 'N' ) THEN
                        
                        ERRORS.SETERROR
                        (
                            CNUERRORBALANCENOLESSCERO,
                            DAOR_OPERATING_UNIT.FSBGETNAME( INUOPEUNI )||'|'||
                            RCOPEUNIITEMBALA.BALANCE||'|'||
                            DAGE_ITEMS.FSBGETDESCRIPTION( INUITEM )
                        );
                        RAISE EX.CONTROLLED_ERROR;
                    END IF;
                END IF;

                
                DAOR_OPE_UNI_ITEM_BALA.UPDBALANCE(INUITEM,INUOPEUNI,RCOPEUNIITEMBALA.BALANCE);
            END IF;
        END IF;
        
        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.UpdBalance] FIN',3);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDBALANCE;

    
    PROCEDURE VALIDATEQUOTAS
    (
        INUITEM    IN OR_OPE_UNI_ITEM_BALA.ITEMS_ID%TYPE,
        INUOPEUNI  IN OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID%TYPE,
        INUQUOTA   IN OR_OPE_UNI_ITEM_BALA.QUOTA%TYPE,
        INUOCCACIONALQUOTA IN OR_OPE_UNI_ITEM_BALA.OCCACIONAL_QUOTA%TYPE
    )
    IS
        NUBALANCE   OR_OPE_UNI_ITEM_BALA.BALANCE%TYPE;

    BEGIN
        UT_TRACE.TRACE('[GE_BOListUnitaryCost.validateQuotas] INICIO', 2);

        IF INUQUOTA < 0 THEN
            ERRORS.SETERROR(CNUQUOTA_LESS_THAN_CERO);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        IF INUOCCACIONALQUOTA < 0 THEN
            ERRORS.SETERROR(CNUOCC_QUOTA_LESS_CERO);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        NUBALANCE := DAOR_OPE_UNI_ITEM_BALA.FNUGETBALANCE(INUITEM, INUOPEUNI);
        
        IF INUQUOTA + INUOCCACIONALQUOTA < NUBALANCE THEN
            ERRORS.SETERROR(CNUBALANCEQUOTAERROR,INUOPEUNI||'|'||INUITEM);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        IF INUQUOTA > CNUMAX_999999_99 THEN
            
            GE_BOERRORS.SETERRORCODE(CNUERR_114656);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        UT_TRACE.TRACE('[GE_BOListUnitaryCost.validateQuotas] FIN', 2);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    PROCEDURE SETOCCACIONALQUOTA
    (
        INUITEM    IN OR_OPE_UNI_ITEM_BALA.ITEMS_ID%TYPE,
        INUOPEUNI  IN OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID%TYPE,
        INUQUOTA   IN OR_OPE_UNI_ITEM_BALA.QUOTA%TYPE,
        INUOCCACIONALQUOTA IN OR_OPE_UNI_ITEM_BALA.OCCACIONAL_QUOTA%TYPE
    )
    IS
        NUGETITEMCLASSIFID GE_ITEMS.ITEM_CLASSIF_ID%TYPE;
    BEGIN
        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.setOccacionalQuota] INICIO',3);
        
        VALIDATEQUOTAS(INUITEM,
                       INUOPEUNI,
                       INUQUOTA,
                       INUOCCACIONALQUOTA);
        
        DAOR_OPE_UNI_ITEM_BALA.UPDQUOTA(INUITEM, INUOPEUNI, INUQUOTA);
        DAOR_OPE_UNI_ITEM_BALA.UPDOCCACIONAL_QUOTA(INUITEM, INUOPEUNI, INUOCCACIONALQUOTA);
        
        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.setOccacionalQuota] FIN',3);
    EXCEPTION
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETOCCACIONALQUOTA;
    
    
    FUNCTION FNUGETITEMSPRICE
    (
        INUITEMID   IN OR_OPE_UNI_ITEM_BALA.ITEMS_ID%TYPE,
        INUOPEUNIID IN OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID%TYPE,
        INUQUANTITY IN OR_OPE_UNI_ITEM_BALA.BALANCE%TYPE DEFAULT 1
    )
    RETURN NUMBER
    IS
        RCOPEUNIITEMBALA    DAOR_OPE_UNI_ITEM_BALA.STYOR_OPE_UNI_ITEM_BALA;
        NUPRICE             NUMBER;
        NUERRORCODE         GE_MESSAGE.MESSAGE_ID%TYPE;
        SBERRORMESSAGE      GE_MESSAGE.DESCRIPTION%TYPE;
        RCTEMPVALUE         OR_BOITEMSMOVE.TYRCTEMPVALUE;
    BEGIN
        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.fnuGetItemsPrice] INICIO',3);

        IF (NOT DAOR_OPE_UNI_ITEM_BALA.FBLEXIST(INUITEMID, INUOPEUNIID)) THEN
            ERRORS.SETERROR(CNUERR_14767,INUITEMID||'|'||INUOPEUNIID);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        DAOR_OPE_UNI_ITEM_BALA.GETRECORD(INUITEMID, INUOPEUNIID, RCOPEUNIITEMBALA);

        
        IF RCOPEUNIITEMBALA.BALANCE = 0 THEN
            NUPRICE := RCOPEUNIITEMBALA.TOTAL_COSTS * INUQUANTITY;
            
            IF NUPRICE = 0 THEN

                BEGIN
                    RCTEMPVALUE := OR_BOITEMSMOVE.GTBTEMPVALUE(INUITEMID);
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        RCTEMPVALUE.ITEMS_ID := INUITEMID;
                        RCTEMPVALUE.TOTAL_VALUE := 0;
                END;

                IF RCTEMPVALUE.TOTAL_VALUE > 0 THEN
                    NUPRICE := RCTEMPVALUE.TOTAL_VALUE * INUQUANTITY;
                END IF;
            END IF;
            
        ELSE
            NUPRICE := RCOPEUNIITEMBALA.TOTAL_COSTS * INUQUANTITY / RCOPEUNIITEMBALA.BALANCE;
        END IF;

        
        
        
        
        IF  GE_BOPARAMETER.FSBGET('COST_PROM_UNID_SERV') != GE_BOCONSTANTS.CSBYES
            AND NVL(DAOR_OPERATING_UNIT.FSBGETES_EXTERNA(INUOPEUNIID),GE_BOCONSTANTS.CSBNO) =
                GE_BOCONSTANTS.CSBNO THEN
            NUPRICE := OR_BCITEMSMOVE.FNUGETAVGCOSTALLUNISERV(INUITEMID) * INUQUANTITY;
        END IF;
        
        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.fnuGetItemsPrice] FIN',3);
        
        RETURN NUPRICE;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR ;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETITEMSPRICE;

    
    




























    PROCEDURE UPDBALANCESERIALITEM
    (
        INUNEWITEM  IN OR_OPE_UNI_ITEM_BALA.ITEMS_ID%TYPE,
        INUOLDITEM  IN OR_OPE_UNI_ITEM_BALA.ITEMS_ID%TYPE,
        IRCOPERUNIT IN DAGE_ITEMS_SERIADO.STYGE_ITEMS_SERIADO,
        INUAMOUNT   IN OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT%TYPE DEFAULT 1
    )
    IS
        NUGETITEMCLASSIFID          GE_ITEMS.ITEM_CLASSIF_ID%TYPE;
        
        RCUNIITEMBALADECREASE       DAOR_OPE_UNI_ITEM_BALA.STYOR_OPE_UNI_ITEM_BALA;
        
        RCOPEUNIITEMBALAINCREASE    DAOR_OPE_UNI_ITEM_BALA.STYOR_OPE_UNI_ITEM_BALA;
        
        RCOPEUNIITEMBALA            DAOR_OPE_UNI_ITEM_BALA.STYOR_OPE_UNI_ITEM_BALA;
        NUUNITARYCOST               OR_OPE_UNI_ITEM_BALA.TOTAL_COSTS%TYPE;
        
        
        FUNCTION SETUNITARYCOST
        (
            INUTOTALCOST IN  OR_OPE_UNI_ITEM_BALA.TOTAL_COSTS%TYPE,
            INUBALANCE   IN  OR_OPE_UNI_ITEM_BALA.BALANCE%TYPE
        )
        RETURN OR_OPE_UNI_ITEM_BALA.TOTAL_COSTS%TYPE
        IS
            NUCOST   OR_OPE_UNI_ITEM_BALA.TOTAL_COSTS%TYPE := 0;
        BEGIN

            IF(INUBALANCE > 0 AND INUTOTALCOST > 0)THEN
                NUCOST := INUTOTALCOST/INUBALANCE;
            END IF;
            
            RETURN NUCOST;

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END SETUNITARYCOST;
        

    BEGIN
        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.UpdBalanceSerialItem] INICIO',4);
        UT_TRACE.TRACE('inuNewItem:['||INUNEWITEM||']   inuOldItem:['||INUOLDITEM||']  inuOpeUni:['||IRCOPERUNIT.OPERATING_UNIT_ID||'] inuAmount:['||INUAMOUNT ||']',4);

        
        IF DAOR_OPE_UNI_ITEM_BALA.FBLEXIST(INUOLDITEM, IRCOPERUNIT.OPERATING_UNIT_ID) THEN
            
            DAOR_OPE_UNI_ITEM_BALA.GETRECORD(INUOLDITEM, IRCOPERUNIT.OPERATING_UNIT_ID, RCUNIITEMBALADECREASE);
            UT_TRACE.TRACE('existe la cantidad del �tem a RESTAR := '||RCUNIITEMBALADECREASE.BALANCE,15);
            
            NUUNITARYCOST := SETUNITARYCOST(RCUNIITEMBALADECREASE.TOTAL_COSTS, RCUNIITEMBALADECREASE.BALANCE);
            
            RCUNIITEMBALADECREASE.BALANCE := RCUNIITEMBALADECREASE.BALANCE - INUAMOUNT;
            
            RCUNIITEMBALADECREASE.TOTAL_COSTS := NUUNITARYCOST * RCUNIITEMBALADECREASE.BALANCE;
            
            DAOR_OPE_UNI_ITEM_BALA.UPDBALANCE(INUOLDITEM, IRCOPERUNIT.OPERATING_UNIT_ID, RCUNIITEMBALADECREASE.BALANCE);
            DAOR_OPE_UNI_ITEM_BALA.UPDTOTAL_COSTS(INUOLDITEM, IRCOPERUNIT.OPERATING_UNIT_ID, RCUNIITEMBALADECREASE.TOTAL_COSTS);
        END IF;
        
        
        IF DAOR_OPE_UNI_ITEM_BALA.FBLEXIST(INUNEWITEM, IRCOPERUNIT.OPERATING_UNIT_ID) THEN
            
            DAOR_OPE_UNI_ITEM_BALA.GETRECORD(INUNEWITEM, IRCOPERUNIT.OPERATING_UNIT_ID, RCOPEUNIITEMBALAINCREASE);
            UT_TRACE.TRACE('existe la cantidad del �tem a SUMAR := '||RCOPEUNIITEMBALAINCREASE.BALANCE,15);
            
            NUUNITARYCOST := SETUNITARYCOST(RCOPEUNIITEMBALAINCREASE.TOTAL_COSTS, RCOPEUNIITEMBALAINCREASE.BALANCE);
            
            RCOPEUNIITEMBALAINCREASE.BALANCE := RCOPEUNIITEMBALAINCREASE.BALANCE + INUAMOUNT;
            
            RCOPEUNIITEMBALAINCREASE.TOTAL_COSTS := NUUNITARYCOST * RCOPEUNIITEMBALAINCREASE.BALANCE;
            
            DAOR_OPE_UNI_ITEM_BALA.UPDBALANCE(INUNEWITEM, IRCOPERUNIT.OPERATING_UNIT_ID, RCOPEUNIITEMBALAINCREASE.BALANCE);
            DAOR_OPE_UNI_ITEM_BALA.UPDTOTAL_COSTS(INUNEWITEM, IRCOPERUNIT.OPERATING_UNIT_ID, RCOPEUNIITEMBALAINCREASE.TOTAL_COSTS);
        ELSE
            UT_TRACE.TRACE('Lo CREA ',15);
            
            
            
            
            OR_BOOPEUNIITEMBALA.ADDITEMBALANOTEXIST(IRCOPERUNIT.OPERATING_UNIT_ID, INUNEWITEM);

            
            DAOR_OPE_UNI_ITEM_BALA.GETRECORD(INUNEWITEM, IRCOPERUNIT.OPERATING_UNIT_ID, RCOPEUNIITEMBALA);
            
            RCOPEUNIITEMBALA.OPERATING_UNIT_ID := IRCOPERUNIT.OPERATING_UNIT_ID;
            RCOPEUNIITEMBALA.ITEMS_ID :=  INUNEWITEM;
            RCOPEUNIITEMBALA.BALANCE := INUAMOUNT;
            RCOPEUNIITEMBALA.QUOTA := CNUMAXQUOTA;
            RCOPEUNIITEMBALA.TOTAL_COSTS := INUAMOUNT * IRCOPERUNIT.COSTO;
            
            DAOR_OPE_UNI_ITEM_BALA.UPDRECORD( RCOPEUNIITEMBALA );
        END IF;

        UT_TRACE.TRACE('[OR_BOOpeUniItemBala.UpdBalanceSerialItem] FIN',3);
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDBALANCESERIALITEM;
    
    

















    PROCEDURE RESETOCCACIONALQUOTA
    (
        INUITEM    IN OR_OPE_UNI_ITEM_BALA.ITEMS_ID%TYPE,
        INUOPEUNI  IN OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID%TYPE
    )
    IS
        NUGETITEMCLASSIFID GE_ITEMS.ITEM_CLASSIF_ID%TYPE;
    BEGIN
        IF (DAOR_OPE_UNI_ITEM_BALA.FBLEXIST(INUITEM, INUOPEUNI)) THEN
            DAOR_OPE_UNI_ITEM_BALA.UPDOCCACIONAL_QUOTA(INUITEM, INUOPEUNI, 0);
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END RESETOCCACIONALQUOTA;    
    
END OR_BOOPEUNIITEMBALA;