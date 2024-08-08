PACKAGE CT_BOReads
IS
    


























    
    
    
    

    



    PROCEDURE GETREAD
    (
        ISBCAUSAL       IN      VARCHAR2,
        ISBOBSECOD      IN      VARCHAR2,
        ONUCOUNT        OUT     NUMBER
    );
    
    



    PROCEDURE GETREADNOEFFECT
    (
        ISBCAUSAL       IN      VARCHAR2,
        ISBOBSECOD      IN      VARCHAR2,
        ONUCOUNT        OUT     NUMBER
    );
    
    
    PROCEDURE GETREWORKED
    (
        OBLREADING      OUT     BOOLEAN
    );
    
    
    PROCEDURE GETBADREADS
    (
        OBLREADING      OUT     BOOLEAN
    );
    
    FUNCTION FSBVERSION
    RETURN VARCHAR2;
    
    



    PROCEDURE PROCESSREADBYCONTRACT
    (
        INUCONTRACTID   IN  GE_CONTRATO.ID_CONTRATO%TYPE,
        IDTFINALDATE    IN  GE_PERIODO_CERT.FECHA_FINAL%TYPE
    );
    
END CT_BOREADS;

PACKAGE BODY CT_BOReads
IS
    



























    
    
    
    CSBVERSION                  CONSTANT VARCHAR2(10) := 'SAO424459';

    GSBREADTASKTYPES            VARCHAR2(200);
    
    
    

    



















    PROCEDURE GETREAD
    (
        ISBCAUSAL       IN      VARCHAR2,
        ISBOBSECOD      IN      VARCHAR2,
        ONUCOUNT        OUT     NUMBER
    )
    IS
        SBORDERID           OR_ORDER.ORDER_ID%TYPE;
        TBPARAMETERS        UT_STRING.TYTB_STRING;
    BEGIN
        UT_TRACE.TRACE('BEGIN CT_BOReads.GetRead', 1);
        
        UT_TRACE.TRACE('Par�metro -> isbCausal: ' || ISBCAUSAL, 2);
        UT_TRACE.TRACE('Par�metro -> isbObseCod: ' || ISBOBSECOD, 2);
        
        
        UT_STRING.EXTSTRING (ISBCAUSAL,  '|',   TBPARAMETERS);

        
        FOR NUCOUNTER IN 1 .. TBPARAMETERS.COUNT LOOP
            IF TBPARAMETERS.EXISTS(NUCOUNTER) THEN
                
                IF (TBPARAMETERS(NUCOUNTER) NOT IN ('F','I','T','R')) THEN
                    ERRORS.SETERROR(122142, 'isbCausal');
                    RAISE EX.CONTROLLED_ERROR;
                END IF;
            END IF;
        END LOOP;
        
        TBPARAMETERS.DELETE;
        
        UT_STRING.EXTSTRING (ISBOBSECOD,  '|',   TBPARAMETERS);
        
        BEGIN
            
            FOR NUCOUNTER IN 1 .. TBPARAMETERS.COUNT LOOP
                IF TBPARAMETERS.EXISTS(NUCOUNTER) THEN
                    DAOBSELECT.ACCKEY(UT_CONVERT.FNUCHARTONUMBER(TBPARAMETERS(NUCOUNTER)));
                    
                   



                END IF;
            END LOOP;

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR(122142, 'isbObseCod');
                RAISE EX.CONTROLLED_ERROR;
        END;
        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(CT_BOCONSTANTS.FSBGETCONTRACTORINSTANCENAME,NULL,'OR_ORDER', 'ORDER_ID',SBORDERID);
        
        ONUCOUNT := CT_BCREADS.FNUGETREAD(UT_CONVERT.FNUCHARTONUMBER(SBORDERID), ISBCAUSAL, ISBOBSECOD, FALSE);
        
        UT_TRACE.TRACE('Par�metro -> onuCount: ' || ONUCOUNT, 2);
        
        UT_TRACE.TRACE('END CT_BOReads.GetRead', 1);
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        
    END GETREAD;
    
    



















    PROCEDURE GETREADNOEFFECT
    (
        ISBCAUSAL       IN      VARCHAR2,
        ISBOBSECOD      IN      VARCHAR2,
        ONUCOUNT        OUT     NUMBER
    )
    IS
        SBORDERID       OR_ORDER.ORDER_ID%TYPE;
    BEGIN
        UT_TRACE.TRACE('BEGIN CT_BOReads.GetReadNoEffect', 1);

        UT_TRACE.TRACE('Par�metro -> isbCausal: ' || ISBCAUSAL, 2);
        UT_TRACE.TRACE('Par�metro -> isbObseCod: ' || ISBOBSECOD, 2);

        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(CT_BOCONSTANTS.FSBGETCONTRACTORINSTANCENAME,NULL,'OR_ORDER', 'ORDER_ID',SBORDERID);

        ONUCOUNT := CT_BCREADS.FNUGETREAD(UT_CONVERT.FNUCHARTONUMBER(SBORDERID), ISBCAUSAL, ISBOBSECOD, TRUE);

        UT_TRACE.TRACE('Par�metro -> onuCount: ' || ONUCOUNT, 2);

        UT_TRACE.TRACE('END CT_BOReads.GetReadNoEffect', 1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END GETREADNOEFFECT;
    
    














    PROCEDURE GETREWORKED
    (
        OBLREADING      OUT     BOOLEAN
    )
    IS
        SBORDERID       OR_ORDER.ORDER_ID%TYPE;
    BEGIN
    
        UT_TRACE.TRACE('BEGIN CT_BOReads.GetReWorked', 1);

        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(CT_BOCONSTANTS.FSBGETCONTRACTORINSTANCENAME,NULL,'OR_ORDER', 'ORDER_ID',SBORDERID);

        OBLREADING := CT_BCREADS.FBOGETREWORKED(UT_CONVERT.FNUCHARTONUMBER(SBORDERID));

        UT_TRACE.TRACE('Par�metro -> oblReading: ' || (CASE WHEN (OBLREADING = TRUE) THEN 'TRUE' ELSE 'FALSE' END), 2);

        UT_TRACE.TRACE('END CT_BOReads.GetReWorked', 1);
        
    END GETREWORKED;
    
    














    PROCEDURE GETBADREADS
    (
        OBLREADING      OUT     BOOLEAN
    )
    IS
        SBORDERID       OR_ORDER.ORDER_ID%TYPE;
    BEGIN

        UT_TRACE.TRACE('BEGIN CT_BOReads.GetBadReads', 1);

        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(CT_BOCONSTANTS.FSBGETCONTRACTORINSTANCENAME,NULL,'OR_ORDER', 'ORDER_ID',SBORDERID);

        OBLREADING := CT_BCREADS.FBOGETBADREADS(UT_CONVERT.FNUCHARTONUMBER(SBORDERID));

        UT_TRACE.TRACE('Par�metro -> oblReading: ' || (CASE WHEN (OBLREADING = TRUE) THEN 'TRUE' ELSE 'FALSE' END), 2);

        UT_TRACE.TRACE('END CT_BOReads.GetBadReads', 1);
        
    END GETBADREADS;

    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;
    
    
    






















    PROCEDURE REGISTERORDER
    (
        INUCONTRACTID       IN  GE_CONTRATO.ID_CONTRATO%TYPE,
        INUOPERUNITID       IN  OR_ORDER.OPERATING_UNIT_ID%TYPE,
        INUACTIVITY         IN  GE_ITEMS.ITEMS_ID%TYPE,
        INUADDRESSID        IN  OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE,
        IDTFINISHDATE       IN  OR_ORDER.EXECUTION_FINAL_DATE%TYPE,
        INUITEMAMOUNT       IN  OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT%TYPE,
        INUVALUE            IN  OR_ORDER_ITEMS.VALUE%TYPE,
        INUTOTALPRICE       IN  OR_ORDER_ITEMS.TOTAL_PRICE%TYPE,
        INUREFVALUE         IN  OR_ORDER_ACTIVITY.VALUE_REFERENCE%TYPE
    )
    IS
        NUORDERID   OR_ORDER.ORDER_ID%TYPE;

    BEGIN
        UT_TRACE.TRACE('Inicia CT_BCReads.RegisterOrder',15);

        NUORDERID := NULL;

        OR_BOORDER.CREATECLOSEORDER
        (
            INUOPERUNITID    => INUOPERUNITID,
            INUACTIVITY      => INUACTIVITY,
            INUADDRESSID     => INUADDRESSID,
            
            IDTFINISHDATE    => IDTFINISHDATE + 1 - (1/(24*60*60)),
            INUITEMAMOUNT    => INUITEMAMOUNT,
            INUREFVALUE      => INUREFVALUE,
            INUCAUSAL        => OR_BOCONSTANTS.CNUSUCCESCAUSAL,
            INURELATIONTYPE  => NULL,
            IONUORDERID      => NUORDERID,
            INUORDERRELAID   => NULL,
            INUCOMMENTTYPEID => NULL,
            ISBCOMMENT       => NULL,
            INUPERSONID      => GE_BOPERSONAL.FNUGETPERSONID
        );

        UT_TRACE.TRACE('Order Creada -->'||NUORDERID,15);

        
        DAOR_ORDER.UPDDEFINED_CONTRACT_ID(NUORDERID, INUCONTRACTID);
        
        DAOR_ORDER.UPDSAVED_DATA_VALUES(NUORDERID, CT_BCREADS.CSBGROUPEDTOKEN);
        
        CT_BCREADS.UPDATEVALUEANDCOST(NUORDERID, INUVALUE, INUTOTALPRICE);

        UT_TRACE.TRACE('Finaliza CT_BCReads.RegisterOrder',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    






















    PROCEDURE CREATEGROUPEDORDERS
    (
        INUCONTRACTID   IN  GE_CONTRATO.ID_CONTRATO%TYPE,
        ISBOBSERVID     IN  GE_PARAMETER.VALUE%TYPE,
        IDTFECHALIMITE  IN  GE_PERIODO_CERT.FECHA_FINAL%TYPE,
        ITBORDERSGROUP  IN  OUT NOCOPY CT_TYTBORDERSTOLIQ
    )
    IS
    BEGIN
        UT_TRACE.TRACE('Inicia CT_BCReads.CreateGroupedOrders ('||INUCONTRACTID||') ('||ISBOBSERVID||')',15);

        
        IF ( GSBREADTASKTYPES IS NULL ) THEN
            CT_BCREADS.GETREADTASKTYPES(GSBREADTASKTYPES);
        END IF;
        TD('gsbReadTaskTypes: '||GSBREADTASKTYPES);
        
        
        FOR RCROW IN CT_BCREADS.CUGETGROUPEDORDERSLEC(ITBORDERSGROUP, IDTFECHALIMITE, GSBREADTASKTYPES, ISBOBSERVID) LOOP

            REGISTERORDER
            (
                INUCONTRACTID,
                RCROW.OPERATING_UNIT_ID,
                RCROW.ITEMS_ID,
                RCROW.ADDRESS_ID,
                RCROW.LEGALDATE,
                RCROW.LEGAL_ITEM_AMOUNT,
                RCROW.VALUE,
                RCROW.TOTAL_PRICE,
                RCROW.VALUE_REFERENCE
            );

        END LOOP;

        
        FOR RCROW IN CT_BCREADS.CUGETGROUPEDORDERSNOLEC(ITBORDERSGROUP, IDTFECHALIMITE) LOOP

            REGISTERORDER
            (
                INUCONTRACTID,
                RCROW.OPERATING_UNIT_ID,
                RCROW.ITEMS_ID,
                RCROW.ADDRESS_ID,
                RCROW.LEGALDATE,
                RCROW.LEGAL_ITEM_AMOUNT,
                RCROW.VALUE,
                RCROW.TOTAL_PRICE,
                RCROW.VALUE_REFERENCE
            );

        END LOOP;

        UT_TRACE.TRACE('Finaliza CT_BCReads.CreateGroupedOrders',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    





















    PROCEDURE ASSOCORDERSTOCONTRACT
    (
        INUCONTRACTID   IN  GE_CONTRATO.ID_CONTRATO%TYPE,
        ISBTASKTYPESID  IN  GE_PARAMETER.VALUE%TYPE,
        IDTFINALDATE    IN  GE_PERIODO_CERT.FECHA_FINAL%TYPE
    )
    IS
        
        RCGE_CONTRATO       DAGE_CONTRATO.STYGE_CONTRATO;
        NUOPERATINGUNITID   OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE;
        TBOPERATINGUNITS    DAOR_OPERATING_UNIT.TYTBOPERATING_UNIT_ID;
        SBFINALTASKTYPES    GE_PARAMETER.VALUE%TYPE := NULL;
        NUIDX               NUMBER;

    BEGIN

        UT_TRACE.TRACE('Inicia CT_BOReads.AssocOrdersToContract ('||INUCONTRACTID||')',2);

        
        RCGE_CONTRATO := DAGE_CONTRATO.FRCGETRECORD(INUCONTRACTID);
        
        
        TBOPERATINGUNITS   :=  CT_BCREADS.FTBGETOPUNIBYCONTRACT(INUCONTRACTID);
        
        
        SBFINALTASKTYPES    :=  CT_BCREADS.FSBGETGROUPTASKTYPES(INUCONTRACTID, ISBTASKTYPESID);
        
        
        IF (SBFINALTASKTYPES IS NOT NULL) THEN
        
            
            IF (TBOPERATINGUNITS.COUNT > 0)THEN

                NUIDX := TBOPERATINGUNITS.FIRST;
            
                LOOP
                    EXIT WHEN NUIDX IS NULL;
                    
                        NUOPERATINGUNITID := TBOPERATINGUNITS(NUIDX);
                         UT_TRACE.TRACE('nuOperatingUnitId ('||NUOPERATINGUNITID||')',2);
        
                        
                        
                        CT_BCREADS.UPDCONTRACTTOORDERS
                        (
                            NUOPERATINGUNITID,
                            SBFINALTASKTYPES,
                            RCGE_CONTRATO,
                            IDTFINALDATE
                        );

                        NUIDX := TBOPERATINGUNITS.NEXT(NUIDX);
                END LOOP;

            END IF;

        END IF;

        UT_TRACE.TRACE('Finaliza CT_BOReads.AssocOrdersToContract', 2);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END ASSOCORDERSTOCONTRACT;


    






























    PROCEDURE PROCESSREADBYCONTRACT
    (
        INUCONTRACTID   IN  GE_CONTRATO.ID_CONTRATO%TYPE,
        IDTFINALDATE    IN  GE_PERIODO_CERT.FECHA_FINAL%TYPE
    )
    IS
        SBTASKTYPESID       GE_PARAMETER.VALUE%TYPE;
        SBOBSERVID          GE_PARAMETER.VALUE%TYPE;
        NUORDERSCREATED     NUMBER;
        TBORDERSTOGROUP     CT_TYTBORDERSTOLIQ;
        TBDAYSTOEXEC        DAGE_PERIODO_CERT.TYTBFECHA_INICIAL;
    BEGIN

        UT_TRACE.TRACE('Inicia CT_BCReads.fnuGetReadByContract ('||INUCONTRACTID||')', 2);
        TD('Inicia CT_BCReads.fnuGetReadByContract');

        
        SBTASKTYPESID  := GE_BOPARAMETER.FSBGET('AGRUPED_TASK_TYPE');
        SBOBSERVID     := GE_BOPARAMETER.FSBGET('OBSERV_TO_EXCLUDE');

        
        
        IF (SBTASKTYPESID IS NOT NULL) THEN
            SBTASKTYPESID := CT_BCREADS.CSBSEPARATOR || REPLACE(SBTASKTYPESID, ' ', '') || CT_BCREADS.CSBSEPARATOR;
        END IF;
        TD('sbTaskTypesId: '||SBTASKTYPESID);

        
        
        IF (SBOBSERVID IS NOT NULL) THEN
            SBOBSERVID := CT_BCREADS.CSBSEPARATOR || REPLACE(SBOBSERVID, ' ', '') || CT_BCREADS.CSBSEPARATOR;
        END IF;
        TD('sbObservId: '||SBOBSERVID);

        TD('Asociando contratos a ordenes que no tienen.');
        
        ASSOCORDERSTOCONTRACT(INUCONTRACTID, SBTASKTYPESID, IDTFINALDATE);

        
        IF ( TBORDERSTOGROUP IS NULL ) THEN
            TBORDERSTOGROUP := CT_TYTBORDERSTOLIQ();
        ELSE
            TBORDERSTOGROUP.DELETE;
        END IF;
        
        TD('Colecci�n Inicializada: tbOrdersToGroup');

        
        CT_BCREADS.GETORDERSTOGROUP(INUCONTRACTID, SBTASKTYPESID, IDTFINALDATE, TBORDERSTOGROUP);
        
        TD('�rdenes a Agrupar: '||TBORDERSTOGROUP.COUNT);

        
        CT_BCREADS.GETDAYSTOEXEC(TBORDERSTOGROUP, TBDAYSTOEXEC);
        
        TD('D�as a procesar: '||TBDAYSTOEXEC.COUNT);

        
        IF (TBDAYSTOEXEC.COUNT > 0) THEN

            
            FOR NUINDEX IN TBDAYSTOEXEC.FIRST .. TBDAYSTOEXEC.LAST LOOP

                BEGIN
                    SAVEPOINT INITPROCESS;
                    
                    TD('Procesando d�a:'||TBDAYSTOEXEC(NUINDEX));

                    


                    CREATEGROUPEDORDERS
                    (
                        INUCONTRACTID,
                        SBOBSERVID,
                        TBDAYSTOEXEC(NUINDEX),
                        TBORDERSTOGROUP
                    );

                    TD('Actualizando Ordenes a Liquidadas.');
                    
                    CT_BCREADS.UPDATEORDERLIQ
                    (
                        TBORDERSTOGROUP,
                        TBDAYSTOEXEC(NUINDEX)
                    );

                    COMMIT;
                EXCEPTION
                    WHEN EX.CONTROLLED_ERROR THEN
                        ROLLBACK TO INITPROCESS;
                        RAISE EX.CONTROLLED_ERROR;
                    WHEN OTHERS THEN
                        ERRORS.SETERROR;
                        ROLLBACK TO INITPROCESS;
                        RAISE EX.CONTROLLED_ERROR;
                END;

            END LOOP;
        ELSE
            UT_TRACE.TRACE('-->No se encontraron ordenes para agrupar',15);
        END IF;
        
        
        TBORDERSTOGROUP.DELETE;


        UT_TRACE.TRACE('Finaliza CT_BCReads.fnuGetReadByContract', 2);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END PROCESSREADBYCONTRACT;
    

END CT_BOREADS;