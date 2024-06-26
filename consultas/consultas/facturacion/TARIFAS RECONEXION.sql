
SELECT  *
FROM    open.ta_conftaco
WHERE   ta_conftaco.cotcconc in (159);


SELECT *
FROM OPEN.TA_TARICOPR PR 
WHERE PR.TACPCOTC=566;

SELECT *
FROM OPEN.TA_VIGETACP VG, OPEN.TA_TARICOPR PR 
WHERE VITPTACP=PR.TACPCONS
 AND SYSDATE BETWEEN VG.VITPFEIN AND VG.VITPFEFI
 AND PR.TACPCOTC=566
 AND VITPESTA='P';

SELECT *
FROM OPEN.TA_TARICONC PR
WHERE TACOCOTC=566;
SELECT *
FROM OPEN.TA_VIGETACO R, OPEN.TA_TARICONC PR
WHERE R.VITCTACO=PR.TACOCONS 
  AND TACOCOTC=566
  AND SYSDATE BETWEEN R.VITCFEIN AND R.VITCFEFI;


SELECT *
FROM open.ta_confcrta, open.ta_deficrbt, OPEN.TA_DEFICRTA T, open.ta_conftaco c
WHERE decbcons = coctdecb 
  and coctdect=T.DECTCONS
  and c.cotcconc in (159)
  and c.cotcdect =COCTDECT
ORDER BY coctprio;




--<< Definicion de criterios de tarifas
SELECT A.COTCCONC AS CONCEPTO
      ,D.TACODESC AS DESCR
      ,B.COCTDECB AS CRITERIO
      ,C.DECBDESC AS DESCRIPCION
      ,B.COCTPRIO AS PRIORIDAD
      ,D.TACOCONS AS TARIFA_CONCEPTO
      ,D.TACOCR01 AS CRITERIO01
      ,D.TACOCR02 AS CRITERIO02
      ,D.TACOCR03 AS CRITERIO03
      ,D.TACOCR04 AS CRITERIO04
  FROM TA_CONFTACO A
      ,TA_CONFCRTA B
      ,TA_DEFICRBT C
      ,TA_TARICONC D
 WHERE A.COTCCONC = 169
   AND B.COCTDECT = A.COTCDECT
   AND C.DECBCONS = B.COCTDECB
   AND D.TACOCOTC = A.COTCCONS
 ORDER BY COCTPRIO
 ;
--<< Validación de vigencias de tarifas x concepto
SELECT VITCCONS AS ID_VIGENCIA
      ,VITCTACO AS TARIFA_CONCEPTO
      ,VITCFEIN AS VIGENCIA_INICIAL
      ,VITCFEFI AS VIGENCIA_FINAL
      ,VITCVIGE AS ACTIVA
      ,VITCVALO AS VALOR
      ,VITCPORC AS PORCENTAJE
      ,VITCPROG AS PROCESO
  FROM TA_VIGETACO
 WHERE VITCTACO IN (TARIFA_CONCEPTO)
   AND SYSDATE BETWEEN VITCFEIN AND VITCFEFI
 ORDER BY 1 DESC
 ;
--<< Validación de vigencias de rangos de tarifas x concepto
SELECT *
  FROM TA_RANGVITC
 WHERE RAVTVITC = ID_VIGENCIA;