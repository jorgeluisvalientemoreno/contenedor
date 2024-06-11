PACKAGE BODY GE_BCListUnitaryCost AS





























































    
    
    
    
    CSBVERSION  CONSTANT VARCHAR2(20)  := 'SAO212391';

	
    
    

    
    
    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    




















    FUNCTION FNUGETGENERICPRICELIST
    (
         IDTASSIGNED IN GE_LIST_UNITARY_COST.VALIDITY_START_DATE%TYPE DEFAULT NULL
    )
    RETURN GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID%TYPE
    IS
        DTASSIGNED DATE := TRUNC(NVL(IDTASSIGNED,UT_DATE.FDTSYSDATE));

        NURETURN GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID%TYPE;

        CURSOR CUPRICELIST IS
           SELECT /*+ index(GE_LIST_UNITARY_COST IDX_GE_LIST_UNITARY_COST01)*/
                  GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID
             FROM GE_LIST_UNITARY_COST
                  /*+ GE_BCListUnitaryCost.fnuGetGenericPriceList*/
            WHERE GE_LIST_UNITARY_COST.OPERATING_UNIT_ID IS NULL
              AND GE_LIST_UNITARY_COST.CONTRACT_ID IS NULL
              AND GE_LIST_UNITARY_COST.CONTRACTOR_ID IS NULL
              AND GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID IS NULL
              AND DTASSIGNED BETWEEN TRUNC(GE_LIST_UNITARY_COST.VALIDITY_START_DATE)
              AND TRUNC(GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE);

        PROCEDURE CLOSECURSORS
        IS
        BEGIN
             IF CUPRICELIST%ISOPEN THEN
                CLOSE CUPRICELIST;
             END IF;
        END;

    BEGIN

         OPEN CUPRICELIST;
         FETCH CUPRICELIST INTO NURETURN;
         CLOSE CUPRICELIST;

         RETURN NURETURN;

    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
    		CLOSECURSORS;
			RAISE;
		WHEN OTHERS THEN
            CLOSECURSORS;
			ERRORS.SETERROR;
			RAISE EX.CONTROLLED_ERROR;
    END FNUGETGENERICPRICELIST;
    
    


















    FUNCTION FNUGETVALIDPRLSTBYOPERUNIT
    (
         INUOPERUNIT IN GE_LIST_UNITARY_COST.OPERATING_UNIT_ID%TYPE,
         IDTASSIGNED IN GE_LIST_UNITARY_COST.VALIDITY_START_DATE%TYPE
    )
    RETURN GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID%TYPE
    IS

        NURETURN        GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID%TYPE;

        CURSOR CUPRICELISTBYOPERUNIT
        (
            NUOPERUNIT GE_LIST_UNITARY_COST.OPERATING_UNIT_ID%TYPE,
            DTASSIGNED GE_LIST_UNITARY_COST.VALIDITY_START_DATE%TYPE
        ) IS
            SELECT /*+ index(GE_LIST_UNITARY_COST IDX_GE_LIST_UNITARY_COST05)*/
                  GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID
            FROM  GE_LIST_UNITARY_COST
                  /*+ GE_BCListUnitaryCost.fnuGetValidPrLstByOperUnit*/
            WHERE GE_LIST_UNITARY_COST.OPERATING_UNIT_ID = NUOPERUNIT
            AND DTASSIGNED BETWEEN TRUNC(GE_LIST_UNITARY_COST.VALIDITY_START_DATE)
                                    AND TRUNC(GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE);

        
        PROCEDURE CLOSECURSORS
        IS
        BEGIN
            
            IF CUPRICELISTBYOPERUNIT%ISOPEN THEN
                CLOSE CUPRICELISTBYOPERUNIT;
            END IF;

        END;

    BEGIN
        

        OPEN CUPRICELISTBYOPERUNIT(INUOPERUNIT,TRUNC(IDTASSIGNED));
        FETCH CUPRICELISTBYOPERUNIT INTO NURETURN;
        CLOSE CUPRICELISTBYOPERUNIT;

        RETURN NURETURN;

    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
    		CLOSECURSORS;
			RAISE;
		WHEN OTHERS THEN
            CLOSECURSORS;
			ERRORS.SETERROR;
			RAISE EX.CONTROLLED_ERROR;
    END;

    
    






















    PROCEDURE GETPRICELISTOPERUNIORGEN
    (
        INUOPERATINGUNITID  IN  GE_LIST_UNITARY_COST.OPERATING_UNIT_ID%TYPE,
        INUCONTRACTID       IN  GE_LIST_UNITARY_COST.CONTRACT_ID%TYPE,
        INUCONTRACTORID     IN  GE_LIST_UNITARY_COST.CONTRACTOR_ID%TYPE,
        INUGEOLOCID         IN  GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID%TYPE,
        IDTDATE             IN  GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE%TYPE,
        OTBPRCLISTITEM     OUT  TYTBPRICELISTS,
        ONUCOUNT           OUT  NUMBER
    )
    IS

        DTDATE DATE := TRUNC(IDTDATE);
            
        
        CURSOR CUOPERUNITLIST
        (
            IDTDATE             IN  GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE%TYPE,
            INUOPERATINGUNITID  IN  GE_LIST_UNITARY_COST.OPERATING_UNIT_ID%TYPE
        )
        IS
            SELECT  /*+ index(ge_list_unitary_cost IDX_GE_LIST_UNITARY_COST05)*/
                    GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID
            FROM    GE_LIST_UNITARY_COST
                    /*+ GE_BCListUnitaryCost.GetPriceListOperUniorGen.cuOperunitList*/
            WHERE   GE_LIST_UNITARY_COST.OPERATING_UNIT_ID = INUOPERATINGUNITID
            AND     TRUNC(GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE) >= IDTDATE
            ORDER BY  GE_LIST_UNITARY_COST.VALIDITY_START_DATE;
            
        
        CURSOR CUCONTRACTLIST
        (
            IDTDATE             IN  GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE%TYPE,
            INUCONTRACTID       IN  GE_LIST_UNITARY_COST.CONTRACT_ID%TYPE
        )
        IS
            SELECT  /*+ index(ge_list_unitary_cost IDX_GE_LIST_UNITARY_COST02)*/
                    GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID
            FROM    GE_LIST_UNITARY_COST
                    /*+ GE_BCListUnitaryCost.GetPriceListOperUniorGen.cuContractList*/
            WHERE   GE_LIST_UNITARY_COST.CONTRACT_ID = INUCONTRACTID
            AND     TRUNC(GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE) >= IDTDATE
            ORDER BY  GE_LIST_UNITARY_COST.VALIDITY_START_DATE;

        
        CURSOR CUCONTRACTORLIST
        (
            IDTDATE             IN  GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE%TYPE,
            INUCONTRACTORID     IN  GE_LIST_UNITARY_COST.CONTRACTOR_ID%TYPE
        )
        IS
            SELECT  /*+ index(ge_list_unitary_cost IDX_GE_LIST_UNITARY_COST04)*/
                    GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID
            FROM    GE_LIST_UNITARY_COST
                    /*+ GE_BCListUnitaryCost.GetPriceListOperUniorGen.cuContractorList*/
            WHERE   GE_LIST_UNITARY_COST.CONTRACTOR_ID = INUCONTRACTORID
            AND     TRUNC(GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE) >= IDTDATE
            ORDER BY  GE_LIST_UNITARY_COST.VALIDITY_START_DATE;
            
        
        CURSOR CUGEOLOCLIST
        (
            IDTDATE             IN  GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE%TYPE,
            INUGEOLOCID         IN  GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID%TYPE
        )
        IS
            SELECT  /*+ index(ge_list_unitary_cost IDX_GE_LIST_UNITARY_COST03)*/
                    GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID
            FROM    GE_LIST_UNITARY_COST
                    /*+ GE_BCListUnitaryCost.GetPriceListOperUniorGen.cuGeoLocList*/
            WHERE   GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID = INUGEOLOCID
            AND     TRUNC(GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE) >= IDTDATE
            ORDER BY  GE_LIST_UNITARY_COST.VALIDITY_START_DATE;
            

        
        CURSOR CUGENPRCLIST
        (
            IDTDATE IN GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE%TYPE
        )
        IS
            SELECT  /*+ index(ge_list_unitary_cost IDX_GE_LIST_UNITARY_COST01) */
                    GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID
            FROM    GE_LIST_UNITARY_COST
                    /*+ GE_BCListUnitaryCost.GetPriceListOperUniorGen.cuGenPrcList*/
            WHERE   GE_LIST_UNITARY_COST.OPERATING_UNIT_ID IS NULL
            AND     GE_LIST_UNITARY_COST.CONTRACT_ID IS NULL
            AND     GE_LIST_UNITARY_COST.CONTRACTOR_ID IS NULL
            AND     GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID IS NULL
            AND     TRUNC(GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE) >= IDTDATE
            ORDER BY  GE_LIST_UNITARY_COST.VALIDITY_START_DATE;
            
        
        PROCEDURE CLOSECURSORS
        IS
        BEGIN
            
            IF CUOPERUNITLIST%ISOPEN THEN
                CLOSE CUOPERUNITLIST;
            END IF;

            
            IF CUCONTRACTLIST%ISOPEN THEN
                CLOSE CUCONTRACTLIST;
            END IF;

            
            IF CUCONTRACTORLIST%ISOPEN THEN
                CLOSE CUCONTRACTORLIST;
            END IF;

            
            IF CUGEOLOCLIST%ISOPEN THEN
                CLOSE CUGEOLOCLIST;
            END IF;
            
            
            IF CUGENPRCLIST%ISOPEN THEN
                CLOSE CUGENPRCLIST;
            END IF;

        END;

    BEGIN
        UT_TRACE.TRACE('GE_BCListUnitaryCost.GetPriceListOperUniorGen INICIO',1);

        OTBPRCLISTITEM.DELETE;



        IF INUOPERATINGUNITID IS NOT NULL THEN
        
            OPEN  CUOPERUNITLIST (DTDATE,INUOPERATINGUNITID);
            FETCH CUOPERUNITLIST BULK COLLECT INTO OTBPRCLISTITEM;
            CLOSE CUOPERUNITLIST;
            
        ELSIF INUCONTRACTID IS NOT NULL THEN
        
            OPEN  CUCONTRACTLIST (DTDATE,INUCONTRACTID);
            FETCH CUCONTRACTLIST BULK COLLECT INTO OTBPRCLISTITEM;
            CLOSE CUCONTRACTLIST;
            
        ELSIF INUCONTRACTORID IS NOT NULL THEN
        
            OPEN  CUCONTRACTORLIST (DTDATE,INUCONTRACTORID);
            FETCH CUCONTRACTORLIST BULK COLLECT INTO OTBPRCLISTITEM;
            CLOSE CUCONTRACTORLIST;
            
        ELSIF INUGEOLOCID IS NOT NULL THEN
        
            OPEN  CUGEOLOCLIST (DTDATE,INUGEOLOCID);
            FETCH CUGEOLOCLIST BULK COLLECT INTO OTBPRCLISTITEM;
            CLOSE CUGEOLOCLIST;
            
        ELSE
        
            OPEN  CUGENPRCLIST (DTDATE);
            FETCH CUGENPRCLIST BULK COLLECT INTO OTBPRCLISTITEM;
            CLOSE CUGENPRCLIST;
            
        END IF;

        ONUCOUNT := OTBPRCLISTITEM.COUNT;

        UT_TRACE.TRACE('GE_BCListUnitaryCost.GetPriceListOperUniorGen FIN',1);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            CLOSECURSORS;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            CLOSECURSORS;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETPRICELISTOPERUNIORGEN;
    
    














    PROCEDURE GETVALIDPRLST
    (
        INUOPERATINGUNITID  IN  GE_LIST_UNITARY_COST.OPERATING_UNIT_ID%TYPE,
        INUCONTRACTID       IN  GE_LIST_UNITARY_COST.CONTRACT_ID%TYPE,
        INUCONTRACTORID     IN  GE_LIST_UNITARY_COST.CONTRACTOR_ID%TYPE,
        INUGEOLOCID         IN  GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID%TYPE,
        IDTASSIGNED         IN  GE_LIST_UNITARY_COST.VALIDITY_START_DATE%TYPE,
        ORFOUTPUT           IN  OUT NOCOPY CONSTANTS.TYREFCURSOR
    )
    IS
        NUPRICELISTID        GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID%TYPE;
        SBSQL    VARCHAR2(4000);

        DTASSIGNED DATE := TRUNC(IDTASSIGNED);
        
        
        CURSOR CUPRICELISTBYOPERUNIT
        (
            INUOPERUNITID GE_LIST_UNITARY_COST.OPERATING_UNIT_ID%TYPE,
            IDTASSIG      GE_LIST_UNITARY_COST.VALIDITY_START_DATE%TYPE
        ) IS
            SELECT /*+ index(GE_LIST_UNITARY_COST IDX_GE_LIST_UNITARY_COST05)*/
                  GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID
            FROM  GE_LIST_UNITARY_COST
                 /*+ GE_BCListUnitaryCost.GetValidPrLst.cuPriceListByOperUnit */
            WHERE GE_LIST_UNITARY_COST.OPERATING_UNIT_ID = INUOPERUNITID
              AND IDTASSIG BETWEEN TRUNC(GE_LIST_UNITARY_COST.VALIDITY_START_DATE)
                                    AND TRUNC(GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE);
                                    
        
        CURSOR CUPRICELISTBYCONTRACT
        (
            INUCONTRCID GE_LIST_UNITARY_COST.CONTRACT_ID%TYPE,
            IDTASSIG    GE_LIST_UNITARY_COST.VALIDITY_START_DATE%TYPE
        ) IS
            SELECT /*+ index(GE_LIST_UNITARY_COST IDX_GE_LIST_UNITARY_COST02)*/
                  GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID
            FROM  GE_LIST_UNITARY_COST
                  /*+ GE_BCListUnitaryCost.GetValidPrLst.cuPriceListByContract*/
            WHERE GE_LIST_UNITARY_COST.CONTRACT_ID = INUCONTRCID
              AND IDTASSIG BETWEEN TRUNC(GE_LIST_UNITARY_COST.VALIDITY_START_DATE)
                                    AND TRUNC(GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE);

        
        CURSOR CUPRICELISTBYCONTRACTOR
        (
            INUCONTRCTID GE_LIST_UNITARY_COST.CONTRACTOR_ID%TYPE,
            IDTASSIG     GE_LIST_UNITARY_COST.VALIDITY_START_DATE%TYPE
        ) IS
            SELECT /*+ index(GE_LIST_UNITARY_COST IDX_GE_LIST_UNITARY_COST04)*/
                  GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID
            FROM  GE_LIST_UNITARY_COST
                  /*+ GE_BCListUnitaryCost.GetValidPrLst.cuPriceListByContractor*/
            WHERE GE_LIST_UNITARY_COST.CONTRACTOR_ID = INUCONTRCTID
              AND IDTASSIG BETWEEN TRUNC(GE_LIST_UNITARY_COST.VALIDITY_START_DATE)
                                    AND TRUNC(GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE);
                                    
        
        CURSOR CUPRICELISTBYGEOLOC
        (
            INUGEOLOCID GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID%TYPE,
            IDTASSIG    GE_LIST_UNITARY_COST.VALIDITY_START_DATE%TYPE
        ) IS
            SELECT /*+ index(GE_LIST_UNITARY_COST IDX_GE_LIST_UNITARY_COST03)*/
                  GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID
            FROM  GE_LIST_UNITARY_COST
                  /*+ GE_BCListUnitaryCost.GetValidPrLst.cuPriceListByGeoLoc*/
            WHERE GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID = INUGEOLOCID
              AND IDTASSIG BETWEEN TRUNC(GE_LIST_UNITARY_COST.VALIDITY_START_DATE)
                                    AND TRUNC(GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE);
                                    
        
        CURSOR CUPRICELISTBYGENERIC
        (
            IDTASSIG GE_LIST_UNITARY_COST.VALIDITY_START_DATE%TYPE
        ) IS
            SELECT /*+ index(GE_LIST_UNITARY_COST IDX_GE_LIST_UNITARY_COST01)*/
                  GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID
            FROM  GE_LIST_UNITARY_COST
                   /*+ GE_BCListUnitaryCost.GetValidPrLst.cuPriceListByGeneric*/
            WHERE GE_LIST_UNITARY_COST.OPERATING_UNIT_ID IS NULL
              AND GE_LIST_UNITARY_COST.CONTRACT_ID IS NULL
              AND GE_LIST_UNITARY_COST.CONTRACTOR_ID IS NULL
              AND GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID IS NULL
              AND IDTASSIG BETWEEN TRUNC(GE_LIST_UNITARY_COST.VALIDITY_START_DATE)
                                    AND TRUNC(GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE);


        
        PROCEDURE CLOSECURSORS
        IS
        BEGIN
            
            IF (CUPRICELISTBYOPERUNIT%ISOPEN) THEN
                CLOSE CUPRICELISTBYOPERUNIT;
            END IF;

            
            IF (CUPRICELISTBYCONTRACT%ISOPEN) THEN
                CLOSE CUPRICELISTBYCONTRACT;
            END IF;
            
            
            IF (CUPRICELISTBYCONTRACTOR%ISOPEN) THEN
                CLOSE CUPRICELISTBYCONTRACTOR;
            END IF;
            
            
            IF (CUPRICELISTBYGEOLOC%ISOPEN) THEN
                CLOSE CUPRICELISTBYGEOLOC;
            END IF;
            
            
            IF (CUPRICELISTBYGENERIC%ISOPEN) THEN
                CLOSE CUPRICELISTBYGENERIC;
            END IF;
        END;
        
    BEGIN

        IF (INUOPERATINGUNITID IS NOT NULL) THEN

            OPEN  CUPRICELISTBYOPERUNIT (INUOPERATINGUNITID,DTASSIGNED);
            FETCH CUPRICELISTBYOPERUNIT INTO NUPRICELISTID;
            CLOSE CUPRICELISTBYOPERUNIT;

        ELSIF (INUCONTRACTID IS NOT NULL) THEN

            OPEN  CUPRICELISTBYCONTRACT (INUCONTRACTID,DTASSIGNED);
            FETCH CUPRICELISTBYCONTRACT INTO NUPRICELISTID;
            CLOSE CUPRICELISTBYCONTRACT;

        ELSIF (INUCONTRACTORID IS NOT NULL) THEN

            OPEN  CUPRICELISTBYCONTRACTOR (INUCONTRACTORID,DTASSIGNED);
            FETCH CUPRICELISTBYCONTRACTOR INTO NUPRICELISTID;
            CLOSE CUPRICELISTBYCONTRACTOR;

        ELSIF (INUGEOLOCID IS NOT NULL) THEN

            OPEN  CUPRICELISTBYGEOLOC (INUGEOLOCID,DTASSIGNED);
            FETCH CUPRICELISTBYGEOLOC INTO NUPRICELISTID;
            CLOSE CUPRICELISTBYGEOLOC;

        ELSE

            OPEN  CUPRICELISTBYGENERIC (DTASSIGNED);
            FETCH CUPRICELISTBYGENERIC INTO NUPRICELISTID;
            CLOSE CUPRICELISTBYGENERIC;

        END IF;
        
        SBSQL := ' SELECT ge_unit_cost_ite_lis.items_id, ge_unit_cost_ite_lis.list_unitary_cost_id, '||CHR(10)||
                 ' ge_unit_cost_ite_lis.price, nvl(ge_unit_cost_ite_lis.sales_value,0) sales_value  '||CHR(10)||
                 ' FROM ge_unit_cost_ite_lis '||CHR(10)||
                 ' /*+ GE_BCListUnitaryCost.GetValidPrLst*/'||CHR(10)||
                 ' WHERE ge_unit_cost_ite_lis.list_unitary_cost_id = :inuLstPric '||CHR(10)||
                 ' ORDER BY ge_unit_cost_ite_lis.items_id ';

         
         OPEN ORFOUTPUT FOR SBSQL USING NUPRICELISTID;

    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
    		CLOSECURSORS;
			RAISE;
		WHEN OTHERS THEN
            CLOSECURSORS;
			ERRORS.SETERROR;
			RAISE EX.CONTROLLED_ERROR;
    END GETVALIDPRLST;
    
    


























    PROCEDURE GETPRICELISTING
    (
        INUOPERATINGUNITID    IN      GE_LIST_UNITARY_COST.OPERATING_UNIT_ID%TYPE,
        INUCONTRACTID         IN      GE_LIST_UNITARY_COST.CONTRACT_ID%TYPE,
        INUCONTRACTORID       IN      GE_LIST_UNITARY_COST.CONTRACTOR_ID%TYPE,
        INUGEOLOCID           IN      GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID%TYPE,
        ORFOUTPUT IN OUT NOCOPY CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQL    VARCHAR2(6000);
    BEGIN
        UT_TRACE.TRACE('Inicio GE_BCListUnitaryCost.GetPriceListing', 10);

        SBSQL := ' SELECT /*+ index(ge_list_unitary_cost IDX_GE_LIST_UNITARY_COST01)*/ '||CHR(10)||
                   ' ge_list_unitary_cost.list_unitary_cost_id, ge_list_unitary_cost.description, '||CHR(10)||
                   ' ge_list_unitary_cost.validity_start_date, ge_list_unitary_cost.validity_final_date '||CHR(10)||
                   ' FROM ge_list_unitary_cost '||CHR(10)||
                   ' /*+ GE_BCListUnitaryCost.GetPriceListing*/'||CHR(10)||
                   ' WHERE nvl(ge_list_unitary_cost.operating_unit_id,-1) = nvl(:inuOperatingUnitId,-1) '||CHR(10)||
                   ' AND nvl(ge_list_unitary_cost.contract_id,-1) = nvl(:inuContractId,-1) '||CHR(10)||
                   ' AND nvl(ge_list_unitary_cost.contractor_id,-1) = nvl(:inuContractorId,-1) '||CHR(10)||
                   ' AND nvl(ge_list_unitary_cost.geograp_location_id,-1) = nvl(:inuGeoLocId,-1) '||CHR(10)||
                   ' ORDER BY ge_list_unitary_cost.validity_start_date ';
        
        OPEN ORFOUTPUT FOR SBSQL USING INUOPERATINGUNITID,INUCONTRACTID, INUCONTRACTORID, INUGEOLOCID;

        UT_TRACE.TRACE('FIN GE_BOListUnitaryCost.GetPriceListing', 5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('CONTROLLED_ERROR GE_BCListUnitaryCost.GetPriceListing', 10);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('others GE_BCListUnitaryCost.GetPriceListing', 10);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETPRICELISTING;

    



















    PROCEDURE GETALLPRICELISTING
    (
        ORFOUTPUT IN OUT NOCOPY CONSTANTS.TYREFCURSOR
    )
	 IS
    BEGIN
        UT_TRACE.TRACE('Inicio GE_BCListUnitaryCost.GetAllPriceListing', 10);
        OPEN ORFOUTPUT FOR
            SELECT /*+ index(ge_list_unitary_cost IDX_GE_LIST_UNITARY_COST06)*/
                   GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID,
                   GE_LIST_UNITARY_COST.DESCRIPTION,
                   GE_LIST_UNITARY_COST.VALIDITY_START_DATE,
                   GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE,
                   GE_LIST_UNITARY_COST.CONTRACT_ID,
                   GE_LIST_UNITARY_COST.CONTRACTOR_ID,
                   GE_LIST_UNITARY_COST.OPERATING_UNIT_ID,
                   GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID
            FROM   GE_LIST_UNITARY_COST
                   /*+ GE_BCListUnitaryCost.GetAllPriceListing*/
            WHERE  CT_BOCONTRSECURITY.FNUCANMANAGECOSTLIST(GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID) = 1
            ORDER BY GE_LIST_UNITARY_COST.VALIDITY_START_DATE,
                     GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE;
        UT_TRACE.TRACE('FIN GE_BCListUnitaryCost.GetAllPriceListing', 10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('CONTROLLED_ERROR GE_BCListUnitaryCost.GetAllPriceListing', 10);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('others GE_BCListUnitaryCost.GetAllPriceListing', 10);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETALLPRICELISTING;
    
    
    























	PROCEDURE GETLSTPRICITEMVAL
    (
        INULSTPRIC      IN  GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID%TYPE,
        ORFOUTPUT IN OUT NOCOPY CONSTANTS.TYREFCURSOR
    )
	IS
        SBSQL    VARCHAR2(4000);
    BEGIN
        UT_TRACE.TRACE('Inicio GE_BCListUnitaryCost.GetLstPricItemVal
                                Lista ['||INULSTPRIC||']', 5);
        SBSQL := ' SELECT ge_unit_cost_ite_lis.items_id, ge_unit_cost_ite_lis.list_unitary_cost_id, '||CHR(10)||
                   ' ge_unit_cost_ite_lis.price, nvl(ge_unit_cost_ite_lis.sales_value,0) sales_value '||CHR(10)||
                   ' FROM ge_unit_cost_ite_lis '||CHR(10)||
                   ' /*+ GE_BCListUnitaryCost.GetLstPricItemVal*/'||CHR(10)||
                   ' WHERE ge_unit_cost_ite_lis.list_unitary_cost_id = :inuLstPric '||CHR(10)||
                   ' ORDER BY ge_unit_cost_ite_lis.items_id ';
        
        OPEN ORFOUTPUT FOR SBSQL USING INULSTPRIC;
        UT_TRACE.TRACE('FIN GE_BCListUnitaryCost.GetLstPricItemVal', 5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('CONTROLLED_ERROR GE_BCListUnitaryCost.GetLstPricItemVal', 5);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('others GE_BCListUnitaryCost.GetLstPricItemVal', 5);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETLSTPRICITEMVAL;
    
    



















    FUNCTION FNUGETNPRICELISTBYRANGE
    (
        INUOPERATINGUNITID          IN      GE_LIST_UNITARY_COST.OPERATING_UNIT_ID%TYPE,
        INUCONTRACTID               IN      GE_LIST_UNITARY_COST.CONTRACT_ID%TYPE,
        INUCONTRACTORID             IN      GE_LIST_UNITARY_COST.CONTRACTOR_ID%TYPE,
        INUGEOLOCID                 IN      GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID%TYPE,
        IDTVALIDITYSTARTDATE        IN      GE_LIST_UNITARY_COST.VALIDITY_START_DATE%TYPE,
        IDTVALIDITYFINALDATE        IN      GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE%TYPE,
        INULIST_UNITARY_COST_ID     IN      GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID%TYPE := NULL
    )
    RETURN NUMBER
    IS
        RFOUTPUT            CONSTANTS.TYREFCURSOR;
        NUNPRICELLIST       NUMBER;
        ISBSQL              VARCHAR2(4000);
    BEGIN
        UT_TRACE.TRACE('BEGIN GE_BCListUnitaryCost.fnuGetNPriceListByRange', 3);
        
        UT_TRACE.TRACE('Par?metro: inuOperatingUnitId -> ' || INUOPERATINGUNITID, 4);
        UT_TRACE.TRACE('Par?metro: inuContractId -> ' || INUCONTRACTID, 4);
        UT_TRACE.TRACE('Par?metro: inuContractorId -> ' || INUCONTRACTORID, 4);
        UT_TRACE.TRACE('Par?metro: inuGeoLocId -> ' || INUGEOLOCID, 4);
        UT_TRACE.TRACE('Par?metro: idtValidityStartDate -> ' || IDTVALIDITYSTARTDATE, 4);
        UT_TRACE.TRACE('Par?metro: idtValidityFinalDate -> ' || IDTVALIDITYFINALDATE, 4);
        UT_TRACE.TRACE('Par?metro: inuList_unitary_cost_id -> ' || INULIST_UNITARY_COST_ID, 4);
    
        ISBSQL := '
            SELECT  /*+ index(ge_list_unitary_cost IDX_GE_LIST_UNITARY_COST06)*/
                    count(ge_list_unitary_cost.list_unitary_cost_id)
            FROM    ge_list_unitary_cost
                    /*+ GE_BCListUnitaryCost.fnuGetNPriceListByRange*/
            WHERE   (:idtValidityStartDate between validity_start_date AND validity_final_date
            OR      :idtValidityFinalDate between validity_start_date AND validity_final_date
            OR      validity_start_date  between :idtValidityStartDate AND :idtValidityFinalDate
            OR      validity_final_date  between :idtValidityStartDate AND :idtValidityFinalDate)';
            
        IF (INULIST_UNITARY_COST_ID IS NULL) THEN
            ISBSQL :=  ISBSQL || CHR(13) || 'AND :list_unitary_cost_id IS null';
        ELSE
            ISBSQL :=  ISBSQL || CHR(13) || 'AND list_unitary_cost_id <> :list_unitary_cost_id ';
        END IF;
            
        IF (INUOPERATINGUNITID IS NULL) THEN
            ISBSQL :=  ISBSQL || CHR(13) || 'AND operating_unit_id IS null AND :operating_unit_id IS null';
        ELSE
            ISBSQL :=  ISBSQL || CHR(13) || 'AND operating_unit_id = :operating_unit_id ';
        END IF;
        
        IF (INUCONTRACTID IS NULL) THEN
            ISBSQL :=  ISBSQL || CHR(13) || 'AND contract_id IS null AND :contract_id IS null ';
        ELSE
            ISBSQL :=  ISBSQL || CHR(13) || 'AND contract_id = :contract_id ';
        END IF;
        
        IF (INUCONTRACTORID IS NULL) THEN
            ISBSQL :=  ISBSQL || CHR(13) || 'AND contractor_id IS null AND :contractor_id IS null';
        ELSE
            ISBSQL :=  ISBSQL || CHR(13) || 'AND contractor_id = :contractor_id ';
        END IF;
        
        IF (INUGEOLOCID IS NULL) THEN
            ISBSQL :=  ISBSQL || CHR(13) || 'AND geograp_location_id IS null AND :geograp_location_id IS null';
        ELSE
            ISBSQL :=  ISBSQL || CHR(13) || 'AND geograp_location_id = :geograp_location_id ';
        END IF;
        
        UT_TRACE.TRACE('Query: ' || ISBSQL, 3);
            
        OPEN RFOUTPUT FOR ISBSQL USING
            IDTVALIDITYSTARTDATE,
            IDTVALIDITYFINALDATE,
            IDTVALIDITYSTARTDATE,
            IDTVALIDITYFINALDATE,
            IDTVALIDITYSTARTDATE,
            IDTVALIDITYFINALDATE,
            INULIST_UNITARY_COST_ID,
            INUOPERATINGUNITID,
            INUCONTRACTID,
            INUCONTRACTORID,
            INUGEOLOCID;
            
        FETCH RFOUTPUT INTO NUNPRICELLIST;
        
        UT_TRACE.TRACE('END GE_BCListUnitaryCost.fnuGetNPriceListByRange[' || NUNPRICELLIST || ']', 3);
        
        RETURN NUNPRICELLIST;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('CONTROLLED_ERROR GE_BCListUnitaryCost.fnuGetNPriceListByRange', 3);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('others GE_BCListUnitaryCost.fnuGetNPriceListByRange', 3);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END FNUGETNPRICELISTBYRANGE;

END GE_BCLISTUNITARYCOST;