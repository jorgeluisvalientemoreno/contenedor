WITH READINGS
AS
(
    SELECT  /*+ leading(lectelme)
                index(lectelme IX_LECTELME05)
                use_nl_with_index(pericose pk_pericose) materialize */
            LECTELME.*,
            PERICOSE.*,
            RANK() OVER ( PARTITION BY LEEMPECS ORDER BY LEEMCLEC ASC, LEEMFELE DESC ) MARCA_ 
    FROM    LECTELME,
            PERICOSE
    WHERE   LEEMSESU = 1110834 --INUPRODUCT                
    AND     LEEMTCON = 1 --INUCONSUMPTIONTYPE        
    AND     LEEMELME = 248453 --INUMEASUREELEMENT         
    AND     LEEMFELE < to_date('22/07/2024 09:39:15','dd/mm/yyyy hh24:mi:ss') --IDTREADINGDATE            
    AND     PECSCONS = LEEMPECS
    AND     LEEMCLEC IN ('F','I') 
),
CONSUMPTIONS
AS
(
    SELECT  *
    FROM    CONSSESU
    WHERE   COSSTCON = 1 --INUCONSUMPTIONTYPE        
    AND     COSSELME = 248453 --INUMEASUREELEMENT         
    AND     COSSSESU = 1110834 --INUPRODUCT                
    AND     COSSMECC NOT IN (4, 5, 2) --facturado, recuperado, corregido
),
FILTEREDDATA
AS
(
    SELECT  /*+ leading(Readings) index(Consumptions.conssesu IX_CONSSESU03) use_nl(Consumptions)*/
            *
    FROM    READINGS,
            CONSUMPTIONS
    WHERE   COSSPECS(+) = LEEMPECS
) --select * from filtereddata order by leemcons desc;
,
QUALIFIED_CONSUMPTIONS
AS
(
    SELECT  RANK() OVER ( PARTITION BY LEEMPECS, LEEMCLEC ORDER BY COSSFERE DESC, ROWNUM DESC ) LASTCONS,
            FILTEREDDATA.*
    FROM    FILTEREDDATA
) --select * from QUALIFIED_CONSUMPTIONS order by leemcons desc;
,
ANALIZED_READINGS
AS
(
    SELECT  QUALIFIED_CONSUMPTIONS.*,
            CASE
                
                
                
                WHEN ( LEEMCLEC =  'I' AND
                       LEEMLETO IS NOT NULL                         ) THEN
                    'S'
                
                
                
                
                WHEN ( COSSMECC != 3 AND --estimado
                       LEEMLETO IS NOT NULL                         ) THEN
                    'S'
                
                
                
                ELSE
                    'N'
            END VALIDREADINGFLAG
    FROM    QUALIFIED_CONSUMPTIONS
)
select leemsesu,leemlean,leemleto,leemfela,leemfele,leemdocu,leemcons,leemclec,cosspefa,leempefa,cosspecs,leempecs,cosscoca,cossmecc,cossflli,cossfere,cosscavc,cossfufa,pecsfeci,pecsfecf,marca_,VALIDREADINGFLAG
from ANALIZED_READINGS where lastcons = 1 order by leemcons desc;
