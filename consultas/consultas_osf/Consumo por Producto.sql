        WITH CONSUMPTIONSOURCEDATA
        AS
        (
            SELECT  *
            FROM    open.VW_CMPRODCONSUMPTIONS
            WHERE   COSSSESU = 50653529
        ),
        READINGSOURCE
        AS
        (
            SELECT  /*+ leading(ConsumptionSourceData)
                        index(lectelme IX_LECTELME07) */
                    LECTELME.*
            FROM    CONSUMPTIONSOURCEDATA,
                    open.LECTELME
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
                    open.CONSSESU
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
                  FROM   open.TIPOCONS WHERE TCONCODI = COSSTCON )           TIPOCONSUMO,
                ( SELECT COSSELME||' - '||ELMECODI
                  FROM   open.ELEMMEDI WHERE ELMEIDEM = COSSELME )           ELEMENTO,
                COSSSUMA                                                CONSUMO,
                COSSFUFA                                                FUNCIONCALC,
                COSSMECC||' - '||MECCDESC                               METODO,
                COSSDIAS                                                DIASCONSUMO,
                ( SELECT /*+ index(hicoprpm UX_HICOPRPM01) */
                         HCPPCOPR
                  FROM   open.HICOPRPM
                  WHERE  HCPPSESU = COSSSESU
                  AND    HCPPTICO = COSSTCON
                  AND    HCPPPECO = COSSPECS )                          CONSUMOPROMEDIO,
                ( SELECT /*+ index(perifact pk_perifact) */
                         COSSPEFA||' ('||PEFAMES||' - '||PEFAANO||')'
                  FROM   open.PERIFACT WHERE PEFACODI = COSSPEFA )           PERIODOFACTURACION,
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
                  FROM   open.CHARGECONSSOURCE, open.CARGOS
                  WHERE  CHARGECONSSOURCE.COSSSESU = CONSUMPTIONSOURCEDATA.COSSSESU
                  AND    CHARGECONSSOURCE.COSSPECS = CONSUMPTIONSOURCEDATA.COSSPECS
                  AND    CHARGECONSSOURCE.COSSTCON = CONSUMPTIONSOURCEDATA.COSSTCON
                  AND    CARGCODO = CHARGECONSSOURCE.COSSCONS
                  AND    ROWNUM   = 1 )                                 CUENTACOBRO,
                COSSSESU                                                PARENT_ID
        FROM    CONSUMPTIONSOURCEDATA
                /*+ CM_BCConsumosPorServSusc.Childs_ProdConsumpInfo */
        ORDER BY PECSFECI DESC, COSSFERE DESC;
