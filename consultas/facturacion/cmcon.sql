
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
