SELECT DISTINCT  I.ITEMS_ID, I.DESCRIPTION, /*PRICE, SALES_VALUE,*/ VALIDITY_START_dATE, VALIDITY_FINAL_DATE, 
CASE WHEN OPERATING_UNIT_ID IS NOT NULL THEN 'UO'
     WHEN GEOGRAP_LOCATION_ID IS NOT NULL THEN 'LO'
     WHEN CONTRACTOR_ID IS NOT NULL THEN 'CON'
     WHEN CONTRACT_ID IS NOT NULL THEN 'CO'
     ELSE 'GE' END TIPO,
     COUNT(DISTINCT PRICE)   
FROM OPEN.GE_LIST_UNITARY_COST C, OPEN.GE_UNIT_COST_ITE_LIS LI, OPEN.GE_ITEMS I
WHERE C.LIST_UNITARY_COST_ID=LI.LIST_UNITARY_COST_ID
  AND I.ITEMS_ID=LI.ITEMS_ID
  AND I.ITEM_CLASSIF_ID IN (3,8,21)
  AND VALIDITY_FINAL_DATE>=TRUNC(SYSDATE)
  AND VALIDITY_START_dATE<=TRUNC(SYSDATE)
  AND (GEOGRAP_LOCATION_ID !=8425 OR GEOGRAP_LOCATION_ID IS NULL)
GROUP BY I.ITEMS_ID, I.DESCRIPTION, /*PRICE, SALES_VALUE,*/ VALIDITY_START_dATE, VALIDITY_FINAL_DATE, 
CASE WHEN OPERATING_UNIT_ID IS NOT NULL THEN 'UO'
     WHEN GEOGRAP_LOCATION_ID IS NOT NULL THEN 'LO'
     WHEN CONTRACTOR_ID IS NOT NULL THEN 'CON'
     WHEN CONTRACT_ID IS NOT NULL THEN 'CO'
     ELSE 'GE' END
ORDER BY 5 DESC, 1 ;
     
     
 SELECT DISTINCT  I.ITEMS_ID, I.DESCRIPTION, PRICE, SALES_VALUE,C.DESCRIPTION,  VALIDITY_START_dATE, VALIDITY_FINAL_DATE, GEOGRAP_LOCATION_ID, 
CASE WHEN OPERATING_UNIT_ID IS NOT NULL THEN 'UO'
     WHEN GEOGRAP_LOCATION_ID IS NOT NULL THEN 'LO'
     WHEN CONTRACTOR_ID IS NOT NULL THEN 'CON'
     WHEN CONTRACT_ID IS NOT NULL THEN 'CO'
     ELSE 'GE' END TIPO
FROM OPEN.GE_LIST_UNITARY_COST C, OPEN.GE_UNIT_COST_ITE_LIS LI, OPEN.GE_ITEMS I
WHERE C.LIST_UNITARY_COST_ID=LI.LIST_UNITARY_COST_ID
  AND I.ITEMS_ID=LI.ITEMS_ID
  AND I.ITEM_CLASSIF_ID IN (3,8,21)
  AND VALIDITY_FINAL_DATE>=TRUNC(SYSDATE)
  AND VALIDITY_START_dATE<=TRUNC(SYSDATE)
  AND I.ITEMS_ID=10007788;
  
  
SELECT DISTINCT  I.ITEMS_ID, I.DESCRIPTION, PRICE, SALES_VALUE, VALIDITY_START_dATE, VALIDITY_FINAL_DATE, 
CASE WHEN OPERATING_UNIT_ID IS NOT NULL THEN 'UO'
     WHEN GEOGRAP_LOCATION_ID IS NOT NULL THEN 'LO'
     WHEN CONTRACTOR_ID IS NOT NULL THEN 'CON'
     WHEN CONTRACT_ID IS NOT NULL THEN 'CO'
     ELSE 'GE' END TIPO
FROM OPEN.GE_LIST_UNITARY_COST C, OPEN.GE_UNIT_COST_ITE_LIS LI, OPEN.GE_ITEMS I
WHERE C.LIST_UNITARY_COST_ID=LI.LIST_UNITARY_COST_ID
  AND I.ITEMS_ID=LI.ITEMS_ID
  AND I.ITEM_CLASSIF_ID IN (3,8,21)
  AND VALIDITY_FINAL_DATE>=TRUNC(SYSDATE)
  AND VALIDITY_START_dATE<=TRUNC(SYSDATE)
  AND (GEOGRAP_LOCATION_ID !=8425 OR GEOGRAP_LOCATION_ID IS NULL)
ORDER BY 7 DESC, 1 ;
     