PL/SQL Developer Test script 3.0
145
DECLARE
        INUOPERUNIT     OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE:=1600;
        INUITEM         CT_ITEM_NOVELTY.ITEMS_ID%TYPE:=100003665;
        INUTECUNIT      GE_PERSON.PERSON_ID%TYPE:=13586;
        INUORDERID      OR_ORDER.ORDER_ID%TYPE:=NULL;
        INUVALUE        NUMBER:=50000;
        INUAMOUNT       NUMBER:=NULL;
        INUUSERID       SA_USER.USER_ID%TYPE:=1960;--1;
        INUCOMMENTYPE   GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE:=1298;
        ISBCOMMENT      OR_ORDER_COMMENT.ORDER_COMMENT%TYPE:='PRUEBA';
        NUERROR         NUMBER;
        SBERROR         VARCHAR2(4000);
        
        BLHASERROR          BOOLEAN := FALSE;
        NUCONTRACTORID      GE_CONTRATISTA.ID_CONTRATISTA%TYPE;
        ONUORDER            NUMBER;
        NUUSERID            SA_USER.USER_ID%TYPE := INUUSERID;
        
        SBFINALDATE         GE_BOINSTANCECONTROL.STYSBVALUE;
        DTFINALDATE         DATE;
        
        SBCONTRACT          GE_BOINSTANCECONTROL.STYSBVALUE;
        NUCONTRACT          GE_CONTRATO.ID_CONTRATO%TYPE;
        NUTASKTYPE          OR_ORDER.TASK_TYPE_ID%TYPE;
    BEGIN
        
        --UT_TRACE.TRACE('INICIO CT_BONovelty.CreateNoveltyRule';5);

        
        
        BEGIN
            
            CT_BONOVELTY.VALIDATENOVELTY
            (
                INUOPERUNIT,
                INUITEM,
                INUTECUNIT,
                INUORDERID,
                INUVALUE,
                INUAMOUNT,
                INUUSERID,
                INUCOMMENTYPE,
                ISBCOMMENT,
                FALSE       
            );
        EXCEPTION
            WHEN OTHERS THEN
                BLHASERROR := TRUE;
                ERRORS.SETERROR;
                ERRORS.GETERROR(NUERROR, SBERROR);
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
                 DBMS_OUTPUT.PUT_LINE(SBERROR);
                 DBMS_OUTPUT.PUT_LINE(NUERROR);
        END;
        

        IF (NUUSERID IS NULL) THEN
            NUUSERID := SA_BOSYSTEM.GETSYSTEMUSERID;
        END IF;
        
        NUCONTRACTORID := DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID(INUOPERUNIT, 0);

        
        IF (NOT BLHASERROR) THEN
            CT_BONOVELTY.CREATENOVELTY
            (
                NUCONTRACTORID,
                INUOPERUNIT,
                INUITEM,
                INUTECUNIT,
                INUORDERID,
                INUVALUE,
                INUAMOUNT,
                NUUSERID,
                INUCOMMENTYPE,
                ISBCOMMENT,
                ONUORDER,
                CT_BOCONSTANTS.CNUTRANS_TYPE_NOVE_ORDER,
                TRUE
            );
            
            IF (ONUORDER IS NOT NULL) THEN
              DBMS_OUTPUT.PUT_LINE(ONUORDER);
                CT_BOCERTIFICATECONTROL.BLINSERTNOVORDERS := TRUE;
                
                GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(CT_BOCONSTANTS.FSBGETCONTRACTORINSTANCENAME,
                                                  NULL,
                                                  'GE_PERIODO_CERT',
                                                   CT_BOCONSTANTS.FSBGETBREAKDATEATTRNAME,
                                                  SBFINALDATE);
                DTFINALDATE := TO_DATE(SBFINALDATE,  UT_DATE.FSBDATE_FORMAT);
                
                IF DTFINALDATE < DAOR_ORDER.FDTGETEXECUTION_FINAL_DATE(ONUORDER) THEN
                
                    
                    DAOR_ORDER.UPDEXECUTION_FINAL_DATE(ONUORDER, DTFINALDATE);

                END IF;

                
                GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(CT_BOCONSTANTS.FSBGETCONTRACTORINSTANCENAME,
                                                  NULL,
                                                  'GE_CONTRATO',
                                                  'ID_CONTRATO',
                                                  SBCONTRACT);

                
                NUCONTRACT := TO_NUMBER(SBCONTRACT);
                
                
                NUTASKTYPE := DAOR_ORDER.FNUGETTASK_TYPE_ID(ONUORDER);
                
                
                
                IF CT_BCCONTRACT.FBLHASCONTRACTTASKTYPES(NUCONTRACT) THEN
                    
                    IF CT_BCCONTRACT.FBLAPPLYCONTBYTASKTYPE(NUCONTRACT, NUTASKTYPE) THEN
                        
                        DAOR_ORDER.UPDDEFINED_CONTRACT_ID(ONUORDER,NUCONTRACT);
                    END IF;
                
                ELSIF CT_BCCONTRACT.FBLHASCONTTYPETASKTYPES(NUCONTRACT) THEN
                    
                    IF CT_BCCONTRACT.FBLAPPLYCONTTYPEBYTSKTYPE(DAGE_CONTRATO.FNUGETID_TIPO_CONTRATO(NUCONTRACT),NUTASKTYPE) THEN
                        
                        DAOR_ORDER.UPDDEFINED_CONTRACT_ID(ONUORDER,NUCONTRACT);
                    END IF;
                ELSE
                    
                    
                    DAOR_ORDER.UPDDEFINED_CONTRACT_ID(ONUORDER,NUCONTRACT);

                END IF;
            END IF;
        END IF;
    
       -- UT_TRACE.TRACE('FIN CT_BONovelty.CreateNoveltyRule';5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ;
0
0
