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
