﻿WITH TABLA AS
(SELECT /*+ INDEX (PR IDX_PR_PRODUCT_05) INDEX (SU IDX_PR_PROD_SUSPENSION_01) */
 PR.PRODUCT_ID, 
 DI.ADDRESS_PARSED, DI.GEOGRAP_LOCATION_ID,
 PR.SUBSCRIPTION_ID, DI.SEGMENT_ID
FROM OPEN.PR_PRODUCT PR, OPEN.AB_ADDRESS DI
WHERE PR.ADDRESS_ID=DI.ADDRESS_ID
  AND PR.PRODUCT_TYPE_ID=7014
  AND DI.GEOGRAP_LOCATION_ID IN (:LOCALIDAD)
  AND PR.CATEGORY_ID IN (:CATEGORIA))
  
SELECT DE.GEOGRAP_LOCATION_ID ID_DEPARTAMENTO,
       DE.DESCRIPTION DESC_DEPARTAMENTO,
       LO.GEOGRAP_LOCATION_ID ID_LOCALIDAD,
       LO.DESCRIPTION DESC_LOCALIDAD,
       (select so.operating_sector_id||'-'||so.description
      from open.ab_segments se, open.or_operating_sector so
      where se.operating_sector_id=so.operating_sector_id
      and se.segments_id=tabla.SEGMENT_ID) Sector_operativo,
       TABLA.PRODUCT_ID PRODUCTO,
       OPEN.LDC_REPORTESCONSULTA.SubscriberName((SELECT SUSCCLIE FROM OPEN.SUSCRIPC WHERE SUSCCODI = TABLA.SUBSCRIPTION_ID)) NOMBRE,
       TABLA.ADDRESS_PARSED DIRECCION,
       (SELECT EL.ELMECODI FROM OPEN.ELEMMEDI EL, OPEN.ELMESESU MP WHERE EL.ELMEIDEM = MP.EMSSELME AND (MP.EMSSFERE IS NULL OR MP.EMSSFERE > SYSDATE) AND MP.EMSSSESU = TABLA.PRODUCT_ID AND ROWNUM = 1) MEDIDOR,
       (SELECT L.LEEMLETO FROM OPEN.LECTELME L, OPEN.PERIFACT PF WHERE L.LEEMSESU = TABLA.PRODUCT_ID AND LEEMCLEC = 'F' AND L.LEEMPEFA = PF.PEFACODI AND PF.PEFAANO = TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE,0),'YYYY')) AND PF.PEFAMES = TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE,0),'MM')) AND ROWNUM = 1) LECTURA_1,
       (SELECT L.LEEMLETO FROM OPEN.LECTELME L, OPEN.PERIFACT PF WHERE L.LEEMSESU = TABLA.PRODUCT_ID AND LEEMCLEC = 'F' AND L.LEEMPEFA = PF.PEFACODI AND PF.PEFAANO = TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE,-1),'YYYY')) AND PF.PEFAMES = TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE,-1),'MM')) AND ROWNUM = 1) LECTURA_2,
       (SELECT L.LEEMLETO FROM OPEN.LECTELME L, OPEN.PERIFACT PF WHERE L.LEEMSESU = TABLA.PRODUCT_ID AND LEEMCLEC = 'F' AND L.LEEMPEFA = PF.PEFACODI AND PF.PEFAANO = TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE,-2),'YYYY')) AND PF.PEFAMES = TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE,-2),'MM')) AND ROWNUM = 1) LECTURA_3,
       (SELECT L.LEEMLETO FROM OPEN.LECTELME L, OPEN.PERIFACT PF WHERE L.LEEMSESU = TABLA.PRODUCT_ID AND LEEMCLEC = 'F' AND L.LEEMPEFA = PF.PEFACODI AND PF.PEFAANO = TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE,-3),'YYYY')) AND PF.PEFAMES = TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE,-3),'MM')) AND ROWNUM = 1) LECTURA_4,
       (SELECT L.LEEMLETO FROM OPEN.LECTELME L, OPEN.PERIFACT PF WHERE L.LEEMSESU = TABLA.PRODUCT_ID AND LEEMCLEC = 'F' AND L.LEEMPEFA = PF.PEFACODI AND PF.PEFAANO = TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE,-4),'YYYY')) AND PF.PEFAMES = TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE,-4),'MM')) AND ROWNUM = 1) LECTURA_5,
       (SELECT L.LEEMLETO FROM OPEN.LECTELME L, OPEN.PERIFACT PF WHERE L.LEEMSESU = TABLA.PRODUCT_ID AND LEEMCLEC = 'F' AND L.LEEMPEFA = PF.PEFACODI AND PF.PEFAANO = TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE,-5),'YYYY')) AND PF.PEFAMES = TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE,-5),'MM')) AND ROWNUM = 1) LECTURA_6
FROM TABLA,  
     OPEN.GE_GEOGRA_LOCATION LO,
     OPEN.GE_GEOGRA_LOCATION DE
WHERE TABLA.GEOGRAP_LOCATION_ID=LO.GEOGRAP_LOCATION_ID
  AND LO.GEO_LOCA_FATHER_ID=DE.GEOGRAP_LOCATION_ID