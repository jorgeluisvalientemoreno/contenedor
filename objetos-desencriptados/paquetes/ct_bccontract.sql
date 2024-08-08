PACKAGE BODY CT_BCContract 
IS 



















































































































































 
    
    
    
    CSBVERSION                  CONSTANT VARCHAR2(20) := 'SAO492019_SO'; 
 
    CNUSUCCESSFULLCLASSCAUSAL   CONSTANT GE_CAUSAL.CLASS_CAUSAL_ID%TYPE := GE_BOPARAMETER.FNUGET('ACCOM_CAUSE_TYPE'); 
 
    
    
    
 
    
    
    
     
    FUNCTION FSBVERSION 
    RETURN VARCHAR2 IS 
    BEGIN 
        RETURN CSBVERSION; 
    END FSBVERSION; 
     
    























 
    PROCEDURE GETCONDITIONSPLAN 
    ( 
        INUCONTRACTID	    IN  CT_CONPLA_CON_TYPE.CONTRACT_ID%TYPE, 
        IDTDATE             IN  CT_CONPLA_CON_TYPE.START_DATE%TYPE, 
        ONUCONDITIONSPLANID OUT CT_CONPLA_CON_TYPE.CONDITIONS_PLAN_ID%TYPE 
    ) 
    IS 
        DTMINDATE   DATE := UT_DATE.FDTMINDATE; 
        DTMAXDATE   DATE := UT_DATE.FDTMAXDATE; 
         
        
        CURSOR CUCONDITIONSPLANS 
        IS 
            SELECT  /*+ index (CT_CONPLA_CON_TYPE IDX_CT_CONPLA_CON_TYPE03 ) */ 
                    CT_CONPLA_CON_TYPE.CONDITIONS_PLAN_ID 
            FROM    CT_CONPLA_CON_TYPE 
                    /*+ CT_BCContract.GetConditionsPlan*/ 
            WHERE   CT_CONPLA_CON_TYPE.CONTRACT_ID = INUCONTRACTID 
              AND   CT_CONPLA_CON_TYPE.FLAG_TYPE = CT_BOCONSTANTS.CSBISCONTRACT 
              AND   IDTDATE BETWEEN NVL(CT_CONPLA_CON_TYPE.START_DATE, 
                                       DTMINDATE) 
                               AND NVL(CT_CONPLA_CON_TYPE.END_DATE, 
                                       DTMAXDATE) 
              AND   CT_CONPLA_CON_TYPE.PERSON_ID IS NULL 
              AND   CT_CONPLA_CON_TYPE.PERSONAL_TYPE IS NULL; 
               
    BEGIN 
         
        OPEN CUCONDITIONSPLANS; 
        FETCH CUCONDITIONSPLANS INTO ONUCONDITIONSPLANID; 
        CLOSE CUCONDITIONSPLANS; 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF (CUCONDITIONSPLANS%ISOPEN) THEN 
                CLOSE CUCONDITIONSPLANS; 
            END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            IF (CUCONDITIONSPLANS%ISOPEN) THEN 
                CLOSE CUCONDITIONSPLANS; 
            END IF; 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END GETCONDITIONSPLAN; 
     
    




























 
    PROCEDURE GETCONTRACTSTOPROCESS 
    ( 
        INUCONTRACTTYPEID	IN            GE_CONTRATO.ID_TIPO_CONTRATO%TYPE, 
        INUCONTRACTORID	    IN            GE_CONTRATO.ID_CONTRATISTA%TYPE, 
        IDTBREAKDATE        IN            GE_PERIODO_CERT.FECHA_FINAL%TYPE, 
        IDTPERIODSTARTDATE  IN            GE_PERIODO_CERT.FECHA_INICIAL%TYPE, 
        IDTPERIODENDDATE    IN            GE_PERIODO_CERT.FECHA_FINAL%TYPE, 
        OTBCONTRACTS        IN OUT NOCOPY DAGE_CONTRATO.TYTBID_CONTRATO 
    ) 
    IS 
        
        CURSOR CUCONTRACTS 
        IS 
            SELECT  GE_CONTRATO.ID_CONTRATO 
            FROM    GE_CONTRATO, 
                    GE_CONTRATISTA 
                    /*+ CT_BCContract.GetContractsToProcess*/ 
            WHERE 
                   
                   GE_CONTRATO.FECHA_CIERRE IS NULL 
                   
              AND  IDTBREAKDATE BETWEEN NVL(GE_CONTRATO.FECHA_INICIAL, 
                                            UT_DATE.FDTMINDATE) 
                                    AND NVL(GE_CONTRATO.FECHA_FINAL, 
                                            UT_DATE.FDTMAXDATE) 
                   
              AND  GE_CONTRATO.ID_TIPO_CONTRATO = NVL(INUCONTRACTTYPEID, 
                                                      GE_CONTRATO.ID_TIPO_CONTRATO) 
 
                   
              AND  GE_CONTRATO.ID_CONTRATISTA = GE_CONTRATISTA.ID_CONTRATISTA 
                    
              AND  GE_CONTRATISTA.ID_CONTRATISTA =NVL(INUCONTRACTORID, GE_CONTRATO.ID_CONTRATISTA) 
              AND  GE_CONTRATISTA.STATUS NOT IN (CT_BOCONSTANTS.FSBGETREJECTSTATUS, CT_BOCONSTANTS.FSBGETINACTIVESTATUS) 
                                                     
                    
              AND  CT_BOCONTRSECURITY.FNUCANMANAGECONTRACT(GE_CONTRATO.ID_CONTRATO) = 1 
               
                   
              AND  (   (    NVL(GE_CONTRATO.FECHA_INICIAL, 
                                UT_DATE.FDTMINDATE) <= IDTPERIODSTARTDATE 
                        AND IDTPERIODSTARTDATE <= NVL(GE_CONTRATO.FECHA_FINAL, 
                                                      UT_DATE.FDTMAXDATE) 
                       ) 
                    OR (    NVL(GE_CONTRATO.FECHA_INICIAL, 
                                UT_DATE.FDTMINDATE) <= IDTPERIODENDDATE 
                        AND IDTPERIODENDDATE <= NVL(GE_CONTRATO.FECHA_FINAL, 
                                                    UT_DATE.FDTMAXDATE)) 
                    OR (    IDTPERIODSTARTDATE <= NVL(GE_CONTRATO.FECHA_INICIAL, 
                                                      UT_DATE.FDTMINDATE) 
                        AND NVL(GE_CONTRATO.FECHA_FINAL, 
                                UT_DATE.FDTMAXDATE) <= IDTPERIODENDDATE 
                       ) 
                   ); 
    BEGIN 
 
        OPEN CUCONTRACTS; 
        FETCH CUCONTRACTS BULK COLLECT INTO OTBCONTRACTS; 
        CLOSE CUCONTRACTS; 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF (CUCONTRACTS%ISOPEN) THEN 
                CLOSE CUCONTRACTS; 
            END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            IF (CUCONTRACTS%ISOPEN) THEN 
                CLOSE CUCONTRACTS; 
            END IF; 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END GETCONTRACTSTOPROCESS; 
     
    


























 
    PROCEDURE GETOPENCONTRACTSTOPROCESS 
    ( 
        INUCONTRACTTYPEID	IN            GE_CONTRATO.ID_TIPO_CONTRATO%TYPE, 
        INUCONTRACTORID	    IN            GE_CONTRATO.ID_CONTRATISTA%TYPE, 
        IDTBREAKDATE        IN            GE_PERIODO_CERT.FECHA_FINAL%TYPE, 
        IDTPERIODSTARTDATE  IN            GE_PERIODO_CERT.FECHA_INICIAL%TYPE, 
        IDTPERIODENDDATE    IN            GE_PERIODO_CERT.FECHA_FINAL%TYPE, 
        OTBCONTRACTS        IN OUT NOCOPY DAGE_CONTRATO.TYTBID_CONTRATO 
    ) 
    IS 
        SBSQL           VARCHAR(2000); 
        SBHINT          VARCHAR(200) := ''; 
        SBTYPE          VARCHAR(200) := ''; 
        SBCONTRACTOR    VARCHAR(200) := ''; 
        OCUDATACURSOR   CONSTANTS.TYREFCURSOR; 
    BEGIN 
        IF (INUCONTRACTORID IS NOT NULL) THEN 
            SBHINT := '    index(GE_CONTRATISTA PK_GE_CONTRATISTA) '; 
            SBCONTRACTOR := ' AND  ge_contratista.id_contratista = '||INUCONTRACTORID; 
        END IF; 
        IF (INUCONTRACTTYPEID IS NOT NULL) THEN 
                SBHINT := SBHINT || CHR(10) || 
                          '    index(GE_CONTRATO IDX_GE_CONTRATO_01) '; 
                SBTYPE := ' AND  ge_contrato.id_tipo_contrato = '||INUCONTRACTTYPEID; 
        END IF; 
 
        SBSQL := 'SELECT /*+ ' || SBHINT || '*/ ' ||CHR(10)|| 
                 '      ge_contrato.id_contrato ' ||CHR(10)|| 
                 'FROM    ge_contrato,  '  ||CHR(10)|| 
                    'ge_contratista ' ||CHR(10)|| 
                    '/*+ CT_BCContract.GetOpenContractsToProcess SAO212226*/ ' ||CHR(10)|| 
            'WHERE ' ||CHR(10)|| 
                   
            '      ge_contrato.fecha_cierre IS null ' ||CHR(10)|| 
                   
            ' AND  ge_contrato.status = ct_boconstants.fsbGetOpenStatus ' ||CHR(10)|| 
                   
       
       
       
       
                   
            SBTYPE ||CHR(10)|| 
                   
            '  AND  ge_contrato.id_contratista = ge_contratista.id_contratista ' ||CHR(10)|| 
                    
            SBCONTRACTOR ||CHR(10)|| 
            '  AND  ge_contratista.status not in (ct_boconstants.fsbGetRejectStatus, ct_boconstants.fsbgetInactiveStatus) ' ||CHR(10)|| 
                    
            '  AND  CT_BOContrSecurity.fnuCanManageContract(ge_contrato.id_contrato) = 1 ' ||CHR(10)|| 
            
            '  AND  to_date(''' || TO_CHAR(IDTPERIODENDDATE, UT_DATE.FSBDATE_FORMAT)||''', ut_date.fsbDATE_FORMAT) >= ' ||CHR(10)|| 
            '     nvl(ge_contrato.fecha_inicial, ut_date.fdtMinDate)'; 
 
        
















 
             
        UT_TRACE.TRACE('sbSql: '||SBSQL, 10 ); 
        OPEN OCUDATACURSOR FOR SBSQL; 
        FETCH OCUDATACURSOR BULK COLLECT INTO OTBCONTRACTS; 
        CLOSE OCUDATACURSOR; 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RAISE EX.CONTROLLED_ERROR; 
 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END GETOPENCONTRACTSTOPROCESS; 
     
    














 
    FUNCTION FBLHASOPENEDCERTIFS 
    ( 
        INUCONTRACTID IN CT_CONPLA_CON_TYPE.CONTRACT_ID%TYPE 
    ) 
    RETURN BOOLEAN 
    IS 
        SBVARIA VARCHAR2(1); 
 
        CURSOR CUCERTIFICATES IS 
            SELECT 'x' 
            FROM GE_ACTA 
                  /*+ CT_BCContract.fblHasOpenedCertifs*/ 
            WHERE GE_ACTA.ID_CONTRATO = INUCONTRACTID 
              AND GE_ACTA.ESTADO = CT_BOCONSTANTS.FSBGETOPENEDCERTIFSTATUS 
              AND ROWNUM < 2; 
    BEGIN 
 
        OPEN CUCERTIFICATES; 
        FETCH CUCERTIFICATES INTO SBVARIA; 
        CLOSE CUCERTIFICATES; 
 
        IF SBVARIA IS NULL THEN 
            RETURN FALSE; 
        ELSE 
            RETURN TRUE; 
        END IF; 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF (CUCERTIFICATES%ISOPEN) THEN 
                CLOSE CUCERTIFICATES; 
            END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            IF (CUCERTIFICATES%ISOPEN) THEN 
                CLOSE CUCERTIFICATES; 
            END IF; 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END FBLHASOPENEDCERTIFS; 
     
    





















 
    PROCEDURE GETCONDPLANSBYPERSON 
    ( 
        INUCONTRACTID	    IN  CT_CONPLA_CON_TYPE.CONTRACT_ID%TYPE, 
        IDTDATE             IN  CT_CONPLA_CON_TYPE.START_DATE%TYPE, 
        OTBCONDITIONSPLANS  OUT CT_BCCONTRACT.TYTBCONDITIONSPLANID 
    ) 
    IS 
        DTMINDATE   DATE := UT_DATE.FDTMINDATE; 
        DTMAXDATE   DATE := UT_DATE.FDTMAXDATE; 
         
        
        CURSOR CUCONDITIONSPLANS 
        IS 
            SELECT /*+ index ( CT_CONPLA_CON_TYPE IDX_CT_CONPLA_CON_TYPE03 ) */ 
                   CT_CONPLA_CON_TYPE.CONDITIONS_PLAN_ID, 
                   CT_CONPLA_CON_TYPE.PERSON_ID 
            FROM   CT_CONPLA_CON_TYPE 
                    /*+ CT_BCContract.GetCondPlansByPerson*/ 
            WHERE  CT_CONPLA_CON_TYPE.CONTRACT_ID = INUCONTRACTID 
              AND  CT_CONPLA_CON_TYPE.FLAG_TYPE = CT_BOCONSTANTS.CSBISCONTRACT 
              AND  IDTDATE BETWEEN NVL(CT_CONPLA_CON_TYPE.START_DATE, 
                                       DTMINDATE) 
                               AND NVL(CT_CONPLA_CON_TYPE.END_DATE, 
                                       DTMAXDATE) 
              AND  CT_CONPLA_CON_TYPE.PERSON_ID IS NOT NULL; 
    BEGIN 
             
        FOR RCCONDITIONSPLANS IN CUCONDITIONSPLANS LOOP 
            OTBCONDITIONSPLANS(RCCONDITIONSPLANS.PERSON_ID) := RCCONDITIONSPLANS.CONDITIONS_PLAN_ID; 
        END LOOP; 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF (CUCONDITIONSPLANS%ISOPEN) THEN 
                CLOSE CUCONDITIONSPLANS; 
            END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            IF (CUCONDITIONSPLANS%ISOPEN) THEN 
                CLOSE CUCONDITIONSPLANS; 
            END IF; 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END GETCONDPLANSBYPERSON; 
     
    



















 
    PROCEDURE GETCONDPLANSBYPERSONTYPE 
    ( 
        INUCONTRACTID	    IN  CT_CONPLA_CON_TYPE.CONTRACT_ID%TYPE, 
        IDTDATE             IN  CT_CONPLA_CON_TYPE.START_DATE%TYPE, 
        OTBCONDITIONSPLANS  OUT CT_BCCONTRACT.TYTBCONDITIONSPLANID 
    ) 
    IS 
        
        CURSOR CUCONDITIONSPLANS 
        IS 
            SELECT /*+ index ( CT_CONDI_PLAN_CONT IDX_CT_CONDI_PLAN_CONT01 ) */ 
                   CT_CONPLA_CON_TYPE.CONDITIONS_PLAN_ID, 
                   CT_CONPLA_CON_TYPE.PERSONAL_TYPE 
            FROM   CT_CONPLA_CON_TYPE 
                    /*+ CT_BCContract.GetCondPlansByPersonType*/ 
            WHERE  CT_CONPLA_CON_TYPE.CONTRACT_ID = INUCONTRACTID 
              AND  CT_CONPLA_CON_TYPE.FLAG_TYPE = CT_BOCONSTANTS.CSBISCONTRACT 
              AND  IDTDATE BETWEEN NVL(CT_CONPLA_CON_TYPE.START_DATE, 
                                       UT_DATE.FDTMINDATE) 
                               AND NVL(CT_CONPLA_CON_TYPE.END_DATE, 
                                       UT_DATE.FDTMAXDATE) 
              AND  CT_CONPLA_CON_TYPE.PERSONAL_TYPE IS NOT NULL; 
    BEGIN 
             
        FOR RCCONDITIONSPLANS IN CUCONDITIONSPLANS LOOP 
            OTBCONDITIONSPLANS(RCCONDITIONSPLANS.PERSONAL_TYPE) := RCCONDITIONSPLANS.CONDITIONS_PLAN_ID; 
        END LOOP; 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF (CUCONDITIONSPLANS%ISOPEN) THEN 
                CLOSE CUCONDITIONSPLANS; 
            END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            IF (CUCONDITIONSPLANS%ISOPEN) THEN 
                CLOSE CUCONDITIONSPLANS; 
            END IF; 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END GETCONDPLANSBYPERSONTYPE; 
 
    















 
    FUNCTION FNUCALBILLCERTDOWNPAYMENT 
    ( 
        INUCONTRACTID    IN  GE_CONTRATO.ID_CONTRATO%TYPE 
    ) 
    RETURN GE_CONTRATO.VALOR_ANTICIPO%TYPE 
    IS 
        NUTOTALVALUE GE_CONTRATO.VALOR_ANTICIPO%TYPE; 
    BEGIN 
        SELECT /*+ index ( GE_DETALLE_ACTA IDX_GE_DETALLE_ACTA_01 ) */ 
               SUM(GE_DETALLE_ACTA.VALOR_TOTAL) VALOR_TOTAL 
        INTO   NUTOTALVALUE 
        FROM   GE_ACTA, 
               GE_DETALLE_ACTA 
                /*+ CT_BCContract.fnuCalBillCertDownPayment*/ 
        WHERE  GE_ACTA.ID_CONTRATO = INUCONTRACTID 
          AND  GE_ACTA.ID_TIPO_ACTA = CT_BOCONSTANTS.FNUGETBILLINGCERTITYPE 
          AND  GE_ACTA.ID_ACTA = GE_DETALLE_ACTA.ID_ACTA 
          AND  GE_DETALLE_ACTA.ID_ITEMS = GE_BOITEMSCONSTANTS.CNUDOWNPAYMENTITEM; 
 
        RETURN ABS(NUTOTALVALUE); 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END FNUCALBILLCERTDOWNPAYMENT; 
     
    













 
    PROCEDURE GETCONTRACTTYPELOV 
    ( 
        ORFREFCURSOR OUT CONSTANTS.TYREFCURSOR 
    ) 
    IS 
    BEGIN 
        UT_TRACE.TRACE('BEGIN CT_BCContract.GetContractTypeLov', 2); 
 
        OPEN ORFREFCURSOR FOR 
            SELECT  GE_TIPO_CONTRATO.ID_TIPO_CONTRATO ID, GE_TIPO_CONTRATO.DESCRIPCION DESCRIPTION 
            FROM    GE_TIPO_CONTRATO; 
 
        UT_TRACE.TRACE('END CT_BCContract.GetContractTypeLov', 2); 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF (ORFREFCURSOR%ISOPEN) THEN 
                CLOSE ORFREFCURSOR; 
            END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            IF (ORFREFCURSOR%ISOPEN) THEN 
                CLOSE ORFREFCURSOR; 
            END IF; 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END GETCONTRACTTYPELOV; 
     
    













 
    PROCEDURE GETCASHTYPELOV 
    ( 
        ORFREFCURSOR OUT CONSTANTS.TYREFCURSOR 
    ) 
    IS 
    BEGIN 
        UT_TRACE.TRACE('BEGIN CT_BCContract.GetCashTypeLov', 2); 
 
        OPEN ORFREFCURSOR FOR 
            SELECT  GST_TIPOMONE.TIMOCODI ID, GST_TIPOMONE.TIMODESC DESCRIPTION 
            FROM    GST_TIPOMONE; 
 
        UT_TRACE.TRACE('END CT_BCContract.GetCashTypeLov', 2); 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF (ORFREFCURSOR%ISOPEN) THEN 
                CLOSE ORFREFCURSOR; 
            END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            IF (ORFREFCURSOR%ISOPEN) THEN 
                CLOSE ORFREFCURSOR; 
            END IF; 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END GETCASHTYPELOV; 
     
    
















 
    PROCEDURE GETCONTRACTSBYCONTRACTOR 
    ( 
       INUCONTRACTORID IN  GE_CONTRATISTA.ID_CONTRATISTA%TYPE, 
       ORFREFCURSOR    OUT CONSTANTS.TYREFCURSOR 
    ) 
    IS 
    BEGIN 
 
        IF (ORFREFCURSOR%ISOPEN) THEN 
            CLOSE ORFREFCURSOR; 
        END IF; 
 
        OPEN ORFREFCURSOR 
         FOR 
      SELECT/*+ Index(ge_contrato IDX_GE_CONTRATO_01)*/ 
             GE_CONTRATO.* 
        FROM GE_CONTRATO 
             /*+ CT_BCContract.GetContractsByContractor*/ 
       WHERE GE_CONTRATO.ID_CONTRATISTA = INUCONTRACTORID 
         AND CT_BOCONTRSECURITY.FNUCANMANAGECONTRACT(GE_CONTRATO.ID_CONTRATO) = 1; 
        
        EXCEPTION 
            WHEN EX.CONTROLLED_ERROR THEN 
                IF (ORFREFCURSOR%ISOPEN) THEN 
                    CLOSE ORFREFCURSOR; 
                END IF; 
                RAISE EX.CONTROLLED_ERROR; 
            WHEN OTHERS THEN 
                IF (ORFREFCURSOR%ISOPEN) THEN 
                    CLOSE ORFREFCURSOR; 
                END IF; 
                ERRORS.SETERROR; 
                RAISE EX.CONTROLLED_ERROR; 
    END GETCONTRACTSBYCONTRACTOR; 
     
    














 
    PROCEDURE GETSTATUSLOV 
    ( 
       ORFREFCURSOR OUT CONSTANTS.TYREFCURSOR 
    ) 
    IS 
    BEGIN 
        IF (ORFREFCURSOR%ISOPEN)THEN 
           CLOSE ORFREFCURSOR; 
        END IF; 
         
          OPEN ORFREFCURSOR 
           FOR 
        SELECT CT_BOCONSTANTS.FSBGETREGISTERSTATUS ID, 
               CT_BOCONSTANTS.FSBGETDESCSTATUS(CT_BOCONSTANTS.FSBGETREGISTERSTATUS) DESCRIPTION 
          FROM DUAL 
         UNION 
        SELECT CT_BOCONSTANTS.FSBGETOPENSTATUS ID, 
               CT_BOCONSTANTS.FSBGETDESCSTATUS(CT_BOCONSTANTS.FSBGETOPENSTATUS) DESCRIPTION 
          FROM DUAL 
         UNION 
        SELECT CT_BOCONSTANTS.FSBGETCANCELSTATUS ID, 
               CT_BOCONSTANTS.FSBGETDESCSTATUS(CT_BOCONSTANTS.FSBGETCANCELSTATUS) DESCRIPTION 
          FROM DUAL 
         UNION 
        SELECT CT_BOCONSTANTS.FSBGETCLOSEDSTATUS ID, 
               CT_BOCONSTANTS.FSBGETDESCSTATUS(CT_BOCONSTANTS.FSBGETCLOSEDSTATUS) DESCRIPTION 
          FROM DUAL 
         UNION 
        SELECT CT_BOCONSTANTS.FSBGETSUSPENDSTATUS ID, 
               CT_BOCONSTANTS.FSBGETDESCSTATUS(CT_BOCONSTANTS.FSBGETSUSPENDSTATUS) DESCRIPTION 
          FROM DUAL; 
 
        EXCEPTION 
            WHEN EX.CONTROLLED_ERROR THEN 
                IF (ORFREFCURSOR%ISOPEN)THEN 
                   CLOSE ORFREFCURSOR; 
                END IF; 
                RAISE EX.CONTROLLED_ERROR; 
            WHEN OTHERS THEN 
                IF (ORFREFCURSOR%ISOPEN)THEN 
                   CLOSE ORFREFCURSOR; 
                END IF; 
                ERRORS.SETERROR; 
                RAISE EX.CONTROLLED_ERROR; 
    END GETSTATUSLOV; 
     
    














 
    FUNCTION FBLCONTRACTHASORDERS 
    ( 
      INUCONTRACTID  IN GE_CONTRATO.ID_CONTRATO%TYPE 
    ) 
    RETURN BOOLEAN 
	 IS 
        NUORDERID OR_ORDER.ORDER_ID%TYPE; 
        CURSOR CUORDENESCONTRATO 
        IS 
           SELECT CT_ORDER_CERTIFICA.ORDER_ID 
           FROM   GE_ACTA, 
                  CT_ORDER_CERTIFICA 
                  /*+ CT_BCContract.fblContractHasOrders*/ 
           WHERE  GE_ACTA.ID_CONTRATO = INUCONTRACTID 
           AND    GE_ACTA.ID_ACTA = CT_ORDER_CERTIFICA.CERTIFICATE_ID; 
    BEGIN 
        OPEN CUORDENESCONTRATO; 
        FETCH CUORDENESCONTRATO INTO NUORDERID; 
        CLOSE CUORDENESCONTRATO; 
 
        IF (NUORDERID IS NULL) THEN 
            RETURN FALSE; 
        ELSE 
            RETURN TRUE; 
        END IF; 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF CUORDENESCONTRATO%ISOPEN THEN 
               CLOSE CUORDENESCONTRATO; 
            END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
            IF CUORDENESCONTRATO%ISOPEN THEN 
               CLOSE CUORDENESCONTRATO; 
            END IF; 
            RAISE EX.CONTROLLED_ERROR; 
    END FBLCONTRACTHASORDERS; 
 
    














 
    FUNCTION FBLHASCONTRACTTASKTYPES 
    ( 
        INUCONTRACTID   IN GE_CONTRATO.ID_CONTRATO%TYPE 
    ) RETURN BOOLEAN 
    IS 
        
        SBRESULT    VARCHAR2(1); 
    BEGIN 
        
        UT_TRACE.TRACE('INICIO CT_BCContract.fblHasContractTaskTypes',10); 
 
        SELECT  /*+index (CT_TASKTYPE_CONTYPE IDX_CT_TASKTYPE_CONTYPE02)*/ 
                'X' 
        INTO    SBRESULT 
        FROM    CT_TASKTYPE_CONTYPE 
                /*+ CT_BCContract.fblHasContractTaskTypes*/ 
        WHERE   CONTRACT_ID = INUCONTRACTID 
        AND     FLAG_TYPE = CT_BOCONSTANTS.CSBISCONTRACT 
        AND ROWNUM < 2; 
 
        IF (SBRESULT IS NOT NULL ) THEN 
            UT_TRACE.TRACE('FIN CT_BCContract.fblHasContractTaskTypes',10); 
            RETURN TRUE; 
        ELSE 
            UT_TRACE.TRACE('FIN CT_BCContract.fblHasContractTaskTypes',10); 
            RETURN FALSE; 
        END IF; 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RETURN FALSE; 
        WHEN OTHERS THEN 
            RETURN FALSE; 
    END FBLHASCONTRACTTASKTYPES; 
     
    















 
    FUNCTION FBLHASCONTTYPETASKTYPES 
    ( 
        INUCONTRACTTYPEID   IN GE_CONTRATO.ID_TIPO_CONTRATO%TYPE 
    ) RETURN BOOLEAN 
    IS 
        
        SBRESULT    VARCHAR2(1); 
    BEGIN 
        
        UT_TRACE.TRACE('INICIO CT_BCContract.fblHasContTypeTaskTypes',10); 
 
        
        SELECT  /*+index (CT_TASKTYPE_CONTYPE IDX_CT_TASKTYPE_CONTYPE01)*/ 
                'X' 
        INTO    SBRESULT 
        FROM    CT_TASKTYPE_CONTYPE 
                /*+ CT_BCContract.fblHasContTypeTaskTypes SAO207690 */ 
        WHERE   CONTRACT_TYPE_ID = INUCONTRACTTYPEID 
        AND     FLAG_TYPE = CT_BOCONSTANTS.CSBISCONTRACTTYPE 
        AND ROWNUM < 2; 
 
        IF (SBRESULT IS NOT NULL ) THEN 
            UT_TRACE.TRACE('FIN CT_BCContract.fblHasContTypeTaskTypes [TRUE]',10); 
            RETURN TRUE; 
        END IF; 
        UT_TRACE.TRACE('FIN CT_BCContract.fblHasContTypeTaskTypes [FALSE]',10); 
        RETURN FALSE; 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RETURN FALSE; 
        WHEN OTHERS THEN 
            RETURN FALSE; 
    END FBLHASCONTTYPETASKTYPES; 
     
    
















 
    PROCEDURE GETACTIVECONTRACTS 
    ( 
        INUCONTRACTOR   IN  GE_CONTRATISTA.ID_CONTRATISTA%TYPE, 
        IDTDATE         IN  DATE DEFAULT UT_DATE.FDTSYSDATE, 
        OTBCONTRACTS    IN OUT NOCOPY DAGE_CONTRATO.TYTBGE_CONTRATO 
    ) 
    IS 
        
        CUCURSOR    CONSTANTS.TYREFCURSOR; 
    BEGIN 
        
        UT_TRACE.TRACE('INICIO CT_BCContract.GetActiveContracts',10); 
 
        
        IF CUCURSOR%ISOPEN THEN CLOSE CUCURSOR; END IF; 
 
        
        OPEN CUCURSOR FOR 
            SELECT  /*+INDEX (GE_CONTRATO IDX_GE_CONTRATO_01)*/ 
                    GE_CONTRATO.*, 
                    GE_CONTRATO.ROWID 
            FROM    GE_CONTRATO 
                    /*+ CT_BCContract.GetActiveContracts*/ 
            WHERE   GE_CONTRATO.ID_CONTRATISTA = INUCONTRACTOR 
            AND     (GE_CONTRATO.FECHA_INICIAL <= IDTDATE OR GE_CONTRATO.FECHA_INICIAL IS NULL) 
            AND     (GE_CONTRATO.FECHA_FINAL   >= IDTDATE OR GE_CONTRATO.FECHA_FINAL IS NULL) 
            ORDER BY NVL(GE_CONTRATO.FECHA_INICIAL,UT_DATE.FDTMINDATE), NVL(GE_CONTRATO.FECHA_FINAL,UT_DATE.FDTMAXDATE) ASC; 
 
        FETCH CUCURSOR BULK COLLECT INTO OTBCONTRACTS; 
        CLOSE CUCURSOR; 
 
        UT_TRACE.TRACE('FIN CT_BCContract.GetActiveContracts',10); 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF CUCURSOR%ISOPEN THEN CLOSE CUCURSOR; END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            IF CUCURSOR%ISOPEN THEN CLOSE CUCURSOR; END IF; 
            RAISE EX.CONTROLLED_ERROR; 
    END GETACTIVECONTRACTS; 
     
    
















 
    PROCEDURE GETOPENACTIVECONTRACTS 
    ( 
        INUCONTRACTOR   IN  GE_CONTRATISTA.ID_CONTRATISTA%TYPE, 
        IDTDATE         IN  DATE DEFAULT UT_DATE.FDTSYSDATE, 
        OTBCONTRACTS    IN OUT NOCOPY DAGE_CONTRATO.TYTBGE_CONTRATO 
    ) 
    IS 
        
        CUCURSOR    CONSTANTS.TYREFCURSOR; 
    BEGIN 
        
        UT_TRACE.TRACE('INICIO CT_BCContract.GetOpenActiveContracts',10); 
 
        
        IF CUCURSOR%ISOPEN THEN CLOSE CUCURSOR; END IF; 
 
        
        OPEN CUCURSOR FOR 
            SELECT  /*+INDEX (GE_CONTRATO IDX_GE_CONTRATO_01)*/ 
                    GE_CONTRATO.*, 
                    GE_CONTRATO.ROWID 
            FROM    GE_CONTRATO 
                    /*+ CT_BCContract.GetOpenActiveContracts SAO212226 */ 
            WHERE   GE_CONTRATO.ID_CONTRATISTA = INUCONTRACTOR 
            AND     GE_CONTRATO.STATUS = CT_BOCONSTANTS.FSBGETOPENSTATUS 
            AND     (GE_CONTRATO.FECHA_INICIAL <= IDTDATE OR GE_CONTRATO.FECHA_INICIAL IS NULL) 
            AND     (GE_CONTRATO.FECHA_FINAL   >= IDTDATE OR GE_CONTRATO.FECHA_FINAL IS NULL) 
            ORDER BY NVL(GE_CONTRATO.FECHA_INICIAL,UT_DATE.FDTMINDATE), NVL(GE_CONTRATO.FECHA_FINAL,UT_DATE.FDTMAXDATE) ASC; 
 
        FETCH CUCURSOR BULK COLLECT INTO OTBCONTRACTS; 
        CLOSE CUCURSOR; 
 
        UT_TRACE.TRACE('FIN CT_BCContract.GetOpenActiveContracts',10); 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF CUCURSOR%ISOPEN THEN CLOSE CUCURSOR; END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            IF CUCURSOR%ISOPEN THEN CLOSE CUCURSOR; END IF; 
            RAISE EX.CONTROLLED_ERROR; 
    END GETOPENACTIVECONTRACTS; 
     
    















 
    FUNCTION FBLAPPLYCONTBYTASKTYPE 
    ( 
        INUCONTRACTID   IN GE_CONTRATO.ID_CONTRATO%TYPE, 
        INUTASKTYPEID   IN OR_ORDER.TASK_TYPE_ID%TYPE 
    ) RETURN BOOLEAN 
    IS 
        
        SBRESULT    VARCHAR2(1); 
    BEGIN 
        
        UT_TRACE.TRACE('INICIO CT_BCContract.fblApplyContByTaskType',10); 
 
        SELECT  /*+index (CT_TASKTYPE_CONTYPE IDX_CT_TASKTYPE_CONTYPE02)*/ 
                'X' 
        INTO    SBRESULT 
        FROM    CT_TASKTYPE_CONTYPE 
                /*+ CT_BCContract.fblApplyContByTaskType*/ 
        WHERE   CONTRACT_ID   = INUCONTRACTID 
        AND     TASK_TYPE_ID  = INUTASKTYPEID 
        AND     FLAG_TYPE     = CT_BOCONSTANTS.CSBISCONTRACT 
        AND ROWNUM < 2; 
 
        UT_TRACE.TRACE('FIN CT_BCContract.fblApplyContByTaskType',10); 
 
        RETURN SBRESULT IS NOT NULL; 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RETURN FALSE; 
        WHEN OTHERS THEN 
            RETURN FALSE; 
    END FBLAPPLYCONTBYTASKTYPE; 
     
    















 
    FUNCTION FBLAPPLYCONTTYPEBYTSKTYPE 
    ( 
        INUCONTTYPEID   IN GE_CONTRATO.ID_TIPO_CONTRATO%TYPE, 
        INUTASKTYPEID   IN OR_ORDER.TASK_TYPE_ID%TYPE 
    ) RETURN BOOLEAN 
    IS 
        
        SBRESULT    VARCHAR2(1); 
    BEGIN 
        
        UT_TRACE.TRACE('INICIO CT_BCContract.fblApplyContTypeByTskType',10); 
 
        SELECT  /*+index (CT_TASKTYPE_CONTYPE IDX_CT_TASKTYPE_CONTYPE01)*/ 
                'X' 
        INTO    SBRESULT 
        FROM    CT_TASKTYPE_CONTYPE 
                /*+ CT_BCContract.fblApplyContTypeByTskType*/ 
        WHERE   CONTRACT_TYPE_ID = INUCONTTYPEID 
        AND     TASK_TYPE_ID     = INUTASKTYPEID 
        AND     FLAG_TYPE        = CT_BOCONSTANTS.CSBISCONTRACTTYPE 
        AND ROWNUM < 2; 
 
        UT_TRACE.TRACE('FIN CT_BCContract.fblApplyContTypeByTskType',10); 
 
        RETURN SBRESULT IS NOT NULL; 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RETURN FALSE; 
        WHEN OTHERS THEN 
            RETURN FALSE; 
    END FBLAPPLYCONTTYPEBYTSKTYPE; 
     
    












































 
    PROCEDURE SETALLORDERSWBASE 
    ( 
        IDTBREAKDATE        IN         GE_ACTA.FECHA_FIN%TYPE, 
        INUCONTRACTID       IN         GE_CONTRATO.ID_CONTRATO%TYPE 
    ) 
    IS 
 
        TBROWID             DAOR_ORDER.TYTBROWID; 
 
        DTBREAKDATE         DATE; 
 
        
        CURSOR CUALLORDERS IS 
             SELECT /*+ ordered 
                        index(or_order IDX_OR_ORDER21) 
                        index(ge_causal PK_GE_CAUSAL) */ 
                    OR_ORDER.ROWID 
             FROM   OR_ORDER, 
                    GE_CAUSAL 
                    /*+ CT_BCContract.SetAllOrdersWBase*/ 
             WHERE 
                   
                   OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED 
                   
               AND OR_ORDER.CAUSAL_ID = GE_CAUSAL.CAUSAL_ID 
               AND GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL 
                   
               AND OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE 
                   
               AND OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES 
                    
               AND  OR_ORDER.DEFINED_CONTRACT_ID = INUCONTRACTID; 
    BEGIN 
        DTBREAKDATE := TRUNC(IDTBREAKDATE); 
        OPEN CUALLORDERS; 
         
        LOOP 
            FETCH CUALLORDERS BULK COLLECT INTO TBROWID LIMIT CT_BOCONSTANTS.CNUORDERSNUMBER; 
 
            FORALL I IN 1..TBROWID.COUNT 
                INSERT INTO TMP_VARCHAR(FIELD) VALUES (TBROWID(I)); 
            EXIT WHEN CUALLORDERS%NOTFOUND; 
            TBROWID.DELETE; 
        END LOOP; 
        CLOSE CUALLORDERS; 
             
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF (CUALLORDERS%ISOPEN) THEN 
                CLOSE CUALLORDERS; 
            END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            IF (CUALLORDERS%ISOPEN) THEN 
                CLOSE CUALLORDERS; 
            END IF; 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END SETALLORDERSWBASE; 
     
    













































 
    PROCEDURE SETALLORDERSABASE 
    ( 
        INUADMINBASEID	    IN         GE_ACTA.ID_BASE_ADMINISTRATIVA%TYPE, 
        IDTBREAKDATE        IN         GE_ACTA.FECHA_FIN%TYPE, 
        INUCONTRACTID       IN         GE_CONTRATO.ID_CONTRATO%TYPE 
    ) 
    IS 
        TBROWID             DAOR_ORDER.TYTBROWID; 
        DTBREAKDATE         DATE; 
 
        
        
        CURSOR CUORDERSADMINBASE IS 
            SELECT 
                        /*+ 
                            ordered 
                            index(or_order IDX_OR_ORDER21) 
                            index (or_operating_unit PK_OR_OPERATING_UNIT) 
                            index(ge_causal PK_GE_CAUSAL) 
                        */ 
                    OR_ORDER.ROWID 
             FROM   OR_ORDER, 
                    OR_OPERATING_UNIT, 
                    GE_CAUSAL 
                    /*+ CT_BCContract.SetAllOrdersABase*/ 
             WHERE 
                   
                   OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED 
                   
               AND OR_ORDER.CAUSAL_ID = GE_CAUSAL.CAUSAL_ID 
               AND GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL 
                   
               AND OR_ORDER.OPERATING_UNIT_ID = OR_OPERATING_UNIT.OPERATING_UNIT_ID 
                   
               AND OR_OPERATING_UNIT.ADMIN_BASE_ID = INUADMINBASEID 
                   
               AND OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE 
                   
               AND OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES 
                    
               AND  OR_ORDER.DEFINED_CONTRACT_ID = INUCONTRACTID; 
    BEGIN 
        DTBREAKDATE := TRUNC(IDTBREAKDATE); 
 
        OPEN CUORDERSADMINBASE; 
         
        LOOP 
            FETCH CUORDERSADMINBASE BULK COLLECT INTO TBROWID LIMIT CT_BOCONSTANTS.CNUORDERSNUMBER; 
 
            FORALL I IN 1..TBROWID.COUNT 
                INSERT INTO TMP_VARCHAR(FIELD) VALUES (TBROWID(I)); 
            EXIT WHEN CUORDERSADMINBASE%NOTFOUND; 
            TBROWID.DELETE; 
        END LOOP; 
        CLOSE CUORDERSADMINBASE; 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF (CUORDERSADMINBASE%ISOPEN) THEN 
                CLOSE CUORDERSADMINBASE; 
            END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            IF (CUORDERSADMINBASE%ISOPEN) THEN 
                CLOSE CUORDERSADMINBASE; 
            END IF; 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END SETALLORDERSABASE; 
     
    















 
    FUNCTION FNUCOUNTNOCLOSEOCONTRACTS 
    ( 
        INUCONTRACTORID	    IN         GE_CONTRATISTA.ID_CONTRATISTA%TYPE 
    ) 
    RETURN NUMBER 
    IS 
        NUCOUNT     NUMBER; 
    BEGIN 
 
        SELECT  COUNT(*) 
        INTO    NUCOUNT 
        FROM    GE_CONTRATO 
        WHERE   ID_CONTRATISTA = INUCONTRACTORID 
        AND     STATUS IN (CT_BOCONSTANTS.FSBGETOPENSTATUS, CT_BOCONSTANTS.FSBGETREGISTERSTATUS, CT_BOCONSTANTS.FSBGETSUSPENDSTATUS); 
 
        RETURN NUCOUNT; 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RETURN 0; 
        WHEN OTHERS THEN 
            RETURN 0; 
    END FNUCOUNTNOCLOSEOCONTRACTS; 
     
    













 
    PROCEDURE GETACCOUNTCLASSIFLOV 
    ( 
        ORFREFCURSOR OUT CONSTANTS.TYREFCURSOR 
    ) 
    IS 
    BEGIN 
        UT_TRACE.TRACE('BEGIN CT_BCContract.GetAccountClassifLoV', 2); 
 
        OPEN ORFREFCURSOR FOR 
            SELECT  GE_ACCOUNT_CLASSIF.ACCOUNT_CLASSIF_ID ID, GE_ACCOUNT_CLASSIF.DESCRIPTION DESCRIPTION 
            FROM    GE_ACCOUNT_CLASSIF 
            /*+ CT_BCContract.GetAccountClassifLoV SAO212073 */; 
 
        UT_TRACE.TRACE('END CT_BCContract.GetAccountClassifLoV', 2); 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF (ORFREFCURSOR%ISOPEN) THEN 
                CLOSE ORFREFCURSOR; 
            END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            IF (ORFREFCURSOR%ISOPEN) THEN 
                CLOSE ORFREFCURSOR; 
            END IF; 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END GETACCOUNTCLASSIFLOV; 
     
    




















 
    PROCEDURE SETORDERSBYTASKCONTRACTWBASE 
    ( 
        INUCONTRACTORID	    IN         GE_CONTRATISTA.ID_CONTRATISTA%TYPE, 
        IDTBREAKDATE        IN         GE_ACTA.FECHA_FIN%TYPE, 
        INUCONTRACTID       IN         GE_CONTRATO.ID_CONTRATO%TYPE, 
        ISBFLAGTYPE         IN         CT_TASKTYPE_CONTYPE.FLAG_TYPE%TYPE 
    ) 
    IS 
        TBROWID             DAOR_ORDER.TYTBROWID; 
        DTBREAKDATE         DATE; 
 
        
        
        CURSOR CUALLORDERSBYTASKCONTRACT IS 
             SELECT /*+ ordered 
                        index(or_order IDX_OR_ORDER21) 
                        index(ge_causal PK_GE_CAUSAL) */ 
                    OR_ORDER.ROWID 
             FROM   OR_ORDER, 
                    GE_CAUSAL 
             WHERE 
                   
                   OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED 
                   
               AND OR_ORDER.CAUSAL_ID = GE_CAUSAL.CAUSAL_ID 
               AND GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL 
                   
               AND OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE 
                   
               AND OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES 
                    
               AND  OR_ORDER.DEFINED_CONTRACT_ID = INUCONTRACTID 
          UNION 
             SELECT 
             /*+ ordered 
                        index (or_operating_unit IDX_OR_OPERATING_UNIT10) 
                        index(or_order  IDX_OR_ORDER_3) 
                        INDEX (ct_tasktype_contype  IDX_CT_TASKTYPE_CONTYPE01) 
                        index(ge_causal PK_GE_CAUSAL)*/ 
                    OR_ORDER.ROWID 
             FROM   OR_OPERATING_UNIT, 
                    OR_ORDER, 
                    CT_TASKTYPE_CONTYPE, 
                    GE_CAUSAL 
                    /*+ CT_BCContract.SetOrdersByTaskContractWBase*/ 
             WHERE  
                    OR_OPERATING_UNIT.CONTRACTOR_ID = INUCONTRACTORID 
               AND  OR_OPERATING_UNIT.ES_EXTERNA = GE_BOCONSTANTS.CSBYES 
               AND  OR_ORDER.OPERATING_UNIT_ID = OR_OPERATING_UNIT.OPERATING_UNIT_ID 
               
               AND  OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED 
                
               AND  OR_ORDER.CAUSAL_ID = GE_CAUSAL.CAUSAL_ID 
               AND  GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL 
                    
               AND  OR_ORDER.TASK_TYPE_ID = CT_TASKTYPE_CONTYPE.TASK_TYPE_ID 
               AND  CT_TASKTYPE_CONTYPE.CONTRACT_ID = INUCONTRACTID 
               AND  CT_TASKTYPE_CONTYPE.FLAG_TYPE = ISBFLAGTYPE 
                    
               AND  OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE 
                    
               AND OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES 
                    
               AND  OR_ORDER.DEFINED_CONTRACT_ID IS NULL; 
    BEGIN 
        DTBREAKDATE := TRUNC(IDTBREAKDATE); 
        OPEN CUALLORDERSBYTASKCONTRACT; 
 
        LOOP 
            FETCH CUALLORDERSBYTASKCONTRACT BULK COLLECT INTO TBROWID LIMIT CT_BOCONSTANTS.CNUORDERSNUMBER; 
 
            FORALL I IN 1..TBROWID.COUNT 
                INSERT INTO TMP_VARCHAR(FIELD) VALUES (TBROWID(I)); 
            EXIT WHEN CUALLORDERSBYTASKCONTRACT%NOTFOUND; 
            TBROWID.DELETE; 
        END LOOP; 
        CLOSE CUALLORDERSBYTASKCONTRACT; 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END SETORDERSBYTASKCONTRACTWBASE; 
     
    






















 
    PROCEDURE SETORDERSBYTASKCONTTYPEWBASE 
    ( 
        INUCONTRACTORID	    IN         GE_CONTRATISTA.ID_CONTRATISTA%TYPE, 
        IDTBREAKDATE        IN         GE_ACTA.FECHA_FIN%TYPE, 
        INUCONTRACTID       IN         GE_CONTRATO.ID_CONTRATO%TYPE, 
        INUCONTRACTTYPEID   IN         GE_CONTRATO.ID_TIPO_CONTRATO%TYPE, 
        ISBFLAGTYPE         IN         CT_TASKTYPE_CONTYPE.FLAG_TYPE%TYPE 
    ) 
    IS 
        TBROWID             DAOR_ORDER.TYTBROWID; 
        DTBREAKDATE         DATE; 
 
        
        
        CURSOR CUALLORDERSBYTASKCONTTYPE IS 
              SELECT /*+ ordered index(or_order IDX_OR_ORDER21) 
                        index(ge_causal PK_GE_CAUSAL)*/ 
                    OR_ORDER.ROWID 
             FROM   OR_ORDER, 
                    GE_CAUSAL 
             WHERE 
                
                OR_ORDER.DEFINED_CONTRACT_ID = INUCONTRACTID 
                
                AND OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES 
                
                AND  OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED 
                   
                AND OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE 
                   
                AND GE_CAUSAL.CAUSAL_ID = OR_ORDER.CAUSAL_ID 
                AND GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL 
          UNION 
             SELECT /*+ ordered 
                        index (or_operating_unit IDX_OR_OPERATING_UNIT10) 
                        index(or_order  IDX_OR_ORDER_3) 
                        INDEX (ct_tasktype_contype  IDX_CT_TASKTYPE_CONTYPE01) 
                        index(ge_causal PK_GE_CAUSAL)*/ 
                    OR_ORDER.ROWID 
             FROM   OR_OPERATING_UNIT, 
                    OR_ORDER, 
                    CT_TASKTYPE_CONTYPE, 
                    GE_CAUSAL 
                    /*+ CT_BCContract.SetOrdersByTaskContTypeWBase*/ 
             WHERE 
                    OR_OPERATING_UNIT.CONTRACTOR_ID = INUCONTRACTORID 
               AND  OR_OPERATING_UNIT.ES_EXTERNA = GE_BOCONSTANTS.CSBYES 
               AND  OR_ORDER.OPERATING_UNIT_ID = OR_OPERATING_UNIT.OPERATING_UNIT_ID 
                    
               AND  OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED 
                    
               AND  GE_CAUSAL.CAUSAL_ID = OR_ORDER.CAUSAL_ID 
               AND  GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL 
               
               AND  OR_ORDER.TASK_TYPE_ID = CT_TASKTYPE_CONTYPE.TASK_TYPE_ID 
               AND  CT_TASKTYPE_CONTYPE.CONTRACT_TYPE_ID = INUCONTRACTTYPEID 
               AND  CT_TASKTYPE_CONTYPE.FLAG_TYPE = ISBFLAGTYPE 
                    
               AND  OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE 
                    
               AND OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES 
                    
               AND  OR_ORDER.DEFINED_CONTRACT_ID IS NULL; 
    BEGIN 
        DTBREAKDATE := TRUNC(IDTBREAKDATE); 
        OPEN CUALLORDERSBYTASKCONTTYPE; 
 
        LOOP 
            FETCH CUALLORDERSBYTASKCONTTYPE BULK COLLECT INTO TBROWID LIMIT CT_BOCONSTANTS.CNUORDERSNUMBER; 
 
            FORALL I IN 1..TBROWID.COUNT 
                INSERT INTO TMP_VARCHAR(FIELD) VALUES (TBROWID(I)); 
            EXIT WHEN CUALLORDERSBYTASKCONTTYPE%NOTFOUND; 
            TBROWID.DELETE; 
        END LOOP; 
        CLOSE CUALLORDERSBYTASKCONTTYPE; 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END SETORDERSBYTASKCONTTYPEWBASE; 
     
    























 
    PROCEDURE SETORDERSBYTASKCONTRACTABASE 
    ( 
        INUCONTRACTORID	    IN         GE_CONTRATISTA.ID_CONTRATISTA%TYPE, 
        INUADMINBASEID	    IN         GE_ACTA.ID_BASE_ADMINISTRATIVA%TYPE, 
        IDTBREAKDATE        IN         GE_ACTA.FECHA_FIN%TYPE, 
        INUCONTRACTID       IN         GE_CONTRATO.ID_CONTRATO%TYPE, 
        ISBFLAGTYPE         IN         CT_TASKTYPE_CONTYPE.FLAG_TYPE%TYPE 
    ) 
    IS 
        TBROWID             DAOR_ORDER.TYTBROWID; 
        DTBREAKDATE         DATE; 
 
        
        
        CURSOR CUORDERSADMBASTASKCONTRACT IS 
             SELECT OR_ORDER.ROWID 
             FROM   OR_ORDER, 
                    OR_OPERATING_UNIT, 
                    GE_CAUSAL 
             WHERE 
                   
                   OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED 
                   
               AND OR_ORDER.CAUSAL_ID = GE_CAUSAL.CAUSAL_ID 
               AND GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL 
                   
               AND OR_ORDER.OPERATING_UNIT_ID = OR_OPERATING_UNIT.OPERATING_UNIT_ID 
                   
               AND OR_OPERATING_UNIT.ADMIN_BASE_ID = INUADMINBASEID 
                   
               AND OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE 
                   
               AND OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES 
                    
               AND  OR_ORDER.DEFINED_CONTRACT_ID = INUCONTRACTID 
        UNION 
             SELECT 
                    OR_ORDER.ROWID 
             FROM   OR_ORDER, 
                    OR_OPERATING_UNIT, 
                    CT_TASKTYPE_CONTYPE, 
                    GE_CAUSAL 
                    /*+ CT_BCContract.SetOrdersByTaskContractABase*/ 
             WHERE 
                    
                    OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED 
                    
               AND  OR_ORDER.CAUSAL_ID = GE_CAUSAL.CAUSAL_ID 
               AND  GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL 
                    
               AND  OR_ORDER.OPERATING_UNIT_ID = OR_OPERATING_UNIT.OPERATING_UNIT_ID 
               AND  OR_OPERATING_UNIT.CONTRACTOR_ID = INUCONTRACTORID 
               AND  OR_OPERATING_UNIT.ES_EXTERNA = GE_BOCONSTANTS.CSBYES 
                    
               AND  OR_OPERATING_UNIT.ADMIN_BASE_ID = INUADMINBASEID 
                    
               AND  OR_ORDER.TASK_TYPE_ID = CT_TASKTYPE_CONTYPE.TASK_TYPE_ID 
               AND  CT_TASKTYPE_CONTYPE.CONTRACT_ID = INUCONTRACTID 
               AND  CT_TASKTYPE_CONTYPE.FLAG_TYPE = ISBFLAGTYPE 
                    
               AND  OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE 
                    
               AND OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES 
                    
               AND  OR_ORDER.DEFINED_CONTRACT_ID IS NULL; 
    BEGIN 
        DTBREAKDATE := TRUNC(IDTBREAKDATE); 
        OPEN CUORDERSADMBASTASKCONTRACT; 
 
        LOOP 
            FETCH CUORDERSADMBASTASKCONTRACT BULK COLLECT INTO TBROWID LIMIT CT_BOCONSTANTS.CNUORDERSNUMBER; 
 
            FORALL I IN 1..TBROWID.COUNT 
                INSERT INTO TMP_VARCHAR(FIELD) VALUES (TBROWID(I)); 
            EXIT WHEN CUORDERSADMBASTASKCONTRACT%NOTFOUND; 
            TBROWID.DELETE; 
        END LOOP; 
        CLOSE CUORDERSADMBASTASKCONTRACT; 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END SETORDERSBYTASKCONTRACTABASE; 
     
    























 
    PROCEDURE SETORDERSBYTASKCONTTYPEABASE 
    ( 
        INUCONTRACTORID	    IN         GE_CONTRATISTA.ID_CONTRATISTA%TYPE, 
        INUADMINBASEID	    IN         GE_ACTA.ID_BASE_ADMINISTRATIVA%TYPE, 
        IDTBREAKDATE        IN         GE_ACTA.FECHA_FIN%TYPE, 
        INUCONTRACTID       IN         GE_CONTRATO.ID_CONTRATO%TYPE, 
        INUCONTRACTTYPEID   IN         GE_CONTRATO.ID_TIPO_CONTRATO%TYPE, 
        ISBFLAGTYPE         IN         CT_TASKTYPE_CONTYPE.FLAG_TYPE%TYPE 
    ) 
    IS 
        TBROWID             DAOR_ORDER.TYTBROWID; 
        DTBREAKDATE         DATE; 
 
        
        
        CURSOR CUORDERSADMBASTASKCONTTYPE IS 
             SELECT 
                    OR_ORDER.ROWID 
             FROM   OR_ORDER, 
                    OR_OPERATING_UNIT, 
                    GE_CAUSAL 
             WHERE 
                   
                   OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED 
                   
               AND OR_ORDER.CAUSAL_ID = GE_CAUSAL.CAUSAL_ID 
               AND GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL 
                   
               AND OR_ORDER.OPERATING_UNIT_ID = OR_OPERATING_UNIT.OPERATING_UNIT_ID 
                   
               AND OR_OPERATING_UNIT.ADMIN_BASE_ID = INUADMINBASEID 
                   
               AND OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE 
                   
               AND OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES 
                    
               AND  OR_ORDER.DEFINED_CONTRACT_ID = INUCONTRACTID 
        UNION 
             SELECT 
                    OR_ORDER.ROWID 
             FROM   OR_ORDER, 
                    OR_OPERATING_UNIT, 
                    CT_TASKTYPE_CONTYPE, 
                    GE_CAUSAL 
                    /*+ CT_BCContract.SetOrdersByTaskContTypeABase*/ 
             WHERE 
                    
                    OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED 
                    
               AND  OR_ORDER.CAUSAL_ID = GE_CAUSAL.CAUSAL_ID 
               AND  GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL 
                    
               AND  OR_ORDER.OPERATING_UNIT_ID = OR_OPERATING_UNIT.OPERATING_UNIT_ID 
               AND  OR_OPERATING_UNIT.CONTRACTOR_ID = INUCONTRACTORID 
               AND  OR_OPERATING_UNIT.ES_EXTERNA = GE_BOCONSTANTS.CSBYES 
                    
               AND  OR_OPERATING_UNIT.ADMIN_BASE_ID = INUADMINBASEID 
                    
               AND  OR_ORDER.TASK_TYPE_ID = CT_TASKTYPE_CONTYPE.TASK_TYPE_ID 
               AND  CT_TASKTYPE_CONTYPE.CONTRACT_TYPE_ID = INUCONTRACTTYPEID 
               AND  CT_TASKTYPE_CONTYPE.FLAG_TYPE = ISBFLAGTYPE 
                    
               AND  OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE 
                    
               AND OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES 
                    
               AND  OR_ORDER.DEFINED_CONTRACT_ID IS NULL; 
    BEGIN 
        DTBREAKDATE := TRUNC(IDTBREAKDATE); 
        OPEN CUORDERSADMBASTASKCONTTYPE; 
 
        LOOP 
            FETCH CUORDERSADMBASTASKCONTTYPE BULK COLLECT INTO TBROWID LIMIT CT_BOCONSTANTS.CNUORDERSNUMBER; 
 
            FORALL I IN 1..TBROWID.COUNT 
                INSERT INTO TMP_VARCHAR(FIELD) VALUES (TBROWID(I)); 
            EXIT WHEN CUORDERSADMBASTASKCONTTYPE%NOTFOUND; 
            TBROWID.DELETE; 
        END LOOP; 
        CLOSE CUORDERSADMBASTASKCONTTYPE; 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END SETORDERSBYTASKCONTTYPEABASE; 
     
 
    














 
    FUNCTION FNUCALBILLCERTWARRANTY 
    ( 
        INUCONTRACTID    IN  GE_CONTRATO.ID_CONTRATO%TYPE 
    ) 
    RETURN GE_CONTRATO.ACUMUL_FONDO_GARANT%TYPE 
    IS 
        NUTOTALVALUE        GE_CONTRATO.ACUMUL_FONDO_GARANT%TYPE; 
        ITEMFONDOGARANTIA   GE_CONTRATO.ACUMUL_FONDO_GARANT%TYPE := GE_BOPARAMETER.FNUVALORNUMERICO('ITEM_FONDO_GARANTIA'); 
    BEGIN 
        SELECT /*+ index ( GE_DETALLE_ACTA IDX_GE_DETALLE_ACTA_01 ) */ 
               SUM(GE_DETALLE_ACTA.VALOR_TOTAL) VALOR_TOTAL 
        INTO   NUTOTALVALUE 
        FROM   GE_ACTA, 
               GE_DETALLE_ACTA 
                /*+ CT_BCContract.fnuCalBillCertDownPayment*/ 
        WHERE  GE_ACTA.ID_CONTRATO = INUCONTRACTID 
          AND  GE_ACTA.ID_TIPO_ACTA = CT_BOCONSTANTS.FNUGETBILLINGCERTITYPE 
          AND  GE_ACTA.ID_ACTA = GE_DETALLE_ACTA.ID_ACTA 
          AND  GE_DETALLE_ACTA.ID_ITEMS = ITEMFONDOGARANTIA; 
 
        RETURN ABS(NUTOTALVALUE); 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END FNUCALBILLCERTWARRANTY; 
 
     
    

















 
    PROCEDURE GETACTIVECONTRATVAL 
    ( 
        INUCONTRACTOR   IN  GE_CONTRATISTA.ID_CONTRATISTA%TYPE, 
        IDTDATE         IN  DATE DEFAULT UT_DATE.FDTSYSDATE, 
        INUORDERCOST    IN  OR_ORDER.ESTIMATED_COST%TYPE, 
        OTBCONTRACTS    IN OUT NOCOPY DAGE_CONTRATO.TYTBGE_CONTRATO 
    ) 
    IS 
        
        CUCURSOR    CONSTANTS.TYREFCURSOR; 
    BEGIN 
        
        UT_TRACE.TRACE('INICIO CT_BCContract.GetActiveContratVal',10); 
 
        
        IF CUCURSOR%ISOPEN THEN CLOSE CUCURSOR; END IF; 
 
        
        OPEN CUCURSOR FOR 
            SELECT 
                    GE_CONTRATO.*, 
                    GE_CONTRATO.ROWID 
            FROM    GE_CONTRATO 
                    /*+ CT_BCContract.GetActiveContratVal SAO388057 */ 
            WHERE   GE_CONTRATO.ID_CONTRATISTA = INUCONTRACTOR 
            AND     (GE_CONTRATO.FECHA_INICIAL <= IDTDATE OR GE_CONTRATO.FECHA_INICIAL IS NULL) 
            AND     (GE_CONTRATO.FECHA_FINAL   >= IDTDATE OR GE_CONTRATO.FECHA_FINAL IS NULL) 
            AND     (INUORDERCOST  + NVL(GE_CONTRATO.VALOR_ASIGNADO,0) + NVL(GE_CONTRATO.VALOR_NO_LIQUIDADO,0) + 
                    NVL(GE_CONTRATO.VALOR_LIQUIDADO,0) <= GE_CONTRATO.VALOR_TOTAL_CONTRATO ) 
            ORDER BY NVL(GE_CONTRATO.FECHA_INICIAL,UT_DATE.FDTMINDATE), NVL(GE_CONTRATO.FECHA_FINAL,UT_DATE.FDTMAXDATE) ASC; 
 
        FETCH CUCURSOR BULK COLLECT INTO OTBCONTRACTS; 
        CLOSE CUCURSOR; 
 
        UT_TRACE.TRACE('FIN CT_BCContract.GetActiveContratVal',10); 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF CUCURSOR%ISOPEN THEN CLOSE CUCURSOR; END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            IF CUCURSOR%ISOPEN THEN CLOSE CUCURSOR; END IF; 
            RAISE EX.CONTROLLED_ERROR; 
    END GETACTIVECONTRATVAL; 
 
    

















 
    PROCEDURE GETOPENCONTRACTBYVAL 
    ( 
        INUCONTRACTOR   IN  GE_CONTRATISTA.ID_CONTRATISTA%TYPE, 
        IDTDATE         IN  DATE DEFAULT UT_DATE.FDTSYSDATE, 
        INUORDERCOST    IN  OR_ORDER.ESTIMATED_COST%TYPE, 
        OTBCONTRACTS    IN  OUT NOCOPY DAGE_CONTRATO.TYTBGE_CONTRATO 
    ) 
    IS 
        
        CUCURSOR    CONSTANTS.TYREFCURSOR; 
    BEGIN 
        
        UT_TRACE.TRACE('INICIO CT_BCContract.GetOpenContractbyVal',10); 
 
        
        IF CUCURSOR%ISOPEN THEN CLOSE CUCURSOR; END IF; 
 
        
        OPEN CUCURSOR FOR 
            SELECT 
                    GE_CONTRATO.*, 
                    GE_CONTRATO.ROWID 
            FROM    GE_CONTRATO 
                    /*+ CT_BCContract.GetOpenContractbyVal SAO388057 */ 
            WHERE   GE_CONTRATO.ID_CONTRATISTA = INUCONTRACTOR 
            AND     GE_CONTRATO.STATUS = CT_BOCONSTANTS.FSBGETOPENSTATUS 
            AND     (GE_CONTRATO.FECHA_INICIAL <= IDTDATE OR GE_CONTRATO.FECHA_INICIAL IS NULL) 
            AND     (GE_CONTRATO.FECHA_FINAL   >= IDTDATE OR GE_CONTRATO.FECHA_FINAL IS NULL) 
            AND     (INUORDERCOST  + NVL(GE_CONTRATO.VALOR_ASIGNADO,0) + NVL(GE_CONTRATO.VALOR_NO_LIQUIDADO,0) + 
                    NVL(GE_CONTRATO.VALOR_LIQUIDADO,0) <= GE_CONTRATO.VALOR_TOTAL_CONTRATO ) 
            ORDER BY NVL(GE_CONTRATO.FECHA_INICIAL,UT_DATE.FDTMINDATE), NVL(GE_CONTRATO.FECHA_FINAL,UT_DATE.FDTMAXDATE) ASC; 
 
        FETCH CUCURSOR BULK COLLECT INTO OTBCONTRACTS; 
        CLOSE CUCURSOR; 
 
        UT_TRACE.TRACE('FIN CT_BCContract.GetOpenContractbyVal',10); 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF CUCURSOR%ISOPEN THEN CLOSE CUCURSOR; END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            IF CUCURSOR%ISOPEN THEN CLOSE CUCURSOR; END IF; 
            RAISE EX.CONTROLLED_ERROR; 
    END GETOPENCONTRACTBYVAL; 
     
    














 
    FUNCTION FNUGETESTIMCOSTBYCONT 
    ( 
        INUIDACTA       IN GE_ACTA.ID_ACTA%TYPE 
    ) 
    RETURN OR_ORDER.ESTIMATED_COST%TYPE 
    IS 
        
        NUESTIMCOSTTOT      OR_ORDER.ESTIMATED_COST%TYPE; 
 
        
        CURSOR CUESTIMCOSTBYCONT 
        IS 
            SELECT  /*+ index (OR_ORDER PK_OR_ORDER) */ 
                    SUM(NVL(A.ESTIMATED_COST,0)) ESTIMATED_COST_TOT 
            FROM    OR_ORDER A, 
                    ( 
                        SELECT  /*+ index (GE_DETALLE_ACTA IDX_GE_DETALLE_ACTA_01) */ 
                                UNIQUE ID_ORDEN 
                        FROM    GE_DETALLE_ACTA 
                        WHERE   ID_ACTA = INUIDACTA 
                        AND     NVL(AFFECT_CONTRACT_VAL, 'Y') = 'Y' 
                    ) B 
                    /*+ CT_BCContract.fnuGetEstimCostByCont */ 
            WHERE   A.ORDER_ID = B.ID_ORDEN; 
 
    BEGIN 
        UT_TRACE.TRACE ('Begin CT_BCContract.fnuGetEstimCostByCont',2); 
 
        
        IF (CUESTIMCOSTBYCONT%ISOPEN) THEN 
            CLOSE CUESTIMCOSTBYCONT; 
        END IF; 
 
        OPEN CUESTIMCOSTBYCONT; 
        FETCH CUESTIMCOSTBYCONT INTO NUESTIMCOSTTOT; 
        CLOSE CUESTIMCOSTBYCONT; 
 
        UT_TRACE.TRACE ('End CT_BCContract.fnuGetEstimCostByCont['||NUESTIMCOSTTOT||']',2); 
         
        RETURN NUESTIMCOSTTOT; 
 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF (CUESTIMCOSTBYCONT%ISOPEN) THEN 
                CLOSE CUESTIMCOSTBYCONT; 
            END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            IF (CUESTIMCOSTBYCONT%ISOPEN) THEN 
                CLOSE CUESTIMCOSTBYCONT; 
            END IF; 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END FNUGETESTIMCOSTBYCONT; 
     
    















 
    FUNCTION FBLVALPENDORDERS (INUCONTRACTID GE_CONTRATO.ID_CONTRATO%TYPE) 
    RETURN BOOLEAN 
    IS 
        CURSOR CUPENDORDERS IS 
            SELECT /*+ ordered index(or_order IDX_OR_ORDER21) 
                       index(ge_causal PK_GE_CAUSAL) */ 
                   'X' 
              FROM OR_ORDER, GE_CAUSAL 
             WHERE DEFINED_CONTRACT_ID = INUCONTRACTID 
               AND IS_PENDING_LIQ IN ('Y', 'E') 
               AND OR_ORDER.CAUSAL_ID = GE_CAUSAL.CAUSAL_ID 
               AND GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL 
               AND ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED 
            UNION 
            SELECT 'X' 
              FROM OR_ORDER 
             WHERE DEFINED_CONTRACT_ID = INUCONTRACTID 
               AND (ORDER_STATUS_ID < OR_BOCONSTANTS.CNUORDER_STAT_CLOSED OR ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_LOCK) ; 
                
        SBRESULT VARCHAR2(1); 
    BEGIN 
        OPEN CUPENDORDERS; 
        FETCH CUPENDORDERS INTO SBRESULT;
        CLOSE CUPENDORDERS; 
        IF (SBRESULT IS NOT NULL)THEN 
            RETURN TRUE; 
        ELSE 
            RETURN FALSE; 
        END IF; 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            IF (CUPENDORDERS%ISOPEN) THEN 
                CLOSE CUPENDORDERS; 
            END IF; 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            IF (CUPENDORDERS%ISOPEN) THEN 
                CLOSE CUPENDORDERS; 
            END IF; 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END FBLVALPENDORDERS; 
     
    



















 
    PROCEDURE UPDATEORDERSBYCONTRACT 
    ( 
        IDTBREAKDATE        IN         GE_ACTA.FECHA_FIN%TYPE, 
        INUCONTRACTID       IN         GE_CONTRATO.ID_CONTRATO%TYPE, 
        INUCONTRACTORID     IN         GE_CONTRATO.ID_CONTRATISTA%TYPE 
    ) 
    IS 
    BEGIN 
        UT_TRACE.TRACE('Inicia CT_BCContract.updateOrdersByContract', 2); 
 
        
        UPDATE  OR_ORDER 
        SET     OR_ORDER.DEFINED_CONTRACT_ID = INUCONTRACTID 
                /*+ CT_BCContract.updateOrdersByContract SAO273959*/ 
        WHERE   OR_ORDER.ROWID IN 
                ( 
                    SELECT 
                            /*+ 
                                ordered 
                                index(or_order IDX_OR_ORDER21) 
                                index (or_operating_unit PK_OR_OPERATING_UNIT) 
                                INDEX (ct_tasktype_contype IDX_CT_TASKTYPE_CONTYPE02) 
                                index(ge_causal PK_GE_CAUSAL) 
                            */ 
                            OR_ORDER.ROWID 
                     FROM   OR_ORDER, 
                            OR_OPERATING_UNIT, 
                            CT_TASKTYPE_CONTYPE, 
                            GE_CAUSAL 
                     WHERE 
                            
                            OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED 
                            
                       AND  OR_ORDER.CAUSAL_ID = GE_CAUSAL.CAUSAL_ID 
                       AND  GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL 
                            
                       AND  OR_ORDER.OPERATING_UNIT_ID = OR_OPERATING_UNIT.OPERATING_UNIT_ID 
                       AND  OR_OPERATING_UNIT.CONTRACTOR_ID = INUCONTRACTORID 
                       AND  OR_OPERATING_UNIT.ES_EXTERNA = GE_BOCONSTANTS.CSBYES 
                            
                       AND  OR_ORDER.TASK_TYPE_ID = CT_TASKTYPE_CONTYPE.TASK_TYPE_ID 
                       AND  CT_TASKTYPE_CONTYPE.CONTRACT_ID = INUCONTRACTID 
                       AND  CT_TASKTYPE_CONTYPE.FLAG_TYPE = CT_BOCONSTANTS.CSBISCONTRACT 
                            
                       AND  OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE 
                            
                       AND OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES 
                            
                       AND  OR_ORDER.DEFINED_CONTRACT_ID IS NULL 
                ); 
 
        UT_TRACE.TRACE('Termina CT_BCContract.updateOrdersByContract', 2); 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END UPDATEORDERSBYCONTRACT; 
     
    




















 
    PROCEDURE UPDATEORDERSBYCONTRACTTYPE 
    ( 
        IDTBREAKDATE        IN         GE_ACTA.FECHA_FIN%TYPE, 
        INUCONTRACTID       IN         GE_CONTRATO.ID_CONTRATO%TYPE, 
        INUCONTRACTORID     IN         GE_CONTRATO.ID_CONTRATISTA%TYPE, 
        INUCONTRACTTYPEID   IN         GE_CONTRATO.ID_TIPO_CONTRATO%TYPE 
    ) 
    IS 
    BEGIN 
        UT_TRACE.TRACE('Inicia CT_BCContract.updateOrdersByContractType', 2); 
 
        
        UPDATE  OR_ORDER 
        SET     OR_ORDER.DEFINED_CONTRACT_ID = INUCONTRACTID 
                /*+ CT_BCContract.updateOrdersByContract SAO273959*/ 
        WHERE   OR_ORDER.ROWID IN 
                ( 
                    SELECT /*+ 
                                ordered 
                                index(or_order IDX_OR_ORDER21) 
                                index (or_operating_unit PK_OR_OPERATING_UNIT) 
                                INDEX (ct_tasktype_contype IDX_CT_TASKTYPE_CONTYPE02) 
                                index(ge_causal PK_GE_CAUSAL) 
                            */ 
                            OR_ORDER.ROWID 
                     FROM   OR_ORDER, 
                            OR_OPERATING_UNIT, 
                            CT_TASKTYPE_CONTYPE, 
                            GE_CAUSAL 
                     WHERE 
                            
                            OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED 
                            
                       AND  OR_ORDER.CAUSAL_ID = GE_CAUSAL.CAUSAL_ID 
                       AND  GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL 
                            
                       AND  OR_ORDER.OPERATING_UNIT_ID = OR_OPERATING_UNIT.OPERATING_UNIT_ID 
                       AND  OR_OPERATING_UNIT.CONTRACTOR_ID = INUCONTRACTORID 
                       AND  OR_OPERATING_UNIT.ES_EXTERNA = GE_BOCONSTANTS.CSBYES 
                            
                       AND  OR_ORDER.TASK_TYPE_ID = CT_TASKTYPE_CONTYPE.TASK_TYPE_ID 
                       AND  CT_TASKTYPE_CONTYPE.CONTRACT_TYPE_ID = INUCONTRACTTYPEID 
                       AND  CT_TASKTYPE_CONTYPE.FLAG_TYPE = CT_BOCONSTANTS.CSBISCONTRACTTYPE 
                            
                       AND  OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE 
                            
                       AND OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES 
                            
                       AND  OR_ORDER.DEFINED_CONTRACT_ID IS NULL 
                ); 
 
        UT_TRACE.TRACE('Termina CT_BCContract.updateOrdersByContractType', 2); 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END UPDATEORDERSBYCONTRACTTYPE; 
     
    



















 
    PROCEDURE UPDATEORDERSBYGENERICCONTRACT 
    ( 
        IDTBREAKDATE        IN         GE_ACTA.FECHA_FIN%TYPE, 
        INUCONTRACTID       IN         GE_CONTRATO.ID_CONTRATO%TYPE, 
        INUCONTRACTORID     IN         GE_CONTRATO.ID_CONTRATISTA%TYPE 
    ) 
    IS 
    BEGIN 
        UT_TRACE.TRACE('Inicia CT_BCContract.updateOrdersByGenericContract', 2); 
 
        
        UPDATE  OR_ORDER 
        SET     OR_ORDER.DEFINED_CONTRACT_ID = INUCONTRACTID 
                /*+ CT_BCContract.updateOrdersByContract SAO273959*/ 
        WHERE   OR_ORDER.ROWID IN 
                ( 
                    SELECT /*+ 
                                ordered 
                                index(or_order IDX_OR_ORDER21) 
                                index (or_operating_unit PK_OR_OPERATING_UNIT) 
                                index(ge_causal PK_GE_CAUSAL) 
                            */ 
                            OR_ORDER.ROWID 
                     FROM   OR_ORDER, 
                            OR_OPERATING_UNIT, 
                            GE_CAUSAL 
                     WHERE 
                           
                           OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_CLOSED 
                           
                       AND OR_ORDER.CAUSAL_ID = GE_CAUSAL.CAUSAL_ID 
                       AND GE_CAUSAL.CLASS_CAUSAL_ID = CNUSUCCESSFULLCLASSCAUSAL 
                           
                       AND OR_ORDER.OPERATING_UNIT_ID = OR_OPERATING_UNIT.OPERATING_UNIT_ID 
                       AND OR_OPERATING_UNIT.CONTRACTOR_ID = INUCONTRACTORID 
                       AND OR_OPERATING_UNIT.ES_EXTERNA = GE_BOCONSTANTS.CSBYES 
                           
                       AND OR_ORDER.LEGALIZATION_DATE <= IDTBREAKDATE 
                           
                       AND OR_ORDER.IS_PENDING_LIQ = GE_BOCONSTANTS.CSBYES 
                           
                       AND OR_ORDER.DEFINED_CONTRACT_ID IS NULL 
                ); 
 
        UT_TRACE.TRACE('Termina CT_BCContract.updateOrdersByGenericContract', 2); 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RAISE EX.CONTROLLED_ERROR; 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END UPDATEORDERSBYGENERICCONTRACT; 
     
END CT_BCCONTRACT;