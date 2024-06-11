PACKAGE BODY CM_BCConsumosPorServSusc IS
























































































    CSBVERSION CONSTANT VARCHAR2(25) := 'SAO217927';

    
    
    

    
    SBERRMSG	                GE_ERROR_LOG.DESCRIPTION%TYPE;


    















    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
    
        RETURN CSBVERSION;
    
    END;
























PROCEDURE GETCSNOTIFICONSUMPTION
(
    INUNOCRCONS         IN      CM_NOTICRIT.NOCRCONS%TYPE,
    OCUREFCURSOR        OUT     PKCONSTANTE.TYREFCURSOR
)
IS
BEGIN
    PKERRORS.PUSH('CM_BCConsumosPorServSusc.GetCSNotifiConsumption');

    OPEN OCUREFCURSOR FOR
        SELECT NOCRCONS CODIGO,
               NOCRSUSC,
               NOCRFECR,
               NOCRFACT,
               NOCROBSE,
               NOCRTINO ||' - ' ||TINCDESC TINCDESC,
               CONSSESU.ROWID PADRE
         FROM  CM_NOTICRIT, CM_TIPONOCR, CONSSESU
        WHERE  CM_NOTICRIT.NOCRTINO = CM_TIPONOCR.TINCCONS(+)
        AND    CM_NOTICRIT.NOCRPECO = CONSSESU.COSSPECS
        AND    CM_NOTICRIT.NOCRTICO = CONSSESU.COSSTCON
        AND    CM_NOTICRIT.NOCRSESU = CONSSESU.COSSSESU
        AND    CM_NOTICRIT.NOCRCONS = INUNOCRCONS
        AND    ROWNUM = 1;

    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
        RAISE LOGIN_DENIED;
    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE PKCONSTANTE.EXERROR_LEVEL2;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
END GETCSNOTIFICONSUMPTION;



















PROCEDURE GETHPNOTIFICONSUMPTION
(
    ISBCODIGO         IN      VARCHAR,
    OCUREFCURSOR      OUT     PKCONSTANTE.TYREFCURSOR
)
IS
BEGIN
    PKERRORS.PUSH('CM_BCConsumosPorServSusc.GetHPNotifiConsumption');

    UT_TRACE.TRACE('conssesu.rowid: '|| ISBCODIGO, 15);
    
    OPEN OCUREFCURSOR FOR
        SELECT NOCRCONS CODIGO,
               NOCRSUSC, NOCRFECR, NOCRFACT, NOCROBSE,
               NOCRTINO ||' - ' ||TINCDESC TINCDESC,
               ISBCODIGO PADRE
        FROM  CM_NOTICRIT, CM_TIPONOCR, CONSSESU
        WHERE  CM_NOTICRIT.NOCRTINO = CM_TIPONOCR.TINCCONS(+)
        AND    CM_NOTICRIT.NOCRPECO = CONSSESU.COSSPECS
        AND    CM_NOTICRIT.NOCRTICO = CONSSESU.COSSTCON
        AND    CM_NOTICRIT.NOCRSESU = CONSSESU.COSSSESU
        AND    CONSSESU.ROWID = ISBCODIGO
        ORDER BY NOCRCONS DESC;

    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
        RAISE LOGIN_DENIED;
    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE PKCONSTANTE.EXERROR_LEVEL2;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
END GETHPNOTIFICONSUMPTION;























PROCEDURE GETCSORDERCONSUMPTCRIT
(
    INUORCRORDE         IN      CM_ORDECRIT.ORCRORDE%TYPE,
    OCUREFCURSOR        OUT     PKCONSTANTE.TYREFCURSOR
)
IS
BEGIN
    PKERRORS.PUSH('CM_BCConsumosPorServSusc.GetCSOrderConsumptCrit');

    OPEN OCUREFCURSOR FOR
        SELECT CM_ORDECRIT.ORCRORDE CODIGO,
               OR_ORDER_STATUS.DESCRIPTION ORDER_STATUS,
               CM_ORDECRIT.ORCRLECT,
               CM_ORDECRIT.ORCRNOFU,
               CM_ORDECRIT.ORCRSESU  PADRE_ID
        FROM   CM_ORDECRIT, OR_ORDER, OR_ORDER_STATUS
        WHERE  OR_ORDER.ORDER_STATUS_ID = OR_ORDER_STATUS.ORDER_STATUS_ID
        AND    CM_ORDECRIT.ORCRORDE = OR_ORDER.ORDER_ID
        AND    CM_ORDECRIT.ORCRORDE = INUORCRORDE;

    PKERRORS.POP;

EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
        RAISE LOGIN_DENIED;
    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE PKCONSTANTE.EXERROR_LEVEL2;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
END GETCSORDERCONSUMPTCRIT;




















PROCEDURE GETHPORDERCONSUMPTCRIT
(
    ISBCODIGO         IN      VARCHAR,
    OCUREFCURSOR      OUT     PKCONSTANTE.TYREFCURSOR
)
IS
BEGIN
    PKERRORS.PUSH('CM_BCConsumosPorServSusc.GetHPOrderConsumptCrit');

    UT_TRACE.TRACE('conssesu.rowid: '|| ISBCODIGO, 15);
    
    OPEN OCUREFCURSOR FOR
        SELECT CM_ORDECRIT.ORCRORDE CODIGO,
               OR_ORDER_STATUS.DESCRIPTION ORDER_STATUS,
               CM_ORDECRIT.ORCRLECT,
               CM_ORDECRIT.ORCRNOFU,
               ISBCODIGO  PADRE_ID
        FROM   CM_ORDECRIT, OR_ORDER, OR_ORDER_STATUS, CONSSESU
        WHERE  OR_ORDER.ORDER_STATUS_ID = OR_ORDER_STATUS.ORDER_STATUS_ID
        AND    CM_ORDECRIT.ORCRORDE = OR_ORDER.ORDER_ID
        AND    CM_ORDECRIT.ORCRPECO = CONSSESU.COSSPECS
        AND    CM_ORDECRIT.ORCRTICO = CONSSESU.COSSTCON
        AND    CM_ORDECRIT.ORCRSESU = CONSSESU.COSSSESU
        AND    CONSSESU.ROWID = ISBCODIGO
        ORDER BY CM_ORDECRIT.ORCRORDE DESC;

    PKERRORS.POP;

EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
        RAISE LOGIN_DENIED;
    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE PKCONSTANTE.EXERROR_LEVEL2;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
END GETHPORDERCONSUMPTCRIT;

    





















    PROCEDURE GETCORRECTIONFACTOR
    (
        INUFACTORID    IN   CM_FACOCOSS.FCCOCONS%TYPE,
        OCUREFCURSOR   OUT  PKCONSTANTE.TYREFCURSOR
    )
    IS
    BEGIN
        PKERRORS.PUSH('CM_BCConsumosPorServSusc.GetCorrectionFactor');

        UT_TRACE.TRACE('Factor de correcci�n: '|| INUFACTORID, 5);

        IF (OCUREFCURSOR%ISOPEN) THEN
            CLOSE OCUREFCURSOR;
        END IF;

        OPEN OCUREFCURSOR FOR
            SELECT  /*+ index(CM_Facocoss PK_CM_FACOCOSS)*/
                    CM_FACOCOSS.FCCOCONS,
                    CM_FACOCOSS.FCCOPECS,
                    CM_FACOCOSS.FCCOUBGE,
                    CM_FACOCOSS.FCCOFACO,
                    CM_FACOCOSS.FCCOFAPR,
                    CM_FACOCOSS.FCCOFATE,
                    CM_FACOCOSS.FCCOFASC,
                    CM_FACOCOSS.FCCOFAPC,
                    CM_FACOCOSS.FCCOFACM,
                    CM_FACOCOSS.FCCOSESU PARENTID
            FROM    CM_FACOCOSS, CONSSESU /*+ CM_BCConsumosPorServSusc.GetCorrectionFactor */
            WHERE   CM_FACOCOSS.FCCOCONS = INUFACTORID;

        PKERRORS.POP;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    END GETCORRECTIONFACTOR;
    
    





















    PROCEDURE GETCORRECTFACTORBYCONS
    (
        ISBCONSROWID   IN   VARCHAR2,
        OCUREFCURSOR   OUT  PKCONSTANTE.TYREFCURSOR
    )
    IS
    BEGIN
        PKERRORS.PUSH('CM_BOConsumosPorServSusc.GetCorrectFactorByCons');

        UT_TRACE.TRACE('RowId del Conssesu: '|| ISBCONSROWID, 5);

        IF (OCUREFCURSOR%ISOPEN) THEN
            CLOSE OCUREFCURSOR;
        END IF;

        OPEN OCUREFCURSOR FOR
            SELECT  /*+ Rowid(Conssesu)*/
                    CM_FACOCOSS.FCCOCONS,
                    CM_FACOCOSS.FCCOPECS,
                    CM_FACOCOSS.FCCOUBGE,
                    CM_FACOCOSS.FCCOFACO,
                    CM_FACOCOSS.FCCOFAPR,
                    CM_FACOCOSS.FCCOFATE,
                    CM_FACOCOSS.FCCOFASC,
                    CM_FACOCOSS.FCCOFAPC,
                    CM_FACOCOSS.FCCOFACM,
                    ISBCONSROWID PARENTID
            FROM    CONSSESU, CM_FACOCOSS /*+ CM_BCConsumosPorServSusc.GetCorrectFactorByCons */
            WHERE   CM_FACOCOSS.FCCOCONS = CONSSESU.COSSFCCO
            AND     CONSSESU.ROWID = ISBCONSROWID;

        PKERRORS.POP;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    END GETCORRECTFACTORBYCONS;
    
    























































    PROCEDURE GETPRODCONSUMPTIONS
    (
        INUPRODUCT           IN          CONSSESU.COSSSESU%TYPE,
        INUCONSUMPTIONTYPE   IN          CONSSESU.COSSTCON%TYPE,
        INUCONSUMPTIONPERIOD IN          CONSSESU.COSSPECS%TYPE,
        ISBINCLUDECURRENT    IN          VARCHAR2,
        INUREGISTERSTORETURN IN          NUMBER,
        OTBCONSUMPTIONS      OUT NOCOPY  TYTBCONSUMPTIONS
    )
    IS
        
        
        
        CURSOR CUPRODCONSUMPTION
        IS
            SELECT  /*+ leading(vw_cmprodconsumptions)
                        use_nl(vw_cmprodconsumptions tipocons)
                        use_nl(vw_cmprodconsumptions cm_facocoss)
                    */
                    COSSSESU,            
                    COSSTCON,            
                    TCONDESC,            
                    COSSPECS,            
                    NVL(COSSSUMA,0),     
                    COSSNVEC,            
                    COSSMECC,            
                    MECCDESC,            
                    COSSDICO,            
                    COSSFERE,            
                    COSSFUFA,            
                    COSSCAVC,            
                    PECSFECI,            
                    PECSFECF,            
                    FCCOFACO             
            FROM    VW_CMPRODCONSUMPTIONS, TIPOCONS, CM_FACOCOSS
            --+ CM_BCConsumosPorServSusc.GetProdConsumptions
            WHERE   COSSSESU   = INUPRODUCT
            AND     COSSTCON   = TIPOCONS.TCONCODI
            AND     COSSFCCO   = CM_FACOCOSS.FCCOCONS (+)
            AND     COSSTCON+0 = NVL( INUCONSUMPTIONTYPE, COSSTCON )
            AND     PECSFECI  <= NVL(
                                        (
                                            SELECT   /*+ PUSH_SUBQ */
                                                     DECODE( ISBINCLUDECURRENT,
                                                             CM_BCMEASCONSUMPTIONS.CSBDONOT_INCLUDE_CURR_PER,
                                                             PECSFECI,
                                                             PECSFECI - 1)
                                            FROM     PERICOSE
                                            WHERE    PECSCONS = INUCONSUMPTIONPERIOD
                                        ), PECSFECI
                                     )
            ORDER BY PECSFECI DESC;
    BEGIN
        PKERRORS.PUSH('CM_BCConsumosPorServSusc.GetProdConsumptions');

        OPEN CUPRODCONSUMPTION;

        FETCH CUPRODCONSUMPTION BULK COLLECT INTO OTBCONSUMPTIONS
        LIMIT INUREGISTERSTORETURN;

        CLOSE CUPRODCONSUMPTION;

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    END GETPRODCONSUMPTIONS;












































PROCEDURE SEARCH_CONSBYPRODUCT
(
    INUPRODUCT              IN  CONSSESU.COSSSESU%TYPE,
    ISBMEASUREELEMENT       IN  ELEMMEDI.ELMECODI%TYPE,
    INUCONSUMPTIONPERIOD    IN  CONSSESU.COSSPECS%TYPE,
    INUCONSUMPTIONTYPE      IN  CONSSESU.COSSTCON%TYPE,
    ISBCALCCONSFUNCTION     IN  CONSSESU.COSSFUFA%TYPE,
    INUQUALIFICATION        IN  CONSSESU.COSSCAVC%TYPE,
    INUESTIMATIONTIMES      IN  CONSSESU.COSSNVEC%TYPE,
    ISBLIQFLAG              IN  CONSSESU.COSSFLLI%TYPE,
    OCUREFCURSOR            OUT PKCONSTANTE.TYREFCURSOR
)
IS
BEGIN
    PKERRORS.PUSH('CM_BCConsumosPorServSusc.Search_ConsByProduct');

    OPEN OCUREFCURSOR FOR
        SELECT  /*+ leading(VW_CMProdConsumptions)
                    index(@DataSource conssesu ix_conssesu02)
                    use_nl_with_index(mecacons pk_mecacons)
                    use_nl_with_index(pericose pk_pericose) */
                COSSROWID                                                           PRIMARY_KEY,
                COSSSESU                                                            PRODUCTO,
                COSSPECS||' ('||REPLACE(TO_CHAR(PECSFECI,'dd-Month-yyyy'),' ','')
                ||'  /  '||REPLACE(TO_CHAR(PECSFECF,'dd-Month-yyyy'),' ','')||')'   PERIODO,
                ( SELECT TCONCODI||' - '||TCONDESC
                  FROM   TIPOCONS WHERE TCONCODI = COSSTCON )                       TIPOCONSUMO,
                COSSSUMA                                                            CONSUMO,
                COSSDIAS                                                            DIASCONSUMO,
                ( SELECT CAVCCODI ||' - '||CAVCDESC
                  FROM   CALIVACO WHERE CAVCCODI = COSSCAVC )                       CALIFICACION,
                ( SELECT COSSELME||' - '||ELMECODI
                  FROM   ELEMMEDI WHERE ELMEIDEM = COSSELME )                       ELEMENTO,
                COSSFUFA                                                            FUNCIONCALC,
                COSSMECC||' - '||MECCDESC                                           METODO,
                COSSFERE                                                            FECHAREGISTRO,
                COSSNVEC                                                            VECESESTIMADO,
                NVL(CALCFLLI,PKCONSTANTE.NO)                                        FLAGLIQUIDADO,
                COSSFUNC                                                            FUNCIONARIO,
                COSSSESU                                                            PARENT_ID
        FROM    VW_CMPRODCONSUMPTIONS
                /*+ CM_BCConsumosPorServSusc.Search_ConsByProduct */
        WHERE   COSSPECS = INUCONSUMPTIONPERIOD
        AND     COSSSESU = NVL(INUPRODUCT,COSSSESU)
        AND     COSSTCON = NVL(INUCONSUMPTIONTYPE,COSSTCON)
                
        AND     ( ISBMEASUREELEMENT IS NULL OR NOT LNNVL(
                    COSSELME = ISBMEASUREELEMENT)
                )
        AND     ( ISBCALCCONSFUNCTION IS NULL OR NOT LNNVL(
                    LOWER(COSSFUFA) LIKE LOWER('%'||ISBCALCCONSFUNCTION||'%') )
                )
        AND     ( INUQUALIFICATION IS NULL OR NOT LNNVL(
                    COSSCAVC = INUQUALIFICATION )
                )
        AND     ( INUESTIMATIONTIMES IS NULL OR NOT LNNVL(
                    COSSNVEC = INUESTIMATIONTIMES )
                )
        AND     ( ISBLIQFLAG IS NULL OR NOT LNNVL(
                    NVL(CALCFLLI,PKCONSTANTE.NO) = ISBLIQFLAG ) )
        ORDER BY PECSFECI DESC;

    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);

END SEARCH_CONSBYPRODUCT;





































PROCEDURE QUERY_CONSBYPRODUCT
(
    ISBCONSROWID   IN   VARCHAR2,
    OCUREFCURSOR   OUT  PKCONSTANTE.TYREFCURSOR
)
IS
    
    
    
    NUPRODUCT           CONSSESU.COSSSESU%TYPE;
    NUCONSUMPTIONTYPE   CONSSESU.COSSTCON%TYPE;
    NUCONSUMPTIONPERIOD CONSSESU.COSSPECS%TYPE;
    NUMEASELEMENT       CONSSESU.COSSELME%TYPE;

    
    
    
    CURSOR CUINITIALCONS
    IS
        SELECT  COSSSESU, COSSTCON, COSSPECS, COSSELME
        FROM    CONSSESU
        WHERE   ROWID = ISBCONSROWID;
BEGIN
    PKERRORS.PUSH('CM_BCConsumosPorServSusc.Query_ConsByProduct');

    
    
    
    
    OPEN CUINITIALCONS;
    FETCH CUINITIALCONS
    INTO NUPRODUCT,NUCONSUMPTIONTYPE, NUCONSUMPTIONPERIOD,NUMEASELEMENT;
    CLOSE CUINITIALCONS;

    OPEN OCUREFCURSOR FOR
        SELECT  /*+ leading(ConsumoProducto) */
                COSSROWID                                                           PRIMARY_KEY,
                COSSSESU                                                            PRODUCTO,
                COSSPECS||' ('||REPLACE(TO_CHAR(PECSFECI,'dd-Month-yyyy'),' ','')
                ||'  /  '||REPLACE(TO_CHAR(PECSFECF,'dd-Month-yyyy'),' ','')||')'   PERIODO,
                ( SELECT TCONCODI||' - '||TCONDESC
                  FROM   TIPOCONS WHERE TCONCODI = COSSTCON )                       TIPOCONSUMO,
                COSSSUMA                                                            CONSUMO,
                COSSDIAS                                                            DIASCONSUMO,
                ( SELECT CAVCCODI ||' - '||CAVCDESC
                  FROM   CALIVACO WHERE CAVCCODI = COSSCAVC )                       CALIFICACION,
                ( SELECT COSSELME||' - '||ELMECODI
                  FROM   ELEMMEDI WHERE ELMEIDEM = COSSELME )                       ELEMENTO,
                COSSFUFA                                                            FUNCIONCALC,
                COSSMECC||' - '||MECCDESC                                           METODO,
                COSSFERE                                                            FECHAREGISTRO,
                COSSNVEC                                                            VECESESTIMADO,
                NVL(CALCFLLI,PKCONSTANTE.NO)                                        FLAGLIQUIDADO,
                COSSFUNC                                                            FUNCIONARIO,
                COSSSESU                                                            PARENT_ID
        FROM    VW_CMPRODCONSUMPTIONS
                /*+ CM_BCConsumosPorServSusc.Query_ConsByProduct */
        WHERE   COSSPECS = NUCONSUMPTIONPERIOD
        AND     COSSSESU = NUPRODUCT
        AND     COSSTCON = NUCONSUMPTIONTYPE;

    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);

END QUERY_CONSBYPRODUCT;






















PROCEDURE PARENT_CONSBYPRODUCT
(
    INUCODROWID IN      VARCHAR,
    ONUPRODUCT  OUT     CONSSESU.COSSSESU%TYPE
)
IS
BEGIN
    PKERRORS.PUSH('CM_BCConsumosPorServSusc.Parent_ConsByProduct');

    SELECT  COSSSESU
    INTO    ONUPRODUCT
    FROM    CONSSESU
            /*+ CM_BCConsumosPorServSusc.Parent_ConsByProduct */
    WHERE   ROWID = INUCODROWID;

    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);

END PARENT_CONSBYPRODUCT;
































PROCEDURE CHILDS_CONSBYPRODUCT
(
    INUPRODUCT     IN  CONSSESU.COSSSESU%TYPE,
    OCUREFCURSOR   OUT CONSTANTS.TYREFCURSOR
)
IS
BEGIN
    PKERRORS.PUSH('CM_BCConsumosPorServSusc.Childs_ConsByProduct');

    OPEN OCUREFCURSOR FOR
        SELECT  COSSROWID                                                           PRIMARY_KEY,
                COSSSESU                                                            PRODUCTO,
                COSSPECS||' ('||REPLACE(TO_CHAR(PECSFECI,'dd-Month-yyyy'),' ','')
                ||'  /  '||REPLACE(TO_CHAR(PECSFECF,'dd-Month-yyyy'),' ','')||')'   PERIODO,
                ( SELECT TCONCODI||' - '||TCONDESC
                  FROM   TIPOCONS WHERE TCONCODI = COSSTCON )                       TIPOCONSUMO,
                COSSSUMA                                                            CONSUMO,
                COSSDIAS                                                            DIASCONSUMO,
                ( SELECT CAVCCODI ||' - '||CAVCDESC
                  FROM   CALIVACO WHERE CAVCCODI = COSSCAVC )                       CALIFICACION,
                ( SELECT COSSELME||' - '||ELMECODI
                  FROM   ELEMMEDI WHERE ELMEIDEM = COSSELME )                       ELEMENTO,
                COSSFUFA                                                            FUNCIONCALC,
                COSSMECC||' - '||MECCDESC                                           METODO,
                COSSFERE                                                            FECHAREGISTRO,
                COSSNVEC                                                            VECESESTIMADO,
                NVL(CALCFLLI,PKCONSTANTE.NO)                                        FLAGLIQUIDADO,
                COSSFUNC                                                            FUNCIONARIO,
                COSSSESU                                                            PARENT_ID
        FROM    VW_CMPRODCONSUMPTIONS
                /*+ CM_BCConsumosPorServSusc.Childs_ConsByProduct */
        WHERE   COSSSESU = INUPRODUCT
        ORDER BY PECSFECI DESC, COSSFERE DESC;


    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);

END CHILDS_CONSBYPRODUCT;






















PROCEDURE CHILD_DETAILPRODCONS
(
    ISBCONSROWID   IN   VARCHAR2,
    OCUREFCURSOR   OUT  PKCONSTANTE.TYREFCURSOR
)
IS
BEGIN
    PKERRORS.PUSH('CM_BCConsumosPorServSusc.Child_DetailProdCons');

    OPEN OCUREFCURSOR FOR
        WITH CONSUMOPRODUCTO
        AS
        (
            SELECT  COSSSESU    QUERY_PRODUCTO,
                    COSSPECS    QUERY_PERIODO,
                    COSSTCON    QUERY_TIPOCONSUMO
            FROM    CONSSESU
            WHERE   ROWID = ISBCONSROWID
        )
        SELECT  /*+ leading(ConsumoProducto)
                    use_nl_with_index(conssesu IX_CONSSESU03) */
                CONSSESU.ROWID                                 PRIMARY_ID,
                COSSCOCA                                       CONSUMO,
                ( SELECT CAVCCODI ||' - '||CAVCDESC
                  FROM   CALIVACO WHERE CAVCCODI = COSSCAVC )  CALIFICACION,
                ( SELECT COSSELME||' - '||ELMECODI
                  FROM   ELEMMEDI WHERE ELMEIDEM = COSSELME )  ELEMENTO,
                COSSFUFA                                       FUNCIONCALC,
                ( SELECT MECCCODI ||' - '||MECCDESC
                  FROM   MECACONS WHERE MECCCODI = COSSMECC )  METODO,
                COSSFERE                                       FECHAREGISTRO,
                COSSNVEC                                       VECESESTIMADO,
                COSSFLLI                                       FLAGLIQUIDADO,
                COSSFUNC                                       FUNCIONARIO,
                ISBCONSROWID                                   PARENT_ID
        FROM    CONSSESU,
                CONSUMOPRODUCTO
                /*+ CM_BCConsumosPorServSusc.Child_DetailProdCons */
        WHERE   COSSPECS = QUERY_PERIODO
        AND     COSSSESU = QUERY_PRODUCTO
        AND     COSSTCON = QUERY_TIPOCONSUMO
        ORDER BY COSSFERE ASC, COSSMECC ASC;


    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
        
END CHILD_DETAILPRODCONS;






















PROCEDURE QUERY_DETAILPRODCONS
(
    ISBCONSROWID   IN   VARCHAR2,
    OCUREFCURSOR   OUT  PKCONSTANTE.TYREFCURSOR
)
IS
BEGIN
    PKERRORS.PUSH('CM_BCConsumosPorServSusc.Query_DetailProdCons');

    OPEN OCUREFCURSOR FOR
        SELECT  ROWID                                          PRIMARY_ID,
                COSSCOCA                                       CONSUMO,
                ( SELECT CAVCCODI ||' - '||CAVCDESC
                  FROM   CALIVACO WHERE CAVCCODI = COSSCAVC )  CALIFICACION,
                ( SELECT COSSELME||' - '||ELMECODI
                  FROM   ELEMMEDI WHERE ELMEIDEM = COSSELME )  ELEMENTO,
                COSSFUFA                                       FUNCIONCALC,
                ( SELECT MECCCODI ||' - '||MECCDESC
                  FROM   MECACONS WHERE MECCCODI = COSSMECC )  METODO,
                COSSFERE                                       FECHAREGISTRO,
                COSSNVEC                                       VECESESTIMADO,
                COSSFLLI                                       FLAGLIQUIDADO,
                COSSFUNC                                       FUNCIONARIO,
                ISBCONSROWID                                   PARENT_ID
        FROM    CONSSESU
                /*+ CM_BCConsumosPorServSusc.Query_DetailProdCons */
        WHERE   ROWID = ISBCONSROWID;

    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
        
END QUERY_DETAILPRODCONS;






















PROCEDURE PARENT_DETAILPRODCONS
(
    INUCODROWID      IN      VARCHAR2,
    ONUPARENTCONS    OUT     VARCHAR2
)
IS
BEGIN
    PKERRORS.PUSH('CM_BCConsumosPorServSusc.Parent_DetailProdCons');

    ONUPARENTCONS := INUCODROWID;
    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);

END PARENT_DETAILPRODCONS;




































PROCEDURE QUERY_PRODCONSUMPINFO
(
    ISBCONSROWID   IN   VARCHAR2,
    OCUREFCURSOR   OUT  PKCONSTANTE.TYREFCURSOR
)
IS
    
    
    
    NUPRODUCT           CONSSESU.COSSSESU%TYPE;
    NUCONSUMPTIONTYPE   CONSSESU.COSSTCON%TYPE;
    NUCONSUMPTIONPERIOD CONSSESU.COSSPECS%TYPE;
    NUMEASELEMENT       CONSSESU.COSSELME%TYPE;

    
    
    
    CURSOR CUINITIALCONS
    IS
        SELECT  COSSSESU, COSSTCON, COSSPECS, COSSELME
        FROM    CONSSESU
        WHERE   ROWID = ISBCONSROWID;

BEGIN
    PKERRORS.PUSH('CM_BCConsumosPorServSusc.Query_ProdConsumpInfo');

    
    
    
    
    OPEN CUINITIALCONS;
    FETCH CUINITIALCONS
    INTO NUPRODUCT,NUCONSUMPTIONTYPE, NUCONSUMPTIONPERIOD,NUMEASELEMENT;
    CLOSE CUINITIALCONS;

    
    
    
    OPEN OCUREFCURSOR FOR
        WITH READINGSOURCE
        AS
        (
            SELECT  /*+ index(lectelme IX_LECTELME07) */
                    *
            FROM    LECTELME
            WHERE   LEEMSESU = NUPRODUCT
            AND     LEEMELME = NUMEASELEMENT
            AND     LEEMPECS = NUCONSUMPTIONPERIOD
            AND     LEEMTCON = NUCONSUMPTIONTYPE
            AND     ROWNUM = 1
        ),
        CHARGECONSSOURCE
        AS
        (
            SELECT  /*+ index(conssesu IX_CONSSESU03) */
                    *
            FROM    CONSSESU
            WHERE   COSSSESU = NUPRODUCT
            AND     COSSTCON = NUCONSUMPTIONTYPE
            AND     COSSPECS = NUCONSUMPTIONPERIOD
            AND     COSSCONS IS NOT NULL
            ORDER BY COSSFERE DESC
        )
        SELECT  COSSROWID                                               PRIMARY_ID,
                COSSPECS||'  ('||REPLACE(TO_CHAR(PECSFECI,'dd-Month-yyyy'),' ','')||
                 ' / '         ||REPLACE(TO_CHAR(PECSFECF,'dd-Month-yyyy'),' ','')||
                 ')'                                                    PERIODOCONSUMO,
                ( SELECT TCONCODI||' - '||TCONDESC
                  FROM   TIPOCONS WHERE TCONCODI = COSSTCON )           TIPOCONSUMO,
                ( SELECT COSSELME||' - '||ELMECODI
                  FROM   ELEMMEDI WHERE ELMEIDEM = COSSELME )           ELEMENTO,
                COSSSUMA                                                CONSUMO,
                COSSFUFA                                                FUNCIONCALC,
                COSSMECC||' - '||MECCDESC                               METODO,
                COSSDIAS                                                DIASCONSUMO,
                ( SELECT /*+ index(hicoprpm UX_HICOPRPM01) */
                         HCPPCOPR
                  FROM   HICOPRPM
                  WHERE  HCPPSESU = NUPRODUCT
                  AND    HCPPTICO = NUCONSUMPTIONTYPE
                  AND    HCPPPECO = NUCONSUMPTIONPERIOD )               CONSUMOPROMEDIO,
                ( SELECT /*+ index(perifact pk_perifact) */
                         COSSPEFA||' ('||PEFAMES||' - '||PEFAANO||')'
                  FROM   PERIFACT WHERE PEFACODI = COSSPEFA )           PERIODOFACTURACION,
                ( SELECT LEEMLETO
                  FROM   READINGSOURCE )                                LECTURATOMADA,
                ( SELECT REPLACE(TO_CHAR(LEEMFELE,'dd-Month-yyyy'),' ','')
                  FROM   READINGSOURCE )                                FECHALECTURA,
                ( SELECT /*+ leading(ChargeConsSource)
                             index(cargos IX_CARG_CODO) */
                         CARGCUCO
                  FROM   CHARGECONSSOURCE, CARGOS
                  WHERE  CARGCODO = CHARGECONSSOURCE.COSSCONS
                  AND    ROWNUM   = 1 )                                 CUENTACOBRO,
                COSSSESU                                                PARENT_ID
        FROM    VW_CMPRODCONSUMPTIONS
                /*+ CM_BCConsumosPorServSusc.Query_ProdConsumpInfo */
        WHERE   COSSSESU = NUPRODUCT
        AND     COSSTCON = NUCONSUMPTIONTYPE
        AND     COSSPECS = NUCONSUMPTIONPERIOD;

    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);

END QUERY_PRODCONSUMPINFO;




































PROCEDURE CHILDS_PRODCONSUMPINFO
(
    INUPRODUCT     IN   CONSSESU.COSSSESU%TYPE,
    OCUREFCURSOR   OUT  PKCONSTANTE.TYREFCURSOR
)
IS
BEGIN
    PKERRORS.PUSH('CM_BCConsumosPorServSusc.Childs_ProdConsumpInfo');

    OPEN OCUREFCURSOR FOR
        WITH CONSUMPTIONSOURCEDATA
        AS
        (
            SELECT  *
            FROM    VW_CMPRODCONSUMPTIONS
            WHERE   COSSSESU = INUPRODUCT
        ),
        READINGSOURCE
        AS
        (
            SELECT  /*+ leading(ConsumptionSourceData)
                        index(lectelme IX_LECTELME07) */
                    LECTELME.*
            FROM    CONSUMPTIONSOURCEDATA,
                    LECTELME
            WHERE   LEEMSESU = COSSSESU
            AND     LEEMELME = COSSELME
            AND     LEEMPECS = COSSPECS
            AND     LEEMTCON = COSSTCON
            ORDER BY LEEMFELE DESC
        ),
        CHARGECONSSOURCE
        AS
        (
            SELECT  /*+ leading(ConsumptionSourceData)
                        index(conssesu IX_CONSSESU03) */
                    CONSSESU.*
            FROM    CONSUMPTIONSOURCEDATA,
                    CONSSESU
            WHERE   CONSSESU.COSSSESU = CONSUMPTIONSOURCEDATA.COSSSESU
            AND     CONSSESU.COSSTCON = CONSUMPTIONSOURCEDATA.COSSTCON
            AND     CONSSESU.COSSPECS = CONSUMPTIONSOURCEDATA.COSSPECS
            AND     CONSSESU.COSSCONS IS NOT NULL
            ORDER BY CONSSESU.COSSFERE DESC
        )
        SELECT  COSSROWID                                               PRIMARY_ID,
                COSSPECS||'  ('||REPLACE(TO_CHAR(PECSFECI,'dd-Month-yyyy'),' ','')||
                 ' / '         ||REPLACE(TO_CHAR(PECSFECF,'dd-Month-yyyy'),' ','')||
                 ')'                                                    PERIODOCONSUMO,
                ( SELECT TCONCODI||' - '||TCONDESC
                  FROM   TIPOCONS WHERE TCONCODI = COSSTCON )           TIPOCONSUMO,
                ( SELECT COSSELME||' - '||ELMECODI
                  FROM   ELEMMEDI WHERE ELMEIDEM = COSSELME )           ELEMENTO,
                COSSSUMA                                                CONSUMO,
                COSSFUFA                                                FUNCIONCALC,
                COSSMECC||' - '||MECCDESC                               METODO,
                COSSDIAS                                                DIASCONSUMO,
                ( SELECT /*+ index(hicoprpm UX_HICOPRPM01) */
                         HCPPCOPR
                  FROM   HICOPRPM
                  WHERE  HCPPSESU = COSSSESU
                  AND    HCPPTICO = COSSTCON
                  AND    HCPPPECO = COSSPECS )                          CONSUMOPROMEDIO,
                ( SELECT /*+ index(perifact pk_perifact) */
                         COSSPEFA||' ('||PEFAMES||' - '||PEFAANO||')'
                  FROM   PERIFACT WHERE PEFACODI = COSSPEFA )           PERIODOFACTURACION,
                ( SELECT LEEMLETO
                  FROM   READINGSOURCE
                  WHERE  LEEMSESU = COSSSESU
                  AND    LEEMELME = COSSELME
                  AND    LEEMPECS = COSSPECS
                  AND    LEEMTCON = COSSTCON
                  AND ROWNUM = 1 )                                      LECTURATOMADA,
                ( SELECT REPLACE(TO_CHAR(LEEMFELE,'dd-Month-yyyy'),' ','')
                  FROM   READINGSOURCE
                  WHERE  LEEMSESU = COSSSESU
                  AND    LEEMELME = COSSELME
                  AND    LEEMPECS = COSSPECS
                  AND    LEEMTCON = COSSTCON
                  AND ROWNUM = 1 )                                      FECHALECTURA,
                ( SELECT /*+ leading(ChargeConsSource)
                             index(cargos IX_CARG_CODO) */
                         CARGCUCO
                  FROM   CHARGECONSSOURCE, CARGOS
                  WHERE  CHARGECONSSOURCE.COSSSESU = CONSUMPTIONSOURCEDATA.COSSSESU
                  AND    CHARGECONSSOURCE.COSSPECS = CONSUMPTIONSOURCEDATA.COSSPECS
                  AND    CHARGECONSSOURCE.COSSTCON = CONSUMPTIONSOURCEDATA.COSSTCON
                  AND    CARGCODO = CHARGECONSSOURCE.COSSCONS
                  AND    ROWNUM   = 1 )                                 CUENTACOBRO,
                COSSSESU                                                PARENT_ID
        FROM    CONSUMPTIONSOURCEDATA
                /*+ CM_BCConsumosPorServSusc.Childs_ProdConsumpInfo */
        ORDER BY PECSFECI DESC, COSSFERE DESC;

    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);

END CHILDS_PRODCONSUMPINFO;





























PROCEDURE PARENT_PRODCONSUMPINFO
(
    ISBCONSROWID   IN   VARCHAR2,
    ONUPRODUCT     OUT  CONSSESU.COSSSESU%TYPE
)
IS
BEGIN
    PKERRORS.PUSH('CM_BCConsumosPorServSusc.Parent_ProdConsumpInfo');

    SELECT  COSSSESU
    INTO    ONUPRODUCT
    FROM    CONSSESU
            /*+ CM_BCConsumosPorServSusc.Parent_ProdConsumpInfo */
    WHERE   ROWID = ISBCONSROWID;

    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);

END PARENT_PRODCONSUMPINFO;


END CM_BCCONSUMOSPORSERVSUSC;