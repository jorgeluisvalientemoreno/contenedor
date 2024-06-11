PACKAGE BODY CT_BoFWCertificate
IS



























































































    
    
    
    CSBVERSION                  CONSTANT VARCHAR2(10) := 'SAO407089';

    
    CNUERRORSTATUSCONTRACTOR    CONSTANT NUMBER(18)   :=  900900;
    CNUERRORSTATUSCONTRACT      CONSTANT NUMBER(18)   :=  900899;
    
    
    

       
    
    
    
    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;


    
    
    



















    FUNCTION FRFCERTIFICATESFORPRINT
    RETURN CONSTANTS.TYREFCURSOR
    IS
        
        SBID_PERIODO            GE_BOINSTANCECONTROL.STYSBVALUE;
        NUPERIODID              GE_PERIODO_CERT.ID_PERIODO%TYPE;
        
        SBID_TIPO_ACTA          GE_BOINSTANCECONTROL.STYSBVALUE;
        NUCERTIFICATETYPEID     GE_ACTA.ID_TIPO_ACTA%TYPE;
        
        SBID_BASE_ADMINISTRA    GE_BOINSTANCECONTROL.STYSBVALUE;
        NUADMINBASEID           GE_BASE_ADMINISTRA.ID_BASE_ADMINISTRA%TYPE;
        
        SBID_TIPO_CONTRATO      GE_BOINSTANCECONTROL.STYSBVALUE;
        NUCONTRACTTYPEID        GE_TIPO_CONTRATO.ID_TIPO_CONTRATO%TYPE;
        
        SBID_CONTRATISTA        GE_BOINSTANCECONTROL.STYSBVALUE;
        NUCONTRACTORID          GE_CONTRATISTA.ID_CONTRATISTA%TYPE;
        
        RFGEACTA                CONSTANTS.TYREFCURSOR;
        
    BEGIN
        
        UT_TRACE.TRACE('INICIO ct_bofwCertificate.frfCertificatesForPrint',10);
        
        SBID_PERIODO := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('GE_PERIODO_CERT', 'ID_PERIODO');
        NUPERIODID := TO_NUMBER(SBID_PERIODO);
        
        SBID_TIPO_ACTA := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('GE_ACTA', 'ID_TIPO_ACTA');

        NUCERTIFICATETYPEID := TO_NUMBER(SBID_TIPO_ACTA);
        
        SBID_BASE_ADMINISTRA := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('GE_BASE_ADMINISTRA', 'ID_BASE_ADMINISTRA');
        NUADMINBASEID := TO_NUMBER(SBID_BASE_ADMINISTRA);
        
        SBID_TIPO_CONTRATO := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('GE_TIPO_CONTRATO', 'ID_TIPO_CONTRATO');
        NUCONTRACTTYPEID := TO_NUMBER(SBID_TIPO_CONTRATO);
        
        SBID_CONTRATISTA := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('GE_CONTRATISTA', 'ID_CONTRATISTA');
        NUCONTRACTORID := TO_NUMBER(SBID_CONTRATISTA);

        IF (SBID_BASE_ADMINISTRA IS NULL) THEN
            OPEN RFGEACTA FOR
                SELECT  GE_ACTA.ID_ACTA,
                        GE_ACTA.NOMBRE NOMBRE_ACTA,
                        (GE_ACTA.ID_TIPO_ACTA || ' - '|| CT_BOCONSTANTS.FSBGETDESCCERTIFICATETYPE(GE_ACTA.ID_TIPO_ACTA)) TIPO_ACTA,
                        (DECODE(GE_ACTA.ESTADO,CT_BOCONSTANTS.FSBGETOPENEDCERTIFSTATUS,'Abierto',CT_BOCONSTANTS.FSBGETCLOSEDCERTIFSTATUS,'Cerrado')) ESTADO,
                        (GE_ACTA.ID_CONTRATO || ' - '||GE_CONTRATO.DESCRIPCION ) CONTRATO,
                        (   SELECT ID_TIPO_CONTRATO || ' - '|| DESCRIPCION
                            FROM GE_TIPO_CONTRATO
                            WHERE GE_TIPO_CONTRATO.ID_TIPO_CONTRATO = GE_CONTRATO.ID_TIPO_CONTRATO ) TIPO_DE_CONTRATO,
                        (SELECT GE_CONTRATISTA.ID_CONTRATISTA || ' - ' ||GE_CONTRATISTA.DESCRIPCION
                         FROM GE_CONTRATISTA WHERE GE_CONTRATO.ID_CONTRATISTA = GE_CONTRATISTA.ID_CONTRATISTA) CONTRATISTA,
                        (   SELECT ID_BASE_ADMINISTRATIVA  || ' - ' || DESCRIPCION
                            FROM GE_BASE_ADMINISTRA
                            WHERE GE_BASE_ADMINISTRA.ID_BASE_ADMINISTRA = GE_ACTA.ID_BASE_ADMINISTRATIVA
                        ) BASE_ADMINISTRATIVA,
                        (   SELECT ID_PERIODO || ' - ' || NOMBRE
                            FROM GE_PERIODO_CERT
                            WHERE GE_PERIODO_CERT.ID_PERIODO = GE_ACTA.ID_PERIODO) PERIODO,
                        GE_ACTA.FECHA_CREACION,
                        GE_ACTA.FECHA_CIERRE,
                        GE_ACTA.FECHA_INICIO,
                        GE_ACTA.FECHA_FIN
                FROM GE_CONTRATO, GE_ACTA
                WHERE GE_ACTA.ID_CONTRATO = GE_CONTRATO.ID_CONTRATO
                AND GE_ACTA.ID_PERIODO = NUPERIODID
                AND CT_BOCONTRSECURITY.FNUCANMANAGECONTRACT(GE_ACTA.ID_CONTRATO) = 1
                AND GE_ACTA.ID_TIPO_ACTA = NVL(NUCERTIFICATETYPEID,GE_ACTA.ID_TIPO_ACTA)
                AND GE_CONTRATO.ID_TIPO_CONTRATO = NVL(NUCONTRACTTYPEID,GE_CONTRATO.ID_TIPO_CONTRATO)
                AND GE_CONTRATO.ID_CONTRATISTA = NVL(NUCONTRACTORID,GE_CONTRATO.ID_CONTRATISTA)
                AND EXISTS (SELECT 'x' FROM GE_DETALLE_ACTA
                            WHERE GE_DETALLE_ACTA.ID_ACTA = GE_ACTA.ID_ACTA
                            AND GE_DETALLE_ACTA.VALOR_TOTAL > 0 AND ROWNUM < 2);
        ELSE
            OPEN RFGEACTA FOR
                SELECT  GE_ACTA.ID_ACTA,
                        GE_ACTA.NOMBRE NOMBRE_ACTA,
                        (GE_ACTA.ID_TIPO_ACTA || ' - '|| CT_BOCONSTANTS.FSBGETDESCCERTIFICATETYPE(GE_ACTA.ID_TIPO_ACTA)) TIPO_ACTA,
                        (DECODE(GE_ACTA.ESTADO,CT_BOCONSTANTS.FSBGETOPENEDCERTIFSTATUS,'Abierto',CT_BOCONSTANTS.FSBGETCLOSEDCERTIFSTATUS,'Cerrado')) ESTADO,
                        (GE_ACTA.ID_CONTRATO || ' - '||GE_CONTRATO.DESCRIPCION ) CONTRATO,
                        (   SELECT ID_TIPO_CONTRATO || ' - '|| DESCRIPCION
                            FROM GE_TIPO_CONTRATO
                            WHERE GE_TIPO_CONTRATO.ID_TIPO_CONTRATO = GE_CONTRATO.ID_TIPO_CONTRATO ) TIPO_DE_CONTRATO,
                        (SELECT GE_CONTRATISTA.ID_CONTRATISTA || ' - ' ||GE_CONTRATISTA.DESCRIPCION
                         FROM GE_CONTRATISTA WHERE GE_CONTRATO.ID_CONTRATISTA = GE_CONTRATISTA.ID_CONTRATISTA) CONTRATISTA,
                        (   SELECT ID_BASE_ADMINISTRATIVA  || ' - ' || DESCRIPCION
                            FROM GE_BASE_ADMINISTRA
                            WHERE GE_BASE_ADMINISTRA.ID_BASE_ADMINISTRA = GE_ACTA.ID_BASE_ADMINISTRATIVA
                        ) BASE_ADMINISTRATIVA,
                        (   SELECT ID_PERIODO || ' - ' || NOMBRE
                            FROM GE_PERIODO_CERT
                            WHERE GE_PERIODO_CERT.ID_PERIODO = GE_ACTA.ID_PERIODO) PERIODO,
                        GE_ACTA.FECHA_CREACION,
                        GE_ACTA.FECHA_CIERRE,
                        GE_ACTA.FECHA_INICIO,
                        GE_ACTA.FECHA_FIN
                FROM GE_CONTRATO, GE_ACTA
                WHERE GE_ACTA.ID_CONTRATO = GE_CONTRATO.ID_CONTRATO
                AND GE_ACTA.ID_PERIODO = NUPERIODID
                AND CT_BOCONTRSECURITY.FNUCANMANAGECONTRACT(GE_ACTA.ID_CONTRATO) = 1
                AND GE_ACTA.ID_TIPO_ACTA = NVL(NUCERTIFICATETYPEID,GE_ACTA.ID_TIPO_ACTA)
                AND GE_ACTA.ID_BASE_ADMINISTRATIVA = NUADMINBASEID
                AND GE_CONTRATO.ID_TIPO_CONTRATO = NVL(NUCONTRACTTYPEID,GE_CONTRATO.ID_TIPO_CONTRATO)
                AND GE_CONTRATO.ID_CONTRATISTA = NVL(NUCONTRACTORID,GE_CONTRATO.ID_CONTRATISTA)
                AND EXISTS (SELECT 'x' FROM GE_DETALLE_ACTA
                            WHERE GE_DETALLE_ACTA.ID_ACTA = GE_ACTA.ID_ACTA
                            AND GE_DETALLE_ACTA.VALOR_TOTAL > 0 AND ROWNUM < 2);
        END IF;
        RETURN RFGEACTA;

        UT_TRACE.TRACE('FIN ct_bofwCertificate.frfCertificatesForPrint',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FRFCERTIFICATESFORPRINT;
    
    
    
    

    



















    PROCEDURE PRINTCERTIFICATESMASS
    (
        INUACTAID    IN GE_ACTA.ID_ACTA%TYPE,
        INUCURRENT   IN NUMBER,
        INUTOTAL     IN NUMBER,
        ONUERRORCODE OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
        OSBERRORMESS OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS
        
        
        NUEXECID_CTIASCOMP  SA_EXECUTABLE.EXECUTABLE_ID%TYPE := 72;
    BEGIN
        
        UT_TRACE.TRACE('INICIO ct_bofwCertificate.PrintCertificatesMass',12);

        UT_TRACE.TRACE('inuCurrent:'||INUCURRENT,5);
        UT_TRACE.TRACE('inuActaId:'||INUACTAID,5);
        UT_TRACE.TRACE('inuTotal:'||INUTOTAL,5);
        
        IF INUCURRENT = 1 THEN
           CT_BOCERTIFICATE.CLEARPRINTTABLEPL;
        END IF;

        
        
        CT_BOCERTIFICATE.ADDCERTIFTOPRINTTABLEPL(INUACTAID);

        IF (INUCURRENT = INUTOTAL) THEN
        	
            GE_BOIOPENEXECUTABLE.SETPOSTREGISTER(NUEXECID_CTIASCOMP);
        END IF;
        
        UT_TRACE.TRACE('FIN ct_bofwCertificate.PrintCertificatesMass',12);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESS);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESS);
    END PRINTCERTIFICATESMASS;


    
    

    














    PROCEDURE INITIALIZEBREAKDATE
    IS
        SBID_PERIODO GE_BOINSTANCECONTROL.STYSBVALUE;
        NUPERIODID   GE_PERIODO_CERT.ID_PERIODO%TYPE;
        DTENDDATE    GE_PERIODO_CERT.FECHA_FINAL%TYPE;
        
        DTLOWERDATE  GE_PERIODO_CERT.FECHA_FINAL%TYPE;
        
        SBINSTANCE   VARCHAR2(300);
    BEGIN
        SBID_PERIODO := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_PERIODO_CERT',
                                                              'ID_PERIODO');

        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(SBINSTANCE);

        IF (SBID_PERIODO IS NULL) THEN
            
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,
                                                      NULL,
                                                      'GE_PERIODO_CERT',
                                                      'FECHA_FINAL',
                                                      NULL);
            RETURN;
        END IF;

        NUPERIODID := TO_NUMBER(SBID_PERIODO);

        DTENDDATE := DAGE_PERIODO_CERT.FDTGETFECHA_FINAL(NUPERIODID) + 1 - 1/86400;

        DTLOWERDATE := UT_DATE.FDTSYSDATE;

        
        
        IF (DTLOWERDATE > DTENDDATE) THEN
            DTLOWERDATE := DTENDDATE;
        END IF;

        GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,
                                                  NULL,
                                                  'GE_PERIODO_CERT',
                                                  'FECHA_FINAL',
                                                  TO_CHAR(DTLOWERDATE,
                                                          UT_DATE.FSBDATE_FORMAT));
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END INITIALIZEBREAKDATE;
    
    
    

    

















    PROCEDURE VALIDATEBREAKDATE
    IS
        SBID_PERIODO  GE_BOINSTANCECONTROL.STYSBVALUE;
        SBFECHA_FINAL GE_BOINSTANCECONTROL.STYSBVALUE;
        
        NUPERIODID    GE_PERIODO_CERT.ID_PERIODO%TYPE;
        RCPERIOD      DAGE_PERIODO_CERT.STYGE_PERIODO_CERT;

        SBINSTANCE   VARCHAR2(300);
        
        DTBREAKDATE   GE_PERIODO_CERT.FECHA_FINAL%TYPE;
        
        
        CNUHIGHERSYSTEMDATEERR  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 3852;
        
        CNULOWERPERIODDATEERR   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 6262;
        
        CNUHIGHERPERIODDATEERR  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 6264;
    BEGIN
        SBID_PERIODO := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_PERIODO_CERT',
                                                              'ID_PERIODO');

        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(SBINSTANCE);

        IF (SBID_PERIODO IS NULL) THEN
            
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,
                                                      NULL,
                                                      'GE_PERIODO_CERT',
                                                      'FECHA_FINAL',
                                                      NULL);
                                                      
            IF (SBID_PERIODO IS NULL) THEN
                ERRORS.SETERROR(6542,
                                'Periodo');
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            RETURN;
        END IF;

        SBFECHA_FINAL := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_PERIODO_CERT',
                                                               'FECHA_FINAL');
        DTBREAKDATE := TRUNC(TO_DATE(SBFECHA_FINAL,
                                     UT_DATE.FSBDATE_FORMAT));

        
        IF (DTBREAKDATE > UT_DATE.FDTSYSDATE) THEN
            GE_BOERRORS.SETERRORCODE(CNUHIGHERSYSTEMDATEERR);
            RAISE EX.CONTROLLED_ERROR;
            RETURN;
        END IF;

        NUPERIODID := TO_NUMBER(SBID_PERIODO);
        DAGE_PERIODO_CERT.GETRECORD(NUPERIODID,
                                    RCPERIOD);

        
        IF (DTBREAKDATE < RCPERIOD.FECHA_INICIAL) THEN
            GE_BOERRORS.SETERRORCODE(CNULOWERPERIODDATEERR);
            RAISE EX.CONTROLLED_ERROR;
            RETURN;
        END IF;
        
        
        IF (DTBREAKDATE > (RCPERIOD.FECHA_FINAL + 1 - 1/86400)) THEN
            GE_BOERRORS.SETERRORCODE(CNUHIGHERPERIODDATEERR);
            RAISE EX.CONTROLLED_ERROR;
            RETURN;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDATEBREAKDATE;
    
    
    

    














































    PROCEDURE GENCONTRACTORSOBLIG
    IS
        SBID_PERIODO         GE_BOINSTANCECONTROL.STYSBVALUE;
        NUPERIODID           GE_PERIODO_CERT.ID_PERIODO%TYPE;
        SBFECHA_CORTE        GE_BOINSTANCECONTROL.STYSBVALUE;
        DTBREAKDATE          GE_PERIODO_CERT.FECHA_FINAL%TYPE;
        SBID_BASE_ADMINISTRA GE_BOINSTANCECONTROL.STYSBVALUE;
        NUADMINBASEID        GE_BASE_ADMINISTRA.ID_BASE_ADMINISTRA%TYPE;
        SBID_TIPO_CONTRATO   GE_BOINSTANCECONTROL.STYSBVALUE;
        NUCONTRACTTYPEID     GE_CONTRATO.ID_TIPO_CONTRATO%TYPE;
        SBID_CONTRATISTA     GE_BOINSTANCECONTROL.STYSBVALUE;
        NUCONTRACTORID       GE_CONTRATO.ID_CONTRATISTA%TYPE;
        SBIMPRIMIR           GE_BOINSTANCECONTROL.STYSBVALUE;
        
        RCPERIOD             DAGE_PERIODO_CERT.STYGE_PERIODO_CERT;
        
        TBCONTRACTS          DAGE_CONTRATO.TYTBID_CONTRATO;
        
        TBCERTIFICATES       DAGE_ACTA.TYTBID_ACTA;
        
        NUCONTRACTCOUNTER    NUMBER := 0;
        NUCERTIFICATECOUNTER NUMBER := 0;
        
        PROCEDURE PROCESSCONTRACT
        (
            INUCONTRACTID    GE_CONTRATO.ID_CONTRATO%TYPE
        )
        IS
            NUERROR                     GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
            SBERROR                     GE_ERROR_LOG.DESCRIPTION%TYPE;
            TBNOADMINBASELIQCERTIFS     CT_BCLIQUIDATIONSUPPORT.TYTBCERTIFICATEID;
            TBNOADMINBASEBILLCERTIFS    CT_BCLIQUIDATIONSUPPORT.TYTBCERTIFICATEID;
            TBLIQCERTIFICATES           CT_BCLIQUIDATIONSUPPORT.TYTBCERTIFICATEID;
            TBBILLCERTIFICATES          CT_BCLIQUIDATIONSUPPORT.TYTBCERTIFICATEID;
        BEGIN
            
            CT_BCLIQUIDATIONSUPPORT.CLEARTMPORDERSTABLE;

            
            CT_BOLIQUIDATIONPROCESS.GENERATECONTRACTOBLIG(NUPERIODID,
                                                          INUCONTRACTID,
                                                          NUADMINBASEID,
                                                          DTBREAKDATE,
                                                          TBNOADMINBASELIQCERTIFS,
                                                          TBNOADMINBASEBILLCERTIFS,
                                                          TBLIQCERTIFICATES,
                                                          TBBILLCERTIFICATES,
                                                          FALSE,
                                                          TBCERTIFICATES);
            NUCONTRACTCOUNTER := NUCONTRACTCOUNTER + 1;
            NUCERTIFICATECOUNTER := NUCERTIFICATECOUNTER + TBCERTIFICATES.COUNT;
            
            IF (    (SBIMPRIMIR = GE_BOCONSTANTS.CSBYES)
                AND (TBCERTIFICATES.COUNT > 0)) THEN
                
                FOR N IN TBCERTIFICATES.FIRST..TBCERTIFICATES.LAST LOOP
                    
                    
                    CT_BOCERTIFICATE.ADDCERTIFTOPRINTTABLEPL(TBCERTIFICATES(N));
                END LOOP;
                
                GE_BOIOPENEXECUTABLE.SETONEVENT(72,
                                                'POST_REGISTER');
            END IF;
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                ERRORS.GETERROR(NUERROR,
                                SBERROR);
                
                CT_BOPROCESSLOG.REGISTERPROCESSLOG(INUCONTRACTID,
                                                   NUPERIODID,
                                                   DTBREAKDATE,
                                                   NULL,
                                                   NULL,
                                                   NULL);
            WHEN OTHERS THEN
            	ERRORS.SETERROR;
            	ERRORS.GETERROR(NUERROR,
                                SBERROR);
                
                CT_BOPROCESSLOG.REGISTERPROCESSLOG(INUCONTRACTID,
                                                   NUPERIODID,
                                                   DTBREAKDATE,
                                                   NULL,
                                                   NULL,
                                                   NULL);
        END PROCESSCONTRACT;
    BEGIN
        
        SBID_PERIODO         := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_PERIODO_CERT',
                                                                      'ID_PERIODO');
        NUPERIODID := TO_NUMBER(SBID_PERIODO);
        
        SBFECHA_CORTE        := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_PERIODO_CERT',
                                                                      'FECHA_FINAL');
        DTBREAKDATE := TO_DATE(SBFECHA_CORTE,
                               UT_DATE.FSBDATE_FORMAT);
                               
        SBID_BASE_ADMINISTRA := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_BASE_ADMINISTRA',
                                                                      'ID_BASE_ADMINISTRA');
        NUADMINBASEID := TO_NUMBER(SBID_BASE_ADMINISTRA);
        
        SBID_TIPO_CONTRATO   := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_TIPO_CONTRATO',
                                                                      'ID_TIPO_CONTRATO');
        NUCONTRACTTYPEID := TO_NUMBER(SBID_TIPO_CONTRATO);
        
        SBID_CONTRATISTA     := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_CONTRATISTA',
                                                                      'ID_CONTRATISTA');
        NUCONTRACTORID := TO_NUMBER(SBID_CONTRATISTA);
                                                                      
        
        SBIMPRIMIR           := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_ACTA',
                                                                      'ESTADO');

        
        DAGE_PERIODO_CERT.GETRECORD(NUPERIODID,
                                    RCPERIOD);
                                    
        
        CT_BCCONTRACT.GETOPENCONTRACTSTOPROCESS(NUCONTRACTTYPEID,
                                            NUCONTRACTORID,
                                            DTBREAKDATE,
                                            RCPERIOD.FECHA_INICIAL,
                                            RCPERIOD.FECHA_FINAL,
                                            TBCONTRACTS);

        IF (TBCONTRACTS.COUNT = 0) THEN
            ERRORS.SETERROR(6482);
            RAISE EX.CONTROLLED_ERROR;
            RETURN;
        END IF;
        
        
        GE_BOCERTCONTRATISTA.LIMPIARCACHEVALORITEMLISTA;
        
        
        CT_BOCERTIFICATE.CLEARPRINTTABLEPL;

        
        FOR N IN TBCONTRACTS.FIRST..TBCONTRACTS.LAST LOOP
            PROCESSCONTRACT(TBCONTRACTS(N));
        END LOOP;
        
        
        GE_BOINSTANCECONTROL.ADDATTRIBUTE('WORK_INSTANCE',
                                          NULL,
                                          'SUCCESS_MESSAGE_ENTITY',
                                          'SUCCESS_MESSAGE_ATTRIBUTE',
                                          6502);
        
        
        GE_BOINSTANCECONTROL.ADDATTRIBUTE('WORK_INSTANCE',
                                          NULL,
                                          'SUCCESS_MESSAGE_ARGUMENTS_ENTITY',
                                          'SUCCESS_MESSAGE_ARGUMENTS_ATTRIBUTE',
                                          NUCONTRACTCOUNTER||'|'||TBCONTRACTS.COUNT||'|'||NUCERTIFICATECOUNTER);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GENCONTRACTORSOBLIG;
    
    
    
    


















    FUNCTION FRFGETOPENEDCERTIFS
    RETURN CONSTANTS.TYREFCURSOR
    IS
        SBID_PERIODO         GE_BOINSTANCECONTROL.STYSBVALUE;
        NUPERIODID           GE_PERIODO_CERT.ID_PERIODO%TYPE;
        
        SBID_TIPO_ACTA       GE_BOINSTANCECONTROL.STYSBVALUE;
        NUCERTIFICATETYPEID  GE_ACTA.ID_TIPO_ACTA%TYPE;
        
        SBID_TIPO_CONTRATO   GE_BOINSTANCECONTROL.STYSBVALUE;
        NUCONTRACTTYPEID     GE_TIPO_CONTRATO.ID_TIPO_CONTRATO%TYPE;
        
        SBID_CONTRATISTA     GE_BOINSTANCECONTROL.STYSBVALUE;
        NUCONTRACTORID       GE_CONTRATISTA.ID_CONTRATISTA%TYPE;
        
        SBID_BASE_ADMINISTRA GE_BOINSTANCECONTROL.STYSBVALUE;
        NUADMINBASEID        GE_BASE_ADMINISTRA.ID_BASE_ADMINISTRA%TYPE;
    
        RFCERTIFICATES       CONSTANTS.TYREFCURSOR;
    BEGIN
        SBID_PERIODO         := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_PERIODO_CERT',
                                                                      'ID_PERIODO');
        NUPERIODID := TO_NUMBER(SBID_PERIODO);
                                                                      
        SBID_TIPO_ACTA := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('GE_ACTA',
                                                                 'ID_TIPO_ACTA');

        NUCERTIFICATETYPEID := TO_NUMBER(SBID_TIPO_ACTA);
                                                                      
        SBID_TIPO_CONTRATO   := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_TIPO_CONTRATO',
                                                                      'ID_TIPO_CONTRATO');
        NUCONTRACTTYPEID := TO_NUMBER(SBID_TIPO_CONTRATO);
                                                                      
        SBID_CONTRATISTA     := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_CONTRATISTA',
                                                                      'ID_CONTRATISTA');
        NUCONTRACTORID := TO_NUMBER(SBID_CONTRATISTA);
                                                                      
        SBID_BASE_ADMINISTRA := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_BASE_ADMINISTRA',
                                                                      'ID_BASE_ADMINISTRA');
        NUADMINBASEID := TO_NUMBER(SBID_BASE_ADMINISTRA);
                                                                      
        IF (SBID_BASE_ADMINISTRA IS NULL) THEN
            OPEN RFCERTIFICATES FOR
                SELECT  GE_ACTA.ID_ACTA,
                        GE_ACTA.NOMBRE NOMBRE_ACTA,
                        (GE_ACTA.ID_TIPO_ACTA || ' - '|| CT_BOCONSTANTS.FSBGETDESCCERTIFICATETYPE(GE_ACTA.ID_TIPO_ACTA)) TIPO_ACTA,
                        (GE_ACTA.ID_CONTRATO || ' - '||GE_CONTRATO.DESCRIPCION ) CONTRATO,
                        (   SELECT ID_TIPO_CONTRATO || ' - '|| DESCRIPCION
                            FROM GE_TIPO_CONTRATO
                            WHERE GE_TIPO_CONTRATO.ID_TIPO_CONTRATO = GE_CONTRATO.ID_TIPO_CONTRATO ) TIPO_DE_CONTRATO,
                        (SELECT GE_CONTRATISTA.ID_CONTRATISTA || ' - ' ||GE_CONTRATISTA.DESCRIPCION
                         FROM GE_CONTRATISTA WHERE GE_CONTRATO.ID_CONTRATISTA = GE_CONTRATISTA.ID_CONTRATISTA) CONTRATISTA,
                        (   SELECT ID_BASE_ADMINISTRATIVA  || ' - ' || DESCRIPCION
                            FROM GE_BASE_ADMINISTRA
                            WHERE GE_BASE_ADMINISTRA.ID_BASE_ADMINISTRA = GE_ACTA.ID_BASE_ADMINISTRATIVA
                        ) BASE_ADMINISTRATIVA,
                        (   SELECT ID_PERIODO || ' - ' || NOMBRE
                            FROM GE_PERIODO_CERT
                            WHERE GE_PERIODO_CERT.ID_PERIODO = GE_ACTA.ID_PERIODO) PERIODO,
                        GE_ACTA.FECHA_CREACION,
                        GE_ACTA.FECHA_CIERRE,
                        GE_ACTA.FECHA_INICIO,
                        GE_ACTA.FECHA_FIN
                FROM GE_CONTRATO, GE_ACTA
                WHERE GE_ACTA.ID_CONTRATO = GE_CONTRATO.ID_CONTRATO
                AND GE_ACTA.ESTADO = CT_BOCONSTANTS.FSBGETOPENEDCERTIFSTATUS
                AND GE_ACTA.ID_PERIODO = NUPERIODID
                AND GE_ACTA.ID_TIPO_ACTA = NVL(NUCERTIFICATETYPEID,GE_ACTA.ID_TIPO_ACTA)
                AND CT_BOCONTRSECURITY.FNUCANMANAGECONTRACT(GE_ACTA.ID_CONTRATO) = 1
                AND GE_CONTRATO.ID_TIPO_CONTRATO = NVL(NUCONTRACTTYPEID,GE_CONTRATO.ID_TIPO_CONTRATO)
                AND GE_CONTRATO.ID_CONTRATISTA = NVL(NUCONTRACTORID,GE_CONTRATO.ID_CONTRATISTA);
        ELSE
            OPEN RFCERTIFICATES FOR
                SELECT  GE_ACTA.ID_ACTA,
                        GE_ACTA.NOMBRE NOMBRE_ACTA,
                        (GE_ACTA.ID_TIPO_ACTA || ' - '|| CT_BOCONSTANTS.FSBGETDESCCERTIFICATETYPE(GE_ACTA.ID_TIPO_ACTA)) TIPO_ACTA,
                        (GE_ACTA.ID_CONTRATO || ' - '||GE_CONTRATO.DESCRIPCION ) CONTRATO,
                        (   SELECT ID_TIPO_CONTRATO || ' - '|| DESCRIPCION
                            FROM GE_TIPO_CONTRATO
                            WHERE GE_TIPO_CONTRATO.ID_TIPO_CONTRATO = GE_CONTRATO.ID_TIPO_CONTRATO ) TIPO_DE_CONTRATO,
                        (SELECT GE_CONTRATISTA.ID_CONTRATISTA || ' - ' ||GE_CONTRATISTA.DESCRIPCION
                         FROM GE_CONTRATISTA WHERE GE_CONTRATO.ID_CONTRATISTA = GE_CONTRATISTA.ID_CONTRATISTA) CONTRATISTA,
                        (   SELECT ID_BASE_ADMINISTRATIVA  || ' - ' || DESCRIPCION
                            FROM GE_BASE_ADMINISTRA
                            WHERE GE_BASE_ADMINISTRA.ID_BASE_ADMINISTRA = GE_ACTA.ID_BASE_ADMINISTRATIVA
                        ) BASE_ADMINISTRATIVA,
                        (   SELECT ID_PERIODO || ' - ' || NOMBRE
                            FROM GE_PERIODO_CERT
                            WHERE GE_PERIODO_CERT.ID_PERIODO = GE_ACTA.ID_PERIODO) PERIODO,
                        GE_ACTA.FECHA_CREACION,
                        GE_ACTA.FECHA_CIERRE,
                        GE_ACTA.FECHA_INICIO,
                        GE_ACTA.FECHA_FIN
                FROM GE_CONTRATO, GE_ACTA
                WHERE GE_ACTA.ID_CONTRATO = GE_CONTRATO.ID_CONTRATO
                AND GE_ACTA.ESTADO = CT_BOCONSTANTS.FSBGETOPENEDCERTIFSTATUS
                AND GE_ACTA.ID_PERIODO = NUPERIODID
                AND GE_ACTA.ID_TIPO_ACTA = NVL(NUCERTIFICATETYPEID,GE_ACTA.ID_TIPO_ACTA)
                AND CT_BOCONTRSECURITY.FNUCANMANAGECONTRACT(GE_ACTA.ID_CONTRATO) = 1
                AND GE_ACTA.ID_BASE_ADMINISTRATIVA = NUADMINBASEID
                AND GE_CONTRATO.ID_TIPO_CONTRATO = NVL(NUCONTRACTTYPEID,GE_CONTRATO.ID_TIPO_CONTRATO)
                AND GE_CONTRATO.ID_CONTRATISTA = NVL(NUCONTRACTORID,GE_CONTRATO.ID_CONTRATISTA);
        END IF;
        RETURN RFCERTIFICATES;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FRFGETOPENEDCERTIFS;
    
    
    

    

















    PROCEDURE REVERTCERTIFICATE
    (
        INUCERTIFICATEID IN  GE_ACTA.ID_ACTA%TYPE,
        INUCURRENT       IN  NUMBER,
        INUTOTAL         IN  NUMBER,
        ONUERRORCODE     OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
        OSBERRORMESS     OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS
        SBFORZAR GE_BOINSTANCECONTROL.STYSBVALUE;
    BEGIN
        SBFORZAR := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_ACTA',
                                                          'ESTADO');
                                                          
        IF (SBFORZAR IS NULL) THEN
            ERRORS.SETERROR(2126,
                            '�Forzar la reversi�n?');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF (SBFORZAR = GE_BOCONSTANTS.CSBYES) THEN
            CT_BSCERTIFICATE.REVERTCERTIFICATE(INUCERTIFICATEID,
                                               TRUE,
                                               ONUERRORCODE,
                                               OSBERRORMESS);
        ELSE
            CT_BSCERTIFICATE.REVERTCERTIFICATE(INUCERTIFICATEID,
                                               FALSE,
                                               ONUERRORCODE,
                                               OSBERRORMESS);
        END IF;

        
        PKGENERALSERVICES.COMMITTRANSACTION;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            PKGENERALSERVICES.ROLLBACKTRANSACTION;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            PKGENERALSERVICES.ROLLBACKTRANSACTION;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END REVERTCERTIFICATE;
    

    
    





















    PROCEDURE FILLATTRIBPROCESSLOG
    (
        IOSBPROCESSLOG     IN OUT     GE_BOUTILITIES.STYSTATEMENT
    )
    IS
        SBITEMS         GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBPERIODO       GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
    BEGIN

        IF IOSBPROCESSLOG IS NOT NULL THEN
            RETURN;
        END IF;
        
        SBITEMS := '( SELECT ge_items.items_id ' || GE_BOUTILITIES.CSBSEPARATOR || ' ge_items.code ' ||
                   GE_BOUTILITIES.CSBSEPARATOR || ' ge_items.description ' ||
                   ' FROM ge_items WHERE ge_items.items_id = CT_PROCESS_LOG.ITEMS_ID )';

        SBPERIODO := '( SELECT ge_periodo_cert.id_periodo || ' || CHR(39) ||' -  ('|| CHR(39) || ' || ' ||
                     ' to_char(ge_periodo_cert.fecha_inicial, ut_date.fsbSHORT_DATE_FORMAT ) || '|| CHR(39) ||' , '|| CHR(39) || ' || ' ||
                     ' to_char(ge_periodo_cert.fecha_final, ut_date.fsbSHORT_DATE_FORMAT) || '|| CHR(39) ||')'|| CHR(39) ||
                     ' FROM  ge_periodo_cert WHERE ge_periodo_cert.id_periodo = CT_PROCESS_LOG.PERIOD_ID ) ';

        
        
        GE_BOUTILITIES.ADDATTRIBUTE ('CT_PROCESS_LOG.PROCESS_LOG_ID','PROCESS_LOG_ID',IOSBPROCESSLOG);
        GE_BOUTILITIES.ADDATTRIBUTE (SBPERIODO,'PERIOD_ID',IOSBPROCESSLOG);
        GE_BOUTILITIES.ADDATTRIBUTE ('CT_PROCESS_LOG.ORDER_ID','ORDER_ID',IOSBPROCESSLOG);
        GE_BOUTILITIES.ADDATTRIBUTE (SBITEMS,'ITEMS_ID',IOSBPROCESSLOG);
        GE_BOUTILITIES.ADDATTRIBUTE ('CT_PROCESS_LOG.CONDITION_BY_PLAN_ID||''-''||CT_BCConditionPlan.fsbCondNameByCondPlan(CT_PROCESS_LOG.condition_by_plan_id)','CONDITION_NAME',IOSBPROCESSLOG);
        GE_BOUTILITIES.ADDATTRIBUTE ('CT_PROCESS_LOG.LOG_DATE','LOG_DATE',IOSBPROCESSLOG);
        GE_BOUTILITIES.ADDATTRIBUTE ('CT_PROCESS_LOG.BREAK_DATE','BREAK_DATE',IOSBPROCESSLOG);
        GE_BOUTILITIES.ADDATTRIBUTE ('CT_PROCESS_LOG.ERROR_CODE','ERROR_CODE',IOSBPROCESSLOG);
        GE_BOUTILITIES.ADDATTRIBUTE ('CT_PROCESS_LOG.ERROR_MESSAGE','ERROR_MESSAGE',IOSBPROCESSLOG);


        GE_BOUTILITIES.ADDATTRIBUTE ('nvl(:parent_id,CT_PROCESS_LOG.CONTRACT_ID)','parent_id',IOSBPROCESSLOG);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FILLATTRIBPROCESSLOG;
    
    
















    PROCEDURE GETPROCLOGBYID
    (
        ISBPROCESLOG        IN VARCHAR2,
        OCUDATACURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS
        
        SBSQL                   VARCHAR2(32767);
        NUPROCESSLOG            CT_PROCESS_LOG.PROCESS_LOG_ID%TYPE;
        SBPROCESSLOG            GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.getProcLogById');

        FILLATTRIBPROCESSLOG(SBPROCESSLOG);

        NUPROCESSLOG := TO_NUMBER(ISBPROCESLOG);

        SBSQL :=  ' SELECT ' ||CHR(10)||
                    SBPROCESSLOG  ||CHR(10)||
                  ' FROM    CT_PROCESS_LOG ' ||CHR(10)||
                  ' WHERE   CT_PROCESS_LOG.PROCESS_LOG_ID = :nuProceLogId';

        UT_TRACE.TRACE(SBSQL,15);
        UT_TRACE.TRACE('nuProcessLog:'||NUPROCESSLOG,15);

        OPEN OCUDATACURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, NUPROCESSLOG;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.getProcLogById');
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETPROCLOGBYID;
    
    
















    PROCEDURE GETPROCLOGBYCONTRACT
    (
        ISBCONTRACT         IN VARCHAR2,
        OCUDATACURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS
        
        SBSQL                   VARCHAR2(32767);
        NUCONTRATO              GE_CONTRATO.ID_CONTRATO%TYPE;
        SBPROCESSLOG            GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.getProcLogByContract',10);

        FILLATTRIBPROCESSLOG(SBPROCESSLOG);

        NUCONTRATO := TO_NUMBER(ISBCONTRACT);

        SBSQL :=  ' SELECT ' ||CHR(10)||
                    SBPROCESSLOG  ||CHR(10)||
                  ' FROM    CT_PROCESS_LOG ' ||CHR(10)||
                  ' WHERE   CT_PROCESS_LOG.contract_id = :nuContrato';

        UT_TRACE.TRACE(SBSQL,15);
        UT_TRACE.TRACE('nuContrato:'||NUCONTRATO,15);

        OPEN OCUDATACURSOR FOR SBSQL USING NUCONTRATO, NUCONTRATO;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.getProcLogByContract',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETPROCLOGBYCONTRACT;

    














    PROCEDURE GETOPERATINGUNITBYCONTRACTOR
    (
        ORFRESULT          IN OUT NOCOPY CONSTANTS.TYREFCURSOR
    )
	IS
        SBINSTANCE                GE_BOINSTANCECONTROL.STYSBNAME;
        SBIDINDEX                 GE_BOINSTANCECONTROL.STYNUINDEX;
        SBCONTRACTORID            GE_BOINSTANCECONTROL.STYNUINDEX;
        NUCONTRACTORID            GE_CONTRATISTA.ID_CONTRATISTA%TYPE;
    BEGIN
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.getOperatingUnitByContractor',10);
        
		
        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(SBINSTANCE);
        
		IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(SBINSTANCE, NULL, 'GE_CONTRATISTA', 'ID_CONTRATISTA', SBIDINDEX) = GE_BOCONSTANTS.GETTRUE ) THEN
		    SBCONTRACTORID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('GE_CONTRATISTA', 'ID_CONTRATISTA');
        ELSE
            IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'GE_CONTRATISTA', 'ID_CONTRATISTA', SBIDINDEX) = GE_BOCONSTANTS.GETTRUE ) THEN
                GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'GE_CONTRATISTA', 'ID_CONTRATISTA', SBCONTRACTORID);
            END IF;
        END IF;

        NUCONTRACTORID := UT_CONVERT.FNUCHARTONUMBER(SBCONTRACTORID);

		OPEN ORFRESULT FOR
            SELECT /*+ index(OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT10)*/
                OR_OPERATING_UNIT.OPERATING_UNIT_ID ID, OR_OPERATING_UNIT.NAME DESCRIPTION
            FROM OR_OPERATING_UNIT
            WHERE OR_OPERATING_UNIT.CONTRACTOR_ID = NUCONTRACTORID;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.getOperatingUnitByContractor',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('CONTROLLED_ERROR CT_BoFWCertificate.getOperatingUnitByContractor',10);
            IF (ORFRESULT%ISOPEN) THEN
                CLOSE ORFRESULT;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('others CT_BoFWCertificate.getOperatingUnitByContractor',10);
            IF (ORFRESULT%ISOPEN) THEN
                CLOSE ORFRESULT;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END GETOPERATINGUNITBYCONTRACTOR;
    

    

















    PROCEDURE SUSPENDCONTRACTOR
    IS

        

        
        SBINSTANCE              GE_BOINSTANCECONTROL.STYSBNAME;

         
        SBCONTRACTORID          VARCHAR2(300);
        NUCONTRACTORID          GE_CONTRATISTA.ID_CONTRATISTA%TYPE;

        
        SBOPERATINGUNITID       VARCHAR2(300);
        NUOPERATINGUNITID       OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE;

        
        SBCOMMENTTYPE           VARCHAR2(300);
        NUCOMMENTTYPE           GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE;

        
        SBCOMMENT               GE_ACTA.COMMENT_%TYPE;

    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.SuspendContractor',10);

        
        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'CONTRACTOR_ID', SBCONTRACTORID);
        NUCONTRACTORID := TO_NUMBER(SBCONTRACTORID);
        
        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'OPERATING_UNIT_ID', SBOPERATINGUNITID);
        NUOPERATINGUNITID := TO_NUMBER(SBOPERATINGUNITID);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'COMMENT_TYPE_ID', SBCOMMENTTYPE);
        NUCOMMENTTYPE := TO_NUMBER(SBCOMMENTTYPE);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'COMMENT_', SBCOMMENT);

         UT_TRACE.TRACE(' sbContractorId: [' || SBCONTRACTORID || ']
                          sbOperatingUnitId: [' || SBOPERATINGUNITID || ']
                          sbCommentType: [' || SBCOMMENTTYPE || ']
                          sbComment: [' || SBCOMMENT || ']' , 11);

        
        CT_BOCONTRACTOR.CHANGESTATUSCONTRACTOR(NUCONTRACTORID, NUOPERATINGUNITID, NUCOMMENTTYPE, SBCOMMENT, CT_BOCONSTANTS.FSBGETSUSPENDSTATUS);
        
        COMMIT;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.SuspendContractor',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR - CONTROLLED_ERROR CT_BoFWCertificate.SuspendContractor',10);
            ROLLBACK;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR - OTHERS CT_BoFWCertificate.SuspendContractor',10);
            ROLLBACK;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SUSPENDCONTRACTOR;
    
     














    PROCEDURE VALIDATESUSPENDCONTRACTOR
    IS

        
        SBINSTANCE              GE_BOINSTANCECONTROL.STYSBNAME;
        SBCONTRACTORID          GE_BOUTILITIES.STYSTATEMENT;
        NUINDEX                 GE_BOINSTANCECONTROL.STYNUINDEX;
        NUCONTRACTORID          GE_CONTRATISTA.ID_CONTRATISTA%TYPE;
        SBSTATUSAVAILABLE        GE_CONTRATISTA.STATUS%TYPE;
        SBSTATUSCONTRACTOR      GE_CONTRATISTA.STATUS%TYPE;

    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.validateSuspendContractor',10);

        
        GE_BOINSTANCECONTROL.ACCKEYATTRIBUTESTACK('WORK_INSTANCE',NULL,'GE_CONTRATISTA','ID_CONTRATISTA',NUINDEX);
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',NULL,'GE_CONTRATISTA','ID_CONTRATISTA',SBCONTRACTORID);
        NUCONTRACTORID := UT_CONVERT.FNUCHARTONUMBER(SBCONTRACTORID);

        
        SBSTATUSAVAILABLE := CT_BOCONSTANTS.FSBGETAVAILABLESTATUS;

        
        SBSTATUSCONTRACTOR := CT_BOCONTRACTOR.FSBGETSTATUSCONTRACTOR(NUCONTRACTORID);

        
        IF SBSTATUSCONTRACTOR = SBSTATUSAVAILABLE THEN
            GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA','CONTRACTOR_ID',NUCONTRACTORID);
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_CONTRATISTA','STATUS',CT_BOCONSTANTS.FSBGETDESCSTATUS(SBSTATUSAVAILABLE));
        ELSE
            UT_TRACE.TRACE('Error - El estado del contratista no es v�lido para la ejecuci�n del Acta de suspensi�n',11);
            ERRORS.SETERROR(CNUERRORSTATUSCONTRACTOR, CT_BOCONSTANTS.FSBGETDESCSTATUS(SBSTATUSAVAILABLE) || '|' ||
                                    CT_BOCONSTANTS.FSBGETDESCCERTIFICATETYPE(CT_BOCONSTANTS.FNUGETSUSPENDCERTITYPE));
            RAISE  EX.CONTROLLED_ERROR;
        END IF;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.validateSuspendContractor',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR - CONTROLLED_ERROR CT_BoFWCertificate.validateSuspendContractor',10);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR - OTHERS CT_BoFWCertificate.validateSuspendContractor',10);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDATESUSPENDCONTRACTOR;
    
         














    PROCEDURE VALIDATEACTIVECONTRACTOR
    IS

        
        SBINSTANCE              GE_BOINSTANCECONTROL.STYSBNAME;
        SBCONTRACTORID          GE_BOUTILITIES.STYSTATEMENT;
        NUINDEX                 GE_BOINSTANCECONTROL.STYNUINDEX;
        NUCONTRACTORID          GE_CONTRATISTA.ID_CONTRATISTA%TYPE;
        SBSTATUSSUSPEND         GE_CONTRATISTA.STATUS%TYPE;
        SBSTATUSAVAILABLE       GE_CONTRATISTA.STATUS%TYPE;
        SBSTATUSCONTRACTOR      GE_CONTRATISTA.STATUS%TYPE;

    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.validateActiveContractor',10);

        
        GE_BOINSTANCECONTROL.ACCKEYATTRIBUTESTACK('WORK_INSTANCE',NULL,'GE_CONTRATISTA','ID_CONTRATISTA',NUINDEX);
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',NULL,'GE_CONTRATISTA','ID_CONTRATISTA',SBCONTRACTORID);
        NUCONTRACTORID := UT_CONVERT.FNUCHARTONUMBER(SBCONTRACTORID);

        
        SBSTATUSSUSPEND := CT_BOCONSTANTS.FSBGETSUSPENDSTATUS;
        
        SBSTATUSAVAILABLE := CT_BOCONSTANTS.FSBGETAVAILABLESTATUS;

        
        SBSTATUSCONTRACTOR := CT_BOCONTRACTOR.FSBGETSTATUSCONTRACTOR(NUCONTRACTORID);

        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );
        GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA','CONTRACTOR_ID',NUCONTRACTORID);
            
        
        IF SBSTATUSCONTRACTOR = SBSTATUSAVAILABLE THEN
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_CONTRATISTA','STATUS',CT_BOCONSTANTS.FSBGETDESCSTATUS(SBSTATUSAVAILABLE));
        ELSIF SBSTATUSCONTRACTOR = SBSTATUSSUSPEND THEN
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_CONTRATISTA','STATUS',CT_BOCONSTANTS.FSBGETDESCSTATUS(SBSTATUSSUSPEND));
        END IF;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.validateActiveContractor',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR - CONTROLLED_ERROR CT_BoFWCertificate.validateActiveContractor',10);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR - OTHERS CT_BoFWCertificate.validateActiveContractor',10);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDATEACTIVECONTRACTOR;
    
        

















    PROCEDURE ACTIVATECONTRACTOR
    IS

        

        
        SBINSTANCE              GE_BOINSTANCECONTROL.STYSBNAME;

         
        SBCONTRACTORID          VARCHAR2(300);
        NUCONTRACTORID          GE_CONTRATISTA.ID_CONTRATISTA%TYPE;

        
        SBOPERATINGUNITID       VARCHAR2(300);
        NUOPERATINGUNITID       OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE;

        
        SBCOMMENTTYPE           VARCHAR2(300);
        NUCOMMENTTYPE           GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE;

        
        SBCOMMENT               GE_ACTA.COMMENT_%TYPE;

        
        SBSTATUSCONTRACTOR      GE_CONTRATISTA.STATUS%TYPE;
    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.ActivateContractor',10);

        
        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'CONTRACTOR_ID', SBCONTRACTORID);
        NUCONTRACTORID := TO_NUMBER(SBCONTRACTORID);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'OPERATING_UNIT_ID', SBOPERATINGUNITID);
        NUOPERATINGUNITID := TO_NUMBER(SBOPERATINGUNITID);
        
        
        SBSTATUSCONTRACTOR := CT_BOCONTRACTOR.FSBGETSTATUSCONTRACTOR(NUCONTRACTORID);
        
        
        IF (NUOPERATINGUNITID IS NULL AND SBSTATUSCONTRACTOR = CT_BOCONSTANTS.FSBGETAVAILABLESTATUS) THEN
            UT_TRACE.TRACE('Error - Si la unidad operativa es nula, el contratista debe estar en estado suspendido',11);
            ERRORS.SETERROR(CNUERRORSTATUSCONTRACTOR, CT_BOCONSTANTS.FSBGETDESCSTATUS(CT_BOCONSTANTS.FSBGETSUSPENDSTATUS) || '|' ||
                                    CT_BOCONSTANTS.FSBGETDESCCERTIFICATETYPE(CT_BOCONSTANTS.FNUGETACTIVATECERTITYPE));
            RAISE  EX.CONTROLLED_ERROR;
            
        END IF;

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'COMMENT_TYPE_ID', SBCOMMENTTYPE);
        NUCOMMENTTYPE := TO_NUMBER(SBCOMMENTTYPE);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'COMMENT_', SBCOMMENT);

        UT_TRACE.TRACE(' sbContractorId: [' || SBCONTRACTORID || ']
                        sbOperatingUnitId: [' || SBOPERATINGUNITID || ']
                        sbCommentType: [' || SBCOMMENTTYPE || ']
                        sbComment: [' || SBCOMMENT || ']', 11);

        
        CT_BOCONTRACTOR.CHANGESTATUSCONTRACTOR(NUCONTRACTORID, NUOPERATINGUNITID, NUCOMMENTTYPE, SBCOMMENT, CT_BOCONSTANTS.FSBGETAVAILABLESTATUS);

        COMMIT;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.ActivateContractor',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR - CONTROLLED_ERROR CT_BoFWCertificate.ActivateContractor',10);
            ROLLBACK;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR - OTHERS CT_BoFWCertificate.ActivateContractor',10);
            ROLLBACK;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ACTIVATECONTRACTOR;
    

     















    PROCEDURE VALIDATEINITIALIZECONTRACT
    IS

        
        SBINSTANCE              GE_BOINSTANCECONTROL.STYSBNAME;
        SBCONTRACTID            GE_BOUTILITIES.STYSTATEMENT;
        NUINDEX                 GE_BOINSTANCECONTROL.STYNUINDEX;
        NUCONTRACTID            GE_CONTRATO.ID_CONTRATO%TYPE;
        SBSTATUSREGISTER        GE_CONTRATO.STATUS%TYPE;
        SBSTATUSCONTRACT        GE_CONTRATO.STATUS%TYPE;

    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.ValidateInitializeContract',10);

        
        GE_BOINSTANCECONTROL.ACCKEYATTRIBUTESTACK('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',NUINDEX);
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',SBCONTRACTID);
        NUCONTRACTID := UT_CONVERT.FNUCHARTONUMBER(SBCONTRACTID);
        
        
        SBSTATUSREGISTER := CT_BOCONSTANTS.FSBGETREGISTERSTATUS;

        
        SBSTATUSCONTRACT := CT_BOCONTRACT.FSBGETSTATUSCONTRACT(NUCONTRACTID);

        
        IF SBSTATUSCONTRACT = SBSTATUSREGISTER THEN
            GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA','ID_CONTRATO',NUCONTRACTID);
        ELSE
            UT_TRACE.TRACE('Error - El estado del contrato no es v�lido para la ejecuci�n del Acta de Apertura',10);
            ERRORS.SETERROR(CNUERRORSTATUSCONTRACT, CT_BOCONSTANTS.FSBGETDESCSTATUS(SBSTATUSREGISTER) || '|' ||
                                    CT_BOCONSTANTS.FSBGETDESCCERTIFICATETYPE(CT_BOCONSTANTS.FNUGETOPENCERTITYPE ));
            RAISE  EX.CONTROLLED_ERROR;
        END IF;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.ValidateInitializeContract',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR - CONTROLLED_ERROR CT_BoFWCertificate.ValidateInitializeContract',10);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR - OTHERS CT_BoFWCertificate.ValidateInitializeContract',10);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDATEINITIALIZECONTRACT;
    

    
    













    PROCEDURE INITIALIZECONTRACT
    IS

        

        
        SBINSTANCE              GE_BOINSTANCECONTROL.STYSBNAME;

         
        SBCONTRACTID          GE_BOUTILITIES.STYSTATEMENT;
        NUCONTRACTID          GE_CONTRATISTA.ID_CONTRATISTA%TYPE;

        
        SBVALUETOTAL          GE_BOUTILITIES.STYSTATEMENT;
        NUVALUETOTAL          GE_ACTA.VALOR_TOTAL%TYPE;
        
        
        SBVALUEADVANCE        GE_BOUTILITIES.STYSTATEMENT;
        NUVALUEADVANCE        GE_ACTA.VALUE_ADVANCE%TYPE;
        
        
        SBINITIALDATE         GE_BOUTILITIES.STYSTATEMENT;
        DTINITIALDATE         GE_ACTA.FECHA_INICIO%TYPE;
        
        
        SBFINALDATE           GE_BOUTILITIES.STYSTATEMENT;
        DTFINALDATE           GE_ACTA.FECHA_FIN%TYPE;
        
        
        SBCOMMENTTYPE          GE_BOUTILITIES.STYSTATEMENT;
        NUCOMMENTTYPE          GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE;

        
        SBCOMMENT              GE_ACTA.COMMENT_%TYPE;

    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.InitializeContract',10);

        
        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'ID_CONTRATO', SBCONTRACTID);
        NUCONTRACTID := TO_NUMBER(SBCONTRACTID);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'VALOR_TOTAL', SBVALUETOTAL);
        NUVALUETOTAL := TO_NUMBER(SBVALUETOTAL);
        
        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'VALUE_ADVANCE', SBVALUEADVANCE);
        NUVALUEADVANCE := TO_NUMBER(SBVALUEADVANCE);
        
        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'FECHA_INICIO', SBINITIALDATE);
        DTINITIALDATE := UT_DATE.FDTDATEWITHFORMAT(SBINITIALDATE);
        
        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'FECHA_FIN', SBFINALDATE);
        DTFINALDATE := UT_DATE.FDTDATEWITHFORMAT(SBFINALDATE);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'COMMENT_TYPE_ID', SBCOMMENTTYPE);
        NUCOMMENTTYPE := TO_NUMBER(SBCOMMENTTYPE);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'COMMENT_', SBCOMMENT);

        UT_TRACE.TRACE(' sbContractId: [' || SBCONTRACTID || ']
         sbValueTotal: [' || SBVALUETOTAL || ']
         sbValueAdvance: [' || SBVALUEADVANCE || ']
         sbInitialDate: [' || SBINITIALDATE || ']
         sbFinalDate: [' || SBFINALDATE || ']
         sbCommentType: [' || SBCOMMENTTYPE || ']
         sbComment: [' || SBCOMMENT || ']', 11);

        
        CT_BOCONTRACT.INITIALIZECONTRACT(NUCONTRACTID, NUVALUETOTAL,NUVALUEADVANCE,DTINITIALDATE, DTFINALDATE,
                                             NUCOMMENTTYPE,  SBCOMMENT);

        COMMIT;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.InitializeContract',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR - CONTROLLED_ERROR CT_BoFWCertificate.InitializeContract',10);
            ROLLBACK;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR - OTHERS CT_BoFWCertificate.InitializeContract',10);
            ROLLBACK;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END INITIALIZECONTRACT;
    
    














    PROCEDURE VALIDATECHANGECONTRACT
    IS

        
        SBINSTANCE              GE_BOINSTANCECONTROL.STYSBNAME;
        SBCONTRACTID            GE_BOUTILITIES.STYSTATEMENT;
        NUINDEX                 GE_BOINSTANCECONTROL.STYNUINDEX;
        NUCONTRACTID            GE_CONTRATO.ID_CONTRATO%TYPE;
        SBSTATUSOPEN            GE_CONTRATO.STATUS%TYPE;
        SBSTATUSCONTRACT        GE_CONTRATO.STATUS%TYPE;
        
        
        
        NUVALUETOTAL          GE_ACTA.VALOR_TOTAL%TYPE;
        
        NUVALUEADVANCE        GE_ACTA.VALUE_ADVANCE%TYPE;
        
        DTINITIALDATE         GE_ACTA.FECHA_INICIO%TYPE;
        
        DTFINALDATE           GE_ACTA.FECHA_FIN%TYPE;

    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.ValidateChangeContract',10);

        
        GE_BOINSTANCECONTROL.ACCKEYATTRIBUTESTACK('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',NUINDEX);
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',SBCONTRACTID);
        NUCONTRACTID := UT_CONVERT.FNUCHARTONUMBER(SBCONTRACTID);

        
        SBSTATUSOPEN := CT_BOCONSTANTS.FSBGETOPENSTATUS;

        
        SBSTATUSCONTRACT := CT_BOCONTRACT.FSBGETSTATUSCONTRACT(NUCONTRACTID);

        
        IF SBSTATUSCONTRACT = SBSTATUSOPEN THEN
            NUVALUETOTAL   := DAGE_CONTRATO.FNUGETVALOR_TOTAL_CONTRATO(NUCONTRACTID,0);
            NUVALUEADVANCE := DAGE_CONTRATO.FNUGETVALOR_ANTICIPO(NUCONTRACTID,0);
            DTINITIALDATE  := DAGE_CONTRATO.FDTGETFECHA_INICIAL(NUCONTRACTID,0);
            DTFINALDATE    := DAGE_CONTRATO.FDTGETFECHA_FINAL(NUCONTRACTID,0);

            GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );

            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA','ID_CONTRATO',NUCONTRACTID);
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA','VALOR_TOTAL',NUVALUETOTAL);
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA','VALUE_ADVANCE',NUVALUEADVANCE);
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA','FECHA_INICIO', TO_CHAR(DTINITIALDATE, UT_DATE.FSBDATE_FORMAT));
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA','FECHA_FIN',TO_CHAR(DTFINALDATE, UT_DATE.FSBDATE_FORMAT));
            
        ELSE
            UT_TRACE.TRACE('Error - El estado del contrato no es v�lido para la ejecuci�n del Acta de Modificaci�n',10);
            ERRORS.SETERROR(CNUERRORSTATUSCONTRACT, CT_BOCONSTANTS.FSBGETDESCSTATUS(SBSTATUSOPEN) || '|' ||
                                    CT_BOCONSTANTS.FSBGETDESCCERTIFICATETYPE(CT_BOCONSTANTS.FNUGETCHANGECERTITYPE ));
            RAISE  EX.CONTROLLED_ERROR;
        END IF;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.ValidateChangeContract',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR - CONTROLLED_ERROR CT_BoFWCertificate.ValidateChangeContract',10);
            RAISE  EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR - OTHERS CT_BoFWCertificate.ValidateChangeContract',10);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDATECHANGECONTRACT;
    
    















    PROCEDURE CHANGECONTRACT
    IS

        

        
        SBINSTANCE              GE_BOINSTANCECONTROL.STYSBNAME;

         
        SBCONTRACTID          GE_BOUTILITIES.STYSTATEMENT;
        NUCONTRACTID          GE_CONTRATISTA.ID_CONTRATISTA%TYPE;

        
        SBVALUETOTAL          GE_BOUTILITIES.STYSTATEMENT;
        NUVALUETOTAL          GE_ACTA.VALOR_TOTAL%TYPE;

        
        SBVALUEADVANCE        GE_BOUTILITIES.STYSTATEMENT;
        NUVALUEADVANCE        GE_ACTA.VALUE_ADVANCE%TYPE;
        
        
        SBINITIALDATE         GE_BOUTILITIES.STYSTATEMENT;
        DTINITIALDATE         GE_ACTA.FECHA_INICIO%TYPE;

        
        SBFINALDATE           GE_BOUTILITIES.STYSTATEMENT;
        DTFINALDATE           GE_ACTA.FECHA_FIN%TYPE;

        
        SBCOMMENTTYPE          GE_BOUTILITIES.STYSTATEMENT;
        NUCOMMENTTYPE          GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE;

        
        SBCOMMENT              GE_ACTA.COMMENT_%TYPE;

    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.ChangeContract',10);

        
        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'ID_CONTRATO', SBCONTRACTID);
        NUCONTRACTID := TO_NUMBER(SBCONTRACTID);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'VALOR_TOTAL', SBVALUETOTAL);
        NUVALUETOTAL := TO_NUMBER(SBVALUETOTAL);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'VALUE_ADVANCE', SBVALUEADVANCE);
        NUVALUEADVANCE := TO_NUMBER(SBVALUEADVANCE);
        
         
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'FECHA_INICIO', SBINITIALDATE);
        DTINITIALDATE := UT_DATE.FDTDATEWITHFORMAT(SBINITIALDATE);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'FECHA_FIN', SBFINALDATE);
        DTFINALDATE := UT_DATE.FDTDATEWITHFORMAT(SBFINALDATE);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'COMMENT_TYPE_ID', SBCOMMENTTYPE);
        NUCOMMENTTYPE := TO_NUMBER(SBCOMMENTTYPE);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'COMMENT_', SBCOMMENT);

        UT_TRACE.TRACE(' sbContractId: [' || SBCONTRACTID || ']
         sbValueTotal: [' || SBVALUETOTAL || ']
         sbValueAdvance: [' || SBVALUEADVANCE || ']
         sbInitialDate: [' || SBINITIALDATE || ']
         sbFinalDate: [' || SBFINALDATE || ']
         sbCommentType: [' || SBCOMMENTTYPE || ']
         sbComment: [' || SBCOMMENT || ']', 11);
         
        
        CT_BOCONTRACT.CHANGECONTRACT(NUCONTRACTID, NUVALUETOTAL,NUVALUEADVANCE, DTINITIALDATE, DTFINALDATE,NUCOMMENTTYPE, SBCOMMENT);

        COMMIT;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.ChangeContract',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR - CONTROLLED_ERROR CT_BoFWCertificate.ChangeContract',10);
            ROLLBACK;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR - OTHERS CT_BoFWCertificate.ChangeContract',10);
            ROLLBACK;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CHANGECONTRACT;
    
    
    














    PROCEDURE VALIDATESUSPENDCONTRACT
    IS

        
        SBINSTANCE              GE_BOINSTANCECONTROL.STYSBNAME;
        SBCONTRACTID            GE_BOUTILITIES.STYSTATEMENT;
        NUINDEX                 GE_BOINSTANCECONTROL.STYNUINDEX;
        NUCONTRACTID            GE_CONTRATO.ID_CONTRATO%TYPE;
        SBSTATUSOPEN            GE_CONTRATO.STATUS%TYPE;
        SBSTATUSCONTRACT        GE_CONTRATO.STATUS%TYPE;

    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.ValidateSuspendContract',10);

        
        GE_BOINSTANCECONTROL.ACCKEYATTRIBUTESTACK('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',NUINDEX);
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',SBCONTRACTID);
        
        NUCONTRACTID := UT_CONVERT.FNUCHARTONUMBER(SBCONTRACTID);

        
        SBSTATUSOPEN := CT_BOCONSTANTS.FSBGETOPENSTATUS;

        
        SBSTATUSCONTRACT := CT_BOCONTRACT.FSBGETSTATUSCONTRACT(NUCONTRACTID);

        
        IF SBSTATUSCONTRACT = SBSTATUSOPEN THEN
            GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA','ID_CONTRATO',NUCONTRACTID);
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_CONTRATO','STATUS',CT_BOCONSTANTS.FSBGETDESCSTATUS(SBSTATUSOPEN));
        ELSE
            UT_TRACE.TRACE('Error - El estado del contrato no es v�lido para la ejecuci�n del Acta de Suspensi�n',10);
            ERRORS.SETERROR(CNUERRORSTATUSCONTRACT, CT_BOCONSTANTS.FSBGETDESCSTATUS(SBSTATUSOPEN) || '|' ||
                                    CT_BOCONSTANTS.FSBGETDESCCERTIFICATETYPE(CT_BOCONSTANTS.FNUGETSUSPENDCERTITYPE ));
            RAISE  EX.CONTROLLED_ERROR;
        END IF;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.ValidateSuspendContract',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR - CONTROLLED_ERROR CT_BoFWCertificate.ValidateSuspendContract',10);
            RAISE  EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR - OTHERS CT_BoFWCertificate.ValidateSuspendContract',10);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDATESUSPENDCONTRACT;
    
    













    PROCEDURE SUSPENDCONTRACT
    IS

        

        
        SBINSTANCE              GE_BOINSTANCECONTROL.STYSBNAME;
        NUINDEX                 GE_BOINSTANCECONTROL.STYNUINDEX;

         
        SBCONTRACTID          GE_BOUTILITIES.STYSTATEMENT;
        NUCONTRACTID          GE_CONTRATISTA.ID_CONTRATISTA%TYPE;

        
        SBCOMMENTTYPE          GE_BOUTILITIES.STYSTATEMENT;
        NUCOMMENTTYPE          GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE;

        
        SBCOMMENT              GE_ACTA.COMMENT_%TYPE;

    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.SuspendContract',10);

        
        GE_BOINSTANCECONTROL.ACCKEYATTRIBUTESTACK('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',NUINDEX);
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',SBCONTRACTID);
        NUCONTRACTID := UT_CONVERT.FNUCHARTONUMBER(SBCONTRACTID);

        
        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );
        
        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'COMMENT_TYPE_ID', SBCOMMENTTYPE);
        NUCOMMENTTYPE := UT_CONVERT.FNUCHARTONUMBER(SBCOMMENTTYPE);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'COMMENT_', SBCOMMENT);

        UT_TRACE.TRACE(' sbCommentType: [' || SBCOMMENTTYPE || ']
                         sbComment: [' || SBCOMMENT || ']', 11);

        
        CT_BOCONTRACT.CHANGESTATUSCONTRACT(NUCONTRACTID,NUCOMMENTTYPE, SBCOMMENT, CT_BOCONSTANTS.FSBGETSUSPENDSTATUS);

        COMMIT;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.SuspendContract',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR - CONTROLLED_ERROR CT_BoFWCertificate.SuspendContract',10);
            ROLLBACK;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR - OTHERS CT_BoFWCertificate.SuspendContract',10);
            ROLLBACK;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SUSPENDCONTRACT;
    
    














    PROCEDURE VALIDATEACTIVATECONTRACT
    IS

        
        SBINSTANCE              GE_BOINSTANCECONTROL.STYSBNAME;
        SBCONTRACTID            GE_BOUTILITIES.STYSTATEMENT;
        NUINDEX                 GE_BOINSTANCECONTROL.STYNUINDEX;
        NUCONTRACTID            GE_CONTRATO.ID_CONTRATO%TYPE;
        SBSTATUSSUSPEND         GE_CONTRATO.STATUS%TYPE;
        SBSTATUSCONTRACT        GE_CONTRATO.STATUS%TYPE;

    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.ValidateActivateContract',10);

        
        GE_BOINSTANCECONTROL.ACCKEYATTRIBUTESTACK('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',NUINDEX);
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',SBCONTRACTID);

        NUCONTRACTID := UT_CONVERT.FNUCHARTONUMBER(SBCONTRACTID);

        
        SBSTATUSSUSPEND := CT_BOCONSTANTS.FSBGETSUSPENDSTATUS;

        
        SBSTATUSCONTRACT := CT_BOCONTRACT.FSBGETSTATUSCONTRACT(NUCONTRACTID);

        
        IF SBSTATUSCONTRACT = SBSTATUSSUSPEND THEN
            GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA','ID_CONTRATO',NUCONTRACTID);
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_CONTRATO','STATUS',CT_BOCONSTANTS.FSBGETDESCSTATUS(SBSTATUSSUSPEND));
        ELSE
            UT_TRACE.TRACE('Error - El estado del contrato no es v�lido para la ejecuci�n del Acta de Reactivaci�n',10);
            ERRORS.SETERROR(CNUERRORSTATUSCONTRACT, CT_BOCONSTANTS.FSBGETDESCSTATUS(SBSTATUSSUSPEND) || '|' ||
                                    CT_BOCONSTANTS.FSBGETDESCCERTIFICATETYPE(CT_BOCONSTANTS.FNUGETACTIVATECERTITYPE ));
            RAISE  EX.CONTROLLED_ERROR;
        END IF;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.ValidateActivateContract',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR - CONTROLLED_ERROR CT_BoFWCertificate.ValidateActivateContract',10);
            RAISE  EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR - OTHERS CT_BoFWCertificate.ValidateActivateContract',10);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDATEACTIVATECONTRACT;
    
    













    PROCEDURE ACTIVATECONTRACT
    IS

        

        
        SBINSTANCE              GE_BOINSTANCECONTROL.STYSBNAME;
        NUINDEX                 GE_BOINSTANCECONTROL.STYNUINDEX;

         
        SBCONTRACTID          GE_BOUTILITIES.STYSTATEMENT;
        NUCONTRACTID          GE_CONTRATISTA.ID_CONTRATISTA%TYPE;

        
        SBCOMMENTTYPE          GE_BOUTILITIES.STYSTATEMENT;
        NUCOMMENTTYPE          GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE;

        
        SBCOMMENT              GE_ACTA.COMMENT_%TYPE;

    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.ActivateContract',10);

        
        GE_BOINSTANCECONTROL.ACCKEYATTRIBUTESTACK('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',NUINDEX);
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',SBCONTRACTID);
        NUCONTRACTID := UT_CONVERT.FNUCHARTONUMBER(SBCONTRACTID);

        
        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'COMMENT_TYPE_ID', SBCOMMENTTYPE);
        NUCOMMENTTYPE := UT_CONVERT.FNUCHARTONUMBER(SBCOMMENTTYPE);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'COMMENT_', SBCOMMENT);

        UT_TRACE.TRACE(' sbCommentType: [' || SBCOMMENTTYPE || ']
                         sbComment: [' || SBCOMMENT || ']', 11);
                         
        
        CT_BOCONTRACT.CHANGESTATUSCONTRACT(NUCONTRACTID,NUCOMMENTTYPE, SBCOMMENT, CT_BOCONSTANTS.FSBGETOPENSTATUS);

        COMMIT;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.ActivateContract',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR - CONTROLLED_ERROR CT_BoFWCertificate.ActivateContract',10);
            ROLLBACK;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR - OTHERS CT_BoFWCertificate.ActivateContract',10);
            ROLLBACK;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ACTIVATECONTRACT;
    
    














    PROCEDURE VALIDATECANCELCONTRACT
    IS

        
        SBINSTANCE              GE_BOINSTANCECONTROL.STYSBNAME;
        SBCONTRACTID            GE_BOUTILITIES.STYSTATEMENT;
        NUINDEX                 GE_BOINSTANCECONTROL.STYNUINDEX;
        NUCONTRACTID            GE_CONTRATO.ID_CONTRATO%TYPE;
        SBSTATUSREGISTER          GE_CONTRATO.STATUS%TYPE;
        SBSTATUSCONTRACT        GE_CONTRATO.STATUS%TYPE;

    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.ValidateCancelContract',10);

        
        GE_BOINSTANCECONTROL.ACCKEYATTRIBUTESTACK('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',NUINDEX);
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',SBCONTRACTID);

        NUCONTRACTID := UT_CONVERT.FNUCHARTONUMBER(SBCONTRACTID);

        
        SBSTATUSREGISTER := CT_BOCONSTANTS.FSBGETREGISTERSTATUS;

        
        SBSTATUSCONTRACT := CT_BOCONTRACT.FSBGETSTATUSCONTRACT(NUCONTRACTID);

        
        IF SBSTATUSCONTRACT = SBSTATUSREGISTER THEN
            GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA','ID_CONTRATO',NUCONTRACTID);
            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_CONTRATO','STATUS',CT_BOCONSTANTS.FSBGETDESCSTATUS(SBSTATUSREGISTER));
        ELSE
            UT_TRACE.TRACE('Error - El estado del contrato no es v�lido para la ejecuci�n del Acta de Anulaci�n',10);
            ERRORS.SETERROR(CNUERRORSTATUSCONTRACT, CT_BOCONSTANTS.FSBGETDESCSTATUS(SBSTATUSREGISTER) || '|' ||
                                    CT_BOCONSTANTS.FSBGETDESCCERTIFICATETYPE(CT_BOCONSTANTS.FNUGETCANCELCERTITYPE ));
            RAISE  EX.CONTROLLED_ERROR;
        END IF;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.ValidateCancelContract',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR - CONTROLLED_ERROR CT_BoFWCertificate.ValidateCancelContract',10);
            RAISE  EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR - OTHERS CT_BoFWCertificate.ValidateCancelContract',10);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDATECANCELCONTRACT;
    
    













    PROCEDURE CANCELCONTRACT
    IS

        

        
        SBINSTANCE              GE_BOINSTANCECONTROL.STYSBNAME;
        NUINDEX                 GE_BOINSTANCECONTROL.STYNUINDEX;

         
        SBCONTRACTID          GE_BOUTILITIES.STYSTATEMENT;
        NUCONTRACTID          GE_CONTRATISTA.ID_CONTRATISTA%TYPE;

        
        SBCOMMENTTYPE          GE_BOUTILITIES.STYSTATEMENT;
        NUCOMMENTTYPE          GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE;

        
        SBCOMMENT              GE_ACTA.COMMENT_%TYPE;

    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.CancelContract',10);

        
        GE_BOINSTANCECONTROL.ACCKEYATTRIBUTESTACK('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',NUINDEX);
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',SBCONTRACTID);
        NUCONTRACTID := UT_CONVERT.FNUCHARTONUMBER(SBCONTRACTID);

        
        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'COMMENT_TYPE_ID', SBCOMMENTTYPE);
        NUCOMMENTTYPE := UT_CONVERT.FNUCHARTONUMBER(SBCOMMENTTYPE);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'COMMENT_', SBCOMMENT);

        UT_TRACE.TRACE(' sbCommentType: [' || SBCOMMENTTYPE || ']
                         sbComment: [' || SBCOMMENT || ']', 11);
                         
        
        CT_BOCONTRACT.CHANGESTATUSCONTRACT(NUCONTRACTID,NUCOMMENTTYPE, SBCOMMENT, CT_BOCONSTANTS.FSBGETCANCELSTATUS);

        COMMIT;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.CancelContract',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR - CONTROLLED_ERROR CT_BoFWCertificate.CancelContract',10);
            ROLLBACK;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR - OTHERS CT_BoFWCertificate.CancelContract',10);
            ROLLBACK;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CANCELCONTRACT;
    
    















    PROCEDURE DEFINECONTRACT
    IS

        NUCONTRACT    GE_CONTRATO.ID_CONTRATO%TYPE;
        NUORDER       OR_ORDER.ORDER_ID%TYPE;

        SBCONTRACT    GE_BOINSTANCECONTROL.STYSBVALUE;
        SBORDER       GE_BOINSTANCECONTROL.STYSBVALUE;

    BEGIN
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.DefineContract',5);

        
        SBCONTRACT  := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_CONTRATO', 'ID_CONTRATO');
        NUCONTRACT  := TO_NUMBER(SBCONTRACT);

        
        SBORDER     := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('OR_ORDER', 'ORDER_ID');
        NUORDER     := TO_NUMBER(SBORDER);

        
        CT_BOCERTIFICATE.DEFINECONTRACT(NUORDER, NUCONTRACT);
        
        
        COMMIT;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.DefineContract',5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END DEFINECONTRACT;
    
     



















    PROCEDURE REGENERATEOBLIGATION
    IS

        NUCERTIFICATEID     GE_ACTA.ID_ACTA%TYPE;

        SBCERTIFICATE       GE_BOINSTANCECONTROL.STYSBVALUE;

        NUINDEX             GE_BOINSTANCECONTROL.STYNUINDEX;
        
    BEGIN
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.RegenerateObligation',5);

        
        GE_BOINSTANCECONTROL.ACCKEYATTRIBUTESTACK('WORK_INSTANCE',NULL,'CT_FW_ACTA','ID_ACTA',NUINDEX);
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',NULL,'CT_FW_ACTA','ID_ACTA',SBCERTIFICATE);
        
        NUCERTIFICATEID := UT_CONVERT.FNUCHARTONUMBER(SBCERTIFICATE);

        UT_TRACE.TRACE('nuCertificateId: ' || NUCERTIFICATEID,1);

        
        GE_BOCERTIFICATE.LOCKCERTIFICATEBYPK(NUCERTIFICATEID);
        
       
        IF(GE_BCCERTIFICATE.FNUVALORDERRELATEDADJUST(NUCERTIFICATEID) > 0) THEN
        
            UT_TRACE.TRACE('Error - Existen �rdenes con ajustes, hacer la regeneraci�n por CTVMO-Verificaci�n y Modificaci�n de �rdenes',11);
            ERRORS.SETERROR (2741,'Error - Existen �rdenes con ajustes, asociadas al acta. Regenerar por CTVMO-Verificaci�n y Modificaci�n de �rdenes');
            RAISE  EX.CONTROLLED_ERROR;
            
        END IF;

        
        CT_BOCERTIFICATE.REGENERATEALLOBLIGATION
        (
            NUCERTIFICATEID
        );
        
        
        GE_BOINSTANCECONTROL.ADDATTRIBUTE('WORK_INSTANCE',
                                          NULL,
                                          'SUCCESS_MESSAGE_ENTITY',
                                          'SUCCESS_MESSAGE_ATTRIBUTE',
                                          110583);

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.RegenerateObligation',5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ROLLBACK;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ROLLBACK;
            RAISE EX.CONTROLLED_ERROR;
    END REGENERATEOBLIGATION;
    
    













    FUNCTION FRFGETORDERSTOMARK
    RETURN CONSTANTS.TYREFCURSOR
    IS
        RFCURSOR CONSTANTS.TYREFCURSOR;

        SBID_PERIODO         GE_BOINSTANCECONTROL.STYSBVALUE;
        NUPERIODID           GE_PERIODO_CERT.ID_PERIODO%TYPE;
        SBID_CONTRATISTA     GE_BOINSTANCECONTROL.STYSBVALUE;
        NUCONTRACTORID       GE_CONTRATO.ID_CONTRATISTA%TYPE;
        
    BEGIN
        UT_TRACE.TRACE('Inicia CT_BoFWCertificate.frfGetOrdersToMark',15);

         
        SBID_PERIODO         := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_PERIODO_CERT',
                                                                      'ID_PERIODO');
        NUPERIODID := TO_NUMBER(SBID_PERIODO);

        SBID_CONTRATISTA     := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_CONTRATISTA',
                                                                      'ID_CONTRATISTA');
        NUCONTRACTORID := TO_NUMBER(SBID_CONTRATISTA);
        
        RFCURSOR := CT_BCCERTIFICATE.FRFGETORDERSTOMARK
                    (
                        NUCONTRACTORID,
                        DAGE_PERIODO_CERT.FDTGETFECHA_INICIAL(NUPERIODID),
                        DAGE_PERIODO_CERT.FDTGETFECHA_FINAL(NUPERIODID)
                    );

        UT_TRACE.TRACE('Finaliza CT_BoFWCertificate.frfGetOrdersToMark',15);

        RETURN RFCURSOR;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FRFGETORDERSTOMARK;
    
    











    PROCEDURE MARKORDERSTOLIQ
    (
        INUORDERID    IN OR_ORDER.ORDER_ID%TYPE,
        INUCURRENT   IN NUMBER,
        INUTOTAL     IN NUMBER,
        ONUERRORCODE OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
        OSBERRORMESS OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS

    BEGIN
        
        UT_TRACE.TRACE('INICIO ct_bofwCertificate.MarkOrdersToLiq',12);

        UT_TRACE.TRACE( 'inuCurrent: '||INUCURRENT || CHR(10) ||
                        'inuOrderId: '||INUORDERID || CHR(10) ||
                        'inuTotal: '  ||INUTOTAL,5);


        DAOR_ORDER.UPDIS_PENDING_LIQ(INUORDERID, GE_BOCONSTANTS.CSBYES);
        IF (INUCURRENT = INUTOTAL) THEN
        	
            COMMIT;
        END IF;

        UT_TRACE.TRACE('FIN ct_bofwCertificate.MarkOrdersToLiq',12);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESS);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESS);
    END MARKORDERSTOLIQ;
    
    













    PROCEDURE VALIDATEINACTIVATECONTRACTOR
    IS

        
        SBINSTANCE              GE_BOINSTANCECONTROL.STYSBNAME;
        SBCONTRACTORID          GE_BOUTILITIES.STYSTATEMENT;
        NUINDEX                 GE_BOINSTANCECONTROL.STYNUINDEX;
        NUCONTRACTORID          GE_CONTRATISTA.ID_CONTRATISTA%TYPE;
        SBSTATUSCONTRACTOR      GE_CONTRATISTA.STATUS%TYPE;

    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.validateInactivateContractor',10);

        
        GE_BOINSTANCECONTROL.ACCKEYATTRIBUTESTACK('WORK_INSTANCE',NULL,'GE_CONTRATISTA','ID_CONTRATISTA',NUINDEX);
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',NULL,'GE_CONTRATISTA','ID_CONTRATISTA',SBCONTRACTORID);
        NUCONTRACTORID := UT_CONVERT.FNUCHARTONUMBER(SBCONTRACTORID);

        
        SBSTATUSCONTRACTOR := CT_BOCONTRACTOR.FSBGETSTATUSCONTRACTOR(NUCONTRACTORID);

        
        IF SBSTATUSCONTRACTOR <> CT_BOCONSTANTS.FSBGETAVAILABLESTATUS THEN
            UT_TRACE.TRACE('Error - El estado del contratista no es v�lido para la ejecuci�n del Acta de suspensi�n',11);
            ERRORS.SETERROR(CNUERRORSTATUSCONTRACTOR, CT_BOCONSTANTS.FSBGETDESCSTATUS(CT_BOCONSTANTS.FSBGETAVAILABLESTATUS) || '|' ||
                                    CT_BOCONSTANTS.FSBGETDESCCERTIFICATETYPE(CT_BOCONSTANTS.FNUGETINACTIVATECERTITYPE));
            RAISE  EX.CONTROLLED_ERROR;
        END IF;
        
        
        IF CT_BCCONTRACT.FNUCOUNTNOCLOSEOCONTRACTS(NUCONTRACTORID) > 0 THEN
            UT_TRACE.TRACE('Error - existen contratos en estados no finales.',11);
            ERRORS.SETERROR (901878);
            RAISE  EX.CONTROLLED_ERROR;
        END IF;
        
        
        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );
        GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA','CONTRACTOR_ID',NUCONTRACTORID);
        GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_CONTRATISTA','STATUS',CT_BOCONSTANTS.FSBGETDESCSTATUS(CT_BOCONSTANTS.FSBGETAVAILABLESTATUS));

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.validateInactivateContractor',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR - CONTROLLED_ERROR CT_BoFWCertificate.validateInactivateContractor',10);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR - OTHERS CT_BoFWCertificate.validateInactivateContractor',10);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDATEINACTIVATECONTRACTOR;
    
    













    PROCEDURE INACTIVATECONTRACTOR
    IS

        

        
        SBINSTANCE              GE_BOINSTANCECONTROL.STYSBNAME;

         
        SBCONTRACTORID          VARCHAR2(300);
        NUCONTRACTORID          GE_CONTRATISTA.ID_CONTRATISTA%TYPE;

        
        SBCOMMENTTYPE           VARCHAR2(300);
        NUCOMMENTTYPE           GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE;

        
        SBCOMMENT               GE_ACTA.COMMENT_%TYPE;

    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BoFWCertificate.SuspendContractor',10);

        
        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'CONTRACTOR_ID', SBCONTRACTORID);
        NUCONTRACTORID := TO_NUMBER(SBCONTRACTORID);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'COMMENT_TYPE_ID', SBCOMMENTTYPE);
        NUCOMMENTTYPE := TO_NUMBER(SBCOMMENTTYPE);

        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(SBINSTANCE,NULL,'GE_ACTA', 'COMMENT_', SBCOMMENT);

         UT_TRACE.TRACE(' sbContractorId: [' || SBCONTRACTORID || ']
                          sbCommentType: [' || SBCOMMENTTYPE || ']
                          sbComment: [' || SBCOMMENT || ']' , 11);

        
        CT_BOCONTRACTOR.INACTIVATECONTRACTOR(NUCONTRACTORID, NUCOMMENTTYPE, SBCOMMENT);

        COMMIT;

        UT_TRACE.TRACE('FIN CT_BoFWCertificate.SuspendContractor',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR - CONTROLLED_ERROR CT_BoFWCertificate.InactivateContractor',10);
            ROLLBACK;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR - OTHERS CT_BoFWCertificate.InactivateContractor',10);
            ROLLBACK;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END INACTIVATECONTRACTOR;
    
    














    PROCEDURE VALIDATECLOSECERTIFICA
    IS
        NUACTA                          GE_ACTA.ID_ACTA%TYPE;
        SBINSTANCE                      VARCHAR2(300);
        CSBERRORESTADO      CONSTANT    GE_MESSAGE.MESSAGE_ID%TYPE     := 9481;
    BEGIN

        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE
        (
            GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
            NULL,
            'CT_FW_ACTA',
            'ID_ACTA',
            NUACTA
        );

        
        IF DAGE_ACTA.FSBGETESTADO(NUACTA) = GE_BOCONSTANTS.CSBACTA_CERRADA THEN
            GE_BOERRORS.SETERRORCODE(CSBERRORESTADO);
        END IF;


    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDATECLOSECERTIFICA;
    
END CT_BOFWCERTIFICATE;