---LDCRIPLI
SELECT IP.IPLIMEDE ELEMEN_MED,
       IP.IPLIFECH FCHA_MSTRA,
       IP.IPLIHORA HORA_MSTRA,
       IP.IPLIDIRE DIR_MSTRA,
       IP.IPLIBARR BARR_MSTRA,
       IP.IPLIESTA ESTACION,
       IP.IPLILOCA LOCAL_MSTRA,
       IP.IPLICONCE CONCENTRACION,
       IP.IPLIPRES PRESION,
       IP.IPLITIOD TIPO_ODO,
       IP.IPLIMETO METODO,
       IP.IPLIREGU REGULADOR,
       IP.IPLILECT LECT_MSTRA,
       IP.ORDER_ID,
       PP.PRODUCT_ID COD_PRODUCT,
       PP.PRODUCT_STATUS_ID || '-' || PS.DESCRIPTION ESTADO_PROD,
       AB.ADDRESS_PARSED DIR_PROD,
       GL2.DESCRIPTION BARRIO,
       GL1.DESCRIPTION LOCALIDAD,
       TO_NUMBER(LEC.LEEMLETO) LECTURA,
       OPEN.DACATEGORI.Fsbgetcatedesc(PP.CATEGORY_ID) CATEGORIA,
       IP.FLAG,
IP.UNIT_OPER,
IP.ORDER_ID,
trunc(IP.IPLIFECC) IPLIFECC
  FROM OPEN.LDC_IPLI_IO IP
 INNER JOIN OPEN.ELMESESU EM ON IP.IPLIMEDE = EM.EMSSCOEM
 INNER JOIN OPEN.SERVSUSC SS ON EM.EMSSSESU = SS.SESUNUSE
 INNER JOIN OPEN.SUSCRIPC SC ON SS.SESUSUSC = SC.SUSCCODI
 INNER JOIN OPEN.PR_PRODUCT PP ON SC.SUSCCODI = PP.SUBSCRIPTION_ID
 INNER JOIN OPEN.PS_PRODUCT_STATUS PS ON PP.PRODUCT_STATUS_ID = PS.PRODUCT_STATUS_ID
 INNER JOIN OPEN.AB_ADDRESS AB ON PP.ADDRESS_ID = AB.ADDRESS_ID
 INNER JOIN OPEN.GE_GEOGRA_LOCATION GL1 ON AB.GEOGRAP_LOCATION_ID = GL1.GEOGRAP_LOCATION_ID
 INNER JOIN OPEN.GE_GEOGRA_LOCATION GL2 ON AB.NEIGHBORTHOOD_ID = GL2.GEOGRAP_LOCATION_ID
 INNER JOIN (SELECT LEEMELME, LEEMLETO
               FROM OPEN.LECTELME A
              WHERE LEEMFELE = (SELECT MAX(LEEMFELE)
                                  FROM OPEN.LECTELME B
                                 WHERE A.LEEMELME = B.LEEMELME)) LEC ON EM.EMSSELME = LEC.LEEMELME
 WHERE (TRUNC(SYSDATE) BETWEEN EMSSFEIN AND EMSSFERE)
   AND PP.PRODUCT_TYPE_ID = 7014
   AND PP.PRODUCT_ID=50015405;

   
---IPLIOT 
SELECT IP.IPLIMEDE ELEMEN_MED,IP.IPLIFECH FCHA_MSTRA, IP.IPLIHORA HORA_MSTRA, IP.IPLIDIRE DIR_MSTRA,
                           IP.IPLIBARR BARR_MSTRA, IP.IPLIESTA ESTACION, PP.PRODUCT_ID COD_PRODUCT, PP.PRODUCT_STATUS_ID || ''-'' || PS.DESCRIPTION ESTADO_PROD,
                           AB.ADDRESS_PARSED DIR_PROD, GL2.DESCRIPTION BARRIO, GL1.DESCRIPTION LOCALIDAD, TO_NUMBER(LEC.LEEMLETO) LECTURA,
                           OPEN.DACATEGORI.Fsbgetcatedesc(PP.CATEGORY_ID) CATEGORIA,
                           IP.ORDER_ID
                      FROM OPEN.LDC_IPLI_IO IP
                     INNER JOIN OPEN.ELMESESU EM ON IP.IPLIMEDE = EM.EMSSCOEM
                     INNER JOIN OPEN.SERVSUSC SS ON EM.EMSSSESU = SS.SESUNUSE
                     INNER JOIN OPEN.SUSCRIPC SC ON SS.SESUSUSC = SC.SUSCCODI
                     INNER JOIN OPEN.PR_PRODUCT PP ON SC.SUSCCODI = PP.SUBSCRIPTION_ID
                     INNER JOIN OPEN.PS_PRODUCT_STATUS PS ON PP.PRODUCT_STATUS_ID = PS.PRODUCT_STATUS_ID
                     INNER JOIN OPEN.AB_ADDRESS AB ON PP.ADDRESS_ID = AB.ADDRESS_ID
                     INNER JOIN OPEN.GE_GEOGRA_LOCATION GL1 ON AB.GEOGRAP_LOCATION_ID = GL1.GEOGRAP_LOCATION_ID
                     INNER JOIN OPEN.GE_GEOGRA_LOCATION GL2 ON AB.NEIGHBORTHOOD_ID = GL2.GEOGRAP_LOCATION_ID
                     INNER JOIN (SELECT LEEMELME, LEEMLETO
                                   FROM OPEN.LECTELME A
                                  WHERE LEEMFELE = (SELECT MAX(LEEMFELE)
                                                      FROM OPEN.LECTELME B
                                                     WHERE A.LEEMELME = B.LEEMELME)) LEC ON EM.EMSSELME = LEC.LEEMELME
                     WHERE (TRUNC(SYSDATE) BETWEEN EMSSFEIN AND EMSSFERE)
                      AND PP.PRODUCT_TYPE_ID = 7014
                      --AND IP.ORDER_ID IS NULL
                       AND IP.UNIT_OPER   = 3093
                       AND PP.PRODUCT_ID=50015405;
--LDCUPIPLI                        
SELECT *
FROM OPEN.LDC_IPLI_IO 
WHERE (LDC_IPLI_IO.FLAG = 'N' OR  LDC_IPLI_IO.FLAG IS NULL)
  AND IPLIMEDE='H-7840766-S';
  
SELECT *
FROM OPEN.OR_ORDER_ACTIVITY
WHERE PRODUCT_ID=50015405
  AND TASK_TYPE_ID=12244;

SELECT ORDER_ID, OPERATING_UNIT_ID
FROM OPEN.OR_ORDER
WHERE ORDER_ID=28604625;